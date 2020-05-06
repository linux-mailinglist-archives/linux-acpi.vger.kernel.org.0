Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90B11C79A6
	for <lists+linux-acpi@lfdr.de>; Wed,  6 May 2020 20:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730465AbgEFSrf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 6 May 2020 14:47:35 -0400
Received: from mga02.intel.com ([134.134.136.20]:58064 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730317AbgEFSre (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 6 May 2020 14:47:34 -0400
IronPort-SDR: k/Rzcs39BWT0OCh9fWdK/08PQ0PT0F/GFE/h+0TzyeA2HzY5xEDDFSmobtxExBv1apSDNh2g4E
 U5Hy2JtqgIRg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 11:47:33 -0700
IronPort-SDR: kiReXJiaSFj7B3q699Z9jv6Ff2Ink4T07+KspMNQ80RqoQV5DlEoy45XL58GBg+FmWS/ahvttq
 1DjMdwYbejSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,360,1583222400"; 
   d="scan'208";a="260198344"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga003.jf.intel.com with ESMTP; 06 May 2020 11:47:32 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 6 May 2020 11:47:32 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 6 May 2020 11:47:31 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 6 May 2020 11:47:31 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 6 May 2020 11:47:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WE/Y0cAeN7M2JzVqBi9vhLwBX2+snjeSy6SGI4cAGEm/bv86wV3wGTD1gDxHgSThKiF8v5oECWDeAEhoYegwdgz0O9Jqujnl4+Rffq13k0L987swv87K5hVBkEdlQTA9sleSdv6wimEYzh/EocZK03/jXjsLRZwq+7UYK39ylT7iRYhqRdtubu+DKNoYsqVew1rB6ftjDBnOehDM0mEHqmuEhXDPcFEpNg5RTgUuit6magXa8VmMGl9VLl92zkIqZPu1xrhZUYJKajpQUYjuJSWTCOLr7sfEMIT0BKBfvVowLBk+6rjGyuyHOODNsi2xa5dhxZwUNFmZqoHxwjQCvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajsA2Y1DQbJ3Rz1v6Gos8vXQAtcDRSROSDidB6IUnco=;
 b=eP1zuZ6R6GwTMVFaA2S9HgY4ElUoD/ihhI3MbzHwHRhfCpMSbMvwjDOWjB6f6H76NQk8Qsex6SpAWgSgMouP3XDx90P+T0FvTAea3SDSFPFHTQU2pmFpwWq9gMzuYxaAZqQFS7oNrD7g/PVqx9EAf5NOG8ipxLbFVXErZq4Wl5LZh9CaF+eXJFu988dhj1XjJTb7O+M6OBas5cgi9FIEk+6q9WWaywI6rhdRDLbutVE2x94YWR7I3u7DsA/aw6aHWwMoZWy2eOVPHbrgoDHKME1DlaSeGtQ2a2EKpeczb80g4eqKgxnrbXPj6Ra9LNhfOnfQwjUT39ZgJ+3wZNtb1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajsA2Y1DQbJ3Rz1v6Gos8vXQAtcDRSROSDidB6IUnco=;
 b=J8g3AgVTkuSPAAa3MgSw9ZArXB13uv7dzrGOk1ds+RkpEdg5voP91UlviLTNrRHOSAewt247dW5Lto8XLaoVkJZwvj0tPie1EiMU8A9+WkqX6ApDVltbbL5quC5ZvY4CNHDP/zDQCHk+0Y+F9/uDPvn7yhiCgsHkIRilfhLREZA=
Received: from BYAPR11MB3096.namprd11.prod.outlook.com (2603:10b6:a03:8f::14)
 by BYAPR11MB2789.namprd11.prod.outlook.com (2603:10b6:a02:cc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Wed, 6 May
 2020 18:47:27 +0000
Received: from BYAPR11MB3096.namprd11.prod.outlook.com
 ([fe80::94e7:471d:f545:3c3e]) by BYAPR11MB3096.namprd11.prod.outlook.com
 ([fe80::94e7:471d:f545:3c3e%5]) with mapi id 15.20.2979.028; Wed, 6 May 2020
 18:47:27 +0000
From:   "Kaneda, Erik" <erik.kaneda@intel.com>
To:     Jaime Perez <19.jaime.91@gmail.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Cheng, Michael" <michael.cheng@intel.com>
Subject: RE: Suspend
Thread-Topic: Suspend
Thread-Index: AQHWI9M5XG1XpU8iyUKMwwQ0P2gpqqibZb5w
Date:   Wed, 6 May 2020 18:47:27 +0000
Message-ID: <BYAPR11MB3096149F4950FE626B991D83F0A40@BYAPR11MB3096.namprd11.prod.outlook.com>
References: <CAM2dokvEdG5P5dso8+3vh7urX1FCFx4p+g-TiBH62+pMfuDKqA@mail.gmail.com>
 <CAM2doks5uTqmeV+f8ok4D=jCRRM=rEYUM_jdVHGmvToOZmcrWA@mail.gmail.com>
In-Reply-To: <CAM2doks5uTqmeV+f8ok4D=jCRRM=rEYUM_jdVHGmvToOZmcrWA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.52.214]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3ce42e3-4a34-42ce-cdaa-08d7f1edec9f
x-ms-traffictypediagnostic: BYAPR11MB2789:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB2789AFD23A51E533EBC33D1EF0A40@BYAPR11MB2789.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 03950F25EC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hMJlZ9qqWfUqQG0fAATbZ4G89Cn377mkv1FhC3mFFj5XHlRs/Lf3Yuib6QtIR9SjieOK5uVxQuyV4FSgDMT9lnPYS395zWr5aeXXip4Pw2BvhgCKrZrsBKt0apC/0niZtUPTv6uym+STsGtoEnUV0ESecQCCLh+5aAWh5GVPBml3oZZ1ZIMrMWOWpTxdPwP5SUAIRUtyiJFXGdwoFmaGtRHpg2GWyJEUYJynrNv94NS7MFeQWwOnFzhY/QmGPWg6tFUGHNQFjEvpj1WcZx6ELhvP4FDtdFhQxsDQLh9UwILBGiWI/4O61SasAsedZjXcf3vzZmgrzXUq1/RWoUdHQH0GmrmvTsEmOlothN3OXHWWHBMqURAoreL6xZtXOmAYQgpMRIouALbBRQ2/EX+yXUPEkCFajn8ONh6EwDnbIzaX2Yhnd4qSF2WbDc0tFG8K4R/fPlpbpDtgn7OUNTEolB+bak0IulawTKiCx/Gc5BFW+ss7hgl24aFy7hCQafrZ0+Gm9h26anbJxqrVJf08Hw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3096.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(39860400002)(396003)(366004)(136003)(376002)(33430700001)(76116006)(66946007)(6506007)(3480700007)(316002)(86362001)(66446008)(66476007)(66556008)(110136005)(53546011)(52536014)(9686003)(2906002)(55016002)(4744005)(64756008)(71200400001)(33656002)(478600001)(5660300002)(186003)(8676002)(6636002)(8936002)(7696005)(15650500001)(7116003)(26005)(33440700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: fHq6jEPQukyEZp7fycrIM5mzl7Y8B63urPk1VI3gweIG1z4eH7r9mjYKrnr+g66SKaW1DTERGpXi4qF1V9O5D/AvYHk2cYCcYp32AuxvPmCjZM4IO5sd231Yn8j+y0FzVv1JB9eRoPhVFvd0fmST9INKER0aebczWeL9EWB0i/19BTxhWjHQWxcn0tRZ7t8aid+DDmPyO+SrakhuW975vuYQOipjhX39g1YZ2mL9/TXk4fU3U7M89cK6svxkn+BVw4Yx2lisVP/O1c1/pV6jsk4iFgPUYhghmXQ0pFHcYNRPicai3RJK5ZAPHrZuxjQsgfxaArwYNkQHm3cQI6LH++2Qb0GZWIy0VOsdMWJlsIAMdjmAr9n7iKMvacilYhwa0mOBAAEhxV4K4FBIvbd/bmXdp1b1G5fTIPuNvgpSryUTxVVfUYKhDpaZm3IZQH2b4H5FKiz1DEsTLI0wzxV7tbi3iS710/L1mLc1UHKyottH+tjx+bKkqEcqDPz1AoYoAciMoX+M6i/CnVrKXd0HASpvEeLpae5T+RaXQB1ai2HejkMXUpXbCccpxjbVg6w2lvQs+gLXISk1AYB2JzOfIOxDuaO/kHX0yMa1akXYBN87+corAX4Te601VnlFBdiNE9nNbcp3z0uN/bNnXOPJ5jmaHD4FpGA3OeVyF6xjBQFXuQsKjkR4dy6Rffzk6tQs66yUOuCUCPDoQn0rwPezJ75vlEzS4tHKI364FevuQ89liwAfqiJVpo4EDx9f/xAz4j1Kw96YJtKY/Nc6Ma/5tZ9pU4wvizLvW18b62upTUo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f3ce42e3-4a34-42ce-cdaa-08d7f1edec9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2020 18:47:27.4584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HsLFKowEUhx2erfWpI5i9n7/LCEd7laMX7zv0jRqvjuqZRKg4VDPNgy+tIH5cCrqQG2aRdWuW22I5F0sFosKIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2789
X-OriginatorOrg: intel.com
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

K01pY2hhZWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1h
Y3BpLW93bmVyQHZnZXIua2VybmVsLm9yZyA8bGludXgtYWNwaS0NCj4gb3duZXJAdmdlci5rZXJu
ZWwub3JnPiBPbiBCZWhhbGYgT2YgSmFpbWUgUGVyZXoNCj4gU2VudDogV2VkbmVzZGF5LCBNYXkg
NiwgMjAyMCAxMToyMSBBTQ0KPiBUbzogbGludXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3Vi
amVjdDogRndkOiBTdXNwZW5kDQo+IA0KPiBIaSwNCj4gSSBoYXZlIG5vdCBiZWVuIGFibGUgdG8g
c3VzcGVuZCBteSBwYyBzaW5jZSBJIHVzZWQgY2hyb21lT1MuIElmIEkgcHJlc3Mgb24NCj4gc3Vz
cGVuZCBidXR0b24sIG15IHBjIHNlZW1zIHRvIGdvIHRvIHNsZWVwLCBidXQgd2hlbiBpIHByZXNz
IHBvd2VyIGJ1dHRvbg0KPiBvciBzcGFjZSBiYXIsIGl0IGdvZXMgdG8gYmlvcyBhbmQgbWFrZXMg
YSBub3JtYWwgYm9vdC4NCj4gDQo+IFRoYW5rcw0K
