Return-Path: <linux-acpi+bounces-16368-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A702FB4421F
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Sep 2025 18:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA95C1CC28A1
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Sep 2025 16:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664C72D3EE0;
	Thu,  4 Sep 2025 16:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XbT8dyBA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B542367DC;
	Thu,  4 Sep 2025 16:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757001883; cv=fail; b=V/F2imGGluXCMZsrRU2wP8aGZNs0SwnE3we5WiVa9MPSoS1ZW7L3ud7kDjbjO4aXq5YxIYnVl2xgjBoMMyBAcbo1wulHJwFhrOH3Nx2AOiwDptWVMffUKC11po46XSiBFdvulncmuaTiP/5YoOvYG9v+iSfdG7CHqtxTD8vZXDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757001883; c=relaxed/simple;
	bh=8GsrYfgglpfb81+q+m9g6Rf+LdRw9TllTpI1pAhfz3A=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s2Mz1KRyBy3zXnDvbDt5jKhzokCo9Ec4Rxwl+TSjbL2yYo2ROUyMa1uv8ZqvDbssweY6h3gGtwlIEj7rW3I4l4AN5iZYxhwiAR0J7fILAOFt2HM9h0wHfvDkQLavw16SpKRGEtHx51bmcInoDYjt4a/Gygzih9UTBYWjzwuVfL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XbT8dyBA; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757001881; x=1788537881;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=8GsrYfgglpfb81+q+m9g6Rf+LdRw9TllTpI1pAhfz3A=;
  b=XbT8dyBAp00dVnrc5e3ZK4TLr6VfllEzg9q6Zemmyh3JxR3kZt5snMzP
   CSvU1uThwiDtZIDtMkrdjJhIhk6n6wrAk5u1k2T7yZG/CWezY9gv9M7Ky
   ES64Yp3bfGW4yZZLGUkUEpyhRpxJotTCgD22TfpZpvH5NZrKpN5rVt+9g
   EQFvjh6dMIDvUYML0qBaert6r0wLeV0VPQjLYh/Ds7RS6ZqW5xSIbxY6u
   BmAN2f02I5MS+M0veDF4xbUQIe89syniibWcoaPygWGauNRkOgQyKmB3F
   LQLZe9bzW6DzrB7QOYrhx+23N3Fl04lhVDQxahjtVQQeAPDBzCEOgpn6W
   w==;
X-CSE-ConnectionGUID: SDR19KRvQBurvq6uaizbig==
X-CSE-MsgGUID: 9jrVV29fRnWTLwcscPWhYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="63171428"
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="63171428"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 09:04:40 -0700
X-CSE-ConnectionGUID: /gcMzpuITQWaK2d+EZJXjw==
X-CSE-MsgGUID: 9fL+Y+60R2WNtH8qMxj/ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="171874963"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 09:04:39 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 09:04:39 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 4 Sep 2025 09:04:38 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.42) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 09:04:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bdM5DVt/4ksTzLxnROsBDsfsF45zzklwCQAgFXFL5E0hm4hc6mJjyJR0MEPT3u4jBfuT0xINwZIfG+lfaUeLWD9+h/pOf6n4wzbGR38/oT8Vn2kKS9xlA8ddFo3hv7sh6tY4wUIs7ycOIrXLlIZZeYJOBBE9o7q5Tg1CnDwvI1on0VoM2R7Mm7u72iQC5rH4+N/hc1wPucWBmZlsoH3cPsQfisVZFa/qMtWaU406CsSiRRyZd9uyIai06rBn6E+mwuQEbm3QRtPAyHXyA2rMMpvRwl+vHiXic3E8mycsRjV1szUkD2pMnKhNWaHKDviH8CNIxqaHqx1Msc6tqkLJ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQlGuwyDTl53wNxJFT3Qygts1LOBtbekmj5y/ZV5UdU=;
 b=m74mJH30vcPiWKdDgWIoV8UQYNWb9ZACYP1CP5mtkTrswMYXwIrKROeFZWKzorguHhx4U3i5/mlddh+byAKeO0ZUTLfu9iiews7jGgZvtWYhKiHQJcqNA02rEVsP4StgP/GMFp54jFWpXzn0dg7PPVqZ4/8sLuh3z1t5/1F2tSTQIQFo3bAnxSW1S+7njBoonxINlyYmaIb336/QNbDlY0xHEvLoBxuouxmehxqoeE7x3ua4p+SWHrcEbnIcGoEGbHslIeqP9PLCZxIunTtYpaD3PVMtYLWUEWzvTL2zmnHZsQ/BiTW31BzSztPFuiu5MsPJTx5wAyNSTME57i5SNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by SA2PR11MB5017.namprd11.prod.outlook.com
 (2603:10b6:806:11e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 16:04:31 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::bbd5:541c:86ba:3efa]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::bbd5:541c:86ba:3efa%7]) with mapi id 15.20.9094.017; Thu, 4 Sep 2025
 16:04:31 +0000
