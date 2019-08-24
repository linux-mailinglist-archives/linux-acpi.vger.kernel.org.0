Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 877069BDF4
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Aug 2019 15:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfHXNYY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 24 Aug 2019 09:24:24 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:43950 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727601AbfHXNYY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 24 Aug 2019 09:24:24 -0400
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7ODOMvR002047;
        Sat, 24 Aug 2019 09:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=ZGrH/Wz9CACwtknJ2Pf8tU0GB4dJD7WncCe2xqW3TjU=;
 b=h7jdft3mU5pARshf3G/18LoMjwj3Jqdw8RHmw81Vp2ZyS63bIWrTuMmP1Med/5MHo5Yv
 jef8cq4t06rohcmU0ceR9AEr6iNiWrbyHuj2WuFWtWv/38aDC/6ytA4AxYE8ZDser15r
 i47oX/El9FbvbzZISBUi3Oz/tCBw4HQhb/M4LN3kktyittkP2cwZ/t8IzLI7CHtMDdnd
 YJmWmOFW4XIeP1lLkjfx5NGliMhPduoQtksoGk/adlQwzjW2M6O3moshjebYpnpv6CHg
 p6XYdm/iYzbK8ZZ17OR6t5slX3RE5/kxczSbUKOSPdZV6wOXaxJnh/hZJKVfoD7iGSF9 Fw== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 2uk2pe8cx3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 24 Aug 2019 09:24:22 -0400
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7ODNk44139250;
        Sat, 24 Aug 2019 09:24:21 -0400
Received: from ausxippc101.us.dell.com (ausxippc101.us.dell.com [143.166.85.207])
        by mx0b-00154901.pphosted.com with ESMTP id 2uk2fc9wk2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 24 Aug 2019 09:24:21 -0400
X-LoopCount0: from 10.166.135.95
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,346,1549951200"; 
   d="scan'208";a="1289314603"
From:   <Mario.Limonciello@dell.com>
To:     <bjorn@mork.no>, <Charles.Hyde@dellteam.com>
CC:     <linux-acpi@vger.kernel.org>, <oliver@neukum.org>,
        <nic_swsd@realtek.com>, <linux-usb@vger.kernel.org>
Subject: RE: [RFC 2/3] ACPI: move ACPI functionality out of r8152 driver
Thread-Topic: [RFC 2/3] ACPI: move ACPI functionality out of r8152 driver
Thread-Index: AQHVWgITZZ4dwXs8CES9WUAD0zcVmKcKGJidgAAv6rA=
Date:   Sat, 24 Aug 2019 13:24:20 +0000
Message-ID: <b3062089954f43259f8dfce9076b78ad@AUSX13MPC101.AMER.DELL.COM>
References: <b84b32cb144f4ba8918ee2406e69275a@AUSX13MPS303.AMER.DELL.COM>
 <87blwe272v.fsf@miraculix.mork.no>
