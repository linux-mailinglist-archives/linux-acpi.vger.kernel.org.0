Return-Path: <linux-acpi+bounces-10952-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D385A2D742
	for <lists+linux-acpi@lfdr.de>; Sat,  8 Feb 2025 17:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F4B6165566
	for <lists+linux-acpi@lfdr.de>; Sat,  8 Feb 2025 16:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A071F30B4;
	Sat,  8 Feb 2025 16:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcUBmrrc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2831F30B0;
	Sat,  8 Feb 2025 16:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739031745; cv=none; b=MDUteSHjgq50XcSG27f/lG3Y0nFOfKehbPZwKys6rkbXB2aiJgJDU71cphTbsY3Z3AQiF3RG2qBBnQzPwBf4dOam4USWCEgbMQ5ZLAQ5MyEG/wEaqnY90r0vcu1M+u+f3T9F6ZGywPRkyHKy60fCejnArUXMSNx0NEJKz3MFANQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739031745; c=relaxed/simple;
	bh=Dnni8GKPdcukcrtd2Tff75EhjCO+JRljRFGY6qeFkb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y5tqzq/ripYJXvv5R/11sUNaJpGDSP0wJqXdudJlrXR3c1XxX8fM6ctX9nKMK8pRSU8s3mO+PMmBc8upok7ntljZNazeoaeSp7A+vvgeE5dSHPWhOeQqB2UD/LNBrFscWylP5HshGfU9sURamBIp+OU+jZi9b4VnE4+ai/E+I1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcUBmrrc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48299C4CED6;
	Sat,  8 Feb 2025 16:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739031744;
	bh=Dnni8GKPdcukcrtd2Tff75EhjCO+JRljRFGY6qeFkb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kcUBmrrcLD7nU+nXCUnvY49YC3G3awge9rTbeWD3y9gaBPwfh8iW9Zr4rJJWpZVqp
	 aDXKuweAopfXqBG0ENoqkz+++/73dAVgTh5LKN3dlrY6tNbEu/dfPb+S41DaCuTCsp
	 dClmOBlMkiVPjcdctGSY6k2lEaYLpkRTVKRf/kEnoPsF3UN0oGhYiG/jYkb2DrWsC5
	 AUAY4hqejrzoOWP2eSKMWVW59pHywwhHyb1J2rvJpEfKPlQqTsOxr3knR9wakRMhdl
	 5pDfspJXyHYwFPuhKwXtbFc+CLMm3ldjU/E9AxOpN9tEJCZNXBzVbGVb6gg1Xu0I2j
	 5tHmpY/iSYxbw==
From: Mario Limonciello <superm1@kernel.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	linux-acpi@vger.kernel.org (open list:ACPI),
	linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend, aka swsusp)),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 4/4] ACPI: battery: Wake system on AC plug or unplug in over s2idle
Date: Sat,  8 Feb 2025 10:22:10 -0600
Message-ID: <20250208162210.3929473-5-superm1@kernel.org>
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

On Windows the OS will wake up when plugged or unplugged from AC adapter.
Depending upon whether the system was plugged in or unplugged will
determine whether the "display turns on".  If there is no user activity
for some time then it goes back to sleep.

In Linux plugging or unplugging an adapter will wake the SoC from HW
sleep but then the Linux kernel puts it right back into HW sleep
immediately unless there is another interrupt active (such as a PME or
GPIO).

To get closer to the Windows behavior, record the state of the battery
when going into suspend and compare it when updating battery status
during the s2idle loop. If it's changed, wake the system.

This can be restored to previous behavior by disabling the ACPI battery
device `power/wakeup` sysfs file.

Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/modern-standby-wake-sources#environmental-context-changes-1
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/battery.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 72c8a509695e6..91f79927cc720 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -125,6 +125,7 @@ struct acpi_battery {
 	int state;
 	int power_unit;
 	int capacity_suspend;
+	int suspend_state;
 	unsigned long flags;
 };
 
@@ -1012,6 +1013,12 @@ static inline bool acpi_battery_should_wake(struct acpi_battery *battery)
 		return true;
 	}
 
+	if (battery->state != battery->suspend_state) {
+		pm_pr_dbg("Waking due to battery state changed from 0x%x to 0x%x",
+			  battery->suspend_state, battery->state);
+		return true;
+	}
+
 	return false;
 }
 
@@ -1313,6 +1320,7 @@ static int acpi_battery_suspend(struct device *dev)
 		return -EINVAL;
 
 	battery->capacity_suspend = battery->capacity_now;
+	battery->suspend_state = battery->state;
 
 	return 0;
 }
-- 
2.43.0


