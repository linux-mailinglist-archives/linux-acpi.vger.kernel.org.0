Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE41144A7DD
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Nov 2021 08:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243755AbhKIHx6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 9 Nov 2021 02:53:58 -0500
Received: from mail-eopbgr1300099.outbound.protection.outlook.com ([40.107.130.99]:30432
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235217AbhKIHx6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 9 Nov 2021 02:53:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGbxOV4lKVbj2PWf37WwyZnfrtzcPwGvIRnZzOdpNNvLffZm4juJm8KP93i9JwAFqgu1bIuiRcxLE6lm1daZKBEM44vagN3sCXdzJyeUNkE97zy1u4349CnxLcpBVO0zAAoepNdpfa7bkvq39X/M6GVI77Jwh/qkaKl0Vhe0qdVHd4N8Zr2V5HdbHW+ae+xscN6OtygpjtUogFvMP8BWcPviisDd3P1H0Iw7x/ids+/E3npVXxx1k4SP5MTwUk5NE5k0duRCEcBjqgGogmnolqzaWH+ZTnT278+NV2Fcydh0TuITf2aCbBILNNj/SIoHes15ndgsepU4fQ6YIdiUAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9/DTH8fWxHLTO7c3lD12cq61/bFbYdhQTWjJayHSSk=;
 b=l/0zi3tLRLVGXn2hhxB19b5erKhOviJ47R+a4nTzmVHSTJCTQ+GSCbIrgtcz2fDSai8bZdw5UxUTgqFH/rGVooHctHvOK1IVWxgEsgJO51pQTNwAPkLpsfCxRbeNZiA8wwtqKQtOLikZF+TqGxteROwYtL3gvbYwgg7XWPaTiZUlzuAAXx1SlNhrzz7Xp3VWtDlPks/pWR5XoK4s0phAiPh7vV7GQ6DitsmQ0pxkI+fB6Ffm5MQjPSMWJvhVyE45YJfqF8V94d2dtwyS17uVtAvp/EPFW7h8e4W/TZrRfcfQu5jcViAJEGirBESzKOwX0Yx8p1P8Fxwlrfvg69tIaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9/DTH8fWxHLTO7c3lD12cq61/bFbYdhQTWjJayHSSk=;
 b=O8tQJDA1qw8fW6S9BSeDGB8N+lOJPqGwT7mSJ5WtbTGw+T+iRLQeMZPvfIwvou3y801LtsZ+/PzxszJCscOXoL6SNu+barMugik1tknQl5NfdIzdgkjRjUW905YJPY+lf/ySYxkVfwZfUvNKqFv7JY7MFx5cQ5NlonsVFyZfIAc=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=vivo.com;
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
 by HK0PR06MB2259.apcprd06.prod.outlook.com (2603:1096:203:48::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Tue, 9 Nov
 2021 07:51:09 +0000
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::814a:4668:a3bd:768]) by HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::814a:4668:a3bd:768%7]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 07:51:09 +0000
From:   Guo Zhengkui <guozhengkui@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com, Guo Zhengkui <guozhengkui@vivo.com>
Subject: [PATCH] ACPI: processor idle: fix swap.cocci warning
Date:   Tue,  9 Nov 2021 15:50:51 +0800
Message-Id: <20211109075051.7890-1-guozhengkui@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0020.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::30) To HK2PR06MB3492.apcprd06.prod.outlook.com
 (2603:1096:202:2f::10)
