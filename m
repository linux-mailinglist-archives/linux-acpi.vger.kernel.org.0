Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A04C16F635
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Feb 2020 04:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgBZDnA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 25 Feb 2020 22:43:00 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:58586 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726024AbgBZDnA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 25 Feb 2020 22:43:00 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BC343562B035809ED25D;
        Wed, 26 Feb 2020 11:42:57 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Wed, 26 Feb 2020
 11:42:51 +0800
Subject: Re: [PATCH] acpi/iort: check output reference for the real used
 mapping
To:     Heyi Guo <guoheyi@huawei.com>, <devel@edk2.groups.io>
CC:     <wanghaibin.wang@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20200225090136.40989-1-guoheyi@huawei.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <120d5f92-eede-10bc-6d2b-b4a4ef763b24@huawei.com>
Date:   Wed, 26 Feb 2020 11:42:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20200225090136.40989-1-guoheyi@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020/2/25 17:01, Heyi Guo wrote:
> The function iort_node_map_id() does the sanity check against the
> first mapping in the node, but not the one which we really use.
> 
> Logically we need check the mapping we use, or check every mapping in
> the node. Choose the first fix for we are not firmware tester.
> 
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

I think we can warning on the NULL parent reference when
scanning the mappings in the node, but don't bail out for
the mappings we are not using.

Thanks
Hanjun

