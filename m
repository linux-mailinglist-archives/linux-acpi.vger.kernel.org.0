Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8BE345227
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Mar 2021 22:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhCVV6I (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 Mar 2021 17:58:08 -0400
Received: from mga09.intel.com ([134.134.136.24]:11591 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230016AbhCVV6B (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 22 Mar 2021 17:58:01 -0400
IronPort-SDR: JQ1A3DObbuDoIor0tKrC4OZ6SlvHkl02LYHTSrbxejhwp/MgV8TSTjVMZtp4uTM2NqdM4AJOsX
 icyfnpRMawrg==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="190450419"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="190450419"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 14:58:00 -0700
IronPort-SDR: o23FJf0azAakSji4HPKSNhRtJTf5f6rcqJ9JN3WxEY6mtQjG3b7xRivuotMtZQ5THxCzZ0G3FX
 0ICq/mjLMzJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="435306889"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 22 Mar 2021 14:58:00 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 22 Mar 2021 14:57:59 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Mon, 22 Mar 2021 14:57:59 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Mon, 22 Mar 2021 14:57:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SuGWaFzR69/Cd1kGwep/l0pTfOwpGBhZ09OhccfddrL8v2gEDPuW7/0PtLeolqRml4VJUl5/HNusSy62OVdXySrm/m7SJA9h0ieSwUniSCZtLODFnGRgCCwWC0vVyikH4YTkGwvvDhxjRkYv9R0Q1EOGLZs+uFv9pnaenOu/lFLmy6ZAx+0hSELemn08ds9Io61D9ANGawLI+9WYZRrtqtLsHTQNlyXRe3h5pLzrQIlieFEe/zl0jJzjeWxGt25wYFus6NlTEP2a5JnNJN1UgCFUnn7sSNz9hP0iiqCzeFqst5vYk5+MPQOvYT+DFqyLiFUJl74x/hJ9O10otl+pLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQwMQTJpFs+SbA/4PyNqZt9JWvE4yNlstMJOMb+1kA0=;
 b=VNOTCh2SRm/ihVbaYivLppkH3s+9r8/Bi5seiNxMGCH3gPv/RT14Zm5VUXy6UQo5GtayECZGi3WqFClvwY8FQzgpJVx6f0sW4eQLjsLzAfKjJVwUGR3pOzkCSBog4DltnzFYE2/4ARMinZlHwZK8ZexR7f9cMtKLSIHHAEwIgy8PB/9V1osqdxKGF7Ja6V6dGtQ8Pz3AckobUekf6snT6d+dUgZ/uFLluM23ABnhWqGVGg2GPlG4hHWZ5xffzO1hkIaOlPcT0THNe0aabigDbh9EYHDNDcCA2b2ftZzQi+WQfOWOUjpWzdAcTsrnhhjSGK+DUPrc6BQ6yr2QTqTQ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQwMQTJpFs+SbA/4PyNqZt9JWvE4yNlstMJOMb+1kA0=;
 b=eNWDpA8HKYuNFhBtA5UQWPHDpokwcS7G/MBy1hzAt5+w5vNVWFEpl80npSw/498zKDleqWu1n0Z5xYD8paf/IP5KF47D52W8vzLEWeUvYeEQkfdCA8E9XglGe8HyczlkfRXMIPW4WLDMFwjoooCdT3twKvMRjH8G3ZHI+JHOmeI=
Received: from MWHPR11MB1599.namprd11.prod.outlook.com (2603:10b6:301:e::16)
 by MWHPR11MB1567.namprd11.prod.outlook.com (2603:10b6:301:d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 21:57:58 +0000
Received: from MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::b874:3c43:9abe:d35e]) by MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::b874:3c43:9abe:d35e%5]) with mapi id 15.20.3955.027; Mon, 22 Mar 2021
 21:57:58 +0000
