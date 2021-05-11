Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1F737AEE8
	for <lists+linux-acpi@lfdr.de>; Tue, 11 May 2021 20:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbhEKS6J (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 May 2021 14:58:09 -0400
Received: from mail-co1nam11on2047.outbound.protection.outlook.com ([40.107.220.47]:5536
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231454AbhEKS6J (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 11 May 2021 14:58:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bxCXXbIaKVRy1wcFQYdaOoImNLMB2AInckcxZMlRpH25SIQ4DQQAEKP/OpI70/KhV8me6CmvDC/YJkg2sJNvc3JUGOZq0A9F6pc7WtFumhIR9lkZRd6cF7IFNRcftJSocuz+hdM7S1fafxdrTEuh+2LOH2oC1wUl0dQDY3xxSAl/ocdLFc5MF/Z9ceBFeC4KAuPfdHxP/p+eh3cmHAfSx7kGJtKUrbBWEN5zXhzkKahHdCEl/h3YR2/3ri2U0Ada26CXcGD35PyFl1bQDxwNJ2FKrTPtOPGJIn7ljC8o5FhEfJxGn3vEOFJwty7ZF9mnOgGHMsq5iUJUxrus/POdRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/AdOw4IxEIEx8jIaC0WDkbc4q4AMartW1NSa5Q8C28M=;
 b=MIbVtewD9BceIxEkw6t+OwyO4oTHv4c4cx73P2q3Kbh/Sgb6qkesRm5hMN9aJ+/SNNRpZfx2G6fk0hW3aeOIgqVZCfxFCeWJqgco6vCSg3XRwD+A5TH5xP9eE+YhD0+3iAkrdUmuMNJ1dongAg7swAWqYa30U9MQrSQ/3eKP8W+b0Tl/EwcHsJdFX00L/xIzcdoZJVAXxhHY+Wb7EC+DmqBSn7lajBdP9KftNmApfteMD52Dpd9iFPLhZt2xNZE0oLcnwvovkyfRcxa1H2LcL7QBaaMo0GtWdxlBwrvV1zJJcp+5hpFhOa/NFm7aT8iT1x+BM5suWwisk57sV0iX0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/AdOw4IxEIEx8jIaC0WDkbc4q4AMartW1NSa5Q8C28M=;
 b=GdsJ5yTJqZV+oReDPG671qnziU6U0M9HmMGQtVowvrZFdPMevmEOatV77+UldCjrZghTnmkiRPGWhDsBHnalm7YNP4ZANF1AfTJfuXGwX9CC1L154yab+Ik6sfzA6A/sKgMI5B02Ippx+FWqS1tXuFVO87r2ASLDIXeKn/wM5wM=
Received: from BYAPR12MB2693.namprd12.prod.outlook.com (2603:10b6:a03:6a::33)
 by BYAPR12MB3624.namprd12.prod.outlook.com (2603:10b6:a03:aa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Tue, 11 May
 2021 18:56:59 +0000
Received: from BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::c0c3:7247:a767:f5b6]) by BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::c0c3:7247:a767:f5b6%3]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 18:56:59 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Liang, Prike" <Prike.Liang@amd.com>
CC:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH] ACPI / idle: override c-state latency when not in
 conformance with s0ix
Thread-Topic: [PATCH] ACPI / idle: override c-state latency when not in
 conformance with s0ix
Thread-Index: AQHXRhB2PGuo7Bnw1UWLxLUelvn94KreE2SAgABSPyCAABwqAIAAASCAgAAANICAABENgIAADJ1w
Date:   Tue, 11 May 2021 18:56:59 +0000
Message-ID: <BYAPR12MB269399B97D4BBC07B5758CCDE2539@BYAPR12MB2693.namprd12.prod.outlook.com>
References: <20210511025024.10083-1-mario.limonciello@amd.com>
 <CAJZ5v0jSZ-oR2m15emfWV4s2rCic=t7RAEXd0--yaHPbt820-w@mail.gmail.com>
 <BYAPR12MB26937BC445598D567C964734E2539@BYAPR12MB2693.namprd12.prod.outlook.com>
 <CAJZ5v0jRSUV7_MN6Ru0R6tNq11Qe7Swv3Wy4sfZYbrn0H8r-tw@mail.gmail.com>
 <CAJZ5v0i=Zx_LOR1yZ0EkgrH4jy9+j=++kRBOJm_da3_a1=HDTw@mail.gmail.com>
 <BYAPR12MB2693FA7AE60DADDDDE0809FCE2539@BYAPR12MB2693.namprd12.prod.outlook.com>
 <MN2PR12MB44888AB90D99B2A3B4A70961F7539@MN2PR12MB4488.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB44888AB90D99B2A3B4A70961F7539@MN2PR12MB4488.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Enabled=true;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_SetDate=2021-05-11T17:24:31Z;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Method=Privileged;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Name=Non-Business;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_ActionId=13668c12-1c91-4094-972e-e52f0d596402;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_ContentBits=0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2600:1700:70:f700:5f0:f9af:d99c:b88f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d31a177d-6c03-46c8-a762-08d914ae8e92
