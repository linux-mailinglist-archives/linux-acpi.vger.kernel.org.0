Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2899BC76A
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Sep 2019 14:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504817AbfIXMB6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 24 Sep 2019 08:01:58 -0400
Received: from mga05.intel.com ([192.55.52.43]:60527 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504802AbfIXMB6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 24 Sep 2019 08:01:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2019 05:01:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,544,1559545200"; 
   d="scan'208";a="182892414"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 24 Sep 2019 05:01:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4CE9596; Tue, 24 Sep 2019 15:01:54 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/5] ACPI / utils: Introduce acpi_dev_hid_uid_match() helper
Date:   Tue, 24 Sep 2019 15:01:50 +0300
Message-Id: <20190924120153.8382-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190924120153.8382-1-andriy.shevchenko@linux.intel.com>
References: <20190924120153.8382-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

There are users outside of ACPI realm which reimplementing the comparator
function to check if the given device matches to given HID and UID.

For better utilization, introduce a helper for everyone to use.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/utils.c    | 25 +++++++++++++++++++++++++
 include/acpi/acpi_bus.h |  3 +++
 include/linux/acpi.h    |  6 ++++++
 3 files changed, 34 insertions(+)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index dbd1c4cfd7d1..804ac0df58ec 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -701,6 +701,31 @@ bool acpi_check_dsm(acpi_handle handle, const guid_t *guid, u64 rev, u64 funcs)
 }
 EXPORT_SYMBOL(acpi_check_dsm);
 
+/**
+ * acpi_dev_hid_uid_match - Match device by supplied HID and UID
+ * @adev: ACPI device to match.
+ * @hid2: Hardware ID of the device.
+ * @uid2: Unique ID of the device, pass NULL to not check _UID.
+ *
+ * Matches HID and UID in @adev with given @hid2 and @uid2.
+ * Returns true if matches.
+ */
+bool acpi_dev_hid_uid_match(struct acpi_device *adev,
+			    const char *hid2, const char *uid2)
+{
+	const char *hid1 = acpi_device_hid(adev);
+	const char *uid1 = acpi_device_uid(adev);
+
+	if (strcmp(hid1, hid2))
+		return false;
+
+	if (!uid2)
+		return true;
+
+	return uid1 && !strcmp(uid1, uid2);
+}
+EXPORT_SYMBOL(acpi_dev_hid_uid_match);
+
 /**
  * acpi_dev_found - Detect presence of a given ACPI device in the namespace.
  * @hid: Hardware ID of the device.
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 175f7b40c585..d3cc8a786065 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -75,6 +75,9 @@ acpi_evaluate_dsm_typed(acpi_handle handle, const guid_t *guid, u64 rev,
 	  .package.elements = (eles)			\
 	}
 
+bool acpi_dev_hid_uid_match(struct acpi_device *adev,
+			    const char *hid2, const char *uid2);
+
 bool acpi_dev_found(const char *hid);
 bool acpi_dev_present(const char *hid, const char *uid, s64 hrv);
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 9426b9aaed86..272b51a4f385 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -662,6 +662,12 @@ static inline u64 acpi_arch_get_root_pointer(void)
 
 struct fwnode_handle;
 
+static inline bool acpi_dev_hid_uid_match(struct acpi_device *adev,
+					  const char *hid2, const char *uid2)
+{
+	return false;
+}
+
 static inline bool acpi_dev_found(const char *hid)
 {
 	return false;
-- 
2.23.0

