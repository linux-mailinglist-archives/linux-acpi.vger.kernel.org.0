Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9423C283CE7
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Oct 2020 18:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgJEQ4b (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Oct 2020 12:56:31 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:23382 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727107AbgJEQ4b (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Oct 2020 12:56:31 -0400
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 095GbEBD004190;
        Mon, 5 Oct 2020 12:56:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=jVXjh4V7wdKPiysCy8MkG6NgaamZqDqrS5PTPK+6TJE=;
 b=WTPJzKEf2TgGaejJkdiRu9Vof0Cp8Ya85XJlmnKAgW+xgHZlcsnQ97DLgyYZX0rBXqrt
 zwmhzheid8xpNANpvuyqOEew3zmGVXuvY6jlww9SRFHCTZv4rE4lolOZb8x4WUoQCJT4
 MOnWcFA/YCp2m9EGHNbTEwFCtT+LPjSCBusll2Wp55iEyL0aun2LWOPExMOh4+9bmCcP
 vC59sfS3C119vvLtRoYxYHgg7hzFTIBRPK/vv7xcJcxKByw9W1fcBJK0oRAKhJkY1bXw
 scBigAcrEzA1fd91NQQrfzU527KPQFs9tDJc1Lvn3DpcpFcIOO6rDpNH+IGCN1ZAKoQv 7Q== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 33xnyndkek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Oct 2020 12:56:17 -0400
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 095GshL9037986;
        Mon, 5 Oct 2020 12:56:16 -0400
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by mx0b-00154901.pphosted.com with ESMTP id 3406wsrje9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Oct 2020 12:56:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=adqO1rueNSywaJw6vbhKeRcuii+CHV0vhfybl1X/10SJ97rtRp+V9j7VuWIg2dLBTi82p1tXmyQwOczBI3p8tZmQZ5yfKtqOpaIVaZQqeMs6W4eqVGCZtNzTdIPczu0z5OZIMbiFyCBfkUL2TrthQyh1+oJQNPGaTWCmJh4pYvY5gfcMppeyzVLqfuIqK03i5mxxpSR1kgchrqMQdgVRppzmBCBloJh2nZLHiVjY+CNNLEJyMxAX+Am4u2pz7oonX0JmlOJyCeDhGR+607IlBVtYj2MABMdAPeuiApDalHqapnVhzSL/CCrLlp71BY2VJ7BQT8a7hOGXOi1EN5OweA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVXjh4V7wdKPiysCy8MkG6NgaamZqDqrS5PTPK+6TJE=;
 b=BZDetF5egYQvv1Yskl4cF//FAmZCW/mXhJ7JSTpYyuz1tEONUgM+FoqExWEJ6iLdF9g8qm8/8yMYsmtTPKmwPL7WuzKCLJ6J44hFhozuaBm6Vmqrk9/KjiZRYLCaIleUeI6l1Ac1NCijx4SqWAtGCjcFA6ZHm04JfXvkuEeZrraYljm1JIBwfEbrs5FQZQIpCHuobZBhaTiPZ/k6ZGoRDUAF8D2ErIrlb7hBy0czvPWQJRN7Orz7EYgY5cpDCJywMqvsJCi8RSD3boULfZXgY7pIF6FzREPpJ5j1pVMhwuQU5hPDdrUYJTb2j6TDd+gLcJOK68c++Rz9YlHvTRFg9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVXjh4V7wdKPiysCy8MkG6NgaamZqDqrS5PTPK+6TJE=;
 b=KZuxjdzWznAqTxx4qUBp70TMhotUUJ6/SSnFh5Xoa1WfFqM1+U4HrLvW8sgMhdEYHboISiP6UN3TT9+GwNuhVwc1VB+9oUnAIsQYwNudcxEYKrvshP+b/1oOrQh87+yblkDtvvHieGVYvuSQSRMBJsCIEbKCl1Gd6JOtfmEY3vE=
Received: from DM6PR19MB2636.namprd19.prod.outlook.com (2603:10b6:5:15f::15)
 by DM5PR19MB0026.namprd19.prod.outlook.com (2603:10b6:4:6c::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Mon, 5 Oct
 2020 16:56:14 +0000
Received: from DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2]) by DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2%4]) with mapi id 15.20.3433.044; Mon, 5 Oct 2020
 16:56:14 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@dell.com>
