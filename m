Return-Path: <linux-acpi+bounces-10709-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6114AA12FDA
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 01:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B15A3A6247
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 00:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F3E1547E9;
	Thu, 16 Jan 2025 00:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JC3X7LDj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199E014B959;
	Thu, 16 Jan 2025 00:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736987305; cv=none; b=OlgXDAO5/BXMsccpN7ptJ8bYRqKQGNEKBu5bgA45VS3YKmDiZ8eTmedLlH7oMv1kXG3I8mfdIveSHe3X+yo97eALlXQBWOnZNJUwogwi9TAuy2JRCUJSf2aUm+zQGOR0tApqk/YxPyj7hu0pwj+KT+0Mmouci94k5NquV1TngEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736987305; c=relaxed/simple;
	bh=r3+zajkWnSc6nIQzFdNZHPcXlS4SrX9xPynZuolMFTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qeX/bBuGp8NqyuhQRjVz21kjIjr5pTWAh6o9VQoF11RmlnE54YxIJhEkD5BlA9DR/c2g8b8YpqbO0C4zhr/LR0gSg/cNtLPi556Cw+zeauLJiD/aLV2l2/lgcIt6KaRt3dnhFXG4smLYe2hcOrFw5e0BUTVbMl1mbmHaXtVGMu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JC3X7LDj; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e398484b60bso625272276.1;
        Wed, 15 Jan 2025 16:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736987302; x=1737592102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Tg50cvLi+S3OFbqsFm+fhLnAbqIbAXDy5oAujEJcOY=;
        b=JC3X7LDjtvvatR4ACxDrPEfzr96WRW5n6rlvAss3+IAPtKs9s2h5bk8lK//sBpuinl
         kk7/j5kPqAk5ba1w46h9eZKU4rr9/eQmS38uK9fJ0NrUbN6RhyMIEQsqAiKFU2OCRH4H
         rixCoVXxpkQf6cNlcd3oodtONH84yo08+4dCaxFy3BnFB590+PdGi9nIx3v5sUdQStSm
         7xhDG/bxzVri9uLxTyk5wulsfxT0y8tZzWiUK9VDMlMgQrq9a0/d7HClrjyi1bb4bUxl
         HJxQF7V5I11l2VsdZB926Z0bELAJkD0KXYZ3IA9bqIZajaf+CiTqfFVh1bMP9DOpYt0U
         zdkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736987302; x=1737592102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Tg50cvLi+S3OFbqsFm+fhLnAbqIbAXDy5oAujEJcOY=;
        b=ThlyFPNO9dUACsjYOCola5K/bPqksLZARW2/CityZBq9vTjVV1gq8Fzx/nT8c5E+hj
         dpLPOllTohsC5ZHR0MA7uiUiATIeT1Ed68y1glSjAUkGD6U4xfi05EO5aQ9kqWG+Rw0j
         PEpKFR5Y8Tej/a0B09NliWkhsID0CxU5KD2ZsOitaMGdwNeD7jLFcZkAYCQh4eQPxSuZ
         ynRX2haZlUeHZN1HuHMx4sUHt8i0kYINJyjpOjpkCGFlux/vghXworozj6mI6tgXWvrS
         Sm+M2y+uxgf0diwTyXff/J9M5QnHLnSVh9TRTEq+14ymg2a81Pq3EXCW5f9uuvI5aIWi
         Q0rw==
X-Forwarded-Encrypted: i=1; AJvYcCV65QiG9a4zZ/nEFZpsFj2mFcs8ZKYApq/+JzTZ4KG7cDZ6ZKrGga24iwxjZdfguAOyzCm1FSZt+7bgxtXl@vger.kernel.org, AJvYcCXotFBVU+mJcQIMDp011vhyxMbILfTmSPv4dkldkeo2IL2b2RVLn0Ibldh0Js1gewP/z2LhyMoWYqHE@vger.kernel.org
X-Gm-Message-State: AOJu0YxKMUM8vQbB0lc77skTtwbyeZQcJcHdWeyIWGEVS78eKtFMZg/V
	Zd2Q41Oj/aRGbb5vkLjXAii1UR3p1PyJMe/2+xmqHCFpTjw6CnrloAf84w==
