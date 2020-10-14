Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 022C828D79D
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Oct 2020 02:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgJNAnJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 13 Oct 2020 20:43:09 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:60456 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727837AbgJNAnI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 13 Oct 2020 20:43:08 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 160EB44ABE733EDAB73A;
        Wed, 14 Oct 2020 08:43:05 +0800 (CST)
Received: from [10.174.179.182] (10.174.179.182) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Wed, 14 Oct 2020 08:43:02 +0800
Subject: Re: [PATCHv2] ACPI: debug: don't allow debugging when ACPI is
 disabled
To:     Jamie Iles <jamie@nuviainc.com>, <linux-acpi@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <20201009152116.35184-1-jamie@nuviainc.com>
 <20201012130446.57325-1-jamie@nuviainc.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <b332a42a-cb5d-ad2a-99f5-77df748c343a@huawei.com>
Date:   Wed, 14 Oct 2020 08:43:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201012130446.57325-1-jamie@nuviainc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.182]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020/10/12 21:04, Jamie Iles wrote:
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
> 
> This is because acpi_debugger.lock has not been initialized as
> acpi_debugger_init() is not called when ACPI is disabled.  Fail module
> loading to avoid this and any subsequent problems that might arise by
> trying to debug AML when ACPI is disabled.
> 
> Fixes: 8cfb0cdf07e2 ("ACPI / debugger: Add IO interface to access debugger functionalities")
> Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

My review still valid, thanks!

Hanjun
