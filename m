Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371454D44A5
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Mar 2022 11:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241219AbiCJKdm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Mar 2022 05:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241367AbiCJKdO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Mar 2022 05:33:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 646DB13EF8C
        for <linux-acpi@vger.kernel.org>; Thu, 10 Mar 2022 02:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646908332;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aqZfieWFaoTQyfoYU2cd+k7oJA/upC8Un56CVcZd2Ys=;
        b=bOEgvB78MdCvUduvcHetb0mzZbTTmDpvlMjN22y2pIojg35AcCFIYm9A1lOFTecnZja/9I
        HlTKkZSBtvupPYOotORQ+V397KwM55jGtLwB+x+Y4gUFogeb/WKPIacCFjT8O/07frMfoM
        mz3/TCn7OaPPZDa4KHAceHQ1HMY+qaw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-400-xFw3Gml6PoW5IWPupd984g-1; Thu, 10 Mar 2022 05:32:09 -0500
X-MC-Unique: xFw3Gml6PoW5IWPupd984g-1
Received: by mail-wm1-f71.google.com with SMTP id 26-20020a05600c22da00b00388307f3503so2128700wmg.1
        for <linux-acpi@vger.kernel.org>; Thu, 10 Mar 2022 02:32:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=aqZfieWFaoTQyfoYU2cd+k7oJA/upC8Un56CVcZd2Ys=;
        b=dAgZeJZzjeBVwh+NIFXBw+7UEuRhjVN6TB/iYUv8Cv5InR00AHQ8FyxJBS4KAcPra4
         xXb/EdZGxCkT+mIpoOLEZ42WuZjk0jC9z/rAOMtMWZaZHrGIrAbOx1i09gOfPREIsgkF
         IqltAaPlLeJHGhon7HbgGXTngSi7ACqqw5zWkt1F9w0uXd5jJ286yaTMYUTD3szpXY/j
         kFt4+idF3G2azW3x6SGqMa3KSmko9vAObFJcw1OCH+LMAVOfBZN171f16/6bcHy83lgP
         PFQYSbNYsu1Fj4YuoMGFGJeVvZLUYUlnAjy4scmjPWnfjUCsyGEaV8Cwe0buGYTnYf0x
         +F/A==
X-Gm-Message-State: AOAM533MPfdzCbAc/3d4VgBWR+sEOt/26c51R+lD8RepUfUwsIu34DGv
        B3HR7/SHORvW+XT5K9q5vtKvvowdp60Ah/3karJiojcz05s7KFxDAk0jNrs4MsaM2ejMj4RTux7
        YNxb2xXOLZR1VjJhHTQ215w==
X-Received: by 2002:a05:600c:1906:b0:389:a5c0:23cb with SMTP id j6-20020a05600c190600b00389a5c023cbmr11020914wmq.96.1646908328178;
        Thu, 10 Mar 2022 02:32:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwMjFs69jHMpjU+b0/ecnP20PxF4UByxjwTYY1588fpNSG85NATW81wHOOCegpkBuj4Zc0pwA==
X-Received: by 2002:a05:600c:1906:b0:389:a5c0:23cb with SMTP id j6-20020a05600c190600b00389a5c023cbmr11020884wmq.96.1646908327807;
        Thu, 10 Mar 2022 02:32:07 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id e4-20020adffc44000000b001f1dba38a65sm3801263wrs.105.2022.03.10.02.32.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 02:32:07 -0800 (PST)
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v8 03/11] ACPI/IORT: Add helper functions to parse RMR
 nodes
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     linuxarm@huawei.com, lorenzo.pieralisi@arm.com, joro@8bytes.org,
        robin.murphy@arm.com, will@kernel.org, wanghuiqiang@huawei.com,
        guohanjun@huawei.com, steven.price@arm.com, Sami.Mujawar@arm.com,
        jon@solid-run.com, yangyicong@huawei.com
References: <20220221154344.2126-1-shameerali.kolothum.thodi@huawei.com>
 <20220221154344.2126-4-shameerali.kolothum.thodi@huawei.com>
From:   Eric Auger <eric.auger@redhat.com>
Message-ID: <d5740467-f070-bd29-5ef4-de071b751292@redhat.com>
Date:   Thu, 10 Mar 2022 11:32:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220221154344.2126-4-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Shameer,

