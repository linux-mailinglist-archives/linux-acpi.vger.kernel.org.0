Return-Path: <linux-acpi+bounces-17067-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 731C8B7CB92
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Sep 2025 14:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3DF07A2303
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Sep 2025 12:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DD530CB58;
	Wed, 17 Sep 2025 12:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DSoMv4nQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607AD30CB3C
	for <linux-acpi@vger.kernel.org>; Wed, 17 Sep 2025 12:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758110863; cv=none; b=qsg0oPL0/JuIvDBm6jB9HITR4986WLe/+MeR1CBSbh68fqFyNCl2Cq3SMDRU8ia7vqU/f1Ynhg7lYbahXigIJgbe+PzaD+1t5Fdn2bju6/A2BYUjTUcyF20lEu8DllSCbiJSih1PR3MYsDds1sKUR0sYrUN6/LtvqCenAOJ2YoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758110863; c=relaxed/simple;
	bh=3GKrM5qvk/7L+4STTpEdIWwKZscM3QuPJv3FqOM9Va8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Rh0gy7+avPLgXT7NE3JwQIA+fIFegztPB7AUeCjINQ+vdp6CWXECqQLA50uwIOosz8wGqHphX5f64rrZ/v9pK0D6t9E3s2U8759GSEx9eGkbIFz3hDsQaZTav3XZnFIxxA1bY++pjDn/JoWvGowSPqPhfhmXdaq2RMet48vPVL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DSoMv4nQ; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b0f435a8e5eso392694566b.0
        for <linux-acpi@vger.kernel.org>; Wed, 17 Sep 2025 05:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758110860; x=1758715660; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NV43YwBZiRSdCnIID1DuFxlHUNP/YouE1V9ZkJbiCfw=;
        b=DSoMv4nQov4r38xBl9X1ucxl3NEeRJ5bcQrsUGbAZn8N4Vr48GdekCQBs14bf6kdiD
         F1snO/G/ePYv6uuWnYXj/ig/gRgwjjmkqTHzKawbPldPIArG3eVUhqJqwDb32tQBtlPc
         o2M9nk6qcTdBtJ1Msj4euP0j3gsZMjnLlTcv0Qt+msSnTwesXYk0Tkof8Wn6Szb2wE8g
         lEXwmp8JBeOv0xnklUCVGszMjWfAV3IQLUYYQL2k/Hs/vXiSAfmdF8caly9axQIcqkT5
         D8ZZATfo9g2E4zeWeL4FyC/7pnpvYA/HOy2mDem1YyTUHPjm4qBGEQaFtA7dhCInU5Sq
         V2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758110860; x=1758715660;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NV43YwBZiRSdCnIID1DuFxlHUNP/YouE1V9ZkJbiCfw=;
        b=dF+xSEQhQrso+EsWzBGgzT2S6yp80j5pHK8POvDSq2Z+yPrKLrkv3pnjhOnp44t6Oc
         x204vC2Sr5kgRtIT5uESCe6uyd7ERLUaenqMCfSba8h2iXmRIa7JPw5eQsAtTg0NiM8u
         nvD6gSimG05+0HBACm1SKvq4sjSEJAaUzuukNpOwLX1qzKKYyw6krb3ayt4LcB+wvQWh
         e0d0E5RZScWDxHLtHLvqkozyHWmjri/5TTVr+Eem9kSI5/fbpvci8kNoTkZJyOaRszQp
         t3iKrzX0yxSGcotZo93V0ICWE7tKgkBN2+iaVm3Wd7WYjRYEx2CeJhebmHlRlfntP9pW
         Mukw==
