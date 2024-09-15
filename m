Return-Path: <linux-acpi+bounces-8309-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECEA979832
	for <lists+linux-acpi@lfdr.de>; Sun, 15 Sep 2024 20:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A2F71F21917
	for <lists+linux-acpi@lfdr.de>; Sun, 15 Sep 2024 18:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DF61CBEAA;
	Sun, 15 Sep 2024 18:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3QH7CVi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EAF1CBE98;
	Sun, 15 Sep 2024 18:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726425568; cv=none; b=q9kDWy3iy4la7IbdUoTUjFXVQ9GD/fhk4vpJdRfInmdWe8QM/NuyAS6WQx2tCbyj7rcD3JLQqajYTEqux700Yk5Yt09YEXfuDy2biNZe+wAw5nsYZN5xtMHyU+ygCZKVbhIqqlGB41v9pgBn2yoBv95ygXcdReXMwmXgoU8WDYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726425568; c=relaxed/simple;
	bh=keCmrGqn8EZjR2v9MgON+1inwuqXRtWmcwOAfBJ62fM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KKY5gbqvKVa9FT9/lmohVmsNfV7nSCeX/q5boPCP9Ww3jiMgQ9lpXGNCEkYS9dMy+7kODco5IoxvSW2AcBJ1Uurh74zE7Ryp1k03RyWTwYEXMH7It4wWH05eDAzJPPNXJGpA/YhmiEjpgCRVepT7sckFUiNCWDobiAI0qIyAhzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m3QH7CVi; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cbaf9bfdbso20146245e9.0;
        Sun, 15 Sep 2024 11:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726425564; x=1727030364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BubB76Gm/+PXngcewf3UxvETcuLALREaZF3VY8gFJww=;
        b=m3QH7CVioXUZlTcXez1tzURS1g2ZGIPYCCLn5W8BouYFQSZE8lWseUj0S7IaAbWzE1
         +46OwoCjbzpWNn8NcIKdb460s1/SqlMz5DUTCDakLJkS+x/B0zhHKhMQiJZV7IQq2P+v
         2TV+ua/LrdePzqUfYk/uuVIdzxIB1RlrF60N0IjCPfEPW/6xylT658jA5LioAkSvTABn
         ZyT1AMDsgcmDMAr067CS2MrYcfcgmC8KoJguyGFg3X6lTSDFOJ61HRUtZ0kn2HT1LT8V
         cch2kEIn85VLpiaoJMUhOIWPzz60aJm9qTLvWSDrjAMK7xjpkCkBhlUnJAU9CYk6UtWa
         VkLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726425564; x=1727030364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BubB76Gm/+PXngcewf3UxvETcuLALREaZF3VY8gFJww=;
        b=U9KY/Dc2n/qdKOUGbaJtg3ZtjdnrYVt2+C5r5EFPHinERXiuhyie+cnNNOVLmFqDOg
         JiRtlGN1tnpEmi67xalJ9JNbO6MdvnXgUutETZB6qPXPfTTkF0RPSLvRY8mWC2Cj28iI
         cGWcps98UwWYHuTjpjzBITpnaObLzEVhq0cmL7B8zrkPVb0S9SFrVE81Kq7wjbmP098H
         qcA0KZnejiN7/1NtzqUNweVHHyz4mjquBOuUZWKglxolktaRHqzY6ne4HguI9WmYtnRV
         E4SShEhfH3yl+G3G/6g19RuE+97tw4ukafgDiAyh7o8h2lhEMzCnqB8oQ8jHtL0NNyU4
         QvGA==
X-Forwarded-Encrypted: i=1; AJvYcCVsQVPGaL8JFzSSDrdPHp4gQZOZVVyD/heKx9NhLbChuU/kjad7YRGdZO6/PzT1QDwkPUw5N4ESYsvMaVSW@vger.kernel.org, AJvYcCVxBLYZAGYi01hEDXOZQNaKTUbbgFnREkY6B1FccrR8IE7lloW+Aeo0U68kGAvsfKwUA5A35XCZBqu2@vger.kernel.org
X-Gm-Message-State: AOJu0YwcM0uj7KL+vg4jQk/ujDjNp0+kGGOiM8VRgOiBFhnlcrEEJR6y
	cQeue3IBKxbqEpr4Rh+RbqB5M8WfmSbVAQbLIAK+fY9Y7UFubfr1CKBhqQ==
X-Google-Smtp-Source: AGHT+IGdVWZbZlZqMEbwDjELGdMIn/gX+FexnG/400I907lv+zs3oygPi8/fEv/56/0oF1wxM0Mrfg==
X-Received: by 2002:a05:600c:4e94:b0:42c:b34d:720c with SMTP id 5b1f17b1804b1-42d9070a587mr52572485e9.4.1726425564444;
        Sun, 15 Sep 2024 11:39:24 -0700 (PDT)
Received: from qamajeed.Home ([39.45.198.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73f2001sm5162357f8f.48.2024.09.15.11.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 11:39:24 -0700 (PDT)
From: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
Subject: [PATCH 10/10] ACPI: thermal: Use strscpy instead of strcpy.
Date: Sun, 15 Sep 2024 23:38:22 +0500
Message-ID: <20240915183822.34588-10-qasim.majeed20@gmail.com>
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

Replace strcpy() with strscpy() in the ACPI thermal driver.

strcpy() has been deprecated because it is generally unsafe.
Eliminating it from the kernel source.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
---
 drivers/acpi/thermal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index a0cfc857fb55..0c69d04fbac9 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -842,9 +842,9 @@ static int acpi_thermal_add(struct acpi_device *device)
 		return -ENOMEM;
 
 	tz->device = device;
-	strcpy(tz->name, device->pnp.bus_id);
-	strcpy(acpi_device_name(device), ACPI_THERMAL_DEVICE_NAME);
-	strcpy(acpi_device_class(device), ACPI_THERMAL_CLASS);
+	strscpy(tz->name, device->pnp.bus_id);
+	strscpy(acpi_device_name(device), ACPI_THERMAL_DEVICE_NAME);
+	strscpy(acpi_device_class(device), ACPI_THERMAL_CLASS);
 	device->driver_data = tz;
 
 	acpi_thermal_aml_dependency_fix(tz);
-- 
2.43.0


