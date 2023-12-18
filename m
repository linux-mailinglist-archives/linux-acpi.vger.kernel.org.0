Return-Path: <linux-acpi+bounces-2537-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1817C817E41
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Dec 2023 00:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FEF81F22934
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Dec 2023 23:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB63760AF;
	Mon, 18 Dec 2023 23:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SOaxHKcZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E7F760B2;
	Mon, 18 Dec 2023 23:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702943290; x=1734479290;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jnnbbZqcW+GqU26TBdoQDsdIDWEBRab1fE+8xn6UOAk=;
  b=SOaxHKcZkIlVB9+thxAjKOQO1FougfhzFhXws+ppqwZDgAnw953FrcIi
   Qrf5u2QDELzHkOkO9cM2VOoPuupGo5xPaiKSOf25eK0TX5ojcy4IAnq7G
   I/3aNBa3iBPTORy4a5+nGZ+UtsJZ///vwLFe8nQosZy+Qs/eBqTtSmw/j
   mLeD1/QLrqs+IIl1804bb+4lxPrsPvZx8GmChNdFvxGbAUbD8aohmTqMS
   Qdha+l0ULuJ7g0ljp/CIWdHXF4f/HoVai5FO1OWCnECrl5Pzg8InbRnIh
   yohLjvCdJ1R5A9H+JP5o1fpNZqjn7kAJQ5v0KI6izm2KsiMeWF4pfmqOY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="2432716"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="2432716"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 15:48:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="751940640"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="751940640"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2023 15:48:07 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 15:48:06 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Dec 2023 15:48:06 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Dec 2023 15:48:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNs1gVUrDZPd+Gg1JbsgSqFvCNtThsCAPY3OURCxkoXfRSVCPxhzoP1WHg3fIfIpvaJh2rue4KeCmjn41TeduOvz5E/MdaS57zVNkqNK2c91W1Nryb81A6ywgVblpGOkVeuMpbwk/9xSU+Qlt93ohQTZHWXIdp91AEELReiQpLmFK0OOMiGkIbp7+dkWrVGwpQ+AcNziPe+3Oq4XG5i3QcRkCECLfAF5gmQ1+teCd6+S0HKSoQ7x3dVZ0fgKCMLaTl6tSr4qVDHsr/OFfYL7I/MAU8s7/KKNH/UVYQzYYKhniNROMoEYAUcOmRRHaaDWxc1DrMgYJF07toXWU3tmqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UJ5Ck6X6jzXS33AeryQzYskFDynSaK6aCaaj8vYczQ=;
 b=ZB6sqOprpa6cV3ktSr+8NASPjCZXKwD1LW/8wInp0vRje67oKe3vPeow4Oxebxz1SkBKXfHiwqNN65XErDHw4rQcLwK9axHKC/cK1CKwRa3e/w9Xt3xMxCxeccR12DXsyFp6OQtKaD5ZEd1eGJcY6lV5CKT5+BSQJTgqU2cg11Q+5LKMj4xmpanh9wQa0nCKwvFGZngOyaiT4CS5ifUBeMwkxkfivMNjKk13BY94xAi6mTX9xYxQ2KTBAddDhLyEhSWBvIPxIiItIfHUfkYXlZK9kKKh9MN4apOFccNbb2U1nZrHGZwr7FS2g9dXArPmfrK71cCgdbsdRlYD7MrtwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL3PR11MB6531.namprd11.prod.outlook.com (2603:10b6:208:38e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 23:48:04 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169%5]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 23:48:04 +0000
Date: Mon, 18 Dec 2023 15:48:01 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>, <dan.j.williams@intel.com>,
	<dave@stogolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <rafael@kernel.org>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<benjamin.cheatham@amd.com>
Subject: Re: [PATCH v8 1/5] cxl, ACPI, APEI, EINJ: Add CXL_EINJ Kconfig option
Message-ID: <6580da3199b15_715492948@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20231213223702.543419-1-Benjamin.Cheatham@amd.com>
 <20231213223702.543419-2-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231213223702.543419-2-Benjamin.Cheatham@amd.com>
