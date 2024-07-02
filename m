Return-Path: <linux-acpi+bounces-6733-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D51D3923D2E
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jul 2024 14:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 584051F23F82
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jul 2024 12:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368E515CD77;
	Tue,  2 Jul 2024 12:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ibWvELpK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AAA14D703;
	Tue,  2 Jul 2024 12:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719921945; cv=fail; b=JRVKseYcFcMrv5+8egOQSaUqIvqwq4J6g5YvxkPfGTcSfFJYfltnq63bWREo/8iurHtR+r+inqI3QSvvmbSJpwdbiq2gWbRTXXa1er+OVnIxDptsndt00Bpobbo1pg/nPt6TudU/Yf3DxK2Vx/aiP1DRmmiMCM4WRUtOE2wp4+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719921945; c=relaxed/simple;
	bh=JD8tllekNuPmjDcc+vfF3DzE9S3gZWtnGSCb2geDijs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jZBW8JuCnwdGI+GzFmF0CG4XNxHEfKlRP77efF2tBbXVLAAiHB12L37p03hT7yGgrq+clXxpvOqY90OzAtddBEXroHnqoCh0TiQSllpEMFvufrfYnXWKJJ4g3fcncuHHElO2yF0kWxNAT1vsxKzznzP2GYUwzlWYQPefCGBFfQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ibWvELpK; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719921943; x=1751457943;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JD8tllekNuPmjDcc+vfF3DzE9S3gZWtnGSCb2geDijs=;
  b=ibWvELpKEUPgedXH4npue+LJVBsRaVNYYAVO6ILU7sHLZH8WUnm4FKNt
   rtH9jPjEis7Vxo0n2PAkSpuP0tTfZ1uaGm7kgzqUV/b/5KD5wsjyaIXA+
   aCOcs6C4bNVsp6ZRLQDXYIodWRht9UqMJ9uC0lGMPMmrPwPpLU9hda47+
   AfTCNDdVR2Us0CMwFlMQZohR9hl4HoEep3Kt0qSQfchK3M1K/y1KVEBPb
   3idzdcqPn5hLPBEInvGNbXhlQzd8wlU4q1XxbzikOevkZUePIUuTFeDKx
   k3VAfljteOTL4jLrld53Uc1JpLkDNdcCt3mB7/mYdX7hvxc4wkYSGsGhx
   g==;
X-CSE-ConnectionGUID: CiLzGjrbRvCHjITuhh8JeQ==
X-CSE-MsgGUID: ATHnzQBATKSK24O0unvEIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="34631280"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="34631280"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 05:05:43 -0700
X-CSE-ConnectionGUID: QLma2y+ZS0qcNxfuojPEJQ==
X-CSE-MsgGUID: Q1Zj5OWiR5WE6RXfOQ8J4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="45885082"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Jul 2024 05:05:42 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 2 Jul 2024 05:05:41 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 2 Jul 2024 05:05:41 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 2 Jul 2024 05:05:41 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 05:05:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ojgdkpki33wA1yNNtCFID1p8fE2hlxhAa7jgNL2CaNgWllnuzku5H2+EQNnwSM0tHZEoG/CCL0wV+u5m1a3XXmjUmfnoHB69XVuz2UXsFwc3wbLY1Re6aQpbhSZ4SouC6p7Eyv7jMry0dZjZ/BEa7jRhYKAZ/9XipUh1f0LYPFvA1i8CcABT3PlNGlDy2MWtm9ru8eJszq6l361dqvM1hb3y6I63e9vKPnqo9f9vVK7vJL9Jq8JAPOTEBDJmbasIrShGKnvYwvXdL9Oz/fLb357m2skWxTQh2f3u1S7VKu/Ieqj1hVvha7IiQfmjfn5GgHl1QM/Cu6kktZHGyqgPrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JD8tllekNuPmjDcc+vfF3DzE9S3gZWtnGSCb2geDijs=;
 b=BzctDUDABQjWnGmsqc8BvNp4UY5KDu8h9L0hDwFkN/VNhyVgs9xl0YLNAW5q038o/gDNpgJb3iEMWBaLjpSGhbbJnFLLf7ixDP5bo4QClg7U7UaC1xwz4+ekzig4Ejv8ucnfXQ7/Fx7Kxl8PBn4Kw6873MNMmz89luVDFQfY5ny7BdACQUW8h92Z5YdFlJJ76a764JMHge6gb5F/SiTQPKH+3Qb8X5Nvzmg4Fz7EfK70LZb5CF5SKh/oSkOiw+qGljnJL/B0boXzJawoD5Uwy1ESss1/YCru0yEDd5Gisoo54FHhSaxhquDQ+ST2k4Mzjzy+KIHkcoPqPSWRkgN1IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DS0PR11MB8206.namprd11.prod.outlook.com (2603:10b6:8:166::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Tue, 2 Jul
 2024 12:05:38 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%5]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 12:05:38 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "tglx@linutronix.de" <tglx@linutronix.de>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, "Li,
 Zhiquan1" <zhiquan1.li@intel.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "hpa@zytor.com" <hpa@zytor.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v3] x86/acpi: fix panic while AP online later with kernel
 parameter maxcpus=1
