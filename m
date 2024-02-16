Return-Path: <linux-acpi+bounces-3572-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEFB857247
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Feb 2024 01:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E59D4286C74
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Feb 2024 00:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4367663D;
	Fri, 16 Feb 2024 00:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="II/d0amq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300EE7EF;
	Fri, 16 Feb 2024 00:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708042202; cv=fail; b=fzAlirVkTe9eC+AITQCWA17GiEfa2pHJixPYMvNcSXhkTmXaF4PDnMgc/84Q69B21ymSPMjqJgNgDfBFhn6CP8WXIcBrpQStwHBj0fUZv4fDx/MQ2z0MLTPxbwtc1OP9pLL44k13ABoRR0EWRK+urOYsofMkiUVYECPHAETwWk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708042202; c=relaxed/simple;
	bh=nCvFNkYAMMfcW2GF+1ToMt5k/R7uj5Lm1SoX65X9jqs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NWQC2V707VDHgbURSthodtPZNumudv6TSp1laJNKUmKamwkmbLnlBHxu9UOnkzuJh4/3+kNDdtJQAxiovMQ785i/TGdTeIw1gHcNCyvY7aAspC49gAR+f7hbELEzwL5lc6/Ikz1elQ0FjpA8+QCbu2Th0foMLcOKnJebH2fQZ28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=II/d0amq; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708042201; x=1739578201;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nCvFNkYAMMfcW2GF+1ToMt5k/R7uj5Lm1SoX65X9jqs=;
  b=II/d0amq8Mu3rF8ISWGSz/b4ywt8an/z5Aq1T6hEuGLo9YpSY7tPGrt+
   vXNXJLe4dTRpeQdJZ0npFykP9YwLlbmXjXw0s4d17CXY9ZtzFXdjYou9c
   y5F9ZBKRq/+6T3aoZdL0TK5rz6M8uiPxvS02QYpDWFmmq+mKV4rJ3xbBu
   8L2dxtLe+5SkFDYUL/u+HOZZ4/ZxaCzXARj7/FtYHyHGQj/B77X2agVqv
   hyTCrpkLY7RvGcV7rN+q/iDqcFlQtRkFrU8Jks5lknz2UfrkYbg10JB78
   aPV9nU4Bc4qT3Hvki55orjZWDPh8eV11aTxk/vfwgrN/nzsd3AadY3IZ+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="5974328"
X-IronPort-AV: E=Sophos;i="6.06,163,1705392000"; 
   d="scan'208";a="5974328"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 16:10:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,163,1705392000"; 
   d="scan'208";a="8306936"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Feb 2024 16:09:57 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 16:09:56 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 15 Feb 2024 16:09:56 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 15 Feb 2024 16:09:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESG3v9jKfvd3pZlkkzgzPhGorLLfw6yj06q8We4LssCOU2AFHuXhoIHY3OfXhBb6AqyELflhzIWUkIhnLp3mpYtnUtdaygFmmhTgauDkJk90EptB6SjQOCKQ4jRDnapmF8a03y9OSfxXlu4jZnOXo2d/rhbPTXDUrh1YMea4fy+5fWofNUGhI65D96AXJ55PR9bUhY4Lf1pqSH9hTQyNgTzt61ks7OZh2+cSd6E8pnRGwXn2Syx3uST+VzW6jwoweoPz6U36W2u592sEqfYV7lKSwMYvMbFM2jAWhC2JCMGHzGliGz+ZcCHt9IxTv5MgPe0NvkVFQV6/+9Gn3qc1ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=McLRFjU66KWFNMmNFsbRXymvJ0vAzs/SMpagr/1+w08=;
 b=a/CLVcpA0fwlaME3nVfhQx1eesgneppTlyeasPEX1OKCi2s0uzDqTTFpBpSPcFDaQVBuiZQ+ZIrixeNpf23qng9MtdnDAKT1RmXanGagwVZ/OT5+i1QuhRQmVstyFS1ApgjX3KP2W+iieARV4m7X8ukZ+ezl//q84BokzoABk8j5FjBXoRIjHIG5+OfdbjbjechV0YRbAYsVwEH03Vrm5eAvYGOHx2m8OM1skfl8wV/9Tse4sYXp8TK9bjIUX+BmbMc+6Zj9x6IvkqN53Nvjj4l+9cd1kme8AsrKjW3EzVcuvkbSqZIrBcagHWRSrVIU5G4aFWxvYaU5yblIU6qZMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB7326.namprd11.prod.outlook.com (2603:10b6:8:106::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.40; Fri, 16 Feb
 2024 00:09:47 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7270.036; Fri, 16 Feb 2024
 00:09:47 +0000
