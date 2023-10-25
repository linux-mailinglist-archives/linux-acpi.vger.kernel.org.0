Return-Path: <linux-acpi+bounces-997-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E54DE7D75D1
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 22:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 683B9B20B13
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 20:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8F13418B
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 20:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="bc4o5R2u"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C2F33997
	for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 20:25:28 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C89C19A6
	for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 13:25:19 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6be1bc5aa1cso132590b3a.3
        for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 13:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698265519; x=1698870319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kojFGf2ZSJMlibBdobzZmgsjyx4Ywkx3WkwDcrmlX4=;
        b=bc4o5R2uRaA6wRDr326evH2qCIY9KhXBqmOap9Rh/as79Qpcg2Qicy4H+VVxFUknNu
         k4xMf/iXntL0KNo4tITE354JEJ95D9q2fdE+TV7dvjkBac+pd2TI2xoPHFgeP5bmWlsy
         u5bWElwny2aXk+K/OT1ttCkjs8jSk4H36BTZQrgZQ77cvpSmHm+va+WOAchlKFhdBxMa
         d4aK1Bu9VaQt6GGDiueX/nis1P4GNpLukPI6x6P7cKWUz8xPut3EL/m9G1kNkWIniLXN
         ylixWR1+htq/nm9vivn5WMHaHVBkEPwLuqJQfdIuoI6+ko3baX8+AqmTB0gvpHsd9pi1
         Ddow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698265519; x=1698870319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5kojFGf2ZSJMlibBdobzZmgsjyx4Ywkx3WkwDcrmlX4=;
        b=milfLnUwsdmAsCdhMTkmclgMbMwTRgwjJDC+hMSCot+xVHXh/lyhLbIV/ysqf8544J
         RzE8/cu6lQ8F361R1BEXztq8wzi0xhcWGt5Imh9zdZv5GB4SJ5hUQSgaKAbHeQR8dRL4
         ogA/f7jo9KBqtDh7FgPg9WWeR+eVru2hZksBrhZwAElbklu8p/3/mxxwIJK7Mopant/o
         2zZfJNvKh1QCLhZW3HB8Wo5QSyS3gxzFGrveN6FGaIVRY8TwUR16yB5iJdCbuYJOwpm5
         hra8jPDPllimCq8A3uLzvfkumRmCaX33XNlapFOVhrsu36wbFT2QJAO703HOVU6O946G
         nwlg==
X-Gm-Message-State: AOJu0YxHdf59uJ0RmZ49YnpwIUL1qR5DyugniqPLc5Q91JT0+SXXLm8G
	L7eTv6J4vRm0q8pfTnF3YbSUOQ==
X-Google-Smtp-Source: AGHT+IEA5VCpygjnJt29h1aUuFMuVqz64Qf8m3MJ6i95Ryf0OFy3qLoON8TOXsusky9X3JJetvXkcA==
X-Received: by 2002:aa7:888b:0:b0:6bd:9281:9446 with SMTP id z11-20020aa7888b000000b006bd92819446mr19186279pfe.10.1698265518840;
        Wed, 25 Oct 2023 13:25:18 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id y3-20020aa79423000000b006b84ed9371esm10079590pfo.177.2023.10.25.13.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 13:25:18 -0700 (PDT)
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
Subject: [RFC PATCH v2 12/21] PCI: pci-acpi.c: Return correct value from pcibios_alloc_irq()
Date: Thu, 26 Oct 2023 01:53:35 +0530
Message-Id: <20231025202344.581132-13-sunilvl@ventanamicro.com>
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

Return the correct value from pcibios_alloc_irq().

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/pci/pci-acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index c8c3369fd69f..80dc0b290544 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1528,7 +1528,7 @@ arch_initcall(acpi_pci_init);
 int pcibios_alloc_irq(struct pci_dev *dev)
 {
 	if (!acpi_disabled)
-		acpi_pci_irq_enable(dev);
+		return acpi_pci_irq_enable(dev);
 
 	return 0;
 }
-- 
2.39.2