Thread-Topic: [PATCH v3] x86/acpi: fix panic while AP online later with kernel
 parameter maxcpus=1
Thread-Index: AQHazBr927+PQYwpdEOLVZAzYp0A37HjWBIA
Date: Tue, 2 Jul 2024 12:05:38 +0000
Message-ID: <41ee5438e8059c299f5722e386cdc1457ddc16eb.camel@intel.com>
References: <20240702005800.622910-1-zhiquan1.li@intel.com>
In-Reply-To: <20240702005800.622910-1-zhiquan1.li@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DS0PR11MB8206:EE_
x-ms-office365-filtering-correlation-id: 131591bd-b8a3-497a-e7ed-08dc9a8f499f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cmNHTDdTb0gzODJvVmlaK1phVTlpVjVQRXN3RjV4b0xkQ1MxNWpSejdwS2xW?=
 =?utf-8?B?Qnh0dk92WEtHUkdzWWdFK2d5ZGF1a2k4SGxZcXFCNkZqdCtTVG81UUZSNWhp?=
 =?utf-8?B?MkxLeWRXZ3prclh6aitSN0dTbjNHWjQ1eWF3ZTBCYllUdlgzMUJ6RDRTMjQx?=
 =?utf-8?B?WUYxRzJEanlKWGkxVEc5TFRuWEdadzdlQ2VGK3RFNk14VDN1aXdjR2hUMkll?=
 =?utf-8?B?Yys1MTNiZHN1bStFVXoxT3gwVGsrQzQrTm91S3ZkYTY1c2lSMExSMmRUeVAv?=
 =?utf-8?B?bWFaWnBrdzgxTlg3bXIyelduS3M3SFFGRzNra3B4ZWhxN0xTQkJTVktMc205?=
 =?utf-8?B?OXdjNm1LVC9pcm9UWHdsNVdDU3YwZlFSZmlnaFZkc0RqRFF6OVhaQWVnV21X?=
 =?utf-8?B?bGhVa0ZXVmF5MHA3dGREYUxvcjlHNXJ0R3JSQzFDRFNOZngyVFgzY1NDQXhG?=
 =?utf-8?B?UlRaeTNMUmdDTVRUakRnK1N1OE82Z3R2Q1NmT1AvNGd0cjJ5bXRLT0dLZGtu?=
 =?utf-8?B?R1ZyQ0s4T0RlcHRTZGE4ckJRaFhpRDlZTkN6MUU3dEVVTllIcGxwLytFc0Ev?=
 =?utf-8?B?cnpKM0E4S2VrQ2x0VDV2YWlKRnk1RmRaY0NhY0V0VjgxSFp6V3lVZ3JCWHNP?=
 =?utf-8?B?VWwwazN5THR0cFBPTHB6c0k4Y1NtSjlrQXJsVnM5YzZjck9YNW02V3VvUXZv?=
 =?utf-8?B?MG95US9nYmVDVkdqUDV2TUdORUllb0JMT2tWakZvZXBBUEFHSjZXTEkwcnNr?=
 =?utf-8?B?UFh0ZmlwODd1MXZzWGs2RWhoYTFqM2c2NHk2d05NOW9LVzNrWHNrLzU2QlpO?=
 =?utf-8?B?WFJ4VXlZZGU2YTBib3VDbkpUNC91NVpnZTQxWVcxdUk4aGgyTVRGSUdhZ1k5?=
 =?utf-8?B?dWdTLzZJRUd3THpyRXVDNFBCK1Ryc0h5dGtQcFlWSEc1YlBVVnZyQ0h5bWpJ?=
 =?utf-8?B?dDZtOG5UZ0NsRnhIOHNsSjBOdTR2bE5aUlRtWWh1cmJCVlRNNEl6WHZXVWVQ?=
 =?utf-8?B?a3I1MXFvdkNRTFpXL3dKTFNHb2NvcUJMcDF0TjJDMlMwc2xQY1FtNzg3a0Qy?=
 =?utf-8?B?SU5GRE0rK2FrYXo1dDNlZTdaYkd6U1FDbStYcmNhS2h3c0NFZW9MUEhDdlRC?=
 =?utf-8?B?V0EyMzlZR3dsZVFtRU8zd1JEa3Q0SEt4azNZdFVKNk1LVjN5a1gwakx3OXlX?=
 =?utf-8?B?MUdzZkZtZnEwaGNvVzFnZFlvOEdHcnRxNW9ac2tHVVJJWkxJUDN2bWNkK3l6?=
 =?utf-8?B?MWtGcnRGeVZ6K1ZOZms4bEV0dWU4bGxXZG9MaHJ3amxZcFN5c284Q1NPNEc1?=
 =?utf-8?B?OG44dndlV0t5S0Nwa3NnWkRJNUo3dDZHaVc4MkZyL3doQTlLeGJQU1JabWJK?=
 =?utf-8?B?K2UwTkVpallTZzY4WTE5VWVWdVhZM1U0azhGNnJBV3lpbDhTN24rL0VxZDJH?=
 =?utf-8?B?emVQRDdSaE8zKy94Q2FZa09aWC96ZitOOFhQcExFdWI5dnd0MTIxWE1FTzJD?=
 =?utf-8?B?T1FjTys3cjhlNXYyWTYzVHNEYXhLOFUyZWZiTGV4K3VXUnRWZzA2YjdKKzlO?=
 =?utf-8?B?TjNyWndzSm9mYXZyazE1Q1NLeHVXNUp2bWxuNGRuWmorUndFdnI0TGZTTFhF?=
 =?utf-8?B?K1VDRjBlTmhLd1BkSkxJV0VzcldabXF6a0wwaGFjWThHc0hEZHpIS1kzdXlS?=
 =?utf-8?B?bUF4bC8vWWVMbCtnWWZhK3VSVTdrd0V4Qm1HYzhwMHRRc05ud1JSU2doallL?=
 =?utf-8?B?V0o2eUtiMGJlcHYwQ2tZaUJuUGVsMUUzOE5wTmRNdThaWDU2Y2JaeGhvYjVu?=
 =?utf-8?B?MlFVTFI3NVBxcmt6RjFIS1pvNTFrbDk4R2lNWUg0a3NwSHphY29mRWZIYi9s?=
 =?utf-8?B?eHVBTHZLcE0yenExUzJYdnBYdVJoS1Faay82d3NuTE83R0E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmQ3bDNUMTByQUV3dklMQnBpcHVvc3hNWWF0WUpMNXQ1MnVvQnFsMU1yWE5E?=
 =?utf-8?B?dlZuWEVML1RUbjZ6MXpOTzM1TU56Y1lvMTFycTd5TEw3dFAwL3pyWDRBSUFw?=
 =?utf-8?B?bkVWMGd2endEUGdvVVZIT2lLb3k2L2xzYUM2QUtwWTY4VlNYRDZYOEtObXpn?=
 =?utf-8?B?clplQ1d2WXo2SXRPL2h6VWVFUHh6ZEtpRVY5REZFd3plbEpyY1NuQkdtaDNx?=
 =?utf-8?B?R1BrUldQSkxlNnIxcThDT24rQXBFS3ZtMmFrdTdoRGhSVm9QeUdqMzM1a0ln?=
 =?utf-8?B?ZnZUODFMS2RvZ1pzN3R0QWl5QXhkYVFuSmUxNHorWmQyK05lR1ZMOHBYVzEv?=
 =?utf-8?B?ckt2a0dOdm5RT0IydVd1M0N5b0pkblJiWjJLeUVVQzU0V3hSazJmS3JlTHFX?=
 =?utf-8?B?VHlmRS9yb0s2S3k1L3lKdjJuNzRMQkVLZ3FyenlNQWs5ZmtOTEtsV0JCVTRo?=
 =?utf-8?B?U2tvQzBCZ0xxUUZJZXlFd2dTUzZxZ0NCellqYUpFTFI1S1B6aUpHbFp0cGlM?=
 =?utf-8?B?b2xJODU4R1ZOYlQybnR5a1ltdW0rR1luQXV0eklJakg1dGNrcjgxMldaeTlq?=
 =?utf-8?B?K09JV1l4U0JnUHVnZmsxaW9WTlJEd2Y5YnUzWlZFUlJKcmRJTmFyQU9zMTVk?=
 =?utf-8?B?Q1VBa3o1OVlyTzlPZ0MvVnJwUjJvQm5tWVI1RzNndTUxN1FSdTNGYzlwbUp0?=
 =?utf-8?B?Q001MTdaSmtSalhzSmhQZ2JTRTkrTTNZSTdEY0pJUjZrYjNtV01nelVQNEN5?=
 =?utf-8?B?Z1E4VHJ4ZlB5TlR0RXZFaGdETWJjOEV5WGVSWm5sdmpZY1NYRnJNS3cwd3hG?=
 =?utf-8?B?Skw4dVZrd3RlRjZlMUhPSDV3QThOMGJmK0dSLzJrVWR6czFKUFE0MHRrdnEw?=
 =?utf-8?B?aVh2T1NwcXBBaWJFYWNGUyt0SEd4bEUxRWVOSkJzOElZQXRUWmwrejgycGJ2?=
 =?utf-8?B?dDRrOXBzc0VCRjczY2p5MjlDYUVQVGUwOFoxQVRtK1ZkZmJKRkNqQTVST1My?=
 =?utf-8?B?bkthU0Rid3c3UWZ6U1IzVkVac05OeEQvSFh4U2VmaXFyVEl6TEtWNkhMeVBD?=
 =?utf-8?B?aXZybjlUMXhOelhBOE5RWjJhVHo5Y3hNQXF0cHlsR25FL0hJRjgwVGI4d01x?=
 =?utf-8?B?QXBiZGlBczdPNDhES1ZHZlVHRHZmd2pzQ0UybGJlWDFpS1ovRlZ0WjZvTG82?=
 =?utf-8?B?UkJ3K1J0Q1hOclpuWVprU1pBRWprSEdXVGp2KzNISjNucmoxaEhqcEViRExj?=
 =?utf-8?B?VjZrMHhvVjZINUtuZVVWazFHUS9UaW8vMG5JYmNHVWNtTmlMcTU3aEJUcHFX?=
 =?utf-8?B?cjVXcXJpY3lkVWticlh1RHhEbzJYWDJVOWtvVWhMWEV0NDNldnkrYTNGTTJz?=
 =?utf-8?B?R0JaMms5VEFMTzJFeGJvZEJTOUhreWN2RGNHWUF0NGFEZlJsYU9rZi80K0dj?=
 =?utf-8?B?VEtJMU4zVnFXWmx6Vk03TzZ6ZDYreWVVbUNWUHJoQmw1TmQ4b1JPazBXejly?=
 =?utf-8?B?d2JaVzg1OGlGdFVpcEFEcDB3SmhnV3hRbTYxTVJwM0FPNWxZdnJSbm8wcTdF?=
 =?utf-8?B?S3Q0TUhyVDRKK0pnSTNoY2RxQW9lM3A3QXZSSWhWUS9MVThPY3ltQ1ppclkw?=
 =?utf-8?B?eERiTzg1cGR6TjRrOWloTjRucDJWS2ZRclR0aUJuUUFJUGpEd01MYTF5bGNN?=
 =?utf-8?B?U05CR1B0TG1lRTFRaHVQV1ZmUHlmcWhLOVhrK2FXN1BJcStRSHlLL0RUbWZk?=
 =?utf-8?B?Y1QxdnlOaW00QlZSQldYMVlnL2gveWxJNkV6RmtDMEFRazNqWkdxZG5xY0pT?=
 =?utf-8?B?UnZFcXV1UW5PMTkyTzBKcmxxZTJlODlWb0pobWh1SzZzQXg3aW4yZUwrZ3pk?=
 =?utf-8?B?QWFGekR4enBOdWdwVHBPbTVxejdESHNRWGpvYWxzd1N0eXcvc1FIWmdRY3R3?=
 =?utf-8?B?WlJFKzM0NnJVSjd2WmpPLzJ2VVJWMDRsVHBiWWsweTRyUUhhVXd3UVlrZCti?=
 =?utf-8?B?dEpxS1VOQ0hnbkxmUGJjSkhBTUhNWDBvTlB5S1R6eW9aTTVmTWswbitnbWUz?=
 =?utf-8?B?YWRaMk00ZGxGZ1prUzh6amEzeVNaNTN6UDZ6MHFwODdVVnVTYWZhVGpVZnU3?=
 =?utf-8?Q?DlPhY0lduEja3tA7Sz/x1mUh3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D50D03B066F1AD4FACE8E7A85F88032A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 131591bd-b8a3-497a-e7ed-08dc9a8f499f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 12:05:38.5673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZQwoicwhrMBm52lva19VIp1naXI55LE8AlEeHiMEIGVP6aX6g84aLDitZxYkVm+BtzCR6SiCqQCqIzIhTr7VOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8206
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA3LTAyIGF0IDA4OjU4ICswODAwLCBaaGlxdWFuIExpIHdyb3RlOg0KPiBU
aGUgaXNzdWUgd2FzIGZvdW5kIG9uIHRoZSBwbGF0Zm9ybSB0aGF0IHVzaW5nICJNdWx0aXByb2Nl
c3NvciBXYWtldXANCj4gU3RydWN0dXJlIlsxXSB0byBzdGFydHVwIHNlY29uZGFyeSBDUFUsIHdo
aWNoIGlzIHVzdWFsbHkgdXNlZCBieQ0KPiBlbmNyeXB0ZWQgZ3Vlc3QuICBXaGVuIHJlc3RyaWN0
IGJvb3QgdGltZSBDUFUgdG8gMSB3aXRoIHRoZSBrZXJuZWwNCj4gcGFyYW1ldGVyICJtYXhjcHVz
PTEiIGFuZCBicmluZyBvdGhlciBDUFVzIG9ubGluZSBsYXRlciwgdGhlcmUgd2lsbCBiZQ0KPiBh
IGtlcm5lbCBwYW5pYy4NCj4gDQo+IFRoZSB2YXJpYWJsZSBhY3BpX21wX3dha2VfbWFpbGJveCwg
d2hpY2ggaG9sZHMgdGhlIHZpcnR1YWwgYWRkcmVzcyBvZg0KPiB0aGUgTVAgV2FrZXVwIFN0cnVj
dHVyZSBtYWlsYm94LCB3aWxsIGJlIHNldCBhcyByZWFkLW9ubHkgYWZ0ZXIgaW5pdC4NCj4gSWYg
dGhlIGZpcnN0IEFQIGdldHMgb25saW5lIGxhdGVyLCBhZnRlciBpbml0LCB0aGUgYXR0ZW1wdCB0
byB1cGRhdGUNCj4gdGhlIHZhcmlhYmxlIHJlc3VsdHMgaW4gcGFuaWMuDQo+IA0KPiBUaGUgbWVt
cmVtYXAoKSBjYWxsIHRoYXQgaW5pdGlhbGl6ZXMgdGhlIHZhcmlhYmxlIGNhbm5vdCBiZSBtb3Zl
ZCBpbnRvDQo+IGFjcGlfcGFyc2VfbXBfd2FrZSgpIGJlY2F1c2UgbWVtcmVtYXAoKSBpcyBub3Qg
ZnVuY3Rpb25hbCBhdCB0aGF0IHBvaW50DQo+IGluIHRoZSBib290IHByb2Nlc3MuDQo+IA0KPiBb
MV0gRGV0YWlscyBhYm91dCB0aGUgTVAgV2FrZXVwIHN0cnVjdHVyZSBjYW4gYmUgZm91bmQgaW4g
QUNQSSB2Ni40LCBpbg0KPiAgICAgdGhlICJNdWx0aXByb2Nlc3NvciBXYWtldXAgU3RydWN0dXJl
IiBzZWN0aW9uLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogWmhpcXVhbiBMaSA8emhpcXVhbjEubGlA
aW50ZWwuY29tPg0KPiBSZXZpZXdlZC1ieTogS2lyaWxsIEEuIFNodXRlbW92IDxraXJpbGwuc2h1
dGVtb3ZAbGludXguaW50ZWwuY29tPg0KDQpTZWVtcyB0aGlzIGNoYW5nZWxvZyBvbmx5IG1lbnRp
b25zIHRoZSBwcm9ibGVtLCBidXQgZG9lc24ndCBzYXkgaG93IHRvIGZpeDoNCg0KICBSZW1vdmUg
dGhlIF9fcm9fYWZ0ZXJfaW5pdCBhbm5vdGF0aW9uIG9mIGFjcGlfbXBfd2FrZV9tYWlsYm94IHRv
IGZpeC4NCg0KWy4uLl0NCg0KPiANCj4gIC8qIFZpcnR1YWwgYWRkcmVzcyBvZiB0aGUgTXVsdGlw
cm9jZXNzb3IgV2FrZXVwIFN0cnVjdHVyZSBtYWlsYm94ICovDQo+IC1zdGF0aWMgc3RydWN0IGFj
cGlfbWFkdF9tdWx0aXByb2Nfd2FrZXVwX21haWxib3ggKmFjcGlfbXBfd2FrZV9tYWlsYm94IF9f
cm9fYWZ0ZXJfaW5pdDsNCj4gK3N0YXRpYyBzdHJ1Y3QgYWNwaV9tYWR0X211bHRpcHJvY193YWtl
dXBfbWFpbGJveCAqYWNwaV9tcF93YWtlX21haWxib3g7DQo+ICANCj4gDQoNCkJ1dCBpZiBtZW1y
ZW1hcCgpIGlzbid0IGF2YWlsYWJsZSBpbiBhY3BpX3BhcnNlX21wX3dha2UoKSBpcyB0aGUgY29u
Y2VybiwgY291bGQNCndlIGNoYW5nZSB0byBkbyBpdCBiZWZvcmUgc21wX2luaXQoKSBidXQgYWZ0
ZXIgbWVtcmVtYXAoKSBpcyBhdmFpbGFibGU/DQoNCkUuZywgd2Ugc2hvdWxkIGJlIGFibGUgdG8g
dXNlIGVhcmx5X2luaXRjYWxsKCkgKG9ubHkgY29tcGlsZSB0ZXN0ZWQpOg0KDQpkaWZmIC0tZ2l0
IGEvYXJjaC94ODYva2VybmVsL2FjcGkvbWFkdF93YWtldXAuYw0KYi9hcmNoL3g4Ni9rZXJuZWwv
YWNwaS9tYWR0X3dha2V1cC5jDQppbmRleCA2Y2ZlNzYyYmUyOGIuLmNhMGFlYTA4MzJhYyAxMDA2
NDQNCi0tLSBhL2FyY2gveDg2L2tlcm5lbC9hY3BpL21hZHRfd2FrZXVwLmMNCisrKyBiL2FyY2gv
eDg2L2tlcm5lbC9hY3BpL21hZHRfd2FrZXVwLmMNCkBAIC0xNzYsMTggKzE3Niw2IEBAIHN0YXRp
YyBpbnQgYWNwaV93YWtldXBfY3B1KHUzMiBhcGljaWQsIHVuc2lnbmVkIGxvbmcNCnN0YXJ0X2lw
KQ0KICAgICAgICAgICAgICAgIHJldHVybiAtRU9QTk9UU1VQUDsNCiAgICAgICAgfQ0KIA0KLSAg
ICAgICAvKg0KLSAgICAgICAgKiBSZW1hcCBtYWlsYm94IG1lbW9yeSBvbmx5IGZvciB0aGUgZmly
c3QgY2FsbCB0byBhY3BpX3dha2V1cF9jcHUoKS4NCi0gICAgICAgICoNCi0gICAgICAgICogV2Fr
ZXVwIG9mIHNlY29uZGFyeSBDUFVzIGlzIGZ1bGx5IHNlcmlhbGl6ZWQgaW4gdGhlIGNvcmUgY29k
ZS4NCi0gICAgICAgICogTm8gbmVlZCB0byBwcm90ZWN0IGFjcGlfbXBfd2FrZV9tYWlsYm94IGZy
b20gY29uY3VycmVudCBhY2Nlc3Nlcy4NCi0gICAgICAgICovDQotICAgICAgIGlmICghYWNwaV9t
cF93YWtlX21haWxib3gpIHsNCi0gICAgICAgICAgICAgICBhY3BpX21wX3dha2VfbWFpbGJveCA9
IG1lbXJlbWFwKGFjcGlfbXBfd2FrZV9tYWlsYm94X3BhZGRyLA0KLSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZW9mKCphY3BpX21wX3dha2VfbWFpbGJv
eCksDQotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBNRU1S
RU1BUF9XQik7DQotICAgICAgIH0NCi0NCiAgICAgICAgLyoNCiAgICAgICAgICogTWFpbGJveCBt
ZW1vcnkgaXMgc2hhcmVkIGJldHdlZW4gdGhlIGZpcm13YXJlIGFuZCBPUy4gRmlybXdhcmUgd2ls
bA0KICAgICAgICAgKiBsaXN0ZW4gb24gbWFpbGJveCBjb21tYW5kIGFkZHJlc3MsIGFuZCBvbmNl
IGl0IHJlY2VpdmVzIHRoZSB3YWtldXANCkBAIC0yOTAsMyArMjc4LDI5IEBAIGludCBfX2luaXQg
YWNwaV9wYXJzZV9tcF93YWtlKHVuaW9uIGFjcGlfc3VidGFibGVfaGVhZGVycw0KKmhlYWRlciwN
CiANCiAgICAgICAgcmV0dXJuIDA7DQogfQ0KKw0KK3N0YXRpYyBpbnQgX19pbml0IGFjcGlfbXBf
d2FrZV9tYXBfbWFpbGJveCh2b2lkKQ0KK3sNCisgICAgICAgLyoNCisgICAgICAgICogTm90aGlu
ZyB0byBkbyBpZiB0aGUgIk11bHRpcHJvY2Vzc29yIFdha2V1cCBTdHJ1Y3R1cmUiIGlzDQorICAg
ICAgICAqIG5vdCBwcmVzZW50LiAgYWNwaV9tcF93YWtlX21haWxib3hfcGFkZHIgY291bGQgYWxz
byBiZSAwDQorICAgICAgICAqIGlmIHRoZSBrZXJuZWwgaXMgZnJvbSBrZXhlYy4NCisgICAgICAg
ICovDQorICAgICAgIGlmICghYWNwaV9tcF93YWtlX21haWxib3hfcGFkZHIpDQorICAgICAgICAg
ICAgICAgcmV0dXJuIDA7DQorDQorICAgICAgIC8qIG1lbXJlbWFwKCkgaXNuJ3QgYXZhaWxhYmxl
IGluIGFjcGlfcGFyc2VfbXBfd2FrZSgpICovDQorICAgICAgIGFjcGlfbXBfd2FrZV9tYWlsYm94
ID0gbWVtcmVtYXAoYWNwaV9tcF93YWtlX21haWxib3hfcGFkZHIsDQorICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZW9mKCphY3BpX21wX3dha2VfbWFpbGJveCksDQor
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTUVNUkVNQVBfV0IpOw0KKyAg
ICAgICAvKg0KKyAgICAgICAgKiBXaGVuIG1lbXJlbWFwKCkgZmFpbHMsIGNsZWFyIGFjcGlfbXBf
d2FrZV9tYWlsYm94X3BhZGRyDQorICAgICAgICAqIHRvIHByZXZlbnQgTlVMTCBkZXJlZmVyZW5j
ZSBvZiBhY3BpX21wX3dha2VfbWFpbGJveA0KKyAgICAgICAgKiB3aGVuIGJyaW5naW5nIHVwIHNl
Y29uZGFyeSBDUFVzLg0KKyAgICAgICAgKi8NCisgICAgICAgaWYgKFdBUk5fT04oIWFjcGlfbXBf
d2FrZV9tYWlsYm94KSkNCisgICAgICAgICAgICAgICBhY3BpX21wX3dha2VfbWFpbGJveF9wYWRk
ciA9IDA7DQorDQorICAgICAgIHJldHVybiAwOw0KK30NCitlYXJseV9pbml0Y2FsbChhY3BpX21w
X3dha2VfbWFwX21haWxib3gpOw0KDQoNCg==

