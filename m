Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39EA32EC388
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Jan 2021 19:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbhAFSxv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 6 Jan 2021 13:53:51 -0500
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:64104 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726143AbhAFSxu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Jan 2021 13:53:50 -0500
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 106IqsZx023471;
        Wed, 6 Jan 2021 13:52:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=7uzZay8Z6yosiu3zH0vfV4y7pg2yTIcjgloNnFlPCps=;
 b=i2pkZLh+8Akg6ciHmVwMyRegJYnF96Z7BauIYbdlEbNNYmV2ba2EdQoAVCHVwPZQN9wx
 ZVR6y1GMj28ZLd3s0gw1V8KwQ+mxVoXbjlqIdTkiSLdnLuSzw4A1z6bmV2z+f/2bngAw
 c7mrN2evn2BiqY+j4rM/VIT1j1danPHUdWkq61Ri9wXH+in6xP2pPruFvH3LBHFZpSKR
 +BLpvN0ipcc1nNhL4DCWZ0z9e+ao60NOset0XIYxcRyzXQ5iIbYepqMUvrqgUe/dyeDd
 legOcgFay9d0vn9laofzLbmNH9AKKwgrCfORc5wtCk9vhAb1gM/Tth2GSA4GxC64no9O 5w== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 35tms8q5mh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Jan 2021 13:52:59 -0500
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 106IpHLY185366;
        Wed, 6 Jan 2021 13:52:59 -0500
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by mx0a-00154901.pphosted.com with ESMTP id 35wj6arnq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jan 2021 13:52:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFcd1PiG41Xr+XcCRUFbqQiw1H37kO6sK/gc4E7LihLmPY1Vr5V1MTOjZwtCQ1sxO4JAwy9TB6+8i0Zc0gYH00mQ67MS9a4tI7zGBl7vTQPAi2byyR3keJDeEq4YeIOo/gqLLeHW3BcZgRZvr9taWJJn/q1QldZiVR/bhzySe75df99KwdffntfHeldihoaz4DCUG3/4ZW9PvwX3PcUQmLX3nnT3NJomyZssGCLyWS4wA5EoQhQ13M6uQnkaDmhfFooALWKbnw5TY5S8xGFtIUXE38RtVWnSWOGRkvQPjlulGww3k/C72dDN+7zSlBH9MKHQNfgtiuQ645Rq+rLGbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uzZay8Z6yosiu3zH0vfV4y7pg2yTIcjgloNnFlPCps=;
 b=IBxPEm2w72XTe6gsqLdEMjcBlWybp9VFraAu5o30iQ/vst1TEpTQH6e20dVnLbe02HkJCIVxPztXI0shxaaRe/XAonL4uS5qkEzFXh/jOTEDdl+c3j8hsg++NAkFVq66rktE049RcjqT5rmdZjeLBPZbOkM5a2Brqq9pBiNONAg2MsKXJkg4hIEQXvXK6dAtDAA/ke11DXBtLJ2JGr69IQ7MHOu7vz5a39UvFZC+mQGrnyCmiVxplLM+wV+6n/4NvhNSea7LgoM0VIUXOsSV0De7ZSgO65l8TE/+zV5zUEryicwcHjcZdIXwEJIL6vCkTui5DiS7Zt6JaglKuVen2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uzZay8Z6yosiu3zH0vfV4y7pg2yTIcjgloNnFlPCps=;
 b=PD9t9qkk0OWaMPoofAPKfK3Q0YJWxKE0E1QOuJZfpCnt11NK8MEl4O2LSKcyS4M3aFm93jn3YDIrfsD/x9GYSZONC7+CktyqOteRpquR7Eb+Do9C/h2Lng4wO1BWaoilMgFvhfBoVrkRQUFXZshOhbdYuNAWFEzCbq+1Zc+kK88=
