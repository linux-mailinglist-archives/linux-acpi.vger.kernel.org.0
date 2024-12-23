Return-Path: <linux-acpi+bounces-10283-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FBF9FB4C0
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Dec 2024 20:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB97216523C
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Dec 2024 19:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A581C3C1A;
	Mon, 23 Dec 2024 19:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QX4fpPy8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CDC1BBBE3;
	Mon, 23 Dec 2024 19:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734983064; cv=fail; b=lKUeyENt8Q9ztnPmlqdISkWUCaZJSik3BPjE3LkysnYOXPydRdJRzsF83/rdWxsQff0Wi9Uf6nYsSgnyiHY/5R6boeIAGuU9nkndn138wBdKBts4LEqJpjNL80e9S9U9Mk309c/solKSZWo2tgGFMt4wiY2UrkGHPyNdt3EWFDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734983064; c=relaxed/simple;
	bh=sY9P/9seGGSmtEirbAL7WrEnqRyPWal3pql7Y0wAR68=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SZG9W/E7wTYHWpAu72jPDj9WlrsgN5xvA/3ltFNXPYZ8na/2aazYotgxoy+UC5i3bvlmxkzZ660Of1OaJLFS5pT33Y39ms6PPMa05VYVKd9rW3o30w/AbjP2SC3P9/ooVGS2Sv/4IJUE9DAHOEL0JvdzBHYKha6JtJT0LSYAgsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QX4fpPy8; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734983063; x=1766519063;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sY9P/9seGGSmtEirbAL7WrEnqRyPWal3pql7Y0wAR68=;
  b=QX4fpPy8XcMQfdBjP0Ojv3eGM01SR3gDByQob+c2ZmD+Q7FLv7103VBX
   SdtG/GCxpcmLjnfRxCf2VYc/uYPB4va7waCERFL05RbNplfhsiKmhmlBI
   pnFyCtBCwT1v2qR5WhDms/iGFpOS9DRuULhRhWSGB4XG3IhtkdoKRZQiA
   zPzZzlhD4aAxMrAWc9duENaggxbd7971Iy0PT49YBOjP0T31xIR063w9J
   zqW4F9Tla6SAqDtkpac391gzWAL0irRB/JWdF7Jc4B0ajVbigRrErQM3g
   DGNAxmzyDoR5TG/ERKcfqiGGUZcFRY/lw5bT9ablcddnMtD0OfO+wA0VL
   g==;
X-CSE-ConnectionGUID: hTjKStdrTXmooL0nT1/vfA==
X-CSE-MsgGUID: fcCkr52uTuuecWj0znWHSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11295"; a="52856443"
X-IronPort-AV: E=Sophos;i="6.12,258,1728975600"; 
   d="scan'208";a="52856443"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2024 11:44:22 -0800
