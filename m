Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3014345A7DC
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Nov 2021 17:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238937AbhKWQgt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Nov 2021 11:36:49 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:11550 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229719AbhKWQg0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 23 Nov 2021 11:36:26 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AN6Jv74020525;
        Tue, 23 Nov 2021 10:31:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=VB0WVtclKyWX/z639ZvIPonFq9Yl/h3KL1GIU4M7gJU=;
 b=RhhviHRW2BeBJtDUizt73Cn/tK1rtKpif71/pFRsg6ZKKU11Ii/PtRk0MAePT+9wnh4C
 ZvQGg5zPmjQ01EecRKqcKEZWqHlB3ieGQBmOFrActvFuCgxeRdwU3RSb4tCFlv9ZoLiN
 EGrDxZTm87ICBQ1Xco4T09hvPrwJyCXzDUdX8r9DVtld6GeYS6c6QoagLZAHTg348SZg
 7SWvQkO7EQ0zxlANOLcKOj5AFL979Q4ls5rLlGT60mehcIWFvXMYW1xlkWK44Ja/HRCg
 mKx2EybqT5TZlDHGonjqKZM/XqdJKnIrLbh++Iz44AwcFJSLo9cd+8W6axxtm+slHf+p wA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3cg5ms21nk-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 23 Nov 2021 10:31:58 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 23 Nov
 2021 16:31:56 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 23 Nov 2021 16:31:56 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.11])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id BE46A2A3;
        Tue, 23 Nov 2021 16:31:55 +0000 (UTC)
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
Subject: [PATCH 07/11] ASoC: cs35l41: Create shared function for errata patches
Date:   Tue, 23 Nov 2021 16:31:45 +0000
Message-ID: <20211123163149.1530535-8-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211123163149.1530535-1-tanureal@opensource.cirrus.com>
References: <20211123163149.1530535-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: So9lURRzDGxtGmVvSvac1Dt1FAjuTwBx
X-Proofpoint-ORIG-GUID: So9lURRzDGxtGmVvSvac1Dt1FAjuTwBx
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ASoC and HDA systems require the same errata patches, so
move it to the shared code using a function the correctly
applies the patches by revision

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 include/sound/cs35l41.h        |  1 +
 sound/soc/codecs/cs35l41-lib.c | 86 ++++++++++++++++++++++++++++++++
 sound/soc/codecs/cs35l41.c     | 89 ++--------------------------------
 3 files changed, 90 insertions(+), 86 deletions(-)

diff --git a/include/sound/cs35l41.h b/include/sound/cs35l41.h
index 9241173740cc..e33bc0ed502d 100644
--- a/include/sound/cs35l41.h
+++ b/include/sound/cs35l41.h
@@ -765,5 +765,6 @@ extern struct regmap_config cs35l41_regmap_spi;
 
 int cs35l41_init_supplies(struct device *dev, struct regulator_bulk_data *supplies);
 int cs35l41_otp_unpack(struct device *dev, struct regmap *regmap);
+int cs35l41_register_errata_patch(struct device *dev, struct regmap *reg, unsigned int reg_revid);
 
 #endif /* __CS35L41_H */
diff --git a/sound/soc/codecs/cs35l41-lib.c b/sound/soc/codecs/cs35l41-lib.c
index cd9be6fbf910..b7a6dbf7fb8b 100644
--- a/sound/soc/codecs/cs35l41-lib.c
+++ b/sound/soc/codecs/cs35l41-lib.c
@@ -655,6 +655,60 @@ static const struct cs35l41_otp_packed_element_t otp_map_2[CS35L41_NUM_OTP_ELEM]
 	{ 0x00017044,	0,	24 }, /*LOT_NUMBER*/
 };
 
