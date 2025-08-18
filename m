Return-Path: <linux-acpi+bounces-15800-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D67B2AB82
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 16:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BD1D587F31
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 14:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7C831E11F;
	Mon, 18 Aug 2025 14:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="M98z+0jz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C423203BE
	for <linux-acpi@vger.kernel.org>; Mon, 18 Aug 2025 14:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755527813; cv=none; b=QaCq7G6vQmJzjmGTMgGHCcpFzb4bNqkshNaz5wr4rmncJiRo2Op9CHYnmUcho+JJjMUmiXYJmzYgtIjX3XlPIkN9hZKxde3YQdHF3IG3/qPmvnygvisxz5cw7Yg+gED6GJQuZBMwz43ePaeGd4JgxUTKe+rpDZzZovQZIvZdTDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755527813; c=relaxed/simple;
	bh=xtTVVvYKRT3zqG7WMPSmZmZl0Wr4uI0gO0PQOWeY0ME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q7ahL3voUmzrUQB3dcG74ICbZRBMBx8qEeyiTj/sLj0iSHd87v5aBt6EbdqZR86MBSkmTA7oYb7vQ5lq/Z4BUNqcm3h/J8W7yWhlZzt5eHe9ObZa7Jh2KIw+/O4fQ1nyF937dEC6OwwhrwiD/ywWGzZACe5EXqsK6hXZs8HYgaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=M98z+0jz; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b471aaa085aso2406369a12.0
        for <linux-acpi@vger.kernel.org>; Mon, 18 Aug 2025 07:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755527811; x=1756132611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQbiLTQGi4sOYDMKTFgGpWiNF5qAYuHZ+4Lz0Qn0zrE=;
        b=M98z+0jzirfGUx93AjVBZtuaNzNUw5uUTzT7ZgWsn5etFkybhBnxL3wHxl2pA5gBpj
         xythucqhrSXItir9pLBzIQ2Yfx99NQ3uOc7jjVqG7tqoe2MFrStmokxE8D9Q8wiEexid
         XgQBtlq/T67DPxJJ2rq0yeTXVx7hELjGapfcYMaXNlgGG4VEPuHrAd+SSXtXXGA7/X7s
         RE/+ptRBZe0AVVLt9cBAyTntE1bZ2EfHjQmvzl3xgrV1jznuB2T+BGgNc5F7b2YqYQjz
         XKDA8toU3z67J1jIsG0kqHYHwGHAl/XVmeP/E+tqSQhqta8WOpLzqdGCoJgyUfOxu2/g
         +BUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755527811; x=1756132611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UQbiLTQGi4sOYDMKTFgGpWiNF5qAYuHZ+4Lz0Qn0zrE=;
        b=n3qJT+43MfjkzWbthV9e+oHmduPq/JD7mmE20U96cTCN46RArmJNWwfxC8zRqGJ/hG
         z3C6gCli+bDPxb1qUM7AigXBRXLfNNbX1aPJ6EQsJxTT3/34LTGeLGtl25KeBzeOuZSL
         lPJxI8FTBgg4vQGZ+QYkSIWsVl3PikRmCGsBH8X8BvvPMlPYTHo87+ZcuXi4vEIS2ZfU
         3hhGbpppfuwW4SHXz6als5rwD3WX9ePWNwN7o/g2DCyrHJw/lvi6IWBFvzeok/D/yB9U
         KQCkqE2agVm44i6B14/XyBFF12ofoBzj29yecA7KKOw8s8sFY8rP1a8ctxazUuOXX5af
         EqdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGjjoNjpXopFWy908eUKna1w/C4o6Q7rrF5C9Evw3YuWXeMih72zKz+WyUR96APq/HPeq6qwjUSxBv@vger.kernel.org
