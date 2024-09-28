Return-Path: <linux-acpi+bounces-8478-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2A5989131
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Sep 2024 21:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCB1D1C236EA
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Sep 2024 19:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBC7185B72;
	Sat, 28 Sep 2024 19:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lxyt+6Qa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC8C176AAE;
	Sat, 28 Sep 2024 19:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727552867; cv=none; b=mfBSq5rtwG7rOs33TbrAUxzgG2tLM2DJy7W9mRZSvPL0PwBupIvuH8bPdPYpJQdhyjz/8dDUFlRztcdV7ajL+WJn7Q/wsbFBaiurK5iC22hF927zXP76CkjjHGlSyGMWM2Es4nOcfy4IYDG8pQifXcoi4k+Xlxj2mHI6WTCGVxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727552867; c=relaxed/simple;
	bh=OmSLqQKAb/QVwFN4C7eKhQPVnPYgmYpfMCMk1y2cALQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J1MTbxf7jQiJ4euHx93KFE9U+4xYhPySi6x7WAcnn0ES0/8LLK/MWs2RacJxpVZVyL9iqST2xEfpE7YmPxWamxYCxRwcePCADJJpCufmTGHrMOM/oGGetRH7MIXNMTwhH/XgAPu4wKbaosvl+LKRUleBz5TFh965L2l3lFtFFvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lxyt+6Qa; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c8844f0ccaso2210234a12.0;
        Sat, 28 Sep 2024 12:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727552864; x=1728157664; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2iltsOj2nm0hssOij02ApkpMdrgfT0iF/UOR+aKdBio=;
        b=Lxyt+6Qa4/Pw6iiDXG0IfYGlurKBQcY5Au4R1ByadIRIewKLgdXyZTmkk1xFjgKDNN
         aZwwInDU7REKF93cFLoejeCT0CA7/xkCtr7bfbx+VG/3Fc27aEnZ/Xu34feTv5sezSQK
         xzV/Zrh3utKQ/gu16JSb1ireDMrciEDFfjKhaQfV3JgdvWUu4YoEuvSRnhiEfgOuCmZy
         vUiMIoXVVqBEAEMQV6e2zypVUfMW+0Ohv+6xmipRIYE6pACXY0EJRfC772SPSNLn81py
         bOx+jQWwBIEMjLO/gCzDjm0O/7YitM/50L0uL79ERbGB/GJilscOQ4Pi7zBuSvZlIWjC
         K95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727552864; x=1728157664;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2iltsOj2nm0hssOij02ApkpMdrgfT0iF/UOR+aKdBio=;
        b=O5hyp0U4wiWHDj/AKi+ij5tGX3UCkCw14i/3D8+jBYiyqEvrMup0Ucqf4U3TvqTgd2
         wOYAGIUNBdQgD79YZBDfgp8RIDR+zIclDQCA3/T9DXW8K/ZwBjb0nNZdgCjWr9rrua4D
         DeJWWkRYGa9jBUDDqTS3CepL3HpDoyWWge/9cPzbu54afWRjDkkepgToFeSZ7aE3tSCW
         BTihOG6nDUz+2U/JSYpkQzlfWbmKSiBPfDBznlFodvSw7QceCh7lmWasWCmwWafW35ux
         pt2j3PFSswaxey+gvsNf53lkbduMTpppMQjYNXokj7kJsTSemtmy0dAZBFLP6JLdlGZT
         UlXw==
X-Forwarded-Encrypted: i=1; AJvYcCW5ICVgDX9155HkRXDT1sm/d60pmdkYAFa+4BYhPAtS3qFT04NcvY+IevygywzeVCLFpGAjAyfvOy4SX6mF@vger.kernel.org, AJvYcCXZYu6JOcWmf/JPietJ66Zhim+6EfB71umky4BSiAEXhm/HyOqRrmh5+rtC8wmE/j+X/n4EY5/SpGbS@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+ewQ4s+Skc7L6fAxsatZL+IB4bB2xFkN3H2fwY/lVcGGKgW3Q
	Z6Z2Ad3GpKR0KL4eWSKT35JH84Nx6ckK+/A4P93ciYps0Kv+whgl1YgGEw==
X-Google-Smtp-Source: AGHT+IFft1o19Zd9czA/C4i/Nk9M0s2es2Xe7eLAYuqbNn7Q27a2SfNiUuDSSopD0Eh+G1YkUuuPow==
X-Received: by 2002:a17:907:6094:b0:a86:c372:14c3 with SMTP id a640c23a62f3a-a93c4a4e0e5mr933056566b.48.1727552863793;
        Sat, 28 Sep 2024 12:47:43 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-2243-8f1c-2a7e-ca73.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:2243:8f1c:2a7e:ca73])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2775c22sm283707466b.20.2024.09.28.12.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 12:47:43 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sat, 28 Sep 2024 21:47:37 +0200
Subject: [PATCH 3/3] gpio: acpi: switch to
 device_for_each_child_node_scoped()
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240928-gpio_device_for_each_child_node_scoped-v1-3-c20eff315f4f@gmail.com>
References: <20240928-gpio_device_for_each_child_node_scoped-v1-0-c20eff315f4f@gmail.com>
In-Reply-To: <20240928-gpio_device_for_each_child_node_scoped-v1-0-c20eff315f4f@gmail.com>
To: Hoan Tran <hoan@os.amperecomputing.com>, 
 Serge Semin <fancer.lancer@gmail.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727552857; l=1319;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=OmSLqQKAb/QVwFN4C7eKhQPVnPYgmYpfMCMk1y2cALQ=;
 b=eOSvEiYIr9MxSawrD21/c/lnXe8QWnJQBkoIprV+FI1oauBP+WU4gbv9Hmjc7olsJlQadDQEB
 S+NLzUpfVpSDtsni7kcxNDp/2MgJhtuDG9m4jl5nQ/Qvsoup86C5A4m
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Switch to device_for_each_child_node_scoped() to simplify the code by
removing the need for a call to fwnode_handle_put() in the error path.

This also prevents possible memory leaks if new error paths are added
without the required call to fwnode_handle_put().

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/gpio/gpiolib-acpi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 78ecd56123a3..1f9fe50bba00 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -1315,9 +1315,8 @@ acpi_gpiochip_parse_own_gpio(struct acpi_gpio_chip *achip,
 static void acpi_gpiochip_scan_gpios(struct acpi_gpio_chip *achip)
 {
 	struct gpio_chip *chip = achip->chip;
-	struct fwnode_handle *fwnode;
 
-	device_for_each_child_node(chip->parent, fwnode) {
+	device_for_each_child_node_scoped(chip->parent, fwnode) {
 		unsigned long lflags;
 		enum gpiod_flags dflags;
 		struct gpio_desc *desc;
@@ -1335,7 +1334,6 @@ static void acpi_gpiochip_scan_gpios(struct acpi_gpio_chip *achip)
 		ret = gpiod_hog(desc, name, lflags, dflags);
 		if (ret) {
 			dev_err(chip->parent, "Failed to hog GPIO\n");
-			fwnode_handle_put(fwnode);
 			return;
 		}
 	}

-- 
2.43.0


