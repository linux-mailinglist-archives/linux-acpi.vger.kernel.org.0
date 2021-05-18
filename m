Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E081388231
	for <lists+linux-acpi@lfdr.de>; Tue, 18 May 2021 23:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352486AbhERVhK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 18 May 2021 17:37:10 -0400
Received: from mga14.intel.com ([192.55.52.115]:15937 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244028AbhERVhI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 18 May 2021 17:37:08 -0400
IronPort-SDR: 0+WhGUpiHM/5TdT8lw9sBXKy1HR0SnoPmS7OPPFYd39aWcYhn2y9iY43FaE3lFVwfR5sMzo4+J
 fyd/4x7d95FQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="200522413"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="200522413"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 14:35:48 -0700
IronPort-SDR: +12kO/3VWdBWc11JM6R/35PRvgVW0oUS21kaD3gxIUT3nXhB/LibWTEUOTzfhX8KysrFZQ+rEI
 ul7bRP/g/CQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="542135940"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga001.fm.intel.com with ESMTP; 18 May 2021 14:35:42 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 18 May 2021 14:35:41 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Tue, 18 May 2021 14:35:41 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 18 May 2021 14:35:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/efqJaFjUy8gAWJXO+/CfGhPdVQqfZ3IqXMnCvtrjjnlA9QZ38R0yJuI7mJBPrdfgjj5psGG2qem4c/ZgAUbFrSO4HaIGwv2khfWQMso9hFAwqLGnRGCO5Amuh7OoFuRy0roTGbxPIGqtUyntxWV0zwnG3cCxHswfgJnDFuoMdy0pYhTx+s4jGEWSrNtPR2uetJAq4qgtD5I9RNIKiMH8vtM3hAnj545yUuxRr5Q8aoUAe9PLFHZsVshCf4SUiJ2Dz/kNJqBte1k0W2xAD4lhINEZgt/zONo8o2nJux9QCQFfa/WZzCX46QF6ObZMJljTlhqyWWZSKxZFbfl+CIOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aleLuuqyMnTbpIgp1CpagyChCtKfgL9n8WbjV6QInCk=;
 b=E1ySn9WgDXwi3bYdBTsjJN8CMfokTrJXudOK6T8cJ08NkR+WVHckwFJpKbZ7fkKKRzkUrJT+zJQ4sfgmc1mVIDEmVZxX8STW9Tjc9cJJyXElrXAC++oQdqgcDmnPP2/T2sVpMUrtUJL14HTcjm930PIyk8dSdbIIS5HmxMwpvGNCAW/Nm0FhcP4txTRy0eKMfmUeJHrlVSueqPKzO2jSCYIbiQugLf1rrmxAoz85jWUjdESL+zHAjsoxF8LVSeq+EClub89OrA3FE4WD97Glo6yJ6l7hVOHkT104DmWK22qFZtFvYghGL2qxdL4xufzY64lrql4jVt8A3MpoP6VnJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aleLuuqyMnTbpIgp1CpagyChCtKfgL9n8WbjV6QInCk=;
 b=RmQLEyS7B1L3RfjXqX+yGaSweTcsvVsWAahsAiIjI28OQxtDoqrWJxdmbFimMNH0sLMSUlOO+TapQWrg7AecHxMX93VzmAv8tFehNtf4Agz3Xb14kKzMLjDaxQkxAAgx23gn9Eru4rTzcRUbCoHZiGx2vfNYHmSc/sH8W+mod8I=
Received: from MWHPR11MB1599.namprd11.prod.outlook.com (2603:10b6:301:e::16)
 by CO1PR11MB5187.namprd11.prod.outlook.com (2603:10b6:303:95::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Tue, 18 May
 2021 21:35:39 +0000
Received: from MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::48df:6af5:afe:ea7e]) by MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::48df:6af5:afe:ea7e%7]) with mapi id 15.20.4129.031; Tue, 18 May 2021
 21:35:39 +0000
From:   "Kaneda, Erik" <erik.kaneda@intel.com>
To:     "chenxiang (M)" <chenxiang66@hisilicon.com>,
        "Moore, Robert" <robert.moore@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "hoan@os.amperecomputing.com" <hoan@os.amperecomputing.com>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: RE: [PATCH] ACPICA: fix a memleak issue related to ACPI/GPIO
