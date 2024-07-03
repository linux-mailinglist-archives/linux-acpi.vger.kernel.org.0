Return-Path: <linux-acpi+bounces-6750-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD1B924DF0
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jul 2024 04:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3B3D1C24EA9
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jul 2024 02:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4574683;
	Wed,  3 Jul 2024 02:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hFxDlmOL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D331146B5;
	Wed,  3 Jul 2024 02:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719974422; cv=fail; b=gKxYzH055tH4b7Q+Ukxh4cbEzgirWlI6GLR0opx90vk3pKMxPlhY4MxwKidgsd+TPp+KzWU0+xhiv/awrgHxzqRIV33Qxu3dEWK6xQT7kAMQveW0VAyg3DxQJH7KmGgAPxEaWE8vMMBsdK2DqLtoprzLcxK7miyNRR9EPcBEgpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719974422; c=relaxed/simple;
	bh=kpXJqWwneebVeYtNAJJ8Jd2QPLnvnArffFFAt/pAjxM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fJD4qdr2gmUDQiorIuDo4r3s/F6C50PV68McGrUnTWWL5u6oy1eDvjhYi+e1U69pFnBzkKHjftcu//dBhJ1u3LwsWMJ9DvYmMBNx2F1R9AWkNgRlpScWbl7xNWxb/FcGJcghw+r3hXPQaqRhph7XiHFPhjVGHM80cX/3ky5qcj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hFxDlmOL; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719974420; x=1751510420;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kpXJqWwneebVeYtNAJJ8Jd2QPLnvnArffFFAt/pAjxM=;
  b=hFxDlmOL5wokRLdLyDnY7DuzuzgIdLMKQMhGDjEhRu3Kbfom2UKe6xX1
   cT+68GevQyzXmdZMe30idJ2uBZk/4f3Xz7CTdSQlWJNri0rpO1Ckyu5dK
   R8U3ovsdWN0loyHJvTDeDGTSL86l4oEpaopt3VSEYqrRA8U3y3Wd6rE3N
   JL2PdD3lMyh5IQmxdoF3F266MXFfqe6C2LvTkcJ/eysXva6gSI5IJsRqb
   Doir0F/o8iM/QZWC8fWa0/gg/ei5TNthOtRtXFJomkM6yhOR4a9zA0JaN
   hqzfecwxscWutmcMTmR7FZpkwv8aZKLH7300XeHns3WEwsky4yRWpo4+q
   w==;
