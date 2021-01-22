Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFBB300AC2
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Jan 2021 19:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbhAVSKk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Jan 2021 13:10:40 -0500
Received: from mga02.intel.com ([134.134.136.20]:46124 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729370AbhAVR6G (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 22 Jan 2021 12:58:06 -0500
IronPort-SDR: XrybbIskCK+A0uLwM50A+UXaot8BvNKgeJqg2hH4wEwQZCOgodOt2JhkABwe/mm0JEyFayttvj
 cwFsvuCeiiiw==
X-IronPort-AV: E=McAfee;i="6000,8403,9872"; a="166581793"
X-IronPort-AV: E=Sophos;i="5.79,367,1602572400"; 
   d="scan'208";a="166581793"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 09:57:24 -0800
IronPort-SDR: PHU+vr2smspfSh1RtlN5/iFa2zfqUkY8Cf3ziYCGkI9cpwHuSODfcG6jqdc0/sErlUmMmudgcd
 5GFCYYmmuY9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,367,1602572400"; 
   d="scan'208";a="571201858"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga005.jf.intel.com with ESMTP; 22 Jan 2021 09:57:23 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 22 Jan 2021 09:57:23 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 22 Jan 2021 09:57:23 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 22 Jan 2021 09:57:23 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.55) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Fri, 22 Jan 2021 09:57:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QkAs8EcZ7ebTrdWI5y1qrAvs11LAlv8BDDAdP3aOc8aajMP45GQ7C8C/Pz8GlStvkJ9UrXucXR3KnVpirtKjSAOGATWpOzcGSJ8PiUHr7lm33s3X6OmTsTnNiqfPUnQ+yB0A3Oc0SD3AnquH95fqKKrDCo3dIsVfoMRgFseg5GZl06NEK/+aDOkUMQt/6WiEpqm/sqC7jNRO7jX/k8B6VCztuTYzjGCb0LyB1mgnSda3DaK3NoCBcKUHVJGxpzOQ0zCiPTeQof3zlJBxPKdGAD3UKB+ARaoQkKwkePWMfkbqwsL401Br0iPbwlA9nh7AUXjbWgjmVN3aCg1kykSnjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EAQLhsFKXmryzCc7w/UrKwc+NwKHWobUZBin7hP2vMk=;
 b=HsZvCBAm0TZZV2v/Tj6a73ZVZ+5NL+8aDD6jkp9wuPcn8kWKFLTO1KVWlZAD7aEMqzsXrZnU2aFEBA6D3jw24QB0nJPn7d/snsKKp63fHqjm8Kl7zSQVbyDpEEPa6rO8Djp7afvPcbFVPMOHlceNzmolVytpa7GoPTG5imJ66wsEod75i/FZiqStgDInDhbR9KWNGdLk864eaJz2FpKvHcAJNVanxo77SOAiIXXMnKiyH+5AKcqapyF2UHRjIMzB1gDVUhl49hCUU266KsGFqayGfRyEM/onleH0ecD4HUZri6bGeq30W04XnFDza9WuI/1EdaeI7EMyuPsTgsnjcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EAQLhsFKXmryzCc7w/UrKwc+NwKHWobUZBin7hP2vMk=;
 b=RcnbxOwBxCi/X3I0JLxVmV/lnTW/2iD8VzBtezyZu65xhpltZKCXyVdXp4bkFPawCndwLD3dfxx8zYi+4l1lMmD02cbofoD6dZX7qySl8T3ihgpevb5bjMUh87byl3mhToEQuRM4cFQBxgEHwBP0O5GPvl31u4RTH/PFRhKMaiE=
Received: from MWHPR11MB1599.namprd11.prod.outlook.com (2603:10b6:301:e::16)
 by MWHPR11MB1295.namprd11.prod.outlook.com (2603:10b6:300:2b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Fri, 22 Jan
 2021 17:57:19 +0000
Received: from MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::4878:159c:ca1e:f430]) by MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::4878:159c:ca1e:f430%10]) with mapi id 15.20.3784.015; Fri, 22 Jan
 2021 17:57:19 +0000
From:   "Kaneda, Erik" <erik.kaneda@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v2 0/9] ACPICA release 20201217 and 20210105
Thread-Topic: [PATCH v2 0/9] ACPICA release 20201217 and 20210105
Thread-Index: AQHW8FloJ+STD1FsMkW4umQ3GcgnK6ozv8sAgAAvcOA=
Date:   Fri, 22 Jan 2021 17:57:19 +0000
Message-ID: <MWHPR11MB15991A6F1F75F107FA8E1968F0A09@MWHPR11MB1599.namprd11.prod.outlook.com>
References: <20210122002357.370836-1-erik.kaneda@intel.com>
 <CAJZ5v0iFkA1rXV0kuv2aQtXtOZYGpR20jdMzZRtwJkmqbCDxdw@mail.gmail.com>
