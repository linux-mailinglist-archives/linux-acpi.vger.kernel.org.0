Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A347D44AF02
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Nov 2021 14:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbhKINu2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 9 Nov 2021 08:50:28 -0500
Received: from mail-eopbgr1310092.outbound.protection.outlook.com ([40.107.131.92]:51776
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231169AbhKINu2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 9 Nov 2021 08:50:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YIVYypro3UIQWLu1Qp1YyGdGxs2cPdJYL2xgANUPosDWtIopVbcaJGI7Uf0m8yUmMRsUfOaib2bS8xSYYFxPhdQE8p87hSALsl4QoM9wYIDbHb7mhhFLnb2QANnB6PFOSiMILzlZdGaEVx/bK0iD9ttRE8AynromfNdMAejwpE+sX7MDLK1USltHjhwFZ10EcAlKzt9CnxBDgkzLwWRDzl4KS4+yRLDimfJmYlfZWnlZrfyoE9Cy4G7Yot57i+dIftZmUAqlicvuXOjc/fsSCO3qUcQtPXOF8SG4x4wEJbsEmb2VJAxUb8SD8LmycIfNj5AChd5lFBdfBUlRdBYVyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=orc0653bOsOYXT8ElR0XDulPuCZJ88Da0k2TQGAZksM=;
 b=Pf7RpfYAGQGvWf4IJEa/dl0fbB9y1sQMvyya7wVILrdbadi1qRwU5u5m4BxDJzCexxoGamJQLCjSBMmPAqv7dkrZvz/J9X08o9UAQn7prG6A5IyKMhsvjMhZbjTQST5KYXHHHHJtY7iliuh5kUgcVH3rU6ho4YimgNMiGYTwUU0zUzqlSz17b2jpKWetm3isPF5blwfK334Yn2PteUMLX2Dbk0uIPLxYbqpGWHjv5EJ62GYaY+DBBUdwxHQYCcXGqwitEUX1+H5eAibxUDgWhE1BO6NjXkvzgBHQRZT1asefk+fU/2fgTanTU+WyltmQ4CyG9w1Lg4YrGpM/K72G/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orc0653bOsOYXT8ElR0XDulPuCZJ88Da0k2TQGAZksM=;
 b=YvLokucRi1Zym+h4z/339kO+c1Gko9ept8wo5/D/CwXndqtAl4HGlvb9xPtppMGZRGVvC6suSX0Ic9NiXOaqPS9lTComjrca4Qx0qkzpkWQehlimtyV7JetL81RxtsVC8dJXDDJsnTxHmPrHyoLuSgKBuNjn0oDZQhO+9SsH2V4=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=vivo.com;
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
 by HK0PR06MB2258.apcprd06.prod.outlook.com (2603:1096:203:4c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Tue, 9 Nov
 2021 13:47:39 +0000
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::814a:4668:a3bd:768]) by HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::814a:4668:a3bd:768%7]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 13:47:39 +0000
From:   Guo Zhengkui <guozhengkui@vivo.com>
To:     Robert Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com, Guo Zhengkui <guozhengkui@vivo.com>
Subject: [PATCH] ACPICA: fix swap.cocci warning
Date:   Tue,  9 Nov 2021 21:47:27 +0800
Message-Id: <20211109134728.1710-1-guozhengkui@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0014.apcprd06.prod.outlook.com
 (2603:1096:202:2e::26) To HK2PR06MB3492.apcprd06.prod.outlook.com
 (2603:1096:202:2f::10)
