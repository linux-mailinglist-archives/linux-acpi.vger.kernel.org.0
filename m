Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC04286791
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Oct 2020 20:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbgJGSll (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 7 Oct 2020 14:41:41 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:4794 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726312AbgJGSlh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Oct 2020 14:41:37 -0400
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 097IReBX022114;
        Wed, 7 Oct 2020 14:41:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=1xh7AHscHwXqsKx3XygzmsMMAFYiDudvXDgPSveIuoM=;
 b=EFR9W52WrDYlbfLemVvt+xBT6rXGtlijOWiMndQOyZwyhD3DjNcd2nutRIzup8nEz3WO
 supujddY2JbHAZxAQKnnDakToav/6/ibHVYqv3tBbAQaqG1qHolZ11ku2Prjoh62N+do
 Lp5FtlXb8cEOeBZeFGOj+JKqGwj273D03QcDdl5E9yWNHvEfodNeGIg83KbhQkKRqWOe
 uJtNkaHCIM28V4iDnYkJ9bqJiw1NFh3fBa9SQbjqvzEol4O98StNFZg77pMNVbtz/oZq
 yCL/J+uaZIGbPtLrQnlSjePTNjNAKDkSB923WF2tY1GZZYfoh90DRm+NPHwE9YkACnSV Uw== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 340phw6fp6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Oct 2020 14:41:25 -0400
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 097IXVhd101629;
        Wed, 7 Oct 2020 14:41:25 -0400
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2055.outbound.protection.outlook.com [104.47.38.55])
        by mx0b-00154901.pphosted.com with ESMTP id 340rkc6hmx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Oct 2020 14:41:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXavKa7dIqvpFMtU6NfSW2sgZ5Z/dWJHF13+91FTYB05rwjZlG1+Ijmx/9O1xENnoKEckHTbdbu7+Wwi51R1bItZHBOV1kAI0aIsqOGHRM8/g9uYpluOdfNhgGTzjbdA1q5fx3fHa+ASeJ4riikSfgpt3VoZSNs9yH1RDZx80OT5GFSUNK/rV8bivcyLpTdP5VMLzfuaHJFdCqwYcsEWkWsiA/YVNRxAJPbPNm1C9XUo0BLs3pym0zGdmmwE6zvR4vhwr68j/jJHRl++D2VnViLkaGZn7AEWPUU52GQlpknu6oItCoIS9D3qte/bAG0avs5PIArH7iOlEiY8ytFQvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xh7AHscHwXqsKx3XygzmsMMAFYiDudvXDgPSveIuoM=;
 b=VCpxQaWFEvGwUHq3iONnBlbxpDj+nIpaw3CrtjLVQi1K5KKxPwu9mubaD75GnPFwfdcaw3hMEAvV59orFpb9QEwSUliVe+JHYYJUcNM+9H+zg+9cphVJ1C2omnZjtAfABNp83pOpL7sKOc/U27MKfth7IHWOTK3hYmUfi1kYv4kRKJU3sWZ8yHKepVFU+yyIafnKmBMxyIeaPSQEUOS7eBpsXTtAdaIp6hH4oR7ELR1hlwbEp8hcwp10s9vgDxbJG9Hfnbd0N1OZ5UT7+Wg4Jtl4EnLzRxeqSCqnYb+0PX9PwmOlhRqmY1fU2yRrWVCu6cfL2oQyV6Jz8qDh6UPPcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xh7AHscHwXqsKx3XygzmsMMAFYiDudvXDgPSveIuoM=;
 b=fk7sUUKxIW/Pzm6o+hPfphKB7OsfnPstf2lhbCPJdTPii04HgOdm2VlFzDqW0XkafKul8Oa85JUQpXDZMW69sBPZYEh/3d2NgGu8KXr/GjiUs1/vJQ/LuMIl4I0QA8VckRbT9bxbwiZt8vQ3y9uAQhvlKsKpvv/+Am7q06ExLEM=
