Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 701C945A7C2
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Nov 2021 17:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbhKWQgB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Nov 2021 11:36:01 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:37908 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234907AbhKWQgA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 23 Nov 2021 11:36:00 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AN6Jv73020525;
        Tue, 23 Nov 2021 10:31:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=YfmJ3QFELq+ojijO+3GcBv66WJJ4ZeAGwfcy4dwVxqQ=;
 b=OjtN8j2bmrwOPsLAe5ct8muw4UVcKLvNgb/gDs5VKPTVkP+BgIb4CyM+TJDDOjt1y8tP
 zuZZZhzXR7kH4pr2U4Ol2hg+9qsmfrkFTo3H67o4zipCYdVogtk5ENlEVlEE57CXRhzN
 fC3F76nUU9h25jNMHX+EXWCmhE9Qz5Q67or8drIgZU535sdBxfgmxQuZrmh0xPJolT7I
 mPtunpOrLqteyuNd1aWujFjWFLQq/1cil+UA/KRqe4xNrK8AQwCXQokKxPnYFEttw/71
 UMZ9pMH4zPIOUDRaSZvzyG/vNTovl7G4crHu7kS6CAEQn76ezsTRbUSzwJE9QKw1WJnc AQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3cg5ms21nk-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 23 Nov 2021 10:31:57 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 23 Nov
 2021 16:31:55 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 23 Nov 2021 16:31:55 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.11])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 60FDB2A3;
        Tue, 23 Nov 2021 16:31:54 +0000 (UTC)
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
Subject: [PATCH 05/11] ASoC: cs35l41: Move cs35l41_otp_unpack to shared code
Date:   Tue, 23 Nov 2021 16:31:43 +0000
Message-ID: <20211123163149.1530535-6-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211123163149.1530535-1-tanureal@opensource.cirrus.com>
References: <20211123163149.1530535-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: TP07YcWZmvvoAVfCVZAmRsi8Q2s7FAFU
X-Proofpoint-ORIG-GUID: TP07YcWZmvvoAVfCVZAmRsi8Q2s7FAFU
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ASoC and HDA will do the same cs35l41_otp_unpack, so move it
to shared code

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 include/sound/cs35l41.h        |   1 +
 sound/soc/codecs/cs35l41-lib.c | 116 ++++++++++++++++++++++++++++++
 sound/soc/codecs/cs35l41.c     | 125 +--------------------------------
 sound/soc/codecs/cs35l41.h     |   3 -
 4 files changed, 118 insertions(+), 127 deletions(-)

diff --git a/include/sound/cs35l41.h b/include/sound/cs35l41.h
index 5039e876bad1..9241173740cc 100644
--- a/include/sound/cs35l41.h
+++ b/include/sound/cs35l41.h
@@ -764,5 +764,6 @@ extern struct regmap_config cs35l41_regmap_i2c;
 extern struct regmap_config cs35l41_regmap_spi;
 
 int cs35l41_init_supplies(struct device *dev, struct regulator_bulk_data *supplies);
+int cs35l41_otp_unpack(struct device *dev, struct regmap *regmap);
 
 #endif /* __CS35L41_H */
diff --git a/sound/soc/codecs/cs35l41-lib.c b/sound/soc/codecs/cs35l41-lib.c
index 4aba0f90b876..a13c5313f4e5 100644
--- a/sound/soc/codecs/cs35l41-lib.c
+++ b/sound/soc/codecs/cs35l41-lib.c
@@ -7,6 +7,8 @@
 // Author: David Rhodes <david.rhodes@cirrus.com>
 // Author: Lucas Tanure <lucas.tanure@cirrus.com>
 
+#include <linux/slab.h>
+#include <linux/dev_printk.h>
 #include <linux/regulator/consumer.h>
 #include <sound/cs35l41.h>
 
@@ -749,3 +751,117 @@ int cs35l41_init_supplies(struct device *dev, struct regulator_bulk_data *suppli
 	return 0;
 }
 
