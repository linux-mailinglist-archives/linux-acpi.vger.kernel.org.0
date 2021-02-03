Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA2AD30E2D9
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Feb 2021 19:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbhBCSwG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Feb 2021 13:52:06 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:46594 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbhBCSwB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Feb 2021 13:52:01 -0500
Received: from 89-64-80-249.dynamic.chello.pl (89.64.80.249) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.537)
 id 403957b0e42b8183; Wed, 3 Feb 2021 19:51:17 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Joe Perches <joe@perches.com>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH v3 3/5] ACPI: button: Clean up printing messages
Date:   Wed, 03 Feb 2021 19:46:14 +0100
Message-ID: <5061782.uJCyLE8JBt@kreacher>
In-Reply-To: <1961054.9MKZ8ejxOh@kreacher>
References: <2367702.B5bJTmGzJm@kreacher> <1991501.dpTHplkurC@kreacher> <1961054.9MKZ8ejxOh@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Replace the ACPI_DEBUG_PRINT() instance in button.c with an
acpi_handle_debug() call, drop the _COMPONENT and ACPI_MODULE_NAME()
definitions that are not used any more, drop the no longer needed
ACPI_BUTTON_COMPONENT definition from the headers and update the
documentation accordingly.

While at it, replace the direct printk() invocations with pr_info()
(that changes the excessive log level for some of them too) and drop
the unneeded PREFIX sybmbol definition from battery.c.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
---

v2 -> v3: Add R-by tag.

v1 -> v2: Changelog update.

---
 Documentation/firmware-guide/acpi/debug.rst |    1 -
 drivers/acpi/button.c                       |   15 +++++----------
 drivers/acpi/sysfs.c                        |    1 -
 include/acpi/acpi_drivers.h                 |    1 -
 4 files changed, 5 insertions(+), 13 deletions(-)

Index: linux-pm/drivers/acpi/button.c
===================================================================
--- linux-pm.orig/drivers/acpi/button.c
+++ linux-pm/drivers/acpi/button.c
@@ -21,8 +21,6 @@
 #include <linux/dmi.h>
 #include <acpi/button.h>
 
-#define PREFIX "ACPI: "
-
 #define ACPI_BUTTON_CLASS		"button"
 #define ACPI_BUTTON_FILE_STATE		"state"
 #define ACPI_BUTTON_TYPE_UNKNOWN	0x00
@@ -54,9 +52,6 @@ static const char * const lid_init_state
 	[ACPI_BUTTON_LID_INIT_DISABLED]		= "disabled",
 };
 
-#define _COMPONENT		ACPI_BUTTON_COMPONENT
-ACPI_MODULE_NAME("button");
-
 MODULE_AUTHOR("Paul Diefenbaugh");
 MODULE_DESCRIPTION("ACPI Button Driver");
 MODULE_LICENSE("GPL");
@@ -285,7 +280,7 @@ static int acpi_button_add_fs(struct acp
 		return 0;
 
 	if (acpi_button_dir || acpi_lid_dir) {
-		printk(KERN_ERR PREFIX "More than one Lid device found!\n");
+		pr_info("More than one Lid device found!\n");
 		return -EEXIST;
 	}
 
@@ -434,8 +429,8 @@ static void acpi_button_notify(struct ac
 		}
 		break;
 	default:
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Unsupported event [0x%x]\n", event));
+		acpi_handle_debug(device->handle, "Unsupported event [0x%x]\n",
+				  event);
 		break;
 	}
 }
@@ -523,7 +518,7 @@ static int acpi_button_add(struct acpi_d
 			ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_LID);
 		input->open = acpi_lid_input_open;
 	} else {
-		printk(KERN_ERR PREFIX "Unsupported hid [%s]\n", hid);
+		pr_info("Unsupported hid [%s]\n", hid);
 		error = -ENODEV;
 		goto err_free_input;
 	}
@@ -567,7 +562,7 @@ static int acpi_button_add(struct acpi_d
 	}
 
 	device_init_wakeup(&device->dev, true);
-	printk(KERN_INFO PREFIX "%s [%s]\n", name, acpi_device_bid(device));
+	pr_info("%s [%s]\n", name, acpi_device_bid(device));
 	return 0;
 
  err_remove_fs:
Index: linux-pm/Documentation/firmware-guide/acpi/debug.rst
===================================================================
--- linux-pm.orig/Documentation/firmware-guide/acpi/debug.rst
+++ linux-pm/Documentation/firmware-guide/acpi/debug.rst
@@ -52,7 +52,6 @@ shows the supported mask values, current
     ACPI_CA_DISASSEMBLER            0x00000800
     ACPI_COMPILER                   0x00001000
     ACPI_TOOLS                      0x00002000
-    ACPI_BUTTON_COMPONENT           0x00080000
     ACPI_SBS_COMPONENT              0x00100000
     ACPI_FAN_COMPONENT              0x00200000
     ACPI_PCI_COMPONENT              0x00400000
Index: linux-pm/drivers/acpi/sysfs.c
===================================================================
--- linux-pm.orig/drivers/acpi/sysfs.c
+++ linux-pm/drivers/acpi/sysfs.c
@@ -52,7 +52,6 @@ static const struct acpi_dlayer acpi_deb
 	ACPI_DEBUG_INIT(ACPI_COMPILER),
 	ACPI_DEBUG_INIT(ACPI_TOOLS),
 
-	ACPI_DEBUG_INIT(ACPI_BUTTON_COMPONENT),
 	ACPI_DEBUG_INIT(ACPI_SBS_COMPONENT),
 	ACPI_DEBUG_INIT(ACPI_FAN_COMPONENT),
 	ACPI_DEBUG_INIT(ACPI_PCI_COMPONENT),
Index: linux-pm/include/acpi/acpi_drivers.h
===================================================================
--- linux-pm.orig/include/acpi/acpi_drivers.h
+++ linux-pm/include/acpi/acpi_drivers.h
@@ -15,7 +15,6 @@
  * Please update drivers/acpi/debug.c and Documentation/firmware-guide/acpi/debug.rst
  * if you add to this list.
  */
-#define ACPI_BUTTON_COMPONENT		0x00080000
 #define ACPI_SBS_COMPONENT		0x00100000
 #define ACPI_FAN_COMPONENT		0x00200000
 #define ACPI_PCI_COMPONENT		0x00400000



