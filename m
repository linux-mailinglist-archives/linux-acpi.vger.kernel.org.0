Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB41F2BC210
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Nov 2020 21:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgKUUay (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 21 Nov 2020 15:30:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27375 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728402AbgKUUay (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 21 Nov 2020 15:30:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605990652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NS6++THCjQt8F/nyZ7tB/jnyYNnDzYzVyxOVUprHeKU=;
        b=TDP5vhc/0NYTWWygWm9puQZbb2YA0Ived5Q97gH+SJMLPdaWq5fmWSFH6rURA8/bplLSrs
        gEWG4s8zxJ9LWARLSG8ZcNCFlOlLxn8saDffzV+LvRj5U4i0KId8LDyPyUEJcBw3zk73Y6
        Oy+Cn6lbr33KZKjk8Vi7XWu3AMypIX4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-mdN7A9DWPS2MZGZh6oPhGA-1; Sat, 21 Nov 2020 15:30:50 -0500
X-MC-Unique: mdN7A9DWPS2MZGZh6oPhGA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B99F809DCC;
        Sat, 21 Nov 2020 20:30:49 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-24.ams2.redhat.com [10.36.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7457C18E4F;
        Sat, 21 Nov 2020 20:30:46 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org
Subject: [PATCH 4/7] ACPI: scan: Split root scanning into 2 steps
Date:   Sat, 21 Nov 2020 21:30:37 +0100
Message-Id: <20201121203040.146252-5-hdegoede@redhat.com>
In-Reply-To: <20201121203040.146252-1-hdegoede@redhat.com>
References: <20201121203040.146252-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The ACPI scan code currently does not honor _DEP lists, except
for ACPI battery nodes.

This is an issue on some devices, where some of the methods used during
device-addition may rely on OpRegions of other devices.

An example of this is the Acer Switch 10E SW3-016 model. The _HID method
of the ACPI node for the UART attached Bluetooth, reads GPIOs to detect
the installed wifi chip and update the _HID for the Bluetooth's ACPI node
accordingly. The current ACPI scan code calls _HID before the GPIO
controller's OpRegions are available, leading to the wrong _HID being
used and Bluetooth not working.

This splits the scanning into 2 steps, deferring the addition of some
devices which need access to OpRegions of other devices during scanning
to the second step.

This initial implementation takes a very simple approach to identify
which devices need to have their device-addition deferred. It uses a
static lists of HIDs for this. This list is initially populated with
the HID reported for the Bluetooth on the Acer SW3-016. This uses the
HID reported when the GPIO OpRegions are not yet available!

A more elaborate approach, which actually looks at the _DEP list will
be added by a follow up patch. This other approach has a big chance
of causing regressions, so for now it will be hidden behind a kernel
commandline option. Which is why the KISS approach chosen here is needed
to fix the issue at hand, so that things will work OOTB on affected
devices.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1665610
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/scan.c | 65 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 7dde66222648..407c8536568b 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -42,6 +42,15 @@ DEFINE_MUTEX(acpi_device_lock);
 LIST_HEAD(acpi_wakeup_device_list);
 static DEFINE_MUTEX(acpi_hp_context_lock);
 
+/*
+ * Variables for the new 2 step scan scheme:
+ * Step 1. Add all devices for which acpi_should_defer_add() returns false
+ * Step 2. Add devices deferred during phase 1.
+ * These are protected by the acpi_scan_lock.
+ */
+static bool acpi_check_defer_add;
+static LIST_HEAD(acpi_deferred_devices);
+
 /*
  * The UART device described by the SPCR table is the only object which needs
  * special-casing. Everything else is covered by ACPI namespace paths in STAO
@@ -55,6 +64,11 @@ struct acpi_dep_data {
 	acpi_handle slave;
 };
 
+struct acpi_deferred_dev {
+	struct list_head node;
+	acpi_handle handle;
+};
+
 void acpi_scan_lock_acquire(void)
 {
 	mutex_lock(&acpi_scan_lock);
@@ -741,6 +755,16 @@ static const char * const acpi_ignore_dep_hids[] = {
 	NULL
 };
 
+/*
+ * List of HIDs for which we defer adding them to the second step of the
+ * scanning of the root, because some of their methods used during addition
+ * depend on OpRegions registered by the drivers for other ACPI devices.
+ */
+static const char * const acpi_defer_add_hids[] = {
+	"BCM2E5B", /* Acer SW3-016 bluetooth HID when GPIO OpRegs or not available yet */
+	NULL
+};
+
 static struct acpi_device *acpi_bus_get_parent(acpi_handle handle)
 {
 	struct acpi_device *device = NULL;
@@ -1631,18 +1655,42 @@ void acpi_device_add_finalize(struct acpi_device *device)
 	kobject_uevent(&device->dev.kobj, KOBJ_ADD);
 }
 
+static bool acpi_should_defer_add(acpi_handle handle, struct acpi_device_info *info)
+{
+	if (!acpi_check_defer_add || !info)
+		return false;
+
+	if (acpi_info_matches_hids(info, acpi_defer_add_hids))
+		return true;
+
+	return false;
+}
+
 static int acpi_add_single_object(struct acpi_device **child,
 				  acpi_handle handle, int type,
 				  unsigned long long sta)
 {
 	int result;
 	struct acpi_device *device;
+	struct acpi_deferred_dev *deferred_dev;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	struct acpi_device_info *info = NULL;
 
 	if (handle != ACPI_ROOT_OBJECT && type == ACPI_BUS_TYPE_DEVICE)
 		acpi_get_object_info(handle, &info);
 
+	if (acpi_should_defer_add(handle, info)) {
+		kfree(info);
+
+		deferred_dev = kzalloc(sizeof(*deferred_dev), GFP_KERNEL);
+		if (!deferred_dev)
+			return -ENOMEM;
+
+		deferred_dev->handle = handle;
+		list_add_tail(&deferred_dev->node, &acpi_deferred_devices);
+		return -EPROBE_DEFER;
+	}
+
 	device = kzalloc(sizeof(struct acpi_device), GFP_KERNEL);
 	if (!device) {
 		printk(KERN_ERR PREFIX "Memory allocation error\n");
@@ -2201,6 +2249,7 @@ int __init acpi_scan_init(void)
 	int result;
 	acpi_status status;
 	struct acpi_table_stao *stao_ptr;
+	struct acpi_deferred_dev *deferred_dev, *tmp;
 
 	acpi_pci_root_init();
 	acpi_pci_link_init();
@@ -2248,7 +2297,9 @@ int __init acpi_scan_init(void)
 	/*
 	 * Enumerate devices in the ACPI namespace.
 	 */
+	acpi_check_defer_add = true;
 	result = acpi_bus_scan(ACPI_ROOT_OBJECT);
+	acpi_check_defer_add = false;
 	if (result)
 		goto cleanup;
 
@@ -2256,6 +2307,15 @@ int __init acpi_scan_init(void)
 	if (result)
 		goto cleanup;
 
+	list_for_each_entry_safe(deferred_dev, tmp, &acpi_deferred_devices, node) {
+		result = acpi_bus_scan(deferred_dev->handle);
+		if (result)
+			goto cleanup;
+
+		list_del(&deferred_dev->node);
+		kfree(deferred_dev);
+	}
+
 	/* Fixed feature devices do not exist on HW-reduced platform */
 	if (!acpi_gbl_reduced_hardware) {
 		result = acpi_bus_scan_fixed();
@@ -2275,6 +2335,11 @@ int __init acpi_scan_init(void)
 		put_device(&acpi_root->dev);
 	}
 
+	list_for_each_entry_safe(deferred_dev, tmp, &acpi_deferred_devices, node) {
+		list_del(&deferred_dev->node);
+		kfree(deferred_dev);
+	}
+
 	mutex_unlock(&acpi_scan_lock);
 	return result;
 }
-- 
2.28.0

