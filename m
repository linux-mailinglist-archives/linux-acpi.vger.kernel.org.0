Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039F83A63F6
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Jun 2021 13:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234453AbhFNLSw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Jun 2021 07:18:52 -0400
Received: from foss.arm.com ([217.140.110.172]:33154 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235163AbhFNLQw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 14 Jun 2021 07:16:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C33146D;
        Mon, 14 Jun 2021 04:14:49 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D29F3F694;
        Mon, 14 Jun 2021 04:14:45 -0700 (PDT)
Subject: Re: [PATCH v5 1/8] ACPI/IORT: Add support for RMR node parsing
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     linuxarm@huawei.com, lorenzo.pieralisi@arm.com, joro@8bytes.org,
        wanghuiqiang@huawei.com, guohanjun@huawei.com,
        steven.price@arm.com, Sami.Mujawar@arm.com, jon@solid-run.com,
        eric.auger@redhat.com, yangyicong@huawei.com
References: <20210524110222.2212-1-shameerali.kolothum.thodi@huawei.com>
 <20210524110222.2212-2-shameerali.kolothum.thodi@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <15c7fac0-11a8-0cdb-aac3-b5d8feb8f066@arm.com>
Date:   Mon, 14 Jun 2021 12:14:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210524110222.2212-2-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021-05-24 12:02, Shameer Kolothum wrote:
> Add support for parsing RMR node information from ACPI.
> Find associated stream id and smmu node info from the
> RMR node and populate a linked list with RMR memory
> descriptors.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>   drivers/acpi/arm64/iort.c | 104 +++++++++++++++++++++++++++++++++++++-
>   1 file changed, 103 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 3912a1f6058e..fea1ffaedf3b 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -40,6 +40,19 @@ struct iort_fwnode {
>   static LIST_HEAD(iort_fwnode_list);
>   static DEFINE_SPINLOCK(iort_fwnode_lock);
>   
> +/*
> + * One entry for IORT RMR.
> + */
> +struct iort_rmr_entry {
> +	struct list_head list;
> +	u32 sid;
> +	struct acpi_iort_node *smmu;
> +	struct acpi_iort_rmr_desc *rmr_desc;
> +	u32 flags;
> +};
> +
> +static LIST_HEAD(iort_rmr_list);         /* list of RMR regions from ACPI */
> +
>   /**
>    * iort_set_fwnode() - Create iort_fwnode and use it to register
>    *		       iommu data in the iort_fwnode_list
> @@ -393,7 +406,8 @@ static struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
>   		if (node->type == ACPI_IORT_NODE_NAMED_COMPONENT ||
>   		    node->type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX ||
>   		    node->type == ACPI_IORT_NODE_SMMU_V3 ||
> -		    node->type == ACPI_IORT_NODE_PMCG) {
> +		    node->type == ACPI_IORT_NODE_PMCG ||
> +		    node->type == ACPI_IORT_NODE_RMR) {
>   			*id_out = map->output_base;
>   			return parent;
>   		}
> @@ -1660,6 +1674,91 @@ static void __init iort_enable_acs(struct acpi_iort_node *iort_node)
>   #else
>   static inline void iort_enable_acs(struct acpi_iort_node *iort_node) { }
>   #endif
> +static int iort_rmr_desc_valid(struct acpi_iort_rmr_desc *desc, u32 count)
> +{
> +	int i, j;
> +
> +	for (i = 0; i < count; i++) {
> +		u64 end, start = desc[i].base_address, length = desc[i].length;
> +
> +		if (!IS_ALIGNED(start, SZ_64K) || !IS_ALIGNED(length, SZ_64K))
> +			return -EINVAL;

We should certainly FW_BUG for this, but maybe it's OK to continue, 
since all we should need to do is round our iommu_resv_regions to at 
least PAGE_SIZE. That seems possibly better than ignoring them and 
having things potentially blow up later (especially if an end user 
exercises the system more thoroughly than the firmware developer tested 
it, which in at least one case I've seen may be "at all"...)

> +		end = start + length - 1;
> +
> +		/* Check for address overlap */
> +		for (j = i + 1; j < count; j++) {
> +			u64 e_start = desc[j].base_address;
> +			u64 e_end = e_start + desc[j].length - 1;
> +
> +			if (start <= e_end && end >= e_start)
> +				return -EINVAL;

Similarly it's not *too* hard to trim overlaps; I guess it's really a 
question of whether we want to bother :/

> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int __init iort_parse_rmr(struct acpi_iort_node *iort_node)
> +{
> +	struct acpi_iort_node *smmu;
> +	struct iort_rmr_entry *e;
> +	struct acpi_iort_rmr *rmr;
> +	struct acpi_iort_rmr_desc *rmr_desc;
> +	u32 map_count = iort_node->mapping_count;
> +	u32  sid;

Nit: extra space.

> +	int i, ret = 0;
> +
> +	if (iort_node->type != ACPI_IORT_NODE_RMR)
> +		return 0;
> +
> +	if (!iort_node->mapping_offset || map_count != 1) {

Beware that there was some discussion about allowing multiple SIDs to 
share an RMR descriptor, since there are potential use-cases which would 
otherwise lead to excessive duplication (e.g. an MSI doorbell carveout 
in a VM which would effectively apply to all possible PCI RIDs). I think 
the conclusion we reached was that disallowing that was fairly 
arbitrary, and could possibly be relaxed in future. It looks like the 
design of things here could grow to fit that fairly easily though, so I 
don't think it's a major concern.

Robin.

> +		pr_err(FW_BUG "Invalid ID mapping, skipping RMR node %p\n",
> +		       iort_node);
> +		return -EINVAL;
> +	}
> +
> +	/* Retrieve associated smmu and stream id */
> +	smmu = iort_node_get_id(iort_node, &sid, 0);
> +	if (!smmu) {
> +		pr_err(FW_BUG "Invalid SMMU reference, skipping RMR node %p\n",
> +		       iort_node);
> +		return -EINVAL;
> +	}
> +
> +	/* Retrieve RMR data */
> +	rmr = (struct acpi_iort_rmr *)iort_node->node_data;
> +	if (!rmr->rmr_offset || !rmr->rmr_count) {
> +		pr_err(FW_BUG "Invalid RMR descriptor array, skipping RMR node %p\n",
> +		       iort_node);
> +		return -EINVAL;
> +	}
> +
> +	rmr_desc = ACPI_ADD_PTR(struct acpi_iort_rmr_desc, iort_node,
> +				rmr->rmr_offset);
> +
> +	ret = iort_rmr_desc_valid(rmr_desc, rmr->rmr_count);
> +	if (ret) {
> +		pr_err(FW_BUG "Invalid RMR descriptor[%d] for node %p, skipping...\n",
> +		       i, iort_node);
> +		return ret;
> +	}
> +
> +	for (i = 0; i < rmr->rmr_count; i++, rmr_desc++) {
> +		e = kmalloc(sizeof(*e), GFP_KERNEL);
> +		if (!e)
> +			return -ENOMEM;
> +
> +		e->sid = sid;
> +		e->smmu = smmu;
> +		e->rmr_desc = rmr_desc;
> +		e->flags = rmr->flags;
> +
> +		list_add_tail(&e->list, &iort_rmr_list);
> +	}
> +
> +	return 0;
> +}
>   
>   static void __init iort_init_platform_devices(void)
>   {
> @@ -1689,6 +1788,9 @@ static void __init iort_init_platform_devices(void)
>   
>   		iort_enable_acs(iort_node);
>   
> +		if (iort_table->revision == 3)
> +			iort_parse_rmr(iort_node);
> +
>   		ops = iort_get_dev_cfg(iort_node);
>   		if (ops) {
>   			fwnode = acpi_alloc_fwnode_static();
> 
