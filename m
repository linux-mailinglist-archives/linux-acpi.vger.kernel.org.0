Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5040432B440
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Mar 2021 06:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236879AbhCCEzX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Mar 2021 23:55:23 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12671 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1578142AbhCBNOe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Mar 2021 08:14:34 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Dqbq64ZTxzlQx8;
        Tue,  2 Mar 2021 20:22:10 +0800 (CST)
Received: from [10.174.184.42] (10.174.184.42) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Tue, 2 Mar 2021 20:24:06 +0800
Subject: Re: [PATCH v13 07/10] iommu/arm-smmu-v3: Maintain a SID->device
 structure
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        <joro@8bytes.org>, <will@kernel.org>
References: <20210302092644.2553014-1-jean-philippe@linaro.org>
 <20210302092644.2553014-8-jean-philippe@linaro.org>
CC:     <lorenzo.pieralisi@arm.com>, <robh+dt@kernel.org>,
        <guohanjun@huawei.com>, <sudeep.holla@arm.com>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>, <robin.murphy@arm.com>,
        <Jonathan.Cameron@huawei.com>, <eric.auger@redhat.com>,
        <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-accelerators@lists.ozlabs.org>, <baolu.lu@linux.intel.com>,
        <jacob.jun.pan@linux.intel.com>, <kevin.tian@intel.com>,
        <vdumpa@nvidia.com>, <zhangfei.gao@linaro.org>,
        <shameerali.kolothum.thodi@huawei.com>, <vivek.gautam@arm.com>,
        <wangzhou1@hisilicon.com>
From:   Keqian Zhu <zhukeqian1@huawei.com>
Message-ID: <b683c66f-68e7-4174-74a5-2ea7c44f54ac@huawei.com>
Date:   Tue, 2 Mar 2021 20:24:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20210302092644.2553014-8-jean-philippe@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.184.42]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Jean,

Reviewed-by: Keqian Zhu <zhukeqian1@huawei.com>

