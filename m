Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C032A0E29
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Oct 2020 19:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgJ3S5h (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Oct 2020 14:57:37 -0400
Received: from mga14.intel.com ([192.55.52.115]:56632 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbgJ3S5h (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 30 Oct 2020 14:57:37 -0400
IronPort-SDR: 8s8u7VVeg/W0Y8x7KfInFBlXvL1vrdSxWI5n5i6lCaFe03grYS60Uyl9CNppQVOXp6tJBp1MS4
 4l6wsXNWbAiA==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="167869062"
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="167869062"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 11:57:36 -0700
IronPort-SDR: M+iagChnVE9Z7rDkq9o21ABG1R5TRvknjdtF8D9FJ8GZflxcwkBP3M+XYzPxviEP1ZA7hPm5Id
 HhBY4oYWgzxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="305019460"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga007.fm.intel.com with ESMTP; 30 Oct 2020 11:57:36 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 30 Oct 2020 11:57:35 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 30 Oct 2020 11:57:35 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Fri, 30 Oct 2020 11:57:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejaToYF/5GJ+A9IchKaezW91oI0kvmjWpzLfl9/+8T5lsAyG53UV/m2wN9AusqWgFoc/fihxkVhJUaxUvCm1p+igTR3gf22N8FiQ9ixtF8BepXoU+LriZj1XFR3MZe+ZDLHnUGYKoqnOl9MHVeLblaZKpvsS8AskQXdqeKxOVqLMcZUU1NFgc/1H7egJPO6k6QQm6LtAW8/zNzrS1zMItiHQQMAB11v2c8ZU/Zy/ZpWI3/Ded1o6K5xpp8PR6E7WSzYvSM3PJ8p2jN3bULCFawLFRU4lQ6y5T4dIbEVS+uz8WFix4duTpZJ0V7oT8hRzSsddmsVEeuzdBoZVQ6yYBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1dpxKfxS4ssj6nKqQ4XRrFiQPDtNiRGS3lrpqfcj8k=;
 b=Aq/RYi9+t6vWoaFkMnNUuCAVAjTep9CYNWdPmtcjmTSLNAP+gRJzAERmR8jwUREZKKp4YuxgrpDzA1lj9TTCHzIJDeJ1H8kLO4kKrrF7xLFqselwdpcI8DszScOhzyBaO370NG15FM8p5JYMlMu9iT96CW4xWLx/boeW4IF0OwR4RH2ZpYlJEikhSIncyQBJ9N63aIraq+qtv2ucu8NE4xi9OrhYVMtnkdOP2xUMNKeeaetO5WR3JoQTbMcZ83oxjmJ9LhD2woYBt1+1tJ3MOqc2zHO5ti5MgvCKsRSDVusltKi9Z8D2l/uZpc9EmngV39kpGbVv/KMmIdYiUd3U8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1dpxKfxS4ssj6nKqQ4XRrFiQPDtNiRGS3lrpqfcj8k=;
 b=KG/MJP2lUjI6dtuFjh6urYxxtYexlgIwlrLXoXeohdO6ELtt4C3ZOy/QkjPjSV1f1ZP/S0YsHi7iVBJxqCkhhO3HXhZmUcZFtNKXYmXzKG7J31Ws2WVO7IxEO0Cp2lzzgAY8aJgG4QIDFnLTBNqSJTVPK1EEbEFhiR2XaJ93R7E=
Received: from MWHPR11MB1599.namprd11.prod.outlook.com (2603:10b6:301:e::16)
 by CO1PR11MB5025.namprd11.prod.outlook.com (2603:10b6:303:9e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19; Fri, 30 Oct
 2020 18:57:33 +0000
Received: from MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::95ce:8aed:2361:1f31]) by MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::95ce:8aed:2361:1f31%10]) with mapi id 15.20.3499.028; Fri, 30 Oct
 2020 18:57:33 +0000
From:   "Kaneda, Erik" <erik.kaneda@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        "Moore, Robert" <robert.moore@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>
Subject: RE: [PATCH] ACPICA: Also handle "orphan" _REG methods for GPIO
 OpRegions
Thread-Topic: [PATCH] ACPICA: Also handle "orphan" _REG methods for GPIO
 OpRegions
Thread-Index: AQHWqrOnbaxVkidVN0K4VBzXKS8YhamqXyUggAEjKYCAADldIIAAFZUAgAHNXyCAAL1ZgIACK4wA
Date:   Fri, 30 Oct 2020 18:57:33 +0000
Message-ID: <MWHPR11MB15992234045948BBAD62716EF0150@MWHPR11MB1599.namprd11.prod.outlook.com>
References: <20201025094542.3669-1-hdegoede@redhat.com>
 <MWHPR11MB159947FE046515CE985CA571F0190@MWHPR11MB1599.namprd11.prod.outlook.com>
 <BYAPR11MB32563BD4E4ABB7BEF135ABFB87160@BYAPR11MB3256.namprd11.prod.outlook.com>
 <MWHPR11MB15990ABB3778816E4831FDF9F0160@MWHPR11MB1599.namprd11.prod.outlook.com>
 <d8330e68-c0ab-ab3c-ee13-3d9dc58ade7b@redhat.com>
 <MWHPR11MB1599E899E45EF55CB70A89A3F0170@MWHPR11MB1599.namprd11.prod.outlook.com>
 <6e04d729-421e-c663-6d06-d69ec4c96556@redhat.com>
