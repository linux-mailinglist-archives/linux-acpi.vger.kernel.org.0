Return-Path: <linux-acpi+bounces-14491-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3E1AE2779
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Jun 2025 07:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 780E01BC0ECB
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Jun 2025 05:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6543412CDA5;
	Sat, 21 Jun 2025 05:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWP8OLt6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE952AF1C;
	Sat, 21 Jun 2025 05:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750483038; cv=none; b=klkaxUrAIc05mi+AWNYEH+SDcW7K5g9WCGwN++TXJp/hfBDltFcrfVbTQe1WA1ZrXkcaBSMa0Av0lWoZGbXuhivI/twkcAux/dG2P93E3oFWhUQ4uP338AArbkk71/pPIAhd3R0sQLEMXgjKFPgHMadbjKuBaHUx9pzSQg/rbeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750483038; c=relaxed/simple;
	bh=JGREnTYwd30zKWM6FI91tmbFDRIqVUVqQJZjy5Nmx08=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=czYqlhgd0GtLh3OX2dOaTKxd89vkwJLYSYMQ+jIm72Hg0TJZA9H5qByraHlTV0N1lIEB8PFRDHOFqFrNFoVMGVp+eZ37smTimbEbfQF3ab4prVhhi8TUVJq/+UKFkL0P3EJipdtIfSm8NFFn9ujMHBuGQAA8MR/GZV7jBWuLWB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWP8OLt6; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22c33677183so23408225ad.2;
        Fri, 20 Jun 2025 22:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750483036; x=1751087836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H9atXAmiHbi4hBHsesyVbDQEP15xagV4i5usV6TG32g=;
        b=OWP8OLt6gBGAVtesQvm92gLWcHeza6PYUHNSP7yP12A+ypGKTM1dHrs18cTo2jY6I3
         3WFGBhq4KZi+5ZT5d6XBlDPcBE9YIJGvYc9trFw69Q5XnplrOeEJViEXqIF5q51A4Wu7
         EWzMumVLqxZSOStPDdGAR0mX5LcpAawI3z1A2TyXpx2wAEvkawkuSIvaKizjpkPLd9vm
         GYKcQvh6Fwh5yFyqV4RN6JnFlC06hu2+w/eKFahR39R6080meKGzRFlF9SmEXbIEWIN4
         TD1ZuK7fSNu1/H03mA9kDySuQFhAnkK6U1fOYYbQDk5lJ4UtCtEeTfXynuVHKRRnmdj3
         31ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750483036; x=1751087836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H9atXAmiHbi4hBHsesyVbDQEP15xagV4i5usV6TG32g=;
        b=Of61xtfFgg92qgVN3pwtkqwWwRjACS09As9z+LaMdyDUyiffy4yp3yL127zq21/2re
         a/p/R4+enWrWDaSmONxcV0MPRmcX209/y2qeg+Vd2CrX04/1mfboE+PDRgQKCdlMDUTy
         rNLtDFIDmmUnkAuZ9cH5O2shQ9adky7o8D7g2lNEYBaIS1+6+iLa8UyVqs+V7BY+Tzqu
         rjgv8+euhwXVfMVeb9aaX5ZFv5be+mB/Rmu2YCI/7tz9cTM460tcj/wMFAREXDohdL1V
         4ol4sEpUDpNWZeBun0sRwXIQ8K1N0bIgRdNOwGQUeP0cI4zHrF8ShCczOWq7nVmHyNp6
         45cg==
X-Forwarded-Encrypted: i=1; AJvYcCVP099wZEglq7Xez/Mrr+0TfrGchOApleLseVr8itDKNyZdPP73TlHG4nhPiXLPwdmljApUuqDRI800@vger.kernel.org, AJvYcCWP3XpmJ1YVgNGksJAD/NCAwa1y/qxd8e2ZkVFQniIvtSvv8h2LYXz4UlxMdbZi9MrJTGdcFz5e0a0=@vger.kernel.org, AJvYcCWdfVuyJaTgzvQ8BuylrqPjaxs6qeKvRzMdEc5scrgINr6NPWKl72LlqB4z1aJIg9FB+fZ+Y+TXtnWEMMf5@vger.kernel.org
X-Gm-Message-State: AOJu0YyYSamqrqlQEBOaw9FLrx/fC3Ba8Z70zcejH595wQfMyJimTwX9
	uNd4Qaa+ANFyjCjFjKU3xjAny6j0nkK8FjlXgkbfL1e9yxvWfaTlpFeA
X-Gm-Gg: ASbGncuaD/y8vtAOZ7OuAOZior1cxIE4odPjhO0i/5bMwNWVn8KLdS8tAaJkshQ2k7q
	x0zVekc8SbEhQbMI5/zdCblmqVkvQGOLUqvcmGEr5svThjZORMXU3u0mqKYfcTkU/nzzhcvM0Uf
	3I6pcgh0YLBE30nkS77YYDFe8UjQv4brwtaKCP4B7e3zun8ttxynHp965WJk3SEWg8jSbIOpxxY
	XcAsFWmFK7buvY0KhaMATWGC5ApI1pfJIRj8crTqtRWvfk4zGloptKLh6O51y5SJ0knqysZzd6H
	3fzLtZFyaAnxwL6S+utjZK4hkeKCWHWjMv8YmkWkIKOP4dE5UZEVjp+hPHt4R8bea49yq99nDlc
	h
X-Google-Smtp-Source: AGHT+IFJUwDOBzPPWhUnmRwphnn19d11ykLptUH4P8ntKAO6t71fbRgUbCzJASM53zm3I6Iis7dHsg==
X-Received: by 2002:a17:903:2345:b0:224:1eab:97b2 with SMTP id d9443c01a7336-237d9b08563mr87342105ad.53.1750483036065;
        Fri, 20 Jun 2025 22:17:16 -0700 (PDT)
Received: from gmail.com ([2402:e280:3e9b:22f:6693:85c6:43d0:2b6e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d860a8a8sm31149265ad.132.2025.06.20.22.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 22:17:15 -0700 (PDT)
From: Sumeet Pawnikar <sumeet4linux@gmail.com>
To: rafael@kernel.org,
	linux-acpi@vger.kernel.org
Cc: lenb@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	sumeet4linux@gmail.com
Subject: [PATCH] ACPI: FAN: Update fps count debug print
Date: Sat, 21 Jun 2025 10:47:04 +0530
Message-ID: <20250621051704.12050-1-sumeet4linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update invalid value returned debug print with fps_count
instead of control value for checking fan fps count condition.

Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
---
 drivers/acpi/fan_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
index 8ad12ad3aaaf..9f2696a1928c 100644
--- a/drivers/acpi/fan_core.c
+++ b/drivers/acpi/fan_core.c
@@ -102,7 +102,7 @@ static int fan_get_state_acpi4(struct acpi_device *device, unsigned long *state)
 			break;
 	}
 	if (i == fan->fps_count) {
-		dev_dbg(&device->dev, "Invalid control value returned\n");
+		dev_dbg(&device->dev, "Invalid fps_count value returned\n");
 		return -EINVAL;
 	}
 
-- 
2.43.0


