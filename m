Return-Path: <linux-acpi+bounces-10707-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38187A12FD3
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 01:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54A401663CA
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 00:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CE81411DE;
	Thu, 16 Jan 2025 00:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRRmzFop"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C0928399;
	Thu, 16 Jan 2025 00:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736987298; cv=none; b=JdwO1LP1Ztoa5mfnC24kF6SphSV+5R1g21NatZIQsYjqNImWTgseIKlYZXczUvsZ844youwsnA6w6hNG/c9g+uQH3+MYv6FpVFI1T+LyepWGMTLu/QwlqvrTuBC7LBUFPK7mwr2E8MFAseunWpzuRGG95gE60fAYV90m62F6Fdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736987298; c=relaxed/simple;
	bh=vgIFGuCQtCQrejPkdjQybQSCxQrM64ITP35HJbOz4qQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CubHNfP6ej0fCYBFW18qyRGuGmU8B8usQlDgbeJOzn95zRxiR+v/dLNujcVZYdKyIKWEWJ6VaH50jJsF9F2ASa1CQhGOaXyBntW/gHO/xv23Ej7ktaEgXaW4EtPKHDYkl7yTGbkQIl+YDgfdiOAVwcvea1WBy7J1RqKBVl2qxQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRRmzFop; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e3a0acba5feso531646276.2;
        Wed, 15 Jan 2025 16:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736987295; x=1737592095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jn915JjHMCZzW4nymCIdvo1TCvMDkS6xX+9xPAKXL5I=;
        b=WRRmzFophY35ZHuaITkI7AcRB3SOgFt49nE93rWCTUt/odVwuAlLYhRLGO0BA7QIlM
         x9ZzaLINSae1848diUIkNXYqqGg5F2CjgElaN5q70nvGKg1LpyPpYYxuGGLGGiA2GrtN
         txgDLWN/u357z7zERSGFUDLNrAwP3Qt0DtxeO60b+U8CmPR/de33d/BuuKcbrONneNKe
         bvAXQa5d+OO9rmsQLkYVyCDmTINLIjlo5XmYVXfQsJoUOntVWAS6I5rzRsKzhJ1tlFCv
         vGTm+ZOE9oBvhbjGgWmjmdFcH0PTo45yRUoaUSagC+hIDD9Fifl1vgy5XSGgZbBbLOhn
         PJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736987295; x=1737592095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jn915JjHMCZzW4nymCIdvo1TCvMDkS6xX+9xPAKXL5I=;
        b=IHRpHxwzKmOW7X5zAGexRiHrqLLb0I/4m6V9ElGwwKamSRh52LQVN7/HPiypomuP2j
         6Bgjgzbr7gHKkzwvzfSAKplb48etVX+XKKbnW9UByavGdCfj4yTFxiWrtOc2ach+x288
         xP2vzopmkkoH+KcR2+4kBQlg3eeb0JqHvgp7NAb7bdi8ywjqRWoyFVwDsNRRmTm2fgIm
         4loEuHpKWKb1Ebmoa0Jxx2aiq1qZWFbWCoiT3V7GxPgxXJT6gFmNjqumzz11yjU/m6nX
         EY4vDVg7R1myC91igcvEwkwGrx71MGcE5RwAl2kB0L2KZFif59Zg1mPDshv940n06o71
         VIQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMlIEeDA4dj6pziBQhp/6fNByEGKnD8jd24vNhYbpHvdcIXXsFiRc2L/T+fJM5SF90iqNA/SNc1vug@vger.kernel.org, AJvYcCXG9C01OssyMZ78OY/9phDqaTW+qlwLgHlv9Q8O5jMUNvpbZCeRciE8W82si+lyIj70qVVmOIrTHePp9jbH@vger.kernel.org
X-Gm-Message-State: AOJu0YwxeP5MZjoBRCju1HU6Ohi1xs7Pa0LJhkIJhmzeXmohFXL2F/I3
	I8mw83FFO7oyWfZptVJ1z15N4wPsw8BgnUCq6dxs/Iqnu9ztxXtu2l5t6Q==
X-Gm-Gg: ASbGncsZqk3m115Rcm7agEBwmpF8GXj6cGU32im2FuGPHpbepBUXkgzHfkHh0e6zAmo
	k7YBTc5Ncc7JGuf56bdzUL5CKUU4Hj/fiLtOVkXvIP12sWizcTcjuKmXINnKaiJDx88pudm+Bmd
	VWiHlxJEd2pNhsSC52P4oMjhJuIOmfWDLkdbzKy+5wpO57ceIKKOp3HrLj+My0eyXhBpanCejZU
	aYioipKue/E2vdigjJhI2wN+NgkRvOWuSGBQuC1j76t16EQ1REwVAMhqrUk31nu
X-Google-Smtp-Source: AGHT+IHGI2CCldxbaXTDdFrDsQFHmhyBCK3y7oK+RDzKpF8lSEtUCmFtmKcCZIkoyRUwz5T17OoGcw==
X-Received: by 2002:a05:690c:f0c:b0:6ec:b74d:a013 with SMTP id 00721157ae682-6f531245e89mr267306797b3.19.1736987295607;
        Wed, 15 Jan 2025 16:28:15 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f546c46bdesm27229077b3.50.2025.01.15.16.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 16:28:15 -0800 (PST)
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
Subject: [PATCH v4 10/19] platform/x86: dell-pc: Use devm_platform_profile_register()
Date: Wed, 15 Jan 2025 19:27:12 -0500
Message-ID: <20250116002721.75592-11-kuurtb@gmail.com>
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
 drivers/platform/x86/dell/dell-pc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
index 32b3be0723f8..2759bb608b1a 100644
--- a/drivers/platform/x86/dell/dell-pc.c
+++ b/drivers/platform/x86/dell/dell-pc.c
@@ -281,7 +281,7 @@ static int thermal_init(void)
 	thermal_handler->ops = &dell_pc_platform_profile_ops;
 
 	/* Clean up if failed */
-	ret = platform_profile_register(thermal_handler, NULL);
+	ret = devm_platform_profile_register(thermal_handler, NULL);
 	if (ret)
 		goto cleanup_thermal_handler;
 
@@ -298,8 +298,6 @@ static int thermal_init(void)
 
 static void thermal_cleanup(void)
 {
-	if (thermal_handler)
-		platform_profile_remove(thermal_handler);
 	platform_device_unregister(platform_device);
 }
 
-- 
2.48.1


