Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5FFE283C1E
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Oct 2020 18:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgJEQL3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Oct 2020 12:11:29 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:45340 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726657AbgJEQL3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Oct 2020 12:11:29 -0400
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 095G9P61002805;
        Mon, 5 Oct 2020 12:11:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=g9LVSuVP84x+hiiS8FkKmDKcAQOl2odneLFvkT5Uxz8=;
 b=MNwYnu3btygRKD7uFCsZFzmTgcmO9/J41Mt/vlGds+p1MMF+Aihp/OsvScK1k1bB65Y4
 BW7PVqJ0dnc4H4KjONwWrCnU1JnLvL2Xhs8603KKz3Zboij2makfQHQI4xjTRVd5PwE6
 3ppd76UW7k0lDzZ39zaMMN7maDR+64CKJKZp6mo71UcSJPvviCRJSYbSLqyVTzNZq4EX
 B0zR8scKmcxtHCo3xNDa/gNI2e5Bti4zVpROPjWK+VALRQeAPSQLDmx7dccIAx3/TagV
 VJtHl2LQbF4gqa8pXPd914PxIDWyRiSqgjv3lfYP8t3RKbdYsCAEgc1d/FcI2LbD24Ki 6g== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 33xn4x5fn8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Oct 2020 12:11:11 -0400
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 095G2o02025974;
        Mon, 5 Oct 2020 12:11:10 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by mx0a-00154901.pphosted.com with ESMTP id 3406npr479-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Oct 2020 12:11:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6jslcAf6AH3iP5uu0YFR6teuKpKL1rLFsCYPEWIVerwtVokvsXoDJpr8HXthM4Vi0+dCVE5XcBmufBziHYpsVgjrXECZQr1MSnFFVp1zSCsBqd1XQT0DrtIOKHHYwYURsR6zi6rnN1NzGVaJvzSnCCDmFfjsY1/I1JUUX0OZjaxrKakIUXs0QwUADCc9wjNQaJqCwEb2hlYbxv6gMbBWTIFn09xaodOD/O1RwRZIoRciHAh1o/cay0x5yJIuxpqzi6N2gAVFUM41zqEW/LpJf8xYUrmk+aNyJcuUzBOrMMayKvatLAwenP2DQ4BGac958iY/6Kt5xy2nIjiGVubDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9LVSuVP84x+hiiS8FkKmDKcAQOl2odneLFvkT5Uxz8=;
 b=DwOhtgIcWRqJd+cjccFpR2lbnYDf1/C/+Z1+z1Z8ELkCWJf4+CIdCdU57hWjwIfgTruryQ/p1BHU8Y1sSeC1uqKpWPlRpNPouENzk/vJYKsYYFnLFMSoWfQqv95fyUedeptqzwZEBmkYQZq0CcQ0ExJ6hyiMONrKeIrUOq9shrm+18girLEWmmm7miae0j4G7DZrw5UgTPgVVcdZrZcB7fiT6jNju0PFynIaKbBDhr/QE3MGWGgrM031jygEk25c50CnjdQkanXgGw84KmJGC17fgDOvRL6+V8D7DT2h/uy5Kp0e4M2H3VsSFpJ/etv/uwyItlgt0bfyINXGJWUE6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9LVSuVP84x+hiiS8FkKmDKcAQOl2odneLFvkT5Uxz8=;
 b=nFFk5jj2RJP7PJP4zz86DzNcNMfMZGsYPaJWQznUv+exJ7e/11nefB16bceco19jZj+UG3/Y1CKHhydxgHqaEIco6iwvTbRYj9W8/SNaXIRDD+lBEwC++x9WaAer1tXS2qlGd0x/ng6KiCWcAmJNjfTI4S/Y0hn74ThCnxQ7hIo=
Received: from DM6PR19MB2636.namprd19.prod.outlook.com (2603:10b6:5:15f::15)
 by DM5PR19MB1481.namprd19.prod.outlook.com (2603:10b6:3:ba::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Mon, 5 Oct
 2020 16:11:08 +0000
Received: from DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2]) by DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2%4]) with mapi id 15.20.3433.044; Mon, 5 Oct 2020
 16:11:08 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@dell.com>
