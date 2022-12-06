Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565B6644E08
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Dec 2022 22:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiLFVhK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Dec 2022 16:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiLFVhJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Dec 2022 16:37:09 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FBA3FBAF
        for <linux-acpi@vger.kernel.org>; Tue,  6 Dec 2022 13:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670362627; x=1701898627;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FJY0p5bYpsXoXZkPLwicuBl3567heTcJJITFMK8ij0E=;
  b=ZnHLo0aWgXLGjXhz4YPxu9uTiC9FjdmWpBt/2a9Nx8+HHQ0zQZDVwbjN
   y7mLU6Mm9lKTCMlk6WkCG6ZZDoswH3TxUcYw/UIv5fusAZXq/8m+pnuIf
   Fx9t3Ln3zK0AMZgK22o/+S1vG/FYenTZ42j1xFZqWisi54/Udi2Qqariy
   zJ/cdMjP1N+B9rs8xivcLQO75HZFHPrE3uV+nf6ld3qGxUYzuUjONt6j4
   5Ae6IkaRUCKqvVknXAI65jQuVnaiwiY2fXwcrpH8ioqckbJQbMm8aYtSS
   IHSPsVAhDILswwrrPj7tYp3zyC/YSwNl2E8RiY4LRA0l75W7oAY4FROmN
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="315448137"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="315448137"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 13:37:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="709823464"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="709823464"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 06 Dec 2022 13:37:07 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 6 Dec 2022 13:37:06 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 6 Dec 2022 13:37:06 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 6 Dec 2022 13:37:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBWpFWPIBFBvz9kYjCw8Rc4jyhzsEL3HJuRY7bPEtXvXdvLuT+40tsPD+KgFcHaDkVi7X/WIF0nlhbcdeVHADqAt1g5qE9hBwN+iTqB8hTN2JB+SUK4WrEnu7f931FTc3is5ovJzClqTixM8b89yj7VR0Swlj+up4WOLepMRc06Pa8QZP0d8mTRlx5vkIR+v1hnPbdaEmEA0CSmZVwyPFANDkSn6mL/oVR5iTX7DwRwuybKGyMMnqwX9OA3g5tuoHmwPjiqpDhiHCSbXD7L8XryOat59xPn5+W/mFMN+elgxaQAwC9aiaI2E5AOCBSYf56Z31z1+2DRocM1/TUDIrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJY0p5bYpsXoXZkPLwicuBl3567heTcJJITFMK8ij0E=;
 b=SyJb8EArFBDRlv0CfHiDYoz1aSNU/fLa3HbI4b7DxKlp9bnVX5i/wz1i9CH2nLzUztbbCZoZfnNLxfh4KBwEcwOHRnyEyfhHbOfq5SxXaxl46ZbiAMQrIETALR4sKUgHS66HXWwuX4TgsgyK0HZHgpTbUQw/g2gfwPhl53xAf5+r6UhxkOelscb8G+J9LnkmVnkrtxlUJ5QeRR8cZkjSdeypcNdQFR+8+pDGUzaB7B9tlMxqUR/NbPtHsFAqZReSnPEBqn80jeLbQ5/PtxybtUZnsSF8eDFEK0+DVHmYm0RUKc9aOUu56pKs9fNxwiVul09iTJq9S7s6GiNLVM3V/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SJ0PR11MB6741.namprd11.prod.outlook.com (2603:10b6:a03:47a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 21:37:05 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::4eea:7bf0:e6b0:5014]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::4eea:7bf0:e6b0:5014%5]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 21:37:05 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Ben Cheatham <benjamin.cheatham@amd.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "bp@alien8.de" <bp@alien8.de>
CC:     "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v2 0/3] ACPI, APEI, EINJ: Add new CXL Error Types
Thread-Topic: [PATCH v2 0/3] ACPI, APEI, EINJ: Add new CXL Error Types
Thread-Index: AQHZCbS4rpo55m8RgEeWbbRb1EJBv65hWXPAgAAEYYCAAAGy8A==
Date:   Tue, 6 Dec 2022 21:37:04 +0000
Message-ID: <SJ1PR11MB6083C4960BC481DE9BEF2BB7FC1B9@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20221206205234.606073-1-Benjamin.Cheatham@amd.com>
 <SJ1PR11MB608313CBF490328F8C431796FC1B9@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <8f9feb3e-4c32-5c16-558c-7693cc277992@amd.com>
In-Reply-To: <8f9feb3e-4c32-5c16-558c-7693cc277992@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SJ0PR11MB6741:EE_
x-ms-office365-filtering-correlation-id: 37e69905-4da3-4055-79be-08dad7d204d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5XE+WGa21m1/FBmNKIyil1TQt6iTkR+9YEh4qk4em4aCEKajltxnyRSvvCn9GsgG7O4rIircZ1mF2OoRNhaIemgzSL+qie6WTKOceMbfyGfrJRt2wVr8F48/rK3d4TqPEqZyGZFFzixouB7ws+V0Wb7urbFAytdYVOULKyuBhf50Cg6d0d02BG00O+S4EFjyrurVe2dHh4qsLIfTsEdWMjZJa6mvMJkpNIt55+22C0t/TlNePaeZLGimruA+S7jXXKwVQVaZJsit+wPjq8L1JCfN0N9uf90OfiKq1RWnOPYXLAN83dfGeLEadpPR2LoZBuwf40j3xy0Mp7NxjmviJwAHKevdjYat4D2/Zh00BH1UaugVwrogdmmdTswIo3VpwgtLMFKjSujk5faWpVimWmeJER9a6pw2QPbbqOeWnANZgvrS5tBH9RdhkO2u14qcmsoNEiTl6p8upjnEb+RZohgR1dhXEhVLtXUxAvr2FvkujM2SuD3p46xCxXkIMtEg5fowWgtu9fffqnqUUhJb7Bsv8vBNzjzQXuW5oBy/jOvdj/oSMHc1Sn7E10d20aH+Ki3spf71I3OpNgIkJtXGoMrSz2XCibW5uQAmO14lPkiUGoAivyZTWvbZ/lR0Kyk2mqGZnp01SbKM5kPbzsTWtGZ00ftsdXYu86GaVOP40YW6R2stoIpVpn4TjW/4kLAdtf6bMLkp70x3EVgm0DfOCg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(376002)(39860400002)(396003)(366004)(451199015)(26005)(478600001)(2906002)(86362001)(316002)(41300700001)(33656002)(76116006)(55016003)(122000001)(66476007)(66946007)(38100700002)(82960400001)(7696005)(66446008)(66556008)(64756008)(6506007)(8676002)(38070700005)(4326008)(71200400001)(8936002)(186003)(5660300002)(110136005)(52536014)(9686003)(66899015)(4744005)(54906003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K3Vsa2pEbkY1eDFlWWZta0ViT3ZOdE1qTXlNUERkNG03REt1KzRHSGNiRGNU?=
 =?utf-8?B?WGRaalg4a1VneFpKU2xtTnZ2amNDNnJQZXNUeDYvZlBnUlJOSXA4SVllTmdH?=
 =?utf-8?B?emNJSkpsUDVhVEtWcGVhL1IraGxLV1dGQUlzVVFiTUVFRXh3bC9STWhTT1Vr?=
 =?utf-8?B?YytTcTgxbG1PbS9LYUI0bHJOT0NBR1VDZmZEY1FSYmQ3SmpSNGx5TkpMVW5M?=
 =?utf-8?B?bWRkSzkrcHE0bXBQeWhvOGpnSHp0bFMwWFhQSHd0RzVqcHFSTkpOdmNFWHBL?=
 =?utf-8?B?OENlbEkvTkhNd1hWQjV4SlBGemZHVnBraG5XK29xR1hnNWg1bGVQNDVyeXBJ?=
 =?utf-8?B?cUliZjcrZXBtNi9GdjF3OXlCVldSQWM5bGxEK2ZwTm83QjZkZlJyUkh6ZERa?=
 =?utf-8?B?Z0pEK2tOZ2I1eVR2L0gwNldnNmVlM29vekdsZFRzYTdZelJHYjREV05aQUxv?=
 =?utf-8?B?L2hJSGJ6MDJpdXg5MkQrakFwd3k3R1NGT2hGdUFOSEw5Q1RoQkp0MzRrQzk0?=
 =?utf-8?B?Nm9KZlVZcmxpZ0FaMTdWcHcvMWVhVmQrRnRrZEtNRExYNzhqUWF2R3JuQ1Nu?=
 =?utf-8?B?R09hOFhGcEdoU21GeHpqRlNvbDdoRmVvcEY3Ums2bFBpODhjdGdRRExrd2N3?=
 =?utf-8?B?SXZTOE4wSjdTQyt4TkVBYlQ4aXU5aHV5cElCWU5pbGdDOUZPTFplZXZUWWFz?=
 =?utf-8?B?N05OamhhYkVtVXVCT2dNUmlzOEhLVW1IZ05GYlN3YmoxVnJ4bGxoVDBSVVhw?=
 =?utf-8?B?TXhJK2p3ZDUyb1ZXdkFFbGRySDNydGwrZmNBWE5hS2VsdThtck5Xbkdqb1JO?=
 =?utf-8?B?QUtBdXRtSHpCaTZqcVNhL3pQcXk5R3NHc3pEMWY2cm9kMThuOHl0SURiWTVI?=
 =?utf-8?B?QTl3SWVRbnZqSlRzaGlCZ1F3eWV3a1Uwa0RHWnh1c3VpYWg1T1hFN01MWnp4?=
 =?utf-8?B?QXA0NVJad1Y5S1pnemo2YnBoRFB5eHlRUnBzN2JNdmhVUVdXM0FIcVBmK3Vt?=
 =?utf-8?B?ZFVkL044OForVmtkdG9EQTlVOVRUNGlVMW91b1ZlNnhsNFNZd283SVJmakcz?=
 =?utf-8?B?dWx1SVFEUk5GV1NDZ3JxWHFMQXFKNkRqd2poZXE5MGdCNUFIcldXTmN1WkVS?=
 =?utf-8?B?VitFeFE4YUJRaFpSM2pIWFpDa3RYZkE5cE51ck5YT2c5Z2R3QUtBcGxTMFhx?=
 =?utf-8?B?RW1ERFhkVktzZ3lVTXB2RFI0LzlYK3VHbnBmQ1pnUTRqcFBUSGhYdlJLaUVw?=
 =?utf-8?B?Mk9GWGQxYSt4UG1YK3dGVGQ0VW9aTS8xK1laQ0tya3J1aVNRVXFaOHliTWFL?=
 =?utf-8?B?TjZYS3c4RjJha21jRGVXSWNYRU95RU04T2JtZmtNbUE0Zk56U2tSNVFHaVRO?=
 =?utf-8?B?emlHU01xd1g5MzRMOGYzbWJtL3cwY2N4ejhMbWtMVVF0UDFlVjVNWHoyaldv?=
 =?utf-8?B?TENEV3VnWEhFaUgzZDFQcnJkN1lzOGdmaDRZS1kranlHN3V2dklPek5EYk96?=
 =?utf-8?B?YWJEekFHNS9yVmZnNVp4NlFORXNDd2praVFVaUQ4ei9TWVV6Wm5aWm4rSVFD?=
 =?utf-8?B?ZDJaT2VuZ25rV0tYdWxhZFI2UmNzZUxvRk54em43Z21tWHhmQndKTTdyZFNW?=
 =?utf-8?B?elI5dkJPeEdoS3BOV3FuaWFOdkx4ZG55YjFQdXVPUzhNTGVkQzBvSDVyTnUz?=
 =?utf-8?B?S3N3Um50YWNqU1hhNmZvcnduMVRiV2JDSFlrTjB3QW8xV0JFdTNoT0JsMnFP?=
 =?utf-8?B?TUpIWlhqZnhiclFsQ0dReXlScFRkV1Z6eGNPWGhzRDhpUlFITXc5Z3JMYjQ3?=
 =?utf-8?B?WmVqT2tZaVhuN0R0S2EyeHZOYmJwS0xyNC9zRjl1Zml3cDJDQkROeGxDRW5y?=
 =?utf-8?B?TElEM3BRZExrR0JCVDZyUWtsMmlpbHFvT2p6aFpuOTR3eFcvQzkxWkc0L2hM?=
 =?utf-8?B?cm45U0lJTHZuMW9XcVluSERLUDk1NmlqS3EyOG1qbUJyc0NlZ0JVWXZsQ0Nl?=
 =?utf-8?B?VnR2UnUzbTZZam0rZlJKRzl5bWZueTZpSVZQZ3pLa3o4bEJoV3BzOEhGeVh1?=
 =?utf-8?B?OGhpTkVIam1iZXF2VlZZejdtVzcza3VnK3F1bHRUS0dZQjY2bGZac3VBOTAr?=
 =?utf-8?Q?9EiDRvKOFH7rAKLyroN3zB1WE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37e69905-4da3-4055-79be-08dad7d204d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2022 21:37:04.9990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VzoqgEZmSdyUREuf4f5vRo+80CanYoW+XXhuvv0q3JtPq8kFclPgCss+Qt+ozkI8MdOtzBW4+gNT3lUw+sEekw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6741
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

SGkgQmVuLA0KDQo+IFRoZSBsYXN0IHBhdGNoIEkgbWVudGlvbmVkIGxlYXZpbmcgb3V0IGFkZGVk
IHN1cHBvcnQgZm9yIGluamVjdGluZyBDWEwgDQo+IGVycm9ycywgYnV0IEkgZG9uJ3QgaGF2ZSBh
Y2Nlc3MgdG8gYSBtYWNoaW5lIHRoYXQgSSBjYW4gdGVzdCBpdCB3aXRoIGF0IA0KPiB0aGUgbW9t
ZW50IHNvIGl0J2xsIHByb2JhYmx5IGhhdmUgdG8gd2FpdC4NCg0KUGFydHMgMSAmIDIgb2YgeW91
ciBzZXJpZXMgY2FuIGJlIGFwcGxpZWQgbm93IChhcyBuaWNlIGNsZWFudXBzKS4NCg0KQnV0IHBh
cnQgMyB3b3VsZCBqdXN0IGJlIGNvbmZ1c2luZyB0byB1c2VycyB3aXRob3V0IHRoZSBtYXRjaGlu
ZyBwYXRjaA0KdG8gYWRkIENYTCBpbmplY3Rpb24gc3VwcG9ydC4NCg0KSS5lLiBhIHVzZXIgbWln
aHQNCg0KIyBjYXQgL3N5cy9rZXJuZWwvZGVidWcvYXBlaS9laW5qL2F2YWlsYWJsZV9lcnJvcl90
eXBlDQoNCmFuZCBzZWU6DQoNCjB4MDAwMDEwMDAJQ1hMLmNhY2hlIFByb3RvY29sIENvcnJlY3Rh
YmxlDQoNCkJ1dDoNCg0KIyBlY2hvIDB4MTAwMCA+IC9zeXMva2VybmVsL2RlYnVnL2FwZWkvZWlu
ai9lcnJvcl90eXBlDQoNCndvdWxkbid0IGRvIGFueXRoaW5nIHVzZWZ1bCAobWF5IGRvIHdlaXJk
IHN0dWZmIHNpbmNlIHRoZSBkcml2ZXINCmRvZXNuJ3QgYXBwZWFyIHRvIHZhbGlkYXRlIHRoZSAi
dHlwZSIgLi4uIHdvdWxkIGJlIGdyZWF0IGlmIHlvdSBmaXhlZA0KdGhhdCB3aGlsZSB5b3UgYXJl
IGRpZ2dpbmcgYXJvdW5kIGluIHRoaXMgY29kZSA6LSkuDQoNClNvIEknbSBoYXBweSB0byBvZmZl
ciB1cCBhICJSZXZpZXdlZC1ieTogVG9ueSBMdWNrIDx0b255Lmx1Y2tAaW50ZWwuY29tPiINCmZv
ciBhbGwgdGhyZWUgcGFydHMuIEkganVzdCB0aGluayB0aGF0IHBhcnQgMyBzaG91bGQgbm90IGJl
IGFwcGxpZWQgdW50aWwgdGhlDQpyZXN0IG9mIHRoZSBjb2RlIHRvIGdvIHdpdGggaXQgaXMgcmVh
ZHkuDQoNCi1Ub255DQoNCg0K
