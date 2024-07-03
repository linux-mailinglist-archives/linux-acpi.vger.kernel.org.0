Return-Path: <linux-acpi+bounces-6754-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC2B925815
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jul 2024 12:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B32FB2801A
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jul 2024 10:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47F217556C;
	Wed,  3 Jul 2024 10:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jTCM7/ty"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347E3170858;
	Wed,  3 Jul 2024 10:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720001521; cv=fail; b=PlH/ihzUexqirpoNc4GnboR4ia8cuxNELNTL88Ng7DAnfJKzqPd2KnB14ZWXO2xsCEJ7bD4rWGGU4URHkHXABVBiNsatuedXuTuhKwLmux5qFujUzNht6CtEf/oENhKHpzYX/Ckh3LMMN2eI4/OR1/Z9bLVXoGJ3vJe20EO5Y5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720001521; c=relaxed/simple;
	bh=YLTlrOdZWPzbVoiu7TcT3d4mXwMy6aQ9kNAVTaf7cvY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JYtP8jyHn+t2TSuQd1hNyS74osm6R4mTqITHWg+K9kkqHhmkmBNXrS3jRELWhJCoKWW/oE2yaO66Y45Bq26rmKBPftPz66GvZ4Djkfz+AjJEks+0XkFzzm83cYyop6sgkfeI45jeYUrfVYyXPrB0ANfbDWgDgLYiClZHb8AJLQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jTCM7/ty; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720001520; x=1751537520;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YLTlrOdZWPzbVoiu7TcT3d4mXwMy6aQ9kNAVTaf7cvY=;
  b=jTCM7/tyufbYFYWMogz+G86lSOGD6FjzAdKf/EAA/VcaLUOTeqVsP37V
   HJhBLvKyvcM/J9vQ0zJcENIlUrHY8YpHhHa1WLYJG+nEsgNOrRoFqHGAR
   FzW3ksO8O4YfzMS9PxeZBn19GNywYfoFGK65DfkFJ7hmMFhrv3gE+k33o
   DbYh5jv9WEnV9Jc+KaecqB+N1QOeYraW0LL+zqQTy2nW+ncWZaFsCeVMp
   uDzr8uC90QqAanBljvPjX3Pgt6Yvn60HPw9ZaNg84XyGXdIxDsZNgdlEY
   CqSaHEmazANUn1sM8dlRFdb3P7TNqOtZCAFGgyFN9z45GwmOQmU1z4pRk
   A==;
X-CSE-ConnectionGUID: v1oWaVuoRfmQYJvzX+ycKQ==
X-CSE-MsgGUID: 7YY3KeewQ1ygU+wMR411pw==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="17355951"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="17355951"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 03:11:59 -0700
X-CSE-ConnectionGUID: jBpFyEHCRYSWmDmPJ6ou8A==
X-CSE-MsgGUID: sTZCUzTwQRu7k2MWmg8oFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="83759290"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jul 2024 03:12:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 03:11:58 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 3 Jul 2024 03:11:58 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 3 Jul 2024 03:11:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iGdM4TI01P9jnExXNUccwgwJJujw8Jk9IqXIHMAca7iotL6lZkxZaj7l1AnfOym85MD0tQajoCjue6SSr54m7+SdkvPXMpuJeJV+KvSm3MiNS6OQfjG9FpHzRXrEwuiL6Yx4JUpIavC7lwB9Fvk6+0UleIa+s8aIdPVCEAPpKim64L9HyMU++jxCSF2sYF9yHch0j+1QhJ11/OhTedtgAKQHMKvHqVuaPUJo+09vgv//JVwAqlCG9vBwLf6GJvH4Nb8+EE0daJMTfRdIpRbWx6FraTK4T5iG/J44ywpU+k5DuyQzg2gcK1wZaQRU+z2hg79hKI6bMxPd/BZ8xey/mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YLTlrOdZWPzbVoiu7TcT3d4mXwMy6aQ9kNAVTaf7cvY=;
 b=dnxjANGvzxi2OZcNS49uLCugnke+3IajopSRpZyJrROgmvi5YK8t2MJCQ5iFGPiwLIlDzCcLmMcFlddtm/pZmyLQu7qOfbRe0CTgeTOveqsUzkGTkztDI7Bsi6EllmLPrAkrn2HTCTDmWyXO/jPVOzeD45lByx/f6UMf0aO9ap0R3hM4Nn+N461REzd9maneI9XyrvfKQi8Y4UclaK5vH1j1FH/a7tLKMFY+vs7gn4817YjsXE/3sYkNx8rEsgsdiJnUgt9C7WNvCNgFewW7FVBbL3zYsKOBfodHKzSo2JcqazlSa69rJkZXrQRH7HANGlq40r5/w9zsDcjOiERt3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM4PR11MB6382.namprd11.prod.outlook.com (2603:10b6:8:be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.39; Wed, 3 Jul
 2024 10:11:43 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%5]) with mapi id 15.20.7719.029; Wed, 3 Jul 2024
 10:11:43 +0000
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
Subject: Re: [PATCH 1/3] x86/mm/ident_map: Fix virtual address wrap to zero
Thread-Topic: [PATCH 1/3] x86/mm/ident_map: Fix virtual address wrap to zero
Thread-Index: AQHay7Rlp2y4GfBam0ObiEoUKdlij7Hky2CA
Date: Wed, 3 Jul 2024 10:11:43 +0000
Message-ID: <79bce11cdaed0c64e4bc65840816b853023cb58b.camel@intel.com>
References: <20240701124334.1855981-1-kirill.shutemov@linux.intel.com>
	 <20240701124334.1855981-2-kirill.shutemov@linux.intel.com>
In-Reply-To: <20240701124334.1855981-2-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DM4PR11MB6382:EE_
x-ms-office365-filtering-correlation-id: a57df86f-7351-4e1d-471b-08dc9b488a12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?UlBSMjNnWFJJY2FYSjc4d3lHY1NTeHBZWTVKN29jclJQSm1RTjJBNTRjRUdU?=
 =?utf-8?B?SmdCUDRUQkxpc2dwcG1YK21aZUlvZm50MENoZThuc1hTUlI4YUVieVdiQ1N6?=
 =?utf-8?B?MWdndXZiTGRWWXBNQ21uczJiVkxaS1AxcmZlQWpvU1Jzb2VuNEVPRTBhWnFv?=
 =?utf-8?B?TFJnZFQ1NVdiSkVKWjZMaVdYMVJpR2xNWUQvNGYyOTIrSlFmN2g2djIyMjNG?=
 =?utf-8?B?SFY4WjMzN2ZYeHhMcDlod2Q2TUxlWkt6em9jWEFja1UweVdxVU1RUHA2ckpr?=
 =?utf-8?B?QmNMZVk0UCtSNTIvNGtLZ1g4T1pvWncyc2xVd1RLSHlwK2JFZUZvN2xRQVNH?=
 =?utf-8?B?SStDZlFMUU5XYnFkRlplNnBUNWJlNG54cGxoNFRqMUI1NGhwWWI1K1J1WlFU?=
 =?utf-8?B?SkhONVl0TlI5T1VGK1ZNR1RzcUo1Nkx6dEY5Z0kwSURzU1hjR3pUMjByU1kw?=
 =?utf-8?B?aWt0Z3kycVQwNUpna0dLTnpKbGFuOG92QW9MdW96M1dCNlNmbVBCNnZFUGhD?=
 =?utf-8?B?SDRBTGRuSFNzdHU4Yi9FcUo1dmRUUlNDZHVNNHNhV0hScitmRmxNRjNwV0RY?=
 =?utf-8?B?L3RNRjQ4MnhBcit6UzlkMDZERTQzZWRkUVdmMjg1VFo0VldmZGNWb2JOMlUy?=
 =?utf-8?B?MkU2c3NudjEyNUNLcE90WFB0UTRQNU9LS0lzZ1pNRi80T3dnK0ZLd0dLSWtG?=
 =?utf-8?B?cGlnN3FIaEUrQUozc29xY0MwL3Jhakx3a2hDRytMY2pOcUhrdHVOQy9idmtN?=
 =?utf-8?B?MnNYK2lBU1FMMnY1OWZ5QlY0dXR2WWF3c0FXVFdEZHFHRVFmbTFmakhtd1hx?=
 =?utf-8?B?TlRiOFNXTHAxa0JVRUtoWjZabTdyVXZ3QjhLRkdnVnVUVXRzbkVXZUpNVHpE?=
 =?utf-8?B?Zlo1SGl2N3JTcjZoWjdwVHRyQVhzYXRycEt4Sm1INmxSWEhOSTFZcUNHM1ZG?=
 =?utf-8?B?RVBSeUt4bVdiODRXdHdGYmRYUkEyQy85empvY0EybEh3OFRsckU5SFFpOERl?=
 =?utf-8?B?WC9OZVJxRW96Mm1kOFhLN2NidVBTT3BhM0hNOUo5R2lZMy8xS3Qvb1BrbGRw?=
 =?utf-8?B?ZG44bE1yMW5hSlJlMFVhSEE1a1hxV0h6OHRyaHBZR0tGNFExaUNmcXE2dGh4?=
 =?utf-8?B?WXd4SldOaHBDNWhIajJRM0VIcUd6dFZSODVOcWpGM1FJZTl2RXZ1dXRSbW80?=
 =?utf-8?B?VEtXRWVYdXdaM3BiR2txLzN2VmR4YXR5bTNBdms0Q1FhcWY0NUxBUzJVZmRo?=
 =?utf-8?B?Q291djBwV1NuSjhBenZJQ09LRkpKNVUrZ0RMMjNlblhlcFhsTm5HOTNadk5z?=
 =?utf-8?B?ZndaS1VQbzBPdm5Nb2tOejRWU3N2NGp0WCtSTUZkZ2x6Z3B6NDQ0aHk1UExs?=
 =?utf-8?B?YzRkbnZSM2t0M3E1dk9wQ1NGMWQzcVVITUJiNi8rdDRmQitXaDc2ckhVM3Ir?=
 =?utf-8?B?bW1OYlFjQXV6NTc3Zm1sWFoxRExsbDlwa1lVTjJzTE1lbmV4eEdSd21oZWtQ?=
 =?utf-8?B?Q094UGhxcWhnUzFrNzJBVFgyKzhVQ0I5bVZ2UXdHdmdOZHZOVGVrT2tncnBU?=
 =?utf-8?B?T01kT0pDekRJbmhtVnFOUGNIT2k5dHgrYmZaOURGb01OaUZaUHU0SUNZS2hQ?=
 =?utf-8?B?WGRMVUJGZDBmaWM3dHUvRHdvdUZ0NGVWWWZubFhyMDU5RzYrZlN0bHZEVjdF?=
 =?utf-8?B?TTQ4WlU3S0NJRDluWUJ5dHpSdzRSRGNjZDFVT0pSM3FzQXNxTklsMUNiVjJC?=
 =?utf-8?B?OXIzMHNrcWtSZW9ONTl6ZFQ4bDJkei9QY3NwN3F3RWZqV3F1RkxmMXpWUzZG?=
 =?utf-8?B?azNtQ1hVTG9nMCtHR2NCMkJDalhWSzd6UDNYYk1tRW9OT1kxdnpPMFo3aGly?=
 =?utf-8?B?bDhEZmpZVnBtc2NFS0cyMmFpUFUyQitGNi9XKy8xVWl6VHRpbDFTZHcyWW9z?=
 =?utf-8?Q?N/tjhA29BO0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eENpd2twcnpGcWtpeUdwM2lvb3pIb2lETTcyQXJmZlVvR2tFeU45L1MvNnVo?=
 =?utf-8?B?S1o0QnoxV2I3QjR3RmgxZER0NWMrY01Hc0VHSzRHU05udVJhOEVqQ21SMmRu?=
 =?utf-8?B?K0w3MUlKZ0MyQjRtbmN1QWg4TXdkQzljaFF0ZExMdDBibUtTRWZBbGNVWDg4?=
 =?utf-8?B?d2NaSkRwaGdZcU5kQ1B2VVZodGN4d0V4ZWZ6YWZhWHY1emlTeElOVnZXSGxN?=
 =?utf-8?B?WU1XVGFIY0xGdkx4TE9iaDZ4U3pmWEt5czNIZkdEbXJmWFZkczJjcXQ4Ujgr?=
 =?utf-8?B?KzJoZ3RXRFUyRUxxZzU5UTkzZHJvZ0dMM1J3anRTaHdTd3h3dm9YR2J1YTAz?=
 =?utf-8?B?cWpPcHMrVEdSUmhYcHNvWGtKb25tblArdlJMYzFoMmQySWRKUGhyTHQyRXlE?=
 =?utf-8?B?MzhNbGREaUd2aGJHd2k4QnFIR1VXWUpDYnU1MFlWRE5lUzBlVlBzcHl1NTFw?=
 =?utf-8?B?MTArQ0FUdk1qbjlsRHJSbzNzUXBYVUNjSlRDMWwxQlM3WHBYZktoRHc3SFFz?=
 =?utf-8?B?TlF3ZmJhOVBnZG9nZlRyWS9IakR2UWtDNm1MeDNoaVVjdkVwaXUrYTkrZjNE?=
 =?utf-8?B?eEF0M0toZ004SDl5SzU4THBBelhWUmNodVpyNWNQUXN0U0tncVo0NWZybDBh?=
 =?utf-8?B?ZTd6NHVvRkpsRExlYzYwUW9weGg3OXRPd0JmNXVENUxERVpzQy9RRlgxengy?=
 =?utf-8?B?MlU4anp2QU8xTzZ0NCtxZEJhaklBY2JpT255RGZwYkNkZGVEUWRoenZEWDlB?=
 =?utf-8?B?UHhMNUY1TGQ0cUVEYkN5TnBwSFdhYjM5L3pDMEpnT2h2TXIvUWNVbEowdnNC?=
 =?utf-8?B?bjJHbklhMWErK0NJZDRXRE9HQmRweS93RkNBVXV1K05uRVBpVDk5YWsrcGhm?=
 =?utf-8?B?WmxKVlZMTUg1aEE3YjZzL0ZWOTZ5VjY2L2M4ZW8xV0VKbjIvQ3hMZENmaG1W?=
 =?utf-8?B?Sm9LUnVRTEpReUM1NVpJSlBRUlNLVHVTYzBKVENLaTUrN29kWGF4M2dDcWNE?=
 =?utf-8?B?Qzc1L2ozdWgxSFNUeTcxYjZBU3N1OUFKUnZaY1QzSzdNMkZ4RWdTMjFKTC9D?=
 =?utf-8?B?Zll0dytNTWRYMjBJekZMUWcxdHJDWWdyUzllU21GaXJrSURPMS9aOG5saHFl?=
 =?utf-8?B?bkJzT0tTOG9zcHREU05uRXlldU5nWGczY0QyQmlzL2ZVbFd1aDc4d25WdUpu?=
 =?utf-8?B?Vkt4NXhwczdreUI2Q0ZJUnVlRUZFMEV6TEJGaWVkR0s5VFhldzlNRWlEd1A3?=
 =?utf-8?B?SUZIZDI1WndXVzFnTitpY3JqdkpxNmk2eVREekI5dElQenl2QVoxMEV1WnZk?=
 =?utf-8?B?a2h6SGd4Mm1kZHlRby9Xd0R3VmZ6anBVSUwvM05KaWFYRVFKWmFwdmZqbytL?=
 =?utf-8?B?UmNKTXpYUGpnVDRXY2diQVRmZjBsSnFnUVArK2tWNnNtM0NwWU51cWFPMTZ4?=
 =?utf-8?B?elZpMER6V2lVcTBIZ2xrbW5DV09Xc0QrQzdhejU3Mm9OOGNsTGZYdlJ3M3RO?=
 =?utf-8?B?ZlI5UkphRUY2SG45b1BFVXg4NFM0MmRjbWY1ZlFzdlVTOHJxYUo4VmFkN2Uv?=
 =?utf-8?B?Yms1VGF2WXF2MTBaWG1wbzNLVm8zWjFSTENPM3M0UG5JN1p4K0VMZEtZMExG?=
 =?utf-8?B?RXJ4c2NlTnNpWExsbEwxT004Q0pRUlFQYW83UFMzU3lyRmltQnN4VENjVzF1?=
 =?utf-8?B?RnZPanpZOWJ3K2VxcWxuVWRQVldhTTREMEJCclg2RFJ0SXBEQ2FkUGZaRm1m?=
 =?utf-8?B?TStCNlNPVFF5MzUxa0RIZVNJZTVYQ1JRSEUvRDUwODUzQWJFRUJLd3hUa0Jl?=
 =?utf-8?B?ZWc2SE0vQktSbzdPTS9Ia1RkVnc5UXp5RnpEVDhsSkVCSFNQcEJDQVFvQ29n?=
 =?utf-8?B?YWJQTTRVRzVmbzZXY1Jmc2JzVnFYRkI2eUExeEdDcHpERzBvL1liMWgreWhQ?=
 =?utf-8?B?UVFPa3hTZ01TK2s0LzlGNnNTdUpUQnhwNC9yU1dGWlhrY3J6U0xjQTF5U1hN?=
 =?utf-8?B?S2NERHFSMHl5SUw2Rm52YisvY2lBbFNQS2R3NFJpSzdKakZNNmZnNmVySUps?=
 =?utf-8?B?NEdTY2x3VERXWW5ybG9QbTQ3aWgrRkg0SFZIN3Nwbjh0aTZJVVdmdU00WHpi?=
 =?utf-8?Q?68ZeJJD/KmFi35rsNOl4fNkXK?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D91DA6413C92A489011FBE7E3623C05@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a57df86f-7351-4e1d-471b-08dc9b488a12
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2024 10:11:43.5972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eTy+3uSkpI0ODrYyf8Zox5TmpeZt2qZaKf3iJbXTwj1g8PXTU7AimM3YAStkktN9Qc+HPPxSQLHKWGC0UtPgGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6382
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTA3LTAxIGF0IDE1OjQzICswMzAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IENhbGN1bGF0aW9uIG9mICduZXh0JyB2aXJ0dWFsIGFkZHJlc3MgZG9lc24ndCBwcm90
ZWN0IGFnYWluc3Qgd3JhcHBpbmcNCj4gdG8gemVyby4gSXQgY2FuIHJlc3VsdCBpbiBwYWdlIHRh
YmxlIGNvcnJ1cHRpb24gYW5kIGhhbmcuIFRoZQ0KPiBwcm9ibGVtYXRpYyBjYXNlIGlzIHBvc3Np
YmxlIGlmIHVzZXIgc2V0cyBoaWdoIHg4Nl9tYXBwaW5nX2luZm86Om9mZnNldC4NCj4gDQo+IFJl
cGxhY2UgbWFudWFsICduZXh0JyBjYWxjdWxhdGlvbiB3aXRoIHA/ZF9hZGRyX2FuZCgpIHdoaWNo
IGhhbmRsZXMNCg0KcD9kX2FkZHJfYW5kKCkgLT4gcD9kX2FkZHJfZW5kKCkuDQoNCj4gd3JhcHBp
bmcgY29ycmVjdGx5Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogS2lyaWxsIEEuIFNodXRlbW92IDxr
aXJpbGwuc2h1dGVtb3ZAbGludXguaW50ZWwuY29tPg0KDQpSZXZpZXdlZC1ieTogS2FpIEh1YW5n
IDxrYWkuaHVhbmdAaW50ZWwuY29tPg0KDQo=

