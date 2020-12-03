Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 587D72CDF78
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Dec 2020 21:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbgLCUN2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Dec 2020 15:13:28 -0500
Received: from mga06.intel.com ([134.134.136.31]:59381 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726681AbgLCUN1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 3 Dec 2020 15:13:27 -0500
IronPort-SDR: YU19Kw8s3RBPStgY1nR/oLr92x95RDBfMdyq/TaW6GAzo/ccIvueohnRCQS+HmaHh0tO1VK1Ju
 z9B/WscuLFkg==
X-IronPort-AV: E=McAfee;i="6000,8403,9824"; a="234876609"
X-IronPort-AV: E=Sophos;i="5.78,390,1599548400"; 
   d="scan'208";a="234876609"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 12:12:46 -0800
IronPort-SDR: S8mphnDxeeP8fyqZloK49TDu6Y41mAUnJqECCMkdHOU3emesUcGJQyESjaok/jOGOvcM3CGRPw
 4M8xHS9knOTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,390,1599548400"; 
   d="scan'208";a="336089162"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 03 Dec 2020 12:12:46 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 3 Dec 2020 12:12:45 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 3 Dec 2020 12:12:45 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 3 Dec 2020 12:12:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJ+a8BtAMwFiNHCXhW1xpjU/hBGxnuWRMB/HKDASICXbmCMtnrLXXX6opt6zUrnRtysRc6sgJvpht/K/xmEdBJaqlRCmJwouSllEMqrN2sM5XMJHiYZ1lxL4BlZz18Nc+BPqHvT5hEiVyAzBCWa2jsP2kslIlGvTiPH1/YD+QN9vrCLfhV1jvtWmxE1AOaxyxavMMpN6/19tHuOvd+n37LsVFekUUJL9hHXand0Ody5hr+9kvALVZJyXx7rzP9kHC8v4YnyUhe/BWJ3bHhAuX9khH0uRuuskiupGS1MocCQJUfcRjC/xtA93/NUZN1mu3R7ivrOmVSCKAUS+am5q+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vRTltciFCXhJv8Xj8oYrhXa448HLFWVbkLxlANbyKE=;
 b=g+TOi20Z0E+0dqNZ9mh3VnfyMROuRUDQvTYMQyIB612vVNZF5NalvbB4pUppz/dhmjyh53L+sBJcSBaNPGkq9k37xW0Mrkk+7J24mWK0Nj0ZPSTj4qvCEj+TvB5Co6T2JH0x43UBjp4BqbNpb2UGzpNi2B1m9aKrndYDwrNm2+0S4bz6sauQSAHZbLDcwilqHgkslMYvrFkZmLlQrrmcAXAWocad2Ahzws1U5+Ek/sI637zeUTJaEcfc1h1Q18+L4qIiMsC4dKgQ4FEWk3KflBpsPE1IqYL8pXmEh28jHXv1BIRnF5upW+3+Xhd5I9KKgyS+8VSqLB6BKQBIEPNTkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vRTltciFCXhJv8Xj8oYrhXa448HLFWVbkLxlANbyKE=;
 b=Sl/nmJrwMQfWo5V0Pj/v/1mmF5mms7PqysFYvXca0L1mIzPiewyV670GqjXFj3C4a1fixFK3jTP0DLb16tnG0ewc9Sro32hb8ABDmBCNpslGFQH3iqvbBCdtNC5hGVZDSdRFSIZvPwq1VaKykn6AuK5Zdy1uDpW8H3j3APwFI5s=
Received: from BYAPR11MB3448.namprd11.prod.outlook.com (2603:10b6:a03:76::21)
 by BYAPR11MB2727.namprd11.prod.outlook.com (2603:10b6:a02:c7::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Thu, 3 Dec
 2020 20:12:39 +0000
Received: from BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::8004:3bed:cc13:e8ae]) by BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::8004:3bed:cc13:e8ae%7]) with mapi id 15.20.3611.035; Thu, 3 Dec 2020
 20:12:39 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Widawsky, Ben" <ben.widawsky@intel.com>,
        "Douglas, Chet R" <chet.r.douglas@intel.com>
