Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72063723439
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Jun 2023 03:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjFFBAA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Jun 2023 21:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbjFFA76 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Jun 2023 20:59:58 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C4C102
        for <linux-acpi@vger.kernel.org>; Mon,  5 Jun 2023 17:59:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pzk5s1YFzc5gIg9q+KpXd+78b1XhegA7yBls6V7FOiZl5bz4FJlW7zuvH93GXXcKzxySzB9KKBg2TqC9gdo5zR0RIrpbecrb7EBHY1nPCyB3oha6RGVbgBru5OOCeCS+wd94YbLv2aqzrVrxepxPjSlwqwA6eIdfUU7CKPOmDP6QreKpaKZ0EvOxIDYTUbj9QlwTJL5AjG44Wp7f/b+hd74amIlUXlrRV0NSXSL2bKb92kvDSxQY9y1CrTE3JGMnEnOSjqpVHXCsxTHwVPi3wouJZ9HcbMTGRRS04U5BwFU+LePdgEgt0yeIyZcRegBaEm+nbzqPHJ7ebyotx2W9BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cN4FKCzIl52sxplBuXyvhf6+IZ4/+nL+u5q0AgSWZ5c=;
 b=BwQA4NPUlv+vWDZnLnhWMALYzQ0ur1RXHA/iUr2N2BW7D4zqSPywBY45uX52vui9m+PCmAK117jq5vqnt2TD9YOocFEA3rr32SB9xxEHvsyw7nwIhTeUyfY/7BJzmWhwNnWZziS+KcCRvQg0oWFj42m7F8m3/9t1v0kaqaKICQgGqXpe1SvuiPVz7gRewiPt9LxwcWa+Il6i90CtLfpk5NXPQ3LUXOc4epToulV67FfB9JgbDxjOGOgGXNUqL+hd/usG5qMEHrtl7Mf0yA7+K82hjFm17edatAXVHXFCJNMqWwTju3AC9HEPSKeahA6NCEwo46Vhj7GajYG0gCe3UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cN4FKCzIl52sxplBuXyvhf6+IZ4/+nL+u5q0AgSWZ5c=;
 b=YV2T2ZdrryFtow//j4TcR50sUkec40xBUYn6yjdJp7rd8fPq91ziD7NOQI+6BpEIfnC7p9RrT3d96H7fm8o0RiD8ORmZdkWTx0IUWw4x5AaZMzXhYrp+TRRWt8jkV9EE1PgtXiDHdgLpFW4RkM9m9AuKjwuI3gWKGzrsJXrgik9o1YlBYXN99cDjINcj//11k1ck8jIDeM6CksVfq00KE/Q9hgcWcdZGsmUGeKzzxKATy/NF0hpt3jHymZgYR4WaN8G6L0RUkaGfQ30Qrjv4zIn0Knp4OwL1JpcScwTexP/m9mHyQUfDVyFXlTiGCOKuSyiWOv/5qHj8JJRDRjrXBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH2PR12MB4085.namprd12.prod.outlook.com (2603:10b6:610:79::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 00:59:53 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6455.028; Tue, 6 Jun 2023
 00:59:52 +0000
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
Subject: [PATCH v3 00/10] Consolidate the probe_device path
Date:   Mon,  5 Jun 2023 21:59:38 -0300
Message-Id: <0-v3-328044aa278c+45e49-iommu_probe_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0010.namprd10.prod.outlook.com
 (2603:10b6:a03:255::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH2PR12MB4085:EE_
X-MS-Office365-Filtering-Correlation-Id: d9ef497a-c8bb-4c05-b178-08db66295528
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZcHv/2owIeR60t6JsudCZ7r1X4KGzjNiqY8iEoWzTzUfClzCRiGqdToCi1tk9EVTfN8S4uJM7PVk8FqjbOaJEaqcYg1aEKabwQDije/2oknVYkL7LRQDLm7dLLJ4ATkx6MnAJKye09ShJHGbVXwcUVG2vAP6UWn7xssZqwbGLNYTHadqzV1BdUiP3KcwItMEVCk6EuSziBxs+SVSJvzLrEGVydUukGqUtL/+8/79b4vPE9jTa2c8aWduruvSDL6YVz8tNuL9v8WJCsonH0WrlIyVYHWY6C1IIPIwUadjvYoK48WApEj8jxJworZg4Ai6eAlhunz9nTuRV9LAB0rUVyL6uH4Xp1yCz987vY5Ajbei8LTGabpegxE/GsXvNtLQ8GhlQH7vNWzZepQG1+fzRB3PKONH8pqgEfmQRTJm+EDvsnhUSGpI31vh+PDyZKXj+ZmH7zXi3QlS7z2xzWePGSGWuvvk3PF+L7OmyqMHdRS8UFLbizuXmuscwQzRiLrpYazO8h6/0ReYfb/NkuztO9G/T5tmCDSxzvrBMWf/edkaQ1NMTOiTA75yNXeoFTV3nv1Zo3w634NXQcMFwjSHP6kaIZifgkCsATZyjRuuYKPo9nhYlLz/D2aS1XMeuGcE6+ooXFDo6LvZRSHNFziKUVqpBLobD/1mAl9VW7tWShYoTClT7V6/o0kjwANjWEC5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(451199021)(36756003)(110136005)(54906003)(2906002)(478600001)(86362001)(38100700002)(7416002)(41300700001)(8936002)(8676002)(5660300002)(316002)(4326008)(66556008)(66946007)(66476007)(83380400001)(6506007)(2616005)(6512007)(26005)(186003)(6486002)(966005)(6666004)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7YcTQMIe4NRvD9j2wv1XSCXSrX8XZjZpP26jLCLyYJuLnrm8iA8hkisg7MtI?=
 =?us-ascii?Q?d0HIIYVl1T4AS/RictD/NbjSLUdIio8fbfanA6VPUzEAQELTfCxhiC+foC88?=
 =?us-ascii?Q?XUbMBUQCBC4RF0mODUvw+NUjk/hgCpQ+va2veQYjjGDsMYvo3h0z1EneDNUe?=
 =?us-ascii?Q?VSPwwCYbMDknMTLq8bmXd20Pm8V5TrGKUxeK65uErRq3AfrY57ypYqBXcu0D?=
 =?us-ascii?Q?9C6xmlvYc3g3ryu6f/Ccjzr/n7C9YnXcGIJtWv5vRgzfk0JyGm66I9FPXq8/?=
 =?us-ascii?Q?m0HQXQRnTn6AADN25yPtB6oskZqykI1zarHKHX8SI9g5aZYNF9X19AnM9fMC?=
 =?us-ascii?Q?uZ0CdBrWTHV3zUH5Jw6cO6bwiivAEj8FjlaTupYuSRC7vbuUB+tu+nCHVQea?=
 =?us-ascii?Q?dbje7UIc2ksloVUQjfc+2an9pzjIrj8SFLMEG95sJBZTyVVrjaHRWYsjd6xI?=
 =?us-ascii?Q?k8a8ZkMVc0zjXa+KKABiwv3+cj5fx/BftQTKQY70UCf4lg+RI0K6JV46zi3Z?=
 =?us-ascii?Q?kAvk4QchVzpqk7wueIF4Wq3v7Vj9wdwREHEfn8cmT/Q/YAaYVs8kpmGjWoJG?=
 =?us-ascii?Q?yF0zTYD8eBuL1uZNDQRNpWRPMMJkS39GCthPecK9fhjLygAnVa1RNeAYdJw5?=
 =?us-ascii?Q?gCGKzP93Kh9DyifMV85TCMFejw/B+nwexYcu8lh32DRACI7V/RX5HLBGNq31?=
 =?us-ascii?Q?D/y2zqEkixOj5/M2KAdoqP3Udx4+wuRHQ8fxyT3UsHA6BmU5x0A3AL09V/Uf?=
 =?us-ascii?Q?AK/45nsfZaDTRRZX84zz/4HFRne6r3FJ5OUUr/lSvmdApJtmWjcHXAK6k8v6?=
 =?us-ascii?Q?1z2IFmnyvod9uk+3pYI6CLCEHLHdDAoGJ9MOWVnfczhrQhhqB24cQke7gi24?=
 =?us-ascii?Q?LTZPe+AGj5EAL+nHtEY7xx7TEzTD1d7yZi42QGYO9WCVp8P5fAtSmrulm7kA?=
 =?us-ascii?Q?KdjfApVmx50C5w/0DV7BC+WQ2ITq/35alNoeiRXnHtjbqlnVIjuFDYU87m07?=
 =?us-ascii?Q?y3I2y7qQgIG7KOZfHDXj0QcvANEFheDkk5dV/ZgeTT3EXKo3AeYeboWI02D9?=
 =?us-ascii?Q?mCmrCn5EajdbxZ05j9IlkS8M7DmrHa3/Mty52uM7nu386FK1li3CcrO5YkjC?=
 =?us-ascii?Q?t6QDlAdtG4VCbUFzsZNqdAxDDt6wtbRs+lkGcYncrHegVbRcQKBk3SbA6/Vf?=
 =?us-ascii?Q?2ZvyIvfhk9YtydLk+vcC7h829HYXOEKQh+7lZQ9mnCIwvUw4Oft96L2ktYm8?=
 =?us-ascii?Q?odjoY2QR+kU0VFrnPIo0dDoVi11ObovpE3r2/fWiZT+DE6ei+KZ+qfm50kkR?=
 =?us-ascii?Q?GPn6n/j0PFn7PYcl5LfbS4YbEpxvr/plYv+GpPgVsxb/cYykOBSlkjm/1JC7?=
 =?us-ascii?Q?Jw4gENQ5nTRHdxXNGAHpijjY/IsbZV6joCdJ8TopxF/V/6l0/HJ9GImWzt95?=
 =?us-ascii?Q?+/ULyx5WOoyNNiQ/pMWwc0ea3XRGnaL6izzceJ2pzIyAXeBDkvXJz7MO5w1K?=
 =?us-ascii?Q?aREAaX0ZD6nfs5Pn8deDgWYljVvuru9xJu/LXQY5HgshCqIsoRh+MyIjZ/TG?=
 =?us-ascii?Q?MqYa07ai7ai+xFGO3Ibew2ppbX5Ncg7H87dR6QPm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ef497a-c8bb-4c05-b178-08db66295528
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 00:59:51.2463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FC2c29b6gCVfw5JoXvTrW+wM2Zbg7Qkz7ct+kQJOmrhgJrWaaZRWxCb+9hXspJ3T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4085
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

Now that the domain allocation path is less duplicated we can tackle the
probe_device path. Details of this are spread across several functions,
broadly move most of the code into __iommu_probe_device() and organize it
more strictly in terms of paired do/undo functions.

Make the locking simpler by obtaining the group->mutex fewer times and
avoiding adding a half-initialized device to an initialized
group. Previously we would lock/unlock the group three times on these
paths.

This locking change is the primary point of the series, creating the
paired do/undo functions is a path to being able to organize the setup
code under a single lock and still have a logical, not duplicated, error
unwind.

The reorganizing is done with the idea that a following series will
consolidate all of the different places calling arm_iommu_create_mapping()
and iommu_setup_dma_ops() into the new consolidated probe path and get rid
of probe_finalize.

This is on github: https://github.com/jgunthorpe/linux/commits/iommu_probe

v3:
 - Rebase to Joerg's tree with both iommu_group_add/remove patchsets and
   the iommu_err_unwind series
 - Remove redundant lockdep_assert_held()
 - No functional change from v2
v2: https://lore.kernel.org/r/0-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com
 - Rebase to v6.4-rc2
 - Move the POWER cleanup to an independent -rc fix due to the iommu driver
   being merged
 - Update commit messages
 - Rename iommu_init_driver() to iommu_init_device()
 - Simplify __iommu_group_remove_device()
v1: https://lore.kernel.org/r/0-v1-8aecc628b904+2f42-iommu_probe_jgg@nvidia.com

Cc: Nicolin Chen <nicolinc@nvidia.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Jason Gunthorpe (10):
  iommu: Have __iommu_probe_device() check for already probed devices
  iommu: Use iommu_group_ref_get/put() for dev->iommu_group
  iommu: Inline iommu_group_get_for_dev() into __iommu_probe_device()
  iommu: Simplify the __iommu_group_remove_device() flow
  iommu: Add iommu_init/deinit_device() paired functions
  iommu: Move the iommu driver sysfs setup into
    iommu_init/deinit_device()
  iommu: Do not export iommu_device_link/unlink()
  iommu: Always destroy the iommu_group during iommu_release_device()
  iommu: Split iommu_group_add_device()
  iommu: Avoid locking/unlocking for iommu_probe_device()

 drivers/acpi/scan.c         |   2 +-
 drivers/iommu/intel/iommu.c |   7 -
 drivers/iommu/iommu-sysfs.c |   8 -
 drivers/iommu/iommu.c       | 461 ++++++++++++++++++------------------
 drivers/iommu/of_iommu.c    |   2 +-
 5 files changed, 238 insertions(+), 242 deletions(-)


base-commit: d11370bf64c57a3f50c68e2ee55e202ebdd396a2
-- 
2.40.1

