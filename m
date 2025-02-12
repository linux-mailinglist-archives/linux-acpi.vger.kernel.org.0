Return-Path: <linux-acpi+bounces-11076-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA11A31AAC
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 01:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0368F1679D8
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 00:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1089444;
	Wed, 12 Feb 2025 00:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T8PHESTm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5B6A50;
	Wed, 12 Feb 2025 00:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739321154; cv=fail; b=OzF4mC23CwoFLGyHSSbqKfCBsvJqAYzOoNYllHQrEmtmGSfDQzwP0upNW5cxItuqTngrpAckqKTlHR6mQfE3bBjSX11xMOqg59odo0k3REY+qyM3X/PizE2VrTCfP1EBD3t4V9l6vWTpMceOSd5Lpg3e1gi7vQ2t0kL2mDwSFiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739321154; c=relaxed/simple;
	bh=vDu77wPldpxFlwYNHiqO9P/B/j9kNQcrkI2fG1RqjBc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a8TIKu+7CT2XCCmoqQKBKfpspDEmvvuxy+FEfgXvtGtrMX32tq1msMCbSmNnMy+TqHQ3KHfeZyQV/j0NXCpy/quLCpX5efRWcWBJoegl9VSpmiLFG3+l9hHpIiKjGg88Zoy6TpA/RRvQC+Mld7Rb7jlzNaP303o2h4MdkecS2NE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T8PHESTm; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739321153; x=1770857153;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vDu77wPldpxFlwYNHiqO9P/B/j9kNQcrkI2fG1RqjBc=;
  b=T8PHESTmVFUjnsBFiCMp+/DY36wFnqKTi67ZWXp5yMd2zh09smu03v9I
   zNOI5k39otDpcjl8MkV3BRzkUzu7m6muCD1pw4FBW703ITVH7k6rSiv19
   v3Pvl5pJZ0s+l//NzOiKDhg5xacmCpen7+RIUpxa9SvQhViS0VmP3Vn3U
   IaeF5niYkG8w8mFzTl4vM/fxZHIl7ifEWJRAnLjSj9JMDkjjw2+x5viNT
   +qkNASLlYAnUmxyUQE0ONu5psodGxmuacwoeok243xu3Q6McRpDozPNSU
   ioXD/kwLJx3Pc5BYRp9WDvSwcXCJZGtKo7DcvYOzq2ICYnpczdo4j/2Hi
   g==;
X-CSE-ConnectionGUID: EteQAoAJRcSskdRwgR+QsA==
X-CSE-MsgGUID: NpGh5ZJSS5OKSWToAZl+Tg==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="50602643"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="50602643"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 16:45:51 -0800
X-CSE-ConnectionGUID: tLzPZjxhR+2/CepZAd28Vg==
X-CSE-MsgGUID: u11FsgFZTTGjy1nzPdEUlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="149849805"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Feb 2025 16:45:51 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 11 Feb 2025 16:45:50 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 11 Feb 2025 16:45:50 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Feb 2025 16:45:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UYZWrdz01yVC+3c6Nf7pczvBsCHwtiTDOwdYre+k37ShPA544sR1h9SCyj5dLHjOJQ1CHpYyyBzb3i9pZJ0KAHtqkouN4CjUevxvgWAdnBxnm8g79t5az1owdD57VevjhpADuh/BlXtSMRuU82PoupfPHqNCcJb2hrJ5lIlJeH8nuux7BkzJgzNQi35i4ZQsOVdxB2AJBGJj93VJW6zQSEbpGoNtFsA7rEGYf2j3+tVDQ0iPgOwvfm3/pHvHZDUI//T/1UrJOoLyzTtMFPcdXkdwiaEgmD1zBDnAxd8AS/GdlJ2W5VXw/AkF5fYYWHdMyCL4ViLIqWE7f0nezHE99Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RlAFj+SoyMChcA5jV069Vwx24RUFzE5s2zb2uZb3V3c=;
 b=eH/eZuMNMZBWMYXAl6VpHeHjf6dJGDV+7DqOmW0FFmrEc4e09T0UKgwP4psdUcF78Jbb+4fH1Fzg58AChIYuDZPCbtwqeg8V8aKLDFXu62Uy1LEo+p4Nciwpce5MpgTe8tSFPDqNv6PpZh93BOcJuhPQtqQWaQjCime4UclhyY3vU+uUCetRFH7fTV6WmdBkBSGQtYrbJedfvcHE4NYa1VfVKeF4Rys+WmCgTQ41CD+TFck+PBQO3Zpa7I4giRPrGKmYaLWLxSZQtaINynwi2A4wCdDyxsFruosppN2rDufEyV9dd64zUB3K/IbNHgRGSZJsZtESz7gPAuAheYAr0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by PH7PR11MB6907.namprd11.prod.outlook.com (2603:10b6:510:203::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Wed, 12 Feb
 2025 00:45:48 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%6]) with mapi id 15.20.8422.010; Wed, 12 Feb 2025
 00:45:48 +0000
