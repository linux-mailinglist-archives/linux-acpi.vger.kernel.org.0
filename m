Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF20F304C98
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Jan 2021 23:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730270AbhAZWst (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Jan 2021 17:48:49 -0500
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:28722 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391293AbhAZRiN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 26 Jan 2021 12:38:13 -0500
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10QHSNeH002769;
        Tue, 26 Jan 2021 12:37:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=0Xv3fCh1j0q0kKmDHpvs9L7VBajJl0FseKxcpkuTmT8=;
 b=f9iP9mrr2VLl0ZhJ4jm96ZvZQKowIxYFn3vXmjX9K+S/ascGV67Yaik9aO6pW37Zrxkr
 5weELboXyuWKfvKt/L7582Ybzhr6EfniAceoXp+wuSLNJ0NjAjzXFUQOsF4YQqducNUr
 zK1SAoiZ3DmkG2cSVO5xsXXk+Yeg8RsuU7HalUNjpFwCNlVatG+9Loaf1JKidHXhv0Na
 P4UyIOENcJq2nx/l0VUW1udXrvVo0gl4QD1epfjp/vSXBiJM/nRcSANQb053nXQoiuE7
 RFZyBCkP1ampU67gtHmg1CPLWkZrYNynYrUvRD4h497FLriqBTCdkDNUJmqsH5mTYVC4 jQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 368gh39bsb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Jan 2021 12:37:17 -0500
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10QHZor1095919;
        Tue, 26 Jan 2021 12:37:16 -0500
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2059.outbound.protection.outlook.com [104.47.36.59])
        by mx0a-00154901.pphosted.com with ESMTP id 3691hjdew7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jan 2021 12:37:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Af4Xywc/icJX5XlxekccuQzRH3RCzRFCEwlat1UlZZuIeWBgm0k8akepzDHaIMVE5IUxr8Kvm46VDkvpJRJY4H6JSVouD39dJWzIoU9xzEejHKpbQvbUkraLtGrvnJit6l4PfMDZkWF2DVrV4iELbX4r/inwYF1KM8CG/ofHWGxIIjbC0uVf76iVYhFBgKR+aVTaN1qa0caLmUn5Ei56wcaV6Ss2mH1hTl9ZdFZdfXM4Ad+TkFIKTzR5wuURLJ+C7S7nQb69WotiE5Yf8Xs0+skmgy2U6bDIIe2FneT4DOJhLNdXcLmEMyn4NSaJ5jNfEkSa045uPhvA5Ut7Fn9CGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Xv3fCh1j0q0kKmDHpvs9L7VBajJl0FseKxcpkuTmT8=;
 b=LZVtnNb6oj7HoMbqKAnnrPW7HviYCqNZqW4oc0hCkVqL9/KqzWvSUfAH5yLLNcNnoNbjEEy+EAKw8mfNX0hendww+doJ1JVnkUBvGL0SZMTaNjEd5aC0jCQGsSx4Fymc2m2M+hJyAZhUe1OsQ/qyb8T3xqXqy2Pv5+Q1h01OLBRcSM89fBnIjzTzFyNJeLQcdZfqGjOah/gvkVEnSoj3SA/UsJyokm8lCOsch+cJ+g+Y0DUtuPtac/bSn7hOc4x7DFr6iy4pGR60QHfbvJuXu5dVzGr9jPBAvwHeUFb2C4xeI6fg0N8pqByceN9gButyObbL51UCDJKXrexyVRDz3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SA1PR19MB4926.namprd19.prod.outlook.com (2603:10b6:806:1a6::18)
 by SN6PR1901MB4655.namprd19.prod.outlook.com (2603:10b6:805:9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Tue, 26 Jan
 2021 17:37:14 +0000
Received: from SA1PR19MB4926.namprd19.prod.outlook.com
 ([fe80::1c92:24d3:b11f:bc50]) by SA1PR19MB4926.namprd19.prod.outlook.com
 ([fe80::1c92:24d3:b11f:bc50%6]) with mapi id 15.20.3784.019; Tue, 26 Jan 2021
 17:37:14 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@dell.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Christian Kellner <christian@kellner.me>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH 4/6] ACPI: Execute platform _OSC also with query bit clear
Thread-Topic: [PATCH 4/6] ACPI: Execute platform _OSC also with query bit
 clear
Thread-Index: AQHW8/v1cKWMHTpccUeXj8TT66BRyqo6J0wAgAACgWA=
Date:   Tue, 26 Jan 2021 17:37:14 +0000
Message-ID: <SA1PR19MB4926907D028D3F924FF42A36FABC9@SA1PR19MB4926.namprd19.prod.outlook.com>
References: <20210126155723.9388-1-mika.westerberg@linux.intel.com>
 <20210126155723.9388-5-mika.westerberg@linux.intel.com>
 <CAJZ5v0i+wCOFZOhyx6i=TUGMeWyQR4vXzDN06G6xheFwC66Tuw@mail.gmail.com>
In-Reply-To: <CAJZ5v0i+wCOFZOhyx6i=TUGMeWyQR4vXzDN06G6xheFwC66Tuw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-01-26T17:37:08.6172760Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=026bc557-2a9b-4aa6-a8a2-5ba8115a7391;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [76.251.167.31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17b048f8-a2af-4ee7-4f8f-08d8c22104d3
x-ms-traffictypediagnostic: SN6PR1901MB4655:
x-microsoft-antispam-prvs: <SN6PR1901MB4655FC6F806181BF77291FD5FABC9@SN6PR1901MB4655.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B6iQnz9LtZjsoQgeQ9Excp7Gft067d9+YleB5BaxaS8bQFbwOI3iivhnMniyNszwm6kLWyZqlQMwQ9fN2vMNWFUX2unLFuXbwE9DQEGHu380JC6SCGn6LCGKEOW0hDRIbTi7zt5qBZnsvJC7fTjsTuflBY/DZBOvQWNxehe3LD6xUdcDjtpSK+qQLqgEgg+WNoVe0y8lbvolzj0uRCJwHqTwpTeolfEo919w1g4EpHSfEJqNpMFEEF7LuCHfwbMmwmRlnODeVYNqwWgEQ2uYwY7IuK4iy9S09lkfmUlJRbra7yh8b6WbF3QZ2N8Ed2gGXS8zCm+d9beitCvTLZ/bKrVGGI2Zvw38eS6YG2XuDCYC5EkOzgHmzaeZI2X/a9Ceqh4KdlZi9P4SFhbJVWgSjA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR19MB4926.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(136003)(366004)(376002)(2906002)(83380400001)(7416002)(8676002)(86362001)(33656002)(786003)(71200400001)(52536014)(478600001)(7696005)(316002)(26005)(186003)(110136005)(66946007)(5660300002)(76116006)(6506007)(66446008)(53546011)(54906003)(8936002)(9686003)(55016002)(64756008)(66556008)(4326008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?aEFZM05tbGYzbW5lN1NPQWV0SEZESFowYjcrQ24zaUgyU1ZYMm0rR2YrbHE5?=
 =?utf-8?B?WG5ING00cm5MREptYkU0WkJRbUNITzJRQm9pckRkRnMxcldMUHROWk1oZTUx?=
 =?utf-8?B?STRpRngyLzZid1VvSk1qV1pPb1g0NjFvU3FrVjZ4WFRsNm5OOXNTeW9GaTVQ?=
 =?utf-8?B?NmpKNXQySERIWE00R0hGTFVKRmpWQkFRajNhNTRpOERXV2Z6dm9SbWdOdm94?=
 =?utf-8?B?ZlNpUGIxTktDbExUMnB5aW9nS3pMNFcxQ3ZWZkE1alpTQllJaWZJZmhXWkw1?=
 =?utf-8?B?dnJ2dnlxQ0xCM0lJOUtMU2JsalE4NXhMSFQwaW9Jb01RTUFaNmtVaUdoeVRC?=
 =?utf-8?B?N01BRkp4bWdjK1ozbS96cHpiNTlzR3orK0U0RTQ5QlVQZjB4Q1ozTVB6VE1M?=
 =?utf-8?B?cjFpeFA1NW5sdUdxYVN1MFhqS0pOZEZKRzBjUE04MjBMR0QvMkovWm5MVHlN?=
 =?utf-8?B?VmVXcE9SL0p0U3drQVZWQi9ES1k0UnU1MFNWU2JqS3c3cjQzRzdVR3hpalV5?=
 =?utf-8?B?cEVjNjljQUhBblpFNGdpc0FjVzBQZ21DekZXTUUyVlFlTXpLVWhNaVBZNUxn?=
 =?utf-8?B?Vm5oc1pIUjVrdjViNnphd1N1dHdvcWNlTWNhTnBXR1VyVzlidW4vRFg2Qk5O?=
 =?utf-8?B?MmdHREh1NFhYVEREVGVsMTB6bzd2dzJOTVVOUVNraEdSenExOVlENjZSdEc2?=
 =?utf-8?B?bFhZNnlTRUxVNURpZm1obTZCQzdqVVMrYUwrM1VBUW1TZ0xQQ0xJYmJmT0dD?=
 =?utf-8?B?RmQ4cVYwZXprRkZSZnkydm1vUlhUQ282dTZsQk81ZEV0V2N5THQ3cFFxUzM5?=
 =?utf-8?B?R1FZS3dDRkI4S1ovVHYyOTdWL1FVTEtkclBPS0MyQUNuWndNdDFEVHYrRXpE?=
 =?utf-8?B?Rk5aOGJ4RHNySWxNdWE2NThWaUdaMHJmNmFVWnJmZWlVM2pteHFlelRoS1pr?=
 =?utf-8?B?bnA0bTcxbTdtQ1FvZDVoOUE0UmhEaTgzSXNPUjBTYjN5SVZoSm1yQVdubEhR?=
 =?utf-8?B?QzJUZENLRHNQTmNNcHpLVWtoZzl6U1ltbXYvWUVEZ0xTanZ6VFhIeGJDVU1j?=
 =?utf-8?B?ZUhOWk1CZ2JWRE1NbzFvcjhacndnbVlJOENTZHl0dWpuTzRlT2VaSWNQYURD?=
 =?utf-8?B?MkZocXhjUmc2QVowQzJhNXkwdjJySWg0TmR2MFVOMHZiTEpKMkdna0ovNWRX?=
 =?utf-8?B?UTdyWmYzdHUycUx4VU94ZlhDM21ReWhRZnpMMnRPbWRtWUtmWG56OU8xLzVM?=
 =?utf-8?B?aGxsSlI1bXYxZXpwd1pQd0lmM1dIRmJQOXAyQXNnSkZmMXJBTDRRUDVydnNP?=
 =?utf-8?B?cFVDUVZnMDNkc2FoZlA5ekVmWWw3b251ZHhTcHJSRElCVkVIYnM3MVlyOHRK?=
 =?utf-8?B?VEdhK1BvdUVRS0lQcDhuenl6QnRMSDVEQ200bXB1NmNPSWMydS9qWmgvTExt?=
 =?utf-8?Q?3FD43N3J?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR19MB4926.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b048f8-a2af-4ee7-4f8f-08d8c22104d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2021 17:37:14.1052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7hixH8rmqlbLV0Ke6Tmg3GtPA8JG9B5zPaAAYFl1KDxd8lTpb5M2QZ3Wv/1oZEwOiK+waHRbifI5EEylbR+4MdSf8MXho3aqmBi5QcW6jjE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1901MB4655
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-26_09:2021-01-26,2021-01-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1011 impostorscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101260091
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101260090
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

PiBPbiBUdWUsIEphbiAyNiwgMjAyMSBhdCA1OjAxIFBNIE1pa2EgV2VzdGVyYmVyZw0KPiA8bWlr
YS53ZXN0ZXJiZXJnQGxpbnV4LmludGVsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBNYXJp
byBMaW1vbmNpZWxsbyA8bWFyaW8ubGltb25jaWVsbG9AZGVsbC5jb20+DQo+ID4NCj4gPiBUaGUg
cGxhdGZvcm0gX09TQyBjYW4gY2hhbmdlIHRoZSBoYXJkd2FyZSBzdGF0ZSB3aGVuIHF1ZXJ5IGJp
dCBpcyBub3QNCj4gPiBzZXQuIEFjY29yZGluZyB0byBBQ1BJIHNwZWMgaXQgaXMgcmVjb21tZW5k
ZWQgdGhhdCB0aGUgT1MgcnVucyBfT1NDIHdpdGgNCj4gPiBxdWVyeSBiaXQgc2V0IHVudGlsIHRo
ZSBwbGF0Zm9ybSBkb2VzIG5vdCBtYXNrIGFueSBvZiB0aGUgY2FwYWJpbGl0aWVzLg0KPiA+IFRo
ZW4gaXQgc2hvdWxkIHJ1biBpdCB3aXRoIHF1ZXJ5IGJpdCBjbGVhciBpbiBvcmRlciB0byBhY3R1
YWxseSBjb21taXQNCj4gPiB0aGUgY2hhbmdlcy4gQXQgdGhlIG1vbWVudCBMaW51eCBvbmx5IHJ1
bnMgdGhlIF9PU0Mgd2l0aCBxdWVyeSBiaXQgc2V0DQo+IA0KPiBBbmQgdGhhdCdzIGJlY2F1c2Ug
dGhlcmUgd2FzIG5vdGhpbmcgaXQgY291bGQgYXNrIHRvIGNvbnRyb2wgdXNpbmcgdGhlDQo+IF9T
QiBzY29wZSBfT1NDLg0KPiANCj4gVG9kYXkgaXQgaXMganVzdCByZXBvcnRpbmcgd2hhdCBmZWF0
dXJlcyBhcmUgc3VwcG9ydGVkIGJ5IGl0Lg0KPiANCj4gSG93ZXZlciwgd2l0aCB0aGUgdXBjb21p
bmcgVVNCNCBDTSBzdXBwb3J0IGl0IG5lZWRzIHRvIGFzayBmb3IgdGhlDQo+IGNvbnRyb2wgb2Yg
dGhhdCBmZWF0dXJlIGFuZCB0aGF0J3Mgd2h5IHRoZSBfU0Igc2NvcGUgX09TQyBzdXBwb3J0DQo+
IG5lZWRzIHRvIGJlIGV4dGVuZGVkLiAgU28gaXQgaXMgbm90IGEgZml4IGZvciBhIGJ1ZyBvciBt
aXNzaW5nIHNwZWMNCj4gY292ZXJhZ2UsIHdoaWNoIHRoaXMgcGFydCBvZiB0aGUgY2hhbmdlbG9n
IGtpbmQgb2YgaW1wbGllcywgaXQncyBqdXN0DQo+IGVuYWJsaW5nIGEgbmV3IGZlYXR1cmUuDQoN
Ck90aGVyIG9wZXJhdGluZyBzeXN0ZW1zIGJlaGF2ZSBhcyBkZXNjcmliZWQgaW4gdGhlIEFDUEkg
c3BlYyBsb25nIGJlZm9yZSBVU0I0IENNDQpzdXBwb3J0IHdhcyBhZGRlZC4gIEFkbWl0dGVkbHkg
dGhpcyBpcyBzZW1hbnRpY3Mgb2Ygd2hldGhlciB0byBjYWxsIGl0DQphICJidWciLCBidXQgc3Bl
Y2lmaWNhbGx5IHRoZSBsYWNrIG9mIHRoaXMgaW4gdGhlIGV4aXN0aW5nIExpbnV4IGtlcm5lbCBj
b2RlDQoqY2FuKiBhY3R1YWxseSBjYXVzZSB5b3UgdG8gZ2V0IGludG8gYSBzaXR1YXRpb24gd2hl
cmUgeW91IGhhdmUgbm8gZnVuY3Rpb25hbA0KVVNCNC4gIFRoaXMgd2lsbCBoYXBwZW4gaWYgeW91
IGJvb3QgYmV0d2VlbiB0d28gZGlmZmVyZW50IGtlcm5lbHMgb3IgcG90ZW50aWFsbHkNCnR3byBk
aWZmZXJlbnQgb3BlcmF0aW5nIHN5c3RlbXMuICBUaGlzIGlzIGR1ZSB0byBob3cgdGhlIHNlbGVj
dGlvbiBvZiBGVyBvciBTVw0KQ00gaXMgbWFkZS4gIElmIHRoaXMgcGF0Y2ggImFsb25lIiB3YXMg
YnJvdWdodCBmdXJ0aGVyIGJhY2t3YXJkIHRoZSBvbGRlciBrZXJuZWxzDQpGVyBDTSBtb2RlIHdv
dWxkIGJlIGFjdGl2YXRlZCBpbiB0aG9zZSBzaXR1YXRpb25zLg0KDQo+IA0KPiA+IGFuZCB0aGlz
IGlzIGdvaW5nIHRvIGNhdXNlIHByb2JsZW1zIHdpdGggdGhlIFVTQjQgQ00gKENvbm5lY3Rpb24N
Cj4gPiBNYW5hZ2VyKSBzd2l0Y2ggdGhhdCBpcyBnb2luZyB0byBjb21taXQgdGhlIHN3aXRjaCBv
bmx5IHdoZW4gdGhlIE9TDQo+ID4gcmVxdWVzdHMgY29udHJvbCBvdmVyIHRoZSBmZWF0dXJlLg0K
PiA+DQo+ID4gRm9yIHRoaXMgcmVhc29uIG1vZGlmeSB0aGUgX09TQyBzdXBwb3J0IHNvIHRoYXQg
d2UgZmlyc3QgZXhlY3V0ZSBpdCB3aXRoDQo+ID4gcXVlcnkgYml0IHNldCwgdGhlbiB1c2UgdGhl
IHJldHVybmVkIHZhbHUgYXMgYmFzZSBvZiB0aGUgZmVhdHVyZXMgd2UNCj4gDQo+IHMvdmFsdS92
YWx1ZS8NCj4gDQo+ID4gd2FudCB0byBjb250cm9sIGFuZCBydW4gdGhlIF9PU0MgYWdhaW4gd2l0
aCBxdWVyeSBiaXQgY2xlYXIuDQo+ID4NCj4gPiBBbHNvIHJlbmFtZSB0aGUgZnVuY3Rpb24gdG8g
YmV0dGVyIG1hdGNoIHdoYXQgaXQgZG9lcy4NCj4gPg0KPiA+IENjOiBSYWZhZWwgSi4gV3lzb2Nr
aSA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogTWFyaW8g
TGltb25jaWVsbG8gPG1hcmlvLmxpbW9uY2llbGxvQGRlbGwuY29tPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IE1pa2EgV2VzdGVyYmVyZyA8bWlrYS53ZXN0ZXJiZXJnQGxpbnV4LmludGVsLmNvbT4NCj4g
Pg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2FjcGkvYnVzLmMgfCA0MyArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzMSBpbnNl
cnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2FjcGkvYnVzLmMgYi9kcml2ZXJzL2FjcGkvYnVzLmMNCj4gPiBpbmRleCAxNjgyZjhiNDU0YTIu
LmNhN2M3YjJiZjU2ZSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2FjcGkvYnVzLmMNCj4gPiAr
KysgYi9kcml2ZXJzL2FjcGkvYnVzLmMNCj4gPiBAQCAtMjgyLDkgKzI4Miw5IEBAIGJvb2wgb3Nj
X3BjX2xwaV9zdXBwb3J0X2NvbmZpcm1lZDsNCj4gPiAgRVhQT1JUX1NZTUJPTF9HUEwob3NjX3Bj
X2xwaV9zdXBwb3J0X2NvbmZpcm1lZCk7DQo+ID4NCj4gPiAgc3RhdGljIHU4IHNiX3V1aWRfc3Ry
W10gPSAiMDgxMUIwNkUtNEEyNy00NEY5LThENjAtM0NCQkMyMkU3QjQ4IjsNCj4gPiAtc3RhdGlj
IHZvaWQgYWNwaV9idXNfb3NjX3N1cHBvcnQodm9pZCkNCj4gPiArc3RhdGljIHZvaWQgYWNwaV9i
dXNfb3NjX25lZ290aWF0ZV9wbGF0Zm9ybV9jb250cm9sKHZvaWQpDQo+ID4gIHsNCj4gPiAtICAg
ICAgIHUzMiBjYXBidWZbMl07DQo+ID4gKyAgICAgICB1MzIgY2FwYnVmWzJdLCAqY2FwYnVmX3Jl
dDsNCj4gPiAgICAgICAgIHN0cnVjdCBhY3BpX29zY19jb250ZXh0IGNvbnRleHQgPSB7DQo+ID4g
ICAgICAgICAgICAgICAgIC51dWlkX3N0ciA9IHNiX3V1aWRfc3RyLA0KPiA+ICAgICAgICAgICAg
ICAgICAucmV2ID0gMSwNCj4gPiBAQCAtMzIxLDE3ICszMjEsMzYgQEAgc3RhdGljIHZvaWQgYWNw
aV9idXNfb3NjX3N1cHBvcnQodm9pZCkNCj4gPiAgICAgICAgICAgICAgICAgY2FwYnVmW09TQ19T
VVBQT1JUX0RXT1JEXSB8PSBPU0NfU0JfQVBFSV9TVVBQT1JUOw0KPiA+ICAgICAgICAgaWYgKEFD
UElfRkFJTFVSRShhY3BpX2dldF9oYW5kbGUoTlVMTCwgIlxcX1NCIiwgJmhhbmRsZSkpKQ0KPiA+
ICAgICAgICAgICAgICAgICByZXR1cm47DQo+ID4gLSAgICAgICBpZiAoQUNQSV9TVUNDRVNTKGFj
cGlfcnVuX29zYyhoYW5kbGUsICZjb250ZXh0KSkpIHsNCj4gPiAtICAgICAgICAgICAgICAgdTMy
ICpjYXBidWZfcmV0ID0gY29udGV4dC5yZXQucG9pbnRlcjsNCj4gPiAtICAgICAgICAgICAgICAg
aWYgKGNvbnRleHQucmV0Lmxlbmd0aCA+IE9TQ19TVVBQT1JUX0RXT1JEKSB7DQo+ID4gLSAgICAg
ICAgICAgICAgICAgICAgICAgb3NjX3NiX2FwZWlfc3VwcG9ydF9hY2tlZCA9DQo+ID4gLSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBjYXBidWZfcmV0W09TQ19TVVBQT1JUX0RXT1JEXSAm
DQo+IE9TQ19TQl9BUEVJX1NVUFBPUlQ7DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgb3Nj
X3BjX2xwaV9zdXBwb3J0X2NvbmZpcm1lZCA9DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBjYXBidWZfcmV0W09TQ19TVVBQT1JUX0RXT1JEXSAmDQo+IE9TQ19TQl9QQ0xQSV9T
VVBQT1JUOw0KPiA+IC0gICAgICAgICAgICAgICB9DQo+ID4gKw0KPiA+ICsgICAgICAgaWYgKEFD
UElfRkFJTFVSRShhY3BpX3J1bl9vc2MoaGFuZGxlLCAmY29udGV4dCkpKQ0KPiA+ICsgICAgICAg
ICAgICAgICByZXR1cm47DQo+ID4gKw0KPiA+ICsgICAgICAgY2FwYnVmX3JldCA9IGNvbnRleHQu
cmV0LnBvaW50ZXI7DQo+ID4gKyAgICAgICBpZiAoY29udGV4dC5yZXQubGVuZ3RoIDw9IE9TQ19T
VVBQT1JUX0RXT1JEKSB7DQo+ID4gICAgICAgICAgICAgICAgIGtmcmVlKGNvbnRleHQucmV0LnBv
aW50ZXIpOw0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm47DQo+ID4gICAgICAgICB9DQo+ID4g
LSAgICAgICAvKiBkbyB3ZSBuZWVkIHRvIGNoZWNrIG90aGVyIHJldHVybmVkIGNhcD8gU291bmRz
IG5vICovDQo+ID4gKw0KPiA+ICsgICAgICAgLyoNCj4gPiArICAgICAgICAqIE5vdyBydW4gX09T
QyBhZ2FpbiB3aXRoIHF1ZXJ5IGZsYWcgY2xlYW4gYW5kIHdpdGggdGhlIGNhcHMNCj4gDQo+IHMv
Y2xlYW4vY2xlYXIvDQo+IA0KPiA+ICsgICAgICAgICogYm90aCBwbGF0Zm9ybSBhbmQgT1Mgc3Vw
cG9ydHMuDQo+IA0KPiBzL2JvdGggcGxhdGZvcm0gYW5kIE9TIHN1cHBvcnRzL3N1cHBvcnRlZCBi
eSBib3RoIHRoZSBPUyBhbmQgdGhlIHBsYXRmb3JtLw0KPiANCj4gPiArICAgICAgICAqLw0KPiA+
ICsgICAgICAgY2FwYnVmW09TQ19RVUVSWV9EV09SRF0gPSAwOw0KPiA+ICsgICAgICAgY2FwYnVm
W09TQ19TVVBQT1JUX0RXT1JEXSA9IGNhcGJ1Zl9yZXRbT1NDX1NVUFBPUlRfRFdPUkRdOw0KPiA+
ICsgICAgICAga2ZyZWUoY29udGV4dC5yZXQucG9pbnRlcik7DQo+ID4gKw0KPiA+ICsgICAgICAg
aWYgKEFDUElfRkFJTFVSRShhY3BpX3J1bl9vc2MoaGFuZGxlLCAmY29udGV4dCkpKQ0KPiA+ICsg
ICAgICAgICAgICAgICByZXR1cm47DQo+ID4gKw0KPiA+ICsgICAgICAgY2FwYnVmX3JldCA9IGNv
bnRleHQucmV0LnBvaW50ZXI7DQo+ID4gKyAgICAgICBpZiAoY29udGV4dC5yZXQubGVuZ3RoID4g
T1NDX1NVUFBPUlRfRFdPUkQpIHsNCj4gPiArICAgICAgICAgICAgICAgb3NjX3NiX2FwZWlfc3Vw
cG9ydF9hY2tlZCA9DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgY2FwYnVmX3JldFtPU0Nf
U1VQUE9SVF9EV09SRF0gJiBPU0NfU0JfQVBFSV9TVVBQT1JUOw0KPiA+ICsgICAgICAgICAgICAg
ICBvc2NfcGNfbHBpX3N1cHBvcnRfY29uZmlybWVkID0NCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICBjYXBidWZfcmV0W09TQ19TVVBQT1JUX0RXT1JEXSAmDQo+IE9TQ19TQl9QQ0xQSV9TVVBQ
T1JUOw0KPiA+ICsgICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAgIGtmcmVlKGNvbnRleHQucmV0
LnBvaW50ZXIpOw0KPiA+ICB9DQo+ID4NCj4gPiAgLyogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IC0tDQo+
ID4gQEAgLTExNjgsNyArMTE4Nyw3IEBAIHN0YXRpYyBpbnQgX19pbml0IGFjcGlfYnVzX2luaXQo
dm9pZCkNCj4gPiAgICAgICAgICAqIF9PU0MgbWV0aG9kIG1heSBleGlzdCBpbiBtb2R1bGUgbGV2
ZWwgY29kZSwNCj4gPiAgICAgICAgICAqIHNvIGl0IG11c3QgYmUgcnVuIGFmdGVyIEFDUElfRlVM
TF9JTklUSUFMSVpBVElPTg0KPiA+ICAgICAgICAgICovDQo+ID4gLSAgICAgICBhY3BpX2J1c19v
c2Nfc3VwcG9ydCgpOw0KPiA+ICsgICAgICAgYWNwaV9idXNfb3NjX25lZ290aWF0ZV9wbGF0Zm9y
bV9jb250cm9sKCk7DQo+ID4NCj4gPiAgICAgICAgIC8qDQo+ID4gICAgICAgICAgKiBfUERDIGNv
bnRyb2wgbWV0aG9kIG1heSBsb2FkIGR5bmFtaWMgU1NEVCB0YWJsZXMsDQo+ID4gLS0NCj4gPiAy
LjI5LjINCj4gPg0K