To:     Mark Pearson <markpearson@lenovo.com>,
        =?utf-8?B?QmFybmFiw6FzIFDFkWN6ZQ==?= <pobrn@protonmail.com>
CC:     Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mgross@linux.intel.com>,
        Mark Pearson <mpearson@lenovo.com>,
        Elia Devito <eliadevito@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Benjamin Berg <bberg@redhat.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [External] RE: [RFC] Documentation: Add documentation for new
 performance_profile sysfs class
Thread-Topic: [External] RE: [RFC] Documentation: Add documentation for new
 performance_profile sysfs class
Thread-Index: AQHWmYfgDjG0YI7kc0C9HQeldGcjC6mI+DtAgAAZsQCAAB1x8IAADB8AgAAA8LA=
Date:   Mon, 5 Oct 2020 16:56:14 +0000
Message-ID: <DM6PR19MB263622BBE4B699A0AA49977DFA0C0@DM6PR19MB2636.namprd19.prod.outlook.com>
References: <20201003131938.9426-1-hdegoede@redhat.com>
 <20201003131938.9426-2-hdegoede@redhat.com>
 <DM6PR19MB263669227D122BB7699951E6FA0C0@DM6PR19MB2636.namprd19.prod.outlook.com>
 <Mz2G7glm3yMTniKA6SHM011dDkTFF4_otICrMQfVLheopX8JMGSupPleyjyK8OY0tyUazu09nX7XhleBVdl4ozTCWXCPGyvV58Qc-UUTvig=@protonmail.com>
 <DM6PR19MB26369E7468931E63B69A0604FA0C0@DM6PR19MB2636.namprd19.prod.outlook.com>
 <91a9bb74-49e7-0a8d-cbc1-3f1907293fa4@lenovo.com>
