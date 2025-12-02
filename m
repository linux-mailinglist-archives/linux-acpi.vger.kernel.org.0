Return-Path: <linux-acpi+bounces-19372-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 300B7C9A034
	for <lists+linux-acpi@lfdr.de>; Tue, 02 Dec 2025 05:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2CCC3A535F
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Dec 2025 04:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7AE292B2E;
	Tue,  2 Dec 2025 04:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="BkFw4aXK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB21E26E710;
	Tue,  2 Dec 2025 04:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764650176; cv=pass; b=VeVTTaF92DVNHUVE0nFcWta5OnsJuhbEDUXGHWRW1kGkN4DzN/9Z7cpzQOv081/FXjHUs7nsBnZC6DDQthRQQBPqJZOAgJpx0xkecNCSQ03AieaiXcQMcARvfg0fLZsYpXkgw/zIBqS4mt9TCgxWbD+Cy45TwF1UXqvaSq6pCC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764650176; c=relaxed/simple;
	bh=4wd8+KhkCFRbBhuBPcIlkyDZ2fItdnnpD9OTtyctxQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=exRoWYQpJuGlG39H9AMocPWLDg2rim75cOWYagfDyHOYdAmgAL+sTKgiE5BSFED0dP18iYwkLmc3wxVQIvI6uiQnRhEZUb1+h1tltGFIuJ3E4sdgHuPuM8qAuDXcd+nNRlcS8pQy9363DXTWyLYqLdL7eugqLNT9DSOZ+j/FdDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=BkFw4aXK; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1764650148; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=H5jrg0eYrmAkFlpjFQBTe3sbYPaBD5JNy5Y4WPgHoiZmbx6mtFWCnxiib1CGAJ0CbIwi8C/tG6f/rZcnQUfVkM13jFSNmWi5tlx6gsyDQTSZyr4EZCTx4+OKDjhj53BFqj6I+wt9niAGtHXLKpRHwUD+lDlb4JPP4bigDOLJBgk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1764650148; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xgcSSJVn4R0t7VuhB7JeoWNb1R8DZ3L0+c7OtCkeNbs=; 
	b=mWjfh1jtd9ykuYahLZLq2HOkQ5I9zBJM76sy63NuNzINimZXCuI3Yp1BgoUSIcMwA0WWS6wwJdlh3oml74nM5r/ZTdv8zJbHw/R7Ti7iwINKKx2PIKdBMx26HcPOGgTuVka/yhfDhIXc+RtO8Wn8Ng3s43Swze66v7yQv+3q7fg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764650148;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=xgcSSJVn4R0t7VuhB7JeoWNb1R8DZ3L0+c7OtCkeNbs=;
	b=BkFw4aXKsfyTgDCJLvZM7kEGOcCXiOttiqJ/om1NyGupahtzClqQKMf661+FNWgF
	ofKHd0j6xL4kTfYaIxjTkv3hZzRevoX8hMb+VX8PVsh3ro4AJo1VHX8mzlbv68VHOTC
	HFV3NNHGx31v2E6eWW7z3S/ttxg0uOFI10UjN76A=
Received: by mx.zohomail.com with SMTPS id 17646501461601022.3476712878679;
	Mon, 1 Dec 2025 20:35:46 -0800 (PST)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Mario Limonciello <superm1@kernel.org>,
	Robert Beckett <bob.beckett@collabora.com>
Cc: linux-acpi@vger.kernel.org,
	kernel@collabora.com,
	linux-kernel@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Xaver Hugl <xaver.hugl@gmail.com>,
	Richard Hughes <richard@hughsie.com>,
	William Jon McCann <mccann@jhu.edu>,
	"Jaap A . Haitsma" <jaap@haitsma.org>,
	Benjamin Canou <bookeldor@gmail.com>,
	Bastien Nocera <hadess@hadess.net>,
	systemd-devel@lists.freedesktop.org,
	Lennart Poettering <lennart@poettering.net>,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [RFC PATCH v1 1/1] ACPI: PM: s2idle: Add lps0_screen_off sysfs interface
