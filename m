Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D296068244F
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Jan 2023 07:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjAaGJl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 31 Jan 2023 01:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjAaGJk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 31 Jan 2023 01:09:40 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8415A3B3E5;
        Mon, 30 Jan 2023 22:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675145377; x=1706681377;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=wD6in6KKEW7eAAJ2hZ9mNADClN5TYGfK4QgyWjdvpkk=;
  b=f0bWQOtkue68qAVexSnX7eGWsHi+F6b4YpNTe35tGDyKn0UUNIquP+WZ
   S6WHJ7juKYlwcdZCfhkj4cvq1zHbgDt+1Vca4BNiwQ4Ua0cXr0tdv6wc0
   A2jaCJgF9otG6paDLa3R6T4stYhgNMT2ePUsqxwtlnqGU8I+kVXVJ4JDQ
   dsClEa1laqBVABP7K58RFoXttka0EH2DVE0N6uwFXr1JYW7YfnNl8/NAP
   ygid1UkqLGX20OgGHHCV8Gcoj8VUPHWIA+rUugD/jV74dbKuXzsLuvQoY
   DEImbto0kH3j+9PXwwwhMscfl8JWwG8EtILxzzQXdPlT9fhCtffQFmxjP
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="315722327"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="315722327"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 22:09:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="772827170"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="772827170"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 30 Jan 2023 22:09:20 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 30 Jan 2023 22:09:20 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 30 Jan 2023 22:09:19 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 30 Jan 2023 22:09:19 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 30 Jan 2023 22:09:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cfs/gAMP05uMU03i0vyk9gIJz/NkC3bYInxME0aq9MSzliU2WYZzzVUs+HQY9TBwA+96r6cq17fYXIQ3jOrWxHPn827Sc3zFQRrKDxyibx725uz4p4pw/djyqV+DL1RP5wvw9IR+C6fGxMPreF/aNwW4lYsX2mCa/BFG5dLjP803XQSZbdhJwfItX8eHDOCgrG2GdA3q4BpbOH7wA0OgLfhz39cRyqASCs8vh50koc635KmBQL1rHWTH/Uzev2e8VvGIsoLcEUtavn92+ozYpFWZHevaA7kkW2A5d5rXjqslMjW9lC/24PLO04ODivbDvXkewe7DeoQQy8oto5eCNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wD6in6KKEW7eAAJ2hZ9mNADClN5TYGfK4QgyWjdvpkk=;
 b=Hz18L9NSlvpzZpPp1yow3byaxA0d2azNUhCpOi+xECejMuvUVnD/LCXFdshPL263ySWm+5pYSd6xsZFV3tf5/Jz4DsyeRrB0IPg71biwq+ldRG/TdDWU4AGdMbN1Ee6eUzuA4MjsRb04Wz7x+cr5POvO3b669OcsYFZky4iXTQNdrrn4n7gVSOu9xpYjcwoyDn2GdSJLNWbYMkja1JjvLLM2hoho68zuu46fHEARwENpwiCm/GE5TZgKSEePFSM1Tmg25N4TuVCwE6MOJUpITYFjclo5TPMmo9Uw6eLs42NCSFuvNWc/T+kxIshJQ7p9BbLAHIsWiWlN46YVpyo2BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by SA2PR11MB4923.namprd11.prod.outlook.com (2603:10b6:806:fa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 06:09:17 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2%5]) with mapi id 15.20.6043.036; Tue, 31 Jan 2023
 06:09:17 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "topi.maenpaa@visionappster.com" <topi.maenpaa@visionappster.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: ACPI BIOS bug breaks wake from sleep
