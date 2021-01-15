Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16AE52F70DE
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Jan 2021 04:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732437AbhAODSh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Jan 2021 22:18:37 -0500
Received: from mga12.intel.com ([192.55.52.136]:59605 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732439AbhAODSg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 14 Jan 2021 22:18:36 -0500
IronPort-SDR: HnOOzriK6NNV5RJtCqdVnuwVaeSV+qFsmGF0ohOkOSpJ+bnEFJysfBOrTqEgB7dm0XkE6BhARZ
 UsL+9MMLQGfA==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="157668826"
X-IronPort-AV: E=Sophos;i="5.79,348,1602572400"; 
   d="scan'208";a="157668826"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 19:17:55 -0800
IronPort-SDR: CDK0awQXDARpbMWyDRm/A19oc+K5HPMkBGFAbC5TO9ZFLdY7gToQ/MspXYemAOjsR2NeaauRH5
 CdZCJt328gyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,348,1602572400"; 
   d="scan'208";a="398248889"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 14 Jan 2021 19:17:55 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 14 Jan 2021 19:17:55 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 14 Jan 2021 19:17:55 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 14 Jan 2021 19:17:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9kmBss9N8KjpR8LdeHQZCijId3I6B4vorOyhqnxKABtkkjRt9geTYNQ3s81NLLh3sBSLh39IGZY4hORFOR8mZ1wWzWoQ449jkw/hiFLXWrJz6etU39JpIhLEq7XznS1R+7TomkF03GNJQMa2b1jCIzgTVoZqxDtjm2RSNrcJNTbMyDdmkIvHiWY0dGuCKExixjuiF246xgN8UwemuxlXb+XwAuqGNWE3FLqgIgKTs6/C9dT9ist7zFN0uGXOFcxKB0JQKoRhkfv+P2Z34FjGiydr8hsTRzHcqMaL7QHdAuyZN4LdIXRtaetY+C5FN5EaTfQU3djwEyJZ9pgv1iSjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3YqeHsparnziMq6jZRmPgAfd1Fc125hyXJcz0L5OA8=;
 b=GV0yijKW+xjYxuXNoovYbsH2M3F7w1/U+8WQZ3ySbwNMdUXVjxTc9KwteOE4EoAHv9Cxe6Z+snIDUS7ZZRKwtoi/O90wxDXXfD/9dlYy6865ucDxeP+txakmJ+lCg1bvItBqRe479HMfMCWHpEf4KRxUYlSG+0j81e1gc6Ic4dcWHqX+JkjYtOAF+SNVFuHqRrUjPeCBJSpYGPPC6WiaBXRIO5UmzqtBKRjGjdqS/2C+oU0xCcSQ35wnkTOiOETB9ekZKKNdhpCeuVsKfcryCUjCSQy6IS2GsJPmUL9+a8wDr1pusKkcqYHTAh1Z9GmGEyuRCXySFqbAtj2NvYW/pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3YqeHsparnziMq6jZRmPgAfd1Fc125hyXJcz0L5OA8=;
 b=d5yeZ2eZdlO3mRDj2W1xGgtaMOat+SIXEyh7t8sMQoop2NyjScTa4RQkp7AqUE+lPDKE0Cq6GvZelZOZMJyw7RvyjF/EWAGSCC8T6waBbA+vfuTKMmzYc4P8dAn06JbQFCRDk8GptHht04BURR3zlKJKStUfXyeVneXdDXd8yME=
Received: from BYAPR11MB3448.namprd11.prod.outlook.com (2603:10b6:a03:76::21)
 by BYAPR11MB3557.namprd11.prod.outlook.com (2603:10b6:a03:b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Fri, 15 Jan
 2021 03:17:52 +0000
Received: from BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::8004:3bed:cc13:e8ae]) by BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::8004:3bed:cc13:e8ae%7]) with mapi id 15.20.3742.012; Fri, 15 Jan 2021
 03:17:52 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Widawsky, Ben" <ben.widawsky@intel.com>,
        "Douglas, Chet R" <chet.r.douglas@intel.com>
