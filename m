Return-Path: <linux-acpi+bounces-16564-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6318B51293
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 11:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D11A46579D
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 09:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB21313E15;
	Wed, 10 Sep 2025 09:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="r9njdxEu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F381E3128A4;
	Wed, 10 Sep 2025 09:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757496859; cv=none; b=Zb8wCJTQ4sR0yDtEMGTQKVPC+rG50F8hLgDMveRft33TDPeo+Lz46onJE8x4bKUEtrDWQ9opGKxJbHzaMSwOJw2m7slDXSVkYL4VE3ZPBf/E33JN7MQ9fkCTKs/PTwSLVEDk2JjSldcQH1angnDz9mzlDrrsTP7nlf16TVgN3n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757496859; c=relaxed/simple;
	bh=G2oIlx5+3F0uTA2qs+8gy1BOtO3oFBeT4X0nl6deiXY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xjh4fS48pwegJgLRvunFDNrHOIDB62vgHEy2B1/hDiPj1g88A29hBgK3kfVQG0ZUs74e9O9/NUJNt2sw4SkdpxYY+rcsAQhsmwfF8d6o3BPVowuYDGbV/rbKgz7Upn+sWzu4rLDsq0bE0toetiwWqzwZrLAHfKaPXVEggPiP5JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=r9njdxEu; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757496845; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Pr8EoGstQtjK3lXgH2CmjXH5Mo22c8CU5zRjW49QuUo=;
	b=r9njdxEuxYheWutRTgpNbkUXDTARsCF0u2IV7NsJDJhXdwCo3VSidLssZw3GI7pMlpnivDWtQAUfjqLbc/iBAqqMqlBZ0qxJf9GKUPC/p8KHP30AXg3R+kM44TOCrRVOFZ9FdkBNjl8IvezwT6Yv0TD2p6EDFuMtXuedm2CPRGI=
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0WnhhBqV_1757496843 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 10 Sep 2025 17:34:05 +0800
From: Ruidong Tian <tianruidong@linux.alibaba.com>
To: xueshuai@linux.alibaba.com,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: james.morse@arm.com,
	tony.luck@intel.com,
	cleger@rivosinc.com,
	hchauhan@ventanamicro.com,
	tianruidong@linux.alibaba.com
Subject: [RFC PATCH 3/5] acpi: Introduce SSE and HEE in HEST notification types
Date: Wed, 10 Sep 2025 17:33:45 +0800
Message-Id: <20250910093347.75822-4-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20250910093347.75822-1-tianruidong@linux.alibaba.com>
References: <20250910093347.75822-1-tianruidong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce atwo new HEST notification type for RISC-V Hardware
Error Exception and SSE. The GHES entry's notification structure
contains the notification to be used for a given error source.

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 include/acpi/actbl1.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 99fd1588ff38..0f04ef10f510 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1534,7 +1534,9 @@ enum acpi_hest_notify_types {
 	ACPI_HEST_NOTIFY_SEI = 9,	/* ACPI 6.1 */
 	ACPI_HEST_NOTIFY_GSIV = 10,	/* ACPI 6.1 */
 	ACPI_HEST_NOTIFY_SOFTWARE_DELEGATED = 11,	/* ACPI 6.2 */
-	ACPI_HEST_NOTIFY_RESERVED = 12	/* 12 and greater are reserved */
+	ACPI_HEST_NOTIFY_SSE = 12, /* RISCV SSE */
+	ACPI_HEST_NOTIFY_HEE = 13, /* RISCV Hardware Error Exception */
+	ACPI_HEST_NOTIFY_RESERVED = 14	/* 14 and greater are reserved */
 };
 
 /* Values for config_write_enable bitfield above */
-- 
2.43.7


