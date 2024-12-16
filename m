Return-Path: <linux-acpi+bounces-10145-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5579F2CB6
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2024 10:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C65C188A822
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2024 09:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456FC202C56;
	Mon, 16 Dec 2024 09:16:16 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E1C20101E;
	Mon, 16 Dec 2024 09:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734340576; cv=none; b=PwZMPV/9JiLNcrT1is9QPwd5NQ7F7RQc9tnPAmIdT6jD//5ig3dunMZEMHK2HqEk/qmbozvTTj/srHy0Ik27EnHEAHVpdvTKom3lJCvXNMRfQHu9sw1s7KKWkLsjagReHBSaWIB3TIW9/jRjjunTEaaqpFIqqoxqWrA+XvCi6hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734340576; c=relaxed/simple;
	bh=aX4HqyGzLzka94xiZImooBUJwmdy7RYEVbUgjk6BaS4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tMkjzFxv4JeDam1VgeWGjLq8acAYCXVMVIrhgcgR0GNyKc5EUg23OKw/NfJ5bR1AfTcMV31DlLSgR18CcPUTEfgMxbY5vsxpsfQ2pJ0cxcWytZpw32PUZJx4+BEVgk5GiC8TlNceXkfhnAhdTDxYPWElZVm/CXoT/7ysqvcVCf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4YBZ4H08G0zhZWW;
	Mon, 16 Dec 2024 17:13:35 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id F361F1400D5;
	Mon, 16 Dec 2024 17:16:04 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 16 Dec 2024 17:16:04 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <robert.moore@intel.com>,
	<viresh.kumar@linaro.org>
CC: <acpica-devel@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linuxarm@huawei.com>, <pierre.gondois@arm.com>, <ionela.voinescu@arm.com>,
	<jonathan.cameron@huawei.com>, <zhanjie9@hisilicon.com>,
	<lihuisong@huawei.com>, <zhenglifeng1@huawei.com>, <hepeng68@huawei.com>,
	<fanghao11@huawei.com>
Subject: [PATCH v3 0/4] Support for autonomous selection in cppc_cpufreq
Date: Mon, 16 Dec 2024 17:15:59 +0800
Message-ID: <20241216091603.1247644-1-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemh100008.china.huawei.com (7.202.181.93)

Add sysfs interfaces for CPPC autonomous selection in the cppc_cpufreq
driver.

The patch series is organized in two parts:

 - patch 1-2 refactor out the general CPPC register get and set functions
   in cppc_acpi.c

 - patches 3-4 expose sysfs files for users to control CPPC autonomous
   selection when supported

Since Pierre and me have discussed about whether or not to show
auto_act_window and energy_perf when auto_select is disabled. It seems
like whether to show these two files has their own points. We'd like to
ask for some advice.

Relevant discussion:
[1] https://lore.kernel.org/all/522721da-1a5c-439c-96a8-d0300dd0f906@huawei.com/

Change since v2:
 - change cppc_get_reg() and cppc_set_reg() name to cppc_get_reg_val() and
   cppc_set_reg_val()
 - extract cppc_get_reg_val_in_pcc() and cppc_set_reg_val_in_pcc()
 - return the result of cpc_read() in cppc_get_reg_val()
 - add pr_debug() in cppc_get_reg_val_in_pcc() when pcc_ss_id < 0
 - rename 'cpunum' to 'cpu' in cppc_get_reg_val()
 - move some macros from drivers/cpufreq/cppc_cpufreq.c to
   include/acpi/cppc_acpi.h with a CPPC_XXX prefix

Change since v1:
 - fix some incorrect placeholder
 - change kstrtoul to kstrtobool in store_auto_select

Lifeng Zheng (4):
  ACPI: CPPC: Add cppc_get_reg_val and cppc_set_reg_val function
  ACPI: CPPC: Refactor register value get and set ABIs
  ACPI: CPPC: Add autonomous selection ABIs
  cpufreq: CPPC: Support for autonomous selection in cppc_cpufreq

 .../ABI/testing/sysfs-devices-system-cpu      |  54 ++++
 drivers/acpi/cppc_acpi.c                      | 266 +++++++++---------
 drivers/cpufreq/cppc_cpufreq.c                | 129 +++++++++
 include/acpi/cppc_acpi.h                      |  29 ++
 4 files changed, 347 insertions(+), 131 deletions(-)

-- 
2.33.0


