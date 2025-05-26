Return-Path: <linux-acpi+bounces-13894-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D96C6AC3E99
	for <lists+linux-acpi@lfdr.de>; Mon, 26 May 2025 13:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1EF27A6335
	for <lists+linux-acpi@lfdr.de>; Mon, 26 May 2025 11:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF7E14A09C;
	Mon, 26 May 2025 11:31:10 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7624910E3;
	Mon, 26 May 2025 11:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748259070; cv=none; b=Dr4UXvkZPiItQzpqJPHcLlE57qI5Uu+8DIJnEUw9PMA/Tu2Dl1N+JJ+76Pr4FJ2KC4R3r4MiQuu9BpfzCTlsE4eLoQXreTIS0QvYVYyS+jKVt2rEUxyOnhwcd7b67loib2RfgHKJd5s3sXXKCnioF0oFysPARZ9bDWQWRv2vdwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748259070; c=relaxed/simple;
	bh=aWKAJqxQ5cA15GSoq6PTN/J56VFxZG1kjousgJwks5o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GeKWMbxMHCOL/C14v+e5o5vfQphXKE5rlprjaBW4MTIBVD3zs2p3oTVGnLdOCisFVSg3hn3Ng1HDaT4GNw3g+BtcNsGIl1PkZ1s5SpTY34eZrkU9yv4O3LuPGOFbU340l/lUIpyAMx4rpbbQ/6WWNM3F31kuJa6ESD5y5/loaKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4b5YSf5LpYz13LvC;
	Mon, 26 May 2025 19:29:22 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 9387C18006C;
	Mon, 26 May 2025 19:31:04 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 26 May 2025 19:31:03 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <robert.moore@intel.com>,
	<lenb@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>,
	<cenxinghai@h-partners.com>, <yubowen8@huawei.com>, <zhenglifeng1@huawei.com>
Subject: [PATCH 0/3] cpufreq: CPPC: Some optimizations for cppc_cpufreq.c.
Date: Mon, 26 May 2025 19:30:54 +0800
Message-ID: <20250526113057.3086513-1-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemh100008.china.huawei.com (7.202.181.93)

This patch series makes some minor optimizations for cppc_cpufreq.c to
makes codes cleaner.

Lifeng Zheng (3):
  cpufreq: CPPC: Remove cpu_data_list
  cpufreq: CPPC: Return void in populate_efficiency_class()
  cpufreq: CPPC: Remove forward declaration of
    cppc_cpufreq_register_em()

 drivers/cpufreq/cppc_cpufreq.c | 59 +++++++++-------------------------
 include/acpi/cppc_acpi.h       |  1 -
 2 files changed, 15 insertions(+), 45 deletions(-)

-- 
2.33.0