X-ClientProxiedBy: MW4PR03CA0330.namprd03.prod.outlook.com
 (2603:10b6:303:dd::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL3PR11MB6531:EE_
X-MS-Office365-Filtering-Correlation-Id: 31571a8a-3d6b-47fa-3624-08dc0023c722
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: afdALHsEAcGOixRPIR39AK2DvijCqUEV9Ti6tkeqT+mi7Qm829CAPsUANHtmrCgLZuktivjXiCycc2W8F94GKBrc3GMzQ10rSmDTfvsw1cPFQ6WFuA2JzapDHUuO9TaKDOHCz58QGbQkFt+wv5GcPL/ziI5pSYEVnP0m9NBrPsh6M6Vr8qdHQ2RYqf5LmMZkEu6WRcfpyaYnpxkTaimrdbhDqwI0Y8SeQHDabLNx98gjjR+PBmfwjnJjqlLvbrN6WG/y8u/lM3GLL364GhQD4tdqE6DODop75dpr1RWM1lcH8T/CEQoX7DhZ75Ut+fgB2OFAZSCTTT4bnT7J4CM4EXZdGfgFjpX5qbA9pSJtbQG1oMc54X1iGfJPY3ltaDVHLxE5Q9714bXVNmZ7dt//Bgawrys6wPGfc/sdaBq3rUeyMYs9nOqQDJVJPMUlfBY3opr4Kon/vi+Q4mQuqpR6wdzOTFczil4Ff6fEAEiaPl2mEXyOUyVMV359MPq0Uh+lAE41wkX/oQBSZ0T+uPJP+r3ZqqY0E/77euu4Rj+/HK6+LZIf3dV+B+qKSDyeJfenYbOaXsJlkXWIn5ur7tIoEEKivn/ieVw1rr+IjtEG0ic=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(346002)(396003)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(82960400001)(86362001)(38100700002)(83380400001)(26005)(4326008)(66946007)(41300700001)(9686003)(478600001)(66476007)(6486002)(66556008)(6512007)(6666004)(6506007)(2906002)(316002)(8676002)(8936002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pRLScBMHXf6PUKvyUXMX0lddoHkT60EqXvAzbOEYhoRjFc7nWzyzJljb1VDs?=
 =?us-ascii?Q?ptIpnsZ8OwATJpZvU2mliWO+wds7UrkFh8DshpskorDcf2l4CqXdIf3acA+K?=
 =?us-ascii?Q?bsm3pn9FdQ14Wlh9XgFwN9tOJAZlT7nOHOFS7ZTtH7mzcsDKDiBR5+yjOMZE?=
 =?us-ascii?Q?+6T2HZkZC8DNjjbgL82sNAjpvaJ2kg5WfMxAwwxk+LOwqFrfioPm0+TU7/dU?=
 =?us-ascii?Q?/aDSFPKBe+z1iYOZpVspF5aUNqH4y90SXlFeWLl5nGvSqZugYz1IwBpRle7s?=
 =?us-ascii?Q?MScEn/DKAOD7rMCUEKsVEgjt9OpRuhFdoufZCe/r3IWK3Ha7tedW4h/71jt8?=
 =?us-ascii?Q?5xkAqL5A1tQAdlfNUQ/qbedeuZAonmCPJ1pHuQV561sXjlP3hDdN8WpKS+nc?=
 =?us-ascii?Q?jy9JB3tE4wzbQRPaSpgy7rY9IxyvW8AwVvKatqZNrdNOf+C8GYzzfJLVp7uE?=
 =?us-ascii?Q?VmJDf19vfxD9qIwPgm8EGaCc6Pwjx23EHyKOut5GjzqRCQRjfqs9Spx4MGqu?=
 =?us-ascii?Q?LESBqIQwiR8YgyjSAKqhV0NiZ93q3quj7AsLgLTXzdrCQ0eg3KtIsm4Q8Gqa?=
 =?us-ascii?Q?Jbe8RAm15iSDM7IGco2rzZMJcvc7423pCggJ/rQw3n5gEz/FHn/esfff9Ut1?=
 =?us-ascii?Q?j1CK5+J8EDXyypHAtCErX4tqWMbuoQQZ1L3VP3lShQdC2NDhbsA7Dsp+4pew?=
 =?us-ascii?Q?aZ/ooQzuO5VRNXCMetw9e3W/1uP03/J6BfBWpZ2W7GQx30dOPslrRM22ghZB?=
 =?us-ascii?Q?jNJ4axgFsdjyCeDeE/Rp8Aoc9Sk9OcPcZomWhsJR6PYlrdxW7+ysnYChIPyC?=
 =?us-ascii?Q?l+dg5oj/YUrL1qVQiYNshv5bNaOTCrx83ht1LmyhW8n6/nHNQ/wbs3Smn2nA?=
 =?us-ascii?Q?CjM2SKzBXgMv0uxR9X1qS8JGNQkf85BeOLIQNLKZJbhFv3wu7htmfI71YMee?=
 =?us-ascii?Q?NMamr6WnnM+TWsQBh5/nHEHv4H5QSObFTmKiMkKh0uoNDpwy3RcRRJ79OhWQ?=
 =?us-ascii?Q?u+xuCqR5nVTgzzfcAksidXLZuttSHG2+cfMTZtxiUsI77b20JmjUNmDNeXmY?=
 =?us-ascii?Q?I/MWypHcqCeOWo01nYGUtcPuIMY/wfgPYMCk+4IaCJa7vczbtza6eWAvaCBB?=
 =?us-ascii?Q?s3XXDI2+Q/iClb1K18dT+DD+pw1c14L6UVo6ai9Qo+f6ipMu0JfzK4IOsbXV?=
 =?us-ascii?Q?zlQ08CE0MMyHJ8IWqoPKGzC7l5sAsgrAfnwLp182ORPUL1Ejl41Ru0OUaRfe?=
 =?us-ascii?Q?tVJANDUc8KaHPuM2EtjL/iZqWZ/8ltZRSyO73QysM/XlHm0bv80rraU/qKDE?=
 =?us-ascii?Q?K6OyBEcDftGkPO+dW6a2lP0Lmi3biGQdqYtV8mzNzWTmIFqo1XAlkEYGNyjG?=
 =?us-ascii?Q?VeYncFmcHqGh4w4FbRsGgC0P7imFUAM0kPebZl13v/KbvLf2mdbC4fTOR7qt?=
 =?us-ascii?Q?h0nCeobvYhv6Xw17favpHAeMNpqwZ98ewaF5i/RZ4QfxQiLYDEEocqyf5ZW8?=
 =?us-ascii?Q?RE+ONcT2mL1R+8sZvEERxfzqpFib3K2CPHIRznS7ZaY60nCuKGs5x+72h3ap?=
 =?us-ascii?Q?eUjpYZtwuHJQ2y1qlIbaY+4LQauhwT4KamBS9dwAEoO7v9eLlr5DDts2X6qB?=
 =?us-ascii?Q?Ug=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 31571a8a-3d6b-47fa-3624-08dc0023c722
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 23:48:04.6663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: atVARm0RidrAE77jW5MH9VBq8r45EclZRXXxlz2dsdXqLj4+ptjDuUYEChvhDKJeHPRMieM3RP/FAM/jhFx47CC7Jys5/iwpgFDZ3W0h7Tc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6531
X-OriginatorOrg: intel.com

Ben Cheatham wrote:
> Add CONFIG_CXL_EINJ to cxl/Kconfig. This option will allow for the CXL
> core module to access helpers inside the EINJ module, while also giving
> users the option of disabling CXL EINJ error types at build time.
> 
> Also update CONFIG_ACPI_APEI_EINJ to set CONFIG_CXL_EINJ by default.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> ---
>  drivers/acpi/apei/Kconfig |  1 +
>  drivers/cxl/Kconfig       | 12 ++++++++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
> index 6b18f8bc7be3..4c3f0ec5731e 100644
> --- a/drivers/acpi/apei/Kconfig
> +++ b/drivers/acpi/apei/Kconfig
> @@ -55,6 +55,7 @@ config ACPI_APEI_MEMORY_FAILURE
>  config ACPI_APEI_EINJ
>  	tristate "APEI Error INJection (EINJ)"
>  	depends on ACPI_APEI && DEBUG_FS
> +	imply CXL_BUS

This can safely be deleted, it is sufficient for CXL_BUS to depend on
ACPI_APEI_EINJ.

>  	help
>  	  EINJ provides a hardware error injection mechanism, it is
>  	  mainly used for debugging and testing the other parts of
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 8ea1d340e438..6f4adcd733e5 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -154,4 +154,16 @@ config CXL_PMU
>  	  monitoring units and provide standard perf based interfaces.
>  
>  	  If unsure say 'm'.
> +
> +config CXL_EINJ
> +	bool "CXL Error INJection Support"
> +	default ACPI_APEI_EINJ
> +	depends on ACPI_APEI_EINJ && ACPI_APEI_EINJ=CXL_BUS

It is ok for CXL_BUS to be a module while ACPI_APEI_EINJ is built-in, so
the && can be dropped since CXL_BUS is guaranteed to be > 0 here, i.e.:

    default ACPI_APEI_EINJ
    depends on ACPI_APEI_EINJ >= CXL_BUS

