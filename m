Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDDE45A7C6
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Nov 2021 17:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235545AbhKWQgD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Nov 2021 11:36:03 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:55568 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235055AbhKWQgB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 23 Nov 2021 11:36:01 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AN7k0BD013868;
        Tue, 23 Nov 2021 10:32:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=WpUzZd4tTqLEOvh5h1b/MqIlBKUc+ighvZMF3kU7oRQ=;
 b=VsyIGW1Bge+nIo7i2FAwmyI5DluWXnwjJoDCCa89w8riRtLQTMfEjuVbM+018nl8ZIRV
 yPLku1SoUs/0OSzyIiwnzaADZB2BTpCRmHnX7/rQZBwaByJ/g8Qj7BQaWg5pqBAkpaak
 0gs+bcwU3K4EDMwytEnUM7HVE5xVw4yV7v2R7pNcsKTwB2eatP04heocDz36n844yyQj
 HAaI8sSNB07OIFATU3LQ6/8CbCeB35t3OJfEb8BE0zUjLFSSsQqfIrflc0U7QNusWJZP
 JXm+pcZe+6WZuVcXVTcRmiauKdu9LmE+lqjTSQ4UAhXEdxH1oNVCEPFElPCr2e2GlzRG 5w== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3cg3v7a220-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 23 Nov 2021 10:32:01 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 23 Nov
 2021 16:31:58 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 23 Nov 2021 16:31:58 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.11])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D629F2A1;
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
Subject: [PATCH 10/11] hda: cs35l41: Add support for CS35L41 in HDA systems
Date:   Tue, 23 Nov 2021 16:31:48 +0000
Message-ID: <20211123163149.1530535-11-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211123163149.1530535-1-tanureal@opensource.cirrus.com>
References: <20211123163149.1530535-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: eL-wuw8joPPBvukHr-qfDCrN69vIZpNV
X-Proofpoint-ORIG-GUID: eL-wuw8joPPBvukHr-qfDCrN69vIZpNV
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add support for CS35L41 using a new separated driver
that can be used in all upcoming designs

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 MAINTAINERS                     |   2 +
 sound/pci/hda/Kconfig           |  10 +
 sound/pci/hda/Makefile          |  28 +-
 sound/pci/hda/cs35l41_hda.c     | 522 ++++++++++++++++++++++++++++++++
 sound/pci/hda/cs35l41_hda.h     |  69 +++++
 sound/pci/hda/cs35l41_hda_i2c.c |  61 ++++
 sound/pci/hda/hda_component.h   |  20 ++
 sound/pci/hda/patch_realtek.c   | 103 +++++++
 8 files changed, 802 insertions(+), 13 deletions(-)
 create mode 100644 sound/pci/hda/cs35l41_hda.c
 create mode 100644 sound/pci/hda/cs35l41_hda.h
 create mode 100644 sound/pci/hda/cs35l41_hda_i2c.c
 create mode 100644 sound/pci/hda/hda_component.h

diff --git a/MAINTAINERS b/MAINTAINERS
index f32c7d733255..32f4587864b1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4513,10 +4513,12 @@ F:	drivers/media/cec/i2c/ch7322.c
 CIRRUS LOGIC AUDIO CODEC DRIVERS
 M:	James Schulman <james.schulman@cirrus.com>
 M:	David Rhodes <david.rhodes@cirrus.com>
+M:	Lucas Tanure <tanureal@opensource.cirrus.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 L:	patches@opensource.cirrus.com
 S:	Maintained
 F:	Documentation/devicetree/bindings/sound/cirrus,cs*
+F:	sound/pci/hda/cs35l41*
 F:	sound/soc/codecs/cs*
 
 CIRRUS LOGIC DSP FIRMWARE DRIVER
diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index ab9d2746e804..2b091819d885 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -91,6 +91,16 @@ config SND_HDA_PATCH_LOADER
 	  start up.  The "patch" file can be specified via patch module
 	  option, such as patch=hda-init.
 
+config SND_HDA_CODEC_CS35L41_I2C
+	tristate "Build CS35L41 HD-audio codec support for I2C Bus"
+	select SND_HDA_GENERIC
+	help
+	  Say Y or M here to include CS35L41 I2C HD-audio codec support in
+	  snd-hda-intel driver, such as ALC287.
+
+comment "Set to Y if you want auto-loading the codec driver"
+	depends on SND_HDA=y && SND_HDA_CODEC_CS35L41_I2C=m
+
 config SND_HDA_CODEC_REALTEK
 	tristate "Build Realtek HD-audio codec support"
 	select SND_HDA_GENERIC
diff --git a/sound/pci/hda/Makefile b/sound/pci/hda/Makefile
index b8fa682ce66a..baa096107e28 100644
--- a/sound/pci/hda/Makefile
+++ b/sound/pci/hda/Makefile
@@ -13,25 +13,27 @@ snd-hda-codec-$(CONFIG_SND_HDA_INPUT_BEEP) += hda_beep.o
 CFLAGS_hda_controller.o := -I$(src)
 CFLAGS_hda_intel.o := -I$(src)
 
