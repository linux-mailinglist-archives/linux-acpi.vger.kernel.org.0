Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A201F258874
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Sep 2020 08:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgIAGr5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Sep 2020 02:47:57 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10743 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726044AbgIAGr5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 1 Sep 2020 02:47:57 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2BBC8262C5DAB748EDCA;
        Tue,  1 Sep 2020 14:47:52 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Tue, 1 Sep 2020
 14:47:44 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>, <ulf.hansson@linaro.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ACPI: Remove unused inline functions
Date:   Tue, 1 Sep 2020 14:47:16 +0800
Message-ID: <20200901064716.2444-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

There is no callers in tree.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 include/linux/acpi.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 17e80e182802..dd9b961628eb 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -979,8 +979,6 @@ int acpi_subsys_runtime_suspend(struct device *dev);
 int acpi_subsys_runtime_resume(struct device *dev);
 int acpi_dev_pm_attach(struct device *dev, bool power_on);
 #else
-static inline int acpi_dev_runtime_suspend(struct device *dev) { return 0; }
-static inline int acpi_dev_runtime_resume(struct device *dev) { return 0; }
 static inline int acpi_subsys_runtime_suspend(struct device *dev) { return 0; }
 static inline int acpi_subsys_runtime_resume(struct device *dev) { return 0; }
 static inline int acpi_dev_pm_attach(struct device *dev, bool power_on)
@@ -1218,13 +1216,6 @@ static inline int acpi_node_prop_get(const struct fwnode_handle *fwnode,
 	return -ENXIO;
 }
 
-static inline int acpi_dev_prop_get(const struct acpi_device *adev,
-				    const char *propname,
-				    void **valptr)
-{
-	return -ENXIO;
-}
-
 static inline int acpi_dev_prop_read_single(const struct acpi_device *adev,
 					    const char *propname,
 					    enum dev_prop_type proptype,
-- 
2.17.1


