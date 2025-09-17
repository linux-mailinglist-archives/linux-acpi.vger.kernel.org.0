Return-Path: <linux-acpi+bounces-17068-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF03BB7CBBA
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Sep 2025 14:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FF6932865B
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Sep 2025 12:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D8B31A7E1;
	Wed, 17 Sep 2025 12:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iZtB4d0x"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED9930CB4E
	for <linux-acpi@vger.kernel.org>; Wed, 17 Sep 2025 12:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758110864; cv=none; b=hAouQ2nKN841KGpRgBOSA2CwUBZpNUO+I1LwjMhCwJW+ZBHRUtyKLHJa2QKIbhwBnJXKREM+kSe+aexUtfZByFYjIudl27Cb8tuX3vZJRfDuWbO78jIjmihcg6s1brcxBQFMIkZh3PoYNYXGnjnBsNpASyLO+jBhz5xYldcceeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758110864; c=relaxed/simple;
	bh=jtSocMDOLb1lorJOj5v0eJtZ0mT23dw3ZAUJoypwP80=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Wis8luBqKXeVeXPFsvtFogGKR3GqM9Nf2Rs8IQ2NDBwgUyyj1gs3tf3Q+UI3rdyS/Yyfz8RSwsYGX/OnV68E1u/11SG/XmGbNDh5NIn2QokOWvi0wVNR7ldc2GGgWsokc75oAwqIuzNUlVCvcdBrx4v9Ga4MY7ZpFPWi+I7j1kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iZtB4d0x; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-62f4f7d7501so2590681a12.0
        for <linux-acpi@vger.kernel.org>; Wed, 17 Sep 2025 05:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758110861; x=1758715661; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TnmIhuAryfUThPrOWha9IORVkxR4s5Wy0BMv2x6APvY=;
        b=iZtB4d0xv4+08+cBkCxACRFMY9y62n+j6IZfGI0ZEoLlSo1GJpja/QXQsjqrpO4+kE
         IE7TnGETo55allGLQW8JBHWfBPlwQNdxHL7gwIQSUmDVetepGKjw9whjJLY+1bqhGOR/
         fdPK4SZoCrxlwsvvPefGLBoE9b7s0djLC1hpMnxNTMBYV3Nkk7vxDOKsru7ObecrtG4V
         KMv/QSQWacTL6cTgmuFpTMdkApUDNzBX9zuE0aGAVok3FlUlNu/kgdaJo39sJguaPZoV
         pKVch1h8R1H0XX/iijPSk+H9HkC2nZw5yomBKAnrlYuttDr2tyxfNCLB5atr6eDtUh41
         3Yug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758110861; x=1758715661;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TnmIhuAryfUThPrOWha9IORVkxR4s5Wy0BMv2x6APvY=;
        b=fEH8EwhPuOBq+4QlR6MVC8MLKO3haTBWPKhIx4/muGr4DatUkcr9YJVbOfAnK4X6m9
         9KC+rw5BdeMKyU12IuBi+gZ2g5ocRdYKa87aqPM7giqb4U6GrAJq17hGEMD715RJotQh
         KhT2rfbRltvmDSGqxqOY+qb+cMQtpL9AOo+p9NM5fkdR5RG3Y7fTvE75yyuChnoKDBrO
         PFNyLvuCkAsNpWd1emzb4JtE3bFsMWHXtKJg58zPsRaZ+69UsiQjPlodY6dc3pspfEv1
         AzQcqeejRGaJxgNlGZ3bQ8GJttGOiOOIXF5TEI4qycwt9Th+JHmJoEdziqxQq8TExyAb
         8/wQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQZl4l2jH79qMXD6f5QArzC3eB3voPPvjaAbf7++6dN0cY6YSBeckpD8N/WqsP4mXP783JgB2FDZY9@vger.kernel.org
X-Gm-Message-State: AOJu0Yxakf106zMjROosNIMDyOWZ4FCpIaJvN6lG3KO5VyrmUljbBWfh
	Ti7Ycz2lEhl8GBTlMrmi6x+aPphceCzqf7q7Ff0xRZCN/kKdf01bjA76Pf8EsXuIVcARugBfsv+
	nowBnzA==
