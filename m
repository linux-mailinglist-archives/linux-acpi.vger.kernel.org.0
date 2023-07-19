Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A995A7598E3
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Jul 2023 16:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjGSO4u (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 19 Jul 2023 10:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjGSO4t (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Jul 2023 10:56:49 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55F3C0
        for <linux-acpi@vger.kernel.org>; Wed, 19 Jul 2023 07:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689778608; x=1721314608;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RSMVEVl0RLqRs6qUHl4x1oALiNpgvWj2G3t7bqL4P44=;
  b=Aq8kSd3J2PhuvF5PqHqrtd3nXH/SfbWvw+d+/px2jES5nQfP0NoJpFTX
   K+zDCCyme4iyiqqSOsUZwivMmZO47IO3H8Lo4KBhBIcHzV4UgLez3XAWP
   XIzSB1kFHYPqOTEABruggLV9mS4sh8xtuHBdaS8F/Jx2T71HH+HpgSc2J
   jJZ8/ZLnoppoFNWtLjflKoFiByFpICO93/wm/pkkyOeyCZ5z/rNPLyOcg
   JV4zuECzeaXBvJEW50F2Z0z/r8055DvWJheYHSmyTsPLya9/8AyeoTpQh
   m8dLC1+e9MdlSdPZAwxyuhEGb4kNkiGncOQGFJdkNWRHbe61Jqlgfudsx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="356440902"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="356440902"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 07:56:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="837737922"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="837737922"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 19 Jul 2023 07:56:47 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 07:56:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 07:56:47 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 19 Jul 2023 07:56:47 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 19 Jul 2023 07:56:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WxZms0V9DOdHrCVu1a0D3vBVGq8XwlpthfDYYWIdByTMp5+G+xeksUbUe891Sav3Qf3xDNdKzh83ar8EjAxJMyCYKeEV9DX3ZSNgQ+vG9ceKaBJCgEeX2eOSL9wVEq90PAnvFW5oY7ngHcAJNOTP+M72xsnaeHoFRXWuVkan5VaNYFlAlJsSWFboA+BKhd46d949eOZZfLnhKJQ6+Oz13Zzu0p0SLERdIc7q1xqa1LEGG455r5+TCeHR27N6jpklWRrG76D4HezgeE59Mzj70LGMcO1mYxhgkgJofA9p9UWFc2SCMeUvt4J3F4dbRIlWMRwyFJWhD60obFDNirn+HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/3SaKRMJVBG0w8bDMkkDQS2rOcF60hT4Z3Ac3Oihew=;
 b=mCEqAfxx8K+AoHv1ERF7B2DEkXrl+n8UlZip6US5v0LaeBAvnfGR+XSrZYM9RLLxf7/8WXFEyDJdFWroZEN3P62WTCTJ1bc3kLYbubfg8UbC7dRZQpYnn2JiBTN2gLlhyrMaTE7Xc6NYEWTCbr+VgFTmdV1/rtESFj+9aEWldPaDgqoMEWYHDlhBHmd0iWW5A3a6IO6wePX8JvmYkSqdZYlvjLsbmb6pZLpT8ADC/idfD9h5IZ6WPZHIZ9deBuM8HF+tE4+yN0YiLicU/qogeiPAgs93ZQRpjSoERFcd3fpYCBVZa5qDQ4djXf1Z2CnxkU45PgoXiqmC5/DLOwJgzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 PH7PR11MB7642.namprd11.prod.outlook.com (2603:10b6:510:27d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.31; Wed, 19 Jul 2023 14:56:44 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::3a96:9177:fd4f:c649]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::3a96:9177:fd4f:c649%6]) with mapi id 15.20.6588.028; Wed, 19 Jul 2023
 14:56:44 +0000
Message-ID: <199bdc7f-a549-fe70-5a2a-6d0e7d3417aa@intel.com>
Date:   Wed, 19 Jul 2023 16:56:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 0/4] ACPI: NHLT: Access and query helpers
Content-Language: en-US
To:     <rafael@kernel.org>, <robert.moore@intel.com>
CC:     <pierre-louis.bossart@linux.intel.com>,
        <amadeuszx.slawinski@linux.intel.com>,
        <andriy.shevchenko@linux.intel.com>, <linux-acpi@vger.kernel.org>
