Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7AFE16109A
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Feb 2020 12:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgBQLEe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 17 Feb 2020 06:04:34 -0500
Received: from foss.arm.com ([217.140.110.172]:33924 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbgBQLEe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 17 Feb 2020 06:04:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F20D030E;
        Mon, 17 Feb 2020 03:04:33 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BDB463F6CF;
        Mon, 17 Feb 2020 03:04:32 -0800 (PST)
Date:   Mon, 17 Feb 2020 11:04:21 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Pankaj Bansal <pankaj.bansal@nxp.com>
Cc:     Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Varun Sethi <V.Sethi@nxp.com>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI/IORT: fix output id retrieval for platform devices
Message-ID: <20200217110413.GA27550@e121166-lin.cambridge.arm.com>
References: <20200217141504.4183-1-pankaj.bansal@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217141504.4183-1-pankaj.bansal@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Feb 17, 2020 at 07:45:04PM +0530, Pankaj Bansal wrote:
> As per IORT spec if Single mapping flag is not defined for
> a node, the output id ought to to be retrieved using input
> id from an ID mapping.
> 
> Current code of output id retrieval for platform devices
> ignored this case. fixed the same.

This patch fixes nothing, if anything it may break existing
platforms. Please answer the question I asked:

https://lore.kernel.org/lkml/20200214174949.GA30484@e121166-lin.cambridge.arm.com/

> Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
> ---
>  drivers/acpi/arm64/iort.c | 36 +++++++++++++++++-------------------
>  1 file changed, 17 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index ed3d2d1a7ae9..00e562dadd2a 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -358,7 +358,9 @@ static int iort_id_map(struct acpi_iort_id_mapping *map, u8 type, u32 rid_in,
>  	/* Single mapping does not care for input id */
>  	if (map->flags & ACPI_IORT_ID_SINGLE_MAPPING) {
>  		if (type == ACPI_IORT_NODE_NAMED_COMPONENT ||
> -		    type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX) {
> +		    type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX ||
> +		    type == ACPI_IORT_NODE_SMMU_V3 ||
> +		    type == ACPI_IORT_NODE_PMCG) {
>  			*rid_out = map->output_base;
>  			return 0;
>  		}
> @@ -376,7 +378,8 @@ static int iort_id_map(struct acpi_iort_id_mapping *map, u8 type, u32 rid_in,
>  }
>  
>  static struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
> -					       u32 *id_out, int index)
> +					       u32 id_in, u32 *id_out,
> +					       int index)
>  {
>  	struct acpi_iort_node *parent;
>  	struct acpi_iort_id_mapping *map;
> @@ -398,15 +401,8 @@ static struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
>  	parent = ACPI_ADD_PTR(struct acpi_iort_node, iort_table,
>  			       map->output_reference);
>  
> -	if (map->flags & ACPI_IORT_ID_SINGLE_MAPPING) {
> -		if (node->type == ACPI_IORT_NODE_NAMED_COMPONENT ||
> -		    node->type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX ||
> -		    node->type == ACPI_IORT_NODE_SMMU_V3 ||
> -		    node->type == ACPI_IORT_NODE_PMCG) {
> -			*id_out = map->output_base;
> -			return parent;
> -		}
> -	}
> +	if (!iort_id_map(map, node->type, id_in, id_out))
> +		return parent;
>  
>  	return NULL;
>  }
> @@ -510,14 +506,14 @@ static struct acpi_iort_node *iort_node_map_id(struct acpi_iort_node *node,
>  }
>  
>  static struct acpi_iort_node *iort_node_map_platform_id(
> -		struct acpi_iort_node *node, u32 *id_out, u8 type_mask,
> -		int index)
> +		struct acpi_iort_node *node, u32 id_in, u32 *id_out,
> +		u8 type_mask, int index)
>  {
>  	struct acpi_iort_node *parent;
>  	u32 id;
>  
>  	/* step 1: retrieve the initial dev id */
> -	parent = iort_node_get_id(node, &id, index);
> +	parent = iort_node_get_id(node, id_in, &id, index);
>  	if (!parent)
>  		return NULL;
>  
> @@ -592,7 +588,8 @@ u32 iort_msi_map_rid(struct device *dev, u32 req_id)
>  /**
>   * iort_pmsi_get_dev_id() - Get the device id for a device
>   * @dev: The device for which the mapping is to be done.
> - * @dev_id: The device ID found.
> + * @dev_id: On function entry the input id for device.
> + *          On successful function exit, the output device ID found.
>   *
>   * Returns: 0 for successful find a dev id, -ENODEV on error
>   */
> @@ -608,11 +605,11 @@ int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id)
>  	index = iort_get_id_mapping_index(node);
>  	/* if there is a valid index, go get the dev_id directly */
>  	if (index >= 0) {
> -		if (iort_node_get_id(node, dev_id, index))
> +		if (iort_node_get_id(node, *dev_id, dev_id, index))
>  			return 0;
>  	} else {
>  		for (i = 0; i < node->mapping_count; i++) {
> -			if (iort_node_map_platform_id(node, dev_id,
> +			if (iort_node_map_platform_id(node, *dev_id, dev_id,
>  						      IORT_MSI_TYPE, i))
>  				return 0;
>  		}
> @@ -761,7 +758,7 @@ static struct irq_domain *iort_get_platform_device_domain(struct device *dev)
>  
>  	/* then find its msi parent node */
>  	for (i = 0; i < node->mapping_count; i++) {
> -		msi_parent = iort_node_map_platform_id(node, NULL,
> +		msi_parent = iort_node_map_platform_id(node, 0, NULL,
>  						       IORT_MSI_TYPE, i);
>  		if (msi_parent)
>  			break;
> @@ -1038,7 +1035,8 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
>  			return NULL;
>  
>  		do {
> -			parent = iort_node_map_platform_id(node, &streamid,
> +			parent = iort_node_map_platform_id(node, streamid,
> +							   &streamid,
>  							   IORT_IOMMU_TYPE,
>  							   i++);
>  
> -- 
> 2.17.1
> 
