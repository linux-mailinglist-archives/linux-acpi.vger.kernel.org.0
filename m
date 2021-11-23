Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA0E845A7DD
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Nov 2021 17:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238945AbhKWQgt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Nov 2021 11:36:49 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:47928 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235055AbhKWQg1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 23 Nov 2021 11:36:27 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1ANCeXB9012277;
        Tue, 23 Nov 2021 10:31:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=3brB89ZjjL1+5gZabDKcSweNLeFIOFiD2/pzoTpGB34=;
 b=aS0EZ2Vju2RGGYiKQ/QPUiq5bMS3CShN71QKpNQd47oAq+Y4P/VVCd/YapN18CUJGmU7
 1iKKOgvXCLPMJvhK3K8YnMxBWnXX3DpRgymWKiaIvagVz78Dtz57OiDxgDM8QNrP/pCt
 n3X8aVZlG2oLZYPA8tgOtQmL3ODtFmMdieXJsa9vRW29ppJYr+L6gROTOJ3eN6VQMTAO
 CNtLMrW8O2osht8cgmVodhRqq2n0SjFb0HSHZyp3I6C/mWHZudwggKm+cG+fhcKG6ije
 aU8Ve3bjEerPCMsLbvfe8I9HAjHt7I6Uy3zLLb/2SD9v3TLB2ufEbj1f7+fJttome0k3 qA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3cg5ms21ng-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 23 Nov 2021 10:31:56 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 23 Nov
 2021 16:31:55 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 23 Nov 2021 16:31:55 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.11])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1766C2A1;
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
Subject: [PATCH 06/11] ASoC: cs35l41: Move power initializations to reg_sequence
Date:   Tue, 23 Nov 2021 16:31:44 +0000
Message-ID: <20211123163149.1530535-7-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211123163149.1530535-1-tanureal@opensource.cirrus.com>
References: <20211123163149.1530535-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: F5c1oj581rDWt8ngW0Q1II8UAmHOrnin
X-Proofpoint-ORIG-GUID: F5c1oj581rDWt8ngW0Q1II8UAmHOrnin
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ASoC and HDA systems for all revisions of CS35L41 will benefit
from having this initialization, so add it to reg_sequence of
each revision

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l41-lib.c |  2 +-
 sound/soc/codecs/cs35l41.c     | 29 +++++++++--------------------
 2 files changed, 10 insertions(+), 21 deletions(-)

diff --git a/sound/soc/codecs/cs35l41-lib.c b/sound/soc/codecs/cs35l41-lib.c
index a13c5313f4e5..cd9be6fbf910 100644
--- a/sound/soc/codecs/cs35l41-lib.c
+++ b/sound/soc/codecs/cs35l41-lib.c
@@ -43,7 +43,7 @@ const struct reg_default cs35l41_reg[] = {
 	{ CS35L41_CLASSH_CFG,			0x000B0405 },
 	{ CS35L41_WKFET_CFG,			0x00000111 },
 	{ CS35L41_NG_CFG,			0x00000033 },
-	{ CS35L41_AMP_GAIN_CTRL,		0x00000273 },
+	{ CS35L41_AMP_GAIN_CTRL,		0x00000000 },
 	{ CS35L41_GPIO1_CTRL1,			0xE1000001 },
 	{ CS35L41_GPIO2_CTRL1,			0xE1000001 },
 	{ CS35L41_MIXER_NGATE_CFG,		0x00000000 },
diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index 0a88c2f164d1..20edc40b2fab 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -1267,6 +1267,9 @@ static int cs35l41_handle_pdata(struct device *dev,
 }
 
 static const struct reg_sequence cs35l41_reva0_errata_patch[] = {
+	{ CS35L41_DSP1_CCM_CORE_CTRL,	 0x00000000 },
+	{ CS35L41_PWR_CTRL2,		 0x00000000 },
+	{ CS35L41_AMP_GAIN_CTRL,	 0x00000000 },
 	{ 0x00000040,			 0x00005555 },
 	{ 0x00000040,			 0x0000AAAA },
 	{ 0x00003854,			 0x05180240 },
@@ -1286,6 +1289,9 @@ static const struct reg_sequence cs35l41_reva0_errata_patch[] = {
 };
 
 static const struct reg_sequence cs35l41_revb0_errata_patch[] = {
+	{ CS35L41_DSP1_CCM_CORE_CTRL,	 0x00000000 },
+	{ CS35L41_PWR_CTRL2,		 0x00000000 },
+	{ CS35L41_AMP_GAIN_CTRL,	 0x00000000 },
 	{ 0x00000040,			 0x00005555 },
 	{ 0x00000040,			 0x0000AAAA },
 	{ CS35L41_VIMON_SPKMON_RESYNC,	 0x00000000 },
@@ -1299,6 +1305,9 @@ static const struct reg_sequence cs35l41_revb0_errata_patch[] = {
 };
 
 static const struct reg_sequence cs35l41_revb2_errata_patch[] = {
+	{ CS35L41_DSP1_CCM_CORE_CTRL,	 0x00000000 },
+	{ CS35L41_PWR_CTRL2,		 0x00000000 },
+	{ CS35L41_AMP_GAIN_CTRL,	 0x00000000 },
 	{ 0x00000040,			 0x00005555 },
 	{ 0x00000040,			 0x0000AAAA },
 	{ CS35L41_VIMON_SPKMON_RESYNC,	 0x00000000 },
@@ -1533,26 +1542,6 @@ int cs35l41_probe(struct cs35l41_private *cs35l41,
 		goto err;
 	}
 
-	ret = regmap_write(cs35l41->regmap, CS35L41_DSP1_CCM_CORE_CTRL, 0);
-	if (ret < 0) {
-		dev_err(cs35l41->dev, "Write CCM_CORE_CTRL failed: %d\n", ret);
-		goto err;
-	}
-
-	ret = regmap_update_bits(cs35l41->regmap, CS35L41_PWR_CTRL2,
-				 CS35L41_AMP_EN_MASK, 0);
-	if (ret < 0) {
-		dev_err(cs35l41->dev, "Write CS35L41_PWR_CTRL2 failed: %d\n", ret);
-		goto err;
-	}
-
-	ret = regmap_update_bits(cs35l41->regmap, CS35L41_AMP_GAIN_CTRL,
-				 CS35L41_AMP_GAIN_PCM_MASK, 0);
-	if (ret < 0) {
-		dev_err(cs35l41->dev, "Write CS35L41_AMP_GAIN_CTRL failed: %d\n", ret);
-		goto err;
-	}
-
 	ret = cs35l41_set_pdata(cs35l41);
 	if (ret < 0) {
 		dev_err(cs35l41->dev, "Set pdata failed: %d\n", ret);
-- 
2.34.0

