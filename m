Return-Path: <linux-acpi+bounces-17943-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FAEBED183
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Oct 2025 16:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6801319C0D5B
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Oct 2025 14:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADE22FFF81;
	Sat, 18 Oct 2025 14:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HVOXcCeC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E02C2FBE04;
	Sat, 18 Oct 2025 14:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760797333; cv=none; b=PRe48qgidWTbWX3tqn6flp2/Z8gk+sAijEOBefxP4hMmadMfn8EmwEfPG4xBt8l5xqesu6bNTMJtJCnnsJj8HjwRlp5Igq215QqYOwLUPcUziiZodThr5z5T3PO6IcaDSQbd7F+V8OER0K7/190RVRNq2SSpXdWeqeZF7X1G2oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760797333; c=relaxed/simple;
	bh=t/dFdhvyuz66Bza7SgTKVPfg4WTopgWxJbZsaxCOTOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WhsjhItCyin0NZeB8+gsIpABLrIonvdKNSQeWRriq6MoMLdbLT05APCf1CWWdddZvz3WxZsVo1S2+iBZ8Kd70BqUT1CbJApkMskz8Rg0msrPr3CdV8gCJVkSrVhOXT1AgCeOc/i/gHEv5karyDgwarRDat0XMh7W6O9KZmYWdrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HVOXcCeC; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760797329;
	bh=t/dFdhvyuz66Bza7SgTKVPfg4WTopgWxJbZsaxCOTOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HVOXcCeC6R/8O24N4CWmc9cPxh/HOTY8T1lEZ56rfwNuZNV6qkVt4g5QkcXOYOu13
	 m3ZEBuNIinO/as+SRtiGyRaV6hnWp00IVPUiolKC1so4lJX4eHNkQHQnrtXn41Ef+s
	 SPcH5K/tEEs9Rl+8UWFzCfWzfv7Av0JRwMUs5+ymv2hzn4Wc0ASK1sbfJnuhg26QSi
	 rYhIyLIjYHVWkWoJBg7a1XVBYJC4TybxeSBZmr1nro2QZuGNN/HQtk8F74s6Yxyckw
	 GfpocVSnk3Hzp4DxqSmG6wQIl+8H7+x390IT05vW9omPPUHPsTHrRVzXVAGwbdKfdB
	 YiZiy1/E87TZA==
Received: from mt.tail9873f4.ts.net (unknown [144.48.130.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3786A17E13F2;
	Sat, 18 Oct 2025 16:22:07 +0200 (CEST)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-input@vger.kernel.org
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	superm1@kernel.org
Subject: [RFC 4/4] PM: sleep: clear pm_abort_suspend at suspend
Date: Sat, 18 Oct 2025 19:21:07 +0500
Message-ID: <20251018142114.897445-5-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251018142114.897445-1-usama.anjum@collabora.com>
References: <20251018142114.897445-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clear pm_abort_suspend counter in case a wakeup is detected during
hibernation process. If this counter isn't reset, it'll affect the
next hibernation cycle and next time hibernation will not happen as
pm_abort_suspend is still positive.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 drivers/base/power/main.c | 2 ++
 kernel/cpu.c              | 1 +
 kernel/power/hibernate.c  | 5 ++++-
 kernel/power/process.c    | 1 +
 4 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index bcfb170baca63..481744e7d9688 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1627,6 +1627,7 @@ static void device_suspend_late(struct device *dev, pm_message_t state, bool asy
 		goto Complete;
 
 	if (pm_wakeup_pending()) {
+		pm_wakeup_clear(0);
 		WRITE_ONCE(async_error, -EBUSY);
 		goto Complete;
 	}
@@ -1872,6 +1873,7 @@ static void device_suspend(struct device *dev, pm_message_t state, bool async)
 
 	if (pm_wakeup_pending()) {
 		dev->power.direct_complete = false;
+		pm_wakeup_clear(0);
 		WRITE_ONCE(async_error, -EBUSY);
 		goto Complete;
 	}
diff --git a/kernel/cpu.c b/kernel/cpu.c
index db9f6c539b28c..74c9f6b4947dd 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1921,6 +1921,7 @@ int freeze_secondary_cpus(int primary)
 
 		if (pm_wakeup_pending()) {
 			pr_info("Wakeup pending. Abort CPU freeze\n");
+			pm_wakeup_clear(0);
 			error = -EBUSY;
 			break;
 		}
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index aadf82f57e868..1a4a5c3c64970 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -350,8 +350,10 @@ static int create_image(int platform_mode)
 		goto Enable_irqs;
 	}
 
-	if (hibernation_test(TEST_CORE) || pm_wakeup_pending())
+	if (hibernation_test(TEST_CORE) || pm_wakeup_pending()) {
+		pm_wakeup_clear(0);
 		goto Power_up;
+	}
 
 	in_suspend = 1;
 	save_processor_state();
@@ -661,6 +663,7 @@ int hibernation_platform_enter(void)
 		goto Enable_irqs;
 
 	if (pm_wakeup_pending()) {
+		pm_wakeup_clear(0);
 		error = -EAGAIN;
 		goto Power_up;
 	}
diff --git a/kernel/power/process.c b/kernel/power/process.c
index 8ff68ebaa1e08..7a278e049940c 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -67,6 +67,7 @@ static int try_to_freeze_tasks(bool user_only)
 			break;
 
 		if (pm_wakeup_pending()) {
+			pm_wakeup_clear(0);
 			wakeup = true;
 			break;
 		}
-- 
2.47.3


