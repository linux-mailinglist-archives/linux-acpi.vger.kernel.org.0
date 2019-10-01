Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C70C2C373C
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Oct 2019 16:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388917AbfJAO1d (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Oct 2019 10:27:33 -0400
Received: from mga05.intel.com ([192.55.52.43]:29363 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbfJAO1d (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 1 Oct 2019 10:27:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 07:27:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,571,1559545200"; 
   d="scan'208";a="216084449"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 01 Oct 2019 07:27:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8C3C924C; Tue,  1 Oct 2019 17:27:26 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 5/6] mmc: sdhci-acpi: Switch to use acpi_dev_hid_uid_match()
Date:   Tue,  1 Oct 2019 17:27:24 +0300
Message-Id: <20191001142725.30857-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191001142725.30857-1-andriy.shevchenko@linux.intel.com>
References: <20191001142725.30857-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Since we have a generic helper, drop custom implementation in the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/mmc/host/sdhci-acpi.c | 49 ++++++++++++-----------------------
 1 file changed, 16 insertions(+), 33 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 1604f512c7bd..105e73d4a3b9 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -61,7 +61,7 @@ struct sdhci_acpi_slot {
 	mmc_pm_flag_t	pm_caps;
 	unsigned int	flags;
 	size_t		priv_size;
-	int (*probe_slot)(struct platform_device *, const char *, const char *);
+	int (*probe_slot)(struct platform_device *, struct acpi_device *);
 	int (*remove_slot)(struct platform_device *);
 	int (*free_slot)(struct platform_device *pdev);
 	int (*setup_host)(struct platform_device *pdev);
@@ -325,12 +325,10 @@ static bool sdhci_acpi_cht_pci_wifi(unsigned int vendor, unsigned int device,
  * wifi card in the expected slot with an ACPI companion node, is used to
  * indicate that acpi_device_fix_up_power() should be avoided.
  */
-static inline bool sdhci_acpi_no_fixup_child_power(const char *hid,
-						   const char *uid)
+static inline bool sdhci_acpi_no_fixup_child_power(struct acpi_device *adev)
 {
 	return sdhci_acpi_cht() &&
-	       !strcmp(hid, "80860F14") &&
-	       !strcmp(uid, "2") &&
+	       acpi_dev_hid_uid_match(adev, "80860F14", "2") &&
 	       sdhci_acpi_cht_pci_wifi(0x14e4, 0x43ec, 0, 28);
 }
 
@@ -345,8 +343,7 @@ static inline bool sdhci_acpi_byt_defer(struct device *dev)
 	return false;
 }
 
-static inline bool sdhci_acpi_no_fixup_child_power(const char *hid,
-						   const char *uid)
+static inline bool sdhci_acpi_no_fixup_child_power(struct acpi_device *adev)
 {
 	return false;
 }
@@ -375,19 +372,18 @@ static int bxt_get_cd(struct mmc_host *mmc)
 	return ret;
 }
 
-static int intel_probe_slot(struct platform_device *pdev, const char *hid,
-			    const char *uid)
+static int intel_probe_slot(struct platform_device *pdev, struct acpi_device *adev)
 {
 	struct sdhci_acpi_host *c = platform_get_drvdata(pdev);
 	struct intel_host *intel_host = sdhci_acpi_priv(c);
 	struct sdhci_host *host = c->host;
 
-	if (hid && uid && !strcmp(hid, "80860F14") && !strcmp(uid, "1") &&
+	if (acpi_dev_hid_uid_match(adev, "80860F14", "1") &&
 	    sdhci_readl(host, SDHCI_CAPABILITIES) == 0x446cc8b2 &&
 	    sdhci_readl(host, SDHCI_CAPABILITIES_1) == 0x00000807)
 		host->timeout_clk = 1000; /* 1000 kHz i.e. 1 MHz */
 
-	if (hid && !strcmp(hid, "80865ACA"))
+	if (acpi_dev_hid_uid_match(adev, "80865ACA", NULL))
 		host->mmc_host_ops.get_cd = bxt_get_cd;
 
 	intel_dsm_init(intel_host, &pdev->dev, host->mmc);
@@ -473,8 +469,7 @@ static irqreturn_t sdhci_acpi_qcom_handler(int irq, void *ptr)
 	return IRQ_HANDLED;
 }
 
-static int qcom_probe_slot(struct platform_device *pdev, const char *hid,
-			   const char *uid)
+static int qcom_probe_slot(struct platform_device *pdev, struct acpi_device *adev)
 {
 	struct sdhci_acpi_host *c = platform_get_drvdata(pdev);
 	struct sdhci_host *host = c->host;
@@ -482,7 +477,7 @@ static int qcom_probe_slot(struct platform_device *pdev, const char *hid,
 
 	*irq = -EINVAL;
 
-	if (strcmp(hid, "QCOM8051"))
+	if (!acpi_dev_hid_uid_match(adev, "QCOM8051", NULL))
 		return 0;
 
 	*irq = platform_get_irq(pdev, 1);
@@ -501,14 +496,12 @@ static int qcom_free_slot(struct platform_device *pdev)
 	struct sdhci_host *host = c->host;
 	struct acpi_device *adev;
 	int *irq = sdhci_acpi_priv(c);
-	const char *hid;
 
 	adev = ACPI_COMPANION(dev);
 	if (!adev)
 		return -ENODEV;
 
-	hid = acpi_device_hid(adev);
-	if (strcmp(hid, "QCOM8051"))
+	if (!acpi_dev_hid_uid_match(adev, "QCOM8051", NULL))
 		return 0;
 
 	if (*irq < 0)
@@ -583,7 +576,7 @@ static const struct sdhci_acpi_chip sdhci_acpi_chip_amd = {
 };
 
 static int sdhci_acpi_emmc_amd_probe_slot(struct platform_device *pdev,
-					  const char *hid, const char *uid)
+					  struct acpi_device *adev)
 {
 	struct sdhci_acpi_host *c = platform_get_drvdata(pdev);
 	struct sdhci_host *host   = c->host;
@@ -654,17 +647,12 @@ static const struct acpi_device_id sdhci_acpi_ids[] = {
 };
 MODULE_DEVICE_TABLE(acpi, sdhci_acpi_ids);
 
-static const struct sdhci_acpi_slot *sdhci_acpi_get_slot(const char *hid,
-							 const char *uid)
+static const struct sdhci_acpi_slot *sdhci_acpi_get_slot(struct acpi_device *adev)
 {
 	const struct sdhci_acpi_uid_slot *u;
 
 	for (u = sdhci_acpi_uids; u->hid; u++) {
-		if (strcmp(u->hid, hid))
-			continue;
-		if (!u->uid)
-			return u->slot;
-		if (uid && !strcmp(u->uid, uid))
+		if (acpi_dev_hid_uid_match(adev, u->hid, u->uid))
 			return u->slot;
 	}
 	return NULL;
@@ -680,22 +668,17 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 	struct resource *iomem;
 	resource_size_t len;
 	size_t priv_size;
-	const char *hid;
-	const char *uid;
 	int err;
 
 	device = ACPI_COMPANION(dev);
 	if (!device)
 		return -ENODEV;
 
-	hid = acpi_device_hid(device);
-	uid = acpi_device_uid(device);
-
-	slot = sdhci_acpi_get_slot(hid, uid);
+	slot = sdhci_acpi_get_slot(device);
 
 	/* Power on the SDHCI controller and its children */
 	acpi_device_fix_up_power(device);
-	if (!sdhci_acpi_no_fixup_child_power(hid, uid)) {
+	if (!sdhci_acpi_no_fixup_child_power(device)) {
 		list_for_each_entry(child, &device->children, node)
 			if (child->status.present && child->status.enabled)
 				acpi_device_fix_up_power(child);
@@ -745,7 +728,7 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 
 	if (c->slot) {
 		if (c->slot->probe_slot) {
-			err = c->slot->probe_slot(pdev, hid, uid);
+			err = c->slot->probe_slot(pdev, device);
 			if (err)
 				goto err_free;
 		}
-- 
2.23.0

