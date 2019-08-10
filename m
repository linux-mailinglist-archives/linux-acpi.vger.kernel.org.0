Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 116AD88B03
	for <lists+linux-acpi@lfdr.de>; Sat, 10 Aug 2019 13:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbfHJLYI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 10 Aug 2019 07:24:08 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:60555 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfHJLYH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 10 Aug 2019 07:24:07 -0400
Received: from 79.184.254.29.ipv4.supernova.orange.pl (79.184.254.29) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id 280ae9cb69888997; Sat, 10 Aug 2019 13:24:05 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] PM: suspend: Fix platform_suspend_prepare_noirq()
Date:   Sat, 10 Aug 2019 13:24:04 +0200
Message-ID: <1929036.rkDPr3nAr5@kreacher>
In-Reply-To: <1b181f35-29c3-c6ce-6c42-ae55e890579e@samsung.com>
References: <5997740.FPbUVk04hV@kreacher> <CGME20190809120052eucas1p11b56806662ef4f4efb82a152ad651481@eucas1p1.samsung.com> <1b181f35-29c3-c6ce-6c42-ae55e890579e@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After commit ac9eafbe930a ("ACPI: PM: s2idle: Execute LPS0 _DSM
functions with suspended devices"), a NULL pointer may be dereferenced
if suspend-to-idle is attempted on a platform without "traditional"
suspend support due to invalid fall-through in
platform_suspend_prepare_noirq().

Fix that and while at it add missing braces in platform_resume_noirq().

Fixes: ac9eafbe930a ("ACPI: PM: s2idle: Execute LPS0 _DSM functions with suspended devices")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Commit ac9eafbe930a is in linux-next only at this point.

---
 kernel/power/suspend.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

Index: linux-pm/kernel/power/suspend.c
===================================================================
--- linux-pm.orig/kernel/power/suspend.c
+++ linux-pm/kernel/power/suspend.c
@@ -253,10 +253,10 @@ static int platform_suspend_prepare_late
 
 static int platform_suspend_prepare_noirq(suspend_state_t state)
 {
-	if (state == PM_SUSPEND_TO_IDLE) {
-		if (s2idle_ops && s2idle_ops->prepare_late)
-			return s2idle_ops->prepare_late();
-	}
+	if (state == PM_SUSPEND_TO_IDLE)
+		return s2idle_ops && s2idle_ops->prepare_late ?
+			s2idle_ops->prepare_late() : 0;
+
 	return suspend_ops->prepare_late ? suspend_ops->prepare_late() : 0;
 }
 
@@ -265,8 +265,9 @@ static void platform_resume_noirq(suspen
 	if (state == PM_SUSPEND_TO_IDLE) {
 		if (s2idle_ops && s2idle_ops->restore_early)
 			s2idle_ops->restore_early();
-	} else if (suspend_ops->wake)
+	} else if (suspend_ops->wake) {
 		suspend_ops->wake();
+	}
 }
 
 static void platform_resume_early(suspend_state_t state)



