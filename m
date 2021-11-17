Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69B4C455014
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Nov 2021 23:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240956AbhKQWEv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 Nov 2021 17:04:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:44693 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237296AbhKQWEj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 17 Nov 2021 17:04:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637186499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z6cbM7LUGy8fvcQpSOpuJfreeWnR9XsbBE9g2TgwNa4=;
        b=hYQDrn2Z2AgyHHbeZI8B4SPViVUumW2sjt1/HuWnObCoGml1qocSxrgTRaBoj1uQdrCJPX
        qbXiNUDXtsOeM3QcUKC++y5lc4P1WEhQa+SnhDQ6pCJYVU45ULGzokH8PQz+IdGkycsuTD
        umezvvHzr0IElJxb5nyk1powaq/8w4Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-uQW_MhYeOgqnI_HgEqeEgw-1; Wed, 17 Nov 2021 17:01:34 -0500
X-MC-Unique: uQW_MhYeOgqnI_HgEqeEgw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B644315721;
        Wed, 17 Nov 2021 22:01:32 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.192.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 445755D9DE;
        Wed, 17 Nov 2021 22:01:31 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: [PATCH 5.16 regression fix 3/5] ACPI: x86: Add not-present quirk for the PCI0.SDHB.BRC1 device on the GPD win
Date:   Wed, 17 Nov 2021 23:01:16 +0100
Message-Id: <20211117220118.408953-4-hdegoede@redhat.com>
In-Reply-To: <20211117220118.408953-1-hdegoede@redhat.com>
References: <20211117220118.408953-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The GPD win and its sibling the GPD pocket (99% the same electronics in a
different case) use a PCI wifi card. But the ACPI tables on both variants
contain a bug where the SDIO MMC controller for SDIO wifi cards is enabled
despite this. This SDIO MMC controller has a PCI0.SDHB.BRC1 child-device
which _PS3 method sets a GPIO causing the PCI wifi card to turn off.

Commit c10383e8ddf4 ("ACPI: scan: Release PM resources blocked by
unused objects") adds a:

	bus_for_each_dev(&acpi_bus_type, NULL, NULL, acpi_dev_turn_off_if_unused);

call to acpi_scan_init() which causes the buggy _PS3 method to get called
causing the wifi to no longer work.

Add a quirk to override the _STA method for the PCI0.SDHB.BRC1 child
with a status value of 0, so that its power_manageable gets cleared,
avoiding this problem.

This fixes the wifi no longer working on the GPD win and GPD pocket
devices afer this change.

Note that even though it is not used, the _STA method for the MMC
controller is deliberately not overridden. If the status of the MMC
controller were forced to 0 it would never get suspended, which would
cause these mini-laptops to not reach S0i3 level when suspended.

Fixes: c10383e8ddf4 ("ACPI: scan: Release PM resources blocked by unused objects")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/x86/utils.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index a854c28047f2..047fb4747ea8 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -99,9 +99,10 @@ static const struct override_status_id override_status_ids[] = {
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
@@ -125,6 +126,19 @@ static const struct override_status_id override_status_ids[] = {
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
2.31.1

