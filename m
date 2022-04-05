Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879644F46C9
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Apr 2022 01:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235268AbiDEUot (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Apr 2022 16:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457512AbiDEQDT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Apr 2022 12:03:19 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E3E183B7;
        Tue,  5 Apr 2022 08:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649174168; x=1680710168;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BFspJGd9CB7+JJZIYrDM6mFb4mn/cTxRCjTekp+BIcA=;
  b=ZuQ5Mh4sfYagMyZ+GvSvE1gtyBhYQHVjfk+t/DPsrlnM+aAZ1/XwEPn5
   v4y7fr6kLuNRzppZ7ojBGcL5F3wRkJaxBYL7ywBZ0XHTXLYM6zZRqt0B/
   jJZsztt8dHJk91orDvhHGQXVvhzleu9vZv2ybFKfX3Nh2THCEQAf15gW4
   4MTtX7jCneiolUN4vEZiS76rdhWrSvIMNmrK58BRZ9OIN/7euLx4j8FCL
   J+8WzwwJNa4uGCmtNPb/4aEywmJksZjm2nyW2KQbcuwnJE8u1yxy0z4L/
   ozxwM3uzieLq6o/HhYRE60TOcpLRpirRbirlnxxLxgi5JQbakbxBy+g3E
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="248302174"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="248302174"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 08:55:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="641662923"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Apr 2022 08:55:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Apr 2022 08:55:50 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Apr 2022 08:55:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 5 Apr 2022 08:55:49 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 5 Apr 2022 08:55:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l1VBf1Q9SwUT+YYW2aRMMouIenB3RGtbaJY4JDv1ZFX3p1DPayniGRfvYS43YdNBo8vR2ytfEVa66wvrHOnGhWRFP3Rrz7UDaqsWw3ZcqDKfHDw00SPH6kRo/r9YbOt3v4Z/NmIxOxV2j3h2fK9MD4482fHbuJBxLdSocnzuykqt2bUctFlSmrWIHErQkzcGJlUgHXQ42ojPKODefIUMJKWiD4gHdF9B+VwG7CdVlktOaOEhDxTPjYQs33qL9hQxvONTcFjpd5y6oNHsuEt2zC63Apoemom3bJD2NaPGBMHrltVAYsZfju1ASEMtMpLheIUzoyo+xwguq/JFQO4MeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BFspJGd9CB7+JJZIYrDM6mFb4mn/cTxRCjTekp+BIcA=;
 b=oS9sUCI8IFmzmRWA81eeRxIprABvEzExYWK9QG0lTmJqenDKIRVSOKX6uMWKGY0Wcs9X2/togKcvhpueJPYOMmmxf9bHm4jnqNISLHkQdCecffI6w1roq2j/3zgihiO9yWm1XA/7V9Hemmc9Ppj/EUDj4sKkB9bdqQvwBSNuCe2ydPNzNNjGYv2SZc/WE7PEtqonXoKrLiBcCSRQ7Iqeuab4+szWgdXeOvquuU1SFm7HfHti+8ZMOOW82PIX+zpza1PMFwyy4XFOmciqOGY44IILfIiw6BWff0r96Iigy7HSxIjb4QtAyBwpXuPqox4v62V6MFf6/Odm+vGwNNBvzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by BN7PR11MB2801.namprd11.prod.outlook.com (2603:10b6:406:b4::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 15:55:47 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::41a:5dd4:f4b3:33cb]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::41a:5dd4:f4b3:33cb%7]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 15:55:47 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "rafael@kernel.org" <rafael@kernel.org>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Moore, Robert" <robert.moore@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>
Subject: Re: [PATCH v4 3/3] PCI/ACPI: negotiate CXL _OSC
Thread-Topic: [PATCH v4 3/3] PCI/ACPI: negotiate CXL _OSC
Thread-Index: AQHYRTzX1ng5YjcXVUWchGA2uAQ65KzhYJcAgAAgKAA=
Date:   Tue, 5 Apr 2022 15:55:47 +0000
Message-ID: <f7ee304bacd05e2407bc98138efdd7f291c0aad3.camel@intel.com>
References: <20220331202022.1823174-1-vishal.l.verma@intel.com>
         <20220331202022.1823174-4-vishal.l.verma@intel.com>
         <CAJZ5v0haSXXDXaJdWEqpwS=b8r2HQzffKCoVpeDbxY9No5QXfw@mail.gmail.com>
In-Reply-To: <CAJZ5v0haSXXDXaJdWEqpwS=b8r2HQzffKCoVpeDbxY9No5QXfw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-1.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a47813f-fcda-4a45-eb46-08da171cbfeb
x-ms-traffictypediagnostic: BN7PR11MB2801:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <BN7PR11MB2801F3CE65802FCB6A8B254FC7E49@BN7PR11MB2801.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kvPTFzumfNsU7AIIWEQIKA5Fe+4y+52bBUqkIV3WETpNYGZxGOYx98qCJqWDyqHT0A0qv33Z9w8nJucnBkOp64MSrcDLln+SXkcFxMRBo8fRMkjIj1hFFYxumf9Tf6uiVSBnQpJdTeymuT6eWoVoG3ydYxuwxfnWiJUNzWYQoc++NSYrCbMee3tECS4jNqIus30geri6VqBJtRnpsXvbZE+QBzin5zczb+EJLX52G/qwOJp/llerlRIOqMDoYYcR3Wloz3Wupi1I/Hb2BETOptJGVn76kNJ3DMYSi8hFDRh4nYM8u88w+LEH8CA7XP5bWEAnWO9eNMCOvZ48d2nLxnnZirTtsdtrT8eVH2NLq5qofPNOyPPK/9i21Pry5kG+7APEc1eyPnAz9awromX3oI97xFvfDB5/A5vfbNMa03QVusEg9TR6ppOUePNU+E5zhs7KzaxsUzfzoNitP7jU0iYdPDsqIhgwqTND8khZxm3NtmcrUuC42i0QvswLRQrAmMv4ze8QLR3+k2fP5/Wia07Nr2r8/zsW63EdmapjkfKbAzhJVcRrwtZ7ZvmPmLSVEXXXyafeA9nhdNJubH8bDqawuYrvJhwX1cq7dOYIOEwZ1Kgi2tcRINwDpRaQBxoVHBY5T2e8NSSQQCa229jda2Ou8Qbz/ZrZVGm4J5hIb/MZ5kGXc6Bt3pFNPnTZU6XezQ6U3sPDjY82nYK9B7rlUwUd/JOVTBND18WDBb17MhNSA1y836DuBclTARQ6As+lKXqkh2FQBM7fimtk2Dgo3m6eFwnmm7GKJGXTcBmlaAM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(76116006)(53546011)(38070700005)(66556008)(66476007)(66446008)(64756008)(91956017)(8676002)(66946007)(966005)(508600001)(6506007)(83380400001)(71200400001)(4326008)(38100700002)(6916009)(54906003)(2906002)(5660300002)(86362001)(8936002)(2616005)(36756003)(122000001)(82960400001)(186003)(316002)(26005)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SlNvMDM5VGU1amZ4aEJCME9POTN4a3o5OUovcklNNStmaGswYW44bVFkbkZV?=
 =?utf-8?B?QTc1dmUydDFCQTc4U2xsY2UrOFgyZGtkMS9OUEdGblQ2OHJCRkwzRXU0SXVB?=
 =?utf-8?B?eWxBQ2hDbGU2SCt4NjMvSUZXRlk0Y25JblRnUEw3RGordFFBbW9KSW5HSzRP?=
 =?utf-8?B?Nm1wUE1Xc2t4UTIvUGJ3SlA3RUNQT3h2YmNWb0szYk9zQWMvZDZxd2c1T25i?=
 =?utf-8?B?UUp2V1E5bnFrdUZ3WFhNVVo0Umx0UVZzZW84QzlVTXZIOWpIbnBzeHI4ZmFG?=
 =?utf-8?B?aWtocmtIMFFGQzBaY1JsbWlhZHZxN0FReTRDcGE4eGhWUDkxTnBvc3BSVU9B?=
 =?utf-8?B?eEF1RUFhZGZIaG9EYWxJdXg2Sk5JeWJtRGpWL0dMTVhtVE9RWEVQc1BYeUt0?=
 =?utf-8?B?K29NUlkzOC9qWVg4Y0F3V3ZQMUppa05TOUZubE9JT2RSSTBKalVIa2xpYlBq?=
 =?utf-8?B?cUY4d2g3WmRiSE5KN1phNFBCVGU0R3M2Y0ZqMUNod1IreUFjRDhQWTA5dHZY?=
 =?utf-8?B?M21iWWZoc0pHYWk1c2F6M3NNbkZoQkYrMGNGdFZzUVNTcjdxMHpOeTl2TUtM?=
 =?utf-8?B?eHFEdFI3all1dnpPS0FWTFRRcHVEemJuVVdKQWxsSy9EVE9MV3YyTkVwNmgx?=
 =?utf-8?B?bW10VkpYWnJsUnRUYjNFMVZZb0I2N0MxVTBTQUhyM3pPUFZLYXl1UnVyQ0xy?=
 =?utf-8?B?azBNREp5WVVjcWovRE9lcStyT1BxRVVtZlFURXE0THBMekdKc3owYk8zRmtZ?=
 =?utf-8?B?VEkyejUxZmg0N2tqelJaSGRhTFJDM0hOQUhKbGE2RFNDS1BSUVpQcTBoNlcy?=
 =?utf-8?B?eGI2blJzeHU4S1hZOGhjSytLYy9Kem92d0Y2clJ1dFh1bVpiL0k4ejFyeElI?=
 =?utf-8?B?VStMZzZSd1BUbWpNaFN5bkdhSTJhOWcrK2FaVVY1UGZWVU1XOXVnM3FEUXg5?=
 =?utf-8?B?M0dyN2tITlp5eVJzUCtCUUJ1WUlpeS9QWm9aSDJkZXlzT3RqSitaeGdaZEo1?=
 =?utf-8?B?ZW1jK1V0b3JGclEwb2JlL0Noc3dSTHFvMldJWlE5SkdvQVpqQnBJQVVMcUlx?=
 =?utf-8?B?MGQrZmVuRDZCSTlHVXdobG9RMW85R0Q1aDZCVW8zdWhOeFhVbTZWSG5tdkdk?=
 =?utf-8?B?aU1KMytDZHJKNk1FM1NxTUpiYXFiUytSUkVpMzVFbDJTYlRUckRHaHl6T3hh?=
 =?utf-8?B?TnRPa0V1ckxYNGhOczdkcEFNQ2ZuU1lVc3pPcGoyUVd2cUpXU3JBQTRqSXlh?=
 =?utf-8?B?VS92SjJaUy8yTWdzZmJnWW0vbS9sdy9yZkx3TDBVa3o3SS9PaFRkNFhDVFVU?=
 =?utf-8?B?U0oxTjQ1YTRwZGdLanppZXhZaTdEU0RERWx0a24zUU1vdXc2MnU4V0d0ZFdI?=
 =?utf-8?B?dllnbWJyMHdIS2pWZXdFZlNnNTVkYVBlTk1CbUlCZTQ4S0pZWVFndmloZDEx?=
 =?utf-8?B?UncvUFBRUEprOUJHcFM2bk9ETE1mdTNQL2xWWlpTL0szSVNUY0QzaExMbmdF?=
 =?utf-8?B?TzdmUUtYQy93R2RtWXlnM2ZXT2F6OXIxMDh3OXpNRmwzVHVVc0oxdUQ0Q05N?=
 =?utf-8?B?dEFkV2FtbW5NeExkd3hYZ0k0QkpXdjI3K01GYkZtTGZWZVVscmZQTEVlU0JI?=
 =?utf-8?B?QURNSDBqOXJkMUN0U2dKakdpcGZBa2xLSmIyUlAzNHF4K25XVFc0RCtxWFBI?=
 =?utf-8?B?NlNaQkx2WmVUQk0zZXVrMDA5QkdGUnZ1dWFsc3czcHpOeCtOa3BIVUlpcXQw?=
 =?utf-8?B?ajRiWC83ZWZwbi9INjR0azNZTUJQUjQ0VXNWOGZvLzNsU2w5UEZjNFJEN2dx?=
 =?utf-8?B?UmU0VVowVXdLc0d0MGE4cTZuK05WSFg5eGlsQ0NoSzlzTkkyeWtqVGwrVHho?=
 =?utf-8?B?d2xnd0R0QlJCRnNyaTBrdVo0OGNkUkpMRUlJMy9XT1Q4OE9vSzlCYStLUXIv?=
 =?utf-8?B?TnpScHAwM2Nka1BPUEFES2lSZy8zbjdrV2RWUy83NnEyem9yTDFDOGt0azR2?=
 =?utf-8?B?a0tIUk5kR24xcGwxT1NBaW1HcmJ0cU1hSmxIRzRBUFRZaVZYeEh2MHNLS29Z?=
 =?utf-8?B?djQwN3pZY3pZbFQwUkhMRVZ2VThUOURDZ3VzcGFBK2lqNDE0SnlXT05SRkcw?=
 =?utf-8?B?a1lDZUlUNXRyQmZiR3J3UVFiZENFZHJDajVBKzBscVRsMFVrZVk0cmk2NERH?=
 =?utf-8?B?aWVTL2dsMmoxdXNqeStVMFZxOE5vWERaZFl1b1BkRWpnODBKdjBVR2FrdzB1?=
 =?utf-8?B?Z01iZEJSS2ZLQVd1NjJlMWhNdnp3bHptZVNBRzlzc25DY3BPL3JGeWVCQzJp?=
 =?utf-8?B?QzJaRzFubzBBeDBJVit6SHp2UnBHVEUrbC9HOTJaVkwxbE94aHhpcmpKOFNR?=
 =?utf-8?Q?eUYkwG88GM0r3wUkWf5e29iist4HgsYqEmRcp?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E63A46D15384EF42B1B6D6155839FEAA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a47813f-fcda-4a45-eb46-08da171cbfeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2022 15:55:47.1529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: As05NJRW32/GWhcjlE6xAw2FDies5WhNwhjbINIpN1+vjR/I5V0pbIgnVKpKTEnRBD4mB0WJRBosUPNYTqyb3Ilaqb2eEk1GdAQNwEUQ4eI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2801
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