+static const struct cs35l41_otp_map_element_t *cs35l41_find_otp_map(u32 otp_id)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(cs35l41_otp_map_map); i++) {
+		if (cs35l41_otp_map_map[i].id == otp_id)
+			return &cs35l41_otp_map_map[i];
+	}
+
+	return NULL;
+}
+
+int cs35l41_otp_unpack(struct device *dev, struct regmap *regmap)
+{
+	const struct cs35l41_otp_map_element_t *otp_map_match;
+	const struct cs35l41_otp_packed_element_t *otp_map;
+	int bit_offset, word_offset, ret, i;
+	unsigned int bit_sum = 8;
+	u32 otp_val, otp_id_reg;
+	u32 *otp_mem;
+
+	otp_mem = kmalloc_array(CS35L41_OTP_SIZE_WORDS, sizeof(*otp_mem), GFP_KERNEL);
+	if (!otp_mem)
+		return -ENOMEM;
+
+	ret = regmap_read(regmap, CS35L41_OTPID, &otp_id_reg);
+	if (ret) {
+		dev_err(dev, "Read OTP ID failed: %d\n", ret);
+		goto err_otp_unpack;
+	}
+
+	otp_map_match = cs35l41_find_otp_map(otp_id_reg);
+
+	if (!otp_map_match) {
+		dev_err(dev, "OTP Map matching ID %d not found\n", otp_id_reg);
+		ret = -EINVAL;
+		goto err_otp_unpack;
+	}
+
+	ret = regmap_bulk_read(regmap, CS35L41_OTP_MEM0, otp_mem, CS35L41_OTP_SIZE_WORDS);
+	if (ret) {
+		dev_err(dev, "Read OTP Mem failed: %d\n", ret);
+		goto err_otp_unpack;
+	}
+
+	otp_map = otp_map_match->map;
+
+	bit_offset = otp_map_match->bit_offset;
+	word_offset = otp_map_match->word_offset;
+
+	ret = regmap_write(regmap, CS35L41_TEST_KEY_CTL, 0x00000055);
+	if (ret) {
+		dev_err(dev, "Write Unlock key failed 1/2: %d\n", ret);
+		goto err_otp_unpack;
+	}
+	ret = regmap_write(regmap, CS35L41_TEST_KEY_CTL, 0x000000AA);
+	if (ret) {
+		dev_err(dev, "Write Unlock key failed 2/2: %d\n", ret);
+		goto err_otp_unpack;
+	}
+
+	for (i = 0; i < otp_map_match->num_elements; i++) {
+		dev_dbg(dev, "bitoffset= %d, word_offset=%d, bit_sum mod 32=%d\n",
+			bit_offset, word_offset, bit_sum % 32);
+		if (bit_offset + otp_map[i].size - 1 >= 32) {
+			otp_val = (otp_mem[word_offset] &
+					GENMASK(31, bit_offset)) >> bit_offset;
+			otp_val |= (otp_mem[++word_offset] &
+					GENMASK(bit_offset + otp_map[i].size - 33, 0)) <<
+					(32 - bit_offset);
+			bit_offset += otp_map[i].size - 32;
+		} else {
+			otp_val = (otp_mem[word_offset] &
+				   GENMASK(bit_offset + otp_map[i].size - 1, bit_offset)
+				  ) >> bit_offset;
+			bit_offset += otp_map[i].size;
+		}
+		bit_sum += otp_map[i].size;
+
+		if (bit_offset == 32) {
+			bit_offset = 0;
+			word_offset++;
+		}
+
+		if (otp_map[i].reg != 0) {
+			ret = regmap_update_bits(regmap, otp_map[i].reg,
+						 GENMASK(otp_map[i].shift + otp_map[i].size - 1,
+							 otp_map[i].shift),
+						 otp_val << otp_map[i].shift);
+			if (ret < 0) {
+				dev_err(dev, "Write OTP val failed: %d\n", ret);
+				goto err_otp_unpack;
+			}
+		}
+	}
+
+	ret = regmap_write(regmap, CS35L41_TEST_KEY_CTL, 0x000000CC);
+	if (ret) {
+		dev_err(dev, "Write Lock key failed 1/2: %d\n", ret);
+		goto err_otp_unpack;
+	}
+	ret = regmap_write(regmap, CS35L41_TEST_KEY_CTL, 0x00000033);
+	if (ret) {
+		dev_err(dev, "Write Lock key failed 2/2: %d\n", ret);
+		goto err_otp_unpack;
+	}
+	ret = 0;
+
+err_otp_unpack:
+	kfree(otp_mem);
+
+	return ret;
+}
+
diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index c8709de41aaf..0a88c2f164d1 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -14,7 +14,6 @@
 #include <linux/moduleparam.h>
 #include <linux/of_device.h>
 #include <linux/property.h>
-#include <linux/slab.h>
 #include <sound/initval.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -415,128 +414,6 @@ static const struct snd_kcontrol_new cs35l41_aud_controls[] = {
 	WM_ADSP_FW_CONTROL("DSP1", 0),
 };
 
