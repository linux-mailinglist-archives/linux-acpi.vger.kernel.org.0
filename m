Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4248A369AD0
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Apr 2021 21:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbhDWTRO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 23 Apr 2021 15:17:14 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:40156 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhDWTRN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Apr 2021 15:17:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1619205397; x=1650741397;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=32oVdMCPXgVZgbF3VPpXGl4s/tEdl4jF6EsqV6YiJIk=;
  b=gsErsuuzw8G0dZAFRevANE8ZMBCZNzx5wS0+w79w3iLt6fOr+EYP5N1h
   iQ9icc6EYdJ6+f5pooIgw0ilsuTkWaiGQiJ5nfWvEqrLfIIFWdYRQhKFx
   gWUvGnb7jkOmAR2M+SjCroO8sn9JO51AqCLWY1hVxhEeASg5tgxUi2Nys
   Myenfm1zDAwn+ZvY1f3Od8lkk9reeMmI6ZvuqW0lqf7VDH6gQvU9xsDP2
   QenihZC5XaLwuL5lGyqGhrY6dTEW3z/eG4IFQy9l5JfMKhDeuZQXLUww+
   sqId3aYlelUaUylfBhxA0vxAp/bCNpmP2vZEqW8+6QksaPwJ99S3dD0mB
   g==;
IronPort-SDR: /vcA2duPCoVUNBh8fMhoL4fYi9SUw0OWb2oKviHXZTrdGGX/kof5y3X+iWaAZaIs9JjKJB1Q3Y
 5zcCUZ0kHuLP6jxQ3wafjXYj3YB86WgxmQQwZypRFEGbtUr5nCWIJVu9LirB7H74RJrHZlq+ZF
 jNad3LnPU9kxXsglnLFbs49CO0jP0PTuieJnBOxb7NMuUXKXdlfRY7WL8WkHIj8OrL8IfVC3ga
 I7Ggvqg8XoThhTKUYuGF+elkHgW0ATYC11DUaiW12cvFVWC4HiUSpAgj6PDlfE7kbXV3fivg4v
 /5k=
X-IronPort-AV: E=Sophos;i="5.82,246,1613458800"; 
   d="scan'208";a="114703435"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Apr 2021 12:16:36 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 23 Apr 2021 12:16:35 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Fri, 23 Apr 2021 12:16:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HdPOxYsKkaULLcqjIxArhCeQaPEbDyog7jfUQTOikKiBrllvKYxb6InWZIMrinunuuhurl/F4oD6WsL91xu/CFkQzR8sxe4jFYy+XZfL0t7g7xvnV/dAWsAqMyG2F9zBMBp+7XN5MUcsu9c0salvues7AFkcLgME2IOxo69HpSDQpJTyXPZsz4sYwLh2rpDU54dWWS/PVhAgckPVzyBOxiincHctvUSdaPFYFOVBnXV6XTwX/dS+UfsH9jRFR2ALnfTgfTrI2eO79RODarXRYQ4/4Q055AMFt0ZX+KoN6U3anjM3TOUUUcr8tLaJwaIEgLTVWZIuty3BUGkK+oHA6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32oVdMCPXgVZgbF3VPpXGl4s/tEdl4jF6EsqV6YiJIk=;
 b=WvRwjkLREbZ1xk6PiiSPEbD0EgVufo0um34JR8wfz0oCnsF9lTbSrQubxeOX17k2aQWSX5XlxColVhzozY8v+m+AKfGsxfPvRW5GwD0ajGr2GPty1WlCYQdZhfgqel0mkXxWjOMbQJo5dbIORFTlovVrmu6l0mX8mUuBbndw9N6zZfI7JVqxMalaGpPSHp7vT5X+EcNiCCZw5/fCnFXLT+WWK1glORZiVD1PkTmx+ycrpde1WN3YwneReFWnae/ga1d7NtaINsAPMJAR1MEYMDqpdq7ZxLxoRb4ABWsEpuTLxjIm4gR4ycvSjOJfqfuNM1MXUW+2IeidwkNJKP4j9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32oVdMCPXgVZgbF3VPpXGl4s/tEdl4jF6EsqV6YiJIk=;
 b=noNc/ZSew2ta97sm1fBkkTGJdCzd7CD1lCgoZNisiOYwkmlthnvehVWxSf5IRKdXhlJAfGOIzz5TQrthASMDs0rqo64qSHf00Gc5RsPnHie+1TrAi5fMVkaEPwNsaMhS8Zhl9248pyqcs4ChDuK2mbYtAWjtXb7d+QyczHBYTD0=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by MWHPR1101MB2270.namprd11.prod.outlook.com (2603:10b6:301:54::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Fri, 23 Apr
 2021 19:16:30 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::4c:25f5:287a:e40d]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::4c:25f5:287a:e40d%7]) with mapi id 15.20.4065.021; Fri, 23 Apr 2021
 19:16:30 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>, <nsaenz@kernel.org>,
        <maxime@cerno.tech>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <khilman@kernel.org>,
        <ulf.hansson@linaro.org>, <len.brown@intel.com>, <pavel@ucw.cz>,
        <robh+dt@kernel.org>, <frowand.list@gmail.com>, <maz@kernel.org>,
        <tglx@linutronix.de>, <saravanak@google.com>,
        <geert@linux-m68k.org>, <nsaenzjulienne@suse.de>,
        <linux@roeck-us.net>, <guillaume.tucker@collabora.com>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <corbet@lwn.net>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <linux-doc@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <kernel-team@android.com>,
        <linux-rpi-kernel@lists.infradead.org>, <m.szyprowski@samsung.com>
