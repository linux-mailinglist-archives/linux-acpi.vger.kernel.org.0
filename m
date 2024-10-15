Return-Path: <linux-acpi+bounces-8786-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E796299DCB1
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Oct 2024 05:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B036B21E01
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Oct 2024 03:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A3D16EB7C;
	Tue, 15 Oct 2024 03:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lp5dzauV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7D72BD19;
	Tue, 15 Oct 2024 03:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728962614; cv=fail; b=o2lLfxJyBKl0UpBAHPpFEkJ3yqy/nNkTcGTUvyeXY44853D0oC8+VCB01VPdc94+V0fRb8pUzPurepBhcySRZc9q+7Qy5NnSFQsdo0M9tEbyy+vG4jpGLvz2YAv5G+i9wNCcz7iNRhOkw8aLWyZoWU16Eg6NFIKFgREhIzJj4ho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728962614; c=relaxed/simple;
	bh=ATCNi/51y+Kd8EZH80Ej9qQ0nW3YZUxWfy3m2DG4VEY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nwXlER0KMCxgr/5LFxVaK19JGi0L0uphMgnCez0qj+whf8ShLvCnkaloYgNuOJzYkqOVdih19Dvw+1iTJhhTnfbWavXr93YbE3wMFXWVo0AYplfruVIvZUGYTJGifC+UFfJULgdI1htx7GJnFgn1C/D7RLX7/kBpSTqDZ78k12E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lp5dzauV; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728962612; x=1760498612;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ATCNi/51y+Kd8EZH80Ej9qQ0nW3YZUxWfy3m2DG4VEY=;
  b=Lp5dzauV6N9oZxw518T4GkFpp8BJETk1TNaoI1RZi2MPBdgHftjz31fL
   QVpFIq3zP/GCPIMNeZPRXcSzg2z2zkBkMnKg5z9OXZ8zI20w/3vZMLfcc
   jum0/sylavuaNGpC4dcsduD6Ip0hmsH/D7pRILfJ62F5IOCtu9Hhy1pct
   TVCb1MMMGzSP4WC5mEoyy+9mtnNEnp4WlaF5YyOaxMiKyQQQWgMPn/MsN
   yChAAANzbyFKCDPDsJ+DdisVE+2Z6IcNtGqFVjfW4OyRYHadju4eIp5I5
   HnMaceel+BMzuBfsvOk++HCZ2cx0CwAh2sw8eDhwXoLHChjaNaQWDXER3
   g==;
X-CSE-ConnectionGUID: 9dHZb9W2SRueSldKLyYaDA==
X-CSE-MsgGUID: lEfpMdZIQbmVLf4LhiTA6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="32254062"
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="32254062"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 20:23:31 -0700
X-CSE-ConnectionGUID: fhAJB+k9Svei8nVUqfwCGQ==
X-CSE-MsgGUID: SiOZ6KMvRgS8hrdYztrXvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="81729200"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Oct 2024 20:23:31 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Oct 2024 20:23:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Oct 2024 20:23:30 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 14 Oct 2024 20:23:30 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Oct 2024 20:23:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UKq1uywbA7PM4GOCPCX0WlBRBspF0LNpM8v/DJ/HFWu/yrR6RNGDdRoWhLoGGv2tDx3IV40VemRf+AKjrBBWcnz71Rgut6TGd6X0rIIO/yRlK6aqhGwYPEt94j3Zpawej/4iQE/8MhH9E4hZ2nh0sz6eJNndTl7Vy58B74XvUT3tL07wVkVMD+XyDWeVFyflKD6UQAusc0Hg3WwWexEhzW6FZxjafoFn0RugQyJuENIJc0YnADnRdUNKhTYD3fnnDik7TnHaBvUUsQaa9rU++JPPcUMiSf3vlN20byzfA6brwyM14U099/cfNR4h/oXnQ7zC0c4LXVCN93x6Hq+qAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATCNi/51y+Kd8EZH80Ej9qQ0nW3YZUxWfy3m2DG4VEY=;
 b=uWJenISshSMKZcLvWb3Tj3ABJhzFU8eM46KUA5m2v8sp3c8sqgtl5QtzbCOaoImaRfifz2DNp8ghfuvoekyZIrdU75FPlC6tmMVI1LN5zeMRc/GEUU5zzWs5rJ8swP81foFncQoHbRsnGXsrPoeUdx9O6XL3/zlntw2zdfuW8XzjuPwbz2PSlwYM5rkGnwG2AZvmP+YtuPhUJhNat82uaOLKcK1zKqd+cQlDaGoKPnMK5rKHvxPS0qRwb5v3ouYy9YBvA6iL6ZTGzfo5lywjvWx65CMDmOd13eV/OP/VfEwt8qVk9QUSTa7wYt3HLEW53KGe17MdwurkV5Q5YxUs4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by SJ0PR11MB6791.namprd11.prod.outlook.com (2603:10b6:a03:484::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 03:23:27 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%5]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 03:23:27 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "jmattson@google.com" <jmattson@google.com>
