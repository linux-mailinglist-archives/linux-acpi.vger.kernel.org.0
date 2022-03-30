Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2CAC4ECDAF
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Mar 2022 22:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbiC3UJ5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 30 Mar 2022 16:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbiC3UJ4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Mar 2022 16:09:56 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8F05D19C;
        Wed, 30 Mar 2022 13:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648670888; x=1680206888;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f+xxicozIFiamBkxp9os83PdT/bBY6hqXIrmjX4dths=;
  b=EffwnBrrFKRL1UX+HkR2rLI14F3ZzNN70IhF9kzRHPJjXhpIeWeJ9CTf
   1mU5o0o5UQ/dO/Ko728hzvhS/u+PBzGI09uRRw0NP0GGvEofOfqAyoWVj
   r7/PM627CUE6NAWBzC/wjYplexh4/IWJvWwcBDJEWmPCI5/bcb11iBdWI
   n/AUGQEji96zk3VpzWMRtFf8rLr8h18K+4xTYROzBdOtutAJLQ9xnB+Bz
   DFsVeAolMMK/oDvI9U1Gtx7ZdUyHwzg8WOGusR9oj283/ul0H51Ggxc7Q
   n2FdB5YGKlPRTzH3I19biYO3lGIaVtUxrfLHSYS66b/H8cMoZ0AYPmWSw
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="258466949"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="258466949"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 13:08:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="554795677"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP; 30 Mar 2022 13:08:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 30 Mar 2022 13:08:08 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 30 Mar 2022 13:08:07 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 30 Mar 2022 13:08:07 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 30 Mar 2022 13:08:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fOHslveSi1qkeNQaPYRWniGtX21oR8TFe5rG6auvsVseOoHlCvpVr9j+m3Ppuw/IGZ7tR2yWNT5WyrmGh6o5TwNVZIX/H6aSkr414W9Cd41CYT/vdaf35QF7S/l6vyUwJsyOmdLMpeEt7P1aaAXyWC58ziyo2lywRnzFFL/4hg4MosmTMbBA6m/ebFm8v7a3wyfGGgBKbF7t9sJFQrY8hwVfmg8TysnA/uJkESd6AjpDU9P/iY12ezlnoDz+yenKnAr4GdfpQ95UzOGCcm5QjBg93XBKNx8+NrBhIzuZoP3M5KCm/RvfvRIAEWGR6VM3NAMFW2ES+vee2ErMo7ZjIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+xxicozIFiamBkxp9os83PdT/bBY6hqXIrmjX4dths=;
 b=KmZdZER6uQ5sUukcKKUDeICrW5Ijuz4rFQLq+lU/dMD+rJ5n5TBJNQpjT6A8cq5vs3XGLaxrlgq4COlJ65olQ2ne5XHbSKAP92NRH5XrR+ytscpTC690qsDxpHD4IIm2fYxTf0S+OcQ1weIZqNcyli7gwYxHhxqck69JbI5yRrQQ1El/YI4Z8dPrd0/1a/vyo0Hrg9d28vEPHcp+VEa/9/ZVx/qbWWQEZ+GhBgxyDMav5OBEtg+YeZaAhEH9kc7572smNCWECYHOVLRLZUYBlIIRdUaHZcT+ymLwiZ9iOgf6gnnxgeYrucPED0nLbo8tDWKxSNcJ5gbYUuJcyRHu+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by SJ0PR11MB5614.namprd11.prod.outlook.com (2603:10b6:a03:300::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.19; Wed, 30 Mar
 2022 20:08:06 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::d898:84ee:d6a:4eb1]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::d898:84ee:d6a:4eb1%6]) with mapi id 15.20.5102.023; Wed, 30 Mar 2022
 20:08:06 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "helgaas@kernel.org" <helgaas@kernel.org>
CC:     "rafael@kernel.org" <rafael@kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Moore, Robert" <robert.moore@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>
Subject: Re: [PATCH v3 1/3] acpi: add a helper for retrieving _OSC Control
 DWORDs
Thread-Topic: [PATCH v3 1/3] acpi: add a helper for retrieving _OSC Control
 DWORDs
