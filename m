Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6D4E321F95
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Feb 2021 20:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbhBVTEU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 Feb 2021 14:04:20 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:65068 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbhBVTDY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Feb 2021 14:03:24 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_smtp) via UNIX with SMTP (IdeaSmtpServer 0.83.537)
 id c3e939bef3a53db2; Mon, 22 Feb 2021 20:02:21 +0100
Received: from kreacher.localnet (89-64-81-242.dynamic.chello.pl [89.64.81.242])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 3ECD6662057;
        Mon, 22 Feb 2021 20:02:21 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH v1 2/4] ACPI: sysfs: Get rid of ACPICA message printing
Date:   Mon, 22 Feb 2021 19:59:54 +0100
Message-ID: <4357646.0lvgoTfV33@kreacher>
In-Reply-To: <5138173.kHyPcihzTF@kreacher>
References: <5138173.kHyPcihzTF@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrkeefgdduudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtvdenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpefgleehfffhtefflefhleetjeffteettefgteekjedvhfeffedtueefveegveeiveenucfkphepkeelrdeigedrkedurddvgedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepkeelrdeigedrkedurddvgedvpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhuohhhrghnjhhunheshhhurgifvghirdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Replace the only ACPI_EXCEPTION() instance in sysfs.c with a
pr_warn() call, drop the _COMPONENT and ACPI_MODULE_NAME()
definitions that are not used any more and drop the
ACPI_SYSTEM_COMPONENT definition that would not be used any
more in a meaningful way after the above changes.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/firmware-guide/acpi/debug.rst |    1 -
 drivers/acpi/sysfs.c                        |    7 +------
 include/acpi/acpi_drivers.h                 |    1 -
 3 files changed, 1 insertion(+), 8 deletions(-)

Index: linux-pm/drivers/acpi/sysfs.c
===================================================================
--- linux-pm.orig/drivers/acpi/sysfs.c
+++ linux-pm/drivers/acpi/sysfs.c
@@ -12,9 +12,6 @@
 
 #include "internal.h"
 
-#define _COMPONENT		ACPI_SYSTEM_COMPONENT
-ACPI_MODULE_NAME("sysfs");
-
 #ifdef CONFIG_ACPI_DEBUG
 /*
  * ACPI debug sysfs I/F, including:
@@ -55,7 +52,6 @@ static const struct acpi_dlayer acpi_deb
 	ACPI_DEBUG_INIT(ACPI_SBS_COMPONENT),
 	ACPI_DEBUG_INIT(ACPI_FAN_COMPONENT),
 	ACPI_DEBUG_INIT(ACPI_CONTAINER_COMPONENT),
-	ACPI_DEBUG_INIT(ACPI_SYSTEM_COMPONENT),
 	ACPI_DEBUG_INIT(ACPI_MEMORY_DEVICE_COMPONENT),
 };
 
@@ -650,8 +646,7 @@ static int get_status(u32 index, acpi_ev
 	if (index < num_gpes) {
 		status = acpi_get_gpe_device(index, handle);
 		if (ACPI_FAILURE(status)) {
-			ACPI_EXCEPTION((AE_INFO, AE_NOT_FOUND,
-					"Invalid GPE 0x%x", index));
+			pr_warn("Invalid GPE 0x%x", index);
 			return -ENXIO;
 		}
 		status = acpi_get_gpe_status(*handle, index, ret);
Index: linux-pm/Documentation/firmware-guide/acpi/debug.rst
===================================================================
--- linux-pm.orig/Documentation/firmware-guide/acpi/debug.rst
+++ linux-pm/Documentation/firmware-guide/acpi/debug.rst
@@ -55,7 +55,6 @@ shows the supported mask values, current
     ACPI_SBS_COMPONENT              0x00100000
     ACPI_FAN_COMPONENT              0x00200000
     ACPI_CONTAINER_COMPONENT        0x01000000
-    ACPI_SYSTEM_COMPONENT           0x02000000
     ACPI_MEMORY_DEVICE_COMPONENT    0x08000000
 
 debug_level
Index: linux-pm/include/acpi/acpi_drivers.h
===================================================================
--- linux-pm.orig/include/acpi/acpi_drivers.h
+++ linux-pm/include/acpi/acpi_drivers.h
@@ -18,7 +18,6 @@
 #define ACPI_SBS_COMPONENT		0x00100000
 #define ACPI_FAN_COMPONENT		0x00200000
 #define ACPI_CONTAINER_COMPONENT	0x01000000
-#define ACPI_SYSTEM_COMPONENT		0x02000000
 #define ACPI_MEMORY_DEVICE_COMPONENT	0x08000000
 
 /*



