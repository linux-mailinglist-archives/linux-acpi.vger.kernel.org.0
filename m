Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30FD016C47E
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Feb 2020 15:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730601AbgBYO5G (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 25 Feb 2020 09:57:06 -0500
Received: from foss.arm.com ([217.140.110.172]:51830 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729207AbgBYO5G (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 25 Feb 2020 09:57:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA9691FB;
        Tue, 25 Feb 2020 06:57:05 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B1233F703;
        Tue, 25 Feb 2020 06:57:04 -0800 (PST)
Date:   Tue, 25 Feb 2020 14:57:02 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Heyi Guo <guoheyi@huawei.com>
Cc:     devel@edk2.groups.io, wanghaibin.wang@huawei.com,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] acpi/iort: check output reference for the real used
 mapping
Message-ID: <20200225145702.GB8970@e121166-lin.cambridge.arm.com>
References: <20200225090136.40989-1-guoheyi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225090136.40989-1-guoheyi@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Feb 25, 2020 at 05:01:36PM +0800, Heyi Guo wrote:
> The function iort_node_map_id() does the sanity check against the
> first mapping in the node, but not the one which we really use.
> 
> Logically we need check the mapping we use, or check every mapping in
> the node. Choose the first fix for we are not firmware tester.

Yes, I agree with you, I will think about what's best to do, can
I pick up this patch and resend it on your behalf please ?

Thanks,
Lorenzo

> Signed-off-by: Heyi Guo <guoheyi@huawei.com>
> 
> ---
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Hanjun Guo <guohanjun@huawei.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/acpi/arm64/iort.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index ed3d2d1a7ae9..d0fe8d673240 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -470,13 +470,6 @@ static struct acpi_iort_node *iort_node_map_id(struct acpi_iort_node *node,
>  		map = ACPI_ADD_PTR(struct acpi_iort_id_mapping, node,
>  				   node->mapping_offset);
>  
> -		/* Firmware bug! */
> -		if (!map->output_reference) {
> -			pr_err(FW_BUG "[node %p type %d] ID map has NULL parent reference\n",
> -			       node, node->type);
> -			goto fail_map;
> -		}
> -
>  		/*
>  		 * Get the special ID mapping index (if any) and skip its
>  		 * associated ID map to prevent erroneous multi-stage
> @@ -497,6 +490,13 @@ static struct acpi_iort_node *iort_node_map_id(struct acpi_iort_node *node,
>  		if (i == node->mapping_count)
>  			goto fail_map;
>  
> +		/* Firmware bug! */
> +		if (!map->output_reference) {
> +			pr_err(FW_BUG "[node %p type %d] ID map has NULL parent reference\n",
> +			       node, node->type);
> +			goto fail_map;
> +		}
> +
>  		node = ACPI_ADD_PTR(struct acpi_iort_node, iort_table,
>  				    map->output_reference);
>  	}
> -- 
> 2.19.1
> 
