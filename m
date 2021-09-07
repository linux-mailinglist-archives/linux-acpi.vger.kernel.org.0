Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89DEC402B8B
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Sep 2021 17:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345087AbhIGPRi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 Sep 2021 11:17:38 -0400
Received: from mga04.intel.com ([192.55.52.120]:41192 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344938AbhIGPRh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 7 Sep 2021 11:17:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10099"; a="218363300"
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="218363300"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2021 08:16:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="546918515"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 07 Sep 2021 08:16:27 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 7 Sep 2021 08:16:27 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 7 Sep 2021 08:16:27 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Tue, 7 Sep 2021 08:16:27 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Tue, 7 Sep 2021 08:16:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVxw4C1xA10UN/io0BlN0hOnc2z5uQqRlSjjKtfVv2bFlmVzOkLRTlMd/UpzaVlA0REzwg4qtw3Xjqk/jtOznUMh4imVGWEL3IaT5mqWIYjBxqhFsMLIWVlJVOdp6ddZ2bIm9Dxztqd3ykPMxqfkQiKbnTZodsAfODYq/ag8QIv97HGI4tEqoIMCXxRRnsqHq/LkOA4kN3Zau+lr8qlmmd4rHTrO5RsKi+3XeCDnFCUP4YBkkxF4ZReSmlE3gNRUPW/PLe4XWtX1O+6NVOPgd3kN8lmcMFjV6BmYlBwpwvY6+OVL6gkaPY8qW32WqYkMswBS410TwewAWR6xpcgAPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=UqZnjDjOpCJvukimXQ7MnPIII2rVRD9Zd/sx6wQUIxQ=;
 b=nqewMaROvz6KCcJM9vb6ggYrF9n5LlkpEttgJGRhIXvfwicJntcj6b2d3fT9XLANCiJ1U39XvtCcXpSprYy1b29fh4buXh27P4wmADpV5+JVBefgE8Ym1YnD8IZHd1YDc5d3VMZ9zY7Xs7dSMBT7AOO1/vnH/m7bQtKQ/mE/wTyGpaXJs3C1nCY4W2/xP1bz/aHfSNZgynMzn45Q+uabFOwnGbq8EaE3HFt8V/bW8Z1QbnxnTUqZfPyGA4HH1Sk8vX14xKlAcTsUBqMM/kaFq2WGWyrNwbld0rISC3WpIbYJPHP14JMAL+A2MJsJNleLGdr1Zd0rK9RSnT9JRhwoeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqZnjDjOpCJvukimXQ7MnPIII2rVRD9Zd/sx6wQUIxQ=;
 b=dr19D+Y15+qv+qvzZ+5mnAm65452XXsmnr1nejElMYN5GtovM0WaPWyN60oQJSXycvAvkDK44PMX8LBr/nSloS+hnaAeO5wF253KDz7f+vIdt2bPzxgHPwS3BnZrq1MdcgIcgHS1/FWFPLBVolvTvBmCyouBsj8w230gpnpTVus=
Received: from BYAPR11MB3256.namprd11.prod.outlook.com (2603:10b6:a03:76::19)
 by SJ0PR11MB5039.namprd11.prod.outlook.com (2603:10b6:a03:2da::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.25; Tue, 7 Sep
 2021 15:16:23 +0000
Received: from BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::70c4:1ab7:9eb4:f94a]) by BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::70c4:1ab7:9eb4:f94a%4]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 15:16:23 +0000
From:   "Moore, Robert" <robert.moore@intel.com>
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>
Subject: RE: Question about acpi_remove_address_space_handler() behavior if
 handler is running
Thread-Topic: Question about acpi_remove_address_space_handler() behavior if
 handler is running
