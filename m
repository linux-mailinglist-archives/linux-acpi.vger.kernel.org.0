Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B47975AAC1
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Jul 2023 11:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjGTJ3c (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 20 Jul 2023 05:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjGTJ3N (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Jul 2023 05:29:13 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488E236F1F
        for <linux-acpi@vger.kernel.org>; Thu, 20 Jul 2023 02:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689844512; x=1721380512;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PKSUNTDB1joMwSjSd43IrTiGtdCMoTy/vXhXVzu3c/Q=;
  b=N/IJ7qKNdyXqre9jMLCQ603Fq8OwtB9jvZzbJydDbVTbUFHBnydj0fQu
   FhKvv+lRA9OJgJWcDf/ZMk4ZYxt3MXsqxVlFMwwvBYBqG4JNG6U7CAwbb
   Ip6eNFWDUtRoqGSKLTMuW82yvVLXid0eL8L4BlGF4ceoO6cXSzdZc857j
   YjXmeqwqb0FLsgQJy/PvGYMYYdGYf+B/UTcxWone9F4ympML3FwteC8X+
   a8NcGZNVFOYpG+a2RXeABXDrFDoobfmQqDbaWTMd51Gl0UkzYmH9VBxy1
   9rSJ+goiV9wA3sjWXHcHcsKysGebxCgexN3avMbWwb9X1+uxQFcKEOXUg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="369335109"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="369335109"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 02:15:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="898217145"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="898217145"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 20 Jul 2023 02:15:11 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 02:15:10 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 20 Jul 2023 02:15:10 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 20 Jul 2023 02:15:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YqdZFrZue0NBI1gTz6IEgs+jGFnVKEnMxXil4OkajWnis4zXmbgW3peASwdKAyJ0GCiB2zFOzd88CVkwvcTZrD39BreQRKX4onAUuhQjkiiBSW665gQ3YnXD5oufFV0tFCn8Z7BCyWH7rM5hMccIj/yHO2ddqDM7iebgxFsQ7aCj6IkB+LX5dPAjVd+P0iPDsuc4EC5QoUjQcA7EDQRgMjXz9JjO1yDGSTYC6QjND9A4FDOIVzxnDSXuu0NMUk/1GOD4jnEfLPdJCBJmmHQvpbwcvFle0Kwg4qQJ9vOEKxaBr8Yvfp2di3cVMUmNCVIlcnB+Hljmaef9Bde6Cn/BgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCWvPccg5UzGeGJZEyojO1h5fV3pHEMEh6lejmCg8Ec=;
 b=fELagQm3J7qeW6vF+Qs5pvCZmB1Jq49yOlbdKtSr1rOIHcf4TAVGSvll9kY1JtsrL/KfwmS42VQQ8geTn30wVvYj/IroPFUvkysnsPyWu0pahjVkKpZ8sMgZrHd6UPFo8xEWPdzROOIiEZidPOw9eteyVRY3kehlk5AQRTgQzAz03GflDLBS1y27bcQ+781OOKfjt0tKT0VcouQQdK6Rbya2T0AxAtBsRjAX/AvCe6JO8Auh8ZT3W6iS/R1jdL5Wc7jJxbwDp/g4G9CjOeyoTDdsbFrd3dZuJHZXy4VHTHaGQzeuIKxsUKMSpFbrZ7MXEV3A5BmhAZuxHsIvg4BTZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 BN9PR11MB5419.namprd11.prod.outlook.com (2603:10b6:408:100::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.33; Thu, 20 Jul 2023 09:15:07 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::3a96:9177:fd4f:c649]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::3a96:9177:fd4f:c649%6]) with mapi id 15.20.6588.028; Thu, 20 Jul 2023
 09:15:06 +0000