X-CSE-ConnectionGUID: JrkuODtlT9aDZOdIXUlAfw==
X-CSE-MsgGUID: ambTPP1uRzCW+eEZTuJXaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="16839048"
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="16839048"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 19:40:19 -0700
X-CSE-ConnectionGUID: NV//HrizQy+mQgXnLmcEUQ==
X-CSE-MsgGUID: GLRxK2cDQS6GjMpcIp98Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="46837159"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Jul 2024 19:40:20 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 2 Jul 2024 19:40:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 2 Jul 2024 19:40:18 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 2 Jul 2024 19:40:18 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 19:40:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EF568CSiPVwEcGHWngOgZ1b+JDetFQRxYEBxYgF0bn6TXx/hhgbFp8ci+HFnFd2ieTWwpvJqI5J9CpfWJdM7gJCkuE4pWwQaSc4ceWYoJ0+guI4GcfLrWPIDTS124yIZseI9QwP6LK8xmlNXYlso+mmFQVfKRmRlKiUWvVSi50quRtggQKDcupxmJueeNG6UMmhE44tPJBZ8Q3JY1dK4aIqXgkZMIwP3zKaJKu+dZsEFl3P+CaShSfd4gc2lbkik5dL3JsEAuPCrRngIFR3P6Zuk4CUPVdc47L8y/ksaM2MY+aN+i8CufybZFMWU1jiVCu8SnTRGfdRK3cXmxfzKww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdENCG3RMa/SgYpbYliRWWfxYfZ8TYeXkbOdfp0sq60=;
 b=Do8Q56Ilfc6kLuGdXG3Uc4fJq2OSgO03qk6B6D5YWYQS3/V3k+rivV5rZBlTgOy8a/IJer4wH17/Biz1NegYzYWjfSnbakEkpYDdsDRDJJlO2DYgixc53+d0+rDCHF4SZfmW4fhjPgZv/Ez7vAiHd8QlcLIAEROI7LQZTjIqwLG83RwEwhUkq/PjuIkfJG9vIoVI6FdECRNbLifmpwaG9fl5ns+RN0UvBM7okJRwnKpJfVWfbCM6yiA01WZouq757YPdSj4fuZHxJJjFUhWKmJ81d3Lrn0AC4bR/+RqLmNdEtEoXtQxspg8NGLhlsCFXWVyXmfeON3gNMkshZkc3wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB8478.namprd11.prod.outlook.com (2603:10b6:510:308::11)
 by SA1PR11MB5827.namprd11.prod.outlook.com (2603:10b6:806:236::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Wed, 3 Jul
 2024 02:40:15 +0000
Received: from PH7PR11MB8478.namprd11.prod.outlook.com
 ([fe80::6961:eda0:dc93:5b4d]) by PH7PR11MB8478.namprd11.prod.outlook.com
 ([fe80::6961:eda0:dc93:5b4d%6]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 02:40:15 +0000
Message-ID: <2ce73ea8-bd1e-4148-8206-ffac8926a5d1@intel.com>
Date: Wed, 3 Jul 2024 10:39:43 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] x86/acpi: fix panic while AP online later with kernel
 parameter maxcpus=1
To: "Huang, Kai" <kai.huang@intel.com>, "bp@alien8.de" <bp@alien8.de>
CC: "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
References: <20240702005800.622910-1-zhiquan1.li@intel.com>
 <41ee5438e8059c299f5722e386cdc1457ddc16eb.camel@intel.com>
 <20240702124524.GEZoP2ZKcTcKl1ca1R@fat_crate.local>
 <1b716b14c52a89c254108df1cee85306c786c52b.camel@intel.com>
From: Zhiquan Li <zhiquan1.li@intel.com>
Content-Language: en-US
In-Reply-To: <1b716b14c52a89c254108df1cee85306c786c52b.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:195::6) To PH7PR11MB8478.namprd11.prod.outlook.com
 (2603:10b6:510:308::11)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB8478:EE_|SA1PR11MB5827:EE_
