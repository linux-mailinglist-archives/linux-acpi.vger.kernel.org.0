Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEF673A9CEE
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jun 2021 16:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbhFPOIA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Jun 2021 10:08:00 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:64714 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbhFPOIA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Jun 2021 10:08:00 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.1.0)
 id 54e0344117152d93; Wed, 16 Jun 2021 16:05:52 +0200
Received: from kreacher.localnet (89-64-81-4.dynamic.chello.pl [89.64.81.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 15B6D66993E;
        Wed, 16 Jun 2021 16:05:52 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] ACPI: scan: Simplify acpi_table_events_fn()
Date:   Wed, 16 Jun 2021 16:05:50 +0200
Message-ID: <4649754.GXAFRqVoOG@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.64.81.4
X-CLIENT-HOSTNAME: 89-64-81-4.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrfedvledgjeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpefhgedtffejheekgeeljeevvedtuefgffeiieejuddutdekgfejvdehueejjeetvdenucfkphepkeelrdeigedrkedurdegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepkeelrdeigedrkedurdegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=2 Fuz1=2 Fuz2=2
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Notice that the table field of struct acpi_table_events_work is never
read and its event field is always equal to ACPI_TABLE_EVENT_LOAD, so
both of them are redundant.

Accordingly, drop struct acpi_table_events_work and use struct
work_struct directly instead of it, simplify acpi_scan_table_handler()
and rename it to acpi_scan_table_notify().

Moreover, make acpi_bus_table_handler() check the event code against
ACPI_TABLE_EVENT_LOAD before calling acpi_scan_table_notify(), so it
is not necessary to do that check in the latter.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/bus.c      |    3 ++-
 drivers/acpi/internal.h |    2 +-
 drivers/acpi/scan.c     |   38 ++++++++++----------------------------
 3 files changed, 13 insertions(+), 30 deletions(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -2471,46 +2471,28 @@ int __init __acpi_probe_device_table(str
 	return count;
 }
 
-struct acpi_table_events_work {
-	struct work_struct work;
-	void *table;
-	u32 event;
-};
-
 static void acpi_table_events_fn(struct work_struct *work)
 {
-	struct acpi_table_events_work *tew;
-
-	tew = container_of(work, struct acpi_table_events_work, work);
-
-	if (tew->event == ACPI_TABLE_EVENT_LOAD) {
-		acpi_scan_lock_acquire();
-		acpi_bus_scan(ACPI_ROOT_OBJECT);
-		acpi_scan_lock_release();
-	}
+	acpi_scan_lock_acquire();
+	acpi_bus_scan(ACPI_ROOT_OBJECT);
+	acpi_scan_lock_release();
 
-	kfree(tew);
+	kfree(work);
 }
 
-void acpi_scan_table_handler(u32 event, void *table, void *context)
+void acpi_scan_table_notify(void)
 {
-	struct acpi_table_events_work *tew;
+	struct work_struct *work;
 
 	if (!acpi_scan_initialized)
 		return;
 
-	if (event != ACPI_TABLE_EVENT_LOAD)
+	work = kmalloc(sizeof(*work), GFP_KERNEL);
+	if (!work)
 		return;
 
-	tew = kmalloc(sizeof(*tew), GFP_KERNEL);
-	if (!tew)
-		return;
-
-	INIT_WORK(&tew->work, acpi_table_events_fn);
-	tew->table = table;
-	tew->event = event;
-
-	schedule_work(&tew->work);
+	INIT_WORK(work, acpi_table_events_fn);
+	schedule_work(work);
 }
 
 int acpi_reconfig_notifier_register(struct notifier_block *nb)
Index: linux-pm/drivers/acpi/bus.c
===================================================================
--- linux-pm.orig/drivers/acpi/bus.c
+++ linux-pm/drivers/acpi/bus.c
@@ -1195,7 +1195,8 @@ void __init acpi_subsystem_init(void)
 
 static acpi_status acpi_bus_table_handler(u32 event, void *table, void *context)
 {
-	acpi_scan_table_handler(event, table, context);
+	if (event == ACPI_TABLE_EVENT_LOAD)
+		acpi_scan_table_notify();
 
 	return acpi_sysfs_table_handler(event, table, context);
 }
Index: linux-pm/drivers/acpi/internal.h
===================================================================
--- linux-pm.orig/drivers/acpi/internal.h
+++ linux-pm/drivers/acpi/internal.h
@@ -86,7 +86,7 @@ void acpi_device_hotplug(struct acpi_dev
 bool acpi_scan_is_offline(struct acpi_device *adev, bool uevent);
 
 acpi_status acpi_sysfs_table_handler(u32 event, void *table, void *context);
-void acpi_scan_table_handler(u32 event, void *table, void *context);
+void acpi_scan_table_notify(void);
 
 /* --------------------------------------------------------------------------
                      Device Node Initialization / Removal



