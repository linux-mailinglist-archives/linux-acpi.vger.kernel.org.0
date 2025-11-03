Return-Path: <linux-acpi+bounces-18421-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 699A1C2A9B9
	for <lists+linux-acpi@lfdr.de>; Mon, 03 Nov 2025 09:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C8B33A6D56
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Nov 2025 08:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C532E54DB;
	Mon,  3 Nov 2025 08:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="MPXge9kZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2D82E3B15;
	Mon,  3 Nov 2025 08:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762159376; cv=none; b=Vh/Z5KK3/FRBEamwRRCf24k8DDqImZX0u1cBgpTUKjKIuj6HctrBAcyK5si7WZ3umz/jiSVyf5CvV0hmvSB8e4X8smKNIRMVRVV28Qe2J8JxZfjZW8WFAgFLq46i0sQzvdY+WGxvsRmZkN1V4prnProxVt5zu1aVRZz6S7no1Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762159376; c=relaxed/simple;
	bh=b0cFH/dw4TqAECJ0j0rSvmDchB/OCs3ZFetztlScKEU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fJCV+5sEaWqRcjd6YwiYFx2Cu5RjmUtSPbBkce1xo5by4xzp20xk0//lmbJSKf938NrfH+t2YnGcr1JQpFV+KKuZvnCaJ0XAwKTI03FvR8w2flMAx5/NzMIfYxjaAkykWzRVhJfOcSz2gtJW4ieL1vjii1gtowneFuDPoBJKNQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=MPXge9kZ; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=7AEYczK+1l+A0ELZLDbSR3AR3IGjYRryW8CiZbqiNJY=;
	b=MPXge9kZOaoKtK9WZpJPBEHaRjKmXOUFgmOaWYnu5WJW6fA+8wCijJMntPkIbhx+ZPIhp7L2r
	mxYp77Gj63OcOqgG3uJCZBqAA9X3gQ12se4OIyFu56qb7AN0o/i9/0eDrCbuQZ3ZydI3+ATU8vP
	6Oy+LMuhIKpywoJQvBAVFR0=
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4d0Q6K57fTzcb0C;
	Mon,  3 Nov 2025 16:41:13 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id A4EBF14020C;
	Mon,  3 Nov 2025 16:42:46 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 3 Nov 2025 16:42:46 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 3 Nov 2025 16:42:45 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Sudeep.Holla@arm.com>, <linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<lihuisong@huawei.com>
Subject: [PATCH v2 2/7] ACPI: processor: idle: Mark the state as invalid when get lpi_state->arch_flags failed
Date: Mon, 3 Nov 2025 16:42:39 +0800
Message-ID: <20251103084244.2654432-3-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251103084244.2654432-1-lihuisong@huawei.com>
References: <20251103084244.2654432-1-lihuisong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemn100009.china.huawei.com (7.202.194.112)

The architecture specific context loss flags is important for ARM.
And this flag is used to control the execution of different code
flows in acpi_processor_ffh_lpi_enter().

So mark the state as invalid when get lpi_state->arch_flags of this
state failed.

Fixes: a36a7fecfe60 ("ACPI / processor_idle: Add support for Low Power Idle(LPI) states")
Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/acpi/processor_idle.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 9f1040eac051..5213a545fa78 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -983,8 +983,12 @@ static int acpi_processor_evaluate_lpi(acpi_handle handle,
 		if (obj_get_integer(pkg_elem + 2, &lpi_state->flags))
 			lpi_state->flags = 0;
 
-		if (obj_get_integer(pkg_elem + 3, &lpi_state->arch_flags))
-			lpi_state->arch_flags = 0;
+		if (obj_get_integer(pkg_elem + 3, &lpi_state->arch_flags)) {
+			pr_err("Get state-%d architecture specific context loss flags failed, disable it.\n",
+			       state_idx);
+			lpi_state->flags = 0;
+			continue;
+		}
 
 		if (obj_get_integer(pkg_elem + 4, &lpi_state->res_cnt_freq))
 			lpi_state->res_cnt_freq = 1;
-- 
2.33.0