Thread-Topic: ACPI BIOS bug breaks wake from sleep
Thread-Index: AQHZNHdbtzsqjn0OVEKjPU+oPYN5I664DCiA
Date:   Tue, 31 Jan 2023 06:09:17 +0000
Message-ID: <8d9af4cf1adf0700c4c2092e66eb9af4eb934d4c.camel@intel.com>
References: <465f350f019667aa353bad8d1939a683fd400fc3.camel@visionappster.com>
In-Reply-To: <465f350f019667aa353bad8d1939a683fd400fc3.camel@visionappster.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|SA2PR11MB4923:EE_
x-ms-office365-filtering-correlation-id: 56b34a41-8fed-425b-ee56-08db0351af76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UkH0SgeNTyukdFoc/YBETLOc0DhuYIyup2852fwMgp17yqgx5kY1Oze56NQ4bk3elSh4BK0dMeHVMr0I/H0LGO45UpJbNdK6eT2T9WrmySQx2TtOxiDTaLqFKeV1UOl69Ms47FVVHfrmOT4nJorYDMX+6FNdMwe7lbuN6bGsT1rVsh6UcyrqYcKptYl4tXKUvOmL7A/ZpHYN1bmQ8scrmQdcy3LEZ6gZbFrH4b2NSg+RWgMsltoFsavCB2Byu0BhhqXqAwxBe50Q74a1maw0/ovqX0oZywamOVZluUSz/Ljtp53LV8mjRE0L13TvM253Ot+N0ZS9CbOIAE/EKG9wFwFSIS0vrgXFDQlMqMjVHwRvdoFOCh+m8Ig1dtImOe2YKf39ductw7cAAvkilwgThvYTVH7t1+9LELay2eNczUWkJ9hwFdxVTBoRsS4kl6cu9k0PthjV2GgDH91Tu8XBGk50cDUkKnDaCJLoDl20vyfTJEMfpz9p45KCNvYMWyWJw5QitrnZjAaUNfMfXSV2foRnfUCgFtRyfa4pBP4Iivg8qQp6Z4zlPtoMIZYiGHkAWSlr0opDCTZ77u7+4/PQlEIIggvP+uOFYeVJXdkHM1a9dM3qVv0yZcKFlMSubmPBOqxqT9+cJBT/bbhbL+gRKc+ACsFseFEWQ6a8ZgFd7QHJJ3TPLOtiEcgI1f777mMt9gaL++UWhSgFh29QPmWksCVnxfWYNljOwE3fzIyVnp4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(346002)(376002)(39860400002)(136003)(451199018)(38100700002)(38070700005)(122000001)(86362001)(82960400001)(36756003)(110136005)(66946007)(41300700001)(5660300002)(8936002)(76116006)(66556008)(316002)(66476007)(64756008)(66446008)(8676002)(91956017)(2906002)(66574015)(2616005)(83380400001)(6486002)(478600001)(6512007)(71200400001)(6506007)(26005)(186003)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RXNUdHVVQjRCZk1mN0w1YU9JWUErYWNSUzBlam5jMHF3cVM0OERXbEVFNS9X?=
 =?utf-8?B?ekNCd1NaVmJZRmg5UTVEaGdmMTJLWkhsSnUxcnFrMGtBZXF5UXFWUXpISTFW?=
 =?utf-8?B?NklISWx2S2ZVaW9OWlh2bzdpSDVSNTdEeHJWL2c5YStTdXhoRjBVazdKZmc4?=
 =?utf-8?B?MERmOS9WLzdha0d5K1FYZ2g2NzlpN0xBbTRBYUMwRmZIUkNGejlKcGRoSllT?=
 =?utf-8?B?VEZTdHBzVHVqN1A4Z2ZmK0NnejdGbWJaMkNWYklrUFdIYkx4M2hqcmdURHp3?=
 =?utf-8?B?WlFsZEliNFBSVmNGL1hqcXpXbXdXbTBiaTZpNmpxVFpqbFF2ekY2Y3p5NUxw?=
 =?utf-8?B?MkRjcTdDM0hPeXM2WEo5TGtmSGV0ekxqSStQVGlzMlVwVTlKY3g5RmlwQUxL?=
 =?utf-8?B?N1dpQ1h4dmJxVm00VUpkSzE4Tm5GVzNPV2J0NE1EcUhJN1ljT0dnQ0VTZlpy?=
 =?utf-8?B?dnN2UDYyUFF1TWVsWVcrN3hSS0p1QWVzOHZhVkVTSTI1NzRFc3BaRitMdENX?=
 =?utf-8?B?OG5hMVdwZGJza2gySlJocVZrc2JSMmtQak8rdCtWVCtDVllVMVY4b0h0NUYy?=
 =?utf-8?B?S1BGOUJodXZEajYvTWRZeHdIUEhLMXdSeDFaL1ZaQkdEU3BLZ2E3ZW5YQ2Zo?=
 =?utf-8?B?clpDRWNIaWNleVBFZUtwVlRhOUs2TkFlVzFadEprK0orS0VTUW9wNzh3TjIw?=
 =?utf-8?B?SStYSjRjenZockRXWXpwVTg4QWVibFNpQnZtOHRZVjBhQjd4dnIzNkoyZ283?=
 =?utf-8?B?M25nN0lMd0g4YnZLaHdpSmYrWnptZjdpRnB4TlFpb1E2OWRpVlgyZGR1VDNM?=
 =?utf-8?B?MDVTOG5Hbm1QRlg1Qk5jb1kxNG9wK0FPOWU0bDNjN3hFbEtLZVZiVTNDY0ha?=
 =?utf-8?B?YldiNmQ5SXQ3UUxPK1NhNTdDNVdKcndKeUFROElFbnZiNmZxeEUyL0UyOVd4?=
 =?utf-8?B?NUF0bjRheWFmY3dwdThyTG00R1JOQmNuNGhQUmdmdXFpd1pXN09la3R6SHMz?=
 =?utf-8?B?bDJrUDh5WitsM2ExYlZDRFp3eVRzaThJcW8yeXVEcTJRMENlQTVib3luclEw?=
 =?utf-8?B?cUY5QjhWbFJsTDFjSm5IRkVmQXordW1oQ1Iydm1DUjNOckNZeXhRRk9ac2x1?=
 =?utf-8?B?SmtEYkNRTjA5T1ZxWTJjTVRVb2pZZVBxUU5sUFd1emFKM3NiVVhnSFNOcVcz?=
 =?utf-8?B?TGdSS3lkS0ZCeFE5cE92L0xuQXMyNzB6eWkralNjdzAxb25UUitXbEdtRmJX?=
 =?utf-8?B?WmIwUGxoQms3K1djN3FrRzEvS1hCdThQcVRkQTJKL2pGb1lIazVKcWw2NU1B?=
 =?utf-8?B?ZHlEdSt6eHhwWndYUG1SNlYvb2dZZTNxU01BNEVoWjZqcXRXZ2ZmMWdDVEFh?=
 =?utf-8?B?TXBNdmh0UllwYm9iaGJ3TFc2QTU1Q3dyNWFyL3RYRFRlMWY4U3E3ZDRTZW5Y?=
 =?utf-8?B?dnZrd3BtTDBKVVpDRHNQNFZuMGtlL1hqUTVtOFNNUElNZ2I4bnFRelNQRHcv?=
 =?utf-8?B?aTBSQWNqUjVPeXlYWGlKMW54MFJMUzhzdzRmZEl3RmI4NnV3TFJheTdXTkNv?=
 =?utf-8?B?VDIvMFZpV0F3dFhlL3VSd1RKSzJEYUNvOEwrazlSMUxrcjlIbll2cWtPZ3Yy?=
 =?utf-8?B?bEF1MWs2U3BKMHYvZ3JRRHJqbUgwcDhoVXg2UlArdnRvWHdaYnRhWlNiaCtJ?=
 =?utf-8?B?cWU0QW1lanRRZzQrMXFYUkh3aXhsTk5kZjJ5bXZHTGxPL3p1WmdweDBGN1Nl?=
 =?utf-8?B?a2hqekhBekxQL3g4ejNqVEtiVmh6WjRob056RC81aWNvSDVXcWdxV1ZJYXhI?=
 =?utf-8?B?bVVZRlpzUkhtWVZBT1R4NlVvRGRjbjVzQldaV1hSRVZDVmc4bEJ1R3BrdG9S?=
 =?utf-8?B?OXpTNFFPa3QyVm44Sm9nMWdkakFvM2NqN3oyU2ExMDdMNXZGOWpHRVRqc245?=
 =?utf-8?B?aFF3cEVuMlRRTDVTZUVGWU14VDlEUGVQUGxsRUpTWVAxZjVQaCtyY2l5MFNS?=
 =?utf-8?B?ZzhRTklMSlNpUkp0b1VOamdhZVJ2dE1BTE5ydjdLc2VzQklmekNwVEt2TGhw?=
 =?utf-8?B?TFlsRklYSG9UeDgwVkx1MWJtSlV2NzJ5OU1IbW9EclZPREZSNWtuNFgyOS9Z?=
 =?utf-8?B?eXkrZDlIa0RISTJ4Nmx0N29pejBrZ3N6bDNUSUhzbXJLRjJJVDQxS09IZkFT?=
 =?utf-8?B?RWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A38C11D16A24D448BDDE10B588A03523@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b34a41-8fed-425b-ee56-08db0351af76
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 06:09:17.3474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SPEILQ/tI++MeAssUYgF5+JeX4i74xVpKAuXUkGIo6sTwRSqxIdhOqy0ibUwDg517fItcFg2U+XCbkpFf/RI/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4923
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