Message-ID: <820d5447-a491-f052-a1f1-939fc9c283bf@intel.com>
Date:   Thu, 20 Jul 2023 11:15:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/4] ACPI: NHLT: Introduce acpi_gbl_NHLT
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <robert.moore@intel.com>,
        <pierre-louis.bossart@linux.intel.com>,
        <amadeuszx.slawinski@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20230717150047.15196-1-cezary.rojewski@intel.com>
 <20230717150047.15196-3-cezary.rojewski@intel.com>
 <4af468ff-6b87-962d-8629-52bb7d9ee340@intel.com>
 <ZLgDDB7vH/4FaI06@smile.fi.intel.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <ZLgDDB7vH/4FaI06@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:26::13) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6375:EE_|BN9PR11MB5419:EE_
X-MS-Office365-Filtering-Correlation-Id: fb4e32b2-40af-4928-fd37-08db8901ceee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yzPxw5cj0nJIwg2aqvJZ/WHRGg2pFPwStFkeswIeccZWl9e2HA71qPLRqFeF7JZrVQLqC/iieEY7GAT3i4/2zt/HITvyGBEMADd69WYEtJ2km+svKvgpossU+f8Nl1OmTuQSPfEc+LKmJwJzzb/FOQ/8LQ4iK/VAeYgEtSrriedslpCbrOiiKRRpGXcjK1SCZBKk8xJ13mX7Tj4A3bZyczstQTeqLZJng500lvAUrK6nc0ssx+iOlFo2/f3cBDI/sAZQ5/HpmUz00IkWqISO7yXBkUXz20DAS/RzZgwve/72no/OtdfzBBhr1Rq0TDaLgwikWuxNC0qDOqBGXME5gDbuyoaA77dUHAuW2Bb63OOhH6ZjoIHw2i+C2SEtiejo26aznmOnpjm6CEncrScV0SaL8J/FTVHXTeg3UDybnYQ2CeOr+0Ufj6nf2GS1LhQTn/JkNy9UxxDKPD2MUhkGHfN6A1iQF6cWoaARzr8Sz9RmUlQ4WpKXIi7ubta1rPfHkaDT2X9j0osVujEZr67KlaK2ZyWbFsQ9ggscZqBt3ERiWutYDbk3RJkE2lHTQ+PAZ9flc7YUkLRKRPr7bEJVtdsdV9BG/CMuj6qdxGETpEONwI8/p/Q2dtZU/S9+DxHVmDogFkqEpx2OKQw4TuYfjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(39860400002)(376002)(366004)(451199021)(6486002)(6666004)(478600001)(83380400001)(6506007)(53546011)(26005)(6512007)(38100700002)(66556008)(31686004)(66946007)(66476007)(4326008)(6916009)(186003)(82960400001)(2616005)(5660300002)(316002)(8936002)(8676002)(86362001)(2906002)(41300700001)(36756003)(44832011)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0pWRVFGMXhQQjMzekp4elpPWHlOc2UyYjMvckdrVE1XK2JLS1pFNk0wMTRY?=
 =?utf-8?B?OG5sVG9rdWJLWWlPUkcvQ0gvcTZYVnlYVnVRbVpleDlzeHlNUWJrWFVobHdV?=
 =?utf-8?B?OW4rVHE2Q0NSbkxtRTNmb2tIeHdUcitRdEFtZnovODA2MFBkY0lzWXpLazE1?=
 =?utf-8?B?V1pQZzVWb0gvSlFITkgwS0VHTnJuMFR4U0N4SFpIN01oeW03UjdGOEpVUFBP?=
 =?utf-8?B?elhad0JQRU5MWDdOaW1MZUJESk14N1lFYjdoYVN1blRuS1B5VUlDWXVVa0NO?=
 =?utf-8?B?ZldjVk1Fa0p6Z1Budlp2anBhcU52UXNDNm9GZHFHOU5NLy84UVl3YlFJQVFh?=
 =?utf-8?B?bFhOOUp5NUhMeW5LOUJxVFpxSVVrSjBRaFc3VnRkQVV3eTdubllacWVGRDBa?=
 =?utf-8?B?VkhmdEdMZ0pzZkQ2b0ZWUk9EZUNSTXE3eDk1OHBSQmwzTXBXUkNFRTUxaC9L?=
 =?utf-8?B?bWJzOTg0cHJZeFJ1ZmUzd284Z2h5ZGRRYmJMb2syZXVFb3EwVW1hNHRSSUJm?=
 =?utf-8?B?MnVSRngra09aQjR0Wnd0SkNodUJyUm1aa2dFRHB1ZGZlc09HWXBuc1U1ajdo?=
 =?utf-8?B?cElFZzRHZnpiVEF3L0Q5TjdBaXRhRUJtcmtlb08xQVFycEtGNWw4RmxrTTQy?=
 =?utf-8?B?WWE2TzFsaEo2TnhWQURpbzlKQnpFcEFzQnVBM2VOSnZhMXNFZjlMcm4xOHFt?=
 =?utf-8?B?dFFGUjM3QURhY1hIN2NvUHpYUTd6UjVISTRSUTZkZ1pkWjNBQk5ES1lKRDdL?=
 =?utf-8?B?L21PYnVSSWc1Yi9jQm5MUEhRRnc3UEtlUFRBTWIxaUh5K095QUVhd0VPMWp2?=
 =?utf-8?B?OEVTRHZBTmg2eitBdnNLSkViWktESGtudUpHQXNIZDUrU0dSREpYTEgyY1pZ?=
 =?utf-8?B?UGEvVGpyczRCOTJ0dno4Y3NudnRFRXB0c2ljeFFkS3N2UTg3T2htblp2Y295?=
 =?utf-8?B?U053NDVjbVVhdnI3clk5ektyOXdtSVhiSWp4aEt1SytHK2E4TGluSmNIL3VQ?=
 =?utf-8?B?RVNFYzQ5anFzVm5nUVFHTWRKU3NQSldiY3dkaS91M0VBS3dVZkhlSTBIRXla?=
 =?utf-8?B?STVwR3VaY0doOGlydEw1ckhnQm93UGJLeGpsdjJqNjJKdE9qd3o3aEdkd1d2?=
 =?utf-8?B?R1dwVTFSdEV0Mkw0dkh5MlExOExpdWNYcmlQSjhIaDcrZUo3NHA2bHRGeHBv?=
 =?utf-8?B?cUtkenVKUUtmWXRZQ0YzS01tV0l6UXIwSVNRYzRCdGVDRWNWVmVzc2Jlbnpa?=
 =?utf-8?B?eS9ZMTgyZlY0RkJ2emcyZmU5bzZPRFBQWFhVUFFkSGVFY2ovSGZoWDR6aEps?=
 =?utf-8?B?eThHTFE5NDNjdWVqTDlhVlB3TGlMQjlMNkJZUTRHZXJvTGpmNjRjL2xUYUhu?=
 =?utf-8?B?NVoyWkRIUFlKRDBSQVlRNGhjUG5SaFRzTnY2SmpyUkFyeGhpc3k0N2dVT3Zz?=
 =?utf-8?B?ZUNVdDF5UG1GUUx1RE52ZFFCWmV2K0MrMFNjajZRMVM1Unk5cEhKZGpWN0hh?=
 =?utf-8?B?TlVtR292MHFFT0crV0tuSXpSaUVhaGI2M0doSjdaN3ZpY05udFZzK3NJRERE?=
 =?utf-8?B?bktaTy8zalNRMHBReUJVeUhQQ1BKNWFMbVlscGFlWjZhbXJuUERQRVpyNURN?=
 =?utf-8?B?b25lK0FmUFo5MG9wdFpGNHlFZW5DcE1sd1RaVWZGZ0hCc0l3cW1kcGIvVmtt?=
 =?utf-8?B?UjVvU25nZGRoMzAxZHNvN1RzdllPamdXdzdwdDJpRUwyMS92eE5GcHJJL0pE?=
 =?utf-8?B?WjlCMlVoQm5MeFNYNGVXcUR2UDl0ZE1STVRJZnNDZmpKdUwrVnQyZ3QxSFhE?=
 =?utf-8?B?bjRjeTFHN1ovcVR6WWJVQ1RTb3hQcFVWT2VLckdVQjFQVEdoVHJHVnRuUC9S?=
 =?utf-8?B?TXZvcFlFbWJ5ZnZMa25xeFZaTlVTR3M2Z0RNZ2xaQlpWdjhoK2dROGNPbkJw?=
 =?utf-8?B?OG1kMENaSWgyS211ejkyRUdVcEJhU3JpTjRLbEtnSlpOY3JMUmRtbmZFSldS?=
 =?utf-8?B?TVROVFEwa1pYMEp0cG1ZV1V5UWZMQ0ZENU5sYXZaM3ExK3NWaUdhd3VLZHhN?=
 =?utf-8?B?MjRoYUxoTDdRZVpVdkRzdDc4T2FuQjJ1alo1cTFGV3R2S3VxbWRybDkxRXJz?=
 =?utf-8?B?NEY3WjdqRiszZ241RS9PTVdwdW52V09MSjRNbWZvL1duYkM2SUtsM21lRFNy?=
 =?utf-8?B?a0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fb4e32b2-40af-4928-fd37-08db8901ceee
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 09:15:06.5109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eZfKyplsijANs9rq+3wr0Xnlm9vGV9VgodRDW3LEyxqVe8KlZugcfrdDcndoEyg5C7SIroDOjw8QZXEcpOTuGdFyx26nl3nWyaEtO5wqh6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5419
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2023-07-19 5:36 PM, Andy Shevchenko wrote:
> On Wed, Jul 19, 2023 at 04:47:31PM +0200, Cezary Rojewski wrote:
>> On 2023-07-17 5:00 PM, Cezary Rojewski wrote:

...

>>> +++ b/drivers/acpi/nhlt.c
>>> @@ -0,0 +1,13 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +//
>>> +// Copyright(c) 2023 Intel Corporation. All rights reserved.
>>> +//
>>> +// Authors: Cezary Rojewski <cezary.rojewski@intel.com>
>>> +//          Amadeusz Slawinski <amadeuszx.slawinski@linux.intel.com>
>>> +//
>>> +
>>> +#include <linux/export.h>
>>> +#include <acpi/nhlt.h>
>>> +
>>> +struct acpi_table_nhlt *acpi_gbl_NHLT;
>>> +EXPORT_SYMBOL_GPL(acpi_gbl_NHLT);
>>
>> This approach generates a problem with undefined symbol "acpi_gbl_NHLT" when
>> ACPI_NHLT is disabled. As nhlt.c is not built when said kconfig is disabled,
>> symbol is never defined.
>>
>> Proposed solution - modify drivers/acpi/tables.c with:
>>
>> +#include <acpi/nhlt.h>
>> +
>> +struct acpi_table_nhlt *acpi_gbl_NHLT;
>> +EXPORT_SYMBOL_GPL(acpi_gbl_NHLT);
>>
>> as tables.c is always built the symbol is always there.
>> The only other option I see is:
>>
>> -obj-$(CONFIG_ACPI_NHLT)	+= nhlt.o
>> +obj-y				+= nhlt.o
>>
>> and modifying nhlt.c so it's essentially split in half with:
>> #if IS_ENABLED(CONFIG_ACPI_NHLT)
>>
>> but such solutions stinks. I prefer the first approach.
>> What to you find guys?
> 
> I leave this to Rafael as it's his territory.

Rafael, which option do you prefer?

Regardless of IKP and my CI returning success on compilation tests, 
clearly there is a problem when CONFIG_ACPI_NHLT.
