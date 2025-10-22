Return-Path: <linux-acpi+bounces-18124-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 897C3BFE1B8
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 21:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 47D9D4E0F8B
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 19:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EA42F7AD0;
	Wed, 22 Oct 2025 19:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZHaTRFhn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65A02D0601
	for <linux-acpi@vger.kernel.org>; Wed, 22 Oct 2025 19:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761163103; cv=fail; b=l6n4kcdZd+JQyd+f8TQwrlG02aDnjLzjFCUmHowk7rOlS06dWIYUO4EUhmIjmtQ2zy1bc8UF+5+4qf1ttQIMRQMcBDk7S95h2x/OD1jLUUIE8eXmGeVXvydMFjH1aLq/X0PxvlEQV1dsrA6/MOlhixJFr36zdCcuTEjLtpOWcsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761163103; c=relaxed/simple;
	bh=IaHmCNNJD5nrLlOIFagGEeWpQ2kJlbD3Nzi2Va6AR08=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SW6Sc3QEpitm6ubK98Mnkrj0hf8NnCAnaAx8LAwjnMpGmjuZ06glIasi5TSCdS2ntFI18/Xn2rmhybspTn2cf4HCwc48FwGpEqq3S+rUa/BirlD8covYqxCyeyH8e+6h8Ul/xK7MM1L/AHg54vCkXCNa7UxV7r5/quljY5e2Z5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZHaTRFhn; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761163102; x=1792699102;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=IaHmCNNJD5nrLlOIFagGEeWpQ2kJlbD3Nzi2Va6AR08=;
  b=ZHaTRFhnOS1k2GMWSCpz0OomIGf3DAi7SzS9N6KvQ5jr7yYHDE5z0iFe
   zNezzFwKgmMKelH0PcIIo3035c/bbOwKiU39Q+sbFKDQUwU70HHOx7P4M
   GpxfaJuf0t72i8LMlZPczRCYWM6latWGvY16aUxfCk32S2nujqz1OP96H
   NWVc71RJ4xf1rFks0iMmLmAtftQgdtHBs00E1Kb0LYufm+jCNheidYpsp
   dbKcNGM7+vKxmgjrO5S19MZMbDh9elzDf8d5/BXapPwH2GqeMUnwdI51w
   I+lmaRJXekdI4qY0gBUAT6tjGLbkRkgmFlIYj1OslYkF1LJGqqdTpKibI
   g==;
X-CSE-ConnectionGUID: f1kcELlrR5avWgXGhfR9GQ==
X-CSE-MsgGUID: fdDxdvx/QPuGZPb/EXAEoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="67159614"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="67159614"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 12:58:21 -0700
X-CSE-ConnectionGUID: 3ivFE1XHR6O3xPP0FjhjHA==
X-CSE-MsgGUID: 11SoyYzuRh+RZh5gkY5ufQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="183900961"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 12:58:21 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 22 Oct 2025 12:58:20 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 22 Oct 2025 12:58:20 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.39) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 22 Oct 2025 12:58:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l9v710xTaly6irnAZZYEYZEXxAtPVHlrwBmHfE3Fa1sEJO2d1JLsuHasuuND8tHIiFIdfwc2gZzWgklQu6JSeGWSd3KXlvCLIWlckD1YnuN3StzxjGR0jSr9DnuTgvQlGaO24ca0rXueklxcZvdzoyIYju4KYxD4cHMfyUEYFamK9ahY8F9SRS6Hnl/80rb5BAexEXx1WNh9VPSbP8iIekW97JqLcqQnuDYXEXdaUvhTAhW7Vdin45OOqoAfd9uCWyozu/5kf9ke0d4JZi4CdHekPSeVpvTR2aQT1KWeSMZu69n7+XtHY1KZTiRWcLTmb5kuhkpUrBjqZJ1FfdepuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oe+nfSO+xP4ICgO9l13QF+8a8dmzIYlg5qG6s4FvH9w=;
 b=PzvvckGyHx7fdE+TA744pvcFew9PeHj6oRyc+GZW/wpUqNKb9HgTHw5V+GhJm5cXYdMvo327yfT4CiSlwnpfeCEGPUbZ2PZlm5aw5Q2nip+HOp3adn72FHHg6lzHFMSO7BlFU2QUPXB8kzov90+Ba24AMj13tbXcR1GvWEorIg/1G6Qgw6/P3vrnfOf5imFlIZAhYtyiGURhkM+59AWdl7RaU2uahac6EhN9uit2WPaVFWWTz5iUvsk6koOsP1zXD7rb0fWfLIVpoRCK4l4zPuuRW2fpz8JeqKSGMcDne/HEdQR/xDWUZENeGJSuGNJbjEBKGm8g6Psru2WaUwMKYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6077.namprd11.prod.outlook.com (2603:10b6:8:87::16) by
 CH0PR11MB5233.namprd11.prod.outlook.com (2603:10b6:610:e0::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.12; Wed, 22 Oct 2025 19:58:13 +0000
Received: from DS7PR11MB6077.namprd11.prod.outlook.com
 ([fe80::5502:19f9:650b:99d1]) by DS7PR11MB6077.namprd11.prod.outlook.com
 ([fe80::5502:19f9:650b:99d1%5]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 19:58:13 +0000
Date: Wed, 22 Oct 2025 12:58:09 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Kaushlendra Kumar <kaushlendra.kumar@intel.com>, <lenb@kernel.org>,
	<linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] ACPI: mrrm: Fix memory leaks and improve error handling
Message-ID: <aPk3URcrjx_KjkJ7@agluck-desk3>
References: <20251007102237.1015610-1-kaushlendra.kumar@intel.com>
 <CAJZ5v0jr4yNxGD8Zhcotqy+6acmh5MeNwVQWYzaWSxKMsP0fzg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jr4yNxGD8Zhcotqy+6acmh5MeNwVQWYzaWSxKMsP0fzg@mail.gmail.com>
X-ClientProxiedBy: SJ0PR13CA0238.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::33) To DS7PR11MB6077.namprd11.prod.outlook.com
 (2603:10b6:8:87::16)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6077:EE_|CH0PR11MB5233:EE_
