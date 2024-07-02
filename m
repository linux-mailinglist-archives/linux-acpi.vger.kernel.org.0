Return-Path: <linux-acpi+bounces-6749-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DFA924C71
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jul 2024 01:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 913F11F23364
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jul 2024 23:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56ABB17A5B8;
	Tue,  2 Jul 2024 23:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UPKDjoac"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC8E1DA32A;
	Tue,  2 Jul 2024 23:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719964532; cv=fail; b=GgWYcr0bHUpSE97SdW62CeHx/BcLmeO7mP9CJRnBhBxnkCoU5UbrmMJwl+xJb3ZstbnnW6RKuVDFqjrvdLSn4vPHk3e7Vz0g8bSL6hf2zw/CiLTHZbNHT0Px/qeSH9YESzUSER3gNIfpa1MbMmmFGeDR2Vi4bY7O0W8gve2m8Qw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719964532; c=relaxed/simple;
	bh=M06mWbD8R4E0eO5XNELT2ZgbqGEkMQ+3bPXaSxThBfY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RilRQpuZ5izt8y+8rNUupAraUyclH4cTfU9wo5UzT4heOHg1YsvYhjCmyTApXm6OTZQAXimX0TNKnMUracU/+3sqIVw2AC3v1x21q4G8Q1Ev7SqOjm8i+anUZbWpTOUeejECQhJQjdSIkJmtME2afGb9HrYqJItS97xG4Xo3z7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UPKDjoac; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719964530; x=1751500530;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=M06mWbD8R4E0eO5XNELT2ZgbqGEkMQ+3bPXaSxThBfY=;
  b=UPKDjoacicV8+q+uSBiZd/RMGVM373HxjVGOsQNAufLeKWkbxnFtrMfn
   1bbnIBYTat6e/YtZPa9t74breFLBv1EZtiycPzd/61DyWlpkBDv6DY9kH
   mMv/oo9tMdDwurnrB7j9FQ7zRwsCdnZzcNo+XJsAlRF2dRNOtAIFAEoMX
   tKsyK4+9CgMRXAHLQaIavSFUxsoTnL5nBN8jzQCFoWKynK+a0LBNKd9Qz
   WUvg3tVHYmvtfE37jgJBdo6/7v+ZyS+Y0qlBMPfM4VFS4AfdAZeDFhl5i
   luW8YLjARPW8eaLpaxfPnIkyaBDUdqmBekuL6H0G3LCdQTI6txM7aj4hN
   Q==;
X-CSE-ConnectionGUID: hAVn95XXSk2vvzN4Zqv0bA==
X-CSE-MsgGUID: oAGsFQ2SRdaZgZoZetL4cQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="17305996"
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="17305996"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 16:55:30 -0700
X-CSE-ConnectionGUID: JUaURUNWSFi+znUAv7y1zA==
X-CSE-MsgGUID: zyZNZXkoQgS6Bsbkzp4jmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="51021293"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Jul 2024 16:55:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 2 Jul 2024 16:55:28 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 2 Jul 2024 16:55:28 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 2 Jul 2024 16:55:28 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 16:55:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=etqRug9PWZnoa2ScXrVgbO0Bj66DezkMAsSiOq6xTapBqkcRxfWJMC2udV6VQ0+x7ONp1Z2T/ZLMu3jHFz5SAHGYQJP9rox82kWwvIV/HXDYQmnUqulQ9xKv7hecvWz9AJoFs61Rq+v66UxM/OFEd9lN6Rnm3teR41tn5Zzs/sO/SigyIqQ1Do5JuOthpKZ9Wv2/m23SJErR7G1AbIgXc2Y/9yJS7PtRmC/F4AhoxaHuvHGntPq99qd/aqeuMSKh/kIgi+hLyYs68BumdTU5KFZhd2b7I1ePABNBgSa38BA5WyTPkuzCTP3U4CAbm0ksFwlUXehIDN1rkxV4yPfW7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M06mWbD8R4E0eO5XNELT2ZgbqGEkMQ+3bPXaSxThBfY=;
 b=Ky23oVXA/na6yggT8Da5KqGu4p1RQgutcg2RP6azXm37G2VFlQ4L+dt5Op06hJGycS7+FQei35IK7ZNWybBq9Q7yTw5WlZBFLFssDdVTWIJytDuuSTj8O8U1G72Ncx0LfhB7KdB0vADLVmE/bWjstTN38AxgW0U+AqeERKcdebZ8SFqFGzATxOfHy/37496tJAy1xNSSPHH7tFDqNANKr/MBty41eiSLI8oYtqabGcl0tQIfcSPn+mhGB0dgvWQmAlLxxr8ipJKyxkr49H3BUf6K08G47HqlXWprTQO4+gdklVtqLNQbHUgSM7QSEB9la1x8YSBiYmXTmMNKd5arOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by BL3PR11MB6459.namprd11.prod.outlook.com (2603:10b6:208:3be::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Tue, 2 Jul
 2024 23:55:24 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%5]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 23:55:24 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "bp@alien8.de" <bp@alien8.de>
