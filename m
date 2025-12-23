Return-Path: <linux-acpi+bounces-19807-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E83FCD8D2C
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 11:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2E393071042
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 10:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DD8363C6D;
	Tue, 23 Dec 2025 10:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="flvGybIM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E963624BD;
	Tue, 23 Dec 2025 10:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766484565; cv=none; b=fqYo4jbV0v4ht5IRLDblZSZg7nZRlwwyX7U7wXcUFiYYhYDs1v6VvGQkCR1Myrvbd5tbSR9p5jgy/gJXU0TzIPZHIjfchc/+BoDxXXCevLGqAeV/gKBuN9/0YjftI5vDTVMyF/T55T4ycvFJoAUExBLF0knAOL5BTAYaIJLkLnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766484565; c=relaxed/simple;
	bh=Lx/iE5h1LhEbHA2olRCH+dY7ExRpsj0fu+qMzUj0hlM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mGvK7DbbrbtLA/KEdG4vAhRqYHF9kQXATDoU+5Km//nrQI9La3qwWtpJORAoY/dmuagMbKbRHqLwuNr2QLzUnedBL9L/gdAwV1XhDNMPnZesV67gsHgmM3JiialZK4CboGAo06wd0RIdhT2jv30/4YnTEEIAL1fCxsz2Tm4EfFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=flvGybIM; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=oMOpGlJchI45Cc2Ng/Drlg7x/MH9qlevrg+5vIkR9+w=;
	b=flvGybIMvafd7un2sJoLQO/PJvk+DbJ64gb7dSNjycsflYWn97IFDST5416WdB20Y1Fm1EGJa
	M66YTAkTWtZmW92Kx6gsa0j9SEQbcxs/WFe3pr4n4lXvIgr6ZqeXXj/WQphzA0cYGUCifqag4zb
	jR7W6oXmSYZUfTcoGJN0Jeo=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4db9dM3WM2zLlVp;
	Tue, 23 Dec 2025 18:06:15 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 306FD4056C;
	Tue, 23 Dec 2025 18:09:21 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 23 Dec 2025 18:09:15 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 23 Dec 2025 18:09:14 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <bp@alien8.de>,
	<AmandeepKaur.Longia@amd.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<zhangpengjie2@huawei.com>, <wangzhi12@huawei.com>,
	<prime.zeng@hisilicon.com>, <lihuisong@huawei.com>
Subject: [PATCH v1 0/6] ACPI: processor: Recovery some reverted patches
Date: Tue, 23 Dec 2025 18:09:08 +0800
Message-ID: <20251223100914.2407069-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemn100009.china.huawei.com (7.202.194.112)

This series of patches have been reverted due to the crash issue reported
by Borislav [1] and a missing cpuidle sysfs directory reported by Amandeep.

The root cause was commit 7a8c994cbb2d (ACPI: processor: idle: Optimize
ACPI idle driver registration).  Since the other patches in the series 
depended on this commit, they were also reverted.

I have analyzed these issues and implemented the following fixes:
Fix for the Crash:
The crash occurred because 'max_cstate' (which defaults to 8) was not
updated before the ACPI idle states were initialized.  As a result, the idle
driver believed multiple C-states were available, but only the state with
index 1 was actually initialized in the per-CPU acpi_cstate array.  When the
cpuidle governor tried to access a C-state index greater than 1, it hit a
NULL pointer.
Patch 1/6 fixes this by adding acpi_processor_cstate_first_run_checks() to
update 'max_cstate' before initialization.

Fix for missing /sys/devices/system/cpu/cpu*/cpuidle directory:
The previous optimization depended on an external patch [2].  In kernel versions
without that patch, acpi_processor_start() was being called before the ACPI idle
driver had finished registering.  This caused the cpuidle device registration
to fail, resulting in the missing directory.
Patch 1/6 fixes this by moving acpi_processor_register_idle_driver() ahead of 
the acpi_processor_driver registration.

Note:
In this series, only patch 1/6 has been modified to address these bugs, more
detail changes please see the commit.  Patches 2-6/6 remain identical to the
versions that were previously merged.

[1] https://lore.kernel.org/lkml/20251124200019.GIaSS5U9HhsWBotrQZ@fat_crate.local/
[2] https://lore.kernel.org/all/20240529133446.28446-2-Jonathan.Cameron@huawei.com/

Huisong Li (4):
  ACPI: processor: idle: Optimize ACPI idle driver registration
  ACPI: processor: Remove unused empty stubs of some functions
  ACPI: processor: idle: Rearrange declarations in header file
  ACPI: processor: Do not expose global variable acpi_idle_driver

Rafael J. Wysocki (2):
  ACPI: processor: Update cpuidle driver check in
    __acpi_processor_start()
  ACPI: processor: idle: Redefine two functions as void

 drivers/acpi/processor_driver.c |  13 +++-
 drivers/acpi/processor_idle.c   | 116 +++++++++++++++++++-------------
 include/acpi/processor.h        |  34 ++--------
 3 files changed, 86 insertions(+), 77 deletions(-)

-- 
2.33.0


