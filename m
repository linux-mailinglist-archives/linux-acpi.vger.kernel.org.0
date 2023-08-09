Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44BE4776486
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Aug 2023 17:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbjHIPzw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Aug 2023 11:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234570AbjHIPzr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Aug 2023 11:55:47 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF861FFE
        for <linux-acpi@vger.kernel.org>; Wed,  9 Aug 2023 08:55:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivu9TcvZe+SdKHASMpfWSIzLUJDy0PrAxJW6q/XshNKK1R96E0AvwaNggMTPXf9Hn35YAK0JIYw+WAnNIszzYSAoALXmd2ogYzmNCyZ8gfWe+CfcS7TE0u3Win9Mls4v8UiIWdhonERUayocMJBE//RvmEW+R8b/Rmp7mB/4P9bgnStqo41Y1uzoFuvVb2n+EkGgCCqPSWET7IL8gegBAmidueV5prHHeaPjwc7rTmDrTRVK+upCdjo+PfEm9lTO+y6VRqJKHqFxplo6V3Gztkf3j04VgBMZKEg9VEyD05Ajn5miUHgauXILCs/P0vzv152L5V1FNothlhSbY6FVrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BecnWLNdHEwilIUhdU8nE48ErRQLh1UicJGJt2PP4UM=;
 b=h2SHe/Te45+WDRp7yNxg9lE5j5/2WGOtn/Hn/FY/DdHgUfB+KtPo/vQKLAuZj1qOqVqvzJYJKTLt9e5SgzC6dZ75hh0jcmqanE5TqqTm8dnwk6ki7GXG57SzcpOWG1kFBGIaYSCsoFLdZrCbYzs56OOaj0Y/uVy9oGodiXfsKkko4symUvsRCrqwdioKYGdMRB/wFfduHOqggkPs4FeZY9bIMwoYq5uaydHmu/v2pVQl78DCezHJ8rbiugpYdoQC6HI3MM80tsIjhemyNtLqsMtTCJ9Xlg8Z/pZJo+pNRFB9bghoSvdaqBVCc05PcoKrn/6FiVfUf2MyG5m2ww6YhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BecnWLNdHEwilIUhdU8nE48ErRQLh1UicJGJt2PP4UM=;
 b=q+Oot5tT3e48eLuggABMcEoJOAHhVkNR4VN1dx8KtJ0xjvox0pT53yatQmNptWCIoDhDKpR1FWCcISCpH6f3oOiBSwLoXKJAa4b6roPrwN6z/iyaqE21ISX5HZcrtnNWuRJnCgsvHPUNf27wV2WoH4tq7eQA7zWHLvCHpGRpcDId2GClcxabAyxNHsSrquDdUdTPTfLPf53eSrwXFTcVAbKUuD3H52OMxHzPgQPx+XEKGSXf+GAgo5D3aQzJ1cJAk5ORcxy39xksjHxqFxIacpuTmXV3atcHIJRAMEigQAb3kt5CIyO9cPdjhp49vlcWRFn2J3soTO+k7hurQ8dZxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB7790.namprd12.prod.outlook.com (2603:10b6:510:289::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 15:55:43 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 15:55:43 +0000
Date:   Wed, 9 Aug 2023 12:55:39 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux.dev, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v2 0/4] Fix device_lock deadlock on two probe() paths
Message-ID: <ZNO2+7+V/HzyaWY8@nvidia.com>
References: <0-v2-d2762acaf50a+16d-iommu_group_locking2_jgg@nvidia.com>
 <ZNO1mDqas0uX_TVA@8bytes.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNO1mDqas0uX_TVA@8bytes.org>
