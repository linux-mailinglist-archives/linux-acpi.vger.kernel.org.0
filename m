Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B0E4DE35E
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Mar 2022 22:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236573AbiCRVSN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Mar 2022 17:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234158AbiCRVSL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Mar 2022 17:18:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667D31AF535;
        Fri, 18 Mar 2022 14:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647638211; x=1679174211;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KTVHbAegf7Ob9kqTeux72HmVIE+fumDnm0hXZAobdoo=;
  b=idRD/AzcHrqpad2/ff3mWEdFNJAwsR1vCbkN/1EhTpwlTS/bq+GC1iFO
   EmHi6o5gPKFG9Mt65cAbludW0C8j4CKhXelQAdbKYMLLQgURtwMPKjHNC
   nutKtLpzry8xt0cFnx3XYWvnuegAlQ0Q7ZGbN9W5LS8S46mITptNpGHe9
   mjCDoW1omLkdnlHui9gDki+3j8VjS6m7mexZ1DpJp9y11/Sfcs/uPwDZj
   SucCG0eKwOxTLkT7DD+KbEquSPg/OD+HDBEMXjX57u1S9d/F9tVGNzA/0
   Iz7x/y8CI+LT8jfZz/47IGbMLqgwxQSw5EfgyvVbuDi89DZZYFOr5JJ2W
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="257422986"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="257422986"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 14:16:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="715657470"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 18 Mar 2022 14:16:40 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 14:16:39 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Fri, 18 Mar 2022 14:16:39 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Fri, 18 Mar 2022 14:16:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KnQ/7S22o0LMcR1Loni4TIjfawSFrZkhMIug/M5hgYMuFFwJz8ob0YJuSu+02yvWGuHIlYqXeVXskWAxrRetx/bhmIxnjOApRaevInqanBzKikp/HlOoA67NiF45mO7Al417NQ05mH3B0BsMn9QiUn4/nXKRw5mpWINLU+EZQ2C4ZEGgjEtD3e+EBtMuaug7Q9F2VzGHdD0+z+Sfhq0Bh6Pw7bhF+aapV7BzpyjgRj1+MtJ4Kfn2bMt1OcN6YT6re3tWfg7sPGcSNO5XTK9gSwMeHF0bK7iSr9Fm0HuG92x/tYjAJqK1H34NWrM0fyVFRktZOA9CKq7lCTUzYzNMCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTVHbAegf7Ob9kqTeux72HmVIE+fumDnm0hXZAobdoo=;
 b=XPc/AMofHEKHuCOu4qhlRLt6Ylmn+Ro3eZlzcR1IJPr+eK1Bhic4rY7irIRGJHyIJiEqfJkFqFGtlUn28NEVXpoIzKyqZiOsZ1sRJAz+wUfayT7tCyQD8pZTFa4YwgULwlZXq/hmdnvpDnDRm/HYkuNF4NmOyNrZu+jYRB8R3cjvK4bj6AQnwwFHRK3Ohr6I71HMxiHwAV6WK8REiLzQCq3ZRWnhmFZBbtWMuJkGb938xrhKAtZehCkSVbM37o0BCacyfO60aoXluqGW9pdXduxT/tn8uAX5WLfkXTzL5n9s6se/NyANXOGzoPRp1S0WtORNuyIPRyx59Lw5jxYAaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by BN7PR11MB2756.namprd11.prod.outlook.com (2603:10b6:406:b4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Fri, 18 Mar
 2022 21:16:38 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::d898:84ee:d6a:4eb1]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::d898:84ee:d6a:4eb1%6]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 21:16:37 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Moore, Robert" <robert.moore@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [RFC PATCH 2/2] acpi/pci_root: negotiate CXL _OSC
Thread-Topic: [RFC PATCH 2/2] acpi/pci_root: negotiate CXL _OSC
Thread-Index: AQHYOZXEX0UItFxD/USR0kvjsLOzz6zDv8UAgAHn9IA=
Date:   Fri, 18 Mar 2022 21:16:37 +0000
Message-ID: <21213e7ebf5667a25a19ca0c7b64e6fb4652463d.camel@intel.com>
References: <20220317002704.1835870-1-vishal.l.verma@intel.com>
         <20220317002704.1835870-3-vishal.l.verma@intel.com>
         <20220317161008.00005f07@Huawei.com>
In-Reply-To: <20220317161008.00005f07@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-1.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 468d7f60-7b13-4d66-be11-08da092496c2
x-ms-traffictypediagnostic: BN7PR11MB2756:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <BN7PR11MB2756D6246CB69ED77F03F00EC7139@BN7PR11MB2756.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hYez2gQf3EsBy7xCee5OIU5UEvQ/FVRf0xPLxGiio/yILB2TYkmhMh1tgBj/lbwnJEbtWBMNlERWwrn36jmEdYyF0lRnxSC3cYXH7uteVDC5awqunGCvnPKRaiiOlPpOtH6HCd0oJlUKMtbf+JbuofGhzP1x17zRm4mS7XVs/wWufnxmVT5Mvlb2+6Ws9/2kZKdqifhAFxokMQG9cLQ1gll6kQqw13wbkXFN0DJ1W+3rI4CVZHKPs+VCNLPBiDv2mMjjQhNnDWqnviQsrn42uuGav6BgMgkvp4k6vrkIvcW/mDkfAnLzN0CEjXIVxgk/UWvz8BkXDT4w5X/nzQaptLSLa4/hG0GviGoghmHlcnskbY/p2AJWmHQgHWlTeHX5l/+Z2Oo4NWBdEMyLlGcn9b8BU20U+3Y2nySYDQl2okKSyU5WuUGFbWU5YnZHFG0K935Ja9b4SlXqiLaAcpNssfE+q4JDhkY4VHjCvFvMzQzS6LptXCvUEERTFRwUWSHPBaRxLf0S+9SBn1HBqgCI2S59EXkdL/QeeXR5Reaeu+fcAy0w8Bg3tuO0nYDZQzlAroM1rkXJiZW9l5ICoPFD3HHevoQoA8oLPBp2KWuE+NXHTvHEJeNLUvMNgv8ffpSep0z9qQmImowCQhHhdUa35YJcE4Uw4qlbe63uesjiFH4CsFB//rS7OqYDhKL3I3m0FZVW4C4TpW9MhK3KWrnQkQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(26005)(186003)(2616005)(64756008)(8676002)(4326008)(66476007)(66446008)(66556008)(91956017)(6916009)(38070700005)(66946007)(76116006)(86362001)(2906002)(5660300002)(8936002)(508600001)(316002)(71200400001)(6486002)(122000001)(6506007)(82960400001)(6512007)(36756003)(38100700002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXhqMnFENTFiYXVPbHB1RWg5Z2ZrNjJ5bjRDOERKUmpUMURVazdFcmd1WllR?=
 =?utf-8?B?bHpick5kK0pJeXEwQ3RvY01tekJjNVNzRFJOVG4vVVRxVWZRN3ZraW5RaWN6?=
 =?utf-8?B?TFNxdHJxTzRIQUlGY3plODlaNkVFNkhqVHltclMxclZCWC9Gd0E3UFpobkNQ?=
 =?utf-8?B?TTMvQnV4U2xXNEgrSWlDZzZRTE91ajBSZlU1SE16Znpac2tpZExILzJrYzFv?=
 =?utf-8?B?VHFVdnJPSnZJOVlFWGxuSnhXamlQR1B2UjhKMG9JbWJwOUNyZWdhalZGcmt4?=
 =?utf-8?B?Wnc5VVhFZkFnQWN2MXFWMnZwSlM3eHBPTEtFUmJqUUoxUEVMdEx2T1dKMktQ?=
 =?utf-8?B?U2FQMFdBeWZlakJ3eW5zbWFPZVFnUkU4M1JhUUJjZjhqb09hcFFjbXBydzdE?=
 =?utf-8?B?Z2pvRlNVb2d6N0RaNERFWGR0Y0YycHNLWG9RNUJxdGFCMXU0NVh0bzY1S0JH?=
 =?utf-8?B?Si9qQTZEVDJCWlkzNlUyNERyNFRDZnk4K21tRk96ay85T2VTeU9YbDBVcGh2?=
 =?utf-8?B?WUhWQXhMd0lBRXg5ZVIrdjAwNlROYWI3dm9TMlJUcS9FSHdUcjFMQ0tEUEJq?=
 =?utf-8?B?NUlxV1MwK0ttUDRlWmQxeHg5WUFoK2RodDdDQXJoRmp4SkdGVE5EcUdZYnl3?=
 =?utf-8?B?eFJCTzR6dTZYWnV1VnNTVG00UFp6MkpuZVB3MU1KbVp1dHpSRVBjRTVXdVpu?=
 =?utf-8?B?MWpoQnRLTGQzK093YWJKK1BtWmpaQnIxczJISHAxSzkraDhCa1ArWklzd0lH?=
 =?utf-8?B?blEzOUh1Z25TSXk5WVV5V3F1NE9UMVZreDdveUNjRS9WblJ2VVFmdEdXOXNF?=
 =?utf-8?B?NktqRHJTdmtRZ1ZKVnhYQWQwdm9TNDFYeVRqREFsRGhaK0JQMW1ERzJXTURv?=
 =?utf-8?B?eWxDQThkQ3AyQ0gzMXRMbDFoOUJtM2RHZUczaFpFOXBxcUlJRGUyN3dNNDdK?=
 =?utf-8?B?MXl3SzZHWElXQmtseVdVdUNsQ25xazRKLzMyWjRSZHFsOXI4RkR0ckxQVTNR?=
 =?utf-8?B?Z2ZaS1NJSHQ1bkFoTTB4NWRob1JGNHQ0SkV4U3FLRmJtc0tERnJHbmJNaHVn?=
 =?utf-8?B?RE5HOUFjYUlmbHUzWEJkSTJFT1RmZUl3YjVrUzBhOUdmaXVpL0g5cEY0OG1p?=
 =?utf-8?B?a245M0hhOUJSc0hqalBGYkhGd3YxMEFUYnlzUGkzOGhFWXB0S3ZWbXZucVlW?=
 =?utf-8?B?K1NUUSt1OFRZZ3FQL3JwdWErZGZzdTFvWmJROG1uWVVNTERnRmdCYXlNWWFB?=
 =?utf-8?B?YVp3K0FaVWkrcm5qa2Q2UU5zcEdPb0J6cXZrSjVkZUJGMjBZU0pwWVc0VlZK?=
 =?utf-8?B?RTJ4dlVPNGp6a1pkWW1tbUoxZjh4VFJoeHQ2cUdrUG82d3o1dHhqWHh5MWtz?=
 =?utf-8?B?QzN2RmhyQ3BVRmJRUWdqNlE4OUN4M0t2aUxXTTFQbUVzVFlFa2V6ZmZpNDMy?=
 =?utf-8?B?dEpocit6bEQ3bHh6cE9HTjM2UUphWk9XTFAvWWMvRVROWllCRG53ZVlJTFBN?=
 =?utf-8?B?YjNzOFZuOUhrRTBDZVRVTHZLM3RHVk5zUUdiUzd2dEZEOTBsWERTeUlQQk5w?=
 =?utf-8?B?aytXdk1BVjJ0RmpITUVMOVB6c0JKN3FHOGdac1NQR3hCQzBBc1ZaQ0N0R3dn?=
 =?utf-8?B?SDBBbnUwVnhGUStmQzlMT2VQVThuckVJcWNBeXFVU2w3UnhSUzZtSkordTV6?=
 =?utf-8?B?NVFxdkhoMkhobnZJaEZob1BQaTg2MEFJdGMrZCtzT1dpa293LzU0NjZuUFJt?=
 =?utf-8?B?SVFpSk43MFJqYzZMWEk3ekNhd3YrUjJRSCtVL1VQdjFoY01QaHFqYkxPQWIz?=
 =?utf-8?B?bVZPbmR1bHFXWis5U1JZMGlqTTB5YllqV3cxMFZ3UmdPemRaL2JDUjcxTm5p?=
 =?utf-8?B?WDJPMmk5K1JOQnVTUHhORWpIcVhEZkptYkNueDI3M0svZmF4cjBkUmpJTk1l?=
 =?utf-8?B?RWlzZkp3bmFuMzlrUlRiZ2daRUVZaGZUT3pkRkF1N1VhY1pxSmw1TDR6T3VX?=
 =?utf-8?B?YU5qWHlMUUt3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE51CB7829764643AFCF91C0483E975E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 468d7f60-7b13-4d66-be11-08da092496c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 21:16:37.8070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xF9j4/qsRWnzuIXgLgpTwN39lVNE+RR1QtytGBPcARnaXb3n9HwU62ZMt8mBR9xE9s0E9XpSwzTApm1PlzFA0dGIJXhtsdpaFR/QPJvtqp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2756
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

T24gVGh1LCAyMDIyLTAzLTE3IGF0IDE2OjEwICswMDAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Ogo+IE9uIFdlZCwgMTYgTWFyIDIwMjIgMTg6Mjc6MDQgLTA2MDAKPiBWaXNoYWwgVmVybWEgPHZp
c2hhbC5sLnZlcm1hQGludGVsLmNvbT4gd3JvdGU6Cj4gCj4gPiBBZGQgZnVsbCBzdXBwb3J0IGZv
ciBuZWdvdGlhdGluZyBfT1NDIGFzIGRlZmluZWQgaW4gdGhlIENYTCAyLjAgc3BlYywgYXMKPiA+
IGFwcGxpY2FibGUgdG8gQ1hMLWVuYWJsZWQgcGxhdGZvcm1zLiBBZHZlcnRpc2Ugc3VwcG9ydCBm
b3IgdGhlIENYTAo+ID4gZmVhdHVyZXMgd2Ugc3VwcG9ydCAtICdDWEwgMi4wIHBvcnQvZGV2aWNl
IHJlZ2lzdGVyIGFjY2VzcycsICdQcm90b2NvbAo+ID4gRXJyb3IgUmVwb3J0aW5nJywgYW5kICdD
TCBOYXRpdmUgSG90IFBsdWcnLiBSZXF1ZXN0IGNvbnRyb2wgZm9yICdDWEwKPiA+IE1lbW9yeSBF
cnJvciBSZXBvcnRpbmcnLiBUaGUgcmVxdWVzdHMgYXJlIGRlcGVuZGVudCBvbiBDT05GSUdfKiBi
YXNlZAo+ID4gcHJlLXJlcXVpc2l0ZXMsIGFuZCBwcmlvciBQQ0kgZW5hYmxpbmcsIHNpbWlsYXIg
dG8gaG93IHRoZSBzdGFuZGFyZCBQQ0kKPiA+IF9PU0MgYml0cyBhcmUgZGV0ZXJtaW5lZC4KPiA+
IAo+ID4gQ2M6IEJqb3JuIEhlbGdhYXMgPGJoZWxnYWFzQGdvb2dsZS5jb20+Cj4gPiBDYzogIlJh
ZmFlbCBKLiBXeXNvY2tpIiA8cmFmYWVsQGtlcm5lbC5vcmc+Cj4gPiBDYzogUm9iZXJ0IE1vb3Jl
IDxyb2JlcnQubW9vcmVAaW50ZWwuY29tPgo+ID4gQ2M6IERhbiBXaWxsaWFtcyA8ZGFuLmoud2ls
bGlhbXNAaW50ZWwuY29tPgo+ID4gU2lnbmVkLW9mZi1ieTogVmlzaGFsIFZlcm1hIDx2aXNoYWwu
bC52ZXJtYUBpbnRlbC5jb20+Cj4gSGkgVmlzaGFsLAo+IAo+IEEgZmV3IG1pbm9yIHF1ZXJpZXMg
aW5saW5lLgo+IAo+IEpvbmF0aGFuCgpUaGFua3MgZm9yIHJldmlld2luZyBKb25hdGhhbiAtIGZp
eGVkIHVwIG1vc3Qgb2YgdGhlIHRoaW5ncywgc2VlIGJlbG93LgoKPiAKWy4uXQo+ID4gwqAKPiA+
ICtzdGF0aWMgdTMyIGFjcGlfb3NjX2N0eF9nZXRfcGNpX2NvbnRyb2woc3RydWN0IGFjcGlfb3Nj
X2NvbnRleHQgKmNvbnRleHQpCj4gPiArewo+ID4gK8KgwqDCoMKgwqDCoMKgcmV0dXJuICooKHUz
MiAqKShjb250ZXh0LT5yZXQucG9pbnRlciArIDgpKTsKPiAKPiBVc2UgdGhlIGRlZmluZXMgZm9y
IHRoZSBvZmZzZXRzPyBzaXplb2YodTMyKSAqIE9TQ19DT05UUk9MX0RXT1JEIGZvciBleGFtcGxl
Cj4gCj4gPiArfQo+ID4gKwo+ID4gK3N0YXRpYyB1MzIgYWNwaV9vc2NfY3R4X2dldF9jeGxfY29u
dHJvbChzdHJ1Y3QgYWNwaV9vc2NfY29udGV4dCAqY29udGV4dCkKPiA+ICt7Cj4gPiArwqDCoMKg
wqDCoMKgwqByZXR1cm4gKigodTMyICopKGNvbnRleHQtPnJldC5wb2ludGVyICsgMTYpKTsKPiAK
PiBBcyBhYm92ZSArIHNpemVvZih1MzIpICogT1NDX0NYTF9DT05UUk9MX0RXT1JEKQoKTWFrZXMg
c2Vuc2UsIGRvbmUuCgo+IAo+ID4gK30KPiA+ICsKPiA+IMKgc3RhdGljIGFjcGlfc3RhdHVzIGFj
cGlfcGNpX3J1bl9vc2Moc3RydWN0IGFjcGlfcGNpX3Jvb3QgKnJvb3QsCj4gPiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgY29uc3QgdTMyICpjYXBidWYsIHUzMiAqcmV0dmFsKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnN0
IHUzMiAqY2FwYnVmLCB1MzIgKnBjaV9jb250cm9sLAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHUzMiAqY3hs
X2NvbnRyb2wpCj4gPiDCoHsKPiA+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgYWNwaV9vc2NfY29u
dGV4dCBjb250ZXh0ID0gewo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAudXVp
ZF9zdHIgPSB0b191dWlkKHJvb3QpLAo+ID4gQEAgLTIxMiwxOCArMjQ2LDIwIEBAIHN0YXRpYyBh
Y3BpX3N0YXR1cyBhY3BpX3BjaV9ydW5fb3NjKHN0cnVjdCBhY3BpX3BjaV9yb290ICpyb290LAo+
ID4gwqAKPiA+IMKgwqDCoMKgwqDCoMKgwqBzdGF0dXMgPSBhY3BpX3J1bl9vc2Mocm9vdC0+ZGV2
aWNlLT5oYW5kbGUsICZjb250ZXh0KTsKPiA+IMKgwqDCoMKgwqDCoMKgwqBpZiAoQUNQSV9TVUND
RVNTKHN0YXR1cykpIHsKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAqcmV0dmFs
ID0gKigodTMyICopKGNvbnRleHQucmV0LnBvaW50ZXIgKyA4KSk7Cj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgKnBjaV9jb250cm9sID0gYWNwaV9vc2NfY3R4X2dldF9wY2lfY29u
dHJvbCgmY29udGV4dCk7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKGlz
X2N4bChyb290KSkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgKmN4bF9jb250cm9sID0gYWNwaV9vc2NfY3R4X2dldF9jeGxfY29udHJvbCgmY29udGV4
dCk7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGtmcmVlKGNvbnRleHQucmV0
LnBvaW50ZXIpOwo+ID4gwqDCoMKgwqDCoMKgwqDCoH0KPiA+IMKgwqDCoMKgwqDCoMKgwqByZXR1
cm4gc3RhdHVzOwo+ID4gwqB9Cj4gPiDCoAo+ID4gLXN0YXRpYyBhY3BpX3N0YXR1cyBhY3BpX3Bj
aV9xdWVyeV9vc2Moc3RydWN0IGFjcGlfcGNpX3Jvb3QgKnJvb3QsCj4gPiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgdTMyIHN1cHBvcnQsCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdTMyICpjb250
cm9sKQo+ID4gK3N0YXRpYyBhY3BpX3N0YXR1cyBhY3BpX3BjaV9xdWVyeV9vc2Moc3RydWN0IGFj
cGlfcGNpX3Jvb3QgKnJvb3QsIHUzMiBzdXBwb3J0LAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1MzIg
KmNvbnRyb2wsIHUzMiBjeGxfc3VwcG9ydCwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdTMyICpjeGxf
Y29udHJvbCkKPiA+IMKgewo+ID4gwqDCoMKgwqDCoMKgwqDCoGFjcGlfc3RhdHVzIHN0YXR1czsK
PiA+IC3CoMKgwqDCoMKgwqDCoHUzMiByZXN1bHQsIGNhcGJ1Zls2XTsKPiA+ICvCoMKgwqDCoMKg
wqDCoHUzMiBwY2lfcmVzdWx0LCBjeGxfcmVzdWx0LCBjYXBidWZbOF07Cj4gCj4gTmljZSB0byBz
ZXQgY2FwYnVmIHNpemUgb2ZmIG9uZSBvZiB0aGUgZGVmaW5lcyBpZiBwb3NzaWJsZSwgdGhvdWdo
IEknbSBub3QKPiBzdXJlIHdoeSBpdCBpcyA4IChvciB3aHkgaXQgd2FzIDYgYmVmb3JlIGZvciB0
aGF0IG1hdGVyKS7CoCBJIHRoaW5rIGl0IHNob3VsZCBiZSA1LgoKWWVwLCBJJ20gbm90IHN1cmUg
d2h5IHRoZXNlIHdlcmUgNi4gSSd2ZSBhZGRlZCBhIG5ldyBkZWZpbmUgYW5kIHNldCBpdAp0byA1
LiBQZXJoYXBzIHNvbWVvbmUgZnJvbSBBQ1BJIG1pZ2h0IGNvbW1lbnQgaWYgdGhlcmUgd2FzIGEg
cmVhc29uIGZvcgp0aGUgZXh0cmEgcGFkZGluZy4gUmFmYWVsIG9yIFJvYmVydD8KCj4gCj4gPiDC
oAo+ID4gwqDCoMKgwqDCoMKgwqDCoHN1cHBvcnQgfD0gcm9vdC0+b3NjX3N1cHBvcnRfc2V0Owo+
ID4gwqAKPiA+IEBAIC0yMzEsMTEgKzI2NywyMSBAQCBzdGF0aWMgYWNwaV9zdGF0dXMgYWNwaV9w
Y2lfcXVlcnlfb3NjKHN0cnVjdCBhY3BpX3BjaV9yb290ICpyb290LAo+ID4gwqDCoMKgwqDCoMKg
wqDCoGNhcGJ1ZltPU0NfU1VQUE9SVF9EV09SRF0gPSBzdXBwb3J0Owo+ID4gwqDCoMKgwqDCoMKg
wqDCoGNhcGJ1ZltPU0NfQ09OVFJPTF9EV09SRF0gPSAqY29udHJvbCB8IHJvb3QtPm9zY19jb250
cm9sX3NldDsKPiA+IMKgCj4gPiArwqDCoMKgwqDCoMKgwqBpZiAoaXNfY3hsKHJvb3QpKSB7Cj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY3hsX3N1cHBvcnQgfD0gcm9vdC0+Y3hs
X29zY19zdXBwb3J0X3NldDsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjYXBi
dWZbT1NDX0NYTF9TVVBQT1JUX0RXT1JEXSA9IGN4bF9zdXBwb3J0Owo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGNhcGJ1ZltPU0NfQ1hMX0NPTlRST0xfRFdPUkRdID0gKmN4bF9j
b250cm9sIHwgcm9vdC0+Y3hsX29zY19jb250cm9sX3NldDsKPiA+ICvCoMKgwqDCoMKgwqDCoH0K
PiA+ICsKPiA+IMKgcmV0cnk6Cj4gPiAtwqDCoMKgwqDCoMKgwqBzdGF0dXMgPSBhY3BpX3BjaV9y
dW5fb3NjKHJvb3QsIGNhcGJ1ZiwgJnJlc3VsdCk7Cj4gPiArwqDCoMKgwqDCoMKgwqBzdGF0dXMg
PSBhY3BpX3BjaV9ydW5fb3NjKHJvb3QsIGNhcGJ1ZiwgJnBjaV9yZXN1bHQsICZjeGxfcmVzdWx0
KTsKPiA+IMKgwqDCoMKgwqDCoMKgwqBpZiAoQUNQSV9TVUNDRVNTKHN0YXR1cykpIHsKPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcm9vdC0+b3NjX3N1cHBvcnRfc2V0ID0gc3Vw
cG9ydDsKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAqY29udHJvbCA9IHJlc3Vs
dDsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAqY29udHJvbCA9IHBjaV9yZXN1
bHQ7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKGlzX2N4bChyb290KSkg
ewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByb290
LT5jeGxfb3NjX3N1cHBvcnRfc2V0ID0gY3hsX3N1cHBvcnQ7Cj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCpjeGxfY29udHJvbCA9IGN4bF9yZXN1bHQ7
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQo+ID4gwqDCoMKgwqDCoMKgwqDC
oH0gZWxzZSBpZiAoaXNfY3hsKHJvb3QpKSB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoC8qCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIENYTCBfT1ND
IGlzIG9wdGlvbmFsIG9uIENYTCAxLjEgaG9zdHMuIEZhbGwgYmFjayB0byBQQ0llIF9PU0MKPiA+
IEBAIC0zNTgsNiArNDA0LDggQEAgRVhQT1JUX1NZTUJPTF9HUEwoYWNwaV9nZXRfcGNpX2Rldik7
Cj4gPiDCoCAqIEBoYW5kbGU6IEFDUEkgaGFuZGxlIG9mIGEgUENJIHJvb3QgYnJpZGdlIChvciBQ
Q0llIFJvb3QgQ29tcGxleCkuCj4gPiDCoCAqIEBtYXNrOiBNYXNrIG9mIF9PU0MgYml0cyB0byBy
ZXF1ZXN0IGNvbnRyb2wgb2YsIHBsYWNlIHRvIHN0b3JlIGNvbnRyb2wgbWFzay4KPiA+IMKgICog
QHN1cHBvcnQ6IF9PU0Mgc3VwcG9ydGVkIGNhcGFiaWxpdHkuCj4gPiArICogQGN4bF9tYXNrOiBN
YXNrIG9mIENYTCBfT1NDIGNvbnRyb2wgYml0cywgcGxhY2UgdG8gc3RvcmUgY29udHJvbCBtYXNr
Lgo+ID4gKyAqIEBjeGxfc3VwcG9ydDogQ1hMIF9PU0Mgc3VwcG9ydGVkIGNhcGFiaWxpdHkuCj4g
PiDCoCAqCj4gPiDCoCAqIFJ1biBfT1NDIHF1ZXJ5IGZvciBAbWFzayBhbmQgaWYgdGhhdCBpcyBz
dWNjZXNzZnVsLCBjb21wYXJlIHRoZSByZXR1cm5lZAo+ID4gwqAgKiBtYXNrIG9mIGNvbnRyb2wg
Yml0cyB3aXRoIEByZXEuwqAgSWYgYWxsIG9mIHRoZSBAcmVxIGJpdHMgYXJlIHNldCBpbiB0aGUK
PiA+IEBAIC0zNjgsMTIgKzQxNiwxNCBAQCBFWFBPUlRfU1lNQk9MX0dQTChhY3BpX2dldF9wY2lf
ZGV2KTsKPiA+IMKgICogX09TQyBiaXRzIHRoZSBCSU9TIGhhcyBncmFudGVkIGNvbnRyb2wgb2Ys
IGJ1dCBpdHMgY29udGVudHMgYXJlIG1lYW5pbmdsZXNzCj4gPiDCoCAqIG9uIGZhaWx1cmUuCj4g
PiDCoCAqKi8KPiA+IC1zdGF0aWMgYWNwaV9zdGF0dXMgYWNwaV9wY2lfb3NjX2NvbnRyb2xfc2V0
KGFjcGlfaGFuZGxlIGhhbmRsZSwgdTMyICptYXNrLCB1MzIgc3VwcG9ydCkKPiA+ICtzdGF0aWMg
YWNwaV9zdGF0dXMgYWNwaV9wY2lfb3NjX2NvbnRyb2xfc2V0KGFjcGlfaGFuZGxlIGhhbmRsZSwg
dTMyICptYXNrLAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1MzIgc3VwcG9ydCwg
dTMyICpjeGxfbWFzaywKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdTMyIGN4bF9z
dXBwb3J0KQo+ID4gwqB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgdTMyIHJlcSA9IE9TQ19QQ0lfRVhQ
UkVTU19DQVBBQklMSVRZX0NPTlRST0w7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IGFjcGlf
cGNpX3Jvb3QgKnJvb3Q7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgYWNwaV9zdGF0dXMgc3RhdHVzOwo+
ID4gLcKgwqDCoMKgwqDCoMKgdTMyIGN0cmwsIGNhcGJ1Zls2XTsKPiA+ICvCoMKgwqDCoMKgwqDC
oHUzMiBjdHJsLCBjeGxfY3RybCwgY2FwYnVmWzhdOwo+IAo+IEFzIGFib3ZlLCB3aHkgOD8KPiAK
PiA+IMKgCj4gPiDCoMKgwqDCoMKgwqDCoMKgaWYgKCFtYXNrKQo+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gQUVfQkFEX1BBUkFNRVRFUjsKPiA+IEBAIC0zODUsMjAg
KzQzNSwzNSBAQCBzdGF0aWMgYWNwaV9zdGF0dXMgYWNwaV9wY2lfb3NjX2NvbnRyb2xfc2V0KGFj
cGlfaGFuZGxlIGhhbmRsZSwgdTMyICptYXNrLCB1MzIgcwo+ID4gwqDCoMKgwqDCoMKgwqDCoGN0
cmzCoMKgID0gKm1hc2s7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgKm1hc2sgfD0gcm9vdC0+b3NjX2Nv
bnRyb2xfc2V0Owo+ID4gwqAKPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChpc19jeGwocm9vdCkpIHsK
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjeGxfY3RybMKgwqAgPSAqY3hsX21h
c2s7Cj4gCj4gT2RkIHNwYWNpbmcKCkZpeGVkLgoKCg==
