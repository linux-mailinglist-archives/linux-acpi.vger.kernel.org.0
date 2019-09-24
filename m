Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A35BCBCC5C
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Sep 2019 18:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbfIXQWx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 24 Sep 2019 12:22:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40320 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfIXQWw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Sep 2019 12:22:52 -0400
Received: by mail-wr1-f65.google.com with SMTP id l3so2647186wru.7;
        Tue, 24 Sep 2019 09:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H5K9dwGeehPsNkiitTIYE3/RrG3fUirzCIs9ZbU18EE=;
        b=F+YNMRdITAs15Q0iaRGGNa/MDxVQBLbZq0oTRIfjUtLhaNq9LcqvH7g6olQxJGY+es
         M+8Q2Pr5/6bZzaZkrvyaaQ3Ld8HJgWrjR8fDLHJ0ZMVTWvJiOLjjyuzLtJle299GSC9c
         88a2f3d2Xd+cG52U3bU7Mp5rORbnYu/AjvmOXcREss3f+x39xPDhIoHIhb5LPg4O1qZM
         KJa9OQ3IEdcdBIS2PXb99mG/Y4v/5l/oktSMcqw/DZA12ypt4N3hQa4AvNmGnRSnMHId
         THBi48fvXE9/4UyCmrnzoYD4XbYJhFHAyTa/Ly8WlipBD0STD7yFwjKA0eUZ5l/MEPfh
         J2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H5K9dwGeehPsNkiitTIYE3/RrG3fUirzCIs9ZbU18EE=;
        b=AYMOP/ZonQtuFW0Crd0ShIjvYBRr/RBLgFiAp779ntNuCnDyp8ly6eQ4RQaf1/RKM1
         W9RLeEkzvifPB3bbjzcbmrosU+0yx3hdJ5bu7El6/EUhPDvN/t9ejrw9pfTFgnUTudlA
         P5R6nWZpXh1D+u8oNI1q86Njig98zxvUdfGySoKGbM4FeO9uLO5UVjEFncJLYlI+eZqW
         ApqxczfoeXwW6asWuSGGN4SED7hnfyq9dthI0WVh6ITBWSBS9qiswZDxZ1LZ7gZmhv3M
         GVaO3SqvOgeWNrGfCzrZAFCHuTGaO0bm6aTttVUD38MU2EDVpFhcx0VDkVJUx9t12BKK
         UYjg==
X-Gm-Message-State: APjAAAV8bzSpn3OWaYCxdPCHb3LFEwEn6enno20hfpnNTFhE5O3XAD1d
        dyp5n3gImhZqniq+bovL02c=
X-Google-Smtp-Source: APXvYqzjwYNuqhoYIohg5Bhrh8eYI5GxG/gohNhcrXlvOtx9Ixns3gIoJ44/qg3/t/1k0+xnzqJw7w==
X-Received: by 2002:adf:f287:: with SMTP id k7mr3368327wro.206.1569342169590;
        Tue, 24 Sep 2019 09:22:49 -0700 (PDT)
Received: from xws.fritz.box (pD9E5AB82.dip0.t-ipconnect.de. [217.229.171.130])
        by smtp.gmail.com with ESMTPSA id z9sm3907871wrp.26.2019.09.24.09.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 09:22:48 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH v2] serdev: Add ACPI devices by ResourceSource field
Date:   Tue, 24 Sep 2019 18:22:26 +0200
Message-Id: <20190924162226.1493407-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

When registering a serdev controller, ACPI needs to be checked for
devices attached to it. Currently, all immediate children of the ACPI
node of the controller are assumed to be UART client devices for this
controller. Furthermore, these devices are not searched elsewhere.

This is incorrect: Similar to SPI and I2C devices, the UART client
device definition (via UARTSerialBusV2) can reside anywhere in the ACPI
namespace as resource definition inside the _CRS method and points to
the controller via its ResourceSource field. This field may either
contain a fully qualified or relative path, indicating the controller
device. To address this, we need to walk over the whole ACPI namespace,
looking at each resource definition, and match the client device to the
controller via this field.

This patch is based on the existing acpi serial bus implementations in
drivers/i2c/i2c-core-acpi.c and drivers/spi/spi.c, specifically commit
4c3c59544f33e97cf8557f27e05a9904ead16363 ("spi/acpi: enumerate all SPI
slaves in the namespace").

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
Changes compared to v1:
- Patch now reflects the behavior of the existing ACPI serial bus
  implementations (drivers/i2c/i2c-core-acpi.c and drivers/spi/spi.c),
  with a maximum of one serdev client device per ACPI device node
  allocated.

- Ignores and continues on errors from AML code execution and resource
  parsing.

Notes:
  The resource lookup is kept generic (similarly to the implementations
  it is based on), meaning that it should be fairly simple to extend
  acpi_serdev_parse_resource and acpi_serdev_check_resources to get and
  return more information about the serdev client device (e.g. initial
  baud rate) once this is required.

  If multiple device definitions inside a single _CRS block ever become
  a concern, the lookup function can be instructed as to which
  UARTSerialBusV2 resource should be considered by spefifying its index
  in acpi_serdev_lookup.index. This is again based on the I2C
  implementation. Currently the last resource definition is chosen (i.e.
  index = -1) to reflect the behavior of the other ACPI serial bus
  implementations.
---
 drivers/tty/serdev/core.c | 111 +++++++++++++++++++++++++++++++++-----
 1 file changed, 99 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index a0ac16ee6575..226adeec2aed 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -552,16 +552,97 @@ static int of_serdev_register_devices(struct serdev_controller *ctrl)
 }
 
 #ifdef CONFIG_ACPI
