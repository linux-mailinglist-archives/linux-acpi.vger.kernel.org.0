Return-Path: <linux-acpi+bounces-10607-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B495CA10B12
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 16:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3C613A9642
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 15:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623E41CF2B7;
	Tue, 14 Jan 2025 15:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gW+SK6l+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01071A4AA1;
	Tue, 14 Jan 2025 15:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736869110; cv=none; b=Mz+WHBgijiebsd9rAjMQJ5GIgAxiwHLp/9IDPR/xBNIqyq/TQTr2lm3xqBIhSE1UUzSH9dV0y7GxkymCEtwZopjnH8xm4ES1vETwT+qnEGUicIc+vCeMJbYjhzsHgBpzO51vtAGWZJYJvIf/fXdA8NlEtAKV3ftCsakY0z++iZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736869110; c=relaxed/simple;
	bh=2+taimKyBEm1kRNAQ+szSIcVKCkO2CromD3iyu2qvtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nMxhpUemmqm/hBXd1HdFyV8Vc1VmZ5CRF+WE4HIPq+lEp6MHszY506Ix3sGHtzRU3bU0xxNuucJdoBgs8iEO9QmvoRVOgbI8TUI243XXuZBCnFfU98tbPWn9goczZukFH1ltjbiUpBO/BsSx6Poi7kk1iTn+ryLkUYydRw7Jpvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gW+SK6l+; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5187aa2c97dso2017364e0c.2;
        Tue, 14 Jan 2025 07:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736869107; x=1737473907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sjq2L0uePHNEIwDJxvOdyrSdiJEUOj2ZGOc/6PuIBm0=;
        b=gW+SK6l+DKi5PcLEdfO+yJHg1jkZtgf+vTDwmkbXB48Y1RoQqyI4wliKjiWu7wfKur
         7NptoassUJGn7JC+BqXkvX2Zkh99bOggZ9ynLIOsQBZR3k+ykwPAFnFnUNX4DlC2m6zv
         Nv1dFMxsEG+OBBOYWWR1xBTsbdLuYTpOXm1CuoowFPVLUanaLj5tjmeH/N+Nj5Kj9NFN
         zDXAEK2HLGKpp+43/F/XwV+56m50GRvZWe9bHHjRvvfRX4atm/GpcHJXo/EbK+lPcnxX
         n2uoQtv/PCyEcGOUCDtoIdGIPa9+yDpAz3l61y/F94rRJwggArkGY896BqKHX9/jTlqw
         LIEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736869107; x=1737473907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sjq2L0uePHNEIwDJxvOdyrSdiJEUOj2ZGOc/6PuIBm0=;
        b=tR73oSBrAb9WOvv8aAGaG0qJNSEMTc7cQhQ0cL/Ib/8Di/tKufMvkNyTDS7PI/aP6m
         3WzpVDsYPwgtkvk/eilhElSs+I1koAppbd0pCT8gRy0fgbs6eyB2JyzjfrAAqmiDyhiM
         yEB4WCWAen7OegTniY1SYGS/B4UN7hQJJyZgDJW6N8xiJ2OBMQk6PI2/Xp7JRNrYM4wj
         49px4lemEC+gP4KuflBGMO594scj1edQiwoQK49MuPFEoCIN3VYpF1RwYPsZhdWKs8Gw
         hdeymlCAgycW2GvujZ7m68ktooNqrgS98/ueVh3AR8ZXjeKFi4C6We2VR+yaHByMOswc
         JoJg==
X-Forwarded-Encrypted: i=1; AJvYcCUuJgi3fQxyB87vZ5YZRqm21UM6/2WgKt3ANuqNNhRWND35KAsKT5qxR0IVMFvat4R3Xnh6tElKzDF7@vger.kernel.org, AJvYcCX373cr3Esm4p65Lm5kbIn6YVfsrAOXuUxovRloATJk/Hbhl4tEaev/3fy8AMtDeUVMfzhVzTalv24hdZTG@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw5jvF7a1aR6tR6/rDDHJ5dgWLHzxXpEocnfE68Ji09M45qgDy
	2J5Bg5ofwiAVY+vuO1Zz0SfZQrI3xbmjfjXYYGty9gENOBwhWpRc15xwVQ==
X-Gm-Gg: ASbGncutRqntLPylsb6TnFlURL8h/DaEuFrXhIjXkjcf2zIxtBWyZSSDHGilNdU6hhY
	ct0NYvsXCV0dI5Qwsz7VadJP0Q8W3euUHcVL56B9ImPtokHvjV9jf1V/IadOfXUEvxnkCLlvGrV
	791Nq6UUJhiBAD5xXgDRHMfsdphyk5TqOhAo6LdXeOP67k1ObuS9yTp5DeF6go+yeuSLr2uk2BO
	bUwhHqzZtinPD3J8V9JhS/0ccC5OO1FEmnc98lL4QKDdHUazkHjtocaCjf+HPVE
X-Google-Smtp-Source: AGHT+IFmZFDY2y+/oTQyOlNMw68zLjvAGIijNhNMJI9bQH2N2Mohu0AAs5boNvYkOHpoxhVXoMBkBA==
X-Received: by 2002:a05:6122:180d:b0:50d:5e21:ef39 with SMTP id 71dfb90a1353d-51c6c3570a4mr18788273e0c.1.1736869106904;
        Tue, 14 Jan 2025 07:38:26 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51cd7c56d30sm277e0c.14.2025.01.14.07.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 07:38:26 -0800 (PST)
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
Subject: [PATCH v2 06/18] platform/surface: surface_platform_profile: Use devm_platform_profile_register()
Date: Tue, 14 Jan 2025 10:37:14 -0500
Message-ID: <20250114153726.11802-7-kuurtb@gmail.com>
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
2.47.1


