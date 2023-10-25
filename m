Return-Path: <linux-acpi+bounces-988-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDAE7D75C4
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 22:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C1631C20A23
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 20:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF64634182
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 20:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="B2QZEsvN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228D8328D5
	for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 20:24:28 +0000 (UTC)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8743319D
	for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 13:24:26 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6bee11456baso134912b3a.1
        for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 13:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698265466; x=1698870266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8oe0TQ1+zZd/3zKJQAEE+us/MvQWSBihayeSKyJW3A=;
        b=B2QZEsvNG1mckIay9FM37B8+RnbVBxmNlf/31hZqak2JAmMmKKpO3kQ3+QwfNmjTqx
         WCHcf/DzVJlqsxO6h6FGcQQIB3fQvcGK0Xhm7PP5EI8GSSnFruJdb5VNBMmgZSukgjll
         hKkTgNdRX9DqS/9NVqSpYuTi8qQkluwSgds8Na3VFhxvltoRNN7JUqh0xw6EkGo37+km
         keMHZ8eewlPoof4/eNfdheg0AU/D6rS75EXHTf4AOzcv8yobdEXv0yymXFKR3BiSpp61
         txpZSki5CdlRBVvI4nTwBUCbz1S+qpkkDSvq78M6AgKDV+yzA4w+RdbxsqXehsdzMq2V
         XcUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698265466; x=1698870266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W8oe0TQ1+zZd/3zKJQAEE+us/MvQWSBihayeSKyJW3A=;
        b=ozqTkGhZ00u9xxgLlIHjx8AsDHNmPznioPi7bMNHQp1sk4YBgyYsd4i48clNES08o+
         gFYpgxFT2cv5QcREtplIujXoy/iFQqL9rwbhHZm6hs9GiSpjXmVrxuN6LqDtWQwRo9M+
         Gw2mrPP4RJVqHw6LUBGi3Lqq9lY64wW0bB/fqTh6ABGHV4AcbA5Ch1GLHiTaNHxJciI5
         50NHQ9NfE5urMpVjAASKJCjy+Y8nEJ/hDgFbE8ffmawFPdE7gst0wg4CWTmQ69PMC2wG
         NCt+rmt0dDZ0i13h+xbuzeZeMyWPO8hCfwE6/2/CvUXDdl4JPdTrwCIAAsT1LD4XeFAZ
         GbwA==
X-Gm-Message-State: AOJu0Yz2/HanJUDsvCZj0XGjFlRAesSWnaVRU2VEC8d7CoyJaWHcWAa/
	wsYjKFZMEdi7pfOEsKdMCWsC3Q==
X-Google-Smtp-Source: AGHT+IGK6pQK6oEdjKlIa1mcimdR1pYjb6u2hPifw5U79lxb+nCirP606/eGPYNlPkAaYdn6n6fpUw==
X-Received: by 2002:a05:6a00:12:b0:6c0:52b9:d448 with SMTP id h18-20020a056a00001200b006c052b9d448mr905573pfk.9.1698265465988;
        Wed, 25 Oct 2023 13:24:25 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id y3-20020aa79423000000b006b84ed9371esm10079590pfo.177.2023.10.25.13.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 13:24:25 -0700 (PDT)
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
Subject: [RFC PATCH v2 03/21] ACPI: Kconfig: Introduce new option to support deferred GSI probe
Date: Thu, 26 Oct 2023 01:53:26 +0530
Message-Id: <20231025202344.581132-4-sunilvl@ventanamicro.com>
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

On some architectures like RISC-V, the interrupt controllers for Global
System Interrupts (GSI) are not probed early during boot. So, the
device drivers which need to register their GSI, need to be deferred
until the actual interrupt controller driver is probed. To reduce the
impact of such change, add a new CONFIG option which can be set only by
the architecture which needs deferred GSI probing.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index cee82b473dc5..4399e793f1d2 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -51,6 +51,9 @@ config ARCH_MIGHT_HAVE_ACPI_PDC
 config ACPI_GENERIC_GSI
 	bool
 
+config ARCH_ACPI_DEFERRED_GSI
+	bool
+
 config ACPI_SYSTEM_POWER_STATES_SUPPORT
 	bool
 
-- 
2.39.2


