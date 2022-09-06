Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7B85AEE30
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Sep 2022 16:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbiIFOzh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Sep 2022 10:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbiIFOxJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Sep 2022 10:53:09 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2078.outbound.protection.outlook.com [40.107.95.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6F91116D;
        Tue,  6 Sep 2022 07:09:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=llSYJRLGssHsGCLDZSWD7YUu0i+BaUPWUY2Q58Bll1h3Z9oyKShLXCJPMjPmqW92Y61DGxho0wOX42Fnj4yy4Pzcs4qvWFKmpzW8l1YhT++aHY3nw/akKoBGyGosSlkORtXM5fPSqarRTIugaAjElHvno0heHm53/fLzPZmk0GsFW7lq81yo0fKTqCxLHQEaP16ASuBdh973QqTlIcL2I270S0wEbKqDJTIwmqKoIXUAB0vandXDyAfkbYnpShCPXlghWU68idCi7oV6k/85BjXJojfTVOAHZMeLiNsc7qp0KZG1ep7mlsoAGX/9Y04O4h4thUXSyIvv5FdodgUytg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGYdHveUco8vqCTyfodtwBmJGDoUdiASsHVduu/GryY=;
 b=FLRfV/RtQESdwihpu4DT3gtiPNgcoC7PbKYvJF3zbiti6ryInqwZVd2MEnr6HnLq80Vn+kVyRv5gArFVW/6ZTLoXvKUNdkmrXDfXYKj2zOBpPY/CATH5ivBFNRPQjzfWaoxJ7Yb/NyOvUQBf/5oByS78TJoswtftWdY93LnI9aXYoVpGvGeiYrHJVkpLGHUWFIYTiUYLwiV2Y0nduefn81x7ExgQdTh/pxpHJQxu2/qMSJNAMae0FmEbbLYP19S8vpTKuQIufcJ2zFeFvJ4NYEt8Klzjy0P2u5ouqF2hiFb8p4MquYaPd2kMfu9Zoq1jziVeMSlBWpm/Rhz7nNkI5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGYdHveUco8vqCTyfodtwBmJGDoUdiASsHVduu/GryY=;
 b=lzauoqrYVW/XdNhymPfvU3kHJNBr4WHgEaQfIIAjojnI2vwxSdSP6eiXy6eI6ZNXTJV387U0z+pns/yXJ3qUKkt/rhjL1bnifyB+wnSs8o2CnVN5eI50RzjRvWew4Dd3rUTdP4mB3MmvHcwLIcB0x+nSfjy3RwPOZnDvcKjXbr/HFgDAhwIbNXwyz0+sGwtb1oOihuW6XQDzVYqp9WrA8ZIHoe3AsAlFnUaUI56V5m9HnJe6htQWi3xxt2PWzUOe3e737z9JE543cLI4j+aVE4M0dqETSYxdIofpuxMBWcShCRzyGibnOVY+6ON+Q8KZ6L3k6ex1vjU91CJ9ngqmdw==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by SN7PR12MB7203.namprd12.prod.outlook.com (2603:10b6:806:2aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Tue, 6 Sep
 2022 14:08:33 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::25d3:32f3:4be5:da11]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::25d3:32f3:4be5:da11%7]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 14:08:32 +0000
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v1 1/1] Add driver for Mellanox BlueField-3 GPIO
 controller
Thread-Topic: [PATCH v1 1/1] Add driver for Mellanox BlueField-3 GPIO
 controller
