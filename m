Return-Path: <linux-acpi+bounces-2568-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A8681A2CD
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Dec 2023 16:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA3EA1F22A3D
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Dec 2023 15:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A974E3FE44;
	Wed, 20 Dec 2023 15:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W0Q6I5F9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C263FB04
	for <linux-acpi@vger.kernel.org>; Wed, 20 Dec 2023 15:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703086597; x=1734622597;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4SvSwnl3LiKf+c84akAX6gHynZOQ597q3uLR4LWHWls=;
  b=W0Q6I5F9Re4Nx6VH95K13AnuE9ssHcw1B0nzk2hTfWKUHWVvohhu055O
   V7DJwjPvlgt5OAB/2sCfOPZFHSXFXhlGbXz1hJji8KBDonSXFqYFaP6Rj
   tELQIL2YfeRiqvYhXhf++zb67dTBxTI/Vq3/+zjn8r2Kx54QWWinVH/jM
   zXk9tV+7vVTZPSeDwZr6fXPmcrw7DqV9qc8jVzUZy9UfIhvU60sRDItSc
   D6NyR78A1sm9IHqZIqUf2UnlB/OeeWR40u2/L4llp3vLiMhSwFXoV+Hvn
   3YhnnJkDSl5qhCMzMOqu1axoVm6oHSevrRieMOzydy/nNbXR+4yfmNzLD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="386248628"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="386248628"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 07:36:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="17988810"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Dec 2023 07:36:18 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 07:36:17 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 07:36:17 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Dec 2023 07:36:17 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Dec 2023 07:36:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WVqTGVeAo9nB8Ft6CQM273RGJ9ObAG6Pqbb0LftcfMNOoLNJPd8kAlir4GTXVPnDE36W8SV3m9hzMk+mqBwoRIih8wlfMV0vajcyvzJw67c/xz9ZYASQWSu6nTA/8tvKePNFHV3uuNZkXnykBGVfg/vI+tGIgZYBGbCLgKlxQ9cHnAh0IB8vijeKi+ssHUhA3PaoN4vl93afa3vttqRp5zmGjgq/57RLWCqUKV8watBndks7HSTPbddkUVrf4aH+8oCV5NAONpL2m7LSen6P+oz+KihGrpUpDDj67LbuC5J1EMkwQJP9asduR8j71cPXges6BYsoQHuc+M1dN5Hu0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QaqUGOyBiJ/FWdndki3qhyuJYuTyZ2EmMC40B+4q00M=;
 b=a9aqKLNk6MNqCnCnjfDszNONoFKl8m/SUmY4JWk/aZPE6vVMYwv7X/3AQAi9Hy4TpZAOUg7tfOUpTdTfTp1oAr8nW4Rau7kJ0eSB67du7Vp6BJHOzrt6ELBjtbrdNTp4xOIUZfmWjOBwUO8gFpH6XfOyizIKDCgZL8E1ndqFQD5yhPSNACnyZDR2YOYEWjW5CPfayif73mdJ+52Z4GDEmLj2RgGn0tm6pqGEJU32yYpPYwhXbomXPbqmb8xON9esRIWJSOxKekJj15aB4MLKNjjbWkGhDBLpXwxuAXs5NcpMBHpgiMlUxkx/QoejY4X+z/hwBWGUWhi1qmvA/oStnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SJ0PR11MB8294.namprd11.prod.outlook.com (2603:10b6:a03:478::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 15:36:14 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7091.034; Wed, 20 Dec 2023
 15:36:14 +0000
Message-ID: <c74e3611-ac18-4e53-b03d-38f32aaf890a@intel.com>
Date: Wed, 20 Dec 2023 08:36:11 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] acpi/nfit: Use sysfs_emit() for all attributes
To: Dan Williams <dan.j.williams@intel.com>, <nvdimm@lists.linux.dev>
CC: Ben Dooks <ben.dooks@codethink.co.uk>, Alison Schofield
	<alison.schofield@intel.com>, <linux-acpi@vger.kernel.org>
