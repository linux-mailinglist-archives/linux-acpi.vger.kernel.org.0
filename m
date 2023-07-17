Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A89755E6A
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jul 2023 10:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjGQI3b (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 17 Jul 2023 04:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjGQI3a (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Jul 2023 04:29:30 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665C8136
        for <linux-acpi@vger.kernel.org>; Mon, 17 Jul 2023 01:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689582569; x=1721118569;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zzoVkclstpi+TpNepE3N3UZGQiXfHsP/OAKXtNMYSkg=;
  b=I3aTQK7mPIlFGVVsBBGDEYyeR9vTQ9nJTWZBBIe/sKvRQch5XJmy+xM9
   AcDiSgI4nResEsvIG1dSmkkVdsKa5RnrUPmYmjiN8UauLdW3ysiqCws0E
   Lrcqx37EXzqXTCgd6+gg4k6IV1SqZ5qiWNaSfOgLnN2xKO1/jd6ijUavt
   ll+1BlSnnUd9XFQoF4pbJwiZBBr+qW5oVXx1P6KacuXqTjVnVKRZaXpZo
   UqJsat1ppQVKMZAf8zNnlylMbyS+AIiTpLev2rxX25cadFRpv42KIJEfT
   DnEgbx10Ouow8cfY2fRqg6e92epka3kR21Z3SmAGSM1wWWxYIpyr3gGU8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="369427856"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="369427856"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 01:29:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="752814927"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="752814927"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 17 Jul 2023 01:29:28 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 01:29:27 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 01:29:27 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 17 Jul 2023 01:29:27 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 17 Jul 2023 01:29:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Le1hPrm3dv6VRy6IGQPywLv1uzpOfFS54c8ArzRk+8ta1d2NlkarmWGFsixjhrAfL+taUT1jTKY4FxgwUF+AtySq0FhF3WxMqkRvgkBeX1CE2rrhVVp/P4aYHh8N5K13WtW1hC6nYeQAoERbmk+/RDbA4Dkns1hMGYpAGTDcz4corb9LGD/EjZukUCZd3rMW5dSAu4GoPo84L29l8WlxXSDBoDblwW5SbGDpGVDDwl+6VpMCT7/JRDhgV6d6Q+rosqilACA9kG3YJxufr9gxmDBJzU4+wX+y7a5jqN+0NRHtwvjl9mBjzq/sp5uUvOCw5wX0/wIFDbPItAChy8oLPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3tYY5zp69MZmRAdbwaE3HXjl01rBs70qzsFnQZb4AI=;
 b=mernnOxZkWVuzsCwR3mppOfFJZcxlhD03pW9RqvFqSaZ2Z4z8F0m911FWsVr2MwZtHn0q2kurnAAQmlSqFD9mbaiMt5jccXvVmSe3nmjdZUunZ66j4frya2h8BeEgD5nwmoX3LP+Q+P/GXjNvFnQed02iN2alC/h+qisgBx69+sHR1RZ+xx0K3rKzdgubGYSHMpuKUTlZHZKWR3TWsRE41cjv58Fw6+FZIm7NiDWPFsQDnFyZ1uedWExkyg/835xjfpN+A778JS+8QNmEXNm0pv4IyNZp0j2sgZiH9Dh4H5WdS8A4Ukcbsj/O6k6OepxzaBglCTpwtcwPNG97RS0wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 SA2PR11MB5146.namprd11.prod.outlook.com (2603:10b6:806:116::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Mon, 17 Jul
 2023 08:29:24 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::3a96:9177:fd4f:c649]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::3a96:9177:fd4f:c649%6]) with mapi id 15.20.6588.028; Mon, 17 Jul 2023
 08:29:24 +0000
Message-ID: <3544e8dd-874e-4b26-cb37-04aad2a8332a@intel.com>
Date:   Mon, 17 Jul 2023 10:29:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/4] ACPI: NHLT: Add query functions
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     <rafael@kernel.org>, <linux-acpi@vger.kernel.org>,
        <robert.moore@intel.com>, <pierre-louis.bossart@linux.intel.com>,
        <amadeuszx.slawinski@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
