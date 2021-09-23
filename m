Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB8A41663B
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Sep 2021 21:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242993AbhIWT6N (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 23 Sep 2021 15:58:13 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:38042 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242955AbhIWT6N (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 23 Sep 2021 15:58:13 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18NGN5ji011025;
        Thu, 23 Sep 2021 12:56:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=UFp7vHEWChMei+bX+QGXOPu3cQ4g6dhqP22TCpFrvSE=;
 b=jpr0ul68PFkVVUhoAVkwVYlNuKkmZw0iJ8HXHRNwf1MS3xcItFTnzMPXwmvFUY68JYCg
 LkBWkmyH9ZzocGoe6IONvNjcHUQhRfRbFvXVX+sU8mawNK2TBTRKl77dG9MA1R3+/+7I
 S6haIPWmo6wlUTM0Ffk2ZnlDxQvlHRxKZ8LHoeS5zNjt5yKVYtovy83Ik5aU6UcMfODu
 8yliuYPZjv/zmX1jTGNE+ezy8vsLiLz6MYpb9gGLv+rlLBo28/gyf1sk4KayUGZYJ2Er
 hdgf1azhviGstug/8pEcDnAEEfgmi9WF3g2lmxj97fgE81EeBnZR/rwuE7zhFEUOoj3h 7Q== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 3b8ba6cub4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 23 Sep 2021 12:56:20 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 23 Sep
 2021 12:56:18 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 23 Sep 2021 12:56:18 -0700
Received: from localhost.localdomain (unknown [10.110.150.250])
        by maili.marvell.com (Postfix) with ESMTP id BD48F3F707C;
        Thu, 23 Sep 2021 12:56:17 -0700 (PDT)
From:   Vasyl Gomonovych <vgomonovych@marvell.com>
To:     <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>
CC:     Vasyl Gomonovych <vgomonovych@marvell.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        "Robert Richter" <rrichter@amd.com>,
        Tom Saeger <tom.saeger@oracle.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] ACPI: APEI: Check NULL argument in exported symbol
Date:   Thu, 23 Sep 2021 12:56:10 -0700
Message-ID: <20210923195612.25949-1-vgomonovych@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: aZDrHPWlEBaye8PBSFJWu5xH-RlXCIWt
X-Proofpoint-ORIG-GUID: aZDrHPWlEBaye8PBSFJWu5xH-RlXCIWt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-23_06,2021-09-23_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Exported symbol apei_hest_parse is external API
and should check pointer argument

Signed-off-by: Vasyl Gomonovych <vgomonovych@marvell.com>
---
 drivers/acpi/apei/hest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
index 277f00b288d1..9f5c334c7c88 100644
--- a/drivers/acpi/apei/hest.c
+++ b/drivers/acpi/apei/hest.c
@@ -91,7 +91,7 @@ int apei_hest_parse(apei_hest_func_t func, void *data)
 	struct acpi_hest_header *hest_hdr;
 	int i, rc, len;
 
-	if (hest_disable || !hest_tab)
+	if (hest_disable || !hest_tab || !func)
 		return -EINVAL;
 
 	hest_hdr = (struct acpi_hest_header *)(hest_tab + 1);
-- 
2.17.1

