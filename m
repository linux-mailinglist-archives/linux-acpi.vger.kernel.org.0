Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5288068FC6F
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Feb 2023 02:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjBIBKG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Feb 2023 20:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjBIBKF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Feb 2023 20:10:05 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3399F23865;
        Wed,  8 Feb 2023 17:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675905002; x=1707441002;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FOBfu3j9lYZtpxe7WRRVVTb4NGeyf90st1pCp6FEh8M=;
  b=L++nC9X5Om0uFgyRao7cTP/WBCTqzcx5SVbsCLKF307HUiLIUzBsXKtZ
   hQdthQrysQ82pYICZWb/i4SyoGINjRyc2Wh8CO+i7H0VbG18c8sj15QBU
   p1Wn6KH+w9p6v8g2TI9scxQDVuk56Bq/hylWRmtWvBxMn23asEn85g6mr
   KEhn1gkMYAVx7ii71ZMCVF5Xxc/Nr+DTwK/Qj+KmZhK6ebAyVIjRSHBpT
   A7y5hdIF1GTuC/Bzj2+Ubbh7EcIZOZAk3rek7EKGfPBuZNvlUWMVCAiUl
   HTWyQKRVspIF32o2J2b/CJZRs7DYJ+XY3nQcM6AwDFtavksJtZBa6n87J
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="330004319"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="330004319"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 17:10:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="699869007"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="699869007"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 08 Feb 2023 17:10:01 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 17:10:01 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 8 Feb 2023 17:10:00 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 8 Feb 2023 17:10:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ICpaAeW2xOniOzCh7GKzBLh+y5lU37BBOY2dB5qgjwE410iy+X4OcESTtTRKOPNcnnQQdbYKyV0kZu8RdD5+CVtOpa1WZlDiDaiKjpD4Ws93wQdfZMFcsusYWN4lu8C78bVbornAk6nrharKEkJJeNsH0+xl8kpSVg1ylIQjIpIL2EizZLPHMTJxY9lGts6tqgViEWJ4ur69jV9EZsJW+m8PcGXNekyvQrtSPFP5jN2H/ZWtAe8BZQxR6qvxiAJpZXQ8KrvEiTtoX9t1CWjY8eRR70GDVJn5aic3495VXGrk28h/BzT75B80bh4KST+oFV01iz4Bon/ozeBkermELQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FOBfu3j9lYZtpxe7WRRVVTb4NGeyf90st1pCp6FEh8M=;
 b=ENXLH+98KmSzIc56qjerbn2W6GE7XjM0PNBObAPj5/e/mWhvcjfYCySQCkICY5kjpZscmJiTT2G2EDZTHyEgMYAYBR5bZri/jmewzTz6Bk/2IzTYqB6jYCEyLc3043SaeVLQ0uI5cdotZIPF+AGY5jbk7grUTlmRsAY4/6RbPenTpeWICxutC9ZUN/at8ww1SQDa+FP4EHpavNNXRE9yBqKTFzCkYsaks4+q0JDLWNIsxMt0Ps4eaGRNe8KI3XkOd7xY44I8VqFN232vfiWJGI/6hfW7j+OlNThsPTu1KT5yLKJ5rAQNexPjxjonRPHko5gbjY8OOApll6Mv/kbjGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by PH7PR11MB8124.namprd11.prod.outlook.com (2603:10b6:510:237::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Thu, 9 Feb
 2023 01:09:57 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::35af:d7a8:8484:627]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::35af:d7a8:8484:627%5]) with mapi id 15.20.6086.017; Thu, 9 Feb 2023
 01:09:57 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 06/18] cxl/region: Refactor attach_target() for
 autodiscovery
Thread-Topic: [PATCH 06/18] cxl/region: Refactor attach_target() for
 autodiscovery
