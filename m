Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49FAA85D26
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Aug 2019 10:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731393AbfHHIof (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 8 Aug 2019 04:44:35 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:55035 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbfHHIof (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Aug 2019 04:44:35 -0400
Received: from 79.184.254.29.ipv4.supernova.orange.pl (79.184.254.29) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id 4f9bbccdaa245767; Thu, 8 Aug 2019 10:44:32 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     platform-driver-x86@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Subject: [PATCH 2/2] intel-hid: Disable button array during suspend-to-idle
Date:   Thu, 08 Aug 2019 10:44:25 +0200
Message-ID: <2765892.t9mEYBIOOk@kreacher>
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

Notice that intel_button_array_enable() never disables the power
button which is the only one needed to wake up the system from
suspend-to-idle, so it can be safely called during suspend-to-idle
as well as during "regular" system suspend, and rearrange the
code in the driver's "suspend" and "resume" callbacks accordingly.

While at it, use pm_suspend_no_platform() to check if the current
suspend-resume cycle is suspend-to-idle, as that is the only
case when the device should be enabled while suspended.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/intel-hid.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/platform/x86/intel-hid.c
===================================================================
--- linux-pm.orig/drivers/platform/x86/intel-hid.c
+++ linux-pm/drivers/platform/x86/intel-hid.c
@@ -274,10 +274,11 @@ static void intel_hid_pm_complete(struct
 
 static int intel_hid_pl_suspend_handler(struct device *device)
 {
-	if (pm_suspend_via_firmware()) {
+	intel_button_array_enable(device, false);
+
+	if (!pm_suspend_no_platform())
 		intel_hid_set_enable(device, false);
-		intel_button_array_enable(device, false);
-	}
+
 	return 0;
 }
 
@@ -285,10 +286,10 @@ static int intel_hid_pl_resume_handler(s
 {
 	intel_hid_pm_complete(device);
 
-	if (pm_resume_via_firmware()) {
+	if (!pm_suspend_no_platform())
 		intel_hid_set_enable(device, true);
-		intel_button_array_enable(device, true);
-	}
+
+	intel_button_array_enable(device, true);
 	return 0;
 }
 



