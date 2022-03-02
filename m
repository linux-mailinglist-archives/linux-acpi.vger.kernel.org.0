Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C024CA1E5
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Mar 2022 11:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234663AbiCBKNv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Mar 2022 05:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238123AbiCBKNu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Mar 2022 05:13:50 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5666124BC3;
        Wed,  2 Mar 2022 02:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646215987; x=1677751987;
  h=message-id:date:subject:references:to:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=U3sRH2aYu3EmIKgpMuj+/TBvfWUBy8LeAnukXu172Yo=;
  b=NiKelsPVsM5oblI1PFVIBQYRR9fNpbJmUaiM6Q25LqkLWvya0KK2NwQ9
   thPVow0m5e5OCTaHZ9gY7gvUlFP6OyXKcBu6Vp4NGj1n70HoWPqX5xZ6c
   pS9d3QgZY71ofs37paSQV4usLtobEpcnVa2H74DCumkw/DsVt3m8Qt33w
   OjTRX76khVPACF73fxQW2TFxHoIGf52yOTp7jNt73shwr1NWhssLuobZ4
   TW1y2SJdHqO5JrUGjmqa/b0TeEB7LAh55RDNlAB8pAJd8RpZSA+O95M/+
   ZfPWzEvLb6PQflYxcuEXV7pT8JeplAXWUCHsDhoacE4leJJslIiUa8jNq
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="253291764"
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; 
   d="scan'208";a="253291764"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 02:13:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; 
   d="scan'208";a="593959080"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga008.fm.intel.com with ESMTP; 02 Mar 2022 02:13:06 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Mar 2022 02:13:06 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Mar 2022 02:13:05 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 2 Mar 2022 02:13:05 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 2 Mar 2022 02:13:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KAUPDBRvBqagtZDwZbhiX/5gIBXJsgqOGol692bEbVucGAn7g0GyWg4jWdqmkkvdiP8mEaf5fWdPbjmWoDmKJkFf9KMFkny61Pq4Zo+1pP2S4E3VXgA3JN/BasvP5Vmp4XzmMCr7XWMNuOkojhmY2JLjT5SCme1UBzYlJvPP6FIVlR9XJh1DFWgCdKwya4OQUnKPayaaYFjzgChu0DLogQHTda5ULGgaFMNW2hmqGR8sFA2iHI13+gBi7rIAUOu1OaHk7wnrfLZ94MIqR/SqA5S2172Baq45Kfhg9Gra73el7VuzGJlTBwGwhLHjZyR0Emv23Ld5wfvhI6jOQC/BNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rvoTzx0ZMTKNvI+FjDCyz/MZj0ngarYzcO6AgvNVlps=;
 b=gjqsoBfjdHU6xuI9urUWKEsnAnfYUQWMZCEoFXDZwCZbEkqeMord1jCtiMpJDLQoXPj8JO4XNRvoouspKeVi/+Oc2NtVdzBLExhJVbGdeUTucCB1TCIIw7Dea28t5GknJrcok7bbliDtkAkGYfDVhUDA/Fa6hNssCvqc1wntz7znQXNc9fkCx0OclEQH4WNHBykn6wxQrWhb5iDmJVCOueH2bAxg5jNrhoXz3Ng3blhAdR96JPY5RqkZL4vj4Ju7ySn9iI4e9brlexprD3Ut8gsFJRYQd5rlOeU41aWGF1+DATvBHIDkyXco+EEooRC+uZv3AflftSH4+vrR5dsAOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12)
 by SJ0PR11MB5662.namprd11.prod.outlook.com (2603:10b6:a03:3af::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 2 Mar
 2022 10:13:00 +0000
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::c4a2:d11d:cb7b:dc8d]) by SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::c4a2:d11d:cb7b:dc8d%9]) with mapi id 15.20.5038.014; Wed, 2 Mar 2022
 10:13:00 +0000
Message-ID: <473f9d8d-0d1a-7c54-e6c1-a39aa1f3d8a5@intel.com>
Date:   Wed, 2 Mar 2022 18:12:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.1
Subject: [rafael-pm:bleeding-edge 113/118]
 arch/x86/kernel/acpi/boot.c:1476:22: sparse: sparse: excessive elements in
 array initializer
