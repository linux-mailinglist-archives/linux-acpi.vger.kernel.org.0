Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9705B4777
	for <lists+linux-acpi@lfdr.de>; Sat, 10 Sep 2022 18:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbiIJQUa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 10 Sep 2022 12:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiIJQU3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 10 Sep 2022 12:20:29 -0400
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC77326D5
        for <linux-acpi@vger.kernel.org>; Sat, 10 Sep 2022 09:20:28 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id f131so6873597ybf.7
        for <linux-acpi@vger.kernel.org>; Sat, 10 Sep 2022 09:20:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=RxwHULUz+yfFUq9wkbCNzshXlUm7KouABV9q5mOIj5s=;
        b=c3PLk72WgLAJp83jRK6/xPVlyiHSaUXDgpPPAOB+pk6kLR27FkdEUz7VUvdcTsvBDK
         OLkmMPF5hSRn0uMuqwl1LdveLl8TYsnswHeF6u030j0ajjdIJeUIzhLbS7FgHkStVnVm
         ukxlZxaUAOrf8qfpmQwnf2pH4VwIPcQ6d/J1asrQDK+ad1yHpTJ/TyytGD8vyBTrSMHe
         2Dd2Spia+IikN8qsWXlGNf+D6LhAq9PnGSbZ8WbtLht+Dg4AtvT+AVz12CY6hVbm+/3+
         SnuTaK80ZhivQDAk/YZYIIKlPvth9xCFRADXbrH8f9Vtb2UyAEB2yEp2gjFWghp73ew5
         ogjA==
X-Gm-Message-State: ACgBeo11FiRUSb/gCCye6g2Y1yHDTLYEXH2ObTndsr7wxhV5OYyHg+Fl
        TjkWE1VFcjU6fwldVc7aTpIsUxCh1qN2d9eqpZE=
X-Google-Smtp-Source: AA6agR6t46HVPb42THqrAy9buUWDkmADGehEpTSUNUxyuDyRz7yVWrOpNHI6PkaWNA8LUd4wSY4OToMOrWdP+5J7owA=
X-Received: by 2002:a25:ec09:0:b0:6ad:804f:5463 with SMTP id
 j9-20020a25ec09000000b006ad804f5463mr13402595ybh.622.1662826827284; Sat, 10
 Sep 2022 09:20:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220905123412.465162-1-hdegoede@redhat.com>