To:     =?utf-8?B?QmFybmFiw6FzIFDFkWN6ZQ==?= <pobrn@protonmail.com>
CC:     Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mgross@linux.intel.com>,
        Mark Pearson <mpearson@lenovo.com>,
        Elia Devito <eliadevito@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Benjamin Berg <bberg@redhat.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Pearson <markpearson@lenovo.com>
Subject: RE: [RFC] Documentation: Add documentation for new
 performance_profile sysfs class
Thread-Topic: [RFC] Documentation: Add documentation for new
 performance_profile sysfs class
Thread-Index: AQHWmYfgDjG0YI7kc0C9HQeldGcjC6mI+DtAgAAZsQCAAB1x8A==
Date:   Mon, 5 Oct 2020 16:11:08 +0000
Message-ID: <DM6PR19MB26369E7468931E63B69A0604FA0C0@DM6PR19MB2636.namprd19.prod.outlook.com>
References: <20201003131938.9426-1-hdegoede@redhat.com>
 <20201003131938.9426-2-hdegoede@redhat.com>
 <DM6PR19MB263669227D122BB7699951E6FA0C0@DM6PR19MB2636.namprd19.prod.outlook.com>
 <Mz2G7glm3yMTniKA6SHM011dDkTFF4_otICrMQfVLheopX8JMGSupPleyjyK8OY0tyUazu09nX7XhleBVdl4ozTCWXCPGyvV58Qc-UUTvig=@protonmail.com>
