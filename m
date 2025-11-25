Return-Path: <linux-acpi+bounces-19231-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C18DC83860
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Nov 2025 07:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 15A4334AB96
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Nov 2025 06:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF532C027B;
	Tue, 25 Nov 2025 06:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="jFQfeKK+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C3427FB34;
	Tue, 25 Nov 2025 06:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764053235; cv=none; b=UOd6JuR7udqfp+8iqlA4829teOMXndKF+0Z5SSk9ea4UZRMsbCZ+N7SBasBy2LYRwSrHuSZjXNabIcbOxEfqvFzBFtYRtHXMCYprBLhMWIKXa7CI5jc/TVBjyqWlwHH1I0AEfeWlCgIoJ91BMH94ChAcQRzbsncoJ28J+MAEfq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764053235; c=relaxed/simple;
	bh=RsH3fwfxjCJQQVVMUCsGkge1a+1nhQcs4jves+MJ9Kc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AV7U4tP0yczh2Mj3nIFBJ83rl/Pn3SYYv5umgq99VSs5lymLjF61IigpoaROTQxOCKAQ4C5jvNSEEI8N0HofYrTipJ12sA+xsbjoHPFFJlEvKR9sPnD1gBFlus62Zi+3wp0a9nGQBvC0VQvki3p0EookrGuZ1FqWOaAZy/s1H0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=jFQfeKK+; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=W4a/ol4Vy/d+Oe0jO4j6VcFK7IUKujnoDkxRTyVSAwY=;
	b=jFQfeKK+PS+pV4opp8V31RDx8qo3GH6iN+fKv+ELftAET5FsALLBKoHrEqNHyw30DZ/FFS9L0
	QopM4mNQubxWa2FoBYRWucOuuE0rNpS6ON6IUIE/WkmLAPsS4e4MDZaHQ2BA2Ub8iD2WXf+ShkC
	vELW6D155eje+bDhe/55aus=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4dFtV20LK1zpSvS;
	Tue, 25 Nov 2025 14:44:58 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 5CF401402C1;
	Tue, 25 Nov 2025 14:47:03 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 25 Nov 2025 14:47:03 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 25 Nov 2025 14:47:02 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Sudeep.Holla@arm.com>, <linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<lihuisong@huawei.com>
Subject: [PATCH] ACPI: processor: idle: Add debug log for the state whose entry method is illegal
Date: Tue, 25 Nov 2025 14:47:02 +0800
Message-ID: <20251125064702.3666149-1-lihuisong@huawei.com>
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

According to ACPI spec, entry method in LPI sub-package must be buffer
or integer. Driver will disable the state whose the entry method is
illegal by zero flags in struct acpi_lpi_state. The entry method is
very key in cpuidle. A debug log is very useful developers.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/acpi/processor_idle.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 22909fccf0b1..5f86297c8b23 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -946,6 +946,8 @@ static int acpi_processor_evaluate_lpi(acpi_handle handle,
 			lpi_state->entry_method = ACPI_CSTATE_INTEGER;
 			lpi_state->address = obj->integer.value;
 		} else {
+			pr_debug("Entry method of state-%d is illegal, disable it.\n",
+				 state_idx);
 			continue;
 		}
 
-- 
2.33.0


