Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC08B3243E0
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Feb 2021 19:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbhBXSm3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 24 Feb 2021 13:42:29 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:47084 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbhBXSm2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Feb 2021 13:42:28 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_smtp) via UNIX with SMTP (IdeaSmtpServer 0.83.537)
 id ea52b9e47c7a2361; Wed, 24 Feb 2021 19:41:46 +0100
Received: from kreacher.localnet (89-64-80-80.dynamic.chello.pl [89.64.80.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 6B73066152E;
        Wed, 24 Feb 2021 19:41:45 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Platform Driver <platform-driver-x86@vger.kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH v1] platform: x86: ACPI: Get rid of ACPICA message printing
Date:   Wed, 24 Feb 2021 19:41:44 +0100
Message-ID: <2074665.VPHYfYaQb6@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrkeejgdduudegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkggfgtgesthfuredttddtvdenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeevudefgfeguedtjedvhfetveegleduveeuvedvjeekleefhfduhfefheekffefveenucfkphepkeelrdeigedrkedtrdektdenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepihhnvghtpeekledrieegrdektddrkedtpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtohepphhlrghtfhhorhhmqdgurhhivhgvrhdqgiekieesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehguhhohhgrnhhjuhhnsehhuhgrfigvihdrtghomhdprhgtphhtthhopehhuggvghhovgguvges
 rhgvughhrghtrdgtohhmpdhrtghpthhtohephihurdgtrdgthhgvnhesihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

A few x86 platform drivers use ACPI_DEBUG_PRINT() or ACPI_EXCEPTION()
for printing messages, but that is questionable, because those macros
belong to ACPICA and they should not be used elsewhere.  In addition,
ACPI_DEBUG_PRINT() requires special enabling to allow it to actually
print the message, which is a nuisance, and the _COMPONENT symbol
generally needed for that is not defined in any of the files in
question.

For this reason, replace the ACPI_DEBUG_PRINT() in lg-laptop.c with
pr_debug() and the one in xo15-ebook.c with acpi_handle_debug()
(with the additional benefit that the source object can be identified
more easily after this change), and replace the ACPI_EXCEPTION() in
acer-wmi.c with pr_warn().

Also drop the ACPI_MODULE_NAME() definitions that are only used by
the ACPICA message printing macros from those files and from wmi.c
and surfacepro3_button.c (while at it).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/surface/surfacepro3_button.c |    2 --
 drivers/platform/x86/acer-wmi.c               |    4 ++--
 drivers/platform/x86/lg-laptop.c              |    2 +-
 drivers/platform/x86/wmi.c                    |    1 -
 drivers/platform/x86/xo15-ebook.c             |    6 ++----
 5 files changed, 5 insertions(+), 10 deletions(-)

Index: linux-pm/drivers/platform/x86/lg-laptop.c
===================================================================
--- linux-pm.orig/drivers/platform/x86/lg-laptop.c
+++ linux-pm/drivers/platform/x86/lg-laptop.c
@@ -678,7 +678,7 @@ static int __init acpi_init(void)
 
 	result = acpi_bus_register_driver(&acpi_driver);
 	if (result < 0) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error registering driver\n"));
+		pr_debug("Error registering driver\n");
 		return -ENODEV;
 	}
 
Index: linux-pm/drivers/platform/x86/xo15-ebook.c
===================================================================
--- linux-pm.orig/drivers/platform/x86/xo15-ebook.c
+++ linux-pm/drivers/platform/x86/xo15-ebook.c
@@ -26,8 +26,6 @@
 #define XO15_EBOOK_HID			"XO15EBK"
 #define XO15_EBOOK_DEVICE_NAME		"EBook Switch"
 
-ACPI_MODULE_NAME(MODULE_NAME);
-
 MODULE_DESCRIPTION("OLPC XO-1.5 ebook switch driver");
 MODULE_LICENSE("GPL");
 
@@ -66,8 +64,8 @@ static void ebook_switch_notify(struct a
 		ebook_send_state(device);
 		break;
 	default:
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Unsupported event [0x%x]\n", event));
+		acpi_handle_debug(device->handle,
+				  "Unsupported event [0x%x]\n", event);
 		break;
 	}
 }
Index: linux-pm/drivers/platform/x86/acer-wmi.c
===================================================================
--- linux-pm.orig/drivers/platform/x86/acer-wmi.c
+++ linux-pm/drivers/platform/x86/acer-wmi.c
@@ -30,7 +30,6 @@
 #include <linux/input/sparse-keymap.h>
 #include <acpi/video.h>
 
-ACPI_MODULE_NAME(KBUILD_MODNAME);
 MODULE_AUTHOR("Carlos Corbacho");
 MODULE_DESCRIPTION("Acer Laptop WMI Extras Driver");
 MODULE_LICENSE("GPL");
@@ -1605,7 +1604,8 @@ static void acer_kbd_dock_get_initial_st
 
 	status = wmi_evaluate_method(WMID_GUID3, 0, 0x2, &input_buf, &output_buf);
 	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, status, "Error getting keyboard-dock initial status"));
+		pr_warn("Error getting keyboard-dock initial status: %s\n",
+			acpi_format_exception(status));
 		return;
 	}
 
Index: linux-pm/drivers/platform/surface/surfacepro3_button.c
===================================================================
--- linux-pm.orig/drivers/platform/surface/surfacepro3_button.c
+++ linux-pm/drivers/platform/surface/surfacepro3_button.c
@@ -40,8 +40,6 @@ static const guid_t MSHW0040_DSM_UUID =
 #define SURFACE_BUTTON_NOTIFY_PRESS_VOLUME_DOWN		0xc2
 #define SURFACE_BUTTON_NOTIFY_RELEASE_VOLUME_DOWN	0xc3
 
-ACPI_MODULE_NAME("surface pro 3 button");
-
 MODULE_AUTHOR("Chen Yu");
 MODULE_DESCRIPTION("Surface Pro3 Button Driver");
 MODULE_LICENSE("GPL v2");
Index: linux-pm/drivers/platform/x86/wmi.c
===================================================================
--- linux-pm.orig/drivers/platform/x86/wmi.c
+++ linux-pm/drivers/platform/x86/wmi.c
@@ -32,7 +32,6 @@
 #include <linux/fs.h>
 #include <uapi/linux/wmi.h>
 
-ACPI_MODULE_NAME("wmi");
 MODULE_AUTHOR("Carlos Corbacho");
 MODULE_DESCRIPTION("ACPI-WMI Mapping Driver");
 MODULE_LICENSE("GPL");



