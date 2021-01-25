Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A45A3025BD
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Jan 2021 14:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbhAYNwD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 Jan 2021 08:52:03 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2412 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729112AbhAYNvf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Jan 2021 08:51:35 -0500
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DPWQH5Zvtz67gk8;
        Mon, 25 Jan 2021 21:47:35 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Mon, 25 Jan 2021 14:50:52 +0100
Received: from localhost (10.47.28.215) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Mon, 25 Jan
 2021 13:50:51 +0000
Date:   Mon, 25 Jan 2021 13:50:09 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
CC:     <joro@8bytes.org>, <will@kernel.org>, <lorenzo.pieralisi@arm.com>,
        <robh+dt@kernel.org>, <guohanjun@huawei.com>,
        <sudeep.holla@arm.com>, <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <robin.murphy@arm.com>, <eric.auger@redhat.com>,
        <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-accelerators@lists.ozlabs.org>, <baolu.lu@linux.intel.com>,
        <jacob.jun.pan@linux.intel.com>, <kevin.tian@intel.com>,
        <vdumpa@nvidia.com>, <zhangfei.gao@linaro.org>,
        <shameerali.kolothum.thodi@huawei.com>, <vivek.gautam@arm.com>
Subject: Re: [PATCH v11 10/10] iommu/arm-smmu-v3: Add stall support for
 platform devices
Message-ID: <20210125135009.00003ca3@Huawei.com>
In-Reply-To: <20210125110650.3232195-11-jean-philippe@linaro.org>
References: <20210125110650.3232195-1-jean-philippe@linaro.org>
        <20210125110650.3232195-11-jean-philippe@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.28.215]
X-ClientProxiedBy: lhreml705-chm.china.huawei.com (10.201.108.54) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 25 Jan 2021 12:06:51 +0100
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> The SMMU provides a Stall model for handling page faults in platform
> devices. It is similar to PCIe PRI, but doesn't require devices to have
> their own translation cache. Instead, faulting transactions are parked
> and the OS is given a chance to fix the page tables and retry the
> transaction.
> 
> Enable stall for devices that support it (opt-in by firmware). When an
> event corresponds to a translation error, call the IOMMU fault handler.
> If the fault is recoverable, it will call us back to terminate or
> continue the stall.
> 
> To use stall device drivers need to enable IOMMU_DEV_FEAT_IOPF, which
> initializes the fault queue for the device.
> 
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Hi Jean-Phillipe, 

Just one query below.  Either fix that or tell me why you don't need it and
then I'm happy.  With that resolved

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---

