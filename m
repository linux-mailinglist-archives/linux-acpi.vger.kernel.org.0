Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA1A8EE0F
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Aug 2019 16:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732567AbfHOOUD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Aug 2019 10:20:03 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:48618 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730497AbfHOOUC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 15 Aug 2019 10:20:02 -0400
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7FEAWsm009313;
        Thu, 15 Aug 2019 10:20:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=2AbcUHt8nmf+Gvc+/EDnMhyOSV0Nccrd9OCKtoUAeAg=;
 b=NU6dHIhMltgwktyc1GcAwsUQ6Hvr7lVDFCo/nWvp8jA23S4wrapd0vN+rZNWoEk13x5U
 d0t2ghK0T75Tf9PY2kjiu4z3KMFKLg54ZJAqlTj/m7+vhYX8AoiV0ewPTO68rVjGJ4rO
 uxkM3Mkk5CTTYMsfuDYeDsXLnBDZLUnMDynfNpFLgxOKInol+WPl6cZEoyECMlaXZ+9k
 hv5bEZbw029BPCqJdjvkm4AeMOCRa9vi+SXvl6OtTYKTjouFmA/tUVaZjPmf6HuPFH0z
 vY7dsuwJp1TIVqJ6z23n15WfBjmmB1SZAp8Iyof1B6/ghXQ8OHFm4ez2jnY1Rk0b6wZn Qg== 
