Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB563A9D81
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jun 2021 16:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbhFPO2Y (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Jun 2021 10:28:24 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:42852 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbhFPO2Y (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Jun 2021 10:28:24 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.1.0)
 id 54a95c72461561b5; Wed, 16 Jun 2021 16:26:16 +0200
Received: from kreacher.localnet (89-64-81-4.dynamic.chello.pl [89.64.81.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 399FA669926;
        Wed, 16 Jun 2021 16:26:16 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 5/5] ACPI: scan: Fix race related to dropping dependencies
Date:   Wed, 16 Jun 2021 16:25:32 +0200
Message-ID: <3070024.5fSG56mABF@kreacher>
In-Reply-To: <3140195.44csPzL39Z@kreacher>
References: <3140195.44csPzL39Z@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.64.81.4
X-CLIENT-HOSTNAME: 89-64-81-4.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrfedvledgjeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvjeelgffhiedukedtleekkedvudfggefhgfegjefgueekjeelvefggfdvledutdenucfkphepkeelrdeigedrkedurdegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepkeelrdeigedrkedurdegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhguvghgohgvuggvsehrvgguhhgrthdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If acpi_add_single_object() runs concurrently with respect to
acpi_scan_clear_dep() which deletes a dependencies list entry where
the device being added is the consumer, the device's dep_unmet
counter may not be updated to reflect that change.

Namely, if the dependencies list entry is deleted right after
calling acpi_scan_dep_init() and before calling acpi_device_add(),
acpi_scan_clear_dep() will not find the device object corresponding
to the consumer device ACPI handle and it will not update its
dep_unmet counter to reflect the deletion of the list entry.
Consequently, the dep_unmet counter of the device will never
become zero going forward which may prevent it from being
completely enumerated.

To address this problem, modify acpi_add_single_object() to run
acpi_tie_acpi_dev(), to attach the ACPI device object created by it
to the corresponding ACPI namespace node, under acpi_dep_list_lock
along with acpi_scan_dep_init() whenever the latter is called.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c |   46 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 13 deletions(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -657,16 +657,12 @@ static int acpi_tie_acpi_dev(struct acpi
 	return 0;
 }
 
-int acpi_device_add(struct acpi_device *device,
-		    void (*release)(struct device *))
+int __acpi_device_add(struct acpi_device *device,
+		      void (*release)(struct device *))
 {
 	struct acpi_device_bus_id *acpi_device_bus_id;
 	int result;
 
-	result = acpi_tie_acpi_dev(device);
-	if (result)
-		return result;
-
 	/*
 	 * Linkage
 	 * -------
@@ -755,6 +751,17 @@ err_unlock:
 	return result;
 }
 
+int acpi_device_add(struct acpi_device *adev, void (*release)(struct device *))
+{
+	int ret;
+
+	ret = acpi_tie_acpi_dev(adev);
+	if (ret)
+		return ret;
+
+	return __acpi_device_add(adev, release);
+}
+
 /* --------------------------------------------------------------------------
                                  Device Enumeration
    -------------------------------------------------------------------------- */
@@ -1681,14 +1688,10 @@ static void acpi_scan_dep_init(struct ac
 {
 	struct acpi_dep_data *dep;
 
-	mutex_lock(&acpi_dep_list_lock);
-
 	list_for_each_entry(dep, &acpi_dep_list, node) {
 		if (dep->consumer == adev->handle)
 			adev->dep_unmet++;
 	}
-
-	mutex_unlock(&acpi_dep_list_lock);
 }
 
 void acpi_device_add_finalize(struct acpi_device *device)
@@ -1707,6 +1710,7 @@ static int acpi_add_single_object(struct
 				  acpi_handle handle, int type, bool dep_init)
 {
 	struct acpi_device *device;
+	bool release_dep_lock = false;
 	int result;
 
 	device = kzalloc(sizeof(struct acpi_device), GFP_KERNEL);
@@ -1720,16 +1724,32 @@ static int acpi_add_single_object(struct
 	 * this must be done before the get power-/wakeup_dev-flags calls.
 	 */
 	if (type == ACPI_BUS_TYPE_DEVICE || type == ACPI_BUS_TYPE_PROCESSOR) {
-		if (dep_init)
+		if (dep_init) {
+			mutex_lock(&acpi_dep_list_lock);
+			/*
+			 * Hold the lock until the acpi_tie_acpi_dev() call
+			 * below to prevent concurrent acpi_scan_clear_dep()
+			 * from deleting a dependency list entry without
+			 * updating dep_unmet for the device.
+			 */
+			release_dep_lock = true;
 			acpi_scan_dep_init(device);
-
+		}
 		acpi_scan_init_status(device);
 	}
 
 	acpi_bus_get_power_flags(device);
 	acpi_bus_get_wakeup_device_flags(device);
 
-	result = acpi_device_add(device, acpi_device_release);
+	result = acpi_tie_acpi_dev(device);
+
+	if (release_dep_lock)
+		mutex_unlock(&acpi_dep_list_lock);
+
+	if (result)
+		return result;
+
+	result = __acpi_device_add(device, acpi_device_release);
 	if (result) {
 		acpi_device_release(&device->dev);
 		return result;



