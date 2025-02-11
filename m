Return-Path: <linux-acpi+bounces-11029-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 191EAA313B6
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 19:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1F483A209B
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 18:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286AE1E2847;
	Tue, 11 Feb 2025 18:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mG7XknV6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA37261567;
	Tue, 11 Feb 2025 18:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739297182; cv=fail; b=jMFOfrih6F0VZ/ttyOb14VdZQcdRNhg1B7Si6LgISdxCzZU1f5jfI88V9edKAExKshg4KKhSNWdOlVZXe60opHNMOFWbfQVZw4LED5yAt2qkqexB7lo7KKsFA/o6MgzPyV6+f6INgE4dvnkFVl/F4IGg6t2l5Pxfuydf0fZQ9is=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739297182; c=relaxed/simple;
	bh=apNEduZoILJdLdtq7XZyKL63Ju0QnvmMYXX4py0rixs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dIPZ1LXIo2vbLlhrvQ0SMDHl2MHPC1PMqIygEMBbyDkTAEGxMRM5Jkj10JUcpKMX0U7gPBtT4c61CHPASIPs+yVX8R4E3lhH5gW3d39Ll0H90uHdYymzgW6Owlucp/3HgUAStd+kjOgL9YNXMV+Gg/HExcxgLkgXmw6iQrO/NYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mG7XknV6; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739297180; x=1770833180;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=apNEduZoILJdLdtq7XZyKL63Ju0QnvmMYXX4py0rixs=;
  b=mG7XknV6IHbiFwA9AibPjArL/8000az4eMvdcRyxPlFL7T5Fvv3IBqK3
   UKT/upO79bIMIrAlOPrbBeU2CzUq2D9cfRUuLN9ZK03i8fcXTAaX0p/eN
   bkaZ5yfuJR/g7bbb1gKDB8DBfE/OIFTrY8NIeEDxSuUjpqPKmn1fqA2C/
   5/sWsa1IrkMttgf0KpWjMFphKnznn7YuNtwRIN2y0BlX2jqNVqiyOP5+e
   WQ7Mj5Fl5FInAoZecHuEe+7nHQzPxZXlYQS0iP68HEyNju4Cvom1yXQcD
   JDy/SihyVFaX4dYoThdNs/ZyvEct/SWqX2dfz4jkniJVbm+Z/f9dl9Nof
   Q==;