On 2/21/22 4:43 PM, Shameer Kolothum wrote:
> The helper functions here parse through the IORT RMR nodes and
> populate a reserved region list  corresponding to a given iommu
> and device(optional). These also go through the ID mappings of
> the RMR node and retrieves all the SIDs associated with a RMR
> descriptor.
>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  drivers/acpi/arm64/iort.c | 225 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 225 insertions(+)
>
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 0730c4dbb700..05da9ebff50a 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -830,6 +830,231 @@ static struct acpi_iort_node *iort_get_msi_resv_iommu(struct device *dev)
>  	return NULL;
>  }
>  
> +static void iort_rmr_desc_check_overlap(struct acpi_iort_rmr_desc *desc, u32 count)
> +{
> +	int i, j;
> +
> +	for (i = 0; i < count; i++) {
> +		u64 end, start = desc[i].base_address, length = desc[i].length;
> +
> +		end = start + length - 1;
> +
> +		/* Check for address overlap */
> +		for (j = i + 1; j < count; j++) {
> +			u64 e_start = desc[j].base_address;
> +			u64 e_end = e_start + desc[j].length - 1;
> +
> +			if (start <= e_end && end >= e_start)
> +				pr_err(FW_BUG "RMR descriptor[0x%llx - 0x%llx] overlaps, continue anyway\n",
> +				       start, end);
> +		}
> +	}
> +}
> +
> +/*
> + * Please note, we will keep the already allocated RMR reserve
> + * regions in case of a memory allocation failure.
> + */
> +static void iort_rmr_get_resv_regions(struct acpi_iort_node *node,
> +				      struct acpi_iort_node *smmu,
> +				      u32 *sids, u32 num_sids,
> +				      struct list_head *head)
> +{
> +	struct acpi_iort_rmr *rmr = (struct acpi_iort_rmr *)node->node_data;
> +	struct acpi_iort_rmr_desc *rmr_desc;
> +	int i;
> +
> +	rmr_desc = ACPI_ADD_PTR(struct acpi_iort_rmr_desc, node,
> +				rmr->rmr_offset);
> +
> +	iort_rmr_desc_check_overlap(rmr_desc, rmr->rmr_count);
> +
> +	for (i = 0; i < rmr->rmr_count; i++, rmr_desc++) {
> +		struct iommu_resv_region *region;
> +		enum iommu_resv_type type;
> +		u32  *sids_copy;
> +		int prot = IOMMU_READ | IOMMU_WRITE;
> +		u64 addr = rmr_desc->base_address, size = rmr_desc->length;
> +
> +		if (!IS_ALIGNED(addr, SZ_64K) || !IS_ALIGNED(size, SZ_64K)) {
> +			/* PAGE align base addr and size */
> +			addr &= PAGE_MASK;
> +			size = PAGE_ALIGN(size + offset_in_page(rmr_desc->base_address));
> +
> +			pr_err(FW_BUG "RMR descriptor[0x%llx - 0x%llx] not aligned to 64K, continue with [0x%llx - 0x%llx]\n",
> +			       rmr_desc->base_address,
> +			       rmr_desc->base_address + rmr_desc->length - 1,
> +			       addr, addr + size - 1);
> +		}
> +
> +		if (rmr->flags & ACPI_IORT_RMR_REMAP_PERMITTED)
> +			type = IOMMU_RESV_DIRECT_RELAXABLE;
> +		else
> +			type = IOMMU_RESV_DIRECT;
> +
> +		if (rmr->flags & ACPI_IORT_RMR_ACCESS_PRIVILEGE)
> +			prot |= IOMMU_PRIV;
> +
> +		/* Attributes 0x00 - 0x03 represents device memory */
> +		if (ACPI_IORT_RMR_ACCESS_ATTRIBUTES(rmr->flags) <=
> +				ACPI_IORT_RMR_ATTR_DEVICE_GRE)
> +			prot |= IOMMU_MMIO;
> +		else if (ACPI_IORT_RMR_ACCESS_ATTRIBUTES(rmr->flags) ==
> +				ACPI_IORT_RMR_ATTR_NORMAL)
> +			prot |= IOMMU_CACHE;
> +
> +		/* Create a copy of sids array to associate with this resv region */
> +		sids_copy = kmemdup(sids, num_sids * sizeof(*sids), GFP_KERNEL);
> +		if (!sids_copy)
> +			return;
> +
> +		region = iommu_alloc_resv_region(addr, size, prot, type);
> +		if (!region) {
> +			kfree(sids_copy);
> +			return;
> +		}
> +
> +		region->fw_data.rmr.sids = sids_copy;
> +		region->fw_data.rmr.num_sids = num_sids;
> +		list_add_tail(&region->list, head);
> +	}
> +}
> +
> +static u32 *iort_rmr_alloc_sids(u32 *sids, u32 count, u32 id_start,
> +				u32 new_count)
> +{
> +	u32 *new_sids;
> +	u32 total_count = count + new_count;
> +	int i;
> +
> +	new_sids = krealloc_array(sids, count + new_count,
> +				  sizeof(*new_sids), GFP_KERNEL);
> +	if (!new_sids)
> +		return NULL;
> +
> +	/*Update new ones */
> +	for (i = count; i < total_count; i++)
> +		new_sids[i] = id_start++;
> +
> +	return new_sids;
> +}
> +
> +static bool iort_rmr_has_dev(struct device *dev, u32 id_start,
> +			     u32 id_count)
> +{
> +	int i;
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +
> +	if (dev_is_pci(dev)) {
> +		struct pci_dev *pdev = to_pci_dev(dev);
> +		struct pci_host_bridge *host = pci_find_host_bridge(pdev->bus);
> +
> +		if (!host->preserve_config)
> +			return false;
> +	}
> +
> +	for (i = 0; i < fwspec->num_ids; i++) {
> +		if (fwspec->ids[i] >= id_start &&
> +		    fwspec->ids[i] <= id_start + id_count)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static void iort_node_get_rmr_info(struct acpi_iort_node *node,
> +				   struct acpi_iort_node *iommu,
> +				   struct device *dev, struct list_head *head)
> +{
> +	struct acpi_iort_node *smmu = NULL;
> +	struct acpi_iort_rmr *rmr;
> +	struct acpi_iort_id_mapping *map;
> +	u32 *sids = NULL;
> +	u32 num_sids = 0;
> +	int i;
> +
> +	if (!node->mapping_offset || !node->mapping_count) {
> +		pr_err(FW_BUG "Invalid ID mapping, skipping RMR node %p\n",
> +		       node);
> +		return;
> +	}
> +
> +	rmr = (struct acpi_iort_rmr *)node->node_data;
> +	if (!rmr->rmr_offset || !rmr->rmr_count)
> +		return;
> +
> +	map = ACPI_ADD_PTR(struct acpi_iort_id_mapping, node,
> +			   node->mapping_offset);
> +
> +	/*
> +	 * Go through the ID mappings and see if we have a match
> +	 * for smmu and dev(if !NULL). If found, get the sids
> +	 * for the Node.
> +	 * Please note, id_count is equal to the number of IDs
> +	 * in the range minus one.
> +	 */
> +	for (i = 0; i < node->mapping_count; i++, map++) {
> +		struct acpi_iort_node *parent;
> +
> +		if (!map->id_count)
> +			continue;
> +
> +		parent = ACPI_ADD_PTR(struct acpi_iort_node, iort_table,
> +				      map->output_reference);
> +		if (parent != iommu)
> +			continue;
> +
> +		/* If dev is valid, check RMR node corresponds to the dev sid */
> +		if (dev && !iort_rmr_has_dev(dev, map->output_base,
> +					     map->id_count))
> +			continue;
> +
> +		/* Retrieve sids associated with the Node. */
> +		sids = iort_rmr_alloc_sids(sids, num_sids, map->output_base,
> +					   map->id_count + 1);
> +		if (!sids)
> +			return;
> +
> +		num_sids += map->id_count + 1;
> +	}
> +
> +	if (!sids)
> +		return;
> +
> +	iort_rmr_get_resv_regions(node, smmu, sids, num_sids, head);
> +	kfree(sids);
> +}
> +
> +static void iort_find_rmrs(struct acpi_iort_node *iommu, struct device *dev,
> +			   struct list_head *head)
> +{
> +	struct acpi_table_iort *iort;
> +	struct acpi_iort_node *iort_node, *iort_end;
> +	int i;
> +
> +	if (iort_table->revision < 5)
This means E.b and E.c revs are not supported. Is it what we want?

Thanks

Eric
> +		return;
> +
> +	iort = (struct acpi_table_iort *)iort_table;
> +
> +	iort_node = ACPI_ADD_PTR(struct acpi_iort_node, iort,
> +				 iort->node_offset);
> +	iort_end = ACPI_ADD_PTR(struct acpi_iort_node, iort,
> +				iort_table->length);
> +
> +	for (i = 0; i < iort->node_count; i++) {
> +		if (WARN_TAINT(iort_node >= iort_end, TAINT_FIRMWARE_WORKAROUND,
> +			       "IORT node pointer overflows, bad table!\n"))
> +			return;
> +
> +		if (iort_node->type == ACPI_IORT_NODE_RMR)
> +			iort_node_get_rmr_info(iort_node, iommu, dev, head);
> +
> +		iort_node = ACPI_ADD_PTR(struct acpi_iort_node, iort_node,
> +					 iort_node->length);
> +	}
> +}
> +
>  /**
>   * iort_iommu_msi_get_resv_regions - Reserved region driver helper
>   * @dev: Device from iommu_get_resv_regions()

