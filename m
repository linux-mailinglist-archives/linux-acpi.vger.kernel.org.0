Return-Path: <linux-acpi+bounces-10729-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B94A1484E
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Jan 2025 03:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4465B1653F3
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Jan 2025 02:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C5F335BA;
	Fri, 17 Jan 2025 02:37:17 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB4725A620;
	Fri, 17 Jan 2025 02:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737081437; cv=none; b=UOZB8p26sBIjQ9MKq0e3ktvCP55HJtULyH/gDCHb293yZ1ep92qqHXOgIVK0geZJ4f/roIp2730X7hOX1if5SJW/HAbdGp/XivCJq8C9p92b3csfdJ+PwpnOB/tX/VHvMK8iT4neDtiHfjKA9V2x8A44o2+5ebLlxHcYa5b/7mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737081437; c=relaxed/simple;
	bh=4w+BP8O9/bHWDCjjUHehgJ5lO8Ue7r0Wjb/po/jMGAM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IGWRCzdXwJsgE7b3fr9+eTqoWMAgu1WNfl9ReLzz1JPj84pVGgZuqV+wnLsBRX9YCFFM77aKqKaB0EVzEv4C0gpWa91nHR4HjImV+5jr8cZrVsSw1ujU1L6wU+JXSktJuMJnfEfrSVxFe/gDm59KISmH3hraasZhw4sUcb1w2g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4YZ3l35PXVz1xmbG;
	Fri, 17 Jan 2025 10:36:15 +0800 (CST)
Received: from dggpemf200009.china.huawei.com (unknown [7.185.36.246])
	by mail.maildlp.com (Postfix) with ESMTPS id 6F337180043;
	Fri, 17 Jan 2025 10:37:10 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200009.china.huawei.com (7.185.36.246) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 17 Jan 2025 10:37:10 +0800
From: Xiaofei Tan <tanxiaofei@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<jonathan.cameron@huawei.com>, <mchehab+huawei@kernel.org>,
	<roberto.sassu@huawei.com>, <shiju.jose@huawei.com>,
	<prime.zeng@hisilicon.com>, <linuxarm@huawei.com>, Xiaofei Tan
	<tanxiaofei@huawei.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3] acpi: Fix HED module initialization order when it is built-in
Date: Fri, 17 Jan 2025 10:29:57 +0800
Message-ID: <20250117022957.25227-1-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf200009.china.huawei.com (7.185.36.246)

When the module HED is built-in, the module HED init is behind EVGED
as the driver are in the same initcall level, then the order is determined
by Makefile order. That order violates expectations. Because RAS records
can't be handled in the special time window that EVGED has initialized
while HED not.

If the number of such RAS records is more than the APEI HEST error source
number, the HEST resources could be occupied all, and then could affect
subsequent RAS error reporting.

Change the initcall level of HED to subsys_init to fix the issue. If build
HED as a module, the problem remains. To solve this problem completely,
change the ACPI_HED from tristate to bool.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 drivers/acpi/Kconfig | 2 +-
 drivers/acpi/hed.c   | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index d81b55f5068c..7f10aa38269d 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -452,7 +452,7 @@ config ACPI_SBS
 	  the modules will be called sbs and sbshc.
 
 config ACPI_HED
-	tristate "Hardware Error Device"
+	bool "Hardware Error Device"
 	help
 	  This driver supports the Hardware Error Device (PNP0C33),
 	  which is used to report some hardware errors notified via
diff --git a/drivers/acpi/hed.c b/drivers/acpi/hed.c
index 7652515a6be1..677dfcce2990 100644
--- a/drivers/acpi/hed.c
+++ b/drivers/acpi/hed.c
@@ -81,6 +81,7 @@ static struct acpi_driver acpi_hed_driver = {
 	},
 };
 module_acpi_driver(acpi_hed_driver);
+subsys_initcall(acpi_hed_driver_init);
 
 MODULE_AUTHOR("Huang Ying");
 MODULE_DESCRIPTION("ACPI Hardware Error Device Driver");
-- 
2.33.0


