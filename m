Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6BE9F5D2
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Aug 2019 00:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbfH0WI3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 27 Aug 2019 18:08:29 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:55644 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725835AbfH0WI3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 27 Aug 2019 18:08:29 -0400
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7RM4iEl022775;
        Tue, 27 Aug 2019 18:08:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dellteam.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=wgrTYR5ymKufZ96muI6ajzN+6iQVN1o0kLL1VmOoRa4=;
 b=Vs1Ot25Sycemg96iJyziOWiofWtwAEe5Jr8wHbIR/fjSi1xdymbFX93tWvLDpCNXd1dF
 v7oFyn60t5F1nzOFTzTpf5woo6peIuPOK+59J4lTmtkZ0gUP3cbO+ObI36PBk3tvC/ki
 f3aiHHfVL8LajWTR9KNnbOFp3NJ9M2pA/UUcfnK+B6t5K+lhX/nPBDmSM4KR7CRypN0C
 tP1n35Foymxmhswe2Ygtv8TCz43FQjvIt1sJI0P6TPW1OjMeH8CLsmfABbw0f/2Lcu5P
 548UD54M+miEZ2JtBaiZjH7QNRnRmtov/1ROJPzEM9EIbQZIAf3VjHWUzOS49D79IwEF sQ== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 2uk2q45t79-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Aug 2019 18:08:27 -0400
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7RM85kU170783;
        Tue, 27 Aug 2019 18:08:27 -0400
Received: from ausxipps306.us.dell.com (AUSXIPPS306.us.dell.com [143.166.148.156])
        by mx0b-00154901.pphosted.com with ESMTP id 2un4ydgb7d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Aug 2019 18:08:27 -0400
X-LoopCount0: from 10.166.132.131
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="366426943"
From:   <Charles.Hyde@dellteam.com>
To:     <Mario.Limonciello@dell.com>, <bjorn@mork.no>
CC:     <linux-acpi@vger.kernel.org>, <oliver@neukum.org>,
        <nic_swsd@realtek.com>, <linux-usb@vger.kernel.org>
Subject: RE: [RFC 2/3] ACPI: move ACPI functionality out of r8152 driver
Thread-Topic: [RFC 2/3] ACPI: move ACPI functionality out of r8152 driver
Thread-Index: AQHVWgITZZ4dwXs8CES9WUAD0zcVmKcKGJhogACFrgCABPPFAA==
Date:   Tue, 27 Aug 2019 22:08:24 +0000
Message-ID: <6e404c3d3c344342b09b475e64b4ff3e@AUSX13MPS303.AMER.DELL.COM>
References: <b84b32cb144f4ba8918ee2406e69275a@AUSX13MPS303.AMER.DELL.COM>
 <87blwe272v.fsf@miraculix.mork.no>
 <b3062089954f43259f8dfce9076b78ad@AUSX13MPC101.AMER.DELL.COM>
