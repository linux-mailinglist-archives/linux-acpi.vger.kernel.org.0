Return-Path: <linux-acpi+bounces-3760-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7465485CE89
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Feb 2024 04:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96A4E1C23686
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Feb 2024 03:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391792B9D7;
	Wed, 21 Feb 2024 03:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g9kHsCkF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCF12F36
	for <linux-acpi@vger.kernel.org>; Wed, 21 Feb 2024 03:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708484632; cv=fail; b=hjPAlsqufnplkRKE69pKOAkDQwze6YlHsBVkkLzecVVduvb3P5IF7KkrFtMxagOrBPoiehXJmJfrxei98YnXp1JLNVVPwt26qNjwmRpNE9/CENnQctL0XUSfCRimfvQp32q5IVGJXGnEmL8aCh5J+Qy3cfcYjLvpk2wWbLjH2K4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708484632; c=relaxed/simple;
	bh=p9YCPMyFM/34hPOfR9tO2ryCcTol4L2lBk2PG7pKtw4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZQqkBVPQWsOumg78wQABQW/K4DdQd0/lyAAY1Mp1JwjfnaCmdeSUTnMQ4XYI3SBkmbayfd73+E/dcNoPRpZZrxeWQ7lf6DoV74UgNovrewJqFj6IPfW3hL5Z2AdwDqObLiWt8E/99pBY5XrKoJocHanxqQCkdgI+Fildzy87oW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g9kHsCkF; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708484630; x=1740020630;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=p9YCPMyFM/34hPOfR9tO2ryCcTol4L2lBk2PG7pKtw4=;
  b=g9kHsCkF8j+IVMJeZNn/0mo7fSvJxepXEa8kISGYoBt6Urnqm94XJom6
   kPW6PWYz9aD3/Gkm1x5szzb7GwiIjpjLlc4rgd3Rn0T3CSI3N1wRHPdoQ
   NNSCkC6N4Y4SKEMZsJgUEuAPkkltyVVMOW5C2/GCfo3PW/Hnw7/pfmtYw
   tHoSK3oIytpWfnopWPhgTVVV7ct76+imWeg4lsM10rRyW/sNiY4sDEJXV
   lXMSmxFrLX9++UfohX3I4BqZc5D9na5SWV29yWptEF85vBvHH+nbln7Bp
   vkb0wvjmWksoIBTSEAes8hi5S/hwBqu0VPP6FJw+SPZokuRuGHTuVrZZT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2739189"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2739189"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 19:03:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="4889246"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 19:03:49 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 19:03:48 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 19:03:48 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 19:03:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2WMQLjEgYGO9aNiCuFQLiRYx8OyRczQw5yHEF4lfQBBOc1SApFRm6vnUHxpdB627tV3ed6vJ8+QEebmBWkKV8GidwmS5VkKb/RX43XS8BLimJx/zhcCwlI52qrlHhqzMIlssql/MU+QEY2OwREL9GdG168i5XiU631s3RxCs+2G0TVTB3ITp4fngZ78sSpEIrz7B1GLFavfVA8ubx/DGM8F2sNYLdAYn0gilTfvFuvUYkST3gtcmELnkuw81CYsSXY6o2b3zJPCnOhSa1WT2ToLHoqBLzIuSfUxtJVkGbxFTAM64h/T7moreUbz9igmIZlikuEmWRZkLshUqbP5zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9YCPMyFM/34hPOfR9tO2ryCcTol4L2lBk2PG7pKtw4=;
 b=bRVxLr8p8NNbV0xRFL5KWtOOSHPDCv6XlYBtyg5YrJbvqcTvGoIgy6VUaNBz9XkfAIQwArobGE6M3OFa8ttUuteekYH/DlpNpXOuVc9nH0p98xg0IH96C1x4Zv4ZvR4U8xceNS1ZHKno4uvpOhy8IM1g4VupiL1nQF7P1Mver3Py8vZzLE3KyDTMinqVK+8Xkt8OeWgRovVvCOL8h6eV9NavFSgRzYN54yRSX0+0Aq3FYTcy/lYUAy2PleUQG+Zwj8dapMUkOtRns8uw+hBbadlrZpOJ9a9k5bR96PYvG3khYnSltEn5WDvitqrrMQ3SgdgT6Vfbv/rfE2LfPTXyZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5808.namprd11.prod.outlook.com (2603:10b6:510:129::12)
 by SA2PR11MB4826.namprd11.prod.outlook.com (2603:10b6:806:11c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Wed, 21 Feb
 2024 03:03:47 +0000
Received: from PH0PR11MB5808.namprd11.prod.outlook.com
 ([fe80::53e1:ca40:13ff:a23a]) by PH0PR11MB5808.namprd11.prod.outlook.com
 ([fe80::53e1:ca40:13ff:a23a%7]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 03:03:47 +0000
From: "Wu, Wentong" <wentong.wu@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH] ACPI: scan: Defer enumeration of devices with a _DEP
 pointing to IVSC device
Thread-Topic: [PATCH] ACPI: scan: Defer enumeration of devices with a _DEP
 pointing to IVSC device
Thread-Index: AQHaWWFDVzlgIainkkGPsDjCeTjN6LEHBzIAgA0qzTA=
Date: Wed, 21 Feb 2024 03:03:46 +0000
Message-ID: <PH0PR11MB5808AF9BD11005CAEF4BE5988D572@PH0PR11MB5808.namprd11.prod.outlook.com>
References: <20240207005908.32598-1-wentong.wu@intel.com>
 <CAJZ5v0g+bQd_KyDDTGxR3BiN4WidfNi319qhuDzOT=NaDKZV=A@mail.gmail.com>
In-Reply-To: <CAJZ5v0g+bQd_KyDDTGxR3BiN4WidfNi319qhuDzOT=NaDKZV=A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5808:EE_|SA2PR11MB4826:EE_
x-ms-office365-filtering-correlation-id: a57b4321-2e4b-4eaf-2613-08dc3289b8a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9uKQ8LZeIs/aTG//ybrwbAlriaWJPNslSPbQdOpgaSHx4CfBRxIw5INHtlKqPk57QYCFvv8KNDmV4uNNhkJ6AfHFml286ZIzBUxIgg9VbGXrqVEujXpOpz/KImNCmnpdmg7HhW8p97SwFh5o+7ZO7tpgMF396jvLXgm+3+ALerdoht8I2c3kYzsn9bR5TPgiuCVwNoP7v7Dw+3Wlfn9myM2C4u0+Ihsa7j6GC7Nmn/VPO0FRglVhKkDvefmsRvreKWnE3v2Xh91CqVgZVg+P7abrNTDcWPqUvkdSyZDQBjmVx0U+LC4qvfSi3sNqyERkQ98nKRm9IKv6ytAh2r2bjY2/cTj83bcphO8VJ3ApUFHPG6/HfL1ydc/d3g573i03on27z6PJ0Q0Gwv1HQQ46Ss/zSWKE6dUG8I+OJojUPJzn/5GB1cZoyjDTXXwsm5CrkGl5qW2CifcmJwpJRPBGJ4fB30bhaWvtkvgDb8vuNXs4lT7GTfN5Ut1czdGRXEOeqfrzokm5OSbtCAql+1iE8DP2G3iF0ilbsSu9kvslbuDCmagwIDvhmQU4+p1CIFmZcmp0W+o0d3uW2XRZo2eoMApe1bQCZgifjQ3jHnX+rzuJM50KyG/SIn98t6P5Brqe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5808.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUlHWFM1RTE2NHMySUpBYi9ZaERyZGVGa3dNcVRKQWpsTTkzV1dWam5TWlBG?=
 =?utf-8?B?OStXbnVHTHdWNUJwYXF6TVRySDJYQmRPaWVoZVdld1Avb1BwTHlRQmxmWmo5?=
 =?utf-8?B?ZEd3ZnA5NkhtT1FDYzMyd0k5a2g1MHZKbEFKRWp5SjluTGlvRlpHR1dmV3RV?=
 =?utf-8?B?SFBHSmJlanZWdkQvYVlpVkhpVHBzWWZGODdkYW0xU2NwaFB2amJGOFBNTDNY?=
 =?utf-8?B?OEtqTW1KRGcxWDJENXNjcTlKN3M3MDFWQzhQclFRanlvQ0RGcnZBWGxYdE51?=
 =?utf-8?B?UXZXMEFqRm02SDVDOUFBaEhNOG1Damhqc1RucmlPSWV3eFdoOHM5YmhnUGNJ?=
 =?utf-8?B?VjVRTzdTeHdtVDk5b0ZnMWtOMFlwU2dGUWlBaFdmVm9wVGh0dnUvRm9LV1NP?=
 =?utf-8?B?UVNoUjZDQ0toUW95L0N4RUR5NjBjMXkyMWNTaFdmcEhuNWNlQXFhRVZXS2Jz?=
 =?utf-8?B?elc4M2Z6Y2JRYnhLQWtJRXhwQ2ZkSWU3UEJ0bEIxQ1hFZUNJQnV1emkydHRx?=
 =?utf-8?B?Y3B4aXhDMFRFaXlnZ2hXaWtCV2JrU0w4TGQ4b1pZdjBVZk00OHhxN3ZpMCty?=
 =?utf-8?B?OVBLb2I1cjV1aUZsM01aM1ZmZ0I4Mm9KdzJOOGx5MkpodVg1L3Y4VlR3QjhG?=
 =?utf-8?B?cHhDM1R1S2tIbnNIMmUrWTF1elkwVWVSUEc4YjNDS0F5WktBQmxoVHNqQk5n?=
 =?utf-8?B?QzdpVEVPcHY3SHpTZTlNY2tIMWxXblBaT0VLd1loQUJPZFZzMW1KMmJQanow?=
 =?utf-8?B?Z3RldUxWb3hPQlg2N0RjM3V5VVZ4Si9RRktJRExUdmRxRVV3QlhMOWl0aWpC?=
 =?utf-8?B?ZDdvTGQrZVZodmR6VlpndVNxT1dXS0FmKzdBSFBsNUZrTnl1ZldHbnBhd2tj?=
 =?utf-8?B?ZHBFZU1NN3djcnpBUGpXWFNLNCtCYkRWQTlHdWlXMEpaK2M2RGRsTTRzczMw?=
 =?utf-8?B?QkxlQkxxUXlwWkFGeHpxalNGRGZnc1NVN04xRGNIc25KRG9WRDVwZWV5ZDdi?=
 =?utf-8?B?eE9hcW1rQ1JmdjgrZVNpbEUyZ01RMDlaRWhwN21tci9nUnVSVGpYVytZTW9w?=
 =?utf-8?B?NURhUDVsZGt2SThmYmx5Z3VYRGlmR2ZrdjhKbi9aOGs4QkJQZ0RsVCtxZG5o?=
 =?utf-8?B?ZFpJZUdDMEIwbXA3VythQlRZeWZoQm1INTV1SmJNb0Z2Rm4wTG8yWUpjdnNR?=
 =?utf-8?B?T3Vzb1ZFVThDKzBEVisxRlovTTBDRkJ6dXBZYmZoQTVna08xWGk3WnFEZnJi?=
 =?utf-8?B?UEZsNUU5WDdQK1ZETzBpRk16YS9JVVlacUpQaWQ3WkJMS20veGJBeFhvek0y?=
 =?utf-8?B?cStmTXM5RlhHZlZMbGJNMVZoNElDOFdTb3pIY2JvTlhRcHBpb1Z1SEpNVits?=
 =?utf-8?B?cWpKZ3FZWStvUUpaS2g1dTNtZ0xUSDZ0eUlwUGUxNitzT0gxc1RDSGZxRlZv?=
 =?utf-8?B?eFdnNlNVMWZBMWF2RkpNU1RDUW1BLy9wTTBTSVJVTGlOaHNxWDlyNDRVZnlK?=
 =?utf-8?B?T3VlZXZ4OXNUemttcWcvaUQxVk9Ea1dpZEw0WE9VUlJqdytGZlkxRStqUVhU?=
 =?utf-8?B?dzIxVGpMMmJURUdLK1J0U0NXb1d6RTJvSXN2NnZkNUVYMzQ0aUJsL2ZpY3Bv?=
 =?utf-8?B?dk1Canh2VkFVY3dOYXpjYWNDN2lxRU5jNFlIQ2pHQUF6SU9rQWg1MXVXdzFK?=
 =?utf-8?B?MTB4akRWOTRKZ2xvY2pQQ3VzYkxMaHBmbDNCU1FocVZKSHNLZW9PbUZCTTFk?=
 =?utf-8?B?SVp4bzNoai8rLzJtOHBtaC9jSHRTcTRTVm1jUGJzZlgxZTZtTDZQOWhyQUx1?=
 =?utf-8?B?ZkZrczlNZ1owUnlDUU5mQ3NicWtaUzNGVUNTcWJ5RmgvUXllM0NzTDRnNTBX?=
 =?utf-8?B?Q0U0SEp1MzExUjBkcm1uQmgyRXNsTW5vLzdGQURNM3I1SmE4dHk4U2lvZW0z?=
 =?utf-8?B?VDZtMytKRW9GKy9rdjRINXZKM1NURTlMbnFLdmtTME4vWHI2bE52aU9YUXV6?=
 =?utf-8?B?NFBvdzFlbXFUd0VTSjBsYU0xQ0YyNEp2UjRNb2JHS3NxSjdweHBDUGU0dHNQ?=
 =?utf-8?B?ZkpoSkJLdnplTVNqTzhGcExrV2RPdUVHSjd1dDROOGpuNndFSHljRkt3bk5i?=
 =?utf-8?Q?7a1P4CiFudd5hHuRVpT0riK4R?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5808.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a57b4321-2e4b-4eaf-2613-08dc3289b8a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 03:03:46.9617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cd0hcb3ufaHIXd+HQ2iiyQmjP6QggElUwjEia18L8yqNvoomCe5KP09S7F3tQI49PATTT3LzTyzDaoLutIcaqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4826
X-OriginatorOrg: intel.com

PiBGcm9tOiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsQGtlcm5lbC5vcmc+DQo+IE9uIFdlZCwg
RmViIDcsIDIwMjQgYXQgMjowMeKAr0FNIFdlbnRvbmcgV3UgPHdlbnRvbmcud3VAaW50ZWwuY29t
Pg0KPiB3cm90ZToNCj4gPg0KPiA+IEluc2lkZSBJVlNDLCBzd2l0Y2hpbmcgb3duZXJzaGlwIHJl
cXVpcmVzIGFuIGludGVyZmFjZSB3aXRoIHR3bw0KPiA+IGRpZmZlcmVudCBoYXJkd2FyZSBtb2R1
bGVzLCBBQ0UgYW5kIENTSS4gVGhlIHNvZnR3YXJlIGludGVyZmFjZSB0bw0KPiA+IHRoZXNlIG1v
ZHVsZXMgaXMgYmFzZWQgb24gSW50ZWwgTUVJIGZyYW1ld29yay4gVXN1YWxseSBtZWkgY2xpZW50
DQo+ID4gZGV2aWNlcyBhcmUgZHluYW1pY2FsbHkgY3JlYXRlZCwgc28gdGhlIGluZm8gb2YgY29u
c3VtZXJzIGRlcGVuZGluZyBvbg0KPiA+IG1laSBjbGllbnQgZGV2aWNlcyBpcyBub3QgcHJlc2Vu
dCBpbiB0aGUgZmlybXdhcmUgdGFibGVzLg0KPiA+DQo+ID4gVGhpcyBjYXVzZXMgcHJvYmxlbXMg
d2l0aCB0aGUgcHJvYmUgb3JkZXJpbmcgd2l0aCByZXNwZWN0IHRvIGRyaXZlcnMNCj4gPiBmb3Ig
Y29uc3VtZXJzIG9mIHRoZXNlIE1FSSBjbGllbnQgZGV2aWNlcy4gQnV0IG9uIHRoZXNlIGNhbWVy
YSBzZW5zb3INCj4gPiBkZXZpY2VzLCB0aGUgQUNQSSBub2RlcyBkZXNjcmliaW5nIHRoZSBzZW5z
b3JzIGFsbCBoYXZlIGEgX0RFUA0KPiA+IGRlcGVuZGVuY3kgb24gdGhlIG1hdGNoaW5nIE1FSSBi
dXMgQUNQSSBkZXZpY2UsIHNvIGFkZGluZyBJVlNDIE1FSSBidXMNCj4gPiBBQ1BJIGRldmljZSB0
byBhY3BpX2hvbm9yX2RlcF9pZHMgYWxsb3dzIHNvbHZpbmcgdGhlIHByb2JlLW9yZGVyaW5nDQo+
ID4gcHJvYmxlbSBieSBkZWZlcnJpbmcgdGhlIGVudW1lcmF0aW9uIG9mIEFDUEktZGV2aWNlcyB3
aGljaCBoYXZlIGEgX0RFUA0KPiA+IGRlcGVuZGVuY3kgb24gYW4gSVZTQyBtZWkgYnVzIEFDUEkg
ZGV2aWNlLg0KPiA+DQo+ID4gQWRkIElOVEMxMENGLCB0aGUgSElEIG9mIElWU0MgTUVJIGJ1cyBB
Q1BJIGRldmljZSBvbiBNVEwgcGxhdGZvcm0sIHRvDQo+ID4gYWNwaV9ob25vcl9kZXBfaWRzLg0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogV2VudG9uZyBXdSA8d2VudG9uZy53dUBpbnRlbC5jb20+
DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvYWNwaS9zY2FuLmMgfCAxICsNCj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3Bp
L3NjYW4uYyBiL2RyaXZlcnMvYWNwaS9zY2FuLmMgaW5kZXgNCj4gPiBlNmVkMWJhOTFlNWMuLmYz
MmEyYzczOGM4YiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2FjcGkvc2Nhbi5jDQo+ID4gKysr
IGIvZHJpdmVycy9hY3BpL3NjYW4uYw0KPiA+IEBAIC03OTgsNiArNzk4LDcgQEAgc3RhdGljIGNv
bnN0IGNoYXIgKiBjb25zdCBhY3BpX2hvbm9yX2RlcF9pZHNbXSA9IHsNCj4gPiAgICAgICAgICJJ
TlRDMTA1OSIsIC8qIElWU0MgKFRHTCkgZHJpdmVyIG11c3QgYmUgbG9hZGVkIHRvIGFsbG93IGky
YyBhY2Nlc3MgdG8NCj4gY2FtZXJhIHNlbnNvcnMgKi8NCj4gPiAgICAgICAgICJJTlRDMTA5NSIs
IC8qIElWU0MgKEFETCkgZHJpdmVyIG11c3QgYmUgbG9hZGVkIHRvIGFsbG93IGkyYyBhY2Nlc3Mg
dG8NCj4gY2FtZXJhIHNlbnNvcnMgKi8NCj4gPiAgICAgICAgICJJTlRDMTAwQSIsIC8qIElWU0Mg
KFJQTCkgZHJpdmVyIG11c3QgYmUgbG9hZGVkIHRvIGFsbG93IGkyYw0KPiA+IGFjY2VzcyB0byBj
YW1lcmEgc2Vuc29ycyAqLw0KPiA+ICsgICAgICAgIklOVEMxMENGIiwgLyogSVZTQyAoTVRMKSBk
cml2ZXIgbXVzdCBiZSBsb2FkZWQgdG8gYWxsb3cgaTJjDQo+ID4gKyBhY2Nlc3MgdG8gY2FtZXJh
IHNlbnNvcnMgKi8NCj4gPiAgICAgICAgIE5VTEwNCj4gPiAgfTsNCj4gPg0KPiA+IC0tDQo+IA0K
PiBBcHBsaWVkIGFzIDYuOSBtYXRlcmlhbCwgdGhhbmtzIQ0KDQpUaGFua3MsIGFuZCBhbnkgY2hh
bmNlIHRvIDYuOD8gDQoNCkJSLA0KV2VudG9uZw0K

