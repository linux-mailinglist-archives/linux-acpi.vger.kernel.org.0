Return-Path: <linux-acpi+bounces-996-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 342A37D75CF
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 22:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63D7E1C209C1
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 20:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E3034187
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 20:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="JPtX39iv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF9433993
	for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 20:25:24 +0000 (UTC)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A524D10F5
	for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 13:25:13 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6b77ab73c6fso101445b3a.1
        for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 13:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698265513; x=1698870313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksJT9a6E7b+AgWOW+0QqZAQKxEPs+GfkSTk4Wygp/9k=;
        b=JPtX39ivNbt4Wu54KHQbjp1dzqEbHENSrbcvDK7ihL8aouRjgAM1qBg0f08HtA9Epz
         uqxhuOgJssIxhOx5Hdtxi2qNqGoiGAOTpJHtqhzM8/RCoJrrOyAWwNbj7WgPxnxdhNJ/
         QUCcaLA6nIsojuBhfGSIcOAOGAS30PqwI+9t1tNo9RNydJmC8xkKN3pJEfZCXMfEY6XK
         XXfnvzgLivw+nwMJOq+PVT3Azu/kavUkoHQdT5Fpb7im21YBKGATma9lx07I7CqEHUUh
         g8ix8mJPToO7AYfDx1nMKi5QnmRiTuIVnEkjuyp+JOi8/WevGG0hM3Q0gsPDw916+c6y
         jUGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698265513; x=1698870313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ksJT9a6E7b+AgWOW+0QqZAQKxEPs+GfkSTk4Wygp/9k=;
        b=ZMgNnEPvnXmCIAP/d5ZtaMgYODfsXIilUt3vlUZLgr7qBJObsfdRrvcGasnvI2gDbH
         rkV+tluMAkv2OXLfXrXv6+Xw8p1K1WNARL7rqTgUdM4xaLFldku0SY5VLZFzd1mY365e
         Q9KqDqehtKHN/RXfUaRfA4qBrYky82zMdwfNY4e2pXWOJXKf1QfalDrCUwgRwWeqGyzw
         kK/cmk4ijersOxbSS2Ki5rmVCNNyl4K6fw1rtKaPTM/Cf5O/191FZq9KBavA7uQytFvv
         33k87yyEM2ikZqC57n1GgyN3cGQyUBx3n/raRSb7njhug54VPYJ1La8xBMdvyW8f8Qdl
         U8tg==
X-Gm-Message-State: AOJu0Yx91bePB2ZGfLiy/w5cPLOqPJDTziWOk/DwXFzT/U5A1z07OHUp
	0YfIH4YgMb7fm6vXX1HSaNhu4w==
X-Google-Smtp-Source: AGHT+IEV/ROdZJJDw08iKQqN+bmgqdHT2tEV8SRCTGnJc4fD81is4j8SLEFb3dBe1vSckHTdkPvdfA==
X-Received: by 2002:a05:6a00:478c:b0:6b4:64ac:eab2 with SMTP id dh12-20020a056a00478c00b006b464aceab2mr801836pfb.1.1698265512788;
        Wed, 25 Oct 2023 13:25:12 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id y3-20020aa79423000000b006b84ed9371esm10079590pfo.177.2023.10.25.13.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 13:25:12 -0700 (PDT)
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
Subject: [RFC PATCH v2 11/21] PCI: MSI: Add helper function to set system wide MSI support
Date: Thu, 26 Oct 2023 01:53:34 +0530
Message-Id: <20231025202344.581132-12-sunilvl@ventanamicro.com>
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

Like pci_no_msi() used to disable MSI support, add a function to enable
system wide MSI support.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/pci/msi/msi.c | 5 +++++
 drivers/pci/pci.h     | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index ef1d8857a51b..e76ccb8b5f0b 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -913,3 +913,8 @@ void pci_no_msi(void)
 {
 	pci_msi_enable = 0;
 }
+
+void pci_set_msi(void)
+{
+	pci_msi_enable = 1;
+}
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 39a8932dc340..2f876c29f75c 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -167,8 +167,10 @@ extern unsigned int pci_pm_d3hot_delay;
 
 #ifdef CONFIG_PCI_MSI
 void pci_no_msi(void);
+void pci_set_msi(void);
 #else
 static inline void pci_no_msi(void) { }
+static inline void pci_set_msi(void) { }
 #endif
 
 void pci_realloc_get_opt(char *);
-- 
2.39.2