x-ms-traffictypediagnostic: BYAPR12MB3624:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3624A418CEDB3C14E6A32193E2539@BYAPR12MB3624.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NzBoX0e4SF/yQwEwb2uE4VuzIT8pUjMb91jv+DIoDTdYozoH0VRUp8N4/eYY4j7KOYZ+rsxGygKgBqoTgzKvIsLFWZs8mQWcig9/V7d3oKHNmb0UXGo6t4MTjSkFXsNktR1Nu+kjUEk4DKo8AG5rWbeGPq49Qy6Y9pvsjHKqeBXEnbSlcORcW/NctXGMtAXKkIz5kR8mJkxXozqQoH1b9KUjwLpiAyOCtaf/t8wdgSdiwUtni12i2DHNgKVtEgCg2xowJd+iN+7C6hINu4f2PagPts6s6ymIFmK9M5GvsXnq2WmHej26nzxML+ppmUD5+V2kdEyK1N+8Z2lAPlxyX+/OXYoa1SksGAC3fLu4gZ7vBDxIIneBWUmnJ3HNNSbpVZPu4BxUo0G+s1gS1Qz+tFUfUurwvBOgCV7B9RHdURlhFCqnoicEf8g9c51ZBR0qzGsjqaa8l2uQNIxc8K8e28bq/apI05LLz59vB2l4CfnY3D6U3l15+V74dyqc6mCStVexWxhruwMGs6LMVTwb1Xhja4k11LegSGIt2m+vogKEkwPDL4wX+8pH28bkEIwAmXVooZMiMk8VuZJqSSswx1V+l/6cWCdSImdYXmrn/fGl2B4Rcb1Wsl4b2lrMSItviavtZLKFhguduzsKlyRrog==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2693.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(122000001)(33656002)(6506007)(7696005)(86362001)(66476007)(38100700002)(66556008)(64756008)(76116006)(66946007)(6636002)(2906002)(8676002)(66446008)(4326008)(71200400001)(54906003)(5660300002)(4744005)(55016002)(83380400001)(52536014)(110136005)(8936002)(478600001)(186003)(316002)(9686003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Uy9NYzhsbmptd29nSmNXOHhvL0lyakFDS2hUVTR2YjFLcDAxNndCRnFrNUNQ?=
 =?utf-8?B?Yi8zcXlqNTgvOVhiR0hKaGVSKzNkdDc4SjVha21nMVlOYUFiWFc1ZDJiSGh6?=
 =?utf-8?B?aW44TXU0VGcvVHh2RjRYQmVTblZIblB5UWZUNmRQRVpNenFwTVNGb2d6UFpt?=
 =?utf-8?B?dDlRa2Z1YUtOZ0VueW5uSjhoSzdQZWVIYkpUMy9xWGZCaTVKWmgxdk5RcnZs?=
 =?utf-8?B?eXovZEZIaFRJbCtoOENNN3lmaHZKU1hXLzN2VUllVzFYekpNNUhrcWk4VytI?=
 =?utf-8?B?TU5CV1R2N3RRNHFuYUFaSzNzMmFCSjc5WjNpK1gyd1BXVlhXVDFlMHlMMFYv?=
 =?utf-8?B?aUJYNWo2dExoYi9xZFBFMFVCQVo4dU9QRnlES2gvQ1ZLQ2FxTWpENWt4WlB5?=
 =?utf-8?B?YjlISTVkcHVtTUZ3bjJOOXQyZ1gxanQ0dml3Ulp4emMzNjFEdFdSR3EvZGtI?=
 =?utf-8?B?NXJHTWN0T0lmbVB5eURGRmswY1UzUjhlRlR2M3BIMzhBS1Jla1JYeDZEWE9o?=
 =?utf-8?B?SWZGU0Jid1Z2TFMzeUJJemQvbktjYWlIU0dxZTBBaHlSZmpnT1docTdWN2Iz?=
 =?utf-8?B?ek9qaGFzak8rSnd1L0lqd2dLeW9WcTQ1V2VwVzlmS2tIcWVsa0VYaVFQcEZP?=
 =?utf-8?B?NHhIR29JdU1wSS8zekh2bnNyYzBXUkpoOFQvazRYaTNSVlZldmQ2R3ZUTFlL?=
 =?utf-8?B?RFdHRmJ1dnZxUEZRdWN2WlczZytyTGdRR1kwb1h6UFg5WXhjeDJkcTdJbVd4?=
 =?utf-8?B?dVhpNkZaWTJYekJNbHB0bTBUR1dtVUk4ZTZSeEExaHE4MmJsNktUanRDenRN?=
 =?utf-8?B?eDQ4cVZ2NDVSRGI2N3FEZ0xCdk0vYklZUGs2amtVbkRmbE12cmwxMFpCTEdT?=
 =?utf-8?B?SDFPQ2NTYk14b285VGFVenB2Lzh6YkJmL2xEUGpIdnU0MTRwaXg3Zll5RWtm?=
 =?utf-8?B?WkROTUNjMC8yQ1BMZlZuVzI2SFNCNllNNEhUWlV5a1l2QnpPbGN3MXJxbkk2?=
 =?utf-8?B?VkxaZlYyTUt5bzZqbXFpM1hZbTN2THg5VU10VGlxUjZSSDhYZkFtSENyZGpV?=
 =?utf-8?B?aEgzQ3huMndkbC8xbzlzR2JrNUdBb1hmOU0xdHc5SDlTR1NxV0h5dkFJNXZE?=
 =?utf-8?B?djJ2T01VVm1DZW9OcWRXV1NVYktZVzd5QjNvR2EyZ0V0OVhYN0krdTQyOW5q?=
 =?utf-8?B?dk9ZelR0NDhFSFNCNmxkT2ZOOVl2SFJHdWplMmxqZ2J5cVpUeHIwTWVUWnJx?=
 =?utf-8?B?VnEwZkZKNzNpU0tMUmNvL0k5ZTdOZ05rVkFIMXZuTnI1NmJ6aWtjTFRGWlpK?=
 =?utf-8?B?d2NacW5iMi9qeFlLbERxNHpBZEYzeUhuSHdOYlkxWjN3akRpek5QZlpScGhB?=
 =?utf-8?B?VEZPakhtRVV6MEFYTVROQ1g2c09NaTg3WHdROWY1RE92ZkttUG9vNXhyeVkv?=
 =?utf-8?B?b2FLU3dyVVRTTmlOaTJYMWpLSUpEUEVYMkNENTBSVzlMQ3hTRUwyTjU5dklT?=
 =?utf-8?B?QUxBRU93MDYzVTM5aFJGNENsRithZC9lbVdDbUVUNTlZdWpxck5seHpKd2xl?=
 =?utf-8?B?V0hCSSt4b3lCQU9rUFZ1MDRQV2Ztelc3ZmROUVB0NnF0dkJjdG5SYVZzZmNH?=
 =?utf-8?B?cTZKWmh4VE1wemROK2YrZ1YvMVV2TExWNHlQNks5Yy9NZHNGRWRnOFBDN0hR?=
 =?utf-8?B?bVVOdW9taitzdzI0Smx4Y3F4UEpZcVY0SlVScG1jNlJsb24ycnFmeFNramxv?=
 =?utf-8?B?SmR3UGhnWlJWRUFIWU5PZmdKd1M2TGpjdlMwaDdsRjJaVnFzSzFRNEVRRnd1?=
 =?utf-8?B?WEM1YW1nZWpNUWRUVXhpQSsyRFRCNXJSNWpuL0dRNkxucHBOdEFPaW1EdTFT?=
 =?utf-8?Q?RCrxJZac4hLDf?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2693.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d31a177d-6c03-46c8-a762-08d914ae8e92
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2021 18:56:59.6595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JEF4XLV+CdvvbkwGmvF6H6zWLKLHOj628eOTN5R+kwd0Med0r1pt6ZxMlF4dhb04rFn9Z0lXB7ufIZMIMIqUCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3624
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

PiA+DQo+ID4gQWN0dWFsbHkgSSB0aGluayB0aGUgdmFsdWUgc2V0IGluIHRoZSBPRU0gQklPUyBm
b3Igc3RhdGUyIGZyb20gTFBJIGxvb2tzIGJvZ3VzDQo+ID4gdG9vLg0KPiA+IEl0IHNob3VsZCBo
YXZlIGJlZW4gMzZ1cy4NCj4gPg0KPiA+IEBMaWFuZywgUHJpa2UgYW5kIEBEZXVjaGVyLCBBbGV4
YW5kZXIgeW91IGhhdmUgc29tZSBtb3JlIGhpc3Rvcnkgb24gdGhpcw0KPiA+IHRoYW4gSSBkby4N
Cj4gDQo+IEkgdGhpbmsgdGhleSB3ZXJlIGp1c3QgYm9ndXMsIGF0IGxlYXN0IGluIHRoZSBpbml0
aWFsIGNhc2VzIHdoZXJlIHdlIHNhdyB0aGlzLg0KPiANCg0KSW4gcHJvY2Vzc29yX2lkbGUuYyB0
YXJnZXQgcmVzaWRlbmN5IGlzIGNhbGN1bGF0ZWQgYnkgZXhpdCBsYXRlbmN5IG11bHRpcGxpZWQg
YnkNCmEgbGF0ZW5jeSBmYWN0b3IgcGFyYW1ldGVyICgyIGJ5IGRlZmF1bHQpLiAgU28gd2hlbiB0
aGVzZSBzeXN0ZW1zIGhhdmUgdGhlIGJ1Z2d5DQpfQ1NUIEMyIHZhbHVlIG9mIDQwMCwgdGhhdCdz
IHdoZXJlIHRoZSA4MDAgY29tZXMgZnJvbSBmb3IgcmVzaWRlbmN5LCBub3QgX0xQSS4NCg==
