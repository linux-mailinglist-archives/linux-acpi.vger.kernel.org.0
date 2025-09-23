Return-Path: <linux-acpi+bounces-17217-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1C6B94196
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Sep 2025 05:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA8FD17848B
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Sep 2025 03:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F33324E4AF;
	Tue, 23 Sep 2025 03:24:37 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD422CCC0;
	Tue, 23 Sep 2025 03:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758597877; cv=none; b=qqqpaxHo5aedSzV5AZvO7EZzcuIE9tKjl58zD9E0pYQQt0liyYlRvlHkM3ovz9nNSNqPjzKm+PEWjYNlBGYj+adFnR0LrTtGhiC12qMqWNwqpziLvg8Z95IQAcNw6LgQCk63dqe7N/5KK3doPHIFKR0Xp+9Eo2VzMAYZGiLCR9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758597877; c=relaxed/simple;
	bh=6I7Tz5oGq8xu77RMJZcEsFIC/cgt56+jt1kL0mNzyMI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tCzqeN1ghzxo63cmoE+Rw+nUoSNxzxrYQ2NIcEO0M6Q/CeYSMI3715GpY81KzGSMtQAUKeQg/MJh3jraclAFjwC4V2ERAZTbJfLzkzQ+TR7/KMEEK6GEsLKyRlFZ63Q+2ATKhtMrvq+xFa0qmStNH7kilmhh84B/eObT9HFHoZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cW50n0ZTlztTfQ;
	Tue, 23 Sep 2025 11:23:37 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 144411402EA;
	Tue, 23 Sep 2025 11:24:30 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 23 Sep 2025 11:24:29 +0800
Received: from localhost.localdomain (10.50.165.33) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 23 Sep 2025 11:24:29 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<lihuisong@huawei.com>
Subject: [PATCH v5 0/1] ACPI: processor: Fix function declaration of processor_idle.c
Date: Tue, 23 Sep 2025 11:24:27 +0800
Message-ID: <20250923032428.2656329-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemn100009.china.huawei.com (7.202.194.112)

This serises is aimed to fix the function declaration of processor_idle.c.
And the modification idea of this series is from the link[1].
Except for this patch, all other patches in this series have been merged.

[1] https://lore.kernel.org/oe-kbuild-all/202508300519.tZQHY6HA-lkp@intel.com/

---
 Changelog
  v5:
   - fix some comments from Rafael.
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

 drivers/acpi/processor_driver.c | 3 +--
 drivers/acpi/processor_idle.c   | 9 ++++++++-
 include/acpi/processor.h        | 1 -
 3 files changed, 9 insertions(+), 4 deletions(-)

-- 
2.33.0


