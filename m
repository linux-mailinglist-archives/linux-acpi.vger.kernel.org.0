Return-Path: <linux-acpi+bounces-11550-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07090A47DFA
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 13:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDE2517181C
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 12:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E752B22F38C;
	Thu, 27 Feb 2025 12:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="FrxGrIna"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5059322DF86
	for <linux-acpi@vger.kernel.org>; Thu, 27 Feb 2025 12:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740659836; cv=none; b=oCNaKyIsVSFCewvdjERkIB4qEb/LfN7Y7O01+OXXVBXobuywJbWNkl2GcUnFDYPZp2e53j60lWNHhRdZI74pwhnrS8RU2+3wb9LDp7IMdW6IKoLV0+xZLmwYaLbnHDkfxr+esroGy2AK71cU5eko40S1ColSHtOPEF9SPaq5ZQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740659836; c=relaxed/simple;
	bh=nwb9jXPHNocc0BR85JL7p0Pq9kLj9IODjbMJ59HBlc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lzFr0ozWdsDbH6r0IrgdyB1bhkiewidxx2+Nb736Fm0H/im4wTKG5t9IH3CmjwJXWY1klNfSrLwjKE5/Hs57rSgXA1abJKsbCELSU5lPQOOXkyPlbhZizHLmXeqyypdpeS0qM0k0btjAb01qmbScdD8gGBmfPTyvBOxnL7TSF2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=FrxGrIna; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22337bc9ac3so14395945ad.1
        for <linux-acpi@vger.kernel.org>; Thu, 27 Feb 2025 04:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1740659835; x=1741264635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNRn4grONdQPyJNJQgM7dzqjQjDGa6sfyVxFxG4j7Yo=;
        b=FrxGrInaEMo2o+tNyEgcDBM/rqIyuObzmxmjHxzGGm1WeD/h9+FEz0P5Q8th6tnPHt
         KbZCSleoKgCVflj4glTlmecBuaYMf/46rnlRvnbmh/MiDbbuymDrFnW6ECnIoYCANAy7
         b5uHOgZJQOTpGVHLRKq5V6HFFGef7n5k1CXvnOGEYULRH7axeh6nWH0XaP0EyKtT9YMN
         Gi/eE1rf5ENt6TKsBy3sxI5mGGeMqQQDrzJ+Yu3OOVSBU2vb/Z0et4jHcIUAQ5v9lNcs
         I/fKbxgQVKRwWq9JeGDDsTuzwH6bin9anKJUl+Ima9wR/3PzewQZGAL1MXVPKAiKm9e1
         +iSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740659835; x=1741264635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TNRn4grONdQPyJNJQgM7dzqjQjDGa6sfyVxFxG4j7Yo=;
        b=YNmgLCFzKrVumXCWvOZeqZhcuZakUNOsqSNFpBUbJ8Qu0jfadTkAe7XsbxWstSqVse
         R29n6dkjwh+0fsnadV7X7ZrKGpE8o2p0SfkBVlooetO5jqQtb2fatH44lIDsFQR793cv
         vE0DGeE9EIKqmHc3MaOBm6KNgsjjWgb3JMn7UY3zktYGyo+hyO/OH3+Hlg9jijQcZ0AZ
         gH2bD4gTt8vTax4TenXsR3TLhzEbQQAVfhn1gjKOyhn2gc2xICqG1hfMDtP1/8MYpKHR
         m1tQvU5Q9+G0ujuVlimcb1PgFtSCRHj7W+wdVCmNCHRerAo2RkKJocCy+YaHFxtcwZoB
         s11Q==
X-Forwarded-Encrypted: i=1; AJvYcCXQS5EtBxNHDMe4sWngXsfqxCZZIrF/FHXd8DYp3lHGJwqKJJfp6iDuAz9SeVHfaIiCkMeCCKMu7eER@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6uqXxnIzJ9E/r33IQ5AMVmHfIqJs2MQxwbj6zz5unrRn6/S8U
	/wb0W1xdhin1cevR/3xdj+wgqPp9ldyC1FPKKLYfgIA3LknmUy1d4Cuwv68iKFE=
X-Gm-Gg: ASbGncsbJNkKBoiy6YiU55HC0ISOkCje8sf0SXR0wBUQLEpNLc0T0JSYx8tGeeu0D9E
	1Yh2WXjTjbDUKZnj4YC7AyL8I7hbvksLRyU8oaNdKc2TfYXc9bq+9HfT8IAcET4RsHuMpxu18QS
	CVtVH+tIcg3v4Pp/3mkv0f9iSrhRDC5w06JhZ2iSNaEn8mjfmwe3A5CVTqpSsJ7JN+eurb3Z3uU
	OhGBQSlsVnD0dgoIM3pBYaDLRaBBUntlmxzl7oFr+MXEji7KFjcHwEBHITwf9+/jCbdrzBmmTtW
	ZI7tCKQG86V6k41YDlSOXdo8Spw4uwa4E5d9
X-Google-Smtp-Source: AGHT+IG53PBDiu6FVTVuBFXKbMl/pH0m+lbJmkXDl+xjPCROuVKlD+c6+Y7yRaOAw5SWzcbapXcaKA==
X-Received: by 2002:a17:902:e752:b0:223:3bf6:7e6a with SMTP id d9443c01a7336-2233bf6806bmr72051025ad.12.1740659834816;
        Thu, 27 Feb 2025 04:37:14 -0800 (PST)
Received: from ventana-bhyve.. ([49.37.249.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5bddsm13219135ad.140.2025.02.27.04.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:37:14 -0800 (PST)
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
Subject: [RFC PATCH v1 07/10] riscv: Add RISC-V entries in processor type and ISA strings
Date: Thu, 27 Feb 2025 18:06:25 +0530
Message-ID: <20250227123628.2931490-8-hchauhan@ventanamicro.com>
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

- Add RISCV in processor type
- Add RISCV32/64 in ISA

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 drivers/firmware/efi/cper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index b69e68ef3f02..f2908296a48f 100644
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