CC: "ajorgens@google.com" <ajorgens@google.com>, "myrade@google.com"
	<myrade@google.com>, "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org"
	<x86@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "Tang, Feng"
	<feng.tang@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "jay.chen@amd.com"
	<jay.chen@amd.com>, "vladteodor@google.com" <vladteodor@google.com>,
	"jon.grimm@amd.com" <jon.grimm@amd.com>
Subject: Re: [RFC PATCH] x86/acpi: Ignore invalid x2APIC entries
Thread-Topic: [RFC PATCH] x86/acpi: Ignore invalid x2APIC entries
Thread-Index: AQHbG1vT9lbwQmPJwk69cBdGq4KcNrKAxaAAgAAYfoCABV6zAIAAUk0AgACdXAA=
Date: Tue, 15 Oct 2024 03:23:27 +0000
Message-ID: <ac85fe73b3d7f46ce96d5033f8cf58a1b6b001f3.camel@intel.com>
References: <20230702162802.344176-1-rui.zhang@intel.com>
	 <20241010213136.668672-1-jmattson@google.com>
	 <f5962c02ea46c3180e7c0e6e5e1f08f4209a1ca2.camel@intel.com>
	 <CALMp9eQ9v0Ku0Kcrb2mwz6hb5FJRPKT1axyhX5pQ-nhrLzBY4g@mail.gmail.com>
	 <f590669a7fa8d3e3f4d24ae3ed2d864ac14fbef8.camel@intel.com>
	 <CALMp9eQRsQ7hs9vhDGzbyRaqyOuaHDFFgc6VSr9Ui1=J_4s9Nw@mail.gmail.com>
