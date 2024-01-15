Return-Path: <linux-acpi+bounces-2860-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2859082DB14
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Jan 2024 15:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E8A61C21998
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Jan 2024 14:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48731757E;
	Mon, 15 Jan 2024 14:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V3qX8VWI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3568517586
	for <linux-acpi@vger.kernel.org>; Mon, 15 Jan 2024 14:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705327998; x=1736863998;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bEF/x21htNeGAKvpv0eRYvxiNfimgng5Hz68GEXV3HQ=;
  b=V3qX8VWIEmabtz056ae4twOD/81qOTSoay1TfTR5QbK+g0nv9ZXTBLMF
   5lcWdspaZSIkvuGTF58nDOLvIaAh2yCaVhHzHxXc/PQX0pZC6cwaDD/UB
   zwUQf722b8IUwa3f+E96bH4nJYfC5zT+Lsh63Xi3QXnJi+TrCNi2Jdlya
   pz2zWOsAz7tJOMqmbnEzY+Z26SJL1xOwBbC4cKCXgFSSKtm0wIzOICSFG
   RFeDYrsPxSkhVQRKJto3bJ8iwoqS/UjBvgcfbonWJ9J6/S1eadNZlmbRS
   gArO4Y0aPZCUZgZvNDe+8+MQCE8AUNoM2RMpUBDfMeLLC3RB1zifxTXW2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="485783355"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; 
   d="scan'208";a="485783355"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 06:13:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="817842826"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; 
   d="scan'208";a="817842826"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jan 2024 06:13:17 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Jan 2024 06:13:16 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Jan 2024 06:13:16 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Jan 2024 06:13:16 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Jan 2024 06:13:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LSKzhkQfD/OBMDoo6uNDM+o6hL9aJVn6mpxu+emp9RTRkm2CtvCwMnHax5+DmE0bpBvPFjb7RzcmYKzedetGBhdJyMwDxhDAvMbIsshB2WOSg4iHSHcaXGJGjpPdH5d/p1lTF78eRqmhqTdJu2PsnF142Msy0HTay02cDDTl4jW6ps6filZR0ghzUDz4hyurPb1ZP8U6qDA5at0QiaUf8G+yCAEVtic3V4mKKzw2ohPf+A0gkhIvIzgMEMwrIgFUslkF50ncGd336FkyGa5rxBFIZopPzoVAXbciZmLt9alpnmq7RURln11vfO1AK6muAH77IunFgWsEKKdEiMrA6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bEF/x21htNeGAKvpv0eRYvxiNfimgng5Hz68GEXV3HQ=;
 b=T4CFdZ0Q9EAqLNVzHu4m5YOcULbS4Vt6maS9dB07BfPqCNmduTOjsVnLJWk0mhRzN5I8L2jLpgwO2osgOWzDQSjtQZx0YQkcMD7DOhd7pLhgZJCVutAM54Dxsg82c+zHit0Ss2F5XMGsWS4eEkW8xjriDvVbJiuDnawMC19XfuGZWiqMQbfNN2IvNh7EudNsFeOGe1QfE1FI9ygdIgphdHmVcsfaig9BpFy+iO/nlPtvfxiv1LkbLHH9qx4bjADcTm1VEC7Ukbj1gHEl3zoKr747//RoEtISzSxLTKeTTZIoU7V/BbQdlEI7D0LQZPA/MoCHKDrWdAUWs4zdl4aE9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by DM4PR11MB5568.namprd11.prod.outlook.com (2603:10b6:5:388::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Mon, 15 Jan
 2024 14:13:14 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::1962:31ea:5a9e:6102]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::1962:31ea:5a9e:6102%4]) with mapi id 15.20.7181.020; Mon, 15 Jan 2024
 14:13:12 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "rafael@kernel.org" <rafael@kernel.org>, "W_Armin@gmx.de" <W_Armin@gmx.de>
