Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF8577628E
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Aug 2023 16:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjHIOdi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Aug 2023 10:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjHIOdi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Aug 2023 10:33:38 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A469170B
        for <linux-acpi@vger.kernel.org>; Wed,  9 Aug 2023 07:33:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YdCFYI/9UjVv/poSd9ry8y0VpZo27LOKuxROzU6RjWNhaGQe//w80HIMclPoovme1TS8RkqIEiX2EsmhfH6M+6ZcV8qogydIJZQraL9wbbHRyPfIxv690/DrIZB9ARSRh5Zl+Kzd+WtYMzJZNsh2eafKDs7qdPlYRdXayx0dwHlb+Mu6uHlW1/UVfE5q10R1rT/nTvg8YTaqP4uLutG7Of87KjDe6DlYESD9H7BZ+opV+OswCMrwbBsaHue/kXzWR1Lo2i7M+PuOyE6HTCmDRpKY4AWweQdWMavonkxIX1CV03gImNZzz+yaOwmmcLo1eC/h5/8k8SggSGzVNCPnBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DyzcLX+RJpDkm4FbXeuvRkPw7lTYnbqBaoAAkbR6lzM=;
 b=ZutlRYIiKedSajx02YAhju1fk8oUZ8OFAGt0sF9yaCZzvDFeXHI1UPccs1mbO0PpUcQT3LYBDlkfEzzD8nicr54kXRQaH9eoUkbrXj9vnOtt1+3GswWClS0riTBHddZwm8FOdt4P+3XKkaHHLu3ZCJAfACGMK/Da12zO0/HBjvUR1qFJnGa2KIDk168kKs+Ps9KPc4VfCYqo3bC0pQfXFchoHVXigBg3IFiVHpiBClw9yrTEsUHuT1B8Y6M4zlKZs/7ZhvEilMwZDwIu585rhYQLt8OMaqve+xK4QXdwir2nRlfX0Hy4OYXZWf/L4SHnE0/MoZhf3xCt2G0gjw6B/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DyzcLX+RJpDkm4FbXeuvRkPw7lTYnbqBaoAAkbR6lzM=;
 b=cJo8YVrjjsQ8P1aZQRngmdbiPPO4+PyJRQBfieRGf9fZyzJrIxXl8Pxs9rvAPOQPHmVQHN7wZ4A9nvDckzA6obfT0HBwN1GL3sWLxcD4VFYe8w6gzuMv0yCyzm2D1BgXgXe5O0p6cQI3wDuBs/EGv0tPysD2NBtNr7Lrx0xoWnXeWC3n7dyJgM2KWKpcj9NO4w/2JPTdLI0V1kWDlw1plyx9CBfDXkL0lB7bfo9UkvJRQEW5SdjSue/43ILIusrhPAevly5t8pRb1nnT1DeuiK7JI3IyTUatS97RrKBahxy8zaTkmDoLwE5s09+Y5PZGmObhdvfhK7oi4kTazPhBVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ0PR12MB7475.namprd12.prod.outlook.com (2603:10b6:a03:48d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 14:33:32 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 14:33:32 +0000
Date:   Wed, 9 Aug 2023 11:33:30 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>, Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH 3/3] iommu: Do not attempt to re-lock the iommu device
 when probing
Message-ID: <ZNOjuo9jYdSgUwZ5@nvidia.com>
References: <0-v1-8612b9ef48da+333-iommu_group_locking2_jgg@nvidia.com>
 <3-v1-8612b9ef48da+333-iommu_group_locking2_jgg@nvidia.com>
 <BN9PR11MB5276EA0632C6E65C83397B1A8C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <CGME20230809121601eucas1p150499eaa6e5fa6aa998385b3fba70a5a@eucas1p1.samsung.com>
 <ZNODeRzC+Rtkta1U@nvidia.com>
 <4208251b-8822-9376-cbe3-572f362720c5@samsung.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4208251b-8822-9376-cbe3-572f362720c5@samsung.com>
