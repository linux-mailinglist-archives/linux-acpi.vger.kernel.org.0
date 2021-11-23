Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15CA745A7C5
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Nov 2021 17:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235424AbhKWQgC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Nov 2021 11:36:02 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:56658 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234281AbhKWQgA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 23 Nov 2021 11:36:00 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AN6Jv75020525;
        Tue, 23 Nov 2021 10:31:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=EHfuPo5/LBb3ZUd8ZhOZE1mXuciPBoF9gIOwA/Yvyyg=;
 b=JcWSzlv8RHV+NlSMhMaqw8FKqfncV6Ewg0B6IorkMDyK/jv5ymdi2g8jIaTMJksazk2N
 bOlq12XkP+AR6eNRrmWnQ4gW2hBoIf60NK2KYS+hiZFfGLPHJmrhKMFnwEmEa1Grx6F0
 8LArbJoHI0rZaWpV1MuPJCvXTM1BiZdlgNmThYc6sfU3xONE4abQfP3mNO6ZAtzVmbtJ
 pwqf0DhtrGwyHjuGEOvfPhC6xa3+bD+3IxGU26i3ltyQA2Q7u1s1qRfJ1WG5JSjipJYQ
 /KKBsaWmGK7KlA83+jVhAN/ePxlT6PrkvPxOzP8AYP17p5yNLgFx7RTZgrNrcmLmfxx1 9A== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3cg5ms21nk-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 23 Nov 2021 10:31:59 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 23 Nov
 2021 16:31:57 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 23 Nov 2021 16:31:57 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.11])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2B3F82A3;
        Tue, 23 Nov 2021 16:31:57 +0000 (UTC)
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
Subject: [PATCH 09/11] ASoC: cs35l41: Create shared function for boost configuration
Date:   Tue, 23 Nov 2021 16:31:47 +0000
Message-ID: <20211123163149.1530535-10-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211123163149.1530535-1-tanureal@opensource.cirrus.com>
References: <20211123163149.1530535-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: tLMBPh9Pd-dU3BhK7bpeDMVLb8kIPSd7
X-Proofpoint-ORIG-GUID: tLMBPh9Pd-dU3BhK7bpeDMVLb8kIPSd7
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ASoC and HDA will use the same registers to configure
internal boost for the device

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 include/sound/cs35l41.h        |   2 +
 sound/soc/codecs/cs35l41-lib.c |  97 ++++++++++++++++++++++++++++++
 sound/soc/codecs/cs35l41.c     | 105 +--------------------------------
 3 files changed, 101 insertions(+), 103 deletions(-)

