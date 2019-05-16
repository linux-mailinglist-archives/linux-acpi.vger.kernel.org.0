Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2A5203CC
	for <lists+linux-acpi@lfdr.de>; Thu, 16 May 2019 12:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfEPKnX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 16 May 2019 06:43:23 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:43358 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfEPKnW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 16 May 2019 06:43:22 -0400
Received: from 79.184.255.148.ipv4.supernova.orange.pl (79.184.255.148) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id df73ffdb44497ac9; Thu, 16 May 2019 12:43:20 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: [PATCH] ACPI: PM: Call pm_set_suspend_via_firmware() during hibernation
Date:   Thu, 16 May 2019 12:43:19 +0200
Message-ID: <3247013.1dn1YOOxyY@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

On systems with ACPI platform firmware the last stage of hibernation
is analogous to system suspend to S3 (suspend-to-RAM), so it should
be handled analogously.  In particular, pm_suspend_via_firmware()
should return 'true' in that stage to let the callers of it know that
control will be passed to the platform firmware going forward, so
pm_set_suspend_via_firmware() needs to be called then in analogy with
acpi_suspend_begin().

However, the platform hibernation ->begin() callback is invoked
during the "freeze" transition (before creating a snapshot image of
system memory) as well as during the "hibernate" transition which is
the last stage of it and pm_set_suspend_via_firmware() should be
invoked by that callback in the latter stage only.

In order to implement that redefine the hibernation ->begin()
callback to take a pm_message_t argument to indicate which stage
of hibernation is taking place and rework acpi_hibernation_begin()
and acpi_hibernation_begin_old() to take it into account as needed.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/sleep.c     |   39 ++++++++++++++++++++++++---------------
 include/linux/suspend.h  |    2 +-
 kernel/power/hibernate.c |    4 ++--
 3 files changed, 27 insertions(+), 18 deletions(-)

Index: linux-pm/include/linux/suspend.h
===================================================================
--- linux-pm.orig/include/linux/suspend.h
+++ linux-pm/include/linux/suspend.h
@@ -359,7 +359,7 @@ extern void mark_free_pages(struct zone
  *	platforms which require special recovery actions in that situation.
  */
 struct platform_hibernation_ops {
-	int (*begin)(void);
+	int (*begin)(pm_message_t stage);
 	void (*end)(void);
 	int (*pre_snapshot)(void);
 	void (*finish)(void);
Index: linux-pm/kernel/power/hibernate.c
===================================================================
--- linux-pm.orig/kernel/power/hibernate.c
+++ linux-pm/kernel/power/hibernate.c
@@ -129,7 +129,7 @@ static int hibernation_test(int level) {
 static int platform_begin(int platform_mode)
 {
 	return (platform_mode && hibernation_ops) ?
-		hibernation_ops->begin() : 0;
+		hibernation_ops->begin(PMSG_FREEZE) : 0;
 }
 
 /**
@@ -542,7 +542,7 @@ int hibernation_platform_enter(void)
 	 * hibernation_ops->finish() before saving the image, so we should let
 	 * the firmware know that we're going to enter the sleep state after all
 	 */
-	error = hibernation_ops->begin();
+	error = hibernation_ops->begin(PMSG_HIBERNATE);
 	if (error)
 		goto Close;
 
Index: linux-pm/drivers/acpi/sleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.c
+++ linux-pm/drivers/acpi/sleep.c
@@ -1128,15 +1128,19 @@ void __init acpi_no_s4_hw_signature(void
 	nosigcheck = true;
 }
 
-static int acpi_hibernation_begin(void)
+static int acpi_hibernation_begin(pm_message_t stage)
 {
-	int error;
+	if (!nvs_nosave) {
+		int error = suspend_nvs_alloc();
+		if (error)
+			return error;
+	}
 
-	error = nvs_nosave ? 0 : suspend_nvs_alloc();
-	if (!error)
-		acpi_pm_start(ACPI_STATE_S4);
+	if (stage.event == PM_EVENT_HIBERNATE)
+		pm_set_suspend_via_firmware();
 
-	return error;
+	acpi_pm_start(ACPI_STATE_S4);
+	return 0;
 }
 
 static int acpi_hibernation_enter(void)
@@ -1196,7 +1200,7 @@ static const struct platform_hibernation
  *		function is used if the pre-ACPI 2.0 suspend ordering has been
  *		requested.
  */
-static int acpi_hibernation_begin_old(void)
+static int acpi_hibernation_begin_old(pm_message_t stage)
 {
 	int error;
 	/*
@@ -1207,16 +1211,21 @@ static int acpi_hibernation_begin_old(vo
 	acpi_sleep_tts_switch(ACPI_STATE_S4);
 
 	error = acpi_sleep_prepare(ACPI_STATE_S4);
+	if (error)
+		return error;
 
-	if (!error) {
-		if (!nvs_nosave)
-			error = suspend_nvs_alloc();
-		if (!error) {
-			acpi_target_sleep_state = ACPI_STATE_S4;
-			acpi_scan_lock_acquire();
-		}
+	if (!nvs_nosave) {
+		error = suspend_nvs_alloc();
+		if (error)
+			return error;
 	}
-	return error;
+
+	if (stage.event == PM_EVENT_HIBERNATE)
+		pm_set_suspend_via_firmware();
+
+	acpi_target_sleep_state = ACPI_STATE_S4;
+	acpi_scan_lock_acquire();
+	return 0;
 }
 
 /*



