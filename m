Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0351534BC25
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Mar 2021 13:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbhC1LU0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 28 Mar 2021 07:20:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37151 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229543AbhC1LUS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 28 Mar 2021 07:20:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616930407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6+EKCE354c33h9thDLEaaDg4xcXRSjgg3NTk2TKYAYQ=;
        b=htGuHIirXb0W5Qe298VHE9QwXqbxivhEuQPWJbrsRSPGqZePEuRPPSZ3RibOiEF/TaHKMJ
        F67XHXYn9IaRYksYv3fN8n+rwFUWrp/TkhYl5BH9xMKnD/zWrkioBXe56R0EHMI2G7u/Uc
        lgfBABdysGepBXaTJ/tEq3AFMYqkW34=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-gQj0yNNzMKmiERAH3y2puQ-1; Sun, 28 Mar 2021 07:20:04 -0400
X-MC-Unique: gQj0yNNzMKmiERAH3y2puQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BEF87107ACCA;
        Sun, 28 Mar 2021 11:20:03 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-83.ams2.redhat.com [10.36.112.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA8B214106;
        Sun, 28 Mar 2021 11:20:02 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org
Subject: [PATCH 2/2] ACPI: scan: Fix _STA getting called on devices with unmet dependencies
Date:   Sun, 28 Mar 2021 13:20:00 +0200
Message-Id: <20210328112000.12502-2-hdegoede@redhat.com>
In-Reply-To: <20210328112000.12502-1-hdegoede@redhat.com>
References: <20210328112000.12502-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

Fix this by moving the acpi_scan_dep_init() call done for devices added
during the second pass done by acpi_bus_scan() to inside
acpi_add_single_object(), so that dep_unmet is properly initialized
before the acpi_bus_get_status() call.

This re-fixes the issue initially fixed by
commit 63347db0affa ("ACPI / scan: Use acpi_bus_get_status() to initialize
ACPI_TYPE_DEVICE devs"), which introduced the removed
"device->dep_unmet = 1;" statement.

This issue was noticed; and the fix tested on a Dell Venue 10 Pro 5055.

Fixes: 71da201f38df ("ACPI: scan: Defer enumeration of devices with _DEP lists")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/scan.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 19f8fd6ea17a..0d0176559bc2 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1671,7 +1671,8 @@ static void acpi_scan_dep_init(struct acpi_device *adev)
 
 static int acpi_add_single_object(struct acpi_device **child,
 				  acpi_handle handle, int type,
-				  unsigned long long sta)
+				  unsigned long long sta,
+				  bool init_dep)
 {
 	struct acpi_device_info *info = NULL;
 	struct acpi_device *device;
@@ -1693,9 +1694,13 @@ static int acpi_add_single_object(struct acpi_device **child,
 	 * that we can call acpi_bus_get_status() and use its quirk handling.
 	 * Note this must be done before the get power-/wakeup_dev-flags calls.
 	 */
-	if (type == ACPI_BUS_TYPE_DEVICE)
+	if (type == ACPI_BUS_TYPE_DEVICE) {
+		if (init_dep)
+			acpi_scan_dep_init(device);
+
 		if (acpi_bus_get_status(device) < 0)
 			acpi_set_device_status(device, 0);
+	}
 
 	acpi_bus_get_power_flags(device);
 	acpi_bus_get_wakeup_device_flags(device);
@@ -1952,13 +1957,11 @@ static acpi_status acpi_bus_check_add(acpi_handle handle, bool check_dep,
 		}
 	}
 
-	acpi_add_single_object(&device, handle, type, sta);
+	acpi_add_single_object(&device, handle, type, sta, !check_dep);
 	if (!device)
 		return AE_CTRL_DEPTH;
 
 	acpi_scan_init_hotplug(device);
-	if (!check_dep)
-		acpi_scan_dep_init(device);
 
 out:
 	if (!*adev_p)
@@ -2221,7 +2224,7 @@ int acpi_bus_register_early_device(int type)
 	int result;
 
 	result = acpi_add_single_object(&device, NULL,
-					type, ACPI_STA_DEFAULT);
+					type, ACPI_STA_DEFAULT, false);
 	if (result)
 		return result;
 
@@ -2242,7 +2245,7 @@ static int acpi_bus_scan_fixed(void)
 
 		result = acpi_add_single_object(&device, NULL,
 						ACPI_BUS_TYPE_POWER_BUTTON,
-						ACPI_STA_DEFAULT);
+						ACPI_STA_DEFAULT, false);
 		if (result)
 			return result;
 
@@ -2259,7 +2262,7 @@ static int acpi_bus_scan_fixed(void)
 
 		result = acpi_add_single_object(&device, NULL,
 						ACPI_BUS_TYPE_SLEEP_BUTTON,
-						ACPI_STA_DEFAULT);
+						ACPI_STA_DEFAULT, false);
 		if (result)
 			return result;
 
-- 
2.30.2

