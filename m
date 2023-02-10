Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A62F692B01
	for <lists+linux-acpi@lfdr.de>; Sat, 11 Feb 2023 00:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjBJXRN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Feb 2023 18:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBJXRM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Feb 2023 18:17:12 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD9E17CEE;
        Fri, 10 Feb 2023 15:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676071031; x=1707607031;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7f9aG3a1X9qu6eYbR2Q/lzokh603nQExz9rGfIrWCl8=;
  b=SiuYSK3YY37odVQdL6fuPsB8PP+igbYXK1JzM7ziwcwAHyE5Cs1gq9/P
   q5jFbaYaz4igeiOIwhe54nOI5yrHiydOr6/5RJSkxWAHCbCW8hjt3/6x3
   Wtg8/psAJjH9/ooxkG44hKDNukPkAkVTYUNEEATook6LDRfxXYJNPkuAY
   FQF92vZW22hIkCcc32M88o6XP0AOoYXk7M+85v/7EMoGxrnSrcGCADT8J
   vluYoyVTRjounhBZpFvR5EpPG99pQ1yBg8erAmGww4lf5InxV4o4+cg8L
   FTOrKUbotOO3qjpuW0x7S5BAr3Vat3G567fXAK/x6Qne2UiPhjtNMlq2v
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="392954687"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="392954687"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 15:17:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="736884605"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="736884605"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 10 Feb 2023 15:17:04 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 15:17:04 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 15:17:03 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 10 Feb 2023 15:17:03 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 10 Feb 2023 15:17:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RpQqirxVmTW5W8+r+MCGpwQE1Kx/2sCpSB7eqnPQzY8n82Q48eWcKyTXZ91SOkiS9iBpzfPefJbfcEJtKANMgz/xMgXL1IrSOFSWmStlbhRv77zVW/1lTJL9k/weRtDCpjx/9ZqcKaD9BIh+vaf77z66JEap7UcQAHJ2Y9ifokQKwzqRoPcgI23EgS3z/vEnLwDyC6FtZWbW9oCl/gvz5n0lSZ6mF8jsurDNw9E2nv/xLuh2cpUfIu/6PMpoR0yQBExWvdqe332OZH+6ZjC8YGTcEqTIS82t+maNMkYg9RpGPQzSYKoH/WM7DSVTq8cJo0ewZqb5UVyb+/DOv9JHCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7f9aG3a1X9qu6eYbR2Q/lzokh603nQExz9rGfIrWCl8=;
 b=m/zTv/iztIDXyl9Gi5QlwMQ8rc+rkFrPEujklUxdCtkLjS1c51kCbbT1qNcv5U0vThvI7Do4v+ZN17176qDVI77Ff+E/ykoMbiJFNRorzyEPgImTVC9iCLgEBHzVsL65rs1cNoxkB6wOpIp1V0u6vTLzb8HDCrPchZ5pNLaI/G0uxg/EhNqvDFA+632VPJjz1KRuYMhhj0PB6Y6THHv+2o8pg6H7hZj4v10/T6jhljEy0uQFBU8BJTeK1YT/Y4E6Yv7bbfBvLHfkNt2T26haeDluA1d1kddF88QGOHpvf/bqJwEoxFOVb3eTh3HycxQJ3s9nskBic9VfKOt1ecjrhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by MW4PR11MB6763.namprd11.prod.outlook.com (2603:10b6:303:20b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.21; Fri, 10 Feb
 2023 23:17:01 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::35af:d7a8:8484:627]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::35af:d7a8:8484:627%5]) with mapi id 15.20.6086.017; Fri, 10 Feb 2023
 23:17:01 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2 01/20] cxl/memdev: Fix endpoint port removal
