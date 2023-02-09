Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3EE68FBF1
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Feb 2023 01:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjBIAZK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Feb 2023 19:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjBIAZJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Feb 2023 19:25:09 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFE120682;
        Wed,  8 Feb 2023 16:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675902308; x=1707438308;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=41NH2zWulduH3CgQFziSoSPr0Pj8IylF8pvjYvezlRo=;
  b=UGO/pbO40vyY6KlUbEoZ6hrIYe4Q24JSSOC7hXKgn6FtwZBBsofvOCiy
   kA7mT/XWsTTSqLIpPxkfOs052snp8/LdW9S0BR8OsPAW3Bk5HYp0DmJv8
   NbBu7K/zeBypDxi2Yj/KmXpN9f0mWOA1RVjAZMr/9gqCG6eC553ZZWw/2
   tb+WflWP8yVBLVPqqrRDKlcMGg9HsTeZsSdCzbqvBwoIkmCiAT0zyX83T
   6sVVtb+hnkkVZgwRmHsvVPwerro+A0EfDHZjjjmg8Dc0ydCslMdv8hKrY
   XoYXH4XbxsAG1VHQFIGx6QauzOUeZv/muGxD+35Xq+V4Dy/bbfGd591+s
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="329995591"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="329995591"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 16:25:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="841389992"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="841389992"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 08 Feb 2023 16:25:06 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 16:25:05 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 16:25:04 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 8 Feb 2023 16:25:04 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 8 Feb 2023 16:25:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hyRq7p8PiDRC8EiB7c5xfBw9FS0tP+oVIi3Ynk0SopvcI5yujU3XFzxAU5UZmsMWBJ6CdZiTxUHTvR1/2G+O173IkKNFhP/+nF+zaAXwdS5UIfbRixrlQz8Inlih+ypEsLz7/vPPQJEZGe5iBQ0eW4VAQq90Vmi6P64IeNtLeQ9+sghS4o0zqbLCLkev3KAC7GQ4H4l2wyvz5yQpv2WKBKKXpS20xrfb15I3jYyzaaPgPvweBUq87WjAHTa+QndCVyPyD5gIo5XQPSgkpF9sBJqDS/nfpJMHoJX4Y2SU7ES4H74C/5lOpVpdR4/JK2AtRbVriQuorYTWr8y/+BX6Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41NH2zWulduH3CgQFziSoSPr0Pj8IylF8pvjYvezlRo=;
 b=nJVLMuO4b/KtQ9AMhhFEbDB8qqj7fngokXiD6kCD7/Ks7XnvaW/pNaJk48fw/R+Y9QR5nbbzN9DO00Ufh7rFOaE1fJAsDRhTAdzr8Yf49PA21Pz7fEEmQ8yvPv+qhHG39kIZTUPGGSXF3Boq8jQI4tXU4OjpDUCisp/YeYkuNdp/b9jW76oVzV96SRqftRh75jxgT085MUSA//ECkF3OE9kGVLsnsp75CQJbDaGMy+8n/ARaNnf6AgRWvRSNF+oPG11tQ3QnXq9y/eTQnorS5l8XsNOCDsSNkZ+GE/8ZoWxuzSiuLU4U5WMIBmSkVxtNT7PSQzK3+koojPWLCtoYeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by DS0PR11MB7879.namprd11.prod.outlook.com (2603:10b6:8:f7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.35; Thu, 9 Feb
 2023 00:24:57 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::35af:d7a8:8484:627]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::35af:d7a8:8484:627%5]) with mapi id 15.20.6086.017; Thu, 9 Feb 2023
 00:24:57 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 03/18] cxl/region: Support empty uuids for non-pmem
 regions
Thread-Topic: [PATCH 03/18] cxl/region: Support empty uuids for non-pmem
 regions