X-MS-Office365-Filtering-Correlation-Id: 8040b3ef-0f92-4d9b-342f-08dc9b097860
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RFBvV0Y1VzhSbmlYSzFhcStWTzdhY044eStJbStRWktpSjMxYmo4bHdYNTBT?=
 =?utf-8?B?WFFMTlF3c0xuQnc3YmlPYnZlOXBvMk4xek9IYm4rczdCRDY2M205dlFBYVFX?=
 =?utf-8?B?ZWZ3NEV2SE5URW4xSnBmRVh4azBRZm93aitVTFhmTDVJcWFNdko2K1c1N0tO?=
 =?utf-8?B?K0libXV3c1pvdGJQQ3MrT3ZjQk5OT2VhNTRpMlBOMTZkbmlvMmxTaThqYm5M?=
 =?utf-8?B?TjhlbVlzUmRlclVKRmI1SGg1T21Gd0NRY29QWitrWVFlZFc4RzF2alNsU1lG?=
 =?utf-8?B?Q1EyOXVCYnorcmdZNmx3YkxrbExCR1JRb2RJVzB0NVNvMGZ2bmtHZmFOeXdw?=
 =?utf-8?B?UXBsaThZd0J4OGc1MlFaSktIc0cvOStzT01wVXkwLzY3QVNrUU92a2IrVHRN?=
 =?utf-8?B?YXBaYmNXc0FIU0ZMZVg5SU4rL1VPZmgzL3NoZXdheW43Y09FSXpRUGxzOGps?=
 =?utf-8?B?STZJcWExRG52V05UdUxRaU9uNnpGZ2lSWDJKY2w5cGFSZ0JTQVVvcjBaYnZ3?=
 =?utf-8?B?TjU3NlZxWGNwbEg1SSswZXA3c1RjMWIvU3FCOGthaVErTW9nZHlGN2w2WTc1?=
 =?utf-8?B?Y1JQZjBkTnZoc2MwckdNcFZJUU9VekR1SzVxaFd3TDVWelZCTU1uOEJHWWl6?=
 =?utf-8?B?dDY1U2gzVXJvdFU4RGdzb21Sd2pwY1lyajQzcDV6NjBoTHk2ZXBOYXpXSE5S?=
 =?utf-8?B?NGlXY1ZTWjRObEJFTlNvdWl2UFJBQm5WeWdnRW0vRFpsSUMrVWljZkQxa2xG?=
 =?utf-8?B?cExRK2JpWVhJZG9KU0k0ZUdGM0Zib3luMTRMelhxcmltSWlxVnNxRjZ3V2cx?=
 =?utf-8?B?RmI3SFk2bU05ekIxRlpXZ0g0ZDJCaW9QUkpRcmlkZ09mVlVtOU11cmUwVnd4?=
 =?utf-8?B?WWZzUVlPQjJMbS9nK1lvTUVTczlOdElKT0krOUZjaWNqcnZQZnpqMElhV0kv?=
 =?utf-8?B?b09hUFViczlKZ3J3ZlR2VDlpOUlCVWhPdVk1Mnc4WFVrRk1MOG0xMXRscktT?=
 =?utf-8?B?c0pwR0o5ZjF0V0FRcXhmRWZVaGcwTWdhMUVJZUo3SGNOMFpmZ2dQZ3pIaTlX?=
 =?utf-8?B?KzJKNkxFRWo4ZVhZanFUcHNMTm1VSWQ2WW42NUdBTVJ6VldMSlNhT1R4WnpZ?=
 =?utf-8?B?RkFaUVJjRXFnUEROY0srUXBtN25IMHBsNWp4K1hMR2hEWUZsVFVIY0V2R2N6?=
 =?utf-8?B?c1lMSnk1OXk5a0NnR1VrbU1vMnpDV3RlcFdnbnd0Y3liR1A0MmtOS0dKS0xz?=
 =?utf-8?B?cG81MUJORkRkTVgzTkpXSmE4Qjl1NytlN1RPWVRybUpCUS9aR1kvOG9xWG1O?=
 =?utf-8?B?cmZCeGJ1WTJCV21VY2Q4RTJpc2tyVVI4MkR5b0gxRk9lQ0xlbmx2Q21icE5F?=
 =?utf-8?B?L2N0SEkxZGYwMC9zcnZ4cWFHdWJQbzhkMTBLd2N3blNtd2JCSklmVkkxK0dn?=
 =?utf-8?B?bzg0Q3BuRmVTdmtWaXhhclRINDhKbC83SDBxcWxCQ25yZ3IybjZDbDFiOU13?=
 =?utf-8?B?NkRGYk9MRzM5cjRTLzBlWHFZWG9FNzVBZy9FaEdxOHRlOEJMOWw2N3pxMUIr?=
 =?utf-8?B?UVppbXcrTlZZMHY4S0tmMWNudXRSWWo5STkrc0wvdVVDVjBsc1FKSE4zQ3Ny?=
 =?utf-8?B?ZnQ3RlZudDdRNU8zZTVuWTkwRjJPd3BlZFFtSk9tcnFoQXcvS1dXWFh5ZWY4?=
 =?utf-8?B?WisyQW9hSEU3R1ppVjBsL1Bod29RWjBVbWVQTXh2aytFZWpQZjdvMXZGdkx1?=
 =?utf-8?B?K25iZUVaVit1dzh3VVhOM2g5Qm9BcWRRa2IvSEJWbjdPVEpvcnBuQmt4VXlm?=
 =?utf-8?B?RTJYMzE4cHJpQ090QU5mdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8478.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDFGSC9aeEhCaVAzUGxQWFZmQkx0Y0dEeHhodllpdGg3Z0pSeUdHM2N1Q3J1?=
 =?utf-8?B?NmFrTEk1N2MxOUdJSE1sUm9WdFRTdldIRjNveG9uei9MUVBXS3BPbjhCZWI1?=
 =?utf-8?B?TzdZNUVlL0VBcUgvZ0Y4cXZKZDFKS21SR2JEME9BQ29xd1hmVHJscVUybFUx?=
 =?utf-8?B?bG9nSmNQUDF2YkVoMnVaWi9TS0xHajA2TFpNcHZBeThxQnVvUkFBYlFXaTJW?=
 =?utf-8?B?NWM3djNDWVNPanlHZFZGVURqekloN05kb21BUHNjVldjTUQ4OHd6VE84NzZn?=
 =?utf-8?B?VzJTdzQxUXUyMHVNaytaTjNnSmxQMHVnVHVYVXo0TG81cWtaTjUwMytPOS80?=
 =?utf-8?B?UVd1RWhSa3NlUjVZLzNreWN1bHdKZXY0Z0ZIZjZGUEVOSWsxTjdyNVpidUJH?=
 =?utf-8?B?RnhpWSt5V3hCV3ZpWm83Z2dZWjV1S0c5SzFINGw1Q0s5VDFSMHduRnN4UTV1?=
 =?utf-8?B?WU56T2RvWUFRbzZ0Zlp4dE5GV2R3emxjMmRuMlBHUG9Fazk4SERpK1lFOS9k?=
 =?utf-8?B?RGRWOG9oSmhDVmdFY1h3b0ppQ1lwNFpXOERCL0ozSEI2ajFrOWxoVHdtVkwx?=
 =?utf-8?B?ZHNicDM1YUtmUCs3ckE2Yk9WTzlSaFcrNTY3N2M5S0Rya2I2cForeVhGN1Rr?=
 =?utf-8?B?WDJoa29nOSt6K0kvSVNObFBlSnNMMVl4RE5OSHljM2l4VmlkOVZCYk5vZUpv?=
 =?utf-8?B?L1pDVTVTaEhoWG1KTTZQaXVOaFcxUUFid0VFT0Rra3FmRlRrWWdxOUE3VkNo?=
 =?utf-8?B?U0VaOGQ2bTJnRWVheWpma2dlVzg4QVJjaUU4a1JjNVkwbjlPZlVEeHpVMDZh?=
 =?utf-8?B?R0xNaDNRODlqbkQrZDloMEtYc2g4azVOcDQ1am9rZlA1RlIrQXpDd3FrdTYx?=
 =?utf-8?B?WVNLczJvUEpyNVV4OVdxK2NlYTVseGJ4MGw1T2VZbmlPN21xTG9SdnVTUmJ5?=
 =?utf-8?B?Wm5yZk9ZSW5iWEZMVnZUSDBoU0lXMGRta1FJK1MzT3BIWXZSNXF5ckI0ZUh0?=
 =?utf-8?B?bXdiaC9WSURmQWl1M0lWS2NDWE9KVHdKRS9zb09CZk9hQkY1MC9rNFJTSEhp?=
 =?utf-8?B?bFVVOWVrNVdCTEV5SE1lMXJxVTNFWlVRa0MzMGNWOW1VOHBTZHZyei93S0ZG?=
 =?utf-8?B?UXZlcGZHR1Z0MmNpelRIUU81U0tXUU03QzRIZmgyTWhTTmdQckMyMVNqRDZQ?=
 =?utf-8?B?WXU0T1lNYWFSa1hpOHhjclJ5T3NzNCtpZ1ByUW9yVlk1VXprczVTRjNKSHYv?=
 =?utf-8?B?bWxCbjgrdGMzbWkydFUvNjRBS2FUOWZqM2VQMTVhb0xGNlI1OGhWQUt4QXVN?=
 =?utf-8?B?UHZhQU5XeFVUc3JmSWVjWEJBcitGZGN3ZjVUWkRLTW9JS1VBSmtQbmM2bXhZ?=
 =?utf-8?B?dFZvQlpydFRPWG1vVGVQTlN2U081K0p3QU5MYWFaaWRRWFAvblVXUnh4blRH?=
 =?utf-8?B?V094dmZLMkRKUnlGUTE1K0FpMUVLZGxUeUdLTXBtaTFnSmxDdC9rR0dPN3Jr?=
 =?utf-8?B?aWRtbzRaZmlzV2RCbEJtK203SnVGSEVFNmFVRXFEZWVuUFR1QXc0ajAxQ1dj?=
 =?utf-8?B?REJhcUN5MmRtYnBtVXlNbnNhOTNld1Y1WFBKUHpxdVZ3VW42UFE1NFBmUUQw?=
 =?utf-8?B?OS9HKzc4UGdBRVlrL2svTkhpcDRBMk9OV096MWRSZFNmdmVYMU1UWmtZaG84?=
 =?utf-8?B?RTJpZFNoRFB3TytkbXN4MWFSbFdjdzFDTmM1MFV1VUFHNE9IRVBweld3VTZh?=
 =?utf-8?B?YjZ5bVE1WU1pU09oYlUxZkNEYjc4YWdiUjVGZUh3NXVIdEMwaUJhMGU5Ni9s?=
 =?utf-8?B?anRJbHVxSmwyQ3plMzdzYzcvVWcxMi9ZeFNVcHlScXJpeGJ1bkh5Unl1OXh5?=
 =?utf-8?B?aThWZDFVbDZoMmdwWng5NlJUc3FSNnJOQlkzNG1oNjhPNWxQNWVXOXhPT1Zo?=
 =?utf-8?B?VTlqQXQ5ZUZHNGluemZEYm9XajZiZ1F5M0ZPbXRCQVhmdFdjTnJVSzFqdmpa?=
 =?utf-8?B?am5sWmlmZ2pIWHdXeEhybkFYM20zaHV3R0tmc3QrK2xYaWc1TlpDRVp4UWVr?=
 =?utf-8?B?YWlnYVFaSWI0a2JPVnJieGJRcTk0QlNUbVFMUkpYSTBrWCtRV3cvSnpGS3E3?=
 =?utf-8?Q?klcrs7VFNy8OFFoxIisAtzgbu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8040b3ef-0f92-4d9b-342f-08dc9b097860
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8478.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 02:40:15.7566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2g2IBCuqLr7GWZg0pxVPUrKPJbZcqk4c8fCxUekG+vK0saLO6Ou8/dnurBAs0hXQOqFzBWMdAiAcwUZmnUFb8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5827
X-OriginatorOrg: intel.com


