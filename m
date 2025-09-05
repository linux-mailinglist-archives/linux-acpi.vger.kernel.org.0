Return-Path: <linux-acpi+bounces-16439-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A576B464A2
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 22:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33A661708C5
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 20:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198FE2C08D9;
	Fri,  5 Sep 2025 20:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MUG4lAWF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9363F2C0266
	for <linux-acpi@vger.kernel.org>; Fri,  5 Sep 2025 20:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757104590; cv=fail; b=Bg36bdyjzimobJMTFQ+iGwTHgGy5nv303K0s+22GUwNRosFVVLupGbisy6u4uclVXIl412+wdScBZ88ykx0tdnHLGWPnTk64y0vJtO+H9d9L9CsuZ8o1Rcry343nJeCXPAhOFxJ6SzyNJCBMwTmBGWAlZhM/Uu6QflbuY6L+fvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757104590; c=relaxed/simple;
	bh=tltVRW/SWZMYkTIphzXoDj8QpjmN31FUYLBj1522P1c=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r8vDGe/o9FDEG23KmL4/VNPi6GHjlmYso6W0JOjGPM7Ks7E9DA/uHTQDEnSnCP8Ijpca+gDIkYMLohyqJGH9HR18DIlhOplMrascqvkx3enlKdFY1hB5qQfvyWUyEaypYfhWO1JvrByqtWyvuRTSG4h9VoA4y9F4wPm+VDgrY70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MUG4lAWF; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757104588; x=1788640588;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=tltVRW/SWZMYkTIphzXoDj8QpjmN31FUYLBj1522P1c=;
  b=MUG4lAWFhpsKMbGck4NG3TQMi6JMeTDQ/gFBV5XzTMmKGO6NOW96pB0M
   TbH3ok10H766+DPwEQM9hdmzrdXnDfyzriufK2yEVol32i3MvzRpQpsBv
   2hDU00yyPUdxxUwNnxhb9qpKMSAfwtGa6/GR3T8pnXakep2u9mHv2cQ8k
   lwRO1gn3hQCFEOlBrTEGi9WsMcWl0XnXowUH+VbX2X+LvldpcSDzODN0r
   XdNjsp7cwqIe10x+3rjZn4ZW8+APSSQ5WkUYZT8s94HNv2anplpdbLGn2
   YwaOlX1+6ctITyMViiyTJkBmU5jmCmy+K+NS5htWd8gAuSuJ2Zg/d5at4
   g==;
X-CSE-ConnectionGUID: O+mN6j4rQJuRKUBgHeXf8Q==
X-CSE-MsgGUID: 0T4hU0jmQGOLP6qJLoUjTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="58672612"
X-IronPort-AV: E=Sophos;i="6.18,242,1751266800"; 
   d="scan'208";a="58672612"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 13:36:28 -0700
