Return-Path: <linux-acpi+bounces-17502-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65037BB3C44
	for <lists+linux-acpi@lfdr.de>; Thu, 02 Oct 2025 13:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B8497AA771
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Oct 2025 11:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8103101B2;
	Thu,  2 Oct 2025 11:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QSTYr0P5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650A13081D9
	for <linux-acpi@vger.kernel.org>; Thu,  2 Oct 2025 11:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759404853; cv=none; b=uBdGLOlvAhQvnNBLVQqkrXmgKAoRXGv1Yncjks+fI7Ro87tlJd6aInJZdLj+IWaTFupJosbkW8PKwTkmzT1VY4eERRbMOCHht8nMu/fM/g0wJ+SdbLxrZhISmFh1Zh6+VtCIb38hgdxiUpik+Iv/cyyh9v02wXkmkG05aqbnXMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759404853; c=relaxed/simple;
	bh=J2/RE+wcyjAAKq8EIblB7xOAgS7mLmXhSRoseJOM6qo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HbQCaLJfQ8f15NODc/Z3qTfCMmDGg/uotEDLeKfsPHPcHXjlvGIC3QufNbY6L8ll34CDY5+qy0b+eq/A0fYkFV5kiY7dl4ADg8BPCsMj/dXrcX67xEUb+RxMuDA1sCABcN6tIIUMvdmwY0EMn8YRbrVyGZM2vHr97+UKA64wSqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QSTYr0P5; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-634779072f7so1067930a12.3
        for <linux-acpi@vger.kernel.org>; Thu, 02 Oct 2025 04:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759404849; x=1760009649; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fmAJYrTmItlTyHOpDg7j/+fR8RNBuEds8SsTFXNa2iU=;
        b=QSTYr0P5HZbSN7pqnjHEkFLyxFiQ4+fNCy0K9JuUBwv63EMk3LkI75nWCWjraxc8A7
         P2/GHAgAkcEG7/DC93OVSB7sSH3puL2iBx249DufolMbGyZkwhZeNuuF1XWNOE5zrPRK
         oeA6Vex/F1/NgqVsJnKK+aXkMu6uUWwSeXQnht/bZXkq6SQHyHbgdiLCyDApFNZNY86J
         dIc85OgbP40+TDGKbTZpi3VZr9aJyC8KDyRSMnUWAM/oMOB2vfFoQUkdZHgOfJyqQ2Rg
         qh6h0hzfgiz4BOlJW213M51G/+bW1cv0H1xCPXXxKELcDqXr0gNm28qHleeuobmubyGr
         ypkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759404849; x=1760009649;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fmAJYrTmItlTyHOpDg7j/+fR8RNBuEds8SsTFXNa2iU=;
        b=N15iYNiXzU3fePYPdjifQ92pInRFaGA7vroNdmjHEDWWjrmpFSfHJJJuozggT/Co4r
         Y0VeIRws2BVBB5zFCtrO1pwymBnVnbV5ovTjnf5uV7n6wfTurxPK7GaxhZ1U3r1Aw2Mc
         X5I13+eyUI371/A0IZGJSHavowBo8G0DtnjwgB5dSO6Ct40Fd9wFZ9kutVQ/K9gC2l0C
         38VVdAtGlhe/d/pMfkEw/kS3ZF3hoxpMmfJyn8jbUOCcEQB5xXVIBpbxa60Qlk7oCk+t
         uv47Kt7rN49FhuA8fcT/KEQwyI8J56ajaMpRT1MYLdO+OfrbWZmEw4MCcK43KPxsnKit
         z8tw==
X-Forwarded-Encrypted: i=1; AJvYcCX2twkuuTr4lCV9PV2rCTDuhNJ2no9Y4PLNbwkCqhNv/ND4GjPJQru64TtirxZdH4j3xajM5kl+nYOM@vger.kernel.org
X-Gm-Message-State: AOJu0YyVoOHms+c9poVkrJ5kqDQIiOwvlFIhcT44YQZi2lL4/CpplFuy
	81Ve+yowWkvhdIZJz2UlOoIwrNHhvqOLRaQ6mdJG85e51vwtn2bMV+2248fcvWLdg0G2eCx+Oj/
	fWuqZ0A==
X-Google-Smtp-Source: AGHT+IEVj4vd705hRI1+FyDga0YuwYIHHLD8yvOm22iMxGCDPDnuw0E7JmGDFjmhlbedznVsGfjqhnp3nYU=
X-Received: from edsk22.prod.google.com ([2002:aa7:d8d6:0:b0:634:90ba:1f65])
 (user=srosek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:4409:b0:631:fe26:a661
 with SMTP id 4fb4d7f45d1cf-63678bcb6abmr8021731a12.3.1759404848478; Thu, 02
 Oct 2025 04:34:08 -0700 (PDT)
Date: Thu,  2 Oct 2025 11:34:00 +0000
In-Reply-To: <20251002113404.3117429-1-srosek@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251002113404.3117429-1-srosek@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251002113404.3117429-3-srosek@google.com>
Subject: [PATCH v3 2/6] ACPI: DPTF: Move INT340X device IDs to header
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
2.51.0.618.g983fd99d29-goog


