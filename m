Return-Path: <linux-acpi+bounces-665-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 218797CB2A6
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Oct 2023 20:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBA3C280F75
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Oct 2023 18:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B86630D0B
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Oct 2023 18:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Sm8py3Yd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67018286AF
	for <linux-acpi@vger.kernel.org>; Mon, 16 Oct 2023 16:50:10 +0000 (UTC)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9648235E0
	for <linux-acpi@vger.kernel.org>; Mon, 16 Oct 2023 09:50:07 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-581bca3ebb0so433587eaf.0
        for <linux-acpi@vger.kernel.org>; Mon, 16 Oct 2023 09:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1697475007; x=1698079807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nj4mUrtXg+jVZ5VMP/KIsH/QVzXK0fH/Er20bgBIeBo=;
        b=Sm8py3YdeZ4DE4sj4eXMg12/Bm7rzDdAxPAMfc9m+6yP6sqVgpg8MtsUpe4ysMye88
         aL/nZeV9gqmgPCLOsqXjNfeOCLWTx7+CP0A9rwre84WA6jHMEnp9qmRmVig3cwvZyhM5
         13p0DvHtW7kyYOQDOazeoj2TntccFw49PqdfrqFZIR9MxrBX+2MMyE9atajNGgevh5o5
         6XYmIRBUfSMOt5PMFmkiSD/YSuMnxciBzxCywxkmlxbWEySguYffQUQIS1YSvFaYWvKz
         u2eYMEpYWfIbwfXD87546Z3js8M+kwEGi2Diu+5VWYvis0MiBPzvzdhChO7JJDTWjoRq
         bRRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697475007; x=1698079807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nj4mUrtXg+jVZ5VMP/KIsH/QVzXK0fH/Er20bgBIeBo=;
        b=XzviKVAy1TngX3bIsxGozEWQVxbk7pqVeiIiuom8W8f7iTfl7QjwTi+E3O18l/h0cq
         T7yE1GxeiczlBQXS8rzV4DLcQ1h719T9EHj/nzdjVqbKh3+UuXoOBY3DwZLxv2ju/gRI
         F/bLEjlEZDi6ZuEWHi92rDpjRKqzEwWugaS0N6POq2rNyZrNrTWEnmZTpDO0r8wYCrd9
         Sj4M+RNI5Cu1t0ZedPU5MgBf32s5gMv+KMFMhUYEGVPfOuMPMmoaObgnfyoZKY2oqO4/
         oLLOOWd8A8mlLrAGmvitq4NdGo2aUk/M4KApZOgBLK0lafuqjKVQ39uUxTbC/hD1vecm
         GZ3Q==
X-Gm-Message-State: AOJu0YyHbufYSiLKNeZUuRea6kNAfxSazRAquhb4DWFaKNPGaFj3c3dt
	QAonnU3UfEHTdfQ/ZHHo8XgiZA==
X-Google-Smtp-Source: AGHT+IG3jzS3nNrWFmdHjDweEuDLpJu81THeMvF++Va26eiZyY17KHQ5m+DK9WYdaSyS0jW1tMZGag==
X-Received: by 2002:a05:6358:9691:b0:164:8742:525 with SMTP id o17-20020a056358969100b0016487420525mr33127726rwa.17.1697475006528;
        Mon, 16 Oct 2023 09:50:06 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id t21-20020a056a0021d500b006b1e8f17b85sm111252pfj.201.2023.10.16.09.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 09:50:05 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v3 -next 0/3] RISC-V: ACPI improvements
Date: Mon, 16 Oct 2023 22:19:55 +0530
Message-Id: <20231016164958.1191529-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series is a set of patches which were originally part of RFC v1 series
[1] to add ACPI support in RISC-V interrupt controllers. Since these
patches are independent of the interrupt controllers, creating this new
series which helps to merge instead of waiting for big series.

This set of patches primarily adds support below ECR [2] which is approved
by the ASWG and adds below features.

- Get CBO block sizes from RHCT on ACPI based systems.

Additionally, the series contains a patch to improve acpi_os_ioremap().

[1] - https://lore.kernel.org/lkml/20230803175202.3173957-1-sunilvl@ventanamicro.com/
[2] - https://drive.google.com/file/d/1sKbOa8m1UZw1JkquZYe3F1zQBN1xXsaf/view?usp=sharing

Changes since v2:
	1) Modified acpi_get_cbo_block_size() not to take cpu parameter
	   but follow same pattern as DT (Feedback from Samuel and Drew)
	2) Dropped timer patch from the series since it is already
	   applied.
	3) Selected ARCH_KEEP_MEMBLOCK only if ACPI (Feedback from
	   Alex).
	4) Added RB tags received so far except RHCT patch which has
	   changed quite significantly from previous version.

Changes since RFC v1:
	1) Separated the patches from interrupt controller support series.
	2) Addressed feedback from Andy and Drew.
	3) Rebased to Palmer's for-next tree.
	4) Added RB tags received on RFC v1.


Sunil V L (3):
  RISC-V: ACPI: Enhance acpi_os_ioremap with MMIO remapping
  RISC-V: ACPI: RHCT: Add function to get CBO block sizes
  RISC-V: cacheflush: Initialize CBO variables on ACPI systems

 arch/riscv/Kconfig            |  1 +
 arch/riscv/include/asm/acpi.h |  6 +++
 arch/riscv/kernel/acpi.c      | 87 +++++++++++++++++++++++++++++++-
 arch/riscv/mm/cacheflush.c    | 25 +++++++---
 drivers/acpi/riscv/rhct.c     | 93 +++++++++++++++++++++++++++++++++++
 5 files changed, 204 insertions(+), 8 deletions(-)

-- 
2.39.2


