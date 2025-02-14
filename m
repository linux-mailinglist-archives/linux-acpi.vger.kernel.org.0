Return-Path: <linux-acpi+bounces-11181-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCDCA352E1
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Feb 2025 01:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 511FB3A9517
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Feb 2025 00:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1C8275409;
	Fri, 14 Feb 2025 00:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BV2IlKHo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155CD2F46;
	Fri, 14 Feb 2025 00:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739492976; cv=fail; b=uCs63p37/w4mm5Ciza5n7Mm2gWY7kz34qgf7GPSYix9nv7TUpwJxXQ+v7f+nH0XHTG1lRjqDBRjWov5u1r6SXnbgx/TaHX0prvZ1yNy3TBaEC4E5BODj3aWDSTu7eu4J1gcFZsHWdekfGJEK44xT9ItsRL/WcDiq6P9PFxuLdKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739492976; c=relaxed/simple;
	bh=6QyBxyPpcIDJb5xbZ0vtJ/1XRl3Blmm6lc5Cq+VbwKM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RxsI8yenb2PsAcY2gcj/1KDa2ckiq+BdCuwqIxlKSoomp4MDEZC41VERrxGdlfC9eRwESE9V2EKGxdWNxfhsvfyprJ+NxraAt5+SmjSccPMZsPkYUx7T9udHWOx6UyTATBOq9UCihUnQq7Ke2Y5JvOpMdnIPAMmurxj7dcag380=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BV2IlKHo; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739492974; x=1771028974;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6QyBxyPpcIDJb5xbZ0vtJ/1XRl3Blmm6lc5Cq+VbwKM=;
  b=BV2IlKHoS97Uhc/k9NAoj/GtgfI7WRWOsLvRlUMLVCkJYev9xD2lBO8t
   5HJ0eTEZ6GrFhdgXoDhHcJ0p88NWkHGECsDfKO9uHx84zYiiNUoluoN+3
   fcmhBqm8SW1Lalk6fvMgQCOJUDQbAg/gL9VvENrdL2WY9FWvTX3Lvz5zW
   gOYAchzyOoBNsdNrXun12zChBICA2tnjU5zRN8WvJXJ/t+KipvoZSByyK
   VyAR1Hu6/esrNM09cdzLAW25LJyof5aRC9s6txp7vhsmf0cp6FbPfx7gl
   ct/dVi7rsrQVSEgG1F2XvGj0nKfOr0tPos4w3YUIxCl6a6TFK93SJ0jac
   A==;
X-CSE-ConnectionGUID: URv82oeSR2aR+4b1IWHJtA==
X-CSE-MsgGUID: eIsRTauIT1221IScuEclDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="40486602"
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="40486602"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 16:29:33 -0800
X-CSE-ConnectionGUID: /VhFZFY1SgquQZ1bXAcgAg==
X-CSE-MsgGUID: HiYdAOYESuybMbehUVxPTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="144168032"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2025 16:29:33 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 13 Feb 2025 16:29:32 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 13 Feb 2025 16:29:32 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Feb 2025 16:29:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MIkc2BK3IKLBM9WpU+i/gLRxOq0TidC6+R1YdjMW2qRN+jhfBNS9YtuAI3zF3YvrvXuEXuX3k0dR2vE0qnn0jNmJsMRX9C6KrclPWlN1ZuQN04YZUnorqIVmOhmXDBvp92jrSGg6Q5VTfY8Zhe78147HFRONxI76gB7lKXiIZ4EU5XvghiM78fksrDaVpXcjtiZWd8qJYvZsTCvqk1x/K++exqueRowwVDhxTzvceh0w4DsTQ29T/xoXN9hhHSNkfe8aJS593yuVuGlLgPj/+4nhqfqXZCM1oqStZg5o0cpgjWde6vjeJkIkAO4Zn79FOS8aI/R0xBtvNy+jeqDmjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SM71QmjQN4HTbTB5fUJpvQtp13i+QS81pKAggVNxRvc=;
 b=oeGKP2W60+3DuJ/V7x7MAGfv2FyHAuJ6wWpHt6BseZ5jbXzGmc9sXhsJV5HGUj1fZz0vh+QnW+YyvfSl4AQNVprq93eUPOrdicvUanxbezAXhTbivJeAyEek1K8LPQeLO31jE0kKNrsc0Eei6NgGQHvl6ZG2r4b3B1tnJOs7kFTrlt7mZYoS9nL+eOKfJKDaLwqWvx4ggtJJ3L+S3EPPHZo9eKc2JE0lgkqfx64iRrWfwDDzNgE5y5UXy3OntXs7kZ9FIlcr81jLyPU1/eCD0cqe7sxI3aIYqD8TQg7AaMXmMjCZ2/CMZeUqGbg74KRGoIbMSVJml4E6f727WJL3Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by DS0PR11MB7786.namprd11.prod.outlook.com (2603:10b6:8:f2::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.11; Fri, 14 Feb 2025 00:29:30 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%6]) with mapi id 15.20.8422.015; Fri, 14 Feb 2025
 00:29:30 +0000