Thread-Index: AQHYUy6f8PYDEwnjH0GY1hRsyl4qdK0QbjTwgAAQVwCAABikcIALQwgAgAAAjSCAAZckgIAELgbQgAM2cYCAqEdScIAAaVGAgAXGscA=
Date:   Tue, 6 Sep 2022 14:08:32 +0000
Message-ID: <CH2PR12MB3895981F3DBB2F551DA6AE95D77E9@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <20220418141416.27529-1-asmaa@nvidia.com>
 <CH2PR12MB3895A1FB2977B725ED92AB57D7C29@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CACRpkdY1uK=73zpEM5zUyXacm5xaUUFYkuKMxi_q6vwmOPy6tw@mail.gmail.com>
 <CH2PR12MB389560A1873030472A7A371DD7C29@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CACRpkdZhW9XK3opXLLzdMiVLVkGQyJCf7RLZtRQLsmzv-aqwbA@mail.gmail.com>
 <CH2PR12MB38953FF57D91FA75AB9CB102D7CB9@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CACRpkdbAhMa2CXvQra3E13n8WfiBxyHNqzEp4dW3qo5upr_=gw@mail.gmail.com>
 <CH2PR12MB38958CD365876A2106712C3CD7CF9@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CACRpkdZp9hx2SHxsmjBm2oj7m3UT-4S+MKw5qqNME0PLjPNV2A@mail.gmail.com>
 <CH2PR12MB3895B4E89237E6D6F635F252D77A9@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CACRpkdaHuQhzqqQbayGaRqYAcnyv2rmocX7YhcR_qj0HRVHkgQ@mail.gmail.com>
