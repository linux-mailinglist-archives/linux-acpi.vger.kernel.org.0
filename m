Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D389B2DA4A
	for <lists+linux-acpi@lfdr.de>; Wed, 29 May 2019 12:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfE2KU0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 29 May 2019 06:20:26 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:60454 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726254AbfE2KU0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 29 May 2019 06:20:26 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4TAHuUL001078;
        Wed, 29 May 2019 05:19:56 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail2.cirrus.com (mail2.cirrus.com [141.131.128.20])
        by mx0b-001ae601.pphosted.com with ESMTP id 2sq24q4kbq-1;
        Wed, 29 May 2019 05:19:56 -0500
Received: from EDIEX02.ad.cirrus.com (unknown [198.61.84.81])
        by mail2.cirrus.com (Postfix) with ESMTP id DB86A605A6A9;
        Wed, 29 May 2019 05:19:55 -0500 (CDT)
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Wed, 29 May
 2019 11:19:54 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Wed, 29 May 2019 11:19:54 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 874DE44;
        Wed, 29 May 2019 11:19:54 +0100 (BST)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <lee.jones@linaro.org>,
        <rafael@kernel.org>, <gregkh@linuxfoundation.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <patches@opensource.cirrus.com>, <linux-acpi@vger.kernel.org>
Subject: [PATCH v2 4/6] ASoC: cs47l35: Add codec driver for Cirrus Logic CS47L35
Date:   Wed, 29 May 2019 11:19:52 +0100
Message-ID: <20190529101954.10438-4-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190529101954.10438-1-ckeepax@opensource.cirrus.com>
References: <20190529101954.10438-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905290069
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Richard Fitzgerald <rf@opensource.cirrus.com>

Adds the codec driver for the CS47L35 SmartCodec. This is a
multi-functional codec based on the Cirrus Logic Madera platform.

Signed-off-by: Piotr Stankiewicz <piotrs@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Changes since v1:
 - Rename destroy functions to free

Thanks,
Charles

 sound/soc/codecs/Kconfig   |    6 +
 sound/soc/codecs/Makefile  |    2 +
 sound/soc/codecs/cs47l35.c | 1748 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1756 insertions(+)
 create mode 100644 sound/soc/codecs/cs47l35.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 88e133e670872..9d52bc12c84eb 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -70,6 +70,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_CS4341 if SND_SOC_I2C_AND_SPI
 	select SND_SOC_CS4349 if I2C
 	select SND_SOC_CS47L24 if MFD_CS47L24
+	select SND_SOC_CS47L35 if MFD_CS47L35
 	select SND_SOC_CS53L30 if I2C
 	select SND_SOC_CX20442 if TTY
 	select SND_SOC_CX2072X if I2C
@@ -578,6 +579,9 @@ config SND_SOC_CS4349
 config SND_SOC_CS47L24
 	tristate
 
+config SND_SOC_CS47L35
+	tristate
+
 # Cirrus Logic Quad-Channel ADC
 config SND_SOC_CS53L30
 	tristate "Cirrus Logic CS53L30 CODEC"
@@ -707,6 +711,8 @@ config SND_SOC_LOCHNAGAR_SC
 
 config SND_SOC_MADERA
 	tristate
+	default y if SND_SOC_CS47L35=y
+	default m if SND_SOC_CS47L35=m
 
 config SND_SOC_MAX98088
 	tristate "Maxim MAX98088/9 Low-Power, Stereo Audio Codec"
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 2a39ddbaccba1..b275b8b600eed 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -65,6 +65,7 @@ snd-soc-cs43130-objs := cs43130.o
 snd-soc-cs4341-objs := cs4341.o
 snd-soc-cs4349-objs := cs4349.o
 snd-soc-cs47l24-objs := cs47l24.o
+snd-soc-cs47l35-objs := cs47l35.o
 snd-soc-cs53l30-objs := cs53l30.o
 snd-soc-cx20442-objs := cx20442.o
 snd-soc-cx2072x-objs := cx2072x.o
@@ -341,6 +342,7 @@ obj-$(CONFIG_SND_SOC_CS43130)   += snd-soc-cs43130.o
 obj-$(CONFIG_SND_SOC_CS4341)	+= snd-soc-cs4341.o
 obj-$(CONFIG_SND_SOC_CS4349)	+= snd-soc-cs4349.o
 obj-$(CONFIG_SND_SOC_CS47L24)	+= snd-soc-cs47l24.o
+obj-$(CONFIG_SND_SOC_CS47L35)	+= snd-soc-cs47l35.o
 obj-$(CONFIG_SND_SOC_CS53L30)	+= snd-soc-cs53l30.o
 obj-$(CONFIG_SND_SOC_CX20442)	+= snd-soc-cx20442.o
 obj-$(CONFIG_SND_SOC_CX2072X)	+= snd-soc-cx2072x.o