References: <20230712091048.2545319-1-cezary.rojewski@intel.com>
 <20230712091048.2545319-5-cezary.rojewski@intel.com>
 <ZK7LadhJSBjJUNqs@smile.fi.intel.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <ZK7LadhJSBjJUNqs@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0061.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:26::6) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6375:EE_|SA2PR11MB5146:EE_
X-MS-Office365-Filtering-Correlation-Id: f7eb1969-493b-4a48-eafe-08db869fed0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IeGGwbYvvv1ucEF2opSFe75Wx2P6S6UVLAr/CULNG8A8O1eLcbtP6oXj5Pz6WDaIoK/b1G3FQhsWvWr9vlZHLFj7GK2FxFgm+ZLUHWu/dXtKbYi5lmnXScL2WooyI88hEA4BlZbzOBrODXida2CdjzHwUmAAEqvYQzYWGxMnq8W4u61xeIm+vYhEleTNUm/bLF9x5/7czZ7Q4QtTmpMiX665xdR5Yfn+Mfj4BKqxqFt23eqmlxXQ0B8jy9+LQT6Ve+dl50wvAvhMbAWpihciRpl7LAyKgDe2wAGS4apLqsOQ0ENZdFXrFHxU+7w/KoQowrsdbkzMTqzQvsiLP8QFE3h7CubAH8KQeYykJMJm82xKqwpTEnnoRkw3a7FRBhMBrRFzAB4pOz/cFvP3PLFVi1V0AgAvrGdOnBPFPyVCp09EJ9swVs+6YkFXb+c0SEorvQn4Y68/JDZtjgmZbOg6kKSB34qO1OX7IjMvEZXNJhobWVU48ar+sseM7H19coA4HNAczcTid9j99h4bvWybVKWOJnV62ZkJ3JlDTwC5PeiWK/oQIcWuBp+bof4WllVjfW8KsX4k6rp168SaHQw6uur+/rRNwYvkIw8njg/njTT939li1mdSfQHNxkr7BaD4wntNuFGIJoOgCbK58BuN1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(346002)(396003)(39860400002)(366004)(451199021)(316002)(66556008)(6916009)(66946007)(66476007)(4326008)(6666004)(5660300002)(6512007)(6486002)(186003)(6506007)(26005)(41300700001)(53546011)(44832011)(31686004)(478600001)(8936002)(8676002)(2616005)(2906002)(83380400001)(38100700002)(82960400001)(86362001)(31696002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmxaeGp2QzFEb1ZBRWRnY2xpcEgydzdmUUI4UGxkK2FLbkxxSU54bFJaWkJa?=
 =?utf-8?B?WmRhUm1hZnZVR3cza2ltK2pSSENaWGZhdEdsN0ZqT2lxU2paUFU0SmFOOHRM?=
 =?utf-8?B?eGRvNnN4dHBDKzZ6dDZWMVNYTTQ0b3VZOUNDbkx3Y3dHSmwrMnMvY3A2UWFF?=
 =?utf-8?B?TUwyOGp0SHh1eXBXNlVpdFdraDA5TGNueS9OekNNZ2tjdUdJVzNVV2ZZa21H?=
 =?utf-8?B?dzFKcktEcFlPUWZnV1VMdG1TRmhjU0xCenNLOGtKZ01vd3NHQ2RBNGhldmUv?=
 =?utf-8?B?TWMrMVBEL1gybFZrNERNNGZvNVA2SlArUGdpNFJWRC8yNDYxbmQwZHhrb0Ny?=
 =?utf-8?B?dVB2anhnRnhkRXhjejEvMm5HWkFNTDJoTjZ5RXFLbzBGZS9hZitqN2RZUldE?=
 =?utf-8?B?bzRDYVJtbXR3Z0hENTdyWUJETkxxakFMa3N3d1FYWTkvZUttdTNsbDNaWmJV?=
 =?utf-8?B?bjNYb2pjNlkyZFZJWWVyR3VjRzEyR2tEeG5YMTRtUzdJS2ovdDBaRldoOFpX?=
 =?utf-8?B?OGdpeWFMRHRBQjUxakRyMlhXYnJGWXBMTGVnMG9JcnU3K3duUCsraDdJeEFp?=
 =?utf-8?B?U1hKdCtWV0tTbDlSK2N4WG52WGVWRE1RTUhvUjNvOEV3aHByRmU0M1NXbTA1?=
 =?utf-8?B?SHU5Njg3dHJPN3hrWGxuNmV6dFVhQVdYTTlZL3plL2FJeUdQd1FZb3AzRXo2?=
 =?utf-8?B?b3MydFFEQXpDb1FNeWdEa3VadzRyZ2FHTUFjQmgxRWtIdm84SlhBbjViQTl5?=
 =?utf-8?B?Y1lwUkRBejJtdWIvYW16d1FJdlhQUHRZUW9LdktUN1NmU0VBcFRUVGZreEdz?=
 =?utf-8?B?N3pmNnVDSHZtdGd2QjBBVXJTdW52S2VqZDZpQkxqa0hxZ25rU2NkYlFUN1Bn?=
 =?utf-8?B?Y05US3FvcFhDay9NTnE0ZUNmRFdCSnB0QTZXczQ1RHVMQjRGNmpDN2ZrYjNy?=
 =?utf-8?B?L3NSa25jalh4WTdHcytXNDR3RFZMMHAzWFpJZ3dEbkdyMlRvSjhQTWxhNVll?=
 =?utf-8?B?VFh2RUJQdjAyTllQVURsYTc5V2FqdkxFbEh1NExid2pEY1lXVGh2cy9UZUhj?=
 =?utf-8?B?Ymx1eDMzNkloN2FpRkFRa2hKRUJqUFRCaS9FcW50NDJtSFRiWWQrSjBSZXZE?=
 =?utf-8?B?bnFxb2JRU1dQSUlHMHFDSnFuTG9sUE96QThnSUN4S1ZkUVdtQjRMY25zUDQ2?=
 =?utf-8?B?WFNlUUY5M2kyQXJ5VUdTNTJTcnJNU1FOWFprc05TL1RaTitTOGpwa3ZBZ2RW?=
 =?utf-8?B?Wk9UMS9pOHFnQjlYeThlanI3OGlKalBqeDRXbGk2UXk1WndPYkxKRnVJd0JL?=
 =?utf-8?B?bE9NWmtmQUQ0MWkzaGgxV29WRTI4cE5XVlkvbkZSRW13dm5MTExMeGZXRXVS?=
 =?utf-8?B?M3dmcVduRmtNbTh1ellLZWQzSFc1dGJrN1JKOUdNM1NtYkY5WmFqbGZTR3Q4?=
 =?utf-8?B?amF6LzgwckJ0NHBXUTlqSy9Uc0dFYnFIQk1rVGJxZGx6akhlVVZ2dHNobzFY?=
 =?utf-8?B?S3RmVElVTUttT3NRRGVQT0s0cXlQNk5qZHlobWZMR3d2NVJINlVkN2g5SlRB?=
 =?utf-8?B?QTRlcTdvbW0zMGpTRVp0NHBqN1JoZkZPcTZRM2RLM0QyM29uTVV0T1JyS0Jq?=
 =?utf-8?B?c2V6clJhdXlTcVpHT21sL2w2aVNEalJWSk9BMzZua0dTQjhxZkMzbU1Nd2NO?=
 =?utf-8?B?dmt2Z3p4QnVjVUFSVkZhWkxEMVZaQ2YyOUlxVklXYkRrNHF4Y1hnM3RDWmRh?=
 =?utf-8?B?UzREbWthKzNSWTlRNGtnMjRqdE00NWZsYVJpaWxHYnFEMDRXZm11NEJFaUli?=
 =?utf-8?B?WStWN2JVRVBoVUZWUjcwK2M0d2xlUlhUUVhSbXJRSUxUUS9oeDk2OGtFZ0tJ?=
 =?utf-8?B?cFdkZjNJcVhOU0hyM3g2azBzazluN2tiZjBlUlNSVzVISkhZMVJCQWsxaDVG?=
 =?utf-8?B?SVRPb0NUSWZsZTN1QjBwZ0pxaVFVVWJKTlZ0UUJuNUwxdkRGT3NuVklNS1Jq?=
 =?utf-8?B?M0oweC9NeVdsVTRjVzk0VW1ScjVFT0UvMVQ0ZXBMdHV1V2p4V0luTDZYUDJh?=
 =?utf-8?B?NnphTFpXK1NSZVpBMk9CM2VzSExOazM5V1hCbWc5enVaTlMyOS82cERjRFE1?=
 =?utf-8?B?bThmR1RIYlNVZHhiTTA2MFN0R2JOK0xHZHY0Q1NVYktYdXBwcVFJd1Q3UTBG?=
 =?utf-8?B?TXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f7eb1969-493b-4a48-eafe-08db869fed0d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 08:29:24.0752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tiM1D1IQsQhAm3R7YaCZpH3u20sUUr9GFwGYG7Rfhfs3KHVOpOquVoJ3ZIo8zJ5ttq3BxVfp8XrItEMzpYo4paF8bzA//EnTtFdmeyYLA7I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5146
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2023-07-12 5:48 PM, Andy Shevchenko wrote:
> On Wed, Jul 12, 2023 at 11:10:48AM +0200, Cezary Rojewski wrote:

...

>> +bool acpi_nhlt_endpoint_match(const struct acpi_nhlt_endpoint *ep,
>> +			      int link_type, int dev_type, int dir, int bus_id)
>> +{
>> +	return ep &&
>> +	       (link_type < 0 || ep->link_type == link_type) &&
>> +	       (dev_type < 0 || ep->device_type == dev_type) &&
>> +	       (dir < 0 || ep->direction == dir) &&
>> +	       (bus_id < 0 || ep->virtual_bus_id == bus_id);
> 
> I think you can split these for better reading.
> 
> 	if (!ep)
> 		return false;
> 
> 	if (link_type >= 0 && ep->link_type != link_type)
> 		return false;
> 
> 	if (dev_type >= 0 && ep->device_type != dev_type)
> 		return false;
> 
> 	if (dir >= 0 && ep->direction != dir)
> 		return false;
> 
> 	if (bus_id >= 0 && ep->virtual_bus_id != bus_id)
> 		return false;
> 
> 	return true;
> 
> Yes, much more lines, but readability is better in my opinion.
> I also believe that code generation on x86_64 will be the same.

While I favor readability over less lines of code, I do not think 
splitting the conditions makes it easier in this case. Perhaps 
reverse-christmas-tree? Pivoted around '<'.

	return ep &&
	       (link_type < 0 || ep->link_type == link_type) &&
	       (dev_type < 0 || ep->device_type == dev_type) &&
	       (bus_id < 0 || ep->virtual_bus_id == bus_id) &&
	       (dir < 0 || ep->direction == dir);

In general I'd like to distinguish between conditions that one _has to_ 
read and understand and those which reader _may_ pass by. Here, we are 
checking description of an endpoint for equality. Nothing more, nothing 
less.

>> +}

...

>> +struct acpi_nhlt_endpoint *
>> +acpi_nhlt_find_endpoint(const struct acpi_table_nhlt *tb,
>> +			int link_type, int dev_type, int dir, int bus_id)
>> +{
>> +	struct acpi_nhlt_endpoint *ep;
> 
>> +	if (!tb)
>> +		return ERR_PTR(-EINVAL);
> 
> Just wondering how often we will have a caller that supplies NULL for tb.

Depends on kernel's philosophy on public API. In general, public API 
should defend themselves from harmful and illegal callers. However, in 
low level areas 'illegal' is sometimes mistaken with illogical. In such 
cases double safety can be dropped.

Or, perhaps you were discussing return value here and ERR_PTR(-EINVAL) 
could be replaced by something else or even NULL.

>> +	for_each_nhlt_endpoint(tb, ep)
>> +		if (acpi_nhlt_endpoint_match(ep, link_type, dev_type, dir, bus_id))
>> +			return ep;
>> +	return NULL;
>> +}
> 
> ...
> 
>> +struct acpi_nhlt_format_config *
>> +acpi_nhlt_endpoint_find_fmtcfg(const struct acpi_nhlt_endpoint *ep,
>> +			       u16 ch, u32 rate, u16 vbps, u16 bps)
>> +{
>> +	struct acpi_nhlt_wave_extensible *wav;
>> +	struct acpi_nhlt_format_config *fmt;
> 
>> +	if (!ep)
>> +		return ERR_PTR(-EINVAL);
> 
> Similar Q as above.
> 
>> +	for_each_nhlt_endpoint_fmtcfg(ep, fmt) {
>> +		wav = &fmt->format;
>> +
>> +		if (wav->channel_count == ch &&
>> +		    wav->valid_bits_per_sample == vbps &&
>> +		    wav->bits_per_sample == bps &&
>> +		    wav->samples_per_sec == rate)
> 
> Also can be split, but this one readable in the original form.

As order does not really matter here, perhaps reverse-christmas-tree to 
improve readability?

		if (wav->valid_bits_per_sample == vpbs &&
		    wav->samples_per_sec == rate &&
		    wav->bits_per_sample == bps &&
		    wav->channel_count == ch)

>> +			return fmt;
>> +	}
>> +
>> +	return NULL;
>> +}

...

>> +struct acpi_nhlt_format_config *
>> +acpi_nhlt_find_fmtcfg(const struct acpi_table_nhlt *tb,
>> +		      int link_type, int dev_type, int dir, int bus_id,
>> +		      u16 ch, u32 rate, u16 vbps, u16 bps)
>> +{
>> +	struct acpi_nhlt_format_config *fmt;
>> +	struct acpi_nhlt_endpoint *ep;
> 
>> +	if (!tb)
>> +		return ERR_PTR(-EINVAL);
> 
> Same as above.
> Looking at them, wouldn't simply returning NULL suffice?
> 
>> +	for_each_nhlt_endpoint(tb, ep) {
>> +		if (!acpi_nhlt_endpoint_match(ep, link_type, dev_type, dir, bus_id))
>> +			continue;
>> +
>> +		fmt = acpi_nhlt_endpoint_find_fmtcfg(ep, ch, rate, vbps, bps);
>> +		if (fmt)
>> +			return fmt;
>> +	}
>> +
>> +	return NULL;
>> +}
> 
> ...
> 
>> +int acpi_nhlt_endpoint_dmic_count(const struct acpi_nhlt_endpoint *ep)
>> +{
>> +	struct acpi_nhlt_vendor_mic_devcfg *vendor_cfg;
>> +	struct acpi_nhlt_format_config *fmt;
>> +	struct acpi_nhlt_mic_devcfg *devcfg;
>> +	u16 max_ch = 0;
>> +
>> +	if (!ep || ep->link_type != ACPI_NHLT_PDM)
>> +		return -EINVAL;
>> +
>> +	/* Find max number of channels based on formats configuration. */
>> +	for_each_nhlt_endpoint_fmtcfg(ep, fmt)
>> +		max_ch = max(fmt->format.channel_count, max_ch);
>> +
>> +	/* If @ep not a mic array, fallback to channels count. */
>> +	devcfg = acpi_nhlt_endpoint_mic_devcfg(ep);
>> +	if (!devcfg || devcfg->config_type != ACPI_NHLT_CONFIG_TYPE_MIC_ARRAY)
>> +		return max_ch;
>> +
>> +	switch (devcfg->array_type) {
>> +	case ACPI_NHLT_SMALL_LINEAR_2ELEMENT:
>> +	case ACPI_NHLT_BIG_LINEAR_2ELEMENT:
>> +		return 2;
>> +
>> +	case ACPI_NHLT_FIRST_GEOMETRY_LINEAR_4ELEMENT:
>> +	case ACPI_NHLT_PLANAR_LSHAPED_4ELEMENT:
>> +	case ACPI_NHLT_SECOND_GEOMETRY_LINEAR_4ELEMENT:
>> +		return 4;
>> +
>> +	case ACPI_NHLT_VENDOR_DEFINED:
>> +		vendor_cfg = acpi_nhlt_endpoint_vendor_mic_devcfg(ep);
>> +		if (!vendor_cfg)
>> +			return -EINVAL;
>> +		return vendor_cfg->num_mics;
>> +
>> +	default:
> 
>> +		pr_warn("undefined mic array type: %#x\n", devcfg->array_type);
> 
> Is this function can ever be called without backing device? If not,
> I would supply (ACPI?) device pointer and use dev_warn() instead.
> 
> But I'm not sure about this. Up to you, folks.

Given what's our there in the market I wouldn't say it's impossible to 
encounter such scenario. Could you elaborate on what you meant by 
"supply device pointer"?

>> +		return max_ch;
>> +	}
>> +}
> 
