Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB4DA34D43D
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Mar 2021 17:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbhC2PrB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 29 Mar 2021 11:47:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46874 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231396AbhC2Pqz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 29 Mar 2021 11:46:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617032814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lS4aUg7nctYWb/mpu/ZOilv4wNkT+UHj60RSlYgkQZM=;
        b=Y80s7B0VBkDWOSxFfU9pV8va3KZj7Tl7Ddmndy8lt58sU2UUjt4rTP/BSZoEvJjZ4wmJ0Q
        yGYnhQPGv+4nUv8Jn4LMWrDoDfvc5xCqeIGHkGTl2kJ0pKHZ7Ne5ycqhTIA6eweqfAoU4I
        a8aoTnt94/R7NMqDr0s+xZ+2mygaMuU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-aZK3GqYnNIOxCV9dn7Mi0g-1; Mon, 29 Mar 2021 11:46:52 -0400
X-MC-Unique: aZK3GqYnNIOxCV9dn7Mi0g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1C19501E0;
        Mon, 29 Mar 2021 15:46:51 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-124.ams2.redhat.com [10.36.112.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E85C95D9F0;
        Mon, 29 Mar 2021 15:46:50 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org
Subject: [PATCH v2] ACPI: scan: Fix _STA getting called on devices with unmet dependencies
Date:   Mon, 29 Mar 2021 17:46:49 +0200
Message-Id: <20210329154649.16056-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Commit 71da201f38df ("ACPI: scan: Defer enumeration of devices with
_DEP lists") dropped the following 2 lines from acpi_init_device_object():

	/* Assume there are unmet deps until acpi_device_dep_initialize() runs */
	device->dep_unmet = 1;

Leaving the initial value of dep_unmet at the 0 from the kzalloc(). This
causes the acpi_bus_get_status() call in acpi_add_single_object() to
actually call _STA, even though there maybe unmet deps, leading to errors
like these:

[    0.123579] ACPI Error: No handler for Region [ECRM] (00000000ba9edc4c)
               [GenericSerialBus] (20170831/evregion-166)
[    0.123601] ACPI Error: Region GenericSerialBus (ID=9) has no handler
               (20170831/exfldio-299)
[    0.123618] ACPI Error: Method parse/execution failed
               \_SB.I2C1.BAT1._STA, AE_NOT_EXIST (20170831/psparse-550)

Fix this by re-adding the dep_unmet = 1 initialization to
acpi_init_device_object() and modifying acpi_bus_check_add() to make sure
that dep_unmet always gets setup there, overriding the initial 1 value.

This re-fixes the issue initially fixed by
commit 63347db0affa ("ACPI / scan: Use acpi_bus_get_status() to initialize
ACPI_TYPE_DEVICE devs"), which introduced the removed
"device->dep_unmet = 1;" statement.

This issue was noticed; and the fix tested on a Dell Venue 10 Pro 5055.

Fixes: 71da201f38df ("ACPI: scan: Defer enumeration of devices with _DEP lists")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/scan.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 1584c9e463bd..aca4edc8fe6b 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1647,6 +1647,8 @@ void acpi_init_device_object(struct acpi_device *device, acpi_handle handle,
 	device_initialize(&device->dev);
 	dev_set_uevent_suppress(&device->dev, true);
 	acpi_init_coherency(device);
+	/* Assume there are unmet deps to start with. */
+	device->dep_unmet = 1;
 }
 
 void acpi_device_add_finalize(struct acpi_device *device)
@@ -1957,7 +1959,13 @@ static acpi_status acpi_bus_check_add(acpi_handle handle, bool check_dep,
 		return AE_CTRL_DEPTH;
 
 	acpi_scan_init_hotplug(device);
-	if (!check_dep)
+	/*
+	 * If check_dep is true at this point, the device has no dependencies,
+	 * or the creation of the device object would have been postponed above.
+	 */
+	if (check_dep)
+		device->dep_unmet = 0;
+	else
 		acpi_scan_dep_init(device);
 
 out:
-- 
2.30.2

