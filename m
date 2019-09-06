Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAA1FABF14
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Sep 2019 20:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389788AbfIFSAs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 Sep 2019 14:00:48 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:3474 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388322AbfIFSAs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Sep 2019 14:00:48 -0400
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x86HtS29025575;
        Fri, 6 Sep 2019 14:00:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dellteam.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=aXzYX18tT60aUWaQMnCsrQMCGlhXnd4brg96dCMlSck=;
 b=WGy8FGBWMzlQCO+DpebesJpextW+M7kxq+crV63HSGYBNJfu/oEoPiHXWp4RydluHygN
 zc46zAXkObJZIh4I2MvrufotJm6WVVpXalxBZPwEJsCUoXEJd7oSd8yZ93kd9y5m/U6l
 oZ2TznDAyiCeFwb9n4gQa2kZXQAon90sVSwdJnkJI4MmDe80PUKHf4XjYoHFHbnMiGcf
 6sR0lIAVake/moRXiINYIlSB5LOhXalGoQr4AxzRftAvzT1Ntjk1KBMaVYzFGQflSMmv
 7BwXXUFNcqC6gVzazPO2i8TyxZplmDW3xtEhJVkni7H+aspTjwNIiiILJD9jomsV+jNt XQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 2uqm4b3afj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Sep 2019 14:00:46 -0400
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x86HvcLV016637;
        Fri, 6 Sep 2019 14:00:43 -0400
Received: from ausxipps301.us.dell.com (ausxipps301.us.dell.com [143.166.148.223])
        by mx0a-00154901.pphosted.com with ESMTP id 2ur5ym3f92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Sep 2019 14:00:43 -0400
X-LoopCount0: from 10.166.132.133
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="393519333"
From:   <Charles.Hyde@dellteam.com>
To:     <bjorn@mork.no>
CC:     <oliver@neukum.org>, <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <Mario.Limonciello@dell.com>, <chip.programmer@gmail.com>,
        <nic_swsd@realtek.com>, <linux-usb@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH 1/3] net: cdc_ncm: add get/set ethernet address functions
Thread-Topic: [PATCH 1/3] net: cdc_ncm: add get/set ethernet address functions
Thread-Index: AQHVZCzhVbpOtOy+DEKwLQ92ABp4yKceW3ikgACI4XA=
Date:   Fri, 6 Sep 2019 18:00:41 +0000
Message-ID: <43fa8b0a974d426faccf5e6d486af18a@AUSX13MPS307.AMER.DELL.COM>
References: <1567717318990.49322@Dellteam.com>
 <87zhjhssoz.fsf@miraculix.mork.no>
In-Reply-To: <87zhjhssoz.fsf@miraculix.mork.no>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Charles_Hyde@Dellteam.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-09-06T17:37:22.3647491Z;
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
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-06_07:2019-09-04,2019-09-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 mlxlogscore=999 spamscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909060192
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=999 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1909060192
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

PHNuaXBwZWQ+IA0KPiA+ICsJcmV0ID0gdXNibmV0X3JlYWRfY21kKGRldiwgVVNCX0NEQ19HRVRf
TkVUX0FERFJFU1MsDQo+ID4gKwkJCSAgICAgIFVTQl9ESVJfSU4gfCBVU0JfVFlQRV9DTEFTUw0K
PiA+ICsJCQkgICAgICB8IFVTQl9SRUNJUF9JTlRFUkZBQ0UsIDAsDQo+ID4gKwkJCSAgICAgIFVT
Ql9SRVFfU0VUX0FERFJFU1MsIGJ1ZiwgRVRIX0FMRU4pOw0KPiANCj4gV2hlcmUgZGlkIHRoYXQg
VVNCX1JFUV9TRVRfQUREUkVTUyBjb21lIGZyb20/IERpZCB5b3UganVzdCBsb29rIHVwIGFuDQo+
IGFyYnV0cmFyeSBtYWNybyB0aGF0IGhhcHBlbmVkIHRvIG1hdGNoIHlvdXIgZGV2aWNlIGNvbmZp
Zz8gIEhvdyBkbyB5b3UNCj4gZXhwZWN0IHRoaXMgdG8gd29yayB3aXRoIGEgZ2VuZXJpYyBOQ00g
ZGV2aWNlPyAgT3IgZXZlbiB5b3VyIG93biBkZXZpY2UsDQo+IHdoZW4gdGhlIG5leHQgZmlybXdh
cmUgcmV2aXNpb24gbW92ZXMgdGhlIGZ1bmN0aW9uIHRvIGEgZGlmZmVyZW50IGludGVyZmFjZT8N
CjxzbmlwcGVkPg0KDQpodHRwczovL3dpa2kub3NkZXYub3JnL1VuaXZlcnNhbF9TZXJpYWxfQnVz
I1NFVF9BRERSRVNTDQoNCmh0dHBzOi8vd3d3LnVzYi5vcmcvZG9jdW1lbnQtbGlicmFyeS9uZXR3
b3JrLWNvbnRyb2wtbW9kZWwtZGV2aWNlcy1zcGVjaWZpY2F0aW9uLXYxMC1hbmQtZXJyYXRhLWFu
ZC1hZG9wdGVycy1hZ3JlZW1lbnQNCkRvd25sb2FkIGFuZCB2aWV3IHRoZSBOQ00gc3BlY2lmaWNh
dGlvbiB2MS4wIChFcnJhdGEgMSksIGRhdGVkIE5vdmVtYmVyIDI0LCAyMDEwLiAgU2VlIHRhYmxl
IDYuMiBvbiBwYWdlIDMwLiAgQWxzbyBzZWUgc2VjdGlvbnMgNi4yLjIgYW5kIDYuMi4zIG9uIHBh
Z2UgMzIuDQoNClVTQl9SRVFfU0VUX0FERFJFU1MgY2FtZSBmcm9tIGluY2x1ZGUvdWFwaS9saW51
eC91c2IvY2g5LmguICBUaGlzIG1hdGNoZXMgdGhlIFNFVF9BRERSRVNTIGRlZmluaXRpb24gZnJv
bSB0aGUgb3NkZXYgd2lraSBwYWdlLCBzbyBJIHVzZWQgaXQgYmVjYXVzZSB0aGUgbmFtZSBhbmQg
bnVtZXJpYyB2YWx1ZXMgYm90aCBtYXRjaGVkLiAgSXQgZnVydGhlciBtYXRjaGVzIHdoYXQgdGhl
IFdpbmRvd3MgZHJpdmVyIGlzc3Vlcy4NCg0KLS0gDQpDaGFybGVzDQo=
