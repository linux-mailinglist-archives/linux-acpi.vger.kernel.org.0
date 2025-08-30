Return-Path: <linux-acpi+bounces-16211-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA8DB3C840
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Aug 2025 07:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC39258523C
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Aug 2025 05:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FB4296BCB;
	Sat, 30 Aug 2025 05:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U5GNnmqq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9003E284B42
	for <linux-acpi@vger.kernel.org>; Sat, 30 Aug 2025 05:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756532073; cv=none; b=MpyXFDn1rSjHP1Mtd9hp2+ZjdqFEqf4qCT28Borqty2Twko4H5tY126wCQhHY0tgMR8QfGNJAl/JNzdL1G+LKL3V3FstgJwRB02NtYANn5AJyXkgWiLE0dyLF+xFtPX2b/ELyM6V0NR9OD99Vp2Psi773SNuGr6j1vJDERgxtq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756532073; c=relaxed/simple;
	bh=GP8rmObOjrXu7epr0njRmCVcrrC81yDwAxAIKDa+2V0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KBB7speJmZmH1HDLV8roYxBkZXWfnGftqSsJKx4VozdgFlVwq1f9IgQFGaRsjZShIfuzFPpmQ/FZ+mKdM3+KxHOfVMh6dVg5zSU6x7hvE/r+0x5bAi7OTlQO5yrAVlcqxTEd/19Nn/06Izz6fpeFso9QMBNfCU/+v56oXmEFT44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U5GNnmqq; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-61cd4c2c9b6so2178278a12.0
        for <linux-acpi@vger.kernel.org>; Fri, 29 Aug 2025 22:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756532070; x=1757136870; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pj4sNFNldOuyUBqF5jIWEE+OEl1XNF0wLs68yuP/8to=;
        b=U5GNnmqqPbZQ9SpY/FKsUxZLqHOx7oT693VgVBwaXN2TUdq1Z+oLYDmrgR1aVroIiH
         XllzasLaqTmVU6l+GXdFZyCF2yzbzBng+BMdkx83IuT1suCiXGlZnSgMy19vUx9YiqNl
         7PzqCcIFb+Bf0om9sgwwXfql+Khsgaji3J58hOx6ZcmumcGdIMcPvjWsZkIRW+QfO2po
         AXlN0iw73I7JaCH0+sxhAONtzR3UPcVr9XSulRwMJDAHSGKDwN85GBclVibbATPWDGac
         rDsHKoX5eStKcPSussxoveah6Ia2kqbC+t8BHFLLI2SCUKXKOVvK9XQMGmFN4XV3mfEf
         jcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756532070; x=1757136870;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pj4sNFNldOuyUBqF5jIWEE+OEl1XNF0wLs68yuP/8to=;
        b=SkUmabfXmY+1JzB+CTw1OyGVblZbCNKfNvjCYy+qQXaMmU83iRgWbOWVCKNdHlBeC1
         kYPM5eDxZohfGKmp+pP+Cd22wn/M6DrbXPIpNBNpIi5uirY2NOLGgTEQFBJb3iZuLEek
         v9HoqJv1OrxoPvMg6q34V1BhpQ0vomM3oCOI+wmfEE13J+xCqKnGC4HxTbW4QP88yFl7
         d6bOpzvEEGPdqzRTeu7VYF/GoA1XffzobUoaWT9OQcXGyM9ncxLWHwsq/YtlJXkQBSFY
         a/QRy/jHFv764kWaUgD//6ZrJB6nFpHCd+MvrWW6upeYsoYEvhW9LMsOfL9NGQvFYeUf
         vGXA==
X-Forwarded-Encrypted: i=1; AJvYcCV6/xVWm0mkqrAkNqrvrlUyFX1U1U0bBJrALX+X/MYBYAF1ojwrxyw02nXCsdJI5twJq9occQ4IuJsG@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu1wBIUFlBhSic2FX/H4rbBJmW68J/hSJ0B4QxORMlumUt1RPw
	ZTnbcYyEmTQLNIJ0FW/+tRrqp8yVQxgmz7GhdhonRPwdB0vAB6ZPpD51eFH9AdAGmduBUJafPdu
	bovPA0w==
X-Google-Smtp-Source: AGHT+IGia/iY44u/mYMzJDTeJjBED+Djf2zRlvTl4JQglGDR/A4T1xePV+MlTv+vv61u6IleE4WX19HEins=
X-Received: from eda28.prod.google.com ([2002:a05:6402:a01c:b0:61a:8c1a:d101])
 (user=srosek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:51ca:b0:61c:78dc:9fdd
 with SMTP id 4fb4d7f45d1cf-61d26994755mr907420a12.13.1756532070128; Fri, 29
 Aug 2025 22:34:30 -0700 (PDT)
Date: Sat, 30 Aug 2025 05:34:00 +0000
In-Reply-To: <20250830053404.763995-1-srosek@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250830053404.763995-1-srosek@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250830053404.763995-9-srosek@google.com>
Subject: [PATCH v1 08/12] ACPI: DPTF: Move INT3407 device IDs to header
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

The ACPI INT3407 device IDs are shared between the DPTF core
and thermal drivers, thus they are moved to the common header.

Signed-off-by: Slawomir Rosek <srosek@google.com>
---
 drivers/acpi/dptf/dptf_power.c      | 18 ++----------------
 drivers/acpi/dptf/int340x_thermal.c | 17 +----------------
 drivers/acpi/int340x_thermal.h      | 18 ++++++++++++++++++
 3 files changed, 21 insertions(+), 32 deletions(-)

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
index 131648ddec87..43afb6141b98 100644
--- a/drivers/acpi/dptf/int340x_thermal.c
+++ b/drivers/acpi/dptf/int340x_thermal.c
@@ -19,33 +19,18 @@ static const struct acpi_device_id int340x_thermal_device_ids[] = {
 	ACPI_INT3403_DEVICE_IDS,
 	ACPI_INT3404_DEVICE_IDS,
 	ACPI_INT3406_DEVICE_IDS,
-	{"INT3407"},
+	ACPI_INT3407_DEVICE_IDS,
 	{"INT3408"},
 	{"INT3409"},
 	{"INT340A"},
 	{"INT340B"},
-	{"INT3532"},
 	{"INTC1045"},
-	{"INTC1047"},
 	{"INTC1049"},
-	{"INTC1050"},
-	{"INTC1060"},
-	{"INTC1061"},
 	{"INTC1064"},
-	{"INTC1065"},
-	{"INTC1066"},
 	{"INTC106B"},
-	{"INTC106C"},
-	{"INTC106D"},
 	{"INTC10A3"},
-	{"INTC10A4"},
-	{"INTC10A5"},
 	{"INTC10D7"},
-	{"INTC10D8"},
-	{"INTC10D9"},
 	{"INTC10FF"},
-	{"INTC1100"},
-	{"INTC1101"},
 	{"INTC1102"},
 	{""},
 };
diff --git a/drivers/acpi/int340x_thermal.h b/drivers/acpi/int340x_thermal.h
index 946f5bb23b44..8a3d2a9b218a 100644
--- a/drivers/acpi/int340x_thermal.h
+++ b/drivers/acpi/int340x_thermal.h
@@ -47,4 +47,22 @@
 #define ACPI_INT3406_DEVICE_IDS	\
 	{"INT3406"}
 
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
 #endif
-- 
2.51.0.318.gd7df087d1a-goog


