Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC112305C92
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Jan 2021 14:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238157AbhA0NKI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Jan 2021 08:10:08 -0500
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:44950 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S313739AbhAZWox (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 26 Jan 2021 17:44:53 -0500
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10QMWhu3028325;
        Tue, 26 Jan 2021 17:43:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=TA6/AHdpz4nP7SAceW/f1xSKGEZsOKFvF2LCK8xi8ug=;
 b=ytRMcXzUKXcssucbMPVTbDPn3N1WsK8PmnKKrZOmU7Odh1Sqi2TFwiwiz6YAiKF/DR+u
 zDZ3xHYNw0A222MPnIjODu1SMIemLyiuSrgrs2/aJ+TX6PCT8Ssgn3dYTJtSDdhAPYVg
 z1l3vMg1SvFhZlyh/NN4cmujzS0ZN70iQGUusCdq5YFdbWdauWHmnhfrWBwL4yGmBHnc
 5hj9l7w29rZ4uxv0TmiqrYQbeil4N324Ab3s4mjoWy7f86s3kpeQ7BuEHIgJs6A3CRof
 Ra7yCWyF1shk7yk0F+M71Ln0nr9goPsoR1NmIcmmgYEglMneox6Kdltf4jIUo2QyALj4 AA== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 368fugtebb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Jan 2021 17:43:36 -0500
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10QMYiW5142324;
        Tue, 26 Jan 2021 17:43:35 -0500
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2055.outbound.protection.outlook.com [104.47.44.55])
        by mx0b-00154901.pphosted.com with ESMTP id 369266hdq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jan 2021 17:43:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jpITrIXQ09lbAHNcWOfSQj2ANVX5Ca4BoOghljNxroKID4Sy0rWXiJn/PdklMslK5Ul4oMFc10NpRHQkja0/0Em4QcA6ZefW0yKHl4tDqC7CANeXYtrauyeE4iVfLJ/+zM2MXZUuQwh1duWN2ZyTkslW9YLQDuXgmfi8Pg6kd8ecNcxehmyaRu5sH8GVMqST5zpnAC0QtcbRF/uHZ64MbMAouDBauX638nVcKm6A2s1O0zxmnHH44QsKBVhWwZifAXyamjfN8BgoWOlMhsvi7CCfmiwToGBj4nVl/W44aaMXjG3+VCLFKAxzJ5P/XzPVbnyLY3/f8LgnlShd8YhCzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TA6/AHdpz4nP7SAceW/f1xSKGEZsOKFvF2LCK8xi8ug=;
 b=eq87qJWptbdwBbEjDsKoPEoVzbqGoRjPH3Eka3sAJiBNNfSncsi1hrAyTjVxNQMX0MbtkBxpZJ61trkSenXehLnMtVoCDmUnScOsJpUnG2TKaBpyd7ewwPPSc+wUC0F/vxPnpcd+1m0oW9n8arg1LBttuLiFIRDDQF9EhAeGpnZu7TP3An+uDWmkd+fBz8pDpF9/CFH8q8asn6HlPV1REy9G6s6PzkY6Flg/GWOnEAh8kTxtIzFPKM/z3Tv5ECJuFQksNKn67aWlHU792b18cLfCuLPJp2v7SIqWOcHzOTP8S3RR2q3ohkkf7lGpgEKEOz+XFIeQgoQp6lrJIwBCpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SA1PR19MB4926.namprd19.prod.outlook.com (2603:10b6:806:1a6::18)
 by SN7PR19MB4816.namprd19.prod.outlook.com (2603:10b6:806:107::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Tue, 26 Jan
 2021 22:43:32 +0000
Received: from SA1PR19MB4926.namprd19.prod.outlook.com
 ([fe80::1c92:24d3:b11f:bc50]) by SA1PR19MB4926.namprd19.prod.outlook.com
 ([fe80::1c92:24d3:b11f:bc50%6]) with mapi id 15.20.3784.019; Tue, 26 Jan 2021
 22:43:32 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@dell.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Christian Kellner <christian@kellner.me>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH 4/6] ACPI: Execute platform _OSC also with query bit clear
