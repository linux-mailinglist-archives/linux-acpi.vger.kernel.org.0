Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED7CC3C61E8
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jul 2021 19:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235715AbhGLRbc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Jul 2021 13:31:32 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:52404 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235721AbhGLRbb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Jul 2021 13:31:31 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.1.0)
 id 570fb929db1951ce; Mon, 12 Jul 2021 19:28:41 +0200
Received: from kreacher.localnet (89-64-82-45.dynamic.chello.pl [89.64.82.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 65377669C37;
        Mon, 12 Jul 2021 19:28:40 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>
Subject: [PATCH v1 2/6] ACPI: glue: Change return type of two functions to void
Date:   Mon, 12 Jul 2021 19:23:37 +0200
Message-ID: <21118671.EfDdHjke4D@kreacher>
In-Reply-To: <2780027.e9J7NaK4W3@kreacher>
References: <2780027.e9J7NaK4W3@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.64.82.45
X-CLIENT-HOSTNAME: 89-64-82-45.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddruddvgdduudduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvjeelgffhiedukedtleekkedvudfggefhgfegjefgueekjeelvefggfdvledutdenucfkphepkeelrdeigedrkedvrdegheenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepihhnvghtpeekledrieegrdekvddrgeehpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehv
 ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgvihhkkhhirdhkrhhoghgvrhhusheslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since the return values of acpi_device_notify() and
acpi_device_notify_remove() are discarded by their only caller,
change their return type to void.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/glue.c |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

Index: linux-pm/drivers/acpi/glue.c
===================================================================
--- linux-pm.orig/drivers/acpi/glue.c
+++ linux-pm/drivers/acpi/glue.c
@@ -285,7 +285,7 @@ int acpi_unbind_one(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(acpi_unbind_one);
 
-static int acpi_device_notify(struct device *dev)
+static void acpi_device_notify(struct device *dev)
 {
 	struct acpi_bus_type *type = acpi_get_bus_type(dev);
 	struct acpi_device *adev;
@@ -299,7 +299,6 @@ static int acpi_device_notify(struct dev
 		adev = type->find_companion(dev);
 		if (!adev) {
 			dev_dbg(dev, "ACPI companion not found\n");
-			ret = -ENODEV;
 			goto err;
 		}
 		ret = acpi_bind_one(dev, adev);
@@ -319,21 +318,19 @@ static int acpi_device_notify(struct dev
 	acpi_handle_debug(ACPI_HANDLE(dev), "Bound to device %s\n",
 			  dev_name(dev));
 
-	return 0;
+	return;
 
 err:
 	dev_dbg(dev, "No ACPI support\n");
-
-	return ret;
 }
 
-static int acpi_device_notify_remove(struct device *dev)
+static void acpi_device_notify_remove(struct device *dev)
 {
 	struct acpi_device *adev = ACPI_COMPANION(dev);
 	struct acpi_bus_type *type;
 
 	if (!adev)
-		return 0;
+		return;
 
 	type = acpi_get_bus_type(dev);
 	if (type && type->cleanup)
@@ -342,7 +339,6 @@ static int acpi_device_notify_remove(str
 		adev->handler->unbind(dev);
 
 	acpi_unbind_one(dev);
-	return 0;
 }
 
 int acpi_platform_notify(struct device *dev, enum kobject_action action)



