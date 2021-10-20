Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B5243477C
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Oct 2021 11:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhJTJCv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 Oct 2021 05:02:51 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:44394 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229548AbhJTJCu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 20 Oct 2021 05:02:50 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19K5H3Xv026523;
        Wed, 20 Oct 2021 03:59:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=SayzzPMsAGjmsIpv5PlkVzoq+CA82VpCeYd/MpP513E=;
 b=OzA7dOgF+GQ2h7BGIlCl+trOXhLPQJ1qM99ztMa4atD5vBrtHc5m2iNN9Xu/6CtWaq27
 4+Lkc/5l/3MUL2FtzisYBOSlFCnkozerZ5ogx9Y0cuyuCnplryzB/bPaI8boJkzFR8G8
 yfkdOfd/1w8mYtAO5QL3TWCGjp9gdv/gGUBjyV94Y6mceRpqLYi96Mk5uBXI48hGxM7m
 poN1Vm6jIJYJUt/ALR6xDQruN2GHm7oTYycEsj89AmkssPMhtP2azki4CgKxfNPLnlOm
 T+vV65dcsKNvmZoQyoj6Wfc0yoTVCNe0IleFHpt+0gCUy42XYea3qZzTKdoiJeL+qM3M xw== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3bst7q1jty-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 20 Oct 2021 03:59:49 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 20 Oct
 2021 09:59:46 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.7 via Frontend
 Transport; Wed, 20 Oct 2021 09:59:46 +0100
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.166])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 8EF8111DA;
        Wed, 20 Oct 2021 08:59:46 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        "Jaroslav Kysela" <perex@perex.cz>, Len Brown <lenb@kernel.org>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-acpi@vger.kernel.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [RFC PATCH v2 1/3] sound: cs35l41: Allow HDA systems to use CS35l41 ASoC driver
Date:   Wed, 20 Oct 2021 09:59:42 +0100
Message-ID: <20211020085944.17577-2-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211020085944.17577-1-tanureal@opensource.cirrus.com>
References: <20211020085944.17577-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: dPSgHvP0MXPYjwT38S90ggCfo1io1Fz3
X-Proofpoint-GUID: dPSgHvP0MXPYjwT38S90ggCfo1io1Fz3
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Re-use ASoC driver for supporting for Legion 7 16ACHg6
laptop.
HDA machine driver will find the registered dais for the
Amp and use snd_soc_dai_ops to configure it.

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 include/sound/cs35l41.h    |   1 +
 sound/soc/codecs/cs35l41.c | 139 ++++++++++++++++++++++++++++++++++---
 sound/soc/codecs/cs35l41.h |   1 +
 3 files changed, 133 insertions(+), 8 deletions(-)

