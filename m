Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEA74AC155
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Sep 2019 22:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394441AbfIFUUS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 Sep 2019 16:20:18 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:24584 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389797AbfIFUUR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Sep 2019 16:20:17 -0400
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x86KAUN4015863;
        Fri, 6 Sep 2019 16:20:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dellteam.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=kbdA8y5kRu5q9VTzcEXpslhmqOkeLL9Xftp+edS4Mmc=;
 b=PBU7SGyyE84TxRaC4mxWYeEqqHhkwT2tFngp6yuCJAKv7MGEby461PePQ9cMp0PVvDXV
 f5IQO9aLcrnx7g0YQXO/yE2wTnZKrd9/JEoYawLKcQyBs/3C+rDshniSW9G9xFzZD6n2
 usWoc4KcufjV7A+Qyuin5BijQHbQo5dANwS+QNVupPd1YUm6HddRl+eOQ82BkprYBQBr
 /lGlVpfGirrhKLKWN0jC63jwu0cjkyfciHTN4xv1/RmyenV0nzuEnc1NsRbOzw0if2g9
 FgLL7UDhBoG+At/fFo61JrDh7HiOVVysfa23QROH0NQuOvpYiIxQ+jtMMP0FPJGOfe5T nw== 
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 2uqm2duys4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Sep 2019 16:20:16 -0400
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x86KDa1a098138;
        Fri, 6 Sep 2019 16:20:15 -0400
Received: from ausxipps301.us.dell.com (ausxipps301.us.dell.com [143.166.148.223])
        by mx0b-00154901.pphosted.com with ESMTP id 2uupmvr34q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Sep 2019 16:20:15 -0400
X-LoopCount0: from 10.166.132.130
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="393575164"
From:   <Charles.Hyde@dellteam.com>
To:     <bjorn@mork.no>
CC:     <stern@rowland.harvard.edu>, <oliver@neukum.org>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <Mario.Limonciello@dell.com>, <chip.programmer@gmail.com>,
        <nic_swsd@realtek.com>, <linux-usb@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH 1/3] net: cdc_ncm: add get/set ethernet address functions
Thread-Topic: [PATCH 1/3] net: cdc_ncm: add get/set ethernet address functions
Thread-Index: AQHVZO6rVbpOtOy+DEKwLQ92ABp4yKcfFehQ
Date:   Fri, 6 Sep 2019 20:20:13 +0000
Message-ID: <d8cdacc63ddd4da4a88d3712b2b53d32@AUSX13MPS307.AMER.DELL.COM>
References: <43fa8b0a974d426faccf5e6d486af18a@AUSX13MPS307.AMER.DELL.COM>
        <Pine.LNX.4.44L0.1909061412350.1627-100000@iolanthe.rowland.org>
        <a9999ed336ba4f2a8cb93c57f0b3d2f4@AUSX13MPS307.AMER.DELL.COM>
 <87mufhqjdb.fsf@miraculix.mork.no>
In-Reply-To: <87mufhqjdb.fsf@miraculix.mork.no>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Charles_Hyde@Dellteam.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-09-06T20:20:12.0635394Z;
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
 definitions=2019-09-06_08:2019-09-04,2019-09-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 mlxscore=0 impostorscore=0 spamscore=0 bulkscore=0 mlxlogscore=847
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909060209
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxlogscore=943
 malwarescore=0 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 mlxscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1909060209
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

PiA+IFdoYXQgYmV0dGVyIHN1Z2dlc3Rpb24gZG8gZm9sa3MgaGF2ZSwgaW5zdGVhZCBvZiB1c2lu
Zw0KPiBVU0JfUkVRX1NFVF9BRERSRVNTPw0KPiANCj4gVGhlIHNwZWMgaXMgY2xlYXI6IHdJbmRl
eCBpcyBzdXBwb3NlZCB0byBiZSAnTkNNIENvbW11bmljYXRpb25zIEludGVyZmFjZScuDQo+IFRo
YXQncyBob3cgeW91IGFkZHJlc3MgYSBzcGVjaWZpYyBOQ00gZnVuY3Rpb24gKGEgVVNCIGRldmlj
ZSBjYW4gaGF2ZSBtb3JlDQo+IHRoYW4gb25lLi4uKSwgYW5kIHRoYXQncyB3aGF0IHlvdSdsbCBz
ZWUgaW4gYWxsIHRoZSBvdGhlciBpbnRlcmZhY2Ugc3BlY2lmaWMgY2xhc3MNCj4gcmVxdWVzdHMg
aW4gdGhpcyBkcml2ZXIuICBZb3UgZG9uJ3QgaGF2ZSB0byBsb29rIGhhcmQgdG8gZmluZCBleGFt
cGxlcy4NCj4gDQo+IA0KPiBCasO4cm4NCg0KDQpJIGhhdmUgcHJlc2VudGVkIHdoYXQgd29ya3Ms
IHdpdGggdGhlIHYzIHBhdGNoIHNlcmllcy4gIFNpbmNlIHlvdSBvYnZpb3VzbHkgZG8gbm90IGxp
a2Ugd2hhdCBkb2VzIHdvcmssIEkgd2lsbCBhc2sgeW91IHRvIHByb3ZpZGUgY2xlYXIgYW5kIGNv
bmNpc2UgY29kZSBmb3Igd2hhdCB5b3UgYmVsaWV2ZSBvdWdodCB0byB3b3JrLiAgTWluZCB5b3Us
IHRoZSBjb2RlIEkgaGF2ZSBwcm92aWRlZCBzZW5kcyB0aGUgZXhhY3Qgc2FtZSBVU0IgbWVzc2Fn
ZSBhcyBJIHRyYWNlZCB3aXRoIFdpcmVzaGFyayBvbiBteSBXaW5kb3dzIHN5c3RlbS4gIElmIHlv
dSBjYW4gcHJvdmlkZSBnb29kIHdvcmtpbmcgY29kZSB0aGF0IHJlcGxpY2F0ZXMgd2hhdCBJIGhh
dmUgcHJvdmlkZWQsIEkgd291bGQgYmUgdGhyaWxsZWQuDQoNClRoYW5rIHlvdSwNCkNoYXJsZXMN
Cg==
