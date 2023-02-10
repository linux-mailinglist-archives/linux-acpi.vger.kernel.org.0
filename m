Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12FEF692B0A
	for <lists+linux-acpi@lfdr.de>; Sat, 11 Feb 2023 00:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjBJXWJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Feb 2023 18:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjBJXWG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Feb 2023 18:22:06 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9061E284;
        Fri, 10 Feb 2023 15:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676071318; x=1707607318;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=I8J3Hy6dmzk/nC1EcrmBEv7DGAWCvb70N5DUqH46w2s=;
  b=BgVzvmP9YEvxQrR8Vi/qhRZRtynOIDbk4+cYk285NX6MdFh6uwiFdd3k
   oSlPgTpNYg0bCZR5smdgEpOWe9PwWtPo26R+aR8cLa7lxZC0ZrD2rzJ7X
   6zr4FJw6Czw5jCBOCseDGsTS5YaPZcapdH/VkcKFaKormbbSN1NYlxmQQ
   Px24gB5R0UiA6ZKTW2khzpgCwDvpR1IBDUydpH0qCin4ja6BExNKsYWay
   8WU16EQUDSd4nALPryyvFrcAWNA8TAscItPUWz8CS3SnMhLSO5sHa7Vl8
   tOHKuuVTdtVbEFp1V7uoQ5vuV65Y5CmADJHhTPDVQhIEAG6o9gkkl5Ya4
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="328246490"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="328246490"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 15:21:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="997103045"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="997103045"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 10 Feb 2023 15:21:57 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 15:21:57 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 15:21:57 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 10 Feb 2023 15:21:57 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 10 Feb 2023 15:21:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MqjbFHDI7uonp02h5oAvBE2lONr9HAjeufc6qlNgAJ0YcPXLiMmzwM/r3C6Etavs8Y2FgQMdZULQQTl9kOv42VwI3hv7ZqJqaqH7IyPRbrY7ytQ5fn3xTCKI34+Y8QPdhToI7yY6tOwCv1M+GOrRvmHa9NcD0MgtGGcNPEK9t/MpA+dP08KOrR8pef1QWRA7bySUJdj/ma8peBB+FD7NYllEVdXWujLtGUT6lFnLoIGFNJ6F6j5uGsubUCA7sIggRaoTc1nsucwYoamolXF9VntRRyIvilXCUVicLpYhLe3RCtSIbgLWBSPc9ryd/eKpBFiEuo3MBm470mfpLiCR4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8J3Hy6dmzk/nC1EcrmBEv7DGAWCvb70N5DUqH46w2s=;
 b=cZgv/HL66EITf4Q+zVNYPa9PuPfyHqilJYhKWN9fbYsEIB1QttcuMJgi8MV7ar0bwrDkbPmi4eshn8TNO0iA9TojNrRdow/y2Q0cZ8jlHV6wQiXk8sVXmbAxiQf0FsFydmqL0NNCf0yRh0GVYBeCYl6ilsomUPBIsfFunxtKQRIqfqrnV8WydXodQUmwUFjtYCtOdYRklhuJloMp5rb9KcU0fdCcpIhQrjucR49UOiWDS9ltGu5520DzKowodgu2sMnzWoT5QJPa7RcSh6cHZdjKF82UA7H1iLP3aUIHWPB+4bS4whKoI58HqLCdlzxWgsok7W2dKHpmyb9waDPC8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by MW4PR11MB6763.namprd11.prod.outlook.com (2603:10b6:303:20b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.21; Fri, 10 Feb
 2023 23:21:55 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::35af:d7a8:8484:627]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::35af:d7a8:8484:627%5]) with mapi id 15.20.6086.017; Fri, 10 Feb 2023
 23:21:55 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2 12/20] cxl/port: Split endpoint and switch port probe
