Return-Path: <linux-acpi+bounces-17402-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B66BA8AEF
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 11:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C8407B8982
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 09:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214072D2499;
	Mon, 29 Sep 2025 09:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="LcL2lYzk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7992D0292;
	Mon, 29 Sep 2025 09:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759138695; cv=none; b=t9mjbVQGYw4V1MPvJQa0FRtP0RbIOcilRpOuJILHbYEsCWzLIY8fm89hgbnbHMpWXurdp1G/ZCFxQsKPfWVThStv1QpAscc5Ak210QjYW+AFFcAwxkAd7qssbX3wbKBVRXLt84tIApUgWhPGIGbK0AJRFHYOsTz8TgCb6NqVpys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759138695; c=relaxed/simple;
	bh=ET17Ecn8UKDKY1b9r5nv3OFGUUXEXIalhxeaPZZ8X+Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZQWPZyfADADee4xzSjH73mbvAeukJ88yyp4K6JGOhL0xPAp64GjGSgsLmvwwJYncUmhZNpMDiABhOBQZCQlrdGnETEN8+3YewYq4Xj3RVHI8NZj5Zsjf/Fms42zvtkjlDd7Bq8oNNgaS535qslLC3rPyYSBA3d29H+shgq81EJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=LcL2lYzk; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from canpmsgout06.his.huawei.com (unknown [172.19.92.157])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cZx136LlcztTny;
	Mon, 29 Sep 2025 17:37:11 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=zZ7qeN7/pBD4pnUfMBd3WN5wX1rOHmBzXPGuoo+KwT0=;
	b=LcL2lYzk6tEp5cqqBTm3URVP3KF+0IKP7qsC5X91o7fQ6nbyAxJwoKX70rPJDdk2JZfxGTIyz
	KCgudePbYnOBx86SHQf4FxDaRo8QPY6FLkzhLUO7RrMoS2MnAr/oHE/HRS15SOSUzpI+MLAit2I
	fBtZ9TQAq+2s3KfRzz7JsO0=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4cZx1j5LWNzRhQy;
	Mon, 29 Sep 2025 17:37:45 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 7061E140132;
	Mon, 29 Sep 2025 17:37:56 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 29 Sep 2025 17:37:56 +0800
Received: from localhost.localdomain (10.50.165.33) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 29 Sep 2025 17:37:55 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Sudeep.Holla@arm.com>, <linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<lihuisong@huawei.com>
Subject: [PATCH v1 2/9] ACPI: processor: idle: Return failure if entry method is not buffer or integer type
Date: Mon, 29 Sep 2025 17:37:47 +0800
Message-ID: <20250929093754.3998136-3-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250929093754.3998136-1-lihuisong@huawei.com>
References: <20250929093754.3998136-1-lihuisong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemn100009.china.huawei.com (7.202.194.112)

According to ACPI spec, entry method in LPI sub-package must be buffer
or integer. However, acpi_processor_evaluate_lpi() regeards it as success
and treat it as an effective LPI state. This is unreasonable and needs to
return failure to prevent other problems from occurring.

Fixes: a36a7fecfe60 ("ACPI / processor_idle: Add support for Low Power Idle(LPI) states")
Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/acpi/processor_idle.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 5acf12a0441f..681587f2614b 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -958,7 +958,9 @@ static int acpi_processor_evaluate_lpi(acpi_handle handle,
 			lpi_state->entry_method = ACPI_CSTATE_INTEGER;
 			lpi_state->address = obj->integer.value;
 		} else {
-			continue;
+			pr_err("Entry method in LPI sub-package must be buffer or integer.\n");
+			ret = -EINVAL;
+			goto end;
 		}
 
 		/* elements[7,8] skipped for now i.e. Residency/Usage counter*/
-- 
2.33.0


