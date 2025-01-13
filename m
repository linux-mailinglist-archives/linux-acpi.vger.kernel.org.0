Return-Path: <linux-acpi+bounces-10545-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73944A0B6B7
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 13:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F090E1887D4E
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 12:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DC9233D85;
	Mon, 13 Jan 2025 12:21:16 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A587B22AE75;
	Mon, 13 Jan 2025 12:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736770876; cv=none; b=VRVw/Bv6auvPWlbdpjfKdfd1fpoH4ww/nNkC5HE0dS1T/ug6rd875oWhK7ATOSSIi1uYHLixeEPDH/YG6QOAYWYYSLErzACC7tYc40trzR9yu134nKQv9fQEnn1y9HzX5wsxR2YxNtP5bqsseDXEsICQVt+P32mXFzzCvphdpQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736770876; c=relaxed/simple;
	bh=eDUBdG9s1RWTx81cm8cANOu8fq+JRyUO066Yrx0jLOE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sGJ4+EeUJy8NO5fUa3R1Ob+DG0DXcYHbH+IhQVhfgTQBAWpaiYSiTQxVtb+ZtUXRAabonzGvmLGQkFbs+LhBtaJrevgHha+mQwDuvFq9DIXypOO102n8XdNQXZNfCptc5ryqBmexdOHy9sEQ6Dr6T4E8+cjtoIIbFA2FeTPjERo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YWrr64Gc1z2Djfy;
	Mon, 13 Jan 2025 20:17:58 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 6DF851402C3;
	Mon, 13 Jan 2025 20:21:06 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 13 Jan 2025 20:21:05 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <robert.moore@intel.com>,
	<viresh.kumar@linaro.org>, <mario.limonciello@amd.com>,
	<gautham.shenoy@amd.com>, <ray.huang@amd.com>, <pierre.gondois@arm.com>
CC: <acpica-devel@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <zhenglifeng1@huawei.com>,
	<hepeng68@huawei.com>, <fanghao11@huawei.com>
Subject: [PATCH v4 0/6] Support for autonomous selection in cppc_cpufreq
Date: Mon, 13 Jan 2025 20:20:58 +0800
Message-ID: <20250113122104.3870673-1-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemh100008.china.huawei.com (7.202.181.93)

Add sysfs interfaces for CPPC autonomous selection in the cppc_cpufreq
driver.

The patch series is organized in two parts:

 - patch 1-4 refactor out the general CPPC register get and set functions
   in cppc_acpi.c

 - patches 5-6 expose sysfs files for users to control CPPC autonomous
   selection when supported

---
Since Pierre and me have discussed about whether or not to show
auto_act_window and energy_perf when auto_select is disabled. It seems
like whether to show these two files has their own points. We'd like to
ask for some advice.

Relevant discussion:
[1] https://lore.kernel.org/all/522721da-1a5c-439c-96a8-d0300dd0f906@huawei.com/

Changelog:

v4:

 - add REG_OPTIONAL and IS_OPTIONAL_CPC_REG to judge if a cpc register is
   an optional one
 - check whether the register is optional before CPC_SUPPORTED check in
   cppc_get_reg_val() and cppc_set_reg_val()
 - check the register's type in cppc_set_reg_val()
 - add macros to generally implement registers getting and setting
   functions
 - move some logic codes from cppc_cpufreq.c to cppc_acpi.c
 - replace cppc_get_auto_sel_caps() by cppc_get_auto_sel()

v3:

 - change cppc_get_reg() and cppc_set_reg() name to cppc_get_reg_val() and
   cppc_set_reg_val()
 - extract cppc_get_reg_val_in_pcc() and cppc_set_reg_val_in_pcc()
 - return the result of cpc_read() in cppc_get_reg_val()
 - add pr_debug() in cppc_get_reg_val_in_pcc() when pcc_ss_id < 0
 - rename 'cpunum' to 'cpu' in cppc_get_reg_val()
 - move some macros from drivers/cpufreq/cppc_cpufreq.c to
   include/acpi/cppc_acpi.h with a CPPC_XXX prefix

v2:

 - fix some incorrect placeholder
 - change kstrtoul to kstrtobool in store_auto_select

Lifeng Zheng (6):
  ACPI: CPPC: Add IS_OPTIONAL_CPC_REG macro
  ACPI: CPPC: Add cppc_get_reg_val and cppc_set_reg_val function
  ACPI: CPPC: Add macros to generally implement registers getting and
    setting functions
  ACPI: CPPC: Refactor register value get and set ABIs
  ACPI: CPPC: Add autonomous selection ABIs
  cpufreq: CPPC: Support for autonomous selection in cppc_cpufreq

 .../ABI/testing/sysfs-devices-system-cpu      |  54 +++
 drivers/acpi/cppc_acpi.c                      | 332 +++++++++---------
 drivers/cpufreq/amd-pstate.c                  |   3 +-
 drivers/cpufreq/cppc_cpufreq.c                | 109 ++++++
 include/acpi/cppc_acpi.h                      |  30 +-
 5 files changed, 359 insertions(+), 169 deletions(-)

-- 
2.33.0