X-Forwarded-Encrypted: i=1; AJvYcCURxP9EH+Tz/sOLLF9TqefTAgOc4r+G/S16AEIniR0znXutVF/MyLEVxUTib6/ZALdImmtr8MKN3vm8@vger.kernel.org
X-Gm-Message-State: AOJu0YxIpxGtCxOBsZlanVn6D29a2zY9pgbqIrxbpUpIkPKgFG5jyP6p
	5P6quokA/TWXpFgBAww66OZAJYz1l5z3+W/Qvp6Qr5DUsXE6PDD82vj+AcAdJs1/ZhCFx+jhcqH
	Gb8zQKg==
X-Google-Smtp-Source: AGHT+IFjjeeDTEOyecd8Zr4tdZZMZaH/t1jfmBx1qoRAE6uV2MaObMSXrX+vngcdsUxJ9Ux7ia/cMUMtasc=
X-Received: from edh23.prod.google.com ([2002:a05:6402:5057:b0:61e:d219:d99d])
 (user=srosek job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:3f19:b0:b04:84db:c83
 with SMTP id a640c23a62f3a-b1bbb067943mr232742966b.27.1758110859801; Wed, 17
 Sep 2025 05:07:39 -0700 (PDT)
Date: Wed, 17 Sep 2025 12:07:15 +0000
In-Reply-To: <20250917120719.2390847-1-srosek@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250917120719.2390847-1-srosek@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250917120719.2390847-3-srosek@google.com>
Subject: [PATCH v2 2/6] ACPI: DPTF: Move INT340X device IDs to header
From: Slawomir Rosek <srosek@google.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Alex Hung <alexhung@gmail.com>, 
	Hans de Goede <hansg@kernel.org>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, 
	AceLan Kao <acelan.kao@canonical.com>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Tomasz Nowicki <tnowicki@google.com>, 
	Stanislaw Kardach <skardach@google.com>, Michal Krawczyk <mikrawczyk@google.com>, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org, 
	Slawomir Rosek <srosek@google.com>
Content-Type: text/plain; charset="UTF-8"

The ACPI INT340X device IDs are shared between the DPTF core
and thermal drivers, thus they are moved to the common header.

Signed-off-by: Slawomir Rosek <srosek@google.com>
---
 drivers/acpi/dptf/dptf_power.c                | 18 +----
 drivers/acpi/dptf/int340x_thermal.c           | 51 +++-----------
 drivers/acpi/fan.h                            | 10 +--
 drivers/acpi/int340x_thermal.h                | 68 +++++++++++++++++++
 .../intel/int340x_thermal/int3400_thermal.c   | 10 +--
 .../intel/int340x_thermal/int3401_thermal.c   |  3 +-
 .../intel/int340x_thermal/int3402_thermal.c   |  3 +-
 .../intel/int340x_thermal/int3403_thermal.c   | 10 +--
 .../intel/int340x_thermal/int3406_thermal.c   |  3 +-
 9 files changed, 90 insertions(+), 86 deletions(-)
 create mode 100644 drivers/acpi/int340x_thermal.h

diff --git a/drivers/acpi/dptf/dptf_power.c b/drivers/acpi/dptf/dptf_power.c
index 776914f31b9e..d7c59f016083 100644
--- a/drivers/acpi/dptf/dptf_power.c
+++ b/drivers/acpi/dptf/dptf_power.c
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <linux/acpi.h>
 #include <linux/platform_device.h>
+#include "../int340x_thermal.h"
 
 /*
  * Presentation of attributes which are defined for INT3407 and INT3532.
@@ -224,22 +225,7 @@ static void dptf_power_remove(struct platform_device *pdev)
 }
 
 static const struct acpi_device_id int3407_device_ids[] = {
-	{"INT3407", 0},
-	{"INT3532", 0},
-	{"INTC1047", 0},
-	{"INTC1050", 0},
-	{"INTC1060", 0},
-	{"INTC1061", 0},
-	{"INTC1065", 0},
-	{"INTC1066", 0},
-	{"INTC106C", 0},
-	{"INTC106D", 0},
-	{"INTC10A4", 0},
-	{"INTC10A5", 0},
-	{"INTC10D8", 0},
-	{"INTC10D9", 0},
-	{"INTC1100", 0},
-	{"INTC1101", 0},
+	ACPI_INT3407_DEVICE_IDS,
 	{"", 0},
 };
 MODULE_DEVICE_TABLE(acpi, int3407_device_ids);
diff --git a/drivers/acpi/dptf/int340x_thermal.c b/drivers/acpi/dptf/int340x_thermal.c
index 947fe50c2ef6..43afb6141b98 100644
--- a/drivers/acpi/dptf/int340x_thermal.c
+++ b/drivers/acpi/dptf/int340x_thermal.c
@@ -9,63 +9,28 @@
 #include <linux/acpi.h>
 #include <linux/module.h>
 
+#include "../int340x_thermal.h"
 #include "../internal.h"
 
 static const struct acpi_device_id int340x_thermal_device_ids[] = {
-	{"INT3400"},
-	{"INT3401"},
-	{"INT3402"},
-	{"INT3403"},
-	{"INT3404"},
-	{"INT3406"},
-	{"INT3407"},
+	ACPI_INT3400_DEVICE_IDS,
+	ACPI_INT3401_DEVICE_IDS,
+	ACPI_INT3402_DEVICE_IDS,
+	ACPI_INT3403_DEVICE_IDS,
+	ACPI_INT3404_DEVICE_IDS,
+	ACPI_INT3406_DEVICE_IDS,
+	ACPI_INT3407_DEVICE_IDS,
 	{"INT3408"},
 	{"INT3409"},
 	{"INT340A"},
 	{"INT340B"},
-	{"INT3532"},
-	{"INTC1040"},
-	{"INTC1041"},
-	{"INTC1042"},
-	{"INTC1043"},
-	{"INTC1044"},
 	{"INTC1045"},
-	{"INTC1046"},
-	{"INTC1047"},
-	{"INTC1048"},
 	{"INTC1049"},
-	{"INTC1050"},
-	{"INTC1060"},
-	{"INTC1061"},
-	{"INTC1062"},
-	{"INTC1063"},
 	{"INTC1064"},
-	{"INTC1065"},
-	{"INTC1066"},
-	{"INTC1068"},
-	{"INTC1069"},
-	{"INTC106A"},
 	{"INTC106B"},
-	{"INTC106C"},
-	{"INTC106D"},
-	{"INTC10A0"},
-	{"INTC10A1"},
-	{"INTC10A2"},
 	{"INTC10A3"},
-	{"INTC10A4"},
-	{"INTC10A5"},
-	{"INTC10D4"},
-	{"INTC10D5"},
-	{"INTC10D6"},
 	{"INTC10D7"},
-	{"INTC10D8"},
-	{"INTC10D9"},
-	{"INTC10FC"},
-	{"INTC10FD"},
-	{"INTC10FE"},
 	{"INTC10FF"},
-	{"INTC1100"},
-	{"INTC1101"},
 	{"INTC1102"},
 	{""},
 };
diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
index 8a28a72a7c6a..4015ac56c009 100644
--- a/drivers/acpi/fan.h
+++ b/drivers/acpi/fan.h
@@ -11,16 +11,10 @@
 #define _ACPI_FAN_H_
 
 #include <linux/kconfig.h>
+#include "int340x_thermal.h"
 
 #define ACPI_FAN_DEVICE_IDS	\
-	{"INT3404", }, /* Fan */ \
-	{"INTC1044", }, /* Fan for Tiger Lake generation */ \
-	{"INTC1048", }, /* Fan for Alder Lake generation */ \
-	{"INTC1063", }, /* Fan for Meteor Lake generation */ \
-	{"INTC106A", }, /* Fan for Lunar Lake generation */ \
-	{"INTC10A2", }, /* Fan for Raptor Lake generation */ \
-	{"INTC10D6", }, /* Fan for Panther Lake generation */ \
-	{"INTC10FE", }, /* Fan for Wildcat Lake generation */ \
+	ACPI_INT3404_DEVICE_IDS, \
 	{"PNP0C0B", } /* Generic ACPI fan */
 
 #define ACPI_FPS_NAME_LEN	20
diff --git a/drivers/acpi/int340x_thermal.h b/drivers/acpi/int340x_thermal.h
new file mode 100644
index 000000000000..854e4d3bb739
--- /dev/null
+++ b/drivers/acpi/int340x_thermal.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+/*
+ * The ACPI INT340X device IDs are shared between the DPTF core
+ * and thermal drivers.
+ */
+
+#ifndef _ACPI_INT340X_H_
+#define _ACPI_INT340X_H_
+
+#define ACPI_INT3400_DEVICE_IDS	\
+	{"INT3400"},	\
+	{"INTC1040"},	\
+	{"INTC1041"},	\
+	{"INTC1042"},	\
+	{"INTC1068"},	\
+	{"INTC10A0"},	\
+	{"INTC10D4"},	\
+	{"INTC10FC"}
+
+#define ACPI_INT3401_DEVICE_IDS	\
+	{"INT3401"}
+
+#define ACPI_INT3402_DEVICE_IDS	\
+	{"INT3402"}
+
+#define ACPI_INT3403_DEVICE_IDS	\
+	{"INT3403"},	\
+	{"INTC1043"},	\
+	{"INTC1046"},	\
+	{"INTC1062"},	\
+	{"INTC1069"},	\
+	{"INTC10A1"},	\
+	{"INTC10D5"},	\
+	{"INTC10FD"}
+
+#define ACPI_INT3404_DEVICE_IDS	\
+	{"INT3404", }, /* Fan */ \
+	{"INTC1044", }, /* Fan for Tiger Lake generation */ \
+	{"INTC1048", }, /* Fan for Alder Lake generation */ \
+	{"INTC1063", }, /* Fan for Meteor Lake generation */ \
+	{"INTC106A", }, /* Fan for Lunar Lake generation */ \
+	{"INTC10A2", }, /* Fan for Raptor Lake generation */ \
+	{"INTC10D6", }, /* Fan for Panther Lake generation */ \
+	{"INTC10FE", } /* Fan for Wildcat Lake generation */
+
+#define ACPI_INT3406_DEVICE_IDS	\
+	{"INT3406"}
+
+#define ACPI_INT3407_DEVICE_IDS	\
+	{"INT3407"},	\
+	{"INT3532"},	\
+	{"INTC1047"},	\
+	{"INTC1050"},	\
+	{"INTC1060"},	\
+	{"INTC1061"},	\
+	{"INTC1065"},	\
+	{"INTC1066"},	\
+	{"INTC106C"},	\
+	{"INTC106D"},	\
+	{"INTC10A4"},	\
+	{"INTC10A5"},	\
+	{"INTC10D8"},	\
+	{"INTC10D9"},	\
+	{"INTC1100"},	\
+	{"INTC1101"}
+
+#endif
diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index 908cc1bf57f1..6311125c3ebd 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -11,6 +11,7 @@
 #include <linux/acpi.h>
 #include <linux/thermal.h>
 #include "acpi_thermal_rel.h"
+#include "../../../../drivers/acpi/int340x_thermal.h"
 
 #define INT3400_THERMAL_TABLE_CHANGED 0x83
 #define INT3400_ODVP_CHANGED 0x88
@@ -683,14 +684,7 @@ static void int3400_thermal_remove(struct platform_device *pdev)
 }
 
 static const struct acpi_device_id int3400_thermal_match[] = {
-	{"INT3400", 0},
-	{"INTC1040", 0},
-	{"INTC1041", 0},
-	{"INTC1042", 0},
-	{"INTC1068", 0},
-	{"INTC10A0", 0},
-	{"INTC10D4", 0},
-	{"INTC10FC", 0},
+	ACPI_INT3400_DEVICE_IDS,
 	{}
 };
 
