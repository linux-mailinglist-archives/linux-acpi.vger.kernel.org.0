Return-Path: <linux-acpi+bounces-10287-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 777C79FB68D
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Dec 2024 22:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCD7A165F89
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Dec 2024 21:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77B51D619D;
	Mon, 23 Dec 2024 21:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l8t1uh/2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE521422AB;
	Mon, 23 Dec 2024 21:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734990961; cv=fail; b=JVasysNic+CGx/HSZuQpJ4mYeaxvNzRAFDUh4ylZ+PbphOtIEN/ruGf4KqstW8J+CX/XFKcvEwGjNGwKHCbR9mhZVdrFRCd2mBeaa6doq9Cl2WflRrgfUTPkFRJY68SlOVQLPOQG9uZ7I5J5K8E3v1qwyncewxqr+Cnvz5v2MYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734990961; c=relaxed/simple;
	bh=MQ67PYv8lvq/UQQPyKSNLkERn1rbLC+M8s0DKPu0xIw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PJnnmXCvomB15o6o5pbZLixr8VkMf/z55wEuoucZ8r4gqpT8fGRcLyukzpx4ymV66zGKPbc3muyTD3sAJnEIc7zJ553sB1AH8VeqarCX8oDUzn4Hc4yjNWtueYXtAxAjlKWfZIHwpk+HOecFN++eJAZDUViEj3TaA+gqRc4bLa8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l8t1uh/2; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734990959; x=1766526959;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MQ67PYv8lvq/UQQPyKSNLkERn1rbLC+M8s0DKPu0xIw=;
  b=l8t1uh/2R+eOirMqKxkPCVQT8wATSndEqjGEI4dhKb9k1Tw3pceCE6o4
   wXN/CHoFjSAN+toqW4xNdyvqyGl5DXHy4PtW0S7oPqpbu2s60NwEE+lxg
   SWz5dOivBelhnJGZleQtWOHVsRUIF8dlpjbz8XYOgIDCDSaOs/+IZs/mX
   vPwe+SdGxmtOxdcxQnO6nCQMOdyJmXlC9urXobwykvHAVQkUUYBap2jj+
   bWLeb7N3IOjoSNNw92dhS+P1b3y5Vu9bsrLqADgCUifKypOnvjqu/9OaF
   s+k3cYj20i0Ih3a7V2tI7244jYc9PIMngwhLBNahL1tmINAW3bn33jZV7
   A==;
X-CSE-ConnectionGUID: OXn3MeY8RoqpCixuV26PRA==
X-CSE-MsgGUID: DMjgxF8ESxacWFVldcgpBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11295"; a="52993611"
X-IronPort-AV: E=Sophos;i="6.12,258,1728975600"; 
   d="scan'208";a="52993611"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2024 13:55:58 -0800
