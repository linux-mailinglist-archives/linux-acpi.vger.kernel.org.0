Return-Path: <linux-acpi+bounces-17615-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FADBBE1E7
	for <lists+linux-acpi@lfdr.de>; Mon, 06 Oct 2025 15:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 648A51897EA0
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Oct 2025 13:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B71D28725B;
	Mon,  6 Oct 2025 13:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="VRaS+irm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD4B286D49
	for <linux-acpi@vger.kernel.org>; Mon,  6 Oct 2025 13:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759755648; cv=none; b=kRDySZEi2bWgTV+51eQ1UAtIChvOiTm+4S13rw0ylfYxmxy0lSdQvskSMzt2Kiyo2SLtHc3nMFNsWB8NS/O2Oqjz5XjLt6dKIkqsRAxnMf+dGVgS7BVvKjww2ingMSFnsKV16Er/DvN3N0V0QHZiThU3mvUYqLS/aGTX5q03uIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759755648; c=relaxed/simple;
	bh=Vt9wnIolF3wo/Kk0uCqHGjVh5+FV+lRIO97mPGjDUyY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XhDuf3j5hVaXpNPeSZQoqFSmNO+NITG3klXsu/i0PThALSDA1AEqw3RaWp2UoUS987lN9GEcXZeFzz71Du6Ue9T3OIBYNIWurro4B8H6JQH1mBJCOmwLRCkvltHEWLoODA/zJvzz4qmJfzAACcfkh5pl6lrVVqfess3Qe/yydb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=VRaS+irm; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e6ba26c50so28502865e9.2
        for <linux-acpi@vger.kernel.org>; Mon, 06 Oct 2025 06:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1759755645; x=1760360445; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/IT9kGD4PDZntf8OM6JZi28F9oGAqYVuiTpjsu4zy3w=;
        b=VRaS+irmFD/OBgYZPF3GlBBCRzdRjhuWXmdCe4VifuwH9c1dAsRzHY0ocgNdd5Wbg5
         M6br7926J4leGtVxYM7s7raQRFarrCMC7tiHYjD1g/60WnBlGC/16yCJNzLAWCIyIKeh
         GnNOJVoVLaV8tELIm2Kd9hp8hHtstNY7XV7tq9KfoFIQs3JKVV2Xwp4kiVDmbF8nwPgy
         dVP8cwQdgERx3OzUHaoS0w+YEcJcP9+7JYyaVEIduKGRgSgzk9pwBO/UcXayHBa462Aj
         kaEu0zEdQQOYy3vbp3bLoCYpOMmSroEF/xsraKonT6QXLp48lFEp+F4Db0BFgGEadhjE
         VxTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759755645; x=1760360445;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/IT9kGD4PDZntf8OM6JZi28F9oGAqYVuiTpjsu4zy3w=;
        b=GjWHob6u5KSrvZWJmWWNdA/SL89ljqCjdztGFoJsyEcw0keE1XD6+iEuy5AYNHjPr4
         UF8mM9+Dyva7/51A6aBdI4PuiRT14FZlwQUrBygEWYHGUyUBEbx5hxzAERiUtorNBehl
         KOOfiYtH7wMfjW/X2m/lRQxDLf0lHlqkU2hjWcg7Xp5pchUjEYBdzn55uqknCwChZ4Wb
         5uzViDP4klmjXbBjqwTQELhEzLKNbGLtoXAuBp5wmWgBkAwg7MOVZOR8kE50Ck7vgXwc
         yhhEeY8vBs8h7qqFR7pwgvWaE837C4j+jtL+LUPPMnJD0pq8YBQiCerUJjqo67lhVnXu
         Y00w==
X-Forwarded-Encrypted: i=1; AJvYcCXYRZdy10AX0Xq3x0UYGP/niwpBon5jz2zH7ETnCvHByIWrWLJy+8jydnZMpu3cf13fAmHdyztUG9Ce@vger.kernel.org
X-Gm-Message-State: AOJu0YxYb0XcpBFCw7eU7CzuRxQC834KjNrPNX1gPj2aol68yYXjF5vY
	T7w//2FVNs2TwLNqMCoC6AywsnUZzK/eFjvnchj+u0k+mgcxEVc19/sexCLsDrqwqfA=