Thread-Topic: [PATCH v2 01/20] cxl/memdev: Fix endpoint port removal
Thread-Index: AQHZPS7WY7b06dYEgUaGSi8v0QvOEa7I0S6A
Date:   Fri, 10 Feb 2023 23:17:01 +0000
Message-ID: <205c20125f9ac540b600acee346714fae73de258.camel@intel.com>
References: <167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com>
         <167601992789.1924368.8083994227892600608.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <167601992789.1924368.8083994227892600608.stgit@dwillia2-xfh.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.3 (3.46.3-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB3999:EE_|MW4PR11MB6763:EE_
x-ms-office365-filtering-correlation-id: 8a9f6ef0-c207-41db-5942-08db0bbcea34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0aGAmvbGNROnC/wwuE0uuwghSwBdGsk47XLlAZPChZcmURy7261XF/eCIQfVSykoTMyzKWI4If7xMKzh9bILGeZAWbRvyB0Y36l+lfB6k7dRzxJyCMgX1b6k/w51jLBCbIQfyAN78kriYAZZ2egkTE/WSmECVENfneP5h1qjoCgPxV6fq62hbbnGy8SOD9fUVJrLypVAZBuJFES4DwXkUNSymBcYzzKOl0k+wJL70lJluUwPD841Q6EwTppYYFq1giVxGCV62AmlZgzTOsakGMm49XhHuBVLwgEZJMQcuhua7v24yXwrLOdc4BdX5ZU7EQr2Xy5HohmdezZFPegu5MoY7rDBFY16MovsLP/0mzAzFe7EngRwJk6C7NrdgW0DEUFR7pqo1csdddYoK8bKevsovATh/FDzNslnqVN9j0G1F+4GmsOo+KojTydW7o/HAicN/S+Nq0rEp8a/yW2XNUmFceqC7NGIw4yVmPlmA11fyMPaJ//sKUNVxkOJ/vL2X9+H+ebcYq9JN9beMoAbyZZ0+Fg6p4+3iYJpKvk7vTU8x6+KEoZn8rjsol33xiTY9+2Y4tN6cnSfO6qbXcnHkyf/XeygW4NPKO9S7tugerNK9lfwO5AjTmuRJMGax2LiauK1dPsKvcLO5KgEG+pYM7p+jl+D5pSUGcZPJhxO53JZ7xnbz9P+agr4fzaB61uU6A9KQ4xsCVs2X5ZCGdMnC6csH4KaoUkYAJPhV47XUN+U+QmEMg/vGtPGmJ0s9GOC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(366004)(136003)(376002)(396003)(451199018)(110136005)(316002)(54906003)(91956017)(5660300002)(8676002)(76116006)(4326008)(66946007)(66556008)(66476007)(41300700001)(66446008)(64756008)(82960400001)(38070700005)(86362001)(36756003)(38100700002)(122000001)(6512007)(6506007)(26005)(71200400001)(6486002)(966005)(186003)(2616005)(2906002)(8936002)(478600001)(83380400001)(309714004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UCtBc01FdVR0YW5mcGsrYytIemhzY3ZlOFUram10SFN4N0xtdmZoVEwyOWVP?=
 =?utf-8?B?ZDhTZ1hiN283UE9scTFCaTk0bWlYNWQzTDRiWkdneGVjSmV3b2tlY2NhM3Bx?=
 =?utf-8?B?d2wzNGxPb0lvS0YvVUF3WElvNytpcVRDSTRVRVQ0OTc1ZitKTjhhU1V3Zmkv?=
 =?utf-8?B?Y2xkeGlrSG9mMmx5MFVRd1VFQ0k3aENjZVgrK3ZMZmh5TWtnTWhzTWNwVVAx?=
 =?utf-8?B?Y3Vhakp1cXdSekpkT1lOdEp3dlo4aFQvMnpUOXhYNko3NDNHTWcxLytCaXd4?=
 =?utf-8?B?TWdlVHFxZXllallOeXlmTmFNQVYrUVJQMmFNWGtVRGdYSlhBK013U2VFUlFL?=
 =?utf-8?B?T2NlM2pPVTV0NGlURTY5U2VhUXgwWDJsTlFGNnRyUTFidkdkcHYvc29LUTJT?=
 =?utf-8?B?K3pOd3UzK2VzbzU1TElnR0NHRDM1b2twMEpzTG51S096VjJJK2wzMVhIejJK?=
 =?utf-8?B?WVdPdUg1RFA0UVcyeEk4djcxSTV2dEpOWHh6OXBSZ1dYSjFHQjVKRlhpUWxI?=
 =?utf-8?B?NHdaaGR4K1RyMjVOajFJOEdkN01tY055T3NEVzIycUJWWWlRbmRCQk45alVs?=
 =?utf-8?B?VWFValBhTlhaT1ZGMk1NUXpSMGZmUUp1K3VaK3F1b2d5UUx1YjA2YmFnNGQ3?=
 =?utf-8?B?WUhSK1dScmU3K01VL2xsdHR0VnFFR0kwaE9maEdDdEgrbjJkSnlLRmE5RnZq?=
 =?utf-8?B?Rm1nSUFSanZEMkFxVEU3cmlNM01xZTZLeGpDdzg1c2FpYUZOdHU2YzJ4VlV1?=
 =?utf-8?B?ck1vQnNtSEQxOHNkTFJDRlZUVElVOVlxS2xmQWRyUFZycmhiMzR3cm1EWjF4?=
 =?utf-8?B?MG9lc2hGTzBXMk9FRUd5UVZVSXMxcEdWczNTQmxPbEhCTVNTRGpYRmswalJN?=
 =?utf-8?B?dGF3VXhpK2RQWkVFdTdqU1hLK0xBQUYyMTljaEQ4Y0JCZVNRUGRvMVNIYlB0?=
 =?utf-8?B?cUVvS1FtcllBdUk1cnpiSmVmYjFtM3poVU42Z1phbFR3ZDhVaHE1ZW5TcFBF?=
 =?utf-8?B?a0RGR0FYRzdVUlJHM0NwTjZwelhmalMwRmkwOUloS2dtUkZBZDBKUm5oekgy?=
 =?utf-8?B?Y05pTUUvYWNqNFd2T00xWGN4ekFzSWduYytJYmF2c0p4SEQvWFJCd3JPR3Zh?=
 =?utf-8?B?QmxwR3RVUEFlK1kzVU4rWHNycEJDSklNaHphTjNqaHJVY2h2OFFOMXRqaUtQ?=
 =?utf-8?B?UkZqL25ZU1ZMVnFUVi9hV0phK1VFVFdyT3hVcUV5dldwS3hHNVlaMVlKbENE?=
 =?utf-8?B?ekllV0g4K1l4NmxzekE5cGY1Y0J3aHlPdDBRWnM2NlUrZmlPaHpkK1RndGdp?=
 =?utf-8?B?cEMzbGxpMDhwTGVaSERzT2NOcHF6TzRkOUVucXVUOHRBbmkvM255ZjY2UmRH?=
 =?utf-8?B?YXl0UXd3RnlZOGNyRFYwZ2tpenFxS0xYbnh3N2FjTHdkZFRZQWtSUCtBWjEy?=
 =?utf-8?B?L3hDMWNWaXBvakdrcFNsUk9hamU1dForMEtQWmdrNUNBMXh0Mys4K2gwR3cz?=
 =?utf-8?B?SEFhcGc3cDBaRE9TdjNhdVhEUGp4Qk5QWUNabVAvK2NuaUtENUdCZWxLdzVz?=
 =?utf-8?B?NU1QYU5TMFRSL29oMGRrWkMwaFJ0aGJZdGhkNHJlZ252ZnBJYUtnc29SSkow?=
 =?utf-8?B?M2I2MkNURkxYTTg5V3dwa0lJK2xURzRxNGRIQWZ2OU93RGlGa2cwSkEzaER0?=
 =?utf-8?B?N1NBV1FrZUxYS1lvNk1Ccm95cWE5ajYyTjZQWU1NZmdFRXQxMkxIYjRuTFVZ?=
 =?utf-8?B?Rlc0OGFPUm01aFQxQit4RGlJdFZFbm9SSkhRS00xNGFXZ2dEK0ZBZ0syYlAy?=
 =?utf-8?B?WjJMYzdiSmMyV04rM0NjMDRGbGpsdGJtVjd3NlQrWEIyb2dsdVRkUVdMZ1dr?=
 =?utf-8?B?cytTN29WSUNtUlJRZ0NLbEhueVZ6Qnl6dDBaTWExdkEvWE1STlVtYzdEb3Mr?=
 =?utf-8?B?OGVCVWNDNEwvVnBhQ1FuT1hzMDhzeTVOU3FQclhNNjkvR1BNMjIxcVJhV2F2?=
 =?utf-8?B?UXVjWTJ4S2JUT296dTRXN3pxRlhLZFdSQllDWkpGc0RtQUIwYkNVWUpReDVz?=
 =?utf-8?B?MVcxMUhaaTBjbml3QzluNEpNL2ZWV01UTmU5QVNObS9qOUhVMGptc1h0ZnUz?=
 =?utf-8?B?UlF6UXcwdDZsK3BBODVWNWZCWkVoMlRURFdiK3lGZGJzSUdOWGJCZ2l1MUNa?=
 =?utf-8?B?UGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A58DAB430FBED42BFDE5FE449DD3B55@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a9f6ef0-c207-41db-5942-08db0bbcea34
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2023 23:17:01.3801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JM8DLm9Ei15rXwuJa4E+Ql6iMJlq/2NcNJtaQY+9a6WSR0cvRLf5Vj9BT+Z26Y+Nzu3L83eWB5gRV7d51g5cAeZqFk7LgikNoCgvCEANeMY=
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

T24gRnJpLCAyMDIzLTAyLTEwIGF0IDAxOjA1IC0wODAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6Cj4g
VGVzdGluZyBvZiByYW0gcmVnaW9uIHN1cHBvcnQgWzFdLCBzdGltdWxhdGVzIGEgbG9uZyBzdGFu
ZGluZyBidWcgaW4KPiBjeGxfZGV0YWNoX2VwKCkgd2hlcmUgc29tZSBjeGxfZXBfcmVtb3ZlKCkg
Y2xlYW51cCBpcyBza2lwcGVkIGR1ZSB0bwo+IGluYWJpbGl0eSB0byB3YWxrIHBvcnRzIGFmdGVy
IGRwb3J0cyBoYXZlIGJlZW4gdW5yZWdpc3RlcmVkLiBUaGF0Cj4gcmVzdWx0cyBpbiBhIGZhaWx1
cmUgdG8gcmUtcmVnaXN0ZXIgYSBtZW1kZXYgYWZ0ZXIgdGhlIHBvcnQgaXMKPiByZS1lbmFibGVk
IGxlYWRpbmcgdG8gYSBjcmFzaCBsaWtlIHRoZSBmb2xsb3dpbmc6Cj4gCj4gwqDCoMKgIGN4bF9w
b3J0X3NldHVwX3RhcmdldHM6IGN4bCByZWdpb240OiBjeGxfaG9zdF9icmlkZ2UuMDpwb3J0NCBp
dzogMSBpZzogMjU2Cj4gwqDCoMKgIGdlbmVyYWwgcHJvdGVjdGlvbiBmYXVsdCwgLi4uCj4gwqDC
oMKgIFsuLl0KPiDCoMKgwqAgUklQOiAwMDEwOmN4bF9yZWdpb25fc2V0dXBfdGFyZ2V0cysweDg5
Ny8weDllMCBbY3hsX2NvcmVdCj4gwqDCoMKgIGRldl9uYW1lIGF0IGluY2x1ZGUvbGludXgvZGV2
aWNlLmg6NzAwCj4gwqDCoMKgIChpbmxpbmVkIGJ5KSBjeGxfcG9ydF9zZXR1cF90YXJnZXRzIGF0
IGRyaXZlcnMvY3hsL2NvcmUvcmVnaW9uLmM6MTE1NQo+IMKgwqDCoCAoaW5saW5lZCBieSkgY3hs
X3JlZ2lvbl9zZXR1cF90YXJnZXRzIGF0IGRyaXZlcnMvY3hsL2NvcmUvcmVnaW9uLmM6MTI0OQo+
IMKgwqDCoCBbLi5dCj4gwqDCoMKgIENhbGwgVHJhY2U6Cj4gwqDCoMKgwqAgPFRBU0s+Cj4gwqDC
oMKgwqAgYXR0YWNoX3RhcmdldCsweDM5YS8weDc2MCBbY3hsX2NvcmVdCj4gwqDCoMKgwqAgPyBf
X211dGV4X3VubG9ja19zbG93cGF0aCsweDNhLzB4MjkwCj4gwqDCoMKgwqAgY3hsX2FkZF90b19y
ZWdpb24rMHhiOC8weDM0MCBbY3hsX2NvcmVdCj4gwqDCoMKgwqAgPyBsb2NrZGVwX2hhcmRpcnFz
X29uKzB4N2QvMHgxMDAKPiDCoMKgwqDCoCBkaXNjb3Zlcl9yZWdpb24rMHg0Yi8weDgwIFtjeGxf
cG9ydF0KPiDCoMKgwqDCoCA/IF9fcGZ4X2Rpc2NvdmVyX3JlZ2lvbisweDEwLzB4MTAgW2N4bF9w
b3J0XQo+IMKgwqDCoMKgIGRldmljZV9mb3JfZWFjaF9jaGlsZCsweDU4LzB4OTAKPiDCoMKgwqDC
oCBjeGxfcG9ydF9wcm9iZSsweDEwZS8weDEzMCBbY3hsX3BvcnRdCj4gwqDCoMKgwqAgY3hsX2J1
c19wcm9iZSsweDE3LzB4NTAgW2N4bF9jb3JlXQo+IAo+IENoYW5nZSB0aGUgcG9ydCBhbmNlc3Ry
eSB3YWxrIHRvIGJlIGJ5IGRlcHRoIHJhdGhlciB0aGFuIGJ5IGRwb3J0LiBUaGlzCj4gZW5zdXJl
cyB0aGF0IGV2ZW4gaWYgYSBwb3J0IGhhcyB1bnJlZ2lzdGVyZWQgaXRzIGRwb3J0cyBhIGRlZmVy
cmVkCj4gbWVtZGV2IGNsZWFudXAgd2lsbCBzdGlsbCBiZSBhYmxlIHRvIGNsZWFudXAgdGhlIG1l
bWRldidzIGludGVyZXN0IGluCj4gdGhhdCBwb3J0Lgo+IAo+IFRoZSBwYXJlbnRfcG9ydC0+ZGV2
LmRyaXZlciBjaGVjayBpcyBvbmx5IG5lZWRlZCBmb3IgZGV0ZXJtaW5pbmcgaWYgdGhlCj4gYm90
dG9tIHVwIHJlbW92YWwgYmVhdCB0aGUgdG9wLWRvd24gcmVtb3ZhbCwgYnV0IGN4bF9lcF9yZW1v
dmUoKSBjYW4KPiBhbHdheXMgcHJvY2VlZC4KPiAKPiBGaXhlczogMjcwM2MxNmM3NWFlICgiY3hs
L2NvcmUvcG9ydDogQWRkIHN3aXRjaCBwb3J0IGVudW1lcmF0aW9uIikKPiBMaW5rOiBodHRwOi8v
bG9yZS5rZXJuZWwub3JnL3IvMTY3NTY0NTM0ODc0Ljg0NzE0Ni41MjIyNDE5NjQ4NTUxNDM2NzUw
LnN0Z2l0QGR3aWxsaWEyLXhmaC5qZi5pbnRlbC5jb23CoFsxXQo+IFNpZ25lZC1vZmYtYnk6IERh
biBXaWxsaWFtcyA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPgo+IC0tLQo+IMKgZHJpdmVycy9j
eGwvY29yZS9tZW1kZXYuYyB8wqDCoMKgIDEgKwo+IMKgZHJpdmVycy9jeGwvY29yZS9wb3J0LmPC
oMKgIHzCoMKgIDU4ICsrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0t
LQo+IMKgZHJpdmVycy9jeGwvY3hsbWVtLmjCoMKgwqDCoMKgIHzCoMKgwqAgMiArKwo+IMKgMyBm
aWxlcyBjaGFuZ2VkLCAzNSBpbnNlcnRpb25zKCspLCAyNiBkZWxldGlvbnMoLSkKCkxvb2tzIGdv
b2QsCgpSZXZpZXdlZC1ieTogVmlzaGFsIFZlcm1hIDx2aXNoYWwubC52ZXJtYUBpbnRlbC5jb20+
Cgo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2N4bC9jb3JlL21lbWRldi5jIGIvZHJpdmVycy9j
eGwvY29yZS9tZW1kZXYuYwo+IGluZGV4IGE3NGE5MzMxMGQyNi4uM2E4YmMyYjA2MDQ3IDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvY3hsL2NvcmUvbWVtZGV2LmMKPiArKysgYi9kcml2ZXJzL2N4bC9j
b3JlL21lbWRldi5jCj4gQEAgLTI0Niw2ICsyNDYsNyBAQCBzdGF0aWMgc3RydWN0IGN4bF9tZW1k
ZXYgKmN4bF9tZW1kZXZfYWxsb2Moc3RydWN0IGN4bF9kZXZfc3RhdGUgKmN4bGRzLAo+IMKgwqDC
oMKgwqDCoMKgwqBpZiAocmMgPCAwKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
Z290byBlcnI7Cj4gwqDCoMKgwqDCoMKgwqDCoGN4bG1kLT5pZCA9IHJjOwo+ICvCoMKgwqDCoMKg
wqDCoGN4bG1kLT5kZXB0aCA9IC0xOwo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoGRldiA9ICZjeGxt
ZC0+ZGV2Owo+IMKgwqDCoMKgwqDCoMKgwqBkZXZpY2VfaW5pdGlhbGl6ZShkZXYpOwo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2N4bC9jb3JlL3BvcnQuYyBiL2RyaXZlcnMvY3hsL2NvcmUvcG9ydC5j
Cj4gaW5kZXggNDEwYzAzNmMwOWZhLi4zMTdiY2Y0ZGJkOWQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVy
cy9jeGwvY29yZS9wb3J0LmMKPiArKysgYi9kcml2ZXJzL2N4bC9jb3JlL3BvcnQuYwo+IEBAIC0x
MjA3LDYgKzEyMDcsNyBAQCBpbnQgY3hsX2VuZHBvaW50X2F1dG9yZW1vdmUoc3RydWN0IGN4bF9t
ZW1kZXYgKmN4bG1kLCBzdHJ1Y3QgY3hsX3BvcnQgKmVuZHBvaW50KQo+IMKgCj4gwqDCoMKgwqDC
oMKgwqDCoGdldF9kZXZpY2UoJmVuZHBvaW50LT5kZXYpOwo+IMKgwqDCoMKgwqDCoMKgwqBkZXZf
c2V0X2RydmRhdGEoZGV2LCBlbmRwb2ludCk7Cj4gK8KgwqDCoMKgwqDCoMKgY3hsbWQtPmRlcHRo
ID0gZW5kcG9pbnQtPmRlcHRoOwo+IMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gZGV2bV9hZGRfYWN0
aW9uX29yX3Jlc2V0KGRldiwgZGVsZXRlX2VuZHBvaW50LCBjeGxtZCk7Cj4gwqB9Cj4gwqBFWFBP
UlRfU1lNQk9MX05TX0dQTChjeGxfZW5kcG9pbnRfYXV0b3JlbW92ZSwgQ1hMKTsKPiBAQCAtMTI0
MSw1MCArMTI0Miw1NSBAQCBzdGF0aWMgdm9pZCByZWFwX2Rwb3J0cyhzdHJ1Y3QgY3hsX3BvcnQg
KnBvcnQpCj4gwqDCoMKgwqDCoMKgwqDCoH0KPiDCoH0KPiDCoAo+ICtzdHJ1Y3QgZGV0YWNoX2N0
eCB7Cj4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IGN4bF9tZW1kZXYgKmN4bG1kOwo+ICvCoMKgwqDC
oMKgwqDCoGludCBkZXB0aDsKPiArfTsKPiArCj4gK3N0YXRpYyBpbnQgcG9ydF9oYXNfbWVtZGV2
KHN0cnVjdCBkZXZpY2UgKmRldiwgY29uc3Qgdm9pZCAqZGF0YSkKPiArewo+ICvCoMKgwqDCoMKg
wqDCoGNvbnN0IHN0cnVjdCBkZXRhY2hfY3R4ICpjdHggPSBkYXRhOwo+ICvCoMKgwqDCoMKgwqDC
oHN0cnVjdCBjeGxfcG9ydCAqcG9ydDsKPiArCj4gK8KgwqDCoMKgwqDCoMKgaWYgKCFpc19jeGxf
cG9ydChkZXYpKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gMDsKPiAr
Cj4gK8KgwqDCoMKgwqDCoMKgcG9ydCA9IHRvX2N4bF9wb3J0KGRldik7Cj4gK8KgwqDCoMKgwqDC
oMKgaWYgKHBvcnQtPmRlcHRoICE9IGN0eC0+ZGVwdGgpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHJldHVybiAwOwo+ICsKPiArwqDCoMKgwqDCoMKgwqByZXR1cm4gISFjeGxfZXBf
bG9hZChwb3J0LCBjdHgtPmN4bG1kKTsKPiArfQo+ICsKPiDCoHN0YXRpYyB2b2lkIGN4bF9kZXRh
Y2hfZXAodm9pZCAqZGF0YSkKPiDCoHsKPiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IGN4bF9tZW1k
ZXYgKmN4bG1kID0gZGF0YTsKPiAtwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgZGV2aWNlICppdGVyOwo+
IMKgCj4gLcKgwqDCoMKgwqDCoMKgZm9yIChpdGVyID0gJmN4bG1kLT5kZXY7IGl0ZXI7IGl0ZXIg
PSBncmFuZHBhcmVudChpdGVyKSkgewo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBz
dHJ1Y3QgZGV2aWNlICpkcG9ydF9kZXYgPSBncmFuZHBhcmVudChpdGVyKTsKPiArwqDCoMKgwqDC
oMKgwqBmb3IgKGludCBpID0gY3hsbWQtPmRlcHRoIC0gMTsgaSA+PSAxOyBpLS0pIHsKPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBjeGxfcG9ydCAqcG9ydCwgKnBhcmVu
dF9wb3J0Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgZGV0YWNoX2N0
eCBjdHggPSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAuY3hsbWQgPSBjeGxtZCwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoC5kZXB0aCA9IGksCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH07
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBkZXZpY2UgKmRldjsKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBjeGxfZXAgKmVwOwo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYm9vbCBkaWVkID0gZmFsc2U7Cj4gwqAKPiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKCFkcG9ydF9kZXYpCj4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBicmVhazsKPiAtCj4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBvcnQgPSBmaW5kX2N4bF9wb3J0KGRwb3J0X2RldiwgTlVM
TCk7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICghcG9ydCkKPiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbnRpbnVlOwo+IC0KPiAt
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKGlzX2N4bF9yb290KHBvcnQpKSB7Cj4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwdXRfZGV2aWNl
KCZwb3J0LT5kZXYpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkZXYgPSBidXNf
ZmluZF9kZXZpY2UoJmN4bF9idXNfdHlwZSwgTlVMTCwgJmN0eCwKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHBvcnRfaGFzX21lbWRldik7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICgh
ZGV2KQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNv
bnRpbnVlOwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Cj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHBvcnQgPSB0b19jeGxfcG9ydChkZXYpOwo+IMKgCj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwYXJlbnRfcG9ydCA9IHRvX2N4bF9wb3J0KHBvcnQt
PmRldi5wYXJlbnQpOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGV2aWNlX2xv
Y2soJnBhcmVudF9wb3J0LT5kZXYpOwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBp
ZiAoIXBhcmVudF9wb3J0LT5kZXYuZHJpdmVyKSB7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAvKgo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgICogVGhlIGJvdHRvbS11cCByYWNlIHRvIGRlbGV0ZSB0aGUgcG9y
dCBsb3N0IHRvIGEKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAqIHRvcC1kb3duIHBvcnQgZGlzYWJsZSwgZ2l2ZSB1cCBoZXJlLCBiZWNhdXNlIHRoZQo+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogcGFyZW50
X3BvcnQgLT5yZW1vdmUoKSB3aWxsIGhhdmUgY2xlYW5lZCB1cCBhbGwKPiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIGRlc2NlbmRhbnRzLgo+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICovCj4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkZXZpY2VfdW5sb2NrKCZwYXJl
bnRfcG9ydC0+ZGV2KTsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHB1dF9kZXZpY2UoJnBvcnQtPmRldik7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjb250aW51ZTsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgfQo+IC0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRldmljZV9s
b2NrKCZwb3J0LT5kZXYpOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZXAgPSBj
eGxfZXBfbG9hZChwb3J0LCBjeGxtZCk7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBkZXZfZGJnKCZjeGxtZC0+ZGV2LCAiZGlzY29ubmVjdCAlcyBmcm9tICVzXG4iLAo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGVwID8gZGV2X25hbWUo
ZXAtPmVwKSA6ICIiLCBkZXZfbmFtZSgmcG9ydC0+ZGV2KSk7Cj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBjeGxfZXBfcmVtb3ZlKHBvcnQsIGVwKTsKPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGlmIChlcCAmJiAhcG9ydC0+ZGVhZCAmJiB4YV9lbXB0eSgmcG9ydC0+
ZW5kcG9pbnRzKSAmJgo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIWlz
X2N4bF9yb290KHBhcmVudF9wb3J0KSkgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgIWlzX2N4bF9yb290KHBhcmVudF9wb3J0KSAmJiBwYXJlbnRfcG9ydC0+ZGV2LmRy
aXZlcikgewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oC8qCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICog
VGhpcyB3YXMgdGhlIGxhc3QgZXAgYXR0YWNoZWQgdG8gYSBkeW5hbWljYWxseQo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIGVudW1lcmF0ZWQgcG9y
dC4gQmxvY2sgbmV3IGN4bF9hZGRfZXAoKSBhbmQgZ2FyYmFnZQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2N4bC9jeGxtZW0uaCBiL2RyaXZlcnMvY3hsL2N4bG1lbS5oCj4gaW5kZXggYWIxMzgwMDRm
NjQ0Li5jOWRhM2M2OTlhMjEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9jeGwvY3hsbWVtLmgKPiAr
KysgYi9kcml2ZXJzL2N4bC9jeGxtZW0uaAo+IEBAIC0zOCw2ICszOCw3IEBACj4gwqAgKiBAY3hs
X252YjogY29vcmRpbmF0ZSByZW1vdmFsIG9mIEBjeGxfbnZkIGlmIHByZXNlbnQKPiDCoCAqIEBj
eGxfbnZkOiBvcHRpb25hbCBicmlkZ2UgdG8gYW4gbnZkaW1tIGlmIHRoZSBkZXZpY2Ugc3VwcG9y
dHMgcG1lbQo+IMKgICogQGlkOiBpZCBudW1iZXIgb2YgdGhpcyBtZW1kZXYgaW5zdGFuY2UuCj4g
KyAqIEBkZXB0aDogZW5kcG9pbnQgcG9ydCBkZXB0aAo+IMKgICovCj4gwqBzdHJ1Y3QgY3hsX21l
bWRldiB7Cj4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBkZXZpY2UgZGV2Owo+IEBAIC00Nyw2ICs0
OCw3IEBAIHN0cnVjdCBjeGxfbWVtZGV2IHsKPiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IGN4bF9u
dmRpbW1fYnJpZGdlICpjeGxfbnZiOwo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgY3hsX252ZGlt
bSAqY3hsX252ZDsKPiDCoMKgwqDCoMKgwqDCoMKgaW50IGlkOwo+ICvCoMKgwqDCoMKgwqDCoGlu
dCBkZXB0aDsKPiDCoH07Cj4gwqAKPiDCoHN0YXRpYyBpbmxpbmUgc3RydWN0IGN4bF9tZW1kZXYg
KnRvX2N4bF9tZW1kZXYoc3RydWN0IGRldmljZSAqZGV2KQo+IAoK
