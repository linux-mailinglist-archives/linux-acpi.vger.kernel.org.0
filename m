Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2887F3CB5D1
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Jul 2021 12:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236734AbhGPKTW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Jul 2021 06:19:22 -0400
Received: from mail-eopbgr70049.outbound.protection.outlook.com ([40.107.7.49]:24201
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235965AbhGPKTT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 16 Jul 2021 06:19:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZ+gsxbcYehAl4PTUXt9w8m6ZTxlzESVKC1l8QpugcdTMQj+mXeD6z3urzGXNTX7dOUITxqxO97BrOaT4qEzVNFH185tNwLpyPpuOMvLtCJLkoRGfri8PyHtGywsB85LNZZRdFAMQj1qaiYwGOcfjV+WXY/D90WntRSht2Duzu6SfO0lcWLrOIxoNMjK0IL0Jm1Sq1uOJuaA8+vdTwsUGMxsGNMFKZrKuaR8uudOG/DKNVTN2gpSBILB+W+2jmkM5yMNG8AvcwbW8HtRMEu8Embo3XINCHXrKOn9Q6fU4s4Zx20Fpb3EYpHkvrXBssiy/rgROnWaEHeFaik3hkKd/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JuavuJrErdDbqsc7GJdngifGQnY3g75uKAib2babR9g=;
 b=a04K7TK47creZqBozdrw+rlCgfaNFPO0QRh3JbLHf5h2TW2vSE251KuxDGR80n9aOg+WhAOHKM29ABqXiF1W+MDH6j9PYjuvgmnG5JcimSFPKIYHgLZISu2x2FW/YzGRuQODibd+PvV1048K0yLB0DN74IdEONjXJDOBIHcVhGaKAPI/zlsXUZane4Z/rwiEgMUZl9r9TvAgi1JrGCPloK/NiFBNb8yrXVI48uduCbPXrdlwPWebb+0BSi5zekTSSYAjvumkb9AKPy7uqAo0V9UGVqddarOr1lb/b1uIK2nvVwCH6RZZwx90QIK7/hRu2KGLZyZf0WOIFpY2k6PWpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JuavuJrErdDbqsc7GJdngifGQnY3g75uKAib2babR9g=;
 b=XFWk1T+akVLAklwSc7LGS2WNDE7l8GHY/rOxYVA7w+CoY4u0Zqqlo2cgBPEC+LKhM+hJQY4+vynNjXCrUPTASr00Zj39BLzvt3T8T6D9ijyNSTMxolc/88X3nBhOz+Y2ko0oCK0aK3PufaDAo4Equ0p1EYNle/NslHSo+4nKcKg=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VI1PR04MB6990.eurprd04.prod.outlook.com (2603:10a6:803:138::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.26; Fri, 16 Jul
 2021 10:16:22 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::c424:7608:b9e8:f09f]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::c424:7608:b9e8:f09f%5]) with mapi id 15.20.4331.024; Fri, 16 Jul 2021
 10:16:22 +0000
