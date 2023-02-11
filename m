Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC61692C31
	for <lists+linux-acpi@lfdr.de>; Sat, 11 Feb 2023 01:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjBKAky (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Feb 2023 19:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjBKAkx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Feb 2023 19:40:53 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE46C6C7DC;
        Fri, 10 Feb 2023 16:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676076047; x=1707612047;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8fBNjJscA6O2iRhqTW8OJZQ3bvZbo9q/Nxd3482rRsM=;
  b=a98hpXZsP1XLs5YXGdaSl4lM2IGX2MXiisGqt38RjOKyG2x8fRdUDU/c
   jtz7Lf9N/PZghHCzNTf6aiUiBHd4LpGnoy7cepjXNNfE1/PLi21ghQaG/
   9KNpiuTbR4BoQcVWAWkT9LGka917lWDhZ8o2ufpmVZe6liqk20ZE+v+ZO
   B82q0YqztJ1JaeQ60X9INS1c0r4jkNcbNwZ3FVEvvONPSW+77ZSkBxInN
   qG/mWiCJtLOArAzQxisJ1znoEE6LKqy4YeOH8lqNAn+PGo6KNG4CUEniQ
   CdtJMOlVDOpJ3W04PRhX5qsgxggcOlpA0EFIvt41z1VWqcjkYT1/914lv
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="395174502"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="395174502"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 16:40:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="645805218"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="645805218"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 10 Feb 2023 16:40:47 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 16:40:46 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 16:40:45 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 10 Feb 2023 16:40:45 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 10 Feb 2023 16:40:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oEHzb1YexSIgy/ippbZ+xRRO0P0PG7Ey2uV5tg3VTM4GU531bHeKx4WVdrxbSawerAt/Vk5/kE3mHnmFopIWx0/xd7785aKbfn3XibmFP320ee3ihkfRC7qtZT+4EaUssNCekG6DuHgiTUGKKVaFg2XBAbDOXZt7Gfrt2YbrP6/Fh5Q0A/T7PshlzMKBvIUIWjyOzta+1ndByIXrSMOget+En2EHZHkkrDwtMRUd/Z7eQGMlFGMKI4ELZ/xhZTcqAd/qvi+3Rfr0F8eZ6FBRYN7+eFxaZJO0H61uIqkb364zH/eOEzMQwmIW+vIsY9CclL9k8TlvtE9YTJrY7REPBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8fBNjJscA6O2iRhqTW8OJZQ3bvZbo9q/Nxd3482rRsM=;
 b=LSi01BULd86tqKhaLu/B9Kk7BeDjRe8A5JXYuXrXXm+ZJi6IxBBQdiCEH/lRzapAtw5XiCsesxSoo8Ql1k8SrfgmFoxAp5nKiXy//Lp9N68Lm6AoxS23S2uUwMGa7pjIKqlND9j8aYJKxRZqho5Gzh3omaME7JoK+efd4g6ZS5n4ZhLf+k2yAUvIBpTOH10P1X3mJEgcaq/NIHfNZqM+kxhn8oXG5BqIRBWy6BSzsXCZaKzH8SpfVMffN+rWXyEvfYVeTIeEo07HVqIJape4EOdQFD9+3zK8UPffWAzMMuCDVsH7jfPvPPjaMH6xRFgh1dWm/yUI2evGUcAj8FxFAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by PH7PR11MB6031.namprd11.prod.outlook.com (2603:10b6:510:1d2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Sat, 11 Feb
 2023 00:40:39 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::35af:d7a8:8484:627]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::35af:d7a8:8484:627%5]) with mapi id 15.20.6086.017; Sat, 11 Feb 2023
 00:40:39 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fan.ni@samsung.com" <fan.ni@samsung.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2 15/20] dax/hmem: Move HMAT and Soft reservation probe
 initcall level
Thread-Topic: [PATCH v2 15/20] dax/hmem: Move HMAT and Soft reservation probe
 initcall level
