Return-Path: <linux-acpi+bounces-11051-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA47A31680
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 21:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2593F164719
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 20:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BFD1E47AD;
	Tue, 11 Feb 2025 20:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E8WPKrx0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F16826562D;
	Tue, 11 Feb 2025 20:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739305217; cv=fail; b=sxprkOHgRym2m5DRBmLOBZa7hnLkD5vXg8Izi8oZWZmgz9ey1gqLq9x0gpDF29eB5R6pVbpE5885wO6oR2CkrdVwyR7VowymNNR+2hvWYEXbbqAUS9pqNhgnv6wRavbQsSwHHiKaexb35yJ0/F9NA4P5lgCdVejPn3oo2gUkkgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739305217; c=relaxed/simple;
	bh=ycNBSPRGkc5jODXMsSXy3koeJyEryQBO7JlL0aJWvsQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PdwqLecq09si3skd764OPQQ8VCP3koB6jMrrQ+4C0rfkFr/HYMenl/ca2m4GwRx2F3cGdW/EVUns5GfjWJpKxWx9XuqEznIliiRdcubnfUQA9K4vihPSGFpkSMiHDhtVMONrndPytQQIlqi9f84aE5EWZ5Kv0fklCy81rCLW70I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E8WPKrx0; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739305215; x=1770841215;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ycNBSPRGkc5jODXMsSXy3koeJyEryQBO7JlL0aJWvsQ=;
  b=E8WPKrx0zMmuiVsgHw9x1jcEmyHawXtUbHerArmyzus591eQYeGxNQPz
   IVBXJZ+dg0n+LC4GhiKlPMakVpE1j7GoK63Uo3NEYtk/Va7/g3w3gBVTG
   OXRc6gisylQfpRN8dbqginDW9W43TpmAUASuqmvGXYPqwjEvsHyFTTFzl
   w8K3dV8tBetd7WHib62+opwQPFbMIiNx5O7VUAk1ocKt0gZWTwkbuubx4
   TZnVp1h9vkL8+Lld0UjUMKgKTO3+3J8JEqa0jDP7mtx8c8RUCH5egYU3a
   nZtXhsPWjueBGdTlQFJg+d/cM8SPdIJNy2tP9A7BCpu3WdDxB+2Xrnhez
   A==;
X-CSE-ConnectionGUID: w4z4/u3DRIuB98qc8jDbFw==
X-CSE-MsgGUID: hA9r4VpgQhmtO2U2mFbG/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="51373278"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="51373278"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 12:20:08 -0800
X-CSE-ConnectionGUID: ptd+gai9Q7m3tZgu8Og7VQ==
X-CSE-MsgGUID: fR47CU7LQPq6NfHYLfkjRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117235694"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Feb 2025 12:20:08 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 11 Feb 2025 12:20:06 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 11 Feb 2025 12:20:06 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Feb 2025 12:20:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yeaKDKmixeQbRFpGHpTLNOIvdgvtqujxLYxuQN5K3hIOhdmcWJRRR9+as3Y8E9IjextRv23Zd/DXWtasBk8BKQMXofAIBSGCbpYG9WBqKTnTIutaF48ynU92ZwM2f3M0l3O2VpMoQ+ZkuUhJ9YVDTvKAe5oqrdh2yWJxzq8dtEy1YB0kcBaeqEUS5mTTSYSg96etDHUBDd6xE8kl06EkYHmN3LRpj6cRyp0KL8X7NDXmuFH0XoZvmjkEjwOkRm+Ip5BPdsRISpvz0iqCt6AIU9IkK9muRO1lMnSynJ8p6Qy/XFl/pd7wZ21K6CrXvXEJGrp/Z1rs4BHKm3MtejzbgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1uDVECytgpKYmQqvI4TmCTsTGjsI7uFwoDqsdkTVdww=;
 b=Bp+KBGTCTkYn/QLZ/rjKX+SAHcEpYKQ33SjCdOZY9UFCNrqk8SJQlW8ebUBmEFKmYZf0T2xEI8HYwGc4JLsKNLkJ0y1mzyaW029nMYLoootVZ3MUM9cZ37paYx5k68estRjI7izV1moF1n9H+cuqnkF1vVc+i3j4otmeSZWQcIKj36+Vd5ph2b9BKPKz+6WFEwD6G9XUXEu5h5mTLdBjvgfjk6qWdTPngCP1H1Km+n7fScHjaHZgnOrhla3C9wghokUMjkJxMF7xC2HBEDN+gtny3Ews9WYdpZz+f7+oIjlL8aDM1kko2cB2qZ8XJgiVM8BlQR6FkZDfPPAGe7G/Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by PH7PR11MB7986.namprd11.prod.outlook.com (2603:10b6:510:241::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 20:20:04 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%6]) with mapi id 15.20.8422.010; Tue, 11 Feb 2025
 20:20:03 +0000
Message-ID: <b8941997-81c1-490c-8f23-62070f7a46a2@intel.com>
Date: Tue, 11 Feb 2025 12:20:02 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/17] x86/smpboot: Fix INIT delay optimization for
 extended Intel Families
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
	<viresh.kumar@linaro.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck
	<linux@roeck-us.net>, Zhang Rui <rui.zhang@intel.com>, Andrew Cooper
	<andrew.cooper3@citrix.com>, "David Laight" <david.laight.linux@gmail.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-hwmon@vger.kernel.org>
References: <20250211194407.2577252-1-sohil.mehta@intel.com>
 <20250211194407.2577252-3-sohil.mehta@intel.com>
 <cd4828de-3a60-41a1-bb5a-9212bbe01e60@intel.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <cd4828de-3a60-41a1-bb5a-9212bbe01e60@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0016.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::21) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|PH7PR11MB7986:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d7977ec-af4c-4f1b-ba41-08dd4ad977e9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TTdOZW9kWVplVzVFUzlLdVBmWkpaZWVUbHBJTUEyYzBCWmNaK1pCcEI4RDE3?=
 =?utf-8?B?TVNLbkRqRVh1NkpNSzl1bGRoWHY5RnZvT1phSFlta2FxTTRtVjdHb3J3bHBr?=
 =?utf-8?B?ZzVxT1VyU0RhWThFRlR0cFNNL2tPMFArOWMwZitDQm84cSsrSlpXOGF1ekN1?=
 =?utf-8?B?eFVYd01JS0I4WkQzd1Z2c2x4K3BZWjlDZEt5TmYyeTVkN1ZLYzd6Sk1hdndu?=
 =?utf-8?B?ZWQ0czcxRHNSc0JSbFJ0NlV3cldLbi9FZnJ5SjFVRXZPdVpUaEp5YnNqMjJI?=
 =?utf-8?B?ZFd4NHExNE5NUTFFRHY4UUdzcVl0bXNFYURiWGNxaXhmcnhmUTdKc2pzNVBp?=
 =?utf-8?B?Yk4xVHpIUzdnY0UxRDVZZ1h2d2txRnNtUGlzUld4ZU5hYTFyUnFoRFJjWW13?=
 =?utf-8?B?OEZaRXU5dStiZ3psSFk4MXk0ZzluY1RtT1diYTYxVEo4dWNIUEU2WHhnYmNF?=
 =?utf-8?B?MWRwSklRWWh0UDhxQ3BKNGlJam1yQXM0ZXFnTEJNSTFWMzZrNDd6WUtEOWlv?=
 =?utf-8?B?cWdrWUlwR2tNMS9yK1pmb0gxQUJ0ckpWUVVDYXhnczl5blkwUE1DQ3ZSQ2dP?=
 =?utf-8?B?NzNyNW5FSzNscm5vck9IMDd5ZWNKZU0vMFJpUXN1QkZZMnVxWTF3YWxMcWFo?=
 =?utf-8?B?a2pJMG5Zcy9vckxicEltVC9rNGs5aDdNak9ua1ZaYW13M3B4Vk5zOS84U0Fq?=
 =?utf-8?B?WVBoMXU4d0NIQUQvNXkyTS9mcEFIL2FhZXo4cms5TEN5VWFmYjNCSWxuUWhU?=
 =?utf-8?B?aG9vMnErWnJrMEp2enBDVkZ1ZFBCK0cyN0xGNWhnci9aY2F6VUR0WU9lS3VS?=
 =?utf-8?B?aE9iZ2J3R0hkTWw0WkIzeXZYQU1pcmV3MzMxeS9JTkEwYVFESi9EdzZYdER5?=
 =?utf-8?B?TCtzTHp5eWJRc3AvM0JGREpJbFZ2Y1lId0FiS1p1NE9OY1VTZGFpamZ6eHJt?=
 =?utf-8?B?bWlTL1V4SE02RHBCclRvL0JmRHVFNVRLT1RDLzdFc0ZSYVViU1ZFdERROC9X?=
 =?utf-8?B?a2J3dWdYSHRURFJ4d0hyWTBMQ09tNmJtM0RqN2RRUjFBQThoS2xFSk9lWXd1?=
 =?utf-8?B?cE96NFpTVDZ3eUJ1eVRJMk1OMnU1OXlyaWdVVkJheVMxQ1J3VkhTMTVnbUJX?=
 =?utf-8?B?TzdlKysxdmFOOWZPTmRwWSt0VHo2ZmV6cnNETXBBSFdoT2VnME1WbVhrUG4v?=
 =?utf-8?B?UklQNlF4UnlpcTVJc0lNWjhPZ25WQ3hVSDlqa1pZWmhCS1FiVG1xSmpPTTRM?=
 =?utf-8?B?ckdVRzUxYW9QcVdyY0orRkVieE9YVldqYit3VGJ1aUU4bXFscUZRUmFWVFI3?=
 =?utf-8?B?Zkk4N1p2OVRMZlNHTmExMmxGS3lMZHdINkF5T2cyK3FYU3R6ZFJwcFA4djlq?=
 =?utf-8?B?U1NVaVBndzdScjJVRDhkNEdoUHdnQWhHRk8rcnB4WmVjcVdYcEtrdFBXaFFj?=
 =?utf-8?B?US9JS0tUZHR5S09vYUZEN3JNU1c4cWZTZEQyN09Icm8xVlhWaHZlUDd5ZnJO?=
 =?utf-8?B?d0M3eFRkQ2ZPdnZTTjlPRjRmK2p1R0RNc21aL2hlSjdSWmNxVWc4VFhvOUpo?=
 =?utf-8?B?Y0FLSlpFWFJJVWxDTHg5b05qK1hIY3ErR0MzSDZmSCtMZWdoQTlCQTZZbVcw?=
 =?utf-8?B?ZGNxUDRrODFpS0dtRjBhTWp0WE9aaXhwTWpVU0pSN2syejhjWTIxU2p2ZkQx?=
 =?utf-8?B?cnFZUzdBTi9JVHdReUNoQmpPVUxQWWVNdjQrbUNmcUxOak9JOU1TSzAwS1Qv?=
 =?utf-8?B?K1BhYWtWdzYrb3RFbGFBNjlQanZRMXRQSE9FVWdiSWszYnpFdExHRG42VVBp?=
 =?utf-8?B?ZTh6MFYwenZtMEtiSk1MM0RPa095N3RJNk9TSzVXeXZPbnNRYzUvck9YbGJU?=
 =?utf-8?Q?FEK3vtKhF3yze?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEF1ZUM0SEFidjZHOEEraUlQaUxDSG5SNERJVGt5d25vdXJDOEdJVGVLOUww?=
 =?utf-8?B?RkFZSldTaDRxSUlGM0xUaDQwU2M1V0lmSzJ4OEVIKzUvelVQclpQM21helA4?=
 =?utf-8?B?RmE3U0xBSFpJSDBUYklJT2wvZ1puZG5URURTcFViQWp2MktNQVVEbzFoUzdD?=
 =?utf-8?B?MWNaZ2hKWnd2dGFsaGZIb05iYmJSNTRqWkluNDg4cENrK1BkcWcrUWtzS3dY?=
 =?utf-8?B?L1pCcVJGR0JvVHY0TEtNRkFZcXNYdzRkc3E2TzRVR0RyTFdkbFRuTkZJMzBT?=
 =?utf-8?B?TjhYSG1PNnplWURFRFdHTmhqM2Z0Mk9IRkdJaVUzZm1RVDZCdnFzSzh3a3ZS?=
 =?utf-8?B?MFpKcXhIZ1JET1M5VGRVMlNpZEtkZ1VGK2QybHFYd2k0S2dkZWVUV2QxOGI4?=
 =?utf-8?B?Y2gyTWtjbitMcjNKM3AyZmFyb0YyckhJc1BSUlhKcHVrOHk3U0diL0hKQTlB?=
 =?utf-8?B?WVowUk1RdlNSbUxKOWNzYXJ5Z3AyMDNEV0VjNnc0Y1oxSG9SNkFjRGNJeGZT?=
 =?utf-8?B?cFBrZ0RjaXZaQXBPSmNEN25ZWVh4TldhSkovaFpqTkFVK2VqM3dLN0RldVBa?=
 =?utf-8?B?ak9XcGxSNUw5anptV3BHdXc1Tk5KSUYxQWkzR0p5cVRleURKUndnTmFZbXAy?=
 =?utf-8?B?YU5Vbm1hMzI5a3NXV2JUQkNYbUFDQVR1bkJCWXJMOUFzSFoyc3VnSWt5WHJJ?=
 =?utf-8?B?d2lIWUNQb1JRWG5IV0lFbnNMZGc5ZkxiWnVHSC9qOEcxNEpHVTRKcm9WYnI0?=
 =?utf-8?B?QVZDUEZiYWRSUk9vcWxpMkhxcEtoeW1kU2NjZFRVd3RCL2t5eUswUlJ2Vk41?=
 =?utf-8?B?WEtJZEoweUFIRTZEclVLdkRiTm1Yb0FJUzBuNWNwU1JvZ1NRTG9MWTJaR0Ft?=
 =?utf-8?B?d1NsUVlVS1ZQR3VMN2FOektkdXBweEovdzhFbTZ6L3YwdmtGNkdkNERjVjE0?=
 =?utf-8?B?dFFPZmNxTmJEYWt1QkZYMHh3WjNSbW54dStxV0xUWnUyUFd1YzlnQVVVemJS?=
 =?utf-8?B?UDhLRDRyUHlZWW9aY1BZSncxUlBjZHRPZU1NM01UTTMzOER1TjhLUHBWb0x3?=
 =?utf-8?B?MnFlTVMwTzNza29YeXZBZU1WMDExUHFIb0ZFYXRleUpHTjNndXRITWJFdWRZ?=
 =?utf-8?B?eHVNUVdHVzMzRTdiK2FtQ2FFNHhWZXltYkVvb2ZiNHkxUkIvZEE5R0Nyc2NT?=
 =?utf-8?B?WHgrYzZBVjRnUUVYNU9vV0IzZEZHQXMzMU11aUs0VzY2NHl6bkVEMkZOMFpE?=
 =?utf-8?B?RWQ1ak9SMXArTi9Fc3BoRjNDZ2J2N3A1bjNSUFVYd0FwMk1YNDVWWWl3K0Z4?=
 =?utf-8?B?TUhwdExOWjE0RWlHbmRUK281RDFJUVBuaTZJN3VndjRRTHJnUi9DeFRZMlZ5?=
 =?utf-8?B?ZGJ4UjFzSHJWWVZNV0ZVTjlVUlhCL21wQnRIR1lIOTd2UmdJYW5ZOTF0bHZx?=
 =?utf-8?B?THFTM1hyMmRoTldWdFBWNDJpM01xOE5mQUJIcVpHSHprbGtkcjFIam5DREZT?=
 =?utf-8?B?Vy9KeXl0NW9qbkR0QUxQUlIrNUo2dk1XWmJ4d3BtdjVrZE1xdjBOeUxZc2xy?=
 =?utf-8?B?MkxNRDJPcjdYWk9rNXQ0MElRenFlS0V4S1pvcWh2b0QrYTVNbTdCMmEzQktq?=
 =?utf-8?B?b3lITEN6VWZhZjl0Um1sbUVwRyt5TEdvMTd5b21FVG92VDB2YytRMmg5dzJo?=
 =?utf-8?B?OEFubC85QVNqVU4yTW1oenIyQ3dWNXFLNG5WeTNnZ1JNeEhTNzBlSGNwZkZS?=
 =?utf-8?B?cTlZb2YvZ09DRmoyZXZHMXFqc1pNa0VFODlRaXpiZkdCWkJXZzJKTExMU1U0?=
 =?utf-8?B?VEU3Sld3Vk9pNzVnY0dXSlRKalFyUlJRWTU4enBTQXNSOU9IWDhnRmtTNVlh?=
 =?utf-8?B?QlBYL09lRFdmNE81a1gvY3k2RFNOeTRpejlBbG5KSXVBaHFmbSs4b2labTJz?=
 =?utf-8?B?cUtYSS9pNmdMMVNWV0ZtZXlDUkV5dGMvdjNXOSt0dHA1VWJMRjFNTFMxNFF1?=
 =?utf-8?B?S1JRdDJvOWs5eGZGcS9OR1RJdzl0SWJBelJDT3VZWVdXZUR3VmdLVW1IcGJP?=
 =?utf-8?B?eFlBUWlYWitEdkxtWXpHMFM1b1RmV3M3dXJuZ0FRVFc2WGdhTWxXSGlvbFpl?=
 =?utf-8?Q?r67GAgJ/jOU/R4rNk+whfnFoy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d7977ec-af4c-4f1b-ba41-08dd4ad977e9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 20:20:03.8443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aJ62qY4TGHd9BBIred4+7WES1Mecwb7ET/wiFa/wnFMFNx8HttvFWqoS7lXo+KaO3k5inQ3s0XZg4BlEegiIhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7986
X-OriginatorOrg: intel.com

On 2/11/2025 12:10 PM, Dave Hansen wrote:
> On 2/11/25 11:43, Sohil Mehta wrote:
>> Currently only Family 6 is considered as modern and avoids the 10 msec
>> INIT delay. The optimization doesn't extend to the upcoming Family 18/19
>> models.
> 
> This doesn't quite parse correctly to me.
> 
> Let's say it this way:
> 
> 	Some old crusty CPUs need an extra delay that slows down
> 	booting. See the comment above 'init_udelay' for details. Newer
> 	CPUs don't need the delay.
> 
> 	Right now, for Intel, Family 6 and only Family 6 skips the
> 	delay. That leaves out both the Family 15 (Pentium 4s) and brand
> 	new Family 18/19 models.
> 
> 	The omission of Family 15 (Pentium 4s) seems like an oversight
> 	and 18/19 do not need the delay.
> 
> 	Skip the delay on all Intel processors Family 6 and beyond.
> 
> Is there anything wrong there?

No, it is accurate.