In-Reply-To: <91a9bb74-49e7-0a8d-cbc1-3f1907293fa4@lenovo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-10-05T16:56:11.5164540Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=57be8c90-acac-45ee-8a95-7a0a568c7459;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: lenovo.com; dkim=none (message not signed)
 header.d=none;lenovo.com; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [76.251.167.31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 50916d8d-f780-4f31-3178-08d8694f9236
x-ms-traffictypediagnostic: DM5PR19MB0026:
x-microsoft-antispam-prvs: <DM5PR19MB00266E84626FE718A503D94DFA0C0@DM5PR19MB0026.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 82W40ybdjrZ8HTX/sV2w2KPA8exDK+gU/uICNPhICFeOZ5rSpSs2TLEmpnUhQwpBcUupYlmPSyTRrid4878NhfVaovSCE7TcSc9IOr8CvoisY7KABrRNLLWsR+EMFmbtkuPiwGVLhLomWDwZ1objNarIIDKF9umJ6uHdufMAThIoleh+t4or4wL+aSq7QtEAA3PNeXZC7DeYX1ufArGi900SseqrSVeOPuJkaLuV0lzqZq7mMip8cO5vbuJHtZbG5wyZeMu8M/yZwyQeDVw+t4Zi9TZAD+0tcSIeydfDJpD+8qAEzvh1FUi2+Dgd2dS2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB2636.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(396003)(366004)(376002)(136003)(33656002)(52536014)(7696005)(5660300002)(7416002)(8936002)(186003)(316002)(786003)(4326008)(66946007)(66476007)(64756008)(66446008)(478600001)(2906002)(8676002)(66556008)(83380400001)(76116006)(110136005)(9686003)(55016002)(86362001)(54906003)(53546011)(6506007)(71200400001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: gjdC6YKcnfYP8du6COF5+SJ1p/RE2CYfWa9Han50Vir4JMOivR1ShjflJ8mp5R/r6qhm/PVXJe7llX36R3jZ4kJn6aMsMikbtFLHdXoDMVaIofHW4WofiT0YMCsYPe06CNOz2Y2QlH/dl/ByVUL2Ur7Bwzg89aQMvaiw6oSVnlpYwLuyLsxsoIS+2ZmDoZUARZ87IjCuUVQ7YCwv7pt+of4iw1xDgxsgu5esVRBc4u4Z31ZAz3+yrmV8lhjYs4V/byKAvWsg5HjgVuUa6mgMM/gKQmgqHvRkhZ6itatvo71spST0clJSEFpEYdzYplg/sB8w6dYlryKGqfctHKvzmZl1IUsAAOI9cpBB9/a2c2Ly6M8KMJHUa0vF7u0uFDoZ8HwHwhSE24thEaF2zOVrWHU/3b+WQVKBDFMixL8jFqnu0OuL6tL7TlHJU1jSzKWG0bMj+bN/VH6AdlZyZ+/w4wmba/pvuCkytlRR9TUMrGkEN1u0UFfu3pbHXfFPw3NSeF4zr+eXwvKk08hGSz5ZsIxzuvo29r8DgG5fQA7YkmAPwYM2Qkrt1e90zmikXwmnw243Wv1goXIyDg4c7Nu4wPGtREcssvT76OnBY4EhUmYqfyuOi6EJyP1CjzoTitbUqIFMuPmlqz7MTmX7+UtPeA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB2636.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50916d8d-f780-4f31-3178-08d8694f9236
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2020 16:56:14.7384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8nqLYD3g/GBssFj5dHMzssMTdxLiMYzOI9VApvWsfET+3ysTG1X0Z9R5u0WLobrzCc/AM5z5fwGu4wcbsDMeuZqvcBzU1kO/PheK2eShSqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR19MB0026
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-05_12:2020-10-05,2020-10-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 spamscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 mlxlogscore=627
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010050124
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 mlxlogscore=734 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010050122
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

PiBPbiAyMDIwLTEwLTA1IDEyOjExIHAubS4sIExpbW9uY2llbGxvLCBNYXJpbyB3cm90ZToNCj4g
Pj4NCj4gPj4gRXhjdXNlIG15IGlnbm9yYW5jZSwgYnV0IEkgZG9uJ3QgcmVhbGx5IHNlZSB3aHkg
dGhpcyBpbnRlcmZhY2Ugd291bGQgYmUNCj4gdGllZA0KPiA+PiB0bw0KPiA+PiBBQ1BJIGRldmlj
ZXM/IFdoeSBpcyBpdCBub3QgcG9zc2libGUgdG8gd3JpdGUgYSBkcml2ZXIgdGhhdCBpbXBsZW1l
bnRzIHRoaXMNCj4gPj4gaW50ZXJmYWNlDQo+ID4+IGFuZCBkaXJlY3RseSBtb2RpZmllcyBkZXZp
Y2UgcmVnaXN0ZXJzPyBBbSBJIG1pc3Npbmcgc29tZXRoaW5nIG9idmlvdXMNCj4gaGVyZT8NCj4g
Pj4NCj4gPg0KPiA+IFdoZW4gaW1wbGVtZW50ZWQgZm9yIHRoZSB0d28gdmVuZG9ycyBtZW50aW9u
ZWQgaGVyZSwgaXQgd291bGQgYmUgdXNpbmcgYQ0KPiA+IHByb3ByaWV0YXJ5ICJmaXJtd2FyZSBB
UEkiIGltcGxlbWVudGVkIGJ5IHRob3NlIHR3byB2ZW5kb3JzLiAgRm9yIGV4YW1wbGUNCj4gd3Jp
dGUNCj4gPiBhcmd1bWVudHMgKDB4MSwgMHgyKSB0byBBQ1BJLVdNSSBtZXRob2QgV01GVCBhbmQg
aXQgd2lsbCBjYXVzZSBmaXJtd2FyZSB0bw0KPiBjb29yZGluYXRlDQo+ID4gdXNpbmcgdW5kaXNj
bG9zZWQgcHJvdG9jb2wgdG8gYWZmZWN0IHRoZSBwbGF0Zm9ybSBjaGFuZ2VzIGRlc2lyYWJsZS4N
Cj4gPg0KPiA+IFRoaXMgaXMgZGlmZmVyZW50IGluIG15IG1pbmQgZnJvbSAia2VybmVsIHdyaXRl
cyB0byBhIHNwZWNpZmljIHJlZ2lzdGVyIiB0bw0KPiBzZXQNCj4gPiBwb3dlciBwcm9wZXJ0aWVz
IG9mIGEgc3BlY2lmaWMgZGV2aWNlLg0KPiA+DQo+IA0KPiBKdXN0IGN1cmlvdXMgb24gdGhpcyBw
b2ludCAtIGlzbid0IHRoYXQgKG1vc3RseSkgd2hhdCBhbGwgaGFyZHdhcmUgZG9lcz8NCj4gWW91
IHdyaXRlIHRvIGl0IGFuZCB0aGUgZGV2aWNlIGRvZXMgInN0dWZmIiB0byBhY2hpZXZlIHRoZSBy
ZXF1aXJlZA0KPiBlZmZlY3QuIFllcyB0aGlzIGlzIGluIHByb3ByaWV0YXJ5IGZpcm13YXJlLCBi
dXQgZnJvbSBteSBleHBlcmllbmNlIHdpdGgNCj4gaGFyZHdhcmUgZGV2aWNlcyB0aGF0J3Mgbm90
IHVuY29tbW9uIHRoZXNlIGRheXMgYW55d2F5Lg0KPiANCg0KWWVzIEkgYWdyZWUuICBFdmVuICJy
ZWdpc3RlciIgd3JpdGVzIHRvIGEgZGV2aWNlIGFyZSBhY3R1YWxseSBhbiBBUEkgYW5kDQpzb21l
dGhpbmcgaW4gdGhlIGhhcmR3YXJlIG1vbml0b3JzIHRob3NlIHJlZ2lzdGVycyBhbmQgZG9lcyBz
b21ldGhpbmcgYXMgYQ0KcmVzdWx0Lg0KDQo+IExldCBtZSBrbm93IGlmIEknbSBtaXN1bmRlcnN0
YW5kaW5nIHNvbWV0aGluZyBoZXJlLiBJIGNvdWxkbid0IHNlZSB0aGUNCj4gZGlmZmVyZW5jZSBi
ZXR3ZWVuIGEgcmVnaXN0ZXIgd3JpdHRlbiB0byB2aWEgQUNQSSBhbmQgb25lIHdyaXR0ZW4gdG8g
dmlhDQo+IHNvbWUgb3RoZXIgcHJvdG9jb2wgKFNNQlVTPyBvciB3aGF0ZXZlcikNCj4gDQo+IE1h
cmsNCj4gDQoNClRoZSByZWFzb24gSSdtIGNhbGxpbmcgb3V0IGEgZGlzdGluY3Rpb24gaGVyZSBp
cyB0aGF0ICJwbGF0Zm9ybSIgYW5kICJkZXZpY2UiDQpjYW4gY292ZXIgYSBsb3QgbW9yZSB0aGlu
Z3MuICBJbiB0aGlzIGNhc2UgaXQncyBhbiBBUEkgcHJvdmlkZWQgYnkgdGhlIHBsYXRmb3JtJ3MN
CmZpcm13YXJlLCBub3QgYW4gaW5kaXZpZHVhbCBkZXZpY2UncyBmaXJtd2FyZS4gIFNvIHlvdSBj
YW4ndCBhY3R1YWxseSBndWFyYW50ZWUNCndoYXQgdGhlIHBsYXRmb3JtJ3MgZmlybXdhcmUgZGlk
LiAgSXQgY291bGQgaGF2ZSBzZW50IGFueSBudW1iZXIgb2Ygc2lkZWJhbmQNCmNvbW1hbmRzIHRv
IGRldmljZXMgdGhhdCBpdCBjb250cm9scy4gIFRoZSAicGxhdGZvcm0iIGNvdWxkIGhhdmUgcG90
ZW50aWFsbHkNCnRvbGQgdGhlIEdQVSB0byB0dXJuIHVwIGl0cyBmYW5zLCBvciBsb3dlciBpdCdz
IGNsb2NrIGFzIGEgcmVzdWx0IG9mIHRoaXMsIGJ1dCB5b3UNCmNhbid0IHBvc3NpYmx5IGtub3cu
DQoNCkhvd2V2ZXIgaWYgd2UgZ28gdGhlIEdQVSBleGFtcGxlIGFsb25lLCBpdCdzIGEgc3BlY2lm
aWMgc2luZ2xlIGRldmljZSB5b3UncmUNCmNvbnRyb2xsaW5nLiAgWW91IHB1dCB0aGUgR1BVIGlu
dG8gdGhlIGNoYXJhY3Rlcml6YXRpb24gdGhhdCB5b3UgZXhwZWN0ZWQgYW5kIGl0DQpvcGVyYXRl
cyB0aGF0IHdheS4NCg==