X-CSE-ConnectionGUID: zaJOS8ybRuWIxYPe5dYUhA==
X-CSE-MsgGUID: +CufYOkfSAqziuqKwkVh3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="99757591"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Dec 2024 11:44:22 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 23 Dec 2024 11:44:21 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 23 Dec 2024 11:44:21 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 23 Dec 2024 11:44:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XyQQiE4rFkMi3DkmJZSNc9ZFlOGY2l61ADnrgRVE3hFScLTQrSpebTCYA7Szkjwy0Qk1LApY8eFuSEi0lMiqXZMS/QNdyniJ8RsueK03gym9xhx+7UvbwBqznt6FK1pA/0Vg4a8YjjSGuGX5b9p56ux+11Q39UY8j8ag+iypXNyfYYh2fymBDiFroREif6x8onkvUrx07qYJ+RhQMr0jTiZ/cQ0wwPnVZC2sIpkFSyzBbZP1H78O0N4Vn7vn/PDElJLD2XsLaLSjgGbBhU1FwEEikM2nvYVwjjfnn2hXgf93CgQX1ScODr62sBlnKGXCJMd+v1WjcvfBT3VzugyKQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+SRIxzKkmh7ScXVX4FxNgkSlj/JNuJm+I5ZWJ1XFRMI=;
 b=WSlTAPs8iVkvpLLlVvnYry8FkWjLdAv7ZVwQHYp/w+y32xkQzGJgmhJZv6XWIFBDA+mkJrOtPPgtKSi/Xnnoy6rxnmTFSxiWo9mHfnMMl+JpezgG7SBbrbzCMDYIfoYkCCpPdjOBW7RoyS6gnc0tPUl8c9AwDhm3Dhxhxgn3DLOvfWh7pZh0k+/MaUYwR95d6aeevKJJiWN9anOo+mRcuN54Tbh7RA3tz7+vjWoC1VrX3xPe1eqE4LyQllKt7OLGG+4ZejAkcyumseeDqwK2boab2LInLI8QycE1nAs5tBECkTz83jBV8YW9D+EeSoGy1lFw2Wn9M2gxufbFLLIkYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3322.namprd11.prod.outlook.com (2603:10b6:5:55::19) by
 SJ0PR11MB5053.namprd11.prod.outlook.com (2603:10b6:a03:2af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.21; Mon, 23 Dec
 2024 19:43:48 +0000
Received: from DM6PR11MB3322.namprd11.prod.outlook.com
 ([fe80::fca4:6188:1cda:9c1e]) by DM6PR11MB3322.namprd11.prod.outlook.com
 ([fe80::fca4:6188:1cda:9c1e%5]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 19:43:48 +0000
Message-ID: <e2d01538-f2b7-4f0d-8688-124531530c59@intel.com>
Date: Mon, 23 Dec 2024 11:43:44 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/15] Prepare for new Intel family models
To: Andrew Cooper <andrew.cooper3@citrix.com>
CC: <acme@kernel.org>, <adrian.hunter@intel.com>,
	<alexander.shishkin@linux.intel.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <fenghua.yu@intel.com>, <hpa@zytor.com>,
	<irogers@google.com>, <jdelvare@suse.com>, <jolsa@kernel.org>,
	<kan.liang@linux.intel.com>, <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux@roeck-us.net>, <luto@kernel.org>, <mark.rutland@arm.com>,
	<mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
	<rafael@kernel.org>, <rui.zhang@intel.com>, <tglx@linutronix.de>,
	<tony.luck@intel.com>, <viresh.kumar@linaro.org>, <x86@kernel.org>
References: <20241220213711.1892696-1-sohil.mehta@intel.com>
 <f97c1228-7fca-4487-814c-6dd6ba581721@citrix.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <f97c1228-7fca-4487-814c-6dd6ba581721@citrix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0149.namprd03.prod.outlook.com
 (2603:10b6:303:8c::34) To DM6PR11MB3322.namprd11.prod.outlook.com
 (2603:10b6:5:55::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3322:EE_|SJ0PR11MB5053:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f23d8d0-bf88-45ac-0160-08dd238a1e71
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Mi9lNUlIZ3dBQXhLU2hod3A5aDZvNUVpYjkybHZLNlJ5TDhQaHowNUxEd2dr?=
 =?utf-8?B?bFM4eEJYdzBaTnVhYzRDRlFIbGNzcURIY2E0b0N5amM1MWVsWVNjMHF1Nm9Z?=
 =?utf-8?B?a0NGN25rUDNZVVZzN2c4dGt2aHFKZXRBay8zbG9lTEdWbkdVOWRIUXp5VEtR?=
 =?utf-8?B?RW1UM0tGQ0xWcHorSUYvcHNVdktLdkc5SjNJMFZHSjdsSU10bm50ZVZXY2Zs?=
 =?utf-8?B?TWN3dWczR0cwODlGaDRLMGxyUnRldGtvOTg5OHZWM2NqN2JEazZUSVMvT1d1?=
 =?utf-8?B?UnNkV045azFSc2FobTFaYTE5c3pRNDFST3VHV0REbnRjU0tNbDVyOE5iT1ho?=
 =?utf-8?B?aGN4VFRKdkpRalhsRGVRQ0d0eUlac243c2hqeFU5d0xWbTg2L2RrcE1ZZ2t1?=
 =?utf-8?B?bWJ6NHhZenpZSjF2ZStuODUrcG81UTBhNG90ajIzalhoejFYdlQvVDhEaFdV?=
 =?utf-8?B?YlB6c2c0TWUrZURFb3R3SkpVNjNCaGNGQjRlUlc2OUROVkE0d0VhSURvTE1O?=
 =?utf-8?B?anB2L20zRzN0KzVibDk1RjVPKzl3ZU1ldStBZzNaRDZHZ3Z3OW8wNktQYmg4?=
 =?utf-8?B?OUZ6eWhzQlJRKzZEb1hWYWhsRFZzVm5DVjhlQmtFb1lKWThiSkRiakFTRExC?=
 =?utf-8?B?WTFPWU5BU3RWOE0xbHBOQmdWdDRvbmF0NjRTZ2hCOWhCV1VHak5pTzRoRGNW?=
 =?utf-8?B?cWpobGpIdXVoWEdDaFVXSzMzOVU5cmFUdDRpRHJwRGptVUhncVVNL3BtSVp6?=
 =?utf-8?B?UDgzQ1MveW82elJEYVJ4bWdSbE8zNEhXZzZnaXFWaWFMcFkyYkV0V1I3RFg2?=
 =?utf-8?B?RW9rVmxzaGZ3N204eWQwOFZBUUIrZk1MckQvS1U2UEpKS2IxaEZUS1gvZHVi?=
 =?utf-8?B?c3FjVnZZbHgxdU9ZTnJCUWhnalBzWnNJVFMreFdsYmZXVi9KZlBVMXpINXZU?=
 =?utf-8?B?alczU1Z6YW90aUUxK0pGVnFaSENtMGNYa2xId2c5enpJblkzMFE0M1FDbk16?=
 =?utf-8?B?SXpIblIwYmlCRmdlWFh6d0FsSjV1UU42SkJUTjc4UnBrblVRR2JwQ01MMExt?=
 =?utf-8?B?Y0FXNlJ4bWxaVFpXSzBlUFJNWlZucm41TU1GZEN2bi82WDAxS2FSNTJlRkp6?=
 =?utf-8?B?eU5JaEZzOUFwL2kwcW5NYXhYYTVzdTZJTDFidnIzbWNMNFNnZVNEWDErdHYz?=
 =?utf-8?B?K3puNEpzRjlseFVxZkd3ejk4TFREZHhNL3JqOTI3MGNES3RJMmNTaDZnSFFv?=
 =?utf-8?B?a054WTVlRG42NGJMSFUvZGFJQm9uQThhdmh4a0gvMTk4emhGd214d3FZN2lq?=
 =?utf-8?B?SkwrZ0JCT1hDMUpVSmxvN0FWT0MvbFp2UUVqMVRNa3IveUxBSC9Vd05BYk9j?=
 =?utf-8?B?M0RqZGkrc2ZmbFFZQzVIK2M3YmZnT3IxSVdmaElHZXl4M2lXZElibTViUXEx?=
 =?utf-8?B?MGJLU2pqN1VaNHZvcUFqeGgyNThuYUdLTUxQcXd3NkI5bEZPZlQxeWtZR0o0?=
 =?utf-8?B?bHdGNmtDRGpmWnEwd0tIN0hyWFgwdXdEdnZ5ZkZiRDRpT3I1QXlLRWsrOUh2?=
 =?utf-8?B?YlZycTFHTndNMVZGZnJ2azdVK2JLcGJQYStVMlYwYmQrMU9wQm5mYUY2L0xJ?=
 =?utf-8?B?NHk0VjN4R015MEdnOEI2c2JJaytmTUZmN2JROFU4eWVNSk5BVko1MHI3OHh5?=
 =?utf-8?B?bXFrbTlpOWxKc0hXRXJXaFRYOWpwYjNhWmJZbVhmaFc4RTFzeUZBS0l1L1Av?=
 =?utf-8?B?WGVMRmlzbnJhM0J5UDJkdWphZE1QZWtOOGFIeTVBbld0OEcydjZvcHVqWnY2?=
 =?utf-8?B?MlVPOG1INm1nVGNsUDgrU2hYSENydHlwZmVIUTZLbG1hUWFrN2hFa2tLSlI4?=
 =?utf-8?Q?zsVYxMeADL4M9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3322.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aE1DRXAxNGxCZXVFbGpuUlRqQXJra2F1TFJqYVhUSElPN2Y3YzJHcUF1ZUxJ?=
 =?utf-8?B?OGFJUnhXaWhPRnNZcUtRL0JnS0VCdVBpUzFOSjZ1RGUza3J2dnpWcTRRZ21U?=
 =?utf-8?B?anRMMlA5aTNmaWo5RUZ0cVFsZGFIR1VyY2dpN3lHUVhkNHVUbHBlcC94Y09R?=
 =?utf-8?B?blUxMEFuUHdXMDRZenUxVzJRcEZxWFB3V1NMbldSWjlCZ01WMXZWSC9sWlJU?=
 =?utf-8?B?SWF3ZFJGTFlmN2VYcXd4ZkUwZzhzUGs5cU5VZEliNnlwRzliUUJVc2Q1ZnE0?=
 =?utf-8?B?aEo0Ny9HYkdvT1FtZVg4blVXQWFpQ040OHV4Q1lrZTVUQlNhSEJZN1JxZUhR?=
 =?utf-8?B?YXFmV0VtZkxRcStacXVva3gzamU5VXpCL0pMZjM0bEliejd2Z1hMc0dOamwr?=
 =?utf-8?B?WWxhR0xrRDhpckx0T2JFMWQ1QUp1enFMTTBGbHlwbndGdVJjQktHZlJXUEV0?=
 =?utf-8?B?T0VuWDYydEVEUG9iSVBJVGFxNzJnQkxnK1NuK2k4THpyQ3drTHZZSkRpczQy?=
 =?utf-8?B?ZEFoL3FBaVUraEhGb0J0VFJYT294YmplVkV4ekpvTFpBL0dDN1B4WE4wakYz?=
 =?utf-8?B?dnlBZUU3eUFva3NCSVQ0d1ZYbUZUWnFDcFkrM1lKSmNnZHVXa3Z1Wi9KaGd1?=
 =?utf-8?B?NFFsNDRsT0lhL0dkdUdkRWpBOXo1VnJtejFSVVJRdUMwcm1CbVVzOTZOcFVv?=
 =?utf-8?B?bEJMSkg0SkV2REYra1FPelU0TmhxejdpblNXTzBVaFZscmxPa1FSOFZoZFcr?=
 =?utf-8?B?WmRMWDRPb0xIOGtkcE5GMzk0bm5yKzY4N2g0N0hnbmNxbXhCY0VWY0NES1Rs?=
 =?utf-8?B?Sms4b2dabVpXSUg2ZnlMWUh5ZmszUHRpa3N1LzdOb2RpUEtKSXV4cUJxNXVm?=
 =?utf-8?B?ZXdJRTk3TkVXUHVpVTRjeVE1Nmk4MmNGY1M1STVTQ2tMZk5NcnEvRktYODc3?=
 =?utf-8?B?YzdXZWVhVXdpR3pIZVFCZUZQNnk3V1FCKzFONnBHYnFKbCtteklKU0Rxb0c4?=
 =?utf-8?B?Q0ZEWDJqY3NnUjJEYWVRbEMzSmtCQW8xazNXNUFBTGdEQmFiblhMbWhPVUZS?=
 =?utf-8?B?Mkljd1BYV3A4Y3liLzhtOXpNcXdxS0s5dk9NUkNLY2dpRXVTMFNQcHlCd3hq?=
 =?utf-8?B?bm1JWGJTbDBPNzlJZStTNWlVVjVrNTlOUWo2SlZtTXpFNlFQcUR4eEphYnh0?=
 =?utf-8?B?UlBwTmtKbXJ3dGd2UTFpdGtJQnFveTgzRFJpR1V6Wnk4cjhEcDFwVEluWkkw?=
 =?utf-8?B?R3RhbDE1Tzd4ZCt6bGlIaGQ2UDVYR2haZUZMcUpaeHA5dW5aWStldmlRYnc5?=
 =?utf-8?B?Smp6YjFzZURGMERHWUtrejNqQ0RKVm81aXdTYUY2TC8rQ1hBaHp3Q3ZzVmhn?=
 =?utf-8?B?WGVaMGl5eHRxZFpXUkl4Q0lnSWVUeGJCRXRua2FZb1Q3SWRFSmtMN3RwaEpY?=
 =?utf-8?B?WEpxUk1oMUsvQjNuUmtlUCtaLzRWUERvaGFkYnZFdG9FYVlwVk1CaVc5NHNQ?=
 =?utf-8?B?RzkwUndGK3FMN0NKVnR6YnRTeFIxajVmVDYxbURhRHhxY2N3Q3BYbGJxaEV2?=
 =?utf-8?B?eDg1T0RGa2dVYTdLaitqTUhFYXd4N2I4M3d3RWxXb0VwK1FrSnUrMkRDL2VG?=
 =?utf-8?B?SUFBUW5IZWkwYy81RU95QTNEdjRjUlhFc01UOTJaVzlxb25abFFERWtOdkZI?=
 =?utf-8?B?dEFtSGdxTS9JUHdRNmJZdjBPTTNNVnd3RkhtOThNVzBoNEhUTUxJakNhQ1h3?=
 =?utf-8?B?RHQwbG9nR09ML1pZVExWOXNvVHlVb2VUaUFmeHVjTG9jemxDdldZMkRpTU1s?=
 =?utf-8?B?SnVFWlV4ZXo1N0Y3enBVWHVaYkM1bEQ1cVBHa3Z2TzAvbldlbm5XSllVYW1S?=
 =?utf-8?B?cnhRckY5QS9aTys0NHpoTjZOVDJtdDlMSmpxcTI0Nkw2RG1FZCtmOVhmYlhE?=
 =?utf-8?B?YWlHOWY2dXkzZW1pdzlHL1pYV1RQcFpJMUhydjJoYWxuSTQ1cWFQTEpDSWJC?=
 =?utf-8?B?clAvZ1RmeVp6dWhOcldJZnNLMEo3VjJ3WjkrNTY1ZDFBV09mUkZ1N0pyblRJ?=
 =?utf-8?B?WDN3aUp4bU0vcVNSYzAyTVZxZTlWVXRMZktNM2UwcDkrQ3FqMGlNNUQ3bm8z?=
 =?utf-8?Q?dK4Zx0cTvtdKs2VgxU6JGkaPh?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f23d8d0-bf88-45ac-0160-08dd238a1e71
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3322.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2024 19:43:48.1978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gfcPmZTmu0hofh6H+6Obm+l+RXZJN5ZzQGjdiuZIZL//cHXA5rhCKdMP3ELU0JrQqEqGWxWWTjC6AfRqVeb/jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5053
X-OriginatorOrg: intel.com

On 12/20/2024 4:29 PM, Andrew Cooper wrote:
>>
>>   A dump of the microcode file 06-03-02 shows:
>>     001/001: sig 0x00001632, pf_mask 0x00, 1998-06-10, rev 0x0002, size 2048
>>   An archived CPUID dump [3] also says:
>>     CPUID 00000001: 00001632-00000000-00000000-0183FBFF
>>
>>   That would translate to a family number of 22 (0x16). This aberration is 
>>   not explicitly handled anywhere in the kernel so the platform might already 
>>   be broken. This series might make it worse for the platform if the latest 
>>   kernel works on it by chance.
> 
> Are you sure?  Bits 13:12 are the type field, and the 0x1 you've got is
> for an OverDrive processor.
> 

You are right. This is indeed the processor type field. I should have
spent more time reading the specification than Wikipedia :)


> x86_family() will consider this to be family 6 as far as I can see.
> 

On the bright side, we don't have to worry about breaking this CPU.

Sohil

