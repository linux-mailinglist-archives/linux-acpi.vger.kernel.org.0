Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973544E7D0E
	for <lists+linux-acpi@lfdr.de>; Sat, 26 Mar 2022 01:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbiCYXNa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Mar 2022 19:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234029AbiCYXN3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Mar 2022 19:13:29 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB884FC72;
        Fri, 25 Mar 2022 16:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648249913; x=1679785913;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ty1E1w7C04AwLkwV+u58Y3GdyKBIccW8CNl5ke+Adfk=;
  b=CMXErjASLcGRmZHaLBlGPlNxoORvqRRyBtEFmj1Q6f53k/7r8yg/tob9
   iLknZ+65vLnt7/8HZrv84Xglk0j8Ki1yZYMfmbBveyMUtriElWxvz9BYR
   nbjqUOsIWNANeNFsbydKjn0/VUiQPj7noajvyQK2l+9Pj+vIB0MHo+kOb
   XMl89xeA2v4T6ZshInv58GZa4n9XpqYB+BkkSXcw8mrI7kxhhjnIvh7Yf
   tyH4lnpnpMSRga1tQ+DsE6HF9SLy9UiFROTMJnOOwPQP9aeJINo82N1TP
   VFO9migp2NWZNmvTdM8uZvwybTB58M212JFbC35lBKeitpQSpD1Da56Q5
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10297"; a="256307760"
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="256307760"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 16:11:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="648415635"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga002.fm.intel.com with ESMTP; 25 Mar 2022 16:11:53 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 25 Mar 2022 16:11:53 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 25 Mar 2022 16:11:53 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Fri, 25 Mar 2022 16:11:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXhErJLniySz9V1/I8mo23jRxyE7xFUjtFurxq54cRlJMV6/d7AmmR9aLmUu3PViOI1VkUxN0GaeuZl/ReUir4yEnejJtiV0Wgm7i7YUHRmhg0XeRJ+DCBC7TJlH3ijjAHGkCnAEXpBWD0975X68nkfmSTbDdpG0mcZ+LgzlnXF6PlmgOHHrz3NauYbbnQxdFNQBdwSZ0IE6Es5JV5z8td59r9joST26wbtYAFNq2zulUYn2k/Q6WePxFRZODrfpsVNPrLBVpa/3QQMnI7kTPeZkazsdgQXWFRuuW8Zv4iZqrVpKBeuTOVTUNYpnOgIlOiTerwVaVwHjIeG+FDqicA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ty1E1w7C04AwLkwV+u58Y3GdyKBIccW8CNl5ke+Adfk=;
 b=Ig0EfBEVr6a6PBohjmEaeczqGrXsK7gm2E6z3pUoJv0Ie1Q3eiI63K5CEoJYuhzZWxuyMHhZDL0H9AgIVNbai9JHACYXMb22wj2pf6tHCYfyk71BepQ4ftc1ZXIIgumkCB4xP4kmyFDj9Mu03JoXbuZbMCp8oaZkUwUejygl/kcZZviaC98yygEvUDBRHx/3xiTqC9Ri/hRsgxoINAqb4pgKHV6Pziq33hiDPml/aaq+JddIJVpnzo2dztN0EBShow+uAsf5vR8QoBeGiyLz9BrbPvNnIY64uO5A/nXdHV2Zh4yqxdVw58RVSXKy/ikN1t7K22QNmhxZ/s+H/4AHpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by SN6PR11MB3070.namprd11.prod.outlook.com (2603:10b6:805:d4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Fri, 25 Mar
 2022 23:11:50 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::d898:84ee:d6a:4eb1]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::d898:84ee:d6a:4eb1%6]) with mapi id 15.20.5102.019; Fri, 25 Mar 2022
 23:11:50 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "rafael@kernel.org" <rafael@kernel.org>
