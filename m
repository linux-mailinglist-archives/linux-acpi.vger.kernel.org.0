Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F66723438
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Jun 2023 02:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbjFFA76 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Jun 2023 20:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbjFFA76 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Jun 2023 20:59:58 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35A2EA
        for <linux-acpi@vger.kernel.org>; Mon,  5 Jun 2023 17:59:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHOwqa20oJz0Uis1XzLkCLvN5hbRcPZQE0VnlE2gjovaIFhTSIQX2jZYt7Dq7bAmb6GynKKBYcDkf4mrpKA4dc0k7kYsR7xQyxeoUhvKKhIRmrUcLYxz0FZVw3HfQFTyoPWEm6gft3E9vS0dClpH3txDCL3V5G78oHtqO6dNSj5XolDYmokPkThuPT51KR9m4kCndIrWp4FJ+1fY+lCM/DKntmTNzHMSScWTNOxnqKQkfAAKMpRQ4lIA9y5VmiJOWPjZsQ37TIT6A5XMUwp/UeezQWGRDc10hS0bCb7D3piHh/jotZto/ZqxCkBI2P9UrQSxFj7ya9ZbQkBW3YWuHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8diz4XTS7ftFZVs8zPgjZwLv6G8O1Qh/M2aGohNqR1c=;
 b=KGCWyniE7OoC7nfvoyF8OLBncSu+Ma2PcfvV9rbd0zcHhZAhXqP5W7xjhXYo17qjoqBpsvYBa80iGw+kDDm7VIQll+kzo8UQvrVmqfUs9j3qlFOOHFcF10MUU6EPMKZ71kr8HKdUotHyDlpHK9UpEE7q6dHiuXuPsW5PjLaONv5D12DAquSct0Ics/cy9k75/lAb+6HYCEFIaqcdKCev/cuje+dkxeROJNj3TJMPwKgJ79Nkd/ILuSGufu8x1E4L9eUQV1IG2UyZ+/8ZifAzJkAcUnuuRCWvxAu0K9hsuejSajKrdxNUCffwsSiZ20/SlK1fVsSvAtGTViiPm0lP2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8diz4XTS7ftFZVs8zPgjZwLv6G8O1Qh/M2aGohNqR1c=;
 b=GGCL8NBK4hJ7XVQXrAL273E/gEZNSVbOK9G/Bloim/OHdwgJLtkCJ8MMHn/s96rCIIKrUdqkklUJA0uy96JtOIChqjapvhIkJP2GmFEZ7D+EpOkacZeuVuAAVNbjfx/ZOV9+dVsnfKfKTg7kfvx5IvtKNZrKvFTZzjGCx+ZR3eckdnRgzEV9GXJUG9JGeSRBFTQiegcnt5LJS9mix2Jj+axj6NKXdOt9hRcqnm7BfNmrBhhOr0ymJTjHPEPg+gidrtFIfCofHYem1hkfDcs4ZKLKsC/Uh0uy+cFaf5KwOfCPXDzF5/c1P+a7QhZUcAOGNi1GSzJtQRTFZQHdrUcNKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB7765.namprd12.prod.outlook.com (2603:10b6:8:102::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 00:59:52 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6455.028; Tue, 6 Jun 2023
 00:59:51 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v3 02/10] iommu: Use iommu_group_ref_get/put() for dev->iommu_group
