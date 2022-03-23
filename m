Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0FD4E5862
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Mar 2022 19:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343504AbiCWSav (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Mar 2022 14:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbiCWSav (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Mar 2022 14:30:51 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A193C42EFA;
        Wed, 23 Mar 2022 11:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648060160; x=1679596160;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ghqAFj1qiKLZZdNfBAOcDoJN2HT8T74VIDDjpuX4z3U=;
  b=SG2UYYrxNUX38l8U09DLqRc15o12NJKtqol25ghfCG3y4NoSjBV1OCDo
   8TOpOKNKzmGSldayEzwXWcMyMmLWhWa1X4mAYPrWhLn/VOSAL4msn6jgl
   3jrUMdPzv3oiotf0cs7j0rO5bbcV35F49XsV2PYpBr3J+FgFsX2YSpdp4
   RJg1sHIXE84tOKAZoxtrGQVCmqGFJN/jT4XB4lAK8puhmyOPkG2kDAQUX
   g86vF2U8m2V/NfBsdSivPvhrsreDAtBDt1FELxA3e3S/dNYqtbrjUQbbp
   DbpTZB4rpLv69Y9jzBwhn83PXtEjhGKwm4/QNK9gQ+Sp3dtu9uFGoQElK
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="245671775"
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; 
   d="scan'208";a="245671775"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 11:29:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; 
   d="scan'208";a="649551810"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 23 Mar 2022 11:29:19 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 23 Mar 2022 11:29:19 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 23 Mar 2022 11:29:18 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 23 Mar 2022 11:29:18 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 23 Mar 2022 11:29:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zx5p+syxMGqHzVWbuGMnfGLu4s4dYplpUAaTOd5Uxv+hBGXgmZy/985Ri8Xk6lXFzuW+k8kTrxdbfErXhRMJk+pZM9erR/p7oMESxsQ/Jzv6lJnvKsRu+Vy52YKbFltcRPRHbuWgqEMxU6vaeN5AuiBjbjuZ6/N1X6obq5jKzd7h80ik71wzXvP/M18ASVCfsMX2lotcw8y+6exK3JwZOWWissDkpz/q7p/3igPbEG2lwHjc7SXVY52qO11UrFtSNoYuHw8pnScGZ/BA/dXMoLb/NxDrANHW050TQVghjT3ugvT1aE+E8Gsn2oOiVOoZwk9ej1A6few7v7/1eU0mIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ghqAFj1qiKLZZdNfBAOcDoJN2HT8T74VIDDjpuX4z3U=;
 b=D/PD/blF6aY91/b/h8OWUTEif6dHePFrcAb4mANWtyA+j0HYI2K0eZ4ernDgOcC173auA3W5KcHUkMC7SHBawW0inU60zJavbxqIe2vc4sV+iZSRxgluzraBIntUWAnn4Eaxw4sAtYNHmZL2Egv/YUe84O/+O6ssvxXnIH+LM4gV58l1SG2yBw4RQU30vlhVU1ibM586YSBBdZE70IvKd6l8SIs7hudmY3VBPhtnKWfANi8PmLXNOSzyPLgZZxLew9/Wsaw8onDfiU3QVVhd9gl4jEw9AHj8gHmU1r1EVrcfk610IP0DgH0FxrICy1GKB1qIXibh7TN1NIL1he6Mgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by DM5PR11MB1340.namprd11.prod.outlook.com (2603:10b6:3:15::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Wed, 23 Mar
 2022 18:29:17 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::d898:84ee:d6a:4eb1]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::d898:84ee:d6a:4eb1%6]) with mapi id 15.20.5081.023; Wed, 23 Mar 2022
 18:29:16 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "dave@stgolabs.net" <dave@stgolabs.net>
CC:     lkp <lkp@intel.com>, "rafael@kernel.org" <rafael@kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Moore, Robert" <robert.moore@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] acpi/pci_root: negotiate CXL _OSC
Thread-Topic: [PATCH 2/2] acpi/pci_root: negotiate CXL _OSC
Thread-Index: AQHYOw9raWFRleZDlEKat7Ow2y257qzMKSKAgAEoi4A=
Date:   Wed, 23 Mar 2022 18:29:16 +0000
Message-ID: <86f0bc64bc2173f7c061a96a290b540b2710f614.camel@intel.com>
References: <20220318213004.2287428-1-vishal.l.verma@intel.com>
         <20220318213004.2287428-3-vishal.l.verma@intel.com>
         <20220323004753.qkngm4yctprcgvoc@offworld>
