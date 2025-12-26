Return-Path: <linux-acpi+bounces-19856-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FB2CDE961
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Dec 2025 11:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F68D3006A54
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Dec 2025 10:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79141315D39;
	Fri, 26 Dec 2025 10:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="F9X19xtv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5A8314D0F;
	Fri, 26 Dec 2025 10:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766744873; cv=none; b=LOhIz+q5vEUNa//3tuo4KzjHf2h59hC1cmiChqaY+40CPf7DuTLdQjQ7IQAmmP3SsDOpWjZP+AWQ22KAghZmABtZoxF1ZImn3gTxU3bMGxKwl2cKNqeKJzVjT3ArtGxWgEcXtxGfu5/dvZTzHZDE3jzUvEkevW32BHE1dYGqA+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766744873; c=relaxed/simple;
	bh=4hqf5rS2bfwFvwbCJlmmrloIZ4v2ItiJpg+F3qHUwXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jE+Dco7zQibirPemLwxN/U7lfOscwC6ZwQyu+gWxYCxJJ1mnSjfEqejgddc3I/oOEIp1e9WfOWqSPJnTXWHSocBapuaQr5Brk2ybJmOUKvtIqXaZmWDi2cI+e6Ivd/okNr4UGQ3z7d5vOTf0LpWYVgs9aToDJr6UsITJoagQRwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=F9X19xtv; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id 6FE8CC2472;
	Fri, 26 Dec 2025 12:27:43 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id BC2CFC1921;
	Fri, 26 Dec 2025 12:27:42 +0200 (EET)
Received: from antheas-z13 (unknown [IPv6:2a02:2149:8a28:c200:ffd7:3bf6:9efd:b472])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id E965D200D44;
	Fri, 26 Dec 2025 12:27:40 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1766744862;
	bh=LiOshHGRwJ9kf6zmx7ZpAhOgcdHT3lRX/PPYtrOsoyI=; h=From:To:Subject;
	b=F9X19xtvhUEsVGLEremhLCyijTX7GEIEm7eihJOyFT1PUiZrwUDLuwTbFJDjSBOY0
	 9C1OU/89QE7Gu0WiyRwuoD9nrdfrhOWC55QTBWDPkrE7vwBE3wxmA63Xs2nVuuNeG1
	 SR3q84fTjf8A35YbTUwunJF3VuJVvNowLtUYEISL8VjoLeEdPcNw0OQ9C7qMhmsCyA
	 6GaETnJ7IbSHuBGOjvaDA0qYwUXacGSutO+T6P9jI5/zv1Wm9F8uBQJVKo6JgDax1X
	 bBLUQABwFyLIgE+HWCY48Nc54+l3kaZcyoUhZh2jtpzTYCwvyUL58tkpPHHwqx7H/o
	 +2ltuvDAvpDHA==
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
Subject: [RFC v1 2/8] acpi/x86: s2idle: Rename LPS0 constants so they mirror
 their function
Date: Fri, 26 Dec 2025 12:26:40 +0200
Message-ID: <20251226102656.6296-3-lkml@antheas.dev>
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
 <176674486237.2608281.13875257044813946897@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

The LPS0 3/4 constants are part of a firmware notification called
"Display on/off", in which the device enters a "Screen Off" state.
The LPS0 7/8 constants are part of a firmware notification in which
a Windows modern standby computer enters a "sleep" state where the
CPU may still be active and maintain the radios.