diff --git a/include/sound/cs35l41.h b/include/sound/cs35l41.h
index 219f23f643a6..c80ede66f297 100644
--- a/include/sound/cs35l41.h
+++ b/include/sound/cs35l41.h
@@ -769,5 +769,7 @@ int cs35l41_register_errata_patch(struct device *dev, struct regmap *reg, unsign
 int cs35l41_set_channels(struct device *dev, struct regmap *reg,
 			 unsigned int tx_num, unsigned int *tx_slot,
 			 unsigned int rx_num, unsigned int *rx_slot);
+int cs35l41_boost_config(struct device *dev, struct regmap *regmap, int boost_ind, int boost_cap,
+			 int boost_ipk);
 
 #endif /* __CS35L41_H */
diff --git a/sound/soc/codecs/cs35l41-lib.c b/sound/soc/codecs/cs35l41-lib.c
index 5bb733bb02a0..b582e8214c86 100644
--- a/sound/soc/codecs/cs35l41-lib.c
+++ b/sound/soc/codecs/cs35l41-lib.c
@@ -983,3 +983,100 @@ int cs35l41_set_channels(struct device *dev, struct regmap *reg,
 	return 0;
 }
 
+static const unsigned char cs35l41_bst_k1_table[4][5] = {
+	{ 0x24, 0x32, 0x32, 0x4F, 0x57 },
+	{ 0x24, 0x32, 0x32, 0x4F, 0x57 },
+	{ 0x40, 0x32, 0x32, 0x4F, 0x57 },
+	{ 0x40, 0x32, 0x32, 0x4F, 0x57 }
+};
+
+static const unsigned char cs35l41_bst_k2_table[4][5] = {
+	{ 0x24, 0x49, 0x66, 0xA3, 0xEA },
+	{ 0x24, 0x49, 0x66, 0xA3, 0xEA },
+	{ 0x48, 0x49, 0x66, 0xA3, 0xEA },
+	{ 0x48, 0x49, 0x66, 0xA3, 0xEA }
+};
+
+static const unsigned char cs35l41_bst_slope_table[4] = {
+	0x75, 0x6B, 0x3B, 0x28
+};
+
+
+int cs35l41_boost_config(struct device *dev, struct regmap *regmap, int boost_ind, int boost_cap,
+			 int boost_ipk)
+{
+	unsigned char bst_lbst_val, bst_cbst_range, bst_ipk_scaled;
+	int ret;
+
+	switch (boost_ind) {
+	case 1000:	/* 1.0 uH */
+		bst_lbst_val = 0;
+		break;
+	case 1200:	/* 1.2 uH */
+		bst_lbst_val = 1;
+		break;
+	case 1500:	/* 1.5 uH */
+		bst_lbst_val = 2;
+		break;
+	case 2200:	/* 2.2 uH */
+		bst_lbst_val = 3;
+		break;
+	default:
+		dev_err(dev, "Invalid boost inductor value: %d nH\n", boost_ind);
+		return -EINVAL;
+	}
+
+	switch (boost_cap) {
+	case 0 ... 19:
+		bst_cbst_range = 0;
+		break;
+	case 20 ... 50:
+		bst_cbst_range = 1;
+		break;
+	case 51 ... 100:
+		bst_cbst_range = 2;
+		break;
+	case 101 ... 200:
+		bst_cbst_range = 3;
+		break;
+	default:	/* 201 uF and greater */
+		bst_cbst_range = 4;
+	}
+
+	ret = regmap_update_bits(regmap, CS35L41_BSTCVRT_COEFF,
+				 CS35L41_BST_K1_MASK | CS35L41_BST_K2_MASK,
+				 cs35l41_bst_k1_table[bst_lbst_val][bst_cbst_range]
+					<< CS35L41_BST_K1_SHIFT |
+				 cs35l41_bst_k2_table[bst_lbst_val][bst_cbst_range]
+					<< CS35L41_BST_K2_SHIFT);
+	if (ret) {
+		dev_err(dev, "Failed to write boost coefficients: %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_update_bits(regmap, CS35L41_BSTCVRT_SLOPE_LBST,
+				 CS35L41_BST_SLOPE_MASK | CS35L41_BST_LBST_VAL_MASK,
+				 cs35l41_bst_slope_table[bst_lbst_val]
+					<< CS35L41_BST_SLOPE_SHIFT |
+				 bst_lbst_val << CS35L41_BST_LBST_VAL_SHIFT);
+	if (ret) {
+		dev_err(dev, "Failed to write boost slope/inductor value: %d\n", ret);
+		return ret;
+	}
+
+	if (boost_ipk < 1600 || boost_ipk > 4500) {
+		dev_err(dev, "Invalid boost inductor peak current: %d mA\n", boost_ipk);
+		return -EINVAL;
+	}
+	bst_ipk_scaled = ((boost_ipk - 1600) / 50) + 0x10;
+
+	ret = regmap_update_bits(regmap, CS35L41_BSTCVRT_PEAK_CUR, CS35L41_BST_IPK_MASK,
+				 bst_ipk_scaled << CS35L41_BST_IPK_SHIFT);
+	if (ret) {
+		dev_err(dev, "Failed to write boost inductor peak current: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index e61736daef62..99a70e9bb8e8 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -145,24 +145,6 @@ static const struct cs35l41_fs_mon_config cs35l41_fs_mon[] = {
 	{ 6144000,	16,	24 },
 };
 
-static const unsigned char cs35l41_bst_k1_table[4][5] = {
-	{ 0x24, 0x32, 0x32, 0x4F, 0x57 },
-	{ 0x24, 0x32, 0x32, 0x4F, 0x57 },
-	{ 0x40, 0x32, 0x32, 0x4F, 0x57 },
-	{ 0x40, 0x32, 0x32, 0x4F, 0x57 }
-};
-
-static const unsigned char cs35l41_bst_k2_table[4][5] = {
-	{ 0x24, 0x49, 0x66, 0xA3, 0xEA },
-	{ 0x24, 0x49, 0x66, 0xA3, 0xEA },
-	{ 0x48, 0x49, 0x66, 0xA3, 0xEA },
-	{ 0x48, 0x49, 0x66, 0xA3, 0xEA }
-};
-
-static const unsigned char cs35l41_bst_slope_table[4] = {
-	0x75, 0x6B, 0x3B, 0x28
-};
-
 static int cs35l41_get_fs_mon_config_index(int freq)
 {
 	int i;
@@ -987,88 +969,6 @@ static int cs35l41_dai_set_sysclk(struct snd_soc_dai *dai,
 	return 0;
 }
 
-static int cs35l41_boost_config(struct cs35l41_private *cs35l41,
-				int boost_ind, int boost_cap, int boost_ipk)
-{
-	unsigned char bst_lbst_val, bst_cbst_range, bst_ipk_scaled;
-	struct regmap *regmap = cs35l41->regmap;
-	struct device *dev = cs35l41->dev;
-	int ret;
-
-	switch (boost_ind) {
-	case 1000:	/* 1.0 uH */
-		bst_lbst_val = 0;
-		break;
-	case 1200:	/* 1.2 uH */
-		bst_lbst_val = 1;
-		break;
-	case 1500:	/* 1.5 uH */
-		bst_lbst_val = 2;
-		break;
-	case 2200:	/* 2.2 uH */
-		bst_lbst_val = 3;
-		break;
-	default:
-		dev_err(dev, "Invalid boost inductor value: %d nH\n", boost_ind);
-		return -EINVAL;
-	}
-
-	switch (boost_cap) {
-	case 0 ... 19:
-		bst_cbst_range = 0;
-		break;
-	case 20 ... 50:
-		bst_cbst_range = 1;
-		break;
-	case 51 ... 100:
-		bst_cbst_range = 2;
-		break;
-	case 101 ... 200:
-		bst_cbst_range = 3;
-		break;
-	default:	/* 201 uF and greater */
-		bst_cbst_range = 4;
-	}
-
-	ret = regmap_update_bits(regmap, CS35L41_BSTCVRT_COEFF,
-				 CS35L41_BST_K1_MASK | CS35L41_BST_K2_MASK,
-				 cs35l41_bst_k1_table[bst_lbst_val][bst_cbst_range]
-					<< CS35L41_BST_K1_SHIFT |
-				 cs35l41_bst_k2_table[bst_lbst_val][bst_cbst_range]
-					<< CS35L41_BST_K2_SHIFT);
-	if (ret) {
-		dev_err(dev, "Failed to write boost coefficients: %d\n", ret);
-		return ret;
-	}
-
-	ret = regmap_update_bits(regmap, CS35L41_BSTCVRT_SLOPE_LBST,
-				 CS35L41_BST_SLOPE_MASK | CS35L41_BST_LBST_VAL_MASK,
-				 cs35l41_bst_slope_table[bst_lbst_val]
-					<< CS35L41_BST_SLOPE_SHIFT |
-				 bst_lbst_val << CS35L41_BST_LBST_VAL_SHIFT);
-	if (ret) {
-		dev_err(dev, "Failed to write boost slope/inductor value: %d\n", ret);
-		return ret;
-	}
-
-	if (boost_ipk < 1600 || boost_ipk > 4500) {
-		dev_err(dev, "Invalid boost inductor peak current: %d mA\n",
-			boost_ipk);
-		return -EINVAL;
-	}
-	bst_ipk_scaled = ((boost_ipk - 1600) / 50) + 0x10;
-
-	ret = regmap_update_bits(regmap, CS35L41_BSTCVRT_PEAK_CUR,
-				 CS35L41_BST_IPK_MASK,
-				 bst_ipk_scaled << CS35L41_BST_IPK_SHIFT);
-	if (ret) {
-		dev_err(dev, "Failed to write boost inductor peak current: %d\n", ret);
-		return ret;
-	}
-
-	return 0;
-}
-
 static int cs35l41_set_pdata(struct cs35l41_private *cs35l41)
 {
 	int ret;
@@ -1077,9 +977,8 @@ static int cs35l41_set_pdata(struct cs35l41_private *cs35l41)
 	/* Required */
 	if (cs35l41->pdata.bst_ipk &&
 	    cs35l41->pdata.bst_ind && cs35l41->pdata.bst_cap) {
-		ret = cs35l41_boost_config(cs35l41, cs35l41->pdata.bst_ind,
-					   cs35l41->pdata.bst_cap,
-					   cs35l41->pdata.bst_ipk);
+		ret = cs35l41_boost_config(cs35l41->dev, cs35l41->regmap, cs35l41->pdata.bst_ind,
+					   cs35l41->pdata.bst_cap, cs35l41->pdata.bst_ipk);
 		if (ret) {
 			dev_err(cs35l41->dev, "Error in Boost DT config: %d\n", ret);
 			return ret;
-- 
2.34.0

