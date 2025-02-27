Return-Path: <linux-acpi+bounces-11553-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4055EA47E00
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 13:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C6123B532D
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 12:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D7022FAFD;
	Thu, 27 Feb 2025 12:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="IYpz8ai6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5077A2343C2
	for <linux-acpi@vger.kernel.org>; Thu, 27 Feb 2025 12:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740659853; cv=none; b=TNCK6zAYXviWPa7wlId4WZLrCJUvHEQmpA8faOYMZX552tFylFEvGNhqGqNPcfNnm3D4sYUZmxoeJeAeHfrVZJ1Art7tT5/g3XnLKXcNFA98YOEiw+6XVCQa/8qarNpyIQ8UnGtgVmMnyj4ouZxyyfNZZfxcynERYHaeot8J+9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740659853; c=relaxed/simple;
	bh=VXd0R443A2CSpN6/WQb26SvFq5CeBSdmv/3wp2DtRPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UaeqSOEn8kcYAo4dRY/ldvbfJXI4Nvt5mC0snDkpGckKhYDzxushf2WNo9hyrrmqbLiPrI3Pvrw3b838E8ru/5lD8ulGUhDszXgGAjV/Kr0ux3N2OCa/SG9z6qwbiAgH5+nNjtE7/Sp5uBmlgo9WbAj8zZRC0fi4P1fodU4k20Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=IYpz8ai6; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-220f4dd756eso16026415ad.3
        for <linux-acpi@vger.kernel.org>; Thu, 27 Feb 2025 04:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1740659850; x=1741264650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+mNjfrfC3KQpEysy41mS2Tv5FPl9byidBfQ8gAxtKE=;
        b=IYpz8ai6jUfZrW6JOesC2KeuqEZFq65PXtDxF5pjRRe+74aywVgCYQMxkfrO6sAi+b
         WoOmFQbBThkjkqWthkhnQdjFSGFyfZS0PPSeEvs5KoA4cD1f62t/x47ImxHxq44JQ0l+
         yemtizH7DWZji+yz0P45m/rxFk7Gd41G3cnzB9EXE0VlWHVq/GYKsdMUCzugCe7EE6r+
         2ClSzlQSGJwdZYZeIRJeqZ2eEMx+Ewyv2zFUMf0feT5SCaniga7uAT33G3cs8AagiUj3
         ID0w4nKnyNDptgMQjnKbfOAZpPkKpzHN8NfTqTs5AWnldKI1FDLgeYwXWG0C9Unv9h7w
         Mwrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740659850; x=1741264650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5+mNjfrfC3KQpEysy41mS2Tv5FPl9byidBfQ8gAxtKE=;
        b=QdMjqSy5Nuf6hrVaCsg0udJ+c3/lMbhUwzgeiOb02CQTumIWrrwpGdnFegC0111d8l
         LafnFiHN9t+XvF3T4EOORP/2rF5oi7nkeOmIYHoHbU765SocYymF7yZZCg2otfpUmIvH
         kMCLPXT7ZFnr44Do50wxhRr846S7OwSBB9y/8viYgg/UQpufX43AbAWK2sqD7X/smnY0
         sneFiEVRtM1auZEO8I4Ot/W0MeBnqQCkBHn60Mk/jguz2QrFJqCp6j2mtykBj845RZ1f
         17gtJn94bz1YLaOhOdnB0+qeB17DgRJTaSld6jUlOU7RVyvQKuvI+ZnNxTSo6aLVkecs
         lzxg==
X-Forwarded-Encrypted: i=1; AJvYcCUTY2jOHXdFU2OpnCoBlfQFgWgNsYDTuJISOSJcooYN3RLz6RlOS/ML7QxE6InoT25up2DBMJFA9+5v@vger.kernel.org
X-Gm-Message-State: AOJu0YzzVZsnXftBB2bYVMmxnpnDJzW9759k13UUhoBexguOHcBrjA6I
	akuGJ9OYoi7BSnuSamwX3Gf0As05s4V2auLOPMZyWjr9wGmWp6NewABJuzalEGY=
X-Gm-Gg: ASbGncuTmYJJUc1xfBX2MZSguz2ALrUgJNW5t66/CsBCDc96pykSyAC2oUpNvE54fm2
	c3lo7SSfSZ2HhMehd4i/eKtDioR6oWLnfnagTDkUZh3BrkUEA/qTrWKf9MuB8IFmdeCk6VGzXqi
	LtEhlcqjOCXeEOa1yNyuaHiQY+jRRna/9Of5d0D5bjhdHjxojtRdR6MduA5EbEY6NFXO+fh8mba
	sdQlDrnic7n2I7qh72vXVfVueNPLj+YUf2ZaskZOSjqe9cXZv9lc///sjHDd0BBtxXzxFVg2HbE
	MlkJR4ck+gy+3EY0XexR92947VMB/UkDHhwQ
X-Google-Smtp-Source: AGHT+IE9Vof5DljJTx2QIG7oo7zj0JMnbJZ2cxvFEIVb6E+KmXCrNVvzk23nCPfXj+pXqJcPAINyhg==
X-Received: by 2002:a17:902:e847:b0:223:4b8d:32f7 with SMTP id d9443c01a7336-2234b8d349dmr54186705ad.19.1740659850577;
        Thu, 27 Feb 2025 04:37:30 -0800 (PST)
Received: from ventana-bhyve.. ([49.37.249.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5bddsm13219135ad.140.2025.02.27.04.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:37:30 -0800 (PST)
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-efi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	ardb@kernel.org,
	conor@kernel.org,
	cleger@rivosinc.com,
	robert.moore@intel.com,
	sunilvl@ventanamicro.com,
	apatel@ventanamicro.com,
	Himanshu Chauhan <hchauhan@ventanamicro.com>
Subject: [RFC PATCH v1 10/10] riscv: Enable APEI and NMI safe cmpxchg options required for RAS
Date: Thu, 27 Feb 2025 18:06:28 +0530
Message-ID: <20250227123628.2931490-11-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227123628.2931490-1-hchauhan@ventanamicro.com>
References: <20250227123628.2931490-1-hchauhan@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable the APEI option so that APEI GHES options are visible.
Enable SAFE_CMPXCHG option required for GHES error handling.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 arch/riscv/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 7612c52e9b1e..baf97a4f6830 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -54,6 +54,7 @@ config RISCV
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UBSAN
 	select ARCH_HAS_VDSO_TIME_DATA
+	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_KEEP_MEMBLOCK if ACPI
 	select ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE	if 64BIT && MMU
 	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
@@ -175,6 +176,7 @@ config RISCV
 	select HAVE_MOVE_PUD
 	select HAVE_PAGE_SIZE_4KB
 	select HAVE_PCI
+	select HAVE_ACPI_APEI if ACPI
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
-- 
2.43.0


