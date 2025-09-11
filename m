Return-Path: <linux-acpi+bounces-16666-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52291B53028
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Sep 2025 13:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBD9D1BC5872
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Sep 2025 11:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860E03191B1;
	Thu, 11 Sep 2025 11:24:16 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C503148AC;
	Thu, 11 Sep 2025 11:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757589856; cv=none; b=tNkYImJxSY3peS3gi32lEO8VOsjxFJ6ZulCywx52ze3gWKnt8s3Erdyy4HXRhRT0ZiuejEJFGVfB0/QLAVecdEES6TM1+rZTKojFw9+958thOlz1HcPR1FtD1H0wVQfSuljCBoetrDn1H3a6wQjC99NnuJu4LQ5Vko9uIILDDBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757589856; c=relaxed/simple;
	bh=segigDKqprvHFkuzaRX3Iz3GmIJSmxRPgaXPAaYatLI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f3swI+VGxwNmODQCsRgJSY0eCur6zRnlgsi4t4H47kaNqgFPz8KY7M4QG4zn7h4ad6CtG55kib5/QMi+LzwXAYpu0xSbRl+7p4synCaasVMP7gDKwTQ2B9dQZEMQIxZe4QmILhTCtzQ8NwcwmlRV8pCGTSSiQrVJPO96w4XsZCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cMwCl1PknztTd3;
	Thu, 11 Sep 2025 19:23:15 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 281F6180B62;
	Thu, 11 Sep 2025 19:24:10 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 11 Sep 2025 19:24:09 +0800
Received: from localhost.localdomain (10.50.165.33) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 11 Sep 2025 19:24:09 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<lihuisong@huawei.com>
Subject: [PATCH v3 0/3] ACPI: processor: Fix function declaration of processor_idle.c
Date: Thu, 11 Sep 2025 19:24:05 +0800
Message-ID: <20250911112408.1668431-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemn100009.china.huawei.com (7.202.194.112)

This serises is aimed to fix the function declaration of processor_idle.c.
And the modification idea of this series is from the link[1].

The patch fixed the warning reported by the kernel test robot in link[1]
has been applied in v2.

[1] https://lore.kernel.org/oe-kbuild-all/202508300519.tZQHY6HA-lkp@intel.com/

---
 Changelog
  v3:
   - remove the merged patch which fixed the warning in link[1]
   - add a separate patch to handle the "extern struct
     cpuidle_driver acpi_idle_driver" in processor.h.

  v2:
   - split patch v1
     https://patchwork.kernel.org/project/linux-acpi/cover/20250905081900.663869-1-lihuisong@huawei.com/

Huisong Li (3):
  ACPI: processor: Remove unused empty function definition for
    processor_idle.c
  ACPI: processor: Unify the place of function declaration of
    processor_idle.c
  ACPI: processor: Do not expose the global acpi_idle_driver variable

 drivers/acpi/processor_driver.c |  3 +--
 drivers/acpi/processor_idle.c   |  5 +++++
 include/acpi/processor.h        | 28 ++--------------------------
 3 files changed, 8 insertions(+), 28 deletions(-)

-- 
2.33.0