Date:   Mon,  5 Jun 2023 21:59:40 -0300
Message-Id: <2-v3-328044aa278c+45e49-iommu_probe_jgg@nvidia.com>
In-Reply-To: <0-v3-328044aa278c+45e49-iommu_probe_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0017.namprd10.prod.outlook.com
 (2603:10b6:a03:255::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c58df7e-c9ad-45ad-3d5d-08db66295513
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ej+C2E37dO+8Q9H1pL/SZwRFbYx5SPAnwgikkSNIm3VQJUaDR8+46MdqBHQFMAfdoyXZ690qr1PHtz1vngmiqmW3tfp1oKvXKCLSfyguYCOgivdSQP86QZ4l+IUJZnYqOEqwVxNfqFMbMUnk+EisP/m0mULo6xTLOfBqls7MqI/uxwZeNgipHicVRcr9+RiuzdeeM+4o+MT3tJOOKrBI2ieq8VE9ejHVeL5us3FjzjTRflKws75g2jUcvOhSH0Nk9b1emq2lCzPmKVAQO58NOxizxUTI0eKCdpEIvpcnp7JT8uOs8lp1yMy3mc8XdshT4aB0iX2iQX43bH28o+GZc+ZL57n9BzGbb/3aFHeFhXb7RKHNJF2F+y9x7viLLSR9njCrWCSXMhlxvO/mGPOxxR1xEWDiiRR09KCqFZ7z+obg7V7icUYpMD+KOXWqd1n7ERzNx8y6FB4Bk7TWamvpL+0zGQvbn7bQft+H+X85/skwHYw2HijZpzGltJOuOg+3PL1A5wuO1x/T5YzfOXlZcMTyQzDhjo0366nTDY5DNWld3u1zKFkpf4lb7gzV/lJNnzTyuA8Alrl9QmJRRkT6iggplILiv1kCWnBf5jP56/o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199021)(54906003)(66946007)(110136005)(478600001)(8936002)(8676002)(38100700002)(66476007)(316002)(41300700001)(66556008)(4326008)(2616005)(186003)(6486002)(6666004)(83380400001)(26005)(6512007)(6506007)(7416002)(86362001)(5660300002)(4744005)(2906002)(36756003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y7dMRSZnJeoMFXPIVTtTdcBewCkwKUJx5xpKWvss4+lZIZYrBUq4CIomBWd2?=
 =?us-ascii?Q?2pZIPDe5eG76ZxGUO92+A4ZkFVwjozfTCFxBFziELLiOqGrPMVDUhOhRYd4l?=
 =?us-ascii?Q?g3QOoTjK9AN6v3U8G1ElpucAD5Xf1F4Gm8EEnW1ngPdE5S0VJWlzmoGZXzVz?=
 =?us-ascii?Q?Qw9CMwO2f+aH427x4RixUhvtR7rvfqXyUTmMNO/j8MBsYut1jkgr+VpIvOSj?=
 =?us-ascii?Q?KKXnk3JhY9l9TY5j+dmQ+HE6S1MvS1wkFo7z5ZFK+1sV5C06wB4SUk3m3S7b?=
 =?us-ascii?Q?xlm2Wc2/MNfK+FczLpwND0DQxH36ReZUHDENuDCMEiACFI9+wNNfj8vkbLHB?=
 =?us-ascii?Q?yw60Zv8ashcurtJT1txGA2lpTeAMTbnO4tybn7Z6SzY16oGBx6VQHtTQO9Nb?=
 =?us-ascii?Q?5kht76cxTAB5ZI3KWTfO0vcplXx7c1AA9KHa8OhwfykxelcCN6RJi54RkY1y?=
 =?us-ascii?Q?gjr5QKSOtkiMnz9LmTeAbp5qcl1QUYyn/8YqIxZTTgoKPBnVSoXvR4JlIRCS?=
 =?us-ascii?Q?YoFcV9hgH4NHuan6EwUtrq1OEshjvv4mTbEMCeNYXvyrLL5ORnyKWZFEXJ+P?=
 =?us-ascii?Q?KPKpVDctkBgO7OZd/QH+65stNtEgZU+AFh+5bEvCa0RCsVyDKob0Nq63VOWJ?=
 =?us-ascii?Q?ERBuryux75dQ7gHX6ta06XXZXXQ1tmDLHNxUTCv1WMCwnZ5h1HOjNPsg/dqX?=
 =?us-ascii?Q?P1aDUIUGiLfzV/kzicooa1m1Dhb9lirK4AeqjJo01qyF/rPh5Fku3+ttvCQS?=
 =?us-ascii?Q?7eE+zEjqIIsc3YmLkfTIb0zmXWzJAdA3XZPEbRRjQSc7IyCipbrIRdrlZJh9?=
 =?us-ascii?Q?dotp/EqQka+b78QwETJl1Cx7/BZihrwHv5k94blKWgtf4DnDt6liuTilWlLp?=
 =?us-ascii?Q?l/nuK9/FUVjZhKap04jdLysPuDlG0ty3+TrDcbBs1VpGyFCAtyBKCDnYU5H0?=
 =?us-ascii?Q?TWyOe4PDfjbXheA2EaS9f3Q0n/SDjCQd//KqinvZj+4p1HFA26IlD3Fb5xer?=
 =?us-ascii?Q?geoqCu52T/ZK7TKAK9QI6i3iHvsvaZmm8TgpfwsKz3gQ59XkX9uPIOCgm1V7?=
 =?us-ascii?Q?/gBadNplb4bwtpF4noJWF3FOOPvuv8Mj4cUcwShP5fdfUkKRAn4+GzSYXU+h?=
 =?us-ascii?Q?T+nWJZhEnV9nh4jc4fXSQaQx33/KiWgJnLA6TGjUleEsSuxUqxi8KrQGVioe?=
 =?us-ascii?Q?GaXpR6dS9xM0/+7KasZhZoZZas3meNwPF8H/Yk500h4QMpXlhmtkGQ5/NhdM?=
 =?us-ascii?Q?i5nBQNCVN5TjLRzRU49j1pvGdOYJ++O63CfoaBynS7WtGS7hMSQkNY70Zn+6?=
 =?us-ascii?Q?9AE3nn6XyexBSZs7ehBUGIreJd1zew/IZqNp19K75o7RBZtr//RaV3aSU0+C?=
 =?us-ascii?Q?BRQ6Ib586dqpse99ZH+I7j95uAR6NfvPOsQILXH/O7aOVVQ9c34eEXMLWoku?=
 =?us-ascii?Q?eDRbJb2ZpHCs8N0cC5+4t1/c+3PzeNGyAv9gtbZ5w1q0kbvuItIEMy0+jYGW?=
 =?us-ascii?Q?hl9d+DLAeicdQ6yfgpnMs+hn5SkG0IaxVfGBe08WReKsdkw98pdxYxhnB4NS?=
 =?us-ascii?Q?3nMAutNW3GKM3kcqU67n3724X3sbT5qRjCLfiwqN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c58df7e-c9ad-45ad-3d5d-08db66295513
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 00:59:51.0893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p3sQdkeo24Oy+n4frliaebepcSwlvbNcMZ+v/6J0ZdNYeIOQd4IQZtj9bYgapXTD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7765
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

No reason to open code this, use the proper helper functions.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8e77e12a180116..aa162b48c7dc64 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -500,7 +500,7 @@ static void __iommu_group_release_device(struct iommu_group *group,
 	kfree(grp_dev->name);
 	kfree(grp_dev);
 	dev->iommu_group = NULL;
-	kobject_put(group->devices_kobj);
+	iommu_group_put(group);
 }
 
 static void iommu_release_device(struct device *dev)
@@ -1067,8 +1067,7 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 		goto err_free_name;
 	}
 
-	kobject_get(group->devices_kobj);
-
+	iommu_group_ref_get(group);
 	dev->iommu_group = group;
 
 	mutex_lock(&group->mutex);
-- 
2.40.1

