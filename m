Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76B5714FBB
	for <lists+linux-acpi@lfdr.de>; Mon, 29 May 2023 21:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjE2TdT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 29 May 2023 15:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjE2TdS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 29 May 2023 15:33:18 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4B3B7
        for <linux-acpi@vger.kernel.org>; Mon, 29 May 2023 12:33:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSphueAzU+l3uPyptu5pAILDwQQSA7sULijlkx2UC3mqHI+Ei8jbSTyZQeoj5SJLcMGMWsnFHC0g5+7gsbBqzwnomf2i09zqwPStw5rWs8LeJ/9p1T+5SYx+EHw0TazO0DcU11aamcJXGEE7rmpzlZiveMUGnRL8HYvQB6FvtYon1VnjssDWjpjxZSxMMq/ZsC5N8nTw3HqO6aca5LhhFKMR57o+4Naal3h10KUFwRbgAsf5uTV+DBoVuSrafd2A1MbkioZPT5gJ7/19VrKOI0e6+l/AifHWbadqvCyMByzizc7Sw6pfmdojyHvZ9xiM+Ykmo7IWGGbM/TH8tQ6ohQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LktUex6Lilaj26BQvSepgCIm3svoWTQj6SSLd3O/QBM=;
 b=dOfUezK3Ks5uNOdFdPigqQHqZrImVoong4lBN+312inrcO/F8QnWFpbq0kDcOyqiQO5XvE6H7ntagPNRPTWbeUCzNAHXB73v3Wg5B+Uer4hfrdWEv4yfOv+Mtnp7G+Kbm6toVJREQxiT0YT/VxJ9A9cTyo1gHyf1JaH8/23pNl15GOBn0d6kwrWvXaRFrR2BttcftASSGOfI4iC0IMYlnoLPl294Cwft8+pygDRmdO20fIuxkxIzkRZWfwTfeSSv/562FoBdH1li6wjCK/K+DnmEtaQ44jPALE2drJTWideVAxkNPuiIfabu4ICiUUTx4sN6zR6SZL+6RScbJJVX2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LktUex6Lilaj26BQvSepgCIm3svoWTQj6SSLd3O/QBM=;
 b=ptf6xJRiT3XMZ+NlplDIouJzHheqzhOQVnYwwLAmsqa22RNeWjM0LG7FCxYbqbli8MiQHLrwxU1jekUEfn9yrpwoF/5XpEHHT/7VVgT5i2leQm9Fbiyfh+0sNQCuaU18NUU/HGX+2s7F9iVkLkzVzF1efFn8E3uH2dfR8Y2CcPptPCKyl3ZR+1ASY5uKzm4YcMZFOUfAKWBIb2PW4mbB+zOPmuMX5FvVdw9Ys7b2igGL8a2tBDkUCwtFCmvLsZj9pf9em1wP7DX/NQic9YypBzN7nZnoLRPx8flZK5XlT3sc3IZahs3qyjwEaqoJv1Y5npwwvN+HGW2oztrZazl2OA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB8186.namprd12.prod.outlook.com (2603:10b6:610:129::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Mon, 29 May
 2023 19:33:11 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6433.017; Mon, 29 May 2023
 19:33:11 +0000
Date:   Mon, 29 May 2023 16:33:10 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v2 04/10] iommu: Simplify the
 __iommu_group_remove_device() flow
Message-ID: <ZHT99mp6zY+wSeL8@nvidia.com>
References: <4-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
 <8c00a455c0ff008634aad331d5d85584697f02ff.camel@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c00a455c0ff008634aad331d5d85584697f02ff.camel@linux.ibm.com>
