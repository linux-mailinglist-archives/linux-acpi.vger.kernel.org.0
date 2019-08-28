Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 466CEA079A
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Aug 2019 18:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfH1Ql7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 28 Aug 2019 12:41:59 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:31170 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726592AbfH1Ql7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 28 Aug 2019 12:41:59 -0400
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7SGTvZM028221;
        Wed, 28 Aug 2019 12:41:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dellteam.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=a3BoWxj1Az0X+1n8Sjnmh+YLv+LJl807q9sAANHRtRo=;
 b=NdCCoXSCXcREB+knnvpihhv0F5PtxfBmtmeedh7+wgbvWzcE3s+jHMQgHAzts6fNVNZL
 w04Ym3OuzRvR+wWIB8Sz5R/JfCqdDpPB35I2rRZxT0O13lCfOk2dvouj74r784y6arbU
 jRxIg0esoYHEqfdY9nK099fYegY+DpItpdhdVyFg2X/B0Kiao1g8oA1cfMJm/pCYzmiV
 mV+JyYnwJLORc0Nk78cmZsLN0DwR4/phlv+kAfIsKmgc559o9g0sttK+1Ln02MaIjMoQ
 WvtsucTCDXfxvLQVaKbNCRcTUCtrOSlrgDjBIGCTlig02hUf8PNxyx89tLjenp5ujikq Fw== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 2uk2pessu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Aug 2019 12:41:57 -0400
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7SGX9x4191166;
        Wed, 28 Aug 2019 12:41:56 -0400
Received: from ausxippc106.us.dell.com (AUSXIPPC106.us.dell.com [143.166.85.156])
        by mx0a-00154901.pphosted.com with ESMTP id 2ukjakn9te-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Aug 2019 12:41:56 -0400
X-LoopCount0: from 10.166.132.133
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="453337468"
From:   <Charles.Hyde@dellteam.com>
To:     <Mario.Limonciello@dell.com>, <bjorn@mork.no>
CC:     <linux-acpi@vger.kernel.org>, <oliver@neukum.org>,
        <nic_swsd@realtek.com>, <linux-usb@vger.kernel.org>
Subject: RE: [RFC 2/3] ACPI: move ACPI functionality out of r8152 driver
Thread-Topic: [RFC 2/3] ACPI: move ACPI functionality out of r8152 driver
Thread-Index: AQHVWgITZZ4dwXs8CES9WUAD0zcVmKcKGJhogACFrgCABPPFAIAAWKMA//+tuqA=
Date:   Wed, 28 Aug 2019 16:41:53 +0000
Message-ID: <d800fe75f26b4bd2aa59e5c176eae15a@AUSX13MPS307.AMER.DELL.COM>
References: <b84b32cb144f4ba8918ee2406e69275a@AUSX13MPS303.AMER.DELL.COM>
 <87blwe272v.fsf@miraculix.mork.no>
 <b3062089954f43259f8dfce9076b78ad@AUSX13MPC101.AMER.DELL.COM>
 <6e404c3d3c344342b09b475e64b4ff3e@AUSX13MPS303.AMER.DELL.COM>
 <ae55e4a85d594e27a46cab32ad675208@AUSX13MPC101.AMER.DELL.COM>
In-Reply-To: <ae55e4a85d594e27a46cab32ad675208@AUSX13MPC101.AMER.DELL.COM>
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
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-08-28_08:2019-08-28,2019-08-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 mlxscore=0 suspectscore=0 priorityscore=1501
 phishscore=0 bulkscore=0 impostorscore=0 adultscore=0 spamscore=0
 mlxlogscore=729 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1908280166
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=827 spamscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1908280166
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

