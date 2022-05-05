Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62AF751C59F
	for <lists+linux-acpi@lfdr.de>; Thu,  5 May 2022 19:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380930AbiEERFl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 5 May 2022 13:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382497AbiEERFb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 5 May 2022 13:05:31 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05845BD30;
        Thu,  5 May 2022 10:01:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2MCGK46gJQQMf2SCeYb2yOQu/fXqVHjrUU5yF6BmeVoXWRbLmMuFbI9Vjt9TvRfrC6mCdMzzaoshwyC6fbvITQOqJ/aDTLWLMNh8kcOHiJqW7lAyGIhCZNOjyUFdidqqks0P2LlwidJVq0cZ4mg834gF3+U8Eyu5fDS6tF+plZ4vD7MGC965iC/2psFitZEr2tDwqg7alEhP/kO5DxgqiZCEz1M7IaEMEwed19ulTlzwgpfWBLB2TvkQ7chAn0+zYXNpIGekNQyuasaOYtozHyivOd4eabY7M8K6N2LQIPw7i9Bu/8nVRMFB158gXreIQwyaKdwjuzaond9Tsl4NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3FJMpWutrv1R91IjXGWI1d4RjM9hTQqpB858LLL/UAs=;
 b=G2459nBEXly4SwwzcVbmhvWurwWpQ9GPE1hp2Olf1tLbEA420OpF+DffHzemusRtUOvHG8qzEnDHHmDAszz+LqF7T89akPDa/J7L6BR2lws2W3AY22QCb81FFYMel35tfsnkWi3hl+gZhOGc1P9DrjEG4Mhmbbt3NUd7QKIu7oEvvugIXYk4XylL21QQL7weHCnN7MHjilkgGNhkgkJTimktbhdhO3ICrANa7KQmIhZ4zV1NHEAEPqJv1v4Ksjk8sfR5SjVKntTJuzepnNTgLzpsRk2r1+7U7o5oZh5Db54IIoHXlN1F6QFfGDj/0SFe/aGm4nq0pmXtmq/fyAOLiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FJMpWutrv1R91IjXGWI1d4RjM9hTQqpB858LLL/UAs=;
 b=GWEMDO3D3VhPKoFroV9+EAi9GmJlL3UTxiwyRagjxaVwRE6HGHuWTgYx/QwUGT7pLNdRpQhkHX+dXYItd1TY4DJFaG5e8JGfvhRXz1e4dED2MxN25ajQ9DgQnqZyuj8tLlbdRv/lGl+YuVPYn+GofMzZXETehTTWmvmCrMiCnSNF7uqxaFvCoJE2RWtXVMFRQsOiGEBZ8Y/GBzvAzlQSP2ZRzh5Uj52A7gUqmSHbGOEsbr4XwP00/N8HssM6zU8bYxTGdgsvds6dg6skQGOqV47dKRhq4gIIYZoLJoFEu1dJycqwkxxFj46vXd4NJ8Ao6DUwU9ubCl0+ehYMtXR6BQ==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by DM5PR12MB1497.namprd12.prod.outlook.com (2603:10b6:4:d::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.27; Thu, 5 May 2022 17:01:22 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::fd9e:abad:8541:b221]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::fd9e:abad:8541:b221%3]) with mapi id 15.20.5206.024; Thu, 5 May 2022
 17:01:22 +0000
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
Thread-Index: AQHYUy6f8PYDEwnjH0GY1hRsyl4qdK0QbjTwgAAQVwCAABikcA==
Date:   Thu, 5 May 2022 17:01:21 +0000
Message-ID: <CH2PR12MB389560A1873030472A7A371DD7C29@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <20220418141416.27529-1-asmaa@nvidia.com>
 <CH2PR12MB3895A1FB2977B725ED92AB57D7C29@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CACRpkdY1uK=73zpEM5zUyXacm5xaUUFYkuKMxi_q6vwmOPy6tw@mail.gmail.com>
