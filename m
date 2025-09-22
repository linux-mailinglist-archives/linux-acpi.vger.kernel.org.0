Return-Path: <linux-acpi+bounces-17169-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1EFB8F369
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 09:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A5877A30CC
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 07:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4305A274B2F;
	Mon, 22 Sep 2025 07:04:01 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD2B22FE10;
	Mon, 22 Sep 2025 07:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758524641; cv=none; b=sv+n3Fo/JzvrmbzX5QuzFdcB1CcXiXpiMa8zaUmKTYqF7FosakCK/yn1O0Xn+UYRk1vfm+D2bui6UT1CaxKdd1mq6PB5dnl9DpzF7MphNz5rk01PaDhLBdx8+O5wTArLT2BNCgBoSFeRrgeMJukuGGLpyjKBV6QaJrSLjbYnKzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758524641; c=relaxed/simple;
	bh=GVMcixn4Xnfxg8E8X+Mh+Js9zSpyO84U3D7bkW0FsX0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nffL4Q2YjSsBYLoTTpPaTz/m+xFM5BCCppBt+KuSwk4CYz1bLiZ4zBA9bpgUMf222TAWpBfZ/aDODZxyaEWncKsj+99OHJB8SumO/qnYAQBjpAH5DtXQ4c/rqO64d83VhWuFjehDJtAs1bsVOvgr/ZIblGTofDBiazs2Onrsdcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cVYsN5Kyvz2RW8k;
	Mon, 22 Sep 2025 15:00:24 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id F1D131800B2;
	Mon, 22 Sep 2025 15:03:55 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 22 Sep 2025 15:03:55 +0800
Received: from localhost.localdomain (10.50.165.33) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 22 Sep 2025 15:03:55 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<lihuisong@huawei.com>
Subject: [PATCH v4 0/1] ACPI: processor: Fix function declaration of processor_idle.c
Date: Mon, 22 Sep 2025 15:03:53 +0800
Message-ID: <20250922070354.485296-1-lihuisong@huawei.com>
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
Except for this patch, all other patches in this series have been merged.

[1] https://lore.kernel.org/oe-kbuild-all/202508300519.tZQHY6HA-lkp@intel.com/

---
 Changelog
  v4:
   - remove other patches merged.
   - add static for global variable as Rafael suggested.

  v3:
   - remove the merged patch which fixed the warning in link[1]
   - add a separate patch to handle the "extern struct
     cpuidle_driver acpi_idle_driver" in processor.h.
     https://patchwork.kernel.org/project/linux-acpi/cover/20250728070612.1260859-1-lihuisong@huawei.com/
  v2:
   - split patch v1
     https://patchwork.kernel.org/project/linux-acpi/cover/20250905081900.663869-1-lihuisong@huawei.com/

Huisong Li (1):
  ACPI: processor: Do not expose the global acpi_idle_driver variable

 drivers/acpi/processor_driver.c |  3 +--
 drivers/acpi/processor_idle.c   | 12 +++++++++++-
 include/acpi/processor.h        |  1 -
 3 files changed, 12 insertions(+), 4 deletions(-)

-- 
2.33.0


