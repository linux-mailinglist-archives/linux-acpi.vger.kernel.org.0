Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE71356DCB
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Jun 2019 17:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbfFZPgW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 26 Jun 2019 11:36:22 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:61576 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727146AbfFZPgW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 26 Jun 2019 11:36:22 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5QFXYle022897;
        Wed, 26 Jun 2019 10:36:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=PODMain02222019;
 bh=AV/T2mCUaARe6CJNXa05QO9AoXOQYuMlU5+Mm4v9h3w=;
 b=XdWeeh8/g7cPQCN9AaHL6MEFcrJWxb2XFE8ed2AmWDVpcwSTd038KUHfAbYtBKH2Luwd
 FybTGQHiFQMcD/3Dx31Z7l0u8rq9QSRYTLxgaxTG1qpteafkaX1pRnDUtmGJxxtX1Pmj
 f6kC9ZifX+v1pcvmDxvseaKLnO/Pw4C9RsyELM1r9tHWWGtinl7HS7yvLGT8cyyltGOM
 8YaTq95cb7u6gC61LYO+bYL1Xsq8v18UXkWGPX9LqrnpvKyZ0+yb9YxlDPCWsFpulcr/
 rCQxjc8jXo4BwyWU0WEt3tIWhE5Op4surSd6h4Yu9aWdIfYGMAUezzh87Cl1mdwizV/5 Ng== 
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail4.cirrus.com ([87.246.98.35])
        by mx0b-001ae601.pphosted.com with ESMTP id 2tc7gt8cvx-1;
        Wed, 26 Jun 2019 10:36:12 -0500
Received: from EDIEX01.ad.cirrus.com (ediex01.ad.cirrus.com [198.61.84.80])
        by mail4.cirrus.com (Postfix) with ESMTP id 410D6611C8B1;
        Wed, 26 Jun 2019 10:36:14 -0500 (CDT)
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Wed, 26 Jun
 2019 16:36:11 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Wed, 26 Jun 2019 16:36:11 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id DF64F2DA;
        Wed, 26 Jun 2019 16:36:11 +0100 (BST)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <linux-acpi@vger.kernel.org>, <lgirdwood@gmail.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>
Subject: [PATCH 2/2] ASoC: madera: Read device tree configuration
Date:   Wed, 26 Jun 2019 16:36:11 +0100
Message-ID: <20190626153611.10170-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190626153611.10170-1-ckeepax@opensource.cirrus.com>
References: <20190626153611.10170-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906260182
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Read the configuration of the Madera sound driver from device tree using
the new device tree helper function.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Note this patch depends on patches that are currently going through Mark's
tree so probably best if this one also goes through there.

Thanks,
Charles

 sound/soc/codecs/madera.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/sound/soc/codecs/madera.c b/sound/soc/codecs/madera.c
index 1b1be19a2f991..8fe16e4e19c7b 100644
--- a/sound/soc/codecs/madera.c
+++ b/sound/soc/codecs/madera.c
@@ -300,6 +300,68 @@ int madera_free_overheat(struct madera_priv *priv)
 }
 EXPORT_SYMBOL_GPL(madera_free_overheat);
 
+static void madera_prop_get_inmode(struct madera_priv *priv)
+{
+	struct madera *madera = priv->madera;
+	struct madera_codec_pdata *pdata = &madera->pdata.codec;
+	u32 tmp[MADERA_MAX_INPUT * MADERA_MAX_MUXED_CHANNELS];
+	int n, i, in_idx, ch_idx;
+
+	BUILD_BUG_ON(ARRAY_SIZE(pdata->inmode) != MADERA_MAX_INPUT);
+	BUILD_BUG_ON(ARRAY_SIZE(pdata->inmode[0]) != MADERA_MAX_MUXED_CHANNELS);
+
+	n = device_property_read_u32_2darray(madera->dev, "cirrus,inmode",
+					     tmp, ARRAY_SIZE(tmp),
+					     MADERA_MAX_MUXED_CHANNELS);
+	if (n < 0)
+		return;
+
+	in_idx = 0;
+	ch_idx = 0;
+	for (i = 0; i < n; ++i) {
+		pdata->inmode[in_idx][ch_idx] = tmp[i];
+
+		if (++ch_idx == MADERA_MAX_MUXED_CHANNELS) {
+			ch_idx = 0;
+			++in_idx;
+		}
+	}
+}
+
+static void madera_prop_get_pdata(struct madera_priv *priv)
+{
+	struct madera *madera = priv->madera;
+	struct madera_codec_pdata *pdata = &madera->pdata.codec;
+	u32 out_mono[ARRAY_SIZE(pdata->out_mono)];
+	int i, n;
+
+	madera_prop_get_inmode(priv);
+
+	n = device_property_read_u32_2darray(madera->dev, "cirrus,out-mono",
+					     out_mono, ARRAY_SIZE(out_mono), 1);
+	if (n > 0)
+		for (i = 0; i < n; ++i)
+			pdata->out_mono[i] = !!out_mono[i];
+
+	device_property_read_u32_2darray(madera->dev,
+					 "cirrus,max-channels-clocked",
+					 pdata->max_channels_clocked,
+					 ARRAY_SIZE(pdata->max_channels_clocked),
+					 1);
+
+	device_property_read_u32_2darray(madera->dev, "cirrus,pdm-fmt",
+					 pdata->pdm_fmt,
+					 ARRAY_SIZE(pdata->pdm_fmt), 1);
+
+	device_property_read_u32_2darray(madera->dev, "cirrus,pdm-mute",
+					 pdata->pdm_mute,
+					 ARRAY_SIZE(pdata->pdm_mute), 1);
+
+	device_property_read_u32_2darray(madera->dev, "cirrus,dmic-ref",
+					 pdata->dmic_ref,
+					 ARRAY_SIZE(pdata->dmic_ref), 1);
+}
+
 int madera_core_init(struct madera_priv *priv)
 {
 	int i;
@@ -308,6 +370,9 @@ int madera_core_init(struct madera_priv *priv)
 	BUILD_BUG_ON(!madera_mixer_texts[MADERA_NUM_MIXER_INPUTS - 1]);
 	BUILD_BUG_ON(!madera_mixer_values[MADERA_NUM_MIXER_INPUTS - 1]);
 
+	if (!dev_get_platdata(priv->madera->dev))
+		madera_prop_get_pdata(priv);
+
 	mutex_init(&priv->rate_lock);
 
 	for (i = 0; i < MADERA_MAX_HP_OUTPUT; i++)
-- 
2.11.0

