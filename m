Return-Path: <linux-acpi+bounces-3805-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BFD85EB8F
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Feb 2024 23:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D23371F22CEC
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Feb 2024 22:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0842127B6F;
	Wed, 21 Feb 2024 22:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SZiucnLO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E971272CB;
	Wed, 21 Feb 2024 22:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708553118; cv=fail; b=CUQNGzC58Jhq9X9zHy8auAyI/22KYdWaDbpEUbMw39T1kdK6keC47KBKwTF+J+CZ7mW4rCAwvRikoqymfy8hE3QkBB+WGC8xYlqKo0oxn3tK8IijZOYff8Wx+4Oum0oGuorr4L6eSi8AQJ9UQ8dZjJn4ML9fiX6c0A2+gbqqkEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708553118; c=relaxed/simple;
	bh=m1oKgyazDK4KlYKHyXSOYySxXvTie1hqctKHVB/aIwQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KbrC8VEYhdRN5yD+3VuA/1d7RVl6dcH8/TUrRXCeo7Gz4Nx4bDMHAu08I7zAFVFvsH+rMUzb897PwH0FMA9hnvCr/GUEENdzq0Z/aASSKQcx3HfLKOttka0OQdpHXsThyLGyRU/ULISt/jmjALrIYyDJa5m8GGLkOcf3HoI11NA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SZiucnLO; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708553117; x=1740089117;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=m1oKgyazDK4KlYKHyXSOYySxXvTie1hqctKHVB/aIwQ=;
  b=SZiucnLOyk9TRk7ErLFjpJUNbr4yRIVRkhK9c9q3lOHT/cweZfMaVfp2
   bLVTBXn2LXM/QrYy9zRBsTg0mS2e/Wwrg9zP22vdGBcSGx+1ZpArsX7lo
   sLR11J3ihyC3YVWG0Gj/IZtBOVSwgVg2Pra3B2X8YAJxj5o1BdgE0DpWF
   r8yK7Zg5h7YknT2J6LxC/op7Ypbieqlbjw4qAQNlU084cr9qp5hVrrJq2
   Xx0PllvVV0f5NUVEicfzO7mrd91qidDPfU/tvOrUOxiwRwV+M4JuLOhRM
   0T1BiL1wz/mHOANE1xjoM8ac66LRvMb5WW92vAdTdafNnxie3x9813n6S
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="6571550"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="6571550"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 14:05:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="36063257"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Feb 2024 14:05:11 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 14:05:10 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 14:05:10 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 21 Feb 2024 14:05:10 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 21 Feb 2024 14:05:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/e7WZEOgyZzE8D0E9daSNmR94GvtThoehheJF2DYJn1043FMNfbZdxlvDwESGewBL65Uo5//j4r+lO5lnGbO8tB9jRznaHzamd9pNnyaWMm//TQbnzm7IY7gtMRsD56NFXeU0lpxngOip0IBaWmWEMVLFnKbd54gvJg7iijoqBL8FZ8ibOkfKvXuvUGEYwl/0n/hi5Xs0V4J5P4wOMG2c1EZbBnwRZdc60fNShoY+LWilCWUb8vinrT5EaN2L3yQddyU+SEUEQTWuo2FzW40NTskxvIS0q6rSnIOogx9X/rODhEmz4brndY3L3aWQZpa4T8o4fFdJvjPjCkXBBqiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1oKgyazDK4KlYKHyXSOYySxXvTie1hqctKHVB/aIwQ=;
 b=Bk5qTJT44pY/GFwpyAmmRoJFB7Rag4zgpYbjMOnBIq8eQw4evnUsLxnhpudJA0sMfZGgpEOL13vdH7Ahp5zPpQnfJXPdL/XQ+bray3RmAqi/A0qeS667GVvHn7ZJGBjsTnN+9HzpbeT86WHKA8rk7Xky7EKIdLiCc4DEs1v6IHTGMzBnBVZGUpGdfaDrMdDH7QFNgtuRvpwzD5fc8w3um8eLpOBIbByB6nvuFHMLYkOBu/mV7uAAHBZhxjY5s3L8oe35LGO1o1NLl5Ez2i/AvuHSxpYBItnI85NgpFXEnnmeTMq5NLk2YbOG17aL/Nbz0d4vIjjjDVAzUpB+NkJR+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM8PR11MB5687.namprd11.prod.outlook.com (2603:10b6:8:22::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.21; Wed, 21 Feb 2024 22:05:08 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::da43:97f6:814c:4dc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::da43:97f6:814c:4dc%7]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 22:05:08 +0000
