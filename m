Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 806E92862E3
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Oct 2020 17:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbgJGP7N (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 7 Oct 2020 11:59:13 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:27580 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728268AbgJGP7N (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Oct 2020 11:59:13 -0400
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 097FrxaS000549;
        Wed, 7 Oct 2020 11:58:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=J8+xj+oKjqvBUjo9bS4GkMKwG+7P8+UuTcIb6SPJlbs=;
 b=JHNUH6qdwjhB+XYXFIW25yX33o/Hhko7+SEZ9giX8pa1avOtOfmrOCUGOSUiBSDzr4Yt
 4hCoA8LUAseICVv/XOk6eaqcMJH+eIz76NafhayCT+5BDPNM82RKAzlInUIrRu4AsUMW
 n8Ui0J4IzbRiONZZZ80guCy3SGW+Tb/SL12h6H3JHJRwN5afzEaCVX10h1hHjXJIJs4k
 mTM1wCSURzBhzP8xLl7srKUbNXYbi/FzkDBz7C3I5tgTvzqAHjPZYIhQ2JuRLCAD4Dhy
 omqPkR8HSrason56+SybHhZUHTDe6YucR6EG1f3dkKh+/uGt/kpWwEAjniDX73pJP50z IQ== 
Received: from mx0b-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 33y8mcvk12-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Oct 2020 11:58:57 -0400
Received: from pps.filterd (m0090350.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 097FuUaX077138;
        Wed, 7 Oct 2020 11:58:56 -0400
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by mx0b-00154901.pphosted.com with ESMTP id 341fj41fj5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Oct 2020 11:58:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZFz3FUpBqaQUIawnJzTctuEHJlEb1N5EbsBDgd2hTVLqKFm8qBrge/5xWPvMGlt3EFwTZPRkWvtvfXixZJS3P/s4mlUmX/xc9SoUTM8WUmjjFWbzVyloqUngLBPXStbm48l+cHlq9HyvkpCvfB9rTwT8B8E8REmd0jFUQ0PGfCIKzhCUwBnzme2JRUaYD1YmhmOBn9ySiScu7Og8iaYJPEmR+rQstb4HbLnDQlCXjurVFoVNQR+HiLcPXIU9ESVfBJbEzCoIUDaOALp8A0HktXmLU5LK42my41xBVYT0wbNezTn1aoguo9yMKcXfdIx0ShqGMFjJBlHjOiQseI29g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8+xj+oKjqvBUjo9bS4GkMKwG+7P8+UuTcIb6SPJlbs=;
 b=dIymg1c/x8Ya2gvy6j3clExaskR6JnQHsOLpeQSgYeOPKTsrfYip41y01Uk/oeL7Y/U6Vhuk2g/qQWCVF3/9o1enJsy9VraUiUdW2fFBAM+qOfanAEt5BTY6XqlAPdMH/QqNLVuuPzie0IHRJgKaiGlBjppIq6rjD9ybk4lVlxo2l/Xex2AYZSCtPorLzWfb6M4/QLRB6huC0FF+L9OcGMRCS8hgEz5XXjGbicRXAGLkEc72bvHF4XzwH+FemV2oV49OieMrS0TN7b3FBnKAOm8Oi/SpcEfyrPHHuLdYMe60K+FNllHRi7CX6OC92OBT8Ht+siTuKOzOf9ijTmEeXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8+xj+oKjqvBUjo9bS4GkMKwG+7P8+UuTcIb6SPJlbs=;
 b=jOf3Q0WW1UaO506Lo02qRKnOxeJcDJuGHTWvv1HdPMECxWPuyw2LPy1nuj+kDH81xhcNuEx9pA60FqDWhDXoOygTYrqKuhyvxHaTDOq504BbSmlK4CI2PVOhGcU5fGlI1ExgUd2lh5eJSOIt405Fy3/vVnOwHDKZOiVBLYzWg0M=
Received: from DM6PR19MB2636.namprd19.prod.outlook.com (2603:10b6:5:15f::15)
 by DM6PR19MB4245.namprd19.prod.outlook.com (2603:10b6:5:2b1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34; Wed, 7 Oct
 2020 15:58:53 +0000
Received: from DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2]) by DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2%4]) with mapi id 15.20.3455.023; Wed, 7 Oct 2020
 15:58:53 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@dell.com>
To:     Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mgross@linux.intel.com>
CC:     Mark Pearson <mpearson@lenovo.com>,
        Elia Devito <eliadevito@gmail.com>,
        Benjamin Berg <bberg@redhat.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Pearson <markpearson@lenovo.com>
Subject: RE: [RFC] Documentation: Add documentation for new
 performance_profile sysfs class