In-Reply-To: <CACRpkdaHuQhzqqQbayGaRqYAcnyv2rmocX7YhcR_qj0HRVHkgQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f3a020e-82d4-43f3-d892-08da90114859
x-ms-traffictypediagnostic: SN7PR12MB7203:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O3jGmEh1d3T+l6X+u1To73eMqvgGN6Ma7atwLkESib4vtK1W/54MMnsWaQtN0k5IAVsyVgKgOhSseMq8NrdS6kwEMti4HO05lYHeokP6cEaf0XXoi0GUhDB+ULShEyo+M04xwALT4dJOSH919CpUEXR1VFSnhwN0aKj/mJ05nM3gkIJYxs6zdpLKNE/BODhfqL/Xn+a6bOdtOx37VNSsKRU5EA2Ae1s870vzScVHtbu5RY1zJoe2feAdpmM9mvc23uQDnAgh08HP/947NMzkJryT2WM0k+8Eyos38QBWoxEiiU1+DwPwvNLSUaBadHy1xjeRs0OvfTGZExUOoxJctbI1HGz6eiPHUazfALtjMqrN85OtP5ThchcASSHojR19mxYJaj5FpHDKUxdTelzxXw4G+wsvtxbFst+lWyCpNw2gc2bzL6vj2iAYE11kCduADWbuDrmjB0WxAhbMBSt8Y0iua32OCGDBFI9t2fD4QHQ6Lk5MNklOL8JqXm7HyHhqi05aD4Mf6NVPQfJjdxkpBbcuYsRCrsUF/RAhEsCsTR+0Rx3O0b+e5UFAnhAtMjBHA8cbH4oKQuuDq9uKtVR5i/zNSJhkOPMMj+++70xlBZGjYmfwtD2eTsNDbEQ3o2Ik1X8/403xpWdVI4ijcnwpLrfsJMLIULusziBpv4+AnmRpBEYYGygQRcEpxAmpePXjFDe9/a52YUhRnHC1ATyIOb8opuXq9L6yiv8AuQmlBENIH4nxElFyECC72KYEAoePS3F7YoN3Fvslbdm7Lav2ZAlmSamMd/6s66DJnT1cr5/bqYUkBGTujFyAZr2aI7OR9BsVr0O/I7fyok3ErSSeOaLgZJxO/qUipD8fSX+yN+4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(83380400001)(38070700005)(71200400001)(6916009)(966005)(54906003)(186003)(316002)(76116006)(86362001)(6506007)(53546011)(7696005)(4326008)(52536014)(41300700001)(64756008)(33656002)(66946007)(66556008)(5660300002)(8676002)(66476007)(8936002)(66446008)(478600001)(38100700002)(122000001)(9686003)(2906002)(26005)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1RNV1AreHE1T0hFd3o4cHJiekhXVCtwWEQ2QnkyaVZiR1lISzliMlBBRVJ0?=
 =?utf-8?B?OUlib1JZaFBPQVpTbVFrMFVyZCswU2wvNndTblhuVllLUTU1aE1vcXFQL3Fy?=
 =?utf-8?B?MDltVW5aUWMxbmI3VzZSb2preUZhY2cycHM4T2RxSzBMaDJQR2xyZkdvMnVN?=
 =?utf-8?B?V3pDSmNaUnZMR2VlSTVyT2F6N0lLU2c0azRvQUE3dEo4aHpqdTlacWlYVCtF?=
 =?utf-8?B?NWRVZmROaXVqeXFiZFh4eE4vZEdCUmFHeUNWL3llV09zRXkxTUUyajRXUmhK?=
 =?utf-8?B?YkR0djJMejJJOHo1MWJVK2RMSTBkUjlqeVM3blJqcmZ3aTN1SzJ0N3N0S0g4?=
 =?utf-8?B?THVNS2FvbkwrcFRmWmNFcmc3d2RQcGVwMEtVaTJrNm45UWpXaHNYMGJWZVdF?=
 =?utf-8?B?ZWt1MWc2MU1EWnZucHFVUEhvcldzYUZEMWpZVEZDcVpyU1BnYzBwUWRNeS9U?=
 =?utf-8?B?Z2t1T0s1WHN0dWNnSUI4a2ZOOVhLUmF4SlpKK3BSTi9MNG8rc1I4amt6emg5?=
 =?utf-8?B?MXBGK29MM2FuTWtuRVQ3NXZRYVBGUy82cnNKMlh5K3hhVEg4S1J0L3AyUUpS?=
 =?utf-8?B?ZWdXMm0xM1JNb1JaWUxWaW0vTnhDQmpwOUlaQWN2UGt4UCtYSGNIdXk1RVVv?=
 =?utf-8?B?NW9BUHdTd2kzZ01FZ1pqZ3paYmIvWlVJY3RyTDJqUXl2UUZxWWh4TEVuQUJt?=
 =?utf-8?B?WG5adzBQUTZsUzA1a1FCWW9sQy9PeU4rcWRSQmN0U0hma09GTE1RRmJVamw1?=
 =?utf-8?B?cVF3V2E3SnYwZFg1SGw1NEwvc1BRcytYWmhGUWs1MGNHU3dmVWJ1aGhsVHJH?=
 =?utf-8?B?bksxWVJUU28vOUNYSjVreE1oalpZeE9nNmFDOEpoT05PV3g4UFRwc00zZzd1?=
 =?utf-8?B?aXlaY2JEbEpncmhXSDBFL2cxNkZSZE1MeFMweXdJQllvSm5QNVpnSEx1WDNh?=
 =?utf-8?B?bFJqelRGaFU1TXZHQy9hNGtDMkhiN3JZNnE5MmwvZVVGeGZacG83UnA0TzhD?=
 =?utf-8?B?WXhaT0U4UlZiKzM3b0tGSEJtSm1PdnJ2KzlvZ09NVmxWRzhiRTQwamJSVkNq?=
 =?utf-8?B?Qi9CUnVEOEFOVDFVamFqQlRDMEVDQndjbXRJODJkd25HLy9HL3RmVU1XOEtD?=
 =?utf-8?B?NTRzN292djUxYTUyWmdaNElLWXcyVUhNeGxmY1RLdTVxMUVXKzNPdVRCc2ps?=
 =?utf-8?B?WWhBcEE4U0d2RVQvVzRrYStnZDdoM2VYWkh6cDJaSThsblJtd3dKalpYZmtP?=
 =?utf-8?B?S1dteUduMGp4YlMybDh2UFdZbTVrWEhDODVNWkJUa3RUTG9ObmVESGdEZ0hU?=
 =?utf-8?B?ZjJXWlgrcUYxeW9nbDlrMlVRWHVJQzFjZGMxR2pIcTQ3V1BISEJIMHBXRlhQ?=
 =?utf-8?B?QjdTaHZ2bEMvS1FTZjZsVEkxTktmUUdvM1FZb1p5TUhTZjNpMWwvTXYyR1Fm?=
 =?utf-8?B?OC93ejFIYWFBWEdqSzVLUldpZy9MYVc2ZDJXaytyM2xUbEdJNE9wWjVZMlhs?=
 =?utf-8?B?ck5OOEJFT2M5amJKVUg1Y3FYL3JsRnBBbCtYWmtwUmQ3d1Z4SDZ2MnI4emkr?=
 =?utf-8?B?OXF3UGxlNEtyQloxamZYVGdFQkV0K0NQSTBMT0tmMi96K0puVks0MUxXOU9y?=
 =?utf-8?B?bWw4OGFqbDF0aHpKSkxCbjNSelFwbjI5UkNwTysveWNrODFCeUZjdFJ0QVhv?=
 =?utf-8?B?TGdkL2Y2clhzcXRwVkxHYTV5SlljdUdiVjNNMjFHcVJmQWh2Yjg4azVqaXhG?=
 =?utf-8?B?czBDcmQ2QnlmMjA2Sjg1MDlSUTlGSjQ2UXZQRU1mTkFDL3VKdlpkb0pITWVZ?=
 =?utf-8?B?Mk5UVk9oQkdVOWdJQlpVc2p4MG5QcEg2aURGT3VYdDJjbHgrZ0UxQUNxSXRu?=
 =?utf-8?B?RTNSSWdray9iMWpXZUJxWWVzaW43aWJCV3JVZGd4d0RtRlhVRExYUWdMOWlP?=
 =?utf-8?B?d2U3QWJtdzZDWkt4ZEJsNlVjRFdmU0psSUxCWlc2TTZ0Y1RBaUlyN1hhQlV1?=
 =?utf-8?B?K2U1VVhkV3JrNnNGYUxUNGhYQVk3THVJTGtSV25mQ1hWcFZpa2tFUi84bytL?=
 =?utf-8?B?RGxPOExmR3lHSEhVdkN5WmpLRnpYa3dmZFV0ZzlJT2Rpei9nOVFQSXM4cDd5?=
 =?utf-8?Q?yRI0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f3a020e-82d4-43f3-d892-08da90114859
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 14:08:32.8413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /6tA3QuUXIZyvn3OYXCDvF5A+qCkAWSBgT3GnumrT/E+As76W2WJBjxa68vOR6hSIueN6U2Ba4vAYB98OKgN4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7203
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

