Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E15525685
	for <lists+linux-acpi@lfdr.de>; Thu, 12 May 2022 22:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355122AbiELUqA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 May 2022 16:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358430AbiELUp7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 12 May 2022 16:45:59 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2048.outbound.protection.outlook.com [40.107.102.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801B9220CF;
        Thu, 12 May 2022 13:45:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6BztA5+xGKcK+aUqSQOV5bkcnsxkbjASOlBe2K773MdDffNphQfB/vh0Ms8LVo5Lo+f1cXz3HAC3NjxRfaWbV+XNWOSgeYBnE5umNK0gs3dZLZYQVQXol78YZHuDjoHqnjkPZ47iuJ4A+9uITp6IpRaLsnjgvdbdRM7NctfltSk9a3k1nMW2SqVJecgWNK/0kLWxcP5LQh0WApaXYFTgtGKQ7NJp9oe876jld6RRefOaL3f3SfFTTbdvDKXMN4f59YNBAQp2b62p7Wk2ClOkqQY33/Bkcms4RAF9etC1j44u4xEX7hXMd6bCk1RdtnGRzgL2oSI5/jp1wTOnEnZaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4yMibONNtnCL6C6ddiJx1IRTvYQdqU/bkAlw2ByzanU=;
 b=Q0xZ4tjS4eIRTW7skq4sh9oUCv9t2y9aD6998lmlKqQpVDTybzCoVadX3OON1OvdYjXa8ud5uHX8rDRRpFxb9oslZBGgnIfEKPfPNI6IzaQWf4f8q/YR0hh1v3MY997GNsekC9B2B445e7pnLzjRu9oG5LtgAs0/h+w3Vx2lnqjgLC5XGPPVW8Lm1YSvQcaES6F9A0IKeFgrhyUTpGoI3O9w+5gGncdcmMitu1wH9IRBiiV4ZScojgJzvDFv2gX6sLY1FVzOYbjbDGvfhhp7A37aMDML5vAPNS/WGQSluOdJt6aQhpsJ9lqGVQEYsUCZS1rusiQd+47TJSp0cm/lVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yMibONNtnCL6C6ddiJx1IRTvYQdqU/bkAlw2ByzanU=;
 b=os6fXsNXZgP2GRjzgCduLfLmYaLRgj13MCE083TPdfcvY8cRyhuCmD8sUrFnFIBtuAk1XZxuI+4uRhiP6VWEQF30WeKNZsbKZeNsxsw1RunmoVxLNHpk4ExO/gR8lcXeokXJi0CwZlytQAABBjkHxV/JEo0RO9FgyxanjMr6xygAQu5Ud12ZartbGevog7HGhTiUs0jMHbSDQ7rR83QXqZeCvX9cgrG86dow4vWSnFBk+mKciSJghBfHa1LogvmCHRm1Jr6INd5WB+PE2VtCbW9NSuVlwdBwEahZeaDCKrOm0SfaDRMWWWEyzV5fwun/zF8c+kSH2N/cbBruZtGyeA==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by MWHPR12MB1613.namprd12.prod.outlook.com (2603:10b6:301:11::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Thu, 12 May
 2022 20:45:54 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::fd9e:abad:8541:b221]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::fd9e:abad:8541:b221%3]) with mapi id 15.20.5227.023; Thu, 12 May 2022
 20:45:54 +0000
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
Thread-Index: AQHYUy6f8PYDEwnjH0GY1hRsyl4qdK0QbjTwgAAQVwCAABikcIALQwgAgAAAjSA=
Date:   Thu, 12 May 2022 20:45:54 +0000
Message-ID: <CH2PR12MB38953FF57D91FA75AB9CB102D7CB9@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <20220418141416.27529-1-asmaa@nvidia.com>
 <CH2PR12MB3895A1FB2977B725ED92AB57D7C29@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CACRpkdY1uK=73zpEM5zUyXacm5xaUUFYkuKMxi_q6vwmOPy6tw@mail.gmail.com>
 <CH2PR12MB389560A1873030472A7A371DD7C29@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CACRpkdZhW9XK3opXLLzdMiVLVkGQyJCf7RLZtRQLsmzv-aqwbA@mail.gmail.com>