From:   "Kaneda, Erik" <erik.kaneda@intel.com>
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "devel@acpica.org" <devel@acpica.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Moore, Robert" <robert.moore@intel.com>
CC:     Linuxarm <linuxarm@huawei.com>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>
Subject: RE: [RFC PATCH v2 1/8] ACPICA: IORT: Update for revision E
Thread-Topic: [RFC PATCH v2 1/8] ACPICA: IORT: Update for revision E
Thread-Index: AQHXHwc4z+izlmn+GkWYqA4mAb6Fp6qQh6Kg
Date:   Mon, 22 Mar 2021 21:57:58 +0000
Message-ID: <MWHPR11MB1599238526CF0529394CD9D7F0659@MWHPR11MB1599.namprd11.prod.outlook.com>
References: <20201119121150.3316-1-shameerali.kolothum.thodi@huawei.com>
 <20201119121150.3316-2-shameerali.kolothum.thodi@huawei.com>
 <b7a2424941214b33803e34ba3e532440@huawei.com>
In-Reply-To: <b7a2424941214b33803e34ba3e532440@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [174.25.99.223]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b8cb1c8-e5f0-478a-4488-08d8ed7d8e43
x-ms-traffictypediagnostic: MWHPR11MB1567:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB156720352E693E134657E5F3F0659@MWHPR11MB1567.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sAIb49Ht4E4ls/6faeXVH8S1pbqmpTOrmOU5IJh22KaZNOLLLmdQLFyzdegUO2kHzBuylf0xPuZId/BcTGTshCMSyN0kWHICS7/v+zODX/Mh4pjx3jJALANmgDUDs49yUmjGhrUajLhDJ6NgKRSCyp39NKtzJNDAi+16Nf8Q7cqkpdqVjBSkwtKns9+i1rGGD6w0V+/TkpW3Bs13ByyP2meUmX8kgxn/VfKwWHZsxvCJKdQfFoYH5HhVUTa96J3ZCtBoCKGuhA/bH0nerzKxAnYjr/2x6EOKWUaWsuzs/9ZAsHb8pYewep+SvuJE4As3Gz3DTRf+hbuS0V8b35fLxRO2+MY4X+dUGAZS4cbKWTQnTkA+CqYXFNUj8D0uzZWSBwL9oHVHZ0JEk6apyD6sprN4YLLhthOtJOpF+xUhr4GLxudBiqohF17sj1sOjyksIg4TH4Az1Om5mQNxwLPDf4mp7yQbaKdQ6iS20EeETUIBpVleQ0s7DfhaYsISUnnaocToa8kvl8M0NXpcf1+Cip99Wkn2ESH/tAp47sUP2fggNeWIeH/lhxQx9swSxuuopEMKyf6fEuXCjOT6tiN4WUgxuxMQabcQ1ESdjyePCCw09ocm1nPLQhazpUvL7F30fpCaqaCItge3faZzEYmkF4+E7/D/9p9zePVqxxW3dmf6lfMGyYXmGP/qoVh/NaQDxGek0pXu9JNfcfArRiInntZdOzi9ulcbqAaOZRcL38MiL4LFIaR3tXhBb2E9yGwS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1599.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(136003)(39860400002)(396003)(66446008)(66556008)(66946007)(316002)(76116006)(8676002)(110136005)(83380400001)(54906003)(8936002)(86362001)(66476007)(64756008)(33656002)(15650500001)(2906002)(26005)(53546011)(6506007)(5660300002)(71200400001)(478600001)(966005)(4326008)(6636002)(55016002)(7416002)(52536014)(186003)(38100700001)(7696005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?NFhBK1dBS2o1cVMySTQrNGN2ZUpDbnF2L1c1R2N1b3dybFV1djdHVkhNNS9h?=
 =?utf-8?B?MFpQUmlNYnNtWGVnK3RKN0c3V3JYaitMZVZiVkxpeFlzK2NEd2hqYXFZcGZh?=
 =?utf-8?B?V3ZlR3JxT2FmKzN6dGpIaFBERHRDSUc2ZjBXT1lNV0pFcGs3SnRGYjFia3BN?=
 =?utf-8?B?aVE1ZHNIdFZRZ3RFRWFGV1dsV3ZUU29jZjd0WFFyazVUU0pUVi9aRnliS3VK?=
 =?utf-8?B?KzJHSWR3Sk96cTc0M2gwTjl6YnpvT2ZJdlBRdXZiMElEaHMzbmFmOGJkMm1H?=
 =?utf-8?B?RVB5NUVvdC9COXRlODBORitYSHVDWTU0U0dVSSsrUHNDTHNMS3Z3SWFnR1dF?=
 =?utf-8?B?eVR2Y2RwOVZjUmcxWTZMczVDd3JnOTlpRVErUUhmMXBLTWZCRVlhaFNNdFl2?=
 =?utf-8?B?ay9sSFNTb2lFYlRTWUUyblRJZHJ5c0hWRDVRaHhKUk12dG1CaksvZzhNQlZE?=
 =?utf-8?B?ZVdYM2QzSWlLR3gvdHRqd2pEVXZvUThRcjlnM2s2WU5qRFhTYmMyUWpOdUxl?=
 =?utf-8?B?K1A3cUdCKzFwRXo1aENWbTJaV3h6OFpGSDV5Y3lmelo2Wm9Rc1ViN01uWUI3?=
 =?utf-8?B?SlowY2N2SEtESUxKUTR3RzhSZlFuSU9iRk9SdkJoQnBoQXNuaFBETFdBRUJ2?=
 =?utf-8?B?L0s3WnpLY0kwZ3NXenlTVVpIVUdQZUhOc1FMdFc2WmlJZDhsQVY0a3RJb2N3?=
 =?utf-8?B?UXVCbjhGVmpGWFZiNmMwY0NGeGtOZ0N0SzVwWmx3NC81S04vVTJydlBhUkxT?=
 =?utf-8?B?UFFzL3NkTW11a21yckM4M0EyQkNRc0huVW0zcTlLMmhZcGN1OEx5Qm5aYTdG?=
 =?utf-8?B?NUR2YTlBS1NyUTlJWXJXbDBPTmg5ZXNLRlJTZ0xlNGkzNk8rTDV4djBwNmxv?=
 =?utf-8?B?RkxpalE2TnhQdEZIejVRb0lMS3ZhVWZ1OEVHYXgwQkVsenJtQkdQVHoyRjVx?=
 =?utf-8?B?MzVhVkJ6WjlBWmtFY2RRbXQrblhJdVZWSmJFSlBtUVF0VkprNXZBWGU0S1Rs?=
 =?utf-8?B?UDFyWnBKNUVjWWR3UFl3NldHaFN6aFcrZmRrYVlPTlB6RFRDRldVRUY3Z2xO?=
 =?utf-8?B?ZDZxY1RuTHNpTXA3MUZMdndkcTNmRUZyOXllTzlsMjB3QVA5SWhLeXVQRHph?=
 =?utf-8?B?RVI4WkYwcUQ1aktyM1V4eFc5ZXhUWEdjRFhZL1BxMldYZXpESlBEWWJ1YWNp?=
 =?utf-8?B?dXFwOTVnZ2sveU9vTFNKcVdlSDRiRWFsNWluMkJCU1p2UmhxY2YrZDlaei9m?=
 =?utf-8?B?cmNGVlUxMnh0eGI3ejNqQjlkNm5JbEo2VW94SnExcUhTaERyTXppdXRGSUcw?=
 =?utf-8?B?U0VldGdBQjFWNGZxbU9idDlBVlFaUXFsandCRzBzRDFNeUVySGcva3crVDdq?=
 =?utf-8?B?QkFPeEdkMGNZb05zM0x6UXVaaXd6V0JCU08rUUFoYzRiNU9lVXdRN28rdnFZ?=
 =?utf-8?B?cGptZ2dHdWdNem41azBkSE1TMjlaTWZxOHVOazFjUGhtNXA2S0FKYTZ6Mllq?=
 =?utf-8?B?SDdUSUpZWWxpVTg0WVFOYnNJVUhTVFljSldYckVXOS80ZDNkb2U3NzdwK0o2?=
 =?utf-8?B?YldDMXZqdFpGaGZXUmFDeGNibTRGY1J4ZzZ6elZteWRtSmV3S0ZobWRSWmtm?=
 =?utf-8?B?aXp5VzlZMUIybWVwV25SSXoxbUhpVEk4VU5pdm1NczdIV2xYMFNKUTBDVFlv?=
 =?utf-8?B?ZEZtWnZ0WE5Fa084eFFpOUh5YmwwTkxmWTkwM2ZtdmNBZDBROVlSZm5hRUtO?=
 =?utf-8?Q?Zz3KAUMFKTN6htelypylgjPaK05jme0PfxnU8gI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1599.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b8cb1c8-e5f0-478a-4488-08d8ed7d8e43
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2021 21:57:58.5463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3dBhBEZRzraddWR86fo9FdEdJeuyQusx8KKrJ1gMe8u2cP9cQLacalX01WE22b3PX9Rx9h3d5XdplNYo+zYx0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1567
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2hhbWVlcmFsaSBLb2xv
dGh1bSBUaG9kaQ0KPiA8c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29tPg0KPiBT
ZW50OiBNb25kYXksIE1hcmNoIDIyLCAyMDIxIDM6MzYgQU0NCj4gVG86IEthbmVkYSwgRXJpayA8
ZXJpay5rYW5lZGFAaW50ZWwuY29tPjsgbGludXgtYXJtLQ0KPiBrZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsgbGludXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmc7IGlvbW11QGxpc3RzLmxpbnV4LQ0K
PiBmb3VuZGF0aW9uLm9yZzsgZGV2ZWxAYWNwaWNhLm9yZzsgTG9yZW56byBQaWVyYWxpc2kNCj4g
PGxvcmVuem8ucGllcmFsaXNpQGFybS5jb20+OyBNb29yZSwgUm9iZXJ0IDxyb2JlcnQubW9vcmVA
aW50ZWwuY29tPg0KPiBDYzogTGludXhhcm0gPGxpbnV4YXJtQGh1YXdlaS5jb20+OyBzdGV2ZW4u
cHJpY2VAYXJtLmNvbTsNCj4gU2FtaS5NdWphd2FyQGFybS5jb207IHJvYmluLm11cnBoeUBhcm0u
Y29tOyB3YW5naHVpcWlhbmcNCj4gPHdhbmdodWlxaWFuZ0BodWF3ZWkuY29tPg0KPiBTdWJqZWN0
OiBbRGV2ZWxdIFJlOiBbUkZDIFBBVENIIHYyIDEvOF0gQUNQSUNBOiBJT1JUOiBVcGRhdGUgZm9y
IHJldmlzaW9uIEUNCj4gDQo+IFsrXQ0KPiANCj4gSGkgRXJpaywNCj4gDQo+IEFzIHRoaXMgaXMg
bm93IGp1c3QgbWVyZ2VkIGlubyBhY3BpY2EtbWFzdGVyIGFuZCBiYXNlZCBvbiB0aGUgZGlzY3Vz
c2lvbiB3ZQ0KPiBoYWQgaGVyZSwNCj4gDQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9hY3BpY2EvYWNw
aWNhL3B1bGwvNjM4DQo+IA0KPiBJIGhhZCBhIGRpc2N1c3Npb24gd2l0aCBBUk0gZm9sa3MoTG9y
ZW56bykgaW4gdGhlIGxpbmFyby1vcGVuLWRpc2N1c3Npb25zIGNhbGwNCj4gYW5kDQo+IGNhbiBj
b25maXJtIHRoYXQgdGhlIElPUlQgUmV2aXNpb24gRSBpcyBub3QgdGhlIGZpbmFsIHNwZWNpZmlj
YXRpb24gYW5kIGhhcw0KPiBzb21lIGlzc3Vlcw0KPiB3aGljaCBpcyBub3cgY29ycmVjdGVkIGlu
IHRoZSBsYXRlc3QgRS5iIHJldmlzaW9uWzFdLiBBbHNvIHRoZXJlIGFyZSBubyBjdXJyZW50DQo+
IHVzZXJzDQo+IGZvciB0aGUgUmV2IEUgYW5kIGl0IG1heSBub3QgYmUgYSBnb29kIGlkZWEgdG8g
cHVzaCB0aGlzIHZlcnNpb24gaW50byB0aGUgTGludXgNCj4ga2VybmVsDQo+IG9yIGVsc2V3aGVy
ZS4NCj4gDQo+IFNvIGNvdWxkIHlvdSBwbGVhc2UgcmV2ZXJ0IHRoZSBtZXJnZSBhbmQgSSBhbSBw
bGFubmluZyB0byB3b3JrIG9uIHRoZSBFLmINCj4gc29vbi4NCkhpLA0KDQo+IFBsZWFzZSBsZXQg
bWUga25vdyBpZiBJIG5lZWQgdG8gZXhwbGljaXRseSBzZW5kIGEgcmV2ZXJ0IHB1bGwgcmVxdWVz
dCBvciBub3QuDQoNClBsZWFzZSBzZW5kIGEgcmV2ZXJ0IHB1bGwgcmVxdWVzdCBhbmQgSSdsbCBy
ZW1lbWJlciB0byBub3Qgc3VibWl0IExpbnV4LWl6ZSB0aGUgSU9SVCBwYXRjaGVzLg0KDQpGcm9t
IGFsbCBvZiB0aGUgYWN0aXZpdHkgdGhhdCBJJ3ZlIHNlZW4gd2l0aCB0aGUgSU9SVCBzcGVjaWZp
Y2F0aW9uLCBpdCBsb29rcyBsaWtlIHRoaXMgdGFibGUgaXMgbm9udHJpdmlhbCB0byBkZXNpZ24g
YW5kIG1haW50YWluLiBUaGUgZGlmZmljdWx0eSBJIGhhdmUgd2l0aCB0aGUgdGFibGUgaXMgdGhh
dCBJIGRvIG5vdCB1bmRlcnN0YW5kIHdoaWNoIHRhYmxlIHJldmlzaW9ucyBhcmUgaW4gYWN0aXZl
IHVzZS4NCg0KU28gbXkgcXVlc3Rpb24gaXMgdGhpczogd2hpY2ggSU9SVCByZXZpc2lvbnMgYXJl
IGJlaW5nIGFjdGl2ZWx5IHVzZWQ/DQoNClRoYW5rcywNCkVyaWsNCj4gDQo+IFRoYW5rcywNCj4g
U2hhbWVlcg0KPiANCj4gMS4gaHR0cHM6Ly9kZXZlbG9wZXIuYXJtLmNvbS9kb2N1bWVudGF0aW9u
L2RlbjAwNDkvbGF0ZXN0Lw0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+
IEZyb206IGlvbW11IFttYWlsdG86aW9tbXUtYm91bmNlc0BsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZ10gT24NCj4gQmVoYWxmIE9mDQo+ID4gU2hhbWVlciBLb2xvdGh1bQ0KPiA+IFNlbnQ6IDE5
IE5vdmVtYmVyIDIwMjAgMTI6MTINCj4gPiBUbzogbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnOyBsaW51eC1hY3BpQHZnZXIua2VybmVsLm9yZzsNCj4gPiBpb21tdUBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZzsgZGV2ZWxAYWNwaWNhLm9yZw0KPiA+IENjOiBMaW51eGFybSA8
bGludXhhcm1AaHVhd2VpLmNvbT47IHN0ZXZlbi5wcmljZUBhcm0uY29tOw0KPiBHdW9oYW5qdW4N
Cj4gPiAoSGFuanVuIEd1bykgPGd1b2hhbmp1bkBodWF3ZWkuY29tPjsgU2FtaS5NdWphd2FyQGFy
bS5jb207DQo+ID4gcm9iaW4ubXVycGh5QGFybS5jb207IHdhbmdodWlxaWFuZyA8d2FuZ2h1aXFp
YW5nQGh1YXdlaS5jb20+DQo+ID4gU3ViamVjdDogW1JGQyBQQVRDSCB2MiAxLzhdIEFDUElDQTog
SU9SVDogVXBkYXRlIGZvciByZXZpc2lvbiBFDQo+ID4NCj4gPiBJT1JUIHJldmlzaW9uIEUgY29u
dGFpbnMgYSBmZXcgYWRkaXRpb25zIGxpa2UsDQo+ID4gwqAgwqAgLUFkZGVkIGFuIGlkZW50aWZp
ZXIgZmllbGQgaW4gdGhlIG5vZGUgZGVzY3JpcHRvcnMgdG8gYWlkIHRhYmxlDQo+ID4gwqAgwqAg
wqBjcm9zcy1yZWZlcmVuY2luZy4NCj4gPiDCoCDCoCAtSW50cm9kdWNlZCB0aGUgUmVzZXJ2ZWQg
TWVtb3J5IFJhbmdlKFJNUikgbm9kZS4gVGhpcyBpcyB1c2VkDQo+ID4gIMKgIMKgIHRvIGRlc2Ny
aWJlIG1lbW9yeSByYW5nZXMgdGhhdCBhcmUgdXNlZCBieSBlbmRwb2ludHMgYW5kIHJlcXVpcmVz
DQo+ID4gIMKgIMKgIGEgdW5pdHkgbWFwcGluZyBpbiBTTU1VLg0KPiA+ICAgICAtSW50cm9kdWNl
ZCBhIGZsYWcgaW4gdGhlIFJDIG5vZGUgdG8gZXhwcmVzcyBzdXBwb3J0IGZvciBQUkkuDQo+ID4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGFtZWVyIEtvbG90aHVtDQo+IDxzaGFtZWVyYWxpLmtvbG90
aHVtLnRob2RpQGh1YXdlaS5jb20+DQo+ID4gLS0tDQo+ID4gIGluY2x1ZGUvYWNwaS9hY3RibDIu
aCB8IDI1ICsrKysrKysrKysrKysrKysrKystLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE5
IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9hY3BpL2FjdGJsMi5oIGIvaW5jbHVkZS9hY3BpL2FjdGJsMi5oIGluZGV4DQo+ID4gZWM2
Njc3OWNiMTkzLi4yNzRmY2U3YjVjMDEgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9hY3BpL2Fj
dGJsMi5oDQo+ID4gKysrIGIvaW5jbHVkZS9hY3BpL2FjdGJsMi5oDQo+ID4gQEAgLTY4LDcgKzY4
LDcgQEANCj4gPiAgICogSU9SVCAtIElPIFJlbWFwcGluZyBUYWJsZQ0KPiA+ICAgKg0KPiA+ICAg
KiBDb25mb3JtcyB0byAiSU8gUmVtYXBwaW5nIFRhYmxlIFN5c3RlbSBTb2Z0d2FyZSBvbiBBUk0g
UGxhdGZvcm1zIiwNCj4gPiAtICogRG9jdW1lbnQgbnVtYmVyOiBBUk0gREVOIDAwNDlELCBNYXJj
aCAyMDE4DQo+ID4gKyAqIERvY3VtZW50IG51bWJlcjogQVJNIERFTiAwMDQ5RSwgSnVuZSAyMDIw
DQo+ID4gICAqDQo+ID4NCj4gPg0KPiAqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqDQo+ICoqKioqKg0KPiA+ICoqKioqKioqKioqKioqLw0K
PiA+DQo+ID4gQEAgLTg2LDcgKzg2LDggQEAgc3RydWN0IGFjcGlfaW9ydF9ub2RlIHsNCj4gPiAg
CXU4IHR5cGU7DQo+ID4gIAl1MTYgbGVuZ3RoOw0KPiA+ICAJdTggcmV2aXNpb247DQo+ID4gLQl1
MzIgcmVzZXJ2ZWQ7DQo+ID4gKwl1MTYgcmVzZXJ2ZWQ7DQo+ID4gKwl1MTYgaWRlbnRpZmllcjsN
Cj4gPiAgCXUzMiBtYXBwaW5nX2NvdW50Ow0KPiA+ICAJdTMyIG1hcHBpbmdfb2Zmc2V0Ow0KPiA+
ICAJY2hhciBub2RlX2RhdGFbMV07DQo+ID4gQEAgLTEwMCw3ICsxMDEsOCBAQCBlbnVtIGFjcGlf
aW9ydF9ub2RlX3R5cGUgew0KPiA+ICAJQUNQSV9JT1JUX05PREVfUENJX1JPT1RfQ09NUExFWCA9
IDB4MDIsDQo+ID4gIAlBQ1BJX0lPUlRfTk9ERV9TTU1VID0gMHgwMywNCj4gPiAgCUFDUElfSU9S
VF9OT0RFX1NNTVVfVjMgPSAweDA0LA0KPiA+IC0JQUNQSV9JT1JUX05PREVfUE1DRyA9IDB4MDUN
Cj4gPiArCUFDUElfSU9SVF9OT0RFX1BNQ0cgPSAweDA1LA0KPiA+ICsJQUNQSV9JT1JUX05PREVf
Uk1SID0gMHgwNiwNCj4gPiAgfTsNCj4gPg0KPiA+ICBzdHJ1Y3QgYWNwaV9pb3J0X2lkX21hcHBp
bmcgew0KPiA+IEBAIC0xNjcsMTAgKzE2OSwxMCBAQCBzdHJ1Y3QgYWNwaV9pb3J0X3Jvb3RfY29t
cGxleCB7DQo+ID4gIAl1OCByZXNlcnZlZFszXTsJCS8qIFJlc2VydmVkLCBtdXN0IGJlIHplcm8g
Ki8NCj4gPiAgfTsNCj4gPg0KPiA+IC0vKiBWYWx1ZXMgZm9yIGF0c19hdHRyaWJ1dGUgZmllbGQg
YWJvdmUgKi8NCj4gPiArLyogTWFza3MgZm9yIGF0c19hdHRyaWJ1dGUgZmllbGQgYWJvdmUgKi8N
Cj4gPg0KPiA+IC0jZGVmaW5lIEFDUElfSU9SVF9BVFNfU1VQUE9SVEVEICAgICAgICAgMHgwMDAw
MDAwMQkvKiBUaGUgcm9vdA0KPiA+IGNvbXBsZXggc3VwcG9ydHMgQVRTICovDQo+ID4gLSNkZWZp
bmUgQUNQSV9JT1JUX0FUU19VTlNVUFBPUlRFRCAgICAgICAweDAwMDAwMDAwCS8qIFRoZSByb290
DQo+ID4gY29tcGxleCBkb2Vzbid0IHN1cHBvcnQgQVRTICovDQo+ID4gKyNkZWZpbmUgQUNQSV9J
T1JUX0FUU19TVVBQT1JURUQgICAgICAgICAoMSkJLyogVGhlIHJvb3QgY29tcGxleA0KPiA+IHN1
cHBvcnRzIEFUUyAqLw0KPiA+ICsjZGVmaW5lIEFDUElfSU9SVF9QUklfU1VQUE9SVEVEICAgICAg
ICAgKDE8PDEpCS8qIFRoZSByb290IGNvbXBsZXgNCj4gPiBzdXBwb3J0cyBQUkkgKi8NCj4gPg0K
PiA+ICBzdHJ1Y3QgYWNwaV9pb3J0X3NtbXUgew0KPiA+ICAJdTY0IGJhc2VfYWRkcmVzczsJLyog
U01NVSBiYXNlIGFkZHJlc3MgKi8NCj4gPiBAQCAtMjQxLDYgKzI0MywxNyBAQCBzdHJ1Y3QgYWNw
aV9pb3J0X3BtY2cgew0KPiA+ICAJdTY0IHBhZ2UxX2Jhc2VfYWRkcmVzczsNCj4gPiAgfTsNCj4g
Pg0KPiA+ICtzdHJ1Y3QgYWNwaV9pb3J0X3JtciB7DQo+ID4gKwl1MzIgcm1yX2NvdW50Ow0KPiA+
ICsJdTMyIHJtcl9vZmZzZXQ7DQo+ID4gK307DQo+ID4gKw0KPiA+ICtzdHJ1Y3QgYWNwaV9pb3J0
X3Jtcl9kZXNjIHsNCj4gPiArCXU2NCBiYXNlX2FkZHJlc3M7DQo+ID4gKwl1NjQgbGVuZ3RoOw0K
PiA+ICsJdTMyIHJlc2VydmVkOw0KPiA+ICt9Ow0KPiA+ICsNCj4gPg0KPiA+DQo+IC8qKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqDQo+ICoq
KioqDQo+ID4gKioqKioqKioqKioqKioqKg0KPiA+ICAgKg0KPiA+ICAgKiBJVlJTIC0gSS9PIFZp
cnR1YWxpemF0aW9uIFJlcG9ydGluZyBTdHJ1Y3R1cmUNCj4gPiAtLQ0KPiA+IDIuMTcuMQ0KPiA+
DQo+ID4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4g
PiBpb21tdSBtYWlsaW5nIGxpc3QNCj4gPiBpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
Zw0KPiA+IGh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2lvbW11DQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
DQo+IERldmVsIG1haWxpbmcgbGlzdCAtLSBkZXZlbEBhY3BpY2Eub3JnDQo+IFRvIHVuc3Vic2Ny
aWJlIHNlbmQgYW4gZW1haWwgdG8gZGV2ZWwtbGVhdmVAYWNwaWNhLm9yZw0KPiAlKHdlYl9wYWdl
X3VybClzbGlzdGluZm8lKGNnaWV4dClzLyUoX2ludGVybmFsX25hbWUpcw0K