+
+#define SERDEV_ACPI_MAX_SCAN_DEPTH 32
+
+struct acpi_serdev_lookup {
+	acpi_handle device_handle;
+	acpi_handle controller_handle;
+	int n;
+	int index;
+};
+
+static int acpi_serdev_parse_resource(struct acpi_resource *ares, void *data)
+{
+	struct acpi_serdev_lookup *lookup = data;
+	struct acpi_resource_uart_serialbus *sb;
+	acpi_status status;
+
+	if (ares->type != ACPI_RESOURCE_TYPE_SERIAL_BUS)
+		return 1;
+
+	if (ares->data.common_serial_bus.type != ACPI_RESOURCE_SERIAL_TYPE_UART)
+		return 1;
+
+	if (lookup->index != -1 && lookup->n++ != lookup->index)
+		return 1;
+
+	sb = &ares->data.uart_serial_bus;
+
+	status = acpi_get_handle(lookup->device_handle,
+				 sb->resource_source.string_ptr,
+				 &lookup->controller_handle);
+	if (ACPI_FAILURE(status))
+		return 1;
+
+	/*
+	 * NOTE: Ideally, we would also want to retreive other properties here,
+	 * once setting them before opening the device is supported by serdev.
+	 */
+
+	return 1;
+}
+
+static int acpi_serdev_do_lookup(struct acpi_device *adev,
+                                 struct acpi_serdev_lookup *lookup)
+{
+	struct list_head resource_list;
+	int ret;
+
+	lookup->device_handle = acpi_device_handle(adev);
+	lookup->controller_handle = NULL;
+	lookup->n = 0;
+
+	INIT_LIST_HEAD(&resource_list);
+	ret = acpi_dev_get_resources(adev, &resource_list,
+				     acpi_serdev_parse_resource, lookup);
+	acpi_dev_free_resource_list(&resource_list);
+
+	if (ret < 0)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int acpi_serdev_check_resources(struct serdev_controller *ctrl,
+				       struct acpi_device *adev)
+{
+	struct acpi_serdev_lookup lookup;
+	int ret;
+
+	if (acpi_bus_get_status(adev) || !adev->status.present)
+		return -EINVAL;
+
+	/* Look for UARTSerialBusV2 resource */
+	lookup.index = -1;	// we only care for the last device
+
+	ret = acpi_serdev_do_lookup(adev, &lookup);
+	if (ret)
+		return ret;
+
+	/* Make sure controller and ResourceSource handle match */
+	if (ACPI_HANDLE(ctrl->dev.parent) != lookup.controller_handle)
+		return -ENODEV;
+
+	return 0;
+}
+
 static acpi_status acpi_serdev_register_device(struct serdev_controller *ctrl,
-					    struct acpi_device *adev)
+					       struct acpi_device *adev)
 {
-	struct serdev_device *serdev = NULL;
+	struct serdev_device *serdev;
 	int err;
 
-	if (acpi_bus_get_status(adev) || !adev->status.present ||
-	    acpi_device_enumerated(adev))
-		return AE_OK;
-
 	serdev = serdev_device_alloc(ctrl);
 	if (!serdev) {
 		dev_err(&ctrl->dev, "failed to allocate serdev device for %s\n",
@@ -583,7 +664,7 @@ static acpi_status acpi_serdev_register_device(struct serdev_controller *ctrl,
 }
 
 static acpi_status acpi_serdev_add_device(acpi_handle handle, u32 level,
-				       void *data, void **return_value)
+					  void *data, void **return_value)
 {
 	struct serdev_controller *ctrl = data;
 	struct acpi_device *adev;
@@ -591,22 +672,28 @@ static acpi_status acpi_serdev_add_device(acpi_handle handle, u32 level,
 	if (acpi_bus_get_device(handle, &adev))
 		return AE_OK;
 
+	if (acpi_device_enumerated(adev))
+		return AE_OK;
+
+	if (acpi_serdev_check_resources(ctrl, adev))
+		return AE_OK;
+
 	return acpi_serdev_register_device(ctrl, adev);
 }
 
+
 static int acpi_serdev_register_devices(struct serdev_controller *ctrl)
 {
 	acpi_status status;
-	acpi_handle handle;
 
-	handle = ACPI_HANDLE(ctrl->dev.parent);
-	if (!handle)
+	if (!has_acpi_companion(ctrl->dev.parent))
 		return -ENODEV;
 
-	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, 1,
+	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
+				     SERDEV_ACPI_MAX_SCAN_DEPTH,
 				     acpi_serdev_add_device, NULL, ctrl, NULL);
 	if (ACPI_FAILURE(status))
-		dev_dbg(&ctrl->dev, "failed to enumerate serdev slaves\n");
+		dev_warn(&ctrl->dev, "failed to enumerate serdev slaves\n");
 
 	if (!ctrl->serdev)
 		return -ENODEV;
-- 
2.23.0

