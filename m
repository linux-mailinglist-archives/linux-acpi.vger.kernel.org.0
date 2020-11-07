Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32CF2AA564
	for <lists+linux-acpi@lfdr.de>; Sat,  7 Nov 2020 14:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbgKGNdK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 7 Nov 2020 08:33:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42782 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727084AbgKGNdJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Nov 2020 08:33:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604755988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=asb1VhlJqNFXbaZHQsc1gN7iTvg7fcNa3S0Q6avocHE=;
        b=CIgdz/eOfA4rg0BDpf8gehK5Zw/f0kkrGxJnK59d9gNjX0lr/kIt0Nt4ha3hMuD7igI1P6
        +c6UVZNaS+4x3+IoOebzr74K49xF3Bhyfz2HeXq6YRPmH4FpHIPwxTetq0ih7ujbF/QY1d
        dwXbVup6fra5JGhPW+NIleYXxfpOpiw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-n5rWkkujMdOR8asvGd6B-w-1; Sat, 07 Nov 2020 08:33:04 -0500
X-MC-Unique: n5rWkkujMdOR8asvGd6B-w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6544C1006705;
        Sat,  7 Nov 2020 13:33:03 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-12-40.pek2.redhat.com [10.72.12.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7D1166EF62;
        Sat,  7 Nov 2020 13:32:58 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        Andy Shevchenko <andy@infradead.org>
Subject: [PATCH] ACPI: button: Add DMI quirk for Medion Akoya E2228T
Date:   Sat,  7 Nov 2020 14:32:54 +0100
Message-Id: <20201107133254.101882-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The Medion Akoya E2228T's ACPI _LID implementation is quite broken,
it has the same issues as the one from the Medion Akoya E2215T:

1. For notifications it uses an ActiveLow Edge GpioInt, rather then
   an ActiveBoth one, meaning that the device is only notified when the
   lid is closed, not when it is opened.

2. Matching with this its _LID method simply always returns 0 (closed)

In order for the Linux LID code to work properly with this implementation,
the lid_init_state selection needs to be set to ACPI_BUTTON_LID_INIT_OPEN,
add a DMI quirk for this.

While working on this I also found out that the MD60### part of the model
number differs per country/batch while all of the E2215T and E2228T models
have this issue, so also remove the " MD60198" part from the E2215T quirk.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/button.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 0761529cac05..0d93a5ef4d07 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -89,7 +89,18 @@ static const struct dmi_system_id dmi_lid_quirks[] = {
 		 */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "MEDION"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "E2215T MD60198"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "E2215T"),
+		},
+		.driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_OPEN,
+	},
+	{
+		/*
+		 * Medion Akoya E2228T, notification of the LID device only
+		 * happens on close, not on open and _LID always returns closed.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "MEDION"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "E2228T"),
 		},
 		.driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_OPEN,
 	},
-- 
2.28.0

