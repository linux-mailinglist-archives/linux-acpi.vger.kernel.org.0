Return-Path: <linux-acpi+bounces-15369-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F26BB137CE
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Jul 2025 11:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A44317B14F
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Jul 2025 09:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143C1257448;
	Mon, 28 Jul 2025 09:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="pdGxB5gR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936D42571B0
	for <linux-acpi@vger.kernel.org>; Mon, 28 Jul 2025 09:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753695719; cv=none; b=Js+2IORWXPS9H+fYUz5tUXVsPX5WJyAlCrrtOAZcv27QH2N+wJCMbFjPZOVfwGEKXRd7i0cwFLBYt+t0dQ8aG2evNwjYwL8g1aaYunXwNOxtC9bV2h/JFawQRQEA8XPUJFr6KtA8ZDzavxwKfrJWZxObAjSNT9YHPH99PgVFTEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753695719; c=relaxed/simple;
	bh=UBn+LBjax9N4GZfXPTV/0yYRe68OpjEpS5e1cFYqyMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WeaZRtGtCyXk6qstdhHtWRkyTXffJpt8lPZJgZo88fgd9VwHse9Alhs5pGtKyVR5A03+ehsH50e2jA1HdOucru+lRvcpQhUM+pUJeI7NIiqS7dBcZDRkUedFLshNXRIu89tvmjXhEMtxiDpWy3EyaNkZJMR33QLoqrOIdTC9xmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=pdGxB5gR; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-31ecd1f0e71so1119194a91.3
        for <linux-acpi@vger.kernel.org>; Mon, 28 Jul 2025 02:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1753695717; x=1754300517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bl+ki3sYBLOuIZdWtmik+PFOlIYEBNco4Pu8AxHtczE=;
        b=pdGxB5gRGieuRvZWCt29dPB1O0Jf+tlDaCev7xheqXIIQ4I5aA5bxaJJYiTksK0n93
         tYUMJLKbr5vzHSfvv0gFaaWC9SYDijzHPLMRUfx2vs1IV4h7FmneolltaXCFke9UKOq+
         wm2ukSmrfup/7Kixt1nu8JL/MhGkMKOLJCME7PYfXFlcDPj+9uwgM+bXJyp8G1IiOxVf
         qDhQl0sWZ29rmwB34oOAwPj8XJtJIpJTLSJk++q3EElKh08XUSI1DNesPuG0FUFoL1kS
         9u96avgYv2i1vrzpCwP7zMEi5CvipdmAYWsHSTYvS4hd5g52mIxuCVi0DQhS+3yOkr+A
         615g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753695717; x=1754300517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bl+ki3sYBLOuIZdWtmik+PFOlIYEBNco4Pu8AxHtczE=;
        b=N5pqTZwCiEH5FDfk3hGpCgdI997mdBSjZcUYe6jyrlu+hvjcVc7FXqROD2aiLNLDqG
         htSRM1meRsyxllAyGaw3HjF0H3RS5Hk6xm1TMFjkYmwqy4ZWBy3jmlkIOPH/j8OROYls
         ueXJ8Xb6CgbKMhHZLGsGcZ1W7YbEdH3tUU9gdg74NdIro59zmzJhREVuH58KP44ZSNh/
         bN5I0CvR90u0x8ef2T1UXoE+lgZhFfY/Fn4JENy9qzJ+tp9uezexkv0Bf/ruh4sfetmS
         5nH2bJH/fq3CzcfOcoWO9VCARnbXfpqwOWSTHz19k+tvnlzDpBjRW35qqmXl/Tp9SuvD
         ZWpw==
X-Forwarded-Encrypted: i=1; AJvYcCW0HcHrIFZiQ+nIzduk/mQqeS1d2doPiNU0sbaBdtc/JZblxVAVvj8bHzHdjIygrAH1BqsuHIX1N+J9@vger.kernel.org
X-Gm-Message-State: AOJu0YxnH7z7SxB0ihZF1up7X0wYyrnSFIx5QBJpqi3CFSuiYudFnvWG
	Yg7vcb/C70aiR2wnXCatiPZcpBZvCItHRyNSxxTNiPrJi4Wpvwr95ZAstUHjvuRoVq8=
X-Gm-Gg: ASbGnctA4WIS+GjNhLYk+OPteudRHsV/hcBqQ8QrthFJWJiBySMjwFK+pYMh++WVCpE
	pWV+Iz6Q+HJFIAs/Fngi+vSt+P7QhEZiBcdGfZTB6xITwKqpcD332A3i3JG+yhQ/rXoFSxB2IBw
	bk2UA50I4JXIGA792qbiVpSDd09owxw/pFnoFJPDbDf7QLf5TuU7cUVGEZsC2RzzXsdzZdvt2ga
	dIgB/s5COKtj8bRa0LOTLLocxCmoXEHukY/QEjc+Jl7xfLxWvXIQJv1XXx+ESMOtvQfqDH7JId9
	oFWTujOKdogfWEpZ7ZNgc7Gpteo8Qk+clEAT7sl8K2qUyNz4oMpOzoUhlFYWOUKMWHSznVOh9Hm
	aZbJ8NLagXFnMljL2tiBNQulBQBrgRYu/wWNqjzrnSiLAAwTfzIyJkxpzg1wj
X-Google-Smtp-Source: AGHT+IFhFTqPuSSTK3+8jxndNiXraAgvrolPYd24EgLuqZVd3xcphyV7/2XKTMQF8DKsWkxQNVZhAQ==
X-Received: by 2002:a17:90b:4f43:b0:31f:7b7:4070 with SMTP id 98e67ed59e1d1-31f07b7416amr1816333a91.25.1753695716661;
        Mon, 28 Jul 2025 02:41:56 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([122.171.19.28])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e832fbf99sm5396230a91.1.2025.07.28.02.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 02:41:56 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Len Brown <lenb@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Rahul Pathak <rpathak@ventanamicro.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v9 06/24] byteorder: Add memcpy_to_le32() and memcpy_from_le32()
Date: Mon, 28 Jul 2025 15:10:14 +0530
Message-ID: <20250728094032.63545-7-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250728094032.63545-1-apatel@ventanamicro.com>
References: <20250728094032.63545-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add common memcpy APIs for copying u32 array to/from __le32 array.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 include/linux/byteorder/generic.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/byteorder/generic.h b/include/linux/byteorder/generic.h
index c9a4c96c9943..b3705e8bbe2b 100644
--- a/include/linux/byteorder/generic.h
+++ b/include/linux/byteorder/generic.h
@@ -173,6 +173,22 @@ static inline void cpu_to_le32_array(u32 *buf, unsigned int words)
 	}
 }
 
+static inline void memcpy_from_le32(u32 *dst, const __le32 *src, size_t words)
+{
+	size_t i;
+
+	for (i = 0; i < words; i++)
+		dst[i] = le32_to_cpu(src[i]);
+}
+
+static inline void memcpy_to_le32(__le32 *dst, const u32 *src, size_t words)
+{
+	size_t i;
+
+	for (i = 0; i < words; i++)
+		dst[i] = cpu_to_le32(src[i]);
+}
+
 static inline void be16_add_cpu(__be16 *var, u16 val)
 {
 	*var = cpu_to_be16(be16_to_cpu(*var) + val);
-- 
2.43.0


