Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A34421C591E
	for <lists+linux-acpi@lfdr.de>; Tue,  5 May 2020 16:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730616AbgEEOWL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 May 2020 10:22:11 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:49656 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729273AbgEEOWK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 May 2020 10:22:10 -0400
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 045ELLr8018183;
        Tue, 5 May 2020 10:22:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=eWOVHoHSYT/QSC7PG+jS7XcOu2Fql0o++VnQFqc2pK8=;
 b=WtKfpSDeaZzksTKwESbPgQXGYuJdiTuCzMOnXCd+IYp8auJAIPk6Thhc7mJopchUCx22
 dTSojMRnkT9BYfI5cxbYFP3BMLoly3u4uRPHNBvJSUpb8nM/hHGDfLHQbtxMLvry+iWc
 UEuUWXu+km5sLDbYgeYnwzwD55arVPsNiA4Bgn7PfmyVfGHJf7aufs7K2uJbfEPfW0sU
 9oGOWn1hCH/PQp4QnoHUYusycL2wbGAv++RzvwuzldQ3kJ5pY/sAg3LhvGxuGklskorW
 CdVVNIhHGATqeYqPcioBtVMBxldK86hyhCdB04yD4gy3OiEDnPBj1mwddaNkazi6sKSl 3w== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 30sxjm5f00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 May 2020 10:22:08 -0400
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 045EImwK083861;
        Tue, 5 May 2020 10:22:08 -0400
Received: from ausxippc101.us.dell.com (ausxippc101.us.dell.com [143.166.85.207])
        by mx0b-00154901.pphosted.com with ESMTP id 30s57f0mam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 May 2020 10:22:07 -0400
X-LoopCount0: from 10.166.132.134
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,346,1549951200"; 
   d="scan'208";a="1384622948"
From:   <Mario.Limonciello@dell.com>
To:     <hdegoede@redhat.com>, <dvhart@infradead.org>, <andy@infradead.org>
CC:     <linux-acpi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/5] platform/x86: intel-vbtn: Also handle tablet-mode
 switch on "Detachable" and "Portable" chassis-types
Thread-Topic: [PATCH 4/5] platform/x86: intel-vbtn: Also handle tablet-mode
 switch on "Detachable" and "Portable" chassis-types
Thread-Index: AQHWIK+7lmbxrem4aUOvjmuguWcpP6iYECVggAF69ICAAARSQA==
Date:   Tue, 5 May 2020 14:22:05 +0000
Message-ID: <afe7c366c97f4ab18d5a98a9695ceff6@AUSX13MPC101.AMER.DELL.COM>
References: <20200502182951.114231-1-hdegoede@redhat.com>
 <20200502182951.114231-5-hdegoede@redhat.com>
 <7c3e5f844a224ff780cd8e3b3f5f7641@AUSX13MPC101.AMER.DELL.COM>
 <13a8ec94-1eae-4d95-7238-85c612ebc896@redhat.com>
