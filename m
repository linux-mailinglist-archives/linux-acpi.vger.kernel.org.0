Return-Path: <linux-acpi+bounces-12882-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B40A81D90
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 08:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98E62881142
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 06:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD09C2144D6;
	Wed,  9 Apr 2025 06:57:11 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B30212FA2;
	Wed,  9 Apr 2025 06:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744181831; cv=none; b=cHefyLdW+LEuvr+qi7bZsTQN4MoELGUlaHoaaK0wk8XsZMla09/BVcmmF6GcmxCVNkB9awvM8PxrWnUP6DmC5JAYBlFwy6nU0XaRv+/+1vQlUDChtStLIFZoaC3zsoQYIrVEmUfP5a2SQBTJEv2PqviV8TaQBCgvC6IeDvIxAc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744181831; c=relaxed/simple;
	bh=5OqQXLP2ulysEHMnWREeyJq89gXDNN8qHGaB8hrEtD4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iNTmpgQE0zJm7PF98PyOjO0m0mFI0xocBIQX5l1YPr7gz13VJFJi9gfluZvwx73NchnP6obh0psUGB7PQRnNC1MZZjVYE/CR/Rh4fL3Kvx1E9MorqhtihjdmE6DycWaq47Tf8He6gtScj8mbgsXqNjAnhahRiwiKsNV5DYi6Y1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ZXYZG0X2szHrW0;
	Wed,  9 Apr 2025 14:53:42 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 68E481402C4;
	Wed,  9 Apr 2025 14:57:05 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 9 Apr 2025 14:57:04 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <robert.moore@intel.com>,
	<viresh.kumar@linaro.org>, <mario.limonciello@amd.com>,
	<gautham.shenoy@amd.com>, <ray.huang@amd.com>, <perry.yuan@amd.com>,
	<pierre.gondois@arm.com>
CC: <acpica-devel@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>,
	<cenxinghai@h-partners.com>, <zhenglifeng1@huawei.com>, <hepeng68@huawei.com>
Subject: [PATCH v6 0/8] Add functions for getting and setting registers related to autonomous selection in cppc_acpi
Date: Wed, 9 Apr 2025 14:56:55 +0800
Message-ID: <20250409065703.1461867-1-zhenglifeng1@huawei.com>
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

The patch series is organized in two parts:

 - patch 1-6 refactor out the general CPPC register get and set functions
   in cppc_acpi.c

 - patches 7-8 add functions for getting and setting values of auto_sel,
   energy_perf and auto_act_window in cppc_acpi.c

Changelog:

v6:

 - Remove the last patch, will resent it in the future after reaching an
   agreement with Sumit
 - split patch 3 into 2 smaller patches
 - Remove the printing of reg_idx in cppc_get_reg_val() and
   cppc_set_reg_val()
 - Change the logic for determing whether a register is supported in
   cppc_get_reg_val() and cppc_set_reg_val()

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

---
Discussions of previous versions:
v1: https://lore.kernel.org/all/20241114084816.1128647-1-zhenglifeng1@huawei.com/
v2: https://lore.kernel.org/all/20241122062051.3658577-1-zhenglifeng1@huawei.com/
v3: https://lore.kernel.org/all/20241216091603.1247644-1-zhenglifeng1@huawei.com/
v4: https://lore.kernel.org/all/20250113122104.3870673-1-zhenglifeng1@huawei.com/
v5: https://lore.kernel.org/all/20250206131428.3261578-1-zhenglifeng1@huawei.com/

Lifeng Zheng (8):
  ACPI: CPPC: Add IS_OPTIONAL_CPC_REG macro to judge if a cpc_reg is
    optional
  ACPI: CPPC: Optimize cppc_get_perf()
  ACPI: CPPC: Rename cppc_get_perf() to cppc_get_reg_val()
  ACPI: CPPC: Extract cppc_get_reg_val_in_pcc()
  ACPI: CPPC: Add cppc_set_reg_val()
  ACPI: CPPC: Refactor register value get and set ABIs
  ACPI: CPPC: Modify cppc_get_auto_sel_caps() to cppc_get_auto_sel()
  ACPI: CPPC: Add three functions related to autonomous selection

 drivers/acpi/cppc_acpi.c     | 304 +++++++++++++++++++++--------------
 drivers/cpufreq/amd-pstate.c |   3 +-
 include/acpi/cppc_acpi.h     |  30 +++-
 3 files changed, 210 insertions(+), 127 deletions(-)

-- 
2.33.0


