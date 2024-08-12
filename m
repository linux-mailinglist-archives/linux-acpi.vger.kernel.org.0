Return-Path: <linux-acpi+bounces-7513-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB1E94E451
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 03:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43D451F21DFF
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 01:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8383A6AB6;
	Mon, 12 Aug 2024 01:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="OtWndrTe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A3B1E4A6
	for <linux-acpi@vger.kernel.org>; Mon, 12 Aug 2024 01:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723424434; cv=none; b=cnKa7cyoAqaBeUZMG7Tg5iCFddVBxsOfzAhn4X/aaXn0TZpstypoUsMynbyd/IP+m6e1DERmbWWcDkHxKrqGU69vlN0QTxe7MTjrcW4X5i1+7V6KXGRREEDvDQ9F6S9y1j57laEqPQy2/WUYlPW1Tp2ZYHg/DehS0JIO5eJt7CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723424434; c=relaxed/simple;
	bh=ju78PKw5X3jrPkd4u5aoarH1747E7AoqhDQWmGlAe6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BfrH/JdPJrkPkUKuVPOb8RUvk2J+D4xv7eSNCZhyRQEg8kmIzRtSvSV2GNmQkV913uE+DFW+sri31u8oKJVB75XDom6gOergZpv2HJ+uRXehEJzAPctT6Ko39XPtPSZAQaI8OptpCMTfRRq5iww4PQIYnOu+nkyIuaQWom8q63Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=OtWndrTe; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3db130a872fso2879129b6e.2
        for <linux-acpi@vger.kernel.org>; Sun, 11 Aug 2024 18:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1723424431; x=1724029231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ZXNFNaxM8vBPLxvkIIPrWaUY6tMJ6nPhDNbuDGhUyQ=;
        b=OtWndrTeqolnNYuTu6lPAIYMFnRg5PZakcxBfsOpi+NIElZATnRkmDvW3OGrNpy7xA
         3sOuakefAJoWE84807tU8zBzZImG+WtGp+zujugqZIG4L8pfJ1Xw2sRzTwLoHXYyhJam
         pCu/GfRm2sCdT1kzBgK+zC0Jr3vkfg2xcphVnGjvTJ1v7beqjqbA+pjjyHHdMO+wG/Ju
         1Gm9aMt9H/phrIoOxfWDCuoVPTrLqGLSnk7e4ChWZwmtbR34oLqvnVCCKDv8+x4wjXmQ
         2KZIhf5wKxGd1/hsSakaP8asqAwzfzrykFv3eHHsS+Td9Tx2NsdSBKF5U8XES3TRKfSk
         za8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723424431; x=1724029231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ZXNFNaxM8vBPLxvkIIPrWaUY6tMJ6nPhDNbuDGhUyQ=;
        b=JpchEOIEbezEqMcpDaH/TQiqYFCf9ALs7Bl8kvkXsA7hYMpLw+nWGpi8v/786CCCgp
         E2mRLZFFvoXq5rBgn9iAvu8H1PWyXtg+yYb0OM5dqBiqhGn+ZUmvfMK7LG6DD3KYKVZH
         AoU02GkCbPJ9ipVJPlq1hhRTZCPXb5SCEaL4rIVaTHBJTXy4TDPzvUETwW0j1S7BI1xh
         7NI7yB518jM/i+sj98I1lBTo2pSTXyHtzGSn+mqqRCr0bFsF5nb5z0+olucqf71eT0OG
         2bef8Rs2mq4+RkjdUMlgP1gpkg9QwMCzw2Go5+uxR9SIE5czkk8dmMfTi/41wTl7Zm09
         PCog==
X-Forwarded-Encrypted: i=1; AJvYcCWnFNvmBb8pt/G8Da+oKHNqf1J8+m0JKEIcNJ2skqM+5a6CqFEegja3f1EA4QB4YQAMg8u4vciwYSbT0mbjTVBUwp9sGxqy+ShY7Q==
X-Gm-Message-State: AOJu0YwxOp34b6ro9ZxgSGlKEpak/uwBBRr5nb9VK5Gd23fmWQXtjdTK
	XqsE9HQpYtgqvmXSSvO4hPHl9BuwyFMGgo14hpy3BTtM+BxHuSg2d9rflRhXZ98=
X-Google-Smtp-Source: AGHT+IE9UN/eFl1Fb5sxAtzGTPfmVg74o1vo9nXqbGis0UuD39tez7iI9A3QbSPr+XUfKWTJWNIKOQ==
X-Received: by 2002:a05:6808:2f10:b0:3d9:40c2:eb54 with SMTP id 5614622812f47-3dc416688bdmr13217183b6e.5.1723424431425;
        Sun, 11 Aug 2024 18:00:31 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c3dbe8cbdcsm3074062a12.61.2024.08.11.18.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 18:00:30 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: Will Deacon <will@kernel.org>,
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
	Haibo Xu <haibo1.xu@intel.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Drew Fustini <dfustini@tenstorrent.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>
Subject: [PATCH v8 08/17] ACPI: pci_link: Clear the dependencies after probe
Date: Mon, 12 Aug 2024 06:29:20 +0530
Message-ID: <20240812005929.113499-9-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240812005929.113499-1-sunilvl@ventanamicro.com>
References: <20240812005929.113499-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=cp1252
Content-Transfer-Encoding: 8bit

RISC-V platforms need to use dependencies between PCI host bridge, Link
devices and the interrupt controllers to ensure probe order. The
dependency is like below.

Interrupt controller <-- Link Device <-- PCI Host bridge.

If there is no dependency between Link device and PCI Host Bridge,
then PCI devices may be probed prior to Link devices.  If a PCI
device is probed before its Link device, we won't be able to find
its INTx mapping.

So, add the link device's HID to dependency honor list and clear the
dependency after probe is done so that the dependent devices are
unblocked to probe.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Tested-by: Björn Töpel <bjorn@rivosinc.com>
---
 drivers/acpi/pci_link.c | 2 ++
 drivers/acpi/scan.c     | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index aa1038b8aec4..b727db968f33 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -748,6 +748,8 @@ static int acpi_pci_link_add(struct acpi_device *device,
 	if (result)
 		kfree(link);
 
+	acpi_dev_clear_dependencies(device);
+
 	return result < 0 ? result : 1;
 }
 
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 28a221f956d7..753539a1f26b 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -863,6 +863,7 @@ static const char * const acpi_honor_dep_ids[] = {
 	"INTC10CF", /* IVSC (MTL) driver must be loaded to allow i2c access to camera sensors */
 	"RSCV0001", /* RISC-V PLIC */
 	"RSCV0002", /* RISC-V APLIC */
+	"PNP0C0F",  /* PCI Link Device */
 	NULL
 };
 
-- 
2.43.0


