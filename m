Return-Path: <linux-acpi+bounces-15738-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35498B283A6
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Aug 2025 18:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21227AE497F
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Aug 2025 16:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C983093AF;
	Fri, 15 Aug 2025 16:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="It1UEdng"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0408D3090C9
	for <linux-acpi@vger.kernel.org>; Fri, 15 Aug 2025 16:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755274460; cv=none; b=WjjhijLEjbtd01yKTKAPj1WKmJ5r+xcNbjZ/P0qiiPrex9q6IVFmBHx63s41J57gM++VZ0dSQOfVWs2H16A6Yf+42Hj8djvVJOVPEGGMITyBHrVHtzjDnJl9CIhJIvPnDoxGTq4t60SrxfBT+cZz8phrPjshf67RywRNR+U/m/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755274460; c=relaxed/simple;
	bh=Kf2iBK1D431xQGY0jRZ1wlkj6AG2/CAeQT2ykycOP6A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uj9bITcRNKd6+Fp/sWa3uwfgj8hRj8CATVne5X4WP9yHl7G5d+8lntSIikx/amHnc5T3nsJGfkW1QENdY2b324GPC9dYH9eY8PTSAFrZO/RK/ZDptkpaEQZgWoS6dv5FdmwsJ9oGfdJiuFGCxjKb7wJ3QCd1PvlI72lnRmiNOWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=It1UEdng; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b472fd93be3so364627a12.0
        for <linux-acpi@vger.kernel.org>; Fri, 15 Aug 2025 09:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755274457; x=1755879257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vcATQ/iyLXq2WCAG+QWp7/wBNzzyT/wwSXwFvJK/wvw=;
        b=It1UEdngIm6CZdD4F/XCtQiyb+fJlwVULGLVdc84XD9s51SBS+9UQ7a0UKXLXOaX68
         y/MgiJH4OMO1x2/XFiC/M4wb6ccwWzlpPCjnFhWkTiGDcstDrBXiRLPvkzuLFVW83htQ
         fm7AbnJcyTskSrIWbFNvLl45Mx8cIIOywo3NHjSVvTDoiyhfRKVxV2QRXqQa5drH0yiI
         uqWKn6t9YZv80osm+EFA9fi2prQuRrqD67QKZ3ARsICkRSiec6egmkDzWHnlz+qiPkr1
         ZLSSRBpU7ftj5E3eTDbPmNcpv7NejH3ksxhrkuk69XYX7vqtTPgOEIx0V8af5j3ci4jN
         Ub8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755274457; x=1755879257;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vcATQ/iyLXq2WCAG+QWp7/wBNzzyT/wwSXwFvJK/wvw=;
        b=YH42AboVUAViZMH6d5/qswWXPLizR1JyYFrdDzeBr2h8tVse5DxTBxKjyYZCHeS8la
         4Jqo/YplaoeblubWlBt4z0kPbjrQiLoL1cbcethBaNSYiEdBwVMCDYO7obgFYvEzfY10
         rsomKw8/tLbaq0yBqVXCtET3nGo+WW/SR05VZvZX3jZSamwwc7arVn6qCvYT7jaz0h79
         KJl85pApk2Hzr2Sm6HxITyD0t+TsrBDMZxFsGL6O85asiYgaYXhVq5TKbNnCRmMzUsbn
         6SzWYclyj1hVst/fuuMOIBMlF6FEsp5ixVpSuyo8wozzTvzL2NI570w0Gya0ttGxCAJA
         Ihdg==
X-Forwarded-Encrypted: i=1; AJvYcCXrXLDq+ArPYLyCBFzBPur7a3iAIubInM8HYhF+AouBVCY9rsImILmiczTfa7JXnh2wTD8w6C8jaEhy@vger.kernel.org
X-Gm-Message-State: AOJu0YytmUopG9+gxB1yNqAM+gfkAH2bYQO6pYwFcp8aK1nS2QqS0eHP
	wUQ7QBtHEfH5a1FxArAh/Om4b0z9vKPyXIEF4HZcnyzTrLApFmGO3iiwFWXuDlRsvEg=
X-Gm-Gg: ASbGncs0W79Fuv1lhRJL2UQdD1c/q5kk8VafqAJjmdwZMyVkawMR15Zb8cVMAEVYQZ7
	lzAb3s6DLnxpfT+ZqxxjQhKhRDRZgqPLd4p+JfbRFNovQEGZM2MoFeFFQt6rEp2PDV1p5TvhRa6
	FpUoAENS91LNQ8WC8Cz2xWwkSoYesiwc/jQutrZxgoBFS2VOtLV2wtIggBhQ3LLtctoW3qRWhTO
	sX4SMZvM7tswJOC0z45nqRpYtGtVAcETvfkEh8eFqhdACZdyatrPgoWtTAyekCLk/2typxI9Zy9
	Ta012XR4UK8fpvdjkssZrMQ1oAwddMAVRCzk0NOlbO6dmAMJN7EhJBs0Mruahrz8l6nZian3lfi
	EjOhCVUVCChFg9DiiaoWBAvcyK3BSDqWv4cC1UI+yCafISJ/CnOnEuXg=
X-Google-Smtp-Source: AGHT+IHperFQi/7YSivsAfePkj2it+rOxXUM7GZDi3LaWPilgY2XPCaqL9OvKCM03IrF3xh8S5y5iw==
X-Received: by 2002:a17:90b:2d4e:b0:31e:d9f0:9b92 with SMTP id 98e67ed59e1d1-32341ec09f9mr4429507a91.14.1755274457311;
        Fri, 15 Aug 2025 09:14:17 -0700 (PDT)
Received: from localhost.localdomain ([122.171.17.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32331123409sm4645605a91.20.2025.08.15.09.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 09:14:16 -0700 (PDT)
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
Subject: [PATCH 0/2] Common csr_read_num() and csr_write_num() for RISC-V
Date: Fri, 15 Aug 2025 21:44:04 +0530
Message-ID: <20250815161406.76370-1-apatel@ventanamicro.com>
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

These patches can be found in the riscv_csr_read_num_v1 branch at:
https://github.com/avpatel/linux.git

Anup Patel (2):
  ACPI: RISC-V: Fix FFH_CPPC_CSR error handling
  RISC-V: Add common csr_read_num() and csr_write_num() functions

 arch/riscv/include/asm/csr.h |   3 +
 arch/riscv/kernel/Makefile   |   1 +
 arch/riscv/kernel/csr.c      | 177 +++++++++++++++++++++++++++++++++++
 drivers/acpi/riscv/cppc.c    |  21 ++---
 drivers/perf/riscv_pmu.c     |  43 +--------
 5 files changed, 191 insertions(+), 54 deletions(-)
 create mode 100644 arch/riscv/kernel/csr.c

-- 
2.43.0


