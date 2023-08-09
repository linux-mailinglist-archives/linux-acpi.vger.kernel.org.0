Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D157762C3
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Aug 2023 16:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbjHIOn6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Aug 2023 10:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbjHIOny (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Aug 2023 10:43:54 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B04F1FD8
        for <linux-acpi@vger.kernel.org>; Wed,  9 Aug 2023 07:43:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cfUKNCW3s2aENZUTJ6swI7fgaNMh4BJCCYRa/jCjQHVLtB/WeDZakouCTYwfWQ3H0GI5pIgHpXMJGTVEKSH6h9zBLZ4+m6WKn7vCbAAZZvg/6YVe4/AHvO/y0AbU+qR6JAujSlRC/dGWrRgaEQy+74OqFqVzH9Lzb5HPd60ehCnB04qqVL8NoTNbuMk8lDhsgAUG9eKritHd27akAiNXEQZX1PKnHv01c1HOzfKx1SVk4aUVku4PRkvFa3ZrZq47Z2+HAPzner99ipPGeJ2M/hqirbeSJqUKbQmPcwWMxSmV28GmCXuyl1vDE9WiOlSSr4jxNApbAG+83+oBFJq3rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tt2D4d1CSRX5YsRlZG6MJL8qQYqbqS4GASb829ty3o=;
 b=iiuxYqfdq4s+WHtsR06gmgb7dIsLQiXe2iD4uTgObcGdMnvbNO3RQt+KSUysIoEgvYokiveE80dGASFDZzmSRbOEPO2SE1HHovgbHLD90aa0Wz9xl2wDy0TRMSBBQodzj62s+L2X/FU3MMS2DrvxHDr0ocFRj1njMA7eYf4Ssh97swPxVl9fz/KTe61qxt376y4MmBhOz14gStI4qzENjP0dPeLcLGFiuQ6vT/rahndOfIV79YV3+89o5BQlY7R/8RbKU/8DPqxsnnxkt4AJbgDoWbs933O8ZmGUn4I7onxGw1AMyQS8oHB3a+pSg0KbBBZgN+t9Xblhcjp9hDilUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tt2D4d1CSRX5YsRlZG6MJL8qQYqbqS4GASb829ty3o=;
 b=Hfxbikl440xPzsfcf2f0nuV4t1dyFEjArycsMn74GFClOBBqfywzjE6KSEOID3HXfsPOXPW80T5zQIWO3irXxTI7gb9mJ2ojcp4Gf/3yfPKOwUQHaSO49KQ0SuxvRbeWaZqwr5RxIrEtQAWgjmL/CZC4cIreWfE1uARpSgsvktqDWnzv5unhMQK57jDXi0rFik2bVLXJKZwKd+VBzLowP1Hxy2YebZxCKc6q8+Sdgv40A6YHsO+70hUbS9KcdoVR5zidotAtEp4qbqWxXbcNDpZdTE1LVUC/uA3wKzP6zexXNbT+FswtVtwYPvv1pC1WAZGt8bdtzBuPHb/6inVbbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB5059.namprd12.prod.outlook.com (2603:10b6:610:e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 14:43:51 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 14:43:51 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Subject: [PATCH v2 0/4] Fix device_lock deadlock on two probe() paths
Date:   Wed,  9 Aug 2023 11:43:46 -0300
Message-ID: <0-v2-d2762acaf50a+16d-iommu_group_locking2_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0043.namprd15.prod.outlook.com
 (2603:10b6:208:237::12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB5059:EE_
X-MS-Office365-Filtering-Correlation-Id: 024ae5ca-a701-4942-a1df-08db98e70c3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NpYCKmJUhNk2Bsa+uXrq0xZurcGdcqkbbpsAyE+FVGmLR43ntN9r/FkK6OJiOxYq13Q3PrJYYJ0H272MECAg/2nWdjAI8sY9TJeBzPi3FV+s+wx0Wly9neeNP4XXIFgna32icRpNZG7xZT995aD1St5OZEpqgi7agbFoybJ3U7wbaKQFnkaIAFsZ9X+gpsukfNuver/YSIZAo0Z7labMiq5xSTpcbLFR+R4ZxeyPuh7R8i7ek40MXyQ1CMOaOWNYE0lHCuWJLnzVmPOJXyBWr2/S3+YxPJlNZlbJystvpSShu6+pZPiHZX1KzhecDZIJfaexWhVhTTtOa4jtMeuJgURXKd+cAxVDzn/PBgBYZmemWVqsXxKbHz1N0xrkw+b3+LjKJ8xXwjEmwwc8/ONMLkdajiMhmhN7G7k0SFa2T4IVEHD7ya/JCcxMmjvLmBZuTTG59mavDMNlcCykpFxvQoYWX3sB7FT+N6qjIw6X/2sozpuPrVzHHA5UVFTNYdMb4ZNpwk0pGVAhdCvx1hiGpWfMy8Nk8yKuxLXDoVQtlewIQRKYpsVxGAjts2sIRiRon1yQSW+gQfic/8SFow+eRzi/s6l4Ls14Aj7Fij+1aUrL9hJRknUi2wG+CGWRgtIN/kMSqA1RsXNZf5JV8d8q/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(451199021)(186006)(1800799006)(36756003)(110136005)(6666004)(478600001)(66556008)(66476007)(66946007)(54906003)(26005)(6506007)(6512007)(6486002)(4326008)(966005)(2906002)(41300700001)(7416002)(316002)(5660300002)(8936002)(8676002)(38100700002)(86362001)(83380400001)(2616005)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pUXFMXL2MnyIvE4A3ICtY3dPpv64WfAROxzI3r2DnzMhY3kjAr+2tMI9b8DU?=
 =?us-ascii?Q?3CjT2XBZPCVZcDSPzdJQJAGiMD1VFyl2qvvlFr9JNZ8BaWoyTYogOUXcojDB?=
 =?us-ascii?Q?/sRnnEyr/pz3u0P/77u9WzFcXlby5d7QcchCu/gfFEjEWrxSkDYrf5eOPrd7?=
 =?us-ascii?Q?+0pkP+OaXUQWBlMoJnO+nXfTe80gB/6iHeKpur39tDlOboSx8Kyt8+iexZr8?=
 =?us-ascii?Q?6JnpaiSq/jtqywSE2m3cJWuCeclOLQ7mRqsfGCXyPtInTdarOZd/NHoz7CVo?=
 =?us-ascii?Q?3Lxx6Nt59RfZM2etpcXdTtFNzxlqMSIFifUfeH3hb4PyiC7XxUyfKW6z1MKd?=
 =?us-ascii?Q?w4TnA8uovLnO4UtD9DzY2DD4g8K83Ra1qruDF2zivov/v319xT23u68K0e/t?=
 =?us-ascii?Q?0RSEqCZ4Mqppy5MySuk3cGhLT2aNRo7LuXR3lHkmz3iyMg475eK1Q0ugFZgb?=
 =?us-ascii?Q?RnWWrvjxN7TanUj+yPP7eZMtQKmOyoBNPMFNIfrbHUEYYMSYPZmlJIWIsN1K?=
 =?us-ascii?Q?2Q7MC53u8gWu6LL1Q+VA5tCYCOr9PZmg+MmCtymPty2M2Q6d/uk/toTSUmLo?=
 =?us-ascii?Q?Rbjw4W2kRxxxxMTQgNp616/T8xfZWls7VBoZXSG8JbOPaBYx1onogFkm+ycb?=
 =?us-ascii?Q?ARnbqfn6wvevXaoLpIIF4wYgNfxsTK3Pp+sTCiP+S2FJTYGUHYvWnwU3H1ZU?=
 =?us-ascii?Q?k26gS+Dkw30K+6d4NKICoTiKMJLiFSom8ii8B1QjDQlvRMuRpDVDBpqeJYCw?=
 =?us-ascii?Q?fh/Vdfx+UsfSaWk85U0qprkgqg4oqTZqipiZMcjgy3Z29wNiXp+1VkfH0JRL?=
 =?us-ascii?Q?T6BCYJCfLnYhQ71KvMKsxJrAeDvwiry/+tMs+zacYYjUJaTCqvK7K+jtLZbP?=
 =?us-ascii?Q?a8hpCBFiocmOPVCqXuu6Xak6gJF1LJSwIB/gRZSJim0QI9ebadEFbdLOLkfO?=
 =?us-ascii?Q?YR1qV0/aER0cvZru+HJ4/0Z0Gm8B2UrW+LAUBnPUpqGpQy9bwep1Av/Z3iDF?=
 =?us-ascii?Q?T72bx5Og5sM1aPflNdjRUhVolkSDTqkcrk58jPCCdKLmuKjsz5LlQzAoLGLT?=
 =?us-ascii?Q?zvDwNb0EzSNxDtGXGT+1SfRwqAu7u3lxCU0UcpDRc9PD6DkXITI+rDCeCyEa?=
 =?us-ascii?Q?8qgm9uD0mfxJZbpKWmlcjPEklb6xkJKCj8CDwQus/wAySCjjmsELceYjvLlX?=
 =?us-ascii?Q?2ZkmbilLoVNXRvKN28Hq/wdrF5vri2WuMr4OE2ddZwCc/Sbvkh2W5id8gJtb?=
 =?us-ascii?Q?nhlcRcyx5kKK49OYVV1nrUMQKaLudW/No7vXnOL6yNeyaEjshTsXrREQ/1f5?=
 =?us-ascii?Q?1t9fPRvMHNhmsvdvV9tO/HthHecAFy172aqNi2mGpNRFpiagP2oPTos4BBpR?=
 =?us-ascii?Q?O4OQ/u9VA75X8XkdUmszoXB/SCwe17jXe1ghIFZZSL4MgqGQJr7VmlHnVrb+?=
 =?us-ascii?Q?BZ46kUtYM/zPKvpGZxMIO9Yq4U4aRFDewNSpJYwF3wXsWF8QfZmVRk9LwAgO?=
 =?us-ascii?Q?pLuC9RzJctFdzVkSTrezqyMGC/+A/IUs3OYR8wXN8aLZZiTxY+qhRDOr+/1R?=
 =?us-ascii?Q?xC30bcImAwVnIrW8yt7oS7B9tdfDrrRE9qgQ91wM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 024ae5ca-a701-4942-a1df-08db98e70c3d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 14:43:51.4744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4OrE1cEG5XlHcPGlYT0RRJfTZT75zThJU6rYZBwsmktVW7l2+aZHU4KzAhLPlGed
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5059
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

I missed two paths where __iommu_probe_device() can be called while
already holding the device_lock() for the device that is to be probed.

This causes a deadlock because __iommu_probe_device() will attempt to
re-acquire the lock.

Organize things so that these two paths can re-use the existing already
held device_lock by marking the call chains based on if the lock is held
or not.

Also the order of iommu_init_device() was not correct for
generic_single_device_group()

v2:
 - New patch to correct the order of setting iommu_dev during
   iommu_init_device()
 - Spelling fixes
 - Simply block probing the iommu device itself instead of trying to do it
v1: https://lore.kernel.org/r/0-v1-8612b9ef48da+333-iommu_group_locking2_jgg@nvidia.com

Jason Gunthorpe (4):
  iommu: Provide iommu_probe_device_locked()
  iommu: Pass in the iommu_device to probe for in bus_iommu_probe()
  iommu: Do not attempt to re-lock the iommu device when probing
  iommu: dev->iommu->iommu_dev must be set before ops->device_group()

 drivers/acpi/scan.c        |  5 +--
 drivers/iommu/iommu.c      | 65 +++++++++++++++++++++++++++-----------
 drivers/iommu/of_iommu.c   |  2 +-
 drivers/iommu/omap-iommu.c | 12 +++++--
 include/linux/iommu.h      |  6 +++-
 5 files changed, 65 insertions(+), 25 deletions(-)


base-commit: 8d3740021d5d461e1ec4c17fc5625b9b4237c2f8
-- 
2.41.0

