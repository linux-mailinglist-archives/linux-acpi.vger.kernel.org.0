Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 407EC21F2DE
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jul 2020 15:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbgGNNoP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 14 Jul 2020 09:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgGNNoO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Jul 2020 09:44:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74CC5C061755;
        Tue, 14 Jul 2020 06:44:14 -0700 (PDT)
Date:   Tue, 14 Jul 2020 15:44:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594734252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tUdCMtCp1Gj3QLfmNOfgEwGCdQpToQuLKLSiq+Be9z0=;
        b=evFcMbPvdfhG2mR+vp7Rf2lOWv3E2tWYqPH7GibmsRf68V8QGi5qE+toNq3obNDbY4DTCQ
        tlijGD47H6v1a8CzwV4gE7bovFyu2fJZ2qVoPAouZOawUalMy5B/Chi1vvI6e0ywJFaBHl
        aPbD+oDWuGq9ftrgZ4YLJZfmZi1rrYkYevzK53pJsbvO1g8jpIGge+hEqNyDqenDvAOgwg
        3xkdXfrrtAr37SYzttkmcQoBf4/XbrnvF0bPbZAXrwlsIrS9QMmn8VgYm+golg3iPZBt+A
        Qzzv6DMSjrH7BO91TEON+SmZysR1SjWHSd699TUnuRpFsx1uhP29G3FliTiXfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594734252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tUdCMtCp1Gj3QLfmNOfgEwGCdQpToQuLKLSiq+Be9z0=;
        b=n49Wsx7DyIEJ8wLPjvnuyiy4ej330Y3xqfY/rkav27T70w6CDVTkJdFL8CKjrE1juqKjQh
        H7zTNtiSoTvPceDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Zhang Rui <rui.zhang@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Stephen Berman <stephen.berman@gmx.net>, devel@acpica.org
Subject: Re: power-off delay/hang due to commit 6d25be57 (mainline)
Message-ID: <20200714134410.3odqfvjq6rndjjf6@linutronix.de>
References: <20200615145130.bcdidqkp6w23xb6c@linutronix.de>
 <87tuzbh482.fsf@gmx.net>
 <20200616073827.vysntufld3ves666@linutronix.de>
 <87o8pjh1i0.fsf@gmx.net>
 <20200616155501.psduxnisltitodme@linutronix.de>
 <871rmesqkk.fsf@gmx.net>
 <20200617142734.mxwfoblufmo6li5e@linutronix.de>
 <87ftatqu07.fsf@gmx.net>
 <20200624201156.xu6hel3drnhno6c3@linutronix.de>
 <87ftak2kxr.fsf@rub.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ftak2kxr.fsf@rub.de>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020-06-24 23:49:52 [+0200], Stephen Berman wrote:

Let me summarize the thread here:

On Stephen's system, ACPI informs the thermal zone driver to poll the
temperature every second and the driver does so.
The driver queries the temperature by invoking acpi_evaluate_integer()
which invokes (at some point) acpi_ev_queue_notify_request(). 
This then invokes acpi_os_execute_deferred() via
    queue_work_on(, kacpi_notify_wq, )
 
acpi_os_execute_deferred() invokes acpi_ev_notify_dispatch() and this is
no longer synchronised with the initial acpi_evaluate_integer() request.

Before commit
   6d25be5782e48 ("sched/core, workqueues: Distangle worker accounting from rq lock")

that function took on average 1.023993 seconds to complete. The
interval when the thermal driver invokes acpi_evaluate_integer() isn't
exactly 1 second but almost (it is not an absolute timer so). Still it
looks that one function slowly overtakes the other. After 5 Minutes
uptime there is:

| kworker/0:1-12 [000] 312.315565: acpi_ev_queue_notify_request: Dispatching Notify on [TZ10] (Thermal) Value 0x81 (Information Change) Node ffff9935ab20f7a8
| kworker/0:1-12 [000] 312.315567: acpi_os_execute: Adding acpi_ev_notify_dispatch+0x0/0x5a ffff9935a6c64050 <ffff9935a7eb5e00>

Enqueue worker with job ffff9935a7eb5e00

| kworker/0:1-12 [000] 312.315596: acpi_os_execute_deferred_notify: End ffff9935a7eb5c80 acpi_ev_notify_dispatch+0x0/0x5a(ffff9935a6c64c80)
| kworker/0:1-12 [000] 312.315607: acpi_os_execute_deferred_notify: Start ffff9935a7eb5d80 acpi_ev_notify_dispatch+0x0/0x5a(ffff9935a6c64dc0)

previous worker completed, another (already enqueued) started.

| kworker/0:1-12 [000] 313.339564: acpi_ev_queue_notify_request: Dispatching Notify on [TZ10] (Thermal) Value 0x81 (Information Change) Node ffff9935ab20f7a8
| kworker/0:1-12 [000] 313.339566: acpi_os_execute: Adding acpi_ev_notify_dispatch+0x0/0x5a ffff9935a6c64f00 <ffff9935a7eb5c80>

another one enqueued.

| kworker/0:1-12 [000] 313.339595: acpi_os_execute_deferred_notify: End ffff9935a7eb5d80 acpi_ev_notify_dispatch+0x0/0x5a(ffff9935a6c64dc0)
| kworker/0:1-12 [000] 313.339597: acpi_os_execute_deferred_notify: Start ffff9935a7eb5e00 acpi_ev_notify_dispatch+0x0/0x5a(ffff9935a6c64050)

finally, job ffff9935a7eb5e00 started (one second after enqueue).

| kworker/0:1-12 [000] 314.363571: acpi_ev_queue_notify_request: Dispatching Notify on [TZ10] (Thermal) Value 0x81 (Information Change) Node ffff9935ab20f7a8
| kworker/0:1-12 [000] 314.363574: acpi_os_execute: Adding acpi_ev_notify_dispatch+0x0/0x5a ffff9935a6c646e0 <ffff9935a7eb5d80>
| kworker/0:1-12 [000] 314.363608: acpi_os_execute_deferred_notify: End ffff9935a7eb5e00 acpi_ev_notify_dispatch+0x0/0x5a(ffff9935a6c64050)

and ended, two seconds after enqueue. Before it ended, the system
enqueued two more jobs. And this just within 5 Minutes of uptime. The
worker pile slowly up.

According to Stephen, after previously mentioned commit the situation
gets worse. According to tracing the execution time of
acpi_ev_notify_dispatch() varies between 1.023990 (like before) and
2.048005 seconds. While I don't have an explanation for the changed
behaviour (or see anything wrong the commit in question), the pile up of
worker increased.
Stephen noticed this because system shutdown flushes kacpi_notify_wq
and this takes quite some time (with that amount of worker pending).

I tried a few test cases to reproduce that behaviour but failed.
However, even before that commit in question the situation is far from
perfect: 
- There is the lack of synchronisation between thermal driver's
  requests and its tail (that acpi_ev_notify_dispatch() part). 
- Do we have to respect ACPI interval of one seconds. Is the hardware
  really so accurate that it can change noticeable in one second.
- The requests are already back to back which keeps the CPU busy (maybe
  sched-switch will reveal that the CPU is idle most of the time).

So...

Is there a simple way to synchronize the ACPI part? The obvious thing
would be

	flush_workqueue(kacpi_notify_wq);
or
	acpi_os_wait_events_complete()

in thermal_get_temp().
Would it make sense to ensure that the polling interval is no less than
10 seconds?

> Steve Berman

Sebastian