CC: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: ACPI INT340E PTID device
Thread-Topic: ACPI INT340E PTID device
Thread-Index: AQHaRudEDd5bmTHMcE6Cr+tA+Gc8H7Da7CEA
Date: Mon, 15 Jan 2024 14:13:12 +0000
Message-ID: <fec103c301df89c630d894d7c1f6db6f7ccea540.camel@intel.com>
References: <14c6f480-66f4-4683-92d6-55a58eb98585@gmx.de>
In-Reply-To: <14c6f480-66f4-4683-92d6-55a58eb98585@gmx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|DM4PR11MB5568:EE_
x-ms-office365-filtering-correlation-id: 08debdea-48bc-419e-5792-08dc15d41be1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3Mz36QZZ40wxiadmFcX9GrmkGn1/J1cI0cpjSNaywRLr88378yYOnp0jMZWjfNMSKDhHtLCREv3nBivFyum/g43F54udvyoWBRRR5T+IXWNJDegSLLZeQxBKpe5TU9P1sEN7Ca2BHst+8YDoaxt1SPywFyVzn+KbY5zUqQmR/spSWQKgCDwo6zbyFalo0DhE1g0kZnGWTf/qYGwmwIIGH+Q+PvTTR32Xp0qxrDcHDjjE4qWo6rf3Nj+5KE0dMpH4OgSWs1ebgofvbNoRywFORZTmC9l48ce4R+8mX08cjAiJCODvXGlFtbJq1IhMTs5LTYcU2ohBxVli8B9+RhiQ0M/DtO+Njvw0sJWWynTy48rNBxtoOtDuU07M9gWff5lNwfmlcPSZLLPLQTr2DXF3YNc4vb+UJe/1wPexyVP1yaSq1ekJ+OHQpZLxGPPxEOECSGSc6c8lKLLujT8wqgHf32KhVKzI+bwa4Nb0ev1spkVcoNli2cxEqBEvIfHtGQWubBwDwwfs5aQbWv4Sw9d0U1GEXG23shvLeNYPUlQi/YaoV9pwCvfz9JKhJtfKQj2SNDyE8H0NvVqJc8hlPUfgCSeoR+7oZZYJgn1RepH52ug=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(39860400002)(346002)(366004)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(71200400001)(478600001)(6506007)(6512007)(26005)(2616005)(86362001)(38070700009)(38100700002)(82960400001)(122000001)(36756003)(41300700001)(2906002)(4326008)(966005)(83380400001)(91956017)(5660300002)(76116006)(8676002)(64756008)(8936002)(66446008)(66476007)(6486002)(66556008)(66946007)(110136005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cDBmb2JOOGlkY3UxbHpOUkllRHA1bDQ0NlZKaWttSEpOaTFXSzF3b01hclVZ?=
 =?utf-8?B?WTNVbENrZVFNbmlhY1NRZHNaYVV0MVJEZU00VHV0d1lGQjdLbFFUaXVEdGdl?=
 =?utf-8?B?c0lydmVmelF0OVNVN29jWjJIT0RoSDkvTlJQRHc1WEFrbTJuY3RkUVpWY25q?=
 =?utf-8?B?RGsxaEkzUXBlTlJ6TlVFT20vNUp6bzNIU1NpTVFTbHowUjZjSWlyZ0RwTDhO?=
 =?utf-8?B?TjhIZU1LUFBHUnBlaEVoQk9WTGpDdlJ1OHp5cWhqK1pUTm5SaGo3MUdJR1Ns?=
 =?utf-8?B?WlNJWHpwRkp0OUFRTzliZGs0NUVSL1pRZ1k4TThzR0tES0lrWWpZZ2Rnbmxk?=
 =?utf-8?B?V25yV3ptZ0ZwTmw1dEFQZ1FiOG1uQjFmVE00VnN1RXlWNSt4eE9lRHJNNndJ?=
 =?utf-8?B?VUc0UFRwMXRkOUxJTkVxRFBIUTNKWVpPR1NxY3IxUVFZS0VuQWpySG1wODdp?=
 =?utf-8?B?S0x0L1h1UjY3RmxCdVV1Z1Evd0M1WWxtTXpRdUt5ZG1tVXlVZ04yNkcveHgr?=
 =?utf-8?B?dGo4SDVGRjk3N1VpT1U1STJPVk1yUWFzSjVvQUFNRWM4ZlFlUDJaQXgvRWxt?=
 =?utf-8?B?ak93TU1selVPWEl2SDNxTUZCOVo4dmZHTWtyWllVWGYxd0VMS05mMGFmWVhm?=
 =?utf-8?B?THVRVDhNdVcyMmxpN3c3bGhIN1dZUHV5eXhhMWRMcmNJdVdMYUV4c2NUeWla?=
 =?utf-8?B?cjFVZzRxZEpOMnhPSDZKdW5VYXFBSU9UcC9HV2NTUXBmSENTNktJQ0U1OWRK?=
 =?utf-8?B?c3V0UjZpL2tKdmMxQmtObVcrV2pYaFZNYkNGQ01oVERtT3dTUVlBQjBOUGZt?=
 =?utf-8?B?R05LK3p6dk9SV2NmdHJnd3hWSU5MY3Z6NjU3ektQbklsQ3JGVG1rMjdtbnBP?=
 =?utf-8?B?M2UwNEFUV0VoakVJYmpSc2p5UFUydzk0SERHS0c2aFhtMTk2Y0R4Ynl4RHA2?=
 =?utf-8?B?UnpTdStoaiszTURUYXQ0YmJ3ZWJyWEJLWnppNXYrclBuSlA5ZWQ2YWowVG1w?=
 =?utf-8?B?WFFlRWpueVFHcTIzb3ZEYy9JNi9aVmg2TXBEOGJqZHBHd0RhRG1kOVFwYTc4?=
 =?utf-8?B?ZGZZblUvdkRlMXViRWI1UitQbjdlMUpCMFpUbHdDNFBGRFNUOFEwcFZVUXVn?=
 =?utf-8?B?NFEvTHZ2MmZ4MmJSS00ydmR1MjRWZjQrYlpwMzhrNE9FaGJncWN4QmhaMHYx?=
 =?utf-8?B?Znc0VlNjc3RiZXZBSDk2ODFWSGEvenBRRE53RXR1MGlzMEJCUFVRTUF6RmtO?=
 =?utf-8?B?M2lpU3htWXFTNTdXUG0xOHFGRUM5Qm0zeWV4ZFpqcmRqZDhvWHNKR2RmUm90?=
 =?utf-8?B?M2UyY2dWR21mQUh5NnlaTkt5dXU4RmdibEF1eWJjQWpqUmY2bkg3UTB4aXhp?=
 =?utf-8?B?b2E0MU5QVlQwbjFPS3lnVTVTc0wzVW1GS3Z0M1N1Nit4R1EzME9qZU04cHNv?=
 =?utf-8?B?MDlFb2o3dGRleE13TGs0V2c1WnNDTDI3YXpxajQ5OWlrM1o1NjlYTDZwakgx?=
 =?utf-8?B?M3pHeEJSTGFmTjZocjUvYW1pVVMzRVZ2V3ZWNmp3R0JOa3dKTlBxYTlncEpt?=
 =?utf-8?B?RWtyd1JYa3V6RlgxNjg4OWNlNnR4UG1BbXNSN2toTzhqUUFoZVpJUUdFQ2xC?=
 =?utf-8?B?R0tuVlBmNzZlZUF1YTJzempYdW5VdS91TlJSUG5UTDVMalMyUi9KckFMQVRp?=
 =?utf-8?B?VHVVUmpVRVBYOHBtTmJoUWN1d3EyTStoeVFJZUxjRk9IZjZuODVvKzd4WWh5?=
 =?utf-8?B?NG5DN0FLRnQra1hPL0NzZVYxRkFGQ3I5cmF2TWVBOGtFMnBza3VmUjU0NWhv?=
 =?utf-8?B?T3g3Y0lIT2E4TUdjcCtVQWRuZG9oTDdja0M3dUtvUFNHYUozdDlodE9OcnpJ?=
 =?utf-8?B?ZytOVlZMeHJqZ0lxSTg2UlUvM2dGMDF6TDdLdllRTmExVk00ZDJzQkV5MkdB?=
 =?utf-8?B?ejVWSi85anl0cmlwb2hJY2s1ZnlnN0VjcEhUekRYZG9LZXJYdVZuc0E5SjRx?=
 =?utf-8?B?WTNhUmRZZWJnb0VlOHprcXNZS2RNcklKa1U5aTMvUWtHeVlla3RzR25iQ1RS?=
 =?utf-8?B?aFpyOG14OWtaUkpNT3hRSGRlelRWRnJFeXRMWk5XRHEvSG9nNW83V2llMTZB?=
 =?utf-8?B?aWY1N3RucnFveXNQRzJXUzlOZXQwclZjTUkxVlRUTENxaXAwOURHSEc3Q25C?=
 =?utf-8?B?dlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5587CC80CDA92E46AABD2FCF69AFC91F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08debdea-48bc-419e-5792-08dc15d41be1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2024 14:13:12.4647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z1D0OS1+0Oq7jPPz2Rr3DJ3Vn09l8w5RvrQlWLS40IYT0zVuz1qkUrZDrstLBgB7tXS9d5SZBFhc8+/KekqlJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5568
X-OriginatorOrg: intel.com

SGksDQoNCk9uIFN1biwgMjAyNC0wMS0xNCBhdCAxMzo0MiArMDEwMCwgQXJtaW4gV29sZiB3cm90
ZToNCj4gSGVsbG8sDQo+IA0KPiBhIHVzZXIgaGFzIGFza2VkIGlmIHRoZSBBQ1BJIElOVDM0MEUg
ZGV2aWNlIGNvdWxkIGJlIHN1cHBvcnRlZC4NCg0KV2hhdCBkb2VzIHRoaXMgZGV2aWNlIGJyaW5n
IHRvIHRoZSB1c2VyPw0KDQo+ICBJdHMgc2VlbXMgdGhhdCB0aGlzIGRldmljZSBleHBvc2VzDQo+
IHRoZXJtYWwgYW5kIHBvd2VyIHNlbnNvcnMgdG8gdGhlIG9wZXJhdGluZyBzeXN0ZW0sIHBsdXMg
c29tZSBnZW5lcmFsDQo+IHB1cnBvc2UgIk9TRCIgc2Vuc29ycy4NCg0KSG1tLCBJIGRvbid0IGtu
b3cgd2hhdCB0aGlzIGRldmljZSByZWFsbHkgbWVhbnMuIEF0IGxlYXN0IGl0IGlzIG5vdA0KcmVs
YXRlZCB3aXRoIHRoZSBvdGhlciBJTlQzNDBYIGRldmljZXMuDQoNCj4gDQo+IFRoZSBkZXZpY2Ug
aXMgYWxyZWFkeSBzdXBwb3J0ZWQgYnkgdGhlIEhhY2tpbnRvc2ggY29tbXVuaXR5LCBzZWUNCj4g
aGVyZToNCj4gaHR0cHM6Ly9naXRodWIuY29tL1JlaGFiTWFuL09TLVgtRmFrZVNNQy1rb3psZWsv
YmxvYi9tYXN0ZXIvQUNQSVNlbnNvcnMvUFRJRFNlbnNvcnMuY3BwDQo+IA0KPiBCYWNrIGluIDIw
MTQsIHRoZSBJTlQzNDBFIGRldmljZSB3YXMgbWVudGlvbmVkIGluIG1lc3NhZ2UNCj4gIjE0MDg2
MjI5MzQuMzMxNS44LmNhbWVsQHJ6aGFuZzEtdG9zaGliYSIgYXM6DQo+IA0KPiDCoMKgwqDCoMKg
wqDCoMKgVGhlIFBUSUQgZGV2aWNlIGhhcyBfQ0lEIFBOUDBDMDIsIGJ1dCBpdCBpcyBhbHNvIHJl
cHJlc2VudHMNCj4gYW4NCj4gwqDCoMKgwqDCoMKgwqDCoElOVDM0MEUgZGV2aWNlLCB0aGVyZSBp
cyBhIHBsYXRmb3JtIGJ1cyBkcml2ZXIgZm9yIHRoaXMNCj4gZGV2aWNlDQo+IMKgwqDCoMKgwqDC
oMKgwqB3aGljaCB3aWxsIGJlIGludHJvZHVjZWQgYnkgbXlzZWxmIHNvb24uDQoNCkludGVyZXN0
aW5nLCBJIGNhbm5vdCByZWNhbGwgd2hhdCBoYXBwZW5lZCwgbWF5YmUgdGhhdCBkZXZpY2UgSUQg
aXMNCmRlcHJlY2F0ZWQgbGF0ZXIuDQoNCkNDIHNyaW5pdmFzLCBhbmQgd2Ugd2lsbCBtYWtlIGNs
ZWFyIHdoYXQgaXQgZG9lcyBiZWZvcmUgZG9pbmcgYW55dGhpbmcuDQoNCnRoYW5rcywNCnJ1aQ0K

