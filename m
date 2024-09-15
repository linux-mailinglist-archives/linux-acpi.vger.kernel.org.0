Return-Path: <linux-acpi+bounces-8305-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E70097982A
	for <lists+linux-acpi@lfdr.de>; Sun, 15 Sep 2024 20:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE0301F215BB
	for <lists+linux-acpi@lfdr.de>; Sun, 15 Sep 2024 18:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042C01CA6B4;
	Sun, 15 Sep 2024 18:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnHs8QzV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FF61CB323;
	Sun, 15 Sep 2024 18:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726425558; cv=none; b=CrIpdT4ghEVCpuTBoclEF/1Y/arMX/E2I8QVk5PQXiUVjQNC7o9/0imzywv+eat6RajAquLTAOSNS0fXRUM2aplnMuBRZO4pr3/82Y1Z4V3suW1oCBTfozD60Dd6JFsYy9Wo9r8OkvMOPjf5yTzht7Fjl8DVeL1DYJMGTXW9e4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726425558; c=relaxed/simple;
	bh=TH+xzJ+fO/3074TWmc0YMuXz689v0ptV3ZDCbmLrg2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rAzUPYV5/2RWNdyzVRrjYOPif+HCZvR3/XyQrKxOBvssQku17K4XSkO9N5tdDVLvcq9++d3cNKyuL+ezYM4pT2dhO7J/s1H7Eyhy4zI0uyzTSji+N4Gx9iQKfzbZOa6aEJokkhaxt7/VMyzSeFgQaOOZkku65YWg+scLdWKFshc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dnHs8QzV; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-374c3400367so2192338f8f.2;
        Sun, 15 Sep 2024 11:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726425555; x=1727030355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCOqSnFdieDXJHHHRmdhpnL3kHmXkF8GysKNDS7ghhk=;
        b=dnHs8QzVsw6SIkKLAvoilGGce1JYWMLg4gPtAlAuGhgtAylHYvT1v9ZNB7/pTCoKOF
         Hx5HhBEvU9J1VkOrwaKj+5WcC0Rp+0AqVUtcNQH279VHNCa/jH9aUxSSKDKmQTQq84/N
         xaoRCKCMWMW+iESYDxingwz/ZtaUaMY6o0SKdKcOjs4lmh8QXQ53gUJSPoXtsh6M19oi
         63Iz07PI2a6IWVeAqeuX4Oy75fpwTUmTonEYw0Mc2IGvha+noDzKKz8JN/WTQ8pRN13s
         LTnGn3g72580936pWGt2wbrmUuzLFM6EIzkNSkXc9+6fS6TOEuV1uqawn8iFr4vvvPPd
         nvsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726425555; x=1727030355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCOqSnFdieDXJHHHRmdhpnL3kHmXkF8GysKNDS7ghhk=;
        b=iAOVt7mUVqYFfvyHGuKoZLvAeM0OQeOMbzh3K4GH5so4hh8uW1GjlZcbs7rEOE/Yyv
         //ehlA+e2eebCQp414i75WwUCI9T2xh2K6VAPgPv/7NbbQnQEEASN+2CgCY2rxaIo0CH
         IaMIju506OZE9WYIKXO4oRLalA0LkaNdzbZ/YHkSc4kf+sZ4Ox+2ZraNedtibQvZ/QNM
         7MLNh/1HRcd63AdHv+xbjNgE2weMgmqhwMYOCxHQ7vQLo1lf2nUO0ackuaogd4bPzoHe
         o2qogwIKNJqa/T4B2DrQd/Xm+yV3hDudGDpTNE9X2nMVPN3fZQulWvAh2WKYlHb4Cs9l
         lCYw==
X-Forwarded-Encrypted: i=1; AJvYcCV9b6izcgNxp+GuAOx4zB79oUgu/rLzhIehV5rzwXvjdGBjFrMm5Si5WF7622v4zsEFmqg6AM4Iu+Bz@vger.kernel.org, AJvYcCWCnCVzuR4v0gAHj895oD/x3L3EoWHhWUxUqOXhDwaCLn2IDzntauoJn12KLAAZRaqDTH89XUvSzjMqhwoz@vger.kernel.org
X-Gm-Message-State: AOJu0YzGSQ1I7logcD+pTV0xa5jmwWjBQBQVlYCYKzoZfPITeyod9a/s
	A+y87VgCp97mgFRNjFY6Drrhnvh9K5Sk57YZrL+vuoDJgCzPQi8I
X-Google-Smtp-Source: AGHT+IFqJdecjc1NuF71/KUuYxHLKyzDqEgZ0EaHyNceJX+Rwqs0idZ+JuE9R1ughh5wHQuTSA8BhA==
X-Received: by 2002:adf:e6c4:0:b0:374:bd01:707c with SMTP id ffacd0b85a97d-378d6242f38mr7192092f8f.48.1726425555603;
        Sun, 15 Sep 2024 11:39:15 -0700 (PDT)
Received: from qamajeed.Home ([39.45.198.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73f2001sm5162357f8f.48.2024.09.15.11.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 11:39:15 -0700 (PDT)
From: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
Subject: [PATCH 06/10] ACPI: power: Use strscpy instead of strcpy.
Date: Sun, 15 Sep 2024 23:38:18 +0500
Message-ID: <20240915183822.34588-6-qasim.majeed20@gmail.com>
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

Replace strcpy() with strscpy() in the ACPI power driver.

strcpy() has been deprecated because it is generally unsafe.
Eliminating it from the kernel source.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
---
 drivers/acpi/power.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index c2c70139c4f1..25174c24d3d7 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -950,8 +950,8 @@ struct acpi_device *acpi_add_power_resource(acpi_handle handle)
 	mutex_init(&resource->resource_lock);
 	INIT_LIST_HEAD(&resource->list_node);
 	INIT_LIST_HEAD(&resource->dependents);
-	strcpy(acpi_device_name(device), ACPI_POWER_DEVICE_NAME);
-	strcpy(acpi_device_class(device), ACPI_POWER_CLASS);
+	strscpy(acpi_device_name(device), ACPI_POWER_DEVICE_NAME);
+	strscpy(acpi_device_class(device), ACPI_POWER_CLASS);
 	device->power.state = ACPI_STATE_UNKNOWN;
 	device->flags.match_driver = true;
 
-- 
2.43.0