In-Reply-To: <Mz2G7glm3yMTniKA6SHM011dDkTFF4_otICrMQfVLheopX8JMGSupPleyjyK8OY0tyUazu09nX7XhleBVdl4ozTCWXCPGyvV58Qc-UUTvig=@protonmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-10-05T16:11:05.1289172Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=52c0acc1-4dc0-460b-82bd-730a6c16ce22;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: protonmail.com; dkim=none (message not signed)
 header.d=none;protonmail.com; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [76.251.167.31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2926fd1-68fe-4340-07bf-08d8694944f9
x-ms-traffictypediagnostic: DM5PR19MB1481:
x-microsoft-antispam-prvs: <DM5PR19MB1481512262EE02730390D317FA0C0@DM5PR19MB1481.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XKOG+GVpFjeV1hUt2IO77vVXgYvnoVOUUkrDQHOLclOxLSnFAU1Lk7IbN1VXidtd1aLFsMaPvPIHJlpRPY9DPtc1mslrkopTgtRKK1Wtmh94/eBdGthZTxZb3w8o1G56QretgCjAcjuOs2Bhdu/qglrPq5Qa4VfTzG22xwNjRFusFmrBpLQdJEwnBrWEz3cekPgkGq02Pai0RU+gXTXoFKqPfG101ikGQ9rXQOgEWsV4EyOWChqh3PlfTwV47oNUi947CM7QxW0i9svfMoxL9tKAKGspxKmNLCZMrCMs/JQ63zxEbi9XpGsA7NfLsNF4MdFjWphY8YBAk1V0swoQMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB2636.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(346002)(136003)(366004)(396003)(66574015)(83380400001)(7696005)(6506007)(26005)(8676002)(33656002)(9686003)(8936002)(478600001)(55016002)(6916009)(186003)(54906003)(786003)(86362001)(66476007)(66946007)(64756008)(66446008)(66556008)(7416002)(4326008)(52536014)(316002)(76116006)(5660300002)(2906002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: gyk0VD+Hk+aEXP2oKcEYo3wFbDzjhfr1jVwaUB+aNtG5qp09DlBabaxDGOGqoXRVw4UeD0s2sBv3WdEFnaStKqU9XrzOvRLp++qBMJMES44LFsVWckajKYfNUMSsUpaPOEqBB/5r4YPysp1vw6XudPUv3NSvep8wHoD6pa/GZJhGgSXEb4ESjZ2voc142vN4y7kMX537b9LALJqP1aRUjwTwHaEaWlLVu6rfGILO+yqKD0ZHOKjsLdCUUs3KmZ5N2l/GVbiG5oSQJG0QbS/qAnvj4OGCviScqJnqRTtUhiY/vS6a0XQBRtmJF5IIUWTAnF1awM8sJ9C982dBxk8LsxZ/fNkKadPfD+rPYx9CSevWwRmgNP4uq91vtfEw6SJ5DrYBi9xhQ6q7dtuRefEgjdCof38tq7im1FAkPBlhu3bhpTa+SDZyjKzyjGpTqwYDHjZZw00dhHfdx/OheMX6QMmiJEq3mdW+NlB3IE2aE0HySaFkTvC4hUsb+mTIrHXdJ9UdvWJ3WmimoPgnAwzQmySs6Rj7W2x1+rqySdk1eBV1AzgA37cRPSXfWIZNNPCiBkVJz19B3zfvS8zmlpW8V/TJY95OAK+6oMvuk3wABdIXNcMwUgR7X6Ehchx+lXsg0RsllJ8Sem4b49kCJHX/fQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB2636.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2926fd1-68fe-4340-07bf-08d8694944f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2020 16:11:08.2376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lyss7HO4lovkI7suHYoTQ5cQyrcMr+B8+829egavqChOS/rL8XhV8BSTb9K0UIEqTnZeJUyEa/CGUYltd1PwL16is5OtKXD+x0cFf50C4pI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR19MB1481
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-05_11:2020-10-05,2020-10-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 mlxscore=0 adultscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010050117
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010050118
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

PiAyMDIwLiBva3TDs2JlciA1LiwgaMOpdGbFkSAxNDo1OCBrZWx0ZXrDqXNzZWwsIExpbW9uY2ll
bGxvLCBNYXJpbyDDrXJ0YToNCj4gPiA+IE9uIG1vZGVybiBzeXN0ZW1zIENQVS9HUFUvLi4uIHBl
cmZvcm1hbmNlIGlzIG9mdGVuIGR5bmFtaWNhbGx5DQo+IGNvbmZpZ3VyYWJsZQ0KPiA+ID4gaW4g
dGhlIGZvcm0gb2YgZS5nLiB2YXJpYWJsZSBjbG9jay1zcGVlZHMgYW5kIFRQRC4gVGhlIHBlcmZv
cm1hbmNlIGlzDQo+IG9mdGVuDQo+ID4gPiBhdXRvbWF0aWNhbGx5IGFkanVzdGVkIHRvIHRoZSBs
b2FkIGJ5IHNvbWUgYXV0b21hdGljLW1lY2hhbmlzbSAod2hpY2ggbWF5DQo+ID4gPiB2ZXJ5IHdl
bGwgbGl2ZSBvdXRzaWRlIHRoZSBrZXJuZWwpLg0KPiA+ID4gVGhlc2UgYXV0byBwZXJmb3JtYW5j
ZS1hZGp1c3RtZW50IG1lY2hhbmlzbXMgb2Z0ZW4gY2FuIGJlIGNvbmZpZ3VyZWQgd2l0aA0KPiA+
ID4gb25lIG9mIHNldmVyYWwgcGVyZm9ybWFuY2UtcHJvZmlsZXMsIHdpdGggZWl0aGVyIGEgYmlh
cyB0b3dhcmRzIGxvdy1wb3dlcg0KPiA+ID4gY29uc3VtcHRpb24gKGFuZCBjb29sIGFuZCBxdWll
dCkgb3IgdG93YXJkcyBwZXJmb3JtYW5jZSAoYW5kIGhpZ2hlciBwb3dlcg0KPiA+ID4gY29uc3Vt
cHRpb24gYW5kIHRoZXJtYWxzKS4NCj4gPiA+IEludHJvZHVjZSBhIG5ldyBwZXJmb3JtYW5jZV9w
cm9maWxlIGNsYXNzL3N5c2ZzIEFQSSB3aGljaCBvZmZlcnMgYSBnZW5lcmljDQo+ID4gPiBBUEkg
Zm9yIHNlbGVjdGluZyB0aGUgcGVyZm9ybWFuY2UtcHJvZmlsZSBvZiB0aGVzZSBhdXRvbWF0aWMt
bWVjaGFuaXNtcy4NCj4gPg0KPiA+IElmIGludHJvZHVjaW5nIGFuIEFQSSBmb3IgdGhpcyAtIGxl
dCBtZSBhc2sgdGhlIHF1ZXN0aW9uLCB3aHkgZXZlbiBsZXQgZWFjaA0KPiA+IGRyaXZlciBvZmZl
ciBhIGNsYXNzIGludGVyZmFjZSBhbmQgdXNlcnNwYWNlIG5lZWQgdG8gY2hhbmdlICJlYWNoIiBk
cml2ZXIncw0KPiA+IHBlcmZvcm1hbmNlIHNldHRpbmc/DQo+ID4NCj4gPiBJIHdvdWxkIHRoaW5r
IHRoYXQgeW91IGNvdWxkIGp1c3Qgb2ZmZXIgc29tZXRoaW5nIGtlcm5lbC13aWRlIGxpa2UNCj4g
PiAvc3lzL3Bvd2VyL3BlcmZvcm1hbmNlLXByb2ZpbGUNCj4gPg0KPiA+IFVzZXJzcGFjZSBjYW4g
cmVhZCBhbmQgd3JpdGUgdG8gYSBzaW5nbGUgZmlsZS4gQWxsIGRyaXZlcnMgY2FuIGdldCBub3Rp
ZmllZA0KPiA+IG9uIHRoaXMgc3lzZnMgZmlsZSBjaGFuZ2luZy4NCj4gPg0KPiANCj4gVGhhdCBt
YWtlcyBzZW5zZSwgaW4gbXkgb3BpbmlvbiwgZnJvbSB0aGUgcmVndWxhciB1c2VyJ3MgcGVyc3Bl
Y3RpdmU6DQo+IG9uZSBzd2l0Y2ggdG8gcnVsZSB0aGVtIGFsbCwgbm8gZnVzcy4gSG93ZXZlciwg
SSBkb24ndCB0aGluayB0aGF0IHNjYWxlcyB3ZWxsLg0KPiBXaGF0IGlmIHRoZSBoeXBvdGhldGlj
YWwgdXNlcnMgd2FudHMgdG8gcnVuIGEgQ1BVLWhlYXZ5IHdvcmtsb2FkLCBhbmQgdGh1cw0KPiB3
YW50cw0KPiB0byBwdXQgdGhlIEdQVSBpbnRvICJsb3ctcG93ZXIiIG1vZGUgYW5kIHRoZSBDUFUg
aW50byAicGVyZm9ybWFuY2UiIG1vZGU/IFdoYXQNCj4gaWYNCj4gdGhlIHVzZXJzIHdhbnRzIHRv
IHB1dCBvbmUgR1BVIGludG8gImxvdy1wb3dlciIgbW9kZSwgYnV0IHRoZSBvdGhlciBvbmUgaW50
bw0KPiAicGVyZm9ybWFuY2UiPyBXaXRoIHRoZSBjdXJyZW50IHNwZWNpZmljYXRpb24sIHRoZSB1
c2VyJ3MgbmVlZHMgY291bGQgYmUNCj4gZWFzaWx5DQo+IHNhdGlzZmllZC4gSSBkb24ndCBzZWUg
aG93IHRoYXQncyBwb3NzaWJsZSB3aXRoIGEgc2luZ2xlIHN3aXRjaC4gTm9uZXRoZWxlc3MsDQo+
IEkgdGhpbmsNCj4gdGhhdCBhIHNpbmdsZSBnbG9iYWwgc3dpdGNoICppbiBhZGRpdGlvbiogdG8g
dGhlIGNsYXNzIGRldmljZXMgY291bGQgcG9zc2libHkNCj4gc2ltcGxpZnkgdGhlIHVzZXJzcGFj
ZS1rZXJuZWwgaW50ZXJhY3Rpb24gZm9yIG1vc3QgdXNlcnMuDQoNCkkgdGhpbmsgdGhhdCB0aGUg
bW9tZW50IHlvdSByZXByZXNlbnQgYSBwbGF0Zm9ybS9zeXN0ZW0gZGV2aWNlIGFzIGEgc3dpdGNo
IHlvdQ0KbG9zZSB0aGUgYWJpbGl0eSB0byBzZXQgZGlmZmVyZW50IHBvbGljaWVzIGZvciBvdGhl
ciB0eXBlcyBvZiBkZXZpY2VzIHNlcGFyYXRlbHkuDQoNCldoYXQgaWYgdXNpbmcgdGhlIHBsYXRm
b3JtL3N5c3RlbSBkZXZpY2UgYWN0dWFsbHkgL2Fsc28vIG9yY2hlc3RyYXRlcyBjaGFuZ2VzIHRv
DQp0aG9zZSBvdGhlciBkZXZpY2VzIHlvdSBtZW50aW9uPyAgVGhlbiBpdCBiZWNvbWVzIGFuIG9y
ZGVyIG9mIGV2ZW50cyBwcm9ibGVtLCBvcg0Kd29yc2UgYSBwcm9ibGVtIHdoZXJlIG9uZSBzd2l0
Y2ggc2hvd3MgIndyb25nIiB2YWx1ZS4NCg0KPiANCj4gDQo+ID4gVGhlIHN5c3RlbXMgdGhhdCBy
ZWFjdCBpbiBmaXJtd2FyZSAoc3VjaCBhcyB0aGUgdHdvIHRoYXQgcHJvbXB0ZWQNCj4gPiB0aGlz
IGRpc2N1c3Npb24pIGNhbiBjaGFuZ2UgYXQgdGhhdCB0aW1lLiBJdCBsZWF2ZXMgdGhlIHBvc3Np
YmlsaXR5IGZvciBhDQo+ID4gbW9yZSBvcGVuIGtlcm5lbCBpbXBsZW1lbnRhdGlvbiB0aGF0IGNh
biBkbyB0aGUgc2FtZSB0aGluZyB0aG91Z2ggdG9vIGJ5DQo+ID4gZGlyZWN0bHkgbW9kaWZ5aW5n
IGRldmljZSByZWdpc3RlcnMgaW5zdGVhZCBvZiBBQ1BJIGRldmljZXMuDQo+ID4NCj4gDQo+IEV4
Y3VzZSBteSBpZ25vcmFuY2UsIGJ1dCBJIGRvbid0IHJlYWxseSBzZWUgd2h5IHRoaXMgaW50ZXJm
YWNlIHdvdWxkIGJlIHRpZWQNCj4gdG8NCj4gQUNQSSBkZXZpY2VzPyBXaHkgaXMgaXQgbm90IHBv
c3NpYmxlIHRvIHdyaXRlIGEgZHJpdmVyIHRoYXQgaW1wbGVtZW50cyB0aGlzDQo+IGludGVyZmFj
ZQ0KPiBhbmQgZGlyZWN0bHkgbW9kaWZpZXMgZGV2aWNlIHJlZ2lzdGVycz8gQW0gSSBtaXNzaW5n
IHNvbWV0aGluZyBvYnZpb3VzIGhlcmU/DQo+IA0KDQpXaGVuIGltcGxlbWVudGVkIGZvciB0aGUg
dHdvIHZlbmRvcnMgbWVudGlvbmVkIGhlcmUsIGl0IHdvdWxkIGJlIHVzaW5nIGENCnByb3ByaWV0
YXJ5ICJmaXJtd2FyZSBBUEkiIGltcGxlbWVudGVkIGJ5IHRob3NlIHR3byB2ZW5kb3JzLiAgRm9y
IGV4YW1wbGUgd3JpdGUNCmFyZ3VtZW50cyAoMHgxLCAweDIpIHRvIEFDUEktV01JIG1ldGhvZCBX
TUZUIGFuZCBpdCB3aWxsIGNhdXNlIGZpcm13YXJlIHRvIGNvb3JkaW5hdGUNCnVzaW5nIHVuZGlz
Y2xvc2VkIHByb3RvY29sIHRvIGFmZmVjdCB0aGUgcGxhdGZvcm0gY2hhbmdlcyBkZXNpcmFibGUu
DQoNClRoaXMgaXMgZGlmZmVyZW50IGluIG15IG1pbmQgZnJvbSAia2VybmVsIHdyaXRlcyB0byBh
IHNwZWNpZmljIHJlZ2lzdGVyIiB0byBzZXQNCnBvd2VyIHByb3BlcnRpZXMgb2YgYSBzcGVjaWZp
YyBkZXZpY2UuDQoNCg0KDQo=