Thread-Topic: [PATCH] ACPICA: fix a memleak issue related to ACPI/GPIO
Thread-Index: AQHXRt/M5Z1FQ9rUF0yt6Z/2QYLiFaroDZVwgAB4WwCAAUb4cA==
Date:   Tue, 18 May 2021 21:35:39 +0000
Message-ID: <MWHPR11MB1599FBA0B63433B58DC955F4F02C9@MWHPR11MB1599.namprd11.prod.outlook.com>
References: <1620790207-128605-1-git-send-email-chenxiang66@hisilicon.com>
 <MWHPR11MB159982431E024C6212960C0CF02D9@MWHPR11MB1599.namprd11.prod.outlook.com>
 <5a8fcc49-5559-0e99-4dd9-1821b7ade1ea@hisilicon.com>
In-Reply-To: <5a8fcc49-5559-0e99-4dd9-1821b7ade1ea@hisilicon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: hisilicon.com; dkim=none (message not signed)
 header.d=none;hisilicon.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [2600:6c55:4c7f:e63f:39db:8e7d:a733:e8b9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1aa2b3fa-e2a5-4d6e-d563-08d91a44e183
x-ms-traffictypediagnostic: CO1PR11MB5187:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB5187C5D35C1A805E1CCD62B3F02C9@CO1PR11MB5187.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xLQHEffziOVTOHzW06f5RT+V3zZULTP4sWc/OvF4t/xlhJryrqKbmzRy4SBmWLmYgrytBRQvWgzpzeICLdluxq1OpAe7AF7CNyQDVoPPRf6bh/I90y6UJrNPNEpIQ0iJSnxq8u5SRNNK5D6xXvkOM5doLo/9AR3Dy58QFMeptPYSDfWWaXPSePECAEtLSHSmcC7r6ILAa6bktZAhUz8R/3l5Wbp6JGsbUeFzA1MOffqA+Hn9Ggzxu4HM0wdXTmd2eK8sO1OohqrKy31jg3HOzcgOZ6dV3OVTjxQmo+gU64D0yuJ+0FxY/t3vCTCqb3JR095sQLEcP2hrr4HaNSVA6kL6E+8Hzk/jakJbJptCBo91hfPs404th6yrj2xz05eE2t6ZhbpWmflkks3VMJOKyojB1jvjHUlgDn5HACcOmSnpu2RAK5vUVc0c48kjhgYqxSUndSjoprrJiMGvAE71RYl2D0jlkHwALuXa5WR8tscfWT793GqfnYtIOpOFnaFQBT176aLxTymvtpwwztUE/AmJda9LfrK3NpCxfeJLW5bydJrCZZLYks0e7VPRtzs3+sAn4k1pmxd7TLcdh/dA5vBCiKuZPgHWuHLenS5uIgM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1599.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(366004)(346002)(136003)(396003)(8936002)(2906002)(8676002)(76116006)(71200400001)(122000001)(9686003)(53546011)(66946007)(83380400001)(66476007)(66556008)(52536014)(7696005)(4326008)(478600001)(5660300002)(54906003)(110136005)(66446008)(64756008)(316002)(6506007)(186003)(33656002)(55016002)(38100700002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?SUtKTFNjYVU3OThSNTltZ0lEWVpvVG15cjI3bVZNd3o3SjJCUld5Q1d3bkNF?=
 =?utf-8?B?MnNTZjY0M3IxME93VGFPd241ZjlPVjRpUkhyUFFETUFIOWlKMzkySnNCamlC?=
 =?utf-8?B?STM3ek5zNTM4cXZpWC9EcllzNUxxWGk2S3ZZNmZoVGRmWlMvSkVIb3BaaWZK?=
 =?utf-8?B?RmZyMjNzcGFNS2FUMkV4S0ZPOFRrSTkvTk9COXNNWCtDZVl1ajg5cFZseDVD?=
 =?utf-8?B?Q25QdThWWUNEeVNrcUVoVDZrS0J6STkrNVJaMzZUOHBJSEMvVXRCck5jU2I0?=
 =?utf-8?B?cVFYeUdoM0JnUXNVaE9VMlFMMS9ybWZkcU9xVFlEdVdrbWIreEU5RzFHKzdi?=
 =?utf-8?B?RkJMblJPbUFJN0kwbit6N2hvdEdhb21Nb2Y1anhlSHIya1pXSXd1dU1XcCtY?=
 =?utf-8?B?RXNUaFZJT1JJODhyb1lhczJLcVdydFNjT3R1ZURIbWYzY21ya09nWFkxck1J?=
 =?utf-8?B?SzB1NWhDZExiTWV5TVRrUmxoTVIzV1h4L1llWTdPTXJKVU5QbmtDdUpTOE9y?=
 =?utf-8?B?cFM2SmJOZEF5MlJ4YldTQWtqMUNWSHRDNG5FRzZhRmw0UmJ3MHlQSStMc2NK?=
 =?utf-8?B?Y2JyQmxmTzZVR3dPYnNTSUJrUXZkbTFCaGdkSXRPUVJDOFduVm9PZkJPNkhT?=
 =?utf-8?B?NjV6REYrS01nR3R0YytEK2Q0VWJLRXE1M25HY3YzUndobTlzRmc2Zy82MFpD?=
 =?utf-8?B?WkFJK0lnSjhPZFJVNW1RS1Bpdkc4akhRd29PdmZ6byszVElKenppTkJ1TXR4?=
 =?utf-8?B?V1NxemNmMS9pYUVSaklOS1JVWmhwR2VkSFJCc1dHdm5RTXB1S09WMFhrbFpV?=
 =?utf-8?B?N01ENWdiRy9USWQ4STFCcHRUYkhzazNvTGNqR3lIZlYvMDdSa25BU1d6UXVU?=
 =?utf-8?B?MnJDQXJXVFhmaVlIV3VWZmNRaWtBVVNxY01rRVEzQUhQN29JUU1rblRXaVl2?=
 =?utf-8?B?eE9ZTFZqWFpjWWFxcHJ6M08xNFNlL2MyeFRPNmZzbVNvTk8rcUJncVVFS2ta?=
 =?utf-8?B?amNRbFpGS25VMkhtK25rNTJuWVRnVTcwN2lRMmpNbzhMQWpjdiswYlM5ZThV?=
 =?utf-8?B?aFZPWW9pdG1mYms2U1ZaOW1DeGJBYnlVMG5nQzJYU29OdFcreVVvVU5iQ1JR?=
 =?utf-8?B?TE0vOUdvWEVUYkcyY1Y2Y2psdEUxVlpWek5GdzlBSlgzVFdLbUozNDRhcGFM?=
 =?utf-8?B?ZXhJV2ExVlQzMUc5cXp0d2t3NTdxUGVtSU5jYkdLYTVTOWxPZG9TWS9vcXhL?=
 =?utf-8?B?cFM4ZFE2S0JpSis2aDZJV1liNEYyRHRrbEZpNG9nbkdOTWw2YWdadG5zVnpU?=
 =?utf-8?B?cTRGK3psSnAveHpUbmJuWWtwaWxEeUlIN3JPeVVXMVVIL2d0V1FGeEt1V2Vk?=
 =?utf-8?B?SUNwM21Qbjd0ZjdBa1NYRUEvaG5PU1NZcFZRTUpjMzN6a0RWM1llbVZiTVEx?=
 =?utf-8?B?NjFFVTJXSUN5cVoxYnR1M0dXakF2YW9zOGg2eGhVNXpybFZhQ1d5dkpaYmtE?=
 =?utf-8?B?MzFBVUc1eUkvWWwyeVdWdmN6emJtSEQwV3dOSXFuR0RhZ2dsV0xiamVUcDlr?=
 =?utf-8?B?eXVrcXEwQ3RYM1BPc2dCQWVhNFhxd2lFazNDYmhlaHdZZk1ZSFJid0tTU1pX?=
 =?utf-8?B?eXErOUgvU253dVhiRWNoWVI0VnRnc1AvejFjdWRGRVBFbVNocURhSTBLUlBx?=
 =?utf-8?B?NlZ4OGZmMEE0ZTZ2bFNVRDJoL25Dd3ZFVXdzbEhqeGd2TU9udjQ3Uk44Y2hv?=
 =?utf-8?B?L2U5bUk3aVJOV3B3bHd4NnhBV0hXbjRkVjF0azNlUkw0RjVRemljTHo3Qlcr?=
 =?utf-8?B?eUtyeGhrNlpyS2h0SmU2bkFsTmVWMWxUUnlUeU9pLzNqNHRNRGFWc2p2VzBX?=
 =?utf-8?Q?/d9czgz9QeJaG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1599.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aa2b3fa-e2a5-4d6e-d563-08d91a44e183
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2021 21:35:39.1348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t/bVpr6aX9vLoigyw1PsfiZM9lePlcOaarvY7zZ1huii8UKlr1UowOhOGf2VI3KoKNZqXpIoAKN0guihmbPolQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5187
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogY2hlbnhpYW5nIChNKSA8
Y2hlbnhpYW5nNjZAaGlzaWxpY29uLmNvbT4NCj4gU2VudDogTW9uZGF5LCBNYXkgMTcsIDIwMjEg
NzowMiBQTQ0KPiBUbzogS2FuZWRhLCBFcmlrIDxlcmlrLmthbmVkYUBpbnRlbC5jb20+OyBNb29y
ZSwgUm9iZXJ0DQo+IDxyb2JlcnQubW9vcmVAaW50ZWwuY29tPjsgV3lzb2NraSwgUmFmYWVsIEog
PHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tPjsNCj4gaG9hbkBvcy5hbXBlcmVjb21wdXRpbmcu
Y29tOyBmYW5jZXIubGFuY2VyQGdtYWlsLmNvbQ0KPiBDYzogbGludXgtYWNwaUB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LWdwaW9Admdlci5rZXJuZWwub3JnOw0KPiBsaW51eGFybUBodWF3ZWkuY29t
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIEFDUElDQTogZml4IGEgbWVtbGVhayBpc3N1ZSByZWxh
dGVkIHRvIEFDUEkvR1BJTw0KPiANCj4gSGkgRXJpaywNCj4gDQo+IA0KPiDlnKggMjAyMS81LzE4
IDI6NTQsIEthbmVkYSwgRXJpayDlhpnpgZM6DQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gPj4gRnJvbTogY2hlbnhpYW5nIDxjaGVueGlhbmc2NkBoaXNpbGljb24uY29t
Pg0KPiA+PiBTZW50OiBUdWVzZGF5LCBNYXkgMTEsIDIwMjEgODozMCBQTQ0KPiA+PiBUbzogTW9v
cmUsIFJvYmVydCA8cm9iZXJ0Lm1vb3JlQGludGVsLmNvbT47IEthbmVkYSwgRXJpaw0KPiA+PiA8
ZXJpay5rYW5lZGFAaW50ZWwuY29tPjsgV3lzb2NraSwgUmFmYWVsIEoNCj4gPHJhZmFlbC5qLnd5
c29ja2lAaW50ZWwuY29tPjsNCj4gPj4gaG9hbkBvcy5hbXBlcmVjb21wdXRpbmcuY29tOyBmYW5j
ZXIubGFuY2VyQGdtYWlsLmNvbQ0KPiA+PiBDYzogbGludXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWdwaW9Admdlci5rZXJuZWwub3JnOw0KPiA+PiBsaW51eGFybUBodWF3ZWkuY29tOyBY
aWFuZyBDaGVuIDxjaGVueGlhbmc2NkBoaXNpbGljb24uY29tPg0KPiA+PiBTdWJqZWN0OiBbUEFU
Q0hdIEFDUElDQTogZml4IGEgbWVtbGVhayBpc3N1ZSByZWxhdGVkIHRvIEFDUEkvR1BJTw0KPiA+
Pg0KPiA+PiBGcm9tOiBYaWFuZyBDaGVuIDxjaGVueGlhbmc2NkBoaXNpbGljb24uY29tPg0KPiA+
Pg0KPiA+PiBUaGVyZSBpcyBhIG1lbWxlYWsgcmVwb3J0ZWQgYXMgZm9sbG93czoNCj4gPj4NCj4g
Pj4gdW5yZWZlcmVuY2VkIG9iamVjdCAweGZmZmYwMDIwOGZmODVhMDAgKHNpemUgMTI4KToNCj4g
Pj4gICAgY29tbSAic3dhcHBlci8wIiwgcGlkIDEsIGppZmZpZXMgNDI5NDg5MjU4OCAoYWdlIDg4
Ny41NzJzKQ0KPiA+PiAgICBoZXggZHVtcCAoZmlyc3QgMzIgYnl0ZXMpOg0KPiA+PiAgICAgIDAw
IDAwIDAwIDAwIDAyIDAwIDAwIDAwIDA4IDVhIGY4IDhmIDIwIDAwIGZmIGZmICAuLi4uLi4uLi5a
Li4gLi4uDQo+ID4+ICAgICAgMDggNWEgZjggOGYgMjAgMDAgZmYgZmYgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgIC5aLi4gLi4uLi4uLi4uLi4NCj4gPj4gYmFja3RyYWNlOg0KPiA+PiAgICAgIFs8
MDAwMDAwMDBiYzI1YmFkOD5dIHNsYWJfcG9zdF9hbGxvY19ob29rKzB4ODAvMHgyZTANCj4gPj4g
ICAgICBbPDAwMDAwMDAwOGQ1NDcwNzQ+XSBrbWVtX2NhY2hlX2FsbG9jKzB4MTk0LzB4MmMwDQo+
ID4+ICAgICAgWzwwMDAwMDAwMGIwOGRhOWFkPl0gYWNwaV9vc19jcmVhdGVfc2VtYXBob3JlKzB4
M2MvMHg3OA0KPiA+PiAgICAgIFs8MDAwMDAwMDAyNDgxNmMwYT5dIGFjcGlfZXZfaW5zdGFsbF9z
cGFjZV9oYW5kbGVyKzB4MjE0LzB4Mjc0DQo+ID4+ICAgICAgWzwwMDAwMDAwMGQ5M2E1YWMyPl0g
YWNwaV9pbnN0YWxsX2FkZHJlc3Nfc3BhY2VfaGFuZGxlcisweDY0LzB4YjANCj4gPj4gICAgICBb
PDAwMDAwMDAwOThjMzdhNDU+XSBhY3BpX2dwaW9jaGlwX2FkZCsweDEzMC8weDM0OA0KPiA+PiAg
ICAgIFs8MDAwMDAwMDBjMWNmNGI0Mj5dIGdwaW9jaGlwX2FkZF9kYXRhX3dpdGhfa2V5KzB4Nzlj
LzB4ZGQwDQo+ID4+ICAgICAgWzwwMDAwMDAwMDVjZTUzOWU5Pl0NCj4gZGV2bV9ncGlvY2hpcF9h
ZGRfZGF0YV93aXRoX2tleSsweDMwLzB4OTANCj4gPj4gICAgICBbPDAwMDAwMDAwYTMwMzhiOGQ+
XSBkd2FwYl9ncGlvX3Byb2JlKzB4M2U0LzB4N2U4DQo+ID4+ICAgICAgWzwwMDAwMDAwMDQ3YTAz
ZWJhPl0gcGxhdGZvcm1fcHJvYmUrMHg2OC8weGUwDQo+ID4+ICAgICAgWzwwMDAwMDAwMGRjMTVj
NTAxPl0gcmVhbGx5X3Byb2JlKzB4MTdjLzB4NGEwDQo+ID4+ICAgICAgWzwwMDAwMDAwMGFhMWYx
MjNkPl0gZHJpdmVyX3Byb2JlX2RldmljZSsweDY4LzB4ZDANCj4gPj4gICAgICBbPDAwMDAwMDAw
ZDk3NjQ2ZTA+XSBkZXZpY2VfZHJpdmVyX2F0dGFjaCsweDc0LzB4ODANCj4gPj4gICAgICBbPDAw
MDAwMDAwNzNkNWIzZTU+XSBfX2RyaXZlcl9hdHRhY2grMHg4Yy8weGUwDQo+ID4+ICAgICAgWzww
MDAwMDAwMGZmNjBkMTE4Pl0gYnVzX2Zvcl9lYWNoX2RldisweDdjLzB4ZDgNCj4gPj4gICAgICBb
PDAwMDAwMDAwYjAxODM5M2Q+XSBkcml2ZXJfYXR0YWNoKzB4MjQvMHgzMA0KPiA+Pg0KPiA+PiBJ
dCByZXF1aXJlcyB0byBkZWxldGUgdGhlIGhhbmRsZXIgb2JqZWN0IGluIGZ1bmN0aW9uDQo+ID4+
IGFjcGlfcmVtb3ZlX2FkZHJlc3Nfc3BhY2VfaGFuZGxlcigpIGJ1dCBpdCBqdXN0IHVwIHRoZSBz
ZW0gd2l0aA0KPiBmdW5jdGlvbg0KPiA+PiBhY3BpX29zX3JlbGVhc2VfbXV0ZXgoKSwgc28gdXNl
IGFjcGlfb3NfZGVsZXRlX211dGV4KCkgaW5zdGVhZCBvZg0KPiA+PiBhY3BpX29zX3JlbGVhc2Vf
bXV0ZXgoKSBpbiBmdW5jdGlvbg0KPiA+PiBhY3BpX3JlbW92ZV9hZGRyZXNzX3NwYWNlX2hhbmRs
ZXIoKS4NCj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1ieTogWGlhbmcgQ2hlbiA8Y2hlbnhpYW5nNjZA
aGlzaWxpY29uLmNvbT4NCj4gPj4gLS0tDQo+ID4+ICAgZHJpdmVycy9hY3BpL2FjcGljYS9ldnhm
cmVnbi5jIHwgMiArLQ0KPiA+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBk
ZWxldGlvbigtKQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL2FjcGljYS9l
dnhmcmVnbi5jDQo+IGIvZHJpdmVycy9hY3BpL2FjcGljYS9ldnhmcmVnbi5jDQo+ID4+IGluZGV4
IGIxZmYwYTguLjRkYjBiZWMgMTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvYWNwaS9hY3BpY2Ev
ZXZ4ZnJlZ24uYw0KPiA+PiArKysgYi9kcml2ZXJzL2FjcGkvYWNwaWNhL2V2eGZyZWduLmMNCj4g
Pj4gQEAgLTIwMSw3ICsyMDEsNyBAQA0KPiBhY3BpX3JlbW92ZV9hZGRyZXNzX3NwYWNlX2hhbmRs
ZXIoYWNwaV9oYW5kbGUNCj4gPj4gZGV2aWNlLA0KPiA+Pg0KPiA+PiAgIAkJCS8qIE5vdyB3ZSBj
YW4gZGVsZXRlIHRoZSBoYW5kbGVyIG9iamVjdCAqLw0KPiA+Pg0KPiA+IEhpIFhpYW5nLA0KPiA+
DQo+ID4+IC0JCQlhY3BpX29zX3JlbGVhc2VfbXV0ZXgoaGFuZGxlcl9vYmotDQo+ID4+PiBhZGRy
ZXNzX3NwYWNlLg0KPiA+PiArCQkJYWNwaV9vc19kZWxldGVfbXV0ZXgoaGFuZGxlcl9vYmotPmFk
ZHJlc3Nfc3BhY2UuDQo+ID4+ICAgCQkJCQkgICAgICBjb250ZXh0X211dGV4KTsNCj4gPiBUaGFu
a3MgZm9yIHRoaXMgc3VnZ2VzdGlvbiEgSW5zdGVhZCBvZiBhY3BpX29zX2RlbGV0ZV9tdXRleCwg
Y291bGQgeW91IHRyeQ0KPiB1c2luZyBhY3BpX3V0X3JlbW92ZV9yZWZlcmVuY2UgaW5zdGVhZD8N
Cj4gPiBJIGJlbGlldmUgdGhpcyB3aWxsIGlzIGEgc2FmZXIgb3B0aW9uLiBQbGVhc2UgdGVzdCB0
aGlzIGFuZCBzZWUgaWYgaXQgZml4ZXMgdGhlDQo+IG1lbW9yeSBsZWFrLg0KPiANCkhpLA0KDQo+
IEJ1dCB0aGVyZSBpcyBhbHJlYWR5IGFjcGlfdXRfcmVtb3ZlX3JlZmVyZW5jZShoYW5kbGVyX29i
aikgYmVoaW5kIGl0Lg0KDQpUaGUgZGVsZXRlIG11dGV4IGNvdWxkIHJlc3VsdCBpbiB1bmV4cGVj
dGVkIGJlaGF2aW9yIGJlY2F1c2UgaXQncyBub3QgYWx3YXlzIHRoZSBjYXNlIHRoYXQgYWNwaV91
dF9yZW1vdmVfcmVmZXJlbmNlIHdpbGwgY2xlYW4gdXAgdGhlIG9iamVjdC4gVGhpcyBmdW5jdGlv
biBjbGVhbnMgdXAgdGhlIG9iamVjdCBpZiB0aGUgcmVmZXJlbmNlIGNvdW50IGlzIDAgc28gd2Ug
c2hvdWxkIGFkZCB0aGUgZGVsZXRlIG11dGV4IGR1cmluZyB0aGUgZGVsZXRpb24gaW5zdGVhZC4N
Cg0KQ291bGQgeW91IHRyeSB0aGlzIGNvZGUgdG8gc2VlIGlmIGl0IGZpeGVzIHRoZSBsZWFrPw0K
DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL2FjcGljYS91dGRlbGV0ZS5jIGIvZHJpdmVycy9h
Y3BpL2FjcGljYS91dGRlbGV0ZS5jDQppbmRleCA2MjRhMjY3OTRkNTUuLmU1YmE5Nzk1ZWM2OSAx
MDA2NDQNCi0tLSBhL2RyaXZlcnMvYWNwaS9hY3BpY2EvdXRkZWxldGUuYw0KKysrIGIvZHJpdmVy
cy9hY3BpL2FjcGljYS91dGRlbGV0ZS5jDQpAQCAtMjg1LDYgKzI4NSwxNCBAQCBzdGF0aWMgdm9p
ZCBhY3BpX3V0X2RlbGV0ZV9pbnRlcm5hbF9vYmoodW5pb24gYWNwaV9vcGVyYW5kX29iamVjdCAq
b2JqZWN0KQ0KICAgICAgICAgICAgICAgIH0NCiAgICAgICAgICAgICAgICBicmVhazsNCg0KKyAg
ICAgICBjYXNlIEFDUElfVFlQRV9MT0NBTF9BRERSRVNTX0hBTkRMRVI6DQorDQorICAgICAgICAg
ICAgICAgQUNQSV9ERUJVR19QUklOVCgoQUNQSV9EQl9BTExPQ0FUSU9OUywNCisgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAiKioqKiogQWRkcmVzcyBoYW5kbGVyICVwXG4iLCBvYmpl
Y3QpKTsNCisNCisgICAgICAgICAgICAgICBhY3BpX29zX2RlbGV0ZV9tdXRleChvYmplY3QtPmFk
ZHJlc3Nfc3BhY2UuY29udGV4dF9tdXRleCk7DQorICAgICAgICAgICAgICAgYnJlYWs7DQorDQog
ICAgICAgIGRlZmF1bHQ6DQoNCiAgICAgICAgICAgICAgICBicmVhazsNCg0KPiANCj4gPg0KPiA+
IFRoYW5rcywNCj4gPiBFcmlrDQo+ID4NCj4gPj4gICAJCQlhY3BpX3V0X3JlbW92ZV9yZWZlcmVu
Y2UoaGFuZGxlcl9vYmopOw0KPiA+PiAgIAkJCWdvdG8gdW5sb2NrX2FuZF9leGl0Ow0KPiA+PiAt
LQ0KPiA+PiAyLjguMQ0KPiA+DQo+ID4gLg0KPiA+DQo+IA0KDQo=
