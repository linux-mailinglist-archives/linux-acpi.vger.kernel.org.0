Return-Path: <linux-acpi+bounces-19857-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D44E6CDE958
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Dec 2025 11:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6C2D030006C5
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Dec 2025 10:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27C4317712;
	Fri, 26 Dec 2025 10:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="h5ZMRZlc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB069314D38;
	Fri, 26 Dec 2025 10:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766744874; cv=none; b=WCaSzRMw3+RRliaK70R9ssVPk72HriuCkMwSU8MW/K0Iems9o2Tpj72WTrLwJ/4P1TqM2kmSDo43537/l/hoar1gqiplqbF+PwdlLDl/LOPcVLLuziBXeuK5Fl8RaYbakd9gim+Bn9mbtipibhcRWRtQR0f7mtF1Dd846kqge4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766744874; c=relaxed/simple;
	bh=kU7WKbzAeotw+Yh5dtlEQy3dh22cpZu25cvJtN2jHkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ICytr0d8VJSjnUChmhNBUihWTxpSql+HovjBqmBmXfVQxV75KTFuvk0I4yCL9foGArGP6uGMWeg/tqeBso7qQfbf0cnGFExE4HwMfO/DrHD7+c3uao1w9w+xCBHYTn9sCXHBYvCVjaVHMvx+68RHFB8kpou7dBFITEpLYqpKnmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=h5ZMRZlc; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id 42E91BDA27;
	Fri, 26 Dec 2025 12:27:51 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id 70B7ABC770;
	Fri, 26 Dec 2025 12:27:50 +0200 (EET)
Received: from antheas-z13 (unknown [IPv6:2a02:2149:8a28:c200:ffd7:3bf6:9efd:b472])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 4CB77200D44;
	Fri, 26 Dec 2025 12:27:48 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1766744870;
	bh=NIq2lJ/ajRZv+Ep787KnOYWC1DkezUTruLFYn4AKlf8=; h=From:To:Subject;
	b=h5ZMRZlcuD9/F4+jk6M/TyZi/RBHcLDrr/30dqfoHxQhdVkbh1LCBBMi7jGTe6eqR
	 GdUVmSpj4AkOAXnxw/BS9JKglAFFf0jcIjNDSGYVpvw2oEeRmUDcK9ZeQ6JagsbOUI
	 2yavYzftn9yEowKwfdEeEW1iluhlTmbNrBQRmxjJ6UCfDJ/ymjsQsznGBqb6TIfd0I
	 VqsGDvRv1o3gCkUa33JSXCTZjq6BMgcALrWQxpNesrVbElL55Ks0OXnRqp3SX0b3wX
	 IFMBUN7PLS2P1NLnzikBFF0hqYFJ6oZsNKDabOT12eXhNNRLGD72Pl2k/2HbbZBDZM
	 61c3WmgiMpheA==
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
Subject: [RFC v1 6/8] acpi/x86: s2idle: implement turn on display DSM as
 resume notification
Date: Fri, 26 Dec 2025 12:26:44 +0200
Message-ID: <20251226102656.6296-7-lkml@antheas.dev>
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
 <176674486991.2608577.4259034392204383426@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

Windows implements a DSM called "Turn On Display". This notification is
sent to the hardware while on the sleep state if the user interacted
with the device and caused it to wake up in such a way where the display
should turn on.

This allows the OEM to counter the effects of Sleep entry such as a
reduced power envelope to allow for the device to wake up faster.
Implement it as part of the "resume" state in the Microsoft-agnostic
kernel ABI.

Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/modern-standby-firmware-notifications
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/acpi/x86/s2idle.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 7693162c68fd..965b78cc8bf5 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -39,12 +39,13 @@ static const struct acpi_device_id lps0_device_ids[] = {
 #define ACPI_LPS0_DSM_UUID	"c4eb40a0-6cd2-11e2-bcfd-0800200c9a66"
 
 #define ACPI_LPS0_GET_DEVICE_CONSTRAINTS	1
-#define ACPI_LPS0_DISPLAY_OFF	3
-#define ACPI_LPS0_DISPLAY_ON	4
-#define ACPI_LPS0_ENTRY		5
-#define ACPI_LPS0_EXIT		6
-#define ACPI_LPS0_SLEEP_ENTRY	7
-#define ACPI_LPS0_SLEEP_EXIT	8
+#define ACPI_LPS0_DISPLAY_OFF		3
+#define ACPI_LPS0_DISPLAY_ON		4
+#define ACPI_LPS0_ENTRY			5
+#define ACPI_LPS0_EXIT			6
+#define ACPI_LPS0_SLEEP_ENTRY		7
+#define ACPI_LPS0_SLEEP_EXIT		8
+#define ACPI_LPS0_TURN_ON_DISPLAY	9
 
 /* AMD */
 #define ACPI_LPS0_DSM_UUID_AMD      "e3f32452-febc-43ce-9039-932122d37721"
@@ -352,6 +353,8 @@ static const char *acpi_sleep_dsm_state_to_str(unsigned int state)
 			return "sleep entry";
 		case ACPI_LPS0_SLEEP_EXIT:
 			return "sleep exit";
+		case ACPI_LPS0_TURN_ON_DISPLAY:
+			return "turn on display";
 		}
 	} else {
 		switch (state) {
@@ -528,6 +531,9 @@ static u8 acpi_s2idle_get_standby_states(void)
 		if (lps0_dsm_func_mask_microsoft &
 		    (1 << ACPI_LPS0_SLEEP_ENTRY | 1 << ACPI_LPS0_SLEEP_EXIT))
 			states |= BIT(PM_STANDBY_SLEEP);
+		if (lps0_dsm_func_mask_microsoft &
+		    (1 << ACPI_LPS0_TURN_ON_DISPLAY))
+			states |= BIT(PM_STANDBY_RESUME);
 	}
 
 	if (lps0_dsm_func_mask > 0) {
@@ -587,6 +593,12 @@ static int acpi_s2idle_do_notification(standby_notification_t state)
 						lps0_dsm_func_mask_microsoft,
 						lps0_dsm_guid_microsoft);
 		break;
+	case PM_SN_RESUME:
+		if (lps0_dsm_func_mask_microsoft > 0)
+			acpi_sleep_run_lps0_dsm(ACPI_LPS0_TURN_ON_DISPLAY,
+						lps0_dsm_func_mask_microsoft,
+						lps0_dsm_guid_microsoft);
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.52.0



