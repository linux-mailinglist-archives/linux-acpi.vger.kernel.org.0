Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD8FD85D2F
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Aug 2019 10:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731651AbfHHIok (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 8 Aug 2019 04:44:40 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:49275 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731048AbfHHIof (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Aug 2019 04:44:35 -0400
Received: from 79.184.254.29.ipv4.supernova.orange.pl (79.184.254.29) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id 975af00a9d8c7bd9; Thu, 8 Aug 2019 10:44:33 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     platform-driver-x86@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Subject: [PATCH 1/2] intel-hid: intel-vbtn: Avoid leaking wakeup_mode set
Date:   Thu, 08 Aug 2019 10:42:42 +0200
Message-ID: <7715913.DUxqI9eLD1@kreacher>
In-Reply-To: <1717835.1Yz4jNODO2@kreacher>
References: <1717835.1Yz4jNODO2@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Both intel-hid and intel-vbtn set a wakeup_mode flag causing them
to behave in a special way during system suspend and while suspended
in their "prepare" PM callbacks and clear it in their "resume" PM
callbacks.  That may cause the wakeup_mode flag to remain set after
a system suspend failure (if some other driver's "suspend" callback
returns an error before the "suspend" callback of either intel-hid
or intel-vbtn is invoked).

After commit 10a08fd65ec1 ("ACPI: PM: Set up EC GPE for system wakeup
from drivers that need it") that also affects the "wakeup mask" bit
of the EC GPE, which may not be cleared after a failing system
suspend.

Fix this issue by adding "complete" PM callbacks to intel-hid and
intel-vbtn to clear the wakeup_mode flag and the "wakeup mask" bit
of the EC GPE if they have not been cleared earlier.

Fixes: 10a08fd65ec1 ("ACPI: PM: Set up EC GPE for system wakeup from drivers that need it")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

The commit pointed to by the Fixes: tag above is in linux-next only ATM.

The problem had been there before that commit, but it wasn't fixed by it and
the fix depends on that commit.


---
 drivers/platform/x86/intel-hid.c  |   17 ++++++++++++-----
 drivers/platform/x86/intel-vbtn.c |   12 +++++++++---
 2 files changed, 21 insertions(+), 8 deletions(-)

Index: linux-pm/drivers/platform/x86/intel-hid.c
===================================================================
--- linux-pm.orig/drivers/platform/x86/intel-hid.c
+++ linux-pm/drivers/platform/x86/intel-hid.c
@@ -262,6 +262,16 @@ static int intel_hid_pm_prepare(struct d
 	return 0;
 }
 
+static void intel_hid_pm_complete(struct device *device)
+{
+	struct intel_hid_priv *priv = dev_get_drvdata(device);
+
+	if (priv->wakeup_mode) {
+		acpi_ec_set_gpe_wake_mask(ACPI_GPE_DISABLE);
+		priv->wakeup_mode = false;
+	}
+}
+
 static int intel_hid_pl_suspend_handler(struct device *device)
 {
 	if (pm_suspend_via_firmware()) {
@@ -273,12 +283,8 @@ static int intel_hid_pl_suspend_handler(
 
 static int intel_hid_pl_resume_handler(struct device *device)
 {
-	if (device_may_wakeup(device)) {
-		struct intel_hid_priv *priv = dev_get_drvdata(device);
+	intel_hid_pm_complete(device);
 
-		acpi_ec_set_gpe_wake_mask(ACPI_GPE_DISABLE);
-		priv->wakeup_mode = false;
-	}
 	if (pm_resume_via_firmware()) {
 		intel_hid_set_enable(device, true);
 		intel_button_array_enable(device, true);
@@ -288,6 +294,7 @@ static int intel_hid_pl_resume_handler(s
 
 static const struct dev_pm_ops intel_hid_pl_pm_ops = {
 	.prepare = intel_hid_pm_prepare,
+	.complete = intel_hid_pm_complete,
 	.freeze  = intel_hid_pl_suspend_handler,
 	.thaw  = intel_hid_pl_resume_handler,
 	.restore  = intel_hid_pl_resume_handler,
Index: linux-pm/drivers/platform/x86/intel-vbtn.c
===================================================================
--- linux-pm.orig/drivers/platform/x86/intel-vbtn.c
+++ linux-pm/drivers/platform/x86/intel-vbtn.c
@@ -210,19 +210,25 @@ static int intel_vbtn_pm_prepare(struct
 	return 0;
 }
 
-static int intel_vbtn_pm_resume(struct device *dev)
+static void intel_vbtn_pm_complete(struct device *dev)
 {
-	if (device_may_wakeup(dev)) {
-		struct intel_vbtn_priv *priv = dev_get_drvdata(dev);
+	struct intel_vbtn_priv *priv = dev_get_drvdata(dev);
 
+	if (priv->wakeup_mode) {
 		acpi_ec_set_gpe_wake_mask(ACPI_GPE_DISABLE);
 		priv->wakeup_mode = false;
 	}
+}
+
+static int intel_vbtn_pm_resume(struct device *dev)
+{
+	intel_vbtn_pm_complete(dev);
 	return 0;
 }
 
 static const struct dev_pm_ops intel_vbtn_pm_ops = {
 	.prepare = intel_vbtn_pm_prepare,
+	.complete = intel_vbtn_pm_complete,
 	.resume = intel_vbtn_pm_resume,
 	.restore = intel_vbtn_pm_resume,
 	.thaw = intel_vbtn_pm_resume,