Thread-Topic: [PATCH 4/6] ACPI: Execute platform _OSC also with query bit
 clear
Thread-Index: AQHW8/v1cKWMHTpccUeXj8TT66BRyqo6J0wAgAACgWCAAAOLAIAAUsnA
Date:   Tue, 26 Jan 2021 22:43:32 +0000
Message-ID: <SA1PR19MB4926A9A1E4D0AD96FAE236B3FABC9@SA1PR19MB4926.namprd19.prod.outlook.com>
References: <20210126155723.9388-1-mika.westerberg@linux.intel.com>
 <20210126155723.9388-5-mika.westerberg@linux.intel.com>
 <CAJZ5v0i+wCOFZOhyx6i=TUGMeWyQR4vXzDN06G6xheFwC66Tuw@mail.gmail.com>
 <SA1PR19MB4926907D028D3F924FF42A36FABC9@SA1PR19MB4926.namprd19.prod.outlook.com>
 <CAJZ5v0hQ_JZVfOpSZY0hxc01He9x7uzgU2rsKffmQubaeKy=EA@mail.gmail.com>
In-Reply-To: <CAJZ5v0hQ_JZVfOpSZY0hxc01He9x7uzgU2rsKffmQubaeKy=EA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: mika.westerberg@linux.intel.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-01-26T22:43:27.9183791Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=562c5aa7-dd21-449e-8c54-5d074dd71bff;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [76.251.167.31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c17e745e-1003-4d4a-5ba2-08d8c24bcf2e
x-ms-traffictypediagnostic: SN7PR19MB4816:
x-microsoft-antispam-prvs: <SN7PR19MB4816EAF11770C1DEFB13EBABFABC9@SN7PR19MB4816.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TelKSWXmfiTT1ZigOpQ2JSIYVtdJlv2qhjz2wmucp5Mvm5Hxa5BH8+arIHot4yergqRLk6e9TiFF27zc92eSOMIpxwxcAZCz4Sb6y6dkRUlm1YPRllaLTVIyFYmg2qunix+S67B5l5E67ISn8VzmrB2vpt6HYgKA/2KJ8x2Q0Qdcrz3nNNT9u5WC1Y4T2ZtNOUOiavKkiNCkjwYCCgj8fRTkL9Jr28EJjghLLWj9PdhEuP54shcnqjcBEzNspuU0pATi5FwKLPBaG/QH74zT/9ZlbpWMnxZTLrKE9HD85yeQYGpJFSUWZMQKKvl9Sl7GYm/0jvj8AmIc1aCbHHK111rU5FPgdaxb8Ady3Qo03xkZ0Q+P9HijcfFRSc+U6N1sE3gQIhx0Ud15gXkvWHTL0w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR19MB4926.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(66556008)(26005)(64756008)(2906002)(66946007)(786003)(83380400001)(186003)(6506007)(52536014)(478600001)(55016002)(66476007)(4326008)(76116006)(7696005)(33656002)(9686003)(86362001)(54906003)(316002)(110136005)(5660300002)(71200400001)(7416002)(8676002)(66446008)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?SWR1elB4b292bnN0OFk4VTN4RjVkejdWcktFMXFTQXd1aXVHcWRWR0ZKUHJM?=
 =?utf-8?B?aXQrVG9BTHlzeG9kVklMUEJ3SUkxNllqTWJ2L2V6VXZ4c2d3MUtaYzFjOUgx?=
 =?utf-8?B?T28xSVUvZktlR0w1c0JDYkEzNnkyRmxNY0JCSjQzZkJrTlhqTytLRWw5TG9z?=
 =?utf-8?B?WHFIblRTb2duRERiYWI3dzhsNitEMVRWTnoybTE1eFJ2bExpeXU2dUY0L2R6?=
 =?utf-8?B?aG5vamRmMEJLeW00aXdBVldBMGprbTZTRzRwWEJGeFJmQVQrNHoxc0FnUHlP?=
 =?utf-8?B?bHJrVW12VSs2dDNYZTEwcG9GVUpHVkFVVGVNYU95a1ZzQlNoQ0Zuak56WmFJ?=
 =?utf-8?B?akw1RlNwTDNERmFrcE81WDJ3dzA1YVJ2OTlmd0R0TE4vL1RPRXV6cFlWNGll?=
 =?utf-8?B?NnBnd01pZDNveEpnd01PVjYyYWh2cGhKSDhsVjlYakx4YzF5U295ZmFXR3cr?=
 =?utf-8?B?ZzFkZkVNSXNBSEZEanBvaDdRS0FkVi9CR2hmTHRaNkxJMnowK25NRHNocGx4?=
 =?utf-8?B?ZHduOTU2aTFjQmJ3bVVxeEJKUmFFRmhBb2ZoRnh1dWNrbG1jZUxaSnFNK0lP?=
 =?utf-8?B?UjNIRkdIaUlxOUlvTlFhdXErTkF6dGxTd3Zla0poNTRJN1VZNTB5V2hUVnNT?=
 =?utf-8?B?d2NPZjVjZW81RkNpUFluK3U5dFhpUkxjcGJkcXBHSzUzVDI5Z0xOemF2UFdI?=
 =?utf-8?B?dTYzNisrcEp0M2VKeXdZekdyU1ZZT3FUM2lBYmhuSnlTcHJGSE5HZk1QdzZI?=
 =?utf-8?B?QXBUVDdwWXlqdmFXdFBHUUlWVWFyMnpGZVZqZ1VjMWoxRjJVWkdxdy9ONTFh?=
 =?utf-8?B?a1ZpMEtXcFdldVFJMmxBK1RkR1Z2T3VkZS94NnRnb3FZRnFhaWcralVnblJJ?=
 =?utf-8?B?c2RkUFdVOHJXOHZZc1RNV2trT0l1SGpwcjRHSXk1UzkrY0tXWXN2UVpJZTZU?=
 =?utf-8?B?TTdZVjJPSldVcFlPcVpPYUNrVUFwYXlPNlFYZWp3amZtN0NZTWpqakduVnE2?=
 =?utf-8?B?dkFlcUxtOUh1bnc0RzR4SURzZkZQZjV2NXFHd2lqL2l2TktWNjZ6bGxxaEJE?=
 =?utf-8?B?cG9YaCtqa3pBUHJTNHBQMjE2WjVJeXVYeHRLTStrdzRKY0lHa20wcFNudTNv?=
 =?utf-8?B?VmlLMUlKZ0JnZHQvdE85WWdaU1hQSmJ2RmNCY3Jna09UOC9mS0R0UEZXdW1s?=
 =?utf-8?B?aVZ4Um14Q1RXSjZhc0tyK3JTeUdsVFVxcE1RSnpHNVNMdG9CRm4rNDU3elZS?=
 =?utf-8?B?aWFad01QWm02bUxQd0szZ2wvMEtJTTF2a0d6ZzJsS1RjbFJIcXBIQzFQY2ZH?=
 =?utf-8?B?Z1FSK1NJcDUwdGlvMStFdVJ1VVhsTXhqN1U0VWx1OHdEa0U1Z3U4bUtUMUpu?=
 =?utf-8?B?QkdPN1p3M3FVV1c1eThCZ3F6VjQ4ZUFlc1lxc29MSDlXMkM5NXdaa1VTUHI4?=
 =?utf-8?Q?dVyRdddC?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR19MB4926.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c17e745e-1003-4d4a-5ba2-08d8c24bcf2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2021 22:43:32.6127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5bRImdCL31W3jQckXHUP8UKYziJLZBsTeAG/E5YxbT7pN4hCKs9QWJIvcmBwQKfeXX3vXIhlO1siIDkIl65LG1dKVuO43lSuURRjPcEqte8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR19MB4816
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-26_11:2021-01-26,2021-01-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 impostorscore=0 adultscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101260112
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101260112
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

PiBJIHdvdWxkIHB1dCB0aGF0IGluZm9ybWF0aW9uIGludG8gdGhlIGNoYW5nZWxvZy4NCg0KVGhh
bmtzLCBATWlrYSBXZXN0ZXJiZXJnIGNhbiB5b3UgY29sbGFwc2UgdGhhdCBpbiB3aGVuIHlvdSBy
ZS1zcGluIHRoZQ0Kc2VyaWVzPw0KDQo+IA0KPiBNb3Jlb3ZlciwgaGF2ZSB5b3UgbG9va2VkIGF0
IGFjcGlfcGNpX29zY19jb250cm9sX3NldCgpPw0KPiANCj4gV2hhdCBpdCBkb2VzIGlzIGFuYWxv
Z291cyB0byB3aGF0IHlvdSBhcmUgcHJvcG9zaW5nLCBidXQgYSBiaXQNCj4gZGlmZmVyZW50LCBh
bmQgSSB3b3VsZCBsaWtlIHRvIHByZXNlcnZlIGNvbnNpc3RlbmN5IGJldHdlZW4gX09TQyB1c2UN
Cj4gY2FzZXMuDQo+IA0KPiBTbyB3b3VsZCBpdCBiZSBwb3NzaWJsZSB0byBhZGp1c3QgdGhlIF9T
QiBfT1NDIGV2YWx1YXRpb24gZmxvdyB0bw0KPiBmb2xsb3cgdGhlIFBDSSBfT1NDIG9uZT8gIFRo
YXQgaXMsIGlmIGFueSBjb250cm9sIGJpdHMgYXJlIHRoZXJlLCBwYXNzDQo+IHRoZW0gYWxvbmcg
d2l0aCB0aGUgbGFzdCBldmFsdWF0aW9uIG9mIF9PU0Mgd2l0aCB0aGUgcXVlcnkgZmxhZyBjbGVh
ci4NCj4gT3IgaXMgdGhlIGxhdHRlciBkZWZlY3RpdmUgYW5kIGlmIHNvIHRoZW4gd2h5Pw0KDQpC
YXNpY2FsbHkgdGhlIG9ubHkgZGlmZmVyZW5jZSBpcyBhbm90aGVyIGxpbmUgY2xvbmluZyBPU0Nf
Q09OVFJPTF9EV09SRCBmcm9tDQpjYXBidWZfcmV0IHRvIGNhcGJ1Zj8NCg0KWWVzLCB0aGlzIGFj
dHVhbGx5IHNvdW5kcyBsaWtlIGl0IGJldHRlciBhZGhlcmVzIHRvIHRoZSBzcGVjIHRvIG1lLg0K
DQpRdW90aW5nIHNwZWM6DQoiIElmIHRoZSBPUyBpcyBncmFudGVkIGNvbnRyb2wgb2YgYSBmZWF0
dXJlIGluIHRoZSBDb250cm9sIEZpZWxkIGluIG9uZSBjYWxsIHRvDQpfT1NDLCB0aGVuIGl0IG11
c3QgcHJlc2VydmUgdGhlIHNldCBzdGF0ZSBvZiB0aGF0IGJpdCAocmVxdWVzdGluZyB0aGF0IGZl
YXR1cmUpDQppbiBhbGwgc3Vic2VxdWVudCBjYWxscy4iDQoNCg0KPiANCj4gPg0KPiA+ID4NCj4g
PiA+ID4gYW5kIHRoaXMgaXMgZ29pbmcgdG8gY2F1c2UgcHJvYmxlbXMgd2l0aCB0aGUgVVNCNCBD
TSAoQ29ubmVjdGlvbg0KPiA+ID4gPiBNYW5hZ2VyKSBzd2l0Y2ggdGhhdCBpcyBnb2luZyB0byBj
b21taXQgdGhlIHN3aXRjaCBvbmx5IHdoZW4gdGhlIE9TDQo+ID4gPiA+IHJlcXVlc3RzIGNvbnRy
b2wgb3ZlciB0aGUgZmVhdHVyZS4NCj4gPiA+ID4NCj4gPiA+ID4gRm9yIHRoaXMgcmVhc29uIG1v
ZGlmeSB0aGUgX09TQyBzdXBwb3J0IHNvIHRoYXQgd2UgZmlyc3QgZXhlY3V0ZSBpdCB3aXRoDQo+
ID4gPiA+IHF1ZXJ5IGJpdCBzZXQsIHRoZW4gdXNlIHRoZSByZXR1cm5lZCB2YWx1IGFzIGJhc2Ug
b2YgdGhlIGZlYXR1cmVzIHdlDQo+ID4gPg0KPiA+ID4gcy92YWx1L3ZhbHVlLw0KPiA+ID4NCj4g
PiA+ID4gd2FudCB0byBjb250cm9sIGFuZCBydW4gdGhlIF9PU0MgYWdhaW4gd2l0aCBxdWVyeSBi
aXQgY2xlYXIuDQo+ID4gPiA+DQo+ID4gPiA+IEFsc28gcmVuYW1lIHRoZSBmdW5jdGlvbiB0byBi
ZXR0ZXIgbWF0Y2ggd2hhdCBpdCBkb2VzLg0KPiA+ID4gPg0KPiA+ID4gPiBDYzogUmFmYWVsIEou
IFd5c29ja2kgPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tPg0KPiA+ID4gPiBTaWduZWQtb2Zm
LWJ5OiBNYXJpbyBMaW1vbmNpZWxsbyA8bWFyaW8ubGltb25jaWVsbG9AZGVsbC5jb20+DQo+ID4g
PiA+IFNpZ25lZC1vZmYtYnk6IE1pa2EgV2VzdGVyYmVyZyA8bWlrYS53ZXN0ZXJiZXJnQGxpbnV4
LmludGVsLmNvbT4NCj4gPiA+ID4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICBkcml2ZXJzL2FjcGkv
YnVzLmMgfCA0MyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tDQo+
ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMzEgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0p
DQo+ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvYnVzLmMgYi9kcml2
ZXJzL2FjcGkvYnVzLmMNCj4gPiA+ID4gaW5kZXggMTY4MmY4YjQ1NGEyLi5jYTdjN2IyYmY1NmUg
MTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvYWNwaS9idXMuYw0KPiA+ID4gPiArKysgYi9k
cml2ZXJzL2FjcGkvYnVzLmMNCj4gPiA+ID4gQEAgLTI4Miw5ICsyODIsOSBAQCBib29sIG9zY19w
Y19scGlfc3VwcG9ydF9jb25maXJtZWQ7DQo+ID4gPiA+ICBFWFBPUlRfU1lNQk9MX0dQTChvc2Nf
cGNfbHBpX3N1cHBvcnRfY29uZmlybWVkKTsNCj4gPiA+ID4NCj4gPiA+ID4gIHN0YXRpYyB1OCBz
Yl91dWlkX3N0cltdID0gIjA4MTFCMDZFLTRBMjctNDRGOS04RDYwLTNDQkJDMjJFN0I0OCI7DQo+
ID4gPiA+IC1zdGF0aWMgdm9pZCBhY3BpX2J1c19vc2Nfc3VwcG9ydCh2b2lkKQ0KPiA+ID4gPiAr
c3RhdGljIHZvaWQgYWNwaV9idXNfb3NjX25lZ290aWF0ZV9wbGF0Zm9ybV9jb250cm9sKHZvaWQp
DQo+ID4gPiA+ICB7DQo+ID4gPiA+IC0gICAgICAgdTMyIGNhcGJ1ZlsyXTsNCj4gPiA+ID4gKyAg
ICAgICB1MzIgY2FwYnVmWzJdLCAqY2FwYnVmX3JldDsNCj4gPiA+ID4gICAgICAgICBzdHJ1Y3Qg
YWNwaV9vc2NfY29udGV4dCBjb250ZXh0ID0gew0KPiA+ID4gPiAgICAgICAgICAgICAgICAgLnV1
aWRfc3RyID0gc2JfdXVpZF9zdHIsDQo+ID4gPiA+ICAgICAgICAgICAgICAgICAucmV2ID0gMSwN
Cj4gPiA+ID4gQEAgLTMyMSwxNyArMzIxLDM2IEBAIHN0YXRpYyB2b2lkIGFjcGlfYnVzX29zY19z
dXBwb3J0KHZvaWQpDQo+ID4gPiA+ICAgICAgICAgICAgICAgICBjYXBidWZbT1NDX1NVUFBPUlRf
RFdPUkRdIHw9IE9TQ19TQl9BUEVJX1NVUFBPUlQ7DQo+ID4gPiA+ICAgICAgICAgaWYgKEFDUElf
RkFJTFVSRShhY3BpX2dldF9oYW5kbGUoTlVMTCwgIlxcX1NCIiwgJmhhbmRsZSkpKQ0KPiA+ID4g
PiAgICAgICAgICAgICAgICAgcmV0dXJuOw0KPiA+ID4gPiAtICAgICAgIGlmIChBQ1BJX1NVQ0NF
U1MoYWNwaV9ydW5fb3NjKGhhbmRsZSwgJmNvbnRleHQpKSkgew0KPiA+ID4gPiAtICAgICAgICAg
ICAgICAgdTMyICpjYXBidWZfcmV0ID0gY29udGV4dC5yZXQucG9pbnRlcjsNCj4gPiA+ID4gLSAg
ICAgICAgICAgICAgIGlmIChjb250ZXh0LnJldC5sZW5ndGggPiBPU0NfU1VQUE9SVF9EV09SRCkg
ew0KPiA+ID4gPiAtICAgICAgICAgICAgICAgICAgICAgICBvc2Nfc2JfYXBlaV9zdXBwb3J0X2Fj
a2VkID0NCj4gPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjYXBidWZfcmV0
W09TQ19TVVBQT1JUX0RXT1JEXSAmDQo+ID4gPiBPU0NfU0JfQVBFSV9TVVBQT1JUOw0KPiA+ID4g
PiAtICAgICAgICAgICAgICAgICAgICAgICBvc2NfcGNfbHBpX3N1cHBvcnRfY29uZmlybWVkID0N
Cj4gPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjYXBidWZfcmV0W09TQ19T
VVBQT1JUX0RXT1JEXSAmDQo+ID4gPiBPU0NfU0JfUENMUElfU1VQUE9SVDsNCj4gPiA+ID4gLSAg
ICAgICAgICAgICAgIH0NCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAgIGlmIChBQ1BJX0ZBSUxV
UkUoYWNwaV9ydW5fb3NjKGhhbmRsZSwgJmNvbnRleHQpKSkNCj4gPiA+ID4gKyAgICAgICAgICAg
ICAgIHJldHVybjsNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAgIGNhcGJ1Zl9yZXQgPSBjb250
ZXh0LnJldC5wb2ludGVyOw0KPiA+ID4gPiArICAgICAgIGlmIChjb250ZXh0LnJldC5sZW5ndGgg
PD0gT1NDX1NVUFBPUlRfRFdPUkQpIHsNCj4gPiA+ID4gICAgICAgICAgICAgICAgIGtmcmVlKGNv
bnRleHQucmV0LnBvaW50ZXIpOw0KPiA+ID4gPiArICAgICAgICAgICAgICAgcmV0dXJuOw0KPiA+
ID4gPiAgICAgICAgIH0NCj4gPiA+ID4gLSAgICAgICAvKiBkbyB3ZSBuZWVkIHRvIGNoZWNrIG90
aGVyIHJldHVybmVkIGNhcD8gU291bmRzIG5vICovDQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAg
ICAvKg0KPiA+ID4gPiArICAgICAgICAqIE5vdyBydW4gX09TQyBhZ2FpbiB3aXRoIHF1ZXJ5IGZs
YWcgY2xlYW4gYW5kIHdpdGggdGhlIGNhcHMNCj4gPiA+DQo+ID4gPiBzL2NsZWFuL2NsZWFyLw0K
PiA+ID4NCj4gPiA+ID4gKyAgICAgICAgKiBib3RoIHBsYXRmb3JtIGFuZCBPUyBzdXBwb3J0cy4N
Cj4gPiA+DQo+ID4gPiBzL2JvdGggcGxhdGZvcm0gYW5kIE9TIHN1cHBvcnRzL3N1cHBvcnRlZCBi
eSBib3RoIHRoZSBPUyBhbmQgdGhlIHBsYXRmb3JtLw0KPiA+ID4NCj4gPiA+ID4gKyAgICAgICAg
Ki8NCj4gPiA+ID4gKyAgICAgICBjYXBidWZbT1NDX1FVRVJZX0RXT1JEXSA9IDA7DQo+ID4gPiA+
ICsgICAgICAgY2FwYnVmW09TQ19TVVBQT1JUX0RXT1JEXSA9IGNhcGJ1Zl9yZXRbT1NDX1NVUFBP
UlRfRFdPUkRdOw0KPiA+ID4gPiArICAgICAgIGtmcmVlKGNvbnRleHQucmV0LnBvaW50ZXIpOw0K
PiA+ID4gPiArDQo+ID4gPiA+ICsgICAgICAgaWYgKEFDUElfRkFJTFVSRShhY3BpX3J1bl9vc2Mo
aGFuZGxlLCAmY29udGV4dCkpKQ0KPiA+ID4gPiArICAgICAgICAgICAgICAgcmV0dXJuOw0KPiA+
ID4gPiArDQo+ID4gPiA+ICsgICAgICAgY2FwYnVmX3JldCA9IGNvbnRleHQucmV0LnBvaW50ZXI7
DQo+ID4gPiA+ICsgICAgICAgaWYgKGNvbnRleHQucmV0Lmxlbmd0aCA+IE9TQ19TVVBQT1JUX0RX
T1JEKSB7DQo+ID4gPiA+ICsgICAgICAgICAgICAgICBvc2Nfc2JfYXBlaV9zdXBwb3J0X2Fja2Vk
ID0NCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgY2FwYnVmX3JldFtPU0NfU1VQUE9S
VF9EV09SRF0gJg0KPiBPU0NfU0JfQVBFSV9TVVBQT1JUOw0KPiA+ID4gPiArICAgICAgICAgICAg
ICAgb3NjX3BjX2xwaV9zdXBwb3J0X2NvbmZpcm1lZCA9DQo+ID4gPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgIGNhcGJ1Zl9yZXRbT1NDX1NVUFBPUlRfRFdPUkRdICYNCj4gPiA+IE9TQ19TQl9Q
Q0xQSV9TVVBQT1JUOw0KPiA+ID4gPiArICAgICAgIH0NCj4gPiA+ID4gKw0KPiA+ID4gPiArICAg
ICAgIGtmcmVlKGNvbnRleHQucmV0LnBvaW50ZXIpOw0KPiA+ID4gPiAgfQ0KPiA+ID4gPg0KPiA+
ID4gPiAgLyogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gLS0tLQ0KPiA+ID4gLS0NCj4gPiA+ID4gQEAgLTExNjgs
NyArMTE4Nyw3IEBAIHN0YXRpYyBpbnQgX19pbml0IGFjcGlfYnVzX2luaXQodm9pZCkNCj4gPiA+
ID4gICAgICAgICAgKiBfT1NDIG1ldGhvZCBtYXkgZXhpc3QgaW4gbW9kdWxlIGxldmVsIGNvZGUs
DQo+ID4gPiA+ICAgICAgICAgICogc28gaXQgbXVzdCBiZSBydW4gYWZ0ZXIgQUNQSV9GVUxMX0lO
SVRJQUxJWkFUSU9ODQo+ID4gPiA+ICAgICAgICAgICovDQo+ID4gPiA+IC0gICAgICAgYWNwaV9i
dXNfb3NjX3N1cHBvcnQoKTsNCj4gPiA+ID4gKyAgICAgICBhY3BpX2J1c19vc2NfbmVnb3RpYXRl
X3BsYXRmb3JtX2NvbnRyb2woKTsNCj4gPiA+ID4NCj4gPiA+ID4gICAgICAgICAvKg0KPiA+ID4g
PiAgICAgICAgICAqIF9QREMgY29udHJvbCBtZXRob2QgbWF5IGxvYWQgZHluYW1pYyBTU0RUIHRh
YmxlcywNCj4gPiA+ID4gLS0NCj4gPiA+ID4gMi4yOS4yDQo+ID4gPiA+DQo=
