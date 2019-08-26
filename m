Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1CF9D25C
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2019 17:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730464AbfHZPMB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 26 Aug 2019 11:12:01 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:24640 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730379AbfHZPMB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 26 Aug 2019 11:12:01 -0400
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7QFAZWK012848;
        Mon, 26 Aug 2019 11:12:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=GKC4YeZw79OgH/tBdyKtcyUL82OgDdgx1vnibhrrnvY=;
 b=ivyPuO9U5w9cRQV4o21mnU47QnqlD4dnwZl3A8qD1lebVTeETLnX21oEeehd5VD2+i+9
 Nu9lSq9NojpCQpYqvHF7n1bjTSEMUgnmFOwjLm+5tA3ftWD3x71rp+xdyGrmZqeYXmXy
 u5OsgErLvUYuEIWJ0hXLp1Wfu4mRobwHQ/ngJbuwcnPUc470+LkPLHiS54rSbOSRcACC
 ZbzGEE7xRjkYZxSS8Fye0gwh6HGEEVR0sXRQwL/r/lwH1bFQUKhNC6QT4qSPSre3EgHe
 9FuY2BHORvjhrSIrLdY+w/EaYZpUsxIHd+6+OXcNkZuMEIn8O+LhG1P8o4r01DQuXHHR kQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 2uk2xc6vfs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Aug 2019 11:12:00 -0400
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7QFBvcq065931;
        Mon, 26 Aug 2019 11:11:59 -0400
Received: from ausc60pc101.us.dell.com (ausc60pc101.us.dell.com [143.166.85.206])
        by mx0b-00154901.pphosted.com with ESMTP id 2ukjtpcgth-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Aug 2019 11:11:59 -0400
X-LoopCount0: from 10.166.135.97
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="1458070271"
From:   <Mario.Limonciello@dell.com>
To:     <oneukum@suse.com>, <Charles.Hyde@dellteam.com>,
        <linux-usb@vger.kernel.org>
CC:     <nic_swsd@realtek.com>, <linux-acpi@vger.kernel.org>
Subject: RE: [RFC 1/3] net: cdc_ncm: add get/set ethernet address functions
Thread-Topic: [RFC 1/3] net: cdc_ncm: add get/set ethernet address functions
Thread-Index: AQHVWgHa61WkHsDV5EiVn1+4CW4xcqcNeQGAgAAUCKA=
Date:   Mon, 26 Aug 2019 15:11:57 +0000
Message-ID: <bcdf2209ea3c482e980c0f3e64b87bca@AUSX13MPC101.AMER.DELL.COM>
References: <d3971424f9ee4b689b762721f671746a@AUSX13MPS303.AMER.DELL.COM>
 <1566809983.2612.2.camel@suse.com>
In-Reply-To: <1566809983.2612.2.camel@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-08-26T15:11:55.8694762Z;
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
 definitions=2019-08-26_08:2019-08-26,2019-08-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0
 impostorscore=0 adultscore=0 phishscore=0 mlxlogscore=900 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1908260158
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 spamscore=0
 impostorscore=0 clxscore=1015 mlxscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxlogscore=993 priorityscore=1501 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1908260158
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBPbGl2ZXIgTmV1a3VtIDxvbmV1
a3VtQHN1c2UuY29tPg0KPiBTZW50OiBNb25kYXksIEF1Z3VzdCAyNiwgMjAxOSA0OjAwIEFNDQo+
IFRvOiBIeWRlLCBDaGFybGVzIC0gRGVsbCBUZWFtOyBsaW51eC11c2JAdmdlci5rZXJuZWwub3Jn
DQo+IENjOiBMaW1vbmNpZWxsbywgTWFyaW87IG5pY19zd3NkQHJlYWx0ZWsuY29tOyBsaW51eC1h
Y3BpQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1JGQyAxLzNdIG5ldDogY2RjX25j
bTogYWRkIGdldC9zZXQgZXRoZXJuZXQgYWRkcmVzcyBmdW5jdGlvbnMNCj4gDQo+IA0KPiBbRVhU
RVJOQUwgRU1BSUxdDQo+IA0KPiBBbSBGcmVpdGFnLCBkZW4gMjMuMDguMjAxOSwgMjI6MjYgKzAw
MDAgc2NocmllYg0KPiBDaGFybGVzLkh5ZGVAZGVsbHRlYW0uY29tOg0KPiA+IFRoaXMgcGF0Y2gg
YWRkcyBzdXBwb3J0IGZvciBwdXNoaW5nIGEgTUFDIGFkZHJlc3Mgb3V0IHRvIFVTQiBiYXNlZA0K
PiA+IGV0aGVybmV0IGNvbnRyb2xsZXJzIGRyaXZlbiBieSBjZGNfbmNtLiAgV2l0aCB0aGlzIGNo
YW5nZSwgaWZjb25maWcgY2FuDQo+ID4gbm93IHNldCB0aGUgZGV2aWNlJ3MgTUFDIGFkZHJlc3Mu
ICBGb3IgZXhhbXBsZSwgdGhlIERlbGwgVW5pdmVyc2FsIERvY2sNCj4gPiBENjAwMCBpcyBkcml2
ZW4gYnkgY2RjX25jbS4gIFRoZSBENjAwMCBjYW4gbm93IGhhdmUgaXRzIE1BQyBhZGRyZXNzIHNl
dA0KPiA+IGJ5IGlmY29uZmlnLCBhcyBpdCBjYW4gYmUgZG9uZSBpbiBXaW5kb3dzLiAgVGhpcyB3
YXMgdGVzdGVkIHdpdGggYSBENjAwMA0KPiA+IHVzaW5nIGlmY29uZmlnIG9uIGFuIHg4NiBiYXNl
ZCBjaHJvbWVib29rLCB3aGVyZSBpcHJvdXRlMiBpcyBub3QNCj4gPiBhdmFpbGFibGUuDQo+IA0K
PiBUaGUgY29kZSBpcyBnb29kLiBCdXQgcGxhY2luZyBpdCBpbnRvIGNkY19uY20gbWVhbnMgdGhh
dCBjZGNfZXRoZXINCj4gb3Igb3RoZXIgZHJpdmVycyBjYW5ub3QgdXNlIGl0Lg0KPiANCj4gCVJl
Z2FyZHMNCj4gCQlPbGl2ZXINCg0KSXMgdGhpcyBtYXliZSBiZXR0ZXIgaW50ZW5kZWQgZm9yIHVz
Ym5ldCB0aGVuPw0K
