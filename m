Return-Path: <linux-acpi+bounces-18321-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C446C1A026
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 12:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 10E0A34A2F2
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 11:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90D53375C5;
	Wed, 29 Oct 2025 11:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="N5v2ul5D"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D592833031D
	for <linux-acpi@vger.kernel.org>; Wed, 29 Oct 2025 11:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761737261; cv=none; b=UbY1sFoJCdXL3OXTkOJDHCm6DrMinAVXuiDSUBc1MlL7M1NAVO/7bBUqI1++MVsTw/M9Xd7Zmxfu3PJ2m9zRSh7Svj71geTOW+SDz5zSX/VPK/UGgo1uXQVor10IBNktG3gs1Ufqfb4V90u4Hse/4cy7h9QwPe7OIKZ2vztYkU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761737261; c=relaxed/simple;
	bh=I4TEHisHhy81GfBk4tNwlY19gPH1ru3ik8bcWj4YLHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WTKlSGWE+QJzfSbSv5oUdiqTsqCa/lWh2megyCz2fQcaNwpt3q+3AXQRaGjdfbIfzOWYbn67LLnmwYlOJXA/vd6Dr3FDe6ff7Mx4sxbjb7o5NvP1n3B7M4lHCrKfbFrlxT9n+2YH6mcm6Y3aIrXMv3/nhJkJXO7oauLeU8EEhfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=N5v2ul5D; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b6ceba7c97eso6581655a12.0
        for <linux-acpi@vger.kernel.org>; Wed, 29 Oct 2025 04:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1761737259; x=1762342059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lu9PVTm9hjUdHoFQcU8g3rsnUfjy9F8yp+wWZYUCJFc=;
        b=N5v2ul5DYuPP6BS+JMG++hnvL8J8HGcOkejRFmUkaA5x/QCOPH52WwkH/89wzElRaT
         V4NArUDZwut/qZtnXm1M3vRUoj59DljRh7kRX/EChV2DImg27ScHSzeYjamP0vmvmg/D
         U122zUUCcI7TaTKcUwAZg9ZTZuIeenmAU3DR8t5siol1Pa9SeuTpp6jw/mBKZ4RVxmFm
         4OwS/1BF1UrFYkmNwDYUb+YFUpHBIQ3DFEIzVn2NNow5i2mhA9rAa6FlRdo8eYOqtCqi
         0ArmAuYyqiBShSXPj5Cvkb66/AKISaJ86J9FCOi3DJtrCF7vlDvUusECmRLgKM3S/cnD
         c3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761737259; x=1762342059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lu9PVTm9hjUdHoFQcU8g3rsnUfjy9F8yp+wWZYUCJFc=;
        b=CgOhKmk0KJmYD0x2panarD14Wfh4Ymamtd2kjiUSCWaLzsaOBPZA0MFFqbaP/sjcgj
         dsp4myjfKSpSwBCTdzbHlpGj+v6DOin9ct4S7sYmmibNDghZDHCanOFEVA+g/IcUSSWt
         PEwp0m8zjfXTn+ptNOoIVuguwj4wgnle77WNMaDSfsyKbuf8nQDkzSDOKcwqiGlVsxfJ
         8mE7bxg6zt/ZNixAcO48izFA87ThAFHsIGuPIjRro7xusR8i/TMvuMN1wtbg9XUw9vnj
         JOQC0vDCW+J1h2JfdfJZDmeHG/K7xfGOucc9MltXtyXyHghjJhzqWdyN80q/XJnHly6W
         0P1g==
X-Forwarded-Encrypted: i=1; AJvYcCUifAKJLS4Ei2w3qcn44KW44ZmAJy8dnW/HPhA25Ok07uf5UnOYhbq8PIwzKZRb82PL3eyFDKlmvA2j@vger.kernel.org
X-Gm-Message-State: AOJu0YzXjTUHWwKdxWk4jxRy75qwWJAUFNvOItKExL2elDjV4lA/J53g
	cooF4mzyLoUeio/6j3JdoRffCzRXfPS4mXEZv7fnwAfoqitxMOjVUC7vAuDAwqynbPw=
X-Gm-Gg: ASbGncteKRKRVpoxyHAMQRxWGb2gt9ciu9W83jT89bzkQRBQDSTTbaNRNiznC8lnmM0
	smUHEjCSb3vJtTPNg6NfA7MiA4u4E8OY7uTuPugKHkL0wUXA150xNtWeyVi50ipJIVwu6enLNm+
	5nRGnAKjUbtSLteVBZTD9YtQvxhCLHdCan8grrI4RsUrfP0/2OUL0+Y3EOeK+VrMgJctP02AaPL
	bVDFFxlHPngySzXKBqx3ia2/w4hECvNNcLtXdLeBmLUseoMn4iO/c+bi1WnB9lsvPZq9Twc537k
	5tF7GfnEdYDTCDLnXhg7EPgM5dJFjb/0m0vWX1i/pGrz4086AcdZK0MpZmFqvzESw79NNYzFfRx
	jEbC45+hROZBBnO+ihy5HTf8bZdGXQMdI725Ee5ih1RH8g9PGt6T9NUbbrEHEqsR5RBU9yDTzOG
	uueLIsbZEdJKa75pOzSk1gHyKYNzVpdbm0hatIZHU=
X-Google-Smtp-Source: AGHT+IEwNLyhot5qPJEYgE8ajY5jbwtZPlrijo+bkOA+9e521cPY2uChToY5FLnyugwQKON/wAVvRw==
X-Received: by 2002:a17:903:32c6:b0:24c:7bc6:7ac7 with SMTP id d9443c01a7336-294dee20a01mr33897975ad.18.1761737259146;
        Wed, 29 Oct 2025 04:27:39 -0700 (PDT)
Received: from ventana-desktop.localhost ([2405:201:d019:c0ce:f7f5:7789:48e5:c03f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7f6040sm15316918a91.16.2025.10.29.04.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 04:27:38 -0700 (PDT)
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
Subject: [RFC PATCH v2 07/10] riscv: Add RISC-V entries in processor type and ISA strings
Date: Wed, 29 Oct 2025 16:56:45 +0530
Message-ID: <20251029112649.3811657-8-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029112649.3811657-1-hchauhan@ventanamicro.com>
References: <20251029112649.3811657-1-hchauhan@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add RISCV and RISCV32/64 strings in the in processor type and ISA strings
respectively. These are defined for cper records.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 drivers/firmware/efi/cper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 928409199a1a..ebdd92ba1e15 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -110,6 +110,7 @@ static const char * const proc_type_strs[] = {
 	"IA32/X64",
 	"IA64",
 	"ARM",
+	"RISCV",
 };
 
 static const char * const proc_isa_strs[] = {
@@ -118,6 +119,8 @@ static const char * const proc_isa_strs[] = {
 	"X64",
 	"ARM A32/T32",
 	"ARM A64",
+	"RISCV32",
+	"RISCV64",
 };
 
 const char * const cper_proc_error_type_strs[] = {
-- 
2.43.0


