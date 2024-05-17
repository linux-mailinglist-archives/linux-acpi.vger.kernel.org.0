Return-Path: <linux-acpi+bounces-5887-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1053A8C8D44
	for <lists+linux-acpi@lfdr.de>; Fri, 17 May 2024 22:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3401A1C224E5
	for <lists+linux-acpi@lfdr.de>; Fri, 17 May 2024 20:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B2612FF78;
	Fri, 17 May 2024 20:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e2FIL4XD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAEE65C;
	Fri, 17 May 2024 20:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715977215; cv=fail; b=Wc5z55m6aKsJEy1z5j2E8VXGHl+XOTUi+Qqr4xLoYS+dUY86TWijIxxYoXr7VjXj79IoBPAP28g1+4REpW9rz0woiO0Yw1cVjtthXVRXWXzl1f8qeMwbHK5aok+do7btHKz/EHKdK/kXP1dmtTGQHSdh5vITVxI87XYl6Szyumg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715977215; c=relaxed/simple;
	bh=oxqdgep36SWzFF0E6eEnNmXv/gVxVyLM67T24DHd/Q4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=he/qDlC/yUehH5pkhgSF2/Tw+k0fD0o48H8ynxfrwVmjs4+ofVknWsC0h6s/Y4UliWcJMqw9MWdCJpB3yv8njjLkaJN5CiUnEpfiSHpAwWLRPLh/9373M3JN0lVIMeYHGNXoI08XvN/3OEKZVjHK6saaE+Y5D3te7zSRAUgcbS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e2FIL4XD; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715977214; x=1747513214;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oxqdgep36SWzFF0E6eEnNmXv/gVxVyLM67T24DHd/Q4=;
  b=e2FIL4XD/H4YtiBrvgjjwYzzN0aKz/rdkXLW4XVJcOA73RTg4X2k4Xo6
   JUKw8GEME7bm1UO6OHg7bnRsk+fSCdnJnvAqrEMkZlr6M+RmpTlmcpXW+
   MuvOXsXtEy6o5+4q4XZErLBa2feGzOmw9q0YOy3GAVOsTUnYXvrLNzJ7K
   W3tES6pLRvvaMeGBYe9H6hHsGrxX3iz2j1Ztq/ZLd2l3JWIDJtENVzx4s
   C47l2giv6jj1vXxwxS+yVDw7lPoH/VA3QJ5E7z7RN2SFRaqkwotsuDQQD
   kkIWnT60zweoRvWV7txWhynJlUWnk2rxBGi4lNXd0baquwrgI2P5DraxS
   Q==;
