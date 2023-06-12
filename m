Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1F672D04E
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jun 2023 22:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjFLUQU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Jun 2023 16:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjFLUQT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Jun 2023 16:16:19 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C29E41;
        Mon, 12 Jun 2023 13:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686600978; x=1718136978;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zD8qPi2bj3wsHObDWm+NE++czlKstz95f8eNGSITSnw=;
  b=Gw3e3wYA1VK/Luc2oc4zuoToaEbj13Twg0xJ6x/rvIcO4Vl+ffHTOEFW
   hrgtMtz3qqtc+/0GyYHSnR2zDOEeU3ec/sVvJPlC5pHb+m6wm5dgVAyAn
   V/7d1EyPWtd43f51MqnjK0MtC3ATa10bL2jdnZZlRAWV0Lezhuym+meKd
   x40TXm8wF23FZp26szegu9U33wLcOSOZjOFEuW7DwAmu+ByrOta4e2GDu
   AufEUlN22hZGwnO1uIheMC6gYhzydJFUVcsyg0ELgWf1Ao9nfzqOdpP1K
   L4CrIcfgtBd/lpIO5lTppED4VAGmjiAkSnFqzs67Y45W1aMdevBlC0BqP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="421741660"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="421741660"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 13:16:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="801152567"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="801152567"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Jun 2023 13:16:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 12 Jun 2023 13:16:16 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 12 Jun 2023 13:16:16 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 12 Jun 2023 13:16:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k30UmzKHlKY2+452haSFUb/NbaK5SYMYBTKpsiu2+N4cGTYKf7CP2btfqB5zlhFcSift/h5rEqByZtRo1aOBGkmNqNWMqmJ8mgWGCn7xwArivDjfGup/js1T+5HKdafZ0uks/5G93W0hH0YoXPn5tuJXki2B8WKGp+WaTjMHH4cik5gyd7zXsddXmGhHPepYbSKKpsUsH39ZHUhffWdtNrSvgzeb61iVnG6S64THDiWQvNSiV0Z6Gwznjm8mW4IohTwktb9D4Z2zypEzSA4Kbuj2i123dvtImptSVoUmjvIyZgznRrQpMcHgxoKfS0Ieo9nkfO6sWvo10APWLejPrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zXswKC1PAeiQeUXc6vyhK/c94Y2vISb4Ush2lXOamic=;
 b=Rpff43HG0MrkIeMMCBaC7jFbFKxmGb2IFLjBfUb7fztxtZhnm5qtpFGkMuT+dl9mzw4s0e4LqNrkSWSinjIXD5bARLX3WjjZVpJyfguwoGEFYi7kKH3U63xkioWWFyfGlCktIiCyYyZRZt5+O980ND9FI9pT6GWKnTgRzr3BDKXtiaGVvHXPQ5Dqiw76CWp5+DO97gPlOiVtdljJg+uVdyu4PaHZWi3pUav9JCZ/siX8Qjx6Ya6sIOdrlcVIS9j20Xr0X6fiPxPPdJPMDmZGguZCoxjGWc+EFL36Oy0NUGY70Z9Qqoua0tj+23zYZjoSTg5lVZDGa7ItRs0hl8oskQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by PH7PR11MB6883.namprd11.prod.outlook.com (2603:10b6:510:202::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 12 Jun
 2023 20:16:14 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%6]) with mapi id 15.20.6455.043; Mon, 12 Jun 2023
 20:16:14 +0000
Message-ID: <346823be-adbe-940b-f46a-7fd110618873@intel.com>
Date:   Mon, 12 Jun 2023 13:16:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.0
Subject: Re: [PATCH v3 0/4] acpi: Add CDAT parsing support to ACPI tables code
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        Len Brown <lenb@kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <lukas@wunner.de>,
        <Jonathan.Cameron@huawei.com>
References: <168565502116.1098279.131831312990693128.stgit@djiang5-mobl3>
 <CAJZ5v0gbSN5K1Q_Afsr9T3WGadg6zphGsz6ATavmiXVmRMPWcw@mail.gmail.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <CAJZ5v0gbSN5K1Q_Afsr9T3WGadg6zphGsz6ATavmiXVmRMPWcw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0133.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::18) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|PH7PR11MB6883:EE_
