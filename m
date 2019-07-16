Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 415F16ACAD
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Jul 2019 18:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388098AbfGPQ1T (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 Jul 2019 12:27:19 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:53371 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388046AbfGPQ1S (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Jul 2019 12:27:18 -0400
Received: from 79.184.255.39.ipv4.supernova.orange.pl (79.184.255.39) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 50c6e6fd674ef2b9; Tue, 16 Jul 2019 18:27:15 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        "David E. Box" <david.e.box@linux.intel.com>
Subject: [PATCH 4/8] PM: sleep: Fix possible overflow in pm_system_cancel_wakeup()
Date:   Tue, 16 Jul 2019 18:14:58 +0200
Message-ID: <2970489.lynJ6BP8VZ@kreacher>
In-Reply-To: <71085220.z6FKkvYQPX@kreacher>
References: <71085220.z6FKkvYQPX@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It is not actually guaranteed that pm_abort_suspend will be
nonzero when pm_system_cancel_wakeup() is called which may lead to
subtle issues, so make it use atomic_dec_if_positive() instead of
atomic_dec() for the safety sake.

Fixes: 33e4f80ee69b ("ACPI / PM: Ignore spurious SCI wakeups from suspend-to-idle")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/wakeup.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-pm/drivers/base/power/wakeup.c
===================================================================
--- linux-pm.orig/drivers/base/power/wakeup.c
+++ linux-pm/drivers/base/power/wakeup.c
@@ -859,7 +859,7 @@ EXPORT_SYMBOL_GPL(pm_system_wakeup);
 
 void pm_system_cancel_wakeup(void)
 {
-	atomic_dec(&pm_abort_suspend);
+	atomic_dec_if_positive(&pm_abort_suspend);
 }
 
 void pm_wakeup_clear(bool reset)



