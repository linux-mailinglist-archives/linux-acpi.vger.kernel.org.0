Return-Path: <linux-acpi+bounces-2561-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3598191B3
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Dec 2023 21:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBC87283CDE
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Dec 2023 20:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319E139AD7;
	Tue, 19 Dec 2023 20:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I+OS/XLm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B8A39AE2;
	Tue, 19 Dec 2023 20:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703018949; x=1734554949;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Cg9RC+P6bD9AcRwJGT8uwUPQGvWEaEnKIBElC+m6TzM=;
  b=I+OS/XLmXOnHwMfcDYzORRsN4l/TCwzmSMOlc53h/o4uetuLpy7FpCTU
   kPozExwKrGa4fjC/gUuezMI72IlN0YIH0c1B87xTjhbc7C4FoJnCH6GdL
   ophphhjv7oLuzKE9ogltSFc8KmAKo16DuctSjJNUOgdUhJRImhNXPmUVY
   n1imr59fCSnKB/DV8rmxyIMPus03Rl3WkeMcez43lqBZrEEhq5x5QWmRL
   LVj8E4J63eGjDzQVy9JE5KqZbYIBdWZfnEtVQ6+jdxN9RFbjFwKl+AKcB
   uFbeFo2Vg94OKAX4IjD710N1745U6vds3m6XabyUznQr6idayqs0bcI1a
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="399549836"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="399549836"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 12:49:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="10527175"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Dec 2023 12:48:39 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Dec 2023 12:48:38 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 19 Dec 2023 12:48:38 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Dec 2023 12:48:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9RViAwP+dFgOslB9kXhmC1XBitnWmQRQfpRWrysSUNTgrvqY9+1JZtAj+wgvHUei6vf1N5O7B94LR9tmC8mqNQKmb5mx55ei0zbhMQ2H3EFAvuEMIyB/JZCMP3O4FRBNE8P7LG2kDoNpJ3FbWn/Adap8st9qhVOV6CLk7oyJpP3Lxdo0RQSVJBlK2QdD9t3GJ1LLZxwNDinuG+sXWFtwDCfzw8dqT8k/Z3qaUvTgHVlWPSeS2QHTiKJJ1xvnERZeg2X2h8e66kLgjGG9whqEHuOF1pYI3bgP8Kr3LQkFvuf122VPxWRioJUhgqnC74zmpGHlJ6C/mwksAvFEAxyQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=glQdfVtwYnMG/G65KfiK3amOeDUZeSNIJuMu7jC/b2o=;
 b=NizPoMeKsUOSQi3qYqo1lTr5veITS9KXS+5YOcrtS0ez22J/jJdUzjS4cQBcJSUae5li7Yt8Jiw2JKffhTAA/oTdOJz7MojSXTm0on8FRPBw1tCAPbgGe9Ecz9A1j8uc4mfbHow9far7QXrVRWQN9hK/LHVwkh3knxdXF/gN08+McHNl8Ux2LTcGW898Cjrc9ZAXDPgGGV8Sq4KMFPGcaA5ggNBJPCh3n39snLc+eXY49T9j1y/XkJppkQ6EhBhCOnBui5xi/HUnuOPX+XaO3HQmM1UnnEm+5ZiFD27bbYt0w8kopIeG0GIjvjGDTWYEswkORrdfGDAlKFhp2amwzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB6901.namprd11.prod.outlook.com (2603:10b6:510:22a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 20:48:34 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169%5]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 20:48:34 +0000
Date: Tue, 19 Dec 2023 12:48:31 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: Ben Cheatham <Benjamin.Cheatham@amd.com>, <dave@stogolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <rafael@kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v8 2/5] ACPI, APEI, EINJ: Add wrapper __init function
Message-ID: <6582019fd0b2_269bd294cf@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20231213223702.543419-1-Benjamin.Cheatham@amd.com>
 <20231213223702.543419-3-Benjamin.Cheatham@amd.com>
 <6580dcd03b49c_7154929487@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20231219153955.0000473d@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231219153955.0000473d@Huawei.com>
