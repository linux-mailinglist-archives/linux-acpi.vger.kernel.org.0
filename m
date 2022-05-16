Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31265284DA
	for <lists+linux-acpi@lfdr.de>; Mon, 16 May 2022 15:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241710AbiEPNAH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 May 2022 09:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiEPNAE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 16 May 2022 09:00:04 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7223981E;
        Mon, 16 May 2022 06:00:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UEo0KB1YZ/VLCFw33AXOsfEQer/oMpEEoAVN9eWsrIC8Mn5JmuzdjkqGngsou9SQGVfUz6pJg4zXH7OM5Nj6zUjyzypA19eZ0tcnLyL1M2SzMF9dhPnzqpuXRoKipQbDZQOHKRwHXkVbjWbSNyHkzVgpDBAEDJPdbVbkUMpAaqz3LTyy/89IoUwAwFozfQFTaCDWkqHXcjvdfkCYfr2z0MJFhgqb/G3om/oXe8zqvyRcfNaFnKhULVHiWTCm6Ppt4b0YctFjdsy+m+M+cyjL7FJ99pueJqFeBHkt6GnYB9VY3Mt5odcVswkoPw78jb6KCtiQR61WCc3GnM93LMFOfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9To528Ucl5GgQgTFgpmbjzivYbvIUrjP3OpEE6hY2fk=;
 b=eTl8Bae61tYxUEjz4fS4o0et/xrG7XpIJ2yxejJtcjsJfbeNlxLxcUv4I0pTLnz6hEh9/HDaTHN/G2P6aDLf/M7CymajMOzsz1QFltzPwNbRR4VGgt4VefeXYueAKTgmEsFoS9zUNpRsUBYFe6z0X3n5al+9IvQkqXkb+DeuiFRbn9C0MxhAN5vkdLxujJ5WrDFA5Ipp4r5XLE5idnTF0ImnsJ7gMh+TGnZ0rKSSJ1DriwdZ+pFaP/roda94zKh6u84Yp0CP4/i3D6G4eMDDgBEMmDh04jFRgjCNzE+AgOwSaN3ZPSD133m9Cd9B2RtauzovSIGrvUiWJOG+oZb6iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9To528Ucl5GgQgTFgpmbjzivYbvIUrjP3OpEE6hY2fk=;
 b=tY+ndiVRjnegXnjr6bm89hMmzX8rpSQ2wSWMd9SG+w+UdVsc/XYkgC+IB6lejQDc+46gwgs34jEAsNieIqA6MZaE8V30Y0ww96xowznZPP6Xt3C7koSCUM6915i8jQpvS4tvM7csRyBZTcZcXxkcucj3pWfA2ifsaVv474N0BYXxVsJ5p/wQuZkns2f5TxcHDKJM4YjMPTTHfsCyjRqByRx5HFFGI91QAMQrHS8Di5Al8xMxSMdwFPZe8OsRPeRINLOLRvrQ2pvyM7c3D+3hpRuhLRq8WfLFiwcn5a1ovTA37NE9ztbPIaOVS1ADBuUJwYzo+HmUREIu4hCeNXd0fw==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by DM5PR12MB2582.namprd12.prod.outlook.com (2603:10b6:4:b5::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Mon, 16 May
 2022 13:00:02 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::fd9e:abad:8541:b221]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::fd9e:abad:8541:b221%3]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 13:00:01 +0000
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
Thread-Index: AQHYUy6f8PYDEwnjH0GY1hRsyl4qdK0QbjTwgAAQVwCAABikcIALQwgAgAAAjSCAAZckgIAELgbQ
Date:   Mon, 16 May 2022 13:00:01 +0000
Message-ID: <CH2PR12MB38958CD365876A2106712C3CD7CF9@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <20220418141416.27529-1-asmaa@nvidia.com>
 <CH2PR12MB3895A1FB2977B725ED92AB57D7C29@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CACRpkdY1uK=73zpEM5zUyXacm5xaUUFYkuKMxi_q6vwmOPy6tw@mail.gmail.com>
 <CH2PR12MB389560A1873030472A7A371DD7C29@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CACRpkdZhW9XK3opXLLzdMiVLVkGQyJCf7RLZtRQLsmzv-aqwbA@mail.gmail.com>
 <CH2PR12MB38953FF57D91FA75AB9CB102D7CB9@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CACRpkdbAhMa2CXvQra3E13n8WfiBxyHNqzEp4dW3qo5upr_=gw@mail.gmail.com>
