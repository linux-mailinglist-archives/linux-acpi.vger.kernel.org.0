Return-Path: <linux-acpi+bounces-825-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5E57D1718
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 22:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33845282637
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 20:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3DE249F7
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 20:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a/q5z2n+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603CD249EA
	for <linux-acpi@vger.kernel.org>; Fri, 20 Oct 2023 20:27:11 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AF2D66
	for <linux-acpi@vger.kernel.org>; Fri, 20 Oct 2023 13:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697833624; x=1729369624;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=BYCtOzzU91xFrVJTHpbDN1z3YhkOz+6IV8IrIPPo6nM=;
  b=a/q5z2n+P2Kc8C2+5PU9dyzqmhN/Oog69ySz0hy/ThJvWE1vmIFL5H53
   lm+n8LDTpY/z72plkI+tiB5+esU7/ZppTMbiV7j7L2F4qOA/3yjSZuvCK
   1CzTKMrCMpaAnhOjbr6Q1ca+fXIncgL9PkM0tvcetEXBDjZ/CIo2pBwrD
   opR1/DpXxuqAjlOMQF6GtyvvetHl3eFDJfQGSNtlnzcqhV27TK6xUl47r
   oFPjXt/fqNij3zyBzgnZLD2FUICH9MRI3UNvBtfcbcE63zQCli5PA0Tpi
   lOc58CGgwErdkiV4jvAJKku76UH/Cq2vjZkicS4+aSdgyexp/rKjesMT/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="383779540"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="383779540"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 13:27:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="786889617"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="786889617"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Oct 2023 13:27:04 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 13:27:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 20 Oct 2023 13:27:03 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 20 Oct 2023 13:27:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRi6PGK5TCQfGDZAiJDW0JF/GNL85388UXAvtQcl7zS8jUG5GEfvZQB01NxCIm9/kaXQNuy/6M9zQUYp5xmLSnRkOOVI0mnAf2mwstZ+CDAOOWlp32IXXSk0O8geJMPLH0AxYh+utmNtNeuFj6Chb7omq+E/hHpD6HILgE6R8X3uOJCtAb+E9s3PjQqabOpCRYlJjJ8SL9XqJkiMPMOyAl/oQpf2MAAkW4L6tMiUeMLYUCJkljDoscn80Xp3m4oDOVR38r4G7txAuj3TBwGO5yy/I+mISRmhdSQRIzAQ3F9scYf+RupwvgJ19JmdBclG6ShfNF5nXPo44OZCDR7F6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spfSD5M5cP8hv9SP6cN6CDHNd30wEdZujZK1EGB22so=;
 b=DeNLe4tAMtKm7ksV8G76KxNJeu3SVPJRXjOgknQYe6wBEXEfY7ZEaS6I+/nlVnHBAJyy2Bj4GQqkoZhIMW/FmS+01Ilzg2Wlj1K2GzBQdH9cYS2kci8WsPXHabd+Ez320q9NyD0aNKtu9tSODUhPwFnpKT7Oa7zh7GN7ZBlo1+ip2sj3mSGFvAM3n5yDf/h3WjIAKR/ITSFoAem73XXHcudc5dzqGe4dxoVephGnYXl8oaYLutxMN1ZN/OhDgun1B4Y1WSeOKbU+fH9kofG1HDmgezwICBTIPLYQ4UExgF1iE7YSgQqth2XgHUDjXCCHR64JTJWynwH0PnVKcANBCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by LV8PR11MB8582.namprd11.prod.outlook.com (2603:10b6:408:1f7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 20:27:01 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d04:2253:2a8b:5c67]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d04:2253:2a8b:5c67%5]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 20:27:01 +0000
Date: Fri, 20 Oct 2023 13:26:58 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, chenxiang
	<chenxiang66@hisilicon.com>, "Williams, Dan J" <dan.j.williams@intel.com>
CC: "Wilczynski, Michal" <michal.wilczynski@intel.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "linuxarm@huawei.com" <linuxarm@huawei.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>
Subject: Re: [PATCH] Install Notify() handler before getting NFIT table
Message-ID: <6532e292ae459_21a972945@iweiny-mobl.notmuch>
References: <1697720481-150095-1-git-send-email-chenxiang66@hisilicon.com>
 <CAJZ5v0j0A4637V5OEtjP-HMGhH80T=1kPjO_QXbgbBSZHvJY=w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0j0A4637V5OEtjP-HMGhH80T=1kPjO_QXbgbBSZHvJY=w@mail.gmail.com>
X-ClientProxiedBy: BY3PR10CA0001.namprd10.prod.outlook.com
 (2603:10b6:a03:255::6) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|LV8PR11MB8582:EE_
X-MS-Office365-Filtering-Correlation-Id: c1c93d90-60e2-40e1-020e-08dbd1aaea90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c01ILZVxLBU1HcVwOZlLJREzXUWLma3YV46IcSvqBfZfKypMOAZsGndI7dQzFTBzQhXnbtX1c/bl9Z2KoXXV8RnwmlrtG40/PtETKktjvjt25ORlpGMV8iG2LMeug3MOvLxFGL53S+o0BrEioh2iDzFKfk3C6MuMmEk8FkyeacQS5kFAQliUkg+7+TDtuRuy/UxeEfynM22MI8Hqn1l76+eynj0j94iaRmqrn6QqPEXl1lckXCwZpSR8Sxpcp09kwX8Dh3iACCjDKR4jd0q8HKMbN9ARNXaPiv0bW+4heSp/2k/XiBGY5ZF5tXHuAKUUEYrmVpHEFlfBC/9JbejTnjIybOUxPSn8NGAS3vv+2qCyPuN+tinZ8QqONL6eG24tGZKLfWgHcPQvTRhXxQWAu3KxGWKs+8Eory2t/cbeExcoO8DpTLaWI2Oy7XcYwdl9bXjnCr+VHWCswv5Wu1Tk1qxxu5h8n/Rnq3ExHoNyJ32Bg1acr/hyCO2RMKIbi4axDey0oXXozLaPBU7BEpkLFbfUJ78SjbqEjoDMWZBr55+qC61zq6EpbvcTaaJ0RRjw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(4326008)(38100700002)(86362001)(6506007)(44832011)(41300700001)(2906002)(6512007)(83380400001)(82960400001)(9686003)(53546011)(5660300002)(26005)(6666004)(6486002)(8936002)(66556008)(110136005)(66946007)(478600001)(54906003)(66476007)(8676002)(316002)(6636002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0IxekhvalJvQnJKV2VSZEJBRnR4ZDlJY3pjZW90a0VjVnB6QVh0ZlJhempm?=
 =?utf-8?B?c2FIRHVQZ2JSaTFwbExlMWYrb3lPSnlZbHZGcEt1MlEyT0gyQjQ2RkFBc0xy?=
 =?utf-8?B?a1JyQ1Y2K3gwWFFMT3ZmWDN2cmFLdjZ5ZHJPSjZwUGJDNkdtYVRkYWY2eWE0?=
 =?utf-8?B?aDYrbTdkdmxsL2c1Vkl6elorWmhQWUFHUkF6NzY4NUQyVjk0ZWRVYlJVK0Rm?=
 =?utf-8?B?cXd4S3gwaXdCTm1pa1Vock92YUZ4MURtaU9uT2UwZlFGZUJpQnVXOTVXcmpj?=
 =?utf-8?B?c0g4YThta09CajVqQzlXRW1wa1lxMWdEVHU2aUlFbU9nSU5IOHdaVUlNeUlN?=
 =?utf-8?B?VHdjTWJLTVdpTlBwUmdYbi9FM2Z6NVM0L20yMktzSFIyVm5uQzZCSlNxTjJJ?=
 =?utf-8?B?NjdEbEs3dmxqRzN6Ym1OYS8vTzJjSlAzR3pHNmNFd1J1ekpaQWpmL0NuMFVh?=
 =?utf-8?B?YWIyYnNMVUUralA1cjhybDJBL0pZblZrMVY3MHhVdmZ0ZmRrSVFGdHRONURp?=
 =?utf-8?B?bVpSb3NnVzg5NGxhcFIzNmlyYi93VndXYlJsVStxT0xONGQyaXJoZDVWeXdp?=
 =?utf-8?B?R2toWTlwV0paZ3VLbi9TT2RqWmtqcURzbnIrZVZhbDUwZHF0TDRva29RMmJv?=
 =?utf-8?B?OG1wam9hRDl6S1drQmxDaWlwL0ozdm5VTGp5c1lwMlg1T3hpMVVHZWwwYytr?=
 =?utf-8?B?NENmSVJDN1lLcG5JdFZFUUk2c3RzUW40Q055N25DemR0YjdaUlFMcXB1RlZ6?=
 =?utf-8?B?d0ZweFVkMHdTaWZxSDdjOFNKek1qNG1vN0k4STBqQ25LbThxUVlYMXVMSTk1?=
 =?utf-8?B?ZlRQQndsTWpaOUlrVlJ0V0hKN09VeEwvQS9oMjB4VWE4UksxU2VOTUkrZ3o2?=
 =?utf-8?B?OFM2YVZnWnZwQ2xJTTRTWXhZbFFsYkJXMnFoVE04YkVSNnRza0hrTW5iY2Ew?=
 =?utf-8?B?dFNxdWdZUnBsWVhTemlhdlNxRjJ5TjNVajNsZng4dG1ZMnYyRGlESTRtQkVE?=
 =?utf-8?B?ZVNva2lmM0FNMUpTSkY4WXJXcmcwTEk4bXZJRlFXenBUQnh0UUxBd0FZNTRC?=
 =?utf-8?B?Z25weVJQZHBVdnRNaFVsYmJxRDF1K2RZa3doYVZxL2JnNmUxSW9FMUlLd1lo?=
 =?utf-8?B?UE9ZYlFKalQrNTRYVVBzbG9xZWxKb2Z4eGp5NWp5MndpcG11TXhCajBqSlVv?=
 =?utf-8?B?d1NEeUUxY2c1aSttQ1NxRm1ZRzkyNEpaR3BzU0Y2Z0tySEFidHJPckU5S3Zk?=
 =?utf-8?B?bzA0V3dyMXA1VWNNb0V2UVpvM3VIYlREUDVRTzF4dFNaeWZTR3dqWVIvY2ly?=
 =?utf-8?B?ejZmMmFIUjd1MmxpOGgrVU5PQ29DTU8rZ0oyQTdMOWtwcjFucDlyNzV2K2Jm?=
 =?utf-8?B?dE9PbmhiMk5sQmxoTTRrbEYvTkk1emxXNXpkY0dUQTlRV1hzZjIzRldkQmFh?=
 =?utf-8?B?RDJodEZ1QktxU21vSXpYTFEvcVRaL0sxZEVKT0RKU1lRZkNtc29vVllMQWlL?=
 =?utf-8?B?ZTR4RHBCaDQ0Z1lETjNpU21aM1M2MlRzRmJPNWllajg4bVcxSlFUVDZhTEdF?=
 =?utf-8?B?aFIxZ2N3K3N1R0dhM2V4Nk9HdkhpZVZXU0RnRGdkRlVuNmNnR3UzckFsd1Q3?=
 =?utf-8?B?am01bE9ucERXN2xScWR5NXdOeVVMOXMyV3BJM0VLL0t3WFFJUnpKckVPSm4v?=
 =?utf-8?B?Q2o4N0MrbS9vblgzRHhIKzhEUmpNbXBVSVVmaFJ1azkyb3YwN3QyZ3RZVEhs?=
 =?utf-8?B?ZFNLUG9uUkhmNWN3aTFjdDMwSlNvd3ZDa0MvdmlaOTFrampucDY5VVd2UWlH?=
 =?utf-8?B?Y3JZdERHRGVwZkZXbmJHcjF3UktxZXRIRWNGQWExMk1yZml2YXZqZTdldDQ3?=
 =?utf-8?B?dnZLd3oyTjlSNVRKVVFmTnFDbEZTNno4aTNwU21oZzdEVGl4NEZSN2toazU1?=
 =?utf-8?B?NmVQaTZCWHV3YWhBd0U2TWVOSmttb29WWWFzdytVMEpoMFlHVTJWSE1PWEhC?=
 =?utf-8?B?UlhNMHJia1BFTjBpSTlxV3VYc0NRZzRUT1lsL2RJcW96b0lmcVpDTEFrOWVl?=
 =?utf-8?B?OVFxanNrRFZ6ZXVFQVQ2VFBuUEo2OUtKWVprTTdsQjVLTk0wY0ptL0c5M0xr?=
 =?utf-8?Q?1vxZAUwS6uJ1GOS5JR4l5LhFr?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c93d90-60e2-40e1-020e-08dbd1aaea90
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 20:27:01.6421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a9M6rW7xzTZke7mp92i9vVG7l2e9d2hq5LHZw/W2FLi1xPZxiJ4VCoywRJcbhDJ1c+U3u4wEiDd9AjBvp1tb0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8582
X-OriginatorOrg: intel.com

Rafael J. Wysocki wrote:
> On Thu, Oct 19, 2023 at 2:57 PM chenxiang <chenxiang66@hisilicon.com> wrote:
> >
> > From: Xiang Chen <chenxiang66@hisilicon.com>
> >
> > If there is no NFIT at startup, it will return 0 immediately in function
> > acpi_nfit_add() and will not install Notify() handler. If hotplugging
> > a nvdimm device later, it will not be identified as there is no Notify()
> > handler.
> 
> Yes, this is a change in behavior that shouldn't have been made.
> 
> > So move handler installing before getting NFI table in function
> > acpi_nfit_add() to avoid above issue.
> 
> And the fix is correct if I'm not mistaken.
> 
> I can still queue it up for 6.6 if that's fine with everyone.  Dan?

That is fine with me.  Vishal, Dave Jiang, and I are wrangling the nvdimm
tree these days.  I've prepared 6.7 already so I'll ignore this.

Ira

> 
> > Fixes: dcca12ab62a2 ("ACPI: NFIT: Install Notify() handler directly")
> > Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
> > ---
> >  drivers/acpi/nfit/core.c | 22 +++++++++++-----------
> >  1 file changed, 11 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> > index 3826f49..9923855 100644
> > --- a/drivers/acpi/nfit/core.c
> > +++ b/drivers/acpi/nfit/core.c
> > @@ -3339,6 +3339,16 @@ static int acpi_nfit_add(struct acpi_device *adev)
> >         acpi_size sz;
> >         int rc = 0;
> >
> > +       rc = acpi_dev_install_notify_handler(adev, ACPI_DEVICE_NOTIFY,
> > +                                            acpi_nfit_notify, adev);
> > +       if (rc)
> > +               return rc;
> > +
> > +       rc = devm_add_action_or_reset(dev, acpi_nfit_remove_notify_handler,
> > +                                       adev);
> > +       if (rc)
> > +               return rc;
> > +
> >         status = acpi_get_table(ACPI_SIG_NFIT, 0, &tbl);
> >         if (ACPI_FAILURE(status)) {
> >                 /* The NVDIMM root device allows OS to trigger enumeration of
> > @@ -3386,17 +3396,7 @@ static int acpi_nfit_add(struct acpi_device *adev)
> >         if (rc)
> >                 return rc;
> >
> > -       rc = devm_add_action_or_reset(dev, acpi_nfit_shutdown, acpi_desc);
> > -       if (rc)
> > -               return rc;
> > -
> > -       rc = acpi_dev_install_notify_handler(adev, ACPI_DEVICE_NOTIFY,
> > -                                            acpi_nfit_notify, adev);
> > -       if (rc)
> > -               return rc;
> > -
> > -       return devm_add_action_or_reset(dev, acpi_nfit_remove_notify_handler,
> > -                                       adev);
> > +       return devm_add_action_or_reset(dev, acpi_nfit_shutdown, acpi_desc);
> >  }
> >
> >  static void acpi_nfit_update_notify(struct device *dev, acpi_handle handle)
> > --
> 



