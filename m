Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0AE62EC3AB
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Jan 2021 20:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbhAFTFV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 6 Jan 2021 14:05:21 -0500
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:7490 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726369AbhAFTFV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Jan 2021 14:05:21 -0500
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 106IqAq9015332;
        Wed, 6 Jan 2021 14:04:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=aTcOOHebaPx7t26IfZDe2dAeXknxeZTRw943Wexm4SA=;
 b=UGlYK/e/yMqrK7mRvLJPExnDknPfq434+dmgokcqxk36uzZAQ4ZDtSXO37XtoXch9/s7
 BUHihorMu94uEgtwLz4ivIR1dHWLu+Bc3XL3mjYPu8EYhBAH+zYZyrSuNZdKO22bECQ9
 sN/EPXMVAmS74xuKmmtCNYjBnqbwUVJHWhyigaiNihPJqyylvhY4QU6G9VYMD4ow1gUW
 pU1i/W3AfyHjJ8sxL73XOea6XfxDrpO3Xaj9nWWOrhrUG+hMV5AagKuZbkHmO44WHLKi
 9U8P5FdcLkPau/5HbeQ3ndmtb/QZ5YRCKv5KSB9IFx73T1CnXUbbSur5D5+GWewV8Lg1 RQ== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 35tpcty0dm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Jan 2021 14:04:30 -0500
