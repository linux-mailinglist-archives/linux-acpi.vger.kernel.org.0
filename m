Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00DE74F46D3
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Apr 2022 01:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241270AbiDEUpv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Apr 2022 16:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457525AbiDEQDU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Apr 2022 12:03:20 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF2322C;
        Tue,  5 Apr 2022 08:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649174387; x=1680710387;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2OINsQ4VauDy0c0cvL70G6/rRZbK72HQ4BgLPuns+Mw=;
  b=gMitfPAoef7SWP94jVIHFl84H8KPS2WvyGjHBpuiVshJPHpNvtS5ykr0
   oJ1hGLKluep3sUAJnfB8gczZ2vEkTjJRj0et+z7MpBSptOOJrQYsEXRtO
   PiHnZfCJ2vCDChm7aIaDlku4VdPd56wxjgNUWVl/+IUPD9NHS2vai8N4K
   9bbqUJCPiNF4eEbkDGEz4heilbJbVV4Rdt5S3eP9LZnsBMvJufJ1wciud
   5W2tp6yydXWerqe5Vvgy3pRH1kPwiotzIfX0nfLb08td2BxDIeyWMBnkF
   8Rle1KXbiAyWYkA7vooB/Jupyo2zHuDa2f90m0GtUjerQFWc0G1oeOdC7
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="321481889"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="321481889"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 08:59:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="608495545"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga008.fm.intel.com with ESMTP; 05 Apr 2022 08:59:28 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Apr 2022 08:59:28 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 5 Apr 2022 08:59:27 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 5 Apr 2022 08:59:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOExGmxtaiRrx+mOL0UQ7z6woOAXDqh4VBEM7LbecmS54X1TkNW3+UC0X6pm0OVNOQTgSUVtycWf81xCLZizUke3p5LgPe4o+feEZTlpF7DEoQwR3TVY3dBK+f3jok+Yv6SPJw/FYmWiQ355jCSuM4+w1lhA76pRZoIDzOFBWD8RLpECyP57s0E+0U8idB/iiFtRnLMZmvEunvCyp+bLGaLiJyJcxHTsMUm9k/d5lmpaQYjClWC1Dw1NOt3Xpn4HuEXMLy/RLGmydRQRYcFnqDuQ3L1HDMSsrt064f9Z2XJDkusgcID/I5OETZY2aBvIHI5lF0gVxEwAaRoji8Awaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2OINsQ4VauDy0c0cvL70G6/rRZbK72HQ4BgLPuns+Mw=;
 b=emr+Tl1bmnGAaKRSSBTxqh0W8IXihwRrxX3dtPQcPWvOaSziXETXpaaUFS+89CBMjdVDluxy5xoWLBD9NtmjelKyVd34jT69fRDNTkrl1Ju/pceUKdMNHaXoaNJ/g5YBYBW2DEUT70lAeHUkD/8d5SDgEy/64Gk36u8p3ALF8YpqtkdEUpjykitB2lAl+Y1Hu18hPrKQoNwRvSCwtjSTggeXoR2XqPZDmlNgrUDwiFu4B64h/cwS5OOkEb7BNfmMN02fQf7MC0IY/17bdNmDVX826nmnMijXHB1xPadGT4SQNG5rI6DNrNLvJrlCtWGbMUS0wFePRjf8GgjnATpI/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by SJ0PR11MB5613.namprd11.prod.outlook.com (2603:10b6:a03:3ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 15:59:25 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::41a:5dd4:f4b3:33cb]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::41a:5dd4:f4b3:33cb%7]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 15:59:25 +0000
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
Subject: Re: [PATCH v4 2/3] PCI/ACPI: Use CXL _OSC instead of PCIe _OSC
Thread-Topic: [PATCH v4 2/3] PCI/ACPI: Use CXL _OSC instead of PCIe _OSC
Thread-Index: AQHYRTzRZP7IgLSuh0SEDfjb58EsgqzhXOQAgAAk3oA=
Date:   Tue, 5 Apr 2022 15:59:24 +0000
Message-ID: <fb6bdaff0e032459d820f6f2f78768f56e7202af.camel@intel.com>
References: <20220331202022.1823174-1-vishal.l.verma@intel.com>
         <20220331202022.1823174-3-vishal.l.verma@intel.com>
         <CAJZ5v0hfTXkHQE2j8B00Qvn1vuW0a-5AoUG-dSJvCH5PW70AZw@mail.gmail.com>