Subject: Re: ACPI Working Group Code First ECR for a new CXL Root Object
Thread-Topic: ACPI Working Group Code First ECR for a new CXL Root Object
Thread-Index: AQHWybClBaIPKwEtiUmr0E2A2oaIeaooRqKA
Date:   Fri, 15 Jan 2021 03:17:52 +0000
Message-ID: <ab06ae5c27a222ec261195e291ecadf655aedeb2.camel@intel.com>
References: <ecfd911dc8b9a5bac89d1de68047400d15525232.camel@intel.com>
In-Reply-To: <ecfd911dc8b9a5bac89d1de68047400d15525232.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.2 (3.38.2-1.fc33) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.139.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6eff04e7-fcec-48b5-3835-08d8b904250c
x-ms-traffictypediagnostic: BYAPR11MB3557:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB3557CA6354D1071CD0EE9F00C7A70@BYAPR11MB3557.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bMceuDi5BrtDA2ZIzT7mYtbatUcoK1W5DMwFcWkRjh/iNwh7m+msoT0XGg1JiaSIZogtGJ1nm5AxT35wcDQDJMxjDMOf2iFYbE4Nz92C2wiwtNPJ5bpoFNY+/I+gEb9KCUWNIXonN1P3814zXAxHXr8J6LyojbXijrgTP7n6XqffkegXbMHjZMmSNsCWV98KI/YUYuNGbUAiVVx08SmCmpTLoqvu7+ZW6LmaXjv6ao8R4Nywwi998da58khBjSnRJipGe8mPVtOHKfVwLMIEHarMEBiBCo6u5qDA6351JkUlD3qJ2qMKLE44/V7eHWSMZqAuDub1YRv4iu8x7VzGlDye6viCojHiR08KhVlBlMx+DEtJp2ljiDlfv6HZ5JYJDfIwcllpmo3jcI9lPGJgGhgExdpmaMxdNxTSp0w+ZauRG1n2En7vk0JOsp0+i40X2/1FTdDz9tgYHXDS20kb/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3448.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(478600001)(2616005)(966005)(2906002)(6486002)(66476007)(66556008)(91956017)(86362001)(5660300002)(71200400001)(54906003)(6512007)(8676002)(76116006)(186003)(26005)(6506007)(36756003)(66946007)(316002)(8936002)(66446008)(64756008)(4326008)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?M0dxanhabGU2cXZ3a2VuOXc4djNxTUJOTUJQenRWWmZFQW8rN2R4M1NXc1kx?=
 =?utf-8?B?b1pGRHA5bElkMmpRcjJkWG5Uay9Jc1hXQ0dxT1U1b0dSeGpEMVoxRjBEZWZE?=
 =?utf-8?B?R3Q5NWxXQlNVNm9xd3p2eGJlOTRIVER2OGYzend2MTZKdjU2SXd5Q05YYnpy?=
 =?utf-8?B?c0I2VXpod3Uwb3JTT1dlQU9ENVAxR3B2eTlWN2ZPZHdTUTJvME9NWllYTmhR?=
 =?utf-8?B?S3UrdVBYdndqY3Fld0NSSTdWbWVEaGk2SDkxS0IxZ1M1NndPeU5IQThLSmdm?=
 =?utf-8?B?dW0zV0JIMFgyVzZsemFtMCtBZGQrcHJpRnhDTVdvdEl0TFdQbDFyaTRkY1Ax?=
 =?utf-8?B?Y21VbFIwZUl5QTZXZUdFblludHFwcXpQN3hmZE96Nk1pN1ZlVGxYMjA0Zzli?=
 =?utf-8?B?d05icE1nbGlJTUcwUS9oajhwQzlseDREWE14RUdSNXF0WEFmSy9kYU5rUnI5?=
 =?utf-8?B?eEJ0VjRCZWlnNloxLzFWUTUrT1liRCtXZEtFSHlwT0g3LzVKOWNpc0VzZ0lF?=
 =?utf-8?B?SXU0akJTRXV2S2MyelRsYkVENENPVVlDVXp6YWJ6RmF3VVBPTTE3aUpmeWxT?=
 =?utf-8?B?Nk1MclBpT1RkMTF0RmFLbEU3YjRWOUlWeW5rL0FKaVNHV2FHN3RvMXB0bXZN?=
 =?utf-8?B?WWg3bE5MR2pCUEgxVmtVMHZLTkcreTNrQUk4QWVkMVRneVh3dnNIMVgyRmF3?=
 =?utf-8?B?Q2h0YmplZ1VtUkp3RUZ0Zi82TGV4eGE3Q05vWUNQU09iRGxzWTBUNVo2bEh2?=
 =?utf-8?B?N3pUcUhlbnAvVUN3UFI0TXRtK2lJUU0xdFZ0dmp1Sm53Wno3RzR1ZHR0azFP?=
 =?utf-8?B?NG8zRjFmUWd4NzZXUTVBVWhsMU1Teks3cWwwWFFOdGIyMXBtS2piUWk2Y1pI?=
 =?utf-8?B?R1haakttSUxtVjBJTElHTmdNbVdjcFFOMUs3YTNxdkxrNmlTcDQxWUVQY3RO?=
 =?utf-8?B?Umt1bkJKMUVPTWZ2aWRWTUxNdWhLNjBJdkE5dnRMdDRUMFVUeDFGdlV4UExU?=
 =?utf-8?B?cFlBa1ozeGg0TjV6eXZ6RkhWMGV2aXQ0czNta3FHMC81dVg3N21jSVBxamV1?=
 =?utf-8?B?aDRhQmVMbHlURlNTLzZJblkwblR0U3lnbjlsZE8yekhub1FDcmRBOFR1bEtm?=
 =?utf-8?B?M1I5STFRS0k2czZQUnJKdTFjdWNuRUhFMmVBV1FRZFB4RlVGU2pDNnd5aVly?=
 =?utf-8?B?STVjc2hvcS9Odm1FY2Y2VVh2ZWxKeTFCd2IyUmd4ejFmelI2SGJTNXltRVdE?=
 =?utf-8?B?NGJrSVU5UjVtK2hrU3FTSG9YRmJ1UEMrbGZpNWJ4V2I4OHVOMXpGcUNpSlRZ?=
 =?utf-8?Q?R+tD7Cr8jZyCqzPX9sLTD4yBsh2dOqlEl2?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <00B3DCFDAB44DE438CAD5986C28C7947@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3448.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eff04e7-fcec-48b5-3835-08d8b904250c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2021 03:17:52.3801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zaoD3+ZQZzRUsKB+wbXSS/AW8q+ps1AhkyT65aT/DnPUbjsiZTnSS/edVvUTmB7gvtYEb45d8VjtZiIWCqOmt8NIuwmrNibsOctwdKhMNWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3557
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

