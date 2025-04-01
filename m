Return-Path: <linux-acpi+bounces-12581-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 562AFA774D0
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 08:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7BD63A9E6B
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 06:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176A21E8328;
	Tue,  1 Apr 2025 06:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RwjfO8dh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204621E3DFE;
	Tue,  1 Apr 2025 06:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743490608; cv=fail; b=DM417v5AbBRKFm+QrOA5s3ouPJAvVXmlpS7UAaFzfKQFTOavAHkIbQ84bUrs781eJy41JsOQWBX99YA9x2LspK7RkfSxXGGlDEFLvFV/W8xAxMBy52eZj1LlUXPxkKaAdFNbZmUVDzjf6B90ePQpCc4SLVMfV9LRuCuhVtlfGAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743490608; c=relaxed/simple;
	bh=KBvhp9zqgRibxGvB6nkziG5uBHGZiSQfsHt+EyAk844=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oNHEQGZnVMaHrFdnEfx8KOJwYSUEFiqMGKJQncYCY13KcYA9EMTypcQhE11lL9rf9hHlILNOZPIFdKQkl5MAKN6O6KBeKBXsH3rQPzgdEgmhxynZo8NdDxtzU9zhZtsUzUHUCI4Bj0JEqBxRgt87YuEUG4RyJpDihYrsWNE+XMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RwjfO8dh; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743490606; x=1775026606;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KBvhp9zqgRibxGvB6nkziG5uBHGZiSQfsHt+EyAk844=;
  b=RwjfO8dh9A1TSwUX/jcJGXQxa83wYUtYwwS7p6EBZpRRLqwUQ57KJh0Q
   JfG0n+5ZZ44TnvzbRMZvfKeMi66KPuvbZIvjmI/eSDOk/q1OekkOCD7BQ
   gMmuQ7+l1pYnbq18s396deAK/tZvtX5SU1Jdw83g71+fKjEtebk7wT0yx
   dXLfU8hfE3pp4Pqr1NQmxIgYnEbbQ7M8+lBWqBczntYS/NTnZ7zCUeu9B
   OiGFkhAxb/y6lkXXHYZHgIVU2lRXf+f3/0IVB7h3MxAR6wRyjEtugmFKM
   bOJgPUWOtXVKwlHttgK0XjpILN21+7V7hrX8a0Hwqu82dxPwokdhVhZGf
   g==;
X-CSE-ConnectionGUID: gXYM242LTPGov+vBxoilhA==
X-CSE-MsgGUID: I1WhwtZ3T36wT70eTzyXnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11390"; a="44970334"
X-IronPort-AV: E=Sophos;i="6.14,292,1736841600"; 
   d="scan'208";a="44970334"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 23:56:45 -0700
X-CSE-ConnectionGUID: aZVARx6SSeqyVX/vhm0gLQ==
X-CSE-MsgGUID: K3aQWO1sTsevRFSYutBYDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,292,1736841600"; 
   d="scan'208";a="131296076"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 23:56:45 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 31 Mar 2025 23:56:44 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 31 Mar 2025 23:56:44 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 31 Mar 2025 23:56:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WoMJBVBV50W6SzElBJsjJrePl+xK68Tv1leElsvvXzDvpD7lsACkrNHtU99jhNwsYxXoHmNUCMMfvfRarLBGcD0fqWNdAkGWetYZcMyvFfqI02xo6qweJa3XhLRIXTgcTd+HuzeLGdUsHSR2lTJeLlekhcE9dhi/hwRY9z9Gr9r6b9m4bqUu7msbq/j5CyMg3B60ZM2pBT7Y3kAZxiNTtG+0ZxefWs5rwy0Pi6qME2PGO7F55obnUfmmk8OGRPogsrC2RU4eYACHm7v4ebR1pwgBEI4JEHApxItMFXQUmKT5/3+xynVn49YJUzH9lKhTt6MOz+11I9FvZLfDmXDxbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6jOKT3vvsCGNe8U82/OQkptIgq1yn8vXLsxiTQcPZdk=;
 b=j4OwXJfUulj5dtq8zbXbF5ooMjMbigXkvmP2bVnM9qkAXZAQjO2qKubm8WxRg9gAep5tLUkGX90+7CM5Mep2ZxFRHC4aUevlvio7iG3clp+B4+UbjRj8szOUj4y1Viju/4sNYym2906zfkAe85GVY0W8u4HDo7WqDoUwkVRFeXG5x+4HaOQfZMoCwXDYp0P85C1/P1obu8GC+YCEwz+j4Wjg5VGh5MVtBkzne003KTSUI8Wysrbw7icdRNrLjOgLrCBYUED6MIE6ChpIT4+8LYclS4rQVXwU6rltj12XrU11QwAEV+lCJ6BtcwHeteuY812tLmHPt2EYRuxyM/JPUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 IA1PR11MB6468.namprd11.prod.outlook.com (2603:10b6:208:3a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Tue, 1 Apr
 2025 06:56:41 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%7]) with mapi id 15.20.8534.048; Tue, 1 Apr 2025
 06:56:41 +0000