> git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index bb251cab61f3..ee66d1f4cb81 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -435,9 +435,13 @@ bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
>  	return true;
>  }
>  
> -static bool arm_smmu_iopf_supported(struct arm_smmu_master *master)
> +bool arm_smmu_master_iopf_supported(struct arm_smmu_master *master)
>  {
> -	return false;
> +	/* We're not keeping track of SIDs in fault events */
> +	if (master->num_streams != 1)
> +		return false;
> +
> +	return master->stall_enabled;
>  }
>  
>  bool arm_smmu_master_sva_supported(struct arm_smmu_master *master)
> @@ -445,8 +449,8 @@ bool arm_smmu_master_sva_supported(struct arm_smmu_master *master)
>  	if (!(master->smmu->features & ARM_SMMU_FEAT_SVA))
>  		return false;
>  
> -	/* SSID and IOPF support are mandatory for the moment */
> -	return master->ssid_bits && arm_smmu_iopf_supported(master);
> +	/* SSID support is mandatory for the moment */
> +	return master->ssid_bits;
>  }
>  
>  bool arm_smmu_master_sva_enabled(struct arm_smmu_master *master)
> @@ -459,13 +463,55 @@ bool arm_smmu_master_sva_enabled(struct arm_smmu_master *master)
>  	return enabled;
>  }
>  
> +static int arm_smmu_master_sva_enable_iopf(struct arm_smmu_master *master)
> +{
> +	int ret;
> +	struct device *dev = master->dev;
> +
> +	/*
> +	 * Drivers for devices supporting PRI or stall should enable IOPF first.
> +	 * Others have device-specific fault handlers and don't need IOPF.
> +	 */
> +	if (!arm_smmu_master_iopf_supported(master))

So if we have master->iopf_enabled and this happens. Then I'm not totally sure
what prevents the disable below running its cleanup on stuff that was never
configured.

> +		return 0;
> +
> +	if (!master->iopf_enabled)
> +		return -EINVAL;
> +
> +	ret = iopf_queue_add_device(master->smmu->evtq.iopf, dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = iommu_register_device_fault_handler(dev, iommu_queue_iopf, dev);
> +	if (ret) {
> +		iopf_queue_remove_device(master->smmu->evtq.iopf, dev);
> +		return ret;
> +	}
> +	return 0;
> +}
> +
> +static void arm_smmu_master_sva_disable_iopf(struct arm_smmu_master *master)
> +{
> +	struct device *dev = master->dev;
> +
> +	if (!master->iopf_enabled)
> +		return;

As above, I think you need a sanity check on

!arm_smmu_master_iopf_supported(master) before clearing the following.

I may well be missing something that stops us getting here though.

Alternative is probably to sanity check iopf_enabled = true is supported
before letting a driver set it.


> +
> +	iommu_unregister_device_fault_handler(dev);
> +	iopf_queue_remove_device(master->smmu->evtq.iopf, dev);
> +}
> +
>  int arm_smmu_master_enable_sva(struct arm_smmu_master *master)
>  {
> +	int ret;
> +
>  	mutex_lock(&sva_lock);
> -	master->sva_enabled = true;
> +	ret = arm_smmu_master_sva_enable_iopf(master);
> +	if (!ret)
> +		master->sva_enabled = true;
>  	mutex_unlock(&sva_lock);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  int arm_smmu_master_disable_sva(struct arm_smmu_master *master)
> @@ -476,6 +522,7 @@ int arm_smmu_master_disable_sva(struct arm_smmu_master *master)
>  		mutex_unlock(&sva_lock);
>  		return -EBUSY;
>  	}
> +	arm_smmu_master_sva_disable_iopf(master);
>  	master->sva_enabled = false;
>  	mutex_unlock(&sva_lock);
>  
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 3afec6ed8075..39a59d297c3c 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -32,6 +32,7 @@
>  #include <linux/amba/bus.h>
>  
>  #include "arm-smmu-v3.h"
> +#include "../../iommu-sva-lib.h"
>  
>  static bool disable_bypass = true;
>  module_param(disable_bypass, bool, 0444);
> @@ -315,6 +316,11 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
>  		}
>  		cmd[1] |= FIELD_PREP(CMDQ_PRI_1_RESP, ent->pri.resp);
>  		break;
> +	case CMDQ_OP_RESUME:
> +		cmd[0] |= FIELD_PREP(CMDQ_RESUME_0_SID, ent->resume.sid);
> +		cmd[0] |= FIELD_PREP(CMDQ_RESUME_0_RESP, ent->resume.resp);
> +		cmd[1] |= FIELD_PREP(CMDQ_RESUME_1_STAG, ent->resume.stag);
> +		break;
>  	case CMDQ_OP_CMD_SYNC:
>  		if (ent->sync.msiaddr) {
>  			cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_IRQ);
> @@ -878,6 +884,44 @@ static int arm_smmu_cmdq_batch_submit(struct arm_smmu_device *smmu,
>  	return arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmds, cmds->num, true);
>  }
>  
> +static int arm_smmu_page_response(struct device *dev,
> +				  struct iommu_fault_event *unused,
> +				  struct iommu_page_response *resp)
> +{
> +	struct arm_smmu_cmdq_ent cmd = {0};
> +	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> +	int sid = master->streams[0].id;
> +
> +	if (master->stall_enabled) {
> +		cmd.opcode		= CMDQ_OP_RESUME;
> +		cmd.resume.sid		= sid;
> +		cmd.resume.stag		= resp->grpid;
> +		switch (resp->code) {
> +		case IOMMU_PAGE_RESP_INVALID:
> +		case IOMMU_PAGE_RESP_FAILURE:
> +			cmd.resume.resp = CMDQ_RESUME_0_RESP_ABORT;
> +			break;
> +		case IOMMU_PAGE_RESP_SUCCESS:
> +			cmd.resume.resp = CMDQ_RESUME_0_RESP_RETRY;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +	} else {
> +		return -ENODEV;
> +	}
> +
> +	arm_smmu_cmdq_issue_cmd(master->smmu, &cmd);
> +	/*
> +	 * Don't send a SYNC, it doesn't do anything for RESUME or PRI_RESP.
> +	 * RESUME consumption guarantees that the stalled transaction will be
> +	 * terminated... at some point in the future. PRI_RESP is fire and
> +	 * forget.
> +	 */
> +
> +	return 0;
> +}
> +
>  /* Context descriptor manipulation functions */
>  void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid)
>  {
> @@ -988,7 +1032,6 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
>  	u64 val;
>  	bool cd_live;
>  	__le64 *cdptr;
> -	struct arm_smmu_device *smmu = smmu_domain->smmu;
>  
>  	if (WARN_ON(ssid >= (1 << smmu_domain->s1_cfg.s1cdmax)))
>  		return -E2BIG;
> @@ -1033,8 +1076,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
>  			FIELD_PREP(CTXDESC_CD_0_ASID, cd->asid) |
>  			CTXDESC_CD_0_V;
>  
> -		/* STALL_MODEL==0b10 && CD.S==0 is ILLEGAL */
> -		if (smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
> +		if (smmu_domain->stall_enabled)
>  			val |= CTXDESC_CD_0_S;
>  	}
>  
> @@ -1278,7 +1320,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
>  			 FIELD_PREP(STRTAB_STE_1_STRW, strw));
>  
>  		if (smmu->features & ARM_SMMU_FEAT_STALLS &&
> -		   !(smmu->features & ARM_SMMU_FEAT_STALL_FORCE))
> +		    !master->stall_enabled)
>  			dst[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
>  
>  		val |= (s1_cfg->cdcfg.cdtab_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
> @@ -1355,7 +1397,6 @@ static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
>  	return 0;
>  }
>  
> -__maybe_unused
>  static struct arm_smmu_master *
>  arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
>  {
> @@ -1382,9 +1423,96 @@ arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
>  }
>  
>  /* IRQ and event handlers */
> +static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
> +{
> +	int ret;
> +	u32 reason;
> +	u32 perm = 0;
> +	struct arm_smmu_master *master;
> +	bool ssid_valid = evt[0] & EVTQ_0_SSV;
> +	u32 sid = FIELD_GET(EVTQ_0_SID, evt[0]);
> +	struct iommu_fault_event fault_evt = { };
> +	struct iommu_fault *flt = &fault_evt.fault;
> +
> +	/* Stage-2 is always pinned at the moment */
> +	if (evt[1] & EVTQ_1_S2)
> +		return -EFAULT;
> +
> +	master = arm_smmu_find_master(smmu, sid);
> +	if (!master)
> +		return -EINVAL;
> +
> +	if (evt[1] & EVTQ_1_RnW)
> +		perm |= IOMMU_FAULT_PERM_READ;
> +	else
> +		perm |= IOMMU_FAULT_PERM_WRITE;
> +
> +	if (evt[1] & EVTQ_1_InD)
> +		perm |= IOMMU_FAULT_PERM_EXEC;
> +
> +	if (evt[1] & EVTQ_1_PnU)
> +		perm |= IOMMU_FAULT_PERM_PRIV;
> +
> +	switch (FIELD_GET(EVTQ_0_ID, evt[0])) {
> +	case EVT_ID_TRANSLATION_FAULT:
> +	case EVT_ID_ADDR_SIZE_FAULT:
> +	case EVT_ID_ACCESS_FAULT:
> +		reason = IOMMU_FAULT_REASON_PTE_FETCH;
> +		break;
> +	case EVT_ID_PERMISSION_FAULT:
> +		reason = IOMMU_FAULT_REASON_PERMISSION;
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (evt[1] & EVTQ_1_STALL) {
> +		flt->type = IOMMU_FAULT_PAGE_REQ;
> +		flt->prm = (struct iommu_fault_page_request) {
> +			.flags = IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE,
> +			.grpid = FIELD_GET(EVTQ_1_STAG, evt[1]),
> +			.perm = perm,
> +			.addr = FIELD_GET(EVTQ_2_ADDR, evt[2]),
> +		};
> +
> +		if (ssid_valid) {
> +			flt->prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
> +			flt->prm.pasid = FIELD_GET(EVTQ_0_SSID, evt[0]);
> +		}
> +	} else {
> +		flt->type = IOMMU_FAULT_DMA_UNRECOV;
> +		flt->event = (struct iommu_fault_unrecoverable) {
> +			.reason = reason,
> +			.flags = IOMMU_FAULT_UNRECOV_ADDR_VALID |
> +				 IOMMU_FAULT_UNRECOV_FETCH_ADDR_VALID,
> +			.perm = perm,
> +			.addr = FIELD_GET(EVTQ_2_ADDR, evt[2]),
> +			.fetch_addr = FIELD_GET(EVTQ_3_IPA, evt[3]),
> +		};
> +
> +		if (ssid_valid) {
> +			flt->event.flags |= IOMMU_FAULT_UNRECOV_PASID_VALID;
> +			flt->event.pasid = FIELD_GET(EVTQ_0_SSID, evt[0]);
> +		}
> +	}
> +
> +	ret = iommu_report_device_fault(master->dev, &fault_evt);
> +	if (ret && flt->type == IOMMU_FAULT_PAGE_REQ) {
> +		/* Nobody cared, abort the access */
> +		struct iommu_page_response resp = {
> +			.pasid		= flt->prm.pasid,
> +			.grpid		= flt->prm.grpid,
> +			.code		= IOMMU_PAGE_RESP_FAILURE,
> +		};
> +		arm_smmu_page_response(master->dev, &fault_evt, &resp);
> +	}
> +
> +	return ret;
> +}
> +
>  static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
>  {
> -	int i;
> +	int i, ret;
>  	struct arm_smmu_device *smmu = dev;
>  	struct arm_smmu_queue *q = &smmu->evtq.q;
>  	struct arm_smmu_ll_queue *llq = &q->llq;
> @@ -1394,6 +1522,10 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
>  		while (!queue_remove_raw(q, evt)) {
>  			u8 id = FIELD_GET(EVTQ_0_ID, evt[0]);
>  
> +			ret = arm_smmu_handle_evt(smmu, evt);
> +			if (!ret)
> +				continue;
> +
>  			dev_info(smmu->dev, "event 0x%02x received:\n", id);
>  			for (i = 0; i < ARRAY_SIZE(evt); ++i)
>  				dev_info(smmu->dev, "\t0x%016llx\n",
> @@ -1928,6 +2060,8 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
>  
>  	cfg->s1cdmax = master->ssid_bits;
>  
> +	smmu_domain->stall_enabled = master->stall_enabled;
> +
>  	ret = arm_smmu_alloc_cd_tables(smmu_domain);
>  	if (ret)
>  		goto out_free_asid;
> @@ -2275,6 +2409,12 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  			smmu_domain->s1_cfg.s1cdmax, master->ssid_bits);
>  		ret = -EINVAL;
>  		goto out_unlock;
> +	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
> +		   smmu_domain->stall_enabled != master->stall_enabled) {
> +		dev_err(dev, "cannot attach to stall-%s domain\n",
> +			smmu_domain->stall_enabled ? "enabled" : "disabled");
> +		ret = -EINVAL;
> +		goto out_unlock;
>  	}
>  
>  	master->domain = smmu_domain;
> @@ -2510,6 +2650,11 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
>  		master->ssid_bits = min_t(u8, master->ssid_bits,
>  					  CTXDESC_LINEAR_CDMAX);
>  
> +	if ((smmu->features & ARM_SMMU_FEAT_STALLS &&
> +	     device_property_read_bool(dev, "dma-can-stall")) ||
> +	    smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
> +		master->stall_enabled = true;
> +
>  	return &smmu->iommu;
>  
>  err_free_master:
> @@ -2527,7 +2672,8 @@ static void arm_smmu_release_device(struct device *dev)
>  		return;
>  
>  	master = dev_iommu_priv_get(dev);
> -	WARN_ON(arm_smmu_master_sva_enabled(master));
> +	if (WARN_ON(arm_smmu_master_sva_enabled(master)))
> +		iopf_queue_remove_device(master->smmu->evtq.iopf, dev);
>  	arm_smmu_detach_dev(master);
>  	arm_smmu_disable_pasid(master);
>  	arm_smmu_remove_master(master);
> @@ -2655,6 +2801,8 @@ static bool arm_smmu_dev_has_feature(struct device *dev,
>  		return false;
>  
>  	switch (feat) {
> +	case IOMMU_DEV_FEAT_IOPF:
> +		return arm_smmu_master_iopf_supported(master);
>  	case IOMMU_DEV_FEAT_SVA:
>  		return arm_smmu_master_sva_supported(master);
>  	default:
> @@ -2671,6 +2819,8 @@ static bool arm_smmu_dev_feature_enabled(struct device *dev,
>  		return false;
>  
>  	switch (feat) {
> +	case IOMMU_DEV_FEAT_IOPF:
> +		return master->iopf_enabled;
>  	case IOMMU_DEV_FEAT_SVA:
>  		return arm_smmu_master_sva_enabled(master);
>  	default:
> @@ -2681,6 +2831,8 @@ static bool arm_smmu_dev_feature_enabled(struct device *dev,
>  static int arm_smmu_dev_enable_feature(struct device *dev,
>  				       enum iommu_dev_features feat)
>  {
> +	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> +
>  	if (!arm_smmu_dev_has_feature(dev, feat))
>  		return -ENODEV;
>  
> @@ -2688,8 +2840,11 @@ static int arm_smmu_dev_enable_feature(struct device *dev,
>  		return -EBUSY;
>  
>  	switch (feat) {
> +	case IOMMU_DEV_FEAT_IOPF:
> +		master->iopf_enabled = true;
> +		return 0;
>  	case IOMMU_DEV_FEAT_SVA:
> -		return arm_smmu_master_enable_sva(dev_iommu_priv_get(dev));
> +		return arm_smmu_master_enable_sva(master);
>  	default:
>  		return -EINVAL;
>  	}
> @@ -2698,12 +2853,17 @@ static int arm_smmu_dev_enable_feature(struct device *dev,
>  static int arm_smmu_dev_disable_feature(struct device *dev,
>  					enum iommu_dev_features feat)
>  {
> +	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> +
>  	if (!arm_smmu_dev_feature_enabled(dev, feat))
>  		return -EINVAL;
>  
>  	switch (feat) {
> +	case IOMMU_DEV_FEAT_IOPF:
> +		master->iopf_enabled = false;
> +		return 0;
>  	case IOMMU_DEV_FEAT_SVA:
> -		return arm_smmu_master_disable_sva(dev_iommu_priv_get(dev));
> +		return arm_smmu_master_disable_sva(master);
>  	default:
>  		return -EINVAL;
>  	}
> @@ -2734,6 +2894,7 @@ static struct iommu_ops arm_smmu_ops = {
>  	.sva_bind		= arm_smmu_sva_bind,
>  	.sva_unbind		= arm_smmu_sva_unbind,
>  	.sva_get_pasid		= arm_smmu_sva_get_pasid,
> +	.page_response		= arm_smmu_page_response,
>  	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
>  };
>  
> @@ -2831,6 +2992,13 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
>  	if (ret)
>  		return ret;
>  
> +	if ((smmu->features & ARM_SMMU_FEAT_SVA) &&
> +	    (smmu->features & ARM_SMMU_FEAT_STALLS)) {
> +		smmu->evtq.iopf = iopf_queue_alloc(dev_name(smmu->dev));
> +		if (!smmu->evtq.iopf)
> +			return -ENOMEM;
> +	}
> +
>  	/* priq */
>  	if (!(smmu->features & ARM_SMMU_FEAT_PRI))
>  		return 0;
> @@ -3746,6 +3914,7 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
>  	iommu_device_unregister(&smmu->iommu);
>  	iommu_device_sysfs_remove(&smmu->iommu);
>  	arm_smmu_device_disable(smmu);
> +	iopf_queue_free(smmu->evtq.iopf);
>  
>  	return 0;
>  }

