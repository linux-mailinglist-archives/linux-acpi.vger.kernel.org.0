Return-Path: <linux-acpi+bounces-2955-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A098331DA
	for <lists+linux-acpi@lfdr.de>; Sat, 20 Jan 2024 01:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5A80284E9F
	for <lists+linux-acpi@lfdr.de>; Sat, 20 Jan 2024 00:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895F619E;
	Sat, 20 Jan 2024 00:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aGB1qben"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961A5ED2;
	Sat, 20 Jan 2024 00:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705710933; cv=fail; b=VHi0TJIgCeV0/K/NijY9gIsNPCMFISyho+TiZ5IbliuWvWvFneZ37Vh48Ko5t8MNgwlXGLbXyCNYUNxLPUJJF0lSkon5C8ibJurfgL20Zgq+uB7MO8ucgFlXWZSYMIbf7I4Kdl6JGhLdx1ryquvUaRsaYXfHIT//+G5CE4NIEi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705710933; c=relaxed/simple;
	bh=29FKWQ37MEzSOJQ+kYNPAJBjeeJ1a0D4/s/jbGZ3ryc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MbvXBgUM+DvnCs6rSML8IYGrKeq9A9dPDBSzFAryCuSTIhLgaJe+R8cQlgFQZWiLM4KSGLykAobzfE4/7l58jMhDHk2SlEFVn2RmySqjBg0LI3L0zBIqlLRyoIqzof/9Qi9cVymrWiGhixuNUy5aJBW4/FVuCg94nroRV3rz2K4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aGB1qben; arc=fail smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705710931; x=1737246931;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=29FKWQ37MEzSOJQ+kYNPAJBjeeJ1a0D4/s/jbGZ3ryc=;
  b=aGB1qbenRIvbSBbSMAADdjQuxKSC9N9sNQdIJq627s8PQO+nTJQixNOo
   TSB+SNj3NOTERIUDPyyxSOI7FvTMeWsE7kC58PrV+cI3zIh0sCtDHXy58
   ywlSV/NeBmk1jlYHTph1qBHPcsBtX9cXQLialKa1pTPWxe/55mKsouzMP
   gmJ9rwsSw3ZIApbSzL2JPzxmSROVh4mV1qzARRjF6NXGpzGUWUEdZD7fy
   6QP5y971MlpkdIxOTBD2ZQpcNbAKR6mkCFTQKUXAo+AftOIZA7mztctoT
   8r8kMW/zpK7coEoAK+wqLSOSp/4KelY+xFnPvRDrYyeoG7j6tddtfFNnW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="399761786"
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; 
   d="scan'208";a="399761786"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 16:35:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="734677110"
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; 
   d="scan'208";a="734677110"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Jan 2024 16:35:30 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Jan 2024 16:35:29 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 19 Jan 2024 16:35:29 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Jan 2024 16:35:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/q5VwE81CXCwcZfjWJGIfeAwfvXRkEciyS4GWnBzFttz2lbMgfPTHHjNO+SqirqVEkX4utgjjBesanugPTKAYtYrepwI5mIL9cy1yN2XXLutenZPN4cEjlIz2Sa6AE4LdGSX7x3US8drK6mYickpPo1yZetCkFab1hNs2j8ozExP3ftGR7/if6Li4AH01Z58l9zuwNL53JtnUPgcUwXLGf37LP8rBok3ibIkCd21m/ezO+0k1Cg2Uxb2+a6MnKw/iu9m8UPIHRXnC2gVI5VGXcn02nweAYd8Cx+ah1UshywrbsmXf90i0fV7+BTiF1eNKofDBf3nfyesv1GRQhfMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8Ui1l+BsyfhmJCCac6CsOpxHca01SC0cR6VdRlPXbc=;
 b=W/qdYSOY0hnvLWzbt3Aen961cDQvYzQN2KMhQmazjB4Ql4PgLlGxXoh2PUre0QC6z7SFNWmL1SlGXwjSgq04q8Qm6O294AL3juPybnIIPK/TbTz0TVOZmBx2XcKXQhaiTv8ajcc9QyyOQHsAvOWtc1gtlg+zA925/RnqL+/2NaKudWkfdbtqsiCKgueV9uFoqD1KPcUnnu5HBjXoLnx1DFo4RkYUiK5doHRybhsShI/qAc4VzkEq+JIjLf4dYOkgklKKCuUkuGsfFQddMDP1cSFh9HwihVRZPsMPfVgtisdZ9TctvXZoB1IFxU81YYk9RgRAHCke9JyIJHnAUT9Qug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7804.namprd11.prod.outlook.com (2603:10b6:8:f3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Sat, 20 Jan
 2024 00:35:27 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7202.026; Sat, 20 Jan 2024
 00:35:26 +0000
Date: Fri, 19 Jan 2024 16:35:23 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<jonathan.cameron@huawei.com>, <dave@stgolabs.net>, <brice.goglin@gmail.com>,
	<nifan.cxl@gmail.com>, <rafael@kernel.org>, <gregkh@linuxfoundation.org>
Subject: RE: [PATCH v4 05/11] cxl: Split out combine_coordinates() for common
 shared usage
Message-ID: <65ab154b256ca_37ad294cc@dwillia2-xfh.jf.intel.com.notmuch>
References: <170568485801.1008395.12244787918793980621.stgit@djiang5-mobl3>
 <170568501456.1008395.7903809557943927970.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <170568501456.1008395.7903809557943927970.stgit@djiang5-mobl3>
X-ClientProxiedBy: MW4PR04CA0335.namprd04.prod.outlook.com
 (2603:10b6:303:8a::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7804:EE_
X-MS-Office365-Filtering-Correlation-Id: da51076a-5667-4ba2-36ba-08dc194fb1ce
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2BHdsvgpVhaSzduPdfjhl4Hl4BGwM1WAJmqpGUt51GdUS7mG+5aHLYSas96z2kHjWuZrF/JgqzyLt7lvuneJHfDKgRpI6niCbdJrvS1sx4/NKG9z0VojNJFnxdPFYH44vz9+olYnj8LfM38U50dyYvAmFwyBHzzG0jk8Gp71l8uK4QJ7xdsn7LUk7pMv9LUafZNtOh+32QTJ90+uOXrWa4HV/T+7aODULFyppJkg+wT1MltH8ifzLQUSoZ1UB6zp/1hACMe8r1m6c4qaDm/vSISI21YGQjnDWtL/CmlnxUIRh8uhMkMck8a17r/DqzfK87xEMwe2wtjJXQ+bN1qWHte+PscxTSgOuhri013WrppKdi8Ix5KK/X2ASY6nW7uxtKPvMaDJmC2UXG/OgY0W5iZ4k8OC1MxF2WHfRMevvKNMm23nRI92g0CvrdvTWwSWwUD5neV8GyUZa6zES47K+ZoKidIWOT8LaeHCktWbb45jdTYjmyFypeEVhN4Vy7R4k5fmccKe0PDwiv2XpIu/0tSezFutqFf9PpPTvWlBwClOHklgWAe8+JvnX5ZsJygV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(136003)(346002)(39860400002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(26005)(9686003)(6486002)(6506007)(6666004)(6512007)(83380400001)(5660300002)(2906002)(41300700001)(316002)(66476007)(478600001)(66946007)(66556008)(4326008)(8676002)(8936002)(38100700002)(86362001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jmxjp+g3y8bmRMmm1omDluvWTR9aiyd5cN8hNws2yTNlTSye/EJ6EESxjbZy?=
 =?us-ascii?Q?tPxa1WnEiXhw/0XfeVxxUW4xSuZS7XM/jF0066wZE9XPti/qBnUv+KlDyaLD?=
 =?us-ascii?Q?mothEWESC1uoMc9/2LevcBp41wqKfp/9tX2Ja6ZHlEG4joRB06+GSZDBty4D?=
 =?us-ascii?Q?3/363DT1qqMbc5s3U70wgjYpY/Y+KL9sToapW67oFcINehrvbOjDujUdkr5u?=
 =?us-ascii?Q?nFu9d7poAcWWYe5RwjZrdMZQ+CdlOcpAOjo98hIU+/eDFTRuH0rh3rybpcwG?=
 =?us-ascii?Q?KRa60NtM48DCXI68O5GNIaxE190wlc6sLx73vMA/xYVNM5uPgS7KMl+x+NT3?=
 =?us-ascii?Q?mkTej/cU12nW9KTC7IHXm/y12ZOeYwexk9nRJrvS5/EBQUtDed1RISEwc2ps?=
 =?us-ascii?Q?KUHOdeAZIajYY0+gH+kwv5Szjgmw9bMepYnFeZ3er1evZmO/NDa5kzZOwaBi?=
 =?us-ascii?Q?hLGcNhlgCY6HlWK18LhmN/sP2wyiTlmT6gAhEBwcROpWmpEEtgp3yNaja9cN?=
 =?us-ascii?Q?G8cWcs/HogxxkSFlUm74X0XkdUaGgMzwbQ0g6WCcZ868LZ0Kt0m0vsGcWUwy?=
 =?us-ascii?Q?HdvWzcJM8mqT3KnISo6ioGyB+GfJdwibLAbOt++0J8NDm+QM0tnNjj7jMjd4?=
 =?us-ascii?Q?HLCdNOT04JshFn+ns+As6rtP+pSdl7z9LK4GXI8z67K2k+KDAR3gY6wWXx6S?=
 =?us-ascii?Q?xqCQsUnVC6yrJhOPxx4lMUUr8lKcpT3mdWroF7R4C8v71TwauhYeTII2eHuA?=
 =?us-ascii?Q?5D4TrJusU7tUFskdKEbAdcw9P1nVnT4ZQet8t8CxjVDaZOpwF42q1fDcicVZ?=
 =?us-ascii?Q?MOncxAKSsOehRvL2QYk1IAG15IaPOy9Lomp7UVhbhOWUh8RiolxAmIkifIFQ?=
 =?us-ascii?Q?XFFDjL5PLdwHXtV7M2OAasJ1HBd1WeX2N67EtMzQNsYMxvSn8uAtULfkScrM?=
 =?us-ascii?Q?EByTKPpMfGyocTj4xMcjyoBQkd+0g1uyKd7e9uXByERDuDqHyiy7Xp+uHetb?=
 =?us-ascii?Q?ZG2gA8mXG3s6E1Sx+QR75S3iCx0NG1hyBVNqOwhfuuvPsVfxitTzp3pCWOEH?=
 =?us-ascii?Q?K4ATGjtZlrZTdlbZHjDuRP0t2k3HcjB6bt/dDgbWAqv3hXh/CRbVQzRSe4kb?=
 =?us-ascii?Q?8//Ivzbtve+/k0MG8EuqFOXJNgSAHGZbt6d6flpXD2xNs61kBBchp/q8eAQi?=
 =?us-ascii?Q?iu5IkrkfxyyCFWL2laate42P7R3tl/IQtEhUjIOoErwCxgmdyO9VLWPq70dK?=
 =?us-ascii?Q?TH1PKt0g6KuEmwzFUc4x7sWLck6scFP/vSbhpIthCstxuE7ThjIhVGJYJyUx?=
 =?us-ascii?Q?gVb15FMTj/5DuDmkHs9ESKhdYVM06giqVCIWUrq/shvM5kzOCmcpelSGxeZK?=
 =?us-ascii?Q?d4E+UesDhjtTJp4T0pzl1K50XHXcBWM7wQmFjSXAGq15cnImcd1lmIgdI56R?=
 =?us-ascii?Q?NNMm6XIq26LdQIpijO+RrTpPUHwNQzKZr2Xs8+Y2h2YS/V0DhjfmtUPgaNCX?=
 =?us-ascii?Q?qdfah0IIMn8VYD+Cg/AUV3arWCLwXvr3bonaJwSrJW1VnDFwbCt6zHko1qyA?=
 =?us-ascii?Q?9+9/hruFqwiNmlcbRTkxVIzAtqqmYWku3L25JuG8o2RVCQCCuYTWOrs8h2HB?=
 =?us-ascii?Q?Mw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: da51076a-5667-4ba2-36ba-08dc194fb1ce
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2024 00:35:26.2938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TaTGmtxog8QR7dAA51yNHnkQ1px6w0JbwGdBpeyu1gCns6v11Obk/Wwv2qnRxGz+6rfUfk43cfNMTT8yOFS6JYu64TI/q/qZBNbTgJ/FwM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7804
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Refactor the common code of combining coordinates in order to reduce code.
> Create a new function cxl_cooordinates_combine() it combine two 'struct
> access_coordinate'.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/cdat.c |   32 +++++++++++++++++++++++---------
>  drivers/cxl/core/port.c |   18 ++----------------
>  drivers/cxl/cxl.h       |    4 ++++
>  3 files changed, 29 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index cd84d87f597a..4d542627d02d 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -183,15 +183,7 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
>  	xa_for_each(dsmas_xa, index, dent) {
>  		int qos_class;
>  
> -		dent->coord.read_latency = dent->coord.read_latency +
> -					   c.read_latency;
> -		dent->coord.write_latency = dent->coord.write_latency +
> -					    c.write_latency;
> -		dent->coord.read_bandwidth = min_t(int, c.read_bandwidth,
> -						   dent->coord.read_bandwidth);
> -		dent->coord.write_bandwidth = min_t(int, c.write_bandwidth,
> -						    dent->coord.write_bandwidth);
> -
> +		cxl_coordinates_combine(&dent->coord, &dent->coord, &c);
>  		dent->entries = 1;
>  		rc = cxl_root->ops->qos_class(root_port, &dent->coord, 1, &qos_class);
>  		if (rc != 1)
> @@ -514,4 +506,26 @@ void cxl_switch_parse_cdat(struct cxl_port *port)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_switch_parse_cdat, CXL);
>  
> +/**
> + * cxl_coordinates_combine - Combine the two input coordinates into the first
> + *
> + * @c1: first coordinate, to be written to
> + * @c2: second coordinate
> + */
> +void cxl_coordinates_combine(struct access_coordinate *out,
> +			     struct access_coordinate *c1,
> +			     struct access_coordinate *c2)
> +{
> +		if (c2->write_bandwidth)
> +			out->write_bandwidth = min(c1->write_bandwidth,
> +						   c2->write_bandwidth);
> +		out->write_latency = c1->write_latency + c2->write_latency;
> +
> +		if (c2->read_bandwidth)
> +			out->read_bandwidth = min(c1->read_bandwidth,
> +						  c2->read_bandwidth);
> +		out->read_latency = c1->read_latency + c2->read_latency;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_coordinates_combine, CXL);

There is no need for EXPORT_SYMBOL() when the definition and the only
caller exist within the same compilation unit, cxl_core.o.

However, given there is nothing "CXL" about this function it likely wants
to move out of cxl_core.o if another caller ever arrives.


