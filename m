Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6332BC20E
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Nov 2020 21:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbgKUUat (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 21 Nov 2020 15:30:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27229 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728402AbgKUUat (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 21 Nov 2020 15:30:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605990647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M8Me/ZKPPF3zHjqioJTPV/mhYjuAHDncmz5kt3IdLmo=;
        b=hIY4dXNGpp0DRok1JGASwP4j0bm7eMwt148yRzrna3uv3NlRNK0bInlN8cL404qBNhazPF
        cg9p97039NcStVzaIuBFP4rK38XLTQDnvclrdU9PzO/oyqZqKI5f9jYORIdGnbSHG5n0SN
        XTTvMxycNt9pU7Zm69ijlyBAdwi20To=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-kO15xLITPMGmTchSb3TNPA-1; Sat, 21 Nov 2020 15:30:46 -0500
X-MC-Unique: kO15xLITPMGmTchSb3TNPA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E658E1005D70;
        Sat, 21 Nov 2020 20:30:44 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-24.ams2.redhat.com [10.36.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 016841C936;
        Sat, 21 Nov 2020 20:30:43 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org
Subject: [PATCH 2/7] ACPI: scan: Call acpi_get_object_info() from acpi_add_single_object()
Date:   Sat, 21 Nov 2020 21:30:35 +0100
Message-Id: <20201121203040.146252-3-hdegoede@redhat.com>
In-Reply-To: <20201121203040.146252-1-hdegoede@redhat.com>
References: <20201121203040.146252-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Call acpi_get_object_info() from acpi_add_single_object() instead of
calling it from acpi_set_pnp_ids() and pass the result down to the
acpi_set_pnp_ids() call.

This is a preparation patch for splitting the scanning of the root
into 2 steps, deferring the addition of some devices which need access
to OpRegions of other devices during scanning to the second step.

Having the acpi_device_info available earlier is useful for making
the decision on whether to defer the device addition or not, without
needing to make a second acpi_get_object_info() call.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/internal.h |  3 ++-
 drivers/acpi/power.c    |  2 +-
 drivers/acpi/scan.c     | 22 ++++++++++++----------
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index e3638bafb941..cb229e24c563 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -105,7 +105,8 @@ struct acpi_device_bus_id {
 int acpi_device_add(struct acpi_device *device,
 		    void (*release)(struct device *));
 void acpi_init_device_object(struct acpi_device *device, acpi_handle handle,
-			     int type, unsigned long long sta);
+			     int type, unsigned long long sta,
+			     struct acpi_device_info *info);
 int acpi_device_setup_files(struct acpi_device *dev);
 void acpi_device_remove_files(struct acpi_device *dev);
 void acpi_device_add_finalize(struct acpi_device *device);
diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 8048da85b7e0..189a0d4c6d06 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -939,7 +939,7 @@ int acpi_add_power_resource(acpi_handle handle)
 
 	device = &resource->device;
 	acpi_init_device_object(device, handle, ACPI_BUS_TYPE_POWER,
-				ACPI_STA_DEFAULT);
+				ACPI_STA_DEFAULT, NULL);
 	mutex_init(&resource->resource_lock);
 	INIT_LIST_HEAD(&resource->list_node);
 	INIT_LIST_HEAD(&resource->dependents);
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index e949265d5667..25a46ae24229 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1258,10 +1258,8 @@ static bool acpi_object_is_system_bus(acpi_handle handle)
 }
 
 static void acpi_set_pnp_ids(acpi_handle handle, struct acpi_device_pnp *pnp,
-				int device_type)
+				int device_type, struct acpi_device_info *info)
 {
-	acpi_status status;
-	struct acpi_device_info *info;
 	struct acpi_pnp_device_id_list *cid_list;
 	int i;
 
@@ -1272,8 +1270,7 @@ static void acpi_set_pnp_ids(acpi_handle handle, struct acpi_device_pnp *pnp,
 			break;
 		}
 
-		status = acpi_get_object_info(handle, &info);
-		if (ACPI_FAILURE(status)) {
+		if (!info) {
 			pr_err(PREFIX "%s: Error reading device info\n",
 					__func__);
 			return;
@@ -1298,8 +1295,6 @@ static void acpi_set_pnp_ids(acpi_handle handle, struct acpi_device_pnp *pnp,
 		if (info->valid & ACPI_VALID_CLS)
 			acpi_add_id(pnp, info->class_code.string);
 
-		kfree(info);
-
 		/*
 		 * Some devices don't reliably have _HIDs & _CIDs, so add
 		 * synthetic HIDs to make sure drivers can find them.
@@ -1605,7 +1600,8 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
 }
 
 void acpi_init_device_object(struct acpi_device *device, acpi_handle handle,
-			     int type, unsigned long long sta)
+			     int type, unsigned long long sta,
+			     struct acpi_device_info *info)
 {
 	INIT_LIST_HEAD(&device->pnp.ids);
 	device->device_type = type;
@@ -1614,7 +1610,7 @@ void acpi_init_device_object(struct acpi_device *device, acpi_handle handle,
 	device->fwnode.ops = &acpi_device_fwnode_ops;
 	acpi_set_device_status(device, sta);
 	acpi_device_get_busid(device);
-	acpi_set_pnp_ids(handle, &device->pnp, type);
+	acpi_set_pnp_ids(handle, &device->pnp, type, info);
 	acpi_init_properties(device);
 	acpi_bus_get_flags(device);
 	device->flags.match_driver = false;
@@ -1642,14 +1638,20 @@ static int acpi_add_single_object(struct acpi_device **child,
 	int result;
 	struct acpi_device *device;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct acpi_device_info *info = NULL;
+
+	if (handle != ACPI_ROOT_OBJECT && type == ACPI_BUS_TYPE_DEVICE)
+		acpi_get_object_info(handle, &info);
 
 	device = kzalloc(sizeof(struct acpi_device), GFP_KERNEL);
 	if (!device) {
 		printk(KERN_ERR PREFIX "Memory allocation error\n");
+		kfree(info);
 		return -ENOMEM;
 	}
 
-	acpi_init_device_object(device, handle, type, sta);
+	acpi_init_device_object(device, handle, type, sta, info);
+	kfree(info);
 	/*
 	 * For ACPI_BUS_TYPE_DEVICE getting the status is delayed till here so
 	 * that we can call acpi_bus_get_status() and use its quirk handling.
-- 
2.28.0

