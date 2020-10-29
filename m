Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA6E629E9D7
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Oct 2020 12:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgJ2K7x (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Oct 2020 06:59:53 -0400
Received: from mga01.intel.com ([192.55.52.88]:56292 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbgJ2K7v (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 29 Oct 2020 06:59:51 -0400
IronPort-SDR: tW8/rAiOqGnPAKQrkCpiljYdh5JBnmF+w5JeH3n8I8M+ySya8bIcwqdcELA/zTZHdLwb/TSvw/
 iv0ZANxFSWfg==
X-IronPort-AV: E=McAfee;i="6000,8403,9788"; a="186197292"
X-IronPort-AV: E=Sophos;i="5.77,429,1596524400"; 
   d="scan'208";a="186197292"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 03:59:51 -0700
IronPort-SDR: f3/Yq1V5A9wEvnDyIQcEhHJ+NEDT/hpJm1F9eLj2DJZgyBSNiLaUl0Nlt1hDDqZUyL39H2chtD
 PipK+sgjLr7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,429,1596524400"; 
   d="scan'208";a="425017610"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 29 Oct 2020 03:59:49 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCHv2 3/3] usb: dwc3: pci: Register a software node for the dwc3 platform device
Date:   Thu, 29 Oct 2020 13:59:41 +0300
Message-Id: <20201029105941.63410-4-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029105941.63410-1-heikki.krogerus@linux.intel.com>
References: <20201029105941.63410-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

By registering the software node directly instead of just
the properties in it, the driver can take advantage of also
the other features the software nodes have.

Initially using the nodes for isolating the Intel Broxton
specific power management quirk by handling it in Broxton's
very own power management operations (which are supplied as
part of the software node) instead of the drivers generic
ones.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Felipe Balbi <balbi@kernel.org>
---
 drivers/usb/dwc3/dwc3-pci.c | 175 ++++++++++++++++++------------------
 1 file changed, 86 insertions(+), 89 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index 242b6210380a4..43cc0f602820d 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -54,17 +54,12 @@
  * struct dwc3_pci - Driver private structure
  * @dwc3: child dwc3 platform_device
  * @pci: our link to PCI bus
- * @guid: _DSM GUID
- * @has_dsm_for_pm: true for devices which need to run _DSM on runtime PM
  * @wakeup_work: work for asynchronous resume
  */
 struct dwc3_pci {
 	struct platform_device *dwc3;
 	struct pci_dev *pci;
 
-	guid_t guid;
-
-	unsigned int has_dsm_for_pm:1;
 	struct work_struct wakeup_work;
 };
 
@@ -108,6 +103,50 @@ static int dwc3_byt_enable_ulpi_refclock(struct pci_dev *pci)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int dwc3_pci_intel_pm_dsm(struct device *dev, int param)
+{
+	union acpi_object *obj;
+	union acpi_object tmp;
+	union acpi_object argv4 = ACPI_INIT_DSM_ARGV4(1, &tmp);
+	guid_t guid;
+	int ret;
+
+	ret = guid_parse(PCI_INTEL_BXT_DSM_GUID, &guid);
+	if (ret)
+		return ret;
+
+	tmp.type = ACPI_TYPE_INTEGER;
+	tmp.integer.value = param;
+
+	obj = acpi_evaluate_dsm(ACPI_HANDLE(dev), &guid,
+				1, PCI_INTEL_BXT_FUNC_PMU_PWR, &argv4);
+	if (!obj) {
+		dev_err(dev, "failed to evaluate _DSM\n");
+		return -EIO;
+	}
+
+	ACPI_FREE(obj);
+
+	return 0;
+}
+
+static int dwc3_pci_intel_suspend(struct device *dev)
+{
+	return dwc3_pci_intel_pm_dsm(dev->parent, PCI_INTEL_BXT_STATE_D3);
+}
+
+static int dwc3_pci_intel_resume(struct device *dev)
+{
+	return dwc3_pci_intel_pm_dsm(dev->parent, PCI_INTEL_BXT_STATE_D0);
+}
+#endif /* CONFIG_PM */
+
+static const struct dev_pm_ops dwc3_pci_intel_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(dwc3_pci_intel_suspend, dwc3_pci_intel_resume)
+	SET_RUNTIME_PM_OPS(dwc3_pci_intel_suspend, dwc3_pci_intel_resume, NULL)
+};
+
 static const struct property_entry dwc3_pci_intel_properties[] = {
 	PROPERTY_ENTRY_STRING("dr_mode", "peripheral"),
 	PROPERTY_ENTRY_BOOL("linux,sysdev_is_parent"),
@@ -141,18 +180,28 @@ static const struct property_entry dwc3_pci_amd_properties[] = {
 	{}
 };
 
+static const struct software_node dwc3_pci_intel_swnode = {
+	.properties = dwc3_pci_intel_properties,
+};
+
+static const struct software_node dwc3_pci_intel_pm_swnode = {
+	.properties = dwc3_pci_intel_properties,
+	.pm = &dwc3_pci_intel_pm_ops,
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
 
 	if (pdev->vendor == PCI_VENDOR_ID_INTEL) {
-		if (pdev->device == PCI_DEVICE_ID_INTEL_BXT ||
-		    pdev->device == PCI_DEVICE_ID_INTEL_BXT_M ||
-		    pdev->device == PCI_DEVICE_ID_INTEL_EHLLP) {
-			guid_parse(PCI_INTEL_BXT_DSM_GUID, &dwc->guid);
-			dwc->has_dsm_for_pm = true;
-		}
-
 		if (pdev->device == PCI_DEVICE_ID_INTEL_BYT) {
 			struct gpio_desc *gpio;
 			int ret;
@@ -221,7 +270,6 @@ static void dwc3_pci_resume_work(struct work_struct *work)
 
 static int dwc3_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
 {
-	struct property_entry *p = (struct property_entry *)id->driver_data;
 	struct dwc3_pci		*dwc;
 	struct resource		res[2];
 	int			ret;
@@ -264,7 +312,7 @@ static int dwc3_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
 	dwc->dwc3->dev.parent = dev;
 	ACPI_COMPANION_SET(&dwc->dwc3->dev, ACPI_COMPANION(dev));
 
-	ret = platform_device_add_properties(dwc->dwc3, p);
+	ret = device_add_software_node(&dwc->dwc3->dev, (void *)id->driver_data);
 	if (ret < 0)
 		goto err;
 
@@ -287,6 +335,7 @@ static int dwc3_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
 
 	return 0;
 err:
+	device_remove_software_node(&dwc->dwc3->dev);
 	platform_device_put(dwc->dwc3);
 	return ret;
 }
@@ -303,121 +352,86 @@ static void dwc3_pci_remove(struct pci_dev *pci)
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
+	  (kernel_ulong_t) &dwc3_pci_intel_pm_swnode, },
 
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_BXT_M),
-	  (kernel_ulong_t) &dwc3_pci_intel_properties, },
+	  (kernel_ulong_t) &dwc3_pci_intel_pm_swnode, },
 
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
+	  (kernel_ulong_t) &dwc3_pci_intel_pm_swnode },
 
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_TGPLP),
-	  (kernel_ulong_t) &dwc3_pci_intel_properties, },
+	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
 
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_TGPH),
-	  (kernel_ulong_t) &dwc3_pci_intel_properties, },
+	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
 
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_JSP),
-	  (kernel_ulong_t) &dwc3_pci_intel_properties, },
+	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
 
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_NL_USB),
-	  (kernel_ulong_t) &dwc3_pci_amd_properties, },
+	  (kernel_ulong_t) &dwc3_pci_amd_swnode, },
 	{  }	/* Terminating Entry */
 };
 MODULE_DEVICE_TABLE(pci, dwc3_pci_id_table);
 
