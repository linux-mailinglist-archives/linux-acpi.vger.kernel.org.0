Return-Path: <linux-acpi+bounces-6668-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B29791BC7C
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Jun 2024 12:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E8AA1C23CA5
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Jun 2024 10:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1431553AA;
	Fri, 28 Jun 2024 10:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MxmjSlc2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8C1156237;
	Fri, 28 Jun 2024 10:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719569618; cv=fail; b=ReFYnZE06yxoiSq90vgVceW56Ibepx7G92/caB5GSnanwX/BsfM2JZJ9dBkqCqyEPm1miLdXWcfP5m6jAU4AgVw5WN38H2kQybF0EwSqSg9tGh2/fXrpWwp0P9U5M4rV/+IvWUDYOc3oKHS1hX5cTPKbcjqSlysYT5GQfXJZ9I0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719569618; c=relaxed/simple;
	bh=GkqHnHc4k6Lp6vlPdZWiww5WuvDoCF5qAbWvoBwodzg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kdD0oIPtsyh2WQThd+vNl1oQLzesXwZr4HROm0TTCf/HAxosskAm5bMsY58Ihgl9lL+vYldM/XTnPqnTGaElGwlMDYdmVxpIP5yE7DO7/szFp4c94Klj0ipsJ7cI/6oNm/YnQuIvYHryNDhV6AoekMDy7/HhjV+d7Q5Z/1eN/Fs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MxmjSlc2; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719569616; x=1751105616;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GkqHnHc4k6Lp6vlPdZWiww5WuvDoCF5qAbWvoBwodzg=;
  b=MxmjSlc2FIGcVeKOYDGEGkANfzLC81NYZz7Qx9RM8SuDhIBXaGbVQlWt
   7RKtenDVrOIqWY26rwMH5DME/Ba7HnxNZ3Nazr/hi6LJdH6eK51AIM4MY
   mQMp0kVFBolcDXz/yPdZuGv7W3UuduFLGlHYFCT3iAqSza5waVM+7Ejhr
   3ghY/AODktHOEHlXZrf3WsYjX4RO3gN7worw3PWsIT975VVAS8RaGHWWS
   fRi7D5Tcgh7tW0pOjplpxLiBTPDu+moSvNVaBk5QG6Hlq7IU24zBGVHpK
   dBfERMJgBawNy/YLCkBotQZtkEsZmsDGmmJ9nw8N0th1OH2K5myn4QRMA
   Q==;
X-CSE-ConnectionGUID: 6KqVPLNpSqappyyrk1DpoQ==
X-CSE-MsgGUID: UehP3JnTRJ6rS1oV2AyUwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="12298909"
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="12298909"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 03:13:35 -0700
X-CSE-ConnectionGUID: gqZo3rwARDq608coGvVODw==
X-CSE-MsgGUID: gp6/dqkPSCayTw1WDfbKyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="49297756"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jun 2024 03:13:36 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 28 Jun 2024 03:13:35 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 28 Jun 2024 03:13:35 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 28 Jun 2024 03:13:34 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 28 Jun 2024 03:13:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3jZewCo3TR4gWjdhu2kWukbsLAFeXJ3HkkHVL3q/vNDrIvE5Bi35xDkgN2ZmMH7pLjZzxoYl84LbWzAny8XM/0UR0tLr1W54VjpKN1OBiDK/1NSaCnL/Lccsfw9TvvUnNMFXx9N3v8+myEB/ulA8KTGAr51MCSusArFv6wgFTzb6GqggfN40Lday3Zqg/g+j9ZR/9MxDybCeSDiuP/MU4Qs6P2YvS7EgzKv+/tm2QafdBC2NJgnPXaDyOyHCLJVwUhs2JFXkZ1ju2fOPt9UpQKsAnsuIy5aPXW6rWFpOTbplyT3BNqzdvEQxq9EER09Ukba0u2+0F5UB2E6zYQk7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3g2+qnw0nzP4y6Je7sAxUbWtdKyq7Eaw/QsVl4irO2M=;
 b=Hpqra91ta8zn9ysq9P3WtfbLavWDLK5N4RE1EiNawmVa/XWu0caPr/1K05lOJlK60c2nIIs7YqH0cQbkAndgsK+XnqpS+SAeB91JQbkWe3sDMBBHjPhMVcQ2saWUkwMQWcUUDI/HXPoAkIF5y2zYC7b+RVTEliKDYtCENJFJvKZ3pXsLq8xLZd777ERQ+fRu/iQB49PkP0ZCvGjzHGBTF4iljkaeNKCg1anFmNpiiU3+1jbPP/WD/p06nleqdaCPxow5gMcr2CbsU1SIiQ0IyARlWaGdvCteIj0XIwbPkLugfwRkHsQDSklftAjglrnv4G6SkpwXSjZA1fZLTSwP5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB8478.namprd11.prod.outlook.com (2603:10b6:510:308::11)
 by PH8PR11MB6753.namprd11.prod.outlook.com (2603:10b6:510:1c8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.28; Fri, 28 Jun
 2024 10:13:27 +0000
Received: from PH7PR11MB8478.namprd11.prod.outlook.com
 ([fe80::6961:eda0:dc93:5b4d]) by PH7PR11MB8478.namprd11.prod.outlook.com
 ([fe80::6961:eda0:dc93:5b4d%6]) with mapi id 15.20.7698.033; Fri, 28 Jun 2024
 10:13:27 +0000
Message-ID: <2358acca-e6b2-4206-b49a-372ff3d352c5@intel.com>
Date: Fri, 28 Jun 2024 18:12:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/acpi: fix panic while AP online later with kernel
 parameter maxcpus=1
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <rafael@kernel.org>,
	<hpa@zytor.com>, <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240628082119.357735-1-zhiquan1.li@intel.com>
 <2lqydi2yuc5qlyasr6q7wrqq7b5jn6juc4bp7nehshcpxqmnzz@rcld4x7sc3bs>
From: Zhiquan Li <zhiquan1.li@intel.com>
Content-Language: en-US
In-Reply-To: <2lqydi2yuc5qlyasr6q7wrqq7b5jn6juc4bp7nehshcpxqmnzz@rcld4x7sc3bs>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0047.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::10) To PH7PR11MB8478.namprd11.prod.outlook.com
 (2603:10b6:510:308::11)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB8478:EE_|PH8PR11MB6753:EE_