Date: Tue,  2 Dec 2025 07:34:16 +0300
Message-ID: <20251202043416.2310677-2-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251202043416.2310677-1-dmitry.osipenko@collabora.com>
References: <20251202043416.2310677-1-dmitry.osipenko@collabora.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Add `/sys/power/lps0_screen_off` interface to allow userspace to control
Display OFF/ON DSM notifications at runtime. Writing "1" to this file
triggers the OFF notification, and "0" triggers the ON notification.

Userspace should write "1" after turning off all physical and remote
displays. It should write "0" before turning on any of displays.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 Documentation/ABI/testing/sysfs-power |  13 +++
 drivers/acpi/x86/s2idle.c             | 149 +++++++++++++++++++++++---
 2 files changed, 145 insertions(+), 17 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
index d38da077905a..af7c81ae517c 100644
--- a/Documentation/ABI/testing/sysfs-power
+++ b/Documentation/ABI/testing/sysfs-power
@@ -470,3 +470,16 @@ Description:
 
                 Minimum value: 1
                 Default value: 3
+
+What:		/sys/power/lps0_screen_off
+Date:		November 2025
+Contact:	Dmitrii Osipenko <dmitry.osipenko@collabora.com>
+Description:
+		This file is available if the ACPI/OSPM system supports
+		Display Off/On DSM notifications. It controls state of the
+		notification.
+
+		Writing a "1" to this file invokes Display Off Notification.
+		Writing a "0" to this file invokes Display On Notification.
+
+		Notifications are only triggered on state transitions.
diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 6d4d06236f61..d5cb5e22431d 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -18,7 +18,10 @@
 #include <linux/acpi.h>
 #include <linux/device.h>
 #include <linux/dmi.h>
+#include <linux/kobject.h>
+#include <linux/mutex.h>
 #include <linux/suspend.h>
+#include <linux/sysfs.h>
 
 #include "../sleep.h"
 
@@ -61,6 +64,11 @@ static guid_t lps0_dsm_guid_microsoft;
 static int lps0_dsm_func_mask_microsoft;
 static int lps0_dsm_state;
 
