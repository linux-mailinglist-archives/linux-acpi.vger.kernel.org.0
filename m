Return-Path: <linux-acpi+bounces-6760-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8270E926C3A
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Jul 2024 01:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34158284463
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jul 2024 23:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9151818F2D9;
	Wed,  3 Jul 2024 23:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nh989kmV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915EE4964E;
	Wed,  3 Jul 2024 23:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720047852; cv=fail; b=GDByf4P4CMWPHC6tYnBq0n6t5KzeDihcbv/HxCsKvDT4cgGtGOwEVvrfP/g5p22h6QeDA7GQhfTHlmbpX+5haUvLXulFb9ZDztjRMztoEF67E02W9KEfih4+kFbuPvw3gXUZSv7qSZ5iHKLO8wyqDLd6ykmnIUBpdAWeCMUVHRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720047852; c=relaxed/simple;
	bh=zpSVx8mR0AcGtQxz+mcSCAGHky7IoRaCuQ/aBIu2oAU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ABqmQnuEpZqD+kGFuRc+lJzPGFGMx50x8Ms6x5Fb4pw4G92H8V+bo4p1pIho+FIwye0wObooFfEc8oUnMpuYMIch8iKePvTty1vSuzaxXLBSR3CRodbZjHb3Rg+iMm1Z3DMefKtCxPU1JTyjMxGrFPPmq4v/voZTHPxPFhk3rnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nh989kmV; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720047850; x=1751583850;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zpSVx8mR0AcGtQxz+mcSCAGHky7IoRaCuQ/aBIu2oAU=;
  b=nh989kmV0McZ7a9v5aP+mlyuLuxgQNvzlbe5K2aniljaarUvT4i82pjK
   0iNUhvEktz8H5CF4ydY4b6nIru+rUaEANtcxApWwYXNiPsqGq9ZEnxxu+
   tFDfvpvejMheQ/yaapGmw2FmCREOYZaKnSLKwwc9VVG/9KRnHcoYxu4bD
   m1CgS9HnL2bpmNRUfLWJH45+vCQsWy+TuCN379qhwVueO+XDUkGG+1ovl
   k6utnt32o24yRfQO6dgQI1CQNHkiAaW++nz8SCgr9V1G4nu4+MqHJUtdp
   gEu+UcfYRDMkm3xjH3Zh5R5/G4X6F2Qr2HkoM2rIjBstucRSxco6ndQdm
   g==;
