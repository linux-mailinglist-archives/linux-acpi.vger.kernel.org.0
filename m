Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35973360600
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Apr 2021 11:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbhDOJjw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Apr 2021 05:39:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41855 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229537AbhDOJjv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 15 Apr 2021 05:39:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618479568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OYfUyG4SfAr00Lsm1KqY9DuAuxzdrP7zVBgWh191mM8=;
        b=eCcX7ndtygo1wixE3DrjnOeByMzs+jFGfqVwYypz5pktL83kOTh65xY9AAZw0V/lHRIdms
        gBrsC83Y/EoIHJURYLb3/Fz50gpVv6zPZ4ZgP0CqevPOFqTtbvi3Vc4lQb1OKl9nMDIIA2
        Zmd12paV6iTfV3B943eHEXNKQwzETPs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-DWNGSzP_PSKcJiIMK28M_w-1; Thu, 15 Apr 2021 05:39:26 -0400
X-MC-Unique: DWNGSzP_PSKcJiIMK28M_w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF26A6D246;
        Thu, 15 Apr 2021 09:39:24 +0000 (UTC)
Received: from [10.36.114.81] (ovpn-114-81.ams2.redhat.com [10.36.114.81])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F267A1A874;
        Thu, 15 Apr 2021 09:39:20 +0000 (UTC)
Subject: Re: [RFC PATCH v2 2/8] ACPI/IORT: Add support for RMR node parsing
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org, devel@acpica.org
Cc:     linuxarm@huawei.com, steven.price@arm.com, guohanjun@huawei.com,
        Sami.Mujawar@arm.com, robin.murphy@arm.com, wanghuiqiang@huawei.com
References: <20201119121150.3316-1-shameerali.kolothum.thodi@huawei.com>
 <20201119121150.3316-3-shameerali.kolothum.thodi@huawei.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <a64025cd-3312-9621-1771-8e0430220ed8@redhat.com>