In-Reply-To: <CACRpkdZhW9XK3opXLLzdMiVLVkGQyJCf7RLZtRQLsmzv-aqwbA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b79907e-f98b-4f21-a53a-08da34586897
x-ms-traffictypediagnostic: MWHPR12MB1613:EE_
x-microsoft-antispam-prvs: <MWHPR12MB16139A679D348ACB59DF2A8ED7CB9@MWHPR12MB1613.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AFxxK3IOTlrUHA06PD2BTtnocpp+vuUseUDyF/XQHq9g8EHj1hGEFsUZjdx+84rgl7cdwt7I9PjlKnXfXqG9cU5y6K/DV5ZnTKfF4qpFZph492k3GJzWO/9VxbHI5Yb6SSh0RLlu4VV0UCbL8ENiD/mU+SzVUJzwxd+OgdSrbkYPI6YoykcPpks6tfXjx1ZEI7n3+iyx4URLAUv2qTbZA0ZEr6AHJgORdljVto8q+kt8Ml8yH0esAuCcI5hCTQHAd3EFNphnoSX0VJ7qqkpB6pBZoPEwEAyZsm3fmIu2lZMNDC+u40v5kb5ZNOUP6qsiHp7k3QZuIaK8+OQwhLaeSoLNyOxRvTtok9Iu9TC24c3b29kHOY0noaCcCYMK8DXGKj1VQ4tzR+yPNMZAiAswvnUJDkxXK6E4dZjQlSpMFsOsqVuNmDUmV7YsLixIbo46H2gh1zhgMYr/MDKmpFyvAjR9l98rYf7K7+6ajyBUBahFHPkn4HGU4GpLPBjIPEyGNFoLtUTQeohJWbivWjFklM/bDQ/Xyd3IHjJ8eFpEpeeMWyj3d/7dqy8k5XJnCDJ+HZtdpMqrSA3z4XPCRY5cR1A851fS/wWBc5lhv/LfC9A0P+U1px7JchC2hZUi+W35BwzTi1+c7g33N0olbUnE++S2H1Solhl/QY2xetjd6nD42UaP1BRauBv1Iik8VM+oTIzx/dRgh7WZVjbN1whgnA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(38100700002)(38070700005)(9686003)(122000001)(316002)(33656002)(55016003)(508600001)(6916009)(8936002)(54906003)(52536014)(66476007)(66946007)(64756008)(66446008)(8676002)(76116006)(4326008)(66556008)(71200400001)(86362001)(7696005)(6506007)(5660300002)(4744005)(2906002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGxoaDVFNEhyUVVwS1VHMGdiaDBiQk54Y1pTNVZNQkUxRXhiUVdUbWtJSG5r?=
 =?utf-8?B?ai8xdkp5VEdGdnY5dlIraUhBSFlIKzU5c3FtRzJWZ3F0RmNaWjBzaWZaMFY3?=
 =?utf-8?B?aXdCanJrUjBOd0xHNDRteFdBdE9WSEltaHdVNm1UR2F3L3Y3QUZ0UmJFTnpH?=
 =?utf-8?B?UTNtZ3B0T0Rta0VGTGpLVmV3SlFnRlV3WUxiRDFCcms4VlE1VDBJMzFzMmRD?=
 =?utf-8?B?bDl5RnpqU1pvWW93K29KTVNoZ0Izc3M1ZHhMci9jT2t4cldkb2hKSmRhWXNC?=
 =?utf-8?B?cTFXd05uSE9MSHZPRllIQk41dEI2STJQS0hRbHJ6OTdxdGdPUFRrYk9WdG9C?=
 =?utf-8?B?TU1QaHlJcGFQd3hJUjRYQmFBdDYyQ3BaY2p0RWZLZStnanVyV0VSaTI5bXlK?=
 =?utf-8?B?V3oxL0MyeTFaSEF5d21xb2FRL2d4OXMwbUxLUUd5ZDc2c0xwbzJSMkJ1amZV?=
 =?utf-8?B?dEgvdVpJUENYajJtd3VrRDhKRWM2ZXlFSGFEdjV2VUhFTmZHcE1KQ0Q3blRq?=
 =?utf-8?B?dmtkZi9CbzFlaXg3dmZXV2tvMWVPejV3alNCb2hJckhJL29NNGpaelhaTVJu?=
 =?utf-8?B?bnN2c3RGVG93VzVoc09QaXcwWkllamNqYUo5MWpOS2dEWWl3L253NkJ0TlBW?=
 =?utf-8?B?WVdyV0gzSkdQMFdNdUNpQUN4cDNCaWU2TlVob1ZSUmxXUTRiVkQwbndSbFZq?=
 =?utf-8?B?S0RMVzB4aDVTZkluckNoeURDYVgrUFNPZzd2MHlYUmVCZkVORm41cWhvVjk1?=
 =?utf-8?B?ZXZvOThCYmhTaWRVQmlmK2t5UDRuSUtROUNUd2pQN0dsK1p3QS9sK1RXSkNi?=
 =?utf-8?B?amNMQUp3NXpOTm9IOFVLWE5hM2QzbG8rZDNXQ05paHkrVjdEaERwRWpnY01X?=
 =?utf-8?B?Z3FKWFFQRHN6VUh0bnVtRUg3RWtkNEs0VnRha0g4NDJLeHNpdFVqdUxmTnF2?=
 =?utf-8?B?Z3d0b21tTHRrcUU5eFVxeVB1eFpKMTdQOFlIalB1YUN0Z3hQT0prY2lXMElJ?=
 =?utf-8?B?cjN1M0hwZVFsb2FFT0oyOW9DdEI4MnFTeGZLZ2hQZGJxTDZMUzFiNW1FbWFD?=
 =?utf-8?B?NTFjU2NSZEFKb1Zqd3drczhyYnRHb1h0THBLK1EvUmQwcVZDT1ZKcWNNa0k5?=
 =?utf-8?B?ellDNkljUnkrbUhlUWVHbXdlelpmdUN1b1krWGVzaTgrb0lQMFBNOEs4bjgx?=
 =?utf-8?B?a0xoTE45UDZuSWszVTlXQkp4R3F2YUpLMzlBZXowelZxdTdwekhaN3lGLzBj?=
 =?utf-8?B?ODh6cWd2Z2YrNVcwL2pMT0hhS0F2d2JRdXJhQkIrYUpucnVSM2lybGZOZURl?=
 =?utf-8?B?WkpMeUFLL2JZM0hMTysxcmxGQzAySUc4VXpldmRjd2pITGIwb0h3elFaWTJ6?=
 =?utf-8?B?RzRmbnkyNWFKMGRqb0Y3emI5Z0ZkYlNVN1NvM0tQZzl5S2hKNUcwT0ZQeFEx?=
 =?utf-8?B?aHljZ3VBbDhiTFFSNTJYaXlhMlhHMFpzMkhhd3pmQ2FENUxQdWluclc3dDRi?=
 =?utf-8?B?Z05kbUNGRnNJUUpBUFJKVFdLd0o0ODlkL0pSWTAvVXA1ekdVSFd6ZnMvZ0RM?=
 =?utf-8?B?dVIyanI0LzEzTzlZYk1XU3ZpV244UE1CTXc3T1pJU3c4WUNadFl4ZFZyZElu?=
 =?utf-8?B?QllEV1NhZFlOYnNDOEJKbjR3M3U3MlI0UjMxMWFCSllaM1h1Z2I0dk1WdmQr?=
 =?utf-8?B?SmhUNHhSUDZJZ0hsVkFCVGh6ZThkUVZRV1lXNU1Kc0MzMGZSS3FzT01UNDdW?=
 =?utf-8?B?Q3dyS3AyYWc5S25WRGxWV014MG1qcHRXUGk4anRpanR2SjFQZUNrejVieG1l?=
 =?utf-8?B?MDF3ZXJUWUE2U244SEJxUlNNUjAxdnVpRnpXaXNiU3IvdjZidkR2bnhBcnFo?=
 =?utf-8?B?cFB0ZmVwV2RDZjBsUlcwNlY1R1NYd2VkekdsMm5HUmFuV0lSUVdaSE1ibk9t?=
 =?utf-8?B?OS9uL1o1aU5oa0FyNnBHSTJ5OU9wZmxoNWpqOUFzdkdTYmdQcVRwSTlYdVo4?=
 =?utf-8?B?NUdKeXd1Tk56NjFaSWNKamlkaVdoK2tIVlVWR2tqV1FRa3NsTUNRWUlQMkJZ?=
 =?utf-8?B?Ri9MRURkd3ZHZGdFV1dCKzkyK2o3OXI4NDJCMHdZL2NqOW81c1pXQWVuWDRY?=
 =?utf-8?B?ZkFUOWJmMDFJVkZ0cWtncnN0blAxMktHZndaRCtpWHJ0SjBEQlptRDZJcWk0?=
 =?utf-8?B?bTA1THNGdkhpU0ZzZE9qcEZPZlVDOE1ZaWlZeW5TOENteGQ4TnJGNzJlZFVO?=
 =?utf-8?B?QWtMWmc1bkQxbVVEMWNJZGZBV29EVUVNOElhNjh4Q3NiRTZQYnhBWUJ4RmE3?=
 =?utf-8?Q?Ab5jOlY2psO2zlng80?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b79907e-f98b-4f21-a53a-08da34586897
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2022 20:45:54.2256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: atp1Z85AcVLkehtnlVHf+cshoIly1GNdZnh8DRg/H7yohwAdHwe+rkYVZXcJkxjHVdevQLrOzHQqp81Tymtf2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1613
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Pg0KPiBBbGwgR1BJT3MgYXJlIGFsd2F5cyBjb250cm9sbGVkIGJ5IEhXIGJ5IGRlZmF1bHQuDQo+
IEZXX0NPTlRST0xfU0VUIGlzIHVzZWQgd2hlbiB3ZSB3YW50IHRvIHJlbGVhc2UgY29udHJvbCBv
ZiB0aGUgR1BJTyBieSANCj4gSFcgYW5kIGdpdmUgdGhlIGNvbnRyb2wgdG8gc29mdHdhcmUgaW5z
dGVhZC4NCg0KV2hhdCBkb2VzIHRoYXQgbWVhbiBpbiBwcmFjdGljZT8gV2hhdCB3YXkgZG9lcyBo
YXJkd2FyZSBjb250cm9sIGEgR1BJTz8NCg0KSXQncyBub3Qgc29tZSB3YXkgb2YgcmVtdXhpbmcg
dGhlIHBpbnMgaXMgaXQsIHNvIHlvdSB3aGF0IHlvdSBhcmUgY2FsbGluZyAiY29udHJvbGxlZCBi
eSBoYXJkd2FyZSIgaXMgYWN0dWFsbHkgdGhhdCBpdCBpcyBjb250cm9sbGVkIGJ5IGUuZy4gSTJD
IGFuZCBvdGhlciBzdHVmZiB0aGF0IG1heSBiZSBtdXhlZCBpbj8NCg0KWWVzIGV4YWN0bHkuIFRo
ZXNlIEdQSU8gcGlucyBhcmUgYWxyZWFkeSBhc3NpZ25lZCBhIHNwZWNpZmljIEhXIGZ1bmN0aW9u
YWxpdHkgbGlrZSBJMkMgU0RBL1NDTCwgTURJTyBldGMuLi4gYnV0IHdlIHdvdWxkIGxpa2UgdG8g
c3VwcG9ydCB0aGUgb3B0aW9uIHRvIGNvbnRyb2wgdGhlbSBmcm9tIHNvZnR3YXJlIGlmIGRlc2ly
ZWQuIA0K