In-Reply-To: <87blwe272v.fsf@miraculix.mork.no>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.24.60]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-24_08:2019-08-23,2019-08-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 clxscore=1011 priorityscore=1501 lowpriorityscore=0
 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1908240149
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 clxscore=1011
 suspectscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1908240149
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCasO4cm4gTW9yayA8Ympvcm5A
bW9yay5ubz4NCj4gU2VudDogU2F0dXJkYXksIEF1Z3VzdCAyNCwgMjAxOSA1OjI2IEFNDQo+IFRv
OiBIeWRlLCBDaGFybGVzIC0gRGVsbCBUZWFtDQo+IENjOiBsaW51eC1hY3BpQHZnZXIua2VybmVs
Lm9yZzsgTGltb25jaWVsbG8sIE1hcmlvOyBvbGl2ZXJAbmV1a3VtLm9yZzsNCj4gbmljX3N3c2RA
cmVhbHRlay5jb207IGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtS
RkMgMi8zXSBBQ1BJOiBtb3ZlIEFDUEkgZnVuY3Rpb25hbGl0eSBvdXQgb2YgcjgxNTIgZHJpdmVy
DQo+IA0KPiANCj4gW0VYVEVSTkFMIEVNQUlMXQ0KPiANCj4gPENoYXJsZXMuSHlkZUBkZWxsdGVh
bS5jb20+IHdyaXRlczoNCj4gDQo+ID4gVGhpcyBjaGFuZ2UgbW92ZXMgQUNQSSBmdW5jdGlvbmFs
aXR5IG91dCBvZiB0aGUgUmVhbHRlayByODE1MiBkcml2ZXINCj4gPiB0byBpdHMgb3duIHNvdXJj
ZSBhbmQgaGVhZGVyIGZpbGUsIG1ha2luZyBpdCBhdmFpbGFibGUgdG8gb3RoZXINCj4gPiBkcml2
ZXJzIGFzIG5lZWRlZCBub3cgYW5kIGludG8gdGhlIGZ1dHVyZS4gIEF0IHRoZSB0aW1lIHRoaXMg
QUNQSQ0KPiA+IHNuaXBwZXQgd2FzIGludHJvZHVjZWQgaW4gMjAxNiwgb25seSB0aGUgUmVhbHRl
ayBkcml2ZXIgbWFkZSB1c2Ugb2YgaXQNCj4gPiBpbiBzdXBwb3J0IG9mIERlbGwncyBlbnRlcnBy
aXNlIElUIHBvbGljeSBlZmZvcnRzLiAgVGhlcmUgY29tZXMgbm93IGENCj4gPiBuZWVkIGZvciB0
aGlzIHNhbWUgc3VwcG9ydCBpbiBhIGRpZmZlcmVudCBkcml2ZXIsIGFsc28gaW4gc3VwcG9ydCBv
Zg0KPiA+IERlbGwncyBlbnRlcnByaXNlIElUIHBvbGljeSBlZmZvcnRzLg0KPiANCj4gV2h5IG5v
dCBtYWtlIGEgc3RhbmRhbG9uZSBkcml2ZXIgb3V0IG9mIHRoaXMsIG1ha2luZyB0aGUgTUFDIGFk
ZHJlc3MgKGFuZA0KPiBvdGhlciBzeXN0ZW0gc3BlY2lmYyBvYmplY3RzPykgYXZhaWxhYmxlIHRv
IHVzZXJzcGFjZT8gVGhlbiB5b3UgY2FuIGp1c3QNCj4gZGlzdHJpYnV0ZSB1cGRhdGVkIHVkZXYg
cnVsZXMgb3Igc3lzdGVtZCB1bml0cyBvciB3aGF0ZXZlciBmb3IgdGhlIG5leHQgZG9ja2luZw0K
PiBwcm9kdWN0Lg0KPiANCj4gSSBkb24ndCB0aGluayBzeXN0ZW0gc3BlY2lmaWMgcG9saWNpZXMg
c2hvdWxkIGJlIHB1dCBpbnRvIGRldmljZSBkcml2ZXJzLiAgVXNlcnMgd2lsbA0KPiBjb21iaW5l
IHN5c3RlbXMgYW5kIGRldmljZXMgaW4gd2F5cyB5b3UgZG9uJ3QgZm9yZXNlZSwgYW5kIG1heSBo
YXZlIGdvb2QNCj4gcmVhc29ucyB0byB3YW50IHNvbWUgbm9uLWRlZmF1bHQgcG9saWN5IGV2ZW4g
Zm9yIHN1cHBvcnRlZCBjb21iaW5hdGlvbnMuDQoNCkkgcmVjYWxsIHRoYXQgd2hlbiB0aGlzIHdh
cyBmaXJzdCBkb25lIGZvciByODE1MiB3ZSBhY3R1YWxseSBleHBlcmltZW50ZWQgd2l0aCBleGFj
dGx5DQp0aGF0IGFuZCByYW4gaW50byB0d28gcHJvYmxlbXM6DQoNCjEpIFdpdGggdXNlcnNwYWNl
IHJhY2VzIHdpdGggZXRoZXJuZXQgZGV2aWNlIHJlbmFtaW5nDQoyKSBUaGUgZGV0YWlscyBuZWVk
ZWQgdG8gdGVsbCB3aGljaCBkZXZpY2VzIHRoaXMgc2hvdWxkIGFwcGx5IHRvIChzdWNoIGFzIGVG
dXNlIHNldHRpbmdzDQpvciBvdGhlciBpZGVudGlmeWluZyBmYWN0b3JzKSBhcmVuJ3QgZXhwb3J0
ZWQgdG8gdXNlcnNwYWNlLg0KDQpXZSBvbmx5IHdhbnQgdGhpcyBhcHBseWluZyB0byBkZXZpY2Vz
IHRoYXQga2VlcCB0aGUgc2FtZSBwb2xpY3kgaW4gdGhlIGZpcm13YXJlIGZvcg0KdGhpbmdzIGxp
a2UgUFhFIG9yIEhUVFAgYm9vdGluZyBhbmQgZHVhbCBib290aW5nIG90aGVyIG9wZXJhdGluZyBz
eXN0ZW1zLg0KV2UndmUgYmVlbiB2ZXJ5IGNhcmVmdWwgaW4gcjgxNTIgdGhhdCBNQUMgcGFzc3Ro
cm91Z2ggb25seSBhcHBsaWVzIHRvIHRoZSBjb3JyZWN0IGRldmljZXMNCndpdGggdW5pcXVlIGlk
ZW50aWZpZXJzIHRvIGJlIGEgRGVsbCBkb2NrIGFzIHN1Y2guDQoNCj4gDQo+IElmIHlvdSByZWFs
bHkgd2FudCB0byBoYXZlIHRoaXMgcG9saWN5IGluIHRoZSBkcml2ZXIocyksIHRoZW4gcGxlYXNl
IGNvbnNpZGVyDQo+IGV4dGVuZGluZyBldGhfcGxhdGZvcm1fZ2V0X21hY19hZGRyZXNzKCkgd2l0
aCBhbiB4ODYvYWNwaSBtZXRob2QuICBUaGlzIHdpbGwNCj4gbWFrZSB0aGUgZGV2aWNlIGRyaXZl
ciBjb2RlIHN1cHBvcnQgZmV0Y2hpbmcgdGhlIG1hYyBhZGRyZXNzIGZyb20gZGV2aWNlIHRyZWUN
Cj4gYW5kIFNwYXJjIGlkcHJvbXMgdG9vLiAgUHJvdmlkZWQgdGhlIG5ldGRldiBmb2xrcyB0aGlu
Z3MgdGhpcyBpcyBPSywgb2YgY291cnNlLg0KPiBUaGlzIG5lZWRzIHRvIGJlIGRpc2N1c3NlZCB0
aGVyZSwgbGlrZSBnZXRfbWFpbnRhaW5lci5wbCB3b3VsZCBoYXZlIHRvbGQgeW91Lg0KPiANCj4g
TWFraW5nIHN1cmUgd2UgY2FuIG1vZGlmeSB0aGUgTUFDIGFkZHJlc3Mgb2YgVVNCIGV0aGVybmV0
IGRldmljZXMgaXMNCj4gb2J2aW91c2x5IGEgZ29vZCB0aGluZyByZWdhcmRsZXNzIG9mIGhvdy93
aGVyZSB5b3UgZmV0Y2ggaXQuDQo+IA0KPiANCj4gDQo+IA0KPiANCj4gQmrDuHJuDQo=
