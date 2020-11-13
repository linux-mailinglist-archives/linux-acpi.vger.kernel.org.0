Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6561F2B1443
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Nov 2020 03:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgKMC2z (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Nov 2020 21:28:55 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:7494 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgKMC2z (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Nov 2020 21:28:55 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CXMpj6MgBzhjVg;
        Fri, 13 Nov 2020 10:28:45 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Fri, 13 Nov 2020 10:28:43 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     <linux-acpi@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH] ACPI: debug: Remove the not used function
Date:   Fri, 13 Nov 2020 10:20:29 +0800
Message-ID: <1605234029-26225-1-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The inline function __acpi_aml_opened() is not used anywhere,
remove it.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/acpi_dbg.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/acpi/acpi_dbg.c b/drivers/acpi/acpi_dbg.c
index fb72903..d50261d 100644
--- a/drivers/acpi/acpi_dbg.c
+++ b/drivers/acpi/acpi_dbg.c
@@ -117,13 +117,6 @@ static inline bool __acpi_aml_busy(void)
 	return false;
 }
 
-static inline bool __acpi_aml_opened(void)
-{
-	if (acpi_aml_io.flags & ACPI_AML_OPEN)
-		return true;
-	return false;
-}
-
 static inline bool __acpi_aml_used(void)
 {
 	return acpi_aml_io.usages ? true : false;
-- 
1.7.12.4

