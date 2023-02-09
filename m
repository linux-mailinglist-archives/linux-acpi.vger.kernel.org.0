Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F27168FBED
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Feb 2023 01:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjBIAWz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Feb 2023 19:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjBIAWy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Feb 2023 19:22:54 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3662203C;
        Wed,  8 Feb 2023 16:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675902173; x=1707438173;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gm2Hw4TPOlYbTuA4sjlH6vhYhXIMEdEdTESEYj5fIF4=;
  b=Wu5arf90lJmYc/P9kX8BzJUmeDmfKbuOAngv3N3MG/i6j7DDfro0mBsS
   LdJY+B+AvPLbvR2EGkqygyFAIc5v6gZvNvGJYRe7QU1bXDiDC1kvJT28n
   qu+omONqh6gNtXD+5OlVOxVuyw9P88JoFCwv7FJR691VLYwcZqZkjRcDw
   2BaJpMJEeeR0mwhfx2xGe9Rln2VyBFrK81N+Pniw/hi8uIVE+CQODv0ZJ
   aO9Hu5zeiOeAgm7hc0vBjW0b8VqmiMH6go7WwBOB+dLxj8pODxaIOkBZB
   DFsRUAMX9Mn276jk/D2b120HtlyqT5jGlT4u5WHhy4E5poQeUBOUH6Ycr
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="313604618"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="313604618"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 16:22:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="731063387"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="731063387"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 08 Feb 2023 16:22:51 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 16:22:50 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 8 Feb 2023 16:22:50 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 8 Feb 2023 16:22:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nk/frKsv7hEwLw9Xel40++JsBodo/Qi2HHzdo+8bdPzIk5isLA4Up7+avWmAT+Cx/fZaZHFLP+/x5TA5S8AaBpV1Hd1KOeiHY7vwWYnIQOGdL1LhSGh4IpEqv2L4Lvxs6kYukvf5vvos4UQ6qHvouyE093ZKV7zZg5QIQ5RNsNHWRyJ9+k159ajXvJPc1cI1BhQedlpuZrxXhoZnL4WHCSumBMiq2wjVWkMzxFezUzPU8wOKgAQY4y64oJnxSzT1EQNGvp3v8Z/P8Sot0hmVYWQLBiLFgmditAce+B8s35B6HRcF/ONYWOvol86YcC+fOSdcEBrB0By+hwliSNRtXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gm2Hw4TPOlYbTuA4sjlH6vhYhXIMEdEdTESEYj5fIF4=;
 b=SpIBoRd9vJ1HLHTBNBEa+fDjVwwsr4qyP7xSq9KJvde3Unk0KQsLLJVbzLTOqxqgGh/vY2tFScz0KrsC2ulOdwKL4bW0d3ocs1tF6zmKXeF2qLCksKddQEJZFWSV4v851kTDk/PxIsapoJpSkuCqwdjcJm45decv4AXNE0xJf41xYmEqqmRR/vMVVfDJ35mVMciL0pUakN0uaJTsgI9cCQOdIa+GP6UspYdmW7qPfYTcz6ZOIOM20yE0FyweKUWeWz0I59lsFQVEu8dobsdhf6xnLKnulOwcRkHVDriOFnUEMh9Qvi1h/ImMvjSDUSUbIVMERXkN64QaSpZfYq0qrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by SA2PR11MB4907.namprd11.prod.outlook.com (2603:10b6:806:111::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 00:22:48 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::35af:d7a8:8484:627]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::35af:d7a8:8484:627%5]) with mapi id 15.20.6086.017; Thu, 9 Feb 2023
 00:22:48 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 02/18] cxl/region: Add a mode attribute for regions
