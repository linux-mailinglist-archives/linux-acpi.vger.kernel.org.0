Return-Path: <linux-acpi+bounces-6437-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B19909F63
	for <lists+linux-acpi@lfdr.de>; Sun, 16 Jun 2024 21:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0430C2830B2
	for <lists+linux-acpi@lfdr.de>; Sun, 16 Jun 2024 19:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8365E4CB36;
	Sun, 16 Jun 2024 19:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="VcMl4GwX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2103482FE;
	Sun, 16 Jun 2024 19:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718564620; cv=none; b=NqP8s7v5wh25P3NxnQbLge/O8zPMdGJE7l4p7vLAZPVblWGec4Ti1rlx5Acht/dc5+fQrzq63ic/LW0Kvn4DzDqs8NleHDjGbRsWL6bsT4BjDugbNYt5uaWEAzrwuGAh0Ou05TkwRIfCj3GQTqm6IPhLp01aDo7yZzJn5dt7E9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718564620; c=relaxed/simple;
	bh=wiXThF8Cv8s9BfLtjBMdMwv3BjfaTV7Ak2mbNROgkoo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Iu8kzvnqq6HTV5UF4oPQuqHbq2ear2IBeCyApuV7EdGJ+mmF+w4nlkmB7ytuwaGhNW7t7ooeceNa7aFGfl6QA5lYJ7jhfI90Uhz1Ivl5usayzsOeQem/jnzPRJ01NWzD/PxOf3GqUHO8YlGm8mLX9J4USbfZ1RiCZFKsi2SaaZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=VcMl4GwX; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1718564615;
	bh=wiXThF8Cv8s9BfLtjBMdMwv3BjfaTV7Ak2mbNROgkoo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VcMl4GwXivkS0gMvmLsKdmAZ9ZxGXLhL17neqJpsuNvxf2wkM+bEKt//ojBWS14Af
	 KP0/8FeATMGiE2NQ70HB19Yz61PU+0qi4X+Z7LkdbVX9lfD6vHf0HiB5Tk86ZOQUn8
	 16uuMpPkG36ZFDFx7Oi0s3aDLZBbsBZo6Zt2PRT8=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 16 Jun 2024 21:03:30 +0200
Subject: [PATCH v4 2/5] platform/chrome: Update binary interface for
 EC-based charge control
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240616-cros_ec-charge-control-v4-2-74d649a9117d@weissschuh.net>
References: <20240616-cros_ec-charge-control-v4-0-74d649a9117d@weissschuh.net>
In-Reply-To: <20240616-cros_ec-charge-control-v4-0-74d649a9117d@weissschuh.net>
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
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718564614; l=2737;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=wiXThF8Cv8s9BfLtjBMdMwv3BjfaTV7Ak2mbNROgkoo=;
 b=Ozh9vbRj8DJVI4tHkjK6kWS4/q3va4TRN9j6tc7R+t7Q8Q0y2OVygcfZLRIWSWsxSn/2qpJaL
 WVrUC7JPaizCGMMHSXzaUfrkkMA4IM5lzSdg2ZvspVMh4y8zNr1R3uL
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


