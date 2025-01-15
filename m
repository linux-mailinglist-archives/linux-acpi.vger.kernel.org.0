Return-Path: <linux-acpi+bounces-10655-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB26A11A93
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 08:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 930751676BF
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 07:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B05B2361DD;
	Wed, 15 Jan 2025 07:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hfe8zwNb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AD522FE0C;
	Wed, 15 Jan 2025 07:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736925129; cv=none; b=IcTwEv7NmlZMIDDtG0TMIZe35VNyWU/fQhHZHy7nSyUWj1UleL04efulYILfKNjYM32Jjb2oVY9MeuOw2eJYlzEh/OwvzRPk76eKyqpBX4m7r60LUhu2VRDRTx1Hi1epmnrzikIcVTZbXSgnZfH7IiSUMeiOjI+XLL9yXOC5ymM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736925129; c=relaxed/simple;
	bh=o+cWbQeJi7S+1Jp2xBu0B5+ONovcyCIwNoIbPhsR5Y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V81kNi4asx6DabTj237wEfmBpn/qwL9Qi8+fbZIKfecbJL498AMjpaZVRWDif6w9sD3bKsyg+WmLiNo+CDMi2caFeuXLBl8NWr45L55WSmcoYNJeiDjZmBp3MrcvFFTJ2JrvZ6B9BMHoNxhA8a4SvP81UKxihQQSJNlWor/25uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hfe8zwNb; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5162571e761so2182476e0c.2;
        Tue, 14 Jan 2025 23:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736925125; x=1737529925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9cSvCCgizWFu2j5Pl22QTuGZqF7L3nJpbDZ64GXsSdA=;
        b=Hfe8zwNbnKrwxV77H1khuUUQT+gr6J0yATuvOPbJqKsziHMBciQ+JS+RIjihS+xWJo
         7q03ecNXcNy3SVZurMBaEc4b4o6oud0O7fLD0P9kSazTzLxN1JMlEEeD5/1RFpgSmLTf
         gmDO4C4DuRqoq6lOjhyrKXcopag4b/ufuW7TJucEjZ/IEbswF0d0uAuyhh0y8UeP3lbL
         ei5YwOqRaMMwkmqU56AggYMZX0wXGao0LSPqxQrsykeydbPJII3UR6vMtr1rBk+jfW2I
         HnYbH54GO8J4IbpyRICmzQbDKt5XPusHoy+dB5pNwq3iGAolmOeCqGlmMOiaBQJdza/5
         d2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736925125; x=1737529925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9cSvCCgizWFu2j5Pl22QTuGZqF7L3nJpbDZ64GXsSdA=;
        b=TmEy5Y4T+yF7DY4VVOqIxkDORTUZBvivfAWx8FMtxP6NdgHdxaxntF5cvkdRTs/Rnp
         obl92MSr+2EZHbiRd3oY9zcaupRU2E5CaWCIAwaweQ6+4EvVi2N2OVpL07g8BN7kYpft
         2om8uW3bKqdmtCwID3OBeicEWKdgh6KH0irrrrEx0+iHZ0tTET8mAOlWNBnEFK7cfFJP
         zSSmw5uPTe0xT/H65bmL6m6n+BqFlACMJTLhaWGkYGN4rGGyqzwcoeiCi7QdtpYooZrP
         jUK5FjslAI90y3465uzZPCZe8hhkfz/fgfVyable59kLUP2CCBrxAD9Lc17o0662u9sB
         uIkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVb2l9sCOFc5njuc1JFk4GLaTaGhnjoO8CLab0lt+dh/BQGGkcOMgH3fBeqNq8uhwxShLFTHuR/1dMq@vger.kernel.org, AJvYcCWCRyTk8qdQSsuWZxk0AHmMRxXS4G+JmTVblFwTu7ccPmRim8cF0UottWrBbnHnobLqRz8A1mgN1/dxKniY@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo5WIuCy1tRhxFDG9OxYuKaZAlQmex4xlXJWda3rg/pclOnsCx
	t7vzqgy1RHpdXcJYQjipQE9cnCVlprNTp3AaDwvTPT0jb/pUKRTuulYV0A==
X-Gm-Gg: ASbGnctjE+Zw22/q65UsRwF+DfvYE80V6t39Po56QlWJBd4WExjZgy6/DWLMBn/o7BJ
	P5vFUuwfUZcI+zSw50Nk/ly5qnJGcm9DxqH6hVru3cgBoqmG7W9SRpbi4shnezGd/2hujSzim4a
	9sIM8d2G1rd8hA2QxPwe5b69zcGQCYyFrRL0AL4pVmiNbHInM05Fp0P2hRuZMoT8xlI+fElS5Fj
	M3gbt28l+eX0iOVNaoRIThb1/Ot76j3Ff1QUJaSI5GQ2Y+ZPLEaN/jsOz8wt2O1
X-Google-Smtp-Source: AGHT+IFPJdoYHZgWswAnj6/xvBCwmSr+QkDgzOX/NdU25coHV57K/dShxqfS5/ad7fuBrcXF18+y9A==
X-Received: by 2002:a05:6102:26c8:b0:4af:bb06:62d with SMTP id ada2fe7eead31-4b3d0d9fd51mr27697615137.11.1736925124906;
        Tue, 14 Jan 2025 23:12:04 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b608f033ffsm5084366137.6.2025.01.14.23.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 23:12:04 -0800 (PST)
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
Subject: [PATCH v3 07/19] platform/x86: acer-wmi: Use devm_platform_profile_register()
Date: Wed, 15 Jan 2025 02:10:10 -0500
Message-ID: <20250115071022.4815-8-kuurtb@gmail.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250115071022.4815-1-kuurtb@gmail.com>
References: <20250115071022.4815-1-kuurtb@gmail.com>
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
 drivers/platform/x86/acer-wmi.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 6953e36dbfde..39ec236b7cdb 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -1944,7 +1944,7 @@ static int acer_platform_profile_setup(struct platform_device *device)
 		platform_profile_handler.ops =
 			&acer_predator_v4_platform_profile_ops;
 
-		err = platform_profile_register(&platform_profile_handler, NULL);
+		err = devm_platform_profile_register(&platform_profile_handler, NULL);
 		if (err)
 			return err;
 
@@ -2591,8 +2591,6 @@ static int acer_platform_probe(struct platform_device *device)
 	return 0;
 
 error_hwmon:
-	if (platform_profile_support)
-		platform_profile_remove(&platform_profile_handler);
 error_platform_profile:
 	acer_rfkill_exit();
 error_rfkill:
@@ -2613,9 +2611,6 @@ static void acer_platform_remove(struct platform_device *device)
 		acer_backlight_exit();
 
 	acer_rfkill_exit();
-
-	if (platform_profile_support)
-		platform_profile_remove(&platform_profile_handler);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.48.0


