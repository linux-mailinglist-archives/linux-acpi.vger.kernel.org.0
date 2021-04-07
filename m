Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE627356EC2
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Apr 2021 16:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245157AbhDGOeQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 7 Apr 2021 10:34:16 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:42118 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352977AbhDGOeD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Apr 2021 10:34:03 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.0.3)
 id ebc5461653ed92d7; Wed, 7 Apr 2021 16:33:53 +0200
Received: from kreacher.localnet (89-64-81-116.dynamic.chello.pl [89.64.81.116])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 69565669203;
        Wed,  7 Apr 2021 16:33:52 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v1 5/5] ACPI: scan: Call acpi_get_object_info() from acpi_set_pnp_ids()
Date:   Wed, 07 Apr 2021 16:33:38 +0200
Message-ID: <2137295.iZASKD2KPV@kreacher>
In-Reply-To: <2192169.ElGaqSPkdT@kreacher>
References: <2192169.ElGaqSPkdT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.64.81.116
X-CLIENT-HOSTNAME: 89-64-81-116.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrudejjedgjeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvjeelgffhiedukedtleekkedvudfggefhgfegjefgueekjeelvefggfdvledutdenucfkphepkeelrdeigedrkedurdduudeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepkeelrdeigedrkedurdduudeipdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhguvghgohgvuggvsehrvgguhhgrthdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Notice that it is not necessary to call acpi_get_object_info() from
acpi_add_single_object() in order to pass the pointer returned by it
to acpi_init_device_object() and from there to acpi_set_pnp_ids().

It is more straightforward to call acpi_get_object_info() from
acpi_set_pnp_ids() and avoid unnecessary pointer passing, so change
the code accordingly.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/internal.h |    2 +-
 drivers/acpi/power.c    |    2 +-
 drivers/acpi/scan.c     |   21 +++++++++------------
 3 files changed, 11 insertions(+), 14 deletions(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -1307,8 +1307,9 @@ static bool acpi_object_is_system_bus(ac
 }
 
 static void acpi_set_pnp_ids(acpi_handle handle, struct acpi_device_pnp *pnp,
-				int device_type, struct acpi_device_info *info)
+			     int device_type)
 {
+	struct acpi_device_info *info = NULL;
 	struct acpi_pnp_device_id_list *cid_list;
 	int i;
 
@@ -1319,6 +1320,7 @@ static void acpi_set_pnp_ids(acpi_handle
 			break;
 		}
 
+		acpi_get_object_info(handle, &info);
 		if (!info) {
 			pr_err(PREFIX "%s: Error reading device info\n",
 					__func__);
@@ -1344,6 +1346,8 @@ static void acpi_set_pnp_ids(acpi_handle
 		if (info->valid & ACPI_VALID_CLS)
 			acpi_add_id(pnp, info->class_code.string);
 
+		kfree(info);
+
 		/*
 		 * Some devices don't reliably have _HIDs & _CIDs, so add
 		 * synthetic HIDs to make sure drivers can find them.
@@ -1649,7 +1653,7 @@ static bool acpi_device_enumeration_by_p
 }
 
 void acpi_init_device_object(struct acpi_device *device, acpi_handle handle,
-			     int type, struct acpi_device_info *info)
+			     int type)
 {
 	INIT_LIST_HEAD(&device->pnp.ids);
 	device->device_type = type;
@@ -1658,7 +1662,7 @@ void acpi_init_device_object(struct acpi
 	fwnode_init(&device->fwnode, &acpi_device_fwnode_ops);
 	acpi_set_device_status(device, ACPI_STA_DEFAULT);
 	acpi_device_get_busid(device);
-	acpi_set_pnp_ids(handle, &device->pnp, type, info);
+	acpi_set_pnp_ids(handle, &device->pnp, type);
 	acpi_init_properties(device);
 	acpi_bus_get_flags(device);
 	device->flags.match_driver = false;
@@ -1688,21 +1692,14 @@ static void acpi_scan_init_status(struct
 static int acpi_add_single_object(struct acpi_device **child,
 				  acpi_handle handle, int type)
 {
-	struct acpi_device_info *info = NULL;
 	struct acpi_device *device;
 	int result;
 
-	if (type == ACPI_BUS_TYPE_DEVICE && handle != ACPI_ROOT_OBJECT)
-		acpi_get_object_info(handle, &info);
-
 	device = kzalloc(sizeof(struct acpi_device), GFP_KERNEL);
-	if (!device) {
-		kfree(info);
+	if (!device)
 		return -ENOMEM;
-	}
 
-	acpi_init_device_object(device, handle, type, info);
-	kfree(info);
+	acpi_init_device_object(device, handle, type);
 	/*
 	 * Getting the status is delayed till here so that we can call
 	 * acpi_bus_get_status() and use its quirk handling.  Note that
Index: linux-pm/drivers/acpi/internal.h
===================================================================
--- linux-pm.orig/drivers/acpi/internal.h
+++ linux-pm/drivers/acpi/internal.h
@@ -109,7 +109,7 @@ struct acpi_device_bus_id {
 int acpi_device_add(struct acpi_device *device,
 		    void (*release)(struct device *));
 void acpi_init_device_object(struct acpi_device *device, acpi_handle handle,
-			     int type, struct acpi_device_info *info);
+			     int type);
 int acpi_device_setup_files(struct acpi_device *dev);
 void acpi_device_remove_files(struct acpi_device *dev);
 void acpi_device_add_finalize(struct acpi_device *device);
Index: linux-pm/drivers/acpi/power.c
===================================================================
--- linux-pm.orig/drivers/acpi/power.c
+++ linux-pm/drivers/acpi/power.c
@@ -925,7 +925,7 @@ int acpi_add_power_resource(acpi_handle
 		return -ENOMEM;
 
 	device = &resource->device;
-	acpi_init_device_object(device, handle, ACPI_BUS_TYPE_POWER, NULL);
+	acpi_init_device_object(device, handle, ACPI_BUS_TYPE_POWER);
 	mutex_init(&resource->resource_lock);
 	INIT_LIST_HEAD(&resource->list_node);
 	INIT_LIST_HEAD(&resource->dependents);