Thread-Index: AQHZOcbAC1EH86mknUuaTSO9SbkENK7Fxk6A
Date:   Thu, 9 Feb 2023 00:24:57 +0000
Message-ID: <1fe3c33ee00173cd7573b41bdd8c56a088078a94.camel@intel.com>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
         <167564536587.847146.12703125206459604597.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <167564536587.847146.12703125206459604597.stgit@dwillia2-xfh.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.3 (3.46.3-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB3999:EE_|DS0PR11MB7879:EE_
x-ms-office365-filtering-correlation-id: 728f1b7c-df7d-4254-a095-08db0a3412d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eCR9ndLbasDeXW906k2I0lhJ8QtBXr9G2GvXwyf9scRlQMeXBq1SxwtfCrdAaz83ksnmzJQM3eHI9C8J+s7Ge3kvq/KnMkWj2Oy+cpRKBzztFfSbMVtCFj3DNKtaapbfP7k1a1OBUBtONvUd9eI0SsH/407NcXPoedKjQZ/s88exjtdSKsTa3wMhUijZH3XXgoM7Tj6+dBbcnTvyMf4XoXdueVNpEhiPnkV58rgvIcwTkOkej68NUXY+8evXUpp8gL3+/lss3hMszZFB8aHHKga8rOujZn5Akq5XxD2v4hOPJ8vxD81a71bKUznXit0mF/Wfb5pl71dE8HTENK4BgLKgp0sOSzwJZRr0vi5cI3MWcBZDV2EH/Udw57wOrbsF/7lo10cHP3yLBcdq4iW2ICjbV8hsOT/t0OzEEk3yB+7vLKZc9KgpsfLdv5VCaEjtbKXk2fnOhx/byaWrc/INIO+7M6aoNP73iq1NGxoi3yEvi2Toy+jsjXhySyhwBHc6A19OwhPZuqfA3cWCvUfmHVYsKum0pWTt7Am8YsqkmdNG8KGvj+/payEN9gWOzAJILNwFzYzdpWl96OwaRhI56/0T/vzWVsSpzQRHPZzrDEws8VgHlTOab1nY2+ZHeg7Xn8ilDLxs2cnrMBfsUcoYGYNgUoe0RQlYZLZuviJTcgNqQVgMlzCZp+kK1Nro9lSC5qhPurUuE7NN88cInczp6A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(376002)(366004)(396003)(346002)(136003)(451199018)(66946007)(66476007)(64756008)(66446008)(4326008)(76116006)(66556008)(8676002)(41300700001)(6506007)(91956017)(8936002)(26005)(186003)(71200400001)(478600001)(6486002)(6512007)(316002)(86362001)(54906003)(110136005)(83380400001)(2906002)(5660300002)(2616005)(36756003)(38070700005)(82960400001)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bXJQRUFReWJxbUdZOFBRR3h5MVFzTHM3RW5DbVMzTHF2MHFUOEJoQU02VXB3?=
 =?utf-8?B?RXpoZXVyZWExcm95MVFuMlpkaXBKTjhhVDZLWHhnSFNYcFZXWUtBcS9DMkJQ?=
 =?utf-8?B?Y0Q5ek9HT0Mzbm9aQ2V6blNUZEkvV3k1QlNQL0pqUEJ4UmhLUXI4NnZNL0sy?=
 =?utf-8?B?K2d4SzZZK0hsaERUU3l0aFJTTDFKVWhtbTVsTERoNkFRSGNQZS9RWWxYb1Rj?=
 =?utf-8?B?dWhSeWNPL1ZSbXFPc0ZId04vWnVCdGU4cm9zWjhSS3QxYlJ2RWVoak9WdjQ5?=
 =?utf-8?B?Z2w1S1JCaFk3bkRmdjZFa2lZbDlTTXlreWQxZWpsaHorbCsvZzloOXh4N0FC?=
 =?utf-8?B?Vm1kV1BYa0h6WGRKejI3bWk5NlV2T2lFeUxEQk9DNjBHOGthNXBnOGJjZkYw?=
 =?utf-8?B?K09Gci9QWjJFMU1FWmt5Y1g4ODd0MDNhbGVackRDR2xPU0VNWkxhdlBXdVJV?=
 =?utf-8?B?d3R5ZzU4R25uSHZOaEU2emFHNjljSFczK1Ixb2Rwak9HWmozMGpVNngxZnpq?=
 =?utf-8?B?S05nOVJZN0lKZFRRR2E3UTdUMU9xYUQ0aHYvaUwrWUdRSGV1MlVBRUNYYU5S?=
 =?utf-8?B?cmlnY29iQUlSaDZ6dWNSS21JZFVzcmsyZXg5T2RPd2hWRGZxcDJDQ2Q0WFEr?=
 =?utf-8?B?Q1Z4Y3NudktyNlR1ZXJURDMyYU1jZ0F2MkYvMWZwdkZMU2dQWWpsRXVZTUZp?=
 =?utf-8?B?L0E3RUEzNmpOeW9wSHUyM2RobkgrQ3diUWcvNTBKTFU4UHNzMGJPWUozcUUw?=
 =?utf-8?B?N0pkWHVZVldNOVJWN3VkbHFTamYxcXBic0JUekZKcDFLMGhVZDJHVXlLYWxW?=
 =?utf-8?B?UjZTMEViSU4zUEIwT1Q4MDkya3IzOUx5c0NVaE5vMklZaTJDdUhkTitVL1JD?=
 =?utf-8?B?RnBubUVTZmp3RDlkbXZwbEU3TW9GZFgzUnZ4cXZmWFNTdEhTTkhmRzBvWFJs?=
 =?utf-8?B?NHQyaWo2YXhXcis4V25XODQ1cm51dE9xQmUzOVBHWDlIenBlOUd3QjhYWlh5?=
 =?utf-8?B?Rjg0NzFXR1NycUo3MC9od2xmT05waFhyZ3lLcm1ZeDF6T2RoOENjQTBOMXBV?=
 =?utf-8?B?UUFVYlQ4MG4zVlY5akpGM21WbWhiSjE3U3BCVS9uS1Yrc0ZqL1ZWcS9yUVRK?=
 =?utf-8?B?MHFyL1BHbjJJeUFNQzFGdW5Sc3FxV0s1cWZrSUtBK2RGSkx1TysxbzhPaDZD?=
 =?utf-8?B?UTRGdTIzMUUySWcwWE5ocUx2NEJDVkVNT2czaER3MUIySmN5dWFxa0FWc1No?=
 =?utf-8?B?cFJacUZVbUVMdWRHNzJGK0I1cDdqUXhVdEZ4MG1Td003N0dwNkZUbFNsNFd2?=
 =?utf-8?B?ZWtrNDFJNWRucCtZSXF5MDhmdnJPYnpRb2RJQ2JkdFdkckJhQ0Z6VkxuNTNV?=
 =?utf-8?B?cTRyU2M3U3ZZUlpENks1VGs0Qkx5by81SlRyVjRXSG14YkNKOFI3ZW1FSWx6?=
 =?utf-8?B?enZhTGJMYUpsNzlvRUpudXluNUVwQnJwMXFRMldHSUpuQ0MvbldNWEhtV1E1?=
 =?utf-8?B?Q0FOekZ0RWx6RzU4WXFoNDhkbmZTalZEcndGWWFHVldzOVlYRHZ0Z0JycUZn?=
 =?utf-8?B?ZFBxRjk1ZFF4TTNjMGdYcVdVM2xGNmw5dWpaNFZYNjB0WHBpazlSektGb3R5?=
 =?utf-8?B?SUQzeCtHZ1pNYm44TzA5Zy9obk4zTFlDWHlnZ0lkNEhhMVFqYkc5N0Y3dWN1?=
 =?utf-8?B?dXN4Q3RnVGx6VnFCdXJQVWdXK1BqV2NYN2tyVnpNSVhTVDBleW9GVkwyU0di?=
 =?utf-8?B?aWhPMTJmTWk1bm5WM3cwem1USHBuM0o0eXZLTXN6eWllQlZpTkJYRWxMOWVT?=
 =?utf-8?B?VkxhN2d6N2lWLys5M0ZQUE0zYXV2TU9iSTZNSlJOZjA5bmFDSkEwNE9TVCsy?=
 =?utf-8?B?ZjU2WURQbEUyZVV4V20yZUlHOXVQbVRXVC8xRWpoUnlXTDExL1dzU3V2emFq?=
 =?utf-8?B?OW9VVktHL09rNk9qeEdwVWZUTTZDZE0zRVp5eFlnU09hemxIVktwSVl3clBE?=
 =?utf-8?B?dGt2VnQ0Qk1EQ2Y5VWk3RUpRWFZIZEkzVjNxTjZtMWNDamdHWkFNdE1yL3U0?=
 =?utf-8?B?YjFOTWtEVit6eXR0RTdpR2J1ODJNYThBdzRmMDRodWlIcHVYUnJKamkxK09l?=
 =?utf-8?B?eVFnQlROMFE2bzNYbUErN21RaXpwUC9mQ0phNFFEVjJhNGpJNWplS25lSGZU?=
 =?utf-8?B?SUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6EED6450F89DD842BDDA74DEFE0B6718@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 728f1b7c-df7d-4254-a095-08db0a3412d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2023 00:24:57.3337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QQhTAWZoZUgAOvjpq1yTf/k/otmD3GK0US+jdYPDeXspo20uLahPwseKo/tr5gdrM226hxRyzPHKgj2iOjAONn572jX4EGPvbAnusjLSenQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7879
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

T24gU3VuLCAyMDIzLTAyLTA1IGF0IDE3OjAyIC0wODAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6Cj4g
U2hpcHBpbmcgdmVyc2lvbnMgb2YgdGhlIGN4bC1jbGkgdXRpbGl0eSBleHBlY3QgYWxsIHJlZ2lv
bnMgdG8gaGF2ZSBhCj4gJ3V1aWQnIGF0dHJpYnV0ZS4gSW4gcHJlcGFyYXRpb24gZm9yICdyYW0n
IHJlZ2lvbnMsIHVwZGF0ZSB0aGUgJ3V1aWQnCj4gYXR0cmlidXRlIHRvIHJldHVybiBhbiBlbXB0
eSBzdHJpbmcgd2hpY2ggc2F0aXNmaWVzIHRoZSBjdXJyZW50Cj4gZXhwZWN0YXRpb25zIG9mICdj
eGwgbGlzdCAtUicuIE90aGVyd2lzZSwgJ2N4bCBsaXN0IC1SJyBmYWlscyBpbiB0aGUKPiBwcmVz
ZW5jZSBvZiByZWdpb25zIHdpdGggdGhlICd1dWlkJyBhdHRyaWJ1dGUgbWlzc2luZy4gRm9yY2Ug
dGhlCj4gYXR0cmlidXRlIHRvIGJlIHJlYWQtb25seSBhcyB0aGVyZSBpcyBubyBmYWNpbGl0eSBv
ciBleHBlY3RhdGlvbiBmb3IgYQo+ICdyYW0nIHJlZ2lvbiB0byByZWNhbGwgaXRzIHV1aWQgZnJv
bSBvbmUgYm9vdCB0byB0aGUgbmV4dC4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBEYW4gV2lsbGlhbXMg
PGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4KPiAtLS0KPiDCoERvY3VtZW50YXRpb24vQUJJL3Rl
c3Rpbmcvc3lzZnMtYnVzLWN4bCB8wqDCoMKgIDMgKystCj4gwqBkcml2ZXJzL2N4bC9jb3JlL3Jl
Z2lvbi5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoMKgIDcgKysrKystLQo+IMKg
MiBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpMb29rcyBn
b29kLAoKUmV2aWV3ZWQtYnk6IFZpc2hhbCBWZXJtYSA8dmlzaGFsLmwudmVybWFAaW50ZWwuY29t
PgoKPiAKPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9BQkkvdGVzdGluZy9zeXNmcy1idXMt
Y3hsIGIvRG9jdW1lbnRhdGlvbi9BQkkvdGVzdGluZy9zeXNmcy1idXMtY3hsCj4gaW5kZXggMDU4
YjBjNDUwMDFmLi40YzRlMWNiYjExNjkgMTAwNjQ0Cj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9BQkkv
dGVzdGluZy9zeXNmcy1idXMtY3hsCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9BQkkvdGVzdGluZy9z
eXNmcy1idXMtY3hsCj4gQEAgLTMxNyw3ICszMTcsOCBAQCBDb250YWN0OsKgwqDCoMKgbGludXgt
Y3hsQHZnZXIua2VybmVsLm9yZwo+IMKgRGVzY3JpcHRpb246Cj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAoUlcpIFdyaXRlIGEgdW5pcXVlIGlkZW50aWZpZXIgZm9yIHRoZSByZWdp
b24uIFRoaXMgZmllbGQgbXVzdAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYmUg
c2V0IGZvciBwZXJzaXN0ZW50IHJlZ2lvbnMgYW5kIGl0IG11c3Qgbm90IGNvbmZsaWN0IHdpdGgg
dGhlCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoFVVSUQgb2YgYW5vdGhlciByZWdp
b24uCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoFVVSUQgb2YgYW5vdGhlciByZWdp
b24uIEZvciB2b2xhdGlsZSByYW0gcmVnaW9ucyB0aGlzCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGF0dHJpYnV0ZSBpcyBhIHJlYWQtb25seSBlbXB0eSBzdHJpbmcuCj4gwqAKPiDC
oAo+IMKgV2hhdDrCoMKgwqDCoMKgwqDCoMKgwqDCoC9zeXMvYnVzL2N4bC9kZXZpY2VzL3JlZ2lv
blovaW50ZXJsZWF2ZV9ncmFudWxhcml0eQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2N4bC9jb3Jl
L3JlZ2lvbi5jIGIvZHJpdmVycy9jeGwvY29yZS9yZWdpb24uYwo+IGluZGV4IDE3ZDJkMGMxMjcy
NS4uYzllN2YwNWNhYTBmIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvY3hsL2NvcmUvcmVnaW9uLmMK
PiArKysgYi9kcml2ZXJzL2N4bC9jb3JlL3JlZ2lvbi5jCj4gQEAgLTQ1LDcgKzQ1LDEwIEBAIHN0
YXRpYyBzc2l6ZV90IHV1aWRfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZpY2Vf
YXR0cmlidXRlICphdHRyLAo+IMKgwqDCoMKgwqDCoMKgwqByYyA9IGRvd25fcmVhZF9pbnRlcnJ1
cHRpYmxlKCZjeGxfcmVnaW9uX3J3c2VtKTsKPiDCoMKgwqDCoMKgwqDCoMKgaWYgKHJjKQo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHJjOwo+IC3CoMKgwqDCoMKgwqDC
oHJjID0gc3lzZnNfZW1pdChidWYsICIlcFViXG4iLCAmcC0+dXVpZCk7Cj4gK8KgwqDCoMKgwqDC
oMKgaWYgKGN4bHItPm1vZGUgIT0gQ1hMX0RFQ09ERVJfUE1FTSkKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgcmMgPSBzeXNmc19lbWl0KGJ1ZiwgIlxuIik7Cj4gK8KgwqDCoMKgwqDC
oMKgZWxzZQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByYyA9IHN5c2ZzX2VtaXQo
YnVmLCAiJXBVYlxuIiwgJnAtPnV1aWQpOwo+IMKgwqDCoMKgwqDCoMKgwqB1cF9yZWFkKCZjeGxf
cmVnaW9uX3J3c2VtKTsKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gcmM7Cj4gQEAgLTMw
MSw3ICszMDQsNyBAQCBzdGF0aWMgdW1vZGVfdCBjeGxfcmVnaW9uX3Zpc2libGUoc3RydWN0IGtv
YmplY3QgKmtvYmosIHN0cnVjdCBhdHRyaWJ1dGUgKmEsCj4gwqDCoMKgwqDCoMKgwqDCoHN0cnVj
dCBjeGxfcmVnaW9uICpjeGxyID0gdG9fY3hsX3JlZ2lvbihkZXYpOwo+IMKgCj4gwqDCoMKgwqDC
oMKgwqDCoGlmIChhID09ICZkZXZfYXR0cl91dWlkLmF0dHIgJiYgY3hsci0+bW9kZSAhPSBDWExf
REVDT0RFUl9QTUVNKQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gMDsK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIDA0NDQ7Cj4gwqDCoMKgwqDC
oMKgwqDCoHJldHVybiBhLT5tb2RlOwo+IMKgfQo+IMKgCj4gCj4gCgo=