CC: "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Li, Zhiquan1" <zhiquan1.li@intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v3] x86/acpi: fix panic while AP online later with kernel
 parameter maxcpus=1
Thread-Topic: [PATCH v3] x86/acpi: fix panic while AP online later with kernel
 parameter maxcpus=1
Thread-Index: AQHazBr927+PQYwpdEOLVZAzYp0A37HjWBIAgAALIQCAALsvgA==
Date: Tue, 2 Jul 2024 23:55:24 +0000
Message-ID: <1b716b14c52a89c254108df1cee85306c786c52b.camel@intel.com>
References: <20240702005800.622910-1-zhiquan1.li@intel.com>
	 <41ee5438e8059c299f5722e386cdc1457ddc16eb.camel@intel.com>
	 <20240702124524.GEZoP2ZKcTcKl1ca1R@fat_crate.local>
In-Reply-To: <20240702124524.GEZoP2ZKcTcKl1ca1R@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|BL3PR11MB6459:EE_
x-ms-office365-filtering-correlation-id: c69e893a-ffa0-4b22-2374-08dc9af270ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?T3pFaWpRNVN5Z2ZYREN4VVFYVjFBWUJ2WnNiS0FhdzFTVE5wMFRrSlpuMktY?=
 =?utf-8?B?dk9qS2d1Z3UyZW9BOVZ0MzlwOGd3MGFyODZyQ0RoaGJ3cHEzOWk0TkNnVGhr?=
 =?utf-8?B?U25QTTJiMFRyQlZkOFdBeHJEcm9VNGxYblJRcFVlUHFnSkdZei83R1ViWXdJ?=
 =?utf-8?B?MHNBTGVrZDY2UFdkVGRmR3JLWUZRMDFSWlhCTjZIV29kcEpxTnowTUp6QVpO?=
 =?utf-8?B?ak0zYUNvTnhuTzhKOXdzdWd0ZXE1THBNMndsb0RLN01zMEdBeHhVNFBhYk5V?=
 =?utf-8?B?bm9yVGxFNENKSW5ZMWZBTCtlbi9LV1JJSmEzempQVFBXeUU2TmJPZVpQdGV5?=
 =?utf-8?B?OWo4ZVBrdlFoUFRzSFp4elVOdjdiOHp2SWxNbEplVVlrTWdZNVI5LzV5YURB?=
 =?utf-8?B?aTZNVG4rYVAzRkU0K21LYWY5WC9SOXZhS3hhYzRqZ0dkdDdUWE0wNU1uek1K?=
 =?utf-8?B?S3BqQ1B3dTl1V1E4WU80eHN1Z2xUbXZ1bFNPQ1MzNUc3TVpjblAxL29jL0tz?=
 =?utf-8?B?N3pUaDE0U2lweC9jMlA5V1ZKZS8xdUdkc0RET2drMGV4ekMzdzd5c3d6QnBh?=
 =?utf-8?B?WnNrTzhHSFMyUDd4SVovalRVbk8xYWgrbzVXZDRTdlA1S2tiNURZZEJwNjZM?=
 =?utf-8?B?dUsrbVlFVXU5N1VPc1lyUzhtcEtYSk9helRMRHVLTlBWOG13YUFkcUxIdDVX?=
 =?utf-8?B?VUFDL1plT1hpY2hUd2hranRVekR3Mm9IT3ZMRDdEQVhOWFRDZEhlQWlENzFy?=
 =?utf-8?B?MjNNRWxXZDlZMllJS2I5cWtQa0tlbDZyYXBsSkZTc01QMll1aWd2eWNjUkxU?=
 =?utf-8?B?YVFoZU8yYm1McGNvTUZleGhzenZMSkFoKytPYkhleC9FMlFCTjE4RUFXbDhJ?=
 =?utf-8?B?LzRFWmlqMThOUU1TSkpTdExHcDdNL1U5bFBSbkdmS0JBNm5sZmxCV05zWmw4?=
 =?utf-8?B?SUJicVUySzBoZStpempxb09LOC9sNEdZTnNpSlBBaEViTG1xdU5YemR1MGJZ?=
 =?utf-8?B?ZmcwQU1VT01NME15THFZeU5rMWVYV0w0VDYvV3lzeldTN0l5NlhxaHNodjdk?=
 =?utf-8?B?MjFCQXVtOHVLLzA0Q3REa1ljMDJWMWQvTW5xekZweElQOVF5WjJDay9lMzlx?=
 =?utf-8?B?eTZodS83YmtwRTJGVFA0QTg5QmFibTlTa3U3Tncybm0wUFNTd1JqMWZHbkZW?=
 =?utf-8?B?NTIvdVMvbUI1YUMwNG1kako3d2hkcXU2MklKVUtDZXRDdHJweG1vMmdQeXpX?=
 =?utf-8?B?dGJhc05vRmlJOUE3dWxOQmlScWF5QXZ2bkJMSVFpekg1MWx3M0IwRVBKeXNZ?=
 =?utf-8?B?TVFDNkNwb0lwNHRHTUZFQkIySlo4TjNoeGZNek1DS0NGcEwzdjFMdDk2S2RY?=
 =?utf-8?B?Tm8wMm84aGpPa0V0dGJnMkZ4M2pyUFlXMjY0Y2JKK21BNnFNTjh2SGN6NUk1?=
 =?utf-8?B?YmJlK0thcmtQbGVleUtWaTFDY1BIYVZHZ3Y5MnVNbjZ2K3BqckVFMWNlRVZP?=
 =?utf-8?B?M3czWTBEZ014ak9XdUEvTWh2N2N1WDlFQ0lSY1pqTDhKVW5uUllySFNQOFhx?=
 =?utf-8?B?R0pwUUdWcXkzaVNVS0V6dUQ2OGRDR2N6a1FXNCt5RVdRaWlHQ2VSVkxJKytM?=
 =?utf-8?B?NG9ZdXlpTE1KdFFwbDlrR1M3dG56ckVFekQrc09sMjFHT3JXelRmZDFFT09m?=
 =?utf-8?B?dmlUNURUQnNOd243WWx1UWNlQ3dnczBrVmU1bDV5d05TUml0WUZJK3YvVEVB?=
 =?utf-8?B?U0ZYS3pvejVlOG9OTm8zblo3SUJRZGQ0RjB1OW1uWnIraTBEMXZSM2pwL2xp?=
 =?utf-8?B?UVRVNDBwRXRTcjF1RHU0ejk1Wmo5bmErdW1ZbzZJUmJoVkNXdmh6amlOMlhF?=
 =?utf-8?B?Vjd5YlRWTEdOZ1hhbzB4RXhzck84MVFHc2h4N2pndTdQZkE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEFWNE5PU05UZjgvOHZFTzIxT3llRWpaRG0vRWpiUHNoL2d2TTVJazBkRFpB?=
 =?utf-8?B?Mi9kd0s2Si9IcTl4SURCa0xqTHFEa2ZHVmRhMFoyNFg0YUR0a2RQYldEcDRN?=
 =?utf-8?B?Mi9TaHp4VHkwUE9odzhBeGd5U1hkdG82cUNDRDV4dDRBdTN5RUxkeHdwYVgw?=
 =?utf-8?B?TlJlVTRQTFNZMWtNdkVvZFkwaUR3ZTZmZE43ZGVPeFJPYXhUVW0yRXp0cUJs?=
 =?utf-8?B?TjV3eWF5aGZzaWdKcTNwRXZDbU5wd3hZTXlvS2IydVp5TmdPOE5TQ0xrcG54?=
 =?utf-8?B?RVc2MjRtU1FVSEdSeFVVdVZ4eFE1QXBvVVBvZ016T3lNejR3aUxhK25HbXNH?=
 =?utf-8?B?Z2FjUE5LUFZTZm5SWnR1Ym1SYW1QcENlc1lUMmJXVHNsc0FzNC9KVit3SUpS?=
 =?utf-8?B?NlBTbkd3WHFXTERHcC9CTXRZZURZcUUrblkvSmk3aWlTdUZyZ1d5NlYydm5E?=
 =?utf-8?B?NlZBKzdWei9wUVJON0tFTUN0czRwVDYwZUVOZDZ6M0U1VzdNZ3ZyR3NHRHNM?=
 =?utf-8?B?S3p2ZjdtQ1BzSlhGL3Bmb1VQQXVPOVdmSS9ZdENmUGZPNmhpMjZBSzFpdHRZ?=
 =?utf-8?B?bGdGOENjdU93V1dnREVEUnJXNUV6L2ZUQVI0VUFKd2VmQXdlbCtlb3BDa3Js?=
 =?utf-8?B?NndGanRMZ1QybE5QSFVOdS96UmtNdDN4Q0cxLytsWHJ3VkF5UG5TNitJQzZK?=
 =?utf-8?B?UHIrQ1JXNmtSbGkySnYzRjRHYzhhZ3NFZTcwMUJXMVVmNEErbERyUnVXOEt2?=
 =?utf-8?B?blRicVdHaHFXakw5UEZYcE1BdWNzcGFsWU5hZ20zQXR5emMyL2RnK2lGRFhW?=
 =?utf-8?B?bTNJenlpZzNxMVBZWHlWdUF5d1VYeXBYQWUxWlF6aUs1U21GNWsvZ1JPbmV4?=
 =?utf-8?B?NTBhZ2s1VzRTc1hibXlYVDFqRU5PWXFsV2hlQkhtNGFaTmE3TjNoUUFidXc4?=
 =?utf-8?B?WW5Lelh1cFNQcFRvaXFLc2JvTHN6Vllod3dsVUYvZG1weEJtVXhrdVZYZ2J6?=
 =?utf-8?B?NkpsWFN6d1F2UzRzYURMUEx2MHNZbkx0Y0hOWWVlTjJQZGk0ZmV1ZjJIYzlx?=
 =?utf-8?B?WjVaWGgvVWRDMlE5UzBYVzVWL3pxT3V4bnVmTVZ1d0VOWkR3VVJqRmxEMEFD?=
 =?utf-8?B?MHNrTE9qZjBNdFM3MTZpdnhLR0gxOGU0OVF5eGhVdE4vSkFVcDVDcExuVEFt?=
 =?utf-8?B?MU01RDZFU2hZTHFsTmVMSE9Yb2I2bVVIRmUyR1VNU2gwUlJXQitFcXkzck5R?=
 =?utf-8?B?S3cvdHhaKzl6UnJzSEF2aVhKWjB5U1dIOUlZeW1sZ3JrMGhnNXhYTDNGVm1V?=
 =?utf-8?B?d3kvN0pPM1piSGJCR1FjL0wvZnZrQ1BoTHQ4cEJlQnRvdFZFTWd0NHhsLzNL?=
 =?utf-8?B?dFBnR0xEbGo2MzZPWWFEd3doQmx2ZmRlVFRQU0J5OGtubGpvbnJhb0pheDBD?=
 =?utf-8?B?a1h5UktPdFVaNDJGang4eE5KdUludjV5dyt4cGxaclFEdHk5VW1KZk80NkNz?=
 =?utf-8?B?ay9nQ0FxempMU3l4TFhaUTRPWitVdi92SFF4a1JVSW40WHRJeDdYa3V5VkNo?=
 =?utf-8?B?NnV6bldvQzEvdTlLVlJzSGM3b3pSTkN2bWRad2FMMlpRVFFqNnI2dDgwN04y?=
 =?utf-8?B?MDRLcmc0K2NPRysvK1I2ckpHbTAzVUkvT2VFU0UyUmlnSmFJU1JCRWxBVmQ1?=
 =?utf-8?B?YW11UWp3RkgwT0dneUxIcXMySUxZM0tyY2dBOVBROFJtYU5CVG1oa1lSdW9L?=
 =?utf-8?B?cTdhb2lJbTE3ZVN6TkZXWWF2WXVLZDhzTmkxTGhCckpzSkNNdk1iRVkwZ2Zr?=
 =?utf-8?B?VUpHb2o4OGx1M1k2R3htNkViUUU5eE9KSnlIN2dFUkRJR0ttTjFUSTBpMWRr?=
 =?utf-8?B?TVZ0eWoxRk1NZFhnVFFkMVAzV2wycmFZVDkyeXV5ek4xajRCOXhZaGdJcmlI?=
 =?utf-8?B?M2xLcnJTakc3d2RqT2l0b0hmU0xqNkQ1NmdwZ1Fka1hiWXZkaG1TQ1FiL0dT?=
 =?utf-8?B?MTRIY2sraUZuZTVKVktSeVB0eWl3aW9iMmlrWVlZd05pWUhyNEdremtZWDB3?=
 =?utf-8?B?NklERUFBQnFLL1RPTHRnT1ZYYXNjZE9oVE9NUkJpbW52VGcxNDRyNW9rdTFa?=
 =?utf-8?Q?OBzHMR5lfbmFH9pVCQmrSlN87?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F868F45A1CE4B240B49D0B48E6E32D9B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c69e893a-ffa0-4b22-2374-08dc9af270ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 23:55:24.8243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZjYv/CEAPrDLiyPl4iRmyCBiINAPo8sciTneD2jga4IfTVpnZc77syUC57CYajGfu/Ximgjos8AgfHxWdD0Crg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6459
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA3LTAyIGF0IDE0OjQ1ICswMjAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIFR1ZSwgSnVsIDAyLCAyMDI0IGF0IDEyOjA1OjM4UE0gKzAwMDAsIEh1YW5nLCBLYWkg
d3JvdGU6DQo+ID4gT24gVHVlLCAyMDI0LTA3LTAyIGF0IDA4OjU4ICswODAwLCBaaGlxdWFuIExp
IHdyb3RlOg0KPiA+ID4gVGhlIGlzc3VlIHdhcyBmb3VuZCBvbiB0aGUgcGxhdGZvcm0gdGhhdCB1
c2luZyAiTXVsdGlwcm9jZXNzb3IgV2FrZXVwDQo+ID4gPiBTdHJ1Y3R1cmUiWzFdIHRvIHN0YXJ0
dXAgc2Vjb25kYXJ5IENQVSwgd2hpY2ggaXMgdXN1YWxseSB1c2VkIGJ5DQo+ID4gPiBlbmNyeXB0
ZWQgZ3Vlc3QuICBXaGVuIHJlc3RyaWN0IGJvb3QgdGltZSBDUFUgdG8gMSB3aXRoIHRoZSBrZXJu
ZWwNCj4gPiA+IHBhcmFtZXRlciAibWF4Y3B1cz0xIiBhbmQgYnJpbmcgb3RoZXIgQ1BVcyBvbmxp
bmUgbGF0ZXIsIHRoZXJlIHdpbGwgYmUNCj4gPiA+IGEga2VybmVsIHBhbmljLg0KPiA+ID4gDQo+
ID4gPiBUaGUgdmFyaWFibGUgYWNwaV9tcF93YWtlX21haWxib3gsIHdoaWNoIGhvbGRzIHRoZSB2
aXJ0dWFsIGFkZHJlc3Mgb2YNCj4gPiA+IHRoZSBNUCBXYWtldXAgU3RydWN0dXJlIG1haWxib3gs
IHdpbGwgYmUgc2V0IGFzIHJlYWQtb25seSBhZnRlciBpbml0Lg0KPiA+ID4gSWYgdGhlIGZpcnN0
IEFQIGdldHMgb25saW5lIGxhdGVyLCBhZnRlciBpbml0LCB0aGUgYXR0ZW1wdCB0byB1cGRhdGUN
Cj4gPiA+IHRoZSB2YXJpYWJsZSByZXN1bHRzIGluIHBhbmljLg0KPiA+ID4gDQo+ID4gPiBUaGUg
bWVtcmVtYXAoKSBjYWxsIHRoYXQgaW5pdGlhbGl6ZXMgdGhlIHZhcmlhYmxlIGNhbm5vdCBiZSBt
b3ZlZCBpbnRvDQo+ID4gPiBhY3BpX3BhcnNlX21wX3dha2UoKSBiZWNhdXNlIG1lbXJlbWFwKCkg
aXMgbm90IGZ1bmN0aW9uYWwgYXQgdGhhdCBwb2ludA0KPiA+ID4gaW4gdGhlIGJvb3QgcHJvY2Vz
cy4NCj4gPiA+IA0KPiA+ID4gWzFdIERldGFpbHMgYWJvdXQgdGhlIE1QIFdha2V1cCBzdHJ1Y3R1
cmUgY2FuIGJlIGZvdW5kIGluIEFDUEkgdjYuNCwgaW4NCj4gPiA+ICAgICB0aGUgIk11bHRpcHJv
Y2Vzc29yIFdha2V1cCBTdHJ1Y3R1cmUiIHNlY3Rpb24uDQo+ID4gPiANCj4gPiA+IFNpZ25lZC1v
ZmYtYnk6IFpoaXF1YW4gTGkgPHpoaXF1YW4xLmxpQGludGVsLmNvbT4NCj4gPiA+IFJldmlld2Vk
LWJ5OiBLaXJpbGwgQS4gU2h1dGVtb3YgPGtpcmlsbC5zaHV0ZW1vdkBsaW51eC5pbnRlbC5jb20+
DQo+ID4gDQo+ID4gU2VlbXMgdGhpcyBjaGFuZ2Vsb2cgb25seSBtZW50aW9ucyB0aGUgcHJvYmxl
bSwgYnV0IGRvZXNuJ3Qgc2F5IGhvdyB0byBmaXg6DQo+ID4gDQo+ID4gICBSZW1vdmUgdGhlIF9f
cm9fYWZ0ZXJfaW5pdCBhbm5vdGF0aW9uIG9mIGFjcGlfbXBfd2FrZV9tYWlsYm94IHRvIGZpeC4N
Cj4gDQo+IERvIG5vdCB0YWxrIGFib3V0ICp3aGF0KiB0aGUgcGF0Y2ggaXMgZG9pbmcgaW4gdGhl
IGNvbW1pdCBtZXNzYWdlIC0gdGhhdA0KPiBzaG91bGQgYmUgb2J2aW91cyBmcm9tIHRoZSBkaWZm
IGl0c2VsZi4gUmF0aGVyLCBjb25jZW50cmF0ZSBvbiB0aGUgKndoeSoNCj4gaXQgbmVlZHMgdG8g
YmUgZG9uZS4NCj4gDQo+IEltYWdpbmUgb25lIGZpbmUgZGF5IHlvdSdyZSBkb2luZyBnaXQgYXJj
aGVvbG9neSwgeW91IGZpbmQgdGhlIHBsYWNlIGluDQo+IHRoZSBjb2RlIGFib3V0IHdoaWNoIHlv
dSB3YW50IHRvIGZpbmQgb3V0IHdoeSBpdCB3YXMgY2hhbmdlZCB0aGUgd2F5IGl0IA0KPiBpcyBu
b3cuDQo+IA0KPiBZb3UgZG8gZ2l0IGFubm90YXRlIDxmaWxlbmFtZT4gLi4uIGZpbmQgdGhlIGxp
bmUsIHNlZSB0aGUgY29tbWl0IGlkIGFuZA0KPiB5b3UgZG86DQo+IA0KPiBnaXQgc2hvdyA8Y29t
bWl0IGlkPg0KPiANCj4gWW91IHJlYWQgdGhlIGNvbW1pdCBtZXNzYWdlIGFuZCB0aGVyZSdzIGp1
c3QgZ2liYmVyaXNoIGFuZCBub3RoaW5nJ3MNCj4gZXhwbGFpbmluZyAqd2h5KiB0aGF0IGNoYW5n
ZSB3YXMgZG9uZS4gQW5kIHlvdSBzdGFydCBzY3JhdGNoaW5nIHlvdXINCj4gaGVhZCwgdHJ5aW5n
IHRvIGZpZ3VyZSBvdXQgd2h5LiBCZWNhdXNlIHRoZSBkYW1uIGNvbW1pdCBtZXNzYWdlIGlzIHdv
cnRoDQo+IHNoKnQuDQoNClllYWggZnVsbHkgYWdyZWUuICBUaGFua3MgZm9yIHNheWluZyB0aGlz
IGFnYWluLg0KDQo+IA0KPiBUaGlzIGhhcHBlbnMgdG8gdXMgbWFpbnRhaW5lcnMgYXQgbGVhc3Qg
b25jZSBhIHdlZWsuIFdlbGwsIEkgZG9uJ3Qgd2FudA0KPiB0aGF0IHRvIGhhcHBlbiBpbiBteSB0
cmVlIGFueW1vcmUuDQo+IA0KPiBTbyBub25lIG9mIHRoaXMgdGV4dCBhYm92ZSBzdGlsbCBkb2Vz
bid0IGV4cGxhaW4gdG8gbWUgKndoeSogdGhpcyBpcw0KPiBoYXBwZW5pbmcuDQo+IA0KPiBXaHkg
ZG8gQVBzIG5lZWQgdG8gdXBkYXRlIGFjcGlfbXBfd2FrZV9tYWlsYm94Pw0KDQpUaGV5IGRvbid0
IG5lZWQgdG8gaWYgYWNwaV9tcF93YWtlX21haWxib3ggY2FuIGJlIHNldHVwIGJlZm9yZSBzbXBf
aW5pdCgpDQpvbmNlIGZvciBhbGwuDQoNCkJ1dCBjdXJyZW50bHkgdGhlIHNldHVwIG9mIGFjcGlf
bXBfd2FrZV9tYWlsYm94IGlzIGRvbmUgd2hlbiB0aGUgZmlyc3QgQVAgaXMNCmJyb3VnaHQgdXAg
YmVjYXVzZSBtZW1yZW1hcCgpIGRvZXNuJ3Qgd29yayBpbiBhY3BpX3BhcnNlX21wX3dha2UoKSwg
YXMNCm1lbnRpb25lZCBpbiB0aGUgY2hhbmdlbG9nIG9mIHRoaXMgcGF0Y2guDQoNCkkgYWxzbyBm
ZWVsIGl0J3Mgbm90IGlkZWFsIHRvIHNldHVwIGFjcGlfbXBfd2FrZV9tYWlsYm94IHdoZW4gYnJp
bmdpbmcgdXANCnRoZSBmaXJzdCBBUCwgc28gSSBwcm92aWRlZCBteSBkaWZmLiAgSUlVQywgaWYg
bWVtcmVtYXAoKSB3b3JrcyBmb3INCmFjcGlfbXBfd2FrZV9tYWlsYm94IHdoZW4gYnJpbmdpbmcg
dXAgdGhlIGZpcnN0IEFQLCB0aGVuIGl0IHNob3VsZCBhbHNvIHdvcmsNCmluDQp0aGUgZWFybHlf
aW5pdGNhbGwoKS4NCg0KPiANCj4gV2hpY2ggcGF0Y2ggaXMgdGhpcyBmaXhpbmc/DQoNCkl0IGZp
ZXhlcyBiZWxvdyBjb21taXQgQUZBSUNUOg0KDQogIDI0ZGQwNWRhOGM3OSAoIng4Ni9hcGljOiBN
YXJrIGFjcGlfbXBfd2FrZV8qIHZhcmlhYmxlcyBhcw0KX19yb19hZnRlcl9pbml0IikNCg0KV2hp
Y2ggZGlkbid0IGNvbnNpZGVyICdtYXh2Y3B1cz14eCcgY2FzZS4NCg0KDQpCdXQgSSB3aWxsIGxl
YXZlIHRvIEtpcmlsbCB0byBjb25maXJtLg0K

