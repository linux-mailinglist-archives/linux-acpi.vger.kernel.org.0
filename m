Return-Path: <linux-acpi+bounces-10684-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 055C9A123E4
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 13:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA2F31888664
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 12:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA312063FF;
	Wed, 15 Jan 2025 12:38:59 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014F18634C;
	Wed, 15 Jan 2025 12:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736944739; cv=none; b=DXyd/7H7km8yrvCKBp1EJru3Dhf8qzcumq8Y4OUKFjQcwo0QWaccrDNLAQZmbDPE5NJu5XT3/fRL0yzL7dFgdQWH/ArDK0m+uL98Fh8sAry+0jl/BXPvzbCU6brYXmkP1tMU/MJlzQTuL9la39Ca3hHmJqtmUovIy3wAbTIBWD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736944739; c=relaxed/simple;
	bh=XNicPXcEzTOxbi1YdjGtSwSrzOT4DUTBYeQ7hMazxtY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eKK4x1xKSOnGWZN8O05Dnkioo+PwKLiDOxCBXOMowSeV9Y2jMLvvvxREzQJ6dyzOvcfqrL7ZuzjulJw9Md0ZfVzLA3WoZHy+MFM8TrBZS5VTeHsda1T5N2FppPL5sOP6QMfdwxcEgZE5/z16lzVuOWKNSaDgwG/YKKIpIWMLA/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4YY57j0rNzzbk9C;
	Wed, 15 Jan 2025 20:35:45 +0800 (CST)
Received: from dggpemf200009.china.huawei.com (unknown [7.185.36.246])
	by mail.maildlp.com (Postfix) with ESMTPS id 7578A1800D1;
	Wed, 15 Jan 2025 20:38:53 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200009.china.huawei.com (7.185.36.246) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 15 Jan 2025 20:38:53 +0800
From: Xiaofei Tan <tanxiaofei@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<jonathan.cameron@huawei.com>, <mchehab+huawei@kernel.org>,
	<roberto.sassu@huawei.com>, <shiju.jose@huawei.com>,
	<prime.zeng@hisilicon.com>, <linuxarm@huawei.com>, Xiaofei Tan
	<tanxiaofei@huawei.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2] acpi: Fix HED module initialization order when it is built-in
Date: Wed, 15 Jan 2025 20:31:49 +0800
Message-ID: <20250115123149.3324733-1-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf200009.china.huawei.com (7.185.36.246)

When the module HED is built-in, the init order is determined by
Makefile order. That order violates expectations. Because the module
HED init is behind evged. RAS records can't be handled in the
special time window that evged has initialized while HED not.
If the number of such RAS records is more than the APEI HEST error
source number, the HEST resources could be occupied all, and then
could affect subsequent RAS error reporting.

If build HED as a module, the problem remains. To solve this problem
completely, change the ACPI_HED from tristate to bool.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 drivers/acpi/Kconfig  | 2 +-
 drivers/acpi/Makefile | 8 +++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

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
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 40208a0f5dfb..b50d1baeb71f 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -15,6 +15,13 @@ endif
 
 obj-$(CONFIG_ACPI)		+= tables.o
 
+#
+# The hed.o needs to be in front of evged.o to avoid the problem that
+# RAS errors cannot be handled in the special time window of startup
+# phase that evged has initialized while hed not.
+#
+obj-$(CONFIG_ACPI_HED)		+= hed.o
+
 #
 # ACPI Core Subsystem (Interpreter)
 #
@@ -95,7 +102,6 @@ obj-$(CONFIG_ACPI_HOTPLUG_IOAPIC) += ioapic.o
 obj-$(CONFIG_ACPI_BATTERY)	+= battery.o
 obj-$(CONFIG_ACPI_SBS)		+= sbshc.o
 obj-$(CONFIG_ACPI_SBS)		+= sbs.o
-obj-$(CONFIG_ACPI_HED)		+= hed.o
 obj-$(CONFIG_ACPI_EC_DEBUGFS)	+= ec_sys.o
 obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
 obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc_acpi.o
-- 
2.33.0


