Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA16692C03
	for <lists+linux-acpi@lfdr.de>; Sat, 11 Feb 2023 01:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjBKA3R (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Feb 2023 19:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjBKA3Q (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Feb 2023 19:29:16 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5791DFB;
        Fri, 10 Feb 2023 16:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676075355; x=1707611355;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9nl9UxG/Mdq5ZYQQmXxP7hxNx25QRIo97Z29rb950Uk=;
  b=EsMO73PkYucs5qcej0jhNDV7MaQ1+n04d9xPVTCnWmp3VwC1EqnEPJT+
   FsXqVUzM8FuXJEQpHePZpktrvCjtt/ZG0MZIpDiyznPholLPkPXidoTBM
   qLTFvGdCFIhvmG3rLKdrKdFEQNIO8OFkWWS4P5wKxQHXGRIZwD1c0zDvR
   krzBSpD/2r9JumkoF41WmBnuUbVI7VciHJGZggc+2WadENPMArQs6Wnau
   OUfbH9tQxKfJejXe7A71cH4hS/66xlhq1MfZ8DxcaO9XPasRc42y3ZwiH
   Kf/FhbisG22Ks2/8hpX4XM1vRRnPaiHRHMsx12Lp/gmAvH7GqOEwWXc20
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="416787204"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="416787204"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 16:29:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="756960174"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="756960174"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Feb 2023 16:29:12 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 16:29:06 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 10 Feb 2023 16:29:06 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 10 Feb 2023 16:29:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWWcR39kBuJSptOYBwY70PosiA5CNDUK/NStdiE4a1iJPmA4Uhfo/LqTdfQ2pRDvK/BM7D9L8yYNvwkgxpmOZtl4ufveJeVEt6icogeii7e1hIk08KJgHxNENKlVMnOGt85NUsw3+v79cDp/9bh1YxSiC7pPm/Tkbju6M5JMm2pKPRb6bYoN83CVRs78lT3ZjKnTZa8kU7/N8F+etBQXAOS6/QHw85S8z0ocPuyV61e3EZZsedAyoHZDbx1j43+Ifur9/0/MUGNneZWsCdZ6HZ+w6zsGjha2U+ZYMqO3H1rMhCMHeqlsxFSf52xGfxLyhRby/dEtA3d6PvwGBxJBBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9nl9UxG/Mdq5ZYQQmXxP7hxNx25QRIo97Z29rb950Uk=;
 b=famfFDyG9hx1AdBVhfIbQm05MIPjhLjLY9VMmxmTwZm+G4hw1E41HLiZTV6jUck7zqDuELuChKnPEvcrlgNtJt4Rk0r3pLW7tzq/PyLdjw9z4SrjBil/8I5Z/laOHL9tiJPudMjGc7qK+b5/ALfR/Az6i2dolFLIE9nnaUMBN6aRWpTNfDCPlo3VC6da7pLN7PS+nCJZ8gifrrieoNtcqxQ3R/BPZ6/nBfrXa3x7K29CG1VCiFIaNbRT42AofI6RWCXlLfUYQsG8pveO2mcNsBkCTTKOd4C+N+tnw6XsjCdxJPdl7Xbxp5a8V21mA29mvcnTa8f44J315velammscg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by PH7PR11MB5943.namprd11.prod.outlook.com (2603:10b6:510:13f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Sat, 11 Feb
 2023 00:29:04 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::35af:d7a8:8484:627]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::35af:d7a8:8484:627%5]) with mapi id 15.20.6086.017; Sat, 11 Feb 2023
 00:29:03 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fan.ni@samsung.com" <fan.ni@samsung.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2 13/20] cxl/region: Add region autodiscovery