-snd-hda-codec-generic-objs :=	hda_generic.o
-snd-hda-codec-realtek-objs :=	patch_realtek.o
-snd-hda-codec-cmedia-objs :=	patch_cmedia.o
-snd-hda-codec-analog-objs :=	patch_analog.o
-snd-hda-codec-idt-objs :=	patch_sigmatel.o
-snd-hda-codec-si3054-objs :=	patch_si3054.o
-snd-hda-codec-cirrus-objs :=	patch_cirrus.o
-snd-hda-codec-cs8409-objs :=	patch_cs8409.o patch_cs8409-tables.o
-snd-hda-codec-ca0110-objs :=	patch_ca0110.o
-snd-hda-codec-ca0132-objs :=	patch_ca0132.o
-snd-hda-codec-conexant-objs :=	patch_conexant.o
-snd-hda-codec-via-objs :=	patch_via.o
-snd-hda-codec-hdmi-objs :=	patch_hdmi.o hda_eld.o
+snd-hda-codec-generic-objs :=		hda_generic.o
+snd-hda-codec-cs35l41-i2c-objs :=	cs35l41_hda_i2c.o cs35l41_hda.o ../../soc/codecs/cs35l41-lib.o
+snd-hda-codec-realtek-objs :=		patch_realtek.o
+snd-hda-codec-cmedia-objs :=		patch_cmedia.o
+snd-hda-codec-analog-objs :=		patch_analog.o
+snd-hda-codec-idt-objs :=		patch_sigmatel.o
+snd-hda-codec-si3054-objs :=		patch_si3054.o
+snd-hda-codec-cirrus-objs :=		patch_cirrus.o
+snd-hda-codec-cs8409-objs :=		patch_cs8409.o patch_cs8409-tables.o
+snd-hda-codec-ca0110-objs :=		patch_ca0110.o
+snd-hda-codec-ca0132-objs :=		patch_ca0132.o
+snd-hda-codec-conexant-objs :=		patch_conexant.o
+snd-hda-codec-via-objs :=		patch_via.o
+snd-hda-codec-hdmi-objs :=		patch_hdmi.o hda_eld.o
 
 # common driver
 obj-$(CONFIG_SND_HDA) := snd-hda-codec.o
 
 # codec drivers
 obj-$(CONFIG_SND_HDA_GENERIC) += snd-hda-codec-generic.o
+obj-$(CONFIG_SND_HDA_CODEC_CS35L41_I2C) += snd-hda-codec-cs35l41-i2c.o
 obj-$(CONFIG_SND_HDA_CODEC_REALTEK) += snd-hda-codec-realtek.o
 obj-$(CONFIG_SND_HDA_CODEC_CMEDIA) += snd-hda-codec-cmedia.o
 obj-$(CONFIG_SND_HDA_CODEC_ANALOG) += snd-hda-codec-analog.o
diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
new file mode 100644
index 000000000000..5710780db8c6
--- /dev/null
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -0,0 +1,522 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// cs35l41.c -- CS35l41 ALSA HDA audio driver
+//
+// Copyright 2021 Cirrus Logic, Inc.
+//
+// Author: Lucas Tanure <tanureal@opensource.cirrus.com>
+
+#include <linux/acpi.h>
+#include <sound/hda_codec.h>
+#include "hda_local.h"
+#include "hda_auto_parser.h"
+#include "hda_jack.h"
+#include "hda_generic.h"
+#include "hda_component.h"
+#include "cs35l41_hda.h"
+
+static const struct reg_sequence cs35l41_hda_config[] = {
+	{ CS35L41_PLL_CLK_CTRL,		0x00000430 }, //3200000Hz, BCLK Input, PLL_REFCLK_EN = 1
+	{ CS35L41_GLOBAL_CLK_CTRL,	0x00000003 }, //GLOBAL_FS = 48 kHz
+	{ CS35L41_SP_ENABLES,		0x00010000 }, //ASP_RX1_EN = 1
+	{ CS35L41_SP_RATE_CTRL,		0x00000021 }, //ASP_BCLK_FREQ = 3.072 MHz
+	{ CS35L41_SP_FORMAT,		0x20200200 }, //24 bits, I2S, BCLK Slave, FSYNC Slave
+	{ CS35L41_DAC_PCM1_SRC,		0x00000008 }, //DACPCM1_SRC = ASPRX1
+	{ CS35L41_AMP_DIG_VOL_CTRL,	0x00000000 }, //AMP_VOL_PCM  0.0 dB
+	{ CS35L41_AMP_GAIN_CTRL,	0x00000260 }, //AMP_GAIN_PCM 19.5 dB
+	{ CS35L41_PWR_CTRL2,		0x00000001 }, //AMP_EN = 1
+};
+
+static const struct reg_sequence cs35l41_hda_start_bst[] = {
+	{ CS35L41_PWR_CTRL2,		0x00000021 }, //BST_EN = 10, AMP_EN = 1
+	{ CS35L41_PWR_CTRL1,		0x00000001, 3000}, // set GLOBAL_EN = 1
+};
+
+static const struct reg_sequence cs35l41_hda_stop_bst[] = {
+	{ CS35L41_PWR_CTRL1,		0x00000000, 3000}, // set GLOBAL_EN = 0
+};
+
+// only on amps where GPIO1 is used to control ext. VSPK switch
+static const struct reg_sequence cs35l41_start_ext_vspk[] = {
+	{ 0x00000040,			0x00000055 },
+	{ 0x00000040,			0x000000AA },
+	{ 0x00007438,			0x00585941 },
+	{ 0x00007414,			0x08C82222 },
+	{ 0x0000742C,			0x00000009 },
+	{ 0x00011008,			0x00008001 },
+	{ 0x0000742C,			0x0000000F },
+	{ 0x0000742C,			0x00000079 },
+	{ 0x00007438,			0x00585941 },
+	{ CS35L41_PWR_CTRL1,		0x00000001, 3000}, // set GLOBAL_EN = 1
+	{ 0x0000742C,			0x000000F9 },
+	{ 0x00007438,			0x00580941 },
+	{ 0x00000040,			0x000000CC },
+	{ 0x00000040,			0x00000033 },
+};
+
+//only on amps where GPIO1 is used to control ext. VSPK switch
+static const struct reg_sequence cs35l41_stop_ext_vspk[] = {
+	{ 0x00000040,			0x00000055 },
+	{ 0x00000040,			0x000000AA },
+	{ 0x00007438,			0x00585941 },
+	{ 0x00002014,			0x00000000, 3000}, //set GLOBAL_EN = 0
+	{ 0x0000742C,			0x00000009 },
+	{ 0x00007438,			0x00580941 },
+	{ 0x00011008,			0x00000001 },
+	{ 0x0000393C,			0x000000C0, 6000},
+	{ 0x0000393C,			0x00000000 },
+	{ 0x00007414,			0x00C82222 },
+	{ 0x0000742C,			0x00000000 },
+	{ 0x00000040,			0x000000CC },
+	{ 0x00000040,			0x00000033 },
+};
+
+static const struct reg_sequence cs35l41_safe_to_active[] = {
+	{ 0x00000040,			0x00000055 },
+	{ 0x00000040,			0x000000AA },
+	{ 0x0000742C,			0x0000000F },
+	{ 0x0000742C,			0x00000079 },
+	{ 0x00007438,			0x00585941 },
+	{ CS35L41_PWR_CTRL1,		0x00000001, 2000 }, //GLOBAL_EN = 1
+	{ 0x0000742C,			0x000000F9 },
+	{ 0x00007438,			0x00580941 },
+	{ 0x00000040,			0x000000CC },
+	{ 0x00000040,			0x00000033 },
+};
+
+static const struct reg_sequence cs35l41_active_to_safe[] = {
+	{ 0x00000040,			0x00000055 },
+	{ 0x00000040,			0x000000AA },
+	{ 0x00007438,			0x00585941 },
+	{ CS35L41_AMP_DIG_VOL_CTRL,	0x0000A678 }, //AMP_VOL_PCM Mute
+	{ CS35L41_PWR_CTRL2,		0x00000000 }, //AMP_EN = 0
+	{ CS35L41_PWR_CTRL1,		0x00000000 },
+	{ 0x0000742C,			0x00000009, 2000 },
+	{ 0x00007438,			0x00580941 },
+	{ 0x00000040,			0x000000CC },
+	{ 0x00000040,			0x00000033 },
+};
+
+static const struct reg_sequence cs35l41_reset_to_safe[] = {
+	{ 0x00000040,			0x00000055 },
+	{ 0x00000040,			0x000000AA },
+	{ 0x00007438,			0x00585941 },
+	{ 0x00007414,			0x08C82222 },
+	{ 0x0000742C,			0x00000009 },
+	{ 0x00000040,			0x000000CC },
+	{ 0x00000040,			0x00000033 },
+};
+
+static const struct cs35l41_hda_reg_sequence cs35l41_hda_reg_seq_no_bst = {
+	.probe		= cs35l41_reset_to_safe,
+	.num_probe	= ARRAY_SIZE(cs35l41_reset_to_safe),
+	.open		= cs35l41_hda_config,
+	.num_open	= ARRAY_SIZE(cs35l41_hda_config),
+	.prepare	= cs35l41_safe_to_active,
+	.num_prepare	= ARRAY_SIZE(cs35l41_safe_to_active),
+	.cleanup	= cs35l41_active_to_safe,
+	.num_cleanup	= ARRAY_SIZE(cs35l41_active_to_safe),
+};
+
+static const struct cs35l41_hda_reg_sequence cs35l41_hda_reg_seq_ext_bst = {
+	.open		= cs35l41_hda_config,
+	.num_open	= ARRAY_SIZE(cs35l41_hda_config),
+	.prepare	= cs35l41_start_ext_vspk,
+	.num_prepare	= ARRAY_SIZE(cs35l41_start_ext_vspk),
+	.cleanup	= cs35l41_stop_ext_vspk,
+	.num_cleanup	= ARRAY_SIZE(cs35l41_stop_ext_vspk),
+};
+
+static const struct cs35l41_hda_reg_sequence cs35l41_hda_reg_seq_int_bst = {
+	.open		= cs35l41_hda_config,
+	.num_open	= ARRAY_SIZE(cs35l41_hda_config),
+	.prepare	= cs35l41_hda_start_bst,
+	.num_prepare	= ARRAY_SIZE(cs35l41_hda_start_bst),
+	.cleanup	= cs35l41_hda_stop_bst,
+	.num_cleanup	= ARRAY_SIZE(cs35l41_hda_stop_bst),
+};
+
+static void cs35l41_hda_playback_hook(struct device *dev, int action)
+{
+	struct cs35l41_hda *cs35l41 = dev_get_drvdata(dev);
+	const struct cs35l41_hda_reg_sequence *reg_seq = cs35l41->reg_seq;
+	struct regmap *reg = cs35l41->regmap;
+	int ret = 0;
+
+	switch (action) {
+	case HDA_GEN_PCM_ACT_OPEN:
+		if (reg_seq->open)
+			ret = regmap_multi_reg_write(reg, reg_seq->open, reg_seq->num_open);
+		break;
+	case HDA_GEN_PCM_ACT_PREPARE:
+		if (reg_seq->prepare)
+			ret = regmap_multi_reg_write(reg, reg_seq->prepare, reg_seq->num_prepare);
+		break;
+	case HDA_GEN_PCM_ACT_CLEANUP:
+		if (reg_seq->cleanup)
+			ret = regmap_multi_reg_write(reg, reg_seq->cleanup, reg_seq->num_cleanup);
+		break;
+	case HDA_GEN_PCM_ACT_CLOSE:
+		if (reg_seq->close)
+			ret = regmap_multi_reg_write(reg, reg_seq->close, reg_seq->num_close);
+		break;
+	}
+
+	if (ret)
+		dev_warn(cs35l41->dev, "Failed to apply multi reg write: %d\n", ret);
+
+}
+
+static int cs35l41_hda_channel_map(struct device *dev, unsigned int tx_num, unsigned int *tx_slot,
+				    unsigned int rx_num, unsigned int *rx_slot)
+{
+	struct cs35l41_hda *cs35l41 = dev_get_drvdata(dev);
+
+	return cs35l41_set_channels(cs35l41->dev, cs35l41->regmap, tx_num, tx_slot, rx_num,
+				    rx_slot);
+}
+
+int cs35l41_hda_bind(struct device *dev, struct device *master, void *master_data)
+{
+	struct hda_component *comps = master_data;
+	int i;
+
+	for (i = 0; i < HDA_MAX_COMPONENTS; i++) {
+		if (!comps[i].dev) {
+			comps[i].dev = dev;
+			strscpy(comps[i].name, dev_name(dev), sizeof(comps[i].name));
+			comps[i].playback_hook = cs35l41_hda_playback_hook;
+			comps[i].set_channel_map = cs35l41_hda_channel_map;
+			return 0;
+		}
+	}
+
+	return -EBUSY;
+}
+
+static void cs35l41_hda_unbind(struct device *dev, struct device *master, void *master_data)
+{
+	struct hda_component *comps = master_data;
+	int i;
+
+	for (i = 0; i < HDA_MAX_COMPONENTS; i++) {
+		if (comps[i].dev == dev) {
+			memset(&comps[i], 0, sizeof(*comps));
+			return;
+		}
+	}
+}
+
+static const struct component_ops cs35l41_hda_comp_ops = {
+	.bind = cs35l41_hda_bind,
+	.unbind = cs35l41_hda_unbind,
+};
+
+static int cs35l41_hda_apply_properties(struct cs35l41_hda *cs35l41,
+					const struct cs35l41_hda_hw_config *hw_cfg)
+{
+	bool internal_boost = false;
+	int ret;
+
+	if (!hw_cfg) {
+		cs35l41->reg_seq = &cs35l41_hda_reg_seq_no_bst;
+		return 0;
+	}
+
+	if (hw_cfg->bst_ind || hw_cfg->bst_cap || hw_cfg->bst_ipk)
+		internal_boost = true;
+
+	switch (hw_cfg->gpio1_func) {
+	case CS35l41_VSPK_SWITCH:
+		regmap_update_bits(cs35l41->regmap, CS35L41_GPIO_PAD_CONTROL,
+				   CS35L41_GPIO1_CTRL_MASK, 1 << CS35L41_GPIO1_CTRL_SHIFT);
+		break;
+	case CS35l41_SYNC:
+		regmap_update_bits(cs35l41->regmap, CS35L41_GPIO_PAD_CONTROL,
+				   CS35L41_GPIO1_CTRL_MASK, 2 << CS35L41_GPIO1_CTRL_SHIFT);
+		break;
+	}
+
+	switch (hw_cfg->gpio2_func) {
+	case CS35L41_INTERRUPT:
+		regmap_update_bits(cs35l41->regmap, CS35L41_GPIO_PAD_CONTROL,
+				   CS35L41_GPIO2_CTRL_MASK, 2 << CS35L41_GPIO2_CTRL_SHIFT);
+		break;
+	}
+
+	if (internal_boost) {
+		cs35l41->reg_seq = &cs35l41_hda_reg_seq_int_bst;
+		if (!(hw_cfg->bst_ind && hw_cfg->bst_cap && hw_cfg->bst_ipk))
+			return -EINVAL;
+		ret = cs35l41_boost_config(cs35l41->dev, cs35l41->regmap,
+					   hw_cfg->bst_ind, hw_cfg->bst_cap, hw_cfg->bst_ipk);
+		if (ret)
+			return ret;
+	} else {
+		cs35l41->reg_seq = &cs35l41_hda_reg_seq_ext_bst;
+	}
+
+	ret = cs35l41_hda_channel_map(cs35l41->dev, 0, NULL, 1, (unsigned int *)&hw_cfg->spk_pos);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static struct cs35l41_hda_hw_config *cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41,
+							   const char *hid, int id)
+{
+	struct cs35l41_hda_hw_config *hw_cfg;
+	u32 values[HDA_MAX_COMPONENTS];
+	struct acpi_device *adev;
+	struct device *acpi_dev;
+	int i, ret, index = -1;
+	char *property;
+	size_t nval;
+
+	adev = acpi_dev_get_first_match_dev(hid, NULL, -1);
+	if (!adev) {
+		dev_err(cs35l41->dev, "Failed to find an ACPI device for %s\n", hid);
+		return ERR_PTR(-ENODEV);
+	}
+
+	acpi_dev = get_device(acpi_get_first_physical_node(adev));
+	acpi_dev_put(adev);
+
+	property = "cirrus,dev-index";
+	ret = device_property_count_u32(acpi_dev, property);
+	if (ret <= 0)
+		goto no_acpi_dsd;
+
+	if (ret > ARRAY_SIZE(values)) {
+		ret = -EINVAL;
+		goto err;
+	}
+	nval = ret;
+
+	ret = device_property_read_u32_array(acpi_dev, property, values, nval);
+	if (ret)
+		goto err;
+
+	for (i = 0; i < nval; i++) {
+		if (values[i] == id) {
+			index = i;
+			break;
+		}
+	}
+	if (index == -1) {
+		dev_err(cs35l41->dev, "No index found in %s\n", property);
+		ret = -ENODEV;
+		goto err;
+	}
+
+	/* No devm_ version as CLSA0100, in no_acpi_dsd case, can't use devm version */
+	cs35l41->reset_gpio = fwnode_gpiod_get_index(&adev->fwnode, "reset", index, GPIOD_OUT_LOW,
+						     "cs35l41-reset");
+
+	hw_cfg = kzalloc(sizeof(*hw_cfg), GFP_KERNEL);
+	if (!hw_cfg) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	property = "cirrus,speaker-position";
+	ret = device_property_read_u32_array(acpi_dev, property, values, nval);
+	if (ret)
+		goto err_free;
+	hw_cfg->spk_pos = values[index];
+
+	property = "cirrus,gpio1-func";
+	ret = device_property_read_u32_array(acpi_dev, property, values, nval);
+	if (ret)
+		goto err_free;
+	hw_cfg->gpio1_func = values[index];
+
+	property = "cirrus,gpio2-func";
+	ret = device_property_read_u32_array(acpi_dev, property, values, nval);
+	if (ret)
+		goto err_free;
+	hw_cfg->gpio2_func = values[index];
+
+	property = "cirrus,boost-peak-milliamp";
+	ret = device_property_read_u32_array(acpi_dev, property, values, nval);
+	if (ret == 0)
+		hw_cfg->bst_ipk = values[index];
+
+	property = "cirrus,boost-ind-nanohenry";
+	ret = device_property_read_u32_array(acpi_dev, property, values, nval);
+	if (ret == 0)
+		hw_cfg->bst_ind = values[index];
+
+	property = "cirrus,boost-cap-microfarad";
+	ret = device_property_read_u32_array(acpi_dev, property, values, nval);
+	if (ret == 0)
+		hw_cfg->bst_cap = values[index];
+
+	put_device(acpi_dev);
+
+	return hw_cfg;
+
+err_free:
+	kfree(hw_cfg);
+err:
+	put_device(acpi_dev);
+	dev_err(cs35l41->dev, "Failed property %s: %d\n", property, ret);
+
+	return ERR_PTR(ret);
+
+no_acpi_dsd:
+	/*
+	 * Device CLSA0100 doesn't have _DSD so a gpiod_get by the label reset won't work.
+	 * And devices created by i2c-multi-instantiate don't have their device struct pointing to
+	 * the correct fwnode, so acpi_dev must be used here
+	 * And devm functions expect that the device requesting the resource has the correct
+	 * fwnode
+	 */
+	cs35l41->reset_gpio = gpiod_get_index(acpi_dev, NULL, 0, GPIOD_OUT_HIGH);
+	cs35l41->vspk_always_on = true;
+	put_device(acpi_dev);
+
+	return NULL;
+}
+
+int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int irq,
+		      struct regmap *regmap)
+{
+	unsigned int int_sts, regid, reg_revid, mtl_revid, chipid, int_status;
+	struct cs35l41_hda_hw_config *acpi_hw_cfg;
+	struct cs35l41_hda *cs35l41;
+	int ret;
+
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	cs35l41 = devm_kzalloc(dev, sizeof(*cs35l41), GFP_KERNEL);
+	if (!cs35l41)
+		return -ENOMEM;
+
+	cs35l41->dev = dev;
+	cs35l41->irq = irq;
+	cs35l41->regmap = regmap;
+	dev_set_drvdata(dev, cs35l41);
+
+	acpi_hw_cfg = cs35l41_hda_read_acpi(cs35l41, device_name, id);
+	if (IS_ERR(acpi_hw_cfg))
+		return PTR_ERR(acpi_hw_cfg);
+
+	ret = cs35l41_init_supplies(cs35l41->dev, cs35l41->supplies);
+	if (ret) {
+		kfree(acpi_hw_cfg);
+		return ret;
+	}
+
+	if (IS_ERR(cs35l41->reset_gpio)) {
+		ret = PTR_ERR(cs35l41->reset_gpio);
+		cs35l41->reset_gpio = NULL;
+		if (ret == -EBUSY) {
+			dev_info(cs35l41->dev, "Reset line busy, assuming shared reset\n");
+		} else {
+			if (ret != -EPROBE_DEFER)
+				dev_err(cs35l41->dev, "Failed to get reset GPIO: %d\n", ret);
+			goto err;
+		}
+	}
+	if (cs35l41->reset_gpio) {
+		usleep_range(2000, 2100);
+		gpiod_set_value_cansleep(cs35l41->reset_gpio, 1);
+	}
+
+	usleep_range(2000, 2100);
+
+	ret = regmap_read_poll_timeout(cs35l41->regmap, CS35L41_IRQ1_STATUS4, int_status,
+				       int_status & CS35L41_OTP_BOOT_DONE, 1000, 100000);
+	if (ret) {
+		dev_err(cs35l41->dev, "Failed waiting for OTP_BOOT_DONE: %d\n", ret);
+		goto err;
+	}
+
+	ret = regmap_read(cs35l41->regmap, CS35L41_IRQ1_STATUS3, &int_sts);
+	if (ret || (int_sts & CS35L41_OTP_BOOT_ERR)) {
+		dev_err(cs35l41->dev, "OTP Boot error\n");
+		ret = -EIO;
+		goto err;
+	}
+
+	ret = regmap_read(cs35l41->regmap, CS35L41_DEVID, &regid);
+	if (ret) {
+		dev_err(cs35l41->dev, "Get Device ID failed: %d\n", ret);
+		goto err;
+	}
+
+	ret = regmap_read(cs35l41->regmap, CS35L41_REVID, &reg_revid);
+	if (ret) {
+		dev_err(cs35l41->dev, "Get Revision ID failed: %d\n", ret);
+		goto err;
+	}
+
+	mtl_revid = reg_revid & CS35L41_MTLREVID_MASK;
+
+	chipid = (mtl_revid % 2) ? CS35L41R_CHIP_ID : CS35L41_CHIP_ID;
+	if (regid != chipid) {
+		dev_err(cs35l41->dev, "CS35L41 Device ID (%X). Expected ID %X\n", regid, chipid);
+		ret = -ENODEV;
+		goto err;
+	}
+
+	ret = cs35l41_register_errata_patch(cs35l41->dev, cs35l41->regmap, reg_revid);
+	if (ret)
+		goto err;
+
+	ret = cs35l41_otp_unpack(cs35l41->dev, cs35l41->regmap);
+	if (ret) {
+		dev_err(cs35l41->dev, "OTP Unpack failed: %d\n", ret);
+		goto err;
+	}
+
+	ret = cs35l41_hda_apply_properties(cs35l41, acpi_hw_cfg);
+	if (ret)
+		goto err;
+	kfree(acpi_hw_cfg);
+
+	if (cs35l41->reg_seq->probe) {
+		ret = regmap_register_patch(cs35l41->regmap, cs35l41->reg_seq->probe,
+					    cs35l41->reg_seq->num_probe);
+		if (ret) {
+			dev_err(cs35l41->dev, "Fail to apply probe reg patch: %d\n", ret);
+			goto err;
+		}
+	}
+
+	ret = component_add(cs35l41->dev, &cs35l41_hda_comp_ops);
+	if (ret) {
+		dev_err(cs35l41->dev, "Register component failed: %d\n", ret);
+		goto err;
+	}
+
+	dev_info(cs35l41->dev, "Cirrus Logic CS35L41 (%x), Revision: %02X\n", regid, reg_revid);
+
+	return 0;
+
+err:
+	kfree(acpi_hw_cfg);
+	regulator_bulk_disable(CS35L41_NUM_SUPPLIES, cs35l41->supplies);
+	if (!cs35l41->vspk_always_on)
+		gpiod_set_value_cansleep(cs35l41->reset_gpio, 0);
+	gpiod_put(cs35l41->reset_gpio);
+
+	return ret;
+}
+
+int cs35l41_hda_remove(struct device *dev)
+{
+	struct cs35l41_hda *cs35l41 = dev_get_drvdata(dev);
+
+	component_del(cs35l41->dev, &cs35l41_hda_comp_ops);
+
+	regulator_bulk_disable(CS35L41_NUM_SUPPLIES, cs35l41->supplies);
+	if (!cs35l41->vspk_always_on)
+		gpiod_set_value_cansleep(cs35l41->reset_gpio, 0);
+	gpiod_put(cs35l41->reset_gpio);
+
+	return 0;
+}
diff --git a/sound/pci/hda/cs35l41_hda.h b/sound/pci/hda/cs35l41_hda.h
new file mode 100644
index 000000000000..a3b471c727ce
--- /dev/null
+++ b/sound/pci/hda/cs35l41_hda.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * cs35l41_hda.h -- CS35L41 ALSA HDA audio driver
+ *
+ * Copyright 2021 Cirrus Logic, Inc.
+ *
+ * Author: Lucas Tanure <tanureal@opensource.cirrus.com>
+ */
+
+#ifndef __CS35L41_HDA_H__
+#define __CS35L41_HDA_H__
+
+#include <linux/regulator/consumer.h>
+#include <linux/gpio/consumer.h>
+#include <linux/device.h>
+#include <sound/cs35l41.h>
+
+enum cs35l41_hda_spk_pos {
+	CS35l41_LEFT,
+	CS35l41_RIGHT,
+};
+
+enum cs35l41_hda_gpio_function {
+	CS35L41_NOT_USED,
+	CS35l41_VSPK_SWITCH,
+	CS35L41_INTERRUPT,
+	CS35l41_SYNC,
+};
+
+struct cs35l41_hda_reg_sequence {
+	const struct reg_sequence *probe;
+	unsigned int num_probe;
+	const struct reg_sequence *open;
+	unsigned int num_open;
+	const struct reg_sequence *prepare;
+	unsigned int num_prepare;
+	const struct reg_sequence *cleanup;
+	unsigned int num_cleanup;
+	const struct reg_sequence *close;
+	unsigned int num_close;
+};
+
+struct cs35l41_hda_hw_config {
+	unsigned int spk_pos;
+	unsigned int gpio1_func;
+	unsigned int gpio2_func;
+	int bst_ind;
+	int bst_ipk;
+	int bst_cap;
+};
+
+struct cs35l41_hda {
+	struct device *dev;
+	struct regmap *regmap;
+	struct gpio_desc *reset_gpio;
+	struct regulator_bulk_data supplies[CS35L41_NUM_SUPPLIES];
+	const struct cs35l41_hda_reg_sequence *reg_seq;
+
+	int irq;
+
+	/* Don't put the AMP in reset of VSPK can not be turned off */
+	bool vspk_always_on;
+};
+
+int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int irq,
+		      struct regmap *regmap);
+int cs35l41_hda_remove(struct device *dev);
+
+#endif /*__CS35L41_HDA_H__*/
diff --git a/sound/pci/hda/cs35l41_hda_i2c.c b/sound/pci/hda/cs35l41_hda_i2c.c
new file mode 100644
index 000000000000..201930d35486
--- /dev/null
+++ b/sound/pci/hda/cs35l41_hda_i2c.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// cs35l41.c -- CS35l41 HDA I2C driver
+//
+// Copyright 2021 Cirrus Logic, Inc.
+//
+// Author: Lucas Tanure <tanureal@opensource.cirrus.com>
+
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/acpi.h>
+
+#include "cs35l41_hda.h"
+
+static int cs35l41_hda_i2c_probe(struct i2c_client *clt, const struct i2c_device_id *id)
+{
+	const char *device_name;
+
+	/* Compare against the device name so it works for I2C, normal ACPI
+	 * and for ACPI by i2c-multi-instantiate matching cases
+	 */
+	if (memcmp(dev_name(&clt->dev), "i2c-CLSA0100", 12) == 0)
+		device_name = "CLSA0100";
+
+	return cs35l41_hda_probe(&clt->dev, device_name, clt->addr, clt->irq,
+				 devm_regmap_init_i2c(clt, &cs35l41_regmap_i2c));
+}
+
+static int cs35l41_hda_i2c_remove(struct i2c_client *clt)
+{
+	return cs35l41_hda_remove(&clt->dev);
+}
+
+static const struct i2c_device_id cs35l41_hda_i2c_id[] = {
+	{ "cs35l41-hda", 0 },
+	{}
+};
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id cs35l41_acpi_hda_match[] = {
+	{"CLSA0100", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, cs35l41_acpi_hda_match);
+#endif
+
+static struct i2c_driver cs35l41_i2c_driver = {
+	.driver = {
+		.name		= "cs35l41-hda",
+		.acpi_match_table = ACPI_PTR(cs35l41_acpi_hda_match),
+	},
+	.id_table	= cs35l41_hda_i2c_id,
+	.probe		= cs35l41_hda_i2c_probe,
+	.remove		= cs35l41_hda_i2c_remove,
+};
+
+module_i2c_driver(cs35l41_i2c_driver);
+
+MODULE_DESCRIPTION("HDA CS35L41 driver");
+MODULE_AUTHOR("Lucas Tanure <tanureal@opensource.cirrus.com>");
+MODULE_LICENSE("GPL");
diff --git a/sound/pci/hda/hda_component.h b/sound/pci/hda/hda_component.h
new file mode 100644
index 000000000000..2e52be6db9c2
--- /dev/null
+++ b/sound/pci/hda/hda_component.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * HD audio Component Binding Interface
+ *
+ * Copyright (C) 2021 Cirrus Logic, Inc. and
+ *                    Cirrus Logic International Semiconductor Ltd.
+ */
+
+#include <linux/component.h>
+
+#define HDA_MAX_COMPONENTS	4
+#define HDA_MAX_NAME_SIZE	50
+
+struct hda_component {
+	struct device *dev;
+	char name[HDA_MAX_NAME_SIZE];
+	void (*playback_hook)(struct device *dev, int action);
+	int (*set_channel_map)(struct device *dev, unsigned int rx_num, unsigned int *rx_slot,
+				unsigned int tx_num, unsigned int *tx_slot);
+};
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 701c80ed83dc..fb2910530079 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -25,6 +25,7 @@
 #include "hda_auto_parser.h"
 #include "hda_jack.h"
 #include "hda_generic.h"
+#include "hda_component.h"
 
 /* keep halting ALC5505 DSP, for power saving */
 #define HALT_REALTEK_ALC5505
@@ -126,6 +127,10 @@ struct alc_spec {
 	unsigned int coef0;
 	struct input_dev *kb_dev;
 	u8 alc_mute_keycode_map[1];
+
+	/* component binding */
+	struct component_match *match;
+	struct hda_component comps[HDA_MAX_COMPONENTS];
 };
 
 /*
@@ -6497,6 +6502,98 @@ static void alc287_fixup_legion_15imhg05_speakers(struct hda_codec *codec,
 	}
 }
 
+static int comp_match_dev_name(struct device *dev, void *data)
+{
+	if (strcmp(dev_name(dev), data) == 0)
+		return 1;
+
+	return 0;
+}
+
+static int find_comp_by_dev_name(struct alc_spec *spec, const char *name)
+{
+	int i;
+
+	for (i = 0; i < HDA_MAX_COMPONENTS; i++) {
+		if (strcmp(spec->comps[i].name, name) == 0)
+			return i;
+	}
+
+	return -ENODEV;
+}
+
+static int comp_bind(struct device *dev)
+{
+	struct hda_codec *codec = dev_to_hda_codec(dev);
+	struct alc_spec *spec = codec->spec;
+
+	return component_bind_all(dev, spec->comps);
+}
+
+static void comp_unbind(struct device *dev)
+{
+	struct hda_codec *codec = dev_to_hda_codec(dev);
+	struct alc_spec *spec = codec->spec;
+
+	component_unbind_all(dev, spec->comps);
+}
+
+static const struct component_master_ops comp_master_ops = {
+	.bind = comp_bind,
+	.unbind = comp_unbind,
+};
+
+void alc287_legion_16achg6_playback_hook(struct hda_pcm_stream *hinfo, struct hda_codec *codec,
+					 struct snd_pcm_substream *sub, int action)
+{
+	struct alc_spec *spec = codec->spec;
+	unsigned int rx_slot;
+	int i = 0;
+
+	switch (action) {
+	case HDA_GEN_PCM_ACT_PREPARE:
+		rx_slot = 0;
+		i = find_comp_by_dev_name(spec, "i2c-CLSA0100:00-cs35l41-hda.0");
+		if (i >= 0)
+			spec->comps[i].set_channel_map(spec->comps[i].dev, 0, NULL, 1, &rx_slot);
+
+		rx_slot = 1;
+		i = find_comp_by_dev_name(spec, "i2c-CLSA0100:00-cs35l41-hda.1");
+		if (i >= 0)
+			spec->comps[i].set_channel_map(spec->comps[i].dev, 0, NULL, 1, &rx_slot);
+		break;
+	}
+
+	for (i = 0; i < HDA_MAX_COMPONENTS; i++) {
+		if (spec->comps[i].dev)
+			spec->comps[i].playback_hook(spec->comps[i].dev, action);
+	}
+
+
+}
+
+static void alc287_fixup_legion_16achg6_speakers(struct hda_codec *codec,
+						 const struct hda_fixup *fix, int action)
+{
+	struct device *dev = hda_codec_dev(codec);
+	struct alc_spec *spec = codec->spec;
+	int ret;
+
+	switch (action) {
+	case HDA_FIXUP_ACT_PRE_PROBE:
+		component_match_add(dev, &spec->match, comp_match_dev_name,
+				    "i2c-CLSA0100:00-cs35l41-hda.0");
+		component_match_add(dev, &spec->match, comp_match_dev_name,
+				    "i2c-CLSA0100:00-cs35l41-hda.1");
+		ret = component_master_add_with_match(dev, &comp_master_ops, spec->match);
+		if (ret)
+			codec_err(codec, "Fail to register component aggregator %d\n", ret);
+		else
+			spec->gen.pcm_playback_hook = alc287_legion_16achg6_playback_hook;
+		break;
+	}
+}
+
 /* for alc295_fixup_hp_top_speakers */
 #include "hp_x360_helper.c"
 
@@ -6762,6 +6859,7 @@ enum {
 	ALC256_FIXUP_TONGFANG_RESET_PERSISTENT_SETTINGS,
 	ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE,
 	ALC233_FIXUP_NO_AUDIO_JACK,
+	ALC287_FIXUP_LEGION_16ACHG6,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -8486,6 +8584,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc233_fixup_no_audio_jack,
 	},
+	[ALC287_FIXUP_LEGION_16ACHG6] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc287_fixup_legion_16achg6_speakers,
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -8894,6 +8996,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3827, "Ideapad S740", ALC285_FIXUP_IDEAPAD_S740_COEF),
 	SND_PCI_QUIRK(0x17aa, 0x3843, "Yoga 9i", ALC287_FIXUP_IDEAPAD_BASS_SPK_AMP),
 	SND_PCI_QUIRK(0x17aa, 0x3813, "Legion 7i 15IMHG05", ALC287_FIXUP_LEGION_15IMHG05_SPEAKERS),
+	SND_PCI_QUIRK(0x17aa, 0x3847, "Legion 7 16ACHG6", ALC287_FIXUP_LEGION_16ACHG6),
 	SND_PCI_QUIRK(0x17aa, 0x3852, "Lenovo Yoga 7 14ITL5", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3853, "Lenovo Yoga 7 15ITL5", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3819, "Lenovo 13s Gen2 ITL", ALC287_FIXUP_13S_GEN2_SPEAKERS),
-- 
2.34.0