Thread-Topic: [PATCH v2 12/20] cxl/port: Split endpoint and switch port probe
Thread-Index: AQHZPS79LGHLeBJf20iIzu6wiQkD+q7I0o2A
Date:   Fri, 10 Feb 2023 23:21:54 +0000
Message-ID: <763804dd536fcfc8b5d49fb1412de23852fa7a88.camel@intel.com>
References: <167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com>
         <167601999378.1924368.15071142145866277623.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <167601999378.1924368.15071142145866277623.stgit@dwillia2-xfh.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.3 (3.46.3-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB3999:EE_|MW4PR11MB6763:EE_
x-ms-office365-filtering-correlation-id: f098dd69-7f5f-4dcc-fecf-08db0bbd9939
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LzTtN9KgP4zZvRNPFNUsAdR/UccP+gBODkBWSXU0sVbFA+y0Mq4m++jUwpU6aymPZcY5+zFvK5sgM9JEcQDHPUcmt8vFzPZp1pM66b91FghyRrd/QYiSyJoA9eWzB3/m+EZsE0TuOWqgzEHkmXKGQmL/HD5GViGt6ySk0Sho6ROGqMGWoaaJZYj6pCLW8Bt6fg1GikO73CaIv8klSIc332LmXNab+90CjJfm0XAc4RkEFMf35wb6t9hjriq7eUQB9YOIs+qsujFKJMAfjP9U5bXvGKpAvdrLbRqJnPV6o860u2CyvLbWqcwawtVybXO+neogqQd/Vc3zB4lnNnQakqM3a2Y3GoP61TVwS13Cw2t09j8JMf9EszZO3aKIhgbYU0ULBTUDWn07sNoIG579ThVl+TNXQUvT+HSutWmSyke20w1ZCBww/OZNFYH3asTe85uiJ78qUnnJoiRWrYRbxBGM4WJ6rsu2vBi/Urc9GeXLwkNw//svYC/7o5YqQvXf3N33XfvBaxuQLDMAREV4kF8waXhi9dsJC6vS1zj+XWffY0mGePGxuatRvPNmy3RvhcA/52WUr1k1xPg8CKzBcr0NDb3Tx5wBh8HIgXgp5Crrnc6p3htj9jpN2/bSdIOIRH+bBVcZOZAoqcf4zM6flxAKeYN2B0bquq/7oBPnhAs6VNL/s90+NSH+v7mNI04IKceSWZTJ9jB3wr03QF+uqQTMd9vVOIcGm/4bhmpIn4Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(366004)(136003)(376002)(396003)(451199018)(110136005)(316002)(54906003)(91956017)(5660300002)(8676002)(76116006)(4326008)(66946007)(66556008)(66476007)(41300700001)(66446008)(64756008)(82960400001)(38070700005)(86362001)(36756003)(38100700002)(122000001)(6512007)(6506007)(26005)(71200400001)(6486002)(966005)(186003)(2616005)(2906002)(8936002)(478600001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmZZelo5b0pMMkRFMDczWm40WGtHQy9qeVVYNlpVR21vNmhuUXNYRXVHWGpa?=
 =?utf-8?B?M0RtSE11L3dUK1FNR3JFUG45UjF0ODZQVDhFQjdMdlpiUnhzZ0NwVHdreE53?=
 =?utf-8?B?V2JrQ0xJaFpycC9kRDhXQjVWU3RNZzFOQWJUdXQrb3RNeEppTk9na0M2dHFi?=
 =?utf-8?B?RVdEZk02a0VjczM5ZDBiMWg5WWlJSFFJY3hXc1hDTFZVQm4rVnVoYlRJbnM1?=
 =?utf-8?B?Yzlka1dRQUp3cGd5YjZPb3NjT00wQk5wV2oyV1BSbTN4dUpQNlFSTjM4cytD?=
 =?utf-8?B?UUUzcS84QTlGbG5qaUxIZDZlTS8zV0FwK3BzV2NHeHRSZWJTdjBsVWV5MEFx?=
 =?utf-8?B?NGMrTVBUMDJITjFRVnMycXBpbzllZ3dBMjYrSXVrWkNvZUR0UjhubnpWQjRy?=
 =?utf-8?B?MmxENkRsRUVmTVF4REUzcHV5eTJURFRTbS9keE1SZmVjQktGWGRHdU5haDdN?=
 =?utf-8?B?dkVXM1RtN0xUMnFLU2hkaUFvWUVxdCs5b1F4MnNvUmV5R3BJckJQS2ozZHE2?=
 =?utf-8?B?WkdCSzQ0VDNEdnIvcndGQUVPWkVZK2pRRGxsUW9QSyt4a3FER0p0S3lmeE9Z?=
 =?utf-8?B?QTlBNnNhZ3J3OUdpMXNuSFhaZTBsWDZ1Z2QxbGwwb2hIcnI0WE9kNFh2OWda?=
 =?utf-8?B?NUkvSXowS29kWnZxenlRN2YxQzlneHgzSmZUY3o3dDU0M2pZR2pQcTRxYVA0?=
 =?utf-8?B?V0NQbjlNMy8yN2RSdWdacHpIck5hclVOVnl5V1lYUEpSNHRGQ1FScm04UHV0?=
 =?utf-8?B?K2E0UGNPUVpWcFEzUVd1OUd6UlpxTVZNQWZ0MUx1SGRlcE5xWTRjbnlLcTl5?=
 =?utf-8?B?OHZ2a2MwNGZ0WVRqNHJPQ1dsTEtnZUxqeW9CWG1mRHY3QWY4NlVPaUdWUnhn?=
 =?utf-8?B?MW1lc1RzeGMxNjFGUTl3ZS9lVHN2U0pGV3BWdnU3Q2d1NS9scWZVZTk3M1VD?=
 =?utf-8?B?UFoxMUpGT291OUJyYStCUnQyZlQzRk5GWkZsR3dBdHcxQVE5RTRUT1RPMXFR?=
 =?utf-8?B?Qmd5UXROMVJlMDRaZStjNDdIMmpiYUoyd2RqWnh3NkQyaHk1c2thR0RWRitG?=
 =?utf-8?B?NFJicFlmUXFHV1JzSk1GRG1IcW9XU1diQUxSaHJYUHoySE1PM0lPYTF6VDFQ?=
 =?utf-8?B?L09zaEVYWXBnUjZxS1Y0RCsyVFlYM2NmM1ZMelJvMXdrUlhteUJTUUI1YXYz?=
 =?utf-8?B?WTZZZVllWVMxODQ0dVlzNjI1cUdjNnFaM2xja2x5UDU5VjU0eUtYOG42OC94?=
 =?utf-8?B?WkRNMUtqMVRqbEF1TFBHMFYyd2IwZXBsNmdLaFBDY0tXN1JiSkxpb2dVek9x?=
 =?utf-8?B?cFQ0T1l0T21yeGk1VHBWbzJMZXM5VEs3THRQeDYvaUd5dGNiTW5oOGM5NEFH?=
 =?utf-8?B?QjFKUjVLV05OQ3pjVXN4TmhIUUxRc2JiRllVaTRhaFV3VDZ2dGltM0cwMUtR?=
 =?utf-8?B?OUE4YWg4TnA3VnREQklnK2MvazYyc0JVQlRycTFDcnVEanlvYXVPejB6MHd4?=
 =?utf-8?B?VGcyZG5Gdys3bzRUaEpKcENZblFjdUVzWHVlUHpEUG5McytUYWd6RDBNSEdZ?=
 =?utf-8?B?c3ptWFRSQk9wYzZQSnozYzZQdjJ1UHZwdVJQMGNqR3J6cmNrVTBUK2ZISmRz?=
 =?utf-8?B?TEwranJpUHYxMXhBejRFZ3kxdVg0Tm9yVk1WSHhhNEdjSm5rUjZqV2lsbmdw?=
 =?utf-8?B?T0t3dW5ONDVXK2thcXk1YkhBWkw2NlhzWVNTRkZZZUgxa3JrTlMrUUxGdWZw?=
 =?utf-8?B?cjV3dDJaWlQ5M3VxcWI0dlk1QWR1dEN4VW1sdUxkTndLZjR1QXlTaGFsNnYz?=
 =?utf-8?B?dFNJeXpVeWdkb29GWEx2bEYwdEtucW5LWGsrdm1Ed3k5RUlubmNkUmM5bnJU?=
 =?utf-8?B?UW9jc2xEWEY0TWRpYTQ5VHNsTnNUT1JiajhuZzQvajBsUEprTmhBUXNHYkF0?=
 =?utf-8?B?WVJDYTRod2JwSzFTWXVEQU9BSU9reW5CeEVmM1ZiL2l6a0EyWWdiY1MrWWFF?=
 =?utf-8?B?d0g2NHljbkp0VHZhWFhDSjZ5U040d1hudjBKbE43eUxWUGpmVXgrWG1FSk1Z?=
 =?utf-8?B?aVdXRjB4UlV1MWdSWU1EcDRBSjJ2dmJQdHhIWnlEZCtlYVAyY0gvVG9iRFVo?=
 =?utf-8?B?NXkvQ1l3QlVGY2VGQjh0aUVDUUpkc1orZWxoZkkzQStHSkNuZTdzTWZkd0J2?=
 =?utf-8?B?N0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <03B54753298409439F9296B95729E008@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f098dd69-7f5f-4dcc-fecf-08db0bbd9939
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2023 23:21:55.0027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: egDhkChAmmsWvKPV49YiLB+VnfYIqNQ7VufDlCf0NcxgfNdX/Poi+ZeNWUREl3LsUyhXLBRtzKi2oCmr+Fkktgg2Lcj/XAfnvhnd1KM8FO0=
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

T24gRnJpLCAyMDIzLTAyLTEwIGF0IDAxOjA2IC0wODAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6Cj4g
Sm9uYXRoYW4gcG9pbnRzIG91dCB0aGF0IHRoZSBzaGFyZWQgY29kZSBiZXR3ZWVuIHRoZSBzd2l0
Y2ggYW5kIGVuZHBvaW50Cj4gY2FzZSBpcyBzbWFsbC4gQmVmb3JlIGFkZGluZyBhbm90aGVyIGlz
X2N4bF9lbmRwb2ludCgpIGNvbmRpdGlvbmFsLAo+IGp1c3Qgc3BsaXQgdGhlIHR3byBjYXNlcy4K
PiAKPiBSYXRoZXIgdGhhbiBkdXBsaWNhdGUgdGhlICJDb3VsZG4ndCBlbnVtZXJhdGUgZGVjb2Rl
cnMiIGVycm9yIG1lc3NhZ2UKPiB0YWtlIHRoZSBvcHBvcnR1bml0eSB0byBpbXByb3ZlIHRoZSBl
cnJvciBtZXNzYWdlcyBpbgo+IGRldm1fY3hsX2VudW1lcmF0ZV9kZWNvZGVycygpLgo+IAo+IFJl
cG9ydGVkLWJ5OiBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQEh1YXdlaS5jb20+
Cj4gTGluazogaHR0cDovL2xvcmUua2VybmVsLm9yZy9yLzIwMjMwMjA4MTcwNzI0LjAwMDA2N2Vj
QEh1YXdlaS5jb20KPiBTaWduZWQtb2ZmLWJ5OiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1z
QGludGVsLmNvbT4KPiAtLS0KPiDCoGRyaXZlcnMvY3hsL2NvcmUvaGRtLmMgfMKgwqAgMTEgKysr
KysrLS0KPiDCoGRyaXZlcnMvY3hsL3BvcnQuY8KgwqDCoMKgIHzCoMKgIDY5ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+IMKgMiBmaWxlcyBjaGFuZ2Vk
LCA0NyBpbnNlcnRpb25zKCspLCAzMyBkZWxldGlvbnMoLSkKCkxvb2tzIGdvb2QsCgpSZXZpZXdl
ZC1ieTogVmlzaGFsIFZlcm1hIDx2aXNoYWwubC52ZXJtYUBpbnRlbC5jb20+Cgo+IAo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2N4bC9jb3JlL2hkbS5jIGIvZHJpdmVycy9jeGwvY29yZS9oZG0uYwo+
IGluZGV4IGRjYzE2ZDdjYjhmMy4uYTA4OTFjMzQ2NGYxIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMv
Y3hsL2NvcmUvaGRtLmMKPiArKysgYi9kcml2ZXJzL2N4bC9jb3JlL2hkbS5jCj4gQEAgLTgyNiw3
ICs4MjYsOCBAQCBpbnQgZGV2bV9jeGxfZW51bWVyYXRlX2RlY29kZXJzKHN0cnVjdCBjeGxfaGRt
ICpjeGxoZG0pCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgY3hsZWQgPSBjeGxfZW5kcG9pbnRfZGVjb2Rlcl9hbGxvYyhwb3J0KTsKPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoSVNfRVJSKGN4bGVkKSkg
ewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBkZXZfd2FybigmcG9ydC0+ZGV2LAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
IkZhaWxlZCB0byBhbGxvY2F0ZSB0aGUgZGVjb2RlclxuIik7Cj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAiRmFpbGVkIHRvIGFsbG9jYXRlIGRlY29kZXIlZC4lZFxuIiwKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHBvcnQtPmlkLCBpKTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIFBUUl9FUlIoY3hsZWQpOwo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0KPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjeGxkID0gJmN4bGVk
LT5jeGxkOwo+IEBAIC04MzYsNyArODM3LDggQEAgaW50IGRldm1fY3hsX2VudW1lcmF0ZV9kZWNv
ZGVycyhzdHJ1Y3QgY3hsX2hkbSAqY3hsaGRtKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGN4bHNkID0gY3hsX3N3aXRjaF9kZWNvZGVyX2FsbG9jKHBv
cnQsIHRhcmdldF9jb3VudCk7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgaWYgKElTX0VSUihjeGxzZCkpIHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGV2X3dhcm4oJnBvcnQt
PmRldiwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJGYWlsZWQgdG8gYWxsb2NhdGUgdGhlIGRl
Y29kZXJcbiIpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIkZhaWxlZCB0byBhbGxvY2F0ZSBk
ZWNvZGVyJWQuJWRcbiIsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwb3J0LT5pZCwgaSk7Cj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHJldHVybiBQVFJfRVJSKGN4bHNkKTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgY3hsZCA9ICZjeGxzZC0+Y3hsZDsKPiBAQCAtODQ0LDEzICs4NDYs
MTYgQEAgaW50IGRldm1fY3hsX2VudW1lcmF0ZV9kZWNvZGVycyhzdHJ1Y3QgY3hsX2hkbSAqY3hs
aGRtKQo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByYyA9IGluaXRfaGRt
X2RlY29kZXIocG9ydCwgY3hsZCwgdGFyZ2V0X21hcCwgaGRtLCBpLCAmZHBhX2Jhc2UpOwo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKHJjKSB7Cj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkZXZfd2FybigmcG9ydC0+ZGV2LAo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAiRmFpbGVkIHRvIGluaXRpYWxpemUgZGVjb2RlciVkLiVkXG4iLAo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwb3J0
LT5pZCwgaSk7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgcHV0X2RldmljZSgmY3hsZC0+ZGV2KTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gcmM7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqB9Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByYyA9IGFkZF9oZG1f
ZGVjb2Rlcihwb3J0LCBjeGxkLCB0YXJnZXRfbWFwKTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGlmIChyYykgewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGRldl93YXJuKCZwb3J0LT5kZXYsCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJGYWlsZWQgdG8gYWRk
IGRlY29kZXIgdG8gcG9ydFxuIik7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJGYWlsZWQgdG8gYWRkIGRlY29kZXIlZC4l
ZFxuIiwgcG9ydC0+aWQsIGkpOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHJldHVybiByYzsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oH0KPiDCoMKgwqDCoMKgwqDCoMKgfQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2N4bC9wb3J0LmMg
Yi9kcml2ZXJzL2N4bC9wb3J0LmMKPiBpbmRleCA1NDUzNzcxYmYzMzAuLmE4ZDQ2YTY3YjQ1ZSAx
MDA2NDQKPiAtLS0gYS9kcml2ZXJzL2N4bC9wb3J0LmMKPiArKysgYi9kcml2ZXJzL2N4bC9wb3J0
LmMKPiBAQCAtMzAsNTUgKzMwLDY0IEBAIHN0YXRpYyB2b2lkIHNjaGVkdWxlX2RldGFjaCh2b2lk
ICpjeGxtZCkKPiDCoMKgwqDCoMKgwqDCoMKgc2NoZWR1bGVfY3hsX21lbWRldl9kZXRhY2goY3hs
bWQpOwo+IMKgfQo+IMKgCj4gLXN0YXRpYyBpbnQgY3hsX3BvcnRfcHJvYmUoc3RydWN0IGRldmlj
ZSAqZGV2KQo+ICtzdGF0aWMgaW50IGN4bF9zd2l0Y2hfcG9ydF9wcm9iZShzdHJ1Y3QgY3hsX3Bv
cnQgKnBvcnQpCj4gwqB7Cj4gLcKgwqDCoMKgwqDCoMKgc3RydWN0IGN4bF9wb3J0ICpwb3J0ID0g
dG9fY3hsX3BvcnQoZGV2KTsKPiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IGN4bF9oZG0gKmN4bGhk
bTsKPiDCoMKgwqDCoMKgwqDCoMKgaW50IHJjOwo+IMKgCj4gK8KgwqDCoMKgwqDCoMKgcmMgPSBk
ZXZtX2N4bF9wb3J0X2VudW1lcmF0ZV9kcG9ydHMocG9ydCk7Cj4gK8KgwqDCoMKgwqDCoMKgaWYg
KHJjIDwgMCkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHJjOwo+IMKg
Cj4gLcKgwqDCoMKgwqDCoMKgaWYgKCFpc19jeGxfZW5kcG9pbnQocG9ydCkpIHsKPiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmMgPSBkZXZtX2N4bF9wb3J0X2VudW1lcmF0ZV9kcG9y
dHMocG9ydCk7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChyYyA8IDApCj4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gcmM7
Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChyYyA9PSAxKQo+IC3CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIGRldm1fY3hsX2Fk
ZF9wYXNzdGhyb3VnaF9kZWNvZGVyKHBvcnQpOwo+IC3CoMKgwqDCoMKgwqDCoH0KPiArwqDCoMKg
wqDCoMKgwqBpZiAocmMgPT0gMSkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0
dXJuIGRldm1fY3hsX2FkZF9wYXNzdGhyb3VnaF9kZWNvZGVyKHBvcnQpOwo+IMKgCj4gwqDCoMKg
wqDCoMKgwqDCoGN4bGhkbSA9IGRldm1fY3hsX3NldHVwX2hkbShwb3J0KTsKPiDCoMKgwqDCoMKg
wqDCoMKgaWYgKElTX0VSUihjeGxoZG0pKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgcmV0dXJuIFBUUl9FUlIoY3hsaGRtKTsKPiDCoAo+IC3CoMKgwqDCoMKgwqDCoGlmIChpc19j
eGxfZW5kcG9pbnQocG9ydCkpIHsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3Ry
dWN0IGN4bF9tZW1kZXYgKmN4bG1kID0gdG9fY3hsX21lbWRldihwb3J0LT51cG9ydCk7Cj4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBjeGxfZGV2X3N0YXRlICpjeGxkcyA9
IGN4bG1kLT5jeGxkczsKPiArwqDCoMKgwqDCoMKgwqByZXR1cm4gZGV2bV9jeGxfZW51bWVyYXRl
X2RlY29kZXJzKGN4bGhkbSk7Cj4gK30KPiDCoAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAvKiBDYWNoZSB0aGUgZGF0YSBlYXJseSB0byBlbnN1cmUgaXNfdmlzaWJsZSgpIHdvcmtz
ICovCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJlYWRfY2RhdF9kYXRhKHBvcnQp
Owo+ICtzdGF0aWMgaW50IGN4bF9lbmRwb2ludF9wb3J0X3Byb2JlKHN0cnVjdCBjeGxfcG9ydCAq
cG9ydCkKPiArewo+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBjeGxfbWVtZGV2ICpjeGxtZCA9IHRv
X2N4bF9tZW1kZXYocG9ydC0+dXBvcnQpOwo+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBjeGxfZGV2
X3N0YXRlICpjeGxkcyA9IGN4bG1kLT5jeGxkczsKPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgY3hs
X2hkbSAqY3hsaGRtOwo+ICvCoMKgwqDCoMKgwqDCoGludCByYzsKPiArCj4gK8KgwqDCoMKgwqDC
oMKgY3hsaGRtID0gZGV2bV9jeGxfc2V0dXBfaGRtKHBvcnQpOwo+ICvCoMKgwqDCoMKgwqDCoGlm
IChJU19FUlIoY3hsaGRtKSkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJu
IFBUUl9FUlIoY3hsaGRtKTsKPiDCoAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBn
ZXRfZGV2aWNlKCZjeGxtZC0+ZGV2KTsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
cmMgPSBkZXZtX2FkZF9hY3Rpb25fb3JfcmVzZXQoZGV2LCBzY2hlZHVsZV9kZXRhY2gsIGN4bG1k
KTsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKHJjKQo+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHJjOwo+ICvCoMKgwqDC
oMKgwqDCoC8qIENhY2hlIHRoZSBkYXRhIGVhcmx5IHRvIGVuc3VyZSBpc192aXNpYmxlKCkgd29y
a3MgKi8KPiArwqDCoMKgwqDCoMKgwqByZWFkX2NkYXRfZGF0YShwb3J0KTsKPiDCoAo+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByYyA9IGN4bF9oZG1fZGVjb2RlX2luaXQoY3hsZHMs
IGN4bGhkbSk7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChyYykKPiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiByYzsKPiAr
wqDCoMKgwqDCoMKgwqBnZXRfZGV2aWNlKCZjeGxtZC0+ZGV2KTsKPiArwqDCoMKgwqDCoMKgwqBy
YyA9IGRldm1fYWRkX2FjdGlvbl9vcl9yZXNldCgmcG9ydC0+ZGV2LCBzY2hlZHVsZV9kZXRhY2gs
IGN4bG1kKTsKPiArwqDCoMKgwqDCoMKgwqBpZiAocmMpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHJldHVybiByYzsKPiDCoAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqByYyA9IGN4bF9hd2FpdF9tZWRpYV9yZWFkeShjeGxkcyk7Cj4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGlmIChyYykgewo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgZGV2X2VycihkZXYsICJNZWRpYSBub3QgYWN0aXZlICglZClcbiIsIHJj
KTsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVy
biByYzsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQo+IC3CoMKgwqDCoMKgwqDC
oH0KPiArwqDCoMKgwqDCoMKgwqByYyA9IGN4bF9oZG1fZGVjb2RlX2luaXQoY3hsZHMsIGN4bGhk
bSk7Cj4gK8KgwqDCoMKgwqDCoMKgaWYgKHJjKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqByZXR1cm4gcmM7Cj4gwqAKPiAtwqDCoMKgwqDCoMKgwqByYyA9IGRldm1fY3hsX2VudW1l
cmF0ZV9kZWNvZGVycyhjeGxoZG0pOwo+ICvCoMKgwqDCoMKgwqDCoHJjID0gY3hsX2F3YWl0X21l
ZGlhX3JlYWR5KGN4bGRzKTsKPiDCoMKgwqDCoMKgwqDCoMKgaWYgKHJjKSB7Cj4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRldl9lcnIoZGV2LCAiQ291bGRuJ3QgZW51bWVyYXRlIGRl
Y29kZXJzICglZClcbiIsIHJjKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGV2
X2VycigmcG9ydC0+ZGV2LCAiTWVkaWEgbm90IGFjdGl2ZSAoJWQpXG4iLCByYyk7Cj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gcmM7Cj4gwqDCoMKgwqDCoMKgwqDCoH0K
PiDCoAo+IC3CoMKgwqDCoMKgwqDCoHJldHVybiAwOwo+ICvCoMKgwqDCoMKgwqDCoHJldHVybiBk
ZXZtX2N4bF9lbnVtZXJhdGVfZGVjb2RlcnMoY3hsaGRtKTsKPiArfQo+ICsKPiArc3RhdGljIGlu
dCBjeGxfcG9ydF9wcm9iZShzdHJ1Y3QgZGV2aWNlICpkZXYpCj4gK3sKPiArwqDCoMKgwqDCoMKg
wqBzdHJ1Y3QgY3hsX3BvcnQgKnBvcnQgPSB0b19jeGxfcG9ydChkZXYpOwo+ICsKPiArwqDCoMKg
wqDCoMKgwqBpZiAoaXNfY3hsX2VuZHBvaW50KHBvcnQpKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqByZXR1cm4gY3hsX2VuZHBvaW50X3BvcnRfcHJvYmUocG9ydCk7Cj4gK8KgwqDC
oMKgwqDCoMKgcmV0dXJuIGN4bF9zd2l0Y2hfcG9ydF9wcm9iZShwb3J0KTsKPiDCoH0KPiDCoAo+
IMKgc3RhdGljIHNzaXplX3QgQ0RBVF9yZWFkKHN0cnVjdCBmaWxlICpmaWxwLCBzdHJ1Y3Qga29i
amVjdCAqa29iaiwKPiAKCg==
