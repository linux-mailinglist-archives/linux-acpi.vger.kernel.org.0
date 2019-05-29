Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7FB02DA43
	for <lists+linux-acpi@lfdr.de>; Wed, 29 May 2019 12:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbfE2KUN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 29 May 2019 06:20:13 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:60428 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725894AbfE2KUM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 29 May 2019 06:20:12 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4TAHvAF001085;
        Wed, 29 May 2019 05:19:55 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail4.cirrus.com ([87.246.98.35])
        by mx0b-001ae601.pphosted.com with ESMTP id 2sq24q4kbn-1;
        Wed, 29 May 2019 05:19:55 -0500
Received: from EDIEX01.ad.cirrus.com (ediex01.ad.cirrus.com [198.61.84.80])
        by mail4.cirrus.com (Postfix) with ESMTP id 3C79B611C8AC;
        Wed, 29 May 2019 05:20:42 -0500 (CDT)
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Wed, 29 May
 2019 11:19:54 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Wed, 29 May 2019 11:19:54 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5BA442DA;
        Wed, 29 May 2019 11:19:54 +0100 (BST)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <lee.jones@linaro.org>,
        <rafael@kernel.org>, <gregkh@linuxfoundation.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <patches@opensource.cirrus.com>, <linux-acpi@vger.kernel.org>
Subject: [PATCH v2 2/6] ASoC: madera: Add DT bindings for Cirrus Logic Madera codecs
Date:   Wed, 29 May 2019 11:19:50 +0100
Message-ID: <20190529101954.10438-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190529101954.10438-1-ckeepax@opensource.cirrus.com>
References: <20190529101954.10438-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905290069
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Richard Fitzgerald <rf@opensource.cirrus.com>

The Cirrus Logic Madera codecs are a family of related codecs with
extensive digital and analogue I/O, digital mixing and routing,
signal processing and programmable DSPs.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

No change since v1.

Thanks,
Charles

 Documentation/devicetree/bindings/sound/madera.txt | 67 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 include/dt-bindings/sound/madera.h                 | 29 ++++++++++
 3 files changed, 97 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/madera.txt
 create mode 100644 include/dt-bindings/sound/madera.h

diff --git a/Documentation/devicetree/bindings/sound/madera.txt b/Documentation/devicetree/bindings/sound/madera.txt
new file mode 100644
index 0000000000000..1114fcf1aa4c2
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/madera.txt
@@ -0,0 +1,67 @@
+Cirrus Logic Madera class audio codecs
+
+This describes audio configuration bindings for these codecs.
+
+See also the core bindings for the parent MFD driver:
+See Documentation/devicetree/bindings/mfd/madera.txt
+
+and defines for values used in these bindings:
+include/dt-bindings/sound/madera.h
+
+These properties are all contained in the parent MFD node.
+
+Optional properties:
+  - cirrus,dmic-ref : Indicates how the MICBIAS pins have been externally
+    connected to DMICs on each input, one cell per input.
+    <IN1 IN2 IN3 ...>
+    A value of 0 indicates MICVDD and is the default, other values depend on the
+    codec:
+    For CS47L35 one of the CS47L35_DMIC_REF_xxx values
+    For all other codecs one of the MADERA_DMIC_REF_xxx values
+    Also see the datasheet for a description of the INn_DMIC_SUP field.
+
+  - cirrus,inmode : A list of input mode settings for each input. A maximum of
+    16 cells, with four cells per input in the order INnAL, INnAR INnBL INnBR.
+    For non-muxed inputs the first two cells for that input set the mode for
+    the left and right channel and the second two cells must be 0.
+    For muxed inputs the first two cells for that input set the mode of the
+    left and right A inputs and the second two cells set the mode of the left
+    and right B inputs.
+    Valid mode values are one of the MADERA_INMODE_xxx. If the array is shorter
+    than the number of inputs the unspecified inputs default to
+    MADERA_INMODE_DIFF.
+
+  - cirrus,out-mono : Mono bit for each output, must contain six cells if
+    specified. A non-zero value indicates the corresponding output is mono.
+
+  - cirrus,max-channels-clocked : Maximum number of channels that I2S clocks
+    will be generated for. Useful when clock master for systems where the I2S
+    bus has multiple data lines.
+    One cell for each AIF, use a value of zero for AIFs that should be handled
+    normally.
+
+  - cirrus,pdm-fmt : PDM speaker data format, must contain 2 cells
+    (OUT5 and OUT6). See the PDM_SPKn_FMT field in the datasheet for a
+    description of this value.
+    The second cell is ignored for codecs that do not have OUT6.
+
+  - cirrus,pdm-mute : PDM mute format, must contain 2 cells
+    (OUT5 and OUT6). See the PDM_SPKn_CTRL_1 register in the datasheet for a
+    description of this value.
+    The second cell is ignored for codecs that do not have OUT6.
+
+Example:
+
+cs47l35@0 {
+	compatible = "cirrus,cs47l35";
+
+	cirrus,dmic-ref = <0 0 CS47L35_DMIC_REF_MICBIAS1B 0>;
+	cirrus,inmode = <
+		MADERA_INMODE_DMIC MADERA_INMODE_DMIC /* IN1A digital */
+		MADERA_INMODE_SE   MADERA_INMODE_SE   /* IN1B single-ended */
+		MADERA_INMODE_DIFF MADERA_INMODE_DIFF /* IN2 differential */
+		0 0 	/* not used on this codec */
+	>;
+	cirrus,out-mono = <0 0 0 0 0 0>;
+	cirrus,max-channels-clocked = <2 0 0>;
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index 5cfbea4ce5750..642cb5610dd50 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3915,6 +3915,7 @@ W:	https://github.com/CirrusLogic/linux-drivers/wiki
 S:	Supported
 F:	Documentation/devicetree/bindings/mfd/madera.txt
 F:	Documentation/devicetree/bindings/pinctrl/cirrus,madera-pinctrl.txt
+F:	include/dt-bindings/sound/madera*
 F:	include/linux/irqchip/irq-madera*
 F:	include/linux/mfd/madera/*
 F:	drivers/gpio/gpio-madera*
diff --git a/include/dt-bindings/sound/madera.h b/include/dt-bindings/sound/madera.h
new file mode 100644
index 0000000000000..9ff4eae5259b0
--- /dev/null
+++ b/include/dt-bindings/sound/madera.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Device Tree defines for Madera codecs
+ *
+ * Copyright (C) 2016-2017 Cirrus Logic, Inc. and
+ *                         Cirrus Logic International Semiconductor Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef DT_BINDINGS_SOUND_MADERA_H
+#define DT_BINDINGS_SOUND_MADERA_H
+
+#define MADERA_INMODE_DIFF		0
+#define MADERA_INMODE_SE		1
+#define MADERA_INMODE_DMIC		2
+
+#define MADERA_DMIC_REF_MICVDD		0
+#define MADERA_DMIC_REF_MICBIAS1	1
+#define MADERA_DMIC_REF_MICBIAS2	2
+#define MADERA_DMIC_REF_MICBIAS3	3
+
+#define CS47L35_DMIC_REF_MICBIAS1B	1
+#define CS47L35_DMIC_REF_MICBIAS2A	2
+#define CS47L35_DMIC_REF_MICBIAS2B	3
+
+#endif
-- 
2.11.0

