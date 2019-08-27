Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 311199F5E9
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Aug 2019 00:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbfH0WTL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 27 Aug 2019 18:19:11 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:51944 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725989AbfH0WTL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 27 Aug 2019 18:19:11 -0400
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7RMEN82028008;
        Tue, 27 Aug 2019 18:19:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=ReIjJ6BOJHzZyHWyK2izd5jg6rb3eukUaNiAT8vGCbI=;
 b=db79QcJ85kL6kRiIAfpuGShUWLpY/VRMX3bk9CGJGv6p22+N2oOTwU6j8/XHA6pGBSEW
 wVHDWWNmR3jVGR1AYXVkaunxueR23YNA0riaPntV+lNKiPjQzH8xEzjBpl1nbg6C7F4G
 3U0f5mQAsCIwIavUUWSHfhikZcSvDlHCKr0s+TMLhL2qzkKc7goVHVA+4h6IkxP62J6k
 s+j8Q2VJ9syWmGP8XvjSsieLi8d5eC56MknzBsy9pwLBD6pwhh+LqiY5QfMXyD4221hZ
 erGYLgtsBSH1TqSm86xS/5D5aUr39BS6m/mpwDPIlhKoUgds+riKTzwTzgg6k2PZ/WLK Gw== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 2uk2yge3n8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Aug 2019 18:19:09 -0400
