Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBDF1FB891
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Jun 2020 17:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731973AbgFPPzE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Tue, 16 Jun 2020 11:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733047AbgFPPzD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Jun 2020 11:55:03 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA81DC061573;
        Tue, 16 Jun 2020 08:55:03 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jlDvR-0001r7-MW; Tue, 16 Jun 2020 17:55:01 +0200
Date:   Tue, 16 Jun 2020 17:55:01 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Stephen Berman <stephen.berman@gmx.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: power-off delay/hang due to commit 6d25be57 (mainline)
Message-ID: <20200616155501.psduxnisltitodme@linutronix.de>
References: <87imfyh6yx.fsf@gmx.net>
 <87wo4dligz.fsf@gmx.net>
 <20200612110122.jossn5zrktcvpbpm@linutronix.de>
 <87tuzdrgm5.fsf@gmx.net>
 <20200614171005.3zy673p6bpwoqnmq@linutronix.de>
 <874krcsquv.fsf@gmx.net>
 <20200615145130.bcdidqkp6w23xb6c@linutronix.de>
 <87tuzbh482.fsf@gmx.net>
 <20200616073827.vysntufld3ves666@linutronix.de>
 <87o8pjh1i0.fsf@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <87o8pjh1i0.fsf@gmx.net>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020-06-16 10:13:27 [+0200], Stephen Berman wrote:
> Yes, thanks, that did it.  Trace attached.

So TZ10 is a temperature sensor of some kind on your motherboard. In
your v5.6 dmesg there is:
| thermal LNXTHERM:00: registered as thermal_zone0
| ACPI: Thermal Zone [TZ10] (17 C)

So. In /sys/class/thermal/thermal_zone0/device/path you should also see
TZ10. And /sys/class/thermal/thermal_zone0/temp should show the actual
value.
This comes from the "thermal" module.

Looking at the trace, might query the temperature every second which
somehow results in "Dispatching Notify on". I don't understand how it
gets from reading of the temperature to the notify part, maybe it is
part of the ACPI…

However. Could you please make sure that the thermal module is not
loaded at system startup? Adding
    thermal.off=1

to the kernel commandline should do the trick. And you should see
   thermal control disabled

in dmesg. That means your thermal_zone0 with TZ10 does not show up in
/sys and nothing should schedule the work-items. This in turn should
allow you to shutdown your system without the delay.

If this works, could you please try to load the module with tzp=300?
If you add this
 	thermal.tzp=300
  
to the kernel commandline then it should do the trick. You can verify it
by
   cat /sys/module/thermal/parameters/tzp 

This should change the polling interval from what ACPI says to 30secs.
This should ensure that you don't have so many worker waiting. So you
should also be able to shutdown the system.

> Steve Berman

Sebastian
