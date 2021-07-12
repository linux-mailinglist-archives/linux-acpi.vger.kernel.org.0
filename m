Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4AFE3C61EA
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jul 2021 19:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235757AbhGLRbe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Jul 2021 13:31:34 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:45690 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235724AbhGLRbc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Jul 2021 13:31:32 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.1.0)
 id 388f45206587b73e; Mon, 12 Jul 2021 19:28:42 +0200
Received: from kreacher.localnet (89-64-82-45.dynamic.chello.pl [89.64.82.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id E0543669C37;
        Mon, 12 Jul 2021 19:28:41 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>
Subject: [PATCH v1 1/6] ACPI: glue: Rearrange acpi_device_notify()
Date:   Mon, 12 Jul 2021 19:23:32 +0200
Message-ID: <1860890.PYKUYFuaPT@kreacher>
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

Make the code flow in acpi_device_notify() more straightforward and
make it use dev_dbg() and acpi_handle_debug() for printing debug
messages.

The only expected functional impact of this change is the content of
the debug messages printed by acpi_device_notify().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/glue.c |   30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

Index: linux-pm/drivers/acpi/glue.c
===================================================================
--- linux-pm.orig/drivers/acpi/glue.c
+++ linux-pm/drivers/acpi/glue.c
@@ -292,22 +292,21 @@ static int acpi_device_notify(struct dev
 	int ret;
 
 	ret = acpi_bind_one(dev, NULL);
-	if (ret && type) {
-		struct acpi_device *adev;
+	if (ret) {
+		if (!type)
+			goto err;
 
 		adev = type->find_companion(dev);
 		if (!adev) {
-			pr_debug("Unable to get handle for %s\n", dev_name(dev));
+			dev_dbg(dev, "ACPI companion not found\n");
 			ret = -ENODEV;
-			goto out;
+			goto err;
 		}
 		ret = acpi_bind_one(dev, adev);
 		if (ret)
-			goto out;
+			goto err;
 	}
 	adev = ACPI_COMPANION(dev);
-	if (!adev)
-		goto out;
 
 	if (dev_is_platform(dev))
 		acpi_configure_pmsi_domain(dev);
@@ -317,16 +316,13 @@ static int acpi_device_notify(struct dev
 	else if (adev->handler && adev->handler->bind)
 		adev->handler->bind(dev);
 
- out:
-	if (!ret) {
-		struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
-
-		acpi_get_name(ACPI_HANDLE(dev), ACPI_FULL_PATHNAME, &buffer);
-		pr_debug("Device %s -> %s\n", dev_name(dev), (char *)buffer.pointer);
-		kfree(buffer.pointer);
-	} else {
-		pr_debug("Device %s -> No ACPI support\n", dev_name(dev));
-	}
+	acpi_handle_debug(ACPI_HANDLE(dev), "Bound to device %s\n",
+			  dev_name(dev));
+
+	return 0;
+
+err:
+	dev_dbg(dev, "No ACPI support\n");
 
 	return ret;
 }



