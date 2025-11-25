Return-Path: <linux-acpi+bounces-19236-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 583ACC83B9B
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Nov 2025 08:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B3F73AD063
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Nov 2025 07:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCAE2D7DF5;
	Tue, 25 Nov 2025 07:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="Lksi9awk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60ADC2D3A96;
	Tue, 25 Nov 2025 07:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764055780; cv=none; b=qjDS2gos1TFUVeZs3X+aSglgitpuJ1IDoAO5dlpi4mWu5EkBxk3QozLDcXmXrAHoDc8f/MZ5dYYUdmmhA6o+3FUmwbvfmcO3VYDVyM878VHAKqvCWDQ5XxUfcE6/KOJVj4/UEXC5xHkhl6keg9cii6ogVl3C3KOR5P+3nMO2hxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764055780; c=relaxed/simple;
	bh=WmfZUF+gSZyx0qA0ADn82w7MhTV9yEj1GExbfO76dGI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nJrk2G2CLVT7UXwT0HvJeR2Ddqh/BxCjy1TiWxdv9dddXVVIoIPHzHLBYWM2i5tW9IfxXKWHdV+i43nKxMwbH2oOwTspgLaDvcEQ1lG/JWA0hDSNXkcnO9w4hjoTyfGlHXzGj/pLPQF6ldWYxrGOD+nKAveEIsY08PC4Fvc58MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=Lksi9awk; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Dma+t1ZDclB9IiBsT5mlo9tVo8+qTq3voObFI/PMnbE=;
	b=Lksi9awkoErv4siGA5jH4247C/JqlCboH2yX+5uuwXP6/pxU52CgYzUs0TwZNHo5OeIam3a9K
	Z0vHv3NT6x0OZSMOT34QZjB1otOQrITSWWWmwLRCH57yFh5Ive8M95D2jtO1Q/9nXLZBlGgKKtO
	60nSCmk8U1UvKSAtk0a8EvQ=
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4dFvR6007YzpSvS;
	Tue, 25 Nov 2025 15:27:29 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 5C6221804F9;
	Tue, 25 Nov 2025 15:29:35 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 25 Nov 2025 15:29:34 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 25 Nov 2025 15:29:34 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Sudeep.Holla@arm.com>, <linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<lihuisong@huawei.com>
Subject: [PATCH 0/3] ACPI: processor: idle: Fix ACPI idle handling in power notify on failure
Date: Tue, 25 Nov 2025 15:29:30 +0800
Message-ID: <20251125072933.3706006-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemn100009.china.huawei.com (7.202.194.112)

The content in this series was initially discussed in the link [1].
This series disable ACPI idle feature if get power information failed in
power notify becuase the old idle states may not be usable anymore.

In addition, keep the same logical as acpi_processor_register_idle_driver
to get avaiable power information from all online CPUs instead of CPU0.

[1] https://lore.kernel.org/all/20251103084244.2654432-1-lihuisong@huawei.com

Huisong Li (3):
  cpuidle: Add enable_cpuidle() interface
  ACPI: processor: idle: Disable ACPI idle if get power information
    failed in power notify
  ACPI: processor: idle: Update idle states from avaiable power
    information

 drivers/acpi/processor_idle.c | 37 +++++++++++++++++++++++++++++------
 drivers/cpuidle/cpuidle.c     |  5 ++++-
 include/linux/cpuidle.h       |  2 ++
 3 files changed, 37 insertions(+), 7 deletions(-)

-- 
2.33.0


