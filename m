Return-Path: <linux-acpi+bounces-17401-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D74BA8AC2
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 11:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AF26189DFD2
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 09:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925FD2D1913;
	Mon, 29 Sep 2025 09:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="d9N1sQQ3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB33B2D0601;
	Mon, 29 Sep 2025 09:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759138694; cv=none; b=LUlC4K9wTPK4EiUcDemd4ssDEr29PgONptM8zsFz4YSPKzaTiUVeWojkDTKAVUNmn+Oea+1fH4ErrcxCkmisqJuORb7EjWjML8UjS1AmmW+lFHCiImKOzcrIpdrsqzOBW6jCIc5v+N/c415KdIDTpiAC8omzR6AKkcdjRoMaUSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759138694; c=relaxed/simple;
	bh=fYwOECErA6ISUheQ7oOcD0ZnNryYdxvOax7G5YLyxOQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gs/Zag003KmPsynBsSr1EuZUHItk7YlvwF7pZVP05zQeYBu66gcBu0HJlfhhw/Q9epyOhJROijRCZnzXihnJowU9rX5JqIf5MSwzKd7ec0I18UCXodcqM0i0HHQKKelc/ipOeI8mJH93aASXvqLGNDc+YNJWuDeJOuuX7Uss5Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=d9N1sQQ3; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from canpmsgout11.his.huawei.com (unknown [172.19.92.148])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cZx1B1My9ztTtP;
	Mon, 29 Sep 2025 17:37:18 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=XDW8LrIGQZfT9ioHaiAGrXdgQchtR8sw+7/4eE7zjFM=;
	b=d9N1sQQ3gBLqMs9vA2lAnuXJFlQs0qCMo+rkY+cyC1E5ZVhgarHnPANECPSAsOlP0kX/XjJyv
	zT8iU4HhwRX7Od7GyXtsSbEbySzOHLz8vNP1KTOkDCvuOhbAlUUe8AO+M7rlnZ+y+QgsJdNT1IX
	FlSJr6Qrat4i3GsAJ/jS5Fw=
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cZx1q2fhgzKm6W;
	Mon, 29 Sep 2025 17:37:51 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id C0DD6180044;
	Mon, 29 Sep 2025 17:38:01 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 29 Sep 2025 17:37:56 +0800
Received: from localhost.localdomain (10.50.165.33) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 29 Sep 2025 17:37:56 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Sudeep.Holla@arm.com>, <linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<lihuisong@huawei.com>
Subject: [PATCH v1 3/9] ACPI: processor: idle: Return failure when get lpi_state->arch_flags failed
Date: Mon, 29 Sep 2025 17:37:48 +0800
Message-ID: <20250929093754.3998136-4-lihuisong@huawei.com>
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

The architecture specific context loss flags is important for ARM.
And this flag is used to control the execution of different code
flows in acpi_processor_ffh_lpi_enter().

So it is better to return failure when get lpi_state->arch_flags
failed.

Fixes: a36a7fecfe60 ("ACPI / processor_idle: Add support for Low Power Idle(LPI) states")
Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/acpi/processor_idle.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 681587f2614b..f36f9514b6c7 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -984,8 +984,11 @@ static int acpi_processor_evaluate_lpi(acpi_handle handle,
 		if (obj_get_integer(pkg_elem + 2, &lpi_state->flags))
 			lpi_state->flags = 0;
 
-		if (obj_get_integer(pkg_elem + 3, &lpi_state->arch_flags))
-			lpi_state->arch_flags = 0;
+		if (obj_get_integer(pkg_elem + 3, &lpi_state->arch_flags)) {
+			pr_err("Get architecture specific context loss flags failed.\n");
+			ret = -EINVAL;
+			goto end;
+		}
 
 		if (obj_get_integer(pkg_elem + 4, &lpi_state->res_cnt_freq))
 			lpi_state->res_cnt_freq = 1;
-- 
2.33.0


