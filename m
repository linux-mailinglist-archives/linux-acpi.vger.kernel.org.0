Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 884DB8ED78
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Aug 2019 15:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732437AbfHON4B (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Aug 2019 09:56:01 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:17468 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732321AbfHON4B (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 15 Aug 2019 09:56:01 -0400
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7FDtEHK032292;
        Thu, 15 Aug 2019 09:56:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=u7Lgalqk/Dt1oEZypzRsImlDzyPBiir8wp79u1F1Ch0=;
 b=YreAGQXHFbZINJf5dnTbfDfeGGMHb+B3Xlgai45WDZLvZPz3XI80v7OlHX/eFAPgf3RU
 35hXyp24KCln4BCbNSsBoksytNgiJ4JNiM2vtUdlHdsOuKmKQJ6dxOsDgJm1qW2YXxbf
 PUorKUcRWYv1+IbyOpQsrMb1xYyWjuoUKkTCZeYo+QITXPUz7NOUhkPbSulGtboa6Xt0
 Hd3k+2li/YVdgWFBdoTpZcX7P1MPlCRjRhQAapXAqyUEGM4+YDcKWNfPCkEDtAAQ/S5H
 EIokbjeKUIaCsqgyai3DsFvyY68Qq742XvqLpQPc37sE7tSTBzwoqvlCdltvPxjQzfqH xw== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 2ud8g38238-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Aug 2019 09:56:00 -0400
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7FDraLm134310;
        Thu, 15 Aug 2019 09:55:59 -0400
Received: from ausxippc106.us.dell.com (AUSXIPPC106.us.dell.com [143.166.85.156])
        by mx0a-00154901.pphosted.com with ESMTP id 2ud57vb34m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Aug 2019 09:55:59 -0400
X-LoopCount0: from 10.166.132.130
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="448246534"
From:   <Mario.Limonciello@dell.com>
To:     <airlied@gmail.com>, <kherbst@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>,
        <rafael.j.wysocki@intel.com>, <alex.hung@canonical.com>,
        <bskeggs@redhat.com>, <airlied@redhat.com>
Subject: RE: [Nouveau] [PATCH 1/7] Revert "ACPI / OSI: Add OEM _OSI string to
 enable dGPU direct output"
Thread-Topic: [Nouveau] [PATCH 1/7] Revert "ACPI / OSI: Add OEM _OSI string to
 enable dGPU direct output"
Thread-Index: AQGgd6rdZMP3IawUTGaO286TGix+WwEoseSWASaOw1KnU3bBEA==
Date:   Thu, 15 Aug 2019 13:55:39 +0000
Message-ID: <5e05532328324d01bc554c573f6298f8@AUSX13MPC101.AMER.DELL.COM>
References: <20190814213118.28473-1-kherbst@redhat.com>
 <20190814213118.28473-2-kherbst@redhat.com>
 <CAPM=9ty7yEUqKrcixV1tTuWCpyh6UikA3rxX8BF1E3fDb6WLQQ@mail.gmail.com>
In-Reply-To: <CAPM=9ty7yEUqKrcixV1tTuWCpyh6UikA3rxX8BF1E3fDb6WLQQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-08-15T13:55:19.4663444Z;
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
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908150146
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908150146
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1hY3BpLW93bmVyQHZn
ZXIua2VybmVsLm9yZyA8bGludXgtYWNwaS1vd25lckB2Z2VyLmtlcm5lbC5vcmc+IE9uDQo+IEJl
aGFsZiBPZiBEYXZlIEFpcmxpZQ0KPiBTZW50OiBXZWRuZXNkYXksIEF1Z3VzdCAxNCwgMjAxOSA1
OjQ4IFBNDQo+IFRvOiBLYXJvbCBIZXJic3QNCj4gQ2M6IExLTUw7IExpbnV4IEFDUEk7IGRyaS1k
ZXZlbDsgbm91dmVhdTsgUmFmYWVsIEogLiBXeXNvY2tpOyBBbGV4IEh1bmc7IEJlbg0KPiBTa2Vn
Z3M7IERhdmUgQWlybGllDQo+IFN1YmplY3Q6IFJlOiBbTm91dmVhdV0gW1BBVENIIDEvN10gUmV2
ZXJ0ICJBQ1BJIC8gT1NJOiBBZGQgT0VNIF9PU0kgc3RyaW5nIHRvDQo+IGVuYWJsZSBkR1BVIGRp
cmVjdCBvdXRwdXQiDQo+IA0KPiBPbiBUaHUsIDE1IEF1ZyAyMDE5IGF0IDA3OjMxLCBLYXJvbCBI
ZXJic3QgPGtoZXJic3RAcmVkaGF0LmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBUaGlzIHJldmVydHMg
Y29tbWl0IDI4NTg2YTUxZWVhNjY2ZDU1MzFiY2FlZjJmNjhlNGFiYmQ4NzI0MmMuDQo+ID4NCj4g
PiBUaGUgb3JpZ2luYWwgY29tbWl0IG1lc3NhZ2UgZGlkbid0IGV2ZW4gbWFrZSBzZW5zZS4gQU1E
IF9kb2VzXyBzdXBwb3J0IGl0IGFuZA0KPiA+IGl0IHdvcmtzIHdpdGggTm91dmVhdSBhcyB3ZWxs
Lg0KPiA+DQo+ID4gQWxzbyB3aGF0IHdhcyB0aGUgaXNzdWUgYmVpbmcgc29sdmVkIGhlcmU/IE5v
IHJlZmVyZW5jZXMgdG8gYW55IGJ1Z3MgYW5kIG5vdA0KPiA+IGV2ZW4gZXhwbGFpbmluZyBhbnkg
aXNzdWUgYXQgYWxsIGlzbid0IHRoZSB3YXkgd2UgZG8gdGhpbmdzLg0KPiA+DQo+ID4gQW5kIGV2
ZW4gaWYgaXQgbWVhbnMgYSBtdXhlZCBkZXNpZ24sIHRoZW4gdGhlIGZpeCBpcyB0byBtYWtlIGl0
IHdvcmsgaW5zaWRlIHRoZQ0KPiA+IGRyaXZlciwgbm90IGFkZGluZyBzb21lIGhhY2t5IHdvcmth
cm91bmQgdGhyb3VnaCBBQ1BJIHRyaWNrcy4NCj4gPg0KPiA+IEFuZCB3aGF0IG91dCBvZiB0cmVl
IGRyaXZlcnMgZG8gb3IgZG8gbm90IHN1cHBvcnQgd2UgZG9uJ3QgY2FyZSBvbmUgYml0IGFueXdh
eS4NCj4gPg0KPiANCj4gSSB0aGluayB0aGUgcmV2ZXJ0cyBzaG91bGQgYmUgbWVyZ2VkIHZpYSBS
YWZhZWwncyB0cmVlIGFzIHRoZSBvcmlnaW5hbA0KPiBwYXRjaGVzIHdlbnQgaW4gdmlhIHRoZXJl
LCBhbmQgd2Ugc2hvdWxkIGdldCB0aGVtIGluIGFzYXAuDQo+IA0KPiBBY2tlZC1ieTogRGF2ZSBB
aXJsaWUgPGFpcmxpZWRAcmVkaGF0LmNvbT4NCj4gRGF2ZS4NCg0KVGhlcmUgYXJlIGRlZmluaXRl
bHkgZ29pbmcgdG8gYmUgcmVncmVzc2lvbnMgb24gbWFjaGluZXMgaW4gdGhlIGZpZWxkIHdpdGgg
dGhlDQppbiB0cmVlIGRyaXZlcnMgYnkgcmV2ZXJ0aW5nIHRoaXMuICBJIHRoaW5rIHdlIHNob3Vs
ZCBoYXZlIGFuIGFuc3dlciBmb3IgYWxsIG9mIHRob3NlDQpiZWZvcmUgdGhpcyByZXZlcnQgaXMg
YWNjZXB0ZWQuDQoNClJlZ2FyZGluZyBzeXN0ZW1zIHdpdGggSW50ZWwrTlZJRElBLCB3ZSdsbCBo
YXZlIHRvIHdvcmsgd2l0aCBwYXJ0bmVycyB0byBjb2xsZWN0DQpzb21lIGluZm9ybWF0aW9uIG9u
IHRoZSBpbXBhY3Qgb2YgcmV2ZXJ0aW5nIHRoaXMuDQoNCldoZW4gdGhpcyBpcyB1c2VkIG9uIGEg
c3lzdGVtIHdpdGggSW50ZWwrQU1EIHRoZSBBU0wgY29uZmlndXJlcyBBTUQgR1BVIHRvIHVzZQ0K
Ikh5YnJpZCBHcmFwaGljcyIgd2hlbiBvbiBXaW5kb3dzIGFuZCAiUG93ZXIgRXhwcmVzcyIgYW5k
ICJTd2l0Y2hhYmxlIEdyYXBoaWNzIg0Kd2hlbiBvbiBMaW51eC4NCg0KSSBmZWVsIHdlIG5lZWQg
YSBrbm9iIGFuZC9vciBETUkgZGV0ZWN0aW9uIHRvIGFmZmVjdCB0aGUgY2hhbmdlcyB0aGF0IHRo
ZSBBU0wNCm5vcm1hbGx5IHBlcmZvcm1zLg0K