diff --git a/drivers/thermal/intel/int340x_thermal/int3401_thermal.c b/drivers/thermal/intel/int340x_thermal/int3401_thermal.c
index 96d6277a5a8c..e0603f218d2e 100644
--- a/drivers/thermal/intel/int340x_thermal/int3401_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3401_thermal.c
@@ -11,9 +11,10 @@
 
 #include "int340x_thermal_zone.h"
 #include "processor_thermal_device.h"
+#include "../../../../drivers/acpi/int340x_thermal.h"
 
 static const struct acpi_device_id int3401_device_ids[] = {
-	{"INT3401", 0},
+	ACPI_INT3401_DEVICE_IDS,
 	{"", 0},
 };
 MODULE_DEVICE_TABLE(acpi, int3401_device_ids);
diff --git a/drivers/thermal/intel/int340x_thermal/int3402_thermal.c b/drivers/thermal/intel/int340x_thermal/int3402_thermal.c
index 57b90005888a..213d4535f2c1 100644
--- a/drivers/thermal/intel/int340x_thermal/int3402_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3402_thermal.c
@@ -11,6 +11,7 @@
 #include <linux/acpi.h>
 #include <linux/thermal.h>
 #include "int340x_thermal_zone.h"
+#include "../../../../drivers/acpi/int340x_thermal.h"
 
 #define INT3402_PERF_CHANGED_EVENT	0x80
 #define INT3402_THERMAL_EVENT		0x90
