Return-Path: <linux-acpi+bounces-16206-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B5EB3C82E
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Aug 2025 07:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9253584261
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Aug 2025 05:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B8B275AE9;
	Sat, 30 Aug 2025 05:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f3ma+cL3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFA9235057
	for <linux-acpi@vger.kernel.org>; Sat, 30 Aug 2025 05:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756532068; cv=none; b=GcjcK/oc1yoBn84qTfem3gILlM5aNxfuwq99083m+0Vmpfy7UmUZCacUHeyhR2A5ElLaktBph6JTNLdrg3JvWYC6TnWT+RxXxgQ+82xy12dM/xZGHatl7mjmns2ltmnspt59pVDi5hfZOvNOkfY8D+WT0Yw3ar0VJmgFJEeNPWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756532068; c=relaxed/simple;
	bh=0MiGYP2Mz5LWty6AFyG9t1omzpzeezzzMPzyLnU2UEg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q6D8fx/i/beo/I+fQkDBxOoDzSg+jdgQl1OnpvjndapwSSSLLsE22YiXNjt4bSEo09c0qP5iOqctNxEASx635fruPqN6IIfFy8nW2iRNS1OdEVirGX6lsM8M9X2M4G9qTBI903hpgLwG6xHdww3OrN2XTjkWoGdBIYOC8CbUq0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f3ma+cL3; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-61d2ab4bb96so307969a12.1
        for <linux-acpi@vger.kernel.org>; Fri, 29 Aug 2025 22:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756532065; x=1757136865; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M9L1nkxABQJUEtCVPrNX6Jr6k7pIhnucDCQr+9k/IqI=;
        b=f3ma+cL3B8vULgulqF20NwYR6PIqcShI+0KDuQLYj2ZawI29iezpNN33ClkXRaEmRE
         BFRnqu2CHBHkWn69YANdXhijDl0mdaxJaYdX1HoBYmBGOMdTe7ChbxCXBs31F4z02bUg
         KF7QbAZ95TtmqhtUJdkY5jSQjJRaCv6j53Ur+exB9Tw/O6Gqf2Sy6b951AZOT1tjLzjK
         L6I7TduPZ4yIXFGs5Gmd7OXphmmmGRcFlbHMkqANgVFtbRYyjmYGKUIB6tlEO9gkXRxG
         J/+AXTPXZAL2B/k806e3Zs/CDyMUbEea7+VqCsmTzmRuTT5TuuUdqIJtbXB/m3/iM6Ng
         jadw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756532065; x=1757136865;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M9L1nkxABQJUEtCVPrNX6Jr6k7pIhnucDCQr+9k/IqI=;
        b=Pk+PE3zw6QxeU7Tt5XeJXp7KPDJ9Ve3vc+TkthDpczMrWqeR0T1pZ54ExpeFSFugMP
         xE+lCsYPiN5twhhEi69N86K34ttdrdOKoiKtvLgRnN0mEQbmXQSPancZX7Jrn8x9JlU8
         7UiBjI3fIS7Q7vRv3uge2yT0pj+FTlLBxgZyRyGHWmcoP22u4DbWfgVm/z8jX6FGqgtH
         jaiUTDKUFcdiPCoqgmHxKaoTP4SDLSqsvfDH2tQ1mJb6EuY1GXSXZvHNeVCYjVrDrh6u
         JXZ70K/NxOt/iKO5sqJ39KDpCXlnEOzwegRIzllelu6RVGGTDwy9OVOPMcf9u5G3prhO
         CXzA==
X-Forwarded-Encrypted: i=1; AJvYcCUXT3pCFMsjq/ZQPyqAl0pwz98GbXHHk4EkCaOPqsPGAkkiA2uYFep+ZK/koUBaPwF14crHCavhLA+k@vger.kernel.org
X-Gm-Message-State: AOJu0YyzuFmlzMgWqyh4RW3wD8SFVbzkgcErOrM23lTVZO72l/ZYJZTf
	tyvW/aAWMsvyU2BEtIoVTFffhp1c1D72jEuTJeLMlibX2j77MGH9FHsFnBGudDpVpNtTvYdmESX
	x1/m4lA==
X-Google-Smtp-Source: AGHT+IHQuR2VbVue00JTSESIg55Oze2Ld/CVh02VVLZuWezXy385eDUiq9erf15ezLaNCooMkIo9E71MadY=
X-Received: from eddp19.prod.google.com ([2002:a05:6402:46d3:b0:61c:9691:c1d4])
 (user=srosek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:5216:b0:61d:e4a:89d1
 with SMTP id 4fb4d7f45d1cf-61d26eb5d41mr764225a12.37.1756532065107; Fri, 29
 Aug 2025 22:34:25 -0700 (PDT)
Date: Sat, 30 Aug 2025 05:33:55 +0000
In-Reply-To: <20250830053404.763995-1-srosek@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250830053404.763995-1-srosek@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250830053404.763995-4-srosek@google.com>
Subject: [PATCH v1 03/12] ACPI: DPTF: Move INT3401 device IDs to header
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

The ACPI INT3401 device IDs are shared between the DPTF core
and thermal drivers, thus they are moved to the common header.

Signed-off-by: Slawomir Rosek <srosek@google.com>
---
 drivers/acpi/dptf/int340x_thermal.c                     | 2 +-
 drivers/acpi/int340x_thermal.h                          | 3 +++
 drivers/thermal/intel/int340x_thermal/int3401_thermal.c | 3 ++-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/dptf/int340x_thermal.c b/drivers/acpi/dptf/int340x_thermal.c
index 04df20ef1a2e..8fa85c866675 100644
--- a/drivers/acpi/dptf/int340x_thermal.c
+++ b/drivers/acpi/dptf/int340x_thermal.c
@@ -14,7 +14,7 @@
 
 static const struct acpi_device_id int340x_thermal_device_ids[] = {
 	ACPI_INT3400_DEVICE_IDS,
-	{"INT3401"},
+	ACPI_INT3401_DEVICE_IDS,
 	{"INT3402"},
 	{"INT3403"},
 	{"INT3404"},
diff --git a/drivers/acpi/int340x_thermal.h b/drivers/acpi/int340x_thermal.h
index a0d379492a79..3ecd6c4bf2ca 100644
--- a/drivers/acpi/int340x_thermal.h
+++ b/drivers/acpi/int340x_thermal.h
@@ -18,4 +18,7 @@
 	{"INTC10D4"},	\
 	{"INTC10FC"}
 
+#define ACPI_INT3401_DEVICE_IDS	\
+	{"INT3401"}
+
 #endif
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
-- 
2.51.0.318.gd7df087d1a-goog


