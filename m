Return-Path: <linux-acpi+bounces-19863-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CB0CDE988
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Dec 2025 11:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B0603006AB6
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Dec 2025 10:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93592314D38;
	Fri, 26 Dec 2025 10:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="Ih1hUbW2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4EF29A307;
	Fri, 26 Dec 2025 10:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766745406; cv=none; b=efMv9Q1qgkQjMub/xyeNou5F4qrvCinqE//0hKEtBgtbad0GmTYQ3pTCjVsVktnvVxl6OlRa165N3FJR7+pdOcXyD5dBA6/4RGvZYjuWYk2akc6OEHYqxPH1FmlRD86o3Ds7uohdHLs44OzglpE3PWVn9Yw5lPw2mDSlwH8Qu+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766745406; c=relaxed/simple;
	bh=3+5bRz3aGa/fzcAmyVYNGN02MFmipMxO6zvyXLHcC04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cUsJDd+N/z1iUvreeA9rCzwvfmKJO45OrKjl+iYJhyS0fxutlNX4RyqIkNMALD6NP4aT2smdmAyNpEEbj1yTRdUGXoZeMVxIPL3U/em964ZT1wjvEdpg0nOvppypQKothbPQ9QRYgli/Fac1trDt8IQlpXOGG7pCB/xUKBhrvNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=Ih1hUbW2; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id 0BA663F421;
	Fri, 26 Dec 2025 12:27:49 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id 6ACE13F41C;
	Fri, 26 Dec 2025 12:27:48 +0200 (EET)
Received: from antheas-z13 (unknown [IPv6:2a02:2149:8a28:c200:ffd7:3bf6:9efd:b472])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 7849E200D51;
	Fri, 26 Dec 2025 12:27:46 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1766744868;
	bh=IIWY/ziOTk5vlnmDAnFLszfbPgF/DV9tjbzBXpl8Ym8=; h=From:To:Subject;
	b=Ih1hUbW2jfpbdkbpvaBEznukR94Y6SxYg6Av5rKSJG7yZ/8ESbLv9v9OVFFd2FH6B
	 lWT3Qe4JYccOlPgYj1mC0IFanvzp3QUV9meEqmhL+4JFBIsvGxRiyHaQKULGKDHGnV
	 m8j+4nG+BRBAii+U7Uz+Pkbz67Lm8+c1wWno4y3a8soJSsrV/MHXEFHzURwC8q6fzR
	 N/j0ASDbF6FUf+FTJekbuGCfRc0x8emo1URLng/PniLDDKpr2d7W5UqkDND00bvTWl
	 VLg99grT7JIP8zqrBF37U+uL3aJeB7FzL4bjlk6P+13oaOGX/f1bGOBWwXdywwl3pH
	 6rxtG0tJdDt6A==
Authentication-Results: linux3247.grserver.gr;
	spf=pass (sender IP is 2a02:2149:8a28:c200:ffd7:3bf6:9efd:b472) smtp.mailfrom=lkml@antheas.dev smtp.helo=antheas-z13
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: dmitry.osipenko@collabora.com
Cc: bob.beckett@collabora.com,
	bookeldor@gmail.com,
	hadess@hadess.net,
	jaap@haitsma.org,
	kernel@collabora.com,
	lennart@poettering.net,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lkml@antheas.dev,
	mccann@jhu.edu,
	rafael@kernel.org,
	richard@hughsie.com,
	sebastian.reichel@collabora.com,
	superm1@kernel.org,
	systemd-devel@lists.freedesktop.org,
	xaver.hugl@gmail.com
Subject: [RFC v1 5/8] acpi/x86: s2idle: move DSM notifications to
 do_notification callback
Date: Fri, 26 Dec 2025 12:26:43 +0200
Message-ID: <20251226102656.6296-6-lkml@antheas.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251226102656.6296-1-lkml@antheas.dev>
References: <20251226102656.6296-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <176674486790.2608494.3399833283691661815@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

Currently, the DSM Sleep Entry/Exit/Display On/Off notifications fire
during the suspend sequence. Move them to the new do_notification
callback so they can be called during runtime as well. The kernel will
still ensure that they are called during s2idle without userspace
involvement.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/acpi/x86/s2idle.c | 87 +++++++++++++++++++++++----------------
 1 file changed, 52 insertions(+), 35 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 08fa7841a484..7693162c68fd 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -547,6 +547,53 @@ static u8 acpi_s2idle_get_standby_states(void)
 	return states;
 }
 
