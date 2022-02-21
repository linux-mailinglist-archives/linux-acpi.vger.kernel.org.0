Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E844BEBA3
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Feb 2022 21:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbiBUUOy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 21 Feb 2022 15:14:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiBUUOx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Feb 2022 15:14:53 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46D11275F
        for <linux-acpi@vger.kernel.org>; Mon, 21 Feb 2022 12:14:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCeBk093nczp5yd1y9h3BVv6SnnafziPl2K5qyRmvouiPJGDauYcV7gMIER35ImLn4G09fa9Q7vtXJ9xi4F7IMZFHMCh81LCHq4S4dMlSSjCFyEeWfjJsX8SFSJYpCqNaHp525wuXlil5IAJqP3JQbgImjLlJaMvpRCZ47aJwtgxjTqmIkChVdDtjRB3oJwh0jN1YE5QmOt9BkWw46Ouq9zDZCpN7M8oJIfeUo3duRpOgqgRIsVutH1mcPKsch1BTAwta3OfbROAYbk13Tuwg5+yoSN23bKJPcfe+kbzAe8F5TuMAiQX7+bciVXSUJhDC6rHxvBz7f4DYgPmcq6rrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OESkOFJQlNwmFy2KfSCfxzJiu6I1kCMngk0bmK6RTYQ=;
 b=DJ+iI09pGDiSH73sgH8JYcfb/73oBRPtfbtX/VDW7rj9kK3+tWr+I53bwi9XslScWG4Xz8mIi4Yj//FvjM4B9eJsibZFjGFspuaW0CP/sDuD0jaAYqjYykMW8tyy5KaGmZ+oUL2hidBF09nhPPGP7NTmE/ZrZmCfwnLvaKyd1ED9v8/OO9Y1TpgckT4fn62442rl3PoDXmamo9Ot/ypyEzz83TNZBZ3L4a+p9wEHk+Vu9aSntMTUVIzMYEwC3vGw1XJS44HYe5keGS0iolHA89OhVvLbaayxyspRMMSNFrYypWnK4KyaKdjqCp7kctUXdb/uMEa1uHJ3OY+v7fmhDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OESkOFJQlNwmFy2KfSCfxzJiu6I1kCMngk0bmK6RTYQ=;
 b=fKexs1v+OEYpOCqT5lSHnwnqf8VHFYkSFPcdT5fh2djHdli/cFzEpuXMlqxVGPMPe5pDrh+68lLpzf7piXKD7Y4Cb5evFPDWjkuOZiCxw6H6k4cYztwiLIJm1WM0DylXPzPg/iawKXZXL7Wf45m4ksjzu4MVMqTHBby377t1i1k=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by SN1PR12MB2591.namprd12.prod.outlook.com (2603:10b6:802:30::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Mon, 21 Feb
 2022 20:14:21 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%4]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 20:14:21 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: Regression in 5.16-rc1 with suspend to idle
Thread-Topic: Regression in 5.16-rc1 with suspend to idle
Thread-Index: AdgjxKRqoif+H8GDSFuptXvIhGhWMAAJ0i2AAAqAH3AAMzUMAAAESZ8AABIh2uAAgBs6AAAFURlwAAC7lYAAABZLAA==
Date:   Mon, 21 Feb 2022 20:14:21 +0000
Message-ID: <BL1PR12MB515755CA3C1649F83ED3DF9BE23A9@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <BL1PR12MB5157C5EA5510F0C9D7782AE8E2369@BL1PR12MB5157.namprd12.prod.outlook.com>
 <CAJZ5v0g81BmytcjgChXZumsHV5-byzSzDQbp2hc6CYzJ_6N=aw@mail.gmail.com>
 <BL1PR12MB5157E2CDD68BA585C5F4CF2BE2369@BL1PR12MB5157.namprd12.prod.outlook.com>
 <CAJZ5v0ho8PHGp0gAUp5KkUstTXLyUMsaQ7wTL=8xDJtjtXjPRw@mail.gmail.com>
 <CAJZ5v0j3Ma1HuUWoTmJvZDsUtm9hi84njJxJbBZMwe76eATSYQ@mail.gmail.com>
 <BL1PR12MB5157589AB3D9BC55C6D77EB4E2389@BL1PR12MB5157.namprd12.prod.outlook.com>
 <CAJZ5v0jmQaeSKj7wB1Jx+cxDHVxtHzbnTKZ4TcxnydHa5NOn+A@mail.gmail.com>
 <BL1PR12MB51570F5BD05980A0DCA1F3F4E23A9@BL1PR12MB5157.namprd12.prod.outlook.com>
 <CAJZ5v0iNoeUv0XjHWyazu5X8Y5=WXKabKtxB+bwHONgKab8fEA@mail.gmail.com>
