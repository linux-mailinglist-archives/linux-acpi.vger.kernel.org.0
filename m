Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5043470472E
	for <lists+linux-acpi@lfdr.de>; Tue, 16 May 2023 09:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbjEPH65 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 May 2023 03:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbjEPH64 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 May 2023 03:58:56 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4475A19B9
        for <linux-acpi@vger.kernel.org>; Tue, 16 May 2023 00:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684223920; x=1715759920;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+fwwM+fhKKiqwB2YtfMQNFfby+XzoCN1EPGEH+K8bQI=;
  b=n9g3SVsH02FPoBuhwFY5leu1eMVyyoGwrayVy+sjwQkoziQsmNf+/mWI
   ccxEsGp+Mimb6Gu3V+yKJqIrMg6SFO7xkCYfoVUdiPwPK0hFMu4WC76oc
   nuzDJ5vZU7Dxo921zsqaBMBsWPFITgi8vn1dBckqZmzN4dG2hxqAb9l+k
   0y1eahNMsjGlsD1LtEloRb4hjkS7LCMWcw79KdaKi9CLGyL+cKXJ/YV6A
   cTcYP7fTBBDZE06y2RGg6KWPeSrSBepHQARQ0DXX6Z63ShynzOsdnVXF+
   1UwdqjQn/Ew5aBIzvvMjN6eXizLxvfWs6yZ3NHHa7G365CTwjilSbGilV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="353689387"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="353689387"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 00:58:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="766282216"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="766282216"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 16 May 2023 00:58:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 00:58:39 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 16 May 2023 00:58:39 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 16 May 2023 00:58:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nd4L8PWdWZzx385apXoIZCCeZNnCL86dzyDDvZ8NfiXzhKK8egU3deFGutApqaH/VTx8xfIcvxMJzT4pY+WvJJAKKSVxD/QJPw2ljoGz4i9QkdoRaEavw8QaiRIgu8izRkoX2GkAVdBOpWCyDktY8u8yCVsYYwNteBCIF0VW3/98413Z8tAmx6pkQAB1ZUe3r+TFsg7w3qmSf2pi3tktA92ie2S5JpENuhM7pTqcP6J4MAsHpWDviDsFeApXl9d10bukJRCJY95L2vu4ggQaJD5eOON0GA4TPqMqzKXFJS6UoSxbGjdF+qo3Y4cViM0hdNUFB37NHY13/LjFwQjNFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IlKKN7FlvkdCcX/rewhzW32aEGQ0r/C1ibp51QbV2oo=;
 b=KQZ3kBbhEwKogWFeIek9anJokkaJrrIjuK90BXAqTrEXPzk6Nu6+mX8a1cYupiakrGI+soeCp34MKLthGa33f9YlGRXHEsaNwcE8nNF7rWOMkRup2gKtS0NlQ4GM++11Ys2aC5jzMx7l2skAe8sSK0O7AOp102mgY86ZXTuwx5R1v3dVBt9+xTKcV6Mhgqmeff++flmWbme7iOCbuZWHw0ia+A4FB4gGtvim4/9nrJ3oyzx3a7KqgCDPR9Fp0qsSg1MgKSR03CpdJojGgShdqJvA7RwW8Pxus1j22c7MPTFafuUijMJ+SClAT/ZwHUYxrULXPwMbkVly1jDEg2eqzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by CO1PR11MB4930.namprd11.prod.outlook.com (2603:10b6:303:9b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 07:58:37 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::b42f:7e57:d100:6c60]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::b42f:7e57:d100:6c60%6]) with mapi id 15.20.6387.033; Tue, 16 May 2023
 07:58:37 +0000
Message-ID: <2952c88c-b06c-2768-af1a-3fe38ba05ff7@intel.com>
Date:   Tue, 16 May 2023 09:58:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v1 07/34] acpi/nfit: Move handler installing logic to
 driver
To:     kernel test robot <lkp@intel.com>, <linux-acpi@vger.kernel.org>
CC:     <llvm@lists.linux.dev>, <oe-kbuild-all@lists.linux.dev>,
        <rafael@kernel.org>
