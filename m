Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B463351C8C
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Apr 2021 20:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237003AbhDASSo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Apr 2021 14:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239180AbhDASPk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Apr 2021 14:15:40 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1090EC02D563
        for <linux-acpi@vger.kernel.org>; Thu,  1 Apr 2021 08:48:25 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j9so2277541wrx.12
        for <linux-acpi@vger.kernel.org>; Thu, 01 Apr 2021 08:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QWbwrrIJ1fiL7nCRFGWxit4rO1KKHkmsP8LK8g1YDAw=;
        b=cPyF/x1ILGeAQNd/1tRyThFZ85E9CUsMi7GTLqHeFDdUnr0h3EaFc8WA/fKwCn8iEL
         inP2qnTdLq4CBDMLsKUW4KLnQS9SnvQXRl2usejFKCXESlKaJJs7iZdVnLpD+D0K4YAf
         4WDld8WQYweLFgcbtYQ5zRiQJxbiM2f/GO4EsbFnwD9lc1UIFi/5QoBiBrjIvE0PyaTz
         bENwiBHbqdv6Xh6MOiULtqU3Ql9TIc6zE/XT0tyP94j76DNALQzUceeU7k/pFt4AplXO
         vpvqDq23U6jfuOEB9tbPWLF8BTvxF7RI+c3a0CvCg7kaI2ifoo2NFchZBIx+U/SyYXVH
         FqZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QWbwrrIJ1fiL7nCRFGWxit4rO1KKHkmsP8LK8g1YDAw=;
        b=HjT8Kwp63Tx6nFjs0gGgM+PjZ1kWwm5t3nfiJCKgvk3hTYznkIxlx1sbb9JtQBOli5
         7ynvxTB+KekGGoRKBx46yfM6X9MHnluZZIaiWdQkNwEn7ouHviHqmwJU4HWf0V91D2pb
         eTdjCl/IbhquR5V51czNshIRZFAqMEKksz0qYMuMD2Rx1+8YJKeDyeD3a6XRqqKa18Ex
         ZW4p0mEtl1deoRC67epwm6I4Dm76wjfophmQ2Q3+alFDLSds6zhCnykQqNxzyq8nezUT
         XcpOFUDdeSkDc9dCMTdOxSeSRcFNXfriYJL8xHtguZZrDX0cKCuY966sef+ilVjPRKvp
         PYTg==
X-Gm-Message-State: AOAM533j45U+9K/uToxgwrr1pwhMG+jyibRHFKUXhEsxSmPsiMvjucQk
        fY2YzlmhSmPyIm0kMJfs7RJOFQ==
X-Google-Smtp-Source: ABdhPJyj9YRXZPyMMaOclADKgMi87kxypG5GuzdW1Xkf5Lt0r4uREE4E/pJzTTgdiTfXz4DPvWRz0Q==
X-Received: by 2002:adf:e481:: with SMTP id i1mr10858931wrm.63.1617292103741;
        Thu, 01 Apr 2021 08:48:23 -0700 (PDT)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id y8sm8722505wmi.46.2021.04.01.08.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 08:48:23 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     joro@8bytes.org, will@kernel.org
Cc:     lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        guohanjun@huawei.com, sudeep.holla@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, robin.murphy@arm.com, Jonathan.Cameron@huawei.com,
        eric.auger@redhat.com, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-accelerators@lists.ozlabs.org, baolu.lu@linux.intel.com,
        jacob.jun.pan@linux.intel.com, kevin.tian@intel.com,
        vdumpa@nvidia.com, zhangfei.gao@linaro.org,
        shameerali.kolothum.thodi@huawei.com, vivek.gautam@arm.com,
        zhukeqian1@huawei.com, wangzhou1@hisilicon.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v14 10/10] iommu/arm-smmu-v3: Add stall support for platform devices
Date:   Thu,  1 Apr 2021 17:47:19 +0200
Message-Id: <20210401154718.307519-11-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210401154718.307519-1-jean-philippe@linaro.org>
References: <20210401154718.307519-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The SMMU provides a Stall model for handling page faults in platform
devices. It is similar to PCIe PRI, but doesn't require devices to have
their own translation cache. Instead, faulting transactions are parked
and the OS is given a chance to fix the page tables and retry the
transaction.

Enable stall for devices that support it (opt-in by firmware). When an
event corresponds to a translation error, call the IOMMU fault handler.
If the fault is recoverable, it will call us back to terminate or
continue the stall.

To use stall device drivers need to enable IOMMU_DEV_FEAT_IOPF, which
initializes the fault queue for the device.

Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  43 ++++
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  59 +++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 196 +++++++++++++++++-
 3 files changed, 283 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 1b463e27bca1..6ce1a7a7e44d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -354,6 +354,13 @@
 #define CMDQ_PRI_1_GRPID		GENMASK_ULL(8, 0)
 #define CMDQ_PRI_1_RESP			GENMASK_ULL(13, 12)
 
+#define CMDQ_RESUME_0_RESP_TERM		0UL
+#define CMDQ_RESUME_0_RESP_RETRY	1UL
+#define CMDQ_RESUME_0_RESP_ABORT	2UL
+#define CMDQ_RESUME_0_RESP		GENMASK_ULL(13, 12)
+#define CMDQ_RESUME_0_SID		GENMASK_ULL(63, 32)
+#define CMDQ_RESUME_1_STAG		GENMASK_ULL(15, 0)
+
 #define CMDQ_SYNC_0_CS			GENMASK_ULL(13, 12)
 #define CMDQ_SYNC_0_CS_NONE		0
 #define CMDQ_SYNC_0_CS_IRQ		1
@@ -370,6 +377,25 @@
 
 #define EVTQ_0_ID			GENMASK_ULL(7, 0)
 
+#define EVT_ID_TRANSLATION_FAULT	0x10
+#define EVT_ID_ADDR_SIZE_FAULT		0x11
+#define EVT_ID_ACCESS_FAULT		0x12
+#define EVT_ID_PERMISSION_FAULT		0x13
+
+#define EVTQ_0_SSV			(1UL << 11)
+#define EVTQ_0_SSID			GENMASK_ULL(31, 12)
+#define EVTQ_0_SID			GENMASK_ULL(63, 32)
+#define EVTQ_1_STAG			GENMASK_ULL(15, 0)
+#define EVTQ_1_STALL			(1UL << 31)
+#define EVTQ_1_PnU			(1UL << 33)
+#define EVTQ_1_InD			(1UL << 34)
+#define EVTQ_1_RnW			(1UL << 35)
+#define EVTQ_1_S2			(1UL << 39)
+#define EVTQ_1_CLASS			GENMASK_ULL(41, 40)
+#define EVTQ_1_TT_READ			(1UL << 44)
+#define EVTQ_2_ADDR			GENMASK_ULL(63, 0)
+#define EVTQ_3_IPA			GENMASK_ULL(51, 12)
+
 /* PRI queue */
 #define PRIQ_ENT_SZ_SHIFT		4
 #define PRIQ_ENT_DWORDS			((1 << PRIQ_ENT_SZ_SHIFT) >> 3)
@@ -464,6 +490,13 @@ struct arm_smmu_cmdq_ent {
 			enum pri_resp		resp;
 		} pri;
 
+		#define CMDQ_OP_RESUME		0x44
+		struct {
+			u32			sid;
+			u16			stag;
+			u8			resp;
+		} resume;
+
 		#define CMDQ_OP_CMD_SYNC	0x46
 		struct {
 			u64			msiaddr;
@@ -522,6 +555,7 @@ struct arm_smmu_cmdq_batch {
 
 struct arm_smmu_evtq {
 	struct arm_smmu_queue		q;
+	struct iopf_queue		*iopf;
 	u32				max_stalls;
 };
 
@@ -659,7 +693,9 @@ struct arm_smmu_master {
 	struct arm_smmu_stream		*streams;
 	unsigned int			num_streams;
 	bool				ats_enabled;
+	bool				stall_enabled;
 	bool				sva_enabled;
+	bool				iopf_enabled;
 	struct list_head		bonds;
 	unsigned int			ssid_bits;
 };
@@ -678,6 +714,7 @@ struct arm_smmu_domain {
 
 	struct io_pgtable_ops		*pgtbl_ops;
 	bool				non_strict;
+	bool				stall_enabled;
 	atomic_t			nr_ats_masters;
 
 	enum arm_smmu_domain_stage	stage;
@@ -719,6 +756,7 @@ bool arm_smmu_master_sva_supported(struct arm_smmu_master *master);
 bool arm_smmu_master_sva_enabled(struct arm_smmu_master *master);
 int arm_smmu_master_enable_sva(struct arm_smmu_master *master);
 int arm_smmu_master_disable_sva(struct arm_smmu_master *master);
+bool arm_smmu_master_iopf_supported(struct arm_smmu_master *master);
 struct iommu_sva *arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm,
 				    void *drvdata);
 void arm_smmu_sva_unbind(struct iommu_sva *handle);
@@ -750,6 +788,11 @@ static inline int arm_smmu_master_disable_sva(struct arm_smmu_master *master)
 	return -ENODEV;
 }
 
+static inline bool arm_smmu_master_iopf_supported(struct arm_smmu_master *master)
+{
+	return false;
+}
+
 static inline struct iommu_sva *
 arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm, void *drvdata)
 {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index bb251cab61f3..ee66d1f4cb81 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -435,9 +435,13 @@ bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
 	return true;
 }
 
-static bool arm_smmu_iopf_supported(struct arm_smmu_master *master)
+bool arm_smmu_master_iopf_supported(struct arm_smmu_master *master)
 {
-	return false;
+	/* We're not keeping track of SIDs in fault events */
+	if (master->num_streams != 1)
+		return false;
+
+	return master->stall_enabled;
 }
 
 bool arm_smmu_master_sva_supported(struct arm_smmu_master *master)
@@ -445,8 +449,8 @@ bool arm_smmu_master_sva_supported(struct arm_smmu_master *master)
 	if (!(master->smmu->features & ARM_SMMU_FEAT_SVA))
 		return false;
 
-	/* SSID and IOPF support are mandatory for the moment */
-	return master->ssid_bits && arm_smmu_iopf_supported(master);
+	/* SSID support is mandatory for the moment */
+	return master->ssid_bits;
 }
 
 bool arm_smmu_master_sva_enabled(struct arm_smmu_master *master)
@@ -459,13 +463,55 @@ bool arm_smmu_master_sva_enabled(struct arm_smmu_master *master)
 	return enabled;
 }
 
+static int arm_smmu_master_sva_enable_iopf(struct arm_smmu_master *master)
+{
+	int ret;
+	struct device *dev = master->dev;
+
+	/*
+	 * Drivers for devices supporting PRI or stall should enable IOPF first.
+	 * Others have device-specific fault handlers and don't need IOPF.
+	 */
+	if (!arm_smmu_master_iopf_supported(master))
+		return 0;
+
+	if (!master->iopf_enabled)
+		return -EINVAL;
+
+	ret = iopf_queue_add_device(master->smmu->evtq.iopf, dev);
+	if (ret)
+		return ret;
+
+	ret = iommu_register_device_fault_handler(dev, iommu_queue_iopf, dev);
+	if (ret) {
+		iopf_queue_remove_device(master->smmu->evtq.iopf, dev);
+		return ret;
+	}
+	return 0;
+}
+
+static void arm_smmu_master_sva_disable_iopf(struct arm_smmu_master *master)
+{
+	struct device *dev = master->dev;
+
+	if (!master->iopf_enabled)
+		return;
+
+	iommu_unregister_device_fault_handler(dev);
+	iopf_queue_remove_device(master->smmu->evtq.iopf, dev);
+}
+
 int arm_smmu_master_enable_sva(struct arm_smmu_master *master)
 {
+	int ret;
+
 	mutex_lock(&sva_lock);
-	master->sva_enabled = true;
+	ret = arm_smmu_master_sva_enable_iopf(master);
+	if (!ret)
+		master->sva_enabled = true;
 	mutex_unlock(&sva_lock);
 
-	return 0;
+	return ret;
 }
 
 int arm_smmu_master_disable_sva(struct arm_smmu_master *master)
@@ -476,6 +522,7 @@ int arm_smmu_master_disable_sva(struct arm_smmu_master *master)
 		mutex_unlock(&sva_lock);
 		return -EBUSY;
 	}
+	arm_smmu_master_sva_disable_iopf(master);
 	master->sva_enabled = false;
 	mutex_unlock(&sva_lock);
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 8279291660b2..85e103bf021d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -32,6 +32,7 @@
 #include <linux/amba/bus.h>
 
 #include "arm-smmu-v3.h"
+#include "../../iommu-sva-lib.h"
 
 static bool disable_bypass = true;
 module_param(disable_bypass, bool, 0444);
@@ -315,6 +316,11 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 		}
 		cmd[1] |= FIELD_PREP(CMDQ_PRI_1_RESP, ent->pri.resp);
 		break;