Received: from SA1PR19MB4926.namprd19.prod.outlook.com (2603:10b6:806:1a6::18)
 by SN6PR1901MB4655.namprd19.prod.outlook.com (2603:10b6:805:9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Wed, 6 Jan
 2021 18:52:57 +0000
Received: from SA1PR19MB4926.namprd19.prod.outlook.com
 ([fe80::e14a:eb33:4847:6cba]) by SA1PR19MB4926.namprd19.prod.outlook.com
 ([fe80::e14a:eb33:4847:6cba%3]) with mapi id 15.20.3721.024; Wed, 6 Jan 2021
 18:52:57 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@dell.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy@infradead.org>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: RE: How to detect Cherry Trail vs Brasswell inside the kernel ?
Thread-Topic: How to detect Cherry Trail vs Brasswell inside the kernel ?
Thread-Index: AQHW5Cg6LiZtnW9xb02LLj+H/BGp/Koa8Qjg
Date:   Wed, 6 Jan 2021 18:52:57 +0000
Message-ID: <SA1PR19MB492668D0A7FA8F09DCFDECA0FAD00@SA1PR19MB4926.namprd19.prod.outlook.com>
References: <37906985-e026-48d3-cda8-6e63696e72aa@redhat.com>
In-Reply-To: <37906985-e026-48d3-cda8-6e63696e72aa@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-01-06T18:52:57.1211507Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=2a94e1a1-6d12-4045-b08b-e0d402d28051;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [76.251.167.31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8737150e-76b2-4469-bfa7-08d8b2744871
x-ms-traffictypediagnostic: SN6PR1901MB4655:
x-microsoft-antispam-prvs: <SN6PR1901MB46552632FB5B1520F4000311FAD00@SN6PR1901MB4655.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fz1Y8bcXsYWxlvdOdndJ5fgJs8+8XOEOHtFoZE6sqkQv0Tt+NBXP3A6LrGra6IayLfmTlnhWmhOlXjuCXCuDboPPpzF3IP0C0rKus/jYBj7llbngqq1ZyRaR5zgnz9QwNBV51P61QMynyboBFBBYk0mDdf3ALrGCs7cmaIkQm+VgKJuHbZSQuhNgBOuhzrHTWwf1F+lKD15UqcJcD++9MM/tdyazz/as4pRLeEgUA4e9sitpe+dh+MvZMhs5ggWJAVg1Xmq1Q12SUYM9jUgfI/R5sXI3ZTOU83LE1sZfA1YfrRiZMvcnDmUhZfwib/X7u2kFnEV06+o9VyMibmzPtoWR/FlfDXp2rAMDzuAEtNLLhaOX3SiACWtn4eDwd1htFSZu6oKEe9484MMEphjjyw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR19MB4926.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39860400002)(376002)(396003)(136003)(52536014)(186003)(5660300002)(8936002)(4326008)(7696005)(66446008)(66476007)(76116006)(64756008)(55016002)(9686003)(6506007)(26005)(66946007)(33656002)(478600001)(316002)(110136005)(66556008)(54906003)(83380400001)(71200400001)(8676002)(86362001)(786003)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?MjgxM3BabWNkejJZRklVNHpTdm1DdjZ3M0xIdUZmdGt3TW1FUEZZY0FOMkYx?=
 =?utf-8?B?R0R1VkduSVArQ2YrcUZMdktJYSt5R3NLQXhudGRxSUl4M2JjNHduYzFleTN1?=
 =?utf-8?B?RXBlRG5mRi9PVDRyUjYzRXUrcFI3T3VsT3FiZzIvZjExb3FWUkxtT01zRzl1?=
 =?utf-8?B?MFdVVEhkWXV6Wmc5TmxMcE5IRHBQdVdBM1g5R01XcHVIWW4xZWF3bmFOZ015?=
 =?utf-8?B?SGNQbzdLSDJSY3hNenRWeHM5L0RSc0ZkMVNtUnNQUlR5Ykt1eUpVczc3ZmVi?=
 =?utf-8?B?V3JkYm9mQnpBY05lQXpkZTRpb1VMUU9VRzNlWHVKZXBWZVdjd3REYS9RMktx?=
 =?utf-8?B?VEprd1RldExXVjBwR0lmTnN1NGNlcHpXd0tVTHU5Z1ZEQzR4NnRseTVjTVp4?=
 =?utf-8?B?ZVRiQy9HVXZaTkFSa0hJVzZReDdRTUFkZlRlRDU4TERjaENJQVVISjQ3am1D?=
 =?utf-8?B?c0JkTDkrMEdpM2tzczgvamEvRjZDeTA0MzRjdmZ1K241UzVZc2RsWFlDZklr?=
 =?utf-8?B?dytDbjZnUTFLbWNEWmZtRU1kdmt2VzlWekp5aGhNckNIZXNmMndSdFN4cGgx?=
 =?utf-8?B?YnEvY3RnZ2xBeGFLSlhvbCtqNG96b1g1djF4TGFuTGkrQ2s3eFR2RFJRWDJh?=
 =?utf-8?B?U3c5cjZqOVY0MCtaQzk1d2N2bWRObHFudE9tNGRIUTZhVzZUZTNVU3k4Sk44?=
 =?utf-8?B?WVFuRWViRFd4aGNDaXpTTVg5elRpZFQ1Wk1uQ3pvdm9DSzNTa0lxTGoySUh3?=
 =?utf-8?B?WUowcG1IZnNFSForVGQ1N3ZZY2Q4aktCajEyZmordEMzbStCaHdNU2J4M0tW?=
 =?utf-8?B?NGd4d2J5VTNxdkNIL0NLQXFoQjdLZVVseUo2L1FnTVA1WldFcGZZd1BsdVlI?=
 =?utf-8?B?YTFUVFJpK2FoNjZUd2I2UGUzY3N6UUlyVnBvTW44ellJSkI3NFFiMnRrTDA2?=
 =?utf-8?B?K3Mxb3pnYXowek9RQTY4YlJuWTQ3eVhPZ21mZDdMeTg4V2s3SzJEcVNvRW9O?=
 =?utf-8?B?K0pKbVl6MkQwNzlZQXRHa0h4ZU1sbTg5bktsWDRFcGR1ajV2bThqcjlraWRU?=
 =?utf-8?B?aFptbnhxWlBzd1U5SGM4eGV0SGhJbWNqTVRwTGNWTldERk5oOThqTDhDNTNo?=
 =?utf-8?B?cWdMQ0V1dDQ0Z3pJbVY1ckRaZnl1cTFxbElIUUVFZm1LUWk0QngxR2ZlaVNl?=
 =?utf-8?B?NzFNejl0MFdXVkEvaDdqZE1Hc0cvYzZ6eHN2Y2FDanEvVTBjcXN6K3FQMnor?=
 =?utf-8?B?bmNPblBaV2lJandTS0FnZ1M0WWJGNWVJTmhVdVpsZm01VXI2YjdoNldTSnRv?=
 =?utf-8?Q?WqNvzL9xtLZZA=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR19MB4926.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8737150e-76b2-4469-bfa7-08d8b2744871
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2021 18:52:57.3383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qzPqlSOHo1F5Hik/ZqEX13o8BTwI5ntAQYyF3qsaiU3W7UcdJwVI153Tj2fDsXHU3D87IzRKNqJQAb65m5j7QiwHbKrQYJ4S+txyzL/qMqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1901MB4655
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-06_10:2021-01-06,2021-01-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 priorityscore=1501 adultscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 suspectscore=0 phishscore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2101060106
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101060106
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

PiBTbyBJIHdhcyB3b25kZXJpbmcgaWYgYW55b25lIGVsc2UgaGFzIGFueSBiZXR0ZXIgaWRlYXMg
aGVyZT8NCj4gDQo+IFJlZ2FyZHMsDQo+IA0KPiBIYW5zDQo+IA0KPiANCj4gcC5zLg0KPiANCj4g
SnVzdCBGWUkgdGhlIDIgaXNzdWVzIHdoaWNoIEkgd2FudCB0byByZXNvbHZlIGFyZToNCj4gDQo+
IDEuIFByZXZlbnQgZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWxfaW50MDAwMl92Z3Bpby5jIGJp
bmRpbmcgb24gQnJhc3dlbGwNCj4gKG5vbiAidGFibGV0IikgU29Dcy4gVGhlIElOVDAwMDIgQUNQ
SSBkZXZpY2UgaXMgdXNlZCBmb3Igc29tZSB3YWtldXANCj4gZXZlbnRzIChmcm9tIFMyaWRsZSkg
b24gdGhlIHRhYmxldCAoQ2hlcnJ5IFRyYWlsKSB2ZXJzaW9ucyBvZiB0aGUgU29DLg0KPiANCj4g
VGhlIGN1cnJlbnQgY29kZSB3aWxsIGFsc28gYmluZCB0byB0aGUgSU5UMDAwMiBBQ1BJIGRldmlj
ZSAoaWYgcHJlc2VudCkgb24NCj4gQnJhc3dlbGwsIHRoaXMgaXMgY2F1c2luZyBzdXNwZW5kL3Jl
c3VtZSBpc3N1ZXMgb24gc29tZSBkZXZpY2VzLg0KPiBBVE0gd2UgYXJlIHdvcmtpbmcgYXJvdW5k
IHRoaXMgYnkgc2V0dGluZyB0aGUgSVJRQ0hJUF9TS0lQX1NFVF9XQUtFIG9uDQo+IHRoZSBpcnEt
Y2hpcCBmb3IgdGhlIElOVDAwMDIgdkdQSU8gcGluLiBCdXQgdGhpcyBpbiB0dXJuIGlzIGJyZWFr
aW5nIHdha2V1cA0KPiBieSBVU0IgcGVyaXBoZXJhbHMgb24gQ2hlcnJ5IFRyYWlsIGRldmljZXMu
IElmIHdlIGNhbiBqdXN0IHN0b3AgdGhlIGRyaXZlcg0KPiBmcm9tIGJpbmRpbmcgb24gQnJhc3dl
bGwgZGV2aWNlcyBhbGwgdG9nZXRoZXIgdGhlbiB0aGF0IHdvdWxkIGJlIGJldHRlci4NCj4gDQoN
CldvdWxkIGl0IGJlIHBvc3NpYmxlIHRvIGFzayB0aGUgdmVuZG9yIHRvIHJlbW92ZSBJTlQwMDAy
IGRldmljZSBmcm9tIHRoZQ0KZmlybXdhcmU/DQoNCj4gMi4gRGVhbCB3aXRoIG5vbiBmdW5jdGlv
bmFsIC9zeXMvY2xhc3MvYmFja2xpZ2h0L2FjcGlfdmlkZW9bMC03XSBkZXZpY2VzDQo+IHNob3dp
bmcgdXAgb24gQllUL0NIVCBiYXNlZCBtZWRpYS1ib3hlcyAvIGhkbWktc3RpY2tzLiBUaGVzZSBk
ZXZpY2VzIGRvDQo+IG5vdCBoYXZlIGEgTENEIHBhbmVsLCBzbyB0aGVyZSB3aWxsIGJlIG5vICJu
YXRpdmUiIGJhY2tsaWdodCBkcml2ZXIgY2F1c2luZw0KPiBkcml2ZXJzL2FjcGkvdmlkZW8tZGV0
ZWN0LmMgdG8gc2VsZWN0IGFjcGlfYmFja2xpZ2h0X3ZpZGVvIGFzIGJhY2tsaWdodC10eXBlLg0K
PiBkcml2ZXJzL2FjcGkvYWNwaS12aWRlby5jIHRyaWVzIHRvIGF2b2lkIHJlZ2lzdGVyaW5nIG5v
bi1mdW5jdGlvbmFsDQo+IC9zeXMvY2xhc3MvYmFja2xpZ2h0L2FjcGlfdmlkZW8gZGV2aWNlcyBp
biBjYXNlcyBsaWtlIHRoaXMsIGJ1dCB0aGF0IGRlcGVuZHMNCj4gb24gYSBETUkgY2hhc3Npcy10
eXBlIGNoZWNrICh0byBhdm9pZCBzdXBwcmVzc2luZyB0aGUgYmFja2xpZ2h0IGludGVyZmFjZQ0K
PiBvbiBsYXB0b3BzIHdoZXJlIHdlIGxpa2VseSBkbyB3YW50IGl0KSBhbmQgbWFueSBvZiB0aGVz
ZSBtZWRpYS1ib3hlcyAvDQo+IGhkbWktc3RpY2tzIGFyZSBkZXJpdmVkIGZyb20gQllUL0NIVCB0
YWJsZXQgZGVzaWducyBhbmQgb2Z0ZW4gdGhlIERNSQ0KPiBjaGFzc2lzIHR5cGUgc3RpbGwgc2F5
cyAiVGFibGV0Ii4gQWN0dWFsIENoZXJyeSBUcmFpbCBkZXZpY2VzIHdpdGggYSBMQ0QNCj4gcGFu
ZWwgYWx3YXlzIHVzZSB0aGUgbmF0aXZlIGludGVsX2JhY2tsaWdodCBpbnRlcmZhY2UsIGJ1dCBJ
IGd1ZXNzIHNvbWUNCj4gQnJhc3dlbGwgYmFzZWQgZGV2aWNlcyBtaWdodCB1c2UgdGhlIGFjcGlf
dmlkZW8gaW50ZXJmYWNlLg0KDQpNYXliZSBhIGZ1bmN0aW9uIHRvIGxvb2sgYXQgc3BlY2lmaWNh
bGx5IHRoZSBETUkgY2hhc3NpcyB0eXBlIG9mICJUYWJsZXQiIGFuZA0KY2hlY2sgZm9yIHRoZSBs
YWNrIG9mIGFuIGludGVybmFsIExDRCBwYW5lbC4gIFRoYXQgc2VlbXMgbGlrZSBkZXRlY3Rpbmcg
dGhhdA0KY29tYmluYXRpb24gc2hvdWxkbid0IGV2ZXIgdHJ5IHRvIHJ1biB0aGlzIGNvZGUuDQoN
Cj4gDQo+IEkgd291bGQgbGlrZSB0byBiZSBhYmxlIHRvIGFkZCBzb21lIGNvZGUgdGhlIHRoZSBB
Q1BJIHZpZGVvIGNvZGUgd2hpY2gNCj4gc2ltcGx5IGlnbm9yZXMgdGhlIGJyb2tlbiBhY3BpX3Zp
ZGVvIGludGVyZmFjZSBvbiBDaGVycnkgVHJhaWwgZGV2aWNlcywNCj4gd2hpbGUgc3RpbGwgdXNp
bmcgaXRzIG5vcm1hbCBkZXRlY3Rpb24gbG9naWMgb24gQnJhc3N3ZWxsIGRldmljZXMuDQo+IFRo
ZSBhbHRlcm5hdGl2ZSB3b3VsZCBiZSBhbiBldmVyIGdyb3dpbmcgbGlzdCBvZiBETUkgYmFzZWQg
cXVpcmtzIHdoaWNoDQo+IGlzIHVuZGVzaXJhYmxlLg0KDQo=
