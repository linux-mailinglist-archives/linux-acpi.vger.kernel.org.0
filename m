Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 516AD31D009
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Feb 2021 19:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhBPSQZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 Feb 2021 13:16:25 -0500
Received: from mga17.intel.com ([192.55.52.151]:11137 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229999AbhBPSQV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 16 Feb 2021 13:16:21 -0500
IronPort-SDR: TYN/+WluIO/rQpYhANzdfolXZXGl/Q8qwk45xaKIMCVZ+Ok0enGUIC/qBfnnewOIT8xz6HMfdR
 FRZOLQNxO3iA==
X-IronPort-AV: E=McAfee;i="6000,8403,9897"; a="162740621"
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="162740621"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 10:15:40 -0800
IronPort-SDR: 2WxhuIyEjM0fUUOJ38/GblDX+XGysmS3+z2DHiGhhcgGfN5WS+MeCA8Ka3dvB8efg/2tDAFjsy
 2d+32A9AOONg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="512609456"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 16 Feb 2021 10:15:40 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 16 Feb 2021 10:15:39 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 16 Feb 2021 10:15:39 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 16 Feb 2021 10:15:37 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 16 Feb 2021 10:15:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYftq7QDCHO3PwpDQaW2Xi6XeUMtkm+T1biXKCbGEQlrZ86xRO4S92jv8ePZfzDuusyhNg929ycDKuDBFFMexeO/H66KO0RUSWWlr6OTOXcanZsgTngl8kbyEJB6Ju/+dqX+2q0j7CQi4gGOqypgvRI78+BCTFJ9g/wzEeMWt8HXoHL2RqpEdXmy31ta6bO7csrJVGKMVIrOeQ24r/mNBr+x/nb+1luRdFniENwGkiho9JEgA1m/+iIKXDuPx84jFF6eRt3ydPsgAVb3C5MG8LB6oubHlxxZKKa3IbUDQshr0xDt2RTGXt6N/rZ4dToiIQvJUZkjJjJM/dbcv2abcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GZBPgIguM1mcK5tC4BD0nnwKU3OPW7XV+LxlsvXygo=;
 b=iFhbgtrN0CQqXV7mOeLl3PlL5CyuWAS3FG3nwWSgRb1lcmiTFDaMDWXwYIBeg9S+6y3Fuco8DTuA1CxZF/Gy8aBbT+rlvgfVHP1xb3bp5tSvH0+T8dCpPMY3I7tDDnltnS6mbNip9DEPP0y+1FAOPqucjn3ulICQEmD39D9711fRY9L1ojdzPwW4YUxoh3MWdrbdImmAYJeAI3P4+mBivKZqOCuAiAsLj9QJJHlN+Lg07PwOE8ZIEg3GLoOcQOgtEWHkjky7LFOiw22WiPJEZm9PE1mceQfJ6aDx0t0IkV7NWjxkSMFhefEiJKVDkF27ghEOi7MdGH7pD/PWoactmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GZBPgIguM1mcK5tC4BD0nnwKU3OPW7XV+LxlsvXygo=;
 b=UdhGIToKAjnk4hNOWZ2/iGlrPoObtrNLdWDsIu4RPQWs1dl1xCzrjptRZmiEtKOZbgIWvEg8AKjHC48DbCAjUrPznGHr8FblPvr7H57d/GpefSBnyZ9nYhKpgktUHt7qIG9wIq+uUcsYBWBW6+2cc4EJIM9zibacjMzesA5dJHM=
Received: from BYAPR11MB3256.namprd11.prod.outlook.com (2603:10b6:a03:76::19)
 by BY5PR11MB4008.namprd11.prod.outlook.com (2603:10b6:a03:186::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Tue, 16 Feb
 2021 18:15:31 +0000
Received: from BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::ac1e:2d22:3f90:4dc]) by BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::ac1e:2d22:3f90:4dc%7]) with mapi id 15.20.3846.039; Tue, 16 Feb 2021
 18:15:31 +0000
From:   "Moore, Robert" <robert.moore@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
CC:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "Kaneda, Erik" <erik.kaneda@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>
Subject: RE: [PATCH 0/2] ACPICA: Fix a race in GenericSerialBus (I2C) and GPIO
 handling
Thread-Topic: [PATCH 0/2] ACPICA: Fix a race in GenericSerialBus (I2C) and
 GPIO handling
Thread-Index: AQHW25Oc9/cUXkbUgk+7YO3jW4BZXKpZztoAgAAJ7YCAAY9ccA==
Date:   Tue, 16 Feb 2021 18:15:31 +0000
Message-ID: <BYAPR11MB32561639443993C98C31236587879@BYAPR11MB3256.namprd11.prod.outlook.com>
References: <20201226142830.48818-1-hdegoede@redhat.com>
 <ced43570-1e76-6f96-f9ab-83473b4adfb7@redhat.com>
 <CAJZ5v0g2mhrw56aAjafYAsRnOWjZTATyHyfi57ekuQyGs6O-MA@mail.gmail.com>
In-Reply-To: <CAJZ5v0g2mhrw56aAjafYAsRnOWjZTATyHyfi57ekuQyGs6O-MA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.136.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd5f9d21-88d4-4136-0a41-08d8d2a6d880
x-ms-traffictypediagnostic: BY5PR11MB4008:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB40084DB4BB89447B5020537C87879@BY5PR11MB4008.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e2MKVOYhBYsfvm+GhUU7jUaJlMQy7YgL84XeKDD178QGho8jVPJqyC5FzkicP8/z8qjekr/W1nO1jrFUdvusfyfGJ0AHR5mXEd5+6Z5/i5oI+inYkxLjB4PfTn4QXF/jJ1PniAQw9nxiNetKy0lpMVs9m4e40hpNLkRL5HUzGRtf5wK4ndTw4hJfjvqm4tXlA1bmsBlmMH+Ux6Twsv/QSwqkaCkftwy5i0BAEpHNpO8KbY2zOAHqPwpFfZBI7fir03hrPO2pQ1mUWTOKN6UEvTiXP9tFjnciCYAwAU7hyMAt5H1IpLwRpRnazqgpMui9BNmGUuFGiR0niLay5HR/e1fhrRT4y0AnOyMT+mmswB/Y1Lx+KNFCFwxvHOk48ZOiSAd9twOT6iFqf8P1ml5ELNlr4V2l2hN2zMAS30P84oGKzYx+P+oP1f/pAWQCLUiIfftaDtZK4ELWG9EEYN/IcCq4MB70EDkE3qHv6bzxpkLDV9Zje9JOMU+RvHSAxfH7eFhOnCcF//LvCdh7YUCz9VFi3YxNfUgJzwuznnoEzwtrx5EtghZOGyX4nJ4a5pg/KWhYLV8qSWB3yuuRMMSG6CReV95WwtXU7rpD2HyqmX4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3256.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(366004)(376002)(136003)(346002)(71200400001)(33656002)(76116006)(66946007)(66446008)(66476007)(4326008)(66556008)(478600001)(966005)(86362001)(2906002)(64756008)(8936002)(55016002)(110136005)(54906003)(5660300002)(186003)(53546011)(83380400001)(7696005)(52536014)(316002)(9686003)(8676002)(26005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UHVSb1RRV0hTeTNSSm9xeDhMcS96aVp6UTVJb1VUVkR2NHhYUUxqSUxSWkFq?=
 =?utf-8?B?MXZSaVIrMUp4YkxqWWpWOHFuc2RvYVI0MzQ1VmE0dFlqL3hGOUtMU0IyMGVu?=
 =?utf-8?B?WHI4R3BXWlpxWkdCRUZUWjJpTXIxUVd4eHZjMkE2dzF4UFU2UFRCVjZLY1dW?=
 =?utf-8?B?d3N2UXYrejd0UEFkYlRIM1pOYXJaVjV6S0UveFUyOWlJbnl5ZUk3dTZaVHBT?=
 =?utf-8?B?Zk5mNkJ6a2xKOXFNQjdDUUtEUDU0aGhzOEhxQWZZTFpGenVxQmZDei8wdTFQ?=
 =?utf-8?B?VVpzWitTVFpMVTdmVXA5TWozbzRac1Nzd01pOXJpL093bTNtTVkvUE9nU1ZT?=
 =?utf-8?B?VHBzZkVGNm9takV5RkttR1pQTGI1TUNnSkxKRTBRdXA2d1MwMGhYU0Qra2xF?=
 =?utf-8?B?dDNQeDZFVS9lNUhRdEVJUXZWWXZRTk9ETTlLSWpvWmtWNEFXNkFaenZOY2pG?=
 =?utf-8?B?Vkp1dVRVYlFGUDNTdFdYdXNZWUxMY3NYZTZ6NjFoRkkxYU1ud291VzJvZ3Fz?=
 =?utf-8?B?RVRmVFpXc29xS0ZkRlhMMjE3V2IyRUgwSHNIdCtEcGNxeGRCRFpDL1FMSkhK?=
 =?utf-8?B?WERkTThxLzd3S20wNldKRlZ5ZjhPL21IV281ZVEzUmF1MWM3dXNMRFVOZFRX?=
 =?utf-8?B?NzhjSXVJUkQyQWJLQ0t4bEhzNm81bkhlVHQxbVVlOGF0RzVIdVJ2V0lXaHdv?=
 =?utf-8?B?VUhwUS9DM2pTSVRmT3pmQkFnNVJHRE12MVNmNjVmbG5iTVZWOUtTT0pYNHhm?=
 =?utf-8?B?VlZrZmZmWmE1eExzbE1EbnJ2aGxJc2Q1Q3VhcGRhYk9ucGhTdWloa01YRy9R?=
 =?utf-8?B?d0h5U3pJMmppdlp4TWZGK0VkbkxmV095OHFSMUcwWG00aXdjOHRKRFllWHFD?=
 =?utf-8?B?VDlGdkhReU4rWEc4VE5oNGRoRGE0R05rZ1I5YlR6blpUaWhJNWxVdnUrN0xq?=
 =?utf-8?B?RGh3RG9KcXZvcmd3R3B6b2ZQbXp3RVRwMU1DQmtNSUNKK1hHcVVaL3hQMitz?=
 =?utf-8?B?Q0JMa0pNRFA0RVdHcjFNV3E4YjBpRnRyekpSRGZiN0ZHRFFKMTBxYWQ1RkZI?=
 =?utf-8?B?bUVrYzN5SUdMMXhvZDY4RWcrOFJUemJrZ0pTaTh1MFNiRXJGZ3VzRXlpbTNh?=
 =?utf-8?B?NzRBRno2TXlFalBYRjJ5bnhycTNwcDZUa0NZYXZDQXRCM0E2SktZTFpFWFlI?=
 =?utf-8?B?WEpWS3dkZlNIWi9heG04ODhxbU1kYWJTUCtiSVdBSVRGdGJhU21tNUhSMGUv?=
 =?utf-8?B?UjNuZDJ4eFovUVFpdDJWSTdNWENlYjJSd21naXRxWEpMK2IwUytPbWxNUm9J?=
 =?utf-8?B?dUw1c0ZFVmNXVzF0KzZBSVNTVFBFS0RJbHQ1Q0RRcmE3eXluY1lkYnRNRjF4?=
 =?utf-8?B?OXlRNFhqRWZ4QUd2UDAzOTlNaWVTd0RlSzBUNW85MVZqQ1duSzJ0VWpRYS9V?=
 =?utf-8?B?REk5ZW1JeFZ2SkJUd3BJWWVzeXlXTnZPZzJiT2twMVdtQk13MGZKUjZyK1Zw?=
 =?utf-8?B?KytqemtJd0xZS214V2l4aVBDNktWZ2ZIYjJEYnpOTVVFcXhvajZaVmFBNGhS?=
 =?utf-8?B?Qjk5TmN6YjBDeXZISDd1SmlkSGNQVThmMkhuNVh4Q1lTTnYzOW9IWmZoVnJI?=
 =?utf-8?B?UStaVmQ2em4xK3V3enI1TXJzWlhkTndLY2dLelg2TmdDMlVTSW9yTmhDS3Yr?=
 =?utf-8?B?ZE9zaXJnUDg0TGk3MXE5K0xUcTlYQWllakNwamFNWTRDYkFtdzhyZ1BxOTRq?=
 =?utf-8?Q?mrZ/yB8Vxa0NWQat91AGr4GL4852pvyN3eDG3gq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3256.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd5f9d21-88d4-4136-0a41-08d8d2a6d880
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2021 18:15:31.0729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X0/lko/GW3ZPk83srMUveDdAi7I9OGoMwBY2aFkK8T9ZVHHXEB1CKro8umRwFIZUu5ul30JzcUg3xyXgPLoSmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4008
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