+static int acpi_s2idle_do_notification(standby_notification_t state)
+{
+	switch ((__force unsigned int)state) {
+	case PM_SN_INACTIVE_ENTRY:
+		if (lps0_dsm_func_mask > 0)
+			acpi_sleep_run_lps0_dsm(
+				acpi_s2idle_vendor_amd() ?
+					ACPI_LPS0_DISPLAY_OFF_AMD :
+					ACPI_LPS0_DISPLAY_OFF,
+				lps0_dsm_func_mask, lps0_dsm_guid);
+
+		if (lps0_dsm_func_mask_microsoft > 0)
+			acpi_sleep_run_lps0_dsm(ACPI_LPS0_DISPLAY_OFF,
+						lps0_dsm_func_mask_microsoft,
+						lps0_dsm_guid_microsoft);
+		break;
+	case PM_SN_INACTIVE_EXIT:
+		if (lps0_dsm_func_mask > 0)
+			acpi_sleep_run_lps0_dsm(
+				acpi_s2idle_vendor_amd() ?
+					ACPI_LPS0_DISPLAY_ON_AMD :
+					ACPI_LPS0_DISPLAY_ON,
+				lps0_dsm_func_mask, lps0_dsm_guid);
+		if (lps0_dsm_func_mask_microsoft > 0)
+			acpi_sleep_run_lps0_dsm(ACPI_LPS0_DISPLAY_ON,
+						lps0_dsm_func_mask_microsoft,
+						lps0_dsm_guid_microsoft);
+		break;
+	case PM_SN_SLEEP_ENTRY:
+		if (lps0_dsm_func_mask_microsoft > 0)
+			acpi_sleep_run_lps0_dsm(ACPI_LPS0_SLEEP_ENTRY,
+						lps0_dsm_func_mask_microsoft,
+						lps0_dsm_guid_microsoft);
+		break;
+	case PM_SN_SLEEP_EXIT:
+		if (lps0_dsm_func_mask_microsoft > 0)
+			acpi_sleep_run_lps0_dsm(ACPI_LPS0_SLEEP_EXIT,
+						lps0_dsm_func_mask_microsoft,
+						lps0_dsm_guid_microsoft);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int acpi_s2idle_begin_lps0(void)
 {
 	if (pm_debug_messages_on && !lpi_constraints_table) {
@@ -576,33 +623,16 @@ static int acpi_s2idle_prepare_late_lps0(void)
 	if (pm_debug_messages_on)
 		lpi_check_constraints();
 
-	/* Screen off */
+	/* LPS0 entry */
 	if (lps0_dsm_func_mask > 0)
 		acpi_sleep_run_lps0_dsm(acpi_s2idle_vendor_amd() ?
-					ACPI_LPS0_DISPLAY_OFF_AMD :
-					ACPI_LPS0_DISPLAY_OFF,
+					ACPI_LPS0_ENTRY_AMD :
+					ACPI_LPS0_ENTRY,
 					lps0_dsm_func_mask, lps0_dsm_guid);
 
 	if (lps0_dsm_func_mask_microsoft > 0)
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_DISPLAY_OFF,
-				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
-
-	/* LPS0 entry */
-	if (lps0_dsm_func_mask > 0 && acpi_s2idle_vendor_amd())
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY_AMD,
-					lps0_dsm_func_mask, lps0_dsm_guid);
-
-	if (lps0_dsm_func_mask_microsoft > 0) {
-		/* Modern Standby entry */
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SLEEP_ENTRY,
-				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY,
 				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
-	}
-
-	if (lps0_dsm_func_mask > 0 && !acpi_s2idle_vendor_amd())
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY,
-					lps0_dsm_func_mask, lps0_dsm_guid);
 
 	list_for_each_entry(handler, &lps0_s2idle_devops_head, list_node) {
 		if (handler->prepare)
@@ -643,27 +673,14 @@ static void acpi_s2idle_restore_early_lps0(void)
 					ACPI_LPS0_EXIT,
 					lps0_dsm_func_mask, lps0_dsm_guid);
 
-	if (lps0_dsm_func_mask_microsoft > 0) {
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT,
-				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
-		/* Modern Standby exit */
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SLEEP_EXIT,
-				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
-	}
-
-	/* Screen on */
 	if (lps0_dsm_func_mask_microsoft > 0)
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_DISPLAY_ON,
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT,
 				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
-	if (lps0_dsm_func_mask > 0)
-		acpi_sleep_run_lps0_dsm(acpi_s2idle_vendor_amd() ?
-					ACPI_LPS0_DISPLAY_ON_AMD :
-					ACPI_LPS0_DISPLAY_ON,
-					lps0_dsm_func_mask, lps0_dsm_guid);
 }
 
 static const struct platform_s2idle_ops acpi_s2idle_ops_lps0 = {
 	.get_standby_states = acpi_s2idle_get_standby_states,
+	.do_notification = acpi_s2idle_do_notification,
 	.begin = acpi_s2idle_begin_lps0,
 	.prepare = acpi_s2idle_prepare,
 	.prepare_late = acpi_s2idle_prepare_late_lps0,
-- 
2.52.0



