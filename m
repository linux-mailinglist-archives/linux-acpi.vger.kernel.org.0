Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1743050E7F3
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Apr 2022 20:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244284AbiDYSUa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 Apr 2022 14:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244297AbiDYSU3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Apr 2022 14:20:29 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF2C3B282;
        Mon, 25 Apr 2022 11:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650910644; x=1682446644;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PtJBiGxlrj6mpicEdDxMkhMr5bxgDUNM1zaQNz5GU64=;
  b=Zy5xbzIEh58sXiBbPZtxSlYTCdJJOn2U4Rq6gyMkezNRlaw8VdMW+eic
   8fSs3UtBFQ9vpD+QBFjYg12ZNT9Y8GRJFogwzHuBJoDRfusA417yNKfjH
   qkxxBQKqt+qPEyTVfhozkuCnmgtDWFtvRcrMmVgosR5Bhc8MNo/+3A4zG
   S7UhB3hSYUrbE6Ql3xWU36fwKNA7nSo828nqkyA3dDfsfszY2SgnZZywO
   F7kUJLtgwLOJ5uREexChPvH93lU6DpFbxlpLUBad2ie28B85ZH1/B6PoK
   QslRx3lF8HOUhzm+bpDnvsChMXbJRjfJ9SzKmPPBwcxeSfwwQXxxHVJOC
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="290467256"
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="290467256"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 11:17:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="873030899"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga005.fm.intel.com with ESMTP; 25 Apr 2022 11:17:23 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 25 Apr 2022 11:17:23 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 25 Apr 2022 11:17:23 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 25 Apr 2022 11:17:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3CekKmDwrry9mKCyohSbN0QAboZIN/ELHKJV7PaZOhlopeK9437kxhZo3Tsd97AS7NnRXdTTXINehtfwUQGe5WNrSlf+RFWhYn59WSbiurjLt8eqGzBd1I1gUYVxfvr5rXaFmbAHafEeeD6IP5FOwALRcnmaNr4f4y9DeuO/T2CyeNvptJm8gU8uu2HHt63qU9WSRCmRbnt+j4P4/VD5mQkjMIynKpPcre5kQF+VrIlANwYMdMf48kN4hjaKDiHkDHdEsKUdn47dA0FMdgTaa+IK2ro0zOHED21fH+AA+YMwnXDR3Jf4MCIdFlU+D+k8YK+ctgiQ/f8jykl3vJFjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fTk1Hv3n+ME2tGBayJxE/e48fQ+3ie5BAvLc6UQbB5M=;
 b=oZ5Qz4vzO7a2/6qHyvKEOEMgTKmZ7MM4BvFQjDHSPiqAtrlfZKK/8rGekQNj6uiYqPVHYPiVTXeKbmwLeMNywi3ieODGANKYugw10MHr191jtmOfvJxZ/hZzfnaouF2MgFtCp5x2GxSzxpP+UJoRX/0IKh1QqJhAyUEKJziLp4c9v0A6nlavoZzIldOlx8qV9pFi2eOVWPuXr6EpJXB2KyCABMSGX9o7jcPo39anym5BcKwkYbHHizgiIDmAWY1tkcq6hwbGapTEtSrVm63kipRC6heFdR7GOfLPzw/Dx6ECuiJ+DyfSjqHleV0SvmTemM4BPdy677hYjkRBk9ubEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by DM6PR11MB3211.namprd11.prod.outlook.com (2603:10b6:5:58::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.19; Mon, 25 Apr
 2022 18:17:21 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::98d8:aa81:9f56:c36a]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::98d8:aa81:9f56:c36a%9]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 18:17:20 +0000
