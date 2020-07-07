Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 868F021659E
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jul 2020 06:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgGGEy2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 Jul 2020 00:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbgGGEy2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Jul 2020 00:54:28 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0E9C061755
        for <linux-acpi@vger.kernel.org>; Mon,  6 Jul 2020 21:54:28 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id h2so22851470pgc.19
        for <linux-acpi@vger.kernel.org>; Mon, 06 Jul 2020 21:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=97u8CGQi5ZioYr1yjrYRCu5eLh5aS+BU1QeP4Xn39iE=;
        b=j74iLk6iDDXkBPsA4CTdYOGwVpUUBpAA5GaYkHpZD6PXKVLwwHW9U4CmP7rQG8AH6U
         Vd7mXz81Fhy5bxAJX9i7t29EEyAZVXIrmq42nlonIVGUTLKFrnY2T7i8bOv8vuF4hcqO
         2AG6nkNUZSeJ0dvO/0up6GKkjWHn50uPAHPBX+jNVI1ug7jSZk8qwydVsrcmeRso7Nuk
         mcF27eKhC4XkmypwETOGQESPqd2PXlxErfgHAyWMM6KoSlk+OshQI7up0c78ipFXZ8ew
         dTv9rqhJObUt4xOT4YbyOxGOlbaMkYmYX4nLg1x6qV/VWrtsQnoRkXuki/FrdABNFGr+
         ayjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=97u8CGQi5ZioYr1yjrYRCu5eLh5aS+BU1QeP4Xn39iE=;
        b=nojEOjtRrHX4pKDQtIUd//0sAKBVxtKswnXReRuwGtaqlbf4q1ts3vISbh3ewhUG1/
         nxO3wmlI2BaH9wvClEQoXU98qQmgcoB46dJzb9gNaWtl1QEmoOf2Gp2hMuELLXavwhAY
         7RQcDQyBEdL4hNXPlrjO1lepvvUs0tMwjXLKFk8grZYtxFlxKL3SURZK12S+spIzE4dT
         tH9HGsgJ3mt3wGp8WIKX4une2gpIEVD1xknE3o8M1CTHENCj0ZAGaJ7CCCtRT+aPfxcZ
         iZQ2MCpsox28HpSfF9nrZCaWvAZxNa6d/WNQTJ+RxA5q6YeEXP7Z/s8NhGvLZNkkSVPY
         81eA==
X-Gm-Message-State: AOAM530w0ISXFbybn98Q+YNmJ9f67eR+GW0/NP2z4VdHRZ2kCrhbkK8F
        bmolDitaerRSc9nu9IHHb9cL+I44w09I
X-Google-Smtp-Source: ABdhPJzlN7mYF/xYvbEh4M34xEGrcIVP0SsMlzIK51wj8kyFYrmeeJcic2UyjCXpcUS7M7+8FR2jTxaHjlig
X-Received: by 2002:a17:90b:4c12:: with SMTP id na18mr432022pjb.0.1594097667077;
 Mon, 06 Jul 2020 21:54:27 -0700 (PDT)
Date:   Mon,  6 Jul 2020 21:54:17 -0700
In-Reply-To: <20200707045418.3517076-1-rajatja@google.com>
Message-Id: <20200707045418.3517076-3-rajatja@google.com>
Mime-Version: 1.0
References: <20200707045418.3517076-1-rajatja@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v3 3/4] PCI: Treat "external-facing" devices as internal
From:   Rajat Jain <rajatja@google.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, Raj Ashok <ashok.raj@intel.com>,
        lalithambika.krishnakumar@intel.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        oohall@gmail.com, Saravana Kannan <saravanak@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The "ExternalFacingPort" devices (root ports) are internal devices that
sit on the internal system fabric. Ref:
https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports

Currently they were treated (marked as untrusted) at par with other
external devices downstream those external facing rootports.

