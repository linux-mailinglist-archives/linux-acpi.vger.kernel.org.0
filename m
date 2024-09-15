Return-Path: <linux-acpi+bounces-8302-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9DD979824
	for <lists+linux-acpi@lfdr.de>; Sun, 15 Sep 2024 20:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BADC71F21136
	for <lists+linux-acpi@lfdr.de>; Sun, 15 Sep 2024 18:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392191C9EC6;
	Sun, 15 Sep 2024 18:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTGJvBz6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825611C9EB5;
	Sun, 15 Sep 2024 18:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726425553; cv=none; b=k8TXx/8XzAnAcD4uWItrozRja5VWgrKtLz1NkRCj8mwT8Dx5TVr3A6PbKv2+XVIM3fB9Zrw7dyG/ITIdPUj2f9yZFI8dtLfDnl1aTF1giNKPwZYqFwNE6Az5xQ2yZSpGSiLZWUY4LKdFktUECcYuIHx/PSAFzDeOEa5kkrWTAkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726425553; c=relaxed/simple;
	bh=v1VE8GlgbLovu7FzspWcQCNMUgl4ykznIQhRvDIkq3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SBdcozZP85T3BE/XdKzj5MrI4sbO4PXNUHDN2iFHWutH7ZZmgHHawIArIy8HjycWVnOhdwe8FXpHvfx21ylJ8uupltVsqlH+Qls+YXZMJSmNVc2DcR1YLXdMmF0lcn0vIW9pN93XJk1PtU2XzhqXVkc5rmxJnZCTKTJrmYMHcSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTGJvBz6; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cde6b5094so29450675e9.3;
        Sun, 15 Sep 2024 11:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726425550; x=1727030350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbWf+7usUXPbgb2aRvoa6RRa98fE6m5NKrnKLo5X8Q4=;
        b=WTGJvBz6yMVpUcCNWQ4WH9yMRRebcoWq91rwyNIULQScNLFfnHXxrvRGzlBp9u+131
         T35ws7/Jvvtyu1diSdZhfTla8wCubnYEytTkPykLB3SNMEDWsZyDWdeDYWLfb8+PGGSC
         adFBVy0DD1t/AIV4FomkBeU1iugRaVtdlgvR9WFrxJshhuI5kb4iGqFRyFMSMMhO6Lmf
         xw0EhG9gyCfrN4CUfN6d1wvm/ffV+pXWir729Ic12HYa11Z+lCkzDKskRQwieee9U6U+
         rP5mTw8SNtKLO7XPgMshVTDCIVyS/QpmuY7g4QGnekKNC7W6EjbN8f4+Mx2GfNqnvobb
         NXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726425550; x=1727030350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JbWf+7usUXPbgb2aRvoa6RRa98fE6m5NKrnKLo5X8Q4=;
        b=E81ho7La4RAWFsarripzAAv+GR2It1g9Yvd0UBdkjoiCjdOCJ1eWICbQwnqoZ0ruXB
         wtFu9zZsdqohsNykn4kQode8XSDR6dhp6jJqCZZv1JEstweAKHTDUxj/Ypgxk75ZWohG
         rmmmmCwS2clMO/oBmpB/8IRZqSodkvGUFob3VuTmHbp8YVqWNBgMqKv8kMkIFfVXJ0D6
         rMEhHcl8DRsqCXcfwalEEt8eNFl3USSo1rSmpuJV2/006UoTJnFrHfOQNj1AWdLqncfc
         X4pDiNr+s9XdCgpsOfgQZVYZOexnyne1sVx4V+fFcBSPu0AkZyAf0RJChVKJ0g9J/QHG
         VQXg==
X-Forwarded-Encrypted: i=1; AJvYcCVld+brjwsTvMJV52LYIAcyWcvuDwKPs7nF7KWH7/ZZfbiA/ateAlBffLxIFiLFkHobhvu8dvTiyKxF8zUy@vger.kernel.org, AJvYcCWHtJUsBr4fSr0O4N+5sUm0NpDRbqj6O+0zrFEG36uXS5WjPUphcZyzEobYJsdbBEVNTNyWtzjzVbpG@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo62LRJDb7uw1RUwAug9vjAdIa793KGpF4VLAoATxObgTDcUd6
	RMkmFZmBB9Ydu9NzIA2RMhI/mQoyCosBK1SLu6Sy1DchzTzmC6hXlKqcrrwB
X-Google-Smtp-Source: AGHT+IGEvH8eOSC8DXIKx7aa71EenGGMFszWRvai88KhFWatglY4FAVQj6u688jRL9Q+CdUVhOEDOg==
X-Received: by 2002:a05:600c:46c5:b0:42c:b843:792b with SMTP id 5b1f17b1804b1-42cdb531b96mr94952455e9.2.1726425549515;
        Sun, 15 Sep 2024 11:39:09 -0700 (PDT)
Received: from qamajeed.Home ([39.45.198.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73f2001sm5162357f8f.48.2024.09.15.11.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 11:39:09 -0700 (PDT)
From: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
Subject: [PATCH 03/10] ACPI: event: Use strscpy instead of strcpy.
Date: Sun, 15 Sep 2024 23:38:15 +0500
Message-ID: <20240915183822.34588-3-qasim.majeed20@gmail.com>
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

Replace strcpy() with strscpy() in the ACPI event driver.

strcpy() has been deprecated because it is generally unsafe.
Eliminating it from the kernel source.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
---
 drivers/acpi/event.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/event.c b/drivers/acpi/event.c
index d199a19bb292..96a9aaaaf9f7 100644
--- a/drivers/acpi/event.c
+++ b/drivers/acpi/event.c
@@ -28,8 +28,8 @@ int acpi_notifier_call_chain(struct acpi_device *dev, u32 type, u32 data)
 {
 	struct acpi_bus_event event;
 
-	strcpy(event.device_class, dev->pnp.device_class);
-	strcpy(event.bus_id, dev->pnp.bus_id);
+	strscpy(event.device_class, dev->pnp.device_class);
+	strscpy(event.bus_id, dev->pnp.bus_id);
 	event.type = type;
 	event.data = data;
 	return (blocking_notifier_call_chain(&acpi_chain_head, 0, (void *)&event)
-- 
2.43.0


