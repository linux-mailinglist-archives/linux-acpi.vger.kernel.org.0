Return-Path: <linux-acpi+bounces-5045-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DBF8A58A2
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Apr 2024 19:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B92EB23323
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Apr 2024 17:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFAA12AACC;
	Mon, 15 Apr 2024 17:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="hY85NLRH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE4412A179
	for <linux-acpi@vger.kernel.org>; Mon, 15 Apr 2024 17:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200608; cv=none; b=bKZ0dFV21yYsF8N+/h5s4XHp/PfNn/uuwnQW3XTnM1eK4jkeNpg/Rm1pNn7P8rKuyEgrW0+KU38+j8uDCAPjMdtytLS1QilB4cSeTRlIyboycIYOxgZuqdx8RkNe1I2AqiH0ZxeLHCLG2/DXo+R1Z1k8LFCC1JkJfpJGODOTtp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200608; c=relaxed/simple;
	bh=iq+zCwdn57VORSoLKgJUoBBIF3f6Y9IiyHLbSdDt+cg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dwoASCjHK96Gj2czDiL/rBXxaDA/Tr9mzkgNdWQ6++DcHHXTkutstRcOBvfPH6MmVwwLyczZuG9KFkcANbw7MfpanevTUOEJAdXP/yHI3JUbgIJGuSht4hT0T5wmeDUQyMjFbcvBrGjQmt2AuM7WeNR5sfScExcGdvyjOAtMUPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=hY85NLRH; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ece8991654so3184852b3a.3
        for <linux-acpi@vger.kernel.org>; Mon, 15 Apr 2024 10:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713200604; x=1713805404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tgBDpDYGQ0glprRFD8yP0RdoCRZMFoPF1RZGUEi3Dy4=;
        b=hY85NLRHwlYjZWYsKiclOqFiPC3qx2xzyWU1/2uXzVTqfR2KLiRH/J7sQhsEk+ulhU
         aN7j5M5TONSNMsszIuWjVLLC6bzndUZdOUMsgJ1zZ49pR4DL5nSMHoWZgULCIJoFMTMD
         4RQ2eIy64Gbye+IPzkeDtrgdFygWoMWJWWG0kp9CeONxIfP7FwQLjKmVQh9LyxA9Othz
         /yI2C3Aqsm+IZsbhHb5L08XqKy6j6OLHao4gAVb4VekrS+lVs6oGFNAiIkBZ/Po1uy5F
         yv4smTv+6a6e/3+FKOV3WRnJ3jsfZjVZSHQE257RWyC6loE0Wnj0leg//b+pq/WY+Gkt
         hA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713200604; x=1713805404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tgBDpDYGQ0glprRFD8yP0RdoCRZMFoPF1RZGUEi3Dy4=;
        b=hRb+5Zxj6K68grZkb8eTCFnW1EwHzbexZrgqvWex6svEyA34QV2VvNmpnPXavaysRE
         yInw9yUO3MOd9MyV4dSXJawvMmVQYt9lWWHlEEmIpNHjWxWNH3Ao5WUYLuMnvrDWe2Un
         xvSdKKODK8CqTrEHMl441zsTlyXK23TqWO3NwFT+jt5O8EOtEIhMwEudUNdZQOC0Iyy8
         1IlMzKpRXrbu6Y4YJ5eHXKcFhoII8CPIBTXMW/zpEI0MGDehJjNoYLQ8RUcqUqViK69l
         yqBPiGQMwC+1nWY8MJSV9VKCH+zPz7sWFGgiLkJ8klcuNMubC2HwogEzhaMGZz4p1zop
         tT+A==
X-Forwarded-Encrypted: i=1; AJvYcCVmPmt1OusxwjlRpsNQ30O12/hnUFN/NJKtqr3BZy4cukZoBsYvGCKpOIa737as7fsWcv1cUrgvLvUy2ZZ9JbrN/IXGs4SqREXZLQ==
X-Gm-Message-State: AOJu0Ywql4mEvZaUU2+8vb4e8nfHC5cHkerz/sAMUnzyAXOwJsZVgWsy
	92o32ZdQZzw33SCx3nUtnO44buqLtLDYWtO/hlHG5tT8QeVfOl0y7ERE4Fv1rrg=
X-Google-Smtp-Source: AGHT+IGfV3g4HnB1SEs58HPZghQyLF4oCdd9NUua8vNYxrzLQb9woMp8qFN8pqykKJDwEhBAY0XH6Q==
X-Received: by 2002:a05:6a00:23cc:b0:6e7:29dd:84db with SMTP id g12-20020a056a0023cc00b006e729dd84dbmr14671886pfc.31.1713200604137;
        Mon, 15 Apr 2024 10:03:24 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.230])
        by smtp.gmail.com with ESMTPSA id 1-20020a056a00072100b006ed045e3a70sm7433158pfm.25.2024.04.15.10.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 10:03:23 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Robert Moore <robert.moore@intel.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Andrei Warkentin <andrei.warkentin@intel.com>,
	Marc Zyngier <maz@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [RFC PATCH v4 18/20] ACPI: bus: Add RINTC IRQ model for RISC-V
Date: Mon, 15 Apr 2024 22:31:11 +0530
Message-Id: <20240415170113.662318-19-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240415170113.662318-1-sunilvl@ventanamicro.com>
References: <20240415170113.662318-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the IRQ model for RISC-V INTC so that acpi_set_irq_model can use this
for RISC-V.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/bus.c   | 3 +++
 include/linux/acpi.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 17ee483c3bf4..6739db258a95 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1190,6 +1190,9 @@ static int __init acpi_bus_init_irq(void)
 	case ACPI_IRQ_MODEL_LPIC:
 		message = "LPIC";
 		break;
+	case ACPI_IRQ_MODEL_RINTC:
+		message = "RINTC";
+		break;
 	default:
 		pr_info("Unknown interrupt routing model\n");
 		return -ENODEV;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index f8f92aaf97ad..c4b6d5c3aaed 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -107,6 +107,7 @@ enum acpi_irq_model_id {
 	ACPI_IRQ_MODEL_PLATFORM,
 	ACPI_IRQ_MODEL_GIC,
 	ACPI_IRQ_MODEL_LPIC,
+	ACPI_IRQ_MODEL_RINTC,
 	ACPI_IRQ_MODEL_COUNT
 };
 
-- 
2.40.1


