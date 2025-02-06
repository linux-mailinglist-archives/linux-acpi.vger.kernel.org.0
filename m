Return-Path: <linux-acpi+bounces-10911-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D2CA2A960
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Feb 2025 14:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9B347A3A16
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Feb 2025 13:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD90523A599;
	Thu,  6 Feb 2025 13:14:37 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6832222F391;
	Thu,  6 Feb 2025 13:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738847677; cv=none; b=MVH0xCu07awDc4pi00l/1B9Dzr7qhU8cayezBMtYQiaBX7F+wGoKpxMNJUNTT/MzNxZGR2j37K2yme3dRZn1prB1pRemjTsarQVfzLETdwZuifwsUztJv3xWCga/BXQNxAULpHVFZSyTwuO3RyuE1+qcnOTg2qfRNBENOcRV0Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738847677; c=relaxed/simple;
	bh=vHAGrAf4YWkDgVgUsCR2p/jiGWJqleALHntTmxeHJTY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YwiByEKDqpCnmH/yVWs1TRSmo6Su3XFfAaRyZcUhvqYW7FmM33YD0sfI9A//hdZekNxlNGqGLCis6gxxL+qzkj1qqsACCY91htzWA5kAKSfyTHoTGs9U+kGUFmEnPXD57MipwD4zYcs3+fD+CWAbU3Q37ODbXwCpRIF1QSGKjN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Ypct35Bymz2Fcxv;
	Thu,  6 Feb 2025 21:10:51 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 19DC81A0188;
	Thu,  6 Feb 2025 21:14:30 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 6 Feb 2025 21:14:29 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <robert.moore@intel.com>,
	<viresh.kumar@linaro.org>, <mario.limonciello@amd.com>,
	<gautham.shenoy@amd.com>, <ray.huang@amd.com>, <pierre.gondois@arm.com>
CC: <acpica-devel@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linuxarm@huawei.com>, <yumpusamongus@gmail.com>,
	<srinivas.pandruvada@linux.intel.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <zhenglifeng1@huawei.com>,
	<hepeng68@huawei.com>, <fanghao11@huawei.com>
Subject: [PATCH v5 0/8] Support for autonomous selection in cppc_cpufreq
Date: Thu, 6 Feb 2025 21:14:20 +0800
Message-ID: <20250206131428.3261578-1-zhenglifeng1@huawei.com>
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

 - patch 1-5 refactor out the general CPPC register get and set functions
   in cppc_acpi.c

 - patches 6-8 expose sysfs files for users to control CPPC autonomous
   selection when supported

Changelog:

v5:

 - add more explanation to the commit logs and comments
 - change REG_OPTIONAL from bin to hex
 - split patch 2 into 3 smaller patches
 - remove CPPC_REG_VAL_READ() and CPPC_REG_VAL_WRITE() macros
 - move the modification part in patch 5 into a separate patch
 - rename the sysfs file from "energy_perf" to
   energy_performance_preference_val

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

Lifeng Zheng (8):
  ACPI: CPPC: Add IS_OPTIONAL_CPC_REG macro to judge if a cpc_reg is
    optional
  ACPI: CPPC: Optimize cppc_get_perf()
  ACPI: CPPC: Rename cppc_get_perf() to cppc_get_reg_val()
  ACPI: CPPC: Add cppc_set_reg_val()
  ACPI: CPPC: Refactor register value get and set ABIs
  ACPI: CPPC: Modify cppc_get_auto_sel_caps() to cppc_get_auto_sel()
  ACPI: CPPC: Add three functions related to autonomous selection
  cpufreq: CPPC: Support for autonomous selection in cppc_cpufreq

 .../ABI/testing/sysfs-devices-system-cpu      |  54 ++++
 drivers/acpi/cppc_acpi.c                      | 303 +++++++++++-------
 drivers/cpufreq/amd-pstate.c                  |   3 +-
 drivers/cpufreq/cppc_cpufreq.c                | 109 +++++++
 include/acpi/cppc_acpi.h                      |  30 +-
 5 files changed, 372 insertions(+), 127 deletions(-)

-- 
2.33.0


