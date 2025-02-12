Return-Path: <linux-acpi+bounces-11081-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 811E4A31F35
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 07:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29E143A1F8F
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 06:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F1E1FC11E;
	Wed, 12 Feb 2025 06:41:48 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECCE1EEA32;
	Wed, 12 Feb 2025 06:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739342508; cv=none; b=q1w1PHvBgJaVnvUPt5FTZ8V93skoAaTJUUjwjgXeCY99xT9uBLgOZdtfiI/TB9Ofe7A7fkOc9FolUUA3wGjX8PnIPUbOAQXHDhX7ZsxJsdT49JI8G3DW5am2KnDVeR7gis3TbkP8BILuiUYiSNEqrPgFwaD5ZjAs1eNxZ0a0mmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739342508; c=relaxed/simple;
	bh=6YO1Gy3y+qoZz8zIN+vjvk3mQBBe30aQCHwAFSrGcFI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cu5CyvaZCl+95M4JkgSE0vJqFJibDpXR0NjDqb8VQtiPbSch9REEyVLeFb2PMXPdkD81x2+89rSVZ9TzV45x5WIjvCF4295Jj8MopWu4wnpoW72Bl2fVIwpIW+jARUkpFa9jzJZyfFPXV5/VcU+6l2jMgbP1tDJDldLIEqOEshs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Yt7tw64kzz22mtb;
	Wed, 12 Feb 2025 14:38:48 +0800 (CST)
Received: from dggpemf200009.china.huawei.com (unknown [7.185.36.246])
	by mail.maildlp.com (Postfix) with ESMTPS id 7DDC0140138;
	Wed, 12 Feb 2025 14:41:41 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200009.china.huawei.com (7.185.36.246) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 12 Feb 2025 14:41:41 +0800
From: Xiaofei Tan <tanxiaofei@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<jonathan.cameron@huawei.com>, <mchehab+huawei@kernel.org>,
	<roberto.sassu@huawei.com>, <shiju.jose@huawei.com>,
	<prime.zeng@hisilicon.com>, <linuxarm@huawei.com>, Xiaofei Tan
	<tanxiaofei@huawei.com>
Subject: [PATCH v4] ACPI: HED: Always initialize before evged
Date: Wed, 12 Feb 2025 14:34:08 +0800
Message-ID: <20250212063408.927666-1-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 -v4: Fix register HED device twice issue found by Nathan, and change
patch name following Rafael's advice.
---
 drivers/acpi/Kconfig | 2 +-
 drivers/acpi/hed.c   | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

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
index 7652515a6be1..3499f86c411e 100644
--- a/drivers/acpi/hed.c
+++ b/drivers/acpi/hed.c
@@ -80,7 +80,12 @@ static struct acpi_driver acpi_hed_driver = {
 		.remove = acpi_hed_remove,
 	},
 };
-module_acpi_driver(acpi_hed_driver);
+
+static int __init acpi_hed_driver_init(void)
+{
+	return acpi_bus_register_driver(&acpi_hed_driver);
+}
+subsys_initcall(acpi_hed_driver_init);
 
 MODULE_AUTHOR("Huang Ying");
 MODULE_DESCRIPTION("ACPI Hardware Error Device Driver");
-- 
2.33.0