MIME-Version: 1.0
Received: from localhost.localdomain (218.213.202.190) by HK2PR06CA0014.apcprd06.prod.outlook.com (2603:1096:202:2e::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13 via Frontend Transport; Tue, 9 Nov 2021 13:47:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9e0b141-1c7b-4168-c528-08d9a3877e83
X-MS-TrafficTypeDiagnostic: HK0PR06MB2258:
X-Microsoft-Antispam-PRVS: <HK0PR06MB225884339907A2DC01D9B9F3C7929@HK0PR06MB2258.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4wYOJela8sEnQlSnPF14TpgSDS+P1TWtmqpR/VmJPwNRhk7g+3zc9fAiYbh5CWxSoMVSeEYeJoVHrjaz6PivP4tskjSwiz9Ty+wgZijIcSJpVRzudN46oImqWinVD9/mFS0y3q5wYw+fWsmHWCdnlTWs6mtp1uXKyzDKgpmmkfXFe6FFiVkrzxSylyVtbociINJzzq2shn5+1XoLeV55zhVB4G23dKjdspprthvhu9oGf1NS1p8XFkCRS/B+CMs5FH+MxYDRvam4b2LWfm6NozVe4dUpohCvly7S0+gGKOUQicAvpjVsEnAzX3BYvPNgolsQ0oAo4V0oSFmjYl22W1kEnHfxzWE6BjP+yqVG74bNFd5mlLoMaqRooifa9VoArbWmltjJXL3PFSyltE1WdRShspgaDH1a70DV4HwjxyuN08r+e+oWDrURA/HekRAziJITPsKnuVe25wrol6ewe2NvZSd0tt0yt7g/ka3mJXWSOvnVi+Zqtwq4OVnqNGa6jDVyj/89/mopMDjfNzg1OG49Gw2b/jIF1Ws0NfGxkJeWRRc8Ugy1x7JStVgszwNl4zTeZUuyMDVPN6KJeBRfUHd0hJlJXxvebLSWbEfl5K8NqoCKuA4ACYAwN0T49IIHDv1M6MDP4DzrjZCvC6ODYiLgP6NFgpczBc0jKhwflBEkbrF2GUqZoDO54WgXuu6w0pu7IICxItlaYw62o+PUsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR06MB3492.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(4326008)(66946007)(186003)(83380400001)(66476007)(86362001)(38350700002)(107886003)(66556008)(6512007)(26005)(6506007)(110136005)(508600001)(316002)(52116002)(36756003)(2906002)(1076003)(956004)(8936002)(6666004)(2616005)(5660300002)(38100700002)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M10HYvb94XJtOtUVsnwF5Brt2m3NmADwbiuLxWtF7gItCgKwXhFjW2lqgq6U?=
 =?us-ascii?Q?SZ9vPeGDOlfhbTFLa/VsHQQkMZnFsUZW5YJ1HQ5S2VcURHu1mbkAsuFC4jkc?=
 =?us-ascii?Q?NcyZb4qBfWEiG+b4XIS8NwDZV8BJ56aG17rX8hVyivX3G2ScKp9q8jBvB+KN?=
 =?us-ascii?Q?ra3abxkZL2SaMXYWVBvvzQo8hDy6aXq7Myrks7D3rCTqABf88EeZpxew0lLr?=
 =?us-ascii?Q?wvMG9D/AkqDzyeoUclFuOGyajw/UNjrSSiwYrCUzkwMOfMlQfeOIt6xfTliK?=
 =?us-ascii?Q?pQ5yh+NyP61YSoOELIE2TDQQICSCELA9PW2O7a5g0svQzB0fXW5YGPrrWsbC?=
 =?us-ascii?Q?GA/JIudkQcXh5MRKO8BuV5E5UXXeg4kkjkoeD5DajCiiuTAosaLE4NcNKjat?=
 =?us-ascii?Q?/NbcmisLuVFOhAmfA+NMPiTK9SR07CSfzl5084ydUi1BurwveUZtmTKNGyQS?=
 =?us-ascii?Q?lD2pGQR7txichYrlghOWbD/IzaPZk+FYpqOMhSfXx0prqd50K6e6pyqZkPgc?=
 =?us-ascii?Q?T6Gwv617oARyPIDh+9cR1Yrswdj2iM9eMuI3qmRYcjeXdt8TZ8Y2x9owDBph?=
 =?us-ascii?Q?NM9AOXoHwMkOKWwtXSxNbkZPGoQYKkLNrDSIjfX2yzMxscvNltKxww6hnt2I?=
 =?us-ascii?Q?wrezYx1trzJ7mdHt4+HMYJmcuTuRlec3Cr0epjVGeK4Wr3hjV/MEVFFmeB1A?=
 =?us-ascii?Q?Cbi9Hu0QjBOqaW+I0nyO/basGIZq4OirUfE4i4eD0WZ21CwJ6eYMZ5NHUz3y?=
 =?us-ascii?Q?Z8fxEKKn9iE8yD3wJW4AIVdrajIPnfRbaBJ82VCzSjGW7vk679IE7vxD0p7X?=
 =?us-ascii?Q?1MRLYiDepiAKXskY7hAaHJdrrod2QTmJeWhtOnrzUjXyKAykJ+bQEe1I/NTa?=
 =?us-ascii?Q?tvn0X3HD6Svn7pDcc+X8OH542+Zw2XoVrnHhLOvxrEeVBUCPhKoeVXFz3TS8?=
 =?us-ascii?Q?NF6kqwC5iBaB4r+jkt4ZF83toidJeY//00YGqq995xpRddar7R50+PUipTtZ?=
 =?us-ascii?Q?LRLDzdTCnF+faX1cY+nhEpAWjPbYo15RfsJwFQkJgyohBiBXVE/Hvxq5z2PU?=
 =?us-ascii?Q?gJqULBYCN/ZtndjCAVsgPiOsOyKXMEY3C3j0ljxS9M3nNlMVN9Kp0AQV/xRI?=
 =?us-ascii?Q?h2qpsHVa4z9PEJrHdBETVu6O1HsbfrZDGYFbrzYzn6ufcCzJymwjjQGPtCHk?=
 =?us-ascii?Q?vwY0EmJu1fkhmFvGXaCnTRoz+S/9hkE/2DQvKxVnXQr/G7rqgz8fMARO/dIB?=
 =?us-ascii?Q?ux9MvbPCuM4VsBGS0NfhWDGME/bFKGpboNKOdggQLXc7cGb3ACqq3GdVwHTa?=
 =?us-ascii?Q?w9EqbRfVksmmXw2F36YWaqnO4LhiwjUB8LKoja2ILVpOyIC9mVIICoZ5PAvd?=
 =?us-ascii?Q?V/OcOvuEOmNkRCF8tk7LDZbET/sCGFzZ7KWfIDbWu9erzEea34vzOYmqM8L0?=
 =?us-ascii?Q?Py6K6L87Wfp4BGdOEtwZWDAU3iK1WfbzKdnQE6OiKEQxhhhM8kEg3JZ9E0lk?=
 =?us-ascii?Q?/ioM/z2cGsQRTcO37P1Oh2Gp7axBCXX8anrdcctRI5lAVbty8o0CLW1539Er?=
 =?us-ascii?Q?JMC1NnlvyK5znxisIbUuejzRvQtRheG0LGsLZ2UyimuB8d6emYERqzSpn/LB?=
 =?us-ascii?Q?HWVF0qyRk2lkFocUHtFRYXc=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e0b141-1c7b-4168-c528-08d9a3877e83
X-MS-Exchange-CrossTenant-AuthSource: HK2PR06MB3492.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 13:47:38.9632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eQhLdtdfo4eFvkRgGFuE3wryr3A6BamrHbCHVOxbAL6LVNL9iAXUj8/VTTzHV4o4B3nnKydaZ9Qv2sHFku0Gag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2258
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Fix following swap.cocci warning:
./drivers/acpi/acpica/nsrepair2.c:896:33-34: WARNING
opportunity for swap()

Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
---
 drivers/acpi/acpica/nsrepair2.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index 14b71b41e845..02a904ca4caf 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -8,6 +8,7 @@
  *
  *****************************************************************************/
 
+#include <linux/minmax.h>
 #include <acpi/acpi.h>
 #include "accommon.h"
 #include "acnamesp.h"
@@ -875,7 +876,6 @@ acpi_ns_sort_list(union acpi_operand_object **elements,
 {
 	union acpi_operand_object *obj_desc1;
 	union acpi_operand_object *obj_desc2;
-	union acpi_operand_object *temp_obj;
 	u32 i;
 	u32 j;
 
@@ -892,9 +892,7 @@ acpi_ns_sort_list(union acpi_operand_object **elements,
 			    || ((sort_direction == ACPI_SORT_DESCENDING)
 				&& (obj_desc1->integer.value <
 				    obj_desc2->integer.value))) {
-				temp_obj = elements[j - 1];
-				elements[j - 1] = elements[j];
-				elements[j] = temp_obj;
+				swap(elements[j - 1], elements[j]);
 			}
 		}
 	}
-- 
2.20.1