diff --git a/sound/soc/codecs/cs47l35.c b/sound/soc/codecs/cs47l35.c
new file mode 100644
index 0000000000000..ccbd0952adfee
--- /dev/null
+++ b/sound/soc/codecs/cs47l35.c
@@ -0,0 +1,1748 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// ALSA SoC Audio driver for CS47L35 codec
+//
+// Copyright (C) 2015-2019 Cirrus Logic, Inc. and
+//                         Cirrus Logic International Semiconductor Ltd.
+//
+// This program is free software; you can redistribute it and/or modify
+// it under the terms of the GNU General Public License as published by the
+// Free Software Foundation; version 2.
+//
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/pm.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/tlv.h>
+#include <sound/tlv.h>
+
+#include <linux/irqchip/irq-madera.h>
+#include <linux/mfd/madera/core.h>
+#include <linux/mfd/madera/registers.h>
+
+#include "madera.h"
+#include "wm_adsp.h"
+
+#define CS47L35_NUM_ADSP	3
+#define CS47L35_MONO_OUTPUTS	1
+
+#define DRV_NAME "cs47l35-codec"
+
+struct cs47l35 {
+	struct madera_priv core;
+	struct madera_fll fll;
+};
+
+static const struct wm_adsp_region cs47l35_dsp1_regions[] = {
+	{ .type = WMFW_ADSP2_PM, .base = 0x080000 },
+	{ .type = WMFW_ADSP2_ZM, .base = 0x0e0000 },
+	{ .type = WMFW_ADSP2_XM, .base = 0x0a0000 },
+	{ .type = WMFW_ADSP2_YM, .base = 0x0c0000 },
+};
+
+static const struct wm_adsp_region cs47l35_dsp2_regions[] = {
+	{ .type = WMFW_ADSP2_PM, .base = 0x100000 },
+	{ .type = WMFW_ADSP2_ZM, .base = 0x160000 },
+	{ .type = WMFW_ADSP2_XM, .base = 0x120000 },
+	{ .type = WMFW_ADSP2_YM, .base = 0x140000 },
+};
+
+static const struct wm_adsp_region cs47l35_dsp3_regions[] = {
+	{ .type = WMFW_ADSP2_PM, .base = 0x180000 },
+	{ .type = WMFW_ADSP2_ZM, .base = 0x1e0000 },
+	{ .type = WMFW_ADSP2_XM, .base = 0x1a0000 },
+	{ .type = WMFW_ADSP2_YM, .base = 0x1c0000 },
+};
+
+static const struct wm_adsp_region *cs47l35_dsp_regions[] = {
+	cs47l35_dsp1_regions,
+	cs47l35_dsp2_regions,
+	cs47l35_dsp3_regions,
+};
+
+static const int wm_adsp2_control_bases[] = {
+	MADERA_DSP1_CONFIG_1,
+	MADERA_DSP2_CONFIG_1,
+	MADERA_DSP3_CONFIG_1,
+};
+
+static const char * const cs47l35_outdemux_texts[] = {
+	"HPOUT",
+	"EPOUT",
+};
+
+static SOC_ENUM_SINGLE_DECL(cs47l35_outdemux_enum, SND_SOC_NOPM, 0,
+			    cs47l35_outdemux_texts);
+
+static const struct snd_kcontrol_new cs47l35_outdemux =
+	SOC_DAPM_ENUM_EXT("HPOUT1 Demux", cs47l35_outdemux_enum,
+			  madera_out1_demux_get, madera_out1_demux_put);
+
+static int cs47l35_adsp_power_ev(struct snd_soc_dapm_widget *w,
+				 struct snd_kcontrol *kcontrol,
+				 int event)
+{
+	struct snd_soc_component *component =
+		snd_soc_dapm_to_component(w->dapm);
+	struct cs47l35 *cs47l35 = snd_soc_component_get_drvdata(component);
+	struct madera_priv *priv = &cs47l35->core;
+	struct madera *madera = priv->madera;
+	unsigned int freq;
+	int ret;
+
+	ret = regmap_read(madera->regmap, MADERA_DSP_CLOCK_1, &freq);
+	if (ret != 0) {
+		dev_err(madera->dev,
+			"Failed to read MADERA_DSP_CLOCK_1: %d\n", ret);
+		return ret;
+	}
+
+	freq &= MADERA_DSP_CLK_FREQ_LEGACY_MASK;
+	freq >>= MADERA_DSP_CLK_FREQ_LEGACY_SHIFT;
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		ret = madera_set_adsp_clk(&cs47l35->core, w->shift, freq);
+		if (ret)
+			return ret;
+		break;
+	default:
+		break;
+	}
+
+	return wm_adsp_early_event(w, kcontrol, event);
+}
+
+#define CS47L35_NG_SRC(name, base) \
+	SOC_SINGLE(name " NG HPOUT1L Switch",  base,  0, 1, 0), \
+	SOC_SINGLE(name " NG HPOUT1R Switch",  base,  1, 1, 0), \
+	SOC_SINGLE(name " NG SPKOUT Switch",  base,  6, 1, 0), \
+	SOC_SINGLE(name " NG SPKDAT1L Switch", base,  8, 1, 0), \
+	SOC_SINGLE(name " NG SPKDAT1R Switch", base,  9, 1, 0)
+
+static void cs47l35_hp_post_enable(struct snd_soc_dapm_widget *w)
+{
+	struct snd_soc_component *component =
+		snd_soc_dapm_to_component(w->dapm);
+	unsigned int val;
+	int ret;
+
+	switch (w->shift) {
+	case MADERA_OUT1L_ENA_SHIFT:
+	case MADERA_OUT1R_ENA_SHIFT:
+		ret = snd_soc_component_read(component, MADERA_OUTPUT_ENABLES_1,
+					     &val);
+		if (ret) {
+			dev_err(component->dev,
+				"Failed to check output enables: %d\n", ret);
+			return;
+		}
+
+		val &= (MADERA_OUT1L_ENA | MADERA_OUT1R_ENA);
+
+		if (val != (MADERA_OUT1L_ENA | MADERA_OUT1R_ENA))
+			break;
+
+		snd_soc_component_update_bits(component,
+					      MADERA_EDRE_HP_STEREO_CONTROL,
+					      0x0001, 1);
+		break;
+	default:
+		break;
+	}
+}
+
+static void cs47l35_hp_post_disable(struct snd_soc_dapm_widget *w)
+{
+	struct snd_soc_component *component =
+		snd_soc_dapm_to_component(w->dapm);
+
+	switch (w->shift) {
+	case MADERA_OUT1L_ENA_SHIFT:
+		snd_soc_component_write(component, MADERA_DCS_HP1L_CONTROL,
+					0x2006);
+		break;
+	case MADERA_OUT1R_ENA_SHIFT:
+		snd_soc_component_write(component, MADERA_DCS_HP1R_CONTROL,
+					0x2006);
+		break;
+	default:
+		return;
+	}
+
+	/* Only get to here for OUT1L and OUT1R */
+	snd_soc_component_update_bits(component,
+				      MADERA_EDRE_HP_STEREO_CONTROL,
+				      0x0001, 0);
+}
+
+static int cs47l35_hp_ev(struct snd_soc_dapm_widget *w,
+			 struct snd_kcontrol *kcontrol, int event)
+{
+	int ret;
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+	case SND_SOC_DAPM_PRE_PMD:
+		return madera_hp_ev(w, kcontrol, event);
+	case SND_SOC_DAPM_POST_PMU:
+		ret = madera_hp_ev(w, kcontrol, event);
+		if (ret < 0)
+			return ret;
+
+		cs47l35_hp_post_enable(w);
+		return 0;
+	case SND_SOC_DAPM_POST_PMD:
+		ret = madera_hp_ev(w, kcontrol, event);
+		cs47l35_hp_post_disable(w);
+		return ret;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct snd_kcontrol_new cs47l35_snd_controls[] = {
+SOC_ENUM("IN1 OSR", madera_in_dmic_osr[0]),
+SOC_ENUM("IN2 OSR", madera_in_dmic_osr[1]),
+
+SOC_SINGLE_RANGE_TLV("IN1L Volume", MADERA_IN1L_CONTROL,
+		     MADERA_IN1L_PGA_VOL_SHIFT, 0x40, 0x5f, 0, madera_ana_tlv),
+SOC_SINGLE_RANGE_TLV("IN1R Volume", MADERA_IN1R_CONTROL,
+		     MADERA_IN1R_PGA_VOL_SHIFT, 0x40, 0x5f, 0, madera_ana_tlv),
+SOC_SINGLE_RANGE_TLV("IN2L Volume", MADERA_IN2L_CONTROL,
+		     MADERA_IN2L_PGA_VOL_SHIFT, 0x40, 0x5f, 0, madera_ana_tlv),
+SOC_SINGLE_RANGE_TLV("IN2R Volume", MADERA_IN2R_CONTROL,
+		     MADERA_IN2R_PGA_VOL_SHIFT, 0x40, 0x5f, 0, madera_ana_tlv),
+
+SOC_ENUM("IN HPF Cutoff Frequency", madera_in_hpf_cut_enum),
+
+SOC_SINGLE("IN1L HPF Switch", MADERA_IN1L_CONTROL,
+	   MADERA_IN1L_HPF_SHIFT, 1, 0),
+SOC_SINGLE("IN1R HPF Switch", MADERA_IN1R_CONTROL,
+	   MADERA_IN1R_HPF_SHIFT, 1, 0),
+SOC_SINGLE("IN2L HPF Switch", MADERA_IN2L_CONTROL,
+	   MADERA_IN2L_HPF_SHIFT, 1, 0),
+SOC_SINGLE("IN2R HPF Switch", MADERA_IN2R_CONTROL,
+	   MADERA_IN2R_HPF_SHIFT, 1, 0),
+
+SOC_SINGLE_TLV("IN1L Digital Volume", MADERA_ADC_DIGITAL_VOLUME_1L,
+	       MADERA_IN1L_DIG_VOL_SHIFT, 0xbf, 0, madera_digital_tlv),
+SOC_SINGLE_TLV("IN1R Digital Volume", MADERA_ADC_DIGITAL_VOLUME_1R,
+	       MADERA_IN1R_DIG_VOL_SHIFT, 0xbf, 0, madera_digital_tlv),
+SOC_SINGLE_TLV("IN2L Digital Volume", MADERA_ADC_DIGITAL_VOLUME_2L,
+	       MADERA_IN2L_DIG_VOL_SHIFT, 0xbf, 0, madera_digital_tlv),
+SOC_SINGLE_TLV("IN2R Digital Volume", MADERA_ADC_DIGITAL_VOLUME_2R,
+	       MADERA_IN2R_DIG_VOL_SHIFT, 0xbf, 0, madera_digital_tlv),
+
+SOC_ENUM("Input Ramp Up", madera_in_vi_ramp),
+SOC_ENUM("Input Ramp Down", madera_in_vd_ramp),
+
+MADERA_MIXER_CONTROLS("EQ1", MADERA_EQ1MIX_INPUT_1_SOURCE),
+MADERA_MIXER_CONTROLS("EQ2", MADERA_EQ2MIX_INPUT_1_SOURCE),
+MADERA_MIXER_CONTROLS("EQ3", MADERA_EQ3MIX_INPUT_1_SOURCE),
+MADERA_MIXER_CONTROLS("EQ4", MADERA_EQ4MIX_INPUT_1_SOURCE),
+
+MADERA_EQ_CONTROL("EQ1 Coefficients", MADERA_EQ1_2),
+SOC_SINGLE_TLV("EQ1 B1 Volume", MADERA_EQ1_1, MADERA_EQ1_B1_GAIN_SHIFT,
+	       24, 0, madera_eq_tlv),
+SOC_SINGLE_TLV("EQ1 B2 Volume", MADERA_EQ1_1, MADERA_EQ1_B2_GAIN_SHIFT,
+	       24, 0, madera_eq_tlv),
+SOC_SINGLE_TLV("EQ1 B3 Volume", MADERA_EQ1_1, MADERA_EQ1_B3_GAIN_SHIFT,
+	       24, 0, madera_eq_tlv),
+SOC_SINGLE_TLV("EQ1 B4 Volume", MADERA_EQ1_2, MADERA_EQ1_B4_GAIN_SHIFT,
+	       24, 0, madera_eq_tlv),
+SOC_SINGLE_TLV("EQ1 B5 Volume", MADERA_EQ1_2, MADERA_EQ1_B5_GAIN_SHIFT,
+	       24, 0, madera_eq_tlv),
+
+MADERA_EQ_CONTROL("EQ2 Coefficients", MADERA_EQ2_2),
+SOC_SINGLE_TLV("EQ2 B1 Volume", MADERA_EQ2_1, MADERA_EQ2_B1_GAIN_SHIFT,
+	       24, 0, madera_eq_tlv),
+SOC_SINGLE_TLV("EQ2 B2 Volume", MADERA_EQ2_1, MADERA_EQ2_B2_GAIN_SHIFT,
+	       24, 0, madera_eq_tlv),
+SOC_SINGLE_TLV("EQ2 B3 Volume", MADERA_EQ2_1, MADERA_EQ2_B3_GAIN_SHIFT,
+	       24, 0, madera_eq_tlv),
+SOC_SINGLE_TLV("EQ2 B4 Volume", MADERA_EQ2_2, MADERA_EQ2_B4_GAIN_SHIFT,
+	       24, 0, madera_eq_tlv),
+SOC_SINGLE_TLV("EQ2 B5 Volume", MADERA_EQ2_2, MADERA_EQ2_B5_GAIN_SHIFT,
+	       24, 0, madera_eq_tlv),
+
+MADERA_EQ_CONTROL("EQ3 Coefficients", MADERA_EQ3_2),
+SOC_SINGLE_TLV("EQ3 B1 Volume", MADERA_EQ3_1, MADERA_EQ3_B1_GAIN_SHIFT,
+	       24, 0, madera_eq_tlv),
+SOC_SINGLE_TLV("EQ3 B2 Volume", MADERA_EQ3_1, MADERA_EQ3_B2_GAIN_SHIFT,
+	       24, 0, madera_eq_tlv),
+SOC_SINGLE_TLV("EQ3 B3 Volume", MADERA_EQ3_1, MADERA_EQ3_B3_GAIN_SHIFT,
+	       24, 0, madera_eq_tlv),
+SOC_SINGLE_TLV("EQ3 B4 Volume", MADERA_EQ3_2, MADERA_EQ3_B4_GAIN_SHIFT,
+	       24, 0, madera_eq_tlv),
+SOC_SINGLE_TLV("EQ3 B5 Volume", MADERA_EQ3_2, MADERA_EQ3_B5_GAIN_SHIFT,
+	       24, 0, madera_eq_tlv),
+
+MADERA_EQ_CONTROL("EQ4 Coefficients", MADERA_EQ4_2),
+SOC_SINGLE_TLV("EQ4 B1 Volume", MADERA_EQ4_1, MADERA_EQ4_B1_GAIN_SHIFT,
+	       24, 0, madera_eq_tlv),
+SOC_SINGLE_TLV("EQ4 B2 Volume", MADERA_EQ4_1, MADERA_EQ4_B2_GAIN_SHIFT,
+	       24, 0, madera_eq_tlv),
+SOC_SINGLE_TLV("EQ4 B3 Volume", MADERA_EQ4_1, MADERA_EQ4_B3_GAIN_SHIFT,
+	       24, 0, madera_eq_tlv),
+SOC_SINGLE_TLV("EQ4 B4 Volume", MADERA_EQ4_2, MADERA_EQ4_B4_GAIN_SHIFT,
+	       24, 0, madera_eq_tlv),
+SOC_SINGLE_TLV("EQ4 B5 Volume", MADERA_EQ4_2, MADERA_EQ4_B5_GAIN_SHIFT,
+	       24, 0, madera_eq_tlv),
+
+MADERA_MIXER_CONTROLS("DRC1L", MADERA_DRC1LMIX_INPUT_1_SOURCE),
+MADERA_MIXER_CONTROLS("DRC1R", MADERA_DRC1RMIX_INPUT_1_SOURCE),
+MADERA_MIXER_CONTROLS("DRC2L", MADERA_DRC2LMIX_INPUT_1_SOURCE),
+MADERA_MIXER_CONTROLS("DRC2R", MADERA_DRC2RMIX_INPUT_1_SOURCE),
+
+SND_SOC_BYTES_MASK("DRC1", MADERA_DRC1_CTRL1, 5,
+		   MADERA_DRC1R_ENA | MADERA_DRC1L_ENA),
+SND_SOC_BYTES_MASK("DRC2", MADERA_DRC2_CTRL1, 5,
+		   MADERA_DRC2R_ENA | MADERA_DRC2L_ENA),
+
+MADERA_MIXER_CONTROLS("LHPF1", MADERA_HPLP1MIX_INPUT_1_SOURCE),
+MADERA_MIXER_CONTROLS("LHPF2", MADERA_HPLP2MIX_INPUT_1_SOURCE),
+MADERA_MIXER_CONTROLS("LHPF3", MADERA_HPLP3MIX_INPUT_1_SOURCE),
+MADERA_MIXER_CONTROLS("LHPF4", MADERA_HPLP4MIX_INPUT_1_SOURCE),
+
+MADERA_LHPF_CONTROL("LHPF1 Coefficients", MADERA_HPLPF1_2),
+MADERA_LHPF_CONTROL("LHPF2 Coefficients", MADERA_HPLPF2_2),
+MADERA_LHPF_CONTROL("LHPF3 Coefficients", MADERA_HPLPF3_2),
+MADERA_LHPF_CONTROL("LHPF4 Coefficients", MADERA_HPLPF4_2),
+
+SOC_ENUM("LHPF1 Mode", madera_lhpf1_mode),
+SOC_ENUM("LHPF2 Mode", madera_lhpf2_mode),
+SOC_ENUM("LHPF3 Mode", madera_lhpf3_mode),
+SOC_ENUM("LHPF4 Mode", madera_lhpf4_mode),
+
+MADERA_RATE_ENUM("ISRC1 FSL", madera_isrc_fsl[0]),
+MADERA_RATE_ENUM("ISRC2 FSL", madera_isrc_fsl[1]),
+MADERA_RATE_ENUM("ISRC1 FSH", madera_isrc_fsh[0]),
+MADERA_RATE_ENUM("ISRC2 FSH", madera_isrc_fsh[1]),
+
+WM_ADSP2_PRELOAD_SWITCH("DSP1", 1),
+WM_ADSP2_PRELOAD_SWITCH("DSP2", 2),
+WM_ADSP2_PRELOAD_SWITCH("DSP3", 3),
+
+MADERA_MIXER_CONTROLS("DSP1L", MADERA_DSP1LMIX_INPUT_1_SOURCE),
+MADERA_MIXER_CONTROLS("DSP1R", MADERA_DSP1RMIX_INPUT_1_SOURCE),
+MADERA_MIXER_CONTROLS("DSP2L", MADERA_DSP2LMIX_INPUT_1_SOURCE),
+MADERA_MIXER_CONTROLS("DSP2R", MADERA_DSP2RMIX_INPUT_1_SOURCE),
+MADERA_MIXER_CONTROLS("DSP3L", MADERA_DSP3LMIX_INPUT_1_SOURCE),
+MADERA_MIXER_CONTROLS("DSP3R", MADERA_DSP3RMIX_INPUT_1_SOURCE),
+
+SOC_SINGLE_TLV("Noise Generator Volume", MADERA_COMFORT_NOISE_GENERATOR,
+	       MADERA_NOISE_GEN_GAIN_SHIFT, 0x16, 0, madera_noise_tlv),
+
+MADERA_MIXER_CONTROLS("HPOUT1L", MADERA_OUT1LMIX_INPUT_1_SOURCE),
+MADERA_MIXER_CONTROLS("HPOUT1R", MADERA_OUT1RMIX_INPUT_1_SOURCE),
+MADERA_MIXER_CONTROLS("SPKOUT", MADERA_OUT4LMIX_INPUT_1_SOURCE),
+MADERA_MIXER_CONTROLS("SPKDAT1L", MADERA_OUT5LMIX_INPUT_1_SOURCE),
+MADERA_MIXER_CONTROLS("SPKDAT1R", MADERA_OUT5RMIX_INPUT_1_SOURCE),
+
+SOC_SINGLE("HPOUT1 SC Protect Switch", MADERA_HP1_SHORT_CIRCUIT_CTRL,
+	   MADERA_HP1_SC_ENA_SHIFT, 1, 0),
+
+SOC_SINGLE("SPKDAT1 High Performance Switch", MADERA_OUTPUT_PATH_CONFIG_5L,
+	   MADERA_OUT5_OSR_SHIFT, 1, 0),
+
+SOC_DOUBLE_R("HPOUT1 Digital Switch", MADERA_DAC_DIGITAL_VOLUME_1L,
+	     MADERA_DAC_DIGITAL_VOLUME_1R, MADERA_OUT1L_MUTE_SHIFT, 1, 1),
+SOC_SINGLE("Speaker Digital Switch", MADERA_DAC_DIGITAL_VOLUME_4L,
+	   MADERA_OUT4L_MUTE_SHIFT, 1, 1),
+SOC_DOUBLE_R("SPKDAT1 Digital Switch", MADERA_DAC_DIGITAL_VOLUME_5L,
+	     MADERA_DAC_DIGITAL_VOLUME_5R, MADERA_OUT5L_MUTE_SHIFT, 1, 1),
+
+SOC_DOUBLE_R_TLV("HPOUT1 Digital Volume", MADERA_DAC_DIGITAL_VOLUME_1L,
+		 MADERA_DAC_DIGITAL_VOLUME_1R, MADERA_OUT1L_VOL_SHIFT,
+		 0xbf, 0, madera_digital_tlv),
+SOC_SINGLE_TLV("Speaker Digital Volume", MADERA_DAC_DIGITAL_VOLUME_4L,
+	       MADERA_OUT4L_VOL_SHIFT, 0xbf, 0, madera_digital_tlv),
+SOC_DOUBLE_R_TLV("SPKDAT1 Digital Volume", MADERA_DAC_DIGITAL_VOLUME_5L,
+		 MADERA_DAC_DIGITAL_VOLUME_5R, MADERA_OUT5L_VOL_SHIFT,
+		 0xbf, 0, madera_digital_tlv),
+
+SOC_DOUBLE("SPKDAT1 Switch", MADERA_PDM_SPK1_CTRL_1, MADERA_SPK1L_MUTE_SHIFT,
+	   MADERA_SPK1R_MUTE_SHIFT, 1, 1),
+
+SOC_ENUM("Output Ramp Up", madera_out_vi_ramp),
+SOC_ENUM("Output Ramp Down", madera_out_vd_ramp),
+
+SOC_SINGLE("Noise Gate Switch", MADERA_NOISE_GATE_CONTROL,
+	   MADERA_NGATE_ENA_SHIFT, 1, 0),
+SOC_SINGLE_TLV("Noise Gate Threshold Volume", MADERA_NOISE_GATE_CONTROL,
+	       MADERA_NGATE_THR_SHIFT, 7, 1, madera_ng_tlv),
+SOC_ENUM("Noise Gate Hold", madera_ng_hold),
+
+CS47L35_NG_SRC("HPOUT1L", MADERA_NOISE_GATE_SELECT_1L),
+CS47L35_NG_SRC("HPOUT1R", MADERA_NOISE_GATE_SELECT_1R),
+CS47L35_NG_SRC("SPKOUT", MADERA_NOISE_GATE_SELECT_4L),
+CS47L35_NG_SRC("SPKDAT1L", MADERA_NOISE_GATE_SELECT_5L),
+CS47L35_NG_SRC("SPKDAT1R", MADERA_NOISE_GATE_SELECT_5R),
+
+MADERA_MIXER_CONTROLS("AIF1TX1", MADERA_AIF1TX1MIX_INPUT_1_SOURCE),
+MADERA_MIXER_CONTROLS("AIF1TX2", MADERA_AIF1TX2MIX_INPUT_1_SOURCE),
+MADERA_MIXER_CONTROLS("AIF1TX3", MADERA_AIF1TX3MIX_INPUT_1_SOURCE),
+MADERA_MIXER_CONTROLS("AIF1TX4", MADERA_AIF1TX4MIX_INPUT_1_SOURCE),
+MADERA_MIXER_CONTROLS("AIF1TX5", MADERA_AIF1TX5MIX_INPUT_1_SOURCE),
+MADERA_MIXER_CONTROLS("AIF1TX6", MADERA_AIF1TX6MIX_INPUT_1_SOURCE),
+
+MADERA_MIXER_CONTROLS("AIF2TX1", MADERA_AIF2TX1MIX_INPUT_1_SOURCE),
+MADERA_MIXER_CONTROLS("AIF2TX2", MADERA_AIF2TX2MIX_INPUT_1_SOURCE),
+
+MADERA_MIXER_CONTROLS("AIF3TX1", MADERA_AIF3TX1MIX_INPUT_1_SOURCE),
+MADERA_MIXER_CONTROLS("AIF3TX2", MADERA_AIF3TX2MIX_INPUT_1_SOURCE),
+
+MADERA_MIXER_CONTROLS("SLIMTX1", MADERA_SLIMTX1MIX_INPUT_1_SOURCE),
+MADERA_MIXER_CONTROLS("SLIMTX2", MADERA_SLIMTX2MIX_INPUT_1_SOURCE),
+MADERA_MIXER_CONTROLS("SLIMTX3", MADERA_SLIMTX3MIX_INPUT_1_SOURCE),
+MADERA_MIXER_CONTROLS("SLIMTX4", MADERA_SLIMTX4MIX_INPUT_1_SOURCE),
+MADERA_MIXER_CONTROLS("SLIMTX5", MADERA_SLIMTX5MIX_INPUT_1_SOURCE),
+MADERA_MIXER_CONTROLS("SLIMTX6", MADERA_SLIMTX6MIX_INPUT_1_SOURCE),
+
+MADERA_GAINMUX_CONTROLS("SPDIF1TX1", MADERA_SPDIF1TX1MIX_INPUT_1_SOURCE),
+MADERA_GAINMUX_CONTROLS("SPDIF1TX2", MADERA_SPDIF1TX2MIX_INPUT_1_SOURCE),
+
+WM_ADSP_FW_CONTROL("DSP1", 0),
+WM_ADSP_FW_CONTROL("DSP2", 1),
+WM_ADSP_FW_CONTROL("DSP3", 2),
+};
+
+MADERA_MIXER_ENUMS(EQ1, MADERA_EQ1MIX_INPUT_1_SOURCE);
+MADERA_MIXER_ENUMS(EQ2, MADERA_EQ2MIX_INPUT_1_SOURCE);
+MADERA_MIXER_ENUMS(EQ3, MADERA_EQ3MIX_INPUT_1_SOURCE);
+MADERA_MIXER_ENUMS(EQ4, MADERA_EQ4MIX_INPUT_1_SOURCE);
+
+MADERA_MIXER_ENUMS(DRC1L, MADERA_DRC1LMIX_INPUT_1_SOURCE);
+MADERA_MIXER_ENUMS(DRC1R, MADERA_DRC1RMIX_INPUT_1_SOURCE);
+MADERA_MIXER_ENUMS(DRC2L, MADERA_DRC2LMIX_INPUT_1_SOURCE);
+MADERA_MIXER_ENUMS(DRC2R, MADERA_DRC2RMIX_INPUT_1_SOURCE);
+
+MADERA_MIXER_ENUMS(LHPF1, MADERA_HPLP1MIX_INPUT_1_SOURCE);
+MADERA_MIXER_ENUMS(LHPF2, MADERA_HPLP2MIX_INPUT_1_SOURCE);
+MADERA_MIXER_ENUMS(LHPF3, MADERA_HPLP3MIX_INPUT_1_SOURCE);
+MADERA_MIXER_ENUMS(LHPF4, MADERA_HPLP4MIX_INPUT_1_SOURCE);
+
+MADERA_MIXER_ENUMS(DSP1L, MADERA_DSP1LMIX_INPUT_1_SOURCE);
+MADERA_MIXER_ENUMS(DSP1R, MADERA_DSP1RMIX_INPUT_1_SOURCE);
+MADERA_DSP_AUX_ENUMS(DSP1, MADERA_DSP1AUX1MIX_INPUT_1_SOURCE);
+
+MADERA_MIXER_ENUMS(DSP2L, MADERA_DSP2LMIX_INPUT_1_SOURCE);
+MADERA_MIXER_ENUMS(DSP2R, MADERA_DSP2RMIX_INPUT_1_SOURCE);
+MADERA_DSP_AUX_ENUMS(DSP2, MADERA_DSP2AUX1MIX_INPUT_1_SOURCE);
+
+MADERA_MIXER_ENUMS(DSP3L, MADERA_DSP3LMIX_INPUT_1_SOURCE);
+MADERA_MIXER_ENUMS(DSP3R, MADERA_DSP3RMIX_INPUT_1_SOURCE);
+MADERA_DSP_AUX_ENUMS(DSP3, MADERA_DSP3AUX1MIX_INPUT_1_SOURCE);
+
+MADERA_MIXER_ENUMS(PWM1, MADERA_PWM1MIX_INPUT_1_SOURCE);
+MADERA_MIXER_ENUMS(PWM2, MADERA_PWM2MIX_INPUT_1_SOURCE);
+
+MADERA_MIXER_ENUMS(OUT1L, MADERA_OUT1LMIX_INPUT_1_SOURCE);
+MADERA_MIXER_ENUMS(OUT1R, MADERA_OUT1RMIX_INPUT_1_SOURCE);
+MADERA_MIXER_ENUMS(SPKOUT, MADERA_OUT4LMIX_INPUT_1_SOURCE);
+MADERA_MIXER_ENUMS(SPKDAT1L, MADERA_OUT5LMIX_INPUT_1_SOURCE);
+MADERA_MIXER_ENUMS(SPKDAT1R, MADERA_OUT5RMIX_INPUT_1_SOURCE);
+
+MADERA_MIXER_ENUMS(AIF1TX1, MADERA_AIF1TX1MIX_INPUT_1_SOURCE);
+MADERA_MIXER_ENUMS(AIF1TX2, MADERA_AIF1TX2MIX_INPUT_1_SOURCE);
+MADERA_MIXER_ENUMS(AIF1TX3, MADERA_AIF1TX3MIX_INPUT_1_SOURCE);
+MADERA_MIXER_ENUMS(AIF1TX4, MADERA_AIF1TX4MIX_INPUT_1_SOURCE);
+MADERA_MIXER_ENUMS(AIF1TX5, MADERA_AIF1TX5MIX_INPUT_1_SOURCE);
+MADERA_MIXER_ENUMS(AIF1TX6, MADERA_AIF1TX6MIX_INPUT_1_SOURCE);
+
+MADERA_MIXER_ENUMS(AIF2TX1, MADERA_AIF2TX1MIX_INPUT_1_SOURCE);
+MADERA_MIXER_ENUMS(AIF2TX2, MADERA_AIF2TX2MIX_INPUT_1_SOURCE);
+
+MADERA_MIXER_ENUMS(AIF3TX1, MADERA_AIF3TX1MIX_INPUT_1_SOURCE);
+MADERA_MIXER_ENUMS(AIF3TX2, MADERA_AIF3TX2MIX_INPUT_1_SOURCE);
+
+MADERA_MIXER_ENUMS(SLIMTX1, MADERA_SLIMTX1MIX_INPUT_1_SOURCE);
+MADERA_MIXER_ENUMS(SLIMTX2, MADERA_SLIMTX2MIX_INPUT_1_SOURCE);
+MADERA_MIXER_ENUMS(SLIMTX3, MADERA_SLIMTX3MIX_INPUT_1_SOURCE);
+MADERA_MIXER_ENUMS(SLIMTX4, MADERA_SLIMTX4MIX_INPUT_1_SOURCE);
+MADERA_MIXER_ENUMS(SLIMTX5, MADERA_SLIMTX5MIX_INPUT_1_SOURCE);
+MADERA_MIXER_ENUMS(SLIMTX6, MADERA_SLIMTX6MIX_INPUT_1_SOURCE);
+
+MADERA_MUX_ENUMS(SPD1TX1, MADERA_SPDIF1TX1MIX_INPUT_1_SOURCE);
+MADERA_MUX_ENUMS(SPD1TX2, MADERA_SPDIF1TX2MIX_INPUT_1_SOURCE);
+
+MADERA_MUX_ENUMS(ISRC1INT1, MADERA_ISRC1INT1MIX_INPUT_1_SOURCE);
+MADERA_MUX_ENUMS(ISRC1INT2, MADERA_ISRC1INT2MIX_INPUT_1_SOURCE);
+MADERA_MUX_ENUMS(ISRC1INT3, MADERA_ISRC1INT3MIX_INPUT_1_SOURCE);
+MADERA_MUX_ENUMS(ISRC1INT4, MADERA_ISRC1INT4MIX_INPUT_1_SOURCE);
+
+MADERA_MUX_ENUMS(ISRC1DEC1, MADERA_ISRC1DEC1MIX_INPUT_1_SOURCE);
+MADERA_MUX_ENUMS(ISRC1DEC2, MADERA_ISRC1DEC2MIX_INPUT_1_SOURCE);
+MADERA_MUX_ENUMS(ISRC1DEC3, MADERA_ISRC1DEC3MIX_INPUT_1_SOURCE);
+MADERA_MUX_ENUMS(ISRC1DEC4, MADERA_ISRC1DEC4MIX_INPUT_1_SOURCE);
+
+MADERA_MUX_ENUMS(ISRC2INT1, MADERA_ISRC2INT1MIX_INPUT_1_SOURCE);
+MADERA_MUX_ENUMS(ISRC2INT2, MADERA_ISRC2INT2MIX_INPUT_1_SOURCE);
+MADERA_MUX_ENUMS(ISRC2INT3, MADERA_ISRC2INT3MIX_INPUT_1_SOURCE);
+MADERA_MUX_ENUMS(ISRC2INT4, MADERA_ISRC2INT4MIX_INPUT_1_SOURCE);
+
+MADERA_MUX_ENUMS(ISRC2DEC1, MADERA_ISRC2DEC1MIX_INPUT_1_SOURCE);
+MADERA_MUX_ENUMS(ISRC2DEC2, MADERA_ISRC2DEC2MIX_INPUT_1_SOURCE);
+MADERA_MUX_ENUMS(ISRC2DEC3, MADERA_ISRC2DEC3MIX_INPUT_1_SOURCE);
+MADERA_MUX_ENUMS(ISRC2DEC4, MADERA_ISRC2DEC4MIX_INPUT_1_SOURCE);
+
+static const char * const cs47l35_aec_loopback_texts[] = {
+	"HPOUT1L", "HPOUT1R", "SPKOUT", "SPKDAT1L", "SPKDAT1R",
+};
+
+static const unsigned int cs47l35_aec_loopback_values[] = {
+	0, 1, 6, 8, 9,
+};
+
+static const struct soc_enum cs47l35_aec1_loopback =
+	SOC_VALUE_ENUM_SINGLE(MADERA_DAC_AEC_CONTROL_1,
+			      MADERA_AEC1_LOOPBACK_SRC_SHIFT, 0xf,
+			      ARRAY_SIZE(cs47l35_aec_loopback_texts),
+			      cs47l35_aec_loopback_texts,
+			      cs47l35_aec_loopback_values);
+
+static const struct soc_enum cs47l35_aec2_loopback =
+	SOC_VALUE_ENUM_SINGLE(MADERA_DAC_AEC_CONTROL_2,
+			      MADERA_AEC2_LOOPBACK_SRC_SHIFT, 0xf,
+			      ARRAY_SIZE(cs47l35_aec_loopback_texts),
+			      cs47l35_aec_loopback_texts,
+			      cs47l35_aec_loopback_values);
+
+static const struct snd_kcontrol_new cs47l35_aec_loopback_mux[] = {
+	SOC_DAPM_ENUM("AEC1 Loopback", cs47l35_aec1_loopback),
+	SOC_DAPM_ENUM("AEC2 Loopback", cs47l35_aec2_loopback),
+};
+
+static const struct snd_soc_dapm_widget cs47l35_dapm_widgets[] = {
+SND_SOC_DAPM_SUPPLY("SYSCLK", MADERA_SYSTEM_CLOCK_1, MADERA_SYSCLK_ENA_SHIFT,
+		    0, madera_sysclk_ev,
+		    SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+SND_SOC_DAPM_SUPPLY("OPCLK", MADERA_OUTPUT_SYSTEM_CLOCK,
+		    MADERA_OPCLK_ENA_SHIFT, 0, NULL, 0),
+SND_SOC_DAPM_SUPPLY("DSPCLK", MADERA_DSP_CLOCK_1, 6,
+		    0, NULL, 0),
+
+SND_SOC_DAPM_REGULATOR_SUPPLY("DBVDD2", 0, 0),
+SND_SOC_DAPM_REGULATOR_SUPPLY("CPVDD1", 20, 0),
+SND_SOC_DAPM_REGULATOR_SUPPLY("CPVDD2", 20, 0),
+SND_SOC_DAPM_REGULATOR_SUPPLY("MICVDD", 0, SND_SOC_DAPM_REGULATOR_BYPASS),
+SND_SOC_DAPM_REGULATOR_SUPPLY("SPKVDD", 0, 0),
+
+SND_SOC_DAPM_SUPPLY("MICBIAS1", MADERA_MIC_BIAS_CTRL_1,
+		    MADERA_MICB1_ENA_SHIFT, 0, NULL, 0),
+SND_SOC_DAPM_SUPPLY("MICBIAS2", MADERA_MIC_BIAS_CTRL_2,
+		    MADERA_MICB1_ENA_SHIFT, 0, NULL, 0),
+
+SND_SOC_DAPM_SUPPLY("MICBIAS1A", MADERA_MIC_BIAS_CTRL_5,
+		    MADERA_MICB1A_ENA_SHIFT, 0, NULL, 0),
+SND_SOC_DAPM_SUPPLY("MICBIAS1B", MADERA_MIC_BIAS_CTRL_5,
+		    MADERA_MICB1B_ENA_SHIFT, 0, NULL, 0),
+SND_SOC_DAPM_SUPPLY("MICBIAS2A", MADERA_MIC_BIAS_CTRL_6,
+		    MADERA_MICB2A_ENA_SHIFT, 0, NULL, 0),
+SND_SOC_DAPM_SUPPLY("MICBIAS2B", MADERA_MIC_BIAS_CTRL_6,
+		    MADERA_MICB2B_ENA_SHIFT, 0, NULL, 0),
+
+SND_SOC_DAPM_SUPPLY("FXCLK", SND_SOC_NOPM,
+		    MADERA_DOM_GRP_FX, 0,
+		    madera_domain_clk_ev,
+		    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+SND_SOC_DAPM_SUPPLY("ISRC1CLK", SND_SOC_NOPM,
+		    MADERA_DOM_GRP_ISRC1, 0,
+		    madera_domain_clk_ev,
+		    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+SND_SOC_DAPM_SUPPLY("ISRC2CLK", SND_SOC_NOPM,
+		    MADERA_DOM_GRP_ISRC2, 0,
+		    madera_domain_clk_ev,
+		    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+SND_SOC_DAPM_SUPPLY("OUTCLK", SND_SOC_NOPM,
+		    MADERA_DOM_GRP_OUT, 0,
+		    madera_domain_clk_ev,
+		    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+SND_SOC_DAPM_SUPPLY("SPDCLK", SND_SOC_NOPM,
+		    MADERA_DOM_GRP_SPD, 0,
+		    madera_domain_clk_ev,
+		    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+SND_SOC_DAPM_SUPPLY("DSP1CLK", SND_SOC_NOPM,
+		    MADERA_DOM_GRP_DSP1, 0,
+		    madera_domain_clk_ev,
+		    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+SND_SOC_DAPM_SUPPLY("DSP2CLK", SND_SOC_NOPM,
+		    MADERA_DOM_GRP_DSP2, 0,
+		    madera_domain_clk_ev,
+		    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+SND_SOC_DAPM_SUPPLY("DSP3CLK", SND_SOC_NOPM,
+		    MADERA_DOM_GRP_DSP3, 0,
+		    madera_domain_clk_ev,
+		    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+SND_SOC_DAPM_SUPPLY("AIF1TXCLK", SND_SOC_NOPM,
+		    MADERA_DOM_GRP_AIF1, 0,
+		    madera_domain_clk_ev,
+		    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+SND_SOC_DAPM_SUPPLY("AIF2TXCLK", SND_SOC_NOPM,
+		    MADERA_DOM_GRP_AIF2, 0,
+		    madera_domain_clk_ev,
+		    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+SND_SOC_DAPM_SUPPLY("AIF3TXCLK", SND_SOC_NOPM,
+		    MADERA_DOM_GRP_AIF3, 0,
+		    madera_domain_clk_ev,
+		    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+SND_SOC_DAPM_SUPPLY("SLIMBUSCLK", SND_SOC_NOPM,
+		    MADERA_DOM_GRP_SLIMBUS, 0,
+		    madera_domain_clk_ev,
+		    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+SND_SOC_DAPM_SUPPLY("PWMCLK", SND_SOC_NOPM,
+		    MADERA_DOM_GRP_PWM, 0,
+		    madera_domain_clk_ev,
+		    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+
+SND_SOC_DAPM_SIGGEN("TONE"),
+SND_SOC_DAPM_SIGGEN("NOISE"),
+
+SND_SOC_DAPM_INPUT("IN1AL"),
+SND_SOC_DAPM_INPUT("IN1AR"),
+SND_SOC_DAPM_INPUT("IN1BL"),
+SND_SOC_DAPM_INPUT("IN1BR"),
+SND_SOC_DAPM_INPUT("IN2L"),
+SND_SOC_DAPM_INPUT("IN2R"),
+
+SND_SOC_DAPM_OUTPUT("DRC1 Signal Activity"),
+SND_SOC_DAPM_OUTPUT("DRC2 Signal Activity"),
+
+SND_SOC_DAPM_OUTPUT("DSP Trigger Out"),
+
+SND_SOC_DAPM_MUX("IN1L Mux", SND_SOC_NOPM, 0, 0, &madera_inmux[0]),
+SND_SOC_DAPM_MUX("IN1R Mux", SND_SOC_NOPM, 0, 0, &madera_inmux[1]),
+
+SND_SOC_DAPM_DEMUX("HPOUT1 Demux", SND_SOC_NOPM, 0, 0, &cs47l35_outdemux),
+
+SND_SOC_DAPM_PGA("PWM1 Driver", MADERA_PWM_DRIVE_1, MADERA_PWM1_ENA_SHIFT,
+		 0, NULL, 0),
+SND_SOC_DAPM_PGA("PWM2 Driver", MADERA_PWM_DRIVE_1, MADERA_PWM2_ENA_SHIFT,
+		 0, NULL, 0),
+
+SND_SOC_DAPM_AIF_OUT("AIF1TX1", NULL, 0,
+		     MADERA_AIF1_TX_ENABLES, MADERA_AIF1TX1_ENA_SHIFT, 0),
+SND_SOC_DAPM_AIF_OUT("AIF1TX2", NULL, 0,
+		     MADERA_AIF1_TX_ENABLES, MADERA_AIF1TX2_ENA_SHIFT, 0),
+SND_SOC_DAPM_AIF_OUT("AIF1TX3", NULL, 0,
+		     MADERA_AIF1_TX_ENABLES, MADERA_AIF1TX3_ENA_SHIFT, 0),
+SND_SOC_DAPM_AIF_OUT("AIF1TX4", NULL, 0,
+		     MADERA_AIF1_TX_ENABLES, MADERA_AIF1TX4_ENA_SHIFT, 0),
+SND_SOC_DAPM_AIF_OUT("AIF1TX5", NULL, 0,
+		     MADERA_AIF1_TX_ENABLES, MADERA_AIF1TX5_ENA_SHIFT, 0),
+SND_SOC_DAPM_AIF_OUT("AIF1TX6", NULL, 0,
+		     MADERA_AIF1_TX_ENABLES, MADERA_AIF1TX6_ENA_SHIFT, 0),
+
+SND_SOC_DAPM_AIF_OUT("AIF2TX1", NULL, 0,
+		     MADERA_AIF2_TX_ENABLES, MADERA_AIF2TX1_ENA_SHIFT, 0),
+SND_SOC_DAPM_AIF_OUT("AIF2TX2", NULL, 0,
+		     MADERA_AIF2_TX_ENABLES, MADERA_AIF2TX2_ENA_SHIFT, 0),
+
+SND_SOC_DAPM_AIF_OUT("AIF3TX1", NULL, 0,
+		     MADERA_AIF3_TX_ENABLES, MADERA_AIF3TX1_ENA_SHIFT, 0),
+SND_SOC_DAPM_AIF_OUT("AIF3TX2", NULL, 0,
+		     MADERA_AIF3_TX_ENABLES, MADERA_AIF3TX2_ENA_SHIFT, 0),
+
+SND_SOC_DAPM_AIF_OUT("SLIMTX1", NULL, 0,
+		     MADERA_SLIMBUS_TX_CHANNEL_ENABLE,
+		     MADERA_SLIMTX1_ENA_SHIFT, 0),
+SND_SOC_DAPM_AIF_OUT("SLIMTX2", NULL, 0,
+		     MADERA_SLIMBUS_TX_CHANNEL_ENABLE,
+		     MADERA_SLIMTX2_ENA_SHIFT, 0),
+SND_SOC_DAPM_AIF_OUT("SLIMTX3", NULL, 0,
+		     MADERA_SLIMBUS_TX_CHANNEL_ENABLE,
+		     MADERA_SLIMTX3_ENA_SHIFT, 0),
+SND_SOC_DAPM_AIF_OUT("SLIMTX4", NULL, 0,
+		     MADERA_SLIMBUS_TX_CHANNEL_ENABLE,
+		     MADERA_SLIMTX4_ENA_SHIFT, 0),
+SND_SOC_DAPM_AIF_OUT("SLIMTX5", NULL, 0,
+		     MADERA_SLIMBUS_TX_CHANNEL_ENABLE,
+		     MADERA_SLIMTX5_ENA_SHIFT, 0),
+SND_SOC_DAPM_AIF_OUT("SLIMTX6", NULL, 0,
+		     MADERA_SLIMBUS_TX_CHANNEL_ENABLE,
+		     MADERA_SLIMTX6_ENA_SHIFT, 0),
+
+SND_SOC_DAPM_PGA_E("OUT1L", SND_SOC_NOPM,
+		   MADERA_OUT1L_ENA_SHIFT, 0, NULL, 0, cs47l35_hp_ev,
+		   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD |
+		   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU),
+SND_SOC_DAPM_PGA_E("OUT1R", SND_SOC_NOPM,
+		   MADERA_OUT1R_ENA_SHIFT, 0, NULL, 0, cs47l35_hp_ev,
+		   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD |
+		   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU),
+SND_SOC_DAPM_PGA_E("OUT4L", SND_SOC_NOPM,
+		   MADERA_OUT4L_ENA_SHIFT, 0, NULL, 0, madera_spk_ev,
+		   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+SND_SOC_DAPM_PGA_E("OUT5L", MADERA_OUTPUT_ENABLES_1,
+		   MADERA_OUT5L_ENA_SHIFT, 0, NULL, 0, madera_out_ev,
+		   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMU),
+SND_SOC_DAPM_PGA_E("OUT5R", MADERA_OUTPUT_ENABLES_1,
+		   MADERA_OUT5R_ENA_SHIFT, 0, NULL, 0, madera_out_ev,
+		   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMU),
+
+SND_SOC_DAPM_PGA("SPD1TX1", MADERA_SPD1_TX_CONTROL,
+		 MADERA_SPD1_VAL1_SHIFT, 0, NULL, 0),
+SND_SOC_DAPM_PGA("SPD1TX2", MADERA_SPD1_TX_CONTROL,
+		 MADERA_SPD1_VAL2_SHIFT, 0, NULL, 0),
+SND_SOC_DAPM_OUT_DRV("SPD1", MADERA_SPD1_TX_CONTROL,
+		     MADERA_SPD1_ENA_SHIFT, 0, NULL, 0),
+
+/*
+ * Input mux widgets arranged in order of sources in MADERA_MIXER_INPUT_ROUTES
+ * to take advantage of cache lookup in DAPM
+ */
+SND_SOC_DAPM_PGA("Noise Generator", MADERA_COMFORT_NOISE_GENERATOR,
+		 MADERA_NOISE_GEN_ENA_SHIFT, 0, NULL, 0),
+
+SND_SOC_DAPM_PGA("Tone Generator 1", MADERA_TONE_GENERATOR_1,
+		 MADERA_TONE1_ENA_SHIFT, 0, NULL, 0),
+SND_SOC_DAPM_PGA("Tone Generator 2", MADERA_TONE_GENERATOR_1,
+		 MADERA_TONE2_ENA_SHIFT, 0, NULL, 0),
+
+SND_SOC_DAPM_SIGGEN("HAPTICS"),
+
+SND_SOC_DAPM_MUX("AEC1 Loopback", MADERA_DAC_AEC_CONTROL_1,
+		 MADERA_AEC1_LOOPBACK_ENA_SHIFT, 0,
+		 &cs47l35_aec_loopback_mux[0]),
+
+SND_SOC_DAPM_MUX("AEC2 Loopback", MADERA_DAC_AEC_CONTROL_2,
+		 MADERA_AEC2_LOOPBACK_ENA_SHIFT, 0,
+		 &cs47l35_aec_loopback_mux[1]),
+
+SND_SOC_DAPM_PGA_E("IN1L PGA", MADERA_INPUT_ENABLES, MADERA_IN1L_ENA_SHIFT,
+		   0, NULL, 0, madera_in_ev,
+		   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD |
+		   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU),
+SND_SOC_DAPM_PGA_E("IN1R PGA", MADERA_INPUT_ENABLES, MADERA_IN1R_ENA_SHIFT,
+		   0, NULL, 0, madera_in_ev,
+		   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD |
+		   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU),
+SND_SOC_DAPM_PGA_E("IN2L PGA", MADERA_INPUT_ENABLES, MADERA_IN2L_ENA_SHIFT,
+		   0, NULL, 0, madera_in_ev,
+		   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD |
+		   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU),
+SND_SOC_DAPM_PGA_E("IN2R PGA", MADERA_INPUT_ENABLES, MADERA_IN2R_ENA_SHIFT,
+		   0, NULL, 0, madera_in_ev,
+		   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD |
+		   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU),
+
+SND_SOC_DAPM_AIF_IN("AIF1RX1", NULL, 0,
+		    MADERA_AIF1_RX_ENABLES, MADERA_AIF1RX1_ENA_SHIFT, 0),
+SND_SOC_DAPM_AIF_IN("AIF1RX2", NULL, 0,
+		    MADERA_AIF1_RX_ENABLES, MADERA_AIF1RX2_ENA_SHIFT, 0),
+SND_SOC_DAPM_AIF_IN("AIF1RX3", NULL, 0,
+		    MADERA_AIF1_RX_ENABLES, MADERA_AIF1RX3_ENA_SHIFT, 0),
+SND_SOC_DAPM_AIF_IN("AIF1RX4", NULL, 0,
+		    MADERA_AIF1_RX_ENABLES, MADERA_AIF1RX4_ENA_SHIFT, 0),
+SND_SOC_DAPM_AIF_IN("AIF1RX5", NULL, 0,
+		    MADERA_AIF1_RX_ENABLES, MADERA_AIF1RX5_ENA_SHIFT, 0),
+SND_SOC_DAPM_AIF_IN("AIF1RX6", NULL, 0,
+		    MADERA_AIF1_RX_ENABLES, MADERA_AIF1RX6_ENA_SHIFT, 0),
+
+SND_SOC_DAPM_AIF_IN("AIF2RX1", NULL, 0,
+		    MADERA_AIF2_RX_ENABLES, MADERA_AIF2RX1_ENA_SHIFT, 0),
+SND_SOC_DAPM_AIF_IN("AIF2RX2", NULL, 0,
+		    MADERA_AIF2_RX_ENABLES, MADERA_AIF2RX2_ENA_SHIFT, 0),
+
+SND_SOC_DAPM_AIF_IN("AIF3RX1", NULL, 0,
+		    MADERA_AIF3_RX_ENABLES, MADERA_AIF3RX1_ENA_SHIFT, 0),
+SND_SOC_DAPM_AIF_IN("AIF3RX2", NULL, 0,
+		    MADERA_AIF3_RX_ENABLES, MADERA_AIF3RX2_ENA_SHIFT, 0),
+
+SND_SOC_DAPM_AIF_IN("SLIMRX1", NULL, 0,
+		    MADERA_SLIMBUS_RX_CHANNEL_ENABLE,
+		    MADERA_SLIMRX1_ENA_SHIFT, 0),
+SND_SOC_DAPM_AIF_IN("SLIMRX2", NULL, 0,
+		    MADERA_SLIMBUS_RX_CHANNEL_ENABLE,
+		    MADERA_SLIMRX2_ENA_SHIFT, 0),
+SND_SOC_DAPM_AIF_IN("SLIMRX3", NULL, 0,
+		    MADERA_SLIMBUS_RX_CHANNEL_ENABLE,
+		    MADERA_SLIMRX3_ENA_SHIFT, 0),
+SND_SOC_DAPM_AIF_IN("SLIMRX4", NULL, 0,
+		    MADERA_SLIMBUS_RX_CHANNEL_ENABLE,
+		    MADERA_SLIMRX4_ENA_SHIFT, 0),
+SND_SOC_DAPM_AIF_IN("SLIMRX5", NULL, 0,
+		    MADERA_SLIMBUS_RX_CHANNEL_ENABLE,
+		    MADERA_SLIMRX5_ENA_SHIFT, 0),
+SND_SOC_DAPM_AIF_IN("SLIMRX6", NULL, 0,
+		    MADERA_SLIMBUS_RX_CHANNEL_ENABLE,
+		    MADERA_SLIMRX6_ENA_SHIFT, 0),
+
+SND_SOC_DAPM_PGA("EQ1", MADERA_EQ1_1, MADERA_EQ1_ENA_SHIFT, 0, NULL, 0),
+SND_SOC_DAPM_PGA("EQ2", MADERA_EQ2_1, MADERA_EQ2_ENA_SHIFT, 0, NULL, 0),
+SND_SOC_DAPM_PGA("EQ3", MADERA_EQ3_1, MADERA_EQ3_ENA_SHIFT, 0, NULL, 0),
+SND_SOC_DAPM_PGA("EQ4", MADERA_EQ4_1, MADERA_EQ4_ENA_SHIFT, 0, NULL, 0),
+
+SND_SOC_DAPM_PGA("DRC1L", MADERA_DRC1_CTRL1, MADERA_DRC1L_ENA_SHIFT, 0,
+		 NULL, 0),
+SND_SOC_DAPM_PGA("DRC1R", MADERA_DRC1_CTRL1, MADERA_DRC1R_ENA_SHIFT, 0,
+		 NULL, 0),
+SND_SOC_DAPM_PGA("DRC2L", MADERA_DRC2_CTRL1, MADERA_DRC2L_ENA_SHIFT, 0,
+		 NULL, 0),
+SND_SOC_DAPM_PGA("DRC2R", MADERA_DRC2_CTRL1, MADERA_DRC2R_ENA_SHIFT, 0,
+		 NULL, 0),
+
+SND_SOC_DAPM_PGA("LHPF1", MADERA_HPLPF1_1, MADERA_LHPF1_ENA_SHIFT, 0,
+		 NULL, 0),
+SND_SOC_DAPM_PGA("LHPF2", MADERA_HPLPF2_1, MADERA_LHPF2_ENA_SHIFT, 0,
+		 NULL, 0),
+SND_SOC_DAPM_PGA("LHPF3", MADERA_HPLPF3_1, MADERA_LHPF3_ENA_SHIFT, 0,
+		 NULL, 0),
+SND_SOC_DAPM_PGA("LHPF4", MADERA_HPLPF4_1, MADERA_LHPF4_ENA_SHIFT, 0,
+		 NULL, 0),
+
+SND_SOC_DAPM_PGA("ISRC1DEC1", MADERA_ISRC_1_CTRL_3,
+		 MADERA_ISRC1_DEC1_ENA_SHIFT, 0, NULL, 0),
+SND_SOC_DAPM_PGA("ISRC1DEC2", MADERA_ISRC_1_CTRL_3,
+		 MADERA_ISRC1_DEC2_ENA_SHIFT, 0, NULL, 0),
+SND_SOC_DAPM_PGA("ISRC1DEC3", MADERA_ISRC_1_CTRL_3,
+		 MADERA_ISRC1_DEC3_ENA_SHIFT, 0, NULL, 0),
+SND_SOC_DAPM_PGA("ISRC1DEC4", MADERA_ISRC_1_CTRL_3,
+		 MADERA_ISRC1_DEC4_ENA_SHIFT, 0, NULL, 0),
+
+SND_SOC_DAPM_PGA("ISRC1INT1", MADERA_ISRC_1_CTRL_3,
+		 MADERA_ISRC1_INT1_ENA_SHIFT, 0, NULL, 0),
+SND_SOC_DAPM_PGA("ISRC1INT2", MADERA_ISRC_1_CTRL_3,
+		 MADERA_ISRC1_INT2_ENA_SHIFT, 0, NULL, 0),
+SND_SOC_DAPM_PGA("ISRC1INT3", MADERA_ISRC_1_CTRL_3,
+		 MADERA_ISRC1_INT3_ENA_SHIFT, 0, NULL, 0),
+SND_SOC_DAPM_PGA("ISRC1INT4", MADERA_ISRC_1_CTRL_3,
+		 MADERA_ISRC1_INT4_ENA_SHIFT, 0, NULL, 0),
+
+SND_SOC_DAPM_PGA("ISRC2DEC1", MADERA_ISRC_2_CTRL_3,
+		 MADERA_ISRC2_DEC1_ENA_SHIFT, 0, NULL, 0),
+SND_SOC_DAPM_PGA("ISRC2DEC2", MADERA_ISRC_2_CTRL_3,
+		 MADERA_ISRC2_DEC2_ENA_SHIFT, 0, NULL, 0),
+SND_SOC_DAPM_PGA("ISRC2DEC3", MADERA_ISRC_2_CTRL_3,
+		 MADERA_ISRC2_DEC3_ENA_SHIFT, 0, NULL, 0),
+SND_SOC_DAPM_PGA("ISRC2DEC4", MADERA_ISRC_2_CTRL_3,
+		 MADERA_ISRC2_DEC4_ENA_SHIFT, 0, NULL, 0),
+
+SND_SOC_DAPM_PGA("ISRC2INT1", MADERA_ISRC_2_CTRL_3,
+		 MADERA_ISRC2_INT1_ENA_SHIFT, 0, NULL, 0),
+SND_SOC_DAPM_PGA("ISRC2INT2", MADERA_ISRC_2_CTRL_3,
+		 MADERA_ISRC2_INT2_ENA_SHIFT, 0, NULL, 0),
+SND_SOC_DAPM_PGA("ISRC2INT3", MADERA_ISRC_2_CTRL_3,
+		 MADERA_ISRC2_INT3_ENA_SHIFT, 0, NULL, 0),
+SND_SOC_DAPM_PGA("ISRC2INT4", MADERA_ISRC_2_CTRL_3,
+		 MADERA_ISRC2_INT4_ENA_SHIFT, 0, NULL, 0),
+
+WM_ADSP2("DSP1", 0, cs47l35_adsp_power_ev),
+WM_ADSP2("DSP2", 1, cs47l35_adsp_power_ev),
+WM_ADSP2("DSP3", 2, cs47l35_adsp_power_ev),
+
+/* End of ordered input mux widgets */
+
+MADERA_MIXER_WIDGETS(EQ1, "EQ1"),
+MADERA_MIXER_WIDGETS(EQ2, "EQ2"),
+MADERA_MIXER_WIDGETS(EQ3, "EQ3"),
+MADERA_MIXER_WIDGETS(EQ4, "EQ4"),
+
+MADERA_MIXER_WIDGETS(DRC1L, "DRC1L"),
+MADERA_MIXER_WIDGETS(DRC1R, "DRC1R"),
+MADERA_MIXER_WIDGETS(DRC2L, "DRC2L"),
+MADERA_MIXER_WIDGETS(DRC2R, "DRC2R"),
+
+SND_SOC_DAPM_SWITCH("DRC1 Activity Output", SND_SOC_NOPM, 0, 0,
+		    &madera_drc_activity_output_mux[0]),
+SND_SOC_DAPM_SWITCH("DRC2 Activity Output", SND_SOC_NOPM, 0, 0,
+		    &madera_drc_activity_output_mux[1]),
+
+MADERA_MIXER_WIDGETS(LHPF1, "LHPF1"),
+MADERA_MIXER_WIDGETS(LHPF2, "LHPF2"),
+MADERA_MIXER_WIDGETS(LHPF3, "LHPF3"),
+MADERA_MIXER_WIDGETS(LHPF4, "LHPF4"),
+
+MADERA_MIXER_WIDGETS(PWM1, "PWM1"),
+MADERA_MIXER_WIDGETS(PWM2, "PWM2"),
+
+MADERA_MIXER_WIDGETS(OUT1L, "HPOUT1L"),
+MADERA_MIXER_WIDGETS(OUT1R, "HPOUT1R"),
+MADERA_MIXER_WIDGETS(SPKOUT, "SPKOUT"),
+MADERA_MIXER_WIDGETS(SPKDAT1L, "SPKDAT1L"),
+MADERA_MIXER_WIDGETS(SPKDAT1R, "SPKDAT1R"),
+
+MADERA_MIXER_WIDGETS(AIF1TX1, "AIF1TX1"),
+MADERA_MIXER_WIDGETS(AIF1TX2, "AIF1TX2"),
+MADERA_MIXER_WIDGETS(AIF1TX3, "AIF1TX3"),
+MADERA_MIXER_WIDGETS(AIF1TX4, "AIF1TX4"),
+MADERA_MIXER_WIDGETS(AIF1TX5, "AIF1TX5"),
+MADERA_MIXER_WIDGETS(AIF1TX6, "AIF1TX6"),
+
+MADERA_MIXER_WIDGETS(AIF2TX1, "AIF2TX1"),
+MADERA_MIXER_WIDGETS(AIF2TX2, "AIF2TX2"),
+
+MADERA_MIXER_WIDGETS(AIF3TX1, "AIF3TX1"),
+MADERA_MIXER_WIDGETS(AIF3TX2, "AIF3TX2"),
+
+MADERA_MIXER_WIDGETS(SLIMTX1, "SLIMTX1"),
+MADERA_MIXER_WIDGETS(SLIMTX2, "SLIMTX2"),
+MADERA_MIXER_WIDGETS(SLIMTX3, "SLIMTX3"),
+MADERA_MIXER_WIDGETS(SLIMTX4, "SLIMTX4"),
+MADERA_MIXER_WIDGETS(SLIMTX5, "SLIMTX5"),
+MADERA_MIXER_WIDGETS(SLIMTX6, "SLIMTX6"),
+
+MADERA_MUX_WIDGETS(SPD1TX1, "SPDIF1TX1"),
+MADERA_MUX_WIDGETS(SPD1TX2, "SPDIF1TX2"),
+
+MADERA_DSP_WIDGETS(DSP1, "DSP1"),
+MADERA_DSP_WIDGETS(DSP2, "DSP2"),
+MADERA_DSP_WIDGETS(DSP3, "DSP3"),
+
+SND_SOC_DAPM_SWITCH("DSP1 Trigger Output", SND_SOC_NOPM, 0, 0,
+		    &madera_dsp_trigger_output_mux[0]),
+SND_SOC_DAPM_SWITCH("DSP2 Trigger Output", SND_SOC_NOPM, 0, 0,
+		    &madera_dsp_trigger_output_mux[1]),
+SND_SOC_DAPM_SWITCH("DSP3 Trigger Output", SND_SOC_NOPM, 0, 0,
+		    &madera_dsp_trigger_output_mux[2]),
+
+MADERA_MUX_WIDGETS(ISRC1DEC1, "ISRC1DEC1"),
+MADERA_MUX_WIDGETS(ISRC1DEC2, "ISRC1DEC2"),
+MADERA_MUX_WIDGETS(ISRC1DEC3, "ISRC1DEC3"),
+MADERA_MUX_WIDGETS(ISRC1DEC4, "ISRC1DEC4"),
+
+MADERA_MUX_WIDGETS(ISRC1INT1, "ISRC1INT1"),
+MADERA_MUX_WIDGETS(ISRC1INT2, "ISRC1INT2"),
+MADERA_MUX_WIDGETS(ISRC1INT3, "ISRC1INT3"),
+MADERA_MUX_WIDGETS(ISRC1INT4, "ISRC1INT4"),
+
+MADERA_MUX_WIDGETS(ISRC2DEC1, "ISRC2DEC1"),
+MADERA_MUX_WIDGETS(ISRC2DEC2, "ISRC2DEC2"),
+MADERA_MUX_WIDGETS(ISRC2DEC3, "ISRC2DEC3"),
+MADERA_MUX_WIDGETS(ISRC2DEC4, "ISRC2DEC4"),
+
+MADERA_MUX_WIDGETS(ISRC2INT1, "ISRC2INT1"),
+MADERA_MUX_WIDGETS(ISRC2INT2, "ISRC2INT2"),
+MADERA_MUX_WIDGETS(ISRC2INT3, "ISRC2INT3"),
+MADERA_MUX_WIDGETS(ISRC2INT4, "ISRC2INT4"),
+
+SND_SOC_DAPM_OUTPUT("HPOUTL"),
+SND_SOC_DAPM_OUTPUT("HPOUTR"),
+SND_SOC_DAPM_OUTPUT("EPOUTP"),
+SND_SOC_DAPM_OUTPUT("EPOUTN"),
+SND_SOC_DAPM_OUTPUT("SPKOUTN"),
+SND_SOC_DAPM_OUTPUT("SPKOUTP"),
+SND_SOC_DAPM_OUTPUT("SPKDAT1L"),
+SND_SOC_DAPM_OUTPUT("SPKDAT1R"),
+SND_SOC_DAPM_OUTPUT("SPDIF1"),
+
+SND_SOC_DAPM_OUTPUT("MICSUPP"),
+};
+
+#define MADERA_MIXER_INPUT_ROUTES(name)	\
+	{ name, "Noise Generator", "Noise Generator" }, \
+	{ name, "Tone Generator 1", "Tone Generator 1" }, \
+	{ name, "Tone Generator 2", "Tone Generator 2" }, \
+	{ name, "Haptics", "HAPTICS" }, \
+	{ name, "AEC1", "AEC1 Loopback" }, \
+	{ name, "AEC2", "AEC2 Loopback" }, \
+	{ name, "IN1L", "IN1L PGA" }, \
+	{ name, "IN1R", "IN1R PGA" }, \
+	{ name, "IN2L", "IN2L PGA" }, \
+	{ name, "IN2R", "IN2R PGA" }, \
+	{ name, "AIF1RX1", "AIF1RX1" }, \
+	{ name, "AIF1RX2", "AIF1RX2" }, \
+	{ name, "AIF1RX3", "AIF1RX3" }, \
+	{ name, "AIF1RX4", "AIF1RX4" }, \
+	{ name, "AIF1RX5", "AIF1RX5" }, \
+	{ name, "AIF1RX6", "AIF1RX6" }, \
+	{ name, "AIF2RX1", "AIF2RX1" }, \
+	{ name, "AIF2RX2", "AIF2RX2" }, \
+	{ name, "AIF3RX1", "AIF3RX1" }, \
+	{ name, "AIF3RX2", "AIF3RX2" }, \
+	{ name, "SLIMRX1", "SLIMRX1" }, \
+	{ name, "SLIMRX2", "SLIMRX2" }, \
+	{ name, "SLIMRX3", "SLIMRX3" }, \
+	{ name, "SLIMRX4", "SLIMRX4" }, \
+	{ name, "SLIMRX5", "SLIMRX5" }, \
+	{ name, "SLIMRX6", "SLIMRX6" }, \
+	{ name, "EQ1", "EQ1" }, \
+	{ name, "EQ2", "EQ2" }, \
+	{ name, "EQ3", "EQ3" }, \
+	{ name, "EQ4", "EQ4" }, \
+	{ name, "DRC1L", "DRC1L" }, \
+	{ name, "DRC1R", "DRC1R" }, \
+	{ name, "DRC2L", "DRC2L" }, \
+	{ name, "DRC2R", "DRC2R" }, \
+	{ name, "LHPF1", "LHPF1" }, \
+	{ name, "LHPF2", "LHPF2" }, \
+	{ name, "LHPF3", "LHPF3" }, \
+	{ name, "LHPF4", "LHPF4" }, \
+	{ name, "ISRC1DEC1", "ISRC1DEC1" }, \
+	{ name, "ISRC1DEC2", "ISRC1DEC2" }, \
+	{ name, "ISRC1DEC3", "ISRC1DEC3" }, \
+	{ name, "ISRC1DEC4", "ISRC1DEC4" }, \
+	{ name, "ISRC1INT1", "ISRC1INT1" }, \
+	{ name, "ISRC1INT2", "ISRC1INT2" }, \
+	{ name, "ISRC1INT3", "ISRC1INT3" }, \
+	{ name, "ISRC1INT4", "ISRC1INT4" }, \
+	{ name, "ISRC2DEC1", "ISRC2DEC1" }, \
+	{ name, "ISRC2DEC2", "ISRC2DEC2" }, \
+	{ name, "ISRC2DEC3", "ISRC2DEC3" }, \
+	{ name, "ISRC2DEC4", "ISRC2DEC4" }, \
+	{ name, "ISRC2INT1", "ISRC2INT1" }, \
+	{ name, "ISRC2INT2", "ISRC2INT2" }, \
+	{ name, "ISRC2INT3", "ISRC2INT3" }, \
+	{ name, "ISRC2INT4", "ISRC2INT4" }, \
+	{ name, "DSP1.1", "DSP1" }, \
+	{ name, "DSP1.2", "DSP1" }, \
+	{ name, "DSP1.3", "DSP1" }, \
+	{ name, "DSP1.4", "DSP1" }, \
+	{ name, "DSP1.5", "DSP1" }, \
+	{ name, "DSP1.6", "DSP1" }, \
+	{ name, "DSP2.1", "DSP2" }, \
+	{ name, "DSP2.2", "DSP2" }, \
+	{ name, "DSP2.3", "DSP2" }, \
+	{ name, "DSP2.4", "DSP2" }, \
+	{ name, "DSP2.5", "DSP2" }, \
+	{ name, "DSP2.6", "DSP2" }, \
+	{ name, "DSP3.1", "DSP3" }, \
+	{ name, "DSP3.2", "DSP3" }, \
+	{ name, "DSP3.3", "DSP3" }, \
+	{ name, "DSP3.4", "DSP3" }, \
+	{ name, "DSP3.5", "DSP3" }, \
+	{ name, "DSP3.6", "DSP3" }
+
+static const struct snd_soc_dapm_route cs47l35_dapm_routes[] = {
+	/* Internal clock domains */
+	{ "EQ1", NULL, "FXCLK" },
+	{ "EQ2", NULL, "FXCLK" },
+	{ "EQ3", NULL, "FXCLK" },
+	{ "EQ4", NULL, "FXCLK" },
+	{ "DRC1L", NULL, "FXCLK" },
+	{ "DRC1R", NULL, "FXCLK" },
+	{ "DRC2L", NULL, "FXCLK" },
+	{ "DRC2R", NULL, "FXCLK" },
+	{ "LHPF1", NULL, "FXCLK" },
+	{ "LHPF2", NULL, "FXCLK" },
+	{ "LHPF3", NULL, "FXCLK" },
+	{ "LHPF4", NULL, "FXCLK" },
+	{ "PWM1 Mixer", NULL, "PWMCLK" },
+	{ "PWM2 Mixer", NULL, "PWMCLK" },
+	{ "OUT1L", NULL, "OUTCLK" },
+	{ "OUT1R", NULL, "OUTCLK" },
+	{ "OUT4L", NULL, "OUTCLK" },
+	{ "OUT5L", NULL, "OUTCLK" },
+	{ "OUT5R", NULL, "OUTCLK" },
+	{ "AIF1TX1", NULL, "AIF1TXCLK" },
+	{ "AIF1TX2", NULL, "AIF1TXCLK" },
+	{ "AIF1TX3", NULL, "AIF1TXCLK" },
+	{ "AIF1TX4", NULL, "AIF1TXCLK" },
+	{ "AIF1TX5", NULL, "AIF1TXCLK" },
+	{ "AIF1TX6", NULL, "AIF1TXCLK" },
+	{ "AIF2TX1", NULL, "AIF2TXCLK" },
+	{ "AIF2TX2", NULL, "AIF2TXCLK" },
+	{ "AIF3TX1", NULL, "AIF3TXCLK" },
+	{ "AIF3TX2", NULL, "AIF3TXCLK" },
+	{ "SLIMTX1", NULL, "SLIMBUSCLK" },
+	{ "SLIMTX2", NULL, "SLIMBUSCLK" },
+	{ "SLIMTX3", NULL, "SLIMBUSCLK" },
+	{ "SLIMTX4", NULL, "SLIMBUSCLK" },
+	{ "SLIMTX5", NULL, "SLIMBUSCLK" },
+	{ "SLIMTX6", NULL, "SLIMBUSCLK" },
+	{ "SPD1TX1", NULL, "SPDCLK" },
+	{ "SPD1TX2", NULL, "SPDCLK" },
+	{ "DSP1", NULL, "DSP1CLK" },
+	{ "DSP2", NULL, "DSP2CLK" },
+	{ "DSP3", NULL, "DSP3CLK" },
+	{ "ISRC1DEC1", NULL, "ISRC1CLK" },
+	{ "ISRC1DEC2", NULL, "ISRC1CLK" },
+	{ "ISRC1DEC3", NULL, "ISRC1CLK" },
+	{ "ISRC1DEC4", NULL, "ISRC1CLK" },
+	{ "ISRC1INT1", NULL, "ISRC1CLK" },
+	{ "ISRC1INT2", NULL, "ISRC1CLK" },
+	{ "ISRC1INT3", NULL, "ISRC1CLK" },
+	{ "ISRC1INT4", NULL, "ISRC1CLK" },
+	{ "ISRC2DEC1", NULL, "ISRC2CLK" },
+	{ "ISRC2DEC2", NULL, "ISRC2CLK" },
+	{ "ISRC2DEC3", NULL, "ISRC2CLK" },
+	{ "ISRC2DEC4", NULL, "ISRC2CLK" },
+	{ "ISRC2INT1", NULL, "ISRC2CLK" },
+	{ "ISRC2INT2", NULL, "ISRC2CLK" },
+	{ "ISRC2INT3", NULL, "ISRC2CLK" },
+	{ "ISRC2INT4", NULL, "ISRC2CLK" },
+
+	{ "AIF2 Capture", NULL, "DBVDD2" },
+	{ "AIF2 Playback", NULL, "DBVDD2" },
+
+	{ "AIF3 Capture", NULL, "DBVDD2" },
+	{ "AIF3 Playback", NULL, "DBVDD2" },
+
+	{ "OUT1L", NULL, "CPVDD1" },
+	{ "OUT1R", NULL, "CPVDD1" },
+	{ "OUT1L", NULL, "CPVDD2" },
+	{ "OUT1R", NULL, "CPVDD2" },
+
+	{ "OUT4L", NULL, "SPKVDD" },
+
+	{ "OUT1L", NULL, "SYSCLK" },
+	{ "OUT1R", NULL, "SYSCLK" },
+	{ "OUT4L", NULL, "SYSCLK" },
+	{ "OUT5L", NULL, "SYSCLK" },
+	{ "OUT5R", NULL, "SYSCLK" },
+
+	{ "SPD1", NULL, "SYSCLK" },
+	{ "SPD1", NULL, "SPD1TX1" },
+	{ "SPD1", NULL, "SPD1TX2" },
+
+	{ "IN1AL", NULL, "SYSCLK" },
+	{ "IN1AR", NULL, "SYSCLK" },
+	{ "IN1BL", NULL, "SYSCLK" },
+	{ "IN1BR", NULL, "SYSCLK" },
+	{ "IN2L", NULL, "SYSCLK" },
+	{ "IN2R", NULL, "SYSCLK" },
+
+	{ "MICBIAS1", NULL, "MICVDD" },
+	{ "MICBIAS2", NULL, "MICVDD" },
+
+	{ "MICBIAS1A", NULL, "MICBIAS1" },
+	{ "MICBIAS1B", NULL, "MICBIAS1" },
+	{ "MICBIAS2A", NULL, "MICBIAS2" },
+	{ "MICBIAS2B", NULL, "MICBIAS2" },
+
+	{ "Noise Generator", NULL, "SYSCLK" },
+	{ "Tone Generator 1", NULL, "SYSCLK" },
+	{ "Tone Generator 2", NULL, "SYSCLK" },
+
+	{ "Noise Generator", NULL, "NOISE" },
+	{ "Tone Generator 1", NULL, "TONE" },
+	{ "Tone Generator 2", NULL, "TONE" },
+
+	{ "AIF1 Capture", NULL, "AIF1TX1" },
+	{ "AIF1 Capture", NULL, "AIF1TX2" },
+	{ "AIF1 Capture", NULL, "AIF1TX3" },
+	{ "AIF1 Capture", NULL, "AIF1TX4" },
+	{ "AIF1 Capture", NULL, "AIF1TX5" },
+	{ "AIF1 Capture", NULL, "AIF1TX6" },
+
+	{ "AIF1RX1", NULL, "AIF1 Playback" },
+	{ "AIF1RX2", NULL, "AIF1 Playback" },
+	{ "AIF1RX3", NULL, "AIF1 Playback" },
+	{ "AIF1RX4", NULL, "AIF1 Playback" },
+	{ "AIF1RX5", NULL, "AIF1 Playback" },
+	{ "AIF1RX6", NULL, "AIF1 Playback" },
+
+	{ "AIF2 Capture", NULL, "AIF2TX1" },
+	{ "AIF2 Capture", NULL, "AIF2TX2" },
+
+	{ "AIF2RX1", NULL, "AIF2 Playback" },
+	{ "AIF2RX2", NULL, "AIF2 Playback" },
+
+	{ "AIF3 Capture", NULL, "AIF3TX1" },
+	{ "AIF3 Capture", NULL, "AIF3TX2" },
+
+	{ "AIF3RX1", NULL, "AIF3 Playback" },
+	{ "AIF3RX2", NULL, "AIF3 Playback" },
+
+	{ "Slim1 Capture", NULL, "SLIMTX1" },
+	{ "Slim1 Capture", NULL, "SLIMTX2" },
+	{ "Slim1 Capture", NULL, "SLIMTX3" },
+	{ "Slim1 Capture", NULL, "SLIMTX4" },
+
+	{ "SLIMRX1", NULL, "Slim1 Playback" },
+	{ "SLIMRX2", NULL, "Slim1 Playback" },
+	{ "SLIMRX3", NULL, "Slim1 Playback" },
+	{ "SLIMRX4", NULL, "Slim1 Playback" },
+
+	{ "Slim2 Capture", NULL, "SLIMTX5" },
+	{ "Slim2 Capture", NULL, "SLIMTX6" },
+
+	{ "SLIMRX5", NULL, "Slim2 Playback" },
+	{ "SLIMRX6", NULL, "Slim2 Playback" },
+
+	{ "AIF1 Playback", NULL, "SYSCLK" },
+	{ "AIF2 Playback", NULL, "SYSCLK" },
+	{ "AIF3 Playback", NULL, "SYSCLK" },
+	{ "Slim1 Playback", NULL, "SYSCLK" },
+	{ "Slim2 Playback", NULL, "SYSCLK" },
+
+	{ "AIF1 Capture", NULL, "SYSCLK" },
+	{ "AIF2 Capture", NULL, "SYSCLK" },
+	{ "AIF3 Capture", NULL, "SYSCLK" },
+	{ "Slim1 Capture", NULL, "SYSCLK" },
+	{ "Slim2 Capture", NULL, "SYSCLK" },
+
+	{ "Voice Control DSP", NULL, "DSP3" },
+
+	{ "Audio Trace DSP", NULL, "DSP1" },
+
+	{ "IN1L Mux", "A", "IN1AL" },
+	{ "IN1L Mux", "B", "IN1BL" },
+	{ "IN1R Mux", "A", "IN1AR" },
+	{ "IN1R Mux", "B", "IN1BR" },
+
+	{ "IN1L PGA", NULL, "IN1L Mux" },
+	{ "IN1R PGA", NULL, "IN1R Mux" },
+
+	{ "IN2L PGA", NULL, "IN2L" },
+	{ "IN2R PGA", NULL, "IN2R" },
+
+	MADERA_MIXER_ROUTES("OUT1L", "HPOUT1L"),
+	MADERA_MIXER_ROUTES("OUT1R", "HPOUT1R"),
+
+	MADERA_MIXER_ROUTES("OUT4L", "SPKOUT"),
+
+	MADERA_MIXER_ROUTES("OUT5L", "SPKDAT1L"),
+	MADERA_MIXER_ROUTES("OUT5R", "SPKDAT1R"),
+
+	MADERA_MIXER_ROUTES("PWM1 Driver", "PWM1"),
+	MADERA_MIXER_ROUTES("PWM2 Driver", "PWM2"),
+
+	MADERA_MIXER_ROUTES("AIF1TX1", "AIF1TX1"),
+	MADERA_MIXER_ROUTES("AIF1TX2", "AIF1TX2"),
+	MADERA_MIXER_ROUTES("AIF1TX3", "AIF1TX3"),
+	MADERA_MIXER_ROUTES("AIF1TX4", "AIF1TX4"),
+	MADERA_MIXER_ROUTES("AIF1TX5", "AIF1TX5"),
+	MADERA_MIXER_ROUTES("AIF1TX6", "AIF1TX6"),
+
+	MADERA_MIXER_ROUTES("AIF2TX1", "AIF2TX1"),
+	MADERA_MIXER_ROUTES("AIF2TX2", "AIF2TX2"),
+
+	MADERA_MIXER_ROUTES("AIF3TX1", "AIF3TX1"),
+	MADERA_MIXER_ROUTES("AIF3TX2", "AIF3TX2"),
+
+	MADERA_MIXER_ROUTES("SLIMTX1", "SLIMTX1"),
+	MADERA_MIXER_ROUTES("SLIMTX2", "SLIMTX2"),
+	MADERA_MIXER_ROUTES("SLIMTX3", "SLIMTX3"),
+	MADERA_MIXER_ROUTES("SLIMTX4", "SLIMTX4"),
+	MADERA_MIXER_ROUTES("SLIMTX5", "SLIMTX5"),
+	MADERA_MIXER_ROUTES("SLIMTX6", "SLIMTX6"),
+
+	MADERA_MUX_ROUTES("SPD1TX1", "SPDIF1TX1"),
+	MADERA_MUX_ROUTES("SPD1TX2", "SPDIF1TX2"),
+
+	MADERA_MIXER_ROUTES("EQ1", "EQ1"),
+	MADERA_MIXER_ROUTES("EQ2", "EQ2"),
+	MADERA_MIXER_ROUTES("EQ3", "EQ3"),
+	MADERA_MIXER_ROUTES("EQ4", "EQ4"),
+
+	MADERA_MIXER_ROUTES("DRC1L", "DRC1L"),
+	MADERA_MIXER_ROUTES("DRC1R", "DRC1R"),
+	MADERA_MIXER_ROUTES("DRC2L", "DRC2L"),
+	MADERA_MIXER_ROUTES("DRC2R", "DRC2R"),
+
+	MADERA_MIXER_ROUTES("LHPF1", "LHPF1"),
+	MADERA_MIXER_ROUTES("LHPF2", "LHPF2"),
+	MADERA_MIXER_ROUTES("LHPF3", "LHPF3"),
+	MADERA_MIXER_ROUTES("LHPF4", "LHPF4"),
+
+	MADERA_DSP_ROUTES("DSP1"),
+	MADERA_DSP_ROUTES("DSP2"),
+	MADERA_DSP_ROUTES("DSP3"),
+
+	{ "DSP Trigger Out", NULL, "DSP1 Trigger Output" },
+	{ "DSP Trigger Out", NULL, "DSP2 Trigger Output" },
+	{ "DSP Trigger Out", NULL, "DSP3 Trigger Output" },
+
+	{ "DSP1 Trigger Output", "Switch", "DSP1" },
+	{ "DSP2 Trigger Output", "Switch", "DSP2" },
+	{ "DSP3 Trigger Output", "Switch", "DSP3" },
+
+	MADERA_MUX_ROUTES("ISRC1INT1", "ISRC1INT1"),
+	MADERA_MUX_ROUTES("ISRC1INT2", "ISRC1INT2"),
+	MADERA_MUX_ROUTES("ISRC1INT3", "ISRC1INT3"),
+	MADERA_MUX_ROUTES("ISRC1INT4", "ISRC1INT4"),
+
+	MADERA_MUX_ROUTES("ISRC1DEC1", "ISRC1DEC1"),
+	MADERA_MUX_ROUTES("ISRC1DEC2", "ISRC1DEC2"),
+	MADERA_MUX_ROUTES("ISRC1DEC3", "ISRC1DEC3"),
+	MADERA_MUX_ROUTES("ISRC1DEC4", "ISRC1DEC4"),
+
+	MADERA_MUX_ROUTES("ISRC2INT1", "ISRC2INT1"),
+	MADERA_MUX_ROUTES("ISRC2INT2", "ISRC2INT2"),
+	MADERA_MUX_ROUTES("ISRC2INT3", "ISRC2INT3"),
+	MADERA_MUX_ROUTES("ISRC2INT4", "ISRC2INT4"),
+
+	MADERA_MUX_ROUTES("ISRC2DEC1", "ISRC2DEC1"),
+	MADERA_MUX_ROUTES("ISRC2DEC2", "ISRC2DEC2"),
+	MADERA_MUX_ROUTES("ISRC2DEC3", "ISRC2DEC3"),
+	MADERA_MUX_ROUTES("ISRC2DEC4", "ISRC2DEC4"),
+
+	{ "AEC1 Loopback", "HPOUT1L", "OUT1L" },
+	{ "AEC1 Loopback", "HPOUT1R", "OUT1R" },
+	{ "AEC2 Loopback", "HPOUT1L", "OUT1L" },
+	{ "AEC2 Loopback", "HPOUT1R", "OUT1R" },
+	{ "HPOUT1 Demux", NULL, "OUT1L" },
+	{ "HPOUT1 Demux", NULL, "OUT1R" },
+
+	{ "AEC1 Loopback", "SPKOUT", "OUT4L" },
+	{ "AEC2 Loopback", "SPKOUT", "OUT4L" },
+	{ "SPKOUTN", NULL, "OUT4L" },
+	{ "SPKOUTP", NULL, "OUT4L" },
+
+	{ "HPOUTL", "HPOUT", "HPOUT1 Demux" },
+	{ "HPOUTR", "HPOUT", "HPOUT1 Demux" },
+	{ "EPOUTP", "EPOUT", "HPOUT1 Demux" },
+	{ "EPOUTN", "EPOUT", "HPOUT1 Demux" },
+
+	{ "AEC1 Loopback", "SPKDAT1L", "OUT5L" },
+	{ "AEC1 Loopback", "SPKDAT1R", "OUT5R" },
+	{ "AEC2 Loopback", "SPKDAT1L", "OUT5L" },
+	{ "AEC2 Loopback", "SPKDAT1R", "OUT5R" },
+	{ "SPKDAT1L", NULL, "OUT5L" },
+	{ "SPKDAT1R", NULL, "OUT5R" },
+
+	{ "SPDIF1", NULL, "SPD1" },
+
+	{ "MICSUPP", NULL, "SYSCLK" },
+
+	{ "DRC1 Signal Activity", NULL, "DRC1 Activity Output" },
+	{ "DRC2 Signal Activity", NULL, "DRC2 Activity Output" },
+	{ "DRC1 Activity Output", "Switch", "DRC1L" },
+	{ "DRC1 Activity Output", "Switch", "DRC1R" },
+	{ "DRC2 Activity Output", "Switch", "DRC2L" },
+	{ "DRC2 Activity Output", "Switch", "DRC2R" },
+};
+
+static int cs47l35_set_fll(struct snd_soc_component *component, int fll_id,
+			   int source, unsigned int fref, unsigned int fout)
+{
+	struct cs47l35 *cs47l35 = snd_soc_component_get_drvdata(component);
+
+	switch (fll_id) {
+	case MADERA_FLL1_REFCLK:
+		return madera_set_fll_refclk(&cs47l35->fll, source, fref,
+					     fout);
+	case MADERA_FLL1_SYNCCLK:
+		return madera_set_fll_syncclk(&cs47l35->fll, source, fref,
+					      fout);
+	default:
+		return -EINVAL;
+	}
+}
+
+static struct snd_soc_dai_driver cs47l35_dai[] = {
+	{
+		.name = "cs47l35-aif1",
+		.id = 1,
+		.base = MADERA_AIF1_BCLK_CTRL,
+		.playback = {
+			.stream_name = "AIF1 Playback",
+			.channels_min = 1,
+			.channels_max = 6,
+			.rates = MADERA_RATES,
+			.formats = MADERA_FORMATS,
+		},
+		.capture = {
+			.stream_name = "AIF1 Capture",
+			.channels_min = 1,
+			.channels_max = 6,
+			.rates = MADERA_RATES,
+			.formats = MADERA_FORMATS,
+		 },
+		.ops = &madera_dai_ops,
+		.symmetric_rates = 1,
+		.symmetric_samplebits = 1,
+	},
+	{
+		.name = "cs47l35-aif2",
+		.id = 2,
+		.base = MADERA_AIF2_BCLK_CTRL,
+		.playback = {
+			.stream_name = "AIF2 Playback",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MADERA_RATES,
+			.formats = MADERA_FORMATS,
+		},
+		.capture = {
+			.stream_name = "AIF2 Capture",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MADERA_RATES,
+			.formats = MADERA_FORMATS,
+		 },
+		.ops = &madera_dai_ops,
+		.symmetric_rates = 1,
+		.symmetric_samplebits = 1,
+	},
+	{
+		.name = "cs47l35-aif3",
+		.id = 3,
+		.base = MADERA_AIF3_BCLK_CTRL,
+		.playback = {
+			.stream_name = "AIF3 Playback",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MADERA_RATES,
+			.formats = MADERA_FORMATS,
+		},
+		.capture = {
+			.stream_name = "AIF3 Capture",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MADERA_RATES,
+			.formats = MADERA_FORMATS,
+		 },
+		.ops = &madera_dai_ops,
+		.symmetric_rates = 1,
+		.symmetric_samplebits = 1,
+	},
+	{
+		.name = "cs47l35-slim1",
+		.id = 4,
+		.playback = {
+			.stream_name = "Slim1 Playback",
+			.channels_min = 1,
+			.channels_max = 4,
+			.rates = MADERA_RATES,
+			.formats = MADERA_FORMATS,
+		},
+		.capture = {
+			.stream_name = "Slim1 Capture",
+			.channels_min = 1,
+			.channels_max = 4,
+			.rates = MADERA_RATES,
+			.formats = MADERA_FORMATS,
+		 },
+		.ops = &madera_simple_dai_ops,
+	},
+	{
+		.name = "cs47l35-slim2",
+		.id = 5,
+		.playback = {
+			.stream_name = "Slim2 Playback",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MADERA_RATES,
+			.formats = MADERA_FORMATS,
+		},
+		.capture = {
+			.stream_name = "Slim2 Capture",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MADERA_RATES,
+			.formats = MADERA_FORMATS,
+		 },
+		.ops = &madera_simple_dai_ops,
+	},
+	{
+		.name = "cs47l35-cpu-voicectrl",
+		.capture = {
+			.stream_name = "Voice Control CPU",
+			.channels_min = 1,
+			.channels_max = 1,
+			.rates = MADERA_RATES,
+			.formats = MADERA_FORMATS,
+		},
+		.compress_new = &snd_soc_new_compress,
+	},
+	{
+		.name = "cs47l35-dsp-voicectrl",
+		.capture = {
+			.stream_name = "Voice Control DSP",
+			.channels_min = 1,
+			.channels_max = 1,
+			.rates = MADERA_RATES,
+			.formats = MADERA_FORMATS,
+		},
+	},
+	{
+		.name = "cs47l35-cpu-trace",
+		.capture = {
+			.stream_name = "Audio Trace CPU",
+			.channels_min = 1,
+			.channels_max = 6,
+			.rates = MADERA_RATES,
+			.formats = MADERA_FORMATS,
+		},
+		.compress_new = &snd_soc_new_compress,
+	},
+	{
+		.name = "cs47l35-dsp-trace",
+		.capture = {
+			.stream_name = "Audio Trace DSP",
+			.channels_min = 1,
+			.channels_max = 6,
+			.rates = MADERA_RATES,
+			.formats = MADERA_FORMATS,
+		},
+	},
+};
+
+static int cs47l35_open(struct snd_compr_stream *stream)
+{
+	struct snd_soc_pcm_runtime *rtd = stream->private_data;
+	struct snd_soc_component *component =
+		snd_soc_rtdcom_lookup(rtd, DRV_NAME);
+	struct cs47l35 *cs47l35 = snd_soc_component_get_drvdata(component);
+	struct madera_priv *priv = &cs47l35->core;
+	struct madera *madera = priv->madera;
+	int n_adsp;
+
+	if (strcmp(rtd->codec_dai->name, "cs47l35-dsp-voicectrl") == 0) {
+		n_adsp = 2;
+	} else if (strcmp(rtd->codec_dai->name, "cs47l35-dsp-trace") == 0) {
+		n_adsp = 0;
+	} else {
+		dev_err(madera->dev,
+			"No suitable compressed stream for DAI '%s'\n",
+			rtd->codec_dai->name);
+		return -EINVAL;
+	}
+
+	return wm_adsp_compr_open(&priv->adsp[n_adsp], stream);
+}
+
+static irqreturn_t cs47l35_adsp2_irq(int irq, void *data)
+{
+	struct cs47l35 *cs47l35 = data;
+	struct madera_priv *priv = &cs47l35->core;
+	struct madera *madera = priv->madera;
+	struct madera_voice_trigger_info trig_info;
+	int serviced = 0;
+	int i, ret;
+
+	for (i = 0; i < CS47L35_NUM_ADSP; ++i) {
+		ret = wm_adsp_compr_handle_irq(&priv->adsp[i]);
+		if (ret != -ENODEV)
+			serviced++;
+		if (ret == WM_ADSP_COMPR_VOICE_TRIGGER) {
+			trig_info.core_num = i + 1;
+			blocking_notifier_call_chain(&madera->notifier,
+						MADERA_NOTIFY_VOICE_TRIGGER,
+						&trig_info);
+		}
+	}
+
+	if (!serviced) {
+		dev_err(madera->dev, "Spurious compressed data IRQ\n");
+		return IRQ_NONE;
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int cs47l35_component_probe(struct snd_soc_component *component)
+{
+	struct cs47l35 *cs47l35 = snd_soc_component_get_drvdata(component);
+	struct madera *madera = cs47l35->core.madera;
+	int i, ret;
+
+	snd_soc_component_init_regmap(component, madera->regmap);
+
+	mutex_lock(&madera->dapm_ptr_lock);
+	madera->dapm = snd_soc_component_get_dapm(component);
+	mutex_unlock(&madera->dapm_ptr_lock);
+
+	ret = madera_init_inputs(component);
+	if (ret)
+		return ret;
+
+	ret = madera_init_outputs(component, CS47L35_MONO_OUTPUTS);
+	if (ret)
+		return ret;
+
+	snd_soc_component_disable_pin(component, "HAPTICS");
+
+	ret = snd_soc_add_component_controls(component,
+					     madera_adsp_rate_controls,
+					     CS47L35_NUM_ADSP);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < CS47L35_NUM_ADSP; i++)
+		wm_adsp2_component_probe(&cs47l35->core.adsp[i], component);
+
+	return 0;
+}
+
+static void cs47l35_component_remove(struct snd_soc_component *component)
+{
+	struct cs47l35 *cs47l35 = snd_soc_component_get_drvdata(component);
+	struct madera *madera = cs47l35->core.madera;
+	int i;
+
+	mutex_lock(&madera->dapm_ptr_lock);
+	madera->dapm = NULL;
+	mutex_unlock(&madera->dapm_ptr_lock);
+
+	for (i = 0; i < CS47L35_NUM_ADSP; i++)
+		wm_adsp2_component_remove(&cs47l35->core.adsp[i], component);
+}
+
+#define CS47L35_DIG_VU 0x0200
+
+static unsigned int cs47l35_digital_vu[] = {
+	MADERA_DAC_DIGITAL_VOLUME_1L,
+	MADERA_DAC_DIGITAL_VOLUME_1R,
+	MADERA_DAC_DIGITAL_VOLUME_4L,
+	MADERA_DAC_DIGITAL_VOLUME_5L,
+	MADERA_DAC_DIGITAL_VOLUME_5R,
+};
+
+static const struct snd_compr_ops cs47l35_compr_ops = {
+	.open = &cs47l35_open,
+	.free = &wm_adsp_compr_free,
+	.set_params = &wm_adsp_compr_set_params,
+	.get_caps = &wm_adsp_compr_get_caps,
+	.trigger = &wm_adsp_compr_trigger,
+	.pointer = &wm_adsp_compr_pointer,
+	.copy = &wm_adsp_compr_copy,
+};
+
+static const struct snd_soc_component_driver soc_component_dev_cs47l35 = {
+	.probe			= &cs47l35_component_probe,
+	.remove			= &cs47l35_component_remove,
+	.set_sysclk		= &madera_set_sysclk,
+	.set_pll		= &cs47l35_set_fll,
+	.name			= DRV_NAME,
+	.compr_ops		= &cs47l35_compr_ops,
+	.controls		= cs47l35_snd_controls,
+	.num_controls		= ARRAY_SIZE(cs47l35_snd_controls),
+	.dapm_widgets		= cs47l35_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(cs47l35_dapm_widgets),
+	.dapm_routes		= cs47l35_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(cs47l35_dapm_routes),
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
+};
+
+static int cs47l35_probe(struct platform_device *pdev)
+{
+	struct madera *madera = dev_get_drvdata(pdev->dev.parent);
+	struct cs47l35 *cs47l35;
+	int i, ret;
+
+	BUILD_BUG_ON(ARRAY_SIZE(cs47l35_dai) > MADERA_MAX_DAI);
+
+	/* quick exit if Madera irqchip driver hasn't completed probe */
+	if (!madera->irq_dev) {
+		dev_dbg(&pdev->dev, "irqchip driver not ready\n");
+		return -EPROBE_DEFER;
+	}
+
+	cs47l35 = devm_kzalloc(&pdev->dev, sizeof(struct cs47l35), GFP_KERNEL);
+	if (!cs47l35)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, cs47l35);
+
+	cs47l35->core.madera = madera;
+	cs47l35->core.dev = &pdev->dev;
+	cs47l35->core.num_inputs = 4;
+
+	ret = madera_core_init(&cs47l35->core);
+	if (ret)
+		return ret;
+
+	ret = madera_init_overheat(&cs47l35->core);
+	if (ret)
+		goto error_core;
+
+	ret = madera_request_irq(madera, MADERA_IRQ_DSP_IRQ1,
+				 "ADSP2 Compressed IRQ", cs47l35_adsp2_irq,
+				 cs47l35);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to request DSP IRQ: %d\n", ret);
+		goto error_overheat;
+	}
+
+	ret = madera_set_irq_wake(madera, MADERA_IRQ_DSP_IRQ1, 1);
+	if (ret)
+		dev_warn(&pdev->dev, "Failed to set DSP IRQ wake: %d\n", ret);
+
+	for (i = 0; i < CS47L35_NUM_ADSP; i++) {
+		cs47l35->core.adsp[i].part = "cs47l35";
+		cs47l35->core.adsp[i].num = i + 1;
+		cs47l35->core.adsp[i].type = WMFW_ADSP2;
+		cs47l35->core.adsp[i].rev = 1;
+		cs47l35->core.adsp[i].dev = madera->dev;
+		cs47l35->core.adsp[i].regmap = madera->regmap_32bit;
+
+		cs47l35->core.adsp[i].base = wm_adsp2_control_bases[i];
+		cs47l35->core.adsp[i].mem = cs47l35_dsp_regions[i];
+		cs47l35->core.adsp[i].num_mems =
+			ARRAY_SIZE(cs47l35_dsp1_regions);
+
+		ret = wm_adsp2_init(&cs47l35->core.adsp[i]);
+		if (ret) {
+			for (--i; i >= 0; --i)
+				wm_adsp2_remove(&cs47l35->core.adsp[i]);
+			goto error_dsp_irq;
+		}
+	}
+
+	madera_init_fll(madera, 1, MADERA_FLL1_CONTROL_1 - 1, &cs47l35->fll);
+
+	for (i = 0; i < ARRAY_SIZE(cs47l35_dai); i++)
+		madera_init_dai(&cs47l35->core, i);
+
+	/* Latch volume update bits */
+	for (i = 0; i < ARRAY_SIZE(cs47l35_digital_vu); i++)
+		regmap_update_bits(madera->regmap, cs47l35_digital_vu[i],
+				   CS47L35_DIG_VU, CS47L35_DIG_VU);
+
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_idle(&pdev->dev);
+
+	ret = devm_snd_soc_register_component(&pdev->dev,
+					      &soc_component_dev_cs47l35,
+					      cs47l35_dai,
+					      ARRAY_SIZE(cs47l35_dai));
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to register component: %d\n", ret);
+		goto error_pm_runtime;
+	}
+
+	return ret;
+
+error_pm_runtime:
+	pm_runtime_disable(&pdev->dev);
+
+	for (i = 0; i < CS47L35_NUM_ADSP; i++)
+		wm_adsp2_remove(&cs47l35->core.adsp[i]);
+error_dsp_irq:
+	madera_set_irq_wake(madera, MADERA_IRQ_DSP_IRQ1, 0);
+	madera_free_irq(madera, MADERA_IRQ_DSP_IRQ1, cs47l35);
+error_overheat:
+	madera_free_overheat(&cs47l35->core);
+error_core:
+	madera_core_free(&cs47l35->core);
+
+	return ret;
+}
+
+static int cs47l35_remove(struct platform_device *pdev)
+{
+	struct cs47l35 *cs47l35 = platform_get_drvdata(pdev);
+	int i;
+
+	pm_runtime_disable(&pdev->dev);
+
+	for (i = 0; i < CS47L35_NUM_ADSP; i++)
+		wm_adsp2_remove(&cs47l35->core.adsp[i]);
+
+	madera_set_irq_wake(cs47l35->core.madera, MADERA_IRQ_DSP_IRQ1, 0);
+	madera_free_irq(cs47l35->core.madera, MADERA_IRQ_DSP_IRQ1, cs47l35);
+	madera_free_overheat(&cs47l35->core);
+	madera_core_free(&cs47l35->core);
+
+	return 0;
+}
+
+static struct platform_driver cs47l35_codec_driver = {
+	.driver = {
+		.name = "cs47l35-codec",
+	},
+	.probe = &cs47l35_probe,
+	.remove = &cs47l35_remove,
+};
+
+module_platform_driver(cs47l35_codec_driver);
+
+MODULE_SOFTDEP("pre: madera irq-madera arizona-micsupp");
+MODULE_DESCRIPTION("ASoC CS47L35 driver");
+MODULE_AUTHOR("Piotr Stankiewicz <piotrs@opensource.cirrus.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:cs47l35-codec");
-- 
2.11.0

