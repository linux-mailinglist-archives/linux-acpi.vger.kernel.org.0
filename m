Return-Path: <linux-acpi+bounces-4307-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD9F87A2CC
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Mar 2024 06:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C7A7283257
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Mar 2024 05:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE8F12E72;
	Wed, 13 Mar 2024 05:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B8VvELj2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F3212E4E;
	Wed, 13 Mar 2024 05:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710309505; cv=fail; b=lgAleilT1JE3Bq7CZMjPGI6H45W0HUdJV6uJ6xWWnp33RyTXl/fD+S+RF1KYnw+5uuLbhQxhexCgD3yQKfSV+0aEQKn+ippk+W3fhHBK5J88XqLoOjDl4GPXbSgd4GtASylsgeZtvebZ4b6tJ5VPYtA+OdelcSByFeb8YboPdaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710309505; c=relaxed/simple;
	bh=gQt1uXxOCvMBFMWGAeuZqcwrTUh5+4Olc92/KYCxHOc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=awI0sT3BG9wEsavaO6LaO8mTiDIbRFNurmNP1vtLNZUkU7rsIQffkHk5ZlqMBn3sBsTehsYtu3DgI/wMx3botGLGEZptoppw0w3I5vvGSaRbzIs7gDdc4G7zF2L0NR3/OBN65IAQNge9axKufRGVdYdTWkhjAfrnM9ZZ9pOENak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B8VvELj2; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710309504; x=1741845504;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gQt1uXxOCvMBFMWGAeuZqcwrTUh5+4Olc92/KYCxHOc=;
  b=B8VvELj2KAjYrLoUP7TA6DD62Q47dlyRmu4V3jhOmQb1UK7HzVl1NtZu
   lWvJzNf5mTdjsXEDKxBNcL0rlUiJ26B3dzgzP9IBnf569QI5pccjdo7SM
   G2157EIp8PuqVOA/HqFkI7kfpHAlqG8amPXdI6wfL6NWCmyvuIlj/08aa
   GYxQdL4rJgzTLAvCJc4Y8WbB0HhlGKS0df3w7KNmy3OSUTwPlIsZOQxii
   b49eoIPcJR9McwRwC6XR5xyUHFHHbSzaBfWt5ZxUUEJuTqwuDAZsEpMMz
   D7ktVWI1q5Sc6z7RCXcpj68e2Pm1oRUa8wvwaRpXqqjB1hKCCgK2TeR9v
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="8826434"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="8826434"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 22:58:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="42722656"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Mar 2024 22:58:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Mar 2024 22:58:19 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Mar 2024 22:58:19 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Mar 2024 22:58:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmwB+H9Z2aCf130WpyYA5QuR8y68tAW78sB/nkWoHLBEI/akAelnoEQbbndESHFg/jttWxyF2RQPNQ+LBzN6mF8bSjFZK0cjUeNYjsAYJQli0DTzUqU3a9lbLcBoO7QS5bm6KG7u+v9VQx/duPlumefzinqESM46LfJBjlBp4dUnWwDlDjckAShdW/B7k1D9+OPYP8Wu4hTGi6UHWTKX+DbFxN7p9/JPKU5QltmXSqvBAv+hbcIKrQp5A7ITFWco4l+rrGOhaTyBrdvaf3VmgOOMYhn7GlwFG46uZF9t2hUK+vgiJ7h9k8QD/q6cI19HvOGErd3URNxepPCP+7OqoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GsQs5I9x2ZJ2qoGFHL6TpaqREgAmXigs/ed0MPrhYxc=;
 b=PUm6w4dnP4QNe/8ptGw1EJRFmqL87+z61HXTH7VQc5z+s7ia++GcG3hSS2N9M6oA0XNZb6d2zjrW+YiW1n+R05BIP0L2Bje5arSW1zjIdySi2ps3mchVjXojqC6FOVPomxdCfmfVAxEpkqlKueqfo9CUTqVX9KJ/UrpDEgnPMXbGAPm2aF1QU8GrAzBGmik+OD/sVOzZhcRW7g2Rx4z7rC9Syzmo63kWM6M4wuJilDvfwW0L0Rs8T8P5xOw2r3Gt+wYAEGlHvvsp3H9bZIlg3GPBI36mm01Bme4Mvqm7fsJHihkk7q9JMPxpAWsGyTSgEAAtAKneqF7iTOA1t9WZsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Wed, 13 Mar
 2024 05:58:16 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7386.015; Wed, 13 Mar 2024
 05:58:16 +0000
