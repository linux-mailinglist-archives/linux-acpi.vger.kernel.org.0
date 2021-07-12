Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB8F3C61E3
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jul 2021 19:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235646AbhGLRb2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Jul 2021 13:31:28 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:50650 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235694AbhGLRb2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Jul 2021 13:31:28 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.1.0)
 id ce6edfc1f50ac715; Mon, 12 Jul 2021 19:28:38 +0200
Received: from kreacher.localnet (89-64-82-45.dynamic.chello.pl [89.64.82.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 4DA1A669C37;
        Mon, 12 Jul 2021 19:28:37 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>
Subject: [PATCH v1 4/6] ACPI: glue: Eliminate acpi_platform_notify()
Date:   Mon, 12 Jul 2021 19:25:55 +0200
Message-ID: <8790139.CDJkKcVGEf@kreacher>
In-Reply-To: <2780027.e9J7NaK4W3@kreacher>
References: <2780027.e9J7NaK4W3@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.64.82.45
X-CLIENT-HOSTNAME: 89-64-82-45.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddruddvgdduudduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvjeelgffhiedukedtleekkedvudfggefhgfegjefgueekjeelvefggfdvledutdenucfkphepkeelrdeigedrkedvrdegheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeekledrieegrdekvddrgeehpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehv
 ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgvihhkkhhirdhkrhhoghgvrhhusheslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Get rid of acpi_platform_notify() which is redundant and
make device_platform_notify() in the driver core call
acpi_device_notify() and acpi_device_notify_remove() directly.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/glue.c  |   19 ++-----------------
 drivers/base/core.c  |    7 ++++---
 include/linux/acpi.h |   10 ++++------
 3 files changed, 10 insertions(+), 26 deletions(-)

Index: linux-pm/drivers/base/core.c
===================================================================
--- linux-pm.orig/drivers/base/core.c
+++ linux-pm/drivers/base/core.c
@@ -2005,9 +2005,10 @@ device_platform_notify(struct device *de
 {
 	int ret;
 
-	ret = acpi_platform_notify(dev, action);
-	if (ret)
-		return ret;
+	if (action == KOBJ_ADD)
+		acpi_device_notify(dev);
+	else if (action == KOBJ_REMOVE)
+		acpi_device_notify_remove(dev);
 
 	ret = software_node_notify(dev, action);
 	if (ret)
Index: linux-pm/include/linux/acpi.h
===================================================================
--- linux-pm.orig/include/linux/acpi.h
+++ linux-pm/include/linux/acpi.h
@@ -1380,13 +1380,11 @@ static inline int find_acpi_cpu_cache_to
 #endif
 
 #ifdef CONFIG_ACPI
-extern int acpi_platform_notify(struct device *dev, enum kobject_action action);
+extern void acpi_device_notify(struct device *dev);
+extern void acpi_device_notify_remove(struct device *dev);
 #else
-static inline int
-acpi_platform_notify(struct device *dev, enum kobject_action action)
-{
-	return 0;
-}
+static inline void acpi_device_notify(struct device *dev) { }
+static inline void acpi_device_notify_remove(struct device *dev) { }
 #endif
 
 #endif	/*_LINUX_ACPI_H*/
Index: linux-pm/drivers/acpi/glue.c
===================================================================
--- linux-pm.orig/drivers/acpi/glue.c
+++ linux-pm/drivers/acpi/glue.c
@@ -285,7 +285,7 @@ int acpi_unbind_one(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(acpi_unbind_one);
 
-static void acpi_device_notify(struct device *dev)
+void acpi_device_notify(struct device *dev)
 {
 	struct acpi_bus_type *type = acpi_get_bus_type(dev);
 	struct acpi_device *adev;
@@ -324,7 +324,7 @@ err:
 	dev_dbg(dev, "No ACPI support\n");
 }
 
-static void acpi_device_notify_remove(struct device *dev)
+void acpi_device_notify_remove(struct device *dev)
 {
 	struct acpi_device *adev = ACPI_COMPANION(dev);
 	struct acpi_bus_type *type;
@@ -340,18 +340,3 @@ static void acpi_device_notify_remove(st
 
 	acpi_unbind_one(dev);
 }
-
-int acpi_platform_notify(struct device *dev, enum kobject_action action)
-{
-	switch (action) {
-	case KOBJ_ADD:
-		acpi_device_notify(dev);
-		break;
-	case KOBJ_REMOVE:
-		acpi_device_notify_remove(dev);
-		break;
-	default:
-		break;
-	}
-	return 0;
-}



