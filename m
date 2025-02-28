Return-Path: <linux-acpi+bounces-11635-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C96A49FAA
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Feb 2025 18:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B19553A96BA
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Feb 2025 17:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366F626FDB1;
	Fri, 28 Feb 2025 17:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gL9ylTNF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACA01EF39D;
	Fri, 28 Feb 2025 17:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740762124; cv=none; b=CEwTIksXJYU/ZW4hSo8TITs6EKPjQcynX2TcTAdBW5ERFJT1Xdzqp26lJC8733/DaapEQ78LbjIELrQqXm0z0AmiurssojZYDUSN21pJxXGd0AqolVzFMQL5xjgw2Fgbryo34nstJW+mh4lzYTe2wgcBEGABt3qvP9Ca44xqskk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740762124; c=relaxed/simple;
	bh=9+iYkt+wJ6197jyeEJG0eHiJ/ej1i8To+qwrM5HYKuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sw8NOKPhhTZSmu0thNAQCrAc/ZCtxGnfcH63z/SRjlV546QgYj6eS0mK8LFpNEl6YD/eR472Yr4UodQGQUy3s/3s0c9MafNlmiwvMOw/p5muQZcGj5/7wb1k1qWeVcdlCqdPz8FtoiFPTBVDT8sdrP+gqW/xl+Xi12GzkdauM7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gL9ylTNF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A37EC4CEE8;
	Fri, 28 Feb 2025 17:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740762123;
	bh=9+iYkt+wJ6197jyeEJG0eHiJ/ej1i8To+qwrM5HYKuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gL9ylTNFvemu+jZb69XgAEHa0+0588j88XdIgb61pK9Lq/jCJdZSDRTfnl6k276WT
	 MYsy+eDESsh2XvQhFQ69kn/VkUCSycvHF4nmkac1NDA6NJPH+ZPmCfiJhI7FM+7x/M
	 MY2fdLWMgMjxvArifv6slvqClRyDiKTIiIIOj+ERwxVYDoCtTN9X25jiyfV/MC1NHB
	 oU3KKVyoMReBdLlDN8cwBg/e+96BdmZEElcWImP79EqYgiizj9gzMhqc65j/w5Aq7e
	 C3zrS0gKfVM3f2XfyzDwI+FGPN1X5/zmSH1N5rq8GkwT+NcRC0pqhC54PWKbiDNAf2
	 j2NEGTliR3DrQ==
From: Mario Limonciello <superm1@kernel.org>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Luke D . Jones" <luke@ljones.dev>,
	Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: platform-driver-x86@vger.kernel.org (open list:AMD PMF DRIVER),
	linux-kernel@vger.kernel.org (open list),
	linux-acpi@vger.kernel.org (open list:ACPI),
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	Antheas Kapenekakis <lkml@antheas.dev>,
	me@kylegospodneti.ch,
	Denis Benato <benato.denis96@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 1/3] ACPI: platform_profile: Add support for hidden choices
Date: Fri, 28 Feb 2025 11:01:53 -0600
Message-ID: <20250228170155.2623386-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250228170155.2623386-1-superm1@kernel.org>
References: <20250228170155.2623386-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

When two drivers don't support all the same profiles the legacy interface
only exports the common profiles.

This causes problems for cases where one driver uses low-power but another
uses quiet because the result is that neither is exported to sysfs.

To allow two drivers to disagree, add support for "hidden choices".
Hidden choices are platform profiles that a driver supports to be
compatible with the platform profile of another driver.

Fixes: 688834743d67 ("ACPI: platform_profile: Allow multiple handlers")
Reported-by: Antheas Kapenekakis <lkml@antheas.dev>
Closes: https://lore.kernel.org/platform-driver-x86/e64b771e-3255-42ad-9257-5b8fc6c24ac9@gmx.de/T/#mc068042dd29df36c16c8af92664860fc4763974b
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Cc: "Luke D. Jones" <luke@ljones.dev>
 drivers/acpi/platform_profile.c  | 94 +++++++++++++++++++++++++-------
 include/linux/platform_profile.h |  3 +
 2 files changed, 76 insertions(+), 21 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 2ad53cc6aae53..ef9444482db19 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -21,9 +21,15 @@ struct platform_profile_handler {
 	struct device dev;
 	int minor;
 	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
+	unsigned long hidden_choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
 	const struct platform_profile_ops *ops;
 };
 
