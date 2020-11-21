Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 220132BC20C
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Nov 2020 21:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgKUUar (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 21 Nov 2020 15:30:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39138 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728402AbgKUUar (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 21 Nov 2020 15:30:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605990646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/nTqVVP0uahNJ0Vi39exTUckgy0BekWuMmxre6Vsres=;
        b=HkrT/Ciu5xzotOIaB61Mht6EEOJTM35499NDo0n1g/evJ1FEsy6/ifwKBB0hSrhkT6E3aJ
        kPzqblMPDsdnTzGAfPuKFfgcp/JU06prSlADSJ+Bwx8v0AdH5FFUomthGT9c8HtrSJwqv1
        EGA3McCG05L4xnAOFytViKJPrk8FmfU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-kLbre_OuMU655pTZoK3Yww-1; Sat, 21 Nov 2020 15:30:44 -0500
X-MC-Unique: kLbre_OuMU655pTZoK3Yww-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AEDFE51DE;
        Sat, 21 Nov 2020 20:30:43 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-24.ams2.redhat.com [10.36.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B733718E4F;
        Sat, 21 Nov 2020 20:30:42 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org
Subject: [PATCH 1/7] ACPI: scan: Add an acpi_info_matches_hids() helper
Date:   Sat, 21 Nov 2020 21:30:34 +0100
Message-Id: <20201121203040.146252-2-hdegoede@redhat.com>
In-Reply-To: <20201121203040.146252-1-hdegoede@redhat.com>
References: <20201121203040.146252-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

acpi_device_dep_initialize() skips _DEPS with a HID of "INT3396"
and checks this using an acpi_device_info struct.

The upcoming changes splitting the scanning of the root into 2 steps,
deferring the addition of some devices which need access to OpRegions of
other devices during scanning to the second step, need to extend the
HIDs to skip during _DEP checking to a list of HIDs; and need to check
an acpi_device_info struct against a list of HIDs in more places.

Add an acpi_info_matches_hids() helper which checks a list of HIDs
for this and switch acpi_device_dep_initialize() over to this helper.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/scan.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index bc6a79e33220..e949265d5667 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -719,6 +719,28 @@ int acpi_device_add(struct acpi_device *device,
 /* --------------------------------------------------------------------------
                                  Device Enumeration
    -------------------------------------------------------------------------- */
+static bool acpi_info_matches_hids(struct acpi_device_info *info,
+				   const char * const hids[])
+{
+	int i;
+
+	if (!(info->valid & ACPI_VALID_HID))
+		return false;
+
+	for (i = 0; hids[i]; i++) {
+		if (!strcmp(info->hardware_id.string, hids[i]))
+			return true;
+	}
+
+	return false;
+}
+
+/* List of HIDs for which we ignore matching ACPI devices, when checking _DEP lists. */
+static const char * const acpi_ignore_dep_hids[] = {
+	"INT3396", /* Windows System Power Management Controller */
+	NULL
+};
+
 static struct acpi_device *acpi_bus_get_parent(acpi_handle handle)
 {
 	struct acpi_device *device = NULL;
@@ -1833,13 +1855,7 @@ static void acpi_device_dep_initialize(struct acpi_device *adev)
 			continue;
 		}
 
-		/*
-		 * Skip the dependency of Windows System Power
-		 * Management Controller
-		 */
-		skip = info->valid & ACPI_VALID_HID &&
-			!strcmp(info->hardware_id.string, "INT3396");
-
+		skip = acpi_info_matches_hids(info, acpi_ignore_dep_hids);
 		kfree(info);
 
 		if (skip)
-- 
2.28.0

