Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B310389B77
	for <lists+linux-acpi@lfdr.de>; Thu, 20 May 2021 04:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbhETCkm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 19 May 2021 22:40:42 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4689 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhETCkl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 19 May 2021 22:40:41 -0400
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Flv4x2K4nz16QH1;
        Thu, 20 May 2021 10:36:33 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (7.185.36.114) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 10:39:19 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 10:39:19 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
To:     <linux-acpi@vger.kernel.org>
CC:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH] ACPI: Remove redundant assignment of error
Date:   Thu, 20 May 2021 10:39:08 +0800
Message-ID: <1621478348-33757-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

'error' will be initialized and cleanup the redundant initialization.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 drivers/acpi/event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/event.c b/drivers/acpi/event.c
index 92e59f45329b..bfb16cf8f807 100644
--- a/drivers/acpi/event.c
+++ b/drivers/acpi/event.c
@@ -165,7 +165,7 @@ static int acpi_event_genetlink_init(void)
 
 static int __init acpi_event_init(void)
 {
-	int error = 0;
+	int error;
 
 	if (acpi_disabled)
 		return 0;
-- 
2.7.4

