Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7741C45FE50
	for <lists+linux-acpi@lfdr.de>; Sat, 27 Nov 2021 12:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235525AbhK0Lla (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 27 Nov 2021 06:41:30 -0500
Received: from mga11.intel.com ([192.55.52.93]:46334 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235818AbhK0Lja (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 27 Nov 2021 06:39:30 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10180"; a="233249761"
X-IronPort-AV: E=Sophos;i="5.87,269,1631602800"; 
   d="scan'208";a="233249761"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2021 03:36:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,269,1631602800"; 
   d="scan'208";a="572541212"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 27 Nov 2021 03:36:13 -0800
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 27 Nov 2021 03:36:12 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Sat, 27 Nov 2021 03:36:12 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Sat, 27 Nov 2021 03:36:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0zlqPm/TULHV+/hafQe8Mnki3zQSZ82okien7KkZyc3vCAiXLiKGVPKyA786n9diTGH3reBEkeLwGCkq7+9QUbi/edKAgveT+X103NDh2uEUSyQXCsypAATVJBKCIYVTTzSUHA+jbeOkgDthTR1YLCM5MTC9Bu6S/FwxaKOND+n8zMidN4JJ2qghZsbESYokQbEnxmlAXwXkjnmLYxoOmSFZWLUqgmDD1/PMyYomAxx8HVvzcY/7fom9sOsuzJrcCFh/NQL8rq8Dx5u3z0v+dX7LO4EosrA16H2c8iQof76mg/YFCRbKS/NHp8Y2z6LtB+vlVBeddYB0hJVcAZ9WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZSHi99E8scR/gC/eDXb2hbk9HpAaBbvs+K+jeagHi0=;
 b=VO043LCvYNRgKVZ42FZQZjN+r7xb+wyNT/7zdKUEbzdnm7F9UPix2hz5OvXVI5Rgb+X6W0QQ2daBZ9CAlcZnCgBpEG0hDNkiG3CugqxDiz5YKoQkJKbxBLjUvSbVieZmNm6CFBpnFH4NPa2/gEdxK7uQ1dB5ZplaAuXKhkY4nk11LlB6GKpkyMWdmUR6C4y5bXZZlHLABrGzcR+JFM0QWrVPfSHlxNWhGIzr9LSrM3atmkoF/L+M5k4raCxEdYqori5Y+sXYVOdPJWvqoSVMCRvCK94gJ3T95tf2R/RdpKaZZWI/Ot079a5E+RXTj01bCAkxl9ckAaUoAXWaYOOg/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZSHi99E8scR/gC/eDXb2hbk9HpAaBbvs+K+jeagHi0=;
 b=KAHujLIOsJgQikaWVjAzodBgRyF8RHNgp/0Ov+R4fOzIsKPQPRMSV62yFUL4xEacbgwVMDF0/RSvgfO0WWHTaF0R5qRdKO/MXtKvYDvNJ6CExJqoHPmyqL90FddmhXN7qOxKmGElOKpA5PMtWgp+imxmcebnGXry/hgPMagSFZU=
Received: from BYAPR11MB3256.namprd11.prod.outlook.com (2603:10b6:a03:76::19)
 by SJ0PR11MB4784.namprd11.prod.outlook.com (2603:10b6:a03:2da::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Sat, 27 Nov
 2021 11:36:11 +0000
Received: from BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::61d4:ab77:cc62:fabf]) by BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::61d4:ab77:cc62:fabf%6]) with mapi id 15.20.4690.027; Sat, 27 Nov 2021
 11:36:11 +0000
From:   "Moore, Robert" <robert.moore@intel.com>
To:     Guo Zhengkui <guozhengkui@vivo.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        kernel <kernel@vivo.com>
Subject: RE: [PATCH] ACPICA: fix swap.cocci warning
Thread-Topic: [PATCH] ACPICA: fix swap.cocci warning
Thread-Index: AQHX1XBydH3TKz8UmkyKZ8Yotmxz3qwKc18KgAzmwqA=
Date:   Sat, 27 Nov 2021 11:36:11 +0000
Message-ID: <BYAPR11MB325677C8CDA89C5B5C5267A487649@BYAPR11MB3256.namprd11.prod.outlook.com>
References: <20211109134728.1710-1-guozhengkui@vivo.com>
 <AIwACwDlE6oYbcAnsFaroKpJ.9.1637246783998.Hmail.guozhengkui@vivo.com.@PENBSlo1djBpeHR2ek5pQXd3THRYWGdHLThGZHZ0V1l5N1JVaDBwRno2NXNqY215dU5kUUBtYWlsLmdtYWlsLmNvbT4=>
 <db9c50a4-dab7-4aba-1ebb-e38fda08cfe1@vivo.com>
