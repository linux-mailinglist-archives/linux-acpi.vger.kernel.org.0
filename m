Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF86029BFBD
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Oct 2020 18:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1816561AbgJ0RHh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 27 Oct 2020 13:07:37 -0400
Received: from mga02.intel.com ([134.134.136.20]:33467 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1816551AbgJ0RHf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 27 Oct 2020 13:07:35 -0400
IronPort-SDR: u5PuF+3kK7mYsdqkQxl5wBWc4fc3u/8Fd3vVlwRfVtHojCKSCdPJAIrWy3Wf974sZG9v4Ki89X
 pDTiEL4o7Jnw==
X-IronPort-AV: E=McAfee;i="6000,8403,9787"; a="155092503"
X-IronPort-AV: E=Sophos;i="5.77,424,1596524400"; 
   d="scan'208";a="155092503"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 10:07:32 -0700
IronPort-SDR: /Rj8gb+qVDyOI1eZcKW0lD2blNmINcLe83fdJ/JocH9q/bGuDB/A+4OrwGDaNDLf09ObcF+1yp
 5b5z0vTpzxdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,424,1596524400"; 
   d="scan'208";a="424473618"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga001.fm.intel.com with ESMTP; 27 Oct 2020 10:07:30 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 27 Oct 2020 10:07:30 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 27 Oct 2020 10:07:30 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 27 Oct 2020 10:07:30 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.58) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 27 Oct 2020 10:07:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aysxvlFEdkMAzfmchtd1y/63Fuuw1oIp/voyvc+i5JF4zNDjA54beo+6GP8rV8ylp6ulbQWLB+bFmmcOgKPmiGTLAdknN5kmATVClda5st3bJn9H/XvArGmQ9i5SdMmBJ9cYiczqmq/GTCVrXEs6q/odUQt180/ZogfX0wp5HDQrINvSO+nGMqRT8yNwLk1jNVwWLBVeD3CfYYoEFpkX7NsgeuK8kqktLzm3AOGODsvxNd6gbB3lABvYXMkaj+M4HW35uY8Gk5ND1DFhbfkK6jwWqVPTp0veW1UV/pv50XRCVLoOw/RM0QAw1C0up7S9wUwVHMAght5gg0pFRQa7Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9wx8hG6vOOptnTTL1oOxCDWPoJmGq0QXmLlBpWbQ9hQ=;
 b=DLtSAsNYUMu+wbuK1JF2LAkyyZ5YhrqQ00wDmzslFt4Bc3+b6hd0gGLdvlyNIKWtZustY/dXzjnRCpe4L5qACXO/8wBbNmQSSeQe/nSBq/jrjQ0GmlzOqjC12pjW7IDN4xAwLAGaSPnG8ER+ej4A0+43XBDtvFhswN39S4Qy6nrae+o7Wto7C42J5SbnMsMFYDHzrwYHVIfFIVjAe4iW0oTYXUQIOsgFbRH5pgKn+KlZRyNVXQfxu/EEAcdgQJ+sYA5Iwbbo4I96xa2d378qBMzzHNAL6nRB7BXtek8/Y3u2cbB4hZBV4bjDVprFvHoOMKTN5zwTc7iQD9F1FVyWfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9wx8hG6vOOptnTTL1oOxCDWPoJmGq0QXmLlBpWbQ9hQ=;
 b=C5YZsI+n6oQQNUSzWUObDDgTPJYPgx9HkRWnQyWTETYnYfHHUcGwKh96edU5P/pMZ20taJYL5T7xrOYHgWVMY8CqDGOQkTORmpjt/E4t6SSTUSbiSY2AlCmlofhj4mfL2OeLwU0aN42QVpAl1z9z01gmxKbq37JzAsuesleplMo=
Received: from BYAPR11MB3448.namprd11.prod.outlook.com (2603:10b6:a03:76::21)
 by BYAPR11MB3477.namprd11.prod.outlook.com (2603:10b6:a03:7c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Tue, 27 Oct
 2020 17:07:22 +0000
Received: from BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::ecd4:8f8f:fa3d:f63d]) by BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::ecd4:8f8f:fa3d:f63d%7]) with mapi id 15.20.3499.018; Tue, 27 Oct 2020
 17:07:21 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "zhangqilong3@huawei.com" <zhangqilong3@huawei.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