MIME-Version: 1.0
Received: from localhost.localdomain (203.90.234.87) by HK2P15301CA0020.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.1 via Frontend Transport; Tue, 9 Nov 2021 07:51:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a09403b8-c109-420f-51db-08d9a355b119
X-MS-TrafficTypeDiagnostic: HK0PR06MB2259:
X-Microsoft-Antispam-PRVS: <HK0PR06MB2259A5F265ED09F2158BB62AC7929@HK0PR06MB2259.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d6xBMqjXQgDs0MqncouJKbp5sWtT/lkGkPlkh6ZW5ZPLJ9v6E6umwbVssvRZZnYy+eLjxbDwpNhCxP3EhHUzdmZ3xkq3AYZJuCmefGOAlv2DrLT+OeHVW+m5R+R2RYu3kIT4RWIrpuxRPnMGipIJYkr1Bx4+f/+GwtdIqJ80JTWpOPuq/+HcIk2YOQdCzHU6dkntAjeTUDiXfpdX6NNKAE/KnyGLEEpPyACsabpnYIlSJwk53v+jDJUFhbfmTXg2RBiZ6G32zdZATaVYcN3vUw+j7k/674Jv/R/JQuD9EsNFB9cQL8b8+eCDGxJ06vasUfRLfTuYg45qdPsIXulA5vZnRIdMMlbOhFXEOSl0DkChICZEx/L5zgS/AkGiRGOdPJGDND2d5Yy++gXYTaDGxjwlRqjtGIbHw39qO8ZY6z2meUGG4oSdbJDkf+aHZC5B2Y7BJ2GicYmP+3M8CtDWsMOVPmwMMvWQRJ6mvtgCdot9qFIpCZKBaKElQTPaPSkYkIzbijEGAIJf/IAfWc9Jwnll8Ubn0F6upovlpzk5oeMlnmbDReTENTmD3h+F4iCTRphMngRXfLBCqBL03hkbdmgh99/Kir3d+HykWibXKmEN+KntItyI+dLezOLxUc2TvL+7Z9Jwn0iklygckKeKlYcEBd3VjjifrgBV2w50HTgMgcQtYKNVDP1Yf0UMZjg77OlWeO+sLAQQIhQRLf6lAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR06MB3492.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(66476007)(6486002)(2616005)(66556008)(26005)(1076003)(66946007)(6666004)(6512007)(36756003)(2906002)(52116002)(5660300002)(508600001)(83380400001)(107886003)(4326008)(956004)(6506007)(8936002)(8676002)(110136005)(316002)(186003)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p3a7KLOxFaSNyhKAso94ZZcU+TT1AThq1fyAHCyVULYjXNg0skLcxuPPusig?=
 =?us-ascii?Q?8LcCcMS+H1GV6aBpwfhaQ4j9y3+xmXRTZybKM/kpx9PBm79n5k/1TrLfz2DI?=
 =?us-ascii?Q?ADKUm/+e3oUsW8EJWKLEHXKTkA0O19ngshVKnfRE5AU/xxByXpXPtESIM4Ja?=
 =?us-ascii?Q?8XbGjI6EYB3H4aWlErqLdUY3zeGHFAmfoRoI6hr+qvQCwpwrCYjfJNo7G1pB?=
 =?us-ascii?Q?NM3JPvKTgQHAjC/Ch8OCd+QVx95nmiBmvUio8JOKNx0URWISb51c8YHdmkiF?=
 =?us-ascii?Q?AMcfthkv3k73ZA7ZFzrrn/EePLtBJ8kQ3tk90Vs21XC4AKW9PcyteMCtyxk2?=
 =?us-ascii?Q?GrHFFeuWOnkVKIroiXXIXa1ynaWg3yxgP3r4LDgOBoe2fiMbCsW8CV48Znvv?=
 =?us-ascii?Q?Y6wvZ09JgEhNI9c946f98cUd5vvJkULP063nGrPosRATIfKkZyF6Ixm2ynMZ?=
 =?us-ascii?Q?ejI32OsJPRqW/TCSTB+n9riKp+fPpI0COI/vtcZ3r9JW0RgIjBynlUcmO7AB?=
 =?us-ascii?Q?d8HlaXqo6mPGFuUXhfEzNyPlZeRuAk9tzVx8ogjcXImTUBsB5wqcKYG60Yg0?=
 =?us-ascii?Q?NdHyKHnNch5vCf/eD6PwGWMBJD0b7cz2yNSiXXr/2T01OaBZFfUpaCG3MBx2?=
 =?us-ascii?Q?yQaf5bU11zw51Idm8na4AMVpkCS7387GBWGEyCOitPM7J35qHFayMxiSn7MT?=
 =?us-ascii?Q?FdECenV9ohZBe9VPUigf/Tm9+Scnscksf7a6MhjF3meh+2nvtSUW4n9ChNIk?=
 =?us-ascii?Q?zW+rPrtj007yONHKptwvANVvNzopOPr/CemnsCF58aTTA40a9265jDpY6xQH?=
 =?us-ascii?Q?PUPgVOrrJEFUia/zrULDQFTsY1weiC2vpjhyiCw24hk4Tga7jyTUuDo9xTb7?=
 =?us-ascii?Q?C8ghj3G7cGVGPpjvzSBMDU59VkUNTqqoM5uwD76REPqR1wY7LBKyELTSbv+H?=
 =?us-ascii?Q?Kvda88j8ldf5C3IQlIX/G8eoWF/SJ3Z44MPg9Ec4F/lDvSWkRGJMDzgIs1ZQ?=
 =?us-ascii?Q?KKiMXsBS7tUra2s+H5MIlj7VMQ4w4SQC23Gm/TxoUmfrxjrYHhU8fg8qjyOe?=
 =?us-ascii?Q?oLsmw6Fh/HiITAakqbmTogl027HH9k2VTjDA3o+Rivco9GFycsSIZINjOkAK?=
 =?us-ascii?Q?PzGyysQ9kSnYUYiAentKkTSHpMup6wLtcq5HYEianl4OdGVB7apYOuCT/GXT?=
 =?us-ascii?Q?q8uWd26FOf9ZGCJP4/qDslhX22LLLciu5YkZsWfT9NJN81FiJsF5xyunoYhr?=
 =?us-ascii?Q?XGs+QZdBVpcYXAp2hIvSiFK4bNbiq4gtNi9I/pai6dVaSNoU4ClD8Df80kY0?=
 =?us-ascii?Q?4KHpt9ArZ5Sk+TnNORNo9ZPY8d4/DX9IzrOnJluf7JLzJ3xKk/v3TlvgJR2X?=
 =?us-ascii?Q?1BAFft/7nft4EW6nAC65xqO3gv7a5WJaI3VOTRZr1ba/SGhyM3K4piCevRqf?=
 =?us-ascii?Q?aJXCif6A7BJu+9zlv2CxoziP7XhIDyHYuLfPw8yPyNKgt02lwX7EXRjBI8mU?=
 =?us-ascii?Q?reX+LovO7YnksYjaq8VquPzNSWABnJtB4Cgt9ueFRU3a5AgGByG+7N5wx6/F?=
 =?us-ascii?Q?3aJk1NOh7v7wP0ELT9Gmxy+n0zP0kgS4QocfHarcqZSZDcGHoHgg1Klc2959?=
 =?us-ascii?Q?4BiO0Wq5q7mfgtJKs7ZpAr0=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a09403b8-c109-420f-51db-08d9a355b119
