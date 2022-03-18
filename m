Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2544DE395
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Mar 2022 22:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237576AbiCRVfe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Mar 2022 17:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbiCRVfe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Mar 2022 17:35:34 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68F31D9170;
        Fri, 18 Mar 2022 14:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647639254; x=1679175254;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5QtKRMcT3LWr2JTAgPsXOCHSKb/V6i3YHU+5rcpyaDw=;
  b=PitZrmg/TRZzN4zqvAx7Kej3q5YRnUp7kJovdIB7/OL30ztawINshYjI
   eKrnvGZ7RHsxtbz3AWUjE9JcCEFrp3CYF47oq2jGQDQyBP3GNJc86eJfi
   gP87vJd98kMXESojXLrojx4f8Jg9qV7LlWtz+pQaweRbeCl28YXD60odU
   Whx/YaIAhA1XzxNTXcHjpnQ/NgWvY+B24zuqIZt7spSgxVTcpflj10/BH
   Q7izHUnTHnGqcT4+3bm8R3cH9wBti+i5nhmCv+DteVBCjw8LCCM+C3ovF
   iIKwuLDynPNKN4paBOiGyC0hUz6fIRgiFYEscw+4LQz+gf5e4RnIQ2onJ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="237841378"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="237841378"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 14:34:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="499397857"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga003.jf.intel.com with ESMTP; 18 Mar 2022 14:34:14 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 14:34:13 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Fri, 18 Mar 2022 14:34:13 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Fri, 18 Mar 2022 14:34:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YqaqXVCgfPs5okIcWAORqxWCxlnjx6AAMe7Xo5rK22bS86VkZvZkzH9+YthoxEpOdD2+rtJnd7x23i57PcVZR5lP68+PPgvlj/V/9LjvSn5i03bxi/o1lb2JzxlnhkScm23hOeADRsB2ZJWMI2rCtumTpx4nPLy/QSquGmB/yWLR4ZNcIXI0DTmlZivLyC+vy51AgIBejTBfoxo9wntxDonfjHiiznoMmiP5L0cSRfM9MLic9tdNgl5ugVy7pyUVhGJ1MAQy70jZpP/aBp5qrcknPul1iuzq6Qemq5TAi3fPHLQQKlbQLgKxFd1RwbH2jOP5HHm8r+Ii8fx51cnZSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5QtKRMcT3LWr2JTAgPsXOCHSKb/V6i3YHU+5rcpyaDw=;
 b=cGe/jobCU4LeFfd1CcuMEwff6kLpKXVGxQGqhEfPLPk/BfUsZ0+Bcv3f3wCmkXoy9HeYq5MjIq7tX0XO4QF1HFC5aGXt9FszdpQPYbeokX/Gv+0WX3OqL91cxMztqJj58GHK7KpOQDmDSXtiz3QEcUZchWQY+08x2dXj1VBXuL6GqqyKAa8//B99N3JV6U/tQyHyJuZAwd371d54V8MbdptxLH6Z3A9hfHK3EJu1smMrlZFgONV07UomljbtjJMeU2eJ1LNgG/fhiQ0409kE2m5X/ZTUn6MtKzlBBsj8rA1r4v4OXb2ugo3ogUGkvtN78SjhNZoZoHlUWVwKNEE4PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by MWHPR11MB0062.namprd11.prod.outlook.com (2603:10b6:301:67::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Fri, 18 Mar
 2022 21:34:12 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::d898:84ee:d6a:4eb1]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::d898:84ee:d6a:4eb1%6]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 21:34:11 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Moore, Robert" <robert.moore@intel.com>,
        "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 0/2] acpi: add support for CXL _OSC
