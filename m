Return-Path: <linux-acpi+bounces-6755-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6E592585C
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jul 2024 12:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F19E1F2499E
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jul 2024 10:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8888815B134;
	Wed,  3 Jul 2024 10:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CdJ4ljgv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CCE155A39;
	Wed,  3 Jul 2024 10:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720002191; cv=fail; b=CLAbEt9GU9Qgfq7y5cLNi3vUaiZctZ4MFStljt5BfvKvuxyw2RTrQLdTnXZyWw5AT/m+PR1Aarf4LopHoXGn5Vr/Wl07ftwCpUIoEZCWILGM+ooFm5gOHiVq4/jeXufS9xxIJuKXPdLaByNlDywN2AN+5nU7yfFGG5goZsRHIBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720002191; c=relaxed/simple;
	bh=Qhj31BBYrYeXxxsPXRwbyKP5sBL/7pAXmpMz+WSUy0U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f6fM0s4/9HvZ2rUw/9a2JKNIsXzDEdkDeHyKgkdYazaIoj6tgnwbbmeFjcweji9PSQoPH0ab8SgUFRhmfaXs2Vl0MhFxCTh4xDeFNeBeyAU/cmddPO+Uhp2xVuqPtqRqKOv+uhY7+udl/JtMpISyHuW5A5iVI6MSHNRI161Lhpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CdJ4ljgv; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720002190; x=1751538190;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Qhj31BBYrYeXxxsPXRwbyKP5sBL/7pAXmpMz+WSUy0U=;
  b=CdJ4ljgvp/SEvWKQA8ecznktoXsVKmTwgljgyVxBj+6uBbskMLzdmLOv
   6le1ew8uHoh7v5z3rD0RlaJ3ibFeZBVtN4LAz/LsSdCRYXx2ws+N/rrpe
   NIRIfxTaeuGyVYIfQTzfbIXWop04vNQFpJOlxeg4Su3+mc0Nn2HvgCPsj
   yZtFQPzv5GXAjcvGFCIWw2RXjNQ4Nt7uoi5v7HR1aJrLhesbOnkf2DzhM
   4l18Tjq1D8zNVARGb4kGYUBbFEggC/OIEelNwD/sYHuJMCl+aeXemrcoq
   3W3Xv9blAQ2g9Or+GbuRIvWXHp7xpxrx8C69L7J4YxPp4NRJl6OpUZLc4
   w==;
X-CSE-ConnectionGUID: UhMF4JhYSiqVEuJ+MaTxSg==
X-CSE-MsgGUID: nczJPpptRF6c5XFkhTzeQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="21032816"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="21032816"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 03:23:09 -0700
X-CSE-ConnectionGUID: 4cb2D3RITNa3oaARv+FelQ==
X-CSE-MsgGUID: +VfvoJZETjy/g31ws2gRIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="46350371"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jul 2024 03:23:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 03:23:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 03:23:08 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 3 Jul 2024 03:23:08 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 3 Jul 2024 03:23:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=czs/brL3tMVxWLz2wK0u/2WxtZCGqmK+T46mhvN6g/2+fn9LJ7w+Et1OvgS3fHtecHu2fSW9sssNvLQKNurVPSpKnFQT7ez9LAFb2bkVnBZa713dJyyVkrJBurbmU5T48aO2HXSSiG3D70L1HohwJo1mhzObvmZuM/sn/4ZprgyxnjzAevJS9AdCUtvX64dtXvcCGAs26hay2WnD7ko1aIAruHlYT/MRVN1CoGN/zSBERR7L+2HkULGz5O2Qv21tzt5nWo3oiWYRJOc829yk2Lqtrg/9s6C8WYGf1iBptJSK2oP8EgaQ6UJ4vtKGgdSAnCoS9TitbybH7KP68u15nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qhj31BBYrYeXxxsPXRwbyKP5sBL/7pAXmpMz+WSUy0U=;
 b=ep7i7V2GTtLZwSgguxg0ulSd3zCh7TQhmS5v8ptu+o8EyPFkQYlYQeCP5Nhv/YZENUuCCxDciwbT/oyFDXU0aHJ+VtuH4WtE1ZNRzwvEQwFZvpbhOHeO5g4XS39v7wYBhdDLtnw9/Akgp3x1BC0GNUSaYhhoZEP+Z/mpWnVLtCqhIEqrkMCdPOHNEZey1ULvL8kPx2Snft2xLhuAsW84MUkNyTnDpA0yPn4e3/VVLIaUqm+JIlV+tfgfmOz2UH/7i1hZ6iWF6e4NpL1iZT7/84iM9qMDwT6ma1T7g3VHL+xHMaXdYIdaN9/pgo9GIo2ljt5zuXbfWbzlLJCgsfY+PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SN7PR11MB8264.namprd11.prod.outlook.com (2603:10b6:806:26c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Wed, 3 Jul
 2024 10:23:04 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%5]) with mapi id 15.20.7719.029; Wed, 3 Jul 2024
 10:23:04 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "luto@kernel.org" <luto@kernel.org>, "rafael@kernel.org"
	<rafael@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>,
	"peterz@infradead.org" <peterz@infradead.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "bhe@redhat.com" <bhe@redhat.com>,
	"x86@kernel.org" <x86@kernel.org>
CC: "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ardb@kernel.org" <ardb@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"tzimmermann@suse.de" <tzimmermann@suse.de>
Subject: Re: [PATCH 2/3] x86/acpi: Replace manual page table initialization
 with kernel_ident_mapping_init()
Thread-Topic: [PATCH 2/3] x86/acpi: Replace manual page table initialization
 with kernel_ident_mapping_init()
Thread-Index: AQHay7R0Lq0refvg90+xl/1YurPbQrHkzo2A
Date: Wed, 3 Jul 2024 10:23:04 +0000
Message-ID: <846ad46e6a843a9fa5a07acb6bbfda64fab07875.camel@intel.com>
References: <20240701124334.1855981-1-kirill.shutemov@linux.intel.com>
	 <20240701124334.1855981-3-kirill.shutemov@linux.intel.com>
In-Reply-To: <20240701124334.1855981-3-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SN7PR11MB8264:EE_
x-ms-office365-filtering-correlation-id: b96440e7-b8d7-4077-6563-08dc9b4a2001
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?aGh0Z2RVZTBqbC9BL01qSFJpd1R0RmwzNFMyVXh6dTd1OHFIb0JDTVVjYVFO?=
 =?utf-8?B?V0E3NzJWakdoRXp3MmN3V3hHdGZneEpTVmYrR3diYnVOdDRIWnVnSFNOV25H?=
 =?utf-8?B?RklNd0ZKR3NmR0hrZGxKU1FyRTcweHVaMnI1SERGT2pkSEIvVUsxSnVTR1pw?=
 =?utf-8?B?RnRaczZCYzRLZTZXSkpUSlphNFZ0aGNrcTJ1eWkwWkhxdTNmS1RqT3lFMEtE?=
 =?utf-8?B?b0E5U2RQaHM2dWxBbVVrMU1iaURhczlhWWFDUWxnVkR3ZVUvb2tEbWhZNzQw?=
 =?utf-8?B?MmtHYkV2YkV1c1ZsUnAyQVUzUVJuTFlmUlFZTHk5RVNPUjh1UitId3JQZzh4?=
 =?utf-8?B?ZnRLVjBhWEtmTXZtbnhISTk2SFpuWm4ya1prNE5DbTZHdFE5Vjh6OVFucnZB?=
 =?utf-8?B?L3FOUGJmeVZmV01Gb1RPd2hrN2VTZFZveEN6M1hnMjR4b1Y4T3ZpV3FXRDRr?=
 =?utf-8?B?elFCUjJYUXlGUW1RQUQvcnJUQ01hU0ZURXlnZk1hNW9uaDVkU1Y1WU02Q1dY?=
 =?utf-8?B?S0MwOWVMbzN5RVJDTGtMK3FKV2JqczdEcjJoaGkvLzNhZmZwWXBsS21mb3Jr?=
 =?utf-8?B?QVZzcjVSQmhqUVNDbytLMFFXb0NhMEs3dGVPS0pVZ25MekZsWm9qRDBNcG9Y?=
 =?utf-8?B?M2lHRk9sTVMwSXJEVngwQUMyQlFleWhVZXpNMS9oVnNIYXBnMU1YZm1hOVNQ?=
 =?utf-8?B?NkdibXRDQzFyTFZxeEExQ0p4WEhneXp6RUtXUlkrRjVjanR3dndibCt2OGs0?=
 =?utf-8?B?enNYVS9PclFRcG4vUDBBZFVOcDQ3bFNiWUd6NTNTNVRlYmFINGhaeTFPM3Rv?=
 =?utf-8?B?NDFWVjBaS0J2cE1lZE1WbkJYWWRLQ3Q4dzhuOG0xNUp1Z0FwcktyY2tEbC9i?=
 =?utf-8?B?UzZGcVo1bk4wcXd0ODB1cE01VFI3TWYzc3lFQXRBUGdPd0l2bW9LbUtYRmFU?=
 =?utf-8?B?eFFzZmlsQ3ZMeW0vMnZHOUcxUnRmakhna2MvWjVjN0llQzBwS2k3VkVvSVNX?=
 =?utf-8?B?L0ptZnp3cThVQU5yeUxhNTlLN3JpYVYvWVFJcys5dzVtdWdZaXlyNERzTm1Y?=
 =?utf-8?B?bm9KN01lWExwNU5xdjMvN0R1VXNPZVhhZ3l1VERFOUJ3dlcvUW1kZTRuRlZL?=
 =?utf-8?B?ajNMRXZ3c3h5YW83UUpzRGxaeG9NZk9lTll1SkV1ZG0waTBsNVVsNTNlYkRu?=
 =?utf-8?B?WFI2bWt3T1ZHODRrNXdSRkc2WldBTDBsVEFxV2NTTVdwWGNaRTJia0xjOEhs?=
 =?utf-8?B?YmNhMHhKa0NTNXA5VFE1U0dqeTA4WnVZMm9GZXF5eGVDUE1zR1hFY0wySVIy?=
 =?utf-8?B?L0tXdXMvYXUxS0dJNDZtWTZ0cnJmMlh1aE80NHB5ZmMrQnM5dXFvdEIrdU9X?=
 =?utf-8?B?UndNUDFhUFo4UFZDZTBveTY1TUxGMlE5WkV2UlNrdDd4TlU5ajJ2Z1lkaGcx?=
 =?utf-8?B?bGtIMVdXaEY3RngrTzlhSWhCcmI5TVF6eGRVWGhvOFZWMVBUcmFMTTl6djBT?=
 =?utf-8?B?Q3lYeW4vaVFoNmNKVTF2QjVWdWxUYTJuQUsrWmFaem9TS0d6cWxVQy9wTEw1?=
 =?utf-8?B?UDNQbHBSRWhLV21WNndwNGFGdjEwanV2Y3hOK0Q4L3BSOU16a0dkR052cEdm?=
 =?utf-8?B?K0MxM3VrVWJFTXpPc2ROSHpSTW5BKy85RlNMSjhRRHF6OVRuc0g0VDZvV3NG?=
 =?utf-8?B?eDR1aVFnSnA1UVFadVVKSTh2N1ZiSnYyc1NLYUw5a2tqVzk4N0g4WEVyNDkr?=
 =?utf-8?B?Yjk0aXdDd1RjbUwwSmxkS2FRcXlURXVxd3hTOVcvTG5NMFgxaFMxS0t4UVRS?=
 =?utf-8?B?MUpOWE9hOHB1SEg5WEVVRWpEdWZrT0Fta3pUY0VLWlZrazBVQ1lBSzhHUjF3?=
 =?utf-8?B?MU9EM3NCc0dnNGhnRU8vWFVPUWdWb01TUndSaHgzV0UyNFVNaTJBTXp2ZHh5?=
 =?utf-8?Q?kzGpnCIDlI0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkJzVWlCbjNwcUcwWWtYU0lacDQ5NGEyc25xWVFlRHowa0VDdVQwL2xFaEty?=
 =?utf-8?B?bllsS1JQS1Q1YXVPRGZCbTU1ZW9IdlB0MkdBOThrZWtIZHQ1bWRjalNnVTh4?=
 =?utf-8?B?cDd1YXB6QmovY3p2T0JHM2RzQ3p2bzJkZ0RWc0dCaDBacVo4a1N3ZnBkaVRl?=
 =?utf-8?B?U2ROUG9IUC9LTWY5ZGp5UFM2Q25ER3hOZ3plcjJQT0VkczlHck9qWmp0Vlhl?=
 =?utf-8?B?eUJSUzZuekViajBHQW1ZY3FKdnVYWmxjK3dCdThaalNLNWY5a3RsWHg5SC93?=
 =?utf-8?B?UWR1aG11eEhkMG9LUnBTWi9uS0x3dWQveHNDckZUSWoyRGdBYUFvMm56QjVx?=
 =?utf-8?B?aXluWEpoV0JaS3VFa1BLWm5sc2JzR0NsS0Fvb01JOFlCMTdNY2lxM2ZCcmJm?=
 =?utf-8?B?UzB5SlR3aTV2M24xcmtWYTlRaFJCYnhlYy9CMjJkTVVzdExvRjJjb2dQOE5M?=
 =?utf-8?B?WWw3bUxJZm9wSHJua3hwMExBZ2poazhKekRvZDhWR2hLeFUwTk1WWmhzMHYy?=
 =?utf-8?B?eVhXYUVSWWFtZzYwL25IS0RuTDg5TlhrbVV3eWE1TUNHNjYySE5OUWRoRUgy?=
 =?utf-8?B?RGh3dDRta3dUNzI5dGRtblRVT256S2NjRjdFYXNlbVp0ay9SMXNBYWtRaFRE?=
 =?utf-8?B?d1ova2FMc3oyOGUvR2E4WmRhV0ltNlhYTU5Hbk56MGdSamtBc0ZUQmIyQVRX?=
 =?utf-8?B?NjBFaXcybjgxTDhmT3NUMHArS2Z4YlBSdmhucmV5Wk9ZTUU3RmlPMnNWM2k2?=
 =?utf-8?B?NTE2cEgybk1GY3k1S1h3SUZQNUNiQXJwVUo3QUcyQ0dOSE9zaVFZQ3JvcVdr?=
 =?utf-8?B?cEpqYThmbVJMeHoxQUNEVDRscFNjY09UcUg4a1dlNzhQaG45Vm9TU0crVU5s?=
 =?utf-8?B?TURENitDVW5uT3B2Nkx2UjBXWlJadzB3djhSYnJsbjNZcVdUSXQ4QUhPd1lw?=
 =?utf-8?B?OG13L1pkME1UbWcwcmpwY3doczYxUXQ1NWRIRU1WU2RSYmJ2czlUTnRkRml4?=
 =?utf-8?B?OU9obkN1S0dPSEwzQWpaNWhSUGVvNTE3TFdCY015NlFRejRvVEVlZHpjMlMx?=
 =?utf-8?B?bnhlNCtkL3Brd1RDMlVvbEFLeSs0YldMeWxFOEUzZ2REcHRlNGtWRDBrWFps?=
 =?utf-8?B?VjJiRTRJQ294aDJBYUZDUzVDUG1PYnlJSEJCNGY2d245dUQwTGNuQWpBSHE1?=
 =?utf-8?B?YkxJejBydnpJUTdmYmErcjQyT3Rlem5iV09xRHFvcDZObWFrWGZ5SXB6T2dW?=
 =?utf-8?B?UEhNeCtXUlNXM0pydFFwRDRmeUh4UGFQRFQxNWlSdXJZRFkzc3VZaXVoa0Rx?=
 =?utf-8?B?ZkxJN0lsV0JNVGJzcnRQMHdiK1lZNnFXOTZ4KytPMEE3aHJLVTdidkNRbWhw?=
 =?utf-8?B?MDNlaDZCclRJTUZJVXBUQnIwQ2tjWlFDM2pKZVJIZlhBVWxLN3BmSHJDUmtn?=
 =?utf-8?B?eklMdHQzTzJMa1BXUXRYRVBuM3dmRXJxcFVLSHVzb2RKMGFiUVA5QlZjMGxO?=
 =?utf-8?B?bjNMZW52cXZuenAvQnRXdjNEbjduSEpqMVMwbnZ5dHhTUmEweEVkL2NkakJp?=
 =?utf-8?B?aHRUWVNyODcrMzlCYmtBUm1PcWdHa1JXNXAxVVhmaWd2NVZ3djM2SzA4b3Vr?=
 =?utf-8?B?empUVytDQkdwNm5wbjh2OGVacWM3YXE5MmcwcEhGVUVvUnQyem40aTI0dEM4?=
 =?utf-8?B?ZklnZW1BMzg3TWgrbmt4dEw1ZWpFSTlaRDdtUWs3TE0wM2MzNGg4eXMycjBM?=
 =?utf-8?B?QmxMenJxSmUxOHZQVENwbnBUWWtiaVd6UFhuNHdUUkkxVkV2bno1SFQxV0xa?=
 =?utf-8?B?VG81dlo0V0Q1QkVqMGxOVGhKcGFRbEhsTlJEQ05EUU8rZno0UnFrSjlkbytn?=
 =?utf-8?B?cEtHNDhsMmVUeE9vSEY0a204b21VazB6YTVseVBkb2dheS9lVTNBTkZ1R3FR?=
 =?utf-8?B?dEZyOFBKZ0NnNzl4cjRRcmlMTFRBajUyYi95Qk5iUzdzeU0za001dndLTGxJ?=
 =?utf-8?B?U2pkNEZPUDJ2eXVJYjlyeTNKSmZkNzB0YjRRMWpsdllIN2dyVzMySmFCblhx?=
 =?utf-8?B?ckdWaUpTV3ZCK0VJMVhPN0VLbjNBbVF1WFhlTzF0TXVHcERYU2dtYTh6SmRy?=
 =?utf-8?Q?Sq4oIayjQmC4+8fpcQBdWWx+1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C9018EC254C01C44B6D7CCD167C59B76@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b96440e7-b8d7-4077-6563-08dc9b4a2001
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2024 10:23:04.6274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dYfb745sjdcxMvCAXIEHLbfsOYSUZn2ehSCk3MVBQfVGIdItvZgZ9Tno09buu/aNocPVkcOp2k4r0BtARzH0JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8264
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTA3LTAxIGF0IDE1OjQzICswMzAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IFRoZSBmdW5jdGlvbiBpbml0X3RyYW5zaXRpb25fcGd0YWJsZSgpIG1hcHMgdGhlIHBh
Z2Ugd2l0aA0KPiBhc21fYWNwaV9tcF9wbGF5X2RlYWQoKSBpbnRvIGFuIGlkZW50aXR5IG1hcHBp
bmcuDQo+IA0KPiBSZXBsYWNlIG1hbnVhbCBwYWdlIHRhYmxlIGluaXRpYWxpemF0aW9uIHdpdGgg
a2VybmVsX2lkZW50X21hcHBpbmdfaW5pdCgpDQo+IHRvIGF2b2lkIGNvZGUgZHVwbGljYXRpaW9u
LsKgDQo+IA0KDQpkdXBsaWNhdGlpb24gLT4gZHVwbGljYXRpb24uDQoNCg0KPiBVc2UgeDg2X21h
cHBpbmdfaW5mbzo6b2Zmc2V0IHRvIGdldCB0aGUgcGFnZQ0KPiBpcyBtYXBwZWQgYXQgdGhlIGNv
cnJlY3QgbG9jYXRpb24uDQoNCkkgZG9uJ3QgdGhpbmsgdGhlICJpcyIgaXMgbmVlZGVkLiAgSnVz
dCAiLi4uIGdldCB0aGUgcGFnZSBtYXBwZWQgYXQgLi4uIi4NCg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogS2lyaWxsIEEuIFNodXRlbW92IDxraXJpbGwuc2h1dGVtb3ZAbGludXguaW50ZWwuY29tPg0K
DQpSZXZpZXdlZC1ieTogS2FpIEh1YW5nIDxrYWkuaHVhbmdAaW50ZWwuY29tPg0K