X-MS-Exchange-CrossTenant-AuthSource: HK2PR06MB3492.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 07:51:08.9869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x8O1Ki/Rz4/g5hkkRcc+WT+/4GjIRNn111ZW3Uh+tx4ilFOFeGTpvrdqHsWUGo22Lwfsnzx0OX1MVKxZS/G3iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2259
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Fix following coccicheck warning:
./drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c:914:40-41:
WARNING opportunity for swap().

swap() was used instead of the tmp variable to swap values.

Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
---
 drivers/acpi/processor_idle.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 76ef1bcc8848..4b906bb527e8 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -20,6 +20,7 @@
 #include <linux/tick.h>
 #include <linux/cpuidle.h>
 #include <linux/cpu.h>
+#include <linux/minmax.h>
 #include <acpi/processor.h>
 
 /*
@@ -400,13 +401,10 @@ static int acpi_cst_latency_cmp(const void *a, const void *b)
 static void acpi_cst_latency_swap(void *a, void *b, int n)
 {
 	struct acpi_processor_cx *x = a, *y = b;
-	u32 tmp;
 
 	if (!(x->valid && y->valid))
 		return;
-	tmp = x->latency;
-	x->latency = y->latency;
-	y->latency = tmp;
+	swap(x->latency, y->latency);
 }
 
 static int acpi_processor_power_verify(struct acpi_processor *pr)
-- 
2.20.1

