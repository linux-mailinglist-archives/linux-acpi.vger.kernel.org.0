Return-Path: <linux-acpi+bounces-237-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D58347B0C02
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 20:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 8216228128E
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 18:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AB31A58C
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 18:33:09 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CA747357
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 17:00:27 +0000 (UTC)
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5F5EB
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 10:00:25 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-7a52a27fe03so4819470241.0
        for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 10:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695834023; x=1696438823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lR0BPLKkgj2fJ5IyWi7flO/+WIQlLqax41QD5MIUKy0=;
        b=iih6pNLIRQUZMRqe3zrtvGPXNMlkAk7Rc6fRsmfK0AhRT5gg3kJcnaIx2g1Gvtw/+f
         0xG6mfTE+OhsDeHBFgXdEGijpgIei4p6gT11ktSATIElzKS0RdAv+QPMPv8XzspXkhn/
         pQoaVmrQtWZ11WRZvnNL8ZfxIQGRSZehYIkuh4CV6hjnIqPBFKdoncbzK4NvP3LZXZG6
         3vWasTAoj0c2oEh0DBXsJRKrJu0YKH0r1lkvCDtrFufuZ02Bz4V5AeVbJY9vHeOe52e8
         M0zD3cAOVVBIndccPmlbT3KLCGHR01ehPGj2HkYLUDh+YJPLoHh/H4MP6nhtwO+uYzV6
         oxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695834023; x=1696438823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lR0BPLKkgj2fJ5IyWi7flO/+WIQlLqax41QD5MIUKy0=;
        b=rKEoyNtFk5/AtFedur8AscWTFZTG/ew3X9zTXlhyQuF32tvHxVG6fbGdZj03ZqgoO3
         rQEfkE7PKVeBT95Kl2C6q4oHqtAamH396cwLrq3FlNFwyeBgo2jsYrUT7sfLnxhVRbTp
         W1CQr4DyaJDdAcPHYTt0S/pUMiuBuR/5gQ77nfLVwvL5dB9E1ZL251o2RjYxL9YVt8IL
         g18A/8haSsb0B0UMTo7LIEEPFGLfUfBga2eLs1C6nywPIZUZ3QX5ajRByfR764eJNYim
         qdMvD7kAcS9Hk/3tTDPUt/QF6OZnStNg03YjBAdu9EPYdp61Q64ynnHiuqnczDnvAR2t
         kNqQ==
X-Gm-Message-State: AOJu0YzxvGd0jIOxBv7i+KkamIu+CNpVZt6uqXCbgnQXjyQjQ5FI1nro
	XMKm0Hq/5rTGtc4oJLQ9+WHAOg==
X-Google-Smtp-Source: AGHT+IGbkNYcjY6OkDmHWUN+FpDde/aR1o0xZg9sHepbkCx/UdwSY0ITedw583PH98yPOZ8dUv5Kog==
X-Received: by 2002:a05:6102:f81:b0:452:de00:7ab4 with SMTP id e1-20020a0561020f8100b00452de007ab4mr1063401vsv.5.1695834023233;
        Wed, 27 Sep 2023 10:00:23 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.190.42])
        by smtp.gmail.com with ESMTPSA id u7-20020a637907000000b00584b293d157sm3279396pgc.80.2023.09.27.10.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 10:00:22 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v2 -next 0/4] RISC-V: ACPI improvements
Date: Wed, 27 Sep 2023 22:30:11 +0530
Message-Id: <20230927170015.295232-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series is a set of patches which were originally part of RFC v1 series
[1] to add ACPI support in RISC-V interrupt controllers. Since these
patches are independent of the interrupt controllers, creating this new
series which helps to merge instead of waiting for big series.

This set of patches primarily adds support below ECR [2] which is approved
by the ASWG and adds below features.

- Get CBO block sizes from RHCT on ACPI based systems.
- Set timer_can_not_wakeup in timer driver based on the flag in RHCT.

Additionally, the series contains a patch to improve acpi_os_ioremap().

[1] - https://lore.kernel.org/lkml/20230803175202.3173957-1-sunilvl@ventanamicro.com/
[2] - https://drive.google.com/file/d/1sKbOa8m1UZw1JkquZYe3F1zQBN1xXsaf/view?usp=sharing

Changes since RFC v1:
	1) Separated the patches from interrupt controller support series.
	2) Addressed feedback from Andy and Drew.
	3) Rebased to Palmer's for-next tree.
	4) Added RB tags received on RFC v1.

Sunil V L (4):
  RISC-V: ACPI: Enhance acpi_os_ioremap with MMIO remapping
  RISC-V: ACPI: RHCT: Add function to get CBO block sizes
  RISC-V: cacheflush: Initialize CBO variables on ACPI systems
  clocksource/timer-riscv: ACPI: Add timer_cannot_wakeup_cpu

 arch/riscv/Kconfig                |  1 +
 arch/riscv/include/asm/acpi.h     |  9 ++++
 arch/riscv/kernel/acpi.c          | 87 ++++++++++++++++++++++++++++++-
 arch/riscv/mm/cacheflush.c        | 37 ++++++++++---
 drivers/acpi/riscv/rhct.c         | 72 ++++++++++++++++++++++++-
 drivers/clocksource/timer-riscv.c |  4 ++
 6 files changed, 201 insertions(+), 9 deletions(-)

-- 
2.39.2


