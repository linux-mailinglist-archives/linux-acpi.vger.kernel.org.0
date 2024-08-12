Return-Path: <linux-acpi+bounces-7510-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2345094E44B
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 03:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C21321F21E9A
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 01:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066A0C8F6;
	Mon, 12 Aug 2024 01:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="GNNcUdik"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767D317556
	for <linux-acpi@vger.kernel.org>; Mon, 12 Aug 2024 01:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723424414; cv=none; b=Kpcsdm/tezq6aTUyr5oIIyIA76XPn3FUG+VW8j23PU7YS7a99X2jIm6N2R2g/Hkt8eZfE2ea8bFdykEjTzvbMkXNEki8IclMF9CVeEDRmihgAOKrI+8+Bv6+eNdl4h5F/0TfT/bYxVsONQBiIsY912n+uAwiyXfV5eYkoeZpIrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723424414; c=relaxed/simple;
	bh=Vcq+n8JQdTk3vmf6hqmLO7PiXIRS5Btk4ojcnv75rJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dZ+abVJbx7kg26O1vlXtEPf6chhsefnzt+ox3yYo5vT2ZY2Aw7QIL68cY9SbxYWwZTgDIeKwixwUtWK8dac70+J/m0zsxLD9yyKuUKdVnlbb4j40Qf6eymTIXsSUOaAssBsXQoJEz00lr1uXdpyGyDpM3V1ny1k5Tjxvrj63+zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=GNNcUdik; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7c3e0a3c444so627310a12.1
        for <linux-acpi@vger.kernel.org>; Sun, 11 Aug 2024 18:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1723424413; x=1724029213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJwTiJ9RwivJpxYHWXKjwIEWKuv7B7ooXczAECPccKA=;
        b=GNNcUdikKsWtnzLHTFz4yF7DfWuZtjqDRc4cvfjQsyu9qRcL6ZZ/E3rb2eYGfkYqsW
         YIHPfeeKa6vTZ7dgD2cFQGACQ1NW+HJDBzy6oF8tKpPTH5DOCatpknaOLwF6Ou9ifKU9
         6k1KkH0H44jFAf30Cm/xocA8PLZRq87DmXRpD+4dehf5/btReVM/vB37uhP++Uk/Cg6D
         yuICpdolKl4tx4kAp0xrpahfBGbOg9Wp52GtMVl2tfXuJCkAXRNIaDnnOic37FmSukMi
         9ysjltXUN8vGKVCwzWQGLnCZlqRZyXQXfUWnEYu9eGRQkTtQX9aEqliJrQed6OuRopJa
         nQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723424413; x=1724029213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJwTiJ9RwivJpxYHWXKjwIEWKuv7B7ooXczAECPccKA=;
        b=E5XptM/qT3HLhIwdodRqgzc5WRYfVnTdl9HFXf/7KZ20m9KiblCDuBUpSqZfD91u+g
         dkRUuCZwfEHsqaDEinM1lKbUWxFXPQVHbd5Y0eFhb7EpXOKQjdluicn4ipf7rQG2AaPm
         E1h5YkKXvwjf4bjnPUs+kiMX6aMvXAM91iHcfI6J/X642w065raa/u8XWgFOBXpg+8+M
         PGzhxtTGQbfW2YOfX/0We9+S0yTA411hSfKOg+fCx8V6X7eN2ezOc+y8QM56uj29S/vr
         93GwkdpH+9ilA2j9NBuADV3QwgHpiDO37CKvIMJLMFHtDxMH10uelOSTd28hAZbuxxpy
         zEQg==
X-Forwarded-Encrypted: i=1; AJvYcCVXOa2BXuIfhbDkQPUYGRxZ5UKlHB8f64pkLccDelWjTtr8y5LBi8RwNB4ziSRRQ8a/zuN0+e0yPMGRZ+zlMq+bNv3dmcU165lNvg==
X-Gm-Message-State: AOJu0YzIxV0Bk5M3sHdF95buH4Z70cLZPIhfcr68TohjMmS/GfzUWj4/
	z1N7qFxCMbujyy2o2v7CHCBj92SstetbsMt6iOHB5hrtWk+iTVPcNe66mZyw8VM=
X-Google-Smtp-Source: AGHT+IEe5Qz6cd7b/1zBihHx5AlfGtYBeT8sDhSQ+DFn35gv+sWFK8VgaNh+IQbBrU4whiezDiQL7g==
X-Received: by 2002:a17:902:e5c2:b0:1fd:8f7b:1e88 with SMTP id d9443c01a7336-2009681bff6mr206131935ad.12.1723424412492;
        Sun, 11 Aug 2024 18:00:12 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c3dbe8cbdcsm3074062a12.61.2024.08.11.18.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 18:00:12 -0700 (PDT)
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
Subject: [PATCH v8 05/17] ACPI: scan: Add RISC-V interrupt controllers to honor list
Date: Mon, 12 Aug 2024 06:29:17 +0530
Message-ID: <20240812005929.113499-6-sunilvl@ventanamicro.com>
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

RISC-V PLIC and APLIC will have dependency from devices using GSI. So, add
these devices to the honor list.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Tested-by: Björn Töpel <bjorn@rivosinc.com>
---
 drivers/acpi/scan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 374cae4aef78..39b3ccae9f79 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -861,6 +861,8 @@ static const char * const acpi_honor_dep_ids[] = {
 	"INTC1095", /* IVSC (ADL) driver must be loaded to allow i2c access to camera sensors */
 	"INTC100A", /* IVSC (RPL) driver must be loaded to allow i2c access to camera sensors */
 	"INTC10CF", /* IVSC (MTL) driver must be loaded to allow i2c access to camera sensors */
+	"RSCV0001", /* RISC-V PLIC */
+	"RSCV0002", /* RISC-V APLIC */
 	NULL
 };
 
-- 
2.43.0


