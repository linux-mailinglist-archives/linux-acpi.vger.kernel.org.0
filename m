Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E74B6ACAF
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Jul 2019 18:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388131AbfGPQ1V (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 Jul 2019 12:27:21 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:52586 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387977AbfGPQ1U (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Jul 2019 12:27:20 -0400
Received: from 79.184.255.39.ipv4.supernova.orange.pl (79.184.255.39) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 1116abc0f6e4ed4e; Tue, 16 Jul 2019 18:27:18 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        "David E. Box" <david.e.box@linux.intel.com>
Subject: [PATCH 0/8] PM / ACPI: sleep: Simplify the suspend-to-idle control flow
Date:   Tue, 16 Jul 2019 18:08:29 +0200
Message-ID: <71085220.z6FKkvYQPX@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

The rationale for these changes is explained in the changelog of patch [6/8] as follows:

"After commit 33e4f80ee69b ("ACPI / PM: Ignore spurious SCI wakeups
from suspend-to-idle") the "noirq" phases of device suspend and
resume may run for multiple times during suspend-to-idle, if there
are spurious system wakeup events while suspended.  However, this
is complicated and fragile and actually unnecessary.

The main reason for doing this is that on some systems the EC may
signal system wakeup events (power button events, for example) as
well as events that should not cause the system to resume (spurious
system wakeup events).  Thus, in order to determine whether or not
a given event signaled by the EC while suspended is a proper system
wakeup one, the EC GPE needs to be dispatched and to start with that
was achieved by allowing the ACPI SCI action handler to run, which
was only possible after calling resume_device_irqs().

However, dispatching the EC GPE this way turned out to take too much
time in some cases and some EC events might be missed due to that, so
commit 68e22011856f ("ACPI: EC: Dispatch the EC GPE directly on
s2idle wake") started to dispatch the EC GPE right after a wakeup
event has been detected, so in fact the full ACPI SCI action handler
doesn't need to run any more to deal with the wakeups coming from the
EC.

Use this observation to simplify the suspend-to-idle control flow
so that the "noirq" phases of device suspend and resume are each
run only once in every suspend-to-idle cycle, which is reported to
significantly reduce power drawn by some systems when suspended to
idle (by allowing them to reach a deep platform-wide low-power state
through the suspend-to-idle flow)."

A bonus is that after the essential changes the s2idle flow can be
integrated back into the generic suspend/resume one (patch [7/8])
and some simplifications can be made in drivers/base/power/main.c
after that (patch [8/8]).

Patches [1-5/8] are pre-requisite and the changes made by the first
three of them really take effect after applying patch [6/8].  Patch
[4/8], in turn, is a fix and patch [5/8] is an extra simplification.

Please refer to the changelogs for details.

For easier testing, this series is available from the git branch at:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-s2idle-rework

Thanks,
Rafael



