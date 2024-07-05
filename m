Return-Path: <linux-acpi+bounces-6777-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E08EA928DBA
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Jul 2024 21:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92325284422
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Jul 2024 19:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F381465B3;
	Fri,  5 Jul 2024 19:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emT4i/rg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0FC18AF4;
	Fri,  5 Jul 2024 19:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720207124; cv=none; b=jfWDM4awMT2JIXMTADZdcOnZLq/ZxyPl0rU36HbPie1b9BalTtX2eePye04LYEMta6/hdCHqExnHkQez8oJ/f695qstTuZjRYNSRZUQqLw7kKA8hroMha0dQNQoAHktlAYOSuuO0jQVgl+Wr1/BCEiBKy4W3Id5kk4uH5aZFJx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720207124; c=relaxed/simple;
	bh=hNcEz1OYtw08PxmSpFlH3YSXnGgAyTqletcXjeyA6zs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jeBsPwGeNnDfWLe1/a4RTGWcaif74fvktx8mcBgGiZPCumBat117+GGiZJNHA9DEUD9K/zVVRFtxflkX0tKLSy8fVSHfTNRQNPTObW2ChdVYh2oJ5sbfPLe+tpXVmtjf1NMJZV7X3UZWarZCgJxl0Bb1ZD3R+7niKtxFIpWeiq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emT4i/rg; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52ea5dc3c79so1566137e87.1;
        Fri, 05 Jul 2024 12:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720207121; x=1720811921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P69kZ+S1hfiWiq82fz30moD60frg6JEbjOfeN4iomhc=;
        b=emT4i/rglEL2Rq7dQldZsLrgHKwWJoCMLPK5L9TyuR5a4n7ZZW3Qt5xu717oDtSF8q
         bdQN5QJApaNyZ9SzF+hoNN5Exc1omdn5lVcNt+2l0bAcvzwh0411VGgZXYLeuBMxZh2o
         NTQAfn49sNYRQ0DxNZcKmM4C6yiJMPH8HYhZH6r8dCq6Qxkc5tBhsMp5+8vhBlfIfPOB
         U5U6HHdpo5zPDEfCMET7AuJFhreAdGo/EF3uelc7v/famBSDqeOqgXXnzBc0U4NIALok
         BDDMDc8JcSKsxsVsLJKkXSBBI+TqKazBym9ZF2GTjSA4jwcmCrqos2xvEaYGqP0BknGA
         /d8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720207121; x=1720811921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P69kZ+S1hfiWiq82fz30moD60frg6JEbjOfeN4iomhc=;
        b=eDkkiEOLOPl4FEJiEMkNJK/CvnEwNayu7NfX/dEZES6K+wumxq3diX4NwvllThCcM3
         EyG6sqETXvhraLUje13Rt69cJOCN7HDNtruPR4d82uM7su7zqVOz4uDH6U+M0aYk3b5G
         s8+2rr5MF6+76Mdnx8Horaraxu9GIotaMHhQKWJltDSqAyk5ZrWd4RQDso8pAW7L5lxI
         0PxD+4KNj8iSKDouvHbjh6YdYnGbWEn/lh11mVzidOaKqlHaInxIembljid0t0kqSbp1
         I88J/LALRtNL0nZS04fmFnvUAHtHPWClSxYD3PR8/A0t0Wyz+MHkbMjI4erk2QS15YOm
         BRMg==
X-Forwarded-Encrypted: i=1; AJvYcCU/PU1lo8/myGG/RrMgDLWlBF+GxVT2t62lzWX14QcXBJoFsr0la2ZBNJV51CvEle0oCVeqR37dygGNuPiImae9VRmOzymLDxIk/Yt5
X-Gm-Message-State: AOJu0YwETLNDOS2HE/ylRXFLtI9yBpXN6xeY3DIOhSfpjixOwlCXOb46
	qIdNt7gCLI4eBDZnXqmzgNRfoqfOHcdoensOOzyV1O8laDqcHAlNPC2DWzqCKsY=
X-Google-Smtp-Source: AGHT+IFiI5C72H9HrtnPCdkn4Tgv2awkRnLTAVoTc9+P5ZexMEgJiRGRx2krHCnmKvNxU4prQZKBOQ==
X-Received: by 2002:a05:6512:3282:b0:52c:e07d:229c with SMTP id 2adb3069b0e04-52ea064c57emr3820839e87.22.1720207120269;
        Fri, 05 Jul 2024 12:18:40 -0700 (PDT)
Received: from localhost.localdomain ([185.245.255.21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab08cfc1sm701120266b.163.2024.07.05.12.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 12:18:40 -0700 (PDT)
From: Thomas Andreatta <thomasandreatta2000@gmail.com>
X-Google-Original-From: Thomas Andreatta <thomas.andreatta2000@gmail.com>
To: rafael@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Andreatta <thomas.andreatta2000@gmail.com>
Subject: [PATCH]     Staging: acpi: fixed a coding style issue moving from strcpy to strscpy.
Date: Fri,  5 Jul 2024 21:18:35 +0200
Message-Id: <20240705191835.152189-1-thomas.andreatta2000@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fixed a coding style issue moving from strcpy to strscpy.

Signed-off-by: Thomas Andreatta <thomas.andreatta2000@gmail.com>
---
 drivers/acpi/ac.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index 09a87fa222c7..f4b5ba033df8 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -213,8 +213,11 @@ static int acpi_ac_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ac->device = adev;
-	strcpy(acpi_device_name(adev), ACPI_AC_DEVICE_NAME);
-	strcpy(acpi_device_class(adev), ACPI_AC_CLASS);
+	char *device_class = acpi_device_class(adev);
+	char *device_name = acpi_device_name(adev);
+
+	strscpy(acpi_device_name(adev), ACPI_AC_DEVICE_NAME, strlen(device_name));
+	strscpy(device_class, ACPI_AC_CLASS, strlen(device_class));
 
 	platform_set_drvdata(pdev, ac);
 
-- 
2.34.1


