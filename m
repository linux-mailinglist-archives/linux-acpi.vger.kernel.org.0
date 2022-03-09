Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555A34D307C
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Mar 2022 14:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbiCINtq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Mar 2022 08:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbiCINtp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Mar 2022 08:49:45 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2088.outbound.protection.outlook.com [40.107.100.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E51A149B93
        for <linux-acpi@vger.kernel.org>; Wed,  9 Mar 2022 05:48:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DduvFzDKtbvwFXCbiTPCnZ1K2H0fgi9A1TU7Q1NQ7ON7dc1C/qjxRIXovOqrrampezZ8zam1tCDjuvKRcQsmd/+Mh4dIBFaaaget8qVBYwtHfOn+qEeL713NVgOJ9OPSDrNEyAWWnK8+VHLesKHee8wpglRL85MbozTgg2JTSOf2PyQaOtjhyK3vYqLywSphy1MslF16pFDe/CVSi1A3DwiVHTSu2e47aW3/GdOBINefQLr9ErhmfcHEU26xYt/XTRqOAnYw2Wz0weGpKeDqj43xhceDePLuW93eoqp9/Rer3kEK49wuX+rEOhWzID9I1QdZFPR7E5Ut85gHQ5L/Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IArbAfxhqhTjVicKzbi8L5rNt0eN9G+f8VWvSqz2qwI=;
 b=NJrtyoynDz/khBSSY0b+YxQhUxQljo4XyEWBNv7irkvKMmfu0MC73+dFr6KVlH1t5v1svJZ8HsUsOYsshe2W6gAKSDtRvLxhfkv34EMeBQvTpzh7bGYC5tx3CMKR+nzV4WxalI0v1o+ZDPl5E0W1LNeKVl/sPwLAWL/nf63kAiMgTrX72q7v/XWG6UJy/Mv+9nOFdwOyCGfk78+gaXx069apIauPHvgklhXhe2Jihxios7s0cqQd7nd14O9O74VynrrvXHua66daCOD7DgNB9xH8CUJ6eKjQC6bXvwlfclaGvQWAuq4zvohihNyHPgxc4uWcFfQD7J/JjywEjw9wnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IArbAfxhqhTjVicKzbi8L5rNt0eN9G+f8VWvSqz2qwI=;
 b=v1bcyUUt3petWMSwoFV1bWYYCnFsW2otXW+2xJzn/yClsdjOyUunCkSV4NZc01mHQwvTJD87hcCfV8iUA4djN3q/xfPh+o+EhGxvSv5RQG5vq/yLkXJ4nE3RnqOpcvJ2Q/3NCKv/kAg0C6VzYKYKrMjWzUQldQP85dwiCoIOuBA=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by DM4PR12MB5263.namprd12.prod.outlook.com (2603:10b6:5:39b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Wed, 9 Mar
 2022 13:48:44 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%5]) with mapi id 15.20.5038.029; Wed, 9 Mar 2022
 13:48:44 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Qian Cai <quic_qiancai@quicinc.com>
Subject: RE: [PATCH] PCI/ACPI: Add support for `AE_SUPPORT` in _OSC queries
Thread-Topic: [PATCH] PCI/ACPI: Add support for `AE_SUPPORT` in _OSC queries
Thread-Index: AQHYMz4dV+TeLnmW50K8sfbt3FV7say3DayAgAABRrA=
Date:   Wed, 9 Mar 2022 13:48:44 +0000
Message-ID: <BL1PR12MB515736C2283780FA1215554EE20A9@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220308224200.2691564-1-mario.limonciello@amd.com>
 <CAJZ5v0ixsSuH_d+CCiU_Mn7HaCf6mLekOadte9j33NKg4aH20w@mail.gmail.com>
