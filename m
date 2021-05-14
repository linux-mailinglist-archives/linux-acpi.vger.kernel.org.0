Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4846338104D
	for <lists+linux-acpi@lfdr.de>; Fri, 14 May 2021 21:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbhENTKF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 May 2021 15:10:05 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:57016 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbhENTKF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 14 May 2021 15:10:05 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.0.5)
 id c477499158a19fbb; Fri, 14 May 2021 21:08:52 +0200
Received: from kreacher.localnet (89-64-80-69.dynamic.chello.pl [89.64.80.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 9599D66969F;
        Fri, 14 May 2021 21:08:51 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] ACPI: PM / fan: Put fan device IDs into separate header file
Date:   Fri, 14 May 2021 21:08:51 +0200
Message-ID: <11763292.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.64.80.69
X-CLIENT-HOSTNAME: 89-64-80-69.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrvdehkedggedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpefhgedtffejheekgeeljeevvedtuefgffeiieejuddutdekgfejvdehueejjeetvdenucfkphepkeelrdeigedrkedtrdeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeekledrieegrdektddrieelpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=2 Fuz1=2 Fuz2=2
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The ACPI fan device IDs are shared between the fan driver and the
device power management code.  The former is modular, so it needs
to include the table of device IDs for module autoloading and the
latter needs that list to avoid attaching the generic ACPI PM domain
to fan devices (which doesn't make sense) possibly before the fan
driver module is loaded.

Unfortunately, that requires the list of fan device IDs to be
updated in two places which is prone to mistakes, so put it into
a symbol definition in a separate header file so there is only one
copy of it in case it needs to be updated again in the future.

Fixes: b9ea0bae260f ("ACPI: PM: Avoid attaching ACPI PM domain to certain devices")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/device_pm.c |    6 ++----
 drivers/acpi/fan.c       |    7 +++----
 drivers/acpi/fan.h       |   13 +++++++++++++
 3 files changed, 18 insertions(+), 8 deletions(-)

Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -20,6 +20,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/suspend.h>
 
+#include "fan.h"
 #include "internal.h"
 
 /**
@@ -1310,10 +1311,7 @@ int acpi_dev_pm_attach(struct device *de
 	 * with the generic ACPI PM domain.
 	 */
 	static const struct acpi_device_id special_pm_ids[] = {
-		{"PNP0C0B", }, /* Generic ACPI fan */
-		{"INT3404", }, /* Fan */
-		{"INTC1044", }, /* Fan for Tiger Lake generation */
-		{"INTC1048", }, /* Fan for Alder Lake generation */
+		ACPI_FAN_DEVICE_IDS,
 		{}
 	};
 	struct acpi_device *adev = ACPI_COMPANION(dev);
Index: linux-pm/drivers/acpi/fan.c
===================================================================
--- linux-pm.orig/drivers/acpi/fan.c
+++ linux-pm/drivers/acpi/fan.c
@@ -16,6 +16,8 @@
 #include <linux/platform_device.h>
 #include <linux/sort.h>
 
+#include "fan.h"
+
 MODULE_AUTHOR("Paul Diefenbaugh");
 MODULE_DESCRIPTION("ACPI Fan Driver");
 MODULE_LICENSE("GPL");
@@ -24,10 +26,7 @@ static int acpi_fan_probe(struct platfor
 static int acpi_fan_remove(struct platform_device *pdev);
 
 static const struct acpi_device_id fan_device_ids[] = {
-	{"PNP0C0B", 0},
-	{"INT3404", 0},
-	{"INTC1044", 0},
-	{"INTC1048", 0},
+	ACPI_FAN_DEVICE_IDS,
 	{"", 0},
 };
 MODULE_DEVICE_TABLE(acpi, fan_device_ids);
Index: linux-pm/drivers/acpi/fan.h
===================================================================
--- /dev/null
+++ linux-pm/drivers/acpi/fan.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+/*
+ * ACPI fan device IDs are shared between the fan driver and the device power
+ * management code.
+ *
+ * Add new device IDs before the generic ACPI fan one.
+ */
+#define ACPI_FAN_DEVICE_IDS	\
+	{"INT3404", }, /* Fan */ \
+	{"INTC1044", }, /* Fan for Tiger Lake generation */ \
+	{"INTC1048", }, /* Fan for Alder Lake generation */ \
+	{"PNP0C0B", } /* Generic ACPI fan */