Received: from mx0b-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 2ucytb20ed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Aug 2019 10:20:01 -0400
Received: from pps.filterd (m0090350.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7FEDCva047352;
        Thu, 15 Aug 2019 10:20:01 -0400
Received: from ausxippc110.us.dell.com (AUSXIPPC110.us.dell.com [143.166.85.200])
        by mx0b-00154901.pphosted.com with ESMTP id 2ud7t4sean-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Aug 2019 10:20:01 -0400
X-LoopCount0: from 10.166.132.129
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="844156564"
From:   <Mario.Limonciello@dell.com>
To:     <kherbst@redhat.com>
CC:     <airlied@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <nouveau@lists.freedesktop.org>, <rafael.j.wysocki@intel.com>,
        <alex.hung@canonical.com>, <bskeggs@redhat.com>,
        <airlied@redhat.com>
Subject: RE: [Nouveau] [PATCH 1/7] Revert "ACPI / OSI: Add OEM _OSI string to
 enable dGPU direct output"
Thread-Topic: [Nouveau] [PATCH 1/7] Revert "ACPI / OSI: Add OEM _OSI string to
 enable dGPU direct output"
Thread-Index: AQGgd6rdZMP3IawUTGaO286TGix+WwEoseSWASaOw1KnU3bBEIAAWGiA//+vQEA=
Date:   Thu, 15 Aug 2019 14:19:58 +0000
Message-ID: <3fc22fe8bcaf4304bb07534b61c4de90@AUSX13MPC101.AMER.DELL.COM>
References: <20190814213118.28473-1-kherbst@redhat.com>
 <20190814213118.28473-2-kherbst@redhat.com>
 <CAPM=9ty7yEUqKrcixV1tTuWCpyh6UikA3rxX8BF1E3fDb6WLQQ@mail.gmail.com>
 <5e05532328324d01bc554c573f6298f8@AUSX13MPC101.AMER.DELL.COM>
 <CACO55tsDA1WpMGtAPqUJpWt0AmPDnv9LuC09g2KB5GXB-VSCew@mail.gmail.com>
In-Reply-To: <CACO55tsDA1WpMGtAPqUJpWt0AmPDnv9LuC09g2KB5GXB-VSCew@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-08-15T14:19:56.7925463Z;
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
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-15_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=944 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908150147
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908150147
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

PiA+IFRoZXJlIGFyZSBkZWZpbml0ZWx5IGdvaW5nIHRvIGJlIHJlZ3Jlc3Npb25zIG9uIG1hY2hp
bmVzIGluIHRoZSBmaWVsZCB3aXRoIHRoZQ0KPiA+IGluIHRyZWUgZHJpdmVycyBieSByZXZlcnRp
bmcgdGhpcy4gIEkgdGhpbmsgd2Ugc2hvdWxkIGhhdmUgYW4gYW5zd2VyIGZvciBhbGwgb2YNCj4g
dGhvc2UNCj4gPiBiZWZvcmUgdGhpcyByZXZlcnQgaXMgYWNjZXB0ZWQuDQo+ID4NCj4gPiBSZWdh
cmRpbmcgc3lzdGVtcyB3aXRoIEludGVsK05WSURJQSwgd2UnbGwgaGF2ZSB0byB3b3JrIHdpdGgg
cGFydG5lcnMgdG8NCj4gY29sbGVjdA0KPiA+IHNvbWUgaW5mb3JtYXRpb24gb24gdGhlIGltcGFj
dCBvZiByZXZlcnRpbmcgdGhpcy4NCj4gPg0KPiA+IFdoZW4gdGhpcyBpcyB1c2VkIG9uIGEgc3lz
dGVtIHdpdGggSW50ZWwrQU1EIHRoZSBBU0wgY29uZmlndXJlcyBBTUQgR1BVIHRvDQo+IHVzZQ0K
PiA+ICJIeWJyaWQgR3JhcGhpY3MiIHdoZW4gb24gV2luZG93cyBhbmQgIlBvd2VyIEV4cHJlc3Mi
IGFuZCAiU3dpdGNoYWJsZQ0KPiBHcmFwaGljcyINCj4gPiB3aGVuIG9uIExpbnV4Lg0KPiANCj4g
YW5kIHdoYXQncyBleGFjdGx5IHRoZSBkaWZmZXJlbmNlIGJldHdlZW4gdGhvc2U/IEFuZCB3aGF0
J3MgdGhlIGFjdHVhbA0KPiBpc3N1ZSBoZXJlPw0KDQpEUC9IRE1JIGlzIG5vdCBkZXRlY3RlZCB1
bmxlc3MgcGx1Z2dlZCBpbiBhdCBib290dXAuICBJdCdzIGR1ZSB0byBtaXNzaW5nIEhQRA0KZXZl
bnRzLg0KDQo+IA0KPiBXZSBhbHJlYWR5IGhhdmUgdGhlIFBSSU1FIG9mZmxvYWRpbmcgaW4gcGxh
Y2UgYW5kIGlmIHRoYXQncyBub3QNCj4gZW5vdWdoLCB3ZSBzaG91bGQgd29yayBvbiBleHRlbmRp
bmcgaXQsIG5vdCBhZGRpbmcgc29tZSBBQ1BJIGJhc2VkDQo+IHdvcmthcm91bmRzLCBiZWNhdXNl
IHRoYXQncyBleGFjdGx5IGhvdyB0aGF0IGxvb2tzIGxpa2UuDQo+IA0KPiBBbHNvLCB3YXMgdGhp
cyBkaXNjdXNzZWQgd2l0aCBhbnlib2R5IGludm9sdmVkIGluIHRoZSBkcm0gc3Vic3lzdGVtPw0K
PiANCj4gPg0KPiA+IEkgZmVlbCB3ZSBuZWVkIGEga25vYiBhbmQvb3IgRE1JIGRldGVjdGlvbiB0
byBhZmZlY3QgdGhlIGNoYW5nZXMgdGhhdCB0aGUgQVNMDQo+ID4gbm9ybWFsbHkgcGVyZm9ybXMu
DQo+IA0KPiBXaHkgZG8gd2UgaGF2ZSB0byBkbyB0aGF0IG9uIGEgZmlybXdhcmUgbGV2ZWwgYXQg
YWxsPw0KDQpGb2xrcyBmcm9tIEFNRCBHcmFwaGljcyB0ZWFtIHJlY29tbWVuZGVkIHRoaXMgYXBw
cm9hY2guICBGcm9tIHRoZWlyIHBlcnNwZWN0aXZlDQppdCdzIG5vdCBhIHdvcmthcm91bmQuICBU
aGV5IHZpZXcgdGhpcyBhcyBhIGRpZmZlcmVudCBhcmNoaXRlY3R1cmUgZm9yIEFNRCBncmFwaGlj
cyBkcml2ZXIgb24NCldpbmRvd3MgYW5kIEFNRCBncmFwaGljcyB3LyBhbWRncHUgZHJpdmVyLiAg
VGhleSBoYXZlIGRpZmZlcmVudCBBU0wgcGF0aHMgdXNlZCBmb3INCmVhY2guDQo=
