Return-Path: <linux-acpi+bounces-19714-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5FFCD065F
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Dec 2025 15:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7B7E3017647
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Dec 2025 14:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219C630FC08;
	Fri, 19 Dec 2025 14:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="cuXI98sC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC8427FB35
	for <linux-acpi@vger.kernel.org>; Fri, 19 Dec 2025 14:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766155786; cv=none; b=RODaLOz/1zDCkKRpZ89FTHKYPvpHLHlbNoek8h6N+qQUZXECYI/JdvriJ76ITozKwU/rKhsJJRyCy67AbL1ODDxsdAKILrQw0t2JpFCG7yZwlq1+G1DNB9XjB/leUvBICGjRII1WkkNkHwqOS0JpPbo7IQGn9R+DyJWAXJis2kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766155786; c=relaxed/simple;
	bh=+Tp8CMDnW7asxzuHa3KneanYjFNAYllglbT23a6t4zk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R7ybU42E4AtHDsIzkmCpnl04UANwDakRFB+Lv4BlpDaHB8xeFmTrbkjCRRGDf7bzA1o71xsClcNrlu+90rBZowIVxU3QyQGYW9k1zZkppYzkjZBEIirLcBubBPGQ216zfLj2fdAM+9ScLsHG4xY7R/r1a8liQkooTNUrzEUWPOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=cuXI98sC; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=FxRRySUQAmQQGS37Z35MmmKWhPZZY2M1tezZ/ckkK0Y=;
	b=cuXI98sCVP2g5k/pY2YI6OFXvVTZwb5i9qBNyu4Pc857dpkQbiY32UTM+NaI/FDw9HoaLoQyg
	lBGJQkLWdHEY3fV6fZduB0xX+UGhEvXbOnEMlVCOmPLsSKhmz+FIpMQDL4aBvaa1830orUb8vai
	al5qC5KxcswKQmcqk9GCtvM=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4dXr3b2JtGz1T4G3;
	Fri, 19 Dec 2025 22:47:23 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 975F520109;
	Fri, 19 Dec 2025 22:49:38 +0800 (CST)
Received: from localhost.localdomain (10.50.87.83) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 19 Dec 2025 22:49:38 +0800
From: Hanjun Guo <guohanjun@huawei.com>
To: Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Sudeep Holla
	<sudeep.holla@arm.com>
CC: "Rafael J . Wysocki" <rafael@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH] MAINTAINERS: Update the maintainers for ARM64 ACPI
Date: Fri, 19 Dec 2025 22:49:06 +0800
Message-ID: <20251219144906.348353-1-guohanjun@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500002.china.huawei.com (7.185.36.57)

ARM64 ACPI patches go via ARM64 tree, but the listed maintainers
for ARM64 ACPI don't include Catalin and Will, and there is no
F: line under the ARM64 architecture entry, so emails will not
route to Catalin and Will in an automatic way.

Adding Catalin and Will to the maintainers entry for ARM64 ACPI
to fix the problem, it will make life easy for merging ARM64 ACPI
patches.

Adding new maintainer entries for ARM64 ACPI doesn't mean the review
work will balance to the new maintainer, patches still need to be
acked by currently listed folks (Lorenzo, Hanjun, Sudeep) before
merging them.

Link: https://lore.kernel.org/linux-acpi/aS2ZTfS9YVO98Exe@willie-the-truck/
Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b11839cba9d..6050d94a50ec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -335,6 +335,8 @@ ACPI FOR ARM64 (ACPI/arm64)
 M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
 M:	Hanjun Guo <guohanjun@huawei.com>
 M:	Sudeep Holla <sudeep.holla@arm.com>
+M:	Catalin Marinas <catalin.marinas@arm.com>
+M:	Will Deacon <will@kernel.org>
 L:	linux-acpi@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-- 
2.25.1