In-Reply-To: <CAJZ5v0hfTXkHQE2j8B00Qvn1vuW0a-5AoUG-dSJvCH5PW70AZw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-1.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40307ec2-ab08-4618-ac24-08da171d41b8
x-ms-traffictypediagnostic: SJ0PR11MB5613:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <SJ0PR11MB561311EEBEB7FF12A41082DBC7E49@SJ0PR11MB5613.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yuR6gegVq8NSBYWqSbx7Ol9mvLnoakV+spqR363f9xlk35lw5BZsL5YzknYoi4Q0Jpw+ukuSkSowo1eVMoZoMwE4rumVgyN+9U/5vCYRV6ypgDCuBKly/BMzW7Ze3RxFBAegkatO9umk1Qnbgj+RL7tIXor7AHwVDGMBA5rSnKxqiO7xTWGhmpcNasiM31py/YryKWHqF6/7XPTs+4sXDKvaGH2KysqGK0syAIVUcayRwmc3kuZUzYE1JNeEm+AqFl4szGL2Dpks17WMmazLsYS340uic7eEiUy8bozcbnz+XyTqYGI2ADhbaL/yccRqQQQAuWZ5vIUeUt+awIgnjWJPX11ZLyoskpL1Z3dZJN0MFR/DHalkQmDtB701esWDaxkZE/fOh5jZa8qmo0haccuWWHEtuZ00mTrbaXCHCk2qgR5NjaX0v2vp+CvTEG2ov3bWlCHVisfBeQPZwa2BBhshkn3+b2C52BR8yCuz5tebkV7qrktfZKUtaeAauoueP5pwHkWYu9K3r+7r2tYCwp/uU82NMpCusEGSWbGZVuf+88nHtwFhwF0MRzWXcDQj+UAFJ65IO2QigwaVWK/huolqpgBufkfLD0uchdtharf3pJsIc5k2Q7GZXldwg6j6obW7O9N8uO9zVUJKmP0A6ZEy9PSBRr0qmHHwY+4q4yIPpNildogemtTPLQBHeBpxpYTRXtk0bej6KIg63NYNeQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(8676002)(66556008)(5660300002)(91956017)(66446008)(2906002)(66476007)(64756008)(76116006)(66946007)(6916009)(8936002)(316002)(54906003)(86362001)(38070700005)(6486002)(38100700002)(71200400001)(53546011)(6506007)(6512007)(122000001)(508600001)(36756003)(83380400001)(26005)(186003)(2616005)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzBFbDJ2VE9zWDVxQmxCcjk2Ny9GK0xyOVhuMGtHYXhBNjNVK3BHY1FHYmhL?=
 =?utf-8?B?cFpCYTJRWldNMmFjUU1wRWkrUXhIQVZGWlNERGhUSlVPV1FjTnFlRjVCc1F0?=
 =?utf-8?B?bnNoWWRnSkxMM2JVbGw2dlVGWC9MY2V3Rk95UWpUSWVuZkNqTjVYQ3VVYVBM?=
 =?utf-8?B?R3dnUEhiSUdLaWJDamhYOTY1N2VPNlZscHl1cVNsOUxWN3hBUmZQeTVQNU1M?=
 =?utf-8?B?WDU4NU45YU12aVhuWkdwOFBaQ3lReTRIakQ5N3FLWndPMXJvQk16T2RrTk9B?=
 =?utf-8?B?U29DRzVTY3ZiYXordkw0YTFvZ3BNaWlXcDFKOVBhRDdQNXpNMUlKVkQwdGEz?=
 =?utf-8?B?VUFWS1pyWFhMdUF1bmlKUGNoa04zTFU1VndxWU1RQXdxNjhvSGFVU0VFWXdj?=
 =?utf-8?B?QUVqOFhMb2FEeWd6MUFQUWw3Q1dEaG5KSk9qUlRYa2lFNFZzT3hUd0RKRWNq?=
 =?utf-8?B?MExUSjZkbkt2QkNyL1RWeUZxUXRuMGN0bzIxQ3BHZzBISEhvUS9jWnBlbGJR?=
 =?utf-8?B?Rlp3K3FTRXBCYjVHSy8wcVI4bTRXcVY2cWN3b25BV1ZCckNWQzRJNXhsemZF?=
 =?utf-8?B?ZzJqSFFhaXhqM2lKZStrZ1dkYUJhSjQ0cDkxVkJrMkVzR2Q5dXNEMTh1RTVS?=
 =?utf-8?B?WWJoYm1jVGdEQ1htdHUxZU1BTWgxZ0JZWk1pUkRRZStpVnduSUlQZ094Um9m?=
 =?utf-8?B?ZVR1UU9iY0k3Z3ljZXpyNDg2amVobE9wTFk4cTdtd2NMK0JoR2llS3c1ZkFN?=
 =?utf-8?B?MlVzdVVSZjgvS2tYblRTOU96Wkxod1pwTnQrcHFrNlJDTHNYSDhQcFlRK0R5?=
 =?utf-8?B?UjBwN25mNUl3eGFDQXhHS1BKNVNIN1Z1b21JM28wd1MxTXBTMGp2Qno4NkF0?=
 =?utf-8?B?OSs4cXE2eDRLTVJHdHlWUGVOYndJYmtCZmN0UHEwbVNPbHcyakY0Y3c2VWNE?=
 =?utf-8?B?MWZ2RE5RRlNWR0xaeTFOY0x1YlZ4SytxbDNjMG5MUi9Zb1h4d0lBcGZXTU9M?=
 =?utf-8?B?d3FuL3pKempaSEwwUkd2Ymw0SE93cm12TGZYTm15dWJVcmdDRnZMdWZEK1dJ?=
 =?utf-8?B?Qkd0cEtkQ3hLTitZQ1grUmREVVNUMGwwMjFqMXRWMnllMWpHSFRJSGNRSHlV?=
 =?utf-8?B?NUoxTWdJSGFXc3JQaGkwQTlVWUlUd0owVGxoblJvZlNKd1FwKzRNd3ErUm13?=
 =?utf-8?B?ZXhlQzRrTURuNnNqd1FFTStkdnNxc29GWGxoY1d3T0p2NGVHcWRtVUdKYTd1?=
 =?utf-8?B?TCtSb1k2QWkvZEVhbHpqMGdKKzRXSnY2cjA1ZE9OZUVFRDVlbFFsZEt4aFMz?=
 =?utf-8?B?eHZqSk5HNUs5L0h4Q0EzZ1BiTkozcDkxVWRPQy9nbnJ4ckhzVHY5bC91c0xC?=
 =?utf-8?B?NGU0NU1BWWlIRHFPOXFmV1NZejI3NmJya0RZZ0ozYUt0ZnR3OW9jb0ZkSnJp?=
 =?utf-8?B?d2RpckZPa1VMN3FhK1hXbUxzZFg0cUtOT0dLSkJRTUJXOUVBSnlvZkQzZGxz?=
 =?utf-8?B?UnJJT3A3a0w2RFNDNXQ5TWJ5eU5lU2U1SzZrZEdaZ0ZVVUhTRzI1UG5JOWVQ?=
 =?utf-8?B?TFVuZkpKM3M4VmtpampUQTVtY01GL3g2TDBZcXkrWlR4TDE3b1RWOTM0RDVa?=
 =?utf-8?B?TUFJRVdNMjNERCs5bndRMkM5dnJORXNYZzZaa1d5MU4vdDB4Y3FqNnhHdmZj?=
 =?utf-8?B?U3lodExJb2xlL05IcE5ISWZlVHhUbTUvQjJTVUtERXdEYmdxMTFzOU9BQXVj?=
 =?utf-8?B?dUFIMHdyRVJkSUtRUmxhUlFEMDdkWHN6eWVxVGxEOTJDazBJYjZLbkEvSVN5?=
 =?utf-8?B?Q0o3azFyVnVJZ2w5U0JDd2tjTFZTbC9lcmxZREhIeVpzTURKVHUvRllUM3Ay?=
 =?utf-8?B?a01DR0hPVXpMVWduVmpmbFhJSGhYUkdEZ09XbDRPcjJvd2Y3OWlyQnU5UFhy?=
 =?utf-8?B?VTJrOXlRU0RYb0ZPTlFFRkhTeTlNbnNGRUFJbGlRbEZRVGt2WjVIaEcrblhl?=
 =?utf-8?B?eUZCeHYvSHJTb0ZYRE51b3pJL3pOUGljdEwvWTFrYWtha1RnazkvbGxIQ0hE?=
 =?utf-8?B?Vkd3YW4vY1AvNC9vMEdBNFQ0cTJmTnhUM3RPTUpBMmg0TW1uQjc0eHdTT0Rl?=
 =?utf-8?B?NzNGMXNUTUlTSmk4aHk2NUZOajgxTmNqdmVSakZITk9DQWZBZGl6N0kvTHkz?=
 =?utf-8?B?MWN4QW1oYkFzaG9nbVdEZHl0SW9DNDZ3ZkdDUVJpLzN5Q2g0eitScVZEc2Mv?=
 =?utf-8?B?cVhIdDFMWkxOUWgwQkg2N0g3Tlg0ak1KVjYwbGpzZ0haTWh5eHoyNTkwLzdy?=
 =?utf-8?B?ODVpV25kUENkamVnUDhTbHkrYmovWkJkcTZJZkpUSEhXSUE0MUJmN1hVd29u?=
 =?utf-8?Q?24qRoM9UDkyq/Mk+lBGur0TVw773dZPelqbNP?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <87F4AFC82490B54E95E77ADA73933726@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40307ec2-ab08-4618-ac24-08da171d41b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2022 15:59:24.9208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 09XJlm6Nd+mYPHQtUDD2CbDquGtXBbVe06Uu9wamYz120Qgth+BHm7nvf5nWj/zKi37E2RfIrq3f9tJI+/d+DgIIasiZS5blFhFZgviJMHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5613
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

