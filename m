Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74104692E53
	for <lists+linux-acpi@lfdr.de>; Sat, 11 Feb 2023 05:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjBKEZ3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Feb 2023 23:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBKEZ2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Feb 2023 23:25:28 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DD6821B6;
        Fri, 10 Feb 2023 20:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676089526; x=1707625526;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AnKN2daaHaaWFuMwoe1D9+KaG/c5U7QazlY+lYf2rrc=;
  b=fifvr8JTz65ulQDfQv7j8IVgQij4AaNL53Zlvow75ojIHqBYN15oCUHB
   N3mzqLVx5wAgTXcd6MnSeO7NkjuZ/pB/JGjVk3yubAY+Idcxg3C5PZFmB
   HSHjP8RBa+YM5yQNhJGbDVoCvtn+jjBOTYvsPY20eZ35+Z9sbAub5z2+G
   kC+6orBCge/xhM6a5X2DvpImNkmSzzCk83q5fPBB7Ba1WCeNi4KC+5j3t
   cGiT17wL+N9SwOSeBaS6QNgwvpmL3FfBbpdRSTay/ODRrA5/J/GBScQa5
   bQDO9Njhi5oI93vGnJZP8DzAec+9SZyOuJrZSVNlK/bs5UIfOUyx660i6
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="310214092"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="310214092"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 20:25:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="700681760"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="700681760"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 10 Feb 2023 20:25:25 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 20:25:25 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 20:25:24 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 10 Feb 2023 20:25:24 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 10 Feb 2023 20:25:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLyv43HdS2ouG1zwDECImAgio54Kj9HoiXN92YYkCh/ImglVjwsT0HtwYv8mqYHVPMKaKScHy3mmx9DGGV37uz2dkxiYQzTymePKcx5tUBFkZqUO0SWrzzghlXVtyoru6rK9ulRk/B+TW3RPkYyxWbgFfr3z/fA+KIyowjljSCsOxg8oG/caTm/IYquDWCHpRwJU2x7vQAjt+b1tvvUEpMBSTg2n4P76bmB9p0Gqw8uHO9l7yUxOpZg/3Hxv8xXcKhr1l1DCyJMLq3QDnA05TkRyATIjazCUwO7i+WUNOQhj8gLBI8A571+MkLpr24m1yb5opK32ly8V5+08Xr3Epw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AnKN2daaHaaWFuMwoe1D9+KaG/c5U7QazlY+lYf2rrc=;
 b=WUjKGL+AQO+K2rRwzlglCf+fgI486nGT5jZpGmMwWzRre+aZC9ByGQAZ6/2mPlvmoUO2ul1Wyy1qVgCNT7KX94QtjHqL8qQ63WTtiTURe59SqdY2k/DUaxcH5lcxMsCbKkkNR40W5Hwr/9ohRiOdC4xaX0PuYerTQD8tnuWWGivuTABNu5+EHhihJgPUGi1uX31eGH/J23c7MCa22FasQ819NsWy6Hqr40InR0ClbX0RpJHIiKY7zITB4U+Rj7cntpyUDpVnZyF5RNJFUak9QjVLhuG35ii0+DwbydoAIywf+6uTDQh+IICJ1Byru3EiNDcgns+SuEKX6JdMb1z5jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by SA1PR11MB6896.namprd11.prod.outlook.com (2603:10b6:806:2bd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.21; Sat, 11 Feb
 2023 04:25:20 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::35af:d7a8:8484:627]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::35af:d7a8:8484:627%5]) with mapi id 15.20.6086.017; Sat, 11 Feb 2023
 04:25:20 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "fan.ni@samsung.com" <fan.ni@samsung.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2 17/20] dax/hmem: Convey the dax range via
 memregion_info()
Thread-Topic: [PATCH v2 17/20] dax/hmem: Convey the dax range via
 memregion_info()