X-MS-Office365-Filtering-Correlation-Id: bc8c0b37-2867-4a5d-391c-08dc975af395
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZVdXbnFSUVo3Y0NpK2Z6amxEQWJaRlZvNitPcW16Ym1meDlnMWdUVjFrQUgz?=
 =?utf-8?B?S2NUOHJjZUpaOHN3VFVRVTVBeEFySWZ6d0lCK25BZUc2TTlpbW1jTGdGYmw0?=
 =?utf-8?B?NjQwV09reTRzVzZFNDhTVEZULys4Zldla0xOcHBqVmpKMnJNcVFsWlM4NnZo?=
 =?utf-8?B?S3BxQmFndlU0ZVB0c1lYYm9Ia1RTdzUyYXJmYWhyNXl0ckc4eENTeUZMeHUx?=
 =?utf-8?B?VlZQRmVtSUN2WDUwZFpwZzkrSlFnaldaZHFLQ3Z6WXVwTEovNnRQVDUwbmYz?=
 =?utf-8?B?cTlYdEtQMkRnL2lDMm80NkpEREdMdjVNUmwyV3ZzTmkwUTVQeTZkek10VGtq?=
 =?utf-8?B?TjM3d1dpRmVtVFFvUHhWVFNKTXJ0QjJaa3ZhL3B4UU8vV2FXWWRsOTF1MXNS?=
 =?utf-8?B?MzIzV05USE5UV3RhSitCR1VzY0tldUVGT0U3cU5LTmNNaDBFdjFKclVPT3Fh?=
 =?utf-8?B?b3NPQW0vV0R1UnNZWWF2Ym9jY3dldmorYVU2UkkxUzBzbHV5OGRZSE1Zb29K?=
 =?utf-8?B?aXFjYndnVXUyN09SalFBaFdUTHl0d0Y1cjMzdG91S1R0bE1Yd1FyUXNnb3dz?=
 =?utf-8?B?T3VXbDNoTk56alVJSndmd0FpUWhadWtQNFhEWXkvV2pCV0JYYitzS3BXUWwx?=
 =?utf-8?B?K2tZSm1hc3RETjlPRWJOSmxTYkhhMFBRUC8xejRKa0FTVi94TW90bkU4b3Fk?=
 =?utf-8?B?MitUQmwxUE0yYWl1endGcEt1SUdIbE1OdXlnZU5KUzNibExxc0RNWFF4V2tr?=
 =?utf-8?B?RS9NZXI0b0pMYVdVYVhyZG1OUWJYL2MwTTQvckpZdDVQQUxreGVjS1c4eExm?=
 =?utf-8?B?V2VKV2djV2VSdjhSTU84K1dQelZ1U3V4NktwWGhYSTZ3SWFQZTZTeFJVc3or?=
 =?utf-8?B?K2pnYW1WQ1FKZ05IcHMyNHh2U1NnQVZMbUNoZmM4ajgvdmw4d3hlRWtYdXNO?=
 =?utf-8?B?MWxtblhnMjNKMm9ERU5pR3hPU0xTUm5kcWlFbVliN2w3SWJFZDVuVE80ZXVR?=
 =?utf-8?B?eFJrbG1ObVkvR2hFclp2VVNVbytMSWNBL0RSVUw1aW1UZEF6RXNWQWdBR1Mz?=
 =?utf-8?B?MVRDUnZHVEdFMkJacWlYdTFZWFlBaWxJLy9Kcm1LdFd4VzFtRHRWQzRjZmtE?=
 =?utf-8?B?Z1EwRWFoNFMraVpLOVlNNEYyTm1oNkdIZ2VlQkxtTW10SG1ZYmxyMTZacGFP?=
 =?utf-8?B?aE5YVUZFdGtpeEdLcVdLNTAvNVR4MDVEL21uZmF2WU5nSlU0QlN3ZUZseXp1?=
 =?utf-8?B?cVhHYWZBdzJtbDNBbnVEaFYzc2N0NVd6YmlSK00zMENpUkw3MXQ5MDFhWUx2?=
 =?utf-8?B?SXpTaEJpZGducCtTWjVtY0FEblJiUEt3bDdoSHVaQ3lmSjZvMFUweVFRTjg3?=
 =?utf-8?B?b2VtcU9IWXBOaDczb1RpUFRqc1VaTnBOOUpjZTUrQ2tmRTFlTU4rS3Q5bkZV?=
 =?utf-8?B?dCsrTU9La3N4cHZzU3Jibk90NXQrU0tnNFU1MEZkU1hmT2c0YUZSMW44cjdq?=
 =?utf-8?B?Q255cXZwMmc0YkNQalMwUkNtTmRjZkVpMEZLc21wVnUwbDNSNUNBNWVZeVFK?=
 =?utf-8?B?K2UyQSswT1cvUzlrejRTeWYyZ1NTUmtyRTNqZWw2Mko3cDc1RG9LcS9NUGV4?=
 =?utf-8?B?Q0RhVUNQRDd2b0Y4Z1lnYnVXSXpPenNjMUF6RG40Q043dDM4RENEa2NoSFcz?=
 =?utf-8?B?cTdFWkxuQW43Sjl1bkNWTmp4MVBkWTdja1lLaHc1OWFudlQ1YnJLS3Bpc20w?=
 =?utf-8?B?SXg1WEZIcThTN1JoeFdUQlh1OU9rMGFobFU3bTQzNml6VXp5eklScysxM0Vi?=
 =?utf-8?B?VFc4aVN1S2VrS0FWRXhDQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8478.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVRmNjdUenhzZ0dzMmV6US9YVWIyTU1YclY0bkJjVmhZRi9kckRhYTJLUzRn?=
 =?utf-8?B?OUUycHUwWW1zTnY2aUZyRWtYYWNtUmp1bVhmVHZiU251S1lKaXJEbUsrUWpa?=
 =?utf-8?B?QU1Uc1A0aE41ZnkrcEl4WlNTSWRmdjBLWDBNSkJHdHFpZGVkQyttUUZJa0FR?=
 =?utf-8?B?NWtaeTJWS2N5QVJaSWNJRUxFcE90SVFOOEJIeUdkWDBtN0Z0VTdQZjFLeFp3?=
 =?utf-8?B?S0U4eGkrQVQ5cUhmbnJFbmMvYnNYRXIxejV5VkFLN2ppTzdRdEtHMFdBY2hH?=
 =?utf-8?B?dDZsekRGTG12aUFpSGo3R1RmQlZzUUQ2M0dzd3hFZEJ3azZ6NHE1OUZhVGtr?=
 =?utf-8?B?R21wTUlkWWRCclR5cm1aR01VWmRROXk1YTYxMjVoM3dJeFFyNyt0TFo5MGN5?=
 =?utf-8?B?Y09hQ2RQTy9waVdYMGFVTmNZOTJaNGZTODhHK2M5N0Z0RWtBQkUwYThDbXov?=
 =?utf-8?B?V1Y5Qk55Q01FNnMrS2FIRjVleEhmR0hFa3ErcnNSalpDYWM1Z0lDN2xkSUJU?=
 =?utf-8?B?SmJtVEhyZnYxZXVHYzZ2Z2VyNWFvazFIUGFicHdnazlKUHh4OVJndUVHWkJx?=
 =?utf-8?B?MVNwbGpqdmk0bDRrcTJ2NnVvbTMyM2hUZldCQks1eWJydmJYQk9BSXlQell6?=
 =?utf-8?B?ZUZlblFtSHBLaEc3S1AyOVpCc2NkdlhuRHZNSHM4L3FOdjhFdUxmSkZxcXJa?=
 =?utf-8?B?SEJOcDlRbWxFMHFBRlZnTWY3WjFsZWU0R0ZlSlloSGU0M0NvNGJiN04xSHhK?=
 =?utf-8?B?YWJKVTZ3Z1BDVFJnV2FRRW5ycTFkb2p4cHhTWmVrUU9PcDV3NnM0bFRUSlkz?=
 =?utf-8?B?ZXBWZXVyL2FKT2huWmFSbTJjZGJXRVBZNnQ1Wk5DRUUxMkxKTWNBaVVLaVJt?=
 =?utf-8?B?aXFxaEJocXZEOGlCNTkyY3drZU1kTUs2a09vMmwzYU9QZ2FRNm9WVit0YjBH?=
 =?utf-8?B?aUJQMW5hOEIzejBoWWNOekt4dHljTHNCb2VFTFRMcHhPQ093U3JPS2RyclNS?=
 =?utf-8?B?U00wMDZFYjBtNDRudzNQUmNDVEJCSFowQWJHandGcnhYVlgyaXVteXFGL2lk?=
 =?utf-8?B?WGl1YnRDcjVPd01KVEFzYWgxNnd1Y01yd3FPU1NUNnhkREZtOXVWMFFiZUpT?=
 =?utf-8?B?UjNjY1YxRFh5WU1iL3BCNjVpSlVFUjIzRDFueEpqbGZNMS85dXhwN1RkT1lw?=
 =?utf-8?B?ejVIN0pQNDgyNFo1SjJEMStyNWROMm9SK1ZHdnZKRWE5UFFReWFvazZMR1NV?=
 =?utf-8?B?ZDhONzVOMWg4cjVidTRlaUx3Q0RIWVhIbnRXNmgwM1M1aXU2d1pZL2pyVnNJ?=
 =?utf-8?B?UWp4SEk2Ny85NEpYMldpdXM1UzlUQlFqMVg0ZWxBd3ZsRDdyWlNTODV3UWFi?=
 =?utf-8?B?aFpsdVFzODR5Z1BBSWUyZDhkaWVhbzdTT2FRNE16bC9INGNhWkFCa05RTjRZ?=
 =?utf-8?B?S05ySnYvNmpyVVVtaFBlQ3ozTDZ2L1NCREJtdjZCQVQxUTBITE5rRFJ4UFVS?=
 =?utf-8?B?NTcxMTVWOTJxbnphVGVWMUVtMDlkQUZyOHBKS1N0eVk2WGFkRjFkVUxMQmds?=
 =?utf-8?B?bjNzbExrSjZyVEhGdStlRkJMVHJkMnBkSlBGU0hmd0pVam1VMFdDYnV6aTI5?=
 =?utf-8?B?c3B1MlNSeGpnMWV3NmFmWG50aW5vcHhKcmN5cTlKZVMrSmNlSWtIdVFiU2RK?=
 =?utf-8?B?RTVUWmFyMlBVTVNKYlQ5R0tCT1BjTGxiOEZnck9xVjJGWTZMcmY0QzV0WHJu?=
 =?utf-8?B?RE40U3JaVWV1YkJkY0FFVzNKdnBoSG5qR1E0bW9Oa2R2MG14TlljeGVzNEk4?=
 =?utf-8?B?Vm5LN0tHQVFkMXgxY0htU2NacGVjMUJERXlFdEdrMmx1STdpcWN1YXA3WlNv?=
 =?utf-8?B?V0dDMEU5aUFUSWZoWDRWN3pNa3RNYjJaSVVFVmZUTWRkL3lxVUE0NGJiZXFD?=
 =?utf-8?B?R1dGbjVtTzlsM3NYTFIvalNqVzdtUSsxbmlBL2Z5NkVrT1FCMUpQWDBuOWJl?=
 =?utf-8?B?MmROTmpCYk5CcEhIdTAxMGE3ZHE5YmNMU3RaSGZpd0RGQ1lFcXZMSDhxa0ZW?=
 =?utf-8?B?d1ExK3lJNytkdzFadlEycUVvTVJvZnNKZHVoKzg2YTJmZFF1MWdQR2tDQjZ1?=
 =?utf-8?Q?x2h7cgROMAgMrBb7CYXc+Akxa?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bc8c0b37-2867-4a5d-391c-08dc975af395
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8478.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 10:13:27.2696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i/DI9go4iCKV9qs3u50U0KsKYWkih1tGHqj46GnZhALvPUqz2R43FcWIeDq6UZ0Ras0Am/31yGIjEKwIjl0n+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6753
X-OriginatorOrg: intel.com


On 2024/6/28 18:07, Kirill A. Shutemov wrote:
>   The memremap() call that initializes the variable cannot be moved into
>   acpi_parse_mp_wake() because memremap() is not functional at that point
>   in the boot process.
> 
> Otherwise looks good to me.
> 
> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Many thanks, Kirill.
I'll revise them into V3.

Best Regards,
Zhiquan