X-CSE-ConnectionGUID: SCZwOykQTlySlzjYSflF6A==
X-CSE-MsgGUID: mNAKp9jMR2+mVbt/xvNr6g==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="29695678"
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="29695678"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 13:20:13 -0700
X-CSE-ConnectionGUID: eoIBrdwOSFa/ebr1OVnOiQ==
X-CSE-MsgGUID: US3gmuk2QgKX3l/dVwksuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="63094945"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 May 2024 13:20:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 17 May 2024 13:20:12 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 17 May 2024 13:20:12 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 17 May 2024 13:20:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CfaxoJrwln6MLBmFoqAFaHYwy0s5NtE0WaQqeOX9zlTdZzBfApsWUM9qZQ9HKSyGQ07YOf6XfDD/RkhIfnHePP8nOzSC03YrcZ8qOBw14FCmiWIbv6RA5DtS5k4bAcerWfh5x/W6mQOT2H2zgM7Eh6qYNxupODRLCfdtw6qPjjS/ItIFexunXfcMH0WSqM4q8CSKfSHZ8XT49C/1vFL+iRNCIhPfWflGIN78EVtQIJbloS4/0nsvpLWyUxOBwTHBPkmqDJiev6YlIVa20+fdEMG1cG7BU7fVrVBX52d83xkXxCozIX+QQcrfOV8zvB83IxJaJcqXsFJZwgiqOvs4nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCSywNEbFcTZgGd+n3u93WvDavhXTigcNu22vmDvXxQ=;
 b=QoNgJx6txoWz56ZyLjNELhd9t3l+QHTIPkSzqkbEJX/02X6R23dVmpcPHAdr9LxRqcCzE51X+iEP/iAQriIQkOtyQppnsPaOSXtiOw4aCuxYZ5LxfUVu8Ob+dEjDiDZs67k3QntuDldVqMSm4LXHVvbSTBe+rnyNbDLuzcLfwcwxS1jVwbsGP3dsvqqWpRdMULa2npviVxuXVabFUmtskLqwasHaX4UaK1DFiCW652z5OPlCcttrH75jnw1Exwl332bYuiVo3DLNCuEKVFo4kzkbOhHiZdA9qfVgYEvo/atKQgRQsHn31gyJROiCtpjrrtkVWMbrlETE8J++yJTZgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB7062.namprd11.prod.outlook.com (2603:10b6:806:2b3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Fri, 17 May
 2024 20:20:09 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7587.028; Fri, 17 May 2024
 20:20:09 +0000
Date: Fri, 17 May 2024 13:20:06 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<mahesh.natu@intel.com>, <rafael@kernel.org>
Subject: Re: [ACPI Code First ECN] Enumerate "Inclusive Linear Address Mode"
 memory-side caches
Message-ID: <6647bbf6c88e3_2c2629451@dwillia2-xfh.jf.intel.com.notmuch>
References: <663ea70884cfd_db82d29414@dwillia2-xfh.jf.intel.com.notmuch>
 <20240517174550.0000242a@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240517174550.0000242a@Huawei.com>
X-ClientProxiedBy: MW4PR03CA0172.namprd03.prod.outlook.com
 (2603:10b6:303:8d::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB7062:EE_
X-MS-Office365-Filtering-Correlation-Id: 67a2a256-e412-424b-5245-08dc76aebf94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hJkgVx8S17+3SERV19THjz8taP2XWEsnYv4k8VXsQd6ShcQI+g0T/T04HZH5?=
 =?us-ascii?Q?HVigewHZ4KNRAbkBZpzC9z13R41SBzID/1WOPi6JAbBsf0qy7EXOP+DxCVER?=
 =?us-ascii?Q?cBaWjvai6+UW9IBEur3EdrUbDheqr1p/KAVr+Jxr0OtEDQ2OTVt0J0WzGuTc?=
 =?us-ascii?Q?K0ZrxQBoEufaCKlcSa4rq9JfhReBQv+KIWOOihEcoZxzedHUgepcUJZXVLHQ?=
 =?us-ascii?Q?6BYoqIcuOHsi2aObnM13ZCfww0yTW7MvXR5/DaAibuq6I/1vPCo/2beVTlc+?=
 =?us-ascii?Q?vXwDttqxmzS/Fu/6bS0msuB7c34u9qDHbpNKQrdfSrKtMBm0x4kZjKs26I5f?=
 =?us-ascii?Q?pNxTVtLsgeMWMpN6HRVTuzqps8c3T3GtMX6rKyIwVVDzjCdaaZHXTRmApbSO?=
 =?us-ascii?Q?5a5TfM1uk0qsmGmKJnAXHbFLaxCZmZHJe4ZYAu+ypbzcMLJV9MYomALGud19?=
 =?us-ascii?Q?7gH8/XboVuBX3OFoCoqScrS99k4vSHn4tJK06Nbvq1CCOjVG7e8OMT8pOjUT?=
 =?us-ascii?Q?HNehmeqAwebMRgyU5qw4ePkmDS6EN2Dt76onEhmflHo8NMBUViZgYD6oy6ik?=
 =?us-ascii?Q?NeP+UG+c8LPh7SUJYOxLLMy8LCm8Jf4tHqSykDNXzwVXouNuc7V5cZ+w/a5M?=
 =?us-ascii?Q?x6lVAJ1MOfL2f97dQ38W59yzqkVvYbPOVwCOImhp9ztmUbqWeTWw4zi9WeI6?=
 =?us-ascii?Q?NQAj1FKn/JsTfBtw3FMfHgcSCPSrraMrf2ZaRHuViqCDwiIb+48t38mKaWd6?=
 =?us-ascii?Q?e3j/oioHpDvPyjEHK9LRhXc/J+09Gwi49/vFXKL7QkaVXz9MpH6WHB2Pb9Zd?=
 =?us-ascii?Q?4JsMopMp+1BjdvryIy3LMpFMqMmRYR6DvmbcPL4+ts4rMMEqThKqPAKR/LsW?=
 =?us-ascii?Q?1zivrNqtait8Q3QOeZuHGDLWyQROBpW9RrajT0QPcU7yRBm5pv875y4Tjevk?=
 =?us-ascii?Q?2N03c/09z0wV0SzsQRqOMvHJBQp2bBR9/1zssRgQK4przhQEsBxwEO1Trvso?=
 =?us-ascii?Q?/4fxPqaq4JHOtMoGIZ9+BEbYPu+gIXUhceMXCmQeeb06zupwIA9eWcfebHoG?=
 =?us-ascii?Q?9vfbzyuC/NFnt9Nck9ZafyJ44ETlCjjtutgqWNXGF/tTGRnMHs+pw1PzMo3b?=
 =?us-ascii?Q?ObyPFrNtbbwmTOWbDO3Mukko1uwrAfmkmUYAJNT1PKamXDbli+IvVLo9pzxK?=
 =?us-ascii?Q?s+sf5rLuh8dBhYn4o4kdeCp+YgASL50q3/j3nhN8DDaIG4FOx425Zzghus0?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eZcuLz4v1xcg8WwXVoADth/xSsYAcyRN8Vv9BBp3FjvL01QKgPnxh8zldnI1?=
 =?us-ascii?Q?BWpaQDff/se5CREyeE5vD9FVJbX76udMMERNqdAXIwSCtMNKiFR7rMK+TnUz?=
 =?us-ascii?Q?UE+Fx7OaOB1tKgvqmkpW1hbF9kny2a7OPjDuElrIdkBIkolAlvvoncQk1mBu?=
 =?us-ascii?Q?AHzEscRgv5XwX+Gv9a9NoNAYYRJLzrdBy0cqKFYroijoUHd3d+Lli0bEwz7c?=
 =?us-ascii?Q?gYrGpPb2spcTpGQ7PTqYLvcoP1q8pfWtUUVxdIPCltxobzrD16TDH9KzjOoU?=
 =?us-ascii?Q?exl+kPRWFoe8kwnsM98oUA59iw7AxhzV+IthMapRW75QtIY12UI60lMEH0gL?=
 =?us-ascii?Q?bNvlAaWh5oyKFuwdLWesWfQMZZFtOhKZ96Bv9EQjSxIAFn0ouZ3C6zsOfhnS?=
 =?us-ascii?Q?2//Bwxl+i2rY+eTD3aIowVBhUIqO9nlrSWrwHzdCtRBDILphXEtDOrooT8ec?=
 =?us-ascii?Q?YSVtiKO6w7TsayLRvyfxwKjnhMdbg4sV7YeHSzrlEWQ2iQYA0jhate534Srm?=
 =?us-ascii?Q?BJOZSpwir8f7wo9Kd6Beqil1zooRLQSN+WBY+MjlvtlJ2Eh1NHgyAUNJLmUV?=
 =?us-ascii?Q?VhmqwWiRI4Ij1mlw9G7PUeOvD3VDI9uXhz7tE7/3jOAGidQkt+hegvxzvQKm?=
 =?us-ascii?Q?EsGYCzD4ZM6ouhb42yS9G/6U7Nsx7IGTTlPjToBmg6myUcliB4ZlCWIezg0/?=
 =?us-ascii?Q?ozBLskoR38hkjVnnzjKrbBXyBBPP+gVn0QzB5MsvdQ6Z+t0bUij74O+udx+p?=
 =?us-ascii?Q?p7afV4MH5yPXd5d7+QMHferk/U9zr43CpCWQFLON9mLQipnFUiRr9YOJQFHA?=
 =?us-ascii?Q?+rurNsG+cJUOhP4rxt4GL4EnFh8LMJjdbPy+v9G6KhuzTEacdeCKceD406dD?=
 =?us-ascii?Q?UzSiJV2gJoYueNwkK+aFk7KTslJXI940L8MQH0e0DwauYFRBs7RUJlZoWC/w?=
 =?us-ascii?Q?r2LY4ChuR9kGpZB9z7zRtjFT5RwwoRVtiehwJL+JElaPRytlCJrziEzcRZxH?=
 =?us-ascii?Q?L2bRKr0KXvSM7SHdhpHLG4jsGFiPARM1UHMRM2tIwI7bl88BfyMvl+8vwG2p?=
 =?us-ascii?Q?9E7inxc14aIu/I/tKDaR4hWRGq3oTMTZXfBMI7zmUeJ0jx4IM8gCu1jB43YM?=
 =?us-ascii?Q?KZQ0k9HsWZ7mrnEKydFCDDhxXrRKykiBD2ZK1Cxr9btc1GK7LMsUR3hWFkg8?=
 =?us-ascii?Q?hV0srFSUEHd59ZyzupMRJTlHLmoLu6sKfmt+iIQwSADYZzwGVxy0m4sSHUVZ?=
 =?us-ascii?Q?0bdVNSnxou7PpydVF6BrjRablOxY1KSNgtjZ8oz/Ck7vqzD2R9/76YRpySIU?=
 =?us-ascii?Q?4yEZkhMSJyKCpkTRn+SKH4go+F/dqXAne/JYndLyKTWgE0DHzakDnetFrSDf?=
 =?us-ascii?Q?ZOiYsNEZbSX0g/ghxg9aIHygqD3Xh+rDHgKOs8TzRPIe7xEuyduOmPL25imd?=
 =?us-ascii?Q?nYwXEDx7ZaLBlORCCadF6CebEiPMIw+DOxB8j8/TOoLkdnna45xtKD5owNJm?=
 =?us-ascii?Q?LsJqp6O8gg5cHi1quON4hj/iWVfOCA3+YtG+XvPQ93eHwAEMjZzOh8lZ6yL3?=
 =?us-ascii?Q?iTo6ep1lpdl7S36vqysSTL1epL8Y5aV8B9CCdj81F5x7CADrtp4ltFAy5c6Q?=
 =?us-ascii?Q?sQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 67a2a256-e412-424b-5245-08dc76aebf94
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 20:20:09.2270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W5uhdqc2fUO9UJ1MFlXam7vyHJXPV3RJrpauLfmR6xh9KZTO7zX2AhDpxwoGAI/jMKG1YBPNsVPUM76bg78d2tkK9ym7jSlQYy8xRIYUdxc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7062
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Fri, 10 May 2024 16:00:24 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > # Title: Enumerate "Inclusive Linear Address Mode" memory-side caches
> 
> So pretty much all my feedback is about using inclusive in anything
> to do with caches.  Term usually means something very different from
> what you have here and it confused me. As an example, consider a dataset
> that fits entirely in CPU  L3 / L2 capacity.
> In that case the situation you describe here looks like an exclusive L2 / L3
> cache (line sits in one or the other but not both).

I clarify in the text that this term is an attribute of the *address-space* not
the cache hierarchy. If HMAT ever needed to described that a multi-level
memory-side cache was Inclusive or Exclusive then I would likely steal bit3 of
Cache Attributes field to enumerate that detail, but it is not clear that detail
matters to any OS mechanism or policy.

> Maybe just describe the problem and skip the exact cause?
> 
> Enumerate "Unrecoverable aliases in direct mapped memory-side caches"

I have read that several times and I can not map that title back to the property
this "address mode" enumeration is trying to describe.

I would prefer to just pile on more explicit clarifications to overcome that
instinct to map the word "Inclusive" to a multi-level cache attribute. Something
like "note, 'Inclusive Linear' address-mode not to be confused with
'Inclusive/Exclusive' multi-level cache organization".

> Whilst the CXL side of things (and I assume your hardware migration engine)
> don't provide a way to recover this, it would be possible to build
> a system that otherwise looked like you describe that did provide access
> to the tag bits and so wouldn't present the aliasing problem.

Aliasing problem? All direct-mapped caches have aliases, it just happens that
this address mode allows direct-addressability of at least one alias.

> > 
> > # Status: Draft v2
> > 
> > # Document: ACPI Specification 6.6
> > 
> > # License
> > SPDX-License Identifier: CC-BY-4.0
> > 
> > # Submitter:
> > * Sponsor: Dan Williams, Intel
> > * Creators/Contributors:
> >     * Andy Rudoff, retired
> >     * Mahesh Natu, Intel
> >     * Ishwar Agarwal, Intel
> > 
> > # Changelog
> > * v2: Clarify the "Inclusive" term as "including the capacity of the cache
> >   in the SRAT range length"
> > * v2: Clarify that 0 is an undeclared / transparent Address Mode, and
> >   that Address Mode values other than 1 are Reserved.
> > 
> > # Summary of the Change
> > Enable an OSPM to enumerate that the capacity for a memory-side cache is
> > "included" in an SRAT range. Typically the "Memory Side Cache Size"
> > enumerated in the HMAT is "excluded" from the SRAT range length because
> > it is a transparent cache of the SRAT capacity. The enumeration of this
> > addressing mode enables OSPM memory RAS (Reliability, Availability, and
> > Serviceability) flows.
> 
> 'excluded' somehow implies it exists as something we might include but
> we don't.  'Not relevant' would be clearer wording I think.

But it is relevant. If the near memory (cache memory) is 64GB and the far memory
(backing store) is 64GB then the SRAT range is 64GB (cache-excluded). With this
new mode the SRAT range is 128GB.

> > Recall that the CXL specification allows for platform address ranges to
> > be interleaved across CXL and non-CXL targets. CXL 3.1 Table 9-22 CFMWS
> > Structure states "If the Interleave Set spans non-CXL domains, this list
> > may contain values that do not match \_UID field in any CHBS structures.
> > These entries represent Interleave Targets that are not CXL Host
> > Bridges". For an OSPM this means address translation needs to be
> > prepared for non-CXL targets. Now consider the case when that CXL
> > address range is flagged as a memory side cache in the ACPI HMAT.
> 
> A CXL address range can be flagged as having a memory-side cache in
> front of it bus as you've state normally wouldn't have separate HPA
> ranges. The interleave stuff doesn't get you to what you describe
> here as it's well defined, not a transparent cache like a
> memory-side cache.  A given cacheline is in a known FRU, not potentially
> multiple ones. Hence I'm not sure this paragraph is particularly useful.

It was an attempt to show precedent for why Linux needs to care about the memory
organization and how CFMWS does not achieve this description. That said, as this
is text that only appears in the justification for the ECN I do not mind
dropping it.

> > Address translation needs to consider that the decode for an error may
> > impact multiple components (FRUs fields replaceable units).
> > 
> > Now consider the implications of ["Flat Memory Mode" (Intel presentation
> > at Hot Chips
> > 2023)](https://cdrdv2-public.intel.com/787386/Hot%20Chips%20-%20Aug%2023%20-%20BHS%20and%20Granite%20Rapid%20-%20Xeon%20-%20Architecture%20-%20Public.pdf).
> 
> Other than telling us someone put it on a slide, that slide provides
> very little useful info!

Hence this write-up in the ECN, felt it was better than nothing to include a
picture for reference.

> > This cache geometry implies an address space that includes the
> > memory-side cache size in the reported address range. For example, a
> > typical address space layout for a memory-side-cache of 32GB of DDR
> > fronting 64GB of CXL would report 64GB in the "Length" field of the
> > SRAT's "Memory Affinity Structure" and 32GB in the "Memory Side Cache
> > Size" field of the HMAT's "Memory Side Cache Information Structure".
> 
> > An
> > inclusive address-space layout of the same configuration would report
> > 96GB in the "Length" field of the SRAT's "Memory Affinity Structure" and
> > 32GB in the "Memory Side Cache Size" field of the HMAT's "Memory Side
> > Cache Information Structure". The implication for address translation in
> > the inclusive case, is that there are N potential aliased address
> > impacted by a memory error where N is the ratio of:
> > 
> > SRAT.MemoryAffinityStructure.Length /
> > HMAT.MemorySideCacheInformation.CacheSize
> 
> So in your example a memory error can affect any of 3 addresses.
> 
> That feels like it is assuming a particular caching strategy without
> expressly stating it. Let us take it to extreme.  Make it a fully
> associative non-inclusive DDR cache (sure that is insane, but bare
> with me). Now any potential problem affects all addresses as a given error
> in the memory-side cache might affect anything - given it's fully associative
> it's also possible an error in the CXL memory might also be any cacheline
> in the system.
> 
> The memory-side cache description does include the option of specifying
> the cache is direct mapped so if that is set your assumed mapping is valid.
> If someone set the 'complex cache indexing' option then I think all bets
> are off. To be useful you should rule that out in your spec change.

Sure, "Linear" implies direct-mapped since fully-set associative is a
non-linear arrangement.

> > This change request is not exclusive to CXL, the concept is applicable
> > to any memory-side-cache configuration that the HMAT+SRAT can describe.
> > However, CXL is a primary motivator given the OSPM role in address
> > translation for device-physical-address (DPA) events being translated to
> > impacted host-physical-address (HPA) events.
> > 
> > # Benefits of the Change
> > An OSPM, when it knows about inclusive cache address space, can take
> > actions like quarantine / offline all the impacted aliased pages to
> > prevent further consumption of poison, or run repair operations on all
> > the affected targets. Without this change an OSPM may not accurately
> > identify the HPA associated with a given CXL FRU event, or it may
> > misunderstand that an SRAT memory affinity range is an amalgam of CXL
> > and cache capacity.
> 
> Could you add a cache attribute to say it's a non-inclusive / exclusive
> cache? That combined with direct-mapped would I think provide the relevant
> indication.  It still runs into the problem that advanced hardware
> could still resolve which alias is the problem. So maybe we are better
> off sticking to describing that fact there is an alias issue for any
> reported errors that cannot be resolved (presumably you can poke the
> the aliased entries and see which one gives poison via synchronous access)

I still disagree with the implication that "inclusion" is a property of the
cache and not the address layout for this ECN.

> Note that I'm not keen on the use of inclusive for your range description
> because that terminology means the exact opposite of what you intend
> when applied to a normal cache! I can't think of a better term though
> but the bikeshed should not be blue.

I am sticking with "include" since cache capacity is included in the SRAT
range, and will move off that term when/if someone comes up with something
better.

[..]
> > 
> > * Extend the implementation note after Table 5.149 to explain how to
> >   interpret the "Inclusive linear" mode.
> > 
> >     * "When Address Mode is 1 'Inclusive Linear' it indicates that there
> >       are N directly addressable aliases of a given cacheline
> >       where N is the ratio of target memory proximity domain size and
> >       the memory side cache size.  Where the N aliased addresses for a
> >       given cacheline all share the same result for the operation
> >       'address modulo cache size'."
> 
> That description is somewhat tighter than the free form one in the intro
> so answered a lot of questions I had before getting this far.

Happy to delete all of the text outside of "Detailed Description of the Change"
since none of it will be included in ACPI spec.

