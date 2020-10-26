Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A34D42998BA
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Oct 2020 22:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733027AbgJZV2t (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 26 Oct 2020 17:28:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34550 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733019AbgJZV2t (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 26 Oct 2020 17:28:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603747728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wpnaNWw/OHnz3UjdtMu4b8SJkY1puYStr0q+gSxjYQQ=;
        b=dvPpYoMJ5TFQ6pOPmnXNWTC8ghl+gywiPq3jXUP0Q7qg+fv5H41uajQBm0TsDcdtjeOJOA
        ROzxYzUYNjdgHZgIkmD4y+8RoXm17WdpmFk2eelTseljqRqn3/H61wkoKbOT01HCbsS5a0
        eF9XnffFNXa271OTxB/sIQedw79dPIk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-74Lb8ctgNgyKrMXAZH3XHw-1; Mon, 26 Oct 2020 17:28:44 -0400
X-MC-Unique: 74Lb8ctgNgyKrMXAZH3XHw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E26D2106BC7B;
        Mon, 26 Oct 2020 21:28:42 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-200.ams2.redhat.com [10.36.112.200])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EB4685C1BB;
        Mon, 26 Oct 2020 21:28:41 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI: button: Drop no longer necessary Acer SW5-012 lid_init_state quirk
Date:   Mon, 26 Oct 2020 22:28:40 +0100
Message-Id: <20201026212840.17231-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Commit 78a5b53e9fb4 ("Input: soc_button_array - work around DSDTs which
modify the irqflags") adds a workaround for DSDTs with a _LID method
which play tricks with the irqflags, assuming that the OS is using
an irq-type of IRQ_TYPE_LEVEL_LOW.

Now that this workaround is in place, we no longer need to disable the
lid functionality on the Acer SW5-012.

Fixes: 78a5b53e9fb4 ("Input: soc_button_array - Work around DSDTs which modify the irqflags")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/button.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index da4b125ab4c3..0761529cac05 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -73,19 +73,6 @@ MODULE_DEVICE_TABLE(acpi, button_device_ids);
 
 /* Please keep this list sorted alphabetically by vendor and model */
 static const struct dmi_system_id dmi_lid_quirks[] = {
-	{
-		/*
-		 * Acer Switch 10 SW5-012. _LID method messes with home and
-		 * power button GPIO IRQ settings causing an interrupt storm on
-		 * both GPIOs. This is unfixable without a DSDT override, so we
-		 * have to disable the lid-switch functionality altogether :|
-		 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire SW5-012"),
-		},
-		.driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_DISABLED,
-	},
 	{
 		/* GP-electronic T701, _LID method points to a floating GPIO */
 		.matches = {
-- 
2.28.0