VGhpcyBzZWVtcyBsaWtlIGEgZ3JhcGhpY3MgaXNzdWUuDQpQbGVhc2UgY29uZmlybSBpZiB0aGUg
cHJvYmxlbSBzdGlsbCBleGlzdHMgd2l0aCBMQVRFU1QgdmFuaWxsYSBrZXJuZWwuDQpJZiB5ZXMs
IHBsZWFzZSBib290IHdpdGgga2VybmVsIHBhcmFtZXRlciAibm9tb2Rlc2V0IiBhbmQgc2VlIGlm
IHRoZQ0KcHJvYmxlbSBpcyBzdGlsbCB0aGVyZS4NCg0KdGhhbmtzLA0KcnVpDQoNCk9uIE1vbiwg
MjAyMy0wMS0zMCBhdCAwNjo1MiArMDAwMCwgVG9waSBNw6RlbnDDpMOkIHdyb3RlOg0KPiBIaSwN
Cj4gDQo+IEkgaG9wZSBJJ20gbm90IGJyZWFraW5nIHJ1bGVzIGJ5IHBvc3RpbmcgdGhpcyBxdWVz
dGlvbiBoZXJlLiBJZiBJIGFtLA0KPiBjb3VsZCB5b3UgcGxlYXNlIHBvaW50IG1lIHRvIHRoZSBy
aWdodCBmb3J1bT8NCj4gDQo+IEkgcmVjZW50bHkgYm91Z2h0IGEgbmV3IGxhcHRvcCBJIGFzc3Vt
ZWQgd2FzIGNsb3NlIGVub3VnaCB0byBvdGhlciBIUA0KPiBsYXB0b3AgbW9kZWxzIHRoYXQgd29y
a2VkIGZpbmUgd2l0aCBMaW51eC4gSXQgYXBwYXJlbnRseSB3YXNuJ3QuDQo+IEhhcmR3YXJlIHNw
ZWNzOg0KPiBodHRwczovL3N1cHBvcnQuaHAuY29tL3VzLWVuL2RvY3VtZW50L2lzaF81OTk0NjQx
LTU5OTQ3MDUtMTYuIEkgaGF2ZQ0KPiB0aGUgbW9kZWwgd2l0aCBhbiBJbnRlbCBDb3JlIGk3IDEy
NzAwSCBhbmQgTlZJRElBIFJUWCBBMjAwMC4NCj4gDQo+IEknbSBydW5uaW5nIEt1YnVudHUgMjIu
MTAgKHRyaWVkIDIyLjA0IGZpcnN0KSB3aXRoIGtlcm5lbCB2ZXJzaW9uDQo+IDUuMTkuMC0yOS4g
SSB1cGdyYWRlZCB0aGUgZmlybXdhcmUgdG8gdGhlIGxhdGVzdCB2ZXJzaW9uIGZvdW5kIG9uDQo+
IEhQJ3MNCj4gc2l0ZS4gVGhlIHZlcnNpb24gaXMgbm93IEJJT1MgVTk3IFZlci4gMDEuMDQuMDEg
MTAvMjUvMjAyMi4gVGhpcyBoYWQNCj4gbm8NCj4gZWZmZWN0Lg0KPiANCj4gVGhlIHByb2JsZW0g
aXMgdGhlIGxhcHRvcCB3b24ndCB3YWtlIHVwIGFmdGVyIGJlaW5nIHN1c3BlbmRlZC4gVGhpcw0K
PiBoYXBwZW5zIGlycmVzcGVjdGl2ZSBvZiB0aGUgd2F5IHRoZSBzdXNwZW5kIGhhcHBlbmVkOyBj
bG9zaW5nIHRoZSBsaWQNCj4gYW5kIGV4cGxpY2l0bHkgaW52b2tpbmcgInN5c3RlbWN0bCBzdXNw
ZW5kIiBoYXZlIHRoZSBzYW1lIGVmZmVjdC4NCj4gT25jZQ0KPiBzdXNwZW5kZWQsIG9wZW5pbmcg
dGhlIGxpZCBvciBwcmVzc2luZyB0aGUgcG93ZXIgYnV0dG9uIHdpbGwgY2F1c2UNCj4gdGhlDQo+
IGtleWJvYXJkIGJhY2tsaWdodCB0byB0dXJuIG9uIGZvciBhIHdoaWxlIGFuZCB0aGUgc2NyZWVu
IHRvIGZsYXNoIGENCj4gZmV3DQo+IHRpbWVzLiBJIGFsc28gc2VlIEFDUEkgcmVsYXRlZCBlcnJv
ciBtZXNzYWdlcyBxdWlja2x5IGZsYXNoaW5nIG9uIHRoZQ0KPiBzY3JlZW4uIEkgdG9vayBhIHZp
ZGVvIHRvIGNvbmZpcm0gdGhleSB3ZXJlIHRoZSBzYW1lIEkgc2VlIGluIHRoZQ0KPiBzeXN0ZW0g
am91cm5hbC4NCj4gDQo+IEkgYXR0YWNoZWQgdGhlIChob3BlZnVsbHkpIHJlbGV2YW50IHBhcnRz
IG9mIG15IHN5c3RlbSBqb3VybmFsLiBUaGUNCj4gZmlyc3QgZXJyb3IgYXBwZWFyZWQgZHVyaW5n
ICJub3JtYWwiIG9wZXJhdGlvbiBiZWZvcmUgSSBjbG9zZWQgdGhlDQo+IGxpZC4NCj4gVGhlIG5l
eHQgY2h1bmsgb2YgdGhlIGxvZyBpcyB3aGVuIEkgY2xvc2VkIHRoZSBsaWQsIGFuZCB0aGUgdGhp
cmQgb25lDQo+IHdoZW4gSSByZW9wZW5lZCBpdC4gDQo+IA0KPiBJIGRvbid0IGFsd2F5cyBzZWUg
dGhlICJMaWQgY2xvc2VkIiBtZXNzYWdlIGluIHRoZSBsb2csIGJ1dCAiQUNQSQ0KPiBCSU9TDQo+
IEVycm9yIChidWcpOiBBRV9BTUxfUEFDS0FHRV9MSU1JVCwgSW5kZXggKDB4MDAwMDAwMEZGKSBp
cyBiZXlvbmQgZW5kDQo+IG9mDQo+IG9iamVjdCAobGVuZ3RoIDB4MTIpICgyMDIyMDMzMS9leG9w
YXJnMi0zOTMpIiBpcyBhbHdheXMgdGhlcmUuIFNhbWUNCj4gZ29lcyB0byB0aGUgcGFydCB0aGF0
IHN0YXJ0cyB3aXRoICJbIGN1dCBoZXJlIF0iLiBJdCBpcyBhIGJpdCBoYXJkIHRvDQo+IHN5bmNo
cm9uaXplIHRoZSBsb2cgYW5kIHRoZSBwaHlzaWNhbCBldmVudHMsIGJ1dCBpdCBzZWVtcyB0byBt
ZSB0aGF0DQo+IHRoZSBlcnJvciBtZXNzYWdlcyBjYW4gYXBwZWFyIGVpdGhlciB3aGVuIEkgY2xv
c2UgdGhlIGxpZCBvciB3aGVuIEkNCj4gb3BlbiBpdC4NCj4gDQo+IA0KPiBNeSBxdWVzdGlvbnM6
DQo+IA0KPiAxLiBJcyB0aGVyZSBhIHdheSBJIGNhbiB3b3JrIGFyb3VuZCB0aGlzIHVzaW5nIGtl
cm5lbCBib290IHBhcmFtZXRlcnMNCj4gb3IgdGhlIGxpa2U/IEknbSBhc3N1bWluZyBkaXNhYmxp
bmcgQUNQSSB3b3VsZCBtYWtlIGl0IGRpc2FwcGVhciwgYnV0DQo+IHRoYXQgaXNuJ3QgYW4gb3B0
aW9uIGZvciBhIGEgbGFwdG9wLg0KPiANCj4gMi4gV2hhdCB3b3VsZCBpdCB0YWtlIHRvIHdvcmsg
YXJvdW5kIHRoaXMgaW4gdGhlIEFDUEktcmVsYXRlZCBrZXJuZWwNCj4gc291cmNlIGNvZGU/DQo+
IA0KPiANCj4gLSBUb3BpDQo=
