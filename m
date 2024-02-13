Return-Path: <linux-acpi+bounces-3457-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 916B185397A
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Feb 2024 19:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D43728A361
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Feb 2024 18:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626B0604DC;
	Tue, 13 Feb 2024 18:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hfBcygiO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5B86089D;
	Tue, 13 Feb 2024 18:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707847691; cv=fail; b=CGGWTASMVf6D9C/o/VvpUlnpAQnLih6w7UyMoMPm4Ji2cCfPNu0CGTDqKX2DdpxRK0q0+xLL5MY/IpnEds+ZhgQAhx3o9ktP9IZyFSqX/o6WAPRuRkObYjruyk0SeTOxleLE5DZLZzPJOrw9bhjXQqWJVExr+fQDpr4e7iOKe8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707847691; c=relaxed/simple;
	bh=NNBtiHo0f0wxgIFqKWn5kBIy5QJOMJES4ToE0NvMac4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HMkxVFgty7n2egCQZlbCzpw46JI7rINPUCRBch38lxPwT8Y7BCSxNcI/FCIKrScO4Hkvk1DlOfSz9byRJ2hnMWkoajaC/ggG3BhZqNw3FhBVemr8ZF1fUuSW74vpayHbXHqQdvnRY1O+TejMQWySmAa4nmYsWM1wiussUYvLXcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hfBcygiO; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707847689; x=1739383689;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NNBtiHo0f0wxgIFqKWn5kBIy5QJOMJES4ToE0NvMac4=;
  b=hfBcygiOHwWpovmfR/zs5sr3LsU/IThEtgSzMC8vrW80K4rX9eREJvxi
   9IJvu1oGw6hpR9ZQMWPlapT+TF58Uh+wJufu8QOdLGJiQLL6QUpXDHZQn
   deFW4UImhU0kFJFzqxlP5hsuYvx3UCyDEuOF8yXqUa0Nn/eFfViTg9Akz
   mVViWylCsKrIg02fGLk2eHAXfvNFxgRo1kqRMj1EICnPdA/unXJrrYzVf
   N2R9Cb+lD6/W3kpztzxmEZa/5ie9bWWxLitTQLalM19yE9MdM/2z4j4X5
   6ZBbvEsgh/n62XZrEfx9qx+yO9RJEYQ42OWdeafyVOFAx4O8xuFSgBPhV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="5690010"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="5690010"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 10:08:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="911854704"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="911854704"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2024 10:08:07 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 10:08:07 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 10:08:06 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 13 Feb 2024 10:08:06 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 13 Feb 2024 10:08:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZCRIBWWbjTCgN0jPH7nhPD4JtiRAcSV0HuaiNTPeVPMEVNZYvCM+7yUrlHszf3DQX/Q7LReMasBkN9NnoFf7XJ3BidBHp3Rwzp0Trxiy/y2V0f2aVWvjjd8KnxAnRePZ1LyteX02vgYLCEqqzKKHxz4+MG42htlzw1b1XGGa5A7NAH50QtGlmCf11MWBss7jQFC0ImyqXDKrU7OTg73WTirVKnyIre7e/zlu6713y5JXgCIh1M+MY142r/FMIQ46qMkhPUT0zN7/QQWer7n/AscYhTXtEpibFD/X54JfhpKKSsUeqprXDKFYVFvlKeHdTxAi7TMsUNkxM/1amtIXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihHN9gVJ5wNdGdwIyH2bRlCqOxFfHKgKvNccNtEG6eM=;
 b=jmRK3c7Dd4XFTLXRU3vkfx7YHilkpVKVLnSyiQs6jj7jKeTaWn3t5rZ1Dyal2KohoKJFALAgJBKjiCDyUyrXfgXfDrvJKQTM3cMr1NkMQXX0L2O6n2LzvH6+i456rJ6obntKKfVZp/HhoDUgR2OCxejEbYgh9JUfehz2uWONoTQKFkgb8bQa6LU//lP7JEApVrT8CpbHQOdkx+W36I1nlT9IUs78ATBHGQXJ+gQrn/7eGlHjX78tWoSLAGhtkoAejN2L+y76JgfAcudLMsX+H75i30IB0JVE8Hy/GBvaAk+uegSRy1MOFVlyesTrAqdkoQAPLB54zdzYFL04jIzVoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB7177.namprd11.prod.outlook.com (2603:10b6:610:153::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35; Tue, 13 Feb
 2024 18:08:04 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 18:08:04 +0000
Date: Tue, 13 Feb 2024 10:08:01 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ben Cheatham <benjamin.cheatham@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <dave@stogolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <rafael@kernel.org>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v11 3/4] cxl/core, EINJ: Add EINJ CXL debugfs files and
 EINJ helper functions