X-ClientProxiedBy: MW4PR04CA0254.namprd04.prod.outlook.com
 (2603:10b6:303:88::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB6901:EE_
X-MS-Office365-Filtering-Correlation-Id: a311179f-dfd9-4d40-8e21-08dc00d3ddfc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wIf0YDPxma6TARkacLsut06LwAc9VKgIS/Jpk7A6gkCUwT93DwgYO3+ZKmw8QghLUzrBwplE9vdHJVgkey9OUbOdpc55GshGTQDQFxLZdhSKX7UNTX19A32KXf4D0W0ndJr0aUp6tZiQNWfiBq52lZ4jxX2u0/2S0VL/5OkQNcAln+MApIZmKXkYsqdyDsC0bkCZMGxURXvBc6GbGnlJrxYdYEI+7JuVk03NME99/C9hbJnUS1PRXnLTEuGUS+i9+BeDiq88xJYiFjkjhxlxNcRY+cg1NcB0239+6I3AyjQcP8ePf+RM8V6PuSHEb8grFpW6Ks5bWTgiNOfw0iOA+xNRtBuRCkaSt6AGFANOWwUQn1TBYC34bnJsLDVK1Toq4MELqAhgxZC2d76z7HtidgUVfGCPjxLeaZBcDaBMVg9IEeFhKuMmrDJCdFjuSfG7jQJstZz8WRN9OKyMycJQwd4LQYd34hswI0daFuFXGNiysqC5dOaznazvegaaH2+GCChaRjFry1dTAYiFo2vG143thXMGOHOY9bXSOIrobdbplxP8FfbPsoAEmH8YW8WI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(6506007)(9686003)(6512007)(6666004)(26005)(38100700002)(82960400001)(86362001)(478600001)(8936002)(8676002)(4326008)(110136005)(41300700001)(2906002)(5660300002)(66556008)(6486002)(66476007)(66946007)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Bx1v4uqUOXxFzRREAjdL5I9DmlDnBU4OB9kN5wgzKS4EYPh8Kh9uyUyZ3/ZZ?=
 =?us-ascii?Q?ja4niD0PaeMdEQ9TskX3KNoZ+8uGb2wD6dsZz67pEt7qKW68EAHmWadGpllA?=
 =?us-ascii?Q?ND/aJs4Jymoswv6ziAwpIL6L9ICnW2lm/oHlLDB9xZJutdRNiFSNUmao82/d?=
 =?us-ascii?Q?sRo25IMnJAsKijXI+CLsy5ZMSjH5JeGNFVBOs++KwSXYNsX55xqZQKygC6bc?=
 =?us-ascii?Q?IW4Zx+DOn8cHEY1fc/4YnOlUkr27htOXL5W9lS9FtrRXlXF4ifaCGEnlEi+6?=
 =?us-ascii?Q?sKR6scH5734uzPl9SxOmxNi7ewps9OenLqFvNDnp+phdHMRvsbkucsnT+ci4?=
 =?us-ascii?Q?2x4ZVy9YgJzHhpHW/MsBu5tHz4MD2J0ArHng7p7NIS2HKFP6msvRGrkkPahF?=
 =?us-ascii?Q?rxFf8KBUOyH+yinxil0Cj0yFYM+hb11SsBFtVE/5hZLu20KYNckYOs9WVhVx?=
 =?us-ascii?Q?XH8GGeLPEPUH7YGkizG4uxrPCi3TdpDWa5bbv+jfYeeEMVgc2Z58Kudo5+ag?=
 =?us-ascii?Q?mTIJj22zRDjZFS3EU86U20coZOGb8/2mcJ78Ul2SD9Gk8Q6+i9yzMhNqQIXD?=
 =?us-ascii?Q?nhP6i2ntV7e8AntoS4lF4PP5GKfPKhAes4Q1tWokVQ870jCsLd4PTm+YA150?=
 =?us-ascii?Q?0is99xl81HwJhL0ad4SQruZtlEWzebpVxUfSs/yvRj0CSVTGjpnN1Dm8uLYg?=
 =?us-ascii?Q?HfqngUk3UsI+1VK+DkGsQUIvbA0LNp2wpkbuCFhVMk/gjTC2aEyq9dAhUCYM?=
 =?us-ascii?Q?mj2+TUWX8+XP8aC2Wte63gl4XtW+Ee/DaKVEYEH6AyqkUPQYcudvntzyOruW?=
 =?us-ascii?Q?mXszK1JVN3nQT9e8osjhmyI4h6RIDSrobrL5hHBLlPtR1CzS+qO4+lth5nCt?=
 =?us-ascii?Q?JxBaEb2L1LbF/6UNEIuNmZxKx86NbVo4mLuhjfnJK2Wq4gXzfJ0mDnvo+wzb?=
 =?us-ascii?Q?6/GlKHywxOeQ+PlARfTv2xGNAr5Dzz5rC4AhWIPe6vdHuQTmf2pVIPPwlCOQ?=
 =?us-ascii?Q?+p8/S1bStD5J6LT0msimyD6PZUWyp9+ydm8g0jJj03Qj4QgQzcjBjhIEfOT8?=
 =?us-ascii?Q?DlytnKUCmhFTRkeDf4LIc7NcWM0UahKifqZsbOUagSYVZA/mf2ztd5WlkK1a?=
 =?us-ascii?Q?5VELHkjcqZKnQ06pqzuLjqMS6xK476pQH3Q6ybmB95coRDS4fd8ky5DG9ddX?=
 =?us-ascii?Q?17X71thahQZyMWAYyBHD4rbjFUHZsg9OG3/GBTW58bO5QZwan6vd3tAFCCxq?=
 =?us-ascii?Q?Rgh43pMR5sS7mUV/vXGXajwDToR9usnPmX4bEEH3Ziqi25LnIfZu7vpEL5cX?=
 =?us-ascii?Q?LlwPFcC75QIuqsCiXPfiRSu+tPgjxE2xFNKn99ji7ye8CcvpbgbyJEXW23Tv?=
 =?us-ascii?Q?9+ktZ55LWIX0X1ZRoFc/zegEr9h6sD+Z7CxCgokrRJ4gTf2YnRjZM2oJnuv/?=
 =?us-ascii?Q?eERGZfNGR3oTrTHepCgTKx8shwy5vfD7fzLI+01rEuTxEjXUUia5Y+r7vUBE?=
 =?us-ascii?Q?wxi1qdkbTw14sw0SfDUZI7po6shcraFns7E8Y/w1qTWnsvzl/F1ABPNwMMlA?=
 =?us-ascii?Q?HcQKe4W2cgOHquf96hPzwJCuPn6dWvjsqqu6D+9CY59pnK55851iBJxnirNc?=
 =?us-ascii?Q?ng=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a311179f-dfd9-4d40-8e21-08dc00d3ddfc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 20:48:34.3765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TwII6NX8b6Nmum3d0fe7zdcgjJTEM4FOafHkVSe1DJBfAv7R5vcNSDADaHu/chxNV7UVVvC1m4vTDVhQgPzczSWXbx5vgXwe2mkpFjUTTag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6901
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Mon, 18 Dec 2023 15:59:12 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Ben Cheatham wrote:
> > > The CXL core module should be able to load regardless of whether the
> > > EINJ module initializes correctly. Instead of porting the EINJ module to
> > > a library module, add a wrapper __init function around einj_init() to  
> > 
> > Small quibble with this wording... the larger EINJ module refactoring
> > would be separating module_init() from EINJ probe(). As is this simple
> > introduction of an einit_init() wrapper *is* refactoring this module to
> > be used as a module dependency.
> > 
> > > pin the EINJ module even if it does not initialize correctly. This
> > > should be fine since the EINJ module is only ever unloaded manually.
> > > 
> > > One note: since the CXL core will be calling into the EINJ module
> > > directly, even though it may not have initialized, all CXL helper
> > > functions *have* to check if the EINJ module is initialized before
> > > doing any work.  
> > 
> > Another small quibble here, perhaps s/may not have initialized/may not
> > have successfully initialized/? Because initialization will have
> > definitely completed one way or the other, but callers need to abort if
> > it completed in error.
> > 
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> > 
> > Did Jonathan really get in and review this new patch in the series
> > before me? If yes, apologies I missed it, if no I think it is best
> > practice to not carry forward series Reviewed-by's if new patches appear
> > in the series between revisions.
> 
> I'm not keen on the solution as it's esoteric and to me seems fragile.
> I've looked at discussion on v7 and can see why you ended up with this
> but I'd have preferred to see the 'violent' approach :)

The issue though is similar to the argument for the creation of the
ACPI0017 device for CXL, there is not a great place to hang the einj
device-driver.

However, since einj has no legacy "auto-load" behavior, I think it is
not a lot of code to have einj's module_init() do something like this:

	einj_dev = platform_device_register_full(&einj_dev_info);
	platform_driver_register(&einj_driver);

Ben, you want to give that a shot? Jonathan is right that my proposed
hack is *a* solution but probably not *the* solution where this should
end up.

