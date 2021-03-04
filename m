Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE14132D8B0
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Mar 2021 18:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238054AbhCDRh5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Mar 2021 12:37:57 -0500
Received: from mga02.intel.com ([134.134.136.20]:1909 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239217AbhCDRhx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 4 Mar 2021 12:37:53 -0500
IronPort-SDR: Tj6eHcRL4uehtWABBX4EaMpBXVvje6O+8M8hZ1orHZMw9LZT5J38k3Jylz+duO6W/33nTINCFv
 t/QXIS/2Cpgg==
X-IronPort-AV: E=McAfee;i="6000,8403,9913"; a="174579771"
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="scan'208";a="174579771"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 09:37:08 -0800
IronPort-SDR: KJzydKRy94ZGK8f5bDwFohvFYd9sAZ+WiQ7aMUaiMC7iO5JXKAA+TBMh8amC/D93j1t+LjWfXB
 tQiz4XxzZN7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="scan'208";a="507473447"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga001.fm.intel.com with ESMTP; 04 Mar 2021 09:37:02 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 4 Mar 2021 09:37:02 -0800
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 4 Mar 2021 09:37:01 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Thu, 4 Mar 2021 09:37:01 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Thu, 4 Mar 2021 09:37:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGhAcSj+g7wHLdvkFJWBP3YOalPJx751ajKWCaiKaBYYVPkwaoVGLjJ+tLHbJLTnw+buKvkWL7WrCpyBC75bxRGZm1QJKIRgNPsiVKyMzI9tMwVCVSk7CR0ULLGqABX6SYu6c2HxjuWhwGrvAF3/0Sl8rJWwO1YaTzv0hKf0XNXhm+IaZZxPiLgtHIv0tEi3gpEQMjQwavlDwN8RyOnvIsGS2utMJZWtbY3QhL1JKSZO0O9jDcOkD2fnfvHOA+PsSHAC60saN380+jgGbKWnFZLf4p1GlKwhWO5vAOFs9s5s4jje8S6QIHwP+rBxONmqGTVVSRC5LevP8p6u7RkufQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3YTsINS2Dsl1gdK0SIcb+pxsYe1BO4R/Pdrbs3WMn/Q=;
 b=khnY/XL0o3bgApMpoyt8ijDTs/XCH9kdtyM7qW/f0M0cTivyBnZpWhU9qPVZ1qFuj3gqdNr5cyz2STXicJT7JBxiFkYqGCa1fGJkIXBpAoTN8InFzORVY72xhDa+oZuubJ7tzpiaEt3HaEvHUYqYMVKlu/8NWoBZEaZ1LuMvp2kvP2xRVVBGYgjHcyFgcw5waB/TJJVm7jUkKSoOhCvPTRBR818/qKNommbjn1Kaei5nkLK0JAZodYdfQnwT0b8A6eJk/tsPwKW6CTAdCQefBYrq+uQKD8ced8oSfzPJdbdYlz6ZHJANaYA/uGxYCmJfjjvwOK6rqYiKGwI+IfoASQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3YTsINS2Dsl1gdK0SIcb+pxsYe1BO4R/Pdrbs3WMn/Q=;
 b=X25b4J6vA6nVAtFTd/sT/i7Qo+0+OIj2WAbSggDHqDNl3B1eaNIygfPjSN212ch7UjdVNkwNJKeLC7W0KIK4mTjmcMfHV/ZrV/H6jM1JCbfDUM592R1tKO3pOTdLFgzvxz4hkeYQvbSsEw4r1V87ju944JKfmDp4ZcnycMau0eE=
Received: from BYAPR11MB3256.namprd11.prod.outlook.com (2603:10b6:a03:76::19)
 by SJ0PR11MB5184.namprd11.prod.outlook.com (2603:10b6:a03:2d5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Thu, 4 Mar
 2021 17:36:58 +0000
Received: from BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::ac1e:2d22:3f90:4dc]) by BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::ac1e:2d22:3f90:4dc%7]) with mapi id 15.20.3890.032; Thu, 4 Mar 2021
 17:36:58 +0000