Thread-Index: AQHZPS8RPrzdNxCjpUGnkRmKWIqfba7JJ1GA
Date:   Sat, 11 Feb 2023 04:25:19 +0000
Message-ID: <59b99a2c6594581e32da528da32483caed1b1da5.camel@intel.com>
References: <167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com>
         <167602002217.1924368.7036275892522551624.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <167602002217.1924368.7036275892522551624.stgit@dwillia2-xfh.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.3 (3.46.3-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB3999:EE_|SA1PR11MB6896:EE_
x-ms-office365-filtering-correlation-id: 8167b9de-4fcb-4948-53ce-08db0be7fbd9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +0fhFgxXu18oTgGYmpHSMtNotSDKmToiKqvBVlNzQpOoIOuRoVdA2qLNcypi9J93snHMpPMXXOZGD91OfH0PywLfvxin3dHZEIOF3VlfEvZLyd4RvWniNtYtJLXjufm8GRvIhIhuipIzRLnlII7p8sdp/kcIbxf9wmtbMU+4B4g7oi5oFmGSA0mc2RkRE8a29fDi54nxPeGWINWmkVq2yUN8G+pihlH/OFWzRk/zoY6dBzvpZgfv1CTJmFVGHDCLQg2gU+gxqRCkIIuSV1CNzIM8etZKH0x5njM6i0X0RUhTVrjExznEP/vlNFp72SBPskfgAC+nFTeNkt5orX9KH6henBaYyscYo/ZRKkjjPlWDGSJwIYdPdNIx7NtjfWrIN7oxfhoq9jArnuTlSQBEAIUwBGi+emuIeombgUh2TMnVnI3NUrYoF5OlPA2zVzEHi8oIcDVzhfQm/w3BDrlebMwBU4Wh+zAt8rF4ghoHoMCOudeSk9kzmSkNHgoLiOT4dJpLfGM5ANp729FtBrJdHp1BVhER8mG0QnUMXBNi50k/v/WQ29TcV2hslIuNCN7i8XpiohKD8CalyWYJmv3b5woO1erW7QENOBLaAfYioUpizRFc9yZ/PRTXTFF6GAuKJM92xTPKJiWpkOIDQmEKMMW/pYGkUBeVSzEYe6ShZk4Hwq6fvkmDDwkl2e+yAW6A6zqXYiz3680ukzC8SwMqagoHx8e5xAk6uZktd4yNRBs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(376002)(366004)(39860400002)(136003)(451199018)(86362001)(38070700005)(66556008)(8676002)(64756008)(66446008)(4326008)(66476007)(66946007)(76116006)(41300700001)(91956017)(5660300002)(8936002)(2906002)(36756003)(82960400001)(122000001)(38100700002)(6506007)(6512007)(316002)(186003)(71200400001)(26005)(966005)(54906003)(110136005)(478600001)(6486002)(2616005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXl1SEJKM0JyM2IvWGl1eEtZM0xNelFDemFLRjlldHlacXB5dU1nVUd2N0t0?=
 =?utf-8?B?NTFxdkdHajVRclJDRXM3OU96dU9STFBXMVRWUUVlb2hSay9SRDVlaXJRemk3?=
 =?utf-8?B?VlRkR3V4dWR3YjJOdnA5V3JPNGVEVUdINklKY2VYYzdRM3M0ajdIbkJHSlMw?=
 =?utf-8?B?ZzFNMlpqUHpSY3ZSV0VwdUU3SXNjbGE1eGdyTUd2NlJLQi9rTGZLeXl1R2wy?=
 =?utf-8?B?dXdOZ28wZkt2S0hUbVMwZTdHMWdSK1ZCT1NZTTZCazVhNW9BOFpuM0t6aWVz?=
 =?utf-8?B?VXUvOFVnK2cyelpsUzVhemcxSXdkVHJlRFNrcTE5c1oxQzdOcUYvQ3F4RTVB?=
 =?utf-8?B?SGN5UU1pTk5iV2lmZTB3OGdSdDNKYklKTFVpZWFGOGwremthSk1YOEZoM3Nl?=
 =?utf-8?B?SjdUVVFJcm1hYWxab3VOZWt5RUxHYkxSRWZTZWlHRHg2MWYvYjNVOGdZMEJt?=
 =?utf-8?B?dnlZOExlMmNVZFJ3ZlNEUUw3L2dPbnRyYU1aTnBoNVFyWTV0TkNpZ29VeDF1?=
 =?utf-8?B?TmR3MnlidjFCRHR0WDR0WTFyUkI0WVh5SXRQb05oN3JKWjdzZkpESGVLKzAy?=
 =?utf-8?B?dDJYVmxXZ3Y1em5aY1ZpQm14RkVuMGRsSm90bkFiVXBpSFVFUHBwQWhBd2pV?=
 =?utf-8?B?OW1IV3J3Z3NVT2pFbklzSXRIc0lhOG1kL0o3WlRpMSszZTBZOXc2N2piMEJO?=
 =?utf-8?B?OFU1ei9YTURkZElvbmhYSjN5TnVHbFNZU0NTbm1YaG5sWlBSbTFYYnpFd0Jm?=
 =?utf-8?B?QjgxWWtaS3prN1hmWHhJY1VFMEhEazdENzdFeDBzamlZK3VvQk83aHh0aWJ2?=
 =?utf-8?B?Wll5S2RtQzFmZlV1NDVrYUR3bFhzVkxNOTRhQXdjeUFpdkkxRGdVSUkzZFly?=
 =?utf-8?B?TUNKeEpPcE5YdmdrRUl5dHBhVk8wejJGUFF1UzFpNmcrbzd3RTVSZWlKOTIv?=
 =?utf-8?B?d1QzZHlZZzB5U28xQzBOYmZkZjZhOTRtNkU3QTZtcEFXcllJU25BR1MxY3FU?=
 =?utf-8?B?eUl1V1Q5T0JVWFhtWlJUYngrd1lYK25LZ1lpNlpZSjJLN2g5M2c1Vnc1RWw0?=
 =?utf-8?B?QkNVUFA0anZ4NTlvWHp0SzRWZlFBWGowN0xSenEveTlKekk3Y0dxSmVLOTJo?=
 =?utf-8?B?WWg0NUgwdm9oNmpwODhYaTRrWUxQK0pzd0tLZHFZOUFENmNHTTNtYi9qYTcv?=
 =?utf-8?B?Z2c2VVcwNm42ZGNJb0dNWFJnSldIK1oydUQvV09NdzRtMHZocGxUSlBDdW9M?=
 =?utf-8?B?NnBKY1BneXQxSUh3UURkcUdqbGxVYW5OVDZIM005WWsvV0swS1p5dUZySG5R?=
 =?utf-8?B?dkFlM01HY2Fxa2RXSmlZYUxIU05PTzZWTXVlKy9CaUZWYllSaFpCeFo1UUE3?=
 =?utf-8?B?Y2htSWVXTEFHU2R2M1EySWQ4MEVxeXlVK1dIdjZXejJwNkZUelR3SStYRHFI?=
 =?utf-8?B?RXdJc0FGUlpDYVdscjVTNG12dWJzWm11UFdqWVNtKzNlYjNreUVqZ2oyQmF5?=
 =?utf-8?B?UVE1TXp5dWNaMGVmVFlKUEVab011aC9MSVB3S0ljOWlseXRHK2RyYTFOSDd6?=
 =?utf-8?B?RStuWXRxK2RLQTNPWjRoa2M5ZGYza05wZ1NySElyb0xTNm93ZlFsUHFPN2lU?=
 =?utf-8?B?dStNVEtzYXd0bFF2NFRtdU5MazgxcWFyVUxzallHY2ZQdzdMZHlCVTZmSTZB?=
 =?utf-8?B?OWtaTkFoQXkrNVEvUm9ESjBtdUtmdmFJdDZWK0p6cjZ5V1VCbzBqVHRrSzcv?=
 =?utf-8?B?VG5lazY0UDBvcFpwZlhyQ25GTHptTDBZTmtlSWZLc1hQM1BvM1dVMEYvR0tU?=
 =?utf-8?B?dTZjUkxQOW9GLzkyaUV3eXc2TDNjNlJ3VXNoc0J1ZHVHREgveHFscGJMeFg3?=
 =?utf-8?B?T3RldG5nc05NVlpsZ1h0RlVxRDYxZkNXYzc5U3lHNG1welNZeW1icnpTWGQ0?=
 =?utf-8?B?a2dhVVhhb24wbUxKN1BxVG5zZExYYVZRLy84MTBzV3htZEczbEs2Tnk1OXBa?=
 =?utf-8?B?Y0lJeGowTERxTTl1ZFVzVUZ3dExuMGJsd2FQaGUrMFpmaEExVkRtcVBQcitP?=
 =?utf-8?B?dFI2RVdFNHVFMFMyNEUyOElUS0ZGT3lwVmVjOS8vWjBOQTJIdlRuTEhlMWJr?=
 =?utf-8?B?SUQzTjZLTzBoQXduOE50OXdZR2cwSmNzOVp2dkZKcVNrSmNaUm11cFJ0WEFV?=
 =?utf-8?B?VGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <712C24B4755C5948999A5C668631CD5D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8167b9de-4fcb-4948-53ce-08db0be7fbd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2023 04:25:19.3263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 03zscMGMVvEKt79yeeAs3b8mJz4MN1QoTzTCaTzGw+rhq9XjlCxZ2W2jIcH7h3GTklEa5sPS4JQ9dyApL+BazUAzlN8sq2MojETSQLRcMDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6896
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

T24gRnJpLCAyMDIzLTAyLTEwIGF0IDAxOjA3IC0wODAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6Cj4g
SW4gcHJlcGFyYXRpb24gZm9yIGhtZW0gcGxhdGZvcm0gZGV2aWNlcyB0byBiZSB1bnJlZ2lzdGVy
ZWQsIHN0b3AgdXNpbmcKPiBwbGF0Zm9ybV9kZXZpY2VfYWRkX3Jlc291cmNlcygpIHRvIGNvbnZl
eSB0aGUgYWRkcmVzcyByYW5nZS4gVGhlCj4gcGxhdGZvcm1fZGV2aWNlX2FkZF9yZXNvdXJjZXMo
KSBBUEkgY2F1c2VzIGFuIGV4aXN0aW5nICJTb2Z0IFJlc2VydmVkIgo+IGlvbWVtIHJlc291cmNl
IHRvIGJlIHJlLXBhcmVudGVkIHVuZGVyIGFuIGluc2VydGVkIHBsYXRmb3JtIGRldmljZQo+IHJl
c291cmNlLiBXaGVuIHRoYXQgcGxhdGZvcm0gZGV2aWNlIGlzIGRlbGV0ZWQgaXQgcmVtb3ZlcyB0
aGUgcGxhdGZvcm0KPiBkZXZpY2UgcmVzb3VyY2UgYW5kIGFsbCBjaGlsZHJlbi4KPiAKPiBJbnN0
ZWFkLCBpdCBpcyBzdWZmaWNpZW50IHRvIGNvbnZleSBqdXN0IHRoZSBhZGRyZXNzIHJhbmdlIGFu
ZCBsZXQKPiByZXF1ZXN0X21lbV9yZWdpb24oKSBpbnNlcnQgcmVzb3VyY2VzIHRvIGluZGljYXRl
IHRoZSBkZXZpY2VzIGFjdGl2ZSBpbgo+IHRoZSByYW5nZS4gVGhpcyBhbGxvd3MgdGhlICJTb2Z0
IFJlc2VydmVkIiByZXNvdXJjZSB0byBiZSByZS1lbnVtZXJhdGVkCj4gdXBvbiB0aGUgbmV4dCBw
cm9iZSBldmVudC4KPiAKPiBSZXZpZXdlZC1ieTogSm9uYXRoYW4gQ2FtZXJvbiA8Sm9uYXRoYW4u
Q2FtZXJvbkBodWF3ZWkuY29tPgo+IFRlc3RlZC1ieTogRmFuIE5pIDxmYW4ubmlAc2Ftc3VuZy5j
b20+Cj4gTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8xNjc1NjQ1NDMzMDMuODQ3MTQ2
LjExMDQ1ODk1MjEzMzE4NjQ4NDQxLnN0Z2l0QGR3aWxsaWEyLXhmaC5qZi5pbnRlbC5jb20KPiBT
aWduZWQtb2ZmLWJ5OiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4KPiAt
LS0KPiDCoGRyaXZlcnMvZGF4L2htZW0vZGV2aWNlLmMgfMKgwqAgMzcgKysrKysrKysrKysrKyst
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+IMKgZHJpdmVycy9kYXgvaG1lbS9obWVtLmPCoMKgIHzC
oMKgIDE0ICsrKy0tLS0tLS0tLS0tCj4gwqBpbmNsdWRlL2xpbnV4L21lbXJlZ2lvbi5oIHzCoMKg
wqAgMiArKwo+IMKgMyBmaWxlcyBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCAzNCBkZWxldGlv
bnMoLSkKCkxvb2tzIGdvb2QsCgpSZXZpZXdlZC1ieTogVmlzaGFsIFZlcm1hIDx2aXNoYWwubC52
ZXJtYUBpbnRlbC5jb20+Cgo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2RheC9obWVtL2Rldmlj
ZS5jIGIvZHJpdmVycy9kYXgvaG1lbS9kZXZpY2UuYwo+IGluZGV4IDIwNzQ5YzdmYWI4MS4uYjFi
MzM5YmNjZmU1IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZGF4L2htZW0vZGV2aWNlLmMKPiArKysg
Yi9kcml2ZXJzL2RheC9obWVtL2RldmljZS5jCj4gQEAgLTE1LDE1ICsxNSw4IEBAIHN0YXRpYyBz
dHJ1Y3QgcmVzb3VyY2UgaG1lbV9hY3RpdmUgPSB7Cj4gwqDCoMKgwqDCoMKgwqDCoC5mbGFncyA9
IElPUkVTT1VSQ0VfTUVNLAo+IMKgfTsKPiDCoAo+IC12b2lkIGhtZW1fcmVnaXN0ZXJfZGV2aWNl
KGludCB0YXJnZXRfbmlkLCBzdHJ1Y3QgcmVzb3VyY2UgKnIpCj4gK3ZvaWQgaG1lbV9yZWdpc3Rl
cl9kZXZpY2UoaW50IHRhcmdldF9uaWQsIHN0cnVjdCByZXNvdXJjZSAqcmVzKQo+IMKgewo+IC3C
oMKgwqDCoMKgwqDCoC8qIGRlZmluZSBhIGNsZWFuIC8gbm9uLWJ1c3kgcmVzb3VyY2UgZm9yIHRo
ZSBwbGF0Zm9ybSBkZXZpY2UgKi8KPiAtwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgcmVzb3VyY2UgcmVz
ID0gewo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAuc3RhcnQgPSByLT5zdGFydCwK
PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmVuZCA9IHItPmVuZCwKPiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmZsYWdzID0gSU9SRVNPVVJDRV9NRU0sCj4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5kZXNjID0gSU9SRVNfREVTQ19TT0ZUX1JFU0VSVkVE
LAo+IC3CoMKgwqDCoMKgwqDCoH07Cj4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXY7Cj4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBtZW1yZWdpb25faW5mbyBpbmZv
Owo+IMKgwqDCoMKgwqDCoMKgwqBpbnQgcmMsIGlkOwo+IEBAIC0zMSw1NSArMjQsNTMgQEAgdm9p
ZCBobWVtX3JlZ2lzdGVyX2RldmljZShpbnQgdGFyZ2V0X25pZCwgc3RydWN0IHJlc291cmNlICpy
KQo+IMKgwqDCoMKgwqDCoMKgwqBpZiAobm9obWVtKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgcmV0dXJuOwo+IMKgCj4gLcKgwqDCoMKgwqDCoMKgcmMgPSByZWdpb25faW50ZXJz
ZWN0cyhyZXMuc3RhcnQsIHJlc291cmNlX3NpemUoJnJlcyksIElPUkVTT1VSQ0VfTUVNLAo+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgSU9SRVNfREVTQ19T
T0ZUX1JFU0VSVkVEKTsKPiArwqDCoMKgwqDCoMKgwqByYyA9IHJlZ2lvbl9pbnRlcnNlY3RzKHJl
cy0+c3RhcnQsIHJlc291cmNlX3NpemUocmVzKSwgSU9SRVNPVVJDRV9NRU0sCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSU9SRVNf
REVTQ19TT0ZUX1JFU0VSVkVEKTsKPiDCoMKgwqDCoMKgwqDCoMKgaWYgKHJjICE9IFJFR0lPTl9J
TlRFUlNFQ1RTKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuOwo+IMKg
Cj4gwqDCoMKgwqDCoMKgwqDCoGlkID0gbWVtcmVnaW9uX2FsbG9jKEdGUF9LRVJORUwpOwo+IMKg
wqDCoMKgwqDCoMKgwqBpZiAoaWQgPCAwKSB7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoHByX2VycigibWVtcmVnaW9uIGFsbG9jYXRpb24gZmFpbHVyZSBmb3IgJXByXG4iLCAmcmVz
KTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcHJfZXJyKCJtZW1yZWdpb24gYWxs
b2NhdGlvbiBmYWlsdXJlIGZvciAlcHJcbiIsIHJlcyk7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqByZXR1cm47Cj4gwqDCoMKgwqDCoMKgwqDCoH0KPiDCoAo+IMKgwqDCoMKgwqDC
oMKgwqBwZGV2ID0gcGxhdGZvcm1fZGV2aWNlX2FsbG9jKCJobWVtIiwgaWQpOwo+IMKgwqDCoMKg
wqDCoMKgwqBpZiAoIXBkZXYpIHsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcHJf
ZXJyKCJobWVtIGRldmljZSBhbGxvY2F0aW9uIGZhaWx1cmUgZm9yICVwclxuIiwgJnJlcyk7Cj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHByX2VycigiaG1lbSBkZXZpY2UgYWxsb2Nh
dGlvbiBmYWlsdXJlIGZvciAlcHJcbiIsIHJlcyk7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBnb3RvIG91dF9wZGV2Owo+IMKgwqDCoMKgwqDCoMKgwqB9Cj4gwqAKPiAtwqDCoMKg
wqDCoMKgwqBpZiAoIV9fcmVxdWVzdF9yZWdpb24oJmhtZW1fYWN0aXZlLCByZXMuc3RhcnQsIHJl
c291cmNlX3NpemUoJnJlcyksCj4gK8KgwqDCoMKgwqDCoMKgaWYgKCFfX3JlcXVlc3RfcmVnaW9u
KCZobWVtX2FjdGl2ZSwgcmVzLT5zdGFydCwgcmVzb3VyY2Vfc2l6ZShyZXMpLAo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGV2X25h
bWUoJnBkZXYtPmRldiksIDApKSB7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRl
dl9kYmcoJnBkZXYtPmRldiwgImhtZW0gcmFuZ2UgJXByIGFscmVhZHkgYWN0aXZlXG4iLCAmcmVz
KTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGV2X2RiZygmcGRldi0+ZGV2LCAi
aG1lbSByYW5nZSAlcHIgYWxyZWFkeSBhY3RpdmVcbiIsIHJlcyk7Cj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBnb3RvIG91dF9hY3RpdmU7Cj4gwqDCoMKgwqDCoMKgwqDCoH0KPiDC
oAo+IMKgwqDCoMKgwqDCoMKgwqBwZGV2LT5kZXYubnVtYV9ub2RlID0gbnVtYV9tYXBfdG9fb25s
aW5lX25vZGUodGFyZ2V0X25pZCk7Cj4gwqDCoMKgwqDCoMKgwqDCoGluZm8gPSAoc3RydWN0IG1l
bXJlZ2lvbl9pbmZvKSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAudGFyZ2V0
X25vZGUgPSB0YXJnZXRfbmlkLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAucmFu
Z2UgPSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAu
c3RhcnQgPSByZXMtPnN0YXJ0LAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgLmVuZCA9IHJlcy0+ZW5kLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqB9LAo+IMKgwqDCoMKgwqDCoMKgwqB9Owo+IMKgwqDCoMKgwqDCoMKgwqByYyA9IHBsYXRm
b3JtX2RldmljZV9hZGRfZGF0YShwZGV2LCAmaW5mbywgc2l6ZW9mKGluZm8pKTsKPiDCoMKgwqDC
oMKgwqDCoMKgaWYgKHJjIDwgMCkgewo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBw
cl9lcnIoImhtZW0gbWVtcmVnaW9uX2luZm8gYWxsb2NhdGlvbiBmYWlsdXJlIGZvciAlcHJcbiIs
ICZyZXMpOwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIG91dF9yZXNvdXJj
ZTsKPiAtwqDCoMKgwqDCoMKgwqB9Cj4gLQo+IC3CoMKgwqDCoMKgwqDCoHJjID0gcGxhdGZvcm1f
ZGV2aWNlX2FkZF9yZXNvdXJjZXMocGRldiwgJnJlcywgMSk7Cj4gLcKgwqDCoMKgwqDCoMKgaWYg
KHJjIDwgMCkgewo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwcl9lcnIoImhtZW0g
cmVzb3VyY2UgYWxsb2NhdGlvbiBmYWlsdXJlIGZvciAlcHJcbiIsICZyZXMpOwo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwcl9lcnIoImhtZW0gbWVtcmVnaW9uX2luZm8gYWxsb2Nh
dGlvbiBmYWlsdXJlIGZvciAlcHJcbiIsIHJlcyk7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBnb3RvIG91dF9yZXNvdXJjZTsKPiDCoMKgwqDCoMKgwqDCoMKgfQo+IMKgCj4gwqDC
oMKgwqDCoMKgwqDCoHJjID0gcGxhdGZvcm1fZGV2aWNlX2FkZChwZGV2KTsKPiDCoMKgwqDCoMKg
wqDCoMKgaWYgKHJjIDwgMCkgewo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkZXZf
ZXJyKCZwZGV2LT5kZXYsICJkZXZpY2UgYWRkIGZhaWxlZCBmb3IgJXByXG4iLCAmcmVzKTsKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGV2X2VycigmcGRldi0+ZGV2LCAiZGV2aWNl
IGFkZCBmYWlsZWQgZm9yICVwclxuIiwgcmVzKTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoGdvdG8gb3V0X3Jlc291cmNlOwo+IMKgwqDCoMKgwqDCoMKgwqB9Cj4gwqAKPiDCoMKg
wqDCoMKgwqDCoMKgcmV0dXJuOwo+IMKgCj4gwqBvdXRfcmVzb3VyY2U6Cj4gLcKgwqDCoMKgwqDC
oMKgX19yZWxlYXNlX3JlZ2lvbigmaG1lbV9hY3RpdmUsIHJlcy5zdGFydCwgcmVzb3VyY2Vfc2l6
ZSgmcmVzKSk7Cj4gK8KgwqDCoMKgwqDCoMKgX19yZWxlYXNlX3JlZ2lvbigmaG1lbV9hY3RpdmUs
IHJlcy0+c3RhcnQsIHJlc291cmNlX3NpemUocmVzKSk7Cj4gwqBvdXRfYWN0aXZlOgo+IMKgwqDC
oMKgwqDCoMKgwqBwbGF0Zm9ybV9kZXZpY2VfcHV0KHBkZXYpOwo+IMKgb3V0X3BkZXY6Cj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZGF4L2htZW0vaG1lbS5jIGIvZHJpdmVycy9kYXgvaG1lbS9obWVt
LmMKPiBpbmRleCBjNzM1MWUwZGM4ZmYuLjUwMjVhOGM5ODUwYiAxMDA2NDQKPiAtLS0gYS9kcml2
ZXJzL2RheC9obWVtL2htZW0uYwo+ICsrKyBiL2RyaXZlcnMvZGF4L2htZW0vaG1lbS5jCj4gQEAg
LTE1LDI1ICsxNSwxNyBAQCBzdGF0aWMgaW50IGRheF9obWVtX3Byb2JlKHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYpCj4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBtZW1yZWdpb25faW5mbyAq
bXJpOwo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgZGV2X2RheF9kYXRhIGRhdGE7Cj4gwqDCoMKg
wqDCoMKgwqDCoHN0cnVjdCBkZXZfZGF4ICpkZXZfZGF4Owo+IC3CoMKgwqDCoMKgwqDCoHN0cnVj
dCByZXNvdXJjZSAqcmVzOwo+IC3CoMKgwqDCoMKgwqDCoHN0cnVjdCByYW5nZSByYW5nZTsKPiAt
Cj4gLcKgwqDCoMKgwqDCoMKgcmVzID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYsIElPUkVT
T1VSQ0VfTUVNLCAwKTsKPiAtwqDCoMKgwqDCoMKgwqBpZiAoIXJlcykKPiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FTk9NRU07Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKg
bXJpID0gZGV2LT5wbGF0Zm9ybV9kYXRhOwo+IC3CoMKgwqDCoMKgwqDCoHJhbmdlLnN0YXJ0ID0g
cmVzLT5zdGFydDsKPiAtwqDCoMKgwqDCoMKgwqByYW5nZS5lbmQgPSByZXMtPmVuZDsKPiAtwqDC
oMKgwqDCoMKgwqBkYXhfcmVnaW9uID0gYWxsb2NfZGF4X3JlZ2lvbihkZXYsIHBkZXYtPmlkLCAm
cmFuZ2UsIG1yaS0+dGFyZ2V0X25vZGUsCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBQTURfU0laRSwgMCk7Cj4gK8KgwqDCoMKgwqDCoMKgZGF4X3JlZ2lv
biA9IGFsbG9jX2RheF9yZWdpb24oZGV2LCBwZGV2LT5pZCwgJm1yaS0+cmFuZ2UsCj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBtcmktPnRhcmdldF9ub2RlLCBQTURfU0laRSwgMCk7Cj4gwqDCoMKgwqDCoMKg
wqDCoGlmICghZGF4X3JlZ2lvbikKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJl
dHVybiAtRU5PTUVNOwo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoGRhdGEgPSAoc3RydWN0IGRldl9k
YXhfZGF0YSkgewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmRheF9yZWdpb24g
PSBkYXhfcmVnaW9uLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmlkID0gLTEs
Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5zaXplID0gcmVnaW9uX2lkbGUgPyAw
IDogcmVzb3VyY2Vfc2l6ZShyZXMpLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAu
c2l6ZSA9IHJlZ2lvbl9pZGxlID8gMCA6IHJhbmdlX2xlbigmbXJpLT5yYW5nZSksCj4gwqDCoMKg
wqDCoMKgwqDCoH07Cj4gwqDCoMKgwqDCoMKgwqDCoGRldl9kYXggPSBkZXZtX2NyZWF0ZV9kZXZf
ZGF4KCZkYXRhKTsKPiDCoMKgwqDCoMKgwqDCoMKgaWYgKElTX0VSUihkZXZfZGF4KSkKPiBkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tZW1yZWdpb24uaCBiL2luY2x1ZGUvbGludXgvbWVtcmVn
aW9uLmgKPiBpbmRleCBiZjgzMzYzODA3YWMuLmMwMTMyMTQ2Nzc4OSAxMDA2NDQKPiAtLS0gYS9p
bmNsdWRlL2xpbnV4L21lbXJlZ2lvbi5oCj4gKysrIGIvaW5jbHVkZS9saW51eC9tZW1yZWdpb24u
aAo+IEBAIC0zLDEwICszLDEyIEBACj4gwqAjZGVmaW5lIF9NRU1SRUdJT05fSF8KPiDCoCNpbmNs
dWRlIDxsaW51eC90eXBlcy5oPgo+IMKgI2luY2x1ZGUgPGxpbnV4L2Vycm5vLmg+Cj4gKyNpbmNs
dWRlIDxsaW51eC9yYW5nZS5oPgo+IMKgI2luY2x1ZGUgPGxpbnV4L2J1Zy5oPgo+IMKgCj4gwqBz
dHJ1Y3QgbWVtcmVnaW9uX2luZm8gewo+IMKgwqDCoMKgwqDCoMKgwqBpbnQgdGFyZ2V0X25vZGU7
Cj4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IHJhbmdlIHJhbmdlOwo+IMKgfTsKPiDCoAo+IMKgI2lm
ZGVmIENPTkZJR19NRU1SRUdJT04KPiAKCg==
