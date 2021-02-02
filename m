Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9530830C9A2
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Feb 2021 19:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238491AbhBBSXk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Feb 2021 13:23:40 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:57100 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238420AbhBBSVY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Feb 2021 13:21:24 -0500
Received: from 89-64-80-193.dynamic.chello.pl (89.64.80.193) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.537)
 id 637ff068aa18e73b; Tue, 2 Feb 2021 19:19:56 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Joe Perches <joe@perches.com>
Subject: [PATCH v2 1/5] ACPI: AC: Clean up printing messages
Date:   Tue, 02 Feb 2021 19:14:55 +0100
Message-ID: <5584914.5WsbVgmIkf@kreacher>
In-Reply-To: <1991501.dpTHplkurC@kreacher>
References: <2367702.B5bJTmGzJm@kreacher> <1991501.dpTHplkurC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Replace the ACPI_DEBUG_PRINT() and ACPI_EXCEPTION() instances
in ac.c with acpi_handle_debug() and acpi_handle_info() calls,
respectively, which among other things causes the excessive log
level of the messages previously printed via ACPI_EXCEPTION() to
be more adequate.

Drop the _COMPONENT and ACPI_MODULE_NAME() definitions that are not
used any more, drop the no longer needed ACPI_AC_COMPONENT definition
from the headers and update the documentation accordingly.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: Changelog update

---
 Documentation/firmware-guide/acpi/debug.rst |    1 -
 drivers/acpi/ac.c                           |   12 +++++-------
 drivers/acpi/sysfs.c                        |    1 -
 include/acpi/acpi_drivers.h                 |    1 -
 4 files changed, 5 insertions(+), 10 deletions(-)

Index: linux-pm/Documentation/firmware-guide/acpi/debug.rst
===================================================================
--- linux-pm.orig/Documentation/firmware-guide/acpi/debug.rst
+++ linux-pm/Documentation/firmware-guide/acpi/debug.rst
@@ -52,7 +52,6 @@ shows the supported mask values, current
     ACPI_CA_DISASSEMBLER            0x00000800
     ACPI_COMPILER                   0x00001000
     ACPI_TOOLS                      0x00002000
-    ACPI_AC_COMPONENT               0x00020000
     ACPI_BATTERY_COMPONENT          0x00040000
     ACPI_BUTTON_COMPONENT           0x00080000
     ACPI_SBS_COMPONENT              0x00100000
Index: linux-pm/drivers/acpi/ac.c
===================================================================
--- linux-pm.orig/drivers/acpi/ac.c
+++ linux-pm/drivers/acpi/ac.c
@@ -28,9 +28,6 @@
 #define ACPI_AC_STATUS_ONLINE		0x01
 #define ACPI_AC_STATUS_UNKNOWN		0xFF
 
-#define _COMPONENT		ACPI_AC_COMPONENT
-ACPI_MODULE_NAME("ac");
-
 MODULE_AUTHOR("Paul Diefenbaugh");
 MODULE_DESCRIPTION("ACPI AC Adapter Driver");
 MODULE_LICENSE("GPL");
@@ -102,8 +99,9 @@ static int acpi_ac_get_state(struct acpi
 	status = acpi_evaluate_integer(ac->device->handle, "_PSR", NULL,
 				       &ac->state);
 	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, status,
-				"Error reading AC Adapter state"));
+		acpi_handle_info(ac->device->handle,
+				"Error reading AC Adapter state: %s\n",
+				acpi_format_exception(status));
 		ac->state = ACPI_AC_STATUS_UNKNOWN;
 		return -ENODEV;
 	}
@@ -153,8 +151,8 @@ static void acpi_ac_notify(struct acpi_d
 
 	switch (event) {
 	default:
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Unsupported event [0x%x]\n", event));
+		acpi_handle_debug(device->handle, "Unsupported event [0x%x]\n",
+				  event);
 		fallthrough;
 	case ACPI_AC_NOTIFY_STATUS:
 	case ACPI_NOTIFY_BUS_CHECK:
Index: linux-pm/drivers/acpi/sysfs.c
===================================================================
--- linux-pm.orig/drivers/acpi/sysfs.c
+++ linux-pm/drivers/acpi/sysfs.c
@@ -52,7 +52,6 @@ static const struct acpi_dlayer acpi_deb
 	ACPI_DEBUG_INIT(ACPI_COMPILER),
 	ACPI_DEBUG_INIT(ACPI_TOOLS),
 
-	ACPI_DEBUG_INIT(ACPI_AC_COMPONENT),
 	ACPI_DEBUG_INIT(ACPI_BATTERY_COMPONENT),
 	ACPI_DEBUG_INIT(ACPI_BUTTON_COMPONENT),
 	ACPI_DEBUG_INIT(ACPI_SBS_COMPONENT),
Index: linux-pm/include/acpi/acpi_drivers.h
===================================================================
--- linux-pm.orig/include/acpi/acpi_drivers.h
+++ linux-pm/include/acpi/acpi_drivers.h
@@ -15,7 +15,6 @@
  * Please update drivers/acpi/debug.c and Documentation/firmware-guide/acpi/debug.rst
  * if you add to this list.
  */
-#define ACPI_AC_COMPONENT		0x00020000
 #define ACPI_BATTERY_COMPONENT		0x00040000
 #define ACPI_BUTTON_COMPONENT		0x00080000
 #define ACPI_SBS_COMPONENT		0x00100000