In-Reply-To: <CAJZ5v0iFkA1rXV0kuv2aQtXtOZYGpR20jdMzZRtwJkmqbCDxdw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [174.25.99.223]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a015d40-42dd-4bc8-9dc1-08d8beff29ad
x-ms-traffictypediagnostic: MWHPR11MB1295:
x-microsoft-antispam-prvs: <MWHPR11MB12956E4B871F0AE84FCD1219F0A09@MWHPR11MB1295.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FH1ul+Q0krnZgkyYfcF/nfWYRvlsP8HR3EX0VXkgcMQGlllGB2Dn8BJvrzK+JqMeECoL/o/+//Xb7XsmIMu8zbwNLAs8eRsmzUqRaU8A5XI3YAj5CLqlsJeyhVPCBhsUvcLtmdaGitAGLXG0xmBzveZBjsDCdfiKRAQREBOy0+LXo1rV2P/+/gsTHSX88jDJQ0PV46UzF8Wm8gl86CGyYusHStgsIlv5fr3byeClbITelUIKKhU29gEQ5AlzKg+2PJCzd8ZaKOzodQJsv/vlXzdwF1xoVvUD5OfNkOVlpN+5wvVnDa4TqtQvx92nGKxcNICmUqWqaQCR7tXu7zZ2pAypvytFZI2M6WM9EvTp1ruqpYEDgtuVnBOWdL//Nwwag04QOd5KxPdLQZOEOVtZRH/c5BnSKPrTWcmJvJG5hYdd5xyO6IWpZ91WmxoshchX9dzs6yHaBno9n0Pp/2FnKw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1599.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(136003)(39860400002)(366004)(53546011)(6506007)(71200400001)(55016002)(33656002)(83380400001)(478600001)(4326008)(6916009)(2906002)(76116006)(5660300002)(52536014)(66556008)(26005)(316002)(64756008)(9686003)(66446008)(8676002)(966005)(66946007)(66476007)(86362001)(186003)(8936002)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?TERsSllVZW1yZTNMUmxZSGtjbHpTMFp5SDN3SWJ2cGZBTDlTc0cxemFpUnNR?=
 =?utf-8?B?clBZSTNGVklPWnl0TlNqUkVlZFhFcit6MUtuelVHWEsvY1MrY000MGJQWkti?=
 =?utf-8?B?UDI5V3R6aHdsUEVTM20waVNSWDc2T01GQ2pkZk5TWVpGUTRMc2ZOSUtTZ0Zm?=
 =?utf-8?B?b1pQS09scUlQcEswRnY1dXNBMjUwRzN4YjhMWkNDMGl2VXZZVVhlTGNVK2Zq?=
 =?utf-8?B?cFVvdDF0cHBLTk9oSTZtVUJIaUVndStWNVBDZG9NV0FzZjAyVEF1TWx1c2ZT?=
 =?utf-8?B?dnA2VDBZTi84MEtrck9pVUVGMmZlSHMwMjJ2UU9DZXJmNUk2TEZva2RoaGNX?=
 =?utf-8?B?cnRocmhhNHh5VTJCR3B2NkhSVEdxdWVuTFFNQS9hZzlOMG14S3VQOW5aR2Jt?=
 =?utf-8?B?MWpQdUFIQVo4R1hRaEtkaGFKb0U1S0lEcHl6TDc2UFYwY0pReVcxR0h0SzZP?=
 =?utf-8?B?NW1YK1hSbWtuU3dqMDNHZURoSjJvS1VhZWtVYy9Ed1duRVBVUGVjeTM4eWhK?=
 =?utf-8?B?WEtVS1NYYzdudWQrMVd4SFhDL2l4ZHkwYWlxY214cEVlTVJiNVI5eGE3dzBp?=
 =?utf-8?B?VDBwQ01PakppQWpSbnkxOTZZUmRIVGJYVW96M0E4Z1h2dlRiM1NSMTc5b21h?=
 =?utf-8?B?YUVjUUhYMm93ZEtCSnJ6Vmg5VFp0Mm55Z2VXNm81ZHhvS2NrcGt2dkdaOVFW?=
 =?utf-8?B?NWx4MG1iK2w1UmczTVhQVjVvbHVsU1BoMUFDRlViQXhiaVYwYXYrMXR3MWRD?=
 =?utf-8?B?b0JxYjhnRXJuTmx5K0VBMWliMDRXT0JOOEtzQTFKYmdWcWh6UlU5dEc1bHl6?=
 =?utf-8?B?WjZUaWhuU3B2WjM5ZDRFaG16K0Q2TmptcmJKa1I5eUM2UTFXVWZoSGhMcDd0?=
 =?utf-8?B?R0hrTnVTdWF6S2JtVUNhZnlJcTRDelBCSWhjUTBtWHVaWjBZb0VMd3NrdHp4?=
 =?utf-8?B?bHJMMmtPQ0ZYRGU4clR6WW1aS0FtaTlvYzhiaWNMcDNTZFdITkZCUVVnaUxP?=
 =?utf-8?B?MGR6TGtQTzhJQkRMZjNkWVViYTJTRHN4VjFLOEoxOXkyRy9mQm5LSktyS2Fw?=
 =?utf-8?B?YlFSZXJTWjhNRG1ZTXFoeEo3cGVkazB3YlNiT0F5aEhkMVQzUFBrcHRzMjFL?=
 =?utf-8?B?VXVha2NzUFRQbmgzZG13aGRYK1Q4cU5saDVTaGoyUy9WeVlrR2dRYW1RS3V2?=
 =?utf-8?B?NUx3WXZQcGQ4Z2s5QnhSZnFkRUZ6OEl3VXV2VFo2ejNtK2NCd250UGFYM0dE?=
 =?utf-8?B?RW5wajMyaTdxVGpuUm1laVJEVlVSMnBnOGVNdnI4M2pCVkU2eXY2SG8rbUJF?=
 =?utf-8?B?VlFsWW9nVkdYVUp0cHV4S0h0ZVJQT3c2WnFSem1Cb1ZrN1AzcUxRUmxjMUVw?=
 =?utf-8?B?bHlwVVQ2NWZkQTBJbU80KzlXL2tUOU1zNEduallPaWY5dnRDUDBINStET3dJ?=
 =?utf-8?Q?lpEs/es9?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1599.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a015d40-42dd-4bc8-9dc1-08d8beff29ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2021 17:57:19.7267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mvIMnzm5/7ak1fM+23wRD/8wu08qadHJS9p9B/nFwV5Fozbwc4w83+D7Ea1B8tbz12VAumpkKarYS7vU+DlBMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1295
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFmYWVsIEouIFd5c29j
a2kgPHJhZmFlbEBrZXJuZWwub3JnPg0KPiBTZW50OiBGcmlkYXksIEphbnVhcnkgMjIsIDIwMjEg
NzowNyBBTQ0KPiBUbzogS2FuZWRhLCBFcmlrIDxlcmlrLmthbmVkYUBpbnRlbC5jb20+DQo+IENj
OiBSYWZhZWwgSiAuIFd5c29ja2kgPHJhZmFlbEBrZXJuZWwub3JnPjsgQUNQSSBEZXZlbCBNYWxp
bmcgTGlzdCA8bGludXgtDQo+IGFjcGlAdmdlci5rZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIHYyIDAvOV0gQUNQSUNBIHJlbGVhc2UgMjAyMDEyMTcgYW5kIDIwMjEwMTA1DQo+IA0K
PiBPbiBGcmksIEphbiAyMiwgMjAyMSBhdCAxOjU2IEFNIEVyaWsgS2FuZWRhIDxlcmlrLmthbmVk
YUBpbnRlbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gVGhpcyBzZXJpZXMgY29udGFpbnMgQUNQSUNB
IHZlcnNpb25zIDIwMjAxMjE3IGFuZCAyMDIxMDEwNS4gVGhlc2UNCj4gPiByZWxlYXNlcyBhcmUg
cXVpdGUgc21hbGwgYW5kIGNvbnRhaW4gdHJpdmlhbCBvciBzdHlsaXN0aWMgZml4ZXMgYXMgd2Vs
bA0KPiA+IGFzIGRlcHJlY2F0aW5nIE1UTVIgYW5kIFZSVEMgdGFibGVzLiBUaGUgY29weXJpZ2h0
IHVwZGF0ZSBwYXRjaCBpcyBsYXJnZQ0KPiA+IGluIHNpemUgc28gaXQgbWlnaHQgbm90IGNvbWUg
dGhyb3VnaCB0aGUgbWFpbGluZyBsaXN0LiBBcyBhbg0KPiA+IGFsdGVybmF0aXZlLCB0aGlzIHBh
dGNoIHNldCBpcyBob3N0ZWQgYXQgdGhlIGZvbGxvd2luZyBsaW5rIG9uIGdpdGh1YjoNCj4gPg0K
PiA+IGh0dHBzOi8vZ2l0aHViLmNvbS9TY2htRXJpay9saW51eC90cmVlLzIwMjEwMTA1DQo+ID4N
Cj4gPiB2MiAtIHJlcGxhY2UgbWlzc2luZyBsaW5lIGluIGluY2x1ZGUvYWNwaS9hY3R5cGVzLmgg
aW4gTmljaydzIGZhbGx0aHJvdWdoDQo+ID4gcGF0Y2guIEl0IGxvb2tzIGxpa2UgdGhpcyBsaW5l
IHdhcyBtaXNzaW5nIGR1ZSB0byBhIGJ1ZyBpbiBBQ1BJQ0Encw0KPiA+IGxpbnV4aXplIHNjcmlw
dHMuLi4NCj4gDQo+IEkndmUganVzdCByZXBsYWNlZCB0aGUgZGVmZWN0aXZlIHBhdGNoIGFuZCBy
ZXRhaW5lZCB0aGUgcmVzdCBmcm9tIHRoZQ0KPiBwcmV2aW91cyB2ZXJzaW9uLg0KPiANCj4gVGhh
bmtzIQ0KDQpPayB0aGFua3MsIGFuZCBzb3JyeSBhYm91dCB0aGUgY29uZnVzaW9uIQ0KDQpFcmlr
DQo=
