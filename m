Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E752530C6B5
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Feb 2021 17:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236927AbhBBQ4l (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Feb 2021 11:56:41 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:50782 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236933AbhBBQyd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Feb 2021 11:54:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1612284873; x=1643820873;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TU7rjNlGHGYMgh5U7QuKgNjuaPyPCcmPLnlONAIuSas=;
  b=QciYk5NYaa8ATV5In/FT+B0L4QFlMGxhoMIMKBkMSQjXOg8PtZ6uyDU7
   2As3w6+4+ELdMWAmwtHQK6LAXQdi7M6jDB4topSLgXJkhAHWSaFnf5rqp
   ziGDn50G6SrN/VjWyj+t2wY/5ZJXmp2ldpVXn09k5ZgvxxhER/5EwYee7
   z1ElPpSMEGQMdzaoF23TXSckLyf9tjRj7zXMBItcR1CUBpAwiw+LAY2O4
   PedRhmguj7UzKcYfAY2AicvqSrMZj5eQzkefI60rTL4jGzj4D45U1tUMQ
   vuCzTfRxHmbM1mo17eb+o1LpeGYfO0CpISDp1DOSAofCHV7/lh/isBQbw
   Q==;
IronPort-SDR: e6WhV4MLnsZ/XDhgXkYRP66xhqcSAiPRmb7GnDiSp3AlvB16Vkf0y+fY9acPc10JBd8M7DTHgW
 ZYEtHuM2tJx+aU+2IS38Eh/untCLxOMR2wDfq40tHz5wBojhuL4MKM6lUjOPGMKM7Sx5b/r/gD
 iJN9Yk+GuWB/x7X6E2kipDoP6S1u/Jx3FOIqfvlFD04pLp0b6Qed39SVzwERmI3I5+I9AwK6+R
 Wc3eXicIM8uBYoV0Eqlqfr0AP+XuiYlTIv0foWW19GCmwv5KAhnMFhmC8XSDryutF8oaZxqq2+
 L08=
X-IronPort-AV: E=Sophos;i="5.79,395,1602572400"; 
   d="scan'208";a="107714944"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Feb 2021 09:52:55 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 2 Feb 2021 09:52:54 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Tue, 2 Feb 2021 09:52:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYjTMC8jG9m0AuxCGRtf9s52rUuTmYOoQpiyknWLzhmqqNLAgmIUhEs/Lm/panDQvAOLZBDft+miJHPmKdwS3Rx5EFYqeURvtPek0ofgFBr3ZcxO1KStoR9+vGMSZUvmQNIDjFql/ZL/fjJXdA7W7MHE6TC1dBoPvbgkCJqM1aHY73PzfLQFdGcSa3yZFeWgjXlDq7v8LTmceQx0yzjgXMOjCmFfmLnv0ryaxkuf7IdLl2Ss0d/B5YpG+WUqDXAjJ3P6DK5A6f7hhhR7W7TwtJFXeTGrsofHycTpFhQaEKKAxaKD9+R493AgVcAClTgKLDjetjTbaUQgUnV4T1hq9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TU7rjNlGHGYMgh5U7QuKgNjuaPyPCcmPLnlONAIuSas=;
 b=RiCSgJyoyiylysl5z0SBQsGPF2P3JTUOUWg3f+R2whO0srDAburIOQRs8VXC4zoBvX3g0YxXPSgZ6HfIc4/cYF5EQZ1n0U65wucbDgQKd0L+e5g8npBJ7TFyz1MhbhPDlsWHP8nn5DjeEwCcc542CvTXmGqVkEkQfmfKl4jqC7PmGwGBtbfZK6XlpbFS0pHPG0vuMmq8kllGaq4hhKqbo9co5KQBdDok0v8Sl4I+WHMpvda9s+TPadDQAl2M2Unf+MOFcatbMzB++jnAeXArdJdo4uYoJnPJfz2lyV72JvuMjcHygEgK13ZWFc7UnBoV/KTYFsyF4eE4eGx2PiSiTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TU7rjNlGHGYMgh5U7QuKgNjuaPyPCcmPLnlONAIuSas=;
 b=L5yL930rtB4ETpon7tkDCqPW78GDCKerJ57DULmxuXtUKb0cCMaEGNLB/EYKivJIfT/8pftQXxE1bsU7U2EZiwMZf2Qxzfc1PNhOzeyYDCksqhC5J0WleEGczm8UOM3VXGERy9GlEA9hgQrle8rncK92NtUR+q3A0POhphQoeH8=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SA0PR11MB4623.namprd11.prod.outlook.com (2603:10b6:806:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Tue, 2 Feb
 2021 16:52:53 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::f4e3:108c:4222:7dab]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::f4e3:108c:4222:7dab%3]) with mapi id 15.20.3805.027; Tue, 2 Feb 2021
 16:52:53 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <saravanak@google.com>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <m.szyprowski@samsung.com>,
        <geert@linux-m68k.org>, <maz@kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <martin@kaiser.cx>, <robh+dt@kernel.org>, <frowand.list@gmail.com>,
        <lenb@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <kernel-team@android.com>
