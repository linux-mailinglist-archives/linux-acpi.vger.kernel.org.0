Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D93BB8202
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Sep 2019 21:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390163AbfIST4q (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 Sep 2019 15:56:46 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40753 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387854AbfIST4q (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Sep 2019 15:56:46 -0400
Received: by mail-wr1-f66.google.com with SMTP id l3so4384440wru.7;
        Thu, 19 Sep 2019 12:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KrhHWVyRHuQgUbyMmguMXRSYml5yBV9Jt6pBfOObHPo=;
        b=EgziUIECg9S5aRxVwIEHUQnmDkMIbeSwGZ+d8k1yqttlnKcQcB8980x4AZ02t+GPW2
         b4XEvPBepb0wGdJkppcF3lZn2aLBtI+sGAiEwn9P6ARdwmHFRTBEfw5EJ4oIR55poIIl
         HjUs2F0o33/r2Ohgr3JeZgInr5W9i87fspSHrWfYXw8VOqOL2PYx+7wj765jyP8HPKlh
         msNGb/yi7vJQMnpbq5vLKgJZypkZbyN+eBB1I4x2Y4QlshsJBgCsBJx22UhttVk+fHCq
         1GPLt7r7hoQEa3B8d5Oi9A1IjbEVG6N0KgwwsV+feFjQ9jtAV+tleh/mUandVGuWkqsN
         aDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KrhHWVyRHuQgUbyMmguMXRSYml5yBV9Jt6pBfOObHPo=;
        b=K8UiDsEiLta76995f+7IrfiVmm/qFaTAuS7iFt2wAix2ynK3igwrMSI+KsjLh1fvYQ
         5zq206+X9xzihqerDuJTkRzSJ73yNH9reJC6YbnrTkdiR9Bb1rg3AYH9gG94WVKu90ns
         c9HZoV2YRN1vHaiTVIsEYpge2bobMn6govMzrYcVrEfLLmOfthxawjorzCkF4IBkeXTG
         4R/jNSPXDgdlbnhga6jM3sfOdSa0u08BJNYN6EIc4FDbwv8QyOQ9RArLtzHdsLTntGuM
         30aGJZTN+pJoFnQnGuMJlPmM4p30R8kuqlnoMoqti65CKmnlIfV5qpU/zLeDl1Qzxnsc
         KyJA==
X-Gm-Message-State: APjAAAVpQwLV8j6px2LB8wajfKmequPRSAk+wyJYNRxxa7G6Z7yhTxg5
        DrnAEbT/4GiDFtDVl6mHy3g=
X-Google-Smtp-Source: APXvYqys2In+Oqd9HfyjYuY9xLlWMZng1jIJEYABpKBowJXuIUF91l5q4lModrLVq/MPIt/bpfUCFQ==
X-Received: by 2002:a5d:66cb:: with SMTP id k11mr7967835wrw.174.1568923003769;
        Thu, 19 Sep 2019 12:56:43 -0700 (PDT)
Received: from xws.fritz.box (pD9E5AB20.dip0.t-ipconnect.de. [217.229.171.32])
        by smtp.gmail.com with ESMTPSA id f143sm12311104wme.40.2019.09.19.12.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 12:56:43 -0700 (PDT)
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
Subject: [PATCH] serdev: Add ACPI devices by ResourceSource field
Date:   Thu, 19 Sep 2019 21:56:24 +0200
Message-Id: <20190919195624.1140941-1-luzmaximilian@gmail.com>
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

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
This patch is similar to the the implementations in drivers/spi/spi.c
(see commit 4c3c59544f33e97cf8557f27e05a9904ead16363) and
drivers/i2c/i2c-core-acpi.c. However, I think that there may be an
issues with these two implementations: Both walk over the whole ACPI
namespace, but only match the first SPI or I2C resource (respectively),
so I think there may be problems when multiple SPI or I2C resources are
defined under the same ACPI device node (as in second or third SPI/I2C
resource definitions being ignored). Please note, however, that I am by
no means qualified with regards to this, and this might be totally fine.
Nevertheless I'd appreciate if anyone with more knowledge on the subject
could have a look at it. This patch would avoid this problem (for UART)
by simply walking all resource definitions via acpi_walk_resources.

There is a further issue in the serdev ACPI implementation that this
patch does not address: ACPI UART resource definitions contain things
like the initial baud-rate, parity, flow-control, etc. As far as I know,
these things can currently only be set once the device is opened.
Furthermore, some option values, such as ParityTypeMark, are not (yet)
supported. I'd be willing to try and implement setting the currently
supported values based on ACPI for a future patch, if anyone can provide
me with some pointers on how to do that.

I have personally tested this patch on a Microsoft Surface Book 2, which
like all newer MS Surface devices has a UART EC, and it has been in use
(in some form or another) for a couple of months on other Surface
devices via a patched kernel [1, 2, 3]. I can, however, not speak for
any non-Microsoft devices or potential Apple ACPI quirks.

[1]: https://github.com/jakeday/linux-surface/
[2]: https://github.com/qzed/linux-surface/
[3]: https://github.com/qzed/linux-surfacegen5-acpi/

 drivers/tty/serdev/core.c | 64 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 56 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index a0ac16ee6575..1c8360deea77 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -582,18 +582,64 @@ static acpi_status acpi_serdev_register_device(struct serdev_controller *ctrl,
 	return AE_OK;
 }
 
-static acpi_status acpi_serdev_add_device(acpi_handle handle, u32 level,
-				       void *data, void **return_value)
+struct acpi_serdev_resource_context {
+	struct serdev_controller *controller;
+	struct acpi_device *device;
+};
+
+static acpi_status
+acpi_serdev_add_device_from_resource(struct acpi_resource *resource, void *data)
 {
-	struct serdev_controller *ctrl = data;
-	struct acpi_device *adev;
+	struct acpi_serdev_resource_context *ctx
+		= (struct acpi_serdev_resource_context *)data;
+	struct acpi_resource_source *ctrl_name;
+	acpi_handle ctrl_handle;
+
+	if (resource->type != ACPI_RESOURCE_TYPE_SERIAL_BUS)
+		return AE_OK;
 
-	if (acpi_bus_get_device(handle, &adev))
+	if (resource->data.common_serial_bus.type
+	    != ACPI_RESOURCE_SERIAL_TYPE_UART)
 		return AE_OK;
 
-	return acpi_serdev_register_device(ctrl, adev);
+	ctrl_name = &resource->data.common_serial_bus.resource_source;
+	if (ctrl_name->string_length == 0 || !ctrl_name->string_ptr)
+		return AE_OK;
+
+	if (acpi_get_handle(ctx->device->handle, ctrl_name->string_ptr,
+			    &ctrl_handle))
+		return AE_OK;
+
+	if (ctrl_handle == ACPI_HANDLE(ctx->controller->dev.parent))
+		return acpi_serdev_register_device(ctx->controller,
+						   ctx->device);
+
+	return AE_OK;
 }
 
+static acpi_status
+acpi_serdev_add_devices_from_resources(acpi_handle handle, u32 level,
+				       void *data, void **return_value)
+{
+	struct acpi_serdev_resource_context ctx;
+	acpi_status status;
+
+	ctx.controller = (struct serdev_controller *)data;
+	status = acpi_bus_get_device(handle, &ctx.device);
+	if (status)
+		return AE_OK;		// ignore device if not present
+
+	status = acpi_walk_resources(handle, METHOD_NAME__CRS,
+				     acpi_serdev_add_device_from_resource,
+				     &ctx);
+	if (status == AE_NOT_FOUND)
+		return AE_OK;		// ignore if _CRS is not found
+	else
+		return status;
+}
+
+#define SERDEV_ACPI_ENUMERATE_MAX_DEPTH		32
+
 static int acpi_serdev_register_devices(struct serdev_controller *ctrl)
 {
 	acpi_status status;
@@ -603,8 +649,10 @@ static int acpi_serdev_register_devices(struct serdev_controller *ctrl)
 	if (!handle)
 		return -ENODEV;
 
-	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, 1,
-				     acpi_serdev_add_device, NULL, ctrl, NULL);
+	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
+				     SERDEV_ACPI_ENUMERATE_MAX_DEPTH,
+				     acpi_serdev_add_devices_from_resources,
+				     NULL, ctrl, NULL);
 	if (ACPI_FAILURE(status))
 		dev_dbg(&ctrl->dev, "failed to enumerate serdev slaves\n");
 
-- 
2.23.0

