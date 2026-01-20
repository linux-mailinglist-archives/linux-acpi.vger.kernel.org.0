Return-Path: <linux-acpi+bounces-20446-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOj/DbllcGkVXwAAu9opvQ
	(envelope-from <linux-acpi+bounces-20446-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jan 2026 06:35:53 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C015194C
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jan 2026 06:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1D34C5E7132
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 11:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAB0378D8F;
	Tue, 20 Jan 2026 11:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="Zxa8t9LI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69E1423141;
	Tue, 20 Jan 2026 11:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768908191; cv=none; b=b/wx5r9snv7sESgq6Esii03xp/N+Yovfcp3b3FdkuVWi1kxF8iK+rdKrIWHqYAyqqHwBGWj7N1mB9VXs2LiuAa2RbdgmFwOMV9TxMyYAr94Je6bYJukXPKjkN3nEwsAdDYkTBJSx9ZsbksyTwQY6yh7k/H8JjwJJTxd6XBS/7/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768908191; c=relaxed/simple;
	bh=FC801hB3/xwHT+vKzk2DxkHsypj4WxcNSE5wWSkFXc8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W9mQmE877cKoF0ah9ss60GhAI5Iw+pLayAKHOMEFY4fEO4poFIf1o/qTUthURa2P1vnH0YkXGPEAaOJPjFi1XKqIK4FAAHJiVDQfMSfDTk2nQOPxiaEPmxCiWKSppKWSInQnziwih7CpOkydkI1kJxOc97E/NhuKYEIuoFFmDrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=Zxa8t9LI; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=W/RL44c6sFsxU3xn2hcNRlraqlKHQiWNaLOGQqBV88Q=;
	b=Zxa8t9LIVX5cC7iuUxYZjqDn4s8QJAUEpAk8OB6f3zAclM9FwjMHUaLvfZb78aYBcpiXtkwhf
	e9iHvWyc1Y9cq4Vqs9zidv1FCxw1Ub+9K97O+de6pprp3OZQ5hIWcqKd/Lipzd7ZaSmfa9rzYho
	zL4/C1v6y6hWhhQz4Srsfko=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4dwPwh3JTPzpSt7;
	Tue, 20 Jan 2026 19:19:16 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id BA1464056D;
	Tue, 20 Jan 2026 19:23:00 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 20 Jan 2026 19:23:00 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 20 Jan 2026 19:22:59 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<wangzhi12@huawei.com>, <zhangpengjie2@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH v2 2/3] ACPI: processor: idle: Redefine acpi_processor_setup_cpuidle_dev to void
Date: Tue, 20 Jan 2026 19:22:57 +0800
Message-ID: <20260120112258.1595164-3-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260120112258.1595164-1-lihuisong@huawei.com>
References: <20260120112258.1595164-1-lihuisong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemn100009.china.huawei.com (7.202.194.112)
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : No valid SPF, DKIM not aligned (relaxed),quarantine];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[h-partners.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20446-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[h-partners.com:+];
	FROM_NEQ_ENVFROM(0.00)[lihuisong@huawei.com,linux-acpi@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,huawei.com:email,huawei.com:mid]
X-Rspamd-Queue-Id: 81C015194C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The callers of acpi_processor_setup_cpuidle_dev() ignore its return value.
This function can be redefined to a void function.

No intentional functional impact.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/acpi/processor_idle.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index d055dbae36c8..ba4cde028b0e 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1243,18 +1243,19 @@ static void acpi_processor_setup_cpuidle_states(struct acpi_processor *pr)
  * @pr: the ACPI processor
  * @dev : the cpuidle device
  */
-static int acpi_processor_setup_cpuidle_dev(struct acpi_processor *pr,
-					    struct cpuidle_device *dev)
+static void acpi_processor_setup_cpuidle_dev(struct acpi_processor *pr,
+					     struct cpuidle_device *dev)
 {
 	if (!pr->flags.power_setup_done || !pr->flags.power || !dev)
-		return -EINVAL;
+		return;
 
 	dev->cpu = pr->id;
-	if (pr->flags.has_lpi)
-		return acpi_processor_ffh_lpi_probe(pr->id);
+	if (pr->flags.has_lpi) {
+		acpi_processor_ffh_lpi_probe(pr->id);
+		return;
+	}
 
 	acpi_processor_setup_cpuidle_cx(pr, dev);
-	return 0;
 }
 
 static int acpi_processor_get_power_info(struct acpi_processor *pr)
-- 
2.33.0