Thread-Index: AQHYRGISk6rNMu9emUmh1BOkO07P3azYSUOAgAARtIA=
Date:   Wed, 30 Mar 2022 20:08:06 +0000
Message-ID: <48dd8104149fe483d8b0b0e343b1e3c146eae339.camel@intel.com>
References: <20220330190443.GA1700287@bhelgaas>
In-Reply-To: <20220330190443.GA1700287@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-1.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 992cedd2-5eac-41c1-ff7d-08da128900f1
x-ms-traffictypediagnostic: SJ0PR11MB5614:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <SJ0PR11MB561478B8FD0A6CED2F9FD849C71F9@SJ0PR11MB5614.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3A2RCZc3YV3PGszF/fyzOUaBIFPlFU3q3KvLnVLSOL/8L3cWelHaJEAA89GycHKsOPPOBKDuzAL2vaA9fc1efAMZ7WUTw50AdD21h8OVu2Uq/XFO+9J9D3i+8GaDMkhp+7DZf1E/ZtQgy5n7g6v62PLTX/jmBAORkAn5NQvrymZwdDh3FBTv9N6nyScrmRGobCtpegnWQPbrSAHFpc9UgHRuf5XTMHClk5G8K9B9DtlnWrMWgZuXlt1w1i9zltDZ6uDkN5r2pUiSe4mHFGIrhtIyJo8YYxlftDzg53G9nnTf4WoHWMBPFhu/wukZ+ACL2QIiVCVPPV8f0IXaZIYoB4U+SQyE1awQ43rMeMOieUjj3H8LY0dkmeNaKbiGtJU6DDZkUdnjPR4DRtHvIdTCLr4pfWGK9eI31WlfIccWkugvaFvpRiuCx00e3BhemWHbO5fW9pXiU4nANP0o2/Rh9lxDloJjTmHKwH1ae/YD1G5QBKsnZlha9z/I3a9ZDC4HlcKWRThRkJXmrIReYT92QhJqkHgtNP/AZG6SIU3Dc7/IVgkgfRtJkC4BX93K6DZaf1CasdvzwmtbZCJt4kcC67g7jTvaYH99TEeMeDAgPcUSJOwJJSQGkckMOa0sPEaW+Hz4JhJ91ic7YWA8hOo1h6JHgqU1223Ecqw6RWK8+F0q7Atc9cEFOiXJ+A0BGbugz0dN9oKVvUSRddvP1BSxDA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(316002)(8676002)(38070700005)(4744005)(71200400001)(2906002)(82960400001)(86362001)(8936002)(508600001)(91956017)(64756008)(66556008)(66476007)(66446008)(76116006)(122000001)(66946007)(54906003)(6916009)(6486002)(5660300002)(186003)(26005)(38100700002)(6512007)(2616005)(6506007)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUdJMkVHRHN4T3NIUVk5VUdrb0UwV3dxRVRPdFRVQVlBMG5rTFk2UzVVU24y?=
 =?utf-8?B?cW8vL2xlaVdXSWJ1WVlKL2RhZytzRTIyRGMrVFZEcWVzUGJSVnJNM240OGt6?=
 =?utf-8?B?RFBZWU4vc2N5ODNKL1FEMDFUZmh4ME1QT1ptTUF1aGFxejZodE4wM0ZlVE4z?=
 =?utf-8?B?QmlxL29MbVZTVzgxSUFWbFM2RzNDKy8rZFNaRkxmdkE2MHdzdnkzYVp2dEpt?=
 =?utf-8?B?bFMrNUl2YlBCRDdFY2pWdkRQNC9qa1Znb21TK0lIREhsMXdjQnB2K3FwRisv?=
 =?utf-8?B?SjlXRU44Q2pSc1ZHUWFRQ1NLMjQxVk16azJRbHFwV0diUVpsL2tVRXFxRk1F?=
 =?utf-8?B?Rk9xVXFVS0M3ME9RNmgreHhMaWlnNFYwc0R5THZxZGxZVnJ0bW9OMkk4RGs3?=
 =?utf-8?B?L2d1WE5wc29neG54UkRrUFdmNmlrQXZyNFh2ZldNelc0bVpwRzMwWDlPTFZy?=
 =?utf-8?B?NU5BZ3AvRys0YTdQcElOQlFzcFQ3YitlWjdlQUc0cXBYK29PbkloYXVma1A0?=
 =?utf-8?B?SFBaUkRyRVhlcWttbWJsakh2c0ZhYzg4M25jM1NjVWtTQjRIVFlYM2NKcURK?=
 =?utf-8?B?UjdiS3VrOEg4ZGtSTnY1Q0ZTUGV3b0E5WkRlcVltTVFUcWxDbmVKRWh2WnVz?=
 =?utf-8?B?SmpMakpZUUQ4WnlwVXZRZVlsUjV0L1BaUzluRnFyMzJHNGoyMG5rbEg0ZERp?=
 =?utf-8?B?N1QxcjJtcWl2SkV1a3BDM0NPWWloT2dzK2NtUXNSWGE3Ym5ZZnE3OG54Q0wz?=
 =?utf-8?B?cEd0ZE13TGpHRGRhRDdVcW5XMFZrMDRuVWduRFdTT1F0R3k3SHZabUFlTWl3?=
 =?utf-8?B?TEFkOEZjK0xTVWpDSkNQRThLNWp1ZXFvNmdlQXBMbGp2NmxFRU1qc1NURC9J?=
 =?utf-8?B?SS9xWmRzdTFUa2FrTTlVRUZNd1NRdm5ibWJJVUxFT1RTcklqd01aUk9ETW9W?=
 =?utf-8?B?K1VsaEFKQ2NhMm5LQmtLbUtqWnczYzh6YzY1ZUk2YmlISjdHNWErd3haWS9O?=
 =?utf-8?B?dXhpdnNUbFUwa1VneXdTM2RzN0dFM2wzTVJhaFp1YXAwWjBrSnJ1K1dVZ0Ey?=
 =?utf-8?B?N2didkNlTTVIK3R6L1o3cXBtWlBZVU9VcE5XaWFjS2FaY0ZNaWt5cmIwZmF2?=
 =?utf-8?B?TlFFQjBUZHF3WDF4OUk3ODlrQ3VDYWowV2t3TmREY0EvdjE1MGhRbTduQUE0?=
 =?utf-8?B?amlGeDBrN003alZrbFZlVVJkRFFyaXNKODZFZmJENWFxcDZxTmd0UDVsL3Ry?=
 =?utf-8?B?NjZzM1ZOK0dKUHcvU0VZenhLUTQyOEM0OXZydUhCUTBHeE81eTRURGc3Zmpy?=
 =?utf-8?B?SEoyVmNKdnhDNjNZYUp4a0ZDT3N6L09KYXJPK2IvK3c5UG1ocmZ0blJpeTJh?=
 =?utf-8?B?elk0c0ZZTFQ2R2VFTFpDKzBRYlpkakZNTjErRUpRQ0pJUDhBSktvS3FyOFZt?=
 =?utf-8?B?QTMyZ2xLUElGdzFsYnZwOHpyUXVQNTNQVEg2bTBGUWJIc3NPa0pxNS85NFFs?=
 =?utf-8?B?VDFZTmhMNGdoT0ltZnR0aE00bUdOdEh2MlFONlg0UllVNTgzOFh2bXB1KzBO?=
 =?utf-8?B?V1NWRjBnWHE1OFhvMmIwaS81cFl0WU9ZT1YwQnROZzZXQ0pZcDZoR3pqaUcv?=
 =?utf-8?B?WUVpNW53WW9WcG1TMDRNYTJtaCtqcXA2R09jWkxtNWJpQUxEYlhkTG53OUJM?=
 =?utf-8?B?dVRSS0N5N2g1cXFmU1phVTBkVGlkWlBOS3VSNmJ6UHNRU1FsZnF0TXpaTnla?=
 =?utf-8?B?NWRPbGQ5eTNpWlAwQmVnVU13WXFsYVZjOWI0M2h1dTFrS1VxaEhDZXZka3Zn?=
 =?utf-8?B?T2pxQk5YWDAzdEtVVXVFUXZjajN2WWQ4c1d5YXBKM28yOUVtZzJVYXJOMVgr?=
 =?utf-8?B?ZXNPZVhHU3lUbXFUZ1gzcElCQ1RYR3pzNWNSV2wrbWhmRHVDOVN3WWU1cFp6?=
 =?utf-8?B?ZEVUSmxtU0hGMTBaeWRadGFIM3VQTFBpTmc3aVpjUUlnZXc3c3IrUm5sUlh4?=
 =?utf-8?B?QVR5K2ZhZFp5TzVZZENJL2QxaTdmc0ViVVhSMkg0QmRqYUwxaURCLzB6cFNu?=
 =?utf-8?B?Q3pyUXRhOXpZZGRZOFBDY3JVaXBNd3lRQi9qSERELy9iMUFFSG1UZXN3ODBN?=
 =?utf-8?B?bFQ4NExRMVhyNmtrODIyWllKdGtnVXliYWdSa3prNkpNdGZTVWhSK3BpdnAv?=
 =?utf-8?B?U1FIMGtTMmowZk1LeHhWSUo4TFFzQ3Y3Y0hpRytsY0h4bFVXSW9JSDJNZUZR?=
 =?utf-8?B?VUxrc1lEakkveDYxZGk5ZkNVbXJjZGlNV1ZDMDBHdnFrTEZoRU56NXEzbFFR?=
 =?utf-8?B?aHRmeFJRRk9KaDJqN3d0NkxhTEt4dGxyQXM3MnQyUVh2akQ3Ylc2NGRkRGNK?=
 =?utf-8?Q?0k2zsW34qHHO3n8g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9BAE8A4E179611428BC5AD1E11BE97D3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 992cedd2-5eac-41c1-ff7d-08da128900f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2022 20:08:06.1400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cfuGRdNPED0rzmDN6td6Qno9QIhfPFybb1zCf0bZMlh9rMgrZhBgLE8L7R8cE+TUNTsQxumsXp9Nt06d2TN6EeyLrLTriILkMzoFmJ7UsP4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5614
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

