Return-Path: <linux-acpi+bounces-11559-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 212C6A48315
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 16:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA2323A99B1
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 15:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0698B26B956;
	Thu, 27 Feb 2025 15:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="x7gAjO3b"
X-Original-To: linux-acpi@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAF42356AE;
	Thu, 27 Feb 2025 15:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740670572; cv=none; b=hbUv6t4VRO3SaLlfPBrPUzrE/HfZvDdSbAEfwUZq+Z9XcW4UWgJgMqF4KCghkg3MEzE23dFrI9udEG3HztvX2D5PAfAYysmA/r6oEDEABDJj/ov9O7SY9w+fTBuYkKXa+1cWb8scgvyn+NBP6t0ldQHRtm/R0cwPeINNuaHYTKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740670572; c=relaxed/simple;
	bh=N1g/xOjMk7teaJFqdCqZo85/5P+OvKpR7kGgk3bDvmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O7b4Wcu4fQRBumq0y79IEo4kYTxKVQIN2ka1FxEA1oxtTDaBwJfJPTDltrRTD3a8oE7/a2b5hA5nrGEfzntO3C/9FdS8dfKJRYhSy0BZwJQDv+bN+4lRy4tqKjIusa+PKAqb+2bL1pW35i0eCDaLSyfgkTDTJ8rc1IDt3a4RAuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=x7gAjO3b; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:8d8a:5967:d692:ea4e])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 8D11C2E08EB4;
	Thu, 27 Feb 2025 17:36:06 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1740670567;
	bh=tTANKw9JSXLoAQsvy6j2XrIf6M0EziwO513JKFkwGrg=; h=From:To:Subject;
	b=x7gAjO3b8YItU/IwqzT0ctpkWZjXw+T7C+u5ai+Igu2+5Ozhmy2LU4cUv+gZ1Cgz+
	 2wLWRJbhUYvMldBYl4S8Gvdkt37i3nUXNxsY9rNafsMV82BhJn4XSzmPuCNW6pYJv9
	 DjxsFkt1R2RyybUyFhleul5qet7HgK8sewy4IpI8=
Authentication-Results: linux1587.grserver.gr;
	spf=pass (sender IP is 2a05:f6c2:511b:0:8d8a:5967:d692:ea4e) smtp.mailfrom=lkml@antheas.dev smtp.helo=localhost.localdomain
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: mario.limonciello@amd.com,
	mpearson-lenovo@squebb.ca
Cc: ilpo.jarvinen@linux.intel.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	rafael@kernel.org,
	hdegoede@redhat.com,
	me@kylegospodneti.ch,
	luke@ljones.dev,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v2 1/2] ACPI: platform_profile: Add handlers that do not
 occlude power options
Date: Thu, 27 Feb 2025 16:36:02 +0100
Message-ID: <20250227153603.131046-2-lkml@antheas.dev>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227153603.131046-1-lkml@antheas.dev>
References: <20250227153603.131046-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <174067056771.31651.319648231233912872@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Currently, only the subset of supported profiles are exposed when
using platform profile. This is a big problem when e.g., asus-wmi
and amd-pmf are loaded together, as they have conflicting low
power options. This causes ppd and tuned to miss the low power
option increasing power consumption. In 2025, this is only expected
to increase, as more laptops ship with amd-pmf notifiers and this
starts to become an issue in more manufacturers.

Therefore, this commit introduces the concept of secondary handlers.
These are handlers that are able to accept all options and do not
partake in the process of selecting which profiles are visible.

These handlers still have a probe function which is used for their
endpoint and their endpoint works normally and will block other
options. However, when called from the legacy endpoint, all options
will be sent to them. It is the expectation that secondary handlers
will pick the closest profile they have to what was sent.

In the absence of a primary handler, the options shown in the legacy
endpoint will be the union of all options of all secondary handlers.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/acpi/platform_profile.c  | 57 +++++++++++++++++++++++++++-----
 include/linux/platform_profile.h |  5 +++
 2 files changed, 54 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 2ad53cc6aae5..55e8bb6adf8e 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -63,17 +63,18 @@ static ssize_t _commmon_choices_show(unsigned long *choices, char *buf)
  * _store_class_profile - Set the profile for a class device
  * @dev: The class device
  * @data: The profile to set
+ * @enforce_valid: For secondary handlers, enforce that the profile is valid
  *
  * Return: 0 on success, -errno on failure
  */
