Return-Path: <linux-acpi+bounces-10051-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D26BF9EBA70
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 20:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF7DC283E72
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 19:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6935F22A1D9;
	Tue, 10 Dec 2024 19:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QkvUaSsD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC31E228C98
	for <linux-acpi@vger.kernel.org>; Tue, 10 Dec 2024 19:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733860584; cv=none; b=giH2+hGdJirp9O5mZLUCtRaG0if1OfLpuIo5cznQS+o31pj9+FX/AsIbli1dlsnaygodtddE5aqwdv4ReLfubUODdP1y//8bXQcCCD4ocgp8eXMbTfGByCZP2h1mz5IzWY0GBuUhE48D210J8u7LoOI12Z6IPPjCGg++2eusa1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733860584; c=relaxed/simple;
	bh=Whh0DQItzHYKCLXHq+kfFC3x+7+Dk004xdEIyRizvX4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LWqyHj1zAabQ37K8ppUiJ3QzqTa7rTKJZdO8/sFl4XaPwK1YNPv/CGmczQ5pVxXY+kzNiaoS48MDJLC+5PwEdUkSDEELwaGvFPlzpPSJGcrfPEKMRHRACJam4KlLOR6YOOfbbSTzRkS8BE800heFpB2naE4ES8axRIvijQAM7kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QkvUaSsD; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5174f9c0d2aso797948e0c.1
        for <linux-acpi@vger.kernel.org>; Tue, 10 Dec 2024 11:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733860581; x=1734465381; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y8Rm27YENFKXAm/b99nWNPn/wMV7ojkGu352W65SJ+Y=;
        b=QkvUaSsDjiaKz2N0cUsM9qtCGW0xthUakRBDtOZqKdtK4jG2jUqgbMhI3n43H0+YqT
         SmLX0FldveJuUcacSKDYeZBWIv9Bn8zLiSS636aIXDBVJ6aYwpRHADGKx+TJ4vTCF+A3
         WV/WuXdK89/b2l9+3Llaqrz60WkOLXK11QRjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733860581; x=1734465381;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y8Rm27YENFKXAm/b99nWNPn/wMV7ojkGu352W65SJ+Y=;
        b=uRbW+HPU76J9bTZk90wwZjWBc1OAVfr+0xzCaXfV33/yPy/HPrmusi9nHmwLVGqxBD
         ouoZ2eMQHw39ADab0wOJYcVfC2HqQSQLH2fbgkhz5SLzbLA3CYKWSLDvmk8hi6PeIH55
         yg+JiUtPkmRVaeJC8OuZ2l0pTqJWCdna8ZSQH5nTp6VVr/6puf6t3+J8V+nGRse1SwF0
         8e/Rk6JchwcEidFeZSz5a/E1sr+OaipUkqmfx67Ymcw+/K6PHYMqfuCe6L+GI6Ypm0an
         57k3OvvwKU92Vhil+ma7WCwyw0+mx0f4kpZd1BwzNIZKXLX9tTaTn+xQF4F5iPxINSyF
         DzIg==
X-Forwarded-Encrypted: i=1; AJvYcCWUhNN+xD/QkeqIYIfMR3OdF8xZaVt/fn7yysIOR0PHTKg7KqKc5KUbLfD88GsRAax+PS93eQ7dtvE9@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn4XeHA+WmAN6AHvEvIhvuv1RXkievc+7LiTzD/1oBcWwuI6m8
	uOYD2TSyV9Qmw2YkJtiZ+6nJl3o2J3vetx5qL9Do7rCt9//sFTXpXkMqsc9UgA==
X-Gm-Gg: ASbGnctQVKK0HPLDmXaxNXhJDHciksJYhcQakw1yer49cT4Ei+BrkvPxQ45XdR/ATTr
	HLT8HlKlOGE7ovS/ZOmEDr4kxDPE5IRyligE9lC70Bmav/0STAh0+TXXIog1XKdKkUxXF2eaxHI
	tZzrS/0nWC5tMBIGyJ2UdAYww9wUM+alo3vdEd8ej8ak2KRFf2Dzjtf4tSDrUelBmTGGifypjMd
	opHhIaqOE0/1Yy+UpzEh9amCOkbRHPe53ImSh+IGwyi3pcG7SlD+kWQL6P4xuw3zhH+yvPfdLiY
	59fwXYRb8Dfi/BpMZ6VSDMJUyTs4
X-Google-Smtp-Source: AGHT+IEooHxihkgq0sisqhW/5irMfcedK/Z/FIef/F30lACx1FcjAKe1abfF7f/u+XsC/FOi7CtYPg==
X-Received: by 2002:a05:6102:ccb:b0:4af:a925:6b40 with SMTP id ada2fe7eead31-4b12913b260mr760661137.20.1733860581729;
        Tue, 10 Dec 2024 11:56:21 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85c2ba7dc70sm1279522241.15.2024.12.10.11.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 11:56:20 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Dec 2024 19:56:02 +0000
Subject: [PATCH v3 5/7] ACPI: bus: implement for_each_acpi_consumer_dev
 when !ACPI
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-fix-ipu-v3-5-00e409c84a6c@chromium.org>
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
In-Reply-To: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 acpica-devel@lists.linux.dev, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

Provide an implementation of for_each_acpi_consumer_dev that can be use
used when CONFIG_ACPI is not set.

The expression `false && supplier` is used to avoid "variable not used"
warnings.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/acpi/acpi_bus.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 520f12155e7f..4f1b3a6f107b 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -1009,6 +1009,9 @@ acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_info **pld
 	return AE_ERROR;
 }
 
+#define for_each_acpi_consumer_dev(supplier, consumer)			\
+	for (consumer = NULL; false && (supplier);)
+
 #define for_each_acpi_dev_match(adev, hid, uid, hrv)			\
 	for (adev = NULL; false && (hid) && (uid) && (hrv);)
 

-- 
2.47.0.338.g60cca15819-goog


