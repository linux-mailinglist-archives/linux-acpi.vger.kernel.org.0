Return-Path: <linux-acpi+bounces-11328-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A12A3C9EB
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 21:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 402F43B8F59
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 20:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04FA23AE60;
	Wed, 19 Feb 2025 20:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M4JfNiwL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D626521516A;
	Wed, 19 Feb 2025 20:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739997125; cv=fail; b=W5TCyDAzDPc5HvYtdyEIYfwh1ZyrD+yodn0y0jjmvBX96iqwFpzLsED4q0O5ql43v33HtjrgPkpJHsL5+FKzjZc05rl+6f9ftnYP2gBFpEzPdK+E268NNpjjhc8HGz7kPvuo2XFxXTPpaia5IclFeR5QuJ01fuvMzL4OwWx41HQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739997125; c=relaxed/simple;
	bh=OTLiRjh3wZLUAXXF+xbIC7zdqgKwn9bHzck4LcsW+ok=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bhy0bTj+HnGdqx5fskRgJHChx7NfCToXoHYw5ijlSJtJnS0uG2O9VJi9FUuMieVRdVxg9kRQIHgXN21HQy80A7d8j3TSeeb86LKIY9cPCdQRSsJDPVs8cBB4OQfdHedAU9M/o5oytbW7pXVykoUO91d1D1jBgMg82OZAUTKBvR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M4JfNiwL; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739997124; x=1771533124;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OTLiRjh3wZLUAXXF+xbIC7zdqgKwn9bHzck4LcsW+ok=;
  b=M4JfNiwLNk+AyVBdrhCm217T2D+qmMEI9NJDT8OKvM7W583UoccgD78f
   D5/oSzKB25DBweqZjBr++oXzwOh/MhstbL+8M7FxwYfMQlHRUDjsLZulE
   9GeB7FOPgqKEyJoEhv/Zp5rue6zOBz6Z0rpt/7sxERZyIUjssFj9XFqgm
   MRypTnnWdk3xZnQApJ76k2vTHXAKAonBmbaS4pYQe+iaN0fWalpWUXbg3
   B7XqQaHvYhglQMKNXBr8B0+bIVMjvz3Q7F/D2meq7IfDGp+0DvzbNrx8I
   dL0GikOWGRRWJ+9spxKl9TotM54lMhiWxWHfTkLBKi9RcI1Joaw6asoea
   Q==;
X-CSE-ConnectionGUID: ZhKIU7GtRAGmI+jfS//ysw==
X-CSE-MsgGUID: ypAjOeY3Tb+lC1MRnNp3Ug==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="40609202"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="40609202"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 12:32:03 -0800
X-CSE-ConnectionGUID: jb4JcZPpRhWHTXp12lGxAQ==
X-CSE-MsgGUID: yEcn8kjUTkmSG/+dpBdcIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="138040526"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Feb 2025 12:32:01 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 19 Feb 2025 12:32:01 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 12:32:01 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 12:32:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G1/5apRtj0PfFPkd10yS6qAKHpYbuCmEBGYxoDL8BY1nqScKn4oXpmj7xmnx2xfYbsdRrdr+Y3bBbxQWJK5ZE7akOkQHEYtk9eWDiXaNs34x4YsozS0tqUkNzr9ljCTuvQtrgbALVSrlfA0WU4OTs5EQTNDyk1CC5NLexOuldCZIi1ilie4uM2dPsWcb174EMRI3spMc6rHOe5Xf9nXbJF13tXcNzJhttTTopUifpbi+mJRge+UKjxkhQLp2Ji71zsPXNE3s/9xoZ8Vrh44WA3yGTqWMKKnWgs+fW24pqpmc/WTKLQBtb9ElR7mHqBeMTwf9FE8D5aRFj8Ds55f1zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23EWGRkobczpBD/BjXZ6huYulTtAQsi3+w8yYCu7ZD4=;
 b=KRzfJm6Xem1Eo1nJ0x8xcuc9vALjjz4d38t1vzB1VJipEZrPHZRqupfv6vl2mz/NBkwUhpFdsR9e1G9E3LglO35u1l5XQufTj1a2XnfDFy8u1rgJw7ezxnB4bS55BByYS9l4pXLnrJK5Aiv17vPLHBrnKKqS3Ik4RCpJCEFj5uIVvlFVRQEbvGa/2+dQa49+br0BRbiDMI7c0UZns2MM40ERIdy7rEsL/2jmtj16lwFbGzZQJI5uobGqgj3q2xsmBFSg0xVFJJeoElFe0IT916b82GayXChk3BuHE6jhWYKczphNKHtkf6xvpdmXUQdMEYo425FiWPD+goPrBYStrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by PH8PR11MB6802.namprd11.prod.outlook.com (2603:10b6:510:1ca::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Wed, 19 Feb
 2025 20:31:57 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%5]) with mapi id 15.20.8466.015; Wed, 19 Feb 2025
 20:31:57 +0000
Message-ID: <3f3f6589-8074-4a9a-936f-513013c43477@intel.com>
Date: Wed, 19 Feb 2025 12:31:55 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/15] perf/x86: Simplify Intel PMU initialization
To: "Liang, Kan" <kan.liang@linux.intel.com>, <x86@kernel.org>, Dave Hansen
	<dave.hansen@linux.intel.com>, Tony Luck <tony.luck@intel.com>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, "H .
 Peter Anvin" <hpa@zytor.com>, "Rafael J . Wysocki" <rafael@kernel.org>, "Len
 Brown" <lenb@kernel.org>, Andy Lutomirski <luto@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck
	<linux@roeck-us.net>, Zhang Rui <rui.zhang@intel.com>, Andrew Cooper
	<andrew.cooper3@citrix.com>, David Laight <david.laight.linux@gmail.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
References: <20250219184133.816753-1-sohil.mehta@intel.com>
 <20250219184133.816753-15-sohil.mehta@intel.com>
 <49c59a81-015f-46a1-88b9-f043ca2710d0@linux.intel.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <49c59a81-015f-46a1-88b9-f043ca2710d0@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0181.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::6) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|PH8PR11MB6802:EE_
X-MS-Office365-Filtering-Correlation-Id: b83ddc95-38b6-4a7e-77a8-08dd5124748e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NTJVMHZMWUlVR2FocFRFNW00bDdGWS8vY2FFRjhOVmRQSlNDZDYzYWhtSDRa?=
 =?utf-8?B?eHd3eHk2NXJyVHZOUmYvRis2Q3JuOCtmeFlhOURBUDAxMy8rZlhYeUpwbWY4?=
 =?utf-8?B?czE1MWtZNStWOExnVzBTM2F6MGNOczd3dmJGTjFSTkxOSjBKU3oxaS84YTBU?=
 =?utf-8?B?R0lNRjVmR2xMcXQzK2dZNGZpdWhyVkJxU0FRNEo2Q0lyOWNSNURydVdDSVgx?=
 =?utf-8?B?L1JYVmhuWWViejg5MmRlUG1XUFViYWpBWFNuU05OeHJpNHJhRmZkeTR0cW5X?=
 =?utf-8?B?bW9sR1UzVTdKdm1kSERMQUtabU1BYVBQZU9GZmZzbTB0cjJnSDdUeVhCNUdB?=
 =?utf-8?B?djQwUjNIdlRibGFWUUkzdmd5UlpFSW5vZ2dNL3gwNjJsVnhLUkM2bjZnUmE4?=
 =?utf-8?B?RHZVWFhjZHRzWFFTempWSlM0T0FwazFZVTYrWjlURUcrV0JRTmF2SXV1S2E1?=
 =?utf-8?B?b2JGdEVNanpadUlKUXRZdFRSeUc2TUhsbXFCcm5NK2c5L0l5Q1JTd1M5NTA0?=
 =?utf-8?B?UDlYWUhYVHVLSWRrZldMSGlYV0xIMlV3dG9LVkxiQ3BsL3JHN3NzSTIvZWo2?=
 =?utf-8?B?WEMrR0VBYmJYTmUwckxid2M0dHJKSitwZmEyTk45dWJoYzh5RlBjZnp1Z090?=
 =?utf-8?B?WFdXd0g5MnEvcVoreFM5REUvY0tjV2dBbHZ0Skd5cFhWRVNocVlRaDNHU0ZV?=
 =?utf-8?B?VTVSSWQ1NlAvU1hVN2s0VXZUZUpYWlVSL1VEMGt3cXI4YU5DTFU0RjM0Wm1W?=
 =?utf-8?B?ckFHYnAvblZhRWJBZC9WZmcrY0hhQjUzYm9aSUlqTnVkQUpZMTQ0VExIK0Vl?=
 =?utf-8?B?RWhlZ2ZtZGphYU1hUVFqTU5ia0lSejQ4YjNQciszTm5sS05BZnpBZEtoc2Vl?=
 =?utf-8?B?ZHJIZU5MVmdYWjFGNnpIaCsrdWpIdDRUbkk4NWtYRVpQbjd5Zjcyci8xbjlY?=
 =?utf-8?B?cmFxTXRlVzdCTkxUT1QyclA0UVY3dlNFRzl2YnJIc3Jvb1JGRXdEVVBjRWhO?=
 =?utf-8?B?dm5jUk9WUHJrdEQ3YXM5aCtGSU56ckFQZjM3d0ZaeFUzSzRIV003cStTQlZI?=
 =?utf-8?B?YldFQ2VVRmovcjB3QlNpMHhFTU41UzFIMGFvL0xQL0ZjVE5DUDlwMFlQY3pH?=
 =?utf-8?B?TzdNNkd0Tk12V2JnMDNic2ZMYklpZUdXOGNNZGlNOE9SOGtJRzZaZ1lZanR5?=
 =?utf-8?B?cXBIdDRwS2ExR1AySHpPUlhTWGFabmxpL0JFc0ltTXliOG1RRUwrVHZhYWoy?=
 =?utf-8?B?Ni9DMHl0THpVbkZ3dld5a1JrZUNaM0t6c3JEQ05zRVprZmNrMjhsOTR6akQw?=
 =?utf-8?B?R3hNZzQzS1gyemcwTlo2aUZmbFU2blFsWktSOE9vcDdhU1prQVJhYU45em1Q?=
 =?utf-8?B?MkthSlUxS1QzckZLTkYvQUtXTHJPUHVJSHliNGhYOTZ6aGJseVU5elUralZB?=
 =?utf-8?B?OGNRR2RJWC9GaHl4QURuVG04RFUyRkEyQkVncUIzOVcvY1oxVkFtMkU5R1Rt?=
 =?utf-8?B?QXFrMW90TW5lZXBJL1hubnBHclJpQW5lUTJuNHIxRHhOd1FzSEZPV2x0aEFH?=
 =?utf-8?B?OFFOZ1VZaGh2UjhIanZvdUdzdWxlZTZQR1RhaVRsU2ovczg3RE00cFMvYTZG?=
 =?utf-8?B?bm9TN3lXOSswSytuVCt6Z1JiODEwMG9jdkJvTlQvcGVYTENZNm1IRjB1dmY4?=
 =?utf-8?B?SGQyWmZWWmE4QStudmpaT01MeWk3Vk5MNDZLQ0EzU281U05PSnh3MTFJbWlu?=
 =?utf-8?B?UHlvZnpzOXhDS2pqcjlrbWtJNE45NlozOUl4bm9vNXdsc0VkeVJRUm5oUlk4?=
 =?utf-8?B?OTUrcjZtbEJqZDM2NDFJelQyQkh6djRhazB6VmNLQXFlakd2bnVUTWZPZWs5?=
 =?utf-8?Q?GKELPZDj42z7K?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVEzSHc0d0NtNkx5ZzFNYmNxM2RVZjdmOTIwa2pzaTJhamdwSnB6Wjk1Z0Qr?=
 =?utf-8?B?T3J4bGtWOEVZcTJOVXNuTFpDZS95Q0czdVlSMHFEYTdQMWpDSzN1eW1aaWw1?=
 =?utf-8?B?VVY4ckl4WXQ0RC8vNkFYN0p1UHZ1eWp4eGlOb2JCKzBOandhUHh6cUVLRE1q?=
 =?utf-8?B?ZXNQS2d0b0tMMU1nVStzdHN4T0VXckFZa0d0QllzTUVRNFFqZFBNWlpQaEE3?=
 =?utf-8?B?Vmo3SVJHQWNNaVU2YjNybmR3U0ZKVU9ORko1V3Bpa3ErejErQTk0Uk1wcTdl?=
 =?utf-8?B?Q2laN3RCRzBYNkp1dG9tQTYzOUVLNStOSk04R29SM1dxTnl2VmR1Rm5YQnZ0?=
 =?utf-8?B?ZXFTdENBZzlmR3BJdjc0Mjlub0tSN1VkV3M1ai9QdGpWLzRyQndpWFRsQUpq?=
 =?utf-8?B?UFg0R0N4UnM5cE5ReVFPRllOUW9JdVBUUjRNRlc5NVFmY0U5Lzl4RGs2QVV2?=
 =?utf-8?B?aGdHYytLSDFRUWZKc1E4bXlDMEdDaXR6UFRTcXMvS1ZrVEY5bDI1SW9BYnlq?=
 =?utf-8?B?K0pEczBTRUxLNXBmWjlaSFRqV1BEZTFOdkVwcE5OQWZjb1dLSFFpc1lYblg2?=
 =?utf-8?B?ZnpnOHRDcXd1RExwOXFmSVVPL1JCcFhaVVF0c2FBZG1nRnEyeXFjZjBrTVB3?=
 =?utf-8?B?bTFiWElpZmhuVS9Pb05DT2dxcnczZWJZNDZlTVBwNGdkNitWWlN1ekRyOUlV?=
 =?utf-8?B?d3pkTDExVGZBV1Q2elhTdVdTZzM4bmE0UjdmYXVTR2luNGVqTmpJY2NVM1Fj?=
 =?utf-8?B?WjhVaUxhdDl5bG9XY2RqdFlwelUrSUYzSzRtR2FBU0VPV05WWXdZem5zYWta?=
 =?utf-8?B?OXI0WjJBUXpXVCtzMEl2TkhiRHBQeUVlbk5QWmJYNFA0WkFBZkxvOC91R1BD?=
 =?utf-8?B?MFYrUWYxVEhJZk42a0E2OEhtNlh6bGoxVWlhWE5memdmelBUVWc3VkoxM2ZK?=
 =?utf-8?B?d0VUNnFMWTR3WFlhekVwbFZENjVON1owUkl2M0RTb2N5a1FLUms3ZEN4QnUy?=
 =?utf-8?B?VUx3L2FpWFAyeUdCelMrSElBSDZIWVI0L0VOZjFjMHBkR3Y0dkpjcVM2SlZw?=
 =?utf-8?B?SEE1eURuS0t4ek93MmF4ZmtRRnRtanROK21aWGRuOEdUNmhqcFdHb3EwU3hh?=
 =?utf-8?B?TW1jRWd3NEpNc3ViUWJHS1k4RnpjcDZlbGcwdE11SDRXdFJyUGtFTGk4VVVR?=
 =?utf-8?B?WjBBK01zUGZvQnZNQ29FaTJyVkFQQlBwc0pnaDBBdGxzSi90aUNwSFFrWFU0?=
 =?utf-8?B?WFpqWWJvTVNRUDhyMDhjYkRJQk8vT2djc3RLY1dGenhoSGdzZitLNE1NZU1B?=
 =?utf-8?B?STdzcmFKZDVoS3gxZjFGb3g1UjdQUmxyRmtZbjc4VlN6TGxzbDlVbnRHckVK?=
 =?utf-8?B?K0lPWmNBVGZUcDQyNEJkZ3RIcUxZNmt2ZGZoTmF1RTFSMFpBY01IVnUycVN1?=
 =?utf-8?B?dVRzMHdXRUFuc0xwemsyNkVON0htV1NNM0xZeUE4WG15Mmh1SEU4TTlraFdD?=
 =?utf-8?B?Y2lJYnFnWjZlUGhuN3k1ZWpmd0paL0NPUW9oMk5oekQvbkMxNkZoNDF2di94?=
 =?utf-8?B?Q2NLUzN5dDErMjBmUDB2cTFKMUJPN3EyTzMyUllhc0FBNlFtSVNuTUZpMzBq?=
 =?utf-8?B?d1k2bEo1NFpETXJJTE1mcFBjd0pKcDd0WjB0RFl0ZGtCSTRodm9DYzJqWFZh?=
 =?utf-8?B?dlFEMk1Zb0E4MTh0cmQvRWJGcmFNTzNveUZ5ejk1NlBXVTFRWDhCVE9xQlU4?=
 =?utf-8?B?dERGY1RVNXJuUGpJU3dzWDlyUWlPTjFWMnlNOFZLdkRDa3gwc3JtOVUzWTBV?=
 =?utf-8?B?WjE5eDBJZy9xSUFHM3NtY0J6VW5MSnpIcGNsOWR5ZGd0SklIbEpkVDZyTUpi?=
 =?utf-8?B?bzVnY3BpTVVwVFdXMGFrNzh1azJkbDhENlJ3Y0hNbWovbzRXYmF1WHMvZU1S?=
 =?utf-8?B?U1BwMkRPdWZkZ1EzSnVDVHFsOWlldUJZTCsvNXBweWJjQ1NIdTJ6YytsU2hs?=
 =?utf-8?B?elNtdEN0SUx3ZDM2aEdta1Q4T0pwM3VqYXNIOVRBYXpRZko3bG9KZ05oNVFj?=
 =?utf-8?B?ZFpkWnl0Mk01L05rMDNIT0pTTDZDZGdmQ3R0Zk5QbG9DL1pKRXpYRE54NGkw?=
 =?utf-8?Q?NcgNH45G7DIh63ONc46EKxB1b?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b83ddc95-38b6-4a7e-77a8-08dd5124748e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 20:31:57.3713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6sDnilthsdoSGG+EgbmZ+79XMEYpD2bmUjq4S8/dQ4CxjVYFjzAeBDHEb9RPVS77sCdaVrmRnCCWFTE3hq7ahg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6802
