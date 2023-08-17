Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBA277FDE7
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Aug 2023 20:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353261AbjHQSdp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Aug 2023 14:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354450AbjHQSdX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Aug 2023 14:33:23 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176C32D58
        for <linux-acpi@vger.kernel.org>; Thu, 17 Aug 2023 11:33:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRykyTsdJlF0nwWE4z/7EPj8f3DAe6PJtck4fV5kD5Jxrd82rVpE3GTBKJDWO0POaZbfHCu4znt6fvciqEU6mVy8V6ZWTtZUwR4X9ag93fIBmvhbKWRVAmR9fonxmHRiX2wAQ6aAlIpdDh9keAJ81rI3t/gsGo52CVlmdGu1L5Iq7QhhJ3gjIBVMpqFofnY5L/Xv+DXR1EGffl0ZxC/2KJBMOxF+EcyY5z+VORex4uRz+49XIlCZd936FFsPPAVYDKXaPaVBin2i7q7Ic9xx35HYGSoCcvVma5Dlqs45vkLpvxxBFxnH4OCXPfQ2/fqmGsKgT6UwSO59epHBPIDOvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JrchdpIMuYPJdaY7C45CxSOzPOti/b60iDjXH0fgNME=;
 b=emdAXmlpxSGV2YPhgcYSmkg4L4ht+bkqnN6leqgk0n0IJ1pzWwccjQYI+CiI4e1nbsQLNxsWhRyUMbYYTJ7XH9Ta2dosiMgEsY7ZGMs6elJ0HgwRwrAo59MZSoAQrDs43QZznO9LDyfnQQAdj4JqrHoSm5WtqH85RvaQBimjwlLeNpHWDDi9XfyvgwNEbstVfEy1qnRx8c9XoDaxrvAX1uwY44SAhvcK7fP7Xwu4R+WZ6V+5xGexw56B3f6VJWIQ0A1vUEk5GwXeyktMlRRrFjaIkPZ5sqk4opuLKGc9wKO6bTEdg5c4P+2+AXzKNfLzwiQ29dNsPa4gS3Z0bhlWHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JrchdpIMuYPJdaY7C45CxSOzPOti/b60iDjXH0fgNME=;
 b=IrIYNo7R2rawvJ14PamQSFFw3BAyISPWFOcbUUNi7RpoGCmAjLWClL3IIzp2mXbdWQPxvejDKf1Ha8nTBJ2NTSlORX+t9RutcrT4+ePpOFQdsj/oWgiX+Sra6YxBO8o8CPOl6eQOi3gltaYOlyvwa7hB2tWovAywARtR03m311IcFZLKuupkthDjjgVSDVJkW+Rk0Z0elGIoiNA1756qnl6GkSYv3mjhqdN3lgmPmLuPr11HMQTU/yC3O1tQtUmXkc/4zP6QWxPY+JQwS0yofXofGm4RRwyjcZabNWSMHn7uUtFCt+jQl51U4y3Tbzlgb4jfClYWivKjFoBBUgZuvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5097.namprd12.prod.outlook.com (2603:10b6:408:136::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 18:33:18 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 18:33:17 +0000
Date:   Thu, 17 Aug 2023 15:33:16 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v2 0/4] Fix device_lock deadlock on two probe() paths
Message-ID: <ZN5n7GnlrTS6s5Yg@nvidia.com>
References: <CGME20230809144403eucas1p1345aec6ec34440f1794594426e0402ab@eucas1p1.samsung.com>
 <0-v2-d2762acaf50a+16d-iommu_group_locking2_jgg@nvidia.com>
 <d090f196-a5c2-b188-31bf-e42553d8d251@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d090f196-a5c2-b188-31bf-e42553d8d251@samsung.com>
