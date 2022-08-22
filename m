Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9EEA59C45A
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Aug 2022 18:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235136AbiHVQo1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 Aug 2022 12:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbiHVQo0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Aug 2022 12:44:26 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1B0101D4
        for <linux-acpi@vger.kernel.org>; Mon, 22 Aug 2022 09:44:25 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-33365a01f29so310122017b3.2
        for <linux-acpi@vger.kernel.org>; Mon, 22 Aug 2022 09:44:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=y7MSsM2ftIzui/wQvodif6u8Cen1K0OOlax9HJdqI7o=;
        b=qWEnEKtBt8BTc2UOiQYQA73gARTAIDtAGVtvsblgvRmlhJPPYz+s9TF8CCaMaovYJX
         l4VNrJ2esLSnmBmXGInVz7E/XF4Z3EaBUJGJJcA26hbQUSNFvCRS2Trb2R5EX2+0s7KB
         XPF1k9CtgDtmxzpSleHhxUdAYIuyQE1B9DJ1nAKH+YZn8oI6lTiV8IDxDSKUfwbWjwl/
         T/a+29mEjcbHd6//z1MrLyRpBTlncOynz6CknabcTvGpG0Zu3vGS+lSmEda1aX3kflaS
         63X7raVWZQPfRxCH31Mtz5FP+FHRAvS2ToAItVwGocVWFLf9Bb4gEsndDMeMlOXoPlvV
         a9aw==
X-Gm-Message-State: ACgBeo2aW4zUEafhX89+zTssnn2Y4M8i9wicNhdxkYh2PSYqKGluPxjd
        ZdjCAaKpspFBaX3GCIaT3XglQFvU80956g59/VSuMRS3CHo=
X-Google-Smtp-Source: AA6agR4eLp9hWz3HZaw8bBgZW3xjbsrM2yCKAbc0kfeVbohXn1aCMUkkmunvoERVyD8TWt9MWTRzlfcSZ9b20n8mxVY=
X-Received: by 2002:a0d:f647:0:b0:328:317c:9069 with SMTP id
 g68-20020a0df647000000b00328317c9069mr20875188ywf.301.1661186664193; Mon, 22
 Aug 2022 09:44:24 -0700 (PDT)
MIME-Version: 1.0
References: <YwDsy3ZUgTtlKH9r@zx2c4.com>
In-Reply-To: <YwDsy3ZUgTtlKH9r@zx2c4.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 22 Aug 2022 18:44:13 +0200
Message-ID: <CAJZ5v0jdOguaacSzB1jxQZVoJ3RSjZY1M07XdKHmLv6EpoqX_A@mail.gmail.com>
Subject: Re: null ptr deref in __power_supply_is_system_supplied
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
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

On Sat, Aug 20, 2022 at 4:17 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hi,
>
> With 963a70bee5880640d0fd83ed29dc1e7ec0d2bd4a, I'm seeing this OOOPs
> from __power_supply_is_system_supplied:
>
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> #PF: supervisor instruction fetch in kernel mode
> #PF: error_code(0x0010) - not-present page
> PGD 0 P4D 0
> Oops: 0010 [#1] PREEMPT SMP
> CPU: 14 PID: 1156 Comm: upowerd Tainted: G S   U             6.0.0-rc1+ #366
> Hardware name: LENOVO 20Y5CTO1WW/20Y5CTO1WW, BIOS N40ET36W (1.18 ) 07/19/2022
> RIP: 0010:0x0
> Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
> RSP: 0018:ffff88815350bd08 EFLAGS: 00010212
> RAX: ffff88810207d620 RBX: ffff88815350bd7c RCX: 000000000000394e
> RDX: ffff88815350bd10 RSI: 0000000000000004 RDI: ffff888111722c00
> RBP: ffff88815350bd68 R08: ffff8881187a8af8 R09: ffff8881187a8af8
> R10: 0000000000000000 R11: 000000000000005f R12: ffffffff8162d0b0
> R13: ffff88810159a038 R14: ffffffff823b3768 R15: ffff88810159a000
> FS:  00007fd1f0958140(0000) GS:ffff88901f780000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffffffffffd6 CR3: 0000000152c7a004 CR4: 0000000000770ee0
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  __power_supply_is_system_supplied+0x26/0x40

It looks like __power_supply_is_system_supplied() should test psy
against NULL, but I'm not sure why that wasn't necessary before.

Neither the ACPI battery nor the ACPI AC driver has changed since 5.19 FWIW.

>  class_for_each_device+0xa5/0xd0
>  ? acpi_battery_get_state+0x4e/0x1f0
>  power_supply_is_system_supplied+0x26/0x40
>  acpi_battery_get_property+0x301/0x310
>  power_supply_show_property+0xa5/0x1d0
>  dev_attr_show+0x10/0x30
>  sysfs_kf_seq_show+0x78/0xc0
>  seq_read_iter+0xfd/0x3e0
>  vfs_read+0x1cb/0x290
>  ksys_read+0x4e/0xc0
>  do_syscall_64+0x2b/0x50
>  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> RIP: 0033:0x7fd1f0bed70c
> Code: ec 28 48 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 39 a4 f8 ff 41 89 c0 48 8b 54 24 18 48 8b 74 24 10 8b 7c 24 08 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 34 44 89 c7 48 89 44 24 08 e8 8f a4 f8 ff 48
> RSP: 002b:00007ffc8d3f27e0 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fd1f0bed70c
> RDX: 0000000000001000 RSI: 000055957d534850 RDI: 000000000000000c
> RBP: 000055957d50b1d0 R08: 0000000000000000 R09: 0000000000001000
> R10: 000000000000006f R11: 0000000000000246 R12: 00007ffc8d3f2910
> R13: 0000000000000000 R14: 0000000000000000 R15: 000000000000000c
>  </TASK>
> Modules linked in: rfcomm snd_seq_dummy snd_hrtimer snd_seq snd_seq_device cmac algif_skcipher bnep uvcvideo videobuf2_vmalloc btusb videobuf2_memops videobuf2_v4l2 btintel videobuf2_common bluetooth video>
>  i2c_designware_platform i2c_designware_core snd_hda_intel i2c_algo_bit drm_buddy snd_intel_dspcfg kvm_intel spi_nor intel_gtt think_lmi snd_intel_sdw_acpi mtd mei_pxp mei_hdcp firmware_attributes_class wm>
>
> CR2: 0000000000000000
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:0x0
> Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
> RSP: 0018:ffff88815350bd08 EFLAGS: 00010212
> RAX: ffff88810207d620 RBX: ffff88815350bd7c RCX: 000000000000394e
> RDX: ffff88815350bd10 RSI: 0000000000000004 RDI: ffff888111722c00
> RBP: ffff88815350bd68 R08: ffff8881187a8af8 R09: ffff8881187a8af8
> R10: 0000000000000000 R11: 000000000000005f R12: ffffffff8162d0b0
> R13: ffff88810159a038 R14: ffffffff823b3768 R15: ffff88810159a000
> FS:  00007fd1f0958140(0000) GS:ffff88901f780000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffffffffffd6 CR3: 0000000152c7a004 CR4: 0000000000770ee0
> PKRU: 55555554
>
> Regards,
> Jason