In-Reply-To: <CAJZ5v0iNoeUv0XjHWyazu5X8Y5=WXKabKtxB+bwHONgKab8fEA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-21T20:14:19Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=ec9f059b-f054-44e4-945f-557f94df1fe8;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-02-21T20:14:19Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: f2babee8-1684-49d1-9c4c-9a101f0213f4
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5e6ab02-a726-4f66-d51e-08d9f576bf5c
x-ms-traffictypediagnostic: SN1PR12MB2591:EE_
x-microsoft-antispam-prvs: <SN1PR12MB25915834C196D3DBF8DF7E62E23A9@SN1PR12MB2591.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O2lK7CCaiCDzzdP+zF1htCAiCBrp/kPHfZmqPx0V41ENFWiIPCkNKUGQ6Tzu1tLT6OJ0js8IgEcN1CJzSAjf6yb+3wAxILahfibV3GXkThjl3C4HiCcNNmYzbaKukfwd0NQs4sa7v20d/niTd0j2i7IJYreYANIeHZIBcZ2wXdr7V88jm+w6UymGCwQGFl3QqmkXb8Nk1Lbz6iC5Bvx3y+gYHfweGh4QP3yoXwHrEmHO1gjRD+8mssKKpNMRvTHVgm7ENt8yDiqkEfhXxF0ZorgFHEGO/4hGsw/jisDZvJKuEXlZcN2y51PUAOwptkita+7Q6meODJIa9kFFpk0C3njn/hb4rkpN49NV2dRzxk64LjJ+O2c3YnNQ3wOUIce1NNRsJp7aPOhfcUPaCp3LIj9SPGdLKmOwErTxRzNvRPJn218CxGMuOpq5Msm5wdvw0uhzOMSkNv7gjcoRFxoAHuQR4w3dS4r70Y2CpDi0xik8YGBGw4Y+c80Uga8edrWQHf4VhfHywv/SEnUtUdOGS8NtpIi08uO4RHMZOrFajVilQ/i/AOcRTmF1s8eU7Z3pX/w/wC/GMI9nq52VDyc82hrY1NH6MezqtrgHcBtbzX5XdBj+kjbdFc4tJ2OrJzgTY4IwUebyFUG6MXN0QM6d3Pc3R76Tco0EHiJmP9VcM/7caVWYoZ8RO/bHshXf4kqQ72ruT3lpzaYQPaMtUkTFZjD88v36vCKgXPfJMUocfEd7rva8epBa8GNyp2dZBVQXRmMKOMx4lj4NdwltAWgPFriGRBbNormSxg8PuBGXQDc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(9686003)(66946007)(76116006)(5660300002)(4326008)(66556008)(66476007)(66446008)(64756008)(6506007)(508600001)(7696005)(6916009)(966005)(316002)(83380400001)(71200400001)(33656002)(26005)(186003)(52536014)(8676002)(4744005)(8936002)(38100700002)(55016003)(2906002)(122000001)(54906003)(86362001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTZsb1lrYVcxSDhjQWxNV28rYS9TK0VRNTU4eFpPV2tFVS9BV3pOdWE2bjdt?=
 =?utf-8?B?QXdZbUc2aCtYeDFvUXFSbjBtVE84RDMvOVBkeTBqa29Od21JNWZ4eStUSEVF?=
 =?utf-8?B?VUxIV211NCtzeHZlNHdGdnRZTWFicytsMWxIRTFSaFNnQU13RlFpc0JNejFC?=
 =?utf-8?B?UUNkbXJPOWpOQ3ppaDVWTkt3QkYyeE5hQkNuaFFJRC9acUFqZ3JpTEUydDRh?=
 =?utf-8?B?Tm5UbVR2R3F0ejhPV245UER4ZFovL0NYOTVjUVVUNmZ6K3JwaEJBTHR5cXcr?=
 =?utf-8?B?NERiN0RTcERZdkpIRTZnNUhvOUxGWWZCWXE2V1plZnN1SzRTYWFMNGxNd3U5?=
 =?utf-8?B?SG5qa1pJd1I5WGJJL1Rkbm1PbCtmc2sxL1ExRThjYUVPSlFuMlVLUUFXSGwz?=
 =?utf-8?B?RzZ4RXJFZ2tZeDNBTHVqNjRhZEhrTXY4MGNYSHU3SlRMeW9hVHd3UGtMc2FG?=
 =?utf-8?B?bUVYZ2VmRXhyYXlSWHozY2lwd292N3E4d1FEVjlaZXlWRUJuZ1NLQnpiTUVz?=
 =?utf-8?B?NnRXYTFaRnViNytpUXhZMlFlNXluN21veWFKQzUvUHNFZUF5WTJBa3M0bFJ0?=
 =?utf-8?B?U0xPb2F2NEczZ01oampYbk5PQ3Nka0pWcDRIL0hKTXFWK3MwanptOTgyZlJB?=
 =?utf-8?B?TFdxQ3B1U3pVWHJFS1I3dUVEaHVsZktCL3V0cDFWWjV0bXJ2eFgyZWpyQ200?=
 =?utf-8?B?RWYxNWpVQXBJVXhmai9WcnZYVGJWa1BSTG1KM0pMRUQwdHdhaCttemxuM3Bm?=
 =?utf-8?B?UXRFb0tjcXBtVE9EUUlia1k1Z0d4K1NpbExvWUQrUm1QTUFUc2pjYTNqcWwv?=
 =?utf-8?B?dFN0RnN1bkJUNldtY2xrVHJIcGVubjhnVStLbXl6OFlGMCtVcXA4ZDc4ZTVF?=
 =?utf-8?B?eVdIZXY3QlpBWUl2ajNicDUyZVBoUEZvN2t1czRtYjg0dWV3UEdDZ3FoVmxh?=
 =?utf-8?B?R1hTNFJJZGFlV0JjRGsyNlhERS81OXUyaFF3RStHMjlZWENMN0ZjQzlmREVD?=
 =?utf-8?B?M0VrMTdrS3ZMVC81N05qSTVBeHkzM2N3VklDSUwwUnhxUnlRSXNZcGdiNkJC?=
 =?utf-8?B?Tk82dnNvVExvaFFiUG1mZDQ1cjJRSnhzOFJGU2w1ZDh2OW9ZWWRxNm9PVUtM?=
 =?utf-8?B?MVAxeWFxZnh1dkdibWdueXgvKy9TSHJZUzBFR25jVXBlOFNzU25hZmgxODly?=
 =?utf-8?B?eDlMZlZwbkFrWVZvOVExODR0b2IxVDFwOGloNFQrV3Y3NWNKVXA5TnBGR3k0?=
 =?utf-8?B?UmVWNFJ5V01VTjZjNGdOeEJyNFV5MlAyazRJaWgxUGZGYmEyeHhQUjVyK1hT?=
 =?utf-8?B?ZEtwb3BGelFpLytWcktrZVB5d1ErV1lUVGE3MHhyYkdnZjV5K3FHQW1UQ3Mv?=
 =?utf-8?B?aEVmSnNPd2RIUGgzN24wOXNVWnZ4bTdJSnNlNkVmNjFDUU1kQUVSdkpJQTBG?=
 =?utf-8?B?Y2VLZ2svUFd2dDRYcndPMW5oeU9TSW96Um45ek1qekZFbUhnR2kvK0ZEcmo5?=
 =?utf-8?B?ODE4TnNWM1dCY0dVUVFDZ0pITkZDY08yaUcwQ01NT2x3SUhBZUVYejVQNm5H?=
 =?utf-8?B?M3VCbDJ0OVF5VDhmSWJ6RVhIYTc1R2JEcHRlcnMvOVZaLzUyblVMdHhFTlJW?=
 =?utf-8?B?MlFVajlRalRKcklsU0dwUHFtb0RxcEJFYzgrY2I3eFZGUVVjSmZZNklyc0Zv?=
 =?utf-8?B?ZjJSK3k5SjFoTUl2SXNDSWMrMmlRT0VicWM2QjI5by8vNTR1Z1preUJ0czdZ?=
 =?utf-8?B?SEVwQW13UTlsNUQxcE9uaXZseXlMZWlJVFhVOFl0QUF4a1liQjM0emRob2Y0?=
 =?utf-8?B?Tk91OG5sOXVUZXhGL29uRzh6T3hnT0hmVGFlRlhoUzc1SzRvSit1bWZWM1pw?=
 =?utf-8?B?N3dkbFBpWlJwZ1piWnJkQmpoMUQyUUxsY1ZCdUVKRlROazlyNHJzeUxkN2dC?=
 =?utf-8?B?TzJ0YXEwWTdqMVFRUEkyeVpWZGprQ3ZvV0FJeDR6WXplRzgvUGw5U1NvYTZl?=
 =?utf-8?B?ZVNMd3RzbFV3YmFnYmI3a2ZHWThDWXlQSFRNRUxlYTZzSDRrSTRZb3dtbTNz?=
 =?utf-8?B?MHZGUTFBQ21XaW5HSmRMUnNCMUVJU0JpbVJJZk9CWmFPck5oU3dPVkRrWHpm?=
 =?utf-8?B?dS9PeTFOaGdOdWlHMm1RVWdnOEpSQmhQWnNod2xSM05pNEtnOVdWakdNN2Y0?=
 =?utf-8?Q?4ENoFzo0rtQzDlltUT3l4Yg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5e6ab02-a726-4f66-d51e-08d9f576bf5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2022 20:14:21.3083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kgFKQ6MXQTDaa7oxo4EjEviyOGPSrQicK0ffpWbodQwATVhRlFBYw7ml0zzbpaLqWDWkDqLoLvg/fTM5LXBjCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2591
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KPiANCj4gT0sNCg0KaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvcGxhdGZvcm0tZHJpdmVyLXg4Ni8yMDIyMDIyMTIwMDcyOC4yMzIzNDY5LTEtbWFyaW8u
bGltb25jaWVsbG9AYW1kLmNvbS9ULyN1DQoNCj4gDQo+ID4gTG9uZyB0ZXJtIC0gYXJlIHlvdSBv
cHBvc2VkIHRvIGRyaXZlcnMvYWNwaS94ODYvczJpZGxlLmMgbW92aW5nIHRvDQo+IGRyaXZlcnMv
cGxhdGZvcm0veDg2Lz8NCj4gDQo+IEl0IGlzIHRpZWQgdG8gdGhlIGNvZGUgaW4gc2xlZXAuYywg
c28gSSdkIHJhdGhlciBub3QgbW92ZSBpdC4NCg0KT0sgaWYgd2UncmUga2VlcGluZyBpdCB0aGVy
ZSwgd291bGQgeW91IGJlIG9wZW4gdG8gYSBwYXRjaCBleHBvcnRpbmcgYSBzeW1ib2wgdG8NCmxl
dCBvdGhlciBkcml2ZXJzIHJlZ2lzdGVyIGFub3RoZXIgY2FsbGJhY2sgYWZ0ZXIgTFBTMD8gIEl0
J3Mgc29tZXdoYXQgc2ltaWxhciB0byB3aGF0IG15DQp0ZXN0IGhhY2sgZGlkIGFuZCBtaWdodCBi
ZSBhIGJldHRlciBsb25nIHRlcm0gc29sdXRpb24gaWYgc28uDQoNCj4gDQo+ID4gSSdkIHJlYWxs
eSBsaWtlIHRoZSBzdHVmZiBhbWQtcG1jIGRvZXMgdG8gYmUgYSBjYWxsYmFjayBhZnRlciBscHMw
ICh3aGljaCBpcyBjbG9zZXINCj4gdG8gaG93IGl0IHdvcmtzDQo+ID4gb24gV2luZG93cyAtIGl0
J3MgdGhlIHZlcnkgbGFzdCB0aGluZykuDQo+IA0KPiBJIHNlZS4NCj4gDQo+IEEgbm90aWZpZXIt
YmFzZWQgZHJpdmVyIGludGVyZmFjZSB0byBiZSBpbnZva2VkIGZyb20gczJpZGxlLmMgc2hvdWxk
DQo+IHdvcmsgZm9yIHRoYXQuDQo+IA0KPiA+IEkgZmVlbCBsaWtlIGtlZXBpbmcgdGhlIHN0dWZm
IGl0IGRvZXMgYXMgbm9pcnEgaXMgZ2VuZXJhbGx5IGZyYWdpbGUsIGFuZCBJIHdhbnQgdG8NCj4g
YXZvaWQgdGhpcyBraW5kDQo+ID4gb2YgYnJlYWthZ2UuDQo+IA0KPiBTdXJlLg0K