In-Reply-To: <CAJZ5v0ixsSuH_d+CCiU_Mn7HaCf6mLekOadte9j33NKg4aH20w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-09T13:48:42Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=d0d9ba08-32ef-4917-b07b-d6060c5a75b0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-03-09T13:48:42Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 481849ca-5024-4493-8d63-0683a2f87f9e
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 89551790-7d37-4381-7217-08da01d38717
x-ms-traffictypediagnostic: DM4PR12MB5263:EE_
x-microsoft-antispam-prvs: <DM4PR12MB52639E6E24109FB004982BF9E20A9@DM4PR12MB5263.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kiAo2kvOn/rd/xZ+Rc78nsKUY77XYmBWqN7bd7SMBIN1A0nFf3nOKBht1rInsySJs8+sDkvZQV7+UocW/jyPMnf32dP0HlwIqW55XPs9DbEP+n2PCa22zwD/ad7C5JiRH7e//1BaTCjsGZVZIjR5zu7g7ymLcp+9RkWKfAJmQM1my/ByKaDfbNJJO6t6MzyurEaguq2zFJ8hs7wSEH1En+hhkLj28thYGrMJmSAxwOPRKlmeJEk/Y//ts5s0JQHP1A7pMR259f7vodAAW5ckRjxxe5yW1klE46jKZLkTV7jV7WiRRpPSvCFZg7zIg6TjqnW/cAtd5o32dnwEuTP/j6HIvHiL2plg2HDnCeODBYSuUZinndXDTApDD1UP8gJrN/wevAh13O0RTkMsFROfDw50rwnl0IaBR1jmgEuNhvOgjX1Ai657IiOKKWhBxgBCJmGKNotTnkzpuE8zScvKuNibq48Leb2cTZznbF0Y/RTcrz3gc+cWFMm+6YbKNQjDUWrTQ1eKdNqduFK0ubuL5tMW3aPKxSmREGd1W0IkFxtJrJAnBdZaIAremj2JYlt9GyG/sQkWhXoNqKFasvNanwh7pogUZCslMwvL8KOWkXC6ikjc8jIVRdvistrKkeMlhOCwttdFsH/Vb2D8K2m1jfuRbUSZ0a2hUtKRj0EI7z4CzwiLBgJmsewGQhc4NjFvypTXgqI+W1LEqTsQPPW8t5LxxCytA4Ubc1DnrwRW3a4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(4326008)(66946007)(8676002)(66556008)(66476007)(66446008)(64756008)(76116006)(122000001)(52536014)(8936002)(54906003)(6916009)(33656002)(316002)(55016003)(2906002)(186003)(86362001)(5660300002)(6506007)(9686003)(71200400001)(26005)(508600001)(38070700005)(83380400001)(7696005)(81973001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZHR4WndabkdKQnRielFGRXl5M0pkUVllUU9mcmJpYUFQb2ViejR6NnZVdWw1?=
 =?utf-8?B?Z2lVNFZZTWdaeWdpRlFpRWgxTHZpeGZ1SWJMdFR4UE1MdnJYLzFyWDBDTEpa?=
 =?utf-8?B?cnhFMDByMWViR2w3T2pEVnFXd2s5bWw4TVhyU2tyQUhiNWNFVnlmRWFFVllC?=
 =?utf-8?B?WndQeS9yVHhxVTVQR21rNnRlSW13QndHU3NZUHdlL3B1KzlRa3RFMGw4QlUz?=
 =?utf-8?B?a05oR0p5UGJFSWs1MzByYzJGOUZJRzRrcFREczJqa3ZGMXZIYU9CVWtldmlS?=
 =?utf-8?B?bHljUm1JaloxV1piWVhVVGdtL3VXTGZiSVpMUWdYN2x0L0x5ZFZBQUtBY3dq?=
 =?utf-8?B?ZUdxSFRxU245dXJ1ck13bGFJSDY4OHM1MzQvRThGSmFJa2IvaUduWVh6a0xS?=
 =?utf-8?B?UEVWMzFHaU1icVhPRUlpM2tsb2QycUJwb1VLdURmY2JaWUg4KzEzZ291eXRu?=
 =?utf-8?B?bzcxYTRmbjFoQlBRaWh0UmxkaWFsV2Q2UlBXazVZMTFWczZkVmVYdGJSMnp1?=
 =?utf-8?B?QmtmM0FOOGoxUk16ZGlnTjlyVU5tcnM4c1pnSlNrZTN4QWJNSTdSN0dWaGQ3?=
 =?utf-8?B?NWlUVW1DeE9MRzZOQUpnaTl1aUQxQm8vSTQrTGI4U2tmRHdqYnFHem9wNVFR?=
 =?utf-8?B?cEF2UlNiRlIwcS93ZFVVZkRYVFJkc2hpRnhVWk1XQ0U1Zm9KMHJqZzV4R1JM?=
 =?utf-8?B?UklOT2dPeERZb2hqNTlSaFlobzM1dVM5dWNYWDFxNHgydGNIVytnM2tqV0Vj?=
 =?utf-8?B?ZFJjcWI5K3g5NllCU1ZHOEdxUjRNdGVUYXlQeDFxUkt6b3ZBeGw0eENveGFT?=
 =?utf-8?B?R3AxazM0ZGppQmcwUG5leldBWG8xbmFrOXl0WllRbFVhMlZSbCtPdHUyL1Bj?=
 =?utf-8?B?bDlmZ2pORFZuOUMrdWNrLzkxb0pKOGZkSGpETTczQkFFdGp4ZDluVDk2UTFF?=
 =?utf-8?B?YUxFVDB6T1hUcXlDSkNJVlN0RmdJOTVNNmVlNmdXSzFXT0VlTW9VUm9rc1BT?=
 =?utf-8?B?SFdrTERlMGt1SG9DeWlCRjNtWmxSSlBaRC9YQ3NBYnBjQkxMMnhzTy93M05z?=
 =?utf-8?B?eWhtQ3dodXVJV1VwVWM4NFlJenRGNTNEcUNVOVJSbTlQaTI2aTY0SFVvWmxV?=
 =?utf-8?B?M1pQcUEzcVBQVjNRZ243UFFBTDhGaFZ3UkpPa0huUTN3QzJXQ0w2LzlpQzJs?=
 =?utf-8?B?SytEVEwyLy9iS1IxbEd3L21makhpMEhLMjZkYnBSQVZWWXlBaFJkdlZkczBF?=
 =?utf-8?B?MWtFdmFjOGIvc2VINS9RWUNnZ0dVTjBTSlRoa2N6Uk5XSWx3Z0ZOclZaNU1Y?=
 =?utf-8?B?Njh6WG02alRiZFdrdmJCalovU1pkaHAxZ0tJY04rdTJsNEMwcEgrbGdyY0pQ?=
 =?utf-8?B?M3pnLzNxTHlqcDZqcDNBeTJXMlg3MGJjcldSRW5sOUR0SkkzSkVuSnIyR3dY?=
 =?utf-8?B?cTQ2djRzL0duaWhmZE9UQUtVYVNYSmJuSG1kemZ3VERFb1lLQmx1SXN5em1s?=
 =?utf-8?B?SEY3Z1E4NkFDR3AvdGNpTElhWmhkcVJWbVRXd1JySENRUmxCQ25xZk9lbTJj?=
 =?utf-8?B?NmJzUzJyTTFieUMrbW5yYktCNitEN3h5UGNQZ0E0QnlvbUk2dUN4TWN3UHBE?=
 =?utf-8?B?ZUlrN1RhckJxWXZQR2E2YTBvTWNtb2gzdUtQSDJYZFZ6elltYzQrRDBzdmVV?=
 =?utf-8?B?OWY4K2lxc3YrRWQ4K3dmdFhkcy8vd0hUeHo5MCtRK1J3WHgwUU91SUhPK2hN?=
 =?utf-8?B?QXpFcU1uTlZoVWpqL2t2U0N6bCtzMWhJa1czT0JPbEowWVgxQjBCc3FDbG1a?=
 =?utf-8?B?S2xXYjBKTGZVSW5wb1ZmTDlZS1p2NHVvV0hQTlFHN3hFa0tML3JZSUpJbThr?=
 =?utf-8?B?SXFmblRpcnlBQ2NBWEk4Q0xIYjNsNDhsR2FUbUtWOVdkL2MzL0JwbDQ5SFFi?=
 =?utf-8?B?elNSdUdGYXdKV296UFJvQWEwUHlaYVU1QUpsNDVWNHhIaWdSUHpWUXBRQTlB?=
 =?utf-8?B?bkJEWDRKNHc2VjRQWTh3SC9oeWVtdWs4aWY1N3RhTVo4VzhvdDZ1c2JlWkh3?=
 =?utf-8?B?U2JvQzMyVUxVMTBsZEdMdHZwbjRTZFBKN3dFY1l5azdac0dlZHVjdW0xSXhy?=
 =?utf-8?B?V2dvQTlLVEFpLzVuSjFBekYrSUVlNElSVkF1NmdzRjFyRDNwamI4N0c0VDl4?=
 =?utf-8?Q?UhNP1bkSPRDbvhkCtqHD+kY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89551790-7d37-4381-7217-08da01d38717
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2022 13:48:44.2065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XqKjMf9oh8SKy+uossVMht2i183p+qkHpTTPbNsNJCvPCC6QcbR2p3HGMvy53nu6hzlhbyW6Br2J1dOflTkWyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5263
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQo+ID4NCj4gPiBjb21taXQgYTQxMmNhZWE1YTJk
ICgiQUNQSTogYnVzOiBBbGxvdyBuZWdvdGlhdGluZyBfT1NDIGNhcGFiaWxpdGllcyIpDQo+ID4g
YWRkZWQgc3VwcG9ydCBmb3IgYGFjcGlfcnVuX29zY2AgdG8gcmV0dXJuIGBBRV9TVVBQT1JUYCB3
aGVuIG5lZ290aWF0aW5nDQo+ID4gYW4gX09TQy4NCj4gPg0KPiA+IFRoaXMgd2FzIGZpeGVkIGlu
IG90aGVyIGtlcm5lbCBjb25zdW1lcnMsIGJ1dCBgYWNwaV9wY2lfcnVuX29zY2Agd2FzDQo+ID4g
bWlzc2VkLiAgVXBkYXRlIHRoZSBmdW5jdGlvbiB0byBkZXRlY3Qgd2hlbiBjYWxsZWQgd2l0aA0K
PiBgT1NDX1FVRVJZX0VOQUJMRWANCj4gPiBzZXQgYW5kIGF0dGVtcHQgdG8gbmVnb3RpYXRlIHVw
IHRvIDUgdGltZXMuDQo+IA0KPiBUaGlzIGlzIG5vdCBob3cgaXQgaXMgZGVzaWduZWQgdG8gd29y
aywgdGhvdWdoLg0KPiANCj4gYWNwaV9wY2lfcXVlcnlfb3NjKCkgaXMgZm9yIHRoYXQuDQo+IA0K
PiA+DQo+ID4gUmVwb3J0ZWQtYnk6IFFpYW4gQ2FpIDxxdWljX3FpYW5jYWlAcXVpY2luYy5jb20+
DQo+ID4gRml4ZXM6IGE0MTJjYWVhNWEyZCAoIkFDUEk6IGJ1czogQWxsb3cgbmVnb3RpYXRpbmcg
X09TQyBjYXBhYmlsaXRpZXMiKQ0KPiANCj4gU28gSSdtIHNlcmlvdXNseSB0aGlua2luZyBhYm91
dCBkcm9wcGluZyB0aGF0IHdob2xlIGxvdCBhdCB0aGlzIHBvaW50Lg0KDQpEbyB5b3Ugd2FudCBt
ZSB0byBzZW5kIHVwIGEgc2VyaWVzIHBlcmhhcHMgdGhhdCByZXZlcnRzIHRob3NlIDMgY29tbWl0
cw0KYW5kIGluc3RlYWQgbW92ZXMgdGhlIGxvZ2ljIGNoYW5nZXMgb24gcXVlcnkgaGFuZGxpbmcg
ZnJvbSBhY3BpX3J1bl9vc2MgaW50bw0KYWNwaV9idXNfb3NjX25lZ290aWF0ZV9wbGF0Zm9ybV9j
b250cm9sPw0KDQo+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IE1hcmlvIExpbW9uY2llbGxvIDxtYXJp
by5saW1vbmNpZWxsb0BhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2FjcGkvcGNpX3Jv
b3QuYyB8IDIxICsrKysrKysrKysrKysrKysrKysrLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjAg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvYWNwaS9wY2lfcm9vdC5jIGIvZHJpdmVycy9hY3BpL3BjaV9yb290LmMNCj4gPiBpbmRleCA2
ZjllNzVkMTQ4MDguLjJlZGEzNTVmZGU1NyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2FjcGkv
cGNpX3Jvb3QuYw0KPiA+ICsrKyBiL2RyaXZlcnMvYWNwaS9wY2lfcm9vdC5jDQo+ID4gQEAgLTE3
MSw3ICsxNzEsNyBAQCBzdGF0aWMgdm9pZCBkZWNvZGVfb3NjX2NvbnRyb2woc3RydWN0IGFjcGlf
cGNpX3Jvb3QNCj4gKnJvb3QsIGNoYXIgKm1zZywgdTMyIHdvcmQpDQo+ID4gIHN0YXRpYyB1OCBw
Y2lfb3NjX3V1aWRfc3RyW10gPSAiMzNEQjRENUItMUZGNy00MDFDLTk2NTctNzQ0MUMwM0RENzY2
IjsNCj4gPg0KPiA+ICBzdGF0aWMgYWNwaV9zdGF0dXMgYWNwaV9wY2lfcnVuX29zYyhhY3BpX2hh
bmRsZSBoYW5kbGUsDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29u
c3QgdTMyICpjYXBidWYsIHUzMiAqcmV0dmFsKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHUzMiAqY2FwYnVmLCB1MzIgKnJldHZhbCkNCj4gPiAgew0KPiA+ICAgICAg
ICAgc3RydWN0IGFjcGlfb3NjX2NvbnRleHQgY29udGV4dCA9IHsNCj4gPiAgICAgICAgICAgICAg
ICAgLnV1aWRfc3RyID0gcGNpX29zY191dWlkX3N0ciwNCj4gPiBAQCAtMTgwLDcgKzE4MCwyNiBA
QCBzdGF0aWMgYWNwaV9zdGF0dXMgYWNwaV9wY2lfcnVuX29zYyhhY3BpX2hhbmRsZQ0KPiBoYW5k
bGUsDQo+ID4gICAgICAgICAgICAgICAgIC5jYXAucG9pbnRlciA9ICh2b2lkICopY2FwYnVmLA0K
PiA+ICAgICAgICAgfTsNCj4gPiAgICAgICAgIGFjcGlfc3RhdHVzIHN0YXR1czsNCj4gPiArICAg
ICAgIHUzMiAqY2FwYnVmX3JldDsNCj4gPiArICAgICAgIGludCBpOw0KPiA+ICsNCj4gPiArICAg
ICAgIGlmICghKGNhcGJ1ZltPU0NfUVVFUllfRFdPUkRdICYgT1NDX1FVRVJZX0VOQUJMRSkpDQo+
ID4gKyAgICAgICAgICAgICAgIGdvdG8gc2tpcF9uZWdvdGlhdGU7DQo+ID4gKyAgICAgICBmb3Ig
KGkgPSAwOyBpIDwgNTsgaSsrKSB7DQo+ID4gKyAgICAgICAgICAgICAgIHN0YXR1cyA9IGFjcGlf
cnVuX29zYyhoYW5kbGUsICZjb250ZXh0KTsNCj4gPiArICAgICAgICAgICAgICAgaWYgKHN0YXR1
cyA9PSBBRV9PSyB8fCBzdGF0dXMgPT0gQUVfU1VQUE9SVCkgew0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgIGNhcGJ1Zl9yZXQgPSBjb250ZXh0LnJldC5wb2ludGVyOw0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgIGNhcGJ1ZltPU0NfU1VQUE9SVF9EV09SRF0gPQ0KPiBjYXBidWZfcmV0
W09TQ19TVVBQT1JUX0RXT1JEXTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBrZnJlZShj
b250ZXh0LnJldC5wb2ludGVyKTsNCj4gPiArICAgICAgICAgICAgICAgfQ0KPiA+ICsgICAgICAg
ICAgICAgICBpZiAoc3RhdHVzICE9IEFFX1NVUFBPUlQpDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgYnJlYWs7DQo+ID4gKyAgICAgICB9DQo+ID4gKyAgICAgICBpZiAoQUNQSV9GQUlMVVJF
KHN0YXR1cykpDQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiBzdGF0dXM7DQo+ID4NCj4gPiAr
c2tpcF9uZWdvdGlhdGU6DQo+ID4gKyAgICAgICBjYXBidWZbT1NDX1FVRVJZX0RXT1JEXSA9IDA7
DQo+ID4gICAgICAgICBzdGF0dXMgPSBhY3BpX3J1bl9vc2MoaGFuZGxlLCAmY29udGV4dCk7DQo+
ID4gICAgICAgICBpZiAoQUNQSV9TVUNDRVNTKHN0YXR1cykpIHsNCj4gPiAgICAgICAgICAgICAg
ICAgKnJldHZhbCA9ICooKHUzMiAqKShjb250ZXh0LnJldC5wb2ludGVyICsgOCkpOw0KPiA+IC0t
DQo+ID4gMi4zNC4xDQo+ID4NCg==
