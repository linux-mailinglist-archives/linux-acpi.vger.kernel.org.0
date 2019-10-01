Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4688C3738
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Oct 2019 16:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388689AbfJAO1b (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Oct 2019 10:27:31 -0400
Received: from mga04.intel.com ([192.55.52.120]:61215 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727149AbfJAO1a (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 1 Oct 2019 10:27:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 07:27:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,571,1559545200"; 
   d="scan'208";a="181706098"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 01 Oct 2019 07:27:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 84204234; Tue,  1 Oct 2019 17:27:26 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 4/6] ACPI / LPSS: Switch to use acpi_dev_hid_uid_match()
Date:   Tue,  1 Oct 2019 17:27:23 +0300
Message-Id: <20191001142725.30857-5-andriy.shevchenko@linux.intel.com>
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
 drivers/acpi/acpi_lpss.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 60bbc5090abe..1e520ea16042 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -478,31 +478,16 @@ static const struct lpss_device_links lpss_device_links[] = {
 	{"80860F41", "5", "LNXVIDEO", NULL, DL_FLAG_PM_RUNTIME},
 };
 
-static bool hid_uid_match(struct acpi_device *adev,
-			  const char *hid2, const char *uid2)
-{
-	const char *hid1 = acpi_device_hid(adev);
-	const char *uid1 = acpi_device_uid(adev);
-
-	if (strcmp(hid1, hid2))
-		return false;
-
-	if (!uid2)
-		return true;
-
-	return uid1 && !strcmp(uid1, uid2);
-}
-
 static bool acpi_lpss_is_supplier(struct acpi_device *adev,
 				  const struct lpss_device_links *link)
 {
-	return hid_uid_match(adev, link->supplier_hid, link->supplier_uid);
+	return acpi_dev_hid_uid_match(adev, link->supplier_hid, link->supplier_uid);
 }
 
 static bool acpi_lpss_is_consumer(struct acpi_device *adev,
 				  const struct lpss_device_links *link)
 {
-	return hid_uid_match(adev, link->consumer_hid, link->consumer_uid);
+	return acpi_dev_hid_uid_match(adev, link->consumer_hid, link->consumer_uid);
 }
 
 struct hid_uid {
@@ -518,7 +503,7 @@ static int match_hid_uid(struct device *dev, const void *data)
 	if (!adev)
 		return 0;
 
-	return hid_uid_match(adev, id->hid, id->uid);
+	return acpi_dev_hid_uid_match(adev, id->hid, id->uid);
 }
 
 static struct device *acpi_lpss_find_device(const char *hid, const char *uid)
-- 
2.23.0