In-Reply-To: <db9c50a4-dab7-4aba-1ebb-e38fda08cfe1@vivo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.200.16
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97c69310-9b06-4899-c5d3-08d9b19a1ce6
x-ms-traffictypediagnostic: SJ0PR11MB4784:
x-microsoft-antispam-prvs: <SJ0PR11MB4784FDDCF8A6D6EA8514C70387649@SJ0PR11MB4784.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 59/Arwa2gafN+r8Ssr2e/QBxV3Wy0+iCluJnmGvEPLPjFbpk0iVnDsiPQxhU/b937di/068EE9EtRPl0qG3Jo5Tect5iPOICy2W2W4ZKgp0XJV/TH4URJ/brvJ/K5XPsJ4FIJGaUASgFeJDu0nIT68Xp0HkeSgyn2KzlR2HRsP5oondWPxIrP++fCiGtPSz3yv7YTKLl1hHaUiZkqAodPvSL34u2EGsu2nHvjSW5bkTgZ/h4LktHttEU48PXdkm46NkOrS1zsHX6ARFgcHxhTNhaFIz5v4FN57sMekQ3lWk+sOT/ZpRLG4Vz0JP4k9prYhmyA4rF3dlYCpFIHrqHnabtyNHSNA79uzJvs79BuLo808Ul2O81vCirWVJkKh2yOMkZnrIkC4VgV6tSd3YEpODDDghXuF+EgMqUaMadVVCRIBY/+jki1q1BVwrPMVOAokW3Zyoij3kaWap5ZQrFoVwyw7Ykrxp4yugaKlTNLK4vQMlaN+pE8YVVcyRhDeMRqNeRbjvhF20JwW4jVQjqPCkkJFQTQC9g6BTJA3bR+eg+S29FU0NakdVujdMkEy2iUyiW3xvYy2HvjA0Dfq1J4WKfQQCIOaSzWXAKMFTbjLfoarTzP/3mG2I7uK+nmAqB+DmndNF8MUlcldY5m1YAIfdO7wJOWiU6HiBBS+B2D2mmEXHy1ZBwZ3JN1f5CEGMxSDZm+QOAB4kVgtfoBCpOtp+iFuPvuHSVy/AvrDBcmUf5RxFcErib2SBc9OBfF9DmkYGAnKlUzlrLampASpZoohYVm6/ktoKGj+xp+qccQgo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3256.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(54906003)(110136005)(86362001)(5660300002)(8936002)(38100700002)(2906002)(52536014)(83380400001)(26005)(53546011)(71200400001)(8676002)(4326008)(9686003)(316002)(7696005)(33656002)(38070700005)(66476007)(76116006)(64756008)(66946007)(66556008)(66446008)(82960400001)(186003)(6506007)(966005)(55016003)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SlNCOXZUeXozcTZPeW5vSndwSWpKLzBlZlVhMTdWVm9WZlg2Y20wV2l0eDdi?=
 =?utf-8?B?Y2ZYblhTMjF5Wm5CWVdERHNwV2srZmp0ekpCL2pSRk4zNmJodFk0eWJKTllP?=
 =?utf-8?B?UEdtR2gyOTh6aWZCMlA5MnRtOUFtVW4xandlQTZXdFFzOHlXcWY1TUdBQ0RG?=
 =?utf-8?B?V2tySE9qUUQvZUdnNHJOY0VuSmp3ajBOMFN0NEVBUUg3K1pVaURQZFowSldE?=
 =?utf-8?B?STUrRUVGemJ2eHRxRjd3dWwySldMVHZ3TEhhbk0vR3VOMmI4Vzg1OGY2bHlF?=
 =?utf-8?B?L2VoZzFkZzJ3ZEtJSGlNRkpNaE9LQnVNdTNDNEUxeno0aGVoT3hhM3duT1di?=
 =?utf-8?B?M2NYekp2NTladVFuTDJtWVB1WCtBUlZOMDkwanl6NndzSGdTRXV0N0UzSVd5?=
 =?utf-8?B?RzJyUGFxK0s4Tml3RXBjV01nRGRUQ051VG9NdWI0Y0VvVVBYMDB3L284MEhn?=
 =?utf-8?B?cmdVbVlYbE1YYU1FbEFrL2MyT0VvMGNMcXdEcCtVRGkvWUQ5VzB2UEswaE4r?=
 =?utf-8?B?T2hKMGhxTFhJU2IrMlRnUVJ2bGJpbjlUS29OMG5uQWNEWFhoaVZkTmFtc2Y4?=
 =?utf-8?B?SHBlREU5YTNTbmFBL3ZjZW1Bdk9NNWZyZ2ZaaU40T05RbXdIc2I4YVdBbWNm?=
 =?utf-8?B?ZUxwYys2S2NCMEhrTjZKRGJYbkZYRGlsWDNHb0FnejdvUldNNkhEeU1yL3oy?=
 =?utf-8?B?UGJlOXF3ekl6OFRIcFdqbTVNZS95dVpuNnlQVDdtclYxTmluWW9DdWNrb3ZT?=
 =?utf-8?B?QnJpVUZBczRHWUVBS1cwN3ZXYnMzN2FvQXBBSVpQQkVNVnRvaEVhTFlWTnR1?=
 =?utf-8?B?QUpzMHJ3UU5XUjJ1TFpqb3puTTNkckxCdWJDcmxMYTNUdVhGWFE0Y2M2dEdi?=
 =?utf-8?B?cm5VdG1zeXYrSUhBSmVRdkw4aXZwVEpzSnMzUnpUc0JpMkZUSUg2b1VmYW56?=
 =?utf-8?B?ZGNBS1FjNmkvN1FIR3R6UDVWN2dFNmhvNFRDNG1wdU4rd0J2VGx5ZDJrWEYy?=
 =?utf-8?B?QmdwRmtlMWxiTmNzVlMzTW1vMW0ybHRNUXp3aFlHbzJmd0JnZU4yQ1NPZHZF?=
 =?utf-8?B?WVpOVDBXOVZLdDRBQVNYcVdkYWYvaDFUcmw1NWxjb3dsWDZnVHlwOEpuNzdB?=
 =?utf-8?B?dktRZ3J2RlRJSU1XRTIwOXpIbFhoeDJVYnpoVjlpTFdwc0tWblVkc0FWTGVw?=
 =?utf-8?B?YnNnQ2tUM1poRklSQkY5RFpRVkNnUHlXR3Z6eWlDVjRYRVpLNXpLYXdYRHB1?=
 =?utf-8?B?ZEdLTnJqUzdDY1cvRmc4cWJGQVJnRTVFZEMwMTdhQlNwV1dRWnZzajlPOXBV?=
 =?utf-8?B?UC9LWUJDU0JFL2tZMW56VXN5ZzhHYUtId2oyT1FSQS8zaGpMRnNpVzV1NEFi?=
 =?utf-8?B?UnlDVisyUmV3NTVZUkhVM2xSMGxzUlM3Z1RKb0ZUc3RiV0xlVVAxVko1bDFa?=
 =?utf-8?B?MHpvUnd5SHNvc2RzY2t4a1J3VElWNU5vRGNUYjdDSGd1K3Q5SmdvdHJHaUFP?=
 =?utf-8?B?SXg4ZHJjYlIvek5rTENQR29SdngwYTlhNWY0dENTZ0c3b2E2RkZvUUd1eHlC?=
 =?utf-8?B?dFAyOVpEK3VFTXFHV3dpdGtOcUczY3dIbjZoRDVlYTlFMXhXWEVCVlI0ejJJ?=
 =?utf-8?B?N3hYcjB6ZTRVQ0pFbkhpM2NEczdJaXA2aGlNMFVGS2VXOU1tTVMyRFM4cXVK?=
 =?utf-8?B?ZWdwTklMVGRSNVBjVkZuamEwK2c1aDZwcUgwbm4xeWV4eG5yZlRVOHE5NEhJ?=
 =?utf-8?B?RWlHQTZzc0E3MHRseW1LZjAyMTlXcWIxQi9ER1Z2NS9lSk93NUk1VjI1dWE2?=
 =?utf-8?B?cUtOd21iUmFLVW94QWdDMGdtSUxDWVZCR0ttV0hsUTRlcmZIMTNjTFpTQStw?=
 =?utf-8?B?c2pQb2hNMmxOc0VpRVJXNUlOWklFbVA2UjdRcjZkL3JXTDFDLzVHWVRLaVJH?=
 =?utf-8?B?bTdDNm52ZVJ2OUQwTFRDODJJTG9ZbGNNU1Q4VWM5d0pKUWwyMno1L3JUT3E5?=
 =?utf-8?B?QmZJNHlJU1V2SkUzeUQyTk02L3hKbnNUSkUwczVmRkI2akNBcDRBME1jeTJq?=
 =?utf-8?B?ZXZrTW0rbkpLeStkelVIQXRaa2xoZnU4N0J6OWk3TFJXRnVWUkZFZVpEenk5?=
 =?utf-8?B?MkJUMFc4d0tPaGVaWDIrTkVmaDNGSDVIaUl5OHJ2bEovTVhCTUJGQTdWL0dK?=
 =?utf-8?Q?Cf4c7ZCoUqRF97orZmfFWFo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3256.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c69310-9b06-4899-c5d3-08d9b19a1ce6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2021 11:36:11.6412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ohaaqfof/u7uBIHBE9Mj79d70a0t1+NBk5LwcuKYaV+HyVFT6swK6OsAzk9sUO8g8OhnwshzPBSv+d/AGBvFWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4784
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBHdW8gWmhlbmdrdWkgPGd1b3po
ZW5na3VpQHZpdm8uY29tPiANClNlbnQ6IFRodXJzZGF5LCBOb3ZlbWJlciAxOCwgMjAyMSAxMDoz
MSBQTQ0KVG86IFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZhZWxAa2VybmVsLm9yZz4NCkNjOiBNb29y
ZSwgUm9iZXJ0IDxyb2JlcnQubW9vcmVAaW50ZWwuY29tPjsgV3lzb2NraSwgUmFmYWVsIEogPHJh
ZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tPjsgTGVuIEJyb3duIDxsZW5iQGtlcm5lbC5vcmc+OyBB
Q1BJIERldmVsIE1hbGluZyBMaXN0IDxsaW51eC1hY3BpQHZnZXIua2VybmVsLm9yZz47IG9wZW4g
bGlzdDpBQ1BJIENPTVBPTkVOVCBBUkNISVRFQ1RVUkUgKEFDUElDQSkgPGRldmVsQGFjcGljYS5v
cmc+OyBMaW51eCBLZXJuZWwgTWFpbGluZyBMaXN0IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnPjsga2VybmVsIDxrZXJuZWxAdml2by5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBBQ1BJ
Q0E6IGZpeCBzd2FwLmNvY2NpIHdhcm5pbmcNCg0KT24gMjAyMS8xMS8xOCAyMjo0NiwgUmFmYWVs
IEouIFd5c29ja2kgd3JvdGU6DQo+IE9uIFR1ZSwgTm92IDksIDIwMjEgYXQgMjo0NyBQTSBHdW8g
WmhlbmdrdWkgPGd1b3poZW5na3VpQHZpdm8uY29tPiB3cm90ZToNCj4+DQo+PiBGaXggZm9sbG93
aW5nIHN3YXAuY29jY2kgd2FybmluZzoNCj4+IC4vZHJpdmVycy9hY3BpL2FjcGljYS9uc3JlcGFp
cjIuYzo4OTY6MzMtMzQ6IFdBUk5JTkcgb3Bwb3J0dW5pdHkgZm9yIA0KPj4gc3dhcCgpDQo+Pg0K
Pj4gU2lnbmVkLW9mZi1ieTogR3VvIFpoZW5na3VpIDxndW96aGVuZ2t1aUB2aXZvLmNvbT4NCj4g
DQo+IFRoaXMgY2hhbmdlIG5lZWRzIHRvIGJlIHN1Ym1pdHRlZCB0byB0aGUgdXBzdHJlYW0gQUNQ
SUNBIHByb2plY3QgdmlhIA0KPiBodHRwczovL2dpdGh1Yi5jb20vYWNwaWNhL2FjcGljYS8NCj4g
DQo+IFRoYW5rcyENCg0KU28gaXQgbWVhbnMgSSBuZWVkIHRvIHN1Ym1pdCB0aGlzIHBhdGNoIHRv
IHVwc3RyZWFtIEFDUElDQSBwcm9qZWN0LCBub3QgbGludXgtbmV4dD8NCg0KDQpUaGUgYW5zd2Vy
IGlzIHllcy4NCkJvYg0KDQoNCj4gDQo+PiAtLS0NCj4+ICAgZHJpdmVycy9hY3BpL2FjcGljYS9u
c3JlcGFpcjIuYyB8IDYgKystLS0tDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KyksIDQgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS9hY3Bp
Y2EvbnNyZXBhaXIyLmMgDQo+PiBiL2RyaXZlcnMvYWNwaS9hY3BpY2EvbnNyZXBhaXIyLmMgaW5k
ZXggMTRiNzFiNDFlODQ1Li4wMmE5MDRjYTRjYWYgDQo+PiAxMDA2NDQNCj4+IC0tLSBhL2RyaXZl
cnMvYWNwaS9hY3BpY2EvbnNyZXBhaXIyLmMNCj4+ICsrKyBiL2RyaXZlcnMvYWNwaS9hY3BpY2Ev
bnNyZXBhaXIyLmMNCj4+IEBAIC04LDYgKzgsNyBAQA0KPj4gICAgKg0KPj4gICAgDQo+PiAqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioNCj4+ICoqKioqKioqLw0KPj4NCj4+ICsjaW5jbHVkZSA8bGludXgvbWlubWF4Lmg+
DQo+PiAgICNpbmNsdWRlIDxhY3BpL2FjcGkuaD4NCj4+ICAgI2luY2x1ZGUgImFjY29tbW9uLmgi
DQo+PiAgICNpbmNsdWRlICJhY25hbWVzcC5oIg0KPj4gQEAgLTg3NSw3ICs4NzYsNiBAQCBhY3Bp
X25zX3NvcnRfbGlzdCh1bmlvbiBhY3BpX29wZXJhbmRfb2JqZWN0ICoqZWxlbWVudHMsDQo+PiAg
IHsNCj4+ICAgICAgICAgIHVuaW9uIGFjcGlfb3BlcmFuZF9vYmplY3QgKm9ial9kZXNjMTsNCj4+
ICAgICAgICAgIHVuaW9uIGFjcGlfb3BlcmFuZF9vYmplY3QgKm9ial9kZXNjMjsNCj4+IC0gICAg
ICAgdW5pb24gYWNwaV9vcGVyYW5kX29iamVjdCAqdGVtcF9vYmo7DQo+PiAgICAgICAgICB1MzIg
aTsNCj4+ICAgICAgICAgIHUzMiBqOw0KPj4NCj4+IEBAIC04OTIsOSArODkyLDcgQEAgYWNwaV9u
c19zb3J0X2xpc3QodW5pb24gYWNwaV9vcGVyYW5kX29iamVjdCAqKmVsZW1lbnRzLA0KPj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB8fCAoKHNvcnRfZGlyZWN0aW9uID09IEFDUElfU09S
VF9ERVNDRU5ESU5HKQ0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJiYgKG9i
al9kZXNjMS0+aW50ZWdlci52YWx1ZSA8DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgb2JqX2Rlc2MyLT5pbnRlZ2VyLnZhbHVlKSkpIHsNCj4+IC0gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgdGVtcF9vYmogPSBlbGVtZW50c1tqIC0gMV07DQo+PiAtICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGVsZW1lbnRzW2ogLSAxXSA9IGVsZW1lbnRzW2pdOw0K
Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbGVtZW50c1tqXSA9IHRlbXBfb2Jq
Ow0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzd2FwKGVsZW1lbnRzW2ogLSAx
XSwgZWxlbWVudHNbal0pOw0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgIH0NCj4+ICAgICAg
ICAgICAgICAgICAgfQ0KPj4gICAgICAgICAgfQ0KPj4gLS0NCj4+IDIuMjAuMQ0KPj4NCg==
