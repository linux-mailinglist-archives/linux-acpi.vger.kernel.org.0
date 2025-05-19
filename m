Return-Path: <linux-acpi+bounces-13791-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6BFABB564
	for <lists+linux-acpi@lfdr.de>; Mon, 19 May 2025 08:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8C06175086
	for <lists+linux-acpi@lfdr.de>; Mon, 19 May 2025 06:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6F42580EC;
	Mon, 19 May 2025 06:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XUGKM+Gh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14CE199939
	for <linux-acpi@vger.kernel.org>; Mon, 19 May 2025 06:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747637767; cv=none; b=CDSWizIN7BKMDsXGOtSGM/mUYOKDkE6fAixZ7haseTWHuV+y4ikMj8TJsKQLyXTaeYXgPFTfBz15xtgIw5n/pzaOS8ZA6w2hOqPJOOhplw6y7kQwM+s67aEqoUWO/ZPSvyb6p7hpBAURvejOkr2p6wxJHhwIrC0w6UjLXHo0CNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747637767; c=relaxed/simple;
	bh=8NDJ9XwjY+Hw9ef5xraaEJ2PXeEup+WOftekfr63tZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E6SqLbSOkeDbHcN4mW3moSL8leTCUDeZ2dRvXvehyDoANvLnChEjqC7djr4Ex3Y3SUOzpNiwBAxbfdYXBGfiM2TzEjDFDwfsR2lKzNhyI08IeAUjv/m4j1+q+CeQv5mKSEjt45CPZGeNUg9PpKKhttP+adJ9LMHa20Xn9QS23pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XUGKM+Gh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747637764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uoYFGf22vXFHYoBtKGUddYJzSMczRem5Rut6KCdwPLw=;
	b=XUGKM+GhAtkVQ7Ql5mwGIuUHpQSMJSfrdCOGt2b2/XIWv0kQm5eWzu0p4LPWlIyYANNVSK
	f6fEpFqlup23f14azLeESHUZMfiNUFQ5HH6oE5AA6pImd0LzBW3YYARYW15pZJtptxA6S4
	jaRWQs8713h7qsZcFxvsNOuG2BF8+ek=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-8p6SDhxqNb23kDMygscaJQ-1; Mon, 19 May 2025 02:56:02 -0400
X-MC-Unique: 8p6SDhxqNb23kDMygscaJQ-1
X-Mimecast-MFC-AGG-ID: 8p6SDhxqNb23kDMygscaJQ_1747637762
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ad55aac4ec6so121897666b.1
        for <linux-acpi@vger.kernel.org>; Sun, 18 May 2025 23:56:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747637761; x=1748242561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uoYFGf22vXFHYoBtKGUddYJzSMczRem5Rut6KCdwPLw=;
        b=czDiU/Q9s6s2A1eglkJ6Qkdlx7PJqfzQFXRQRXzOyHzx8gFof4m2WF5mbKg92skDHW
         BPUYkDANRCvAApimnCQu3kHM39lRO1qZP8dHa3PMcFNhypjScDrlamoaJ180vy0eSTvC
         IaLf+oIT2akC0AR48uWuuJ64E6Nx+FhgLgPvPnS39J0SnQbWqDPMn2mDvI+3sVTgXpcV
         LCNzTjptzekQiW+ZMTOJB6g3nTgIXFKXgxfiRPuHTeDZb11YIjGbUqUps2uoPAAM+khO
         hnT7QNF7xM4jwKKtkZ8yYzsT1yBsxtLKeuY3jLIR+UrrMwGmpkiwQHvV085nLM4B+j34
         RUmg==
X-Forwarded-Encrypted: i=1; AJvYcCVBhrDAQiFmMhNBGK0T5cvjDf4Z5CSCkaTfVK5RF7dHjVtCjZlZE3SgAamoSkCfg+Jvq6k+Wtg9m5TS@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm6WnvZESucLB7Bpm0PoS6PjllQkzwmYm1ioHL/VFDMbaqSo8g
	BM9XOoOmggci87Gve0SpBp5ttlXCsIPcY5QOHxAX3CYiTgOGS49y0a/pmNXCiUJ/H37oyziTUib
	4fS67FdFPxTUEIF8pHIZY0Tlo4Yk9C1STlQCz2GU5foWenYHRgWWB7V2ERpqbmAw=
X-Gm-Gg: ASbGncvRIhaAa/g4iFz847mvDxI80lHJTf9cYhTtnR0zWQCqwQaTrmgWqNh6nDDfoVY
	AdDr65FOOO7eqecmS7nPNGyfbD85G8IWbMsLdLrS3pq94VbZLM45pdmqCt7Z9F4uYtxH/DpnAPG
	EsgxAy1HVnj2kgZfq61MZRhdAD/yZbtMZqgKJnQrD88yux5amToteIX7Ck5p/31Vn3rk7zCGK5s
	+tN7+ZLwaynrSwTACEi5d+C1MKXg0Wj/QECSvAhtKkaTkBZdN8nl9BaFn2wxGHi2dT3KxnLMd8P
	kHs5CNzCLe6kzo8c601mEtyjoIRZFWbi+NvOQ0JwjPXovRDPlNWljGfhzGo=
X-Received: by 2002:a17:907:c21:b0:ad5:1b14:15f4 with SMTP id a640c23a62f3a-ad52fbfa34fmr875342266b.25.1747637761581;
        Sun, 18 May 2025 23:56:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6XDR4x7P+w+zNIdbiwaUD7ggLJDGBPXBLLoGw0L3zesxGdykirkJT0v+7+kEm5cfIYzsfNQ==
X-Received: by 2002:a17:907:c21:b0:ad5:1b14:15f4 with SMTP id a640c23a62f3a-ad52fbfa34fmr875341366b.25.1747637761232;
        Sun, 18 May 2025 23:56:01 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e01:ef00:bf5b:f273:a506:f71f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d441fb5sm549446566b.108.2025.05.18.23.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 23:56:00 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <westeri@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: adjust file entry in GPIO ACPI SUPPORT
Date: Mon, 19 May 2025 08:55:57 +0200
Message-ID: <20250519065557.659674-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit babb541af627 ("gpiolib: acpi: Move quirks to a separate file")
splits drivers/gpio/gpiolib-acpi.c into two files, gpiolib-acpi-core.c and
gpiolib-acpi-quirks.c, but misses to adjust the file entry in GPIO ACPI
SUPPORT.

Adjust the file entry after this splitting into the two files.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 20e07e61a148..c816f8e0572e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10273,7 +10273,7 @@ L:	linux-acpi@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-gpio-intel.git
 F:	Documentation/firmware-guide/acpi/gpio-properties.rst
-F:	drivers/gpio/gpiolib-acpi.c
+F:	drivers/gpio/gpiolib-acpi-*.c
 F:	drivers/gpio/gpiolib-acpi.h
 
 GPIO AGGREGATOR
-- 
2.49.0


