Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8A44BD2D3
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Sep 2019 21:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731131AbfIXTht (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 24 Sep 2019 15:37:49 -0400
Received: from mga07.intel.com ([134.134.136.100]:23259 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730848AbfIXThq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 24 Sep 2019 15:37:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2019 12:37:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,545,1559545200"; 
   d="scan'208";a="213800081"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 24 Sep 2019 12:37:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CEA331A1; Tue, 24 Sep 2019 22:37:42 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 3/6] ACPI / utils: Introduce acpi_dev_hid_uid_match() helper
Date:   Tue, 24 Sep 2019 22:37:36 +0300
Message-Id: <20190924193739.86133-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190924193739.86133-1-andriy.shevchenko@linux.intel.com>
References: <20190924193739.86133-1-andriy.shevchenko@linux.intel.com>
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
 include/acpi/acpi_bus.h |  2 ++
 include/linux/acpi.h    |  6 ++++++
 3 files changed, 33 insertions(+)

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
index 3f6fddeb7519..0c23fd0548d1 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -680,6 +680,8 @@ static inline bool acpi_device_can_poweroff(struct acpi_device *adev)
 		adev->power.states[ACPI_STATE_D3_HOT].flags.explicit_set);
 }
 
+bool acpi_dev_hid_uid_match(struct acpi_device *adev, const char *hid2, const char *uid2);
+
 struct acpi_device *
 acpi_dev_get_first_match_dev(const char *hid, const char *uid, s64 hrv);
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 9426b9aaed86..34778e4757fd 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -672,6 +672,12 @@ static inline bool acpi_dev_present(const char *hid, const char *uid, s64 hrv)
 	return false;
 }
 
+static inline bool
+acpi_dev_hid_uid_match(struct acpi_device *adev, const char *hid2, const char *uid2)
+{
+	return false;
+}
+
 static inline struct acpi_device *
 acpi_dev_get_first_match_dev(const char *hid, const char *uid, s64 hrv)
 {
-- 
2.23.0

