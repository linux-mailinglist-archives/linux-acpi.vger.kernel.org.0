Return-Path: <linux-acpi+bounces-17745-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD5ABD9AF1
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Oct 2025 15:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 57F1B351D01
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Oct 2025 13:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9E02FC881;
	Tue, 14 Oct 2025 13:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="jD0Gd3ds"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9375D1DDA09
	for <linux-acpi@vger.kernel.org>; Tue, 14 Oct 2025 13:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760448083; cv=none; b=tYoAC97v8Aao5OdcpT5cUos88RUAmY8N1zW6PLyrVP6gxL3awrrjzReObmgKCL4CMpBGxCcYDxzaf/PzmGa2bH/eaJ9tKgsihRMTZm5Ydc8YFAhT/KyMD1S8ofBYuVXMo++DBfrE2mzL0EABjntRn89UJe170SYMFX1PjAYaM00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760448083; c=relaxed/simple;
	bh=My5HomZWKvxduE6n3PHRd+8RyM8EUC+3BbmfbP/nP40=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QkNCbCQ6zrUAR6XdHzybVeBd7qVCSaT9CEFKtdIn9F2K7zV4egXKH/L5QThS1ywN8jFFXwyyuWM956372NNRTI5DNVfVJ+x9stuBm1LiK1eQHfcy+oDZTccGbqYOCMOwI0DzbvNq/fR8l2zfxF95YuP+KPerZMaGmBoYcPqqB70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=jD0Gd3ds; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-279e2554b6fso39451615ad.2
        for <linux-acpi@vger.kernel.org>; Tue, 14 Oct 2025 06:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1760448080; x=1761052880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w63d3iN1NxniFWTpRTs5PQTHc3ix0F8ilLg1M56GOwQ=;
        b=jD0Gd3dsc8w3uPt8t0lIGuNFgl/AryVN33W3XgGiYm9gQbueBHMqueMrd42Hq7IqNS
         Sqc+HMpwQcvwITDubW3Q6Gv5/31vEYid1soSSJfYAjLo9rS4ouyAtwp6UivPakXCeybQ
         oEssZhbfgYJEHulYeuMb3pMehXbPDC4vglbzH85e9AOZ3el9y4m3fIWYwlf+Bs1dXuZ1
         B2mtu8tdIkLLHiKlDIqyAEHfM272FO0FmUHLxK5NR36sdw85+D4a3sIDBmn+f7pHRyF/
         RLqGIfUbp/5kWBlOUSps/3hl6FbK4huK/0kyjJqdm5lZdD+nC54xAswiN2O3aXw4ZLQl
         IqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760448080; x=1761052880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w63d3iN1NxniFWTpRTs5PQTHc3ix0F8ilLg1M56GOwQ=;
        b=A8mx9LxKkGFOf1ch8Wg8iKLQIxmRN+8xRZQAcE15ah/RliMoKtAYgr+L1NcWNHR7aW
         NlhtIT1VzIrM8/hw7ec3glLsmu9Rf2rrJFZEag3H1dRnzxK+/JHRuMLJBKRM3v6V3PjZ
         rlwhKUJgVLYRO27f2oFMjk8YWhRwI1dw//6Tz/HgattHt+83x47ZHtv0JpEojaFYpBx6
         fFxXjK6raev2+d5sAP0KeHJ0GuvU+pezjX9WqHeTdDYmSLwIKubWRv1yHvsFAMaqUVKN
         lhlJY2gh54zlnVtJF35UumdOmweIScqgE2FYjd6G4G4AtatYJ/5HOX7L3tpAUV/qI8A1
         fp2g==
X-Forwarded-Encrypted: i=1; AJvYcCUhu1ySfl25lqncURfYbOSGlEwXpa3a+gQ375mrynt7KoGrP/i4u7Z+n1N9dxlfx7lD3y2a/dxCO2Xy@vger.kernel.org
X-Gm-Message-State: AOJu0YwCdenXtJgiIzWjl3apE3+DKzprq0K+mluxMl82HWznEX+GmzmW
	Pn3GPXEGMgnXFvfVXKqc0fmvxeDNeWHLbFTHnv/ZiRmj33aJHWOC0MTdy0kdgtxI/7I=
X-Gm-Gg: ASbGncusDQWkEIvLkxDitCcol7BFVIDJX3AnYIYvnzahpwWmASydQ9q382lyRbo4t4b
	nF0VNxFCl+RJK/l35fY5wx3Nb12LOZEIvrehrLtIMy4FFfFUA/qtU2rGvqVANLngjkIUAqo/ohZ
	uDuSaHXbRcdE77eEIxdh5/VWE0Z6pkYTVOxuKxI1VFriKQQ6/vy8jvsKIwgBEtFXv4oK1gJ3AvD
	/3cXsTrerEWSnYBS0IBVpHm6jXnd2j5ii8s8Pd/lvMgG8xluoI0doAZaj1AAbJVql14fsp6FUGo
	AiSESFvY96g2BlLMeDkKqKHVKz+yvRS/BxjeKrjbupZir8IAcc0bvz4foj2b7wjqsGLPtzZwwAp
	faYztCKXRC0jL/haUxPx2iIRGOu+e/Cjs2zsECln6Ek0cdNJ4V8+0SlD2rrdxt53jd4LWKP+W
X-Google-Smtp-Source: AGHT+IF7s3fLFOl9rdJb0wt/YGaCzHyGdkNVTxLw2zcP1cyGfw127m9LZ83PtoZ1nbrWcMLKHR37aA==
X-Received: by 2002:a17:902:f64d:b0:26c:e270:6dad with SMTP id d9443c01a7336-2902741e4a0mr268523345ad.60.1760448079692;
        Tue, 14 Oct 2025 06:21:19 -0700 (PDT)
Received: from localhost.localdomain ([122.171.20.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de6f08sm164387635ad.26.2025.10.14.06.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 06:21:19 -0700 (PDT)
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
Subject: [PATCH v3 0/1] Common csr_read_num() and csr_write_num() for RISC-V
Date: Tue, 14 Oct 2025 18:51:05 +0530
Message-ID: <20251014132106.181155-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some of the RISC-V drivers (such as RISC-V PMU and ACPI CPPC) need to
access CSR based on CSR number discovered from somewhere. Add common
RISC-V csr_read_num() and csr_write_num() functions under arch/riscv
for such drivers.

These patches can be found in the riscv_csr_read_num_v3 branch at:
https://github.com/avpatel/linux.git

Changes since v2:
 - Rebase on Linux-6.18-rc1
 - Added reviewed-by tags

Changes since v1:
 - Make "out_err" mandatory for csr_read_num() and csr_write_num()
   in PATCH2 as suggested by Sunil and Drew. This also helps further
   simplify csr_read_num() and csr_write_num().

Anup Patel (1):
  RISC-V: Add common csr_read_num() and csr_write_num() functions

 arch/riscv/include/asm/csr.h |   3 +
 arch/riscv/kernel/Makefile   |   1 +
 arch/riscv/kernel/csr.c      | 165 +++++++++++++++++++++++++++++++++++
 drivers/acpi/riscv/cppc.c    |  17 ++--
 drivers/perf/riscv_pmu.c     |  54 ++----------
 5 files changed, 184 insertions(+), 56 deletions(-)
 create mode 100644 arch/riscv/kernel/csr.c

-- 
2.43.0


