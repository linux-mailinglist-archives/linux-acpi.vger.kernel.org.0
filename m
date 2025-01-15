Return-Path: <linux-acpi+bounces-10654-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D74A11A8F
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 08:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97F713A3DB3
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 07:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8203234D1F;
	Wed, 15 Jan 2025 07:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcUKB69K"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40411234D1A;
	Wed, 15 Jan 2025 07:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736925120; cv=none; b=mzK6mz+TZxgO1Iou8RoEueCZqKJyrn4HvazKtspWX/XjEYyUrmHGj/eAGayRizKEPjijZGjcLsXN/MuwhDZ6hQ78wF2gnQk+4RAwAq4ph2OZz51mpiq3by45cRGWH1ciQT+Kek7NtkcK2JxCpQY2+bVduPM+GxFPFto27x7PuKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736925120; c=relaxed/simple;
	bh=xxpFolKZ3QIWrSeNZx2UGrFKgXHvd9r/4p1nFCx3I6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V1oUWD3pmi9VavO6d4TUvk0JMOeMWs8lvevUAWwoZAR/MsqbRsz6pnycFrxN9DMa/ApX+KzNMj1C5JV7kTm4jSfiUU3v2BEFjSh7ceG62MKBiPob/GLHNJq3JLX8+Nxjb3ozYkOzCLw8zmQWU6eKGTYKNgmQ5FUsOmcDbFxN8d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dcUKB69K; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-85c4b057596so1386659241.3;
        Tue, 14 Jan 2025 23:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736925117; x=1737529917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3ef8ZxwB/RtbrqRwLVcEe60IFIru377XMlbDqmQIbY=;
        b=dcUKB69KqGzrnsH6Jai6Dfb8VIhBXExA4l6ihoF6cHyS/rabPo5yZ8DPlJwDb54J7/
         G3ZAvb8q6ukcfjGzOpbCju2I77R2OK/bghEoxApLxy65mQkGwxnZZZfBhbj7TIBzkzL6
         5HNC6TqdU2BJ5W3+8edk5YyAIBaYas0YCsO6qYVyP1YyhppFBNyZFa7KSSFNuFijjdgA
         hGg6/LiLbPj5B/8kZ42c7uIcEs4tjwUptQQEsSFYsVy91YPO5tcK9ItzUndQlvH+lGeG
         WSt31oRfxB7nPEFqVz/0n+rNy7yHcafkNmtIVhLkX7onUk4vMOQ8gBe3H5XDju688Pq6
         BjNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736925117; x=1737529917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c3ef8ZxwB/RtbrqRwLVcEe60IFIru377XMlbDqmQIbY=;
        b=ZaT9NM8EIGPm2Jg3r6Y2fqmlhHsJkQYj7A9Lf1WeIrLT/nl7eGZ2tMq7NDN5HJ3Uym
         2XK3Em/vNWSUbjcF7tuuIf7LkjQJ54+ySKJ2Inyksn4mI4dQNxONnZZMd81VjeveQDJl
         qHPpgox2w5DzVbMwkBLq3ICb+5LgY5LPxriQCvQAWdKoz2K/dH1mTcJKN7n9Cd8DB1KI
         M+wq/3WLu9wvU0+Rzl/bTbUfVO6NFbNhx6iLxLi/kkP/FhDm6Cbw6TdPmbRf3ZqEkEQa
         Un3g5Pa2EfpYH7BC253fVhFzrvNrMlVdJ3EXnTC7qMnOh9Z26Fe0M2p5WY5iHYb3F8nG
         QVmw==
X-Forwarded-Encrypted: i=1; AJvYcCWP1Pr4zVmRlSzaMqS30BuTnNRWrfQq45NjRonA5TzfbcUjgfAcoIoHzlZFKUglm75VT8bg1iG6LGE4VZJM@vger.kernel.org, AJvYcCXbh3PyQCeuPuPd7Hc7rPAlvMNDirLY53Y+wMYldGLmaTDPvTUYsERn5nhq2D6Dlf4JwNE27pcz/0lJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyZDJCoYqmikgpzrUrcuSVsTRW07WC6sw3jH/7DF/f/yG5YYcuJ
	nS+HvS3bsMGXvpR7gJNXwu0N9RoqCdigFct5iqM8JifcxJk+V5fPu0tEiA==
X-Gm-Gg: ASbGnctpIpdcT8i+qOuOdod+6f3bQdt8cX5D1eij/5MBN/ACoOGahNowMPP2PMGjs8l
	rUVM1l10Op7Mzw2CFKtnINV/UxLHGNMH0zB/irIyVHYLLYr//u34kNAVMttYa7tza2fSnX6h/XY
	2sWxI9LwkwdQ3wE+Sl24L5KDFmKZyRnbbpgXf7dWvuRzBlFGOL0y3Yf6egaTndQHaMGUIvKb2mC
	Cv8fddquv13gNgG7OZOQ6uIquUaCKRPkUMhYuIxH5sEXK+/nOd0cmuX6uyQPWtz
X-Google-Smtp-Source: AGHT+IG9UZghEc6LXZuT2SOZCui+uTBb38w3hHu+Rkg5xOIGNBNMHwfFOdoktEnAcVwFa0iZv/PkQQ==
X-Received: by 2002:a05:6102:1624:b0:4b2:5c4b:55e7 with SMTP id ada2fe7eead31-4b3d106a3a0mr24283737137.25.1736925117607;
        Tue, 14 Jan 2025 23:11:57 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b608f033ffsm5084366137.6.2025.01.14.23.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 23:11:56 -0800 (PST)
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
Subject: [PATCH v3 06/19] platform/surface: surface_platform_profile: Use devm_platform_profile_register()
Date: Wed, 15 Jan 2025 02:10:09 -0500
Message-ID: <20250115071022.4815-7-kuurtb@gmail.com>
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
 drivers/platform/surface/surface_platform_profile.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
index 48cfe9cb89c8..bbdc873cb788 100644
--- a/drivers/platform/surface/surface_platform_profile.c
+++ b/drivers/platform/surface/surface_platform_profile.c
@@ -234,15 +234,7 @@ static int surface_platform_profile_probe(struct ssam_device *sdev)
 
 	tpd->has_fan = device_property_read_bool(&sdev->dev, "has_fan");
 
-	return platform_profile_register(&tpd->handler, tpd);
-}
-
-static void surface_platform_profile_remove(struct ssam_device *sdev)
-{
-	struct ssam_platform_profile_device *tpd;
-
-	tpd = ssam_device_get_drvdata(sdev);
-	platform_profile_remove(&tpd->handler);
+	return devm_platform_profile_register(&tpd->handler, tpd);
 }
 
 static const struct ssam_device_id ssam_platform_profile_match[] = {
@@ -253,7 +245,6 @@ MODULE_DEVICE_TABLE(ssam, ssam_platform_profile_match);
 
 static struct ssam_device_driver surface_platform_profile = {
 	.probe = surface_platform_profile_probe,
-	.remove = surface_platform_profile_remove,
 	.match_table = ssam_platform_profile_match,
 	.driver = {
 		.name = "surface_platform_profile",
-- 
2.48.0


