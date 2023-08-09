Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BCD7759A8
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Aug 2023 13:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbjHILC1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Aug 2023 07:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbjHILC0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Aug 2023 07:02:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2CB1FFE
        for <linux-acpi@vger.kernel.org>; Wed,  9 Aug 2023 04:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691578945; x=1723114945;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4TLvr9z+F5sty04if7cfAPcEXEwg5SdE51mMm+rv9Vo=;
  b=Ftb2b18XKmo9x0UG99BqievQVYRDGVbnhW9FtBsxYdoDpY2Jai64QGDj
   SZ8tCwxAoDdaMeXYK2F2VffYhrQKaRMTqgaS61IRrvQh4Mghpg9bDQOyw
   B6hP3VYtUoJbGet8yIC4Yj4uBvM13T/Iu0DnX+VMRy1xoxoBvYM36T14K
   P3J2zzOcdtdNHIRuCYlCpd3jNiMHs0vu5goLmDBanZ2m5YGR7HTKML9XO
   ZASP6tFY1u8WD1zLNm3bT0Dmnobd275cbMlTziYCvSgqD8vFtea5ByH6z
   TLVmt9lpXy7hjiC8ZbMRPDkPdWwx4cX64rxEP7yVM/jZAKA+ZDDcG+Eqg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="350678495"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="350678495"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 04:02:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="731760192"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="731760192"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 09 Aug 2023 04:02:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 04:02:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 9 Aug 2023 04:02:24 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 9 Aug 2023 04:02:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YePhgUJZ77fkUGOPLt9jknDQQ/buSdTMTVSfbxDqZHDCtPfQl3YCoxUMp6V/AVrgvJ35mbP+bMqRhoHDA5ltT0Nf/GQHemx/qJyS9Br4m1bnmg+1zibZqwOLJeiaY+ubVKEfNJnDUq5FldRD4VNYVRBnEg7ETqRJgI7HsdKFqTlK3Q4CSqkOdtAeCs4dHN+/wlTEplJE/5LaudsAnVwia3zBrOZTfu/o6aXzdUDJnX5ItmBxdwl3+eUdUucZQpAAcfwk9jQrlq8x+TJDddO+rxEn5uEOf68lOFPnzb8TChMNdUWTmavQmt9xSseXavxsQKypbBOCa4h54ktL5N4VVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/iL+e25DQO+X8Zn6zVq+whwLKcYcy5r2dg3cCeyz3w=;
 b=XJL8laoRuQz0Is4iibscDd8HuUSB9kFdSk73KKGzIwV9Sqr92X1Msr3kXcaPs+e9gt1Na3AcXGs2Am9XHSBIY0k+TLI872C1UJF66XBHjRREXFF5xY7f0APiTNTYDGddmFXkY2kYQDlIKz9Iawsu72kOePCQkmSQxQ8LX1AfHYLlya5P0P0cBcvt3bkZ2JCWGlXNv2p1diezv1MM0vnPFN0t2w0NRbXjlY/Gnxwq5kFr+1J0SdGteaoU4YTPsKvoCiTtk+JE/gCHG5MzDdp9Rdh40FwtGAoBy2QWAz9uRigYIXC8xHjLRotJvD2uDfICxh2wxYLypu43z8E+4Qw+Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 MN2PR11MB4581.namprd11.prod.outlook.com (2603:10b6:208:26c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 11:02:22 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::71cd:9328:e4d3:d104]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::71cd:9328:e4d3:d104%3]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 11:02:21 +0000
Message-ID: <d41c58f0-9fbc-dace-a781-8ba00758c052@intel.com>
Date:   Wed, 9 Aug 2023 13:02:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 1/4] ACPI: NHLT: Device configuration access interface
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     <rafael@kernel.org>, <linux-acpi@vger.kernel.org>,
        <robert.moore@intel.com>, <amadeuszx.slawinski@linux.intel.com>,
        <andriy.shevchenko@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>
