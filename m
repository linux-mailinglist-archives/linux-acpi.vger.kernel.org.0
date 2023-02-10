Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184E5692B03
	for <lists+linux-acpi@lfdr.de>; Sat, 11 Feb 2023 00:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjBJXRu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Feb 2023 18:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBJXRt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Feb 2023 18:17:49 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0A81814F;
        Fri, 10 Feb 2023 15:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676071068; x=1707607068;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DSQFtfxsCOTuIwGQpMQSDKdzgocEbsz3hQJfAS0Wo7A=;
  b=JZV30tMZeBLFwLQj3wQKbRPoMR6gb38oJp6YIlaq11B+fKHaZCf4TGnB
   n4W2yy+9mykbOLFDbKklLvUsIjwkM6bEFYP7yGSc7C63CI1xDjg9EJWtN
   3knhMW+htVbtpVfKKQUb0smd91vjwJorfqN1QO1FkEFpwx1FU7faEuHUh
   XH2GtUwgIVldfM1bBUngwjbXfnPFke7NZ2ULAlPJCHILJRwvtTxvLfOD2
   xF9ghphrOvmz0NUruewhAa01tXctD6tCJiTXhdD6CWPR0aATt2IpudeRr
   6IwLfPYFsUpBy2N/1/xgAFZIV1JTsXFWnPYLb9KtJYWanX2Vc6yyTgidH
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="310914297"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="310914297"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 15:17:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="810986581"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="810986581"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 10 Feb 2023 15:17:48 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 15:17:47 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 15:17:47 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 10 Feb 2023 15:17:47 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 10 Feb 2023 15:17:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bAondeAVQBWF6KIzqAGXcxZhMb0MC7L36gSNqXlfhL1WD412BNEF94D8bqAuKftSj8akfjGxcXc3ydltWBIhyacYO34ejKZxMoHqNNiu7I1G+3wp9MeqtxucXXG1vLSdXANPF6Z6XqRBYdvQTWcIECg5JVGlTbnb98kwc5HQOfl3UXs2Pidw6jBHfjqkDyX2J4+C7TaHdy4OhK7kTJuAyUlDXCJAHKRHQYK4YXA098atj6QuYMCia3VmrQlNdyjJy5ZLGLukyprbWHTH96oCRD8hp72nwM9uVRxO9wd624PO2X3nUrA8YD2IEJM5E//nC9rt5y8XpwZiY7Zne5peXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSQFtfxsCOTuIwGQpMQSDKdzgocEbsz3hQJfAS0Wo7A=;
 b=bXjQ49O2n0fD40VyoSh4o3TuCAno0rlUWOAJx+mvTJWpXO27qUF6i1MDUblmC3Clta8M89dNla4pRz9Rl+wgqt0XlpA0cbfbj7SJ4/dJJWLGfRZbIPboD7n50SyPlrjl++ErIcpSCVNx6U+r+S9Yi19+YqJw0SkcL0UN6V6HjzCStc+kdJsv/RsUw7uj8QCFXv7V72vGvlZ4yhOAxlYxtOr1iyuAokR17+ZrgPsU4tRJ/weP9P8I5FI1iTtTaCkn447jCGKQJcp9dP+EM/2An4imW1OoyWGX7MHf4/1zrd7fVnMWMyIBQyz7jU74gykfoIa1wYWuiC7AzBZQzLA8Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by MW4PR11MB6763.namprd11.prod.outlook.com (2603:10b6:303:20b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.21; Fri, 10 Feb
 2023 23:17:40 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::35af:d7a8:8484:627]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::35af:d7a8:8484:627%5]) with mapi id 15.20.6086.017; Fri, 10 Feb 2023
 23:17:40 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2 08/20] cxl/region: Cleanup target list on attach error
