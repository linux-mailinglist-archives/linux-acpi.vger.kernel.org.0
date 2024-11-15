Return-Path: <linux-acpi+bounces-9594-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D17789CD606
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Nov 2024 04:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97322282BF4
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Nov 2024 03:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1C5157A5C;
	Fri, 15 Nov 2024 03:56:59 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382E142ABD;
	Fri, 15 Nov 2024 03:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731643019; cv=none; b=PbvH7kWl/TOmbg2fou4lBCsfLJG2fZ/THc59KJ8Nr4vsBXdaU/EtvpyxyoKQmnnhPf41yEzvqh7o8/Dz/cUFtWq4zqhVcMT2THVqxiqk5acH2DzSvHasZKEbDNBcWEAvfJJxvNYZBq/qSrFqFQEVx3iUESpYxoQQkkDlY4Ham0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731643019; c=relaxed/simple;
	bh=Z48OJDprdK0O2rEHXZ/21zaG1g01OxpBlpO9Tj7hztk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LVfrIL9RtQWlfpAKqU15tRrT+IEqbI0z0279SjOFzYSVmyO1ujY8bZgi66y8UUoQTHaOAXxOK5iqAu1DrTGEOdQp8Qi9w394xUq6i/hfS53fzqs0s29cBwaRLVQgSmuMXTjirPGt6s6SrSScsynZ0reRA4adXItTBd2ysLUbNDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XqNSv1R6dz1jyhs;
	Fri, 15 Nov 2024 11:54:55 +0800 (CST)
Received: from dggpemf200009.china.huawei.com (unknown [7.185.36.246])
	by mail.maildlp.com (Postfix) with ESMTPS id 3C3FD1401F0;
	Fri, 15 Nov 2024 11:56:47 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200009.china.huawei.com (7.185.36.246) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 15 Nov 2024 11:56:46 +0800
From: Xiaofei Tan <tanxiaofei@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<jonathan.cameron@huawei.com>, <M.Chehab@huawei.com>,
	<roberto.sassu@huawei.com>, <shiju.jose@huawei.com>,
	<prime.zeng@hisilicon.com>, <linuxarm@huawei.com>, Xiaofei Tan
	<tanxiaofei@huawei.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH] acpi: Fix hed module initialization order when it is built-in
Date: Fri, 15 Nov 2024 11:50:14 +0800
Message-ID: <20241115035014.1339256-1-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf200009.china.huawei.com (7.185.36.246)

When the module hed is built-in, the init order is determined by
Makefile order. That order violates expectations. Because the module
hed init is behind evged. RAS records can't be handled in the
special time window that evged has initialized while hed not.
If the number of such RAS records is more than the APEI HEST error
source number, the HEST resources could be occupied all, and then
could affect subsequent RAS error reporting.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 drivers/acpi/Makefile | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 61ca4afe83dc..54f60b7922ad 100644
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


