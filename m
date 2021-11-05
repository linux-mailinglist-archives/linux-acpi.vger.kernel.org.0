Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 411D3445F1F
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Nov 2021 05:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbhKEE1u (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Nov 2021 00:27:50 -0400
Received: from esa1.hc1455-7.c3s2.iphmx.com ([207.54.90.47]:65466 "EHLO
        esa1.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229884AbhKEE1s (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Nov 2021 00:27:48 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Nov 2021 00:27:48 EDT
IronPort-SDR: Zjw/T7eEx9mkZNg+D/oYUMwXLzL14Xuf9mCt3mf7dZHu2BBVPYnkvrbPYBrGHFOTANilIGSsst
 7qOIa3KFE4qAm1IYdCBg+S1KWfkHvER03JZW+ZuaxkJzXfj/JZguz3SORK1iA4+Iebe0EdQfqk
 +1A0U4IbjH62HeiuEFL9EKVGo4VhcTspIVyexXqfjaz3gnFrK7ECbOs9gQW1XWDP4uvRHIQnI+
 GbR+EYvGDKb1t6QmicAOu9vKJ5IlG2zz4eJFa+1WGwN0Qo2iP/IMlZjL+HDAW0vK8Pa5oMEwPl
 PVlMg6HbbIVR+oJa0amyPwWr
X-IronPort-AV: E=McAfee;i="6200,9189,10158"; a="51529912"
X-IronPort-AV: E=Sophos;i="5.87,210,1631545200"; 
   d="scan'208";a="51529912"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP; 05 Nov 2021 13:17:58 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
        by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 8617B1F4646;
        Fri,  5 Nov 2021 13:17:57 +0900 (JST)
Received: from yto-om4.fujitsu.com (yto-om4.o.css.fujitsu.com [10.128.89.165])
        by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id B7D6C4431A8;
        Fri,  5 Nov 2021 13:17:56 +0900 (JST)
Received: from localhost.localdomain (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om4.fujitsu.com (Postfix) with ESMTP id 7D30D400C3B25;
        Fri,  5 Nov 2021 13:17:56 +0900 (JST)
From:   Shuuichirou Ishii <ishii.shuuichir@fujitsu.com>
To:     rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, linux-arm-kernel@lists.infradead.org,
        ishii.shuuichir@fujitsu.com
Subject: [PATCH] acpi/tables: Add AEST in ACPI Table Definition
Date:   Fri,  5 Nov 2021 13:16:35 +0900
Message-Id: <20211105041635.1481738-1-ishii.shuuichir@fujitsu.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

When We added AEST using the Upgrading ACPI tables via initrd function,
the kernel could not recognize the AEST, so We added AEST the ACPI table
definition.

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