Message-ID: <65cbb00153347_29b12943d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240208200042.432958-1-Benjamin.Cheatham@amd.com>
 <20240208200042.432958-4-Benjamin.Cheatham@amd.com>
 <6cd90997-0dea-4dd6-ab8e-2630efaa6209@amd.com>
 <65c6bd181bd36_5a7f294dc@dwillia2-xfh.jf.intel.com.notmuch>
 <65c71827726ae_5a7f29434@dwillia2-xfh.jf.intel.com.notmuch>
 <2329b256-184a-4646-b92c-7d3f8589474f@amd.com>
 <81f10f6b-fc67-44fc-a190-450df00752fc@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <81f10f6b-fc67-44fc-a190-450df00752fc@amd.com>
X-ClientProxiedBy: MW4PR03CA0237.namprd03.prod.outlook.com
 (2603:10b6:303:b9::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: 8346949c-fda9-48ea-e369-08dc2cbeb8e5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hQL9U4CH6z84MOijTZQH6VLdGiTR8+vWxvYInIjX+ejq4ShPq2mqvAIu6oBJf2xLFeLWjZUt2C4UtkjVW0pcACw5JmmpKTuX2jD/jhry8sl5N4SZ+FovRHx5EiWnAnrOphW//zhosdvPmM2U6q7xnAPFpkYGjpsIaR5mQuYR2ql9pUEOBU2JHT1NulsHqtRUbch/bDu6Rt7ebBHPrvrPDnWWovk6ur7a5a4xazO4T5SdOArmZE3rVdRYtuXqDuw3B8slr5gmUdBWbwYLS/K29wY2vv2wyXd3DG+L92jJxHJMvKbhdniVlXBYMKrsVv8DdWaaLqy5uAicFAXfVqfiGvWAC8rmE1msk12+2SutEpz5bEK3BJkCnUIJN8fZdD5HdOXHrKVQeBNxJ3vu68J5hfeARHFG3ksL/Wm99NuGWskNKuIyxq+W1+9jixtLcIn/X8bEo6402q1sZP/yroHwi1dLd7FDcHkTKE0u2+V7UArZ6SBZsyz3fZZTRQiyDFxkt0JWdulTmfP2UFrAsyLFek/bz6wyNfmZsSPeZfRiry+5U34SnYnzMDZ/QRIhVEf1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(136003)(376002)(366004)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(2906002)(6486002)(9686003)(6512007)(6506007)(6666004)(110136005)(316002)(478600001)(4326008)(66556008)(66476007)(8676002)(41300700001)(26005)(8936002)(66946007)(86362001)(5660300002)(38100700002)(82960400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WqCL/YvwoAbAohugNoN8dtqDw3UzrZo/q+gTjmiYWacr3KqU5IDYrmmp6qUg?=
 =?us-ascii?Q?2+9rJjUh2F85xt28RZSSImLK0ivd7V7B48lFtoRvKrLPED3i5JW4KZfp9Clg?=
 =?us-ascii?Q?hG/nw17AGcUqnuC3DGEsoKCXdQhnIRLHrpxon+Lgxl7T6BiLQSv4bvytJSc2?=
 =?us-ascii?Q?k+E6FTZjR23KACNpP9B07ervIVBBmkX77vhOIPO4aYcB6MJIXxqN/li0+WED?=
 =?us-ascii?Q?FXjImRNCEmGmAwntQBB4mqLV6wMUVCEn/CJy1vX3kvKWClcxJ0ULYCrnsuis?=
 =?us-ascii?Q?HOmfX8xSF7GeYzfHjtlZoKcS/1ZxYEALViBgflcclApmTrL0MWrF3XCthWCK?=
 =?us-ascii?Q?D7i0YHP96AWU6/EXAUc4vYo18L4bx7WZ8QDkoDeibpUch/bS4D+DOjAqB9tD?=
 =?us-ascii?Q?cGXpHo+ziAN9s+gzPj2RMnC3APFfKd6L1BXyAiu93hXZvD006OjaBYU4s7LM?=
 =?us-ascii?Q?Ktb2cpDjqlZdxaoVVct1OKpCCSyb5pghcv9ItKbSG+2juAXNDOb6LSrF5H6h?=
 =?us-ascii?Q?oy1SYxMgyyjWpQkRQT2NXTVsiK/Hrc7otndNecWqbGJQ+VkdxWaKzcpa2pLU?=
 =?us-ascii?Q?NYjumnJBl2pqF1rSXZM61TwbqOtTTQnC9hKRdKvPJyOSAGEv3BxRiM00+EBZ?=
 =?us-ascii?Q?T8Njq/uZH0lFsQC4ijqDpDclzyuTpTgvmi2yxniua2kwEj0Wsyzh6SDYXYml?=
 =?us-ascii?Q?fFLI4cdktna0ZE/CBBUKq2HSVERUPCtgCr1N91RYZmIya47y9G4N9KYTuW3j?=
 =?us-ascii?Q?gM2WQ/wyYLWI9sJr+KAbbH1w6rgZYsyLIMRGINmlJkQxHMY2xWymesTIxgb+?=
 =?us-ascii?Q?N0zzewVDAKyb6Rw7X7/0XOPimMxdETm9zGeN3ReNS+5kw0P5uAoROxVXTXmJ?=
 =?us-ascii?Q?nuhV8SQI5I69nGQyjG7RA8usOmghA4NtiBLVQIlsZvtDt6j57wp1lZV0gcqv?=
 =?us-ascii?Q?EXlhUbfZgMzFzXmkLWhNistmtagpPUXzt/4SAMr6Xx8utoxCp+eyYegk6Jjs?=
 =?us-ascii?Q?StvI2rykYWYAVz69sCE5X4Boff0T8QYHeLAas/Pj7Cq0TXP5XUVsNXyxMnqS?=
 =?us-ascii?Q?UqKlGHp09YS6DU3TEoVqDuCMsy4vi80GFJUaBloO1HuSStExoHGLZ8pXRDch?=
 =?us-ascii?Q?sS2y+Y+/wW2DV4hy0/XsM6WAZk9bYXC630CrDUR9a+jgMLBFkxOFYlpDhuwr?=
 =?us-ascii?Q?ZW0KvJjhoquBQf1e8b+uEQu+VsKC29OsP8Q0Z/4ApAgb916LvAHJtGwc19Cj?=
 =?us-ascii?Q?NgZtwXC2uQTmUgCLIXqTWEYMbwMivitjQAB9cneoMb16fthD3SZpY7o9HDGn?=
 =?us-ascii?Q?OGvq77FZk85pa9CN/VfgB8VHdYQXO6rHd7N919kmPDAvF44Ze6VI4KN17PXQ?=
 =?us-ascii?Q?xnfc5VR7Oqh7DFAe+SdcXoXSmz/Xqv+2X53ehbPTdBruxfFarRC1FSTwUOy3?=
 =?us-ascii?Q?9YqtZmFtrRkMXHNgLeqXetmD46rOeYM57b1IcxyogjoA4uhmrcvrnt3FfpKS?=
 =?us-ascii?Q?2HnHWkZB4SWFJGIDLD35UUCw/X1/Gn7FwvM9aOMi5UWYN7f6+Wf/E/+gNB/e?=
 =?us-ascii?Q?0TXsF0KRdmIlMzWcPNxn15Nlz1fGDl/mm2QUylN6kkIe40TYV1b9W/IjK7qd?=
 =?us-ascii?Q?VA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8346949c-fda9-48ea-e369-08dc2cbeb8e5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 18:08:03.8629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ytFWFSXz1B4QdPDk8+o0TUI4iKOQ0GRJVcsu70a8DdDd4OhQNCbWaTQ6yA6UWUZQVJ3fW/BB8OgXBL72th+EWeyXapwMgUMiOdD8e4I9ydM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7177
X-OriginatorOrg: intel.com

Ben Cheatham wrote:
[..]
> >> Wait, no y == 2 and m == 1, so:
> >>
> >> depends on ACPI_APEI_EINJ >= CXL_BUS
> >>
> >> ...is correct, but you need IS_ENABLED(CONFIG_CXL_EINJ), not
> >> IS_REACHABLE to guard those exports.
> > 
> > Ok, I'll test it out today and let you know if it works.
> > 
> 
> Alright, I tested it yesterday and that fix doesn't work. When I
> change the guard to IS_ENABLED(CONFIG_CXL_EINJ) and set
> CONFIG_CXL_EINJ=n and CONFIG_ACPI_APEI_EINJ=y/m I get a redefinition
> error in einj.c. I've found a 4 ways to fix this so far, here they
> are:
> 
[..]
> 4. Change the Kconfig definition of CXL_EINJ to depends on ACPI_APEI_EINJ = CXL_BUS.
> 
> My vote is for option 4, but I figured I should ask to see if you (or
> anyone else reading this thread) likes a different one or has a better
> idea than the ones I laid out.

Looks good to me, it is the easiest to understand. Everything else looks
like a Kbuild unit test that only a build-bot would love. EINJ needs to
remain modular for the non-CXL case and if someone decides they want to
turn on this debug feature then CXL needs to be modular too.

