Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC203997D2
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Jun 2021 04:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhFCCCp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Jun 2021 22:02:45 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3041 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhFCCCp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jun 2021 22:02:45 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FwTWz4SWYzWr7k;
        Thu,  3 Jun 2021 09:56:15 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 3 Jun 2021 10:00:54 +0800
Received: from [10.174.179.71] (10.174.179.71) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 3 Jun 2021 10:00:54 +0800
Subject: Re: [PATCH] acpi/arm64: Mark next_platform_timer as __init
To:     Kees Cook <keescook@chromium.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20210602214645.695597-1-keescook@chromium.org>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <e0381edd-92d3-ef3c-b643-f50f962416bc@huawei.com>
Date:   Thu, 3 Jun 2021 10:00:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20210602214645.695597-1-keescook@chromium.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.71]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021/6/3 5:46, Kees Cook wrote:
> Fix section mismatch warning:
> 
> WARNING: modpost: vmlinux.o(.text.unlikely+0x95ac): Section mismatch in reference from the function next_platform_timer() to the variable .init.data:acpi_gtdt_desc
> The function next_platform_timer() references
> the variable __initdata acpi_gtdt_desc.
> This is often because next_platform_timer lacks a __initdata
> annotation or the annotation of acpi_gtdt_desc is wrong.
> 
> Suggested-by: Hanjun Guo <guohanjun@huawei.com>
> Link: https://lore.kernel.org/linux-acpi/20200508152653.157663-1-wangkefeng.wang@huawei.com/
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>   drivers/acpi/arm64/gtdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
> index 0a0a982f9c28..c3ad42470a7c 100644
> --- a/drivers/acpi/arm64/gtdt.c
> +++ b/drivers/acpi/arm64/gtdt.c
> @@ -36,7 +36,7 @@ struct acpi_gtdt_descriptor {
>   
>   static struct acpi_gtdt_descriptor acpi_gtdt_desc __initdata;
>   
> -static inline void *next_platform_timer(void *platform_timer)
> +static __init void *next_platform_timer(void *platform_timer)
>   {
>   	struct acpi_gtdt_header *gh = platform_timer;

Thanks for the fix,

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
