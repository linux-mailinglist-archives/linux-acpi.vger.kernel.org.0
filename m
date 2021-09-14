Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 141D840B1C8
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Sep 2021 16:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234656AbhINOqc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 14 Sep 2021 10:46:32 -0400
Received: from mail-eopbgr20081.outbound.protection.outlook.com ([40.107.2.81]:19012
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234868AbhINOpo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 14 Sep 2021 10:45:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAtOIAm0nVsBOuJNQTIzDGGFPHGFMJdiqnfOaoIIVAbIqK2eehgGyQKiaXTDqjtncLLH9FJzSyU7g4d7bODrIIpRzM6ZPPatlWdQ0l1XB7O4ppl4z5zZpT58uDhsS31BYErlyG3E/bq6MNzIBeTnr7bl72J92ESqjZYF9w4j/YHa/DHwecjHHcb3E6f/EDN1CuZ1pd7U6r5yersdSeCZZk+IGIPZkZgtvGO6XC5kMO18KWlQfLbcBFEbU7oBI2owsaAoGNiOWdIEvxwftsWRylkxYIfGKG9SRHn02gFxMLN29wGbTQszYxnXdCJFFgRRk2VZDRXxIqITVvpoKoYKpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=gJf+yB3xCoeTfkZZ9YBSbF/uMyYxIiJtso+9TZxGeL0=;
 b=OL7Qlsw3MpHzL8WroyNbq9NE+AHQ3taxeCYCJJbARzDiwQVekZSaIbfm0EuSA2eKx1748hTBbyaR5WLQVT6jGp54QgSM1AafsmChh1/8eMbTjz3IfkvYjdJ0UWL6gVXzUqic0mBulWKueKSWYhZNfQd1P84JCEJtQnjy59n7KFzvLNuYjzlbE4tW5DM0eX4z/UjuN/J3diNQ6SjHmaTDb5LZ7G4BMuqnOZKvYw/5W453q7aFQ2EgOkgLJjqfkvI/kkJq6qclaB4r847ov35RKRbM/Lpz21N/ytQXmSRVROyoCt86lmBqB1lq/CUHkjhGSkOdbGxB8BBh5PwtfNkFsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJf+yB3xCoeTfkZZ9YBSbF/uMyYxIiJtso+9TZxGeL0=;
 b=jJFsWOc+Tp1Ik42Gg9ylkQ6YZvrg5b4eQpsnq2cTu4R9c7FjAvIFK2P5Nc2lacXlYAeILHbt0dD0S2MDxlVoobPrh0BXj24ltl3uo1fj7hyEAtp73xQ7XsKYQpHm4Y1Pea0PUYkDKEieQF2drmSo+MPhSklz4EcK6gcDwzxkgNM=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VI1PR04MB7182.eurprd04.prod.outlook.com (2603:10a6:800:121::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Tue, 14 Sep
 2021 14:44:25 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::e948:b382:34fc:c923]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::e948:b382:34fc:c923%7]) with mapi id 15.20.4500.018; Tue, 14 Sep 2021
 14:44:25 +0000