-static const struct cs35l41_otp_map_element_t *cs35l41_find_otp_map(u32 otp_id)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(cs35l41_otp_map_map); i++) {
-		if (cs35l41_otp_map_map[i].id == otp_id)
-			return &cs35l41_otp_map_map[i];
-	}
-
-	return NULL;
-}
-
-static int cs35l41_otp_unpack(void *data)
-{
-	const struct cs35l41_otp_map_element_t *otp_map_match;
-	const struct cs35l41_otp_packed_element_t *otp_map;
-	struct cs35l41_private *cs35l41 = data;
-	int bit_offset, word_offset, ret, i;
-	unsigned int bit_sum = 8;
-	u32 otp_val, otp_id_reg;
-	u32 *otp_mem;
-
-	otp_mem = kmalloc_array(CS35L41_OTP_SIZE_WORDS, sizeof(*otp_mem), GFP_KERNEL);
-	if (!otp_mem)
-		return -ENOMEM;
-
-	ret = regmap_read(cs35l41->regmap, CS35L41_OTPID, &otp_id_reg);
-	if (ret < 0) {
-		dev_err(cs35l41->dev, "Read OTP ID failed: %d\n", ret);
-		goto err_otp_unpack;
-	}
-
-	otp_map_match = cs35l41_find_otp_map(otp_id_reg);
-
-	if (!otp_map_match) {
-		dev_err(cs35l41->dev, "OTP Map matching ID %d not found\n",
-			otp_id_reg);
-		ret = -EINVAL;
-		goto err_otp_unpack;
-	}
-
-	ret = regmap_bulk_read(cs35l41->regmap, CS35L41_OTP_MEM0, otp_mem,
-			       CS35L41_OTP_SIZE_WORDS);
-	if (ret < 0) {
-		dev_err(cs35l41->dev, "Read OTP Mem failed: %d\n", ret);
-		goto err_otp_unpack;
-	}
-
-	otp_map = otp_map_match->map;
-
-	bit_offset = otp_map_match->bit_offset;
-	word_offset = otp_map_match->word_offset;
-
-	ret = regmap_write(cs35l41->regmap, CS35L41_TEST_KEY_CTL, 0x00000055);
-	if (ret < 0) {
-		dev_err(cs35l41->dev, "Write Unlock key failed 1/2: %d\n", ret);
-		goto err_otp_unpack;
-	}
-	ret = regmap_write(cs35l41->regmap, CS35L41_TEST_KEY_CTL, 0x000000AA);
-	if (ret < 0) {
-		dev_err(cs35l41->dev, "Write Unlock key failed 2/2: %d\n", ret);
-		goto err_otp_unpack;
-	}
-
-	for (i = 0; i < otp_map_match->num_elements; i++) {
-		dev_dbg(cs35l41->dev,
-			"bitoffset= %d, word_offset=%d, bit_sum mod 32=%d\n",
-			bit_offset, word_offset, bit_sum % 32);
-		if (bit_offset + otp_map[i].size - 1 >= 32) {
-			otp_val = (otp_mem[word_offset] &
-					GENMASK(31, bit_offset)) >>
-					bit_offset;
-			otp_val |= (otp_mem[++word_offset] &
-					GENMASK(bit_offset +
-						otp_map[i].size - 33, 0)) <<
-					(32 - bit_offset);
-			bit_offset += otp_map[i].size - 32;
-		} else {
-			otp_val = (otp_mem[word_offset] &
-				GENMASK(bit_offset + otp_map[i].size - 1,
-					bit_offset)) >>	bit_offset;
-			bit_offset += otp_map[i].size;
-		}
-		bit_sum += otp_map[i].size;
-
-		if (bit_offset == 32) {
-			bit_offset = 0;
-			word_offset++;
-		}
-
-		if (otp_map[i].reg != 0) {
-			ret = regmap_update_bits(cs35l41->regmap,
-						 otp_map[i].reg,
-						 GENMASK(otp_map[i].shift +
-							 otp_map[i].size - 1,
-						 otp_map[i].shift),
-						 otp_val << otp_map[i].shift);
-			if (ret < 0) {
-				dev_err(cs35l41->dev, "Write OTP val failed: %d\n",
-					ret);
-				goto err_otp_unpack;
-			}
-		}
-	}
-
-	ret = regmap_write(cs35l41->regmap, CS35L41_TEST_KEY_CTL, 0x000000CC);
-	if (ret < 0) {
-		dev_err(cs35l41->dev, "Write Lock key failed 1/2: %d\n", ret);
-		goto err_otp_unpack;
-	}
-	ret = regmap_write(cs35l41->regmap, CS35L41_TEST_KEY_CTL, 0x00000033);
-	if (ret < 0) {
-		dev_err(cs35l41->dev, "Write Lock key failed 2/2: %d\n", ret);
-		goto err_otp_unpack;
-	}
-	ret = 0;
-
-err_otp_unpack:
-	kfree(otp_mem);
-	return ret;
-}
-
 static irqreturn_t cs35l41_irq(int irq, void *data)
 {
 	struct cs35l41_private *cs35l41 = data;
@@ -1650,7 +1527,7 @@ int cs35l41_probe(struct cs35l41_private *cs35l41,
 		goto err;
 	}
 
-	ret = cs35l41_otp_unpack(cs35l41);
+	ret = cs35l41_otp_unpack(cs35l41->dev, cs35l41->regmap);
 	if (ret < 0) {
 		dev_err(cs35l41->dev, "OTP Unpack failed: %d\n", ret);
 		goto err;
diff --git a/sound/soc/codecs/cs35l41.h b/sound/soc/codecs/cs35l41.h
index 453ece8889e0..26a08d58a8c3 100644
--- a/sound/soc/codecs/cs35l41.h
+++ b/sound/soc/codecs/cs35l41.h
@@ -21,9 +21,6 @@
 #define CS35L41_RX_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE)
 #define CS35L41_TX_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE)
 
-extern const struct cs35l41_otp_map_element_t
-				cs35l41_otp_map_map[CS35L41_NUM_OTP_MAPS];
-
 enum cs35l41_cspl_mbox_status {
 	CSPL_MBOX_STS_RUNNING = 0,
 	CSPL_MBOX_STS_PAUSED = 1,
-- 
2.34.0