-#if defined(CONFIG_PM) || defined(CONFIG_PM_SLEEP)
-static int dwc3_pci_dsm(struct dwc3_pci *dwc, int param)
-{
-	union acpi_object *obj;
-	union acpi_object tmp;
-	union acpi_object argv4 = ACPI_INIT_DSM_ARGV4(1, &tmp);
-
-	if (!dwc->has_dsm_for_pm)
-		return 0;
-
-	tmp.type = ACPI_TYPE_INTEGER;
-	tmp.integer.value = param;
-
-	obj = acpi_evaluate_dsm(ACPI_HANDLE(&dwc->pci->dev), &dwc->guid,
-			1, PCI_INTEL_BXT_FUNC_PMU_PWR, &argv4);
-	if (!obj) {
-		dev_err(&dwc->pci->dev, "failed to evaluate _DSM\n");
-		return -EIO;
-	}
-
-	ACPI_FREE(obj);
-
-	return 0;
-}
-#endif /* CONFIG_PM || CONFIG_PM_SLEEP */
-
 #ifdef CONFIG_PM
 static int dwc3_pci_runtime_suspend(struct device *dev)
 {
-	struct dwc3_pci		*dwc = dev_get_drvdata(dev);
-
-	if (device_can_wakeup(dev))
-		return dwc3_pci_dsm(dwc, PCI_INTEL_BXT_STATE_D3);
-
-	return -EBUSY;
+	return device_can_wakeup(dev) ? 0 : -EBUSY;
 }
 
 static int dwc3_pci_runtime_resume(struct device *dev)
 {
 	struct dwc3_pci		*dwc = dev_get_drvdata(dev);
-	int			ret;
-
-	ret = dwc3_pci_dsm(dwc, PCI_INTEL_BXT_STATE_D0);
-	if (ret)
-		return ret;
 
 	queue_work(pm_wq, &dwc->wakeup_work);
 
@@ -425,24 +439,7 @@ static int dwc3_pci_runtime_resume(struct device *dev)
 }
 #endif /* CONFIG_PM */
 
-#ifdef CONFIG_PM_SLEEP
-static int dwc3_pci_suspend(struct device *dev)
-{
-	struct dwc3_pci		*dwc = dev_get_drvdata(dev);
-
-	return dwc3_pci_dsm(dwc, PCI_INTEL_BXT_STATE_D3);
-}
-
-static int dwc3_pci_resume(struct device *dev)
-{
-	struct dwc3_pci		*dwc = dev_get_drvdata(dev);
-
-	return dwc3_pci_dsm(dwc, PCI_INTEL_BXT_STATE_D0);
-}
-#endif /* CONFIG_PM_SLEEP */
-
 static const struct dev_pm_ops dwc3_pci_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(dwc3_pci_suspend, dwc3_pci_resume)
 	SET_RUNTIME_PM_OPS(dwc3_pci_runtime_suspend, dwc3_pci_runtime_resume,
 		NULL)
 };
-- 
2.28.0

