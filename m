Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F844417776
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Sep 2021 17:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbhIXP1E (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 Sep 2021 11:27:04 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:23052 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233132AbhIXP1D (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 24 Sep 2021 11:27:03 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18OBufr4030951;
        Fri, 24 Sep 2021 08:25:05 -0700
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-0016f401.pphosted.com with ESMTP id 3b9e88rpb0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Sep 2021 08:25:05 -0700
Received: from m0045849.ppops.net (m0045849.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 18OFBSc4002163;
        Fri, 24 Sep 2021 08:25:05 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by mx0a-0016f401.pphosted.com with ESMTP id 3b9e88rpat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Sep 2021 08:25:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKTC2qRep4dWCHllCHtsE2xIBOihfnZtN/R+bGVSOC2eWVVj5IlvS7ybvlPPfw5Qkq/UaTOg++MRUAr9KjVfZau0cKzxlDj3F+UPHhu8QSmLzSpn3310txRtyWX03Y09zN3u7pjV8LkX85+/MEVRY8lZfI7+7NG+9Wjjr7G6+qoyqns0t3LpkJMZ3E0soHaBnq+i21x3GEidGNK1LFQjRO6rBL4bbhy66/6mB451FY9A1fYaKmczGtTMtH0FglKN7ac5mYc4Pa0spBymDKCWgAZ+YLuqtqEROpKYWhOXfkV1tljmfGFTszGs4WhE5IrOsQGfh8/FITw1yYprvdzuCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=oa0jqhNsI7sv76x5KUppmrQ4aLysrW2i0r92GWxPANg=;
 b=YvENPpYXXLglC6DTpNxAP7LXIx/oANGLO2rvae1YF43MOnGxYVoKEF801AZOXeNKqnIWudpDlbjvNblPbxSfUeTqJgaNO3r+wK89EKrCUoqM3RE2DfHVdzvBhpOA7RC7Wp2SibMFAJWSQQId4JL645bTqZ2xbMdRHALP8ILb82EfTRylNtDwStJAsl+Z61NCvIGiFyVonhiIq8stsOSH1zdHaO3hRDA+xCw9TeMAcBIHqtE3MbiWqwbc9R92UNOGnzVPiiDORz6Zodr2Xgbxf69/mgKX5bFkDvWpHC1o37vDArmZoY4bjfq36lH+Evjh/RQj5YFJbT65qIZwKBhbgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oa0jqhNsI7sv76x5KUppmrQ4aLysrW2i0r92GWxPANg=;
 b=mquvLlvhkFGDnML4Jltdrr4dr/CC6/ERRyNftlnhpWj3POxBy9ljZLu2zLUukHwyVpxu3VWKtqQFFod//xRU2HLduyaOTY9zRAXRYofhUuutFTrFWu6Xzy0AStazCT/umtWfZflceVWHn30ZXIvH6WKp3Avy37MB1KWeOKwxpjk=
Received: from SJ0PR18MB3900.namprd18.prod.outlook.com (2603:10b6:a03:2e4::9)
 by SJ0PR18MB4108.namprd18.prod.outlook.com (2603:10b6:a03:2e9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Fri, 24 Sep
 2021 15:25:03 +0000
Received: from SJ0PR18MB3900.namprd18.prod.outlook.com
 ([fe80::d06:b37c:6f9a:ed3d]) by SJ0PR18MB3900.namprd18.prod.outlook.com
 ([fe80::d06:b37c:6f9a:ed3d%7]) with mapi id 15.20.4544.018; Fri, 24 Sep 2021
 15:25:03 +0000
From:   Vasyl Gomonovych <vgomonovych@marvell.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Robert Richter <rrichter@amd.com>,
        Tom Saeger <tom.saeger@oracle.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI: APEI: Check NULL argument in exported symbol
Thread-Topic: [PATCH] ACPI: APEI: Check NULL argument in exported symbol
Thread-Index: AdexKwfMuIc97LzgRRGYIeZLqnmnXg==
Date:   Fri, 24 Sep 2021 15:25:03 +0000
Message-ID: <SJ0PR18MB3900EC8E9BCB9EF18FE18C74A1A49@SJ0PR18MB3900.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d2c42c4-fcad-4a96-dda7-08d97f6f7b0b
x-ms-traffictypediagnostic: SJ0PR18MB4108:
x-microsoft-antispam-prvs: <SJ0PR18MB41081296C4A26844E43DD2ABA1A49@SJ0PR18MB4108.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hn3GDq6u3gUt1kWgtypQC14WbxotYW+UyyxRpJ8YV/o6tlRgl8hZ0Wwrci8WwZV6fU7rjh5SyhUQL03iONdhF72keVCiLWn1bXJkzE1pWWQY8D7EPmgWHG1ADdZ+wn3iQfK6KK4woP1dq2vwCWsmfPbUeE4ZTEhXUwNfR2FPgFs/UjrzS0/Ykr8GrY7FacocX95aNmpPqUPe3VBxh0GS40T9e3Klc1mawHY/Injojt1OllKz6dINZcqSTjAt+mcJlNXlZyjhh/0+UACNdN0XhrjUDKgwvh4Dg/LIFBKF46tizE+SzE7/kHBr9ZWpKSbvHGoyRmyAKFaEvk1Fi0jc/bxE5mTlZj0MbjrUDUx4dFTexcCg1KHdXKJgZzT9YgUP2kPgNHRwoEEgm5CwC6z7oZds5nTosycOWW9EjrzAq/RxwavWWFJ5Nbne8sKIN86VNolRwSsES6jaInlosw1gXcah2yiPahyER5l3IweFnBo9cC+RG5Xe7O+QmdB4UL4VHxLcz4CE1RSjffUz9fEAnE4WyPNOJcry/iGe7wm9SlBub6FeG57j4Zx8KbPb8+Fy+ErUcm6BNKDFw9ObNLjzzl+poI4YCSMmTCI5Q5CGcd4PGINsg/1J+BC43zXfFTKLQnzYPdk0quXFcbvm8+LLM1di6gYAF0ydw632y17+x14ec+0dzzwvjOi326QlHBVKXlmOCV0suuWYhwi12Hm4bA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB3900.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(26005)(66946007)(4326008)(33656002)(186003)(8936002)(86362001)(55016002)(76116006)(2906002)(508600001)(64756008)(66556008)(7416002)(6916009)(6506007)(66476007)(38070700005)(316002)(66446008)(8676002)(122000001)(54906003)(52536014)(71200400001)(9686003)(38100700002)(7696005)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UmljNEEvTFB5WGhJdndkc0NqYVp4d2YrSnd5OFFlN25CcjhYa2tOQXZIWGkx?=
 =?utf-8?B?dzBtNzhWYlBMRHcvVG9IMk5FMTMwOWRMSFhPSEd4ZGlDY3F5NXpRRHdjWUhJ?=
 =?utf-8?B?UEpOdUJXOW1TZ1d1a0F1SDMrYU1tbWtKZTRUZHZuT3UzbmNvTlZTZDBHWkZM?=
 =?utf-8?B?alRvbUdqai9tcmFVcmFzMHcrOG5DMGtuRms2Q04xV1pWUVFYWkFnNWVFUXBS?=
 =?utf-8?B?bERBOUNvSGl2Z1owRXRGNEt1QVRxRmlBMmNUR0htaE40TmkrUHp1UWdZck9G?=
 =?utf-8?B?NGI1d0FkWkdUSVhERFVYQUZURURsQ3BTK0VVbnNFdzN5VDlQcWJXam44YW8r?=
 =?utf-8?B?elpnZUpUV3BrSUc1ZnZGVmN4ZERpM2VzMlV3YzNCNlZqTDNlOUFUd2VlejB3?=
 =?utf-8?B?MWtPbHZlOWxhaXRBa0JpbWNPRXBkY3VQK042SHVEL1hHUVMrOVQyanVNVHoz?=
 =?utf-8?B?bFo5RjVDV0tvOUdWWVZyVkZabjh5NmZydzVRM0VZODlEdUtJUzVmNDB3VlV4?=
 =?utf-8?B?Si9hQndEWTNHeHk1b0hUaDQya2p6b3pOVi9VY1RZWDVKREFZY0htZmRVdDh4?=
 =?utf-8?B?RVo0YnNCdHVhRmVCSzZSMnFTYk9mRXVsb2lYelA3SkhhUVRFczVqVzM5R0FN?=
 =?utf-8?B?dXV6a3BPa3hid0dyMytiRUtUWEZBREFEd3BlaGM4eEhULzl5VXA1U1kxMjlF?=
 =?utf-8?B?VDBHc1R0WWR5aGxWWFBRUGpXbVdxWUdiK2RiNjJjZEJ5T0kyc3VWenR1STNN?=
 =?utf-8?B?MStGNHhpTTZyeThaSGZ4QWM5OEwxb09LQWcyNGswN3JRR014dEJEV1pGNE5F?=
 =?utf-8?B?LzN2Rk1raEEyN0dtTnY4SHlIbG5vK1EwNG5EZThFenpjcjB5bERqVUdrc1Zl?=
 =?utf-8?B?d0VMQmJIemJNTFNZYzlFeWNMRWxsOVo1TklKdjd6Vk0xNXJlS3RBdFk0WjA3?=
 =?utf-8?B?cVRrcHVwK1Y3czlSRDJqdHpvOHdzc29SdWVjdGtPK216SS9wYjJLSVpnR0V5?=
 =?utf-8?B?R0pTVVUrM011SEZ6dEdTMEg2UU5NMUlJM3JicmhKSGk1MThNZkdpZXVmTS9E?=
 =?utf-8?B?VVhKcitVLzZWWC9TY2xaakNiN3RtcklkQ2lpWVNobXZSUDVlaEpEa29mWW8r?=
 =?utf-8?B?cklEUG5XYWljdkQvQ0h1Vkt6Z1JFZDNPREtrLyt5dHVoOTc4ZkJRRWRIeVNw?=
 =?utf-8?B?eUxEalJndCtoVEpBM3hyZW5kT0xqanl6VVlYQlVLQTNuVVlULzlzNDB3eXZO?=
 =?utf-8?B?UTBldHRJcDd1Z2pZNU5INDQvMXdia2x3SEhyVkR0dVorTTZ5UnBmTXpFWHhh?=
 =?utf-8?B?bmtzZXhFK2pYSGV4QTZqVXJ3L00xaFREaC9vNHducEMxNDhZQ3FRN05KTTFw?=
 =?utf-8?B?VDczVU5ITkNJNjh1ZDNUbnZNWnpJUVVWWUIvUHRwQXBUMVpDZ0FEMjFjeWM0?=
 =?utf-8?B?eE1YeEhBWTk0RlRjdEQ4YVQycVNNL1JOOEYvUHpHRW5iMEczQ1NLUjVLSisv?=
 =?utf-8?B?eXA1enNjR3VyUGpNNkdOSkxQZFlQZitsdkxoQU5qbnJ2bG1HUVIzdExRNEl6?=
 =?utf-8?B?MTVvMCtsVG9HVTVDOW0xNDNpcCtsV0x0bVM3aWxMbkZSNjNNYStPVWhtSkdC?=
 =?utf-8?B?MU1lZlgrM08wS0dET3FxalN3Zzh6bFArK1pEQkFnVUhpU1lhOXo5UkFVQitz?=
 =?utf-8?B?M0NKSU9aNGhMeGFqdjMvTmxkNHl5a1A4Z1ZkeEE2SE9OcWtDc3pwS0JQcTFx?=
 =?utf-8?Q?1mWuiG65z3BQLWD6QEU5gJoiUjPgowSSWLDnaSF?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB3900.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d2c42c4-fcad-4a96-dda7-08d97f6f7b0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2021 15:25:03.1471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fIDeyYH4bQ1h4KB2C8mgVv2hMyIGVnMViFwpD97SLKbwUoGmk/Wqe4IfeaAiW+NtHIqzz0KXto4NfoXh2W4dhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB4108
X-Proofpoint-GUID: 7losc-EFzUQPU__edAv_T4G3vvvl2ClW
X-Proofpoint-ORIG-GUID: UGZLPpxtV339FOihHfClMVPAsoAXB9T9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-24_05,2021-09-24_02,2020-04-07_01
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

PiBMb29raW5nIGF0IHRoaXMgbW9yZSwgdGhhdCBhcGVpX2hlc3RfcGFyc2UoKSB0aG5nIHNob3Vs
ZCBiZSBtYWRlIHN0YXRpYyBhbmQgdGhlIGV4cG9ydCBkcm9wcGVkLg0KSSBmb3VuZCAgYXBlaV9o
ZXN0X3BhcnNlKCkgdXNlZnVsIEFQSSB0byBhY2Nlc3MgdGhlIEhFU1QgdGFibGUuDQpJIHRoaW5r
IFJBUyBkZXZlbG9wbWVudCBzaG91bGQgaW5jcmVhc2UgdGhlIG51bWJlciBvZiB1c2VycyBvZiBh
cGVpX2hlc3RfcGFyc2UoKS4NCldpdGggdGhpcyBBUEkgd2UgY2FuIHJlYWQgSEVTVCBhbmQgbW9k
aWZ5IGl0Lg0KUmVhZCBleGFtcGxlIGlzIHRvIGdldCBhIGNvdW50IG9mIGVycm9ycyBzb3VyY2Vz
IGZyb20gSEVTVCB0YWJsZXMgZnJvbSB0aGUgZXh0ZXJuYWwgZHJpdmVyIGFuZCB1c2UgdGhhdCBj
b3VudGVyIGZvciBkcml2ZXIgZGF0YSBhbGxvY2F0aW9uLg0KT25lIG9mIHdyaXRlIGV4YW1wbGUg
aXMgdG8gcGF0Y2ggZXJyb3Jfc3RhdHVzX2FkZHJlc3MsIGlmIGZpcm13YXJlIGNoYW5nZSANCm1l
bW9yeSBsYXlvdXQgYmFzZWQgb24gYm9vdCBjb25kaXRpb25zLCBlcnJvcl9zdGF0dXNfYWRkcmVz
cyBmcm9tIGhlc3QuYXNsIGNhbiByZXF1aXJlIHNoaWZ0IHdoaWNoIGNhbiBiZSByZWNvZ25pemVk
IGJ5IGRyaXZlci4NCkN1cnJlbnRseSBteSBSQVMgZGV2ZWxvcG1lbnQgdW5kZXJ3YXkgYW5kIEkg
cmVjb2duaXplIHRoYXQgbGVnYWwgYW5kIG9wZW4gd2F5IHRvIHRvdWNoIEhFU1QgdGFibGUgaXMg
DQp2aWEgYXBlaV9oZXN0X3BhcnNlKCkgZnJvbSBleHRlcm5hbCBkcml2ZXIuIA0KQWJzdHJhY3Rp
b24gbGF5ZXIgYmV0d2VlbiBkcml2ZXIgbWFpbiBwdXJwb3NlcyBhbmQgc2V0dXAgcHJvY2VkdXJl
IEhFU1QgYWNjZXNzIHV0aWxpemUgbWFpbmx5IGFwZWlfaGVzdF9wYXJzZSgpLiANCkZyb20gIHRo
aXMgcGVyc3BlY3RpdmUgYXBlaV9oZXN0X3BhcnNlKCkgYmVjb21lIGNlbnRyYWwgZnVuY3Rpb24g
aW4gYWNjZXNzIGFic3RyYWN0aW9uLiANClRoYXQgaXMgd2h5IEkgdGhvdWdodCB0byBtYWtlIHRo
aXMgY2hlY2suIEJ1dCBvZiBjb3Vyc2UgdXNlciBzaG91bGQgYmUgcmVzcG9uc2libGUgZm9yIG93
biB3YXkgb2YgYWNjZXNzLg0K