Message-ID: <49278389-9340-406f-ac82-204538b047f1@intel.com>
Date: Tue, 11 Feb 2025 16:45:46 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/17] x86/cpu/intel: Bound the non-architectural
 constant_tsc model checks
To: Dave Hansen <dave.hansen@intel.com>, <x86@kernel.org>, Dave Hansen
	<dave.hansen@linux.intel.com>, Tony Luck <tony.luck@intel.com>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	"Kan Liang" <kan.liang@linux.intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin"
	<hpa@zytor.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown
	<lenb@kernel.org>, Andy Lutomirski <luto@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, Fenghua Yu <fenghua.yu@intel.com>, Jean Delvare
	<jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Zhang Rui
	<rui.zhang@intel.com>, Andrew Cooper <andrew.cooper3@citrix.com>, David
 Laight <david.laight.linux@gmail.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-hwmon@vger.kernel.org>
References: <20250211194407.2577252-1-sohil.mehta@intel.com>
 <20250211194407.2577252-16-sohil.mehta@intel.com>
 <aa6782af-91e8-4f35-b478-709a8a5b7d29@intel.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <aa6782af-91e8-4f35-b478-709a8a5b7d29@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0003.namprd21.prod.outlook.com
 (2603:10b6:a03:114::13) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|PH7PR11MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: 4998d2cf-895d-47d2-cef0-08dd4afe974c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SExLTTJydmtjbjBJWm5TdTB6MFJ0aTNtZmhpeDFNR2o4RDVmdzRyZjk1aUQ1?=
 =?utf-8?B?T2l4RmZqNldXZmxLR2s0bEFhM0NDbTEwZFpVWVhCWHFxdENHaS9MdHJIQkFU?=
 =?utf-8?B?SUNQa2Mzci9KU2pKV05jWlZ2ZHRCR3h2c1ExTzRnSkJuSXJ6c3ZxdUFNOUpx?=
 =?utf-8?B?ckJHWW45dkhROThRNXFyczlFNzBwUUhkZ0VqUEZ1eG43WEp0bHcxVElmMTla?=
 =?utf-8?B?N1M5aFh6UmxNenlXODVhQ1RSdHUwL25iaFBEdEZOMFR4K2JiM2U2UTZNbVIr?=
 =?utf-8?B?NzExVzF3RW13MS8yUGlMOUg5cjhvVUc1U0w3cXhBeHRNLzlwYTNMVjZpTGpC?=
 =?utf-8?B?akpUVHhlT0NzZ0g3elg0NldvZjNDTjE2dUY2RmFLS3NKS3htRW5Ba1pyeDZu?=
 =?utf-8?B?V04zMVFuVkVHVHEyZzRUYlErNTkwV3VTSXI2N3Y5QVdMUWVvRVJZTHV2bERC?=
 =?utf-8?B?M0R6L1dsS1lHTXBVSnVMbzQvZGNuUFBQUVJkbFJPeVVXVno3UHpjOGZWMlZC?=
 =?utf-8?B?aU5PSXFjOXpkVGZtOWUzc3RzRDgrci9yK3l3emZUQVp5RmtBNHpROW5JUmtv?=
 =?utf-8?B?cUgybUFvamVxckJ4TUNVYWZVbmNtODJJSW1oVGY3SnhhbTJPdUZKRnZsTy9y?=
 =?utf-8?B?VUpvdkxnUjJNQ1U2YUwrR1pYanpvNFpHVHA5L1Rjenhndndzazh2MndrQ1F4?=
 =?utf-8?B?dkp2b25LRWRobHh4TERwT3hiZUtSeWo4SXV2T2hseE1xWGYydE5wRUtPL0h0?=
 =?utf-8?B?RHRPNXlONDZzWmZhTjJ3U1dxMTNPUUluRXJ4L3FaeU85RHpHYWQ0ZHFJRFE3?=
 =?utf-8?B?UU05aFJybWVPWlVDa01KZEVqa01LMUxNcjlnZzMwcm5EeGxsbE8zN0gxbk1q?=
 =?utf-8?B?UEI2cU1MZUJxbE5TbTRJM1MxTFRnNlVjNFJkVDJHVjhER1BvUDRLcDlzdmNU?=
 =?utf-8?B?Q3FITlJ3V2JuSzZhdnpVeE5HaE84MnhldHpLekd2WE0zcnBNcnlxWnBWV0Zw?=
 =?utf-8?B?aWJQaWs3RXQrSFBlS2dUbDlCYzY2bkYralhvZ0I1NUE0NXFPM3FXaWFFcXRJ?=
 =?utf-8?B?Vk5mU1VZMlBCaGZoM2EwT1ZYOE54SmpwbVhvQVNNUmJVb0xZY1RPdUJzNFQ3?=
 =?utf-8?B?RWRpNXl2R3oxdnRHckZUdzd6MVNGZUhhem00Z3BqSE1INDRGeXUxTmc3dUJ3?=
 =?utf-8?B?YzllanJOdXNiMTZZdFp1K2k2eWYrY2xUQXJKZ1UwNzJjVFJsa3JnSXZ1T2dy?=
 =?utf-8?B?WnlpYUJsZnJld084ekY2L3RRKzNZbGRrc2tPdUU3Y2FJRTlpZm40VlZ1N0Ux?=
 =?utf-8?B?YUQxTWZ2KzRheFdxdTR5bGo5ZVJ4SWhCbWEvMTZ0WkNaZm9Ud25MMlF3UHQ0?=
 =?utf-8?B?TzNHenYyN1duNjhKOUg4cXFod3UwVUtyWVVIM3BuK25BbE5zS2lzU3hUYk1S?=
 =?utf-8?B?WVJBNVN1T0s0cUdYLzZRazQrYldtYXBmTHN6bnh2ZmlxcXBYQkl6UTNLZHRE?=
 =?utf-8?B?L29VN0RtVzljOS9lQm5zYlU5OElxNlNlbVlYSlRMOVM3bXI1NTFNYkZidmxB?=
 =?utf-8?B?YnRUVDRiTi90elV5VndrcWlydmZMUGRPQ2RDZGlRVEt4TXNFVkZqbVVtekhx?=
 =?utf-8?B?aFVreERDQU1FbzEzVGFoV1p6L1FEbmo3bUFZbFhnM0FySlFFS2tFTE9aVDlV?=
 =?utf-8?B?cjV4RXFzRTNXVlNXWUdDNzBrajRVVnFRSEdXeHNkNzJzRDArQzZJc2V1dW9N?=
 =?utf-8?B?azNSNG9uYVlBanlJUzA1Z1RRbGNGMnBGOXlYdmN6T1JNaTYwMTJxTWVKSFZp?=
 =?utf-8?B?Z053QlNZaFdSN09HNXZzczQraU95Y2kxL1NUT21HekZkbXpJYWV4NnIrTkJ6?=
 =?utf-8?Q?fKa6nrVQmSsX8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGs1QWZXTEZJU3RkK2ROQThEek9LOTByNFVvWUtmTUszcG9Rb0k3VER4cmRt?=
 =?utf-8?B?bEJ3Nk96QXF6cFRueitENW1oYjh3WGVtUjRtcko2Yjh2RHFRUTRpVFpQcFZy?=
 =?utf-8?B?aDlscWpCYzYwckJ3bkVpREVuYzhnaG9RaDBDN01xb0dTaXZmVTFlTDZnQ0NC?=
 =?utf-8?B?Q0g0UTl2NGJJcVhSUExBUEJQaEhmU21BenFNb1NrVEkvdGhDd1A1T3R0amtW?=
 =?utf-8?B?em5nSmdBMGhBRmZmVnhRa1lmSjRFMCtDRmM4bzZPOFVORjBuUVMyU0pqQWpO?=
 =?utf-8?B?c2RMV0p3NTc1Qkp6QzB0UmNmYy91V01JeDRrdExtb1IvbVJFQTRtbkhJVjJR?=
 =?utf-8?B?NkRmaDRQT3hxc1dhZjYwckFaZUVUYmNYOUxSekg1NlNxSWVNaVFocjFORVRa?=
 =?utf-8?B?SVY1bkR2K3hkNXVyMG5mZm00T1BqRTJrU2MzOGdCNFZKYk5mSThZcjhvQXVq?=
 =?utf-8?B?TlBWV09DMThseW9pL0YvYkpKQzZQS0RReXJuM3p3Njl1WlRLL3BNMFd6T1lF?=
 =?utf-8?B?UGpCQml0akRDNVV3S3FpbU1vb0hCL2tKTEExTVpUcVRINWJUL2tpa1hxdzlV?=
 =?utf-8?B?ODliWEtVeDhUMjNCV0ZrNXBaenJWdWJlekY5cTNiVERnOXgxaGhreGVnSGRK?=
 =?utf-8?B?b0lhV25tQmMxNTdPd0NTWVkxZzMyZEZkMHZCN0xDSG01cXU4ZFQreGlQRzBs?=
 =?utf-8?B?bXNaZVh1MGJBWkNmNVFja1FKTzk4YnVLK2JabkJ0Wis2TnBBdFI1TnA0WDVr?=
 =?utf-8?B?aEJGQmhDYk8xNHZ1TnF1RnovMFcrT1B3c2xjVmZsNEVXZEtySFBvckxCWFVE?=
 =?utf-8?B?dkhtb2dySkNIdnZjd2YvV2ljU1FURkM5Sm9RbHlNQ3F6aFFBUVg0ek1QRkwv?=
 =?utf-8?B?YVNLNTEwdkZRV3RibzlvYnNDeklqTHZjK2Y1SzE3eDVvcXlidWZwV2tScXZi?=
 =?utf-8?B?TmxIOURtZDdmR2JUQUNkQ1FxNDdDWUQyYm5sQTZxSThOMUJIcTNEM2ZGZm9E?=
 =?utf-8?B?d2JFclN1eUJsOHA5YmlzS0ZCWFRsS3p1bHZ2cXJtcHhjZlg4dGVKdzFQWHgy?=
 =?utf-8?B?Sld1QVlSNC80ZEIraTdxWm1JQ1lRSWpMek1VWDFHYm1tYzhTbmZrZjZtaE5B?=
 =?utf-8?B?VCtPMjVyd3ZxWUdHTlJLLzE0WHpKRFVqMnpDWGhxZFhyOExyNGF1aUdWcGNF?=
 =?utf-8?B?amVyRTZHMUt3ZW9PSW9xdlJhMXVnYkdDSHdUZVFjdUZtRnczbkxlU2Vsdkov?=
 =?utf-8?B?a0x5dER2dFZIZnRuYmVWSnpyZ2R6Tkk4d3hjdHpkeWxvVFQ5WnhuUGhqeUtL?=
 =?utf-8?B?VSthcmZpYUhzdHYzRDlQZHlkYWt5VjhGYnlTTWlDWnU4RFJIenlHWHltUHU0?=
 =?utf-8?B?eEZlak9iL0JTYlluNGRURzNITm9JcmtmTlF5N2l4VzVSVDJzS2ZZM2tRUjEz?=
 =?utf-8?B?bWo1eGxkWGhUZ0R6NWpMbG1SdHpyNURhbEl3SFo5VjVKM3BKOEgvekNiNHFW?=
 =?utf-8?B?c1FQeGUxNElxZGtJTnVQZmZqNlphL1pUUFVlTzRUWWFPQ1l1UFM3L2tTRVNr?=
 =?utf-8?B?ektiVUVNUm9qRUYrdy84V2o3M2RBSllnRWxFOUsyQ2RtVGE3M29aUnJhZmpL?=
 =?utf-8?B?MDNQL083RGtVT1dmZG40ZU9YaGNYeXJBNTNFcGVKTDV5V0JNMnZXSUJ0cG1C?=
 =?utf-8?B?NXdsMFRhTnk4VTVpOFpyRHIxekYveW1mWHRqTXpPOERQb1pjS1kwRGpQMTZX?=
 =?utf-8?B?UzFsdjNGY0liYkxpSWVTUWt6TmRZczZkR2RKUnpwbU92V3EvSTd3SFpjbFkx?=
 =?utf-8?B?MklRWmpSSGVtdWtYbEpLUHBVTDZLSkEzYUx4bmFkdDJ0NC9Ea09FOVoveER3?=
 =?utf-8?B?U3VNMzZEMVpTR3NQd2RYTVFtQXVFalFhcjVXUVgvTk9FQVNMVGVVdk9nQW9M?=
 =?utf-8?B?S0lwOGt4bGtmVURRaWRFVXh4VmdKL0ZzNXJPalpiOGlHbjhaY2c2eW9XcGdH?=
 =?utf-8?B?VkFoK0lRNmVqTmxvSDdMOWtGdnBOOTU5MFJGbDRydnlWMHJ3M0NXUCs0TVg1?=
 =?utf-8?B?aUlDWTdFYmpNZEptQTZOVWNWak5NRjNxMUFSbHFIQU1IUTYzWjUwTUpYNTNl?=
 =?utf-8?Q?Sspo9fAgo8MryjJ1YgjWlZhye?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4998d2cf-895d-47d2-cef0-08dd4afe974c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 00:45:47.9718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ymtMnjVuogk5C2AwAKah2fGwgdDI94UoLokic5A7qr1knIS5V2Yj+gUX0kKThSvbCkR2bJkQp+aO9ktelqep+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6907
