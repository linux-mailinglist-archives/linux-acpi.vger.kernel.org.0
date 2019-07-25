Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6006C75B07
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Jul 2019 00:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfGYW4Y (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Jul 2019 18:56:24 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:48788 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726941AbfGYW4X (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Jul 2019 18:56:23 -0400
Received: from 79.184.253.188.ipv4.supernova.orange.pl (79.184.253.188) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 2d85bf4e2888bf9b; Fri, 26 Jul 2019 00:56:21 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
Subject: [PATCH 3/4] ACPI: PM: s2idle: Rearrange lps0_device_attach()
Date:   Fri, 26 Jul 2019 00:55:11 +0200
Message-ID: <4485073.xHi3FTShEL@kreacher>
In-Reply-To: <3471485.I2vrcDHEeC@kreacher>
References: <3471485.I2vrcDHEeC@kreacher>
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
 



