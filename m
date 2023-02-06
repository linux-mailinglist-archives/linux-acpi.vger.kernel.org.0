Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02DDD68C6B6
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Feb 2023 20:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjBFTZX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Feb 2023 14:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjBFTZW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2023 14:25:22 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3211B304;
        Mon,  6 Feb 2023 11:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675711522; x=1707247522;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gYuesCMPotltzNQ/M53YYWH5JAa++gGb79KbX36kk2I=;
  b=Y5+4ORf2spsyWvv6jc6mbpHHULEsmBV/dANcAfBdy7OKRrPH8YRvhqz6
   MUCTxOPUjKXvnTDDpvwJNj+v0uBh59xgNgOYdV/wClKHzlRQRJeCPrhV4
   4WhcpAtDxB596Hf0khzrHz3rnRPsQ50MY94oplF0NupkeHUPUNVAcO1Nh
   UUQpM5fOVHCeTaUEIFTZjBre/2a96vGZBqs8qWQVpkyGdgXwb15P8g/Gg
   tGHHR3HH1FJa8fRkkYdvDuwFJCDt292CtbXkf0L6gw4BTRcgqH7kvc/W6
   UDoIQH7ktzs5zE60vBzTvFdWfP2OYcXBh9w1YFnaFKOK/nloajvOi4/X1
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="312949588"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="312949588"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 11:25:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="659938898"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="659938898"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 06 Feb 2023 11:25:21 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 11:25:21 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 11:25:20 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 6 Feb 2023 11:25:20 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 6 Feb 2023 11:25:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESUjJy2qmZadR1m+dI8UVLRJzZg1nHfvchtHyDFRsFsFMRv4Pae9PBWTCP+wAV53GobP8CEMWrR8zZdFHHnPOreoBAjnJ6UYWwavrgbaq/bGCyocYR/DmmVDX7XDwutSl7jPLgoABY8skqiYeEvL6WgkvFjXlJubNEYEk92B2SUhM3MCuh+Zlf7YnsAPMIdqpbkiT3jGAXnI2ax4VJbF9PXlmZD9EKYxS0XrhukIZqyQu96U59DjDCv4dpPxCgNKvAz+QvVa16rG1Fein4OH//bDynXLvAbxBvk1+jthj3h0zr2xCcmnVoEADKkaCDJXsMmAxnw66oX5t2RaQgy+kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Za/JtZkbEPL8ZVROqvUmqbOV+nIB4bfZPRat2o8SDIg=;
 b=DTzuK33H4+FyDfpAh9HBxP4mJWZYgdnPFirCid9xft4oA8/27ZfIKkw7FmD+yXCgWMdiQTAPL/7VPx3HFpEWO7tSKQUxj6xz2NtEJ85iP6DtEJpTBBF6UarFHsEB06hCxRlf4MLuIhJMPvDu1Tudav8TOzKsDtnMTb7JRJRqF0IRwwldt4AzAY9eouy8S5XsMzEpy0ghH9fu0OHkfEwQgputkSu7fvBy1UlB4o66psT4fkuuzmPw9yVfToPtYgN+r+hH1VYm4TKH9OfVs+64Q1Jn/zd4xr0VjcDZAMjyP51oadazzVYHQeuU99v7uJdD/cj2nTE224Oy5Pjn/B7Tpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CO1PR11MB4836.namprd11.prod.outlook.com (2603:10b6:303:9d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Mon, 6 Feb
 2023 19:25:18 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6%9]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 19:25:18 +0000
Date:   Mon, 6 Feb 2023 11:25:15 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
CC:     <dave.hansen@linux.intel.com>, <linux-mm@kvack.org>,
        <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 05/18] cxl/region: Add volatile region creation support
Message-ID: <63e1541bc45b1_fd49e29414@iweiny-mobl.notmuch>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
 <167564537678.847146.4066579806086171091.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <167564537678.847146.4066579806086171091.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: BY5PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::12) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CO1PR11MB4836:EE_
X-MS-Office365-Filtering-Correlation-Id: 06ed585d-b9bf-4da1-369f-08db0877e16a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YNMk2qOCRWm/EjqmxDQaM8yzO1NkTsqiXdMoB3qkXFk2EeAv6NBHQPlhnNtLw0WscbWNI4fmgWwnaUtMQzmJVoKiqq+Xqr4mxJXb2LF3A6Jy6zFPRic0AXWrQwa+dGKow9ZdUI2baXk35Rmp1HoG6XdOukUFNAtWOpDnbX5bKtKeSpyIyX5eE/A2Q9oDEFtrwlwzs2KhlZuqnTCeFLLfMHxIZB78MWBSUOpBKS1Q9Uh5/518NRh4dkQN7R9nZXb8M6GKaXR74HuI3nAeotDHMYyODyE0tdjLn84S9gE1F1Gg0vPq2tU4ntm7QehW/XmIkOH7rxi/aUhY8pVMiqcPCGs8pv3TeUFFvnj9EIwvTjpmZzqA9WmmUkoQ8sApUgRYZstxH5WGuV/KPjn3I9QO3MxqG6dUfw5XqrXbP5N6AihOjSYioUU0fFjdEK57OirnY2sJg+Ze3DRvLEYNhfJlq/aY7YSIv9j2bW2ljPwf+1CLwMavRqiUWa0ncpaFbDvgWB+Q5uNSkexgGdIhccLZm9RZCrZRYLfIwQQrRPpbdZ4uesnwTzIHbKI0EfJSsvxSw7CdPKiQeRZZrs0MRtrxgfhc+c40IzzS3iwuRv7W/rRcCm7Ri5rMk9GwklqU/Ddu5ek2t863TSBWf4wfBtJ86g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199018)(44832011)(2906002)(6666004)(4744005)(5660300002)(38100700002)(6506007)(478600001)(82960400001)(26005)(8936002)(6486002)(186003)(6512007)(41300700001)(9686003)(4326008)(316002)(8676002)(66476007)(86362001)(66556008)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iBBSQRH5TNswPOp74MQdw/XCdcDdWxaLSsVJL9CftB/INUDH7OH7ME98Nome?=
 =?us-ascii?Q?3GM65R4zEIqprqLXcdWEkvJcNjMVeYxW+zooEmx7bRhciezgOvI0S08CTdWB?=
 =?us-ascii?Q?BVzUkvM7HC/Kx/AAIQ3ROGMN1JRQA+ifFcgcrKKvk1QZVbi+6ZJs2xkdXwcP?=
 =?us-ascii?Q?i/gQpmWe3njQPuw+mGOxASxNsM1EQ4SRQdjFPWLbhYTnVCCseCd1LUHYlQsu?=
 =?us-ascii?Q?A9aoxJjZ+7RArVzqhZp1P8/rSIv1VvIB/jm6G6fAtesJdo7SaaWvafKwUR1i?=
 =?us-ascii?Q?WP2/e2X7bLBVWcxdzir6Z1CIlto/7KtrJj2Wou0mO3cbBFHLBzc2vZLizMj4?=
 =?us-ascii?Q?IsT+ESXVrBZj9E+PA47JZlSApkmd3Wx71dps38yvBxWjWXKsF7LT7t2peMC8?=
 =?us-ascii?Q?lOeYtEAhBdXv1/g0H/pgDp4+d/jpUjhX5JIY7m4n36B9MRsghsauHOvX8Sl+?=
 =?us-ascii?Q?KMPi4R/eCisKoCr1i/aJcYdA86E3dJwWxqsm5zSvT6DnTGBRbjqNASqF7gUS?=
 =?us-ascii?Q?n+hb+uM5o9L3oi/qR3xARyBTv1Y3WP/Szori6JQwdyek8E112goYuj7GBv3w?=
 =?us-ascii?Q?6HRV12+PlYCmzvRKVKDkdhGWo7A3aP8pwbhjGtQSq4vezut5febvLI6EHRDt?=
 =?us-ascii?Q?301n9/4axMtnDsrwTpELvT8ZFvGDTvWfDJLBb1CxFzPL/SzCM4radYYOQQLU?=
 =?us-ascii?Q?qpwDrl3DARjorjlSG0HFVX+pqEjmI/lc+X+G5mp5vXEqUos7GG0GgCieH/n6?=
 =?us-ascii?Q?k4UBOymCHHBuxy5GXb8UQA2WsbMkNVogJaSM18sQhRmlzF7h3A3kgByc/+Lm?=
 =?us-ascii?Q?vn5f8imbDprQvD+A94g9sp8+3zX7Xe12LO0EYYjtZcwHM244mgeDDtJRWjiV?=
 =?us-ascii?Q?vu/oc57Fp+cI+AUtfg5iRgkhd5XuYMuGQsHiH2ygUsAAdikk9jAoEaRDY6u/?=
 =?us-ascii?Q?K+5rnvSFmz8Uxc1uS9ytnMTD2P0YBQLKryfqo4yT6JK9w/Ibow5CR6c2qNCh?=
 =?us-ascii?Q?UxaqKMCfD11Ct+FvkJ6JOfOc8W3NT8JYnbNYZ1km6MH/o5OeYvdDC2kgM74H?=
 =?us-ascii?Q?YdbVnh+rQQGD1lZIH5s2G+awyovkxGZMQh6qM1kSWwNDs1fxJ+y9xkxbQFg4?=
 =?us-ascii?Q?NnY4iL4dT3P/gM93sDN4yD1npsvSzR4gKCtI8bnQcri80lAeIoYDPYHGo6Mf?=
 =?us-ascii?Q?WamRy99TbtY2mrkIGCPiusMUrFrNxieXEVD87RlWkfwhE5cqHtHruhoDYNR7?=
 =?us-ascii?Q?Zneo5951cuFRcwaa3gsqfClenRKLUWxDLHOeCiJswZUtwza7rcapF5/PRydL?=
 =?us-ascii?Q?xNHHZ/txT9nhl+86ZXienLf5oJWEaBxCBEfeXrFxjXa6vniycNFoxmrkan/0?=
 =?us-ascii?Q?qW1Bkuzf2qqdB+RgMy78MThCa0aCmdYmHsTgnmcWTVivT6M1C4EU/fu9umZ9?=
 =?us-ascii?Q?s7HSNplWHfAZI1VgDkXjBF5dXZoy1OE3zHluRJIpccZaCBcyLtJ10bufSCCV?=
 =?us-ascii?Q?RhWwcp4NTduIDPbeLnZiLGm1ivBYlzrDnfpb9q/icnWS01WBPtTWcDGYV8Pc?=
 =?us-ascii?Q?AP6IoyIHZ60KQnfdJ6vZbcdzV1KAdvQo7C5Igrp6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 06ed585d-b9bf-4da1-369f-08db0877e16a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 19:25:18.1379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HRR/WZhTr4kSqxkMRsyF2rDkatZowWR2HLNmSFl+FKwV8tM2CG2phGbWjqwYA9lsTMV8mheFZ+5mHPBFf79HGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4836
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dan Williams wrote:
> Expand the region creation infrastructure to enable 'ram'
> (volatile-memory) regions. The internals of create_pmem_region_store()
> and create_pmem_region_show() are factored out into helpers
> __create_region() and __create_region_show() for the 'ram' case to
> reuse.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
