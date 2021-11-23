Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B73E45A7D6
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Nov 2021 17:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237796AbhKWQge (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Nov 2021 11:36:34 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:54230 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237840AbhKWQgY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 23 Nov 2021 11:36:24 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AN7k0BC013868;
        Tue, 23 Nov 2021 10:32:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=ATn3v5FpDaLdr5ZeC+/nTRw9PYiV4Lv2gQEjGJ7czWI=;
 b=mBzqTLJDKTVBPjfb9a4WI/MiWBGfbrQz+OjQcQFgeGUQBveDMXpmBfxRZpcFOdTbTThD
 Vpo7tLnw4IJQnsmmycRgDAZNQCYJqsIbE+2iZroN/Pg50oRwtp85OOhfqRBy4wDS3qhL
 tORbtmBsTguEGDHv/WxfvRwtOdn9HeJ9AmRyM5vnVRU9UCpEFewbIRaejuEI850xZmPw
 iPOlyQc3c5hRI1ayRboOCKXFU40AkVR9XAkJqfore6FEBLr2MdCnyJm8H5PcTSt4QXs3
 qesJlNygBxBovmx0duzdWUDfBkUogxamm0wdAmm7pFsZ3rGDxKubdJL5WQVpVzOCEkf0 mA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3cg3v7a220-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 23 Nov 2021 10:31:59 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 23 Nov
 2021 16:31:57 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 23 Nov 2021 16:31:57 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.11])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 722922A1;
        Tue, 23 Nov 2021 16:31:56 +0000 (UTC)
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
Subject: [PATCH 08/11] ASoC: cs35l41: Create shared function for setting channels
Date:   Tue, 23 Nov 2021 16:31:46 +0000
Message-ID: <20211123163149.1530535-9-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211123163149.1530535-1-tanureal@opensource.cirrus.com>
References: <20211123163149.1530535-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: YvymC5K6L6g4PSNiPa0k72Ok9bN1h3kx
X-Proofpoint-ORIG-GUID: YvymC5K6L6g4PSNiPa0k72Ok9bN1h3kx
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ASoC and HDA will use the same register to set channels
for the device

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 include/sound/cs35l41.h        |  3 +++
 sound/soc/codecs/cs35l41-lib.c | 32 ++++++++++++++++++++++++++++++++
 sound/soc/codecs/cs35l41.c     | 30 +++---------------------------
 3 files changed, 38 insertions(+), 27 deletions(-)

diff --git a/include/sound/cs35l41.h b/include/sound/cs35l41.h
index e33bc0ed502d..219f23f643a6 100644
--- a/include/sound/cs35l41.h
+++ b/include/sound/cs35l41.h
@@ -766,5 +766,8 @@ extern struct regmap_config cs35l41_regmap_spi;
 int cs35l41_init_supplies(struct device *dev, struct regulator_bulk_data *supplies);
 int cs35l41_otp_unpack(struct device *dev, struct regmap *regmap);
 int cs35l41_register_errata_patch(struct device *dev, struct regmap *reg, unsigned int reg_revid);
+int cs35l41_set_channels(struct device *dev, struct regmap *reg,
+			 unsigned int tx_num, unsigned int *tx_slot,
+			 unsigned int rx_num, unsigned int *rx_slot);
 
 #endif /* __CS35L41_H */
diff --git a/sound/soc/codecs/cs35l41-lib.c b/sound/soc/codecs/cs35l41-lib.c
index b7a6dbf7fb8b..5bb733bb02a0 100644
--- a/sound/soc/codecs/cs35l41-lib.c
+++ b/sound/soc/codecs/cs35l41-lib.c
@@ -951,3 +951,35 @@ int cs35l41_register_errata_patch(struct device *dev, struct regmap *reg, unsign
 
 	return ret;
 }
+
+int cs35l41_set_channels(struct device *dev, struct regmap *reg,
+			 unsigned int tx_num, unsigned int *tx_slot,
+			 unsigned int rx_num, unsigned int *rx_slot)
+{
+	unsigned int val, mask;
+	int i;
+
+	if (tx_num > 4 || rx_num > 2)
+		return -EINVAL;
+
+	val = 0;
+	mask = 0;
+	for (i = 0; i < rx_num; i++) {
+		dev_dbg(dev, "rx slot %d position = %d\n", i, rx_slot[i]);
+		val |= rx_slot[i] << (i * 8);
+		mask |= 0x3F << (i * 8);
+	}
+	regmap_update_bits(reg, CS35L41_SP_FRAME_RX_SLOT, mask, val);
+
+	val = 0;
+	mask = 0;
+	for (i = 0; i < tx_num; i++) {
+		dev_dbg(dev, "tx slot %d position = %d\n", i, tx_slot[i]);
+		val |= tx_slot[i] << (i * 8);
+		mask |= 0x3F << (i * 8);
+	}
+	regmap_update_bits(reg, CS35L41_SP_FRAME_TX_SLOT, mask, val);
+
+	return 0;
+}
+
diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index b1202ac9f264..e61736daef62 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -746,36 +746,12 @@ static const struct cs_dsp_region cs35l41_dsp1_regions[] = {
 	{. type = WMFW_ADSP2_YM,	.base = CS35L41_DSP1_YMEM_UNPACK24_0},
 };
 
-static int cs35l41_set_channel_map(struct snd_soc_dai *dai, unsigned int tx_num,
-				   unsigned int *tx_slot, unsigned int rx_num,
-				   unsigned int *rx_slot)
+static int cs35l41_set_channel_map(struct snd_soc_dai *dai, unsigned int tx_n,
+				   unsigned int *tx_slot, unsigned int rx_n, unsigned int *rx_slot)
 {
 	struct cs35l41_private *cs35l41 = snd_soc_component_get_drvdata(dai->component);
-	unsigned int val, mask;
-	int i;
-
-	if (tx_num > 4 || rx_num > 2)
-		return -EINVAL;
 
-	val = 0;
-	mask = 0;
-	for (i = 0; i < rx_num; i++) {
-		dev_dbg(cs35l41->dev, "rx slot %d position = %d\n", i, rx_slot[i]);
-		val |= rx_slot[i] << (i * 8);
-		mask |= 0x3F << (i * 8);
-	}
-	regmap_update_bits(cs35l41->regmap, CS35L41_SP_FRAME_RX_SLOT, mask, val);
-
-	val = 0;
-	mask = 0;
-	for (i = 0; i < tx_num; i++) {
-		dev_dbg(cs35l41->dev, "tx slot %d position = %d\n", i, tx_slot[i]);
-		val |= tx_slot[i] << (i * 8);
-		mask |= 0x3F << (i * 8);
-	}
-	regmap_update_bits(cs35l41->regmap, CS35L41_SP_FRAME_TX_SLOT, mask, val);
-
-	return 0;
+	return cs35l41_set_channels(cs35l41->dev, cs35l41->regmap, tx_n, tx_slot, rx_n, rx_slot);
 }
 
 static int cs35l41_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
-- 
2.34.0