Message-ID: <0ba818f7-6abe-4391-3fc0-788f58c5756b@intel.com>
Date:   Mon, 25 Apr 2022 20:17:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Subject: Re: [PATCH v6 0/3] PCI/ACPI: add support for CXL _OSC
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Moore, Robert" <robert.moore@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>
References: <20220425181357.GA1647966@bhelgaas>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
In-Reply-To: <20220425181357.GA1647966@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::23) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a18caefb-0415-4987-ba2e-08da26e7d693
X-MS-TrafficTypeDiagnostic: DM6PR11MB3211:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
X-Microsoft-Antispam-PRVS: <DM6PR11MB32112779EC4A88E961BE9E8BCBF89@DM6PR11MB3211.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s3kKT5zYAbgM42lciW402BS1jk6jNFhZl4i946EmHVz96uLIBvg6uVHEBm+W+iZNtItGjwqLyS6ZQ9LA3Kc9QDlPRnQ1xc7esv0LYaH7tL+reGiK5M/fNIG6s05uZkrupbupYbAiogf19MhDi9Tkt5RyG0L5Gh5V8SRTrNMtnXwvAauQu7wg9JCD4txdHbZ6TiIT/jPGljkgX6F3jXZ3Crm8v/VleZYIIzmPA80xcbr02nX9KU653I2nYERGhzpcXu4go5bOjrOLoLfwAAoY61skpW9oiVI+maRz9U7e2NKqbIlnPU00HnuaU1WoVwf8OUFmweRStv+0h3R7FPQG+Jw9cj6h+FeGu3tKGaZqbzO2hFH5e5Dj9rcUDC+qF6gxHRStCt6McLIBJaHWBylKodZ6uAviLXLN+HviU0KmeFBaOvDE1mu+P9MKn2Y7nIcq8eJnH4JTlT9QHTNuii9IvXyiD6Kev58VlSIEb3HXmZygQto2xil0nliJCGWxqqXBZaiwbkV7mrsa1MXRhOAx+49PY2W4yOE/OtPfcFmniUFvLR/bXWogQUyMlZ23INi1zScUBfHs00zH98TXi4XRWPTBAdLKItfQgkLbEikaVR0ElKgZj90BcSx7S8itDazs6fc76NMxB/PtX4iWc/G3yDZ83r42Iss1W2c61/Id6XSSWQIBmwIOgNfO0tGtoCh4mwE6YnRa/WmXTP2y86LwDaTMAMacv+Y7+tIjoc3ykFo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(82960400001)(316002)(4326008)(31696002)(2616005)(6506007)(508600001)(6486002)(86362001)(8676002)(110136005)(54906003)(66556008)(6636002)(186003)(26005)(36756003)(6512007)(2906002)(38100700002)(66946007)(53546011)(4744005)(36916002)(6666004)(31686004)(8936002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFJnRGphWFZVcUJwU1I3dnhSNjNUOU5EY1NjUENVcHd4YzBLNGhWV0hpK29W?=
 =?utf-8?B?TkIrUHJRUk9RMmIxeHdHbDYvT3NDSVRSTU1ycWxmYTU2d0VuSFVSdWdLaGd6?=
 =?utf-8?B?NkJBK08xVHIxT0NrM3Q2NGJtK0hqbTR5dXJsMytKQjR6N09MTk5namVtbFF6?=
 =?utf-8?B?VHhYY1Bwbk9oTEQxZ21IeVc1SlBCK3o1NDhlZGVHU1lidW56TnRyK21CQ1Uy?=
 =?utf-8?B?N1pVbFBOZDFDeVJOQ1pSaU84cm11MGhYNi9RZFhkSXo5NnlPQjRoeFJXTFRw?=
 =?utf-8?B?M2JqR0EvS2hickp0eXdxZkZTUFloZlROSWZnQnMwS295UGRkQ0tqUmFGQ1c1?=
 =?utf-8?B?cjdVZTYzUHZXdnlRZVVWYUxpVFUvYitGOWdSUGhMUFdSQ0cxeXlaL0ZZVDFr?=
 =?utf-8?B?Y3VSa0V2ZHB6SlM0a1NDZkZrVmlJbUFtalQ2ek9ITDN2RlBmZHFrckhnR0Jx?=
 =?utf-8?B?Z2RMdURMUW5wdkNTcjg2WWIrcDgyc1U5bS9pV29EenMwcFdSVDZKLzdMSnZv?=
 =?utf-8?B?Y0h1U216eXlML3BNVVY3ck15ZGtWZUJTREhVcU4yRXFWZjIyUkh2UFdOamM4?=
 =?utf-8?B?bjhMamc1V01lV1l5RU5Oa1JjRTdwK2tqdlpLZXZLU1dWV1lKN0hod3RMc2ph?=
 =?utf-8?B?aTRsZ0o2Yldyc2JCRFo2UkNTUXB3b3dKUGdVS0JUL3ErazVGQUU1SmM3ZUw1?=
 =?utf-8?B?VGhQM0ZvVjRMUVh1RlFGR2FKcXZCOGk4SUI2QnNkb3BjN3EwNTJnR2JEaGlK?=
 =?utf-8?B?VFUrdEQ5N0h6RnJGYU5OOGo2eHhpc3RpTGtZL0tXYm00cUJYY0tUZmViM2J1?=
 =?utf-8?B?VzZIQmUzdlFQdlFFcE1vZ3J2V3lYNXd5VFZsRlJJUWh4R3NYK0U5YllVUXlj?=
 =?utf-8?B?ZDIrblBCOGFRUm5SQVFVZ0dHbGFPMkg1ZWxQODFhVjdYblQ4ZXZCbjVOQmZh?=
 =?utf-8?B?QWh4VVFCV1JBTGI0VnlPL0VlTnhHd09DY2NmTGIrQUc1d01LZFlmenpmZE9o?=
 =?utf-8?B?QzhlSERXaXZCSUFSNGFMR0h0eFdiUmowckRxTmxhQXFKcjhTNURiZ2J3VnJF?=
 =?utf-8?B?eDVONytnQjRSdktIVm1kTWFNVTYvSXJqZXVLTjNTR284UXJZUU9GQ0ZUMHNS?=
 =?utf-8?B?R2szbk94R29ENGNMbDI2T1AyYVk1N3FKcENDUnd0NHpVdkJHZlZnNmt5T3lR?=
 =?utf-8?B?dHNzYTZ1bHgzUCtEZ0tHTU1kdWxxQTFQODB5RC9xdnlKYlpKMUw3cmVXcm1Y?=
 =?utf-8?B?ZnQ0b3N1SjEvVjQyOVM5THNidm4vQXQ2Q000TVJGZzlPQnBEdmlEdm0vc2My?=
 =?utf-8?B?eWhlajNpNkZpdnNJTHh3REpwcTNia3MxdVZPL0RWUkpNanJOQ3E2Q2RNT1BO?=
 =?utf-8?B?RldjYWNMdjg3dWlxTllNYmpxWVYzcUJ6S1dmZ0xsYXc1WGpxUXpsWGcybFdj?=
 =?utf-8?B?R3V4VWQ1L2dmOWJLVTErQWx5ajAvZFo2SzBQTW1UcEllUmk2U0JaVUJkMjBu?=
 =?utf-8?B?eDY1cmtVSFVhM3hlUDVFVjQrZW9vK0lBM05OQXMrT1AxcmlNbFN1YUFHTE9L?=
 =?utf-8?B?OW11SHhJa2JUOUYzaTFCWC9STmtnbVNBNUhyeXE4TW9HeG5MdERUclBWd1J5?=
 =?utf-8?B?QWV2TlZSQnJEVUdpWEVESEVlTHo2SEpSMlNCQ2g3a0k5YURseURiSlIyL2hH?=
 =?utf-8?B?RUNqTEljSmpDSDVPakl2ZUdmV21iZFJ0bnYzMm1kdzdZRlFBWkxQVkh1QjRp?=
 =?utf-8?B?RGE3WG5SdjhPQXpjOGFMVnBWVFRBZEw5SGZLbGJzRG9pODNxSWQ5NnEwYnNH?=
 =?utf-8?B?d0ZxWVJyMWhCK2FMNkRVZUR4d0tBRmFvVzljQXZPd1BjaTJ6bEppYzBnZEJj?=
 =?utf-8?B?OTdZQk1sak5lalQ2V2djaEZwazE2SFk4Tk9ucUljQlRscXMxOXBPOFBncUEr?=
 =?utf-8?B?V0p6ZkpZLzI4NEROZllybnowUURHdURTekwzR1JQNk12R0RaTzY1OVNvWDhG?=
 =?utf-8?B?U3ZpR1lJNnFVNlAxWThpRkJySFlSL2pZMmlZbVRoUXF2YlQ2R3IyanRESXc1?=
 =?utf-8?B?a0Q5eER0SDlpL2RoYzkzczBzL2ZhQjNZamRLeElEWW8rbTkrOGhYc2IxS1VI?=
 =?utf-8?B?VXpLWGx4MjAwOHJpRUREb3V3KytmVXdxOUlublJCR2sxb05sV09FaXAwR3hh?=
 =?utf-8?B?Y2V4RGwxUWpwdUkxL2JlNXJDaUVhZG9PRSt2eTlseU40ZFRkSUZhcXF5VTBT?=
 =?utf-8?B?dENzMlBUM1c2dE9kZzhvZDNjb1g5dWFhdFJhaXNkUmxRSzhLK1FFMUZoMnQy?=
 =?utf-8?B?LzBYZTBhaDZtbzNaRnlaZ3BrVDE3Z01YU0tlNVBZQUdaOXNDcmZHdGFJaXZ4?=
 =?utf-8?Q?jWnfaKLLOSU0T25w=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a18caefb-0415-4987-ba2e-08da26e7d693
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 18:17:20.8688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wPTVmT2kK4xcry0xOdZWeEmFIdxDHq7kx89aCb+4N6reUgGByxy3Gn0Gop/s55NUGAB2V2VcyWnYjHhklL/GsTwhCPzCjkTwtpKTllOM1tY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3211
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 4/25/2022 8:13 PM, Bjorn Helgaas wrote:
> On Fri, Apr 22, 2022 at 10:24:34PM +0000, Verma, Vishal L wrote:
>> On Wed, 2022-04-13 at 01:36 -0600, Vishal Verma wrote:
>>> Changes since v5[1]:
>>> - Collect an reviewed-by tags from Rafael, Adam, and David
>>> - Fix a couple of missed s/CXL/extended/ in acpi_bus.h (Rafael)
>> Rafael, or Bjorn,
>>
>> Dan has offered to take this through cxl.git. Any objections to that -
>> would you prefer it to go through either the PCI or ACPI trees instead?
> OK by me if Dan or Rafael takes it.

All right, so it depends on whether or not there's any pending material 
for the CXL tree that will depend on these patches.  If so, it likely is 
better to route them via CXL.