Thread-Topic: [PATCH v2 08/20] cxl/region: Cleanup target list on attach error
Thread-Index: AQHZPS7zyVUQGfaNGU68kEv7nw0AM67I0V0A
Date:   Fri, 10 Feb 2023 23:17:39 +0000
Message-ID: <7cce2c809fdb1c042b285de57f4cec0ace2127fd.camel@intel.com>
References: <167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com>
         <167601996980.1924368.390423634911157277.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <167601996980.1924368.390423634911157277.stgit@dwillia2-xfh.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.3 (3.46.3-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB3999:EE_|MW4PR11MB6763:EE_
x-ms-office365-filtering-correlation-id: 63f8cfe8-cc3f-4bd3-145f-08db0bbd013c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9/BY3iWBvK6DYNhb+ZYmqOl5PErsNEqh+AldntBQw3hJvMA1gmPYKCpEmbSmpjplzWvJxdgQWKoBo4vTlvRfN/btHx0K6NVL6ABSwRv68BT8dDiKclFABeLu7K5q4zLj+BKw56cnPIwBbZtbKoawbgWTiochr1Z5oHx2gGfVtLdIrV/W25s6AamdBscujM0zdEjFceeBGN3HpJ7Q86OkXmIVZLUZJUmqK5tzx1LMVysBIa5sSAjPWQkkXXp6IcGiar+K9smqtQuJbWTMinGbYyix7FQs1pIIdXJ0KQET2uBXQdCsK14il0K+kLLKPNAZH50GeZDm+4Pi9GvxBE0uSgnLL6jCHCPrTB91UGmXH4EMZvDvSZCvIBTkfqUr7D85joNmhT6ADFGm9o6Gl/5xlUynma3iZbMi68PZUIWbIWjTbnBJnoSt4PHXPX6My77J+MvwaDL122qS7U+pNzMSmPjWPB7k8TSyGlK2AxO35CNmdTOslbkljEiIgXq7y2jy56MQKH5Sg3bMriJIrZz/F5pf2yHe+4Q6Nky3YxVEt+6r3Vtvq2Mq9/Uxc/rq6jFRua/7GaL1pcWj7lNxSFprDAA718gR5E70RUCk7vYjdEyk84t8oQfDTv9kCS288fJn0Xo3eucqGM3iDl6EaTQhlpyPPTUPGI1eNLR3OixqHL01Do7ZMiYQen4sw1OPgL/Ea/uP9uVqvxcqO1qgsrjAzMVKwKBBx7nEvkRzP18MHio=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(366004)(136003)(376002)(396003)(451199018)(110136005)(316002)(54906003)(91956017)(5660300002)(8676002)(76116006)(4326008)(66946007)(66556008)(66476007)(41300700001)(66446008)(64756008)(82960400001)(38070700005)(86362001)(36756003)(38100700002)(122000001)(6512007)(6506007)(26005)(71200400001)(6486002)(966005)(186003)(2616005)(2906002)(4744005)(8936002)(478600001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M09IT2k4eHRnL243R2xLYnRJVkQ1Z0xxeW1YbzJNejgzV20zWVNuTnhxa25R?=
 =?utf-8?B?SGxCaUg1Y3JxVmdrM1JTZjZ2SUw5eEVCdkx2YnhVWHNheHJvNDd5M1NvRitJ?=
 =?utf-8?B?UlJMbys1amtPVUVKR0xCdjlCMVpBM0N4anR5Vm5ZNkxPeFUzMzc2YTNEZU9Z?=
 =?utf-8?B?QkFpNUpqYy9vRTEyTXZNL3NDMis5YjBjK3ArMjZXOGF3aDBENGJBNzBVeXho?=
 =?utf-8?B?RklxaHFnTmdpUlY0a2RrTEZBeVVhQzRoSC9NeVBsdFRvV3c0WkFjTHdCVGpa?=
 =?utf-8?B?Rkc0SUJVTmhPZ2dkeWNFQlFXMnA3TnBpQWU3Mnk5VlIzQjNTTDFoRVdiYzZK?=
 =?utf-8?B?MUVQRi9mMEtQeUFRYUcwN2lsQ0dUREdhTXY2b2RyMHZxU0txcEhNY1NLWEFG?=
 =?utf-8?B?SnZjbDZBeEFWbW5XaGRlN0wwa0t1ZEQyakFTendVQnV2VUMzT0FzZ0t3aCtm?=
 =?utf-8?B?TDRPMUtYdUZxQXNkSkZ6Rjc3RVoxZkFMYlJ2NUhRVzRHNVV2R2RqZEozUnpt?=
 =?utf-8?B?ek5Hd01aUXBOMFZUbFR3OGlSd3BPNUdseXlMZnlGSTU5cGZIenFrM3NWclVG?=
 =?utf-8?B?RVM5S2ltS2lwZi80a3E0dkZoMTY4RHpqN2NhMVJYYlFhQVB4NGM4Q2tYVmlL?=
 =?utf-8?B?ZlVQT29oRldDbDlEOGU1YVpWZ3R3eXRQM3Q0MFEyYXg4L0pLZU9lM0lPa0s4?=
 =?utf-8?B?QloxTXFjcHh4TVdzRTRzNXRVWStlUFQrQTZES1Iyb3hYM1FWbnBhSzZxOFJK?=
 =?utf-8?B?WHI1TmI2Q1N2Zk5GS2p1dFdnT1FFbzBTQzZsai9HcVBSWkRkNUpTL2JBRHZZ?=
 =?utf-8?B?MytjYjJtUE81Yk1tSE0wWGdYNGNaTnA3R0RoN1NsZ0htUVd2VkYrV3QrbmZQ?=
 =?utf-8?B?OUFnMEZEbnRxWkh3bGVvenNZOTVvSE5zR1pxVTN2dzNCbmJOMWF6NTRUVUVj?=
 =?utf-8?B?cXdhcGkwSlRSTWxlb0dsTjkyR3JlYnF0Zk1lUkpTcG5VWE4xeDBrUUhxNGky?=
 =?utf-8?B?UDFMdDZxWkNsMSswWWN0QnZDOWl4Qld6M2dHTTNMc3dhU2k2MUhyWnJBT1B2?=
 =?utf-8?B?aG1wRE5ud2lURGRjMUtZV2FOZ3NvSkZuSG0rajBjenliOEhsQkF4ZzdYV3pG?=
 =?utf-8?B?Z3dkNXhvaytIR0FxOSt5M1BJc3Y0K2lVMUFBRDlQMXFUWmhtdGw5NVhydUVj?=
 =?utf-8?B?VWRrdnFodEJVQ1lJdXJJQTBRaWt0OS85bWJNTk8zMTJhd3QvYm1sMGxkTXM2?=
 =?utf-8?B?Q3dUb0k5dU0xUytDTkhZSThkSjllUFR1bWpFRGJnbE8yUEkrWk1UdFhEZHRa?=
 =?utf-8?B?a0ZiN0c5OW9jclNpS0VHTWVEWENtYXQyaE9EN0o0VzdMekZqVnJPVEcvVWR6?=
 =?utf-8?B?dUNKTTVWOG9WaGpBcEhpaXhoaEtjQ2lmT2pUZXJNV1p4N1V4Wk5rTjJQaFJm?=
 =?utf-8?B?Z3N0V21XQmZialNRbCtxRm1SQjVlUkxKNGFycGZGQTdqV3haSk9tY3RjM0h2?=
 =?utf-8?B?azZFTzZuNjRjVmlMMGMyajdLT1Q0K2w2a213Qnk4NVYzbUF0MUo0cWFvaWNx?=
 =?utf-8?B?WmdNWDhOL1crWHh3eXNrNHRzK0ZEdVdtOGdkakNCN3RjTXFQajBLU1hTaWZt?=
 =?utf-8?B?NmppMjVHd2tMVS8rNVZMdGNLRGpsOUZydnA0alBIZmQrMnZlNWFmV2F0UWI3?=
 =?utf-8?B?ZmVmRkxkSFlpYjlwS1kvZW5QcWZJeFZlamhsK0lCSlRwRlNYY1RQdFRreWdD?=
 =?utf-8?B?NGxKSlphaUtlZUxDOTZPb1RUblRMREFvYVpKVTBEeGplak5Cc1dkdnFVOEJE?=
 =?utf-8?B?TFhDQmFmTjdLcld2UEpvaGJiWjBpU0E4cVVMSnpLOHo5ZncxTzQyS2ZlTG1p?=
 =?utf-8?B?bnBjQ3M2ZmtHc2wreVNKNjkzUllNK3BhVmtsUWd2OTFWMGgzRXEwVjRJMXBP?=
 =?utf-8?B?cStJekNSUXJJaGx2TVk5ejRqODdIQnVZV0tBQmFxSUV2TXRLNWp2UFRCaDMr?=
 =?utf-8?B?emFTWnVpcWlrR3hiQ1hZa2V3RS9iSWwrV01OblFZRUlIcWdWaUVXK2s0aHJU?=
 =?utf-8?B?a2M5SDJVckh6UllGNmlJcEtod1JnbkpHRmF1Y0gwYlhNVkgrR2grSkMxQmFD?=
 =?utf-8?B?bkVqazFuUXFaTlplblBZbUhaWXlQVTJ1b1NOcUx3OUxFaHJndkkrQTE4YmR2?=
 =?utf-8?B?VHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BFD8FA74114AA44281DAE41DE3B65044@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63f8cfe8-cc3f-4bd3-145f-08db0bbd013c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2023 23:17:39.9871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FTYZJdy84PJApSPbvwr9apjfOHIQhmhKSYOW+PeFy8yvrbUSl/+1UG9otWEmQalwoqkxEC9aNjdSvp1VGDZEMDHr0sr0seAajx0D4gVffAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6763
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

T24gRnJpLCAyMDIzLTAyLTEwIGF0IDAxOjA2IC0wODAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
IEpvbmF0aGFuIG5vdGljZWQgdGhhdCB0aGUgdGFyZ2V0IGxpc3Qgc2V0dXAgaXMgbm90IHVud291
bmQgY29tcGxldGVseQ0KPiB1cG9uIGVycm9yLiBVbmRvIGFsbCB0aGUgc2V0dXAgaW4gdGhlICdl
cnJfZGVjcmVtZW50OicgZXhpdCBwYXRoLg0KPiANCj4gRml4ZXM6IDI3YjNmOGQxMzgzMCAoImN4
bC9yZWdpb246IFByb2dyYW0gdGFyZ2V0IGxpc3RzIikNCj4gUmVwb3J0ZWQtYnk6IEpvbmF0aGFu
IENhbWVyb24gPEpvbmF0aGFuLkNhbWVyb25ASHVhd2VpLmNvbT4NCj4gTGluazogaHR0cDovL2xv
cmUua2VybmVsLm9yZy9yLzIwMjMwMjA4MTIzMDMxLjAwMDA2OTkwQEh1YXdlaS5jb20NCj4gU2ln
bmVkLW9mZi1ieTogRGFuIFdpbGxpYW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+DQo+IC0t
LQ0KPiDCoGRyaXZlcnMvY3hsL2NvcmUvcmVnaW9uLmMgfMKgwqDCoCAyICsrDQo+IMKgMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KDQpMb29rcyBnb29kLA0KDQpSZXZpZXdlZC1ieTog
VmlzaGFsIFZlcm1hIDx2aXNoYWwubC52ZXJtYUBpbnRlbC5jb20+DQoNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2N4bC9jb3JlL3JlZ2lvbi5jIGIvZHJpdmVycy9jeGwvY29yZS9yZWdpb24u
Yw0KPiBpbmRleCAwNDBiYmQzOWM4MWQuLmFlN2QzYWRjZDQxYSAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9jeGwvY29yZS9yZWdpb24uYw0KPiArKysgYi9kcml2ZXJzL2N4bC9jb3JlL3JlZ2lvbi5j
DQo+IEBAIC0xMzQ3LDYgKzEzNDcsOCBAQCBzdGF0aWMgaW50IGN4bF9yZWdpb25fYXR0YWNoKHN0
cnVjdCBjeGxfcmVnaW9uICpjeGxyLA0KPiDCoA0KPiDCoGVycl9kZWNyZW1lbnQ6DQo+IMKgwqDC
oMKgwqDCoMKgwqBwLT5ucl90YXJnZXRzLS07DQo+ICvCoMKgwqDCoMKgwqDCoGN4bGVkLT5wb3Mg
PSAtMTsNCj4gK8KgwqDCoMKgwqDCoMKgcC0+dGFyZ2V0c1twb3NdID0gTlVMTDsNCj4gwqBlcnI6
DQo+IMKgwqDCoMKgwqDCoMKgwqBmb3IgKGl0ZXIgPSBlcF9wb3J0OyAhaXNfY3hsX3Jvb3QoaXRl
cik7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpdGVyID0gdG9fY3hsX3BvcnQoaXRlci0+
ZGV2LnBhcmVudCkpDQo+IA0KDQo=