+struct aggregate_choices_data {
+	unsigned long aggregate[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
+	int count;
+};
+
 static const char * const profile_names[] = {
 	[PLATFORM_PROFILE_LOW_POWER] = "low-power",
 	[PLATFORM_PROFILE_COOL] = "cool",
@@ -73,7 +79,7 @@ static int _store_class_profile(struct device *dev, void *data)
 
 	lockdep_assert_held(&profile_lock);
 	handler = to_pprof_handler(dev);
-	if (!test_bit(*bit, handler->choices))
+	if (!test_bit(*bit, handler->choices) && !test_bit(*bit, handler->hidden_choices))
 		return -EOPNOTSUPP;
 
 	return handler->ops->profile_set(dev, *bit);
@@ -239,21 +245,44 @@ static const struct class platform_profile_class = {
 /**
  * _aggregate_choices - Aggregate the available profile choices
  * @dev: The device
- * @data: The available profile choices
+ * @arg: struct aggregate_choices_data
  *
  * Return: 0 on success, -errno on failure
  */
-static int _aggregate_choices(struct device *dev, void *data)
+static int _aggregate_choices(struct device *dev, void *arg)
 {
+	unsigned long tmp[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
+	struct aggregate_choices_data *data = arg;
 	struct platform_profile_handler *handler;
-	unsigned long *aggregate = data;
 
 	lockdep_assert_held(&profile_lock);
 	handler = to_pprof_handler(dev);
-	if (test_bit(PLATFORM_PROFILE_LAST, aggregate))
-		bitmap_copy(aggregate, handler->choices, PLATFORM_PROFILE_LAST);
+	bitmap_or(tmp, handler->choices, handler->hidden_choices, PLATFORM_PROFILE_LAST);
+	if (test_bit(PLATFORM_PROFILE_LAST, data->aggregate))
+		bitmap_copy(data->aggregate, tmp, PLATFORM_PROFILE_LAST);
 	else
-		bitmap_and(aggregate, handler->choices, aggregate, PLATFORM_PROFILE_LAST);
+		bitmap_and(data->aggregate, tmp, data->aggregate, PLATFORM_PROFILE_LAST);
+	data->count++;
+
+	return 0;
+}
+
+/**
+ * _remove_hidden_choices - Remove hidden choices from aggregate data
+ * @dev: The device
+ * @arg: struct aggregate_choices_data
+ *
+ * Return: 0 on success, -errno on failure
+ */
+static int _remove_hidden_choices(struct device *dev, void *arg)
+{
+	struct aggregate_choices_data *data = arg;
+	struct platform_profile_handler *handler;
+
+	lockdep_assert_held(&profile_lock);
+	handler = to_pprof_handler(dev);
+	bitmap_andnot(data->aggregate, handler->choices,
+		      handler->hidden_choices, PLATFORM_PROFILE_LAST);
 
 	return 0;
 }
@@ -270,22 +299,31 @@ static ssize_t platform_profile_choices_show(struct device *dev,
 					     struct device_attribute *attr,
 					     char *buf)
 {
-	unsigned long aggregate[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
+	struct aggregate_choices_data data = {
+		.aggregate = { [0 ... BITS_TO_LONGS(PLATFORM_PROFILE_LAST) - 1] = ~0UL },
+		.count = 0,
+	};
 	int err;
 
-	set_bit(PLATFORM_PROFILE_LAST, aggregate);
+	set_bit(PLATFORM_PROFILE_LAST, data.aggregate);
 	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
 		err = class_for_each_device(&platform_profile_class, NULL,
-					    aggregate, _aggregate_choices);
+					    &data, _aggregate_choices);
 		if (err)
 			return err;
+		if (data.count == 1) {
+			err = class_for_each_device(&platform_profile_class, NULL,
+						    &data, _remove_hidden_choices);
+			if (err)
+				return err;
+		}
 	}
 
 	/* no profile handler registered any more */
-	if (bitmap_empty(aggregate, PLATFORM_PROFILE_LAST))
+	if (bitmap_empty(data.aggregate, PLATFORM_PROFILE_LAST))
 		return -EINVAL;
 
-	return _commmon_choices_show(aggregate, buf);
+	return _commmon_choices_show(data.aggregate, buf);
 }
 
 /**
@@ -373,7 +411,10 @@ static ssize_t platform_profile_store(struct device *dev,
 				      struct device_attribute *attr,
 				      const char *buf, size_t count)
 {
-	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
+	struct aggregate_choices_data data = {
+		.aggregate = { [0 ... BITS_TO_LONGS(PLATFORM_PROFILE_LAST) - 1] = ~0UL },
+		.count = 0,
+	};
 	int ret;
 	int i;
 
@@ -381,13 +422,13 @@ static ssize_t platform_profile_store(struct device *dev,
 	i = sysfs_match_string(profile_names, buf);
 	if (i < 0 || i == PLATFORM_PROFILE_CUSTOM)
 		return -EINVAL;
-	set_bit(PLATFORM_PROFILE_LAST, choices);
+	set_bit(PLATFORM_PROFILE_LAST, data.aggregate);
 	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
 		ret = class_for_each_device(&platform_profile_class, NULL,
-					    choices, _aggregate_choices);
+					    &data, _aggregate_choices);
 		if (ret)
 			return ret;
-		if (!test_bit(i, choices))
+		if (!test_bit(i, data.aggregate))
 			return -EOPNOTSUPP;
 
 		ret = class_for_each_device(&platform_profile_class, NULL, &i,
@@ -453,12 +494,15 @@ EXPORT_SYMBOL_GPL(platform_profile_notify);
  */
 int platform_profile_cycle(void)
 {
+	struct aggregate_choices_data data = {
+		.aggregate = { [0 ... BITS_TO_LONGS(PLATFORM_PROFILE_LAST) - 1] = ~0UL },
+		.count = 0,
+	};
 	enum platform_profile_option next = PLATFORM_PROFILE_LAST;
 	enum platform_profile_option profile = PLATFORM_PROFILE_LAST;
-	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
 	int err;
 
-	set_bit(PLATFORM_PROFILE_LAST, choices);
+	set_bit(PLATFORM_PROFILE_LAST, data.aggregate);
 	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
 		err = class_for_each_device(&platform_profile_class, NULL,
 					    &profile, _aggregate_profiles);
@@ -470,14 +514,14 @@ int platform_profile_cycle(void)
 			return -EINVAL;
 
 		err = class_for_each_device(&platform_profile_class, NULL,
-					    choices, _aggregate_choices);
+					    &data, _aggregate_choices);
 		if (err)
 			return err;
 
 		/* never iterate into a custom if all drivers supported it */
-		clear_bit(PLATFORM_PROFILE_CUSTOM, choices);
+		clear_bit(PLATFORM_PROFILE_CUSTOM, data.aggregate);
 
-		next = find_next_bit_wrap(choices,
+		next = find_next_bit_wrap(data.aggregate,
 					  PLATFORM_PROFILE_LAST,
 					  profile + 1);
 
@@ -532,6 +576,14 @@ struct device *platform_profile_register(struct device *dev, const char *name,
 		return ERR_PTR(-EINVAL);
 	}
 
+	if (ops->hidden_choices) {
+		err = ops->hidden_choices(drvdata, pprof->hidden_choices);
+		if (err) {
+			dev_err(dev, "platform_profile hidden_choices failed\n");
+			return ERR_PTR(err);
+		}
+	}
+
 	guard(mutex)(&profile_lock);
 
 	/* create class interface for individual handler */
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index 8ab5b0e8eb2c1..8c9df7dadd5d3 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -33,6 +33,8 @@ enum platform_profile_option {
  * @probe: Callback to setup choices available to the new class device. These
  *	   choices will only be enforced when setting a new profile, not when
  *	   getting the current one.
+ * @hidden_choices: Callback to setup choices that are not visible to the user
+ *		    but can be set by the driver.
  * @profile_get: Callback that will be called when showing the current platform
  *		 profile in sysfs.
  * @profile_set: Callback that will be called when storing a new platform
@@ -40,6 +42,7 @@ enum platform_profile_option {
  */
 struct platform_profile_ops {
 	int (*probe)(void *drvdata, unsigned long *choices);
+	int (*hidden_choices)(void *drvdata, unsigned long *choices);
 	int (*profile_get)(struct device *dev, enum platform_profile_option *profile);
 	int (*profile_set)(struct device *dev, enum platform_profile_option profile);
 };
-- 
2.43.0