On 2021/3/2 17:26, Jean-Philippe Brucker wrote:
> When handling faults from the event or PRI queue, we need to find the
> struct device associated with a SID. Add a rb_tree to keep track of
> SIDs.
> 
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  13 +-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 157 ++++++++++++++++----
>  2 files changed, 140 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index f985817c967a..7b15b7580c6e 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -639,6 +639,15 @@ struct arm_smmu_device {
>  
>  	/* IOMMU core code handle */
>  	struct iommu_device		iommu;
> +
> +	struct rb_root			streams;
> +	struct mutex			streams_mutex;
> +};
> +
> +struct arm_smmu_stream {
> +	u32				id;
> +	struct arm_smmu_master		*master;
> +	struct rb_node			node;
>  };
>  
>  /* SMMU private data for each master */
> @@ -647,8 +656,8 @@ struct arm_smmu_master {
>  	struct device			*dev;
>  	struct arm_smmu_domain		*domain;
>  	struct list_head		domain_head;
> -	u32				*sids;
> -	unsigned int			num_sids;
> +	struct arm_smmu_stream		*streams;
> +	unsigned int			num_streams;
>  	bool				ats_enabled;
>  	bool				sva_enabled;
>  	struct list_head		bonds;
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 7edce914c45e..d148bb6d4289 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -909,8 +909,8 @@ static void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain,
>  
>  	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
>  	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
> -		for (i = 0; i < master->num_sids; i++) {
> -			cmd.cfgi.sid = master->sids[i];
> +		for (i = 0; i < master->num_streams; i++) {
> +			cmd.cfgi.sid = master->streams[i].id;
>  			arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
>  		}
>  	}
> @@ -1355,6 +1355,28 @@ static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
>  	return 0;
>  }
>  
> +/* smmu->streams_mutex must be held */
> +__maybe_unused
> +static struct arm_smmu_master *
> +arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
> +{
> +	struct rb_node *node;
> +	struct arm_smmu_stream *stream;
> +
> +	node = smmu->streams.rb_node;
> +	while (node) {
> +		stream = rb_entry(node, struct arm_smmu_stream, node);
> +		if (stream->id < sid)
> +			node = node->rb_right;
> +		else if (stream->id > sid)
> +			node = node->rb_left;
> +		else
> +			return stream->master;
> +	}
> +
> +	return NULL;
> +}
> +
>  /* IRQ and event handlers */
>  static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
>  {
> @@ -1588,8 +1610,8 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master)
>  
>  	arm_smmu_atc_inv_to_cmd(0, 0, 0, &cmd);
>  
> -	for (i = 0; i < master->num_sids; i++) {
> -		cmd.atc.sid = master->sids[i];
> +	for (i = 0; i < master->num_streams; i++) {
> +		cmd.atc.sid = master->streams[i].id;
>  		arm_smmu_cmdq_issue_cmd(master->smmu, &cmd);
>  	}
>  
> @@ -1632,8 +1654,8 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
>  		if (!master->ats_enabled)
>  			continue;
>  
> -		for (i = 0; i < master->num_sids; i++) {
> -			cmd.atc.sid = master->sids[i];
> +		for (i = 0; i < master->num_streams; i++) {
> +			cmd.atc.sid = master->streams[i].id;
>  			arm_smmu_cmdq_batch_add(smmu_domain->smmu, &cmds, &cmd);
>  		}
>  	}
> @@ -2065,13 +2087,13 @@ static void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master)
>  	int i, j;
>  	struct arm_smmu_device *smmu = master->smmu;
>  
> -	for (i = 0; i < master->num_sids; ++i) {
> -		u32 sid = master->sids[i];
> +	for (i = 0; i < master->num_streams; ++i) {
> +		u32 sid = master->streams[i].id;
>  		__le64 *step = arm_smmu_get_step_for_sid(smmu, sid);
>  
>  		/* Bridged PCI devices may end up with duplicated IDs */
>  		for (j = 0; j < i; j++)
> -			if (master->sids[j] == sid)
> +			if (master->streams[j].id == sid)
>  				break;
>  		if (j < i)
>  			continue;
> @@ -2345,11 +2367,101 @@ static bool arm_smmu_sid_in_range(struct arm_smmu_device *smmu, u32 sid)
>  	return sid < limit;
>  }
>  
> +static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
> +				  struct arm_smmu_master *master)
> +{
> +	int i;
> +	int ret = 0;
> +	struct arm_smmu_stream *new_stream, *cur_stream;
> +	struct rb_node **new_node, *parent_node = NULL;
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
> +
> +	master->streams = kcalloc(fwspec->num_ids, sizeof(*master->streams),
> +				  GFP_KERNEL);
> +	if (!master->streams)
> +		return -ENOMEM;
> +	master->num_streams = fwspec->num_ids;
> +
> +	mutex_lock(&smmu->streams_mutex);
> +	for (i = 0; i < fwspec->num_ids; i++) {
> +		u32 sid = fwspec->ids[i];
> +
> +		new_stream = &master->streams[i];
> +		new_stream->id = sid;
> +		new_stream->master = master;
> +
> +		/*
> +		 * Check the SIDs are in range of the SMMU and our stream table
> +		 */
> +		if (!arm_smmu_sid_in_range(smmu, sid)) {
> +			ret = -ERANGE;
> +			break;
> +		}
> +
> +		/* Ensure l2 strtab is initialised */
> +		if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
> +			ret = arm_smmu_init_l2_strtab(smmu, sid);
> +			if (ret)
> +				break;
> +		}
> +
> +		/* Insert into SID tree */
> +		new_node = &(smmu->streams.rb_node);
> +		while (*new_node) {
> +			cur_stream = rb_entry(*new_node, struct arm_smmu_stream,
> +					      node);
> +			parent_node = *new_node;
> +			if (cur_stream->id > new_stream->id) {
> +				new_node = &((*new_node)->rb_left);
> +			} else if (cur_stream->id < new_stream->id) {
> +				new_node = &((*new_node)->rb_right);
> +			} else {
> +				dev_warn(master->dev,
> +					 "stream %u already in tree\n",
> +					 cur_stream->id);
> +				ret = -EINVAL;
> +				break;
> +			}
> +		}
> +		if (ret)
> +			break;
> +
> +		rb_link_node(&new_stream->node, parent_node, new_node);
> +		rb_insert_color(&new_stream->node, &smmu->streams);
> +	}
> +
> +	if (ret) {
> +		for (i--; i >= 0; i--)
> +			rb_erase(&master->streams[i].node, &smmu->streams);
> +		kfree(master->streams);
> +	}
> +	mutex_unlock(&smmu->streams_mutex);
> +
> +	return ret;
> +}
> +
> +static void arm_smmu_remove_master(struct arm_smmu_master *master)
> +{
> +	int i;
> +	struct arm_smmu_device *smmu = master->smmu;
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
> +
> +	if (!smmu || !master->streams)
> +		return;
> +
> +	mutex_lock(&smmu->streams_mutex);
> +	for (i = 0; i < fwspec->num_ids; i++)
> +		rb_erase(&master->streams[i].node, &smmu->streams);
> +	mutex_unlock(&smmu->streams_mutex);
> +
> +	kfree(master->streams);
> +}
> +
>  static struct iommu_ops arm_smmu_ops;
>  
>  static struct iommu_device *arm_smmu_probe_device(struct device *dev)
>  {
> -	int i, ret;
> +	int ret;
>  	struct arm_smmu_device *smmu;
>  	struct arm_smmu_master *master;
>  	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> @@ -2370,27 +2482,12 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
>  
>  	master->dev = dev;
>  	master->smmu = smmu;
> -	master->sids = fwspec->ids;
> -	master->num_sids = fwspec->num_ids;
>  	INIT_LIST_HEAD(&master->bonds);
>  	dev_iommu_priv_set(dev, master);
>  
> -	/* Check the SIDs are in range of the SMMU and our stream table */
> -	for (i = 0; i < master->num_sids; i++) {
> -		u32 sid = master->sids[i];
> -
> -		if (!arm_smmu_sid_in_range(smmu, sid)) {
> -			ret = -ERANGE;
> -			goto err_free_master;
> -		}
> -
> -		/* Ensure l2 strtab is initialised */
> -		if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
> -			ret = arm_smmu_init_l2_strtab(smmu, sid);
> -			if (ret)
> -				goto err_free_master;
> -		}
> -	}
> +	ret = arm_smmu_insert_master(smmu, master);
> +	if (ret)
> +		goto err_free_master;
>  
>  	device_property_read_u32(dev, "pasid-num-bits", &master->ssid_bits);
>  	master->ssid_bits = min(smmu->ssid_bits, master->ssid_bits);
> @@ -2429,6 +2526,7 @@ static void arm_smmu_release_device(struct device *dev)
>  	WARN_ON(arm_smmu_master_sva_enabled(master));
>  	arm_smmu_detach_dev(master);
>  	arm_smmu_disable_pasid(master);
> +	arm_smmu_remove_master(master);
>  	kfree(master);
>  	iommu_fwspec_free(dev);
>  }
> @@ -2852,6 +2950,9 @@ static int arm_smmu_init_structures(struct arm_smmu_device *smmu)
>  {
>  	int ret;
>  
> +	mutex_init(&smmu->streams_mutex);
> +	smmu->streams = RB_ROOT;
> +
>  	ret = arm_smmu_init_queues(smmu);
>  	if (ret)
>  		return ret;
> 