+static const struct reg_sequence cs35l41_reva0_errata_patch[] = {
+	{ CS35L41_DSP1_CCM_CORE_CTRL,	 0x00000000 },
+	{ CS35L41_PWR_CTRL2,		 0x00000000 },
+	{ CS35L41_AMP_GAIN_CTRL,	 0x00000000 },
+	{ 0x00000040,			 0x00005555 },
+	{ 0x00000040,			 0x0000AAAA },
+	{ 0x00003854,			 0x05180240 },
+	{ CS35L41_VIMON_SPKMON_RESYNC,	 0x00000000 },
+	{ 0x00004310,			 0x00000000 },
+	{ CS35L41_VPVBST_FS_SEL,	 0x00000000 },
+	{ CS35L41_OTP_TRIM_30,		 0x9091A1C8 },
+	{ 0x00003014,			 0x0200EE0E },
+	{ CS35L41_BSTCVRT_DCM_CTRL,	 0x00000051 },
+	{ 0x00000054,			 0x00000004 },
+	{ CS35L41_IRQ1_DB3,		 0x00000000 },
+	{ CS35L41_IRQ2_DB3,		 0x00000000 },
+	{ CS35L41_DSP1_YM_ACCEL_PL0_PRI, 0x00000000 },
+	{ CS35L41_DSP1_XM_ACCEL_PL0_PRI, 0x00000000 },
+	{ 0x00000040,			 0x0000CCCC },
+	{ 0x00000040,			 0x00003333 },
+};
+
+static const struct reg_sequence cs35l41_revb0_errata_patch[] = {
+	{ CS35L41_DSP1_CCM_CORE_CTRL,	 0x00000000 },
+	{ CS35L41_PWR_CTRL2,		 0x00000000 },
+	{ CS35L41_AMP_GAIN_CTRL,	 0x00000000 },
+	{ 0x00000040,			 0x00005555 },
+	{ 0x00000040,			 0x0000AAAA },
+	{ CS35L41_VIMON_SPKMON_RESYNC,	 0x00000000 },
+	{ 0x00004310,			 0x00000000 },
+	{ CS35L41_VPVBST_FS_SEL,	 0x00000000 },
+	{ CS35L41_BSTCVRT_DCM_CTRL,	 0x00000051 },
+	{ CS35L41_DSP1_YM_ACCEL_PL0_PRI, 0x00000000 },
+	{ CS35L41_DSP1_XM_ACCEL_PL0_PRI, 0x00000000 },
+	{ 0x00000040,			 0x0000CCCC },
+	{ 0x00000040,			 0x00003333 },
+};
+
+static const struct reg_sequence cs35l41_revb2_errata_patch[] = {
+	{ CS35L41_DSP1_CCM_CORE_CTRL,	 0x00000000 },
+	{ CS35L41_PWR_CTRL2,		 0x00000000 },
+	{ CS35L41_AMP_GAIN_CTRL,	 0x00000000 },
+	{ 0x00000040,			 0x00005555 },
+	{ 0x00000040,			 0x0000AAAA },
+	{ CS35L41_VIMON_SPKMON_RESYNC,	 0x00000000 },
+	{ 0x00004310,			 0x00000000 },
+	{ CS35L41_VPVBST_FS_SEL,	 0x00000000 },
+	{ CS35L41_BSTCVRT_DCM_CTRL,	 0x00000051 },
+	{ CS35L41_DSP1_YM_ACCEL_PL0_PRI, 0x00000000 },
+	{ CS35L41_DSP1_XM_ACCEL_PL0_PRI, 0x00000000 },
+	{ 0x00000040,			 0x0000CCCC },
+	{ 0x00000040,			 0x00003333 },
+};
+
 const struct cs35l41_otp_map_element_t cs35l41_otp_map_map[CS35L41_NUM_OTP_MAPS] = {
 	{
 		.id = 0x01,
@@ -865,3 +919,35 @@ int cs35l41_otp_unpack(struct device *dev, struct regmap *regmap)
 	return ret;
 }
 
+int cs35l41_register_errata_patch(struct device *dev, struct regmap *reg, unsigned int reg_revid)
+{
+	int ret = 0;
+	char *rev;
+
+	switch (reg_revid) {
+	case CS35L41_REVID_A0:
+		ret = regmap_register_patch(reg, cs35l41_reva0_errata_patch,
+					    ARRAY_SIZE(cs35l41_reva0_errata_patch));
+		rev = "A0";
+		break;
+	case CS35L41_REVID_B0:
+		ret = regmap_register_patch(reg, cs35l41_revb0_errata_patch,
+					    ARRAY_SIZE(cs35l41_revb0_errata_patch));
+		rev = "B0";
+		break;
+	case CS35L41_REVID_B2:
+		ret = regmap_register_patch(reg, cs35l41_revb2_errata_patch,
+					    ARRAY_SIZE(cs35l41_revb2_errata_patch));
+		rev = "B2";
+		break;
+	default:
+		ret = -EINVAL;
+		rev = "XX";
+		break;
+	}
+
+	if (ret)
+		dev_err(dev, "Failed to apply %s errata patch: %d\n", rev, ret);
+
+	return ret;
+}
diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index 20edc40b2fab..b1202ac9f264 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -1266,60 +1266,6 @@ static int cs35l41_handle_pdata(struct device *dev,
 	return 0;
 }
 
-static const struct reg_sequence cs35l41_reva0_errata_patch[] = {
-	{ CS35L41_DSP1_CCM_CORE_CTRL,	 0x00000000 },
-	{ CS35L41_PWR_CTRL2,		 0x00000000 },
-	{ CS35L41_AMP_GAIN_CTRL,	 0x00000000 },
-	{ 0x00000040,			 0x00005555 },
-	{ 0x00000040,			 0x0000AAAA },
-	{ 0x00003854,			 0x05180240 },
-	{ CS35L41_VIMON_SPKMON_RESYNC,	 0x00000000 },
-	{ 0x00004310,			 0x00000000 },
-	{ CS35L41_VPVBST_FS_SEL,	 0x00000000 },
-	{ CS35L41_OTP_TRIM_30,		 0x9091A1C8 },
-	{ 0x00003014,			 0x0200EE0E },
-	{ CS35L41_BSTCVRT_DCM_CTRL,	 0x00000051 },
-	{ 0x00000054,			 0x00000004 },
-	{ CS35L41_IRQ1_DB3,		 0x00000000 },
-	{ CS35L41_IRQ2_DB3,		 0x00000000 },
-	{ CS35L41_DSP1_YM_ACCEL_PL0_PRI, 0x00000000 },
-	{ CS35L41_DSP1_XM_ACCEL_PL0_PRI, 0x00000000 },
-	{ 0x00000040,			 0x0000CCCC },
-	{ 0x00000040,			 0x00003333 },
-};
-
-static const struct reg_sequence cs35l41_revb0_errata_patch[] = {
-	{ CS35L41_DSP1_CCM_CORE_CTRL,	 0x00000000 },
-	{ CS35L41_PWR_CTRL2,		 0x00000000 },
-	{ CS35L41_AMP_GAIN_CTRL,	 0x00000000 },
-	{ 0x00000040,			 0x00005555 },
-	{ 0x00000040,			 0x0000AAAA },
-	{ CS35L41_VIMON_SPKMON_RESYNC,	 0x00000000 },
-	{ 0x00004310,			 0x00000000 },
-	{ CS35L41_VPVBST_FS_SEL,	 0x00000000 },
-	{ CS35L41_BSTCVRT_DCM_CTRL,	 0x00000051 },
-	{ CS35L41_DSP1_YM_ACCEL_PL0_PRI, 0x00000000 },
-	{ CS35L41_DSP1_XM_ACCEL_PL0_PRI, 0x00000000 },
-	{ 0x00000040,			 0x0000CCCC },
-	{ 0x00000040,			 0x00003333 },
-};
-
-static const struct reg_sequence cs35l41_revb2_errata_patch[] = {
-	{ CS35L41_DSP1_CCM_CORE_CTRL,	 0x00000000 },
-	{ CS35L41_PWR_CTRL2,		 0x00000000 },
-	{ CS35L41_AMP_GAIN_CTRL,	 0x00000000 },
-	{ 0x00000040,			 0x00005555 },
-	{ 0x00000040,			 0x0000AAAA },
-	{ CS35L41_VIMON_SPKMON_RESYNC,	 0x00000000 },
-	{ 0x00004310,			 0x00000000 },
-	{ CS35L41_VPVBST_FS_SEL,	 0x00000000 },
-	{ CS35L41_BSTCVRT_DCM_CTRL,	 0x00000051 },
-	{ CS35L41_DSP1_YM_ACCEL_PL0_PRI, 0x00000000 },
-	{ CS35L41_DSP1_XM_ACCEL_PL0_PRI, 0x00000000 },
-	{ 0x00000040,			 0x0000CCCC },
-	{ 0x00000040,			 0x00003333 },
-};
-
 static const struct reg_sequence cs35l41_fs_errata_patch[] = {
 	{ CS35L41_DSP1_RX1_RATE,	0x00000001 },
 	{ CS35L41_DSP1_RX2_RATE,	0x00000001 },
@@ -1487,38 +1433,9 @@ int cs35l41_probe(struct cs35l41_private *cs35l41,
 		goto err;
 	}
 
-	switch (reg_revid) {
-	case CS35L41_REVID_A0:
-		ret = regmap_register_patch(cs35l41->regmap,
-					    cs35l41_reva0_errata_patch,
-					    ARRAY_SIZE(cs35l41_reva0_errata_patch));
-		if (ret < 0) {
-			dev_err(cs35l41->dev,
-				"Failed to apply A0 errata patch: %d\n", ret);
-			goto err;
-		}
-		break;
-	case CS35L41_REVID_B0:
-		ret = regmap_register_patch(cs35l41->regmap,
-					    cs35l41_revb0_errata_patch,
-					    ARRAY_SIZE(cs35l41_revb0_errata_patch));
-		if (ret < 0) {
-			dev_err(cs35l41->dev,
-				"Failed to apply B0 errata patch: %d\n", ret);
-			goto err;
-		}
-		break;
-	case CS35L41_REVID_B2:
-		ret = regmap_register_patch(cs35l41->regmap,
-					    cs35l41_revb2_errata_patch,
-					    ARRAY_SIZE(cs35l41_revb2_errata_patch));
-		if (ret < 0) {
-			dev_err(cs35l41->dev,
-				"Failed to apply B2 errata patch: %d\n", ret);
-			goto err;
-		}
-		break;
-	}
+	ret = cs35l41_register_errata_patch(cs35l41->dev, cs35l41->regmap, reg_revid);
+	if (ret)
+		goto err;
 
 	irq_pol = cs35l41_irq_gpio_config(cs35l41);
 
-- 
2.34.0

