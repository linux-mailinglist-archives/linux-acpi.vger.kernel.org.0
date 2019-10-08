Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05189CF099
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2019 03:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbfJHBoZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Oct 2019 21:44:25 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:10042 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726917AbfJHBoZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Oct 2019 21:44:25 -0400
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x981e6An011903;
        Mon, 7 Oct 2019 21:44:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=yCKdzxuAI15HqQkGoQIkK3L6z/InOYNfvaU8ZRq3CIQ=;
 b=hCzosoDzxt8GWMsLE6dI+YPFcXsRr6lotBZaMVgS956b2QJkePDWjC9i54KkIM9x7VMs
 W9i+ICPnso4G46yFcT3wcz5UZuBuNKrs9mnuwTVcFYD4IGCYjq6fCjthPLT6CxH4uvQP
 kLf30FXL77ZtWQB4Uio+67Tj6UIavyx8cO/K7oaATY668K9EOfah31AQeqGdFHAdV4HP
 KIa8DhIwMTXGhkU70oUDc+nu+ZbpPfxpylz9tFB24MYGFozHtH8t4h6wRH2s7cL0Q7wd
 sU9fIBMpY9lgLr2CWK1UY/Hzi6l84kqt3oY/QE9CaVs4mEKi/dDYyINCaamsjNVNUWXP uw== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 2vem8vkg54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Oct 2019 21:44:22 -0400
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x981cMWo078962;
        Mon, 7 Oct 2019 21:44:21 -0400
Received: from ausc60ps301.us.dell.com (ausc60ps301.us.dell.com [143.166.148.206])
        by mx0b-00154901.pphosted.com with ESMTP id 2vemenrr8q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Oct 2019 21:44:21 -0400
X-LoopCount0: from 10.166.132.133
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="1360428870"
From:   <Mario.Limonciello@dell.com>
To:     <pmenzel@molgen.mpg.de>, <rjw@rjwysocki.net>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ACPI: PM: Revert "ACPI / PM: Blacklist Low Power S0 Idle
 _DSM for Dell XPS13 9360"
Thread-Topic: [PATCH] ACPI: PM: Revert "ACPI / PM: Blacklist Low Power S0 Idle
 _DSM for Dell XPS13 9360"
Thread-Index: AQHVdIS2zGdNRDUjQk2wDaptzH3FCKdQLGgA///crxA=
Date:   Tue, 8 Oct 2019 01:44:17 +0000
Message-ID: <541d9bfa3ccf45b5b07e35e3eebb72ed@AUSX13MPC105.AMER.DELL.COM>
References: <1569514137-2307-1-git-send-email-mario.limonciello@dell.com>
 <97e66464-8407-fd58-21a6-aeb7736dec7b@molgen.mpg.de>
In-Reply-To: <97e66464-8407-fd58-21a6-aeb7736dec7b@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-07_05:2019-10-07,2019-10-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1910080016
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 clxscore=1015
 suspectscore=0 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910080016
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

