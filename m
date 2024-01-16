Return-Path: <linux-acpi+bounces-2905-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FD882FDD3
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Jan 2024 00:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E53F7B232A4
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Jan 2024 23:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A8367C64;
	Tue, 16 Jan 2024 23:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GZsTCj8/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D9767C5E;
	Tue, 16 Jan 2024 23:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705448871; cv=fail; b=IT9JtbcyMs47LoblRUZ+aVBraPXfAftl2DVNi50HcLXaiIOH+FXE2Z7tDqD/ajA5g1szRpNHyOFVJL0wp85gjMsd61+sGx8ztAun5EAOvJKKysdJ9JrYmu91weQ5pNT1A/7Zf+jSovx7Y6s4E/VZpxvr8IQ/KYXp26xutHSEdgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705448871; c=relaxed/simple;
	bh=aNgQpT2Uw2HwusbeBR3FCoJY3/PW9WUbkbrOWS9tb4w=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:
	 ARC-Message-Signature:ARC-Authentication-Results:Received:Received:
	 Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	b=Aiun+sjlzwik9QGlK6G5I8gOciLWXhlRcjCIqEuiXPhO1d5YdAejT6x2JaKLdxR+DM3Knzp5bToz4vxNUDmD5CmhgZnR1R6PnJ5h5Z6fnsOKxZhGYZ2lpf/9XgSOP/+mDRnx8rYehIdN0J4hSeOxH1tB57XXOZ3pc5XQqxdrMrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GZsTCj8/; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705448870; x=1736984870;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aNgQpT2Uw2HwusbeBR3FCoJY3/PW9WUbkbrOWS9tb4w=;
  b=GZsTCj8/tkH9BYqKB7MQkU664CT/eqEChSRKiw+uB2RDdJbQwrjO/mAc
   Hb0KPF1qqlnfP7D6phXWAubUrTVU1NnUCXSeLk3K55IN2MdIX2OHz4pck
   u0TQ5QpWrsN0t60BRwi4U7byJHSpmwjNt75qp8WYQEP/zDUrRW66FuZtO
   9fuAm/6dvwe6sTFG026iM020eQKIBhNB3A6MKx3cbQQCqSfibRKwAsleg
   gYf7fic4j82nEzWg7QubSyvGdgF27pVg8GxaiBHiLA/BKd14uHV5U89FA
   7dwZzlBcG33Izy/ybvqty/9m9p+662PurwUR3N/s4Xy89lbis2Uck9zsm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="21501145"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="21501145"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 15:47:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="907545185"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="907545185"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jan 2024 15:47:48 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Jan 2024 15:47:48 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Jan 2024 15:47:48 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Jan 2024 15:47:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OAc6u+eV81kL2fgxhsalNKDlnYSp0kmvCsXjbl8ZLkID9GkWcJuwa0tnyKv/lxZOFivOs8TSnzXrIJuOZEh7KM0ZFptvuFfycOYKogEzwb4mKb02J+l1OBcYNSj/np3lWH7+IqHIT1qYpWC5n3i3mgRlnK8dDygtF8NeyadGEZuPy5GtqoG0frWRbBCdI4UYpfZBP62c/IW/zILAUsBXCR62X2tMuz+ppng2TqPwrL0lbz1hZTewzLGC/Wah6AvqFwMfsMeRQwEiVark4vInxlgRWvfH3lMQAtzEPFhQQ9mmNG/XhZE0cvXFhGGtKnAEZ6VBQPiBDtz9UtHheiQGKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43kp4n9Yvm2hEY9AV4cCjw+mcSK+u6U66fVln3eX8/E=;
 b=mi9cIdNMyX1Q/5sXj3IC3iyKwP0MlinKg13IMXKF0twMOrT0I6c3fTrQJEBVrom+HvIP4NAibMu9/KB4vSvEciBjWqfjHtxMkkzdDdO42H12rBSkSrbiGQKhsUc5xkMBmggTl/Pukge/9krhDaWESpQS9+zaby9B4mVFBXAvz07sQ9m/Xz3LQtnvqdzFfAmHFEATnn4UOMIeqD4yMtB1eUQTWRl8gL1JexhwgjVdzjNIQzDZy2LxZuJ5RN/uhVLhiVSIDo05B2z9LTjiS0sgd6dQOeL0CH0HS6IyqmcWtT9wkGaXrVzO5tICys9AuFLlhLP1BH2mrz1207C56SAFFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB6823.namprd11.prod.outlook.com (2603:10b6:806:2b0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 16 Jan
 2024 23:47:42 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7181.015; Tue, 16 Jan 2024
 23:47:42 +0000
Date: Tue, 16 Jan 2024 15:47:39 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>, <dan.j.williams@intel.com>,
	<dave@stogolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <rafael@kernel.org>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<benjamin.cheatham@amd.com>
Subject: RE: [PATCH v9 3/5] EINJ: Migrate to a platform driver
Message-ID: <65a7159bbad4d_3b8e294f5@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240115172007.309547-1-Benjamin.Cheatham@amd.com>
 <20240115172007.309547-4-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240115172007.309547-4-Benjamin.Cheatham@amd.com>
X-ClientProxiedBy: MW4PR02CA0010.namprd02.prod.outlook.com
 (2603:10b6:303:16d::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB6823:EE_
X-MS-Office365-Filtering-Correlation-Id: 504afeea-cb17-45b4-98eb-08dc16ed87e1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SeERvUJiHkt/mSQ7t5FYjsP3mlnvF2HgiSY9sO+Oqws88N4dtRGdUaIHdI9tqXGkgSvzqOYaDlYrvkZscZ6OvTrlbDoRLP+V3HunZoUEw0I8tA8i+fiXoB+QUl6i9ituSMyRs1BtXsBEYkI5Uza7vS31B3QxEOuE3yiWga3Rj2mNMibo1XPrUnIyxfXIRU1F2PqKfvA7z7TUMwwXoa8ksmrjOMkoEL+cLsGoU/qoKhExra3KegukwYbQpPBYj7AF6XJncYbQh/XdsDpQeb9leXTDliC19UYEb1X7VR1HXhPxIJrQ/2MnxMsgkmdLJAMJRpYsFtzSgoJ53HlZghFobwzwaX0yZcUHfX2LJs66Uz/J/ACi3LFo062X+ADkI/Jyw+ZiLLlLAK9pUDk9nsLmJ6dzfBoeIuPprK4zAcEcosyunL5gi9++vyj9xb/237inofTdIAAj8cXE4yL1rAuyxNHXE3aC6Zrg+B0LWRk9pXYcR1Fxu5cpSpw1ByrZuRw1quj/BkMRTBdJDI/etauFg3x2Q1u5pDyzOxu10mK/SvyBAz7w3aywRwrktEE7W82V49K/hWiPmlIhh1K6YQ5IaQXhVhAZdd3QXNvV8ltFrFznawdWD+e1hw+pX+OiyKGE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(366004)(376002)(346002)(230273577357003)(230173577357003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(9686003)(5660300002)(8936002)(86362001)(478600001)(26005)(82960400001)(6486002)(6666004)(83380400001)(6506007)(41300700001)(316002)(4326008)(8676002)(6512007)(38100700002)(66946007)(66556008)(2906002)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I0mcbM/KgXnIjT185eVeOBbB/gsmJQAfnbEtvT4jA6ZzX34CE3iKsAK4elRF?=
 =?us-ascii?Q?fuq66bYxgi42AZXt9xo6iEEcU9/FgnZPWGpv680879d51XF9ELXC4mJv4v9s?=
 =?us-ascii?Q?7W5kg+fxiDb0ZuHa/PwZ6Ox23EdNmQqksW3nN8eSDC/E+NAHRsBTaIMXfzL8?=
 =?us-ascii?Q?buv+FSxcSfCcROWRKEQjdhyZf9GElGZ4u+uTEcQUAYid8pbMA+Z3JnyVt7gW?=
 =?us-ascii?Q?LmwQDiMmmMA6ZXC+K5ZpPyXtHjZur4zAzlUQjZ+m8kL7ZLTdZSVdVu/EZsCg?=
 =?us-ascii?Q?m3OovLXVwVgAPOynUWC89jd3PVBpW90B7f+zmZ1MWYT+RnpkXx/17CdhTGig?=
 =?us-ascii?Q?UH2dErCnXsGQHznzgzv3ThUuKPrLcB87DAUTjZaSojsELHhKy89zX31RnQQl?=
 =?us-ascii?Q?e4hc6y4EyKu3Gb9+k/U39vkmi6gBQ9klafc3i5QVr7HRo+aUSBPKej3PwKXA?=
 =?us-ascii?Q?aUKg8qMm6IKXdS2hVYVl5PZSVguWfKNBQGGHRViwX8AQrF53Ys9C9+PAR97a?=
 =?us-ascii?Q?fh2c19MTpaqBqHOz+Ils1M0oSXSdPpjqmXT1u5Uotd8pon83ya1/orZOW4ir?=
 =?us-ascii?Q?BL853tc3csywEbwuwV3/tvF8GvJ9M+qQsZ1jgSbrlAsvnA610Ajb51jwo8lc?=
 =?us-ascii?Q?teiAAUf4GBD/FPEINn8SFOQ+mWozNNe5AbzbUIemqHRH+a5cEff8yI61t+Dr?=
 =?us-ascii?Q?hMThvjt56tgNAglMqg3Y31Xpnp1xPcDiFonilu+Pmigq51Je1j4UCSF9o6+U?=
 =?us-ascii?Q?T/CTOVrGEv3x6iQQVkotP3v/yy7c/GjRMFlYmCvtXRbM1cpG4E/4N6W/K3od?=
 =?us-ascii?Q?DBxTbrsswYmMQMTN8HFJ8JC86FZdjioRdGm4u/ysQ4AnB68TJ3CR1z+paWSq?=
 =?us-ascii?Q?1D5QR3OzKZISVfYe+C4TbkMMb50GfoRZikrHdNM362krMj7fP6UTEWXFYugV?=
 =?us-ascii?Q?RO68B6wSgLhnkuctTCCqlwXDxrO+YeFt6T4xErfXEdWWCkp4/4xNOZLIGkLm?=
 =?us-ascii?Q?+h++3IgS1gT7/iEldVJHwUtbVe83gQZ34Y5vkkMnP1c0HWVdO3m+Lw5XRYI2?=
 =?us-ascii?Q?ijWcLfDZGMeMkvyIPO/khNNbemOj/5UCHwPMJdjGoWqeOSyjelx02kBFEMXS?=
 =?us-ascii?Q?y/A0vz34F6ZyJKrOSC5ZaZ7DlxniMi3p8/VydfiOlD8LpndoQlOSNG42i7u5?=
 =?us-ascii?Q?MjQvrqYvY2+np560dlRKrIpKwDPpT9Mhnw59FYAu5nIcUWCbBuuXK21pNlQS?=
 =?us-ascii?Q?LxXsteBYQA1bBpllYaDqb8vubqzfRtfTmpmKdn8cMPB/SG01v+dCpSzzgg2P?=
 =?us-ascii?Q?8Zln5h+ZmNneL4zE6c4ZX6OQfKpYTOlinD0Fkkl+3FftbckMExsiSGLzGNFg?=
 =?us-ascii?Q?02NMLfyd81+YKKj0/VCFdfV81lGK6G29E8hVzCNkp66FirB26VHVC5rfPP0C?=
 =?us-ascii?Q?We4y06YGse+M4Wl4qya8JA8AgDmY8sG14ToyQ5Q+cdI5XVVS1F1y4/pyiK6P?=
 =?us-ascii?Q?6aXW0I9L/HMZUJMyiGRE8e57gvKDTu7oYefGgIBt8oAQKjRLwJ8+put7N8ed?=
 =?us-ascii?Q?hU2qtEdQyriTBlFQTRdL2VCMq19CmNhV4vtUIMqXu258SBm3iYCgSU9Gdz6G?=
 =?us-ascii?Q?zw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 504afeea-cb17-45b4-98eb-08dc16ed87e1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 23:47:42.3940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yNC0A4G+Jm1VpEoziGUaSw1lNqroJVMrRC0MDhynBUgmJw9nEWlhk0dWNXrI+FdiuH1n9yCMoHaVBE37ibhvFeMPoQAwSJgikPB3qUhxlhA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6823
X-OriginatorOrg: intel.com

Ben Cheatham wrote:
> Change the EINJ module to install a platform device/driver on module
> init and move the module init() and exit() functions to driver probe and
> remove. This change allows the EINJ module to load regardless of whether
> setting up EINJ succeeds, which allows dependent modules to still load
> (i.e. the CXL core).
> 
> Since EINJ may no longer be initialized when the module loads, any
> functions that are called from dependent/external modules should check
> the einj_initialized variable before calling any EINJ functions.
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> ---
>  drivers/acpi/apei/einj.c | 43 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 41 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
> index 013eb621dc92..10d51cd73fa4 100644
> --- a/drivers/acpi/apei/einj.c
> +++ b/drivers/acpi/apei/einj.c
> @@ -21,6 +21,7 @@
>  #include <linux/nmi.h>
>  #include <linux/delay.h>
>  #include <linux/mm.h>
> +#include <linux/platform_device.h>
>  #include <asm/unaligned.h>
>  
>  #include "apei-internal.h"
> @@ -136,6 +137,12 @@ static struct apei_exec_ins_type einj_ins_type[] = {
>   */
>  static DEFINE_MUTEX(einj_mutex);
>  
> +/*
> + * Functions called from dependent modules should check this variable
> + * before using any EINJ functionality.
> + */

This reads slightly odd to me, is this clearer?

"Exported APIs use this flag to exit early if einj_probe() failed."

> +static bool einj_initialized;

This can be marked __ro_after_init to make it clear that it is static
for the lifetime of the module.

> +
>  static void *einj_param;
>  
>  static void einj_exec_ctx_init(struct apei_exec_context *ctx)
> @@ -684,7 +691,7 @@ static int einj_check_table(struct acpi_table_einj *einj_tab)
>  	return 0;
>  }
>  
> -static int __init einj_init(void)
> +static int einj_probe(struct platform_device *pdev)

This can remain __init since nothing will call this function port
init().

>  {
>  	int rc;
>  	acpi_status status;
> @@ -782,7 +789,7 @@ static int __init einj_init(void)
>  	return rc;
>  }
>  
> -static void __exit einj_exit(void)
> +static void einj_remove(struct platform_device *pdev)

Similarly this can remain __exit.
 
>  {
>  	struct apei_exec_context ctx;
>  
> @@ -801,6 +808,38 @@ static void __exit einj_exit(void)
>  	acpi_put_table((struct acpi_table_header *)einj_tab);
>  }
>  
> +static struct platform_device *einj_dev;
> +struct platform_driver einj_driver = {
> +	.remove_new = einj_remove,
> +	.driver = {
> +		.name = "einj",

Perhaps call this acpi-einj just to preserve the namespace in case a
cross-platform generic "einj" comes along.

> +	},
> +};
> +
> +static int __init einj_init(void)
> +{
> +	struct platform_device_info einj_dev_info = {
> +		.name = "einj",

Ditt "acpi-einj"

> +		.id = -1,
> +	};
> +
> +	einj_dev = platform_device_register_full(&einj_dev_info);

Just return early here if this failed.

> +	einj_initialized = !platform_driver_probe(&einj_driver, einj_probe);

Nit, but since platform_driver_probe() does not return bool, I would
prefer this to be more explicit:

	err = platform_driver_probe();
	einj_initialized = err == 0;

I think it is ok for the platform-device to stick around if einj_probe()
failures as userspace can see that the module is loaded but driver-init
failed.

Similarly it's probably also ok to fail the module load if
platform_device_register_full() fails since something deeper is wrong
with the system if it is starting to fail something so basic.

> +	if (!(einj_initialized || IS_ERR_OR_NULL(einj_dev)))
> +		platform_device_del(einj_dev);
> +
> +	return 0;
> +}
> +
> +static void __exit einj_exit(void)
> +{
> +	if (einj_initialized) {
> +		platform_driver_unregister(&einj_driver);
> +		platform_device_del(einj_dev);

Per above, this device_del can move outside the conditional.