However, currently, the values are named as "Screen on/off" and "MS
entry/exit", where Modern Standby is abbreviated as "MS". Therefore,
perform a minor rename so that the values match their function. Then,
fix the debug message to say that it executes notifications instead of
entering states as it is otherwise confusing.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/acpi/x86/s2idle.c | 54 +++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 6d4d06236f61..1f13c8b0ef83 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -39,19 +39,19 @@ static const struct acpi_device_id lps0_device_ids[] = {
 #define ACPI_LPS0_DSM_UUID	"c4eb40a0-6cd2-11e2-bcfd-0800200c9a66"
 
 #define ACPI_LPS0_GET_DEVICE_CONSTRAINTS	1
-#define ACPI_LPS0_SCREEN_OFF	3
-#define ACPI_LPS0_SCREEN_ON	4
+#define ACPI_LPS0_DISPLAY_OFF	3
+#define ACPI_LPS0_DISPLAY_ON	4
 #define ACPI_LPS0_ENTRY		5
 #define ACPI_LPS0_EXIT		6
-#define ACPI_LPS0_MS_ENTRY      7
-#define ACPI_LPS0_MS_EXIT       8
+#define ACPI_LPS0_SLEEP_ENTRY	7
+#define ACPI_LPS0_SLEEP_EXIT	8
 
 /* AMD */
 #define ACPI_LPS0_DSM_UUID_AMD      "e3f32452-febc-43ce-9039-932122d37721"
 #define ACPI_LPS0_ENTRY_AMD         2
 #define ACPI_LPS0_EXIT_AMD          3
-#define ACPI_LPS0_SCREEN_OFF_AMD    4
-#define ACPI_LPS0_SCREEN_ON_AMD     5
+#define ACPI_LPS0_DISPLAY_OFF_AMD   4
+#define ACPI_LPS0_DISPLAY_ON_AMD    5
 
 static acpi_handle lps0_device_handle;
 static guid_t lps0_dsm_guid;
@@ -340,25 +340,25 @@ static const char *acpi_sleep_dsm_state_to_str(unsigned int state)
 {
 	if (lps0_dsm_func_mask_microsoft || !acpi_s2idle_vendor_amd()) {
 		switch (state) {
-		case ACPI_LPS0_SCREEN_OFF:
-			return "screen off";
-		case ACPI_LPS0_SCREEN_ON:
-			return "screen on";
+		case ACPI_LPS0_DISPLAY_OFF:
+			return "display off";
+		case ACPI_LPS0_DISPLAY_ON:
+			return "display on";
 		case ACPI_LPS0_ENTRY:
 			return "lps0 entry";
 		case ACPI_LPS0_EXIT:
 			return "lps0 exit";
-		case ACPI_LPS0_MS_ENTRY:
-			return "lps0 ms entry";
-		case ACPI_LPS0_MS_EXIT:
-			return "lps0 ms exit";
+		case ACPI_LPS0_SLEEP_ENTRY:
+			return "sleep entry";
+		case ACPI_LPS0_SLEEP_EXIT:
+			return "sleep exit";
 		}
 	} else {
 		switch (state) {
-		case ACPI_LPS0_SCREEN_ON_AMD:
-			return "screen on";
-		case ACPI_LPS0_SCREEN_OFF_AMD:
-			return "screen off";
+		case ACPI_LPS0_DISPLAY_ON_AMD:
+			return "display on";
+		case ACPI_LPS0_DISPLAY_OFF_AMD:
+			return "display off";
 		case ACPI_LPS0_ENTRY_AMD:
 			return "lps0 entry";
 		case ACPI_LPS0_EXIT_AMD:
@@ -383,7 +383,7 @@ static void acpi_sleep_run_lps0_dsm(unsigned int func, unsigned int func_mask, g
 	lps0_dsm_state = func;
 	if (pm_debug_messages_on) {
 		acpi_handle_info(lps0_device_handle,
-				"%s transitioned to state %s\n",
+				"%s executed notification %s\n",
 				 out_obj ? "Successfully" : "Failed to",
 				 acpi_sleep_dsm_state_to_str(lps0_dsm_state));
 	}
@@ -545,12 +545,12 @@ static int acpi_s2idle_prepare_late_lps0(void)
 	/* Screen off */
 	if (lps0_dsm_func_mask > 0)
 		acpi_sleep_run_lps0_dsm(acpi_s2idle_vendor_amd() ?
-					ACPI_LPS0_SCREEN_OFF_AMD :
-					ACPI_LPS0_SCREEN_OFF,
+					ACPI_LPS0_DISPLAY_OFF_AMD :
+					ACPI_LPS0_DISPLAY_OFF,
 					lps0_dsm_func_mask, lps0_dsm_guid);
 
 	if (lps0_dsm_func_mask_microsoft > 0)
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF,
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_DISPLAY_OFF,
 				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
 
 	/* LPS0 entry */
@@ -560,7 +560,7 @@ static int acpi_s2idle_prepare_late_lps0(void)
 
 	if (lps0_dsm_func_mask_microsoft > 0) {
 		/* Modern Standby entry */
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_ENTRY,
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SLEEP_ENTRY,
 				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY,
 				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
@@ -613,18 +613,18 @@ static void acpi_s2idle_restore_early_lps0(void)
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT,
 				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
 		/* Modern Standby exit */
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_EXIT,
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SLEEP_EXIT,
 				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
 	}
 
 	/* Screen on */
 	if (lps0_dsm_func_mask_microsoft > 0)
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON,
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_DISPLAY_ON,
 				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
 	if (lps0_dsm_func_mask > 0)
 		acpi_sleep_run_lps0_dsm(acpi_s2idle_vendor_amd() ?
-					ACPI_LPS0_SCREEN_ON_AMD :
-					ACPI_LPS0_SCREEN_ON,
+					ACPI_LPS0_DISPLAY_ON_AMD :
+					ACPI_LPS0_DISPLAY_ON,
 					lps0_dsm_func_mask, lps0_dsm_guid);
 }
 
-- 
2.52.0