@@ -84,7 +85,7 @@ static void int3402_thermal_remove(struct platform_device *pdev)
 }
 
 static const struct acpi_device_id int3402_thermal_match[] = {
-	{"INT3402", 0},
+	ACPI_INT3402_DEVICE_IDS,
 	{}
 };
 
diff --git a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
index ba63796761eb..d246c69d4872 100644
--- a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
@@ -12,6 +12,7 @@
 #include <linux/thermal.h>
 #include <linux/platform_device.h>
 #include "int340x_thermal_zone.h"
+#include "../../../../drivers/acpi/int340x_thermal.h"
 
 #define INT3403_TYPE_SENSOR		0x03
 #define INT3403_TYPE_CHARGER		0x0B
@@ -269,14 +270,7 @@ static void int3403_remove(struct platform_device *pdev)
 }
 
 static const struct acpi_device_id int3403_device_ids[] = {
-	{"INT3403", 0},
-	{"INTC1043", 0},
-	{"INTC1046", 0},
-	{"INTC1062", 0},
-	{"INTC1069", 0},
-	{"INTC10A1", 0},
-	{"INTC10D5", 0},
-	{"INTC10FD", 0},
+	ACPI_INT3403_DEVICE_IDS,
 	{"", 0},
 };
 MODULE_DEVICE_TABLE(acpi, int3403_device_ids);
diff --git a/drivers/thermal/intel/int340x_thermal/int3406_thermal.c b/drivers/thermal/intel/int340x_thermal/int3406_thermal.c
index e21fcbccf4ba..d05ca8bc4061 100644
--- a/drivers/thermal/intel/int340x_thermal/int3406_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3406_thermal.c
@@ -12,6 +12,7 @@
 #include <linux/backlight.h>
 #include <linux/thermal.h>
 #include <acpi/video.h>
+#include "../../../../drivers/acpi/int340x_thermal.h"
 
 #define INT3406_BRIGHTNESS_LIMITS_CHANGED	0x80
 
@@ -187,7 +188,7 @@ static void int3406_thermal_remove(struct platform_device *pdev)
 }
 
 static const struct acpi_device_id int3406_thermal_match[] = {
-	{"INT3406", 0},
+	ACPI_INT3406_DEVICE_IDS,
 	{}
 };
 
-- 
2.51.0.384.g4c02a37b29-goog