CC:     lkp <lkp@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Moore, Robert" <robert.moore@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] acpi/pci_root: negotiate CXL _OSC
Thread-Topic: [PATCH 2/2] acpi/pci_root: negotiate CXL _OSC
Thread-Index: AQHYOw9raWFRleZDlEKat7Ow2y257qzNYVkAgANj8YA=
Date:   Fri, 25 Mar 2022 23:11:50 +0000
Message-ID: <dfcc7b9081fb3b6f15c04c500920709e0ed2cc8e.camel@intel.com>
References: <20220318213004.2287428-1-vishal.l.verma@intel.com>
         <20220318213004.2287428-3-vishal.l.verma@intel.com>
         <CAJZ5v0i5d+eYrW8afeC4xAN8rG54e=mOFVzMEMYLn0U63jhJAg@mail.gmail.com>
In-Reply-To: <CAJZ5v0i5d+eYrW8afeC4xAN8rG54e=mOFVzMEMYLn0U63jhJAg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-1.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3990c407-f62a-4579-138e-08da0eb4d80a
x-ms-traffictypediagnostic: SN6PR11MB3070:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <SN6PR11MB307014F2F83CBBC5679E91F8C71A9@SN6PR11MB3070.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ExWdhHOgVtXI6LQPhui+DgeeF3aHZ18wuw8UnbRNNczIq32cCN6h9Tm/nf6uR4mAuEVptzWIN32LEhBQ5gIvR5NTRI2sj+xOumPQMnzjYpzL4JCTKTbWyo/N9EdaJBoaCFOJCLZ4R3M9jzBsxKTxo0qnutArIlFfXe+o6yavypEdF6T4dT3iXGfiXFqtRlXFfMdQkJ+0I2cmq5cnuXmW+BmAz6JGF6SbVS/Bf+WsBdignNP0jfUcmMKKL92JlqG0+Fclctl+sg8DLCrvismhL1nk3w5pRyKvts5hJQoAt/wE+yQieveeGLK973+wDgqXjbNgNyW0oUcZdAyDczKLfpVm5yY48tbGYT2YvO9WJM+Q185LpfHiselEzq+NnfkeY2yZbrJkKYRpV5rFcqalaTjCJ/OuOmaH4UHkcphxHmiRXqSqERLrTTYYGiOB2rBlV01aZPI2clLCHs2OcSzGbRjz7jfO2Mxi/gCv+oVU15toQnLxgUWeARG559exHysHJqLCnlf9DqAZarH1uGn6Zgo/XxDYd76kujj+S1kn4zv8hcLnKxfdAA36yKBOTc1d4OK0/EU9YP6i3DpXQd+Wni9oHOTM8c7kgSKaDkydcGOXGxtPDZh7KlZrcluFJhd9hYB7/AZY0y5Zgp1M1T4qGbXpRJSpDs4U6oYQ7djijM+a6uAjcGqnVmtfNgprrMCArXuBC8jgmsWW+IczbdVqtA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(8936002)(508600001)(186003)(2616005)(26005)(91956017)(53546011)(6512007)(6506007)(86362001)(2906002)(122000001)(82960400001)(38100700002)(6486002)(83380400001)(66556008)(38070700005)(71200400001)(66946007)(8676002)(4326008)(6916009)(64756008)(66476007)(316002)(36756003)(66446008)(54906003)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qnc4UFB2UW1uRWFWWDZzaTFTTTB1ZFBoUEZTNUVnRngxMXFUcTJnU2RGaTd4?=
 =?utf-8?B?STh5SWtUUEtwMG4wRTlDdlloa2NzeXcyaE0wYVE3bVhHZXczZHVOekJlQ2dS?=
 =?utf-8?B?MFRBR3BEcS82SERMNTR5SCtYTW5XQXZpaWNFN1RRS2pmZmt0b3NobDg2TVpr?=
 =?utf-8?B?RWlBTEVIZyt3Vkhib0ZtREVIZGtNOGpLZnNyK3FJN25LWEFmU1RGaCtsQjgx?=
 =?utf-8?B?S0hBRXdoTk40WEI4ZG51a0h6YS9KczVHQzN6UDF3VklkL3kwYW1TbHBYZE4y?=
 =?utf-8?B?TVQ5dE5sc0R5djNGb2VmNXRMNE9iL1lzOTF0STBCMHQ3S201bUl0akJLYXo1?=
 =?utf-8?B?b1ZGdE96ZFEzbkpwalFjSW9hWU1GcWdQMytJZGNqYkNSNy9hM294N25ZWWp3?=
 =?utf-8?B?eC9tS3B6MUU5UHNhVUJjU0t3b2FoV3RNVDNWeWgwUFdhWjdiYlVteENINVdQ?=
 =?utf-8?B?WTRFTjl4dks2YVowbnlJNG4wRURVUW1HYTlES2ZCM3Nkd2QxM1JxeHBBS0Mv?=
 =?utf-8?B?M0wvTW12YkgveUxPRnNWZlloRVc0eDgxUVByZFl6OHhkcXdJdVkvQ2ZGdElR?=
 =?utf-8?B?bDRBZy9LVFpWVDlaTFErTmo2czBQRWY2RXh3ZXhqNmlpQWo0Znhld1JxMXFi?=
 =?utf-8?B?ZmNNYTJlY2VBMStXSWdTdHphMzUrMG53UFhpbVhpYitGUmI0OE9ycEFXY3Q5?=
 =?utf-8?B?dnc0MW9SU25paUppcVRjTDRuMDlmUHN0K0kyWndHL2dlLzFPb3FUdHFHdlI2?=
 =?utf-8?B?cFpHQ1ovQUxSRWNjTXc4bFFORkNDQmNNZ1VxZloydXE4MHhmWUppbXN2Tktp?=
 =?utf-8?B?M2hhV0JQeTBkYTlFUkNjSlYyYzQvTmhYbGdrc1Q4ZHNDanVsOXc3SjdDNWJl?=
 =?utf-8?B?aUlwajlERGxwSkVTVUszSHQ0Y0tvWjNWSUJuTWtybGNkbk4zQkYrejZKTXpt?=
 =?utf-8?B?NnZzalJHYkYreERXNnQyakRiUjg2c3pFQTFOY1l4NjdTbFNISTZyYWVDckdh?=
 =?utf-8?B?MUtPaDc4K2lHSWF4Y3E4cWpNQ3Y3OEJmb2JJZmMvSStnalV2c0Q5eDY2a3Bo?=
 =?utf-8?B?bTNYYWRFUXQ2blgxRmdvOG8zdFJMVUVxUS83RW1ka3hxVnFoaXVMeDlUdEhr?=
 =?utf-8?B?L1ludWdYQ3RHWDlzMjV6NVMrWjNNSHRra1AyTm5maDcxUUlmOHIycW9Ca2dw?=
 =?utf-8?B?VjA3ZldSb2Z3T3VzT0tzSUgxZXd3UGlpSjIyN2ZUbDlCeUxFdHVDRERCYysy?=
 =?utf-8?B?TTQya1NDNUNUeWxoYnN1MWR3SmplMStYb21DNmNRZnF1T0NaKzkvUnhkUGlS?=
 =?utf-8?B?TnppbVlsMTFPRXlrMFlYTEdHV3F2bDhzSnhzMjkvSHU5SVhjY2E1cDFzMy85?=
 =?utf-8?B?QjFXNnpCWlFEMXA0anRVRXkxV3JjUml6TFZ6d2h6R2s1MGhXODBMNy9jT2pt?=
 =?utf-8?B?K0kzL0Y2ZXNERERTcC92enZodldRcDFkcGo2SSsyRXZjYStHNXJDdi9uZWdN?=
 =?utf-8?B?cnd5aml6RUMwVUVGZThWNmRLRDhFSkFITXU1ZSsrRTB4eGwxSFV0RXJrQ1p2?=
 =?utf-8?B?dXJUa2ZaRmFnaTF1QzkrR2xJQmx0T1JCLzJlKzFVWFdWdi85eEZjNkFKTUpp?=
 =?utf-8?B?WnBCaDhNMHZkTnorUGxnY0VrSHgzMmc3YnhCc2pGN2tJQVIwdkdMUHNZZnJn?=
 =?utf-8?B?ajJFanJQRHV4WGRQeGdiSE52L0xQZTlFR3BkWmFZb0o2UFUrbWJxRWwyOUpo?=
 =?utf-8?B?UUVEblFrUkViTkpLWWRYOGc0VmpTbXRuejBENWhCTXhkTHNVVWtwZjlSdjM1?=
 =?utf-8?B?RjlUT3dCNDUvUzJPZWViMHQ3Q3JKQzVHWGw5N2V0TWdKSlZlYVZkejZldjdX?=
 =?utf-8?B?ODVsaVRwdndWNmYyZmN3clF2anZTb0drUlU3OEp3VUFad2V0dy95ZGZ3cm95?=
 =?utf-8?B?SHZLb2kwV3NKRUsxZ1Mwa2JtTkkzRElpbkRXNUVQVTkzK1p3SjhHS3U4ODlk?=
 =?utf-8?B?UmxsbmQ3S3FFVVNxejlmQzRiZzZyZTJ2eEdPTVVrR1VqZjczRTNhcE1ueGF4?=
 =?utf-8?B?ZDJNVkx5Tm91NHQ3dHQ1Y2NmbmIwZmJlK2NObmRKK2cwMlN5QXZ2OHdsbXdv?=
 =?utf-8?B?cDFFTzRKR0VWNFFGMkF1WU41K0dMcGRmd0R5UFUzRUhtYmR3U01MZHBJdHA2?=
 =?utf-8?B?N2FiU1FhQjZLQ1loakp6QlJaUFRoZ1ZzaVFNWmZYRlJzUGgzcjllR1lKRGQy?=
 =?utf-8?B?eURzSXc4VEVXMktoRGJ3SEhLYXU1eGY3WTgvTkZ3bnQwMEtNNDliZnJjRCtE?=
 =?utf-8?B?bGxMVVRsa3F2UGlwTFNMdHBiWXQweSswcVZSSTdIem10b2lrK3RhSHdRRlRm?=
 =?utf-8?Q?7OsRACo9tJgOiygE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D9307AA84D66E4CAC053B92605E3AC2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3990c407-f62a-4579-138e-08da0eb4d80a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2022 23:11:50.7006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D1uZBnWBKfOW7rxyLYkDgE5v2IIPqxuYP4iU3GioSK9NbMyplXvLLtS/e9d++3Z5KaI/O9mJopajTZ5ZvxrzfxdYKhVv2y90F25ADY2vpKs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3070
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

T24gV2VkLCAyMDIyLTAzLTIzIGF0IDIwOjI1ICswMTAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToKPiBPbiBGcmksIE1hciAxOCwgMjAyMiBhdCAxMDozMCBQTSBWaXNoYWwgVmVybWEgPHZpc2hh
bC5sLnZlcm1hQGludGVsLmNvbT4gd3JvdGU6Cj4gPiAKPiA+IEBAIC0zODUsMjAgKzQzNywzNSBA
QCBzdGF0aWMgYWNwaV9zdGF0dXMgYWNwaV9wY2lfb3NjX2NvbnRyb2xfc2V0KGFjcGlfaGFuZGxl
IGhhbmRsZSwgdTMyICptYXNrLCB1MzIgcwo+ID4gwqDCoMKgwqDCoMKgwqAgY3RybMKgwqAgPSAq
bWFzazsKPiA+IMKgwqDCoMKgwqDCoMKgICptYXNrIHw9IHJvb3QtPm9zY19jb250cm9sX3NldDsK
PiA+IAo+ID4gK8KgwqDCoMKgwqDCoCBpZiAoaXNfY3hsKHJvb3QpKSB7Cj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBjeGxfY3RybCA9ICpjeGxfbWFzazsKPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgICptYXNrIHw9IHJvb3QtPm9zY19jb250cm9sX3NldDsKPiAKPiBJ
cyB0aGlzIGNvcnJlY3Q/Cj4gCj4gSXQgYXBwZWFycyByZWR1bmRhbnQgYXQgbGVhc3QsIGJlY2F1
c2UgdGhlIHNhbWUgdXBkYXRlIGhhcyBhbHJlYWR5Cj4gaGFwcGVuZWQgYWJvdmUuCgpPaCBnb29k
IHNwb3QgLSB0aGlzIHdhcyBhIGNvcHktcGFzdGUgZXJyb3IsIGl0IG5lZWRzIHRvIGJlOgoKICAq
Y3hsX21hc2sgfD0gcm9vdC0+Y3hsX29zY19jb250cm9sX3NldDsKCkkndmUgZml4ZWQgdGhpcyB1
cCBhbmQgYWxsIG90aGVyIGNvbW1lbnRzIHRvbyBmb3IgdjIuCgpUaGFua3MgZm9yIHRoZSByZXZp
ZXchCgo+IAo+ID4gK8KgwqDCoMKgwqDCoCB9Cj4gPiArCj4gPiDCoMKgwqDCoMKgwqDCoCAvKiBO
ZWVkIHRvIGNoZWNrIHRoZSBhdmFpbGFibGUgY29udHJvbHMgYml0cyBiZWZvcmUgcmVxdWVzdGlu
ZyB0aGVtLiAqLwo+ID4gwqDCoMKgwqDCoMKgwqAgZG8gewo+ID4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgc3RhdHVzID0gYWNwaV9wY2lfcXVlcnlfb3NjKHJvb3QsIHN1cHBvcnQsIG1h
c2spOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RhdHVzID0gYWNwaV9wY2lf
cXVlcnlfb3NjKHJvb3QsIHN1cHBvcnQsIG1hc2ssIGN4bF9zdXBwb3J0LAo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBjeGxfbWFzayk7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgaWYgKEFDUElfRkFJTFVSRShzdGF0dXMpKQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gc3RhdHVzOwo+ID4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGN0cmwgPT0gKm1hc2spCj4gPiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4gPiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBkZWNvZGVfb3NjX2NvbnRyb2wocm9vdCwgInBsYXRmb3JtIGRvZXMg
bm90IHN1cHBvcnQiLAo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjdHJsICYgfigqbWFzaykpOwo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGlzX2N4bChyb290KSkgewo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICgoY3RybCA9PSAqbWFzaykg
JiYgKGN4bF9jdHJsID09ICpjeGxfbWFzaykpCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRlY29kZV9jeGxfb3NjX2NvbnRy
b2wocm9vdCwgInBsYXRmb3JtIGRvZXMgbm90IHN1cHBvcnQiLAo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgY3hsX2N0cmwgJiB+KCpjeGxfbWFzaykpOwo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfSBlbHNlIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBpZiAoY3RybCA9PSAqbWFzaykKPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGVjb2RlX29zY19j
b250cm9sKHJvb3QsICJwbGF0Zm9ybSBkb2VzIG5vdCBzdXBwb3J0IiwKPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGN0cmwgJiB+KCptYXNrKSk7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB9Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY3RybCA9ICpt
YXNrOwo+ID4gLcKgwqDCoMKgwqDCoCB9IHdoaWxlICgqbWFzayk7Cj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBjeGxfY3RybCA9ICpjeGxfbWFzazsKPiA+ICvCoMKgwqDCoMKgwqAg
fSB3aGlsZSAoKm1hc2sgfHwgKmN4bF9tYXNrKTsKPiA+IAo+ID4gwqDCoMKgwqDCoMKgwqAgLyog
Tm8gbmVlZCB0byByZXF1ZXN0IF9PU0MgaWYgdGhlIGNvbnRyb2wgd2FzIGFscmVhZHkgZ3JhbnRl
ZC4gKi8KPiA+IC3CoMKgwqDCoMKgwqAgaWYgKChyb290LT5vc2NfY29udHJvbF9zZXQgJiBjdHJs
KSA9PSBjdHJsKQo+ID4gK8KgwqDCoMKgwqDCoCBpZiAoKChyb290LT5vc2NfY29udHJvbF9zZXQg
JiBjdHJsKSA9PSBjdHJsKSAmJgo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgICgocm9vdC0+Y3hs
X29zY19jb250cm9sX3NldCAmIGN4bF9jdHJsKSA9PSBjeGxfY3RybCkpCj4gPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIEFFX09LOwo+ID4gCj4gPiDCoMKgwqDCoMKgwqDC
oCBpZiAoKGN0cmwgJiByZXEpICE9IHJlcSkgewo+ID4gQEAgLTQxMCwxMSArNDc3LDE3IEBAIHN0
YXRpYyBhY3BpX3N0YXR1cyBhY3BpX3BjaV9vc2NfY29udHJvbF9zZXQoYWNwaV9oYW5kbGUgaGFu
ZGxlLCB1MzIgKm1hc2ssIHUzMiBzCj4gPiDCoMKgwqDCoMKgwqDCoCBjYXBidWZbT1NDX1FVRVJZ
X0RXT1JEXSA9IDA7Cj4gPiDCoMKgwqDCoMKgwqDCoCBjYXBidWZbT1NDX1NVUFBPUlRfRFdPUkRd
ID0gcm9vdC0+b3NjX3N1cHBvcnRfc2V0Owo+ID4gwqDCoMKgwqDCoMKgwqAgY2FwYnVmW09TQ19D
T05UUk9MX0RXT1JEXSA9IGN0cmw7Cj4gPiAtwqDCoMKgwqDCoMKgIHN0YXR1cyA9IGFjcGlfcGNp
X3J1bl9vc2Mocm9vdCwgY2FwYnVmLCBtYXNrKTsKPiA+ICvCoMKgwqDCoMKgwqAgaWYgKGlzX2N4
bChyb290KSkgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2FwYnVmW09TQ19D
WExfU1VQUE9SVF9EV09SRF0gPSByb290LT5jeGxfb3NjX3N1cHBvcnRfc2V0Owo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2FwYnVmW09TQ19DWExfQ09OVFJPTF9EV09SRF0gPSBj
eGxfY3RybDsKPiA+ICvCoMKgwqDCoMKgwqAgfQo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoCBzdGF0
dXMgPSBhY3BpX3BjaV9ydW5fb3NjKHJvb3QsIGNhcGJ1ZiwgbWFzaywgY3hsX21hc2spOwo+ID4g
wqDCoMKgwqDCoMKgwqAgaWYgKEFDUElfRkFJTFVSRShzdGF0dXMpKQo+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBzdGF0dXM7Cj4gPiAKPiA+IMKgwqDCoMKgwqDCoMKg
IHJvb3QtPm9zY19jb250cm9sX3NldCA9ICptYXNrOwo+ID4gK8KgwqDCoMKgwqDCoCByb290LT5j
eGxfb3NjX2NvbnRyb2xfc2V0ID0gKmN4bF9tYXNrOwo+ID4gwqDCoMKgwqDCoMKgwqAgcmV0dXJu
IEFFX09LOwo+ID4gwqB9Cj4gPiAKPiA+IEBAIC00NDAsNiArNTEzLDE5IEBAIHN0YXRpYyB1MzIg
Y2FsY3VsYXRlX3N1cHBvcnQodm9pZCkKPiA+IMKgwqDCoMKgwqDCoMKgIHJldHVybiBzdXBwb3J0
Owo+ID4gwqB9Cj4gPiAKPiA+ICtzdGF0aWMgdTMyIGNhbGN1bGF0ZV9jeGxfc3VwcG9ydCh2b2lk
KQo+ID4gK3sKPiA+ICvCoMKgwqDCoMKgwqAgdTMyIHN1cHBvcnQ7Cj4gPiArCj4gPiArwqDCoMKg
wqDCoMKgIHN1cHBvcnQgPSBPU0NfQ1hMXzJfMF9QT1JUX0RFVl9SRUdfQUNDRVNTX1NVUFBPUlQ7
Cj4gPiArwqDCoMKgwqDCoMKgIGlmIChwY2lfYWVyX2F2YWlsYWJsZSgpKQo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgc3VwcG9ydCB8PSBPU0NfQ1hMX1BST1RPQ09MX0VSUl9SRVBP
UlRJTkdfU1VQUE9SVDsKPiA+ICvCoMKgwqDCoMKgwqAgaWYgKElTX0VOQUJMRUQoQ09ORklHX0hP
VFBMVUdfUENJX1BDSUUpKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3VwcG9y
dCB8PSBPU0NfQ1hMX05BVElWRV9IUF9TVVBQT1JUOwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoCBy
ZXR1cm4gc3VwcG9ydDsKPiA+ICt9Cj4gPiArCj4gPiDCoHN0YXRpYyB1MzIgY2FsY3VsYXRlX2Nv
bnRyb2wodm9pZCkKPiA+IMKgewo+ID4gwqDCoMKgwqDCoMKgwqAgdTMyIGNvbnRyb2w7Cj4gPiBA
QCAtNDcxLDYgKzU1NywxNiBAQCBzdGF0aWMgdTMyIGNhbGN1bGF0ZV9jb250cm9sKHZvaWQpCj4g
PiDCoMKgwqDCoMKgwqDCoCByZXR1cm4gY29udHJvbDsKPiA+IMKgfQo+ID4gCj4gPiArc3RhdGlj
IHUzMiBjYWxjdWxhdGVfY3hsX2NvbnRyb2wodm9pZCkKPiA+ICt7Cj4gPiArwqDCoMKgwqDCoMKg
IHUzMiBjb250cm9sID0gMDsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqAgaWYgKElTX0VOQUJMRUQo
Q09ORklHX01FTU9SWV9GQUlMVVJFKSkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGNvbnRyb2wgfD0gT1NDX0NYTF9FUlJPUl9SRVBPUlRJTkdfQ09OVFJPTDsKPiA+ICsKPiA+ICvC
oMKgwqDCoMKgwqAgcmV0dXJuIGNvbnRyb2w7Cj4gPiArfQo+ID4gKwo+ID4gwqBzdGF0aWMgYm9v
bCBvc19jb250cm9sX3F1ZXJ5X2NoZWNrcyhzdHJ1Y3QgYWNwaV9wY2lfcm9vdCAqcm9vdCwgdTMy
IHN1cHBvcnQpCj4gPiDCoHsKPiA+IMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBhY3BpX2RldmljZSAq
ZGV2aWNlID0gcm9vdC0+ZGV2aWNlOwo+ID4gQEAgLTQ5Miw2ICs1ODgsNyBAQCBzdGF0aWMgYm9v
bCBvc19jb250cm9sX3F1ZXJ5X2NoZWNrcyhzdHJ1Y3QgYWNwaV9wY2lfcm9vdCAqcm9vdCwgdTMy
IHN1cHBvcnQpCj4gPiDCoHN0YXRpYyB2b2lkIG5lZ290aWF0ZV9vc19jb250cm9sKHN0cnVjdCBh
Y3BpX3BjaV9yb290ICpyb290LCBpbnQgKm5vX2FzcG0pCj4gPiDCoHsKPiA+IMKgwqDCoMKgwqDC
oMKgIHUzMiBzdXBwb3J0LCBjb250cm9sID0gMCwgcmVxdWVzdGVkID0gMDsKPiA+ICvCoMKgwqDC
oMKgwqAgdTMyIGN4bF9zdXBwb3J0ID0gMCwgY3hsX2NvbnRyb2wgPSAwLCBjeGxfcmVxdWVzdGVk
ID0gMDsKPiA+IMKgwqDCoMKgwqDCoMKgIGFjcGlfc3RhdHVzIHN0YXR1czsKPiA+IMKgwqDCoMKg
wqDCoMKgIHN0cnVjdCBhY3BpX2RldmljZSAqZGV2aWNlID0gcm9vdC0+ZGV2aWNlOwo+ID4gwqDC
oMKgwqDCoMKgwqAgYWNwaV9oYW5kbGUgaGFuZGxlID0gZGV2aWNlLT5oYW5kbGU7Cj4gPiBAQCAt
NTE1LDEwICs2MTIsMjAgQEAgc3RhdGljIHZvaWQgbmVnb3RpYXRlX29zX2NvbnRyb2woc3RydWN0
IGFjcGlfcGNpX3Jvb3QgKnJvb3QsIGludCAqbm9fYXNwbSkKPiA+IMKgwqDCoMKgwqDCoMKgIGlm
IChvc19jb250cm9sX3F1ZXJ5X2NoZWNrcyhyb290LCBzdXBwb3J0KSkKPiA+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCByZXF1ZXN0ZWQgPSBjb250cm9sID0gY2FsY3VsYXRlX2NvbnRy
b2woKTsKPiA+IAo+ID4gLcKgwqDCoMKgwqDCoCBzdGF0dXMgPSBhY3BpX3BjaV9vc2NfY29udHJv
bF9zZXQoaGFuZGxlLCAmY29udHJvbCwgc3VwcG9ydCk7Cj4gPiArwqDCoMKgwqDCoMKgIGlmIChp
c19jeGwocm9vdCkpIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGN4bF9zdXBw
b3J0ID0gY2FsY3VsYXRlX2N4bF9zdXBwb3J0KCk7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBkZWNvZGVfY3hsX29zY19zdXBwb3J0KHJvb3QsICJPUyBzdXBwb3J0cyIsIGN4bF9z
dXBwb3J0KTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGN4bF9yZXF1ZXN0ZWQg
PSBjeGxfY29udHJvbCA9IGNhbGN1bGF0ZV9jeGxfY29udHJvbCgpOwo+ID4gK8KgwqDCoMKgwqDC
oCB9Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgIHN0YXR1cyA9IGFjcGlfcGNpX29zY19jb250cm9s
X3NldChoYW5kbGUsICZjb250cm9sLCBzdXBwb3J0LAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgICZjeGxfY29udHJvbCwgY3hsX3N1cHBvcnQpOwo+ID4gwqDCoMKgwqDCoMKgwqAgaWYgKEFD
UElfU1VDQ0VTUyhzdGF0dXMpKSB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
aWYgKGNvbnRyb2wpCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGRlY29kZV9vc2NfY29udHJvbChyb290LCAiT1Mgbm93IGNvbnRyb2xzIiwgY29udHJv
bCk7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoY3hsX2NvbnRyb2wpCj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGVjb2RlX2N4
bF9vc2NfY29udHJvbChyb290LCAiT1Mgbm93IGNvbnRyb2xzIiwKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGN4bF9jb250cm9sKTsKPiA+IAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGlmIChhY3BpX2dibF9GQURULmJvb3RfZmxhZ3MgJiBBQ1BJX0ZBRFRfTk9fQVNQ
TSkgewo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAv
Kgo+ID4gQEAgLTU0Nyw2ICs2NTQsMTEgQEAgc3RhdGljIHZvaWQgbmVnb3RpYXRlX29zX2NvbnRy
b2woc3RydWN0IGFjcGlfcGNpX3Jvb3QgKnJvb3QsIGludCAqbm9fYXNwbSkKPiA+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGVjb2RlX29zY19jb250cm9s
KHJvb3QsICJPUyByZXF1ZXN0ZWQiLCByZXF1ZXN0ZWQpOwo+ID4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZWNvZGVfb3NjX2NvbnRyb2wocm9vdCwgInBs
YXRmb3JtIHdpbGxpbmcgdG8gZ3JhbnQiLCBjb250cm9sKTsKPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB9Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoY3hs
X2NvbnRyb2wpIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBkZWNvZGVfY3hsX29zY19jb250cm9sKHJvb3QsICJPUyByZXF1ZXN0ZWQiLCBjeGxfcmVx
dWVzdGVkKTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBkZWNvZGVfY3hsX29zY19jb250cm9sKHJvb3QsICJwbGF0Zm9ybSB3aWxsaW5nIHRvIGdyYW50
IiwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGN4bF9jb250cm9sKTsKPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0KPiA+IAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGRldl9pbmZvKCZkZXZpY2UtPmRldiwgIl9PU0M6IHBsYXRmb3JtIHJldGFpbnMg
Y29udHJvbCBvZiBQQ0llIGZlYXR1cmVzICglcylcbiIsCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYWNwaV9mb3JtYXRfZXhjZXB0aW9uKHN0YXR1
cykpOwo+ID4gLS0KPiA+IDIuMzUuMQo+ID4gCgo=
