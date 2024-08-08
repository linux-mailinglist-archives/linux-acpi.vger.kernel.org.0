Return-Path: <linux-acpi+bounces-7444-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1565C94BE4A
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Aug 2024 15:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 462351C2498D
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Aug 2024 13:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F018618A6DD;
	Thu,  8 Aug 2024 13:15:49 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBF718B48D
	for <linux-acpi@vger.kernel.org>; Thu,  8 Aug 2024 13:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723122949; cv=none; b=huhGD3d58IM3ByrOhn6JzRrK3yPKPXrB2MRSGUYxki0nZV04K7pMYpFsUsBS3JPqw5ToL5ELS1GUeKpfPjvzqGBLPyObKSt1ww2z7KLlrqV2qfFZ9+WtmT0CTYGE/H+Se5aP83nX5e/zn0zi560OAoFetkJDH9zpdmZCAAc2egk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723122949; c=relaxed/simple;
	bh=omlAygFSvf8YdONy0npAXJcAea5nXdTQfr4kCPZK2hI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nuk3QS5af4FjdFFGlmmJr4aOhnq5SIoS2gwHhjNwUwGwGPRZYfOQ8I9tSs5KJPECJcqrARG+L8IOcdW2MQDcbR/8kbScxnmy1eMr2QPW0jHrJHXlw9IqxWxyeTH05e+Jtsjwbihe6DThd6MYxvzH5jpvbuXmfe1DeLqndfyC938=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WfnVD3x8dz1j6Q4;
	Thu,  8 Aug 2024 21:11:00 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id C0F611402C7;
	Thu,  8 Aug 2024 21:15:44 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 8 Aug 2024 21:15:44 +0800
From: Hanjun Guo <guohanjun@huawei.com>
To: Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>
CC: Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
	<linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>, Hanjun
 Guo <guohanjun@huawei.com>
Subject: [PATCH 0/3] cleanups for ARM64 ACPI
Date: Thu, 8 Aug 2024 21:15:19 +0800
Message-ID: <20240808131522.1032431-1-guohanjun@huawei.com>
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

Remove some leftover functions in asm/acpi.h, and ACPI NUMA
code are not strictly arch specific, move them to drivers/acpi/arm64/.

Hanjun Guo (3):
  ARM64: ACPI: Remove the leftover acpi_init_cpus()
  ARM64: ACPI: Remove the leftover arm64_acpi_numa_init()
  ARM64: ACPI: Move the NUMA code to drivers/acpi/arm64/

 arch/arm64/include/asm/acpi.h                        | 12 ------------
 arch/arm64/kernel/Makefile                           |  1 -
 drivers/acpi/arm64/Makefile                          |  1 +
 .../arm64/kernel => drivers/acpi/arm64}/acpi_numa.c  |  0
 include/linux/acpi.h                                 |  4 ++++
 5 files changed, 5 insertions(+), 13 deletions(-)
 rename {arch/arm64/kernel => drivers/acpi/arm64}/acpi_numa.c (100%)

-- 
2.25.1