Message-ID: <88a36c5b-8dc0-47b8-832d-366f0214dd11@intel.com>
Date: Tue, 1 Apr 2025 14:56:31 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] tools: Fix compile error of pfrut/firewire
To: luriwen <luriwen@hotmail.com>
CC: Takashi Sakamoto <o-takashi@sakamocchi.jp>, <lenb@kernel.org>,
	<robert.moore@intel.com>, <linux1394-devel@lists.sourceforge.net>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, k2ci <kernel-bot@kylinos.cn>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>,
	<yu.chen.surf@foxmail.com>
References: <20250328074750.3524280-1-luriwen@kylinos.cn>
 <20250329010721.GA11319@workstation.local>
 <TYBPR01MB5470C91FC2902D16D3FB9707B1AD2@TYBPR01MB5470.jpnprd01.prod.outlook.com>
 <CAJZ5v0jy21xWDSrTxSzg0YPBQYrntXvDYK-GZtH2we+qGjw3Bw@mail.gmail.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <CAJZ5v0jy21xWDSrTxSzg0YPBQYrntXvDYK-GZtH2we+qGjw3Bw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KU1PR03CA0001.apcprd03.prod.outlook.com
 (2603:1096:802:18::13) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|IA1PR11MB6468:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c7531d1-0f0c-4d55-94d4-08dd70ea5b81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y25ORjY2ZDNLSjEvbU41WUZnYkc1Z2phT29HRW9uamFjdmYvRE14Z1hTSVBO?=
 =?utf-8?B?YmROeDFKeEpWcFByTmNyODNLQVE1Q1NoSlE5a2hHSVlTSUtJbW9sTFRaem5I?=
 =?utf-8?B?U3hNcjhiV0JYSnZBc0c2VDV0WkpOVlhJQVk0elVhTVpzODh6SDhNSG0yd3dK?=
 =?utf-8?B?aDI0a3pwNHFUMWF1WngwdkF3Y2MrOTNjakkwYU1jUXluK2dCU3RiWW11NjFq?=
 =?utf-8?B?cDNSKzBsN1gwRlFGN0x2WjhxT1M1enZray84S25vTEtDNURMQzd2WFN0OGpS?=
 =?utf-8?B?VnVWcVNRV0pQRWxhZEwzOWRrak9OWHZCSE9KSGNVVVZOT0VieW0zZFM3Y2Ew?=
 =?utf-8?B?M29LaDhwQnZBcHNzZjIvUE1CU0dHOFJvck01NzV3SHFrM0ZDNitIeE5iM2Yw?=
 =?utf-8?B?d1pFbGNSc1hzVXRqSklKa3kxbThlWmVTaWVSOXlKaDNsMGViZjB3VUNwT0kz?=
 =?utf-8?B?M3JwMWxDcjJ5eW5USGdLSDRNSWtHanZpUnBaQmJidCtOZEhJZkdFRFdRcGx6?=
 =?utf-8?B?YmRUbEVCR1ZmOWpmd0tNaEZQQjZiUTE1S0Zwcjhrb3pZRUJFQXpOUlhCSlNI?=
 =?utf-8?B?VWFoMnNOcHpETC9FM1B5WThBZitTVXpzUWp4VlNYT1l2aEZzQnl5czlXNEls?=
 =?utf-8?B?a1hvaWIyNEpSUStBRW93bWN1MVY1LzFrcVB1UC82MUZYbjgzVkErY2NhczJs?=
 =?utf-8?B?UDNDbkZYRWY2STUxTzEwSkpmYXNwTlQ0OWpUVG56Yy9CZEJUZlcyMTUzMTF0?=
 =?utf-8?B?bmNJeC9Fb0xCQnVhTjBzdCt4MWRBYnJUTHVyd2xmNkhyZmJ6MXZqNWpubUN6?=
 =?utf-8?B?Zk5GVnRxSHFacklRanBqMVFXYW5lTlNCRFc4cXhZL0p5bk4wYUJKOG9jV3dq?=
 =?utf-8?B?VUpiZHF3SEpQdXJWVFgraDRLaWRBR2RlT1FpdEVoMGRDUGZxM0ZVbjJhODRK?=
 =?utf-8?B?UnlvQ2dJTEtaWEwrcmZ2Z0NUMmFUYzBIVEN1RmUvZnh2elh0clRsaHpZZzdO?=
 =?utf-8?B?OGlGWU1naGVVYVVHWFF3aHpIdzBQNmcyQlVBSGhza2VGV0pJbzRLTjRJeHpP?=
 =?utf-8?B?ODc0VGZyRnJLTENOTWpOS3M1L2dtSWlYOG44eVYrMjJJUFEzKzlERGdxZEJ4?=
 =?utf-8?B?NlJ3L29TY0lndFV5OXFGWmtTWHNPWmpVNkF2RnFMN1BlSldaanVLK3VYZE9M?=
 =?utf-8?B?WXdzY241a0xXTkVhbCtTYWMvMzR0cUNaYk16cG9XQW9DcmxzbFdnZEFpSlBl?=
 =?utf-8?B?QmZnNGF6Y3RGbjA0d2J6NmdBOW5KcWN1VWtSbmFjb3h3aThoMy94cVlkNmFH?=
 =?utf-8?B?MDJZclhyVGFMWEVZWUg5ZGw3b041em9SU2d6VXlBMk5jVlRLaDZHRWFlb3RL?=
 =?utf-8?B?azZmdWVHM25vTGxlMWF1WjRhYnh3dmxLT1BFaFpEcTVvQm84K294MWFQaUdz?=
 =?utf-8?B?R2I4TXdPWm12TFdueEVrbnJmaHRsN1RTR01hOTREYjV6c3lYbDF6cllPMDhl?=
 =?utf-8?B?YUQ0OUxsL2xseHU3bFhIdUt4L08wSjJ5cGpodlhHS1kweVpWMzAwem1mWWMy?=
 =?utf-8?B?Q3pRZFNqKzl3SDJjYXpQbzlodGRGTXh5RHpVSS9UczBoc3N0azIyUHp1aFZQ?=
 =?utf-8?B?SG9yM0RNNkEwek53d1BsZVlmYWtZVDZoSUY3cDV4WVk3cEc4YVkzRUVQaVla?=
 =?utf-8?B?R1RjQ1IwTjg4NlVxUzRwcWRmWXpQMkNZT2tMZVRzQ0ZWVndGc0cvU0UrL0RZ?=
 =?utf-8?B?cmh3UTV5NXlwSzVJclZYM015Q1NHTEs5aXB4Z3FvNWlYZEtzbkxucUNFdFpo?=
 =?utf-8?B?TGV2ZmxDb3orWHNyS3MzNDEzelB6MG9XczNxeGdzVFh4QmZSUFBBSDg4Smtn?=
 =?utf-8?Q?XMai95E4iIZK2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVliaHlWK1NDRHRaMjcxcGxsMGNPRklRQUNYRWw5c0hyME5wMFJxWG51YXJa?=
 =?utf-8?B?OFF0c1lmZVBkZHc4WEozWlhJMjIwMzYwejhaN2htQitpK0hpSXZoOVcyZGR0?=
 =?utf-8?B?NkFLODNJaWtOYzFyTlhCaW5jVStwSngrR0NnUFhRNVVDbU9NNDJlL1JLcWhX?=
 =?utf-8?B?cjl4UTZmMVUzTlJzUFVzVHdmYUF3UTJMVm5RQUVpME1iZjYyT2ZtNVkrTXFC?=
 =?utf-8?B?bjB3ekFLTHFWbUNjTjl3U3pCWCtTM1pFWjBYYS9xYW5rZndpOHB0RlEvN2Uw?=
 =?utf-8?B?UHJqcFVMeCtYVFpqOG1rdTM5MDg5eTFLZGNGcUF1cGVEWmhDZGZGcWRkckd3?=
 =?utf-8?B?cmlrTDFzKytmN2VvTTBVZSsxTHkrK1JuWEpyTnQ0L1NZZzlHSEN6bXhRTXFv?=
 =?utf-8?B?b01OYWV1V2JmVmh3QisyU2tMUERNR3hEQTlqVEwvSU4wVEFiTlpRQStqMG5m?=
 =?utf-8?B?NXRKeHVsRm9nUDlrckdkWjZyZmhEejBZcDUzRkNFaEFFc1hlMXVHUm14b0t2?=
 =?utf-8?B?STA0YlRET2psM3hQNXBHaGp4cDBqSWNjQjhjc045dGtVeHBSTjlmM01TUjJP?=
 =?utf-8?B?dTROYy9hY2F1dWlxVk5RcVliVG1QUC9rQmJHNWR4Y2hDZjh3Tng2NmQwaVlF?=
 =?utf-8?B?Y2lrZzUxanZJMXJSRFQ3MGlWTTBFS215Q0VEeHREcXI2alpVODhzanVkMkVk?=
 =?utf-8?B?eElJcnRtbWkySkplM2dEdFlHZG9YbkRnRllmN0hPenZvTFN5YVVFVWtyQVZB?=
 =?utf-8?B?Z3QxM0FJamVhaDVGWnRwU2s2VUJvcU9RTXo5MUlSMks0VWF0Mm1lTUFXMUtx?=
 =?utf-8?B?QkhhdlErT0xjVW9UQmxCQjJnSWpIbVRuWnhVVlUvMmtKWWN6dkRqMzl3aERy?=
 =?utf-8?B?aEZuZlhXSjk2YXpYZ3g3a0h0MjNDejdGa1dmcWhXV1AzZEk2QnVvTkZtV2dP?=
 =?utf-8?B?bXR3UlF4aUZUZ1p1WHNTUHR5MlFncGRMd0JaWHA4SWZ3WWppdkNlS2dNeGVL?=
 =?utf-8?B?QXdoQXh2MUI5eUprMWlQQzZCWldpajh1d0lGOFUzamhmVGtSUm9zbHEzdTVl?=
 =?utf-8?B?dVhEWkttVTVYTWROU1RPOUs1dFBBMmhoaFRINjRLUHJ4L2FpaS9MeWovWGtD?=
 =?utf-8?B?RHRmNFNhRitWcDVXTHBGUktwVXBKQ0xqTmk1bFNyMEt4L2ZIQi9pS3o0TDA5?=
 =?utf-8?B?R09FSE5OdmFmL01mNW9FL2ZnY0dOaG9RcjRndmJpRW1VMGFHYkN1bWd6QWpK?=
 =?utf-8?B?c0lvbEJDT3B5enFFbWh1ekZmbnVwRjRLdlo2YzVOL2ZQTktIMUpQc0Jtb0tD?=
 =?utf-8?B?MGdFaWNDRVlLeTFmaUl0ck5LaVExMWVUVmp1ZXJ0S3M3WlhOWXRrRUVlbEtw?=
 =?utf-8?B?NlVEbHlDKysyVzVQbVppTk1kQTdlVDNqekg4QUZFaUtqWkVVQXoySFhDNkVF?=
 =?utf-8?B?K0RhbHNYYktqSmpudTJqRmhLd0hBWTdvVnNDdUZQNEdHWFFza1haN1drYmcz?=
 =?utf-8?B?WXY5ZVNhck05aXZxVUppemdCWjNQR0tYRUxBTmVkTkpmT0c1MkhhVHU5VTRq?=
 =?utf-8?B?THFQRXN6c1NUQlNVWTBTamdGek1HT1llcE5iWWdiZmdiYTNTV1hmWldrekZv?=
 =?utf-8?B?MTFoNEJYY3p6ZUtYTXNKM240TFg3RHVuRzdsQ0ZUVDVEZDBydHhEL3orYjg5?=
 =?utf-8?B?NGx3LzhmdjI2K2JxZEtvRGJpYitvQ09vV3pSVDlsdnVpWGxFYm40UUt0SHpx?=
 =?utf-8?B?UG81SUNGSkVKNHFUV0phUzUwa0QwN3RWdUx4bUY4ODZKcEZxcWtoRnpENHB2?=
 =?utf-8?B?U1VtMmg0anAwS2llQlM1WFBUNWEwZEpPUXNyVFlaNmRyQXA0dmFvZ1MzKzc5?=
 =?utf-8?B?TG52Y2t4NEVhcXZqTHNJblBmOFkrMWxMNVhBNkZBd0JXMlhhT2lhSTRmVHBs?=
 =?utf-8?B?dGM4cTBBN0FNSWtIVHFqcnBJSlJyeFZZZ1FLUmF1d3RsdHdPQmpmbDJHMHRx?=
 =?utf-8?B?Yjd3dFRHcWJnbHlsZDh0S3NVQ2RCSk5vNEdocno5dmFvSk1ULzVsY2VRRDlE?=
 =?utf-8?B?bUNINlZQTWxGVzhBV2NTaGVPeTdhdURqWTNVMkQzVEpkelJ4T25weUY2RDhj?=
 =?utf-8?Q?SA6RVKRs3qQ/xIhwWsf3bwXDY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c7531d1-0f0c-4d55-94d4-08dd70ea5b81
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 06:56:41.7763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9YMHPPbuqXZYgHIjBKTGHRsOnIsCmbEbk8wjzcwakJHb+wNqyBi1mHefVikJH3xvPN4ZGyGVwaBReQKVogapZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6468
X-OriginatorOrg: intel.com