CC:     "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH -next] ACPI: NFIT: Fix judgment of rc is '-ENXIO'
Thread-Topic: [PATCH -next] ACPI: NFIT: Fix judgment of rc is '-ENXIO'
Thread-Index: AQHWrGZ8H45w4kaXzUO4aq8lvusVLqmrrnSA
Date:   Tue, 27 Oct 2020 17:07:21 +0000
Message-ID: <36878b3b8ad11e4139e5b8b8d1e8c9c42a221521.camel@intel.com>
References: <20201027134901.65045-1-zhangqilong3@huawei.com>
In-Reply-To: <20201027134901.65045-1-zhangqilong3@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5 (3.36.5-1.fc32) 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.137.77]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5cf0036e-3cca-477c-8ec8-08d87a9ac4e5
x-ms-traffictypediagnostic: BYAPR11MB3477:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB347700390E65EFD21C1804DCC7160@BYAPR11MB3477.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3tUgafHiVce1H989LPuHXLe2/NNSdOyYg+xV/5PSVLKfzTqO7HrIzLYN46KQO2f4nsR/cEYuJgdHwSRBdSYLoz0W14g8fwD3ioRvgzGh93qki/z9c8gtjOdwkm5mRk5HdTIGAMaEzzl8CIOlPVcgBRlGf3+tlzT/xeYlrZCwS/8zQOTW57EkGmw2IXAoeQj9rPDGMgizIYloeAjog/BuwO8eHD8k1ss0DvObVHOG2QeEvWdHQSQ30NUF5E01ddexoCf0h3uOK6rGIz7BNBIv6GJQuduNtQiH//Ds7BSxFXzq7kALTxpbLRQnS2YvjFJ1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3448.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(8676002)(4326008)(66446008)(5660300002)(4001150100001)(478600001)(91956017)(66556008)(2906002)(54906003)(76116006)(6486002)(66476007)(6512007)(83380400001)(110136005)(26005)(2616005)(66946007)(316002)(6506007)(86362001)(8936002)(4744005)(71200400001)(186003)(36756003)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: yz+tSmGmEat0oWYZSGC2++fzU3fmyhQVmLZWG8P5fLe6KrvRHL8FBN46fGzFIb2K4Q7NP6xqEwfpR2FKWqWOVisYr8TGYzH2qZN36Inqiqx+rVV/kvejdFoavBlvq08Em9XjSpKOK9OQ/sz+pMTmiK+dLyNdNJpN7B5yBluVEKhA1EfgjpfV0YGhl/Y53lisrhPEDT1n4NhpNv/qRaF2FbmzBlxLs7+bpgQ0FkdOFOC2+AGJjXL2kbAhqJBTaZwgeMmCCLXHIC88FpAlTb8PJD7MN2QRdlrRUY8lINT/ZEf7W6JWInN/lL01xcZ32h/P65Z/cTUVVNv+EsGVRPy6wC+wBy+B+kwvtsdp79k3hK2zJ/SOv/8tGUG/ZiMSXpQbT8tEQ85CwS2InbhJhkBZcKq7HShP8K4V0/vzrss73Y1LgLOZkZZ95oQpf+QlXLn21NDS6WLs1KT2wZusfP830K3HATuild4sEQR4ZtzK5noSavFeU2U0xcdTuHqWMGvElkizSH7gf9NT+wBmC6HduUBmgDd3QvOlWT+xiRRqDEwZn70jEgijid3u3jyLgl0miFTnlFBFG1LwUgIOa9iARge3RJWmwlc5x0JV/NwP2udZ30XG8C+cx770x7hStSxSG+wRU7cW/NwMQtTU2ckjxg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <E75A7414F932FA428C81498A80A389C9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3448.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf0036e-3cca-477c-8ec8-08d87a9ac4e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2020 17:07:21.8107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bGdyxBUDB1J7awHSifxa8zXDUzvZk85eeonLdzt94ujO8Xhv/iDUHPYtq99KDplEmYYN5awmPjtXTXmIEu435fsqLrxNazbxpnGvjQUPxQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3477
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

T24gVHVlLCAyMDIwLTEwLTI3IGF0IDIxOjQ5ICswODAwLCBaaGFuZyBRaWxvbmcgd3JvdGU6DQo+
IEluaXRpYWwgdmFsdWUgb2YgcmMgaXMgJy1FTlhJTycsIGFuZCB3ZSBzaG91bGQNCj4gdXNlIHRo
ZSBpbml0aWFsIHZhbHVlIHRvIGNoZWNrIGl0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogWmhhbmcg
UWlsb25nIDx6aGFuZ3FpbG9uZzNAaHVhd2VpLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2FjcGkv
bmZpdC9jb3JlLmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkNCg0KTG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBWaXNoYWwgVmVybWEgPHZp
c2hhbC5sLnZlcm1hQGludGVsLmNvbT4NCg0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNw
aS9uZml0L2NvcmUuYyBiL2RyaXZlcnMvYWNwaS9uZml0L2NvcmUuYw0KPiBpbmRleCA3NTYyMjc4
MzdiM2IuLjNhM2MyMDllZDNkMyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9hY3BpL25maXQvY29y
ZS5jDQo+ICsrKyBiL2RyaXZlcnMvYWNwaS9uZml0L2NvcmUuYw0KPiBAQCAtMTU2NCw3ICsxNTY0
LDcgQEAgc3RhdGljIHNzaXplX3QgZm9ybWF0MV9zaG93KHN0cnVjdCBkZXZpY2UgKmRldiwNCj4g
IAkJCQkJbGUxNl90b19jcHUobmZpdF9kY3ItPmRjci0+Y29kZSkpOw0KPiAgCQkJYnJlYWs7DQo+
ICAJCX0NCj4gLQkJaWYgKHJjICE9IEVOWElPKQ0KPiArCQlpZiAocmMgIT0gLUVOWElPKQ0KPiAg
CQkJYnJlYWs7DQo+ICAJfQ0KPiAgCW11dGV4X3VubG9jaygmYWNwaV9kZXNjLT5pbml0X211dGV4
KTsNCg0K