Date: Thu, 4 Sep 2025 11:06:21 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Colin Ian King
	<colin.i.king@gmail.com>, Dan Williams <dan.j.williams@intel.com>, Dave Jiang
	<dave.jiang@intel.com>
CC: Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Len Brown <lenb@kernel.org>, Jia He <justin.he@arm.com>,
	<nvdimm@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] ACPI: NFIT: Fix incorrect ndr_desc being
 reportedin dev_err message
Message-ID: <68b9b8fdb0443_70a18294b1@iweiny-mobl.notmuch>
References: <20250902114518.2625680-1-colin.i.king@gmail.com>
 <CAJZ5v0je-10aKyA0zeDZbqTXzjxNb7yTfsWkt_-a-7uwqYdmcA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0je-10aKyA0zeDZbqTXzjxNb7yTfsWkt_-a-7uwqYdmcA@mail.gmail.com>
X-ClientProxiedBy: MW4PR03CA0231.namprd03.prod.outlook.com
 (2603:10b6:303:b9::26) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|SA2PR11MB5017:EE_
X-MS-Office365-Filtering-Correlation-Id: 8322d540-a96c-4fe8-ba86-08ddebccbbaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YkZ3cm5ncGpiWHVBbC9CWXQveWxBT2pFemc0RzAvWEFlOEdVVlUwd2ljZWpm?=
 =?utf-8?B?STdqK2lqakxaa25rSDVWbFFNaWl1Z3Z1ZStWVkFXZzY2N0lZOWlSdnVkbkVl?=
 =?utf-8?B?UXpkckNnTDdFSlF4b0FicnRQbHFBU2d6QlhWWmlOY2xrUlladERHbEpYcWVZ?=
 =?utf-8?B?QWk4bHJHZzVQNkFFaFZqNUJpaGt1amtrQTI3UUF1bldVZ1hKY2JGOUlMbmNz?=
 =?utf-8?B?K0l3ZmVmWWQxSDAvVWZzcHdXVzVUNk91Mnd4cUo2cmRsOUh6VVhjQ3RJNlVG?=
 =?utf-8?B?MUZtYW8yL1hvWDM3Y1MzUUgyQ0tobGd4SEhQMy9QSDVlMlJwNXdYWGNkeHRn?=
 =?utf-8?B?WXhTME5waEN0N2RUY256elp4b2JCWEFpWUozYXh6UnFPZjVJS1M4b3phdFNz?=
 =?utf-8?B?OU94WktnOUxobjN0cVB2SFFvbTlUa1R3ekM4cEhadG0rMjBzd1NOczFKRHdm?=
 =?utf-8?B?aXJtNmZCZmZKK21NTVhBb3hsSm15YzFlbTRXZnJ1K2dGakMxWC9DNWJ6TTZm?=
 =?utf-8?B?aUd0YXJGNHBTR3JxMXpUZDBaVlpEZTR5Y0pzNlY2dkhGOVNRMWNjWGFycEh4?=
 =?utf-8?B?K1VvOHVzOW1UV2dxekdJbUhOaVNRcDMyVlJlTWZFVkgvOGxPdjVMbHhqVVVo?=
 =?utf-8?B?VUYwdnFXT2ZGa0hKZXlIZmtaU01jbHozQnA1Z3NDZ0hWa2g1TVJtNS9xU04r?=
 =?utf-8?B?cWtUQWovNU5uVEdJYzE0VFA3REs5dnVTWEtJQ2NIbTdVV29LVmRWZ2xvV2Rs?=
 =?utf-8?B?eklPU1p0bWJRVXZTV0dQdlpOWFl4Y2grQkdMbmZidDhMTFczQmIzZmdIRjAz?=
 =?utf-8?B?UmhDbmkvZjlhZU9NVENPRUV2QXIva01aVnBVYUJ1UmxGS0I5VzFKQUl3Wmx6?=
 =?utf-8?B?TEw1cjRHTkhxYi9rN2NWaityMEVmY3ZJdHJTdHJMblRYSmI2bzR5a0ZIL21I?=
 =?utf-8?B?OWNra0o1aUZxVnpLSHR6NEhYZDlMWm56TndXMEg2N0hGaVdsZHBxM3RHT3NU?=
 =?utf-8?B?dDErY2ZBQUhCMkNjL3VFUHIrNm1DdjFzMzFzQzlyYmhFWW1FT1JITXhxejRs?=
 =?utf-8?B?NGZQenpZYXJCaStjZ1ZreXdudStCNUVITEdLQnBMcm0rSDBxSURneGZxWkFW?=
 =?utf-8?B?TVNLMlhxaFBpSEV3TkRyM0FZbjcxaURiNExLWS85eENIV0dmeVlQTXI3eTIr?=
 =?utf-8?B?dFc0SDhDZkpPNE9nK1hNOC9mdFdvY0Ruck1PSlZWYjlBMUx3dkFscjg3SldV?=
 =?utf-8?B?YlJFMVVsT3dvczQ3RGI5Y2U1V0JDV1RhM21rSzhydlZuQjBwbGl4eFFPeGg0?=
 =?utf-8?B?ZXI1Szg1QldaNldKNlV4YUpSN211TnU4dXV0Z3Mya05DZlZHSjFjVmZIZHZ1?=
 =?utf-8?B?MkV0WFEzcG5CRWwzc3Awd0JiM2xOcnk0a0FOZFFwMEk5TE93WDNxVXdDbGgv?=
 =?utf-8?B?ZTVEOWtaRFJHSzhNRGlDZDR1b0YyOERndWpMSDBBSGFUZXJwdURoN29QLzNq?=
 =?utf-8?B?UG1JZ0I0Q1g3eXI5MHo3UmNBTnMwdUljaWwwcm1VUDdPb2FOZFFSdll3eVJ2?=
 =?utf-8?B?VXNRemV2dERCdjlPSVJ6bHJIUGdxQnVjUDFSYUxqSFF2MDA5ZEFpVWVMREhW?=
 =?utf-8?B?bUVqVk1PZ2hONmdQSDRaSXFyc1hJcHdNcWhHeVNkYmwxWmFheUttSFBwZTJK?=
 =?utf-8?B?NlZmRkl3dWpMdVpMNTJaZy9ycUJ4Q3RVUjc0ODFWblg4V00wUHVsRWx3MFNT?=
 =?utf-8?B?WDB1Qk1jVHZWTFlFYTRsT2Q1eDhxMWN2b2o3WU15WG52ZUx5c3U2ajE4YUda?=
 =?utf-8?B?ekdFbGVTcEcwRWliUGlkUW5sdDNUSHdGYU9lVXRhK1UzZ0lEd2JwNTkxc0cx?=
 =?utf-8?B?amkwNm1KcFRPV0p4RFlYaUlDdGp6QjhLQ0l4OGhlTklRYXc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzFNVHVNMDNaT0pObFJtNzlwWGpCRldnc25IUnhhYmNYSXVpaHMzK1RPUWZ4?=
 =?utf-8?B?cVFveDVGZ3FPaDQ1OThrRGN0dWo5MHorSnhOWWovYk0rc0dac3R0R2FMSUJT?=
 =?utf-8?B?emZrR2c2WVhjeFpFTEQ1bXhhcTcvWFBvNEZzdlUrT2lTcU5IL0gvWUt0TTE3?=
 =?utf-8?B?c08xeGlWbTVsWFMwdUNHRkdJVk1DT24yQlIvUEFMZld6NTZZUHcweWRTSi9S?=
 =?utf-8?B?VmloNGtKK0UzMXN4OGdndFhiSWdpMUNONS96cDI5eWYxVSs3UG40dXRHMEVk?=
 =?utf-8?B?K0ozY2kwTkcralpoQTIrclJ3TnF4ZUJUN3dKKzJUb05iT2RYT0w0OU8wdjVh?=
 =?utf-8?B?SjhXa3pXdUZHclFLcU1vdkErUjd6LzgwazZQTTY5N3kxNGszLzRZL3dGZ2VQ?=
 =?utf-8?B?UERVakVHTXRzYS9Wb1V2ZGlRSXU0SkNHVDhzL2FGeTR2YVA3dkZrY3kvc0Rz?=
 =?utf-8?B?YXRPWEJOMHJaQjNoR2dRZC9WbHRsWnk1MVJsbWZnZ25jd2IvUmV0NEhjMEpa?=
 =?utf-8?B?V2JGT3RVbFVvUElkVXZCcDIwcTVZelB6SHV4akJGaWRRc0N5QzdMQ2lKbmlY?=
 =?utf-8?B?L2N0ZXJ6STV4VURkbDZTeXlub3ErQ1BJRGR3d1JGb2tMbzdOTlJ1WXJseHJ0?=
 =?utf-8?B?ZG1mcWpqbjZKdkFJU2k5Uk0xNEdrdXllc21BSDc5ZDJFMWdCblgvTVVIdGxV?=
 =?utf-8?B?a1JaZUVFYjROVklIeVpyWk9GbnNzeGlKYmhhdG82U0NwNllHNlF5empzVmdx?=
 =?utf-8?B?V2MyWVYrVVJJUGhacDU0bTgwdWFoVWFYeWhFbUVzdm5mamYrOGtYaVJqUEdr?=
 =?utf-8?B?dUc3SlBYczg5ekh2OVc4TFhFV25OUlp2T3grK1l3YmtCMnhodGR3L2NyOHNQ?=
 =?utf-8?B?MEN6NGJ2a3NZZzlVdm5kbmEwVGhZNUVqVG9ISlMrd0pOMnVWR0IrQmpnOXZD?=
 =?utf-8?B?cGVHOGRHL1d5LzJ3TElIV0xFMEFkUEJqZDc2ZG9Oa1RyaFo5ZlhUQ1Q5Qmds?=
 =?utf-8?B?M25ibURSMGtIN083TnBYdjZlZnF3end2NHVZaCtuNFFwTmh2cFhlWW0zeGdC?=
 =?utf-8?B?Z0pTQzlGcXBHL25rV2xJMWpaaUlLZjJtWXB2cWhHemdCUDlTcWI0eUNMa2Zp?=
 =?utf-8?B?aitWUVdXaWZFTlYrc1h3OEJlSENBSkplSnRzeWl3dzlxN0tWR3ZPUFBYUHdn?=
 =?utf-8?B?T0laWGxYb2Nsb0oyV3YrY3FabTd6SEN4eW5kK3I0UHpOTlFWNitzMUlXV3Er?=
 =?utf-8?B?M0EraG1VaHowSnBuY3lFWlpFZFBlbHYzNkRBeVZUaWJHdGorQ1NiQThGZnNC?=
 =?utf-8?B?THhCcFg1Ukc4bjhpS1dBd2c0NXczcTBPQUdtV29HVnh2SHdZYzQ5aVc2L255?=
 =?utf-8?B?dE91VVEvdVdCaXdIdjZ2YjNKbGE4ZCtBNWZZU0xFWFpCMHRjcTFPRkZrUXpp?=
 =?utf-8?B?ZVNoQzhuaS9GajQ3VGlyWTJLOGJxTEc1Q1VLWE4rTXNha2ZQV3lCN2xZWDh4?=
 =?utf-8?B?RHJVcTZ3NXdLbjhtb0c4NlU0NERORUljZkdVOHVrTXFJRUFqdmsycWJnSzM5?=
 =?utf-8?B?T2FwVDdjMnU4NDhqeThKeDBVZEJkdmVvNW9hOW9JMjNoS3phVExUQVExOGM2?=
 =?utf-8?B?NEk4eCtlQmd0WS9oakJ5RndWRmdYU2tIR1c4TEdvN1dZaTJDUEU0d1llVnZw?=
 =?utf-8?B?VGovMG0yN08zMysvNlpNajVvZERWQU02TDdZSU5PWEJDY1BrMDUyeERnZVY2?=
 =?utf-8?B?Q3JTSEFKTmxYS2xFQm0yMmcvOGNLUkdORnI5TDhubUpwZEtjV0V6UGpPc1dN?=
 =?utf-8?B?N210NDJCVDJCUGdZaVhrWHZybmptVFQ5MCsvR0c0aXY0dHRlaWhFSHkwdWx3?=
 =?utf-8?B?bnVMTFA2QmUzUkMvU2tnc3BTSGZYVGJsbCtmNjdKM1RQTk1xaVNXVVhHMG1P?=
 =?utf-8?B?QnJzMUVzd3pvaktKbkdvdG1LNjJyUVhZeXkyejhhbGdkYytmdS80ZmFwZGl4?=
 =?utf-8?B?VlNHMmthWElwVVl2TVFyRlBHNnNJMHlXeWtIMVlLSEtneXo5ajg0YzVYS3Fm?=
 =?utf-8?B?d0R1SG1yN3BNVytHWjlVZ3R6OE1DbTdYMnJQZG13YkRnSXloakVneDljNEU0?=
 =?utf-8?Q?utGSaEZwcoTQ6GL2LPpfzjojM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8322d540-a96c-4fe8-ba86-08ddebccbbaf
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 16:04:31.2967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4+Akx8tuqlOKZueVgpaqZO1SkXwQh2CZlSXChOXuoNTu9wVu5hOx9n3Su1JWEFX3spc4Nq5utXPfdM+9cpxUVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5017
X-OriginatorOrg: intel.com