In-Reply-To: <b3062089954f43259f8dfce9076b78ad@AUSX13MPC101.AMER.DELL.COM>
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
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-27_04:2019-08-27,2019-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1906280000 definitions=main-1908270208
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=999 malwarescore=0
 mlxscore=0 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1908270207
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQo+ID4gPiBUaGlzIGNoYW5nZSBtb3ZlcyBBQ1BJIGZ1bmN0aW9uYWxpdHkgb3V0IG9mIHRoZSBS
ZWFsdGVrIHI4MTUyIGRyaXZlcg0KPiA+ID4gdG8gaXRzIG93biBzb3VyY2UgYW5kIGhlYWRlciBm
aWxlLCBtYWtpbmcgaXQgYXZhaWxhYmxlIHRvIG90aGVyDQo+ID4gPiBkcml2ZXJzIGFzIG5lZWRl
ZCBub3cgYW5kIGludG8gdGhlIGZ1dHVyZS4gIEF0IHRoZSB0aW1lIHRoaXMgQUNQSQ0KPiA+ID4g
c25pcHBldCB3YXMgaW50cm9kdWNlZCBpbiAyMDE2LCBvbmx5IHRoZSBSZWFsdGVrIGRyaXZlciBt
YWRlIHVzZSBvZg0KPiA+ID4gaXQgaW4gc3VwcG9ydCBvZiBEZWxsJ3MgZW50ZXJwcmlzZSBJVCBw
b2xpY3kgZWZmb3J0cy4gIFRoZXJlIGNvbWVzDQo+ID4gPiBub3cgYSBuZWVkIGZvciB0aGlzIHNh
bWUgc3VwcG9ydCBpbiBhIGRpZmZlcmVudCBkcml2ZXIsIGFsc28gaW4NCj4gPiA+IHN1cHBvcnQg
b2YgRGVsbCdzIGVudGVycHJpc2UgSVQgcG9saWN5IGVmZm9ydHMuDQo+ID4NCj4gPiBXaHkgbm90
IG1ha2UgYSBzdGFuZGFsb25lIGRyaXZlciBvdXQgb2YgdGhpcywgbWFraW5nIHRoZSBNQUMgYWRk
cmVzcw0KPiA+IChhbmQgb3RoZXIgc3lzdGVtIHNwZWNpZmMgb2JqZWN0cz8pIGF2YWlsYWJsZSB0
byB1c2Vyc3BhY2U/IFRoZW4geW91DQo+ID4gY2FuIGp1c3QgZGlzdHJpYnV0ZSB1cGRhdGVkIHVk
ZXYgcnVsZXMgb3Igc3lzdGVtZCB1bml0cyBvciB3aGF0ZXZlcg0KPiA+IGZvciB0aGUgbmV4dCBk
b2NraW5nIHByb2R1Y3QuDQo+ID4NCj4gPiBJIGRvbid0IHRoaW5rIHN5c3RlbSBzcGVjaWZpYyBw
b2xpY2llcyBzaG91bGQgYmUgcHV0IGludG8gZGV2aWNlDQo+ID4gZHJpdmVycy4gIFVzZXJzIHdp
bGwgY29tYmluZSBzeXN0ZW1zIGFuZCBkZXZpY2VzIGluIHdheXMgeW91IGRvbid0DQo+ID4gZm9y
ZXNlZSwgYW5kIG1heSBoYXZlIGdvb2QgcmVhc29ucyB0byB3YW50IHNvbWUgbm9uLWRlZmF1bHQg
cG9saWN5IGV2ZW4NCj4gZm9yIHN1cHBvcnRlZCBjb21iaW5hdGlvbnMuDQo+IA0KPiBJIHJlY2Fs
bCB0aGF0IHdoZW4gdGhpcyB3YXMgZmlyc3QgZG9uZSBmb3IgcjgxNTIgd2UgYWN0dWFsbHkgZXhw
ZXJpbWVudGVkIHdpdGgNCj4gZXhhY3RseSB0aGF0IGFuZCByYW4gaW50byB0d28gcHJvYmxlbXM6
DQo+IA0KPiAxKSBXaXRoIHVzZXJzcGFjZSByYWNlcyB3aXRoIGV0aGVybmV0IGRldmljZSByZW5h
bWluZw0KPiAyKSBUaGUgZGV0YWlscyBuZWVkZWQgdG8gdGVsbCB3aGljaCBkZXZpY2VzIHRoaXMg
c2hvdWxkIGFwcGx5IHRvIChzdWNoIGFzIGVGdXNlDQo+IHNldHRpbmdzIG9yIG90aGVyIGlkZW50
aWZ5aW5nIGZhY3RvcnMpIGFyZW4ndCBleHBvcnRlZCB0byB1c2Vyc3BhY2UuDQo+IA0KPiBXZSBv
bmx5IHdhbnQgdGhpcyBhcHBseWluZyB0byBkZXZpY2VzIHRoYXQga2VlcCB0aGUgc2FtZSBwb2xp
Y3kgaW4gdGhlDQo+IGZpcm13YXJlIGZvciB0aGluZ3MgbGlrZSBQWEUgb3IgSFRUUCBib290aW5n
IGFuZCBkdWFsIGJvb3Rpbmcgb3RoZXIgb3BlcmF0aW5nDQo+IHN5c3RlbXMuDQo+IFdlJ3ZlIGJl
ZW4gdmVyeSBjYXJlZnVsIGluIHI4MTUyIHRoYXQgTUFDIHBhc3N0aHJvdWdoIG9ubHkgYXBwbGll
cyB0byB0aGUNCj4gY29ycmVjdCBkZXZpY2VzIHdpdGggdW5pcXVlIGlkZW50aWZpZXJzIHRvIGJl
IGEgRGVsbCBkb2NrIGFzIHN1Y2guDQo+IA0KPiA+DQo+ID4gSWYgeW91IHJlYWxseSB3YW50IHRv
IGhhdmUgdGhpcyBwb2xpY3kgaW4gdGhlIGRyaXZlcihzKSwgdGhlbiBwbGVhc2UNCj4gPiBjb25z
aWRlciBleHRlbmRpbmcgZXRoX3BsYXRmb3JtX2dldF9tYWNfYWRkcmVzcygpIHdpdGggYW4geDg2
L2FjcGkNCj4gPiBtZXRob2QuICBUaGlzIHdpbGwgbWFrZSB0aGUgZGV2aWNlIGRyaXZlciBjb2Rl
IHN1cHBvcnQgZmV0Y2hpbmcgdGhlDQo+ID4gbWFjIGFkZHJlc3MgZnJvbSBkZXZpY2UgdHJlZSBh
bmQgU3BhcmMgaWRwcm9tcyB0b28uICBQcm92aWRlZCB0aGUgbmV0ZGV2DQo+IGZvbGtzIHRoaW5n
cyB0aGlzIGlzIE9LLCBvZiBjb3Vyc2UuDQo+ID4gVGhpcyBuZWVkcyB0byBiZSBkaXNjdXNzZWQg
dGhlcmUsIGxpa2UgZ2V0X21haW50YWluZXIucGwgd291bGQgaGF2ZSB0b2xkIHlvdS4NCj4gPg0K
PiA+IE1ha2luZyBzdXJlIHdlIGNhbiBtb2RpZnkgdGhlIE1BQyBhZGRyZXNzIG9mIFVTQiBldGhl
cm5ldCBkZXZpY2VzIGlzDQo+ID4gb2J2aW91c2x5IGEgZ29vZCB0aGluZyByZWdhcmRsZXNzIG9m
IGhvdy93aGVyZSB5b3UgZmV0Y2ggaXQuDQo+ID4NCj4gPg0KPiA+DQo+ID4NCj4gPg0KPiA+IEJq
w7hybg0KDQpCeSBtb3ZpbmcgYWNwaV9tYWNfcGFzc3RocnUuYyBpbnRvIGRyaXZlcnMvYWNwaS8s
IHdoYXQgaXMgdGhlIHN1Z2dlc3RlZCBlZGl0IHRvIE1ha2VmaWxlIGZvciB0aGlzPyAgSSBhbSB0
aGlua2luZyBpdCBjb3VsZCBiZSBhZGRlZCBpbW1lZGlhdGVseSBmb2xsb3dpbmcgdGhlIGNvbW1l
bnQgIlRoZXNlIGFyZSAocG90ZW50aWFsbHkpIHNlcGFyYXRlIG1vZHVsZXMiIHdpdGg6DQoNCmFw
aWMteSArPSBhY3BpX21hY19wYXNzdGhydS5vDQoNCkkgcmVtb3ZlZCBleHRyYSBzcGFjaW5nIGFi
b3ZlIGZvciBwb3N0aW5nIGhlcmUuDQoNClRoYW5rIHlvdSwNCkNoYXJsZXMgSHlkZQ0K