Message-ID: <066c8d9b-05fa-4380-ab2c-91a5e1475021@intel.com>
Date: Thu, 13 Feb 2025 16:29:29 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/17] x86/cpu/intel: Fix page copy performance for
 extended Families
To: Andrew Cooper <andrew.cooper3@citrix.com>, Dave Hansen
	<dave.hansen@intel.com>, <x86@kernel.org>, Dave Hansen
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
	<rui.zhang@intel.com>, David Laight <david.laight.linux@gmail.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-hwmon@vger.kernel.org>
References: <20250211194407.2577252-1-sohil.mehta@intel.com>
 <20250211194407.2577252-6-sohil.mehta@intel.com>
 <b9c21518-54fc-4907-8fc3-d492a3f33bdf@intel.com>
 <2299c94f-aa46-47b5-bd25-9436a8fbd619@citrix.com>
 <90eb900b-0b75-4c0d-be65-a4357729e5cd@intel.com>
 <445ccf10-5ac8-42aa-ba09-5f4ba689ec19@citrix.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <445ccf10-5ac8-42aa-ba09-5f4ba689ec19@citrix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0224.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::19) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|DS0PR11MB7786:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cbef6e8-6b08-40f5-2171-08dd4c8ea570
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NGpWcWZlNHhMaUJTQjNlYzYwWGNZa1Z3MGxtVFBTdWRtL3RyZkl0Rlk0L3ZE?=
 =?utf-8?B?Rm1hYlBYV0pVZFZxSDlOWWIzazlmcmsrbzBZdHZlbmhVQW9mVktVb0xEWW9M?=
 =?utf-8?B?UXhBZG1TVmowN2ZSM01wSzZ0SE01WEtRMnQ5SmxtU2diVHJLbGt2L2tENmFj?=
 =?utf-8?B?UEswajVBTCt0U3ltYlk0U1ZpZWxwOG11NmE2MkxCaGJTMEViWHpLcGkwZytW?=
 =?utf-8?B?U2p0YXh3SGIyQ2thOHE2K0FmU0dSSVV4RkN0RWk2cEJ5azVPNzc1VDRMd1lE?=
 =?utf-8?B?Rm01bWhzcXJYbDM3aW5sWTBuM2FCWEpXWXpHdkFFSVV5WkhabklQT2Y2OTdN?=
 =?utf-8?B?T1R3WndBVEdrVUU0ZXpTVllyYmx6OVQ1N0NWQzdPUWl6TmZwdHhLRm93eVpJ?=
 =?utf-8?B?TjJITnJkb2pvOTJKN3R1dytrNk5aNzlVc2tDSUpOZ2FNNzY5N09ZQW1BcFNH?=
 =?utf-8?B?SmNRNkpXTnZBcEZYTnFVRmp2OWFOU09PaVJPc2QrK0dyQk1iRHo3TjJkVzls?=
 =?utf-8?B?TkhuUm12RlE3OVFUUVdJVUQ2dnNQVytCUTNZeFMraFNzUUh0SCsvdkpwM2Q3?=
 =?utf-8?B?cHQwV3V0ZDhJaGg4T0NPZjc0aUk1SGNYZTlpYXpFaW5GRlhOcGlpZi9qOHlo?=
 =?utf-8?B?NGh3NmNsclp2eUt5c0I4aUNHdExLaXorUlFBVFM2d0FDZ29OY3ZxR2loWkc0?=
 =?utf-8?B?aW95RVh2WHRqekNxRXJiZktGQlZqYnd5N2tyZnRZVEpMZTRKYklzcHY4WFZi?=
 =?utf-8?B?RW1vODdwaytwSEhxaUxRYXJ3cURKdDBOZjdWNzEwbFNXb1pmMlRTZ3NRYXNa?=
 =?utf-8?B?ZkF3V2NFa21BbXU4elZkWWlKeXdSWjVUUXBpQ2x6NjZwUWRjNDZ0MWdSYVBp?=
 =?utf-8?B?b3REU1JjTTg5OFNJQklkTjIvSXpqYVFVQU92TEZ2RG9HOFBmNG01QStZTVZh?=
 =?utf-8?B?d1o4VHRjM2Fhd0NHdnNGM2Z1TGRrR01vaEhiQ1RtUDJ5WTk4VlZhSS9RWDQ2?=
 =?utf-8?B?K20yNDZQZVMrR1RZVTFEZCszMjQ2OE1mbjBNMm9uOEhua09yV05SNmZ2VzNK?=
 =?utf-8?B?MFI5aXNrM05QY0VzRjhLQmlZTHZtZ3lQOXBrZkxkRTcyN0VYZXlvb3BMK29k?=
 =?utf-8?B?YlZZS08zRTFVWDB6cTNycnJGTmFadnhjNDdOSHQzblNKUzUveStOd1c0T0Mv?=
 =?utf-8?B?aGNaVSs5SmdlMVJ0OHJDWW8yT1NMa2dSaXJ3RUdKRU41Wk16aTYyL1R0aW9M?=
 =?utf-8?B?ekRPRkFWMHZscXlNbXc5VG5OQTQvRUlLbUp5SXNIQ1hhazBGamc2WFd3YTNG?=
 =?utf-8?B?NFl0UUZVaGZ0dVhRYlR5KzNzRWVlcjFyMmNjUjdiTHFDTk1VRUVWcUd2eFNT?=
 =?utf-8?B?eGVoekNlTzVRVWdTWUdGMTBDZVIwSG9WemZscVJkTUovdEZrWVhpZGdCUWVV?=
 =?utf-8?B?NzR5dEhoQ1JKaERpU0NWS0FOdUZLQlJHRnFXUDUwZzRvVE9ENkY5bGw3dmNJ?=
 =?utf-8?B?TTFjcEsxaDVJcEM4TjZ0RUxncHpSY1NJYVBsaWRyL1FidXJwVWlNaDNBY1Uz?=
 =?utf-8?B?WHFId0UxcC9nQXFvZkFVSGQyazJCUFFhNHpEeUsrM09uTGpwT2VQUXFDL3NF?=
 =?utf-8?B?bGRrbDZKbU5BQWFQa0xGT0FwYWpzUlptUWwvcHoxdW4xeGw5QlNPbnNCWUVC?=
 =?utf-8?B?Nlo3bks5TU9jOEkwcjNrUDl0dHladjFZVUlDV0VreHQ5TkRHKzlzbVI5Q3BS?=
 =?utf-8?B?UU8zTERSU3pleHlISU00NmtIbXJCcHhac25EQXVkMkhaRnhuVENkMU5LOS9n?=
 =?utf-8?B?RlUrY2JlSVcwcnZiOHlja2x4WGNhNWtiN2FTOWFnc21LS3BsUDd4YTlPMGpi?=
 =?utf-8?Q?bs4WtdRSvwHuG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlV4S1dETS9mVGxjNC91ZzJ4N0NzbzdSS3BlaXliemJNait0S09lRVh4MEF2?=
 =?utf-8?B?aXRpenVCbitoczNlTGNBU1QvVitQMVAvUjNsakNUb1hrODBseFJ5aTBzTEFl?=
 =?utf-8?B?eHVJZHliSzBWZHM2MUpiVUQxTURDblVpRlZnSFhlR3ZmMmpOVWRFVXZWWFdh?=
 =?utf-8?B?UVpEQjBPQmZ1SEhyZ2xOeGI0Y2FYOXVKR0t0Wkh0UzFTbVhTNStUMEYwV2dH?=
 =?utf-8?B?ZnVvTUh2TUt5L3FtVmJTMGNYUGExZ3FyNjlPRVN1SzdabnhQZ1pQM28rakY5?=
 =?utf-8?B?bVVmQ0ZEQ3lQZ05VUm1nN2VXM2l3d283WnEyUUtSbkhONFJsMkpqeDJyZC9s?=
 =?utf-8?B?QnNsYXpjUk5HaFhFRDZnbEJ5V1ZqUGk1YVRsY3ErQzNuSW92eUFsN3BnTWZN?=
 =?utf-8?B?N0k3SXZLblNYVUdsNmlrTnlHOFBWTkRjMTY4dkI1MjM4cnpvN2hUeWVQWng5?=
 =?utf-8?B?alhoZ1FqZDdyMnZhendCVUttUnZVL3ZkajNDUm82Y2M4L2lKSkp4R2VsVXBR?=
 =?utf-8?B?STB6Y2JBcDFDVExTdjlFWnNsZU1hS0VHTTdwMUhWQmJXTy9KbGgvWVRuaW5p?=
 =?utf-8?B?cnlhVElpd0FVdXZtQ0VYQWJkY3RQOGJTQUZUblFWY0NuOUtOSEM3amhZUXI3?=
 =?utf-8?B?M2pzSy8vNWFhc0t5ZmZxZStPektlVUpEQ1dpRWlxSWFrMUlwWW1iNndIWFZC?=
 =?utf-8?B?RVF6N3h4TTkvWWxZeXhmQnMyajhVQms3bWNVYUI0Q2hiUVlpRHNoanFGQ09v?=
 =?utf-8?B?L1BkUG5KdnBqeGQvMlNDbDM5djk0UVNndGMweVl3QzhtMkFVNUhZNVowV1lM?=
 =?utf-8?B?K2c0cXJnTGFnc3FZNnVlU1UxVUFpOGtwREpSRVVjNDVnNE45dU5yaW40b0Vy?=
 =?utf-8?B?SmRHZ2Ntb3RCWEFuR21yZ0hWSXpNdVFIdnI4ZUV4ajFWMDN6RXo3ekZWWTE1?=
 =?utf-8?B?azY3UmlSOTNHaVZ5UE9BVkZ3WGtXQS9PbytZZi8rREh1eTYvYmYzYUdUa2oz?=
 =?utf-8?B?OHV5K0tON2JLQVYyTEEycitxRkRudEV2WjZMQ21pWC9TMkdpc2tFQUZMOERN?=
 =?utf-8?B?M0dJRWdYZGk3elErVlNPdWhlTlFCUFNDOUc0Y2NpRFhWenkvYTQ3S0xWNWNa?=
 =?utf-8?B?bnc2NmJCY1QvMjFmbjdhakdMZTFjZTZSTGFwTGsvM0xhS1BxNEFvYmN3Y2o2?=
 =?utf-8?B?LzhBUUhkZVVXbkx0dFlqL2hFUmNKOWlJQ0hWNWNIT1kxUW5yMm9HM3Z3aEdX?=
 =?utf-8?B?Z1BrUDBIMXVvZzEzbmRoQXZ3bGdXS1VXMDRPSkxsKzlVSE03RFZvSiswazB4?=
 =?utf-8?B?bHYvSTg0TFRtbGFWWmFUTjNmdnoxaHg5VTNjZDM0dml6SFFlNWgraHA1UTl1?=
 =?utf-8?B?elZBbFZnRWtnbmNXbGZhS0dUYzZjb1IyNTAyZ3RWZFpCdG5kM01PZHVlcFh1?=
 =?utf-8?B?SWs5SFJwbEZDcG9uNzhXaTNLVDdrbUUzeGc4QTIxbFRtcXVBem1TUTBPb05Z?=
 =?utf-8?B?cGhya1V5MHRiUzBhU0xYZFNPdUNMS3BEU1F4cUZyczhRdDllMG9mOEk0V0lD?=
 =?utf-8?B?SVMzbHQxV21RcDZJa1dOdmZqbnJINjVnY3J6ekRFcjl1S0R6Q250WVRBa3hP?=
 =?utf-8?B?ZDg1T2Ird1QwVnBpbU43Z2c0ZzJEQ3B6dWRSekltU1RCVlFDS0Vmci9hUGxz?=
 =?utf-8?B?L29ZdCtLc1BNaUtmYkFTMEp3R2w1REhQT0dpRUNjNmFiTUhGR0JjSHBGSHV1?=
 =?utf-8?B?NGFQK1ozLzRNZEgzZGFIRFpRSzRJZlpCS1ZlN056RjR1RUNMWlc3UUtIZW9J?=
 =?utf-8?B?TGNyWkROdW5sQ24rd2ZYWkFYOVVnUEtieHd4ZzZNOTZWZzNFZnJXSEYvbnFP?=
 =?utf-8?B?QnIxL3lkS2xKaEc3WTR0ZURHakdpVGpBVnZ3N3c5UlRhbmhWQ3dtaFMvc3ZR?=
 =?utf-8?B?VHREM3dqQnZpdEVQK21NOTlIRjJadjNnUW5Rd0U2aDArci9Vck5LWVBaWkth?=
 =?utf-8?B?dnl6T0VKM0JvTWNuMlZLUXI2UWxRL3MxYmFENXNBc1B4K2dxNlZTNXVUbVla?=
 =?utf-8?B?TFlkSW9zbUxVZ2xRVUwrUmpCTkR5aFdHZFFRVnIxZXY0U0IrV09hSGMzSXNO?=
 =?utf-8?Q?49APZitAjJq4uotZqUHo+pK2d?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cbef6e8-6b08-40f5-2171-08dd4c8ea570
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 00:29:30.3315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UUdvYH7hPKbYO4JTbBco7FIgT0l4hkif8iuUhzJe0+RaMUuL5IqqqwWwzCXXWy42kZvutcYtb+hh8YTegkFqBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7786
X-OriginatorOrg: intel.com

On 2/13/2025 3:02 PM, Andrew Cooper wrote:
> On 12/02/2025 9:19 pm, Sohil Mehta wrote:
>> Check 1 (Based on Family Model numbers):
>>> /*
>>>  * Unconditionally set REP_GOOD on early Family 6 processors
>>>  */
>>> if (IS_ENABLED(CONFIG_X86_64) &&
>>>     (c->x86_vfm >= INTEL_PENTIUM_PRO && c->x86_vfm < INTEL_PENTIUM_M_DOTHAN))
>>> 	set_cpu_cap(c, X86_FEATURE_REP_GOOD);
>> This check is mostly redundant since it is targeted for 64 bit and very
>> few if any of those CPUs support 64 bit processing. I suggest that we
>> get rid of this check completely. The risk here is fairly limited as well.
> 
> PENTIUM_PRO is model 0x1.  M_DOTHAN isn't introduced until patch 10, but
> is model 0xd.
> 
> And model 0xf (Memron) is the first 64bit capable fam6 CPU, so this is
> dead code given the CONFIG_X86_64 which the compiler can't actually
> optimise out.
> 

Thanks for confirming. I figured this is likely dead code but wasn't
completely sure.