X-OriginatorOrg: intel.com

On 2/11/2025 1:41 PM, Dave Hansen wrote:
> On 2/11/25 11:44, Sohil Mehta wrote:
>> Constant TSC has been architectural on Intel CPUs for a while. Supported
>> CPUs use the architectural Invariant TSC bit in CPUID.80000007. A
>> Family-model check is not required for these CPUs.
>>
>> Prevent unnecessary confusion but restricting the model specific checks
>> to CPUs that need it and moving it closer to the architectural check.
>>
>> Invariant TSC was likely introduced around the Nehalam timeframe on the
>> Xeon side and Saltwell timeframe on the Atom side.  Due to interspersed
>> model numbers extend the non-architectural capability setting until
>> Ivybridge to be safe.
> 
> How about:
> 
> X86_FEATURE_CONSTANT_TSC is a Linux-defined, synthesized feature flag.
> It is used across several vendors. Intel CPUs will set the feature when
> the architectural CPUID.80000007.EDX[1] bit is set. There are also some
> Intel CPUs that have the X86_FEATURE_CONSTANT_TSC behavior but don't
> enumerate it with the architectural bit.  Those currently have a model
> range check.
> 
> Today, virtually all of the CPUs that have the CPUID bit *also* match
> the "model >= 0x0e" check. This is confusing. Instead of an open-ended
> check, pick some models (INTEL_IVYBRIDGE and P4_WILLAMETTE) as the end
> of goofy CPUs that should enumerate the bit but don't.  These models are
> relatively arbitrary but conservative pick for this.
> 
> This makes it obvious that later CPUs (like family 18+) no longer need
> to synthesize X86_FEATURE_CONSTANT_TSC.
> 

Looks much better.

>> +	/* Some older CPUs have invariant TSC but may not report it architecturally via 8000_0007 */
>> +	if ((c->x86_vfm >= INTEL_P4_PRESCOTT && c->x86_vfm <= INTEL_P4_WILLAMETTE) ||
>> +	    (c->x86_vfm >= INTEL_CORE_YONAH && c->x86_vfm <= INTEL_IVYBRIDGE))
>> +		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
> 
> Please do vertically align this too.
> 
> Would it make logical sense to do:
> 
>         if (c->x86_power & (1 << 8)) {
>                 set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
>                 set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC);
>         } else if ((c->x86_vfm >= INTEL_P4_PRESCOTT ...
> 
> ?
> 
> That would make it *totally* clear that it's an either/or situation.  Right?
> 

Yup, will change it.

> 