Subject: Re: [PATCH] clk: Skip clk provider registration when np is NULL
Thread-Topic: [PATCH] clk: Skip clk provider registration when np is NULL
Thread-Index: AQHXOHSx3OGtyPoatUKROvP5L/gVX6rCeWmA
Date:   Fri, 23 Apr 2021 19:16:30 +0000
Message-ID: <1a9f6d35-2c0e-df6b-f759-70edffa9c5b6@microchip.com>
References: <20210423171335.262316-1-tudor.ambarus@microchip.com>
 <20210423191236.265996-1-tudor.ambarus@microchip.com>
In-Reply-To: <20210423191236.265996-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
authentication-results: baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [82.77.80.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8fb2496-6895-4728-24a3-08d9068c4d0d
x-ms-traffictypediagnostic: MWHPR1101MB2270:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB2270B0F1D03E839EDD846106F0459@MWHPR1101MB2270.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y1DLNP0VEEUV5PWYNzvwLENmls4cm/Zzk3nvhVsM9aHEFWlCRnKnELMgpTd5ngtPEy03ZPT7B1csA3QP2U1fLizGRHwFOfK8Pyg9FlgYtSTSHPKNRkfxhyKk/nwD5/XUTPd6zweeFlwD7T/Cj6XnY+cfMN7yyrKhmpKgcASX0SId0hugmqKqG0PubMW9PX3SDdzS9Vr6dcarOKvm/JHYQDTINC2EkvqCaK+xeMhFEKJtZ6lvftbmjodT8qBMMwpZd91PkvT9+lN7A6/dQcophFwnFMQkAk+NbM23PXqWqeUTC7AxgN9Qf6e4S1y/M7NbNw9y+isMuNQ8ETY5z0SzFF3e3eZoikpLQLjO4Yxhs9bGpf9H2MfswtCXFPaXUHZ1CY3h/MjybIJc8X1FlchmYGYApdhZsCROcaibFdyen4UaxhkWzIzCVjQuiNDySLsPnvYW4RAtQ4s+7IaLpsxrwnSpiI+ShQgG6SGh6hWLu9e3pcIb3TgVVyjOg9o3iPJ1JGa8K7uZfaIuxGaPdpgsIo0nBJdCPwIyKCbpVSc+kDDzTgN0+MwpUOHiQiDOmoWFdBp6jQL5phpCI6S+pAwMlptrjXz9kbzLUtAN66io3y6vQeS32vlrfOwBphBjZ+O99EbJPbXQI8uZDYrq8ibJ0CHI+5GWTwt8Zr3rNSfUYou3prSllsMpGAMs7s1dga74cfgThCLhHJrtTG5VaGxzcw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(366004)(136003)(39860400002)(376002)(38100700002)(2616005)(6486002)(478600001)(76116006)(7416002)(64756008)(91956017)(66446008)(4326008)(66946007)(66556008)(66476007)(31686004)(71200400001)(186003)(8676002)(5660300002)(83380400001)(36756003)(122000001)(8936002)(6506007)(6512007)(53546011)(316002)(86362001)(31696002)(26005)(110136005)(54906003)(921005)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?aGVwT2NFLzM1MkprOGN2QXE4SEgxNE4vSTNpYmM4OHQxUlhHelBrVXBwUHJI?=
 =?utf-8?B?RC9YblFrS3JMei9Ic2pNWHF6bnJXMVByTnpYVGVwUURxbmZ3OFlvNWNHR2tK?=
 =?utf-8?B?cEtIVTRVVHg2cHdRdmlHWHcvRTJwa21jcTRPUFp4Si9YT3FXMStkaG9XUG5x?=
 =?utf-8?B?ZVYrUzVqVVdsTUZnSnpydTlFZ2RhbmRHZHVuQ1c1QTcxU0c2aVZEME9USElv?=
 =?utf-8?B?OStyYU1oSmx1ZFU0VlA5SzBHQm93UnI2aExBeStrak81Q2dRZkRUbm9ST1Nn?=
 =?utf-8?B?VC9ETnB1aUUzTG5rTm1NRnluNThyTG9kNkY5c0E4V2lqSURBazVmeUhwUmxH?=
 =?utf-8?B?ZkRlVWVVMVpOWmQ5anl0SCtzNG5CT2J3QmNLblpWc2NFdEU2QTFlOGZURjVq?=
 =?utf-8?B?aWlZampTQ0ZpUWF0S1lWWFVLU1lkQi8xQWc2blNmNU92ZEo5N0dTTU1tcld0?=
 =?utf-8?B?c2liNzZ1NjBUbVppMDAyQ1N4YjljQVJneEQxMGZObkFSR0tiK0xYQ3FOM0JW?=
 =?utf-8?B?dmh2REg3bTFyYVRoMkFzTjRLRzhZRVpBczhwQUhWMHVYQWxMT0R1OHlrUDFT?=
 =?utf-8?B?YzFrbFZHaDZhNk1UdktzWG9vL29uR3IyZHhyeVloL2psTU1uMS9wOTFBN0pq?=
 =?utf-8?B?Rm5aZ2ZEbTdKZ3F2TzBQNVdEcTlQczl0VW50aUFCdFRhbk04Q2Vrd3c3UlZI?=
 =?utf-8?B?MUszQVArdUFCQU8wcUp1ZGkyRHEvZHNZNXBoZkxiRVlUTzJ1S3FnUTlBRXhK?=
 =?utf-8?B?QVphNm1VK3plU3BkTVVpaDZic1JZRFRxTDdTLy81SFNMWHAzK2d0Mk9ERGY0?=
 =?utf-8?B?T2xCTTVpTUt5d0JwdTRvZmlnQk9KSGlET1Y1Y2RpeHdMTS9qUlpTKy9mN2RS?=
 =?utf-8?B?TjVYR1pkNWhXek5JdnpzcmwraXBrMmZSbW50eGJoK3NJak9OR3BGQmhOZDVC?=
 =?utf-8?B?Z05rT2lCVTNsL2xUWnNIS2RoZEJZbEQ5dS82dGNYbys2NVNoSjZIMUJHSHdo?=
 =?utf-8?B?SDRQd0puT3JiYTZYZzlCSkNub3U5UDNyQ3JiRzgrV2pWMVBUTE9yMWVKMDg2?=
 =?utf-8?B?NXNQb3pIZElscG8wV3hmTGFSZE5xcm9QaVFUWUZuc2J1QnlaWDVYc0hCNGdk?=
 =?utf-8?B?ckwrRjVvYXV1dTdtcWFDRWh2OXFEaGJidi9oVXNIdEg2NGkwRFZlRHZRbDMw?=
 =?utf-8?B?ZFZjZ3VnYUNTVTMrdENzelpEdEY3UkRvWUpOZTB0RllMbXYwUERVbWkxL2M3?=
 =?utf-8?B?Mmg1eTMwNW1uTkFKYnF5dFVQN1FVbDVYaUhEYzZJTTgwRWY0YWpxdFBFbWVR?=
 =?utf-8?B?WUFZR3gvRk14MFZCRm9mUFc4Y0IvM3F5M2lnZkFJT3NqR3p3WmZvYkxoUGdW?=
 =?utf-8?B?WTdzamlRNlhHcDFFeGc5eUhtaW14YlZnczBZcnE4c0Nwc1dnM0NaT0V2OUp2?=
 =?utf-8?B?Qi9IS0JoUFFoTy9pckhjM3VBaGkvYnZWL0c0N0paZ05YRUJCN2F2TFQvODVm?=
 =?utf-8?B?OTBWNkgxQ2doWGdpZUFoKzYvSWVmRzBpajFnY2NPdU1ud3Jqa1ZpTTlLenVC?=
 =?utf-8?B?STg5ZmZiLzcvZXM5ajRIT0IydzdyczNyVWtUdERWVVg5NkUxVXFrVEN1dlB2?=
 =?utf-8?B?TzF2UkxBL2RoR1N5ZTVxMWdvbmI5Y1FrdGc5Ty9XK0F0SFdhZGdsVTB2aFFX?=
 =?utf-8?B?b1BYVkJNdVlaNmFERzVleTVuZ0tqck5IN3NkZGFKd1RlZEVNbEpRZFo2MEkw?=
 =?utf-8?Q?d2dqJ231nkoa/dZ39s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3942E3D6A4C41845968B3F243F9D2CD7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8fb2496-6895-4728-24a3-08d9068c4d0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2021 19:16:30.6246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZnXGJUA1ojzX3TMwD4h8G+0sUCkt1PrPqq++a7FlIU4TgFWxQvTAmOMfQgkWzf35LZX5fevrWcFudhp/raPUiQteZPy2L583xt6MLYcRoCs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2270
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

T24gNC8yMy8yMSAxMDoxMiBQTSwgVHVkb3IgQW1iYXJ1cyB3cm90ZToNCj4gY29tbWl0IDY1Nzlj
OGQ5N2FkNyAoImNsazogTWFyayBmd25vZGVzIHdoZW4gdGhlaXIgY2xvY2sgcHJvdmlkZXIgaXMg
YWRkZWQiKQ0KPiByZXZlYWxlZCB0aGF0IGNsay9iY20vY2xrLXJhc3BiZXJyeXBpLmMgZHJpdmVy
IGNhbGxzDQo+IGRldm1fb2ZfY2xrX2FkZF9od19wcm92aWRlcigpLCB3aXRoIGEgTlVMTCBkZXYt
Pm9mX25vZGUsIHdoaWNoIHJlc3VsdGVkIGluIGENCj4gTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNl
IGluIG9mX2Nsa19hZGRfcHJvdmlkZXIoKSB3aGVuIGNhbGxpbmcNCnMvb2ZfY2xrX2FkZF9wcm92
aWRlcigpL29mX2Nsa19hZGRfaHdfcHJvdmlkZXIoKQ0KPiBmd25vZGVfZGV2X2luaXRpYWxpemVk
KCkuDQo+IA0KPiBSZXR1cm5pbmcgMCBpcyByZWR1Y2luZyB0aGUgaWYgY29uZGl0aW9ucyBpbiBk
cml2ZXIgY29kZSBhbmQgaXMgYmVpbmcNCj4gY29uc2lzdGVudCB3aXRoIHRoZSBDT05GSUdfT0Y9
biBpbmxpbmUgc3R1YiB0aGF0IHJldHVybnMgMCB3aGVuIENPTkZJR19PRg0KPiBpcyBkaXNhYmxl
ZC4gVGhlIGRvd25zaWRlIGlzIHRoYXQgZHJpdmVycyB3aWxsIG1heWJlIHJlZ2lzdGVyIGNsa2Rl
diBsb29rdXBzDQo+IHdoZW4gdGhleSBkb24ndCBuZWVkIHRvIGFuZCB3YXN0ZSBzb21lIG1lbW9y
eS4NCj4gDQo+IFJlcG9ydGVkLWJ5OiBNYXJlayBTenlwcm93c2tpIDxtLnN6eXByb3dza2lAc2Ft
c3VuZy5jb20+DQo+IEZpeGVzOiA2NTc5YzhkOTdhZDcgKCJjbGs6IE1hcmsgZndub2RlcyB3aGVu
IHRoZWlyIGNsb2NrIHByb3ZpZGVyIGlzIGFkZGVkIikNCj4gU2lnbmVkLW9mZi1ieTogVHVkb3Ig
QW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0KPiAtLS0NCj4gVGhpcyB3b3Vs
ZCBiZSB0aGUgc2Vjb25kIGFwcHJvYWNoLCB3aGVyZSB3ZSBkb24ndCByZXR1cm4gYW4gZXJyb3Ig
d2hlbg0KPiBvbmUgY2FsbHMgZGV2bV9vZl9jbGtfYWRkX2h3X3Byb3ZpZGVyIHdpdGggYSBOVUxM
IG9mX25vZGUsIGJ1dCBpbnN0ZWFkDQo+IHdlIGp1c3QgcmV0dXJuIDAgYW5kIHNraXAgdGhlIGxv
Z2ljIGluIHRoZSBjb3JlIGFuZCB0aGUgZHJpdmVycy4NCj4gDQo+ICBkcml2ZXJzL2Nsay9jbGsu
YyB8IDkgKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvY2xrLmMgYi9kcml2ZXJzL2Nsay9jbGsuYw0KPiBp
bmRleCBlMmVjMWI3NDUyNDMuLjVkMTBkYTM1MTlhYyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9j
bGsvY2xrLmMNCj4gKysrIGIvZHJpdmVycy9jbGsvY2xrLmMNCj4gQEAgLTQ1NDAsNiArNDU0MCw5
IEBAIGludCBvZl9jbGtfYWRkX3Byb3ZpZGVyKHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAsDQo+ICAJ
c3RydWN0IG9mX2Nsa19wcm92aWRlciAqY3A7DQo+ICAJaW50IHJldDsNCj4gIA0KPiArCWlmICgh
bnApDQo+ICsJCXJldHVybiAwOw0KPiArDQo+ICAJY3AgPSBremFsbG9jKHNpemVvZigqY3ApLCBH
RlBfS0VSTkVMKTsNCj4gIAlpZiAoIWNwKQ0KPiAgCQlyZXR1cm4gLUVOT01FTTsNCj4gQEAgLTQ1
NzksNiArNDU4Miw5IEBAIGludCBvZl9jbGtfYWRkX2h3X3Byb3ZpZGVyKHN0cnVjdCBkZXZpY2Vf
bm9kZSAqbnAsDQo+ICAJc3RydWN0IG9mX2Nsa19wcm92aWRlciAqY3A7DQo+ICAJaW50IHJldDsN
Cj4gIA0KPiArCWlmICghbnApDQo+ICsJCXJldHVybiAwOw0KPiArDQo+ICAJY3AgPSBremFsbG9j
KHNpemVvZigqY3ApLCBHRlBfS0VSTkVMKTsNCj4gIAlpZiAoIWNwKQ0KPiAgCQlyZXR1cm4gLUVO
T01FTTsNCj4gQEAgLTQ2NzYsNiArNDY4Miw5IEBAIHZvaWQgb2ZfY2xrX2RlbF9wcm92aWRlcihz
dHJ1Y3QgZGV2aWNlX25vZGUgKm5wKQ0KPiAgew0KPiAgCXN0cnVjdCBvZl9jbGtfcHJvdmlkZXIg
KmNwOw0KPiAgDQo+ICsJaWYgKCFucCkNCj4gKwkJcmV0dXJuIDA7DQo+ICsNCj4gIAltdXRleF9s
b2NrKCZvZl9jbGtfbXV0ZXgpOw0KPiAgCWxpc3RfZm9yX2VhY2hfZW50cnkoY3AsICZvZl9jbGtf
cHJvdmlkZXJzLCBsaW5rKSB7DQo+ICAJCWlmIChjcC0+bm9kZSA9PSBucCkgew0KPiANCg0K