In-Reply-To: <20220323004753.qkngm4yctprcgvoc@offworld>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-1.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 600cd1ba-d662-4850-8a00-08da0cfb09d5
x-ms-traffictypediagnostic: DM5PR11MB1340:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <DM5PR11MB1340C0C6E460C9005DB62864C7189@DM5PR11MB1340.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FoS/lwygMg2rn4GHLYh1bfG0RJbuD6IqQ1Q1WaIJI0panbTi3sF0m1XORR8kFQbFDonmVZgZjZI0155wkiEg602+Ipj8t6gH4jcPBI10tvG6QDI1WanIl0kquoVHFHAfLRQHRPcRADNk65cJdjJ3tDOFcUHtenCvft+yi35iQlz68ORTI1dIKyVKWSNY3IhJIAnNK6+XQFKbXO9pRGie7sluu+CUd8e1q3PmMCwTHHgtpwDBXxhC1AYexifZNtXEkYjAZXjbjlmTVoxOa+rfOwHYhFns515Md0Snv4XmKgYXva3lwHlBnkK1bAd6MO1oNdJxxpg8KA8jbU98cGzFm8UgIxhpFP/Mg5l4v2a5QZLuqSeksd2F/b9Aw6Xkdx1JZWZSNhoenNkQVteYFkKhpDci2ufSLQHbbyFCm09z0ZpC4qXkzcBfD5O1Z3c7SFg3P3bIYh7v8dNJg+7NT/7ufzapK7FlGkjzG03E4wST4mtPvQsxgKboCNzrV5XmKuNZKzJBqBYRaaf4jmzh09NBmlFYr1oSXRrM1p3Dv1ol7/O2QoCHeONCKYx6zVXckavLxmD7bO0IKsyiau08uK9jWE/bJr6VByciOP2p8GGAbAlgLe5qT7vZRM5I3AydDUGDQVtRPKQdC5oIL2dOgRbvrlC3fvpu+jIJmMQfMdceZDrDALS+VgUXNthduw2qCxVJYAkcIp3Gm5UCBARpaQ3wuA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(6916009)(6506007)(26005)(186003)(6512007)(83380400001)(6486002)(2616005)(316002)(8936002)(38070700005)(508600001)(36756003)(71200400001)(2906002)(66446008)(66946007)(38100700002)(86362001)(66476007)(66556008)(76116006)(82960400001)(91956017)(4326008)(64756008)(122000001)(5660300002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d29lc1czL2hHL21kZE80d0syOWRZSTdad0UvdlJkUVJ4M1Qwd2ZicG4rWVJh?=
 =?utf-8?B?WSttNzVDMXEvU3JheDYwTEtkMGphT0dnNTRjMTB0SEwzZGNVOFVCL2JLUjBI?=
 =?utf-8?B?UkxldTEzUGxsTWRYTXV4MzRMTjlBVWQwM2NrZ1NuZ3FQQVphZzBBVm40OEd1?=
 =?utf-8?B?N3dvdjdSOEVBRVZoeWtUTU5oaHZrNUgvcWZiYmlqdEo2Tk8xbnR4RUdxenJw?=
 =?utf-8?B?NnFXZ01HQ1NsMWd1WFJucmRabzVwV21IQ1BkN3lTRStUQUdJZE0rTnJEaWI5?=
 =?utf-8?B?Y2xicE5zcjgyM0k5dzByeEZ0NmhaaWJlazFNYXNIdVFUK2NyYVRhZUZ5MURJ?=
 =?utf-8?B?K2w5SVloa3dBZTJyeEd1MTRkUER3d3I3MlBUbGZGSjRMWjIyelVrcHZsQVZE?=
 =?utf-8?B?ZVpocVlvSmZpRUJTRkVid1JvTGw1Vkg0bjB3ZzYyb0hGMWl4MzRVa0pxTDRX?=
 =?utf-8?B?QXM2UDZmUUxldWYwaEQ3Sy9pcElNcjZNOWIxcEtVeVU0RkFoNk1rMmI1SXYr?=
 =?utf-8?B?M0dVQXU2cDBkMlRsRU5EemkyRUpwZURpOEI0YUlEZSthMkZhVml6Tjdpb0cz?=
 =?utf-8?B?NHQ0WmFneStCU2VxSGZaL3ZzTXkxVWU3aFJCWGp4R0JrY0xVeE1Mbk00cE1F?=
 =?utf-8?B?by8wd0NEd1lJcEFQK2gzZXNYaVBSdnhLSlhSR20zcml5aGtmVlhqUDVJN2tE?=
 =?utf-8?B?MFdyMmdqdjBwUHFlVDFGYlZXMDlvNHU5MWxJeWNaaG9rRzF0bW5VY0tYdms0?=
 =?utf-8?B?dThVTEo2dVFUMVNqSi9uY290MTRpeHBBK20vcDhLWkFmUDVSSk82amg5eThv?=
 =?utf-8?B?dkk3TmpOcjYzOEprQktFcmJpV2hZcDRhbEZwWE9OYWNRbFIvNi95aFJYN2NL?=
 =?utf-8?B?bEpIRWxqeXphcEwyZDJOemo3ZnU1UG1iTFFpcnNudjV2eWt5dzg2aGw1cG5N?=
 =?utf-8?B?cVZrd1BjS2FSemFmRUlDdExaNGZ3V2FnVUVObXBScVJSejF4OUswdjYwdE00?=
 =?utf-8?B?WXBGN3lldlF4N2RsdXVkU0ZZTUgrMXdHdzYrejBWYTlCenpVMXpYOUk3Ty9H?=
 =?utf-8?B?WlJYQ1M1OW5PQk1EVEZ4ZkpBTmk1SXhqZFhnR2tBaFJUcDV4OEhpSDNaek00?=
 =?utf-8?B?NVI2TlFRQ2ZxSzVXSmpjRkJkTU5LZ29qYllYeXhzZTNIM041UG1JeDlYWVhQ?=
 =?utf-8?B?cGNYQTM5dzd0QW9SdUtkUmZnRnRCYWNmdUM0ZEdoTE1PaEJXR21pcGsrY3U3?=
 =?utf-8?B?ckRBQ3NPSThYOGR1VUxXbWVMWjJFY3Yxa1NjbWdhY3RMWkpHV2oxMVEzaEZX?=
 =?utf-8?B?ZktxMGlycUZ4MmlPMk04NENKRCtrWk9adFFCaFNqdXZtVERMTlVVUkFTdkk2?=
 =?utf-8?B?S3l6WUR0UXNlVVJ6UTZaQ3hmeU4yMFVVWHMwc0k3UmphQ212UEREb0JENmZQ?=
 =?utf-8?B?VkhGU1ZzdmJvMGRRQkY4TmdvVEhsK1F0dFlTeWN0VzRVOE0wTUhwYUVNRGFT?=
 =?utf-8?B?b1ZaejBVRXpLaHhjWWpucDBPR2Z5MHRwMzR6ZWFiRUhHalFIanhLT2cvUGtx?=
 =?utf-8?B?V3U2bUNYTFhiZS9yeW5Hb095clhWSkZYYzB1OFl3SVdIL2M2UnhXcmJ6bnQ1?=
 =?utf-8?B?OUNPaXJGZmVqQ2V4NURnNE11ODg1dUJvYWxmRkk2eGl5eXJwM0JYREtNcEt3?=
 =?utf-8?B?SzE1dFJObEREMVRGbk9MWi94bGpPcEtyelF3UzV4VVhJZ3JUZFNScVppSHI5?=
 =?utf-8?B?N1N1MUlRVEc5NXd2V1JDUjZheHFYS1lNY2pLRHlGRExIZUpNNnBOaFNRTDBL?=
 =?utf-8?B?ckUxNGYreUU3c1paclRVbm8vRk40ZUpTVkVJcjFLWUtLUzFkcXR1QVcwbXBP?=
 =?utf-8?B?Q0hZUzBLTzBpWklOQWVjazFGOE1vWmwxYWZyMTA5S0Jqb1F4UklReUNQeWFW?=
 =?utf-8?B?TzRiR1dIU3BOd1RWYnZvUkN4R05oaTM5VGxFb05rR0haQUxPVi9UY2tLMGRM?=
 =?utf-8?B?ODVna1o1c2NnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <692A1AA77C11B249B13BE09D219A6ABD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 600cd1ba-d662-4850-8a00-08da0cfb09d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2022 18:29:16.5941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ly94L6L2fd+7c5LXp+OTMrM5kvFxwLq36qbhrd8NTMpPv5wFVwgX1V3N8odBjkKi5rNe9o+vkWTFk/18JqdvW7NtJwHeJlStW2wD1Xy65mY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1340
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

T24gVHVlLCAyMDIyLTAzLTIyIGF0IDE3OjQ3IC0wNzAwLCBEYXZpZGxvaHIgQnVlc28gd3JvdGU6
Cj4gT24gRnJpLCAxOCBNYXIgMjAyMiwgVmlzaGFsIFZlcm1hIHdyb3RlOgo+IAo+ID4gKy8qIE1h
eCBwb3NzaWJsZSBfT1NDIGNhcGFiaWxpdHkgRFdPUkRTICovCj4gPiArI2RlZmluZSBPU0NfQ0FQ
QUJJTElUWV9EV09SRFNfTUFYwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoDUKPiA+ICsKPiA+
IC8qIEluZGV4ZXMgaW50byBfT1NDIENhcGFiaWxpdGllcyBCdWZmZXIgKERXT1JEcyAyICYgMyBh
cmUgZGV2aWNlLXNwZWNpZmljKSAqLwo+ID4gI2RlZmluZSBPU0NfUVVFUllfRFdPUkTCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoDDCoMKgwqDCoMKgwqDC
oC8qIERXT1JEIDEgKi8KPiA+ICNkZWZpbmUgT1NDX1NVUFBPUlRfRFdPUkTCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgMcKgwqDCoMKgwqDCoMKgLyogRFdPUkQg
MiAqLwo+ID4gI2RlZmluZSBPU0NfQ09OVFJPTF9EV09SRMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAywqDCoMKgwqDCoMKgwqAvKiBEV09SRCAzICovCj4gPiAr
I2RlZmluZSBPU0NfQ1hMX1NVUFBPUlRfRFdPUkTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAzwqDCoMKgwqDCoMKgwqAvKiBEV09SRCA0ICovCj4gPiArI2RlZmluZSBPU0NfQ1hM
X0NPTlRST0xfRFdPUkTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqA0wqDCoMKg
wqDCoMKgwqAvKiBEV09SRCA1ICovCj4gCj4gU2hvdWxkbid0IGFsbCB0aGlzIGJlIGluIHBhdGNo
IDEvMiAoYW5kIGFsc28gYXMgZW51bSBtYXliZSk/IE9yIGF0IGxlYXN0Cj4gdGhlIGRlZmluZSBP
U0NfQ0FQQUJJTElUWV9EV09SRFNfTUFYIGluc3RlYWQgb2YgaGF2aW5nIHRvIGRvOgoKWWVhaCBt
b3ZpbmcgRFdPUkRTX01BWCBhbmQgdGhlIGFzc29jaWF0ZWQgY2hhbmdlcyB0byBwYXRjaCAxIG1h
a2VzCnNlbnNlLgoKPiAKPiA+IC1zdGF0aWMgYWNwaV9zdGF0dXMgYWNwaV9wY2lfb3NjX2NvbnRy
b2xfc2V0KGFjcGlfaGFuZGxlIGhhbmRsZSwgdTMyICptYXNrLCB1MzIgc3VwcG9ydCkKPiA+ICtz
dGF0aWMgYWNwaV9zdGF0dXMgYWNwaV9wY2lfb3NjX2NvbnRyb2xfc2V0KGFjcGlfaGFuZGxlIGhh
bmRsZSwgdTMyICptYXNrLAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1MzIgc3Vw
cG9ydCwgdTMyICpjeGxfbWFzaywKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdTMy
IGN4bF9zdXBwb3J0KQo+ID4gewo+ID4gwqDCoMKgwqDCoMKgwqDCoHUzMiByZXEgPSBPU0NfUENJ
X0VYUFJFU1NfQ0FQQUJJTElUWV9DT05UUk9MOwo+ID4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBh
Y3BpX3BjaV9yb290ICpyb290Owo+ID4gwqDCoMKgwqDCoMKgwqDCoGFjcGlfc3RhdHVzIHN0YXR1
czsKPiA+IC3CoMKgwqDCoMKgwqDCoHUzMiBjdHJsLCBjYXBidWZbNl07Cj4gPiArwqDCoMKgwqDC
oMKgwqB1MzIgY3RybCwgY3hsX2N0cmwgPSAwLCBjYXBidWZbT1NDX0NBUEFCSUxJVFlfRFdPUkRT
X01BWF07Cj4gCj4gLi4uIHdoaWNoIGJ0dyB3aHkgaXMgY2FwYnVmIDYgaW4gdGhlIHByZXZpb3Vz
IHBhdGNoIGFuZCBub3cgNSBpbiB0aGlzIG9uZT8KPiBTb3JyeSBpZiBJIG1pc3NlZCBhbnl0aGlu
ZyBvYnZpb3VzIGhlcmUsIGp1c3Qgc2VlbXMgb2RkLgoKT2gsIEkganVzdCBub3RpY2VkIHBhdGNo
IDEgY2hhbmdlcyBpdCB0byA2IGluIHRoZSBmaXJzdCBwbGFjZSAoSQp0aG91Z2h0IGl0IHdhcyBq
dXN0IDYgZXZlbiBiZWZvcmUgdGhpcyBzZXQpLCB0aGF0IGlzIHdyb25nLiBQcmV2aW91c2x5LAp0
aGUgUENJIG9ubHkgX09TQyBoYWQgMywgYW5kIHdpdGggQ1hMIGl0IGJlY29tZXMgNS4gSSdsbCBm
aXggdGhpcyB1cC4KCj4gCj4gQW5kIGFsc28gaXQncyB1Z2x5IHRvIGp1c3QgYWRkIGV4dHJhIHBh
cmFtcyB0byBhY3BpX3BjaV9vc2NfY29udHJvbF9zZXQoKQo+IGFuZCBoYXZlIGNhbGxlcnMgZG8g
ZG86Cj4gCj4gPiArwqDCoMKgwqDCoMKgwqBzdGF0dXMgPSBhY3BpX3BjaV9vc2NfY29udHJvbF9z
ZXQoaGFuZGxlLCAmY29udHJvbCwgc3VwcG9ydCwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAmY3hsX2NvbnRyb2wsIGN4bF9zdXBwb3J0KTsKPiAKPiBBbmQgdGhpcyBzb3J0IG9mIHRoaW5n
IGhhcHBlbnMgYWxsIG92ZXIgdGhlIHBhdGNoIHdpdGggc3RydWN0IGFjcGlfcGNpX3Jvb3QuCj4g
U28gdGhlIHdob2xlIGhhbmRsaW5nIG9mIHRoZSBfT1NDIHN0YXRlIG9mIHN1cHBvcnQvY29udHJv
bCBiaXRzIGltbyByZWFsbHkKPiB3YW50cyB0byBiZSBjb25zb2xpZGF0ZWQgYmV0d2VlbiBDWEwg
YW5kIG5vbi1DWEwuCgpJIGRvbid0IGRpc2FncmVlIDopIC0gQW55IHRob3VnaHRzIG9uIHdoYXQg
Y2FuIGJlIGRvbmUgdG8gY29uc29saWRhdGUKdGhpbmdzIGZ1cnRoZXI/IFRoaXMgc2VlbWVkIGxp
a2UgdGhlIGxvd2VzdCB0b3VjaCBhcHByb2FjaCB0aGF0IGtlcHQKZXhpc3RpbmcgUENJLW9ubHkg
cGF0aHMgYXMtaXMuCgo+IAo+IFRoYW5rcywKPiBEYXZpZGxvaHIKClRoYW5rcyBmb3IgdGhlIHJl
dmlldyEKCg==