X-ClientProxiedBy: YT4P288CA0002.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::6) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB8186:EE_
X-MS-Office365-Filtering-Correlation-Id: 84a4f224-9384-4ee2-a1c2-08db607b8a17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1nO2HbA7z5Xj9kCTsUDFMd7AC/ZKFQDQtSZFFChoOEra9n4UNycnCbdqfd/aTw5uI5+uVNDs8MPC2Eg33PDPzpK3Gsw+0n1T0bEgADZM1kFMUhoYbGGajz1lQMlS72uokSaFxEgazpSthQmGRWnbQ5fmCUD7yujs6f8+JHjEJCPC1MwDHeMKXLEAxBcMhd6GdF60rnIZLHr6yam14AiJIrg5jBB2eXPrUjmDONkBMS9pnOK/zLjusqz+UdjMKZb5sNsz4dsuKIB7Uv00so8LRzZwLuZDXMJHjPRNItEJW/QcmHMEfCPu9zeECSuBfEj4ydetCwgOuaK0O4Nvugw/5BLBFu/NvtZd+GxxDQldg/YmZtD5Ttj3bo4AspZLGXXhQSy2HY5s9W+szCSEaAdVkAtHcEd54E7z6V1iZxx4xvlwbhkfiDL0CXQJQPOsCYSl7fVPpe9EQLl27NSW2ZDCVF0huT1i57O+Vi60LgAzWjAiHvjO6sWxc1WGkx8+WbWBtVe7YOyDVn/Z8JvTcFn/RzeQ4dXEdjcwaDxFkO/AW+6Zo17DbTtugteAUk7OgBU61myFrgqiCBbn8M8utkEJOPygWNrk1Nyt2b8UfzdGVy8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(366004)(376002)(136003)(451199021)(86362001)(36756003)(54906003)(4326008)(316002)(478600001)(6916009)(66946007)(66556008)(66476007)(6486002)(5660300002)(8936002)(8676002)(41300700001)(7416002)(2906002)(38100700002)(2616005)(6512007)(6506007)(26005)(186003)(107886003)(83380400001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bMj5RUkVsWlVe3VtHT/fNQ81JHhUQT3BWftaTby1xizd6cSTBJ7pqGviW8/U?=
 =?us-ascii?Q?OPj2O8PQmDaP685AcrHygv2tKP9wQAU5lnIDVJR+n6/Mtu/1VVs3OyS7agug?=
 =?us-ascii?Q?8aHnHnBm2MMv4iMvgvba0gkM3FwmMZB4apb2UJdv/OTx6c6VdS46q3E1h10z?=
 =?us-ascii?Q?lW3OaZ7ZjBismADA7shQztF4vAhxay+oRD4t9gKYdYlJ1Eq27HdcAEzb8dP9?=
 =?us-ascii?Q?Gg1k7zIuqhD7NoM0wdki2G7z36CAmGiWcMUbLAnWpCbGmSKZHsrLEaFn2loM?=
 =?us-ascii?Q?eWCM4mh9NdR/a7V3xVUh4JorMoxbpRTpxMOtzjGz8IibIDs+erg/xwcsW7wZ?=
 =?us-ascii?Q?JD4YQpLzUpAOHxQ7dsOqi5GwChJ8i9Dd1qn5VS/mylMLst5pJC+E3w15olzu?=
 =?us-ascii?Q?XGMK11jJ4NfL0+qb9g6aq+CBrJIWyrv11hEEgT+bHzsSLhhZweO4zAJVGLse?=
 =?us-ascii?Q?kjzWUIXJ+Kbe1YZD2rvdafgCqs0HsznlZczAmOghPMsxvZYR0Js0auGsujkK?=
 =?us-ascii?Q?Y6mXpaOusMBsC2hJHPEk+Aux4ortF/3oSAeNpuzRTLmrLxrNJ0aAMm2XhT5q?=
 =?us-ascii?Q?2LAfSsa3X/aKh9fppRLWg+Kd+R5OKCquOp0EpG0APO1msUWYTuDtx1b4Vcv9?=
 =?us-ascii?Q?6UKCTXch+r1GZUAX23VjPgt+SPC+N4wSB+DEmrfqhEgTHbfOZLJsH2KdLKSq?=
 =?us-ascii?Q?3CuZquFbpEe1x9L/Mh+49FFi2BnIXyGkzGoPcpU78Nrm/BkaIvCmKp1WGXYw?=
 =?us-ascii?Q?ef29/IKSghj1xVijKJ4+g61HJFsE5YaTvhxcC6D9C5T1XCEML/DkGwNfHTel?=
 =?us-ascii?Q?ttGWufa5qoArVMT7tVUNYMPxHM9khcL/27/aFeoD5vVZOZ2pKqm/Rl5RrQkc?=
 =?us-ascii?Q?Lk9PbT/cQmVO8ICMqqgkoxzKwVNdTehBLci1ROP3FHs7GW0/PEi7i65hVlbR?=
 =?us-ascii?Q?9LBrBdSJC6c4roNPKGYAlcNGnLrhiI3Okv13ywLRitBM8LkMvUKCp7xidDob?=
 =?us-ascii?Q?Xrum1dB/OsyQ7W2bk1qEqEKOMw3oLyWphve0M+jzcgpjnpPrNEZJ4xxkWIEH?=
 =?us-ascii?Q?+UmTRMC1J3qjZdWNOEF9pOJe1OoryuRjdqtNUJ5QIAJ1zN0gtN0aXfeaW1pr?=
 =?us-ascii?Q?rQ+JN9c0A6A0ey9D+LQoJ/ZPHFL2NBjBoLT3j7ViLeK1EekNFdqLkhp26Gw+?=
 =?us-ascii?Q?kXBt1Mk79v9dMBy33Dy9IsTSiVRSPgg7DWevQPNbWpg/jVcn5phFZ9ZkTHLX?=
 =?us-ascii?Q?9G/GJ+twNe7vawFPhiP6h43b0C/1qrtpVskZmjAhAvpQcy/NRg5maLHAtX7M?=
 =?us-ascii?Q?i6ae1Dao/iGMMyRknA4/oL3+9E+m7D9I+Tqtr1HIfY8sAjcBZmlvvSZi4YDF?=
 =?us-ascii?Q?0ArJf1EoMIDU/w50UYvXDloZp8cvdvPmIOv9M0WgvP9jXohcyRM+q4wImSnN?=
 =?us-ascii?Q?lKGHKbnh7QNAg6+LVkgVVUSxCTgbPuI4d1Hhd4xcY35GurBQMvOT0TM6DcmK?=
 =?us-ascii?Q?qEyQUIZOgoGMIe08RLgLqf0uXMJjS7Ucek91r3Zoi6Jilcp/OvRZSo53V74Z?=
 =?us-ascii?Q?QPpQVoUmiRlS00u7PDDGEpIjLpZgvb0/OBqIRcB7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a4f224-9384-4ee2-a1c2-08db607b8a17
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 19:33:11.8366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wg4lfi3DFztY+0q3VCs/7VYSBOvJgTUh6cuOAI+dU4QkI3Kn0aXkkDqhU22ub+q+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8186
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, May 22, 2023 at 10:35:49AM +0200, Niklas Schnelle wrote:
> On Fri, 2023-05-19 at 15:42 -0300, Jason Gunthorpe wrote:
> > Instead of returning the struct group_device and then later freeing it, do
> > the entire free under the group->mutex and defer only putting the
> > iommu_group.
> > 
> > It is safe to remove the sysfs_links and free memory while holding that
> > mutex.
> > 
> > Move the sanity assert of the group status into
> > __iommu_group_free_device().
> > 
> > The next patch will improve upon this and consolidate the group put and
> > the mutex into __iommu_group_remove_device().
> > 
> > __iommu_group_free_device() is close to being the paired undo of
> > iommu_group_add_device(), following patches will improve on that.
> > 
> > Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > ---
> >  drivers/iommu/iommu.c | 83 ++++++++++++++++++++-----------------------
> >  1 file changed, 39 insertions(+), 44 deletions(-)
> > 
> ---8<---
> > +
> > +/*
> > + * Remove the iommu_group from the struct device. The attached group must be put
> > + * by the caller after releaseing the group->mutex.
> > + */
> > +static void __iommu_group_remove_device(struct device *dev)
> > +{
> > +	struct iommu_group *group = dev->iommu_group;
> > +	struct group_device *device;
> > +
> > +	lockdep_assert_held(&group->mutex);
> > +	for_each_group_device(group, device) {
> > +		if (device->dev != dev)
> > +			continue;
> > +
> > +		list_del(&device->list);
> 
> for_each_group_device() uses list_for_each_entry() but here you are
> deleting from the list, don't we need a ..._safe() variant then?

As a general statement, yes

> > +		__iommu_group_free_device(group, device);
> > +		/* Caller must put iommu_group */
> > +		return;

But the loop immediately returns before going to the next iteration so
this is safe.

Jason
