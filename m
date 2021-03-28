Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF5634BC24
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Mar 2021 13:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbhC1LU0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 28 Mar 2021 07:20:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28453 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229503AbhC1LUR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 28 Mar 2021 07:20:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616930407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Yy8DT+dgxAGVTXTbpn7linerG5T039cPJdOMl8dCnFI=;
        b=aFXdD/vBv9fI5yI+pk9+evFbp0csBnLWFe5uhQzMcqmChzEfU7QIC39CxYwC9AZfIYCcLY
        ug6aZguIWTBziXogrS6o/doqP4sKOiB4Uf89zCrTLnngunwUwgA+Rc+3Qw6ICIVJ/j4jiP
        aUFE2BadjBfV0X1oqPUpRrmepxkA+Do=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-vPifRFyGOfGj3uHbqGD_mQ-1; Sun, 28 Mar 2021 07:20:03 -0400
X-MC-Unique: vPifRFyGOfGj3uHbqGD_mQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8189D81746F;
        Sun, 28 Mar 2021 11:20:02 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-83.ams2.redhat.com [10.36.112.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8B46B14106;
        Sun, 28 Mar 2021 11:20:01 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org
Subject: [PATCH 1/2] ACPI: scan: Move acpi_scan_dep_init() higher up in scan.c
Date:   Sun, 28 Mar 2021 13:19:59 +0200
Message-Id: <20210328112000.12502-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Move acpi_scan_dep_init() higher up in scan.c to avoid needing a forward
declaration in the next patch in this set.

Fixes: 71da201f38df ("ACPI: scan: Defer enumeration of devices with _DEP lists")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/scan.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 1584c9e463bd..19f8fd6ea17a 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1655,6 +1655,20 @@ void acpi_device_add_finalize(struct acpi_device *device)
 	kobject_uevent(&device->dev.kobj, KOBJ_ADD);
 }
 
+static void acpi_scan_dep_init(struct acpi_device *adev)
+{
+	struct acpi_dep_data *dep;
+
+	mutex_lock(&acpi_dep_list_lock);
+
+	list_for_each_entry(dep, &acpi_dep_list, node) {
+		if (dep->consumer == adev->handle)
+			adev->dep_unmet++;
+	}
+
+	mutex_unlock(&acpi_dep_list_lock);
+}
+
 static int acpi_add_single_object(struct acpi_device **child,
 				  acpi_handle handle, int type,
 				  unsigned long long sta)
@@ -1906,20 +1920,6 @@ static u32 acpi_scan_check_dep(acpi_handle handle)
 	return count;
 }
 
-static void acpi_scan_dep_init(struct acpi_device *adev)
-{
-	struct acpi_dep_data *dep;
-
-	mutex_lock(&acpi_dep_list_lock);
-
-	list_for_each_entry(dep, &acpi_dep_list, node) {
-		if (dep->consumer == adev->handle)
-			adev->dep_unmet++;
-	}
-
-	mutex_unlock(&acpi_dep_list_lock);
-}
-
 static bool acpi_bus_scan_second_pass;
 
 static acpi_status acpi_bus_check_add(acpi_handle handle, bool check_dep,
-- 
2.30.2

