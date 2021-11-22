Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F1E4593A4
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Nov 2021 18:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237533AbhKVRJI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 Nov 2021 12:09:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:43065 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237880AbhKVRJF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 22 Nov 2021 12:09:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637600759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=StFri3RLtdyO8CigL7YbqsQgsUYZayoitG4VD3555vg=;
        b=K1KSKp/sT2kg9aZrT2m9c10gyB4OEAReuQTuxkz62vMXpmfwiP0ZIpQQKOSVzNAg7HJJno
        N/avFgcJWvHlv+HLAvN+JUxV3EVfP62/XjaSW9LOboSYo99+LZBqJ+ipvdhy1ZfP7emMk/
        eBVIkDGP73cCyY1l/H5X+8sFPM4LiEs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-255-cW5g7JpBMx2bVEWh9b2-cQ-1; Mon, 22 Nov 2021 12:05:57 -0500
X-MC-Unique: cW5g7JpBMx2bVEWh9b2-cQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18B65100C661;
        Mon, 22 Nov 2021 17:05:56 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.226])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7ACE45D6D5;
        Mon, 22 Nov 2021 17:05:54 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: [PATCH v2 4/7] ACPI / x86: Add not-present quirk for the PCI0.SDHB.BRC1 device on the GPD win
Date:   Mon, 22 Nov 2021 18:05:33 +0100
Message-Id: <20211122170536.7725-5-hdegoede@redhat.com>
In-Reply-To: <20211122170536.7725-1-hdegoede@redhat.com>
References: <20211122170536.7725-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The GPD win and its sibling the GPD pocket (99% the same electronics in a
different case) use a PCI wifi card. But the ACPI tables on both variants
contain a bug where the SDIO MMC controller for SDIO wifi cards is enabled
despite this. This SDIO MMC controller has a PCI0.SDHB.BRC1 child-device
which _PS3 method sets a GPIO causing the PCI wifi card to turn off.

At the moment there is a pretty ugly kludge in the sdhci-acpi.c code,
just to work around the bug in the DSDT of this single design. This can
be solved cleaner/simply with a quirk overriding the _STA return of the
broken PCI0.SDHB.BRC1 PCI0.SDHB.BRC1 child with a status value of 0,
so that its power_manageable flag gets cleared, avoiding this problem.

Note that even though it is not used, the _STA method for the MMC
controller is deliberately not overridden. If the status of the MMC
controller were forced to 0 it would never get suspended, which would
cause these mini-laptops to not reach S0i3 level when suspended.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Drop the Fixes: c10383e8ddf4 ("ACPI: scan: Release PM resources blocked by
  unused objects") tag and related wording in the commit message, since
  that patch has been reverted for now
---
 drivers/acpi/x86/utils.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index 190bfc2ab3f2..b3fb428461c6 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -94,9 +94,10 @@ static const struct override_status_id override_status_ids[] = {
 	/*
 	 * The GPD win BIOS dated 20170221 has disabled the accelerometer, the
 	 * drivers sometimes cause crashes under Windows and this is how the
-	 * manufacturer has solved this :| Note that the the DMI data is less
-	 * generic then it seems, a board_vendor of "AMI Corporation" is quite
-	 * rare and a board_name of "Default String" also is rare.
+	 * manufacturer has solved this :|  The DMI match may not seem unique,
+	 * but it is. In the 67000+ DMI decode dumps from linux-hardware.org
+	 * only 116 have board_vendor set to "AMI Corporation" and of those 116
+	 * only the GPD win and pocket entries' board_name is "Default string".
 	 *
 	 * Unfortunately the GPD pocket also uses these strings and its BIOS
 	 * was copy-pasted from the GPD win, so it has a disabled KIOX000A
@@ -120,6 +121,19 @@ static const struct override_status_id override_status_ids[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
 		DMI_MATCH(DMI_BIOS_DATE, "05/25/2017")
 	      }),
+
+	/*
+	 * The GPD win/pocket have a PCI wifi card, but its DSDT has the SDIO
+	 * mmc controller enabled and that has a child-device which _PS3
+	 * method sets a GPIO causing the PCI wifi card to turn off.
+	 * See above remark about uniqueness of the DMI match.
+	 */
+	NOT_PRESENT_ENTRY_PATH("\\_SB_.PCI0.SDHB.BRC1", ATOM_AIRMONT, {
+		DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
+		DMI_EXACT_MATCH(DMI_BOARD_NAME, "Default string"),
+		DMI_EXACT_MATCH(DMI_BOARD_SERIAL, "Default string"),
+		DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Default string"),
+	      }),
 };
 
 bool acpi_device_override_status(struct acpi_device *adev, unsigned long long *status)
-- 
2.33.1