From:   "Moore, Robert" <robert.moore@intel.com>
To:     "weidongcui@gmail.com" <weidongcui@gmail.com>
CC:     "Kaneda, Erik" <erik.kaneda@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Xinyang Ge <aegiryy@gmail.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: RE: [PATCH] Enable ACPI_ADR_SPACE_PCI_CONFIG in
 acpi_gbl_default_address_spaces only when ACPI_PCI_CONFIGURED is defined
Thread-Topic: [PATCH] Enable ACPI_ADR_SPACE_PCI_CONFIG in
 acpi_gbl_default_address_spaces only when ACPI_PCI_CONFIGURED is defined
Thread-Index: AQHW/pI3ruT7cwkxjEOUSsZ8OrOy5apyuR4AgAF306CAAANRAIAABwjQ
Date:   Thu, 4 Mar 2021 17:36:58 +0000
Message-ID: <BYAPR11MB3256FD804E3F3CE584B6D3B387979@BYAPR11MB3256.namprd11.prod.outlook.com>
References: <20210209031744.26474-1-weidongcui@gmail.com>
 <MWHPR11MB1599D81078925FFD128E954EF0989@MWHPR11MB1599.namprd11.prod.outlook.com>
 <BYAPR11MB325658379DB73F6EEDD6C76F87979@BYAPR11MB3256.namprd11.prod.outlook.com>
 <CADFYyO73g8LkgwZv4m5N2bXq0XcZru4m9+K0uudCLmcp7yewpQ@mail.gmail.com>
