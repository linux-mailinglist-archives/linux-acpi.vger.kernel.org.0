Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B47276FC86
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Jul 2019 11:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfGVJqh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 Jul 2019 05:46:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36144 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727541AbfGVJqh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Jul 2019 05:46:37 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hpUtp-0003O3-V0; Mon, 22 Jul 2019 11:46:30 +0200
Date:   Mon, 22 Jul 2019 11:46:29 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        "David E. Box" <david.e.box@linux.intel.com>
Subject: Re: [PATCH 0/8] PM / ACPI: sleep: Simplify the suspend-to-idle
 control flow
In-Reply-To: <71085220.z6FKkvYQPX@kreacher>
Message-ID: <alpine.DEB.2.21.1907221145440.1782@nanos.tec.linutronix.de>
References: <71085220.z6FKkvYQPX@kreacher>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 16 Jul 2019, Rafael J. Wysocki wrote:

> Hi All,
> 
> The rationale for these changes is explained in the changelog of patch [6/8] as follows:
> 
> "After commit 33e4f80ee69b ("ACPI / PM: Ignore spurious SCI wakeups
> from suspend-to-idle") the "noirq" phases of device suspend and
> resume may run for multiple times during suspend-to-idle, if there
> are spurious system wakeup events while suspended.  However, this
> is complicated and fragile and actually unnecessary.
> 
> The main reason for doing this is that on some systems the EC may
> signal system wakeup events (power button events, for example) as
> well as events that should not cause the system to resume (spurious
> system wakeup events).  Thus, in order to determine whether or not
> a given event signaled by the EC while suspended is a proper system
> wakeup one, the EC GPE needs to be dispatched and to start with that
> was achieved by allowing the ACPI SCI action handler to run, which
> was only possible after calling resume_device_irqs().
> 
> However, dispatching the EC GPE this way turned out to take too much
> time in some cases and some EC events might be missed due to that, so
> commit 68e22011856f ("ACPI: EC: Dispatch the EC GPE directly on
> s2idle wake") started to dispatch the EC GPE right after a wakeup
> event has been detected, so in fact the full ACPI SCI action handler
> doesn't need to run any more to deal with the wakeups coming from the
> EC.
> 
> Use this observation to simplify the suspend-to-idle control flow
> so that the "noirq" phases of device suspend and resume are each
> run only once in every suspend-to-idle cycle, which is reported to
> significantly reduce power drawn by some systems when suspended to
> idle (by allowing them to reach a deep platform-wide low-power state
> through the suspend-to-idle flow)."
> 
> A bonus is that after the essential changes the s2idle flow can be
> integrated back into the generic suspend/resume one (patch [7/8])
> and some simplifications can be made in drivers/base/power/main.c
> after that (patch [8/8]).

Nice work!

Acked-by: Thomas Gleixner <tglx@linutronix.de>

