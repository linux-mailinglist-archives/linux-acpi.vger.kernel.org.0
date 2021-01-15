Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4462F75E3
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Jan 2021 10:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbhAOJvB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Jan 2021 04:51:01 -0500
Received: from mga18.intel.com ([134.134.136.126]:51123 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729700AbhAOJvA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 Jan 2021 04:51:00 -0500
IronPort-SDR: XBeCFAqkdIgkZsHnKlwHLyqo9yzfIsto+vnWMF9WcHVNyIjJAhWtAoZfzLc2LCglmvbvZyJOIV
 jj80elk6g2hQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="166195730"
X-IronPort-AV: E=Sophos;i="5.79,349,1602572400"; 
   d="scan'208";a="166195730"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 01:49:23 -0800
IronPort-SDR: aj425wfM4VxnSMsWiLxAg7df9d1n+O2e8r8pzDl3tcED1bEMPdT+ltqM+s9ebAwzL2afqbmQBP
 KIdVTVkM6f2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,349,1602572400"; 
   d="scan'208";a="465538736"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 15 Jan 2021 01:49:20 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg KH <greg@kroah.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH v3 2/4] usb: dwc3: pci: Register a software node for the dwc3 platform device
Date:   Fri, 15 Jan 2021 12:49:12 +0300
Message-Id: <20210115094914.88401-3-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210115094914.88401-1-heikki.krogerus@linux.intel.com>
References: <20210115094914.88401-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

By registering the software node directly instead of just
the properties in it, the driver can take advantage of also
the other features the software nodes have.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Acked-by: Felipe Balbi <balbi@kernel.org>
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