Thread-Index: AQHZPS8Gd6h73Sipp0ux0Xrw8fbC1a7I6IyA
Date:   Sat, 11 Feb 2023 00:40:39 +0000
Message-ID: <56afc05eec2ac63af7984fffdfb8a5ab2e1678ec.camel@intel.com>
References: <167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com>
         <167602001107.1924368.11562316181038595611.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <167602001107.1924368.11562316181038595611.stgit@dwillia2-xfh.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.3 (3.46.3-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB3999:EE_|PH7PR11MB6031:EE_
x-ms-office365-filtering-correlation-id: 8af63257-61c5-4892-0fbb-08db0bc8990c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f+7eCNu/Kv0U8lprsbIGsMV8yXkEDC+V14zJ9SS9kpVkgByryS/CU2vnoGZVQanrcoESMe4NwXFM2e8XCmymu3nZKtp0pvjMJ7FQXPogfiK4HjHDBDZA4DyxxHhd3Tkf3e+BBCaUe/6eVifqevb3v0vVwUcrbeRRLl4drxS4C5WcAmjNOqSoXVtsLc6j4YhDO7NwPZDlcOVXJ8rGNxsMyMDz2kqg/IxDa75k7MNu+1GZ2s5WdGyfSHsx3W370CZYJqDZStobYGi7LpUvd/S/2YDZdjZSfgYAuPMYk/dsc718cY/xqTCVK3UNZ8uM7aYaQTRJE7wHGQexJVUY930yuyEgdBT2MSczJlVKXfSw1cyx9wH7yJHKYPQuE9KnH4XbOd68g4tbQdBFaM0qOWF88u36fLsdzASaLPt+tbfWyTPgASMZgSNEmK5BwSw0dnrkTXYIJFFIPUutP6BS7YDPWmrQUweCRwnjrH+eubUhIoSYQXGLrGHERTv0HldmaoHpHjqBwXtBYF+I11JpP93YdNUTKcMXPUkQrvP4/w5tJrl4m5rjqkQyNbqne4Wd8SKvcCGwsWl9YRDIkl6Ks4RfNgqckp3kcOU76SD/arj2eR5bo07abQ+w6HL7vuN8uav26tE7ALX7Uy6RqWxoUNIhsVFdGGb6VVWS6t8955+bzS/ysWA4N1Tazd5kTAJU/KbOKWQAhrm6NMK/Bf6P+2ppmV1mMxIuI43tX8jwqlurHmM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(136003)(366004)(346002)(39860400002)(451199018)(38070700005)(36756003)(82960400001)(26005)(6506007)(86362001)(6512007)(186003)(478600001)(966005)(66476007)(2616005)(83380400001)(122000001)(41300700001)(5660300002)(8936002)(4326008)(2906002)(64756008)(54906003)(110136005)(8676002)(71200400001)(316002)(66556008)(91956017)(66446008)(38100700002)(76116006)(66946007)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?end0YmdKcVh4RjZIdTJsemFLTTM2clFzUysyQWg4QmZNRDBuRnh0cmZyU0hS?=
 =?utf-8?B?QTVPcFdsWHBtTFdRaXQyeTJ4WWFLUlJONkE3a3FDdmNnUk9oR21URm5ORFdl?=
 =?utf-8?B?TElodDZsbFFFVFlwTjRMUE41TFM4M0FQdUNoQUtHWFZlMFRlK2VpdEtiY2Jz?=
 =?utf-8?B?M2xmS2FIV01CemJnNUIrcnZhYkFjQjVEUXNrZzlvMnVUT1dRNEkrSWlCMzZT?=
 =?utf-8?B?R28wbmJCRnNMa2FmcnlsSFczSlcxU3hmbEMvM0tQK25aUytDajQ2MHFTMTkw?=
 =?utf-8?B?enJvemNRcmI1cWRQUVp3dk9hbi96dlZ3TG12eWJYdExUWnNUQ0J5b3Nvb25j?=
 =?utf-8?B?UTZBek8yd2l2WTR6M3IySzAyckJzZ0pyU0lrcDJ0VDgrZk1WekJGeWg2Rmk1?=
 =?utf-8?B?Z2RvdE9QMmVsV1FXUzlJbmNzNDYvamdmT09RZ1pXT2ZETUhsb0RUWmM3Uy9v?=
 =?utf-8?B?OHNlaVJnYW56SDZBcEprUmhVd2x1VE8rRkRNU1RIZ1REZVQxQVZLeXN0Nm9a?=
 =?utf-8?B?ZUtSV25aZGZHUGhWb3ZsZDJuSDlHRFV2OWJWUlZUZXlPYmJoVnU5NE1EOXd3?=
 =?utf-8?B?OXZlakx6enFNcmx2bDRwVWwvbngrREg0K0ZWMytwbVNxUmppUkM5NGRaNld5?=
 =?utf-8?B?NUk2NElXWU1pN3pkd3VIR0RBWHdaWkdXSlN0V0dhTFp6emtKOHNVMng2bGVs?=
 =?utf-8?B?ZURQdGREdUFYb0crdHJ2cHpQcFAxTFRWUVV6NHZjenUxa3IrU3R0K3gzWVlD?=
 =?utf-8?B?VDVVZTJjTTlBS3RUcmRJUzlXUTZJVHJ1dzRWY2xhWll5aWxoakYxajQzWmZm?=
 =?utf-8?B?dGw4NW8zaU5vYUkyUWxSOGdRUE83eHVuc0V5QjY3YlFWZkxCTTZDNTVoVjBU?=
 =?utf-8?B?Y212N2xSWHFoMVlFNWNhQlB2ZmpzY0ZzYTdEYTRDOTFjdTczc3ZTWmU4dG9E?=
 =?utf-8?B?VGg2TXJDOTZsRkdSWU5CTnIwSFZkNndaMXRrMVJjNjkwamJuK0l1SzJOaVA3?=
 =?utf-8?B?aHdINDh6RHJ6dE51Z3pxZG9QZ09YcEZxNlZ4QzFyaE12ZE45bWp4blVmb2pm?=
 =?utf-8?B?QjZwa0NaeVlEdHAyaXc1UTB1S0ZicWtNNVZxL2ZWZUxDM2tDbHgyN0swU3Zj?=
 =?utf-8?B?RFlYb3J5T2RtSkplejdZTGZyNlFnN2tjbUM0NTNCZHkrcStuaTU3YXJ5VkxX?=
 =?utf-8?B?Nk9qUlduYnd2MUtqYXBZZmdCc1U2MzRCeEg1WFNBeUVRMDROM3lXaUdpVFNj?=
 =?utf-8?B?b2dYcUI4eUtlQjlGa0pBMVdOdHY0NVZ1R2t6ZStZMFhmS28vVFFTMHhwNVF6?=
 =?utf-8?B?dXN4RFNhdzNqNC9DNmJKeHJOS1NuSGFqQWw0MTRJcDZqVHRHZU1DSUJWOWMw?=
 =?utf-8?B?TWprZVk2OEZKb3ZiUGNVeE9hYUQyMTdEcWR4SW8ydWFJZG9ESzFjMm9IaHBo?=
 =?utf-8?B?REFLN0NBajRDQ0N4dWx4Z1FNUWRZN1R5blVOZks4WTJISTYxVGtPZnRyY3VF?=
 =?utf-8?B?MXp5ZGdNSVNzVkFyQlNSdWVTRUJoUG5xTUdHNit1RWFydDlLdC81dTEyWGJw?=
 =?utf-8?B?TDB1aldQcXBpaXJvUkFZU2pubHppeXM0ZDhtcVZTZ3NHa2IwVkd4cnJEeGdZ?=
 =?utf-8?B?c0YwdWlTTHR6Y29CejdPUER6Qjc1bTZlQyswWGdySzJVQW51NFVZS1V3MHpj?=
 =?utf-8?B?Y0dIZEZSNUFuKzMvSmRsTTgvMWxpZWxaSkNsS2pzNGx4Y25zejNqT3U4cE5T?=
 =?utf-8?B?UDhpTk5WN3Uxd0oxbS9ZU0luVzlHYW5aUGFTVzhrZDVxeDNLOFY0SXpYckJw?=
 =?utf-8?B?S01mcUEwSUsvbUJiODUwNHdhQ05DR0c1bVpMTUQ3c3pSUW5hYldVYVozQktm?=
 =?utf-8?B?OHlxN25OcDZ2c2lCT3I0bGpPdU9xR3NvSTk1djNFc3NLbUd2a3RjN0JGRFZh?=
 =?utf-8?B?Q0ZicDZhKy9Najl1cjJXczgzVzNBZ1JRdDNLaThncHQ2QXJQQVp2ejJxb1Bl?=
 =?utf-8?B?ZnlqK0QyLzR0S3FaVnRRclhyaGRXNDBPVzJ5R2VSODI4UkxrQng3UlRGSC9F?=
 =?utf-8?B?L0I2ZUM0MS9FZU5xTEhPQnNzQkFOYzlrakVtRmtFWXcxVWRGeitGK3Vja3hn?=
 =?utf-8?B?NFFFbWJUZ1VoeGhmSHBwSTZSaGdMdTlVL0ZkUTBUTTNpU0NVZk9UQ05WKzZV?=
 =?utf-8?B?bUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F538C89C435DCB4AA368EE006004BC26@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af63257-61c5-4892-0fbb-08db0bc8990c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2023 00:40:39.1501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RnBLw5Lpw/bCYpsTFz+5psBR/xrVw7QdUdcC11T2weNSEAsrW1XaRwOARMds+BuY75mCX3MF+577hOABA/9Q4J+hw5VLJtYB0SZLNHGH77I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6031
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
IEluIHByZXBhcmF0aW9uIGZvciBtb3ZpbmcgbW9yZSBmaWx0ZXJpbmcgb2YgImhtZW0iIHJhbmdl
cyBpbnRvIHRoZQ0KPiBkYXhfaG1lbS5rbyBtb2R1bGUsIHVwZGF0ZSB0aGUgaW5pdGNhbGwgbGV2
ZWxzLiBITUFUIHJhbmdlIHJlZ2lzdHJhdGlvbg0KPiBtb3ZlcyB0byBzdWJzeXNfaW5pdGNhbGwo
KSB0byBiZSBkb25lIGJlZm9yZSBTb2Z0IFJlc2VydmF0aW9uIHByb2JpbmcsDQo+IGFuZCBTb2Z0
IFJlc2VydmF0aW9uIHByb2JpbmcgaXMgbW92ZWQgdG8gZGV2aWNlX2luaXRjYWxsKCkgdG8gYmUg
ZG9uZQ0KPiBiZWZvcmUgZGF4X2htZW0ua28gaW5pdGlhbGl6YXRpb24gaWYgaXQgaXMgYnVpbHQt
aW4uDQo+IA0KPiBUZXN0ZWQtYnk6IEZhbiBOaSA8ZmFuLm5pQHNhbXN1bmcuY29tPg0KPiBMaW5r
OiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzE2NzU2NDU0MjEwOS44NDcxNDYuMTAxMTM5NzI4
ODE3ODI0MTkzNjMuc3RnaXRAZHdpbGxpYTIteGZoLmpmLmludGVsLmNvbQ0KPiBTaWduZWQtb2Zm
LWJ5OiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4NCj4gLS0tDQo+IMKg
ZHJpdmVycy9hY3BpL251bWEvaG1hdC5jwqAgfMKgwqDCoCAyICstDQo+IMKgZHJpdmVycy9kYXgv
aG1lbS9NYWtlZmlsZSB8wqDCoMKgIDMgKystDQo+IMKgZHJpdmVycy9kYXgvaG1lbS9kZXZpY2Uu
YyB8wqDCoMKgIDIgKy0NCj4gwqAzIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMyBk
ZWxldGlvbnMoLSkNCg0KTG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IFZpc2hhbCBWZXJtYSA8
dmlzaGFsLmwudmVybWFAaW50ZWwuY29tPg0KDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9h
Y3BpL251bWEvaG1hdC5jIGIvZHJpdmVycy9hY3BpL251bWEvaG1hdC5jDQo+IGluZGV4IDYwNWEw
YzcwNTNiZS4uZmYyNDI4MjMwMWFiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2FjcGkvbnVtYS9o
bWF0LmMNCj4gKysrIGIvZHJpdmVycy9hY3BpL251bWEvaG1hdC5jDQo+IEBAIC04NjksNCArODY5
LDQgQEAgc3RhdGljIF9faW5pdCBpbnQgaG1hdF9pbml0KHZvaWQpDQo+IMKgwqDCoMKgwqDCoMKg
wqBhY3BpX3B1dF90YWJsZSh0YmwpOw0KPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIDA7DQo+IMKg
fQ0KPiAtZGV2aWNlX2luaXRjYWxsKGhtYXRfaW5pdCk7DQo+ICtzdWJzeXNfaW5pdGNhbGwoaG1h
dF9pbml0KTsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZGF4L2htZW0vTWFrZWZpbGUgYi9kcml2
ZXJzL2RheC9obWVtL01ha2VmaWxlDQo+IGluZGV4IDU3Mzc3YjRjM2Q0Ny4uZDRjNGNkNmJjY2Q3
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2RheC9obWVtL01ha2VmaWxlDQo+ICsrKyBiL2RyaXZl
cnMvZGF4L2htZW0vTWFrZWZpbGUNCj4gQEAgLTEsNiArMSw3IEBADQo+IMKgIyBTUERYLUxpY2Vu
c2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiAtb2JqLSQoQ09ORklHX0RFVl9EQVhfSE1FTSkgKz0g
ZGF4X2htZW0ubw0KPiArIyBkZXZpY2VfaG1lbS5vIGRlbGliZXJhdGVseSBwcmVjZWRlcyBkYXhf
aG1lbS5vIGZvciBpbml0Y2FsbCBvcmRlcmluZw0KPiDCoG9iai0kKENPTkZJR19ERVZfREFYX0hN
RU1fREVWSUNFUykgKz0gZGV2aWNlX2htZW0ubw0KPiArb2JqLSQoQ09ORklHX0RFVl9EQVhfSE1F
TSkgKz0gZGF4X2htZW0ubw0KPiDCoA0KPiDCoGRldmljZV9obWVtLXkgOj0gZGV2aWNlLm8NCj4g
wqBkYXhfaG1lbS15IDo9IGhtZW0ubw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9kYXgvaG1lbS9k
ZXZpY2UuYyBiL2RyaXZlcnMvZGF4L2htZW0vZGV2aWNlLmMNCj4gaW5kZXggOTAzMzI1YWFjOTkx
Li4yMDc0OWM3ZmFiODEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZGF4L2htZW0vZGV2aWNlLmMN
Cj4gKysrIGIvZHJpdmVycy9kYXgvaG1lbS9kZXZpY2UuYw0KPiBAQCAtMTA0LDQgKzEwNCw0IEBA
IHN0YXRpYyBfX2luaXQgaW50IGhtZW1faW5pdCh2b2lkKQ0KPiDCoCAqIEFzIHRoaXMgaXMgYSBm
YWxsYmFjayBmb3IgYWRkcmVzcyByYW5nZXMgdW5jbGFpbWVkIGJ5IHRoZSBBQ1BJIEhNQVQNCj4g
wqAgKiBwYXJzaW5nIGl0IG11c3QgYmUgYXQgYW4gaW5pdGNhbGwgbGV2ZWwgZ3JlYXRlciB0aGFu
IGhtYXRfaW5pdCgpLg0KPiDCoCAqLw0KPiAtbGF0ZV9pbml0Y2FsbChobWVtX2luaXQpOw0KPiAr
ZGV2aWNlX2luaXRjYWxsKGhtZW1faW5pdCk7DQo+IA0KDQo=