Thread-Index: AQHXoavYBoFTQUvqQkOWf0rmhSCgfauYsagA
Date:   Tue, 7 Sep 2021 15:16:23 +0000
Message-ID: <BYAPR11MB32561D19A0FD9AB93E2B1E5287D39@BYAPR11MB3256.namprd11.prod.outlook.com>
References: <57a2a9fa-e296-85dc-75f8-94ccd0527204@gmail.com>
In-Reply-To: <57a2a9fa-e296-85dc-75f8-94ccd0527204@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24e67eba-4978-46b7-c5fa-08d972127472
x-ms-traffictypediagnostic: SJ0PR11MB5039:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB5039199B2D117DA56958220F87D39@SJ0PR11MB5039.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fwY5wKa8Hlmegrcfi6FtVI5cBtwH9VfRxV+6VlT1VUmtzPNEJ7VeTlFe+YYY6RkkysE9Z/3YrV9q3ev7xX68TLF4vksPq//2hkWSclVGilqiGKAwG4mNo/sCm4vXQs6MclD/smaKI58m3Mam/5bAIHuLUzWF9vrrUBjCrFkOGK5QQWmiSBaFZNlVvw0FamFWpNEa6gCMQJ0Vz3ChtYMTDFSLtE3tiUOWjaUyds6XDQFBo8j4YfHiRSgHAIq1oMeIsHso0k5enp/lY4XsBO7EXq1lakCdavXOci8gUWRqiGzswtaaEDsV6yzbxYf0B3PjTkhcHCWwcqZ/wWHi0K5ZTAGMbCPELxBgLRXZszy/eAre/uFfhCv4+ggtAejo0p1U0QUgR4hmjxwd/sxiVQphBJqhpLz0EjBe4lHoQfLUK8FeRt+poaM4V0Ogb3uLM+v7R9iJthxnB4Bp95yN+AJrYlWhO4ov/LLaVtZoqWkuy7NzhEuUnmZpEaFCrxxcIx8kcw6GAgZ+MLhfSuKG8reHnKpiu0wY2rv0kGkhB/fyeagd4K8jte/JuduUH0gFg7VrMP9b3dL4j6VFD/v8bZTrlDQx3qiSoExfglF83jrycJWRUgKCZAhIJ3+Th+2X9d+ZQZbAThJfNttFS0/PK5WSnazi/RaxEKc9d31K9vBLfJ/8IYGbP7cpk9Us/KnMyy9lbl+B8SRIyrSVlu/7aY2bi9GaDTul6tVh26sJQBEiI0w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3256.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(396003)(39860400002)(346002)(83380400001)(55016002)(66446008)(9686003)(52536014)(186003)(6636002)(64756008)(5660300002)(4744005)(26005)(76116006)(66946007)(66556008)(66476007)(38070700005)(86362001)(53546011)(6506007)(2906002)(110136005)(478600001)(4326008)(7696005)(8936002)(122000001)(38100700002)(33656002)(8676002)(316002)(71200400001)(54906003)(60764002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTZkTEZTUzJiM2Z6U2NRVG1FZnhFYzBsSk1vK0ZvQytzUzM2b2h3YmhpQyta?=
 =?utf-8?B?MnFhUmFjbWY2emRvRGR4RUhXSG1GdXVYVmFYSTV3NW92ZVlpY3dtRzZNWnVm?=
 =?utf-8?B?YkhXTE1ZWEZRdEkyS3V4YnEwbGQzRFRoUnFYN3dHbXNMbUhNdFFUNm12VENh?=
 =?utf-8?B?QjlVcm02cmI0UW5VN2pXVWR6TU53bDdocjdhT2J4TFNSaG9iVWhWUUIzcWU0?=
 =?utf-8?B?OEYzdXI1anl2S1dIK25aVVJUNmduTEJWTGdRZ3pUT1JzWE9wbVhIRlNTdkNh?=
 =?utf-8?B?dklOUW5iREdSTFQzcHY3eERrWlEvUTdkOWJhNVBWVVVWQmFVOGdXeEFkS0FW?=
 =?utf-8?B?c2xpYmszbFVkdk5XcWxmeEJDY2JqMzZxNWhZV3hiN0x6cVFsRFQyTmpnRXM5?=
 =?utf-8?B?UFUzSE5ZU3lONFc5N0hHc1NMNjF1c0xQRm1mbUlIQmlkZDFjVFBDYWlqYi92?=
 =?utf-8?B?a1FMYzQ0a0NDT2NjaGpDSEN1ZXU4OTlUYjVuZm5TaFIwSHA4eVBBanVwMVlY?=
 =?utf-8?B?WHBadk04WXNoYVlORW9DdGl2WHNVQ0twN0xxYUlSZVF4NElGblc3aWNyT0pX?=
 =?utf-8?B?bDZQOXkvMlNGM3RaL2hvL2tXMkFEd2lvV1o3dUNDN2dRRGxVZkNYYVJkT245?=
 =?utf-8?B?eGdKc1JIV1grQ29MdTdXSmFCbHp2UkhzbjRFa3JDWjlsQ3ZlR2J1dVU3czh4?=
 =?utf-8?B?VkdQYUE3OEFxb1RIOXR1MTE5TWlmWWpFRkk3V01JZFFZNWxyaVNOSjRKUVNP?=
 =?utf-8?B?REh3WjBUUCsvcmErU1lyQ3Bsd1cwUjJ4WVlPTHZjY0s0bHEydUdoT1JKLzlI?=
 =?utf-8?B?Y0hlTDRXMW9GeUhwRkpmMStyRHJaQVc2Qy9IUmZIdytpaG1JM1pIRVRHSkFD?=
 =?utf-8?B?eWVTenhKNk9rWmQxODgyTjE0T2tiZ3huZmFiNmdUdER1RG1kQ1gvazdvUVhk?=
 =?utf-8?B?YnkvbkYvK0lKSFFJejhwd2N6K2RxRXE2L0RraUs3TjNQdk5FTUNEaGx5TjNx?=
 =?utf-8?B?SGdwWXpBQ1hzNnNxUWF6L0NmYXJxY2I1Snh3d2pVTWo0NjVqTEx1eko1Y1pN?=
 =?utf-8?B?Mml5VDcvdE1zY0o1clRabTcwd0NjczlOMjNUOEVic05DL2hKVVFPaDhxSml3?=
 =?utf-8?B?bndsb2dZb09NcmNoUk8vMDgxejIvNWQyYzRTdGdvRzlZYm1pQVFDSkFEYWEx?=
 =?utf-8?B?NHNtSUdwWkM1QnJuL2hHc04yVFNCSDROSUVMaHFabHpBYVhKQXZjTFcwZFlt?=
 =?utf-8?B?YllJK0FINTlwQVBVZVl6T1JZdjZ2K0g1WlhZbGdkLzJKRmJKbUlEcExuYm9t?=
 =?utf-8?B?V3Jsajlsck9QNU1EVHkzUlU5N0Y2YUdpM0gxZkFIcE4vb0pZQ09YNGdiM2h2?=
 =?utf-8?B?cndrU0U2aGNIOXQvVWc5ZUJmUnBuZ3dldklDUS9yL0tYeGZvQTlXR0ZxZGd0?=
 =?utf-8?B?NkZVWTB5eFg2QzRxOVRpNUVmYlovUGQ5N1QrSENPL1RwckJkTE1NNGFuOU4x?=
 =?utf-8?B?NEw3b0JnalFIRUNzeHZRWHJrM3RxU2xDMkQ1OXNPMU1QK3dyRjRtdUFYdXc0?=
 =?utf-8?B?d3BvdFNIUTI3YmUzRkhEZVVZQjRsQnRNMzJ3OHcrNE1lTWhtd09WSVFzVmpL?=
 =?utf-8?B?cktkUFBTSU5yT01mbEVIRUV6WjRRMFhibnNEM1YwbTJzdzlmbUN6WG9FTUZS?=
 =?utf-8?B?d3Q1am5QYUtDRTRFaytUNktnTFZiQTIyVGVMdWN5R2tIRlZ4ZzJzUGphd2JT?=
 =?utf-8?Q?ycgBdWRPsNlR9Lo8VuhMUcC7zsD4SjZqA2qnsT7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3256.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e67eba-4978-46b7-c5fa-08d972127472
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2021 15:16:23.6243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uf4CrX5q78y2LjQodr/DVLdzuj16k2kUCdHpQJKf1Yg7h4iBPjhIqbr5EQA8rcamwDwBPUQckCMMfKuHNHo9lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5039
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

