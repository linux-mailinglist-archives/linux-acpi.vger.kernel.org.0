Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E834E3C61DF
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jul 2021 19:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbhGLRbZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Jul 2021 13:31:25 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:61526 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234742AbhGLRbY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Jul 2021 13:31:24 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.1.0)
 id e09e8c5f6ca796ac; Mon, 12 Jul 2021 19:28:35 +0200
Received: from kreacher.localnet (89-64-82-45.dynamic.chello.pl [89.64.82.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 2E631669C37;
        Mon, 12 Jul 2021 19:28:34 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>
Subject: [PATCH v1 6/6] driver core: Split device_platform_notify()
Date:   Mon, 12 Jul 2021 19:28:16 +0200
Message-ID: <7971483.NyiUUSuA9g@kreacher>
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

Split device_platform_notify_remove) out of device_platform_notify()
and call the latter on device addition and the former on device
removal.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/core.c |   37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

Index: linux-pm/drivers/base/core.c
===================================================================
--- linux-pm.orig/drivers/base/core.c
+++ linux-pm/drivers/base/core.c
@@ -2000,24 +2000,24 @@ static inline int device_is_not_partitio
 }
 #endif
 
-static int
-device_platform_notify(struct device *dev, enum kobject_action action)
+static void device_platform_notify(struct device *dev)
 {
-	if (action == KOBJ_ADD)
-		acpi_device_notify(dev);
-	else if (action == KOBJ_REMOVE)
-		acpi_device_notify_remove(dev);
-
-	if (action == KOBJ_ADD)
-		software_node_notify(dev);
-	else if (action == KOBJ_REMOVE)
-		software_node_notify_remove(dev);
+	acpi_device_notify(dev);
 
-	if (platform_notify && action == KOBJ_ADD)
+	software_node_notify(dev);
+
+	if (platform_notify)
 		platform_notify(dev);
-	else if (platform_notify_remove && action == KOBJ_REMOVE)
+}
+
+static void device_platform_notify_remove(struct device *dev)
+{
+	acpi_device_notify_remove(dev);
+
+	software_node_notify_remove(dev);
+
+	if (platform_notify_remove)
 		platform_notify_remove(dev);
-	return 0;
 }
 
 /**
@@ -3289,9 +3289,7 @@ int device_add(struct device *dev)
 	}
 
 	/* notify platform of device entry */
-	error = device_platform_notify(dev, KOBJ_ADD);
-	if (error)
-		goto platform_error;
+	device_platform_notify(dev);
 
 	error = device_create_file(dev, &dev_attr_uevent);
 	if (error)
@@ -3394,8 +3392,7 @@ done:
  SymlinkError:
 	device_remove_file(dev, &dev_attr_uevent);
  attrError:
-	device_platform_notify(dev, KOBJ_REMOVE);
-platform_error:
+	device_platform_notify_remove(dev);
 	kobject_uevent(&dev->kobj, KOBJ_REMOVE);
 	glue_dir = get_glue_dir(dev);
 	kobject_del(&dev->kobj);
@@ -3540,7 +3537,7 @@ void device_del(struct device *dev)
 	bus_remove_device(dev);
 	device_pm_remove(dev);
 	driver_deferred_probe_del(dev);
-	device_platform_notify(dev, KOBJ_REMOVE);
+	device_platform_notify_remove(dev);
 	device_remove_properties(dev);
 	device_links_purge(dev);
 



