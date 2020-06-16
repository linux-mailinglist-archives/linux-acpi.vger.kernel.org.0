Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 288EA1FAA0D
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Jun 2020 09:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgFPHia (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 Jun 2020 03:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgFPHia (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Jun 2020 03:38:30 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C71C05BD43;
        Tue, 16 Jun 2020 00:38:30 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jl6Au-0006oR-12; Tue, 16 Jun 2020 09:38:28 +0200
Date:   Tue, 16 Jun 2020 09:38:27 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Stephen Berman <stephen.berman@gmx.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: power-off delay/hang due to commit 6d25be57 (mainline)
Message-ID: <20200616073827.vysntufld3ves666@linutronix.de>
References: <87tuzjcovq.fsf@gmx.net>
 <20200610102514.4vdzu5u7d6vnpicn@linutronix.de>
 <87imfyh6yx.fsf@gmx.net>
 <87wo4dligz.fsf@gmx.net>
 <20200612110122.jossn5zrktcvpbpm@linutronix.de>
 <87tuzdrgm5.fsf@gmx.net>
 <20200614171005.3zy673p6bpwoqnmq@linutronix.de>
 <874krcsquv.fsf@gmx.net>
 <20200615145130.bcdidqkp6w23xb6c@linutronix.de>
 <87tuzbh482.fsf@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87tuzbh482.fsf@gmx.net>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020-06-16 09:14:37 [+0200], Stephen Berman wrote:
> 
> I set CONFIG_ACPI_DEBUG=y, applied the patch and rebuilt 5.6.4, but:
> 
> $ cat /sys/kernel/debug/tracing/trace > trace.txt
> cat: /sys/kernel/debug/tracing/trace: No such file or directory
> 
> Here are all the 5.6.4 config options with "TRACING" or "TRACE"; do I
> need to set any that aren't set?

I see that "Kernel hacking  ---> Tracers" is enabled. You should have
one tracer enabled for that trace_printk() to work. You have context
switch tracer so it should be enough.

You might need CONFIG_DEBUG_FS (but it is set in your 5.1 config) or it
is just not mounted. So I have here:

| debugfs on /sys/kernel/debug type debugfs (rw,nosuid,nodev,noexec,relatime)
| tracefs on /sys/kernel/debug/tracing type tracefs (rw,nosuid,nodev,noexec,relatime)

Does it work for you if you mount it?

> Steve Berman

Sebastian
