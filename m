Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5859460EB6
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Nov 2021 07:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242164AbhK2GYN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 29 Nov 2021 01:24:13 -0500
Received: from esa10.hc1455-7.c3s2.iphmx.com ([139.138.36.225]:43664 "EHLO
        esa10.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232611AbhK2GWN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 29 Nov 2021 01:22:13 -0500
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Nov 2021 01:22:12 EST
IronPort-SDR: 1oyaJcgJG5TQlY10r66p8wbXXlD77qtxXY5inXRm3iXXY/3yTkchimuSDX2gmF9Iab8AfslLXT
 JwiJN1KxoKV6+Xo7XkJ9x3j5E4M5XCw/gzQWjUIY5UZS25YRKwKRjaP6HVd9H7OKtg6wpqTFb0
 LzTxnHGFpL/biNHhqAmXBWyryLrUtXTEEFvf4W1qutGuLk96GXfNuTyp3DojmX5/xM9uZkoJFg
 V8Z0EV36gZbi9imiVV+l84fd3O+UF8UFvWYUWI5Js1ucKeAhWbk0M554LPK9XP9WyJNsfAwfKc
 epBvq8oGIl5e5T5NOgF3YlW4
X-IronPort-AV: E=McAfee;i="6200,9189,10182"; a="42117594"
X-IronPort-AV: E=Sophos;i="5.87,272,1631545200"; 
   d="scan'208";a="42117594"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP; 29 Nov 2021 15:11:44 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 9E7981F4F48;
        Mon, 29 Nov 2021 15:11:43 +0900 (JST)
Received: from oym-om3.fujitsu.com (oym-om3.o.css.fujitsu.com [10.85.58.163])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id BF86FE6475;
        Mon, 29 Nov 2021 15:11:42 +0900 (JST)
Received: from localhost.localdomain (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by oym-om3.fujitsu.com (Postfix) with ESMTP id 7482B40110161;
        Mon, 29 Nov 2021 15:11:41 +0900 (JST)
From:   Shuuichirou Ishii <ishii.shuuichir@fujitsu.com>
To:     rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com,
        guohanjun@huawei.com, sudeep.holla@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, ishii.shuuichir@fujitsu.com
Subject: [PATCH v3] acpi/tables: Add AEST in ACPI Table Definition
Date:   Mon, 29 Nov 2021 15:10:44 +0900
Message-Id: <20211129061044.1779456-1-ishii.shuuichir@fujitsu.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

When We added AEST using the Upgrading ACPI tables via initrd function,
the kernel could not recognize the AEST, so added the AEST table to
the list to enable the table upgrade function.

Signed-off-by: Shuuichirou Ishii <ishii.shuuichir@fujitsu.com>
---
v3 : Changed the location of the change log so that it does not
     disappear when the patch is applied.

v2 : The reason for committing in the commit log was not clear,
     so it was pointed out and corrected.

 drivers/acpi/tables.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 71419eb16e09..2699bf7e21ab 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -500,7 +500,7 @@ static const char table_sigs[][ACPI_NAMESEG_SIZE] __initconst = {
 	ACPI_SIG_WDDT, ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT,
 	ACPI_SIG_PSDT, ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT,
 	ACPI_SIG_IORT, ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPTT,
-	ACPI_SIG_NHLT };
+	ACPI_SIG_NHLT, ACPI_SIG_AEST };
 
 #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
 
-- 
2.27.0

