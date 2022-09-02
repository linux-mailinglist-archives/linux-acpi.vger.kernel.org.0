Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9382E5AB629
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Sep 2022 18:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237811AbiIBQC5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Sep 2022 12:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237502AbiIBQCZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Sep 2022 12:02:25 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2073.outbound.protection.outlook.com [40.107.212.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3BDF7B2C;
        Fri,  2 Sep 2022 08:56:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AgPrb7ezSHA8Ra2QQcMufbri0w+9U2Gv5ReLrbI3l9lT2gIQX304BAAN/1jzp49yRASr4/CAjdeiWlr8toS0GQh3PGsx2V4wsvP0ZN6iWC3MEzCUboTBJknUfHq7VVrs8PL5GYest20AmXa8eC4of4Fi/xB06IOd1U2Kmjrc8LiPYH980g4bB6+r+41qHdxaO5PducGIdt3Y/MEiPndtnQ6wKnspD0BKDnhAi1R0qlNqm4FOpD960r92t5X9XyCJBwc1ghmPqhZaMxSE4wYGxkFLgMfh7MKc8S5bpxgHHA1eX3qb7qStRf7hmyiO7DTPUd97Z8GeDGtItZnf1VfzTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18pIrBJVtDlrwGHri5+4uqnxs9DK852gPYC9HfgPuA0=;
 b=NkQfomO362sQUNxUFgMd9YzbYPRMx2U6Op0xFWLe/Ye5/uW3vTonTXrEBaF643dLl6cm1MpxubzUE+1K/WE2Mcuwol9vPbOvRFZjF6zJZrp+3nUwURWgoFxqY2Lx8VK4vscyeBhDyR2GPtN3AfLuW+IrUC5FnZEXeED/KNUXFwkUChzR63jrAndmjHvpc85xE88Ibi63LOkWhnNPjSDXyl4JR6RyP+qdclOFQrA1txdIXRTGUqqJpsiC85FooSaifZTZvcA2cZWpKQBfV6oY47kvojmukmWFFn7SXGKh6YoVt1A/+E4lZQqagkjEpKEFg8Aziso6eIO1mRqWVRolcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18pIrBJVtDlrwGHri5+4uqnxs9DK852gPYC9HfgPuA0=;
 b=tTGQVWzJgd1c1dZDibrmTrt3O9RCYr9E2hWA141UAlXmcQ/KyDDMb0GcIr0Oz4BUtHH42dzcMmJIwW/3fq6Htr12aVv86x/XURT+cDFRwkqLAyuI2oN1Z/08jyKwGxuYecYSqAEAt8sV3sgwJsgdYGtPq2SP+DZsPdkUr0cA0gmznQuRaPrhXMaH66DlRLDcV2C5Ymib9maIPr/bZI/Zd4Aa36WdbpyTDe3HLb6GI5RfaXzvh0hnXLErg/enCOwzZxrGPRtn+Wf+6Q8l26PVFXnHOHKxwkvtG9V0lD4oPA+tw2z5AXLljyqVKudD5V8iJi4c9Gk4cgyUanQvtPmMhw==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by DM4PR12MB6085.namprd12.prod.outlook.com (2603:10b6:8:b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Fri, 2 Sep
 2022 15:54:59 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::25d3:32f3:4be5:da11]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::25d3:32f3:4be5:da11%7]) with mapi id 15.20.5588.012; Fri, 2 Sep 2022
 15:54:59 +0000
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
Thread-Index: AQHYUy6f8PYDEwnjH0GY1hRsyl4qdK0QbjTwgAAQVwCAABikcIALQwgAgAAAjSCAAZckgIAELgbQgAM2cYCAqEdScA==
Date:   Fri, 2 Sep 2022 15:54:58 +0000
Message-ID: <CH2PR12MB3895B4E89237E6D6F635F252D77A9@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <20220418141416.27529-1-asmaa@nvidia.com>
 <CH2PR12MB3895A1FB2977B725ED92AB57D7C29@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CACRpkdY1uK=73zpEM5zUyXacm5xaUUFYkuKMxi_q6vwmOPy6tw@mail.gmail.com>
 <CH2PR12MB389560A1873030472A7A371DD7C29@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CACRpkdZhW9XK3opXLLzdMiVLVkGQyJCf7RLZtRQLsmzv-aqwbA@mail.gmail.com>
 <CH2PR12MB38953FF57D91FA75AB9CB102D7CB9@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CACRpkdbAhMa2CXvQra3E13n8WfiBxyHNqzEp4dW3qo5upr_=gw@mail.gmail.com>
 <CH2PR12MB38958CD365876A2106712C3CD7CF9@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CACRpkdZp9hx2SHxsmjBm2oj7m3UT-4S+MKw5qqNME0PLjPNV2A@mail.gmail.com>
