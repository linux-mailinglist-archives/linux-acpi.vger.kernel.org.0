Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95BBC356EC4
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Apr 2021 16:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353058AbhDGOeR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 7 Apr 2021 10:34:17 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:53148 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352985AbhDGOeF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Apr 2021 10:34:05 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.0.3)
 id 3fefc9d137ea351f; Wed, 7 Apr 2021 16:33:54 +0200
Received: from kreacher.localnet (89-64-81-116.dynamic.chello.pl [89.64.81.116])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 86987669203;
        Wed,  7 Apr 2021 16:33:53 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v1 4/5] ACPI: scan: Drop sta argument from acpi_init_device_object()
Date:   Wed, 07 Apr 2021 16:32:43 +0200
Message-ID: <7894723.T7Z3S40VBb@kreacher>
In-Reply-To: <2192169.ElGaqSPkdT@kreacher>
References: <2192169.ElGaqSPkdT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.64.81.116
X-CLIENT-HOSTNAME: 89-64-81-116.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrudejjedgjeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvjeelgffhiedukedtleekkedvudfggefhgfegjefgueekjeelvefggfdvledutdenucfkphepkeelrdeigedrkedurdduudeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepkeelrdeigedrkedurdduudeipdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhguvghgohgvuggvsehrvgguhhgrthdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Use the observation that the initial status check for
ACPI_BUS_TYPE_PROCESSOR objects can be carried out in the same way
as for ACPI_BUS_TYPE_DEVICE objects and it is not necessary to fail
acpi_add_single_object() if acpi_bus_get_status_handle() returns an
error for a processor (its status can be set to 0 instead) to
simplify acpi_add_single_object().

Accordingly, drop the "sta" argument from acpi_init_device_object()
as it can always set the initial status to ACPI_STA_DEFAULT and let
its caller correct that later on.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/internal.h |    3 +--
 drivers/acpi/power.c    |    3 +--
 drivers/acpi/scan.c     |   28 ++++++++++++++--------------
 3 files changed, 16 insertions(+), 18 deletions(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -1649,15 +1649,14 @@ static bool acpi_device_enumeration_by_p
 }
 
 void acpi_init_device_object(struct acpi_device *device, acpi_handle handle,
-			     int type, unsigned long long sta,
-			     struct acpi_device_info *info)
+			     int type, struct acpi_device_info *info)
 {
 	INIT_LIST_HEAD(&device->pnp.ids);
 	device->device_type = type;
 	device->handle = handle;
 	device->parent = acpi_bus_get_parent(handle);
 	fwnode_init(&device->fwnode, &acpi_device_fwnode_ops);
-	acpi_set_device_status(device, sta);
+	acpi_set_device_status(device, ACPI_STA_DEFAULT);
 	acpi_device_get_busid(device);
 	acpi_set_pnp_ids(handle, &device->pnp, type, info);
 	acpi_init_properties(device);
@@ -1680,19 +1679,21 @@ void acpi_device_add_finalize(struct acp
 	kobject_uevent(&device->dev.kobj, KOBJ_ADD);
 }
 
+static void acpi_scan_init_status(struct acpi_device *adev)
+{
+	if (acpi_bus_get_status(adev))
+		acpi_set_device_status(adev, 0);
+}
+
 static int acpi_add_single_object(struct acpi_device **child,
 				  acpi_handle handle, int type)
 {
 	struct acpi_device_info *info = NULL;
-	unsigned long long sta = ACPI_STA_DEFAULT;
 	struct acpi_device *device;
 	int result;
 
 	if (type == ACPI_BUS_TYPE_DEVICE && handle != ACPI_ROOT_OBJECT)
 		acpi_get_object_info(handle, &info);
-	else if (type == ACPI_BUS_TYPE_PROCESSOR &&
-		 ACPI_FAILURE(acpi_bus_get_status_handle(handle, &sta)))
-		return -ENODEV;
 
 	device = kzalloc(sizeof(struct acpi_device), GFP_KERNEL);
 	if (!device) {
@@ -1700,16 +1701,15 @@ static int acpi_add_single_object(struct
 		return -ENOMEM;
 	}
 
-	acpi_init_device_object(device, handle, type, sta, info);
+	acpi_init_device_object(device, handle, type, info);
 	kfree(info);
 	/*
-	 * For ACPI_BUS_TYPE_DEVICE getting the status is delayed till here so
-	 * that we can call acpi_bus_get_status() and use its quirk handling.
-	 * Note this must be done before the get power-/wakeup_dev-flags calls.
+	 * Getting the status is delayed till here so that we can call
+	 * acpi_bus_get_status() and use its quirk handling.  Note that
+	 * this must be done before the get power-/wakeup_dev-flags calls.
 	 */
-	if (type == ACPI_BUS_TYPE_DEVICE)
-		if (acpi_bus_get_status(device) < 0)
-			acpi_set_device_status(device, 0);
+	if (type == ACPI_BUS_TYPE_DEVICE || type == ACPI_BUS_TYPE_PROCESSOR)
+		acpi_scan_init_status(device);
 
 	acpi_bus_get_power_flags(device);
 	acpi_bus_get_wakeup_device_flags(device);
Index: linux-pm/drivers/acpi/internal.h
===================================================================
--- linux-pm.orig/drivers/acpi/internal.h
+++ linux-pm/drivers/acpi/internal.h
@@ -109,8 +109,7 @@ struct acpi_device_bus_id {
 int acpi_device_add(struct acpi_device *device,
 		    void (*release)(struct device *));
 void acpi_init_device_object(struct acpi_device *device, acpi_handle handle,
-			     int type, unsigned long long sta,
-			     struct acpi_device_info *info);
+			     int type, struct acpi_device_info *info);
 int acpi_device_setup_files(struct acpi_device *dev);
 void acpi_device_remove_files(struct acpi_device *dev);
 void acpi_device_add_finalize(struct acpi_device *device);
Index: linux-pm/drivers/acpi/power.c
===================================================================
--- linux-pm.orig/drivers/acpi/power.c
+++ linux-pm/drivers/acpi/power.c
@@ -925,8 +925,7 @@ int acpi_add_power_resource(acpi_handle
 		return -ENOMEM;
 
 	device = &resource->device;
-	acpi_init_device_object(device, handle, ACPI_BUS_TYPE_POWER,
-				ACPI_STA_DEFAULT, NULL);
+	acpi_init_device_object(device, handle, ACPI_BUS_TYPE_POWER, NULL);
 	mutex_init(&resource->resource_lock);
 	INIT_LIST_HEAD(&resource->list_node);
 	INIT_LIST_HEAD(&resource->dependents);