X-Gm-Gg: ASbGncv8+YWN4cbDNJD93k1T3v69KogBOUtf43JWvDeRauVWyHqwmikmk0DjK/xuS0a
	3QRt5j2OpmmW1figLrfyGAy0qKnQXdXe6yLFzpWN4iI1TH4VHsdncBFq/A602o8AbgzWUS/LAx1
	JXSZVEiWclvsRLhAOqRo/mcbqgbYbce2/a0/+ooqTA/2eGKlw5I/IplCDJBUNy/9ndqv9MANwVK
	+mMED0Txef69ig8RAReIfdxfkqDNBTWhfXzPn9iw84yqzGtVsYroshyXIhx808yxVKt2UVh6xHR
	qlKJenGaHhdm0l/F7UDSPAuAwROaBwx6TlmAFHfSyHaEyI/zgaOo3Ya6WfOy7NI6vao95IjNCr6
	OYdT+vVUXMqt3ACRTIJcu9dh1W+E/jKyfnexxVjInBw==
X-Google-Smtp-Source: AGHT+IFcI7k/9n2YR8FC83rJGfcHlvQpg2C6nFUd24sixSFEEP5w3sJNEHKEVUf5IVa/dNhlqGBm/w==
X-Received: by 2002:a05:600c:1f0e:b0:46e:3978:ba71 with SMTP id 5b1f17b1804b1-46e7113f659mr76463845e9.21.1759755644579;
        Mon, 06 Oct 2025 06:00:44 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:ed2b:276f:1a72:aac0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e619b86e1sm249725965e9.5.2025.10.06.06.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 06:00:43 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 06 Oct 2025 15:00:21 +0200
Subject: [PATCH 6/9] reset: order includes alphabetically in reset/core.c
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251006-reset-gpios-swnodes-v1-6-6d3325b9af42@linaro.org>
References: <20251006-reset-gpios-swnodes-v1-0-6d3325b9af42@linaro.org>
In-Reply-To: <20251006-reset-gpios-swnodes-v1-0-6d3325b9af42@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1096;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=ISz7nO0lAaqHotZMBBTU6RwrDTKlASO8zsYyU+2upwQ=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBo471w6JhfRjQCA8hJP5hdnIaHCaGljK8aymehO
 +FgZAvfSbuJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaOO9cAAKCRARpy6gFHHX
 cn4OEACA7/SpyFyKEaHp7ocSnaGwo1aIkqVYudOPP9e+VFGVKMdOzVZh4A1gCWdcJxcx4tp+iij
 2xE7CCS6bIIzlavt30LlZvA/llR8ufJhIggJUBsyscrj7uqGf9BJa7OgBNOaquONMALK+0jIzxr
 4AUVqTKYWC0pLpFTGkFzkliMXLAnECba/+yZ8AJ/nWtjSEwuHtDCMCmTP5tYHX20mNTZmFUYjAg
 FhfGsxGCYXdIx0y3kT1mEajb5Ysum5XGB0fhWr3/2seZ472D1WKsew9shdHPftKZEnyVNOYi2r3
 twpdZnVKnVbcks/iGVgv1DQdl7BvLywhB1DGry3PrjzqB5aMgDqKrqMpN4ifJ9dI+zb2HKkozuH
 iT6fxCdulwFtcWQPgvtSEWwjgRRPc60QBQsCCKiEnLJ8d7yfnjSpahAO7q/18kcDAT4xdgOtqhl
 tIFGG6gPIuwTU1h18mw4RsbOuvjpZ11L7eRae1OdwhspRYsh9/IsAmocZVn0Tj2ZSxp1DSt0iE1
 FFTzqiN5URkaPVjqVdSUnfvm0AenDBpdJ710l68lyw2IVRs5m/9TfSLitc3D9XGMucWQaxo+Ltu
 eNi3jwkp4ADe0xOmDCh22OMXJ1YWptMbveatloyV8Rym0MGQQ0GXvJw0fZOasJf2LA1bcXukPWN
 cF8bcdWB9l0iDhQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

For better readability and easier maintenance order the includes
alphabetically.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/reset/core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 22f67fc77ae531c6efba3ce92cc73a2d57397762..5a696e2dbcc224a633e2b321da53b7bc699cb5f3 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -4,19 +4,20 @@
  *
  * Copyright 2013 Philipp Zabel, Pengutronix
  */
+
+#include <linux/acpi.h>
 #include <linux/atomic.h>
 #include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/export.h>
-#include <linux/kernel.h>
-#include <linux/kref.h>
 #include <linux/gpio/driver.h>
 #include <linux/gpio/machine.h>
 #include <linux/idr.h>
+#include <linux/kernel.h>
+#include <linux/kref.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/acpi.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 #include <linux/reset-controller.h>

-- 
2.48.1