In-Reply-To: <CACRpkdZp9hx2SHxsmjBm2oj7m3UT-4S+MKw5qqNME0PLjPNV2A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9366e236-1728-4192-2649-08da8cfb7d18
x-ms-traffictypediagnostic: DM4PR12MB6085:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y10MoCJEAlXCk97JHNrnniDM+d6vuIgEKLzbhEywZf8IdP9jwG8mAnGj0xWOc9qkB5PI2UcJ7/7Ox2Fee020AYJA8Mi4EUKvwBrvglDog1xyQu2JcBnq6ndGxz3BOopNpO3WDML5bxfWyTAUoNq4KTA/yq4aK5tssuB6a6v/s5AkFtJ4Y8KQ0sF4bUDwTqO9luZZNzyOwgbcUWDzRQZLv2hb0YFPUVvLyF7TFezfFyakwbpXUQIweJKVn/A08wLFSWuNG2qrsTrVb/jmfrLId+t0/acfSrpk01pgEXppkPKRhZjZA8C2QKf89hIM2Dy5D/ZAxuIFUctUn2tv4zAEi2YEH4ahOROBcARD1n98ADjRn+wKwrQYo3VZ+ocEiDDiiZHbJRr0+adG01ZtdghzIaps9OIE8soc3ZzWFlD4gocTV7RK484Af2xbaAMT3/75pDaW5DyCCoz+Txi3PDycEVJvkm8PnSAS6GSqnzGFiqoSItWqCmSEz/gl/UfQRhHmXldWKEKYjzE1qYttjV68gpQHx+148vM/Bmf60fiH4G75ePaew0VEM/gTtSxj3NVRtWPSbC7DUftgTb8z1BZXLD/ceWG5hbYP5pqIelZhSmRG4kPX7Jm3vnieA1ncaOhGWEj3bEHGUs+NSslqYSTqI84dDqH8wQSsEqAZ35m1AeQr8vwQVMN3/k/8DpYjG2JL5NJCuuDJD8IY0SGA1kRBqMMRSZbCBijRgLScH6nVYdtoZvbmVYeCJpLSYf0kxZwY2aR3n1Ce6T31LZjQnnlyGTnclNDUW7kEeOt9AhBF+FCaOPTnp+qkhrDAVUSsilMw5ZYk7LPSV5klJU0mmgG10G8CHEIsGjbfBDpjtHC8a6Xrr4ZestaCH9Ft9fnmM1EH2LOlx5XHV4AX7enYZTtfcQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(39860400002)(376002)(396003)(346002)(8936002)(9686003)(122000001)(53546011)(86362001)(26005)(2906002)(478600001)(52536014)(7696005)(33656002)(6506007)(5660300002)(41300700001)(38070700005)(38100700002)(83380400001)(186003)(966005)(55016003)(66476007)(76116006)(66446008)(66946007)(64756008)(316002)(71200400001)(4326008)(66556008)(54906003)(8676002)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjYwSnhjUUxxajZMZTdUUG14V2ZINHlnZmpDUkJqTWdxSmNsUVFBSHF3VUJw?=
 =?utf-8?B?SmgzRjRJMHlvcEpyZ01yLzFnU292UlBIUGNEV2NWU2pKTitONWczRTNSZHV0?=
 =?utf-8?B?a3hRbWlwWFVXSXFIVzJFMTdrK0hmcDgzZDNXUjhiTkRxZFJNWGpvQ2Y0b2Zk?=
 =?utf-8?B?WmRwTUdKSmc5bGNjeGUyMThKUmlUd25KU1R1TTFzTVVtd28wNGwzTnBXTmtP?=
 =?utf-8?B?cThaaHdQRjN5dWZJd2FXMHY4amcwUFYzclI4b1E2Q0VNUDFXMERXbTBhc1VX?=
 =?utf-8?B?MWg2RVlyYmxVWEk2MWpDeHU4UFpXblIzdHgzTFNNd3NYSm9laTlTK1JmemxW?=
 =?utf-8?B?NVlTVFFIT3RBZFlLS1llKzNrNVEzeXN1VGhCTmUrV3NnM3lsR3FDcHpkbmpp?=
 =?utf-8?B?SXZEeHQvaXFkckNvditsTTBuN0RiVWszbjBtSFpyaVQvUnM0WVpXYVYvYlRi?=
 =?utf-8?B?Z1NXODNQeEp3VGYzc0JlK0c4Wi9MVS9GWk1LNjBvTlVkaDlHS1loQ2ZnSWd1?=
 =?utf-8?B?MFZGMG90cFFlaEMyQ09mYm1mRmc0V2NKUnI5d1RjSmwrTHdlUUY0cTdyUXM5?=
 =?utf-8?B?b2NIaDJ0T3FiS250R2tUb2ttTWJrL3V1VU5wNktONURndS9EdVBESmJPaktX?=
 =?utf-8?B?TDJWZkVyN1FWcU9tR3dZcFJuYnhqTHE5bjBDSlVNNzAvOGFENjd6cTVhbVVB?=
 =?utf-8?B?RlkveWFSeHovdGI3RERzSytINmgwdFJvTDFJcXg3NDZOWHJadGcrOWlFb3lV?=
 =?utf-8?B?QldDYk1ndVhmek1WT3BYRjlsV3ltL1ZkaTRlRkJVdmd0aXY2NU04eW1KSjFT?=
 =?utf-8?B?M3QxVFFDdlBJOWxaZzh1bUFhZitrOWw4R3U2enhSNWRobnhydkhMQUxTUnUw?=
 =?utf-8?B?cDNsYktTYjNJWEtMOVVMWk82T3krME4yZ3UzdTJzcS9oclVnSU9jMy9RQ0Fs?=
 =?utf-8?B?UnNDeWlXS3p3ZlVnTmdQWFljRWV4WDFOTUdzckVlbzN5TEVNR1hST2pkM0Zv?=
 =?utf-8?B?cVBTei9SdjQ3QjQ3aFVlN1lXUkRUTDlHcCs2UkVRYXNxLyt3UkladW9TRlNP?=
 =?utf-8?B?czcvRkFXckFrbjdndC8wYTBmRDJTRmFYWlNjTmtwNHp1SE14WGNLaFhFRjVa?=
 =?utf-8?B?YXhLdEUvM2wyMHhPTFNlWjQ4T1p5VytpamtxbkdXcDlVellNbmFxYk9hdG9T?=
 =?utf-8?B?WEIyaVZiYjkvbytvVUo4UE9zN0tDWXlkNWhDcU1KWUQ3TGdtZVlRem1oT042?=
 =?utf-8?B?NEN3Q0Y2ZlhCbG9wR3hVVThhMW8zUDc1aUNiNzhXd3JQbmpGd3dCaGNoQ0s1?=
 =?utf-8?B?SWVYQXZWR09kNG5OUFFVTzZPaE1TY3Q5bmNoYm1Nc3h4NWE5aG9icWhUd1Yr?=
 =?utf-8?B?cis0MzR0VHZLcUpab0Jwc3RNY0orT25NRHRsaUwvVW5YM0JhM0w1THBHSTIw?=
 =?utf-8?B?SnpPS01aYnREdkIveWNGTHY0TGpwWm5xckVTYVRuRUp0Y3hacnZoR0VNdkE5?=
 =?utf-8?B?Mkd3YURITnVNMkV1bUN0WHVsL3YvSnhYQ05tRllvc25VZUZaelNiUk1BdDYy?=
 =?utf-8?B?M0hpbGVvam85QlBidmFneERtMUViK0pQRGxOQ0VFUEZjaWR4QVNpMm5hSnUz?=
 =?utf-8?B?SXNJRjd4VEpVT1JFM3F1RkdQaHFLby83ZWR6Rkk5emVTbVE5WmhmaWJySmJm?=
 =?utf-8?B?NWlFbkFBWHNrY2VrWE9PSEdKMzhacVRzUUhHL09mUFBmNU9DTHJ5cnphVUVB?=
 =?utf-8?B?TzdZcUdSYVRVeGF2OWNiSzNobzJyOGJzYVlrUG40OFhlMEYvTElKaVF5N0pS?=
 =?utf-8?B?TytFUERmMUMzNmZLUkkzNThSb3hCeTNmR21VRkpIdWFKc0dQOW5VY2VsWWND?=
 =?utf-8?B?RmpXY3JXMjhCSFg0SzZYK3dIcEhvNFFWNlZLOGc3UEpaUXI5dk5Vd3B6T1F1?=
 =?utf-8?B?RkFyQldMR1Q0a3BkaDFqTzIvekhadTJLQjNtMUZPSzZVTW9GRTJ2b0VvaGZL?=
 =?utf-8?B?TXFxenVHcUJwVXVodFkvcHU0TWt2QU1LMEtQMXdHZkU3T3NxMnFoZ1ErME1T?=
 =?utf-8?B?YTgvS3p1Yk5hUEIzbmdCdjIwMTIzVTZvZHV6OXFmblRmU2VWVkZCVzJLTlQ3?=
 =?utf-8?Q?Z/Q4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9366e236-1728-4192-2649-08da8cfb7d18
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2022 15:54:58.9448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +iOuLvfmQNLIegvQh4pGkCIp94OZPsCIej+DAFtjz5b13QyaouvzHdSSADJSStU3muSXt0AuGrBGcv/ga6T9+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6085
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

