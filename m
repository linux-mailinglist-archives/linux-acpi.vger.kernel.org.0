Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 545F3481BD6
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Dec 2021 12:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbhL3L54 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 30 Dec 2021 06:57:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:27131 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239054AbhL3L5z (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 30 Dec 2021 06:57:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640865474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=a9phBxRxNDO9c/LsZJKzxh2rYnijWAA8vRBg0kiykpg=;
        b=JzSPNf/XoTDtF/s1PnSp+l6+oXkF+oMcc5GML3F61IFk7HMeRM7F6OyngWkKeYUy6sUPji
        kLJb5T62xqWpvCbUZEuAg95SOqcWy/6V34mYjZ1rpdIKwkCBol8jfeRNkQQkCvMZ7S+/Bs
        8I3BFCEZMplDg47vuE5gJhi+9b/mmwM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-231-yxR1KP1uOeWDGdAvzFAG6Q-1; Thu, 30 Dec 2021 06:57:53 -0500
X-MC-Unique: yxR1KP1uOeWDGdAvzFAG6Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 557F2802C92;
        Thu, 30 Dec 2021 11:57:52 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.254])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 48A3384A12;
        Thu, 30 Dec 2021 11:57:48 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        linux-serial@vger.kernel.org,
        =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= 
        <frederic.danis.oss@gmail.com>
Subject: [PATCH] ACPI / scan: Create platform device for BCM4752 and LNV4752 ACPI nodes
Date:   Thu, 30 Dec 2021 12:57:47 +0100
Message-Id: <20211230115747.15302-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

BCM4752 and LNV4752 ACPI nodes describe a Broadcom 4752 GPS module
attached to an UART of the system.

The GPS modules talk a custom protocol which only works with a closed-
source Android gpsd daemon which knows this protocol.

The ACPI nodes also describe GPIOs to turn the GPS on/off these are
handled by the net/rfkill/rfkill-gpio.c code. This handling predates the
addition of enumeration of ACPI instantiated serdevs to the kernel and
was broken by that addition, because the ACPI scan code now no longer
instantiates platform_device-s for these nodes.

Rename the i2c_multi_instantiate_ids HID list to ignore_serial_bus_ids
and add the BCM4752 and LNV4752 HIDs, so that rfkill-gpio gets
a platform_device to bind to again; and so that a tty cdev for gpsd
gets created for these.

Fixes: e361d1f85855 ("ACPI / scan: Fix enumeration for special UART devices")
Cc: Frédéric Danis <frederic.danis.oss@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Note there is some work on reverse-engineering the protocol for these
GPS modules here, but this is not complete:
https://redmine.replicant.us/projects/replicant/wiki/BCM4751
https://git.replicant.us/contrib/PaulK/bcm4751/
---
 drivers/acpi/scan.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 526e823a33fb..c5dfbe26a0cb 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1701,6 +1701,7 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
 {
 	struct list_head resource_list;
 	bool is_serial_bus_slave = false;
+	static const struct acpi_device_id ignore_serial_bus_ids[] = {
 	/*
 	 * These devices have multiple I2cSerialBus resources and an i2c-client
 	 * must be instantiated for each, each with its own i2c_device_id.
@@ -1709,11 +1710,18 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
 	 * drivers/platform/x86/i2c-multi-instantiate.c driver, which knows
 	 * which i2c_device_id to use for each resource.
 	 */
-	static const struct acpi_device_id i2c_multi_instantiate_ids[] = {
 		{"BSG1160", },
 		{"BSG2150", },
 		{"INT33FE", },
 		{"INT3515", },
+	/*
+	 * HIDs of device with an UartSerialBusV2 resource for which userspace
+	 * expects a regular tty cdev to be created (instead of the in kernel
+	 * serdev) and which have a kernel driver which expects a platform_dev
+	 * such as the rfkill-gpio driver.
+	 */
+		{"BCM4752", },
+		{"LNV4752", },
 		{}
 	};
 
@@ -1727,8 +1735,7 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
 	     fwnode_property_present(&device->fwnode, "baud")))
 		return true;
 
-	/* Instantiate a pdev for the i2c-multi-instantiate drv to bind to */
-	if (!acpi_match_device_ids(device, i2c_multi_instantiate_ids))
+	if (!acpi_match_device_ids(device, ignore_serial_bus_ids))
 		return false;
 
 	INIT_LIST_HEAD(&resource_list);
-- 
2.33.1

