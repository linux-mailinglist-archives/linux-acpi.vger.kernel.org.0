Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 936511F5DB1
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jun 2020 23:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgFJV2m (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Jun 2020 17:28:42 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:31628 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726277AbgFJV2l (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 10 Jun 2020 17:28:41 -0400
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05ALQdJl003820;
        Wed, 10 Jun 2020 17:28:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=6grmnVb/zeUszFLov+H/q6yUUb8OVl9uFf62tln/WJc=;
 b=eJn/QtPQxg0OEWJEOhCpMTwCPHYNFwMfD3lyRxf415WUpoRb1Z2E7S52cjgoxDr1hBFy
 hc+reFHVTuqD2CcxgVs5oxrj98HS2WUcSW6xuMe1iiEYrpPVwKzRZB4CmK0fC/vyrGJT
 NC9KNM/F571H16lnDWz2yBfXEOanSjQxABhljHxDO6ws+rwQSB6svfzXG/1Sr0V0Fyu2
 LHdsA7SHRv++3vyM7ld7UvspMxFHjD3Y0u0Edb4O0TKmOKeXOVh6ksDAMry1dOwdyX4K
 tEHM8jePKt2UoIy2chShw1AvxjMt7GucvhuGXLFHtEomZvZEzMvzmcoT3CboPZoKOnG9 ZA== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 31jjr04jaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Jun 2020 17:28:40 -0400
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05AL8ChR150510;
        Wed, 10 Jun 2020 17:28:39 -0400
Received: from ausc60ps301.us.dell.com (ausc60ps301.us.dell.com [143.166.148.206])
        by mx0a-00154901.pphosted.com with ESMTP id 31k6fq8rt6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Jun 2020 17:28:39 -0400
X-LoopCount0: from 10.166.132.129
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="1451263206"
From:   <Mario.Limonciello@dell.com>
To:     <enric.balletbo@collabora.com>, <rjw@rjwysocki.net>
CC:     <rafael@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <lenb@kernel.org>,
        <kernel@collabora.com>, <groeck@chromium.org>,
        <bleung@chromium.org>, <dtor@chromium.org>, <gwendal@chromium.org>,
        <vbendeb@chromium.org>, <andy@infradead.org>,
        <ayman.bagabas@gmail.com>, <benjamin.tissoires@redhat.com>,
        <blaz@mxxn.io>, <dvhart@infradead.org>,
        <dmitry.torokhov@gmail.com>, <gregkh@linuxfoundation.org>,
        <hdegoede@redhat.com>, <jeremy@system76.com>, <2pi@mok.nu>,
        <mchehab+samsung@kernel.org>, <rajatja@google.com>,
        <srinivas.pandruvada@linux.intel.com>,
        <platform-driver-x86@vger.kernel.org>
Subject: RE: [PATCH v4] platform: x86: Add ACPI driver for ChromeOS
Thread-Topic: [PATCH v4] platform: x86: Add ACPI driver for ChromeOS
Thread-Index: AQHWEZn1ic1J55wnDUCcmSeyJR9LmKh32IiAgFJaEOiACNhPAP//rP0A
Date:   Wed, 10 Jun 2020 21:28:36 +0000
Message-ID: <59771d3689da41a5bbc67541aa6f4777@AUSX13MPC105.AMER.DELL.COM>
References: <20200413134611.478441-1-enric.balletbo@collabora.com>
 <CAJZ5v0gWZ27_DwWQadsJOUxLo4a0rAMe45d4AWXS2gHJZfgfKg@mail.gmail.com>
 <a2953d50-da22-279a-f1e4-faa796d815b1@collabora.com>
 <10490419.gsntqH5CaE@kreacher>
 <4e7f8bf3-b72b-d418-ec95-e1f8c3d61261@collabora.com>
In-Reply-To: <4e7f8bf3-b72b-d418-ec95-e1f8c3d61261@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-06-10T21:28:35.5441118Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=07420e5e-fc6b-4053-8350-7b39d4d844d2;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.24.60]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-10_13:2020-06-10,2020-06-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 adultscore=0
 malwarescore=0 cotscore=-2147483648 mlxlogscore=999 spamscore=0
 phishscore=0 priorityscore=1501 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006100155
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 spamscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006100156
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogcGxhdGZvcm0tZHJpdmVy
LXg4Ni1vd25lckB2Z2VyLmtlcm5lbC5vcmcgPHBsYXRmb3JtLWRyaXZlci14ODYtDQo+IG93bmVy
QHZnZXIua2VybmVsLm9yZz4gT24gQmVoYWxmIE9mIEVucmljIEJhbGxldGJvIGkgU2VycmENCj4g
U2VudDogV2VkbmVzZGF5LCBKdW5lIDEwLCAyMDIwIDQ6MjIgUE0NCj4gVG86IFJhZmFlbCBKLiBX
eXNvY2tpDQo+IENjOiBSYWZhZWwgSi4gV3lzb2NraTsgTGludXggS2VybmVsIE1haWxpbmcgTGlz
dDsgQUNQSSBEZXZlbCBNYWxpbmcgTGlzdDsNCj4gTGVuIEJyb3duOyBDb2xsYWJvcmEgS2VybmVs
IE1MOyBHdWVudGVyIFJvZWNrOyBCZW5zb24gTGV1bmc7IERtaXRyeQ0KPiBUb3Jva2hvdjsgR3dl
bmRhbCBHcmlnbm91OyB2YmVuZGViQGNocm9taXVtLm9yZzsgQW5keSBTaGV2Y2hlbmtvOyBBeW1h
bg0KPiBCYWdhYmFzOyBCZW5qYW1pbiBUaXNzb2lyZXM7IEJsYcW+IEhyYXN0bmlrOyBEYXJyZW4g
SGFydDsgRG1pdHJ5IFRvcm9raG92Ow0KPiBHcmVnIEtyb2FoLUhhcnRtYW47IEhhbnMgZGUgR29l
ZGU7IEplcmVteSBTb2xsZXI7IE1hdHRpYXMgSmFjb2Jzc29uOyBNYXVybw0KPiBDYXJ2YWxobyBD
aGVoYWI7IFJhamF0IEphaW47IFNyaW5pdmFzIFBhbmRydXZhZGE7IHBsYXRmb3JtLWRyaXZlci0N
Cj4geDg2QHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0XSBwbGF0Zm9y
bTogeDg2OiBBZGQgQUNQSSBkcml2ZXIgZm9yIENocm9tZU9TDQo+IA0KPiANCj4gW0VYVEVSTkFM
IEVNQUlMXQ0KPiANCj4gSGkgUmFmYWVsLA0KPiANCj4gTWFueSB0aGFua3MgZm9yIHlvdXIgZmVl
ZGJhY2suIFNlZSBteSBhbnN3ZXJzIGlubGluZS4NCj4gDQo+IE9uIDUvNi8yMCAxMzoxNywgUmFm
YWVsIEouIFd5c29ja2kgd3JvdGU6DQo+ID4gT24gVHVlc2RheSwgQXByaWwgMTQsIDIwMjAgNDoz
NTozOCBQTSBDRVNUIEVucmljIEJhbGxldGJvIGkgU2VycmEgd3JvdGU6DQo+ID4+IEhpIFJhZmFl
bCwNCj4gPj4NCj4gPj4gT24gMTMvNC8yMCAyMjo0MSwgUmFmYWVsIEouIFd5c29ja2kgd3JvdGU6
DQo+ID4+PiBPbiBNb24sIEFwciAxMywgMjAyMCBhdCAzOjQ2IFBNIEVucmljIEJhbGxldGJvIGkg
U2VycmENCj4gPj4+IDxlbnJpYy5iYWxsZXRib0Bjb2xsYWJvcmEuY29tPiB3cm90ZToNCj4gPj4+
Pg0KPiA+Pj4+IFRoaXMgZHJpdmVyIGF0dGFjaGVzIHRvIHRoZSBDaHJvbWVPUyBBQ1BJIGRldmlj
ZSBhbmQgdGhlbiBleHBvcnRzIHRoZQ0KPiB2YWx1ZXMNCj4gPj4+PiByZXBvcnRlZCBieSB0aGUg
QUNQSSBpbiBhIHN5c2ZzIGRpcmVjdG9yeS4gVGhlc2UgdmFsdWVzIGFyZSBub3QNCj4gZXhwb3J0
ZWQNCj4gPj4+PiB2aWEgdGhlIHN0YW5kYXJkIEFDUEkgdGFibGVzLCBoZW5jZSBhIHNwZWNpZmlj
IGRyaXZlciBpcyBuZWVkZWQgdG8gZG8NCj4gPj4+PiBpdC4NCj4gPj4+DQo+ID4+PiBTbyBob3cg
ZXhhY3RseSBhcmUgdGhleSBleHBvcnRlZD8NCj4gPj4+DQo+ID4+DQo+ID4+IFRoZXkgYXJlIGV4
cG9ydGVkIHRocm91Z2ggc3lzZnMuDQo+ID4+DQo+ID4+Pj4gVGhlIEFDUEkgdmFsdWVzIGFyZSBw
cmVzZW50ZWQgaW4gdGhlIHN0cmluZyBmb3JtIChudW1iZXJzIGFzIGRlY2ltYWwNCj4gPj4+PiB2
YWx1ZXMpIG9yIGJpbmFyeSBibG9icywgYW5kIGNhbiBiZSBhY2Nlc3NlZCBhcyB0aGUgY29udGVu
dHMgb2YgdGhlDQo+ID4+Pj4gYXBwcm9wcmlhdGUgcmVhZCBvbmx5IGZpbGVzIGluIHRoZSBzdGFu
ZGFyZCBBQ1BJIGRldmljZXMgc3lzZnMNCj4gZGlyZWN0b3J5IHRyZWUuDQo+ID4+Pg0KPiA+Pj4g
TXkgdW5kZXJzdGFuZGluZyBiYXNlZCBvbiBhIGN1cnNvcnkgbG9vayBhdCB0aGUgcGF0Y2ggaXMg
dGhhdCB0aGVyZSBpcw0KPiA+Pj4gYW4gQUNQSSBkZXZpY2Ugd2l0aCBfSElEIGVxdWFsIHRvICJH
R0wwMDAxIiAgYW5kIG9uZSBvciBtb3JlIHNwZWNpYWwNCj4gPj4+IG1ldGhvZHMgdW5kZXIgaXQg
dGhhdCByZXR1cm4gdmFsdWVzIHdoaWNoIHlvdSB3YW50IHRvIGV4cG9ydCBvdmVyDQo+ID4+PiBz
eXNmcyBhcyBiaW5hcnkgYXR0cmlidXRlcy4gIFRoZXkgYXBwZWFyIHRvIGJlIHJlYWQtb25seS4N
Cj4gPj4+DQo+ID4+DQo+ID4+IEV4YWN0bHksIHRoZXJlIGlzIGFuIEFDUEkgZGV2aWNlIGVxdWFs
IHRvICJHR0wwMDAxIiBhbmQgb25lIHNwZWNpYWwNCj4gbWV0aG9kDQo+ID4+IGNhbGxlZCBNTFNU
IHRoYXQgcmV0dXJucyBhIGxpc3Qgb2YgdGhlIG90aGVyIGNvbnRyb2wgbWV0aG9kcyBzdXBwb3J0
ZWQNCj4gYnkgdGhlDQo+ID4+IENocm9tZSBPUyBoYXJkd2FyZSBkZXZpY2UuIFRoZSBkcml2ZXIg
Y2FsbHMgdGhlIHNwZWNpYWwgTUxTVCBtZXRob2QgYW5kDQo+IGdvZXMNCj4gPj4gdGhyb3VnaCB0
aGUgbGlzdC4NCj4gPj4NCj4gPj4+IEkgZ3Vlc3MgdGhhdCB0aGVzZSBkYXRhIGFyZSB0byBiZSBj
b25zdWJlZCBieSB1c2VyIHNwYWNlPw0KPiA+Pj4NCj4gPj4NCj4gPj4gWWVzLCB0aGlzIGlzIHVz
ZWQgYnkgdXNlciBzcGFjZSwgdG8gYmUgbW9yZSBzcGVjaWZpYyBDaHJvbWVPUyB1c2Vyc3BhY2UN
Cj4gdXNlcyBpdC4NCj4gPg0KPiA+IFdlbGwsIGxldCBtZSBzdGFydCBvdmVyLg0KPiA+DQo+ID4g
VGhlIHN1YmplY3QgYW5kIGNoYW5nZWxvZyBvZiB0aGlzIHBhdGNoIGFyZSBub3QgcHJlY2lzZSBl
bm91Z2ggSU1PIGFuZA0KPiB0aGVyZSBpcw0KPiA+IG5vdCBlbm91Z2ggaW5mb3JtYXRpb24gaW4g
dGhlIGxhdHRlci4NCj4gPg0KPiANCj4gT2ssIEkgY2FuIGltcHJvdmUgdGhhdC4NCj4gDQo+ID4g
SXQgaXMgbm90IGNsZWFyIHdoYXQgIkFDUEkgZHJpdmVyIGZvciBDaHJvbWVPUyIgbWVhbnMuICBU
aGVyZSBtYXkgYmUgbWFueQ0KPiBBQ1BJDQo+ID4gZHJpdmVycyBpbiBhIExpbnV4LWJhc2VkIHN5
c3RlbSBhcyBhIHJ1bGUuDQo+ID4NCj4gPiBJdCBpcyB1bmNsZWFyIHdoYXQgdGhlIENocm9tZU9T
IEFDUEkgZGV2aWNlIGlzIGFuZCB3aHkgaXQgaXMgdGhlcmUuICBJcw0KPiB0aGVyZQ0KPiA+IGFu
eSBkb2N1bWVudGF0aW9uIG9mIGl0IHlvdSBjYW4gcG9pbnQgbWUgdG8/DQo+ID4NCj4gDQo+IEkn
bSBhZnJhaWQsIEkgZG9uJ3QgdGhpbmsgdGhlcmUgaXMgYW55IGRvY3VtZW50YXRpb24sIEknbGwg
YXNrIGFyb3VuZC4NCj4gDQo+ID4gSXQgaXMgdW5jbGVhciB3aGF0IHlvdSBtZWFuIGJ5ICJUaGVz
ZSB2YWx1ZXMgYXJlIG5vdCBleHBvcnRlZCB2aWEgdGhlDQo+IHN0YW5kYXJkDQo+ID4gQUNQSSB0
YWJsZXMiLg0KPiA+DQo+ID4gSXQgbG9va3MgbGlrZSAoYnV0IGl0IGlzIG5vdCBhY3R1YWxseSBk
b2N1bWVudGVkIGluIGFueSB3YXkpIHRoZSBpZGVhIGlzDQo+IHRvDQo+ID4gZ2V0IHRvIHRoZSBB
Q1BJIGRldmljZSBvYmplY3Qgd2l0aCBfSElEIHJldHVybmluZyAiR0dMMDAwMSIsIGV2YWx1YXRl
IHRoZQ0KPiA+IE1MU1QgbWV0aG9kIHVuZGVyIGl0IGFuZCB0aGVuIGV2YWx1YXRlIHRoZSBtZXRo
b2RzIGxpc3RlZCBieSBpdCBhbmQNCj4gZXhwb3J0IHRoZQ0KPiA+IGRhdGEgcmV0dXJuZWQgYnkg
dGhlbSB2aWEgc3lzZnMsIHVuZGVyIHRoZSAiR0dMMDAwMSIgZGV2aWNlIG9uIHRoZSAiYWNwaSIN
Cj4gYnVzLg0KPiA+IElzIHRoaXMgY29ycmVjdD8NCj4gPg0KPiANCj4gWWVzLCB0aGlzIGlzIGNv
cnJlY3QuDQo+IA0KPiA+IElmIHNvLCB0aGVyZSBpcyBhIGNvdXBsZSBvZiBpc3N1ZXMgaGVyZS4N
Cj4gPg0KPiA+IEZpcnN0IG9mZiwgR0dMMDAwMSBpcyBub3QgYSB2YWxpZCBBQ1BJIGRldmljZSBJ
RCwgYmVjYXVzZSB0aGUgR0dMIHByZWZpeA0KPiBpcyBub3QNCj4gPiBwcmVzZW50IGluIHRoZSBs
aXN0IGF0IGh0dHBzOi8vdWVmaS5vcmcvYWNwaV9pZF9saXN0DQo+ID4NCj4gPiBUaGVyZSBhcmUg
dHdvIHdheXMgdG8gYWRkcmVzcyB0aGF0LiAgT25lIHdvdWxkIGJlIHRvIHRha2UgdGhlIEdPT0cg
cHJlZml4DQo+ID4gKHByZXNlbnQgaW4gdGhlIGxpc3QgYWJvdmUpLCBhcHBlbmQgYSBwcm9wZXIg
dW5pcXVlIG51bWJlciAoaWYgSSB3ZXJlIHRvDQo+ID4gZ3Vlc3MsIEkgd291bGQgc2F5IHRoYXQg
MDAwMSBoYWQgYmVlbiByZXNlcnZlZCBhbHJlYWR5KSB0byBpdCBhbmQgdGhlbg0KPiA+IHB1dCB0
aGUgcmVzdWx0aW5nIGRldmljZSBJRCBpbnRvIHRoZSBmaXJtd2FyZSwgdG8gYmUgcmV0dXJuZWQg
X0hJRCBmb3INCj4gdGhlDQo+ID4gZGV2aWNlIGluIHF1ZXN0aW9uICh5b3UgY2FuIGFkZCBhIF9D
SUQgcmV0dXJuaW5nICJHR0wwMDAxIiBzbyBpdCBjYW4gYmUNCj4gPiBmb3VuZCBieSB0aGUgb2xk
IGludmFsaWQgSUQgYXQgbGVhc3QgZnJvbSB0aGUga2VybmVsKS4NCj4gDQo+IEFzIERtaXRyeSBz
YWlkLCB0aGlzIGlzIG5vdCBnb2luZyB0byBoYXBwZW4uDQoNCkkgdGhpbmsgaXQncyBwcm9iYWJs
eSB3b3J0aCBncm91cGluZyAiZXhpc3RpbmciIHBsYXRmb3JtcyBhbmQgbmV3IHBsYXRmb3Jtcw0K
c2VwYXJhdGVseS4gIE1vcmUgYmVsb3cuDQoNCj4gDQo+IA0KPiA+IFRoZSBvdGhlciBvbmUgd291
bGQNCj4gPiBiZSB0byBwcm9wZXJseSByZWdpc3RlciB0aGUgR0dMIHByZWZpeCBmb3IgR29vZ2xl
IGFuZCBlc3RhYmxpc2ggYSBwcm9jZXNzDQo+IGZvcg0KPiA+IGFsbG9jYXRpbmcgSURzIHdpdGgg
dGhhdCBwcmVmaXggaW50ZXJuYWxseS4NCj4gPg0KPiANCj4gSUlVQyBJIHRoaW5rIHRoaXMgaXMg
dGhlIG9wdGlvbiB3ZSBzaG91bGQgZ28sIGFsdGhvdWdoIEkgYW0gbm90IHJlYWxseSBzdXJlDQo+
IGhvdw0KPiB0byBkbyBpdCAoSSB3aWxsIGludmVzdGlnYXRlIG9yIGFzaykuDQo+IA0KPiBUbyBn
aXZlIHlvdSBzb21lIHJlZmVyZW5jZXMsIGlmIEknbSBub3Qgd3JvbmcsIHRoaXMgcHJlZml4IGlz
IHVzZWQgaW4gYWxsDQo+IG9yDQo+IGFsbW9zdCBhbGwgSW50ZWwgQ2hyb21lYm9vayBkZXZpY2Vz
IChhdXJvbiwgY3lhbiwgZXZlLCBmaXp6LCBoYXRjaCwNCj4gb2N0b3B1cywNCj4gcG9wcHksIHN0
cmFnbyAuLi4pIFRoZSBBQ1BJIHNvdXJjZSBmb3IgdGhpcyBkZXZpY2UgY2FuIGJlIGZvdW5kIGhl
cmUgWzFdLA0KPiBhbmQsDQo+IGlmIG5vdCBhbGwsIGFsbW9zdCBhbGwgSW50ZWwgYmFzZWQgQ2hy
b21lYm9va3MgYXJlIHNoaXBwZWQgd2l0aCB0aGUNCj4gZmlybXdhcmUNCj4gdGhhdCBzdXBwb3J0
cyB0aGlzLg0KDQpZb3UgY2FuIHBvdGVudGlhbGx5IGNhcnJ5IGEgc21hbGwgcGF0Y2ggaW4geW91
ciBkb3duc3RyZWFtIGtlcm5lbCBmb3IgdGhlDQpsZWdhY3kgc3R1ZmYgdW50aWwgaXQgcmVhY2hl
cyBFT0wuICBBdCBsZWFzdCBmb3IgdGhlIG5ldyBzdHVmZiB5b3UgY291bGQNCmVuYWN0IGEgcHJv
Y2VzcyB0aGF0IHByb3Blcmx5IHJlc2VydmVzIHVuaXF1ZSBudW1iZXJzIGFuZCBjaGFuZ2VzIHRo
ZSBkcml2ZXINCndoZW4gdGhlIGludGVyZmFjZSBwcm92aWRlZCBieSB0aGUgQUNQSSBkZXZpY2Ug
aGFzIGNoYW5nZWQuDQoNCj4gDQo+ID4gTmV4dCwgZGV2aWNlIGF0dHJpYnV0ZXMgaW4gc3lzZnMg
YXJlIHBhcnQgb2YgdGhlIGtlcm5lbCBBQkkgYW5kIG9uY2UNCj4gZGVmaW5lZCwNCj4gPiB0aGV5
IGNhbm5vdCBjaGFuZ2UgKGV4Y2VwdGlvbnMgaGFwcGVuLCBidXQgcmFyZWx5KSwgc28geW91IG11
c3QgZ3VhcmFudGVlDQo+ID4gdGhhdCB3aGF0ZXZlciBhcHBlYXJzIGluIHRoZXJlLCB3aWxsIGFs
d2F5cyBiZSBwcmVzZW50IGZvciBkZXZpY2VzIHdpdGgNCj4gdGhlDQo+ID4gZ2l2ZW4gZGV2aWNl
IElEIGluIHRoZSBmdXR1cmUgaW4gdGhlIHNhbWUgZm9ybWF0Lg0KPiA+DQo+ID4gQ2FuIHlvdSBh
Y3R1YWxseSBndWFyYW50ZWUgdGhhdD8gIElmIHNvLCB3aGF0IGlzIHRoYXQgZ3VhcmFudGVlIGJh
c2VkIG9uPw0KPiA+DQo+IA0KPiBBbHRob3VnaCBpcyBub3QgcmVhbGx5IGRvY3VtZW50ZWQsIGNh
biB3ZSBzYXkgdGhhdCB0aGlzIGlzIGEgc3RhbmRhcmQgImRlDQo+IGZhY3RvIg0KPiBhc3N1bWlu
ZyB0aGF0IHRoZXJlIGFyZSBsb3RzIG9mIGRldmljZXMgaW4gdGhlIGZpZWxkIGFuZCBmb3IgYSBs
b25nIHRpbWUNCj4gd2l0aA0KPiB0aGF0PyBDYW4gdGhpcyBiZSBhIGd1YXJhbnRlZT8NCj4gDQo+
ID4gVGhhbmtzIQ0KPiA+DQo+ID4NCj4gPg0KPiANCj4gVGhhbmtzIQ0KPiANCj4gWzFdDQo+IGh0
dHBzOi8vY2hyb21pdW0uZ29vZ2xlc291cmNlLmNvbS9jaHJvbWl1bW9zL3RoaXJkX3BhcnR5L2Nv
cmVib290LysvcmVmcy9oZQ0KPiBhZHMvY2hyb21lb3MtMjAxNi4wNS9zcmMvdmVuZG9yY29kZS9n
b29nbGUvY2hyb21lb3MvYWNwaS9jaHJvbWVvcy5hc2wNCg==
