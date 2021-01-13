Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 647D12F4696
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Jan 2021 09:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725681AbhAMIdB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 13 Jan 2021 03:33:01 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10720 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbhAMIdB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Jan 2021 03:33:01 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DG0yY4d6tzl4W1;
        Wed, 13 Jan 2021 16:31:01 +0800 (CST)
Received: from [10.174.178.147] (10.174.178.147) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Wed, 13 Jan 2021 16:32:11 +0800
Subject: Re: [PATCH] ACPI: configfs: add missing check after
 configfs_register_default_group
To:     Qinglang Miao <miaoqinglang@huawei.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210113073058.79506-1-miaoqinglang@huawei.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <7e56bf92-9300-b685-10e0-1e2551a42f36@huawei.com>
Date:   Wed, 13 Jan 2021 16:32:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20210113073058.79506-1-miaoqinglang@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.147]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021/1/13 15:30, Qinglang Miao wrote:
> A list_add corruption is reported by Hulk Robot like this:
> ==============
> list_add corruption.
> Call Trace:
> link_obj+0xc0/0x1c0
> link_group+0x21/0x140
> configfs_register_subsystem+0xdb/0x380
> acpi_configfs_init+0x25/0x1000 [acpi_configfs]
> do_one_initcall+0x149/0x820
> do_init_module+0x1ef/0x720
> load_module+0x35c8/0x4380
> __do_sys_finit_module+0x10d/0x1a0
> do_syscall_64+0x34/0x80
> 
> It's because of the missing check after configfs_register_default_group,
> where configfs_unregister_subsystem should be called once failure.

I think it's right to call *_unregister_* for error path, but...

> 
> Fixes: 612bd01fc6e0 ("ACPI: add support for loading SSDTs via configfs")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---
>   drivers/acpi/acpi_configfs.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/acpi_configfs.c b/drivers/acpi/acpi_configfs.c
> index cf91f4910..25512ab0e 100644
> --- a/drivers/acpi/acpi_configfs.c
> +++ b/drivers/acpi/acpi_configfs.c
> @@ -268,7 +268,12 @@ static int __init acpi_configfs_init(void)
>   
>   	acpi_table_group = configfs_register_default_group(root, "table",
>   							   &acpi_tables_type);
> -	return PTR_ERR_OR_ZERO(acpi_table_group);
> +	if (IS_ERR(acpi_table_group)) {
> +		configfs_register_subsystem(&acpi_configfs);

...

Typo here, s/register/unregister.

Thanks
Hanjun