X-MS-Office365-Filtering-Correlation-Id: 00fea0fe-9e58-4200-8110-08de11a55519
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RXZmWkZDbzRZdUJBNWFrVmZ0em55djFqN1IxckY4WitFRW90ZlFWY3VYNXR1?=
 =?utf-8?B?dFlEc0VXV1NtcjFEM2VsYnlXYmpsUDUzdE9ZbmpIRm5QcG1SanNkTk9pQVJk?=
 =?utf-8?B?b2tKUXFJUUtWc2VrcVZodkRsTDF6MjRrQURqVjYzMU5sV05XTGdJK3lESnMw?=
 =?utf-8?B?YWNNTFZRVVorZ2s5dFZPcDJGZVJkS3NtdzBMWUZHbTBiQkdBYlE3WGxucFBN?=
 =?utf-8?B?YmpDYVdTRVNydHpZUnpMYlRFY0RGdCtmTjhjOU1nYmtpSWZCRmppWlp5VW1h?=
 =?utf-8?B?STJvSk5nNHovN05RbVNleityR2JTR2tFd2Mxb2VpMm5sajhtM0hQU2dWK093?=
 =?utf-8?B?c2pjOThkemdoMnE4NHZsQnFRcGdHSHdteVhNSGNqVFM5aThjYVpPNUQ5cVhF?=
 =?utf-8?B?emwwRE5wdFJ0UXFFSlZsVGtZU1Jtc0Y1TU1UQVVrVXpXY2lYYlpYVkNlZHRt?=
 =?utf-8?B?R0dvQ1lqUDRFTCtHQVE5TWZJQ0FHMXpuV3EzaG9PM1RkRUFvV0lIcjgyR3FQ?=
 =?utf-8?B?Rk0xZGNrTEtiRzBXZm12dnhpaDR2d3lpdFY1Q2RQcmNFUnhkOFhHclEvWXVX?=
 =?utf-8?B?RjRETy9QZzU1WUdQNVN0RWNiN0lmam5CeFREZ0xRNWgweEF6aTdYQU00WFlY?=
 =?utf-8?B?enpaYTJIS0oybW1kelRUdHNlZ2ptNjcxeUJuQytPSEJ3TzZxdzQrdkhXbnNV?=
 =?utf-8?B?TUFkUnNIMzdvdUdnb0s1VURueXc0SHNFazhvcWRRaEVrc3BMelpRVEl4cHlI?=
 =?utf-8?B?Kzc3VEl2ZkZ0NU0wUndKczd2eFBQRjIySXBxN3pKRU05dHVVSXVTVjZtVXlD?=
 =?utf-8?B?MXl2VGRXNnMvQzltT1UzU3RxTW53dnRTOHltZUVVeWZRakwraUxkM1VUS0li?=
 =?utf-8?B?MXNnRTJWYW5TSWFFeklFK21HVVlJK3NvMkg5NzlPSDV3QlErbUNGV2tVMTdF?=
 =?utf-8?B?aTh5UW1GTWE2YlE3ZTBUTk5LclkrSnB3U3I1S1ljV0VRZGlBUFdUK3dHVzlL?=
 =?utf-8?B?NHV5RHc0QTlmU1JLVGY4ZE5kWCtIbXFIVFkyNFVST1JFeVEvQnVkLzd3MVRW?=
 =?utf-8?B?TmVZTkdqOS84cGgvbjJNbWhLNXp6TWNVM2F5RGoxYXI0b3FOem9sM2h4R01j?=
 =?utf-8?B?U1I1c0xSSFR6Tmo5d1RpdnNEdlk1bGZQQ1NuaTVEQ2pwOEdLbGFJWDIwWkpW?=
 =?utf-8?B?NGFrTEFEWGY1dHpUOTlxcmpjelJUOVhmVTIwWnN3VDhqdGgyVkxKRkc5SmU0?=
 =?utf-8?B?UTlrSXBhTXNvZHJuNytVbXR2QmI5a3oveVhNNENyMk5raDZTdEJRQnZROUlv?=
 =?utf-8?B?em9aRENsZU12UHNoZ01BNCtBbE5qeXhrd0hhbUM3SHMxdVNvT0pTRHBWU204?=
 =?utf-8?B?ZXhTOW12d1RFWENzY1Q2YXdoRlB2cExaNlFxU2VvT0YrazI2c3NXcmNwMUR4?=
 =?utf-8?B?MWcxRHBNcm1IM0ZnUld5TUlqVlZ4QlkvVUllcjBVeW5QbXV0V210VFlIejhP?=
 =?utf-8?B?WnZNaVF2NmxZRW1JOVJhc0JZS0JqTFM4MDdsRzJlSm41MSs1Und6MGQxeVh1?=
 =?utf-8?B?QzF0SVFDWjBYenJoaU5nQVlzY0FpeFR6UXpOTGgyWGt3WU5UaG5pYVYwNXMw?=
 =?utf-8?B?UG9reXF3cGhjaXJGdlY3YUhsY1BEOS9BRUZ2NW9tRnRwczBEK1JFL25EZE90?=
 =?utf-8?B?QkxnZG5Wb0p0RHdSUVZrNThNVWI2dS85Tks3TCtUdG5uQ0tGTGF3N3c4cmNj?=
 =?utf-8?B?N1JoNVRINk9OcTVCOUNOL3JhSFJhUjRZZzdNb3VGUnI4eG5HNjJxMlVobmZ6?=
 =?utf-8?B?VElMbUhPWTkwWFNoSk92ZzVHRWpjNW9heUVhVmxWbzZSU2toODYyYXVpU0J3?=
 =?utf-8?B?WHh0eWwvTFV4dG9zR3pCaGhaUnUyMk16RlllODludVRyMFVXTW9FRlRmTEUv?=
 =?utf-8?Q?LRLbucqvz22EdNqDj0Cr3btMMPtZ9hVi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6077.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVJXTXl2N28xa0JOS3p0MHUvbEFhYzZ2UlNBZFJ6ZklhaXVpRVV3Qms2NGlj?=
 =?utf-8?B?bUd1Tm8xcnFDbk9vdHYwdEZCOTZ3Z3lhZi9KclhHR3NWdDJadVI5UTN4cEly?=
 =?utf-8?B?NTgwVU44TGhITU1FM2RJdTk3U0UvWkNEa0hiUjR6RjJEZ3JhRFNRQTJZUGtR?=
 =?utf-8?B?bXpJRHp6ZlM2RVl6dlRMSm1CVHoyQ2RWRXhZcWhIWWgvMUtkNFlyS3NUaTY3?=
 =?utf-8?B?RW1jREdWYnI3STBuZzZYbzlBZlE3czRrM0ZSWXlZeVZRelJicXhVMGs3cHZ2?=
 =?utf-8?B?ZlZ2UTlJQ2crSHhDbmpJTTlrdW1VV2lNQ1JRZCt2bkpYUS83NkFQc1pUeDM4?=
 =?utf-8?B?VDVpNkFON2t0cUpkaDg2Q0Z4d2s0RlZIQTFxL2poSGhQUUpkb1V2alYwZEZC?=
 =?utf-8?B?Y2IxUGI2T2U2bDBQN25HZ2RTaUVHUHJPYit4TUpFekhXQy9wek5uVGQxZGFS?=
 =?utf-8?B?cEJ3T1E3OVY5eERKZmdyWmNBOHg4TnZwU1l0aDNIMm9URTRSdk1HSkl3em55?=
 =?utf-8?B?MEprK3Zrd2hhMmhVYWN6MCtLWEl3azY0ekFmNVllSS9OTDFHc29lOEtTYkpF?=
 =?utf-8?B?TkVkYXBDeWtIdmprUThxZW9CUEEwTGhpSUFEdE82aDNYV2NleWRUR2I5dVhm?=
 =?utf-8?B?SmsyRXlQMk04WE9QeXMrNW9YYUtkQURCem90MWpVMFVIczFDVWRGTnVBOUNw?=
 =?utf-8?B?Uk45ZWs2VUp2ZEJuaEYvcFZJZ1I4N0pKNkFBZzBiWkFVd1dLS1U0Vm5BcDN0?=
 =?utf-8?B?d1RGanVWY1VDYXhkZlQrS2wxbG1ZYUhPNlIzdk8rYnFpZHI5VTc1R1JmQzZK?=
 =?utf-8?B?RjhUWHJpTUdFU2Q5bS91Qnl2aHZOcEVZdldOZDVNYldJWllmbHNtcEhlL3M5?=
 =?utf-8?B?UHNYMHhtNUh6U3RaZ1E4UWFyU3V0Tm5IczJuU2NwcTRZaEJYczFtcW1GTFlU?=
 =?utf-8?B?d2lsRzhQeVFqeWtpY3V6TlM1dTFMVTVCN1RkWWx5L1dpRVhZbWZxMWNYQUVv?=
 =?utf-8?B?SUJ2RVhyV3JzRkMyeXc4dGFIbG1xc05QTGhkSm95NnZ5RU9ZMWFZWEhyZHNP?=
 =?utf-8?B?QVlvTy9WSjZ3Z2NCRlRvMHYxS20ySEw2UldPNzI0UUI4UFVqMDVXVDA0SEpu?=
 =?utf-8?B?ajRzS2pJNGtwUFMvalU4MlBzUU5ZZW5LYW0rc0FJUXFEaU1iNVZ1WmV1cG1Y?=
 =?utf-8?B?VnVMbnhPVGF2bUo1eTZwZUpuY1Voc243bmk1by9IM0Q4V0VOQWpYMlNXa2NC?=
 =?utf-8?B?UGdnOUtEVUZxTm96aEhrQzMrU241aWxac2VrL0lvUHRYQjZBT1lsR0RzLzNk?=
 =?utf-8?B?K3NrdDFsR1RBL2V6VU9pMzMydUVtcUZCQzIxbDlsbklOb0dkZnl5WHc3VTZO?=
 =?utf-8?B?Z0xYeWNIeW8wNndjejllN0dNZFhVaHorSkF0Wmw5UzlTUGpySGluNFdEMWh2?=
 =?utf-8?B?L1BnWGZ1RjQzc2hsSDN0OFhLYy9DeGNTcVBsRUYwYUwrbzQ1dTNObzNmU0lU?=
 =?utf-8?B?b2Q3RTcvNXJtMlVrbTdxR01KN3hpTDFSc0Y4SDdhd1FwVVdUN1Y1Y0VpN3RP?=
 =?utf-8?B?TWdUcGFMZmxWK2wvUVZJNFY5aVZUWlIyQkt4ZDR2NzBQNW9EdzVtU2hvSzdR?=
 =?utf-8?B?bFBjeDc2VndKQk14dzlPZW8ydlRscEt4TkQ0dXo4UGN6YWJsaDVFOW5pdlFC?=
 =?utf-8?B?dEkxL1hJdTdGbjRNRExuaHBGQkNHcSt5Y1J4Z2RhVmFmN2FqTWFNcjhQc0JZ?=
 =?utf-8?B?eTk0UUtrSll0ckl0TjZHeWtGVTl4ZXhhOUplMklBU2tGNFVPUkVYcDNEcktC?=
 =?utf-8?B?UDlrbldicDdJUjJIaEZDU2hZQjF0bXZ2YUVPVVNwK0t2NXloL1BTNVNoYWRP?=
 =?utf-8?B?K1FXbUk3R1NDY0FYd0c0Mi9GaTBMM21qRVVqbTc5cHROMDFYSEhCNU9Ja3Y5?=
 =?utf-8?B?Rk5MZ3czbjZaS3E0TmlGSzB4cXlRaHJycFlZclhGSE9ham93Nm42N0tkNXBV?=
 =?utf-8?B?dm5rMElWenAxdExKZjF6YjMvYXBnSTcyaVY5a00yaWNlTDVVeFY1YkVqbkl5?=
 =?utf-8?B?bXVCZ21pOFhtVUlSOUY4djgwMUVLVGl6ZURmVTdRSS9KK1pKNnFaVEgvbHNp?=
 =?utf-8?Q?e18kWnf6ZnIlC4IGPyNP8rWQ1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 00fea0fe-9e58-4200-8110-08de11a55519
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6077.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 19:58:13.2042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IiahDs2hBAgIqtGuFkKq67zB5KKjTlv06GMt0dW5oVxDOKsn8Kmw7+VQJbn53IYSX/VaQ+3w0FigYE7H//uqqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5233
X-OriginatorOrg: intel.com

