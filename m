Return-Path: <linux-acpi+bounces-6122-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 671198D70A5
	for <lists+linux-acpi@lfdr.de>; Sat,  1 Jun 2024 17:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B34AAB21AE2
	for <lists+linux-acpi@lfdr.de>; Sat,  1 Jun 2024 15:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88641527A4;
	Sat,  1 Jun 2024 15:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Kjz2fM/L"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9521CD3D
	for <linux-acpi@vger.kernel.org>; Sat,  1 Jun 2024 15:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717254312; cv=none; b=emS56yxSAWZKLheV+xhy9IZ31LrbgAtdS2bwwIbhDMiagdNYTZBVltksQuzED4MJXJvw76d5sMlUDTNyy1sSk+uf6Uk70MPSTtKZwzXmbdr1Lvjg9i7L2XgPXbNMsPurdA2dhbCkXbCyR2XoT1yIyrg6oA3DlWlOMHncEVzQ77A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717254312; c=relaxed/simple;
	bh=MS3pYncxgjtaz9tqccBN5FjLqLx8afnodSL+vXxHJSE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qh07ELgwGrCCAPNb3BoL2bt0+qjeelXxIblfGsVuZRwhDuvXQ8PdVYqpuzmOE0JaA+flp543d3VTX1jvG7r8h7z6um8Dlh3DCukV2bj+T/fvbf6ooAWoEqiL9oxW+wpCdUhyTPK0PQPI1jSUjVM78UWmw8qMWRGZ9/fKCMduEDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Kjz2fM/L; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2bfdae7997aso2334838a91.2
        for <linux-acpi@vger.kernel.org>; Sat, 01 Jun 2024 08:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1717254311; x=1717859111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4M/mYQsiafz27308Ygh9HE2jpjvmPpXdwbsDZU0p4U=;
        b=Kjz2fM/LXEMXrWPgy3sD+Wi5PZRi93ASTcmKlDmLh3ZGN0oPWD1oeZdpMNCKrd2QMN
         MrhFdYfjFFM3RS6qtHorNm7M7CfuypUyrkZpnY3FD68PI//gs0qtSjwEAPQXu0Ng/2sw
         nOFWvBQcnJVJyLituErWYCrzA8IYz68IyEoyckiu1lQaWO6JaHD5zABHo1wuAil2TJ2K
         04h89Uk4D+8+/SfPXscz1RzEE5gIDVeJVqVs6+Fy7FYIIKcTr47CPgOPe/ZIxpHzlKWT
         1KQw3Z6ESHZu/i9lNKHViesBqeju7+vOBZFy5DfS5K7KzhQavvh60k5MvtXtsM95WffU
         SwDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717254311; x=1717859111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B4M/mYQsiafz27308Ygh9HE2jpjvmPpXdwbsDZU0p4U=;
        b=OP2XHVeJIPnqrzxWlMSzvg5ZAX5nC+6vf9N45Wk3Bl9CupRYu3cv+A7dGeIjOH9mrB
         7V77NZIt8+Hf/4RXezHGXs7P8DbsLIiUKd1mRbv81CXfgq4HtHTlFXKZbtZW4y4523TI
         PdcieBH88Kn7wgT2nTS9IQuTyoY4VU0KbZ4Y3SAVvEjIHERIDLt0HNFEK5CtK1HeUH4N
         /RE2n79jM3rH9yllwO2dhqg3PZAYteMr4ZtOdVd5ikEAAu/9TdExjDJ9C8DvcXlbhjm2
         oRiQugvcb6xFojlpt3L3MqqE6nvNdbRh6t2JSOEW0ytJr0mbkCX9ry11MuEplK8OYesx
         PwKA==
X-Forwarded-Encrypted: i=1; AJvYcCVLhPtlGvZaDn1s9ANcOnuKozIfskc54t7uwsbaWFUvYTy7tJoE+3sg9nCTWlHmRbpX7E/XUoSlpdV4chwt/uTdco6K/OsWrNFSNA==
X-Gm-Message-State: AOJu0Ywkyg8CngT3/VCS7s9R4dhXemooEH1IyHhybN7U3qtnseLYepCU
	ltGrfkbrpdwSXvnV1OVgX0GLhe0oxjNDavFox5PNTf72LXFtNf38dltakiIlZEM=
X-Google-Smtp-Source: AGHT+IH8CUtTilyts1LQmIwjtfiqczpJ90H7WVJzan1b3vUk1N8n0tjhHWRHLwYTOBrAh4nFvjs79Q==
X-Received: by 2002:a17:90b:1bcd:b0:2c2:a2a:6151 with SMTP id 98e67ed59e1d1-2c20a2a631emr797621a91.39.1717254310835;
        Sat, 01 Jun 2024 08:05:10 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.237])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6c35a4ba741sm2559410a12.85.2024.06.01.08.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 08:05:10 -0700 (PDT)
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
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marc Zyngier <maz@kernel.org>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v6 07/17] ACPI: bus: Add RINTC IRQ model for RISC-V
Date: Sat,  1 Jun 2024 20:34:01 +0530
Message-Id: <20240601150411.1929783-8-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240601150411.1929783-1-sunilvl@ventanamicro.com>
References: <20240601150411.1929783-1-sunilvl@ventanamicro.com>
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
index 8d0710ade8c6..d5286e39668e 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1201,6 +1201,9 @@ static int __init acpi_bus_init_irq(void)
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
index 0c6d9539f737..3dd67ee09c39 100644
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


