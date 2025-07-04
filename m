Return-Path: <linux-acpi+bounces-15010-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D74AF88CE
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jul 2025 09:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5709586800
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jul 2025 07:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514A3280303;
	Fri,  4 Jul 2025 07:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="nPKIBTF0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2BC27FB29
	for <linux-acpi@vger.kernel.org>; Fri,  4 Jul 2025 07:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751612890; cv=none; b=bh+FyVi7xbG/xgUkt74hNpgm+ZEF9wIl8Zs5mI0qAvHSSbQykjyDUJF0L1G06sOUB7H6g5DlxrDPPuwBsmAGQUZ+fYB/XjMq+fimZFhaKbO7I8mR9aK4QjBUXJRACg08/fZsnQDjtCg01ob2J6/4x0cbJNsdCcluEYJMWMQLrsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751612890; c=relaxed/simple;
	bh=bbsKQgQKotFffImznTiHFRZUkpn3l2AEmmz1a9sty/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PK2DM5f6I7sd303km7UKEJSmkRmxx422G/170b0JiV8jD33YlLpk+aUcv58weEc/RchY5/IPZvSAxEO7UpxJDKS4KYu70QDYvzlrBUb/FGSuSqep2c5noh4T9yNvsgUqm/ogncqCZzjslxfmaVQUwnV+rC6Dg6WJAob6oA/PloY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=nPKIBTF0; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-313bb9b2f5bso771129a91.3
        for <linux-acpi@vger.kernel.org>; Fri, 04 Jul 2025 00:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1751612887; x=1752217687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFaQ5Zs1hbK8MQOtKnNrpZ/cBeXTMcFHCuSD6j9WtSo=;
        b=nPKIBTF0AK+/1HHoTW+QCGP18nXWXDLUIA9nglN/twuOKc5qKK6669ADY6e8XQfppB
         8oBEqnvbVxtwDWumfi3pJgwBPf7orNb8cKTyoUUQLsinu4DEACYhWsNei5SQEag97w+Y
         FPsM8toAFQPdVQnGO+/EptIvT+Qbu7Dwlzoujf00OyIxc+zFhlrzT+uX44XHSJjLMGu+
         wmrGk7YzjOng0HY+nY6+88eej74P3uB6aTMPZKPFnSCMBXBgYp4hoG3NIOKfIV0wemV4
         JCZtB4JvXHaTU6oHmrKg/9b5uy0bkn5QkySpFgv0nCdWi6iz6duF91Id+OID4XET5yt7
         7k3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751612887; x=1752217687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qFaQ5Zs1hbK8MQOtKnNrpZ/cBeXTMcFHCuSD6j9WtSo=;
        b=u815WZ1eNxx0BROxvOyiYvlrjAoYFgVEbcWglKAST7jCy/+0op+eW1AU3hkRs+Q000
         Mi5g08bUlRj3BmxbEoJghTd9rb4mZA71WtJmqLoDqZ61OAUEkf8Q/fGP0vQU/lhHmAFy
         ywaKwtFUiHOuLVPtNYc59V8g0ccIxeopiFugAiNQ9Rr/iV5S7A5hupTn4yHikejnvdu7
         qW1jSgH5L+e5WTsP+2p0psuriIvwcMDWNPz6W14pkFwu1LgE/zRN47BcwPk3KLxTzAEE
         8kSrqqwtOg99jI6b1B/CU/e5Fh4hAhtD4bUqkjJO+WUjBKpJO5x90DSHegTiELGL59SI
         8ubQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6gGWmEgkl2RUZ4pt3bmjidUOfqnpBZuGkrM19E9RMVmlA+4SQUEE8w2saJ8jg5scpWjsidlpbL/pa@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4GkJ2HuZj5sysP0Vzx78DVHrKLPgYjq9oWMabxsib2iEQMI60
	EDxKH9i4sstgyCWiyH5A0dcLWEUSvgxn12+yJq0ZPhPvPAjiAWG0HPbh0B3KIW5AiiM=
X-Gm-Gg: ASbGnculxs0Knkc8OtaSCBRyyRl8mkX0aHM7Mbw7w//rBhh5yrYhoGFh6KqYF3QpNq6
	7Y0PZpPRo3jcC+VcObSwZrwUGrNv9YZHGp38ZVF3RKeA/FacD7THvoIMutNHe6wyLU1S8tpYjGV
	YtxSJzjG7pNsXbxZBSEgVdigfeiIPZFqabwF6z4SOvt0qWbjri7fxkq28+VEMLBAZRJ4Kes8o83
	Q/4hVRPRMIHaM4RsroIgkmtt8nbyBX9rYLWr4eadL4kDlvrgbz3ujR8JYLlJeY2e4F+GybEf3V/
	coRcpzH0vzRMCfXBPFuQrIqcQP4dPj2QwgGSgpdAXzWRNaFCialttSqLsX4f3u5rc+MTGLIEXJ6
	HLjtSj+sjFhOI9AVQIgn00JcilZcZSXEUE3Ps
X-Google-Smtp-Source: AGHT+IF0zc2Duk30cC4boPPLQkPLExP0m0SOo91oiLUKWYjOgmAFhVPRmIXRhh+FnhO03cSYBVMJxg==
X-Received: by 2002:a17:90b:54d0:b0:313:d6ce:6c6e with SMTP id 98e67ed59e1d1-31aac449e2bmr2377250a91.8.1751612886401;
        Fri, 04 Jul 2025 00:08:06 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.166.196])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31aaae59a93sm1358697a91.12.2025.07.04.00.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 00:08:05 -0700 (PDT)
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
Subject: [PATCH v8 20/24] irqchip/irq-riscv-imsic-early: Export imsic_acpi_get_fwnode()
Date: Fri,  4 Jul 2025 12:33:52 +0530
Message-ID: <20250704070356.1683992-21-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704070356.1683992-1-apatel@ventanamicro.com>
References: <20250704070356.1683992-1-apatel@ventanamicro.com>
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


