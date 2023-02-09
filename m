Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10ABE691209
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Feb 2023 21:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjBIURn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 9 Feb 2023 15:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjBIURm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Feb 2023 15:17:42 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D955ACF8;
        Thu,  9 Feb 2023 12:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675973862; x=1707509862;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=90FsnP0F7hG+d53gINjAKM04BliNX9bPBfnMxgpAKC0=;
  b=NokZvQIr/+SNoDud02AMhWVmB/X7Qu9W2qTvpIDEXPBC5owV4zFbKxPV
   3syd0AmxNktLevoc7m2tFHUbcvRiVoda/t2P3OMcYBfMLDsEMtvny19XP
   HUnMr23yHjUwnsWRRid27nOiBL5QKRcrekxlRh3hnqWWTBCpdOUYr6bR6
   HUUk7BhNa/0faj7hGvHWqXryP2HmKICJ9aGDJY9Erg3bjNTcbaRGfbMCm
   rKa44JVlyztP1cfSKN8lDoxKjOBDI0BZAqOSWAWYEokik7Ux4oQdllB2N
   lfttFwsMJAX5GgwtyrfArpRo2GuPo/fRf/j8k+1IkrN9j+LDZOpW8I424
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="328868244"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="328868244"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 12:17:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="645389228"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="645389228"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 09 Feb 2023 12:17:41 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 9 Feb 2023 12:17:41 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 9 Feb 2023 12:17:40 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 9 Feb 2023 12:17:40 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 9 Feb 2023 12:17:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7vbxFsPbkrmQ4OVzXSSALQk15CgoO5Ap+6Zw1wFtDbk/Bo2hlG53vAqlB/5ov4hno2RBcg7lcMB3tvXnU+YRwyo7Qea4SFweTtFH8b31ZTSH9vQcdi2qlODCZmz36wJeTsFnDN3kaA4IwzEQ1fyrnKcpefz83Cmk/tWS3sUMvHaAj47A/JQ8h2qoXL177zZxushtKFiViK47oiZarywW8Oqvp+5pNrhA6clkMr6GXTz6MRjmYJGzqYAygUAcpwV6XYONSIDaqHblvPZU64JI8olfiM4rDFQUm5jjT4f8n8nBsNm7kUIeJRwzEmPopsETLYNyl5i14WvAIS3jPqzyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=90FsnP0F7hG+d53gINjAKM04BliNX9bPBfnMxgpAKC0=;
 b=KsilabjGc/daj4stZviANAMiC2axE0EwvbF7sK1t0+RL9X7uo8K3QluBcEUxPdWraJI3IRjRCipSvW8LU/m4f9Fp8rFeYt1elRyNZ8Q65s9y4I/deaoBOmL/3DEAK1SY9GZujR2Om2VAWdro3LQKqAxoj9xiAOWXOp44p/jBJgbI3Vz/Qt1M3KCLqe2eSB1dkflO1hnredBMHjpLkWRPvcGysheXM6Dp/E3g4GgboG7NW6VtTZwi5PnP1yvutX6Q4Lb7AoV9/QDj6VAvkHLbPJyWYP766SKxA12D1bk8huM1FUG4sCtdOZ4jAezZPyk70SETe27TMYBllgMsBHgdRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by BL3PR11MB6459.namprd11.prod.outlook.com (2603:10b6:208:3be::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Thu, 9 Feb
 2023 20:17:33 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::35af:d7a8:8484:627]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::35af:d7a8:8484:627%5]) with mapi id 15.20.6086.017; Thu, 9 Feb 2023
 20:17:33 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 09/18] cxl/region: Enable CONFIG_CXL_REGION to be toggled
