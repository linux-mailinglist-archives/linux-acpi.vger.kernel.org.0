Return-Path: <linux-acpi+bounces-1002-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F6A7D75D9
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 22:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72C382812FC
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 20:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B78E3418C
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 20:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="cZDdqT/g"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE3022F1A
	for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 20:25:57 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1C810CB
	for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 13:25:48 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-68fb85afef4so141801b3a.1
        for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 13:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698265548; x=1698870348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cuOe+AU3MQZSBvbMUo9B/kQ2SYr1hcMCXHjeEaDcfY=;
        b=cZDdqT/gtqqI0oRq7UCAkp68DsV0s5Wqf+YVZ1of5fXPaZ95fQ1mwqXd5CoOeff3Pn
         cWT82Cg/EhuvcFsKVQTjTH4THO35VgzBwMguia2vgolJ9+0ZyEwWwJ1cOkjg20y8VuZY
         sLOhrr7oUewiG4Rhb2YweEwgUxxUhYD1lb8Rymo1TEkjYyO0NmbW6HUsmHjuOP75O+Nh
         ZFPnpmAU1Z7lbL8uugrDLcXdMyQtMUhSFFvt6+WJAS91FdwgYZQbquE1TJ5hBPh1po5a
         +c4wrcjBMG7B/TuKcikOoUPZC8GpKJ3/8NHrgBSMFJjQpR9Vkl7OB/9FHz7/+XqTg6e7
         /iVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698265548; x=1698870348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8cuOe+AU3MQZSBvbMUo9B/kQ2SYr1hcMCXHjeEaDcfY=;
        b=vVVWi6Q1GTmcPEdv+XgwYi4Ws+/QcthM0/hm/wmhWJjzTlayXOCkK63i9zCLuYkV4S
         9dRJXlWHqbE+9QVV1siwUTSvO6nl1l/SchMCst9XxBX6ZD2kwj+6Pj+ZU2ug7B0wULMK
         Q5BMSwt4zzJCr7SF/eZa5g+P/wMvkCTfF9VH3e2kK4rZuJ5fpjxagdsqO2/MVVQLBJPT
         rpHK8fTwkfQXJHSfbJXe0LCKvoTkUFtJezodKzImsHqAXpNc9gzQruZhkWKWErGgZmuO
         UpnnorgWz4BYj8GNpXqMTKpi3OrsM1b7JmkNCYFItgrNEBlZSgdgKfrw/iG+zHp4uQzM
         GZWg==
X-Gm-Message-State: AOJu0YxdOaFVmFMIj7XjfHuleSkEDN9YPinoQ4ZECaELl9m+JjiHln3O
	JyIujJFGIUsGwVP/zAdV1QxvaA==
X-Google-Smtp-Source: AGHT+IEhemy4634FjVGt90Fqrc/7Er8LwdUnaKYZ7F/EhXxC4jPWbW3jfNiUW2TVJUJPoCyPB2P5Hw==
X-Received: by 2002:a05:6a21:78a3:b0:17a:eddb:acc2 with SMTP id bf35-20020a056a2178a300b0017aeddbacc2mr8715766pzc.46.1698265547753;
        Wed, 25 Oct 2023 13:25:47 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id y3-20020aa79423000000b006b84ed9371esm10079590pfo.177.2023.10.25.13.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 13:25:47 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-serial@vger.kernel.org
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Haibo Xu <haibo1.xu@intel.com>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [RFC PATCH v2 17/21] ACPI: bus: Add RINTC IRQ model for RISC-V
Date: Thu, 26 Oct 2023 01:53:40 +0530
Message-Id: <20231025202344.581132-18-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231025202344.581132-1-sunilvl@ventanamicro.com>
References: <20231025202344.581132-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: *

Add the IRQ model for RISC-V INTC so that acpi_set_irq_model can use this
for RISC-V.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/bus.c   | 3 +++
 include/linux/acpi.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index a4aa53b7e2bb..9eace6c7042e 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1158,6 +1158,9 @@ static int __init acpi_bus_init_irq(void)
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
index 4ad256a0039c..19c3dda9c2ed 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -95,6 +95,7 @@ enum acpi_irq_model_id {
 	ACPI_IRQ_MODEL_PLATFORM,
 	ACPI_IRQ_MODEL_GIC,
 	ACPI_IRQ_MODEL_LPIC,
+	ACPI_IRQ_MODEL_RINTC,
 	ACPI_IRQ_MODEL_COUNT
 };
 
-- 
2.39.2


