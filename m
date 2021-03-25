Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29494349894
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Mar 2021 18:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhCYRsS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Mar 2021 13:48:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:49646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229629AbhCYRsN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 25 Mar 2021 13:48:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E7BB619DC;
        Thu, 25 Mar 2021 17:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616694493;
        bh=9bFU3KcAiurrg1ZHvCw0obn8sWQePDYcL3Zjxhv6ikw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s5WFMQS2fck6GL6JJ8Cp9VF2PusZjfU5Z7nZgFEM3Bq4A1ZBGyhsP9jT8xLF8WdO9
         4vwrzvTlsrLRYVNO9573QCDOZniG0ycrTG3P5EBXnMgmesYKdZTiZeXvotS5KsVkJi
         L1ErN+CYj94NEd1DJxbVuFEgPiYSFYgwSH/1HtTbFy7p/NmaApRRk+7w8TbCape5z7
         6EPhIAY7IKUBG9FytVlRq3YbsfjOGiTR27nfVEk2FrkD2+kSnfq1et4beNr9//k/CA
         iWWiknNzRXecn7N0QYel9ssLZXTMZtP6dk6+g9g5gnq5zR3cSBFYcdIrhEet+quLHr
         hyfYxNVbFCqnw==
Date:   Thu, 25 Mar 2021 17:48:07 +0000
From:   Will Deacon <will@kernel.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     joro@8bytes.org, vivek.gautam@arm.com, guohanjun@huawei.com,
        linux-acpi@vger.kernel.org, zhangfei.gao@linaro.org,
        lenb@kernel.org, devicetree@vger.kernel.org, kevin.tian@intel.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        rjw@rjwysocki.net, iommu@lists.linux-foundation.org,
        sudeep.holla@arm.com, robin.murphy@arm.com,
        linux-accelerators@lists.ozlabs.org
Subject: Re: [PATCH v13 07/10] iommu/arm-smmu-v3: Maintain a SID->device
 structure
Message-ID: <20210325174807.GD15504@willie-the-truck>
References: <20210302092644.2553014-1-jean-philippe@linaro.org>
 <20210302092644.2553014-8-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302092644.2553014-8-jean-philippe@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 02, 2021 at 10:26:43AM +0100, Jean-Philippe Brucker wrote:
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

Can you add a lockdep assertion for that?

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

[...]

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

Is 'i--' really what you want for the initial value? Doesn't that correspond
to the ID you *didn't* add to the tree?

> +			rb_erase(&master->streams[i].node, &smmu->streams);
> +		kfree(master->streams);

Do you need to NULLify master->streams and/or reset master->num_streams
after this? Seems like they're left dangling.

Will
