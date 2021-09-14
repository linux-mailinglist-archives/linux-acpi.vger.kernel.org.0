Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C44940AEFD
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Sep 2021 15:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbhINNfj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 14 Sep 2021 09:35:39 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:36908
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233202AbhINNfj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 14 Sep 2021 09:35:39 -0400
Received: from localhost.localdomain (unknown [124.160.154.16])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 46FDA3F043;
        Tue, 14 Sep 2021 13:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631626461;
        bh=Pr5iM932GI77Lo+Ea3+NqfD7FehRvGvqGwClG0J74fw=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=bGiQMuMLO4WV6CZPpGMYExx1t/yd7s3puSnK4uAPLPqdogCTeBru4z9QpJYCktAEV
         +bI5sh9eSu+icz2+4GiV7x9Q7hRzue3EZNVsfXdvVTzq9MtvDTF7wb++KXZK4/GgDz
         +0NJ2R69et5EsRq96qsCTlMRXuw3X/O0KmxxJFGtmvZkv8uxBaE7cmK2ndTm/nDNJZ
         quOnmeHX5kOZ0K+8e3ZJWwLshwPAmDNM/ckfrQaAjX5Y+TrgBu5oP7hQWHj/SecKRC
         MEbwLHhrz4+WxJN+aaVGCIcQuC83CzIgcnnqkPiZYEfWvfFIjcY0BLQxVjBinv//j3
         GB9f9CRDZjy9g==
From:   Hui Wang <hui.wang@canonical.com>
To:     linux-acpi@vger.kernel.org, rafael.j.wysocki@intel.com
Cc:     manuelkrause@netscape.net, hui.wang@canonical.com
Subject: [PATCH v2] ACPI: resources: add legacy irq override exception by DMI info
Date:   Tue, 14 Sep 2021 21:34:10 +0800
Message-Id: <20210914133410.88366-1-hui.wang@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

After the commit 0ec4e55e9f57 ("ACPI: resources: Add checks for ACPI
IRQ override") is reverted, the keyboard of those Medion laptops can't
work again.

To fix the keyboard issue, here adding an override check by DMI info,
this will not affect other machines and this design refers to
the prt_quirks[] in the drivers/acpi/pci_irq.c.

If we meet similar issues on other platforms, we could expand the
table of skip_override_table[] or medion_laptop[].

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=213031
BugLink: http://bugs.launchpad.net/bugs/1909814
Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reported-by: Manuel Krause <manuelkrause@netscape.net>
Tested-by: Manuel Krause <manuelkrause@netscape.net>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 drivers/acpi/resource.c | 51 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index ee78a210c606..676254ccac4d 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -16,6 +16,7 @@
 #include <linux/ioport.h>
 #include <linux/slab.h>
 #include <linux/irq.h>
+#include <linux/dmi.h>
 
 #ifdef CONFIG_X86
 #define valid_IRQ(i) (((i) != 0) && ((i) != 2))
@@ -380,17 +381,63 @@ unsigned int acpi_dev_get_irq_type(int triggering, int polarity)
 }
 EXPORT_SYMBOL_GPL(acpi_dev_get_irq_type);
 
+static const struct dmi_system_id medion_laptop[] = {
+	{
+		.ident = "MEDION P15651",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "MEDION"),
+			DMI_MATCH(DMI_BOARD_NAME, "M15T"),
+		},
+	},
+	{ }
+};
+
+struct irq_override_cmp {
+	const struct dmi_system_id *system;
+	unsigned char irq;
+	unsigned char triggering;
+	unsigned char polarity;
+	unsigned char shareable;
+};
+
+static const struct irq_override_cmp skip_override_table[] = {
+	{ medion_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0 },
+};
+
+static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
+				  u8 shareable)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(skip_override_table); i++) {
+		const struct irq_override_cmp *entry = &skip_override_table[i];
+
+		if (dmi_check_system(entry->system) &&
+		    entry->irq == gsi &&
+		    entry->triggering == triggering &&
+		    entry->polarity == polarity &&
+		    entry->shareable == shareable)
+			return false;
+	}
+
+	return true;
+}
+
 static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
 				     u8 triggering, u8 polarity, u8 shareable,
-				     bool legacy)
+				     bool check_override)
 {
 	int irq, p, t;
+	bool override;
 
 	if (!valid_IRQ(gsi)) {
 		irqresource_disabled(res, gsi);
 		return;
 	}
 
+	override = check_override && acpi_dev_irq_override(gsi, triggering,
+							   polarity, shareable);
+
 	/*
 	 * In IO-APIC mode, use overridden attribute. Two reasons:
 	 * 1. BIOS bug in DSDT
@@ -401,7 +448,7 @@ static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
 	 * using extended IRQ descriptors we take the IRQ configuration
 	 * from _CRS directly.
 	 */
-	if (legacy && !acpi_get_override_irq(gsi, &t, &p)) {
+	if (override && !acpi_get_override_irq(gsi, &t, &p)) {
 		u8 trig = t ? ACPI_LEVEL_SENSITIVE : ACPI_EDGE_SENSITIVE;
 		u8 pol = p ? ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
 
-- 
2.25.1