References: <20230512140222.124868-8-michal.wilczynski@intel.com>
 <202305130006.7vOawF8K-lkp@intel.com>
Content-Language: en-US
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <202305130006.7vOawF8K-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0151.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::19) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|CO1PR11MB4930:EE_
X-MS-Office365-Filtering-Correlation-Id: 342620cc-3414-4fc7-0dde-08db55e35a7d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i4vNxJZ7hQiin0+GI/NUglm7TmRh1/DDcYCMCpxWXA1qVkFZMco3XokcSDILeafBEO94eWVw+rhXhVySUv93H3jQ2M+cz7l/wV1dwRIMYZAGRztQh3hzJ6Pjd5OaCKXs9jFttQKrxwF3JglQ0J5Yzt/49iNz89pCUk3X6s6nAKaKlVEZb+5mNpmuZ2QcgwFuEzETPkEUS31yehaBwcQk9bGRFkksLifYCiPQ83P+foviUXUcGFF2DBd70bQ/u9KVhau7mRTL/kYoF13t9+lKLpnq+Y5HP7Vjw3onJd9SfHTThAU49kWQM7yFiJvxLKtZcP0mOOY3UThBex0ftwIJrQajQvoko9nP6YlSzvS1ahZtDCdSw9HzOtzXGq7A24Cfq8YmbBqZSQHARW3lHpIqFLMyLhcNrj72QiaryWuMm/RuJKu90UT7UI6yrHreRTcXJPaOgXTn38tLIgv6IYS0GacKs5pWFxoF7qRf+ZZHsU73L44ka5rbDZ8rPEhaCpUIvxfRcaEpQewTUH8rC9DB38NnWqKMnpNuo1UWj9ioWJpxqZcYIuVlHseDesaqCHvc4K5N6QqrXr21nbL73D2I1mNyfehAfoqldFmUt0JOAc+P1qZAqeSTDjEHl2kEFai78ZNL1hks3+lJB1H/VL+jM2q95Cdb2FJA3P8G6RrArs2d5so2P6OQA+PzcQIQ140b
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199021)(86362001)(31696002)(38100700002)(36756003)(82960400001)(31686004)(2906002)(6666004)(478600001)(6486002)(8676002)(966005)(186003)(66556008)(26005)(8936002)(53546011)(6512007)(6506007)(316002)(66476007)(2616005)(5660300002)(41300700001)(66946007)(4326008)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVBOYm1UMUcveU5XSytsblF1OFNDN3dITTg1SWdZdGdiN1VaUGFCVlB5R1Z6?=
 =?utf-8?B?Rnh1ZU5LYko5RjVMLzZUOWdEYTIxcTZidkhPSWpHbnFscEQrV2svUEtpemRu?=
 =?utf-8?B?Y0tsS1FCaFFYWUNaN3d2QUZHYkFmaklSVGJtR0hGZjRHTElSSmpUUlhaZTdp?=
 =?utf-8?B?em9iK3lLZTlPeTVLcmhkNVJHWUJJcTR2NmNiajV0M0pIK3o4OVlhS2FzT0dx?=
 =?utf-8?B?Smdra1ZtbE9OdWRNb0VoeHZQUS8xUXREeVZhUHlTb3h3MzZsSmtzSk9LdFM0?=
 =?utf-8?B?UXVONDNJQ2VuKzB5cVlNWTN2Mmp6d1o1dG12Z1Y5dHJkT3d5L0Q0RFhkdWdI?=
 =?utf-8?B?WTZGT2tOSlVHZXNoSG5WTlRDYUxZMERNYlNuaFBYdzFhVWVlT2FLaGRSV2ln?=
 =?utf-8?B?MUIyU1BXTW9tNm9TSTE4dUpCRUkrVWNuS1Job1N4Y1pQMGtHaG1PR2I2UzFP?=
 =?utf-8?B?b1hBODRpeE5PcUNqVitTRlRiMHkzNVAxRDQ4aHE1QWZ5dUNYVHliUVRWTm5h?=
 =?utf-8?B?K2hqRzBrSGN2cjZ4UkJHQThGVEh0aUF5eUZVZmg3K2c4ejJBRmoySmtEbGZ0?=
 =?utf-8?B?R3VzYkt2TTlIbGtxTE1BbjN4MS9FS1AvaHA5MmgwcHNpK0pRU0U1amsvN1Bw?=
 =?utf-8?B?RE16NWRBQ3VsWDczQmRuVEV5bXZpUXpLSUdMdzBVVUN5czJVS1NKbHpUdXlQ?=
 =?utf-8?B?aGZxVFN4QkNoRDF3ZnZHZ200MDRsOHM2UkdxeDRqbnV5cm5WaWtRVlh1ZjhS?=
 =?utf-8?B?NnR1UGVTRndONm1oRGJoN3FnVURsbEQ3T2c4bzVZSEM3ckZOcGdJR3NBdlE2?=
 =?utf-8?B?VlBvZVYyWGI1V3dsS1ZpZVErUG5YM3lWcFlFaVRJQTVKcFdBM0wyS1dVT0h6?=
 =?utf-8?B?b3g0dkdIcHhyZjRJTStXSzU0R0h6dE53UGNPeFh4SHg1VTdQWlRrRnMrUUw0?=
 =?utf-8?B?c1IrYzdQN3JuMlNOR0s3YkJ4NzNmUnVSdlJFeGZVVjFvR2ZDRGZyL2dIbW5Z?=
 =?utf-8?B?ckdIOHV0VjhudUJSWWdGd044d256OGg4OElmSFhJVVNvWnFnZDl0bUJzcGRH?=
 =?utf-8?B?V0IwblJINlo4RitLZUpzYXZOamx0R2U2ZXAxM3dGYzR2cnVFZTZKejUxaDBG?=
 =?utf-8?B?c1AvWVgva1phamw1ZFlsdlJiUFltWUtZYzFnWndTRGJQRXlPWFRLZTNha2RW?=
 =?utf-8?B?Z294a0ZyYXNPcy9GKzV2OSsxbzEwOE9MbkQxc3lESjRhMTM1K0xTVW5nd3Q1?=
 =?utf-8?B?Ti9ZMmtzMlVoK2hObEk5d3dvOVZZNm1tYkJ2Y2I3Tmx2ODdRVGZSSlBJQXlS?=
 =?utf-8?B?MU1zaHpPRlJuMTg5Q0VYZ3NZSVJyakJzQis2Z0xUVk82WkRRYmFLclFaRWI0?=
 =?utf-8?B?U2hvTVBua3J6cStGM2F1SE1VNWRhOUpQbGdhNHpTT2JGV3UrZEFMZlgrMFlw?=
 =?utf-8?B?WFQyZkRNNnVCM29lR3FCclFXMExwdmRTdmtFUWtxK3hPOXc2WUNSSW4yRlJw?=
 =?utf-8?B?N2cxdnI1THZIRnpJKzVPWGFhNUVrV0lRb1lZNkJVYy8zejZHdEs1SGdFSFhE?=
 =?utf-8?B?S1hyL2gvRS93aTdWTFZOT2g5TnFkZjR0S3YxQXkzVVR6dXRGVnR0emFlb1JE?=
 =?utf-8?B?Tnppc1Q3TXcrNk1YSXVLNmJqZWEyalU0Smg5cjJqZStZeDRzLzloYnNzdW1Z?=
 =?utf-8?B?MWdlSGdhL05TOC95QXFLQzJjYVQvdzYzT3Rka1lDUG4vSW8xZ0x1Z0hxVXFI?=
 =?utf-8?B?WlJqQ2RrZEtBZ3c2UzYzZ0wwcWU1NTdIT2JxOEltM3ZFdmovOFpVRHp2OEdz?=
 =?utf-8?B?Q00xSE1JOTNKZzBaaWx6Qk5yemNwTWErSTVyMEpUNXFLcHg4YVFUK1hSU3Vn?=
 =?utf-8?B?b0NoQmEyeUk2Wjc3SVVRZStEazJSMEdIc3cyaUlSMVZNVkIwR3V2eUpSVHFE?=
 =?utf-8?B?VmZzTFFHcThyVVFhQ0p2UDZHYVNxS1JBUUlDZnVZSGxVU1NmenpOVWV0NTZE?=
 =?utf-8?B?QWZFZjRBN0s3UGJrVUtXczRSS0JaWGlaMVJraU1ZVzBiWkdFbVRuMVdZaE9h?=
 =?utf-8?B?TC9Pc1hEcFRaKzZvaTR3YjMreCtRL2VhcFh1TUEwcVpZVVEyVG9LQlhBRFJN?=
 =?utf-8?B?WFRuQmFsc1BpbGd6UWdBbjJ1TmdPVE5VL3lvQVdzTS92Skh2OXAxdTh0aEpH?=
 =?utf-8?B?MXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 342620cc-3414-4fc7-0dde-08db55e35a7d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 07:58:37.0722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tubnt7GLXeG7HwCD7DHBWD2ZY8mPCQYOTGfR7iUOyx0WpNYd8MtJ6EgAx4yDU9VllJ1QXIpDVYX4ymakmffjqeePX4C/MH/zwaqaep4wtes=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4930
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 5/12/2023 7:11 PM, kernel test robot wrote:
> Hi Michal,

Some of the drivers that I modifed weren't switched for compilation in my default .config file.
That's why I haven't noticed some of the compilation failures. Will take .config from here
https://download.01.org/0day-ci/archive/20230513/202305130350.ZEskVtFO-lkp@intel.com/config
fix the errors and re-send v2.

Regards,
Michał

>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on rafael-pm/linux-next]
> [also build test ERROR on chrome-platform/for-next groeck-staging/hwmon-next linus/master v6.4-rc1 next-20230512]
> [cannot apply to jic23-iio/togreg nvdimm/libnvdimm-for-next nvdimm/dax-misc crng-random/master]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Michal-Wilczynski/acpi-Adjust-functions-installing-bus-event-handlers/20230512-220607
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
> patch link:    https://lore.kernel.org/r/20230512140222.124868-8-michal.wilczynski%40intel.com
> patch subject: [PATCH v1 07/34] acpi/nfit: Move handler installing logic to driver
> config: arm64-randconfig-r032-20230511 (https://download.01.org/0day-ci/archive/20230513/202305130006.7vOawF8K-lkp@intel.com/config)
> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project b0fb98227c90adf2536c9ad644a74d5e92961111)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm64 cross compiling tool for clang build
>         # apt-get install binutils-aarch64-linux-gnu
>         # https://github.com/intel-lab-lkp/linux/commit/2f0865bfe3ea129ced1df996b1f80fb5d44133e8
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Michal-Wilczynski/acpi-Adjust-functions-installing-bus-event-handlers/20230512-220607
>         git checkout 2f0865bfe3ea129ced1df996b1f80fb5d44133e8
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/acpi/nfit/
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202305130006.7vOawF8K-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    drivers/acpi/nfit/core.c:1717:13: warning: no previous prototype for function 'nfit_intel_shutdown_status' [-Wmissing-prototypes]
>    __weak void nfit_intel_shutdown_status(struct nfit_mem *nfit_mem)
>                ^
>    drivers/acpi/nfit/core.c:1717:8: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    __weak void nfit_intel_shutdown_status(struct nfit_mem *nfit_mem)
>           ^
>           static 
>>> drivers/acpi/nfit/core.c:3376:43: error: use of undeclared identifier 'device'
>            return acpi_device_install_event_handler(device, ACPI_DEVICE_NOTIFY, acpi_nfit_notify);
>                                                     ^
>>> drivers/acpi/nfit/core.c:3376:71: error: use of undeclared identifier 'acpi_nfit_notify'
>            return acpi_device_install_event_handler(device, ACPI_DEVICE_NOTIFY, acpi_nfit_notify);
>                                                                                 ^
>    drivers/acpi/nfit/core.c:3381:35: error: use of undeclared identifier 'device'
>            acpi_device_remove_event_handler(device, ACPI_DEVICE_NOTIFY, acpi_nfit_notify);
>                                             ^
>    drivers/acpi/nfit/core.c:3381:63: error: use of undeclared identifier 'acpi_nfit_notify'
>            acpi_device_remove_event_handler(device, ACPI_DEVICE_NOTIFY, acpi_nfit_notify);
>                                                                         ^
>>> drivers/acpi/nfit/core.c:3457:15: error: use of undeclared identifier 'adev'
>            device_lock(&adev->dev);
>                         ^
>    drivers/acpi/nfit/core.c:3458:22: error: use of undeclared identifier 'adev'
>            __acpi_nfit_notify(&adev->dev, adev->handle, event);
>                                ^
>    drivers/acpi/nfit/core.c:3458:33: error: use of undeclared identifier 'adev'
>            __acpi_nfit_notify(&adev->dev, adev->handle, event);
>                                           ^
>    drivers/acpi/nfit/core.c:3459:17: error: use of undeclared identifier 'adev'
>            device_unlock(&adev->dev);
>                           ^
>    1 warning and 8 errors generated.
>
>
> vim +/device +3376 drivers/acpi/nfit/core.c
>
>   3314	
>   3315	static int acpi_nfit_add(struct acpi_device *adev)
>   3316	{
>   3317		struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER, NULL };
>   3318		struct acpi_nfit_desc *acpi_desc;
>   3319		struct device *dev = &adev->dev;
>   3320		struct acpi_table_header *tbl;
>   3321		acpi_status status = AE_OK;
>   3322		acpi_size sz;
>   3323		int rc = 0;
>   3324	
>   3325		status = acpi_get_table(ACPI_SIG_NFIT, 0, &tbl);
>   3326		if (ACPI_FAILURE(status)) {
>   3327			/* The NVDIMM root device allows OS to trigger enumeration of
>   3328			 * NVDIMMs through NFIT at boot time and re-enumeration at
>   3329			 * root level via the _FIT method during runtime.
>   3330			 * This is ok to return 0 here, we could have an nvdimm
>   3331			 * hotplugged later and evaluate _FIT method which returns
>   3332			 * data in the format of a series of NFIT Structures.
>   3333			 */
>   3334			dev_dbg(dev, "failed to find NFIT at startup\n");
>   3335			return 0;
>   3336		}
>   3337	
>   3338		rc = devm_add_action_or_reset(dev, acpi_nfit_put_table, tbl);
>   3339		if (rc)
>   3340			return rc;
>   3341		sz = tbl->length;
>   3342	
>   3343		acpi_desc = devm_kzalloc(dev, sizeof(*acpi_desc), GFP_KERNEL);
>   3344		if (!acpi_desc)
>   3345			return -ENOMEM;
>   3346		acpi_nfit_desc_init(acpi_desc, &adev->dev);
>   3347	
>   3348		/* Save the acpi header for exporting the revision via sysfs */
>   3349		acpi_desc->acpi_header = *tbl;
>   3350	
>   3351		/* Evaluate _FIT and override with that if present */
>   3352		status = acpi_evaluate_object(adev->handle, "_FIT", NULL, &buf);
>   3353		if (ACPI_SUCCESS(status) && buf.length > 0) {
>   3354			union acpi_object *obj = buf.pointer;
>   3355	
>   3356			if (obj->type == ACPI_TYPE_BUFFER)
>   3357				rc = acpi_nfit_init(acpi_desc, obj->buffer.pointer,
>   3358						obj->buffer.length);
>   3359			else
>   3360				dev_dbg(dev, "invalid type %d, ignoring _FIT\n",
>   3361					(int) obj->type);
>   3362			kfree(buf.pointer);
>   3363		} else
>   3364			/* skip over the lead-in header table */
>   3365			rc = acpi_nfit_init(acpi_desc, (void *) tbl
>   3366					+ sizeof(struct acpi_table_nfit),
>   3367					sz - sizeof(struct acpi_table_nfit));
>   3368	
>   3369		if (rc)
>   3370			return rc;
>   3371	
>   3372		rc = devm_add_action_or_reset(dev, acpi_nfit_shutdown, acpi_desc);
>   3373		if (rc)
>   3374			return rc;
>   3375	
>> 3376		return acpi_device_install_event_handler(device, ACPI_DEVICE_NOTIFY, acpi_nfit_notify);
>   3377	}
>   3378	
>   3379	static void acpi_nfit_remove(struct acpi_device *adev)
>   3380	{
>   3381		acpi_device_remove_event_handler(device, ACPI_DEVICE_NOTIFY, acpi_nfit_notify);
>   3382		/* see acpi_nfit_unregister */
>   3383	}
>   3384	
>   3385	static void acpi_nfit_update_notify(struct device *dev, acpi_handle handle)
>   3386	{
>   3387		struct acpi_nfit_desc *acpi_desc = dev_get_drvdata(dev);
>   3388		struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER, NULL };
>   3389		union acpi_object *obj;
>   3390		acpi_status status;
>   3391		int ret;
>   3392	
>   3393		if (!dev->driver) {
>   3394			/* dev->driver may be null if we're being removed */
>   3395			dev_dbg(dev, "no driver found for dev\n");
>   3396			return;
>   3397		}
>   3398	
>   3399		if (!acpi_desc) {
>   3400			acpi_desc = devm_kzalloc(dev, sizeof(*acpi_desc), GFP_KERNEL);
>   3401			if (!acpi_desc)
>   3402				return;
>   3403			acpi_nfit_desc_init(acpi_desc, dev);
>   3404		} else {
>   3405			/*
>   3406			 * Finish previous registration before considering new
>   3407			 * regions.
>   3408			 */
>   3409			flush_workqueue(nfit_wq);
>   3410		}
>   3411	
>   3412		/* Evaluate _FIT */
>   3413		status = acpi_evaluate_object(handle, "_FIT", NULL, &buf);
>   3414		if (ACPI_FAILURE(status)) {
>   3415			dev_err(dev, "failed to evaluate _FIT\n");
>   3416			return;
>   3417		}
>   3418	
>   3419		obj = buf.pointer;
>   3420		if (obj->type == ACPI_TYPE_BUFFER) {
>   3421			ret = acpi_nfit_init(acpi_desc, obj->buffer.pointer,
>   3422					obj->buffer.length);
>   3423			if (ret)
>   3424				dev_err(dev, "failed to merge updated NFIT\n");
>   3425		} else
>   3426			dev_err(dev, "Invalid _FIT\n");
>   3427		kfree(buf.pointer);
>   3428	}
>   3429	
>   3430	static void acpi_nfit_uc_error_notify(struct device *dev, acpi_handle handle)
>   3431	{
>   3432		struct acpi_nfit_desc *acpi_desc = dev_get_drvdata(dev);
>   3433	
>   3434		if (acpi_desc->scrub_mode == HW_ERROR_SCRUB_ON)
>   3435			acpi_nfit_ars_rescan(acpi_desc, ARS_REQ_LONG);
>   3436		else
>   3437			acpi_nfit_ars_rescan(acpi_desc, ARS_REQ_SHORT);
>   3438	}
>   3439	
>   3440	void __acpi_nfit_notify(struct device *dev, acpi_handle handle, u32 event)
>   3441	{
>   3442		dev_dbg(dev, "event: 0x%x\n", event);
>   3443	
>   3444		switch (event) {
>   3445		case NFIT_NOTIFY_UPDATE:
>   3446			return acpi_nfit_update_notify(dev, handle);
>   3447		case NFIT_NOTIFY_UC_MEMORY_ERROR:
>   3448			return acpi_nfit_uc_error_notify(dev, handle);
>   3449		default:
>   3450			return;
>   3451		}
>   3452	}
>   3453	EXPORT_SYMBOL_GPL(__acpi_nfit_notify);
>   3454	
>   3455	static void acpi_nfit_notify(acpi_handle handle, u32 event, void *data)
>   3456	{
>> 3457		device_lock(&adev->dev);
>   3458		__acpi_nfit_notify(&adev->dev, adev->handle, event);
>   3459		device_unlock(&adev->dev);
>   3460	}
>   3461	
>

