Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 738CA45D63D
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Nov 2021 09:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346432AbhKYIiz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Nov 2021 03:38:55 -0500
Received: from esa12.hc1455-7.c3s2.iphmx.com ([139.138.37.100]:53261 "EHLO
        esa12.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347233AbhKYIgz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 25 Nov 2021 03:36:55 -0500
IronPort-SDR: XUDKK/TWQwdQ9f0wktc9lgsBdGkGjQQaUQ0uXVJwDtVWJyM5DdujUw8mzTZ3Tf8C6sjt13KZjP
 Ed+AXIG9UKYU3FMeb+z0KBk12kqrkPkhenkUMcUHK1DIjPi5zeg3q2jQXviKUWPWTJGDOUr1xk
 Y33NMXq65z+EIU4LmJknDm2B7lBS2XjfBtGldpkro8BhOvWra5WKJbvS+h3Dl7EeFqD4cN6IDP
 /udg+wMtTL3PWIoHOUEarikHP3/dkv5xh9/BGQESJk4n0nxdpVp8uVXNxvD/guEJAUe7c5sutK
 HBQkwwHWjZsrlxOpnnCSTmql
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="33669373"
X-IronPort-AV: E=Sophos;i="5.87,262,1631545200"; 
   d="scan'208";a="33669373"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP; 25 Nov 2021 17:33:41 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
        by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id DF7376CC6A;
        Thu, 25 Nov 2021 17:33:40 +0900 (JST)
Received: from yto-om1.fujitsu.com (yto-om1.o.css.fujitsu.com [10.128.89.162])
        by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 1A105E0F89;
        Thu, 25 Nov 2021 17:33:40 +0900 (JST)
Received: from localhost.localdomain (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om1.fujitsu.com (Postfix) with ESMTP id CB3BE404AFF02;
        Thu, 25 Nov 2021 17:33:39 +0900 (JST)
From:   Shuuichirou Ishii <ishii.shuuichir@fujitsu.com>
To:     rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com,
        guohanjun@huawei.com, sudeep.holla@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, ishii.shuuichir@fujitsu.com
Subject: [PATCH v2] acpi/tables: Add AEST in ACPI Table Definition
Date:   Thu, 25 Nov 2021 17:32:40 +0900
Message-Id: <20211125083240.123131-1-ishii.shuuichir@fujitsu.com>
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

Change log:
v2 : The reason for committing in the commit log was not clear,
     so it was pointed out and corrected.

Signed-off-by: Shuuichirou Ishii <ishii.shuuichir@fujitsu.com>
---
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

