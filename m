Return-Path: <linux-acpi+bounces-990-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E257D75C6
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 22:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E00B71C20A1D
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 20:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E51168BD
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 20:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="nNqvGjA6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C6E328DD
	for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 20:24:40 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BE91A7
	for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 13:24:38 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6bd73395bceso116561b3a.0
        for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 13:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698265477; x=1698870277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J8S/JDCmwBJX/s4tcuif01AJjqTYAtUjVSzvHHCYv3Q=;
        b=nNqvGjA6QPmPkU0pIK+PisNTyVgj2VgA4U5e51WIi1UAtB68oOcDrAFNkopUNesM5k
         x5L/8RGmTh7GA0rwpMIDrGTAfFijRQogXgvaxhxfntL7XlcCcztZsFKcL45pLMhuRGcP
         HDaG3Z2kIzvvvvrPWQh+rvSak5AwjfkNG5+O6B6BLQxWc+MTHPvMxYWttNwgWppF25vJ
         glcd/sy1FvIwxr7bfe//85NgZBsIJ+qhTJAByTugflLc9l77og8LLV94aKgAb/i72lJx
         V4qVcEQj5eXnFn3BigSXcUMY7LN3Zr7E5hveMCoS84pk0QvbHq4XbsyfXz85Gezfp/m6
         Tuvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698265477; x=1698870277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J8S/JDCmwBJX/s4tcuif01AJjqTYAtUjVSzvHHCYv3Q=;
        b=HzF9IcRT7vNFMP1Ta0tugjzXXd4NE0bScCx0k0nNC9jg9WFVRR8THV7rYllwDFbvc7
         5LiWAqa/9KxcefD3r4X8hJQ1Lpee/dC/lV4pbaInLwRShVoAyGaGBvsAG3EjFUckWk7K
         Wcf4RJsXKlZDLUOa/d4jXvqoLHHlAdqFXib1cM6nQj7nTDWWr6EWZjcGseoKcpkoh4+i
         +Q4lb5gIK2gcc8p2nzvhjNcpyIbuOxxpmNEw5ZPzPg9F5YgOlvDv4pQYqmv+NfzxUvSZ
         IpVFigEmvRJLmET7x1yFun5wEtnkmeLPgktKIw52yV2z0PWI+tiD/YigOMjgioo9sdQk
         n/9Q==
X-Gm-Message-State: AOJu0YwydxuLQKH/esqS/0v2I43qnliLdp6a4sX2QBYcHdT3nxqRmn2f
	rWjXN2ljuOh9pqo8yRluDok+Ug==
X-Google-Smtp-Source: AGHT+IGn0Ntg16V2ATutjBKN8vUehxORe09c59/GsjNsvnPR9Qebb6VfuMhALgVB74e2gHGUr8GJNA==
X-Received: by 2002:a05:6a00:1396:b0:68f:b015:ea99 with SMTP id t22-20020a056a00139600b0068fb015ea99mr913751pfg.10.1698265477463;
        Wed, 25 Oct 2023 13:24:37 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id y3-20020aa79423000000b006b84ed9371esm10079590pfo.177.2023.10.25.13.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 13:24:37 -0700 (PDT)
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
Subject: [RFC PATCH v2 05/21] pnp.h: Return -EPROBE_DEFER for disabled IRQ resource in pnp_irq()
Date: Thu, 26 Oct 2023 01:53:28 +0530
Message-Id: <20231025202344.581132-6-sunilvl@ventanamicro.com>
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

To support deferred PNP driver probe, pnp_irq() must return -EPROBE_DEFER
so that the device driver can do deferred probe if the interrupt controller
is not probed early.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 include/linux/pnp.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/pnp.h b/include/linux/pnp.h
index c2a7cfbca713..21cf833789fb 100644
--- a/include/linux/pnp.h
+++ b/include/linux/pnp.h
@@ -147,12 +147,18 @@ static inline resource_size_t pnp_mem_len(struct pnp_dev *dev,
 }
 
 
-static inline resource_size_t pnp_irq(struct pnp_dev *dev, unsigned int bar)
+static inline int pnp_irq(struct pnp_dev *dev, unsigned int bar)
 {
 	struct resource *res = pnp_get_resource(dev, IORESOURCE_IRQ, bar);
 
-	if (pnp_resource_valid(res))
+	if (pnp_resource_valid(res)) {
+#if IS_ENABLED(CONFIG_ARCH_ACPI_DEFERRED_GSI)
+		if (!pnp_resource_enabled(res))
+			return -EPROBE_DEFER;
+#endif
+
 		return res->start;
+	}
 	return -1;
 }
 
-- 
2.39.2


