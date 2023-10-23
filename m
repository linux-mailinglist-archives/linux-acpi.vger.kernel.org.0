Return-Path: <linux-acpi+bounces-832-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1645E7D2A70
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 08:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C19B328132F
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 06:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789246FB4
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 06:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RbrLhWum"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0BA4C7D
	for <linux-acpi@vger.kernel.org>; Mon, 23 Oct 2023 05:36:25 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7751DD5D;
	Sun, 22 Oct 2023 22:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698039384; x=1729575384;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=8Pmv3DZWM/2dbRrEDbbreAnJn6Hwwne5SAiYAHhbnP4=;
  b=RbrLhWumLqNBeINKT6dIjlbHg/BdSt1vYZ4DWu4WcaTmA9VvdEdgAuLx
   2EuLFgR8ygKo04BonKL3mjdRvsJub0zE+6RKQ4HJa8ryiYs+H7ltD7lMK
   A1K5ydILuOPNF3syF4Zy1yTY+ruC1w1BsWZtFXXAIwKWp8YVaGNR8Tkuo
   uv+eeA77ABi4l9JE5aFKGinBmG22cbOTX0ER+5pArLOQ+Y28xrxo4MNrl
   9MAk59AGRgyDnJCOaTRzLUw0jpbyWGR2+pH0wMiLx3DqZ1fj7s7xd+LVi
   c6JEIkbSpKctI6f/1hPKKxDE9pPmWbQDeEpXO7eSWv8p1Q9w8lywceXhA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="417905368"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="417905368"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 22:36:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="734556678"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="734556678"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orsmga006.jf.intel.com with ESMTP; 22 Oct 2023 22:35:59 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: rafael@kernel.org,
	len.brown@intel.com,
	robert.moore@intel.com,
	mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	mark.rutland@arm.com,
	will@kernel.org,
	linux@roeck-us.net,
	Jonathan.Cameron@Huawei.com
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linuxfoundation.org,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hwmon@vger.kernel.org,
	mallikarjunappa.sangannavar@intel.com,
	bala.senthil@intel.com,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2 1/6] ACPI: utils: Introduce acpi_dev_uid_match() for matching _UID
Date: Mon, 23 Oct 2023 11:05:25 +0530
Message-Id: <20231023053530.5525-2-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231023053530.5525-1-raag.jadav@intel.com>
References: <20231023053530.5525-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

Introduce acpi_dev_uid_match() helper that matches the device with
supplied _UID string.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/acpi/utils.c    | 31 +++++++++++++++++++++++++++----
 include/acpi/acpi_bus.h |  1 +
 include/linux/acpi.h    |  5 +++++
 3 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 79915d4a0031..be21b77059af 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -824,20 +824,43 @@ bool acpi_check_dsm(acpi_handle handle, const guid_t *guid, u64 rev, u64 funcs)
 }
 EXPORT_SYMBOL(acpi_check_dsm);
 
+/**
+ * acpi_dev_uid_match - Match device by supplied UID
+ * @adev: ACPI device to match.
+ * @uid2: Unique ID of the device.
+ *
+ * Matches UID in @adev with given @uid2.
+ *
+ * Returns:
+ *  - %true if matches.
+ *  - %false otherwise.
+ */
+bool acpi_dev_uid_match(struct acpi_device *adev, const char *uid2)
+{
+	const char *uid1 = acpi_device_uid(adev);
+
+	return uid1 && uid2 && !strcmp(uid1, uid2);
+}
+EXPORT_SYMBOL_GPL(acpi_dev_uid_match);
+
 /**
  * acpi_dev_hid_uid_match - Match device by supplied HID and UID
  * @adev: ACPI device to match.
  * @hid2: Hardware ID of the device.
  * @uid2: Unique ID of the device, pass NULL to not check _UID.
  *
- * Matches HID and UID in @adev with given @hid2 and @uid2.
- * Returns true if matches.
+ * Matches HID and UID in @adev with given @hid2 and @uid2. Absence of @uid2
+ * will be treated as a match. If user wants to validate @uid2, it should be
+ * done before calling this function.
+ *
+ * Returns:
+ *  - %true if matches or @uid2 is NULL.
+ *  - %false otherwise.
  */
 bool acpi_dev_hid_uid_match(struct acpi_device *adev,
 			    const char *hid2, const char *uid2)
 {
 	const char *hid1 = acpi_device_hid(adev);
-	const char *uid1 = acpi_device_uid(adev);
 
 	if (strcmp(hid1, hid2))
 		return false;
@@ -845,7 +868,7 @@ bool acpi_dev_hid_uid_match(struct acpi_device *adev,
 	if (!uid2)
 		return true;
 
-	return uid1 && !strcmp(uid1, uid2);
+	return acpi_dev_uid_match(adev, uid2);
 }
 EXPORT_SYMBOL(acpi_dev_hid_uid_match);
 
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 756b3f3c2c45..afeed6e72049 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -763,6 +763,7 @@ static inline bool acpi_device_can_poweroff(struct acpi_device *adev)
 		adev->power.states[ACPI_STATE_D3_HOT].flags.explicit_set);
 }
 
+bool acpi_dev_uid_match(struct acpi_device *adev, const char *uid2);
 bool acpi_dev_hid_uid_match(struct acpi_device *adev, const char *hid2, const char *uid2);
 int acpi_dev_uid_to_integer(struct acpi_device *adev, u64 *integer);
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index afd94c9b8b8a..db3a33e19c97 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -787,6 +787,11 @@ static inline bool acpi_dev_present(const char *hid, const char *uid, s64 hrv)
 
 struct acpi_device;
 
+static inline bool acpi_dev_uid_match(struct acpi_device *adev, const char *uid2)
+{
+	return false;
+}
+
 static inline bool
 acpi_dev_hid_uid_match(struct acpi_device *adev, const char *hid2, const char *uid2)
 {
-- 
2.17.1