VGhhbmsgeW91IGZvciB5b3VyIHJlc3BvbnNlISBBbGwgY2xlYXIhIA0KDQotLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KRnJvbTogTGludXMgV2FsbGVpaiA8bGludXMud2FsbGVpakBsaW5hcm8u
b3JnPiANClNlbnQ6IEZyaWRheSwgU2VwdGVtYmVyIDIsIDIwMjIgNTo1NSBQTQ0KVG86IEFzbWFh
IE1uZWJoaSA8YXNtYWFAbnZpZGlhLmNvbT4NCkNjOiBhbmR5LnNoZXZjaGVua29AZ21haWwuY29t
OyBiZ29sYXN6ZXdza2lAYmF5bGlicmUuY29tOyBsaW51eC1ncGlvQHZnZXIua2VybmVsLm9yZzsg
bGludXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMS8xXSBB
ZGQgZHJpdmVyIGZvciBNZWxsYW5veCBCbHVlRmllbGQtMyBHUElPIGNvbnRyb2xsZXINCkltcG9y
dGFuY2U6IEhpZ2gNCg0KT24gRnJpLCBTZXAgMiwgMjAyMiBhdCA1OjU1IFBNIEFzbWFhIE1uZWJo
aSA8YXNtYWFAbnZpZGlhLmNvbT4gd3JvdGU6DQoNCj4gRHVyaW5nIHRlc3RpbmcsIEkgdXNlIHRo
ZSBzeXNmcyB0byBjaGFuZ2UgdGhlIGdwaW8gdmFsdWUgYXMgZm9sbG93czoNCj4gQ2QgL3N5cy9j
bGFzcy9ncGlvDQo+IGVjaG8gNDgwID4gZXhwb3J0DQo+IFdoZW4gSSBkbyB0aGUgZXhwb3J0LCBJ
IHNlZSB0aGF0IGdwaW9jaGlwX2dlbmVyaWNfcmVxdWVzdCBpcyBiZWluZyBjYWxsZWQgd2hpY2gg
Y2FsbHMgLmdwaW9fcmVxdWVzdF9lbmFibGUgPSBtbHhiZl9ncGlvX3JlcXVlc3RfZW5hYmxlLg0K
DQpZZXMgYnV0IGRvbid0IHVzZSB0aGUgZGVwcmVjYXRlZCBzeXNmcyB0byB0ZXN0IEdQSU8sIHVz
ZSBsaWJncGlvZCBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGlicy9saWJncGlvZC9s
aWJncGlvZC5naXQvDQoNCj4gSXMgdGhpcyBob3cgaXQgYWxzbyB3b3JrcyBpbiBvdGhlciBkcml2
ZXI/IE9yIGFtIEkgbWlzc2luZyBzb21ldGhpbmc/DQoNClRoZSBncGlvX2NoaXAgdXN1YWxseSB3
b3JrcyBhcyBhIGZyb250IGVuZCBmb3IgcGluIGNvbnRyb2wuDQoNCj4gSSB3YW50ZWQgdG8gZGlz
YWxsb3cgbXV4aW5nIGZyb20gdXNlciBzcGFjZS4NCg0KSWYgeW91IGFzayBmb3IgYSBHUElPIHRo
ZW4gaXQgd2lsbCBiZSBtdXhlZCBpbiBpZiB5b3UgaW1wbGVtZW50IC5ncGlvX3JlcXVlc3RfZW5h
YmxlKCkuDQoNCklmIHlvdSB3YW50IHRvIG1ha2UgaXQgaW1wb3NzaWJsZSB0byB1c2UgY2VydGFp
biBncGlvcyBhbHRlciAudmFsaWRfbWFzay4NCg0KSWYgeW91IGRvbid0IHdhbnQgcGVvcGxlIHRv
IHVzZSB0aGUgc3lzZnMgQUJJICh3aGljaCBieSB0aGUgd2F5IHJlcXVpcmVzIHlvdSB0byBmaXJz
dCBzZWxlY3QgdGhlICJDT05GSUdfRVhQRVJUIg0Kb3B0aW9uKSB0aGVuIGRvIG5vdCBjb21waWxl
IGl0IGludG8gdGhlIGtlcm5lbC4gSXQgaXMgYSBiaWcgcmlzayB0byB1c2UgaXQgaW4gYW55IGNh
c2UsIHNvIGp1c3QgZG9uJ3QuDQoNCklmIHlvdSB1c2UgdGhlIGNoYXJhY3RlciBkZXZpY2UgKHdo
aWNoIGlzIGVuYWJsZWQgYnkgZGVmYXVsdCksIHlvdSBjYW4gc2V0IHBlcm1pc3Npb25zIG9uIC9k
ZXYvZ3Bpb2NoaXBOIHN1Y2ggdGhhdCBvbmx5IHByaXZpbGVnZWQgdXNlcnMgY2FuIGFjY2VzcyBp
dCwganVzdCBsaWtlIHlvdSBwcm90ZWN0IGFueSBvdGhlciBibG9jay9jaGFyYWN0ZXIgZGV2aWNl
Lg0KDQo+IEkgd291bGQgbGlrZSB0aGF0IHRvIGJlIGNvbnRyb2xsZWQgYnkgdGhlIEFDUEkgdGFi
bGUgb25seS4NCg0KSSBkb24ndCBrbm93IGlmIGl0IGlzIHBvc3NpYmxlIHRvIHJlc3RyaWN0IEdQ
SU9zIHRvIGp1c3QgYmUgdXNlZCBmcm9tIEFDUEkuDQoNCj4gRm9yIGV4YW1wbGUsIHVzZSBkZXZt
X2dwaW9fcmVxdWVzdCBmcm9tIHNvbWUgb3RoZXIgZHJpdmVyIGlmIG5lZWRlZC4NCg0KSWYgeW91
IG9ubHkgd2FudCBvdGhlciBrZXJuZWwgY29uc3VtZXJzIHRvIHVzZSBHUElPcywgdGhlIGRpc2Fi
bGUgdGhlIHN5c2ZzIEFCSSwgYW5kIGFsc28gZGlzYWJsZSB0aGUgY2hhcmFjdGVyIGRldmljZSwg
dGhlbiBvbmx5IHRoZSBrZXJuZWwgY2FuIHVzZSBHUElPcy4NCg0KWW91cnMsDQpMaW51cyBXYWxs
ZWlqDQo=
