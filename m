Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5FB52BBD3
	for <lists+linux-acpi@lfdr.de>; Wed, 18 May 2022 16:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238430AbiEROGI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 18 May 2022 10:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238418AbiEROF4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 18 May 2022 10:05:56 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5556D3335A;
        Wed, 18 May 2022 07:05:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmK7+PuhVMmjGe5IYx6ZOfI+krd+ZusSCEW8HvnscO0/R39T87B8SyPV2VGMT1Izon9xokiHth63lbO79rk2Nkyg0ZQgGXk3A1OOCdNNWJXVxdAemD1kq+GwQ6YbIHYVosGrMNGbHYOUPeyk47MsyirQEHan3wbFzAgQy2DcEyTKyBGntiduyT8/yDg8MUa4F1XsJ/QPyDnpB/qKGjBDHnmvcpMGAfEV1ZuSUGgptOf9ePX6hTHm5Ab2biSpxUfocxHhcKnn/G8Fs4R46catBFsq6RafcAfHjxqh5YmuJHLGG3euVui0G1kan2Zq+dk80fJNBXJvf8FnxqodLtKFvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gggUnKCMd8FSJVZn2fWsa0M2cs3WntQDuLLp4r/mcH0=;
 b=EGyuMICbpNR0GHokkKGMbBzMJfpmoj16kCFVmOMCGe7nmG1MqQvnK5eBw/sZYScFIAG3ccaB4b5c0PE+yQNOr8ssapDD4EUBGHmlb9M7yNk6T8hhbcTefY3J5gw6gdDkqaRXEMyo/9qs23ZEp+WtJKan0s26YimZ9FmklEh2XrfcSx+yXISxXC6w/sX+syPXFDAn9/lBHJevu1UllHhHP4eoXBFnqyRnptT96aeMFw413a190G+yfrSVntTPVoKhDQWtmTxZKpebdMaMpFVfuG5FshCngF9LoHJNwMohk+I1XYW13mtQiydtwmKcaIzO86WVrL3oNZ9/Sv7Cp0k5fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gggUnKCMd8FSJVZn2fWsa0M2cs3WntQDuLLp4r/mcH0=;
 b=brwpnUqZpNTUn1pU37zXzCQkjsJua1BpqmRLIMQ/6u5N1tY1oSiXQMqKSertKeNjzucQion5bd2eYOVwNXHD3tqVCEeBIfXaOJURgXsq4VkjvWnwvO1hzTxrHJDzoHlZWjx/EmRjBrQMwoh5zTQCZtLUBSSZNiZe2BIwut4bwHc6mH59qSzNXDBFcuFzRYabKJvalIy932snPeRcd25H/kN0qeif714MWZ3w8RcImXYxmFixzG7ibILNwcOBU/tNbtzTY/AD9HmRrnQFZRvL36oJm84GxhhYsucWePFVYnJckFmVadpfLcXLQ2+5T9YAbq6cuJ/pBJu9qjdJ3IPy4w==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by CY4PR1201MB0086.namprd12.prod.outlook.com (2603:10b6:910:17::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Wed, 18 May
 2022 14:05:53 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::fd9e:abad:8541:b221]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::fd9e:abad:8541:b221%3]) with mapi id 15.20.5250.018; Wed, 18 May 2022
 14:05:53 +0000
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
Thread-Index: AQHYUy6f8PYDEwnjH0GY1hRsyl4qdK0QbjTwgAAQVwCAABikcIALQwgAgAAAjSCAAZckgIAELgbQgAM2cYCAAAOoIA==
Date:   Wed, 18 May 2022 14:05:53 +0000
Message-ID: <CH2PR12MB3895763500532CA0A76E314ED7D19@CH2PR12MB3895.namprd12.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 366500bb-e28f-4193-3a8e-08da38d7859d
x-ms-traffictypediagnostic: CY4PR1201MB0086:EE_
x-microsoft-antispam-prvs: <CY4PR1201MB008615ABDF10E90F9EADB80FD7D19@CY4PR1201MB0086.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2cictMOnFtFTYaSlP7anlN3KOvHHLJD37VYn8R7PMI6qVH0hZF8BzFlC95kRvPWjQF9y7X+U2BigZaW77njgXW749XH87rhssYUmJxbKE3G4Yxfy3uxzOmCtg5/ZGV0LQS8MAcfqzj86EG0Pq5bwdZzDQ7Sl4PJsv2WclCwoZgFxStpXsvywtgez9qxKBZx+tgNBVhM/RLfg5+cJsWK7EWBoBB7fyK+qo9+fzOcflqpHDP1AB7oZYSlunjy38bkQOCLTpE3GNdkhh5t8MlC5bjrHFZs+BzBn8VQMlWyiQSlGVWbktH0pioSn7xTbvX1KedkpI504oL1o4eK1f0VUJnmsynvM/aVMJoYCTwKJF6t/CSPIBdN8UiVUII59lEl7RiS98dtFxx8+Y5EskPN6omvuywLwuIwwyYAsLc2xvn+rRIeaTKbF2ezuO9Ya7JwSTCvRtn0v08iA+VlSvbzJtus3U4FmtENnIEyQy/HQMiuqPe/FJjeV2TYILyQEnJGxBzGIwXuZAC+b0ik2KQgnt20mL6dSPyI2poVbhg/8pq+GOxsOo6i3Dxap5cn9dsP8jztc7M088ZJa2conCoosNNPvoazeMP6n7aIBsz9453zQUYCO7nJXobbc8gmkB0qbnpEvcTj3oeSJx3NQVU4EJ4qEQBCESUaWY0MnPBLu5QPSDH9pUoSR4ppNnPrubYlyjUsYtPRHBbXOf/3pe4gBMn0Fuq6umXNAYHRJdcl8AORPfCV3D18GbJjNos4yJ7w2x3cDQSGNBaf5K2k3IFtf8kRKnIlE0BGS00jcNTOQhWM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(54906003)(26005)(86362001)(508600001)(55016003)(122000001)(83380400001)(9686003)(186003)(6916009)(66446008)(76116006)(7696005)(966005)(64756008)(53546011)(6506007)(66476007)(38070700005)(66946007)(66556008)(38100700002)(33656002)(8676002)(2906002)(8936002)(71200400001)(52536014)(5660300002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHY0ZTZYRW0wZjA4UEs2ZmtZSDB1WGJ3OWFLd0xtU0pjQjk4UTZFSlY0Vko0?=
 =?utf-8?B?NnI2ZVB2RkVnNnRLbm1aUy9yUjh3aEZFMC9LSnNwTEo4cVY3d1NIei9rckNH?=
 =?utf-8?B?aWhCeWRwOGtuYUUxU2dtQ29LVjYySHZ6eEVxUXNEa1F4bkZXcHBWVmxkWnYz?=
 =?utf-8?B?ekJNbnVnSklIMklJVDZKQUdlZEJLaTJZNi9NVjhhQlVMbDBNcGg2amQxakdw?=
 =?utf-8?B?OHJaS3Z4dmNBUFNENWxKV2QvbXJleW5QNU02Mi9UZWljMCtHSlI0V2pWdkh0?=
 =?utf-8?B?YmpNcmJDRXBOUUIyd3VNN0ZjT203VG5YeGZneVk4V2VXeFkxQ2wrTE8xZXdF?=
 =?utf-8?B?UHFzRGtvc253aTE1QjNDdTNhY2oyMUowblRUWGcwQzlvZWhDTWZtaDJxZWtP?=
 =?utf-8?B?MVdGWkFBZ1lGL2g2YmxEbTNpeDJqRGFUc0xFVjBqemdWWDR6V0xpTEtHazR1?=
 =?utf-8?B?eDdDU3ZFdmJwbUtOV3hqTmxIbm9LTE9JN1RxRUZSSG1JK3ZpOFVjTUpSQUNN?=
 =?utf-8?B?US9VVlArSnM3WFVZQ0VkU2JxeDE1TW8wSkduYUc1S0szaDNOMVZrSm83Zk1Z?=
 =?utf-8?B?ZzVSSU5sRThRVkRLZ1hxRXJmcnFLZnpuZ1RjSHB6QkhPY090ckNRbytkdmhN?=
 =?utf-8?B?bWtzeWtNSEdraUQwNU9Sekg3c3NJcnhQVGcvdll0RzZ1UmMxWjhTQTlOWGNS?=
 =?utf-8?B?RE1wWkMyMGZXY1JEelRUQ1NQYlZvQ2k1Yko0OFUyMWtaNUNxU3pJNUU3ME1s?=
 =?utf-8?B?VW1iZWcxc2xMWitQSXVZNnllQXJMaXN0cE1wVHA3N3YxMlBvWnh3Tmx6cEt1?=
 =?utf-8?B?RElDY1dzYjY2VGRWV1M0eTE1bXhJaGo3cGRzZkNsa09MSXZsLzA1dUVYSFF1?=
 =?utf-8?B?dGU3YjBqZEJuYjBlUnBwcEhIZ1VESkRXMmZuMTBjdWpBUENDVTc1aFVmYzdN?=
 =?utf-8?B?L2U5aVJxZlVsOGtLZHN1WDgveGUxaFg1cnI1THplLzFwRHV1dGVwZ0lacXc4?=
 =?utf-8?B?ZlAzVXJPZGdaTUYzOHNKQUh5OTcrSVA5RG5KamsvNGg1WG5tdlRYcUNrNGhD?=
 =?utf-8?B?aXQrYWNZWEcxMUFTZm1iamFlWWlzWERTeE5YamRDaVpEQ0FLb0pteDZibzV1?=
 =?utf-8?B?N1hqbncvZVFWMFJMT1Y2RDBWalp4dFo2RnVYTnllZHk3NnlHQkVKMW9vWjhV?=
 =?utf-8?B?YzU3TkxqbkpSTnlueHpUbjJmZllRamJQLzlXWUJkTFRRSjZlZHhFZmIzRkxx?=
 =?utf-8?B?eVNFYXdXVVpZejRpVW5qTVRXM3RlY1FJWW9WTm0zTzd4cnRjTTRlaGoyTElY?=
 =?utf-8?B?MWo2WDJOc2M3UXFPZnVNQkx3U2Jvd25qYVg0NVhRVEE1cFI2dzh5NWdVSyty?=
 =?utf-8?B?UUtib08yMys1eXNYMGNULzVkcno2WUlMbldOQXVFTDQ0MEdTdEVmNDJ5eXRy?=
 =?utf-8?B?TW8vaU1xOWtQMkthb0NVVUw3UDhqZVRITWZtNWRYR1lYbnh1Z05sTFZMbmE5?=
 =?utf-8?B?b2sxYS9KMzZWeEsvVUxnOHdHOU1TcGZSSHU0Z0svejFwZUJUa01FM0NEQm1M?=
 =?utf-8?B?SHh0cFJ6SFFZT25SV0ZacjA2bFZWV2tFRUZDUlNqRytCUXMxRjc4Y3RlSHF6?=
 =?utf-8?B?M0VKd24rMjBnUXhadGIvdVVBRzhBaktrUjczZ1pkQzhNL1dPMTNuRVBLZmI1?=
 =?utf-8?B?SEo5YVpUM21hMnpMRktXemVoTzVJOGE4ZTVNbDhUY0gvcFZmQ2NCMkQzV1VS?=
 =?utf-8?B?bVd6ZVErMGdsSGxjSXJ5bkc0UlFVV3MvdGxQckdJbGdrMlgzNmZ6dkdEbHVZ?=
 =?utf-8?B?NGc1UVhlbDZrY25IRlhsMEJsT2tVSExpSFFVVTdBL0h5dnFGWFZ0dlU2SURK?=
 =?utf-8?B?SFl0VmxrZFNQd3ZIYjMrbUdTcXA5M1FFZHJ1M0dma2ZHSldhMTZUNmRhQ3ND?=
 =?utf-8?B?S3k5WWdiKzhobGcrSGNHRGlrVUJYY2MrR0ppdlhMOGJJUFRwKy9WbmpzeEFB?=
 =?utf-8?B?Q2RCWkgxUTVWMFRzRXREUS9kNW1WcWR2anZpKzEvWW1qV0dybzNJS0ZjR0Vl?=
 =?utf-8?B?UWdMREtVRGFRUkl0Q3ZQSmpGZDJUQ2x5Ukl1ait2anllMWluZms3Wnh0Umlh?=
 =?utf-8?B?bjdXU1hveTFhNnR0SkhSSEorRjJhcEpRN0VMMnBXS3orVjlZL1V4RlVWeWNL?=
 =?utf-8?B?a3lGWHpoMjVnUGk3SUJMQlJYWlpoQitDRU9IT1haZENpTGNodjhRUUxOTFdz?=
 =?utf-8?B?d1d1akNhRmppZ2RYWElZeXdhMWVXdU14QVZsU3VueFdKRDEvT0FBaWhYN3lI?=
 =?utf-8?Q?vcqLt1pDJ89Pdjbd27?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 366500bb-e28f-4193-3a8e-08da38d7859d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2022 14:05:53.6831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fDfbJYAmMguVRKLzNy2Zb61+bRMCdra3c9Xo4RdyYzABGMtVDU2m55LexF9BnzYnACsQBdwSg8EYDvzEeN9jAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0086
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

VGhhbmsgeW91IGZvciB0aGUgZmVlZGJhY2sgTGludXMhIEkgd2lsbCBhZGRyZXNzIHlvdXIgY29t
bWVudHMgaW4gbXkgbmV4dCBwYXRjaC4NCg0KQmVzdCwNCkFzbWFhDQoNCi0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQpGcm9tOiBMaW51cyBXYWxsZWlqIDxsaW51cy53YWxsZWlqQGxpbmFyby5v
cmc+IA0KU2VudDogV2VkbmVzZGF5LCBNYXkgMTgsIDIwMjIgOTo1MSBBTQ0KVG86IEFzbWFhIE1u
ZWJoaSA8YXNtYWFAbnZpZGlhLmNvbT4NCkNjOiBhbmR5LnNoZXZjaGVua29AZ21haWwuY29tOyBi
Z29sYXN6ZXdza2lAYmF5bGlicmUuY29tOyBsaW51eC1ncGlvQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMS8xXSBBZGQg
ZHJpdmVyIGZvciBNZWxsYW5veCBCbHVlRmllbGQtMyBHUElPIGNvbnRyb2xsZXINCkltcG9ydGFu
Y2U6IEhpZ2gNCg0KT24gTW9uLCBNYXkgMTYsIDIwMjIgYXQgMzowMCBQTSBBc21hYSBNbmViaGkg
PGFzbWFhQG52aWRpYS5jb20+IHdyb3RlOg0KDQo+IFNvIHRoZXNlIEdQSU8gcGlucyBhcmUgYXNz
aWduZWQgb25lIHNwZWNpZmljIEhXIGZ1bmN0aW9uYWxpdHkgb24gdGhlIA0KPiBib2FyZHMgIGFu
ZCBzb2Z0d2FyZSBzaG91bGQgbmV2ZXIgY2hhbmdlIHRoZW0uDQo+DQo+IEJ5IGRlZmF1bHQsIGZv
ciBzZWN1cml0eSBwdXJwb3NlcywgSSB0aGluayB3ZSBzaG91bGRuJ3QgbGV0IHRoZSB1c2VyIA0K
PiBoYXZlIHRoZSBvcHRpb24gdG8gY29udHJvbCB0aGUgR1BJTyBwaW5zIHNpbmNlIHRoZXkgaGF2
ZSBhIHNwZWNpZmljIEhXIGZ1bmN0aW9uYWxpdHkuDQo+DQo+IEJ1dCBmb3IgYnJpbmd1cC9kZWJ1
ZyBwdXJwb3Nlcywgd2Ugd291bGQgbGlrZSB0byBzdXBwb3J0IHRoZSBvcHRpb24gb2YgDQo+IHNv
ZnR3YXJlIGJlaW5nIGFibGUgdG8gY2hhbmdlIHRoZXNlIHBpbiB2YWx1ZXMuIFdlIGFsc28gbWln
aHQgaGF2ZSANCj4gY3VzdG9tZXJzIHRoYXQgY2hvb3NlIHRvIGNoYW5nZSB0aGUgZGVmYXVsdCBI
VyBjb25uZWN0aW9uIG9mIGEgY2VydGFpbiANCj4gR1BJTyBwaW4gYW5kIGNvbm5lY3QgaXQgdG8g
Y29udHJvbCB0aGVpciBMRURzIGZvciBpbnN0YW5jZS4NCg0KVGhlIGZhY3QgdGhhdCB0aGUgdXNl
Y2FzZSBpcyBicmluZ3VwL2RlYnVnIGRvZXMgbm90IG1lYW4gd2UgY3V0IGNvcm5lcnMgYW5kIGRv
ICJxdWljayBmaXhlcyIuIFRoZSBwcm9wZXIgQVBJcyBoYXZlIHRvIGJlIGltcGxlbWVudGVkLCB0
aGUgYWx0ZXJuYXRpdmUgaXMgdG8gbm90IHN1Ym1pdCB0aGUgZHJpdmVyIGF0IGFsbC4NCg0KV2hh
dCBJIGhlYXIgaXMgdGhhdCB0aGVzZSBwaW5zIGhhdmUgdHdvIG1vZGVzOg0KDQoxLiBVc2VkIGZv
ciBhIGRldmljZSAoSTJDIGV0YykNCjIuIFVzZWQgYXMgR1BJTyBieSBzZXR0aW5nIGEgYml0IGlu
IFlVX0dQSU9fRldfQ09OVFJPTF9TRVQNCg0KVGhpcyBpcyB0d28gcGluIGNvbnRyb2wgbXVsdGlw
bGV4aW5nIHN0YXRlcyBhbHJlYWR5Lg0KDQpTbyB0aGlzIHNob3VsZCBoYXZlIGEgc2ltcGxlIHBp
biBjb250cm9sIGRyaXZlciBhcyBiYWNrLWVuZCB3aXRoIHRoZSBHUElPIGFzIGZyb250IGVuZC4g
QSBzaG9ydGN1dCB0byBlbmFibGluZyBwaW5zIGludG8gR1BJTyBtb2RlIGNhbiBiZSBwcm92aWRl
ZCB1c2luZyAuZ3Bpb19yZXF1ZXN0X2VuYWJsZSgpIGZyb20gc3RydWN0IHBpbm11eF9vcHMuDQoN
ClBsZWFzZSByZWZlciB0bw0KaHR0cHM6Ly9kb2NzLmtlcm5lbC5vcmcvZHJpdmVyLWFwaS9waW4t
Y29udHJvbC5odG1sDQoNCkkga25vdyB0aGlzIG1lYW5zIG1vcmUgd29yayBhbmQgaXMga2luZCBv
ZiBjb21wbGV4LiBCdXQgZHJpdmVycy9waW5jdHJsIGhhcyBhIGxvdCBvZiBleGFtcGxlcyB5b3Ug
Y2FuIGZvbGxvdywgZm9yIGV4YW1wbGUgZHJpdmVycy9waW5jdHJsL3BpbmN0cmwtc3gxNTB4LmMg
YW5kIG90aGVyIHNpbXBsZSBtdWx0aXB1cnBvc2UgY2hpcHMuDQoNCllvdXJzLA0KTGludXMgV2Fs
bGVpag0K
