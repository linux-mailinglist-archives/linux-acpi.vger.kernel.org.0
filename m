Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B394770DA
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Dec 2021 12:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbhLPLoI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 16 Dec 2021 06:44:08 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:10190 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232287AbhLPLoG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 16 Dec 2021 06:44:06 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BG6WwLr019726;
        Thu, 16 Dec 2021 05:43:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=dGUyg6LrczQdRzXmtkYFi/ilF+UTK9fPqGSUiqla73k=;
 b=GF3GiLzhUbD+rSPg3QcV4mMiLfJj+ZI+CzjcD1FeLiKinr2zUA2FM+41J/xWIMLMpfba
 W0hZzOEOlpFPc0gFCovJS9Ho5ywvhqbhmMD5dGzWXdsuS64eZDKyuT7hJ2MVNAA4WzrN
 M8bJP33917sJCe9p+mNh8VpCmKka3RpKx8xhV3DEy1RI4uexjXXkVVKlZm+8+kSErMe6
 MWl+bGCFe0agyDgxMzSvePuFI0i9LYog3jKqXS4mVGLoDEOlhnb4dkzEQWrp20ZZQV+o
 5RMlPkLCIY6Wp2E9D1OGfhXCgr6/4hKWFMBQoJTgV1eKzDQd1SLwkT3fx6EznD/Mm666 OQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3cymsc110q-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 16 Dec 2021 05:43:43 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 16 Dec
 2021 11:43:39 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 16 Dec 2021 11:43:39 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.64.39])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6303A45D;
        Thu, 16 Dec 2021 11:43:39 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-acpi@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH v5 09/10] ALSA: hda/realtek: Add support for Legion 7 16ACHg6 laptop
Date:   Thu, 16 Dec 2021 11:43:31 +0000
Message-ID: <20211216114332.153409-10-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211216114332.153409-1-tanureal@opensource.cirrus.com>
References: <20211216114332.153409-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: V_PJ7tP0Qm2u1aM1_sod0oFj9kvWTF8J
X-Proofpoint-ORIG-GUID: V_PJ7tP0Qm2u1aM1_sod0oFj9kvWTF8J
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add Support for CS35L41 using the component binding
method

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 sound/pci/hda/patch_realtek.c | 107 ++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3599f4c85ebf..7299e6388900 100644
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
@@ -6497,6 +6502,102 @@ static void alc287_fixup_legion_15imhg05_speakers(struct hda_codec *codec,
 	}
 }
 
+static int comp_match_dev_name(struct device *dev, void *data)
+{
+	return strcmp(dev_name(dev), data) == 0;
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
+	struct hda_codec *cdc = dev_to_hda_codec(dev);
+	struct alc_spec *spec = cdc->spec;
+
+	return component_bind_all(dev, spec->comps);
+}
+
+static void comp_unbind(struct device *dev)
+{
+	struct hda_codec *cdc = dev_to_hda_codec(dev);
+	struct alc_spec *spec = cdc->spec;
+
+	component_unbind_all(dev, spec->comps);
+}
+
+static const struct component_master_ops comp_master_ops = {
+	.bind = comp_bind,
+	.unbind = comp_unbind,
+};
+
+static void comp_generic_playback_hook(struct hda_pcm_stream *hinfo, struct hda_codec *cdc,
+				       struct snd_pcm_substream *sub, int action)
+{
+	struct alc_spec *spec = cdc->spec;
+	int i;
+
+	for (i = 0; i < HDA_MAX_COMPONENTS; i++) {
+		if (spec->comps[i].dev)
+			spec->comps[i].playback_hook(spec->comps[i].dev, action);
+	}
+}
+
+static void alc287_legion_16achg6_playback_hook(struct hda_pcm_stream *hinfo, struct hda_codec *cdc,
+						struct snd_pcm_substream *sub, int action)
+{
+	struct alc_spec *spec = cdc->spec;
+	unsigned int rx_slot;
+	int i;
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
+	comp_generic_playback_hook(hinfo, cdc, sub, action);
+}
+
+static void alc287_fixup_legion_16achg6_speakers(struct hda_codec *cdc, const struct hda_fixup *fix,
+						 int action)
+{
+	struct device *dev = hda_codec_dev(cdc);
+	struct alc_spec *spec = cdc->spec;
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
+			codec_err(cdc, "Fail to register component aggregator %d\n", ret);
+		else
+			spec->gen.pcm_playback_hook = alc287_legion_16achg6_playback_hook;
+		break;
+	}
+}
+
 /* for alc295_fixup_hp_top_speakers */
 #include "hp_x360_helper.c"
 
@@ -6766,6 +6867,7 @@ enum {
 	ALC256_FIXUP_SET_COEF_DEFAULTS,
 	ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE,
 	ALC233_FIXUP_NO_AUDIO_JACK,
+	ALC287_FIXUP_LEGION_16ACHG6,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -8490,6 +8592,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc233_fixup_no_audio_jack,
 	},
+	[ALC287_FIXUP_LEGION_16ACHG6] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc287_fixup_legion_16achg6_speakers,
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -8899,6 +9005,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3827, "Ideapad S740", ALC285_FIXUP_IDEAPAD_S740_COEF),
 	SND_PCI_QUIRK(0x17aa, 0x3843, "Yoga 9i", ALC287_FIXUP_IDEAPAD_BASS_SPK_AMP),
 	SND_PCI_QUIRK(0x17aa, 0x3813, "Legion 7i 15IMHG05", ALC287_FIXUP_LEGION_15IMHG05_SPEAKERS),
+	SND_PCI_QUIRK(0x17aa, 0x3847, "Legion 7 16ACHG6", ALC287_FIXUP_LEGION_16ACHG6),
 	SND_PCI_QUIRK(0x17aa, 0x3852, "Lenovo Yoga 7 14ITL5", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3853, "Lenovo Yoga 7 15ITL5", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3819, "Lenovo 13s Gen2 ITL", ALC287_FIXUP_13S_GEN2_SPEAKERS),
-- 
2.34.1