+	case CMDQ_OP_RESUME:
+		cmd[0] |= FIELD_PREP(CMDQ_RESUME_0_SID, ent->resume.sid);
+		cmd[0] |= FIELD_PREP(CMDQ_RESUME_0_RESP, ent->resume.resp);
+		cmd[1] |= FIELD_PREP(CMDQ_RESUME_1_STAG, ent->resume.stag);
+		break;
 	case CMDQ_OP_CMD_SYNC:
 		if (ent->sync.msiaddr) {
 			cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_IRQ);
@@ -878,6 +884,44 @@ static int arm_smmu_cmdq_batch_submit(struct arm_smmu_device *smmu,
 	return arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmds, cmds->num, true);
 }
 
+static int arm_smmu_page_response(struct device *dev,
+				  struct iommu_fault_event *unused,
+				  struct iommu_page_response *resp)
+{
+	struct arm_smmu_cmdq_ent cmd = {0};
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	int sid = master->streams[0].id;
+
+	if (master->stall_enabled) {
+		cmd.opcode		= CMDQ_OP_RESUME;
+		cmd.resume.sid		= sid;
+		cmd.resume.stag		= resp->grpid;
+		switch (resp->code) {
+		case IOMMU_PAGE_RESP_INVALID:
+		case IOMMU_PAGE_RESP_FAILURE:
+			cmd.resume.resp = CMDQ_RESUME_0_RESP_ABORT;
+			break;
+		case IOMMU_PAGE_RESP_SUCCESS:
+			cmd.resume.resp = CMDQ_RESUME_0_RESP_RETRY;
+			break;
+		default:
+			return -EINVAL;
+		}
+	} else {
+		return -ENODEV;
+	}
+
+	arm_smmu_cmdq_issue_cmd(master->smmu, &cmd);
+	/*
+	 * Don't send a SYNC, it doesn't do anything for RESUME or PRI_RESP.
+	 * RESUME consumption guarantees that the stalled transaction will be
+	 * terminated... at some point in the future. PRI_RESP is fire and
+	 * forget.
+	 */
+
+	return 0;
+}
+
 /* Context descriptor manipulation functions */
 void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid)
 {
@@ -988,7 +1032,6 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
 	u64 val;
 	bool cd_live;
 	__le64 *cdptr;
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
 
 	if (WARN_ON(ssid >= (1 << smmu_domain->s1_cfg.s1cdmax)))
 		return -E2BIG;
@@ -1033,8 +1076,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
 			FIELD_PREP(CTXDESC_CD_0_ASID, cd->asid) |
 			CTXDESC_CD_0_V;
 
-		/* STALL_MODEL==0b10 && CD.S==0 is ILLEGAL */
-		if (smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
+		if (smmu_domain->stall_enabled)
 			val |= CTXDESC_CD_0_S;
 	}
 
@@ -1278,7 +1320,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 			 FIELD_PREP(STRTAB_STE_1_STRW, strw));
 
 		if (smmu->features & ARM_SMMU_FEAT_STALLS &&
-		   !(smmu->features & ARM_SMMU_FEAT_STALL_FORCE))
+		    !master->stall_enabled)
 			dst[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
 
 		val |= (s1_cfg->cdcfg.cdtab_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
@@ -1355,7 +1397,6 @@ static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
 	return 0;
 }
 
-__maybe_unused
 static struct arm_smmu_master *
 arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
 {
@@ -1379,9 +1420,103 @@ arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
 }
 
 /* IRQ and event handlers */
+static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
+{
+	int ret;
+	u32 reason;
+	u32 perm = 0;
+	struct arm_smmu_master *master;
+	bool ssid_valid = evt[0] & EVTQ_0_SSV;
+	u32 sid = FIELD_GET(EVTQ_0_SID, evt[0]);
+	struct iommu_fault_event fault_evt = { };
+	struct iommu_fault *flt = &fault_evt.fault;
+
+	switch (FIELD_GET(EVTQ_0_ID, evt[0])) {
+	case EVT_ID_TRANSLATION_FAULT:
+		reason = IOMMU_FAULT_REASON_PTE_FETCH;
+		break;
+	case EVT_ID_ADDR_SIZE_FAULT:
+		reason = IOMMU_FAULT_REASON_OOR_ADDRESS;
+		break;
+	case EVT_ID_ACCESS_FAULT:
+		reason = IOMMU_FAULT_REASON_ACCESS;
+		break;
+	case EVT_ID_PERMISSION_FAULT:
+		reason = IOMMU_FAULT_REASON_PERMISSION;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	/* Stage-2 is always pinned at the moment */
+	if (evt[1] & EVTQ_1_S2)
+		return -EFAULT;
+
+	if (evt[1] & EVTQ_1_RnW)
+		perm |= IOMMU_FAULT_PERM_READ;
+	else
+		perm |= IOMMU_FAULT_PERM_WRITE;
+
+	if (evt[1] & EVTQ_1_InD)
+		perm |= IOMMU_FAULT_PERM_EXEC;
+
+	if (evt[1] & EVTQ_1_PnU)
+		perm |= IOMMU_FAULT_PERM_PRIV;
+
+	if (evt[1] & EVTQ_1_STALL) {
+		flt->type = IOMMU_FAULT_PAGE_REQ;
+		flt->prm = (struct iommu_fault_page_request) {
+			.flags = IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE,
+			.grpid = FIELD_GET(EVTQ_1_STAG, evt[1]),
+			.perm = perm,
+			.addr = FIELD_GET(EVTQ_2_ADDR, evt[2]),
+		};
+
+		if (ssid_valid) {
+			flt->prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
+			flt->prm.pasid = FIELD_GET(EVTQ_0_SSID, evt[0]);
+		}
+	} else {
+		flt->type = IOMMU_FAULT_DMA_UNRECOV;
+		flt->event = (struct iommu_fault_unrecoverable) {
+			.reason = reason,
+			.flags = IOMMU_FAULT_UNRECOV_ADDR_VALID,
+			.perm = perm,
+			.addr = FIELD_GET(EVTQ_2_ADDR, evt[2]),
+		};
+
+		if (ssid_valid) {
+			flt->event.flags |= IOMMU_FAULT_UNRECOV_PASID_VALID;
+			flt->event.pasid = FIELD_GET(EVTQ_0_SSID, evt[0]);
+		}
+	}
+
+	mutex_lock(&smmu->streams_mutex);
+	master = arm_smmu_find_master(smmu, sid);
+	if (!master) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	ret = iommu_report_device_fault(master->dev, &fault_evt);
+	if (ret && flt->type == IOMMU_FAULT_PAGE_REQ) {
+		/* Nobody cared, abort the access */
+		struct iommu_page_response resp = {
+			.pasid		= flt->prm.pasid,
+			.grpid		= flt->prm.grpid,
+			.code		= IOMMU_PAGE_RESP_FAILURE,
+		};
+		arm_smmu_page_response(master->dev, &fault_evt, &resp);
+	}
+
+out_unlock:
+	mutex_unlock(&smmu->streams_mutex);
+	return ret;
+}
+
 static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 {
-	int i;
+	int i, ret;
 	struct arm_smmu_device *smmu = dev;
 	struct arm_smmu_queue *q = &smmu->evtq.q;
 	struct arm_smmu_ll_queue *llq = &q->llq;
@@ -1391,6 +1526,10 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 		while (!queue_remove_raw(q, evt)) {
 			u8 id = FIELD_GET(EVTQ_0_ID, evt[0]);
 
+			ret = arm_smmu_handle_evt(smmu, evt);
+			if (!ret)
+				continue;
+
 			dev_info(smmu->dev, "event 0x%02x received:\n", id);
 			for (i = 0; i < ARRAY_SIZE(evt); ++i)
 				dev_info(smmu->dev, "\t0x%016llx\n",
@@ -1925,6 +2064,8 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 
 	cfg->s1cdmax = master->ssid_bits;
 
+	smmu_domain->stall_enabled = master->stall_enabled;
+
 	ret = arm_smmu_alloc_cd_tables(smmu_domain);
 	if (ret)
 		goto out_free_asid;
@@ -2272,6 +2413,12 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 			smmu_domain->s1_cfg.s1cdmax, master->ssid_bits);
 		ret = -EINVAL;
 		goto out_unlock;
+	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
+		   smmu_domain->stall_enabled != master->stall_enabled) {
+		dev_err(dev, "cannot attach to stall-%s domain\n",
+			smmu_domain->stall_enabled ? "enabled" : "disabled");
+		ret = -EINVAL;
+		goto out_unlock;
 	}
 
 	master->domain = smmu_domain;
@@ -2510,6 +2657,11 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 		master->ssid_bits = min_t(u8, master->ssid_bits,
 					  CTXDESC_LINEAR_CDMAX);
 
+	if ((smmu->features & ARM_SMMU_FEAT_STALLS &&
+	     device_property_read_bool(dev, "dma-can-stall")) ||
+	    smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
+		master->stall_enabled = true;
+
 	return &smmu->iommu;
 
 err_free_master:
@@ -2527,7 +2679,8 @@ static void arm_smmu_release_device(struct device *dev)
 		return;
 
 	master = dev_iommu_priv_get(dev);
-	WARN_ON(arm_smmu_master_sva_enabled(master));
+	if (WARN_ON(arm_smmu_master_sva_enabled(master)))
+		iopf_queue_remove_device(master->smmu->evtq.iopf, dev);
 	arm_smmu_detach_dev(master);
 	arm_smmu_disable_pasid(master);
 	arm_smmu_remove_master(master);
@@ -2655,6 +2808,8 @@ static bool arm_smmu_dev_has_feature(struct device *dev,
 		return false;
 
 	switch (feat) {
+	case IOMMU_DEV_FEAT_IOPF:
+		return arm_smmu_master_iopf_supported(master);
 	case IOMMU_DEV_FEAT_SVA:
 		return arm_smmu_master_sva_supported(master);
 	default:
@@ -2671,6 +2826,8 @@ static bool arm_smmu_dev_feature_enabled(struct device *dev,
 		return false;
 
 	switch (feat) {
+	case IOMMU_DEV_FEAT_IOPF:
+		return master->iopf_enabled;
 	case IOMMU_DEV_FEAT_SVA:
 		return arm_smmu_master_sva_enabled(master);
 	default:
@@ -2681,6 +2838,8 @@ static bool arm_smmu_dev_feature_enabled(struct device *dev,
 static int arm_smmu_dev_enable_feature(struct device *dev,
 				       enum iommu_dev_features feat)
 {
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+
 	if (!arm_smmu_dev_has_feature(dev, feat))
 		return -ENODEV;
 
@@ -2688,8 +2847,11 @@ static int arm_smmu_dev_enable_feature(struct device *dev,
 		return -EBUSY;
 
 	switch (feat) {
+	case IOMMU_DEV_FEAT_IOPF:
+		master->iopf_enabled = true;
+		return 0;
 	case IOMMU_DEV_FEAT_SVA:
-		return arm_smmu_master_enable_sva(dev_iommu_priv_get(dev));
+		return arm_smmu_master_enable_sva(master);
 	default:
 		return -EINVAL;
 	}
@@ -2698,12 +2860,19 @@ static int arm_smmu_dev_enable_feature(struct device *dev,
 static int arm_smmu_dev_disable_feature(struct device *dev,
 					enum iommu_dev_features feat)
 {
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+
 	if (!arm_smmu_dev_feature_enabled(dev, feat))
 		return -EINVAL;
 
 	switch (feat) {
+	case IOMMU_DEV_FEAT_IOPF:
+		if (master->sva_enabled)
+			return -EBUSY;
+		master->iopf_enabled = false;
+		return 0;
 	case IOMMU_DEV_FEAT_SVA:
-		return arm_smmu_master_disable_sva(dev_iommu_priv_get(dev));
+		return arm_smmu_master_disable_sva(master);
 	default:
 		return -EINVAL;
 	}
@@ -2734,6 +2903,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.sva_bind		= arm_smmu_sva_bind,
 	.sva_unbind		= arm_smmu_sva_unbind,
 	.sva_get_pasid		= arm_smmu_sva_get_pasid,
+	.page_response		= arm_smmu_page_response,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
 };
 
@@ -2831,6 +3001,13 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
 	if (ret)
 		return ret;
 
+	if ((smmu->features & ARM_SMMU_FEAT_SVA) &&
+	    (smmu->features & ARM_SMMU_FEAT_STALLS)) {
+		smmu->evtq.iopf = iopf_queue_alloc(dev_name(smmu->dev));
+		if (!smmu->evtq.iopf)
+			return -ENOMEM;
+	}
+
 	/* priq */
 	if (!(smmu->features & ARM_SMMU_FEAT_PRI))
 		return 0;
@@ -3746,6 +3923,7 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 	iommu_device_unregister(&smmu->iommu);
 	iommu_device_sysfs_remove(&smmu->iommu);
 	arm_smmu_device_disable(smmu);
+	iopf_queue_free(smmu->evtq.iopf);
 
 	return 0;
 }
-- 
2.31.1