In-Reply-To: <6e04d729-421e-c663-6d06-d69ec4c96556@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [50.45.176.77]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28991dd5-7372-4405-264a-08d87d05a8e0
x-ms-traffictypediagnostic: CO1PR11MB5025:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB50255C4B8CA3B8BE032A572CF0150@CO1PR11MB5025.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oCQ2criaVJLQtr8Ed97TBU4uh9UWR5YgAPdEZVYk2tBG0jtn+bhFgEXbNwlO4tYviwbiE/C7ClbqX0LMWzt3WU6oSZ+7Ovmf6pNKAmTNFVCtBN90ZYDOZGP3MRW1tEgH+DamoHlq/L2+QVls8ucFe460y9OLtpr46WlU10vXDgGP3jUJOI1hJ+DVs0umpO/z/wEPrq4TwzNW/0G+Sl0z/0NyPVOiSI+EGk1DtPJXZSK3V989sef7tPkZ8/4Q+A1cVGYRJ4vq4d75OO0bf0ctdf7lu/aMvjlxeExxmrh2eJT63RXQqUFAlSRWIRxmomdMCS+yc8zyWVSAexKi9c1Ve3zegNxZcQ1OM9Btxqg2AzFuXHAwPhHNMLcsZvqXV96SG+U3uVwDrrKz5Fg9PhKIfQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1599.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(6029001)(4636009)(366004)(136003)(39860400002)(376002)(346002)(396003)(4326008)(478600001)(5660300002)(52536014)(66476007)(66946007)(9686003)(66446008)(55016002)(83380400001)(71200400001)(6506007)(66556008)(64756008)(2906002)(53546011)(54906003)(186003)(26005)(8676002)(8936002)(966005)(316002)(7696005)(76116006)(86362001)(33656002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: FC8kdA6u+uak/4l3JxXps9+QcXNK1Ka6axS6Amt1B5jsBaTTbJeIWNFeAVygaxfSR+HC84AE9ikl8oUZxxIrsoI0gLPjNIDXqytmD/pd01xkCWLTg6y7r9UfTaJI4cyOe2lfXyOd8FFoxVBZZ/EOp+4l1O0N4vkZyiPvA9+T3M/zMVE8x+p+xGFgbFGla851gbd9+jogu5YVpUgx0oxOVedpvW6om7HnC7ihnyvelfM+9DkzsPyqIzFyKELZVZJSry+mGLuc807UQKYBJVVkvF/N/J9ddaPqKhWgI6DN21K82UZ/P/teo8LwZwRrMhBw7gg6w7LXmKKpA+eq659qDFnrbu3vFHp8lcJaBcovGld0C9RXUi+iTWd5aiyPIq7Z1K7iq1HB7KexlyXan7DB5lS5vCX2C2vpcT4BHLItkKu0m4tGfNKiGy+eQe5AHEl/g3xtPS/PEs7ISrZAZaf6G8UE9oB6O5hRJX+Wz2S49Np6/+MES13FP6vjMYSGSEGmCYQHgeiLEW1Chq7MACIwgjEkLKNM86Lz//IYUI5GgOIu0W3te3kRSuT+tSCyyRiCZ/jau3Ar8F6v8QmcNpO6/uumVgzcAUXpz18N1Vg2aPop5sZzKkNeQn4R/9hoH5IO8Tg71r+ISO5tcNcc1EZQ9Q==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1599.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28991dd5-7372-4405-264a-08d87d05a8e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2020 18:57:33.3426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FYo/NVxQvpxK3UeI6YIK4oqCcMBfm04IiP+K4z6GVPTor+YZ64EPja/vlGzqo3we4WXn9MUEcDYMr6FGAyGCFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5025
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSGFucyBkZSBHb2VkZSA8
aGRlZ29lZGVAcmVkaGF0LmNvbT4NCj4gU2VudDogVGh1cnNkYXksIE9jdG9iZXIgMjksIDIwMjAg
Mjo0OSBBTQ0KPiBUbzogS2FuZWRhLCBFcmlrIDxlcmlrLmthbmVkYUBpbnRlbC5jb20+OyBNb29y
ZSwgUm9iZXJ0DQo+IDxyb2JlcnQubW9vcmVAaW50ZWwuY29tPjsgUmFmYWVsIEogLiBXeXNvY2tp
IDxyandAcmp3eXNvY2tpLm5ldD47IExlbg0KPiBCcm93biA8bGVuYkBrZXJuZWwub3JnPg0KPiBD
YzogbGludXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmc7IGRldmVsQGFjcGljYS5vcmcNCj4gU3ViamVj
dDogUmU6IFtQQVRDSF0gQUNQSUNBOiBBbHNvIGhhbmRsZSAib3JwaGFuIiBfUkVHIG1ldGhvZHMg
Zm9yIEdQSU8NCj4gT3BSZWdpb25zDQo+IA0KPiBIaSwNCj4gDQo+IE9uIDEwLzI4LzIwIDExOjMz
IFBNLCBLYW5lZGEsIEVyaWsgd3JvdGU6DQo+ID4NCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRoYXQuY29t
Pg0KPiA+PiBTZW50OiBUdWVzZGF5LCBPY3RvYmVyIDI3LCAyMDIwIDEyOjAwIFBNDQo+ID4+IFRv
OiBLYW5lZGEsIEVyaWsgPGVyaWsua2FuZWRhQGludGVsLmNvbT47IE1vb3JlLCBSb2JlcnQNCj4g
Pj4gPHJvYmVydC5tb29yZUBpbnRlbC5jb20+OyBSYWZhZWwgSiAuIFd5c29ja2kgPHJqd0Byand5
c29ja2kubmV0PjsgTGVuDQo+ID4+IEJyb3duIDxsZW5iQGtlcm5lbC5vcmc+DQo+ID4+IENjOiBs
aW51eC1hY3BpQHZnZXIua2VybmVsLm9yZzsgZGV2ZWxAYWNwaWNhLm9yZw0KPiA+PiBTdWJqZWN0
OiBSZTogW1BBVENIXSBBQ1BJQ0E6IEFsc28gaGFuZGxlICJvcnBoYW4iIF9SRUcgbWV0aG9kcyBm
b3INCj4gR1BJTw0KPiA+PiBPcFJlZ2lvbnMNCj4gPj4NCj4gPj4gSGksDQo+ID4+DQo+ID4+IE9u
IDEwLzI3LzIwIDY6NDMgUE0sIEthbmVkYSwgRXJpayB3cm90ZToNCj4gPj4+DQo+ID4+Pg0KPiA+
Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+Pj4gRnJvbTogTW9vcmUsIFJvYmVy
dCA8cm9iZXJ0Lm1vb3JlQGludGVsLmNvbT4NCj4gPj4+PiBTZW50OiBUdWVzZGF5LCBPY3RvYmVy
IDI3LCAyMDIwIDc6MTcgQU0NCj4gPj4+PiBUbzogS2FuZWRhLCBFcmlrIDxlcmlrLmthbmVkYUBp
bnRlbC5jb20+OyBIYW5zIGRlIEdvZWRlDQo+ID4+Pj4gPGhkZWdvZWRlQHJlZGhhdC5jb20+OyBS
YWZhZWwgSiAuIFd5c29ja2kgPHJqd0Byand5c29ja2kubmV0PjsNCj4gTGVuDQo+ID4+Pj4gQnJv
d24gPGxlbmJAa2VybmVsLm9yZz4NCj4gPj4+PiBDYzogbGludXgtYWNwaUB2Z2VyLmtlcm5lbC5v
cmc7IGRldmVsQGFjcGljYS5vcmcNCj4gPj4+PiBTdWJqZWN0OiBSRTogW1BBVENIXSBBQ1BJQ0E6
IEFsc28gaGFuZGxlICJvcnBoYW4iIF9SRUcgbWV0aG9kcyBmb3INCj4gPj4gR1BJTw0KPiA+Pj4+
IE9wUmVnaW9ucw0KPiA+Pj4+DQo+ID4+Pj4gTG9va3MgT0sgdG8gbWUuDQo+ID4+Pg0KPiA+Pj4g
T2ssIEknbGwgbWFrZSBhIHB1bGwgcmVxdWVzdCBvZiB0aGlzIHRvIEFDUElDQSBvbiBiZWhhbGYg
b2YgSGFucyBhbmQgaXQgd2lsbA0KPiBiZQ0KPiA+PiBpbiB0aGUgbmV4dCBBQ1BJQ0EgcmVsZWFz
ZS4NCj4gPj4NCj4gPj4gR3JlYXQsIHRoYW5rIHlvdS4NCj4gPg0KPiA+IFB1bGwgcmVxdWVzdCBp
cyBhdmFpbGFibGUgaGVyZTogaHR0cHM6Ly9naXRodWIuY29tL2FjcGljYS9hY3BpY2EvcHVsbC82
NDQNCj4gPg0KPiA+IE9uY2UgaXQncyBtZXJnZWQsIGl0J2xsIGJlIGEgcGFydCBvZiB0aGUgbmV4
dCBBQ1BJQ0EgcmVsZWFzZS4NCj4gDQo+IFRoYW5rIHlvdSBmb3IgcG9ydGluZyB0aGlzIHRvIHRo
ZSBBQ1BJQ0EgdXBzdHJlYW0gY29kZSwNCj4gdW5mb3J0dW5hdGVseSB5b3UgbWlzc2VkIG9uZSBj
aGFuZ2Ugd2hlbiBwb3J0aW5nIHRoaXMuIEkndmUgYWRkZWQNCj4gYSByZXZpZXcgcG9pbnRpbmcg
dGhlIG1pc3NpbmcgYml0IG91dCBvbiBnaXRodWIuDQo+IA0KPiBTcGVjaWZpY2FsbHkgeW91IG1p
c3NlZCB0aGlzIGJpdDoNCj4gDQo+ICAJCWlmICgobmV4dF9ub2RlLT50eXBlID09IEFDUElfVFlQ
RV9SRUdJT04pICYmDQo+ICAJCSAgICAobmV4dF9ub2RlLT5vYmplY3QpICYmDQo+IC0JCSAgICAo
bmV4dF9ub2RlLT5vYmplY3QtPnJlZ2lvbi5zcGFjZV9pZCA9PQ0KPiBBQ1BJX0FEUl9TUEFDRV9F
QykpIHsNCj4gKwkJICAgIChuZXh0X25vZGUtPm9iamVjdC0+cmVnaW9uLnNwYWNlX2lkID09IHNw
YWNlX2lkKSkgew0KPiAgCQkJZ290byBleGl0OwkvKiBEbyBub3QgZXhlY3V0ZSB0aGUgX1JFRyAq
Lw0KPiAgCQl9DQo+IA0KVXBkYXRlZCB0aGUgUFIuDQoNClRoYW5rcyBmb3IgY2F0Y2hpbmcgdGhp
cywNCkVyaWsNCj4gDQo+IFJlZ2FyZHMsDQo+IA0KPiBIYW5zDQoNCg==
