Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826E03FC6AF
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Aug 2021 14:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236281AbhHaLkG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 31 Aug 2021 07:40:06 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:15275 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbhHaLkG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 31 Aug 2021 07:40:06 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GzQF30V6mz87yl;
        Tue, 31 Aug 2021 19:38:47 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 31 Aug 2021 19:39:08 +0800
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 31 Aug 2021 19:39:07 +0800
Subject: Re: [PATCH] semaphore: Add might_sleep() to down_*() family
To:     Guenter Roeck <linux@roeck-us.net>,
        Xiaoming Ni <nixiaoming@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <peterz@infradead.org>,
        <mingo@redhat.com>, <will@kernel.org>, <longman@redhat.com>,
        <boqun.feng@gmail.com>, <wangle6@huawei.com>,
        <xiaoqian9@huawei.com>, <shaolexi@huawei.com>,
        <linux-acpi@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Xiongfeng Wang" <wangxiongfeng2@huawei.com>
References: <20210809021215.19991-1-nixiaoming@huawei.com>
 <20210831111322.GA1687117@roeck-us.net>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <9471f03d-942d-2143-5d87-8ec98bc38ec3@huawei.com>
Date:   Tue, 31 Aug 2021 19:39:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20210831111322.GA1687117@roeck-us.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.247]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Guenter,

On 2021/8/31 19:13, Guenter Roeck wrote:
> Hi,
> 
> On Mon, Aug 09, 2021 at 10:12:15AM +0800, Xiaoming Ni wrote:
>> Semaphore is sleeping lock. Add might_sleep() to down*() family
>> (with exception of down_trylock()) to detect atomic context sleep.
>>
>> Previously discussed with Peter Zijlstra, see link:
>>   https://lore.kernel.org/lkml/20210806082320.GD22037@worktop.programming.kicks-ass.net
>>
>> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
>> Acked-by: Will Deacon <will@kernel.org>
> 
> This patch results in the following traceback on all arm64 boots with
> EFI BIOS.
> 
> The problem is only seen with CONFIG_ACPI_PPTT=y, and thus only on arm64.

I Cced Xiongfeng, he sent a patch to fix this issue over a month ago:

https://lore.kernel.org/linux-arm-kernel/20210720112635.38565-1-wangxiongfeng2@huawei.com/T/

and the calltrace is exactly the same as below.

Sudeep, would you mind take a look again?

> ---
> [   14.048540] BUG: sleeping function called from invalid context at kernel/locking/semaphore.c:163
> [   14.048700] in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 14, name: cpuhp/0
> [   14.048865] 2 locks held by cpuhp/0/14:
> [   14.048943]  #0: ffff8000125799b0 (cpu_hotplug_lock){++++}-{0:0}, at: cpuhp_thread_fun+0x38/0x254
> [   14.049320]  #1: ffff8000125799d8 (cpuhp_state-up){+.+.}-{0:0}, at: cpuhp_thread_fun+0x38/0x254
> [   14.049523] irq event stamp: 62
> [   14.049580] hardirqs last  enabled at (61): [<ffff800010269690>] finish_task_switch.isra.0+0xd0/0x2f0
> [   14.049689] hardirqs last disabled at (62): [<ffff800010313ce8>] generic_exec_single+0x138/0x190
> [   14.049785] softirqs last  enabled at (0): [<ffff8000102245d4>] copy_process+0x634/0x1af4
> [   14.049876] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [   14.050299] CPU: 0 PID: 14 Comm: cpuhp/0 Not tainted 5.14.0-01100-gb91db6a0b52e #1
> [   14.050452] Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
> [   14.050694] Call trace:
> [   14.050753]  dump_backtrace+0x0/0x19c
> [   14.050839]  show_stack+0x1c/0x30
> [   14.050892]  dump_stack_lvl+0x9c/0xd8
> [   14.050949]  dump_stack+0x1c/0x38
> [   14.050999]  ___might_sleep+0x154/0x200
> [   14.051053]  __might_sleep+0x54/0x90
> [   14.051106]  down_timeout+0x34/0x90
> [   14.051159]  acpi_os_wait_semaphore+0x68/0x9c
> [   14.051218]  acpi_ut_acquire_mutex+0x50/0xbc
> [   14.051277]  acpi_get_table+0x3c/0xc0
> [   14.051330]  acpi_find_last_cache_level+0x44/0x12c
> [   14.051391]  _init_cache_level+0xd8/0xe4
> [   14.051446]  generic_exec_single+0xf8/0x190
> [   14.051502]  smp_call_function_single+0x174/0x1e0
> [   14.051561]  init_cache_level+0x30/0x60
> [   14.051614]  cacheinfo_cpu_online+0x28/0x840
> [   14.051675]  cpuhp_invoke_callback+0x168/0x2ac
> [   14.051751]  cpuhp_thread_fun+0x198/0x254
> [   14.051810]  smpboot_thread_fn+0x200/0x2c0
> [   14.051867]  kthread+0x164/0x170
> [   14.051921]  ret_from_fork+0x10/0x18

Thanks
Hanjun
