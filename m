Return-Path: <linux-acpi+bounces-8306-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F81997982C
	for <lists+linux-acpi@lfdr.de>; Sun, 15 Sep 2024 20:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDE601F217BF
	for <lists+linux-acpi@lfdr.de>; Sun, 15 Sep 2024 18:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6961CB515;
	Sun, 15 Sep 2024 18:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iz/iEW0e"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC9D1CB33A;
	Sun, 15 Sep 2024 18:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726425561; cv=none; b=GoyPKX6GLRUN26ITMpukWuSL/4vUTTFfhnI/PenakEh+UOaT52Dcu9+pN0tO4f1hG60KNp+2IhHka9Gamq2C8lBew7PgKI9Wl7JnmwAhO/ikMkScu0rRed/DJfTexklrI5XxiUJ6B49xt/31bMPG9isUPgA1xUaRh2FaEojfADc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726425561; c=relaxed/simple;
	bh=QoUWTZne1jWr63rOxXE6p255C+CLmqViiMc6+HGq5S4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dj2a9wbL56Muonwv5t3R9ZGXhjSgYxJFAiKNshWZ2mBFkFFoE6Tq7SnyJyeuhPQXutj//ieSxCjyD1djnVv7WhbBen74lqIiM4J4ekpcbp84Bn+1ZoSrvbJtRPZhrCkQtx8fi1aCtACEvYIcWARcxO7A7D+IqWvW0pNHSFNV7jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iz/iEW0e; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cbc22e1c4so20417505e9.2;
        Sun, 15 Sep 2024 11:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726425558; x=1727030358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3sfvhHdETpIzImGnfuB66N28/eIqs9Dchf2bSTnmUN0=;
        b=Iz/iEW0etHLTijsmTUI2XG6+j9VX/0sRfne7OHCIkzbkufYRq9I6DHbbni0fSPVxe7
         Iagy6T2J0w8sQxT7MPUa8ieVPlThDFd3UK1yGoaYJYMuwQwbIakGL80Xik6SI2I5iDcB
         F9pTilvGW2pn6g9FJQN+FLmi1xiO3lp/6GOS3BuIj0gSmSx+KBP0Tj6aj4tBvaWT7lnB
         GxKLdwUU9ZdnDl6zRxklG/2Z+iY/MaT5R9KmHANnHUEij2O1AdtegK284iJ/iqG2Y8jX
         +F2i+u7+wuPoFzWuBJgtUCmiDc3TK9kv4us//THw44JGoY4gjf1UyZshIrLvXMer4txD
         h+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726425558; x=1727030358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3sfvhHdETpIzImGnfuB66N28/eIqs9Dchf2bSTnmUN0=;
        b=lzxQl3V8pZEGd30+O49OxrhFCLo4hS34Dk4478MPRRWpFJlZ6kCq4K3uMQNskIkh3R
         A/4+e0WsaPm+kP+c9ES98LAFDsIn04l7sX3FJHMMzp25Xvz1A73JO1NrrMScFxvN7bPM
         EMF/Wogdcvfm0vhQe3eQ98Zw8hGEn6A5ttVHz3elWXFQyKgakm48aGqVmE7WZNJvserq
         8unHLaEQdpm53HvUA11ZZcKPXwpLTXE5aOkTMYZO0/nKd/GlyzNOGQiOvYAYc6kBLPei
         oXhCHkE71CWoDYbvy5RLb+gpqJYDa4WvSbW3oM6GWVanI0RliDu6VH8QPnuaLAh181AP
         Jj6w==
X-Forwarded-Encrypted: i=1; AJvYcCUwYMKjrKcowUpwO4pSN4PHNs5VySpZmWqtjPZTKaIoK8rGpzE7dg3A0pvAiSeIaCnIACtT8Uf64KGh@vger.kernel.org, AJvYcCW/bWIZGttvbvbzMeF5YIiolbFP4CcOG5cfRv6lJz9DojcuhfRbhWWZo6Ho2Gxj/yeAedBxrmruvsOQtaEz@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/Z/YXvwSx45UbVydJ4WmyLsak83FvZ31s2pyoI2X/Da2waUsz
	Yu2sWM9C2ondsPDnd9jOyIbWqhAr50wY7C8/SE6LFJr7Rsm1fCcH
X-Google-Smtp-Source: AGHT+IE8jgabBx8WeBP1L+viW4h4KJj3z8nr0KA+qF64OBxZL7TGrFTSZs+otQltJcxpKHA12An1Vg==
X-Received: by 2002:adf:ec05:0:b0:374:c793:7bad with SMTP id ffacd0b85a97d-378d61e2843mr5255345f8f.16.1726425557790;
        Sun, 15 Sep 2024 11:39:17 -0700 (PDT)
Received: from qamajeed.Home ([39.45.198.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73f2001sm5162357f8f.48.2024.09.15.11.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 11:39:17 -0700 (PDT)
From: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
Subject: [PATCH 07/10] ACPI: sbs: Use strscpy instead of strcpy.
Date: Sun, 15 Sep 2024 23:38:19 +0500
Message-ID: <20240915183822.34588-7-qasim.majeed20@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240915183822.34588-1-qasim.majeed20@gmail.com>
References: <20240915183822.34588-1-qasim.majeed20@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace strcpy() with strscpy() in the ACPI sbs driver.

strcpy() has been deprecated because it is generally unsafe.
Eliminating it from the kernel source.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
---
 drivers/acpi/sbs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index 7a0914055fca..a3f95a3fffde 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -644,8 +644,8 @@ static int acpi_sbs_add(struct acpi_device *device)
 
 	sbs->hc = acpi_driver_data(acpi_dev_parent(device));
 	sbs->device = device;
-	strcpy(acpi_device_name(device), ACPI_SBS_DEVICE_NAME);
-	strcpy(acpi_device_class(device), ACPI_SBS_CLASS);
+	strscpy(acpi_device_name(device), ACPI_SBS_DEVICE_NAME);
+	strscpy(acpi_device_class(device), ACPI_SBS_CLASS);
 	device->driver_data = sbs;
 
 	result = acpi_charger_add(sbs);
-- 
2.43.0


