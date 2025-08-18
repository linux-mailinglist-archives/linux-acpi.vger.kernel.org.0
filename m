Return-Path: <linux-acpi+bounces-15792-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFEFB29C22
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 10:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E956189C78A
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 08:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E053002CB;
	Mon, 18 Aug 2025 08:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="XLyJBkbm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013026.outbound.protection.outlook.com [40.107.44.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4279330148F;
	Mon, 18 Aug 2025 08:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755505507; cv=fail; b=YMI/ltZpsUy3xkOa6Y8HsSbQoApzRjEmaUhLXncnqvFE+I41NcTmzDPHn28oNo4W4TJjsGpZxbX/mzs+HEkTxyZzT8Bxk5kcpydHhCTiLlNF9ffw2pdkziBk6cS9BBA8UGstFufmlq/6Z1/gSfnW877qdr4EJxmqBlxEDw/cnt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755505507; c=relaxed/simple;
	bh=E5/RwSxbeErvtW6jh6fSwsKNsPmTWXxw2cKUKGDnBZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=h4EJTocjrUqJtwY+8Poi9GaUkDs9TSXTniUSnUdM+PthZoGjbECNEhAA8UW1AHhvnXGTw2REVGOvjZ3o1oacG/ASY5t/A5Qn8fg0PJ7xHzI1zgTATm8LvFrsWzjXeFX2k5DrEPT7LGeWRdY9QUd0j8HGbFkBzs/4YB7DTAG2olo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=XLyJBkbm; arc=fail smtp.client-ip=40.107.44.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v9MGNLZu9N6/nHQsDbwmH6NVuT3uaFWVBaZGmdEtN79S4fDKGcn1fVe1sZL87rX1NJlNlhsrkmIbsGagk5IybknqXdbqcgJw+1OBiJDddXKsyrUC03IJIwUIhWnVrKZnpn19fzIiLz8eTD44Eq25qpX6nDizX/w2BvdFXfPuWdR7PuupO6B1+rNL7ibIzu25u68Q19Dpq59Mcia6IBBsHYePQjAs/wQovhrRm0MijU82Av7DkHI9K++fIpH/0KPdXmaJoj3iPyXb0Uz7iRTHFVFpMHex6nxEBvE+HojD9iv4C7UDl6dV+Jxh3d5bN5qBg1ycn6E87UArAu7qGQCBXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/yoda9aoIAsQnoDqvkVllnXMS1rDXJZxgJZXICtB+KQ=;
 b=sLrTIU6kno5yUYKCZe9WxDP/HELGBcRGzBlSOEJ65BTTkmQS6qqBDUOGMgpkkAJbWV5B8OGxAITtrrZhcMBcg9UZfc/JeqTXQ2hLYmJ0bfNPFABKQK81p79xEkuJ6VKgCr4amLl0RPl5k6m+1u8BYOweeu9RfCCiH9N+5Mwisy+RmEP06VZ3e3I7BpM5DxXWBuZ/172I7fuQnidhS3IY+c+DhzX/Ql4v9EJRCaXGzMZ6N9aApd4JtnegAJWyETdgyjyxD3qrgY37nkwaqx33M7zYDJXFuN3iT1uVyASUBk814MkPbLH9JJ0HPksP7YTcIgrRkmyeLWznDuqCnVoZ4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yoda9aoIAsQnoDqvkVllnXMS1rDXJZxgJZXICtB+KQ=;
 b=XLyJBkbm794yqC6bhn5lw35xyj2e1I8SKkoea0bBuEjNmYdKH88J6M5fvSDKRFnjgOroVL8YbJ+R6p/uIuUSSusOMLLIeaQm4ZCKcM41xcyoLDniAn0qhm7yKo64Gt/kH34FB4z3FriyehvSXLoRwAOjiFHuP12oilbFsWl1s1bYEgDLX9DushKykYPSUQuGRPQG/0bP2keX5pC4hxkZ+dMfgQd8yGP7oMizI0ExGnFrNc16sm4G3vQ2e3ADto1PoN9rhXWLvPuL5LlOi+w6WBXZxW2kyYf2DcG79JEMrxQNcqqg102BJAvcdXb8jC1RO92cC2s1f6jJ9Omzf8nZKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by JH0PR06MB6414.apcprd06.prod.outlook.com (2603:1096:990:10::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 08:25:01 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 08:25:01 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: perex@perex.cz,
	rafael@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] pnp: isapnp: use str_plural() to simplify the code