Received: from DM6PR19MB2636.namprd19.prod.outlook.com (2603:10b6:5:15f::15)
 by DM5PR1901MB2183.namprd19.prod.outlook.com (2603:10b6:4:aa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Wed, 7 Oct
 2020 18:41:23 +0000
Received: from DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2]) by DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2%4]) with mapi id 15.20.3455.023; Wed, 7 Oct 2020
 18:41:23 +0000
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
Thread-Index: AQHWmYfgDjG0YI7kc0C9HQeldGcjC6mI+DtAgAMVLYCAAEOvcIAAC2yAgAAeRRA=
Date:   Wed, 7 Oct 2020 18:41:23 +0000
Message-ID: <DM6PR19MB2636B067186B08B744EA2163FA0A0@DM6PR19MB2636.namprd19.prod.outlook.com>
References: <20201003131938.9426-1-hdegoede@redhat.com>
         <20201003131938.9426-2-hdegoede@redhat.com>
         <DM6PR19MB263669227D122BB7699951E6FA0C0@DM6PR19MB2636.namprd19.prod.outlook.com>
         <85a36eb58cb9774f1907582dfc75295ed847200c.camel@hadess.net>
         <DM6PR19MB26364E6AA2F51981F592CE58FA0A0@DM6PR19MB2636.namprd19.prod.outlook.com>
 <c73ffad8fd6bff8ff20d91930b097bff82be1c8f.camel@hadess.net>