X-ClientProxiedBy: BYAPR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:a03:40::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB7790:EE_
X-MS-Office365-Filtering-Correlation-Id: 785b28bd-fea2-43fe-ae0f-08db98f1159a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3A6DdJryYUvworhpu00VtXEGNIKhA5Mc74L+e65CKVKOkf7ny9FbevD4aHgKyrus/dCi5XHY+OlznM3fAKhzobFzYLT0FC9s0AUDT2aimjI7pmXxY1mLMlN+MvDwQUJ5ttTkjvsekb0b+NKlFdQ378LIak07fWkITYt+b+jq7m0j1IWKxS8BEcNrOPEAEL+YgS2O0nS5haXi0EyZcWatAVnp8wLE+576oDlKJaL6pFObQjfNTffsfvR4DtiFf8n9EnMj7YdKDtOXsMEJEFJ8DyiRNjzgfLix1mFSGhrP4trDM0fCoueSfIcBT+lOrXs0dzPDZg37eoqUXO44+47Io9lbvLfYrDKKiL0sP/6TBS20sHyHSd4n8sFaTBHq8pinfwU0pjlU5sNU++rfSfLsw3HTZ8CfvMB6qKnjnAWAn5xBQql54DfgwZ3CUC38eR6ISCP9cG2dDT0i8rCVdYx9SQtxlvt2z4D89gYTbp0fCPOprIJ+o0ifZpRlBteKzyc4QHrS9yYuqA/f/5PLmRIDQCH0QuY6Fy0eTB2pr7ckjjeVNqF4a54qSZuR92xEVn9T
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(39860400002)(396003)(136003)(1800799006)(186006)(451199021)(2616005)(6506007)(36756003)(26005)(6486002)(6666004)(6512007)(478600001)(54906003)(38100700002)(66556008)(66946007)(66476007)(41300700001)(316002)(8676002)(5660300002)(7416002)(8936002)(4326008)(6916009)(4744005)(2906002)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6tlNATqAntMvf27rbB4KEr5HTx9MQSBb1TlDFnQPfqLh4/KPGVn6Vfjwus86?=
 =?us-ascii?Q?8qhCTQNEaBr8Sauf1nE27O6nsc73pxZqAH/TjMwNdOSNcI1vGsz6meqXYrdv?=
 =?us-ascii?Q?vh9PaWPMCSVzekltMMv5RfMss7EFmyDtxExxpHBl0FKYTyQdFN5zDUpUM6lp?=
 =?us-ascii?Q?DvIClv0phCbUkfcztJbUXi9oVGBSvUxSSS+UVDh70DRwncbJjNhUy4RcM/6l?=
 =?us-ascii?Q?pBxI2R1/bh3dUO+AZ/rzNg78PIyOb3mGLKzpXVDpwG1tcdA3n1c6OoVZ7et5?=
 =?us-ascii?Q?+RgpZsN5EqyC2d5PAKGsJiG9Un/pBIchivo3NOGc7jJVcbDDeJxiqQP9yeaJ?=
 =?us-ascii?Q?evP/xflSNGxWprKdovJ6f1Fn5y1kmSpxsgwRR5qWNvpZGXcsGw6rampqKn4S?=
 =?us-ascii?Q?k/OiKXl/97muIYbUQlCVcoGS0V6SrnpBDihUpiqx/utK4qyUXj/Z2eLj7UDw?=
 =?us-ascii?Q?8l71xTZ55tKDK4Y2L+4IyJBYr0xEfkxK+k8cBimNqp8ChSesQnieKM36R0DC?=
 =?us-ascii?Q?J4p8o5l6hBDZJWRSoRFu48bSPV7sYoS6rhv2rvP2i5MAyfCsshahF9xkrl6k?=
 =?us-ascii?Q?xO6pbEuq2GHc84jaFeFbUxGQ0zV6/TTKvARVOIzmVdXYCNUw0jI9kTR+H9gP?=
 =?us-ascii?Q?bpG+1ajZ+1tKDDlabXIphcud1JDU0n9tzi2u1kfp7rIjrhkzR3+QL0jNWyTL?=
 =?us-ascii?Q?3xOotTZ9wU9Wrhia+2e2mqeumh46Q5RNiF+If+22wfrcWkAogMm4ndeM4Jdk?=
 =?us-ascii?Q?L/hlDC17ZmzwWLdGZKF8DRi63v1PdQYv7Qo+R9Mdpxe17gak37BiYZtopNm7?=
 =?us-ascii?Q?eBV8WCAYHQlZPSRNGeyf8m/OFCqMHtHhbN2rDmHOeuK50Mx7AtPui31jaHVd?=
 =?us-ascii?Q?xbfSnrwVLBWJgtZqCthDrzA1GCV3h8K9JY1I3PXk8/ki1AvtE+T38o9PCEKw?=
 =?us-ascii?Q?HRnkEWyKDAtmKBh84YkLLsgPxrst7rcbkZtn8f1zfgJmEOKYee50un2HzIw6?=
 =?us-ascii?Q?sXHM7bj7QhbbGYRt9aWSqN25Ym6ePbRAUY58dqDrcJ6Engx1dBRZMT+KmvAm?=
 =?us-ascii?Q?LyN8mPo9wtwqU+JlqFrGgZxOQXrc62Ff7UANNCPjbAHkVRALFOKPaD+8qIU+?=
 =?us-ascii?Q?1BJ012DpaWbWZZjSqi4GKt3ZNNCrXa/P01h6vRD/Ve7Gn0J2PfQYNFvZ4uXR?=
 =?us-ascii?Q?ltveESpKte5v0PwsDNyA6QQARx4iq9GgTvC5eqRAuxHh7N8IYWuSn3zKGLVz?=
 =?us-ascii?Q?lMLl9yX4BBbNftADn2L6i18aIbJXClHqL+h1Wa8RODC3iQd+rbumC4aZrRXb?=
 =?us-ascii?Q?DLLCp7M14C9RBJLsjnVlOr1eb9BI4XAzQSJC1z8YiGsTQkaSPa5h9pCy7HC7?=
 =?us-ascii?Q?+euwUDTmAE8SX+Uy0fAg7bXMifVKFX6P2L2cxS+86mxhQZtQ7crPfpEHl+AZ?=
 =?us-ascii?Q?x2kfhUVjzG8wdkkXHqRUQ949SWArZTTZXZHfd6/dFYT64/xKwQDMCOQ5q12A?=
 =?us-ascii?Q?eKznDl8RIa1d9Sui8YAcUrbM5W33hjtBBGE1G/NSIAgMpwLdMUQDGr+c/YY7?=
 =?us-ascii?Q?CHP82hIJ+gksbEGpGfI7NW3ljalSA8BT4GsuXKbq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 785b28bd-fea2-43fe-ae0f-08db98f1159a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 15:55:42.9687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NEBAAgza6Q4GPMWSXMXMfrvGtDEMrtqhN+kCMzCZFDjmnrg8b49CkCgOh6fgngmz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7790
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Aug 09, 2023 at 05:49:44PM +0200, Joerg Roedel wrote:
> On Wed, Aug 09, 2023 at 11:43:46AM -0300, Jason Gunthorpe wrote:
> > Jason Gunthorpe (4):
> >   iommu: Provide iommu_probe_device_locked()
> >   iommu: Pass in the iommu_device to probe for in bus_iommu_probe()
> >   iommu: Do not attempt to re-lock the iommu device when probing
> >   iommu: dev->iommu->iommu_dev must be set before ops->device_group()
> 
> Applied, thanks for fixing this quickly.

Yes, of course, thanks!

Jason
