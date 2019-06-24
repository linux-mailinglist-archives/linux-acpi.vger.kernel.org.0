Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCE1850275
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Jun 2019 08:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbfFXGkP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 Jun 2019 02:40:15 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:19100 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726216AbfFXGkP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 24 Jun 2019 02:40:15 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EEAB5476A3D528FE57DF;
        Mon, 24 Jun 2019 14:40:08 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Mon, 24 Jun 2019
 14:40:06 +0800
Subject: Re: [RFC PATCH] acpi/arm64: ignore 5.1 FADTs that are reported as 5.0
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux-acpi@vger.kernel.org>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <lorenzo.pieralisi@arm.com>,
        <lee.jones@linaro.org>, <leif.lindholm@linaro.org>
References: <20190619121831.7614-1-ard.biesheuvel@linaro.org>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <fe0a8132-27bb-13d5-1753-873fc7bca636@huawei.com>
Date:   Mon, 24 Jun 2019 14:39:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20190619121831.7614-1-ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2019/6/19 20:18, Ard Biesheuvel wrote:
> Some Qualcomm Snapdragon based laptops built to run Microsoft Windows
> are clearly ACPI 5.1 based, given that that is the first ACPI revision
> that supports ARM, and introduced the FADT 'arm_boot_flags' field,
> which has a non-zero field on those systems.
> 
> So in these cases, infer from the ARM boot flags that the FADT must be
> 5.1 or later, and treat it as 5.1.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/kernel/acpi.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index 803f0494dd3e..7722e85fb69c 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -155,10 +155,14 @@ static int __init acpi_fadt_sanity_check(void)
>  	 */
>  	if (table->revision < 5 ||
>  	   (table->revision == 5 && fadt->minor_revision < 1)) {
> -		pr_err("Unsupported FADT revision %d.%d, should be 5.1+\n",
> +		pr_err(FW_BUG "Unsupported FADT revision %d.%d, should be 5.1+\n",
>  		       table->revision, fadt->minor_revision);
> -		ret = -EINVAL;
> -		goto out;
> +
> +		if (!fadt->arm_boot_flags) {
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +		pr_err("FADT has ARM boot flags set, assuming 5.1\n");

Obviously it's a firmware bug, but should be harmless,

Acked-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun

