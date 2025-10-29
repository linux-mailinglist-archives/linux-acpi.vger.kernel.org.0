Return-Path: <linux-acpi+bounces-18315-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC27C1A050
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 12:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF8421894B15
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 11:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11E5331A4C;
	Wed, 29 Oct 2025 11:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="KsGXi5Kp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B4C3314B3
	for <linux-acpi@vger.kernel.org>; Wed, 29 Oct 2025 11:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761737231; cv=none; b=Q9QmddVEon6AuyrasQCZX91J32suly9RN0OVrTlMxiMQF1DLSA5CJEB6tEwPTSb0j3q/230EzBDo+BuHn6BlIRpB3MiDO2hu+mScAOOsz4lgitIjowgejJnPanW/ZTsMciCgymh6yS+vYc6+EWeaTA0hwKg3YuIK9oMScOO9LCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761737231; c=relaxed/simple;
	bh=xZ3ZGRZyyesAYiVSJppgbzc/6wpmKcXOnx/IFbeBZY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j1qJbuqJmZuFNtQxeGd4onrPax07cZR6a2uvA/sCffQO78/p+hpk3izNdYqqAXtvUaKZGRiVWN0ytL+nneFUzd25SiMHiKuHFKM6H3949tNglceWrBKBI7DSER3rqbMEOoct6m149n9x+mVjBdhbzNucVkCtrsphZwdoZr2mWGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=KsGXi5Kp; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-33292adb180so7236462a91.3
        for <linux-acpi@vger.kernel.org>; Wed, 29 Oct 2025 04:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1761737229; x=1762342029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fc2pmS4Yu1PyEFNeNlAsHoxFDYNywDlEMWQLdy1zt3o=;
        b=KsGXi5KppNs02/pneO9yLUQjhUPG/sVUpEifv5AsL7S0cJmlOETyulMh0j6qoUTBze
         cDL4hwaZxA1qr4aU3B8pvs22ERpQSlccLOzL9l63tqb8oPELiKyW3bP6IAs+KwMMWLr1
         +bAT5d8WVCZzSRYz9r8BnD2k5DOaVhRGqWBUWCxRqoVGJL5ysF32CxePnM85N6ZufQdR
         NgXgLKY5RVrnx+Ha+ba9YyjmhZTwhCXrq33l1INaZgO/tXVu8oSVX2bwnxl+MoAiy3Kj
         ohiZedkNnqIm5JtwuQQJURXVzBHrgDrE9FoSX9j3EqdE+4FwnrVxB4ynJ9SS6ksXphuo
         81XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761737229; x=1762342029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fc2pmS4Yu1PyEFNeNlAsHoxFDYNywDlEMWQLdy1zt3o=;
        b=PsjJxHKV0sHIpR+KzgFSoke51W+rxETNMH+rfBis3spJ6dt5Ab8jugj5HAZwys7SCz
         9ebVesy7hxRDjfUlOvNaCf0jnibkdpnyyMbWjpzBi9F+y8xq4VqtCMkUpbQQkzjjvF+X
         P0f0s1WG2cjMovRxEonfaviqPnxFcsDOM2XJa8PF2lqwOaRmdwckrHgyAGFAfODMiWXN
         9nSf4AmgnXIcFOgmXLh2+0Ayzws+8QIpZXo4q13v3R66U5lpaK5rb9vCLIV82Lm9uLMU
         ejI6tpKigiPHUf3vFa/l9jFL6HR9z90edT34yaA8RYYQO3TJOCqwakdN6JuzpXy784e4
         wtSA==
X-Forwarded-Encrypted: i=1; AJvYcCU6EFl8OiH6zVraS6/Q09fNzNoQxSamwReO+mkfhf7qqP5WZ39AOBDl8VdaETo9qH2MaOrlnhKiwkn8@vger.kernel.org
X-Gm-Message-State: AOJu0YwEhlL1Wv0cs8/V47HGVQKQmw6yqzKyy61KJsEeaehnt9fBwQ01
	mniG4ahy+153U3am15o2biox2RTKmAQlN4uGa70FsZqIpRWH4XEj3gefxBUEr+mRAII=
X-Gm-Gg: ASbGnctrrqr36AY3mg7yBXCubNyLVYBtG26XrtfXplj2ccJrHtie9mPG7C7Wc+HRmdn
	wxI+XpmAZAqaSeZwBQCTNkBbLSSCDTy5h5mHDgG8QBjuY/lGtfKlElpty10fv9iXxJQuepBPmsT
	Nm9YwIdk5wS5s4vKc4LRHjEo7G739XrFgZkv/+YtgWEo+aLStflPJsDCmS3yLVH+iyHNn5r1uAk
	zmj9YWkCXV1mPCwsSF0nN/1fEiJN5PW7uYL5rOFb8j+Vw/DbrwgWqpAuONtmlMatFx5mE9qdxeJ
	E6B3VdT19OVpvTgSpA/Xa8mlgdBdGucpXcdx/prD6xjRneg9GviPLHXd/BwIKEq1/IGCnW/unhQ
	h3lelST+prb7FCunP22KJfc0svFa4VsT8LiEcFSJk8X2Pp2Nxhoq7Wn+Wcvk+0dsD/CXZ8xrxQA
	Em3RvMV68k1xL4eylzLCurXT3TjiAZ
X-Google-Smtp-Source: AGHT+IGEAqFeWf0ftjlgJx4OkwPZYhleAzhblNhIB2XsxH/EACVURZv5OiId6pITaCbKSnoGThy0lA==
X-Received: by 2002:a17:90b:2811:b0:330:6f13:53fc with SMTP id 98e67ed59e1d1-3403a290f88mr2790213a91.27.1761737228426;
        Wed, 29 Oct 2025 04:27:08 -0700 (PDT)
Received: from ventana-desktop.localhost ([2405:201:d019:c0ce:f7f5:7789:48e5:c03f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7f6040sm15316918a91.16.2025.10.29.04.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 04:27:08 -0700 (PDT)
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
Subject: [RFC PATCH v2 01/10] riscv: Define ioremap_cache for RISC-V
Date: Wed, 29 Oct 2025 16:56:39 +0530
Message-ID: <20251029112649.3811657-2-hchauhan@ventanamicro.com>
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

bert and einj drivers use ioremap_cache for mapping entries
but ioremap_cache is not defined for RISC-V.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 arch/riscv/include/asm/io.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
index 09bb5f57a9d3..5550b28f38db 100644
--- a/arch/riscv/include/asm/io.h
+++ b/arch/riscv/include/asm/io.h
@@ -142,6 +142,9 @@ __io_writes_outs(outs, u64, q, __io_pbr(), __io_paw())
 #ifdef CONFIG_MMU
 #define arch_memremap_wb(addr, size, flags)	\
 	((__force void *)ioremap_prot((addr), (size), __pgprot(_PAGE_KERNEL)))
+
+#define ioremap_cache(addr, size)					\
+	((__force void *)ioremap_prot((addr), (size), PAGE_KERNEL))
 #endif
 
 #endif /* _ASM_RISCV_IO_H */
-- 
2.43.0