X-Gm-Gg: ASbGncvKGOVFyUW2ofId6TBxikEK4UiScIvfOJdLNDg77NuVAC8t/hxdIUuIU5gH8Wm
	KheFaEDcSOya6eY+g4ihxqmM2VsCMDNTMD3Wvd+cnrd7WgkQYJFdxq84Y2RKw0gaVp9UCOccDX+
	BwXuoVTajd0pJ8byGp8BKi0PFJdTJkdwoFt2Gcz+tVUgy0aUWGyq7F8ziDlcayD9IDpCNPF4YS5
	tKm0xiX2/99lOZl6ZLMZ4sn1k6YwMcu4Jygdl99iMiCin1WNAKSeac1+IYKaxV6
X-Google-Smtp-Source: AGHT+IG5HXgLTkUXHqgqIOlEtoVxGPc2XjuHVBGEOGtd/oBYeVu+NHxK5MnrvlL6lImWo2zfcksX1g==
X-Received: by 2002:a05:690c:9b0c:b0:6ef:4a57:fc89 with SMTP id 00721157ae682-6f53125e6e5mr262496917b3.19.1736987302571;
        Wed, 15 Jan 2025 16:28:22 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f546c46bdesm27229077b3.50.2025.01.15.16.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 16:28:22 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	"Len Brown" <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Mario Limonciello" <mario.limonciello@amd.com>,
	"Armin Wolf" <W_Armin@gmx.de>,
	"Joshua Grisham" <josh@joshuagrisham.com>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Hans de Goede" <hdegoede@redhat.com>,
	"Kurt Borja" <kuurtb@gmail.com>,
	"Maximilian Luz" <luzmaximilian@gmail.com>,
	"Lee, Chun-Yi" <jlee@suse.com>,
	"Shyam Sundar S K" <Shyam-sundar.S-k@amd.com>,
	"Corentin Chary" <corentin.chary@gmail.com>,
	"Luke D. Jones" <luke@ljones.dev>,
	"Lyndon Sanche" <lsanche@lyndeno.ca>,
	"Ike Panhc" <ike.pan@canonical.com>,
	"Henrique de Moraes Holschuh" <hmh@hmh.eng.br>,
	"Mark Pearson" <mpearson-lenovo@squebb.ca>,
	"Alexis Belmonte" <alexbelm48@gmail.com>,
	"Ai Chao" <aichao@kylinos.cn>,
	"Gergo Koteles" <soyer@irl.hu>,
	Dell.Client.Kernel@dell.com,
	ibm-acpi-devel@lists.sourceforge.net
Subject: [PATCH v4 12/19] platform/x86: hp-wmi: Use devm_platform_profile_register()
Date: Wed, 15 Jan 2025 19:27:14 -0500
Message-ID: <20250116002721.75592-13-kuurtb@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250116002721.75592-1-kuurtb@gmail.com>
References: <20250116002721.75592-1-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace platform_profile_register() with it's device managed version.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/hp/hp-wmi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 75bcd8460e7c..1304dfc65aab 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -1652,7 +1652,7 @@ static int thermal_profile_setup(struct platform_device *device)
 	platform_profile_handler.name = "hp-wmi";
 	platform_profile_handler.dev = &device->dev;
 
-	err = platform_profile_register(&platform_profile_handler, NULL);
+	err = devm_platform_profile_register(&platform_profile_handler, NULL);
 	if (err)
 		return err;
 
@@ -1714,9 +1714,6 @@ static void __exit hp_wmi_bios_remove(struct platform_device *device)
 		rfkill_unregister(wwan_rfkill);
 		rfkill_destroy(wwan_rfkill);
 	}
-
-	if (platform_profile_support)
-		platform_profile_remove(&platform_profile_handler);
 }
 
 static int hp_wmi_resume_handler(struct device *device)
-- 
2.48.1