On 2024/7/3 07:55, Huang, Kai wrote:
>> This happens to us maintainers at least once a week. Well, I don't want
>> that to happen in my tree anymore.
>>
>> So none of this text above still doesn't explain to me *why* this is
>> happening.
>>
>> Why do APs need to update acpi_mp_wake_mailbox?

Not AP needs to update acpi_mp_wake_mailbox, but BSP might need to
update it after the init stage.  In the encrypted guest CPU hot-plug
scenario, BSP memremap() the acpi_mp_wake_mailbox_paddr, and writes APIC
ID of APs, wakeup vector and the ACPI_MP_WAKE_COMMAND_WAKEUP command
into mailbox.  Firmware will listen on mailbox command address, and once
it receives the wakeup command, the CPU associated with the given apicid
will be booted.

We cannot assume that all APs will be brought up in the init stage.

> They don't need to if acpi_mp_wake_mailbox can be setup before smp_init()
> once for all.
> 
> But currently the setup of acpi_mp_wake_mailbox is done when the first AP is
> brought up because memremap() doesn't work in acpi_parse_mp_wake(), as
> mentioned in the changelog of this patch.
> 
> I also feel it's not ideal to setup acpi_mp_wake_mailbox when bringing up
> the first AP, so I provided my diff.  IIUC, if memremap() works for
> acpi_mp_wake_mailbox when bringing up the first AP, then it should also work
> in
> the early_initcall().

Besides the factor that whether memremap() is functional at the point in
the boot process, another reason I can think of is, if the intention is
just to work with BSP, then the remapping is a redundant step.
Especially in the kexec & kdump case, the capture kernel only needs
single CPU to work usually with the "maxcpus=1" option.

IMHO, the solution that postpone the remapping while really needs to
bring up APs is reasonable, just don't make acpi_mp_wake_mailbox
read-only.  The APs might be brought up later, might be never.


> 
>> Which patch is this fixing?
> It fiexes below commit AFAICT:
> 
>   24dd05da8c79 ("x86/apic: Mark acpi_mp_wake_* variables as
> __ro_after_init")
> 
> Which didn't consider 'maxvcpus=xx' case.
> 

Thanks a lot for checking this, Kai.

> 
> But I will leave to Kirill to confirm.

Best Regards,
Zhiquan