Thread-Topic: [RFC] Documentation: Add documentation for new
 performance_profile sysfs class
Thread-Index: AQHWmYfgDjG0YI7kc0C9HQeldGcjC6mI+DtAgAMVLYCAAEOvcA==
Date:   Wed, 7 Oct 2020 15:58:52 +0000
Message-ID: <DM6PR19MB26364E6AA2F51981F592CE58FA0A0@DM6PR19MB2636.namprd19.prod.outlook.com>
References: <20201003131938.9426-1-hdegoede@redhat.com>
         <20201003131938.9426-2-hdegoede@redhat.com>
         <DM6PR19MB263669227D122BB7699951E6FA0C0@DM6PR19MB2636.namprd19.prod.outlook.com>
 <85a36eb58cb9774f1907582dfc75295ed847200c.camel@hadess.net>
In-Reply-To: <85a36eb58cb9774f1907582dfc75295ed847200c.camel@hadess.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-10-07T15:58:43.1181391Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=9d612fc6-a438-4c48-b266-2113fd0f594b;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: hadess.net; dkim=none (message not signed)
 header.d=none;hadess.net; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [76.251.167.31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1df7c969-942e-4e7d-fa4f-08d86ad9e386
x-ms-traffictypediagnostic: DM6PR19MB4245:
x-microsoft-antispam-prvs: <DM6PR19MB4245B7B3E0920F9EBCF81461FA0A0@DM6PR19MB4245.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4WDWAHtRSzLKr2F1iqPRTRz9mBa/JB+R9Crhj/D5nJ0b812GsObCSGj+FLSDHifL65MRDjTz2rS2STUeyfv55jKuJBMeSwb+sHTYeOsEYAtYo5rBilbNrCNHsZW3GGqXcQAKSCcvxvBBeJkTZI9DrVGEVspudTAVoPa1zHxMQ50rT12GnWUJ/BrN6+/5j3ZbhfkOwxXPYAGd3zJAlpKjYj/hKjFG8+PMUnEp9ppeJ0JHm3OFp2rbfWKOvlegQBgflWbBZCA8vZsVqduES29c79wr83skCswjT4fhN04dVZtZ39NzYHztZx9ItOgHRGZ1kiTIiDQOIxh+EsmWIvG/VAS0XAbMudZS5ho2OLv4Ac+DwacnPotWczhaysJBIFA8QybPPKA38mL6zuHCTdRYkQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB2636.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(136003)(396003)(366004)(346002)(26005)(52536014)(66446008)(76116006)(786003)(64756008)(316002)(9686003)(66556008)(5660300002)(66946007)(66476007)(6506007)(7416002)(7696005)(478600001)(186003)(86362001)(2906002)(71200400001)(8936002)(33656002)(83080400001)(55016002)(8676002)(4326008)(83380400001)(54906003)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: wyJ5CTuoYOM2X2o+qTX3xxXT2vXP1lr0IcQ4WjykP5JKNhS+Wr/JR48YeIv0VV0BxNt8eiWBzfWHzE/MK/oDfFczg8FSh0Pb+Wf8DW/DQ9otQB+HW/aAD+9LTDuliMY8ckgw7ydXjXZdkWG+52angn9CRsSuJqwiK68yFZ8uVHL0EJoow+B47BDDY6F8aKSRFh9Tt7WFSSgr1Y9XzsRTmLH2hEhriTtX5PWh98TQtAW426ypg4GcxLxOgeYo/cKX/wt7iwBVsQ+oEG6o2En66XQAiudU914gS2No+cpaeBzJoubVF6soYwAV19BQ9V6cZBfXLTlKQMCd7Tpq2OnciUwS7mcjaMEx55X6CUn6fcnt3+AT1wh3vKjkF8MVYYZ1LjCuFTfN0thVcd6VIwcbl3qRqCm0+quMgtbZ0eQ0O81XSE7t+mjLJ0zetlEC683mNegRnqOBEVJbJLx8F4WJ4nbZq/YGbjOlc7Ki0lqwcsGwKYwTuBLQCT8QyjPah6jXfzLSAq+mUdnfQYokd+Zd1aK231pCmVxrSvirxKzjE45FoPumZ5CuXnnvx8PNKVNAQhi2M//he3UefsW2rcggIKsYkLUMk8d3e8Dz/GDlQ1zV1tI3BvRSpZGTq+Ty/vPEeZ3llmV7WnFG8pEg3a6IWA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB2636.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1df7c969-942e-4e7d-fa4f-08d86ad9e386
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2020 15:58:52.9717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1nVxYCcuh3FGn0zBhK7Km8z7YDX73AsD51YBHUpXKk8Ryk8XtpalEps9ry+KIGqafZ5KPGltKkUDDjVdb1oaGgfwXy7k41TphB8OGZSL668=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB4245
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-07_10:2020-10-06,2020-10-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010070100
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010070099
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

IA0KPiBPbiBNb24sIDIwMjAtMTAtMDUgYXQgMTI6NTggKzAwMDAsIExpbW9uY2llbGxvLCBNYXJp
byB3cm90ZToNCj4gPiA+IE9uIG1vZGVybiBzeXN0ZW1zIENQVS9HUFUvLi4uIHBlcmZvcm1hbmNl
IGlzIG9mdGVuIGR5bmFtaWNhbGx5DQo+ID4gPiBjb25maWd1cmFibGUNCj4gPiA+IGluIHRoZSBm
b3JtIG9mIGUuZy4gdmFyaWFibGUgY2xvY2stc3BlZWRzIGFuZCBUUEQuIFRoZSBwZXJmb3JtYW5j
ZQ0KPiA+ID4gaXMgb2Z0ZW4NCj4gPiA+IGF1dG9tYXRpY2FsbHkgYWRqdXN0ZWQgdG8gdGhlIGxv
YWQgYnkgc29tZSBhdXRvbWF0aWMtbWVjaGFuaXNtDQo+ID4gPiAod2hpY2ggbWF5DQo+ID4gPiB2
ZXJ5IHdlbGwgbGl2ZSBvdXRzaWRlIHRoZSBrZXJuZWwpLg0KPiA+ID4NCj4gPiA+IFRoZXNlIGF1
dG8gcGVyZm9ybWFuY2UtYWRqdXN0bWVudCBtZWNoYW5pc21zIG9mdGVuIGNhbiBiZQ0KPiA+ID4g
Y29uZmlndXJlZCB3aXRoDQo+ID4gPiBvbmUgb2Ygc2V2ZXJhbCBwZXJmb3JtYW5jZS1wcm9maWxl
cywgd2l0aCBlaXRoZXIgYSBiaWFzIHRvd2FyZHMNCj4gPiA+IGxvdy1wb3dlcg0KPiA+ID4gY29u
c3VtcHRpb24gKGFuZCBjb29sIGFuZCBxdWlldCkgb3IgdG93YXJkcyBwZXJmb3JtYW5jZSAoYW5k
IGhpZ2hlcg0KPiA+ID4gcG93ZXINCj4gPiA+IGNvbnN1bXB0aW9uIGFuZCB0aGVybWFscykuDQo+
ID4gPg0KPiA+ID4gSW50cm9kdWNlIGEgbmV3IHBlcmZvcm1hbmNlX3Byb2ZpbGUgY2xhc3Mvc3lz
ZnMgQVBJIHdoaWNoIG9mZmVycyBhDQo+ID4gPiBnZW5lcmljDQo+ID4gPiBBUEkgZm9yIHNlbGVj
dGluZyB0aGUgcGVyZm9ybWFuY2UtcHJvZmlsZSBvZiB0aGVzZSBhdXRvbWF0aWMtDQo+ID4gPiBt
ZWNoYW5pc21zLg0KPiA+ID4NCj4gPg0KPiA+IElmIGludHJvZHVjaW5nIGFuIEFQSSBmb3IgdGhp
cyAtIGxldCBtZSBhc2sgdGhlIHF1ZXN0aW9uLCB3aHkgZXZlbiBsZXQgZWFjaA0KPiA+IGRyaXZl
ciBvZmZlciBhIGNsYXNzIGludGVyZmFjZSBhbmQgdXNlcnNwYWNlIG5lZWQgdG8gY2hhbmdlICJl
YWNoIiBkcml2ZXIncw0KPiA+IHBlcmZvcm1hbmNlIHNldHRpbmc/DQo+ID4NCj4gPiBJIHdvdWxk
IHRoaW5rIHRoYXQgeW91IGNvdWxkIGp1c3Qgb2ZmZXIgc29tZXRoaW5nIGtlcm5lbC13aWRlIGxp
a2UNCj4gPiAvc3lzL3Bvd2VyL3BlcmZvcm1hbmNlLXByb2ZpbGUNCj4gPg0KPiA+IFVzZXJzcGFj
ZSBjYW4gcmVhZCBhbmQgd3JpdGUgdG8gYSBzaW5nbGUgZmlsZS7CoCBBbGwgZHJpdmVycyBjYW4g
Z2V0IG5vdGlmaWVkDQo+ID4gb24gdGhpcyBzeXNmcyBmaWxlIGNoYW5naW5nLg0KPiA+DQo+ID4g
VGhlIHN5c3RlbXMgdGhhdCByZWFjdCBpbiBmaXJtd2FyZSAoc3VjaCBhcyB0aGUgdHdvIHRoYXQg
cHJvbXB0ZWQNCj4gPiB0aGlzIGRpc2N1c3Npb24pIGNhbiBjaGFuZ2UgYXQgdGhhdCB0aW1lLsKg
IEl0IGxlYXZlcyB0aGUgcG9zc2liaWxpdHkgZm9yIGENCj4gPiBtb3JlIG9wZW4ga2VybmVsIGlt
cGxlbWVudGF0aW9uIHRoYXQgY2FuIGRvIHRoZSBzYW1lIHRoaW5nIHRob3VnaCB0b28gYnkNCj4g
PiBkaXJlY3RseSBtb2RpZnlpbmcgZGV2aWNlIHJlZ2lzdGVycyBpbnN0ZWFkIG9mIEFDUEkgZGV2
aWNlcy4NCj4gDQo+IFRoZSBwcm9ibGVtLCBhcyBJJ3ZlIG1lbnRpb25lZCBpbiBwcmV2aW91cyBk
aXNjdXNzaW9ucyB3ZSBoYWQgYWJvdXQNCj4gdGhpcywgaXMgdGhhdCwgYXMgeW91J3ZlIHNlZW4g
aW4gcmVwbGllcyB0byB0aGlzIG1haWwsIHRoaXMgd291bGQNCj4gc3VkZGVubHkgYmUgbWFraW5n
IHRoZSBrZXJuZWwgYXBwbHkgcG9saWN5Lg0KPiANCj4gVGhlcmUncyBnb2luZyB0byBiZSBwdXNo
YmFjayBhcyBzb29uIGFzIHBvbGljeSBpcyBlbmFjdGVkIGluIHRoZQ0KPiBrZXJuZWwsIGFuZCB5
b3UgdGFrZSBhd2F5IHRoZSBkaWZmZXJlbnQga25vYnMgZm9yIGluZGl2aWR1YWwgY29tcG9uZW50
cw0KPiAob3IgeW91IGNhbiBjb250cm9sIHRoZW0gY2VudHJhbGx5IGFzIHdlbGwgYXMgaW5kaXZp
ZHVhbGx5KS4gQXMgbXVjaCBhcw0KPiBJIGhhdGUgdGhlIHF1YW50aXR5IG9mIGtub2JzWzFdLCBJ
IGRvbid0IHRoaW5rIHRoYXQgdHJ5aW5nIHRvIHJlZHVjZQ0KPiB0aGUgbnVtYmVyIG9mIGtub2Jz
IGluIHRoZSBrZXJuZWwgaXMgYSBnb29kIHVzZSBvZiBvdXIgdGltZSwgYW5kIGVhc2llcg0KPiB0
byBlbmFjdCwgY29vcmRpbmF0ZWQgd2l0aCBkZXNpZ24gdGFyZ2V0cywgaW4gdXNlci1zcGFjZS4N
Cj4gDQo+IFVubGVzcyB5b3UgY2FuIHRoaW5rIG9mIGEgd2F5IHRvIGltcGxlbWVudCB0aGlzIGtl
cm5lbCB3aWRlIHNldHRpbmcNCj4gd2l0aG91dCBhZGRpbmcgb25lIG1vcmUgZXhwb25lbnQgb24g
dGhlIG51bWJlciBvZiBwb3NzaWJpbGl0aWVzIGZvciB0aGUNCj4gdGVzdGluZyBtYXRyaXgsIEkn
bGwgKzEgSGFucycgb3JpZ2luYWwgQVBJLg0KPiANCkFjdHVhbGx5IEkgb2ZmZXJlZCB0d28gcHJv
cG9zYWxzIGluIG15IHJlcGx5LiAgU28gYXJlIHlvdSBOQUtpbmcgYm90aD8NClRoZSBvdGhlciBv
bmUgc3VnZ2VzdGVkIHRvIHVzZSB0aGUgc2FtZSBmaXJtd2FyZSBhdHRyaWJ1dGVzIGNsYXNzIGJl
aW5nDQppbnRyb2R1Y2VkIGJ5IHRoZSBuZXcgRGVsbCBkcml2ZXIgKGh0dHBzOi8vcGF0Y2h3b3Jr
Lmtlcm5lbC5vcmcvcGF0Y2gvMTE4MTgzNDMvKQ0Kc2luY2UgdGhpcyBpcyBhY3R1YWxseSBhIGtu
b2IgdG8gYSBzcGVjaWZpYyBmaXJtd2FyZSBzZXR0aW5nLg0KDQo=
