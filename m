Return-Path: <linux-acpi+bounces-7656-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9681A956B03
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 14:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09514B22CFA
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 12:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B780916B397;
	Mon, 19 Aug 2024 12:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HgxpYwOh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34F7161901;
	Mon, 19 Aug 2024 12:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724071169; cv=fail; b=X75qMaVTa6vvvncnxbQRjxaAUaqgIjitb6pbjKHX2KHAorVHsQWzLeS2r7qGz+Xibq3f+RtUfFzxBXSTyUwY/Fh++gMzQSgr103jT+G4s1mm/yidQTI8DjFtwz/Uw5TvaHmDRG0xW+2zxxb9z/GCByFpOJqCSjAhllgvh9g+GD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724071169; c=relaxed/simple;
	bh=72nJ1BPwkuKgbi5set13tasOuwZ84vl0Ez2oN92UacE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MTun6zpadWbNzbrO0/8ozZGwnMDb6A1mjjVbp3Lxg3kvoekd+w/rkUY+BdBamLG0ixBmejhREtNhisNgLX8TZ95XVLe9r3aSfhRXBNB7RQSJu1z/hP1YxmFoFImIiwRS+MilWs9FnRDfOtIFXA3yE4wANE/ZaBvlSkfEz0mu4W8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HgxpYwOh; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724071167; x=1755607167;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=72nJ1BPwkuKgbi5set13tasOuwZ84vl0Ez2oN92UacE=;
  b=HgxpYwOhVPLiJ/PlyJzsBNSH2apzunAZzYoRfa4RM3qMqWa4+TP+EhaT
   +1QP5BvtD42ZR7Ogxzg7btP5azoLgKvyVhVxgHLQ6ghq3YJtcV7I9RCPB
   pRZ59AoZkNksWJcP/Tg/WHxjGWITJhue720rcgd6zdD8KwsBxcy7hF9oL
   HqZVrKtgOtexEw0jtTMLFYiU4ho5RWfSO7hVNDwAjoffiNR/NQHieFEEQ
   csbVFNqmui/QxftSZCPLfjStkN/pIeYVZ45eWAUXTgBI3sOr4B5PSHe2k
   ctz83eFxHHHtpYNo+efJet0JhIYIrzuN5ydcVc3vHvyo8C3Sssu6B6qyn
   A==;
X-CSE-ConnectionGUID: MqH817KhSkiYtNzhts2FRw==
X-CSE-MsgGUID: KCddsQtnR5qJHcu0ecmUQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="33466374"
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="33466374"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 05:39:26 -0700
X-CSE-ConnectionGUID: BdiTz5Q2Q1eK6nsWVJZ4Hw==
X-CSE-MsgGUID: eMh+eZFBQPKd8QJugzCb1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="65252558"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Aug 2024 05:39:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 05:39:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 05:39:25 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 19 Aug 2024 05:39:25 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 05:39:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y3ClVnhdOphnuVLWp9ltPhRbMYif1Im6yAHPWRM+l9V+z7KnVaRtjQErgZr6gTFhdU6pezai3PCT//CMxuxq0nmmFMgYlngc8K+NstlP2U47I33DmrLiDi6PVCI3g63Zz7GlBYqy2/D9wdaXI8BLVD5CBO+WisI+plmnJGHyXXmTySj6igPWxF9/q2UehpamrnKJKKF9kEs7kLV4MSOmvNefKVxf6l3Kf2sMqLWvuP8KA/a5BIFOcZgH8AWjaYBgGsC0+c38aUfhozv+Y/bN+TNlf9iB0n7vGxzTMOokKfOzmEbb81bLFkUhxJSKrP6dYGkWvbmJU+JatI2Dd2Wn4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72nJ1BPwkuKgbi5set13tasOuwZ84vl0Ez2oN92UacE=;
 b=x/Sy6GI4ooh+xN1ard4yTr8kz+0D/ZdsPFvbEI9KRrMxSaY82sduJlaB27gz0YRNRGCvHloshSQvRSSu5ND38Le2NGwwyOfGhYy91CC2iJwZsUhvim8RS1LuLbZG98AGrEoLsrqnqoTMgUBzhgcYGdgXbd6TRVQljL/3z6hc2kjW8wIcPE7LwqYfxzaPTG4mKBSibqZi3uYol8qxuKRnWv1hIq9Z7BNxqJp6sbnzGDgQjUJv6RtbLOlZJlJfjykq57hELAE5QSQsuBODeNIW2VmvHyR5GlRZxllBsD+Yi5DqBB/tXqso8bdR0Fi/+D0/+8O62aQfaLqXk+Wbnb334g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DS0PR11MB6351.namprd11.prod.outlook.com (2603:10b6:8:cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Mon, 19 Aug
 2024 12:39:23 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%7]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 12:39:23 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"Huang, Ying" <ying.huang@intel.com>
CC: "ardb@kernel.org" <ardb@kernel.org>, "luto@kernel.org" <luto@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "tzimmermann@suse.de"
	<tzimmermann@suse.de>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "hpa@zytor.com" <hpa@zytor.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "bp@alien8.de" <bp@alien8.de>,
	"rafael@kernel.org" <rafael@kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCHv3 3/4] x86/64/kexec: Map original relocate_kernel() in
 init_transition_pgtable()
Thread-Topic: [PATCHv3 3/4] x86/64/kexec: Map original relocate_kernel() in
 init_transition_pgtable()
Thread-Index: AQHa8gaplxIQHt1FDUe8BCwalB/rOLIuboSAgAALTQCAAAvBAA==
Date: Mon, 19 Aug 2024 12:39:23 +0000
Message-ID: <d97a17a53cb7550134ec521e3d22177d6a6ad05e.camel@intel.com>
References: <20240819070827.3620020-1-kirill.shutemov@linux.intel.com>
	 <20240819070827.3620020-4-kirill.shutemov@linux.intel.com>
	 <4c140a8e0154504e9c645b9f78b0b164dc25a461.camel@intel.com>
	 <hr7kym77uhbtj32eymcdp5mcbpid7euoiiszhx6yhkrbw5riag@lcozqjayilbo>
In-Reply-To: <hr7kym77uhbtj32eymcdp5mcbpid7euoiiszhx6yhkrbw5riag@lcozqjayilbo>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3 (3.52.3-1.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DS0PR11MB6351:EE_
x-ms-office365-filtering-correlation-id: 46daffaa-c3ec-423a-ecab-08dcc04bf42e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NURKemUxc1dRMHpBWGh6T1dyZkplWkZBZXllM1BpajVuamZtTjdGZjlvYld1?=
 =?utf-8?B?cVNDQzVXZWd5czRQdGM2Vlphd1pmcHZ0RmVEVTI5MUZsSEp3YW1EeFYwSHBU?=
 =?utf-8?B?TmdPU09vWEc2S2JwekR2MEsyanBoRWxKK0s3dE9hbkpSNmdDMzJFK2cwbEl5?=
 =?utf-8?B?cmh0Y1NsSERvUHg0ZXg0bVdWZnVkT1N3Z2dGOEFUZTNtZ1ZIV0JPS1hPTmhi?=
 =?utf-8?B?TGFqbkpaNjJKZG96QzZoUi9qcmpOaUsvQ3NxWnpLY01Sbm1wWFZ4N1VEaCtt?=
 =?utf-8?B?SFo0OXJMenBRNVpIQWxnRkI5c0J4ay8zYTc5czZGaW9idTN4ZGpITmVIN0l5?=
 =?utf-8?B?VjRJTStiTkZTK1JLUTJRbVBCQzRIMjl6a3BkUk1Oc3VoaVIyeFErbklRNnVS?=
 =?utf-8?B?eElLcmlMWjlQUkdKWEF1R0w0T3JSbXc2SThNWTA1UndibEt3aXRRTlpMVWxF?=
 =?utf-8?B?cHRuKy9pUzdIdHJ3VWxieWpyc0tHYlZWcW1uVnAvdm9NOTRHYUJ3L29wQmFZ?=
 =?utf-8?B?M3dCTlEySGRCSVRMVGUzL2IyZ0xodnFiQUI1TmdpcGsrZW1qMTJ2WWhSQU93?=
 =?utf-8?B?TEJnZmswQmxnd29QWGErSFFERHQzclplaFVsZVU0cXR0clA5OXJIdW4rL0tw?=
 =?utf-8?B?cGZ1SXhZZ1FrbWdnZkhlNUxGdURjcFp0NTR4QXdOUkpWTURlYUxVM1pjZTBJ?=
 =?utf-8?B?dTNTb0JaeXNWSVB5NnJGNnBxZHdkZ2p6QVg3d1RMYzQxT0RRbUNCSCtTSTFn?=
 =?utf-8?B?QVVRWWF6a3krYWRBdkE3R2p5SCt6RlpvYkR5L0o1UWpTVDF3cXVBNUEvMlhG?=
 =?utf-8?B?emRnK0tVK3FoWHhQdFYzNUgvQ0hpMEJIbUpmSS8wUTBwSmNmRzdZcGJMZjlK?=
 =?utf-8?B?K1RWUFVkZzVxUmR3UzhVY0FsOXE4dFg4YzJYaFg3U25YWmNWaUt2TVlpajJD?=
 =?utf-8?B?RTVYc3phNjlQK3ZXdFNuaExweWhiRldqT2orY3gyUDdMK1ltaGhaK29maFJS?=
 =?utf-8?B?MUg3ems3c2lhWEZnVUFiOXJHRHZCaGZmZElSUUtTTVBOUHRNVkhuQUl6Q3Qx?=
 =?utf-8?B?M1RSUTY2TVFyLzZiQU1SMzdJKzVtVUcvTGxhN1g2KzdwcDNJR1cwN2hJQ29J?=
 =?utf-8?B?V0h4c2NIN0ZpUUhHcFp4N2xDZ3N0T2V3VVhETUdiTDNIRE5XalMrSUhNdTA0?=
 =?utf-8?B?clZCNWtCTVBBTTBsM2pxMFFZSFdlckZpTUU4SkY4VWVId1NWR056bjdpSUdx?=
 =?utf-8?B?TVpvZFVjQUhvdG5PdXVzeGlYZmZiVkRsOVdNU2lDWmZUVjQydXBXN0I0eUpM?=
 =?utf-8?B?aUxEZXhuNnJWWWw5KzBSc0pNY05ya3VkelZmZXpBTVJzODBwTVh6QVFtakJy?=
 =?utf-8?B?TDdCckpNay91UnVWRGVYeEZuWHlQK0ZjVjhicmRhM1MwSFpmTWdQNmxnZkRS?=
 =?utf-8?B?YnNwSXRqVXphTittKzM2R3lNN2QxcTFocDRULzFkS0U3RnpPMm1RbTYrNmY1?=
 =?utf-8?B?R21SRUZxTnRNOEE3bVM2ZTJacDRJeVFKeU5zWkxLUU1BelFDK0Y5UENwYzRL?=
 =?utf-8?B?MEovY2huMkZVMk1SMXdqMDJlT0tQbEFodGNUbkhoVlVkYUhUeVB3ckZOSmxS?=
 =?utf-8?B?L2p0SzNHblFMdlRteGI4TG9neHVWdmQrQXhSVzczenVsbERIb2dYQjdXNTk2?=
 =?utf-8?B?SHFuQ29oZUJFSDJNTE5OZUs3ZFZYWGVJaGw5bkllNlMxSWpDeEV2dFZCR0hx?=
 =?utf-8?B?dzdURUdTdTVpcWs2RXVrTVpqQnFzaVhTYndwdEJ3UytuaVNzTHRFaEZacTEx?=
 =?utf-8?B?aExjMkIwdzFKRzYyd0FvaWR1Q2d2eWM5RmlldmJET3BIZC9FYm03dmNxUVJr?=
 =?utf-8?B?MVY4UDBpZGlUY2Zpa3R3UUVsZnVhU1oxYmE1eG11RzVqRnc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjBaY29mTHp6K05Qc3Z1cEdjR2g3ZG54M2xSYnNqTW1xZzd5dExQUlgyc0VY?=
 =?utf-8?B?bVFnQkVnbG9MbVRLQU5WUG1VTEVUVjg2Mkdjc2RnUUNwRGI0dW1XM2thWTdz?=
 =?utf-8?B?d3FXNlZYNkEwK1FSVVF5QktFK3puVDNJOWhNdmRxY1JOWGN0VmNjUVhFdWJC?=
 =?utf-8?B?dWt0OGRuVEdOUThkTUtGK3UzdnZiL1hlTEhoV282VVJKMmVneXFqNmM4dk1C?=
 =?utf-8?B?L2dwdExwTDYyRjhvWHg4WmVPRWc5dTR6SmtFTVRtdG1jcGR3SGN3Zi9HR0Nh?=
 =?utf-8?B?Y1U0eWI5K2JpcG13aXdrbkE5WG1VeXF5aVBFa2VZMHNRdXR4MXJSclZmc0tl?=
 =?utf-8?B?RVZjaFN2eHJha0lKVm5iRGFDSzhZbWtnbXZCbTVpOGFyTmtGd2paNFFNdnFN?=
 =?utf-8?B?dHErQURzRUUybXJFazh5SmFIWldYSE9SL0MxZGVnSTFOQjBsZk5xNzBXcEx1?=
 =?utf-8?B?a3BZdUp2MnNNckoyOUIrVldhOFFQTXhscUVzU2F4K0lHM0FMeGJ4cHVpZmZO?=
 =?utf-8?B?Tm94ZnBjenZ1UGNOa3lvSi85UUxhaTg0ZGVTc0RkdS95R3lwM0syUzdiZllF?=
 =?utf-8?B?OXNSdHNFVGdhRnVrNGdqQnBkNTZkTTI1MVNoSWJqVEI5dFpMVTR2WXVNblpQ?=
 =?utf-8?B?SmhaUTM3YnI2U3h3ZVN1SDRIRE5Ob2JPeklsSWZjeEVIV3haRGFSUXZyVXNw?=
 =?utf-8?B?RlVTTTJVZ1QyUmsxTDh2V0NRd0N6c09BelZKck5UK1U5WUFWYmF4UWJoTkxv?=
 =?utf-8?B?Wnh2TU81YmFia0YwZmtOL1E1Uys3VVpERklsU2YrNWtseUEzcVNPSzI2R3BP?=
 =?utf-8?B?SWFNZnFhMkdDUWI5R1RmejJ4QW0xdFMweFp0Q2k4eHU0dmtTR0l3OVI4ZnVn?=
 =?utf-8?B?UkhmMGU1WTRaZWRpTnMzWTdQN0dGVWV2bTIrVVhpb05TdTRCbDhlenVpS3Mw?=
 =?utf-8?B?VFNtTy90LzE4TERqY29YV1RHVVBoU2cvWDNMZGtRVndHaDQ3WGFySVZ4RW16?=
 =?utf-8?B?dFd1T0ttUzdUV1VFaE0rNmlzNkxmZmxPREhpM1JRSktZSmFtZGtVdE4za3BL?=
 =?utf-8?B?Vmp1K3pmU1pTYXNkWE1WMmtBbFBnRUoxYWE4L1RCNHZHVngxNkExdmxpQllu?=
 =?utf-8?B?bDJXVmpJcWlWSlRXREcrZkxLU3FnMTQ5WWVYcm0vSjJxaXJEdVYvWUtaR2Rv?=
 =?utf-8?B?c051dllCOU5GK0p0YTh0K2lPWUJWK2FxaTEyNFYvUlhJS1lkbHpFVndtNzlq?=
 =?utf-8?B?TlZHODloU3hvQXdNVExXVmFwUWRBYW5nWEZua0tJcjdMVmo2dUZkUmlpRVRz?=
 =?utf-8?B?VUNEN0dnY21YVml5OFFqNU4yYXZSQTA1MzJPUlFzSDl1WFNsWENjbFo4N1pz?=
 =?utf-8?B?TnM4dE8vMnNLa2pMbC9jWVF4elpOTTNleTB0VWxtS0o5YlhuczZLa0lHOFBF?=
 =?utf-8?B?dytjQ1VVeHFLUzB6VXBUYTd3bkRPZm5mK01TMEQ0OU5IR05lN25sUlIra0l1?=
 =?utf-8?B?K3pWdXlncWtIc3lCK0dBKzMrWmxZaXFOa2dVY21ZREkzbjFvN21oaGNqM0dC?=
 =?utf-8?B?Z2h2cTBDYkVNZHorUEl6WC9Ud1NydnluY2tVbHU5TFcvZmN0dng4dTkyRE4x?=
 =?utf-8?B?NkZPeUVWeUlib2JuUFNnaHN4RFdnblE5KzZPaEgza3JLNHR2enV0cEpsdmxD?=
 =?utf-8?B?cFByS0xLdUZHZkFHdHBhSUd3MkxpYkNzS2JITmJOY2ZsSUpQaitqWW8zMXpv?=
 =?utf-8?B?YWlOQXRFOXA4SmRuL1QyelprSEdPQnJXekRIdTcyNE5zZkEzUmVteXBFRkhG?=
 =?utf-8?B?RTN0bi9hMWUzYUladkR6S2hOUlRPRHlsY2x5WFZDSVU3cjIxZWUvUTd6YS9s?=
 =?utf-8?B?NGxrdGVzMU9jNlJUZi9MTGNTMkNlc0ZYZ0pud2pmMWdzbkJWMVNzcVF5UkJu?=
 =?utf-8?B?MXZxMndHc0tPK0ZoM1A0OHcwWUZiR25KbCtmK3ZwV202Z0MrQWIxQms5aFV3?=
 =?utf-8?B?anNvREtMQitucS96Y25QNk1xZVVDMUxtQWhUNERTSUlSZDdSaFk4VmV2Z2Vu?=
 =?utf-8?B?L21mZ3puMlJyUjBTaHB5RUhMWDBkNW5vVThYbHc3ekFjb3pGYzlwSFZwd2JS?=
 =?utf-8?Q?JKlwB6fxM4dc8E052gCbNAiKT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5610EF0679DFF149858E193050A12FD5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46daffaa-c3ec-423a-ecab-08dcc04bf42e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 12:39:23.1104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nEMBbzOjl+B442aqUdReQQMOwmcQA5jfD6h5Ye1gbpwsOthW/VXbvCmnRrf4FEXbIL6SJypX5FJkhgxT2NKmPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6351
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTA4LTE5IGF0IDE0OjU3ICswMzAwLCBraXJpbGwuc2h1dGVtb3ZAbGludXgu
aW50ZWwuY29tIHdyb3RlOg0KPiBPbiBNb24sIEF1ZyAxOSwgMjAyNCBhdCAxMToxNjo1MkFNICsw
MDAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiA+IE9uIE1vbiwgMjAyNC0wOC0xOSBhdCAxMDowOCAr
MDMwMCwgS2lyaWxsIEEuIFNodXRlbW92IHdyb3RlOg0KPiA+ID4gVGhlIGluaXRfdHJhbnNpdGlv
bl9wZ3RhYmxlKCkgZnVuY3Rpb24gc2V0cyB1cCB0cmFuc2l0aW9uYWwgcGFnZSB0YWJsZXMuDQo+
ID4gPiBJdCBlbnN1cmVzIHRoYXQgdGhlIHJlbG9jYXRlX2tlcm5lbCgpIGZ1bmN0aW9uIGlzIHBy
ZXNlbnQgaW4gdGhlDQo+ID4gPiBpZGVudGl0eSBtYXBwaW5nIGF0IHRoZSBzYW1lIGxvY2F0aW9u
IGFzIGluIHRoZSBrZXJuZWwgcGFnZSB0YWJsZXMuDQo+ID4gPiByZWxvY2F0ZV9rZXJuZWwoKSBz
d2l0Y2hlcyB0byB0aGUgaWRlbnRpdHkgbWFwcGluZywgYW5kIHRoZSBmdW5jdGlvbg0KPiA+ID4g
bXVzdCBiZSBwcmVzZW50IGF0IHRoZSBzYW1lIGxvY2F0aW9uIGluIHRoZSB2aXJ0dWFsIGFkZHJl
c3Mgc3BhY2UgYmVmb3JlDQo+ID4gPiBhbmQgYWZ0ZXIgc3dpdGNoaW5nIHBhZ2UgdGFibGVzLg0K
PiA+ID4gDQo+ID4gPiBpbml0X3RyYW5zaXRpb25fcGd0YWJsZSgpIG1hcHMgYSBjb3B5IG9mIHJl
bG9jYXRlX2tlcm5lbCgpIGluDQo+ID4gPiBpbWFnZS0+Y29udHJvbF9jb2RlX3BhZ2UgYXQgdGhl
IHJlbG9jYXRlX2tlcm5lbCgpIHZpcnR1YWwgYWRkcmVzcywgYnV0DQo+ID4gPiB0aGUgb3JpZ2lu
YWwgcGh5c2ljYWwgYWRkcmVzcyBvZiByZWxvY2F0ZV9rZXJuZWwoKSB3b3VsZCBhbHNvIHdvcmsu
DQo+ID4gPiANCj4gPiA+IEl0IGlzIHNhZmUgdG8gdXNlIG9yaWdpbmFsIHJlbG9jYXRlX2tlcm5l
bCgpIHBoeXNpY2FsIGFkZHJlc3MgY2Fubm90IGJlDQo+ID4gPiBvdmVyd3JpdHRlbiB1bnRpbCBz
d2FwX3BhZ2VzKCkgaXMgY2FsbGVkLCBhbmQgdGhlIHJlbG9jYXRlX2tlcm5lbCgpDQo+ID4gPiB2
aXJ0dWFsIGFkZHJlc3Mgd2lsbCBub3QgYmUgdXNlZCBieSB0aGVuLg0KPiA+ID4gDQo+ID4gPiBN
YXAgdGhlIG9yaWdpbmFsIHJlbG9jYXRlX2tlcm5lbCgpIGF0IHRoZSByZWxvY2F0ZV9rZXJuZWwo
KSB2aXJ0dWFsDQo+ID4gPiBhZGRyZXNzIGluIHRoZSBpZGVudGl0eSBtYXBwaW5nLiBJdCBpcyBw
cmVwYXJhdGlvbiB0byByZXBsYWNlIHRoZQ0KPiA+ID4gaW5pdF90cmFuc2l0aW9uX3BndGFibGUo
KSBpbXBsZW1lbnRhdGlvbiB3aXRoIGEgY2FsbCB0bw0KPiA+ID4ga2VybmVsX2lkZW50X21hcHBp
bmdfaW5pdCgpLg0KPiA+ID4gDQo+ID4gPiBOb3RlIHRoYXQgd2hpbGUgcmVsb2NhdGVfa2VybmVs
KCkgc3dpdGNoZXMgdG8gdGhlIGlkZW50aXR5IG1hcHBpbmcsIGl0DQo+ID4gPiBkb2VzIG5vdCBm
bHVzaCBnbG9iYWwgVExCIGVudHJpZXMgKENSNC5QR0UgaXMgbm90IGNsZWFyZWQpLiBUaGlzIG1l
YW5zDQo+ID4gPiB0aGF0IGluIG1vc3QgY2FzZXMsIHRoZSBrZXJuZWwgc3RpbGwgcnVucyByZWxv
Y2F0ZV9rZXJuZWwoKSBmcm9tIHRoZQ0KPiA+ID4gb3JpZ2luYWwgcGh5c2ljYWwgYWRkcmVzcyBi
ZWZvcmUgdGhlIGNoYW5nZS4NCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogS2lyaWxsIEEu
IFNodXRlbW92IDxraXJpbGwuc2h1dGVtb3ZAbGludXguaW50ZWwuY29tPg0KPiA+ID4gLS0tDQo+
ID4gPiAgYXJjaC94ODYva2VybmVsL21hY2hpbmVfa2V4ZWNfNjQuYyB8IDIgKy0NCj4gPiA+ICAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+IA0KPiA+
ID4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9tYWNoaW5lX2tleGVjXzY0LmMgYi9hcmNo
L3g4Ni9rZXJuZWwvbWFjaGluZV9rZXhlY182NC5jDQo+ID4gPiBpbmRleCA5YzlhYzYwNjg5M2Uu
LjY0NTY5MGU4MWMyZCAxMDA2NDQNCj4gPiA+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9tYWNoaW5l
X2tleGVjXzY0LmMNCj4gPiA+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9tYWNoaW5lX2tleGVjXzY0
LmMNCj4gPiA+IEBAIC0xNTcsNyArMTU3LDcgQEAgc3RhdGljIGludCBpbml0X3RyYW5zaXRpb25f
cGd0YWJsZShzdHJ1Y3Qga2ltYWdlICppbWFnZSwgcGdkX3QgKnBnZCkNCj4gPiA+ICAJcHRlX3Qg
KnB0ZTsNCj4gPiA+ICANCj4gPiA+ICAJdmFkZHIgPSAodW5zaWduZWQgbG9uZylyZWxvY2F0ZV9r
ZXJuZWw7DQo+ID4gPiAtCXBhZGRyID0gX19wYShwYWdlX2FkZHJlc3MoaW1hZ2UtPmNvbnRyb2xf
Y29kZV9wYWdlKStQQUdFX1NJWkUpOw0KPiA+ID4gKwlwYWRkciA9IF9fcGEocmVsb2NhdGVfa2Vy
bmVsKTsNCj4gPiA+ICAJcGdkICs9IHBnZF9pbmRleCh2YWRkcik7DQo+ID4gPiAgCWlmICghcGdk
X3ByZXNlbnQoKnBnZCkpIHsNCj4gPiA+ICAJCXA0ZCA9IChwNGRfdCAqKWdldF96ZXJvZWRfcGFn
ZShHRlBfS0VSTkVMKTsNCj4gPiANCj4gPiANCj4gPiBJSVVDLCB0aGlzIGJyZWFrcyBLRVhFQ19K
VU1QIChpbWFnZS0+cHJlc2VydmVfY29udGV4dCBpcyB0cnVlKS4NCj4gPiANCj4gPiBUaGUgcmVs
b2NhdGVfa2VybmVsKCkgZmlyc3Qgc2F2ZXMgY291cGxlIG9mIHJlZ3MgYW5kIHNvbWUgb3RoZXIg
ZGF0YSBsaWtlIFBBDQo+ID4gb2Ygc3dhcCBwYWdlIHRvIHRoZSBjb250cm9sIHBhZ2UuICBOb3Rl
IGhlcmUgdGhlIFZBX0NPTlRST0xfUEFHRSBpcyB1c2VkIHRvDQo+ID4gYWNjZXNzIHRoZSBjb250
cm9sIHBhZ2UsIHNvIHRob3NlIGRhdGEgYXJlIHNhdmVkIHRvIHRoZSBjb250cm9sIHBhZ2UuDQo+
ID4gDQo+ID4gU1lNX0NPREVfU1RBUlRfTk9BTElHTihyZWxvY2F0ZV9rZXJuZWwpDQo+ID4gICAg
ICAgICBVTldJTkRfSElOVF9FTkRfT0ZfU1RBQ0sNCj4gPiAgICAgICAgIEFOTk9UQVRFX05PRU5E
QlINCj4gPiAgICAgICAgIC8qICAgICAgDQo+ID4gICAgICAgICAgKiAlcmRpIGluZGlyZWN0aW9u
X3BhZ2UNCj4gPiAgICAgICAgICAqICVyc2kgcGFnZV9saXN0DQo+ID4gICAgICAgICAgKiAlcmR4
IHN0YXJ0IGFkZHJlc3MNCj4gPiAgICAgICAgICAqICVyY3ggcHJlc2VydmVfY29udGV4dA0KPiA+
ICAgICAgICAgICogJXI4ICBiYXJlX21ldGFsDQo+ID4gICAgICAgICAgKi8NCj4gPiANCj4gPiAJ
Li4uDQo+ID4gDQo+ID4gICAgICAgICBtb3ZxICAgIFBUUihWQV9DT05UUk9MX1BBR0UpKCVyc2kp
LCAlcjExICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCj4gPiAgICAgICAgIG1vdnEgICAg
JXJzcCwgUlNQKCVyMTEpICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIA0KPiA+ICAgICAgICAgbW92cSAgICAlY3IwLCAlcmF4DQo+ID4gICAgICAgICBtb3ZxICAg
ICVyYXgsIENSMCglcjExKQ0KPiA+ICAgICAgICAgbW92cSAgICAlY3IzLCAlcmF4DQo+ID4gICAg
ICAgICBtb3ZxICAgICVyYXgsIENSMyglcjExKQ0KPiA+ICAgICAgICAgbW92cSAgICAlY3I0LCAl
cmF4DQo+ID4gICAgICAgICBtb3ZxICAgICVyYXgsIENSNCglcjExKQ0KPiA+IA0KPiA+IAkuLi4N
Cj4gPiANCj4gPiAJLyoNCj4gPiAgICAgICAgICAqIGdldCBwaHlzaWNhbCBhZGRyZXNzIG9mIGNv
bnRyb2wgcGFnZSBub3cNCj4gPiAgICAgICAgICAqIHRoaXMgaXMgaW1wb3NzaWJsZSBhZnRlciBw
YWdlIHRhYmxlIHN3aXRjaA0KPiA+ICAgICAgICAgICovDQo+ID4gICAgICAgICBtb3ZxICAgIFBU
UihQQV9DT05UUk9MX1BBR0UpKCVyc2kpLCAlcjgNCj4gPiANCj4gPiAgICAgICAgIC8qIGdldCBw
aHlzaWNhbCBhZGRyZXNzIG9mIHBhZ2UgdGFibGUgbm93IHRvbyAqLw0KPiA+ICAgICAgICAgbW92
cSAgICBQVFIoUEFfVEFCTEVfUEFHRSkoJXJzaSksICVyOQ0KPiA+IA0KPiA+ICAgICAgICAgLyog
Z2V0IHBoeXNpY2FsIGFkZHJlc3Mgb2Ygc3dhcCBwYWdlIG5vdyAqLw0KPiA+ICAgICAgICAgbW92
cSAgICBQVFIoUEFfU1dBUF9QQUdFKSglcnNpKSwgJXIxMA0KPiA+IA0KPiA+ICAgICAgICAgLyog
c2F2ZSBzb21lIGluZm9ybWF0aW9uIGZvciBqdW1waW5nIGJhY2sgKi8NCj4gPiAgICAgICAgIG1v
dnEgICAgJXI5LCBDUF9QQV9UQUJMRV9QQUdFKCVyMTEpDQo+ID4gICAgICAgICBtb3ZxICAgICVy
MTAsIENQX1BBX1NXQVBfUEFHRSglcjExKQ0KPiA+ICAgICAgICAgbW92cSAgICAlcmRpLCBDUF9Q
QV9CQUNLVVBfUEFHRVNfTUFQKCVyMTEpDQo+ID4gDQo+ID4gCS4uLg0KPiA+IA0KPiA+IEFuZCBh
ZnRlciBqdW1waW5nIGJhY2sgZnJvbSB0aGUgc2Vjb25kIGtlcm5lbCwgcmVsb2NhdGVfa2VybmVs
KCkgdHJpZXMgdG8NCj4gPiByZXN0b3JlIHRoZSBzYXZlZCBkYXRhOg0KPiA+IA0KPiA+IAkuLi4N
Cj4gPiANCj4gPiAgICAgICAgIC8qIGdldCB0aGUgcmUtZW50cnkgcG9pbnQgb2YgdGhlIHBlZXIg
c3lzdGVtICovDQo+ID4gICAgICAgICBtb3ZxICAgIDAoJXJzcCksICVyYnANCj4gPiAgICAgICAg
IGxlYXEgICAgcmVsb2NhdGVfa2VybmVsKCVyaXApLCAlcjgJCTwtLS0tLS0tLS0gICgqKSANCj4g
PiAgICAgICAgIG1vdnEgICAgQ1BfUEFfU1dBUF9QQUdFKCVyOCksICVyMTANCj4gPiAgICAgICAg
IG1vdnEgICAgQ1BfUEFfQkFDS1VQX1BBR0VTX01BUCglcjgpLCAlcmRpDQo+ID4gICAgICAgICBt
b3ZxICAgIENQX1BBX1RBQkxFX1BBR0UoJXI4KSwgJXJheA0KPiA+ICAgICAgICAgbW92cSAgICAl
cmF4LCAlY3IzDQo+ID4gICAgICAgICBsZWEgICAgIFBBR0VfU0laRSglcjgpLCAlcnNwDQo+ID4g
ICAgICAgICBjYWxsICAgIHN3YXBfcGFnZXMNCj4gPiAgICAgICAgIG1vdnEgICAgJHZpcnR1YWxf
bWFwcGVkLCAlcmF4DQo+ID4gICAgICAgICBwdXNocSAgICVyYXgNCj4gPiAgICAgICAgIEFOTk9U
QVRFX1VOUkVUX1NBRkUNCj4gPiAgICAgICAgIHJldA0KPiA+ICAgICAgICAgaW50Mw0KPiA+IFNZ
TV9DT0RFX0VORChpZGVudGl0eV9tYXBwZWQpDQo+ID4gDQo+ID4gTm90ZSB0aGUgYWJvdmUgY29k
ZSAoKikgdXNlcyB0aGUgVkEgb2YgcmVsb2NhdGVfa2VybmVsKCkgdG8gYWNjZXNzIHRoZSBjb250
cm9sDQo+ID4gcGFnZS4gIElJVUMsIHRoYXQgbWVhbnMgaWYgd2UgbWFwIFZBIG9mIHJlbG9jYXRl
X2tlcm5lbCgpIHRvIHRoZSBvcmlnaW5hbCBQQQ0KPiA+IHdoZXJlIHRoZSBjb2RlIHJlbG9jYXRl
X2tlcm5lbCgpIHJlc2lkZXMsIHRoZW4gdGhlIGFib3ZlIGNvZGUgd2lsbCBuZXZlciBiZQ0KPiA+
IGFibGUgdG8gcmVhZCB0aG9zZSBkYXRhIGJhY2sgc2luY2UgdGhleSB3ZXJlIHNhdmVkIHRvIHRo
ZSBjb250cm9sIHBhZ2UuDQo+ID4gDQo+ID4gRGlkIEkgbWlzcyBhbnl0aGluZz8NCj4gDQo+IE5v
dGUgdGhhdCByZWxvY2F0ZV9rZXJuZWwoKSB1c2FnZSBhdCAoKikgaXMgaW5zaWRlIGlkZW50aXR5
X21hcHBlZCgpLiBXZQ0KPiBydW4gZnJvbSBpZGVudGl0eSBtYXBwaW5nIHRoZXJlLiBOb3RoaW5n
IGNoYW5nZWQgdG8gaWRlbnRpdHkgbWFwcGluZw0KPiBhcm91bmQgcmVsb2NhdGVfa2VybmVsKCks
IG9ubHkgdG9wIG1hcHBpbmcgKGF0IF9fU1RBUlRfS0VSTkVMX21hcCkgaXMNCj4gYWZmZWN0ZWQu
DQoNClllcywgYnV0IGJlZm9yZSB0aGlzIHBhdGNoIHRoZSBWQSBvZiByZWxvY2F0ZV9rZXJuZWwo
KSBpcyBtYXBwZWQgdG8gdGhlIGNvcGllZA0Kb25lLCB3aGljaCByZXNpZGVzIGluIHRoZSBjb250
cm9sIHBhZ2U6DQoNCiAgICAgICAgY29udHJvbF9wYWdlID0gcGFnZV9hZGRyZXNzKGltYWdlLT5j
b250cm9sX2NvZGVfcGFnZSkgKyBQQUdFX1NJWkU7DQogICAgICAgIF9fbWVtY3B5KGNvbnRyb2xf
cGFnZSwgcmVsb2NhdGVfa2VybmVsLCBLRVhFQ19DT05UUk9MX0NPREVfTUFYX1NJWkUpOw0KICAg
ICAgICANCiAgICAgICAgcGFnZV9saXN0W1BBX0NPTlRST0xfUEFHRV0gPSB2aXJ0X3RvX3BoeXMo
Y29udHJvbF9wYWdlKTsNCiAgICAgICAgcGFnZV9saXN0W1ZBX0NPTlRST0xfUEFHRV0gPSAodW5z
aWduZWQgbG9uZyljb250cm9sX3BhZ2U7ICAgIA0KDQpTbyB0aGUgKCopIGNhbiBhY3R1YWxseSBh
Y2Nlc3MgdG8gdGhlIGNvbnRyb2wgcGFnZSBJSVVDLg0KDQpOb3cgaWYgd2UgY2hhbmdlIHRvIG1h
cCBWQSBvZiByZWxvY2F0ZV9rZXJuZWwoKSB0byB0aGUgb3JpZ2luYWwgb25lLCB0aGVuICgqKQ0K
d29uJ3QgYmUgYWJsZSB0byBhY2Nlc3MgdGhlIGNvbnRyb2wgcGFnZS4NCg0KPiANCj4gQnV0IEkg
ZGlkbid0IHRlc3Qga2V4ZWMganVtcCB0aGluZy4gRG8geW91IChvciBhbnlib2R5IGVsc2UpIGhh
dmUgc2V0dXAgdG8NCj4gdGVzdCBpdD8NCj4gDQoNCk5vIEkgZG9uJ3Qga25vdyBob3cgdG8gdGVz
dCBlaXRoZXIsIGp1c3QgbXkgdW5kZXJzdGFuZGluZyBvbiB0aGUgY29kZSA6LSgNCg0KR2l0IGJs
YW1lIHNheXMgWWluZyBpcyB0aGUgb3JpZ2luYWwgYXV0aG9yLCBzbyArWWluZyBoZXJlIGhvcGlu
ZyBoZSBjYW4NCnByb3ZpZGUgc29tZSBpbnNpZ2h0Lg0KDQpBbnl3YXksIG15IG9waW5pb24gaXMg
d2Ugc2hvdWxkIGRvIHBhdGNoIDQgZmlyc3QgYnV0IHN0aWxsIG1hcCBWQSBvZg0KcmVsb2NhdGVf
a2VybmVsKCkgdG8gY29udHJvbCBwYWdlIHNvIHRoZXJlIHdpbGwgYmUgbm8gZnVuY3Rpb25hbCBj
aGFuZ2UuICBUaGlzDQpwYXRjaHNldCBpcyBhYm91dCB0byByZWR1Y2UgZHVwbGljYXRlZCBjb2Rl
IGFueXdheS4NCg0K

