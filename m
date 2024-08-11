Return-Path: <linux-acpi+bounces-7499-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DE194DFFA
	for <lists+linux-acpi@lfdr.de>; Sun, 11 Aug 2024 06:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BD331C20B6A
	for <lists+linux-acpi@lfdr.de>; Sun, 11 Aug 2024 04:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67B911CAB;
	Sun, 11 Aug 2024 04:23:33 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C81FBE8
	for <linux-acpi@vger.kernel.org>; Sun, 11 Aug 2024 04:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723350213; cv=none; b=DX62ZozFi6ycSAt1+Ok+eqfZ7APxQ23abPwxqIb22VVRY9W/LsFbWACMtRuW2p8+YW97awJcYjHMSqF+TRXpQmqJe61Z0ikztuLwwp3NB5vZUw++eh7+plJvvRfoPCOmmIvvg+TZW/cVFV0nb7pF927T/zdFynZdL7c1Bp1ElT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723350213; c=relaxed/simple;
	bh=Kv24KHA23+ovb0FXM3xYsvy6s7/1dJY0TJQ1BYKJTp0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=krL25lSZ2iVmu+jcoLJ3NXUdhJ7vjOhGm9yB6JywtluO2UQlxpmOXFXhLmZNVASQRWJK6Gb0ki6JTTgwWv2uooHPB8wGPfXWOK2DVGOFoUkY+gcDWt2s5hmm0C+/JMf6v1KtQ0R3D4DVLJC8MZQVUGj/lij26GRA3KF4c5E+lJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WhPXr2DgXz20l7w;
	Sun, 11 Aug 2024 12:18:52 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id AD7D6140138;
	Sun, 11 Aug 2024 12:23:22 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sun, 11 Aug 2024 12:23:22 +0800
From: Hanjun Guo <guohanjun@huawei.com>
To: Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>
CC: Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
	<linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>, Hanjun
 Guo <guohanjun@huawei.com>
Subject: [PATCH v2 0/4] Cleanups for ARM64 ACPI
Date: Sun, 11 Aug 2024 12:22:59 +0800
Message-ID: <20240811042303.3498761-1-guohanjun@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Cleanups for ARM64 ACPI, first remove some leftover functions in
asm/acpi.h, then make acpi_numa_get_nid() invisible to kernel/smp.c
for the preparation to move acpi_numa.c to drivers/acpi/arm64/.

ACPI NUMA code for ARM64 are not strictly arch specific, move them
to drivers/acpi/arm64/.

From v1:
1. Add patch "ACPI: Make acpi_numa_get_nid() invisible to
   kernel/smp.c" to do some preparation for moving acpi_numa.c
   to drivers/acpi/arm64/.
2. Fix the conflict with riscv implementation.

Compiled with ACPI enabled and disabled on ARM64, with ACPI enabled
on RISC-V.

Hanjun Guo (4):
  ARM64: ACPI: Remove the leftover acpi_init_cpus()
  ARM64: ACPI: Remove the leftover arm64_acpi_numa_init()
  ARM64: ACPI: Make acpi_numa_get_nid() invisible to kernel/smp.c
  ARM64: ACPI: Move the NUMA code to drivers/acpi/arm64/

 arch/arm64/include/asm/acpi.h                        | 12 ------------
 arch/arm64/kernel/Makefile                           |  1 -
 arch/arm64/kernel/smp.c                              |  5 -----
 drivers/acpi/arm64/Makefile                          |  1 +
 .../arm64/kernel => drivers/acpi/arm64}/acpi_numa.c  |  8 +++++++-
 include/linux/acpi.h                                 |  1 +
 6 files changed, 9 insertions(+), 19 deletions(-)
 rename {arch/arm64/kernel => drivers/acpi/arm64}/acpi_numa.c (94%)

-- 
2.25.1


