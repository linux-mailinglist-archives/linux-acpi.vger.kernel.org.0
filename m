Return-Path: <linux-acpi+bounces-10295-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0899FBEEE
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Dec 2024 15:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B0631884919
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Dec 2024 14:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0721D86C6;
	Tue, 24 Dec 2024 14:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWR/qUTu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B340E1CCED2;
	Tue, 24 Dec 2024 14:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735048971; cv=none; b=Q/ibSypMPBRpB0Yju+1rsHsjgH3AxLN13B7Te0k9XBC7JWbnSLIYsmpRfd2ganYDvcJvQOMtkWuMqFUJd8C0a1HIApP7D8u22bYvD+nLiC8WqqiOdsWXOCnJQ7vtK7XxZ4ECtL9C4Ks3I6wlmdr1uwkcDvR1rx7vYa2jh0zbErQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735048971; c=relaxed/simple;
	bh=tzVg25RDibZ0h2wOq5+IoBh873Kpk7iGS9SUDQe1Sfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TKevpfvO62M9QekXIWcpzJbzTGi3fPofABw421tT88b39qob2GHhBkFk4zh1cIKeseU17tD2t7U2EbNslwFsLF/ZbWVr3XU7btD2BgYs08idzaPNnFmMdu4wLEYCbrygu/5pGYLa2wQl/EYkZHgQCYh0tIgNUzelc0J4tGg+l+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hWR/qUTu; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e3983426f80so4764799276.1;
        Tue, 24 Dec 2024 06:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735048968; x=1735653768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rv0BDzn3CZSKo6xwZQLoVWwerOwVOOmdArHSd9iduis=;
        b=hWR/qUTu9PmLekfK0mvzJ4C4Zk73r2Mwj6+hgk4B2kuG5dx/sGUc95ABDY3Y1XMzdr
         MXLcwlH1tD5auYfUYOWxY2BgBP1I1uXctPNNHdHImBuZE2LUjZF4VFglCWaHQWcUbNw1
         EgD2tzSF4EPXPBttgfvo20PRzCj7O0vcVXpZK+369LO5gynOTh3K4KjoDd3/cmZzLNaR
         bbMR948TXQCZ0JZ6+bf0863PBChcdnZzTGtQyU12l/xCeLNEf/zbEkXC/XRtfrZOL95c
         nXzbTtFBvyAf3V+mhUER2MmaGGJa74QXXsPoMo+I6svdntfpYEcwc9xIx1MUp9DDcmB7
         jXCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735048968; x=1735653768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rv0BDzn3CZSKo6xwZQLoVWwerOwVOOmdArHSd9iduis=;
        b=KChwmVLXDQUnjBhN422OvOnAi6NC/zY8tCIqb+i5Ko2AHeWcje9UGun/SODC5Mg4Et
         /vt6phyOaMJ50oVwFEGqaX2QS/yfox3LTmBolqUXSZcNIpV9efB+a0C+eNh6sHCB0aoD
         RgIARIVOwL4mTasAwOSfBgjV6KG5RmzyXBAbh2TlW7Ya33S9info/tSmka/GhcoS+WY0
         Yb4DnxLvXB/jubldJsholCnrpkmAIXAO6PE8ya3vS6wwb7MWKJRNiWkhhDQIgiTSnb9F
         7X102uCQttJB9O6n87R0AYjHiZniBzTrMCrEtoZ2vgoQGOBJyORaaEMz8xj0+Fwy4g4k
         3H9g==
X-Forwarded-Encrypted: i=1; AJvYcCWa2nPg1aMQoxAxE9uVBqUUhbcqfUDJYnva5g7bw0HfeEK3xHZ6SL6GFRr0LbDLTH8UTk9nhB/sl4W0@vger.kernel.org, AJvYcCWj7C3Py67a88j2deRpetp0/MQvZzq8+sMbZGzgMi6laDypqLCAbxT1ggpTFf+u/XVqoOPTSIO+d35XlsjI@vger.kernel.org
X-Gm-Message-State: AOJu0YxAdmMDkic/t54RFG0gcx6RpHQjk0ZDNhfIm0/r2qjsARbGXGr+
	7J7q7yVb9CQ9lb6ameo/6ZoxAepuHxhvyOkg/vcfa3cC2ylWonmsVPD4XQ==
X-Gm-Gg: ASbGncv/qAoQsg5Inn0smrDC95z+RCrMFjL21ZT1bRxUfqLHcOlR283dSJg8D7KNzuM
	enRHgdxKfz1ndqrA5etDIO81ImYzvtxaacnBseJBpG28fwR/1BLT09i7UDyGsu/w4CUtCiSq7Fc
	hDHKHexkTq/Fa/b8TvEVET4rxzg0gYML+3OtIstuvDaeUSxbdKyXzTpCW5zDGcIGiMUdwwCIiIp
	/Foc4X3QMLXecI999jlvvgzM+CaSIrlAi82qbc+6ipvvDuBsw84Ug/jvYo7I+06
X-Google-Smtp-Source: AGHT+IFov0+kxCPQtgOBgzfblQKgpZIZJy/XfD1s2N23DEvLfTumzDzlRhLxLcZ3C4AY8bc1WL5JEA==
X-Received: by 2002:a05:6902:2603:b0:e4c:35c4:cf03 with SMTP id 3f1490d57ef6-e538c223610mr11549701276.18.1735048968104;
        Tue, 24 Dec 2024 06:02:48 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e537cc79049sm2976051276.33.2024.12.24.06.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2024 06:02:47 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: W_Armin@gmx.de,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mario.limonciello@amd.com,
	mpearson-lenovo@squebb.ca,
	rafael@kernel.org,
	soyer@irl.hu,
	Kurt Borja <kuurtb@gmail.com>
Subject: [PATCH v2 2/2] alienware-wmi: Use devm_platform_profile_register()
Date: Tue, 24 Dec 2024 09:01:33 -0500
Message-ID: <20241224140131.30362-5-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241224140131.30362-2-kuurtb@gmail.com>
References: <20241224140131.30362-2-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace platform_profile_register() with it's device managed version.
Drop remove_thermal_profile() because it's no longer needed.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index e95d22c7b60c..7b3ee2d6a23d 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -1159,13 +1159,7 @@ static int create_thermal_profile(struct platform_device *platform_device)
 	pp_handler.name = "alienware-wmi";
 	pp_handler.dev = &platform_device->dev;
 
-	return platform_profile_register(&pp_handler);
-}
-
-static void remove_thermal_profile(void)
-{
-	if (quirks->thermal)
-		platform_profile_remove(&pp_handler);
+	return devm_platform_profile_register(&pp_handler);
 }
 
 static int __init alienware_wmi_init(void)
@@ -1239,7 +1233,6 @@ static int __init alienware_wmi_init(void)
 
 fail_prep_zones:
 	alienware_zone_exit(platform_device);
-	remove_thermal_profile();
 fail_prep_thermal_profile:
 fail_prep_deepsleep:
 fail_prep_amplifier:
@@ -1260,7 +1253,6 @@ static void __exit alienware_wmi_exit(void)
 	if (platform_device) {
 		alienware_zone_exit(platform_device);
 		remove_hdmi(platform_device);
-		remove_thermal_profile();
 		platform_device_unregister(platform_device);
 		platform_driver_unregister(&platform_driver);
 	}
-- 
2.47.1