Date: Thu, 15 Feb 2024 16:09:45 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: "Luck, Tony" <tony.luck@intel.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>, Ben Cheatham <Benjamin.Cheatham@amd.com>
CC: "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
	"rafael@kernel.org" <rafael@kernel.org>, "james.morse@arm.com"
	<james.morse@arm.com>, "bp@alien8.de" <bp@alien8.de>, "dave@stogolabs.net"
	<dave@stogolabs.net>, "Jiang, Dave" <dave.jiang@intel.com>, "Schofield,
 Alison" <alison.schofield@intel.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v12 0/3] cxl, EINJ: Update EINJ for CXL error types
Message-ID: <65cea7c922f57_5c762946f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240214200709.777166-1-Benjamin.Cheatham@amd.com>
 <Zc1kwWupeN9WagFj@agluck-desk3>
 <65cd7cac71377_5c76294ad@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <SJ1PR11MB60832AFF7D2F9FBD2670CBBEFC4D2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB60832AFF7D2F9FBD2670CBBEFC4D2@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-ClientProxiedBy: MW4PR04CA0314.namprd04.prod.outlook.com
 (2603:10b6:303:82::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB7326:EE_
X-MS-Office365-Filtering-Correlation-Id: bcba6276-50c6-4e71-036f-08dc2e839617
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W3OqPX2yxoSBP0G8ZvVfRGamQmmRoJ0XpwEXHgs42KtgnDx5sFpiVI8t8buswj3eRCKw9Tn+yjCQod+kB7HpWMwc/gU4vokDPjpfLTIE4tN31oHgyIjFaU/DIK2PCLG84DNTqlck1mXfAkQfD6/hUXavipuZZhsVybfku5fs0nvHHgHxSHOsSTZJux0/0kr4FFhRH1JqDTeJwOhR0+RwacO7Jgjc56NvX3Z3eLcIgEaDTQ3KzS5vyskUxddBjfBnXbmUWIZ+CKKIQWE/REHXLjIZyItz3n1AFc/sPPr13eUeCGB5FlAnj9inXTY9qlBRyKuaugdYUQf9MW9E5AxztMMOD8oXYLOFMEoiwQRXsGbRljgx/y6T494Q9oAhEgE1DPjBakO07bcGaWjfElQkOZwtUyMIwXxULaIkRZ5tmeih96KD0izPswbfUucMavivtrX45wodrw3g9Y2eWag2hcgAhV5UN6T3E8xlhZzJye6N0tUs7NpEcQW3mnN5/cCg4KLd+i8JA3oj0WrzSodkssHVW4/ENAewgh8gW1degHUI8wC0HNzdRNfJz6LrwMW3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(366004)(396003)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(4326008)(8936002)(2906002)(5660300002)(8676002)(38100700002)(83380400001)(26005)(82960400001)(86362001)(6506007)(110136005)(316002)(66946007)(66476007)(54906003)(66556008)(9686003)(478600001)(6512007)(41300700001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z+BN06oSrtJcvFNK8XIHXM2v4eFqUyj+L9SaqxJs3TSt+OETd1I4SZVrsVix?=
 =?us-ascii?Q?wJFfBiPyU8lqwloQ6qfESMrouv587nl7oIt/pbnO+QwauZ6Qt6boC/ZnkYeo?=
 =?us-ascii?Q?C5XZj5vHNhfGBanWtOljX1rAa3ub3zfLBXTehJ5T4t84Tjm9v1/OaIva0gDK?=
 =?us-ascii?Q?B4FiRGPpoIBYtiTf7DEg5VBS3UyUbGobS8Jmn4XXA9iaHUdPrHT7KprpmA8C?=
 =?us-ascii?Q?dkJAUhxw4x9BXapTknvuaTSlOQiBMoWS08oT51v27RRm0GlsHs/Dr18L6ErI?=
 =?us-ascii?Q?7sLCneNvsUwhyf5JYuC0MckL7PxfFZVRLcVWaJj6aokpOAmvdUVkHQa2Df2N?=
 =?us-ascii?Q?qNHOY+WtEzRNQsOKdp2DxIEpSzKz9pUTnTM/WmRBu/eM34JjSpFO3wqQ/dp2?=
 =?us-ascii?Q?i/wQ74mdzEyP5Jffus0JjX09s6a7oJIq9LQGgfajaQD9+AudqJbV9w0NO2UL?=
 =?us-ascii?Q?6zqWiNs0Z2HyuEwgmfsyyZpFRYEEFWpQaK/YArpEUlNLIUqQc+8qdOb6zng6?=
 =?us-ascii?Q?+7uI+dBdRTjhz4B9IeYQcE9f8dltuSlXVt9bhPr/3C6yHUG9G0fhf90ZFh/y?=
 =?us-ascii?Q?yWqiBQ9mguXy41G2WLvMS20LwV6L+se7NLkmds+TBpFU4jkUHN2dDxvVyZ+1?=
 =?us-ascii?Q?eDeH3ua3nGYORfD4HYEmh+G2VFEerWaa35q+zuTHvPQh1+SyNo+4OKQFVl38?=
 =?us-ascii?Q?HmWNq+rzHOk6e8NIYzsnATjxmJhg/yhJ3F2q7k47oi4Q0FkEyjNg6ZUL5Y/c?=
 =?us-ascii?Q?9qwHju/5vM4clGucZOLhvJ+zwo3HafKPFO3DoSd/lSUz0m+8PeVCwqgImIeo?=
 =?us-ascii?Q?Z8oJfU5HPaEF1mdL6rvI7YBrn0yNE2xWjLkrDKeuIs7371hAVjzx1ulVcam7?=
 =?us-ascii?Q?4q87V8xzt4k7DvOXezIL3uVRUPglPCamGZmSIILKLjVcmeSv6wzK8qL+AT6R?=
 =?us-ascii?Q?lhNRwz+Xu3sxzkQHLjwO44rIqK/zy/4zP80aQcWj68d3n3zpJedRgXrll/CS?=
 =?us-ascii?Q?D2pqfers8wbvVYX9bmBdSRB4+09CYXTyGZUbot2OO/d+FVTcC9Nphtvu4GjB?=
 =?us-ascii?Q?Ari6I9YoIA0/dyHX+x2PAj+87P5+2JaK9ZH47pN09dBjCNHEmnJ55paFEzpX?=
 =?us-ascii?Q?YBDHNJNcLlSeB90ShNxpT+cj3Q/MaDf28cHjRRrF19HVMHsCMr/lFUSEFYdt?=
 =?us-ascii?Q?fEG/fsET2iGp4tPiIYMaUYQ/I6KyGVt3tk0H65wB+L0mnjiNW5YUjIejlwnX?=
 =?us-ascii?Q?zacQnUD3jWheoFA0lw2U6Bm+MXvogiR3Eau9z0ujqt2tuLrEGqs6EgiXA+cb?=
 =?us-ascii?Q?AMn4Sdnt+V/ChRSRZ+qV5y7X0fcd83Tsc0cp0GWXubwPwmaBsXP2Rrwbjsjv?=
 =?us-ascii?Q?AI43JuBTYywWYcTUjd044PUHOlqBn2YkwF8MB/RNrfpbrCa+vBx6WIM9CI2C?=
 =?us-ascii?Q?xJhPSp5K0L5q7GyX80Sc3QEmMV24vQNSo685aBTY+47ahowcp+kIysSVOIyV?=
 =?us-ascii?Q?eHzqDCn7fPglQ70qqhE5b25kQuIaC60ifigyhDJWkiBh98/MNjHVV+erB3Nj?=
 =?us-ascii?Q?86uT97++H4gjF+1oSAR7IkWULkgP6wJ2iamrNideqClVLdMRaV53HNkRNZPI?=
 =?us-ascii?Q?0A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bcba6276-50c6-4e71-036f-08dc2e839617
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 00:09:47.5545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Guc/mg5S0QRB4qqqr73OsbjsbVeQs+zrC0yW1VWF3hv9mBH9GCQD09F8dJCZAXgp9ZxQ1kBZc6CD0kv1c2ZZYACjkLc4bCjT0nGiKXHQRzw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7326
X-OriginatorOrg: intel.com

Luck, Tony wrote:
> > I would save that work for a clear description of why einj.ko should not
> > be resident.
> 
> Personally, it would save me having to type "modprobe einj" to run tests (and
> answer e-mails from validation folks telling they missed this step).

It would only autoload with cxl_core.ko though.

> 
> But others might feels this is unwanted. It looks like some distros build kernels
> with CONFIG_ACPI_APEI_EINJ=m.
> 
> On the other hand, EINJ should be under control of a BIOS option that
> defaults to "off". So production systems won't enable it.
> 
> But perhaps there will be a pr_warn() or pr_err() during boot. One of these will likely trip:
> 
> 	pr_warn("EINJ table not found.\n");
> 	pr_err("Failed to get EINJ table: %s\n", acpi_format_exception(status));
> 	pr_warn(FW_BUG "Invalid EINJ table.\n");
> 	pr_err("Error collecting EINJ resources.\n");

Oh, good point. However, should a debug module really be throwing
pr_err() or pr_warn()? I.e. should those all move to pr_info() or
pr_debug() since the error case is detected by the lack of debugfs files
being published.

At least that would be my preference over creating cxl_einj.ko.

