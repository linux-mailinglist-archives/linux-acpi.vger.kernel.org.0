Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86133699C8
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Apr 2021 20:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbhDWSgY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 23 Apr 2021 14:36:24 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:64757 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhDWSgX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Apr 2021 14:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1619202947; x=1650738947;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lkmB2Y+uTivV48AG9VtgLgvWJ/k7J3oXNdIV6k+0kI0=;
  b=1B09dsLIGFHPNP5plrkrHcm/zNZKUuxizlrZFdS01hMHuWfyuiJVlPs8
   fJljzeSScpTO2SQ5ClHx0ueZ4Z8Gxh3Rp4MwETEZNj1S5C8ge/9wk+2An
   GowTYaDY4Bz5oF/zEVp7wE1R6g6KUh91AVGMlwuop2urt3JNDjvwCIMl/
   FV2C9sb6lTq0uWSbbF2Us/GbZspHHdyn4E6u3QWZqww0xRIerjLQ7OeIE
   d5QITTHui4lPraP4WXXTHR8rCFVi3KTvuaavwKkMJ7GJekybvP+R90hsN
   bVWJDxLOH+2bzwL3M0eNCkDlGEkcD2vOnqGR0e4Hq13fqKAJal4QbLKBV
   g==;
IronPort-SDR: fZ887GnreMVbYXn/3487r8DmTm3Sg4YybAr7pa1YfHBGYcoUrtx5om8cAMIhJEbXIrvjVneADP
 +We0os6tQjpwv4SVrlnJOCERQJKJitJ/M34gmpy+9YrZaft06M1d2pZIJ6vuVUJ4A2HlUrqklJ
 t89OV1B8IJfm72VmX9HfCTwL5N0eEYSJER3hlxljsy9YOAhETvmJMmEiuWTCRBYwtVUBUsYxwE
 btEE40PnJvxRxWRfYmASzGl/U3Tneo+pjfQ0cz+WE8jrEkMvb8vSSgj8pwqAoc70+3i4AznzEY
 lpo=
X-IronPort-AV: E=Sophos;i="5.82,246,1613458800"; 
   d="scan'208";a="124339674"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Apr 2021 11:35:45 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 23 Apr 2021 11:35:45 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Fri, 23 Apr 2021 11:35:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I49+ehKMTzb9HxZ/30HPttN7FTz/W4EUskmo40evCeUNoL55gAnwMcJc+XpiJHrsS7fQlvUXTU+KNbV2WEGJHO+utNZMJl7qpDZWFrrzVop/W9JRP0+Dv0+c5gUJod+XHdC+mQRWCM3Ip9hkEMU5xYfj2q/LE3uSvg493oqK0fza9LYMym8wKZfNesDUyLDJG1ngZAOBj2MiTFwxygPwvvZ/6sBqzzIl70UK9FViQ0Jn++aAyXmcvZlTv9wxxHpm/a/8lpGtyW/ZKDATuppSjC1ioB8Oxx6ROvq2di6MISM0aiBqriXEyaQ+AWod/lcxvWkaJLg+vt29LLVM3jzw/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lkmB2Y+uTivV48AG9VtgLgvWJ/k7J3oXNdIV6k+0kI0=;
 b=R3sC+nijRLzRTB64EDjnXzrkWCTaIn9BkRwFU0mIj4DaZTpOT9glQyClEqjxcvFpIiZY0gN9v48xBZWvTGiSGzNQWrRf9CL/23wz7lgeRLDTrliDau2DLOWdVhOmTK+tO2PYdgwkIgbr+VVsSnVfaSNwdXoqmjYoOarfHJTo9g9pv8DSh9JoNt3Lw3TpjfcpcyND2PISg9T5A1Ujx2Qo0NnMsV5mxdbpoVjR3gagku1wZkVd/sYYrwfbUsYJItewQ3BOi1dGDBlxF0WAif4GtnMkLfQvZ4dTwmwe2YAyK0yzqbSrSwgRSZkPVk7HXEfgqRXNSo46gRpFtiEy9fzX2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lkmB2Y+uTivV48AG9VtgLgvWJ/k7J3oXNdIV6k+0kI0=;
 b=Z6NgMiQVZmc21t99Rmjqx4m48VdiqZRnu6tFi9oH1ZKqhPccG3UmSw7iKHEIl2yLyJe4NVnrWuK/1f2DVZVoaR9eclZhZ0uh0ejeJOF1yjJAnUKPZHWAvHO6XD+dP2TmMvyLDEJUD7NExDqixHgB3o1YPPhc7PWstybf3yEGX8Y=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by MWHPR1101MB2222.namprd11.prod.outlook.com (2603:10b6:301:57::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Fri, 23 Apr
 2021 18:35:42 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::4c:25f5:287a:e40d]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::4c:25f5:287a:e40d%7]) with mapi id 15.20.4065.021; Fri, 23 Apr 2021
 18:35:42 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <nsaenz@kernel.org>, <saravanak@google.com>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>, <maxime@cerno.tech>,
        <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <khilman@kernel.org>, <ulf.hansson@linaro.org>,
        <len.brown@intel.com>, <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>, <maz@kernel.org>, <tglx@linutronix.de>,
        <geert@linux-m68k.org>, <nsaenzjulienne@suse.de>,
        <linux@roeck-us.net>, <guillaume.tucker@collabora.com>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <corbet@lwn.net>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <linux-doc@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <kernel-team@android.com>,
        <linux-rpi-kernel@lists.infradead.org>, <m.szyprowski@samsung.com>