Date: Tue, 12 Mar 2024 22:58:13 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <rafael@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>
CC: <dave@stogolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v15 2/4] EINJ: Add CXL error type support
Message-ID: <65f14075cea72_a9b429414@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240311142508.31717-1-Benjamin.Cheatham@amd.com>
 <20240311142508.31717-3-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240311142508.31717-3-Benjamin.Cheatham@amd.com>
X-ClientProxiedBy: MW4PR04CA0245.namprd04.prod.outlook.com
 (2603:10b6:303:88::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB4839:EE_
X-MS-Office365-Filtering-Correlation-Id: bee1fca9-6431-4eac-4258-08dc43229382
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YdSsdrzOXO6fHlBKdyWqGkQzdYFkfCtvSdAnJGV8xnyvH1JflW9OBCtzJ/xTAUFUqI3eKmmv9Pclz6yplUcCLfAt83OdInelgTSLP5vObVmb6jKtHBnzq/Wy1XD4fbL/uz6mdtRCOmgZE7HUsIZs86+QFS80r41Gka2JZ0X7N7/UCDI7PStuzFOqDCXFwji3+RsQq+xj4dRI4UMoUtubsZuzHLcQK1Y96xuJD8GeiP4N2jIVlZYg+16y9KPmbgZURF5krvIbp8OggZzkSaBHeztftJnc1oDritzeB1VOj9QkKM83Xr8tqWfnxTBH7+XOHrTyO9UvVVI4C4kbyqGtWEV/jrTpCHnAAZds/kpBCVY1KEyBCMy+w9fCSwC99GMkgsGd2yfGes8xOHm8MiF2tC+WPRJNAUqwmmfMw8NF0IIjJ98AdhlQvPvlL+juCP4DaWz+xWUSHDyn63YNcWqKSP9AlyLSFMRHdpjZRkLK9XxLy1ZeHTJ3pFhl7+Dbx5YnRYOD0xzXYGdcz2q0auUU78F/ceXyWeMVKaY3Q+WiceeOu04QSQTq/Mi/5gfTI9S2H4G0GX0uAuQ+DgA82hTmx9g2QVlL2KoYumbC3epSJmOrFRtZgXwhiYqIaWGVg4Xwi+J0xuvVaNCh+ewBB6YBE7Bmrh8/acZlqZQD60bKL3g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VfcIXD8JV5rvx3AMGeAtAiTzB4Xzae0lFyt9tTLHmmD36EtQ/1sujrWtkxHe?=
 =?us-ascii?Q?Hd4HIuOd+RR6tmvrQS+2zkaU5hzbQsYkYNqGX5fHTwuXI8oeCcyc1NYmyMAK?=
 =?us-ascii?Q?i4EKA2tKp6oPp1uxbxmMZYszvTl3Xn3tNe1Q0RzClIPtKFNds4Vuz6esqP2d?=
 =?us-ascii?Q?w3V3moUuO5eIusXxBwf4z2kXQmMRQzRPHnuIRbtM58n48XCffErXNa3R3u7Y?=
 =?us-ascii?Q?/gbEUnzWKwgtVn27moN6Masc37/U3AJzhF/k1P0LHhSiRPM8kDKm8c2G8yDK?=
 =?us-ascii?Q?liJyE2hrJZYqa06BpvTQAjLNDQVR/RGGeiXkPHxN9S+2mLbXHJWvhrMK9Q//?=
 =?us-ascii?Q?tqt6aLgzyHbA5I1T8hRFeoQ8ZJnNtO+mFPXz0Jg/hXRsEHOPkDFuv3W7oBKl?=
 =?us-ascii?Q?PhuW2ejvOrLEJbVnZXHHufGM3DbGgqM6m4DC/wKiTsLOY9aJC3XrTvDmvfDs?=
 =?us-ascii?Q?gPAx3RZlJ5M7ixpmL41VRHruZeBPu/DdEZkX4ZCqno6p/4pMkmgr3x3jGv1c?=
 =?us-ascii?Q?Rk4YTw5di9FFD0Y3JrOchouOJiJzDstb7lS8AYgIpKzSRTH+fgPMNNYgNCoc?=
 =?us-ascii?Q?mhb6EJAFSq35sk1feovHQt1eZLidhNXjULV/hFr/0KMW/YIpPcGbGwZLZrFr?=
 =?us-ascii?Q?JueDti9aMDTR64znj2HKXk6G4nnWrbdzSXcwYWkKICbZLr4JCL+eqx4iIege?=
 =?us-ascii?Q?t+87sgSggb94ZuS1wzXKQZOx+NtvUDlVF953l88VrZ2pUUNrSVQIC+FZ0yAm?=
 =?us-ascii?Q?ra8Uf/Sv7B3NyYBjwMtwXYWtfVBTJ7CrIVDBWft/lFwWl4ZQXsP5+KeIYm05?=
 =?us-ascii?Q?B/YYSLPOZkL+s0rjvaXTshbH+Sh1xhF6IjzL0/cTqTvBzPZ61zyNEHZtjkO0?=
 =?us-ascii?Q?uTAdjIwnj19x8ks7lWbOSJ+MixbImB4OykYbN7RANnQcXpMHzm0Az+H8ULmx?=
 =?us-ascii?Q?Szv6EYtbs6oDXKkyiuo2B/tClVeeZm+PB43GNYicf+4SMErc9kNvCaIUQsEG?=
 =?us-ascii?Q?YILj3gyW+P5ACQ87Fa5nj3qKXZdiMU6ZKFGAaBTBAGyqZ87YbY0YHoggz5jn?=
 =?us-ascii?Q?Ud1e/S1uoky4E3yYk1Sew94qIyNlicfgOIrpP+1NkUPZGsHEdiw8GtOse95L?=
 =?us-ascii?Q?oEaV0a7NSl8tAcm9N00STYxKfT/YCv1cO8seCPkByhNZMwL1PT0P145yihuz?=
 =?us-ascii?Q?HxzuY98OQLoyPsohrxBn2Va5klPtAQTtdQDPJY6n47Qs7R3lS6oyb7RuSXeU?=
 =?us-ascii?Q?UckNTafuIhUDtGVFLff8xc0dwkVYpiBRUmZMS/x44jFYsR3eJCFWfkwstY7L?=
 =?us-ascii?Q?z0r4i3a5+YpTVmKhlrNotVOiHCQpQC5x/DOkneWvE9l3LJIY7qP9URElD0QD?=
 =?us-ascii?Q?J7HxcDOIP3X0Ou2n0+LoomuT34i0TfCpV3fLFZjSB2O/YIESruLkI6X1zdiz?=
 =?us-ascii?Q?Rkj/eSg5d2nNV81/0grcB3BnQrAYh+XpFt78E3PKjr1Lu8XBTQg+am1FkEq2?=
 =?us-ascii?Q?fheT23kb05buwqmPWmLiwnf39THsD6Z4LV+hzOM1rzRKqBs7YAGWshKXFbUU?=
 =?us-ascii?Q?u1gDHfvW63MBW9/blJcadBNSz9pxdUSYCvd2Wzuhjsqr8XkoWPilfjGhWzmw?=
 =?us-ascii?Q?oA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bee1fca9-6431-4eac-4258-08dc43229382
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 05:58:16.3949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MpBDIHZzHYz/YL/EMS7+51HHzmNmBcP+d62NdAlSMxkoJSI+SohesZpMHbjDX8RAdOdsoW0ms/O1es6tgyerVloiGKqbdvQKkqmumA2VRhI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4839
X-OriginatorOrg: intel.com

Ben Cheatham wrote:
> Move CXL protocol error types from einj.c (now einj-core.c) to einj-cxl.c.
> einj-cxl.c implements the necessary handling for CXL protocol error
> injection and exposes an API for the CXL core to use said functionality,
> while also allowing the EINJ module to be built without CXL support.
> Because CXL error types targeting CXL 1.0/1.1 ports require special
> handling, only allow them to be injected through the new cxl debugfs
> interface (next commit) and return an error when attempting to inject
> through the legacy interface.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> ---
>  MAINTAINERS                               |   1 +
>  drivers/acpi/apei/Kconfig                 |  12 +++
>  drivers/acpi/apei/Makefile                |   2 +
>  drivers/acpi/apei/apei-internal.h         |  18 ++++
>  drivers/acpi/apei/{einj.c => einj-core.c} |  77 ++++++++++----
>  drivers/acpi/apei/einj-cxl.c              | 116 ++++++++++++++++++++++
>  include/linux/einj-cxl.h                  |  44 ++++++++
>  7 files changed, 252 insertions(+), 18 deletions(-)
>  rename drivers/acpi/apei/{einj.c => einj-core.c} (93%)
>  create mode 100644 drivers/acpi/apei/einj-cxl.c
>  create mode 100644 include/linux/einj-cxl.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2ecaaec6a6bf..90cf8403dd17 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5289,6 +5289,7 @@ M:	Dan Williams <dan.j.williams@intel.com>
>  L:	linux-cxl@vger.kernel.org
>  S:	Maintained
>  F:	drivers/cxl/
> +F:	include/linux/cxl-einj.h
>  F:	include/linux/cxl-event.h
>  F:	include/uapi/linux/cxl_mem.h
>  F:	tools/testing/cxl/
> diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
> index 6b18f8bc7be3..f01afa2805be 100644
> --- a/drivers/acpi/apei/Kconfig
> +++ b/drivers/acpi/apei/Kconfig
> @@ -60,6 +60,18 @@ config ACPI_APEI_EINJ
>  	  mainly used for debugging and testing the other parts of
>  	  APEI and some other RAS features.
>  
> +config ACPI_APEI_EINJ_CXL
> +	bool "CXL Error INJection Support"
> +	default ACPI_APEI_EINJ
> +	depends on ACPI_APEI_EINJ && CXL_BUS <= ACPI_APEI_EINJ
> +	help
> +	  Support for CXL protocol Error INJection through debugfs/cxl.
> +	  Availability and which errors are supported is dependent on
> +	  the host platform. Look to ACPI v6.5 section 18.6.4 and kernel
> +	  EINJ documentation for more information.
> +
> +	  If unsure say 'n'
> +
>  config ACPI_APEI_ERST_DEBUG
>  	tristate "APEI Error Record Serialization Table (ERST) Debug Support"
>  	depends on ACPI_APEI
> diff --git a/drivers/acpi/apei/Makefile b/drivers/acpi/apei/Makefile
> index 4dfac2128737..2c474e6477e1 100644
> --- a/drivers/acpi/apei/Makefile
> +++ b/drivers/acpi/apei/Makefile
> @@ -2,6 +2,8 @@
>  obj-$(CONFIG_ACPI_APEI)		+= apei.o
>  obj-$(CONFIG_ACPI_APEI_GHES)	+= ghes.o
>  obj-$(CONFIG_ACPI_APEI_EINJ)	+= einj.o
> +einj-y				:= einj-core.o
> +einj-$(CONFIG_ACPI_APEI_EINJ_CXL) += einj-cxl.o
>  obj-$(CONFIG_ACPI_APEI_ERST_DEBUG) += erst-dbg.o
>  
>  apei-y := apei-base.o hest.o erst.o bert.o
> diff --git a/drivers/acpi/apei/apei-internal.h b/drivers/acpi/apei/apei-internal.h
> index 67c2c3b959e1..cd2766c69d78 100644
> --- a/drivers/acpi/apei/apei-internal.h
> +++ b/drivers/acpi/apei/apei-internal.h
> @@ -130,4 +130,22 @@ static inline u32 cper_estatus_len(struct acpi_hest_generic_status *estatus)
>  }
>  
>  int apei_osc_setup(void);
> +
> +int einj_get_available_error_type(u32 *type);
> +int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
> +		      u64 param4);
> +int einj_cxl_rch_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
> +			      u64 param3, u64 param4);
> +bool einj_is_cxl_error_type(u64 type);
> +int einj_validate_error_type(u64 type);
> +
> +#ifndef ACPI_EINJ_CXL_CACHE_CORRECTABLE
> +#define ACPI_EINJ_CXL_CACHE_CORRECTABLE     BIT(12)
> +#define ACPI_EINJ_CXL_CACHE_UNCORRECTABLE   BIT(13)
> +#define ACPI_EINJ_CXL_CACHE_FATAL           BIT(14)
> +#define ACPI_EINJ_CXL_MEM_CORRECTABLE       BIT(15)
> +#define ACPI_EINJ_CXL_MEM_UNCORRECTABLE     BIT(16)
> +#define ACPI_EINJ_CXL_MEM_FATAL             BIT(17)
> +#endif
> +
>  #endif
> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj-core.c
> similarity index 93%
> rename from drivers/acpi/apei/einj.c
> rename to drivers/acpi/apei/einj-core.c
> index 937c69844dac..9affbe807ded 100644
> --- a/drivers/acpi/apei/einj.c
> +++ b/drivers/acpi/apei/einj-core.c
[..]
> +	/*
> +	 * Injections targeting a CXL 1.0/1.1 port have to be injected
> +	 * via the einj_cxl_rch_error_inject() path as that does the proper
> +	 * validation of the given RCRB base (MMIO) address.
> +	 */
> +	if (einj_is_cxl_error_type(type) && (flags & SETWA_FLAGS_MEM)) {
> +		return -EINVAL;
> +	}

Checkpatch says:

WARNING: braces {} are not necessary for single statement blocks
#170: FILE: drivers/acpi/apei/einj-core.c:578:
+       if (einj_is_cxl_error_type(type) && (flags & SETWA_FLAGS_MEM)) {
+               return -EINVAL;
+       }


Fixed.

