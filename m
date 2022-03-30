Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBD44ECDE4
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Mar 2022 22:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349350AbiC3USY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 30 Mar 2022 16:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350913AbiC3USX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Mar 2022 16:18:23 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1C94831C;
        Wed, 30 Mar 2022 13:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648671396; x=1680207396;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/iTNaYbZ2Kx+XLZo8ICGcZnW26BiarCMnsJt1IJu3DE=;
  b=hrJwjicYbLw+mn0GrbY8Pi469wBH9T+/ffMJ1DSKIf5jDG5tDbmNJEIu
   kPWjujdXTHdJne/JTCuRVbmfp2gm8yq2HLQzfebOIzkFHB+2Z2npRZuD3
   z+gBfi3ecP7lBYpPIarAbSyo3aA2nFjGCCxwcASFtSfUBhMlhMAgMWizO
   i1QuH3t6gFI9NQHyNWnIqNGRQIjHi9h9kWnH8KIg8YC449CkZ+8gVz32p
   ylrM3nFV4j34hgMBq0Y9CoDJzy0pjqShMGHEAq8NT6j84t0+z5d02ej9A
   ISHP4qHQffGL33P7kR7rWj++lBwkc0A1YLWAYqFKb0Q7TqK7KzauCsjL5
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="259351022"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="259351022"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 13:16:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="639855099"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Mar 2022 13:16:34 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 30 Mar 2022 13:16:34 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 30 Mar 2022 13:16:33 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 30 Mar 2022 13:16:33 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 30 Mar 2022 13:16:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5zich2JPXMTUmhFMN1FdWuxjE3COq9/nKDV5lJXYNnObA59R7V4jbuFc5HcIqX/WYJQDUYOcWCdDnCKrMVO2XBxxhHsuOdnHKpXlmr3dRFObBL0nC4e1LIZKG4bMci/1d+q/9GSZjW8XeVVIFkYrp8ONRApY9M5fPdtuluMTADDJFfrevRV/wsVIKz6r8m2Px8iTZGncHI4GWXuQZplpFhgCe3k5RRcm0E7IlH3VlgzZDisBkU83L9DzQ67XIp4CEySRR3xZGDYVIRjfX8/DydBkxLYRJsEfYgVVf1ypGQqpEk7aK/ZmBhSjTJ04eHYjIiRAv61kRmU2qf+DyyS/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/iTNaYbZ2Kx+XLZo8ICGcZnW26BiarCMnsJt1IJu3DE=;
 b=hEWSxs/NZalVNOQjyU+rJRVPSivyxBxXE0RFhNjA8p3pPC57deixuORlCD8KeB3PY1+UydQ6in21wWEVXkmhMdzVxn0JPUs7Xq69h1EvSfJ1cZyOY1tn1JD7DlrTmiA+hzwJt3eVl5Hz0HWa03IyjytfPV7bWcfBbJhqMdarW1xBrwRA8O/WBSFNYVF9XaRbpZ4c6rbD7jT0dv/zFP0Tl5d/+uSLJ8VvycCQ5j575PpsEqVrffHumVEA5K68HgqfFzSre8tJj67zJ/J4IqDbjqI7uRSkF/hZig1QxLup9CQqXwGnRqyQpdGfeNHCdrsLWHrbWYy0HfWniQOVmtctqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by MWHPR1101MB2303.namprd11.prod.outlook.com (2603:10b6:301:5b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Wed, 30 Mar
 2022 20:16:29 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::d898:84ee:d6a:4eb1]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::d898:84ee:d6a:4eb1%6]) with mapi id 15.20.5102.023; Wed, 30 Mar 2022
 20:16:29 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "helgaas@kernel.org" <helgaas@kernel.org>
