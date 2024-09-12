Return-Path: <linux-acpi+bounces-8261-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE0B9762A9
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Sep 2024 09:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D6EFB22343
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Sep 2024 07:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D9718DF62;
	Thu, 12 Sep 2024 07:28:28 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDAF189521;
	Thu, 12 Sep 2024 07:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726126107; cv=none; b=QXJZpEKH2ER+Jer+ZMdU2rgl1JQxB4X0O+C1FmMbpl0vQfj4d/X/GvyT9cmQ4RKeMgumxgRLn7aUZOxatRBHXMdXk8w/2CQaMRqDEw2fs79rrGsh8EJ+ct89gEK8hjm4FZVzhdvp1z0QOZbdsvL342fPipY8roeLm+ZWpC/Etsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726126107; c=relaxed/simple;
	bh=RrPTbcCpAfV8k1AbAO9/s+RxS4FFPanYF+XlEDPmo2A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fQrFItYWvNNb5EcCuKFedQU1wIQ01TgNR7tdLe73lisSlGuHVuQCrLFG5juzsGU3hkf3zSkfg9INBmxNYvaWe6I9DjhRY3FEo8FMg3TX8ztXE+bSD/hSmN5OhVMb6SKuwodjtrWqamyLn1ghtWzdfbtiXQ2V8Ma8iBYDNLfRJG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4X48Dc2thJz69XP;
	Thu, 12 Sep 2024 15:28:16 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (unknown [7.185.36.137])
	by mail.maildlp.com (Postfix) with ESMTPS id 856981800D4;
	Thu, 12 Sep 2024 15:28:23 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpeml500019.china.huawei.com (7.185.36.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Sep 2024 15:28:23 +0800
From: Jie Zhan <zhanjie9@hisilicon.com>
To: <ionela.voinescu@arm.com>, <beata.michalska@arm.com>,
	<wangxiongfeng2@huawei.com>, <viresh.kumar@linaro.org>, <rafael@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
	<zhanjie9@hisilicon.com>, <jonathan.cameron@huawei.com>,
	<wanghuiqiang@huawei.com>, <zhenglifeng1@huawei.com>, <lihuisong@huawei.com>,
	<yangyicong@huawei.com>, <liaochang1@huawei.com>, <zengheng4@huawei.com>
Subject: [PATCH v2 0/3] cppc_cpufreq: Rework ->get() error handling when cores are idle
Date: Thu, 12 Sep 2024 15:22:28 +0800
Message-ID: <20240912072231.439332-1-zhanjie9@hisilicon.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500019.china.huawei.com (7.185.36.137)

CPPC feedback counters can be unchanged or 0 when cores are idle, e.g.
clock-gated or power-gated.  In such case, get the latest desired perf for
calculating frequency.  Also, the HiSilicon CPPC workaround is now handled
by the common code and can be removed.

Jie Zhan (3):
  cppc_cpufreq: Return desired perf in ->get() if feedback counters are
    0
  cppc_cpufreq: Return latest desired perf if feedback counters don't
    change
  cppc_cpufreq: Remove HiSilicon CPPC workaround

 drivers/cpufreq/cppc_cpufreq.c | 103 +++++++++------------------------
 1 file changed, 27 insertions(+), 76 deletions(-)

-- 
2.33.0


