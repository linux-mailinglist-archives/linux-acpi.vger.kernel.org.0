Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A313D0661
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jul 2021 03:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhGUAoy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 20 Jul 2021 20:44:54 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:15043 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbhGUAot (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Jul 2021 20:44:49 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GTyVL414SzZr4q;
        Wed, 21 Jul 2021 09:22:02 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 21 Jul 2021 09:25:25 +0800
Received: from [10.174.179.5] (10.174.179.5) by dggpemm500002.china.huawei.com
 (7.185.36.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 21 Jul
 2021 09:25:24 +0800
Subject: Re: [PATCH] ACPI / PPTT: get PPTT table in the first beginning
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>, <rjw@rjwysocki.net>,
        <viresh.kumar@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <guohanjun@huawei.com>
References: <20210720112635.38565-1-wangxiongfeng2@huawei.com>
 <20210720133751.u6k6bdm7qco3gn65@bogus>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <1c9112c0-8a3e-e82e-8c88-377e3d4e9e18@huawei.com>
Date:   Wed, 21 Jul 2021 09:25:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20210720133751.u6k6bdm7qco3gn65@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.5]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Sudeep,

On 2021/7/20 21:37, Sudeep Holla wrote:
> On Tue, Jul 20, 2021 at 07:26:35PM +0800, Xiongfeng Wang wrote:
>> When I added might_sleep() in down_timeout(), I got the following
> 
> Sorry it is not clear if you are able to reproduce this issue without
> any other modifications in the mainline kernel ?

Without any modifications, the mainline kernel does not print the Calltrace. But
the risk of sleeping in atomic context still exists.

> 
>> Calltrace:
>>
>> [    8.775671] BUG: sleeping function called from invalid context at kernel/locking/semaphore.c:160
>> [    8.777070] in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 14, name: cpuhp/0
> 
>>From this I guess you are adding sleep after raw_spin_lock_irqsave
> in down_timeout(kernel/locking/semaphore.c).

I add 'might_sleep()' which is used to check whether there are problems if I
sleep here. It's not a real sleep.

The Document for might_sleep is as below.
/**
 * might_sleep - annotation for functions that can sleep

 *
 * this macro will print a stack trace if it is executed in an atomic
 * context (spinlock, irq-handler, ...). Additional sections where blocking is
 * not allowed can be annotated with non_block_start() and non_block_end()
 * pairs.
 *
 * This is a useful debugging help to be able to catch problems early and not
 * be bitten later when the calling function happens to sleep when it is not
 * supposed to.
 */

> 
>>
>> It is because generic_exec_single() will disable local irq before
>> calling _init_cache_level(). _init_cache_level() use acpi_get_table() to
>> get the PPTT table, but this function could schedule out.
>>
>> To fix this issue, we use a static pointer to record the mapped PPTT
>> table in the first beginning. Later, we use that pointer to reference
>> the PPTT table in acpi_find_last_cache_level(). We also modify other
>> functions in pptt.c to use the pointer to reference PPTT table.

The main problem is that we called local_irq_save() in generic_exec_single(),
and then we called down_timeout() in acpi_os_wait_semaphore(). down_timeout()
could enter into sleep if failed to acquire the semaphore. There are risks of
sleeping in irq disabled context.

Thanks,
Xiongfeng

>>
> 
> I don't follow this change at all.
> 