CC:     lkp <lkp@intel.com>, "rafael@kernel.org" <rafael@kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Moore, Robert" <robert.moore@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>
Subject: Re: [PATCH v3 3/3] acpi/pci_root: negotiate CXL _OSC
Thread-Topic: [PATCH v3 3/3] acpi/pci_root: negotiate CXL _OSC
Thread-Index: AQHYRGIYuU9xbWgnOEKTWZKeTPrEjazYSGsAgAAU4wA=
Date:   Wed, 30 Mar 2022 20:16:29 +0000
Message-ID: <4a6543cf79e66ecd5ec5c15da5bec74d3602cb07.camel@intel.com>
References: <20220330190142.GA1698903@bhelgaas>
In-Reply-To: <20220330190142.GA1698903@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-1.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42cea80e-95f2-49cb-996a-08da128a2d17
x-ms-traffictypediagnostic: MWHPR1101MB2303:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <MWHPR1101MB23037C703005FBDFEB414267C71F9@MWHPR1101MB2303.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X0wWZD27Yn5DVKtP5kpGXnWEmEzRgwiDt2/EKz++k9Clko4Acz/uISupFASW7T0KOt2AKk7KBOAKODavK2sKUcz62MI53UWwJezORLX2mrK983G2EL4L+zQzEqV+UFOEUXwcezmksHCR3LO4Tko8g5HijB/b2GxrG+bRlxQVV1sMtbo3TjiVb6IbYZBEBIuYhkCY6+ZvpqkzCcPI2e/BPb/0RCL4YFYDbEh6CWyhGiplrg/WRgEClg0VFgV2q7yAyhwQnWrGPj8dZZvww6xdKLFeI/NBXwPCMmubTSQBx5K+nDl4oLuBr0i+gPXHuvb3CHJg6AsehzNdsA5FwMfGupj3rACfwm9DUtjtXPZMC7RaIh0pLUqEoaEGYHamPi6kq+6eYtkWF0ZhwtGxmX5AlSe1x6IHzWe8d6twGJs6eGKIqTsVJZpo01h0IIyaSGyI2DewbbGXDZxLFCJ4Kca2ahFVY9QhX3e+fnF9EfIRWVHYHw6yWVCpawY5fqMVmYwvyIxy8RQvjLg3a5HhOg8d6i7DlmLXrJ8iJNeVDV2qgOaZaJET+vYiBo4BzZ+M0yvT/36v2KBE4phm9UW8l3gAOnj0G9U+XJYn5r38tHe+e3mHGG7azU72jhDo9UIte5kqfbdNKPAf6PVnJajgdeFMn9mdM3JF4dS/RaXAb4+FPYu5cqs3Y1Lly6mTbEk36uVSC+VR/M4pNJNqxXAdnL5+K1Po77iWkFXPaU24nFncWvqyI4VQ5hFpcbfDGgRbfeqpBD6b99kxCE7Bt94hPaa6sYJMB7L5efvH75SUhnMtRGM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(508600001)(6506007)(316002)(76116006)(6512007)(86362001)(38070700005)(966005)(5660300002)(8676002)(66446008)(66476007)(66556008)(4326008)(82960400001)(64756008)(71200400001)(66946007)(91956017)(6486002)(54906003)(6916009)(8936002)(122000001)(36756003)(26005)(186003)(83380400001)(2616005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVZJK21hekZTMVFsVUdEK3dqaE52RzBmdlBnUCtIcmxmR1E2NVRWelVZN0Zq?=
 =?utf-8?B?K0tiT2oyV2JRL3pwcm5VSmtuODVINEF0QWVkbVZYZWFucFhVOXcra1E4OWFB?=
 =?utf-8?B?ZnV6cHgzNVNQcHNDeHFWU2VJdnpBeWZZaE1adG1UbVZvQ05pV2ZVTE8velpN?=
 =?utf-8?B?bDNvMWtDSnpraG1nK3h6WHZ3RU4yTkFCYnNubzY1WmZtNmNVMkhpb25qTFdE?=
 =?utf-8?B?SUJSR01seGk2c0g3N1pMSG9YQXRqcXB3MWRyN2FabHIvZm9zcmVzbXZBWVJu?=
 =?utf-8?B?UkZYRTU5c2xNV0hOclhKK3NLeEorTVlkTkc3V0VhYmM3ckdGTE02V3BOYWlz?=
 =?utf-8?B?LzdhckZsV3N3WkZuSnNNOGRGR2FlWjFwNDJ3dU5WRWlkVWFPVGxIeUdkVlJY?=
 =?utf-8?B?STNKRkVWZUo3Qk9JSUNWbFlVWkdGUmdHSkdNcjJyU3MzNXhYUG90VE04czIw?=
 =?utf-8?B?RTdBdnpMZjc0aFNIeHlVUjROajEzVVNCNjBvTHFaWVlKNW1pNVlqNGc4Uml6?=
 =?utf-8?B?bXRMa2J2SEpkSmZnNWhXU2pSN1BHU2FJbTl0djkzWlMrK044ekpEdzhMOEJE?=
 =?utf-8?B?RVV5R2ZVZFlMZFAxait1QnpNM0dRTXZ6N1JRclF6MEpRblNYNzFYNWdJamFV?=
 =?utf-8?B?UFNiUExmTkQ4cGhLdG53a2psT205blBkWFVLaHZkUC9SUHhrWnJSQTlNNFlU?=
 =?utf-8?B?NFUwR0ZOdWhoNDllOEpkOUFvNFdoTy90ZkwzTUlDSERWWThwTTRGRkQraVZz?=
 =?utf-8?B?TjZzdkRDaEJTSWlXNEgvTmpic1NpSldaNTcyTzVEZ1RxUWRMeGVuZGJjUVRC?=
 =?utf-8?B?OGI1VDVka1NTbTYvZXA3OGhJUzRzSTJVWml4Mi95TEtlT3d5OXZtek5yZnJL?=
 =?utf-8?B?WVZ1WnRZTTFDS201UnE2MFNkREg1d09RWFI2Z2RpV2pYcE41STNqL1VweEJR?=
 =?utf-8?B?NlNoazVSUHJtSmtiWERRSU44cU5XODZHY0ZwT1NUM1FQcXBQaWxVTkxRQzk1?=
 =?utf-8?B?dDBET1hER3NWNWZVQm1YNHRTYjRkRUFXTVBOYXdnSEdCRVlId0ZDZFVyczNV?=
 =?utf-8?B?eGh4REY3THhVbzEra1JFZUFET3hER1ErT2JpNVV5M0ZLM256NFIzOXNSQjJo?=
 =?utf-8?B?YlFGbDNyY3h2TjZKY2hQR1NWVVlZMzZqYTBMaDdlWE1xZzRmK3Mza2gzZXFo?=
 =?utf-8?B?ai9iNU1XYmJxM2hkKzFkTkpOZmkxT1JNSndrSU9sdUNuRmpIWmdnK2NidVNQ?=
 =?utf-8?B?Zko3ZzJSRGFRY1FSVE1td2RubXp1cmczUmJkMG4rbWFxT3EralV1ZWRUcW1S?=
 =?utf-8?B?ZlNYMU1QMEhLSWl5MEZXSHp1b0xFbE8rdkJZNnNjWHQyUWtKUldTMFp6NXJX?=
 =?utf-8?B?KzJqUk43ZUlKOGsyelg3NTdjVWNIaVVUM1FhTkt2Rk5DOFF3cWdZRG1rNlV2?=
 =?utf-8?B?YTBvRU5nVHFIMCs4UVpmb1ZuV04yZ25NcnY2UWlsVkVLMGRRNndYUEpZQWh2?=
 =?utf-8?B?dW9FN0pvSFc2WHBzVG51WUEwU3N3ZkVoRUdDR3A3UDRzemtEU1Q4MFI4RERF?=
 =?utf-8?B?MEVLdms1RGNTWjl1bjRneFVRVWFRdSswUXhhaDVpNU41SVdHKy9YTVkzRlJN?=
 =?utf-8?B?SG8rSHNSUlM4RkRzWStuYmprS25yWTkyVTZzdkp2d1M0NjFFQUowcXRWWE1U?=
 =?utf-8?B?QnZzbTJjMjhhcmw2NlNLKy9kbFR3Uk9XUEQ3Tm1tOGJzMFYzVXl0bm1RRE5o?=
 =?utf-8?B?NHVxeUNqcDNBY3dHditWMllZN0gzaGtsUWtNUDlIRWkxQndvbzJiZjFPRXVT?=
 =?utf-8?B?ZXJWeDN5R2kwazZCUFZRc0N6clgrNUMwNUpGUUY0aXRycDJTS2dBUjVralJk?=
 =?utf-8?B?QlJyT2srak9GZDJSa2IvdVZUNEorUEE0RmJvRTcxMUdUdUZRZytyRWdYRk9h?=
 =?utf-8?B?ZjNwaElvSFFQbC9samwvN1MzRlhpNHc1aUdzN3pMNUJZODlycm1qaUlRWU5k?=
 =?utf-8?B?RlY4SnA3aDd6QTVOa0dmaENldkU5NnVzTU93c2RqY041ZUNxYjlNZHhuQ3dD?=
 =?utf-8?B?RUtjanI1Qm5BdkVCRGlQcEJHVjdFMzVTdXpZbVkvb1RhUkFlVlJrTDVzM0ll?=
 =?utf-8?B?MWdrUlRXVGg5VFZWOVgxV3huVUxTc04xVmdFWFFnV3RXRVU3ZjJsUGZmTC9m?=
 =?utf-8?B?ZERtNFhES2twSUphaFh0WmFHdVBqNzJtSlpiaUZvYk0rQmZadlAxRklDRS9D?=
 =?utf-8?B?akJmeEFlei9JUVVJTEpIWTNwMXFXdFViR1V5TFBjb0t3anpZdlNLWWpCMlkv?=
 =?utf-8?B?WmVtUWFXU2hLRVppZlNSWUt1OXJvZ3pIOU1DTXg0bzBYTmFrTUo3bS91MG9I?=
 =?utf-8?Q?KRPH5pUvm9n+F82M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2921D714EEA1274F9F4933EFB771CB01@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42cea80e-95f2-49cb-996a-08da128a2d17
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2022 20:16:29.5779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +M+w2lIKdxXioiElat3zvQSilI+gagiXVkC3ilCGv8xt97lDqsMi9T4fMeVbAYspGy39MpMw17oxBZOSx5Zn3xNZvRlUkUn8VXJkqO3VeBc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2303
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

T24gV2VkLCAyMDIyLTAzLTMwIGF0IDE0OjAxIC0wNTAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiBEb24ndCBqdXN0IG1ha2UgdXAgbmV3IHByZWZpeGVzIGZvciB0aGUgc3ViamVjdCBsaW5lLsKg
IFByZXZpb3VzIG9uZXMNCj4gbG9vayBsaWtlIHRoaXM6DQo+IA0KPiDCoCBQQ0kvQUNQSTogRml4
IGFjcGlfcGNpX29zY19jb250cm9sX3NldCgpIGtlcm5lbC1kb2MgY29tbWVudA0KPiDCoCBBQ1BJ
OiBVc2UgYWNwaV9mZXRjaF9hY3BpX2RldigpIGluc3RlYWQgb2YgYWNwaV9idXNfZ2V0X2Rldmlj
ZSgpDQo+IMKgIFBDSS9BQ1BJOiBDaGVjayBmb3IgX09TQyBzdXBwb3J0IGluIGFjcGlfcGNpX29z
Y19jb250cm9sX3NldCgpDQo+IMKgIFBDSS9BQ1BJOiBNb3ZlIF9PU0MgcXVlcnkgY2hlY2tzIHRv
IHNlcGFyYXRlIGZ1bmN0aW9uDQo+IMKgIFBDSS9BQ1BJOiBNb3ZlIHN1cHBvcnRlZCBhbmQgY29u
dHJvbCBjYWxjdWxhdGlvbnMgdG8gc2VwYXJhdGUgZnVuY3Rpb25zDQo+IMKgIFBDSS9BQ1BJOiBS
ZW1vdmUgT1NDX1BDSV9TVVBQT1JUX01BU0tTIGFuZCBPU0NfUENJX0NPTlRST0xfTUFTS1MNCj4g
wqAgQUNQSTogcGNpX3Jvb3Q6IFVuaWZ5IHRoZSBtZXNzYWdlIHByaW50aW5nDQo+IMKgIFBDSS9B
Q1BJOiBDbGFyaWZ5IG1lc3NhZ2UgYWJvdXQgX09TQyBmYWlsdXJlDQo+IMKgIFBDSS9BQ1BJOiBS
ZW1vdmUgdW5uZWNlc3Nhcnkgb3NjX2xvY2sNCj4gwqAgUENJL0FDUEk6IE1ha2UgYWNwaV9wY2lf
b3NjX2NvbnRyb2xfc2V0KCkgc3RhdGljDQo+IMKgIFBDSS9BQ1BJOiBSZXBsYWNlIG9wZW4gY29k
ZWQgdmFyaWFudCBvZiByZXNvdXJjZV91bmlvbigpDQo+IA0KPiBTbyBJIHRoaW5rICJQQ0kvQUNQ
STogIiB3b3VsZCBiZSBhIGdvb2QgY2hvaWNlLsKgIEFsc28gY2FwaXRhbGl6ZSB0aGUNCj4gbmV4
dCB3b3JkIGFzIGFsbCB0aGUgYWJvdmUgZG8uDQoNClllcCB3aWxsIGNoYW5nZSB0byAiUENJL0FD
UEk6Ig0KDQo+IA0KPiBPbiBXZWQsIE1hciAzMCwgMjAyMiBhdCAxMjoxNDozNFBNIC0wNjAwLCBW
aXNoYWwgVmVybWEgd3JvdGU6DQo+ID4gQWRkIGZ1bGwgc3VwcG9ydCBmb3IgbmVnb3RpYXRpbmcg
X09TQyBhcyBkZWZpbmVkIGluIHRoZSBDWEwgMi4wIHNwZWMsIGFzDQo+IA0KPiBQbGVhc2UgaW5j
bHVkZSBhIHNlY3Rpb24gcmVmZXJlbmNlLg0KDQpPaw0KDQo+IA0KPiA+IGFwcGxpY2FibGUgdG8g
Q1hMLWVuYWJsZWQgcGxhdGZvcm1zLiBBZHZlcnRpc2Ugc3VwcG9ydCBmb3IgdGhlIENYTA0KPiA+
IGZlYXR1cmVzIHdlIHN1cHBvcnQgLSAnQ1hMIDIuMCBwb3J0L2RldmljZSByZWdpc3RlciBhY2Nl
c3MnLCAnUHJvdG9jb2wNCj4gPiBFcnJvciBSZXBvcnRpbmcnLCBhbmQgJ0NMIE5hdGl2ZSBIb3Qg
UGx1ZycuIFJlcXVlc3QgY29udHJvbCBmb3IgJ0NYTA0KPiANCj4gIkNMIiBsb29rcyBsaWtlIGEg
dHlwbyBmb3IgIkNYTCI/DQoNClllcCwgZml4ZWQgZm9yIHY0Lg0KDQo+IA0KPiA+IE1lbW9yeSBF
cnJvciBSZXBvcnRpbmcnLiBUaGUgcmVxdWVzdHMgYXJlIGRlcGVuZGVudCBvbiBDT05GSUdfKiBi
YXNlZA0KPiA+IHByZS1yZXF1aXNpdGVzLCBhbmQgcHJpb3IgUENJIGVuYWJsaW5nLCBzaW1pbGFy
IHRvIGhvdyB0aGUgc3RhbmRhcmQgUENJDQo+IA0KPiBzL3ByZS1yZXF1aXNpdGVzL3ByZXJlcXVp
c2l0ZXMvDQoNCkFjay4NCg0KPiANCj4gPiBfT1NDIGJpdHMgYXJlIGRldGVybWluZWQuDQo+ID4g
DQo+ID4gVGhlIENYTCBzcGVjaWZpY2F0aW9uIGRvZXMgbm90IGRlZmluZSBhbnkgYWRkaXRpb25h
bCBjb25zdHJhaW50cyBvbg0KPiA+IHRoZSBob3RwbHVnIGZsb3cgYmV5b25kIFBDSWUgbmF0aXZl
IGhvdHBsdWcsIHNvIGEga2VybmVsIHRoYXQgc3VwcG9ydHMNCj4gPiBuYXRpdmUgUENJZSBob3Rw
bHVnLCBzdXBwb3J0cyBDWEwgaG90cGx1Zy4gRm9yIGVycm9yIGhhbmRsaW5nIHByb3RvY29sDQo+
ID4gYW5kIGxpbmsgZXJyb3JzIGp1c3QgdXNlIFBDSWUgQUVSLiBUaGVyZSBpcyBuYXNjZW50IHN1
cHBvcnQgZm9yDQo+ID4gYW1lbmRpbmcgQUVSIGV2ZW50cyB3aXRoIENYTCBzcGVjaWZpYyBzdGF0
dXMgWzFdLCBidXQgdGhlcmUncw0KPiA+IG90aGVyd2lzZSBubyBhZGRpdGlvbmFsIE9TIHJlc3Bv
bnNpYmlsaXR5IGZvciBDWEwgZXJyb3JzIGJleW9uZCBQQ0llDQo+ID4gQUVSLiBDWEwgTWVtb3J5
IEVycm9ycyBiZWhhdmUgdGhlIHNhbWUgYXMgdHlwaWNhbCBtZW1vcnkgZXJyb3JzIHNvDQo+ID4g
Q09ORklHX01FTU9SWV9GQUlMVVJFIGlzIHN1ZmZpY2llbnQgdG8gaW5kaWNhdGUgc3VwcG9ydCB0
byBwbGF0Zm9ybQ0KPiA+IGZpcm13YXJlLg0KPiA+IA0KPiA+IFsxXTogaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbGludXgtY3hsLzE2NDc0MDQwMjI0Mi4zOTEyMDU2LjgzMDM2MjUzOTI4NzEzMTM4
NjAuc3RnaXRAZHdpbGxpYTItZGVzazMuYW1yLmNvcnAuaW50ZWwuY29tLw0KPiA+IA0KPiA+IENj
OiBCam9ybiBIZWxnYWFzIDxiaGVsZ2Fhc0Bnb29nbGUuY29tPg0KPiA+IENjOiAiUmFmYWVsIEou
IFd5c29ja2kiIDxyYWZhZWxAa2VybmVsLm9yZz4NCj4gPiBDYzogUm9iZXJ0IE1vb3JlIDxyb2Jl
cnQubW9vcmVAaW50ZWwuY29tPg0KPiA+IENjOiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1z
QGludGVsLmNvbT4NCj4gPiBSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRl
bC5jb20+DQo+IA0KPiBXaGF0IHdhcyByZXBvcnRlZCBieSB0aGUgcm9ib3Q/wqAgSWYgaXQganVz
dCBjb21wbGFpbmVkIGFib3V0IHNvbWV0aGluZw0KPiBpbiB2MSBvciB2MiwgSSB0aGluayB0aGVy
ZSdzIG5vIHBvaW50IGluIG1lbnRpb25pbmcgdGhpcyBoZXJlLsKgIEl0J3MNCj4gdGhlIHNhbWUg
YXMgb3JkaW5hcnkgcmV2aWV3IGNvbW1lbnRzIChsaWtlIHRoZXNlIEknbSBjb21wb3NpbmcpLCBh
bmQNCj4gdGhleSBkb24ndCBuZWVkIHRvIGJlIGFja25vd2xlZGdlZC7CoCBJIHRoaW5rICJSZXBv
cnRlZC1ieSIgaXMgZ3JlYXQNCj4gd2hlbiBnaXZpbmcgY3JlZGl0IGZvciBidWcgZml4ZXMsIGJ1
dCB0aGF0J3Mgbm90IHdoYXQncyBoYXBwZW5pbmcNCj4gaGVyZS4NCg0KQ29ycmVjdCBpdCB3YXMg
YSBjb21waWxlIHdhcm5pbmcsIGFuZCBhY3R1YWxseSBpdCB3YXNuJ3Qgb24tbGlzdCAtIDBkYXkN
CnNlbnQgaXQgcHJpdmF0ZWx5LCBiZWNhdXNlIGl0IHdhcyBvbiB0aGUgUkZDIHZlcnNpb24uIEl0
IG1ha2VzIHNlbnNlIHRvDQp0cmVhdCBpdCBhcyBhIG5vcm1hbCByZXZpZXcgY29tbWVudCAtIEkg
b25seSBhZGRlZCB0aGUgdGFnIGJlY2F1c2UgdGhlDQowZGF5IGVtYWlscyBhc2sgeW91IHRvIChJ
IHN1cHBvc2UgdGhleSB1c2UgdGhlIHRyYWlsZXJzIGZvciBtZXRyaWNzIG9uDQphY3Rpb25hYmxl
IGZlZWRiYWNrIGdlbmVyYXRlZCBieSB0aGUgYm90KS4gSSdtIGhhcHB5IHRvIGRyb3AgaXQgaWYN
CnRoYXQncyBwcmVmZXJyZWQgaGVyZS4NCg0KPiANCj4gQmpvcm4NCg0K