X-Gm-Message-State: AOJu0YxcgZS96fIA9Hpcy2/nc310mM3Vqx9FBcoP+TiY7QXjpXNzdpAM
	jynCu97Eh/PsjMlrwE8P2cZTcMYAvN7ApVPs+wARAl+M5D/ex7AgWVj6HeUzWGnosEE=
X-Gm-Gg: ASbGncuwwPwnmSCfuygJRceL+a6BtLSQIUV3ByXQ+sA14aoxC/Kx+a4DVlBOcNLbACW
	YL5/u+oJ+WDNTlVkllHYSOoOCfZUEp8YVUmMBPoYxfEnu79LkPMWFN2IUDkXhTpTz2QYSxW1NkN
	s4Yi+o/zxMC/9aGAJdLh/oFfX7///HzRPqfDAuY09XndnMHurUO/euPCPuDgREg19LDFWz14wr4
	Pcfj/tfHr2zKxS0D2KJ8/+HczexX8g40uaDP/rw8B1/cY0Ox0dpaboh0QueoUWoNeb5tuY5Kb5e
	grcXfIDW2CdpD5Qc9lVFv2N5mVlBnE3kUiEzRBTC+MLm4nsF10gagGHubLCyo93+1j98DZ/MZBl
	pGxMBkn7S6PBbmqqKhmJRHVAQwuFyaRbjoCpPndSXS5bZBj8m3xbeSc0=
X-Google-Smtp-Source: AGHT+IFPjTGWX0YkyeszTwSPraUCxDH1MMY6bmni9f8pZnvxHNb7k5FK6QV/gsCMcRTABLOy2Tdaqg==
X-Received: by 2002:a17:903:b07:b0:234:8a4a:ad89 with SMTP id d9443c01a7336-2446bce41cbmr181639185ad.1.1755527810969;
        Mon, 18 Aug 2025 07:36:50 -0700 (PDT)
Received: from localhost.localdomain ([122.171.22.169])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d50f664sm81704945ad.75.2025.08.18.07.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 07:36:50 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Sunil V L <sunilvl@ventanamicro.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Len Brown <lenb@kernel.org>,
	Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-acpi@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>,
	Troy Mitchell <troy.mitchell@linux.dev>
Subject: [PATCH v2 1/2] ACPI: RISC-V: Fix FFH_CPPC_CSR error handling
Date: Mon, 18 Aug 2025 20:05:59 +0530
Message-ID: <20250818143600.894385-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818143600.894385-1-apatel@ventanamicro.com>
References: <20250818143600.894385-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cppc_ffh_csr_read() and cppc_ffh_csr_write() returns Linux error
code in "data->ret.error" so cpc_read_ffh() and cpc_write_ffh() must
not use sbi_err_map_linux_errno() for FFH_CPPC_CSR.

Fixes: 30f3ffbee86b ("ACPI: RISC-V: Add CPPC driver")
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Troy Mitchell <troy.mitchell@linux.dev>
---
 drivers/acpi/riscv/cppc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/riscv/cppc.c b/drivers/acpi/riscv/cppc.c
index 440cf9fb91aa..42c1a9052470 100644
--- a/drivers/acpi/riscv/cppc.c
+++ b/drivers/acpi/riscv/cppc.c
@@ -119,7 +119,7 @@ int cpc_read_ffh(int cpu, struct cpc_reg *reg, u64 *val)
 
 		*val = data.ret.value;
 
-		return (data.ret.error) ? sbi_err_map_linux_errno(data.ret.error) : 0;
+		return data.ret.error;
 	}
 
 	return -EINVAL;
@@ -148,7 +148,7 @@ int cpc_write_ffh(int cpu, struct cpc_reg *reg, u64 val)
 
 		smp_call_function_single(cpu, cppc_ffh_csr_write, &data, 1);
 
-		return (data.ret.error) ? sbi_err_map_linux_errno(data.ret.error) : 0;
+		return data.ret.error;
 	}
 
 	return -EINVAL;
-- 
2.43.0