Hi Riwen,

On 3/31/2025 7:52 PM, Rafael J. Wysocki wrote:
> On Mon, Mar 31, 2025 at 11:15 AM luriwen <luriwen@hotmail.com> wrote:
>>
>> 在 2025/3/29 09:07, Takashi Sakamoto 写道:
>>> Hi,
>>>
>>> On Fri, Mar 28, 2025 at 03:47:50PM +0800, Riwen Lu wrote:
>>>> The value -rR of MAKEFLAGS implicit do not use make's built-in rules and
>>>> variables. Previous commit d1d096312176 ("tools: fix annoying "mkdir -p
>>>> ..." logs when building tools in parallel") removed the MAKEFLAGS=
>>>> command for tools and caused the built-in rules for pfrut/firewire
>>>> failed to take effect.
>>>>
>>>> Reported-by: k2ci <kernel-bot@kylinos.cn>
>>>> Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
> 
> Yu, can you have a look at this please?
> 
>>>> ---
>>>>    tools/firewire/Makefile               | 7 +++++++
>>>>    tools/power/acpi/tools/pfrut/Makefile | 2 +-
>>>>    2 files changed, 8 insertions(+), 1 deletion(-)
>>>
>>> As long as testing with v6.14 release, I can not find such failure. I
>>> guess that some one has fixed the issue between the commit and the
>>> release.
>>>
>>> Would you please recheck the issue?
>>>
>>>
>>> Thanks
>>>
>>> Takashi Sakamoto
>>
>> I have reconfirmed that this type of error does indeed exist when using
>> make tools/all or make tools/firewire at commit 4e82c87058f4 ("Merge tag
>> 'rust-6.15' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/ojeda/linux") in the 6.14
>> kernel.
>> The relevant error messages are as follows:
>> $ make tools/all
>>     ...
>>     LD       pfrut
>> /usr/bin/ld:
>> /home/luriwen/workspace/kernel/kernel.org/linux-git/linux/tools/power/acpi/tools/pfrut/pfrut.o:
>> in function `print_cap':
>> /home/luriwen/workspace/kernel/kernel.org/linux-git/linux/tools/power/acpi/tools/pfrut/pfrut.c:179:
>> undefined reference to `uuid_unparse'
>> /usr/bin/ld:
>> /home/luriwen/workspace/kernel/kernel.org/linux-git/linux/tools/power/acpi/tools/pfrut/pfrut.c:184:
>> undefined reference to `uuid_unparse'
>> /usr/bin/ld:
>> /home/luriwen/workspace/kernel/kernel.org/linux-git/linux/tools/power/acpi/tools/pfrut/pfrut.c:189:
>> undefined reference to `uuid_unparse'
>> /usr/bin/ld:
>> /home/luriwen/workspace/kernel/kernel.org/linux-git/linux/tools/power/acpi/tools/pfrut/pfrut.c:191:
>> undefined reference to `uuid_unparse'
>> collect2: error: ld returned 1 exit status
>>
>> $ make tools/firewire
>>     SYNC    include/config/auto.conf.cmd
>>     HOSTCC  scripts/basic/fixdep
>>     HOSTCC  scripts/kconfig/conf.o
>>     HOSTCC  scripts/kconfig/confdata.o
>>     HOSTCC  scripts/kconfig/expr.o
>>     LEX     scripts/kconfig/lexer.lex.c
>>     YACC    scripts/kconfig/parser.tab.[ch]
>>     HOSTCC  scripts/kconfig/lexer.lex.o
>>     HOSTCC  scripts/kconfig/menu.o
>>     HOSTCC  scripts/kconfig/parser.tab.o
>>     HOSTCC  scripts/kconfig/preprocess.o
>>     HOSTCC  scripts/kconfig/symbol.o
>>     HOSTCC  scripts/kconfig/util.o
>>     HOSTLD  scripts/kconfig/conf
>>     DESCEND firewire
>> make[3]: *** No rule to make target 'nosy-dump.o', needed by
>> 'nosy-dump'.  Stop.
>> make[2]: *** [Makefile:72: firewire] Error 2
>> make[1]: ***
>> [/home/kylin/remote/kernel/kernel.org/linux-git/linux/Makefile:1438:
>> tools/firewire] Error 2
>> make: *** [Makefile:251: __sub-make] Error 2
>>

Maybe add more background in the commit log that, the default
MAKEFLAGS in Makefile under Linux's root directory is with "-rR".
Before commit d1d096312176 is applied, the -rR is overwriten by
the subdirectory's MAKEFLAGS, so it will not cause problems when
compiling the sub-directory of tools. After commit d1d096312176,
the -rR takes effect, which prevents the tools from using the
built-in rules and variables. Maybe also added Fixed: tag.

Regarding the prfut Makefile, we have fixed the LDFLAGS issue,
but the CFLAGS += xxx will not take effect, right?

This reminds me that, is it possible to just remove -rR for the
sub-directories? In this way we don't have to change the code of
every tool one-by-one, pfrut, firewire...
Cced Masahiro for guidance.

Something like below:

diff --git a/Makefile b/Makefile
index d138b17b8840..853be42ca1a1 100644
--- a/Makefile
+++ b/Makefile
@@ -1431,12 +1431,11 @@ endif

  tools/: FORCE
         $(Q)mkdir -p $(objtree)/tools
-       $(Q)$(MAKE) LDFLAGS= O=$(abspath $(objtree)) subdir=tools -C 
$(srctree)/tools/
+       $(Q)$(MAKE) LDFLAGS= MAKEFLAGS="$(filter-out rR,$(MAKEFLAGS))" 
O=$(abspath $(objtree)) subdir=tools -C $(srctree)/tools/

  tools/%: FORCE
         $(Q)mkdir -p $(objtree)/tools
-       $(Q)$(MAKE) LDFLAGS= O=$(abspath $(objtree)) subdir=tools -C 
$(srctree)/tools/ $*
-
+       $(Q)$(MAKE) LDFLAGS= MAKEFLAGS="$(filter-out rR,$(MAKEFLAGS))" 
O=$(abspath $(objtree)) subdir=tools -C $(srctree)/tools/ $*
  # 
---------------------------------------------------------------------------
  # Kernel selftest