Thread-Topic: [PATCH 02/18] cxl/region: Add a mode attribute for regions
Thread-Index: AQHZOcbB8uBeV4MYmEeb4nCDLe0kNK7FxbYA
Date:   Thu, 9 Feb 2023 00:22:48 +0000
Message-ID: <c386ba8551ca28f530199f544e2e7648b85800fb.camel@intel.com>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
         <167564536041.847146.11330354943211409793.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <167564536041.847146.11330354943211409793.stgit@dwillia2-xfh.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.3 (3.46.3-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB3999:EE_|SA2PR11MB4907:EE_
x-ms-office365-filtering-correlation-id: e12ab8f7-43fd-452f-3084-08db0a33c617
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dYk9oETlio/sP/LxxZY3out11DMFZQ1/J8jE10tlfaPuoFYv301v5wrvwWkthRPrNiiPh1QTEPfrJAoVPHgBU8U6O2wA8iu3Xr5JUhofjJzO7j+Osi63BgmKyElwNxPS8JZeX1xLcbcU0auByuZRskZz9Ei7j1ucVkWD2hYSiV41PVwCWHkXyjPSQVnGD//p8IMXkWab/IQ/X2ps87SYt6blgEJRRh9Y2sUx2jLxejuGUIDt7XWCUvn1AflJedei4Bzh6LViQQU1vlt08yL+JCKSae2jNPjfa0m06g38GojIO6yaYgARAUGP2EpPxGmozCf952rV3vm0X8hJGPrx4nln9gsrvgqB6QOTnLOAGYHvZoWz69L+vt1MNnLwtTcdKu/MIGquYA5Ap2aNNABVI7Vc6FXA/cHYGN27qkL07jHdU+clwlAgCdAk6jnO4rJfYR4dw/+g1rtdIjByLoKGwUoM68oKWK/gu6EoN6psr/INRb05onoiWdHDlQPZPRYIv6lSkiqPD+k01EfzbRVRfuqn23LvxqPDIvTfJmdPCCDSFnI+U2uafE+AqkOXNaQXg1sZwG3Mihxw1wg+YgcTi0n6jJ53J1p/ZH2PkRV7QZCnb5Mjn6s4BCJS9kLPnEnTFqtH+dukOqJnspkaX3/QgcTMZS4n+OSkX4LgeZ+w+iL4HygfAFrpbjgMpf+yf3zFnQ077dmPMiiYwvzabMA2/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199018)(38070700005)(5660300002)(86362001)(8936002)(122000001)(26005)(186003)(6512007)(2616005)(38100700002)(83380400001)(76116006)(91956017)(54906003)(110136005)(316002)(41300700001)(66946007)(8676002)(64756008)(66446008)(66476007)(66556008)(4326008)(82960400001)(478600001)(6506007)(71200400001)(6486002)(36756003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXlka0plUHpISFJRUDRNSnJKZ1BVY3g1YWdoSng1Znk3alVsOGw3MjNGNFRG?=
 =?utf-8?B?YWEyMVN2UjNRN0Z2aG5MYXZrQlNaR1A0ZGhkK0I4T0M4QXZob3lIWUZ0VWV0?=
 =?utf-8?B?ZTZ4MUNBeHh4R0c4cTRlOVJRNysxenlSblBDK25DdDhqWDMramxmeXc1MG9v?=
 =?utf-8?B?THBTTTRUbEp1L0lSTnJVMlZZTE9jYzZlVDdiMVpTMVc2ZHNMSlBZRDBUTk1x?=
 =?utf-8?B?SXlxbnJ5eWg1TGZiUVF4ZHU0a0FFU2dxMU1uclBvbzdLNm9ETWFBb0xRWXFY?=
 =?utf-8?B?OHYwRmx4ZCszODZ5dUx6emZrZVkwcGczdlcrNmhYT2hwaU9xZFFmcW1nWUJk?=
 =?utf-8?B?NjVtNnZmcGoxcnBQNFRlTExZYzBYTFJaTmk2NldPa1BWR09jQ3l4Y2RhQnZk?=
 =?utf-8?B?dWlCQm5pbDdwcGEvMWR3Z3JTUlAxTHQ1dHA1L2lNTVNqKzNnbWdOMlpCeldk?=
 =?utf-8?B?d3dCV1FWaTZvRkxUY0dVbzV3dGZpZy9Va1BHVWNUakpZcm5QbCsvQ0lNLzho?=
 =?utf-8?B?SEpDVEJrOGx6MTh2L0hOK1ZUa2lGTzhpQU9IVTB3VmVDblM5Z3h0ZEkrcmRJ?=
 =?utf-8?B?WDhwczhCWW1nRXZwOVRkVEdrajZXNUJ5bWtRUWtUTTBFdUZxdmdjVHFoYjBx?=
 =?utf-8?B?TVNWenpFWUdBRlpKTU1WLzJycEhtYW1TTGQ3UVFGcEFtQ2Z2OXNadUlrTExG?=
 =?utf-8?B?WjZzMmEyVWlrTjdCMFdRMXNHblBDWjA1N2RrMisrS2pKSUc1bitGSWtsUkRs?=
 =?utf-8?B?dmluU3BaV2xLeHFYS1Z5TU5pbEtVNU0wUkdWa0lsdjB6MWFQcE1sYmhkYko1?=
 =?utf-8?B?dFkxL215YUE2R09uZDk1YlRUVzZncHFhL29WR1dudFRaZnZLZWdyYkg5cUdo?=
 =?utf-8?B?Zjk5d2YvdklwSlFHZGNUQ090UmtIaGIzMFdCaTR1SGUzSzBpaFFJYTlpRU1q?=
 =?utf-8?B?Q1A0cHh2U2NrWHhZeWRidnRnVS9XKzVPc1NaZ0MxekxjRnIrS2cxa0UycDAz?=
 =?utf-8?B?aWo0eFJtSk1qMEZTVlNPY0x3eU1neEN0T1NWdGhMQXU4SkJvdFVLUm9VTERJ?=
 =?utf-8?B?cXRlbEMvOHpISUNUaTJRYyt1OEdSSis0SjhnZ0IzUEduVFhYMG16eVN3NmRP?=
 =?utf-8?B?RXJKdFByZURaV1A4VE8yWXM5VTNUNWZCa3RMY3J3bEhsdUF2ZEFkb1ZTVm5G?=
 =?utf-8?B?SHZnTlAvN1BXWmxhQjQ0SmNZYjFkblBwNlRUa24wOEVEVHZobG1QakRLWnlu?=
 =?utf-8?B?WEpRdDN2dEdHa2htSmhlUHQrWjBpZndub2M2TUtBdmM1Z3I3cDJQaGlTbitQ?=
 =?utf-8?B?ekhtcEY2RmhGQ29CcFhPKzhPNytUREpuUm9VdjdjL1ovN3RMcG1PSjcvWnJt?=
 =?utf-8?B?bWJoZzdibXREQ093VmR5NkU5ZlV3OS9LNHZhMEZ6ZkY2TTlNeVFuWWtLektv?=
 =?utf-8?B?dnVWejFFOXBKczY1L1hvMlBIMzc2RTR5bktqUkt2eEtycjF2VjhoN2NSQjVo?=
 =?utf-8?B?bkxMbmowNDhUNHNXNTl4bVNUS0Fka1JDMU9Zb25hYVZwaWtHK25iWXNuQVZT?=
 =?utf-8?B?Nm8yNDdlL1pmemZRbE16Q2pqeGZ6Wkt2RW5BdGtIQklzaWNEQlF3Snl4YzRO?=
 =?utf-8?B?emE4TzEwWGtyVlljUVhMV1hRcVRzRGJlUXlpcVpJVzRseXJma2pRUkVLdHFT?=
 =?utf-8?B?b0dZempMTURVNXVPWHZZWjJZbFZnSStQVnh6YmFwSS9PWFlRZjRYMk44Ry82?=
 =?utf-8?B?YjBQbWY3VjBUcVk0ckRNYWRKV1RwUGd4L1BKdTZObkNITitLUnhTNHpBS0Rz?=
 =?utf-8?B?OGFhUU43Q2FqSUo3dUJyeWdZRWZ6SnduRGRza3RkYllkWmlZNkdHWW9JVHVp?=
 =?utf-8?B?UitSNmMwRUJBNVMvSDhVMUYvdTJWSHZ2ZGNCcmhtUEZUeUxsbzllQllKdnNo?=
 =?utf-8?B?a1pKR0RnWnkwMytSQWRuS0Y4d2ZJTm5iZFAvMWJCRTY5S01QNDYvZTVrTEZM?=
 =?utf-8?B?L2JNVHdBaWxLekxNdjZxSTlXQTFsemd0K1lnSkUwUENhMWVtS0N4cU5JWkJs?=
 =?utf-8?B?Mk4wa0RpZXF1WXVIUktiSVZnRkUxRnk3MHNuM21neEVFa0o4OHUwWXJUWU15?=
 =?utf-8?B?eEMyZmZGWThNbHpHbVN1dS9HeldNTVYyNnNwM2Q4eUhFZGFOcFZVQ2ZTZi9r?=
 =?utf-8?B?bEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9DA9C3C89120414AB0BEDF130CBB2E15@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e12ab8f7-43fd-452f-3084-08db0a33c617
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2023 00:22:48.5919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bZq+HOMVvYZSxjKlxrHVNJwbDZOp6RHUiZlm48ACVPdUPtnkk74Y9drEtBEZ1r4/37yee4o6Uoe1BMJMP7gpUsqBH1Bm14VX2HIj1clG62s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4907
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

T24gU3VuLCAyMDIzLTAyLTA1IGF0IDE3OjAyIC0wODAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6Cj4g
SW4gcHJlcGFyYXRpb24gZm9yIGEgbmV3IHJlZ2lvbiB0eXBlLCAicmFtIiByZWdpb25zLCBhZGQg
YSBtb2RlCj4gYXR0cmlidXRlIHRvIGNsYXJpZnkgdGhlIG1vZGUgb2YgdGhlIGRlY29kZXJzIHRo
YXQgY2FuIGJlIGFkZGVkIHRvIGEKPiByZWdpb24uIFNoYXJlIHRoZSBpbnRlcm5hbHMgb2YgbW9k
ZV9zaG93KCkgKGZvciBkZWNvZGVycykgd2l0aCB0aGUKPiByZWdpb24gY2FzZS4KPiAKPiBTaWdu
ZWQtb2ZmLWJ5OiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4KPiAtLS0K
PiDCoERvY3VtZW50YXRpb24vQUJJL3Rlc3Rpbmcvc3lzZnMtYnVzLWN4bCB8wqDCoCAxMSArKysr
KysrKysrKwo+IMKgZHJpdmVycy9jeGwvY29yZS9wb3J0LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB8wqDCoCAxMiArLS0tLS0tLS0tLS0KPiDCoGRyaXZlcnMvY3hsL2NvcmUvcmVn
aW9uLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDEwICsrKysrKysrKysKPiDC
oGRyaXZlcnMvY3hsL2N4bC5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfMKgwqAgMTQgKysrKysrKysrKysrKysKPiDCoDQgZmlsZXMgY2hhbmdlZCwgMzYgaW5z
ZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pCgpMb29rcyBnb29kLCB0aGFua3MgZm9yIGFkZGlu
ZyB0aGlzIC0gbWFrZXMgbGliY3hsJ3Mgam9iIG11Y2ggZWFzaWVyIQoKUmV2aWV3ZWQtYnk6IFZp
c2hhbCBWZXJtYSA8dmlzaGFsLmwudmVybWFAaW50ZWwuY29tPgoKPiAKPiBkaWZmIC0tZ2l0IGEv
RG9jdW1lbnRhdGlvbi9BQkkvdGVzdGluZy9zeXNmcy1idXMtY3hsCj4gYi9Eb2N1bWVudGF0aW9u
L0FCSS90ZXN0aW5nL3N5c2ZzLWJ1cy1jeGwKPiBpbmRleCA1YmUwMzIzMTNlMjkuLjA1OGIwYzQ1
MDAxZiAxMDA2NDQKPiAtLS0gYS9Eb2N1bWVudGF0aW9uL0FCSS90ZXN0aW5nL3N5c2ZzLWJ1cy1j
eGwKPiArKysgYi9Eb2N1bWVudGF0aW9uL0FCSS90ZXN0aW5nL3N5c2ZzLWJ1cy1jeGwKPiBAQCAt
MzU4LDYgKzM1OCwxNyBAQCBEZXNjcmlwdGlvbjoKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHJlc3VsdHMgaW4gdGhlIHNhbWUgYWRkcmVzcyBiZWluZyBhbGxvY2F0ZWQuCj4gwqAK
PiDCoAo+ICtXaGF0OsKgwqDCoMKgwqDCoMKgwqDCoMKgL3N5cy9idXMvY3hsL2RldmljZXMvcmVn
aW9uWi9tb2RlCj4gK0RhdGU6wqDCoMKgwqDCoMKgwqDCoMKgwqBKYW51YXJ5LCAyMDIzCj4gK0tl
cm5lbFZlcnNpb246wqB2Ni4zCj4gK0NvbnRhY3Q6wqDCoMKgwqDCoMKgwqBsaW51eC1jeGxAdmdl
ci5rZXJuZWwub3JnCj4gK0Rlc2NyaXB0aW9uOgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAoUk8pIFRoZSBtb2RlIG9mIGEgcmVnaW9uIGlzIGVzdGFibGlzaGVkIGF0IHJlZ2lvbgo+
IGNyZWF0aW9uIHRpbWUKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYW5kIGRpY3Rh
dGVzIHRoZSBtb2RlIG9mIHRoZSBlbmRwb2ludCBkZWNvZGVyIHRoYXQKPiBjb21wcmlzZSB0aGUK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmVnaW9uLiBGb3IgbW9yZSBkZXRhaWxz
IG9uIHRoZSBwb3NzaWJsZSBtb2RlcyBzZWUKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgL3N5cy9idXMvY3hsL2RldmljZXMvZGVjb2RlclguWS9tb2RlCj4gKwo+ICsKPiDCoFdoYXQ6
wqDCoMKgwqDCoMKgwqDCoMKgwqAvc3lzL2J1cy9jeGwvZGV2aWNlcy9yZWdpb25aL3Jlc291cmNl
Cj4gwqBEYXRlOsKgwqDCoMKgwqDCoMKgwqDCoMKgTWF5LCAyMDIyCj4gwqBLZXJuZWxWZXJzaW9u
OsKgdjYuMAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2N4bC9jb3JlL3BvcnQuYyBiL2RyaXZlcnMv
Y3hsL2NvcmUvcG9ydC5jCj4gaW5kZXggNDEwYzAzNmMwOWZhLi44NTY2NDUxY2IyMmYgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy9jeGwvY29yZS9wb3J0LmMKPiArKysgYi9kcml2ZXJzL2N4bC9jb3Jl
L3BvcnQuYwo+IEBAIC0xODAsMTcgKzE4MCw3IEBAIHN0YXRpYyBzc2l6ZV90IG1vZGVfc2hvdyhz
dHJ1Y3QgZGV2aWNlICpkZXYsCj4gc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsCj4gwqB7
Cj4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBjeGxfZW5kcG9pbnRfZGVjb2RlciAqY3hsZWQgPQo+
IHRvX2N4bF9lbmRwb2ludF9kZWNvZGVyKGRldik7Cj4gwqAKPiAtwqDCoMKgwqDCoMKgwqBzd2l0
Y2ggKGN4bGVkLT5tb2RlKSB7Cj4gLcKgwqDCoMKgwqDCoMKgY2FzZSBDWExfREVDT0RFUl9SQU06
Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBzeXNmc19lbWl0KGJ1Ziwg
InJhbVxuIik7Cj4gLcKgwqDCoMKgwqDCoMKgY2FzZSBDWExfREVDT0RFUl9QTUVNOgo+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gc3lzZnNfZW1pdChidWYsICJwbWVtXG4i
KTsKPiAtwqDCoMKgwqDCoMKgwqBjYXNlIENYTF9ERUNPREVSX05PTkU6Cj4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBzeXNmc19lbWl0KGJ1ZiwgIm5vbmVcbiIpOwo+IC3C
oMKgwqDCoMKgwqDCoGNhc2UgQ1hMX0RFQ09ERVJfTUlYRUQ6Cj4gLcKgwqDCoMKgwqDCoMKgZGVm
YXVsdDoKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHN5c2ZzX2VtaXQo
YnVmLCAibWl4ZWRcbiIpOwo+IC3CoMKgwqDCoMKgwqDCoH0KPiArwqDCoMKgwqDCoMKgwqByZXR1
cm4gc3lzZnNfZW1pdChidWYsICIlc1xuIiwgY3hsX2RlY29kZXJfbW9kZV9uYW1lKGN4bGVkLQo+
ID5tb2RlKSk7Cj4gwqB9Cj4gwqAKPiDCoHN0YXRpYyBzc2l6ZV90IG1vZGVfc3RvcmUoc3RydWN0
IGRldmljZSAqZGV2LCBzdHJ1Y3QKPiBkZXZpY2VfYXR0cmlidXRlICphdHRyLAo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2N4bC9jb3JlL3JlZ2lvbi5jIGIvZHJpdmVycy9jeGwvY29yZS9yZWdpb24u
Ywo+IGluZGV4IDYwODI4ZDAxOTcyYS4uMTdkMmQwYzEyNzI1IDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvY3hsL2NvcmUvcmVnaW9uLmMKPiArKysgYi9kcml2ZXJzL2N4bC9jb3JlL3JlZ2lvbi5jCj4g
QEAgLTQ1OCw2ICs0NTgsMTUgQEAgc3RhdGljIHNzaXplX3QgcmVzb3VyY2Vfc2hvdyhzdHJ1Y3Qg
ZGV2aWNlICpkZXYsCj4gc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsCj4gwqB9Cj4gwqBz
dGF0aWMgREVWSUNFX0FUVFJfUk8ocmVzb3VyY2UpOwo+IMKgCj4gK3N0YXRpYyBzc2l6ZV90IG1v
ZGVfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlCj4gKmF0
dHIsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2hh
ciAqYnVmKQo+ICt7Cj4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IGN4bF9yZWdpb24gKmN4bHIgPSB0
b19jeGxfcmVnaW9uKGRldik7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoHJldHVybiBzeXNmc19lbWl0
KGJ1ZiwgIiVzXG4iLCBjeGxfZGVjb2Rlcl9tb2RlX25hbWUoY3hsci0KPiA+bW9kZSkpOwo+ICt9
Cj4gK3N0YXRpYyBERVZJQ0VfQVRUUl9STyhtb2RlKTsKPiArCj4gwqBzdGF0aWMgaW50IGFsbG9j
X2hwYShzdHJ1Y3QgY3hsX3JlZ2lvbiAqY3hsciwgcmVzb3VyY2Vfc2l6ZV90IHNpemUpCj4gwqB7
Cj4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBjeGxfcm9vdF9kZWNvZGVyICpjeGxyZCA9IHRvX2N4
bF9yb290X2RlY29kZXIoY3hsci0KPiA+ZGV2LnBhcmVudCk7Cj4gQEAgLTU4NSw2ICs1OTQsNyBA
QCBzdGF0aWMgc3RydWN0IGF0dHJpYnV0ZSAqY3hsX3JlZ2lvbl9hdHRyc1tdID0gewo+IMKgwqDC
oMKgwqDCoMKgwqAmZGV2X2F0dHJfaW50ZXJsZWF2ZV9ncmFudWxhcml0eS5hdHRyLAo+IMKgwqDC
oMKgwqDCoMKgwqAmZGV2X2F0dHJfcmVzb3VyY2UuYXR0ciwKPiDCoMKgwqDCoMKgwqDCoMKgJmRl
dl9hdHRyX3NpemUuYXR0ciwKPiArwqDCoMKgwqDCoMKgwqAmZGV2X2F0dHJfbW9kZS5hdHRyLAo+
IMKgwqDCoMKgwqDCoMKgwqBOVUxMLAo+IMKgfTsKPiDCoAo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2N4bC9jeGwuaCBiL2RyaXZlcnMvY3hsL2N4bC5oCj4gaW5kZXggYWEzYWYzYmI3M2IyLi5jYTc2
ODc5YWYxZGUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9jeGwvY3hsLmgKPiArKysgYi9kcml2ZXJz
L2N4bC9jeGwuaAo+IEBAIC0zMjAsNiArMzIwLDIwIEBAIGVudW0gY3hsX2RlY29kZXJfbW9kZSB7
Cj4gwqDCoMKgwqDCoMKgwqDCoENYTF9ERUNPREVSX0RFQUQsCj4gwqB9Owo+IMKgCj4gK3N0YXRp
YyBpbmxpbmUgY29uc3QgY2hhciAqY3hsX2RlY29kZXJfbW9kZV9uYW1lKGVudW0KPiBjeGxfZGVj
b2Rlcl9tb2RlIG1vZGUpCj4gK3sKPiArwqDCoMKgwqDCoMKgwqBzdGF0aWMgY29uc3QgY2hhciAq
IGNvbnN0IG5hbWVzW10gPSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoFtDWExf
REVDT0RFUl9OT05FXSA9ICJub25lIiwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
W0NYTF9ERUNPREVSX1JBTV0gPSAicmFtIiwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgW0NYTF9ERUNPREVSX1BNRU1dID0gInBtZW0iLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBbQ1hMX0RFQ09ERVJfTUlYRURdID0gIm1peGVkIiwKPiArwqDCoMKgwqDCoMKgwqB9
Owo+ICsKPiArwqDCoMKgwqDCoMKgwqBpZiAobW9kZSA+PSBDWExfREVDT0RFUl9OT05FICYmIG1v
ZGUgPD0gQ1hMX0RFQ09ERVJfTUlYRUQpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oHJldHVybiBuYW1lc1ttb2RlXTsKPiArwqDCoMKgwqDCoMKgwqByZXR1cm4gIm1peGVkIjsKPiAr
fQo+ICsKPiDCoC8qKgo+IMKgICogc3RydWN0IGN4bF9lbmRwb2ludF9kZWNvZGVyIC0gRW5kcG9p
bnTCoCAvIFNQQSB0byBEUEEgZGVjb2Rlcgo+IMKgICogQGN4bGQ6IGJhc2UgY3hsX2RlY29kZXJf
b2JqZWN0Cj4gCj4gCgo=
