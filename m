Return-Path: <linux-acpi+bounces-10949-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82ADCA2D73C
	for <lists+linux-acpi@lfdr.de>; Sat,  8 Feb 2025 17:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67602167376
	for <lists+linux-acpi@lfdr.de>; Sat,  8 Feb 2025 16:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF261F1819;
	Sat,  8 Feb 2025 16:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3aH5GOC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C911F17EF;
	Sat,  8 Feb 2025 16:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739031742; cv=none; b=id7hX+yRfR9boZyiAidUB0u43Pkj7aJsqv5z9T5/xhq7r/2n1JjNsSiwKN3PJaWTOsLzd3GMEqpQostv+QqMws9irroDHyl05dZFwgh5gF2DIK8GcLxX7dBlIzM+AqV7D4b9G8JeR5xXBhRfQCiZ4al3QCcoSwgDl8SBx9NWX4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739031742; c=relaxed/simple;
	bh=J5y6IgrSOVtBq4uouiKtoAz+C0U/0HD51b5eO4I/M+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xx/57oSiPWP1C7jIOPS98Gq9X4boM0jjTfpf88DSP2hMiuNl6kXi8BHXZ0PC4RL7s9i27/ckOK3B7HfXj38N7OaYvmgxD7tOMkBckEtaFgtFW/vJT4/4rp7mHWdyUbMQz/agk1WGHdrZA+ZRK3omgeKh6zweKA0CHH1nOXqiTp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3aH5GOC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88DD9C4CEE6;
	Sat,  8 Feb 2025 16:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739031742;
	bh=J5y6IgrSOVtBq4uouiKtoAz+C0U/0HD51b5eO4I/M+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i3aH5GOCsVxb5Smu8sPdbA95ePMG/TwiD0PJGeI6y2/wgXHg8ISTxRmQXHxHoFBQ3
	 n9E9pn+k1Ds8pVDTac2ShdjWckocSCdNwGIWss43omF0AWsTczRZh7WxpohJZIz2aU
	 pSz/Sa9M3HFaYIHM9eRKrb3YAJdLQ+i3NjxzdS/UN6sJEmsdp1qB6ZoWmWYma0kNH/
	 5AwonkbCvZzQ7A96SCp3phv22HZLMEQ1KwjnISHZe83dmmew/vx++ziIhzvrFiYvlj
	 J/JHOnteKQbfUrnyifUOh/Xa5NoCx+fr8hichmhDiKnOIuPmMCBFmOLxLqfYxaNygp
	 Xs0fa0oI3yBDg==
From: Mario Limonciello <superm1@kernel.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	linux-acpi@vger.kernel.org (open list:ACPI),
	linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend, aka swsusp)),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 1/4] PM: Add sysfs file for energy consumed over sleep cycle
Date: Sat,  8 Feb 2025 10:22:07 -0600
Message-ID: <20250208162210.3929473-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250208162210.3929473-1-superm1@kernel.org>
References: <20250208162210.3929473-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

During a sleep cycle the system will consume power to keep the
platform in s2idle or s3. On systems running on a battery this
can be measured by comparing battery before and after the sleep
cycle.

Add a symbol for the battery to report current energy level and
a sysfs file to show this information to a user.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/ABI/testing/sysfs-power |  8 ++++++++
 include/linux/suspend.h               |  2 ++
 kernel/power/main.c                   | 10 ++++++++++
 3 files changed, 20 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
index a3942b1036e25..e263355f99fc1 100644
--- a/Documentation/ABI/testing/sysfs-power
+++ b/Documentation/ABI/testing/sysfs-power
@@ -442,6 +442,14 @@ Description:
 		'total_hw_sleep' and 'last_hw_sleep' may not be accurate.
 		This number is measured in microseconds.
 
+What:		/sys/power/suspend_stats/last_sleep_energy
+Date:		March 2025
+Contact:	Mario Limonciello <mario.limonciello@amd.com>
+Description:
+		The /sys/power/suspend_stats/last_sleep_energy file
+		contains the amount of energy that the battery consumed
+		during the last sleep cycle. This number is measured in mAh.
+
 What:		/sys/power/sync_on_suspend
 Date:		October 2019
 Contact:	Jonas Meurer <jonas@freesources.org>
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index da6ebca3ff774..9627e2394c8a9 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -441,6 +441,7 @@ extern int unregister_pm_notifier(struct notifier_block *nb);
 extern void ksys_sync_helper(void);
 extern void pm_report_hw_sleep_time(u64 t);
 extern void pm_report_max_hw_sleep(u64 t);
+extern void pm_report_sleep_energy(u64 t);
 
 #define pm_notifier(fn, pri) {				\
 	static struct notifier_block fn##_nb =			\
@@ -484,6 +485,7 @@ static inline int unregister_pm_notifier(struct notifier_block *nb)
 
 static inline void pm_report_hw_sleep_time(u64 t) {};
 static inline void pm_report_max_hw_sleep(u64 t) {};
+static inline void pm_report_sleep_energy(u64 t) {};
 
 static inline void ksys_sync_helper(void) {}
 
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 6254814d48171..9305c86e0b91a 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -321,6 +321,7 @@ struct suspend_stats {
 	u64 last_hw_sleep;
 	u64 total_hw_sleep;
 	u64 max_hw_sleep;
+	u64 last_sleep_energy;
 	enum suspend_stat_step failed_steps[REC_FAILED_NUM];
 };
 
@@ -368,6 +369,12 @@ void pm_report_hw_sleep_time(u64 t)
 }
 EXPORT_SYMBOL_GPL(pm_report_hw_sleep_time);
 
+void pm_report_sleep_energy(u64 t)
+{
+	suspend_stats.last_sleep_energy = t;
+}
+EXPORT_SYMBOL_GPL(pm_report_sleep_energy);
+
 void pm_report_max_hw_sleep(u64 t)
 {
 	suspend_stats.max_hw_sleep = t;
@@ -399,6 +406,7 @@ suspend_attr(fail, "%u\n");
 suspend_attr(last_hw_sleep, "%llu\n");
 suspend_attr(total_hw_sleep, "%llu\n");
 suspend_attr(max_hw_sleep, "%llu\n");
+suspend_attr(last_sleep_energy, "%llu\n");
 
 #define suspend_step_attr(_name, step)		\
 static ssize_t _name##_show(struct kobject *kobj,		\
@@ -477,6 +485,7 @@ static struct attribute *suspend_attrs[] = {
 	&last_hw_sleep.attr,
 	&total_hw_sleep.attr,
 	&max_hw_sleep.attr,
+	&last_sleep_energy.attr,
 	NULL,
 };
 
@@ -484,6 +493,7 @@ static umode_t suspend_attr_is_visible(struct kobject *kobj, struct attribute *a
 {
 	if (attr != &last_hw_sleep.attr &&
 	    attr != &total_hw_sleep.attr &&
+	    attr != &last_sleep_energy.attr &&
 	    attr != &max_hw_sleep.attr)
 		return 0444;
 
-- 
2.43.0


