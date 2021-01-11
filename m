Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43FCA2F17C2
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Jan 2021 15:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbhAKONY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Jan 2021 09:13:24 -0500
Received: from mga17.intel.com ([192.55.52.151]:16819 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732693AbhAKONJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 11 Jan 2021 09:13:09 -0500
IronPort-SDR: Qnvjt2eJRPrCF6jRh+/paDUGZbPu0vxP8URz/O2+vILGZttqWOFGxhfr/P+AYVP36QHHUw3gEd
 lz5KuMAE1iYA==
X-IronPort-AV: E=McAfee;i="6000,8403,9860"; a="157645652"
X-IronPort-AV: E=Sophos;i="5.79,338,1602572400"; 
   d="scan'208";a="157645652"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 06:10:54 -0800
IronPort-SDR: 8v2v10JIrOosYBRPVwDo6fw1qlSMc4MimG2LBH7UH4EmYxF/c04VypIr8zUXOamYT+7ebga6h7
 vpIjnPUMy6ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,338,1602572400"; 
   d="scan'208";a="464171615"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 11 Jan 2021 06:10:52 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Felipe Balbi <balbi@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH v2 2/3] usb: dwc3: pci: Register a software node for the dwc3 platform device
Date:   Mon, 11 Jan 2021 17:10:44 +0300
Message-Id: <20210111141045.14027-3-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210111141045.14027-1-heikki.krogerus@linux.intel.com>
References: <20210111141045.14027-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

By registering the software node directly instead of just
the properties in it, the driver can take advantage of also
the other features the software nodes have.

Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/dwc3/dwc3-pci.c | 61 ++++++++++++++++++++++---------------
 1 file changed, 37 insertions(+), 24 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index bae6a70664c80..037bc21bffa66 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -142,6 +142,18 @@ static const struct property_entry dwc3_pci_amd_properties[] = {
 	{}
 };
 
+static const struct software_node dwc3_pci_intel_swnode = {
+	.properties = dwc3_pci_intel_properties,
+};
+
+static const struct software_node dwc3_pci_intel_mrfld_swnode = {
+	.properties = dwc3_pci_mrfld_properties,
+};
+
+static const struct software_node dwc3_pci_amd_swnode = {
+	.properties = dwc3_pci_amd_properties,
+};
+
 static int dwc3_pci_quirks(struct dwc3_pci *dwc)
 {
 	struct pci_dev			*pdev = dwc->pci;
@@ -222,7 +234,6 @@ static void dwc3_pci_resume_work(struct work_struct *work)
 
 static int dwc3_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
 {
-	struct property_entry *p = (struct property_entry *)id->driver_data;
 	struct dwc3_pci		*dwc;
 	struct resource		res[2];
 	int			ret;
@@ -265,7 +276,7 @@ static int dwc3_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
 	dwc->dwc3->dev.parent = dev;
 	ACPI_COMPANION_SET(&dwc->dwc3->dev, ACPI_COMPANION(dev));
 
-	ret = platform_device_add_properties(dwc->dwc3, p);
+	ret = device_add_software_node(&dwc->dwc3->dev, (void *)id->driver_data);
 	if (ret < 0)
 		goto err;
 
@@ -288,6 +299,7 @@ static int dwc3_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
 
 	return 0;
 err:
+	device_remove_software_node(&dwc->dwc3->dev);
 	platform_device_put(dwc->dwc3);
 	return ret;
 }
@@ -304,75 +316,76 @@ static void dwc3_pci_remove(struct pci_dev *pci)
 #endif
 	device_init_wakeup(&pci->dev, false);
 	pm_runtime_get(&pci->dev);
+	device_remove_software_node(&dwc->dwc3->dev);
 	platform_device_unregister(dwc->dwc3);
 }
 
 static const struct pci_device_id dwc3_pci_id_table[] = {
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_BSW),
-	  (kernel_ulong_t) &dwc3_pci_intel_properties },
+	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
 
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_BYT),
-	  (kernel_ulong_t) &dwc3_pci_intel_properties, },
+	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
 
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_MRFLD),
-	  (kernel_ulong_t) &dwc3_pci_mrfld_properties, },
+	  (kernel_ulong_t) &dwc3_pci_intel_mrfld_swnode, },
 
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_CMLLP),
-	  (kernel_ulong_t) &dwc3_pci_intel_properties, },
+	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
 
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_CMLH),
-	  (kernel_ulong_t) &dwc3_pci_intel_properties, },
+	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
 
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_SPTLP),
-	  (kernel_ulong_t) &dwc3_pci_intel_properties, },
+	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
 
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_SPTH),
-	  (kernel_ulong_t) &dwc3_pci_intel_properties, },
+	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
 
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_BXT),
-	  (kernel_ulong_t) &dwc3_pci_intel_properties, },
+	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
 
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_BXT_M),
-	  (kernel_ulong_t) &dwc3_pci_intel_properties, },
+	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
 
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_APL),
-	  (kernel_ulong_t) &dwc3_pci_intel_properties, },
+	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
 
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_KBP),
-	  (kernel_ulong_t) &dwc3_pci_intel_properties, },
+	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
 
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_GLK),
-	  (kernel_ulong_t) &dwc3_pci_intel_properties, },
+	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
 
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_CNPLP),
-	  (kernel_ulong_t) &dwc3_pci_intel_properties, },
+	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
 
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_CNPH),
-	  (kernel_ulong_t) &dwc3_pci_intel_properties, },
+	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
 
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_CNPV),
-	  (kernel_ulong_t) &dwc3_pci_intel_properties, },
+	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
 
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ICLLP),
-	  (kernel_ulong_t) &dwc3_pci_intel_properties, },
+	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
 
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_EHLLP),
-	  (kernel_ulong_t) &dwc3_pci_intel_properties, },
+	  (kernel_ulong_t) &dwc3_pci_intel_swnode },
 
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_TGPLP),
-	  (kernel_ulong_t) &dwc3_pci_intel_properties, },
+	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
 
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_TGPH),
-	  (kernel_ulong_t) &dwc3_pci_intel_properties, },
+	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
 
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_JSP),
-	  (kernel_ulong_t) &dwc3_pci_intel_properties, },
+	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
 
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ADLS),
-	  (kernel_ulong_t) &dwc3_pci_intel_properties, },
+	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
 
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_NL_USB),
-	  (kernel_ulong_t) &dwc3_pci_amd_properties, },
+	  (kernel_ulong_t) &dwc3_pci_amd_swnode, },
 	{  }	/* Terminating Entry */
 };
 MODULE_DEVICE_TABLE(pci, dwc3_pci_id_table);
-- 
2.29.2

