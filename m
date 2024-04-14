Return-Path: <linux-acpi+bounces-4993-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BEE8A3FFB
	for <lists+linux-acpi@lfdr.de>; Sun, 14 Apr 2024 05:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9B2D28246F
	for <lists+linux-acpi@lfdr.de>; Sun, 14 Apr 2024 03:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5EA134A8;
	Sun, 14 Apr 2024 02:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gx4hC6tT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997991BF27
	for <linux-acpi@vger.kernel.org>; Sun, 14 Apr 2024 02:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713063591; cv=none; b=aBxZUc0flWYGGYRGsY5D/g0msc7dBIuiT0x24jvYlfJlLSwylUslG/Vzr4YZyPIrIBOzeBQXUGNSBMaXea/k7IDsFsS3JiHRkxBfL+BDy/wIZ3sA2DnFXeeL0cL/s9u5MOYPMVdtRiA7LjjPSrAsagEcxcDjL/f6W8PXxTr2C9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713063591; c=relaxed/simple;
	bh=74/j8ENughgKXArfiTJjMj2qv/FhTXWLGElJJX5xuq8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JYGIOoldSGMXUcVAKCeFfvKolyNAwb28HFhx10gtozNTKwaDIZAgPE1iEJufLH4VUVsmIy9LJMjgFE54dLsubObEzv0IFXy0Jp5ENwCyQacvFsrjZ33o9s7JwdQPOyuJxDvzqj+aAEBXn+feh9IVmq8giYX8xz8wwI0G/CJ709g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gx4hC6tT; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ed11782727so1788525b3a.1
        for <linux-acpi@vger.kernel.org>; Sat, 13 Apr 2024 19:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713063590; x=1713668390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hheiXqV+1wPbN2r8XTJ5OPePJHFHtIdLdr/kVMTR0TE=;
        b=gx4hC6tT3bhKRz1xEPhKSViTnx1nOQB21g5NfvSI2EQm3xDR7vm9pD8ydWsACFS9gn
         XnEQ//Y/uct6CskUejHsQMjsynCG6QewjfnK/hvaVB7UOrcYjKca5NEDuwX+OhVnKF6G
         v5U8RrrMxs6bJzkTD5ryfKu5l1AkZRRZFlsN1p9y7f8btWqaZFvsksPOt5OQXVbNoVUm
         cKIoA7yZIclUu4jP2+MEHeABg9XjPLtyExml98suZJvbX7PXr/sPlY078cPqSpNB4ocN
         sUQJhO98zQJmkjMDVeJRW0W5jI2q5yN7sz0uOri1biHtPsek/CUwhfjsbIii2zFndTo0
         2U9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713063590; x=1713668390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hheiXqV+1wPbN2r8XTJ5OPePJHFHtIdLdr/kVMTR0TE=;
        b=LRZn6spBOstsSr1gPL5vcboXcR6itgdaoz3XVkqzlYJQa23BfsPCgYthlobGprnU6w
         8y2nG7IUitUE8RHbrHjQiwbv+0isYShOBjR47Nj1mNa9FVu+neotV5xJvP70vGV9Iw50
         u6ZIiF7n+k2rLfdkAOl5heVYcJ2v1+1Vp0UpaArK3YIsd62i7YfgaLBvXMIvSkffBGU9
         ffuxovKJB4Qsa2OZA1AihQpGBWQEOMS/houVcrA5qwno0UYqxq3xX8JdP4/Nfzz36U4U
         PI4AX5CnS0AJxJSg1dk0suQSy6u41Rh0/9k6mFs8+31QNDiDD40DpSeDa+dUs7NqET6U
         zdxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWC5wH7K6kAuyA4ekJ20wn2eqk70DQZXAKMbXyiWwfincNKBumbxah6Fd0yQzrbPvgxU1mCmNkTTF9Tdcz7usQYux7FDBIW9dj7sw==
X-Gm-Message-State: AOJu0YxFPMuMdyw1h/3e93swksHKE1NTepRwrq9ozSEPSTH72bViOYeu
	5IlNiVql2bo7eQoSMoXIkydgpUuvkKE/jd+aNTKRkiXtLC1/QCEYAmF43zPaFCo=
X-Google-Smtp-Source: AGHT+IES5ARbziOtU0omIM62ldJV61HnJflISF54CoCezeAWh0dUBTsAEufgLAJHedaFd0waldCY0w==
X-Received: by 2002:a17:90a:d306:b0:2a2:8065:899f with SMTP id p6-20020a17090ad30600b002a28065899fmr4798578pju.41.1713063589971;
        Sat, 13 Apr 2024 19:59:49 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id cx15-20020a17090afd8f00b002a219f8079fsm4799913pjb.33.2024.04.13.19.59.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 13 Apr 2024 19:59:49 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org,
	bhelgaas@google.com,
	james.morse@arm.com,
	jhugo@codeaurora.org,
	jeremy.linton@arm.com,
	john.garry@huawei.com,
	Jonathan.Cameron@huawei.com,
	pierre.gondois@arm.com,
	sudeep.holla@arm.com,
	tiantao6@huawei.com
Cc: Yunhui Cui <cuiyunhui@bytedance.com>
Subject: [PATCH v2 3/3] RISC-V: Select ACPI PPTT drivers
Date: Sun, 14 Apr 2024 10:58:26 +0800
Message-Id: <20240414025826.64025-3-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20240414025826.64025-1-cuiyunhui@bytedance.com>
References: <20240414025826.64025-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After adding ACPI support to populate_cache_leaves(), RISC-V can build
cacheinfo through the ACPI PPTT table, thus enabling the ACPI_PPTT
configuration.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 6d64888134ba..5d73fcaf9136 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -14,6 +14,7 @@ config RISCV
 	def_bool y
 	select ACPI_GENERIC_GSI if ACPI
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
+	select ACPI_PPTT if ACPI
 	select ARCH_DMA_DEFAULT_COHERENT
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
-- 
2.20.1


