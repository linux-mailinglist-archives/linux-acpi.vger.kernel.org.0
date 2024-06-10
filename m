Return-Path: <linux-acpi+bounces-6289-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6839D902609
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Jun 2024 17:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07DB81F23172
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Jun 2024 15:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8B714262C;
	Mon, 10 Jun 2024 15:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="aOHM2mGL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBAA13E3F2;
	Mon, 10 Jun 2024 15:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718034731; cv=none; b=H/wLSme1oOuf7rkMXdn260IAHR74Cf0jZ7oDBaITpyOlA8B8addwthD3Mv93fRZNhDhVybgU+qbPimRaJNAl977+MaruL3Pey0BYh9975ajb2TiTLmpMrtqKeDl8lYqqZBI13ML76P6vl+z5mslDZs2/pKaNpQrir7hYb8gk2dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718034731; c=relaxed/simple;
	bh=wiXThF8Cv8s9BfLtjBMdMwv3BjfaTV7Ak2mbNROgkoo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f/tquSS5qZbaP1Lwi44QaUuM1S7uQhcpOajcy0LRGD7Vi45RluH/1nAZDTWwIxEkva2Fd1USUBounV+EO+8dSTJNd2h6fX2O2DOC5e5te/Q/XRbaXKiQyIPNGFm+dFtlaiYcQ06OHLNJMsHeEXahqVoo/2XOlDnWLDtUaMWKNRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=aOHM2mGL; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1718034726;
	bh=wiXThF8Cv8s9BfLtjBMdMwv3BjfaTV7Ak2mbNROgkoo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aOHM2mGLnlszY7u+sQzIDhQHoXwsq1HEyRzsTq6itoRH0SpGbE1VUHwyTmVbAWT+4
	 /h2rgdWK7O1IBJXAuoBjx3Rw7T0Dhfrb2eut7hU7/L1wmq5sFz2eUEGnCxDMWvv161
	 KFrMKQBxz3sIwuAoRLTdWP5YwVttb6k+0ZvKKJws=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 10 Jun 2024 17:51:07 +0200
Subject: [PATCH v3 2/5] platform/chrome: Update binary interface for
 EC-based charge control
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240610-cros_ec-charge-control-v3-2-135e37252094@weissschuh.net>
References: <20240610-cros_ec-charge-control-v3-0-135e37252094@weissschuh.net>
In-Reply-To: <20240610-cros_ec-charge-control-v3-0-135e37252094@weissschuh.net>
To: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 Sebastian Reichel <sre@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, Tzung-Bi Shih <tzungbi@kernel.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>, 
 Dustin Howett <dustin@howett.net>, 
 Stephen Horvath <s.horvath@outlook.com.au>, 
 Rajas Paranjpe <paranjperajas@gmail.com>, linux-acpi@vger.kernel.org, 
 acpica-devel@lists.linux.dev, Matt Hartley <matt.hartley@gmail.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718034726; l=2737;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=wiXThF8Cv8s9BfLtjBMdMwv3BjfaTV7Ak2mbNROgkoo=;
 b=1SsvsC41J3n/vk/ZG8IwOit7MH7m+s2bsFwzf2068otXpRxHxWulpchHzAKYs8HMPQTRcdGg2
 NTPpEtMUjvOAHBvHVWMpaw6tpZlNmJuIhewveILqkqRogpcBMrmjDsE
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The charge-control command v2/v3 is more featureful than v1, it
additionally supports charge thresholds.

The definitions were imported from ChromeOS EC commit
32870d602317 ("squirtle: modify motionsense rotation matrix")

Acked-by: Tzung-Bi Shih <tzungbi@kernel.org>
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 include/linux/platform_data/cros_ec_commands.h | 49 ++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
index ec598057d1da..e574b790be6f 100644
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -3843,16 +3843,61 @@ struct ec_params_i2c_write {
  * discharge the battery.
  */
 #define EC_CMD_CHARGE_CONTROL 0x0096
-#define EC_VER_CHARGE_CONTROL 1
+#define EC_VER_CHARGE_CONTROL 3
 
 enum ec_charge_control_mode {
 	CHARGE_CONTROL_NORMAL = 0,
 	CHARGE_CONTROL_IDLE,
 	CHARGE_CONTROL_DISCHARGE,
+	/* Add no more entry below. */
+	CHARGE_CONTROL_COUNT,
+};
+
+#define EC_CHARGE_MODE_TEXT                               \
+	{                                                 \
+		[CHARGE_CONTROL_NORMAL] = "NORMAL",       \
+		[CHARGE_CONTROL_IDLE] = "IDLE",           \
+		[CHARGE_CONTROL_DISCHARGE] = "DISCHARGE", \
+	}
+
+enum ec_charge_control_cmd {
+	EC_CHARGE_CONTROL_CMD_SET = 0,
+	EC_CHARGE_CONTROL_CMD_GET,
+};
+
+enum ec_charge_control_flag {
+	EC_CHARGE_CONTROL_FLAG_NO_IDLE = BIT(0),
 };
 
 struct ec_params_charge_control {
-	uint32_t mode;  /* enum charge_control_mode */
+	uint32_t mode; /* enum charge_control_mode */
+
+	/* Below are the fields added in V2. */
+	uint8_t cmd; /* enum ec_charge_control_cmd. */
+	uint8_t flags; /* enum ec_charge_control_flag (v3+) */
+	/*
+	 * Lower and upper thresholds for battery sustainer. This struct isn't
+	 * named to avoid tainting foreign projects' name spaces.
+	 *
+	 * If charge mode is explicitly set (e.g. DISCHARGE), battery sustainer
+	 * will be disabled. To disable battery sustainer, set mode=NORMAL,
+	 * lower=-1, upper=-1.
+	 */
+	struct {
+		int8_t lower; /* Display SoC in percentage. */
+		int8_t upper; /* Display SoC in percentage. */
+	} sustain_soc;
+} __ec_align4;
+
+/* Added in v2 */
+struct ec_response_charge_control {
+	uint32_t mode; /* enum charge_control_mode */
+	struct { /* Battery sustainer thresholds */
+		int8_t lower;
+		int8_t upper;
+	} sustain_soc;
+	uint8_t flags; /* enum ec_charge_control_flag (v3+) */
+	uint8_t reserved;
 } __ec_align4;
 
 /*****************************************************************************/

-- 
2.45.2