X-ClientProxiedBy: BL1PR13CA0132.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5097:EE_
X-MS-Office365-Filtering-Correlation-Id: 147ddc44-50f7-431c-60aa-08db9f506ceb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WfWm8wtCMqq+faRFV5sJ1eNlinzVRX5hENwCccdk5Ja+IWgmSuhGVn5ef5FkIHdUTRM3wwqRWk4W3XD5I1CV6wGD75qHLJHz3W6Bl05LD8Ke3vrWhI1on+tnwK+WH86preeT0hGOTJEPbSeI5L9F7V71aMEdcRMY7u5kmXH9Bx+w/Hd/zL8cVcAlsKlQWNR6bjJYMnDSjU/6EoXCP4m3IIIhjsQSiYGvNBgGFulUonLLkBqd5MjcWEsUtu7DMga69WmmilpHHJz2rkird8+Q2wCj1qzT/w4GVwn5RJFw6xtC+udjbWFSzi4iJ9Z9n36MmY7ee4hkeqr5l1nKw78tjhvNuORaeIMERHgVtav7GFJcQkG0qzUonuXyri4zAmxceLGw1neuMuuf8UJadIVtSjobx4mXDYjZ4I0BuTb6wOTAWN5JFikeMwPBPOFe4hZRW/WMNBIyb2Ky3AyZuJMI8It/q7J2aVoa7YMQuqiFzAMlkWHARl3EdRcdIVr56Tv2iNWA/+N68bOEX+P2mcAHC+m6mtdNlRK2I6P1PeTO2mJoKYEt25E+/Qe/h79CRKHH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(376002)(346002)(136003)(1800799009)(186009)(451199024)(7416002)(2906002)(83380400001)(66556008)(66476007)(6506007)(6486002)(6916009)(54906003)(316002)(53546011)(478600001)(5660300002)(2616005)(26005)(41300700001)(6512007)(8676002)(8936002)(4326008)(66946007)(36756003)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1JGbVkySkdaTUFBa0xwbkpLM3NiMG1oVW1DUzVVQVNaWFgzalE4SXJSTCtP?=
 =?utf-8?B?UUxYbENuVlpCeTZnZzR6UGVRWGQyd0Y0ZEZDSlc0WFVKUU5IUG10aHdpVm1I?=
 =?utf-8?B?ajBGbUxOeTdoSi91WDJrU0RXcWhmN3ZKRmFRa1hRcG5wdi9WOTJLNXZDVnhU?=
 =?utf-8?B?dzhJeUZZWk5EM0FnWG5LQ0g4d08xNEMxbFFCUEJJWm5TYjVTT2hPQzFaUlBX?=
 =?utf-8?B?NVVkRzdGQm5lbVBhYkZORGk5Qy9pSnJmNFFtTWNWMm1pZ3dDYW1yNGVweWJo?=
 =?utf-8?B?ZGM0WTRPWFJWNklQQXhCT2c1T3V1aExjdTBEMVhxdmZTMHBodkJhY3U5NGJP?=
 =?utf-8?B?STBrYXlSNUJQMlFsTDFtUEplZmMxRzJ5OUR2aU9rcE9yZjNJNDV3eGdtUWJa?=
 =?utf-8?B?WTRKaVlBSGtMVFh4YXB3VFJUWjM5ZlUyUjk3MmxPUEpYZEVUS2ZLZkd2VmpG?=
 =?utf-8?B?blBIUmlpVktac1poMUVIUm9EUXFRRUxOa2pDZEZxODlUUlQxRlFBL0gwUkZP?=
 =?utf-8?B?UGFWZm56VVZ5MS8wdlFlVnBVWSt2YVRacUVrWjRnZlZJSHlBQ3p4M3BWTnBH?=
 =?utf-8?B?ME1YSDBTa20vKzBPU2s1aW1CcW05U2U0dFFaZGZDOWhScDdEMlBNQ3d0SWE3?=
 =?utf-8?B?MExxVmpTcENLK2p4emVnNXBObGdlN3RDdVErZVlKWWo0bEFTQnJtNld1Z2Ri?=
 =?utf-8?B?NXdRYXFyTjFqejh4QnJ2dU5URkVPU0xwM3hLOHhDS3ZGRG5VYXh6b1pzbU16?=
 =?utf-8?B?bU94WHRKOVBSRXdBSDJjeHM4eUUyeUM5VkJYZnNpTlkxU2c2dEV3UWdBTFpG?=
 =?utf-8?B?MHVLdWpDWjRaNTNNOXZ5RHBQMUFtYXpwUnQ4djFSWHZtZjBraDBIL3R0bFBz?=
 =?utf-8?B?aFBxTGRXR1ZLMFB5bTljS3ZUYnkvYk1YNXp6NU94ODYxVzZFUXJ2THMzWmtp?=
 =?utf-8?B?RTQzc05nS1NLT0p1a0pYSGVqSWYzUnhJK2R5U1YrOTlyVXlBSXJMQlBlcVJ4?=
 =?utf-8?B?T2EyN0dua1lhNVlxM1dFNVZCNjZBYXZaaG9TTDJXclJYWjVUcDVEekFMYlJn?=
 =?utf-8?B?Y3RPaURWeFIvajk1dDZlT0RFbW4rS2dIbWliQVhYZDZqUktuRDJ1MVU0RkF2?=
 =?utf-8?B?UVlGaU03YjVNVmo2eDF4N1hqRCtXd25wOUZzRU1DTzZ2dk5JbDZsbEsycWYv?=
 =?utf-8?B?Z2Q4TzNBS0NhN01WamQvUmFnbGVPMzArekJ5ZWxiSkRlNmFaRjV4OHRXUERN?=
 =?utf-8?B?YStPNUFJenlqK2VrU3BYeXVvOWZTa1luN1VZQjE0eWd6dnZ3djh3ZjdDbDRs?=
 =?utf-8?B?Z2ZvU3UwZHh2bnNlc0RZTUE4dDQrUisvNThneGRQb3pCcmdlcUFhSk1QdW9Z?=
 =?utf-8?B?dEJ2UUhsSnJ3T3EyT2RSaUFEbWx6OEdMcEpXUXBacmFwdVBZR05FRlJwaHR3?=
 =?utf-8?B?Wjg1alhCTWtIeDk3WkxPMTlwUkFDNVhPMlpPbEhOWW1GSWF1MVFTMkQzTlZ0?=
 =?utf-8?B?UFgvQ2h3RHJzOVZRSVhrWklqZHd1QkNkRlFSenlNd0VzbzJsbmk3NEVINXo0?=
 =?utf-8?B?WmRUU0dIWU8vL1BCY2R1OHJIM1lQeFEvN1FwS0p3K3JKUEtxL0lGamlndjkv?=
 =?utf-8?B?ZlFFQ1pVNHZYc1NhZGhmWEQrc21oWEoxUnViSitzdlJOUVJ5aDF6ZXBzbGFj?=
 =?utf-8?B?bGlmZkMxOFpRcHhSY1YzcWIzSmhPM1luZTNMcitJLzBZK1gzQXVXVWcvZEly?=
 =?utf-8?B?WjVWN1gyNEl3alNlaEszdkJVS3ByWGgrR054R0ZURVFwQkNGckw3aUN4VTk2?=
 =?utf-8?B?a1o3VHQyc0VYUVF3anZtZzNlejgreWlIRnNHb1FhMkJEcldKSVppSGN2Y3M2?=
 =?utf-8?B?OWE3NnhRS0wzUFdFU0FJTWRsTDhCZzhOVDFKdnhlT29WanE5UkFSa3Ayakls?=
 =?utf-8?B?V0NWNWtqYlhCbzdVK0Y2MjRrR0VVQUVLQWpKQ3pDYVRUc1JKVnQ0T3RSSVhl?=
 =?utf-8?B?Uk5HeTdoU3FQQk1ZVFdUdDJnczRkVm53LzNrWmJnUnNTS3hQcWpzSFlTUU4r?=
 =?utf-8?B?cktUQVdnWUQrMERIMVBhQmZmL3A0U3k4VHcxU1o0SE1wVnA4UWUxbkhHMFgx?=
 =?utf-8?Q?5GlT6VGMoX4ZQ5NZ57kLMKJg0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 147ddc44-50f7-431c-60aa-08db9f506ceb
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 18:33:17.8087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r3sXd39yBd37wriiQaHQWpsdBvbQXRKQxidg6t63RI3JcvzW96Obca+c7j1KnPqK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5097
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Aug 17, 2023 at 10:31:31AM +0200, Marek Szyprowski wrote:
> Hi Jason,
> 
> On 09.08.2023 16:43, Jason Gunthorpe wrote:
> > I missed two paths where __iommu_probe_device() can be called while
> > already holding the device_lock() for the device that is to be probed.
> >
> > This causes a deadlock because __iommu_probe_device() will attempt to
> > re-acquire the lock.
> >
> > Organize things so that these two paths can re-use the existing already
> > held device_lock by marking the call chains based on if the lock is held
> > or not.
> >
> > Also the order of iommu_init_device() was not correct for
> > generic_single_device_group()
> 
> I've just noticed that there is still one more issue left to fix after 
> applying this patchset. On Qualcomm's RB5 board I get the following 
> warning (captured on vanilla next-20230817):