Rafael J. Wysocki wrote:
> On Tue, Sep 2, 2025 at 1:46 PM Colin Ian King <colin.i.king@gmail.com> wrote:
> >
> > There appears to be a cut-n-paste error with the incorrect field
> > ndr_desc->numa_node being reported for the target node. Fix this by
> > using ndr_desc->target_node instead.
> >
> > Fixes: f060db99374e ("ACPI: NFIT: Use fallback node id when numa info in NFIT table is incorrect")
> > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> > ---
> >  drivers/acpi/nfit/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> > index ae035b93da08..3eb56b77cb6d 100644
> > --- a/drivers/acpi/nfit/core.c
> > +++ b/drivers/acpi/nfit/core.c
> > @@ -2637,7 +2637,7 @@ static int acpi_nfit_register_region(struct acpi_nfit_desc *acpi_desc,
> >         if (ndr_desc->target_node == NUMA_NO_NODE) {
> >                 ndr_desc->target_node = phys_to_target_node(spa->address);
> >                 dev_info(acpi_desc->dev, "changing target node from %d to %d for nfit region [%pa-%pa]",
> > -                       NUMA_NO_NODE, ndr_desc->numa_node, &res.start, &res.end);
> > +                       NUMA_NO_NODE, ndr_desc->target_node, &res.start, &res.end);
> >         }
> >
> >         /*
> > --
> 
> Dan, Dave, are you guys going to take this one, or should I take care of it?

Apologies, I should have said I'm taking this one.  It is queued up.

Thanks for the ping,
Ira

