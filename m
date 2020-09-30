Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A80027E483
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Sep 2020 11:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbgI3JHw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 30 Sep 2020 05:07:52 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14788 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725776AbgI3JHw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 30 Sep 2020 05:07:52 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7D8F18A9CA45CAADD438;
        Wed, 30 Sep 2020 17:07:49 +0800 (CST)
Received: from [10.174.179.33] (10.174.179.33) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Wed, 30 Sep 2020 17:07:42 +0800
Subject: Re: [PATCH] ACPI / NUMA: Add stub function for pxm_to_node
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <linux-acpi@vger.kernel.org>, <devel@acpica.org>,
        <linux-kernel@vger.kernel.org>
References: <20200928194554.3423466-1-natechancellor@gmail.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <a39af625-6e2e-3cb2-ece5-ea2b2dbb7c21@huawei.com>
Date:   Wed, 30 Sep 2020 17:07:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200928194554.3423466-1-natechancellor@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.33]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020/9/29 3:45, Nathan Chancellor wrote:
> After commit 01feba590cd6 ("ACPI: Do not create new NUMA domains from
> ACPI static tables that are not SRAT"):
> 
> $ scripts/config --file arch/x86/configs/x86_64_defconfig -d NUMA -e ACPI_NFIT
> 
> $ make -skj"$(nproc)" distclean defconfig drivers/acpi/nfit/
> drivers/acpi/nfit/core.c: In function ‘acpi_nfit_register_region’:
> drivers/acpi/nfit/core.c:3010:27: error: implicit declaration of
> function ‘pxm_to_node’; did you mean ‘xa_to_node’?
> [-Werror=implicit-function-declaration]
>   3010 |   ndr_desc->target_node = pxm_to_node(spa->proximity_domain);
>        |                           ^~~~~~~~~~~
>        |                           xa_to_node
> cc1: some warnings being treated as errors
> ...
> 
> Add a stub function like acpi_map_pxm_to_node had so that the build
> continues to work.
> 
> Fixes: 01feba590cd6 ("ACPI: Do not create new NUMA domains from ACPI static tables that are not SRAT")
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
> 
> I am not sure if this is the right place or value for this. It looks
> like there is going to be another stub function added here, which is
> going through -mm:
> 
> https://lkml.kernel.org/r/159643094925.4062302.14979872973043772305.stgit@dwillia2-desk3.amr.corp.intel.com
> 
>   include/acpi/acpi_numa.h | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/include/acpi/acpi_numa.h b/include/acpi/acpi_numa.h
> index fdebcfc6c8df..09eb3bc20ff5 100644
> --- a/include/acpi/acpi_numa.h
> +++ b/include/acpi/acpi_numa.h
> @@ -22,5 +22,10 @@ extern int acpi_numa __initdata;
>   extern void bad_srat(void);
>   extern int srat_disabled(void);
>   
> +#else				/* CONFIG_ACPI_NUMA */
> +static inline int pxm_to_node(int pxm)
> +{
> +	return 0;
> +}
>   #endif				/* CONFIG_ACPI_NUMA */
>   #endif				/* __ACP_NUMA_H */

Looks good to me,

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