Thread-Topic: [PATCH 09/18] cxl/region: Enable CONFIG_CXL_REGION to be toggled
Thread-Index: AQHZOcbXpMvn9Mt+mkad3GnYvaekna7HE4WA
Date:   Thu, 9 Feb 2023 20:17:33 +0000
Message-ID: <237c7fcb6ee895fc3e0c73f96ad1ed6f73b8bba8.camel@intel.com>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
         <167564539875.847146.16213498614174558767.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <167564539875.847146.16213498614174558767.stgit@dwillia2-xfh.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.3 (3.46.3-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB3999:EE_|BL3PR11MB6459:EE_
x-ms-office365-filtering-correlation-id: 24644c05-1e2d-4b5b-287a-08db0adaad79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e1WyBiJgzCkM8TQjizJEXzz+h1KSYAdgaItRXb2yAyzKJ51pTXazRQT8D14clMwxw5sxLj0V2FOQbUmAYb4TrqTbbMbm0LqzUG2fzIDOJdWXQcSiGLZKiRY4dBVwfohfCQce0LICSHzPLJyKMzcWKAjsdb+7OZzoxbTQs7p1VQUiBrJQJSmrOTHNUvW2EoDvKyVJsFBGq5WDWXbNfBidB2Nbv0NmlLLBnX3qXV4qmg8W8gjkwwr1/WTJOmZsYzXHPNTlVLXERloNwD/j8xcAQxeqSOHGHvFa06HyKVF7CzGj7Z6tn1b24TznYYrBuT+jCSy43CuMmhf5+yhq2Ng/D1BpoEFMkatx1g/zAjSvxd9eeb+myH7rEvTOKRooDZD9hSkL9e2OqD48PBZSMUcKYcqBTbkhbVDHHPfLDUT0le2YXYPe3KdLTCHaE4Htp0sPGM82WPavoHcVFECxM5uvuXTYR5vch0R4VTEXqRW8/auYlMQCS5qk1HhM5Bsn6R1MrY2TRPSW/wGtnCFEfMkiQVJXSHXw66Wiucm8sGSR9DXqKxTRcAdIoWeXs2JSmFE5Oib6svn068WO65BFBln3W2eClbpM39crB8IHpDLwiqOnw5uvy5v6id5vo+wC9gj1xp+5gC8YWcGPpY1n3YbqoZGtNrzVXNuzUwBeLPbOnCE54x92D4e1Mv6HAtRNZyRR87kXWsXRrf9j3Y89GceGMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199018)(6486002)(2906002)(2616005)(83380400001)(478600001)(64756008)(71200400001)(6512007)(26005)(36756003)(41300700001)(66446008)(66476007)(6506007)(66556008)(186003)(82960400001)(66946007)(122000001)(86362001)(38070700005)(38100700002)(316002)(4326008)(8676002)(54906003)(8936002)(5660300002)(110136005)(76116006)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aUpBVzJld2lxZXVUWXVwK3JiVXk3bUFYL1NJS1I4enF6aVNPekl4QnluZ2Fu?=
 =?utf-8?B?S1JHYUtEelhKSW54V0E3MGZpaXBjZ2ZEZGRhdm81TzNYWDgrclltb2tDcmZj?=
 =?utf-8?B?UnczVDkvTFNzem1xQjVJTEhTejlkMjB6cy8xOE5qc3k4Ny9CNmFxSGE4WFJG?=
 =?utf-8?B?SGVvZkdyc3ZKR0hndGhlUzNzTUJuclovNG1vYU9ER1JBU0pFYmZBVnk3L01q?=
 =?utf-8?B?VUh5bmNTWkdHWWFpaHJFVnAyQ3ZkMmVKZWlMeDkrdVptYm5YUVM5VVdady9Y?=
 =?utf-8?B?cFk2MkN6aW5PSlZmKzVnMUJJSldNTzFsQisyVmk4aEUrR2dOOGJLQnp3b0FH?=
 =?utf-8?B?SysyVmhDSU1LbkVkKzE1OG1DSGpWRXQzMTJ2Y243elRNTUFUbzdmQk4rdGJn?=
 =?utf-8?B?cjhqUDhwa0tvaVFHdzE3M0VVeFhrVXlOVGRnOVgyWlVmOGczVDFKcTlMbDY3?=
 =?utf-8?B?aytXckZoTlkzWU1MOGorTWhKNkJnTFBibzBjL3hobUJ1Mnc5SUVPeXdWa0lN?=
 =?utf-8?B?RUxESFhjU0RNZmxQU3BSYUJZQ0RTVlRaRDUvcGx1Qks2MUVmREFXMlYxZUFt?=
 =?utf-8?B?anpUL2NxcGNaTkFYNHRxZkF4MUdGSVdlU3hPeE1nWmQzMktoc2Ntb2VBdXNR?=
 =?utf-8?B?cHJMRXF4NVNFWm5QRzAyWS9LUmVsTk1wdGpzcXJFT0w4WGJFZU51VXVlS1Uv?=
 =?utf-8?B?WXlCQ0g1SDR6aUV3clAzK043V3NTeUtINThTWU9ySDhuUE85K2xhNTZJQVhj?=
 =?utf-8?B?NkVmV1M5MXd4T0pqWm9UUGU0UXkzUGpxZmZyaFR5T0xCMFp1M3k1cnRpR2t2?=
 =?utf-8?B?b05vaVE1OEZVOTgvakpPTlhFMXQrcjNuN2x6WWEzc2NYdzVDeFdlUThTME45?=
 =?utf-8?B?NWtqWml3L2YzeXR1S1ROQ3JSMHExMGNzVkM2NWZkMEpDbEx3NEM2eXBWeE5U?=
 =?utf-8?B?Mjc0SGVLN2FLeHZ2SlhiVjE0b2tVSGlmYS9rK2h5dUY4SDJ5SGRQRFZKWUFR?=
 =?utf-8?B?STkyQkdKNDFXZnNZOTVWTUxPd1NEd3QwL1NuTXFObis0QlpzR09yUEd6bzZE?=
 =?utf-8?B?czMxWCtsUWdtb3hvYU5OWXRaazVLY2E5NTdiaE9saVJnaVhwVi9kdGtlRGZK?=
 =?utf-8?B?OUlWWEwxVzVtZHBmSjVyTXRnMFhMajU0V3Fjc09DaEhJVGxuL0hHMUJ4NUl2?=
 =?utf-8?B?dFpZUkxpMG10RUE5ZUVPRU9ibVZpNkpCVkFoRGU3bUQzZXdYeHlpVzhsekxl?=
 =?utf-8?B?dnc0djNsYkVPSXZaeVdQYmpwaml5Q3drMHN3MnhhYzlOcnNVOCtkTEtmMWs1?=
 =?utf-8?B?TnJIc0h4VlMzcUR5QnVTNU01TUtNdGQrOEZQWmRVd0hKanVKR2xwMDhqcEdT?=
 =?utf-8?B?MXB5UXdqNnV4MjhmbDAxbmg5UXZnSGsxZVVUMWN2SXZ0S1hFZk5QWiswZTBZ?=
 =?utf-8?B?UWoyQ0xqVmNpQWlCdGdjS3U4bHVIcUhQeU5yeGlYT0lUd2VHMW4yUTRSK0dU?=
 =?utf-8?B?OWZJU3lKZ20xUnh3THRVL3NPL2lxcEdFRG83NGlWK2hQOW9oTFN4eGJ5bkdQ?=
 =?utf-8?B?N1UyRHdwdVAxRE91TW1JbVVLRTlBTU11TE1WUXNVbXpvTWZDekxWTkI5c3FL?=
 =?utf-8?B?TlRaRUdZSlNyMUZld1VXSnBsQ3RoSWFCRkhNVkpoWkYzZDBKY3lKdVRIOFU5?=
 =?utf-8?B?cTNtZENZb0RERjhGb2wrMVhOMHMwOUZGK3JEY3l4QUIzSmdhVllaYnZNT0Fj?=
 =?utf-8?B?dE5sWEpDdDhVQWI0Z1J3OUV4RTl2WmdXK1BnNXpZVmRsZzlUQU5ydUN1eENE?=
 =?utf-8?B?NVpxaFl6a0ZXdkFlNzc2RHNiSXBZeTRQT01DRU8wQWU4ZUkvQTdPaEdOYU5P?=
 =?utf-8?B?R3RQaUp0RDdjUUpZTHdPeU9wSVkxVXdSWm14NUJuNUVnTUtmek55b3BpcFlt?=
 =?utf-8?B?cFh2TmlMZnVvdkptUGRMNlZybTJmODdubU9ZYmZCc2o0bnJiV3d0YmNzNW45?=
 =?utf-8?B?S2UyRTVpdGV6b2N5dVlaeGZBZm14a0luT1F6cmh4Z1B1SFVxRDJrU01pSDdQ?=
 =?utf-8?B?aWVlSk0wcythMTluOWRXaUNiTFVzeHBDWGJ1VCt4WVRSaWNjcDc5azl5NWUw?=
 =?utf-8?B?WjJjYzZLNVdacGhYcnh6TTlDZUE4d3RjYzQ4Yk4zbnk0b0YvMUtvOGFaTnRs?=
 =?utf-8?B?alE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F7B93C64E4A5B9408E49188EE79269A2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24644c05-1e2d-4b5b-287a-08db0adaad79
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2023 20:17:33.1979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f47V8qYG8gGSfyxgr2na8q2QU2/JsKJ1QY3F62BvgI26FtVF8tvMFuqJ3osHGQg5orD6INrX0BwO8P3nFMtbZYFTwzksRUJcnVP82CthfKY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6459
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

T24gU3VuLCAyMDIzLTAyLTA1IGF0IDE3OjAzIC0wODAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
IEFkZCBoZWxwIHRleHQgYW5kIGEgbGFiZWwgc28gdGhlIENYTF9SRUdJT04gY29uZmlnIG9wdGlv
biBjYW4gYmUNCj4gdG9nZ2xlZC4gVGhpcyBpcyBtYWlubHkgdG8gZW5hYmxlIGNvbXBpbGUgdGVz
dGluZyB3aXRob3V0IHJlZ2lvbg0KPiBzdXBwb3J0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRGFu
IFdpbGxpYW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+DQo+IC0tLQ0KPiDCoGRyaXZlcnMv
Y3hsL0tjb25maWcgfMKgwqAgMTIgKysrKysrKysrKystDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDEx
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2N4bC9LY29uZmlnIGIvZHJpdmVycy9jeGwvS2NvbmZpZw0KPiBpbmRleCAwYWM1M2M0MjJjMzEu
LjE2M2MwOTRlNjdhZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9jeGwvS2NvbmZpZw0KPiArKysg
Yi9kcml2ZXJzL2N4bC9LY29uZmlnDQo+IEBAIC0xMDQsMTIgKzEwNCwyMiBAQCBjb25maWcgQ1hM
X1NVU1BFTkQNCj4gwqDCoMKgwqDCoMKgwqDCoGRlcGVuZHMgb24gU1VTUEVORCAmJiBDWExfTUVN
DQo+IMKgDQo+IMKgY29uZmlnIENYTF9SRUdJT04NCj4gLcKgwqDCoMKgwqDCoMKgYm9vbA0KPiAr
wqDCoMKgwqDCoMKgwqBib29sICJDWEw6IFJlZ2lvbiBTdXBwb3J0Ig0KPiDCoMKgwqDCoMKgwqDC
oMKgZGVmYXVsdCBDWExfQlVTDQo+IMKgwqDCoMKgwqDCoMKgwqAjIEZvciBNQVhfUEhZU01FTV9C
SVRTDQo+IMKgwqDCoMKgwqDCoMKgwqBkZXBlbmRzIG9uIFNQQVJTRU1FTQ0KPiDCoMKgwqDCoMKg
wqDCoMKgc2VsZWN0IE1FTVJFR0lPTg0KPiDCoMKgwqDCoMKgwqDCoMKgc2VsZWN0IEdFVF9GUkVF
X1JFR0lPTg0KPiArwqDCoMKgwqDCoMKgwqBoZWxwDQo+ICvCoMKgwqDCoMKgwqDCoMKgIEVuYWJs
ZSB0aGUgQ1hMIGNvcmUgdG8gZW51bWVyYXRlIGFuZCBwcm92aXNpb24gQ1hMIHJlZ2lvbnMuIEEg
Q1hMDQo+ICvCoMKgwqDCoMKgwqDCoMKgIHJlZ2lvbiBpcyBkZWZpbmVkIGJ5IG9uZSBvciBtb3Jl
IENYTCBleHBhbmRlcnMgdGhhdCBkZWNvZGUgYSBnaXZlbg0KPiArwqDCoMKgwqDCoMKgwqDCoCBz
eXN0ZW0tcGh5c2ljYWwgYWRkcmVzcyByYW5nZS4gRm9yIENYTCByZWdpb25zIGVzdGFibGlzaGVk
IGJ5DQo+ICvCoMKgwqDCoMKgwqDCoMKgIHBsYXRmb3JtLWZpcm13YXJlIHRoaXMgb3B0aW9uIGVu
YWJsZXMgbWVtb3J5IGVycm9yIGhhbmRsaW5nIHRvDQoNCnVubmVjZXNzYXJ5LWh5cGhlbmF0aW9u
Pw0KDQpCdXQgcmVnYXJkbGVzcywNCg0KUmV2aWV3ZWQtYnk6IFZpc2hhbCBWZXJtYSA8dmlzaGFs
LmwudmVybWFAaW50ZWwuY29tPg0KDQoNCj4gK8KgwqDCoMKgwqDCoMKgwqAgaWRlbnRpZnkgdGhl
IGRldmljZXMgcGFydGljaXBhdGluZyBpbiBhIGdpdmVuIGludGVybGVhdmVkIG1lbW9yeQ0KPiAr
wqDCoMKgwqDCoMKgwqDCoCByYW5nZS4gT3RoZXJ3aXNlLCBwbGF0Zm9ybS1maXJtd2FyZSBtYW5h
Z2VkIENYTCBpcyBlbmFibGVkIGJ5IGJlaW5nDQo+ICvCoMKgwqDCoMKgwqDCoMKgIHBsYWNlZCBp
biB0aGUgc3lzdGVtIGFkZHJlc3MgbWFwIGFuZCBkb2VzIG5vdCBuZWVkIGEgZHJpdmVyLg0KPiAr
DQo+ICvCoMKgwqDCoMKgwqDCoMKgIElmIHVuc3VyZSBzYXkgJ3knDQo+IMKgDQo+IMKgY29uZmln
IENYTF9SRUdJT05fSU5WQUxJREFUSU9OX1RFU1QNCj4gwqDCoMKgwqDCoMKgwqDCoGJvb2wgIkNY
TDogUmVnaW9uIENhY2hlIE1hbmFnZW1lbnQgQnlwYXNzIChURVNUKSINCj4gDQo+IA0KDQo=