References: <202203021316.r0hMgV0f-lkp@intel.com>
Content-Language: en-US
To:     Mark Cilissen <mark@yotsuba.nl>
CC:     <kbuild-all@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>,
        <devel@acpica.org>, Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hans de Goede <hdegoede@redhat.com>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202203021316.r0hMgV0f-lkp@intel.com>
X-Forwarded-Message-Id: <202203021316.r0hMgV0f-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR0302CA0005.apcprd03.prod.outlook.com
 (2603:1096:202::15) To SJ0PR11MB5598.namprd11.prod.outlook.com
 (2603:10b6:a03:304::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d133ffb-4afc-42b7-430e-08d9fc353b23
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5662:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <SJ0PR11MB56623C568D6FE4FCCA4A9C97FB039@SJ0PR11MB5662.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X8ShRW5GOJDUOqlF8aQ3aSgzBKNgF9ycztSwww5M+p/wUbViYTxmM4aId5VhgqWwrHIUYMV8Vn0hLazTeQMlsdPJAsGLlmnVSAWobRaUoSXpHrWR5nWtBzj6vA9GBiJkkt58kTD/ec8mj+EHxiiXFjUHFA8YKQGAyvIGqNmNjAYiAeNyjc1dc/1LBI/FPnjsY2RzqAHK93R2x5ddwlLzsWqxa3yiK2ZtlNqOR1tiwIghRPBIRXBuLgJAmjCoIfdiuuuqLyBG39oImJjqWs1IqVVIxEvck1Om7MWVFu2ihv4Wsvs/whFU35iFX0mGkQp2xK3LMrFAhwyE4FRiVFN5+HMWhImyRY1fPYhvvE0b1V+yb+PZGOHeqWC1AYV/2gGJB1JMKkxvixqj+0dOKJzsU2ATHVUEO8MiAzB63kdrKkylWSKIIc79TSLHDLdGGBuLzS3pqYo0/iXQcvrN9hzQ9GSJ3q0GBHLM8AEs/u2Kefqr9wx2+500bkIPD56BhnKurJIZdFeFvpVbIMxlpoo2tY3VE+N2ePgho0xXAMDMbIIcsIZbqCCx8CDJN1l3yvN42+/+KgxU5qaNL7n/gHXxnkfErNcdMGRC4hRXUiW7ZTDU5DM3+RYQ7m8TJouo4g+6N0olj1tGcGWQSF/hSd4xoPzxdw7hOg33XSujO/bWnZl0G0KgU/aASSPz0TZ2Z/2zayiXOBRgZ1mXgRDoJX8yO1Tx+TFxdbHjv4fNzFtytCZvtvbwTp7nFB2F067GPS3pASA5fP1+RHTL6sSEx5FwfJRFBKTe5JMVdgefJVrrsAmACFt+l6425rYq2OS83BKbKgj+n4nW7q+11Mhd2AxJZkFYJ6HKNhIZQHiLoDKRmi4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5598.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(2906002)(8676002)(36756003)(4326008)(2616005)(8936002)(186003)(26005)(66946007)(508600001)(6666004)(6506007)(6512007)(38100700002)(31696002)(66476007)(66556008)(86362001)(31686004)(82960400001)(966005)(5660300002)(6486002)(6916009)(316002)(54906003)(30864003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUxaM3R4OHR2VHF3elNuamxza2p6Qk9zTzFYaTV5U2daUVh5cFhRWFVyVnZs?=
 =?utf-8?B?bXQ5ZWx3N1ZQL3lnSCthNUFBVEhtTVpjaStGWDVlRXd5KzhVRGdIQXlsYzVh?=
 =?utf-8?B?RUdKcjQzQ1RGK2N1Z0hpNkw5cEJSS3ZGeXRsbVRmSEVCNU14OFNITmNrcGsx?=
 =?utf-8?B?U3k5MjBuTWF0eXhVZGptUHI4VUYrcTZhWktqVlJxSTAvL0dGTXd3MThyY1pa?=
 =?utf-8?B?RkZLOEpPVzAvaHZSSExKK1FzSHJ2N2VhNCsxSm1FUkdWQVl0RWNhT09Jb2p1?=
 =?utf-8?B?TmpLZVNaN2ZVZVBKODNSWVdndTJMY2d1VE1WbU1HYXB2Y1pjeDJlV2UrekFM?=
 =?utf-8?B?NnBiZzdpMDBkOUlra1NSQnFsYWQ3VEdlR2NBSXdYMzcrcWM3OWQ3N1hlTzNC?=
 =?utf-8?B?c2EyekMzOE95WmRycjdKZWtGbTNGQzh6M2VDTjA1QlBKMk42VnJkb21HZGly?=
 =?utf-8?B?Q2x2NUVIekY3WG5ieC9DZnRwWFVOU1RxcmVaTytsakhkd0U5VkpDWE51R3dx?=
 =?utf-8?B?bEpudnRkdFI1OEJ5MnU2YVFqNGRXUXNXR1hDSCtwdUJVSlFjU29ZUUxnN1Yz?=
 =?utf-8?B?MHlsWkoxeXltc3FLY3NWSHRNY1ZhTUNyU0pYaDFQY2R2MmRrdzZubzRDVzFv?=
 =?utf-8?B?QTIrWS9yNW9Kd2NrTkJ4U2xwUS8yeWtybmlCQ1pVblQvdkRDNjg0Zjk5NE51?=
 =?utf-8?B?YXlrN01sSXczOVI3V3BuMDgvN3VTamkzbldVTHRIUWRDdXJPSTRpV2xOUGZ6?=
 =?utf-8?B?TjIwVlgyNHhoV2RYdWk4NTZWck5zSFRVcGRDcDdOempIa0xvSHEzd2FZT2RH?=
 =?utf-8?B?YnpTdElST3FtYlRiU1F3V1FyVUdPM2xIdGIxeWFKOXFuT2NXc3p0dmNJWEoy?=
 =?utf-8?B?Um1lcThvZEI3cEc5VFB5R3ZWTlFLK1QxNk9yTDl6ODk0dFpmcUxNdXV5Y0JT?=
 =?utf-8?B?c2RFYVpVY2kxcU1zdUdwUjFGU0VLMVBLK3NNZlJnVHdBaWRybFRubDFFMVIw?=
 =?utf-8?B?RFdoZDUyV2Znb0lzd1pCWnZ5dUJwRDRMZVhFeVgxOXZLOWc3WlhRV1ZkSWFF?=
 =?utf-8?B?UjBVMWd3SnlmSjhBMXcreGp1ejJtTHJQRk1nU3grMU9HcnNXY1NBQ0k5aWFJ?=
 =?utf-8?B?R0NPUVkwNUFJYlA1RStlT3BhdWtrZnJaT1RrbDRYaGVSK1FTSVFHWjZvNmZN?=
 =?utf-8?B?Vk5XZm1RQmExOUxSNWlXQXZycSt5RnRuUTZuOEtPT2craGV5UHAxU2hMZ2JM?=
 =?utf-8?B?U0FxT1lVS0ZwNnhESS93azhPT3BNbTRocVY4NFJTczRiUTQrazVYdXFkY25X?=
 =?utf-8?B?dDUrRExUQnhDcmV3bnNEZHl4N0d4Qzd3dFI0Y01mSjBFTEp3dlRrRXVabEl3?=
 =?utf-8?B?enVWRjBadjFEc1c0dlhUQXl2KzlrdVFoS0VRRjJWWmZ6eGpqK2wxdkxSajdu?=
 =?utf-8?B?S0owSG1uSktubmxPbW1UZEdzMkZWaTF5dTNtYUVNOElhcWVOeldwNFJPYmxU?=
 =?utf-8?B?MFZKMk5zTEtTNDVvaEx4TlF3anh6a2F3cmpCRU9DV2V6WlM3d0RNWW5GeXJB?=
 =?utf-8?B?VEdTTDhZcFRIL0FrMERkeng4cWRZdlpWaFRUc21QbndMblljQXBRaDFPYUZY?=
 =?utf-8?B?U0tLdFVVTFhwbmNDL0tpUHVBbWlkQTJrNWp2cUxUU0Q4ZUlaZmZNWVEyc04w?=
 =?utf-8?B?THI3aWFXQU85UE1qMTNRNkJEVnNESnBTejBDRzJJK2dCODlTUWRzOWhLVW5j?=
 =?utf-8?B?cVF3aFFrWWgrdm5pMTczUEdHaTgzNFRXVUd2QXZIMndZM2liZURpQXRweTZa?=
 =?utf-8?B?bXZ5d0pBM0hzeXF6WVVwVmZQWmJKckx4R0ErSmFaSldiUnllMWpENGRaVk4y?=
 =?utf-8?B?Z1VyY1JWQW13aHZaS042ODkvb0UvRTN0ZUdKWWVWMzBGWDltNVpDR1FUYWJT?=
 =?utf-8?B?QnZ1WHRaVlh0bmFKNXZwSWlaQzFOT2lNOWpwdWQxZTNNNDBDdWJxMEJRUy9v?=
 =?utf-8?B?emRac2YwanM1OWh2d2wyUSs2RFBGZGI0M2tsQmllTTNaenlWTUdURktFbmcw?=
 =?utf-8?B?Njk5TXphdDBqbHhKV21taU9UZGJva0picXNpMGlwMUlUYVBRUVprQmErendP?=
 =?utf-8?B?U2x1eXZZdmQ5dWlCd1l0TnY2SXUxZ1BMdHc3ZzNCWnBwbWI2QXFRT1RFbHNF?=
 =?utf-8?Q?NsljShRLoIQUGLAabk+faHc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d133ffb-4afc-42b7-430e-08d9fc353b23
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5598.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 10:13:00.8093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1dv9kiCh3qXVoQO3KcAQH/bTiohrmEkF8H+yObYNF0O3arSMARCH+JyNyeE9uQYF76RXDImCzpkCkKyJkf8SNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5662
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   f7307721a01f4f14d21c699b270a870370cf34b9
commit: ed00b2b8d737f87a2437d7bd7c7f90124b50da05 [113/118] x86 / ACPI: Work around broken XSDT on SEGA AALE board
config: i386-randconfig-s002 (https://download.01.org/0day-ci/archive/20220302/202203021316.r0hMgV0f-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
         # apt-get install sparse
         # sparse version: v0.6.4-dirty
         # https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?id=ed00b2b8d737f87a2437d7bd7c7f90124b50da05
         git remote add rafael-pm https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
         git fetch --no-tags rafael-pm bleeding-edge
         git checkout ed00b2b8d737f87a2437d7bd7c7f90124b50da05
         # save the config file to linux build tree
         mkdir build_dir
         make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/kernel/acpi/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <yujie.liu@intel.com>


sparse warnings: (new ones prefixed by >>)
 >> arch/x86/kernel/acpi/boot.c:1476:22: sparse: sparse: excessive elements in array initializer

vim +1476 arch/x86/kernel/acpi/boot.c

7486341a98f2685 arch/x86/kernel/acpi/boot.c  Li, Aubrey        2015-03-11  1389
aea00143a8db8c0 arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1390  /*
aea00143a8db8c0 arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1391   * If your system is blacklisted here, but you find that acpi=force
5b4c0b6fffb91b0 arch/x86/kernel/acpi/boot.c  Zhang Rui         2009-04-01  1392   * works for you, please contact linux-acpi@vger.kernel.org
aea00143a8db8c0 arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1393   */
6faadbbb7f9da70 arch/x86/kernel/acpi/boot.c  Christoph Hellwig 2017-09-14  1394  static const struct dmi_system_id acpi_dmi_table[] __initconst = {
aea00143a8db8c0 arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1395  	/*
aea00143a8db8c0 arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1396  	 * Boxes that need ACPI disabled
aea00143a8db8c0 arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1397  	 */
aea00143a8db8c0 arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1398  	{
aea00143a8db8c0 arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1399  	 .callback = dmi_disable_acpi,
aea00143a8db8c0 arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1400  	 .ident = "IBM Thinkpad",
aea00143a8db8c0 arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1401  	 .matches = {
aea00143a8db8c0 arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1402  		     DMI_MATCH(DMI_BOARD_VENDOR, "IBM"),
aea00143a8db8c0 arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1403  		     DMI_MATCH(DMI_BOARD_NAME, "2629H1G"),
aea00143a8db8c0 arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1404  		     },
aea00143a8db8c0 arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1405  	 },
aea00143a8db8c0 arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1406
aea00143a8db8c0 arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1407  	/*
aea00143a8db8c0 arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1408  	 * Boxes that need ACPI PCI IRQ routing disabled
aea00143a8db8c0 arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1409  	 */
aea00143a8db8c0 arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1410  	{
aea00143a8db8c0 arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1411  	 .callback = disable_acpi_irq,
aea00143a8db8c0 arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1412  	 .ident = "ASUS A7V",
aea00143a8db8c0 arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1413  	 .matches = {
aea00143a8db8c0 arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1414  		     DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC"),
aea00143a8db8c0 arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1415  		     DMI_MATCH(DMI_BOARD_NAME, "<A7V>"),
aea00143a8db8c0 arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1416  		     /* newer BIOS, Revision 1011, does work */
4be44fcd3bf648b arch/i386/kernel/acpi/boot.c Len Brown         2005-08-05  1417  		     DMI_MATCH(DMI_BIOS_VERSION,
4be44fcd3bf648b arch/i386/kernel/acpi/boot.c Len Brown         2005-08-05  1418  			       "ASUS A7V ACPI BIOS Revision 1007"),
aea00143a8db8c0 arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1419  		     },
aea00143a8db8c0 arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1420  	 },
74586fca38109d2 arch/i386/kernel/acpi/boot.c Len Brown         2007-03-08  1421  	{
74586fca38109d2 arch/i386/kernel/acpi/boot.c Len Brown         2007-03-08  1422  		/*
74586fca38109d2 arch/i386/kernel/acpi/boot.c Len Brown         2007-03-08  1423  		 * Latest BIOS for IBM 600E (1.16) has bad pcinum
74586fca38109d2 arch/i386/kernel/acpi/boot.c Len Brown         2007-03-08  1424  		 * for LPC bridge, which is needed for the PCI
74586fca38109d2 arch/i386/kernel/acpi/boot.c Len Brown         2007-03-08  1425  		 * interrupt links to work. DSDT fix is in bug 5966.
74586fca38109d2 arch/i386/kernel/acpi/boot.c Len Brown         2007-03-08  1426  		 * 2645, 2646 model numbers are shared with 600/600E/600X
74586fca38109d2 arch/i386/kernel/acpi/boot.c Len Brown         2007-03-08  1427  		 */
74586fca38109d2 arch/i386/kernel/acpi/boot.c Len Brown         2007-03-08  1428  	 .callback = disable_acpi_irq,
74586fca38109d2 arch/i386/kernel/acpi/boot.c Len Brown         2007-03-08  1429  	 .ident = "IBM Thinkpad 600 Series 2645",
74586fca38109d2 arch/i386/kernel/acpi/boot.c Len Brown         2007-03-08  1430  	 .matches = {
74586fca38109d2 arch/i386/kernel/acpi/boot.c Len Brown         2007-03-08  1431  		     DMI_MATCH(DMI_BOARD_VENDOR, "IBM"),
74586fca38109d2 arch/i386/kernel/acpi/boot.c Len Brown         2007-03-08  1432  		     DMI_MATCH(DMI_BOARD_NAME, "2645"),
74586fca38109d2 arch/i386/kernel/acpi/boot.c Len Brown         2007-03-08  1433  		     },
74586fca38109d2 arch/i386/kernel/acpi/boot.c Len Brown         2007-03-08  1434  	 },
74586fca38109d2 arch/i386/kernel/acpi/boot.c Len Brown         2007-03-08  1435  	{
74586fca38109d2 arch/i386/kernel/acpi/boot.c Len Brown         2007-03-08  1436  	 .callback = disable_acpi_irq,
74586fca38109d2 arch/i386/kernel/acpi/boot.c Len Brown         2007-03-08  1437  	 .ident = "IBM Thinkpad 600 Series 2646",
74586fca38109d2 arch/i386/kernel/acpi/boot.c Len Brown         2007-03-08  1438  	 .matches = {
74586fca38109d2 arch/i386/kernel/acpi/boot.c Len Brown         2007-03-08  1439  		     DMI_MATCH(DMI_BOARD_VENDOR, "IBM"),
74586fca38109d2 arch/i386/kernel/acpi/boot.c Len Brown         2007-03-08  1440  		     DMI_MATCH(DMI_BOARD_NAME, "2646"),
74586fca38109d2 arch/i386/kernel/acpi/boot.c Len Brown         2007-03-08  1441  		     },
74586fca38109d2 arch/i386/kernel/acpi/boot.c Len Brown         2007-03-08  1442  	 },
aea00143a8db8c0 arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1443  	/*
aea00143a8db8c0 arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1444  	 * Boxes that need ACPI PCI IRQ routing and PCI scan disabled
aea00143a8db8c0 arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1445  	 */
aea00143a8db8c0 arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1446  	{			/* _BBN 0 bug */
aea00143a8db8c0 arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1447  	 .callback = disable_acpi_pci,
aea00143a8db8c0 arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1448  	 .ident = "ASUS PR-DLS",
aea00143a8db8c0 arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1449  	 .matches = {
aea00143a8db8c0 arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1450  		     DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
aea00143a8db8c0 arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1451  		     DMI_MATCH(DMI_BOARD_NAME, "PR-DLS"),
4be44fcd3bf648b arch/i386/kernel/acpi/boot.c Len Brown         2005-08-05  1452  		     DMI_MATCH(DMI_BIOS_VERSION,
4be44fcd3bf648b arch/i386/kernel/acpi/boot.c Len Brown         2005-08-05  1453  			       "ASUS PR-DLS ACPI BIOS Revision 1010"),
aea00143a8db8c0 arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1454  		     DMI_MATCH(DMI_BIOS_DATE, "03/21/2003")
aea00143a8db8c0 arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1455  		     },
aea00143a8db8c0 arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1456  	 },
aea00143a8db8c0 arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1457  	{
aea00143a8db8c0 arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1458  	 .callback = disable_acpi_pci,
aea00143a8db8c0 arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1459  	 .ident = "Acer TravelMate 36x Laptop",
aea00143a8db8c0 arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1460  	 .matches = {
aea00143a8db8c0 arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1461  		     DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
aea00143a8db8c0 arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1462  		     DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 360"),
aea00143a8db8c0 arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1463  		     },
aea00143a8db8c0 arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1464  	 },
ed00b2b8d737f87 arch/x86/kernel/acpi/boot.c  Mark Cilissen     2022-02-23  1465  	/*
ed00b2b8d737f87 arch/x86/kernel/acpi/boot.c  Mark Cilissen     2022-02-23  1466  	 * Boxes that need ACPI XSDT use disabled due to corrupted tables
ed00b2b8d737f87 arch/x86/kernel/acpi/boot.c  Mark Cilissen     2022-02-23  1467  	 */
ed00b2b8d737f87 arch/x86/kernel/acpi/boot.c  Mark Cilissen     2022-02-23  1468  	{
ed00b2b8d737f87 arch/x86/kernel/acpi/boot.c  Mark Cilissen     2022-02-23  1469  	 .callback = disable_acpi_xsdt,
ed00b2b8d737f87 arch/x86/kernel/acpi/boot.c  Mark Cilissen     2022-02-23  1470  	 .ident = "SEGA AALE",
ed00b2b8d737f87 arch/x86/kernel/acpi/boot.c  Mark Cilissen     2022-02-23  1471  	 .matches = {
ed00b2b8d737f87 arch/x86/kernel/acpi/boot.c  Mark Cilissen     2022-02-23  1472  		     DMI_MATCH(DMI_SYS_VENDOR, "NEC"),
ed00b2b8d737f87 arch/x86/kernel/acpi/boot.c  Mark Cilissen     2022-02-23  1473  		     DMI_MATCH(DMI_PRODUCT_NAME, "Bearlake CRB Board"),
ed00b2b8d737f87 arch/x86/kernel/acpi/boot.c  Mark Cilissen     2022-02-23  1474  		     DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
ed00b2b8d737f87 arch/x86/kernel/acpi/boot.c  Mark Cilissen     2022-02-23  1475  		     DMI_MATCH(DMI_BIOS_VERSION, "V1.12"),
ed00b2b8d737f87 arch/x86/kernel/acpi/boot.c  Mark Cilissen     2022-02-23 @1476  		     DMI_MATCH(DMI_BIOS_DATE, "02/01/2011"),
ed00b2b8d737f87 arch/x86/kernel/acpi/boot.c  Mark Cilissen     2022-02-23  1477  		     },
ed00b2b8d737f87 arch/x86/kernel/acpi/boot.c  Mark Cilissen     2022-02-23  1478  	},
35af28219e684a3 arch/x86/kernel/acpi/boot.c  Andreas Herrmann  2008-10-22  1479  	{}
35af28219e684a3 arch/x86/kernel/acpi/boot.c  Andreas Herrmann  2008-10-22  1480  };
35af28219e684a3 arch/x86/kernel/acpi/boot.c  Andreas Herrmann  2008-10-22  1481

$ vim +573 include/linux/mod_devicetable.h

573 struct dmi_system_id {
574         int (*callback)(const struct dmi_system_id *);
575         const char *ident;
576         struct dmi_strmatch matches[4];  <--
577         void *driver_data;
578 };

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
