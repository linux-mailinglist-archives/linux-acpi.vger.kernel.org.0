Return-Path: <linux-acpi+bounces-17071-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 836E0B7CC0D
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Sep 2025 14:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 389E9586830
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Sep 2025 12:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FD832340C;
	Wed, 17 Sep 2025 12:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uyuI34de"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DC031A7FA
	for <linux-acpi@vger.kernel.org>; Wed, 17 Sep 2025 12:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758110868; cv=none; b=Bx7NIcNR0SOzwP+cXMzBf3BeSl4+F4Uyr3lYhTPTUlnIUZ5rwIkFhnyl9KUrXXGoZ6p+pEl/NLmdZFl4LCTho946wxNI53Zc4qMbJ0wEiycbb17/4I/4gnqDDhz6tvbD4goMV74VNcs6BCMhiddarN7V+4bG/Jv/u4XBkR0bRwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758110868; c=relaxed/simple;
	bh=tU762bI0xjmHVqq18zAAOPUzkyoCPt7UCqr5rNDSzXg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mfqet2519Yk3ocxQ54mcexiI5IKBvIJtR6IiefkgGm7AtDCVTgIWEzcGCtuk9JUwBg+pzOJgnczKF3YasjEghT1wOmCyX7qEAzCXxVcEimFBlWgfEB+PO6QVSp9qDWOgLWDnuALp4cQ+mJZfokRVGw3EnKHq9pTsMN0IRvlSUAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uyuI34de; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3eb72c3e669so1632926f8f.3
        for <linux-acpi@vger.kernel.org>; Wed, 17 Sep 2025 05:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758110864; x=1758715664; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BlR6y3fxG98sQ/Eewnl5kAjfb6+S1suRK717CcwkbKU=;
        b=uyuI34deKtzMNdtMSWwOHub0IrOrglhEagNgHyhd0gSGXOxtrGFiiSM4PxOMzAjKLN
         3D310wl+0gw8lsbSr1mhn4QcJhMYGviMSR3upgBNpf4CbJjp4OEd6LwEm+1vuv894dFL
         vNogqY8jWz/IoM3EoJ/KFqP5V1AZp6JW5DqwK48o5EO+KaNemm8C/K1bEU7DWXm2IIMo
         PQoxfdlFtfUgpgNklYLFXoNuljFnpNBm4vrceEpZYQ61ufEGhjw+7SJP++DgHDwKTsOr
         uIHeb8MvN0IUGH/UW2mgJYL+x9Ab3SQU8bktdnCtVWKDa3RFUpwfYR6kt1XusVgp9Oux
         kGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758110864; x=1758715664;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BlR6y3fxG98sQ/Eewnl5kAjfb6+S1suRK717CcwkbKU=;
        b=s3f0J+LM6CvJvCpSq/Q61YBW8tp/kMK3XvHOUnMoHuXIhQEp7siRnTKQRd7UsiOBMM
         ZmeP6Bb1X9h246/xRYM5vuxH8qm/HRjvoaoY7sr9rn8dsJAgBKVRKD8ro+XIWUCcWVUQ
         OTF7tJgwddBR6kOqo8uXRjMOx4k2nmSQOZF/xvzyQTs/u0xC2bxtHLBi56gqXMZk/A2U
         r9K1tOnEZVq9SJi4jmctKMcPxpJ5gewJ61Z+0z2H/MY9LUSkacODNgThoyw3oM5HOfid
         tVb9eeopf5fH3lsqrZBXy1AFqf3SeBvKGswDBgw7Skks5cX2JgT+Tq/2iqPuh9U/kC6W
         XC6g==
X-Forwarded-Encrypted: i=1; AJvYcCWXJyYdJN/Nx15J29TlV/G9cvCaNSOheaOS7e4uXP7b+AlqLanrp/csCr47vYIkYLpWFGyHEOzYx1it@vger.kernel.org
X-Gm-Message-State: AOJu0Yys+syAB3ImMN5s25zPzUxY9CDPizIvZq13Tzlpwq09TWcTalKR
	FF8XgmeyVk0eKzAVQ/+4Z1TSo5h9WmeoMK9Z0I8M0vpo2n4fImAArDPLK0TbS9XYjXgkQD8/gCR
	VH/hRgA==
X-Google-Smtp-Source: AGHT+IGOAdZFO28NRYCmZTgbDO00GhheP/jEh493wkfP2hN9YkezE8rvmlHxlcfstNv8u00RkaPzUYQvyWI=
X-Received: from wrbdn1.prod.google.com ([2002:a05:6000:c01:b0:3d6:801b:c728])
 (user=srosek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:24ca:b0:3d6:212b:9ae2
 with SMTP id ffacd0b85a97d-3ecdfa4d51dmr1825000f8f.63.1758110864148; Wed, 17
 Sep 2025 05:07:44 -0700 (PDT)
Date: Wed, 17 Sep 2025 12:07:19 +0000
In-Reply-To: <20250917120719.2390847-1-srosek@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250917120719.2390847-1-srosek@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250917120719.2390847-7-srosek@google.com>
Subject: [PATCH v2 6/6] ACPI: DPTF: Move INT340X enumeration to modules
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

Move enumeration of INT340X ACPI device objects on the platform bus
from DPTF core to thermal drivers using ACPI platform core methods

Signed-off-by: Slawomir Rosek <srosek@google.com>
---
 drivers/acpi/dptf/dptf_pch_fivr.c                       | 2 +-
 drivers/acpi/dptf/dptf_power.c                          | 2 +-
 drivers/acpi/dptf/int340x_thermal.c                     | 7 +++++--
 drivers/acpi/fan_core.c                                 | 2 +-
 drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 2 +-
 drivers/thermal/intel/int340x_thermal/int3401_thermal.c | 2 +-
 drivers/thermal/intel/int340x_thermal/int3402_thermal.c | 2 +-
 drivers/thermal/intel/int340x_thermal/int3403_thermal.c | 2 +-
 drivers/thermal/intel/int340x_thermal/int3406_thermal.c | 2 +-
 9 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/dptf/dptf_pch_fivr.c b/drivers/acpi/dptf/dptf_pch_fivr.c
index cb81636a5d63..f3cd52c89e8d 100644
--- a/drivers/acpi/dptf/dptf_pch_fivr.c
+++ b/drivers/acpi/dptf/dptf_pch_fivr.c
@@ -162,7 +162,7 @@ static struct platform_driver pch_fivr_driver = {
 	},
 };
 
