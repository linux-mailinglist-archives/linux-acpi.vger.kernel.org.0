Return-Path: <linux-acpi+bounces-8482-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A579892E9
	for <lists+linux-acpi@lfdr.de>; Sun, 29 Sep 2024 05:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E1811F21046
	for <lists+linux-acpi@lfdr.de>; Sun, 29 Sep 2024 03:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D741F94D;
	Sun, 29 Sep 2024 03:38:31 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADF817C8B;
	Sun, 29 Sep 2024 03:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727581111; cv=none; b=F07JGn8vPPlIYYb9Kk/z1kvb2RUQsmFJgRu7w8Esib/hWC31RXFSTGOkBkpF8JeDOGoGI88/ITQm81CIN1BKg5TZ90c4gAe+7IGmkQuMUe3YkiSN6YuXzm+aaXoGHEHKMBpUiqO9XURHZTGWoD+C/p0mQxJ6RXyRiU3R3kEe5N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727581111; c=relaxed/simple;
	bh=9VkY50E8QK4yXq60zaRNmqSImq1PPvd/e3dCjlpe4XI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MtJMaZCpnKMXY6sTzFFdRZOp3mJJlXwoXIicOSI71Dm9PlC5g2qQQbyzOqKfbICnlrapAglq7F1cjO6HO7sKYSeC99PbbuuWaxc2SlzdMtTwfb/3JdMVEWUkLRFrfBmbwlrgPTaK1DL3K15Kd/Wuywelz1rIDEyImkzZKaIuWH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XGVJM3X62z1SBPs;
	Sun, 29 Sep 2024 11:37:23 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (unknown [7.185.36.137])
	by mail.maildlp.com (Postfix) with ESMTPS id 31673140157;
	Sun, 29 Sep 2024 11:38:16 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpeml500019.china.huawei.com (7.185.36.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 29 Sep 2024 11:38:15 +0800
From: Jie Zhan <zhanjie9@hisilicon.com>
To: <viresh.kumar@linaro.org>, <rafael@kernel.org>, <ionela.voinescu@arm.com>,
	<beata.michalska@arm.com>, <wangxiongfeng2@huawei.com>
CC: <linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
	<zhanjie9@hisilicon.com>, <jonathan.cameron@huawei.com>,
	<wanghuiqiang@huawei.com>, <zhenglifeng1@huawei.com>, <lihuisong@huawei.com>,
	<yangyicong@huawei.com>, <liaochang1@huawei.com>, <zengheng4@huawei.com>
Subject: [PATCH v4 0/2] cppc_cpufreq: Rework ->get() error handling when cores are idle
Date: Sun, 29 Sep 2024 11:32:12 +0800
Message-ID: <20240929033214.1039485-1-zhanjie9@hisilicon.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500019.china.huawei.com (7.185.36.137)

CPPC feedback counters can be unchanged or 0 when cores are idle, e.g.
clock-gated or power-gated.  In such case, get the latest desired perf for
calculating frequency.

Also, the HiSilicon CPPC workaround can now be removed as it can be handled
by the common code.

---
v4:
- Some additional comments as suggested. No functions changes.

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
v3: https://lore.kernel.org/all/20240919084552.3591400-1-zhanjie9@hisilicon.com/

Jie Zhan (2):
  cppc_cpufreq: Use desired perf if feedback ctrs are 0 or unchanged
  cppc_cpufreq: Remove HiSilicon CPPC workaround

 drivers/cpufreq/cppc_cpufreq.c | 128 ++++++++++++---------------------
 1 file changed, 46 insertions(+), 82 deletions(-)

-- 
2.33.0


