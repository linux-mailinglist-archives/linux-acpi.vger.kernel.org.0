Return-Path: <linux-acpi+bounces-10615-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B13A10B30
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 16:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 470F7188A3F6
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 15:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283A31FBEB8;
	Tue, 14 Jan 2025 15:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWUECB8C"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6931FBE80;
	Tue, 14 Jan 2025 15:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736869138; cv=none; b=MsW5VNhS6y02MqVDoL1qMybCyCVmcQ05oYiHP1xcoJsz4C+ZSTUx1ZFtLZ094y0oDHacowThS3XEFn8hTsDM6JdN2NTW7ggS9vdjEwd73SsEVd5VSSVtS7dzmsOHCyz+MvRhNZkyTnA4dcjmOZKP159O7aCXFNqxEZEhUaBKwH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736869138; c=relaxed/simple;
	bh=go7YGDo+/CPimM/t0Xx6B6Z816gFoIMzYFR5DY+X7JY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HJN0kft1hCkkZds/UMUR/QrHqzL0uXmogruHu1brOsafOpUfk3jRJYQK9Nh0lF4u/iZoCMTGEi0K+aN1GlQ13ro0buzI/4U8fAJ3H7zqvnQEg0ExUwbTi6tcZqkmKYeZZ64C2Q/PMwiFBTpDjd06h7n24Lm5fzVW1McKIsoyYIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWUECB8C; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-85c4b4cf73aso1145374241.2;
        Tue, 14 Jan 2025 07:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736869135; x=1737473935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LiCnWXVueHQuao3N4A+VSfpdGCx4nAczUeSeIXuHHQQ=;
        b=dWUECB8CPX0MbYng/zy6bMoa1kluFPSHs8fOEkHkYrU3U6BQj8C3NPozk1MxBsQeUu
         zH9M4NpOcN6S3B6qXxs/wjPURFEIzzrdau5aE4kBWS2ZCFh9pSjY8U/vXmYrtiAh+2S+
         JMJ4jq9SXCdOM0TdQFYXIA+ZPG59qJeguC89Mw+faZublrkIQxu6g5LYefFAwYmA4sSw
         pTidoYTtLc2uMUOI1n15Y6bO3gmU2eAc4bRv7Cs2O2M7Eqjc2uVUNpJ3WsMDUSd9mvqS
         s6ZVMcNVBdKvfZwyiaDCn4FX5OHmwYNuf6mK8M2Syylck6zyK7NlwyhJjwCukpBHo3tq
         QLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736869135; x=1737473935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LiCnWXVueHQuao3N4A+VSfpdGCx4nAczUeSeIXuHHQQ=;
        b=lyRAOBYAY2GKgaGbriMi8JOampuuoeaY9PAa9ST0wGggpHBx6kLGvEHfYSluBxV8KK
         /TRS5+Xghx/E4DvIE4hxUz9p56gbI3yzpV0hSwW4dsh2SJsAeVB01Sd3BDfMZ8/2wVDW
         WRNVGly5tS3onVhG1ihAXpkiS7ukpIMLd+PGQOjgg9HBobiCnNMKmZxRjLCkUHvJQq88
         pfOS7sZ0FHjqufSJOGt0WPhvOcyHezpJ2zcjzFisQvOg4Pq2u2wRy832bcE34+eLT+zH
         UbF927DAxU7d7YVHO5Cl7l1vbuEp3PhW5Xxu6okRHA06OurImhVai5AEgsBmeYWortKK
         b5iQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9BOaas4A5qeCedapfFtXMTLPTa02J9IBkvLxVOxhxkFgtBqXrETg0Wpa4XztExQFWJX6Pq3BpfqoDCGqQ@vger.kernel.org, AJvYcCW2FRuFAQFsLDQnRdyW68CSC92JZoshqpkb4zdG4Jng+eZr4URE07R41i3MT7aRcpT6jPIyITT+sPYe@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+tNReM3if90y2338abFgA7ofn68IpOuR8jvuB3wG/FeezDvxI
	pvz/JeysITPqskqwMksprLtmS89AODa/03YGlO9puQzbxHp3IF/gI0RJjw==
X-Gm-Gg: ASbGnctKDN0TwzvapBpQO4R1m1cIQMO3boFJsm6SZUAhX1te5DpKkTxkB1kh01hm/dS
	FF6MlRW/8qpFUg2e0y7FgB2u2NDMgyxE/AyKaZMLNZwuAp04mictIau5ZMPX/ZHfUwASlez9q50
	jfQjZ8809/LAbpmaGrcFkl1B9wXR38ZsMR2ap6LbmizHmQ3shLsmhuii+oGQwoYaSs/fzWoFjLq
	fHwANML+H0TDEZAsWqYto2vmpQxl6X6g4j3BDLAKTtQuX5af+EURx5apv8njYkW
X-Google-Smtp-Source: AGHT+IFk7j4l7HPj8VxDCjftfQkzhJq9B3+Zw2zMzEnf/NJM23IVRxVCmlPlM4a1/jAdbvZMGX9XDg==
X-Received: by 2002:a05:6122:1acf:b0:518:80fb:df24 with SMTP id 71dfb90a1353d-51c6c43aadcmr22112591e0c.3.1736869135265;
        Tue, 14 Jan 2025 07:38:55 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51cd7c56d30sm277e0c.14.2025.01.14.07.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 07:38:54 -0800 (PST)
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
Subject: [PATCH v2 14/18] platform/x86: thinkpad_acpi: Use devm_platform_profile_register()
Date: Tue, 14 Jan 2025 10:37:22 -0500
Message-ID: <20250114153726.11802-15-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250114153726.11802-1-kuurtb@gmail.com>
References: <20250114153726.11802-1-kuurtb@gmail.com>
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
 drivers/platform/x86/thinkpad_acpi.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 5c250867678f..54ff3e6b8b1a 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10649,7 +10649,7 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
 
 	dytc_profile.dev = &tpacpi_pdev->dev;
 	/* Create platform_profile structure and register */
-	err = platform_profile_register(&dytc_profile, NULL);
+	err = devm_platform_profile_register(&dytc_profile, NULL);
 	/*
 	 * If for some reason platform_profiles aren't enabled
 	 * don't quit terminally.
@@ -10667,14 +10667,8 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
 	return 0;
 }
 
-static void dytc_profile_exit(void)
-{
-	platform_profile_remove(&dytc_profile);
-}
-
 static struct ibm_struct  dytc_profile_driver_data = {
 	.name = "dytc-profile",
-	.exit = dytc_profile_exit,
 };
 
 /*************************************************************************
-- 
2.47.1


