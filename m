Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F41671C3774
	for <lists+linux-acpi@lfdr.de>; Mon,  4 May 2020 13:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbgEDLA7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 May 2020 07:00:59 -0400
Received: from foss.arm.com ([217.140.110.172]:41856 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727098AbgEDLA7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 4 May 2020 07:00:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 321811FB;
        Mon,  4 May 2020 04:00:58 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F17D93F71F;
        Mon,  4 May 2020 04:00:56 -0700 (PDT)
Date:   Mon, 4 May 2020 12:00:46 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        Hanjun Guo <guohanjun@huawei.com>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 2/2] ACPI/IORT: work around num_ids ambiguity
Message-ID: <20200504110037.GA26486@e121166-lin.cambridge.arm.com>
References: <20200501161014.5935-1-ardb@kernel.org>
 <20200501161014.5935-3-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501161014.5935-3-ardb@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, May 01, 2020 at 06:10:14PM +0200, Ard Biesheuvel wrote:
> The ID mapping table structure of the IORT table describes the size of
> a range using a num_ids field carrying the number of IDs in the region
> minus one. This has been misinterpreted in the past in the parsing code,
> and firmware is known to have shipped where this results in an ambiguity,
> where regions that should be adjacent have an overlap of one value.
> 
> So let's work around this by detecting this case specifically: when
> resolving an ID translation, allow one that matches right at the end of
> a multi-ID region to be superseded by a subsequent one.
> 
> To prevent potential regressions on broken firmware that happened to
> work before, only take the subsequent match into account if it occurs
> at the start of a mapping region.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/acpi/arm64/iort.c | 40 +++++++++++++++++---
>  1 file changed, 34 insertions(+), 6 deletions(-)

The patch logic is sound - I still think that the resulting code can
benefit from a one-off boot time mapping data initialisation but we can
address that later as a clean-up, first thing is to remove the quirk
mechanism.

Goes without saying, this needs extensive testing on existing
platforms before sending it to stable kernels.

Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 98be18266a73..9f139a94a1d3 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -300,7 +300,7 @@ static acpi_status iort_match_node_callback(struct acpi_iort_node *node,
>  }
>  
>  static int iort_id_map(struct acpi_iort_id_mapping *map, u8 type, u32 rid_in,
> -		       u32 *rid_out)
> +		       u32 *rid_out, bool check_overlap)
>  {
>  	/* Single mapping does not care for input id */
>  	if (map->flags & ACPI_IORT_ID_SINGLE_MAPPING) {
> @@ -316,10 +316,34 @@ static int iort_id_map(struct acpi_iort_id_mapping *map, u8 type, u32 rid_in,
>  	}
>  
>  	if (rid_in < map->input_base ||
> -	    (rid_in >= map->input_base + map->id_count))
> +	    (rid_in > map->input_base + map->id_count))
>  		return -ENXIO;
>  
> +	if (check_overlap) {
> +		/*
> +		 * We already found a mapping for this input ID at the end of
> +		 * another region. If it coincides with the start of this
> +		 * region, we assume the prior match was due to the off-by-1
> +		 * issue mentioned below, and allow it to be superseded.
> +		 * Otherwise, things are *really* broken, and we just disregard
> +		 * duplicate matches entirely to retain compatibility.
> +		 */
> +		pr_err(FW_BUG "[map %p] conflicting mapping for input ID 0x%x\n",
> +		       map, rid_in);
> +		if (rid_in != map->input_base)
> +			return -ENXIO;
> +	}
> +
>  	*rid_out = map->output_base + (rid_in - map->input_base);
> +
> +	/*
> +	 * Due to confusion regarding the meaning of the id_count field (which
> +	 * carries the number of IDs *minus 1*), we may have to disregard this
> +	 * match if it is at the end of the range, and overlaps with the start
> +	 * of another one.
> +	 */
> +	if (map->id_count > 0 && rid_in == map->input_base + map->id_count)
> +		return -EAGAIN;
>  	return 0;
>  }
>  
> @@ -404,7 +428,8 @@ static struct acpi_iort_node *iort_node_map_id(struct acpi_iort_node *node,
>  	/* Parse the ID mapping tree to find specified node type */
>  	while (node) {
>  		struct acpi_iort_id_mapping *map;
> -		int i, index;
> +		int i, index, rc = 0;
> +		u32 out_ref = 0, map_id = id;
>  
>  		if (IORT_TYPE_MASK(node->type) & type_mask) {
>  			if (id_out)
> @@ -438,15 +463,18 @@ static struct acpi_iort_node *iort_node_map_id(struct acpi_iort_node *node,
>  			if (i == index)
>  				continue;
>  
> -			if (!iort_id_map(map, node->type, id, &id))
> +			rc = iort_id_map(map, node->type, map_id, &id, out_ref);
> +			if (!rc)
>  				break;
> +			if (rc == -EAGAIN)
> +				out_ref = map->output_reference;
>  		}
>  
> -		if (i == node->mapping_count)
> +		if (i == node->mapping_count && !out_ref)
>  			goto fail_map;
>  
>  		node = ACPI_ADD_PTR(struct acpi_iort_node, iort_table,
> -				    map->output_reference);
> +				    rc ? out_ref : map->output_reference);
>  	}
>  
>  fail_map:
> -- 
> 2.17.1
> 
