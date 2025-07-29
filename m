Return-Path: <linux-acpi+bounces-15410-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 412D1B14E3C
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Jul 2025 15:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D41218A2F22
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Jul 2025 13:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8204D17A31D;
	Tue, 29 Jul 2025 13:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="M6xUkeKd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48283FB31
	for <linux-acpi@vger.kernel.org>; Tue, 29 Jul 2025 13:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753794952; cv=none; b=d3OLatlkIFRvATwdpqzyCajcywrEKk6n0SSoNkIXDn09uvB5ei4pCIi1Tcy2avg51tomXwJ/07h8GDELLniHaSJOSGEeC3lIIMHk/AXXfN34BVWMuiAm6B6l3DybU9Momfdl2Bg0QEbPxn2a4Q52+JGO9M54/zs49WZUmM+cgWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753794952; c=relaxed/simple;
	bh=30m+wpBeV7sO84PVOH9cp3Flo+o17t35qnTyOhq3ztQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iohPjVJQ+RgLIP3LF9NxOeEngiHDFt3r+NgLx0cORyTkx0fv4WxsajUTRxjH20HFCBM1nzQ+x0M/nFq5CoEBWC8YOT6NnGK2CaDcka/SSD+JIOHuPCQhDfe+CVkDAh14+5tZTswtj2zWA9EfVGYDHy6L1tXR4C2ccDN9sqORT8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=M6xUkeKd; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 56AAA3F641
	for <linux-acpi@vger.kernel.org>; Tue, 29 Jul 2025 13:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1753794942;
	bh=0675nP1c4f7LfG6VM+ssWqBgKXw69YZUUaqh2DpxFLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=M6xUkeKdEk1wszpC3P2gNT4nfMTx5DrZwRGTRoPlfDQCmhmbX9f+kcs6XlQVLlH5v
	 Pz2Tk9BDGfYXSB8J+Fd/IY0wi7V0EVqTbFiFdoyf8lT8W4bgctXRjTnbEogWT82LV6
	 LYZ8QwgDR04fsibLTpJSjfFvudUQPaSH3K30airSEgDiIDQmk35IBnv7mg8szrINbh
	 9lGOKIHEdG5yj1l76mNF2PbasIVl9I9kv/7XgsZbUV5yw/WIEoKvCRdtsVB3feMGqp
	 Xt+QdwYkkpQeSiRID3U+BNnxR9HtjXUHb/GmxdcQQCbtj8AWFZeesOWntgzAQzlMta
	 UQei+3U3JOVhA==
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-455e9e09afeso19896875e9.2
        for <linux-acpi@vger.kernel.org>; Tue, 29 Jul 2025 06:15:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753794942; x=1754399742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0675nP1c4f7LfG6VM+ssWqBgKXw69YZUUaqh2DpxFLE=;
        b=PWxaffh0slGfB9k3dnHdQlx8YaSAV0OdM1gzxolKImOhbuA9Gksj2ctyN4L5d5epv1
         JAcDvLhUsyALg+gdrneqpqAXP860XRoDFGBKg/Kf6TWWJKFyrzULCQRIb+TFRVjWXjCT
         r8Px9EQYkWOyehhSx9Y9wkjpC5bpT+BbeLBtPuaAaT+HZZpYRsISPXRRoLxOIZHqQSu1
         dOtVOcTXG1pymma+BMJLMOPKjSpNZ4QouTsdmvCXMaqBQJYn6W4y0GQQIka0VCTvwB9y
         RxBN+5sGf2bRyRNicC9FVbdOayjfugwdy0J3r8pJptsZ1E9rX8K+h04W0fFQLqkf/fA7
         vUWA==
X-Forwarded-Encrypted: i=1; AJvYcCWELyFvLB9yF/AKD7tk1EVdwuv/TuYMrFJVTxKO+zReNHTB8B/UwzKH1ckXhebSBLXm92o3eKR2/WHT@vger.kernel.org
X-Gm-Message-State: AOJu0YzdK1QEyFHYb/MoCEfjyRUDxDqiB97DKfxHnmT3CtNy43PcQi8q
	KEzSiGdfYcnahgFTC+oa79YOg6sRg+Qo/37IJfRBj7H2WNe/+7C23eOx4cpBnv/Jl8dZR1chy8c
	HSNBMV5JC8saaYOC79Cujim1lUwU8ZCmVLubqyaNYyTaq0FhKPrO2N1WLFXDQ3rg3/RPPM/DXzY
	H1brk=
X-Gm-Gg: ASbGnctfB/ThLLuIHOCE/XKQN6plNE9J+xbGeTJhvNLTxQhxOdl3fTUgg3MEniHicpq
	w2FK+oeCG8d+1UgMyrqd1hl8UzQ01NTQRl4fgYgcvEq4gX3A842t9sDjgSlqvnE3YEYRfBDUtkT
	I09+HzNB4OrRz8gXOBXabhqjOZLlUm6fh4tW2JHlXvX8q9IhzDdByN/YUI26hghldYOQUAnYh3H
	BUQbuaRnvQitBV4Xb+Cj8S0AzKTA3Lev07JVW9FnMG3j26OYn5fUt4RsO9/Ehx5tL5X8rqrFzUz
	zZ/1HklzrTXRPjqQbFTKf9dik8lNawbx9zVWJtwJHp3Er52nKIZujg5bhWcsrut8VNE+IjtaU+/
	7ndW4N9tzsfyXjdQmsnzRVlqPtBQ7zg==
X-Received: by 2002:a05:600c:3510:b0:456:2698:d4d9 with SMTP id 5b1f17b1804b1-458762fd2acmr137350665e9.3.1753794941859;
        Tue, 29 Jul 2025 06:15:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZvwVRiKsT7wS30tgGHiJnVmDKGNcXlgxTTqdd4YwYAyoY3NMdFL5ZkFUfhAD5/m/bpZyuMQ==
X-Received: by 2002:a05:600c:3510:b0:456:2698:d4d9 with SMTP id 5b1f17b1804b1-458762fd2acmr137350395e9.3.1753794941456;
        Tue, 29 Jul 2025 06:15:41 -0700 (PDT)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b778eb9bdfsm12024338f8f.20.2025.07.29.06.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 06:15:40 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexandre Ghiti <alex@ghiti.fr>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	linux-riscv@lists.infradead.org,
	kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/2] RISC-V: ACPI: enable parsing the BGRT table
Date: Tue, 29 Jul 2025 15:15:34 +0200
Message-ID: <20250729131535.522205-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250729131535.522205-1-heinrich.schuchardt@canonical.com>
References: <20250729131535.522205-1-heinrich.schuchardt@canonical.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BGRT table is used to display a vendor logo during the boot process.
Add the code for parsing it.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/riscv/kernel/acpi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
index 3f6d5a6789e87..71698ee11621a 100644
--- a/arch/riscv/kernel/acpi.c
+++ b/arch/riscv/kernel/acpi.c
@@ -14,6 +14,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/efi-bgrt.h>
 #include <linux/efi.h>
 #include <linux/io.h>
 #include <linux/memblock.h>
@@ -160,6 +161,8 @@ void __init acpi_boot_table_init(void)
 			early_init_dt_scan_chosen_stdout();
 	} else {
 		acpi_parse_spcr(earlycon_acpi_spcr_enable, true);
+		if (IS_ENABLED(CONFIG_ACPI_BGRT))
+			acpi_table_parse(ACPI_SIG_BGRT, acpi_parse_bgrt);
 	}
 }
 
-- 
2.50.0