X-CSE-ConnectionGUID: ynGG5+nBRzebgFi1VJa/hA==
X-CSE-MsgGUID: Ufj1BvDkSQmD3boztfqMrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,242,1751266800"; 
   d="scan'208";a="171524888"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 13:36:28 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 13:36:26 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Sep 2025 13:36:26 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.89) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 13:36:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uwfGPM9754aU+DMsDUNAL+9xS8BXL1Upz9coXwpX/7bacsIRKguO3BB7G46jGcPtNBvNOOI9sWDQmwYO31Blt+hmmUkJLMRl6nVwqZvjbjBIwxF0e77fo7xRbPscKffGFxw20D5k7Jy40obB76PoGSrqUlTSRgbIx2mhr7rcgFuhA47q/p+znijbtheoMi/CErX9f51JHVx8AihVfoh1f9dhMrUxCx22bi7UYOxY2bxo4z2XDCTkQTFqEVy5HRLeXERXPrX2b7xDKmVxUqqUj4Rx1a/zcF2yiwXTqP9JNC4PLo+AIUczUU/728G8vho41aio4saiR4Gh9Olm/tAEiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tltVRW/SWZMYkTIphzXoDj8QpjmN31FUYLBj1522P1c=;
 b=n/BMhivqu71WUrOmUGG9KurF1Xt+XaieIjAIMUm8lryjernk55+sM9SUtP8f5DDsAUgqfMsnvqmkrzeEgVffVL8b4mH6jZxyEZXUjPiDmM50VzLNvwjimlC3/NGGnLCdZ35dAqgS4a/nVaMOQmHayQIEKxJv1nNZlKcm5oV32h8iGp8Mb9PyeDPXUFft9T4VTw0fLP1lARqInmZwJxI7SwX7wS0VRm6/j3W9i0zBROe4QSzhPeg1vOU4Lx6pq2iNgpCUYocBDrSfL4ssRuGqZkTcphQAqLMirVuMnUBuwARc5dM/4NlKwvEPwF+ViAfD08aKrKp1T0lYBLz/+T6q2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH7PR11MB8249.namprd11.prod.outlook.com (2603:10b6:510:1a7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Fri, 5 Sep
 2025 20:36:22 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.9094.015; Fri, 5 Sep 2025
 20:36:22 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "jane.chu@oracle.com" <jane.chu@oracle.com>, "Liam R. Howlett"
	<Liam.Howlett@oracle.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
	"surenb@google.com" <surenb@google.com>, "Anderson, Russ"
	<russ.anderson@hpe.com>, "rppt@kernel.org" <rppt@kernel.org>,
	"osalvador@suse.de" <osalvador@suse.de>, "nao.horiguchi@gmail.com"
	<nao.horiguchi@gmail.com>, "mhocko@suse.com" <mhocko@suse.com>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
	"linmiaohe@huawei.com" <linmiaohe@huawei.com>, "jiaqiyan@google.com"
	<jiaqiyan@google.com>, "david@redhat.com" <david@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "Meyer, Kyle" <kyle.meyer@hpe.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "vbabka@suse.cz" <vbabka@suse.cz>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Fan, Shawn"
	<shawn.fan@intel.com>
Subject: RE: PATCH v3 ACPI: APEI: GHES: Don't offline huge pages just because
 BIOS asked
Thread-Topic: PATCH v3 ACPI: APEI: GHES: Don't offline huge pages just because
 BIOS asked
Thread-Index: AQHcHpFNghz0HBmU602rHD1MDcKklLSE/FYAgAAC9JCAAAbvgIAABRKA
Date: Fri, 5 Sep 2025 20:36:22 +0000
Message-ID: <SJ1PR11MB60834C3A834440F8E883F5C3FC03A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250904155720.22149-1-tony.luck@intel.com>
 <brfqzhbipg35twgv22vnnotbv3t3grwh2dxugvtbgqduuhsvst@f7exibz7i7tk>
 <aLsHh70jI6BGHjaN@agluck-desk3>
 <bwu744g3qzbzylxvfgt7v4tnf2k2eosqbkg7alm6u5roa7j3bn@gmut2l5227kw>
 <aLspJ5Tpqp4qRDk2@agluck-desk3>
 <cf05bc8e-fc79-49e4-a90a-47e661b4ae69@oracle.com>
 <SJ1PR11MB60830CB47549119351B1DF73FC03A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <698d9758-a22d-4d70-8b56-54efcc453f2f@oracle.com>
In-Reply-To: <698d9758-a22d-4d70-8b56-54efcc453f2f@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH7PR11MB8249:EE_
x-ms-office365-filtering-correlation-id: c635edd6-efae-43f0-bc3e-08ddecbbe062
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NzYyYkVlakZIMHAydHV6eUIxSGxHZ3lYRUhobm9nSk1UQzdWRTBibTVNUkZG?=
 =?utf-8?B?eU5NWTlWYkVWYjVnRzUrSTh0RmNRYmRicjUycXV6V1lCdUZSaGo4MHJsL2xo?=
 =?utf-8?B?cHI2TzlidVpJRXZVTjROZUkzbEVPbnpkTUJaaDVsSkxZeFlQZkFOcFlmTmUy?=
 =?utf-8?B?a1c4VFJRR1d2TUlueVZUWjZyMXFoTGtYZHVPSnNuSkRFd3VPbFVzRCtlNG5y?=
 =?utf-8?B?aGRGNlgvMlo5VUdmaTFNdXY4UUVWNnRTV0VhU3NwQXl0WU9rMDhIOVFLcEdS?=
 =?utf-8?B?dnJUWmJxR2V6dndoQjdHM2tWR0M3Q1RINVRQYW1EU0lsWTBMaktGQ0RvT3hQ?=
 =?utf-8?B?YTZrOE1OS3RJbTcrRXBQeU9FTHFjWGswYktXOHdXOGtBZWRZOWxuaklXUC96?=
 =?utf-8?B?dzZmOE9nNDh6N21TbzV3OC9TZlVTUDU4M2ZXQUFkSDRrU0I0VnJPU0ZuRXpo?=
 =?utf-8?B?Sm0wSThvbU9yMmxrMkdZSStmOUVKVVhTa1JBaE5xZmhmaU1kazJCMFZDQytW?=
 =?utf-8?B?MlJ1YXZTV1hQb1pYd3JnZDU4aEorN3FzV0pqaUswalFXNWU5Uk5BTFVQRkU1?=
 =?utf-8?B?aUxwM2N0TFBkUUp2TDhUVUpCd1BJM2lsam5RU0U4NDlGN0s1cFN1dC9uUUxu?=
 =?utf-8?B?cW1rV2tsYTJkM0hVM0Z3VVB1T1dwdnR6R1h2OFpWc3pkeUU2TlVrS1pJa3o2?=
 =?utf-8?B?UVFJUDFyNnlBQ3g4ZndMM1J5M3VsckluQzJHTERGMFJ6eklwdkNtbjBRQllK?=
 =?utf-8?B?UHhxWkVSY2g3NjNoMjc3SnI2T2MyaTAyQ280RUpJNTFlSXFsVW1nNkJsKytD?=
 =?utf-8?B?Q25xOUM2YzJYdzN2WTZTWTRMQVRjQnJyaXF3ZEJiRjhhRjdGUWY4bGpWNVpC?=
 =?utf-8?B?MUpOU2l1Y1ArYUxIWUFVMmNJek1jVHVHME5tcDZKQnZoWXdUVldnMk9IbENV?=
 =?utf-8?B?a0J3RS9tb0I3WGhiY1pydGsrbXJQWmFlZ2hLamNNVFQzZGpCYm5wK0dQWTIz?=
 =?utf-8?B?YWxZQzlPYUtaL1FzMlNZbXNkUTFobzlnWW4reFJ2NVBPVTUxbU9ObzU2RFNv?=
 =?utf-8?B?UzQ0cmcrQVkxbC9KNE9PUGM2Vk12aXNTUWtoczZWVkwzeEZoMVZJTys3a3VV?=
 =?utf-8?B?c2g5NGl2aEJDK01FQ3ozL1BwNWdNcGtiR1ZCNG44c1BjRXM3b2E0VDV4bDRD?=
 =?utf-8?B?K1R0M0xGZTlpQjFhZTJ0bVM2TUh3em9TN1czN0RWZjBIanFmSklTZ2wxM3Fh?=
 =?utf-8?B?SGVSbVhuKzNUd05hbVdSaTArM09ZV1g4SzlaMTR2MjlMNUo1UDhEM2d2d0RF?=
 =?utf-8?B?Qm9GMVNVU1VwNm91Wnc3QXFwRlpEY0R3dEd1b05WVU9TUmljcjdCaVJrbFBQ?=
 =?utf-8?B?dGhyWkRKK0FxZ09jVDlFcDdNdFdmYmpHVXNkVE5Mb1hEYzN4S2RMTHYyaWZi?=
 =?utf-8?B?bmhmMHdlNGhkQmhBemMvRTExWmVISjd3bkFXcS9mL3l2RnZmWW9HbzlIajU0?=
 =?utf-8?B?TXdLbnFyYXZsZ0RUV2tEcFdTMjdFTGdKR1VycGFwRzJRdVFqdzl0YU9sMnFH?=
 =?utf-8?B?TXl1STdIRWE1eXQ4OFk5M1hzSjFyZk9XTnkycVVOSGFMSVI3OGJ1VzdJSDMy?=
 =?utf-8?B?ZTFDdmY4M3lMcmU0Y1ZjKzNKR0NZVVlpYjZHcTI1ZjIxLzRpUkw0dkNCV2Y5?=
 =?utf-8?B?UDE0R3YvME50ZW1abVFJMnRlR2FIOFN4Wm5UVmJjSnhXcFFPcVY3bERUYTdN?=
 =?utf-8?B?MFA3Q21qMlcxUXZqeDd6aVprczV6Q25OSWEva3piTUhaaXFGVGhJcTZ5OGlP?=
 =?utf-8?B?eFBBREZiZFNNT2tBbzhzdVdGazhERXdOTFNGU21GQXV0MUQ4a01kYzUwdG85?=
 =?utf-8?B?ZjJZZkJYYkJXMFo3QTdjemg1ZmFyNExNcjJlODVOWlJGODRlSytNQm81ZlJp?=
 =?utf-8?B?WjA4U1pDSXplempIdTh0WnFyTmtmMm5YejlJUy9vMUZDY094cGNNaTE0STRu?=
 =?utf-8?Q?SOUoSpqdNUXdrMZUkKcEAlRnzYIxjE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3hvNDVtKzhSRUJJYVlUbnl4WmJGS0U1ZUtDUVNWd2RtTjFSRjNac0pSS200?=
 =?utf-8?B?all6Lzg5eVR3Mk5vQ0tISVlMamtqcDVtVG5rbEdGbXYwb1crZnF6aFh6WTIv?=
 =?utf-8?B?cWNyK0krTDhndzVyVlU5WktxaS9nM1RDNFBKemlNcUh1WmE5a1cxSHh3ZW8r?=
 =?utf-8?B?T1lYMWRiSDc2WG9SQ2pGbTN4ZXhrUDcraHF3bXQrbkhTeGJxaXJIdGZJMGx5?=
 =?utf-8?B?MEZKc0p4ejNKK1h5NmhscEJGTG1JTkJZanhnY2FMaVlTcElxMmhiZGpnZTV5?=
 =?utf-8?B?N0FSbnpSempJcm9PcUZveUkxRjd0WVhQekl5NTNDREFlOE9tMFRJVEpVcHM4?=
 =?utf-8?B?NGdoaG1GY0FCeUpDcUlWaEQzK2RRTnBLS2lnNDZhNGhuVW8vaXhmd1hxcnlu?=
 =?utf-8?B?dnEwN2NnT1BYaE5SSjc1bzFmV2lwSDVMUXA3M1hFV0JPZXBvNzgyZ2syWm5l?=
 =?utf-8?B?dEcxbnJPQ2JiR2tuRXBJcHN4Ui9RVUNmYzZSSWFFNXppY1NKOElPL2JhNGp0?=
 =?utf-8?B?dE9pVjRueUtPdG9Hdm5nbzhKZ0dQZmxzTU5ZRzh4OUU2NFF6cEJpY0ZEOW53?=
 =?utf-8?B?M1VGdU0zVU8yZ0xQT0lOTGV0TE1Ldkw3Qm96b0FhZXZNV2U5K2ZKbFJ0VzBy?=
 =?utf-8?B?cHFYVEtKN2tQNTV2amYxeGc4UXZmNWZDWi9pN0JYQ2t5NjdmdFExT0dVSmtp?=
 =?utf-8?B?Z3JXaHFwanFyUVllbmxxelh5ZmNFZGdsWGZTVWhtZG4zaC9hbG1QQ0tURzla?=
 =?utf-8?B?bGh0TCt4TVNPdzUzS2dDaGExaVdlMXowaXB1K2VPTW5hYUVGbXNhcGpRYXZG?=
 =?utf-8?B?WEdRcUU4QjR2cEdXYjd2QmNMb24zenpKVDd1Ymx2d0R6ckhZYnJlcnRVbjJl?=
 =?utf-8?B?T1lxTzRueTF6NXl1R2dFL3g1eVNUd0NkTVNpNk5qZkdDYjdBOFRhWThkcXhQ?=
 =?utf-8?B?RFFQZ3d2N21yblFCV1djNW1SR2VtSTl0Wm91UW9kWEZKNVlKNEFhMHRvS2VZ?=
 =?utf-8?B?cmJjOEx2aE90SjJOcTc2YkEwbW5jMW5NNUVkOGhKTXk4c2w3eWwwcTg4UEJx?=
 =?utf-8?B?V3ErTkJMNTA0R3VNWnhEYUNObzhFMVorU0ZTVzdzNU84dCtkeDh6eXNOQlkw?=
 =?utf-8?B?dldWUlN6SkhvZU1HV0RQYll4NXhBT2N2UUgrMEticzhnTVZ1ME5seFdyTi9Y?=
 =?utf-8?B?L0I1Smljd1lvS1ZpSUhPZ1RwQXRtWFRPY1ZxNDVQVEt6aHNjMUs2Q0RmMnRP?=
 =?utf-8?B?ZHk1LzZ0ak5YNjc0V1ZBVDhua2x1bXlnYllYRTdZZUVJSE5jbWFYaEZBK21x?=
 =?utf-8?B?UkZSOEFMYXpNcVd1VnBuNFE1Mlg0MUp0L0JzVDFYWWlxUldrTENJUVYwRHVZ?=
 =?utf-8?B?bnloQXR4VDllc3VTQ1h5TlB2OFhwejFBckZkdVNZSk1tNTVDM21IZHJUYTBY?=
 =?utf-8?B?Q2luSEllbFB2Zk14Vlc4R2M5MTdoU1AxZmVWaC9MNWVXZFB1djlpM2d6TjVX?=
 =?utf-8?B?ZWc1cVNKUXNRQzdhOGNxWjhQRjEyc1NBWGppdk00Ri84ZmlrR1N2dFBNaW53?=
 =?utf-8?B?VzYzWlFaZVh6cDRTZ25PT2xWVU5PSnJuVWVUcTVnRTFnQ0w4c0tYY0lwRmlj?=
 =?utf-8?B?eTVXU20va1VQdFhPOTBoZzFOeUVMNWg0Tis4TkdXaURFbUcvMlZ5NzB0VUJn?=
 =?utf-8?B?VG5EQi9sOGVZbFVhV0E3WGIzc0EvdlpYVytHYnQwSjNWSzN4T05DaHdhRUNa?=
 =?utf-8?B?M3ZzZGVncitCU21qUEJ5TStQM0p4UXc1elFFc3YvVXhJWXk4MkFWTDdVSUU1?=
 =?utf-8?B?UUdTZExSaEcwTHlWTFRPZFNvbmU5R1dBc3M1TEI4LzdyaWtsMTR6a1VEZk56?=
 =?utf-8?B?Ym43ZVBnOWdmMFhwUzVoQlpKR0IyYnkralBCYmprVHg3OThOc1dmcGVCUGRq?=
 =?utf-8?B?Y0Ura1ljcDk5NWd5NDNRdWtRdnVCdHNiak5hbVZCcnQ2Yy9mL05JaGdKY3Fq?=
 =?utf-8?B?VHFtaEdGQUxHVE1SZFgwTlFPWElRY0EwY1dWb29GN3FFd1p3Z1V6NFBVSVpV?=
 =?utf-8?B?Y1lBdnVLUUtDVmlNWGZUNGhuMWdKb2hJUk9rdk05TGVHWVFJRW9nL04yYUdp?=
 =?utf-8?Q?JRMg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c635edd6-efae-43f0-bc3e-08ddecbbe062
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2025 20:36:22.3574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yDNzVwt5cvbYzt3Jii4SwROVZ9nxKVhMLDb0hrBQH1hZThRR8Npq4zj7j+GBOl4f+UuBaerhw5be+5FvNPdJxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8249
X-OriginatorOrg: intel.com

PiBCVFcsIGZvcmdvdCB0byBhc2sgYW5vdGhlciBxdWVzdGlvbi4NCj4gICAgICAgZ2hlc19kb19w
cm9jDQo+ICAgICAgICAgYm9vbCBzeW5jID0gaXNfaGVzdF9zeW5jX25vdGlmeShnaGVzKTsNCj4g
ICAgICAgICBbLi5dDQo+ICAgICAgICAgICAgICAgcXVldWVkID0gZ2hlc19oYW5kbGVfbWVtb3J5
X2ZhaWx1cmUoZ2RhdGEsIHNldiwgc3luYyk7DQo+ICAgICAgICAgWy4uXQ0KPiAgICAgICAgIGlm
IChzeW5jICYmICFxdWV1ZWQpIHsNCj4gICAgICAgICAgICAgZm9yY2Vfc2lnKFNJR0JVUyk7DQo+
IFRoZSBxdWVzdGlvbiBpcywgaW4gdGhlIENFIE1DRSBjYXNlLCAnc3luYycgaXMgbmV2ZXIgJ3Ry
dWUnIGJ5IGRlc2lnbiwNCj4gY29ycmVjdD8NCg0KSSdkIGNhbGwgaXQgYSBCSU9TIGJ1ZyBpZiBz
eW5jIChnaGVzLT5nZW5lcmljLT5ub3RpZnkudHlwZSA9PSBBQ1BJX0hFU1RfTk9USUZZX1NFQSkN
CndlcmUgc2V0IGZvciBhIGNvcnJlY3RlZCBlcnJvciBub3RpZmljYXRpb24uDQoNCkJ1dCB0aGlz
IHNlZW1zIHRvIGJlIGFuIEFSTSB0aGluZy4gQWxsIHRoZXNlIG5vdGlmaWNhdGlvbnMgb24geDg2
IGFyZSBhc3luYy4NCg0KLVRvbnkNCg==

