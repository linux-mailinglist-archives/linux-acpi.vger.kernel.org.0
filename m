Return-Path: <linux-acpi+bounces-15006-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F66AF88BA
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jul 2025 09:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB8BB176FC3
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jul 2025 07:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED182797A9;
	Fri,  4 Jul 2025 07:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Umh9KFfY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0751279787
	for <linux-acpi@vger.kernel.org>; Fri,  4 Jul 2025 07:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751612843; cv=none; b=NyTz8ircZu6dExQbd1hJyewmjERcGGl/Z8BdwjaM5TH5x7LGwhD5E1gqENUZ4vmabCf2Z9Ny5R6OBrTrgfZykq0f+hL9hqmhoKNMU56DuxCOhxaRHX/fgUtIpNgl8iaMaXO9UM8XyzIRrv7MJtfshdKukGHzO2tPT7T2k8rXPHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751612843; c=relaxed/simple;
	bh=kOJ0GefeAd9UEbFEyV014zsaaRwCNdDHSJBAudKVMFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bKQrmBXE+FnE6sKzPkny3FXM7DjXCt+pb4xRU3OEp/PODzYKW5uIyBU2QC4NnRsqtOw27TIkuzIE3SenIjwWM/Wcjy5pYEFq2H9EgsA4z5xLyYIRi/2lGdlEqYGSCQNlQQlHcLeXSLJSvDZ91nMw98+8QRJQv4qgZGWjlxsfU3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Umh9KFfY; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7fd35b301bdso657726a12.2
        for <linux-acpi@vger.kernel.org>; Fri, 04 Jul 2025 00:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1751612841; x=1752217641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQx4DIh4Piuq7HhjaN41eXcQRyGY2O2ucSjN2pwnllI=;
        b=Umh9KFfYnNsJyzELZ24DHzss3F7/qLLiZUELYJVHgzLonLaH3xl04FQ43oTy7NjUiE
         P/BkrTLzWf4Vd6Xz5kSgJIrByDLd3f1V9vCb68nk//4wP0OBx73/9m5tisKEKRWqSD7s
         i9aKnCL33bD60rKu2AeQ8l67e+758M3jXJwP9YisMazYAJhX+744fBkZshwxViX6LmZy
         LeVJIHh8iFGYsOVoHjZGBGRdJW6C/3tr7FtPT9+xVciQAndU61DWCkgmkSFvC5uuqR1s
         +7xQP8yY1LdEUxsUshLbibqKrfFI3lNY5/yU3uGCnoixMOe+rh0Q1DnyaWK49fybSsrA
         vMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751612841; x=1752217641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RQx4DIh4Piuq7HhjaN41eXcQRyGY2O2ucSjN2pwnllI=;
        b=FFAybcAKtdPZPJeKzb16Rc6peTCk+VYih8s1JAETn3vtegsmGZW25V1Fm21xELT5Nm
         Q1AGmQKG6H//lOU39VHNodxOPPAD5WFo+oc84GHGVjhPg1Aog0Sx5NEBY1LNX1px90pg
         DYMSbzk4mv+TXjygMcPTEX1o/JOninXKxOKNu8hxrdlqkfBjya7l5hSbJtjcovJZqvob
         soIRAv5Js7x5DyGSJ/BlUTF4MyOB3H+qRIvN6+USjjrj/GC2ncjAOvlSLuOH4/ygNUqa
         wPOhUuXvBW/twbhGqimsrF3Klg+iGve/z+6EMnQPPBAUTupHATHG3D9oOXUOdYuij2lE
         ICEA==
X-Forwarded-Encrypted: i=1; AJvYcCWjTj0RkQB2bQwVYxj55v6Oj5fVmpkULU+FQhesUgMLdVw+0QGbGm39TcAhcN3tZdazfdlDbzXUrTcz@vger.kernel.org
X-Gm-Message-State: AOJu0YxBMxx+kiJOY0wYAj/50Q0/fdqNbV7THuz3iYonTvcViW+/T+Kt
	m/k6dUTQ1VNYNN+ZBpMLeFmVNFwQemmoWlY2J6MuM4B4AFwjJf+S0gU9IzBngLL/WpI=
X-Gm-Gg: ASbGncv8NYZTZC+C1ay1MbcoLDWhxRckibd/4NMDBuDiDD1H5PieuW9WTBz6UqXFAHs
	uOJymls8jTgKU+iSeUtVN5oPi31sr/KQZeMk4tuoiv47AAIfm8GjY2OwWVWTX91Cpl/Nuddx++C
	68kaz5LBGqNc609f3bDxaAvxk2bzLUROnadonkmyLynxmjVPsRU6ynxQG0eAiEoGP4isqa1OPNM
	sJosUvFVvJCJS6aiRO5nDsSDH5iegakC0iqCn3nXw6v4I+BEufiFtE0HAZb71uYPGpkwbpvAqgk
	Dw3v2Nt1d4qtPIztEq1NQql/IuPB0sQF/cFtepOrlXT9avXpazB0yD/aZJATrh3KcvTHaQ/kyLk
	uS4/sn8tW8ZKq18sz+8Ux/GCoig==
X-Google-Smtp-Source: AGHT+IE8RuxxpKedqzy+uzoXVkR8qJBvZDITw6LQzH2d5wo1aXkwsTRyqrE+z4geahCSOD3aMg/Q4Q==
X-Received: by 2002:a17:90b:2245:b0:312:959:dc4d with SMTP id 98e67ed59e1d1-31aac43290dmr2637314a91.7.1751612840937;
        Fri, 04 Jul 2025 00:07:20 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.166.196])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31aaae59a93sm1358697a91.12.2025.07.04.00.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 00:07:20 -0700 (PDT)
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
	Atish Patra <atishp@rivosinc.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v8 16/24] ACPI: scan: Update honor list for RPMI System MSI
Date: Fri,  4 Jul 2025 12:33:48 +0530
Message-ID: <20250704070356.1683992-17-apatel@ventanamicro.com>
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

The RPMI System MSI interrupt controller (just like PLIC and APLIC)
needs to probed prior to devices like GED which use interrupts provided
by it. Also, it has dependency on the SBI MPXY mailbox device.

Add HIDs of RPMI System MSI and SBI MPXY mailbox devices to the honor
list so that those dependencies are handled.

Reviewed-by: Atish Patra <atishp@rivosinc.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/acpi/scan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index fb1fe9f3b1a3..54181b03b345 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -858,6 +858,8 @@ static const char * const acpi_honor_dep_ids[] = {
 	"INTC10CF", /* IVSC (MTL) driver must be loaded to allow i2c access to camera sensors */
 	"RSCV0001", /* RISC-V PLIC */
 	"RSCV0002", /* RISC-V APLIC */
+	"RSCV0005", /* RISC-V SBI MPXY MBOX */
+	"RSCV0006", /* RISC-V RPMI SYSMSI */
 	"PNP0C0F",  /* PCI Link Device */
 	NULL
 };
-- 
2.43.0