SGkgTGludXMsDQoNClNvcnJ5IGZvciB0aGUgbG9uZyBkZWxheS4gSSBkaWQgd29yayBvbiBhZGRp
bmcgdGhlIHBpbmN0cmwgZHJpdmVyIGJlc2lkZXMgdGhlIGdwaW8gZHJpdmVyIGFuZCBJIGFtIHdv
cmtpbmcgb24gdGVzdGluZyBpdC4NCkkgYWRkZWQgdGhlIGZvbGxvd2luZyB0byB0aGUgZ3BpbyBk
cml2ZXI6DQpnYy0+c2V0ID0gbWx4YmYzX2dwaW9fc2V0Ow0KZ2MtPmRpcmVjdGlvbl9pbnB1dCA9
IG1seGJmM19ncGlvX2RpcmVjdGlvbl9pbnB1dDsNCmdjLT5kaXJlY3Rpb25fb3V0cHV0ID0gbWx4
YmYzX2dwaW9fZGlyZWN0aW9uX291dHB1dDsNCmdjLT5yZXF1ZXN0ID0gZ3Bpb2NoaXBfZ2VuZXJp
Y19yZXF1ZXN0Ow0KZ2MtPmZyZWUgPSBncGlvY2hpcF9nZW5lcmljX2ZyZWU7DQoNCkluIHRoZSBw
aW5jdHJsIGRyaXZlciwgSSBkZWZpbmVkIHRoZSBmb2xsb3dpbmc6DQpzdGF0aWMgY29uc3Qgc3Ry
dWN0IHBpbm11eF9vcHMgbWx4YmZfcG14X29wcyA9IHsNCi5nZXRfZnVuY3Rpb25zX2NvdW50ID0g
bWx4YmZfcG14X2dldF9mdW5jc19jb3VudCwNCi5nZXRfZnVuY3Rpb25fbmFtZSA9IG1seGJmX3Bt
eF9nZXRfZnVuY19uYW1lLA0KLmdldF9mdW5jdGlvbl9ncm91cHMgPSBtbHhiZl9wbXhfZ2V0X2dy
b3VwcywNCi5zZXRfbXV4ID0gbWx4YmZfcG14X3NldCwNCi5ncGlvX3JlcXVlc3RfZW5hYmxlID0g
bWx4YmZfZ3Bpb19yZXF1ZXN0X2VuYWJsZSwNCi5ncGlvX2Rpc2FibGVfZnJlZSA9IG1seGJmX2dw
aW9fZGlzYWJsZV9mcmVlLA0KfTsNCg0KRHVyaW5nIHRlc3RpbmcsIEkgdXNlIHRoZSBzeXNmcyB0
byBjaGFuZ2UgdGhlIGdwaW8gdmFsdWUgYXMgZm9sbG93czoNCkNkIC9zeXMvY2xhc3MvZ3Bpbw0K
ZWNobyA0ODAgPiBleHBvcnQNCldoZW4gSSBkbyB0aGUgZXhwb3J0LCBJIHNlZSB0aGF0IGdwaW9j
aGlwX2dlbmVyaWNfcmVxdWVzdCBpcyBiZWluZyBjYWxsZWQgd2hpY2ggY2FsbHMgLmdwaW9fcmVx
dWVzdF9lbmFibGUgPSBtbHhiZl9ncGlvX3JlcXVlc3RfZW5hYmxlLg0KDQpJcyB0aGlzIGhvdyBp
dCBhbHNvIHdvcmtzIGluIG90aGVyIGRyaXZlcj8gT3IgYW0gSSBtaXNzaW5nIHNvbWV0aGluZz8g
DQpJIHdhbnRlZCB0byBkaXNhbGxvdyBtdXhpbmcgZnJvbSB1c2VyIHNwYWNlLiBJIHdvdWxkIGxp
a2UgdGhhdCB0byBiZSBjb250cm9sbGVkIGJ5IHRoZSBBQ1BJIHRhYmxlIG9ubHkuIEZvciBleGFt
cGxlLCB1c2UgZGV2bV9ncGlvX3JlcXVlc3QgZnJvbSBzb21lIG90aGVyIGRyaXZlciBpZiBuZWVk
ZWQuDQoNClRoYW5rcy4NCkFzbWFhDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTog
TGludXMgV2FsbGVpaiA8bGludXMud2FsbGVpakBsaW5hcm8ub3JnPiANClNlbnQ6IFdlZG5lc2Rh
eSwgTWF5IDE4LCAyMDIyIDk6NTEgQU0NClRvOiBBc21hYSBNbmViaGkgPGFzbWFhQG52aWRpYS5j
b20+DQpDYzogYW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbTsgYmdvbGFzemV3c2tpQGJheWxpYnJl
LmNvbTsgbGludXgtZ3Bpb0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFjcGlAdmdlci5rZXJuZWwu
b3JnDQpTdWJqZWN0OiBSZTogW1BBVENIIHYxIDEvMV0gQWRkIGRyaXZlciBmb3IgTWVsbGFub3gg
Qmx1ZUZpZWxkLTMgR1BJTyBjb250cm9sbGVyDQpJbXBvcnRhbmNlOiBIaWdoDQoNCk9uIE1vbiwg
TWF5IDE2LCAyMDIyIGF0IDM6MDAgUE0gQXNtYWEgTW5lYmhpIDxhc21hYUBudmlkaWEuY29tPiB3
cm90ZToNCg0KPiBTbyB0aGVzZSBHUElPIHBpbnMgYXJlIGFzc2lnbmVkIG9uZSBzcGVjaWZpYyBI
VyBmdW5jdGlvbmFsaXR5IG9uIHRoZSANCj4gYm9hcmRzICBhbmQgc29mdHdhcmUgc2hvdWxkIG5l
dmVyIGNoYW5nZSB0aGVtLg0KPg0KPiBCeSBkZWZhdWx0LCBmb3Igc2VjdXJpdHkgcHVycG9zZXMs
IEkgdGhpbmsgd2Ugc2hvdWxkbid0IGxldCB0aGUgdXNlciANCj4gaGF2ZSB0aGUgb3B0aW9uIHRv
IGNvbnRyb2wgdGhlIEdQSU8gcGlucyBzaW5jZSB0aGV5IGhhdmUgYSBzcGVjaWZpYyBIVyBmdW5j
dGlvbmFsaXR5Lg0KPg0KPiBCdXQgZm9yIGJyaW5ndXAvZGVidWcgcHVycG9zZXMsIHdlIHdvdWxk
IGxpa2UgdG8gc3VwcG9ydCB0aGUgb3B0aW9uIG9mIA0KPiBzb2Z0d2FyZSBiZWluZyBhYmxlIHRv
IGNoYW5nZSB0aGVzZSBwaW4gdmFsdWVzLiBXZSBhbHNvIG1pZ2h0IGhhdmUgDQo+IGN1c3RvbWVy
cyB0aGF0IGNob29zZSB0byBjaGFuZ2UgdGhlIGRlZmF1bHQgSFcgY29ubmVjdGlvbiBvZiBhIGNl
cnRhaW4gDQo+IEdQSU8gcGluIGFuZCBjb25uZWN0IGl0IHRvIGNvbnRyb2wgdGhlaXIgTEVEcyBm
b3IgaW5zdGFuY2UuDQoNClRoZSBmYWN0IHRoYXQgdGhlIHVzZWNhc2UgaXMgYnJpbmd1cC9kZWJ1
ZyBkb2VzIG5vdCBtZWFuIHdlIGN1dCBjb3JuZXJzIGFuZCBkbyAicXVpY2sgZml4ZXMiLiBUaGUg
cHJvcGVyIEFQSXMgaGF2ZSB0byBiZSBpbXBsZW1lbnRlZCwgdGhlIGFsdGVybmF0aXZlIGlzIHRv
IG5vdCBzdWJtaXQgdGhlIGRyaXZlciBhdCBhbGwuDQoNCldoYXQgSSBoZWFyIGlzIHRoYXQgdGhl
c2UgcGlucyBoYXZlIHR3byBtb2RlczoNCg0KMS4gVXNlZCBmb3IgYSBkZXZpY2UgKEkyQyBldGMp
DQoyLiBVc2VkIGFzIEdQSU8gYnkgc2V0dGluZyBhIGJpdCBpbiBZVV9HUElPX0ZXX0NPTlRST0xf
U0VUDQoNClRoaXMgaXMgdHdvIHBpbiBjb250cm9sIG11bHRpcGxleGluZyBzdGF0ZXMgYWxyZWFk
eS4NCg0KU28gdGhpcyBzaG91bGQgaGF2ZSBhIHNpbXBsZSBwaW4gY29udHJvbCBkcml2ZXIgYXMg
YmFjay1lbmQgd2l0aCB0aGUgR1BJTyBhcyBmcm9udCBlbmQuIEEgc2hvcnRjdXQgdG8gZW5hYmxp
bmcgcGlucyBpbnRvIEdQSU8gbW9kZSBjYW4gYmUgcHJvdmlkZWQgdXNpbmcgLmdwaW9fcmVxdWVz
dF9lbmFibGUoKSBmcm9tIHN0cnVjdCBwaW5tdXhfb3BzLg0KDQpQbGVhc2UgcmVmZXIgdG8NCmh0
dHBzOi8vZG9jcy5rZXJuZWwub3JnL2RyaXZlci1hcGkvcGluLWNvbnRyb2wuaHRtbA0KDQpJIGtu
b3cgdGhpcyBtZWFucyBtb3JlIHdvcmsgYW5kIGlzIGtpbmQgb2YgY29tcGxleC4gQnV0IGRyaXZl
cnMvcGluY3RybCBoYXMgYSBsb3Qgb2YgZXhhbXBsZXMgeW91IGNhbiBmb2xsb3csIGZvciBleGFt
cGxlIGRyaXZlcnMvcGluY3RybC9waW5jdHJsLXN4MTUweC5jIGFuZCBvdGhlciBzaW1wbGUgbXVs
dGlwdXJwb3NlIGNoaXBzLg0KDQpZb3VycywNCkxpbnVzIFdhbGxlaWoNCg==