PiBPbiAyNi4wOS4xOSAxODowOCwgTWFyaW8gTGltb25jaWVsbG8gd3JvdGU6DQo+ID4gVGhpcyBy
ZXZlcnRzIHBhcnQgb2YNCj4gPiBjb21taXQgNzE2MzBiN2E4MzJmICgiQUNQSSAvIFBNOiBCbGFj
a2xpc3QgTG93IFBvd2VyIFMwIElkbGUgX0RTTSBmb3INCj4gPiBEZWxsIFhQUzEzIDkzNjAiKSB0
byByZW1vdmUgdGhlIFMwaXggYmxhY2tsaXN0IGZvciB0aGUgWFBTIDkzNjAuDQo+ID4NCj4gPiBU
aGUgcHJvYmxlbXMgd2l0aCB0aGlzIHN5c3RlbSBvY2N1cnJlZCBpbiBvbmUgcG9zc2libGUgTlZN
RSBTU0Qgd2hlbg0KPiA+IHB1dHRpbmcgc3lzdGVtIGludG8gczBpeC4gIEFzIHRoZSBOVk1FIHNs
ZWVwIGJlaGF2aW9yIGhhcyBiZWVuDQo+ID4gYWRqdXN0ZWQgaW4gZDkxNmIxYmUgdGhpcyBpcyBl
eHBlY3RlZCB0byBiZSBub3cgcmVzb2x2ZWQuDQo+IA0KPiAxLiAgUGxlYXNlIGFkZCwgdGhhdCBp
dCB3YXMgdGhlIEh5bml4KD8pIFNTRC4NCj4gMi4gIFBsZWFzZSBhZGQgdGhlIGNvbW1pdCBtZXNz
YWdlIHN1bW1hcnkgb2YgZDkxNmIxYmUuDQo+IA0KPiAgICAgIG52bWUtcGNpOiB1c2UgaG9zdCBt
YW5hZ2VkIHBvd2VyIHN0YXRlIGZvciBzdXNwZW5kDQo+IA0KDQpSYWZhZWwsIGxldCBtZSBrbm93
IGlmIHlvdSB3YW50IG1lIHRvIGFkanVzdCB0aGUgY29tbWl0IG1lc3NhZ2UgYW5kIHJlc3VibWl0
DQpvciBpZiB5b3Ugd291bGQganVzdCBoYW5kbGUgdGhpcyB0YXNrLg0KDQo+ID4gQ2M6ICdQYXVs
IE1lbnplbCA8cG1lbnplbEBtb2xnZW4ubXBnLmRlPicNCj4gPiBCdWdMaW5rOiBodHRwczovL2J1
Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTE5NjkwNw0KPiA+IFNpZ25lZC1vZmYt
Ynk6IE1hcmlvIExpbW9uY2llbGxvIDxtYXJpby5saW1vbmNpZWxsb0BkZWxsLmNvbT4NCj4gDQo+
IFRhZyBpdCBmb3IgdGhlIHN0YWJsZSBzZXJpZXM/IGQ5MTZiMWJlIChmaXJzdCB0YWcgdjUuMy1y
YzEpIGlzIG5vdCB0YWdnZWQgZm9yIHN0YWJsZS4NCj4gDQoNCkFsdGhvdWdoIERlbGwgYXJyYW5n
ZWQgYSBsb3Qgb2YgdGVzdGluZyB3aXRoIHBhcnRuZXJzIEkgZG9uJ3QgZmVlbCBkOTE2YjFiZSBp
cyBhIHN0YWJsZQ0KY2FuZGlkYXRlLiAgUmFmYWVsIGZvdW5kIGEgY29ybmVyIGNhc2Ugd2l0aCBy
ZWdhcmRzIHRvIEFTUE0gY29uZmlndXJhdGlvbiBsYXN0IG1pbnV0ZQ0KaW4gNS4zcmNYLCBJIGZv
dW5kIGEgYW5vdGhlciBjb3JuZXIgY2FzZSByZWxhdGVkIHRvIG9yZGVyIG9mIGV2ZW50cyBhbmQg
dGltaW5nIGFyb3VuZA0KUEMxMCBlbnRyeSB0aGF0J3MgZ2V0dGluZyBmaXhlZCBpbiA1LjQuDQoN
Cj4gPiAtLS0NCj4gPiBUaGUgcGFydGljdWxhciBmYWlsaW5nIGNvbmZpZ3VyYXRpb24gd2FzIHJl
cG9ydGVkIGJ5IG9ubHkgZXZlciBmYWlsZWQNCj4gPiBmb3IgUGF1bCBNZW56ZWwsIHNvIGhvcGVm
dWxseSBoZSBjYW4gdGVzdCBvbiBoaXMgZmFpbGluZyBzeXN0ZW0uDQo+IA0KPiBJIHN1Y2Nlc3Nm
dWxseSB0ZXN0ZWQgTGludXggNS40LXJjMSsgd2l0aCB0aGlzIGNvbW1pdCBsYXN0IEZyaWRheSBv
biB0aGUgRGVsbCBYUFMNCj4gMTMgOTM2MC4NCj4gDQo+IFRlc3RlZC1ieTogUGF1bCBNZW56ZWwg
PHBtZW56ZWxAbW9sZ2VuLm1wZy5kZT4NCj4gDQoNCldlbGwgdGhhdCdzIGdyZWF0LCBhcHByZWNp
YXRlIHlvdXIgdGVzdGluZyBhbmQgY29uZmlybWF0aW9uLg0KDQo=