X-MS-Office365-Filtering-Correlation-Id: 0da9f88f-a628-44c5-6264-08db6b81df28
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qnMu+BmrfCiX6zWGhzcWX/hgGGpHKzxsD7G+UaWcWAGC8aogGuGsKecBDJ+2hPcvqXzFbXLD2yDBE/S8eaUWITUHGt/c394Pf07cLx8sWuyv09lK/j7j44TLzb7dSgqyxf5n6RrsDT6Acy3SNERwvh9aS+zdWk97HCXH3yoF0kMIXieViXoa9BxsKnXIXFHji92IFXQVvF7uOOSZFn9rk9GLaarANcpbRZtZqiVZCh4qCi8XHh3buJMCuXXN7dkzBSkSqHfLpiTFDh1C5GS2m7cIShe4MWtnVCasodSC+G3c29mc0/t5p1IHHF5i6VOEUvC2UBZ3YZnll1DQnJ/YSqT6uxJ7BcQgd4ltYqHmrQY35oIpbyJXWjZYYlZMbbAtq8uqa6uW4cLjNifKA14Pa44RFhioJWN42PRcb+11Y0sS0fzDoxIAdCz/vs1unM8kK3xPxD7ToiDvoWFhxcz1zElYM20tgVMeS+A12HorMTMzy8YYfwUE4DjC9AARNYigbWfG7BhlgPYVJxASFsWsqJ1invuSk2ICundi5Pdo+4ma0A6u8/CAYbxSN0hyTvPGK/faLxqw11fu79y93K31Vorp+gZOvlMY3pkfu69L0KkebvZSSXxqwD0Uzub7uYwbe3JkFhSt580agSmN0zM5SeAwJXKtsTRxC4xnKwo6poA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(376002)(366004)(39860400002)(451199021)(966005)(6666004)(6486002)(478600001)(26005)(6512007)(6506007)(53546011)(83380400001)(186003)(36756003)(31696002)(38100700002)(86362001)(2616005)(82960400001)(31686004)(5660300002)(8936002)(8676002)(316002)(41300700001)(2906002)(4326008)(6916009)(66556008)(66476007)(66946007)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDRoRUU5SjVXQmFaM3RtbityRzI2QUdTWmNmVlBOSm5Db2xBTVJMZHdQeWdT?=
 =?utf-8?B?WGFwMm8rSE4yMUJXaXRUK1Z4bEQ0QzEyME9WZHlyVkxUdFdUUmJvQlFUNEhn?=
 =?utf-8?B?LzcvWldZSFV6Mi9HVlc1ZnBhKzkrMDlOZFJxNDJ2cHhyQVo5RW1ESmNGalNI?=
 =?utf-8?B?SW14bDhzcGpuallGeFpDd2JRMENZL2FFdmlPcnl6WmN6enRmUTd0M21uZnJz?=
 =?utf-8?B?RmQwVzdHUDV4blRUZmI3cmYzNU5aV0l6bWg2T2hLZVBiSFJuNE9lcFByU1pV?=
 =?utf-8?B?bnpIWnMyZ3RzaFAxYm4wYmxFUG5RUjFBMVNtRkI4NitzWFNOSDJwNHppeFdR?=
 =?utf-8?B?WENRWXlxTXkwZHZvRzlLWlpIbk9UZFFnUGQxM0oyZXpGRnBtTjBZQVhLYjFX?=
 =?utf-8?B?bzFDbG9hNS9mZTMyQ3VjUkVKVVk0eVRzdE1EUWNDVTJvUUxFUFJLc0E0ak5P?=
 =?utf-8?B?R3hLYm1jRmhhbmxXQnZ5ZytZWktHV1pPODVXTnlybFI1b0dDd3R6THBTd3hD?=
 =?utf-8?B?UmxtT3lWMFFydmI3SjM4L1F4d2lPVTFkaFVWeEF3NGpHMGdqd1gzNDJnODkz?=
 =?utf-8?B?Q2pKODA1VDdmZlBTUFBWNGd6Vmt3RU15RGZSa0RucldmZTN4RmlycGh1Z2NJ?=
 =?utf-8?B?akY2T1p3Z0xGUGMzK0ZVN2FDUmNuVUdtbFdFeWlUVkhwdnpFZ0FucXVZM1J3?=
 =?utf-8?B?K1ZGUDg5OEUwUVkvcCtabkJtK0JiYk5YaXhVd2dRclF2VmhxL3ZpdkFaTFlY?=
 =?utf-8?B?QlZCQlNSWVJGdTBobnZ1b0NxRldNVGliNWJQVUJORjNiRlVFK0s0L003bXZq?=
 =?utf-8?B?dnpRTW5IOGFGWFhGYWlUVDhubDkvRWh1b29FT2h4c1lTZlI0dWpiOWZSdnda?=
 =?utf-8?B?cGdub3pnVjJTNWRnWG0wbW1RbHlwaXkwVXlsSWFHY3c0Tzd1TnY4YVRXdC9h?=
 =?utf-8?B?aXBqelowUVM3cVpGbjZxUWNNbEdFY2ppazZVcjRjRG1md2lPdHRMSGk4QUha?=
 =?utf-8?B?WTVzYnpJS1pMcWR2VkR3NGp2djVmVnlQOVFYRTFocnZrZUFiS3VoNDBzVDZR?=
 =?utf-8?B?SXg1MDB1VEFLbUVpdEJaWUZOeURQNHd0czFOQmdBU2VScFhQNDQ5bm1yZjVX?=
 =?utf-8?B?YysvWHRRMWxQWkFTUEJjejdCbkNUWlh0YW1xMWtHZ3pCTWJIT21OTVJZY2pw?=
 =?utf-8?B?bGt5aUN6VW1SY2lRN1MwbW91UWZ6ZGozeVczdFFuWGVLeHJIdFBuTmdVSnpV?=
 =?utf-8?B?VU85NUVjYmsxdzdONTRaQTcvQlN1OHVnWG52TjZXY1lQUVQ1RXZHZWd3VW1m?=
 =?utf-8?B?REJZdVZ5UGpLTlFWMDZMaVBUR05XbjlxdUVWYUFnbUtzRmdKWlhUVzNpNHpX?=
 =?utf-8?B?KzNLMkJJNFhVVmNaMXBIT3B0MjFOWi8yejdPT3I5R0VvMVN1VUFZalZqQ2Fw?=
 =?utf-8?B?cTc5am14SEZkd0U3aDZMUUQyY2IrM2lEZ09BRW9GOU1Fc0ZYMlBITVc2OEk4?=
 =?utf-8?B?MlcveWJIMW91OVI3U3dpSjE5dVFqOE50d0xXT3B1T3luQ3YzUjNRcVl4NGJE?=
 =?utf-8?B?NkdiN3dURTJaU0ZvNGkwdXJRVUdYaHY2NC9oZlNRSUxNUGpSU01rZ3hBdHFI?=
 =?utf-8?B?U0VWMzZtSGdCUW02STUyK2NENnpQeWlWUGMrUnoxRElYejMwMUI4V2t4d0NV?=
 =?utf-8?B?SnVWcGZKKzhrd1BUcWhCVWJGNkt3cDNtMVpzU1FHWUdaK1lMVzlRSFUzOWhy?=
 =?utf-8?B?ajBxT3c3b1M1d1RFNmNsZkJyQ1V6dDg1WGdaN2lCQTlkeXpSODB6MnJXMlpp?=
 =?utf-8?B?Nis4MGx0Tm1yODFnT0tucnNvS3MvREwyUXNhRlB3WlhaZ1diRm9PN2RqaW84?=
 =?utf-8?B?bUhFMkVsalc4YldwMkhCSkkvYXR1RmhZUE42Q0EzNWlSS1dhRlE3blhxMkZF?=
 =?utf-8?B?a1RYTjhTeXVTWS9lY2lDWk9jdDBBbUtCU2lWMVZISkxIbUpUempWRmNJNEwv?=
 =?utf-8?B?dERBNXRMb1BsbFdmOUk2RmFWQW9aWTg0OU1DV0ZNZjkwNDJSejlRNG1YeXdN?=
 =?utf-8?B?dmN4RWIwcTdVYWdNM3BheDlRN0dmSGRpKzVSSisvbGpGQUtJWSt0dFdBUDlx?=
 =?utf-8?Q?7sF3386p/XKk5OW0LYwxEoAS4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da9f88f-a628-44c5-6264-08db6b81df28
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 20:16:14.4034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C1mxhboVdN9VeaLHmdgWkvvtKlDw/9kIBIhJiLGvnJK0PnXikfoVeutymh7ymBoOCxX5cC+VHjEmtWI0XGE40A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6883
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