Date:   Thu, 15 Apr 2021 11:39:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20201119121150.3316-3-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Shameer,
On 11/19/20 1:11 PM, Shameer Kolothum wrote:
> Add support for parsing RMR node information from ACPI.
> Find associated stream ids and smmu node info from the
> RMR node and populate a linked list with RMR memory
> descriptors.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  drivers/acpi/arm64/iort.c | 122 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 121 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 9929ff50c0c0..a9705aa35028 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -40,6 +40,25 @@ struct iort_fwnode {
>  static LIST_HEAD(iort_fwnode_list);
>  static DEFINE_SPINLOCK(iort_fwnode_lock);
>  
> +struct iort_rmr_id {
> +	u32  sid;
> +	struct acpi_iort_node *smmu;
> +};
> +
> +/*
> + * One entry for IORT RMR.
> + */
> +struct iort_rmr_entry {
> +	struct list_head list;
> +
> +	unsigned int rmr_ids_num;
> +	struct iort_rmr_id *rmr_ids;
> +
> +	struct acpi_iort_rmr_desc *rmr_desc;
> +};
> +
> +static LIST_HEAD(iort_rmr_list);         /* list of RMR regions from ACPI */
> +
>  /**
>   * iort_set_fwnode() - Create iort_fwnode and use it to register
>   *		       iommu data in the iort_fwnode_list
> @@ -393,7 +412,8 @@ static struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
>  		if (node->type == ACPI_IORT_NODE_NAMED_COMPONENT ||
>  		    node->type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX ||
>  		    node->type == ACPI_IORT_NODE_SMMU_V3 ||
> -		    node->type == ACPI_IORT_NODE_PMCG) {
> +		    node->type == ACPI_IORT_NODE_PMCG ||
> +		    node->type == ACPI_IORT_NODE_RMR) {
>  			*id_out = map->output_base;
>  			return parent;
>  		}
> @@ -1647,6 +1667,103 @@ static void __init iort_enable_acs(struct acpi_iort_node *iort_node)
>  #else
>  static inline void iort_enable_acs(struct acpi_iort_node *iort_node) { }
>  #endif
> +static int iort_rmr_desc_valid(struct acpi_iort_rmr_desc *desc)
> +{
> +	struct iort_rmr_entry *e;
> +	u64 end, start = desc->base_address, length = desc->length;
> +
> +	if (!IS_ALIGNED(start, SZ_64K) || !IS_ALIGNED(length, SZ_64K))
> +		return -EINVAL;
> +
> +	end = start + length - 1;
> +
> +	/* Check for address overlap */
I don't get this check. What is the problem if you attach the same range
to different stream ids. Shouldn't you check there is no overlap for the
same sid?


> +	list_for_each_entry(e, &iort_rmr_list, list) {
> +		u64 e_start = e->rmr_desc->base_address;
> +		u64 e_end = e_start + e->rmr_desc->length - 1;
> +
> +		if (start <= e_end && end >= e_start)
> +			return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int __init iort_parse_rmr(struct acpi_iort_node *iort_node)
> +{
> +	struct iort_rmr_id *rmr_ids, *ids;
> +	struct iort_rmr_entry *e;
> +	struct acpi_iort_rmr *rmr;
> +	struct acpi_iort_rmr_desc *rmr_desc;
> +	u32 map_count = iort_node->mapping_count;
> +	int i, ret = 0, desc_count = 0;
> +
> +	if (iort_node->type != ACPI_IORT_NODE_RMR)
> +		return 0;
> +
> +	if (!iort_node->mapping_offset || !map_count) {
> +		pr_err(FW_BUG "Invalid ID mapping, skipping RMR node %p\n",
> +		       iort_node);
> +		return -EINVAL;
> +	}
> +
> +	rmr_ids = kmalloc(sizeof(*rmr_ids) * map_count, GFP_KERNEL);
> +	if (!rmr_ids)
> +		return -ENOMEM;
> +
> +	/* Retrieve associated smmu and stream id */
> +	ids = rmr_ids;
nit: do you need both rmr_ids and ids?
> +	for (i = 0; i < map_count; i++, ids++) {
> +		ids->smmu = iort_node_get_id(iort_node, &ids->sid, i);
> +		if (!ids->smmu) {
> +			pr_err(FW_BUG "Invalid SMMU reference, skipping RMR node %p\n",
> +			       iort_node);
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +	}
> +
> +	/* Retrieve RMR data */
> +	rmr = (struct acpi_iort_rmr *)iort_node->node_data;
> +	if (!rmr->rmr_offset || !rmr->rmr_count) {
> +		pr_err(FW_BUG "Invalid RMR descriptor array, skipping RMR node %p\n",
> +		       iort_node);
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	rmr_desc = ACPI_ADD_PTR(struct acpi_iort_rmr_desc, iort_node,
> +				rmr->rmr_offset);
> +
> +	for (i = 0; i < rmr->rmr_count; i++, rmr_desc++) {
> +		ret = iort_rmr_desc_valid(rmr_desc);
> +		if (ret) {
> +			pr_err(FW_BUG "Invalid RMR descriptor[%d] for node %p, skipping...\n",
> +			       i, iort_node);
> +			goto out;
so I understand you skip the whole node and not just that rmr desc,
otherwise you would continue. so in that case don't you need to free
both rmr_ids and already allocated 'e'?
> +		}
> +
> +		e = kmalloc(sizeof(*e), GFP_KERNEL);
> +		if (!e) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +
> +		e->rmr_ids_num = map_count;
> +		e->rmr_ids = rmr_ids;
> +		e->rmr_desc = rmr_desc;
> +
> +		list_add_tail(&e->list, &iort_rmr_list);
> +		desc_count++;
> +	}
> +
> +	return 0;
> +
> +out:
> +	if (!desc_count)
don't you want to test ret instead? see comment above. + free allocated ''e'
> +		kfree(rmr_ids);
> +	return ret;
> +}
>  
>  static void __init iort_init_platform_devices(void)
>  {
> @@ -1676,6 +1793,9 @@ static void __init iort_init_platform_devices(void)
>  
>  		iort_enable_acs(iort_node);
>  
> +		if (iort_table->revision == 1)
> +			iort_parse_rmr(iort_node);
> +
>  		ops = iort_get_dev_cfg(iort_node);
>  		if (ops) {
>  			fwnode = acpi_alloc_fwnode_static();
> 
Thanks

Eric

