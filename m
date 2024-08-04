Return-Path: <linux-acpi+bounces-7259-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F741946EAA
	for <lists+linux-acpi@lfdr.de>; Sun,  4 Aug 2024 14:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 479B428189E
	for <lists+linux-acpi@lfdr.de>; Sun,  4 Aug 2024 12:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982CE2E64B;
	Sun,  4 Aug 2024 12:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAy1vNNb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0ED91173F;
	Sun,  4 Aug 2024 12:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722774846; cv=none; b=II5duCcQAbSGVvkEv97EzJGEH9qjDINSiEk/8fRooKt0lLMl8iou8bbuWwl/5J05MHjUsKyONSuM2RugRG0bYZrcxGCvuFd46lF1bcIT+1OCQ6jk/VnqWU/H1n7wXjDT4YJMuecQtcrxwmS06coBf+vFevtLTPTTFR5vtdQPu/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722774846; c=relaxed/simple;
	bh=HqeHXTDOpEhcioM90KBchuXbkgy525Kf/FJQOe/xfx0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y+UkXwFlI5tNmQj4x5UI5FMzBUbKbkheunIP6oXkvM5ZyWe4IfzcWPhSP6Le6gAjJakOi45xWLkYZ+p21XVNHBVUtlPAWV6M2sdxmNok+cKB96JezG6/r19/5JtkuXRnzvdnV9qrBqH5ZUJqqcmXrRN1bbRh0Wwa4nsMDi5jeGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lAy1vNNb; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4281ca54fd3so57098085e9.2;
        Sun, 04 Aug 2024 05:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722774843; x=1723379643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kr58f6AmwLbjxDpVLr7kHM2iTNAugPK3C/ukaZbQdnY=;
        b=lAy1vNNbaxYYDSYxP8GS3htpiZmtzC/IWPexXhxwh1UZrDJ2ZI0icnFatzfDIQLish
         6HwlHS4ietQFAei4dX6Gq7RxefSGYIAruMEZZ1PPgFy1CpYdw1wHgQJtQ4aVkYRnbdi+
         gF1jIwn0qBmkujWgIk5KliBZe8HDwUU4jc5/5dXcZJMYa/gDe4dtwBC7/rqTcYnf2PO5
         GxB1+8xuioqvDlCdz/imdK1tUnJtSjlOqPdsuJ7z78CQNI+/+8+gantFlB5Ix4Szz4gc
         wTwKlFtnR5NLfegMGOncJ+ioxcr8tfwQMM0AWfRaLDzc/hIitqMQGNQRwKXBRQskQoEk
         yjXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722774843; x=1723379643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kr58f6AmwLbjxDpVLr7kHM2iTNAugPK3C/ukaZbQdnY=;
        b=qZLJYwxKWMYvHwYkR0LUfP+k0p1uHcsV/BQ4sCUqUM27tOGIyZM4KaDsny8UePItGS
         OFjnXg8LhRFOVziPjS9SZkc0h8p1sDs/DIqurj4CqcEQkSkTqWW0BGy8PPLooXN1QwtC
         27MxMsIO7vZsb9YG78O6L9mQfy/COhW5UOwmqoVpBKo3+uD/zOGEQckv1AnpzyYVthQ2
         3iy6oDQ2Fm2bWAIOUfTiwcdVbIUQp2iU58toakg3Uq/wXGQkNLfKx1RESGONPWc4q1jn
         IQApdMAahxV/7RA15ukwjgn4vw638QeofMxi9FlL6OU1hjtP35aipvbLsFE36b9XMEkN
         DTDA==
X-Forwarded-Encrypted: i=1; AJvYcCWXUmOqMkghrZhbayo6G+eiyoLQJzArMdMO3wj1NHqDdScnB3Owwlr0KtAl68pWsT1hfeWjqEsKp02R2i2FBOpIpUhS152VUdp97VXaU8g4rasbL01FoiBCoLXSXTa/qA3FimehiKEqsQ==
X-Gm-Message-State: AOJu0YzvKGthjQvADhj1UVcNgx4kq2kubM9+mxkCDSk810rY55wmdvdx
	JiuHLu3uNzX7d0v20bI9S3trId9/GlZhKwYJgwVEhdwA7jO6BrR3StT/Yj2q
X-Google-Smtp-Source: AGHT+IH1azsyuBrUH0O94a/m9BCfpDMnEgDfOZiA/1irY8pGXu1KPWQ8ahvgdLzK0qXdNtsFUCJdhA==
X-Received: by 2002:a05:600c:1ca9:b0:426:6f81:d235 with SMTP id 5b1f17b1804b1-428e6b037f1mr61214945e9.15.1722774842984;
        Sun, 04 Aug 2024 05:34:02 -0700 (PDT)
Received: from qamajeed.Home ([39.45.131.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e88f833asm92848145e9.47.2024.08.04.05.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 05:34:02 -0700 (PDT)
From: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
Subject: [PATCH v2 1/6] ACPI: ac: Use strscpy() instead of strcpy().
Date: Sun,  4 Aug 2024 17:33:08 +0500
Message-Id: <20240804123313.16211-1-qasim.majeed20@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace strcpy() with strscpy() in the ACPI ac driver.
strcpy() has been deprecated because it is generally unsafe, so help to
eliminate it from the kernel source.

Link: https://github.com/KSPP/linux/issues/88

Signed-off-by: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
---
 drivers/acpi/ac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index 09a87fa222c7..ad1427a384e4 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -213,8 +213,8 @@ static int acpi_ac_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ac->device = adev;
-	strcpy(acpi_device_name(adev), ACPI_AC_DEVICE_NAME);
-	strcpy(acpi_device_class(adev), ACPI_AC_CLASS);
+	strscpy(acpi_device_name(adev), ACPI_AC_DEVICE_NAME);
+	strscpy(acpi_device_class(adev), ACPI_AC_CLASS);
 
 	platform_set_drvdata(pdev, ac);
 
-- 
2.34.1