In-Reply-To: <CACRpkdY1uK=73zpEM5zUyXacm5xaUUFYkuKMxi_q6vwmOPy6tw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d2f03cc3-b7d6-495d-a997-08da2eb8e1ad
x-ms-traffictypediagnostic: DM5PR12MB1497:EE_
x-microsoft-antispam-prvs: <DM5PR12MB149728B46739A052587F5C8ED7C29@DM5PR12MB1497.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vmnO2nwiB+D4wLgC7993zm+svq4etChswvlkGXbDcwWrKVTKVAoqEdH2sTHgZjLrjKffqVOfIHsUThyKqePaRGbctSZcGVIIANspWnaCelC5BnHNtT7Njym+K91zZoVG6cem7ZpJwDbVgCQ8XOsoe3IVisQhk0bbVCygnFzyYMfsnEf/ZCyjNvjR00eeL7e90REgRuJQLoxlOrs2ZZAZlbDlV/sh4fxwu0mPjR4SPG0F1ot8SPyoxYAf45qDP3HQuQuyo86ylXcWL/r/e5pKfesS16cF1Ga442NZPcrnV0Yum0tXazgMytG1PfNJjFI6l3TgI2X9q/TPGLWxcj+nrE3V2Ol3m/GJafXBYx73GN4uCktysWhGGXJzPiYi871ZSqoijDQkL4NFaPq0fcwTymhn3tCj2Cvc1Etk6o1ORlAsG+UhcH8LH49KoUY8G7YpVcIxqx7NXrbfaXrWr/W+j7KSvIf9sX0uwMsoAisMYL46EpCKC6kbi5SnhlJHd5+MzATdhX0rubnuWFfhOowlj7ojUIp87GXcbHDYGvUO4s4MC53ldXz48SLf3WTIncVPGy/FBaSOrrZNPKnSI9xBbn7+PaV2JHe1L62mZRtOpSGHFqGmZwPcC9RWNt3WXYwa+hcpPb04hAOkPPKZtlRd6eDwHUw4mI9q2oeazFZJyPmEH0NBRk/UHCaD8aCt66jeUJUCpleuwVYZnCMW8kpHwg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(52536014)(316002)(186003)(8936002)(38100700002)(38070700005)(122000001)(7696005)(76116006)(6506007)(26005)(53546011)(64756008)(66476007)(55016003)(4326008)(66946007)(66446008)(66556008)(8676002)(83380400001)(508600001)(33656002)(71200400001)(86362001)(54906003)(6916009)(9686003)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXgxTTZuelcxRS8wNWpEdSs3WFUyUDZQQTZQaFNZQmgyVklqMHltd2FxTHhV?=
 =?utf-8?B?Q3JSVndqZkhDUml0ZjVWbXJGdDQvMWQzOWlhZHhocDdEaU9lZy9XTWFQT0Z1?=
 =?utf-8?B?dGJnMDZjbWRPWWxuR3hVM0NpdjZhcmtFSlh0UjlQcThYWEswUEVkbktFak9F?=
 =?utf-8?B?ZVJtTmRxZmZ3ZWJ4SGxVZktvZEczQ0w0c21idzI1c2l6eVRkQnhqUjRhRWJQ?=
 =?utf-8?B?Y0MxNkxFc1JZVHllcTBWUEhwZEwzVmpENXhuSkRIaDBsUVpYTXdRbzBUZnpp?=
 =?utf-8?B?Vi8wUDcraFUwZjZqOFY5a1E1M3B1RDNPblZvZXNBT3RaM3ZDMjA3MVhQbkR0?=
 =?utf-8?B?RVZIR0N3SEJVemZYTUlDVjBvTDBlQ2RKTjZqdkt5ODVPRDkyZG5jQ0FPWmlx?=
 =?utf-8?B?M3JuV05RZ2ROV2NZMlpOZnNNVkFVaitOaDZqeFMrTW5Rcml5ODRJRkRuYy9F?=
 =?utf-8?B?NGFRa3p1eFJHZWtVUE1CQUtPZHlTSmJNbGRPZTVNTHk2OUZLQ0lNOEJMNWVP?=
 =?utf-8?B?TmNpMzRsbUlBamJUdS9KY21JNzhsa3ZNSGhkWTVCUDVuVTB0Q2tkMklleVYw?=
 =?utf-8?B?dG9WeG8rSTBFTHA5TW90YVAzdTRRQ3c3RlVtYWZ5RlY0QWswSGdkZnUrUW5Q?=
 =?utf-8?B?RGhnUWIzd3BPSEZSaTArK0hYdUVTZ3hXdnNxMEFiV09zc2VwVlRSZWZabU9j?=
 =?utf-8?B?ZGI5b0g3UURNdkdUVlE2eWZnQzc5N2xrM1pkMmsrdVE3cVpnZXB1TlljL2JC?=
 =?utf-8?B?UEY0dGJVbVJnTlJMRE52TGtHQnp3MGxLZzlZQ1M4UHRxRlhzNTBtNHhGZ3lX?=
 =?utf-8?B?ZFpOWDFyU2ltKzBWMEJSV05pSjZadkdtdGI3YlcyNWJpaUxaaUoyMWFiTXYw?=
 =?utf-8?B?OGJtRnpkR2pSM3R1MEI0V1MwaU1iSnBWNEtQYitkMEJTaE9vWUg0NWUvR1Ra?=
 =?utf-8?B?TXZmd2xHU04zcjY4YzV3cURZZlYyak5YOWQrR1RpMHArWlNYQTNIaStqbm05?=
 =?utf-8?B?RnhrYlMyNDlNbEZuUmJoNEJVSzBjV2lNVDQ5UkQ5OHB6a05jNzJuN0FYZXc4?=
 =?utf-8?B?RTNCMDk4cllWZVhMVVEyN0YraDlPMU5ZVERzaDB6TFZjeFNpdmlmeGRMb2l2?=
 =?utf-8?B?RVJxbkRmd2ZOVTg5Wm9tenl6bTBWVEVWV3dFTUtjVU9ZTGtxczdYci8rNUVz?=
 =?utf-8?B?dW40cVBESFJZaDkxZ0cva3JzRU5QRE1MaHowS2VTbUJLSGU5OFE5SjlVZklS?=
 =?utf-8?B?SHViTDZ6K1dWVlpSMXhXaU84Nm5VS3JSRVdWWjNFRlhtbVk2Q3dFcGh6TUV5?=
 =?utf-8?B?V1B0eERPT2lmdmhqVUdNRDFYdmo3aDJZMFZqWkFFSnZLaWNRVHlXWVMzTldL?=
 =?utf-8?B?MUVVdWx6QVlUTis0ekxIRHVmOGE4LzV5SW5uNHFldzFWaEIxY240TFduK0l0?=
 =?utf-8?B?djA1MVNnMkJ0TGhvanF1SXFRTGd3bTdnQnIvN0lYcjNmNzBldjhLeTZTMGlm?=
 =?utf-8?B?TDBzVzk1YncvUFdRdVJEMEh4OGxZZ1M3ZWRVSklZZ05pekpUSThsZElEMDJM?=
 =?utf-8?B?Q3FxRzhaL0RWdmJMRkE5d3F5b1ptQWg2YzN1SjBQemxMcFVMc3Y2V01PcWwv?=
 =?utf-8?B?eUM4QUprUENDNEdWdWtsUVRRb3ZRWUs3RGNuN01yenFxcHdOY1J6V3BNaC9k?=
 =?utf-8?B?dWZwdHo0MjFzbmtpdExBNDFXa3VnK1NkcjJnRjJLL3BhT29lTkZjUEd0bi84?=
 =?utf-8?B?Q0JjcmdWaFI4RUhtRG16a2JhNkFTM05GSFJUdEE0WkVpZjFEQ1dEL0Z0eWRQ?=
 =?utf-8?B?b3RUV29jdFNZOGRSSG52MnFmNHluVkRoS2d3cVdYOVpSU3VXUk9VTHlFMXFk?=
 =?utf-8?B?eFU4SFJjWjV3ZmxLa3pFdWVlL0M0T2hhdWlCc0FsYkpJajVxaS8rNnpwcFFS?=
 =?utf-8?B?SjFjWjV2N1RrMC8zcytidTZlMTEzRWhHc2JYWENsSzAwZmVzbkJ2c0M1ZDJ2?=
 =?utf-8?B?UEhWQjg3R3FoYmJmcFpMRmZCYVZwU2VLcWEvcXpaOW1lUWFlTi82SHA0NENX?=
 =?utf-8?B?WVNleVBoRnlZVk9HYUZmaXZNMWJlNHcxS2tLTHRPUWo0WW1mNWVGMEo5ZW5s?=
 =?utf-8?B?WjdpUXRhSnNDL0dPQXltKzJ3OFlqWDVaZDBlV1c2S0h0Z3pGZm1BOXdXSGUx?=
 =?utf-8?B?RTl1Ti9vSXBKb2FqNUIveXNLZHBDL0ZYQkNWL21URU1Nam1tMnpJUnJrbkRz?=
 =?utf-8?B?UDdadXQ0alByWm9IRHlTUEFXZy96b3I2ZE5HMTM1UTZQVzh4ekc0cGptR0N4?=
 =?utf-8?Q?N9/q8hILJyGsXbUEQ3?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2f03cc3-b7d6-495d-a997-08da2eb8e1ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2022 17:01:22.0836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TbKhTTD6pkceILP8BumpfqR4eaL2I49C0LljtQt8hT4zMDwZNkmkboBsGwHiQJcQwox5FDPOu1mlRASyaehVIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1497
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBMaW51cyBXYWxsZWlqIDxsaW51
cy53YWxsZWlqQGxpbmFyby5vcmc+IA0KU2VudDogVGh1cnNkYXksIE1heSA1LCAyMDIyIDExOjEy
IEFNDQpUbzogQXNtYWEgTW5lYmhpIDxhc21hYUBudmlkaWEuY29tPg0KQ2M6IGFuZHkuc2hldmNo
ZW5rb0BnbWFpbC5jb207IGJnb2xhc3pld3NraUBiYXlsaWJyZS5jb207IGxpbnV4LWdwaW9Admdl
ci5rZXJuZWwub3JnOyBsaW51eC1hY3BpQHZnZXIua2VybmVsLm9yZw0KU3ViamVjdDogUmU6IFtQ
QVRDSCB2MSAxLzFdIEFkZCBkcml2ZXIgZm9yIE1lbGxhbm94IEJsdWVGaWVsZC0zIEdQSU8gY29u
dHJvbGxlcg0KSW1wb3J0YW5jZTogSGlnaA0KDQo+IENvdWxkIHlvdSBwbGVhc2UgaGF2ZSBhIGxv
b2sgYXQgdGhpcyBwYXRjaD8NCg0KU3VyZSENCg0KPiArc3RhdGljIHZvaWQgbWx4YmYzX2dwaW9f
c2V0KHN0cnVjdCBncGlvX2NoaXAgKmNoaXAsIHVuc2lnbmVkIGludCANCj4gK29mZnNldCwgaW50
IHZhbCkgew0KDQpQdXQgb3BlbmluZyBicmFja2V0IG9uIG5ldyBsaW5lLg0KUnVuIHlvdXIgY29k
ZSB0aHJvdWdoIHNjcmlwdHMvY2hlY2twYXRjaC5wbCBiZWZvcmUgc3VibWl0dGluZy4NCg0KSXQg
aXMgb2RkIHRoYXQgaXQgZ290IHNlbnQgdGhpcyB3YXkgaW4gdGhlIGVtYWlsLiBJbiBteSBwYXRj
aCBhbmQgbXkgbG9jYWwgZmlsZSwgdGhlIGJyYWNrZXQgaXMgYWxpZ25lZCBjb3JyZWN0bHkgYXMg
Zm9sbG93czoNCiArc3RhdGljIHZvaWQgbWx4YmYzX2dwaW9fc2V0KHN0cnVjdCBncGlvX2NoaXAg
KmNoaXAsIHVuc2lnbmVkIGludCBvZmZzZXQsIGludCB2YWwpDQogK3sNCg0KSSBkaWQgcnVuIGNo
ZWNrcGF0Y2gucGwgYmVmb3JlIHNlbmRpbmcgdGhpcy4gSSB3aWxsIHJlc2VuZCB0aGUgZW1haWwg
LCBob3BlZnVsbHkgaXQgd2lsbCBiZSBzZW50IHByb3Blcmx5IHRoaXMgdGltZS4NCg0KPiArICAg
ICAgIHN0cnVjdCBtbHhiZjNfZ3Bpb19jb250ZXh0ICpncyA9IGdwaW9jaGlwX2dldF9kYXRhKGNo
aXApOw0KPiArDQo+ICsgICAgICAgLyogU29mdHdhcmUgY2FuIG9ubHkgY29udHJvbCBHUElPIHBp
bnMgZGVmaW5lZCBieSBjdHJsX2dwaW9fbWFzayAqLw0KPiArICAgICAgIGlmICghKEJJVChvZmZz
ZXQpICYgZ3MtPmN0cmxfZ3Bpb19tYXNrKSkNCj4gKyAgICAgICAgICAgICAgIHJldHVybjsNCj4g
Kw0KPiArICAgICAgIGlmICh2YWwpDQo+ICsgICAgICAgICAgICAgICB3cml0ZWwoQklUKG9mZnNl
dCksIGdzLT5ncGlvX2lvICsgWVVfR1BJT19GV19EQVRBX09VVF9TRVQpOw0KPiArICAgICAgIGVs
c2UNCj4gKyAgICAgICAgICAgICAgIHdyaXRlbChCSVQob2Zmc2V0KSwgZ3MtPmdwaW9faW8gKyAN
Cj4gKyBZVV9HUElPX0ZXX0RBVEFfT1VUX0NMRUFSKTsNCj4gKw0KPiArICAgICAgIC8qIE1ha2Ug
c3VyZSBhbGwgcHJldmlvdXMgd3JpdGVzIGFyZSBkb25lIGJlZm9yZSBjaGFuZ2luZyBZVV9HUElP
X0ZXX0NPTlRST0xfU0VUICovDQo+ICsgICAgICAgd21iKCk7DQo+ICsNCj4gKyAgICAgICAvKiBU
aGlzIG5lZWRzIHRvIGJlIGRvbmUgbGFzdCB0byBhdm9pZCBnbGl0Y2hlcyAqLw0KPiArICAgICAg
IHdyaXRlbChCSVQob2Zmc2V0KSwgZ3MtPmdwaW9faW8gKyBZVV9HUElPX0ZXX0NPTlRST0xfU0VU
KTsgfQ0KDQpCcmFja2V0IG9uIG5ldyBsaW5lLiBUaGlzIGNvZGluZyBzdHlsZSBpcyB2ZXJ5IG9k
ZC4NCg0KU2FtZSBjb21tZW50IGFzIGFib3ZlLiBOb3Qgc3VyZSB3aHkgdGhlIGVtYWlsIHByaW50
cyBpdCB0aGlzIHdheS4NCg0KVGhlIGhhcmR3YXJlIGlzIGEgYml0IG9kZCB0b28gYnV0IEkgc2Vl
IHdoeSB5b3UgY2FuJ3QgdXNlIEdQSU9fR0VORVJJQyBwcm9wZXJseSB3aXRoIHRoaXMgRldfQ09O
VFJPTF9TRVQgYnVzaW5lc3MgOi8NCg0KPiArc3RhdGljIGludCBtbHhiZjNfZ3Bpb19kaXJlY3Rp
b25faW5wdXQoc3RydWN0IGdwaW9fY2hpcCAqY2hpcCwNCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgdW5zaWduZWQgaW50IG9mZnNldCkgew0KPiArICAgICAgIHN0cnVj
dCBtbHhiZjNfZ3Bpb19jb250ZXh0ICpncyA9IGdwaW9jaGlwX2dldF9kYXRhKGNoaXApOw0KPiAr
ICAgICAgIHVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ICsNCj4gKyAgICAgICBzcGluX2xvY2tfaXJx
c2F2ZSgmZ3MtPmdjLmJncGlvX2xvY2ssIGZsYWdzKTsNCj4gKw0KPiArICAgICAgIHdyaXRlbChC
SVQob2Zmc2V0KSwgZ3MtPmdwaW9faW8gKyBZVV9HUElPX0ZXX09VVFBVVF9FTkFCTEVfQ0xFQVIp
Ow0KPiArICAgICAgIHdyaXRlbChCSVQob2Zmc2V0KSwgZ3MtPmdwaW9faW8gKyBZVV9HUElPX0ZX
X0NPTlRST0xfQ0xFQVIpOw0KPiArDQo+ICsgICAgICAgc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgm
Z3MtPmdjLmJncGlvX2xvY2ssIGZsYWdzKTsNCj4gKw0KPiArICAgICAgIHJldHVybiAwOw0KPiAr
fQ0KPiArDQo+ICtzdGF0aWMgaW50IG1seGJmM19ncGlvX2RpcmVjdGlvbl9vdXRwdXQoc3RydWN0
IGdwaW9fY2hpcCAqY2hpcCwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHVuc2lnbmVkIGludCBvZmZzZXQsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBpbnQgdmFsdWUpIHsNCj4gKyAgICAgICBzdHJ1Y3QgbWx4YmYzX2dwaW9fY29u
dGV4dCAqZ3MgPSBncGlvY2hpcF9nZXRfZGF0YShjaGlwKTsNCj4gKyAgICAgICB1bnNpZ25lZCBs
b25nIGZsYWdzOw0KPiArDQo+ICsgICAgICAgc3Bpbl9sb2NrX2lycXNhdmUoJmdzLT5nYy5iZ3Bp
b19sb2NrLCBmbGFncyk7DQo+ICsNCj4gKyAgICAgICB3cml0ZWwoQklUKG9mZnNldCksIGdzLT5n
cGlvX2lvICsgDQo+ICsgWVVfR1BJT19GV19PVVRQVVRfRU5BQkxFX1NFVCk7DQo+ICsNCj4gKyAg
ICAgICBzcGluX3VubG9ja19pcnFyZXN0b3JlKCZncy0+Z2MuYmdwaW9fbG9jaywgZmxhZ3MpOw0K
PiArDQo+ICsgICAgICAgcmV0dXJuIDA7DQo+ICt9DQoNCldoeSBpc24ndCBGV19DT05UUk9MX0NM
RUFSL1NFVCB1c2VkIHdoZW4gbWFraW5nICBhIGxpbmUgaW50byBhbiBvdXRwdXQ/IFNlZW1zIHVu
c3ltbWV0cmljPyBBdCBsZWFzdCBwdXQgYSBjb21tZW50IGluIHRoZSBjb2RlIHdoeSB0aGlzIGlz
IGRpZmZlcmVudCBmcm9tIG1ha2luZyBhIGxpbmUgaW50byBpbnB1dC4NCg0KT2sgSSB3aWxsIGFk
ZCBhIGNvbW1lbnQuDQoNCkFsbCBHUElPcyBhcmUgYWx3YXlzIGNvbnRyb2xsZWQgYnkgSFcgYnkg
ZGVmYXVsdC4NCkZXX0NPTlRST0xfU0VUIGlzIHVzZWQgd2hlbiB3ZSB3YW50IHRvIHJlbGVhc2Ug
Y29udHJvbCBvZiB0aGUgR1BJTyBieSBIVyBhbmQgZ2l2ZSB0aGUgY29udHJvbCB0byBzb2Z0d2Fy
ZSBpbnN0ZWFkLiBXZSB3YW50IHRvIGdpdmUgY29udHJvbCB0byBzb2Z0d2FyZSBvbmx5IGFmdGVy
IGNoYW5naW5nIHRoZSB2YWx1ZSBvZiBhIEdQSU8gcGluIHRvIGF2b2lkIGFueSBnbGl0Y2hlcyBp
biB0aGUgSFcsIHNvIHRoaXMgaXMgdGhlIG9ubHkgY2FzZSB3aGVyZSBZVV9HUElPX0ZXX0NPTlRS
T0xfU0VUIGlzIHNldC4gVGhpcyBpcyB3aHkgd2UgZG9u4oCZdCBkbyBpdCBpbiBtbHhiZjNfZ3Bp
b19kaXJlY3Rpb25fb3V0cHV0LiBBbnl3YXlzLCB0aGUgdXNlciBjYW5ub3Qgc2V0IGEgZ3BpbyBw
aW4gdG8gYSBjZXJ0YWluIHZhbHVlIGZyb20gbGludXgsIGlmIHRoZXkgaGF2ZW4ndCBjaGFuZ2Vk
IHRoZSBkaXJlY3Rpb24gb2YgdGhlIGdwaW8gdG8gb3V0IGluIHRoZSBmaXJzdCBwbGFjZS4gDQpJ
dCBpcyBhIGJpdCBhbiBvZGQgaW1wbGVtZW50YXRpb24gYnV0IGJhc2ljYWxseSBldmVuIGlmIHdl
IHNldCB0aGlzIGJpdCBpbiBtbHhiZjNfZ3Bpb19kaXJlY3Rpb25fb3V0cHV0Og0Kd3JpdGVsKEJJ
VChvZmZzZXQpLCBncy0+Z3Bpb19pbyArIFlVX0dQSU9fRldfT1VUUFVUX0VOQUJMRV9TRVQpOw0K
SXQgZG9lc27igJl0IGFjdHVhbGx5IHRha2UgZWZmZWN0IHVudGlsIHdlIGFsc28gc2V0IHRoZSBj
b3JyZXNwb25kaW5nIGJpdCBpbiBZVV9HUElPX0ZXX0NPTlRST0xfU0VULiBCdXQgaXQgd2FzIGFk
dmlzZWQgYnkgb3VyIEhXIHRlYW0gdG8gc2V0IFlVX0dQSU9fRldfQ09OVFJPTF9TRVQgb25seSBh
ZnRlciBzZXR0aW5nIHRoZSBkZXNpcmVkIEdQSU8gdmFsdWUgdG8gYXZvaWQgSFcgZ2xpdGNoZXMu
DQogDQoNCj4gKyAgICAgICAvKiBUbyBzZXQgdGhlIGRpcmVjdGlvbiB0byBpbnB1dCwganVzdCBn
aXZlIGNvbnRyb2wgdG8gSFcgYnkgc2V0dGluZw0KPiArICAgICAgICAqIFlVX0dQSU9fRldfQ09O
VFJPTF9DTEVBUi4NCj4gKyAgICAgICAgKiBJZiB0aGUgR1BJTyBpcyBjb250cm9sbGVkIGJ5IEhX
LCByZWFkIGl0cyB2YWx1ZSB2aWEgcmVhZF9kYXRhX2luIHJlZ2lzdGVyLg0KPiArICAgICAgICAq
DQo+ICsgICAgICAgICogV2hlbiB0aGUgZGlyZWN0aW9uID0gb3V0cHV0LCB0aGUgR1BJTyBpcyBj
b250cm9sbGVkIGJ5IFNXIGFuZA0KPiArICAgICAgICAqIGRhdGFpbj1kYXRhb3V0LiBJZiBzb2Z0
d2FyZSBtb2RpZmllcyB0aGUgdmFsdWUgb2YgdGhlIEdQSU8gcGluLA0KPiArICAgICAgICAqIHRo
ZSB2YWx1ZSBjYW4gYmUgcmVhZCBmcm9tIHJlYWRfZGF0YV9pbiB3aXRob3V0IGNoYW5naW5nIHRo
ZSBkaXJlY3Rpb24uDQo+ICsgICAgICAgICovDQo+ICsgICAgICAgcmV0ID0gYmdwaW9faW5pdChn
YywgZGV2LCA0LA0KPiArICAgICAgICAgICAgICAgICAgICAgICBncy0+Z3Bpb19pbyArIFlVX0dQ
SU9fUkVBRF9EQVRBX0lOLA0KPiArICAgICAgICAgICAgICAgICAgICAgICBOVUxMLA0KPiArICAg
ICAgICAgICAgICAgICAgICAgICBOVUxMLA0KPiArICAgICAgICAgICAgICAgICAgICAgICBOVUxM
LA0KPiArICAgICAgICAgICAgICAgICAgICAgICBOVUxMLA0KPiArICAgICAgICAgICAgICAgICAg
ICAgICAwKTsNCg0KSG0uIElzIGl0IHN0aWxsIHdvcnRoIGl0Pw0KDQpNVkgNCkxpbnVzIFdhbGxl
aWoNCg==
