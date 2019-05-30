Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD4C830129
	for <lists+linux-acpi@lfdr.de>; Thu, 30 May 2019 19:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfE3RpW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 30 May 2019 13:45:22 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:54164 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725961AbfE3RpW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 30 May 2019 13:45:22 -0400
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UHeuTG019753;
        Thu, 30 May 2019 17:45:19 GMT
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0b-002e3701.pphosted.com with ESMTP id 2stjuw1jxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 May 2019 17:45:19 +0000
Received: from sarge.linuxathome.me (unknown [16.116.161.7])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id 21D4263;
        Thu, 30 May 2019 17:45:15 +0000 (UTC)
From:   Hedi Berriche <hedi.berriche@hpe.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hedi Berriche <hedi.berriche@hpe.com>, Russ Anderson <rja@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Frank Ramsay <frank.ramsay@hpe.com>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [Patch] ACPICA: Increase AE_OWNER_ID_LIMIT to 2047
Date:   Thu, 30 May 2019 18:45:04 +0100
Message-Id: <20190530174504.17172-1-hedi.berriche@hpe.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-30_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=910 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905300124
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

32 sockets systems with 192 NVDIMMs run into the ACPI_OWNER_ID_MAX limit
which is currently set to 255, and nfit kernel module initialisation fails
with the following representative error messages:

ACPI Error: Could not allocate new OwnerId (255 max), AE_OWNER_ID_LIMIT (20170303/utownerid-149
ACPI Error: Method parse/execution failed [\_SB.NVDR.N031.PCDR] (Node ffff9e2fffd8e280), AE_OWNER_ID_LIMIT (20170303/psparse-543)
ACPI Error: Method parse/execution failed [\_SB.NVDR.N031.CR05] (Node ffff9547ffd91bb8), AE_OWNER_ID_LIMIT (20170303/psparse-543)
ACPI Error: Method parse/execution failed [\_SB.NVDR.N031.CRLD] (Node ffff8e99ffd92550), AE_OWNER_ID_LIMIT (20170303/psparse-543)
ACPI Error: Method parse/execution failed [\_SB.NVDR.N031._DSM] (Node ffffadc5ffd90e88), AE_OWNER_ID_LIMIT (20170303/psparse-543)
ACPI: \_SB_.NVDR.N031: failed to evaluate _DSM (0x1b)

Further debugging shows that, on such a system, we end up using 1020 owner IDs,
hence I'm suggesting that we bump ACPI_OWNER_ID_MAX up to 2047.

Signed-off-by: Hedi Berriche <hedi.berriche@hpe.com>
Cc: Russ Anderson <rja@hpe.com>
Cc: Mike Travis <mike.travis@hpe.com>
Cc: Frank Ramsay <frank.ramsay@hpe.com>
Cc: Robert Moore <robert.moore@intel.com>
Cc: Erik Schmauss <erik.schmauss@intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/utownerid.c | 6 +++---
 include/acpi/acconfig.h         | 4 ++--
 include/acpi/actypes.h          | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpica/utownerid.c b/drivers/acpi/acpica/utownerid.c
index 5eb8b76ce9d8..c015a2c147d9 100644
--- a/drivers/acpi/acpica/utownerid.c
+++ b/drivers/acpi/acpica/utownerid.c
@@ -88,7 +88,7 @@ acpi_status acpi_ut_allocate_owner_id(acpi_owner_id *owner_id)
 				/*
 				 * Construct encoded ID from the index and bit position
 				 *
-				 * Note: Last [j].k (bit 255) is never used and is marked
+				 * Note: Last [j].k (bit 2047) is never used and is marked
 				 * permanently allocated (prevents +1 overflow)
 				 */
 				*owner_id =
@@ -116,7 +116,7 @@ acpi_status acpi_ut_allocate_owner_id(acpi_owner_id *owner_id)
 	 */
 	status = AE_OWNER_ID_LIMIT;
 	ACPI_ERROR((AE_INFO,
-		    "Could not allocate new OwnerId (255 max), AE_OWNER_ID_LIMIT"));
+		    "Could not allocate new OwnerId (2047 max), AE_OWNER_ID_LIMIT"));
 
 exit:
 	(void)acpi_ut_release_mutex(ACPI_MTX_CACHES);
@@ -133,7 +133,7 @@ acpi_status acpi_ut_allocate_owner_id(acpi_owner_id *owner_id)
  *              control method or unloading a table. Either way, we would
  *              ignore any error anyway.
  *
- * DESCRIPTION: Release a table or method owner ID. Valid IDs are 1 - 255
+ * DESCRIPTION: Release a table or method owner ID. Valid IDs are 1 - 2047
  *
  ******************************************************************************/
 
diff --git a/include/acpi/acconfig.h b/include/acpi/acconfig.h
index 16a83959e616..536fe9a81cb7 100644
--- a/include/acpi/acconfig.h
+++ b/include/acpi/acconfig.h
@@ -95,9 +95,9 @@
 
 #define ACPI_DEFAULT_PAGE_SIZE          4096	/* Must be power of 2 */
 
-/* owner_id tracking. 8 entries allows for 255 owner_ids */
+/* owner_id tracking. 64 entries allow for 2047 owner_ids */
 
-#define ACPI_NUM_OWNERID_MASKS          8
+#define ACPI_NUM_OWNERID_MASKS          64
 
 /* Size of the root table array is increased by this increment */
 
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index ad6892a24015..f32a4d49ea13 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -442,8 +442,8 @@ typedef void *acpi_handle;	/* Actually a ptr to a NS Node */
 
 /* Owner IDs are used to track namespace nodes for selective deletion */
 
-typedef u8 acpi_owner_id;
-#define ACPI_OWNER_ID_MAX               0xFF
+typedef u16 acpi_owner_id;
+#define ACPI_OWNER_ID_MAX               0x7FF
 
 #define ACPI_INTEGER_BIT_SIZE           64
 #define ACPI_MAX_DECIMAL_DIGITS         20	/* 2^64 = 18,446,744,073,709,551,616 */
-- 
2.20.1