In-Reply-To: <CACRpkdbAhMa2CXvQra3E13n8WfiBxyHNqzEp4dW3qo5upr_=gw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 79c8bb89-269e-4b0a-5fb5-08da373bfd57
x-ms-traffictypediagnostic: DM5PR12MB2582:EE_
x-microsoft-antispam-prvs: <DM5PR12MB25825EAC8258FE687871619DD7CF9@DM5PR12MB2582.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H3IPcS6y/bZaHpWnM5d2DJaGAOJT4tFzxGyjIkHPnFt9hvq4aNdqhVnZ562a+0cuCqntGb/Fh9+MA5y6W5BMLZvuMsk8A3W6r6vdIdHbSEBDL9Qelo17NdbC/w+1Y2pC22qxG2FQ+LoADMTA/bbdMXhpiF2daRd3KIdzHqkfz9lxsAd6oU71n5NIRbdw/2nPJepTiokPlkWOG4NXTW6NrhPtJi9Ern51klXxMmCeo6xNHt0KnqAEmuPnW97WIFqEdoqlj4sgdbnHEwk8FYvBSb4Bux1smCLCnDFFBVT7f6hMf1GWNNqg/D56vh1IR/tyPNB/h0zhBt9h6IOIjIgMM38cWn1dbrhQrM1L+opAbO72lj1kOP7A/ys6J6FljzOSPuslB1Lw1FbFnzYn8pCXs2a7uwiXPtHs4Bn+OdXOZT3qPnS3KlQsCWYcBUqb0ESQlge4DI/z+s35aNmLhoUeO2t3Y8myBD+vqPUWO1dhFibVrD6ELpaWMTIVew/8uz0YsMOpQl4yjRSwE+REXLUftJHHKSkHRZQ+Bs4Q6qnFUNrb0gTLlUVkkpLkFcTWYIlec5EzKhg7IPatf/gAn1P+12dhJ56zGfLcCbeNAK8kwyngrB0bzH5IlbAeTsessdeWJy9DRQ3MwYFNw/n/gIukqMsS5k7voxsLips23lWX5F9sPUOueYyVZLELhXwR5zGMeSq16SA+wjWNP9OI/wduQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66446008)(38100700002)(64756008)(8676002)(66476007)(4326008)(76116006)(86362001)(38070700005)(66556008)(66946007)(7696005)(6506007)(122000001)(6916009)(316002)(54906003)(9686003)(26005)(186003)(71200400001)(508600001)(55016003)(2906002)(5660300002)(8936002)(83380400001)(33656002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEZxUm5scjBhZWVhd0dOYUpzMXpUT1JrbEtUYlNOa1VFSnFlQU1wTnRrNHpp?=
 =?utf-8?B?VkhtbHVUU2MwYkY1RFJOK3dOTDZsZzk0NUdFZnAwR3BWOWJBWWVMQUtlKzdi?=
 =?utf-8?B?TWhiRk8yTHdaUkQ1d0VDdTR1ajZTTWhKZ01MR080bThIV3NTOWR2QkdybkVa?=
 =?utf-8?B?NDRBOENobUdLVUJyR0dhTlhsNjg2NFBXRTV5Q3ZRTXVRMUVsWFIreGNIZ0Vy?=
 =?utf-8?B?ZjlnSWU1QmtWVkNqeEpiRUpCak9vcUhjZ1RuS253R2luSkEwZXpBNVo4eE0y?=
 =?utf-8?B?b3l2dG5reS82aGpHeTdlZTZZQXhNaHdjdjlGU1JZeDl6bi9tVDFQWXZiTVg4?=
 =?utf-8?B?enIwSnJhSHZyVk9mcWxoTlpKUVFGZkM3eFhjSGZZLzREZHhTZHp1ZVQyWmhL?=
 =?utf-8?B?Yzg0c1ZRb0owSE9Qd3k4TGYzUmRXMkFmVEZtZTRLa2RDUlJNR1JkVUo2NlMr?=
 =?utf-8?B?TzNGTG5ucVVCNkdubnV3RVVLcXFMaXVwRWQ5TzB1WndHemMrZWFwMFdwQUZu?=
 =?utf-8?B?cUJWMkx6K2hsa2RISW5yN3drbHNrTDJvNnl2eCtkaVdYcE11VEV2U1JKM2V0?=
 =?utf-8?B?WUwvMVNaWDY4aGFvdkkxbHpGYmRaTjdvUHNJaDEyMm1WcFdsbFZvbUNvcCtX?=
 =?utf-8?B?akJLdnRXNXhGOXZSTzlUeVJWbGVxY3labFdMM3QrNTljUDVFQTdGbGV0WmUw?=
 =?utf-8?B?UU0wU0ZyS003Y2dyME9ScXVDV0gzNThwSzVqVWJ0SS9kaVo3Q1lpem1zc0d0?=
 =?utf-8?B?WXltQW1VYy9FaHlqSEVhS2tHdmQ1NzZEVzJJaldHMXVCRFdtU3ROVEs2dEg5?=
 =?utf-8?B?eE1CUFpIT2dFY0ZaM2xsS1RpUUpsVGxXalJHb3BtbUkwVkllOTdxdzhIekQx?=
 =?utf-8?B?ZnJDWW80TUFOdm5lVW50SDlCS0ZSdHI1MHE4WXdUdG1hY0hWYytzYTFJdm5Z?=
 =?utf-8?B?TWtGanc5ZXNRbjdFUWMzMEcrNW1mOXFzTzAwTzFWcFRqVjl3ODhMYkZoeDlX?=
 =?utf-8?B?c216MEtFM2h2YnlPY3NzVTN1bkl2d25PY1IyUGJESTZaQndmZk1LUDVnTjA4?=
 =?utf-8?B?eFl0YnpTYmRzMGFGbWpMUFV1ays3L1RWZnVCQzFUdndCdVBLeUt1c2lkTGdK?=
 =?utf-8?B?cWdYc0xoQU82V2ZSbTloT3A3WVJnN2ZBWTRtVG5HUU1md3MyeHdwZ2NsVDNT?=
 =?utf-8?B?WDQzM05KYjlucVJENHlITTZpZkdpZVNDYVdaSG81MlpVRk1SMkJlOWp4dmMw?=
 =?utf-8?B?SnB6K2pkNWlCelNtUmNISFFTcFNkbVc2TlA1QlJQcUFLc0E3SktnRGxoL04w?=
 =?utf-8?B?azJOYTdaSVBlNzVla29sQXBrTi92VnlQY2JLMjFxWEpCbUszTHlrL1h6L0xX?=
 =?utf-8?B?ckFXazZVZ3A0Vyt1Ky81dTBOM0dKOVNCb0FTR2pxSHdyZnI4UUNwUlIwaHVP?=
 =?utf-8?B?OE92aElVb050Tkxma1Nhd1NJcU5renlKSytLblI5UEdNUTRxdVBmYndtNmht?=
 =?utf-8?B?UlBiQ0o1MkUwUEFvc0ovWXl1MVAvZ1EwbDgzSVVyeDdsL1I2eTdsWGRBN1pa?=
 =?utf-8?B?NU9lSEdJRTZyMFZkbzFPdXRDSHFPQmRaOEJqbWp3OGljSUdZOGV6WDh2MmVJ?=
 =?utf-8?B?eVNFNUhFajZCc3ozeWdZNnJ1OFpOcDFuQ002dUxESERRR1pVZU5XSDZkTm9l?=
 =?utf-8?B?MHpOODJ5di9jSitYMTFTTFhaVEh5V2d3U1VZcmhFc2RYMU0zWThrNGsvZ3ZY?=
 =?utf-8?B?NVcrazRidGFhcnpDak5yR2ZNeU81Y3J0NkJyMUhvVGJ1NmZMZHozdDRzWkFR?=
 =?utf-8?B?TlBYQkhGWDd5L25Edyt1YWZ2a2JnSjlBTzBIbGtpQVQ0OXFTelFNc2ZER1p6?=
 =?utf-8?B?ZzhXblJRYW12TXJnNHV3NFdqL0JUcWxDZDE4c3RhMUtZRzJteHI3V0NrNU41?=
 =?utf-8?B?a1pWWXl3ME1SSjF0TVA5V3k1Y2E2OGxpdnAzeU1NSUo4cXVpK1NQQ0Eyc1Av?=
 =?utf-8?B?TWRtWHhicU1TbWVWSEc2T0hyWHl6b25Bcmk1NTRKMUpucVU2SGdNZjVHOFRB?=
 =?utf-8?B?NGpmV01wZnVxYkNDLy95US9QTlB5WTRlVnRVVTNEQW92bTdmUUlKSlRibWtx?=
 =?utf-8?B?NDlFdmpneFdtLzhLMDRkR1ByRXRpeVp2S29PNXpFN2c0bkc4TjBYd2xCZTFi?=
 =?utf-8?B?RkxuRUNhcmNzRzE3a05nVVdsM21oOHhGT2R0UnhUQ1ZieG1zQ3pBZUJhMWdH?=
 =?utf-8?B?QjNjZ3pLMkVmc1c1Q0ppL0FDWmFMOEtzWCt2Q24yOTJ2azd1WTVqalhjN2tS?=
 =?utf-8?Q?KYua3MWtSdb7f7JYhV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c8bb89-269e-4b0a-5fb5-08da373bfd57
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2022 13:00:01.8837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e52Pjh1cYLXAMNm+JeDl2ND/I84JAj9cq9Z5Ngd0nRtWPedWZXqp8JppTNNoWkPeyJcL9YEx48RZIfM+BalQiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2582
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Pj4gPiBBbGwgR1BJT3MgYXJlIGFsd2F5cyBjb250cm9sbGVkIGJ5IEhXIGJ5IGRlZmF1bHQuDQo+
PiA+IEZXX0NPTlRST0xfU0VUIGlzIHVzZWQgd2hlbiB3ZSB3YW50IHRvIHJlbGVhc2UgY29udHJv
bCBvZiB0aGUgR1BJTyANCj4+ID4gYnkgSFcgYW5kIGdpdmUgdGhlIGNvbnRyb2wgdG8gc29mdHdh
cmUgaW5zdGVhZC4NCj4+DQo+PiBXaGF0IGRvZXMgdGhhdCBtZWFuIGluIHByYWN0aWNlPyBXaGF0
IHdheSBkb2VzIGhhcmR3YXJlIGNvbnRyb2wgYSBHUElPPw0KPj4NCj4+IEl0J3Mgbm90IHNvbWUg
d2F5IG9mIHJlbXV4aW5nIHRoZSBwaW5zIGlzIGl0LCBzbyB5b3Ugd2hhdCB5b3UgYXJlIA0KPj4g
Y2FsbGluZyAiY29udHJvbGxlZCBieSBoYXJkd2FyZSIgaXMgYWN0dWFsbHkgdGhhdCBpdCBpcyBj
b250cm9sbGVkIGJ5IA0KPj4gZS5nLiBJMkMgYW5kIG90aGVyIHN0dWZmIHRoYXQgbWF5IGJlIG11
eGVkIGluPw0KPg0KPiBZZXMgZXhhY3RseS4gVGhlc2UgR1BJTyBwaW5zIGFyZSBhbHJlYWR5IGFz
c2lnbmVkIGEgc3BlY2lmaWMgSFcgDQo+IGZ1bmN0aW9uYWxpdHkgbGlrZSBJMkMgU0RBL1NDTCwg
TURJTyBldGMuLi4gYnV0IHdlIHdvdWxkIGxpa2UgdG8gDQo+IHN1cHBvcnQgdGhlIG9wdGlvbiB0
byBjb250cm9sIHRoZW0gZnJvbSBzb2Z0d2FyZSBpZiBkZXNpcmVkLg0KDQpCdXQgaG93IGRvZXMg
dGhhdCBwbGF5IHdpdGggeW91ciBwaW4gY29udHJvbGxlcj8NCg0KSSBtZWFuOiBpcyB0aGUgbXVs
dGlwbGV4aW5nIG9mIGRpZmZlcmVudCBvdGhlciBkZXZpY2VzIGFsc28gc29mdHdhcmUgY29udHJv
bGxlZCwgc28gdGhpcyBzaG91bGQgaGF2ZSBhIHByb3BlciBwaW4gY29udHJvbCBkcml2ZXIgcmF0
aGVyIHRoYW4ganVzdCBhIEdQSU8gZHJpdmVyPw0KDQpTbyB0aGVzZSBHUElPIHBpbnMgYXJlIGFz
c2lnbmVkIG9uZSBzcGVjaWZpYyBIVyBmdW5jdGlvbmFsaXR5IG9uIHRoZSBib2FyZHMgYW5kIHNv
ZnR3YXJlIHNob3VsZCBuZXZlciBjaGFuZ2UgdGhlbS4gDQpCeSBkZWZhdWx0LCBmb3Igc2VjdXJp
dHkgcHVycG9zZXMsIEkgdGhpbmsgd2Ugc2hvdWxkbid0IGxldCB0aGUgdXNlciBoYXZlIHRoZSBv
cHRpb24gdG8gY29udHJvbCB0aGUgR1BJTyBwaW5zIHNpbmNlIHRoZXkgaGF2ZSBhIHNwZWNpZmlj
IEhXIGZ1bmN0aW9uYWxpdHkuDQpCdXQgZm9yIGJyaW5ndXAvZGVidWcgcHVycG9zZXMsIHdlIHdv
dWxkIGxpa2UgdG8gc3VwcG9ydCB0aGUgb3B0aW9uIG9mIHNvZnR3YXJlIGJlaW5nIGFibGUgdG8g
Y2hhbmdlIHRoZXNlIHBpbiB2YWx1ZXMuIFdlIGFsc28gbWlnaHQgaGF2ZSBjdXN0b21lcnMgdGhh
dCBjaG9vc2UgdG8gY2hhbmdlIHRoZSBkZWZhdWx0IEhXIGNvbm5lY3Rpb24gb2YgYSBjZXJ0YWlu
IEdQSU8gcGluIGFuZCBjb25uZWN0IGl0IHRvIGNvbnRyb2wgdGhlaXIgTEVEcyBmb3IgaW5zdGFu
Y2UuICANCg0KDQpUaGFua3MuDQpBc21hYSAgDQo=