Date: Mon, 18 Aug 2025 16:24:51 +0800
Message-Id: <20250818082451.497935-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:404:f6::20) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|JH0PR06MB6414:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ead54ec-df14-47a0-bd7a-08ddde30b98c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yARpQ0TdaOnonSRqhKpFaUmUwJnV6rlSWHqrjFDmffN7qgNVeVA69rww9Pzu?=
 =?us-ascii?Q?aPPELO2HYe5kz9duWuOuuZoF/dodpoIfMj1lrZ4gNJVwoSRO3AjKlW/swIM3?=
 =?us-ascii?Q?dgPaWR5qA+2aIsyw+yO2ngxW01KjzduFRPdUuW3h09lKrdYwAwBC32C9nLxL?=
 =?us-ascii?Q?5pDSO0YRh+PHIrDrUsyBPG5QPuiOpOjKIVAHKAmygJlhWJeZhFfaCO36elbu?=
 =?us-ascii?Q?93c0o7zcFbYenMyMja2KDDu381MfEPNc2lrZ3Yvr6KgfJJvJHK09FQAFDs3M?=
 =?us-ascii?Q?0bBKcRijJdjf8rewsSCokwqGCdN9JI+sf5dldzI1q1LxkF0BSl2v4Uewcdan?=
 =?us-ascii?Q?JcF/r6jZTnLqRiD8i7zlW4wQ2uk2/iWnv1XonzVaK6Y80hoFAl+qBxi6L8tX?=
 =?us-ascii?Q?bArOJDTDNyFxKjVcw+svEtINZFfN2lHXkPR2vRJLa3s4GijxNfgerR4se2OD?=
 =?us-ascii?Q?y0wJLgdmsp07COawQ6/vS8Vwu3m0pzE7ChOdvU1b8TD9NjCREaQE2e7Z2I3r?=
 =?us-ascii?Q?ZGGPOoHfHUkZoBqeKLqarUx2nN/vBmLTODi1SFd/wvpUx5FaWYEPTqJSiHsI?=
 =?us-ascii?Q?BdWh4nFu7sQKDP9kfUNfjQv3p5EmblT5v7FAW4fGA856kgG7fMjFVsrJQZg8?=
 =?us-ascii?Q?FYwOqJePoOcloMmdGkmQ5pHGvE417IJ1q91QygCKLF+VcSqW+YwEZRusQOMv?=
 =?us-ascii?Q?9z4Poz3pex3sZZsH7VZnY5bht3YTy82uJQ4Q16ox1yI5LmdGDHp2HFAL0YV9?=
 =?us-ascii?Q?dGnAksBF7E2IfCTkLYMini7PbyRWgiCK2ignesYXjtK9bRXoOj9MHRTPPOKp?=
 =?us-ascii?Q?fbclf39VcJFzuCAJrXerBygYCoMsBB5V8OuZVbjHsOdGclEZZy/g5xZbeXn6?=
 =?us-ascii?Q?IkQKtpEoKWIUjyM3reZJHc4Tc4/RlWm9rwOKrn/7agx/QT3IFldrBRUj3R9Y?=
 =?us-ascii?Q?So16NfMPcnYKAZ0CkCVWr9ve57QmzetslZE8SuWTBP4ekY28eHtCUzoDT7f3?=
 =?us-ascii?Q?E7apbQ8tBhTL8I602in7fFYXDWvvOUMhr4RUhDqntN0NkVJPwhTl3MXTX7dN?=
 =?us-ascii?Q?BHDczuMnaIABGNff4tf31qGFmyXv8fVVWJuZoB5vSQeO/l0Kcsn2XdgEVeB8?=
 =?us-ascii?Q?OAYPOCX4za0A0WwiAXBOzTUmzTkboIxw/GpNPQ/7ACQvppBPMiYTIajpJZk6?=
 =?us-ascii?Q?/e1WrwHmMaCLKCVEWPucnR6Rpq1tb33rADbH/nPLdQR2DuQQQHGdZaa22OMA?=
 =?us-ascii?Q?S/CbFMg57rcsMYfOiybW92nEnNOAtLgXRpjCzrsScV/OVnT4NHai14YCz3Uo?=
 =?us-ascii?Q?51/2E1+ULT6OPRZKP4JxFl4RzEFeRNOurN+4naUhK9pkjvprxwFx01AstrX7?=
 =?us-ascii?Q?havAN7KyZiNnR11X3q64+oMndd5G5ek2ggpO0jbUWzgHWvpTw5fBvWIx2rhX?=
 =?us-ascii?Q?o1/+MU9Y0Wg367ZK9T/5SLUb9Sq6+NTgSjGv+O4DIIYbViawmS5a0A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pNPcEJJZ+1o+H0Eiryvxmw4SOTgcQgoAfTTaQsXL0ctmruAqH39L4WI3GOoF?=
 =?us-ascii?Q?5jCr0Wvpn/eLF7YH93luF3+MZls7PUfDvVITsP3wRlRuOceK/3ANep1pXw7q?=
 =?us-ascii?Q?GDKm7qf5RGdiomvj/3QK/nKrXYC46y0STGDo625rtQy+1KCLqcdwpvBy0uwj?=
 =?us-ascii?Q?TP6cSE9F4mEm8H8O/IgDRW2FRhppMOCAkXgya3oq+LiBAoJUB9QCOjpnx3Ce?=
 =?us-ascii?Q?hdCk77deWQLlaT6PhxIkLaDaxv0Cp7lsJhNeBKdl9/UxoX6YIX4OprqcDMWy?=
 =?us-ascii?Q?Q7q8QIb+KzVZoHqPVOS3Ziujz5Cett3A2wu1AVyllHj5t3q6N88Mx+goavUs?=
 =?us-ascii?Q?c4H3OoEkuVObo7yOLvYSg65I0xmkNVx7M3d6q2G5wX5VGTdJe2VDTd96oFg4?=
 =?us-ascii?Q?+VaeKCB99T4Q0O9dRP4RxXH4UvMv9kkMbygkbKaG7sLCKQdd37vhqYDM34Rl?=
 =?us-ascii?Q?MAqUQ+WPqkiQh7JKJ47yLt9BWJ6DHVxmNPfkNy4utTtVOXraElzimYzlFATB?=
 =?us-ascii?Q?5PBXpLd21xgV4tl2N9/Gboqr0u1gGvoOaB2aAoLMAimVbw9ifAK/RWQI3GqF?=
 =?us-ascii?Q?OlCdwz18uBpAd3v/+1lt6Ul7OZiifxU01ZmUcCPpLTLqzJMjqwbkNEuy6Jzs?=
 =?us-ascii?Q?WV/Kn13S/LvRoYRM9yeIRkYMxUr7TGRp9CU4zkoo1Dpz7nuB/NB044TdINq1?=
 =?us-ascii?Q?aluqn9lVvemLCx39WWzKPmh5WJBs3OyuHCWmVcTsYpx8LVCqTFcWuFRGZvrx?=
 =?us-ascii?Q?kW8pA4LCQpir6aIfo7scIg5+xArH6wyt61nCfq7O4aGE1ceeQBeTV1L6Cnr+?=
 =?us-ascii?Q?BMReDJxgu1UaWGeieYkZAFFpSFGTmXAZeaudsiihBRx0ADtUhgEvfGmdOZgS?=
 =?us-ascii?Q?UHOAI6L/idGyJh1P+bDE5BXd/ZFJ7UIjvmXbuFVlzYVlMyQXOXM7jkx4t90g?=
 =?us-ascii?Q?5LAHE0wNfVzcZStRrwQhZ4AWlEncTLlv8G0lw3dG3qUhzwdcbrTbzq2W9Z0a?=
 =?us-ascii?Q?s+f6PS+c4u2YFYLQ11dkFQWkuDC+l8NT8Z9GJLfLbtnfah6sZ+VqPffLsdbc?=
 =?us-ascii?Q?WGbT1ySyFnWWx+E4W1umrzERFp+D+WXseU8tW32V1SmDzQxRv9Jz9NbS+DvU?=
 =?us-ascii?Q?xTHCvuiMpNRPkEHUWVvnW/UTvUp4pfJI29CpCkBcrBsDEviwlnbKovBDSjR1?=
 =?us-ascii?Q?0h4FafCC+7cVFvT/ZgA470cJPwY4WtKbLY0D2O04llkdaQNGESMqxVGTryZN?=
 =?us-ascii?Q?nWsnfLWc4bgKYSAsXkGHM5tgsiR6tT2AgaR/mblNo9kn2ka6e63wuVT6yulo?=
 =?us-ascii?Q?Bh+X7iAiqKE5/Xpc/MEc/Dsyzl/PxBunJyp8SWrbFH9q2gbnFOp0xAZxT3pu?=
 =?us-ascii?Q?FT9YfA6oa1F5pu6rMeTwJF8qDMdDVfi5prCoSVWgo9LRVe7+uIYFirXK/bIV?=
 =?us-ascii?Q?vLL9cUmpCdcO+IRdCSn2nSsuuN1PWuuk3c777bOCW29BkzSTK47oV6xViZcT?=
 =?us-ascii?Q?ABeMZvW2+v6x0veYwaAR7i88JZAqvOvbtNU1BFrS26j98VkYWe9dL9hSKCXW?=
 =?us-ascii?Q?QxRmJN1cTncDZFZOiTl7awtLbQHZLK5ruS06UKXs?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ead54ec-df14-47a0-bd7a-08ddde30b98c
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 08:25:01.1551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CMcyK8UIo0xMtDZOq+3IYOi0zUa+u0+kLBxhrdmWkmaISM7tqcKE791JfzEe+59i3tJu2i8SrtGubpe5cGY5mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6414

Use the string choice helper function str_plural() to simplify the code.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/pnp/isapnp/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pnp/isapnp/core.c b/drivers/pnp/isapnp/core.c
index d2ff76e74a05..219f96f2aaaf 100644
--- a/drivers/pnp/isapnp/core.c
+++ b/drivers/pnp/isapnp/core.c
@@ -27,6 +27,7 @@
 #include <linux/init.h>
 #include <linux/isapnp.h>
 #include <linux/mutex.h>
+#include <linux/string_choices.h>
 #include <asm/io.h>
 
 #include "../base.h"
@@ -1037,7 +1038,7 @@ static int __init isapnp_init(void)
 	if (cards)
 		printk(KERN_INFO
 		       "isapnp: %i Plug & Play card%s detected total\n", cards,
-		       cards > 1 ? "s" : "");
+		       str_plural(cards));
 	else
 		printk(KERN_INFO "isapnp: No Plug & Play card found\n");
 
-- 
2.34.1


