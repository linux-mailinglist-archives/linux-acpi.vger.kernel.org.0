Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9458E289E1A
	for <lists+linux-acpi@lfdr.de>; Sat, 10 Oct 2020 05:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730158AbgJJD7M (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 9 Oct 2020 23:59:12 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14812 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730804AbgJJDoo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 9 Oct 2020 23:44:44 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B0AB2AF1BF5D965DD835;
        Sat, 10 Oct 2020 11:27:23 +0800 (CST)
Received: from [10.174.179.182] (10.174.179.182) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Sat, 10 Oct 2020 11:27:20 +0800
Subject: Re: [PATCH] ACPI: debug: don't allow debugging when ACPI is disabled
To:     Jamie Iles <jamie@nuviainc.com>, <linux-acpi@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <20201009152116.35184-1-jamie@nuviainc.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <e3186f7c-a873-5176-e247-24bcb7d4a866@huawei.com>
Date:   Sat, 10 Oct 2020 11:27:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201009152116.35184-1-jamie@nuviainc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.182]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020/10/9 23:21, Jamie Iles wrote:
> If ACPI is disabled then loading the acpi_dbg module will result in the
> following splat when lock debugging is enabled.
> 
>    DEBUG_LOCKS_WARN_ON(lock->magic != lock)
>    WARNING: CPU: 0 PID: 1 at kernel/locking/mutex.c:938 __mutex_lock+0xa10/0x1290
>    Kernel panic - not syncing: panic_on_warn set ...
>    CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.9.0-rc8+ #103
>    Hardware name: linux,dummy-virt (DT)
>    Call trace:
>     dump_backtrace+0x0/0x4d8
>     show_stack+0x34/0x48
>     dump_stack+0x174/0x1f8
>     panic+0x360/0x7a0
>     __warn+0x244/0x2ec
>     report_bug+0x240/0x398
>     bug_handler+0x50/0xc0
>     call_break_hook+0x160/0x1d8
>     brk_handler+0x30/0xc0
>     do_debug_exception+0x184/0x340
>     el1_dbg+0x48/0xb0
>     el1_sync_handler+0x170/0x1c8
>     el1_sync+0x80/0x100
>     __mutex_lock+0xa10/0x1290
>     mutex_lock_nested+0x6c/0xc0
>     acpi_register_debugger+0x40/0x88
>     acpi_aml_init+0xc4/0x114
>     do_one_initcall+0x24c/0xb10
>     kernel_init_freeable+0x690/0x728
>     kernel_init+0x20/0x1e8
>     ret_from_fork+0x10/0x18

That's because the mutex acpi_debugger.lock will not be initialized
as acpi_debugger_init() is not called if ACPI is disabled.

If you add above commit log then make it easier to be understood.

> 
> Fail module loading to avoid this and any subsequent problems that might
> arise by trying to debug AML when ACPI is disabled.
> 

It's better to add a fix tag:

Fixes: 8cfb0cdf07e2 ("ACPI / debugger: Add IO interface to access 
debugger functionalities")

> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Jamie Iles <jamie@nuviainc.com>
> ---
>   drivers/acpi/acpi_dbg.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/acpi/acpi_dbg.c b/drivers/acpi/acpi_dbg.c
> index 6041974c7627..fb7290338593 100644
> --- a/drivers/acpi/acpi_dbg.c
> +++ b/drivers/acpi/acpi_dbg.c
> @@ -749,6 +749,9 @@ static int __init acpi_aml_init(void)
>   {
>   	int ret;
>   
> +	if (acpi_disabled)
> +		return -ENODEV;
> +
>   	/* Initialize AML IO interface */
>   	mutex_init(&acpi_aml_io.lock);
>   	init_waitqueue_head(&acpi_aml_io.wait);

With above comments addressed, feel free to add

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun
