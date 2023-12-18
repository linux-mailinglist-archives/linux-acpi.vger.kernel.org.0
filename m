Return-Path: <linux-acpi+bounces-2538-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2EA817E4A
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Dec 2023 00:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AAE51C22C83
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Dec 2023 23:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8571E760B2;
	Mon, 18 Dec 2023 23:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e0m55W4A"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B32A37865;
	Mon, 18 Dec 2023 23:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702943960; x=1734479960;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=d/OkIM87mtF4pGyoU3SW9/fl4xchUEwCrqW+8EnmGWI=;
  b=e0m55W4A4YDOwz5Mei3Ti06JQYyHHBqv3xY15FjzOIv6xAAMgnGH/M2/
   +LpUMf9+C+dbKN1fCtsj1wIRi65lCPuhFbaDwSchYVO1dG0InjxIjwSSH
   /aBxa6AMOaSLhHBRosIO+fjJYRxpLQ3Qf315m5MzvOyF7ivUAJzMhUUK7
   pZDpkK9siqKyXLvJCtRpe9VBBxclhrsNLE7UYRems3HWmDa9pMyOSrpCn
   ryy4u3Q378JCYlEErV6mYJcc85u44L93h6fhlqeYPAl6Yh5ZCxFa0vC3c
   Uk9nV2mjFA7Uv4UXBwlThjSV/sk2L/SRtJf7wxGXvoLf7ffibVCylEmak
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="8951954"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="8951954"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 15:59:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="1022937611"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="1022937611"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2023 15:59:18 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 15:59:18 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 15:59:17 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Dec 2023 15:59:17 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Dec 2023 15:59:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bLsnsHdpuRx4l7D4LAvpJN17SaY8sam05dYp7otgLyXYAUSm1SbDgMWqehFRw1+xdyGHTnFp1eHZPlBg8PQX5RNc73thOMv4O4I9cXFNQJnNwz6HkcaZvKqXXJYf9oMpIcpAj4niP16VLx1M4tWof+7o3hGSF5qC9YKadrcFHbLuNWXqHgL0nOddEWqpjSzS92Ob0VMKDLfc1hAcNqk7JHEuaOh/ryThR2hmSu+GNQciAw1VnDeS/x1vAzKkj6Jg+uh7cSQhV9ix95poLwxgbpZe+j5uHflBvtjzjvc2hPtuHrPYuHD8Xqkrr21eu0tTyZIdR/EYWtg0e5NfDIgD7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krFECqD9KrmZiYEZhUbUfedC0kTHdfiYDw48UnOwsrs=;
 b=KWsCtb8A8rYi6U5PU/IOXeVON5D4GVsi+g5EBh+PxCAeXRi/u6sgExNbHZOwl8iW3e8OpxoYOeP9HkN+RGRhJJujMeHRyPDD44VgQIWAuwjOzdUymGKC9QvFIDJ3BX8w7n7J8Ey107MFN1OEy/SXdbBat2tfQtcLj1MsY2qVW7+J2maVHEpElnZWl4ls2lXGo/44D/7WIji5WcCiRKBLZo+77uoTHIrYnXsNrOqJhOmT2srosiNm1eGObDwNQ+0G52onRtnJVuYqoigs8d/qh1y9642BMkV10iZ/3kGAWmt91tgsmAtyvQNnewBamXZmFI9Pn6574iw9eAAvMKyG/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW3PR11MB4761.namprd11.prod.outlook.com (2603:10b6:303:53::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Mon, 18 Dec
 2023 23:59:15 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169%5]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 23:59:15 +0000
Date: Mon, 18 Dec 2023 15:59:12 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>, <dan.j.williams@intel.com>,
	<dave@stogolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <rafael@kernel.org>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<benjamin.cheatham@amd.com>
Subject: Re: [PATCH v8 2/5] ACPI, APEI, EINJ: Add wrapper __init function
Message-ID: <6580dcd03b49c_7154929487@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20231213223702.543419-1-Benjamin.Cheatham@amd.com>
 <20231213223702.543419-3-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231213223702.543419-3-Benjamin.Cheatham@amd.com>
X-ClientProxiedBy: MW4PR03CA0125.namprd03.prod.outlook.com
 (2603:10b6:303:8c::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW3PR11MB4761:EE_
X-MS-Office365-Filtering-Correlation-Id: f91be179-47ad-487c-4e1d-08dc002556d9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ClJnlMMR0uvvu3Hr9HZV+OAXt39CR69K4gHbzjdYRjcZ9Icic4pF4eaVNEZkjsQwz+6yHjJYWapj2jd0x0kwAvYK3XN1Ewl8gJOe7bVXdUxLhp2SmuFgVeRUVRBBt/bjDdFLVrkWTzrG0ctfVzPpWvW7kozZdto0gnAiLTJoRxY3bjsFGVL7sGwERUUU74vtAyuotjRd5YQJk3vstYnz/j2q8Gz0ZujQepJ0kwpOFBdvk37AFSsGm5pZbMpCt/wxf2eV4k87P+oprURNi5AZAzoKA5ub4Sa519LfEcSfqHmDEQI9g7iDpuuUWNxlrf7aVXwCaEDAO27kxonkBcbJnEACCI0pClMCqDvlYasi9z7WyvZh0NF0Vjmpd1GYa1wAUUHQksXHwj4BIf4RRA3B7dnL8lgoTe5wVinsLPgSJaEGyqUE/K99sNCRb3ak8BOIx5ZfQgrc7joK4uaKKYKEPKo6XP7dNMXhPHDM5NiNM0zMT1fpjla6GFKEn5YBZ5pGukApF9SwjWQjl1xDzT6VXaaVxjOBCiQDGNA4Rdx1/X1RPmsaRUzO4gET09R8w6bW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(366004)(346002)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(38100700002)(5660300002)(8936002)(4326008)(8676002)(6666004)(6512007)(2906002)(9686003)(66946007)(66476007)(66556008)(316002)(6506007)(41300700001)(82960400001)(478600001)(6486002)(26005)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aAH3HkP0Rf7m0azBVXV3a0aQYxajm5bvvk3SOn2RpTq41hoEHYP4jIURer2C?=
 =?us-ascii?Q?EfmROjf1qh7+1p+gsXQCSZ2mz9vv0kdIWufGIIRfc8kC48aFrTk7YParzhzM?=
 =?us-ascii?Q?pTX9K75V2wqHW75F3nsjMAtZ4SPjYXYPuoHICEishGbDcEHQK6R/XLARMjB5?=
 =?us-ascii?Q?OMvkQ2KtVSxqPGFKFVz9Re7jMuCtlECJzZTaHOhXaLL7SWwj5IEt+9JdiYP5?=
 =?us-ascii?Q?IULpJJXz0o05CaAIUBoUaybDyl5n6lFC+C7jhX52J37Kc9JY1oNhX20XG/uo?=
 =?us-ascii?Q?XL9lxoevcLIyY9+DhUjxRQLMWfuc6GpGuF2N7BHk3gVQVKhYBiLQt7shcd96?=
 =?us-ascii?Q?fHrah8AzskUBOaXblBmGegp1MBKi6xEvH9DZ3bM92VjviPnHOocJ9ByYbA9x?=
 =?us-ascii?Q?i1TrSn4ZgYTrRTbcWUGn1hl0Fq3y7OXt81+OUB3s2caH6mZbbA9j5ZlQ1Ahx?=
 =?us-ascii?Q?/L5I/VUGwwNsbynrGHTsar/j9WuzuMrzTeVwkJk5J9FWdN0TuTLybuQM90fT?=
 =?us-ascii?Q?ZQ8FhFKGAdLSphZJb/2KUJxGb+TU/X6yT5liNLWBFjXZyR+9igDdqsKCwi/+?=
 =?us-ascii?Q?Voa4oJCUjXqRtcQmXpP2mLIhAtWU9W3sx6zfhds9WMPlL0xrtj9wOyDbB0Gm?=
 =?us-ascii?Q?zihwJkwwQDQvQFFVOm3j47m9FFdICPTDcBpvBelznWkq/lk9Q1GkT5I/HyZV?=
 =?us-ascii?Q?zUrsEszcgYhTHg0B6Tz37R0BvgAuLjmRw4841YKuT8gN6TSQkOtcRnH94s9p?=
 =?us-ascii?Q?9ww3vUS5fgERK3JGhgrteAEHZisHSu8NdXkG7fGrQHB6ZoPjLMBnMCLUohTr?=
 =?us-ascii?Q?u6KByjxpNmP+uKzBNwxF6MBSbkxfWtxlKJWdD/HlLUV9a9PAdvs1NnhV3kio?=
 =?us-ascii?Q?d/wy5ioxFgNllOCdM31mHxupUn26YAjgsoLS8j5PJ8koPoi72eMe5TsKdC2w?=
 =?us-ascii?Q?e5L3CG6tcDuqIAI/MkxaH59TaZH0WMW/xd3h3hDP/QAR01gLQwfJ6B0LV8jE?=
 =?us-ascii?Q?Pop2TCiICaV4M9PXJnU7aYLXhRTwTz9kjf2IUjF9N7gx3yuxA7zzHWNENRtC?=
 =?us-ascii?Q?82Q7CpqVvlv3mw05nkgP7KQhIfrtUB6bpO6iet7aNHeseK382k44LIbrAXE4?=
 =?us-ascii?Q?ffpsd1ifEovB63YC2MzXt6y/atXL5RZCutV9JtI41hHCShJl7CN9w9MV9oGY?=
 =?us-ascii?Q?TUWRAYz24/g3DWgFW8A4r6QmR3aDz17eHMbg1uOtZdPyfolDN56oaOkXiyEb?=
 =?us-ascii?Q?B7rlsTtknZ1LMH1g7xPyI/Qc2fuUMRF8nE5tUJCNaAvVamPcyzkJSwQ+LUph?=
 =?us-ascii?Q?R7/2OJtA9SyVqMG1SUjtQ3wL6hm8yL5F5xaHRFE1mrrYRS3FTH0LJ0kBl2Ur?=
 =?us-ascii?Q?WVgrpbfcGcTT8Gi5EeokF7H4NL8nKIXXl7nCkx714VstaWWrb0QrTocq3Rut?=
 =?us-ascii?Q?/S4QALO5nALPkqSBlbzCO9T5Mkw/OLIdqJx744fWW0Ah1i8NRbTVLS0wr2YD?=
 =?us-ascii?Q?oGGlBHsSYfO7lqeW9AGhQ3hWps2qIdKZ1aoFO1IhJzo2zMIEvsk3jHyDEvBC?=
 =?us-ascii?Q?RhWtz05JD9w8KIateZMYPQitdVS5z7eowDUdiH06TRVsog8WTgMEK8L344C4?=
 =?us-ascii?Q?Vw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f91be179-47ad-487c-4e1d-08dc002556d9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 23:59:15.7451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6tq0RrGtRbsJdRRHqRo709D13q9hC+xFHKX4sn6n8Crt4XzbtuNQ+po06k4/upRufkLXwAzXripIlt96+ycTX73nxhOsEvMYF2RTHo2zLOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4761
X-OriginatorOrg: intel.com

Ben Cheatham wrote:
> The CXL core module should be able to load regardless of whether the
> EINJ module initializes correctly. Instead of porting the EINJ module to
> a library module, add a wrapper __init function around einj_init() to

Small quibble with this wording... the larger EINJ module refactoring
would be separating module_init() from EINJ probe(). As is this simple
introduction of an einit_init() wrapper *is* refactoring this module to
be used as a module dependency.

> pin the EINJ module even if it does not initialize correctly. This
> should be fine since the EINJ module is only ever unloaded manually.
> 
> One note: since the CXL core will be calling into the EINJ module
> directly, even though it may not have initialized, all CXL helper
> functions *have* to check if the EINJ module is initialized before
> doing any work.

Another small quibble here, perhaps s/may not have initialized/may not
have successfully initialized/? Because initialization will have
definitely completed one way or the other, but callers need to abort if
it completed in error.

> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Did Jonathan really get in and review this new patch in the series
before me? If yes, apologies I missed it, if no I think it is best
practice to not carry forward series Reviewed-by's if new patches appear
in the series between revisions.


> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>

With above fixups, feel free to add:

Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>