X-OriginatorOrg: intel.com

On 2/19/2025 12:10 PM, Liang, Kan wrote:
> 
> 
> On 2025-02-19 1:41 p.m., Sohil Mehta wrote:
>> Architectural Perfmon was introduced on the Family 6 "Core" processors
>> starting with Yonah. Processors before Yonah need their own customized
>> PMU initialization.
>>
>> p6_pmu_init() is expected to provide that initialization for early
>> Family 6 processors. But, due to the unrestricted call to p6_pmu_init(),
>> it could get called for any Family 6 processor if the architectural
>> perfmon feature is disabled on that processor.
>>
>> To simplify, restrict the call to p6_pmu_init() to early Family 6
>> processors that do not have architectural perfmon support. As a result,
>> the "unsupported" console print becomes practically unreachable because
>> all the released P6 processors are covered by the switch cases.
>>
>> Move the console print to a common location where it can cover all
>> modern processors that do not have architectural perfmon support.
>>
>> Also, use this opportunity to get rid of the unnecessary switch cases in
>> p6_pmu_init().  Only the Pentium Pro processor needs a quirk, and the
>> rest of the processors do not need any special handling. The gaps in the
>> case numbers are only due to no processor with those model numbers being
>> released.
>>
>> Converting to a VFM based check gets rid of one last few Intel x86_model
>> comparisons.
>>
>> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
>> ---
>> v3: Restrict calling p6_pmu_init() to only when needed.
>>     Move the console print to a common location.
>>
>> v2: No change.
>> ---
>>  arch/x86/events/intel/core.c | 16 +++++++++++-----
>>  arch/x86/events/intel/p6.c   | 26 +++-----------------------
>>  2 files changed, 14 insertions(+), 28 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 7601196d1d18..c645d8c8ab87 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -6466,16 +6466,22 @@ __init int intel_pmu_init(void)
>>  	char *name;
>>  	struct x86_hybrid_pmu *pmu;
>>  
>> +	/* Architectural Perfmon was introduced starting with INTEL_CORE_YONAH */
>>  	if (!cpu_has(&boot_cpu_data, X86_FEATURE_ARCH_PERFMON)) {
>>  		switch (boot_cpu_data.x86) {
>> -		case 0x6:
>> -			return p6_pmu_init();
>> -		case 0xb:
>> +		case 6:
>> +			if (boot_cpu_data.x86_vfm < INTEL_CORE_YONAH)
>> +				return p6_pmu_init();
>> +			break;
> 
> We may need a return -ENODEV here.
> 

That makes sense. See below.

> I think it's possible that some weird hypervisor doesn't enumerate the
> ARCH_PERFMON for a modern CPU. Perf should not touch the leaf 10 if the
> ARCH_PERFMON is not supported.
> 
> Thanks,
> Kan
> 
>> +		case 11:
>>  			return knc_pmu_init();
>> -		case 0xf:
>> +		case 15:
>>  			return p4_pmu_init();
>> +		default:
>> +			pr_cont("unsupported CPU family %d model %d ",
>> +				boot_cpu_data.x86, boot_cpu_data.x86_model);
>> +			return -ENODEV;
>>  		}
>> -		return -ENODEV;
>>  	}
>>  


How about moving the default case out of the switch statement as shown?
That would make sure that the unsupported print would also get included
with the -ENODEV.

	/* Architectural Perfmon was introduced starting with INTEL_CORE_YONAH */
	if (!cpu_has(&boot_cpu_data, X86_FEATURE_ARCH_PERFMON)) {
		switch (boot_cpu_data.x86) {
		case 6:
			if (boot_cpu_data.x86_vfm < INTEL_CORE_YONAH)
				return p6_pmu_init();
			break;
		case 11:
			return knc_pmu_init();
		case 15:
			return p4_pmu_init();
		}

		pr_cont("unsupported CPU family %d model %d ",
			boot_cpu_data.x86, boot_cpu_data.x86_model);
		return -ENODEV;
	}