Subject: ACPI Working Group Code First ECR for a new CXL Root Object
Thread-Topic: ACPI Working Group Code First ECR for a new CXL Root Object
Thread-Index: AQHWybClBaIPKwEtiUmr0E2A2oaIeQ==
Date:   Thu, 3 Dec 2020 20:12:39 +0000
Message-ID: <ecfd911dc8b9a5bac89d1de68047400d15525232.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5 (3.36.5-1.fc32) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.137.79]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ffda2804-36a6-4df0-0fa5-08d897c7c88b
x-ms-traffictypediagnostic: BYAPR11MB2727:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB27276E15B88807D7D1FED030C7F20@BYAPR11MB2727.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H+Jd2EeQVNYwOeKCA/+9D8aKLFtpTmmoirwQwZGps7+oSzvj3xFmMABdbAuHTLZlNxb/xZSTAO5+hmTqA7g5kB97W3nx0qlC9TN2qzeo0UojVMcdCRfcTuCIzKtfkeUCVRBuf09yk6+4RATrSDHx+POuCH1MLKbuFEDenjKme5HX25HriUJZjevT/2IZyVE5WeYCrP9efke0LSzWmqXMaW87uiCZdXU3rCGiyEjQCPDvUEuzxBQv+RDjRu0Qi9k1Ou7jMrgXWz89KPf9VNB+MqmvbB+xs2KA6YEvL5UBPp7MzdhqB5ilYZbJk0TbKcgKzJ2HYCXjcnFYWZoKYqlf5lFl5hAVo/bd55CNSxQZYbFuP9QkxlV6IKvFTfyrN5bixVeKknMdSmzDodZEQnhx1A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3448.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(4326008)(2616005)(5660300002)(86362001)(71200400001)(110136005)(316002)(54906003)(6486002)(6512007)(66556008)(64756008)(66476007)(66446008)(66946007)(478600001)(91956017)(2906002)(36756003)(26005)(966005)(8936002)(76116006)(186003)(8676002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?OEpqWG5BZTFLMDBhMjQxWUo1ZEptNU9heDZTVUw3bDRJV2NjSUE1eFROSWd2?=
 =?utf-8?B?VzBSRUt0OFY3d0tiT2FhWDJEMlRXbFovbFl5STViNjdEK0Z2UDE0VGdQZ01D?=
 =?utf-8?B?N3ZDamVGelprRXk2RGthOUVSbXRjVm5jcSt6UkU3UkUwOWRyd29EMU41RUVM?=
 =?utf-8?B?ck1aMVhmRHJPMHY3WU5VR2sxQVI1ZjkvYVd2a3BqTWhTd1NZakNnV3pBTkZO?=
 =?utf-8?B?aTFEaDQ1UzYwcGNJWXI1MWRMaGE2TEo0eXpLSndnSGhOMHg4YW9KVXQ4eE9p?=
 =?utf-8?B?dVY1eWMxSG9hK25pZEV1c1VoVUtyNTQ3QXNjODFHUzJXV2ljMUhnR0h0RkVr?=
 =?utf-8?B?MUh0eDZvRkFYMEw5T2JaK1hkUUEzU2xaOWw5b2s3dGx1aWdQc1AyMzBvdE1J?=
 =?utf-8?B?SXpFL21IMitMTysrUW1KdmZyUnZESTdGbXhlWWk4cU92TWtyR01Pd1RVUXU0?=
 =?utf-8?B?M0U0TVR3Z3ZnQmxMRDBrTndoYlJWQzQ2V2lCYThjT3ZWL1hWTlMvdXdOd2lQ?=
 =?utf-8?B?a1dSckd5TjhSWnMxY1JQdVlWVld5WllISFhzbmJCdkpSOFhHV0Q3bXd5NDZ4?=
 =?utf-8?B?WElCdHZudmdTUmhqRmwxMUowNjdqWWY3cWw4MzRKaEErOVpoV3FaRzhndmUw?=
 =?utf-8?B?YjZtc2lLUkpLZDVKdjJ3dnZJeW1Db0FuZ3psVnRDRWhlZHFreWhtUG1BRWV1?=
 =?utf-8?B?N3pTS0pGa2liaWI0L2NPcWp0bFg3eFA0WGwxY01TTmx6UkpwUW91MnJGbFE3?=
 =?utf-8?B?YnhxLzcydjlES0NXWHpXUE1yQWEzOEVkWlBmdzZUbkNUWGhteHFhc1VCd1p4?=
 =?utf-8?B?QXJyRzV6UDd6amMxcHlOa3A0enFHYWFzODV0M2RqQUorZHpmemtGZXFmRk9Y?=
 =?utf-8?B?S3ZadEZRYVJta0tpYnh6TFF2M3JYR2U0c3lMOS9IeUduaW5PL2FHekVycjFU?=
 =?utf-8?B?TURzLzRaMFNXQm1IbkpPMU5FTFMrRXFPQlV2aUpiaVZXeEU1M1dwc0F0T0c0?=
 =?utf-8?B?SFBVdmV0VVJ4Q0pNVG1VR2tBQVpQcmUyQTk1SXZpSStvUHluOUtHMkZjQXdw?=
 =?utf-8?B?WGNZRGxwaGNCcGNGMlpFU3VWM3Y0aVI3cnBpSGphVWJLR09UaDdNbVBOVldB?=
 =?utf-8?B?VWlGSTN4RTdHNjJQSTdZYVpNRHN3dE4zaGhHRlhKWUZqRHQ1TVVQOEw0SnJE?=
 =?utf-8?B?cVh3TENGVS9SeG9qRkNZZCtwdEpoeTVxb1FBdStqaVAzZmowRElqZm1HVnpl?=
 =?utf-8?B?U1VvQXU3U2JvQkt4MnRwSkpJWGFlS3owU2ZQalF0Ulh2SnBXeEIwdFV0amZM?=
 =?utf-8?Q?2zcbaRBPPHGUnMmnSZvLlUEC4MU4Wa2LHJ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <36C87A6767064D40801BECB5729D3872@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3448.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffda2804-36a6-4df0-0fa5-08d897c7c88b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2020 20:12:39.0438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SBoCtz99PY8cq/J+ngrbAHWQcbkX4YBUtzF+nXhBUPh/Gw+uyCc2utFZDvjuTXAaYll7ZW5nPDE5Fk3t+aI8xw68J1mMA2B5B2S01ka04yY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2727
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

VGhpcyBpcyBhIHB1YmxpYyBSRkMgb2YgYW4gQUNQSSBwcm9wb3NhbCB0byBhZGQgYSBuZXcgQ1hM
IFJvb3QgT2JqZWN0DQp0aGF0IGluZGljYXRlcyB0aGUgcHJlc2VuY2Ugb2YgYSBDWEwgaGllcmFy
Y2h5LiBUaGUgcHJvcG9zYWwgaXMgYmVpbmcNCm1hZGUgaW4gdGhlIG5ldyAnQ29kZSBGaXJzdCcg
d29ya2Zsb3cgb2YgdGhlIEFDUEkgU3BlYyBXb3JraW5nIEdyb3VwLg0KVGhlIHN1YmplY3QgbWF0
dGVyIGhlcmUgaGFzIGJlZW4gZXhwbG9yZWQgaW4gcHJldmlvdXNseSBwb3N0ZWQgcGF0Y2hlcw0K
dG8gUUVNVVsxXSBhcyB3ZWxsIGFzIExpbnV4WzJdLiBUaGVzZSBwYXRjaGVzIGhhdmUgc2VydmVk
IGFzIGEgcHJvb2Ytb2YtDQpjb25jZXB0IHRlc3QgdmVoaWNsZSB0byBoZWxwIGVuc3VyZSB0aGF0
IHRoZSBwcm9wb3NhbCB3b3JrcyBpbiBwcmFjdGljZS4NClRoZSBjb3ZlciBsZXR0ZXIgaW4gc2Vy
aWVzIFsyXSBnb2VzIGludG8gYWRkaXRpb25hbCBkZXRhaWwgKHNlY3Rpb24NCnRpdGxlZCAnQUNQ
STAwMTcnKSBmb3IgdGhlIHJlYXNvbmluZyBiZWhpbmQgdGhlIHByb3Bvc2FsLCBhbmQgd2hhdCBp
cw0KbmVlZGVkIGJleW9uZCB3aGF0J3MgZGVzY3JpYmVkIGluIHRoZSBDWEwgMi4wIHNwZWMuDQoN
ClRoZSBjaGFuZ2UgcHJvcG9zYWwgdGhhdCBmb2xsb3dzIGlzIGluIG1hcmtkb3duIGZvcm1hdC4N
Cg0KWzFdOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjAxMTExMDU0NzI0
Ljc5NDg4OC0xLWJlbi53aWRhd3NreUBpbnRlbC5jb20vDQpbMl06IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xpbnV4LWN4bC8yMDIwMTExMTA1NDM1Ni43OTMzOTAtMS1iZW4ud2lkYXdza3lAaW50
ZWwuY29tLw0KDQotLS0tDQoNCiMgVGl0bGU6IEFkZCBDWEwgUm9vdCBPYmplY3QgX0hJRA0KDQoj
IFN0YXR1czogRHJhZnQNCg0KIyBEb2N1bWVudDogQUNQSSBTcGVjaWZpY2F0aW9uIDYuNA0KDQoj
IExpY2Vuc2UNClNQRFgtTGljZW5zZSBJZGVudGlmaWVyOiBDQy1CWS00LjANCg0KIyBTdWJtaXR0
ZXI6DQoqIFNwb25zb3I6IFZpc2hhbCBWZXJtYSwgSW50ZWwNCiogQ3JlYXRvcnMvQ29udHJpYnV0
b3JzOg0KICAgICogQ2hldCBEb3VnbGFzLCBJbnRlbA0KICAgICogQmVuIFdpZGF3c2t5LCBJbnRl
bA0KICAgICogRGFuIFdpbGxpYW1zLCBJbnRlbA0KICAgICogVmlzaGFsIFZlcm1hLCBJbnRlbA0K
DQojIFN1bW1hcnkgb2YgdGhlIENoYW5nZQ0KQWRkIOKAnENvbXB1dGUgRXhwcmVzcyBMaW5rIFJv
b3QgT2JqZWN04oCdIGVudW1lcmF0aW9uIHZhbHVlIHRvIHRoZSBBQ1BJDQpEZXZpY2UgSURzIFRh
YmxlICg1LjE2MCkuDQoNCiMgQmVuZWZpdHMgb2YgdGhlIENoYW5nZQ0KQ29tcHV0ZSBFeHByZXNz
IExpbmsgKENYTCkgaXMgYSBuZXcgaGlnaC1zcGVlZCBDUFUtdG8tRGV2aWNlIGFuZCBDUFUtdG8t
DQpNZW1vcnkgaW50ZXJjb25uZWN0LiBUaGUgbmV3IEFDUEkgRGV2aWNlIElEIHJlcHJlc2VudHMg
YSBzaW5nbGV0b24NCmRldmljZSB0aGF0IGFsbG93cyB0aGUgT1NQTSB0byB0cmlnZ2VyIHRoZSBl
bnVtZXJhdGlvbiBvZiB0aGUgQ1hMLm1lbQ0KYWRkcmVzcyBzcGFjZSwgYW5kIGluZGljYXRlcyB0
aGUgcHJlc2VuY2Ugb2YgY3Jvc3MgSG9zdCBCcmlkZ2UNCihBQ1BJMDAxNikgaW50ZXJsZWF2ZWQg
Q1hMLm1lbSByZXNvdXJjZXMuDQoNCiMgSW1wYWN0IG9mIHRoZSBDaGFuZ2UNCk9uZSBuZXcgcm93
IGFkZGVkIHRvIHRoZSBBQ1BJIERldmljZSBJRHMgdGFibGUgKDUuMTYwKS4NCg0KIyBSZWZlcmVu
Y2VzDQoqIENvbXB1dGUgRXhwcmVzcyBMaW5rIFNwZWNpZmljYXRpb24gdjIuMCwNCjxodHRwczov
L3d3dy5jb21wdXRlZXhwcmVzc2xpbmsub3JnLz4NCg0KIyBEZXRhaWxlZCBEZXNjcmlwdGlvbiBv
ZiB0aGUgQ2hhbmdlDQoNCkFkZCDigJxDb21wdXRlIEV4cHJlc3MgTGluayBSb290IE9iamVjdOKA
nSBlbnVtZXJhdGlvbiBkZXZpY2UNCg0KIyMjIDUuNi43IERldmljZSBDbGFzcy1TcGVjaWZpYyBP
YmplY3RzDQoNCk1vc3QgZGV2aWNlIG9iamVjdHMgYXJlIGNvbnRyb2xsZWQgdGhyb3VnaCBnZW5l
cmljIG9iamVjdHMgYW5kICAuLi4NCg0KVGFibGUgNS4xNjAgQUNQSSBEZXZpY2UgSURzDQoNCnwg
VmFsdWUgfCBEZXNjcmlwdGlvbiB8DQp8IDotLS0gfCA6LS0tOiB8IDotLS06IHwgOi0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLSB8DQp8IC4uIHwgLi4gfA0KfCBBQ1BJMDAxNyB8ICoqQ29tcHV0
ZSBFeHByZXNzIExpbmsgUm9vdCBPYmplY3Q6KiogVGhpcyBkZXZpY2UNCnJlcHJlc2VudHMgdGhl
IHJvb3Qgb2YgYSBDWEwgY2FwYWJsZSBkZXZpY2UgaGllcmFyY2h5LiBJdCBzaGFsbCBiZQ0KcHJl
c2VudCB3aGVuZXZlciB0aGUgcGxhdGZvcm0gYWxsb3dzIE9TUE0gdG8gZHluYW1pY2FsbHkgYXNz
aWduIENYTA0KZW5kcG9pbnRzIHRvIGEgcGxhdGZvcm0gYWRkcmVzcyBzcGFjZS4gfA0KDQojIyBT
cGVjaWFsIEluc3RydWN0aW9ucw0K