X-CSE-ConnectionGUID: oYVPsgnMSh6/wU2nmAvFsw==
X-CSE-MsgGUID: RJoFv7rKSKym9VS0iq5AZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="17517741"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="17517741"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 16:04:09 -0700
X-CSE-ConnectionGUID: uOWyfyrDRvKVlJ3Y7F1hNg==
X-CSE-MsgGUID: aUsBpBE9R5Cp+LdO/qk8Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="77140187"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jul 2024 16:04:10 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 16:04:08 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 3 Jul 2024 16:04:08 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 3 Jul 2024 16:04:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mC7JuDD83V6RiHRqz8SYQEc6ndG1QrmwGRNZ7gk3HOCl0Dc+pwhqyle8JBiVnLRtM/Z4eaNmnxfMhPGz1VwFj2XEDs70ApdXBOm5pfEUxQqVVNvrGHGQH9dwPpRsChteNmA+bIMaBiswJy4mez18+ZnRW8Ck9QQqKyH/d/boHHqSZr44JYFbmflohdh9vV6/roB58pfniayaRB56Aw8Hd+zv256qth+waeXzDhgygws57LnXWYUDDwg2akad6iZf1IU1bQZSH+GD7mC9YZfB/eOofGXdiwUfvRuY7jqFrXMd0iFdMMj+cOtnh3GTw0k2LNj+3DsWPA6koq8xasRJcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hNPgZDl0YFjwY18j2WRSnbbhGUohirlBhVKvjD7BY38=;
 b=etckZA9UDP7Zc7MaImnfqINpYnQDagr7UrxQoTOfQ3HIMUTBCISK/tFvznJ0RaVTjl2lr1HyyYElBQMNfX9OeAzXi3adTeG8isILgDl03G4fZDefE/3BororfnZvdKsQPv9G264hfK307xgrL1noQ2l+ZcptY9LtanaKKrBR8+ZhDTdlnwTISFwluKgK1RQ6LEdnPrqJdzYYgOz0DAeIh/JSLacj01mPvPOIeDwh0cxjRZUKEz2FgDOfSkWYmKh6/YAJt963wh9krzk/7v4i5dGrAvgecgUzrgQEPUVxO1/4kCK6lKgLmIcQRqjUmVuM1Z82lfdb2v0IMdKFbZyVew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB8568.namprd11.prod.outlook.com (2603:10b6:a03:56c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.42; Wed, 3 Jul
 2024 23:04:06 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7719.022; Wed, 3 Jul 2024
 23:04:06 +0000
Date: Wed, 3 Jul 2024 16:04:03 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<mahesh.natu@intel.com>, <rafael@kernel.org>
Subject: Re: [ACPI Code First ECN v4] "Extended-linear" addressing for
 direct-mapped memory-side caches
Message-ID: <6685d8e3bb8f3_4fe7f294b0@dwillia2-xfh.jf.intel.com.notmuch>
References: <668333b17e4b2_5639294fd@dwillia2-xfh.jf.intel.com.notmuch>
 <20240702133112.000077d7@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240702133112.000077d7@Huawei.com>
X-ClientProxiedBy: MW4PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:303:8f::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB8568:EE_
X-MS-Office365-Filtering-Correlation-Id: 2331ec1e-b7b2-4ff5-a3ae-08dc9bb47048
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6so60tBi0z4w0UFb3U6Ch/NUbLQXu5Gx1/+EEE0rBxdpAZ5pC812qZZ7r8qS?=
 =?us-ascii?Q?T20HL9H6krO5M5LbXIuVzw7Z22Ds6X/uu9aOQnUZLUWq8v1ZQTo8Xl1MshHP?=
 =?us-ascii?Q?DGj4uclnU7Q6+vvZepxKpmYgjZT3SNZsixBK2zXUM6cH5q9HJ5Fo72ZUOD7l?=
 =?us-ascii?Q?g9qVig9v8XHQjPHrKZsDiGTQrCa6ZsFawJ1wTIrv+syDOGTtzaH08Spni5cq?=
 =?us-ascii?Q?QIYPgBfXPvjFqdVng3IZ6X35+QRLeRD/MgM+g0GnNsmxUZD+EHMuiq+B0UcW?=
 =?us-ascii?Q?T+DvwgcDXSOW3Nm5MkXWOomXmSYd8UdxkNVvQGlNQyShALw2g/wIaqAHVH9B?=
 =?us-ascii?Q?hEg1NigG0LwA8UdIE7Tr3B16YqmdiwbpPCCYyxaO0jREK9UY3fZ/0l3fSVPU?=
 =?us-ascii?Q?ZT8Awat8qhtL6YkiEMLrnWmlJm0C4WBDHtPldVRFgL7C6X377wGuNDXaoH4M?=
 =?us-ascii?Q?wu00qF9X+NkFMSzINuJECxDB0kLnqDEd9qjuK6HuEfJ5/RtVH5Q8377aSrM5?=
 =?us-ascii?Q?6/NCexDIttrTT0ypUf+n+rmRK7T7YeG94qClAzNpbAkMgjSDIdBwTveSpcTX?=
 =?us-ascii?Q?Mt6VQe0HBsAHbBZYNyptaPN71PLYGuhXphRFt9xe3yMHLVSAXqH6foab8VW2?=
 =?us-ascii?Q?lrd/DIbMd0pumihBJ/06JKR3KslqNaBYTFF9VI+z3G71nVVPABEZ/SjpfAms?=
 =?us-ascii?Q?v+gqXDDnOYWUp8j2SZNGMDpD6TnrDurkkZao7ZkPeifFE7+27xhmt8KrWXYE?=
 =?us-ascii?Q?2D7h0tX9PxiarsYo18/EJzAE5v0OUIBsQfD2+DW50iRP1Bf6WzdEIs4r1iib?=
 =?us-ascii?Q?8+6+DP+upX6tyGccFborEhw8twVklRF1H9FH4nnvzEauKLBadPIp7EEM23T3?=
 =?us-ascii?Q?g+dJjkDjMEKrBdYeBlzh0CLROgoDw3vH+ItNRA74s6a6m2EsxZEp2GgANW8M?=
 =?us-ascii?Q?45HQfc+lMNSgteeXIj9DFRKT2W44KYIUs/7KH/htLI7XvNCoPoS4a/d2SQbc?=
 =?us-ascii?Q?rB7i3fT6oYVAMaYbKlc7vZ5tAmrZsEkhI88OC33nZVA7dw9ZVO0P/BpAkEtI?=
 =?us-ascii?Q?Z2yQ1yQOx3r11KiwGb+nCyXGvdj6bj1UWN1IfV2sZ/fuKQODgQQRyYtmWVZC?=
 =?us-ascii?Q?t9k3H6cZDRIyLgn8DPZTZCML9eu6CMZkMeyYbLcuZpDb0Ozw6ILhblaaaceF?=
 =?us-ascii?Q?SgawfnrpUHl20/F5VOzyR/ZPARz7dJ5xzEgXVrNnb7JxfAqdm7aCehW+W7vY?=
 =?us-ascii?Q?WMvDxLEu03FF8zSj8N5iiWbHALgcfBZSO/O07XsJ0+k354c0MK4k2j1efqaD?=
 =?us-ascii?Q?EhuHS0wO8yYA9GyvwLnpDwtm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a4AquqqHoOZ+OB1GjysoliZQc1mpTX3XrULaap67AABZbU1c72w74gajSBX1?=
 =?us-ascii?Q?ImBXmYWQd4ruB8NL4QTlGvr//3goXIo91CccdCvhmA019ZX/R/c/8e0lDK2N?=
 =?us-ascii?Q?4vvyiQ9lGaUP8ipCgykdFVkHnRXbqgj2n/W0TMBLKJe8kczu3uNVoHil2dLd?=
 =?us-ascii?Q?72YOhuxKeQxlMIEu1ObpoxFHi+0oE8W/PyCRirMUJKZ3eEwSwFl9M5iYENVC?=
 =?us-ascii?Q?RbS8EvBUzsTBNZYg5Mf6my2b3KlQf9rPtlah7tj/ZEnyBEE2QPw4QYOZ58bF?=
 =?us-ascii?Q?9FjUvipi29Lh1+cxTDwvVA0KXZLhje2iNWP/Fn0vy5U9hY5hqxH+IVvQfkeT?=
 =?us-ascii?Q?yd2LJrsowwFEwu+T8kzlQqghsUqA3TtwEwlc8pKM5gIzFYuiFpTE808hwQA7?=
 =?us-ascii?Q?Nkapxs+bH2w/RwsKQ/zro1f1rIHUjXY7sWyJGo4q8BqXucrUrGuzTt1qvr2s?=
 =?us-ascii?Q?OVT55KWTxg6HvNIUSAm+86Vym0EPbBajkf4HcEzzsSHjscpk9L4Wrw+dzpJR?=
 =?us-ascii?Q?DUlyHVOWG6gGbfUMoTOrJdHNcIE8vr5Mb2BPtMdsSumKL4XStW8ZRqgE7zbY?=
 =?us-ascii?Q?fwStvdjezMrIfGFapY0wDDWXkWurjDCwT3G9sRH2Ex8IGZpia1D1P0enNk7E?=
 =?us-ascii?Q?DDETh9jbwjq0Ey0JbZ7MBEPTdjZC6BxOkPgtRW+c12YSzgkb4qrJ3E/VJdp7?=
 =?us-ascii?Q?icmj5dpTPm9b6KYeeisD1Y9mc+KSo5peTxDCZoJaCSRLeYdCaZD28azWn4Xp?=
 =?us-ascii?Q?z6yB2WRwtlWJxztmQPWGfMio29Y+V85eOtBnvz2oygsdpmAWinnmR3CcU7ud?=
 =?us-ascii?Q?uKT2aoKJ2rtlAUth1VnHfS0C2pb1pb1UYZ9NfCPhMBmhVIFbaRpkZ77QlkNd?=
 =?us-ascii?Q?q9csjB1zYnYAfLj4Prui77S3nQcWvZr106ZB98AnD68QCVJMcZiroX8vrq/p?=
 =?us-ascii?Q?mdMkFVZDGkb5B6JEl8/TaIdXZCPEmBWrN3jwZ5yGPOLB4wrlRcjAiq7cDT9J?=
 =?us-ascii?Q?Sb42x+d/hzkRUxRz6B29OXuACmstfmWNgvB2MpfmrD3rvVZ7/SvngifZJ5Oh?=
 =?us-ascii?Q?iof2LPWHAT/L2OtFdjBCBUq+ZG0LsW4b4W0RqPXldmJDdUtR56YA8OR6MzYG?=
 =?us-ascii?Q?a7+pdDmlOEtlMIFokmbMHkaSnCqS3MwnVtHpLOtA74xSv81yhWp6pvUN4492?=
 =?us-ascii?Q?iaHigdHEMRP3flJo1jLRxZAAubJSroXfjyxbXqTyyTmk+r8Dbk32aBwmq1s2?=
 =?us-ascii?Q?VLI5sbN8c1Yo3Jo36M5gLyP5mIEXOEhNnFOSzwwjeBIsB+ie9Qf+mXZgXeZm?=
 =?us-ascii?Q?NEXvY1mhq+Ilkij03qTjMi4y7gbJHwLjCk4TiSVW6hriLGHmhpjnpITtdWhO?=
 =?us-ascii?Q?sSTNsfakG2NnqkpFY+IhS0+xJXSzZ4vo9TrzrDNMQGcyd/YrkW+unD67cKfc?=
 =?us-ascii?Q?ht1CL2NzO8oaEY/1PB0Gy+MwW5j448b7dfPT4MwrVZtBb8wCS4S1q+5v9/kV?=
 =?us-ascii?Q?yhooXB9S9FU8f1xCHRqVH2w2oPUXpmjY/hGPwW4XYmp23a4VgOWFr6SAKCxy?=
 =?us-ascii?Q?Cq/EsJmnXUW9vUp16c0mv6D6DU1Xw0vXsDvULiOYiwj/GoHmce2zM3bQmJOz?=
 =?us-ascii?Q?PA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2331ec1e-b7b2-4ff5-a3ae-08dc9bb47048
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 23:04:06.1244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RyDp2ybHzZTD5fpO08deXf6DuTBznzmdzxN6JUcXZbgJPdRiuntQ9o9Fh4XbmITnC69ct6Y0Bpap9qMsuE2D7k9ePkJvG/X9D8wr7LhjGeo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8568
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Mon, 1 Jul 2024 15:54:41 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > # Title: "Extended-linear" addressing for direct-mapped memory-side caches
> > 
> > # Status: v4
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
> > * v4: Drop "improved cache utilization" claim (Jonathan)
> > * v4: Clarify SPA vs HPA terminology
> > * v4: Clarify possibility and difficulty of multiple CPER records to
> >   communicate aliases (Jonathan)
> > * v4: Clarify that N is expected to be an integer ration of "near" to
> >   "far" memory. (Jonathan)
> > * v3: Replace "Inclusive Linear" with "Extended-linear" term, and
> >   clarify the SPA vs HPA behavior of this cache addressing mode.
> >   (Jonathan)
> > * v2: Clarify the "Inclusive" term as "including the capacity of the cache
> >   in the SRAT range length"
> > * v2: Clarify that 0 is an undeclared / transparent Address Mode, and
> >   that Address Mode values other than 1 are Reserved.
> > 
> > v3: http://lore.kernel.org/6650e4f835a0e_195e294a8@dwillia2-mobl3.amr.corp.intel.com.notmuch
> > v2: http://lore.kernel.org/663ea70884cfd_db82d29414@dwillia2-xfh.jf.intel.com.notmuch
> > 
> Trivial suggestions inline.
> 
> Otherwise seems fine to me.
> 
> Jonathan
[..]
> > # Benefits of the Change
> > Without this change an OSPM that encounters a memory-side cache
> > configuration of DDR fronting CXL may not understand that an SRAT range
> > extended by cache capacity should be maintained as one contiguous SPA
> > range even though the CXL HPA decode configuration only maps a subset of
> > the SRAT SPA range. In other words the memory-side-cache dynamically
> > maps access to that SPA range to either a CXL or DDR HPA.
> > 
> > Without this change the only way for system software to become aware of
> > the fact that one memory poison event implicates multiple address
> > locations would be for multiple error records (CPER) to be emitted
> 
> multiple error record sections (one CPER can contain a bunch of those).

Noted.

> > per-poison consumption event. That may surprise existing OSPM
> > implementations.
> 
> I'd be tempted to add one line say that obviously this is impossible
> for OS first handling as no one there to generate the records.  That
> is kind of implied, but might as well say it.
> 

As I understand this proposal is already under ASWG consideration so I
am pausing on any other editorial updates here awaiting that result.

Thanks for the feedback Jonathan.