Date: Wed, 21 Feb 2024 14:05:04 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ben Cheatham <benjamin.cheatham@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
	<rafael@kernel.org>, <james.morse@arm.com>, <tony.luck@intel.com>,
	<bp@alien8.de>
CC: <dave@stogolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v13 2/4] EINJ: Add CXL error type support
Message-ID: <65d67390d35ee_5c76294b2@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240220221146.399209-1-Benjamin.Cheatham@amd.com>
 <20240220221146.399209-3-Benjamin.Cheatham@amd.com>
 <65d63647ecdb1_5e9bf294d6@dwillia2-xfh.jf.intel.com.notmuch>
 <5a650a49-8f80-4ade-8844-61f88172cecd@amd.com>
 <65d65ffdd40f_5c76294ce@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <f308f836-a41c-4de8-8522-7c086d89f167@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f308f836-a41c-4de8-8522-7c086d89f167@amd.com>
X-ClientProxiedBy: MW4PR04CA0195.namprd04.prod.outlook.com
 (2603:10b6:303:86::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM8PR11MB5687:EE_
X-MS-Office365-Filtering-Correlation-Id: c36d740d-6a03-4d34-177e-08dc33292a5e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I8uV8glwzYLoJg5NcQRjJ+evH5iwILDri2tBBNvxIt03sc4S3lgZvuV1lTQn9/PkxM6CpdA3E12D0cByghrzwcE7/QLWJU/isAwPQqfYvovG2rfLR/hZyrPf9U8jYO5yKmq71LUcAi5xiiWqruL4xePZlKvF2mYv64udl7zBDdOSDspbX1X3fnsHE33R3QYULLhjDBTCW5QYhorrwuyNEMOZkxFKXNSU+a2f11wm48LtOjD1P3r+aFHYJWLYkMDFhUyQxDPt4fBqkhZ2Fji149+FkxgxWySpkRP9SSes8eaNaA+9US9M1xeOo7pD/OO7lb/g5775OiE1UD5WpTywptGq862fp3pUN10+frqqmJzGp/WXV7VY9vK4uoXNzwY9b1NM7erdcu8cE8qctbzY34UVzK4O7q/3wsbGtnbevqbjEdjlabvxngsVCO9gebNSp2LcpTEtdbpYBhGl5QaK76Ce8mfEqiZ7CSVYIGh+YpMef3iEYyx7nPLvEOWc4dZF8KlfjqGbCCUjMIb/czYeYO5JVwaXCe/J5Vs5FfwdXKI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UxffV1aip9x8rGxnGk1sHoGxfb/xuQqZHEwNsRFdtcmBHBJdR1ae0jJwmIt+?=
 =?us-ascii?Q?K3XMa30Iqsi64cmWVjxPHfXpaU3SYGhErU7xBhEg7DZP2vlxD7FTshiW9Tdp?=
 =?us-ascii?Q?OOJbccGGLFs8esYd1QcYoVsBwTrKVSfG0ItD9xtEGOdeQD3CrN0N5ZbC4cyX?=
 =?us-ascii?Q?tKE5OKwYifzWlaivggLMYgC4s7DIrFdHZX23BHghMDGwkNVY56166lfi5Bo2?=
 =?us-ascii?Q?yMoLHwNHrm041zZS29h4+SdEMQYjZemvaBVWuqFKH8d4DFf/AmNbgNtWx1yU?=
 =?us-ascii?Q?BX7V3/Dv6H8Y260frW9c1gF6duJnl25QkT77HRwq6KTwv/VabNdQvs5odyBl?=
 =?us-ascii?Q?geXnV8SGTnXoSj551Rc3LB7mgjmGf8x8r8NPMh8hVQ9NoJcHLBaSbl1sJD6A?=
 =?us-ascii?Q?aqWvu3vV+42QpsNbkvRi8g192kU1u1Qu07u3d+Dh3URR21wJ/JMFW3RFoOSI?=
 =?us-ascii?Q?ewD/coKYzAciJZQvsm/stYfgivTnq8J6m41sK5QT7kmQEqnLZcEqXGGQQhRt?=
 =?us-ascii?Q?ECVtzyDxOP/Y6hNTsxrl85sQ+RFzA212xY0l4FevuKn6Mkm1zSkMim/XozK6?=
 =?us-ascii?Q?N/OUUuBH2GxR5RekomDh1WdPG0Qv46P8FamdoD0XCmTjcDd9tQKFA+wFar5n?=
 =?us-ascii?Q?auheL1Le/K0ZGMzRpEifjhZDiiOisRVGJURUeRuDd5RDWf0Swe7OXr4kKmuM?=
 =?us-ascii?Q?BACcOdLKw0scfQnRN5gwIJP/jJu7fcR8Tp9Z0gNt7XK+YEYfycBmimND2Q5N?=
 =?us-ascii?Q?UimoiooTeKyg+VpJI8IrjkCVc4JBZ+so1y9NKZYlOKLKCkpGfwdM1Ob7MjKd?=
 =?us-ascii?Q?9XbA77c7Ocp1bCjIroFatdEoHYCciZBa9adJQ4GaLCxlJzrxLEArIhsmivS4?=
 =?us-ascii?Q?2Kxsu7SsOLHMh/53qJu9ufBF4RR/8EQrlbXjobE2hEjEDskwlh1wgwiWQ/AP?=
 =?us-ascii?Q?CRgiwtILDBtEzmWdsQlEGdCYGEc7CEY2xj+9OEvfuMEfomvEZz8trVgdzW/1?=
 =?us-ascii?Q?r3Tvj9mE89DWuW5B+KEt/Fl7FhHA+x35FpkVSeKNgRnzU54z3nc/yn6fjwRE?=
 =?us-ascii?Q?GNVVyJlSfrB6XbfBV56w7qJc3oBevuXIpgd4h9TYwb//FTewi6dEGlxBDTdn?=
 =?us-ascii?Q?9SQdI5Glm/d2K85FqnEgjwZ005bzgKtYMdGAxVpfvY/9LOw8BAmjyplaSsFp?=
 =?us-ascii?Q?EtFI/Dmafh/+xmIVVqPj8RmDydZGiymAuvoR0Otm/MOsDQk/dYJIIvnNGQiF?=
 =?us-ascii?Q?XjdSh+S7MPrTc3yBb3GlJ197ZmX9oO/msCSvXPvcK75xkisX/VPPtzjHhJ5L?=
 =?us-ascii?Q?bc6R0lfm0BGynkbq8q2sRVB34pEgFLfHZdFTePJgJGcvyR3Z2uuH2ZFUues4?=
 =?us-ascii?Q?oKK53SEy+x/mH1Gd1TN0skZPjINaVXPV2Mwhqmwss/Jti5C6Dfp9tYq0zXPs?=
 =?us-ascii?Q?I87VdseSTouDL0Dd0LaQDDJgQEpY4ZBSCu3jt8ewZjxsThDyb18meaFoFNXc?=
 =?us-ascii?Q?P59aVb9GRp6sA6yaO8rffdU1FjPFeSi8eoQsivEqhgIyVJEi1C/4oLttZQD/?=
 =?us-ascii?Q?fWL67QUpf0H2m/XHGsgw345PSFTvBi+NsQq59KE6mxunxpxVylh9I+gjydsL?=
 =?us-ascii?Q?sg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c36d740d-6a03-4d34-177e-08dc33292a5e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 22:05:07.9445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QkKfpgmz9AUpoDu5w+TdUEAUuxVcB8KwQfDgJyP/R1wyzWq3zehkCAO9++rkyeDL4TXLekjfRVbeIqHgXfWumoYBUjszNGX9KlZnN4BLE+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5687
X-OriginatorOrg: intel.com

Ben Cheatham wrote:
[..]
> So, it seems like a bad idea to provide legacy access for CXL 1.0/1.1 ports
> due to this issue. CXL 2.0+ ports don't suffer from this issue though since
> they are specified by an SBDF, not a MMIO address. And looking at the code,
> it looks like EINJ error types that use an SBDF already get through the
> filter. So it doesn't look like there's actually anything to be done for
> CXL 2.0+ ports and the new interface is just a convenience feature for 2.0+
> ports.

Ok, I am on board. Continue the status quo of blocking CXL 1.1 error
injection, and let CXL 2.0 error injection be accomplished through
either interface.