From:   laurentiu.tudor@nxp.com
To:     andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jon@solid-run.com, Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH] software node: balance refcount for managed sw nodes
Date:   Fri, 16 Jul 2021 13:16:02 +0300
Message-Id: <20210716101602.1891-1-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM0PR08CA0026.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::39) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-101.ea.freescale.net (83.217.231.2) by AM0PR08CA0026.eurprd08.prod.outlook.com (2603:10a6:208:d2::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 10:16:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fe2bf1c-5816-463f-db02-08d94842c2ff
X-MS-TrafficTypeDiagnostic: VI1PR04MB6990:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB6990F9816FE6DAECC7130334EC119@VI1PR04MB6990.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SHZ3EwxMHgpMgxFbtAbSCEBMVqX3Jy8gVAMNH8dWBaUi8lRw3yjE2+9JTmF9rIYNqaL/SSxEbX8flFBPaPDPZ3E52hdUyrcSVZUllwg/xr7CRcmTcDi5gzwd/qm5UF2EaVNl21vuC3dYJ+f4m63QZ00UTdSgLkgRtHnPIXESH2/6FWo+7sRvtgKXafI9Jlbq2AK/AFibdZbNO/jFeRsuyQcRbSHwtrZuIAgjkRhegjDSUp+fussmUgRAR+WZ4k221Kx0YD/LRezX5MCvNJvqsILJvYBIs3H+sVsPz+TyTPCP2XFXFkf/kYjpIYkzlCfEsttXWR+oXva8j/N5mCLx3HQQe2TCKj9aMnlS8hUaCJq8IbkF1vyuh2qmKv/4/oe4ElFzlx5+I9XjIuvh/nDSHUJ2K59OXyN5SxCTPzusiN7YFN7xA5g/jwlfKTSe7mfyZyRXZGxNYLZonvbz1udQxm1ERT8CGsrwQ7lQ0Y+ezPjd/Fn8clZg9fuDOQYwPqU+3bIjJxn06Yj2bjexmrQRJQTjxnbDy+jzh6gUVDh9iK9kVHbN+UJoDsLOKY1ZqXYoAq3hJn21SWGl9gV3WF/zaQ29sSSfQ7FLtWsMYeNmeLAiHos6XYXnkRm2o3IJc0dWshXJ8Vpnhv4lPGfUQRLFlcggfXrVamxR+5usI4c54Oz2WEZXsqzgfb3RU/n+fxXwk8YCXc6XOVQyQK/SpCL6IA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(366004)(376002)(396003)(52116002)(956004)(2616005)(8676002)(8936002)(26005)(5660300002)(1076003)(316002)(4326008)(186003)(6486002)(66556008)(6666004)(6512007)(66946007)(86362001)(2906002)(478600001)(6506007)(36756003)(38350700002)(66476007)(9686003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZbGr/Zg6UsF+aXnDbd6cvxi2on6LcPzKBYCBmbRNzURGd7OslcG0LM3sPgz3?=
 =?us-ascii?Q?BwkDyecF++nwfj4wlbjmTiuFaDhemV/rDoy9ZRAWfu8BPYzq9nwmgw/3WRm/?=
 =?us-ascii?Q?JitTNwpPgXkeBSl9gRQLyUvhze1S8cqoeb3F7n3GKIHTevfSvSx9z/N/FymI?=
 =?us-ascii?Q?2U21dTPyjeLC3swd/opWxTeiXHCLqvULc52mOIgZqmn142gC38mkN6Tk3jhh?=
 =?us-ascii?Q?xF/IabLoVQWND/hhOFKA4b53Mm5quUVVmO9PaaElAu++e3Cr8+G3gTQ0UyYb?=
 =?us-ascii?Q?UpCj08JQaimv3S08R4+BkSnpbl0GignMrTz4AL4b9+/fSjnYzno3dr7e/y5Y?=
 =?us-ascii?Q?WgFe0xDesZDSgdSffF37nW2t8wmS2/+3sOdQJSZL/eGWMw4ff9rMHdv+ffqT?=
 =?us-ascii?Q?nYaB82puS0WKZzBM2XFfPKNsc60782W4637pbTZhV/ROciP/NwSb+akynIb5?=
 =?us-ascii?Q?KNb2NyLhdzcHqDKWPyBj4AmFhYZDFEn7qwR+EZ5eGSH5W0rvC+e0qCEat0uT?=
 =?us-ascii?Q?87QtJb/uZTFFuC8MtyTUi3tghcJ0qKip0edxfxuSrqUPo7ZKsPYbWq8hP9Ad?=
 =?us-ascii?Q?rGrWCJc1EyLM9tp7WU/yU92kT/CWfaBE5mgOjUujqHh582TleaXT7j0ByXve?=
 =?us-ascii?Q?rWFbIanUwxzm8ftIzavumYfM3x8o4iRi1Mm3Bl9iNlIVUWF3eRnKOfZgHWXZ?=
 =?us-ascii?Q?hLT2P7ahRFPUgOu5955cZmqYmyr4GqNnJSE8gln1bzqgsT/8E6VaqDPytUiK?=
 =?us-ascii?Q?jA8a7q49D4xTlruq3GTSPX/DNljQnxJda2yR407MMFT/vpsgUFaz1YExmKHG?=
 =?us-ascii?Q?O3fl+6S68rSKzQLoECivemsrLobTW1KfSX7K/5pEcl5FoeZ49a12SP4RqCD5?=
 =?us-ascii?Q?uGqzT6h7hRCHL1CW8cCWzBQzcCsOr+e8rJQiIeXKJCLag386Mt179cbY2SLC?=
 =?us-ascii?Q?wNdM2HsF70HavRZ0lduxw2KyWapGDW5igR/rNrh4zoUxgs7ZaLfndo34QrWg?=
 =?us-ascii?Q?OLYUny/eE+tEDQGVbm3cBxH1pEi4yCT8dEwy1bJxdJnJJo3kA/KP3ihW1LOj?=
 =?us-ascii?Q?ojL2nDfDcPtrPkN2PuBJPozd7aZ6IzK15JJVRs9bE+jIQtxgsHGJbnRJGlZx?=
 =?us-ascii?Q?OC8Q1o2WW0GZDs3z7Yj1jGrJ2u4lU5F8MV4m+e1brpZiPiy5fa7Vo2x6Nrtz?=
 =?us-ascii?Q?PE2n37mvoEjcEb0te3VpH8jR4/fRC/jhCM9CRNb96NfkzoAP/I9rmXRaitvT?=
 =?us-ascii?Q?0OxKfnYqBU1iZiDpgeQh5BhZVmBf+m4j6cFw1yXyw//DbKeRKnpf2157W18Q?=
 =?us-ascii?Q?JWG6adD/P1hv8m14s/EM3BLg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe2bf1c-5816-463f-db02-08d94842c2ff
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 10:16:22.7744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O62grZvq0m0C5gttjjUQ2IpFAUGwxC+dya/d6Rq4fnhAzHEekYvkj0ZrIh+hgAbET3X+7a9P5khOZQWKDKxkaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6990
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

software_node_notify(), on KOBJ_REMOVE drops the refcount twice on managed
software nodes, thus leading to underflow errors. Balance the refcount by
bumping it in the device_create_managed_software_node() function.

The error [1] was encountered after adding a .shutdown() op to our
fsl-mc-bus driver.

[1]
pc : refcount_warn_saturate+0xf8/0x150
lr : refcount_warn_saturate+0xf8/0x150
sp : ffff80001009b920
x29: ffff80001009b920 x28: ffff1a2420318000 x27: 0000000000000000
x26: ffffccac15e7a038 x25: 0000000000000008 x24: ffffccac168e0030
x23: ffff1a2428a82000 x22: 0000000000080000 x21: ffff1a24287b5000
x20: 0000000000000001 x19: ffff1a24261f4400 x18: ffffffffffffffff
x17: 6f72645f726f7272 x16: 0000000000000000 x15: ffff80009009b607
x14: 0000000000000000 x13: ffffccac16602670 x12: 0000000000000a17
x11: 000000000000035d x10: ffffccac16602670 x9 : ffffccac16602670
x8 : 00000000ffffefff x7 : ffffccac1665a670 x6 : ffffccac1665a670
x5 : 0000000000000000 x4 : 0000000000000000 x3 : 00000000ffffffff
x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff1a2420318000
Call trace:
 refcount_warn_saturate+0xf8/0x150
 kobject_put+0x10c/0x120
 software_node_notify+0xd8/0x140
 device_platform_notify+0x4c/0xb4
 device_del+0x188/0x424
 fsl_mc_device_remove+0x2c/0x4c
 rebofind sp.c__fsl_mc_device_remove+0x14/0x2c
 device_for_each_child+0x5c/0xac
 dprc_remove+0x9c/0xc0
 fsl_mc_driver_remove+0x28/0x64
 __device_release_driver+0x188/0x22c
 device_release_driver+0x30/0x50
 bus_remove_device+0x128/0x134
 device_del+0x16c/0x424
 fsl_mc_bus_remove+0x8c/0x114
 fsl_mc_bus_shutdown+0x14/0x20
 platform_shutdown+0x28/0x40
 device_shutdown+0x15c/0x330
 __do_sys_reboot+0x218/0x2a0
 __arm64_sys_reboot+0x28/0x34
 invoke_syscall+0x48/0x114
 el0_svc_common+0x40/0xdc
 do_el0_svc+0x2c/0x94
 el0_svc+0x2c/0x54
 el0t_64_sync_handler+0xa8/0x12c
 el0t_64_sync+0x198/0x19c
---[ end trace 32eb1c71c7d86821 ]---

Reported-by: Jon Nettleton <jon@solid-run.com>
Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
Changes since RFC:
 - use software_node_notify(KOBJ_ADD) instead of directly bumping
   refcount (Heikki)

 drivers/base/swnode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index d1f1a8240120..bdb50a06c82a 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -1113,6 +1113,9 @@ int device_create_managed_software_node(struct device *dev,
 	to_swnode(fwnode)->managed = true;
 	set_secondary_fwnode(dev, fwnode);
 
+	if (device_is_registered(dev))
+		software_node_notify(dev, KOBJ_ADD);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(device_create_managed_software_node);
-- 
2.17.1

