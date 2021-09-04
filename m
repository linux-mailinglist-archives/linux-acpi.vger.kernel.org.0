Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9299140092E
	for <lists+linux-acpi@lfdr.de>; Sat,  4 Sep 2021 03:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351086AbhIDBpD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 3 Sep 2021 21:45:03 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:56688
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231389AbhIDBpD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Sep 2021 21:45:03 -0400
Received: from localhost.localdomain (unknown [123.112.70.37])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 239713F336;
        Sat,  4 Sep 2021 01:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1630719836;
        bh=YUjw+GvboUZTZdp9Yn6XFYgmMzKp7VJVVCJ1v4GqtkQ=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=B7Tr840KTEl06thIhB43lUiu0DdYDSkK5arDWcoc3/CHNhORvutBDGRWVJxyeQWwc
         BthXq90U70UMKQAzSIhS+3Tzh/FMd7U5wcM0wOBNsqh+HGu9SJ+VfsmMyXl+AGdByh
         TeZ0KiKWK3zOenzo+QEbj1fssYP/aT4RP4Q/1uDraYv/K7Js0aMIKG1w/Q0CcLPuxk
         n9dw3TtrQLGJiJ98iVmKkbLex1Zkj0Wicvv+cYZ5vw/eQ2sNJehKcfF5LwH/uG5ZuP
         YQFIxRjzoH5s6fKUp/YLTcILWsa6iUo/4wattnspxtomiht/96lZvXSggAZBNkMc0n
         mB69zM72HSiRg==
From:   Hui Wang <hui.wang@canonical.com>
To:     linux-acpi@vger.kernel.org, rafael.j.wysocki@intel.com
Cc:     manuelkrause@netscape.net
Subject: [PATCH] ACPI: resources: add legacy irq override exception by DMI info
Date:   Sat,  4 Sep 2021 09:43:40 +0800
Message-Id: <20210904014340.17536-1-hui.wang@canonical.com>
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
Reported-by: Manuel Krause <manuelkrause@netscape.net>
Tested-by: Manuel Krause <manuelkrause@netscape.net>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 drivers/acpi/resource.c | 52 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index ee78a210c606..434c8964f182 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -16,6 +16,7 @@
 #include <linux/ioport.h>
 #include <linux/slab.h>
 #include <linux/irq.h>
+#include <linux/dmi.h>
 
 #ifdef CONFIG_X86
 #define valid_IRQ(i) (((i) != 0) && ((i) != 2))
@@ -423,6 +424,49 @@ static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
 	}
 }
 
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
+static bool acpi_dev_legacy_irq_override(u32 gsi, u8 triggering, u8 polarity,
+					 u8 shareable)
+{
+	int i;
+	const struct irq_override_cmp *en;
+
+	for (i = 0; i < ARRAY_SIZE(skip_override_table); i++) {
+		en = &skip_override_table[i];
+
+		if (dmi_check_system(en->system) &&
+		    en->irq == gsi &&
+		    en->triggering == triggering &&
+		    en->polarity == polarity &&
+		    en->shareable == shareable)
+			return false;
+	}
+
+	return true;
+}
+
 /**
  * acpi_dev_resource_interrupt - Extract ACPI interrupt resource information.
  * @ares: Input ACPI resource object.
@@ -447,6 +491,7 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
 {
 	struct acpi_resource_irq *irq;
 	struct acpi_resource_extended_irq *ext_irq;
+	bool is_legacy;
 
 	switch (ares->type) {
 	case ACPI_RESOURCE_TYPE_IRQ:
@@ -459,9 +504,14 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
 			irqresource_disabled(res, 0);
 			return false;
 		}
+
+		is_legacy = acpi_dev_legacy_irq_override(irq->interrupts[index],
+							 irq->triggering, irq->polarity,
+							 irq->shareable);
+
 		acpi_dev_get_irqresource(res, irq->interrupts[index],
 					 irq->triggering, irq->polarity,
-					 irq->shareable, true);
+					 irq->shareable, is_legacy);
 		break;
 	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
 		ext_irq = &ares->data.extended_irq;
-- 
2.25.1

