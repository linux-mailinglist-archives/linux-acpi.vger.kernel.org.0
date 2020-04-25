Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 018D31B8982
	for <lists+linux-acpi@lfdr.de>; Sat, 25 Apr 2020 23:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbgDYVId (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 25 Apr 2020 17:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbgDYVIc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 25 Apr 2020 17:08:32 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87846C09B04D
        for <linux-acpi@vger.kernel.org>; Sat, 25 Apr 2020 14:08:32 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id c16so12935326ilr.3
        for <linux-acpi@vger.kernel.org>; Sat, 25 Apr 2020 14:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=BrkAn6lspxdMbSEgORFolb8tSQq4L0hmOBG3ueN/KhU=;
        b=Io7pvbXhNuQAJfP/ukDs2dRW6p5O1O02UYVGVE+YYRIcymH+WzStkta7OJSys5+0BG
         vi3JC1JH1z/GjsmcO0wf2Lj9abqyHP5xJ58rsAxH3tpz2ezi9YDDv1RPLImapcXbPzCT
         BrRJ1+6BL5vypfozKaUuEHmrLuxHVnnEMsLFi7L9WqYBU5gxheo2OqTZiWamCu0MHjWk
         tn0XAuiIv+nrlwVdxOBah/uQWtTF2LPphOhFYwYAH76JVyK1C+mFUd5gcBQW3xLlsnyw
         h6LsxFpVpMsgYC7mlRs96pXppl4YoXKl6tGPATy9twj5/732uQnr9nKCVDf/SN9XVAcR
         clJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=BrkAn6lspxdMbSEgORFolb8tSQq4L0hmOBG3ueN/KhU=;
        b=EbQPAuBWyhkey9Mll4IAPAgOSJPH0Curkv3AXQkzokJ3K2DO0pAH+oNggEVHr2+QYA
         BMEuRRnemNQMBHhAEoBWM9C/K4Cn8xFDEbBSK4n+Pe6zWUAl/T9NVy4ddLv8t53WJD2p
         VVIf40g11deIuj/pu5gV27AIVS/M3Sjb5vCN7dSwe6xg7Fv9S8wCc0l805CWPUIEZogn
         9DxZ+DYaW0vO+KalQwulwN9b1wnNTiucq7J2PK3wSCLpiWgXd6zgSnDcuMwU6T8ztCee
         pBnM+EZT5smEdNrfrSR5LugCyqXrsPFn5bvvN5udivvMOIbW2iECxmPAUUY0OaJxzhoo
         nSnA==
X-Gm-Message-State: AGi0Pub0azOgzRC5U6mDRhRrExziNmpXS9C4wLIjmVRpMzPzZjGstuGs
        l33ogDxpOQaSYt1xoZLwYpm3buxFGiSfJppgrsLQU1Ejhjg=
X-Google-Smtp-Source: APiQypIbBvO7xrXNU9i4Egwl6n9siYs0IvPLahJy+B9Udx33gjgDj1BFg2xIJW87KpJa9aA/j4ACn8I5RT1OaFcMNeA=
X-Received: by 2002:a92:8c90:: with SMTP id s16mr14878016ill.164.1587848911267;
 Sat, 25 Apr 2020 14:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <CACAwPwbOwaMOnwOWVVcs4O7xdb8AcOSSr6VBZ1Bg1a_mz8ub2g@mail.gmail.com>
In-Reply-To: <CACAwPwbOwaMOnwOWVVcs4O7xdb8AcOSSr6VBZ1Bg1a_mz8ub2g@mail.gmail.com>
From:   Maxim Levitsky <maximlevitsky@gmail.com>
Date:   Sun, 26 Apr 2020 00:08:19 +0300
Message-ID: <CACAwPwb=fVajwLWhokQKH4bvDtXd6P0zQc70QfsV8rz4QgyvBg@mail.gmail.com>
Subject: Re: Firmware bug: ACPI interrupt gets disabled after resume from ram
 when triggered by #PME
To:     linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

FYI: I went through list of the kernel parameters and stumbled upon
this parameter 'pcie_port_pm=off'
It made the problem disappear, but it is probably still worth it to debug it.

If you have any kernel patches and/or tests,debug dumps,etc  for me to
try/give I'll be happy to do so.

Best regards,
       Maxim Levitsky

On Fri, Apr 24, 2020 at 11:49 AM Maxim Levitsky <maximlevitsky@gmail.com> wrote:
>
> Hi!
>
> I have the following problem:
> When I suspend my system, and then resume it using one of the wakeup sources
> (tested with two usb keyboards attached to different usb controllers
> and with a wifi card, using
> wake on wan wakeup) then on resume I get ACPI interrupt storm which
> leads to ACPI interrupt be disabled.
>
> Apr 24 11:18:06 starship kernel: irq 9: nobody cared (try booting with
> the "irqpoll" option)
> Apr 24 11:18:06 starship kernel: CPU: 0 PID: 0 Comm: swapper/0 Not
> tainted 5.3.7-301.fc31.x86_64 #1
> Apr 24 11:18:06 starship kernel: Hardware name: Gigabyte Technology
> Co., Ltd. TRX40 DESIGNARE/TRX40 DESIGNARE, BIOS F4c 03/05/2020
> Apr 24 11:18:06 starship kernel: Call Trace:
> Apr 24 11:18:06 starship kernel:  <IRQ>
> Apr 24 11:18:06 starship kernel:  dump_stack+0x5c/0x80
> Apr 24 11:18:06 starship kernel:  __report_bad_irq+0x35/0xa7
> Apr 24 11:18:06 starship kernel:  note_interrupt.cold+0xb/0x63
> Apr 24 11:18:06 starship kernel:  handle_irq_event_percpu+0x6f/0x80
> Apr 24 11:18:06 starship kernel:  handle_irq_event+0x28/0x48
> Apr 24 11:18:06 starship kernel:  handle_fasteoi_irq+0x86/0x130
> Apr 24 11:18:06 starship kernel:  handle_irq+0x1c/0x30
> Apr 24 11:18:06 starship kernel:  do_IRQ+0x4b/0xd0
> Apr 24 11:18:06 starship kernel:  common_interrupt+0xf/0xf
> Apr 24 11:18:06 starship kernel:  </IRQ>
> Apr 24 11:18:06 starship kernel: RIP: 0010:poll_idle+0xa4/0x111
> Apr 24 11:18:06 starship kernel: Code: 04 40 48 c1 e0 05 45 8b 64 04
> 54 4d 69 e4 e8 03 00 00 65 4c 8b 34 25 c0 6b 01 00 b8 c9 00 00 00 49
> 8b 16 83 e2 08 75 >
> Apr 24 11:18:06 starship kernel: RSP: 0018:ffffffff8c403e28 EFLAGS:
> 00000246 ORIG_RAX: ffffffffffffffb1
> Apr 24 11:18:06 starship kernel: RAX: 0000000000000076 RBX:
> 0000001314a7d925 RCX: ffff98852a853050
> Apr 24 11:18:06 starship kernel: RDX: 0000000000000000 RSI:
> 0000000000000003 RDI: 0000001153236883
> Apr 24 11:18:06 starship kernel: RBP: ffff98852a853000 R08:
> 0000001314a7d925 R09: 000000000000016c
> Apr 24 11:18:06 starship kernel: R10: ffff98853ce276c4 R11:
> ffff98853ce276a4 R12: 00000000000007d0
> Apr 24 11:18:06 starship kernel: R13: 0000000000000000 R14:
> ffffffff8c413780 R15: ffffffff8c413780
> Apr 24 11:18:06 starship kernel:  ? poll_idle+0x22/0x111
> Apr 24 11:18:06 starship kernel:  cpuidle_enter_state+0x7c/0x420
> Apr 24 11:18:06 starship kernel:  cpuidle_enter+0x29/0x40
> Apr 24 11:18:06 starship kernel:  do_idle+0x1cf/0x250
> Apr 24 11:18:06 starship kernel:  cpu_startup_entry+0x19/0x20
> Apr 24 11:18:06 starship kernel:  start_kernel+0x54f/0x56c
> Apr 24 11:18:06 starship kernel:  secondary_startup_64+0xa4/0xb0
> Apr 24 11:18:06 starship kernel: handlers:
> Apr 24 11:18:06 starship kernel: [<00000000ac140a6e>] acpi_irq
> Apr 24 11:18:06 starship kernel: Disabling IRQ #9
>
>
> If I wake the system with the power button this doesn't happen.
>
> I tried so far the following:
>
> I tried various combinations of acpi_sci=level/edge acpi_sci=low/high
> - this only hides the problem,
> in the way that power button stops working.
>
> I tried to make acpi interrupt handler lie about IRQ handled just to see
> when the interrupt storm ends (make acpi_irq return IRQ_HANDLED always)
>
> In this case the storm keep on going till I suspend the system again
> and wake it with the power button.
>
> I checked PME status on the chain of pcie bridges leading to the wifi
> device and looks like none have PME pending.
> (I can do the same with USB controller but I guess that would be pointless)
>
> I also checked /sys/firmware/acpi/interrupts/
>
> I have two invalid GPEs that became raised (STS is set) after resume,
> but that happens with power button as well (gpe04 and gpe05)
> I tried to remove the check for invalid gpes in 'counter_set' to try
> and ACK them, and that indeed cleared the STS bit but the storm kept
> on going.
>
> Anything else should I try?
>
> My motherboard is TRX40 Designare running latest F4C bios. I run the
> latest (git pullled yesterday) mainline kernel (5.7-rc2) with few my
> own
> patches that shouldn't be related. I tested this to happen on fedora
> kernel 5.3.7 as well.
>
> I use Fedora 31 if that makes any difference.
>
> ACPI tables attached.
>
> Best regards,
>      Maxim Levitsky
