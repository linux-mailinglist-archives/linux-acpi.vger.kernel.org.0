Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 112F03CB404
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Jul 2021 10:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237660AbhGPIUT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Jul 2021 04:20:19 -0400
Received: from mail-db8eur05on2042.outbound.protection.outlook.com ([40.107.20.42]:4193
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238143AbhGPIUS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 16 Jul 2021 04:20:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWH3FmNl34bI9X8A9F4PRBoc6bPXzpgJL/sOfxPoKIavkRUGfc0R9HRxWntqjLKTNVkJkdfikUPvXYUJYOrhgzY8WTbtSUM3iBmyXeoZ52dwvu6wMNyR4HZ1vgDSeCQUhtBUEMJ40v6Vku75FtlaE4vi+vaSxe+oneE/ZEu789MAC2tE2eD6RP+2b1LHR+GtYI7u8dAVXIn+WGdDh0hD67CFO1rLo1hfWZDBJHv0XDcGI7AgZz2tUdEk9XcxRXOO/bRIu9gyTOtsm7WErxeIElvvp4FmKSz5b8GOWj1fmPVU1np5eRe7HvzJ86F/HK0kDj1FR5ZXIdVmML2bvnMVsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=550W35mpifskBgvOqBPXVKThT37TfkqPuDo++cnx/Wc=;
 b=HD3Xhha5Mbppm0aXtZJyDI5u5UKDRdl59fPgDClQIyD3w27fuahuoOlRvH6/MgPsiKHRbZt0SvOnPZ3mbiXAwVbVj2EqtfQmnPvPZIwMjM71HvkoO8BrB3rIfDFvoAx8x+WN8waOjq/Bk4kcMcum+VIRpi5j7Ow6jW0MgAjttfKHCuK8HRVrBLV6QhIEROLuLjXS7E6veDiB9d5wz59Q1+uqI9IJDavukOGW5jAby5Vg2oLLROOkEIusTz+znELA3zvKL7NTgJF8yC+MURXAo1enaDUunIMesvojfg8+dnBu2B6X18STMCgLXi6nF4iUFP2wS3I/8zKvkHGmALrFSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=550W35mpifskBgvOqBPXVKThT37TfkqPuDo++cnx/Wc=;
 b=iRzEixEiaycLrXNCqDu/f/LgP61EP6g/ae7xs3PXUCKSx8hJ/2c8hynSAe4u0YWj+Wq8/VUq7rzqWbqi4e4SrUCwdQtSo0Kk2tnAKq1YaXnQcYM2qe0s/0HlzwTnYWhVRfYcKOZ83XfZdZwxlgoAf4EEiWACaSiHIXmHMOBpZoI=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VI1PR04MB4239.eurprd04.prod.outlook.com (2603:10a6:803:48::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Fri, 16 Jul
 2021 08:17:20 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::c424:7608:b9e8:f09f]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::c424:7608:b9e8:f09f%5]) with mapi id 15.20.4331.024; Fri, 16 Jul 2021
 08:17:19 +0000