V2UndmUgYmVlbiBidXN5IGltcGxlbWVudGluZyBBQ1BJIDYuNCBzdXBwb3J0IGluIEFDUElDQS4g
U29ycnkgZm9yIHRoZSBkZWxheS4NCkJvYg0KDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQpGcm9tOiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsQGtlcm5lbC5vcmc+IA0KU2VudDogTW9u
ZGF5LCBGZWJydWFyeSAxNSwgMjAyMSAxMDoyNiBBTQ0KVG86IEhhbnMgZGUgR29lZGUgPGhkZWdv
ZWRlQHJlZGhhdC5jb20+DQpDYzogUmFmYWVsIEogLiBXeXNvY2tpIDxyandAcmp3eXNvY2tpLm5l
dD47IExlbiBCcm93biA8bGVuYkBrZXJuZWwub3JnPjsgTW9vcmUsIFJvYmVydCA8cm9iZXJ0Lm1v
b3JlQGludGVsLmNvbT47IEthbmVkYSwgRXJpayA8ZXJpay5rYW5lZGFAaW50ZWwuY29tPjsgQUNQ
SSBEZXZlbCBNYWxpbmcgTGlzdCA8bGludXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmc+OyBvcGVuIGxp
c3Q6QUNQSSBDT01QT05FTlQgQVJDSElURUNUVVJFIChBQ1BJQ0EpIDxkZXZlbEBhY3BpY2Eub3Jn
Pg0KU3ViamVjdDogUmU6IFtQQVRDSCAwLzJdIEFDUElDQTogRml4IGEgcmFjZSBpbiBHZW5lcmlj
U2VyaWFsQnVzIChJMkMpIGFuZCBHUElPIGhhbmRsaW5nDQoNCk9uIE1vbiwgRmViIDE1LCAyMDIx
IGF0IDY6NTIgUE0gSGFucyBkZSBHb2VkZSA8aGRlZ29lZGVAcmVkaGF0LmNvbT4gd3JvdGU6DQo+
DQo+IEhpLA0KPg0KPiBPbiAxMi8yNi8yMCAzOjI4IFBNLCBIYW5zIGRlIEdvZWRlIHdyb3RlOg0K
PiA+IEhpIEFsbCwNCj4gPg0KPiA+IE9uIG9uZSBvZiBteSBtYWNoaW5lcyBJIG5vdGljZWQgdGhl
IGZvbGxvd2luZyBlcnJvcnMgYmVpbmcgbG9nZ2VkOg0KPiA+DQo+ID4gWyAgIDUyLjg5MjgwN10g
aTJjIGkyYy0wOiBhZGFwdGVyIHF1aXJrOiBubyB6ZXJvIGxlbmd0aCAoYWRkciAweDAwNzgsIHNp
emUgMCwgcmVhZCkNCj4gPiBbICAgNTIuODkzMDM3XSBpMmMgaTJjLTA6IGkyYyByZWFkIDAgYnl0
ZXMgZnJvbSBjbGllbnRAMHg3OCBzdGFydGluZyBhdCByZWcgMHgwIGZhaWxlZCwgZXJyb3I6IC05
NQ0KPiA+DQo+ID4gVGhlIHNlY29uZCBsaW5lIGlzIGNvbWluZyBmcm9tIHRoZSBMaW51eCBJMkMg
QUNQSSBPcFJlZ2lvbiBoYW5kbGluZyANCj4gPiBhbmQgYWZ0ZXIgYSBidW5jaCBvZiBkZWJ1Z2dp
bmcgSSd2ZSBmb3VuZCBvdXQgdGhhdCB0aGVyZSBpcyBhIHJhdGhlciANCj4gPiBvYnZpb3VzIChv
bmNlIHlvdSBzZWUgaXQpIGFuZCBuYXN0eSByYWNlIGNvbmRpdGlvbiBpbiB0aGUgaGFuZGxpbmcg
DQo+ID4gb2YgSTJDIGFuZCBHUElPIG9wcmVnaW9ucyBpbiBhY3BpX2V2X2FkZHJlc3Nfc3BhY2Vf
ZGlzcGF0Y2goKS4gU2VlIA0KPiA+IHRoZSBmaXJzdCBwYXRjaCBpbiB0aGlzIHNlcmllcyAodGhl
IHNlY29uZCBwYXRjaCBpcyBhIGZvbGxvdy11cCANCj4gPiBjbGVhbnVwIHBhdGNoIHJlbW92aW5n
IHNvbWUgY29kZSBkdXBsaWNhdGlvbikuDQo+ID4NCj4gPiBUQkggSSdtIHN1cnByaXNlZCB0aGF0
IHRoaXMgaXNzdWUgaGFzIGdvbmUgdW5ub3RpY2VkIGFzIGxvbmcgYXMgaXQgDQo+ID4gaGFzLCBi
dXQgSSBndWVzcyB0aGF0IGl0IG1vc3RseSBsZWFkcyB0byB1bnJlcHJvZHVjYWJsZSBzcG9yYWRp
YyANCj4gPiBwcm9ibGVtcyBtYWtpbmcgaXQgaGFyZCB0byBkZWJ1ZyBhbmQgSSBnb3QgbHVja3kg
dGhhdCBJIGhhZCBhIA0KPiA+IG1hY2hpbmUgd2hlcmUgdGhlIHJhY2Ugc2VlbXMgdG8gdHJpZ2dl
ciBhYm91dCBvbmNlIGV2ZXJ5IDIwIHNlY29uZHMuDQo+ID4NCj4gPiBJIGtub3cgdGhhdCBBQ1BJ
Q0EgcGF0Y2hlcyBhcmUgbm9ybWFsbHkgbWVyZ2VkIHRocm91Z2ggdGhlIEFDUElDQSANCj4gPiB1
cHN0cmVhbSBidXQgZ2l2ZW4gdGhhdCB0aGlzIGlzIGEgc2VyaW91cyBidWcsIEkgYmVsaWV2ZSB0
aGF0IGluIA0KPiA+IHRoaXMgY2FzZSBpdCBtaWdodCBiZSBiZXN0IHRvIGFkZCB0aGUgZml4IGRp
cmVjdGx5IHRvIExpbnV4IGFuZCB0aGVuIA0KPiA+IHBvcnQgaXQgdG8gQUNQSUNBIGZyb20gdGhl
cmUuDQo+DQo+IHBpbmcgPw0KPg0KPiBUaGlzIHdhcyBzdWJtaXR0ZWQgMiBmdWxsIG1vbnRocyBh
Z287IGFuZCBkZXNwaXRlIHRoaXM6DQo+DQo+IDEuIEZpeGluZyBhIHNlcmlvdXMgYnVnIGluIEFD
UElDQQ0KPiAyLiBUaGUgZml4IGJlaW5nIHByZXR0eSBzaW1wbGUgKGFuZCBBRkFJQ1Qgb2J2aW91
c2x5IGNvcnJlY3QpDQo+DQo+IFRoaXMgaXMgc3RpbGwgYXdhaXRpbmcgcmV2aWV3IHVwc3RyZWFt
Og0KPiBodHRwczovL2dpdGh1Yi5jb20vYWNwaWNhL2FjcGljYS9wdWxsLzY1OA0KPg0KPiBJIG11
c3Qgc2F5IHRoYXQgaXQgZmVlbHMgdG8gbWUgdGhhdCB0aGUgdXBzdHJlYW0gQUNQSUNBIHByb2Nl
c3MgaXMgYnJva2VuIGhlcmUuDQo+DQo+IEkgc3VibWl0dGVkIGEgcHVsbC1yZXEgZm9yIHRoaXMs
IGFzIHJlcXVlc3RlZCBhbmQgYWZ0ZXIgdGhhdCB0aGVyZSBoYXMgDQo+IGJlZW4gemVybyBwcm9n
cmVzcy4NCj4NCj4gVGhlIHB1bGwtcmVxIGV2ZW4gaGFzIGEgMjYgZGF5IG9sZCAidGhpcyBsb29r
cyBnb29kIHRvIG1lIiBjb21tZW50IA0KPiBmcm9tIEVyaWssIGZvbGxvd2VkIGJ5IHNpbGVuY2Uu
Li4gPw0KPg0KPiBSYWZhZWwsIGNhbiB5b3UgcGxlYXNlIGNvbnNpZGVyIGp1c3QgZGlyZWN0bHkg
cGlja2luZyB0aGVzZSAyIGZpeGVzIA0KPiBpbnRvIHlvdXIgYWNwaSBicmFuY2gsIHNvIHRoYXQg
d2UgY2FuIGdldCB0aGlzIG5hc3R5IHJhY2UgY29uZGl0aW9uIGZpeGVkID8NCg0KSSB3aWxsIGRv
IHRoYXQgbGF0ZXIgdGhpcyB3ZWVrLCB0aGFua3MhDQo=