From:   laurentiu.tudor@nxp.com
To:     andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jon@solid-run.com, lorenzo.pieralisi@arm.com,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH v2] software node: balance refcount for managed sw nodes
Date:   Tue, 14 Sep 2021 17:44:09 +0300
Message-Id: <20210914144409.32626-1-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0056.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::6) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-101.ea.freescale.net (92.120.5.2) by FR0P281CA0056.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:49::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.9 via Frontend Transport; Tue, 14 Sep 2021 14:44:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31df69a0-094b-47ba-9f0f-08d9778e2578
X-MS-TrafficTypeDiagnostic: VI1PR04MB7182:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB71824C02E207416B13F6546AECDA9@VI1PR04MB7182.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7wYJbTciF8R3htjYNFVEwy6HZKyr38IAKkSGZa3QMNdhC/ahITz9wqiHPcuhzwz5SOZRtlVd15qOopA2oHv7KV7FjqkgVBmBL+au4SlQZx+7miUd1BGwAF+W/oh8aQgZ0aIYEUh5oyogeKxTT6xR5ncRaWLOhSfXGKyDcbTIqiDTrcDsVcPPGrWENtfic5beInPLc6aHn3Ilw/+i6oi83Y+hc/oEWYlu2fuG8jx7I/7QnrZ26Xc6mm0kkFHCrScAarn/hygRUvIuq/NveFu3kkBM+PpH1B2ADHNvsbg3JBFC5MIL9TKQgDDziZo4ncSkxaf32mut9KWZeT/+0+nHzfIYjFpwnnoFi54FrBfEPivsQ10OJk7quwI2MwamBOANWGOTi9ANOwIErNRFAsYxjq9x5uGyUFo2ze1Xdu6i/Qlk+vuhE97baFPK5EiOjZRhQWY+7DL61NmphAtDGQ5ScfoYlLGkaa5+YIdyI0OGfL9gDkhERCLT6HEuizFkpcC8eGohxTM2+yXHGdyKK/5ueDEFlPJB4uvwT44bue5NZVF0yTMaCmrR3fmBW3A/as0+xjrb/aY1SzkiSUrYG1G/RQB5GdRerEuEOoy47/RbY9btzwxdZFC1HeD/o6kdYK7WpV2zjoqFpplFUBhogFRpfRyD4o/UbuiYcGs1aUfBDuFxdAdO1hxUhBz6hn078JnLxudcDApGukL33kEiWUmMvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(396003)(39860400002)(346002)(956004)(2616005)(186003)(9686003)(1076003)(86362001)(5660300002)(8936002)(38350700002)(38100700002)(478600001)(6506007)(26005)(6486002)(8676002)(4326008)(2906002)(66476007)(66556008)(52116002)(36756003)(66946007)(6512007)(316002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xhckf8H/vnE6ZaHxr4/GHRPPTwpevcI5jhNH/sI+ecXhDwvfdfkiY/Zfrj9C?=
 =?us-ascii?Q?OXlSsAAVBFNFlYDTfwnSupWGDfN83SUOk0GQOCUlJxyo6xR33StCRoyuoFeX?=
 =?us-ascii?Q?HMVSvNYuFJj2rscoXXyZt1tdttIdulq46CLHcEszp/RvTxxLy0Gz5TTHwDt/?=
 =?us-ascii?Q?y7JCodoICsExVLICZEL04vaoDA6qCxcwYx5XENk9l2HDkSl+8AlwgQ/3XSHY?=
 =?us-ascii?Q?2MSJtlLBUwz1ZHdCDwi1rsooUXb67jYlDZerfuSuGuqCgCmAKdp0Ttkkn96T?=
 =?us-ascii?Q?Oj0yUr8hjDO0hSbBT2qyXJC6e431o3cPlAq1eqQ+j/i0sTujfvJ6w55uusBO?=
 =?us-ascii?Q?EHhaup187dx7IO4fjcebRVE1r/yscY7/uMxHjeScq5t/xaI6n85BfoGCALBQ?=
 =?us-ascii?Q?eQEwKi+xGtFQNQIKs7cC70QPRT+FxOZg90uepf1yFKq/Jintqr/s/q1MYAsu?=
 =?us-ascii?Q?/RogMfUvwTtKsodOYMwk1aU5/WdopSuiokaaJdpBZbTCjT6nP+i6kLy2mD8O?=
 =?us-ascii?Q?1WyNvfHXP8EJHX2Nv9xlWH6Fr7Ex90DJqXQgsvoK9oSutxvq+pYGJRC9ntuJ?=
 =?us-ascii?Q?A/1aI0SQSB18UFZwJYb4nSPpXmNeX0GslIZUW/BMQCmiFklAlsQQXt25Ry3Y?=
 =?us-ascii?Q?ZaTraUr8L8cYjFR0cGs+9mn4A5GuSNzpeiQ0mP4zW1FRimc2ucUTN9/xwLIy?=
 =?us-ascii?Q?EqpKeoxMkj9+gI7A24op8iLmVUJ8mBKtdrMSw0Fpn8Xyfa3GiiKQ5J8T9sP/?=
 =?us-ascii?Q?l2tuSVE67B6qou55EnoGnqujotkCYQyIyMXEpL9yomK4ugLpz3Z27bVKCPdj?=
 =?us-ascii?Q?idwdFBlf9TN4rbsqblt/ZkPQqXsfq2oehsSJ6PXmFaRnXuBIVp87oHS7ECMj?=
 =?us-ascii?Q?NpxXRlHxy5N0zZIHOg2rfoZOAd7Zir4TlCrjR40vyNF798ODvNs1tj+dn/kb?=
 =?us-ascii?Q?ohQFl0fRvzymm5SQnTsEFiqWdZppKal0hr2O/88s0a0aBfz5Td9Ce30LW0VX?=
 =?us-ascii?Q?Z01xDwrpsQPsWP5aV6jjxc9F8tigOq6cVeLSF/QgawnuWg4G71yPDm+UqjtN?=
 =?us-ascii?Q?EB1ODgdKndilduGcuPP43Xbj3oIYl5KKCN2igGE91FuxcFTSwEEQvYIgK2x2?=
 =?us-ascii?Q?3xb2sMiMdYzifL6nV/Cx49vNpoonjWEn+VHulDppBUXItPPoXfuDGPoZWbok?=
 =?us-ascii?Q?RAg5YvvVTGBH7dsMMWhX1oCgjnhx52SjSGlaCJjSDLdaVgYm5xeVagdf43Wc?=
 =?us-ascii?Q?IZDZmqm2wEDkWNACzjpCJ0m8XxH8twrVJ6ZDjrsuP4uyz9cl1h0NiOohVqat?=
 =?us-ascii?Q?JdT0WdlEe1RHoRly4nfZOZFt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31df69a0-094b-47ba-9f0f-08d9778e2578
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 14:44:25.0377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QudEHJBneFZeNBxuKUDf+joTB+On8KYjOY+cYuKtL04gHGzAW0uaLJdeVohJno7AWN25AOZ3eDI3A07jBj8DQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7182
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
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
Changes since v1:
 - added Heikki's Reviewed-by: (Thanks!)

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

