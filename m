Return-Path: <linux-acpi+bounces-19239-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 738A4C83BAD
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Nov 2025 08:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98C153AE50D
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Nov 2025 07:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546FA2D94A7;
	Tue, 25 Nov 2025 07:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="qkqy9a8a"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69ED52D23BC;
	Tue, 25 Nov 2025 07:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764055799; cv=none; b=sc997A7CDtHlwe9d9hgTNwHRsEYQ/p1cB2R2ktoCzX/aDQq8ykPMom/VuhIjyr5tFDpq3VIfBYJK6Yd1RfeEc9nOERQV5fXKiGIJESTluo3eeII1okbc3ZYXQpXQ6F+ZyElSlDJLR02gB+JdJrsQ/lbLxw5F7RlaRFxm1Yqq8sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764055799; c=relaxed/simple;
	bh=X5/3gdJkRcceYG/DfbiK9+cgdMpYw8zbaZBPlRdOy9Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eGZUcPChtCFCpGm8rZhxhU01JmKtiTUsIspz9zXbbTpdsMw9ThpdE/qmrfXCkwVn2aHgiu/O3MMVk9ejUZ99a3DVGMHwuLbE4Bi+wLOaZM3CAzt0InkluabbG4DrU9CWW0GZA2c2lb4zs7K0+YLKuD9d6+zfIRDVuCswchoSKnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=qkqy9a8a; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=WiROCxrBtPQla3s66UVcRJVDrGmGEpn6T44vNOJN7to=;
	b=qkqy9a8au8DOLsrCNVO1RkMKqzHos3hl0X0VU+elZpG9y7qQ2omg2z3hkQcgj2jfbcfSUo+Xg
	LVmeni04hO6xHlwmfeA8Kuq1CbyU9MWEvikxGEND15vcuMF2c042PFcEsB8wsjLyVcpLX2+eaBp
	01NNktda3jKAZ4Ixi6UaMf4=
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4dFvRq11Crz1T4J7;
	Tue, 25 Nov 2025 15:28:07 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 69E49180B3F;
	Tue, 25 Nov 2025 15:29:48 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 25 Nov 2025 15:29:35 +0800
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
Subject: [PATCH 1/3] cpuidle: Add enable_cpuidle() interface
Date: Tue, 25 Nov 2025 15:29:31 +0800
Message-ID: <20251125072933.3706006-2-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251125072933.3706006-1-lihuisong@huawei.com>
References: <20251125072933.3706006-1-lihuisong@huawei.com>
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

The global switch of cpuidle can be turned back on in some case.
So add enable_cpuidle().

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/cpuidle/cpuidle.c | 5 ++++-
 include/linux/cpuidle.h   | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 56132e843c99..980ddfd3d930 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -48,7 +48,10 @@ void disable_cpuidle(void)
 {
 	off = 1;
 }
-
+void enable_cpuidle(void)
+{
+	off = 0;
+}
 bool cpuidle_not_available(struct cpuidle_driver *drv,
 			   struct cpuidle_device *dev)
 {
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index a9ee4fe55dcf..94c030748af3 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -168,6 +168,7 @@ struct cpuidle_driver {
 };
 
 #ifdef CONFIG_CPU_IDLE
+extern void enable_cpuidle(void);
 extern void disable_cpuidle(void);
 extern bool cpuidle_not_available(struct cpuidle_driver *drv,
 				  struct cpuidle_device *dev);
@@ -203,6 +204,7 @@ extern struct cpuidle_driver *cpuidle_get_cpu_driver(struct cpuidle_device *dev)
 static inline struct cpuidle_device *cpuidle_get_device(void)
 {return __this_cpu_read(cpuidle_devices); }
 #else
+static inline void enable_cpuidle(void) { }
 static inline void disable_cpuidle(void) { }
 static inline bool cpuidle_not_available(struct cpuidle_driver *drv,
 					 struct cpuidle_device *dev)
-- 
2.33.0


