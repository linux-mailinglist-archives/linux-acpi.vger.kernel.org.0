Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173174B14EB
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Feb 2022 19:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234899AbiBJSGa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Feb 2022 13:06:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245517AbiBJSGa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Feb 2022 13:06:30 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A0E6321B7;
        Thu, 10 Feb 2022 10:06:30 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69A1ED6E;
        Thu, 10 Feb 2022 10:06:30 -0800 (PST)
Received: from [10.57.70.89] (unknown [10.57.70.89])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DFED23F70D;
        Thu, 10 Feb 2022 10:06:28 -0800 (PST)
Message-ID: <fcb52c7b-a222-126e-fb3c-d57011506cf8@arm.com>
Date:   Thu, 10 Feb 2022 18:06:24 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] ACPI/IORT: Fix GCC 12 warning
Content-Language: en-GB
To:     Victor Erminpour <victor.erminpour@oracle.com>,
        lorenzo.pieralisi@arm.com
Cc:     guohanjun@huawei.com, sudeep.holla@arm.com, rafael@kernel.org,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org
References: <1644453141-1181-1-git-send-email-victor.erminpour@oracle.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <1644453141-1181-1-git-send-email-victor.erminpour@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2022-02-10 00:32, Victor Erminpour wrote:
> When building with automatic stack variable initialization, GCC 12
> complains about variables defined outside of switch case statements.
> Move the variable into the case that uses it, which silences the warning:
> 
> ./drivers/acpi/arm64/iort.c:1670:59: error: statement will never be executed [-Werror=switch-unreachable]
>    1670 |                         struct acpi_iort_named_component *ncomp;
>         |                                                           ^~~~~

Notwithstanding the fact that that warning is nonsensical, this patch 
changes valid C code into invalid C code that doesn't even compile:

drivers/acpi/arm64/iort.c: In function ‘acpi_iort_dma_get_max_cpu_address’:
drivers/acpi/arm64/iort.c:1669:4: error: a label can only be part of a 
statement and a declaration is not a statement
  1669 |    struct acpi_iort_named_component *ncomp;
       |    ^~~~~~
drivers/acpi/arm64/iort.c:1676:4: error: a label can only be part of a 
statement and a declaration is not a statement
  1676 |    struct acpi_iort_root_complex *rc;
       |    ^~~~~~

Robin.

> Signed-off-by: Victor Erminpour <victor.erminpour@oracle.com>
> ---
>   drivers/acpi/arm64/iort.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 3b23fb775ac4..5c5d2e56d756 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -1645,7 +1645,7 @@ void __init acpi_iort_init(void)
>    */
>   phys_addr_t __init acpi_iort_dma_get_max_cpu_address(void)
>   {
> -	phys_addr_t limit = PHYS_ADDR_MAX;
> +	phys_addr_t local_limit, limit = PHYS_ADDR_MAX;
>   	struct acpi_iort_node *node, *end;
>   	struct acpi_table_iort *iort;
>   	acpi_status status;
> @@ -1667,17 +1667,15 @@ phys_addr_t __init acpi_iort_dma_get_max_cpu_address(void)
>   			break;
>   
>   		switch (node->type) {
> -			struct acpi_iort_named_component *ncomp;
> -			struct acpi_iort_root_complex *rc;
> -			phys_addr_t local_limit;
> -
>   		case ACPI_IORT_NODE_NAMED_COMPONENT:
> +			struct acpi_iort_named_component *ncomp;
>   			ncomp = (struct acpi_iort_named_component *)node->node_data;
>   			local_limit = DMA_BIT_MASK(ncomp->memory_address_limit);
>   			limit = min_not_zero(limit, local_limit);
>   			break;
>   
>   		case ACPI_IORT_NODE_PCI_ROOT_COMPLEX:
> +			struct acpi_iort_root_complex *rc;
>   			if (node->revision < 1)
>   				break;
>   
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