Use the platform flag to identify the external facing devices and then
treat them at par with internal devices (don't mark them untrusted).
Any devices downstream continue to be marked as "untrusted". This was
discussed here:
https://lore.kernel.org/linux-pci/20200610230906.GA1528594@bjorn-Precision-5520/

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v3: * fix commit log and minor code comment
    * Don't check for "ExternalFacingPort" on PCI_EXP_TYPE_DOWNSTREAM
    * Check only for pdev->external_facing in iommu.c
v2: cosmetic changes in commit log

 drivers/iommu/intel/iommu.c |  6 +++---
 drivers/pci/of.c            |  2 +-
 drivers/pci/pci-acpi.c      | 10 +++++-----
 drivers/pci/probe.c         |  2 +-
 include/linux/pci.h         |  8 ++++++++
 5 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d759e7234e982..4f0f6ee2d4aaa 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4738,12 +4738,12 @@ const struct attribute_group *intel_iommu_groups[] = {
 	NULL,
 };
 
-static inline bool has_untrusted_dev(void)
+static inline bool has_external_pci(void)
 {
 	struct pci_dev *pdev = NULL;
 
 	for_each_pci_dev(pdev)
-		if (pdev->untrusted)
+		if (pdev->external_facing)
 			return true;
 
 	return false;
@@ -4751,7 +4751,7 @@ static inline bool has_untrusted_dev(void)
 
 static int __init platform_optin_force_iommu(void)
 {
-	if (!dmar_platform_optin() || no_platform_optin || !has_untrusted_dev())
+	if (!dmar_platform_optin() || no_platform_optin || !has_external_pci())
 		return 0;
 
 	if (no_iommu || dmar_disabled)
diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 27839cd2459f6..22727fc9558df 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -42,7 +42,7 @@ void pci_set_bus_of_node(struct pci_bus *bus)
 	} else {
 		node = of_node_get(bus->self->dev.of_node);
 		if (node && of_property_read_bool(node, "external-facing"))
-			bus->self->untrusted = true;
+			bus->self->external_facing = true;
 	}
 
 	bus->dev.of_node = node;
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 7224b1e5f2a83..43a5158b2b662 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1213,7 +1213,7 @@ static void pci_acpi_optimize_delay(struct pci_dev *pdev,
 	ACPI_FREE(obj);
 }
 
-static void pci_acpi_set_untrusted(struct pci_dev *dev)
+static void pci_acpi_set_external_facing(struct pci_dev *dev)
 {
 	u8 val;
 
@@ -1223,12 +1223,12 @@ static void pci_acpi_set_untrusted(struct pci_dev *dev)
 		return;
 
 	/*
-	 * These root ports expose PCIe (including DMA) outside of the
-	 * system so make sure we treat them and everything behind as
+	 * These root/down ports expose PCIe (including DMA) outside of the
+	 * system so make sure we treat everything behind them as
 	 * untrusted.
 	 */
 	if (val)
-		dev->untrusted = 1;
+		dev->external_facing = 1;
 }
 
 static void pci_acpi_setup(struct device *dev)
@@ -1240,7 +1240,7 @@ static void pci_acpi_setup(struct device *dev)
 		return;
 
 	pci_acpi_optimize_delay(pci_dev, adev->handle);
-	pci_acpi_set_untrusted(pci_dev);
+	pci_acpi_set_external_facing(pci_dev);
 	pci_acpi_add_edr_notifier(pci_dev);
 
 	pci_acpi_add_pm_notifier(adev, pci_dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 6d87066a5ecc5..8c40c00413e74 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1552,7 +1552,7 @@ static void set_pcie_untrusted(struct pci_dev *dev)
 	 * untrusted as well.
 	 */
 	parent = pci_upstream_bridge(dev);
-	if (parent && parent->untrusted)
+	if (parent && (parent->untrusted || parent->external_facing))
 		dev->untrusted = true;
 }
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0ca39042507ce..281be857d2430 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -432,6 +432,14 @@ struct pci_dev {
 	 * mappings to make sure they cannot access arbitrary memory.
 	 */
 	unsigned int	untrusted:1;
+	/*
+	 * Devices are marked as external-facing using info from platform
+	 * (ACPI / devicetree). An external-facing device is still an internal
+	 * trusted device, but it faces external untrusted devices. Thus any
+	 * device enumerated downstream an external-facing device, is marked
+	 * as untrusted.
+	 */
+	unsigned int	external_facing:1;
 	unsigned int	broken_intx_masking:1;	/* INTx masking can't be used */
 	unsigned int	io_window_1k:1;		/* Intel bridge 1K I/O windows */
 	unsigned int	irq_managed:1;
-- 
2.27.0.212.ge8ba1cc988-goog

