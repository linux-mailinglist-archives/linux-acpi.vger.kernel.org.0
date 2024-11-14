Return-Path: <linux-acpi+bounces-9579-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F78A9C852D
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Nov 2024 09:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 571EB1F22B1F
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Nov 2024 08:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED0C1F7570;
	Thu, 14 Nov 2024 08:48:23 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5571E8822;
	Thu, 14 Nov 2024 08:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731574103; cv=none; b=Pfbt9UHpsVAzzC9AbPRMlYAMp4TiVaf7S8ctTWN1eiLUBKkqwD2MUuuEy6Lh6UUIWQ5SsLNx5TsmS+WVYSTsb1Up5boRSChNPB2tgPewK5/uoKdtGrdwCZom8ATCE6Zi3P6A6r4a/a92qXPUDxRHBS5aACk63mokvxdzYKgLyWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731574103; c=relaxed/simple;
	bh=WfUtS8wmBjwich4/bH6kQmwM9n6aLlG/Qrf+UCnO+vk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gP1lD2ZYXVbhzi+oGH1ZT798iZ2yyLuwRVeggN/IZJKRMgcIG/Q1ocOYNgy7S7b3f9YMNsIBIh0cLHMCW8yxcibnGrjscd/s05dkQ5xPnXY7qVwzGmLGO3890t88zaketrE/ZKHics71vyx0fUSz/GZtxtcX7QTQAcQo7FGZt1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Xptyz5kwmz10Qtw;
	Thu, 14 Nov 2024 16:45:47 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 625481402E0;
	Thu, 14 Nov 2024 16:48:18 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 14 Nov 2024 16:48:17 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <robert.moore@intel.com>,
	<viresh.kumar@linaro.org>
CC: <acpica-devel@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <fanghao11@huawei.com>,
	<zhenglifeng1@huawei.com>
Subject: [PATCH 0/3] Support for autonomous selection in cppc_cpufreq
Date: Thu, 14 Nov 2024 16:48:13 +0800
Message-ID: <20241114084816.1128647-1-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh100008.china.huawei.com (7.202.181.93)

Add sysfs interfaces for CPPC autonomous selection in the cppc_cpufreq
driver.

The patch series is organized in two parts:

 - patch 1 refactor out the general CPPC register get and set functions
   in cppc_acpi.c

 - patches 2-3 expose sysfs files for users to control CPPC autonomous
   selection when supported

Lifeng Zheng (3):
  ACPI: CPPC: Refactor register get and set ABIs
  ACPI: CPPC: Add autonomous selection ABIs
  cpufreq: CPPC: Support for autonomous selection in cppc_cpufreq

 .../ABI/testing/sysfs-devices-system-cpu      |  54 ++++
 drivers/acpi/cppc_acpi.c                      | 235 +++++++++---------
 drivers/cpufreq/cppc_cpufreq.c                | 141 +++++++++++
 include/acpi/cppc_acpi.h                      |  20 ++
 4 files changed, 331 insertions(+), 119 deletions(-)

-- 
2.33.0


