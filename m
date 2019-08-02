Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4D67F562
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Aug 2019 12:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731879AbfHBKqL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Aug 2019 06:46:11 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:51387 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730943AbfHBKpw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Aug 2019 06:45:52 -0400
Received: from 79.184.255.110.ipv4.supernova.orange.pl (79.184.255.110) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id 0dbcfeec0813e87f; Fri, 2 Aug 2019 12:45:50 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v3 2/8] ACPI: PM: s2idle: Rearrange lps0_device_attach()
Date:   Fri, 02 Aug 2019 12:38:34 +0200
Message-ID: <1674293.dTdQWrCe23@kreacher>
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

To allow a subsequent change to be simpler, rearrange the code in
lps0_device_attach() to reduce the indentation level and (while
at it) make it avoid calling lpi_device_get_constraints() when
lps0_device_handle is not going to be set.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

In v2 this was patch 3.

---
 drivers/acpi/sleep.c |   32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

Index: linux-pm/drivers/acpi/sleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.c
+++ linux-pm/drivers/acpi/sleep.c
@@ -916,28 +916,30 @@ static int lps0_device_attach(struct acp
 	guid_parse(ACPI_LPS0_DSM_UUID, &lps0_dsm_guid);
 	/* Check if the _DSM is present and as expected. */
 	out_obj = acpi_evaluate_dsm(adev->handle, &lps0_dsm_guid, 1, 0, NULL);
-	if (out_obj && out_obj->type == ACPI_TYPE_BUFFER) {
-		char bitmask = *(char *)out_obj->buffer.pointer;
-
-		lps0_dsm_func_mask = bitmask;
-		lps0_device_handle = adev->handle;
-		/*
-		 * Use suspend-to-idle by default if the default
-		 * suspend mode was not set from the command line.
-		 */
-		if (mem_sleep_default > PM_SUSPEND_MEM)
-			mem_sleep_current = PM_SUSPEND_TO_IDLE;
-
-		acpi_handle_debug(adev->handle, "_DSM function mask: 0x%x\n",
-				  bitmask);
-	} else {
+	if (!out_obj || out_obj->type != ACPI_TYPE_BUFFER) {
 		acpi_handle_debug(adev->handle,
 				  "_DSM function 0 evaluation failed\n");
+		return 0;
 	}
+
+	lps0_dsm_func_mask = *(char *)out_obj->buffer.pointer;
+
 	ACPI_FREE(out_obj);
 
+	acpi_handle_debug(adev->handle, "_DSM function mask: 0x%x\n",
+			  lps0_dsm_func_mask);
+
+	lps0_device_handle = adev->handle;
+
 	lpi_device_get_constraints();
 
+	/*
+	 * Use suspend-to-idle by default if the default suspend mode was not
+	 * set from the command line.
+	 */
+	if (mem_sleep_default > PM_SUSPEND_MEM)
+		mem_sleep_current = PM_SUSPEND_TO_IDLE;
+
 	return 0;
 }
 



