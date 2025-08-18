Return-Path: <linux-acpi+bounces-15779-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 966B5B29805
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 06:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B17C3ACBE4
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 04:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D08F26D4DA;
	Mon, 18 Aug 2025 04:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="f/muIKnc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14ADF264A9C
	for <linux-acpi@vger.kernel.org>; Mon, 18 Aug 2025 04:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755490372; cv=none; b=JCHmg6cAYsKUsqQZKnDAyPRcGyuWE90tC7HSasW8njxKFoErKYdvqXZIZf3fvoWLNVArJ/Fd2ZIlcp6Ak7fKQlq9ZlUF+0vy1BewWxq4aZaS2BRSpP9q5PrLyPdGNhz4iDZY5d2CyT3TkqSRthMvqj7ORE87YMtNd/ea0NfAMy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755490372; c=relaxed/simple;
	bh=rmp0C7txImCtQLNbB7l+5FEegOeoCIFY/QO5lS8kFpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nQhnSwFKZEkjD2B8gw9xfJhAnSiqrQEpv0BEk/1H2wkgOUsHVwJkejAS6YbHJJha3N0JJ42WtSxgQvuryXXEYHFzVPhNEyOFUvXsLq2vPOrTYjcJ9yGzIi4Hl250c2FtrCZXqkllppSKPhykKuq0mUCRKTzj1rmv6AvglfDeC9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=f/muIKnc; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-323267bc2eeso2572316a91.1
        for <linux-acpi@vger.kernel.org>; Sun, 17 Aug 2025 21:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755490370; x=1756095170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSO7EIKKecSXu2aYLs1QJ6fLwvTSI8gnzNqTWtwR7X8=;
        b=f/muIKncdv+8+MqViP76GMiDIwEkNn5v4o/bl7hIktLc3CB3iOfanexZ/7gz2A+ECI
         RTPTBD0F0gjYTkl/CW1qgZE7rj6tuQD/bWQt0aoa3SFeojCjQWdSV1tAuNjTZlhCYbjN
         ProQJhkQKvZqzAH1Oq9T31DQHvFVZBIt9RfdxThzDtX0dLQA3qinijADW+PEMeV1OaId
         ZLg1B4HyGlwhwQ4pqVCNuTKtYnUXoiwIDfoRF3Krd0NWX+uMOqSb/uAMldSOPfA7WaIi
         gVO6aj5oyPVJM9/C/pe4O4bM82pFV0bGIEyfcC2IEaPCk1QvI8e5N9PvtrkRwGm6cFA7
         nK9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755490370; x=1756095170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lSO7EIKKecSXu2aYLs1QJ6fLwvTSI8gnzNqTWtwR7X8=;
        b=BZ4T5NvGy2afc9ddAK3UubP//QYfBTiPWQRLo0qbfZ942ql7nMYfCRwTiMj48TWjmG
         7I3KmpTVGBvpjdCUS5Ugp4o+muBLXAUA3pmkdoPCK9TfuE0PwMWON12lqCRFfwWL5KIq
         IFm3X2LUw0wY5Pgn1QEDKwNUSe2ZYToWb0aLtu5EulGBy7+aLr+zB3Lgqecwq71WcHD8
         MhH5YcXT2Bd39Y1C402ZNhdY20QgNaFIyaQa8n/EN+dYKFoXKFBc4I0ptffwwoR227Fp
         EG3o8uFO1mTrRjdWbmyrYjYsUpUi2psXOnZ/RAkqvQXHGUq+OwvCMdrgnO3IW4oTVGOo
         X4FQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaLKuylNlEm/cfrgzp3+wdcq3P61ur8wsbvaX4ZgbwzdX5nqa+CdBDHVF1Emnu21kokabOUMikkJWu@vger.kernel.org
X-Gm-Message-State: AOJu0YxeiZZ/ZuxtKRbXlupiDw1rIzVbYPC99dlen1o8Nn3j0lM231qt
	e4prjq6hP+Xy9uQQ4vgWQplLzfC5d2z0HRary8sSuT9iY/id3MCHFzBckNVL48thmGs=
X-Gm-Gg: ASbGncuOM5uc+MLwAUbGHYVclk3Ma9KEmvQ09LU9eDYS2QLMsGwG2iRwFX8EX1VQOb3
	SYH02I+q76Ogn8HjN5jp9VIXqNLo6Pg+cdoDNp8iXuDr6E1fvyo6y1YDmjLl+qAROZKhQynhaV6
	VbH6RSkNkyD7HmrQZ87zLQqhtsQ/ZLXJUAdYK0ZD8bsjzgxzMIEcn1kgiIjEC7lmndvzPofHsxA
	C4SQxzAkWhkOn3eyXPCHNfcoJnoB/XHpSw89EmUCB8yXJjaWuFn+qcLB7pZBCGOtra65id/hlFt
	rYFXe4V0a/KkVa3UVfZiB+RQe3Z1PrJm7a0bmoDAaNqERqr5YFG4Fcjbi7H8sf9gqiAEcVXHNxa
	KuyelucUQGji2YIsPcpsjAoKAn2PFTkOm8WUFWeRLUq4c45naB3Wfw5QsACwh0RoJ
X-Google-Smtp-Source: AGHT+IExLgk4LFH6XvWJh2TlOkeN2K8sXn/NODhuvQLQVVN3l8PFGUqseotWWhf1jijDquDiamajVA==
X-Received: by 2002:a17:90b:55c4:b0:31f:30a6:56ff with SMTP id 98e67ed59e1d1-32342141f5bmr14558099a91.19.1755490370228;
        Sun, 17 Aug 2025 21:12:50 -0700 (PDT)
Received: from localhost.localdomain ([122.171.17.53])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32343c70356sm6560972a91.25.2025.08.17.21.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 21:12:49 -0700 (PDT)
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
Subject: [PATCH v10 20/24] irqchip/irq-riscv-imsic-early: Export imsic_acpi_get_fwnode()
Date: Mon, 18 Aug 2025 09:39:16 +0530
Message-ID: <20250818040920.272664-21-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818040920.272664-1-apatel@ventanamicro.com>
References: <20250818040920.272664-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sunil V L <sunilvl@ventanamicro.com>

ACPI based loadable drivers which need MSIs will also need
imsic_acpi_get_fwnode() to update the device MSI domain so
export this function.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/irqchip/irq-riscv-imsic-early.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-riscv-imsic-early.c b/drivers/irqchip/irq-riscv-imsic-early.c
index 2709cacf4855..2c4c682627b8 100644
--- a/drivers/irqchip/irq-riscv-imsic-early.c
+++ b/drivers/irqchip/irq-riscv-imsic-early.c
@@ -7,6 +7,7 @@
 #define pr_fmt(fmt) "riscv-imsic: " fmt
 #include <linux/acpi.h>
 #include <linux/cpu.h>
+#include <linux/export.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/io.h>
@@ -233,6 +234,7 @@ struct fwnode_handle *imsic_acpi_get_fwnode(struct device *dev)
 {
 	return imsic_acpi_fwnode;
 }
+EXPORT_SYMBOL_GPL(imsic_acpi_get_fwnode);
 
 static int __init imsic_early_acpi_init(union acpi_subtable_headers *header,
 					const unsigned long end)
-- 
2.43.0