Thread-Topic: [PATCH 0/2] acpi: add support for CXL _OSC
Thread-Index: AQHYOw9lRF/soW7qY02/37fs6UzftazFqa8A
Date:   Fri, 18 Mar 2022 21:34:11 +0000
Message-ID: <ca52884c6d627e9a6efdbda133fc88d03672b71c.camel@intel.com>
References: <20220318213004.2287428-1-vishal.l.verma@intel.com>
In-Reply-To: <20220318213004.2287428-1-vishal.l.verma@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-1.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f4ce74a-601b-41b7-1408-08da09270b03
x-ms-traffictypediagnostic: MWHPR11MB0062:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <MWHPR11MB006280A572B03B804652C589C7139@MWHPR11MB0062.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fxy5VjXQXTjGShGch8XdetSiansvNSAcialcLAJ4c53lfXPqBjFnNOjPg4c/XmNYFdsK4FovfBzoqnekpOfh4fgZADR2YdRNPrtwfGImUkq2mH4WSei8b/mf7iUiNVNv2A4dZnY5b0+YFzICvvOdKVtH2Y97Apqwb2A538uZ8m6BhUs2jm5gv6TSaXjfm0g3oo/oP+pMrw+AqJQv0GUFf+3SXwN26i2bXRsRiTGLG0buGUUn16zPapJPLcIk63+l3Hmgq01zR4O3Idfvlx+G+ZgP78ghhLi2Rf3gPzegHpWbwuTFlnvaCwXLaakxx0iDIol2I3/SKjbcb8XCzyj/e6XuI4fQEAQRzSn9wrAZml2EqzD1HMemFJ/bt4ZjABKCg8xuZXb1Uk5haUYXCtmSnEAte8RNzA0xFYE1bmF0IP7lVBjkfO65/POXVADg/d07RoAya9OAd7MO9ft/SJTYVjq+PJY6uVhmFsahWRvm1OTlxG69CvhD5wTRu0iWf4lKxXAaF2FO3gz/k2fpnLyS+Y204H+Q+YcSQJW67SWzQLkEOaajB9s8UPTFg65OXGfhAaRksFY2+/gp7shrAdum8g1QgW6cuUNgzq7oLnRbaNcpTvcKsWo7R/7X4Q8Ie/LXk3kweQ17glGXILTwM8F47L+HgsCnyQ1PzC9TUR/7l/6Tll/Vw3OrAcxMoWUHB0RmS7MI+41dXiJD4YcxPHFPzfsafUWY7DGQaRzUeYUu1071hUzOW68G1porLNyaRDVMLTOH2XYCq2OPHfkxSM9NVnFGNxp3Z/Eti2KGBTbl7Rz5pR+Ww8nMiumovDU9lw+fustGGAMFS6I5k9Y3OdF24w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(83380400001)(86362001)(6506007)(6636002)(6486002)(966005)(6512007)(5660300002)(2906002)(8936002)(8676002)(36756003)(37006003)(38100700002)(316002)(82960400001)(71200400001)(2616005)(122000001)(38070700005)(6862004)(4326008)(26005)(186003)(91956017)(66446008)(64756008)(66556008)(66476007)(66946007)(76116006)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3hxMzRWV3I1VExwVzM5WWl5UUN2c2REdEhDTW5aYWs3NkVRbG1LbkhmMDdT?=
 =?utf-8?B?dElUa01FTEtPR0FhVnJYQm4rQzlMdG5zeEZoT3d2bkorNGx0OTNyOXZvRXc4?=
 =?utf-8?B?d3Rjb29hZzkyMGRiNExwNTZJd2JsbWRNUlRKMGtEaFFDYWZVRDRnUmVJMGc2?=
 =?utf-8?B?ZkVKcXU1d0pESFRkTk5VRjI3eXJwZkQvd2ZzYlVMR0E4Rk54TFIzNEtCdXhr?=
 =?utf-8?B?SEROSWVoYjhVZTVoMGNNM3JVSGRIUU1PZTZTVENVMXdNbmh1VmtkUXhGaXFJ?=
 =?utf-8?B?YkpJV1pJVHJTcXFOWldMaDR6alNjU3Mwd29UYWZMczhWSkFUNEcxTHpnc0Jt?=
 =?utf-8?B?aEp1OFlXekxBdVRzK1BhRUdmWGowRlpabklFSHRWV2o5Z1BIYlF3ZWdYcTVw?=
 =?utf-8?B?SElXUGJIT2ZPMXhrV0FjRXpOdGdwWndXUDFXUFlnSjlyYXVWTjdIVGYwNEs5?=
 =?utf-8?B?eWptTkp1TXZlM1hFOXI0dmxuelU1NXZkaXB4d1d6UzZuV2JJS3E5MHpOVk1t?=
 =?utf-8?B?TXI3dHc1S1ZwOXArREFuUnY1TFlXWDNSS1pqendwNThwOG5iQ2hMVkNNVEVl?=
 =?utf-8?B?VjMyaEtaZitJYndKbHZ6elZGMUhpUERxeHBsb3ZDOTVhaytVeUtCekE3WGpV?=
 =?utf-8?B?RVhaejVsbnphbUNwZ1ZFZlMraFk2MTJUY1huMTRkcHFPc1pzcndabnJiT0pm?=
 =?utf-8?B?TERpZmhvKytSdTloTTNWRW1YNndpZFpFcWZPN250eHNSTzhzZTNQL0FMOW5r?=
 =?utf-8?B?eHJzRHpBMUlsaVdyZlBuM2NTSHYyS1V5TXB3NTB6RUR0WmZLL0cwbmZaRjJZ?=
 =?utf-8?B?ZzRVNUNQcHJlSGdhdENOckRFUzlLTlBqSEhuUjNmUjhaaVkyTVA3NDRmWlRp?=
 =?utf-8?B?SlJwZjN4ZWRIVDhhUDhQRE9TUFdBL3BpYjdRV3oyRHZFbDJPS2ZwWUlWaTUz?=
 =?utf-8?B?SjhaMlZRWVp3cklHdldGYW5uZkdlOVA4RjBVWmMrVGoyeDNYUjBKT05wd1NC?=
 =?utf-8?B?SzdBK2xicFJhTDFGRElXSHU2NGMzcHBTVXhnY29CYWZKVGp1eU9YNTgxaStG?=
 =?utf-8?B?MDRwM1BwL1dvb0dBbTlqVzU2MjNaanYyUWtjR2pvMFNTU0o2K2grd2REYWdN?=
 =?utf-8?B?MjVKYzRMOC9KQStJbzI5OUZZOFVzcEIvbWpMblo3dWt5M0Z2Y3p0RUpWRHpz?=
 =?utf-8?B?WWpMNW9jTmtqcXRRSlNBZTlPZitTYjFQenRGK3I1NGhQZEI0d05KbWE1NXpZ?=
 =?utf-8?B?VWQxSzBBMmNPb0hrTzlkSy9Db3FyL1VPR1laRGFHdjI5SENsV1FNVGJmdDFL?=
 =?utf-8?B?SUp5WjhMREVDV01sOGNLOFRiUXF2RU1udjlpTkJ2bHBObnR2QnpEa2NTT3Za?=
 =?utf-8?B?OEVuSHdvN2FuQzdWVytUQ3NXZE9rOXAxaUFqOGQvTFZQS0dOOG55T2swOUFT?=
 =?utf-8?B?UnZLejNEUDZkcm1Ed0QvU0dwdm1zNUtZS0RrQmxHQmd2azdLWXdRN1BpRkxY?=
 =?utf-8?B?bURRN2htMGRFZG1KY20rYW0xdDY5aUZaRHYvQ0hRMUc1WFNQVVpmN3lZTW1C?=
 =?utf-8?B?a0o2ODlsWERZaXlaODhrYjBSNjR1aEJuNmtDRlNubUx0TEhzeStZd2FacTNa?=
 =?utf-8?B?RDh6c3B1Qzg3NTlXQUdXL0N2dzkrM2FITmJHTE5RTmxsL0t1R0xDZDkrc2NU?=
 =?utf-8?B?VU9ud1p0RlVYSkhDY2poc0d1cWtCeEZOQWoxQmNsWnIxMExFRnV2M1VFK01W?=
 =?utf-8?B?ZDhuVk1QdzlyMEZ1WW8zamhBTi9vSjBYMGNUYXlSdjIzS2prdWhKcUo0Qm9t?=
 =?utf-8?B?N2dyY0oxSDd5WjdxdHExQVd1VDJESGNXWU9CenUrUUpmWjcxZUFZaVNJd1Ez?=
 =?utf-8?B?L0RwcFdBUldPb24wcXpNanhUTFlYaG9acCswZWovcDFiaklzMkhzbkU1a2No?=
 =?utf-8?B?OHdpMk9qcStEUFNjb09WVXo4cWlVNU1ML0dDdW9WK0tlNGVhNVUyY25NWndU?=
 =?utf-8?B?S0RCY3V6NDF3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F716CA31B2815349A1CEFEFBC148C0FE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f4ce74a-601b-41b7-1408-08da09270b03
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 21:34:11.8690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9DC8kcHxN5ILivOWchDvVDeKPaPB487QcOvry6eurfoDBhXlPGJnjP56XezrUZQQSSUv/7wWoC+ro0ImiaCn1GTU6zRqPxKhCKwy0ND/cWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB0062
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

