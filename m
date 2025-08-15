Return-Path: <linux-acpi+bounces-15739-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09877B283A7
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Aug 2025 18:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C99A2188F1DE
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Aug 2025 16:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AC03093D9;
	Fri, 15 Aug 2025 16:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="YauduTjs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BDD3090CB
	for <linux-acpi@vger.kernel.org>; Fri, 15 Aug 2025 16:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755274464; cv=none; b=MlG9RKk4ZPwsoq66bj9tfvrhqNSnwUEmUWD4Xt5wY2wQnTuvPAFXCMxbWMyDkfqADW/ZqoI3Ue2I+1mGDD9Lfc/YTmHDLAuTsY8MVgyyydD4AOoBp4i6WJiB/iuklyb/B5v7WhHFUOsNuwcPYhHTbSSPFe5ISsNYKcbUUwvVOWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755274464; c=relaxed/simple;
	bh=fmplqdUGwRhCU6HwPvTap8Scho2rClFy/lrVQmWUIAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KQOAzomFE3QXOHjNa70ecEhiAMDXgq7N1GSvuJL97MI+J0ORMiTX8T5GQ4GMSe2kTGksl8Is3n4BwBT+OsvwjFDE1pZ0l/fJFysVsYYshH7Eyc+zjDSaAgu58Y4u1NzIQ+zL7LZou7YoSO8LPR9QkeNSf6qLUxvQ9g0XThl6twI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=YauduTjs; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-323267bc2eeso1641746a91.1
        for <linux-acpi@vger.kernel.org>; Fri, 15 Aug 2025 09:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755274462; x=1755879262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOTbtPDm0qsjMzwi16WVYcaH7+7/qMVJUy8rQwaf7Ps=;
        b=YauduTjsb5rQ9ZqQ+g8kVQAHIpNNR+Q1io4qEGxQaKFVXDJxlCfaVRER3uNDwKMWnp
         xK8Xlr4y73MCcz0Xuz6mUQ1ixrzAuuajOrnnwWP9x3wKb6KcApPc7lvB17sWfQmBPycQ
         C3QmDl1gly72PYb38PbkyPjEfTtAgwEk2arm1FMVKIphRsU52evSUHioCjM3ujdKz26L
         A+dz9ijEW3oiV1Xnb8c5+aR8IXndLdF3Z5CPeOOYeGD1PXWcsklDXA7JatlSu7Wl0rl8
         7pUTFTcXzyEdqT3rkNbQKYx/Hs/SXySk3rX8oI3UDG/L46R6/Yg6gsKO124oi4vcczSb
         CcFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755274462; x=1755879262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DOTbtPDm0qsjMzwi16WVYcaH7+7/qMVJUy8rQwaf7Ps=;
        b=TuDXKoPT0kUF7R8ifnQyMvYqGVpQ1Lgbri4XzchbwR4BwidmlS98b5yG2pNBVHKSuz
         9M1OK17HziB7BkIffC1CYQCVamh/fBR383q27ijYKUby91hXeWV6ExYMrODuueYiWEv3
         maxUwM6xekOz8sg/GbRrRFxKUXfCYwa8C49Ig3U/mRYlbCPJBb9C4O1HpvlFAE8khjmu
         LpX7t9il6rLmQ8/VzI3v+T5c0857PZnnA+nzuKH6fKKSxWOzISw/Qd9z1d8k5SX7DcWb
         r6XzgZsIhillMduFCHnqL7vVkLL12OtdizQ5jh3ym15kE8Oj+VJijmPAbyA7eOF7I1nK
         TmuA==
X-Forwarded-Encrypted: i=1; AJvYcCVII+7yoevBPTIfqKEBTQT9Vv1BtISyqJ2HXNjkNy2wBxVtTp+Fdfkv3OPwHvTK9hK8V7fkd8NsbPX4@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+hfuGlQ6kiPQbgG42+w8HmHUNzqTgC6B+XGcSVPra+RaVsYyV
	ggQS3dqa26FI9ckDYpx+u7VxxLhAfRz/4e9KJBMoSUwym1jXdDGWqhfBdrzw6+U5Mno=
X-Gm-Gg: ASbGncsk9q5JjAUlGHHAy3tk+WFgyAMRVhSaLlTu0omsHe1f9N7D43/n1x2zGzp+CM1
	97rshpDCScFXcfWQDMupjPMhUBxBUUg5rbIzZGIhtX7RHBY/h0SHQjaRI2dhkkmxubY3T50/iis
	oy8C4zXw950Ru+OOdKspoVnWCFwB9U/+Qql4ziJJJrYkxEa6lRSG80gY5kK9alj921eqcbKVO7I
	i4Igo0NEpmy4lCbXqH0odHUbuE4p1GFv9qEFbokS5XJ0IhhxXJcRVxKCN585XzkVAtKICLTsEc2
	aCuWBO9At/TQY7V+wmls+59wuEb2IAWmkG8gwzjZEPP7W3ljEOq28yICimNA4l0Y2nevfROie6I
	AKwGV8SPNg41Tn9qLZKICprVBz+7un8CcLOx4A9BHqsVO6TGE6ySMG3M=
X-Google-Smtp-Source: AGHT+IHFvFTmbcxXmRN3DXHTp35ctiVVaiF6Z8YM+uVIV53DcXSsUv4K9ZPJVyFNnw7pfMwftn7IEw==
X-Received: by 2002:a17:90b:3f08:b0:31f:22f:a23e with SMTP id 98e67ed59e1d1-32342161425mr4018316a91.27.1755274461963;
        Fri, 15 Aug 2025 09:14:21 -0700 (PDT)
Received: from localhost.localdomain ([122.171.17.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32331123409sm4645605a91.20.2025.08.15.09.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 09:14:21 -0700 (PDT)
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
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 1/2] ACPI: RISC-V: Fix FFH_CPPC_CSR error handling
Date: Fri, 15 Aug 2025 21:44:05 +0530
Message-ID: <20250815161406.76370-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250815161406.76370-1-apatel@ventanamicro.com>
References: <20250815161406.76370-1-apatel@ventanamicro.com>
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


