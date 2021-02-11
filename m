Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4076031942B
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Feb 2021 21:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhBKUSQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 11 Feb 2021 15:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbhBKUSB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Feb 2021 15:18:01 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF1EC061788;
        Thu, 11 Feb 2021 12:17:20 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id l25so11990124eja.9;
        Thu, 11 Feb 2021 12:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fc2OT1cScZA8JM0hMwx8BqoVclia9O93ocGUXBkaHO4=;
        b=GB24+9GxyTapQ+S8/IwOLYWbhKUorY5fIWYrXe5XjpzifNAoqyWLEjiff2C4QUOqmx
         XGM7EaRjPO/EEGu2JReQKNxMlM3tpXlc4kiBNVZXCi+lpj/GPckg55k/dCXKsKw8ax2u
         eE57s3vvP0jMaNvmZpZhRrkXZIL3yXrdYWBySU4Erv47VOHLqA6YmSOQhpoVyOiDQUq1
         farPUsKLLXj1g2lT2UnYNWGS8MTiyWNAyrT/vrrd9Piojbw/d5YfPM2M2+rbNYg7fTZ4
         724cy03ExmVaMXobbR7R5i0mJtBo9r0CVZBOkANjRlVePDEUb/f9bpxoDpFCn0EJ9xUx
         iT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fc2OT1cScZA8JM0hMwx8BqoVclia9O93ocGUXBkaHO4=;
        b=fK1UAoN/uXP31EulsTGWP5mPcU8HQD46x1xqp+FrNTOyxUiiL+pReqmGLG9sLLj58L
         e7M24e7pDlYZas0HfzqQ+PkbADVphr5my30Fg0GIWN1f/pSKm+cy3LqrFz2PSHGimo9G
         qYk4ogz3kTzs5QLfSAPDc5JaI90bA1krUMyvgbCF6YAxh6kl33j3wJMvcfwX+x//0goe
         A6uY9BOT2vE97AvlsKbbDU+KQio7aCFXYB9Qb4Jz582xd1bHHCiCnBn/4IijiTPPGYyG
         tG2q+GgsPtiTUrrD55QXrRvWhcAa466Ac4F9/KBoEZ/4rwsuIKz0qdycOv1ILtEvtlUa
         n5jA==
X-Gm-Message-State: AOAM5317pBZwFs1OVDsmUK4o04//6wm0p5E+TubWJ+wB6VyWPsrSncdp
        pHPZMnNggP6uwz1I083lcvM=
X-Google-Smtp-Source: ABdhPJwZs8PgysLkav93ywnokc6CaMzdG3wvxq/xM12TzDebxYgGhWQez4KsLxFjWDrfgdTU9X7NwQ==
X-Received: by 2002:a17:906:149a:: with SMTP id x26mr10102837ejc.486.1613074639308;
        Thu, 11 Feb 2021 12:17:19 -0800 (PST)
Received: from xws.localdomain ([37.58.58.229])
        by smtp.gmail.com with ESMTPSA id a1sm4938177edj.6.2021.02.11.12.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 12:17:18 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Mark Pearson <markpearson@lenovo.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] ACPI: platform: Add balanced-performance platform profile
Date:   Thu, 11 Feb 2021 21:17:02 +0100
Message-Id: <20210211201703.658240-4-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210211201703.658240-1-luzmaximilian@gmail.com>
References: <20210211201703.658240-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Some devices, including most Microsoft Surface devices, have a platform
profile somewhere inbetween balanced and performance. More specifically,
adding this profile allows the following mapping on Surface devices:

  Vendor Name           Platform Profile
  ------------------------------------------
  Battery Saver         low-power
  Recommended           balanced
  Better Performance    balanced-performance
  Best Performance      performance

Suggested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 .../ABI/testing/sysfs-platform_profile         | 18 +++++++++++-------
 drivers/acpi/platform_profile.c                |  1 +
 include/linux/platform_profile.h               |  1 +
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-platform_profile b/Documentation/ABI/testing/sysfs-platform_profile
index 9d6b89b66cca..dae9c8941905 100644
--- a/Documentation/ABI/testing/sysfs-platform_profile
+++ b/Documentation/ABI/testing/sysfs-platform_profile
@@ -5,13 +5,17 @@ Description:	This file contains a space-separated list of profiles supported for
 
 		Drivers must use the following standard profile-names:
 
-		============	============================================
-		low-power	Low power consumption
-		cool		Cooler operation
-		quiet		Quieter operation
-		balanced	Balance between low power consumption and performance
-		performance	High performance operation
-		============	============================================
+		====================	========================================
+		low-power		Low power consumption
+		cool			Cooler operation
+		quiet			Quieter operation
+		balanced		Balance between low power consumption
+					and performance
+		balanced-performance	Balance between performance and low
+					power consumption with a slight bias
+					towards performance
+		performance		High performance operation
+		====================	========================================
 
 		Userspace may expect drivers to offer more than one of these
 		standard profile names.
diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 4a59c5993bde..dd2fbf38e414 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -17,6 +17,7 @@ static const char * const profile_names[] = {
 	[PLATFORM_PROFILE_COOL] = "cool",
 	[PLATFORM_PROFILE_QUIET] = "quiet",
 	[PLATFORM_PROFILE_BALANCED] = "balanced",
+	[PLATFORM_PROFILE_BALANCED_PERFORMANCE] = "balanced-performance",
 	[PLATFORM_PROFILE_PERFORMANCE] = "performance",
 };
 static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index b4794027e759..a6329003aee7 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -21,6 +21,7 @@ enum platform_profile_option {
 	PLATFORM_PROFILE_COOL,
 	PLATFORM_PROFILE_QUIET,
 	PLATFORM_PROFILE_BALANCED,
+	PLATFORM_PROFILE_BALANCED_PERFORMANCE,
 	PLATFORM_PROFILE_PERFORMANCE,
 	PLATFORM_PROFILE_LAST, /*must always be last */
 };
-- 
2.30.0