From:   laurentiu.tudor@nxp.com
To:     andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jon@solid-run.com, Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [RFC PATCH] software node: balance refcount for managed sw nodes
Date:   Fri, 16 Jul 2021 11:17:11 +0300
Message-Id: <20210716081711.7638-1-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0202CA0004.eurprd02.prod.outlook.com
 (2603:10a6:200:89::14) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-101.ea.freescale.net (83.217.231.2) by AM4PR0202CA0004.eurprd02.prod.outlook.com (2603:10a6:200:89::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 08:17:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82d39d5b-6971-4a98-3156-08d94832217e
X-MS-TrafficTypeDiagnostic: VI1PR04MB4239:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB42397B09DCC76D526B4D6B16EC119@VI1PR04MB4239.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JyHHXSZXJzLUeDqk8k/Fuic/m1WLt5WTSfbXyEV1uVov0ipm5xYG0+FM/jkB9nl/fG/OmzwkevG/67KoJ1HvKba5wfnBm4GX1OPBM7jgiCwiUpRSvrKGIXB6QlcBj3aivCBjmu5igpO9yrmXQKOZt9fHPwMKjxztmMyBoOOHeWjcOSIKEFdVNNw5hfccVRI2XU0VDUWpOI+fsU89MKu2XHBkAq8Z3RoEQiX7rNgDNTtF23IQr101QG2yAhNNupzBEVp3X0LFga/Fk8NXCJzi9nyKIAxAqy+DNYYz7dF3YAheCZ5Vh2I2UL3khQ2hCVJ+X9C8Gw6Rg16LdZ3s013JuQx1K4bPmL5pBilweD4ABfhk8Mdak6dXXgoOyXzjS4yUoS7QS4ljEN8haMRQ4XbDDDK5FTZn2tZ6tvmAfGNpD1iwqtytHhUbH03Oylolo9WUmTNXUCn4EX1O2KQiGIIoxclSliAjl7VXeqPjFSAjzuoAPO5SqZL8QB/hMRP2NNgiNtANC9FXWYrkKufrx4bwBnZUh+oV+MYn+Z/j90rcAuKLz+/qSnr+kSIS/7hpfpcNYDLuCa67WHOccTDkt1CGptoKSLUNrm7kiUYmmuWfLbrvHLqGRhkssTFrTLU6EuJjVeQI9zpu8qU5GFDENw7Zy7Qw9/gZn5d+W0gwj7ba1tl++afyMXYMZDuTHqK8hCWKF66U3pYSxiw/Bo5kcBPg4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(376002)(136003)(39850400004)(396003)(2616005)(956004)(66476007)(26005)(8936002)(186003)(66556008)(6666004)(478600001)(66946007)(2906002)(6512007)(4326008)(9686003)(38100700002)(38350700002)(52116002)(36756003)(6486002)(86362001)(316002)(8676002)(5660300002)(6506007)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TLrlSw3CvWjGoptdH5b0sfDPpHElwJtaHpr8cPmtcgtp6MklefpC46hJOhAY?=
 =?us-ascii?Q?KVJaPh0au+BAjOjsKKYg2RBFFWrkO0fjtAQp/Eom1cvc3yuwjiWduLi66XX5?=
 =?us-ascii?Q?lfiX2PvKiTUtQVRLdpNA8fElRUXpXva6RXoZScoym7mIbBS9dM0zJUaDnuTb?=
 =?us-ascii?Q?jKJzw48PdaXvMH9cLqEuZOgBq4FcL3GSw1w+j3b1YUaIehrQnXN4nv3tUXA6?=
 =?us-ascii?Q?C9TqqUuO9fNNA9nQbkFoXMHVxNQz19PK90iAKpi/d6RFSWunhPRK5FUihGny?=
 =?us-ascii?Q?MKSRARpEm1tLw7LcylFlyprZ4hoLoxIlenQClgxtXZcfepq1o74YMTXsKjjK?=
 =?us-ascii?Q?0uZRBTX4qtmkifJ5xe+yr3I1BWu77dcbEIJyXGC26TsV+ZZPacYTnylJQwCk?=
 =?us-ascii?Q?bwbDiZQnwxvULURwZXz5UgBr51eI5y/vdMG7+v49WGB+xo1R7gwkWII9zsrM?=
 =?us-ascii?Q?5zVLG3KNl2WGrHFV3WtfbDyts90JWZtZxW5XUmqKsLXXgwQ6bdM2lQMVh5t+?=
 =?us-ascii?Q?DJDx1FEIsq9kQm4eLv5r5g5MdbjkvEbTyj7dBJIkxueo6kESC4tQwJrDElwB?=
 =?us-ascii?Q?/ONXkY96uyd4BXCZY4thTRiYbtTKLJBZRadUgUYR5yP2dyzLgAS78TQxm15g?=
 =?us-ascii?Q?vxwZkQJ68QG0zCoYCYrkOHByow4QRemWSnOMMMu9CXTCho5W0kB5n/7ha4V0?=
 =?us-ascii?Q?+hpsGydO/SCCjBSW73MI9C7XYZNMgisHTVBYzSitAOQsKLVm9IKog0pcH/q/?=
 =?us-ascii?Q?Vrs9gnm5MzRDCEttual1waruN0OgOa8GQvAFIyCm26NOJKAWg88onL4QjSPS?=
 =?us-ascii?Q?GDlRKZxjGtYg58Hj8uxnq7xiCBywZ/lWFmbL+aPaHE1RmRNc/E794X7Szdwj?=
 =?us-ascii?Q?JDtkXvOUPtbExIDO5h3D6cz1cPOdNuwkenVUtRiXVGRkYVhPbYGclWgQeOZh?=
 =?us-ascii?Q?SMxiwburIQuAvAk0SBqLX6rKpHF1d/dqpU49S5Y+pJ+lS4mdDqKgNxDhsZ0A?=
 =?us-ascii?Q?XEGm10ErkfX0pS81Qcrgmim7tj0pN7pRzOAtrFNbcvNNZ+6+4ml3IxLoDuVO?=
 =?us-ascii?Q?oUUTKiZfDsFzZ3QLSxZ5DH9s6t/i0CADwXZ/XZzthoFkQ5hf5+f1RvhoyV9u?=
 =?us-ascii?Q?vyLpJziJOtXcPtmfKFXenEL6cYYBfl3SFUZmmmirSUbH5INvfe1DC5d+5noX?=
 =?us-ascii?Q?yEiWWl5yXAgKDuuOH2HQS0khSzZfHQZRWuP1NAxI4xT9W08bcDucyYEZbJLA?=
 =?us-ascii?Q?4luhIz5bC+E29UAX5PLOWiBXQNvdV37hzIQ0DZtiPmEODLhVVtyKaM9BSfSk?=
 =?us-ascii?Q?rCZKH82GCR9cTaRRqe5bYlg4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82d39d5b-6971-4a98-3156-08d94832217e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 08:17:19.8627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LZLezSZ/Cd6kJ5OYIkviIf3F9BY7AWar53BGlhUca3VKt+89Gp+WQTHnA2cv8p5Oxzlbr1tx9Ld5B5/HVvKV5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4239
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
Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/base/swnode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index d1f1a8240120..907616ca487f 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -1113,6 +1113,8 @@ int device_create_managed_software_node(struct device *dev,
 	to_swnode(fwnode)->managed = true;
 	set_secondary_fwnode(dev, fwnode);
 
+	kobject_get(&to_swnode(fwnode)->kobj);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(device_create_managed_software_node);
-- 
2.17.1

