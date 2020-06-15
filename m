Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA8681F9C71
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Jun 2020 17:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730764AbgFOP6u (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 15 Jun 2020 11:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgFOP6t (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Jun 2020 11:58:49 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D245C061A0E;
        Mon, 15 Jun 2020 08:58:49 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jkrVW-0006KP-C2; Mon, 15 Jun 2020 17:58:46 +0200
Date:   Mon, 15 Jun 2020 17:58:46 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Stephen Berman <stephen.berman@gmx.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: power-off delay/hang due to commit 6d25be57 (mainline)
Message-ID: <20200615155846.nd5n32qggusakxl7@linutronix.de>
References: <87tuzjcovq.fsf@gmx.net>
 <20200610102514.4vdzu5u7d6vnpicn@linutronix.de>
 <87imfyh6yx.fsf@gmx.net>
 <87wo4dligz.fsf@gmx.net>
 <20200612110122.jossn5zrktcvpbpm@linutronix.de>
 <87tuzdrgm5.fsf@gmx.net>
 <20200614171005.3zy673p6bpwoqnmq@linutronix.de>
 <874krcsquv.fsf@gmx.net>
 <20200615145130.bcdidqkp6w23xb6c@linutronix.de>
 <87tuzcqqul.fsf@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87tuzcqqul.fsf@gmx.net>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020-06-15 17:41:06 [+0200], Stephen Berman wrote:
> > If you do this "t" then there should be a lot of output on your console.
> > If you do this from an xterm then you can see the output after typing
> > "dmesg". The output should appear also in your system log.
> 
> Ah, ok, I do see it in the log, it looks basically the same as the call
> trace I posted upthread.  I wonder why there was no such output in the
> console, could there be some setting that suppresses it even though
> /proc/sys/kernel/sysrq has `1'?

You have ignore_loglevel soo everything should appear on your console.
The is true for your tty / ctrl+alt+f1 but your xterm shell.

> There were in fact 99 "Start .* acpi_ev_notify_dispatch" messages and 98
> "End .* acpi_ev_notify_dispatch" messages.  Here's the last of them
> before I rebooted:
> 
> Jun 15 08:58:25 strobe-jhalfs kernel: [  193.315014] acpi_os_execute(1109) Adding acpi_ev_notify_dispatch+0x0/0x55 ffff8d7aa99a66e0 <ffff8d7aabb38480>
> Jun 15 08:58:25 strobe-jhalfs kernel: [  193.319929] acpi_os_execute_deferred_notify(853) End   ffff8d7aa8758d00 acpi_ev_notify_dispatch+0x0/0x55(ffff8d7aa84e7eb0)
> Jun 15 08:58:25 strobe-jhalfs kernel: [  193.321242] acpi_os_execute_deferred_notify(851) Start ffff8d7aa8758a80 acpi_ev_notify_dispatch+0x0/0x55(ffff8d7aa84e70a0)
> Jun 15 08:58:26 strobe-jhalfs kernel: [  194.339017] acpi_os_execute(1109) Adding acpi_ev_notify_dispatch+0x0/0x55 ffff8d7aa99a6730 <ffff8d7aabb384c0>
> Jun 15 08:58:27 strobe-jhalfs kernel: [  195.363005] acpi_os_execute(1109) Adding acpi_ev_notify_dispatch+0x0/0x55 ffff8d7aa99a6780 <ffff8d7aabb38500>
> Jun 15 08:58:27 strobe-jhalfs kernel: [  195.367978] acpi_os_execute_deferred_notify(853) End   ffff8d7aa8758a80 acpi_ev_notify_dispatch+0x0/0x55(ffff8d7aa84e70a0)
> Jun 15 08:58:27 strobe-jhalfs kernel: [  195.369234] acpi_os_execute_deferred_notify(851) Start ffff8d7aa8758240 acpi_ev_notify_dispatch+0x0/0x55(ffff8d7aa84e7a00)
> Jun 15 08:58:28 strobe-jhalfs kernel: [  196.387017] acpi_os_execute(1109) Adding acpi_ev_notify_dispatch+0x0/0x55 ffff8d7aa99a68c0 <ffff8d7aabb38540>
> Jun 15 08:58:28 strobe-jhalfs kernel: [  196.388508] acpi_os_execute_deferred_notify(853) End   ffff8d7aa8758240 acpi_ev_notify_dispatch+0x0/0x55(ffff8d7aa84e7a00)
> Jun 15 08:58:28 strobe-jhalfs kernel: [  196.390128] acpi_os_execute_deferred_notify(851) Start ffff8d7aa8758b80 acpi_ev_notify_dispatch+0x0/0x55(ffff8d7aa84e7460)
> Jun 15 08:58:29 strobe-jhalfs kernel: [  197.208714] wlan1: deauthenticating from 7c:ff:4d:08:df:22 by local choice (Reason: 3=DEAUTH_LEAVING)
> Jun 15 08:58:29 strobe-jhalfs kernel: [  197.232214] ip (4614) used greatest stack depth: 11272 bytes left
> Jun 15 08:58:29 strobe-jhalfs kernel: Kernel logging (proc) stopped.
> Jun 15 08:58:29 strobe-jhalfs kernel: Kernel log daemon terminating.

Okay. So there is "Adding" of four events/work items in total, each
almost every second.
Processing of one work-item took two seconds, the other one took a
second. These events are "old" so I don't see the "adding" line for the
Start/End.
You could look in the log for ffff8d7aa8758a80 to seen when it was
enqueued but it feels like ACPI enqueues more events then it is capable
of processing.

> Steve Berman

Sebastian
