Return-Path: <linux-acpi+bounces-6756-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4116F925C6A
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jul 2024 13:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64A251C21508
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jul 2024 11:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4CB181BB4;
	Wed,  3 Jul 2024 11:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gXVpcBpr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C473F181BAC;
	Wed,  3 Jul 2024 11:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720004789; cv=fail; b=eI9s8za9Vbg+c+1FWPpUXzoemv3DELXx4bVRzTdmVt2WVyb3Y/wosCZDg1FDG3HSlHI+eiWsoYDoChttUIUeTYazAa80ueg+GBbIHvL+ZaA2sxuqcf738Yxmj1jdEhkxEFFywgk4OCXPqiQ0TA2J81ZuEB1CNsWBvC1dsyyYPIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720004789; c=relaxed/simple;
	bh=GijpOYhorAaW+zGpl8yccVmYTwOcvVqRcb0duqVyFAY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GcmFZlmgdwIc4bld2b5nZ+LIrZVU6q8HTohGRgUUzO9hBDidDFYNApsQiMhLnCFkjOjQ1Lchft3D577tAScRg/1FfxmPhzgMSsFGjxnWqv+skfRyTBmh5U3bkbppnUJCjvFuNDHoWz8gmVxSE8h6yzzAODIZQKrKbWEKtCjNPM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gXVpcBpr; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720004788; x=1751540788;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GijpOYhorAaW+zGpl8yccVmYTwOcvVqRcb0duqVyFAY=;
  b=gXVpcBpr0ml6XCo76P3GQUis5ab2gvmAHt4CP70QNyJzLHT/aEZzb7E3
   z8NmY/oFtDh90UEftnMJUEuOO4TvRgvAklwZ28JdWuJOlZ09XBCLW/DCQ
   01pCuIX2wAjUbwiJa22jwtJ9gu8wYY01DYyYXFPvDG+HFtr6stWIG2xqC
   8tNZj93uiqyDfHD4hhCxRXWN4MZp4sl6ZQ+77elkfE3K+MhnKfxh+uXVL
   bdMDy5fMaDUDMlSfJ+P0L79MLc2TopkDlBPofa4olJSPNiXOyr1yt3gmn
   kwIn/T5+d+Ei7bZCUCLjuG4Jpp7DsPIU9divA1lvwjTT6kdrNu6fi58nw
   Q==;
X-CSE-ConnectionGUID: HjRTKwoJRfSukfUJ61aY8w==
X-CSE-MsgGUID: hRjcbCdqQGawpljCzQ4lMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="17181147"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="17181147"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 04:06:27 -0700
X-CSE-ConnectionGUID: goU3aJ5sST2sxG2HkQpu2Q==
X-CSE-MsgGUID: Bk1EYLjURYSXjnrKWrdLhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="46096672"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jul 2024 04:06:25 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 04:06:26 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 04:06:25 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 3 Jul 2024 04:06:25 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 3 Jul 2024 04:06:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVFUc4V8f19cGcSk6BnDb0Yq35ZGOLEB7XqwrGyxTzx7BVfI3VzRhzqfU/GtCq/BgW/i1hXJ0DPloj4ROjjwvq17al/lMZ+u/B6rPPgg0gm2RkgOGv4NWRbzD8TRrY4FL+8SXiECeQxPHrMDanHJnWBdWw6LFJ6Wi1mqBKnJErucZu8MUq9/zcZdWCOiVJKf9nMDzuvQJIShOsMGdAOnnfO5UDwBogonDWyc8znQyCxiSkOv76StAJLiucCoGEACTBAoIbhzmP3pdPLVxRCTtNJFEu3o1NL9HjaxmnQhsAPdImkgZ8GV5y36HD+z+ENg/7bbrLCZB0mQAf8anlEoyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GijpOYhorAaW+zGpl8yccVmYTwOcvVqRcb0duqVyFAY=;
 b=FsnX1x8lfmGQww4tRjzFZzqLfuIKUiwCLcf0PYdyZ7/aFyMBcM1WZESSuIXUoc3j2WAo9cJ17uDHQDvlirnqsE7pj8cjjI7Wsrh7DW+wY/FXehdUAxT7BynZGkTum5Kcz7qIu/0I2l2U/HqoYLAuk62Q43Xceym7InlhyPQYALrR3F1DvDKAx7b/jJdL7FtHtAT9VOsMMhYRAjYX+SS/PEJjW8mqZ/99lH/Z3t11q5xlHSEvfVPApz88rT7kwaldFlM82r8m79HNfwNm4tirunUnzIornf5EPAegDj4+dRGvJzNWDX+KT774KAi+NG5V9Ow1bmdLcI4eO3J668xwTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SJ0PR11MB4799.namprd11.prod.outlook.com (2603:10b6:a03:2ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Wed, 3 Jul
 2024 11:06:21 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%5]) with mapi id 15.20.7719.029; Wed, 3 Jul 2024
 11:06:21 +0000
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
Subject: Re: [PATCH 3/3] x86/64/kexec: Rewrite init_transition_pgtable() with
 kernel_ident_mapping_init()
Thread-Topic: [PATCH 3/3] x86/64/kexec: Rewrite init_transition_pgtable() with
 kernel_ident_mapping_init()
Thread-Index: AQHay7R0UfciK4zhOEeY8RF1SP8BgLHk2qSA
Date: Wed, 3 Jul 2024 11:06:21 +0000
Message-ID: <cd655676d5e81ca9b1de0a66f5f5c719ef816c89.camel@intel.com>
References: <20240701124334.1855981-1-kirill.shutemov@linux.intel.com>
	 <20240701124334.1855981-4-kirill.shutemov@linux.intel.com>
In-Reply-To: <20240701124334.1855981-4-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SJ0PR11MB4799:EE_
x-ms-office365-filtering-correlation-id: cec82b9c-b932-4fde-082d-08dc9b502bbd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YkI0THZBWjh4S01IRCtHcDZFKzhHUDVYMjhJSngrdmNSZHZ0cVU1ZzUyMEcy?=
 =?utf-8?B?bVpkN0ZOdDZieU42bFJudEkwd0hyOGtzSElPRWZrTTh4WjcxUlZ2Mlc0S1dN?=
 =?utf-8?B?TWdJSUM0WWpPOTZZckxHU2lVSWxKUUVxZmFWL2RZKzJrNTZucis5K1Z0dUpN?=
 =?utf-8?B?VFBvU2xEV0V4UUg1Q1gxa1djeDJGcHZaM2lYcXlBNGNaVXZTVUdTRitDQy9D?=
 =?utf-8?B?UjEyUnVlZW5XVDR1cWVVOWxnamJwZ2xKNXpjVEV3YVI4K1N4QkhUcWo0RkJT?=
 =?utf-8?B?MFNYZ0daelhqQmFEeGI0WExDNjJvQVF1aUpFUEd2aDd3UEtjMExxTkMzZFpU?=
 =?utf-8?B?TUQrQ21GK2ZaVDAvSlNmalNEQmhyZXhyd0NjSU9Kd3R1N3oyOVNveTcwMTdG?=
 =?utf-8?B?VDlrL0JqaEl6UnpGNXZvMkFNVkVNeHExSHpoUjFPcHhSYWcrRGRwTURnU243?=
 =?utf-8?B?TnM5RDRCRkZXaVRocVI4U3NES2tjVVg4dWJpQTJSV1NnZEdSSWZ3a1B4MGRz?=
 =?utf-8?B?M0dYMUJBSHZ0bGRoZTlzWUovT0hoUjRmSi8zN1RGQ3pFc3VOWC9NQ0RvMUhB?=
 =?utf-8?B?UnJNdHkxOS82Y3hqZHlXb2pmeWd5bGIwL0V1REdHZGN2Y3E4NUhNc1NZdkxy?=
 =?utf-8?B?MVdRM2U1NWlBaGpsQVJlYWlWRHZncHRhbWNkK1VXZWUzTC9QTnBKTkZPY2dj?=
 =?utf-8?B?TkxKWDRWdDlEK0RxZG5EOWRjcWF1ZmxNWG14MDJBT3NUZGdadzNzY1pQZTFH?=
 =?utf-8?B?M1FsWjd6RVkybWUxS1ZIMVpZL1k0UXpxb2VrSTBMKzdHYkQ3TFhTRmQ2VVpH?=
 =?utf-8?B?ci9DNHJKSUJDNGhjVWU4L3A4US9xZ0F4cHNUNU5xUXhXNTlQbTRjMVdtM2Zk?=
 =?utf-8?B?K2xMelVCcWthMHliMXM1bTF3Yk9NNE5iKzRlajlYVTdPb3I1NFZ6MGR5eWMy?=
 =?utf-8?B?MVo0QTJVVWdLS05tc3VlWm00RXZpNm80R0tlVm5scFhWbmwyU3pBYk5Rd1B0?=
 =?utf-8?B?VkR3UExtRFRKREJCYkZGRloyKytCTXhMb0UyMlNubjVSYUhkN2swSlRlTnZn?=
 =?utf-8?B?SS8wcG9wN0ppazJJRGxpdkVyS2hzN3k0QmFQL2lUNnp6OWVxMVgrcGZCa2pv?=
 =?utf-8?B?KzJRQm43bDNXYmg0V1NtRm5sMWFGMVltcnpJc0NycEl4R0xZS2xrL3plQjhL?=
 =?utf-8?B?NDg3V2FKcU9ybXdXa0tDUjNXaWtqTC9LZFpVUStwT21wSUJZS0V3UWVyQkl2?=
 =?utf-8?B?Z0lxQU9manYzc1EzOVM5UzBPd2ZJRnpFZy96RWNoZmdSRDlRRGhLNDl5dTFu?=
 =?utf-8?B?RUhuNDA4bkt4eXlFcCtPRUd5Yy8vVnloMzhKcWQ1c3RjTmFWSVVQYlZ4bndK?=
 =?utf-8?B?K3dNRGdobm8xRExRNVkxY0xWL2VtTytIRHZUeFlwNVY3N05oNVBDVVRDTlRh?=
 =?utf-8?B?NEhJbDErSVg1cjk2U3FzcnFBQUNXaGQwSTloRGtLd2pUb1Z0ODR2ZVMxaG9L?=
 =?utf-8?B?NVhoVGJQVS9tZVVnVHlEVFhOYjJEaHBYSVdUbmxmWVAwM2gvREZJNFpkempM?=
 =?utf-8?B?cXdRZHhJMHFmTWxKWHBYVUxYZENKS25JZ1JBQTF0cWdyQW5QVzc0aWxBbE12?=
 =?utf-8?B?YzR3V09ReEFsNjlLbWF5Y0VPd0NjeWJHSHlsajlzUzZGK29OVUxOWkcrS2xw?=
 =?utf-8?B?ZE9IMDBWbjBaYlJob3VPM0ttdHFTSkxJdDlpM0tlbDBqdlRZaEZtSVJJMHRC?=
 =?utf-8?B?MC9jaXJuMnhxemtnNEJ2eFRrUU91c0xhSUNCNDdDQzNRdUUyb045U2RxQjBC?=
 =?utf-8?B?WStweisza3l5Zmw3cTVla2JHblN6YmlpSWNBcmtaMHR0OW53TzYxbWRhQXpv?=
 =?utf-8?B?VXRsSVdWbjJyYUZNb1BBYnVDa2ovczJJZURtRmN5REVoSmpTeVdtelBlR2pH?=
 =?utf-8?Q?zIYr94QTdOs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zm40UmExNXJvWXV1dFJmNGdORjZxSjZtNG84c0tCUzIvRzE4NlhQQzd6SDI2?=
 =?utf-8?B?YVQzZm1ZdlRWZFZ0ZGpaNmZZb3dvWkdRbUNlbjNZcHI4aUp5RS80a2hnc1Ez?=
 =?utf-8?B?V2RFNW1zSHRXZkJlNVhUbENiU1RHU0VUYmJKUnRPbTRGLy8wUjZKL1dEMjBa?=
 =?utf-8?B?R2ZRaVRpd21YK1RyNzAyNnBXUXI1Z2J4Sm9aRlVodi9pOEJhWUFPMFM3TjBL?=
 =?utf-8?B?VHVYajFJaG81M3hmd0xSK2kzZXpCQk1hQWpJdFNFelM2N05zbCtHc2RocGw4?=
 =?utf-8?B?KzhXcGd5djU3bGRPcStPOTN6QjJiTEJtbWJnL2hYZHZMOU9ycFZRek1kMHRw?=
 =?utf-8?B?STB0TFJSYTBWUnNjSUMyT2pOdEdFNGNaOUw1MzdWQ2xIaEtqbVo1Mll4amRh?=
 =?utf-8?B?eWlKcTEvL0JiSUkvYnVYV1NJajdjTHU4MWV5WWdyVk1mVUZPdXZqeHR5MVhh?=
 =?utf-8?B?NWdPODdtVk9nbEcvU3VhREkyUFRENkI0SmpZdCthRnpKd3UzZGNmMzNtRWkz?=
 =?utf-8?B?QmZpZy9iamhsdVVFc1ZSWE5uZTJoV1BYOExITm1EMXQ2REVOM2dONWIzUDZ6?=
 =?utf-8?B?TWptZHcrNXFlU2lzNmhuY0lqVUdWU0dGankzRW96VTNJVS83NHYxaUdyVDBQ?=
 =?utf-8?B?aERGcE1vM0lTMUw3MG5PUzBIaHJYSTJyeFQwL3ppbk05VGtRbG9KRjN2SzBM?=
 =?utf-8?B?YXZTTm02K3h3NndzTzM2SU9BT0xIellNSTVraGV5bllhV2FMRmcwSHdTNEdO?=
 =?utf-8?B?ejZDa3JkcVpONmhmWjVabUQ1enlKZy9sNnc3Q1hMUmw5TkFHUElYR25TYlJ6?=
 =?utf-8?B?SmNJeTE1dHJtblBIVDNyM2x2NjgxeG9sUFhIUUVjL0pOOHk5Uk9ISS81K3E1?=
 =?utf-8?B?T2lYajdvazZEcjVyTlNrT2FHTVBPSXA0YXNnWlREcjZHVjNvOHJzMzhHZUhm?=
 =?utf-8?B?SnVMbjlNSU9SWmZBU3pnZHk5WFZNcmt6c3NOS3FlN1NqM0ZkcHplNmtESmJp?=
 =?utf-8?B?RUdmVFMwNUtDa1h5V3RIZjk1djJaZGh1bnNWK2NiOVh6MlJ3QTVoZHo4dEs5?=
 =?utf-8?B?c1ZxWFJPZ2hPWDA1OWU0N2hNWU5vSnd1eW0yU0cvUGZ4cHN1UENtQ2lBejNi?=
 =?utf-8?B?ajNLeGtsa1J3cjc2MnFPVFdHNFd4VWlEdEh3dHdTcHhPMjdzSllLTWpGWlBs?=
 =?utf-8?B?aU8rbzZCZXBBSEx0M1pBV3l0cGJ2VUdSV2Jpc2UvVGlrNkE2K3JQd2NMSEE2?=
 =?utf-8?B?UlJ1U2ZDZENLT2JCUWZ0SG5BNXNTVk8yaGRCeWRPZys4aVIzMTVSem1GMmVX?=
 =?utf-8?B?WDJRSVpGWE1hRHNjMHVCY1NDSm9sSldkWGNNVmpEUkVZZU9RTHVLYWVZTm1y?=
 =?utf-8?B?UzB1WG4yeTl1cUxEbXc4SVg2YXVWNERLOSt5S3N6NWNvTGVWeE9WZG1Eei82?=
 =?utf-8?B?UE1JWGVRNmJHajJBK05aV0EwVHM3c29FNVlhSmtmWHJMLzdKRTJRamtlWHJG?=
 =?utf-8?B?V3ByU05xTHJOSHJmZlBjMVpad1BoWXBNTFdwSUp5MkFjdk9DWEw2cjNjZUdN?=
 =?utf-8?B?RnBMOGZxSkpHV1pub2FkQTlUeDVxZzlIS2VBMnNydTlTdUN3allqblhaMGlB?=
 =?utf-8?B?WnRuVm5BdDdmTXFQWlZDWUNnYTBKRCtoRitmK1lNb09UUjN4SXFjRmZYemNx?=
 =?utf-8?B?ekNvOTF2cHhGRm52T1JxVmlCZjJHaDYxOFlsa21SOGtOaUVhUlNXVkZnbzBh?=
 =?utf-8?B?eXE4ZktOU0JUaDlhY0w0eVh1bEx1WnpDbFA2bTdmMXdPa0srUlRIQ3QwN1Aw?=
 =?utf-8?B?ZkpVbHphOCsxZG55ZThRZERGdE9ack0yUXQ0SnRWczNTb2NkZ1Q1NjhQZnZh?=
 =?utf-8?B?dFg4Y0lxbGc2dk9ZU2tvVnE5N2xGU0RoVFZOWU5kVmViLzFrc3NNWThBSXpj?=
 =?utf-8?B?R0JSbEhIWVo4d0JiUmRlbHJpV0NJTkR4bWNaZ0pCSkJ5dTN0cEVsQXJlS2k5?=
 =?utf-8?B?YmNoKyt1dTJGdmZOelEyWWdwU29JTzBETkQ2SXRBQU5nenZpMTRzK0Q2VmJU?=
 =?utf-8?B?VUh2ZHVJbmFwRFh1VUtSVFA1VGJFZ0lXUUdPU2NlQjBJbnhFSk9jeExxK2Mr?=
 =?utf-8?Q?8IYMvDpE41Cy/7kuJSwd0VpMG?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D61334FEF0D8349AA6E55D0AE0B2511@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cec82b9c-b932-4fde-082d-08dc9b502bbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2024 11:06:21.3133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ex2TuAGS8dG7AJUE8JwWWXlbJXHf4/gpaJLDVA/+li/yAjrG+o8/+0zJhgKK7bkj/swkj46OFVKUN6zePB3z5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4799
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTA3LTAxIGF0IDE1OjQzICswMzAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IGluaXRfdHJhbnNpdGlvbl9wZ3RhYmxlKCkgc2V0dXBzIHRyYW5zaXRpb25hbCBwYWdl
IHRhYmxlcy4gUmV3cml0ZSBpdA0KPiB1c2luZyBrZXJuZWxfaWRlbnRfbWFwcGluZ19pbml0KCkg
dG8gYXZvaWQgY29kZSBkdXBsaWNhdGlvbi4NCg0Kc2V0dXBzIC0+IHNldHMgdXANCg0KPiANCj4g
c3RydWN0IGtpbWFnZV9hcmNoIGNoYW5nZWQgdG8gdHJhY2sgYWxsb2NhdGVkIHBhZ2UgdGFibGVz
IGFzIGEgbGlzdCwgbm90DQo+IGxpbmtpbmcgdGhlbSB0byBzcGVjaWZpYyBwYWdlIHRhYmxlIGxl
dmVscy4NCg0KVGhpcyBkb2Vzbid0IGxvb2sgbGlrZSBpbXBlcmF0aXZlIG1vZGUuICBQZXJoYXBz
IGNoYW5nZSB0bzoNCg0KICBDaGFuZ2Ugc3RydWN0IGtpbWFnZV9hcmNoIHRvIHRyYWNrIC4uLg0K
DQpbLi4uXQ0KDQoNCj4gIHN0YXRpYyBpbnQgaW5pdF90cmFuc2l0aW9uX3BndGFibGUoc3RydWN0
IGtpbWFnZSAqaW1hZ2UsIHBnZF90ICpwZ2QpDQo+ICB7DQo+IC0JcGdwcm90X3QgcHJvdCA9IFBB
R0VfS0VSTkVMX0VYRUNfTk9FTkM7DQo+IC0JdW5zaWduZWQgbG9uZyB2YWRkciwgcGFkZHI7DQo+
IC0JaW50IHJlc3VsdCA9IC1FTk9NRU07DQo+IC0JcDRkX3QgKnA0ZDsNCj4gLQlwdWRfdCAqcHVk
Ow0KPiAtCXBtZF90ICpwbWQ7DQo+IC0JcHRlX3QgKnB0ZTsNCj4gKwlzdHJ1Y3QgeDg2X21hcHBp
bmdfaW5mbyBpbmZvID0gew0KPiArCQkuYWxsb2NfcGd0X3BhZ2UJPSBhbGxvY190cmFuc2l0aW9u
X3BndF9wYWdlLA0KPiArCQkuY29udGV4dAk9IGltYWdlLA0KPiArCQkucGFnZV9mbGFnCT0gX19Q
QUdFX0tFUk5FTF9MQVJHRV9FWEVDLA0KPiArCQkua2VybnBnX2ZsYWcJPSBfS0VSTlBHX1RBQkxF
X05PRU5DLA0KPiArCQkub2Zmc2V0ID0gX19TVEFSVF9LRVJORUxfbWFwIC0gcGh5c19iYXNlLA0K
PiArCX07DQo+ICsJdW5zaWduZWQgbG9uZyBtc3RhcnQgPSBQQUdFX0FMSUdOX0RPV04oX19wYShy
ZWxvY2F0ZV9rZXJuZWwpKTsNCj4gKwl1bnNpZ25lZCBsb25nIG1lbmQgPSBtc3RhcnQgKyBQQUdF
X1NJWkU7DQo+ICANCj4gLQl2YWRkciA9ICh1bnNpZ25lZCBsb25nKXJlbG9jYXRlX2tlcm5lbDsN
Cj4gLQlwYWRkciA9IF9fcGEocGFnZV9hZGRyZXNzKGltYWdlLT5jb250cm9sX2NvZGVfcGFnZSkr
UEFHRV9TSVpFKTsNCg0KUGVyaGFwcyBJIGFtIG1pc3Npbmcgc29tZXRoaW5nLCBidXQgdGhpcyBz
ZWVtcyBhIGZ1bmN0aW9uYWwgY2hhbmdlIHRvIG1lLg0KDQpJSVVDIHRoZSBwYWdlIGFmdGVyIGlt
YWdlLT5jb250cm9sX2NvZGVfcGFnZSBpcyBhbGxvY2F0ZWQgd2hlbiBsb2FkaW5nIHRoZQ0Ka2V4
ZWMga2VybmVsIGltYWdlLiAgSXQgaXMgYSBkaWZmZXJlbnQgcGFnZSBmcm9tIHRoZSBwYWdlIHdo
ZXJlIHRoZQ0KcmVsb2NhdGVfa2VybmVsIGNvZGUgcmVzaWRlcyBpbi4NCg0KVGhlIG9sZCBjb2Rl
IG1hcHMgcmVsb2NhdGVfa2VybmVsIGtlcm5lbCBWQSB0byB0aGUgcGFnZSBhZnRlciB0aGUNCmNv
bnRyb2xfY29kZV9wYWdlLiAgTGF0ZXIgaW4gbWFjaGluZV9rZXhlYygpLCB0aGUgcmVsb2NhdGVf
a2VybmVsIGNvZGUgaXMNCmNvcGllZCB0byB0aGF0IHBhZ2Ugc28gdGhlIG1hcHBpbmcgY2FuIHdv
cmsgZm9yIHRoYXQ6DQoNCgljb250cm9sX3BhZ2UgPSBwYWdlX2FkZHJlc3MoaW1hZ2UtPmNvbnRy
b2xfY29kZV9wYWdlKSArIFBBR0VfU0laRTsNCglfX21lbWNweShjb250cm9sX3BhZ2UsIHJlbG9j
YXRlX2tlcm5lbCwNCktFWEVDX0NPTlRST0xfQ09ERV9NQVhfU0laRSk7DQoNClRoZSBuZXcgY29k
ZSBpbiB0aGlzIHBhdGNoLCBob3dldmVyLCBzZWVtcyBqdXN0IG1hcHMgdGhlIHJlbG9jYXRlX2tl
cm5lbCBWQQ0KdG8gdGhlIFBBIG9mIHRoZSByZWxvY2F0ZV9rZXJuZWwsIHdoaWNoIHNob3VsZCBi
ZSBkaWZmZXJlbnQgZnJvbSB0aGUgb2xkDQptYXBwaW5nLg0K