Subject: Re: [PATCH v2 0/3] Make fw_devlink=on more forgiving
Thread-Topic: [PATCH v2 0/3] Make fw_devlink=on more forgiving
Thread-Index: AQHW+RyfxnJka6AsCkKxo1XVKvcQnapFFXcA
Date:   Tue, 2 Feb 2021 16:52:53 +0000
Message-ID: <cb6edbd0-346b-0674-5b5c-7ce3a437736d@microchip.com>
References: <20210202043345.3778765-1-saravanak@google.com>
In-Reply-To: <20210202043345.3778765-1-saravanak@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [79.115.63.101]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56848156-ea24-44a2-e87d-08d8c79afbc6
x-ms-traffictypediagnostic: SA0PR11MB4623:
x-microsoft-antispam-prvs: <SA0PR11MB4623D4D00A25113E5A0D4BE3F0B59@SA0PR11MB4623.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7KAXkegnhms4AkyIVBXOTKbrYgMoxrzchBoI0rF/CoFvTGIxb6CEUlawkFvP+jkJCBl8snVYHT8ZlPacV8fi5LGaUvSXMwCsWrU09B9qZKSUPAoYSn4oBfqLecnkuotZTUgwVUP49M3MgtLhThtp0J70fTYd7tgEg20hv8aNISUR59S88WSxij0ryajCOqr9rBAMutlX5/sljoZJls7WN8D9Rtx2EtHhImqxDSv2+iAsuhuLPzhwtBeWUvFgb/8oF7A3sKNTHASBoKnKJkEyLVoghP7x1m7D4N9c6fT4/x8snCzP5Jpnh2u0nhhzxwWxa6y8YlCnQ+rQ5Vz10COwF5MNJ2LSOVmE+BWTpYAUzG+KNNV6iY8YNOqOvp9WmG3OgcKS2zbUSonwrJN9NUS686vNfIdG74Yu7FaTp9mBueKX87fDMK+77tizvLyCuWi7c6jSwWS6EIMU4gllzQd1aspfJ1eqqjPDXA24WQka3T88mMdTa7AHp/ca1Z4huaxn320040hKS33Ddx2t0X8yTBPfebtT8XqPfYnaBrAvSWJ9RomHxxlZqKGJi4NNMGeJ3nvETMwgf64AYewfU9asXm6jB6nAkrvPs/wp8ViM7ZwTlOHaHsXo9t5PtnalJ+FH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(346002)(366004)(396003)(136003)(6512007)(66946007)(66476007)(110136005)(8936002)(54906003)(36756003)(91956017)(4326008)(2906002)(64756008)(5660300002)(921005)(76116006)(31696002)(8676002)(66446008)(2616005)(66556008)(186003)(316002)(71200400001)(7416002)(31686004)(6486002)(86362001)(83380400001)(478600001)(53546011)(26005)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZW1uWVRLMU5RajI5ZUFJWjgyblVNeUNxeUJUWWJnQjhHa0JLS0o5VldtN0Uw?=
 =?utf-8?B?R1UrY3NPRU1YTmo5RVBOY1NLSTZQL0lEUlhPN1dhK3ZNVmdiR1pvTDl0Y2V0?=
 =?utf-8?B?aTE3alljSTF5NVIrWVNzdUw3SEpFdkFraVVSdVFIeTR6bjhHU2pKaTZUMHB0?=
 =?utf-8?B?T0cwUUFua251UnBoVWZXNzk5UXVScDYvNzF0UnRGaWVCN0UySG04Vkp6ck1y?=
 =?utf-8?B?M1lrdFJBRXNLWHFxQ3FiRVpkOFVPbVdFcmRIYXpLcEFodU9MT0NuOFFRVCtk?=
 =?utf-8?B?RzZvRXQ0bVVTRXNPV3BJVXZaMTRmUEFLR0JnVU9QdmZnMm9lUGMwOVkwdEJU?=
 =?utf-8?B?YUNZbmZsOHlhR1JCK2lsbGNrQ2I5aExPVXg4MVdiSm5aUURYcXVhRzRqTDht?=
 =?utf-8?B?WjZqRGhuemtyYnl3UHJLWGE1NnpYNXRmMXF5VG05Qi81RXBSSThLZTEyRWt2?=
 =?utf-8?B?OU16bzV6ZVJzckp1TVFPYS9vWlNudmNOVFN6M3NZNGhVNnpQeTA5bWhLQlhX?=
 =?utf-8?B?d2RnMnJ4elE2bUFVVytXdklBZjhLVHRPaG9YYjF1ZThwZmpYbjVEaEZsQzBN?=
 =?utf-8?B?L2Rta2g5aUlIeUNOMFI1K1hiVXVOVUJqcDdwa0JOb3VMQkFBSVdIWTQ2bjVS?=
 =?utf-8?B?dTJKeE5qNWpYMHNpeXUxWWpadmNTZDIzVjFJZEZZREd6NjJxazJYQm5ROUVO?=
 =?utf-8?B?K2lWekFINHptM3ZabG9QeU1FVno3Z0ZnZEVMZUYxV09TUUV0LzJxWEl0R0FI?=
 =?utf-8?B?THh6YTZlOTg4WXJ2bkVVRUZVUFpOQ1M3WWd5anV6d1dXMnVQVml5SUV2RGMr?=
 =?utf-8?B?VjBqMmx6WjJXUGg2QnpNbFRCV01PVVIwd3dnZlkwazRGcldHTzdMY2lwL3B6?=
 =?utf-8?B?TGVLS3RvRE9waDZPS0Y1cjh0Vzc3ZXlqYm9lUjJ5bzE5cGkvOXhDMkJ6dzBz?=
 =?utf-8?B?eHdjdk9qMGdoNEoySHRYQldFZFBCRkRVeHhUOGFmUjFhblE1UDJUZ0ZrbllM?=
 =?utf-8?B?RWFZZGJkOWtZdmFTc0xLOFFURE1oT2wvSUhLMTNRa3Q2dklIam9FV0g5L2lS?=
 =?utf-8?B?UTJVbW1TbFhqbmxwTkJ0U1pkMUo2enFteXpsczN2SVZ2SFZXUld6N2IzZUVM?=
 =?utf-8?B?YkNQdnlwWTlvYjF2NXZ1L25KL05lVWs5L096UWdxbDNYYXBQMWlyaDFMNFdQ?=
 =?utf-8?B?eTFEYTdrQ1dqTGZ6c3pWeU5MbDlNZDFDUCswT28xcUp3Wm82dmNva1VQTVVD?=
 =?utf-8?B?L3FiK2FxWnRlNEhjRmNDM1pmUjhVRTRsaVhRSEJOMHJnMGVhZ2xyTmZFbEJy?=
 =?utf-8?B?UHpZdTYyMDNFQUxOTUZrRnhOc2o0TTFhc1lsUk5KdnhIVVhwTFh6WTk2cjdz?=
 =?utf-8?B?bWQ5dDVIcHE4dGdEQnpRVnZLalUydkwvOUNFTlBCYXdWeXUrSlV4UmE3T0gw?=
 =?utf-8?Q?u7Fy7waA?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1B72A66BB2D384B89FB49BF38AE3F79@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56848156-ea24-44a2-e87d-08d8c79afbc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 16:52:53.4728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5/HjQd8h5H8UXEP9XwJg0RsZjLVKqdVSzX/rIe/1TeTcUTTzGaHkLJ1bco4wjzT7mHNLJztCAYkZVDdqxiwGP9ptt0V89v8BQ7JY7TRO5l0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4623
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

