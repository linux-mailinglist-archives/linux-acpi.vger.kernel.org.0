Return-Path: <linux-acpi+bounces-15383-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF10B13821
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Jul 2025 11:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 833EA17CBF3
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Jul 2025 09:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8847A25B31D;
	Mon, 28 Jul 2025 09:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="gP4I7XvQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF2F25B301
	for <linux-acpi@vger.kernel.org>; Mon, 28 Jul 2025 09:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753695856; cv=none; b=iQDOK3TmeVMc+bNfjUP760UOnyw+5d4+HnwVdZUkPRZeUwvzhyX9ep1+8dvOx4BqcBgByfaaBV5Y+hWCF/D7PVhf4URC2i5KEgvEyuH0Wwc8WQKkf3F4cwkZxUwEYXJSmScZugHXIqVe4UlJ/syoUqzWrOUM1M8RK2WTgWVr5y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753695856; c=relaxed/simple;
	bh=bbsKQgQKotFffImznTiHFRZUkpn3l2AEmmz1a9sty/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ekLGP3pfaUiY04GnBdt6j57mcDWqrczn+V4hEnivjGJBOBKwHrgcyCm42IPGHBoSqgKjR8KkaqtP/ue4Lp8GZaean57sToXwaPU4XG5eUJX0nhs4vVLL8xup7TxqCJQUrJNEG1SbgzFhirLy0njGRfo4wLqu8cuzOXL6Uil0+wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=gP4I7XvQ; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b1fd59851baso3025060a12.0
        for <linux-acpi@vger.kernel.org>; Mon, 28 Jul 2025 02:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1753695854; x=1754300654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFaQ5Zs1hbK8MQOtKnNrpZ/cBeXTMcFHCuSD6j9WtSo=;
        b=gP4I7XvQ+Bqvb+O3aq7hyYQoVV5k6T9ebotn/XW3TQz107FxUmcUBRzkh1Daw0vLl9
         shgNROMHlWT8V13jlEriHrMiPQSm2j94XFZirEwtVz8l9HghNyHlhEC0e5OCKJWa7tsR
         LKalf8bhD1FFWAjU90CsxDbsuNkLe243DEfJvZSGm4my6vzsojvtHjlKwmOZf8h2wem0
         6i14vxKri2gUdR6cKxIwoj5vPppeAi1SJQiFqz9n3va0owuQ2h71I3W3874ZZVm4BBc9
         HdEBigcM3bm3D5pn1ZG+AFj9XwAD7QPX0CpSklnIcWpv/ocGwgooN9B5SqLWcXVNMKCi
         KplQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753695854; x=1754300654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qFaQ5Zs1hbK8MQOtKnNrpZ/cBeXTMcFHCuSD6j9WtSo=;
        b=c9HGoHveXcV0Rl2lNcPXCunrZ1RyRlRlVCeUJY4YFn6VTplTO6tPtqoIFF5ogtEGZJ
         yaT9cWax8O+DMcMi5jG/NxenRpnmfSXo+eX/oM7Jyyc8QmEmzoxPwbPfiEKwSLxGSTl/
         Hrc3iRTv7r9Soys89sCuOw7spc6+Qd6DzKcVlQVrcDFWciXlXaz4Nia1sdXWDEDlhxek
         1wQBE28uGYgNWu4ZwHrhD0adpH3Gr7W+ph16MXOvO9sTGzjYsS+3LrSAcK87xPCa7X1c
         FX5o6onuRpfZhHT0pTShh6xK4bnLPcYT24W8+bd9YGMduEq2s68iBa2waGr3R/Ymd4rK
         kAJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLlJodas8wSs170xsJjpCt14gvYdynIX6br2kAGpmfadcqF4UEFWGvYYB6OBSiLXy0ERpW3AeGWQSX@vger.kernel.org
X-Gm-Message-State: AOJu0YwHaWuJGVFRQQw4Nwo6PsctPg5LgOzpMLSImgSkyTusw0l61ouE
	NnfMuE8EWh/qCb1iNtFrn0eTNYy4yuRnPjjc3j43wbHTStkDDfxOZPTHMWUnDJf2lmE=
X-Gm-Gg: ASbGncusBDWqhRkV8N5HMlNoE5ViaX4YgTNbNrmEF2beGbcWMz7RKneicA1wY9VigkS
	RBxLpTJnLp/Daf5HhRte28JfTt7cZ2cQF+GZHHaUOmGLPZM8ZnTzyuUH4YCgxWIBIMYlHZ4B0fO
	pSZ17DujCbZihatVJeTwelkJwcVubdJ6qy8mwTxAGnVwFgoVJPFUHWo/6jUpEoMmOJdL7NxpfPb
	UIS8SOJFmHkHdvlAZy7wYX/eSTeo95+9LaYHW8RNBIIKBOmJDfGiurUX4JdU4LmWPFQvPY+FAdz
	0FgjI/wWHxmYCWQ+JvIysz1K2Oepl8tmwOMhmzCEVrQmKjLdwc6pcc4ZccYVhYDlSZVjMoCQ2N1
	4OsXWZMo8r3NLBPQQvcCJ+WZUj3KPd+pvIyi3UATULR72MAVu1MAjFA51FPSY
X-Google-Smtp-Source: AGHT+IEfvIXwwRB8WyRBePKuANG8ztg+Nz4wcFNvlvu8SORbpxtGlBUAzzVaiaDoPOX1mWYxV1I/1Q==
X-Received: by 2002:a17:90b:35cb:b0:313:283e:e881 with SMTP id 98e67ed59e1d1-31e7785efe2mr17685144a91.11.1753695854107;
        Mon, 28 Jul 2025 02:44:14 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([122.171.19.28])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e832fbf99sm5396230a91.1.2025.07.28.02.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 02:44:13 -0700 (PDT)
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
Subject: [PATCH v9 20/24] irqchip/irq-riscv-imsic-early: Export imsic_acpi_get_fwnode()
Date: Mon, 28 Jul 2025 15:10:28 +0530
Message-ID: <20250728094032.63545-21-apatel@ventanamicro.com>
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
index d9ae87808651..1dbc41d7fe80 100644
--- a/drivers/irqchip/irq-riscv-imsic-early.c
+++ b/drivers/irqchip/irq-riscv-imsic-early.c
@@ -7,6 +7,7 @@
 #define pr_fmt(fmt) "riscv-imsic: " fmt
 #include <linux/acpi.h>
 #include <linux/cpu.h>
+#include <linux/export.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irq.h>
@@ -215,6 +216,7 @@ struct fwnode_handle *imsic_acpi_get_fwnode(struct device *dev)
 {
 	return imsic_acpi_fwnode;
 }
+EXPORT_SYMBOL_GPL(imsic_acpi_get_fwnode);
 
 static int __init imsic_early_acpi_init(union acpi_subtable_headers *header,
 					const unsigned long end)
-- 
2.43.0


