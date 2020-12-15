Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B792DAC03
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Dec 2020 12:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbgLOL1g (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Dec 2020 06:27:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21348 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729062AbgLOL1d (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 15 Dec 2020 06:27:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608031567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VdvU/NwO377Jri/mdqYabuILSsRebo7DrfRPpnxWTKo=;
        b=Z0N+dP3Qdf8f3TZ75H2AJwhzCDHtB0JKAC1jlSTjYeo2ttEnn7u1Pil9aleytVfbkg6hXN
        jtlMR1CUVncuH7L2ZYSpm2d9/4uYKXKWb2DhY2uPJCtr42AhGgR/U7L9CAnz0CY6qJ5iZ1
        5R52vTXnkbULhMCpojpKfRCheHh56aQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-qhRzt49GOH-pECGEa8HN3A-1; Tue, 15 Dec 2020 06:26:05 -0500
X-MC-Unique: qhRzt49GOH-pECGEa8HN3A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C33851005504;
        Tue, 15 Dec 2020 11:26:04 +0000 (UTC)
Received: from x1.localdomain (ovpn-114-62.ams2.redhat.com [10.36.114.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C8A94710DB;
        Tue, 15 Dec 2020 11:26:03 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI: scan: Add Intel Baytrail Mailbox Device to acpi_ignore_dep_ids
Date:   Tue, 15 Dec 2020 12:26:02 +0100
Message-Id: <20201215112602.5314-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Linux does not have a driver for / does not use the "Intel Baytrail
Mailbox Device" (ACIP HID INT33BD). Add it to the acpi_ignore_dep_ids
list, so that we do not defer probing ACPI devices which depend on
another ACPI device with this HID.

Specifically this makes us not defer the probing of the GPO1 ACPI
device / GPIO controller on the Acer Switch 10E SW3-016. On this
tablet model the  _HID method of the ACPI node for the UART attached
Bluetooth, reads GPIOs to detect the installed wifi chip and updates
the reported _HID for the Bluetooth's ACPI node accordingly.

For the Bluetooth's ACPI node to report the correct _HID the GPO1 device
must be probed and attached during the first scan pass. Adding the
"INT33BD" HID to the acpi_ignore_dep_ids list makes this all work.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/scan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 28713741d6ee..05814d188c7d 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -752,6 +752,7 @@ static bool acpi_info_matches_ids(struct acpi_device_info *info,
 /* List of HIDs for which we ignore matching ACPI devices, when checking _DEP lists. */
 static const char * const acpi_ignore_dep_ids[] = {
 	"PNP0D80", /* Windows-compatible System Power Management Controller */
+	"INT33BD", /* Intel Baytrail Mailbox Device */
 	NULL
 };
 
-- 
2.28.0