In-Reply-To: <c73ffad8fd6bff8ff20d91930b097bff82be1c8f.camel@hadess.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-10-07T18:39:28.6152410Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=e7a272ed-da76-45c4-b7f0-53744d67eebd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: hadess.net; dkim=none (message not signed)
 header.d=none;hadess.net; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [76.251.167.31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5cfa8ed-09da-473b-b222-08d86af0976d
x-ms-traffictypediagnostic: DM5PR1901MB2183:
x-microsoft-antispam-prvs: <DM5PR1901MB21838B3BD16C55360F1BFD61FA0A0@DM5PR1901MB2183.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bL0K/AxX1L8juVydCj9PxGGdp+YvnvtAIdfnF9DjXx2L8jlj3RCqX9zP29c1iF89KGKGz9sWrGLx7LN9Gd9mzeibJ2Jt+treZG4CRtaWtSyyP9xM6N3UvrgjLCRFtuTq/pijjtzEGxPeUIUTr6ITOidgXnrNIOeK9MjSKZ3eC+FKHpa19ODieD3iSpUaA2wBr0db0h4TMQGjwEGDlhDo9vrNwY6qtpWlRPQqU0aT8yAixXe+lflE5fKuKCJScpgS3LfjycvubaRNm6s8fvfmcDSW1UurSpU3Dx1sWn1onBP77Xv7tvCX8axsPxPleCS4eiKIbo7azA7S446sCUynouB2czFrOCjW1m5sZjj2JkcHrQvjQLMTHinRtan+0B4Fsw7gXUJJERdjUjxi7gbyww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB2636.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(366004)(39860400002)(376002)(346002)(66946007)(110136005)(55016002)(76116006)(66556008)(66476007)(64756008)(66446008)(33656002)(5660300002)(4326008)(8936002)(52536014)(7696005)(6506007)(7416002)(186003)(26005)(9686003)(316002)(786003)(83380400001)(478600001)(71200400001)(966005)(2906002)(83080400001)(8676002)(86362001)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: cVIJE1ssOeJy2+SuS46B3gW/MVZkejWZa/WfsAG5wZFaWsE+a9YkeUObtuvq+5pvZ4E0a/rCJuov8hSEUDmGswVx8uzpHO9XowBnSV+MY9776T5I1cpJKagxQDKMjVKpELd+ux6zViksGt3tld7bwCqvrtP/McSLJCTE/44QzjJhBQlHJjRoBejoE9/EUkDT4BsVJOIZjoWhdh0cyt/0dxaXXuKVBuRjW5V16pKZmhWbgpzxjZ+ok64WYzhVNLeMnMorIRbFbJk6UU8bVQtkNng/sEw8a12sTLjcNb2rVE6liy6V7KYQTbCWtdRDowrsWp5fl/DyQffA/CCFjR/J+IveowP0kfq7/Ys7tQoYw//H/7uNvLXuIafJtplU7eOVz2OopouQZ4S3JIGNdyujatcEKJrYcL2ufb6AjP6wM4jsiFFsU31zZ3ONT6FXGVmDPcwdwCEP5Gw/CmvZ9gB4g7e36+QUYsHYYUgen/15Sst50JU6BL6H8hRGzsXWjZE7XmHLOptOAxIwkkH/ICRF95njaMRqJrFxDZq68hB/GsBpLUBZCV+C8yiiab/MPwN8+/PTMkRfG1YCCOjm6okVmRXNm9lfiJgssKuajZbTjLrhChxT6lcI0Qp/G2jSKlAsH293P0J6FJxaUg90XXz4GQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB2636.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5cfa8ed-09da-473b-b222-08d86af0976d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2020 18:41:23.7069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ctggf8HBp4p4cxcNfOKQyfQ/idC/vs9Mf3AFRp5btUjiFGyCp+t1EjqWxGqqM5/0z5vjQ5xmC+xoxIeCNHfE2A7iMRq7plu8a1XoT1a8zV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1901MB2183
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-07_10:2020-10-07,2020-10-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010070118
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 adultscore=0 mlxscore=0 malwarescore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010070118
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

PiBPbiBXZWQsIDIwMjAtMTAtMDcgYXQgMTU6NTggKzAwMDAsIExpbW9uY2llbGxvLCBNYXJpbyB3
cm90ZToNCj4gPg0KPiA+ID4gT24gTW9uLCAyMDIwLTEwLTA1IGF0IDEyOjU4ICswMDAwLCBMaW1v
bmNpZWxsbywgTWFyaW8gd3JvdGU6DQo+ID4gPiA+ID4gT24gbW9kZXJuIHN5c3RlbXMgQ1BVL0dQ
VS8uLi4gcGVyZm9ybWFuY2UgaXMgb2Z0ZW4gZHluYW1pY2FsbHkNCj4gPiA+ID4gPiBjb25maWd1
cmFibGUNCj4gPiA+ID4gPiBpbiB0aGUgZm9ybSBvZiBlLmcuIHZhcmlhYmxlIGNsb2NrLXNwZWVk
cyBhbmQgVFBELiBUaGUNCj4gPiA+ID4gPiBwZXJmb3JtYW5jZQ0KPiA+ID4gPiA+IGlzIG9mdGVu
DQo+ID4gPiA+ID4gYXV0b21hdGljYWxseSBhZGp1c3RlZCB0byB0aGUgbG9hZCBieSBzb21lIGF1
dG9tYXRpYy1tZWNoYW5pc20NCj4gPiA+ID4gPiAod2hpY2ggbWF5DQo+ID4gPiA+ID4gdmVyeSB3
ZWxsIGxpdmUgb3V0c2lkZSB0aGUga2VybmVsKS4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFRoZXNl
IGF1dG8gcGVyZm9ybWFuY2UtYWRqdXN0bWVudCBtZWNoYW5pc21zIG9mdGVuIGNhbiBiZQ0KPiA+
ID4gPiA+IGNvbmZpZ3VyZWQgd2l0aA0KPiA+ID4gPiA+IG9uZSBvZiBzZXZlcmFsIHBlcmZvcm1h
bmNlLXByb2ZpbGVzLCB3aXRoIGVpdGhlciBhIGJpYXMgdG93YXJkcw0KPiA+ID4gPiA+IGxvdy1w
b3dlcg0KPiA+ID4gPiA+IGNvbnN1bXB0aW9uIChhbmQgY29vbCBhbmQgcXVpZXQpIG9yIHRvd2Fy
ZHMgcGVyZm9ybWFuY2UgKGFuZA0KPiA+ID4gPiA+IGhpZ2hlcg0KPiA+ID4gPiA+IHBvd2VyDQo+
ID4gPiA+ID4gY29uc3VtcHRpb24gYW5kIHRoZXJtYWxzKS4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+
IEludHJvZHVjZSBhIG5ldyBwZXJmb3JtYW5jZV9wcm9maWxlIGNsYXNzL3N5c2ZzIEFQSSB3aGlj
aA0KPiA+ID4gPiA+IG9mZmVycyBhDQo+ID4gPiA+ID4gZ2VuZXJpYw0KPiA+ID4gPiA+IEFQSSBm
b3Igc2VsZWN0aW5nIHRoZSBwZXJmb3JtYW5jZS1wcm9maWxlIG9mIHRoZXNlIGF1dG9tYXRpYy0N
Cj4gPiA+ID4gPiBtZWNoYW5pc21zLg0KPiA+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IElmIGlu
dHJvZHVjaW5nIGFuIEFQSSBmb3IgdGhpcyAtIGxldCBtZSBhc2sgdGhlIHF1ZXN0aW9uLCB3aHkN
Cj4gPiA+ID4gZXZlbiBsZXQgZWFjaA0KPiA+ID4gPiBkcml2ZXIgb2ZmZXIgYSBjbGFzcyBpbnRl
cmZhY2UgYW5kIHVzZXJzcGFjZSBuZWVkIHRvIGNoYW5nZQ0KPiA+ID4gPiAiZWFjaCIgZHJpdmVy
J3MNCj4gPiA+ID4gcGVyZm9ybWFuY2Ugc2V0dGluZz8NCj4gPiA+ID4NCj4gPiA+ID4gSSB3b3Vs
ZCB0aGluayB0aGF0IHlvdSBjb3VsZCBqdXN0IG9mZmVyIHNvbWV0aGluZyBrZXJuZWwtd2lkZQ0K
PiA+ID4gPiBsaWtlDQo+ID4gPiA+IC9zeXMvcG93ZXIvcGVyZm9ybWFuY2UtcHJvZmlsZQ0KPiA+
ID4gPg0KPiA+ID4gPiBVc2Vyc3BhY2UgY2FuIHJlYWQgYW5kIHdyaXRlIHRvIGEgc2luZ2xlIGZp
bGUuwqAgQWxsIGRyaXZlcnMgY2FuDQo+ID4gPiA+IGdldCBub3RpZmllZA0KPiA+ID4gPiBvbiB0
aGlzIHN5c2ZzIGZpbGUgY2hhbmdpbmcuDQo+ID4gPiA+DQo+ID4gPiA+IFRoZSBzeXN0ZW1zIHRo
YXQgcmVhY3QgaW4gZmlybXdhcmUgKHN1Y2ggYXMgdGhlIHR3byB0aGF0IHByb21wdGVkDQo+ID4g
PiA+IHRoaXMgZGlzY3Vzc2lvbikgY2FuIGNoYW5nZSBhdCB0aGF0IHRpbWUuwqAgSXQgbGVhdmVz
IHRoZQ0KPiA+ID4gPiBwb3NzaWJpbGl0eSBmb3IgYQ0KPiA+ID4gPiBtb3JlIG9wZW4ga2VybmVs
IGltcGxlbWVudGF0aW9uIHRoYXQgY2FuIGRvIHRoZSBzYW1lIHRoaW5nIHRob3VnaA0KPiA+ID4g
PiB0b28gYnkNCj4gPiA+ID4gZGlyZWN0bHkgbW9kaWZ5aW5nIGRldmljZSByZWdpc3RlcnMgaW5z
dGVhZCBvZiBBQ1BJIGRldmljZXMuDQo+ID4gPg0KPiA+ID4gVGhlIHByb2JsZW0sIGFzIEkndmUg
bWVudGlvbmVkIGluIHByZXZpb3VzIGRpc2N1c3Npb25zIHdlIGhhZCBhYm91dA0KPiA+ID4gdGhp
cywgaXMgdGhhdCwgYXMgeW91J3ZlIHNlZW4gaW4gcmVwbGllcyB0byB0aGlzIG1haWwsIHRoaXMg
d291bGQNCj4gPiA+IHN1ZGRlbmx5IGJlIG1ha2luZyB0aGUga2VybmVsIGFwcGx5IHBvbGljeS4N
Cj4gPiA+DQo+ID4gPiBUaGVyZSdzIGdvaW5nIHRvIGJlIHB1c2hiYWNrIGFzIHNvb24gYXMgcG9s
aWN5IGlzIGVuYWN0ZWQgaW4gdGhlDQo+ID4gPiBrZXJuZWwsIGFuZCB5b3UgdGFrZSBhd2F5IHRo
ZSBkaWZmZXJlbnQga25vYnMgZm9yIGluZGl2aWR1YWwNCj4gPiA+IGNvbXBvbmVudHMNCj4gPiA+
IChvciB5b3UgY2FuIGNvbnRyb2wgdGhlbSBjZW50cmFsbHkgYXMgd2VsbCBhcyBpbmRpdmlkdWFs
bHkpLiBBcw0KPiA+ID4gbXVjaCBhcw0KPiA+ID4gSSBoYXRlIHRoZSBxdWFudGl0eSBvZiBrbm9i
c1sxXSwgSSBkb24ndCB0aGluayB0aGF0IHRyeWluZyB0bw0KPiA+ID4gcmVkdWNlDQo+ID4gPiB0
aGUgbnVtYmVyIG9mIGtub2JzIGluIHRoZSBrZXJuZWwgaXMgYSBnb29kIHVzZSBvZiBvdXIgdGlt
ZSwgYW5kDQo+ID4gPiBlYXNpZXINCj4gPiA+IHRvIGVuYWN0LCBjb29yZGluYXRlZCB3aXRoIGRl
c2lnbiB0YXJnZXRzLCBpbiB1c2VyLXNwYWNlLg0KPiA+ID4NCj4gPiA+IFVubGVzcyB5b3UgY2Fu
IHRoaW5rIG9mIGEgd2F5IHRvIGltcGxlbWVudCB0aGlzIGtlcm5lbCB3aWRlIHNldHRpbmcNCj4g
PiA+IHdpdGhvdXQgYWRkaW5nIG9uZSBtb3JlIGV4cG9uZW50IG9uIHRoZSBudW1iZXIgb2YgcG9z
c2liaWxpdGllcyBmb3INCj4gPiA+IHRoZQ0KPiA+ID4gdGVzdGluZyBtYXRyaXgsIEknbGwgKzEg
SGFucycgb3JpZ2luYWwgQVBJLg0KPiA+ID4NCj4gPiBBY3R1YWxseSBJIG9mZmVyZWQgdHdvIHBy
b3Bvc2FscyBpbiBteSByZXBseS7CoCBTbyBhcmUgeW91IE5BS2luZw0KPiA+IGJvdGg/DQo+IA0K
PiBObywgdGhpcyBpcyBvbmx5IGFib3V0IHRoZSBmaXJzdCBwb3J0aW9uIG9mIHRoZSBlbWFpbCwg
d2hpY2ggSSBxdW90ZWQuDQo+IEFuZCBJJ20gbm90IE5BSydpbmcgaXQsIGJ1dCBJIGRvbid0IHNl
ZSBob3cgaXQgY2FuIHdvcmsgd2l0aG91dCBiZWluZw0KPiBhbnRpdGhldGljYWwgdG8gd2hhdCBr
ZXJuZWwgInVzZXJzIiBleHBlY3QsIG9yIHdoYXQgdGhlIGZvbGtzIGNvbnN1bWluZw0KPiB0aG9z
ZSBpbnRlcmZhY2VzIChwcmVzdW1hYmx5IHVzIGJvdGgpIHdvdWxkIGV4cGVjdCB0byBiZSBhYmxl
IHRvIHRlc3QNCj4gYW5kIG1haW50YWluLg0KPiANCg0KKEp1c3Qgc28gb3RoZXJzIGFyZSBhd2Fy
ZSwgQmFzdGllbiBhbmQgSSBoYWQgYSBwcmV2aW91cyBkaXNjdXNzaW9uIG9uIHRoaXMgdG9waWMN
CnRoYXQgaGUgYWxsdWRlZCB0byBoZXJlOiBodHRwczovL2dpdGxhYi5mcmVlZGVza3RvcC5vcmcv
aGFkZXNzL3Bvd2VyLXByb2ZpbGVzLWRhZW1vbi8tL2lzc3Vlcy8xKQ0KDQpJbiBnZW5lcmFsIEkg
YWdyZWUgdGhhdCB3ZSBzaG91bGRuJ3QgYmUgb2ZmZXJpbmcgMTAwJ3Mgb2Yga25vYnMgdG8gY2hh
bmdlDQp0aGluZ3MgYW5kIHByb3RlY3QgdXNlcnMgZnJvbSB0aGVtc2VsdmVzIHdoZXJlIHBvc3Np
YmxlLg0KDQpXaGV0aGVyIHRoZSBkZWNpc2lvbnMgYXJlIG1hZGUgaW4gdGhlIGtlcm5lbCBvciBp
biB1c2Vyc3BhY2UgeW91IHN0aWxsIGhhdmUgYSBtYXRyaXggb25jZQ0KeW91J3JlIGxldHRpbmcg
c29tZW9uZSBjaGFuZ2UgMiBkaWZmZXJlbnQga2VybmVsIGRldmljZXMgdGhhdCBvZmZlciBwb2xp
Y3kuICBJJ2QgYXJndWUgaXQncw0KYWN0dWFsbHkgd29yc2UgaWYgeW91IGxldCB1c2Vyc3BhY2Ug
Y2hhbmdlIGl0IHRob3VnaC4NCg0KTGV0J3MgZ28gYmFjayB0byB0aGUgbXkgR1BVIGFuZCBwbGF0
Zm9ybSBleGFtcGxlIGFuZCBsZXRzIHNheSBib3RoIG9mZmVyIHRoZSBuZXcga25vYiBoZXJlDQpm
b3IgYm90aC4gIFVzZXJzcGFjZSBzb2Z0d2FyZSBzdWNoIGFzIHlvdXIgUFBEIHBpY2tzIHBlcmZv
cm1hbmNlLiAgQm90aCB0aGUgcGxhdGZvcm0gZGV2aWNlDQphbmQgR1BVIGRldmljZSBnZXQgY2hh
bmdlZCwgaG9wZWZ1bGx5IG5vIGNvbmZsaWN0cy4NClRoZW4gdXNlciBkZWNpZGVzIG5vLCBJIGRv
bid0IHdhbnQgbXkgR1BVIGluIHBlcmZvcm1hbmNlIG1vZGUsIEkgb25seSB3YW50IG15IHBsYXRm
b3JtLg0KU28gdGhleSBjaGFuZ2UgdGhlIGtub2IgZm9yIHRoZSBHUFUgbWFudWFsbHksIGFuZCBu
b3cgeW91IGhhdmUgYSBuZXcgY29uZmlnIGluIHlvdXIgbWF0cml4Lg0KDQpIb3dldmVyIGlmIHlv
dSBsZWZ0IGl0IHRvIGEgc2luZ2xlIGtlcm5lbCBrbm9iLCBib3RoIEdQVSBhbmQgcGxhdGZvcm0g
Z2V0IG1vdmVkIHRvZ2V0aGVyIGFuZA0KeW91IGRvbid0IGhhdmUgdGhlc2UgZXh0cmEgY29uZmln
cyBpbiB5b3VyIG1hdHJpeCBhbnltb3JlLg0KDQpUaGUgb3RoZXIgcG9pbnQgSSBtZW50aW9uZWQs
IHRoYXQgcGxhdGZvcm0gbWlnaHQgYWxzbyBkbyBzb21ldGhpbmcgdG8gR1BVIHZpYSBhIHNpZGVi
YW5kIGFuZA0KeW91IHJhY2UsIHlvdSBjYW4gc29sdmUgaXQgd2l0aCBrZXJuZWwgdG9vIGJ5IG1v
ZGlmeWluZyB0aGUgb3JkZXJpbmcgdGhlIGtlcm5lbCBoYW5kbGVzIGl0Lg0KDQpVc2Vyc3BhY2Ug
aG93ZXZlciwgeW91IGdpdmUgdHdvIGtub2JzIGFuZCBub3cgeW91IGhhdmUgdG8gd29ycnkgYWJv
dXQgdGhlbSBnZXR0aW5nIGl0IHJpZ2h0DQphbmQgc3VwcG9ydGluZyB0aGVtIGRvaW5nIHRoZW0g
aW4gdGhlIHdyb25nIG9yZGVyLg0KDQo+ID4gVGhlIG90aGVyIG9uZSBzdWdnZXN0ZWQgdG8gdXNl
IHRoZSBzYW1lIGZpcm13YXJlIGF0dHJpYnV0ZXMgY2xhc3MNCj4gPiBiZWluZw0KPiA+IGludHJv
ZHVjZWQgYnkgdGhlIG5ldyBEZWxsIGRyaXZlciAoDQo+ID4gaHR0cHM6Ly9wYXRjaHdvcmsua2Vy
bmVsLm9yZy9wYXRjaC8xMTgxODM0My8pDQo+ID4gc2luY2UgdGhpcyBpcyBhY3R1YWxseSBhIGtu
b2IgdG8gYSBzcGVjaWZpYyBmaXJtd2FyZSBzZXR0aW5nLg0KPiANCj4gVGhpcyBzZWVtZWQgdG8g
bWUgbGlrZSBhbiBpbXBsZW1lbnRhdGlvbiBkZXRhaWwgKGVnLiB0aGUgc2FtZSBtZXRhZGF0YQ0K
PiBpcyBiZWluZyBleHBvcnRlZCwgYnV0IGluIGEgZGlmZmVyZW50IHdheSksIGFuZCBJIGRvbid0
IGZlZWwgc3Ryb25nbHkNCj4gYWJvdXQgaXQgZWl0aGVyIHdheS4NCg0KT0sgdGhhbmtzLg0K