References: <20230717150047.15196-1-cezary.rojewski@intel.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20230717150047.15196-1-cezary.rojewski@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::22) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6375:EE_|PH7PR11MB7642:EE_
X-MS-Office365-Filtering-Correlation-Id: 032860b4-2260-48ac-0afd-08db88685e20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GgwP0cY7KFluJDmD+GtgnhDKJ7HAkpjpJxjl4HfNLkQOk5SYFiDY02M+ScQyJTUpItOvZcresMU7m609a9xjcnxlj++uHA9vSbhH46O8xO6vQgndj/lH7FJeh+0LFH/czIWDnW/JrOS7U8/1dZ7Y2PzUHxGG3yH9bNLMyioB/G5cLjq/vfvmqf8p/cxTce8uMxtdUI36km9Z9O7wrfskKooBp9wrqF+Nf3ERalhp6P/qbZ8/ADtWTNNAmuy8VYYBqyi+wnmcwMldZLzEg/gCqhH84HkwuEu6t1xw78ObvwS7iTF7w4j2iJRyshndvfppdqqWhfLUM7pS2ppGIKk7Y9WbaRRyvemAoCA5lMudw5R/nzaAB+xOcldmc+Gid5U2ObShRSW3XZ4U+uC2RVCjTSPmoTFJJZWRh38iV4ydPpILGJu6ffllL+Z4I/TT+7nb0gPr97MONzqwc/ozlm0qa7Ggfx2rcswWjcbxLRXazTviKDCFwkNDmLlOyScHCLQfgNTEf9qryUEQxWHa/9A9NJGE9p086rOe72EyeV/Frdtz3pcjWgupqhksSG5stGOwToJ1NCbAnDnODmgMAG4mF9W2vIE5N73q7lRnaKZHFkitpZjqos6Ze5AB6zYVYwRUGe+DosPzxpeZdSXHQ4i9Bw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(346002)(136003)(376002)(39860400002)(451199021)(31686004)(2906002)(478600001)(6486002)(6666004)(66476007)(8936002)(8676002)(4744005)(44832011)(66556008)(36756003)(41300700001)(66946007)(6636002)(4326008)(316002)(82960400001)(83380400001)(86362001)(6512007)(186003)(53546011)(5660300002)(31696002)(26005)(38100700002)(6506007)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEsyRDFyZHBZYVlCdG9hbENBelh2RHFFcS8xNDdPVGFZNFVXakNzTWVBNm5v?=
 =?utf-8?B?Qmo5MW5KSi8vSmovOU0vRmkrYjhEYlE0R3RnNDVCQ3BieDFFTTdoOXpoNVpI?=
 =?utf-8?B?TmtlVnIyeW9kYkwvUklCNGZIcDBqbGdqaXIyeWdRSFdJY1pXVFYvN2lDZjFX?=
 =?utf-8?B?dklIL3NqTWJBUTJqcTMyOElsR2cwUkxaZVFBNUhDS1M1MnBFc0hZaXhKNXA3?=
 =?utf-8?B?TWtFdzhBWm5udzFXQm1KODBVL0pDbVdPdUVTbWNYaFByKzFBRnZjOHpJU0Vn?=
 =?utf-8?B?UlFEWVFYUWoxbW5QWFlacDNpWEtDRGpNTFJCRjgwK3R2MzRxOSszV3Yydmtr?=
 =?utf-8?B?NUJOSWsrMkFMMTZsdjdZSW9oVGxmNjNvM1A2RjdKOGFGR0JROUUvWDVGZkZt?=
 =?utf-8?B?NmlIMVJxSFgvTXEwV0l4S0xoWGsvV2N1SHlWZnVOSTIxOG5aRnBKUE1vUE81?=
 =?utf-8?B?K2phVjBGR0tJNDIyNE1rQVFDUHhoUXBPL1RHYjZuT1JOZUxQMXhUQWJuV2V3?=
 =?utf-8?B?d1p2Y045aHY0TkQzTW1kTXBiTjhRY09hSUxtbk92SjkxZTk3OXVQNDBOM3VF?=
 =?utf-8?B?cGhWdytjWXExbWVmRXRhTlN5ZU5YWkdUS3ZaWTdya0owM2dxZ05kcDk4YW1F?=
 =?utf-8?B?RlJGUloyK0RuYUVMR1dLcTNWSUZVeFhncnF6N2Q3WDJocW5WVVF6V1A0QkNR?=
 =?utf-8?B?ZHFnL25aL0I2ZlcrdHQ1WjBScHFhanU1dGZ6MmlTUm5yYndydHNESFVkcThx?=
 =?utf-8?B?MWUzZURnamhNeGprUmxRV0RGc3g3ZHpBY2lTU2lKc3BPbjJoZDhYZEp3dXJK?=
 =?utf-8?B?cjcrMGw5aG9aWEtSK3BlMGJ3WFdXdlcvSVVHWVZNbmppbmJYOWNiNVJXVmp5?=
 =?utf-8?B?VHJzb0UzMVA2VFdhVXhEb0t2WTFudUVVTTJxQlZDZUs2cWp2V0lIN09CYm5m?=
 =?utf-8?B?MzlWM2FjMEE5RDk2eW05NDhQUTJFTWVpcWN1M0JjLzFhV2o3ZTRCc09hMDhJ?=
 =?utf-8?B?dTJIZis4ODRNcVVCa0FhSzhPOWJMOW5pUy91R1ZzRjlxZVBOK3VadEs2ekxo?=
 =?utf-8?B?TWJjdkExMDNhaHBHS1UxNmIzaUt6cmVJczFJZnpCRWw1MkxsK1lRTWtveldZ?=
 =?utf-8?B?V2RjWWFCVzBSMDhmNUtKWjA0a0FvNi9xWGx2WmppMjk3YkNsQmJsWjFGeDJE?=
 =?utf-8?B?VzJhcTdJSHNVZzV6SGR1L3JTcHluL21lTXl1VEEwZWlaSzdzWTkvWE1aZFJO?=
 =?utf-8?B?NzdSVGE1UjBpaXRaTDBMS2NlOUdzcFhHeGV6TEUyRGpJczRRcFhiYXoxaHhP?=
 =?utf-8?B?U0x5LzlFVStMbFlGdDBLVGw0UjVGNUF3NzA1SGlPS3VvaHBDdlM0THptTDlO?=
 =?utf-8?B?c1JkTm5BZ2dQaXB2U0FCMndlREE5cmdNdC9nSWdCZE5WbXJiMVFrTlM2UmRy?=
 =?utf-8?B?VFFZTXZVdGRkbVUvOGRZYVlpaVFQbnE1d2hWNHo0Z1R3V3BYTGlEQlpWVzJP?=
 =?utf-8?B?VUVsSkxaRFJDQVV0M2ZBdTE3TUZXeXdVY0JlRTlyRGd3RFloWlpQZ3JKS3NE?=
 =?utf-8?B?UVhTcnhnSVE4Q0NrV1FjdjlFb0JCcWF0MjdUM2lreHdjSmNOVkwvUjJpZGJR?=
 =?utf-8?B?S2N6UGF1UGt3K1YvQWhiZytxNTBoRFNPUm1PVXpmNW56VEZvSlRVZlYvSjVQ?=
 =?utf-8?B?cDJOd2lqUGUrcndBUy9DR1FsQnZudkRTQ0llNDc3SGhoTFY4QW1mNHN2dHM4?=
 =?utf-8?B?dVVCS3dWOWNMaGhwR1pnQVdsY0pjUDJSNUltTUtXZWpwVlc1eFVVU1EwY1dP?=
 =?utf-8?B?Y29YQVgrdmY0a3QvY3lLNHpXRlBhMnMrRjh5NEFjR2JMNHlCTjVZZWY1NUUy?=
 =?utf-8?B?alY4MXFXWTRBc1FJeTVjamFEanA5bjJYQjAwdWtzZkhqY3lIbEd1V0dBMmt0?=
 =?utf-8?B?K2ZuYzA5bkphdkVwdk9wVEw1dThVMjZWUEpkRVNsNFNIYlV1NjNSbjE0UzVl?=
 =?utf-8?B?a2Z1SVdHTWIyeG5nZ0RzUFl6Rm1XVGNKaG1tM3ozbU84MWw2QjVsd2JKSEN6?=
 =?utf-8?B?dVMvb3I3WlF6MXkybGwrTzlWcnJqa0hta3dZWDZrT3ZNaWJEUUROVVZDZHZn?=
 =?utf-8?B?VytYUjI4dmp0ZXdwQ3JYS0pZdmxtbnBTQnpWUDZzUHJHaExGcDV3d3RnUUVN?=
 =?utf-8?B?b0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 032860b4-2260-48ac-0afd-08db88685e20
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 14:56:44.1367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: im1cCuzefW4Ta1+V8caK/9V9I25CucLfPxtrkyomyOqz7MZ2VzIQpW8Hkx9/iKUF4xZSDjnx7jt6Be8sAIzs2RLyj+KPXzXXxuA1+kdxkQM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7642
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2023-07-17 5:00 PM, Cezary Rojewski wrote:
> The goal of this patchset is to enhance existing interface of
> NonHDAudioLinkTable (NHLT), that is, accessing device and format
> configuration spaces as well as adding query functions for finding
> specific endpoints and format configurations. Once that is done,
> existing sound-drivers can move from utilizing sound/hda/intel-nhlt.c
> to this very code and ultimately the former file can be removed.

Hello Rafael and Robert,

Given recent question from Pierre regarding licensing, I've scanned 
acpi/ tree for SPDXes used and must admit that I'm lost. There is a mix 
of GPL-2.0, GPL-2.0-or-later and dual BSD-3.0-and-GPL-2.0. The preferred 
kernel license is GPL-2.0 but given what's out there I have my doubts 
about acpi tree.

Could you provide your insight on the subject?


Kind regards,
Czarek
