Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D146E3AEC42
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Jun 2021 17:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhFUP1E (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 21 Jun 2021 11:27:04 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:33978 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229789AbhFUP06 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 21 Jun 2021 11:26:58 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15LFHVji030700;
        Mon, 21 Jun 2021 10:24:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=R5FkVCq+KE7byMZx53BaO/xYpXWQwjNkt9WJFd7GKUw=;
 b=CwX+8u4XG63XnA6DgvP2R2YUGC/w3zJKqYKL6h/pg76KWfbs7gci4Kbh6xUO6WeXal/X
 jsLxGMC7SqxO5RjPoHJrDb7htZo6qruGtS+XkB0EFTA+2FEo1RxhykrwF/M01WMW4vTV
 6wBKtnPbAJ6JZoVFPbv6UBxLtMz3rNnZyryM9ZXLrP6jwnQZUMerwGilZJ8mNPvSooZA
 pIsoZQp/B1StyViSomX9kbJjwbfwt8oVM1d4xPIis0YOojGsgfpUL+yTqWHdT6erg0Wk
 b4eG4OBdrMj3QZ7RyISMXK2Y8lLc59ThQuAKutrzZb++Dp2y0/zH66Giz4nBGOcZV+31 xw== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 39aqy20fp8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 21 Jun 2021 10:24:37 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 21 Jun
 2021 16:24:35 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Mon, 21 Jun 2021 16:24:35 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.172])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 8BDC52B2;
        Mon, 21 Jun 2021 15:24:35 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] ACPI: tables: Add custom DSDT file as makefile prerequisite
Date:   Mon, 21 Jun 2021 16:24:33 +0100
Message-ID: <20210621152433.29716-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: etH7C2KjIMKmlE83Lz-VQExTp6DeUb0B
X-Proofpoint-ORIG-GUID: etH7C2KjIMKmlE83Lz-VQExTp6DeUb0B
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 clxscore=1011 phishscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106210091
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

A custom DSDT file is mostly used during development or debugging,
and in that case it is quite likely to want to rebuild the kernel
after changing ONLY the content of the DSDT.

This patch adds the custom DSDT as a prerequisite to tables.o
to ensure a rebuild if the DSDT file is updated. Make will merge
the prerequisites from multiple rules for the same target.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/acpi/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index efb0d1f64019..ceb1aed4b1fc 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -8,6 +8,11 @@ ccflags-$(CONFIG_ACPI_DEBUG)	+= -DACPI_DEBUG_OUTPUT
 #
 # ACPI Boot-Time Table Parsing
 #
+ifeq ($(CONFIG_ACPI_CUSTOM_DSDT),y)
+tables.o: $(src)/../../include/$(subst $\",,$(CONFIG_ACPI_CUSTOM_DSDT_FILE)) ;
+
+endif
+
 obj-$(CONFIG_ACPI)		+= tables.o
 obj-$(CONFIG_X86)		+= blacklist.o
 
-- 
2.20.1

