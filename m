Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEEE319427
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Feb 2021 21:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbhBKUSH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 11 Feb 2021 15:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbhBKUR6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Feb 2021 15:17:58 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16005C0613D6;
        Thu, 11 Feb 2021 12:17:18 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id f14so11985527ejc.8;
        Thu, 11 Feb 2021 12:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M42x2vdXUf7iABaSw/DfzeNpDBBVtTjcyxsHTr3EEdA=;
        b=gP3z+vu82mgwwojod39XLEzEHCxx+VfVn7qE4nukM6NzCRpOPC5bB9OktOleLpHk0L
         83KYNS5aANgXc7guOSY6YCjuS3PNuphLZbWxJRlQJq9/5g/6E8HQywlNOYXzVuYgUTER
         HFhonCFIltvZZaaEjCZ5Kjk86H8twyvPnhjCo9X2bu5nRU5SH1W69ZQVjrXILymN84qT
         UFQg2GGwRZNL5sGFFtU+7650/CQ5ZAd8rWQEPFcxX+sKK6ab9ioE/0AGzxT/++zRUIPL
         f8p0pYWCqYgZj6Ry2XGGA0z7U6mmXxPeXk6g82GSOy5UzYo0TzYms6WDhcl2Nhkb40Wd
         TUmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M42x2vdXUf7iABaSw/DfzeNpDBBVtTjcyxsHTr3EEdA=;
        b=Haiav619SRSvhjtZfO4Jps5t/tsW0X0fAGiuN46h3YMr2XDnkURAXUrf7dlLrFteSU
         ZD76QbMReXT4v+zDawwjH8Ry1jYeK4vYMXKOXLzWtUs2GvmtymVL6/S2SAM/ZYrY31G7
         NS5WxR5YNZyNKKbhXdbucaSr71ve9A9vmKKE2qPvTY1NX9KXAeU9tUcNKPuw6m6pKkXv
         4BrL5SHe1rcIjNEKbchNyZPoCMuQ2NhXcyg8QJ4R3jdigXjh1DVW5Z5l63S+dcZDo9MS
         mdmiLQIUNgwcxyjV4U5TBpyXnubQIdER74S9FKVJ+YDhXdxNa6IBQPwRIRvOecIJJJlz
         +v/Q==
X-Gm-Message-State: AOAM531Bu5wf/gQNg/737ZNLxBAhmO+E9/5bD28Ngdoi1ZEUW9E/43DF
        WeqFzgPD0DOQPhTqXI80W6Q=
X-Google-Smtp-Source: ABdhPJxMKkcvVoAPB5cskH7X5sezrbX1ms82uFpipsc8gmoxx6+z4S1fHVmnhwOtoNqX7l66zWNA5w==
X-Received: by 2002:a17:906:d8ae:: with SMTP id qc14mr10236017ejb.129.1613074636879;
        Thu, 11 Feb 2021 12:17:16 -0800 (PST)
Received: from xws.localdomain ([37.58.58.229])
        by smtp.gmail.com with ESMTPSA id a1sm4938177edj.6.2021.02.11.12.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 12:17:16 -0800 (PST)
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
Subject: [PATCH v2 1/4] ACPI: platform: Hide ACPI_PLATFORM_PROFILE option
Date:   Thu, 11 Feb 2021 21:17:00 +0100
Message-Id: <20210211201703.658240-2-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210211201703.658240-1-luzmaximilian@gmail.com>
References: <20210211201703.658240-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The ACPI_PLATFORM_PROFILE option essentially provides a library and not
really an independent module. Thus it seems to be more user-friendly to
hide this option and simply make drivers depending on it select it.

Suggested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/acpi/Kconfig         | 16 +---------------
 drivers/platform/x86/Kconfig |  4 ++--
 2 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 5ddff93e38c2..030678965159 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -327,21 +327,7 @@ config ACPI_THERMAL
 	  the module will be called thermal.
 
 config ACPI_PLATFORM_PROFILE
-	tristate "ACPI Platform Profile Driver"
-	default m
-	help
-	  This driver adds support for platform-profiles on platforms that
-	  support it.
-
-	  Platform-profiles can be used to control the platform behaviour. For
-	  example whether to operate in a lower power mode, in a higher
-	  power performance mode or between the two.
-
-	  This driver provides the sysfs interface and is used as the registration
-	  point for platform specific drivers.
-
-	  Which profiles are supported is determined on a per-platform basis and
-	  should be obtained from the platform specific driver.
+	tristate
 
 config ACPI_CUSTOM_DSDT_FILE
 	string "Custom DSDT Table file to include"
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 56353e8c792a..ad4e630e73e2 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -450,7 +450,7 @@ config IDEAPAD_LAPTOP
 	depends on BACKLIGHT_CLASS_DEVICE
 	depends on ACPI_VIDEO || ACPI_VIDEO = n
 	depends on ACPI_WMI || ACPI_WMI = n
-	depends on ACPI_PLATFORM_PROFILE
+	select ACPI_PLATFORM_PROFILE
 	select INPUT_SPARSEKMAP
 	select NEW_LEDS
 	select LEDS_CLASS
@@ -484,7 +484,7 @@ config THINKPAD_ACPI
 	depends on RFKILL || RFKILL = n
 	depends on ACPI_VIDEO || ACPI_VIDEO = n
 	depends on BACKLIGHT_CLASS_DEVICE
-	depends on ACPI_PLATFORM_PROFILE
+	select ACPI_PLATFORM_PROFILE
 	select HWMON
 	select NVRAM
 	select NEW_LEDS
-- 
2.30.0

