Return-Path: <linux-acpi+bounces-19234-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 55937C83971
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Nov 2025 07:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB8E54E96DA
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Nov 2025 06:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D012F28EF;
	Tue, 25 Nov 2025 06:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="gF7tg9ZJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EA32EDD70;
	Tue, 25 Nov 2025 06:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764053543; cv=none; b=blv2Bq0mWy8M+8SgEkRHU0u1Ez6C+KQxnosoTnWiYvk86MuFoJhNhdOJ0iTRLAYEqoeGMLoS37uJnL+FfnR0sC+RpDh/K87HhpRQHgrtDOnPF+XIyDZfNThoC3JNpdtMgF7lFUNgFsAr2IJ+PHjEYuUf2eleK69pwQX+iD6QgT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764053543; c=relaxed/simple;
	bh=J4h71TNKV4mI6f/rwpFNEMhGwOj3PbrCPXOeVs9M9Fs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Riyjt4aW1kCGWK6Lmt3ffk37yLs9PLTO5o41RooOeAKiyUVj8k0zlkYoPdrXCK/BEYWw0YQaHCdPrA681j9vuaiwDRgysfTUQEptb7LZiCkxJfLYh7OgQg+7G9bvPS7t4xlUHWWrQXkjnWDcykyUSSabB3uSA3XTdrK99mbHG74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=gF7tg9ZJ; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=oDP33d6CNdnOovdv/Yf/POqWbQZRT4hW2EDpQhohVkM=;
	b=gF7tg9ZJk/lwpmwtFAqjFDFatl0djXIeNd1Bjm2krKpbETvc22lJVgIWzQKtSCVU6kUz82ULK
	c/FbEegSkEqiKVyEBzjnNOBhAwrHEoBf8Ry1QGShsiEJaw7wWFBy2VxdKhxQYVCGUEb0AmAUaQ2
	8nfl74xmv0PZyglV8VrfN0U=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4dFtcJ4JKWz1prQF;
	Tue, 25 Nov 2025 14:50:24 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id E9609140257;
	Tue, 25 Nov 2025 14:52:12 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 25 Nov 2025 14:52:11 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 25 Nov 2025 14:52:10 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Sudeep.Holla@arm.com>, <linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<lihuisong@huawei.com>
Subject: [PATCH 0/3] ACPI: processor: idle: Enhance LPI verification and
Date: Tue, 25 Nov 2025 14:52:07 +0800
Message-ID: <20251125065210.3670266-1-lihuisong@huawei.com>
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
 kwepemn100009.china.huawei.com (7.202.194.112)

This series is aimed to let LPI verification effective and redefine
two functions to void, which is a part of the series in link [1].

[1] https://lore.kernel.org/all/20251103084244.2654432-1-lihuisong@huawei.com

Huisong Li (3):
  ACPI: processor: idle: Relocate and verify
    acpi_processor_ffh_lpi_probe
  ACPI: processor: idle: Redefine acpi_processor_setup_cpuidle_dev to
    void
  ACPI: processor: idle: Redefine acpi_processor_setup_cpuidle_states to
    void

 drivers/acpi/processor_idle.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

-- 
2.33.0