In-Reply-To: <CALMp9eQRsQ7hs9vhDGzbyRaqyOuaHDFFgc6VSr9Ui1=J_4s9Nw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|SJ0PR11MB6791:EE_
x-ms-office365-filtering-correlation-id: fe089ea8-db68-4ef4-8f13-08dcecc8bc0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?amtjWXZRNzV4Wk15K25uUExWeVZOakM0VWZaSW8wZjBqSmh3amJDeC9JQm5W?=
 =?utf-8?B?WUcvN0dKZUIvQllEY1JBUWltc0czbG1yYWtWVFJWV3MrOXl4a2o0Q1hHbE9N?=
 =?utf-8?B?U3hiTWpCK3djMEdlb2hzVE01NEN5N2Y5RWRDM3MzV2RKV2hzYkk2NWQxMU9o?=
 =?utf-8?B?MnhGQ3RzOFl4SmJNZE5BOFpCMjdSUThFajlvak1SWmppS3ZwelV1dHZhNEoy?=
 =?utf-8?B?MHdwK3BPODVwU3hKS2lPY3VLLytINGRTUldlUmxjUnBMMHhUSnVyVVIyL3NZ?=
 =?utf-8?B?UDZPcmNmZGI2QlYvTk5hQzhmVTNpcjhONmFiUldxZEV4SkhrV1hKVVJyd0tJ?=
 =?utf-8?B?blpBQWZRZ1M2SGE5QVRTKzh4NENVb1lWY3dTRkJaa3V0UnVjQUY2MW5EeWF1?=
 =?utf-8?B?N2lCMmUrZFhFdUJhZy9DWCsvdGhvME1LdzlYZmJNSjMrcnp3SEp1ZjJmNGE1?=
 =?utf-8?B?aHJuVFR5SHN3RlFoV0tjdnZhcVRrUk1vcTRVQkdmRUtsT2hhOS9jVlJYNnY4?=
 =?utf-8?B?VTkyYlRWRkwzR21zbm81Z0k1THVWYzlJTWMycGZsRE9mbGptT1FNVVJOUEFK?=
 =?utf-8?B?L3A3ckZsUDVJcngreUhCcVIzRmFoelk4UFE2blIwR2VGeDZlOUpNaFdhZHNE?=
 =?utf-8?B?TGpsZVVDdlZPUlhtT05IQUJpbCtjL2RnYWZ0eVN3YlhxMHRtWmsxUGhJTWs5?=
 =?utf-8?B?NytlVDlNMUtnOURmdXdlWHpsaGVDdW9zd3hhVStWUm9RRDhHUzNKeTVlRkJO?=
 =?utf-8?B?enpCSUJLLzFCamVMb21lc201cys1bVZXRnpOcG1tRTRnRlRteWFtcGc0VUNy?=
 =?utf-8?B?Tlh4SGR2MHZJNlJCamtXYysrWFZTRFVDY05TL0dlSG1OY1V3OW9IWm5hZ1Nw?=
 =?utf-8?B?NUkyM1NKeFhuZ1BUb3RORGgzYTBHSCtINEl3dEQ3OU9pNHJGVUJReHlnd1NH?=
 =?utf-8?B?YTZoMk9BWDFtM2JaM2JDUmtkRkRyOGp3ZlFCcHZpbFFsVWF3N0NQMHZaa3FO?=
 =?utf-8?B?QWhNWWQ5REFSc0VpWXNHYkVYR2hPUm05QUxyMlJuR1RMY042VVR5S3hFZDR2?=
 =?utf-8?B?MHpGYXhnNm9CdXZTTWlBN0lYdG9yQnBxRlEwOHVKRm5zcnJudG9CR3pnZTJF?=
 =?utf-8?B?ZlU2ZnIreEoxZWx0cEJKRTdLWWxSVVlmQTBtUFM1cGY0ZCsvT05nZVgvU1hU?=
 =?utf-8?B?bWlqR1Y0Rlk4RWw2NlJtZ3BZN0J5ZUVOcWRFSlRGTTVzUGFoV1EvMTdDcWN4?=
 =?utf-8?B?TUg3eWt2aHRtdkJQVzdhdjZzNUdLTEVOei9JRkJlWmFDdUxjazlLa0RXc29y?=
 =?utf-8?B?WUpOZUdUZk9OQ0ZhejR3eUZHb1RiZ3Rqd0pCSXhHWmxHVlBFNzhPODV5dUhL?=
 =?utf-8?B?d3gvMUQzNHBQdVNDQlJsNnhJQlpsNDUzdDhpdnRUeE1pb05VOWJXTUF5OFJm?=
 =?utf-8?B?SlNxU1JGMUZUYjVyRmc0bWFOa3M3blE4Z1RZalRUUGhiU1hia3NiRThzUjNZ?=
 =?utf-8?B?QzNwOTdQWU0yVHZmak16bkxDdmdoZFNXMTdIcS8xMExPVlhRVkNVSHR3K213?=
 =?utf-8?B?ZmF5dW9CVml2bkQrNWJobGF4SWppU1prNmlZejBWWHhQWU9nZmtrQUwrYjNN?=
 =?utf-8?B?T2xsMkRkNHBraTRSQWNSbHVqU3FnZUdqSUdvK3NRVDNuRlBjWFgxOFBwNDZj?=
 =?utf-8?B?UHI4S2l2VWtNM1BlcW9La0lvMFNydDRXR1dTT3FnSlhOY1duQjdxOEVPOUZw?=
 =?utf-8?B?OG1DNENNMGFiV2NmOUtxWTBvYjJLMUg1dk5LSWxQenlUcEhPbDRIOE0wdkVy?=
 =?utf-8?B?MEF0dCsrVEhpN0wxa09aUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFJuL05EbVlCd0ZFTGMyZzlXaTl6ek5ia3NPRUM3cTNPdHBYaVNHWWhyVUxz?=
 =?utf-8?B?cjZmRkhZV3NGbk9uY2phSXJ3S01vMWsxc2FBWVFsQzhZRmFUMS9ZRmwvMXFl?=
 =?utf-8?B?VEp0b3k1Z0ZGZzNhS01xeS9JU2U1UVUvY1daMEdGRlg4ZzAxcVN2aXFhemYy?=
 =?utf-8?B?N3dIYm1Jb0F6dXNvU0owNmZOK3Y3TWkrb2ROTVhZaDdFVW91L0hFYllrV29C?=
 =?utf-8?B?bWE2Q2F0ZFlJRXdQdytUaitkeGRHcCtlNjBPZllCem0vbHhhZWZhM0lBbUJV?=
 =?utf-8?B?YVgxU2tvVjUrNXlCY1FhY1pnL0RVOWNJcGQydjNMYklyWlgrS0dsUXlvTGx6?=
 =?utf-8?B?T0hKQ3M3TGVxSlRvSmhobjBmV0pzcXBWT3BWbVlXWnUyNzlUSVpST2xZcVlC?=
 =?utf-8?B?M0FkTmJMaGUyQWtnYmRqUW0xNlFkTXRkS1oxcjM0bm5ORzJ4R3ZqNmVkVEIx?=
 =?utf-8?B?YmFMMVY1bzFIM0dPQ1EwYmlpeU1XcUtRU3VqRVhOdnpwZmxYOU1ERTZQRHRr?=
 =?utf-8?B?MTM1V2hTbHF5TTY5MWxzcXpBSXdFekd6NkFMT2FENk5SQnlsZGEvQXkwczI1?=
 =?utf-8?B?SGxMSmZlbHBoK1lnS24zbmU5TjJTeG1HeW1NSDZYUnpvRWVQbms4aUh1aUNC?=
 =?utf-8?B?MVd6ajBXN24vMkdZNDZZcENQUWU0M250WktRM1Q4NW9YRm1WTCtSaEpWcTVM?=
 =?utf-8?B?Q3lmL2N5V0Z6c0ZTNEQ5VW1JNDBRZzNZbHovb1JESHNURDVUeWlaRnV6aWp1?=
 =?utf-8?B?U29adzZjS3ZXSXFCWWl5cDNnZ3owZW5abTFnbG42NVhOdmpCU3pBKzllMmsw?=
 =?utf-8?B?RDZrTHJQRU5WRmwxekpqNWIxWmo2bGtCZkNHeGY1WWtEZWVIakttRHc3K1ZH?=
 =?utf-8?B?Q2hiRndyM3ZST3NhaVd3cXpoUUJDam5jU2xCOVZqcUJXMURhcWJuSXVCZGxY?=
 =?utf-8?B?UmRpV0lqVzk0WktpSkg5N29HS0lvbGZmRjJLVE9SWUFXT0MvRWUvMXNHTFhw?=
 =?utf-8?B?STgxcGM5OGJ4Tm9Xc041UUozRUJZcDlaVnRJRDNoalF1UDdQVGlaMDJ5TC8z?=
 =?utf-8?B?K0N0MExnK2IrZzVxeHBzQkhBTXdUck5jRzF3aExzakUxeWQzKzVqd0dsUzFI?=
 =?utf-8?B?cUFrV1MzVkF6ZytUR2VTUUdFaXpkZkNsZm5EREV4MHMxeWlpV2xQM0toRmhP?=
 =?utf-8?B?T0tFMXQzOFRJL0JLZ1c5eS9iTXZCaEtQUkdHdnF6SjFJaWU4RW41ZHN2K1Mz?=
 =?utf-8?B?bmhEQXdMRlFGNDAyTVd6Q0pBblFJeUNIZUNPYjF0TG9nT3ZHVmdRR2lPWi8z?=
 =?utf-8?B?clUwZnRoTDFnOWtSZmFUdlFkVmczb1dLR1o1bUZqOUl1a3l3TENXWHJOWW1h?=
 =?utf-8?B?ajkrSExZSnp1OTRZTlZzMXFZdThvQktrRkNmMVNIdVpuQ05pREw2T3FpNmY3?=
 =?utf-8?B?cS8ybHZmOWxjalAvQXcxYmhLT090TWcvY2FabDgvUFlZMnhHc2E5UmJXdnpM?=
 =?utf-8?B?ZkRORWs5UGRERitpTUpsejZod3BweWhZdnh1UU5HR3lqeFJmWEV4bkV6UStn?=
 =?utf-8?B?SE9CL0FibTl6eThpM3kvZG04amVETXdOQmFxTytaYkZCbEQ2MDlxNmdZcXZ4?=
 =?utf-8?B?aGxWa0w4VXBNd2E3WFA5Ly9jM2dhRndEZ2FGVTV5UVdiOWkrdTBUb1BjMXc3?=
 =?utf-8?B?ek05SUM4YmFmRmYwUXdONk53MUl0dU5uMEdZNDlNSGVna2JjUjlEdGJCL3d3?=
 =?utf-8?B?S1JVb09ZRXhIdnA4T2IzZm4wVWRsdGdZTU9yKzR5cEhQSlozR3F5dnJVUUpR?=
 =?utf-8?B?OHdzREg4WlVnbVJpUll5TFF6YjFlU1h4ZVNyMFFZcWhKOUZPM1h5bFRsQ0hk?=
 =?utf-8?B?QUJnVUdHNlF3VTArSzNMTitpK2tmazZTYVdiemxRMHVDRWdBbG92a1BBeDVR?=
 =?utf-8?B?K0FsQ2t0TlBmSkMyUHFqaER1WTBmeW02UlA0Qys1KzFoY3hLZjNwcWRodmtq?=
 =?utf-8?B?MlltVzBrbGs0R05hcWNUOFVNVERDSWVHUGxpOW54R3JjNjM5WHc2b2ZGYy9i?=
 =?utf-8?B?alNSR2NhVjVvZHNWRGxaM3VLUHUwTmRsSnJYZ09pT2JoOGhISm83UHJERVJD?=
 =?utf-8?B?d0g0OGlMMktkUjJsK1lvRTVJZzZCMlFEVXNvcTAyb0xnSC9FTmdNSHZYL05z?=
 =?utf-8?B?ekE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <56BB8A7D75ECBE42A1257B05ED8D75E1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe089ea8-db68-4ef4-8f13-08dcecc8bc0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2024 03:23:27.1813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: heL3wp31pvU3bk2cJFnGywglT1fakWy0R18HNIIXpFv79OGQSxTwR916Z5Nuo9QiuKQYaTTWWb9aE3ZYqnDaXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6791
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTEwLTE0IGF0IDExOjAwIC0wNzAwLCBKaW0gTWF0dHNvbiB3cm90ZToNCj4g
T24gTW9uLCBPY3QgMTQsIDIwMjQgYXQgNjowNeKAr0FNIFpoYW5nLCBSdWkgPHJ1aS56aGFuZ0Bp
bnRlbC5jb20+DQo+IHdyb3RlOg0KPiA+IA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFRCSCwgSSdt
IG5vdCBzdXJlIHRoYXQgdGhlcmUgaXMgYWN0dWFsbHkgYW55dGhpbmcgd3Jvbmcgd2l0aA0KPiA+
ID4gPiA+IHRoZQ0KPiA+ID4gPiA+IG5ldw0KPiA+ID4gPiA+IG51bWJlcmluZyBzY2hlbWUuDQo+
ID4gPiA+ID4gwqBUaGUgdG9wb2xvZ3kgaXMgcmVwb3J0ZWQgY29ycmVjdGx5IChlLmcuIGluDQo+
ID4gPiA+ID4gL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvY3B1MC90b3BvbG9neS90aHJlYWRfc2li
bGluZ3NfbGlzdCkuDQo+ID4gPiA+ID4gWWV0LA0KPiA+ID4gPiA+IHRoZQ0KPiA+ID4gPiA+IG5l
dyBlbnVtZXJhdGlvbiBkb2VzIHNlZW0gdG8gY29udHJhZGljdCB1c2VyIGV4cGVjdGF0aW9ucy4N
Cj4gPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IFdlbGwsIHdlIGNhbiBzYXkgdGhpcyBpcyBh
IHZpb2xhdGlvbiBvZiB0aGUgQUNQSSBzcGVjLg0KPiA+ID4gPiAiT1NQTSBzaG91bGQgaW5pdGlh
bGl6ZSBwcm9jZXNzb3JzIGluIHRoZSBvcmRlciB0aGF0IHRoZXkNCj4gPiA+ID4gYXBwZWFyIGlu
DQo+ID4gPiA+IHRoZQ0KPiA+ID4gPiBNQURULiIgZXZlbiBmb3IgaW50ZXJsZWF2ZWQgTEFQSUMg
YW5kIFgyQVBJQyBlbnRyaWVzLg0KPiA+ID4gDQo+ID4gPiBBaC4gVGhhbmtzLiBJIGRpZG4ndCBr
bm93IHRoYXQuDQo+ID4gPiANCj4gPiA+ID4gTWF5YmUgd2UgbmVlZCB0d28gc3RlcHMgZm9yIExB
UElDL1gyQVBJQyBwYXJzaW5nLg0KPiA+ID4gPiAxLiBjaGVjayBpZiB0aGVyZSBpcyB2YWxpZCBM
QVBJQyBlbnRyeSBieSBnb2luZyB0aHJvdWdoIGFsbA0KPiA+ID4gPiBMQVBJQw0KPiA+ID4gPiBl
bnRyaWVzIGZpcnN0DQo+ID4gPiA+IDIuIHBhcnNlIExBUElDL1gyQVBJQyBzdHJpY3RseSBmb2xs
b3dpbmcgdGhlIG9yZGVyIGluIE1BRFQuDQo+ID4gPiA+IChsaWtlDQo+ID4gPiA+IHdlIGRvDQo+
ID4gPiA+IGJlZm9yZSkNCj4gPiA+IA0KPiA+ID4gVGhhdCBtYWtlcyBzZW5zZSB0byBtZS4NCj4g
PiA+IA0KPiA+ID4gVGhhbmtzLA0KPiA+ID4gDQo+ID4gPiAtLWppbQ0KPiA+IA0KPiA+IEhpLCBK
aW0sDQo+ID4gDQo+ID4gUGxlYXNlIGNoZWNrIGlmIGJlbG93IHBhdGNoIHJlc3RvcmVzIHRoZSBD
UFUgSURzIG9yIG5vdC4NCj4gPiANCj4gPiB0aGFua3MsDQo+ID4gcnVpDQo+ID4gDQo+ID4gRnJv
bSBlYzc4NmRmZTY5M2NhZDI4MTBiNTRiMGQ4YWZiZmM3ZTRjNGIzZjhhIE1vbiBTZXAgMTcgMDA6
MDA6MDANCj4gPiAyMDAxDQo+ID4gRnJvbTogWmhhbmcgUnVpIDxydWkuemhhbmdAaW50ZWwuY29t
Pg0KPiA+IERhdGU6IE1vbiwgMTQgT2N0IDIwMjQgMTM6MjY6NTUgKzA4MDANCj4gPiBTdWJqZWN0
OiBbUEFUQ0hdIHg4Ni9hY3BpOiBGaXggTEFQSUMveDJBUElDIHBhcnNpbmcgb3JkZXINCj4gPiAN
Cj4gPiBPbiBzb21lIHN5c3RlbXMsIHRoZSBzYW1lIENQVSAod2l0aCBzYW1lIEFQSUMgSUQpIGlz
IGFzc2lnbmVkIHdpdGgNCj4gPiBhDQo+ID4gZGlmZmVyZW50IGxvZ2ljYWwgQ1BVIGlkIGFmdGVy
IGNvbW1pdCBlYzlhZWRiMmFhMWEgKCJ4ODYvYWNwaToNCj4gPiBJZ25vcmUNCj4gPiBpbnZhbGlk
IHgyQVBJQyBlbnRyaWVzIikuDQo+ID4gDQo+ID4gVGhpcyBtZWFucyBMaW51eCBlbnVtZXJhdGVz
IHRoZSBDUFVzIGluIGEgZGlmZmVyZW50IG9yZGVyIGFuZCBpdCBpcw0KPiA+IGENCj4gPiB2aW9s
YXRpb24gb2YNCj4gPiBodHRwczovL3VlZmkub3JnL3NwZWNzL0FDUEkvNi41LzA1X0FDUElfU29m
dHdhcmVfUHJvZ3JhbW1pbmdfTW9kZWwuaHRtbCNtYWR0LXByb2Nlc3Nvci1sb2NhbC1hcGljLXNh
cGljLXN0cnVjdHVyZS1lbnRyeS1vcmRlcg0KPiA+ICwNCj4gPiANCj4gPiDCoCAiT1NQTSBzaG91
bGQgaW5pdGlhbGl6ZSBwcm9jZXNzb3JzIGluIHRoZSBvcmRlciB0aGF0IHRoZXkgYXBwZWFyDQo+
ID4gaW4NCj4gPiDCoMKgIHRoZSBNQURUIg0KPiA+IA0KPiA+IFRoZSBvZmZlbmRpbmcgY29tbWl0
IHdhbnRzIHRvIGlnbm9yZSB4MkFQSUMgZW50cmllcyB3aXRoIEFQSUMgSUQgPA0KPiA+IDI1NQ0K
PiA+IHdoZW4gdmFsaWQgTEFQSUMgZW50cmllcyBleGlzdCwgc28gaXQgcGFyc2VzIGFsbCBMQVBJ
QyBlbnRyaWVzDQo+ID4gYmVmb3JlDQo+ID4gcGFyc2luZyBhbnkgeDJBUElDIGVudHJpZXMuIFRo
aXMgYnJlYWtzIHRoZSBDUFUgZW51bWVyYXRpb24gb3JkZXINCj4gPiBmb3INCj4gPiBzeXN0ZW1z
IHRoYXQgaGF2ZSB4MkFQSUMgZW50cmllcyBsaXN0ZWQgYmVmb3JlIExBUElDIGVudHJpZXMgaW4N
Cj4gPiBNQURULg0KPiA+IA0KPiA+IEZpeCB0aGUgcHJvYmxlbSBieSBjaGVja2luZyB0aGUgdmFs
aWQgTEFQSUMgZW50cmllcyBzZXBhcmF0ZWx5LA0KPiA+IGJlZm9yZQ0KPiA+IHBhcnNpbmcgYW55
IExBUElDL3gyQVBJQyBlbnRyaWVzLg0KPiA+IA0KPiA+IENjOiBzdGFibGVAdmdlci5rZXJuZWwu
b3JnDQo+ID4gUmVwb3J0ZWQtYnk6IEppbSBNYXR0c29uIDxqbWF0dHNvbkBnb29nbGUuY29tPg0K
PiA+IENsb3NlczoNCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNDEwMTAyMTMx
MzYuNjY4NjcyLTEtam1hdHRzb25AZ29vZ2xlLmNvbS8NCj4gPiBGaXhlczogZWM5YWVkYjJhYTFh
ICgieDg2L2FjcGk6IElnbm9yZSBpbnZhbGlkIHgyQVBJQyBlbnRyaWVzIikNCj4gPiBTaWduZWQt
b2ZmLWJ5OiBaaGFuZyBSdWkgPHJ1aS56aGFuZ0BpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gwqBh
cmNoL3g4Ni9rZXJuZWwvYWNwaS9ib290LmMgfCA1MA0KPiA+ICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKy0tLS0NCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCA0NSBpbnNlcnRpb25zKCsp
LCA1IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwv
YWNwaS9ib290LmMNCj4gPiBiL2FyY2gveDg2L2tlcm5lbC9hY3BpL2Jvb3QuYw0KPiA+IGluZGV4
IDRlZmVjYWM0OTg2My4uYzcwYjg2ZjFmMjk1IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gveDg2L2tl
cm5lbC9hY3BpL2Jvb3QuYw0KPiA+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9hY3BpL2Jvb3QuYw0K
PiA+IEBAIC0yMjYsNiArMjI2LDI4IEBAIGFjcGlfcGFyc2VfeDJhcGljKHVuaW9uIGFjcGlfc3Vi
dGFibGVfaGVhZGVycw0KPiA+ICpoZWFkZXIsIGNvbnN0IHVuc2lnbmVkIGxvbmcgZW5kKQ0KPiA+
IMKgwqDCoMKgwqDCoMKgIHJldHVybiAwOw0KPiA+IMKgfQ0KPiA+IA0KPiA+ICtzdGF0aWMgaW50
IF9faW5pdA0KPiA+ICthY3BpX2NoZWNrX2xhcGljKHVuaW9uIGFjcGlfc3VidGFibGVfaGVhZGVy
cyAqaGVhZGVyLCBjb25zdA0KPiA+IHVuc2lnbmVkIGxvbmcgZW5kKQ0KPiA+ICt7DQo+ID4gK8Kg
wqDCoMKgwqDCoCBzdHJ1Y3QgYWNwaV9tYWR0X2xvY2FsX2FwaWMgKnByb2Nlc3NvciA9IE5VTEw7
DQo+ID4gKw0KPiA+ICvCoMKgwqDCoMKgwqAgcHJvY2Vzc29yID0gKHN0cnVjdCBhY3BpX21hZHRf
bG9jYWxfYXBpYyAqKWhlYWRlcjsNCj4gPiArDQo+ID4gK8KgwqDCoMKgwqDCoCBpZiAoQkFEX01B
RFRfRU5UUlkocHJvY2Vzc29yLCBlbmQpKQ0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHJldHVybiAtRUlOVkFMOw0KPiA+ICsNCj4gPiArwqDCoMKgwqDCoMKgIC8qIElnbm9yZSBp
bnZhbGlkIElEICovDQo+ID4gK8KgwqDCoMKgwqDCoCBpZiAocHJvY2Vzc29yLT5pZCA9PSAweGZm
KQ0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAwOw0KPiA+ICsNCj4g
PiArwqDCoMKgwqDCoMKgIC8qIElnbm9yZSBwcm9jZXNzb3JzIHRoYXQgY2FuIG5vdCBiZSBvbmxp
bmVkICovDQo+ID4gK8KgwqDCoMKgwqDCoCBpZiAoIWFjcGlfaXNfcHJvY2Vzc29yX3VzYWJsZShw
cm9jZXNzb3ItPmxhcGljX2ZsYWdzKSkNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCByZXR1cm4gMDsNCj4gPiArDQo+ID4gK8KgwqDCoMKgwqDCoCBoYXNfbGFwaWNfY3B1cyA9IHRy
dWU7DQo+ID4gK8KgwqDCoMKgwqDCoCByZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICsNCj4gPiDCoHN0
YXRpYyBpbnQgX19pbml0DQo+ID4gwqBhY3BpX3BhcnNlX2xhcGljKHVuaW9uIGFjcGlfc3VidGFi
bGVfaGVhZGVycyAqIGhlYWRlciwgY29uc3QNCj4gPiB1bnNpZ25lZCBsb25nIGVuZCkNCj4gPiDC
oHsNCj4gPiBAQCAtMjU3LDcgKzI3OSw2IEBAIGFjcGlfcGFyc2VfbGFwaWModW5pb24gYWNwaV9z
dWJ0YWJsZV9oZWFkZXJzICoNCj4gPiBoZWFkZXIsIGNvbnN0IHVuc2lnbmVkIGxvbmcgZW5kKQ0K
PiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBwcm9jZXNzb3ItPnByb2Nlc3Nvcl9pZCwgLyogQUNQSSBJRA0KPiA+ICovDQo+ID4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHByb2Nlc3Nvci0+bGFwaWNfZmxhZ3MgJg0KPiA+IEFDUElfTUFEVF9FTkFCTEVEKTsNCj4g
PiANCj4gPiAtwqDCoMKgwqDCoMKgIGhhc19sYXBpY19jcHVzID0gdHJ1ZTsNCj4gPiDCoMKgwqDC
oMKgwqDCoCByZXR1cm4gMDsNCj4gPiDCoH0NCj4gPiANCj4gPiBAQCAtMTAyOSw2ICsxMDUwLDgg
QEAgc3RhdGljIGludCBfX2luaXQNCj4gPiBlYXJseV9hY3BpX3BhcnNlX21hZHRfbGFwaWNfYWRk
cl9vdnIodm9pZCkNCj4gPiDCoHN0YXRpYyBpbnQgX19pbml0IGFjcGlfcGFyc2VfbWFkdF9sYXBp
Y19lbnRyaWVzKHZvaWQpDQo+ID4gwqB7DQo+ID4gwqDCoMKgwqDCoMKgwqAgaW50IGNvdW50LCB4
MmNvdW50ID0gMDsNCj4gPiArwqDCoMKgwqDCoMKgIHN0cnVjdCBhY3BpX3N1YnRhYmxlX3Byb2Mg
bWFkdF9wcm9jWzJdOw0KPiA+ICvCoMKgwqDCoMKgwqAgaW50IHJldDsNCj4gPiANCj4gPiDCoMKg
wqDCoMKgwqDCoCBpZiAoIWJvb3RfY3B1X2hhcyhYODZfRkVBVFVSRV9BUElDKSkNCj4gPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FTk9ERVY7DQo+ID4gQEAgLTEwMzcs
MTAgKzEwNjAsMjcgQEAgc3RhdGljIGludCBfX2luaXQNCj4gPiBhY3BpX3BhcnNlX21hZHRfbGFw
aWNfZW50cmllcyh2b2lkKQ0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFjcGlfcGFyc2Vfc2FwaWMs
DQo+ID4gTUFYX0xPQ0FMX0FQSUMpOw0KPiA+IA0KPiA+IMKgwqDCoMKgwqDCoMKgIGlmICghY291
bnQpIHsNCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb3VudCA9DQo+ID4gYWNw
aV90YWJsZV9wYXJzZV9tYWR0KEFDUElfTUFEVF9UWVBFX0xPQ0FMX0FQSUMsDQo+ID4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgYWNwaV9wYXJzZV9sYXBpYywNCj4gPiBNQVhfTE9DQUxfQVBJQyk7DQo+
ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgeDJjb3VudCA9DQo+ID4gYWNwaV90YWJs
ZV9wYXJzZV9tYWR0KEFDUElfTUFEVF9UWVBFX0xPQ0FMX1gyQVBJQywNCj4gPiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBhY3BpX3BhcnNlX3gyYXBpYywNCj4gPiBNQVhfTE9DQUxfQVBJQyk7DQo+IA0K
PiBUaGUgcG9pbnQgaXMgbW9vdCBub3csIGJ1dCBJIGRvbid0IHRoaW5rIHRoZSBwcmV2aW91cyBj
b2RlIGRpZCB0aGUNCj4gcmlnaHQgdGhpbmcgd2hlbiBhY3BpX3RhYmxlX3BhcnNlX21hZHQoKSBy
ZXR1cm5lZCBhIG5lZ2F0aXZlIHZhbHVlDQo+IChmb3IgZXJyb3JzKS4NCg0KUHJldmlvdXMgYW5k
IGN1cnJlbnQgY29kZSBjaGVja3MgZm9yIHRoZSBuZWdhdGl2ZSB2YWx1ZSBsYXRlciBhZnRlcg0K
cGFyc2luZyBib3RoIExBUElDIGFuZCB4MkFQSUMuDQpzbyB3aGF0IGlzIHRoZSBwcm9ibGVtIHlv
dSdyZSByZWZlcnJpbmcgdG8/DQpEbyB5b3UgbWVhbiB3ZSBzaG91bGQgZXJyb3Igb3V0IGltbWVk
aWF0ZWx5IHdoZW4gcGFyc2luZyBMQVBJQyBmYWlscz8NCg0KPiANCj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAvKiBDaGVjayBpZiB0aGVyZSBhcmUgdmFsaWQgTEFQSUMgZW50cmll
cyAqLw0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFjcGlfdGFibGVfcGFyc2Vf
bWFkdChBQ1BJX01BRFRfVFlQRV9MT0NBTF9BUElDLA0KPiA+IGFjcGlfY2hlY2tfbGFwaWMsIE1B
WF9MT0NBTF9BUElDKTsNCj4gDQo+IFR3byBjb21tZW50czoNCj4gDQo+IDEpIFNob3VsZCB3ZSBj
aGVjayBmb3IgYSByZXR1cm4gdmFsdWUgPCAwIGhlcmUsIG9yIGp1c3Qgd2FpdCBmb3Igb25lDQo+
IG9mIHRoZSBsYXRlciB3YWxrcyB0byBlcnJvciBvdXQ/DQoNCkknbSBva2F5IHdpdGggYm90aC4N
Cg0KPiAyKSBJdCBzZWVtcyB1bmZvcnR1bmF0ZSB0byB3YWxrIHRoZSBlbnRpcmUgdGFibGUgd2hl
biB0aGUgZmlyc3QgZW50cnkNCj4gbWF5IGdpdmUgeW91IHRoZSBhbnN3ZXIsIGJ1dCBwZXJoYXBz
IG1vZGVybiBzeXN0ZW1zIGhhdmUgb25seSBYMkFQSUMNCj4gZW50cmllcywgc28gd2Ugd2lsbCB0
eXBpY2FsbHkgaGF2ZSB0byB3YWxrIHRoZSBlbnRpcmUgdGFibGUgYW55d2F5Lg0KDQp5ZWFoLiBU
aGVyZSBhcmUgc3lzdGVtcyB3aXRoIGludmFsaWQgTEFQSUMgZW50cmllcyBmaXJzdCwgYW5kDQph
Y3BpX3BhcnNlX2VudHJpZXNfYXJyYXkoKSBkb2Vzbid0IHN1cHBvcnQgZ3JhY2VmdWwgZWFybHkg
dGVybWluYXRpb24sDQpzbyB3ZSBoYXZlIHRvIGNoZWNrIGFsbCB0aGUgZW50cmllcy4NCg0KPiAN
Cj4gUmV2aWV3ZWQtYW5kLXRlc3RlZC1ieTogSmltIE1hdHRzb24gPGptYXR0c29uQGdvb2dsZS5j
b20+DQoNClRoYW5rcy4gSSB3aWxsIHN1Ym1pdCB0aGUgY3VycmVudCB2ZXJzaW9uIHRvIGtlZXAg
eW91ciB0YWdzLg0KDQotcnVpDQo=