SGksIFNhcmF2YW5hLA0KDQpPbiAyLzIvMjEgNjozMyBBTSwgU2FyYXZhbmEgS2FubmFuIHdyb3Rl
Og0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVu
dHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IFRoaXMgcGF0Y2gg
c2VyaWVzIHNvbHZlcyB0d28gZ2VuZXJhbCBpc3N1ZXMgd2l0aCBmd19kZXZsaW5rPW9uDQo+IA0K
PiBQYXRjaCAxLzMgYW5kIDMvMyBhZGRyZXNzZXMgdGhlIGlzc3VlIG9mIGZpcm13YXJlIG5vZGVz
IHRoYXQgbG9vayBsaWtlDQo+IHRoZXknbGwgaGF2ZSBzdHJ1Y3QgZGV2aWNlcyBjcmVhdGVkIGZv
ciB0aGVtLCBidXQgd2lsbCBuZXZlciBhY3R1YWxseQ0KPiBoYXZlIHN0cnVjdCBkZXZpY2VzIGFk
ZGVkIGZvciB0aGVtLiBGb3IgZXhhbXBsZSwgRFQgbm9kZXMgd2l0aCBhDQo+IGNvbXBhdGlibGUg
cHJvcGVydHkgdGhhdCBkb24ndCBoYXZlIGRldmljZXMgYWRkZWQgZm9yIHRoZW0uDQo+IA0KPiBQ
YXRjaCAyLzIgYWRkcmVzcyAoZm9yIHN0YXRpYyBrZXJuZWxzKSB0aGUgaXNzdWUgb2Ygb3B0aW9u
YWwgc3VwcGxpZXJzDQo+IHRoYXQnbGwgbmV2ZXIgaGF2ZSBhIGRyaXZlciByZWdpc3RlcmVkIGZv
ciB0aGVtLiBTbywgaWYgdGhlIGRldmljZSBjb3VsZA0KPiBoYXZlIHByb2JlZCB3aXRoIGZ3X2Rl
dmxpbms9cGVybWlzc2l2ZSB3aXRoIGEgc3RhdGljIGtlcm5lbCwgdGhpcyBwYXRjaA0KPiBzaG91
bGQgYWxsb3cgdGhvc2UgZGV2aWNlcyB0byBwcm9iZSB3aXRoIGEgZndfZGV2bGluaz1vbi4gVGhp
cyBkb2Vzbid0DQo+IHNvbHZlIGl0IGZvciB0aGUgY2FzZSB3aGVyZSBtb2R1bGVzIGFyZSBlbmFi
bGVkIGJlY2F1c2UgdGhlcmUncyBubyB3YXkNCj4gdG8gdGVsbCBpZiBhIGRyaXZlciB3aWxsIG5l
dmVyIGJlIHJlZ2lzdGVyZWQgb3IgaXQncyBqdXN0IGFib3V0IHRvIGJlDQo+IHJlZ2lzdGVyZWQu
IEkgaGF2ZSBzb21lIG90aGVyIGlkZWFzIGZvciB0aGF0LCBidXQgaXQnbGwgaGF2ZSB0byBjb21l
DQo+IGxhdGVyIHRoaW5raW5nIGFib3V0IGl0IGEgYml0Lg0KPiANCj4gTWFyZWssIEdlZXJ0LA0K
PiANCj4gSSBkb24ndCBleHBlY3QgdjIgdG8gZG8gYW55IGJldHRlciBmb3IgeW91ciBjYXNlcy4N
Cj4gDQo+IFRoaXMgc2VyaWVzIG5vdCBtYWtpbmcgYW55IGRpZmZlcmVuY2UgZm9yIE1hcmVrIGlz
IHN0aWxsIGEgbXlzdGVyeSB0bw0KPiBtZS4gSSBndWVzcyBvbmUgb2YgdGhlIGNvbnN1bWVycyBk
b2Vzbid0IHRha2UgdG9vIHdlbGwgdG8gaXRzIHByb2JlIChhbmQNCj4gaXQncyBjb25zdW1lcnMn
IHByb2JlKSBiZWluZyBkZWxheWVkIHRpbGwgbGF0ZV9pbml0Y2FsbCgpLiBJJ2xsIGNvbnRpbnVl
DQo+IGxvb2tpbmcgaW50byBpdC4NCj4gDQo+IE1hcmMsDQo+IA0KPiBUaGlzIHYyIHNob3VsZCBk
byBiZXR0ZXIgdGhhbiB2MSB3aXRoIGdwaW9saWIgc3R1YiBkcml2ZXIgcmV2ZXJ0ZWQuIEkNCj4g
Zm9yZ290IHRvIHRha2UgY2FyZSBvZiB0aGUgY2FzZSB3aGVyZSBtb3JlIHN1cHBsaWVycyBjb3Vs
ZCBsaW5rIGFmdGVyIEkNCj4gd2VudCBhbmQgZGVsZXRlZCBzb21lIG9mIHRoZSBsaW5rcy4gdjIg
aGFuZGxlcyB0aGF0IG5vdy4NCj4gDQo+IFR1ZG9yLA0KPiANCj4gWW91IHNob3VsZCBzdGlsbCBt
YWtlIHRoZSBjbG9jayBkcml2ZXIgZml4IChiZWNhdXNlIGl0J3MgYSBidWcpLCBidXQgSQ0KPiB0
aGluayB0aGlzIHNlcmllcyB3aWxsIGZpeCB5b3VyIGlzc3VlIHRvbyAoZXZlbiB3aXRob3V0IHRo
ZSBjbG9jayBkcml2ZXINCj4gZml4KS4gQ2FuIHlvdSBwbGVhc2UgZ2l2ZSB0aGlzIGEgc2hvdD8N
Cj4gDQoNCkRpZCB0aGUgZm9sbG93aW5nIHRlc3RzICh1c2luZyBzYW1hNV9kZWZjb25maWcgYW5k
IGF0OTEtc2FtYTVkMl94cGxhaW5lZC5kdHMpOg0KMS8gbW9kdWxhciBrZXJuZWwgd2l0aCB5b3Vy
IHYyIG9uIHRvcCBvZiBuZXh0LTIwMjEwMjAyLCBhbmQgd2l0aG91dCB0aGUgY2xvY2sNCmRyaXZl
ciBmaXg6IHRoZSBwcm9ibGVtIHBlcnNpc3RzLg0KDQoyLyBzdGF0aWMga2VybmVsIHdpdGggeW91
ciB2MiBvbiB0b3Agb2YgbmV4dC0yMDIxMDIwMiwgYW5kIHdpdGhvdXQgdGhlIGNsb2NrDQpkcml2
ZXIgZml4OiB0aGUgcHJvYmxlbSBwZXJzaXN0cy4gQ29tcGFyaW5nIHRvIHRoZSBwcmV2aW91cyB0
ZXN0LCBJIHNlZSB0aGF0DQp0aGUgbGlua3MgdG8gcG1jIGFyZSBkcm9wcGVkLiBJIGNhbiBzZWUg
dGhlIGZvbGxvd2luZyBvbmx5IHdpdGggZWFybHkgcHJpbnRrDQplbmFibGVkOg0KcGxhdGZvcm0g
ZmMwMDgwMDAuc2VyaWFsOiBEcm9wcGluZyB0aGUgbGluayB0byBmMDAxNDAwMC5wbWMNCkJ1dCBs
YXRlciBvbiwgdGhlIHNlcmlhbCBzdGlsbCBnZXRzIGRlZmVycmVkIHdhaXRpbmcgZm9yIHRoZSBk
bWEgY29udHJvbGxlcg0KdGhpcyB0aW1lOg0KcGxhdGZvcm0gZjgwMjAwMDAuc2VyaWFsOiBwcm9i
ZSBkZWZlcnJhbCAtIHN1cHBsaWVyIGYwMDEwMDAwLmRtYS1jb250cm9sbGVyIG5vdCByZWFkeQ0K
SSdsbCBjaGVjayB3aGF0IGhhcHBlbnMgaW4gdGhlIGRtYS1jb250cm9sbGVyLg0KDQozLyBtb2R1
bGFyIGtlcm5lbCB3aXRoIHlvdXIgdjIgYW5kIHRoZSBjbG9jayBkcml2ZXIgZml4IG9uIHRvcCBv
ZiBuZXh0LTIwMjEwMjAyOg0KSSBjYW4gYm9vdCB0aGUgYm9hcmQgYW5kIEkgaGF2ZSBhY2Nlc3Mg
dG8gdGhlIGNvbnNvbGUuIEkgc3RpbGwgaGF2ZSBzb21lDQpwcm9iZSBkZWZlcnJhbHMgdGhhdCBJ
IG5lZWQgdG8gY2hlY2s6DQpyb290QHNhbWE1ZDIteHBsYWluZWQtc2Q6fiMgZG1lc2cgfCBncmVw
IC1pIGRlZmVyDQpbICAgIDQuMzM1NjI1XSBwbGF0Zm9ybSBiMDAwMDAwMC5zZGlvLWhvc3Q6IHBy
b2JlIGRlZmVycmFsIC0gd2FpdCBmb3Igc3VwcGxpZXIgcG1pY0A1Yg0KWyAgICA0LjQ3NDU1OV0g
cGxhdGZvcm0gZmMwMzAwMDAuYWRjOiBwcm9iZSBkZWZlcnJhbCAtIHdhaXQgZm9yIHN1cHBsaWVy
IHBtaWNANWINClsgICAgNC44ODQzMTVdIGNhbGxpbmcgIGRlZmVycmVkX3Byb2JlX2luaXRjYWxs
KzB4MC8weGQ4IEAgMQ0KWyAgICA0Ljg4OTIwNl0gcGxhdGZvcm0gZmMwMzAwMDAuYWRjOiBwcm9i
ZSBkZWZlcnJhbCAtIHdhaXQgZm9yIHN1cHBsaWVyIHBtaWNANWINClsgICAgNS4xMzk0NDddIGlu
aXRjYWxsIGRlZmVycmVkX3Byb2JlX2luaXRjYWxsKzB4MC8weGQ4IHJldHVybmVkIDAgYWZ0ZXIg
MjQ1MTMyIHVzZWNzDQpyb290QHNhbWE1ZDIteHBsYWluZWQtc2Q6fiMgZG1lc2cgfCBncmVwIC1p
IGxpbmtlZA0KWyAgICA0LjkxNjM0Ml0gcGxhdGZvcm0gZmMwMzAwMDAuYWRjOiBMaW5rZWQgYXMg
YSBjb25zdW1lciB0byAwLTAwNWINClsgICAgNC45MjEyOThdIHBsYXRmb3JtIGIwMDAwMDAwLnNk
aW8taG9zdDogTGlua2VkIGFzIGEgY29uc3VtZXIgdG8gMC0wMDViDQpbICAgIDQuOTI2ODE3XSBp
MmMgMC0wMDViOiBMaW5rZWQgYXMgYSBzeW5jIHN0YXRlIG9ubHkgY29uc3VtZXIgdG8gZmMwMzgw
MDAucGluY3RybA0KWyAgICA0Ljk5MDI0Nl0gcGxhdGZvcm0gYWN0ODk0NWEtY2hhcmdlcjogTGlu
a2VkIGFzIGEgY29uc3VtZXIgdG8gZmMwMzgwMDAucGluY3RybA0KWyAgICA1LjA3ODQ4OF0gYXQy
NCAxLTAwNTQ6IExpbmtlZCBhcyBhIGNvbnN1bWVyIHRvIHJlZ3VsYXRvci4wDQpbICAgIDUuMTEx
NTMzXSBhdDkxLXNhbWE1ZDJfYWRjIGZjMDMwMDAwLmFkYzogTGlua2VkIGFzIGEgY29uc3VtZXIg
dG8gcmVndWxhdG9yLjUNClsgICAgNS4xMTg5NjldIHNkaGNpLWF0OTEgYjAwMDAwMDAuc2Rpby1o
b3N0OiBMaW5rZWQgYXMgYSBjb25zdW1lciB0byByZWd1bGF0b3IuMw0Kcm9vdEBzYW1hNWQyLXhw
bGFpbmVkLXNkOn4jIGRtZXNnIHwgZ3JlcCAtaSBkcm9wDQpbICAgIDUuMDE0MDI2XSBhY3Q4OTQ1
YSAwLTAwNWI6IERyb3BwaW5nIHRoZSBsaW5rIHRvIGZjMDM4MDAwLnBpbmN0cmwNCg0KNC8gc3Rh
dGljIGtlcm5lbCB3aXRoIHlvdXIgdjIgYW5kIHRoZSBjbG9jayBkcml2ZXIgZml4IG9uIHRvcCBv
ZiBuZXh0LTIwMjEwMjAyOg0KSSBjYW4gYm9vdCB0aGUgYm9hcmQgYW5kIEkgaGF2ZSBhY2Nlc3Mg
dG8gdGhlIGNvbnNvbGUuIFRoZSBwcm9iZSBkZWZlcnJhbHMgYXJlIHRoZQ0Kc2FtZSBhcyBpbiB0
ZXN0IDMvLg0KDQpDaGVlcnMsDQp0YQ0K
