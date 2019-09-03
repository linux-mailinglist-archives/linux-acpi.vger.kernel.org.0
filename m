Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4554A71EF
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Sep 2019 19:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbfICRuW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 3 Sep 2019 13:50:22 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:59540 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729894AbfICRuW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Sep 2019 13:50:22 -0400
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x83HoLm7006439;
        Tue, 3 Sep 2019 13:50:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dellteam.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=1JsHaC87Apn69hv/wfXNJhKpmZXRt002+8K8DnN2AuM=;
 b=jCHDtuzp1lRQHJ7yp6AfIlbPRNy6m5xMI6aOjsbsxm7N4bBJqt/JS1A1pLTKMQPpPaCV
 a5w27FN2SC8nXxo3IQbpJOhKNUa572xaUzFjp9MmDKAx2GjMwNNxzxNE1O0JQAQOrZAL
 QBdA93tI9sIgdr1mmMOdkPFO8lQtwETas9GHsYowWGjp5ksclTC0bmswe0Zuxif+XfuT
 tJwepmC+YzQCQNo8gWjCgxv7eVaQ/mJxovNW9yiy9iagL2ZNzj62TxUjolDl5XwpMErU
 QY6Yv1dE67yy57Vnq1fyvgxL6uIQhWABJ42fZ53/0sunHh7XgpHKYANrlgV0tF+/6b6x rA== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 2uqm7jbquc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Sep 2019 13:50:21 -0400
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x83Hm5KN017605;
        Tue, 3 Sep 2019 13:50:21 -0400
Received: from ausxippc106.us.dell.com (AUSXIPPC106.us.dell.com [143.166.85.156])
        by mx0b-00154901.pphosted.com with ESMTP id 2ur6fpyy9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Sep 2019 13:50:21 -0400
X-LoopCount0: from 10.166.132.129
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="455804321"
From:   <Charles.Hyde@dellteam.com>
To:     <oneukum@suse.com>, <lenb@kernel.org>, <rjw@rjwysocki.net>
CC:     <Mario.Limonciello@dell.com>, <nic_swsd@realtek.com>,
        <linux-acpi@vger.kernel.org>, <linux-usb@vger.kernel.org>
Subject: RE: [PATCH 3/3] net: cdc_ncm: Add ACPI MAC address pass through
 functionality
Thread-Topic: [PATCH 3/3] net: cdc_ncm: Add ACPI MAC address pass through
 functionality
Thread-Index: AQHVX2qOXZfzpNrp7kuN2ddtBmn+ZqcYfF2AgAGzMPA=
Date:   Tue, 3 Sep 2019 17:50:14 +0000
Message-ID: <f5d9dec6134a4b3da82cb74d24c6dd34@AUSX13MPS307.AMER.DELL.COM>
References: <b24465a706744d99a7c1682f05a24784@AUSX13MPS307.AMER.DELL.COM>
 <1567417759.2469.5.camel@suse.com>
In-Reply-To: <1567417759.2469.5.camel@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Charles_Hyde@Dellteam.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-09-03T17:50:13.1207292Z;
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
 definitions=2019-09-03_03:2019-09-03,2019-09-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1906280000 definitions=main-1909030178
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 spamscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1909030179
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