X-Google-Smtp-Source: AGHT+IE9JxQINOgMAD00LdxNBgiaiiAyNPHD+AyZlkNGA2Dk6RD20m5WkWGC1DsTYu+3JzPdr74YOVTETzw=
X-Received: from edbin5.prod.google.com ([2002:a05:6402:2085:b0:61c:9195:6148])
 (user=srosek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:84f:b0:62f:7bf4:c65e
 with SMTP id 4fb4d7f45d1cf-62f83a0cbb8mr2093077a12.2.1758110860857; Wed, 17
 Sep 2025 05:07:40 -0700 (PDT)
Date: Wed, 17 Sep 2025 12:07:16 +0000
In-Reply-To: <20250917120719.2390847-1-srosek@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250917120719.2390847-1-srosek@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250917120719.2390847-4-srosek@google.com>
Subject: [PATCH v2 3/6] ACPI: DPTF: Move PCH FIVR device IDs to header
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

The ACPI PCH FIVR device IDs are shared between the DPTF core
and PCH FIVR driver, thus they are moved to the common header.

Signed-off-by: Slawomir Rosek <srosek@google.com>
---
 drivers/acpi/dptf/dptf_pch_fivr.c   | 8 ++------
 drivers/acpi/dptf/int340x_thermal.c | 7 +------
 drivers/acpi/int340x_thermal.h      | 8 ++++++++
 3 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/dptf/dptf_pch_fivr.c b/drivers/acpi/dptf/dptf_pch_fivr.c
index 952216c67d58..cb81636a5d63 100644
--- a/drivers/acpi/dptf/dptf_pch_fivr.c
+++ b/drivers/acpi/dptf/dptf_pch_fivr.c
@@ -8,6 +8,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include "../int340x_thermal.h"
 
 struct pch_fivr_resp {
 	u64 status;
@@ -147,12 +148,7 @@ static void pch_fivr_remove(struct platform_device *pdev)
 }
 
 static const struct acpi_device_id pch_fivr_device_ids[] = {
-	{"INTC1045", 0},
-	{"INTC1049", 0},
-	{"INTC1064", 0},
-	{"INTC106B", 0},
-	{"INTC10A3", 0},
-	{"INTC10D7", 0},
+	ACPI_PCH_FIVR_DEVICE_IDS,
 	{"", 0},
 };
 MODULE_DEVICE_TABLE(acpi, pch_fivr_device_ids);
diff --git a/drivers/acpi/dptf/int340x_thermal.c b/drivers/acpi/dptf/int340x_thermal.c
index 43afb6141b98..26522ddfcbaa 100644
--- a/drivers/acpi/dptf/int340x_thermal.c
+++ b/drivers/acpi/dptf/int340x_thermal.c
@@ -20,16 +20,11 @@ static const struct acpi_device_id int340x_thermal_device_ids[] = {
 	ACPI_INT3404_DEVICE_IDS,
 	ACPI_INT3406_DEVICE_IDS,
 	ACPI_INT3407_DEVICE_IDS,
+	ACPI_PCH_FIVR_DEVICE_IDS,
 	{"INT3408"},
 	{"INT3409"},
 	{"INT340A"},
 	{"INT340B"},
-	{"INTC1045"},
-	{"INTC1049"},
-	{"INTC1064"},
-	{"INTC106B"},
-	{"INTC10A3"},
-	{"INTC10D7"},
 	{"INTC10FF"},
 	{"INTC1102"},
 	{""},
diff --git a/drivers/acpi/int340x_thermal.h b/drivers/acpi/int340x_thermal.h
index 854e4d3bb739..dee53c444a32 100644
--- a/drivers/acpi/int340x_thermal.h
+++ b/drivers/acpi/int340x_thermal.h
@@ -65,4 +65,12 @@
 	{"INTC1100"},	\
 	{"INTC1101"}
 
+#define ACPI_PCH_FIVR_DEVICE_IDS	\
+	{"INTC1045"},	\
+	{"INTC1049"},	\
+	{"INTC1064"},	\
+	{"INTC106B"},	\
+	{"INTC10A3"},	\
+	{"INTC10D7"}
+
 #endif
-- 
2.51.0.384.g4c02a37b29-goog


