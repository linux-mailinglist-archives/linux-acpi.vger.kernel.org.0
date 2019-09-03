Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 748B2A7209
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Sep 2019 19:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbfICR5K (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 3 Sep 2019 13:57:10 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:5088 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727624AbfICR5K (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Sep 2019 13:57:10 -0400
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x83Ht0fu005241;
        Tue, 3 Sep 2019 13:57:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=RolfEqM9Io5PbMF8ISc9TKKQO4csVS8RfAj9cy8ylgI=;
 b=Lb1zTlaCjhOcjOPidFKM07MBWaXXYJKJY/DWIL39B++Eutp9kIO0ZFg6tKD4DE3BBb/T
 D2fbHHSYXFQekSjJ6khDjesPhPFncdwpGRdJ7YbOTGmTu3h/O0Yf9DBeKm5U4n2SClI+
 kd7aTjSN8fOOCwzYB0ECevo4v/NWAMNcHfn0EvaOexdQh5+XgRFHqwJjILdF3rUjaT4Z
 3SjsarxNcVF2O6gSJG4kvTPCw5Zj7E/PXFcQLbGcbZ2XrlVN9G+asbyE9EtYflNHRfbM
 eCjKwyqqt0UfZMD8WKKrx++GydfzamW92LBDKyvJX/9Ynakg4O+xQxaRji+swuo2wcXs xw== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 2uqm2dbph6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Sep 2019 13:57:08 -0400
Received: from pps.filterd (m0144102.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x83E4naX023643;
        Tue, 3 Sep 2019 13:57:07 -0400
Received: from ausxipps310.us.dell.com (AUSXIPPS310.us.dell.com [143.166.148.211])
        by mx0b-00154901.pphosted.com with ESMTP id 2ur7jh63kp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Sep 2019 13:57:07 -0400
X-LoopCount0: from 10.166.135.93
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="417617361"
From:   <Mario.Limonciello@dell.com>
To:     <Charles.Hyde@dellteam.com>, <oneukum@suse.com>, <lenb@kernel.org>,
        <rjw@rjwysocki.net>
CC:     <nic_swsd@realtek.com>, <linux-acpi@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Subject: RE: [PATCH 3/3] net: cdc_ncm: Add ACPI MAC address pass through
 functionality
Thread-Topic: [PATCH 3/3] net: cdc_ncm: Add ACPI MAC address pass through
 functionality
Thread-Index: AQHVX2qOXZfzpNrp7kuN2ddtBmn+ZqcYfF2AgAGzMPCAABMT0A==
Date:   Tue, 3 Sep 2019 17:57:05 +0000
Message-ID: <0f1603ffbc26471a95efe5261c964f4c@AUSX13MPC101.AMER.DELL.COM>
References: <b24465a706744d99a7c1682f05a24784@AUSX13MPS307.AMER.DELL.COM>
 <1567417759.2469.5.camel@suse.com>
 <f5d9dec6134a4b3da82cb74d24c6dd34@AUSX13MPS307.AMER.DELL.COM>
In-Reply-To: <f5d9dec6134a4b3da82cb74d24c6dd34@AUSX13MPS307.AMER.DELL.COM>
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
 definitions=2019-09-01_01:2019-08-29,2019-09-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 impostorscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909010057
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 mlxscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1909030180
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIeWRlLCBDaGFybGVzIC0gRGVs
bCBUZWFtDQo+IFNlbnQ6IFR1ZXNkYXksIFNlcHRlbWJlciAzLCAyMDE5IDEyOjUwIFBNDQo+IFRv
OiBPbGl2ZXIgTmV1a3VtOyBsZW5iQGtlcm5lbC5vcmc7IHJqd0Byand5c29ja2kubmV0DQo+IENj
OiBMaW1vbmNpZWxsbywgTWFyaW87IG5pY19zd3NkQHJlYWx0ZWsuY29tOyBsaW51eC1hY3BpQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtDQo+IHVzYkB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDog
UkU6IFtQQVRDSCAzLzNdIG5ldDogY2RjX25jbTogQWRkIEFDUEkgTUFDIGFkZHJlc3MgcGFzcyB0
aHJvdWdoDQo+IGZ1bmN0aW9uYWxpdHkNCj4gDQo+ID4gPiBUaGlzIGNoYW5nZSBhZGRzIHN1cHBv
cnQgdG8gY2RjX25jbSBmb3IgQUNQSSBNQUMgYWRkcmVzcyBwYXNzIHRocm91Z2gNCj4gPiA+IGZ1
bmN0aW9uYWxpdHkgdGhhdCBhbHNvIGV4aXN0cyBpbiB0aGUgUmVhbHRlayByODE1MiBkcml2ZXIu
ICBUaGlzIGlzDQo+ID4gPiBpbiBzdXBwb3J0IG9mIERlbGwncyBVbml2ZXJzYWwgRG9jayBENjAw
MCwgdG8gZ2l2ZSBpdCB0aGUgc2FtZSBmZWF0dXJlDQo+ID4gPiBjYXBhYmlsaXR5IGFzIGlzIGN1
cnJlbnRseSBhdmFpbGFibGUgaW4gV2luZG93cyBhbmQgYWR2ZXJ0aXplZCBvbg0KPiA+ID4gRGVs
bCdzIHByb2R1Y3Qgd2ViIHNpdGUuDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogQ2hhcmxl
cyBIeWRlIDxjaGFybGVzLmh5ZGVAZGVsbHRlYW0uY29tPg0KPiA+ID4gQ2M6IE1hcmlvIExpbW9u
Y2llbGxvIDxtYXJpby5saW1vbmNpZWxsb0BkZWxsLmNvbT4NCj4gPiA+IENjOiBPbGl2ZXIgTmV1
a3VtIDxvbGl2ZXJAbmV1a3VtLm9yZz4NCj4gPiA+IENjOiBSYWZhZWwgSi4gV3lzb2NraSA8cmp3
QHJqd3lzb2NraS5uZXQ+DQo+ID4gPiBDYzogTGVuIEJyb3duIDxsZW5iQGtlcm5lbC5vcmc+DQo+
ID4gPiBDYzogbGludXgtdXNiQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gQ2M6IGxpbnV4LWFjcGlA
dmdlci5rZXJuZWwub3JnDQo+ID4gPiAtLS0NCj4gPiA+ICBkcml2ZXJzL25ldC91c2IvY2RjX25j
bS5jIHwgNjcNCj4gPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQ0K
PiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA2NCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0K
PiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC91c2IvY2RjX25jbS5jIGIvZHJp
dmVycy9uZXQvdXNiL2NkY19uY20uYw0KPiA+ID4gaW5kZXggODUwOTM1Nzk2MTJmLi4xMWEwNGRj
MjI5OGQgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL25ldC91c2IvY2RjX25jbS5jDQo+ID4g
PiArKysgYi9kcml2ZXJzL25ldC91c2IvY2RjX25jbS5jDQo+ID4gPiBAQCAtNTIsNiArNTIsNyBA
QA0KPiA+ID4gICNpbmNsdWRlIDxsaW51eC91c2IvdXNibmV0Lmg+DQo+ID4gPiAgI2luY2x1ZGUg
PGxpbnV4L3VzYi9jZGMuaD4NCj4gPiA+ICAjaW5jbHVkZSA8bGludXgvdXNiL2NkY19uY20uaD4N
Cj4gPiA+ICsjaW5jbHVkZSA8YWNwaS9hY3BpX21hY19wYXNzdGhydS5oPg0KPiA+ID4NCj4gPiA+
ICAjaWYgSVNfRU5BQkxFRChDT05GSUdfVVNCX05FVF9DRENfTUJJTSkNCj4gPiA+ICBzdGF0aWMg
Ym9vbCBwcmVmZXJfbWJpbSA9IHRydWU7DQo+ID4gPiBAQCAtOTg0LDExICs5ODUsMzAgQEAgaW50
IGNkY19uY21fYmluZF9jb21tb24oc3RydWN0IHVzYm5ldCAqZGV2LA0KPiA+IHN0cnVjdCB1c2Jf
aW50ZXJmYWNlICppbnRmLCB1OCBkYXRhXw0KPiA+ID4gIAl1c2Jfc2V0X2ludGZkYXRhKGN0eC0+
Y29udHJvbCwgZGV2KTsNCj4gPiA+DQo+ID4gPiAgCWlmIChjdHgtPmV0aGVyX2Rlc2MpIHsNCj4g
PiA+IC0JCXRlbXAgPSB1c2JuZXRfZ2V0X2V0aGVybmV0X2FkZHIoZGV2LCBjdHgtPmV0aGVyX2Rl
c2MtDQo+ID4gPmlNQUNBZGRyZXNzKTsNCj4gPiA+ICsJCXN0cnVjdCBzb2NrYWRkciBzYTsNCj4g
PiA+ICsNCj4gPiA+ICsJCXRlbXAgPSBjZGNfbmNtX2dldF9ldGhlcm5ldF9hZGRyZXNzKGRldiwg
Y3R4KTsNCj4gPiA+ICAJCWlmICh0ZW1wKSB7DQo+ID4gPiAgCQkJZGV2X2RiZygmaW50Zi0+ZGV2
LCAiZmFpbGVkIHRvIGdldCBtYWMgYWRkcmVzc1xuIik7DQo+ID4gPiAgCQkJZ290byBlcnJvcjI7
DQo+ID4gPiAgCQl9DQo+ID4gPiArDQo+ID4gPiArCQkvKiBDaGVjayBmb3IgYSBEZWxsIFVuaXZl
cnNhbCBEb2NrIEQ2MDAwIGJlZm9yZSBjaGVja2luZyBpZg0KPiA+ID4gKwkJICogQUNQSSBzdXBw
b3J0cyBNQUMgYWRkcmVzcyBwYXNzIHRocm91Z2guDQo+ID4gPiArCQkgKi8NCj4gPiA+ICsJCWlm
ICghc3Ryc3RyKGRldi0+dWRldi0+cHJvZHVjdCwgIkQ2MDAwIikpDQo+ID4gPiArCQkJZ290byBz
a2lwX2FjcGlfbWFwdF9pbl9iaW5kOw0KPiA+ID4gKw0KPiA+ID4gKwkJaWYgKGdldF9hY3BpX21h
Y19wYXNzdGhydShzYS5zYV9kYXRhKSAhPSAwKQ0KPiA+ID4gKwkJCWdvdG8gc2tpcF9hY3BpX21h
cHRfaW5fYmluZDsNCj4gPiA+ICsNCj4gPiA+ICsJCWlmIChtZW1jbXAoZGV2LT5uZXQtPmRldl9h
ZGRyLCBzYS5zYV9kYXRhLCBFVEhfQUxFTikgPT0gMCkNCj4gPiA+ICsJCQlnb3RvIHNraXBfYWNw
aV9tYXB0X2luX2JpbmQ7DQo+ID4gPiArDQo+ID4gPiArCQlpZiAoY2RjX25jbV9zZXRfZXRoZXJu
ZXRfYWRkcmVzcyhkZXYsICZzYSkgPT0gMCkNCj4gPiA+ICsJCQltZW1jcHkoZGV2LT5uZXQtPmRl
dl9hZGRyLCBzYS5zYV9kYXRhLCBFVEhfQUxFTik7DQo+ID4gPiArDQo+ID4gPiArc2tpcF9hY3Bp
X21hcHRfaW5fYmluZDoNCj4gPiA+ICAJCWRldl9pbmZvKCZpbnRmLT5kZXYsICJNQUMtQWRkcmVz
czogJXBNXG4iLCBkZXYtPm5ldC0NCj4gPiA+ZGV2X2FkZHIpOw0KPiA+ID4gIAl9DQo+ID4gPg0K
PiA+ID4gQEAgLTE3MTYsNiArMTczNiw0NyBAQCBzdGF0aWMgdm9pZCBjZGNfbmNtX3N0YXR1cyhz
dHJ1Y3QgdXNibmV0ICpkZXYsDQo+ID4gc3RydWN0IHVyYiAqdXJiKQ0KPiA+ID4gIAl9DQo+ID4g
PiAgfQ0KPiA+ID4NCj4gPiA+ICtzdGF0aWMgaW50IGNkY19uY21fcmVzdW1lKHN0cnVjdCB1c2Jf
aW50ZXJmYWNlICppbnRmKSB7DQo+ID4gPiArCXN0cnVjdCB1c2JuZXQgKmRldiA9IHVzYl9nZXRf
aW50ZmRhdGEoaW50Zik7DQo+ID4gPiArCXN0cnVjdCBjZGNfbmNtX2N0eCAqY3R4ID0gKHN0cnVj
dCBjZGNfbmNtX2N0eCAqKWRldi0+ZGF0YVswXTsNCj4gPiA+ICsJaW50IHJldDsNCj4gPiA+ICsN
Cj4gPiA+ICsJcmV0ID0gdXNibmV0X3Jlc3VtZShpbnRmKTsNCj4gPiA+ICsJaWYgKHJldCAhPSAw
KQ0KPiA+ID4gKwkJZ290byBlcnJvcjI7DQo+ID4gPiArDQo+ID4gPiArCWlmIChjdHgtPmV0aGVy
X2Rlc2MpIHsNCj4gPiA+ICsJCXN0cnVjdCBzb2NrYWRkciBzYTsNCj4gPiA+ICsNCj4gPiA+ICsJ
CWlmIChjZGNfbmNtX2dldF9ldGhlcm5ldF9hZGRyZXNzKGRldiwgY3R4KSkgew0KPiA+ID4gKwkJ
CWRldl9kYmcoJmludGYtPmRldiwgImZhaWxlZCB0byBnZXQgbWFjIGFkZHJlc3NcbiIpOw0KPiA+
ID4gKwkJCWdvdG8gZXJyb3IyOw0KPiA+ID4gKwkJfQ0KPiA+ID4gKw0KPiA+ID4gKwkJLyogQ2hl
Y2sgZm9yIGEgRGVsbCBVbml2ZXJzYWwgRG9jayBENjAwMCBiZWZvcmUgY2hlY2tpbmcgaWYNCj4g
PiA+ICsJCSAqIEFDUEkgc3VwcG9ydHMgTUFDIGFkZHJlc3MgcGFzcyB0aHJvdWdoLg0KPiA+ID4g
KwkJICovDQo+ID4gPiArCQlpZiAoIXN0cnN0cihkZXYtPnVkZXYtPnByb2R1Y3QsICJENjAwMCIp
KQ0KPiA+ID4gKwkJCWdvdG8gc2tpcF9hY3BpX21hcHRfaW5fcmVzdW1lOw0KPiA+DQo+ID4gVGhp
cyBpcyB0b28gdWdseS4gVXNlIGEgZmxhZyBmb3IgdGhlIG5lZWQgdG8gcmVzdG9yZSB0aGUgTUFD
Lg0KPiANCj4gSXQgaXMgdWdseSB0byBtZSwgYWxzbywgYmVjYXVzZSBvZiByZXN0cmljdGlvbnMg
dGhhdCBMaW51eCBzb3VyY2UgY2Fubm90IGJlIGxvbmdlcg0KPiB0aGFuIDgwIGNvbHVtbnMuICBJ
IG11Y2ggcHJlZmVyIHJlYWRhYmlsaXR5IGFuZCBtYWludGFpbmFiaWxpdHkgb3ZlciA4MCBjb2x1
bW4NCj4gbGluZSBsZW5ndGggbGltaXRzLiAgIEJlc2lkZXMsIEkgaGF2ZSBub3QgdXNlZCBhbiA4
MCBjb2x1bW4ga2V5cHVuY2ggbWFjaGluZSBpbg0KPiBtb3JlIHRoYW4gMzUgeWVhcnMuDQoNClRo
aXMgaXMga2VybmVsIHN0eWxlIHRob3VnaC4NCmh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL2h0
bWwvdjUuMi9wcm9jZXNzL2NvZGluZy1zdHlsZS5odG1sDQoNCj4gDQo+ID4gQW5kIGhhdmUgeW91
IGNvbnNpZGVyIHRoZSBjYXNlIHNvbWVib2R5IHRyaWdnZXJzIGEgcmVzZXQgdGhyb3VnaCB1c2Jm
cz8gSXQNCj4gPiBsb29rcyB0byBtZSBsaWtlIHlvdSBzaG91bGQgZW5jYXBzdWxhdGUgdGhlIHJl
c3RvcmF0aW9uIG9mIHRoZSBNQUMgYW5kIGFsc28NCj4gPiB1c2UgaXQgaW4gcG9zdF9yZXNldCgp
DQo+ID4NCj4gPiAJUmVnYXJkcw0KPiA+IAkJT2xpdmVyDQo+IA0KPiBXaWxsIHRoZXJlIG5lZWQg
dG8gYmUgYSBwcmVfcmVzZXQoKSBmdW5jdGlvbiB0byBnbyB3aXRoIHRoZSBwb3N0X3Jlc2V0KCkg
eW91IGFyZQ0KPiBzdWdnZXN0aW5nPw0KDQpJdCBzaG91bGQgbWF0Y2ggaW1wbGVtZW50aW5nIHdo
YXQgMjU3NjYyNzFlNDJmNmIxNWI3MmJhMTU2Y2I0MmEzZmVhOTFiNWIyMQ0KZGlkIGZvciByODE1
Mi4NCg0K