+static DEFINE_MUTEX(lps0_dsm_screen_off_lock);
+static bool lps0_dsm_screen_state_off;
+static bool lps0_screen_off_suspended;
+static bool lps0_screen_off_sysfs_inhibit;
+
 /* Device constraint entry structure */
 struct lpi_device_info {
 	char *name;
@@ -513,6 +521,76 @@ static struct acpi_scan_handler lps0_handler = {
 	.attach = lps0_device_attach,
 };
 
+static bool lps0_has_screen_off_dsm(void)
+{
+	int id = acpi_s2idle_vendor_amd() ?
+		 ACPI_LPS0_SCREEN_ON_AMD : ACPI_LPS0_SCREEN_OFF;
+
+	if (lps0_dsm_func_mask_microsoft > 0 &&
+	    (lps0_dsm_func_mask & BIT(ACPI_LPS0_SCREEN_OFF)))
+		return true;
+
+	if (lps0_dsm_func_mask > 0 && (lps0_dsm_func_mask & BIT(id)))
+		return true;
+
+	return false;
+}
+
+static void lps0_dsm_screen_off(void)
+{
+	if (lps0_dsm_screen_state_off)
+		return;
+
+	if (lps0_dsm_func_mask > 0)
+		acpi_sleep_run_lps0_dsm(acpi_s2idle_vendor_amd() ?
+					ACPI_LPS0_SCREEN_OFF_AMD :
+					ACPI_LPS0_SCREEN_OFF,
+					lps0_dsm_func_mask, lps0_dsm_guid);
+
+	if (lps0_dsm_func_mask_microsoft > 0)
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF,
+					lps0_dsm_func_mask_microsoft,
+					lps0_dsm_guid_microsoft);
+
+	lps0_dsm_screen_state_off = true;
+}
+
+static void lps0_dsm_screen_on(void)
+{
+	if (!lps0_dsm_screen_state_off)
+		return;
+
+	if (lps0_dsm_func_mask_microsoft > 0)
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON,
+					lps0_dsm_func_mask_microsoft,
+					lps0_dsm_guid_microsoft);
+
+	if (lps0_dsm_func_mask > 0)
+		acpi_sleep_run_lps0_dsm(acpi_s2idle_vendor_amd() ?
+					ACPI_LPS0_SCREEN_ON_AMD :
+					ACPI_LPS0_SCREEN_ON,
+					lps0_dsm_func_mask, lps0_dsm_guid);
+
+	lps0_dsm_screen_state_off = false;
+}
+
+static void lps0_dsm_screen_off_set(int sysfs_off, int suspended)
+{
+	mutex_lock(&lps0_dsm_screen_off_lock);
+
+	if (sysfs_off > -1)
+		lps0_screen_off_sysfs_inhibit = sysfs_off;
+	if (suspended > -1)
+		lps0_screen_off_suspended = suspended;
+
+	if (lps0_screen_off_suspended || lps0_screen_off_sysfs_inhibit)
+		lps0_dsm_screen_off();
+	else
+		lps0_dsm_screen_on();
+
+	mutex_unlock(&lps0_dsm_screen_off_lock);
+}
+
 static int acpi_s2idle_begin_lps0(void)
 {
 	if (pm_debug_messages_on && !lpi_constraints_table) {
@@ -543,15 +621,7 @@ static int acpi_s2idle_prepare_late_lps0(void)
 		lpi_check_constraints();
 
 	/* Screen off */
-	if (lps0_dsm_func_mask > 0)
-		acpi_sleep_run_lps0_dsm(acpi_s2idle_vendor_amd() ?
-					ACPI_LPS0_SCREEN_OFF_AMD :
-					ACPI_LPS0_SCREEN_OFF,
-					lps0_dsm_func_mask, lps0_dsm_guid);
-
-	if (lps0_dsm_func_mask_microsoft > 0)
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF,
-				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
+	lps0_dsm_screen_off_set(-1, true);
 
 	/* LPS0 entry */
 	if (lps0_dsm_func_mask > 0 && acpi_s2idle_vendor_amd())
@@ -618,14 +688,7 @@ static void acpi_s2idle_restore_early_lps0(void)
 	}
 
 	/* Screen on */
-	if (lps0_dsm_func_mask_microsoft > 0)
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON,
-				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
-	if (lps0_dsm_func_mask > 0)
-		acpi_sleep_run_lps0_dsm(acpi_s2idle_vendor_amd() ?
-					ACPI_LPS0_SCREEN_ON_AMD :
-					ACPI_LPS0_SCREEN_ON,
-					lps0_dsm_func_mask, lps0_dsm_guid);
+	lps0_dsm_screen_off_set(-1, false);
 }
 
 static const struct platform_s2idle_ops acpi_s2idle_ops_lps0 = {
@@ -673,4 +736,56 @@ void acpi_unregister_lps0_dev(struct acpi_s2idle_dev_ops *arg)
 }
 EXPORT_SYMBOL_GPL(acpi_unregister_lps0_dev);
 
+static ssize_t lps0_screen_off_store(struct kobject *kobj,
+				     struct kobj_attribute *attr,
+				     const char *buf, size_t count)
+{
+	unsigned long val;
+
+	if (kstrtoul(buf, 10, &val))
+		return -EINVAL;
+
+	if (val > 1)
+		return -EINVAL;
+
+	lps0_dsm_screen_off_set(val, -1);
+
+	return count;
+}
+
+static ssize_t lps0_screen_off_show(struct kobject *kobj,
+				    struct kobj_attribute *attr,
+				    char *buf)
+{
+	return sprintf(buf, "%d\n", lps0_screen_off_sysfs_inhibit);
+}
+
+static struct kobj_attribute lps0_screen_off_attr =
+	__ATTR(lps0_screen_off, 0644,
+	       lps0_screen_off_show, lps0_screen_off_store);
+
+static struct attribute *lps0_screen_off_attrs[] = {
+	&lps0_screen_off_attr.attr,
+	NULL,
+};
+
+static struct attribute_group lps0_screen_off_attr_group = {
+	.attrs = lps0_screen_off_attrs,
+};
+
+static int lps0_dsm_screen_off_init(void)
+{
+	int ret;
+
+	if (!lps0_has_screen_off_dsm())
+		return 0;
+
+	ret = sysfs_create_group(power_kobj, &lps0_screen_off_attr_group);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+late_initcall(lps0_dsm_screen_off_init);
+
 #endif /* CONFIG_SUSPEND */
-- 
2.51.1


