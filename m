Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7F92B7703
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Nov 2020 08:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725772AbgKRHgl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 18 Nov 2020 02:36:41 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7645 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgKRHgl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Nov 2020 02:36:41 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CbZP56gTbz15MsB;
        Wed, 18 Nov 2020 15:36:09 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.176.144) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Wed, 18 Nov 2020 15:36:13 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-acpi <linux-acpi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] ACPI/nfit: avoid accessing uninitialized memory in acpi_nfit_ctl()
Date:   Wed, 18 Nov 2020 15:35:17 +0800
Message-ID: <20201118073517.1884-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.176.144]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The ACPI_ALLOCATE() does not zero the "buf", so when the condition
"integer->type != ACPI_TYPE_INTEGER" in int_to_buf() is met, the result
is unpredictable in acpi_nfit_ctl().

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/acpi/nfit/core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 442608220b5c..cda7b6c52504 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -282,18 +282,19 @@ static union acpi_object *pkg_to_buf(union acpi_object *pkg)
 
 static union acpi_object *int_to_buf(union acpi_object *integer)
 {
-	union acpi_object *buf = ACPI_ALLOCATE(sizeof(*buf) + 4);
+	union acpi_object *buf = NULL;
 	void *dst = NULL;
 
-	if (!buf)
-		goto err;
-
 	if (integer->type != ACPI_TYPE_INTEGER) {
 		WARN_ONCE(1, "BIOS bug, unexpected element type: %d\n",
 				integer->type);
 		goto err;
 	}
 
+	buf = ACPI_ALLOCATE(sizeof(*buf) + 4);
+	if (!buf)
+		goto err;
+
 	dst = buf + 1;
 	buf->type = ACPI_TYPE_BUFFER;
 	buf->buffer.length = 4;
-- 
2.26.0.106.g9fadedd


