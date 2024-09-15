Return-Path: <linux-acpi+bounces-8300-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30379979820
	for <lists+linux-acpi@lfdr.de>; Sun, 15 Sep 2024 20:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B4B31C20BDC
	for <lists+linux-acpi@lfdr.de>; Sun, 15 Sep 2024 18:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460CC1C9DEB;
	Sun, 15 Sep 2024 18:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRs/assu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB1D2F4A;
	Sun, 15 Sep 2024 18:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726425538; cv=none; b=gxav5SczadsoYMgXGoZgABKqOEOrqzjIc1l0W78Vy5/Cyk133NUaLftJnEAIB/tbdOOmgl7RtZxOf8L2cJIOOKXaI9SjnUirCXPoYPh+3bRVM8Sw3G5gseum1iRnTxi7VSPFni+PpsQprBljC2XP6/Qpvh2qKtVj3xTUuN3B8Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726425538; c=relaxed/simple;
	bh=GD0hS0R0EaLqxG1C3I6hXxh4u2ZYbLcQaO14hyxtczM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XzgtfZX47UWQpf8opIeCCzembf3DqV00trAbSuir6ZGNdu052+6D1B5vZr1fwHzGKpy5Zg1axOvHz4heVs0eMJoZyGv7XbVO3sN/jceB7cEQW5iE5bodtb+unu02eORYDF+o5tKBO2DPoCufEjoRz8x6NIwFfScOATnYauyBmFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRs/assu; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cba8340beso29505135e9.1;
        Sun, 15 Sep 2024 11:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726425535; x=1727030335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S/QcDg3/f4nXWtxtIsOpnVBD30Dc1zURxuZ8j9D+WaM=;
        b=MRs/assu2K16rs283qGhfYWPmbs7HSE9wzV8US30Gc4JyZv7yh30YXI1Y14wRH7IAH
         /W2PBnkwL7oTrPeJ6fuGaHBp73ai/oDKpZBcdfWwzBTnYaH1iZHIIiINYaDuMQH9N7i/
         v4Vex2+X4ZkFo/z6r0Y1k5iOh+Y23W4aoxvFvqr55h0/TrSI4DRhlrrJ7X7CzHqtWXuU
         uQ1tKr9DKepGI65OSJBKDgSxzh9/dRTjRaky50qy/uqWVOJztjyioXJEbPpUITHwO24R
         N4I1vRlhGuIdEUCwiEZ02qR8WUZ/Xp8/txGE0SdpbAGXoDRndM1Xn4NZigyTH0LQ+nDm
         1ycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726425535; x=1727030335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S/QcDg3/f4nXWtxtIsOpnVBD30Dc1zURxuZ8j9D+WaM=;
        b=to0ULZYMYWegnvyoeFM+C50S4dkYQC9NvV2OjShaUJ+Ppu/1Wy/heg1Uuf5wK+22Kn
         TUStwcA/OJo2rPoOZ5wuub0yqnIyKZOC+rOsFo8f0O53CrH0jdVTZ+8aPgGGs7mND2sc
         NBlJhUAXDl1XSXXnrrVqeAJSDEK/gCWlTglFVlMolfVvdW0u9hNIlP3fjgi2+/lvxmZM
         3fqXfdL7bQESAxVU6JgahwsXXl7SNlLBT0AA5VCPp6HxEc/U8y/IPkqwItzr4FvGNDp6
         wFDlhMVao+TICPaYuSCspTUh1tqb7J8MDmvXswiOvhLOPmHHDJQvB8F4eN+5i0b6Um04
         10zg==
X-Forwarded-Encrypted: i=1; AJvYcCUTCkZbRtoods8ATerFVf4SLnjq3ByxLN/Eu7TlsIGHWTP7lMDL13Ah7roqbnCkCeaPuMTlJCuOGkDA@vger.kernel.org, AJvYcCVhs4sIhda6ZzNA3ej+wV8qgWpE0JcEXNhV+XwsXudChHjkO87f/aKqmp0Vt/BhQvV6uQI0F5AJ/psXqe6/@vger.kernel.org
X-Gm-Message-State: AOJu0YymAClLpI4rGaAQf8CN9IClG1zIteeart2BSFr91VEVj9N34cAz
	DVAAfAlz7kk3ZSP2oVaGreiLg/1WvPzOJn4LnyujNsBAVu8ivCnP
X-Google-Smtp-Source: AGHT+IGZ4ci5SkLCmeXgFDWTKuBpqNZLxkTlSazVcAexk8xbCfkU8YoJe1JXz7UmvEMQzM2muXVy8w==
X-Received: by 2002:a05:600c:3b27:b0:42c:b81b:c49c with SMTP id 5b1f17b1804b1-42cbddeb447mr118442605e9.10.1726425534347;
        Sun, 15 Sep 2024 11:38:54 -0700 (PDT)
Received: from qamajeed.Home ([39.45.198.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73f2001sm5162357f8f.48.2024.09.15.11.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 11:38:53 -0700 (PDT)
From: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
Subject: [PATCH 01/10] ACPI: apd: Use strscpy instead of strcpy.
Date: Sun, 15 Sep 2024 23:38:13 +0500
Message-ID: <20240915183822.34588-1-qasim.majeed20@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace strcpy() with strscpy() in the ACPI apd driver.

strcpy() has been deprecated because it is generally unsafe.
Eliminating it from the kernel source.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
---
 drivers/acpi/acpi_apd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index 80f945cbec8a..403e9de396ae 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -86,7 +86,7 @@ static int fch_misc_setup(struct apd_private_data *pdata)
 		if (!clk_data->name)
 			return -ENOMEM;
 
-		strcpy(clk_data->name, obj->string.pointer);
+		strscpy(clk_data->name, obj->string.pointer, obj->string.length);
 	} else {
 		/* Set default name to mclk if entry missing in firmware */
 		clk_data->name = "mclk";
-- 
2.43.0