T24gRnJpLCAyMDIyLTAzLTE4IGF0IDE1OjMwIC0wNjAwLCBWaXNoYWwgVmVybWEgd3JvdGU6DQo+
IENoYW5nZXMgc2luY2UgdjFbMV06DQo+IC0gVXBkYXRlIGNoYW5nZWxvZ3MgZm9yIGJvdGggcGF0
Y2hlcyAoRGFuKQ0KPiAtIEZpeCBzdXBwb3J0L2NvbnRyb2wgY2FsY3VsYXRpb24gdG8gYmUgYmFz
ZWQgb2ZmIENPTkZJR19NRU1PUllfRkFJTFVSRQ0KPiDCoCAoRGFuKQ0KPiAtIFVzZSBkZWZpbmVz
IGluc3RlYWQgb2YgbWFnaWMgbnVtYmVycyBpbiBhIGZldyBwbGFjZXMgaW4gcGF0Y2ggMg0KPiDC
oCAoSm9uYXRoYW4pDQo+IC0gRml4ICdjYXBidWYnIGFycmF5IHRvIGJlIHRoZSBjb3JyZWN0IDUg
ZWxlbWVudHMuIEFDUEkgcHJldmlvdXNseSBoYWQNCj4gwqAgJzYnIHdoZXJlIG9ubHkgMyB3ZXJl
IG5lZWRlZC4gV2l0aCBDWEwgY2FwYWJpbGl0aWVzLCBub3csIDUgYXJlDQo+IMKgIG5lZWRlZC4g
KEpvbmF0aGFuKS4NCj4gLSBGaXggYSBjb3VwbGUgb2YgdW5pbml0aWFsaXplZCB2YXJpYWJsZSB3
YXJuaW5ncyByZXBvcnRlZCBieSAwZGF5L2xrcC4NCj4gLSBEcm9wICdSRkMnIGFubm90YXRpb24g
Zm9yIHRoZSBzZXQNCj4gDQo+IEFkZCBzdXBwb3J0IGZvciB1c2luZyB0aGUgQ1hMIGRlZmluaXRp
b24gb2YgX09TQyB3aGVyZSBhcHBsaWNhYmxlLCBhbmQNCj4gbmVnb3RpYXRpbmcgQ1hMIHNwZWNp
ZmljIHN1cHBvcnQgYW5kIGNvbnRyb2wgYml0cy4NCj4gDQo+IFBhdGNoIDEgYWRkcyB0aGUgbmV3
IENYTCBfT1NDIFVVSUQsIGFuZCB1c2VzIGl0IGluc3RlYWQgb2YgdGhlIFBDSSBVVUlEDQo+IHdo
ZW4gYSByb290IHBvcnQgaXMgQ1hMIGVuYWJsZWQuIEl0IHByb3ZpZGVzIGEgZmFsbGJhY2sgbWV0
aG9kIGZvcg0KPiBDWEwtMS4xIHBsYXRmb3JtcyB0aGF0IG1heSBub3QgaW1wbGVtZW50IHRoZSBD
WEwtMi4wIF9PU0MuDQo+IA0KPiBQYXRjaCAyIHBlcmZvcm1zIG5lZ290aWF0aW9uIGZvciB0aGUg
Q1hMIHNwZWNpZmljIF9PU0Mgc3VwcG9ydCBhbmQNCj4gY29udHJvbCBiaXRzLg0KPiANCj4gSSd2
ZSB0ZXN0ZWQgdGhlc2UgYWdhaW5zdCBhIGN1c3RvbSBxZW11WzJdLCB3aGljaCBhZGRzIHRoZSBD
WEwgX09TQyAoaW4NCj4gYWRkaXRpb24gdG8gb3RoZXIgQ1hMIHN1cHBvcnQpLiBTcGVjaWZpY2Fs
bHksIF9PU0Mgc3VwcG9ydCBpcyBhZGRlZA0KPiBoZXJlWzNdLg0KPiANCj4gWzFdOiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9saW51eC1jeGwvMTQ2NTE0YjJlNTIzN2EzYzAyNzIzOWE3NWFjZTY5
ZTcyNjcxZDRjOC5jYW1lbEBpbnRlbC5jb20vVC8jdA0KPiBbMl06IGh0dHBzOi8vZ2l0bGFiLmNv
bS9qaWMyMy9xZW11Ly0vdHJlZS9jeGwtdjctZHJhZnQtMi1mb3ItdGVzdA0KPiBbM106IGh0dHBz
Oi8vZ2l0bGFiLmNvbS9qaWMyMy9xZW11Ly0vY29tbWl0LzMxYzg1MDU0Yjg0NjQ1ZGZiZDllOWJi
MTRhYTM1Mjg2MTQxYzE0Y2YNCg0KTG9naXN0aWNhbCBxdWVzdGlvbiAtIFJhZmFlbCwgZG8geW91
IGV4cGVjdCB0aGlzIHRvIGdvIHRocm91Z2ggQUNQSSwgb3INCnNob3VsZCBEYW4gcGljayBpdCB1
cCB0byBnbyB0aHJvdWdoIHRoZSBDWEwgdHJlZT8NCg0KPiANCj4gDQo+IERhbiBXaWxsaWFtcyAo
MSk6DQo+IMKgIFBDSS9BQ1BJOiBVc2UgQ1hMIF9PU0MgaW5zdGVhZCBvZiBQQ0llIF9PU0MNCj4g
DQo+IFZpc2hhbCBWZXJtYSAoMSk6DQo+IMKgIGFjcGkvcGNpX3Jvb3Q6IG5lZ290aWF0ZSBDWEwg
X09TQw0KPiANCj4gwqBpbmNsdWRlL2xpbnV4L2FjcGkuaMKgwqDCoCB8wqAgMTQgKysrDQo+IMKg
aW5jbHVkZS9hY3BpL2FjcGlfYnVzLmggfMKgwqAgNyArLQ0KPiDCoGRyaXZlcnMvYWNwaS9wY2lf
cm9vdC5jIHwgMjA0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0NCj4g
wqAzIGZpbGVzIGNoYW5nZWQsIDE5MyBpbnNlcnRpb25zKCspLCAzMiBkZWxldGlvbnMoLSkNCj4g
DQo+IA0KPiBiYXNlLWNvbW1pdDogNzRiZTk4Nzc0ZGZiYzViOGI3OTVkYjcyNmJkNzcyZTczNWQy
ZWRkNA0KDQo=