PiA+IFRoaXMgY2hhbmdlIGFkZHMgc3VwcG9ydCB0byBjZGNfbmNtIGZvciBBQ1BJIE1BQyBhZGRy
ZXNzIHBhc3MgdGhyb3VnaA0KPiA+IGZ1bmN0aW9uYWxpdHkgdGhhdCBhbHNvIGV4aXN0cyBpbiB0
aGUgUmVhbHRlayByODE1MiBkcml2ZXIuICBUaGlzIGlzDQo+ID4gaW4gc3VwcG9ydCBvZiBEZWxs
J3MgVW5pdmVyc2FsIERvY2sgRDYwMDAsIHRvIGdpdmUgaXQgdGhlIHNhbWUgZmVhdHVyZQ0KPiA+
IGNhcGFiaWxpdHkgYXMgaXMgY3VycmVudGx5IGF2YWlsYWJsZSBpbiBXaW5kb3dzIGFuZCBhZHZl
cnRpemVkIG9uDQo+ID4gRGVsbCdzIHByb2R1Y3Qgd2ViIHNpdGUuDQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBDaGFybGVzIEh5ZGUgPGNoYXJsZXMuaHlkZUBkZWxsdGVhbS5jb20+DQo+ID4gQ2M6
IE1hcmlvIExpbW9uY2llbGxvIDxtYXJpby5saW1vbmNpZWxsb0BkZWxsLmNvbT4NCj4gPiBDYzog
T2xpdmVyIE5ldWt1bSA8b2xpdmVyQG5ldWt1bS5vcmc+DQo+ID4gQ2M6IFJhZmFlbCBKLiBXeXNv
Y2tpIDxyandAcmp3eXNvY2tpLm5ldD4NCj4gPiBDYzogTGVuIEJyb3duIDxsZW5iQGtlcm5lbC5v
cmc+DQo+ID4gQ2M6IGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmcNCj4gPiBDYzogbGludXgtYWNw
aUB2Z2VyLmtlcm5lbC5vcmcNCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9uZXQvdXNiL2NkY19uY20u
YyB8IDY3DQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tDQo+ID4g
IDEgZmlsZSBjaGFuZ2VkLCA2NCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3VzYi9jZGNfbmNtLmMgYi9kcml2ZXJzL25ldC91
c2IvY2RjX25jbS5jDQo+ID4gaW5kZXggODUwOTM1Nzk2MTJmLi4xMWEwNGRjMjI5OGQgMTAwNjQ0
DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvdXNiL2NkY19uY20uYw0KPiA+ICsrKyBiL2RyaXZlcnMv
bmV0L3VzYi9jZGNfbmNtLmMNCj4gPiBAQCAtNTIsNiArNTIsNyBAQA0KPiA+ICAjaW5jbHVkZSA8
bGludXgvdXNiL3VzYm5ldC5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvdXNiL2NkYy5oPg0KPiA+
ICAjaW5jbHVkZSA8bGludXgvdXNiL2NkY19uY20uaD4NCj4gPiArI2luY2x1ZGUgPGFjcGkvYWNw
aV9tYWNfcGFzc3RocnUuaD4NCj4gPg0KPiA+ICAjaWYgSVNfRU5BQkxFRChDT05GSUdfVVNCX05F
VF9DRENfTUJJTSkNCj4gPiAgc3RhdGljIGJvb2wgcHJlZmVyX21iaW0gPSB0cnVlOw0KPiA+IEBA
IC05ODQsMTEgKzk4NSwzMCBAQCBpbnQgY2RjX25jbV9iaW5kX2NvbW1vbihzdHJ1Y3QgdXNibmV0
ICpkZXYsDQo+IHN0cnVjdCB1c2JfaW50ZXJmYWNlICppbnRmLCB1OCBkYXRhXw0KPiA+ICAJdXNi
X3NldF9pbnRmZGF0YShjdHgtPmNvbnRyb2wsIGRldik7DQo+ID4NCj4gPiAgCWlmIChjdHgtPmV0
aGVyX2Rlc2MpIHsNCj4gPiAtCQl0ZW1wID0gdXNibmV0X2dldF9ldGhlcm5ldF9hZGRyKGRldiwg
Y3R4LT5ldGhlcl9kZXNjLQ0KPiA+aU1BQ0FkZHJlc3MpOw0KPiA+ICsJCXN0cnVjdCBzb2NrYWRk
ciBzYTsNCj4gPiArDQo+ID4gKwkJdGVtcCA9IGNkY19uY21fZ2V0X2V0aGVybmV0X2FkZHJlc3Mo
ZGV2LCBjdHgpOw0KPiA+ICAJCWlmICh0ZW1wKSB7DQo+ID4gIAkJCWRldl9kYmcoJmludGYtPmRl
diwgImZhaWxlZCB0byBnZXQgbWFjIGFkZHJlc3NcbiIpOw0KPiA+ICAJCQlnb3RvIGVycm9yMjsN
Cj4gPiAgCQl9DQo+ID4gKw0KPiA+ICsJCS8qIENoZWNrIGZvciBhIERlbGwgVW5pdmVyc2FsIERv
Y2sgRDYwMDAgYmVmb3JlIGNoZWNraW5nIGlmDQo+ID4gKwkJICogQUNQSSBzdXBwb3J0cyBNQUMg
YWRkcmVzcyBwYXNzIHRocm91Z2guDQo+ID4gKwkJICovDQo+ID4gKwkJaWYgKCFzdHJzdHIoZGV2
LT51ZGV2LT5wcm9kdWN0LCAiRDYwMDAiKSkNCj4gPiArCQkJZ290byBza2lwX2FjcGlfbWFwdF9p
bl9iaW5kOw0KPiA+ICsNCj4gPiArCQlpZiAoZ2V0X2FjcGlfbWFjX3Bhc3N0aHJ1KHNhLnNhX2Rh
dGEpICE9IDApDQo+ID4gKwkJCWdvdG8gc2tpcF9hY3BpX21hcHRfaW5fYmluZDsNCj4gPiArDQo+
ID4gKwkJaWYgKG1lbWNtcChkZXYtPm5ldC0+ZGV2X2FkZHIsIHNhLnNhX2RhdGEsIEVUSF9BTEVO
KSA9PSAwKQ0KPiA+ICsJCQlnb3RvIHNraXBfYWNwaV9tYXB0X2luX2JpbmQ7DQo+ID4gKw0KPiA+
ICsJCWlmIChjZGNfbmNtX3NldF9ldGhlcm5ldF9hZGRyZXNzKGRldiwgJnNhKSA9PSAwKQ0KPiA+
ICsJCQltZW1jcHkoZGV2LT5uZXQtPmRldl9hZGRyLCBzYS5zYV9kYXRhLCBFVEhfQUxFTik7DQo+
ID4gKw0KPiA+ICtza2lwX2FjcGlfbWFwdF9pbl9iaW5kOg0KPiA+ICAJCWRldl9pbmZvKCZpbnRm
LT5kZXYsICJNQUMtQWRkcmVzczogJXBNXG4iLCBkZXYtPm5ldC0NCj4gPmRldl9hZGRyKTsNCj4g
PiAgCX0NCj4gPg0KPiA+IEBAIC0xNzE2LDYgKzE3MzYsNDcgQEAgc3RhdGljIHZvaWQgY2RjX25j
bV9zdGF0dXMoc3RydWN0IHVzYm5ldCAqZGV2LA0KPiBzdHJ1Y3QgdXJiICp1cmIpDQo+ID4gIAl9
DQo+ID4gIH0NCj4gPg0KPiA+ICtzdGF0aWMgaW50IGNkY19uY21fcmVzdW1lKHN0cnVjdCB1c2Jf
aW50ZXJmYWNlICppbnRmKSB7DQo+ID4gKwlzdHJ1Y3QgdXNibmV0ICpkZXYgPSB1c2JfZ2V0X2lu
dGZkYXRhKGludGYpOw0KPiA+ICsJc3RydWN0IGNkY19uY21fY3R4ICpjdHggPSAoc3RydWN0IGNk
Y19uY21fY3R4ICopZGV2LT5kYXRhWzBdOw0KPiA+ICsJaW50IHJldDsNCj4gPiArDQo+ID4gKwly
ZXQgPSB1c2JuZXRfcmVzdW1lKGludGYpOw0KPiA+ICsJaWYgKHJldCAhPSAwKQ0KPiA+ICsJCWdv
dG8gZXJyb3IyOw0KPiA+ICsNCj4gPiArCWlmIChjdHgtPmV0aGVyX2Rlc2MpIHsNCj4gPiArCQlz
dHJ1Y3Qgc29ja2FkZHIgc2E7DQo+ID4gKw0KPiA+ICsJCWlmIChjZGNfbmNtX2dldF9ldGhlcm5l
dF9hZGRyZXNzKGRldiwgY3R4KSkgew0KPiA+ICsJCQlkZXZfZGJnKCZpbnRmLT5kZXYsICJmYWls
ZWQgdG8gZ2V0IG1hYyBhZGRyZXNzXG4iKTsNCj4gPiArCQkJZ290byBlcnJvcjI7DQo+ID4gKwkJ
fQ0KPiA+ICsNCj4gPiArCQkvKiBDaGVjayBmb3IgYSBEZWxsIFVuaXZlcnNhbCBEb2NrIEQ2MDAw
IGJlZm9yZSBjaGVja2luZyBpZg0KPiA+ICsJCSAqIEFDUEkgc3VwcG9ydHMgTUFDIGFkZHJlc3Mg
cGFzcyB0aHJvdWdoLg0KPiA+ICsJCSAqLw0KPiA+ICsJCWlmICghc3Ryc3RyKGRldi0+dWRldi0+
cHJvZHVjdCwgIkQ2MDAwIikpDQo+ID4gKwkJCWdvdG8gc2tpcF9hY3BpX21hcHRfaW5fcmVzdW1l
Ow0KPiANCj4gVGhpcyBpcyB0b28gdWdseS4gVXNlIGEgZmxhZyBmb3IgdGhlIG5lZWQgdG8gcmVz
dG9yZSB0aGUgTUFDLg0KDQpJdCBpcyB1Z2x5IHRvIG1lLCBhbHNvLCBiZWNhdXNlIG9mIHJlc3Ry
aWN0aW9ucyB0aGF0IExpbnV4IHNvdXJjZSBjYW5ub3QgYmUgbG9uZ2VyIHRoYW4gODAgY29sdW1u
cy4gIEkgbXVjaCBwcmVmZXIgcmVhZGFiaWxpdHkgYW5kIG1haW50YWluYWJpbGl0eSBvdmVyIDgw
IGNvbHVtbiBsaW5lIGxlbmd0aCBsaW1pdHMuICAgQmVzaWRlcywgSSBoYXZlIG5vdCB1c2VkIGFu
IDgwIGNvbHVtbiBrZXlwdW5jaCBtYWNoaW5lIGluIG1vcmUgdGhhbiAzNSB5ZWFycy4NCg0KPiBB
bmQgaGF2ZSB5b3UgY29uc2lkZXIgdGhlIGNhc2Ugc29tZWJvZHkgdHJpZ2dlcnMgYSByZXNldCB0
aHJvdWdoIHVzYmZzPyBJdA0KPiBsb29rcyB0byBtZSBsaWtlIHlvdSBzaG91bGQgZW5jYXBzdWxh
dGUgdGhlIHJlc3RvcmF0aW9uIG9mIHRoZSBNQUMgYW5kIGFsc28NCj4gdXNlIGl0IGluIHBvc3Rf
cmVzZXQoKQ0KPiANCj4gCVJlZ2FyZHMNCj4gCQlPbGl2ZXINCg0KV2lsbCB0aGVyZSBuZWVkIHRv
IGJlIGEgcHJlX3Jlc2V0KCkgZnVuY3Rpb24gdG8gZ28gd2l0aCB0aGUgcG9zdF9yZXNldCgpIHlv
dSBhcmUgc3VnZ2VzdGluZz8NCg0KQ2hhcmxlcw0K
