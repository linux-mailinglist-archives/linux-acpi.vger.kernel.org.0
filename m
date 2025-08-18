Return-Path: <linux-acpi+bounces-15799-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D880B2ABCF
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 16:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C85262777D
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 14:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1C231B11A;
	Mon, 18 Aug 2025 14:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="TRCG13yf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E8B225390
	for <linux-acpi@vger.kernel.org>; Mon, 18 Aug 2025 14:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755527808; cv=none; b=mL7W4VzuTDXuRYFN4/7f+nPhYe+WNhgdogmmFcFjh98a3ktYqsIGzLerutos+uKtsMrrkVx4Xsf/CoGUZPNkidZBzEOqSpYqiPMam6R2tX/ro1AqSlMeqQ9P3QNwD5CK0aOb5fUmapZslHSZcPB0YTL3Y48p6Zfmw/HyHLD0RMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755527808; c=relaxed/simple;
	bh=Mi7v/5SFKn7WwGpts4xb8BlAippn6V6B+njRlwy9Ex8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JLriq5VEBEs+Z3fuD1x1sbfgEfnq73CFmrqWMcGAweRokyjmnAt7dlvoZRgZSSYq0oXauVv+dF7hvZImJ3sutBjvE2YQiXyZbquuNSCKXWAlTqeo520l0IIMo3nMyPvHdLvDchNjmqzaHZSjo8pYxNUIzF5WpX1YmLmxMVhb1GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=TRCG13yf; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b474a38b25cso702436a12.0
        for <linux-acpi@vger.kernel.org>; Mon, 18 Aug 2025 07:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755527806; x=1756132606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GPRfWRSPn2MXzdkFqXMoQyh3+o3vsKMsh/EYBelfV4w=;
        b=TRCG13yfcxRWuKagNJbN9swhxqua70XJ2WSWKcHzN78W0hDpsll6lZWx0Jwm9TTgsN
         AdEbkoDUORKsVEyDf95eVBxikFJ6bjUDjZDvfnUUukCeZv22+8bBGVkBdNuYIx3d7y/E
         DnDTCXjUPG+1sVJ155zELucUxDaFWN/Kz/N02n7jl8hI4WLjgfhMgs3816qeXoYLo6ii
         mWcRg5Q4hBo9SzIipKvVwnKdCi5mbHfhU4giXgV6bc+7olKYiLgSL4m+4Ael7PZ+NK0X
         OdwNmX5dGmG6Ahm6IXN349GlwnDi3te/4b8pqijh7hWwfZ8QjkzTuyohMS8q21FE92ue
         HJcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755527806; x=1756132606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GPRfWRSPn2MXzdkFqXMoQyh3+o3vsKMsh/EYBelfV4w=;
        b=Fc2lX+04erYNd7mIzUQNSb3xVzkx+e3dIXkldRMO2XN8Ulm4zQytdyXKlpgFmcNYwV
         R3jwVGEcixxWfTwxxzwqdNS0zkf/pjtVKK4PZmCVZ14D1McfCT5YNE1oI7f750fiV9sk
         FUsbwOHt3lC0IVRmTXYEWIIbqA9EtBX91vylY9DDmAp70j2TfBJJesdMq+IfZKlSJJOH
         WhuqilBggRoXXRqecddTD9BobPNa/ekj/sW2E+k1qTMm9jAyUHtLaWcHm7YbDTuL4PKD
         FE1IUg9QpINIL0pg7u+eGCWZiyzRr2GaOUmPyjrk0Ws26kq0UTFI9NwqbTUJhmYTluDu
         z7Rw==
X-Forwarded-Encrypted: i=1; AJvYcCXo3poYjbfU5ohkYHqCjW/GTYAVJ0WVJR4eMwcYlUsHocnE+Fimkuy+6s53bfk5WJjzhTVsMIEJwBT/@vger.kernel.org
X-Gm-Message-State: AOJu0YxAE/zLIj2KA9mDcX9k3uJuvUOyZ4iZba7tFZOgts/TV8kgBlBm
	cARlkcNj+PjFs7APeAplx13rBwp9ldrOwB2oZP6DAuy4vDsDICSZ0tfxe/j5QgJ0yf0=
X-Gm-Gg: ASbGncvjxc6g5vfe5oGzYPovQy9BCvCeFg3dcbPuM0GNySEqpqhF4W9KaXN8i394VFV
	vkg2uWBwnSXDJ2Mz6aaq/GXJq8EF0ka30WJlAohsUUhY/W7+i4EpnCkWgw525pbzx4h6c5riUWF
	YSKaF5Wbr/kJQdsIm6t9nY/AgkqXW05raKaWSGdtcKaXoNEycswHtBGsM/GSLqKWeMUn1rZ6AWn
	F/afXhY06+nFcLRN3w4ofT3YetWGOsnlmIkshRLvxd3Lm3QIyeOEuCECafYSwp37UcuaqqdUHY9
	sfW9oAumYkrqFTiop4Y8VJiooK3jeZ+9TIHOmFDVcDco4JnFulqlTRaWaIc0EtPF0e2XOnY3CIi
	1O5sO/6NLGbZHREfMCJRjO8qX0MSVQWVFHY/6VXcVlWKFaQSlHEhnCtE=
X-Google-Smtp-Source: AGHT+IFhQIGFe+ChK7vTdpEKuwo8wR5gEcJq/HqOaD2XkCBquPT7zD28uoL27+VgjZiGEpkXOMVA2A==
X-Received: by 2002:a17:903:186:b0:240:3ed3:13e7 with SMTP id d9443c01a7336-2446d9699aamr152591495ad.42.1755527806186;
        Mon, 18 Aug 2025 07:36:46 -0700 (PDT)
Received: from localhost.localdomain ([122.171.22.169])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d50f664sm81704945ad.75.2025.08.18.07.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 07:36:45 -0700 (PDT)
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
Subject: [PATCH v2 0/2] Common csr_read_num() and csr_write_num() for RISC-V
Date: Mon, 18 Aug 2025 20:05:58 +0530
Message-ID: <20250818143600.894385-1-apatel@ventanamicro.com>
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

These patches can be found in the riscv_csr_read_num_v2 branch at:
https://github.com/avpatel/linux.git

Changes since v1:
 - Make "out_err" mandatory for csr_read_num() and csr_write_num()
   in PATCH2 as suggested by Sunil and Drew. This also helps further
   simplify csr_read_num() and csr_write_num().

Anup Patel (2):
  ACPI: RISC-V: Fix FFH_CPPC_CSR error handling
  RISC-V: Add common csr_read_num() and csr_write_num() functions

 arch/riscv/include/asm/csr.h |   3 +
 arch/riscv/kernel/Makefile   |   1 +
 arch/riscv/kernel/csr.c      | 165 +++++++++++++++++++++++++++++++++++
 drivers/acpi/riscv/cppc.c    |  21 ++---
 drivers/perf/riscv_pmu.c     |  54 ++----------
 5 files changed, 186 insertions(+), 58 deletions(-)
 create mode 100644 arch/riscv/kernel/csr.c

-- 
2.43.0