In-Reply-To: <CADFYyO73g8LkgwZv4m5N2bXq0XcZru4m9+K0uudCLmcp7yewpQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.136.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c49d1023-8df8-417c-77e3-08d8df341c9c
x-ms-traffictypediagnostic: SJ0PR11MB5184:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB5184C09832CFDA607D33C1B987979@SJ0PR11MB5184.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Les5q1jmkMGrpx8mtqdRVUIQljPqnk9PAJdQQ2wQYWTXtZas25IJRH4PE2KKm917/T6W+WvRvY+3mqA/w3ZtCyOBeRVg+iyb0zCrdfEDYmBmiR7ej0QxhFI0v48bI0ulKnfr4gUl0q0iFzlGUWB0Id1rIXsL9MNYxG9xp9TwvEwtsEtQ2KoHAC/VrYI75lgm+2A6fAcnmmYFpHcBXlvS53VLTUuFprYOPAtinnjf1mfltkOtNzTkgoWL579ejOV1FnkAUfm0O01Bw9A7Copyc57K+vf/+FTvNbojwsNpZLSFwGsOJGU2deFSoeD8JfkXastUEJ1RSO9gCzVendHgSRdj7K9u5Fksvxe2RhKCas1d17huBN+w3+g3C3JRyLWPYjid8g9dALMglHNJXHZPWysNB3NRqW87oHkv8+bmIueHgyehknIFXNp1DSKN3byPBRapMkOeb55rOiSkvUrkOUPbDCGUXTdGxvhEDb1dOLW36OpW8qTqP2kGk/7+EKvenkCOJRXoR9CF5vEnzzORIg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3256.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(396003)(366004)(39860400002)(186003)(66946007)(83380400001)(33656002)(2906002)(76116006)(478600001)(71200400001)(55016002)(6506007)(52536014)(316002)(9686003)(86362001)(8676002)(66556008)(8936002)(5660300002)(53546011)(7696005)(4326008)(66446008)(6916009)(26005)(54906003)(66476007)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?dVRPQ3crMHJ0UDBYUFdxS3FTVHI5dnYyQ1paQU9saU1SZTU1U1hLZnplOGpm?=
 =?utf-8?B?Q1ozeS9DVGJOajBuTTJwR2JjbFJxT0JGMGgwNG5pK08yRGRiTUxueGdtaTZM?=
 =?utf-8?B?YysrS1FjODRBZDZ0Rkg1SjFteXFDZSt3c1VWN3R6N09yWS9MM1JaVVU5SDd5?=
 =?utf-8?B?Z1pIckNFaHc5QUVKUEZucCtycXQ3Lyt3TkdBRFF0S2x6cVl0S2FBeTZWUXlB?=
 =?utf-8?B?MGVMZWlTNnhNY0RBeFBNbVFsS3hIN1hsY2wzZy91dVJLSkhpc3dVOFgxZzhs?=
 =?utf-8?B?K0YwOS8vNUdZNGw2M0lYKzV3WmhTb3R6MDhZcUdTQ1BOcnNaOXEvbnJvSU5n?=
 =?utf-8?B?TkVKeEJRNHBjS3JFaE5sY2JMN3MyMEc4YlFoVXM2SE9lT1pqRXNrOHpwVld0?=
 =?utf-8?B?WjlRY3licFg4bFBmVWlqbEk5RlVNTkVpS1R1aXI5eGozNnhycXhJazNqMkZq?=
 =?utf-8?B?dUZva2tjZlcyTnI3OW9lalZheFMvQVNCVS9kM29mdWFLNjR2aHVtNU1NNUlT?=
 =?utf-8?B?NW5oSjkxRTBwcit3YlBmdGNOM1lNWHlRVWxOeSt2blpyNGd0ZEE2T1NWd1oz?=
 =?utf-8?B?MjFRS2Vvby9HYVRqOFRXUVBZckZGM3JwWC9UZEhrVVRhQkpJRUFHNURUdzJw?=
 =?utf-8?B?dWhYbjNGSlNBSUE4b3Jqd3JPWWFjUEtyWHlHSUVNYlMvTlFvMVMzV3ZwWWVW?=
 =?utf-8?B?bFpBejg3U1JRSlRWQTdSRlVKMmtidm9VN2JtWDJBdVlSMmFIMFQ0Qms4dHNp?=
 =?utf-8?B?dDlVdFFjYUNRcTZER3kwYmRPTUNnWkhnSGpVVFhwcGZkeWF5aGNxSGs3dHZH?=
 =?utf-8?B?d1VWU2RVZlQrK21DbTVhSW5MNk5qQkl3aGljcTdqTVhiMUY0dlA5UDVzbm9v?=
 =?utf-8?B?bndNbWpHTzZpcllqdGhTZkVYUzRtRTNsdHJXS2lPZ0FFaGJpazk3cWpUSG90?=
 =?utf-8?B?aVgxbWRKUXBGSktsQVE4bDlMWjV3dXpVOC9JeDQwN3R4bmJjdkxla05UM2Zk?=
 =?utf-8?B?UUhXOFlhMSswZXo3NWVrOFdSeWNOVGM3aVFJWFJmKzlCTzBvQjhwaXZpUEFI?=
 =?utf-8?B?cC9wbDBGZjFaN2QwRkYxZUlzZnl6K2RGZTV6QWN5MGREaWhxenFYcWNVcUNw?=
 =?utf-8?B?ZEtabXlrOVZxMHR1NHVlcDFWc2xZallVZ2RDV2NnZlMrenFsTWNwa2dvMk1a?=
 =?utf-8?B?ZE5oRHRZUTBpOXdHanNLaHNBMzJ3UjgxTkNZU0IzdDJmZGZtNHZxMzZZV3NC?=
 =?utf-8?B?NHJQTzJydEpNNFIrWXNaeHdXTWxpNTJHYmd1cHJoMHFyRkM3ZW1qNmNjR1ZR?=
 =?utf-8?B?UVVmNkFodFEzeWFMRHQza0hSV1FoMmhXdzk3L1VGeHd5S1M0VENQblpEb1pP?=
 =?utf-8?B?cnJ2NWlRY0dFWEY3cU4wSkxVNmtUVDBwS0F4TzZKdkVGaUVTN2dGQ0ZNeHZ1?=
 =?utf-8?B?dEJPTmc5clBrNXMrYi9KcDYwRk9xTzFTc3h0bnBydE91WU00aC9lbUlZRFhI?=
 =?utf-8?B?WVNudjRSa0dhVUhIdGhEeGk1MlRxdEpUeWdBRjFML1lHai9hOFAvNFVONjVr?=
 =?utf-8?B?ZUZJOXU1aVl3ckhHeFJLSFh1NGNuQVhnUi9EUjF0dzVpNVh2ZUJhdlRPZmFn?=
 =?utf-8?B?aVZTNUVzTUwrZm5mOENIdGE3Tnd3ZFlyYkZ0QUErVUpDTTBRWnFSVllnSTda?=
 =?utf-8?B?R1F0UWhEYmFoV2FJNVE1OHVPOHNBRy85KzNjUm4rRUJKdjB5dzFXRUhLYzJ1?=
 =?utf-8?Q?5Ez7dOVyoCcao7IdHzp0lIfKBhVlUqAK3Oh8+1l?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3256.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c49d1023-8df8-417c-77e3-08d8df341c9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2021 17:36:58.0746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /ZeEpnK+K3V6xK6DlvGe1fviPETnj94Qo2JphH2xRprTZmR7vsd/I3VDdAgZ1/0TlG4iFetRDE7aW2NhX58zUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5184
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBXZWlkb25nIEN1aSA8d2VpZG9u
Z2N1aUBnbWFpbC5jb20+IA0KU2VudDogVGh1cnNkYXksIE1hcmNoIDA0LCAyMDIxIDk6MDYgQU0N
ClRvOiBNb29yZSwgUm9iZXJ0IDxyb2JlcnQubW9vcmVAaW50ZWwuY29tPg0KQ2M6IEthbmVkYSwg
RXJpayA8ZXJpay5rYW5lZGFAaW50ZWwuY29tPjsgV3lzb2NraSwgUmFmYWVsIEogPHJhZmFlbC5q
Lnd5c29ja2lAaW50ZWwuY29tPjsgWGlueWFuZyBHZSA8YWVnaXJ5eUBnbWFpbC5jb20+OyBsaW51
eC1hY3BpQHZnZXIua2VybmVsLm9yZzsgZGV2ZWxAYWNwaWNhLm9yZzsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgTGVuIEJyb3duIDxsZW5iQGtlcm5lbC5vcmc+DQpTdWJqZWN0OiBSZTog
W1BBVENIXSBFbmFibGUgQUNQSV9BRFJfU1BBQ0VfUENJX0NPTkZJRyBpbiBhY3BpX2dibF9kZWZh
dWx0X2FkZHJlc3Nfc3BhY2VzIG9ubHkgd2hlbiBBQ1BJX1BDSV9DT05GSUdVUkVEIGlzIGRlZmlu
ZWQNCg0KPiBXZWxsLCBJIGRvbid0IGxpa2UgdGhlIGZhY3QgdGhhdCBQQ0lfQ09ORklHVVJFRCB3
b3VsZCBoYXZlIHRvIGJlIGRlZmluZWQgYnkgZWFjaCBjdXJyZW50IGhvc3Q6DQo+DQo+ID4gKyNp
ZmRlZiBBQ1BJX1BDSV9DT05GSUdVUkVEDQo+DQo+IEkgd291bGQgcmF0aGVyIHRoZSBsb2dpYyBi
ZSByZXZlcnNlZDoNCj4NCj4gPiArI2lmZGVmIEFDUElfUENJX05PVF9DT05GSUdVUkVEDQoNClRo
YW5rIHlvdSBmb3IgdGhlIGNvbW1lbnRzLCBFcmlrIGFuZCBCb2IhDQoNCkFDUElfUENJX0NPTkZJ
R1VSRUQgaXMgZGVmaW5lZCBpbiBhY2xpbnV4LmggKHNlZSBiZWxvdykgYW5kIHVzZWQgaW4gc2V2
ZXJhbCBwbGFjZXMgaW4gZXZoYW5kbGVyLmMgYW5kIGV4cmVnaW9uLmMuDQpJJ20gbm90IHN1cmUg
d2h5IHdlIHdhbnQgdG8gaW50cm9kdWNlIEFDUElfUENJX05PVF9DT05GSUdVUkVELiAgQm9iLCBJ
IGRvbid0IHVuZGVyc3RhbmQgeW91ciBjb25jZXJucyBhYm91dCAiaGF2ZSB0byBiZSBkZWZpbmVk
IGJ5IGVhY2ggY3VycmVudCBob3N0Ii4gIENhbiB5b3UgcGxlYXNlIHNoZWQgc29tZSBsaWdodCBv
biBpdD8NCg0KSXQgaXMgcmVxdWlyZWQgaW4gYWNsaW51eC5oLCBhbmQgdGh1cyBpdCBpcyByZXF1
aXJlZCBpbiBldmVyeSBob3N0LWRlcGVuZGVudCBjb25maWd1cmF0aW9uIGZpbGUgKGFjZnJlZWJz
ZC5oLCBhY21hY29zeC5oLCBhY25ldGJzZC5oLCBhY2hhaWt1LmgsIGV0Yy4pIEkgd291bGQgcmF0
aGVyIG5vdCBmb3JjZSB0aGVzZSBob3N0LXNwZWNpZmljIGhlYWRlciBmaWxlcyB0byBjaGFuZ2Uu
DQpCb2INCg0KDQojaWZkZWYgQ09ORklHX1BDSQ0KI2RlZmluZSBBQ1BJX1BDSV9DT05GSUdVUkVE
DQojZW5kaWYNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLYW5lZGEs
IEVyaWsgPGVyaWsua2FuZWRhQGludGVsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBNYXJjaCAw
MywgMjAyMSAxMDoyOSBBTQ0KPiBUbzogV2VpZG9uZyBDdWkgPHdlaWRvbmdjdWlAZ21haWwuY29t
PjsgTW9vcmUsIFJvYmVydCANCj4gPHJvYmVydC5tb29yZUBpbnRlbC5jb20+OyBXeXNvY2tpLCBS
YWZhZWwgSiANCj4gPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tPg0KPiBDYzogWGlueWFuZyBH
ZSA8YWVnaXJ5eUBnbWFpbC5jb20+OyBsaW51eC1hY3BpQHZnZXIua2VybmVsLm9yZzsgDQo+IGRl
dmVsQGFjcGljYS5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IExlbiBCcm93biAN
Cj4gPGxlbmJAa2VybmVsLm9yZz4NCj4gU3ViamVjdDogUkU6IFtQQVRDSF0gRW5hYmxlIEFDUElf
QURSX1NQQUNFX1BDSV9DT05GSUcgaW4gDQo+IGFjcGlfZ2JsX2RlZmF1bHRfYWRkcmVzc19zcGFj
ZXMgb25seSB3aGVuIEFDUElfUENJX0NPTkZJR1VSRUQgaXMgDQo+IGRlZmluZWQNCj4NCj4gVGhp
cyBsb29rcyBnb29kIHRvIG1lLiBCb2IsIGRvIHlvdSBoYXZlIGFueSBjb21tZW50cz8NCj4NCj4g
RXJpaw0KPg0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogV2VpZG9u
ZyBDdWkgPHdlaWRvbmdjdWlAZ21haWwuY29tPg0KPiA+IFNlbnQ6IE1vbmRheSwgRmVicnVhcnkg
OCwgMjAyMSA3OjE4IFBNDQo+ID4gVG86IE1vb3JlLCBSb2JlcnQgPHJvYmVydC5tb29yZUBpbnRl
bC5jb20+OyBLYW5lZGEsIEVyaWsgDQo+ID4gPGVyaWsua2FuZWRhQGludGVsLmNvbT47IFd5c29j
a2ksIFJhZmFlbCBKIA0KPiA+IDxyYWZhZWwuai53eXNvY2tpQGludGVsLmNvbT47IExlbiBCcm93
biA8bGVuYkBrZXJuZWwub3JnPg0KPiA+IENjOiBXZWlkb25nIEN1aSA8d2VpZG9uZ2N1aUBnbWFp
bC5jb20+OyBYaW55YW5nIEdlIA0KPiA+IDxhZWdpcnl5QGdtYWlsLmNvbT47IGxpbnV4LWFjcGlA
dmdlci5rZXJuZWwub3JnOyBkZXZlbEBhY3BpY2Eub3JnOw0KPiA+IGxpbnV4LSBrZXJuZWxAdmdl
ci5rZXJuZWwub3JnDQo+ID4gU3ViamVjdDogW1BBVENIXSBFbmFibGUgQUNQSV9BRFJfU1BBQ0Vf
UENJX0NPTkZJRyBpbiANCj4gPiBhY3BpX2dibF9kZWZhdWx0X2FkZHJlc3Nfc3BhY2VzIG9ubHkg
d2hlbiBBQ1BJX1BDSV9DT05GSUdVUkVEIGlzIA0KPiA+IGRlZmluZWQNCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFdlaWRvbmcgQ3VpIDx3ZWlkb25nY3VpQGdtYWlsLmNvbT4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBYaW55YW5nIEdlIDxhZWdpcnl5QGdtYWlsLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJp
dmVycy9hY3BpL2FjcGljYS9ldmhhbmRsZXIuYyB8IDIgKysNCj4gPiAgaW5jbHVkZS9hY3BpL2Fj
Y29uZmlnLmggICAgICAgICB8IDQgKysrKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0
aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS9hY3BpY2EvZXZoYW5k
bGVyLmMgDQo+ID4gYi9kcml2ZXJzL2FjcGkvYWNwaWNhL2V2aGFuZGxlci5jIGluZGV4IDU4ODRl
YmEwNC4uNGMyNWFkNDMzIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvYWNwaS9hY3BpY2EvZXZo
YW5kbGVyLmMNCj4gPiArKysgYi9kcml2ZXJzL2FjcGkvYWNwaWNhL2V2aGFuZGxlci5jDQo+ID4g
QEAgLTI2LDcgKzI2LDkgQEAgYWNwaV9ldl9pbnN0YWxsX2hhbmRsZXIoYWNwaV9oYW5kbGUgb2Jq
X2hhbmRsZSwNCj4gPiAgdTggYWNwaV9nYmxfZGVmYXVsdF9hZGRyZXNzX3NwYWNlc1tBQ1BJX05V
TV9ERUZBVUxUX1NQQUNFU10gPSB7DQo+ID4gICAgICAgQUNQSV9BRFJfU1BBQ0VfU1lTVEVNX01F
TU9SWSwNCj4gPiAgICAgICBBQ1BJX0FEUl9TUEFDRV9TWVNURU1fSU8sDQo+ID4gKyNpZmRlZiBB
Q1BJX1BDSV9DT05GSUdVUkVEDQo+ID4gICAgICAgQUNQSV9BRFJfU1BBQ0VfUENJX0NPTkZJRywN
Cj4gPiArI2VuZGlmDQo+ID4gICAgICAgQUNQSV9BRFJfU1BBQ0VfREFUQV9UQUJMRQ0KPiA+ICB9
Ow0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvYWNwaS9hY2NvbmZpZy5oIGIvaW5jbHVk
ZS9hY3BpL2FjY29uZmlnLmggaW5kZXgNCj4gPiBhMjI1ZWZmNDkuLjc5MDk5OTAyOCAxMDA2NDQN
Cj4gPiAtLS0gYS9pbmNsdWRlL2FjcGkvYWNjb25maWcuaA0KPiA+ICsrKyBiL2luY2x1ZGUvYWNw
aS9hY2NvbmZpZy5oDQo+ID4gQEAgLTE2Miw3ICsxNjIsMTEgQEANCj4gPiAgLyogTWF4aW11bSBz
cGFjZV9pZHMgZm9yIE9wZXJhdGlvbiBSZWdpb25zICovDQo+ID4NCj4gPiAgI2RlZmluZSBBQ1BJ
X01BWF9BRERSRVNTX1NQQUNFICAgICAgICAgIDI1NQ0KPiA+ICsjaWZkZWYgQUNQSV9QQ0lfQ09O
RklHVVJFRA0KPiA+ICAjZGVmaW5lIEFDUElfTlVNX0RFRkFVTFRfU1BBQ0VTICAgICAgICAgNA0K
PiA+ICsjZWxzZQ0KPiA+ICsjZGVmaW5lIEFDUElfTlVNX0RFRkFVTFRfU1BBQ0VTICAgICAgICAg
Mw0KPiA+ICsjZW5kaWYNCj4gPg0KPiA+ICAvKiBBcnJheSBzaXplcy4gIFVzZWQgZm9yIHJhbmdl
IGNoZWNraW5nIGFsc28gKi8NCj4gPg0KPiA+IC0tDQo+ID4gMi4yNC4zIChBcHBsZSBHaXQtMTI4
KQ0KPg0K