On 6/4/23 09:09, Rafael J. Wysocki wrote:
> On Thu, Jun 1, 2023 at 11:31 PM Dave Jiang <dave.jiang@intel.com> wrote:
>> v3:
>> - Move common code to lib/fw_table.c
>> v2:
>> - Split out with CONFIG_ACPI_TABLES_LIB to be independent
>> - Fixed 0-day issues
>> - Change CDAT releveant names to prefix with cdat/CDAT instead of
>>    acpi/ACPI. (Jonathan)
>> - Make table_header a union with cdat table header instead of
>>    'acpi_table_header'. (Jonathan)
>> - Removed ACPI_SIG_CDAT, already defined.
>>
>> Hi Rafael,
>> Please consider ack these patches. Dan can take these through the CXL tree. After
>> attempting to rename the cxl_ prefixes of functions and non ACPICA data structures
>> to something more common, it seems that significant amount of ACPI code would be
>> touched for the rename. For this series I left it alone in order to have the minimal
>> changes to ACPI code.
>>
>> I've broken out the "cxl: Add support for QTG ID retrieval for CXL subsystem" [1]
>> series in order to make it more manageable. Here's the first part of the ACPI
>> changes. These changes are added to allow reuse of ACPI tables code to parse
>> the CDAT tables. While CDAT is not part of ACPI, the table structures are similar
>> to ACPI layouts that the code can be reused with some small modifications.
>>
>> However, in order to be properly utilized by CXL users, the tables code needs
>> to be refactored out to be independent of ACPI. For example, a PPC BE host may
>> have CXL and does not have ACPI support. But it will have CDAT to read from
>> devices and switches. I have created CONFIG_ACPI_TABLES_LIB in order to allow
>> the common code to be independent. 0-day seems to be happy now for all the
>> different configs and archs.
>>
>> 1/4: Split out the common code from drivers/acpi/tables.c to lib/fw_table.c
>> 2/4: Add CDAT support
>> 3,4/4: These two are minor patches that has ACPICA impact. Has been merged into
>>         the ACPICA git repo [3].
>>
>> The whole series is at [2] for convenience.
>>
>> [1]: https://lore.kernel.org/linux-cxl/168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3/T/#t
>> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/log/?h=cxl-qtg
>> [3]: https://github.com/acpica/acpica/pull/874
>>
>> ---
>>
>> Dave Jiang (4):
>>        acpi: Move common tables helper functions to common lib
>>        lib/firmware_table: tables: Add CDAT table parsing support
>>        acpi: fix misnamed define for CDAT DSMAS
>>        acpi: Add defines for CDAT SSLBIS
>>
>>
>>   drivers/acpi/Kconfig     |   1 +
>>   drivers/acpi/tables.c    | 178 +----------------------------
>>   include/acpi/actbl1.h    |   5 +-
>>   include/linux/acpi.h     |  22 +---
>>   include/linux/fw_table.h |  52 +++++++++
>>   lib/Kconfig              |   3 +
>>   lib/Makefile             |   2 +
>>   lib/fw_table.c           | 236 +++++++++++++++++++++++++++++++++++++++
>>   8 files changed, 302 insertions(+), 197 deletions(-)
>>   create mode 100644 include/linux/fw_table.h
>>   create mode 100644 lib/fw_table.c
>>
>> --
> I think that this series can go in via the CXL tree and I'm expecting
> ACPICA to make a new release including the counterparts of patches
> [3-4/4] shortly.
>
> Please feel free to add
>
> Acled-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> to the series.

Thank you Rafael!


> Thanks!
