Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18904593A7
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Nov 2021 18:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238168AbhKVRJL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 Nov 2021 12:09:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56951 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237867AbhKVRJJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 22 Nov 2021 12:09:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637600762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VmVklH+IaL1BbsO+6jNr8NlRCKg2nfcFyO4zpvxC92w=;
        b=QhobhpdVg32f0g4g/ruhk8DlA2xXM3fjDvomA+2rU+wjQzXW9sGezb48Yq4K00fBTVVN6N
        +0tsihDAxxHlCRJj7sZNvHgt2lbqCrHDu6esDW6FJyGdUV1nGGuIwOJJEtsjsseTpt5yeW
        1cF3HCfvTTREFl+mhSjDSlUQdKYEqDM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-176-MM0irJMYNIWGATEb1gL7TA-1; Mon, 22 Nov 2021 12:06:00 -0500
X-MC-Unique: MM0irJMYNIWGATEb1gL7TA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AEA5287D541;
        Mon, 22 Nov 2021 17:05:59 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.226])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 464385D6D5;
        Mon, 22 Nov 2021 17:05:58 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: [PATCH v2 6/7] mmc: sdhci-acpi: Remove special handling for GPD win/pocket devices
Date:   Mon, 22 Nov 2021 18:05:35 +0100
Message-Id: <20211122170536.7725-7-hdegoede@redhat.com>
In-Reply-To: <20211122170536.7725-1-hdegoede@redhat.com>
References: <20211122170536.7725-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Remove the special sdhci_acpi_no_fixup_child_power() helper which was
added to avoid triggering an ACPI tables bug on the GPD win/pocket
devices.

The ACPI child-device triggering this bug has now been added to the
acpi_device_override_status() quirk table, so that its status
field is set to all 0 (instead of the wrong return value from the _STA
ACPI method). This removes the need for the special handling in
the sdhci-acpi code.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- No changes in v2 of this patch-series
---
 drivers/mmc/host/sdhci-acpi.c | 61 ++---------------------------------
 1 file changed, 3 insertions(+), 58 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index f1ef0d28b0dd..1461aae13c19 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -34,7 +34,6 @@
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 #include <asm/iosf_mbi.h>
-#include <linux/pci.h>
 #endif
 
 #include "sdhci.h"
@@ -250,16 +249,6 @@ static bool sdhci_acpi_byt(void)
 	return x86_match_cpu(byt);
 }
 
-static bool sdhci_acpi_cht(void)
-{
-	static const struct x86_cpu_id cht[] = {
-		X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT, NULL),
-		{}
-	};
-
-	return x86_match_cpu(cht);
-}
-
 #define BYT_IOSF_SCCEP			0x63
 #define BYT_IOSF_OCP_NETCTRL0		0x1078
 #define BYT_IOSF_OCP_TIMEOUT_BASE	GENMASK(10, 8)
@@ -304,43 +293,6 @@ static bool sdhci_acpi_byt_defer(struct device *dev)
 	return false;
 }
 
-static bool sdhci_acpi_cht_pci_wifi(unsigned int vendor, unsigned int device,
-				    unsigned int slot, unsigned int parent_slot)
-{
-	struct pci_dev *dev, *parent, *from = NULL;
-
-	while (1) {
-		dev = pci_get_device(vendor, device, from);
-		pci_dev_put(from);
-		if (!dev)
-			break;
-		parent = pci_upstream_bridge(dev);
-		if (ACPI_COMPANION(&dev->dev) && PCI_SLOT(dev->devfn) == slot &&
-		    parent && PCI_SLOT(parent->devfn) == parent_slot &&
-		    !pci_upstream_bridge(parent)) {
-			pci_dev_put(dev);
-			return true;
-		}
-		from = dev;
-	}
-
-	return false;
-}
-
-/*
- * GPDwin uses PCI wifi which conflicts with SDIO's use of
- * acpi_device_fix_up_power() on child device nodes. Identifying GPDwin is
- * problematic, but since SDIO is only used for wifi, the presence of the PCI
- * wifi card in the expected slot with an ACPI companion node, is used to
- * indicate that acpi_device_fix_up_power() should be avoided.
- */
-static inline bool sdhci_acpi_no_fixup_child_power(struct acpi_device *adev)
-{
-	return sdhci_acpi_cht() &&
-	       acpi_dev_hid_uid_match(adev, "80860F14", "2") &&
-	       sdhci_acpi_cht_pci_wifi(0x14e4, 0x43ec, 0, 28);
-}
-
 #else
 
 static inline void sdhci_acpi_byt_setting(struct device *dev)
@@ -352,11 +304,6 @@ static inline bool sdhci_acpi_byt_defer(struct device *dev)
 	return false;
 }
 
-static inline bool sdhci_acpi_no_fixup_child_power(struct acpi_device *adev)
-{
-	return false;
-}
-
 #endif
 
 static int bxt_get_cd(struct mmc_host *mmc)
@@ -861,11 +808,9 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 
 	/* Power on the SDHCI controller and its children */
 	acpi_device_fix_up_power(device);
-	if (!sdhci_acpi_no_fixup_child_power(device)) {
-		list_for_each_entry(child, &device->children, node)
-			if (child->status.present && child->status.enabled)
-				acpi_device_fix_up_power(child);
-	}
+	list_for_each_entry(child, &device->children, node)
+		if (child->status.present && child->status.enabled)
+			acpi_device_fix_up_power(child);
 
 	if (sdhci_acpi_byt_defer(dev))
 		return -EPROBE_DEFER;
-- 
2.33.1