Received: from pps.filterd (m0134318.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7RMII2H120224;
        Tue, 27 Aug 2019 18:19:09 -0400
Received: from ausxipps301.us.dell.com (ausxipps301.us.dell.com [143.166.148.223])
        by mx0a-00154901.pphosted.com with ESMTP id 2uk269vrxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Aug 2019 18:19:08 -0400
X-LoopCount0: from 10.166.135.92
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="388351932"
From:   <Mario.Limonciello@dell.com>
To:     <Charles.Hyde@dellteam.com>, <bjorn@mork.no>
CC:     <linux-acpi@vger.kernel.org>, <oliver@neukum.org>,
        <nic_swsd@realtek.com>, <linux-usb@vger.kernel.org>
Subject: RE: [RFC 2/3] ACPI: move ACPI functionality out of r8152 driver
Thread-Topic: [RFC 2/3] ACPI: move ACPI functionality out of r8152 driver
Thread-Index: AQHVWgITZZ4dwXs8CES9WUAD0zcVmKcKGJidgAAv6rCABZ8vAP//rqVQ
Date:   Tue, 27 Aug 2019 22:19:06 +0000
Message-ID: <ae55e4a85d594e27a46cab32ad675208@AUSX13MPC101.AMER.DELL.COM>
References: <b84b32cb144f4ba8918ee2406e69275a@AUSX13MPS303.AMER.DELL.COM>
 <87blwe272v.fsf@miraculix.mork.no>
 <b3062089954f43259f8dfce9076b78ad@AUSX13MPC101.AMER.DELL.COM>
 <6e404c3d3c344342b09b475e64b4ff3e@AUSX13MPS303.AMER.DELL.COM>
In-Reply-To: <6e404c3d3c344342b09b475e64b4ff3e@AUSX13MPS303.AMER.DELL.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Charles_Hyde@Dellteam.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-08-27T22:08:23.8411868Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual;
 aiplabel=External Public
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-27_04:2019-08-27,2019-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1908270210
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 impostorscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 clxscore=1015 phishscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1908270209
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSHlkZSwgQ2hhcmxlcyAt
IERlbGwgVGVhbQ0KPiBTZW50OiBUdWVzZGF5LCBBdWd1c3QgMjcsIDIwMTkgNTowOCBQTQ0KPiBU
bzogTGltb25jaWVsbG8sIE1hcmlvOyBCasO4cm4gTW9yaw0KPiBDYzogbGludXgtYWNwaUB2Z2Vy
Lmtlcm5lbC5vcmc7IG9saXZlckBuZXVrdW0ub3JnOyBuaWNfc3dzZEByZWFsdGVrLmNvbTsNCj4g
bGludXgtdXNiQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSRTogW1JGQyAyLzNdIEFDUEk6
IG1vdmUgQUNQSSBmdW5jdGlvbmFsaXR5IG91dCBvZiByODE1MiBkcml2ZXINCj4gDQo+IA0KPiA+
ID4gPiBUaGlzIGNoYW5nZSBtb3ZlcyBBQ1BJIGZ1bmN0aW9uYWxpdHkgb3V0IG9mIHRoZSBSZWFs
dGVrIHI4MTUyIGRyaXZlcg0KPiA+ID4gPiB0byBpdHMgb3duIHNvdXJjZSBhbmQgaGVhZGVyIGZp
bGUsIG1ha2luZyBpdCBhdmFpbGFibGUgdG8gb3RoZXINCj4gPiA+ID4gZHJpdmVycyBhcyBuZWVk
ZWQgbm93IGFuZCBpbnRvIHRoZSBmdXR1cmUuICBBdCB0aGUgdGltZSB0aGlzIEFDUEkNCj4gPiA+
ID4gc25pcHBldCB3YXMgaW50cm9kdWNlZCBpbiAyMDE2LCBvbmx5IHRoZSBSZWFsdGVrIGRyaXZl
ciBtYWRlIHVzZSBvZg0KPiA+ID4gPiBpdCBpbiBzdXBwb3J0IG9mIERlbGwncyBlbnRlcnByaXNl
IElUIHBvbGljeSBlZmZvcnRzLiAgVGhlcmUgY29tZXMNCj4gPiA+ID4gbm93IGEgbmVlZCBmb3Ig
dGhpcyBzYW1lIHN1cHBvcnQgaW4gYSBkaWZmZXJlbnQgZHJpdmVyLCBhbHNvIGluDQo+ID4gPiA+
IHN1cHBvcnQgb2YgRGVsbCdzIGVudGVycHJpc2UgSVQgcG9saWN5IGVmZm9ydHMuDQo+ID4gPg0K
PiA+ID4gV2h5IG5vdCBtYWtlIGEgc3RhbmRhbG9uZSBkcml2ZXIgb3V0IG9mIHRoaXMsIG1ha2lu
ZyB0aGUgTUFDIGFkZHJlc3MNCj4gPiA+IChhbmQgb3RoZXIgc3lzdGVtIHNwZWNpZmMgb2JqZWN0
cz8pIGF2YWlsYWJsZSB0byB1c2Vyc3BhY2U/IFRoZW4geW91DQo+ID4gPiBjYW4ganVzdCBkaXN0
cmlidXRlIHVwZGF0ZWQgdWRldiBydWxlcyBvciBzeXN0ZW1kIHVuaXRzIG9yIHdoYXRldmVyDQo+
ID4gPiBmb3IgdGhlIG5leHQgZG9ja2luZyBwcm9kdWN0Lg0KPiA+ID4NCj4gPiA+IEkgZG9uJ3Qg
dGhpbmsgc3lzdGVtIHNwZWNpZmljIHBvbGljaWVzIHNob3VsZCBiZSBwdXQgaW50byBkZXZpY2UN
Cj4gPiA+IGRyaXZlcnMuICBVc2VycyB3aWxsIGNvbWJpbmUgc3lzdGVtcyBhbmQgZGV2aWNlcyBp
biB3YXlzIHlvdSBkb24ndA0KPiA+ID4gZm9yZXNlZSwgYW5kIG1heSBoYXZlIGdvb2QgcmVhc29u
cyB0byB3YW50IHNvbWUgbm9uLWRlZmF1bHQgcG9saWN5IGV2ZW4NCj4gPiBmb3Igc3VwcG9ydGVk
IGNvbWJpbmF0aW9ucy4NCj4gPg0KPiA+IEkgcmVjYWxsIHRoYXQgd2hlbiB0aGlzIHdhcyBmaXJz
dCBkb25lIGZvciByODE1MiB3ZSBhY3R1YWxseSBleHBlcmltZW50ZWQgd2l0aA0KPiA+IGV4YWN0
bHkgdGhhdCBhbmQgcmFuIGludG8gdHdvIHByb2JsZW1zOg0KPiA+DQo+ID4gMSkgV2l0aCB1c2Vy
c3BhY2UgcmFjZXMgd2l0aCBldGhlcm5ldCBkZXZpY2UgcmVuYW1pbmcNCj4gPiAyKSBUaGUgZGV0
YWlscyBuZWVkZWQgdG8gdGVsbCB3aGljaCBkZXZpY2VzIHRoaXMgc2hvdWxkIGFwcGx5IHRvIChz
dWNoIGFzIGVGdXNlDQo+ID4gc2V0dGluZ3Mgb3Igb3RoZXIgaWRlbnRpZnlpbmcgZmFjdG9ycykg
YXJlbid0IGV4cG9ydGVkIHRvIHVzZXJzcGFjZS4NCj4gPg0KPiA+IFdlIG9ubHkgd2FudCB0aGlz
IGFwcGx5aW5nIHRvIGRldmljZXMgdGhhdCBrZWVwIHRoZSBzYW1lIHBvbGljeSBpbiB0aGUNCj4g
PiBmaXJtd2FyZSBmb3IgdGhpbmdzIGxpa2UgUFhFIG9yIEhUVFAgYm9vdGluZyBhbmQgZHVhbCBi
b290aW5nIG90aGVyIG9wZXJhdGluZw0KPiA+IHN5c3RlbXMuDQo+ID4gV2UndmUgYmVlbiB2ZXJ5
IGNhcmVmdWwgaW4gcjgxNTIgdGhhdCBNQUMgcGFzc3Rocm91Z2ggb25seSBhcHBsaWVzIHRvIHRo
ZQ0KPiA+IGNvcnJlY3QgZGV2aWNlcyB3aXRoIHVuaXF1ZSBpZGVudGlmaWVycyB0byBiZSBhIERl
bGwgZG9jayBhcyBzdWNoLg0KPiA+DQo+ID4gPg0KPiA+ID4gSWYgeW91IHJlYWxseSB3YW50IHRv
IGhhdmUgdGhpcyBwb2xpY3kgaW4gdGhlIGRyaXZlcihzKSwgdGhlbiBwbGVhc2UNCj4gPiA+IGNv
bnNpZGVyIGV4dGVuZGluZyBldGhfcGxhdGZvcm1fZ2V0X21hY19hZGRyZXNzKCkgd2l0aCBhbiB4
ODYvYWNwaQ0KPiA+ID4gbWV0aG9kLiAgVGhpcyB3aWxsIG1ha2UgdGhlIGRldmljZSBkcml2ZXIg
Y29kZSBzdXBwb3J0IGZldGNoaW5nIHRoZQ0KPiA+ID4gbWFjIGFkZHJlc3MgZnJvbSBkZXZpY2Ug
dHJlZSBhbmQgU3BhcmMgaWRwcm9tcyB0b28uICBQcm92aWRlZCB0aGUgbmV0ZGV2DQo+ID4gZm9s
a3MgdGhpbmdzIHRoaXMgaXMgT0ssIG9mIGNvdXJzZS4NCj4gPiA+IFRoaXMgbmVlZHMgdG8gYmUg
ZGlzY3Vzc2VkIHRoZXJlLCBsaWtlIGdldF9tYWludGFpbmVyLnBsIHdvdWxkIGhhdmUgdG9sZCB5
b3UuDQo+ID4gPg0KPiA+ID4gTWFraW5nIHN1cmUgd2UgY2FuIG1vZGlmeSB0aGUgTUFDIGFkZHJl
c3Mgb2YgVVNCIGV0aGVybmV0IGRldmljZXMgaXMNCj4gPiA+IG9idmlvdXNseSBhIGdvb2QgdGhp
bmcgcmVnYXJkbGVzcyBvZiBob3cvd2hlcmUgeW91IGZldGNoIGl0Lg0KPiA+ID4NCj4gPiA+DQo+
ID4gPg0KPiA+ID4NCj4gPiA+DQo+ID4gPiBCasO4cm4NCj4gDQo+IEJ5IG1vdmluZyBhY3BpX21h
Y19wYXNzdGhydS5jIGludG8gZHJpdmVycy9hY3BpLywgd2hhdCBpcyB0aGUgc3VnZ2VzdGVkIGVk
aXQgdG8NCj4gTWFrZWZpbGUgZm9yIHRoaXM/ICBJIGFtIHRoaW5raW5nIGl0IGNvdWxkIGJlIGFk
ZGVkIGltbWVkaWF0ZWx5IGZvbGxvd2luZyB0aGUNCj4gY29tbWVudCAiVGhlc2UgYXJlIChwb3Rl
bnRpYWxseSkgc2VwYXJhdGUgbW9kdWxlcyIgd2l0aDoNCj4gDQo+IGFwaWMteSArPSBhY3BpX21h
Y19wYXNzdGhydS5vDQo+IA0KPiBJIHJlbW92ZWQgZXh0cmEgc3BhY2luZyBhYm92ZSBmb3IgcG9z
dGluZyBoZXJlLg0KPiANCg0KSSBiZWxpZXZlIHRoYXQgQmrDuHJuIHNwZWNpZmljYWxseSByZWNv
bW1lbmRlZCB0byBwdXQgaXQgaW4gZHJpdmVycy9hY3BpL3g4Ni4NCg0KV2hpY2ggdGhhdCB3b3Vs
ZCBtZWFuIGl0J3M6DQphY3BpLSQoQ09ORklHX1g4NikgICAgICAgICAgICAgICs9IHg4Ni9hY3Bp
X21hY19wYXNzdGhyb3VnaC5vDQoNCg==