T24gVGh1LCAyMDIwLTEyLTAzIGF0IDIwOjEyICswMDAwLCBWZXJtYSwgVmlzaGFsIEwgd3JvdGU6
DQo+IFRoaXMgaXMgYSBwdWJsaWMgUkZDIG9mIGFuIEFDUEkgcHJvcG9zYWwgdG8gYWRkIGEgbmV3
IENYTCBSb290IE9iamVjdA0KPiB0aGF0IGluZGljYXRlcyB0aGUgcHJlc2VuY2Ugb2YgYSBDWEwg
aGllcmFyY2h5LiBUaGUgcHJvcG9zYWwgaXMgYmVpbmcNCj4gbWFkZSBpbiB0aGUgbmV3ICdDb2Rl
IEZpcnN0JyB3b3JrZmxvdyBvZiB0aGUgQUNQSSBTcGVjIFdvcmtpbmcgR3JvdXAuDQo+IFRoZSBz
dWJqZWN0IG1hdHRlciBoZXJlIGhhcyBiZWVuIGV4cGxvcmVkIGluIHByZXZpb3VzbHkgcG9zdGVk
IHBhdGNoZXMNCj4gdG8gUUVNVVsxXSBhcyB3ZWxsIGFzIExpbnV4WzJdLiBUaGVzZSBwYXRjaGVz
IGhhdmUgc2VydmVkIGFzIGEgcHJvb2Ytb2YtDQo+IGNvbmNlcHQgdGVzdCB2ZWhpY2xlIHRvIGhl
bHAgZW5zdXJlIHRoYXQgdGhlIHByb3Bvc2FsIHdvcmtzIGluIHByYWN0aWNlLg0KPiBUaGUgY292
ZXIgbGV0dGVyIGluIHNlcmllcyBbMl0gZ29lcyBpbnRvIGFkZGl0aW9uYWwgZGV0YWlsIChzZWN0
aW9uDQo+IHRpdGxlZCAnQUNQSTAwMTcnKSBmb3IgdGhlIHJlYXNvbmluZyBiZWhpbmQgdGhlIHBy
b3Bvc2FsLCBhbmQgd2hhdCBpcw0KPiBuZWVkZWQgYmV5b25kIHdoYXQncyBkZXNjcmliZWQgaW4g
dGhlIENYTCAyLjAgc3BlYy4NCj4gDQo+IFRoZSBjaGFuZ2UgcHJvcG9zYWwgdGhhdCBmb2xsb3dz
IGlzIGluIG1hcmtkb3duIGZvcm1hdC4NCj4gDQo+IFsxXTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvcWVtdS1kZXZlbC8yMDIwMTExMTA1NDcyNC43OTQ4ODgtMS1iZW4ud2lkYXdza3lAaW50ZWwu
Y29tLw0KPiBbMl06IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWN4bC8yMDIwMTExMTA1
NDM1Ni43OTMzOTAtMS1iZW4ud2lkYXdza3lAaW50ZWwuY29tLw0KPiANCj4gLS0tLQ0KPiANCj4g
IyBUaXRsZTogQWRkIENYTCBSb290IE9iamVjdCBfSElEDQo+IA0KPiAjIFN0YXR1czogRHJhZnQN
Cg0KVGhpcyBFQ1Igd2FzIGFwcHJvdmVkIGluIHRoZSBBU1dHIHRvZGF5IHdpdGhvdXQgYW55IG1v
ZGlmaWNhdGlvbnMsIGFuZA0KdGhpcyBjb250ZW50IGNhbiBiZSBleHBlY3RlZCB0byBiZSBwcmVz
ZW50IGluIHRoZSBuZXh0IHJlbGVhc2Ugb2YgdGhlDQpzcGVjaWZpY2F0aW9uLg0KDQo+IA0KPiAj
IERvY3VtZW50OiBBQ1BJIFNwZWNpZmljYXRpb24gNi40DQo+IA0KPiAjIExpY2Vuc2UNCj4gU1BE
WC1MaWNlbnNlIElkZW50aWZpZXI6IENDLUJZLTQuMA0KPiANCj4gIyBTdWJtaXR0ZXI6DQo+ICog
U3BvbnNvcjogVmlzaGFsIFZlcm1hLCBJbnRlbA0KPiAqIENyZWF0b3JzL0NvbnRyaWJ1dG9yczoN
Cj4gwqDCoMKgwqAqIENoZXQgRG91Z2xhcywgSW50ZWwNCj4gwqDCoMKgwqAqIEJlbiBXaWRhd3Nr
eSwgSW50ZWwNCj4gwqDCoMKgwqAqIERhbiBXaWxsaWFtcywgSW50ZWwNCj4gwqDCoMKgwqAqIFZp
c2hhbCBWZXJtYSwgSW50ZWwNCj4gDQo+ICMgU3VtbWFyeSBvZiB0aGUgQ2hhbmdlDQo+IEFkZCDi
gJxDb21wdXRlIEV4cHJlc3MgTGluayBSb290IE9iamVjdOKAnSBlbnVtZXJhdGlvbiB2YWx1ZSB0
byB0aGUgQUNQSQ0KPiBEZXZpY2UgSURzIFRhYmxlICg1LjE2MCkuDQo+IA0KPiAjIEJlbmVmaXRz
IG9mIHRoZSBDaGFuZ2UNCj4gQ29tcHV0ZSBFeHByZXNzIExpbmsgKENYTCkgaXMgYSBuZXcgaGln
aC1zcGVlZCBDUFUtdG8tRGV2aWNlIGFuZCBDUFUtdG8tDQo+IE1lbW9yeSBpbnRlcmNvbm5lY3Qu
IFRoZSBuZXcgQUNQSSBEZXZpY2UgSUQgcmVwcmVzZW50cyBhIHNpbmdsZXRvbg0KPiBkZXZpY2Ug
dGhhdCBhbGxvd3MgdGhlIE9TUE0gdG8gdHJpZ2dlciB0aGUgZW51bWVyYXRpb24gb2YgdGhlIENY
TC5tZW0NCj4gYWRkcmVzcyBzcGFjZSwgYW5kIGluZGljYXRlcyB0aGUgcHJlc2VuY2Ugb2YgY3Jv
c3MgSG9zdCBCcmlkZ2UNCj4gKEFDUEkwMDE2KSBpbnRlcmxlYXZlZCBDWEwubWVtIHJlc291cmNl
cy4NCj4gDQo+ICMgSW1wYWN0IG9mIHRoZSBDaGFuZ2UNCj4gT25lIG5ldyByb3cgYWRkZWQgdG8g
dGhlIEFDUEkgRGV2aWNlIElEcyB0YWJsZSAoNS4xNjApLg0KPiANCj4gIyBSZWZlcmVuY2VzDQo+
ICogQ29tcHV0ZSBFeHByZXNzIExpbmsgU3BlY2lmaWNhdGlvbiB2Mi4wLA0KPiA8aHR0cHM6Ly93
d3cuY29tcHV0ZWV4cHJlc3NsaW5rLm9yZy8+DQo+IA0KPiAjIERldGFpbGVkIERlc2NyaXB0aW9u
IG9mIHRoZSBDaGFuZ2UNCj4gDQo+IEFkZCDigJxDb21wdXRlIEV4cHJlc3MgTGluayBSb290IE9i
amVjdOKAnSBlbnVtZXJhdGlvbiBkZXZpY2UNCj4gDQo+ICMjIyA1LjYuNyBEZXZpY2UgQ2xhc3Mt
U3BlY2lmaWMgT2JqZWN0cw0KPiANCj4gTW9zdCBkZXZpY2Ugb2JqZWN0cyBhcmUgY29udHJvbGxl
ZCB0aHJvdWdoIGdlbmVyaWMgb2JqZWN0cyBhbmQgIC4uLg0KPiANCj4gVGFibGUgNS4xNjAgQUNQ
SSBEZXZpY2UgSURzDQo+IA0KPiA+IFZhbHVlIHwgRGVzY3JpcHRpb24gfA0KPiA+IDotLS0gfCA6
LS0tOiB8IDotLS06IHwgOi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSB8DQo+ID4gLi4gfCAu
LiB8DQo+ID4gQUNQSTAwMTcgfCAqKkNvbXB1dGUgRXhwcmVzcyBMaW5rIFJvb3QgT2JqZWN0Oioq
IFRoaXMgZGV2aWNlDQo+IHJlcHJlc2VudHMgdGhlIHJvb3Qgb2YgYSBDWEwgY2FwYWJsZSBkZXZp
Y2UgaGllcmFyY2h5LiBJdCBzaGFsbCBiZQ0KPiBwcmVzZW50IHdoZW5ldmVyIHRoZSBwbGF0Zm9y
bSBhbGxvd3MgT1NQTSB0byBkeW5hbWljYWxseSBhc3NpZ24gQ1hMDQo+IGVuZHBvaW50cyB0byBh
IHBsYXRmb3JtIGFkZHJlc3Mgc3BhY2UuIHwNCj4gDQo+ICMjIFNwZWNpYWwgSW5zdHJ1Y3Rpb25z
DQoNCg==