On Wed, Oct 22, 2025 at 09:31:29PM +0200, Rafael J. Wysocki wrote:
> On Tue, Oct 7, 2025 at 12:24 PM Kaushlendra Kumar
> <kaushlendra.kumar@intel.com> wrote:
> >
> > Add proper error handling and resource cleanup to prevent memory leaks
> > in add_boot_memory_ranges(). The function now checks for NULL return
> > from kobject_create_and_add(), frees allocated names after use, and
> > implements a cleanup path that removes previously created sysfs groups
> > and kobjects on failure.
> >
> > This prevents resource leaks when kobject creation or sysfs group
> > creation fails during boot memory range initialization.
> >
> > Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> > ---
> >  drivers/acpi/acpi_mrrm.c | 33 +++++++++++++++++++++++++++++----
> >  1 file changed, 29 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/acpi/acpi_mrrm.c b/drivers/acpi/acpi_mrrm.c
> > index 47ea3ccc2142..6ec42eb48783 100644
> > --- a/drivers/acpi/acpi_mrrm.c
> > +++ b/drivers/acpi/acpi_mrrm.c
> > @@ -152,23 +152,48 @@ static __init int add_boot_memory_ranges(void)
> >         struct kobject *pkobj, *kobj;
> >         int ret = -EINVAL;
> >         char *name;
> > +       int i;
> >
> >         pkobj = kobject_create_and_add("memory_ranges", acpi_kobj);
> > +       if (!pkobj)
> > +               return -ENOMEM;
> >
> > -       for (int i = 0; i < mrrm_mem_entry_num; i++) {
> 
> Yes, i should be declared in the preamble.
> 
> > +       for (i = 0; i < mrrm_mem_entry_num; i++) {
> >                 name = kasprintf(GFP_KERNEL, "range%d", i);
> >                 if (!name) {
> >                         ret = -ENOMEM;
> > -                       break;
> > +                       goto cleanup;
> >                 }
> >
> >                 kobj = kobject_create_and_add(name, pkobj);
> > +               kfree(name);
> 
> OK, this fixes a memory leak.

I didn't realize that kobject_create_and_add() made its own copy of
the "name" parameter.  Maybe the code should avoid the alloc/free by
making "name" a local variable?

	char name[16] = "rangeXXXXXXXXXX";

	sprintf(&name[5], "%d", i);

> > +               if (!kobj) {
> > +                       ret = -ENOMEM;
> > +                       goto cleanup;
> 
> Why terminate this?  Why not continue?

Terminating here (and below) will go to Kaushlendra's cleanup
code to remove all the ranges. Maybe this is better than having
some random subset of files appear (based on which allocations
succeeded/failed)?

> > +               }
> >
> >                 ret = sysfs_create_groups(kobj, memory_range_groups);
> > -               if (ret)
> > -                       return ret;
> 
> Well, this returns already, but I'm not sure why.  Tony, wouldn't it
> be better to continue?
> 
> > +               if (ret) {
> > +                       kobject_put(kobj);
> > +                       goto cleanup;
> 
> I would do a "continue" instead.
> 
> > +               }
> >         }
> >
> > +       return 0;
> > +
> > +cleanup:
> > +       for (int j = 0; j < i; j++) {
> > +               char cleanup_name[32];
> > +               struct kobject *cleanup_kobj;
> > +
> > +               snprintf(cleanup_name, sizeof(cleanup_name), "range%d", j);
> > +               cleanup_kobj = kobject_get(pkobj);
> > +               if (cleanup_kobj) {
> > +                       sysfs_remove_groups(cleanup_kobj, memory_range_groups);
> > +                       kobject_put(cleanup_kobj);
> > +               }
> > +       }
> > +       kobject_put(pkobj);
> >         return ret;
> >  }
> >
> > --

-Tony

