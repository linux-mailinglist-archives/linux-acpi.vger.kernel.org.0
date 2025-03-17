Return-Path: <linux-acpi+bounces-12307-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F459A65A64
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Mar 2025 18:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FC1C3AC93A
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Mar 2025 17:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B18B206F08;
	Mon, 17 Mar 2025 17:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q3ta6wTw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C2F1C5D7C;
	Mon, 17 Mar 2025 17:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742231380; cv=fail; b=n6ENAamYFWtSj5HD5OnDc6LhPY2Hfc4j7Rhk82G/iqCpift3Iam6hA/6AUg1RGCyDsDQ1IkjHq73ZL2VeuU8hqQK14C9uMy3C42MfPMRhhjmYBHCMKnpPDbbouJnuPZOYJRPjBKs2jLyp3akqGac5bK4YZhJxO69Op1ivv73Jy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742231380; c=relaxed/simple;
	bh=8LFF8XY2FKesYKaIrhdctoAgfR7e95YljJ64wBr01ec=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bP+PuMDgb2/x+oh/LA+I41h9u5ePiNX1KWou3/7h6X92Ab31HeupadHOpL64bsqKMPDCw1M6ICLGEDQ89B14esFpl7EaDFsgy2qabaQUM3nkuuPBaVuEIqjQFL8Y0C+vlqzW3r9Jelt17SC4ma0cLBFywsbzCH457X7ZpIRaPEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q3ta6wTw; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742231378; x=1773767378;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8LFF8XY2FKesYKaIrhdctoAgfR7e95YljJ64wBr01ec=;
  b=Q3ta6wTwI7fod746DydLlFNp+5EsCmgAADTGRyN4dCRms6x4TDglYFhQ
   eLcx47d5mWIH/2fG9pl0KOWmrk+f+BNsk2bR83mar3T0TAHS91O7B0hzP
   8IEVH48ExJKWVQnXiahNOXSYzkrfoUc9nNgLHRdM9MCNmuiGCWlh1a8jx
   2lSn/M3yp35W52tXNxANjlK+QisL1mvx7io1opnqEQt1Ajq49gtcnYx0k
   Qxkvtt494FinUjuf1drixkYg6YA+k2zwFKWFRGHfngVx0jdlvvp4feFLD
   eAjAHKE2I5574ENBOUxkXeJ7lyS5xSrsWEI+iXKBLiB1uISjOqaEZ2Cny
   w==;
X-CSE-ConnectionGUID: M8OIserDRrymSc+vV41OKg==
X-CSE-MsgGUID: phCdZkFvRfKrW4vbmoVfmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="54334324"
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="54334324"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 10:09:37 -0700
X-CSE-ConnectionGUID: FVgz/5OXTFaOJIZyVuVBGg==
X-CSE-MsgGUID: k58mOCp2TO69b3vhEbb0Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="122736961"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Mar 2025 10:09:37 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 17 Mar 2025 10:09:36 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 17 Mar 2025 10:09:36 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Mar 2025 10:09:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KFOJbi83wUiHkXQaDTpMR/PAr5/kunUIm/0YG8+aNhgIEn3AGXnwD4EUqPzgmYoOQ2F73AVDF0XRUHXJDNVd7fyOc8FgeL4VjMk6h6m3KnhhU7tkvrgWVVEhgcdT2uFgjtHnZUSu3Lm1EYLg7ekH9rgyz7wM0Tb4oeDotYAlzaL1cddQmrsSYKWu/tuj3tfBKP1sLBmBGqTfIc1iQLjPu+lTboVi1C9FG5rwDAB+3trrGsCnSMwRYRqf9en4CaBGNFsQR+a6bBsaqBvIhOCJqpEL4rOOxn70oEYS+87cggGOfK4wCS/6G+9ObczJ96DkjCQnulnHUrV3T1xMpRJpFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfU4ccrIbUpgShAsBfxKzWOKHotHfIXejabrSWu9EJc=;
 b=bW4uqT0793rzCt0P1UhCUmVWtLlfNOYKS5MLivaZ8lBFg47U3AM7JrKu3PGg5yQ1FGOf3+Vm+3VKXgJow2uIIjoN2Vv1VdryMnjeJKyWOsOqhMayYfXNEsMbe7Iz5sMmQN5fXjs6yqhf/bArvhAGccZKV5fUBUpGs6KKHEAEh3DX7GvLKmgaPYnhU02gDpmraeZvfs+DVV14vZmP+xUEm+B+tCT2Oqygv4W/6wEsFRWWr8SXD46cBkrNmCNTaidJHV1hmEdvrQkcW1NljjZ+xqYAHuHdT3CofbqYkBhuIO4uW7G7yIG48hBGDkklE2s7UAHzYlR83w+Y2qyJIyd+9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by IA0PR11MB7840.namprd11.prod.outlook.com (2603:10b6:208:403::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 17:09:33 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%5]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 17:09:33 +0000
Message-ID: <df1b95d7-c953-4757-b742-3072f65539f7@intel.com>
Date: Mon, 17 Mar 2025 10:09:31 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/15] Prepare for new Intel Family numbers
To: <x86@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>
CC: Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, "Kan
 Liang" <kan.liang@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, "Rafael J
 . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Andy Lutomirski
	<luto@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Jean Delvare
	<jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Zhang Rui
	<rui.zhang@intel.com>, Andrew Cooper <andrew.cooper3@citrix.com>, "David
 Laight" <david.laight.linux@gmail.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Tony Luck <tony.luck@intel.com>
References: <20250219184133.816753-1-sohil.mehta@intel.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20250219184133.816753-1-sohil.mehta@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:a03:254::15) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|IA0PR11MB7840:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fd48bb5-0581-43c1-8107-08dd65767cb7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ckxaWVNMeDNNWlN5MEVPcHFEWnE5NC85TXpPbGxzTFFZYlI3cGhsdXE4UEZG?=
 =?utf-8?B?cUVxamN3S3dUTnNET2dYMmo1RDd2eWZaU01HSW1EMzNPUWk1dWhtV0FUY0or?=
 =?utf-8?B?SjczOEZKSEFXWWRqOEY5eCtjSEVRdGNmR0J0NHZGRktLV01pTERYTDFNRm5T?=
 =?utf-8?B?K1N3ajhrRVExcWhoZTFNbkpkQUlTVFFIQzZVSEg2RkhaSmJEZW9TNkR1eUhC?=
 =?utf-8?B?LzNOUmRtNHlwZ3UxcEg5YVJrVW5UZ1NLdjZUVysyZDFLNWRTRkpzbGx6OGVs?=
 =?utf-8?B?WXkyRld3bklTeCszbE1tMUZDZjBENzJJOXR2YXY2VDBQRlYrMUVicDhkR1Vo?=
 =?utf-8?B?ZVBaaGVrR0tWQ0V1NlFOZ2JkV2ovS0N3ZkJ6WjJaMFJocm5qK1RnbG15Mm5n?=
 =?utf-8?B?WVdEN3VtbG42b1lpbll2cW9uTHRWRkFyVVlicmhDZ1ZEMmxGUTNnVDVjU2R3?=
 =?utf-8?B?NGZla0ZnMmVZWU5iUDZ1VmRVNWhmTzg5MS9zaUE4dnpQTnVTYSsvdjBQeDBW?=
 =?utf-8?B?V3BpZmJoQjFPR0ZQMnhPWjFKR0ZERUw4ekFpQWZvT3h3b2t4MGhWdzd3WHJI?=
 =?utf-8?B?U2t0MjFlQ2dZbmwweSsrdzBhZTNFUGprMzFyZWk1ai8wbVFrUHJ0ZHhrd2Zu?=
 =?utf-8?B?K2YxSVUyREUrdXR4NWUvVk10RUZQU1M3cTg2ZHBId2ozemEwd29mUlVMeTV6?=
 =?utf-8?B?V2s4cWxJbWxUWjlyNjZGNGJpT29YUnU0WDlTQWgrcys1RWZjbjA2dFhhTTNL?=
 =?utf-8?B?eWRMOGY1VnZkalJPNmwwSHp5di9Id1RlYlY2aHlFYWpKWTFGTnhSWVhVN3Vn?=
 =?utf-8?B?QmJhcE9rQkRlekxkNlZpR1lMYkF0a2d3RXFiaktBekY5aHRPNzlTdzJKQ0hl?=
 =?utf-8?B?ZGtRZjU4b1dWRnp3NXBoYzF5Vk9KNklxNjRKaTZtT0cvWmFhclJhcFNjdDAv?=
 =?utf-8?B?OUJQaHpSMFA4UGJLdXNuNXNNUG5HUUZGVWtOZjZNYnlqb2dacHh5RWY0REZ5?=
 =?utf-8?B?RC9hZEVtVHJ5NWhZSVd1cHhYNlBkenBaL0ZLUnB3RzVtYUt1RTFUMHVsTU1j?=
 =?utf-8?B?b1JGVHpDdXFiaDVwczNXalc4RjdmK2ljYVAvN1kvTGRVUnpiaEE1TThKdUth?=
 =?utf-8?B?T2hhaS9udG04S1NCaXJxWlZWZkJzQndNNThEUjZQREhSekxOajF0cy9CUzJQ?=
 =?utf-8?B?dEQrVkRWQmRKbUhmcFlzZ2JUVGFpVXRSa2NsM21BVDhxNDZ0a0xRNjdyUWp5?=
 =?utf-8?B?ZjNIajdaUE5WMDB1dGhBbkNOZ2VRYnZVYk1lV0NEeUlTRCtMVkJQeFZHb2tq?=
 =?utf-8?B?Z1V4T1pCODZyY3BEUUZDTWhneU02MHhBOVpGTHpPMXBmUUFtT0tXa0s4dCto?=
 =?utf-8?B?QzVxRStGMlRseVBVc2d3UExtazFuY2w4N01CUGZOMnFVemtUMDd1ZzNxY0di?=
 =?utf-8?B?a2NTR1NySEIvelNkaFRiNFhDM0Q2T3ZhdUxCb3JmZ0U4WndQdE12ejdPSzJT?=
 =?utf-8?B?Y01Kb25vRzArakl0R0FuNGxxdlpjQ0pad1FlNzN5N2VOcUsyWlpvaGJCbS9l?=
 =?utf-8?B?d0pzMFMrL1RGYUFJWEIzM3dIcVZybWUwM2ZUWXhyUzVOY1NZVVBlL0ZsYjJI?=
 =?utf-8?B?UXkvWWtjdjJkd2puamhVUzFKMHFqN251TUgzTjcyclBtRkkwK1RzVFpRYUdK?=
 =?utf-8?B?RnRWbHlSMkJRdTRxSE93SlMvdmsxbWx0cUhkcTFUb1dUOTJGS2R3NG1adlVn?=
 =?utf-8?B?N0pxQW9JYkk1V25ZUXBuS1J2aGdKZ2JxVFBsbEc3OFVRR1BnNjRXOU9NZ2Nt?=
 =?utf-8?B?aWFMSXoxNk5Peldub2QvMzBYc3U4Q3M2NTRjUXlqblZyNk1HR0NZTmlCY2ZR?=
 =?utf-8?B?R05HdmFVMy9oQXNBNkhjV1lERERuUG96K2pmRGp1MWlsTlE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0dmS3YxVG5YalN5bWtaN3NPYXg1VFdPQTZuRjEvYzZaaUxuUFgzeVNrcWto?=
 =?utf-8?B?QXl2Y0JPOVBsUkM3ZC9ZOGNtL2ZlY3FvSWpqNWZaSWxSalBaWnhEZ3JZeHVq?=
 =?utf-8?B?VStKbEpSODdsS3JOQnVKKzkxWHBVSnpJb1ZJeW9sam9zUTZxQXlzZFltMGhW?=
 =?utf-8?B?dXFsWDlTVHVMVEhFRnpMTENYZDhBVjNObUxTS3BWR0NqbGlqcFFXK201blBw?=
 =?utf-8?B?YVl0bXNDZlR6cmtJWjVtdjB4NVg2TFdJSGt0Q0FnVjBJUTc0dWNlem9FT1Vj?=
 =?utf-8?B?dDhmUVNDRlArQ0pFdWNNR0NTQ0tVOFAyR1pqWU8yUFRlTXkyNUkzSEFEd1Nu?=
 =?utf-8?B?K05sTnJlTzVDeTl4bzRTSU0wNFhUVE4vMFU1Zy9BKzROalltNmJENjdrK0R4?=
 =?utf-8?B?aHVBUjdibys4ZG53L1FpMitnZDV0cXFtZjNxOU5OVGEwRGc2RGZaT2trK01X?=
 =?utf-8?B?eVZqMW9tL3RTZ2Z4Znplc1ZWa2RuTGFsN1ovVWpLeVBYbWVZMXNaYjVob2Y3?=
 =?utf-8?B?NnJhaVMzUkhRRzdYcHFtbmZORURMUHhvUzVzUjJ6UzNXYzhyS2d0Zm9LbXZC?=
 =?utf-8?B?T1YwWHM2YklqclJIZDRXeXRQRVc3dmJXNk1tcUY4NjRQbFltdmpvWmlrR296?=
 =?utf-8?B?d2p4OVVpdjlGckl0Tk5TWXVUOVEvSW5TQllLMStRQjZDZWEzMmlTZzNlYjVK?=
 =?utf-8?B?aWpOUUhRNVlRZFhIcFBGSnIyY1dDOW9qMU00VFphbVdzRE5RQnpNNDRNWWVs?=
 =?utf-8?B?WHZiVDZPc0JtN3lFWGVZK1JKMU1SeTBIZ1Bwb05XNUhFMkNFbUd3VHJYaytX?=
 =?utf-8?B?Qld3S0svcmdoSTZIYkNWZTBKaGVteTlnL3IvYi9aa1FqYnhoWE9BOE5GLzFh?=
 =?utf-8?B?YnFaNUhmYzJnb3AyVHpXV3FZKzhwVFFNZ29zMU1qd2g2dWt1c0FvdkR5bTEv?=
 =?utf-8?B?ZzZ0S2NkbUUxdFFNK2x1dE9DRWN3dHYwT1VBRDRrNGtWV1RqN251MzZabFRQ?=
 =?utf-8?B?VUJxV29PaHQrYUdEQmU1OG5tUnREZmxZRk5yaitWRGNldjhUWG5ZTjFidE1O?=
 =?utf-8?B?Mk5La3MxKy84aWtVM1pCalRabkU3ZTBteVQrMEZwYVNJUVpkOVcwaUVPMEYy?=
 =?utf-8?B?UkRabmNyaWswN2dZTDl4UjBZM0VNVlhoWVhwUmc5QmUyd2U5S2Z3ZVVrUkgy?=
 =?utf-8?B?TGdJV3pGbFRad29QNGRUYUhUbHBEMlFsR3Bady9iamJ5SE9pV3JRb05Rc0gz?=
 =?utf-8?B?MDVOeWt2aGhBL2Z4N3puVDlnYmtKZ2pkN3hYMTV3UUpTU3U5TnJSS2FRUEs3?=
 =?utf-8?B?RU1lMUhYS3BtNkY5LzcvT2pybmlMTERWSmx6UnVVSU9raGFjeHpSWFV0d0Rj?=
 =?utf-8?B?SWMySmYvOUJzQWd0T3NoVjkwWCtNK2VZVWRCVjJqTnNhMTFqNGExREUza1pI?=
 =?utf-8?B?aTc3dlRLT3JobDZjYWo3U0Z6Y2pPZHlXdEE1TXgwdXE5QURlS0YzVkRFK0NX?=
 =?utf-8?B?Tm13WWJCVzF6MHlobTlEMG5Fd2lMNFNMelErczh4ajg4NUtGTVFVcVJEcElV?=
 =?utf-8?B?dGZXS0VMdkxQZ2d1Q0w3YU5vNkt3alNCRHM3a2tWcEhZcDArbGo0WnYvTnBq?=
 =?utf-8?B?OFZLTm13ZjRWTFhKZWdLMTF3L3Q2YXd5U0FkMkF6TzN5dE5yK21KRFlKZEZS?=
 =?utf-8?B?TEwrbWRkOTRYWktnUHpDcnFyTHhpU05WZTA5djhFMWZvZDdQUXpHYS9uM2Y2?=
 =?utf-8?B?Q2VJcHhaR250WFVCWWIxSWV1aTNUSjQzaFcrNlMzZENXcW5VYVFYeWhKY3dX?=
 =?utf-8?B?ZjdlWTFRTDlSNlFTa1gzNUpRWVlXdFpJbzJ2K09nY0YwMlAxbC9nVThpVzJV?=
 =?utf-8?B?V0d2Rkp6K1FPVFlpRUdINFphS2ZlNmc5R0pUa0JWb2lLZWNLc2hhdGkrdjdj?=
 =?utf-8?B?cVdhNVZCalhqMHpuUXJnMUhEd3FRSERTMVNBZ3pjZEh5QzZycmI2dWxUYmZ5?=
 =?utf-8?B?QU15M3diNGJxU3d2bjIyN3dJQU5rR3BYejJnQWdERHppL2ZmTmZXeXpoZlEv?=
 =?utf-8?B?QXl2TTRVZHZTc1pjbjNESWIza2hFb2NyZitPR0Z1RklZeEV0TU9NdnZnNnQw?=
 =?utf-8?Q?nHy+s4XwCNbx7gwuJ9yWViWLT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fd48bb5-0581-43c1-8107-08dd65767cb7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 17:09:33.1567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3g+gL2Q7+yN7/QJc5Z82QNSfGSdeEJqAa+VzLCgaQcMdX/Ql/GysvmP6ph0vNB+CTtoyr/4/aRU0+iF+4MBcfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7840
X-OriginatorOrg: intel.com

On 2/19/2025 10:41 AM, Sohil Mehta wrote:
> ---Summary---
> Mainstream Intel processors have been using Family 6 for a couple of decades.
> This series is an audit of all the arch/x86 Intel Family-model checks to get
> ready for the upcoming Family 18 and 19 models. It also converts the last
> reamaining Intel x86_model checks to VFM ones.
> 
> Patch 1-8 : Include Dave Hansen's Acked-by.
> Patch 9-15: Almost ready to merge but don't have review tags yet.
> 

Is there any additional feedback?

Most patches have review tags now or are simple enough that they might
not need one. Patch 11 can probably use another look.

Patch 14 is the only one that has a minor change. Seeking additional
input before spinning another revision.

> ---v3 changes---
> * Reordered the patches and moved the Acked ones to the front since they are
>   likely to get applied sooner.
> * Patches 11 and 14 have a slightly different approach now. 
> * Improved commit messages overall.
> * Dropped the drivers/ fixes. Will post them separately.
> 
> ---Previous versions---
> Refer the v2 cover letter for more background.
> 
> v2: https://lore.kernel.org/lkml/20250211194407.2577252-1-sohil.mehta@intel.com/
> RFC-v1: https://lore.kernel.org/lkml/20241220213711.1892696-1-sohil.mehta@intel.com/
> 
> Sohil Mehta (15):
>   x86/apic: Fix 32-bit APIC initialization for extended Intel Families
>   x86/cpu/intel: Fix the movsl alignment preference for extended
>     Families
>   x86/microcode: Update the Intel processor flag scan check
>   x86/mtrr: Modify a x86_model check to an Intel VFM check
>   x86/cpu/intel: Replace early Family 6 checks with VFM ones
>   x86/cpu/intel: Replace Family 15 checks with VFM ones
>   x86/cpu/intel: Replace Family 5 model checks with VFM ones
>   x86/acpi/cstate: Improve Intel Family model checks
>   x86/smpboot: Remove confusing quirk usage in INIT delay
>   x86/smpboot: Fix INIT delay assignment for extended Intel Families
>   x86/cpu/intel: Fix fast string initialization for extended Families
>   x86/pat: Replace Intel x86_model checks with VFM ones
>   x86/cpu/intel: Bound the non-architectural constant_tsc model checks
>   perf/x86: Simplify Intel PMU initialization
>   perf/x86/p4: Replace Pentium 4 model checks with VFM ones
> 

