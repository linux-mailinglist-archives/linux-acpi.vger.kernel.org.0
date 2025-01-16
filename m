Return-Path: <linux-acpi+bounces-10711-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBE6A12FDD
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 01:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B0C1166450
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 00:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7C2156F5E;
	Thu, 16 Jan 2025 00:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZA74KEIW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA0736AF5;
	Thu, 16 Jan 2025 00:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736987311; cv=none; b=YCnMjvhF2v4wbFB4i44NNb/ype3JU9xB3fzUOcGJEm2OQnyY2Amon9upATlmlAcNvJBc2P4P7dNmiFo21iSZu7jTCFBfk+bD08mevWVvZpZakzneaHJ7bckO8aEhTqfo0168X+p4yftm36eZw06xl2VLo4MaSH28wSFod1FGOSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736987311; c=relaxed/simple;
	bh=KEQvIYmq0cIHVoujULOvRQU8fvdS43CqT1HPP2rwjYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tl9RE5RWb713LjuV/+Ef1aoFaGHVkbfDP+Umcxr0b6AcbL2UgugLKyzJgz72YnUKBXFUigvGXg2uILaMUpIUG2BkR5sYmVxriQTlZsBAIbnTzUW8ggo0UV+XXA1yQS4pdkeykFxUI4mQLm8LPMX2yPqIEUA0+7+WLhyWwrP9Ukk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZA74KEIW; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e46ebe19489so548907276.2;
        Wed, 15 Jan 2025 16:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736987309; x=1737592109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0RP7ern37rbsyz4TGATiD0LG/PTcy+anmVzb3IZLQZ8=;
        b=ZA74KEIWE01KdSEEXVloDzV+HUTFyu8l++qHrSm0fNKpJUp7B1i6GUx0Cl1ANoxR2X
         p9dAD2sqd4ClVaMMQv8N8dTX5sNTDmYcexPCz59xzUWAtLB8ovMcwmBgFX97tb4VPZQK
         7AxtUjoDMBjVGkLGEToZehIH+0iyn1/XKBRP4+mQNpyYg9rt8U7m7j7WIFFVty3t+326
         Q1uX3WP8zD3N5ZVLoXPeW0K2cTY9c6unRO+0nqFN5Axb7nGBEjU6oz19HeQ08OYxWbgY
         LjeH1mMEZqNXLnOeXC9pcmS9LxJltr8E8MalQgT6vUvKCtU4lWDHn7QIn45E4sj0tDFO
         Q5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736987309; x=1737592109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0RP7ern37rbsyz4TGATiD0LG/PTcy+anmVzb3IZLQZ8=;
        b=iXKYpeJGGnlpJ3jg0OGTQnqWs2qkKdfflEoklsql3O+HJFCKTG+98xJL+XTIj1H5PN
         S875zwJd0N5GXJFSNcSR5Ut8BUN9O9hrNKFZ55NQi/gmyJFyeAnsPtSWhAOUYzZ4nOm/
         MejVTPbJZnXG01ITmCSg1JDANWE4Wim9yI6wQDJ7luKAWWsjjW/UXic2eHM3c0SDoGkO
         ILVo+JCjufzY/WLoPnJuB10qO9Kmaca/HL/2NsEpt8k9+fb/WMHAOG+/rrFLpB1Y8Jmp
         K4ltZ0BRjUYMTFb4IPtn6C/jaRGi2X6Rp64Dj4Wb9etb6R7MzrVuCWwTuah4CmddTJeo
         993g==
X-Forwarded-Encrypted: i=1; AJvYcCUGkphJ5lumXyLmKWktMnrhWrDGHFhteSiK7dHARJmeFYmY368+H7XNirhbsePAtfJvi2q/ZhLfHxsO@vger.kernel.org, AJvYcCWaQrxTQkHD/U2BgFJshTQ14DckFBsOKXVxbi1pD/MuVbdoNdoE1eSqLXGm4CuXLw0o1bPnJa04ALUwYBAz@vger.kernel.org
X-Gm-Message-State: AOJu0YyfayokQEfz3O9ctnOdXclDzeJbxObzJ1qSk89rAZ6u84Jjee32
	zGIAacUfcjayRHOkzn90ijaZPNtyyNydxW7zGAOePFtylKXjkljtHZf3kw==
X-Gm-Gg: ASbGncvO1oT1WFGvPvBuf+qux0BKn/eJS6m/yuggiZksItR10lOlmlhkq48wXi89ZmH
	ioSY51QDyDmapm9PMYJNrqwYqPK07NP4J0qEbrbOHCFwoM0vWon+KGC+9c/uqU8yiB3Qwf6dEmP
	N5C4VOpVZyZGPoKSgmcPEnn0DSUgDgd9vO8A7rwINARxG2oF2+tHZa+/oQWs4/aYyXXsJmwNgRq
	CUmLx97/G1cDFiKjRWSJyCLe6jWYR5nZ5a/zoRQyPysCHFzv4vBqGDRt464lUXI
X-Google-Smtp-Source: AGHT+IFxEAa5i/RxugjSShvFTYEJLnEaU4SYF6nyvkFZO1eQcrtgEHLpG8u5x1pd5Vueh5k5pVbhOg==
X-Received: by 2002:a05:690c:7346:b0:6f4:222f:3b77 with SMTP id 00721157ae682-6f531224ec9mr272789187b3.1.1736987308893;
        Wed, 15 Jan 2025 16:28:28 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f546c46bdesm27229077b3.50.2025.01.15.16.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 16:28:28 -0800 (PST)
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
Subject: [PATCH v4 14/19] platform/x86: thinkpad_acpi: Use devm_platform_profile_register()
Date: Wed, 15 Jan 2025 19:27:16 -0500
Message-ID: <20250116002721.75592-15-kuurtb@gmail.com>
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
 drivers/platform/x86/thinkpad_acpi.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 62b2ddfe7c0a..c9226e8dc713 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10650,7 +10650,7 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
 
 	dytc_profile.dev = &tpacpi_pdev->dev;
 	/* Create platform_profile structure and register */
-	err = platform_profile_register(&dytc_profile, NULL);
+	err = devm_platform_profile_register(&dytc_profile, NULL);
 	/*
 	 * If for some reason platform_profiles aren't enabled
 	 * don't quit terminally.
@@ -10668,14 +10668,8 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
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
2.48.1