-static int _store_class_profile(struct device *dev, void *data)
+static int _store_class_profile(struct device *dev, void *data, bool enforce_valid)
 {
 	struct platform_profile_handler *handler;
 	int *bit = (int *)data;
 
 	lockdep_assert_held(&profile_lock);
 	handler = to_pprof_handler(dev);
-	if (!test_bit(*bit, handler->choices))
+	if ((enforce_valid || !handler->ops->secondary) && !test_bit(*bit, handler->choices))
 		return -EOPNOTSUPP;
 
 	return handler->ops->profile_set(dev, *bit);
@@ -204,7 +205,7 @@ static ssize_t profile_store(struct device *dev,
 		return -EINVAL;
 
 	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
-		ret = _store_class_profile(dev, &index);
+		ret = _store_class_profile(dev, &index, true);
 		if (ret)
 			return ret;
 	}
@@ -243,21 +244,37 @@ static const struct class platform_profile_class = {
  *
  * Return: 0 on success, -errno on failure
  */
-static int _aggregate_choices(struct device *dev, void *data)
+static int _aggregate_choices(struct device *dev, void *data, bool secondary)
 {
 	struct platform_profile_handler *handler;
 	unsigned long *aggregate = data;
 
 	lockdep_assert_held(&profile_lock);
 	handler = to_pprof_handler(dev);
+
+	if (handler->ops->secondary != secondary)
+		return 0;
+
 	if (test_bit(PLATFORM_PROFILE_LAST, aggregate))
 		bitmap_copy(aggregate, handler->choices, PLATFORM_PROFILE_LAST);
+	else if (handler->ops->secondary)
+		bitmap_or(aggregate, handler->choices, aggregate, PLATFORM_PROFILE_LAST);
 	else
 		bitmap_and(aggregate, handler->choices, aggregate, PLATFORM_PROFILE_LAST);
 
 	return 0;
 }
 
+static int _aggregate_choices_primary(struct device *dev, void *data)
+{
+	return _aggregate_choices(dev, data, false);
+}
+
+static int _aggregate_choices_secondary(struct device *dev, void *data)
+{
+	return _aggregate_choices(dev, data, true);
+}
+
 /**
  * platform_profile_choices_show - Show the available profile choices for legacy sysfs interface
  * @dev: The device
@@ -276,9 +293,16 @@ static ssize_t platform_profile_choices_show(struct device *dev,
 	set_bit(PLATFORM_PROFILE_LAST, aggregate);
 	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
 		err = class_for_each_device(&platform_profile_class, NULL,
-					    aggregate, _aggregate_choices);
+					    aggregate, _aggregate_choices_primary);
 		if (err)
 			return err;
+
+		if (test_bit(PLATFORM_PROFILE_LAST, aggregate)) {
+			err = class_for_each_device(&platform_profile_class, NULL,
+							aggregate, _aggregate_choices_secondary);
+			if (err)
+				return err;
+		}
 	}
 
 	/* no profile handler registered any more */
@@ -325,7 +349,7 @@ static int _store_and_notify(struct device *dev, void *data)
 	enum platform_profile_option *profile = data;
 	int err;
 
-	err = _store_class_profile(dev, profile);
+	err = _store_class_profile(dev, profile, false);
 	if (err)
 		return err;
 	return _notify_class_profile(dev, NULL);
@@ -384,9 +408,18 @@ static ssize_t platform_profile_store(struct device *dev,
 	set_bit(PLATFORM_PROFILE_LAST, choices);
 	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
 		ret = class_for_each_device(&platform_profile_class, NULL,
-					    choices, _aggregate_choices);
+					    choices, _aggregate_choices_primary);
 		if (ret)
 			return ret;
+
+		if (test_bit(PLATFORM_PROFILE_LAST, choices)) {
+			ret = class_for_each_device(
+				&platform_profile_class, NULL, choices,
+				_aggregate_choices_secondary);
+			if (ret)
+				return ret;
+		}
+
 		if (!test_bit(i, choices))
 			return -EOPNOTSUPP;
 
@@ -470,10 +503,18 @@ int platform_profile_cycle(void)
 			return -EINVAL;
 
 		err = class_for_each_device(&platform_profile_class, NULL,
-					    choices, _aggregate_choices);
+					    choices, _aggregate_choices_primary);
 		if (err)
 			return err;
 
+		if (test_bit(PLATFORM_PROFILE_LAST, choices)) {
+			err = class_for_each_device(
+				&platform_profile_class, NULL, choices,
+				_aggregate_choices_secondary);
+			if (err)
+				return err;
+		}
+
 		/* never iterate into a custom if all drivers supported it */
 		clear_bit(PLATFORM_PROFILE_CUSTOM, choices);
 
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index 8ab5b0e8eb2c..3593d3311a89 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -37,11 +37,16 @@ enum platform_profile_option {
  *		 profile in sysfs.
  * @profile_set: Callback that will be called when storing a new platform
  *		 profile in sysfs.
+ * @secondary: Set the platform handler as a secondary. Secondary handlers
+ *		 accept all profile options and are not considered in choosing
+ *		 which options to show under the legacy sysfs. This way, they do
+ *		 not occlude the primary handler's choices.
  */
 struct platform_profile_ops {
 	int (*probe)(void *drvdata, unsigned long *choices);
 	int (*profile_get)(struct device *dev, enum platform_profile_option *profile);
 	int (*profile_set)(struct device *dev, enum platform_profile_option profile);
+	bool secondary;
 };
 
 struct device *platform_profile_register(struct device *dev, const char *name,
-- 
2.48.1