PHNuaXBwZWQ+DQoNCj4gPiA+ID4NCj4gPiA+ID4gSWYgeW91IHJlYWxseSB3YW50IHRvIGhhdmUg
dGhpcyBwb2xpY3kgaW4gdGhlIGRyaXZlcihzKSwgdGhlbg0KPiA+ID4gPiBwbGVhc2UgY29uc2lk
ZXIgZXh0ZW5kaW5nIGV0aF9wbGF0Zm9ybV9nZXRfbWFjX2FkZHJlc3MoKSB3aXRoIGFuDQo+ID4g
PiA+IHg4Ni9hY3BpIG1ldGhvZC4gIFRoaXMgd2lsbCBtYWtlIHRoZSBkZXZpY2UgZHJpdmVyIGNv
ZGUgc3VwcG9ydA0KPiA+ID4gPiBmZXRjaGluZyB0aGUgbWFjIGFkZHJlc3MgZnJvbSBkZXZpY2Ug
dHJlZSBhbmQgU3BhcmMgaWRwcm9tcyB0b28uDQo+ID4gPiA+IFByb3ZpZGVkIHRoZSBuZXRkZXYN
Cj4gPiA+IGZvbGtzIHRoaW5ncyB0aGlzIGlzIE9LLCBvZiBjb3Vyc2UuDQo+ID4gPiA+IFRoaXMg
bmVlZHMgdG8gYmUgZGlzY3Vzc2VkIHRoZXJlLCBsaWtlIGdldF9tYWludGFpbmVyLnBsIHdvdWxk
IGhhdmUgdG9sZA0KPiB5b3UuDQo+ID4gPiA+DQo+ID4gPiA+IE1ha2luZyBzdXJlIHdlIGNhbiBt
b2RpZnkgdGhlIE1BQyBhZGRyZXNzIG9mIFVTQiBldGhlcm5ldCBkZXZpY2VzDQo+ID4gPiA+IGlz
IG9idmlvdXNseSBhIGdvb2QgdGhpbmcgcmVnYXJkbGVzcyBvZiBob3cvd2hlcmUgeW91IGZldGNo
IGl0Lg0KPiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4g
PiBCasO4cm4NCj4gPg0KPiA+IEJ5IG1vdmluZyBhY3BpX21hY19wYXNzdGhydS5jIGludG8gZHJp
dmVycy9hY3BpLywgd2hhdCBpcyB0aGUNCj4gPiBzdWdnZXN0ZWQgZWRpdCB0byBNYWtlZmlsZSBm
b3IgdGhpcz8gIEkgYW0gdGhpbmtpbmcgaXQgY291bGQgYmUgYWRkZWQNCj4gPiBpbW1lZGlhdGVs
eSBmb2xsb3dpbmcgdGhlIGNvbW1lbnQgIlRoZXNlIGFyZSAocG90ZW50aWFsbHkpIHNlcGFyYXRl
DQo+IG1vZHVsZXMiIHdpdGg6DQo+ID4NCj4gPiBhcGljLXkgKz0gYWNwaV9tYWNfcGFzc3RocnUu
bw0KPiA+DQo+ID4gSSByZW1vdmVkIGV4dHJhIHNwYWNpbmcgYWJvdmUgZm9yIHBvc3RpbmcgaGVy
ZS4NCj4gPg0KPiANCj4gSSBiZWxpZXZlIHRoYXQgQmrDuHJuIHNwZWNpZmljYWxseSByZWNvbW1l
bmRlZCB0byBwdXQgaXQgaW4gZHJpdmVycy9hY3BpL3g4Ni4NCj4gDQo+IFdoaWNoIHRoYXQgd291
bGQgbWVhbiBpdCdzOg0KPiBhY3BpLSQoQ09ORklHX1g4NikgICAgICAgICAgICAgICs9IHg4Ni9h
Y3BpX21hY19wYXNzdGhyb3VnaC5vDQoNCg0KVGhlcmUgaXMgbm90aGluZyBpbiB0aGlzIG1ldGhv
ZCB0aGF0IG5lZWRzIHRvIGJlIHg4NiBvbmx5LiAgSWYgdGhpcyBtZXRob2QgaXMgbWFkZSBhdmFp
bGFibGUgdG8gb3RoZXIgYXJjaGl0ZWN0dXJlcywgdGhlbiBpdCBpcyBwb3NzaWJsZSBmb3Igc3lz
dGVtcyBiYXNlZCBvbiBvdGhlciBhcmNoaXRlY3R1cmVzIHRvIGJlbmVmaXQgYW5kIG1ha2UgaW5y
b2FkcyBpbnRvIHRoZSBlbnRlcnByaXNlIHNwYWNlLiAgRGVsbCBtaWdodCBiZSB0aGUgb25seSBj
b21wYW55IHVzaW5nIHRoaXMgbWV0aG9kLCBidXQgaXQgY291bGQgYmUgYWRvcHRlZCBieSBvdGhl
cnMgZm9yIHRoZSBzYW1lIHJlYXNvbnMgRGVsbCBjcmVhdGVkIGl0IGluIHRoZSBmaXJzdCBwbGFj
ZS4NCg0KSSBsb29rZWQgYXQgZXRoX3BsYXRmb3JtX2dldF9tYWNfYWRkcmVzcygpIHBlciBCasO4
cm4ncyBzdWdnZXN0aW9uLCBhbmQgYWRkZWQgYSBkZXZfaW5mbygpIHN0YXRlbWVudCB0byBsZXQg
bWUga25vdyBpZiBhbmQgd2hlbiB0aGlzIGRyaXZlciBmdW5jdGlvbiBpcyBleGVjdXRlZCB3aGVu
IEkgYm9vdGVkIG15IGNocm9tZWJvb2sgYW5kIHBsdWdnZWQgaW4gYSBEZWxsIFVuaXZlcnNhbCBE
b2NrIEQ2MDAwLiAgVW5mb3J0dW5hdGVseSBmb3IgbXkgZXhwZXJpbWVudCwgdGhpcyBmdW5jdGlv
biBpcyBub3QgY2FsbGVkLiAgVGhlcmVmb3JlLCBpdCBtYWtlcyBubyBzZW5zZSB0byBhZGQgY29k
ZSBoZXJlIGZvciBEZWxsJ3MgbmVlZHMgYXQgdGhpcyB0aW1lLiAgRnVydGhlcm1vcmUsIEkgYmVs
aWV2ZSB0aGF0IGl0IGlzIG5vdCBub3csIG5vciB3YXMgaXQgZXZlciwgRGVsbCdzIGludGVudGlv
biB0byBoYXZlIG9uLWJvYXJkIGV0aGVybmV0IE1BQyBhZGRyZXNzZXMgYmUgcmVwcm9ncmFtbWVk
IGJ5IHRoaXMgbWV0aG9kLi4gSSBiZWxpZXZlIGl0IHdhcyBEZWxsJ3MgaW50ZW50aW9uIHRvIGFw
cGx5IHRoaXMgdG8gb25seSBVU0IgVHlwZS1DIGJhc2VkIGV0aGVybmV0IGRldmljZXMsIGhlbmNl
IHRoZSBvcmlnaW5hbCBjb2RlIHdhcyBhcHBsaWVkIHRvIG9ubHkgZHJpdmVycy9uZXQvdXNiL3I4
MTUyLmMuICBUaGF0IGlzIG5vdCB0byBzYXkgdGhpcyBtZXRob2QgaXMgbGltaXRlZCB0byBvbmx5
IFVTQiBUeXBlLUMgZGV2aWNlcywgaXQgY2FuIGJlIHVzZWQgYnkgd2hvbWV2ZXIgZm9yIHdoaWNo
ZXZlciBkcml2ZXJzIGRlZW0gaXQgYWR2YW50YWdlb3VzLCByZWdhcmRsZXNzIG9mIHVuZGVybHlp
bmcgQ1BVIGFyY2hpdGVjdHVyZS4NCg0KLS0gDQpDaGFybGVzDQo=
