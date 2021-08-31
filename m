Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 081BE3FC678
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Aug 2021 13:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbhHaLOi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 31 Aug 2021 07:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241517AbhHaLOU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 31 Aug 2021 07:14:20 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33089C061575;
        Tue, 31 Aug 2021 04:13:25 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id i8-20020a056830402800b0051afc3e373aso22254481ots.5;
        Tue, 31 Aug 2021 04:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=918rd/eXmhAOgQRCCgWl26fSBW9V8xpE7yryMPyN/XI=;
        b=hfY2OcBwlmc7QJ5BBqE0OlfukFjrEK3L9lHztC5z5TyJT8tJg6GDiMm21swSvUOfU+
         +39WD7MeKcX6xqTgO3aNwUs9A/t/ObDA1tCMmzX12CaAuWxDIUcZeMQS5DF5DIwWfB13
         eGcS0m6sh9MmWLtt25TFFBAyqfez8nM0FvGgILhSIcUQbmHe45kdM0rayqUMff6xcdbY
         7pfXyxajdHheMY9AwW84iazh5pXxXtbYVYPsljQXmC+Dz5eWKBde0ilOUKyop/P9eHaS
         SzpdqaVs3CPMQ0Z2Y5SRIrsoLWPD9eDoXs3IRD4V67Y5U7wcXH/d8NR/z5XtVQvUD4PI
         Nnpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=918rd/eXmhAOgQRCCgWl26fSBW9V8xpE7yryMPyN/XI=;
        b=DP1BrcxJ1OiRS30SuCdVuOKOOYQVRGd4+qCv252pl2waE4egpTS9kcQ1B7wD0gGSZy
         lXVjeSdw9tna3Mcx47ARDR/4UtRdwPtF1T0Uct3vCdLs7mzBjiMRA4DO8CukJSphPYfC
         BL/VBAgdycIcJlBa0t88iXeAp7YFhSMcBivRnmMH5V7+WZhvtS4lRtGf4CpJv8UZlPV0
         gUTpoj74zD0TX9YydG46YOCX6Ikrw0wOjhW5EYYiWrCwf+pWUow5qHtA68/pC+btkZAU
         MxssZqYM4ttRbgW0h2mp8Il9p8yPv1zbpQPjdYjagg2+a/nSGXCBvv69EA74pLnr/bRy
         WWtw==
X-Gm-Message-State: AOAM531VNiLUqeT4wzYAwFid/s8ae27bkFmhXkOFKnYbqwPzus6sE/Zz
        cngeZ6om5PkrmiNK6QTJ6d8=
X-Google-Smtp-Source: ABdhPJwvHD5edECKZqO4HcwFvJ+MTQUaWQjCQn4VqHvgqsDTRpcRPlpZQivosp7qtUHmwQnIFW1oQw==
X-Received: by 2002:a9d:5d15:: with SMTP id b21mr23657701oti.356.1630408404452;
        Tue, 31 Aug 2021 04:13:24 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c16sm3846746otp.59.2021.08.31.04.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 04:13:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 31 Aug 2021 04:13:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, longman@redhat.com,
        boqun.feng@gmail.com, wangle6@huawei.com, xiaoqian9@huawei.com,
        shaolexi@huawei.com, linux-acpi@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] semaphore: Add might_sleep() to down_*() family
Message-ID: <20210831111322.GA1687117@roeck-us.net>
References: <20210809021215.19991-1-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809021215.19991-1-nixiaoming@huawei.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On Mon, Aug 09, 2021 at 10:12:15AM +0800, Xiaoming Ni wrote:
> Semaphore is sleeping lock. Add might_sleep() to down*() family
> (with exception of down_trylock()) to detect atomic context sleep.
> 
> Previously discussed with Peter Zijlstra, see link:
>  https://lore.kernel.org/lkml/20210806082320.GD22037@worktop.programming.kicks-ass.net
> 
> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
> Acked-by: Will Deacon <will@kernel.org>

This patch results in the following traceback on all arm64 boots with
EFI BIOS.

The problem is only seen with CONFIG_ACPI_PPTT=y, and thus only on arm64.

Guenter

---
[   14.048540] BUG: sleeping function called from invalid context at kernel/locking/semaphore.c:163
[   14.048700] in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 14, name: cpuhp/0
[   14.048865] 2 locks held by cpuhp/0/14:
[   14.048943]  #0: ffff8000125799b0 (cpu_hotplug_lock){++++}-{0:0}, at: cpuhp_thread_fun+0x38/0x254
[   14.049320]  #1: ffff8000125799d8 (cpuhp_state-up){+.+.}-{0:0}, at: cpuhp_thread_fun+0x38/0x254
[   14.049523] irq event stamp: 62
[   14.049580] hardirqs last  enabled at (61): [<ffff800010269690>] finish_task_switch.isra.0+0xd0/0x2f0
[   14.049689] hardirqs last disabled at (62): [<ffff800010313ce8>] generic_exec_single+0x138/0x190
[   14.049785] softirqs last  enabled at (0): [<ffff8000102245d4>] copy_process+0x634/0x1af4
[   14.049876] softirqs last disabled at (0): [<0000000000000000>] 0x0
[   14.050299] CPU: 0 PID: 14 Comm: cpuhp/0 Not tainted 5.14.0-01100-gb91db6a0b52e #1
[   14.050452] Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
[   14.050694] Call trace:
[   14.050753]  dump_backtrace+0x0/0x19c
[   14.050839]  show_stack+0x1c/0x30
[   14.050892]  dump_stack_lvl+0x9c/0xd8
[   14.050949]  dump_stack+0x1c/0x38
[   14.050999]  ___might_sleep+0x154/0x200
[   14.051053]  __might_sleep+0x54/0x90
[   14.051106]  down_timeout+0x34/0x90
[   14.051159]  acpi_os_wait_semaphore+0x68/0x9c
[   14.051218]  acpi_ut_acquire_mutex+0x50/0xbc
[   14.051277]  acpi_get_table+0x3c/0xc0
[   14.051330]  acpi_find_last_cache_level+0x44/0x12c
[   14.051391]  _init_cache_level+0xd8/0xe4
[   14.051446]  generic_exec_single+0xf8/0x190
[   14.051502]  smp_call_function_single+0x174/0x1e0
[   14.051561]  init_cache_level+0x30/0x60
[   14.051614]  cacheinfo_cpu_online+0x28/0x840
[   14.051675]  cpuhp_invoke_callback+0x168/0x2ac
[   14.051751]  cpuhp_thread_fun+0x198/0x254
[   14.051810]  smpboot_thread_fn+0x200/0x2c0
[   14.051867]  kthread+0x164/0x170
[   14.051921]  ret_from_fork+0x10/0x18
