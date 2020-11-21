Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBD52BC20F
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Nov 2020 21:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbgKUUav (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 21 Nov 2020 15:30:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39600 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728402AbgKUUau (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 21 Nov 2020 15:30:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605990649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GMA0+aUZIGfOOiA4v/mEkuZjI6/I2qCtVstIf9X8elo=;
        b=ETQ3AGAOtyICnQk0BPopgYSVf2jd09G/8n43u2T+liYn43gjeG1qZxaNdXnplBfEG/Jh9P
        Ks/uRbcKobW4MdiVWwG+qGwMCcJ+uZ2WfvErmJhwfdYwyY1cuyB+zWN6s2TMdgueQI7px1
        07vmkeObLAStnmco461e5x0QWeeuQ/w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-cJpGY8PnMpq-l9QFVUxiYQ-1; Sat, 21 Nov 2020 15:30:47 -0500
X-MC-Unique: cJpGY8PnMpq-l9QFVUxiYQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46B17803F48;
        Sat, 21 Nov 2020 20:30:46 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-24.ams2.redhat.com [10.36.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3A2BA18E4F;
        Sat, 21 Nov 2020 20:30:45 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org
Subject: [PATCH 3/7] ACPI: scan: Add a separate cleanup exit-path to acpi_scan_init()
Date:   Sat, 21 Nov 2020 21:30:36 +0100
Message-Id: <20201121203040.146252-4-hdegoede@redhat.com>
In-Reply-To: <20201121203040.146252-1-hdegoede@redhat.com>
References: <20201121203040.146252-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add a separate cleanup exit-path to acpi_scan_init().
This is a preparation patch for splitting the scanning of the root
into 2 steps, deferring the addition of some devices which need access
to OpRegions of other devices during scanning to the second step.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/scan.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 25a46ae24229..7dde66222648 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2250,27 +2250,31 @@ int __init acpi_scan_init(void)
 	 */
 	result = acpi_bus_scan(ACPI_ROOT_OBJECT);
 	if (result)
-		goto out;
+		goto cleanup;
 
 	result = acpi_bus_get_device(ACPI_ROOT_OBJECT, &acpi_root);
 	if (result)
-		goto out;
+		goto cleanup;
 
 	/* Fixed feature devices do not exist on HW-reduced platform */
 	if (!acpi_gbl_reduced_hardware) {
 		result = acpi_bus_scan_fixed();
-		if (result) {
-			acpi_detach_data(acpi_root->handle,
-					 acpi_scan_drop_device);
-			acpi_device_del(acpi_root);
-			put_device(&acpi_root->dev);
-			goto out;
-		}
+		if (result)
+			goto cleanup;
 	}
 
 	acpi_scan_initialized = true;
 
- out:
+	mutex_unlock(&acpi_scan_lock);
+	return 0;
+
+cleanup:
+	if (acpi_root) {
+		acpi_detach_data(acpi_root->handle, acpi_scan_drop_device);
+		acpi_device_del(acpi_root);
+		put_device(&acpi_root->dev);
+	}
+
 	mutex_unlock(&acpi_scan_lock);
 	return result;
 }
-- 
2.28.0

