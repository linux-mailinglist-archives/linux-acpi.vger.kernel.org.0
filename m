Return-Path: <linux-acpi+bounces-4474-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D406788D561
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Mar 2024 05:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FB642A63EA
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Mar 2024 04:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F5322F02;
	Wed, 27 Mar 2024 04:11:30 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEF5224F0
	for <linux-acpi@vger.kernel.org>; Wed, 27 Mar 2024 04:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711512690; cv=none; b=pCcnBEMI1zs86l0MdBMIokMA9nTSPi3BMANrnyxGs/K6ZeO3ZitEV6HKpOoBwUfeCsWEg9FAMrdS5seYY9LSBi+WYeph2onn1fGWlnBH8GqRVEN1f9Sp+9jugVBJBNgnYeaN+XZqKxHwgq/BbXkhhbE3Gc0Sisbz2ry9T1x6uSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711512690; c=relaxed/simple;
	bh=aE0wrt3onU8ZQtCvaeErZnHCExQ6dME88PEQRLCb8wM=;
	h=To:CC:From:Subject:Message-ID:Date:MIME-Version:Content-Type; b=luY5wWS2MB4xTGvzRKmgTsVKOJiOmhXnu4dW1I8Ybby4QhCpjRGV0okq/T6lnHiXAs6Ty6WHAxGL98F/P4clbj6iNLI0jmuUHYn6Xr3jMlrWk+sWBCvAexv4NxksGuSN0NB4XjQGMnjxV1Qjl0JD/NuhfaZu5yLSECHA2UjtJ+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4V4CpJ1S3Zz2BhbQ;
	Wed, 27 Mar 2024 12:08:40 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (unknown [7.185.36.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 82FFD1A0188;
	Wed, 27 Mar 2024 12:11:19 +0800 (CST)
Received: from [10.174.179.5] (10.174.179.5) by dggpemm500002.china.huawei.com
 (7.185.36.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 27 Mar
 2024 12:11:19 +0800
To: James Morse <james.morse@arm.com>
CC: <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel
 Maling List <linux-acpi@vger.kernel.org>, Xie XiuQi <xiexiuqi@huawei.com>
From: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Subject: [Question] report ghes_estatus_pool consume too much memory
Message-ID: <b77541c1-5dcc-d4a2-77c0-5d30f1be6d20@huawei.com>
Date: Wed, 27 Mar 2024 12:11:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500002.china.huawei.com (7.185.36.229)

Hello James,

   Sorry to bother you. It's just that we have come across a problem that
ghes_estatus_pool consume too much meory.
   I upgrade the linux kernel of a AMD machine from 4.18 to 5.10. The free
memory decreased about 1GB. I found out it is because ghes_estatus_pool consumed
about 900MB.
root:~ # cat /proc/vmallocinfo | grep ghes
0xffffb3eb06aed000-0xffffb3eb06caf000 1843200 ghes_estatus_pool_init+0x3e/0xa0
pages=449 vmalloc N0=449
0xffffb3eb30001000-0xffffb3eb680d3000 940384256 ghes_estatus_pool_init+0x3e/0xa0
pages=229585 vmalloc vpages N0=229585

It is because the following commit alloc 64K for each ghes.
   ACPI / APEI: Make estatus pool allocation a static size

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v6.8-rc7&id=fb7be08f1a091ec243780bfdad4bf0c492057808

But the AMD machine have 14350 ghes, only 8 of them are nofified through NMI.
64K for each ghes. So it will consume about 900M
[wxf@localhost ~]$ cat HEST.dsl | grep "Notify Type : 04 \[NMI\]" | wc -l
8
[wxf@localhost ~]$ cat HEST.dsl | grep "Notify Type :" | wc -l
14350

So I'm wondering whether we can revert this commit. I am not sure if there
exists any retriction. Thanks a lot!

Thanks,
Xiongfeng


