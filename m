Return-Path: <linux-acpi+bounces-16215-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E150AB3C853
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Aug 2025 07:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 948D23BDC2D
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Aug 2025 05:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D582D249E;
	Sat, 30 Aug 2025 05:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K6fM86XA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155AA2C21D9
	for <linux-acpi@vger.kernel.org>; Sat, 30 Aug 2025 05:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756532079; cv=none; b=CBJJn+vLCyaO9sxpEs882Pi9nWE6rQfoEJlZ+Qefa4rNQfSIwaM9M9ywEb638p0R2K+f2ouybU3sIVxhKfLl+npP8SaSIsEUWh3Rn0oIunJM/JMbutjFDItxbroATS/d+tOwA0SZ1mqcAQEZRAHolUMnf7GhZPW8SpBCKsqYxHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756532079; c=relaxed/simple;
	bh=tE7h+6Ck152b0ta6W45P08/NelqWtKQJ49igH6GfCXQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W7+wXsbLkWhywhnMgOazu7rkOAbWtbA7vUKWZnMiTrqy7KqKH2B6Tazis3paFqPvrTiNlCUr+P+Z6ssuh6dauq8EYgHD/gTBO0siGS+9EeGV4jPxOIkmhUwZvHvoVMeKD80ZpxXDM16l9MYn/MAsCFo+5NOwiBs+5rJ3Fc72gUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K6fM86XA; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-61c6d735f25so2434411a12.0
        for <linux-acpi@vger.kernel.org>; Fri, 29 Aug 2025 22:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756532075; x=1757136875; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cJWspDoxo9x/XP1u8QC/55JEIhUnUfdlnp+4goH1sDY=;
        b=K6fM86XADRgPDnB7e+oGgTbZeb2ocq9QImAc4W5TqDl2Fiq7098W+W+EGvU1g1ZDXx
         2J8ACBp/4E/anE4Rj9orbHGs2jVAMLqrmTqI0L764HJbVfGZvbRP3PqnD8UXo4OPkXfs
         E5W4sWbb9XmbZ6B1GLjtfwWJ0A6wpOGRHIlkvhLCO5aa8DU81nJH/8ykJX8ACJb/LoSk
         cvuFNLaqQURr1pJWoqMPwP/1oLCTJ37geIu+bj9fM3drBEvTYE4mlBT8lMEFk/7QZdkE
         jLn4gu0sWmyEvBz02L1/9+i08+3s8O+GJn1On2/EzWlQeUGwU7Zq6yvFgnq4bqkp1iRn
         W+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756532075; x=1757136875;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cJWspDoxo9x/XP1u8QC/55JEIhUnUfdlnp+4goH1sDY=;
        b=IH+dl1XrCVJ9gNVG7JVQpe6B4Kb1FCRUSievXi8ZV7RC800vwQ5J3PVB3rZ4Z7qy3r
         No6x7FYxN+SPLPhZFOaw9eyA927rTFhUfW5w4tGw9zvLbj0WzkPJtfAPz7jR57Pdcz2Z
         +LPp2arOgN42uCLryA904MKH55UElDJ00kkXpDB6aPneTK69UZglwjrkctAe2poiiI/R
         hGH0kDym36XfMdUAZ1mxezY8eez2narsbiVZzjln5yC+rP3oLyWRqj8OdmvJlyS4sw68
         Q32m838vrEJBNBq3Uf3F4XMwQC6FiIIyrHshdrTmqJw1RRgtC0YaFSLyAfZsCQ0+5f8f
         DO2g==
X-Forwarded-Encrypted: i=1; AJvYcCV/STTVpRzhIZh70wOgrb8sKfPiYH9nOIhZFLvbvGM1SRUZ3MncXWMo+YWm9qcgyw9krBVJhgLguBB9@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqewm3FoSjD1yJzvLMim4iOegSOriO2Xqr/qOGM37SWE6qpKdE
	GZ34P5MMXgDQ2PUNQYqCqO1vrwovRgVcplKrHHxk/OmQ9mvLkkp83v4UcQhFknhRZ7fcJ4FkMt2
	6bUb40A==
X-Google-Smtp-Source: AGHT+IHhCZBEr1wBakiPy5j+PXcVghhZSHJqFZDur7EAy9lfhOLMwAHt/cfjF1VDIjnk0M9/jmOMuZbLh+Q=
X-Received: from edf8.prod.google.com ([2002:a05:6402:21c8:b0:612:9323:1cb1])
 (user=srosek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:34c1:b0:61c:d457:e559
 with SMTP id 4fb4d7f45d1cf-61d26c3fb81mr936353a12.23.1756532075255; Fri, 29
 Aug 2025 22:34:35 -0700 (PDT)
Date: Sat, 30 Aug 2025 05:34:04 +0000
In-Reply-To: <20250830053404.763995-1-srosek@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250830053404.763995-1-srosek@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250830053404.763995-13-srosek@google.com>
Subject: [PATCH v1 12/12] ACPI: DPTF: Move INT340X enumeration to modules
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
2.51.0.318.gd7df087d1a-goog