X-ClientProxiedBy: BL6PEPF00013E0B.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:10) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB7475:EE_
X-MS-Office365-Filtering-Correlation-Id: 74a5a748-3204-4adb-1cf1-08db98e59b1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wneidIh35MQOi3aKqxODkl3B10RGl+s7HWo4epR64RCyf19DM/mvIGPxE+MyYoYmiAiZYjHjxOuoLkEXhd8u1D4qFLs4ZDSSL2RqGbz/OW3l1OTb1xkGDcjT0KxLOEdYEI3C/h+24w8/dt+5EUG5b2OJniH8QMRCYOtoMaetlT4wZAW/9PKz5GVOXKSZ/LikKDbRu9IkT5gXf+4PkCrF/MHk4/AmUnOnYabso3Pe/3FsIQU0kNyUe0xJe/XeXxlvXlxIpovWNb7+Ar/HqrcWOwlmwda52+/rb8wZgJ3AkR536tOt1towBJ60Ng6LE2LPv774NcqM3APAGnNbFfMqIurg5OjdbTbuY4lAiaAEZ/w9l6+b6tRmOfvkpN8/c1Iki75c8/edKWBbLmuF9rgOCQNtL7CxR9ZoWCn0J6o4WE2hy09xVUMx1482Ys2DK/0B9oG+e9gJ0C2sPNeDEtD6txMlR+OJ2SA61CeJKctmA2ZQs90aic8OW3TH6qJ9V425Ve9LfpcFhHSyNJBKXZE/vXMBxMnmYb/kGpZhP8DWGLMuVM6MIM6cOOfHpxlJxSp+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(396003)(346002)(136003)(1800799006)(186006)(451199021)(6506007)(26005)(38100700002)(53546011)(6916009)(478600001)(7416002)(54906003)(5660300002)(8676002)(4326008)(8936002)(66556008)(66946007)(66476007)(316002)(6512007)(86362001)(41300700001)(6486002)(2616005)(36756003)(2906002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6+iq5M0u6kKyUTZM/tQoAz3GgIM6ale15BeXvIlobPcKA/BkDZsuzcvBIz+2?=
 =?us-ascii?Q?+tYGvlXTAcAZ50sWJV6X2kQw9l2krSOYb+gSp6UEvP1+PzK3NiTIgj048/Zq?=
 =?us-ascii?Q?gC6ZgmXGPnTP+mvKZEm+AF/TPGAm6l5QQurxgAtTWpyY1fftgkqm2jLEoveg?=
 =?us-ascii?Q?QQGJ9WshFPOLocjoLmdsCWeLqfDeLFmmylz4a8H2WUe4X+N3FaJH5Opv1AjY?=
 =?us-ascii?Q?/ET7DSAfjmUo/dR0uS9zn/cDFUVXwOHbB9WqU7ueYZdFbcOr1gMxqNPFmdt1?=
 =?us-ascii?Q?uiVl34mu3THqgv+pxjZazv4AYNNj8P78axBvISiL3IfYswJG8xRctg++4NCw?=
 =?us-ascii?Q?OkCwbr9KaStEa+Zk0AHPs8HOsUUxa3opZe3wTbYlr6Lo4GQsugl03saRjwov?=
 =?us-ascii?Q?6PftPn5XFeo/83VD/aspeVcsR/eDF4eoYt8YhXWrdjg/0nyApBoBQQpRx/Nf?=
 =?us-ascii?Q?Uwa8HHVm65vt0ydjbjQNADmAMg3DAK/yyOOu2qRRkZ25nSWfv6D60GuCJ0iv?=
 =?us-ascii?Q?46YJJzAVDKu9D9T4tRuxbAsoC6YAKVpeNNxsUTlWVi6LbHnwXffHBcccardg?=
 =?us-ascii?Q?zwRPNz/eP2cdMTpmPUSyBuqYlpegMolbMJz7CP05jx9loPoa4928ZotkR/8m?=
 =?us-ascii?Q?tcmHcqbnVykwH+3tVTzjhyDtZ/IiIZ8od28pRqdwKZkaLjdlFso2dCAScBIS?=
 =?us-ascii?Q?KIP3OYzK+SRKs/x5MYveMK/9GkL+dy/uXjd0Jh1bvOOkMUIgwrC2MHxOkgAG?=
 =?us-ascii?Q?rtbYX75Ov7XjjEg49JiC4GFyVordZaWKheRbJjEC1IJUL9jFPrxFpgYHM0Mt?=
 =?us-ascii?Q?XgPQAtUqo3Pi8WpUMcvnylSwrfERHleaObqOExEAIFUVczysLuyGwjwMUIp3?=
 =?us-ascii?Q?CDJMVmf6ularYWnBPXObUtzEebjvJE1rz2/td5RlTibGiiSrsBvwsy4bovMa?=
 =?us-ascii?Q?J7VWa7oWc/A55oJRrjuQ/BOg8HNqnfRFqiCYzvRnTYtfqlBwz6+sNZ+HFSd9?=
 =?us-ascii?Q?nYZpXf4yMsp4wmPQkUaw5Kug5cupT67nj01O9CLn3xcc4NYkvQ8qwDi5GNzM?=
 =?us-ascii?Q?L+g36W6piOWToSmRLPGh7mWVWcKFtCRoEwpvwsNzIFoRsoFzshhRNH/7ZPTj?=
 =?us-ascii?Q?ne2ZzClNR5k13JzVL+Rb6ktwh6bjyHFbBCGd9IzU+ynsE4x4geFRg+9Z9DwR?=
 =?us-ascii?Q?ek1JkO/hOnhTf+DsOTdsHLiOspyv/ksc7x9KTXXVaT6tzKOBP181neHn8tA/?=
 =?us-ascii?Q?Slmdy25Gr5wmcq2Y76BVy/GrY4huESwsouAPFWl/N1NpWCoFdibgEiq33pZ5?=
 =?us-ascii?Q?SvzTczoBeve+oBiBSrOd/LIo+pbOt12+9cAKO/vtVtBKh3Z7rDw+JL+QQepZ?=
 =?us-ascii?Q?5kqt4lJWWyFeyc+8YUU8Xt0W/zFazYdn7KhcY4mZEaxWUeMxvHMbBubwD3d6?=
 =?us-ascii?Q?xyMiiJ8CXAi52U20aqeua8fkcEowqTZBpZBCSfsebjSGWF3/dN6HhsqeGX/e?=
 =?us-ascii?Q?w0J5ExIH38obYBchzwqJjoQA9wKs3Vi96CwgQtAISNPX6/JA09udrucn9VPj?=
 =?us-ascii?Q?z+kreNVb+6d//wOSIt/K/4gJePxEp5wBAGSFPzLV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74a5a748-3204-4adb-1cf1-08db98e59b1e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 14:33:32.1716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gd1+q4PH9pbSTbYLfA5XIoCxWa3AAMWxgxZ6trAoP1RnZvpNoJ1HimRXLu6lTvXz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7475
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Aug 09, 2023 at 03:38:30PM +0200, Marek Szyprowski wrote:
> On 09.08.2023 14:15, Jason Gunthorpe wrote:
> > On Wed, Aug 09, 2023 at 04:01:42AM +0000, Tian, Kevin wrote:
> >>> From: Jason Gunthorpe <jgg@nvidia.com>
> >>> Sent: Wednesday, August 9, 2023 1:27 AM
> >>>
> >>> @@ -1800,11 +1801,18 @@ struct probe_iommu_args {
> >>>   static int probe_iommu_group(struct device *dev, void *data)
> >>>   {
> >>>   	struct probe_iommu_args *args = data;
> >>> +	bool need_lock;
> >>>   	int ret;
> >>>
> >>> -	device_lock(dev);
> >>> +	/* Probing the iommu itself is always done under the device_lock */
> >>> +	need_lock = !args->iommu || args->iommu->hwdev != dev;
> >>> +
> >> is !args->iommu a valid case?
> > Hmm, not any more, it used to happen in an earlier version
> >   
> >> btw probably a dumb question. Why do we continue to probe the
> >> iommu device itself instead of skipping it? The group is a concept
> >> for devices which require DMA protection from iommu instead of
> >> for the iommu device itself...
> > Yeah, that is how I originally did it, but since the locking appeared
> > here I thought it would be safer to just continue to invoke probe as
> > we have always done. I don't know for sure that there isn't some
> > driver that relies on this for some reason.
> >
> > eg it might change the group layouts or something.
> 
> Well, I don't think that there is any driver doing such things, but the 
> only way to check is simply change the behavior an wait for complaints.

My other concern is that we don't fully block iommu devices from being
self probed. They can still be probed during rescan and during 2nd
calls to bus_iommu_probe().

But OK, it makes more logical sense to just block it so lets try that.

Jason
