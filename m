Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C91C0267791
	for <lists+linux-acpi@lfdr.de>; Sat, 12 Sep 2020 05:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725791AbgILDjj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 11 Sep 2020 23:39:39 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33898 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725773AbgILDjj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 11 Sep 2020 23:39:39 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 836985CA38AA738A9A5A;
        Sat, 12 Sep 2020 11:39:37 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Sat, 12 Sep 2020
 11:39:31 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>, <james.morse@arm.com>,
        <tony.luck@intel.com>, <bp@alien8.de>,
        <wangkefeng.wang@huawei.com>, <linux-acpi@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] ACPI, APEI: make apei_resources_all static
Date:   Sat, 12 Sep 2020 11:38:51 +0800
Message-ID: <20200912033851.143311-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This eliminates the following sparse warning:

drivers/acpi/apei/apei-base.c:290:23: warning: symbol
'apei_resources_all' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/acpi/apei/apei-base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
index e358d0046494..d3fbac58d91a 100644
--- a/drivers/acpi/apei/apei-base.c
+++ b/drivers/acpi/apei/apei-base.c
@@ -287,7 +287,7 @@ struct apei_res {
 };
 
 /* Collect all resources requested, to avoid conflict */
-struct apei_resources apei_resources_all = {
+static struct apei_resources apei_resources_all = {
 	.iomem = LIST_HEAD_INIT(apei_resources_all.iomem),
 	.ioport = LIST_HEAD_INIT(apei_resources_all.ioport),
 };
-- 
2.25.4

