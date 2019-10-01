Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E495C373B
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Oct 2019 16:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388640AbfJAO1d (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Oct 2019 10:27:33 -0400
Received: from mga07.intel.com ([134.134.136.100]:64907 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388915AbfJAO1d (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 1 Oct 2019 10:27:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 07:27:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,571,1559545200"; 
   d="scan'208";a="392458208"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 01 Oct 2019 07:27:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 93DAC300; Tue,  1 Oct 2019 17:27:26 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 6/6] iommu/amd: Switch to use acpi_dev_hid_uid_match()
Date:   Tue,  1 Oct 2019 17:27:25 +0300
Message-Id: <20191001142725.30857-7-andriy.shevchenko@linux.intel.com>
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
 drivers/iommu/amd_iommu.c | 30 +++++-------------------------
 1 file changed, 5 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 2369b8af81f3..40f3cf44aa98 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -124,30 +124,6 @@ static struct lock_class_key reserved_rbtree_key;
  *
  ****************************************************************************/
 
-static inline int match_hid_uid(struct device *dev,
-				struct acpihid_map_entry *entry)
-{
-	struct acpi_device *adev = ACPI_COMPANION(dev);
-	const char *hid, *uid;
-
-	if (!adev)
-		return -ENODEV;
-
-	hid = acpi_device_hid(adev);
-	uid = acpi_device_uid(adev);
-
-	if (!hid || !(*hid))
-		return -ENODEV;
-
-	if (!uid || !(*uid))
-		return strcmp(hid, entry->hid);
-
-	if (!(*entry->uid))
-		return strcmp(hid, entry->hid);
-
-	return (strcmp(hid, entry->hid) || strcmp(uid, entry->uid));
-}
-
 static inline u16 get_pci_device_id(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
@@ -158,10 +134,14 @@ static inline u16 get_pci_device_id(struct device *dev)
 static inline int get_acpihid_device_id(struct device *dev,
 					struct acpihid_map_entry **entry)
 {
+	struct acpi_device *adev = ACPI_COMPANION(dev);
 	struct acpihid_map_entry *p;
 
+	if (!adev)
+		return -ENODEV;
+
 	list_for_each_entry(p, &acpihid_map, list) {
-		if (!match_hid_uid(dev, p)) {
+		if (acpi_dev_hid_uid_match(adev, p->hid, p->uid)) {
 			if (entry)
 				*entry = p;
 			return p->devid;
-- 
2.23.0