-module_platform_driver(pch_fivr_driver);
+module_acpi_platform_driver(pch_fivr_driver);
 
 MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/acpi/dptf/dptf_power.c b/drivers/acpi/dptf/dptf_power.c
index d7c59f016083..b85e876b2e85 100644
--- a/drivers/acpi/dptf/dptf_power.c
+++ b/drivers/acpi/dptf/dptf_power.c
@@ -239,7 +239,7 @@ static struct platform_driver dptf_power_driver = {
 	},
 };
 
-module_platform_driver(dptf_power_driver);
+module_acpi_platform_driver(dptf_power_driver);
 
 MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/acpi/dptf/int340x_thermal.c b/drivers/acpi/dptf/int340x_thermal.c
index 7d1308b1f513..b2be3a8df9ac 100644
--- a/drivers/acpi/dptf/int340x_thermal.c
+++ b/drivers/acpi/dptf/int340x_thermal.c
@@ -27,8 +27,11 @@ static const struct acpi_device_id int340x_thermal_device_ids[] = {
 static int int340x_thermal_handler_attach(struct acpi_device *adev,
 					const struct acpi_device_id *id)
 {
-	if (IS_ENABLED(CONFIG_INT340X_THERMAL))
-		acpi_create_platform_device(adev, NULL);
+	/*
+	 * Do not attach INT340X devices until platform drivers are loaded.
+	 * Enumeration of INT340X ACPI device objects on the platform bus
+	 * should be done by thermal drivers.
+	 */
 	return 1;
 }
 
diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
index 095502086b41..7df3caa59b73 100644
--- a/drivers/acpi/fan_core.c
+++ b/drivers/acpi/fan_core.c
@@ -473,7 +473,7 @@ static struct platform_driver acpi_fan_driver = {
 	},
 };
 
-module_platform_driver(acpi_fan_driver);
+module_acpi_platform_driver(acpi_fan_driver);
 
 MODULE_AUTHOR("Paul Diefenbaugh");
 MODULE_DESCRIPTION("ACPI Fan Driver");
diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index 6311125c3ebd..0005961328fc 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -699,7 +699,7 @@ static struct platform_driver int3400_thermal_driver = {
 		   },
 };
 
-module_platform_driver(int3400_thermal_driver);
+module_acpi_platform_driver(int3400_thermal_driver);
 
 MODULE_DESCRIPTION("INT3400 Thermal driver");
 MODULE_AUTHOR("Zhang Rui <rui.zhang@intel.com>");
diff --git a/drivers/thermal/intel/int340x_thermal/int3401_thermal.c b/drivers/thermal/intel/int340x_thermal/int3401_thermal.c
index e0603f218d2e..d496f8b171e0 100644
--- a/drivers/thermal/intel/int340x_thermal/int3401_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3401_thermal.c
@@ -69,7 +69,7 @@ static struct platform_driver int3401_driver = {
 	},
 };
 
-module_platform_driver(int3401_driver);
+module_acpi_platform_driver(int3401_driver);
 
 MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>");
 MODULE_DESCRIPTION("Processor Thermal Reporting Device Driver");
diff --git a/drivers/thermal/intel/int340x_thermal/int3402_thermal.c b/drivers/thermal/intel/int340x_thermal/int3402_thermal.c
index 213d4535f2c1..d06c06fadce5 100644
--- a/drivers/thermal/intel/int340x_thermal/int3402_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3402_thermal.c
@@ -100,7 +100,7 @@ static struct platform_driver int3402_thermal_driver = {
 		   },
 };
 
-module_platform_driver(int3402_thermal_driver);
+module_acpi_platform_driver(int3402_thermal_driver);
 
 MODULE_DESCRIPTION("INT3402 Thermal driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
index d246c69d4872..33735515b47d 100644
--- a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
@@ -284,7 +284,7 @@ static struct platform_driver int3403_driver = {
 	},
 };
 
-module_platform_driver(int3403_driver);
+module_acpi_platform_driver(int3403_driver);
 
 MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/thermal/intel/int340x_thermal/int3406_thermal.c b/drivers/thermal/intel/int340x_thermal/int3406_thermal.c
index d05ca8bc4061..03cc026cdffb 100644
--- a/drivers/thermal/intel/int340x_thermal/int3406_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3406_thermal.c
@@ -203,7 +203,7 @@ static struct platform_driver int3406_thermal_driver = {
 		   },
 };
 
-module_platform_driver(int3406_thermal_driver);
+module_acpi_platform_driver(int3406_thermal_driver);
 
 MODULE_DESCRIPTION("INT3406 Thermal driver");
 MODULE_LICENSE("GPL v2");
-- 
2.51.0.384.g4c02a37b29-goog