X-CSE-ConnectionGUID: 88EWWelIQSy0guwuucR0bg==
X-CSE-MsgGUID: uLVlwrhcQVuwZrxfuu5C5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,258,1728975600"; 
   d="scan'208";a="99069011"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Dec 2024 13:55:58 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 23 Dec 2024 13:55:57 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 23 Dec 2024 13:55:57 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 23 Dec 2024 13:55:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rWU3Sh+aNRiaOiNpBqdbe8j4KUInKJRa/1jrfKU9M/Chmb8r091yPn13xXDhwS2l5Pu7vtS+/F7D58flsnTmRx4VhvOnpF3XxdXYFodQOMnPmdYIIxlgjk9ebvFc9pmzvicx3qbMcsQhcQeMdNFmSQtE6+uoOK9l80PGoGHkSYk0XzGNYNICfp10X1RjELXUoCYwBXzo53BFX02wus7LS+mBPxPma+hpRleARpTWHPSjxkji+Yw4BO9mcnOs88YOhUr4wloC+Kriou5HeUyH5LUc5BZnZTcBLKj+zSe6XTpG/zEAuZ7xM9AzF3jvwECTDZXbmlLmrU9F9/2B9LrMFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4OngykJymkd2KWGAQlCcdKYaALTMj23aG6yeI9OgDK8=;
 b=drtcs7wbqjx9Zsu3U6KXxhb/JN0hvYRt4LcCy/1xlm3IhixS0HfLk7Cvqmr80cGyOtn50RLp2H4/qj3AWc80c9MEeJKDCH0kV/8/rszn6/usQ08uVtjCUlEfvPmJ+1UvEec8MwTyCDyk7KOn0xE3aKY4MlWBhI7O3U/9SvKDlRdhT8ZbXHdu8rfjKOOVNlhIO/wkWte9bzJiUTwr/pbGfEeoyrz//41M/Bib9KpZi/Ls5y5UEWTPgZ71IrJ4fyMGmC3rKkyPqAeQEfx7QhMezTpNTXAtUnQ/lSh3urCJpm6zpp7kkXj/U76pZbClmUpm1L8cSk22XRXs8/aUIHtABQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3322.namprd11.prod.outlook.com (2603:10b6:5:55::19) by
 PH7PR11MB6794.namprd11.prod.outlook.com (2603:10b6:510:1b8::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.20; Mon, 23 Dec 2024 21:55:11 +0000
Received: from DM6PR11MB3322.namprd11.prod.outlook.com
 ([fe80::fca4:6188:1cda:9c1e]) by DM6PR11MB3322.namprd11.prod.outlook.com
 ([fe80::fca4:6188:1cda:9c1e%5]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 21:55:11 +0000
Message-ID: <74e6ec51-4475-40ec-9803-633378a5dcf2@intel.com>
Date: Mon, 23 Dec 2024 13:55:07 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 02/15] x86/apic: Fix smp init delay for extended Intel
 families
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
	<rui.zhang@intel.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-hwmon@vger.kernel.org>
References: <20241220213711.1892696-1-sohil.mehta@intel.com>
 <20241220213711.1892696-3-sohil.mehta@intel.com>
 <0875ab7b-0595-4195-924c-66da28074ef6@intel.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <0875ab7b-0595-4195-924c-66da28074ef6@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0279.namprd04.prod.outlook.com
 (2603:10b6:303:89::14) To DM6PR11MB3322.namprd11.prod.outlook.com
 (2603:10b6:5:55::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3322:EE_|PH7PR11MB6794:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ef23da4-4ed1-40e3-c761-08dd239c7903
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T0NhSmFVNWc2R2tuTTQwSnVNbHlKV01BbWRyYWJuWkx2VzkyRVJHZnJKbzk2?=
 =?utf-8?B?RDBxclRJcW0vZVRLS3ZBNjJ0Vkg4N2Q0bWtSbVJjb0JzWFlqdDhvQU1TS0dL?=
 =?utf-8?B?VGk2M3lueDlrSWorOWhzRDM3Q0JBbUVidnFBQUxnVjNxMnRlcnNyQUtQMVZ1?=
 =?utf-8?B?aEMycWM1ejRHZExXM1BMcndMeU56U1BxYjhSbWxoNVVMZzloczJsUUxpTVFs?=
 =?utf-8?B?dWdoSEZ3aUxxa0ZhanRkck1paFREWjFEUThYUkNESlJJbHRGeWh4Uk5IQmhP?=
 =?utf-8?B?eGFDeE0wcWJlemhNWkRuVmx4ZDBNcTRoQUpwSjVUVXJPdGJCS1hCa1lWMVpz?=
 =?utf-8?B?RWFGSHQ2SkxnMHI5TXBZUHB3L3JMRDBtL1FUZjhZaVRLWnJ3SUxVRVZhM2Vx?=
 =?utf-8?B?RURFZC9CZmhrWG1qK2d3aDBTbGNoQlhuMHh1ZERIWktLOHdYTUtOdUhLQk9C?=
 =?utf-8?B?TnRYZnB2My9NbkQ2cWdIeCszWktRcjBTTmlpMyttbFRhZmR0T0xYM3lpUE10?=
 =?utf-8?B?b1hTU1p0NHp5Z1RpRmFmeEhPU2VKNGVNVGIrMS9jeFhkY2FRTXV4NXJOMmdV?=
 =?utf-8?B?aExvV0V5ZTNMLzEwcnFDd1VrZDFVSnBIWWd6eDVxRnpwTHNWMzhBWEpqUy9q?=
 =?utf-8?B?eWkrMWhocjFHY2ZTM09lYldYYVdsNjBoLzFrU3hjRG9ZZ3RlSFhlMmZQZWM0?=
 =?utf-8?B?YWNKSWI0RkRFYzVvWTJQZnJVeHFTOWZJQUR5WHQ3bTJyVGpNVUp6aThyeVZO?=
 =?utf-8?B?dnBGcS9mS1RLM2FaTEtjZDdkWVYwckdsNUZsNW9UeDkrN1lVMG00a2YyNWpS?=
 =?utf-8?B?bXg3Y1MvNFRHMi9PbFhaQnI3ZHI1YkVrd25hS0JLVnF6NmxKa3RVS2lOYTZJ?=
 =?utf-8?B?bitsaXRxU1hYQWdBekVEZ0FKVTY4OUNzVVNqSE03RENPRHJsSE9zV2NUK0R3?=
 =?utf-8?B?MmFlTXBhSWRVMDVadG5kS2VCU2dsWHpjMms3RG9wQis2QSszZ1RUTThxMVVG?=
 =?utf-8?B?c2JFZ09PQmZoS1lldlRYUnM0dFdwYW9OdkE1d3BTWmRWak5QZ2RHanVJYXEv?=
 =?utf-8?B?N290anVZUW5RWGpabFV3RURJdkRRRUYyRktDYWlxK2VtVUFPdWVFN2FPTlRY?=
 =?utf-8?B?bHlrRzU5OUx4RWhYK0hZN1dJZm5YMlZ6Z1NoSXBKanN1YTZXcldIb2NOblVT?=
 =?utf-8?B?UFRyWXhZZkZOOEVwVTBwZy9Id1Nac2NkWjVLMjhZcjZyVTVRVXBZM3F2ZHJM?=
 =?utf-8?B?L0ZyTmI4dkp4UDFTN2RhNzZWS21od0hFNUNPdVhoakdOWVkyZHdrWUF1aXpm?=
 =?utf-8?B?Z3BWTkU5dFFmYVg3bElaSEs4THpZWlNMTGd5M2s2RU5oUEVKMkJLQVlqKzJU?=
 =?utf-8?B?aVdha1FvK0FVVStUK0krc1pPVG1HLzErRW9JUk9lUHkrMy9yTk82NW1RMG5J?=
 =?utf-8?B?T0UzSEVsVS84RmNWVE5KUzlUWHdFNnlhanl1alZ2eHAycG0vWVRnR1Y2cW1O?=
 =?utf-8?B?TmJPb0U3UTBpMUN1cDhVa3M4VGdMb0VudEYrL1lxU0ViOGN2MGJIUjdiOFNW?=
 =?utf-8?B?UXk0YmE3REdxQXZkUFZRMjlsMk9ZQjB4WlExeFYrK0FrQWlkTHBRVWRHeThv?=
 =?utf-8?B?bktZMXMzandtTW9ZMnhDZFJEb2dZR0J2MlFTeXZhbCtieVN1OVg2V2MzUjla?=
 =?utf-8?B?SEhIRTdlSDl5cVRmeVJhcmZ0d1l4TkRsMVVsd2QvV29pa00ybUhRKzdhT2FK?=
 =?utf-8?B?b0l1NXlSY2FSMzRwelUrd2hGL1R3YXlSU05rNEdOYWJrSnJ3T0NqWFppS2t4?=
 =?utf-8?B?eFI0cm9RTVdHT0lOeCtOSWhBWm41alQrQTAxTCtNTjNROStHRFFESWRmQTN5?=
 =?utf-8?Q?N3a6kWoIQCdBf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3322.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnpPYmlBckNjS1dwZndBK2MzVTBrcFNROGdFUUZ6VFNlY0VsdkFVUklKdlNG?=
 =?utf-8?B?d3ZCcTZYMlQ0SGFiNzUyMkt6S0xaZDVZT1B5bjhoeWhxTEhqbUg3TFFJaHJr?=
 =?utf-8?B?d0hJTTRvUVF1b2xUWGFEWlBubWdUQUFrdDFlZ3VxN1hQY05TeEV6eXR4bi9X?=
 =?utf-8?B?eVc0aWpSU2dVUGFUOUluWFZLOE8zWWdWVWJTb1ZQclNXd3pXUnZJbmN2TWcz?=
 =?utf-8?B?NzFpL2l5Y2ZSbHlWZ21kOU8zMU9mMGVJQ3R1VDA3bDM5Q2QyUDBBWkpjdlBp?=
 =?utf-8?B?RUJkc2pWTDQwMEZoM1hqdHJTVTUzV2FodmZRckE2dCtKclcyQjExRXdRcTNK?=
 =?utf-8?B?K0VxQVQwSjFscEwyYlZCMXI1NmJQMnpSVno0YmJoRWxrbXllUGdSWWEzQzFC?=
 =?utf-8?B?WTFwSFdyeEhiVzB5Zk56YWF5ZWsxa1dIam1EZDBQZkhRNFZjaHV6RWxKRTE2?=
 =?utf-8?B?cy8yL1F0T0FwUWVlZUp0SFNvYlZtWjd1YmRndnIzeklUZDlhZHkycnAybU1Y?=
 =?utf-8?B?dENaUWdYY0I3dHcxTzVnWTdEKytVLzZJM0pWbmNpODZEVktaaUFTZ1JYWHM3?=
 =?utf-8?B?djZRRTZOUnZJejJyUmhiSTZkU2xmYWVwSmxZRXgxTVpVZ2ZSQmIvTndjclVI?=
 =?utf-8?B?NDdEa3ZjdHh6UUV1dUx2OXUzcElMZThuSmJMT2tGZDJKU21uZi9sZENwS0RN?=
 =?utf-8?B?K3BCeC96enlteGEvUkIrUXlkZE84VW1QY2hSUCtoYlpMQ0dxSVdVdCtTQkdk?=
 =?utf-8?B?cHdiNEc3MDdYZVdrTDNXZ3NHaUsyUTZvRTd5bnAyblpYVGpFYjE4QzJpRlpS?=
 =?utf-8?B?ZWRLY2gvVVl6YWp5ZWY0TERTdXhXd2FDUWUrSXZBWk9BTTFBUCtvMzFVcUhI?=
 =?utf-8?B?Y1dpc3h2SVB5OTE0ZDhLaUhoS0g5UWpNVkhzMUpvTUN1NUR2TDNqdlh3VHBC?=
 =?utf-8?B?Nk1wTkhyeUhKVXk0VU1JU0hRdk5rVmNqNE1LRWRRajAvNkxwTlBYM2crMFBr?=
 =?utf-8?B?emN6L3lwSXhxYVU4d3AwVnlORXp2N1J3aGd4N0FWeHYyUk5sU3U2UEdZZmdl?=
 =?utf-8?B?YmVUeGs5Rng1WWd6Z2lBVCtNc2hUSVR5SGl3bE1GSFlZaDBKZU5XbnhNM2NV?=
 =?utf-8?B?UE54OUpsbzlTZHppQUUzRW5XZDV5YXQzQTFEN3Zwci9GNVRVS20weUZSQXJi?=
 =?utf-8?B?Ni9lTCtjaW9DbDRCbWtDZzEyQ09yZHdIU3RGeGRvaC9zZmYvNW9aUUNZUFBx?=
 =?utf-8?B?ZHEyUWlydytZdkZmaThSTjNCUm14dWUwSm9laDRqN25ncWtuSkRaT2ZWd3Bh?=
 =?utf-8?B?Y0ZQbEprRHdMRURtQWNTSTRXdDZWbnZmSm5PcmVnT0l2RTRzdVpINXBTNTJZ?=
 =?utf-8?B?Ym54YkZ6MjlwSTV0QmY3MTB5SHVDRDg0RFBUVXBzdlFrMW1naXc4dCtFMnhR?=
 =?utf-8?B?UWFpRGtWV3pybUJNV1BJRC9ia29hR3cxVXFSbklxMU1mNHRvcmptdDJnVERx?=
 =?utf-8?B?b1Q2MkRjclJNZ3RZbGMvMldXSVVkSU1hemhMOHBtdXIraXFPTlVPT1d1elN5?=
 =?utf-8?B?Y241TVdXakg0S3JpOENjbHZhNjhDSFV6TUltUUd3alg5MmRweUtEM0d4Z2Rs?=
 =?utf-8?B?VUp0OXU5L29DbDZydmw2d1FwY01ubHZlZEFsOGNBT2UrWnpCTVZ0VjRab0lI?=
 =?utf-8?B?SnFvZEViZGZ1ekh3UFk0R05ORE8wVkRPYVlsakJ2bmtIOXQvaUZnZHA3NU5Z?=
 =?utf-8?B?WjVFRE5ML1FUcE52UEJpa2Y5bkRaOWczZXdjNWU2VG04L0g2MlpaUE9qZGIz?=
 =?utf-8?B?ckJNaTEzdHNCcXBiODUwTVhtLzdKdlcxWXJBT2ZYdVFJdG82cXlnOVNxelRW?=
 =?utf-8?B?TDBVdDd1aDBMeVFvQm1mcm5RM0prUHVsS3lzU2FoY05ONENqd0huRjhUT3VN?=
 =?utf-8?B?YmN4bENHbDAwUnRHdlc3S3l3WS8yVU4wSUVnVjEzMjFPZVRQWnI5TnJWTXlq?=
 =?utf-8?B?R20va1BEV29HcFdxdUZ1alBvb2tKUS9iVWY3UjZSbWQvRWpOQ0xFMmppbnM4?=
 =?utf-8?B?MDZ3ams2V1BieUVSbE81L2U0TGMwTnlTOTZMeHFQQTlrZTEvU1lNenMrRWhT?=
 =?utf-8?Q?XNbG5XIA90hbTaIAQUD3WgNu3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef23da4-4ed1-40e3-c761-08dd239c7903
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3322.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2024 21:55:11.0660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A2TVYiXJ4pTh/fn1UEq64ku3BQLRBBWVZ3qsou9kj9792PqM1fXPYlakYK5PIUSZp7LOB7PzWR98MYsBe8Z/Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6794
X-OriginatorOrg: intel.com

On 12/20/2024 3:20 PM, Dave Hansen wrote:
> On 12/20/24 13:36, Sohil Mehta wrote:
>> The MP specification version 1.4 references the i486 and early Pentium
>> processors in family 5. 
> 
> Can you please elaborate on how this reference is relevant to the patch
> at hand?
> 

The comment above UDELAY_10MS_DEFAULT which references the MP
specification seems to be the basis of all the cpu_init_delay quirks.

I wanted to use that reference to justify that family 15 doesn't need
the 10 msec delay since it is not explicitly mentioned there. I realize
now that it's moot since the Pentium 4 wasn't released until 3 years
after it's publication.

I referred the latest MP initialization specification but that doesn't
say explicitly when the delay is needed vs not needed. However it does
say that later Family 6 models and Family 15 models have similar
initialization protocols.

"The selection of the BSP and APs is handled through a special system
bus cycle, without using BIPI and FIPI message arbitration (see Section
9.4.3, “MP Initialization Protocol Algorithm for MP Systems”). These
processor generations have CPUID signatures of family=0FH with
(model=0H, stepping>=0AH) or (model >0, all steppings); or family=06H,
extended_model=0, model>=0EH."

>> However, all processors starting with family 6 likely do not need the
>> 10 msec INIT delay. The omission of the Pentium 4s (family 15) seems
>> like an oversight in the original check.
>>
>> With some risk, choose a simpler check and extend the quirk to all
>> recent and upcoming Intel processors.
> 
> I'm struggling to follow this a bit.
> 

Because my interpretation of the code and the related comments is
opposite to yours. The usage of "quirk" in this context seems to be
inverted due to how this check has evolved over time.

> I think these are the facts that matter:
> 

The code says this:

/* if modern processor, use no delay */
	init_udelay = 0;
/* else, use legacy delay */
	init_udelay = UDELAY_10MS_DEFAULT;


The legacy/default delay is 10 msec and then the quirk applies to the
modern processors to remove the delay. This is the comment above
UDELAY_10MS_DEFAULT:

 * Modern processor families are quirked to remove the delay entirely.

>  * init_udelay=0 means "no quirk"
>  * Modern CPUs don't have the quirk
>  * The current check says "only family 6 is modern"
>  * Family 15 is _probably_ modern and just forgotten about
> 
> And this is what you're doing in the end:
> 
> Consider everything PPro and later to be modern, including all of
> families 6, 15 and the new 18/19 CPUs.
> 

That's right. We consider these CPUs to be modern and do not apply the
10 msec delay but the usage of "quirk" is confusing here.

I'll clarify the changelog without using "quirk" to avoid confusion.

Am I interpreting this wrong?