T24gV2VkLCAyMDIyLTAzLTMwIGF0IDE0OjA0IC0wNTAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiBMb29rIGF0IHByZXZpb3VzIHN1YmplY3QgbGluZXMgYW5kIGNvcHkgdGhlIHN0eWxlIGluc3Rl
YWQgb2YgbWFraW5nIHVwDQo+IHNvbWV0aGluZyBuZXcuDQoNClllcCB3aWxsIGZpeC4NCg0KPiAN
Cj4gT24gV2VkLCBNYXIgMzAsIDIwMjIgYXQgMTI6MTQ6MzJQTSAtMDYwMCwgVmlzaGFsIFZlcm1h
IHdyb3RlOg0KPiA+IER1cmluZyBfT1NDIG5lZ290aWF0aW9uLCB3aGVuIHRoZSAnQ29udHJvbCcg
RFdPUkQgaXMgbmVlZGVkIGZyb20gdGhlDQo+ID4gcmVzdWx0IGJ1ZmZlciBhZnRlciBydW5uaW5n
IF9PU0MsIGEgY291cGxlIG9mIHBsYWNlcyBwZXJmb3JtZWQgbWFudWFsDQo+ID4gcG9pbnRlciBh
cml0aG1ldGljIHRvIG9mZnNldCBpbnRvIHRoZSByaWdodCBzcG90IGluIHRoZSByYXcgYnVmZmVy
Lg0KPiA+IEFkZCBhIGFjcGlfb3NjX2N0eF9nZXRfcGNpX2NvbnRyb2woKSBoZWxwZXIgdG8gdXNl
IHRoZSAjZGVmaW5lJ2QNCj4gPiBEV09SRCBvZmZzZXRzIHRvIGZldGNoIHRoZSBEV09SRHMgbmVl
ZGVkIGZyb20gQGFjcGlfb3NjX2NvbnRleHQsIGFuZA0KPiA+IHJlcGxhY2UgdGhlIGFib3ZlIGlu
c3RhbmNlcyBvZiB0aGUgb3Blbi1jb2RlZCBhcml0aG1ldGljLg0KPiANCj4gQmpvcm4NCg0K