T24gVHVlLCAyMDIyLTA0LTA1IGF0IDE2OjAwICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gT24gVGh1LCBNYXIgMzEsIDIwMjIgYXQgMTA6MjAgUE0gVmlzaGFsIFZlcm1hIDx2aXNo
YWwubC52ZXJtYUBpbnRlbC5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IEFkZCBmdWxsIHN1cHBvcnQg
Zm9yIG5lZ290aWF0aW5nIF9PU0MgYXMgZGVmaW5lZCBpbiB0aGUgQ1hMIDIuMCBzcGVjLCBhcw0K
PiA+IGFwcGxpY2FibGUgdG8gQ1hMLWVuYWJsZWQgcGxhdGZvcm1zLiBBZHZlcnRpc2Ugc3VwcG9y
dCBmb3IgdGhlIENYTA0KPiA+IGZlYXR1cmVzIHdlIHN1cHBvcnQgLSAnQ1hMIDIuMCBwb3J0L2Rl
dmljZSByZWdpc3RlciBhY2Nlc3MnLCAnUHJvdG9jb2wNCj4gPiBFcnJvciBSZXBvcnRpbmcnLCBh
bmQgJ0NYTCBOYXRpdmUgSG90IFBsdWcnLiBSZXF1ZXN0IGNvbnRyb2wgZm9yICdDWEwNCj4gPiBN
ZW1vcnkgRXJyb3IgUmVwb3J0aW5nJy4gVGhlIHJlcXVlc3RzIGFyZSBkZXBlbmRlbnQgb24gQ09O
RklHXyogYmFzZWQNCj4gPiBwcmVyZXF1aXNpdGVzLCBhbmQgcHJpb3IgUENJIGVuYWJsaW5nLCBz
aW1pbGFyIHRvIGhvdyB0aGUgc3RhbmRhcmQgUENJDQo+ID4gX09TQyBiaXRzIGFyZSBkZXRlcm1p
bmVkLg0KPiA+IA0KPiA+IFRoZSBDWEwgc3BlY2lmaWNhdGlvbiBkb2VzIG5vdCBkZWZpbmUgYW55
IGFkZGl0aW9uYWwgY29uc3RyYWludHMgb24NCj4gPiB0aGUgaG90cGx1ZyBmbG93IGJleW9uZCBQ
Q0llIG5hdGl2ZSBob3RwbHVnLCBzbyBhIGtlcm5lbCB0aGF0IHN1cHBvcnRzDQo+ID4gbmF0aXZl
IFBDSWUgaG90cGx1Zywgc3VwcG9ydHMgQ1hMIGhvdHBsdWcuIEZvciBlcnJvciBoYW5kbGluZyBw
cm90b2NvbA0KPiA+IGFuZCBsaW5rIGVycm9ycyBqdXN0IHVzZSBQQ0llIEFFUi4gVGhlcmUgaXMg
bmFzY2VudCBzdXBwb3J0IGZvcg0KPiA+IGFtZW5kaW5nIEFFUiBldmVudHMgd2l0aCBDWEwgc3Bl
Y2lmaWMgc3RhdHVzIFsxXSwgYnV0IHRoZXJlJ3MNCj4gPiBvdGhlcndpc2Ugbm8gYWRkaXRpb25h
bCBPUyByZXNwb25zaWJpbGl0eSBmb3IgQ1hMIGVycm9ycyBiZXlvbmQgUENJZQ0KPiA+IEFFUi4g
Q1hMIE1lbW9yeSBFcnJvcnMgYmVoYXZlIHRoZSBzYW1lIGFzIHR5cGljYWwgbWVtb3J5IGVycm9y
cyBzbw0KPiA+IENPTkZJR19NRU1PUllfRkFJTFVSRSBpcyBzdWZmaWNpZW50IHRvIGluZGljYXRl
IHN1cHBvcnQgdG8gcGxhdGZvcm0NCj4gPiBmaXJtd2FyZS4NCj4gPiANCj4gPiBbMV06IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWN4bC8xNjQ3NDA0MDIyNDIuMzkxMjA1Ni44MzAzNjI1
MzkyODcxMzEzODYwLnN0Z2l0QGR3aWxsaWEyLWRlc2szLmFtci5jb3JwLmludGVsLmNvbS8NCj4g
PiANCj4gPiBDYzogQmpvcm4gSGVsZ2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT4NCj4gPiBDYzog
IlJhZmFlbCBKLiBXeXNvY2tpIiA8cmFmYWVsQGtlcm5lbC5vcmc+DQo+ID4gQ2M6IFJvYmVydCBN
b29yZSA8cm9iZXJ0Lm1vb3JlQGludGVsLmNvbT4NCj4gPiBDYzogRGFuIFdpbGxpYW1zIDxkYW4u
ai53aWxsaWFtc0BpbnRlbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogVmlzaGFsIFZlcm1hIDx2
aXNoYWwubC52ZXJtYUBpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gwqBpbmNsdWRlL2xpbnV4L2Fj
cGkuaMKgwqDCoCB8wqAgMjggKysrKysrKy0NCj4gPiDCoGluY2x1ZGUvYWNwaS9hY3BpX2J1cy5o
IHzCoMKgIDYgKy0NCj4gPiDCoGRyaXZlcnMvYWNwaS9wY2lfcm9vdC5jIHwgMTQ1ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0NCj4gPiDCoDMgZmlsZXMgY2hhbmdlZCwg
MTU3IGluc2VydGlvbnMoKyksIDIyIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQg
YS9pbmNsdWRlL2xpbnV4L2FjcGkuaCBiL2luY2x1ZGUvbGludXgvYWNwaS5oDQo+ID4gaW5kZXgg
ZmM0MGRhOTE0MzE1Li5jZjM2MGI5NjQyZDkgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51
eC9hY3BpLmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L2FjcGkuaA0KPiA+IEBAIC01NTQsMTAg
KzU1NCwxNSBAQCBhY3BpX3N0YXR1cyBhY3BpX3J1bl9vc2MoYWNwaV9oYW5kbGUgaGFuZGxlLCBz
dHJ1Y3QgYWNwaV9vc2NfY29udGV4dCAqY29udGV4dCk7DQo+ID4gwqAjZGVmaW5lIE9TQ19QQ0lf
Q0FQQUJJTElUWV9EV09SRFPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAzDQo+ID4gwqAjZGVm
aW5lIE9TQ19DWExfQ0FQQUJJTElUWV9EV09SRFPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA1
DQo+ID4gDQo+ID4gLS8qIEluZGV4ZXMgaW50byBfT1NDIENhcGFiaWxpdGllcyBCdWZmZXIgKERX
T1JEcyAyICYgMyBhcmUgZGV2aWNlLXNwZWNpZmljKSAqLw0KPiA+ICsvKg0KPiA+ICsgKiBJbmRl
eGVzIGludG8gX09TQyBDYXBhYmlsaXRpZXMgQnVmZmVyDQo+ID4gKyAqIERXT1JEcyAyICYgMyBh
cmUgZGV2aWNlLXNwZWNpZmljLCBhbmQgNCAmIDUgYXJlIHNwZWNpZmljIHRvIENYTCBwbGF0Zm9y
bXMNCj4gDQo+IFNheSAiRFdPUkRzIDIgdGhyb3VnaCA1IGFyZSBkZXZpY2Utc3BlY2lmaWMiIGFu
ZCB5b3UgZG9uJ3QgbmVlZCB0bw0KPiBtZW50aW9uIENYTCBoZXJlLg0KPiANCj4gPiArICovDQo+
ID4gwqAjZGVmaW5lIE9TQ19RVUVSWV9EV09SRMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDDCoMKgwqDCoMKgwqAgLyogRFdPUkQg
MSAqLw0KPiA+IMKgI2RlZmluZSBPU0NfU1VQUE9SVF9EV09SRMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAxwqDCoMKgwqDCoMKgIC8qIERXT1JEIDIgKi8NCj4gPiDC
oCNkZWZpbmUgT1NDX0NPTlRST0xfRFdPUkTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgMsKgwqDCoMKgwqDCoCAvKiBEV09SRCAzICovDQo+ID4gKyNkZWZpbmUgT1ND
X0NYTF9TVVBQT1JUX0RXT1JEwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAzwqDC
oMKgwqDCoMKgIC8qIERXT1JEIDQgKi8NCj4gPiArI2RlZmluZSBPU0NfQ1hMX0NPTlRST0xfRFdP
UkTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDTCoMKgwqDCoMKgwqAgLyogRFdP
UkQgNSAqLw0KPiANCj4gSSB3b3VsZCByZW5hbWUgdGhlIGxhc3QgdHdvIHN5bWJvbHMgYXMgT1ND
X0VYVF9TVVBQT1JUX0RXT1JEIGFuZA0KPiBPU0NfRVhUX0NPTlRST0xfRFdPUkQgKHNlZSBiZWxv
dyBmb3IgYW4gZXhwbGFuYXRpb24pLg0KPiANCj4gDQpZZXAsIGRyb3BwaW5nIENYTCByZWZlcmVu
Y2VzIGhlcmUgYW5kIHRoZSAnZXh0ZW5kZWQnIG5hbWluZyBzb3VuZHMNCmdvb2QsIEknbGwgdXBk
YXRlIHdpdGggdGhlc2UgY2hhbmdlcy4NCg==