X-CSE-ConnectionGUID: ph/QE0SoTp6Hh/sE6EoEnw==
X-CSE-MsgGUID: x2hirPVAQiiccNev3YVaSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39166461"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="39166461"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 10:06:20 -0800
X-CSE-ConnectionGUID: iEt1BRMlRwWHNGpS+cAKgA==
X-CSE-MsgGUID: d82+Pk9lTYSMrr/+d5Ls3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="113225415"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Feb 2025 10:06:19 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 11 Feb 2025 10:06:18 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 11 Feb 2025 10:06:18 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Feb 2025 10:06:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yyV5nmsoxPx+fCnN3l2nXNoPoH9/7NW4kRjdM1aklM1tNwd/naGkGFFO8A4UgfbjcjcP4xK1k9+dAdscezq67kKz9BlW1uFMp1VnONARSx4oA83d5Zcvv1EpMrs7wGvLZ+CAP1zNWBtHt4EJ8keLLoUd/uxFdgTaXz7OLXF7r7pbpu/IZvhLGw9kN1ag1sreN/VBQ1uQyee4s8+KyJehJCTZyjmUPabFNarZa91edk28Cd2aNa4GSRd8bIicbYqt87K5wpysgKmMKg1LHJdZ2W+4P0Cqkcw5GRc2muPPzcQkfoxLMXPjMb06PjbzZQMAda5O/jiGyKe8pIa96ieUag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=apNEduZoILJdLdtq7XZyKL63Ju0QnvmMYXX4py0rixs=;
 b=KhAiIQhC2KnaREtihRAYGbBwrPCO+y0eVJfuQLGdVEAP9dRdStfzcPoFl3SlWYu4YnmptVs9YvBhBrnJ0jHraAE854eDBUQDxMMrRgaasC5J5+J7IKDeB2IltYVlc88k7cwDcaILcnRPOtZcq/cIWSv0gyo6r6Zs8v/nYnty1wF4NR/tD0eEXRnsp166hhH22UNK4o23hI7xeTwx1Z+m8fpOza1fedmsWkTpVu+kn+OMvU8kx/9J1tttvCbuq6ndALDdxng6waE9vg+z3odNAMJv+v47AKgD044jC4BmpJwSlkeNbe6uOjcZWCYbGvsmZQysGW0FcWj8n8wB60165w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SN7PR11MB7565.namprd11.prod.outlook.com (2603:10b6:806:344::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Tue, 11 Feb
 2025 18:05:46 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 18:05:46 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: David Hildenbrand <david@redhat.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: "Moore, Robert" <robert.moore@intel.com>, "Wysocki, Rafael J"
	<rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"acpica-devel@lists.linux.dev" <acpica-devel@lists.linux.dev>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "Oscar
 Salvador" <osalvador@suse.de>, Danilo Krummrich <dakr@kernel.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/4] ACPI/MRRM: Add "node" symlink to
 /sys/devices/system/memory/rangeX
Thread-Topic: [PATCH 3/4] ACPI/MRRM: Add "node" symlink to
 /sys/devices/system/memory/rangeX
Thread-Index: AQHbfACE0Yu2SiLzv0qtSfoPrdz0Y7NBqsKAgABurYCAAEh1IA==
Date: Tue, 11 Feb 2025 18:05:46 +0000
Message-ID: <SJ1PR11MB6083929661A91F9F60F7C8CBFCFD2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250210211223.6139-1-tony.luck@intel.com>
 <20250210211223.6139-4-tony.luck@intel.com>
 <2025021111-deepen-landing-4252@gregkh>
 <d19e60d7-8abb-4e46-8935-bc989b1d5d68@redhat.com>
In-Reply-To: <d19e60d7-8abb-4e46-8935-bc989b1d5d68@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SN7PR11MB7565:EE_
x-ms-office365-filtering-correlation-id: eaa80fe2-b743-4452-69bd-08dd4ac6b56b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZTJ4bUFGM1pmSkRLWmpya2IzUVgwb0xQWVRGaE9YaERkamZOcGc2WGdkS3dy?=
 =?utf-8?B?VlB6ZVZ6VWdsYjlpcXlsaGhFWS9Fbk5SY2VMYkVvanlxUGxWZnB3Q0VkUGFx?=
 =?utf-8?B?QlEzT3IzSElpVUtmK3oyNEVIa3JxZXZOTUU5S0tibnNmdmpTSnN6clRLZHUw?=
 =?utf-8?B?TnQ2VXNibGNSa29jTkgzd3lIMWptUVpueFd4Q1RkUEhjZ3F1YUlUc25nc08v?=
 =?utf-8?B?T05pSklsM24wWkJGbDdHV29wK0RYNVpDNzdLOFE3Y096T3ZxN1k2MTJXNkl3?=
 =?utf-8?B?Wnl5UDF4b0Q4L3ozT2tJZjB0TGVpb0pObnh4NXR4Ti9uUVRhN1JOU1NROWhy?=
 =?utf-8?B?VTYxa21hNFltNGlYUDhiVDBHcGRWcWJ6WUpKRkRWQndUWndVOVI4Nk80T0Qw?=
 =?utf-8?B?ZUF6MEpveG5POS9uKzIwMmorMVRYRGJ6T0ZLcFo4SFJ4ZUF3MithaUh4VDlD?=
 =?utf-8?B?Ymh6YURQWDBXajVIeXg1OFdPSk5uaXBlN1RxclE2b0lFUWt3UEg2dkhlY3lI?=
 =?utf-8?B?SHZxRTNjQjQ5Tk1oaHJmTjNGSDdGK2xJWVlLY3FRWkhPN2c4VnhtODV6NVcz?=
 =?utf-8?B?WGpSdXo1aXEzajYvdXFoNDFod1hzS21WTnJMQXRMSlg4Vk9yYVpoc29DdzZW?=
 =?utf-8?B?K2g4VGJOMytsN09PSEpEaGNpS3UvNTRQSzFwa0kvUjNkSkZhQ1NPZGY3Y0dM?=
 =?utf-8?B?WGoxdHJqdGlzdHVGbEZoTG1ZazlnVlhlZ0VOcHpaN2JQaEpEL2tFTE9DWGda?=
 =?utf-8?B?Y0R0Z1RvM3BCdmlXSE5RNFhxUmVhbUU5elNUQnFDeVNidUtIalBVS2tSSXNG?=
 =?utf-8?B?MWRoTHZPWWIwT0l1Z1NCTldZZ25zd2JTUWx5U2VXTzFiV2JTTU5hRC9GSVFw?=
 =?utf-8?B?THpFdVZsOWU1ejUvcXF3ZENSa3ZWZW55WFlYaGExQkZzZUdKWVZIajU5My9p?=
 =?utf-8?B?SzhOMVpQb1NHRG8wbTNjWTZya0FQM3hNNzFobFRNYU1mTkZpRzhkVnZtOHlt?=
 =?utf-8?B?Q2NnTkFBVXphNTJBWVA4Z0c5dXZJTDFsZVhUZ2VuZjY2Ymkyam5FbkhxWTdO?=
 =?utf-8?B?Z0Jwb0ZHNlM5VmMvZVc1ZTJhSnlzTjg2ZDhyVURYMUFrdlVkRHBpTDV4WXhN?=
 =?utf-8?B?Rndzb3EwK1l0UFJWY0tDeWdFZWVDSkF4NjJ0Zi8yKytaeWxDUUFZdzVHeVhu?=
 =?utf-8?B?UjBzVVVSSGllcWs1QXEvV3IrcVlqOWFBdXVBaWdUczVQOW45OWNURHFveCtT?=
 =?utf-8?B?RmUyd1lUV1lsMGFlUHZkaGVheGo3QzF3ZVhLQlUyemloa241dElKMjlmcCsx?=
 =?utf-8?B?ZTFSZjlWdGYwZStsL3p6NGZGeXIrUUNxK1hFdGFndXZtdGdEWWlRY2tCdU1q?=
 =?utf-8?B?a09tTWdqZVk0ZGViMGM3ZWpaMUJsaEtvOXpsdkNUd2Y2R0ZXOHEzSFdZRHRq?=
 =?utf-8?B?VG5WTEZMZUJxenltdExOMnl1dG1iVXE3MTliSkVOcnJjL3g2VThFN0VlK05G?=
 =?utf-8?B?YlI0WHdlMmh4UFNON3lDVi82UWxSSmFoM1BSR0xCSldVTVBUcXJpTUlVZ1Zu?=
 =?utf-8?B?RkQ2dmFPTGVBTWRyTWxZdUExUHpJTzZPS2daOXdlZVZmcmpITGgzTmk2SDFU?=
 =?utf-8?B?Q2VZT3MzUTcxV1FtdHl2K0dQMWhkQ1BucjVuTXZ3UDd3VmJzWW9YbEJYMnZC?=
 =?utf-8?B?WkVzeitmODlOZXBnSkZNbVdJdEMybGFKSXZERndXTkU4SHBzREVnQ0RRTFZ2?=
 =?utf-8?B?eHRhSXBFRnV5Rnhuc1NwQVdJN0xxNWtWR2VueXBhMWZHRmhmdlZEaGlUU2wy?=
 =?utf-8?B?YmZIQXNZRVVXbFdsSkh6Slo5RWFZeGxZSytBVVI2R0drNkFpQ0JCQW9MRGli?=
 =?utf-8?B?azJXN0UwLytJOVZyU3VReFVycXV5TTZhN0czQzB4UXJHUTVDcVJDbGY5ZmVE?=
 =?utf-8?Q?i/0Vy2TLuDruN9cEPN4mRA+jvUFmQW71?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bFNtbDBxUlhxZkpvY0dvYldGVHpuSzN6aEhxSXVLWUs0Y2dTb2RaVFV1L24z?=
 =?utf-8?B?a3N5TU9lVHc0ZDdTbWsvU1JvWGRpYUxMRFZMWVhja0pRN1A4VkcrZ3JHRUhq?=
 =?utf-8?B?Zk5EbmRjYk9WbzJka3dyOVZxSzhlQVBTU25aTHZzQmFVeXA2di9hSnVKNnl0?=
 =?utf-8?B?b2FscW5kQ2VnNGdjUlZWa2x1RjlyUU9FMG1KMDMzbUZST2ZhWU5tRGlTRnMv?=
 =?utf-8?B?Z0xyLzkvSVhnbjJQMlA4SlhTZmxVWTVNNGpmcGI0dkZKWHhMMW5LNDdkaFda?=
 =?utf-8?B?T0NidmpCZXpMalZwWm44R2tpSUdWQTZ0TURLTi9OanVyV3BqaWl5ZlE3N0hm?=
 =?utf-8?B?bG15UWVIUXFpbTNZNVIvMm1JakFNa1JwdWM2c0oyT1FxT3pubHBlalZvZVlj?=
 =?utf-8?B?RUxxMEY5cTNEZTFsMEpaRVRTV0VWaXRNWmFpYWlSbmFOS1pST2dOb2ozRWlU?=
 =?utf-8?B?d3RjMWRYNmNuMitDbHB3Z2pnTjZOOWVmUW5wR3kwMWxYNU52Q0Q3cTF3S25T?=
 =?utf-8?B?NWRNc0RvamNNU0ZFcXFKRHNubUtaeE5LNzY5ZlpZUzEwUW02SjdCUE50U3pm?=
 =?utf-8?B?MXdHTlVRckdnc3c2ODRjQ2d4cWZJbTlhVk01MHBOeURPeGdCbHNNR0hKRVNi?=
 =?utf-8?B?Q2lWNUVEYWcveEZSMldVVnlTeGxwZ0dWZ0MrZldNVm9hdHNhd1JLNUVFWks1?=
 =?utf-8?B?bkhpazM1eUFJanJxck5TOW8vdWNmS3Y1NXcyTnlBQzFqY3lYakJ5Y1ZOYXFO?=
 =?utf-8?B?K0pZbnNaWis5WXdtT1BWS0JTQ2tuWExuQ1B5VWg1T0YvSC9YcmxvZnNNMVg0?=
 =?utf-8?B?Y3dudVdCMXQ1MUNMSWNjTHhIL2g3dUk3WXZRY1NFbmk5ZFpjQXR5aHU5QU9p?=
 =?utf-8?B?R0tZei9iS0F5NURSU2krQXpLY1ZCZm03NExqcW9CVElIL1hkWGVvU0NCZThh?=
 =?utf-8?B?NDJkaFplY1crV0Q5OFNnNGFMYUY4NVpUQXd1eFI5Z3pzaTg1WXc1S1h0M1Iw?=
 =?utf-8?B?K1ExUVFTa29Ca2hxaWxiU0YxV2h3cVBNTnZLTU1zTi8vYThaa0xQMUhYT2xL?=
 =?utf-8?B?OVowRVNSdDVIMVZ1dGdaWUFPVGl6b2dITEZQeC81bXY1ZmN0VjUrVzdoRlA0?=
 =?utf-8?B?MXh1bnBMdEZZaExxMmJ0T091V25GWmNueUhkUldvckFidW1iKzlRd3Y5RG9s?=
 =?utf-8?B?Wm5jV1F2bldLbU5xNFliMHVPZ0N3ak93QWliTDh6MHpsYTZmbm5hamsrOS9L?=
 =?utf-8?B?R3ZlNmxDRGo0blRrazJ0djlQYXhSMDlMbHNaR0p3eUtxUlVzdXZZL0N6RHJr?=
 =?utf-8?B?MFo1R2cvVlhleitCRmdhamU0a0dpSmN4RkoxK3JGN29GNU9zbUhSdE1lZXJ3?=
 =?utf-8?B?d2NMWGJGRmRhNHRIY0I3YmljYmEwM0FOQlJRL2xCM1o4VWkrbWszTUZhWEM2?=
 =?utf-8?B?UjRlVXBhWm9udGdHR3poWEFwMXRWa0RkRnZmTU1RM0hNbjhaUEVxVXF6dFF0?=
 =?utf-8?B?VDNHRGQ5M2VGVHV4OXhnOVlUY3lGalRXanNsampkOWFZMWx3eHRmTDJyM2gw?=
 =?utf-8?B?ajhIRjlvOUdFQzVzdXhxbkRmT3hlNGlKU29VWEszVUZqOHB2V3VjVXVpN2RK?=
 =?utf-8?B?NFE5L0pnR016akNzN1IySFZ1SlRPbzVCbGo5REtPQkpRSzdGanZOUEsxeHN5?=
 =?utf-8?B?MTFKRTF1djJzd0dJQ0ZxTVVzYzBoS09tSkd2ekoxcnB2VTEyLy9DVkpqQWZU?=
 =?utf-8?B?Z0JQQTREMUxPS3hOV1NQNmE1OEsrOGpwSnBrZnI1Z0JpUjFIb2phOUNQWEJo?=
 =?utf-8?B?M1lVUHNDOWVBZmJNMTl5a3JDZ1phUjVkRWJiOW8xM3BrNVNBTzlNemxjU0wx?=
 =?utf-8?B?Q2t6UWJVdUNxM3FKaXY2Y2VUdkZNVElNdUg2SUwyWDJRRm9PRXU0eHB2Vnhj?=
 =?utf-8?B?d0lEL2hiQWFmdUo3bXlCd2NweGJ5U0VNT2Fvc0cxSkkyWmc1andwUGVpS05n?=
 =?utf-8?B?NXZpRmk5MkR4Y3hKNGpjdTNQRFM3QVhNK1B5NXR0b1g4UjZyUkdwYXFEVVc2?=
 =?utf-8?B?MW5Fd2grblFNUTVHL3FNcWVqejdzMjJSeExpeHpmMDdsY0pUaEpPWVdKdkRY?=
 =?utf-8?Q?V9pvGKC//0sDUTvCmtTFeLJMY?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaa80fe2-b743-4452-69bd-08dd4ac6b56b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2025 18:05:46.3880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wvrRCW9ejjgaa+sX0CNlwUgKI75N2hBJqW7I/hsZaXMsuMLBEl9+SbC6mcIuYIVPatkVqm3BmwBEKJrrm8DkDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7565
X-OriginatorOrg: intel.com

PiA+IFdoYXQgaXMgZ29pbmcgdG8gcmVtb3ZlIHRoaXMgc3ltbGluayBpZiB0aGUgbWVtb3J5IGdv
ZXMgYXdheT8gIE9yIGRvDQo+ID4gdGhlc2UgbmV2ZXIgZ2V0IHJlbW92ZWQ/DQo+ID4NCj4gPiBz
eW1saW5rcyBpbiBzeXNmcyBjcmVhdGVkIGxpa2UgdGhpcyBhbHdheXMgd29ycnkgbWUuICBXaGF0
IGlzIGdvaW5nIHRvDQo+ID4gdXNlIGl0Pw0KPg0KPiBPbiB0b3Agb2YgdGhhdCwgd2Ugc2VlbSB0
byBiZSBidWlsZGluZyBhIHNlcGFyYXRlIGhpZXJhcmNoeSBoZXJlLg0KPg0KPiAvc3lzL2Rldmlj
ZXMvc3lzdGVtL21lbW9yeS8gb3BlcmF0ZXMgaW4gbWVtb3J5IGJsb2NrIGdyYW51bGFyaXR5Lg0K
DQpXaGF0IGRlZmluZXMgdGhlIG1lbW9yeSBibG9ja3M/IEknZCBpbml0aWFsbHkgYXNzdW1lZCBz
b21lIGNvbm5lY3Rpb24NCnRvIHRoZSBBQ1BJIFNSQVQgdGFibGUuIEJ1dCBvbiBteSB0ZXN0IHN5
c3RlbSB0aGVyZSBhcmUgb25seSB0aHJlZQ0KZW50cmllcyBpbiBTUkFUIHRoYXQgZGVmaW5lIG5v
bi16ZXJvIHNpemVkIG1lbW9yeSBibG9ja3MgKHR3byBvbg0Kc29ja2V0L25vZGUgMCBhbmQgb25l
IG9uIHNvY2tldC9ub2RlIDEpLCB5ZXQgdGhlcmUgYXJlOg0KICAgIG1lbW9yeTAgLi4gbWVtb3J5
MzIgZGlyZWN0b3JpZXMNCmluIC9zeXMvZGV2aWNlcy9zeXN0ZW0vbWVtb3J5Lg0KDQpUaGUgcGh5
c19kZXZpY2UgYW5kIHBoeXNfaW5kZXggZmlsZXMgYXJlbid0IGhlbHBpbmcgbWUgZmlndXJlIG91
dA0Kd2hhdCBlYWNoIG9mIHRoZW0gbWVhbi4NCg0KPiAvc3lzL2RldmljZXMvc3lzdGVtL25vZGUv
bm9kZVgvIGxpbmtzIHRvIG1lbW9yeSBibG9ja3MgdGhhdCBiZWxvbmcgdG8gaXQuDQo+DQo+IFdo
eSBpcyB0aGUgbWVtb3J5LWJsb2NrIGdyYW51bGFyaXR5IGluc3VmZmljaWVudCwgYW5kIHdoeSBk
byB3ZSBoYXZlIHRvDQo+IHNxdWVlemUgaW4gYW5vdGhlciByYW5nZSBBUEkgaGVyZT8NCg0KSWYg
YW4gTVJSTSByYW5nZSBjb25zaXN0cyBvZiBzb21lIHNldCBvZiBtZW1vcnkgYmxvY2tzIChtYWtp
bmcNCnN1cmUgdGhhdCBubyBtZW1vcnkgYmxvY2sgc3BhbnMgYWNyb3NzIE1SUk0gcmFuZ2UgYm91
bmRhcmllcywNCnRoZW4gSSBjb3VsZCBhZGQgdGhlIHtsb2NhbCxyZW1vdGV9X3JlZ2lvbl9pZCBm
aWxlcyBpbnRvIHRoZSBtZW1vcnkNCmJsb2NrIGRpcmVjdG9yaWVzLg0KDQpUaGlzIGNvdWxkIHdv
cmsgbm93IHdoaWxlIHRoZSByZWdpb24gYXNzaWdubWVudHMgYXJlIGRvbmUgYnkgdGhlDQpCSU9T
LiBCdXQgaW4gdGhlIGZ1dHVyZSB3aGVuIE9TIGdldHMgdGhlIG9wcG9ydHVuaXR5IHRvIGNoYW5n
ZSB0aGVtDQppdCBtaWdodCBiZSB3ZWlyZCBpZiBhbiBNUlJNIHJhbmdlIGNvbnNpc3RzIG9mIG11
bHRpcGxlIG1lbW9yeQ0KYmxvY2sgcmFuZ2UsIHNpbmNlIHRoZSByZWdpb25faWRzIGluIGVhY2gg
YWxsIHVwZGF0ZSB0b2dldGhlci4NCg0KL3N5cy9kZXZpY2VzL3N5c3RlbS9tZW1vcnkgc2VlbWVk
IGxpa2UgYSBsb2dpY2FsIHBsYWNlIGZvcg0KbWVtb3J5IHJhbmdlcy4gQnV0IHNob3VsZCBJIGp1
bXAgdXAgYSBsZXZlbCBhbmQgbWFrZSBhIG5ldw0KL3N5cy9kZXZpY2VzL3N5c3RlbS9tZW1vcnlf
cmVnaW9ucyBkaXJlY3RvcnkgdG8gZXhwb3NlIHRoZXNlDQpyYW5nZXM/DQoNCi1Ub255DQo=