References: <170303851337.2238503.5103082574938957743.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <170303851337.2238503.5103082574938957743.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0385.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::30) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SJ0PR11MB8294:EE_
X-MS-Office365-Filtering-Correlation-Id: 11e03ba3-34bd-4557-40c7-08dc01716669
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HVPDvAlmNEIztcVBIBv5W4eKAC6FCjEQutQtmx376RDl0Leh8KNxs0qk6VetpCMHwOxIoK+EokXS4toIDj7+wSYvhfAEpHl9Sb3cWJxvvmWDKXH2LZVYBwJZJgyrysJliZEI04tFRvgYYQe703uM/LQwblX8BRjF0IPaMxgtwDZ2J/wPEe3ApJjYEjiXVKSCvjdxfC4kOOuU++5K0/h2FzSK0qNsqCTme6kzYXlDoyGZGS1CubsGaKaV8Ft4J5VCHlk31IqdLXOQJuwQQoHVts82rQ3BrHGCctB2mleXMx+zXE1Qsu9qmLYKANPV30dAnPioj2y6MalC35AFwMU6S0ovixGjM5xT3IanMMRMCbtwHbK1VW6St6fj3hPT7jTYyHuTS1y0jQ5O4LibnhgDiGB/Y+2OlzhriF4Vx4PumpZZeHT7Hz5WyuU/g5wCt/B8AdztpLo55fiB6ZA7SiNSOyMQVX8d0FB8CCXQ1WYwvhs+T1GcC1zdZIOwXEtIO5mirgAjUfKFeKOqeETlEJ2wUBEnx37qEIoF2NzdYHM85hU11tqbmbdUj3hCjnKo+CV7Jyv+nVe21B7b1W951Mgo7ueXjBRcL5i0WbwY30Bojpc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(396003)(366004)(376002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(6506007)(26005)(6666004)(2616005)(53546011)(6512007)(83380400001)(5660300002)(2906002)(478600001)(4326008)(8676002)(8936002)(41300700001)(44832011)(66476007)(6486002)(966005)(54906003)(66946007)(316002)(66556008)(82960400001)(38100700002)(86362001)(31696002)(36756003)(31686004)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUEvS3FSeEs1TDI0aUJINURkZHlpeEpRZmkwWmgxN1dSNTh5UlkxZDBQRXor?=
 =?utf-8?B?TDJnR2Y2OVBWdVgwaDAxKzVCTDh3SWtXdlNOTFh2MFhqZGJmd0I3bjdOc0dT?=
 =?utf-8?B?NlFBdFc1MUhpMUpabTVQWTZvdUtOMDkxWTVaUGkvSG9YNHU0V2gxVzROaXFZ?=
 =?utf-8?B?alRTdmgrdjhPUDN5QjNET1RHY29TSGcwQ2czVjN3dVRZYlJJNHdPWWJCTThh?=
 =?utf-8?B?dU9xdDM1U09DN0h2MmdpVzNDYVRFK1VtWGV0YVcyTFZTbmZSQ085NkJVdDI5?=
 =?utf-8?B?cHpObDV2dWRtN3pidlJ0d1JjSWdBK1dkYWNLNzZmLzh0dE1RdHh3Z3N2Mmkx?=
 =?utf-8?B?QXFPTkdkYXVWM0ZUWStnbmIyeUNITTF6UXJadVNaaW05VzBMamRoQ3dSMUlL?=
 =?utf-8?B?SzNmRmtoaDNuZnFqT1pHWit5bXAycmMyWmkxM1VHenQrM1lqSkt3V3p2QU10?=
 =?utf-8?B?bU1Dc0RZNlV6V29zL1hncDhyVWNzb0pJUm13d0Z5QXBNYXNXb1VkK055Y1dx?=
 =?utf-8?B?M01YU2VnbFBMd1Rac0dwWlBYZnVBTlNUK2l6SmVyKzZITi9adnlhSmNta3VR?=
 =?utf-8?B?emlGb1daaE84MTJDTUFKeFI3TVJIWHFxQkVMQmxxaktNdGlObTZ2NzRyWHVp?=
 =?utf-8?B?R2Z1cUlWV2VOYmV6RlRIZVBocnp6TlhjZ0g0QkJoaDJ6dWZ2SGpGSzlHMTAy?=
 =?utf-8?B?bXgram42cThqeUVoT1hidEFnMFpzYUVxOXIyTU5HMW5HOStpdkFOayt3eWlv?=
 =?utf-8?B?ajRHTW0yUndOTS9yT0c2eGkvZ0pUS0VTbDJiUkdpaXBCZEdvYnFiUDIzYUcw?=
 =?utf-8?B?WFlxZmpLeEt0SkJyUk4xUnJqeHFGd2ZpSis0VXd1UnNBU1djVjFPYm11MUJ3?=
 =?utf-8?B?aStXT2RvNXNaSWFOQ2c2OVJocHR3N3UzRFd3RmxlL3dITlQzeHlROVpWYmlP?=
 =?utf-8?B?bzFnbENvc0hNclpZeFhQYm5Vejl5RWRvQ2diOWlqbkMzOGtCdTBVdHFXcUNU?=
 =?utf-8?B?aXV0K3dUNGdCSlFLWGE0WnZ4NG13K3lBWEFGVDlGMlkvUTRHWUVmU3YxdXoy?=
 =?utf-8?B?cjlwUkQ0QWwzQmRpcEJxR0JPLysycEhXRlNsWTU1dE5wTnhnMWZpWXc3aXVS?=
 =?utf-8?B?ZjByZjZPUkx2ZTBQdFR5OG5iU0dyYllHSjFGQmRBcVlCUVRjM2dQeWNtVVBo?=
 =?utf-8?B?VVlNbVhTWFl1a2tWOUp5UlA3aWtkL3pUZWlXbllCSytScStKSTFybFBDS0oz?=
 =?utf-8?B?ZUJFM05qd3FDNmVqL0RzUzNGYzhFWUh4NzljNE56djIveWhLaXpHeVdXRGpo?=
 =?utf-8?B?V0w5aDVocVRMTjZsSlFvbzdqc1hKZkp3bnAwZ0w0VUs0Q2FKRy9udDZQRFhX?=
 =?utf-8?B?WFRDZEdXUCtMQXJuaUViWXY4N09DZzlpc21nODB3Rzl0YU9XZ2dZN2ZNYUh3?=
 =?utf-8?B?VjB4clVrN3ZqTk1PZHgydWlQNmFHVWcvdU1CTzlteTZaS25OUC9sOVBPY3dN?=
 =?utf-8?B?VjNPWERQMzdCTFZTWGNKcURKVmcySTByclhzNnJlbTdiVlV1Y1BsblBTbVQ3?=
 =?utf-8?B?cnRWcFFLa29aanp4ZDltcnJDd0FMVlVWV3JOWHpZeFdtd3ptZXZTOVVGWjNI?=
 =?utf-8?B?SFVQR0EvZXpYdEswVTNkSGE5WWZHNGFrbWdJZzRhUlRrWlBZNjNLMkJvVERk?=
 =?utf-8?B?SEd5OGZWYmlOdkEySXhvM0NhWFhEaG9XdUdZR1ZxemNuclVVWnk3K2wwTVAw?=
 =?utf-8?B?VUQyNDFRU1kxOVE0QWMzYkVZVXo2MW1QK0pvVUtLa0ZaTndXSDNucTlVWG9P?=
 =?utf-8?B?VWV3TGFFYTA0SSthTFZqK3pxRUlYWDMvdnBscVl3WnNjSVd3NlVWYWt2UHpt?=
 =?utf-8?B?Q2dDM2JjT2FGeThoQWYwS0g5UXR4cGtNbFM5cHdWUEtabUQ0U3B2Z0VhU1dv?=
 =?utf-8?B?YmZZM3E1dlNTczczYVoxNE5PQTUxaWNaQTcxWEV6MTQwTFRDamoveWs2L1lB?=
 =?utf-8?B?K1BQeWQzdC9HSDEyQ05JM0JxZWxsbmtCbU5VQ1AwS2JyZ05za0RuN2ZtRTZU?=
 =?utf-8?B?QTFLajUwNGljSWplSjRQTjJlcWRad3ZRUEpQeCt0NXpSWHBCVVV5SFZ2Mmxw?=
 =?utf-8?Q?tiy2/81a2ToDY2C8mSD2qU7EE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 11e03ba3-34bd-4557-40c7-08dc01716669
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 15:36:14.2101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BxI7ztm5pB11Hfz0NO/eeBv5vMS8+F3Hw0w7GHRUwVPQ9WRZ17a7xTjsLCjxyCq60s9uiZpzHTT7npS7x450Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8294
X-OriginatorOrg: intel.com



On 12/19/23 19:15, Dan Williams wrote:
> sysfs_emit() properly handles the PAGE_SIZE limitation of populating
> sysfs attribute buffers. Clean up the deprecated usage of sprintf() in
> all of nfit's sysfs show() handlers.
> 
> Reported-by: Ben Dooks <ben.dooks@codethink.co.uk>
> Closes: http://lore.kernel.org/0d1bf461-d9e8-88bc-b7e2-b03b56594213@codethink.co.uk
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/acpi/nfit/core.c |   44 ++++++++++++++++++++++----------------------
>  1 file changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 992385537757..9f44156c6181 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -1186,7 +1186,7 @@ static ssize_t bus_dsm_mask_show(struct device *dev,
>  	struct nvdimm_bus_descriptor *nd_desc = to_nd_desc(nvdimm_bus);
>  	struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
>  
> -	return sprintf(buf, "%#lx\n", acpi_desc->bus_dsm_mask);
> +	return sysfs_emit(buf, "%#lx\n", acpi_desc->bus_dsm_mask);
>  }
>  static struct device_attribute dev_attr_bus_dsm_mask =
>  		__ATTR(dsm_mask, 0444, bus_dsm_mask_show, NULL);
> @@ -1198,7 +1198,7 @@ static ssize_t revision_show(struct device *dev,
>  	struct nvdimm_bus_descriptor *nd_desc = to_nd_desc(nvdimm_bus);
>  	struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
>  
> -	return sprintf(buf, "%d\n", acpi_desc->acpi_header.revision);
> +	return sysfs_emit(buf, "%d\n", acpi_desc->acpi_header.revision);
>  }
>  static DEVICE_ATTR_RO(revision);
>  
> @@ -1209,7 +1209,7 @@ static ssize_t hw_error_scrub_show(struct device *dev,
>  	struct nvdimm_bus_descriptor *nd_desc = to_nd_desc(nvdimm_bus);
>  	struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
>  
> -	return sprintf(buf, "%d\n", acpi_desc->scrub_mode);
> +	return sysfs_emit(buf, "%d\n", acpi_desc->scrub_mode);
>  }
>  
>  /*
> @@ -1278,7 +1278,7 @@ static ssize_t scrub_show(struct device *dev,
>  	mutex_lock(&acpi_desc->init_mutex);
>  	busy = test_bit(ARS_BUSY, &acpi_desc->scrub_flags)
>  		&& !test_bit(ARS_CANCEL, &acpi_desc->scrub_flags);
> -	rc = sprintf(buf, "%d%s", acpi_desc->scrub_count, busy ? "+\n" : "\n");
> +	rc = sysfs_emit(buf, "%d%s", acpi_desc->scrub_count, busy ? "+\n" : "\n");
>  	/* Allow an admin to poll the busy state at a higher rate */
>  	if (busy && capable(CAP_SYS_RAWIO) && !test_and_set_bit(ARS_POLL,
>  				&acpi_desc->scrub_flags)) {
> @@ -1382,7 +1382,7 @@ static ssize_t handle_show(struct device *dev,
>  {
>  	struct acpi_nfit_memory_map *memdev = to_nfit_memdev(dev);
>  
> -	return sprintf(buf, "%#x\n", memdev->device_handle);
> +	return sysfs_emit(buf, "%#x\n", memdev->device_handle);
>  }
>  static DEVICE_ATTR_RO(handle);
>  
> @@ -1391,7 +1391,7 @@ static ssize_t phys_id_show(struct device *dev,
>  {
>  	struct acpi_nfit_memory_map *memdev = to_nfit_memdev(dev);
>  
> -	return sprintf(buf, "%#x\n", memdev->physical_id);
> +	return sysfs_emit(buf, "%#x\n", memdev->physical_id);
>  }
>  static DEVICE_ATTR_RO(phys_id);
>  
> @@ -1400,7 +1400,7 @@ static ssize_t vendor_show(struct device *dev,
>  {
>  	struct acpi_nfit_control_region *dcr = to_nfit_dcr(dev);
>  
> -	return sprintf(buf, "0x%04x\n", be16_to_cpu(dcr->vendor_id));
> +	return sysfs_emit(buf, "0x%04x\n", be16_to_cpu(dcr->vendor_id));
>  }
>  static DEVICE_ATTR_RO(vendor);
>  
> @@ -1409,7 +1409,7 @@ static ssize_t rev_id_show(struct device *dev,
>  {
>  	struct acpi_nfit_control_region *dcr = to_nfit_dcr(dev);
>  
> -	return sprintf(buf, "0x%04x\n", be16_to_cpu(dcr->revision_id));
> +	return sysfs_emit(buf, "0x%04x\n", be16_to_cpu(dcr->revision_id));
>  }
>  static DEVICE_ATTR_RO(rev_id);
>  
> @@ -1418,7 +1418,7 @@ static ssize_t device_show(struct device *dev,
>  {
>  	struct acpi_nfit_control_region *dcr = to_nfit_dcr(dev);
>  
> -	return sprintf(buf, "0x%04x\n", be16_to_cpu(dcr->device_id));
> +	return sysfs_emit(buf, "0x%04x\n", be16_to_cpu(dcr->device_id));
>  }
>  static DEVICE_ATTR_RO(device);
>  
> @@ -1427,7 +1427,7 @@ static ssize_t subsystem_vendor_show(struct device *dev,
>  {
>  	struct acpi_nfit_control_region *dcr = to_nfit_dcr(dev);
>  
> -	return sprintf(buf, "0x%04x\n", be16_to_cpu(dcr->subsystem_vendor_id));
> +	return sysfs_emit(buf, "0x%04x\n", be16_to_cpu(dcr->subsystem_vendor_id));
>  }
>  static DEVICE_ATTR_RO(subsystem_vendor);
>  
> @@ -1436,7 +1436,7 @@ static ssize_t subsystem_rev_id_show(struct device *dev,
>  {
>  	struct acpi_nfit_control_region *dcr = to_nfit_dcr(dev);
>  
> -	return sprintf(buf, "0x%04x\n",
> +	return sysfs_emit(buf, "0x%04x\n",
>  			be16_to_cpu(dcr->subsystem_revision_id));
>  }
>  static DEVICE_ATTR_RO(subsystem_rev_id);
> @@ -1446,7 +1446,7 @@ static ssize_t subsystem_device_show(struct device *dev,
>  {
>  	struct acpi_nfit_control_region *dcr = to_nfit_dcr(dev);
>  
> -	return sprintf(buf, "0x%04x\n", be16_to_cpu(dcr->subsystem_device_id));
> +	return sysfs_emit(buf, "0x%04x\n", be16_to_cpu(dcr->subsystem_device_id));
>  }
>  static DEVICE_ATTR_RO(subsystem_device);
>  
> @@ -1465,7 +1465,7 @@ static ssize_t format_show(struct device *dev,
>  {
>  	struct acpi_nfit_control_region *dcr = to_nfit_dcr(dev);
>  
> -	return sprintf(buf, "0x%04x\n", le16_to_cpu(dcr->code));
> +	return sysfs_emit(buf, "0x%04x\n", le16_to_cpu(dcr->code));
>  }
>  static DEVICE_ATTR_RO(format);
>  
> @@ -1498,7 +1498,7 @@ static ssize_t format1_show(struct device *dev,
>  				continue;
>  			if (nfit_dcr->dcr->code == dcr->code)
>  				continue;
> -			rc = sprintf(buf, "0x%04x\n",
> +			rc = sysfs_emit(buf, "0x%04x\n",
>  					le16_to_cpu(nfit_dcr->dcr->code));
>  			break;
>  		}
> @@ -1515,7 +1515,7 @@ static ssize_t formats_show(struct device *dev,
>  {
>  	struct nvdimm *nvdimm = to_nvdimm(dev);
>  
> -	return sprintf(buf, "%d\n", num_nvdimm_formats(nvdimm));
> +	return sysfs_emit(buf, "%d\n", num_nvdimm_formats(nvdimm));
>  }
>  static DEVICE_ATTR_RO(formats);
>  
> @@ -1524,7 +1524,7 @@ static ssize_t serial_show(struct device *dev,
>  {
>  	struct acpi_nfit_control_region *dcr = to_nfit_dcr(dev);
>  
> -	return sprintf(buf, "0x%08x\n", be32_to_cpu(dcr->serial_number));
> +	return sysfs_emit(buf, "0x%08x\n", be32_to_cpu(dcr->serial_number));
>  }
>  static DEVICE_ATTR_RO(serial);
>  
> @@ -1536,7 +1536,7 @@ static ssize_t family_show(struct device *dev,
>  
>  	if (nfit_mem->family < 0)
>  		return -ENXIO;
> -	return sprintf(buf, "%d\n", nfit_mem->family);
> +	return sysfs_emit(buf, "%d\n", nfit_mem->family);
>  }
>  static DEVICE_ATTR_RO(family);
>  
> @@ -1548,7 +1548,7 @@ static ssize_t dsm_mask_show(struct device *dev,
>  
>  	if (nfit_mem->family < 0)
>  		return -ENXIO;
> -	return sprintf(buf, "%#lx\n", nfit_mem->dsm_mask);
> +	return sysfs_emit(buf, "%#lx\n", nfit_mem->dsm_mask);
>  }
>  static DEVICE_ATTR_RO(dsm_mask);
>  
> @@ -1562,7 +1562,7 @@ static ssize_t flags_show(struct device *dev,
>  	if (test_bit(NFIT_MEM_DIRTY, &nfit_mem->flags))
>  		flags |= ACPI_NFIT_MEM_FLUSH_FAILED;
>  
> -	return sprintf(buf, "%s%s%s%s%s%s%s\n",
> +	return sysfs_emit(buf, "%s%s%s%s%s%s%s\n",
>  		flags & ACPI_NFIT_MEM_SAVE_FAILED ? "save_fail " : "",
>  		flags & ACPI_NFIT_MEM_RESTORE_FAILED ? "restore_fail " : "",
>  		flags & ACPI_NFIT_MEM_FLUSH_FAILED ? "flush_fail " : "",
> @@ -1579,7 +1579,7 @@ static ssize_t id_show(struct device *dev,
>  	struct nvdimm *nvdimm = to_nvdimm(dev);
>  	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
>  
> -	return sprintf(buf, "%s\n", nfit_mem->id);
> +	return sysfs_emit(buf, "%s\n", nfit_mem->id);
>  }
>  static DEVICE_ATTR_RO(id);
>  
> @@ -1589,7 +1589,7 @@ static ssize_t dirty_shutdown_show(struct device *dev,
>  	struct nvdimm *nvdimm = to_nvdimm(dev);
>  	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
>  
> -	return sprintf(buf, "%d\n", nfit_mem->dirty_shutdown);
> +	return sysfs_emit(buf, "%d\n", nfit_mem->dirty_shutdown);
>  }
>  static DEVICE_ATTR_RO(dirty_shutdown);
>  
> @@ -2172,7 +2172,7 @@ static ssize_t range_index_show(struct device *dev,
>  	struct nd_region *nd_region = to_nd_region(dev);
>  	struct nfit_spa *nfit_spa = nd_region_provider_data(nd_region);
>  
> -	return sprintf(buf, "%d\n", nfit_spa->spa->range_index);
> +	return sysfs_emit(buf, "%d\n", nfit_spa->spa->range_index);
>  }
>  static DEVICE_ATTR_RO(range_index);
>  
> 

