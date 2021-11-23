Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E4345A7E8
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Nov 2021 17:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238891AbhKWQhF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Nov 2021 11:37:05 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:62442 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S238887AbhKWQgl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 23 Nov 2021 11:36:41 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1ANCeXB7012277;
        Tue, 23 Nov 2021 10:31:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=13QOOMOHEfJf3x3dxB3ukuVPcu2n/luurIuTBvsCw3o=;
 b=A6KSaU3KIqHgMpy/30fzbI/Ds9gduNhPRjKtULO8zbWxVzsCA5TNSN7wSeQikMmfL1J8
 6SXHWCGwyVEZ+YH6J+nDQRgu6aSMPbLWQ71zvEPjmzK4K+GU8VMTBe8Mcq015TfSKnP7
 TEYhHwk17XDXr7jBM7GJe+jhmxm2XPi1p74c3/OzfIpxgpMRR6OvkVJBtE7SUgVxGVFP
 UeHBfdE3rHHndMxjgvVy6qbkSp6XKuXu45vLPblg/xsu79MHKk3cVpuTcv5H/3tdmPrw
 tvJaHEdZEV2HU6tLvrWhTjbUeWY2KfFJikQOHAuVWAER9lOyKUhTC3JN9AjeMYhCppTG jA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3cg5ms21ng-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 23 Nov 2021 10:31:54 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 23 Nov
 2021 16:31:52 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 23 Nov 2021 16:31:52 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.11])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 8D1FA2A3;
        Tue, 23 Nov 2021 16:31:51 +0000 (UTC)
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
Subject: [PATCH 01/11] ASoC: cs35l41: Set the max SPI speed for the whole device
Date:   Tue, 23 Nov 2021 16:31:39 +0000
Message-ID: <20211123163149.1530535-2-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211123163149.1530535-1-tanureal@opensource.cirrus.com>
References: <20211123163149.1530535-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: f9adWZFewEyfyy02AW3fk9vscyXMtFyX
X-Proofpoint-ORIG-GUID: f9adWZFewEyfyy02AW3fk9vscyXMtFyX
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Higher speeds are only supported when PLL is enabled, but
the current driver doesn't enable PLL outside of stream
use cases, so better to set the lowest SPI speed accepted
by the entire device.

Move the current frequency set to the spi sub-driver so
the whole device can benefit from that speed.

spi-max-frequency property could be used, but ACPI systems don't
support it, so by setting it in the spi sub-driver probe
both Device Trees and ACPI systems are supported.

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l41-spi.c | 32 +++-----------------------------
 sound/soc/codecs/cs35l41.c     |  7 -------
 sound/soc/codecs/cs35l41.h     |  4 +---
 3 files changed, 4 insertions(+), 39 deletions(-)

diff --git a/sound/soc/codecs/cs35l41-spi.c b/sound/soc/codecs/cs35l41-spi.c
index 90a921f726c3..3fa99741779a 100644
--- a/sound/soc/codecs/cs35l41-spi.c
+++ b/sound/soc/codecs/cs35l41-spi.c
@@ -42,34 +42,6 @@ static const struct spi_device_id cs35l41_id_spi[] = {
 
 MODULE_DEVICE_TABLE(spi, cs35l41_id_spi);
 
-static void cs35l41_spi_otp_setup(struct cs35l41_private *cs35l41,
-				  bool is_pre_setup, unsigned int *freq)
-{
-	struct spi_device *spi;
-	u32 orig_spi_freq;
-
-	spi = to_spi_device(cs35l41->dev);
-
-	if (!spi) {
-		dev_err(cs35l41->dev, "%s: No SPI device\n", __func__);
-		return;
-	}
-
-	if (is_pre_setup) {
-		orig_spi_freq = spi->max_speed_hz;
-		if (orig_spi_freq > CS35L41_SPI_MAX_FREQ_OTP) {
-			spi->max_speed_hz = CS35L41_SPI_MAX_FREQ_OTP;
-			spi_setup(spi);
-		}
-		*freq = orig_spi_freq;
-	} else {
-		if (spi->max_speed_hz != *freq) {
-			spi->max_speed_hz = *freq;
-			spi_setup(spi);
-		}
-	}
-}
-
 static int cs35l41_spi_probe(struct spi_device *spi)
 {
 	const struct regmap_config *regmap_config = &cs35l41_regmap_spi;
@@ -81,6 +53,9 @@ static int cs35l41_spi_probe(struct spi_device *spi)
 	if (!cs35l41)
 		return -ENOMEM;
 
+	spi->max_speed_hz = CS35L41_SPI_MAX_FREQ;
+	spi_setup(spi);
+
 	spi_set_drvdata(spi, cs35l41);
 	cs35l41->regmap = devm_regmap_init_spi(spi, regmap_config);
 	if (IS_ERR(cs35l41->regmap)) {
@@ -91,7 +66,6 @@ static int cs35l41_spi_probe(struct spi_device *spi)
 
 	cs35l41->dev = &spi->dev;
 	cs35l41->irq = spi->irq;
-	cs35l41->otp_setup = cs35l41_spi_otp_setup;
 
 	return cs35l41_probe(cs35l41, pdata);
 }
diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index afb07d2991ba..e8e997efaa8b 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -438,7 +438,6 @@ static int cs35l41_otp_unpack(void *data)
 	const struct cs35l41_otp_packed_element_t *otp_map;
 	struct cs35l41_private *cs35l41 = data;
 	int bit_offset, word_offset, ret, i;
-	unsigned int orig_spi_freq;
 	unsigned int bit_sum = 8;
 	u32 otp_val, otp_id_reg;
 	u32 *otp_mem;
@@ -462,9 +461,6 @@ static int cs35l41_otp_unpack(void *data)
 		goto err_otp_unpack;
 	}
 
-	if (cs35l41->otp_setup)
-		cs35l41->otp_setup(cs35l41, true, &orig_spi_freq);
-
 	ret = regmap_bulk_read(cs35l41->regmap, CS35L41_OTP_MEM0, otp_mem,
 			       CS35L41_OTP_SIZE_WORDS);
 	if (ret < 0) {
@@ -472,9 +468,6 @@ static int cs35l41_otp_unpack(void *data)
 		goto err_otp_unpack;
 	}
 
-	if (cs35l41->otp_setup)
-		cs35l41->otp_setup(cs35l41, false, &orig_spi_freq);
-
 	otp_map = otp_map_match->map;
 
 	bit_offset = otp_map_match->bit_offset;
diff --git a/sound/soc/codecs/cs35l41.h b/sound/soc/codecs/cs35l41.h
index eea3b14acb0b..a23eabff074f 100644
--- a/sound/soc/codecs/cs35l41.h
+++ b/sound/soc/codecs/cs35l41.h
@@ -729,7 +729,7 @@
 #define CS35L41_FS2_WINDOW_MASK		0x00FFF800
 #define CS35L41_FS2_WINDOW_SHIFT	12
 
-#define CS35L41_SPI_MAX_FREQ_OTP	4000000
+#define CS35L41_SPI_MAX_FREQ		4000000
 
 #define CS35L41_RX_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE)
 #define CS35L41_TX_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE)
@@ -784,8 +784,6 @@ struct cs35l41_private {
 	int irq;
 	/* GPIO for /RST */
 	struct gpio_desc *reset_gpio;
-	void (*otp_setup)(struct cs35l41_private *cs35l41, bool is_pre_setup,
-			  unsigned int *freq);
 };
 
 int cs35l41_probe(struct cs35l41_private *cs35l41,
-- 
2.34.0

