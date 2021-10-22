Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A95436F51
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Oct 2021 03:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbhJVBVL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Oct 2021 21:21:11 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:58876 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230288AbhJVBVJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 21 Oct 2021 21:21:09 -0400
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19LGFJoi006701;
        Fri, 22 Oct 2021 01:18:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=HUDmddCHXUhWfT8oQXFDl3mufSPdOPwB7Dko/rlywck=;
 b=ecDp7w5zJNGyMVwiXobPXG9Lt23JmrG09Zow/aRCI3ySYZCfQfmEmuP2G07Nj/uSC1qa
 PDk0bzzj6M0N/tyOggJdMMj+ElF3NbB4krnbw1qtw6OZUtte7wLy4m51v5KeeGwhIU7c
 oq1K6EvroJo80LWRItAFk6yghs4o2vG1rKEmhKje6ydQQlJhyyWVBkAVsLdtyRw1MPzq
 6nOtCFUMXETk0WpCE834xRE5TqUI6dXmQLQTzmkYl62JxBP8RWEQD0/fVOIqU6+NG6vS
 zcTQ9mGYnlGnHS8SkWNdszLEriZoc6145FcWl0Mgfm/2zviK9gbqhTV66QvlgMZD3hq2 Ag== 
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        by mx0b-002e3701.pphosted.com with ESMTP id 3bu4j17jgm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Oct 2021 01:18:50 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2354.austin.hpe.com (Postfix) with ESMTP id 6C73EA0;
        Fri, 22 Oct 2021 01:18:50 +0000 (UTC)
Received: from ILEIUN5Z4B.asiapacific.hpqcorp.net (unknown [16.168.144.18])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 3671F36;
        Fri, 22 Oct 2021 01:18:47 +0000 (UTC)
From:   james.liu@hpe.com
To:     rafael@kernel.org, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, James Liu <james.liu@hpe.com>
Subject: [PATCH] ACPI: OSL: Handle the return value of acpi_os_map_generic_address() for a non-register GAS
Date:   Fri, 22 Oct 2021 09:18:33 +0800
Message-Id: <20211022011833.24308-1-james.liu@hpe.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ocqSL72CzfxS9Sk-4t1JkTLHsfNyUrSI
X-Proofpoint-ORIG-GUID: ocqSL72CzfxS9Sk-4t1JkTLHsfNyUrSI
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-21_07,2021-10-21_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=822 clxscore=1011
 impostorscore=0 priorityscore=1501 suspectscore=0 mlxscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110220005
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: James Liu <james.liu@hpe.com>

Modify acpi_os_map_generic_address() to correctly handle a non-register
GAS (i.e., a pointer to a data structure), whose bit width is expected
to be 0 according to Table 5.1 in ACPI spec. 6.4.

For example, the RegisterRegion field in SET_ERROR_TYPE_WITH_ADDRESS is a
non-register GAS, which points to a data structure whose format is defined
in Table 18.30 in ACPI Spec. 6.4.

This fix can prevent EINJ (Error Injection module) from loading failure
when a platform firmware can correctly support the format of Injection
Instruction Entry in an EINJ table.

Signed-off-by: James Liu <james.liu@hpe.com>
---
 drivers/acpi/osl.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 45c5c0e45e33..74de9341fadf 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -456,13 +456,23 @@ void __iomem *acpi_os_map_generic_address(struct acpi_generic_address *gas)
 
 	if (gas->space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY)
 		return NULL;
+	/* Handle a non-register GAS (i.e., a pointer to a data structure),
+	 * whose bit width is expected to be 0 according to ACPI spec. 6.4.
+	 * For example, The RegisterRegion field in SET_ERROR_TYPE_WITH_ADDRESS
+	 * points to a data structure whose format is defined in Table 18.30 in
+	 * ACPI Spec. 6.4
+	 */
+	if (!gas->bit_width) {
+		pr_info("Mapping IOMEM for a non-register GAS.\n");
+		return  acpi_os_map_iomem(addr, sizeof(unsigned long long));
+	}
 
 	/* Handle possible alignment issues */
 	memcpy(&addr, &gas->address, sizeof(addr));
-	if (!addr || !gas->bit_width)
+	if (!addr)
 		return NULL;
-
-	return acpi_os_map_iomem(addr, gas->bit_width / 8);
+	else
+		return acpi_os_map_iomem(addr, gas->bit_width / 8);
 }
 EXPORT_SYMBOL(acpi_os_map_generic_address);
 
-- 
2.25.1

