Return-Path: <linux-acpi+bounces-10073-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA889EC350
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 04:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 929F11677AB
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 03:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A1820DD56;
	Wed, 11 Dec 2024 03:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="THZa8Uof"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02A2F9E6
	for <linux-acpi@vger.kernel.org>; Wed, 11 Dec 2024 03:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733887703; cv=none; b=S2ZQ9j4Jp0dOWifsMHb4FZ9MphxnokMiLdH7kENqIiPntXLdm2dWK3ZjhcwM8A2KobzHJcHLnZadsr4fWgEce3OQdEA1akC2nvi+JaxDxoz5O+7dYEw32YrWCVzU4bK+E1Y0Q7x/6TKnMCX8SzJKsZZ8p501W9Gf5kkQu+Iwylg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733887703; c=relaxed/simple;
	bh=chHa0B/VKMYr3cRxqY0Cl2TcliC5piJJ/sWAk9TE9Dc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NdW1mgvdFVfd2LBGWw+w/NqQJxyHLLqLEOHvl/fjxl7f/TeF3vtD+gRJ+I6XMegDdRjTZzDaCzYXECe79mi0x12iIDuhcjwzoWvfQDH3F+39gdrvypo73bVc+ZRHKBvzdwrbIpYiZGf4BFeBqwCtvaCUzf5R9NwaRMk9QV8xKE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=THZa8Uof; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21649a7bcdcso29428295ad.1
        for <linux-acpi@vger.kernel.org>; Tue, 10 Dec 2024 19:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1733887700; x=1734492500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HCpioUYx/Wguc7AzIMqu+gxyV37dTLDMEwaUITpr4mk=;
        b=THZa8UofxioYKoojDhuCnw4GNWqZkTt1hqJ5zx/QqV4w7gIXCyhKkCX6quf6jFSTnG
         qAQ+Y22eQN9g03u1XLMyWtbVHReXmgXFifzkditICk5s5bel38UmZiXAgQ6gpbeolGBd
         MGg3kofaOkNUcaMfWC+oILwrfDRPi5RNYK2bS8c44y1zZTBC2/yXPy7hT00+QMjafY3f
         kmQt+BEh5mI/ol4TMQRDNSdUHF7bUoceIM/4nKkKW/aLXwz3pSu7SCG50XNT2VYc51VB
         8iwNWPW/5iEm1sxiKhd5xTs/030G+YzIa/l3Gx6U9sQntH/dGqGl8v92rRec0H7+rWx9
         Hmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733887700; x=1734492500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HCpioUYx/Wguc7AzIMqu+gxyV37dTLDMEwaUITpr4mk=;
        b=dPrork6Hja7sHv2ix3JEg3XQysFlljZI+M5PszeQYf6hpDjXl1FWDvSFduF36aBdh0
         XNoR2H0W4zjfVodl5ARGepQXFA8uvXIj84Lz1sRD1z7b06b3habXbPtZGaEK/xwNdKvF
         qeeJxutoguSlfJtC0Tu9aTSQaZKJb8n9n5Ga70VZ9G9A/sGQ2ev4N6jgSvlHUNW9TzR4
         MUqOOTTmchp4pcTWcZp0EyDQStgrqVQjx1xBZ6VDuXwlugwFtsWw7aU0FF2csMlNyuuI
         O6bAclByXfqvonNGfvSM2SXtXquZd/40KE/dp6nFrKG0wwoII4Tu85g/G752ir4WSHqu
         4wwA==
X-Gm-Message-State: AOJu0Yw9dHmzMzaiY+caJqX8Wl+CZEpGF1PYpt1J5Ti0nDbQbb8zc77J
	e0FOEJXPPLqogLSyczhvUSaGnkASlX9bF/uwzEykXE09morGjX+gKJBaOToj8jg=
X-Gm-Gg: ASbGncvZbBtqscYeNjS5z7y6GQVC1GUQsFRpPeVViFbOfzKoEmHukVjbeuThlWcI//D
	inqXe/EjSLUiUQCZHoxhNK/DF+J62VkpwFU9OED/FG/GD0zvIzlXaDP8UYUUwFUqWOlTGoEZCgB
	O6MIuNs3U8oTk+2pQ0EhfLh8fmVrn9PToTMPhFrxYwhNmuEQqahrGGxTPnXoqW5If82FylrUVxo
	Yo8KMkg31IeYO0Gog0R/CNreDjgDx41IPM9v2AxjIwiy6BLz6LeVxs40hCNXeWD9duO4i7xQDvU
	Aw==
X-Google-Smtp-Source: AGHT+IFPXXBfhrpsurEJ22iErnC6EpVy4/R3SgLPG2DG9fFg6ED11YCChjc1HyElKucKZySKKDl49g==
X-Received: by 2002:a17:903:41cf:b0:216:4165:c05e with SMTP id d9443c01a7336-2177851dbafmr24167125ad.24.1733887700245;
        Tue, 10 Dec 2024 19:28:20 -0800 (PST)
Received: from localhost.localdomain ([2001:f70:39c0:3a00:6880:79c2:6ffe:8185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2162bd745b4sm64435835ad.73.2024.12.10.19.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 19:28:19 -0800 (PST)
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Subject: [PATCH v2] ACPI: fan: cleanup resources in the error path of .probe()
Date: Wed, 11 Dec 2024 12:28:12 +0900
Message-Id: <20241211032812.210164-1-joe@pf.is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Call thermal_cooling_device_unregister() and sysfs_remove_link() in the
error path of acpi_fan_probe() to fix possible memory leak.

This bug was found by an experimental static analysis tool that I am
developing.

Fixes: 05a83d972293 ("ACPI: register ACPI Fan as generic thermal cooling device")
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
---
Changes in V2:
- Handle the case when the "thermal_cooling" symlink creation fails.
---
 drivers/acpi/fan_core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
index 3ea9cfcff46e..10016f52f4f4 100644
--- a/drivers/acpi/fan_core.c
+++ b/drivers/acpi/fan_core.c
@@ -371,19 +371,25 @@ static int acpi_fan_probe(struct platform_device *pdev)
 	result = sysfs_create_link(&pdev->dev.kobj,
 				   &cdev->device.kobj,
 				   "thermal_cooling");
-	if (result)
+	if (result) {
 		dev_err(&pdev->dev, "Failed to create sysfs link 'thermal_cooling'\n");
+		goto err_unregister;
+	}
 
 	result = sysfs_create_link(&cdev->device.kobj,
 				   &pdev->dev.kobj,
 				   "device");
 	if (result) {
 		dev_err(&pdev->dev, "Failed to create sysfs link 'device'\n");
-		goto err_end;
+		goto err_remove_link;
 	}
 
 	return 0;
 
+err_remove_link:
+	sysfs_remove_link(&pdev->dev.kobj, "thermal_cooling");
+err_unregister:
+	thermal_cooling_device_unregister(cdev);
 err_end:
 	if (fan->acpi4)
 		acpi_fan_delete_attributes(device);
-- 
2.34.1