WWVzLCBJIHRoaW5rIGl0IGlzIGd1YXJhbnRlZWQgdGhhdCB0aGUgaGFuZGxlciBpcyBub3QgcnVu
bmluZzoNCg0KMSkgdGhlIG5hbWVzcGFjZSBpcyBsb2NrZWQgZHVyaW5nIHRoZSByZW1vdmFsLg0K
MikgRXZEZXRhY2hSZWdpb24gaXMgY2FsbGVkIHdoaWNoIHJ1bnMgdGhlIF9SRUcgbWV0aG9kIGlu
ZGljYXRpbmcgdGhhdCB0aGUgcmVnaW9uIGlzIG5vIGxvbmdlciBhdmFpbGFibGUuDQoNCi0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBIZWluZXIgS2FsbHdlaXQgPGhrYWxsd2VpdDFA
Z21haWwuY29tPiANClNlbnQ6IFNhdHVyZGF5LCBTZXB0ZW1iZXIgMDQsIDIwMjEgOTo0MiBBTQ0K
VG86IE1vb3JlLCBSb2JlcnQgPHJvYmVydC5tb29yZUBpbnRlbC5jb20+OyBFcmlrIEthbmVkYSA8
ZXJpay5rYW5lZGFAaW50ZWwuY29tPjsgV3lzb2NraSwgUmFmYWVsIEogPHJhZmFlbC5qLnd5c29j
a2lAaW50ZWwuY29tPg0KQ2M6IGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnOyBKZWFuIERlbHZh
cmUgPGpkZWx2YXJlQHN1c2UuY29tPg0KU3ViamVjdDogUXVlc3Rpb24gYWJvdXQgYWNwaV9yZW1v
dmVfYWRkcmVzc19zcGFjZV9oYW5kbGVyKCkgYmVoYXZpb3IgaWYgaGFuZGxlciBpcyBydW5uaW5n
DQoNCmk4MDEgaTJjIGRyaXZlciBpbnN0YWxscyBhbiBvd24gQUNQSSBpbyBoYW5kbGVyLiBXaGVu
IGRpc2N1c3Npbmcgc29tZSBkcml2ZXIgaW1wcm92ZW1lbnRzIG9uZSBvcGVuIHF1ZXN0aW9uIGlz
IGFib3V0IGJlaGF2aW9yIG9mDQphY3BpX3JlbW92ZV9hZGRyZXNzX3NwYWNlX2hhbmRsZXIoKSBp
ZiB0aGUgaGFuZGxlciBpcyBjdXJyZW50bHkgcnVubmluZy4NCldpbGwgdGhlIGZ1bmN0aW9uIHdh
aXQgdW50aWwgaGFuZGxlciBpcyBmaW5pc2hlZD8gSW4gb3RoZXIgd29yZHMsIHRoZSBhY3R1YWwg
cXVlc3Rpb24gaXM6IEFyZSB3ZSBndWFyYW50ZWVkIHRoYXQgYWZ0ZXIgdGhlIGNhbGwgdG8NCmFj
cGlfcmVtb3ZlX2FkZHJlc3Nfc3BhY2VfaGFuZGxlcigpIHRoZSBoYW5kbGVyIGNhbid0IGJlIHJ1
bm5pbmc/DQo=
