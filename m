Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAD87F567
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Aug 2019 12:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730856AbfHBKqX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Aug 2019 06:46:23 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:59740 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730841AbfHBKpv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Aug 2019 06:45:51 -0400
Received: from 79.184.255.110.ipv4.supernova.orange.pl (79.184.255.110) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id 08687bff39390d68; Fri, 2 Aug 2019 12:45:49 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v3 4/8] ACPI: PM: s2idle: Switch EC over to polling during "noirq" suspend
Date:   Fri, 02 Aug 2019 12:40:43 +0200
Message-ID: <2250753.m3tS5N7MJZ@kreacher>
In-Reply-To: <5997740.FPbUVk04hV@kreacher>
References: <5997740.FPbUVk04hV@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since the ACPI SCI is set up for system wakeup before the "noirq"
suspend of devices, it is better to make suspend-to-idle follow
suspend-to-RAM (S3) and switch over the EC to polling during "noirq"
suspend (and back to interrupt-based flow during "noirq" resume).

The frequency of spurious wakeup interrupts from the EC may be
reduced this way.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

In v2 this was patch 5.

---
 drivers/acpi/ec.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/acpi/ec.c
===================================================================
--- linux-pm.orig/drivers/acpi/ec.c
+++ linux-pm/drivers/acpi/ec.c
@@ -1958,8 +1958,7 @@ static int acpi_ec_suspend_noirq(struct
 	    ec->reference_count >= 1)
 		acpi_set_gpe(NULL, ec->gpe, ACPI_GPE_DISABLE);
 
-	if (acpi_sleep_no_ec_events())
-		acpi_ec_enter_noirq(ec);
+	acpi_ec_enter_noirq(ec);
 
 	return 0;
 }
@@ -1968,8 +1967,7 @@ static int acpi_ec_resume_noirq(struct d
 {
 	struct acpi_ec *ec = acpi_driver_data(to_acpi_device(dev));
 
-	if (acpi_sleep_no_ec_events())
-		acpi_ec_leave_noirq(ec);
+	acpi_ec_leave_noirq(ec);
 
 	if (ec_no_wakeup && test_bit(EC_FLAGS_STARTED, &ec->flags) &&
 	    ec->reference_count >= 1)