References: <20230721154813.310996-1-cezary.rojewski@intel.com>
 <20230721154813.310996-2-cezary.rojewski@intel.com>
 <ZNMdertpWWvoAJM3@surfacebook>
 <c987d5dc-ae21-8fdc-3037-ad05c44742dc@intel.com>
 <CAHp75VdbXXfWT9NB+EF3Wqdjq2egpPReRAwnG96bEckeA9a0sQ@mail.gmail.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <CAHp75VdbXXfWT9NB+EF3Wqdjq2egpPReRAwnG96bEckeA9a0sQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::14) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6375:EE_|MN2PR11MB4581:EE_
X-MS-Office365-Filtering-Correlation-Id: b6584a88-ae16-4b8b-4726-08db98c81b01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uUBUCR+TZXfeE/GG0M1f+hU0eb87k607W56GJ4Tu/hwuSP/W7tEzUvKNROtG95NSQSTPYEiIMK/mRLo86elLjOds5f8uNpV3nBSOUtO4I9/EpqyOFSLcxiIIDRL6BJTh4VSJgyjLwKCfqOgL7N4s1Kps0lyxwbqEZNDcbNbK/Ule5ynHkPlaAmTD4HYyvOWtjAKN02ah/4v63+jeijXeT3vfZOsdXaYqRY9Tg/fC+KK4LJAYhnN+8oVgvHKeQH1zI5dGW57luqmVpqTCtG89YRD4Me55TJIB6c0jUGWfzYOrVIl5+GDwP8R0HnOLcvM4rCRXJiGzr3pFWk561QnzIFgl1LL3TCN154C2/RI1AVo8pexKWp1eXRaqCrtQVf9i6qg5I7VR+YQ5fIOXqaga5a+1bTGhSHMqtgLQF5vgbmhm1c+XPH6+AbyIppDqaKIl2+/1N1wU3I3KQ3j1/OImzU4TeQehL5SNyLPfY5CnulS/PgIMVCw2SuWuLdCrl8KrPGbPpWiR02JgZnsZW8XnT8YJtpiERGcRTJXOn8ZK5X3IoJoVSgLCST3VuGRb2DjdNiQBjrGRCdk1S1ntLvHjZzGrRGUPGwxNLmzG9D+ltyXrOwVucVxbOQZ7so4nwEayT/i5003umvUDA/gTQywr/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(39860400002)(366004)(136003)(396003)(186006)(1800799006)(451199021)(31686004)(83380400001)(478600001)(82960400001)(2616005)(66899021)(6512007)(53546011)(26005)(6506007)(8936002)(66476007)(66946007)(66556008)(41300700001)(316002)(8676002)(31696002)(4326008)(2906002)(6916009)(6486002)(6666004)(36756003)(38100700002)(86362001)(5660300002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGpnVWVMaU9rdVNTY0VsLyt6Y2g3LzU4amZVYnFvZFBlWHFLUzNuMDFualg1?=
 =?utf-8?B?cThSVzQyTDBuUFV1QTdUMU1tK2dHWFFxTXBURWdGWkNxMExOb3BGTVNXVW1h?=
 =?utf-8?B?TmRCV2pCVzY2aEs0bmVZK2V4eDhlNlcwYU95c0Nwa3RoTVYxN3E0QmFJdWlE?=
 =?utf-8?B?bzRHd0IreGc0U1hDRnBKMEltV1J2ajMwb2xhSStUaEl3MGE2Nkl1Rlk5dU11?=
 =?utf-8?B?LzhaeTY5UXppaUljWW5PeUFvVSsybS9ZaUpUYk0vU3R5bXorcUZuM24yL0s5?=
 =?utf-8?B?a0J2T0ZIMC9ZbzVMNWRVT0Zkb1JPMzlqN2kwWE9GSjFab2hsT0Q0eStEdEZD?=
 =?utf-8?B?amF6UUl1UVZsUDVHTkpLT09NV0dZdEhudi8vaWdoVllCckg1bllJOXQrbE1p?=
 =?utf-8?B?ZjhrNEthVFZLQ01XTEw0VTVnNHBEemU5cWtWWmgwakJwdjRzb2YzaHhvTFpJ?=
 =?utf-8?B?akFUcS9Gckx5ZHg0NEY2Sm5HblpmVENWRG15aFBnYURja29zWDdVTFhDWTFZ?=
 =?utf-8?B?WmgxbHhwemNRLzNrY1NwOXljcE4rS21lUllhbDg3THNRV2lMTmYwRDdMR0Ry?=
 =?utf-8?B?dzNMZ3hrWkQwQWlZeFlVRHFNWk5IQ1ZRMy9OMWcrQ2dRbUpvK01OVjd0OEpW?=
 =?utf-8?B?dHJaRWRselNyNHh2SnpHbzhyRTdBMnZtcDRpRnArQk0yU1RUbmZaTUNyaUFm?=
 =?utf-8?B?clhVU2E0NWhZRjFGZ1FlUVZodzcxUW9oOXFlT2UvZWI2SmdQNGJzZVZ2SzNy?=
 =?utf-8?B?U1U4YWQvM2NQa01RaE5tWkZjalIyVE05cHVNQktlSUE5M1ZTLzJLWGVIYUJz?=
 =?utf-8?B?MS9iRWpaRW92STEwZytXVEhQNkFnaTNNWWFLLyswM3RzMGMxRzNpK3BheE4y?=
 =?utf-8?B?KzlBamc3bUFYMkp1WXdhQnlzUEdSVlRCS1lZSDBDM1VPSjJMS2ZNLy91ME5D?=
 =?utf-8?B?enN5K1BuSWVBNXBOVlp5a3l3eEQxenJPQ2VnbFo2MFR6VEl1RElwUVpYdmtD?=
 =?utf-8?B?MVhEQ2g0WkdhTVBIaXJrR0lpdEY5ZkQ1R3lkOWdpV1cvd3VnSk50bzNSTGpi?=
 =?utf-8?B?TzgrZHZsWG4zamVwbmliditxRk9ISWNqbWxFYjIrcEJtcU5HN0kvdXA2akFK?=
 =?utf-8?B?ekdCSFo3WUk3Q2lMTWdyVTQ2b0NkUUhyUFZXQmtmQXh4M25mYXljeEcxT1Br?=
 =?utf-8?B?V2RFeUFZbFQzei8zZjB0bGJON2NjdlFwTFllZnhzOEVZUUszK1Z1RXJVL0Rs?=
 =?utf-8?B?SGc0UTF1SUNsdGlyTG9sSkpJV1hmSUxPNUo1ckxiUUcwa1RoMkdwZS91K0d4?=
 =?utf-8?B?T2RzbjRzd21EZnA0a1ZpTDdTbmtWTFBJWCtoc09OZ054R004ODlWeEowUnB0?=
 =?utf-8?B?eHFyVitNa3B3UjRobDFvVFF4LzYyUm1QTWRRQllOVVhOWGFxTEdMOHRsSkpW?=
 =?utf-8?B?MmtVSmp3ejE2ekxqU1VHRlg4R0MrSUJDcjhteEdhZnJKaFZycG91TTZvdnJr?=
 =?utf-8?B?R0p3cXhMRDJqa3RpR2dNUkcrL0FMSFB5cVluTHZza3d3TVNUZ0JocjlWSExR?=
 =?utf-8?B?bjFDcUpJVzhJMnIzYWFVcGpoQkFMQWg5Z1JGb2dURFlsR2VDVzBHTS9BbS9P?=
 =?utf-8?B?ZTdWbUEvRk9ZbURObERXRjU1YnFaMi9WVjVJSUtlaFIrRzlTNG40b1FyNXVn?=
 =?utf-8?B?VjdJbTcyZFB4QXRaMndCWDVDVWpDQmRGOEwyWHpyem5iRU8vWkxUdVlpbjZE?=
 =?utf-8?B?aHdDS28xckJNS2FVM1BqS0p6Y2laWVJiMGordmtxTWVFS2gxOURVSXRRcnJj?=
 =?utf-8?B?R2RXZ3llbDEwUGRoS0RZTmtBMU5hczZrOXU0bnZVTzlCZW0rV0hQQkN4a044?=
 =?utf-8?B?NkpCekNxempSWlJvRDlPUHIxbG9BT0ZTZHFrYnhSeW5pZWdmZHlJRnRGOGVM?=
 =?utf-8?B?RWJINGNhZFdaQlFvVGY5Z3V4VGtwWk9VblgvMHo2aDBGVDgvODFxVGVPT25G?=
 =?utf-8?B?VDJia0RIUWpNWFdnOVF5dWI3VW95bHRQYkNJNURvR29EaEFyWVFXclp0QVgw?=
 =?utf-8?B?VEp5U1dNQndJSnJkUHg2V2RrYW54emJKaHlTb1JuTTJBVjRjcTB1QTZyRXZF?=
 =?utf-8?B?OVFwTmY2Q003UEIzNlJheUkvT1E1Q1NDYjk1NHZQdk50cGdzejZpWnhwQ2Fi?=
 =?utf-8?B?S0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b6584a88-ae16-4b8b-4726-08db98c81b01
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 11:02:21.9334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zfBFTz89cNaMXLToB/kgqYjOX3lu1rlgxyMgBoec/eS0KU/SHUga7jbECba+q04RhOifywd4ut52GvEy+KrJPM1PhH2z6TciMfvWh685+JU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4581
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2023-08-09 11:05 AM, Andy Shevchenko wrote:
> On Wed, Aug 9, 2023 at 11:48 AM Cezary Rojewski
> <cezary.rojewski@intel.com> wrote:

...

>> First, you took the review seriously and provided a ton of valid
>> feedback. And your reviews and expertise helped me grow as a developer,
>> so from my perspective no need to sorry about spotting bad things late.
>>
>> Now, I admit, a bit surprised given the number of revisions and age of
>> the initial patchset. The cover-letter, attached for each revision, made
>> the intentions clear.
> 
> As you may notice I'm not against code that is done as a part of the
> Linux kernel and my surprise is the ACPICA change. My focus for review
> was a Linux kernel and it was just by a chance I looked at the PR on
> GitHub. There is neither good explanation in the commit message nor
> discussion of the change. What I probably miss (and that may help me
> to understand better the change) are:
> - the examples of the code snippets that are using data types before and after
> - explanation why not all data types were covered (there are more
> "strange" names like with _a, _b suffix)
> - how this is supposed to be maintained as the ACPICA has users
> outside of the kernel and how the change
>   makes their life easier (to me it's the opposite).

In general, many types are bogus or redundant. I'd argue that having 
types defined as _a, _b, _c, _d make the life harder :)

struct acpi_nhlt_device_specific_config_a
	bogus, there is no '_a', it's called mic device config instead

struct acpi_nhlt_device_specific_config_d
	bogus, such thing does not exist
	it breaks the spec as the "CapabilitiesSize" is missing

struct acpi_nhlt_device_specific_config_b
	bogus, such thing does not exist
	it's the header of any dev config but just header alone is
	  invalid

struct acpi_nhlt_device_specific_config_c
	bogus, describes an invalid type. Such thing can be encountered
	only when parsing damaged NHLT

struct acpi_nhlt_render_device_specific_config
	redundant

Then we have constants such as:
#define ACPI_NHLT_PDM                       2
#define ACPI_NHLT_SSP                       3

_PDM/_SSP what? There is no NHLT of type PDM or of type SSP. These 
specify link types but it's not mentioned in constants names.

I believe that by now you see where am going. The patch focuses on 
device-specific-config area as it's the area that requires most help.

>> Our goal is to help actual users of NHLT i.e.:
>> audio teams. While part of ACPICA, NHLT-code is hidden within sound/ so
>> no one asks questions. Leaving things at status quo does not improve the
>> situation.
> 
> What situation? To me it makes it worse. (Again, I'm talking solely
> for ACPICA change, the rest I have reviewed and I am fine with the
> direction taken.)

Situation = on top of above, NHLT-code is currently within sound/.
Let the handlers be part of drivers/acpi as is the case for all ACPI 
tables. The handlers themselves do not (and shall not) belong to ACPICA 
if I'm not mistaken.

>> Thus I believe simple "no" is not an option here. To make the
>> code better overall, relevant pieces should be made part of drivers/acpi.
>>
>> Original problems stem from the fact that audio teams were not looped in
>> during initial integration of NHLT-code. Turned out that no users
>> utilize it in its current form. The problems are subtle, but a
>> discussion wouldn't hurt.
>>
>> To avoid double posting, should we continue the discussion here or in
>> the PR on github?
> 
> Let's do it there, as it's purely about ACPICA.
> The kernel part will be affected depending on the result of the discussion.

Ok.
