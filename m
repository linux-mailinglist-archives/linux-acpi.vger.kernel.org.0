Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28CB33F4BC4
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Aug 2021 15:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhHWNe1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Aug 2021 09:34:27 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:15206 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbhHWNe0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Aug 2021 09:34:26 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GtY8l3zBxz1CZXw;
        Mon, 23 Aug 2021 21:33:11 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 23 Aug 2021 21:33:42 +0800
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 23 Aug 2021 21:33:41 +0800
Subject: Re: [PATCH] acpi/arm64: fix next_platform_timer() section mismatch
 error
To:     Jackie Liu <liu.yun@linux.dev>, <lorenzo.pieralisi@arm.com>
CC:     <linux-acpi@vger.kernel.org>, <liuyun01@kylinos.cn>
References: <20210823092526.2407526-1-liu.yun@linux.dev>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <7f29a149-e005-f13f-2cc4-a9eb737107e1@huawei.com>
Date:   Mon, 23 Aug 2021 21:33:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20210823092526.2407526-1-liu.yun@linux.dev>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.247]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021/8/23 17:25, Jackie Liu wrote:
> From: Jackie Liu <liuyun01@kylinos.cn>
> 
> Fix modpost Section mismatch error in next_platform_timer().
> 
>    [...]
>    WARNING: modpost: vmlinux.o(.text.unlikely+0x26e60): Section mismatch in reference from the function next_platform_timer() to the variable .init.data:acpi_gtdt_desc
>    The function next_platform_timer() references
>    the variable __initdata acpi_gtdt_desc.
>    This is often because next_platform_timer lacks a __initdata
>    annotation or the annotation of acpi_gtdt_desc is wrong.
> 
>    WARNING: modpost: vmlinux.o(.text.unlikely+0x26e64): Section mismatch in reference from the function next_platform_timer() to the variable .init.data:acpi_gtdt_desc
>    The function next_platform_timer() references
>    the variable __initdata acpi_gtdt_desc.
>    This is often because next_platform_timer lacks a __initdata
>    annotation or the annotation of acpi_gtdt_desc is wrong.
> 
>    ERROR: modpost: Section mismatches detected.
>    Set CONFIG_SECTION_MISMATCH_WARN_ONLY=y to allow them.
>    make[1]: *** [scripts/Makefile.modpost:59: vmlinux.symvers] Error 1
>    make[1]: *** Deleting file 'vmlinux.symvers'
>    make: *** [Makefile:1176: vmlinux] Error 2
>    [...]
> 
> Fixes: a712c3ed9b8a ("acpi/arm64: Add memory-mapped timer support in GTDT driver")
> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> ---
>   drivers/acpi/arm64/gtdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
> index 0a0a982f9c28..c0e77c1c8e09 100644
> --- a/drivers/acpi/arm64/gtdt.c
> +++ b/drivers/acpi/arm64/gtdt.c
> @@ -36,7 +36,7 @@ struct acpi_gtdt_descriptor {
>   
>   static struct acpi_gtdt_descriptor acpi_gtdt_desc __initdata;
>   
> -static inline void *next_platform_timer(void *platform_timer)
> +static inline __init void *next_platform_timer(void *platform_timer)
>   {
>   	struct acpi_gtdt_header *gh = platform_timer;

Looks good to me,

Acked-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun
