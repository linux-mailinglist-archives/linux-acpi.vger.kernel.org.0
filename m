Return-Path: <linux-acpi+bounces-7652-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9967C95692C
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 13:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F7DCB23091
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 11:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6711160873;
	Mon, 19 Aug 2024 11:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MVr5gerb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB1B15535B;
	Mon, 19 Aug 2024 11:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724066220; cv=fail; b=KCqJXMKD5B5exFe5SF4ylvF7a1dKYrttL2kuVhleBaCb9OqGdUSuDZmnBVyMzPc8guVVuyHYRFMUdDjRt7qtdXfeiny2YexGf/2enstGzQAEwLeQQ051TatcyWky0Rgxvp7a7GEKwT2bB7sMX1imuHcTTD4jeNfHR66sgkYzEeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724066220; c=relaxed/simple;
	bh=usL59zPvxRV5ak2TCWisFU2BDlVVU4uN38IjvvIP1dI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rRLxUElA89JSgcMqeC22HrSbsfm2iugjg3rKnZAj0kHRMjLxIrkYxJ29urdAaTBV/mjW9p+oNNawGpLt9kgAc+K3VByBX8ZQO9yyz5LtAmMv7KQbDDBAOPdMf35O7qYqZxhC6PuCaOHpMVCB4fL/DAJDOujyoYiNRFLcLA7c3Sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MVr5gerb; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724066218; x=1755602218;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=usL59zPvxRV5ak2TCWisFU2BDlVVU4uN38IjvvIP1dI=;
  b=MVr5gerbxUBiKyc7uoL69iSpTiDw6zd2+DqNHnE2N2Yj3SovGR65Ne9l
   VQSfW59/Z+q1KyMkhow/YiqXWzTJgediiiymG0p7eXfJMN4TNEcbjbYB9
   /SyV5Zea0HejI4yBFSNhlyPtWEv6H+wmVF6dSwajckaVfye6D3rQIFwSI
   +YCqLAaXkSqubOieQxLT0+WPsCphglyuRgqY6KyMJUOEvd3Mrt7qmcQix
   eGb3Fk4/eWige59h+EriXkw0idkp+3bbikflEA5DaHv0F2RhQhW8llp6j
   US8hR/9a+SuFgv8Rv3veQOnNerRWQmJN64ziewzVrmU/U4Am7SEOWlXdh
   A==;
X-CSE-ConnectionGUID: 6SdNGGH6SmOMA61wTNybSg==
X-CSE-MsgGUID: NJXz95O7SLGp77ssr7IyHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="26063159"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="26063159"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 04:16:56 -0700
X-CSE-ConnectionGUID: dpV81sIdT426nbIiblVkBA==
X-CSE-MsgGUID: RPN+AyhZS7m58ulaFsi1XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="97817738"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Aug 2024 04:16:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 04:16:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 04:16:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 19 Aug 2024 04:16:54 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 04:16:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=noGGoHc9COCBXbrOviZPbNWfVddkrP9KaKRj10khkddn8s+WXzcD6WUq1iBuv+EHVm4i5BSFeVjTpmR9wyUk6Q/F119JjAsBRQGLXNU0wY5yZLFA4a/MM41KgLfW0mhmexXZD/cD3jHj9HYWkPRUcxO5DW33ZsZu5tLcZbWhn8YvNp7hHY2aB0LwTOPisjJ4+sDXxo6XGuikkkFoKT8Of3ZdKsADRIQG/8hmMy7AzPe8UUSBtz1TNW/Zbr+VHnt6zre7cBnYKntX2L5k5HK2P282lkM0+GVT+L2G12R4dSxH2EQYmGsg9ZpQenSR2mXEm4UDnXpI4Xne389M/R0Deg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usL59zPvxRV5ak2TCWisFU2BDlVVU4uN38IjvvIP1dI=;
 b=FAMZX+y1NIjEPSkDBw1i04Px9npCnQ6venjXsZlrTNRr6SzwC06WjGe3WzBOzQWzbxd3SrpZk0fM98WRcsK1xfUA+OtbjtpjlhSQgLz9M9Qhg0b5aNrmCBt6OLuOF/BmD61r/ZFvsaO8tqAMtpfO4QrgYnZIL9cqzfnytXeBFerk1EaUlaHEjcSjIfgPytYEiMQkdIS90jPSdZCGKIopV1+0GSARhiHYofbZ0WRiTvTOoXQPqdo2k1RPAwVOnHWADzriNSn/86yufePjTqDTPP6od0rWLaLrJ5nqqBsIvAe5E91ZctSIcw+tzZ20h2F5d2g+X10xKr2VAC0moiYfbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CH0PR11MB8215.namprd11.prod.outlook.com (2603:10b6:610:182::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 11:16:52 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%7]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 11:16:52 +0000
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
Subject: Re: [PATCHv3 3/4] x86/64/kexec: Map original relocate_kernel() in
 init_transition_pgtable()
Thread-Topic: [PATCHv3 3/4] x86/64/kexec: Map original relocate_kernel() in
 init_transition_pgtable()
Thread-Index: AQHa8gaplxIQHt1FDUe8BCwalB/rOLIuboSA
Date: Mon, 19 Aug 2024 11:16:52 +0000
Message-ID: <4c140a8e0154504e9c645b9f78b0b164dc25a461.camel@intel.com>
References: <20240819070827.3620020-1-kirill.shutemov@linux.intel.com>
	 <20240819070827.3620020-4-kirill.shutemov@linux.intel.com>
In-Reply-To: <20240819070827.3620020-4-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3 (3.52.3-1.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CH0PR11MB8215:EE_
x-ms-office365-filtering-correlation-id: 89f497c2-5a86-4e05-4147-08dcc0406d25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?aUlkdFFldFV2NEppSTJ5WExCdGVva2lHWWp4WVVYZHErR25YOSt3WUUyald0?=
 =?utf-8?B?NG92bm1GNGhzOUduK3JnUi95eXQ0ZGtvQ0gwN21ES2tpOWdueWNWaHQ5WkpG?=
 =?utf-8?B?Mkc2QVI4c0x5a2I5VDVJdjVyMDFaRmdONytwUEJWZFl5VkRIS0ZNcU5MNnhZ?=
 =?utf-8?B?QjFTaXM1YTh1d1Q5amZGbDFXK2VLRHpSOVRBa2VYUmpjM3lXdHZESzEzdytu?=
 =?utf-8?B?RkRPRjhJMkNuWmxLVFJPZ0JFcXlZNnFpTW1NNlFGNnVnTkZZUzJqZzh1MThY?=
 =?utf-8?B?LzVvdDFVZmd4U2R6cjk3OERDTnJaVFhUS1BJMEgyNWlOVFV2dm5RYVlTeVQ4?=
 =?utf-8?B?SG9WT2ZManJJa3VrS1FrbEdEMjdSUFh1L0ZtaldpTTA0eUxUVUswT2crTi81?=
 =?utf-8?B?Znp3STZtbkdqMThhMERRaVhtbHExUitLcStlNURTZGozUmk0dlR3UUpycDZS?=
 =?utf-8?B?anVScHZVVE9QTTlSZHJxSG5yRDMxZ3RJcGwzc3JSdnNQZng4YWYxWGt6a2J3?=
 =?utf-8?B?NXNRTjRXWmJWb01YZkd2R0JFZGo3KytTWXV0SklyWlg5LzZISTFaU3JLQTRU?=
 =?utf-8?B?Smp2bmVYQTdNMnRidzRRZ1UzYkcyczM2RHZRQ1JLZ3hyQU9Hc3E3ZXFzaVhk?=
 =?utf-8?B?MVBJVzFrNXQ0c1UwRUUwRXIxUDNBVUJjdjNKcEttZjVjYUpoWWYvNVorM0d6?=
 =?utf-8?B?YlA0T0ZDd0RhMm93Zyt3c1Ayb2E1T0dKbGlYQmw0aklCSlZGbVRwMkppNzNw?=
 =?utf-8?B?NmV5dVc0b2t2YVhTQytDd1Vkdm8xRVAwQ2N6MnhJV2xVSWx2S3QzQ1I0MjdD?=
 =?utf-8?B?NUdxT085N1RiVGlaemRzQnJmM3VWbXF3MXFnZ0pRUkQrWVNxeDFDRWlabmJp?=
 =?utf-8?B?U2krSVhDaVZZNDcvalRMU1BvUEtOb29CV3VLbTZMcitWaGN2UTVyUUFUc2Z1?=
 =?utf-8?B?cmp0SWJTMTdkWllaNDJzVklLZE9veVh6VVBsekRlclNOcWNhOTQ4dUVGbHBM?=
 =?utf-8?B?NVVqRE1PV0prMTBtUzhZa2dieGFSRjhyMmt4QWRXaWR1UVVwWndLVjAzQnFr?=
 =?utf-8?B?aVJxUFFpRkFIL29LbWd1QXNJY2tia3oveDlmVm90MDZ6ZGdGa01CVzBqaGI5?=
 =?utf-8?B?U3M0ejFtVkxaSHlQQlZXTHUwVExUZXA5aVltaThpdmZPVHZ6UHozQ2ZWT2ht?=
 =?utf-8?B?TkpiRW94c1BoWE5hSlRSQVlRbnEyN3ZISTRZdmMvdFFLUjZyOTVGYXlZeGth?=
 =?utf-8?B?T2xOR3dLVUQ3QlhQMy92WmN4RzJkVkEra3JmdDMvU1dsL0dnc09HZEJJZExk?=
 =?utf-8?B?WThBbEwzQ0VUeEROWldrSUNTSWxzTE02dWRIWjV1VG9XTW9odXlGdlB4eDJ5?=
 =?utf-8?B?QkpPSjBxQnVYeE45MEl1MEZlSUdSa2xMQWRSUVdlOTN1OEdpWEJibnpMK1Ny?=
 =?utf-8?B?ZDlOemp2NlFIS0V1S3QzQ3NTZ0NnVFdDbUhQZjZ5NXQxbXVyN241N3Y4WUZF?=
 =?utf-8?B?dlRYdE5mZytPcmJXSUhwY0lXWTRXZWU4YlBYSnJYY0E3T0FzUWVxQnM2TmNo?=
 =?utf-8?B?Qit3aWgxNXV1cFRTYmFka3l0cXpneWNFcVp6bjF1N1Y5dmloeVpNdktYRkFW?=
 =?utf-8?B?M3F5eHdMcXhiaENGaENIdEN2OGZLUDdyeHFzcVdUMUUyTUNXRzV5TjVSb3F1?=
 =?utf-8?B?NXJ2QVVYNVl6Y09keWgwOTgvNHQxWmRVL3kxQkZIVGNMb1lxK3pHM2NoUzg2?=
 =?utf-8?B?T2FXd3IySTlUQ2VGd2JSZy9rZ3U3bmdWODdjMGpGUkE3ZFJsSmRmdGxrcmk1?=
 =?utf-8?B?eDdvNnRtNC9HSmFja0MxY1lzTFBuUVhOOHhMeE5iRXpwOUIvUmM3M0p5WmNq?=
 =?utf-8?B?T2pPTTZrcEFQcGxPRGE3WGtBRjRSOHdsVE54aTRzOXVqL0I3TisvYlBGcCtp?=
 =?utf-8?Q?kT72pmvY0Z0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WmJjdlYzOFRFSWUvMTBvb2Rad1hUdjFlZXJQcGpqVlFXSjZMenFOV0JKSHow?=
 =?utf-8?B?Q0tZS2Rlc2FhQlY3ZVZUczFMWEh3MVk0NVl6SDZXVW5tOVhzUXpzT2JOdC9Y?=
 =?utf-8?B?Z0E3NmVPQ0lqS1NPVHNyQnM5cSt3WDJJUVVBWmxoNXBQdUkxMktKQ2pCYnpn?=
 =?utf-8?B?MlEwVmp5cHhFcmxlKytMamFVK0JZZnp0NWU5OVpybzV5aTZnbW44WmpJU3B0?=
 =?utf-8?B?d2pQRE51TFNXeit4UEJyN25UeThzTWdyVXBUTWhCV3c0VnVMSHFmYTJyTkJI?=
 =?utf-8?B?eUhobjBOV3pCbE5yRWt4ekI5MmFUb2pmREU4WG1MK2lFbTZVZ1FGcHpJaUpL?=
 =?utf-8?B?RGVGckcvMHJYV2gzZHM2QTlZbTNFZ1h6cHRBMERWMEpUM252UjM4WUd1RGRp?=
 =?utf-8?B?eTVzdGFLNnZPeDNUMDkzeFR5akhaZktGMEV5NlNVZnBUOExzcnFPcnRuTWlK?=
 =?utf-8?B?TkpMc0RwR0lVaVFWNHNyZ0RHY0kyMnBUM0NxSTRwZU5JcjRWK095OWtyVHZB?=
 =?utf-8?B?OHk5enlSSS9zSGdnb2hDY2tMUXRncnN4TldFaWhLRHhCLytBdFY5Tm1XYk9B?=
 =?utf-8?B?M3NKS2lCU3Zwd1VvcEkwRVBNNUJ0NlVvcjIxOUdvblRydW5aMXA2N2FEUE5Z?=
 =?utf-8?B?VCtiL1FnOEttc3U4ekZmOHNiZTVLKzZuZk1SZlhIbDdIRFJsZzF6dk5SNm91?=
 =?utf-8?B?cXYwcHBpSnF2M0tqNmY4cDBiYnE3UlJlc21OOHppanFCQ201QTdwMHVmcjhO?=
 =?utf-8?B?ZllvTWQrK3EvS3loVXdsZDVuaXQvNEhza0tPZjd5cjVNY3hrenIvQXVxVXpj?=
 =?utf-8?B?dlVMZXNDZ1dLbFBjS2xUYys3S0IyMGZNakJ6VHNYTTB4bUJ2Tm5kckFmV0Z3?=
 =?utf-8?B?YzFqTXloY21tM2ZnMzdWa0hsUEFaUDhtRGdUUkZKWE9JM2dsUUlkZXBLOUpj?=
 =?utf-8?B?VXNoTlI5dkpsRXg1ZXdya3ZIdFV0b0tXK0kxVzgrQ1NiNTZKNkpOeGNmLzFi?=
 =?utf-8?B?TG5aMWxrMkthMC8yRzhLMWtpOURqa3VjRy9WOEdYRTdocXRTZmQyOWV1KzJL?=
 =?utf-8?B?aWVJdlJ2T0U0TUpkbm9XWXJXU2xKZkVEMmZKMU9SZ0VsVGJDRndqTnA0ZW4v?=
 =?utf-8?B?emdTLzNjUktQVU1XMXAvbzhKL1lrREcxOHpJZ1BTbG1PQ3ZpVEw3UUdrWDZr?=
 =?utf-8?B?NHEyQkhycGU4WFZWTHpRLzJacCtyUjFsYjczNjZKRHkwemtydnBabGtqVkR2?=
 =?utf-8?B?eHlQNzJKelhmYkpwdU12Q05vU2F3Z2NTUUsyV2lQK3p3ZWpURXdFZk5CeGVO?=
 =?utf-8?B?OEs0dXBoWTZtTGJ0YlR3MHV3WFY3N2pNOER6TEhqb1lxTjRzNTU3aHM2UkJ5?=
 =?utf-8?B?aGVCeHN3cGR0YThWQXFaRlJaSnUyTGR4K0tjWEhIY0IwMmlGRnBOdGVHY3ZM?=
 =?utf-8?B?eWpJVWV4dlRIbEVMZFd5TnhUd2pRUTJMYmN5YW5NUFJFUXhYRXU1cll2U0VP?=
 =?utf-8?B?bG4yRVg1MW9CaUJGSWRHb1E4elZuVXJXVU1YQW1FY3A0YzRVWndlMEQxSjhz?=
 =?utf-8?B?d1BuU0J4dTljQ2xSYllxRVRDREdJWEM2S29ZTFYvMkttMnN2Q05RRXpUMG5G?=
 =?utf-8?B?S2JCempVd1NlQ2JFd1FnNGVYcTdxbGNJY00vQWgzQitYN2JuSkM0M2l0YmFp?=
 =?utf-8?B?a3Bwc2hMdEF0YjZDVXJnNG56SmlHNlNnbzNxYUU5OUFzSy9SYlFTWDNJVVZV?=
 =?utf-8?B?MEF6NUlTQ2dLK2VFTlFWd01veHBwRi92cm1kQk5YZFRQSWw0anRhZ3k2VVZk?=
 =?utf-8?B?eHVJMkFTM1gvUEh0anh2WjE3V2N1SGF6bmZlTkJNdzljQkhhS2dIOE5ZTVZP?=
 =?utf-8?B?cXZjeHRIZXF5SkZuVUZrUGxESnA1TnErZnNiNEVMZ3ErSG9JZzdLa3dwbDNa?=
 =?utf-8?B?ZEltRDBNRElERm9HZjNxaEUzMkowdWtkd3BTOWRZeE1PNVc3d2tLYVVJcHR5?=
 =?utf-8?B?MnFUa2VOejZJV2F3YzNNOXFXdzA2aWswRmRKUVZRbGpJNGVZQjQ0dHVZSmpP?=
 =?utf-8?B?UTNGWWlGZ2pKMU1HOFBUNWJHUGlvOXZOcnMwWTZ3N3NhWTUxRkVKMnlTV0tH?=
 =?utf-8?Q?fJ+7351KOXOResan2JL5ieCkb?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6793EE95ABAC0A4DA532AB6B526BA355@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89f497c2-5a86-4e05-4147-08dcc0406d25
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 11:16:52.1187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ygt22nxQ3WJqgyW9LDGh0RTntxNcZ3OR+/6PK74piqac42dtahUfjoScHB2NQJP6a2k1jbggrvzyhdmlRM14dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8215
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTA4LTE5IGF0IDEwOjA4ICswMzAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IFRoZSBpbml0X3RyYW5zaXRpb25fcGd0YWJsZSgpIGZ1bmN0aW9uIHNldHMgdXAgdHJh
bnNpdGlvbmFsIHBhZ2UgdGFibGVzLg0KPiBJdCBlbnN1cmVzIHRoYXQgdGhlIHJlbG9jYXRlX2tl
cm5lbCgpIGZ1bmN0aW9uIGlzIHByZXNlbnQgaW4gdGhlDQo+IGlkZW50aXR5IG1hcHBpbmcgYXQg
dGhlIHNhbWUgbG9jYXRpb24gYXMgaW4gdGhlIGtlcm5lbCBwYWdlIHRhYmxlcy4NCj4gcmVsb2Nh
dGVfa2VybmVsKCkgc3dpdGNoZXMgdG8gdGhlIGlkZW50aXR5IG1hcHBpbmcsIGFuZCB0aGUgZnVu
Y3Rpb24NCj4gbXVzdCBiZSBwcmVzZW50IGF0IHRoZSBzYW1lIGxvY2F0aW9uIGluIHRoZSB2aXJ0
dWFsIGFkZHJlc3Mgc3BhY2UgYmVmb3JlDQo+IGFuZCBhZnRlciBzd2l0Y2hpbmcgcGFnZSB0YWJs
ZXMuDQo+IA0KPiBpbml0X3RyYW5zaXRpb25fcGd0YWJsZSgpIG1hcHMgYSBjb3B5IG9mIHJlbG9j
YXRlX2tlcm5lbCgpIGluDQo+IGltYWdlLT5jb250cm9sX2NvZGVfcGFnZSBhdCB0aGUgcmVsb2Nh
dGVfa2VybmVsKCkgdmlydHVhbCBhZGRyZXNzLCBidXQNCj4gdGhlIG9yaWdpbmFsIHBoeXNpY2Fs
IGFkZHJlc3Mgb2YgcmVsb2NhdGVfa2VybmVsKCkgd291bGQgYWxzbyB3b3JrLg0KPiANCj4gSXQg
aXMgc2FmZSB0byB1c2Ugb3JpZ2luYWwgcmVsb2NhdGVfa2VybmVsKCkgcGh5c2ljYWwgYWRkcmVz
cyBjYW5ub3QgYmUNCj4gb3ZlcndyaXR0ZW4gdW50aWwgc3dhcF9wYWdlcygpIGlzIGNhbGxlZCwg
YW5kIHRoZSByZWxvY2F0ZV9rZXJuZWwoKQ0KPiB2aXJ0dWFsIGFkZHJlc3Mgd2lsbCBub3QgYmUg
dXNlZCBieSB0aGVuLg0KPiANCj4gTWFwIHRoZSBvcmlnaW5hbCByZWxvY2F0ZV9rZXJuZWwoKSBh
dCB0aGUgcmVsb2NhdGVfa2VybmVsKCkgdmlydHVhbA0KPiBhZGRyZXNzIGluIHRoZSBpZGVudGl0
eSBtYXBwaW5nLiBJdCBpcyBwcmVwYXJhdGlvbiB0byByZXBsYWNlIHRoZQ0KPiBpbml0X3RyYW5z
aXRpb25fcGd0YWJsZSgpIGltcGxlbWVudGF0aW9uIHdpdGggYSBjYWxsIHRvDQo+IGtlcm5lbF9p
ZGVudF9tYXBwaW5nX2luaXQoKS4NCj4gDQo+IE5vdGUgdGhhdCB3aGlsZSByZWxvY2F0ZV9rZXJu
ZWwoKSBzd2l0Y2hlcyB0byB0aGUgaWRlbnRpdHkgbWFwcGluZywgaXQNCj4gZG9lcyBub3QgZmx1
c2ggZ2xvYmFsIFRMQiBlbnRyaWVzIChDUjQuUEdFIGlzIG5vdCBjbGVhcmVkKS4gVGhpcyBtZWFu
cw0KPiB0aGF0IGluIG1vc3QgY2FzZXMsIHRoZSBrZXJuZWwgc3RpbGwgcnVucyByZWxvY2F0ZV9r
ZXJuZWwoKSBmcm9tIHRoZQ0KPiBvcmlnaW5hbCBwaHlzaWNhbCBhZGRyZXNzIGJlZm9yZSB0aGUg
Y2hhbmdlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogS2lyaWxsIEEuIFNodXRlbW92IDxraXJpbGwu
c2h1dGVtb3ZAbGludXguaW50ZWwuY29tPg0KPiAtLS0NCj4gIGFyY2gveDg2L2tlcm5lbC9tYWNo
aW5lX2tleGVjXzY0LmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvbWFjaGlu
ZV9rZXhlY182NC5jIGIvYXJjaC94ODYva2VybmVsL21hY2hpbmVfa2V4ZWNfNjQuYw0KPiBpbmRl
eCA5YzlhYzYwNjg5M2UuLjY0NTY5MGU4MWMyZCAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYva2Vy
bmVsL21hY2hpbmVfa2V4ZWNfNjQuYw0KPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvbWFjaGluZV9r
ZXhlY182NC5jDQo+IEBAIC0xNTcsNyArMTU3LDcgQEAgc3RhdGljIGludCBpbml0X3RyYW5zaXRp
b25fcGd0YWJsZShzdHJ1Y3Qga2ltYWdlICppbWFnZSwgcGdkX3QgKnBnZCkNCj4gIAlwdGVfdCAq
cHRlOw0KPiAgDQo+ICAJdmFkZHIgPSAodW5zaWduZWQgbG9uZylyZWxvY2F0ZV9rZXJuZWw7DQo+
IC0JcGFkZHIgPSBfX3BhKHBhZ2VfYWRkcmVzcyhpbWFnZS0+Y29udHJvbF9jb2RlX3BhZ2UpK1BB
R0VfU0laRSk7DQo+ICsJcGFkZHIgPSBfX3BhKHJlbG9jYXRlX2tlcm5lbCk7DQo+ICAJcGdkICs9
IHBnZF9pbmRleCh2YWRkcik7DQo+ICAJaWYgKCFwZ2RfcHJlc2VudCgqcGdkKSkgew0KPiAgCQlw
NGQgPSAocDRkX3QgKilnZXRfemVyb2VkX3BhZ2UoR0ZQX0tFUk5FTCk7DQoNCg0KSUlVQywgdGhp
cyBicmVha3MgS0VYRUNfSlVNUCAoaW1hZ2UtPnByZXNlcnZlX2NvbnRleHQgaXMgdHJ1ZSkuDQoN
ClRoZSByZWxvY2F0ZV9rZXJuZWwoKSBmaXJzdCBzYXZlcyBjb3VwbGUgb2YgcmVncyBhbmQgc29t
ZSBvdGhlciBkYXRhIGxpa2UgUEENCm9mIHN3YXAgcGFnZSB0byB0aGUgY29udHJvbCBwYWdlLiAg
Tm90ZSBoZXJlIHRoZSBWQV9DT05UUk9MX1BBR0UgaXMgdXNlZCB0bw0KYWNjZXNzIHRoZSBjb250
cm9sIHBhZ2UsIHNvIHRob3NlIGRhdGEgYXJlIHNhdmVkIHRvIHRoZSBjb250cm9sIHBhZ2UuDQoN
ClNZTV9DT0RFX1NUQVJUX05PQUxJR04ocmVsb2NhdGVfa2VybmVsKQ0KICAgICAgICBVTldJTkRf
SElOVF9FTkRfT0ZfU1RBQ0sNCiAgICAgICAgQU5OT1RBVEVfTk9FTkRCUg0KICAgICAgICAvKiAg
ICAgIA0KICAgICAgICAgKiAlcmRpIGluZGlyZWN0aW9uX3BhZ2UNCiAgICAgICAgICogJXJzaSBw
YWdlX2xpc3QNCiAgICAgICAgICogJXJkeCBzdGFydCBhZGRyZXNzDQogICAgICAgICAqICVyY3gg
cHJlc2VydmVfY29udGV4dA0KICAgICAgICAgKiAlcjggIGJhcmVfbWV0YWwNCiAgICAgICAgICov
DQoNCgkuLi4NCg0KICAgICAgICBtb3ZxICAgIFBUUihWQV9DT05UUk9MX1BBR0UpKCVyc2kpLCAl
cjExICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCiAgICAgICAgbW92cSAgICAlcnNwLCBS
U1AoJXIxMSkgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQog
ICAgICAgIG1vdnEgICAgJWNyMCwgJXJheA0KICAgICAgICBtb3ZxICAgICVyYXgsIENSMCglcjEx
KQ0KICAgICAgICBtb3ZxICAgICVjcjMsICVyYXgNCiAgICAgICAgbW92cSAgICAlcmF4LCBDUjMo
JXIxMSkNCiAgICAgICAgbW92cSAgICAlY3I0LCAlcmF4DQogICAgICAgIG1vdnEgICAgJXJheCwg
Q1I0KCVyMTEpDQoNCgkuLi4NCg0KCS8qDQogICAgICAgICAqIGdldCBwaHlzaWNhbCBhZGRyZXNz
IG9mIGNvbnRyb2wgcGFnZSBub3cNCiAgICAgICAgICogdGhpcyBpcyBpbXBvc3NpYmxlIGFmdGVy
IHBhZ2UgdGFibGUgc3dpdGNoDQogICAgICAgICAqLw0KICAgICAgICBtb3ZxICAgIFBUUihQQV9D
T05UUk9MX1BBR0UpKCVyc2kpLCAlcjgNCg0KICAgICAgICAvKiBnZXQgcGh5c2ljYWwgYWRkcmVz
cyBvZiBwYWdlIHRhYmxlIG5vdyB0b28gKi8NCiAgICAgICAgbW92cSAgICBQVFIoUEFfVEFCTEVf
UEFHRSkoJXJzaSksICVyOQ0KDQogICAgICAgIC8qIGdldCBwaHlzaWNhbCBhZGRyZXNzIG9mIHN3
YXAgcGFnZSBub3cgKi8NCiAgICAgICAgbW92cSAgICBQVFIoUEFfU1dBUF9QQUdFKSglcnNpKSwg
JXIxMA0KDQogICAgICAgIC8qIHNhdmUgc29tZSBpbmZvcm1hdGlvbiBmb3IganVtcGluZyBiYWNr
ICovDQogICAgICAgIG1vdnEgICAgJXI5LCBDUF9QQV9UQUJMRV9QQUdFKCVyMTEpDQogICAgICAg
IG1vdnEgICAgJXIxMCwgQ1BfUEFfU1dBUF9QQUdFKCVyMTEpDQogICAgICAgIG1vdnEgICAgJXJk
aSwgQ1BfUEFfQkFDS1VQX1BBR0VTX01BUCglcjExKQ0KDQoJLi4uDQoNCkFuZCBhZnRlciBqdW1w
aW5nIGJhY2sgZnJvbSB0aGUgc2Vjb25kIGtlcm5lbCwgcmVsb2NhdGVfa2VybmVsKCkgdHJpZXMg
dG8NCnJlc3RvcmUgdGhlIHNhdmVkIGRhdGE6DQoNCgkuLi4NCg0KICAgICAgICAvKiBnZXQgdGhl
IHJlLWVudHJ5IHBvaW50IG9mIHRoZSBwZWVyIHN5c3RlbSAqLw0KICAgICAgICBtb3ZxICAgIDAo
JXJzcCksICVyYnANCiAgICAgICAgbGVhcSAgICByZWxvY2F0ZV9rZXJuZWwoJXJpcCksICVyOAkJ
PC0tLS0tLS0tLSAgKCopIA0KICAgICAgICBtb3ZxICAgIENQX1BBX1NXQVBfUEFHRSglcjgpLCAl
cjEwDQogICAgICAgIG1vdnEgICAgQ1BfUEFfQkFDS1VQX1BBR0VTX01BUCglcjgpLCAlcmRpDQog
ICAgICAgIG1vdnEgICAgQ1BfUEFfVEFCTEVfUEFHRSglcjgpLCAlcmF4DQogICAgICAgIG1vdnEg
ICAgJXJheCwgJWNyMw0KICAgICAgICBsZWEgICAgIFBBR0VfU0laRSglcjgpLCAlcnNwDQogICAg
ICAgIGNhbGwgICAgc3dhcF9wYWdlcw0KICAgICAgICBtb3ZxICAgICR2aXJ0dWFsX21hcHBlZCwg
JXJheA0KICAgICAgICBwdXNocSAgICVyYXgNCiAgICAgICAgQU5OT1RBVEVfVU5SRVRfU0FGRQ0K
ICAgICAgICByZXQNCiAgICAgICAgaW50Mw0KU1lNX0NPREVfRU5EKGlkZW50aXR5X21hcHBlZCkN
Cg0KTm90ZSB0aGUgYWJvdmUgY29kZSAoKikgdXNlcyB0aGUgVkEgb2YgcmVsb2NhdGVfa2VybmVs
KCkgdG8gYWNjZXNzIHRoZSBjb250cm9sDQpwYWdlLiAgSUlVQywgdGhhdCBtZWFucyBpZiB3ZSBt
YXAgVkEgb2YgcmVsb2NhdGVfa2VybmVsKCkgdG8gdGhlIG9yaWdpbmFsIFBBDQp3aGVyZSB0aGUg
Y29kZSByZWxvY2F0ZV9rZXJuZWwoKSByZXNpZGVzLCB0aGVuIHRoZSBhYm92ZSBjb2RlIHdpbGwg
bmV2ZXIgYmUNCmFibGUgdG8gcmVhZCB0aG9zZSBkYXRhIGJhY2sgc2luY2UgdGhleSB3ZXJlIHNh
dmVkIHRvIHRoZSBjb250cm9sIHBhZ2UuDQoNCkRpZCBJIG1pc3MgYW55dGhpbmc/DQoNCg0K

