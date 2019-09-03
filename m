Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6899A70DB
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Sep 2019 18:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730198AbfICQpY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 3 Sep 2019 12:45:24 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:53908 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729113AbfICQpY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Sep 2019 12:45:24 -0400
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x83GeKYh017317;
        Tue, 3 Sep 2019 12:45:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dellteam.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=8HMoi6E0m5qVaLNk2voP0fKnBeJwcia4kiHkjoecUxU=;
 b=w3p803rGDa2F/Cnpgd6XPzLXizYZgH8DvH7qY9eB1hxCp/OHKqu6S1GSHbg8V5k2wNz1
 vyKheEl0n9QOv6/keohMdHA+IyEqJfA6UvzLLPWeDdV4UICNzQ8YFUwE1gB87/ZDnaYH
 Pa6Hdrcf3dKGQN/DNkdELykExzMz0r543bZo57USvtAhMXmKJ2jOAJGaFnau32Bk0Qru
 0Of6cBTNXR9CaAmm7HvJxlPDZd/wMLZ6ctaE4jhRb2AaxcvYYdxOcOANhHgvNoQ1qjX5
 8KuTzMVbDaApEprG0gQrzmHN7QHQ2UPnTuRr1fY4xSGDX6UBD+by4VjrpXHpjMdaYAka jw== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 2ur034sx46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Sep 2019 12:45:23 -0400
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x83Ggi35039682;
        Tue, 3 Sep 2019 12:45:22 -0400
Received: from ausxipps301.us.dell.com (ausxipps301.us.dell.com [143.166.148.223])
        by mx0b-00154901.pphosted.com with ESMTP id 2ur6fpxyfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Sep 2019 12:45:22 -0400
X-LoopCount0: from 10.166.132.128
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="391726541"
From:   <Charles.Hyde@dellteam.com>
To:     <oneukum@suse.com>, <lenb@kernel.org>, <rjw@rjwysocki.net>
CC:     <Mario.Limonciello@dell.com>, <nic_swsd@realtek.com>,
        <linux-acpi@vger.kernel.org>, <linux-usb@vger.kernel.org>
Subject: RE: [PATCH 1/3] net: cdc_ncm: add get/set ethernet address functions
Thread-Topic: [PATCH 1/3] net: cdc_ncm: add get/set ethernet address functions
Thread-Index: AQHVX2pN6giiJ6/FU06nVjUMk0ut46cYesoAgAGyiKA=
Date:   Tue, 3 Sep 2019 16:45:20 +0000
Message-ID: <2dd5f5fa0e124f8f87ac2c75af1ef81c@AUSX13MPS307.AMER.DELL.COM>
References: <5cee0eb405f2492b8086d8684f1c75ca@AUSX13MPS307.AMER.DELL.COM>
 <1567417420.2469.3.camel@suse.com>
In-Reply-To: <1567417420.2469.3.camel@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Charles_Hyde@Dellteam.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-09-03T16:45:19.2113611Z;
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
 scancount=1 engine=8.12.0-1906280000 definitions=main-1909030170
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1909030170
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

PiA+IFRoaXMgcGF0Y2ggYWRkcyBzdXBwb3J0IGZvciBwdXNoaW5nIGEgTUFDIGFkZHJlc3Mgb3V0
IHRvIFVTQiBiYXNlZA0KPiA+IGV0aGVybmV0IGNvbnRyb2xsZXJzIGRyaXZlbiBieSBjZGNfbmNt
LiAgV2l0aCB0aGlzIGNoYW5nZSwgaWZjb25maWcNCj4gPiBjYW4gbm93IHNldCB0aGUgZGV2aWNl
J3MgTUFDIGFkZHJlc3MuICBGb3IgZXhhbXBsZSwgdGhlIERlbGwgVW5pdmVyc2FsDQo+ID4gRG9j
aw0KPiA+IEQ2MDAwIGlzIGRyaXZlbiBieSBjZGNfbmNtLiAgVGhlIEQ2MDAwIGNhbiBub3cgaGF2
ZSBpdHMgTUFDIGFkZHJlc3MNCj4gPiBzZXQgYnkgaWZjb25maWcsIGFzIGl0IGNhbiBiZSBkb25l
IGluIFdpbmRvd3MuICBUaGlzIHdhcyB0ZXN0ZWQgd2l0aCBhDQo+ID4gRDYwMDAgdXNpbmcgaWZj
b25maWcgb24gYW4geDg2IGJhc2VkIGNocm9tZWJvb2ssIHdoZXJlIGlwcm91dGUyIGlzIG5vdA0K
PiA+IGF2YWlsYWJsZS4NCj4gDQo+ID4gKy8qIFByb3ZpZGUgbWV0aG9kIHRvIHB1c2ggTUFDIGFk
ZHJlc3MgdG8gdGhlIFVTQiBkZXZpY2UncyBldGhlcm5ldA0KPiBjb250cm9sbGVyLg0KPiA+ICsg
Ki8NCj4gPiAraW50IGNkY19uY21fc2V0X21hY19hZGRyKHN0cnVjdCBuZXRfZGV2aWNlICpuZXQs
IHZvaWQgKnApIHsNCj4gPiArCXN0cnVjdCB1c2JuZXQgKmRldiA9IG5ldGRldl9wcml2KG5ldCk7
DQo+ID4gKw0KPiA+ICsJLyogVHJ5IHRvIHB1c2ggdGhlIE1BQyBhZGRyZXNzIG91dCB0byB0aGUg
ZGV2aWNlLiAgSWdub3JlIGFueSBlcnJvcnMsDQo+ID4gKwkgKiB0byBiZSBjb21wYXRpYmxlIHdp
dGggcHJpb3IgdmVyc2lvbnMgb2YgdGhpcyBzb3VyY2UuDQo+ID4gKwkgKi8NCj4gPiArCWNkY19u
Y21fc2V0X2V0aGVybmV0X2FkZHJlc3MoZGV2LCAoc3RydWN0IHNvY2thZGRyICopcCk7DQo+IA0K
PiBZb3UgYXJlIHRocm93aW5nIGF3YXkgZXJyb3IgcmVwb3J0cy4NCj4gDQo+IAlSZWdhcmRzDQo+
IAkJT2xpdmVyDQoNCg0KTXkgaW50ZW50IGlzIGxpbWl0IHRoZSBjaGFuZ2VzIG5lZWRlZCB0byBz
dXBwb3J0IHNldHRpbmcgdGhlIE1BQyBhZGRyZXNzLiwgdGh1cyBhbnkgcG90ZW50aWFsIHNvdXJj
ZSBjb2RlIGVycm9ycy4gIEkgaGF2ZSBub3QgY2hhbmdlZCB0aGUgY3VycmVudCBiZWhhdmlvciBv
ZiB0aGUgZHJpdmVyIHdpdGggcmVzcGVjdCB0byBlcnJvciBwcm9jZXNzaW5nLiAgVGhlIGV4aXN0
aW5nIHNvdXJjZSBkb2VzIG5vdCBjaGVjayBmb3IgZXJyb3IgcmV0dXJuIHZhbHVlcywgdGhlcmVm
b3JlIG15IGNoYW5nZXMgYWxzbyBkbyBub3QgY2hlY2sgZXJyb3IgcmV0dXJuIHZhbHVlcy4NCg0K
Q2hhcmxlcw0K
