Return-Path: <linux-acpi+bounces-8753-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEBD99CAF3
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Oct 2024 15:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B536FB223EC
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Oct 2024 13:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B51B1AA783;
	Mon, 14 Oct 2024 13:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QG1px/Cf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F9619E806;
	Mon, 14 Oct 2024 13:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728911127; cv=none; b=G3fDGKOlL77Yg59j6fWvOsCbuFNdUVDOGWiLEMj91gsj2+/nBQr43cqyN5gW+noljNfTpoA37zflyYTrOAEN8E0FPbWLvBcPRxxFJUiwlHmWCN5QS4i5tolFsMRwheN4yNSLc088CBCqemqsADnqM8SseSXNzIBJfTwm7qzA5ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728911127; c=relaxed/simple;
	bh=93N03/0SIwI63TSvRRAPpFrLfV4l6YcIuAmY4AQe9aw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=CPQhdmdthzPUaktwQNL6kZH+7CrXMjHDiQeB0c8j+kPcejOSPY1H3goHdrys6UTnJ7WLmIMW0NzFor03u11X/bAg4B/9+g52pqOUsz9eliADjY3fC0I0e39ZESF5s0YQ62Sn0Amsf7Cwri/rHUhD9JXYGBx699UDhE2zLTJ0YAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QG1px/Cf; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4311e470fdaso27974525e9.3;
        Mon, 14 Oct 2024 06:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728911124; x=1729515924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZGlh0BgvTZR8tIX7xtvnBBKKfSil7mION4lorOOPKtI=;
        b=QG1px/CfGzL+IV/pncXhQ+CsLggLRiXkY84cSbEY+rmxS1cILAn9npU3CpYrVFEDQ8
         cY45jPyxZfFJ+DtV86jWoE0b/YGE+H6qKmAxYLNKgh/y1HuHIOj9xzo1AO0C0yFrK7vB
         AjRIBEw0x2ZQjD5B9XeyQUFS3dM5HXsddb8lLZIqKtdlleyg2wBpdbQ/ff5I+gQbhH+n
         Eu7w+uGtSBFTFwLTI3A63Uf9naNtHNznbXew5dYfCym7oZVBZUaLJqIt9k9wOHfYWLhs
         ySCw87wjnMaRqixrKIn4F55ymsh66NCywuKOFXhBnLXTU7jZvvTuOg63Jg0xwV8VZsMi
         IifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728911124; x=1729515924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZGlh0BgvTZR8tIX7xtvnBBKKfSil7mION4lorOOPKtI=;
        b=ZaKakG9sB7T5w1g6B2SGUd5bhJrgB1hGHWEkbP7pTwBqPXYLizSS3i/tRrLzhUa/3a
         SEOeK/QKEK+o12/a41b5IpaZa7mkQlbkoHGb8G/yCh6ZOBs8YHm0asODjtC6L0xrlvRo
         86ZD/lu6PPse72Yje0LtPDYn3zTMO5Pyr5dV9broWpCQPQxnxWjPSie5TpDxwcphA6Oy
         ++IUVLF4U2xR49gPogNcYx73C4wbdPuRNabfNjLQZVvde+J60tGOOIEFcIr5QvgnLssl
         0BUAvcs4o7hHeHW3ML1OnxblG1GQ3Fvwbo4Wfaf7mK1WehUeV6HKs8D4VS2xSbL+gF3l
         qnNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbSeqxxEKB5OJjmzgQizqfXXpsi/t8dwY9LwDzOiuqii8ZAB0bP9GEONqSpaKjduYebONZxXwvLGvTRAII@vger.kernel.org, AJvYcCXg/UafdJDsoil9zm/KUannIdTQVj5vQ9JsR/3r07bXWJ3hEvSK1hWEJbagD5TCs0L/ifC9++LDrI1Q@vger.kernel.org
X-Gm-Message-State: AOJu0YxPHqsKMrRu7DFeMdgAUkis5OLES7EYiGdQOobWgJp8aHn/XVy7
	855aoAdNovC7MoLdxpkyVn598p7GlroODdb399YnSAppA/5hrJqdk1P0zA==
X-Google-Smtp-Source: AGHT+IEw0JzL9xW52CWdKReVPk7XaqJtW2zlmIH169YR4ezzpMVjef4ADH7DzHGMB2cI0N4U2/hHuA==
X-Received: by 2002:a05:600c:138a:b0:42c:b74c:d8c3 with SMTP id 5b1f17b1804b1-4311df5c5b0mr113874325e9.32.1728911123845;
        Mon, 14 Oct 2024 06:05:23 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b79fa3bsm11367193f8f.78.2024.10.14.06.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 06:05:22 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] ACPI: pfr_telemetry: remove redundant error check on ret
Date: Mon, 14 Oct 2024 14:05:22 +0100
Message-Id: <20241014130522.1986428-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable ret is initialized to zero and a littler later in
the PFRT_LOG_IOC_GET_INFO case of a switch statement is being checked
for negative error value. Since ret has not been re-assigned since
the initialization ret can never be less than zero so the check is
redundant and can be removed. Remove it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/acpi/pfr_telemetry.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/acpi/pfr_telemetry.c b/drivers/acpi/pfr_telemetry.c
index 998264a7333d..a32798787ed9 100644
--- a/drivers/acpi/pfr_telemetry.c
+++ b/drivers/acpi/pfr_telemetry.c
@@ -272,9 +272,6 @@ static long pfrt_log_ioctl(struct file *file, unsigned int cmd, unsigned long ar
 
 	case PFRT_LOG_IOC_GET_INFO:
 		info.log_level = get_pfrt_log_level(pfrt_log_dev);
-		if (ret < 0)
-			return ret;
-
 		info.log_type = pfrt_log_dev->info.log_type;
 		info.log_revid = pfrt_log_dev->info.log_revid;
 		if (copy_to_user(p, &info, sizeof(info)))
-- 
2.39.5