In-Reply-To: <20220905123412.465162-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 10 Sep 2022 18:20:16 +0200
Message-ID: <CAJZ5v0iUBcQSfYRKyZmyP9Q_6AccWoczfKDtvD5inmbRFUhDOA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: tables: FPDT: Don't call acpi_os_map_memory() on
 invalid phys address
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 5, 2022 at 2:41 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> On a Packard Bell Dot SC (Intel Atom N2600 model) there is a FPDT table
> which contains invalid physical addresses, with high bits set which fall
> outside the range of the CPU-s supported physical address range.
>
> Calling acpi_os_map_memory() on such an invalid phys address leads to
> the below WARN_ON in ioremap triggering resulting in an oops/stacktrace.
>
> Add code to verify the physical address before calling acpi_os_map_memory()
> to fix / avoid the oops.
>
> [    1.226900] ioremap: invalid physical address 3001000000000000
> [    1.226949] ------------[ cut here ]------------
> [    1.226962] WARNING: CPU: 1 PID: 1 at arch/x86/mm/ioremap.c:200 __ioremap_caller.cold+0x43/0x5f
> [    1.226996] Modules linked in:
> [    1.227016] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.0.0-rc3+ #490
> [    1.227029] Hardware name: Packard Bell dot s/SJE01_CT, BIOS V1.10 07/23/2013
> [    1.227038] RIP: 0010:__ioremap_caller.cold+0x43/0x5f
> [    1.227054] Code: 96 00 00 e9 f8 af 24 ff 89 c6 48 c7 c7 d8 0c 84 99 e8 6a 96 00 00 e9 76 af 24 ff 48 89 fe 48 c7 c7 a8 0c 84 99 e8 56 96 00 00 <0f> 0b e9 60 af 24 ff 48 8b 34 24 48 c7 c7 40 0d 84 99 e8 3f 96 00
> [    1.227067] RSP: 0000:ffffb18c40033d60 EFLAGS: 00010286
> [    1.227084] RAX: 0000000000000032 RBX: 3001000000000000 RCX: 0000000000000000
> [    1.227095] RDX: 0000000000000001 RSI: 00000000ffffdfff RDI: 00000000ffffffff
> [    1.227105] RBP: 3001000000000000 R08: 0000000000000000 R09: ffffb18c40033c18
> [    1.227115] R10: 0000000000000003 R11: ffffffff99d62fe8 R12: 0000000000000008
> [    1.227124] R13: 0003001000000000 R14: 0000000000001000 R15: 3001000000000000
> [    1.227135] FS:  0000000000000000(0000) GS:ffff913a3c080000(0000) knlGS:0000000000000000
> [    1.227146] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.227156] CR2: 0000000000000000 CR3: 0000000018c26000 CR4: 00000000000006e0
> [    1.227167] Call Trace:
> [    1.227176]  <TASK>
> [    1.227185]  ? acpi_os_map_iomem+0x1c9/0x1e0
> [    1.227215]  ? kmem_cache_alloc_trace+0x187/0x370
> [    1.227254]  acpi_os_map_iomem+0x1c9/0x1e0
> [    1.227288]  acpi_init_fpdt+0xa8/0x253
> [    1.227308]  ? acpi_debugfs_init+0x1f/0x1f
> [    1.227339]  do_one_initcall+0x5a/0x300
> [    1.227406]  ? rcu_read_lock_sched_held+0x3f/0x80
> [    1.227442]  kernel_init_freeable+0x28b/0x2cc
> [    1.227512]  ? rest_init+0x170/0x170
> [    1.227538]  kernel_init+0x16/0x140
> [    1.227552]  ret_from_fork+0x1f/0x30
> [    1.227639]  </TASK>
> [    1.227647] irq event stamp: 186819
> [    1.227656] hardirqs last  enabled at (186825): [<ffffffff98184a6e>] __up_console_sem+0x5e/0x70
> [    1.227672] hardirqs last disabled at (186830): [<ffffffff98184a53>] __up_console_sem+0x43/0x70
> [    1.227686] softirqs last  enabled at (186576): [<ffffffff980fbc9d>] __irq_exit_rcu+0xed/0x160
> [    1.227701] softirqs last disabled at (186569): [<ffffffff980fbc9d>] __irq_exit_rcu+0xed/0x160
> [    1.227715] ---[ end trace 0000000000000000 ]---
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/acpi_fpdt.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/drivers/acpi/acpi_fpdt.c b/drivers/acpi/acpi_fpdt.c
> index 6922a44b3ce7..a2056c4c8cb7 100644
> --- a/drivers/acpi/acpi_fpdt.c
> +++ b/drivers/acpi/acpi_fpdt.c
> @@ -143,6 +143,23 @@ static const struct attribute_group boot_attr_group = {
>
>  static struct kobject *fpdt_kobj;
>
> +#if defined CONFIG_X86 && defined CONFIG_PHYS_ADDR_T_64BIT
> +#include <linux/processor.h>
> +static bool fpdt_address_valid(u64 address)
> +{
> +       /*
> +        * On some systems the table contains invalid addresses
> +        * with unsuppored high address bits set, check for this.
> +        */
> +       return !(address >> boot_cpu_data.x86_phys_bits);
> +}
> +#else
> +static bool fpdt_address_valid(u64 address)
> +{
> +       return true;
> +}
> +#endif
> +
>  static int fpdt_process_subtable(u64 address, u32 subtable_type)
>  {
>         struct fpdt_subtable_header *subtable_header;
> @@ -151,6 +168,11 @@ static int fpdt_process_subtable(u64 address, u32 subtable_type)
>         u32 length, offset;
>         int result;
>
> +       if (!fpdt_address_valid(address)) {
> +               pr_info(FW_BUG "invalid physical address: 0x%llx!\n", address);
> +               return -EINVAL;
> +       }
> +
>         subtable_header = acpi_os_map_memory(address, sizeof(*subtable_header));
>         if (!subtable_header)
>                 return -ENOMEM;
> --

Applied as 6.1 material, thanks!
