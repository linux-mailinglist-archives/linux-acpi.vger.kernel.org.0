Return-Path: <linux-acpi+bounces-19206-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D5594C802F2
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Nov 2025 12:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ACE7C344DBE
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Nov 2025 11:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0219A275861;
	Mon, 24 Nov 2025 11:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="miElZuSO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4783524501B
	for <linux-acpi@vger.kernel.org>; Mon, 24 Nov 2025 11:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763983246; cv=none; b=b2ek/w0uOZsPOX04KsmTt9khFWbPD0XwHrRTV6e9W3QaWlbbaNqdiOYw+Tw7L+5MBCXBP2NwLYR2qnLV6CD9dvK72C7OcFKZhk416GZA3Ma6qB3FjRLXHtF8U5b1MBnd0jGNGqSzzUUkfbHqkhjY1bQjm0eDm2w42hGJkFDS+yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763983246; c=relaxed/simple;
	bh=9T39oHFVYslmOezN/tg5/hXDiUXFog0BqAT4KJ57q9k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SfIeKTEMvq9o5W3XOcT2DsHpa1MzOTpLJF8M1gAfyMTr6SlMrPyAgrGFYQMAIJksBgS7ievEPoMKxAUJi3AMLDLhG4NJT7WwlYfhyS2Q6SuZOGQPWAKCWYeg7ui6s3y22aStm/fc3Qnoy4SqlxQWrglBS6zSESHPorPAy4hmep8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=miElZuSO; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-11b6bc976d6so5145693c88.0
        for <linux-acpi@vger.kernel.org>; Mon, 24 Nov 2025 03:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1763983244; x=1764588044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QoFjh8MsYFC/IcjaiafYFUcjS29Eup0Axlu8vHGDo8g=;
        b=miElZuSOkUKYmRECU+tiB787jP/xDsYNd3KYY4neGoWZ8nTjb5W/ksLaj1apAhHOpj
         iVuTmEueEHIgDFGMxBJdoxDR+qDaMX1fcYhX3N5/19WQhmOfL79n9FMGyC/zln8IHhfu
         V79nqFtpYZfGph0YdYP9LFJk5tMy1+L9vTCd/Qw0W9iFpnvVo3IX5fwsnosx8uuMMjMP
         MTLh7wOssx124LnB6lQ2MXyi7LLvyo+cd0xWbWkOJ/pVDFkJwEXBtwdjerDRaTycqLLK
         lghpC8LWI/WpD9DZ0ZJMcGutTOzcHcrKVNpS3ueu64x5tG9MWanmVn4eGgE9cKcRvHzA
         xB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763983244; x=1764588044;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QoFjh8MsYFC/IcjaiafYFUcjS29Eup0Axlu8vHGDo8g=;
        b=HZgCTSt46nLS+/EsJPuAcivvAUanvabI+XpCvNIvko7x2h84zpF+IH4ie4RHZFUmBH
         IPeDJ8CWo79w/ldux6dkzVmPhAXIyeRsiXPu0b9TPj7KLo5S6HsfQ3eVf3E9xC8VM8Hz
         6rAVCb9/vrNZAsirJ7T3R4s7pj85L015K4aZvCqXWI4ql/MUsvIiDZoFSTCFlji+vmAk
         26pk2eCIVkpYnpopvnZIkkyHYoInOaUxvfK9ECHCsAmYltNPaCguBSoBpT2BZ5nNwVzM
         Sxmn01XOYHSgSNy3Kv4TnD8eAlDd52WAWMB5fkmSVJ4KOaKJ5MwEcK2A+hHk+fOe24Wt
         9uUA==
X-Forwarded-Encrypted: i=1; AJvYcCWh6cHhMIJKjdYDHgmPwD4lM3007CD670QtrbSsmVrrJSuRKLKuMxMFMPbrvi2eeUf+OPrmhofSxAIk@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ8Bk6uA63gwfJX2ZhMPHBE+w++SZMsVsBM5oWuD7n93BY4bxr
	T98RdR3GbpCZQE84kf0XX8i6XFSsNZwBBZIRgxAXZjlPNJOagyUCGhuhIr2BkjMqNSg=
X-Gm-Gg: ASbGncvZos46+NhbGK4w6y8V3JYjbgA+S7lkRJnVB1I+YN3lMxWAFuI+w4OXRP0yxUz
	vqRT2H6L19WLO6x56VhtR9Mey0t4sGibUj8LRAPN7wG18DzOmZF+fQP/q7hI21OFMic3IHwOa0c
	GbXCAma8g3+AOFxQ6ycDtQrCQmnT6t9+0SkQPQWngBPdR0rD3LZhcp3k5o9Oa/tI5+JHwmZbOam
	I76wk22ZNlQgVolt1KmuAV5VFRrClvywREW0Zp36BIurRdNK870W5f+M0UqQmKRQK+Wbws6OK/l
	rGAkGCMnkKIS8ylkmJOdGMSLr22EB09Nz1kzYSKr+j/K1lHmK3gSLd05BVMR0s7ydwX0T29U1Af
	1glHSijJVl3cMcI3z1HrJtuD5yhcRH3XlmIEvwxbatOlpAyGSt8E6+Zb8nuZ1u7wARrxGRgq6pz
	6NEbQROyb4HLH+x2Etl0uprWEGSE+L1sNfyRX9JI4VDjO2ZnjB5g==
X-Google-Smtp-Source: AGHT+IFRe5OFRcOIRvFt0difRXHFsxQbs1YTDnqVqZ5YmfXA4RNED/Ts3TyJDZwvJQ+Jv8lGcxehkg==
X-Received: by 2002:a05:7022:fb0b:b0:119:e569:f85d with SMTP id a92af1059eb24-11c94b90cb3mr7567332c88.20.1763983244166;
        Mon, 24 Nov 2025 03:20:44 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.166.196])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e5674csm68207847c88.8.2025.11.24.03.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 03:20:43 -0800 (PST)
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
Subject: [PATCH v4 0/1] Common csr_read_num() and csr_write_num() for RISC-V
Date: Mon, 24 Nov 2025 16:50:30 +0530
Message-ID: <20251124112031.170350-1-apatel@ventanamicro.com>
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

These patches can be found in the riscv_csr_read_num_v4 branch at:
https://github.com/avpatel/linux.git

Changes since v3:
 - Rebased on Linux-6.18-rc7
 - Updated commit decription of PATCH1 to reflect the fact that
   we are removing sanity checks on CSR number which are already
   taken care by csr_read_num() and csr_write_num().

Changes since v2:
 - Rebased on Linux-6.18-rc1
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


