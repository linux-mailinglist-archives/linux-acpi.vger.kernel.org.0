Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F74D780FE2
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Aug 2023 18:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378495AbjHRQHR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Aug 2023 12:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378413AbjHRQGr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Aug 2023 12:06:47 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2066.outbound.protection.outlook.com [40.107.212.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7ACE42
        for <linux-acpi@vger.kernel.org>; Fri, 18 Aug 2023 09:06:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GvKRH8buyVP9G4OnVogzUOP61N8GOavYAHx1ZIbv4Os4MGlVb+L1OZhDOTYuIttGxLv82fv0ZtDa+sYQTzVOJOQz+DqXKyucmJAPnZ7UlRCWhNaSqTxpong6AKjd8KPMoM+N2QxVEwcrJAC74Ss5UQkanOJwTGKJScFY+UOYPGG/MIykatRRFXL73o0dpJ32AUyBM/cWSRIanFu8b1DwyMgCjuNR6PII+OzsLxP4W9bPE4b90U/litt0eBUea07Tnmjkx2lhe0Z7/0mdxmtzPGy+zDRgO0XK3tXD7836XsMxUmBag24dOOG0RxFoIIp49JQEo5hvbAHm7FjMWezkog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSfFsF9oV6k6xTud9gJvzH6X6jH0yAPr/JjuGNpFVVc=;
 b=iVAnG/nrSF4apg/xV798uHKiAHgJdtBWPfPUL5G+Tg9ktO27i7URoZ/n4wske69bUOV3Q8srBHCmLFlKhhB9v6PypBfDJUlBIOqTDNKDg/VS6sQBwltxwVakQZIvoI7DXohNqEEEwD5CMHaTw9l9z3lkq5xv4TCEhQ9x5PoT0IgfBSoTGqa35fQRk1Tz6AgD4Gjy0Amm9ztkxOTMYq2o12u6mY+d4jaRHOe5aA+W7Z+FkT6XGsgo8QKM5CQCJHDnIAftBUEbKQgjvGKbvTd+DzuN2Cjb9D1Ydiyqamw/OHm099vP2cEuemczUA9jH8THzdKKMXnQZtj8mujhTOqiuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSfFsF9oV6k6xTud9gJvzH6X6jH0yAPr/JjuGNpFVVc=;
 b=nETiDpz43NkqRgXTqrFBzx7VDq4Nd7t/jL26Jh8nbyh+syunVnDpgKo8mZM+hHL1l2WOY0A/oDJFFvYQWaXE031EhPwlUrJyDj3sWjlVD+bkYNxsWRTyz3qgznIPrQHocUQQxMJWLFUyidSA+o1buWQVR4evmjU5l5uII2WSfReR+/NmfwdKLnL2DSupcKHDvsg9WWKfBuOzwjVWJ8zxY90Q82F/ZH7uk+5ByKUGlUZpcq1Zc2mw3C+03NxmVtR/8Tz/PZSf8incKrQn8haOMXNxfe4lr+8RsG5NGatuxz9VCfn7TEHNlLKc9jnJJzhOMJh6/sneiMrDCAlh0uV2Ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by LV8PR12MB9136.namprd12.prod.outlook.com (2603:10b6:408:18e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 16:06:44 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 16:06:44 +0000
Date:   Fri, 18 Aug 2023 13:06:43 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v2 0/4] Fix device_lock deadlock on two probe() paths
Message-ID: <ZN+XE7dk04f2C3D7@nvidia.com>
References: <CGME20230809144403eucas1p1345aec6ec34440f1794594426e0402ab@eucas1p1.samsung.com>
 <0-v2-d2762acaf50a+16d-iommu_group_locking2_jgg@nvidia.com>
 <d090f196-a5c2-b188-31bf-e42553d8d251@samsung.com>
 <ZN5n7GnlrTS6s5Yg@nvidia.com>
 <ZN-UpDFHab0vGuXp@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZN-UpDFHab0vGuXp@suse.de>
X-ClientProxiedBy: MN2PR15CA0045.namprd15.prod.outlook.com
 (2603:10b6:208:237::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|LV8PR12MB9136:EE_
X-MS-Office365-Filtering-Correlation-Id: dcd7351d-77c9-4e62-9322-08dba0051de1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UaYy895+bAe19gNvLi9GKmhHj72PxFb9M8JVevfn8eBeUdZ/m7x0ngB36/ySde+22q+R1InUSdQZwaYiiK5bSEYjdpcuLbWQuN/uaZHnrlM8xr5w+wys8Mys5l3a75gWckM31Z+7ifGnRZ2uGV3Ojx19i/wlSrOz/8yp47lO7KMDoVjnt7LBIcavVTq/n3U6j5iyvmoFNf7+gXs4Lm6fx3HhP5ihGkkdManC0ksvqiigBSDHdM+C7dPU3erXYLH6cFRYBO7l+PjfX/PMxPc/R73gywvOm2VCRbyv2ew+GzSRKxMHTCI/cFhSKSfzLW85kuLn7mDoPSQyv6uLwjjWkw3vm+XIdcIg4H1OaBnfu2nvFMZDY3SDhhPLMtiiFVw2IpDxMGQ/NqWrmx9Jx8/1WrwJQuCAqA2Hh6XdlNL+cg/WCA5mUUqJUUH8YIcH/6p8Ixvgt8/s1QO9Scl+AXkxDmilIEObFqtJDGujkeE4cAxVp1zAxm4ygK+wXs2HaSHQUFHzF31UBdMRHxPu3y7xa4oefPabVFIegfwe/xyNoydV6VotGdYZU5ElBb577z808tdlL3QoDgLadF7NE151LbeUPidit4SZGYn4YZG+XFU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(366004)(136003)(346002)(451199024)(186009)(1800799009)(5660300002)(2616005)(41300700001)(2906002)(66476007)(66556008)(316002)(6916009)(66946007)(54906003)(7416002)(8676002)(4326008)(8936002)(478600001)(86362001)(6486002)(38100700002)(6506007)(6512007)(36756003)(83380400001)(26005)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XCHM9gDIqVKOtzd2ojGSaP2JQ3d2HbDYDBu3YsyLULqlFSkCaDTcscjERwgR?=
 =?us-ascii?Q?jeKhcHuvjDggohE3ySEYpzQrZhdMeCS9O1+CQaQxfo2KYtiO3UfCMx1XPSsn?=
 =?us-ascii?Q?mfsOwpBoCBShSt8WwID/qmZClbu57Rg6zF7Mc1l+g06abiCP0cvf7oKnQc90?=
 =?us-ascii?Q?o/TqkP6UlYaA3ZIB98ibqMkYOVhRTuBwepyo1A5/bYbhUERBXQnn38DfbqQB?=
 =?us-ascii?Q?KGHa5y+ngt+Gv7KETuk/7ZGkplvFQpAFGOFzGT+cTF4BXkqG8bPK++G7h5Mr?=
 =?us-ascii?Q?+Et8NRB6BSTirwrNurWDwbD0xtZusrgIMOeCVp2ss9/+/isLvpw5AMhr3gUq?=
 =?us-ascii?Q?PfnfA95fmAp9LrHjldl30xwLsJA8tPhJa4Cn/aeeYapd3eGtz/dWQzNpAXwl?=
 =?us-ascii?Q?HL3XtgZvccIwi0Dg0WYt+M4o7jDzCnjysrmFnM9qseFmALkgL3Vc+9ksJyWR?=
 =?us-ascii?Q?xYczQspF9etHk2MzkntsjxHrEVSZbcICbK96ersMgQMN7yRroPVyBT+LHmWA?=
 =?us-ascii?Q?nb3n949HHv8JDCfgwzQYKYpYOA3EsbbaP9WI1MjY8g/4H8ghFLn4CS3b5SQU?=
 =?us-ascii?Q?HwL8VbnRNKh28gHL28HRtslUTZFGj6quo1W0YqwaCdmllGrAV6k0zmyA5H4O?=
 =?us-ascii?Q?1I0+wl4qxitqw+kg0ll6CbZJ/bcBa+uouqzZUDDzPDQnxxFXwPOg+1hsIciG?=
 =?us-ascii?Q?ywArvgwEzz7k5W5WdOM0KngsfU4owCT+MdQaNeJ5nIua6Jc9waOadTX/uzN/?=
 =?us-ascii?Q?wxS3Kh6YY9GzMiUdz/YuPiZx2Vx3CHRSdLcM11Y7WrKgxwVyyfzTtYLGl1Ho?=
 =?us-ascii?Q?HBIGpAzTtlNYTeYxE4W8ZBtBzFakr0uHHVEdE3UsOTMnvPl5uKSH5H1yqgqT?=
 =?us-ascii?Q?0UXRrrPD8tfSGBO2LJzXby7Stc367KTkbE5mSXRquBhKLQPVGJJpw0UVOfKz?=
 =?us-ascii?Q?GY0zrn23tVlggvVnDpQ0wFP2+t3YYYFxPbzGdBz9x4S+4KbPw5tF0Oa49BkS?=
 =?us-ascii?Q?EF+Bomuv5KvrwXO2OK9nSbCdptrN6f6ldJQvP4+10yoxYYor5kqnreWeM39P?=
 =?us-ascii?Q?Jwh1wbc/1KbQCDDvwSx9QxO+c0oPEnNzLbLxWJqvPzOisM33l+ntJBMShloI?=
 =?us-ascii?Q?IRYMzpNx6OVMgdd6aXzrN/tmn4wFRG0nbIgPDLrU86PdvhDivLwmbQAKgB1b?=
 =?us-ascii?Q?H2wpdItp4ioLvIA5qZXr4FsQYGUlaTnwiJ4TpvXk8WcnJKJclvEyf6pYzoa2?=
 =?us-ascii?Q?mGZVDxK2AA8WxFA6lwnkZDqPmYOL8bADh8yhvjFpkJEe2SggOdczM82J3oQB?=
 =?us-ascii?Q?sW9tPWVo+d36ZF6jGqwQl3beBo75YOLtoN1Lq1cVuYq6lBpNMDs7f6/FxLj7?=
 =?us-ascii?Q?nuQcxbA2+4auzFLe69RATrjE+3qhYvnk+TZhnI1DoXRJlxV0VCMHlXugcS+5?=
 =?us-ascii?Q?Mx8Ypdk46XRFJKRNVDYOxDf41GZfij7q+nUyQCfVrWshqLpAzxPofiPvYAbs?=
 =?us-ascii?Q?+vBh6x+4ddsl4LwAHpNS94tt4xMmL/oVwzkmaw8BLkv8Xa0rOW5Jj9SDu95R?=
 =?us-ascii?Q?C/DH4pX4vwm7NkuN1QNJoAYHCBUWqaw4B7gbrYDI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcd7351d-77c9-4e62-9322-08dba0051de1
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 16:06:44.0758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ASwRW8OpSl0ixpekI+5EUTdoMjYYQ7nfDRIA1edMooypZMOPmPlkBpB3hPB54/ok
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9136
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Aug 18, 2023 at 05:56:20PM +0200, Joerg Roedel wrote:
> On Thu, Aug 17, 2023 at 03:33:16PM -0300, Jason Gunthorpe wrote:
> > Bascially.. Yikes!
> 
> Hmm, that is a difficult situation. Even if the problem is a misuse of
> the APIs we can not just blindly break other drivers by our core
> changes.

They are not broken, they just throw a lockdep warning and keep going
as before. This is what triggers:

static inline void device_lock_assert(struct device *dev)
{
	lockdep_assert_held(&dev->mutex);
}

So non-debug builds won't even see anything.

> We need to resolve this situation pretty soon, otherwise I need to
> remove the locking rework patches from the IOMMU tree until the
> callers are fixed.
> 
> Is there a way to keep the broken drivers working for now?

Historically we've tolerated lockdep warnings as a way to motivate
people who care to fix their stuff properly. eg the Intel VT-D had a
lockdep warning at kernel boot for many releases before it was fixed.

The series doesn't make things any functionally worse for these places
misusing the API, but it now does throw a warning in some cases.

IMHO I'd rather keep the warning rather than supress it by adding
device_locks(). Do you agree?

Jason
