Return-Path: <linux-acpi+bounces-16210-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB042B3C83E
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Aug 2025 07:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C29A1B25876
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Aug 2025 05:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E8B2877FC;
	Sat, 30 Aug 2025 05:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ix6H+lzR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9E2283FF4
	for <linux-acpi@vger.kernel.org>; Sat, 30 Aug 2025 05:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756532072; cv=none; b=YxcoislJqAR7PTSA3T/S9J9CiGauoZSKzjKaD6TkjxBUkF1q0FfSbfe3co6NOtOD9IPtjRKjFL03H8G6I7ydbZpFp5cwDDElEEnj1ls+Hr+wlGHMQIzXwAwxhsxrckL5wFbQtl9DTiJX8fGZuvMAQeL8E/rfd3bq1+d0/AfUKrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756532072; c=relaxed/simple;
	bh=dQAOrGekz6zChuoQRjAATB5KSFFu0zYpdpAdPSxbqDE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lf8tFhx6IXPI5lC5BUxT9clxkGZh3NqQ2eyQKC8D2STxlXx+fiUsfNhALSzD+ol10KBCrwZZLHw2xu5OOZpS3RWBDMg0aURYJkc7m/Iny3TPD1wt3XgstpAVaunEX4xpNAlU2tdfVl6QdpRdhx55wyJJhMMcowxwIHiDNwbtDW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ix6H+lzR; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-61cd0c61472so2133404a12.3
        for <linux-acpi@vger.kernel.org>; Fri, 29 Aug 2025 22:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756532069; x=1757136869; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JGeMur4fUxttqE8wvIu4puQb64CSg/KvtrOy/q9BAQE=;
        b=ix6H+lzRG5HsLtU6T7ef7tdJttbhMRtzwcavzS1xBo9R9HTH35IX9r+A6hlvnDR51p
         yOez9QUrkZY+NeGUlvdJdUxNIbB5eS3oOVJhAd/XG4WxpR9AGxX8XIG6UgSvbNkwLr/J
         QtwhSUGtEBJBnV9PvtVq+vjAWNRII85L+A3flWwUY9YPuE9sClwyxmVyFTDAHt9tyyy1
         LHZj/DCNSMH4UG8ypsfjTuQ0EvM2UFu0ink4fqrm0abthP6BNIkF4k6G+SGk1+vd2yyC
         xYLfDhs4Eo4fjy70Vp2LdkDVgNqZxcox15Zoifc+NzHucYF5tNEl1zZMXOpvehj4YPUL
         wnfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756532069; x=1757136869;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JGeMur4fUxttqE8wvIu4puQb64CSg/KvtrOy/q9BAQE=;
        b=MfosqX2iKjBsSq6i+8KvwIWn23xJYPm226BDt47VFG7DMLSpO+TeJXmazJ8hRewNX/
         IfprKRRiR401GwtcC2gg7tLsnrxG3IMWn9Pf0OMVn+2jue7uMOnXwgr7ygkxtes1AUoU
         IHdhQF5QQClZCnVn5Ip+NwqMsViOrexaQ41MwmNfGEmDDbIu2AwYITQwB9/HRTfI3WBg
         QHs6S6janKAx9EDPVNYdIq36Ra6/hK6MKkAFZ5+wCL5SPzjVFs4Gw1ELkiZerYXtDx31
         5TsW2FHgl2SZsm+Obg2N//9Zuwuxwjh1wbQ6AzS2O4lQRvFwaMk4ReBw6yFjg9FSvkvJ
         6dsg==
X-Forwarded-Encrypted: i=1; AJvYcCU2FZBuS1GgXUiTuVrIV9Dyx/oJxJGR7Jd/SIGzL7MEbn5VDHmuRgvp1luj6Y2Dl8X68kohn36EWckg@vger.kernel.org
X-Gm-Message-State: AOJu0YwpHq8B6xe6JuZ79BdJbYoF9KdoxV8vq5DQu6DsCCg+rQbccWy2
	Rm7TAOy+sip3Z1rK433EZRdCo5ReFMaXczNyPEzaauMrg97wAsIu8Dfk6RXyB3P8BFSwesYTI+m
	aFzRnrg==
X-Google-Smtp-Source: AGHT+IHSsYU/I0Cbka4jlBah30LsSVhahauBm0YkEEAXHmzhK820kNJASrzqj4XhIscX8zopfxrYNc/A+gU=
X-Received: from edbio8.prod.google.com ([2002:a05:6402:2188:b0:617:8b41:2efd])
 (user=srosek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:35d3:b0:61d:13b:3c6d
 with SMTP id 4fb4d7f45d1cf-61d26c3339amr941002a12.24.1756532069249; Fri, 29
 Aug 2025 22:34:29 -0700 (PDT)
Date: Sat, 30 Aug 2025 05:33:59 +0000
In-Reply-To: <20250830053404.763995-1-srosek@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250830053404.763995-1-srosek@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250830053404.763995-8-srosek@google.com>
Subject: [PATCH v1 07/12] ACPI: DPTF: Move INT3406 device IDs to header
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

The ACPI INT3406 device IDs are shared between the DPTF core
and thermal drivers, thus they are moved to the common header.

Signed-off-by: Slawomir Rosek <srosek@google.com>
---
 drivers/acpi/dptf/int340x_thermal.c                     | 2 +-
 drivers/acpi/int340x_thermal.h                          | 3 +++
 drivers/thermal/intel/int340x_thermal/int3406_thermal.c | 3 ++-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/dptf/int340x_thermal.c b/drivers/acpi/dptf/int340x_thermal.c
index be2299aadcff..131648ddec87 100644
--- a/drivers/acpi/dptf/int340x_thermal.c
+++ b/drivers/acpi/dptf/int340x_thermal.c
@@ -18,7 +18,7 @@ static const struct acpi_device_id int340x_thermal_device_ids[] = {
 	ACPI_INT3402_DEVICE_IDS,
 	ACPI_INT3403_DEVICE_IDS,
 	ACPI_INT3404_DEVICE_IDS,
-	{"INT3406"},
+	ACPI_INT3406_DEVICE_IDS,
 	{"INT3407"},
 	{"INT3408"},
 	{"INT3409"},
diff --git a/drivers/acpi/int340x_thermal.h b/drivers/acpi/int340x_thermal.h
index d1ffa9c3cfb7..946f5bb23b44 100644
--- a/drivers/acpi/int340x_thermal.h
+++ b/drivers/acpi/int340x_thermal.h
@@ -44,4 +44,7 @@
 	{"INTC10D6", }, /* Fan for Panther Lake generation */ \
 	{"INTC10FE", } /* Fan for Wildcat Lake generation */
 
+#define ACPI_INT3406_DEVICE_IDS	\
+	{"INT3406"}
+
 #endif
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
2.51.0.318.gd7df087d1a-goog


