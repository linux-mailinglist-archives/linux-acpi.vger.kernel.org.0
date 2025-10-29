Return-Path: <linux-acpi+bounces-18322-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 405D9C1A08A
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 12:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F9781B26219
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 11:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1943337B85;
	Wed, 29 Oct 2025 11:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="pe54++yt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4D6333720
	for <linux-acpi@vger.kernel.org>; Wed, 29 Oct 2025 11:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761737276; cv=none; b=Ad+uXXQ+IxBw6muBaOxXcMDXYglSH6+ta8v6FoyKKrzqwRbdGHb6ZcR4Ihw3QgypmfpZRjySEHJ0vWBlPii2IJluIfRTpFaN2Jc2VYvyGu09Fh0MVPuomn1E6yrj3sGr3HVR06T7qH2aXmFueYc/58VgE5S9cYkkiuPlVhLf48k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761737276; c=relaxed/simple;
	bh=TilcVfmqeN4S9SQk/86dbqTu5JigqINDawfpL8vf2DE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jr4LKZQ+yxOX4Q0gKIXz0d3KgtRR6YbjhNsaFYvuuIE8TLzoGB64525FqGjDimlnsCkJjhiWWdxiQ8DtWTkrn+daOUynFB7E2hClQ6H9kh2ndsy87SMBcAzIAFtrlGeVWH6BDanoGoChc6XMSpdOL3taKl50dJpdvf01XShG/Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=pe54++yt; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-33be037cf73so7461679a91.2
        for <linux-acpi@vger.kernel.org>; Wed, 29 Oct 2025 04:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1761737270; x=1762342070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wd49FUCFXP7v439aOYgrBhlMaMpFr/VqGWFeAvQumyw=;
        b=pe54++ytCggU8LUi7x8xTGTKHGjO3vSbxsgPKrzECz5/xwulrRYqwC6Mm4exFUbA2C
         1Y9D3DQ5+XMTdzLSseE5XbFvdarBmLYhdycKL57E7u6ftnJISGXvT+U06JCaXWeGFAKv
         FxT+FXDjmoIkdoQCEbhpbFLP5tf3+fDfnjNjOxMNyY8kPGcAKsnGCNqar3BOPmEZ60CU
         cCYOez+eeRb5zoHlmRIxuhwvLpb8b0s9hJAn1frBZ3+ias5YV4lk2P5ia3sA48glunZ7
         kx3blCT5+wamtPadOIjlscqVSCE2kjwK9ai24wB9ecdycIxNBFDv3H9QqwCrKWpp3qQ+
         EOxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761737270; x=1762342070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wd49FUCFXP7v439aOYgrBhlMaMpFr/VqGWFeAvQumyw=;
        b=SVLhZDOaflou6qRl9mkBfZpLSqHndYh8ssvnKxxFEko6tWXaY2zmNXThPO0dD0Gqnl
         ZLBCmhVFMMFP/p4Bfj5tfVEoEMVWoN9VOelL5KqSB48VRhixmz9tsPVGZ3Oi+tePiD40
         KM5AvoTcQNgWf6SttMZNU2KowAT3cWa9yCzuFneye0ULt+bDQiFIVE/1smEJMKwvmEJm
         TS7KNtTWHh5m9CmbtqaeH/bRFF0Ue/Y1gVFHpXcT3e068faw8GrSIpIsgtK4Gqq9kbSR
         eqKedTZUYMMkVLSuVlZGlKbAtGi9MFOH2myHqkAPZGZN5K6nnbGspf9rUHdpRU49Qw5G
         he8A==
X-Forwarded-Encrypted: i=1; AJvYcCWZ/8zjmAo2/eA+1by77icKicv1qpHW0W8OmI7WsKitsZRqzDma/YYfB6h7HuLuOVPoBATS4BMIdKFf@vger.kernel.org
X-Gm-Message-State: AOJu0Yxug9vZO+tucOM7Ec6loW55SCVcrO0XnD+V0aE8KTtvFFMxCZqn
	xNZZkj1w5mr8W0IeY16lLcimZf1ER8VwoND8Fwi3KKcQkvMc1+7F/0q3N1fMI8tpeAU=
X-Gm-Gg: ASbGncvrYGPOuTJKJpRiAaHDJgXNvgyy9IgZijeRL2ngMCcnlNSTnofMatHeJAkjGGa
	Gqz/0EVZ5mKCb/gxjbuxGqrl7a3s1+Z0aqn/5ueO2Wc+fV2UOs4W+8E9cJ9MPimRsTNx001KJ4L
	EZ5eB/1ALFIsX8y+C3UM0gvGYahSjny8QqVQ+OJ2yy89QI/JIUNU7J2fxdoNw0a4xkvCsHvYwFg
	7w6sqNl0/7/z0uWbdQfKgti6iFC1lBWW55hAc49BiLA0HhR87+tuUzArbBep5fa7L034+PArrPN
	ITYVACSWnoO2nahzQeO+eUH1DKpxFiWxelv1jjd30kOv4A0WizoikbvTf3EBti7bwy/XTmI9RcX
	EkV+oGerA/ijPeBkSm/rxZ7AcJESLqP7DQh4C02djI50tcFh9HE4Bn9+oL7eRYdYTDwleiTr69d
	F1frDmn64szMK9KyMrzMWr4FmY9gOK
X-Google-Smtp-Source: AGHT+IEwpD5L2Hn2Oj9/1NiPPKl78u4FeofUgufEwNswN516sCORZuI1gux4yna6NQqFE96u6vitOQ==
X-Received: by 2002:a17:90b:1f8a:b0:33f:eca0:47c6 with SMTP id 98e67ed59e1d1-3403a2f179cmr2624640a91.30.1761737269909;
        Wed, 29 Oct 2025 04:27:49 -0700 (PDT)
Received: from ventana-desktop.localhost ([2405:201:d019:c0ce:f7f5:7789:48e5:c03f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7f6040sm15316918a91.16.2025.10.29.04.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 04:27:49 -0700 (PDT)
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
Subject: [RFC PATCH v2 09/10] riscv: Select HAVE_ACPI_APEI required for RAS
Date: Wed, 29 Oct 2025 16:56:47 +0530
Message-ID: <20251029112649.3811657-10-hchauhan@ventanamicro.com>
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

Select the HAVE_ACPI_APEI option so that APEI GHES config options
are visible.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 22cda9c452d2..97aa3726e9f6 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -185,6 +185,7 @@ config RISCV
 	select HAVE_MOVE_PUD
 	select HAVE_PAGE_SIZE_4KB
 	select HAVE_PCI
+	select HAVE_ACPI_APEI if ACPI
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
-- 
2.43.0