Received: from pps.filterd (m0144102.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 106J0eXj054221;
        Wed, 6 Jan 2021 14:04:30 -0500
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by mx0b-00154901.pphosted.com with ESMTP id 35whh0sfwa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jan 2021 14:04:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGy5hsRjgA0AkJDgmWrOTSIWczjVI1XgsY54+PV3hX0K5p/hrrcXTwu+uYUl7JFNH9eT00SJH6sQC166IkX9rSQyDBC8oXBC9DEsc8xCluwycKb4QK0yBUlX1NzZzVbFcEPZIQw3pqCjVtiaUW1N3vV6yDt4lSA3d5Ms2HMxKRM4kJaFKo4cIGTdNl6JdR/tVDGVhz9SPZUyOfOUEQVzpH5AQtlfi/oPwgiUySUJm2JFz9V3pj6y17pNhN54hpJhzxWEa1toQO4OxNfFn+XED2bcaGkFp5cudDuuB3w4Kau2puR/KheLsS68QgwbcrxR+ssWqoud+Z7N8b1QLl7RQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTcOOHebaPx7t26IfZDe2dAeXknxeZTRw943Wexm4SA=;
 b=Nexwu5sTt5Z7RjRHjlLWC/iuk/HVVcDVWbj/OP+INPKss2F11EmnXg5dtNCcoI1rygOVfjnqTOUUxBKfClXbSz3lbvA04pkoSqJaemFPY8p94tERqrzop4HtyYvyZYUPcUousE2s/W4IM/aXT1gnReMo8RYhijLfGT8pndS56jCKcgiYzLvrrWhTIPk9KO0cybpyeaYXLlIbTJBY/+X03BQiUovTKlIVVh495PG8HltNJ1t1j4CjT93oJrk0nIh46DMUngXLLanopgUr0oasGB6mslOXyPbBFq5PWAZU+NaWOfWHW9akkfzJWPW6ApJkCIQmjrXliOMHRzRfd/fUtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTcOOHebaPx7t26IfZDe2dAeXknxeZTRw943Wexm4SA=;
 b=aePc2N6VW9UCp0hqBUp5kFIlHQs41+Xk1Gj4ffGhFkXghPz6/cVU+TZL5/9CytzQD88/Tij5sK+9IrOboifHfsx+8FmWzexws3VO7YlimZgZRhGWFmtrBUaoBUHEFHLc8wZH7MzKkYJKix0Wlae140nXENVEJLLYhxqWKhN4i2M=
Received: from SA1PR19MB4926.namprd19.prod.outlook.com (2603:10b6:806:1a6::18)
 by SA0PR19MB4206.namprd19.prod.outlook.com (2603:10b6:806:85::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Wed, 6 Jan
 2021 19:04:28 +0000
Received: from SA1PR19MB4926.namprd19.prod.outlook.com
 ([fe80::e14a:eb33:4847:6cba]) by SA1PR19MB4926.namprd19.prod.outlook.com
 ([fe80::e14a:eb33:4847:6cba%3]) with mapi id 15.20.3721.024; Wed, 6 Jan 2021
 19:04:28 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@dell.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy@infradead.org>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: RE: How to detect Cherry Trail vs Brasswell inside the kernel ?
Thread-Topic: How to detect Cherry Trail vs Brasswell inside the kernel ?
Thread-Index: AQHW5Cg6LiZtnW9xb02LLj+H/BGp/Koa8QjggAACwYCAAADOYA==
Date:   Wed, 6 Jan 2021 19:04:28 +0000
Message-ID: <SA1PR19MB4926B186F8E015F8BE4DAEABFAD00@SA1PR19MB4926.namprd19.prod.outlook.com>
References: <37906985-e026-48d3-cda8-6e63696e72aa@redhat.com>
 <SA1PR19MB492668D0A7FA8F09DCFDECA0FAD00@SA1PR19MB4926.namprd19.prod.outlook.com>
 <70d39d5c-e412-110e-f403-d1c05573c6ce@redhat.com>
In-Reply-To: <70d39d5c-e412-110e-f403-d1c05573c6ce@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-01-06T19:02:51.1491016Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=785780a0-3286-44f3-9ba6-9e5ce80be829;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [76.251.167.31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c348ab21-f168-4abe-8cc7-08d8b275e499
x-ms-traffictypediagnostic: SA0PR19MB4206:
x-microsoft-antispam-prvs: <SA0PR19MB4206BD3D755B55A5C9BCDBB6FAD00@SA0PR19MB4206.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2oNupG/uTc2/GKCupKyt/1itdNqIx0tNy9Yh3GOugcCaw1E0LS11kcN3Nwo8DVPWXqTatTd70dJm8U/TF9ecSwTtyqCGHYE4vS6l9EXcUNhv3+YSn+tVEjWqAUd9oxFIrj7G2IM0jmcLZn/t6L+9JAwh2ZCzgIP9VKv0yj2tVdL/7eoOrOaPmGQKCT4zmDCjJibWMJOp2KvMwEk5HWuCc+fj5aPbFffM3qCcn917itjY70ytZi5Kjqx4zLIFNCrLcrSvy+DRX8XD9fpiHneH3qaxIJrBUcboRREDjYekkQ2PBwoNG5CQl/iukJh+y9McYug4zgXAPRDN62rr6DWeWRh5Dn5recg1EjsA5equFmtqBQ+hf02o+TgcGz0/p1+2gpvzmnXqGQZ7YGKox1vjAw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR19MB4926.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(8676002)(71200400001)(8936002)(786003)(5660300002)(55016002)(9686003)(83380400001)(26005)(6506007)(186003)(66946007)(66446008)(316002)(2906002)(76116006)(33656002)(7696005)(110136005)(478600001)(4326008)(66476007)(66556008)(52536014)(64756008)(86362001)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?RmFWSW13dW0vbWJtZFFKV21Ub1BsZHJnM1Y4VnVqUEEycXNvN2NLYk1xTUp0?=
 =?utf-8?B?WTNwdldFZWRmeFN2enFlQzVFQVhCL3BETEt5dTZ1QWhNWXllYUpQMjVUQW5V?=
 =?utf-8?B?amVxVE00L254QXRRdFF6KzkxaHVvYkxKM1BjV0kvV2pTWittczdCWmxLd3M4?=
 =?utf-8?B?dGV1S2J2WmR2OGVaaXpBRERNS3lpbW5NWE1NUjlIZCtCZTJlV2RYYmlNUyti?=
 =?utf-8?B?UWNIWVduZzRaa1hpZ2lPak41c2ZGZ0twd0xZYWwxOVdzNlY5TzhubU5sejFL?=
 =?utf-8?B?WDFpOUpZZi9nNmoxR0NoRVdGTWc5NElYeHNWUWdaejFZbGdzVlJ6bE9NTWdq?=
 =?utf-8?B?U1Q2WkxEbFE5b3JMMDlITUVwYnIrTDhFcC9yRnhMSi9LQkwwa1d0VjRiUFVh?=
 =?utf-8?B?M2RIb2lxYlRzTjNDRlF1KzRWUzByc0UzWHZOZlE0cGpxcjlhT09pSXpBaDZo?=
 =?utf-8?B?NVh6Z3VlZHliSHhCM2x1OVdTYWtYYWMxYm80dmoxTVFob0ErMEZ5YUtSUDVu?=
 =?utf-8?B?RUV0Q1YwM0xtcXdwK3A4Zlo5WUMyME9vRHpKQWhQVDU4bmV3c1AvblFyQzJk?=
 =?utf-8?B?MjJuWDVMenBPYjU5YzNMS21GcGZYZUJPbFBva1J6dGwwNWJhaDcyTUlPTUxa?=
 =?utf-8?B?UHZ0TDVrR0VxNnBhUHlic1htb0NFMTR6cVlCUHNXZzg1elJnQTdpOC81alJN?=
 =?utf-8?B?MjBnZkNnMWhLSGd3VmZmeUUvZVppVWwwU3ZYdE0rZ1pUVUFTRmZQelFTTU5T?=
 =?utf-8?B?Yjd2MjlFbVEyNTNta0JBOVQ0ZlJqVGE2OEE3QVQ0MkZKZ204NWcwY25kRlFD?=
 =?utf-8?B?VzZCa0FxRVN1QkVqV05pWXBjSm02bWUyL0d2dkozSFlTNW8wRitObVJzbDEy?=
 =?utf-8?B?Wk5DclVqNENCOGNXSUVJSzlveXNOUC9ycmhUbTFreWQrY2ZyRTNSU0t0ZTNN?=
 =?utf-8?B?Q2IyaTBEMHM1TE5nYk9sbnRlSC9wYkt1Rm5VeDg2aGxvM2tmelNyYzVYNklH?=
 =?utf-8?B?RHIzNTdQYnBtNGpiZDJNYk14MzNGeWwzdHJ5ZkZZRjJONk5VTkQ2VlU2VGti?=
 =?utf-8?B?T2djL05BWFFIaUdPSTViSkVwcG9TTjFMdjRGdXFNTE44S1lXR01sY1A3dVI4?=
 =?utf-8?B?OTJDb3g3dHYwT281eUlEQjZNN1NUaHFEai90NUNyNUhuaGNrSnpTR2Q0cW9j?=
 =?utf-8?B?eHd1S1paaUhtTG9WRzEzWmtLZFNDcm9ocGh4WWlzQ2JJUHVhQnhlek92c1Yr?=
 =?utf-8?B?dmxzUjVKTDhGMWYwdnJCaFpBN3N4Qy9YUmZvWXFwd1c3Q0w0Nk12TGZQd202?=
 =?utf-8?Q?zlyZk6bfyKvaE=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR19MB4926.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c348ab21-f168-4abe-8cc7-08d8b275e499
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2021 19:04:28.8314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hx3875J/d4f4KTAA+7pKy25QaXPltErvWUAFfJG+ijl6CdEitHgnWAZEAhPP7gCZagDp9IV2AMhWKpiDD9XNLWD0fHJk9SgbL3d4fcFdK84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR19MB4206
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-06_11:2021-01-06,2021-01-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=997 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101060106
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101060106
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

PiANCj4gPg0KPiA+IFdvdWxkIGl0IGJlIHBvc3NpYmxlIHRvIGFzayB0aGUgdmVuZG9yIHRvIHJl
bW92ZSBJTlQwMDAyIGRldmljZSBmcm9tIHRoZQ0KPiA+IGZpcm13YXJlPw0KPiANCj4gRXZlbiBp
ZiBhbGwgdmVuZG9ycyB3b3VsZCBpc3N1ZSBCSU9zIHVwZGF0ZXMgZm9yIHRoaXMgZm9yIGFsbCBt
b2RlbHMNCj4gKHdoaWNoIHRoZXkgd29uJ3QpIHRoZW4gd2Ugc3RpbGwgY2Fubm90IGNvdW50IG9u
IHVzZXJzIGluc3RhbGxpbmcgdGhvc2UNCj4gQklPUyB1cGRhdGVzLiBCZWNhdXNlIG9mIHRoaXMg
cmVseWluZyBvbiBhIEJJT1MgdXBkYXRlIGlzIGFsbW9zdCBuZXZlciB0aGUNCj4gcmlnaHQgYW5z
d2VyLg0KPiANCj4gKE5vdGUgSSBndWVzcyB0aGVyZSBtaWdodCBiZSBzb21lIGV4dHJlbWUgY2ly
Y3Vtc3RhbnMgLyBzb21lIGNvcm5lciBjYXNlIHdoZXJlDQo+IHRoaW5ncyBhcmUgc28gYnJva2Vu
IHRoYXQgd2Ugd2lsbCB0ZWxsIHVzZXJzIHRvIGp1c3QgdXBncmFkZSB0aGVpciBCSU9TKQ0KDQpJ
dCB3YXNuJ3QgY2xlYXIgdG8gbWUgaWYgdGhpcyBpbnF1aXJ5IHdhcyBmb3IgcmVsZWFzZSBvciBw
cmUtcmVsZWFzZSBoYXJkd2FyZS4NCklmIGl0J3MgcHJlLXJlbGVhc2UgaGFyZHdhcmUgdGhpcyBp
cyBhY3R1YWxseSBxdWl0ZSBwcmVmZXJhYmxlIGluIG15IG9waW5pb24uDQoNCj4gDQo+ID4+IDIu
IERlYWwgd2l0aCBub24gZnVuY3Rpb25hbCAvc3lzL2NsYXNzL2JhY2tsaWdodC9hY3BpX3ZpZGVv
WzAtN10gZGV2aWNlcw0KPiA+PiBzaG93aW5nIHVwIG9uIEJZVC9DSFQgYmFzZWQgbWVkaWEtYm94
ZXMgLyBoZG1pLXN0aWNrcy4gVGhlc2UgZGV2aWNlcyBkbw0KPiA+PiBub3QgaGF2ZSBhIExDRCBw
YW5lbCwgc28gdGhlcmUgd2lsbCBiZSBubyAibmF0aXZlIiBiYWNrbGlnaHQgZHJpdmVyIGNhdXNp
bmcNCj4gPj4gZHJpdmVycy9hY3BpL3ZpZGVvLWRldGVjdC5jIHRvIHNlbGVjdCBhY3BpX2JhY2ts
aWdodF92aWRlbyBhcyBiYWNrbGlnaHQtDQo+IHR5cGUuDQo+ID4+IGRyaXZlcnMvYWNwaS9hY3Bp
LXZpZGVvLmMgdHJpZXMgdG8gYXZvaWQgcmVnaXN0ZXJpbmcgbm9uLWZ1bmN0aW9uYWwNCj4gPj4g
L3N5cy9jbGFzcy9iYWNrbGlnaHQvYWNwaV92aWRlbyBkZXZpY2VzIGluIGNhc2VzIGxpa2UgdGhp
cywgYnV0IHRoYXQNCj4gZGVwZW5kcw0KPiA+PiBvbiBhIERNSSBjaGFzc2lzLXR5cGUgY2hlY2sg
KHRvIGF2b2lkIHN1cHByZXNzaW5nIHRoZSBiYWNrbGlnaHQgaW50ZXJmYWNlDQo+ID4+IG9uIGxh
cHRvcHMgd2hlcmUgd2UgbGlrZWx5IGRvIHdhbnQgaXQpIGFuZCBtYW55IG9mIHRoZXNlIG1lZGlh
LWJveGVzIC8NCj4gPj4gaGRtaS1zdGlja3MgYXJlIGRlcml2ZWQgZnJvbSBCWVQvQ0hUIHRhYmxl
dCBkZXNpZ25zIGFuZCBvZnRlbiB0aGUgRE1JDQo+ID4+IGNoYXNzaXMgdHlwZSBzdGlsbCBzYXlz
ICJUYWJsZXQiLiBBY3R1YWwgQ2hlcnJ5IFRyYWlsIGRldmljZXMgd2l0aCBhIExDRA0KPiA+PiBw
YW5lbCBhbHdheXMgdXNlIHRoZSBuYXRpdmUgaW50ZWxfYmFja2xpZ2h0IGludGVyZmFjZSwgYnV0
IEkgZ3Vlc3Mgc29tZQ0KPiA+PiBCcmFzd2VsbCBiYXNlZCBkZXZpY2VzIG1pZ2h0IHVzZSB0aGUg
YWNwaV92aWRlbyBpbnRlcmZhY2UuDQo+ID4NCj4gPiBNYXliZSBhIGZ1bmN0aW9uIHRvIGxvb2sg
YXQgc3BlY2lmaWNhbGx5IHRoZSBETUkgY2hhc3NpcyB0eXBlIG9mICJUYWJsZXQiDQo+IGFuZA0K
PiA+IGNoZWNrIGZvciB0aGUgbGFjayBvZiBhbiBpbnRlcm5hbCBMQ0QgcGFuZWwuICBUaGF0IHNl
ZW1zIGxpa2UgZGV0ZWN0aW5nIHRoYXQNCj4gPiBjb21iaW5hdGlvbiBzaG91bGRuJ3QgZXZlciB0
cnkgdG8gcnVuIHRoaXMgY29kZS4NCj4gDQo+IFRoZSBpc3N1ZSBpcyB0aGF0IHdlIGNhbm5vdCBk
ZXRlY3QgdGhlIHByZXNlbmNlIG9mIGEgTENEIHBhbmVsIGZyb20gdGhlDQo+IEFDUEktdmlkZW8g
Y29kZS4gVGhhdCBpcyBkb25lIGJ5IHRoZSBpOTE1IGRyaXZlciAob24gdGhlc2UgZGV2aWNlcykg
YW5kDQo+IHdlIHJlYWxseSBkb24ndCB3YW50IGFueSAobW9yZSkgZGVwZW5kZW5jaWVzIGJldHdl
ZW4gdGhlIGFjcGktdmlkZW8gY29kZQ0KPiBhbmQgdGhlIGk5MTUgY29kZSBhcyB0aG9zZSBhcmUg
dmVyeSBoYXJkIHRvIG1hbmFnZSB3cnQgdGhpbmdzIGxpa2UgdGhlDQo+IHByb2Jpbmcgb3JkZXIu
IEFsc28gdGhlIEFDUEktdmlkZW8gY29kZSBpcyBzdXBwb3NlZCB0byBiZSBwbGF0Zm9ybSBhbmQN
Cj4gZXZlbiBhcmNoaXRlY3R1cmUgaW5kZXBlbmRlbnQuDQo+IA0KPiBSZWdhcmRzLA0KPiANCj4g
SGFucw0KDQo=