> Call trace:
>   iommu_probe_device_locked+0xd4/0xe4
>   of_iommu_configure+0x10c/0x200
>   of_dma_configure_id+0x104/0x3b8

So it open codes a call to of_dma_configure_id for some reason

This is a bizzaro thing to do, it is taking the OF handle from a dt:

	node = of_parse_phandle(pdev->dev.of_node, "qcom,gmu", 0);

And the sort of co-opts the platform device it is associated with:

	struct platform_device *pdev = of_find_device_by_node(node);
	gmu->dev = &pdev->dev;
	of_dma_configure(gmu->dev, node, true);

And hackily sets up the iommu? It needs to do this because the iommu
doesn't get setup until something probes on the device. But this code
is just stealing the platform device, it doesn't actually probe a
driver.

So this is all kinds of wrong. Attach a driver if you intend to claim
the device and use it :(

Anyhow, you can "fix" it with this:

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 5deb79924897af..8dbd75c200b91c 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -1556,7 +1556,9 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 
        gmu->dev = &pdev->dev;
 
+       device_lock(gmu->dev);
        of_dma_configure(gmu->dev, node, true);
+       device_unlock(gmu->dev);
 
        /* Fow now, don't do anything fancy until we get our feet under us */
        gmu->idle_level = GMU_IDLE_STATE_ACTIVE;

But there is much more broken here than just that. Maybe leaving the
warning is a good thing so people can fix this properly. (eg remove
the call to of_dma_configure and use the driver core correctly)

Though looking around I see other places open coding of_dma_configure,
so I suppose this will turn into a persisting issue.

Some of these are not going to throw a warning because they are
adjusting the same device the driver is probing for. However those are
busted up since they try to attach the iommu driver to a device after
the driver core has passed iommu_device_use_default_domain(). It will
explode if the driver is removed.

Bascially.. Yikes!

drivers/bcma/main.c:    of_dma_configure(&core->dev, node, false);

  No idea..

drivers/dma/qcom/hidma_mgmt.c:          of_dma_configure(&new_pdev->dev, child, true);

  Registers a platformdevice then does of_dma_configure(), seems
  wrong. of_dma_configure() should be done when a driver is probed.

drivers/gpu/drm/etnaviv/etnaviv_drv.c:          of_dma_configure(&pdev->dev, first_node, true);

  platform_dma_configure() chooses the wrong of_node so this overrides
  the logic?

drivers/gpu/drm/msm/adreno/a6xx_gmu.c:  of_dma_configure(gmu->dev, node, true);
drivers/gpu/drm/msm/adreno/a6xx_gmu.c:  of_dma_configure(gmu->dev, node, true);

  co-opts a platform device without attaching a driver to it

drivers/gpu/drm/sun4i/sun4i_backend.c:          ret = of_dma_configure(drm->dev, dev->of_node, true);
drivers/gpu/drm/sun4i/sun8i_mixer.c:            ret = of_dma_configure(drm->dev, dev->of_node, true);

  No idea.. Same issue with using the wrong of_node?

drivers/gpu/drm/vc4/vc4_drv.c:          ret = of_dma_configure(dev, node, true);
  
  Similar to adreno

drivers/gpu/host1x/bus.c:       of_dma_configure(&device->dev, host1x->dev->of_node, true);
drivers/gpu/host1x/context.c:           err = of_dma_configure_id(&ctx->dev, node, true, &i);
  
  Creating a device and then immediately doing of_dma_configure
  (before registering even).
  
drivers/media/platform/qcom/venus/firmware.c:   ret = of_dma_configure(&pdev->dev, np, true);

  Looks like wrong of_node on the platform_device

drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c:       of_dma_configure(child, dev->of_node, true);

  Says it all:

	/*
	 * The memdevs are not proper OF platform devices, so in order for them
	 * to be treated as valid DMA masters we need a bit of a hack to force
	 * them to inherit the MFC node's DMA configuration.
	 */
	of_dma_configure(child, dev->of_node, true);

drivers/net/wireless/ath/ath10k/snoc.c: ret = of_dma_configure(&pdev->dev, node, true);

  Looks like wrong of_node on the platform_device
					
drivers/net/wireless/ath/ath11k/ahb.c:  ret = of_dma_configure(&pdev->dev, node, true);

  Registering a platform device

sound/soc/bcm/bcm63xx-pcm-whistler.c:   of_dma_configure(pcm->card->dev, pcm->card->dev->of_node, 1);

  No idea

Jason
