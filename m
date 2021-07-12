Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E17DF3C61E5
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jul 2021 19:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235694AbhGLRba (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Jul 2021 13:31:30 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:50048 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235715AbhGLRb3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Jul 2021 13:31:29 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.1.0)
 id 076ee53e60d13b75; Mon, 12 Jul 2021 19:28:39 +0200
Received: from kreacher.localnet (89-64-82-45.dynamic.chello.pl [89.64.82.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id C410C669C38;
        Mon, 12 Jul 2021 19:28:38 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>
Subject: [PATCH v1 3/6] ACPI: bus: Rename functions to avoid name collision
Date:   Mon, 12 Jul 2021 19:24:50 +0200
Message-ID: <3605918.kQq0lBPeGt@kreacher>
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

There is a name collision between acpi_device_notify() defined in
bus.c and another static function defined in glue.c.

Since the latter is going to be exported from that file, rename the
former to acpi_notify_device() and rename acpi_device_notify_fixed()
to follow the same naming pattern.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/bus.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/acpi/bus.c
===================================================================
--- linux-pm.orig/drivers/acpi/bus.c
+++ linux-pm/drivers/acpi/bus.c
@@ -498,24 +498,24 @@ static void acpi_bus_notify(acpi_handle
 	acpi_evaluate_ost(handle, type, ost_code, NULL);
 }
 
-static void acpi_device_notify(acpi_handle handle, u32 event, void *data)
+static void acpi_notify_device(acpi_handle handle, u32 event, void *data)
 {
 	struct acpi_device *device = data;
 
 	device->driver->ops.notify(device, event);
 }
 
-static void acpi_device_notify_fixed(void *data)
+static void acpi_notify_device_fixed(void *data)
 {
 	struct acpi_device *device = data;
 
 	/* Fixed hardware devices have no handles */
-	acpi_device_notify(NULL, ACPI_FIXED_HARDWARE_EVENT, device);
+	acpi_notify_device(NULL, ACPI_FIXED_HARDWARE_EVENT, device);
 }
 
 static u32 acpi_device_fixed_event(void *data)
 {
-	acpi_os_execute(OSL_NOTIFY_HANDLER, acpi_device_notify_fixed, data);
+	acpi_os_execute(OSL_NOTIFY_HANDLER, acpi_notify_device_fixed, data);
 	return ACPI_INTERRUPT_HANDLED;
 }
 
@@ -536,7 +536,7 @@ static int acpi_device_install_notify_ha
 	else
 		status = acpi_install_notify_handler(device->handle,
 						     ACPI_DEVICE_NOTIFY,
-						     acpi_device_notify,
+						     acpi_notify_device,
 						     device);
 
 	if (ACPI_FAILURE(status))
@@ -554,7 +554,7 @@ static void acpi_device_remove_notify_ha
 						acpi_device_fixed_event);
 	else
 		acpi_remove_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
-					   acpi_device_notify);
+					   acpi_notify_device);
 }
 
 /* Handle events targeting \_SB device (at present only graceful shutdown) */