diff --git a/include/sound/cs35l41.h b/include/sound/cs35l41.h
index 1f1e3c6c9be1..e250d31d4b04 100644
--- a/include/sound/cs35l41.h
+++ b/include/sound/cs35l41.h
@@ -23,6 +23,7 @@ struct cs35l41_irq_cfg {
 };
 
 struct cs35l41_platform_data {
+	bool vspk_always_on;
 	int bst_ind;
 	int bst_ipk;
 	int bst_cap;
diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index b16eb6610c0e..e6bb5c047d89 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -21,6 +21,7 @@
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
 #include <sound/tlv.h>
+#include <linux/acpi.h>
 
 #include "cs35l41.h"
 
@@ -1039,9 +1040,7 @@ static int cs35l41_set_pdata(struct cs35l41_private *cs35l41)
 {
 	int ret;
 
-	/* Set Platform Data */
-	/* Required */
-	if (cs35l41->pdata.bst_ipk &&
+	if (!cs35l41->pdata.vspk_always_on && cs35l41->pdata.bst_ipk &&
 	    cs35l41->pdata.bst_ind && cs35l41->pdata.bst_cap) {
 		ret = cs35l41_boost_config(cs35l41, cs35l41->pdata.bst_ind,
 					   cs35l41->pdata.bst_cap,
@@ -1051,8 +1050,7 @@ static int cs35l41_set_pdata(struct cs35l41_private *cs35l41)
 			return ret;
 		}
 	} else {
-		dev_err(cs35l41->dev, "Incomplete Boost component DT config\n");
-		return -EINVAL;
+		dev_info(cs35l41->dev, "Boost disabled\n");
 	}
 
 	/* Optional */
@@ -1098,12 +1096,92 @@ static int cs35l41_irq_gpio_config(struct cs35l41_private *cs35l41)
 	return irq_pol;
 }
 
+static const struct reg_sequence cs35l41_safe_to_global_enable[] = {
+	{ 0x00000040,			0x00000055 },
+	{ 0x00000040,			0x000000AA },
+	{ 0x0000742C,			0x0000000F },
+	{ 0x0000742C,			0x00000079 },
+	{ 0x00007438,			0x00585941 },
+	{ CS35L41_PLL_CLK_CTRL,		0x00000420 }, //3200000Hz ,BCLK Input ,PLL_REFCLK_EN = 0
+	{ CS35L41_PLL_CLK_CTRL,		0x00000430 }, //3200000Hz ,BCLK Input ,PLL_REFCLK_EN = 1
+	{ CS35L41_GLOBAL_CLK_CTRL,	0x00000003 }, //GLOBAL_FS = 48 kHz
+	{ CS35L41_SP_ENABLES,		0x00010000 }, //ASP_RX1_EN = 1
+	{ CS35L41_SP_RATE_CTRL,		0x00000021 }, //ASP_BCLK_FREQ = 3.072 MHz
+	{ CS35L41_SP_FORMAT,		0x18180200 }, //ASP_RX_WIDTH = 24 bits, ASP_TX_WIDTH = 24 bits, ASP_FMT=I2S, BCLK Slave, FSYNC Slave
+	{ CS35L41_DAC_PCM1_SRC,		0x00000008 }, //DACPCM1_SRC = ASPRX1
+	{ CS35L41_AMP_DIG_VOL_CTRL,	0x00000000 }, //AMP_VOL_PCM  0.0 dB
+	{ CS35L41_AMP_GAIN_CTRL,	0x00000260 }, //AMP_GAIN_PCM 19.5 dB
+	{ CS35L41_PWR_CTRL2,		0x00000001 }, //AMP_EN = 1
+	{ CS35L41_PWR_CTRL1,		0x00000001 }, //GLOBAL_EN = 1
+	{ 0x00000040,			0x000000CC },
+	{ 0x00000040,			0x00000033 },
+};
+
+static const struct reg_sequence cs35l41_global_enable_to_active[] = {
+	{ 0x00000040,			0x00000055 },
+	{ 0x00000040,			0x000000AA },
+	{ 0x0000742C,			0x000000F9 },
+	{ 0x00007438,			0x00580941 },
+	{ 0x00000040,			0x000000CC },
+	{ 0x00000040,			0x00000033 },
+};
+
+static const struct reg_sequence cs35l41_active_to_safe_first[] = {
+	{ 0x00000040,			0x00000055 },
+	{ 0x00000040,			0x000000AA },
+	{ 0x00007438,			0x00585941 },
+	{ CS35L41_AMP_DIG_VOL_CTRL,	0x0000A678 }, //AMP_VOL_PCM Mute
+	{ CS35L41_PWR_CTRL2,		0x00000000 }, //AMP_EN = 0
+	{ CS35L41_PWR_CTRL1,		0x00000000 },
+	{ 0x0000742C,			0x00000009 },
+	{ 0x00000040,			0x000000CC },
+	{ 0x00000040,			0x00000033 },
+};
+
+static const struct reg_sequence cs35l41_active_to_safe_second[] = {
+	{ 0x00000040,			0x00000055 },
+	{ 0x00000040,			0x000000AA },
+	{ 0x00007438,			0x00580941 },
+	{ 0x00000040,			0x000000CC },
+	{ 0x00000040,			0x00000033 },
+};
+
+static void cs35l41_dai_shutdown(struct snd_pcm_substream *sub, struct snd_soc_dai *dai)
+{
+	struct cs35l41_private *cs35l41 = snd_soc_component_get_drvdata(dai->component);
+
+	if (cs35l41->hda) {
+		regmap_multi_reg_write(cs35l41->regmap, cs35l41_active_to_safe_first,
+				       ARRAY_SIZE(cs35l41_active_to_safe_first));
+		usleep_range(1500, 2000);
+		regmap_multi_reg_write(cs35l41->regmap, cs35l41_active_to_safe_second,
+				       ARRAY_SIZE(cs35l41_active_to_safe_second));
+	}
+}
+
+static int cs35l41_dai_prepare(struct snd_pcm_substream *sub, struct snd_soc_dai *dai)
+{
+	struct cs35l41_private *cs35l41 = snd_soc_component_get_drvdata(dai->component);
+
+	if (cs35l41->hda) {
+		regmap_multi_reg_write(cs35l41->regmap, cs35l41_safe_to_global_enable,
+				       ARRAY_SIZE(cs35l41_safe_to_global_enable));
+		usleep_range(1500, 2000);
+		regmap_multi_reg_write(cs35l41->regmap, cs35l41_global_enable_to_active,
+				      ARRAY_SIZE(cs35l41_global_enable_to_active));
+	}
+
+	return 0;
+}
+
 static const struct snd_soc_dai_ops cs35l41_ops = {
 	.startup = cs35l41_pcm_startup,
 	.set_fmt = cs35l41_set_dai_fmt,
 	.hw_params = cs35l41_pcm_hw_params,
 	.set_sysclk = cs35l41_dai_set_sysclk,
 	.set_channel_map = cs35l41_set_channel_map,
+	.shutdown = cs35l41_dai_shutdown,
+	.prepare = cs35l41_dai_prepare,
 };
 
 static struct snd_soc_dai_driver cs35l41_dai[] = {
@@ -1126,6 +1204,7 @@ static struct snd_soc_dai_driver cs35l41_dai[] = {
 		},
 		.ops = &cs35l41_ops,
 		.symmetric_rate = 1,
+		.symmetric_sample_bits = 1,
 	},
 };
 
@@ -1148,9 +1227,31 @@ static int cs35l41_handle_pdata(struct device *dev,
 {
 	struct cs35l41_irq_cfg *irq_gpio1_config = &pdata->irq_config1;
 	struct cs35l41_irq_cfg *irq_gpio2_config = &pdata->irq_config2;
+	struct acpi_device *adev;
+	struct device *phys_dev;
 	unsigned int val;
 	int ret;
 
+	if (memcmp(dev_name(cs35l41->dev), "i2c-CLSA0100", 12) == 0) {
+		pdata->vspk_always_on = true;
+		cs35l41->hda = true;
+		adev = acpi_dev_get_first_match_dev("CLSA0100", "1", -1);
+		if (!adev) {
+			dev_err(dev, "Failed to find an ACPI device\n");
+			return -ENODEV;
+		}
+
+		phys_dev = get_device(acpi_get_first_physical_node(adev));
+		acpi_dev_put(adev);
+
+		if (!phys_dev) {
+			dev_err(dev, "Failed to find a physical device\n");
+			return -ENODEV;
+		}
+		cs35l41->reset_gpio = gpiod_get_index(phys_dev, NULL, 0, GPIOD_ASIS);
+		return 0;
+	}
+
 	ret = device_property_read_u32(dev, "cirrus,boost-peak-milliamp", &val);
 	if (ret >= 0)
 		pdata->bst_ipk = val;
@@ -1237,6 +1338,16 @@ static const struct reg_sequence cs35l41_revb2_errata_patch[] = {
 	{ 0x00000040,			 0x00003333 },
 };
 
+static const struct reg_sequence cs35l41_reset_to_enabled[] = {
+	{ 0x00000040,			0x00000055 },
+	{ 0x00000040,			0x000000AA },
+	{ 0x00007438,			0x00585941 },
+	{ 0x00007414,			0x08C82222 },
+	{ 0x0000742C,			0x00000009 },
+	{ 0x00000040,			0x000000CC },
+	{ 0x00000040,			0x00000033 },
+};
+
 int cs35l41_probe(struct cs35l41_private *cs35l41,
 		  struct cs35l41_platform_data *pdata)
 {
@@ -1269,8 +1380,8 @@ int cs35l41_probe(struct cs35l41_private *cs35l41,
 	}
 
 	/* returning NULL can be an option if in stereo mode */
-	cs35l41->reset_gpio = devm_gpiod_get_optional(cs35l41->dev, "reset",
-						      GPIOD_OUT_LOW);
+	if (!cs35l41->reset_gpio)
+		cs35l41->reset_gpio = devm_gpiod_get_optional(cs35l41->dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(cs35l41->reset_gpio)) {
 		ret = PTR_ERR(cs35l41->reset_gpio);
 		cs35l41->reset_gpio = NULL;
@@ -1365,6 +1476,16 @@ int cs35l41_probe(struct cs35l41_private *cs35l41,
 		break;
 	}
 
+	if (cs35l41->pdata.vspk_always_on) {
+		ret = regmap_multi_reg_write(cs35l41->regmap, cs35l41_reset_to_enabled,
+					     ARRAY_SIZE(cs35l41_reset_to_enabled));
+		if (ret < 0) {
+			dev_err(cs35l41->dev, "Failed to apply reset to enabled patch: %d\n", ret);
+			goto err;
+		}
+		dev_info(cs35l41->dev, "Safe mode enabled\n");
+	}
+
 	irq_pol = cs35l41_irq_gpio_config(cs35l41);
 
 	/* Set interrupt masks for critical errors */
@@ -1437,7 +1558,9 @@ int cs35l41_remove(struct cs35l41_private *cs35l41)
 {
 	regmap_write(cs35l41->regmap, CS35L41_IRQ1_MASK1, 0xFFFFFFFF);
 	regulator_bulk_disable(CS35L41_NUM_SUPPLIES, cs35l41->supplies);
-	gpiod_set_value_cansleep(cs35l41->reset_gpio, 0);
+
+	if (cs35l41->reset_gpio && !cs35l41->pdata.vspk_always_on)
+		gpiod_set_value_cansleep(cs35l41->reset_gpio, 0);
 
 	return 0;
 }
diff --git a/sound/soc/codecs/cs35l41.h b/sound/soc/codecs/cs35l41.h
index 0e2639d6ef19..bb1f08e36c04 100644
--- a/sound/soc/codecs/cs35l41.h
+++ b/sound/soc/codecs/cs35l41.h
@@ -762,6 +762,7 @@ struct cs35l41_private {
 	struct regmap *regmap;
 	struct regulator_bulk_data supplies[CS35L41_NUM_SUPPLIES];
 	int irq;
+	bool hda;
 	/* GPIO for /RST */
 	struct gpio_desc *reset_gpio;
 	void (*otp_setup)(struct cs35l41_private *cs35l41, bool is_pre_setup,
-- 
2.33.1