Subject: Re: [PATCH 1/2] clk: Do not register provider with a NULL
 dev->of_node
Thread-Topic: [PATCH 1/2] clk: Do not register provider with a NULL
 dev->of_node
Thread-Index: AQHXOGQLsms0SckXd0K2TYkTE0LfgKrCWl0AgAAP84CAAAPUgA==
Date:   Fri, 23 Apr 2021 18:35:42 +0000
Message-ID: <2165b512-6f01-707b-2276-20a20899b19f@microchip.com>
References: <20210423171335.262316-1-tudor.ambarus@microchip.com>
 <20210423171335.262316-2-tudor.ambarus@microchip.com>
 <CAGETcx-81hPTW_EVexMWaxGSOknuK-zESqKdiuQvye=n3TaHkA@mail.gmail.com>
 <528ab89224ba27f6164135a8ac00a828e7113805.camel@kernel.org>
In-Reply-To: <528ab89224ba27f6164135a8ac00a828e7113805.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [82.77.80.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 212137b6-667d-4c94-e206-08d9068699c8
x-ms-traffictypediagnostic: MWHPR1101MB2222:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB22222E1F3395671408B19BD1F0459@MWHPR1101MB2222.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lErXMZ7p7DFWQo1YDFEoiy/YzLiW0Oe+dI7AwwAT8Ufue+03+q/w5Ip4R2A6Coish1bjZo2/n4eR41mMDhN1jaD483iD/wxGWFPDD4C4MgAv/dbGbLwRZcfWy2zvYbW+yTqHIYN+4vynn8tC7MEFoUG4Zyxtc2rTqPBKl86r0IKUjo2iB95AzRtQmwj5MXBCiWNjDbHX3pQKaZ2GsB87hgmgXtY5bbPTOuL6LDCCHOgyW81y4XfTioI7/QzbzTI4QOI5nK7B2VWmJ9AqduLhmfdsNEzhalTcWGpyfD1oHVMzkCITcpy5h8LsADQedkNoABPcs7WL+OxFQYc4eoeI0srWTAnuaQ1KHfBau2nBEtJscRYACNVOWB0rK6GW3S92OAVO5l2T80lnq/CKQrlEqpqInqlpddK9v0iqQYEpzh5uCItCkWIjbfmiUBBkgo4ENEcFOcXJe2psCL083jvPxkc9aKc0ai7h10ymM9bjGs8eYDw0YRZ2E/CP0UvMw9W8SeYYm5LETHSKmwIeJddT9jLAXuavNa1z22TPkOXOWv+nQMEexGxu6dW41IQ1cC5mRVG8OKxmmUamPIf5rCpqXuE/98cfj7TCG8/FbXK3ecdDnWXSPnRn+o9F2MEwXZWC/zKMk83pNXJa3yE8k71SXL7TEkWiSPsylwEbaWCZYmBo2B0QMBSOZDyab3hgq4Fh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(366004)(346002)(376002)(396003)(76116006)(91956017)(66946007)(53546011)(186003)(7416002)(6506007)(2616005)(6512007)(71200400001)(26005)(122000001)(38100700002)(5660300002)(66556008)(66476007)(64756008)(478600001)(8936002)(66446008)(4326008)(316002)(2906002)(31696002)(83380400001)(31686004)(36756003)(54906003)(6486002)(8676002)(110136005)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Tm1FdlNINnNwUlpBbmJsNy81VmdzNFovQlluVkhma0hDc21FWnorcmlPNktt?=
 =?utf-8?B?RUFYNzF5OVR6aXdQM0FNb3RBQ3JUTzZMQWQ4SHBrSW5nT2JBMFJwa0c0UzRw?=
 =?utf-8?B?V3RJUnIrRy9McTJ5M1JUZ1Z1M05YL1hTeGY3bHc4Y2JycUp1Q0h0VUJwZGto?=
 =?utf-8?B?bFBKNmpSbG1jWVlPblBCNkhDdTNKV3Z4bWxLTEJSU0FzUHpmNFI4NEVibGJU?=
 =?utf-8?B?ZHk2elVtUGtTaUJ0TWtKdHVLWDlwaWVPNXY3cWpZM0w2Rm5YTjdXemErTFJM?=
 =?utf-8?B?Z3dpRml3aDBTVDRBNFRXaHNyaGltZCtERG01VDUzM0swaVNVcCtKQm4wZVFG?=
 =?utf-8?B?eUJWKytmQitPUFpHQmc2ODBRTGt0L1pjZXoveXBGNG4yK3g4bmxjejQrUFJ6?=
 =?utf-8?B?QzdDdStwREdCdUsrVFMxUTJISzRVaVJRdE1YRXNESXNqNC9peUk2NzJLL0FN?=
 =?utf-8?B?TldpcUljWXNVZUpCaWFhRTBER2daTER3SUFFbWdxWmIwUE1wYnhmM0xsU2VD?=
 =?utf-8?B?ZkR1VmltRFdxTXFleWhwRmVJZWxSdkxjN0lpT3hlV2F5eHBMOFZCRWZ6Z3Bo?=
 =?utf-8?B?WUdyZkpSYkd3VXl1Y0Jwb3dkTUdVRDdDQ3RUbTh1TkdHNm5ZSlo4YmZObFNa?=
 =?utf-8?B?QTZMMmVWR3VaN0daRWNuNFUrb0wxOVE1RzFuNENjU1phTnlQdldzaGxwMjFL?=
 =?utf-8?B?STRBWWMwUllwS2Vac2VTcXhMZE0rZ29VcmpWYlV1TzVPbGJDUDNmUFNUVzZV?=
 =?utf-8?B?ZkJsdEthQk5qVng0RkluY3RjNmJlUjg0YUlpbXV2N1M1bGJCR1lJNjZZSmJv?=
 =?utf-8?B?T3hOaVJaTnk2OW4rMld6K1RSNk9oVXpmeDk2Tm9Yc3hNWjNqdGN3aGtTbjA1?=
 =?utf-8?B?MmVkNW53bHlsRTBTc1pOekUzb0ZsZUZpOFhDZER4V3UzNnRvbzZMYkFvUHZK?=
 =?utf-8?B?NExQZ3RFZVUyN0ppY0I1M1BzdVZGR05OTGlsWmkzNlh6R2F5OFpvdHp6T2xG?=
 =?utf-8?B?czkxRmVaTGQ5ODlpSmNod3VvZ1loK3drSDVqUUlUWmg3S3lRWUQrYk5Xc2Qy?=
 =?utf-8?B?YWg0UnlGYTNJUm1tMTAvTzg0UGVrMDYrUFM3UEhTMVl0QnRvSGkyNXJtVTVz?=
 =?utf-8?B?ekRxWEZUSmg3SE1KU0xTL0greHdYSXkzUHROUDkwNWgrZTJGYjRIc1hwMFgr?=
 =?utf-8?B?eFRqd0dWcWdMRVhiQ1lXQkhRelFXUjAxemlmYmp6N2F4N1ZXd0VHOXVLa2FH?=
 =?utf-8?B?dmNPLy9sUjhHRmJSYWwzUy9TWWpkSFh3VnFHcy91V0tKWVp5NE5nT1RvemhX?=
 =?utf-8?B?OHREYUtEQnJqcGJ3NjRLV2xIVEs5WTRKakQzcWdaZkhrWlp6cWxHVzBBdk1p?=
 =?utf-8?B?OEticFpNVW9BTTNyZUxZcWdlOVN3UHRWb3BhWEREc3VQLzYxcnZqRVZnNG1z?=
 =?utf-8?B?UG1USFZzejh1cE90N0hFS2ZHWDlUZWI2U0FreXpxYlNKUEFPMkorbGttWTZR?=
 =?utf-8?B?aGUyd0krcjd4cDZ0Q0pqdHZDRmpJb1JHYnowaVZyYnl0d3FUNWowdDBYZ2Na?=
 =?utf-8?B?TWI4c2tJblk3M2psTDYzNmFjNjBUbDJQRXVPSGxyVmhUTWFJZndPTGl0THht?=
 =?utf-8?B?K0lJTWZ6TlFuRS9OSkZsY0kwZVA3UFNpcmNYWHNnU1lIWlZ5WmltbVRSRElR?=
 =?utf-8?B?em1JQm5yRStvVW9JTTVQdmFDRyt1Y2wxbG9tVGwvU1F3WmpMZzFaSlE5SVlE?=
 =?utf-8?Q?IiHeCp4y98igLVP9Ys=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <08394DA9A436974FACF72B17F03BB717@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 212137b6-667d-4c94-e206-08d9068699c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2021 18:35:42.3804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hdF51ss2mCEwKGE7NzLKDpn4VWGbBadlkKljG6KW5ztM/n9oU73SdCu4hizYW/168ZNNEFKW+XEjB5YFozA8jxMA2Fe9cacgUYJZZXy3XEI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2222
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

T24gNC8yMy8yMSA5OjIxIFBNLCBuaWNvbGFzIHNhZW56IGp1bGllbm5lIHdyb3RlOg0KPiBFWFRF
Uk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNz
IHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEhpIFNhcmF2YW5hLCBUdWRvciwN
Cj4gDQo+IE9uIEZyaSwgMjAyMS0wNC0yMyBhdCAxMDoyNCAtMDcwMCwgU2FyYXZhbmEgS2FubmFu
IHdyb3RlOg0KPj4gT24gRnJpLCBBcHIgMjMsIDIwMjEgYXQgMTA6MTQgQU0gVHVkb3IgQW1iYXJ1
cw0KPj4gPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbT4gd3JvdGU6DQo+Pj4NCj4+PiBjb21t
aXQgNjU3OWM4ZDk3YWQ3ICgiY2xrOiBNYXJrIGZ3bm9kZXMgd2hlbiB0aGVpciBjbG9jayBwcm92
aWRlciBpcyBhZGRlZCIpDQo+Pj4gcmV2ZWFsZWQgdGhhdCBjbGsvYmNtL2Nsay1yYXNwYmVycnlw
aS5jIGRyaXZlciBjYWxscw0KPj4+IGRldm1fb2ZfY2xrX2FkZF9od19wcm92aWRlcigpLCB3aXRo
IGEgTlVMTCBkZXYtPm9mX25vZGUuDQo+Pj4NCj4+PiBkZXZtX29mX2Nsa19hZGRfaHdfcHJvdmlk
ZXIoKSBzaG91bGQgbm90IHJlZ2lzdGVyIHRoZSBwcm92aWRlciB3aXRoDQo+Pj4gYSBOVUxMIGRl
di0+b2Zfbm9kZSwgYXMgdGhlcmUgaXMgbm8gb2Zfbm9kZS4gQXBhcnQgb2YgdGhlIE5VTEwgcG9p
bnRlcg0KPj4+IGRlcmVmZXJlbmNlIHRoYXQgd2lsbCByZXN1bHQgd2hlbiBjYWxsaW5nIGZ3bm9k
ZV9kZXZfaW5pdGlhbGl6ZWQoKSBpbg0KPj4+IG9mX2Nsa19hZGRfaHdfcHJvdmlkZXIoKSwgYW5v
dGhlciBwcm9ibGVtIGlzIHRoYXQgd2hlbiB0d28gZHJpdmVycyBjYWxsaW5nDQo+Pj4gb2ZfY2xr
X2FkZF9od19wcm92aWRlcigpIHdpdGggbnAgPSBOVUxMLCB0aGVpciB1bnJlZ2lzdHJhdGlvbiBv
cmRlciBpcyBub3QNCj4+PiBndWFyYW50ZWVkIHRvIGJlIGNvcnJlY3QuIEF2b2lkIGFsbCB0aGUg
cHJvYmxlbXMgYW5kIGp1c3QgcmV0dXJuIC1FTk9ERVYNCj4+PiB3aGVuIHRoZSBjYWxsZXJzIG9m
IGRldm1fb2ZfY2xrX2FkZF9od19wcm92aWRlcigpIHVzZSBhIE5VTEwgZGV2LT5vZl9ub2RlLA0K
Pj4+IHdoaWNoIHNlZW1zIHRoZSBuYXR1cmFsIHdheSB0byBkby4NCj4+Pg0KPj4+IFJlcG9ydGVk
LWJ5OiBNYXJlayBTenlwcm93c2tpIDxtLnN6eXByb3dza2lAc2Ftc3VuZy5jb20+DQo+Pj4gRml4
ZXM6IDY1NzljOGQ5N2FkNyAoImNsazogTWFyayBmd25vZGVzIHdoZW4gdGhlaXIgY2xvY2sgcHJv
dmlkZXIgaXMgYWRkZWQiKQ0KPj4+IFNpZ25lZC1vZmYtYnk6IFR1ZG9yIEFtYmFydXMgPHR1ZG9y
LmFtYmFydXNAbWljcm9jaGlwLmNvbT4NCj4+PiAtLS0NCj4+PiAgZHJpdmVycy9jbGsvY2xrLmMg
fCAxMiArKysrKysrLS0tLS0NCj4+PiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwg
NSBkZWxldGlvbnMoLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9jbGsuYyBi
L2RyaXZlcnMvY2xrL2Nsay5jDQo+Pj4gaW5kZXggZTJlYzFiNzQ1MjQzLi44YjUwNzdjYzVlNjcg
MTAwNjQ0DQo+Pj4gLS0tIGEvZHJpdmVycy9jbGsvY2xrLmMNCj4+PiArKysgYi9kcml2ZXJzL2Ns
ay9jbGsuYw0KPj4+IEBAIC00NjM0LDExICs0NjM0LDEwIEBAIHN0YXRpYyBzdHJ1Y3QgZGV2aWNl
X25vZGUgKmdldF9jbGtfcHJvdmlkZXJfbm9kZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+Pj4gICAq
IEBnZXQ6IGNhbGxiYWNrIGZvciBkZWNvZGluZyBjbGtfaHcNCj4+PiAgICogQGRhdGE6IGNvbnRl
eHQgcG9pbnRlciBmb3IgQGdldCBjYWxsYmFjaw0KPj4+ICAgKg0KPj4+IC0gKiBSZWdpc3RlcnMg
Y2xvY2sgcHJvdmlkZXIgZm9yIGdpdmVuIGRldmljZSdzIG5vZGUuIElmIHRoZSBkZXZpY2UgaGFz
IG5vIERUDQo+Pj4gLSAqIG5vZGUgb3IgaWYgdGhlIGRldmljZSBub2RlIGxhY2tzIG9mIGNsb2Nr
IHByb3ZpZGVyIGluZm9ybWF0aW9uICgjY2xvY2stY2VsbHMpDQo+Pj4gLSAqIHRoZW4gdGhlIHBh
cmVudCBkZXZpY2UncyBub2RlIGlzIHNjYW5uZWQgZm9yIHRoaXMgaW5mb3JtYXRpb24uIElmIHBh
cmVudCBub2RlDQo+Pj4gLSAqIGhhcyB0aGUgI2Nsb2NrLWNlbGxzIHRoZW4gaXQgaXMgdXNlZCBp
biByZWdpc3RyYXRpb24uIFByb3ZpZGVyIGlzDQo+Pj4gLSAqIGF1dG9tYXRpY2FsbHkgcmVsZWFz
ZWQgYXQgZGV2aWNlIGV4aXQuDQo+Pj4gKyAqIFJlZ2lzdGVycyBjbG9jayBwcm92aWRlciBmb3Ig
Z2l2ZW4gZGV2aWNlJ3Mgbm9kZS4gSWYgdGhlIGRldmljZSBub2RlIGxhY2tzDQo+Pj4gKyAqIG9m
IGNsb2NrIHByb3ZpZGVyIGluZm9ybWF0aW9uICgjY2xvY2stY2VsbHMpIHRoZW4gdGhlIHBhcmVu
dCBkZXZpY2UncyBub2RlIGlzDQo+Pj4gKyAqIHNjYW5uZWQgZm9yIHRoaXMgaW5mb3JtYXRpb24u
IElmIHBhcmVudCBub2RlIGhhcyB0aGUgI2Nsb2NrLWNlbGxzIHRoZW4gaXQgaXMNCj4+PiArICog
dXNlZCBpbiByZWdpc3RyYXRpb24uIFByb3ZpZGVyIGlzIGF1dG9tYXRpY2FsbHkgcmVsZWFzZWQg
YXQgZGV2aWNlIGV4aXQuDQo+Pj4gICAqDQo+Pj4gICAqIFJldHVybjogMCBvbiBzdWNjZXNzIG9y
IGFuIGVycm5vIG9uIGZhaWx1cmUuDQo+Pj4gICAqLw0KPj4+IEBAIC00NjUwLDYgKzQ2NDksOSBA
QCBpbnQgZGV2bV9vZl9jbGtfYWRkX2h3X3Byb3ZpZGVyKHN0cnVjdCBkZXZpY2UgKmRldiwNCj4+
PiAgICAgICAgIHN0cnVjdCBkZXZpY2Vfbm9kZSAqKnB0ciwgKm5wOw0KPj4+ICAgICAgICAgaW50
IHJldDsNCj4+Pg0KPj4+ICsgICAgICAgaWYgKCFkZXYtPm9mX25vZGUpDQo+Pj4gKyAgICAgICAg
ICAgICAgIHJldHVybiAtRU5PREVWOw0KPj4+ICsNCj4+DQo+PiBCYXNlZCBvbiB0aGUgb3RoZXIg
ZGlzY3Vzc2lvbnMsIGZvciBub3csIGp1c3QgcmV0dXJuIDAuIFRoZSBlcnJvcg0KPj4gbWlnaHQg
Y2F1c2Ugb3RoZXIgaXNzdWVzIGluIG90aGVyIGRyaXZlcnMuIFdlIGNhbiBjbGVhbiB0aGlzIHVw
IGxhdGVyLg0KPiANCj4gKzEsIExldCdzIHJldHVybiAwIGFuZCBkbyBub3RoaW5nIHNraXAgdGhl
IGxvZ2ljIGluIHRoZSBkcml2ZXIuDQo+IA0KPiBOb3csIGZyb20gd2hhdCBJIHJlYWQgaW4gZGV2
bV9vZl9jbGtfYWRkX2h3X3Byb3ZpZGVyKCksIHRoZXJlIGlzIGEgdXNlIGNhc2UgZm9yDQo+IGVu
dGVyaW5nIHdpdGggJyFkZXYtPm9mX25vZGUnLiBTZWUgZ2V0X2Nsa19wcm92aWRlcl9ub2RlKCkn
cyB1c2FnZS4gU28gSSB0aGluaw0KPiB3ZSBzaG91bGQgb25seSBiYWlsIGlmIHRoYXQgZnVuY3Rp
b24gZmFpbHMgdG8gcHJvdmlkZSBhIGRldmljZV9ub2RlLg0KPiANCg0KT2gsIHllcywgdGhlIGVy
cm9yIHNob3VsZCBoYXZlIGJlZW4gYWZ0ZXIgdGhlIGdldF9jbGtfcHJvdmlkZXJfbm9kZSgpLg0K
QW55IHdheSwgd2lsbCBzZW5kIHRoZSByZXR1cm4gMCB2YXJpYW50IHRvby4NCg0KQ2hlZXJzLA0K
dGENCiANCg0K
