Return-Path: <linux-acpi+bounces-11546-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A361A47DE6
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 13:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2D651893189
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 12:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658F322E419;
	Thu, 27 Feb 2025 12:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="brhJ3G17"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3F722E011
	for <linux-acpi@vger.kernel.org>; Thu, 27 Feb 2025 12:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740659816; cv=none; b=tZQEofAGMKX1JH126RVLcpy/rsZDIUFaAI/xYKDqI56R5gzLXMnRGfASHVvqS5c5sQa906PzZ3X48V3k7OFva7YNJAZHGaW7xTJ3yyA1R9ltL0qCR0EKP113bCXGdFjdnzon4cdfkL6avtivboLT+kGV+irKX69saVSU1IbFbXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740659816; c=relaxed/simple;
	bh=67ls/POKUjWPQj872a0gGQ9pTH69yGPYjMpXWSU47vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fs+n8Q+ZMFweiuLUdTXaR2UespPzLh74dIr+H+V0D3gmgx6LP+wqTuEL4zXvyfG4rUILXaANeitwHKahVnl+zl1pqwMNKVX1NYKas83lB1Qe6rXLsUa249t2stQJth7ceQxE9PtnG92nAp3iaRHLZOWwSixrc4rbZGjWlVXxVic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=brhJ3G17; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-223594b3c6dso7029645ad.2
        for <linux-acpi@vger.kernel.org>; Thu, 27 Feb 2025 04:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1740659814; x=1741264614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9tq9UU0quHGMxFhwTeHcsfn2hmcgfg1pwu61qXDOW4=;
        b=brhJ3G17yPJnnjGQzqGegbVp8BYquOSnTZC6Fvu2VbWhQfLlhaIr9k5gsN6BZfSzRC
         Rt8IyBKBeRpvhrrrNgImwQNS5WJg0qPiRxHSd+4IDNgMI6seFqJAvmp5u8RuLmXYuM9v
         jn8Dj045c+sKMNJVHYdNafDeFAQ8ebLCM969WMa4OOjpEuvYqj2xSlRsAisVSw1ndFLK
         Z9Qt5J8FLbR2DLN94wNnIDVxT/meE97dsqiN8TZIbHIabLYr65EILamnCumiB6ONGg4M
         +K6oT2aZq9ruFhFHcIuq3KkFwT9J3n9IUR2cic2X5F36R3s7lEOBtxv3EUqYSGdTnRLS
         VOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740659814; x=1741264614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9tq9UU0quHGMxFhwTeHcsfn2hmcgfg1pwu61qXDOW4=;
        b=ZDfKH1zTOgV013PDXssFdEWXJHhP8OwHReRnhNFaiBpIsJQFX3UxCJQDE/gteNwkTj
         DvwYPcyy1W4YVe21ajUe4H+UH3m+T9pq0cZv2yjQyeq3DnsUOAJeaVAMvA50JtwE0eQu
         Oh7+9Du1/2g9uhWP6701knZRWGpPKi5eX6RAqH4ZHoQYBIk9qeey93ZRdgEhsP9jENQh
         oCZvc/3xfawRa3unyrNHubGCc8rqf54HP0ahaPPeOOc/mY8tdnCMmTKL6EfnBrFV1DV8
         bsBImDSYtSoi4ozF+I84eyoGBhlIOcTZFeqDmmMPCuZ/gx8c99fjc4FiFIqzwcFaMW7X
         n3kQ==
X-Forwarded-Encrypted: i=1; AJvYcCU23C05aD69AbzypUsMv/0Cl0dIbHrCvwI766syLA1NNnd6bbPod5125UJey2XPKQFUNBwXJ+ATewG9@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4ry74w3qaIwfjnjZQ7/Ge6mDFlldI+LVJHmP9eWS53b5eBudU
	GO8uw1YLVxzvvQY+WqKOJ4SAaMNaRiimaW7ji9uRE8rIzGGCyFqdGocRCnLwd7o=
X-Gm-Gg: ASbGncuo42vIDEuUP+2sETIaL0tp2QMky5Hv3jCJljJxqnGCe4w4yjNlC53VgMAVh5H
	gax7PElZ6+d8O1WirMDDdSIf2LlU44YCdZy3ZUc8wZTztmQWWI8X6HgQgdK12nCk+hZWE+zlYw8
	t6+gbX9cJErRUhQzhnADFAlGs9VWZS0enlqNvSVcvTzRYwaTSUUQu4GSoN6vUQgl73BAEzveOgg
	rq53YHmrj/dOUcQ4PJ/EqT7XwG4tNYhNsflZlJS8pm+FFI+bZelhOAQw3rf+lqGKFjKh1ag0HdW
	+xui6xkTJS8W18Ov7QL4pJW6ywT8576LLoHf
X-Google-Smtp-Source: AGHT+IHVfqxszUaYFM69ostPnakgkazkeqpkl6j+lHgInhnZ+gtwN2tclnkImUVqCbY1mWtl7iGV3Q==
X-Received: by 2002:a17:903:22c2:b0:21f:55e:ed71 with SMTP id d9443c01a7336-22307b45598mr186650025ad.5.1740659814323;
        Thu, 27 Feb 2025 04:36:54 -0800 (PST)
Received: from ventana-bhyve.. ([49.37.249.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5bddsm13219135ad.140.2025.02.27.04.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:36:54 -0800 (PST)
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-efi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	ardb@kernel.org,
	conor@kernel.org,
	cleger@rivosinc.com,
	robert.moore@intel.com,
	sunilvl@ventanamicro.com,
	apatel@ventanamicro.com,
	Himanshu Chauhan <hchauhan@ventanamicro.com>
Subject: [RFC PATCH v1 03/10] acpi: Introduce SSE in HEST notification types
Date: Thu, 27 Feb 2025 18:06:21 +0530
Message-ID: <20250227123628.2931490-4-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227123628.2931490-1-hchauhan@ventanamicro.com>
References: <20250227123628.2931490-1-hchauhan@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new HEST notification type for RISC-V SSE events.
The GHES entry's notification structure contains the notification
to be used for a given error source. For error sources delivering
events over SSE, it should contain the new SSE notification type.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 include/acpi/actbl1.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 387fc821703a..df577bf25423 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1515,7 +1515,8 @@ enum acpi_hest_notify_types {
 	ACPI_HEST_NOTIFY_SEI = 9,	/* ACPI 6.1 */
 	ACPI_HEST_NOTIFY_GSIV = 10,	/* ACPI 6.1 */
 	ACPI_HEST_NOTIFY_SOFTWARE_DELEGATED = 11,	/* ACPI 6.2 */
-	ACPI_HEST_NOTIFY_RESERVED = 12	/* 12 and greater are reserved */
+	ACPI_HEST_NOTIFY_SSE = 12, /* RISCV SSE */
+	ACPI_HEST_NOTIFY_RESERVED = 13	/* 13 and greater are reserved */
 };
 
 /* Values for config_write_enable bitfield above */
-- 
2.43.0


