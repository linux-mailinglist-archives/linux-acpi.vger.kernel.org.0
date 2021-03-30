Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A8F34F140
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Mar 2021 20:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbhC3Stt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 30 Mar 2021 14:49:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48702 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232866AbhC3Stj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 30 Mar 2021 14:49:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617130177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=H10zMwwgM3nIxfN2sHfG4+WIwEOIfM2ea2HYhMD1yeE=;
        b=DHmVJKhkzAqXnOBCTydG9CW1WXBh5bceYVIyZPR+mZ+em/tPEePdvJ/pjslm/3tk1i3gdw
        TYX7oLH6cMSQ6AELH9Vr0KdZ+cWI4VeyyOeyNJacVUAC9IJpgnf7gWDNS3Awn5K4ECS7VU
        KTpXQDsrBkPP6iM9yvjLM4txmy5aF6E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-T3mzu60pOpiacAzbWl8N3Q-1; Tue, 30 Mar 2021 14:49:35 -0400
X-MC-Unique: T3mzu60pOpiacAzbWl8N3Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF32E9CC08;
        Tue, 30 Mar 2021 18:49:34 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-106.ams2.redhat.com [10.36.112.106])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D2B085944B;
        Tue, 30 Mar 2021 18:49:33 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org
Subject: [PATCH v3] ACPI: scan: Fix _STA getting called on devices with unmet dependencies
Date:   Tue, 30 Mar 2021 20:49:32 +0200
Message-Id: <20210330184932.16027-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
Changes in v2:
- Simplify, making it more like the original 63347db0affa commit

Changes in v3:
- Fix brown paper-bag bug where dep_unmet was not reset to 0 at the start of
  acpi_scan_dep_init()
---
 drivers/acpi/scan.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 1584c9e463bd..24490db82531 100644
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
@@ -1910,6 +1912,8 @@ static void acpi_scan_dep_init(struct acpi_device *adev)
 {
 	struct acpi_dep_data *dep;
 
+	adev->dep_unmet = 0;
+
 	mutex_lock(&acpi_dep_list_lock);
 
 	list_for_each_entry(dep, &acpi_dep_list, node) {
@@ -1957,7 +1961,13 @@ static acpi_status acpi_bus_check_add(acpi_handle handle, bool check_dep,
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

