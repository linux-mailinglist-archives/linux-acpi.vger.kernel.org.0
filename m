Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C994F399758
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Jun 2021 03:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhFCBDv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Jun 2021 21:03:51 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2969 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhFCBDv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jun 2021 21:03:51 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FwSG03Xtsz6tmc;
        Thu,  3 Jun 2021 08:59:04 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 3 Jun 2021 09:02:02 +0800
Received: from [10.174.179.71] (10.174.179.71) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 3 Jun 2021 09:02:02 +0800
Subject: Re: [PATCH v2] ACPI: FPDT: Add the missed acpi_put_table() in
 acpi_init_fpdt()
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>, <rjw@rjwysocki.net>,
        <lenb@kernel.org>, <rui.zhang@intel.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210602115812.109900-1-jingxiangfeng@huawei.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <bef2506e-7f65-199d-92b4-45314701523d@huawei.com>
Date:   Thu, 3 Jun 2021 09:02:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20210602115812.109900-1-jingxiangfeng@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.71]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021/6/2 19:58, Jing Xiangfeng wrote:
> acpi_init_fpdt() misses to call acpi_put_table() in an error path. Add
> the missed function call to fix it.
> 
> Fixes: d1eb86e59be0 ("ACPI: tables: introduce support for FPDT table")
> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
> Acked-by: Zhang Rui <rui.zhang@intel.com>
> ---
> v1 -> v2:
> - Collect Acked-by tag by Zhang Rui.
> - retitle the subject as suggested by Hanjun Guo.
> ---
>   drivers/acpi/acpi_fpdt.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/acpi_fpdt.c b/drivers/acpi/acpi_fpdt.c
> index a89a806a7a2a..4ee2ad234e3d 100644
> --- a/drivers/acpi/acpi_fpdt.c
> +++ b/drivers/acpi/acpi_fpdt.c
> @@ -240,8 +240,10 @@ static int __init acpi_init_fpdt(void)
>   		return 0;
>   
>   	fpdt_kobj = kobject_create_and_add("fpdt", acpi_kobj);
> -	if (!fpdt_kobj)
> +	if (!fpdt_kobj) {
> +		acpi_put_table(header);
>   		return -ENOMEM;
> +	}
>   
>   	while (offset < header->length) {
>   		subtable = (void *)header + offset;

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
