Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38527560DE
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jul 2023 12:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjGQKst (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 17 Jul 2023 06:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjGQKss (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Jul 2023 06:48:48 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC7611C;
        Mon, 17 Jul 2023 03:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689590926; x=1721126926;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=u+svsdPmWoyfD+uVtw13kH/BUEfYMbFh24w2YgZJHeQ=;
  b=D9iRvMoUdsLzoH1F7l/xzKXpfm5xeDMgijmfpKC6l2iN4mVk20otDzu5
   oKgAXL3LLQOqY4EwrrfCE7DR0xY/P6yn+iTpHLIOAGwllFaArQ7Vdx2DM
   KiWggB1ekrI/JfzzPRIK7FEEMNNKP4H//Pun5d+OvFHh9brLL5TvxSQCl
   H4A3Sc1T4GnvAPTkU9keqfWGm5rOR5l43rEpaOv2SCVDbXjnUVnhXhVM7
   zARJf6n/dJaFiBQ/e0xcSu9y6PQ3OO4t+wkWMRUVKGljA8RzGppalySbN
   0Nto3mwxsRxSxbWJ4Bc59VoumI46UKsq0rqs6J5VxQ3QrlLbRkg8w9vpf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="345489211"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="345489211"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 03:48:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="813273620"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="813273620"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Jul 2023 03:48:45 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 03:48:45 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 03:48:45 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 17 Jul 2023 03:48:45 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 17 Jul 2023 03:48:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+W1uiLYRlcjRqsjAM+ZySDgWJ/QgN0aFKwVG/bfWtOQnkh3s1VlaZMG6O7En9bq1o6pjPOYJP+Wsz2aO82YqrvSZTcsV0Vjb74EuVZcw8msVZbP35Tb0Yn+nNlm7kkUI2wM9JDTODNCu82J1QMkLa5tarRskRo0uZ1nMtmPKXian1sUnlpWyi7cjRSCm/GEPL5AuIm/IoR40XYI29CLUmdbOuiipUxBcEP5T7cdAhGwtY4cLNPRsjDXh46ehVk3Ok8NANpkUOAjg/KipjhizEi4VOOfll0GwtQWbHdxzPD5cQlWXMh32UBuuqrfu5xo6Rhu9JRrOdCeP/zTNFGjXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=32Vv+VPrZNjkMQLwelAarF9iRrr9RfCTfuLi0ZuTgk8=;
 b=CJSY944Mm216qTHs0xCvV54dEZ2hM18bACshFJs3FLYTaVqKJ/RuWTDxjvmuc4YXFIZl7kRNfn0DKp4du5aPnum4dbreBQ8H6cLZcJjkbSmZrmJpm/4US6vIQlc8EORBTSOjiHAZl3OJ04JpCFt2XO1AKCRKe8nfqN6M0gfOqFpI3gPrhnqwyJqLvKjOGFuh0xGG/A0Xv/kc8T85c+WwNdjLU0fxk7LsoZx8hq9dUJeDh8WtWOHRQIFKK0hdGqac1ei+KpScBfCR2RksA45tfuwR5i+Uk0mp5nMZxbYJdJMNKrkJIIuZP7GmO4Nsdg240UlvY8AL9KJJvjpBT6fO/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by SJ0PR11MB5813.namprd11.prod.outlook.com (2603:10b6:a03:422::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 10:48:42 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::5f7a:95cd:9d79:aafd]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::5f7a:95cd:9d79:aafd%5]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 10:48:42 +0000
Message-ID: <6f8d0187-0a90-1fa2-61e9-0a7b9a44106e@intel.com>
Date:   Mon, 17 Jul 2023 12:48:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [rafael-pm:bleeding-edge 22/40] drivers/acpi/internal.h:161:
 multiple definition of `acpi_early_processor_control_setup';
 drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>
CC:     <oe-kbuild-all@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
        <devel@acpica.org>, <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <202307150637.CGq9exEE-lkp@intel.com>
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <202307150637.CGq9exEE-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0293.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8a::8) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|SJ0PR11MB5813:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b21455e-b5f0-4fc0-d35c-08db86b3631e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OtRIofO1nUw8YTn7NEEfxjjj/gZEAMaFxkgfbQebJZILk3KaUbC4Kb2SNaBlGRyMKMkzgShsZMjfec4JnePLIPkOZwZHqnqit1rJRTX24CAXZkc8W/WCTasiY1UkGmTERfZhD6TX75HDpNmX83wlrnt7pec3Pb8GlNFGYQ3i4WpQgZS56XwyxJiYOke3fucrYmjXaity6WWN9JDLf1AHTQbaop4Ss4vf9GHkU/Sw9PDll3KZyne1BB8IZvm/70kLWd06W0816II6ujNE2AoHmfRqNYRQG9fpuEMnhx4qmBsyA5qz/StUyGPz3ybcqqW4V0shkxuLJffUKJWNoWDl90+ORmed0JMAFUTSXrme4tT14dpHQQK8yjkI+W1wuGbY7Lb/MzoHGgvuNS7WmbSv9JWmH/UNEzJVku9rCYfX2HqT/MGbwrRH0hTwImnFYHoKphujVu2fpc0cXGB9U7NrUTdkAMjg7hEUJ03Qn6kdofNWg7UC5oS1nzMOvNj6behU8yr8Q61gIVukDubjnzIeGXPj6kh+59QgrMdYZ6C1s/OtMM1+T4rjF0lNfCl37yb9qpzqkfE7GqcGY4bK2Vi15Ley1WR4yn0KGCzhjJIUUc3EP2ZC/4I7MUOzQruy1ncCABlwU2dEOiF8lLo7YTbqqlnDOZpZ4P2jwcHrJkljHyz4TtNia05bp9Vs8ih7YVARavOjECWdnT2SxsQvh5UAbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(366004)(376002)(346002)(136003)(451199021)(31686004)(83380400001)(478600001)(6486002)(186003)(31696002)(2616005)(86362001)(26005)(6506007)(6512007)(966005)(53546011)(66556008)(66946007)(6666004)(38100700002)(54906003)(41300700001)(37006003)(2906002)(36756003)(82960400001)(4326008)(6636002)(8676002)(6862004)(316002)(5660300002)(8936002)(66476007)(81973001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEY5aHkzTGZoN3gzd242VDBFUmxLMkwzYW9PWCtxMnc1Um41Tnpjeml3L21a?=
 =?utf-8?B?emhlSEE4Wkg3ZVMvY3pNeS95aGJUWXN1V2MzeUZCeEQvOW9tdUtxR1dObTdz?=
 =?utf-8?B?OTZkM2o3Qm9VcDJsbmRQVHYrMHpoWG8vM0JqRGJUOVpQYmg1dC9CZE8zd3cw?=
 =?utf-8?B?eW50ek50cUhGSXJZVnpTUVBOb2xybUxDVkxyck52NHI0OVhndjZQUDRTZ256?=
 =?utf-8?B?Yy9PTG5RT2lmeTRzK292SVd4dGJnUStReHVNRzRwTWhzSWdkV3pKcXlXY1gy?=
 =?utf-8?B?UmZHUlcvRU5Vb2wzaTNyS0ZWL2JHR0QwZGt6cFd2SkYzYmM4V2RSSzVzTit4?=
 =?utf-8?B?N29KKytOUEhsMkl6dHNQVEhRS1ZmaksvR3dyT1lwUzlXdlRpZ3dnamlwblgy?=
 =?utf-8?B?SWFnN2xIQnVnWmRvQytSWVhML1ZuMVpQVEI0QXo1QmFNa2tZSnBRM2dkN2pB?=
 =?utf-8?B?YkYyQ3BOejJPQS9EY2RJMEo0UmxWSmc1d29XZzdRaVB3a0ZtRTJkRldyajk0?=
 =?utf-8?B?bWRsbGRrN1FjeWpSWkJ6R3Y1ZndBRTB5SnYrSENwRzVLTjZoQW5wUVZaeHZ6?=
 =?utf-8?B?eEZHY3FFV1V3TU5zaUpJUmJFR1VTQy81K0lnemtnUE0zd0hkTThlQzNpVWVh?=
 =?utf-8?B?V2Zjcm9ub2pUMlNOdWczK0c2MUVxc0VjQlBCVUcwMmhIcloxVTltbkU4djNp?=
 =?utf-8?B?NFV2Qm8wSktsTG1PMytSSjE3a2JpYUNmcmlySnBScCt1cUhESmlzZFd0R2ds?=
 =?utf-8?B?MUdjYkU2dW85T1Q4R25CSytDeW5HNkdkejk3VTEybVZpSDhwcjlZYlo5R0Uv?=
 =?utf-8?B?Rys5SWJvYnlGaVByNFIxNUU2Z2pZK3FnbHdUencydkxQd3pMMDduc2E3aFQr?=
 =?utf-8?B?a2RmcDF3dGFlNWJTbjYrZ1BibEx2alorSlpDckdGTmVuRGJ1NUZsZGlldnRW?=
 =?utf-8?B?ZjVzWXQzR0gvSUQ0T2VSVWtHa21EOU9IeU03b2J2OGZXaUxhSGZMaVRHaUZY?=
 =?utf-8?B?cCt2ZTM5VWNobGpCSVRKUUlzbW81TU5WL2ZxYzE3ZkVETlk5WGNHaXZKSmF6?=
 =?utf-8?B?RXY2Z0xza1o2d2NHSW5NbVdycGxKTlpsVXlaVTRnTDVoVkFzK3N2UHRBSnB4?=
 =?utf-8?B?Y05mb0hBRWdQY1N1UkVTWTNtVGpNRGJ1aEJ1NmJOMWhkWGNUdVovMitoVUNM?=
 =?utf-8?B?U0ZWN3ZNdzJRcjJibGNpNDFNVE8yWTI0QWhoZzVDNVhJM3BVTUFJTGJPTjZT?=
 =?utf-8?B?SVZ4ZEd0OWlTNWNicm1qUUgrSjJwTXBXVVRqWmdkYm40WjltSm1WaUE0VVdL?=
 =?utf-8?B?VDhJSUk3L1ZJTWVaaXlGbG92K2c3L3cwc3BvajAwTmQ2VmJmbzYrVlJPalE3?=
 =?utf-8?B?TElQd1hLL0drdStMamxYRjVYcytxRkxGbHpyODlSSm1NY1pabUdTd1YycHFB?=
 =?utf-8?B?OFRkNWxrM0NBVHRyaC9YNlBYZm5ReXp1ZmZXWUd2YkN3aXh1Z3ZqQTBHR3Jz?=
 =?utf-8?B?TWhLNTI4SmdHOWlpc2lIQS9uOUdpcCtiUmNhdEZ4dVFuUnp3Y25VWWJ0TFhy?=
 =?utf-8?B?Y1Eyb3hQWkRpSzZBUTNnU3lSUzViQlFOSTdHaytUWUFERitwTWxMSFlNWDJu?=
 =?utf-8?B?c3UxNXErU1VQS1ZPZmNOVzZ6emRKNkdJSytTMW44S3l0VWpMRnF6MjVVejlK?=
 =?utf-8?B?aDdma1IwZllnZ1VhdHY3b1dZcEp1WDNSaTRMWFdKR1VlZHRnQ1hBbHMySFRK?=
 =?utf-8?B?VFBsWjZobUZaZS95R2hWUi9wdjdRSjE0UW1hbVdEMWhOU0FjY1NwYkluTk9s?=
 =?utf-8?B?b0pydUZqQVk2UmFwVFZPMWpNRWNJQ24yYzUrTTZqWkZLT2lRY3NHR1dPV2Ir?=
 =?utf-8?B?RGdCSC94R0lVdS94ejhxOGJHbVFsRXM2UVNSWGFFOXFUY0M0alN3YVRKL1Ft?=
 =?utf-8?B?c1hxVlVib2NVNXZGM0lQUmFaaEtpRzVYYThUY09pWUp1dnd6Q1h0ZTVRSWlE?=
 =?utf-8?B?bnhZYXcyNklUYy9DbjluOG44S0ZpcFNmcFFwMnJlN0NIekpoT0V4U01qbHY0?=
 =?utf-8?B?RVhBcE13ZjVjckZwYjFoUm9zQ0JHNzBYQzFtTm85dGhHL1VWWjBLNE9wYUY5?=
 =?utf-8?B?Ky9sWFpzWjZWNDRGeEI1eElUM3BKbkgrcms0aFYzbXY4MEVOeDNoR3dlb2sx?=
 =?utf-8?B?NEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b21455e-b5f0-4fc0-d35c-08db86b3631e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 10:48:42.5861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dAt3qQy9dhQPi4d5KRXFoE3uXDLXkUqKiogzoXZZ4uX5PJBYXJkxBYZM/QN1SlhgGB7E1L/38Lp4ohBPKOS4IS7Pc5BLpX13XlDi7PGdLjw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5813
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 7/15/2023 12:47 AM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
> head:   4f9dd7927c1cdbaffb20fcdbcc2bdc6caa0b4736
> commit: ca805e0f04a5f9a773875ad6de914e54e41d43c7 [22/40] ACPI: processor: Use _OSC to convey OSPM processor support information
> config: arm64-defconfig (https://download.01.org/0day-ci/archive/20230715/202307150637.CGq9exEE-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 12.3.0
> reproduce: (https://download.01.org/0day-ci/archive/20230715/202307150637.CGq9exEE-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202307150637.CGq9exEE-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    aarch64-linux-ld: drivers/acpi/osi.o: in function `acpi_early_processor_control_setup':
>>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
>    aarch64-linux-ld: drivers/acpi/osl.o: in function `acpi_early_processor_control_setup':
>>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
>    aarch64-linux-ld: drivers/acpi/utils.o: in function `acpi_early_processor_control_setup':
>>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
>    aarch64-linux-ld: drivers/acpi/nvs.o: in function `acpi_early_processor_control_setup':
>    drivers/acpi/nvs.c:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
>    aarch64-linux-ld: drivers/acpi/wakeup.o: in function `acpi_early_processor_control_setup':
>>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
>    aarch64-linux-ld: drivers/acpi/device_sysfs.o: in function `acpi_early_processor_control_setup':
>>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
>    aarch64-linux-ld: drivers/acpi/device_pm.o: in function `acpi_early_processor_control_setup':
>>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
>    aarch64-linux-ld: drivers/acpi/bus.o: in function `acpi_early_processor_control_setup':
>>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
>    aarch64-linux-ld: drivers/acpi/glue.o: in function `acpi_early_processor_control_setup':
>>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
>    aarch64-linux-ld: drivers/acpi/scan.o: in function `acpi_early_processor_control_setup':
>>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
>    aarch64-linux-ld: drivers/acpi/acpi_processor.o: in function `acpi_early_processor_control_setup':
>>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
>    aarch64-linux-ld: drivers/acpi/ec.o: in function `acpi_early_processor_control_setup':
>>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
>    aarch64-linux-ld: drivers/acpi/pci_root.o: in function `acpi_early_processor_control_setup':
>>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
>    aarch64-linux-ld: drivers/acpi/pci_link.o: in function `acpi_early_processor_control_setup':
>>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
>    aarch64-linux-ld: drivers/acpi/acpi_lpss.o: in function `acpi_early_processor_control_setup':
>    drivers/acpi/acpi_lpss.c:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
>    aarch64-linux-ld: drivers/acpi/acpi_apd.o: in function `acpi_early_processor_control_setup':
>>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
>    aarch64-linux-ld: drivers/acpi/acpi_platform.o: in function `acpi_early_processor_control_setup':
>>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
>    aarch64-linux-ld: drivers/acpi/acpi_pnp.o: in function `acpi_early_processor_control_setup':
>>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
>    aarch64-linux-ld: drivers/acpi/acpi_amba.o: in function `acpi_early_processor_control_setup':
>>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
>    aarch64-linux-ld: drivers/acpi/power.o: in function `acpi_early_processor_control_setup':
>>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
>    aarch64-linux-ld: drivers/acpi/event.o: in function `acpi_early_processor_control_setup':
>>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
>    aarch64-linux-ld: drivers/acpi/sysfs.o: in function `acpi_early_processor_control_setup':
>>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
>    aarch64-linux-ld: drivers/acpi/property.o: in function `acpi_early_processor_control_setup':
>    drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
>    aarch64-linux-ld: drivers/acpi/debugfs.o: in function `acpi_early_processor_control_setup':
>    drivers/acpi/debugfs.c:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
>    aarch64-linux-ld: drivers/acpi/processor_driver.o: in function `acpi_early_processor_control_setup':
>    drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
>    aarch64-linux-ld: drivers/acpi/container.o: in function `acpi_early_processor_control_setup':
>    drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
>    aarch64-linux-ld: drivers/acpi/acpi_memhotplug.o: in function `acpi_early_processor_control_setup':
>    drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
>    aarch64-linux-ld: drivers/acpi/dptf/int340x_thermal.o: in function `acpi_early_processor_control_setup':
>    drivers/acpi/dptf/../internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
>
>
> vim +161 drivers/acpi/internal.h
>
>    157	
>    158	void acpi_proc_quirk_mwait_check(void);
>    159	bool processor_physically_present(acpi_handle handle);
>    160	#else
>  > 161	void acpi_early_processor_control_setup(void) {}

I think this should be
static inline void acpi_early_processor_control_setup(void) {}

Hopefully you could amend this commit ? Not sure why 0-day haven't
caught it sooner.

Regards,
Michał

>    162	#endif
>    163	
>

