Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF44E455018
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Nov 2021 23:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237296AbhKQWEv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 Nov 2021 17:04:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32892 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240895AbhKQWEj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 17 Nov 2021 17:04:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637186500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WjLVDG8N0MXzJ2oHOzAcwIMXW48KBydTvDcjtGW58vQ=;
        b=Z5xagY3wjnUkaLUrZWUIv93Eg2P+zoO3a3uSH0rAGRQA+KnfzDC/Ko/l1f/zLTeUtXDczz
        xxj7JjDfwzK4VJZuE90in+dFKTpDbAckRC8K0g3RDPwlH9fs+tPDNblu/jmMp0R8Q4z7Hf
        rbNhGQbAxtG585XnHlAUycBP0Ey6p5Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-160-t_3D4irDO5CMMBztwGMp3w-1; Wed, 17 Nov 2021 17:01:36 -0500
X-MC-Unique: t_3D4irDO5CMMBztwGMp3w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E8FB19057A1;
        Wed, 17 Nov 2021 22:01:34 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.192.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0C3A35D9DE;
        Wed, 17 Nov 2021 22:01:32 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: [PATCH 4/5] mmc: sdhci-acpi: Remove special handling for GPD win/pocket devices
Date:   Wed, 17 Nov 2021 23:01:17 +0100
Message-Id: <20211117220118.408953-5-hdegoede@redhat.com>
In-Reply-To: <20211117220118.408953-1-hdegoede@redhat.com>
References: <20211117220118.408953-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
2.31.1