T24gVHVlLCAyMDIyLTA0LTA1IGF0IDE1OjQ3ICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gRmlyc3Qgb2ZmLCBJIHdvdWxkIGNoYW5nZSB0aGUgc3ViamVjdCB0byBzb21ldGhpbmcg
bGlrZSAiUHJlZmVyIENYTA0KPiBfT1NDIHRvIFBDSSBfT1NDIGZvciBDWEwgaG9zdCBicmlkZ2Vz
Ii7CoCBBcyBpcywgaXQga2luZCBvZiBzdWdnZXN0cw0KPiB0aGF0IHRoZSBDWEwgX09TQyBpcyBw
cmVmZXJyZWQgaW4gYWxsIGNhc2VzLg0KPiANCj4gT24gVGh1LCBNYXIgMzEsIDIwMjIgYXQgMTA6
MjAgUE0gVmlzaGFsIFZlcm1hIDx2aXNoYWwubC52ZXJtYUBpbnRlbC5jb20+IHdyb3RlOg0KPiA+
IA0KPiA+IEZyb206IERhbiBXaWxsaWFtcyA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPg0KPiA+
IA0KPiA+IE9CIEluIHByZXBhcmF0aW9uIGZvciBuZWdvdGlhdGluZyBPUyBjb250cm9sIG9mIENY
TCBfT1NDIGZlYXR1cmVzLCBkbyB0aGUNCj4gPiBtaW5pbWFsIGVuYWJsaW5nIHRvIHVzZSBDWEwg
X09TQyB0byBoYW5kbGUgdGhlIGJhc2UgUENJZSBmZWF0dXJlDQo+ID4gbmVnb3RpYXRpb24uIFJl
Y2FsbCB0aGF0IENYTCBfT1NDIGlzIGEgc3VwZXItc2V0IG9mIFBDSWUgX09TQyBhbmQgdGhlDQo+
ID4gQ1hMIDIuMCBzcGVjaWZpY2F0aW9uIG1hbmRhdGVzOiAiSWYgYSBDWEwgSG9zdCBCcmlkZ2Ug
ZGV2aWNlIGV4cG9zZXMgQ1hMDQo+ID4gX09TQywgQ1hMIGF3YXJlIE9TUE0gc2hhbGwgZXZhbHVh
dGUgQ1hMIF9PU0MgYW5kIG5vdCBldmFsdWF0ZSBQQ0llDQo+ID4gX09TQy4iDQo+ID4gDQo+ID4g
UmF0aGVyIHRoYW4gcGFzcyBhIGJvb2xlYW4gZmxhZyBhbG9uZ3NpZGUgQHJvb3QgdG8gYWxsIHRo
ZSBoZWxwZXINCj4gPiBmdW5jdGlvbnMgdGhhdCBuZWVkIHRvIGNvbnNpZGVyIFBDSWUgc3BlY2lm
aWNzLCBhZGQgaXNfcGNpZSgpIGFuZA0KPiA+IGlzX2N4bCgpIGhlbHBlciBmdW5jdGlvbnMgdG8g
Y2hlY2sgdGhlIGZsYXZvciBvZiBAcm9vdC4gVGhpcyBhbHNvDQo+ID4gYWxsb3dzIGZvciBkeW5h
bWljIGZhbGxiYWNrIHRvIFBDSWUgX09TQyBpbiBjYXNlcyB3aGVyZSBhbiBhdHRlbXB0IHRvDQo+
ID4gdXNlIENYTCBfT1hDIGZhaWxzLiBUaGlzIGNhbiBoYXBwZW4gb24gQ1hMIDEuMSBwbGF0Zm9y
bXMgdGhhdCBwdWJsaXNoDQo+ID4gQUNQSTAwMTYgZGV2aWNlcyB0byBpbmRpY2F0ZSBDWEwgaG9z
dCBicmlkZ2VzLCBidXQgZG8gbm90IHB1Ymxpc2ggdGhlDQo+ID4gb3B0aW9uYWwgQ1hMIF9PU0Mg
bWV0aG9kLiBDWEwgX09TQyBpcyBtYW5kYXRvcnkgZm9yIENYTCAyLjAgaG9zdHMuDQo+ID4gDQo+
ID4gQ2M6IEJqb3JuIEhlbGdhYXMgPGJoZWxnYWFzQGdvb2dsZS5jb20+DQo+ID4gQ2M6ICJSYWZh
ZWwgSi4gV3lzb2NraSIgPHJhZmFlbEBrZXJuZWwub3JnPg0KPiA+IENjOiBSb2JlcnQgTW9vcmUg
PHJvYmVydC5tb29yZUBpbnRlbC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IEpvbmF0aGFuIENhbWVy
b24gPEpvbmF0aGFuLkNhbWVyb25AaHVhd2VpLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBEYW4g
V2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBW
aXNoYWwgVmVybWEgPHZpc2hhbC5sLnZlcm1hQGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiDCoGlu
Y2x1ZGUvbGludXgvYWNwaS5owqDCoMKgIHzCoCA0ICsrKw0KPiA+IMKgaW5jbHVkZS9hY3BpL2Fj
cGlfYnVzLmggfMKgIDYgKysrKw0KPiA+IMKgZHJpdmVycy9hY3BpL3BjaV9yb290LmMgfCA3MCAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLQ0KPiA+IMKgMyBmaWxlcyBj
aGFuZ2VkLCA2NSBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkNCj4gPiANCg0KWy4uXQ0K
DQo+ID4gDQo+ID4gQEAgLTU4Nyw4ICs2MTksMTYgQEAgc3RhdGljIGludCBhY3BpX3BjaV9yb290
X2FkZChzdHJ1Y3QgYWNwaV9kZXZpY2UgKmRldmljZSwNCj4gPiANCj4gPiDCoMKgwqDCoMKgwqDC
oCByb290LT5tY2ZnX2FkZHIgPSBhY3BpX3BjaV9yb290X2dldF9tY2ZnX2FkZHIoaGFuZGxlKTsN
Cj4gPiANCj4gPiAtwqDCoMKgwqDCoMKgIGlzX3BjaWUgPSBzdHJjbXAoYWNwaV9kZXZpY2VfaGlk
KGRldmljZSksICJQTlAwQTA4IikgPT0gMDsNCj4gPiAtwqDCoMKgwqDCoMKgIG5lZ290aWF0ZV9v
c19jb250cm9sKHJvb3QsICZub19hc3BtLCBpc19wY2llKTsNCj4gPiArwqDCoMKgwqDCoMKgIGFj
cGlfaGlkID0gYWNwaV9kZXZpY2VfaGlkKHJvb3QtPmRldmljZSk7DQo+ID4gK8KgwqDCoMKgwqDC
oCBpZiAoc3RyY21wKGFjcGlfaGlkLCAiUE5QMEEwOCIpID09IDApDQo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgcm9vdC0+YnJpZGdlX3R5cGUgPSBBQ1BJX0JSSURHRV9UWVBFX1BD
SUU7DQo+ID4gK8KgwqDCoMKgwqDCoCBlbHNlIGlmIChzdHJjbXAoYWNwaV9oaWQsICJBQ1BJMDAx
NiIpID09IDApDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcm9vdC0+YnJpZGdl
X3R5cGUgPSBBQ1BJX0JSSURHRV9UWVBFX0NYTDsNCj4gPiArwqDCoMKgwqDCoMKgIGVsc2UNCj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZXZfd2FybigmZGV2aWNlLT5kZXYsICJ1
bmtub3duIGJyaWRnZSB0eXBlIHdpdGggaGlkOiAlc1xuIiwNCj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhY3BpX2hpZCk7DQo+IA0KPiBTZWNvbmQs
IGJlY2F1c2UgImRldmljZSIgaXMgYW4gQUNQSSBkZXZpY2Ugb2JqZWN0IGFuZCBpdCBoYXMgYSBf
SElELA0KPiBpdHMgbmFtZSBzaG91bGQgaW5jbHVkZSB0aGUgSUQgaW4gdGhpcyBjYXNlLCBzbyBp
bmNsdWRpbmcgaXQgaW50byB0aGUNCj4gbWVzc2FnZSBvbmNlIG1vcmUgaXMgcmVkdW5kYW50Lg0K
PiANCj4gQWxzbywgaWYgdGhpcyBpcyBuZWl0aGVyIFBDSWUgbm9yIENYTCwgaXQgc2hvdWxkIGJl
IGEgImxlZ2FjeSIgUENJDQo+IGhvc3QgYnJpZGdlIGFuZCB0aGF0IGlzIG5vdCBhbiBlcnJvciwg
c28gbWF5YmUgdXNlIGRldl9kYmcoIkFzc3VtaW5nDQo+IG5vbi1QQ0llIGhvc3QgYnJpZGdlXG4i
KT8NCg0KQWdyZWVkIHdpdGggYm90aCBwb2ludHMsIEknbGwgbWFrZSB0aGUgY2hhbmdlcyBmb3Ig
djUuDQoNCg0KDQo=
