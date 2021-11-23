Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC6E345A7C8
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Nov 2021 17:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbhKWQgE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Nov 2021 11:36:04 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:55260 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235318AbhKWQgB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 23 Nov 2021 11:36:01 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AN6Jv72020525;
        Tue, 23 Nov 2021 10:31:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=j9hLZJzFMAZOG6A9G9YB4YFvcbNiH2pOiYjJgOXYQrI=;
 b=puFYdxjzqSVi8FmSTMgCRWDCmdLcnVKrCx5VI1YJJ9dOAr/JFHHeO1pnchIjpkBWK/KR
 LfnuwthniYQt0gI7OIF30HroLTqKaecxr7FXTKtYW/UtXs/QgS+6sDNQS1KxfVJa0vqJ
 GKx2yNj1c0pPvfuvFsc3FJpo8X/d1FDtj2VYvwJ1Q7CUCTne9ZVBdKgFVjroRwc9nv/b
 XljHov7HN+k8jqXpdEG/ASNB1CD6qSQ9ZOixkHscjzXQynVJAYqfiCh3YO1tOFpokWWK
 qxw9QG450dhZHXXr2tGqX3T9dVbwmzjYH+X+0hTnmgqvuEaRqbUjFyKktP47qugjqZNn GQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3cg5ms21nk-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 23 Nov 2021 10:31:56 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 23 Nov
 2021 16:31:53 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 23 Nov 2021 16:31:53 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.11])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0563F2A3;
        Tue, 23 Nov 2021 16:31:53 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Kailang Yang <kailang@realtek.com>,
        Shuming Fan <shumingf@realtek.com>,
        "Pierre-Louis Bossart" <pierre-louis.bossart@linux.intel.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>
CC:     Jeremy Szu <jeremy.szu@canonical.com>,
        Hui Wang <hui.wang@canonical.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        Chris Chiu <chris.chiu@canonical.com>,
        Cameron Berkenpas <cam@neo-zeon.de>,
        Sami Loone <sami@loone.fi>, Elia Devito <eliadevito@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Jack Yu <jack.yu@realtek.com>, "Arnd Bergmann" <arnd@arndb.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        <alsa-devel@alsa-project.org>, <linux-acpi@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Lucas Tanure" <tanureal@opensource.cirrus.com>
Subject: [PATCH 03/11] ASoC: cs35l41: Move regmap config struct to shared code
Date:   Tue, 23 Nov 2021 16:31:41 +0000
Message-ID: <20211123163149.1530535-4-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211123163149.1530535-1-tanureal@opensource.cirrus.com>
References: <20211123163149.1530535-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: HuYSeoxxjjX_d7xNriX0mUm1QC7O0CGy
X-Proofpoint-ORIG-GUID: HuYSeoxxjjX_d7xNriX0mUm1QC7O0CGy
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Move regmap configs to external include so CS35L41 HDA
driver can re-use it.

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 include/sound/cs35l41.h        |  6 +++++-
 sound/soc/codecs/cs35l41-i2c.c | 15 ---------------
 sound/soc/codecs/cs35l41-lib.c | 34 ++++++++++++++++++++++++++++++++--
 sound/soc/codecs/cs35l41-spi.c | 16 ----------------
 sound/soc/codecs/cs35l41.h     |  6 ------
 5 files changed, 37 insertions(+), 40 deletions(-)

diff --git a/include/sound/cs35l41.h b/include/sound/cs35l41.h
index 4a5679c856a3..ced80ede1def 100644
--- a/include/sound/cs35l41.h
+++ b/include/sound/cs35l41.h
@@ -10,6 +10,8 @@
 #ifndef __CS35L41_H
 #define __CS35L41_H
 
+#include <linux/regmap.h>
+
 #define CS35L41_FIRSTREG		0x00000000
 #define CS35L41_LASTREG			0x03804FE8
 #define CS35L41_DEVID			0x00000000
@@ -529,7 +531,6 @@
 #define CS35L41_OTP_TRIM_35		0x0000400C
 #define CS35L41_OTP_TRIM_36		0x00002030
 
-#define CS35L41_MAX_CACHE_REG		36
 #define CS35L41_OTP_SIZE_WORDS		32
 #define CS35L41_NUM_OTP_ELEM		100
 #define CS35L41_NUM_OTP_MAPS		5
@@ -758,4 +759,7 @@ struct cs35l41_otp_map_element_t {
 	u32 word_offset;
 };
 
+extern struct regmap_config cs35l41_regmap_i2c;
+extern struct regmap_config cs35l41_regmap_spi;
+
 #endif /* __CS35L41_H */
diff --git a/sound/soc/codecs/cs35l41-i2c.c b/sound/soc/codecs/cs35l41-i2c.c
index db03fe519e2f..de5c8612f030 100644
--- a/sound/soc/codecs/cs35l41-i2c.c
+++ b/sound/soc/codecs/cs35l41-i2c.c
@@ -19,21 +19,6 @@
 
 #include "cs35l41.h"
 
-static struct regmap_config cs35l41_regmap_i2c = {
-	.reg_bits = 32,
-	.val_bits = 32,
-	.reg_stride = CS35L41_REGSTRIDE,
-	.reg_format_endian = REGMAP_ENDIAN_BIG,
-	.val_format_endian = REGMAP_ENDIAN_BIG,
-	.max_register = CS35L41_LASTREG,
-	.reg_defaults = cs35l41_reg,
-	.num_reg_defaults = ARRAY_SIZE(cs35l41_reg),
-	.volatile_reg = cs35l41_volatile_reg,
-	.readable_reg = cs35l41_readable_reg,
-	.precious_reg = cs35l41_precious_reg,
-	.cache_type = REGCACHE_RBTREE,
-};
-
 static const struct i2c_device_id cs35l41_id_i2c[] = {
 	{ "cs35l40", 0 },
 	{ "cs35l41", 0 },
diff --git a/sound/soc/codecs/cs35l41-lib.c b/sound/soc/codecs/cs35l41-lib.c
index f3071f235f7d..04f59cda5126 100644
--- a/sound/soc/codecs/cs35l41-lib.c
+++ b/sound/soc/codecs/cs35l41-lib.c
@@ -7,10 +7,9 @@
 // Author: David Rhodes <david.rhodes@cirrus.com>
 // Author: Lucas Tanure <lucas.tanure@cirrus.com>
 
-#include <linux/regmap.h>
 #include <sound/cs35l41.h>
 
-const struct reg_default cs35l41_reg[CS35L41_MAX_CACHE_REG] = {
+const struct reg_default cs35l41_reg[] = {
 	{ CS35L41_PWR_CTRL1,			0x00000000 },
 	{ CS35L41_PWR_CTRL3,			0x01000010 },
 	{ CS35L41_GPIO_PAD_CONTROL,		0x00000000 },
@@ -690,3 +689,34 @@ const struct cs35l41_otp_map_element_t cs35l41_otp_map_map[CS35L41_NUM_OTP_MAPS]
 		.word_offset = 2,
 	},
 };
+
+struct regmap_config cs35l41_regmap_i2c = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = CS35L41_REGSTRIDE,
+	.reg_format_endian = REGMAP_ENDIAN_BIG,
+	.val_format_endian = REGMAP_ENDIAN_BIG,
+	.max_register = CS35L41_LASTREG,
+	.reg_defaults = cs35l41_reg,
+	.num_reg_defaults = ARRAY_SIZE(cs35l41_reg),
+	.volatile_reg = cs35l41_volatile_reg,
+	.readable_reg = cs35l41_readable_reg,
+	.precious_reg = cs35l41_precious_reg,
+	.cache_type = REGCACHE_RBTREE,
+};
+
+struct regmap_config cs35l41_regmap_spi = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.pad_bits = 16,
+	.reg_stride = CS35L41_REGSTRIDE,
+	.reg_format_endian = REGMAP_ENDIAN_BIG,
+	.val_format_endian = REGMAP_ENDIAN_BIG,
+	.max_register = CS35L41_LASTREG,
+	.reg_defaults = cs35l41_reg,
+	.num_reg_defaults = ARRAY_SIZE(cs35l41_reg),
+	.volatile_reg = cs35l41_volatile_reg,
+	.readable_reg = cs35l41_readable_reg,
+	.precious_reg = cs35l41_precious_reg,
+	.cache_type = REGCACHE_RBTREE,
+};
diff --git a/sound/soc/codecs/cs35l41-spi.c b/sound/soc/codecs/cs35l41-spi.c
index 60639edcfc5d..c157153f28d8 100644
--- a/sound/soc/codecs/cs35l41-spi.c
+++ b/sound/soc/codecs/cs35l41-spi.c
@@ -17,22 +17,6 @@
 
 #include "cs35l41.h"
 
-static struct regmap_config cs35l41_regmap_spi = {
-	.reg_bits = 32,
-	.val_bits = 32,
-	.pad_bits = 16,
-	.reg_stride = CS35L41_REGSTRIDE,
-	.reg_format_endian = REGMAP_ENDIAN_BIG,
-	.val_format_endian = REGMAP_ENDIAN_BIG,
-	.max_register = CS35L41_LASTREG,
-	.reg_defaults = cs35l41_reg,
-	.num_reg_defaults = ARRAY_SIZE(cs35l41_reg),
-	.volatile_reg = cs35l41_volatile_reg,
-	.readable_reg = cs35l41_readable_reg,
-	.precious_reg = cs35l41_precious_reg,
-	.cache_type = REGCACHE_RBTREE,
-};
-
 static const struct spi_device_id cs35l41_id_spi[] = {
 	{ "cs35l40", 0 },
 	{ "cs35l41", 0 },
diff --git a/sound/soc/codecs/cs35l41.h b/sound/soc/codecs/cs35l41.h
index 74ef72d01190..453ece8889e0 100644
--- a/sound/soc/codecs/cs35l41.h
+++ b/sound/soc/codecs/cs35l41.h
@@ -11,7 +11,6 @@
 #define __CS35L41_H__
 
 #include <linux/gpio/consumer.h>
-#include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/firmware.h>
 #include <sound/core.h>
@@ -22,11 +21,6 @@
 #define CS35L41_RX_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE)
 #define CS35L41_TX_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE)
 
-bool cs35l41_readable_reg(struct device *dev, unsigned int reg);
-bool cs35l41_precious_reg(struct device *dev, unsigned int reg);
-bool cs35l41_volatile_reg(struct device *dev, unsigned int reg);
-
-extern const struct reg_default cs35l41_reg[CS35L41_MAX_CACHE_REG];
 extern const struct cs35l41_otp_map_element_t
 				cs35l41_otp_map_map[CS35L41_NUM_OTP_MAPS];
 
-- 
2.34.0

