Return-Path: <linux-acpi+bounces-5036-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE6E8A587D
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Apr 2024 19:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3AFFB244CE
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Apr 2024 17:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F09984A58;
	Mon, 15 Apr 2024 17:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Syz5qiBo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84CE82C8E
	for <linux-acpi@vger.kernel.org>; Mon, 15 Apr 2024 17:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200545; cv=none; b=OW16jMupe5Ok6WlLSPuW1alBaLRGAzVmPFGtxX5iQAgoYV+Rm+xzQz8SzbiSlpkrixBNxc8w21QTcWcEy7qPMxr8lSfMBLtI0RJyB2R1Q2XMxQae3SGCc/hNn4/9ycvbo5kntZTib/8K9/ukigzQI7+bnIwBVgBztfkrzGmUa4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200545; c=relaxed/simple;
	bh=T/1Xcao9xH6emFSa1ilV8PdiC7xRbDw6sg4wGWt0SgA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hOQSdsjcYlawCjNYeVfNdzwBSEG4L0/DX0tjx+x+cbRpKgcybuFUsGkQS6J20sSvAqqGQQcl0/re5DTOjc50UR+yX3O1Au3N/QU+X3WRT5mkWKjz5oxEpb8FDtrPsfNpSyij/7uz/9A2C78ZTp0rYoObCMr/cjehdnnnrJT1ctU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Syz5qiBo; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ed32341906so3086850b3a.1
        for <linux-acpi@vger.kernel.org>; Mon, 15 Apr 2024 10:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713200543; x=1713805343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2LHe0TiKeYFnNPgLCeAe5BF4w5DQy6QPlu5Fs7U6q4=;
        b=Syz5qiBo9ORx5cGaitMszxDVZy+mpVYRakC1j8Wlnb/gtnQ9hKnM+I9Vy3sknKC4o2
         tyIVh6GW4p81OIiiOR2EiaPQ/Q/z6SiePljf0jPzjvKSMdRziEBEKC/0ktZ2AD0CbChM
         im1n7qPmvXLeRt8zYYW5IEAkEPk3I5vO1wfh6zPi+VceJnF3Zauq1pH+x3cvLoaGOkD4
         JicmEVydSeAsvTMhxlecj7ViHQ2+ETx8xXWMa5tPPH1b75Lt+bMNzVgn5J+hMssONM+o
         +RHnuXA4wSLE1zqLbvAlVk+x4oKm8hPGSPLFN+ypsn8FpJPtNo81gsdwmsBuOu5yCUL5
         yipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713200543; x=1713805343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W2LHe0TiKeYFnNPgLCeAe5BF4w5DQy6QPlu5Fs7U6q4=;
        b=I81hd905GULtjrGWhexldtIaYfp2F3NgxIMatgWjIWx/s48hkx71pp7hho8hrS4HJ7
         m9k0egSECIgf9UMe0OKGGAnOUnDUd0hwCLCZ4RPdU0aTXBVxZ0il1vSw3VnB5/pWeaFN
         vq7UfQNv5mlVRKSndr3yAZRxZ5gOERJbk/BGBDMsBKNm2DRpTuUgddD/a3VFz+wxQkxk
         sI9OOWvq+9Kn1NqtyH9o3poygzkFYLBDA5p2EWVhgD5HwsWzMp+rvGaPNesRvURneqOU
         gLHRXDGTVwxT7Ia1gi227bYttEglJsDfpauU5oli3XNx5pLcWRqbyltE9IUeu40kjUfW
         57OA==
X-Forwarded-Encrypted: i=1; AJvYcCVLsnNNUau8ga5SnRBukJvaHfYdB2nwqrr5mERFEHh2aXSrxC9V8vxObHHg/VQsoW2WLrTLUgl5V3XGWsblkB0OevLQSx8v/5jHCQ==
X-Gm-Message-State: AOJu0YyoFXbi9vz67TdoKWYp23Jn1TT0CTyLGMYXN2eNkBYAdeQd/G4m
	KE+FBvNhsRQMDsLV3s7ZyFoecycNFljltSvRJjgN69U17PJeuEd9vdMR8djBQfE=
X-Google-Smtp-Source: AGHT+IHZPG6wbKkbl+YL/8OPMELdPpFA9RlWoys/7cQw/AgmouLy6gSngELWynfeqJUNk2wi6bZfdA==
X-Received: by 2002:a05:6a00:3d0f:b0:6ed:41f3:431d with SMTP id lo15-20020a056a003d0f00b006ed41f3431dmr11412835pfb.0.1713200543335;
        Mon, 15 Apr 2024 10:02:23 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.230])
        by smtp.gmail.com with ESMTPSA id 1-20020a056a00072100b006ed045e3a70sm7433158pfm.25.2024.04.15.10.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 10:02:22 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev
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
	Samuel Holland <samuel.holland@sifive.com>,
	Robert Moore <robert.moore@intel.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Andrei Warkentin <andrei.warkentin@intel.com>,
	Marc Zyngier <maz@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [RFC PATCH v4 09/20] drivers/acpi/scan.c: Update _DEP honor list
Date: Mon, 15 Apr 2024 22:31:02 +0530
Message-Id: <20240415170113.662318-10-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240415170113.662318-1-sunilvl@ventanamicro.com>
References: <20240415170113.662318-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RISC-V PLIC and APLIC will have _DEP from devices using GSI. So, add
these devices into the honor list.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/scan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index c8f40d81b6cb..07e91616b7d4 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -832,6 +832,8 @@ static const char * const acpi_honor_dep_ids[] = {
 	"INTC1095", /* IVSC (ADL) driver must be loaded to allow i2c access to camera sensors */
 	"INTC100A", /* IVSC (RPL) driver must be loaded to allow i2c access to camera sensors */
 	"INTC10CF", /* IVSC (MTL) driver must be loaded to allow i2c access to camera sensors */
+	"RSCV0001", /* RISC-V PLIC */
+	"RSCV0002", /* RISC-V APLIC */
 	NULL
 };
 
-- 
2.40.1


