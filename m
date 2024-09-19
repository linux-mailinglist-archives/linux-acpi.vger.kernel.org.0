Return-Path: <linux-acpi+bounces-8338-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F75297C642
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Sep 2024 10:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAFD928213E
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Sep 2024 08:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546CE19922A;
	Thu, 19 Sep 2024 08:51:55 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60662199244;
	Thu, 19 Sep 2024 08:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726735915; cv=none; b=I/bXz89RsBOA0BRyY8uz7BaFLJar4uS20yrvAGlvkk3iv1UHpAjaBLjwX5waenqGFDh5MF42n9e+kxZAXaatAmMUhBX0M28zcjoAwtRvScTF/E88NM5r86A0fIGVoztOUS2rHWj5weLhN8v/O8+Mt/uixnLbhpc517hSmP5Bn+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726735915; c=relaxed/simple;
	bh=Dc95LWHjNR/DHvmk/+/0VIsB55nuNQ/Vg4eL6tGCFeA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LjLg23/VVTPfdgaL7dMfW2G3rSwMgpULdVcejyWGZ+cdM3B+rUwTV5Ru2zDrXOirX8G1KGN2xDl0wLTOTOJWTQhILBVHV27mZLfEKg9+aB/r+g50IMcLh0hOj2sjAAQT40/9rVB7jPq1cBclpkGpRnRy+HuIcPVB9mo7XJBWDWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4X8TlV2yvWz20p7t;
	Thu, 19 Sep 2024 16:51:34 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (unknown [7.185.36.137])
	by mail.maildlp.com (Postfix) with ESMTPS id 12E85180044;
	Thu, 19 Sep 2024 16:51:49 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpeml500019.china.huawei.com (7.185.36.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 16:51:48 +0800
From: Jie Zhan <zhanjie9@hisilicon.com>
To: <ionela.voinescu@arm.com>, <beata.michalska@arm.com>,
	<wangxiongfeng2@huawei.com>, <viresh.kumar@linaro.org>, <rafael@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
	<zhanjie9@hisilicon.com>, <jonathan.cameron@huawei.com>,
	<wanghuiqiang@huawei.com>, <zhenglifeng1@huawei.com>, <lihuisong@huawei.com>,
	<yangyicong@huawei.com>, <liaochang1@huawei.com>, <zengheng4@huawei.com>
Subject: [PATCH v3 0/2] cppc_cpufreq: Rework ->get() error handling when cores are idle
Date: Thu, 19 Sep 2024 16:45:50 +0800
Message-ID: <20240919084552.3591400-1-zhanjie9@hisilicon.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500019.china.huawei.com (7.185.36.137)

CPPC feedback counters can be unchanged or 0 when cores are idle, e.g.
clock-gated or power-gated.  In such case, get the latest desired perf for
calculating frequency.

Also, the HiSilicon CPPC workaround can now be removed as it can be handled
by the common code.

---

v3:
- Merge patch 1 & 2, tidy up the logic, and reduce duplicate code
- Return 0 in cppc_perf_from_fbctrs() if the feedback counters are
  unchanged rather than return a cached desired perf
- Return early in cppc_scale_freq_workfn() if the feedback counters are
  unchanged

v2:
- Try reading the lastest desired perf first before using the cached one
- Do the same handling logic when feedback counters are unchanged
- Remove hisilicon workaround

Discussions:
v1: https://lore.kernel.org/all/20240819035147.2239767-1-zhanjie9@hisilicon.com/
v2: https://lore.kernel.org/all/20240912072231.439332-1-zhanjie9@hisilicon.com/

Jie Zhan (2):
  cppc_cpufreq: Use desired perf if feedback ctrs are 0 or unchanged
  cppc_cpufreq: Remove HiSilicon CPPC workaround

 drivers/cpufreq/cppc_cpufreq.c | 120 +++++++++++----------------------
 1 file changed, 39 insertions(+), 81 deletions(-)

-- 
2.33.0