Thread-Topic: [PATCH v2 13/20] cxl/region: Add region autodiscovery
Thread-Index: AQHZPS8DDz5dkH6rTE2lebI/82cNa67I5U6A
Date:   Sat, 11 Feb 2023 00:29:02 +0000
Message-ID: <4f10837c5dcc405eac2441aa78a5f2f388fb601a.camel@intel.com>
References: <167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com>
         <167601999958.1924368.9366954455835735048.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <167601999958.1924368.9366954455835735048.stgit@dwillia2-xfh.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.3 (3.46.3-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB3999:EE_|PH7PR11MB5943:EE_
x-ms-office365-filtering-correlation-id: 40a5172f-4524-4516-d501-08db0bc6fa1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IsNnLDQhfQQoTQDhk4El7ugqlL/D1IHQ3SC2EIlYVXQ0ENP3QS5CqUI/4j2dnWoT/lTVsvz+vPbF6q/yp2S4o1sQKruxeeIvhk91MKJdEjVYbv9YwCHHMkbmuXvLAwDcyODuSG2w27JcNpUR2L4LxRm8Wk888Yv8zZYabLBrGC90goAVXO1bSKT2coZ9E1nbjxmjcHI0/pf+n7elm7sMt6yGee2qtGWdT8mKpTo0oWWOssU/0tU0lN7UyDOQNjsvA3+RhAJ9i+y/tk6J0VmxpeI0PwIVQwpK8Yl9H+T3KEE7rbQJoc8BY798xXwQ9rEeG37zvK69FgWoRCoiMC/J+7oNp7eu8QhFP49JTKf+zm3dFsK6hUaiVQagk0Rs3HE5o3sGPY+uDF5R2C5z29jVsKxf/ErX9B/tCYlVKesuqv3pIbx1tVbwfAzyjHrpSRZegw71RIbO91Mfv7DMt9WpKHoddlr6WYR5j5UrsRgRn7VwgsLGkuwWp5Uc9UIjrMj1s0Q/9Bwt1wAd82dBWVFifrQlMiZ2CEsnU/vTbOh0RvGsjJPokUdEjFR2dueN6sN6JRruFjoV/vOcsylhmpHCxtzgjsqzuNb41ee86KvhrYwL4AlhnT2WOivorv4Bbam2SCKWiGkEDkG8rrW96rdYqOzeLMCvbUuX0rXk0wkWtPS8esNDqatDRXM1eL4n+iIB1kTHVqpWi+4/AwHDnkzSztfH0jLUC/h/z1A6aZzDs9I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(396003)(346002)(376002)(136003)(451199018)(36756003)(83380400001)(122000001)(38100700002)(82960400001)(316002)(6506007)(26005)(186003)(110136005)(54906003)(478600001)(71200400001)(966005)(2906002)(6486002)(38070700005)(8936002)(5660300002)(41300700001)(66476007)(86362001)(2616005)(6512007)(66556008)(76116006)(91956017)(64756008)(8676002)(66946007)(4326008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bTFFWThleXRSbnhEaW13MUtOMWF3RXFzU1ZqRkh2L1ZDRm1paGFnSkthYVVt?=
 =?utf-8?B?RkZhSmZpRXhKVHpEUTY0YzlSZ2JPSFlIc0tubUQ4MGtIVjVuNHFmU2hDOUdx?=
 =?utf-8?B?NnJZTSt5WWFCRElPY2pQemg0bkl5R3hpaWFjZnUydkVONUxPb3dvWTNTYy9l?=
 =?utf-8?B?amFHSDNoMjNzelhhcTQraC9nVFZLZTk4MlY3Yk9Ja2RkZ3BvaVIrZU5PNnZr?=
 =?utf-8?B?TGVHUm9UL20xRnVlem5obFRWS2JBMXUzNnN2Qm5qWmt0T2ZjSUlqTjA3b1lP?=
 =?utf-8?B?ZXRQOFB3RjlmNit1VVF0a0s4bjg5eS8yNmFVbXZWQ2RUWDE4YVNBQW5EdEUr?=
 =?utf-8?B?eXRLRU1RdU4xUnZma1pyaTk5Z0xIaEJFN1QwWDV5VlFFRisrZ3p5Rnd3TWZr?=
 =?utf-8?B?RG40ZWp4dExVYXArY3hzeHVIQ2JCdmJTQXEyUHhyVFUrYlNUclJ5bjdZNGJo?=
 =?utf-8?B?bStUVXdHSGNCSmdId25qWXRKdjh6L3VjR1hrMnpLeE1mTWp2Sy9MODhYRVAw?=
 =?utf-8?B?b1hpN3JLbjFKcGo4K1ExUVRpeVNOY1QrUWxnUTMwd1dBK2cralgyNWgzNklz?=
 =?utf-8?B?ek02YWZ3UFFQYzJpNjhmNE1qQkQzdnV4WXpESWo5Rko5dEoyaTdzSmxVbjFR?=
 =?utf-8?B?ZkJmZDgvR1diS083M2JoM2JEUzVoYmd6WURZVzA2Mi9PQTN5RUk2NzRaNERj?=
 =?utf-8?B?N1ArZzFRR3ZlR00wc0J2cU1zTkJRQk1lbWNMdWhxaW1haXc4ZmFPWkRwUjkz?=
 =?utf-8?B?bTEyQWxCNU5PK3NJSExvUlZJenVXc3BxRHF5dkhudlR4aU9RTUIzYWliZXla?=
 =?utf-8?B?NFR6azY5ZXVkaU9GL0RhRHBGd0lVaHNWU1pyMUpaSkhFcklMaW9Xekgzc1o1?=
 =?utf-8?B?WE9XV3NZOEJnaHNlR2Q5ejZYL3lkTFJtYU9vMndQM1E3R0xoZG5YWGtVQW43?=
 =?utf-8?B?bUF3cmF2a1FBNWNoVUJUYWxJVHYzckJpQ2l3UllvTVVRZ0ovMUlzU3hJK3hZ?=
 =?utf-8?B?OU85b3NlYndDaks5Y2syQ1h2TU83WVlKTnMrMy9kMitiWGplRFgvOFVHMWxN?=
 =?utf-8?B?dVlXeE10S0llTWwyb0U5akN4RlFJTFNxcThnZ3AzU2hkVUNzamZvS0ZmWTEy?=
 =?utf-8?B?cG8zVFN5Z3hhd2tlbG1Vc01BTThwbnRSeWFsS3FKcEFBbVFPT2FVOTNObGpE?=
 =?utf-8?B?MExuRkxGRHUrQ2hNelRkVk5lS1dCWHBkYnJPRHpXNG5lbWNndnlEZDJ1eTh2?=
 =?utf-8?B?ZkJWbG13OVZ6cUlSaUJUV0NhaHdlRTg3bXYzSk9CR3l0c1A0VFZBY2RJaEdW?=
 =?utf-8?B?UEhUM25jR1ZTMzdveUw0Vjk1V3UydTgvelFsdm1mRGVrb1JScHJrZ0hkOXlZ?=
 =?utf-8?B?L1V1TVRoQlc1UzhmZHByRUorck9XbFJoUEV1VE5wZHllTnM5N0FxSmlDQnFY?=
 =?utf-8?B?NytuR0tkd256cmptN2g0NHBCOEM3bUk3WVFENk1UUDg5bmZkT3NtUjFKWFBE?=
 =?utf-8?B?bTViVTlVZm00dUtPZGNXU3FEVjYzQXpoTjFuRXpKdk1QNEF4dDJJNVczZFJn?=
 =?utf-8?B?MU5TUnB4eXdvSXpZbGNXOElpeVAyMTRpQXp2b2dpazEyZXB6eXFsQlB3NTBI?=
 =?utf-8?B?RW8yK3VBNmpWZ2NwWlJpL2ZUcWRlcnFiUVpNRCthaHFjbGlJNElNNUcvYmtp?=
 =?utf-8?B?V3JjdzRNZjluWmluOVNReFFGbmp2TGlGcUw3emFpQ0hnUHZub2p4b0pGZCtP?=
 =?utf-8?B?SlRUaU93bWZqNVNvZkxZZnYxMFg3Z1pZVlFSSEw0OW5VWTN0YmVNZlZYeDdh?=
 =?utf-8?B?eUVJb1NCSk0wZktqMnV0Y3BQcTBWTlh3LzFrUFZkZUpKam1nV2hZQlFiS1RD?=
 =?utf-8?B?UmhVdCtsbWNKcmE3cURBeVdCVnhDSHNuaCtIRzg2MVB6WGRZODhjM1A5UTJY?=
 =?utf-8?B?MUwvVVJ4TXJuNkhRUkVxMXltL04yUDBmMWhiMHRpZzFsbTRXUStuTDZIOUIv?=
 =?utf-8?B?TDVXUVlabnhua1lobUl3VDBLcy9vZERkNkdERUZ1alZEMVdFU3dNWU1WK3FL?=
 =?utf-8?B?VTU3ckxyTVNvNW5kNUE1amdqaEd3RmVrR3JEa1d6QjlLNVZQUjcrK0pjS2Nu?=
 =?utf-8?B?VHhGT2xRaFpTa2VZRDRWUGZRRUpZVTY5R3NqY0V0bkx5dWJ1K0tPYTd6VEd3?=
 =?utf-8?B?OUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE3F278E8014B346842376061123CCBF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40a5172f-4524-4516-d501-08db0bc6fa1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2023 00:29:03.0055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 16hAgGrNkk+mZbUkJOlFsfUj/+7or+ZaEcapOzdeAB5u3bg0iRDDJs3CbiLTe0JR/fwsgTUkjLrgGjfC32d6GeTaG8tc5rcfp+NI/W5doPU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5943
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

T24gRnJpLCAyMDIzLTAyLTEwIGF0IDAxOjA2IC0wODAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6Cj4g
UmVnaW9uIGF1dG9kaXNjb3ZlcnkgaXMgYW4gYXN5bmNocm9ub3VzIHN0YXRlIG1hY2hpbmUgYWR2
YW5jZWQgYnkKPiBjeGxfcG9ydF9wcm9iZSgpLiBBZnRlciB0aGUgZGVjb2RlcnMgb24gYW4gZW5k
cG9pbnQgcG9ydCBhcmUgZW51bWVyYXRlZAo+IHRoZXkgYXJlIHNjYW5uZWQgZm9yIGFjdGl2ZWx5
IGVuYWJsZWQgaW5zdGFuY2VzLiBFYWNoIGFjdGl2ZSBkZWNvZGVyIGlzCj4gZmxhZ2dlZCBmb3Ig
YXV0by1hc3NlbWJseSBDWExfREVDT0RFUl9GX0FVVE8gYW5kIGF0dGFjaGVkIHRvIGEgcmVnaW9u
Lgo+IElmIGEgcmVnaW9uIGRvZXMgbm90IGFscmVhZHkgZXhpc3QgZm9yIHRoZSBhZGRyZXNzIHJh
bmdlIHNldHRpbmcgb2YgdGhlCj4gZGVjb2RlciBvbmUgaXMgY3JlYXRlZC4gVGhhdCBjcmVhdGlv
biBwcm9jZXNzIG1heSByYWNlIHdpdGggb3RoZXIKPiBkZWNvZGVycyBvZiB0aGUgc2FtZSByZWdp
b24gYmVpbmcgZGlzY292ZXJlZCBzaW5jZSBjeGxfcG9ydF9wcm9iZSgpIGlzCj4gYXN5bmNocm9u
b3VzLiBBIG5ldyAnc3RydWN0IGN4bF9yb290X2RlY29kZXInIGxvY2ssIEByYW5nZV9sb2NrLCBp
cwo+IGludHJvZHVjZWQgdG8gbWl0aWdhdGUgdGhhdCByYWNlLgo+IAo+IE9uY2UgYWxsIGRlY29k
ZXJzIGhhdmUgYXJyaXZlZCwgInAtPm5yX3RhcmdldHMgPT0gcC0+aW50ZXJsZWF2ZV93YXlzIiwK
PiB0aGV5IGFyZSBzb3J0ZWQgYnkgdGhlaXIgcmVsYXRpdmUgZGVjb2RlIHBvc2l0aW9uLiBUaGUg
c29ydCBhbGdvcml0aG0KPiBpbnZvbHZlcyBmaW5kaW5nIHRoZSBwb2ludCBpbiB0aGUgY3hsX3Bv
cnQgdG9wb2xvZ3kgd2hlcmUgb25lIGxlZyBvZiB0aGUKPiBkZWNvZGUgbGVhZHMgdG8gZGV2aWNl
QSBhbmQgdGhlIG90aGVyIGRldmljZUIuIEF0IHRoYXQgcG9pbnQgaW4gdGhlCj4gdG9wb2xvZ3kg
dGhlIHRhcmdldCBvcmRlciBpbiB0aGUgJ3N0cnVjdCBjeGxfc3dpdGNoX2RlY29kZXInIGluZGlj
YXRlcwo+IHRoZSByZWxhdGl2ZSBwb3NpdGlvbiBvZiB0aG9zZSBlbmRwb2ludCBkZWNvZGVycyBp
biB0aGUgcmVnaW9uLgo+IAo+ID4gRnJvbSB0aGF0IHBvaW50IHRoZSByZWdpb24gZ29lcyB0aHJv
dWdoIHRoZSBzYW1lIHNldHVwIGFuZCB2YWxpZGF0aW9uCj4gc3RlcHMgYXMgdXNlci1jcmVhdGVk
IHJlZ2lvbnMsIGJ1dCBpbnN0ZWFkIG9mIHByb2dyYW1taW5nIHRoZSBkZWNvZGVycwo+IGl0IHZh
bGlkYXRlcyB0aGF0IGRyaXZlciB3b3VsZCBoYXZlIHdyaXR0ZW4gdGhlIHNhbWUgdmFsdWVzIHRv
IHRoZQo+IGRlY29kZXJzIGFzIHdlcmUgYWxyZWFkeSBwcmVzZW50Lgo+IAo+IFRlc3RlZC1ieTog
RmFuIE5pIDxmYW4ubmlAc2Ftc3VuZy5jb20+Cj4gTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvci8xNjc1NjQ1NDA5NzIuODQ3MTQ2LjE3MDk2MTc4NDMzMTc2MDk3ODMxLnN0Z2l0QGR3aWxs
aWEyLXhmaC5qZi5pbnRlbC5jb20KPiBTaWduZWQtb2ZmLWJ5OiBEYW4gV2lsbGlhbXMgPGRhbi5q
LndpbGxpYW1zQGludGVsLmNvbT4KPiAtLS0KPiDCoGRyaXZlcnMvY3hsL2NvcmUvaGRtLmPCoMKg
wqAgfMKgwqAgMTEgKwo+IMKgZHJpdmVycy9jeGwvY29yZS9wb3J0LmPCoMKgIHzCoMKgwqAgMiAK
PiDCoGRyaXZlcnMvY3hsL2NvcmUvcmVnaW9uLmMgfMKgIDQ5NyArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKy0KPiDCoGRyaXZlcnMvY3hsL2N4bC5owqDCoMKgwqDC
oMKgwqDCoCB8wqDCoCAyOSArKysKPiDCoGRyaXZlcnMvY3hsL3BvcnQuY8KgwqDCoMKgwqDCoMKg
IHzCoMKgIDQ4ICsrKysKPiDCoDUgZmlsZXMgY2hhbmdlZCwgNTc2IGluc2VydGlvbnMoKyksIDEx
IGRlbGV0aW9ucygtKQo+IAo+IApPbmUgcXVlc3Rpb24gYmVsb3csIGJ1dCBvdGhlcndpc2UgbG9v
a3MgZ29vZCwKClJldmlld2VkLWJ5OiBWaXNoYWwgVmVybWEgPHZpc2hhbC5sLnZlcm1hQGludGVs
LmNvbT4KCjwuLj4KCj4gwqAKPiArc3RhdGljIGludCBjeGxfcmVnaW9uX2F0dGFjaF9hdXRvKHN0
cnVjdCBjeGxfcmVnaW9uICpjeGxyLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBjeGxfZW5kcG9pbnRfZGVj
b2RlciAqY3hsZWQsIGludCBwb3MpCj4gK3sKPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgY3hsX3Jl
Z2lvbl9wYXJhbXMgKnAgPSAmY3hsci0+cGFyYW1zOwo+ICsKPiArwqDCoMKgwqDCoMKgwqBpZiAo
Y3hsZWQtPnN0YXRlICE9IENYTF9ERUNPREVSX1NUQVRFX0FVVE8pIHsKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgZGV2X2VycigmY3hsci0+ZGV2LAo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIiVzOiB1bmFibGUgdG8gYWRkIGRlY29kZXIg
dG8gYXV0b2RldGVjdGVkIHJlZ2lvblxuIiwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGRldl9uYW1lKCZjeGxlZC0+Y3hsZC5kZXYpKTsKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FSU5WQUw7Cj4gK8KgwqDCoMKgwqDCoMKg
fQo+ICsKPiArwqDCoMKgwqDCoMKgwqBpZiAocG9zID49IDApIHsKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgZGV2X2RiZygmY3hsci0+ZGV2LCAiJXM6IGV4cGVjdGVkIGF1dG8gcG9z
aXRpb24sIG5vdCAlZFxuIiwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGRldl9uYW1lKCZjeGxlZC0+Y3hsZC5kZXYpLCBwb3MpOwo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVJTlZBTDsKPiArwqDCoMKgwqDCoMKgwqB9Cj4g
Kwo+ICvCoMKgwqDCoMKgwqDCoGlmIChwLT5ucl90YXJnZXRzID49IHAtPmludGVybGVhdmVfd2F5
cykgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkZXZfZXJyKCZjeGxyLT5kZXYs
ICIlczogbm8gbW9yZSB0YXJnZXQgc2xvdHMgYXZhaWxhYmxlXG4iLAo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGV2X25hbWUoJmN4bGVkLT5jeGxkLmRl
dikpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVOWElPOwo+ICvC
oMKgwqDCoMKgwqDCoH0KPiArCj4gK8KgwqDCoMKgwqDCoMKgLyoKPiArwqDCoMKgwqDCoMKgwqAg
KiBUZW1wb3JhcmlseSByZWNvcmQgdGhlIGVuZHBvaW50IGRlY29kZXIgaW50byB0aGUgdGFyZ2V0
IGFycmF5LiBZZXMsCj4gK8KgwqDCoMKgwqDCoMKgICogdGhpcyBtZWFucyB0aGF0IHVzZXJzcGFj
ZSBjYW4gdmlldyBkZXZpY2VzIGluIHRoZSB3cm9uZyBwb3NpdGlvbgo+ICvCoMKgwqDCoMKgwqDC
oCAqIGJlZm9yZSB0aGUgcmVnaW9uIGFjdGl2YXRlcywgYW5kIG11c3QgYmUgY2FyZWZ1bCB0byB1
bmRlcnN0YW5kIHdoZW4KPiArwqDCoMKgwqDCoMKgwqAgKiBpdCBtaWdodCBiZSByYWNpbmcgcmVn
aW9uIGF1dG9kaXNjb3ZlcnkuCj4gK8KgwqDCoMKgwqDCoMKgICovCgpXb3VsZCBpdCBiZSB3b3J0
aHdoaWxlIGFkZGluZyBhbiBhdHRyaWJ1dGUgYXJvdW5kIHRoaXMgLSBlaXRoZXIgdG8KZGlzdGlu
Z3Vpc2ggYW4gYXV0by1hc3NlbWJsZWQgcmVnaW9uIGZyb20gYSB1c2VyLWNyZWF0ZWQgb25lLCBv
cgpwZXJoYXBzIGJldHRlciAtIHNvbWV0aGluZyB0byBtYXJrIHRoZSBhc3NlbWJseSBjb21wbGV0
ZT8gY3hsLWxpc3QKZG9lc24ndCBoYXZlIHRvIGRpc3BsYXkgdGhpcyBhdHRyaWJ1dGUgYXMgaXMs
IGJ1dCBtYXliZSBpdCBjYW4gbWFrZSBhCmRlY2lzaW9uIHRvIG1hcmsgaXQgYXMgaWRsZSB3aGls
ZSBhc3NlbWJseSBpcyBwZW5kaW5nLCBvciBtYXliZSBldmVuCnJlZnVzZSB0byBhZGRfY3hsX3Jl
Z2lvbigpIGZvciBpdCBlbnRpcmVseT8KClRoaXMgY2FuIGJlIGEgZm9sbG93LW9uIHRvby4KCj4g
K8KgwqDCoMKgwqDCoMKgcG9zID0gcC0+bnJfdGFyZ2V0czsKPiArwqDCoMKgwqDCoMKgwqBwLT50
YXJnZXRzW3Bvc10gPSBjeGxlZDsKPiArwqDCoMKgwqDCoMKgwqBjeGxlZC0+cG9zID0gcG9zOwo+
ICvCoMKgwqDCoMKgwqDCoHAtPm5yX3RhcmdldHMrKzsKPiArCj4gK8KgwqDCoMKgwqDCoMKgcmV0
dXJuIDA7Cj4gK30KPiArCj4gCgo=