In-Reply-To: <13a8ec94-1eae-4d95-7238-85c612ebc896@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-05-05T14:22:04.0554298Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=8df0a546-357d-401f-a46c-0c5485e60cac;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.24.10]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-05_08:2020-05-04,2020-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 phishscore=0 clxscore=1015 mlxlogscore=999 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005050116
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005050117
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBwbGF0Zm9ybS1kcml2ZXIteDg2
LW93bmVyQHZnZXIua2VybmVsLm9yZyA8cGxhdGZvcm0tZHJpdmVyLXg4Ni0NCj4gb3duZXJAdmdl
ci5rZXJuZWwub3JnPiBPbiBCZWhhbGYgT2YgSGFucyBkZSBHb2VkZQ0KPiBTZW50OiBUdWVzZGF5
LCBNYXkgNSwgMjAyMCA0OjA2IEFNDQo+IFRvOiBMaW1vbmNpZWxsbywgTWFyaW87IGR2aGFydEBp
bmZyYWRlYWQub3JnOyBhbmR5QGluZnJhZGVhZC5vcmcNCj4gQ2M6IGxpbnV4LWFjcGlAdmdlci5r
ZXJuZWwub3JnOyBwbGF0Zm9ybS1kcml2ZXIteDg2QHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+
IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCA0LzVdIHBsYXRm
b3JtL3g4NjogaW50ZWwtdmJ0bjogQWxzbyBoYW5kbGUgdGFibGV0LW1vZGUNCj4gc3dpdGNoIG9u
ICJEZXRhY2hhYmxlIiBhbmQgIlBvcnRhYmxlIiBjaGFzc2lzLXR5cGVzDQo+IA0KPiANCj4gW0VY
VEVSTkFMIEVNQUlMXQ0KPiANCj4gSGksDQo+IA0KPiBPbiA1LzQvMjAgNTozNyBQTSwgTWFyaW8u
TGltb25jaWVsbG9AZGVsbC5jb20gd3JvdGU6DQo+ID4NCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRoYXQu
Y29tPg0KPiA+PiBTZW50OiBTYXR1cmRheSwgTWF5IDIsIDIwMjAgMTozMCBQTQ0KPiA+PiBUbzog
RGFycmVuIEhhcnQ7IEFuZHkgU2hldmNoZW5rbzsgTGltb25jaWVsbG8sIE1hcmlvDQo+ID4+IENj
OiBIYW5zIGRlIEdvZWRlOyBsaW51eC1hY3BpQHZnZXIua2VybmVsLm9yZzsgcGxhdGZvcm0tZHJp
dmVyLQ0KPiA+PiB4ODZAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnDQo+ID4+IFN1YmplY3Q6IFtQQVRDSCA0LzVdIHBsYXRmb3JtL3g4NjogaW50ZWwtdmJ0bjog
QWxzbyBoYW5kbGUgdGFibGV0LW1vZGUNCj4gc3dpdGNoDQo+ID4+IG9uICJEZXRhY2hhYmxlIiBh
bmQgIlBvcnRhYmxlIiBjaGFzc2lzLXR5cGVzDQo+ID4+DQo+ID4+DQo+ID4+IFtFWFRFUk5BTCBF
TUFJTF0NCj4gPj4NCj4gPj4gQ29tbWl0IGRlOTY0N2VmZWFhOSAoInBsYXRmb3JtL3g4NjogaW50
ZWwtdmJ0bjogT25seSBhY3RpdmF0ZSB0YWJsZXQgbW9kZQ0KPiA+PiBzd2l0Y2ggb24gMi1pbi0x
J3MiKSBhZGRlZCBhIERNSSBjaGFzc2lzLXR5cGUgY2hlY2sgdG8gYXZvaWQgYWNjaWRlbnRhbGx5
DQo+ID4+IHJlcG9ydGluZyBTV19UQUJMRVRfTU9ERSA9IDEgdG8gdXNlcnNwYWNlIG9uIGxhcHRv
cHMuDQo+ID4+DQo+ID4+IFNvbWUgZGV2aWNlcyB3aXRoIGEgZGV0YWNoYWJsZSBrZXlib2FyZCBh
bmQgdXNpbmcgdGhlIGludGVsLXZibnQgKElOVDMzRDYpDQo+ID4+IGludGVyZmFjZSB0byByZXBv
cnQgaWYgdGhleSBhcmUgaW4gdGFibGV0IG1vZGUgKGtleWJvYXJkIGRldGFjaGVkKSBvciBub3Qs
DQo+ID4+IHJlcG9ydCAzMiAvICJEZXRhY2hhYmxlIiBhcyBjaGFzc2lzLXR5cGUsIGUuZy4gdGhl
IEhQIFBhdmlsaW9uIFgyIHNlcmllcy4NCj4gPj4NCj4gPj4gT3RoZXIgZGV2aWNlcyB3aXRoIGEg
ZGV0YWNoYWJsZSBrZXlib2FyZCBhbmQgdXNpbmcgdGhlIGludGVsLXZibnQgKElOVDMzRDYpDQo+
ID4+IGludGVyZmFjZSB0byByZXBvcnQgU1dfVEFCTEVUX01PREUsIHJlcG9ydCA4IC8gIlBvcnRh
YmxlIiBhcyBjaGFzc2lzLXR5cGUuDQo+ID4+IFRoZSBEZWxsIFZlbnVlIDExIFBybyA3MTMwIGlz
IGFuIGV4YW1wbGUgb2YgdGhpcy4NCj4gPj4NCj4gPj4gRXh0ZW5kIHRoZSBETUkgY2hhc3Npcy10
eXBlIGNoZWNrIHRvIGFsc28gYWNjZXB0IFBvcnRhYmxlcyBhbmQgRGV0YWNoYWJsZXMNCj4gPj4g
c28gdGhhdCB0aGUgaW50ZWwtdmJ0biBkcml2ZXIgd2lsbCByZXBvcnQgU1dfVEFCTEVUX01PREUg
b24gdGhlc2UgZGV2aWNlcy4NCj4gPj4NCj4gPj4gTm90ZSB0aGUgY2hhc3Npcy10eXBlIGNoZWNr
IHdhcyBvcmlnaW5hbGx5IGFkZGVkIHRvIGF2b2lkIGEgZmFsc2UtcG9zaXRpdmUNCj4gPj4gdGFi
bGV0LW1vZGUgcmVwb3J0IG9uIHRoZSBEZWxsIFhQUyA5MzYwIGxhcHRvcC4gVG8gdGhlIGJlc3Qg
b2YgbXkga25vd2xlZGdlDQo+ID4+IHRoYXQgbGFwdG9wIGlzIHVzaW5nIGEgY2hhc3Npcy10eXBl
IG9mIDkgLyAiTGFwdG9wIiwgc28gYWZ0ZXIgdGhpcyBjb21taXQNCj4gPj4gd2Ugc3RpbGwgaWdu
b3JlIHRoZSB0YWJsZXQtc3dpdGNoIGZvciB0aGF0IGNoYXNzaXMtdHlwZS4NCj4gPg0KPiA+IFll
cyB0aGF0J3MgY29ycmVjdC4NCj4gPg0KPiA+Pg0KPiA+PiBGaXhlczogZGU5NjQ3ZWZlYWE5ICgi
cGxhdGZvcm0veDg2OiBpbnRlbC12YnRuOiBPbmx5IGFjdGl2YXRlIHRhYmxldCBtb2RlDQo+ID4+
IHN3aXRjaCBvbiAyLWluLTEncyIpDQo+ID4+IFNpZ25lZC1vZmYtYnk6IEhhbnMgZGUgR29lZGUg
PGhkZWdvZWRlQHJlZGhhdC5jb20+DQo+ID4+IC0tLQ0KPiA+PiBMb29raW5nIGF0IHRoZSBNaWNy
b3NvZnQgV2luZG93cyBkb2N1bWVudGF0aW9uIGZvciB0YWJsZXQtbW9kZSByZXBvcnRpbmc6DQo+
ID4+IGh0dHBzOi8vZG9jcy5taWNyb3NvZnQuY29tL2VuLXVzL3dpbmRvd3MtaGFyZHdhcmUvZHJp
dmVycy9ncGlvYnRuL2J1dHRvbi0NCj4gPj4gaW1wbGVtZW50YXRpb24NCj4gPj4NCj4gPj4gVGhl
biB0aGUgcHJlc2VuY2Ugb2YgYSB0YWJsZXQtbW9kZSBzd2l0Y2ggaXMgaW5kaWNhdGVkIGJ5IHRo
ZSBwcmVzZW5jZQ0KPiA+PiBvZiBhIFBOUDBDNjAgY29tcGF0aWJsZSBBQ1BJIGRldmljZXMuIFRo
ZXJlIGFyZSAyIHdheXMgaW4gd2hpY2ggdGhpcyBkZXZpY2UNCj4gPj4gY2FuIHJlcG9ydCB0aGUg
dGFibGV0LW1vZGUuIDEuIERpcmVjdGx5IHByb3ZpZGluZyBhIEdwaW9JbnQgcmVzb3VyY2UgaW5z
aWRlDQo+ID4+IHRoZSBQTlAwQzYwIGRldmljZSwgMi4gVGhyb3VnaCBpbmplY3RpbmcgZXZlbnRz
IGZyb20gYSBXaW5kb3dzIGRyaXZlci4NCj4gPj4NCj4gPj4gSXQgc2VlbXMgdGhhdCB0aGUgaW50
ZWwtdmJ0biAvIHRoZSBJTlQzM0Q2IEFDUEkgZGV2aWNlIGlzIHRoZSBBQ1BJIHNpZGUNCj4gPj4g
b2YgSW50ZWwncyBnZW5lcmljIHNvbHV0aW9uIGZvciB0aGUgY2FzZSB3aGVyZSB0aGUgdGFibGV0
LW1vZGUgY29tZXMgZnJvbQ0KPiA+PiB0aGUgZW1iZWRkZWQtY29udHJvbGxlciBhbmQgbmVlZHMg
dG8gYmUgImluamVjdGVkIi4NCj4gPj4NCj4gPj4gVGhpcyBhbGwgc3VnZ2VzdHMgdGhhdCBpdCBt
aWdodCBiZSBiZXR0ZXIgdG8gcmVwbGFjZSB0aGUgY2hhc3Npcy10eXBlDQo+ID4+IGNoZWNrIHdp
dGggYSBhY3BpX2Rldl9wcmVzZW50KCJQTlAwQzYwIiwgTlVMTCwgLTEpIGNoZWNrLg0KPiA+Pg0K
PiA+PiBNYXJpbywgY2FuIHlvdSBwcm92aWRlIGFuIGFjcGlkdW1wIGFuZCBhbHNhLWluZm8uc2gg
b3V0cHV0IGZvciB0aGUNCj4gPj4gRGVsbCBYUFMgOTM2MCwgc28gdGhhdCBJIGNhbiBjaGVjayBp
ZiB0aGF0IG1pZ2h0IGhlbHAgd2l0aCB0aGUgaXNzdWUNCj4gPj4gdGhlcmUsIGFuZCB0aHVzIGlz
IGEgcG90ZW50aWFsIGNhbmRpZGF0ZSB0byByZXBsYWNlIHRoZSBjaGFzc2lzLXR5cGUNCj4gPj4g
Y2hlY2s/DQo+ID4NCj4gPiBVbmZvcnR1bmF0ZWx5IHdpdGggV0ZIIHJpZ2h0IG5vdywgSSBkb24n
dCBoYXZlIGFjY2VzcyB0byBhIFhQUyA5NjMwIHRvDQo+ID4gZG91YmxlIGNoZWNrIHRoZSBwYXRj
aCBzZXJpZXMuDQo+ID4NCj4gPiBIb3dldmVyIEkgZG8gYWdyZWUgdGhpcyBzaG91bGQgYmUgYSBn
b29kIGFwcHJvYWNoLg0KPiANCj4gT2ssIHNvIGxldHMgc3RpY2sgd2l0aCB0aGUgY2hhc3Npcy10
eXBlIGNoZWNrIChhcyBhbWVuZGVkIGJ5IHRoaXMgcGF0Y2gpDQo+IGZvciBub3cgdGhlbi4gVGhl
biBvbmNlIHlvdSBhcmUgYWJsZSB0byBnbyB0byB5b3VyIG9mZmljZSBhZ2Fpbiwgd2UNCj4gY2Fu
IGV4YW1pbmUgdGhlIGFjcGlfZGV2X3ByZXNlbnQoIlBOUDBDNjAiLCBOVUxMLCAtMSkgYWx0ZXJu
YXRpdmUuDQoNCkkga25vdyBYUFMgMTMncyBhcmUgcHJldHR5IHBvcHVsYXIsIHBlcmhhcHMgc29t
ZW9uZSBvbiB0aGUgbWFpbGluZyBsaXN0IHdobyBoYXMNCm9uZSBjYW4gc2hhcmUgQUNQSSBkdW1w
IGluIHRoZSBpbnRlcmltLg0KDQo+IA0KPiA+IFJldmlld2VkLWJ5OiBNYXJpbyBMaW1vbmNpZWxs
byA8TWFyaW8ubGltb25jaWVsbG9AZGVsbC5jb20+DQo+IA0KPiBUaGFuayB5b3UuDQo+IA0KPiBS
ZWdhcmRzLA0KPiANCj4gSGFucw0KPiANCj4gDQo+IA0KPiANCj4gPj4gLS0tDQo+ID4+ICAgZHJp
dmVycy9wbGF0Zm9ybS94ODYvaW50ZWwtdmJ0bi5jIHwgMTIgKysrKysrKysrKystDQo+ID4+ICAg
MSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPj4NCj4g
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsLXZidG4uYyBiL2RyaXZl
cnMvcGxhdGZvcm0veDg2L2ludGVsLQ0KPiA+PiB2YnRuLmMNCj4gPj4gaW5kZXggNTAwZmFlODJl
MTJjLi40OTIxZmMxNWRjNmMgMTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvcGxhdGZvcm0veDg2
L2ludGVsLXZidG4uYw0KPiA+PiArKysgYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC12YnRu
LmMNCj4gPj4gQEAgLTE1OCwxMiArMTU4LDIyIEBAIHN0YXRpYyB2b2lkIGRldGVjdF90YWJsZXRf
bW9kZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ID4+ICpkZXZpY2UpDQo+ID4+ICAgc3RhdGlj
IGJvb2wgaW50ZWxfdmJ0bl9oYXNfc3dpdGNoZXMoYWNwaV9oYW5kbGUgaGFuZGxlKQ0KPiA+PiAg
IHsNCj4gPj4gICAJY29uc3QgY2hhciAqY2hhc3Npc190eXBlID0gZG1pX2dldF9zeXN0ZW1faW5m
byhETUlfQ0hBU1NJU19UWVBFKTsNCj4gPj4gKwl1bnNpZ25lZCBsb25nIGNoYXNzaXNfdHlwZV9p
bnQ7DQo+ID4+ICAgCXVuc2lnbmVkIGxvbmcgbG9uZyB2Z2JzOw0KPiA+PiAgIAlhY3BpX3N0YXR1
cyBzdGF0dXM7DQo+ID4+DQo+ID4+IC0JaWYgKCEoY2hhc3Npc190eXBlICYmIHN0cmNtcChjaGFz
c2lzX3R5cGUsICIzMSIpID09IDApKQ0KPiA+PiArCWlmIChrc3RydG91bChjaGFzc2lzX3R5cGUs
IDEwLCAmY2hhc3Npc190eXBlX2ludCkpDQo+ID4+ICAgCQlyZXR1cm4gZmFsc2U7DQo+ID4+DQo+
ID4+ICsJc3dpdGNoIChjaGFzc2lzX3R5cGVfaW50KSB7DQo+ID4+ICsJY2FzZSAgODogLyogUG9y
dGFibGUgKi8NCj4gPj4gKwljYXNlIDMxOiAvKiBDb252ZXJ0aWJsZSAqLw0KPiA+PiArCWNhc2Ug
MzI6IC8qIERldGFjaGFibGUgKi8NCj4gPj4gKwkJYnJlYWs7DQo+ID4+ICsJZGVmYXVsdDoNCj4g
Pj4gKwkJcmV0dXJuIGZhbHNlOw0KPiA+PiArCX0NCj4gPj4gKw0KPiA+PiAgIAlzdGF0dXMgPSBh
Y3BpX2V2YWx1YXRlX2ludGVnZXIoaGFuZGxlLCAiVkdCUyIsIE5VTEwsICZ2Z2JzKTsNCj4gPj4g
ICAJcmV0dXJuIEFDUElfU1VDQ0VTUyhzdGF0dXMpOw0KPiA+PiAgIH0NCj4gPj4gLS0NCj4gPj4g
Mi4yNi4wDQo+ID4NCg0K