Thread-Index: AQHZOcbK6Q+N2PgP40iew/GIpwX2Eq7F0uKA
Date:   Thu, 9 Feb 2023 01:09:57 +0000
Message-ID: <0f7a7987fe09c74ca63500c19769de0a1b65eee8.camel@intel.com>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
         <167564538227.847146.16305045998592488364.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <167564538227.847146.16305045998592488364.stgit@dwillia2-xfh.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.3 (3.46.3-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB3999:EE_|PH7PR11MB8124:EE_
x-ms-office365-filtering-correlation-id: 8c87344b-bdca-4b0d-b5cc-08db0a3a5c1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zunUUv4YxdzvsDlhlPsiMqgXctI3856jjUrdsdF6JQY/T9FfOwkIGWnzqs/3wHMwHwO0AfLzgkv8oiCO8Hk2Q5gh809AtKbtgGwexJOy3spGGPh5G21syKArzfEC62KbbcS+tlF7WyBmF6x6lGitQyPQqelzHj6+8pDkrHMlVrYGGz/TvcEiqpY58Fb3ytyB3wwBYue08gGmljYUcb0tGkHgnGAUCxKHRWXILPMlVmiCiyL9xnEMtjOWdxHyd8oTIEr9ahRZNvvEpbEIEZMZlyRAK9IH6XJHe/KuDk2j1TNBdaHZOuAVNJ/R6B89cGzL+Fvfk1SyVZdLiC/9ypV0OpWl6Zm8Jxx3lSix2pyX3prrhV34QlzUSRZAtWIFqS+ovwKKocncLooyIAyN4zlJ1o/uKXLzf8tPoyeUZpDn77ErVTMFGcLYFwDS5fPXZwgj887Mxgt1sf4DbD5mAPMd7JHcPsxTdJQbYv9EXASbFpbvWIGS28DQ+0iUnXsTk+hAqVIqQx4Hdc4knGxyDyizaFJB4lKZyJoCtWhipKmxG81sI1dbuyFAGKBjQJK1oh8dVHoQ8ptrv2g1viiN95eO+sNwo1acvgSMVRnVjFpGms/48V2SzeaM2WVcYwQ3gt6MQmq0WmGlEIoaEV8q8iAtcwSNTfvh84ujuR+h9Pl2l+DBh1jfCXfDdFZ7Xc5O2keoCUFNfCKnpsr2PIq5FpN79g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(396003)(366004)(376002)(136003)(451199018)(6506007)(110136005)(122000001)(316002)(54906003)(6486002)(36756003)(71200400001)(8936002)(186003)(26005)(6512007)(83380400001)(91956017)(82960400001)(76116006)(66476007)(66556008)(2616005)(38100700002)(66446008)(41300700001)(64756008)(66946007)(5660300002)(86362001)(8676002)(4326008)(2906002)(478600001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bEdVV0pDNkV0WnFnUDJUdHZqU2F1SERtVnFqWmF1UDVjRkwwaHQ4bWJ6aFBQ?=
 =?utf-8?B?ZkdWNnZ6WkpVY2ZNTk5UUW5mTTVoMzFvb05pQmJiSTdibTd2T24rVWcwYjJn?=
 =?utf-8?B?cUY0VFNqL29oSk1sVDU0UEdJWnVyVFNvekdrcWVPRjY1Q29yMlN1c282UTR4?=
 =?utf-8?B?MHJJenNpQXd2ZUFCV0d2Yll4M0NWdmhnU3JXQzJCNVRVN2R2M2Iyd21ta1Vt?=
 =?utf-8?B?b1dja0FyUlBTWldyQ0lvQjd5cHFER2wxckRTWkROR1pLRWd2NnkrR0p6LzBr?=
 =?utf-8?B?Z1hOUlN5TWpEY1Z4bExBOEk2azBIN0gyYnhKVXZlMnJmcEpYdlkwMzlVN25s?=
 =?utf-8?B?TW8vOUtTajA5SEdXRVZKZXBCUVlxZUJabjVYeWNoRDN6ejgzYTdsd2xwU1R6?=
 =?utf-8?B?UlZwYXlVZ0gzc053SUdXVkFzdW5JQVdlUStxUXV6TEU5Y096SlNyMC83dEZa?=
 =?utf-8?B?YVAyenhpTDFqSHQ2NVQ0bUVkMUFPQVZkbHlmVFQzdWIwTXpkQmFDTnR6cHhX?=
 =?utf-8?B?bktyQXFKb0d0U1lJRmNWRWQyS2h3L1BqV1lUU09IVGhGUjJla0U4Z2RlY3R4?=
 =?utf-8?B?enN5UEVOaS9rV0Z5YmxYTzJZdHlEbzIvWTJ3U2dYZngyUDNaV1hsY05aT3lU?=
 =?utf-8?B?eFhPNnpzYlZqV3VMWVJ2QzNLRG8vMjhUVWlqMG56VHFzbisvN2p5ako0VXB1?=
 =?utf-8?B?MUhrSi9ycUEwZksxWnBOL1ZUSDZub1M1OXFJbHlVR0svYy9XMUo5REJtLys1?=
 =?utf-8?B?aXppMGRjK1lKVmV0ekpJV1NwbEhCdzFSWFYzVnFHL21aUzkyWEV2SWpoQWZy?=
 =?utf-8?B?a2tLNXFVZDNDL09tQmNkVCtFcUVGY01GZDMyRUxuZ042RktBL20zRjd0Si9v?=
 =?utf-8?B?WVpOWm5WUGRRNGJsajNuanVaczVkc2lBQ2ZIOHFxcnZWMVFNRUdTMTBidGxs?=
 =?utf-8?B?bTFhU2ZqYkFDdnErY1hPRHpUNkIyc2NvelFZMnFvcEJYdHdZNXNiMnpYQ1lG?=
 =?utf-8?B?M3VBYzUvU2NCcC81dFFBYmh5YnNJL2pUc3ExY3AvTW5VeGVLbmJPNTNYWEpB?=
 =?utf-8?B?dzNzV0xDbUhFQjVXUWxzMUh2dHdsbTE1b1VIbEV3MFdWeE9UeHdGUkV1a3Z5?=
 =?utf-8?B?YWdvZDROR1F0S3Zhd2NNZXBMVGF4UHJHZXM1RVVRS1BCWVo3UmRReWNVT0pC?=
 =?utf-8?B?RE5xRE94OGsyb0dYRDFFd3FKQi83WjBlK2tWcVphWXZUbkJiQVV5NCtzUlMx?=
 =?utf-8?B?bXZQNE1KM3FDNnN6dHAyVXFiNVRsRlc5eE5Rdk1tdDZKVCtPQmhvS3cwRDZS?=
 =?utf-8?B?VzJwcFBRalBLUVNsdlVFOTJXREdFL21VMlU0MDZxTW1HL3ltNWVKY3ZPN0hX?=
 =?utf-8?B?ZHA4Wjhkdm10eXdwQmprNDlWaGRTb0grQkt2ZE0wcjhwemRock5LeWhsODQv?=
 =?utf-8?B?ejM5N0dmS1MzVG9TbVRWR1FXR3JSd1FaR3VDVkJSRklKaUlld01MVXAwckw4?=
 =?utf-8?B?VTNmVkNNbnJHSG5UU2NIUWV1eTR1dm8vUm9nZmMrN3J6VWlPeDErajRYRHlQ?=
 =?utf-8?B?dkMwek1TWmdaT3ZOa1hMdk5xK2lqNzY4TVJ6cWxvbmFsY1A2RjJZdEhGcThx?=
 =?utf-8?B?aVllL0J0aG5GdDFydjRIZzdtTWptMWljN2l0YXR5NVBmRHBTazlSdWJ5L0FH?=
 =?utf-8?B?a00xSU1DV1hpakRoL0pmOFUxZGpRTDNESzN0VytoV2xTRjc2dkR5eW1Vbll6?=
 =?utf-8?B?UW5zOWxqVkVsUDlPcnRyS2Z2UUZRSUN3ZVRNaXFibStKVE00UUtUZmVxd1pB?=
 =?utf-8?B?U2lZWThpZFl1SWV0WmNqYjlKWWwvN3dnb21HZjNMcTdpTUtPaHhTRC96bFpH?=
 =?utf-8?B?VU9DcGFtdm1kbGJCSVFYQlNLSlVnYjhWaEpvd00rM2F1UGVxT0RWc1pRYmVD?=
 =?utf-8?B?RUkxMXA3WEwwNG1GYWU3Y2pRQTFKdmVRZzFWQlIvZWl3T3hRWG1XdXBxTXA1?=
 =?utf-8?B?aGFDbk5BSGozYmpLUHBzTHY5RlNPdXl5dXdqdytpSU5UdzNPOElRMTNqeUhZ?=
 =?utf-8?B?d0g1RU13bGNFdlcvMFowVDQ5dDF4dkNmYXEvaFd4bFpjeDY4ZTN5eUluZnJC?=
 =?utf-8?B?bHBoTXRGVnNScHlkSGdYT2tub2hOc3c4UENvS1ZBU2RWbU9xZVdudGFJNVFu?=
 =?utf-8?B?dkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E2C9DB4C3DF7044D804114AB8660D626@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c87344b-bdca-4b0d-b5cc-08db0a3a5c1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2023 01:09:57.2798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sn+0+LL9CzQtoR+HgfkNPEMbWu0Bcvh5J4rxa/J3yoyul4DBY3IVuBl7yc3OPB3paaOG/Qqgefiomw2j8vgokFiGx1NH616iUWT7dcvtPUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8124
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

T24gU3VuLCAyMDIzLTAyLTA1IGF0IDE3OjAzIC0wODAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6Cj4g
UmVnaW9uIGF1dG9kaXNjb3ZlcnkgaXMgdGhlIHByb2Nlc3Mgb2Yga2VybmVsIGNyZWF0aW5nICdz
dHJ1Y3QKPiBjeGxfcmVnaW9uJyBvYmplY3QgdG8gcmVwcmVzZW50IGFjdGl2ZSBDWEwgbWVtb3J5
IHJhbmdlcyBpdCBmaW5kcwo+IGFscmVhZHkgYWN0aXZlIGluIGhhcmR3YXJlIHdoZW4gdGhlIGRy
aXZlciBsb2Fkcy4gVHlwaWNhbGx5IHRoaXMgaGFwcGVucwo+IHdoZW4gcGxhdGZvcm0gZmlybXdh
cmUgZXN0YWJsaXNoZXMgQ1hMIG1lbW9yeSByZWdpb25zIGFuZCB0aGVuIHB1Ymxpc2hlcwo+IHRo
ZW0gaW4gdGhlIG1lbW9yeSBtYXAuIEhvd2V2ZXIsIHRoaXMgY2FuIGFsc28gaGFwcGVuIGluIHRo
ZSBjYXNlIG9mCj4ga2V4ZWMtcmVib290IGFmdGVyIHRoZSBrZXJuZWwgaGFzIGNyZWF0ZWQgcmVn
aW9ucy4KPiAKPiBJbiB0aGUgYXV0b2Rpc2NvdmVyeSBjYXNlIHRoZSByZWdpb24gY3JlYXRpb24g
cHJvY2VzcyBzdGFydHMgd2l0aCBhCj4ga25vd24gZW5kcG9pbnQgZGVjb2Rlci4gUmVmYWN0b3Ig
YXR0YWNoX3RhcmdldCgpIGludG8gYSBoZWxwZXIgdGhhdCBpcwo+IHN1aXRhYmxlIHRvIGJlIGNh
bGxlZCBmcm9tIGVpdGhlciBzeXNmcywgZm9yIHJ1bnRpbWUgcmVnaW9uIGNyZWF0aW9uLCBvcgo+
IGZyb20gY3hsX3BvcnRfcHJvYmUoKSBhZnRlciBpdCBoYXMgZW51bWVyYXRlZCBhbGwgZW5kcG9p
bnQgZGVjb2RlcnMuCj4gCj4gVGhlIGN4bF9wb3J0X3Byb2JlKCkgY29udGV4dCBpcyBhbiBhc3lu
YyBkZXZpY2UtY29yZSBwcm9iaW5nIGNvbnRleHQsIHNvCj4gaXQgaXMgbm90IGFwcHJvcHJpYXRl
IHRvIGFsbG93IFNJR1RFUk0gdG8gaW50ZXJydXB0IHRoZSBhc3NlbWJseQo+IHByb2Nlc3MuIFJl
ZmFjdG9yIGF0dGFjaF90YXJnZXQoKSB0byB0YWtlIEBjeGxlZCBhbmQgQHN0YXRlIGFzIGFyZ3Vt
ZW50cwo+IHdoZXJlIEBzdGF0ZSBpbmRpY2F0ZXMgd2hldGhlciB3YWl0aW5nIGZyb20gdGhlIHJl
Z2lvbiByd3NlbSBpcwo+IGludGVycnVwdGlibGUgb3Igbm90Lgo+IAo+IE5vIGJlaGF2aW9yIGNo
YW5nZSBpcyBpbnRlbmRlZC4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBEYW4gV2lsbGlhbXMgPGRhbi5q
LndpbGxpYW1zQGludGVsLmNvbT4KPiAtLS0KPiDCoGRyaXZlcnMvY3hsL2NvcmUvcmVnaW9uLmMg
fMKgwqAgNDcgKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tCj4g
wqAxIGZpbGUgY2hhbmdlZCwgMjggaW5zZXJ0aW9ucygrKSwgMTkgZGVsZXRpb25zKC0pCgpMb29r
cyBnb29kLAoKUmV2aWV3ZWQtYnk6IFZpc2hhbCBWZXJtYSA8dmlzaGFsLmwudmVybWFAaW50ZWwu
Y29tPgoKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jeGwvY29yZS9yZWdpb24uYyBiL2RyaXZl
cnMvY3hsL2NvcmUvcmVnaW9uLmMKPiBpbmRleCA4ZGVhNDljMDIxYjguLjk3ZWFmZGQ3NTY3NSAx
MDA2NDQKPiAtLS0gYS9kcml2ZXJzL2N4bC9jb3JlL3JlZ2lvbi5jCj4gKysrIGIvZHJpdmVycy9j
eGwvY29yZS9yZWdpb24uYwo+IEBAIC0xNDE4LDMxICsxNDE4LDI1IEBAIHZvaWQgY3hsX2RlY29k
ZXJfa2lsbF9yZWdpb24oc3RydWN0IGN4bF9lbmRwb2ludF9kZWNvZGVyICpjeGxlZCkKPiDCoMKg
wqDCoMKgwqDCoMKgdXBfd3JpdGUoJmN4bF9yZWdpb25fcndzZW0pOwo+IMKgfQo+IMKgCj4gLXN0
YXRpYyBpbnQgYXR0YWNoX3RhcmdldChzdHJ1Y3QgY3hsX3JlZ2lvbiAqY3hsciwgY29uc3QgY2hh
ciAqZGVjb2RlciwgaW50IHBvcykKPiArc3RhdGljIGludCBhdHRhY2hfdGFyZ2V0KHN0cnVjdCBj
eGxfcmVnaW9uICpjeGxyLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHN0cnVjdCBjeGxfZW5kcG9pbnRfZGVjb2RlciAqY3hsZWQsIGludCBwb3MsCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQg
aW50IHN0YXRlKQo+IMKgewo+IC3CoMKgwqDCoMKgwqDCoHN0cnVjdCBkZXZpY2UgKmRldjsKPiAt
wqDCoMKgwqDCoMKgwqBpbnQgcmM7Cj4gLQo+IC3CoMKgwqDCoMKgwqDCoGRldiA9IGJ1c19maW5k
X2RldmljZV9ieV9uYW1lKCZjeGxfYnVzX3R5cGUsIE5VTEwsIGRlY29kZXIpOwo+IC3CoMKgwqDC
oMKgwqDCoGlmICghZGV2KQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4g
LUVOT0RFVjsKPiAtCj4gLcKgwqDCoMKgwqDCoMKgaWYgKCFpc19lbmRwb2ludF9kZWNvZGVyKGRl
dikpIHsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcHV0X2RldmljZShkZXYpOwo+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVJTlZBTDsKPiAtwqDCoMKg
wqDCoMKgwqB9Cj4gK8KgwqDCoMKgwqDCoMKgaW50IHJjID0gMDsKPiDCoAo+IC3CoMKgwqDCoMKg
wqDCoHJjID0gZG93bl93cml0ZV9raWxsYWJsZSgmY3hsX3JlZ2lvbl9yd3NlbSk7Cj4gK8KgwqDC
oMKgwqDCoMKgaWYgKHN0YXRlID09IFRBU0tfSU5URVJSVVBUSUJMRSkKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgcmMgPSBkb3duX3dyaXRlX2tpbGxhYmxlKCZjeGxfcmVnaW9uX3J3
c2VtKTsKPiArwqDCoMKgwqDCoMKgwqBlbHNlCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGRvd25fd3JpdGUoJmN4bF9yZWdpb25fcndzZW0pOwo+IMKgwqDCoMKgwqDCoMKgwqBpZiAo
cmMpCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gb3V0Owo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gcmM7Cj4gKwo+IMKgwqDCoMKgwqDCoMKgwqBk
b3duX3JlYWQoJmN4bF9kcGFfcndzZW0pOwo+IC3CoMKgwqDCoMKgwqDCoHJjID0gY3hsX3JlZ2lv
bl9hdHRhY2goY3hsciwgdG9fY3hsX2VuZHBvaW50X2RlY29kZXIoZGV2KSwgcG9zKTsKPiArwqDC
oMKgwqDCoMKgwqByYyA9IGN4bF9yZWdpb25fYXR0YWNoKGN4bHIsIGN4bGVkLCBwb3MpOwo+IMKg
wqDCoMKgwqDCoMKgwqBpZiAocmMgPT0gMCkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoHNldF9iaXQoQ1hMX1JFR0lPTl9GX0lOQ09IRVJFTlQsICZjeGxyLT5mbGFncyk7Cj4gwqDC
oMKgwqDCoMKgwqDCoHVwX3JlYWQoJmN4bF9kcGFfcndzZW0pOwo+IMKgwqDCoMKgwqDCoMKgwqB1
cF93cml0ZSgmY3hsX3JlZ2lvbl9yd3NlbSk7Cj4gLW91dDoKPiAtwqDCoMKgwqDCoMKgwqBwdXRf
ZGV2aWNlKGRldik7Cj4gwqDCoMKgwqDCoMKgwqDCoHJldHVybiByYzsKPiDCoH0KPiDCoAo+IEBA
IC0xNDgwLDggKzE0NzQsMjMgQEAgc3RhdGljIHNpemVfdCBzdG9yZV90YXJnZXROKHN0cnVjdCBj
eGxfcmVnaW9uICpjeGxyLCBjb25zdCBjaGFyICpidWYsIGludCBwb3MsCj4gwqAKPiDCoMKgwqDC
oMKgwqDCoMKgaWYgKHN5c2ZzX3N0cmVxKGJ1ZiwgIlxuIikpCj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqByYyA9IGRldGFjaF90YXJnZXQoY3hsciwgcG9zKTsKPiAtwqDCoMKgwqDC
oMKgwqBlbHNlCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJjID0gYXR0YWNoX3Rh
cmdldChjeGxyLCBidWYsIHBvcyk7Cj4gK8KgwqDCoMKgwqDCoMKgZWxzZSB7Cj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBkZXZpY2UgKmRldjsKPiArCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRldiA9IGJ1c19maW5kX2RldmljZV9ieV9uYW1lKCZjeGxf
YnVzX3R5cGUsIE5VTEwsIGJ1Zik7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlm
ICghZGV2KQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
cmV0dXJuIC1FTk9ERVY7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAo
IWlzX2VuZHBvaW50X2RlY29kZXIoZGV2KSkgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgcmMgPSAtRUlOVkFMOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBvdXQ7Cj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoH0KPiArCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJjID0g
YXR0YWNoX3RhcmdldChjeGxyLCB0b19jeGxfZW5kcG9pbnRfZGVjb2RlcihkZXYpLCBwb3MsCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBUQVNLX0lOVEVSUlVQVElCTEUpOwo+ICtvdXQ6Cj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHB1dF9kZXZpY2UoZGV2KTsKPiArwqDCoMKgwqDCoMKgwqB9Cj4gwqAK
PiDCoMKgwqDCoMKgwqDCoMKgaWYgKHJjIDwgMCkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHJldHVybiByYzsKPiAKCg==
