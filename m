Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7BB1CBC16
	for <lists+linux-acpi@lfdr.de>; Sat,  9 May 2020 03:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgEIBSU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 May 2020 21:18:20 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4308 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728051AbgEIBSU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 8 May 2020 21:18:20 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9CEAAC5A4080CDBAD7ED;
        Sat,  9 May 2020 09:18:18 +0800 (CST)
Received: from [127.0.0.1] (10.166.213.93) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Sat, 9 May 2020
 09:18:07 +0800
Subject: Re: [PATCH -next] arm64: gtdt: Fix section mismatch in
 next_platform_timer()
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Hulk Robot <hulkci@huawei.com>
References: <20200508152653.157663-1-wangkefeng.wang@huawei.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <e2328035-9caa-590c-b80a-b11860010020@huawei.com>
Date:   Sat, 9 May 2020 09:18:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200508152653.157663-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.213.93]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020/5/8 23:26, Kefeng Wang wrote:
> Drop the __initdata for acpi_gtdt_desc variable to fix the section mismatch,
> 
> WARNING: modpost: vmlinux.o(.text.unlikely+0x95ac): Section mismatch in reference from the function next_platform_timer() to the variable .init.data:acpi_gtdt_desc
> The function next_platform_timer() references
> the variable __initdata acpi_gtdt_desc.
> This is often because next_platform_timer lacks a __initdata
> annotation or the annotation of acpi_gtdt_desc is wrong.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>   drivers/acpi/arm64/gtdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
> index 01962c63a711..6a327616a299 100644
> --- a/drivers/acpi/arm64/gtdt.c
> +++ b/drivers/acpi/arm64/gtdt.c
> @@ -34,7 +34,7 @@ struct acpi_gtdt_descriptor {
>   	void *platform_timer;
>   };
>   
> -static struct acpi_gtdt_descriptor acpi_gtdt_desc __initdata;
> +static struct acpi_gtdt_descriptor acpi_gtdt_desc;
>   
>   static inline void *next_platform_timer(void *platform_timer)

I prefer to make this function as no inline, and make it
as __init function, becasue acpi_gtdt_desc is not used after
gtdt_sbsa_gwdt_init().

Thanks
Hanjun

