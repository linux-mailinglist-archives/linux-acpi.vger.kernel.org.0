Return-Path: <linux-acpi+bounces-729-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFA67CE022
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 16:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49C37B20FCB
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 14:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFE737C84
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 14:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="f4yws7ud"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB3934CC7
	for <linux-acpi@vger.kernel.org>; Wed, 18 Oct 2023 12:40:15 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D498C106
	for <linux-acpi@vger.kernel.org>; Wed, 18 Oct 2023 05:40:14 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6b44befac59so3867046b3a.0
        for <linux-acpi@vger.kernel.org>; Wed, 18 Oct 2023 05:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1697632814; x=1698237614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/x3uu9zf3l2rig8KiIUkNU7Cv7Jr5Is7Qpx6yKtZAfw=;
        b=f4yws7udr4dhiWN6u8KB3P6yF1S5jAVjmD0YQtB+Pmg+Yx5/C7G7qiu3UFdL7gLLDO
         8NniZKYB5tUg1xGWYzjPaePhQuHmTZvSTJXA8nAkgNyAbb9FbfymuTnIg03u9CqBRI6F
         2hR2LJe0acpApgLqx2iwRh+F8Kw8ga1Oc8PgE0q0nTbRoK9CuwsUkY6rvcAVWc4hRkO5
         koFzjfF3i72fYVonL4AZACxzgGNxMmKz1RouwpTZ7eytGWt9rg7W2s1S99mCy2F7/81W
         SnS28PIiT8iBXz89v4GhnivslotW8moU7S5c9oEHKVGMV9CCLmqsJonU8g68ec1WYqX4
         O5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697632814; x=1698237614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/x3uu9zf3l2rig8KiIUkNU7Cv7Jr5Is7Qpx6yKtZAfw=;
        b=Y9DtKJL1t84+ZbVtO5s+ots10D586VPujGPqWxgy9FQGjPkby58fMGJIscB/M7nF/1
         UAcC1f+Ner4PInGma3eai/sH+IvL2nDe5hyTaEOo2rgAX2hHucM3XVJwEwEtViHcyzBB
         eyWNXvT9tOnou598+Gg6ZIm5+XpZseiizJl6rMyO1W0cxMdk/r7GwE8XHqWuonmVOudL
         Z2GPE7hJ7eeYps4XJr9tG3VfKAN9TP1UJMjJuvu5YRdGExst1TpFspXnDCz086YVejlU
         tcJqMG5UEizHzHi+mAVoBG5HfAep8Ap4SyG9WplPzZA2/5AcOX3wkBVrpmGORTh6soIt
         nLFA==
X-Gm-Message-State: AOJu0Yx4bBRbHYWshAtMP1Q8bVf1pzGncfsYspLdQyUIkENNhwai6XNJ
	CkOn7SgTmzSc2Yk2ljnLqN11MQ==
X-Google-Smtp-Source: AGHT+IGEnGeUGjTrjv2baYtR5a8vWsazPx3pLfK2Zn0Z8uBJVrUEphyrDMbgW79aJUk55uqnYKQ+WA==
X-Received: by 2002:a05:6a21:190:b0:149:700e:f50a with SMTP id le16-20020a056a21019000b00149700ef50amr8044741pzb.29.1697632813642;
        Wed, 18 Oct 2023 05:40:13 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id w190-20020a6382c7000000b005891f3af36asm1599267pgd.87.2023.10.18.05.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 05:40:13 -0700 (PDT)
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
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v4 -next 0/4] RISC-V: ACPI improvements
Date: Wed, 18 Oct 2023 18:10:03 +0530
Message-Id: <20231018124007.1306159-1-sunilvl@ventanamicro.com>
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

Changes since v3:
	1) Added new patch to update return value of acpi_get_rhct() as suggested by Drew.
	2) Formatting fixes as suggested by Drew.
	3) Updated tags.

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


Sunil V L (4):
  RISC-V: ACPI: Enhance acpi_os_ioremap with MMIO remapping
  RISC-V: ACPI: Update the return value of acpi_get_rhct()
  RISC-V: ACPI: RHCT: Add function to get CBO block sizes
  RISC-V: cacheflush: Initialize CBO variables on ACPI systems

 arch/riscv/Kconfig            |  1 +
 arch/riscv/include/asm/acpi.h |  6 +++
 arch/riscv/kernel/acpi.c      | 87 +++++++++++++++++++++++++++++++-
 arch/riscv/mm/cacheflush.c    | 25 +++++++---
 drivers/acpi/riscv/rhct.c     | 93 +++++++++++++++++++++++++++++++++--
 5 files changed, 201 insertions(+), 11 deletions(-)

-- 
2.39.2


