Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9567968FD4A
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Feb 2023 03:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbjBICsb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Feb 2023 21:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbjBICrU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Feb 2023 21:47:20 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5636C7A84;
        Wed,  8 Feb 2023 18:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675910649; x=1707446649;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5tLMdc5PAVqdBIsCHaUEEIqEbY5XqX5F5n6ayn/X0WM=;
  b=QrhXjNhB9F4Q8GmMV9kZ/XXYOkFt1aYtuKvzCd46LQRC6V928F+Fr/EB
   SGnLAsSMcsZ9Lg2yu/Y23DklD7LHaFmubrASNgcQsNoztXpQaMkee1Z1s
   ZI/Vl0bxIU66guHrPY+oaKVTNpfAhxmkz5s8LD0qfZY91fZ2mpABLRPL6
   D3YjfDQh3zs7nYoehptBefLd2tz+GmqzBD9QvW7z0A09VXGiVXK2/gJav
   WzDqXKvYJpsIB/2lJmxN2CQYBgBxmGRbS7tpS6v6bY7djXLVqCw4ufpzT
   kvIkMs3sa2HfqrU/y6KVG1bh760TlV196YaUhamADwKSvE2NkWDlA8byR
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="309642857"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="309642857"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 18:44:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="667475989"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="667475989"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 08 Feb 2023 18:44:08 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 18:44:08 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 8 Feb 2023 18:44:08 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 8 Feb 2023 18:44:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eR+4ELTCEhG4VdSN10AfaTsEfA38ekWVA+n5ugccvF9ndJC+nBtbcQKVUvrwmNNeQZ1thkhMm+N4vfYJqgqmZdVtIPVXQtLZ+ikOvS6+U7nlnNDOjZON4xtzEck4aQnLjrQrqXdjHGAYQR8SfuogKNYGZvpZGHwxHzvCvBPFbzppk6lj5dJ07d2tmo2aaFWmK0vAP5AwmUEiXFUmm/ha100hRUrY/HXtlVY2bCpXNH5Iqau0uNLfuQRW8lL5iAA/Ykyf+WV65NKc2m8UGXcQESiCRr9/nQNhOYkSr1BPVjfxzDbsV7rjUU0oI+uYuOxPfIM8PzSZOpH8VDX4M/ambg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+fRYA4e13JKkvk16MccroNn6S5E2k+/h6RC5frvi9ew=;
 b=CcTXsai7T+Vifn440QiLStx+Bu2ZPxcgIg0mkyYYdxgL04DAxzj9Mc4W909TjmRmMY+vIeLmnENKzGtglcmWutJNKyWWfpYzQNmU5S9pMNKGYmfRGdRVbvibVwuYX8lZnPfGushViSMpZXJFSOL5XF2g4vmpko1suaYA6X0xiyQ6E+0Ur4O/q2zc3fAWFHBYzjXBs9sTtr22bdGWmZrjCtWnfa9h2X9c0oZHBfASqMgZ0lv0SPsecockn9TzKDfIp5buiWIYSHyPyLrpRd4eFD1uZ9jpwTM7VRu1fkGRbjB98bz47lBdNg7VOqEkyCCtgU8w4598RqvoFKP6c+ck9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by CH3PR11MB7841.namprd11.prod.outlook.com (2603:10b6:610:121::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Thu, 9 Feb
 2023 02:44:03 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::66b1:16ec:b971:890c]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::66b1:16ec:b971:890c%4]) with mapi id 15.20.6064.034; Thu, 9 Feb 2023
 02:44:03 +0000
Date:   Thu, 9 Feb 2023 10:43:45 +0800
From:   Philip Li <philip.li@intel.com>
To:     kernel test robot <lkp@intel.com>
CC:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        <linux-acpi@vger.kernel.org>, <oe-kbuild-all@lists.linux.dev>,
        <linux-media@vger.kernel.org>, <rafael@kernel.org>,
        <andriy.shevchenko@linux.intel.com>,
        <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v4 2/8] ACPI: property: Parse _CRS CSI-2 descriptor
Message-ID: <Y+Rd4d11fYSJbkSK@rli9-mobl>
References: <20230208152807.3064242-3-sakari.ailus@linux.intel.com>
 <202302090459.kIM95vle-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202302090459.kIM95vle-lkp@intel.com>
X-ClientProxiedBy: SG2PR04CA0172.apcprd04.prod.outlook.com (2603:1096:4::34)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|CH3PR11MB7841:EE_
X-MS-Office365-Filtering-Correlation-Id: bfc0f563-9e2b-4dcb-cac6-08db0a4780ea
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c/TRR93k+6KuzZAJR2YFBSNzvmXM5xH6IzUPb4PKYYJ7aida8Cl9LKGyJRZoNJzWnUSVYT1OE8+dM+UQ60sjpGOICOwwbKfVKPqrMwQ0/yCTcu0rhK7uHKML3NLNCnLw12dL0M95znFBiT7/qHx4ZeZ3hW6YQAtj2S2GbC0jiOE3tYwdZWpmmI6WUf62aZPJuyyppaxUShlZVVUiAECV6cvs1yOU8U0RtaLiS8lqDgVJrV4vmM/ffmHrRPf9FV4EP3kAU2ahbyiomeYARYi8x9OIpHvf3xqbpiSfrbM8SHkpCV6dUmZPQBhcOciJKMA4Poq4RJa17QFyXZO+R/PEWoA4EPPffmcZfvBOdfQYmg0ANXw6akqo4GUDY+bbD4/ilng8DkpgHXa50wxD47hD7216J/hXDDwkcNmmBcMXrJol/GeiaxBTsIKs8p7lL1XwEvpyKwkBe16l6lnGmb8wAvXen98V4gXzhyGKEnAcau5z5FkUZZhjxVisNpXmQ2O/FL3U36DMJJRK2fcvVyka51wZ7RjVEe/WLhYRc1iT0uZQYiFnCz2ctcQ28l95AxGA1mw6ReJ/EC95o0aEX4Sy9TnHWnigqUeHaPsHdZT0+v+1fAF7K1vnsxvkuZOlxKqSMnt7oEWPOYAQCp5+eOBXEEAUgWkjMcTSw9zXU2w5q26zFz/2YpKATA2rnntu4HfS1BStE/o9krUgHZOJsIR3GDUuDJ2ilYnJceWvyXABxNG3tLG3Awhd6V44zAiuR83kvB7dcu3s5cSo1VB+ryPUmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(376002)(396003)(39860400002)(136003)(366004)(346002)(451199018)(6506007)(966005)(9686003)(478600001)(6486002)(186003)(6512007)(26005)(6666004)(6636002)(316002)(83380400001)(66476007)(66946007)(66556008)(82960400001)(38100700002)(8676002)(4326008)(2906002)(8936002)(41300700001)(44832011)(86362001)(5660300002)(33716001)(6862004)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uGDqVsXMb9oN1Qh0KaEs+QyfmXwhoZNoWI/o34RJALJNaLKJ6RoShKcSuO7c?=
 =?us-ascii?Q?ZGLM3U/X5YqEVhkPKG6vCNvdB/AxwVva0TsY+TzH6+JKHg33RI2H4H4ZdS42?=
 =?us-ascii?Q?lyC2j1RBOLALjWSDBPMnczlF/L3bSF7ZTw5plZt+7eQxcY4qQaNR4euwA/mO?=
 =?us-ascii?Q?5r743KZsaPgge7jrY2lNk6JrsEZ6Yno+bTmKSYvHQOS4wUPFnJ4BQQiw+wm4?=
 =?us-ascii?Q?6JmTRnjyCfe4qJKKeJAusRebpbZH1CXheu773oPQgrjr1wb+b9DurZUXPKKy?=
 =?us-ascii?Q?dbB4b5qRoKBT4qhI4gH+Dcryhodq1RYnw4FyoFV8R+s1MtbwLKU00MzM51PB?=
 =?us-ascii?Q?CTzPmsgIlj1CUZMidGllTZn8L0uDoVolzpGtTTxJE4V9byaRaLz5WNKWYEt1?=
 =?us-ascii?Q?GxBVoqEA6wM03vS2l30GscKaH783yyW1akflMiIonPbFly/SXUQg7vZ/0ipw?=
 =?us-ascii?Q?L55b2MiPvW3RWmlPxOfRUTxPOei7c3LV39K/lm18lwfoHVikGAaATnuQ4e0r?=
 =?us-ascii?Q?UXZ5B0OFYv3nelKZMxyJxZfJgtG9Xh47JTgyUTJZKNI/tNbN/eDgE6SUWEXz?=
 =?us-ascii?Q?V8xCuM0LAVD1IKssyvPBXH7dcaSvDtGV6EErVy2QWVB1TX+xaZJpUDV5cH/Y?=
 =?us-ascii?Q?Dp425NfHl+RQsbBgYpS/UEQaNa79MW93FwixZ9yBAZ+uVozn9dbcAKhId2lY?=
 =?us-ascii?Q?MbfGIDC9k/uovEWYiJWvhH6oJapvZa1JTSsxjP4r1rDqp/+IUdBkM6vsPaAA?=
 =?us-ascii?Q?WCqB3CVO+TaKSrDy13hbp9lHkfplfVkTegmyjw+jNWpATN/2tcSXWy18vM6Z?=
 =?us-ascii?Q?1yZ9WHkr8erCDLZIDmPHU0OMxweV6c84MRMDbOGXO/IF2ddM2JG+8nHn+5xS?=
 =?us-ascii?Q?3q2lHBBI5WFsIhqzclYZ/YrbRUzEXTIErosrIVifKaq+l4/h/2quSqPsEtkQ?=
 =?us-ascii?Q?uWEbXxZRxSXmTcfHFX/rwUE7rDQ/IIrTRcEUQWQpOWDRPJO4K4EZA1H19/CF?=
 =?us-ascii?Q?Ia6iWgXrtYUVrj3JdWNMxQBsBqmfLrc22+Z/ngmy6ggYGjxQKArGMSuWBOc6?=
 =?us-ascii?Q?2s5n2ETgrs2M7unpFyggHLXasKBTygeuO3G+tz6W3IrKBxwqhvHPXb+xe/oQ?=
 =?us-ascii?Q?iiXhSq0d7Ht+ydf2zlZOrXtG/U/rnVP0KfA36h/7aIL/p2u+UwBrv4hpWqBj?=
 =?us-ascii?Q?W644cyob23LkQ/CWkMX7P3SEtj5WwDf2lDXz2L0ozLlG34CwRrB0natMrfOg?=
 =?us-ascii?Q?q4i/BJ/3/o3nddcsjKZOJywiYR6l6ZAj1r6fO4qyZSqmHTGh/NwIsGBXGQyG?=
 =?us-ascii?Q?G5t84P05Gnc/Dueh3v1EpMFZXmurjfHCTEFboyQUncMhUwpD78/x+86HGMyz?=
 =?us-ascii?Q?nnI3oFJoTdTMHWBP2aSM57GsbsVGJYLCbKfAfWd5L94kIRoNpJNMcBopjuu8?=
 =?us-ascii?Q?YprVb88VbJCcoYZAH5vcF51fv2pZBIPHBWbRgcvD32IswzZT84DyLGYo+KmO?=
 =?us-ascii?Q?GNNCvo9zDa4vvjclAyyrsR3U8+ysTkRVqy/4oPYdZsxHSjBjyDB8Bb7D8q6F?=
 =?us-ascii?Q?EE1ZMBg41C6C3NEX2ZbO8UAwQvcTfc4ROMmQH5o2yNxVm2agsp6p9CVsdlQ8?=
 =?us-ascii?Q?eQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bfc0f563-9e2b-4dcb-cac6-08db0a4780ea
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 02:44:03.3945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6MtfHn4PDDA2fgleLzOmCQkqxqBM2GkSuHhV18AAS7KfAQ/Q5fEuaLDdT83Za5WczIWyxl7BHGXxZR3Df+B+Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7841
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Feb 09, 2023 at 05:04:11AM +0800, kernel test robot wrote:
> Hi Sakari,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on rafael-pm/linux-next]
> [also build test WARNING on sailus-media-tree/streams linus/master v6.2-rc7 next-20230208]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Sakari-Ailus/ACPI-property-Parse-data-node-string-references-in-properties/20230208-233112
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
> patch link:    https://lore.kernel.org/r/20230208152807.3064242-3-sakari.ailus%40linux.intel.com
> patch subject: [PATCH v4 2/8] ACPI: property: Parse _CRS CSI-2 descriptor
> config: x86_64-rhel-8.3-syz (https://download.01.org/0day-ci/archive/20230209/202302090459.kIM95vle-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
> reproduce (this is a W=1 build):
>         # https://github.com/intel-lab-lkp/linux/commit/d78f47f2d5051c50bdcea131da1779ec0fc8e266
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Sakari-Ailus/ACPI-property-Parse-data-node-string-references-in-properties/20230208-233112
>         git checkout d78f47f2d5051c50bdcea131da1779ec0fc8e266
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=1 O=build_dir ARCH=x86_64 olddefconfig
>         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/acpi/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/20230208152807.3064242-3-sakari.ailus@linux.intel.com

Sorry that the link is wrong, it should be
	Link: https://lore.kernel.org/oe-kbuild-all/202302090459.kIM95vle-lkp@intel.com/

> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/acpi/mipi.c:205:6: warning: no previous prototype for 'acpi_crs_csi2_alloc_fill_swnodes' [-Wmissing-prototypes]
>      205 | void acpi_crs_csi2_alloc_fill_swnodes(size_t ports_count, acpi_handle handle)
>          |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> 
> vim +/acpi_crs_csi2_alloc_fill_swnodes +205 drivers/acpi/mipi.c
> 
>    200	
>    201	/*
>    202	 * Allocate memory and set up software nodes for an ACPI device with given
>    203	 * number of CSI-2 ports.
>    204	 */
>  > 205	void acpi_crs_csi2_alloc_fill_swnodes(size_t ports_count, acpi_handle handle)
>    206	{
>    207		struct acpi_device_software_nodes *ads;
>    208		struct crs_csi2_swnodes *swnodes;
>    209		size_t alloc_size;
>    210		unsigned int i;
>    211		bool overflow;
>    212		void *end;
>    213	
>    214		/*
>    215		 * Allocate memory for ports, node pointers (number of nodes +
>    216		 * 1 (guardian), nodes (root + number of ports * 2 (for for
>    217		 * every port there is an endpoint)).
>    218		 */
>    219		overflow = check_mul_overflow(sizeof(*ads->ports) +
>    220					      sizeof(*ads->nodes) * 2 +
>    221					      sizeof(*ads->nodeptrs) * 2,
>    222					      ports_count, &alloc_size);
>    223		overflow = overflow ||
>    224			   check_add_overflow(sizeof(*ads) + sizeof(*ads->nodes) +
>    225					      sizeof(*ads->nodeptrs) * 2,
>    226					      alloc_size, &alloc_size);
>    227		if (overflow) {
>    228			acpi_handle_warn(handle,
>    229					 "too many _CRS CSI2 resource handles (%zu)",
>    230					 ports_count);
>    231			return;
>    232		}
>    233	
>    234		swnodes = kzalloc(sizeof(*swnodes), GFP_KERNEL);
>    235		ads = kzalloc(alloc_size, GFP_KERNEL);
>    236		ads->ports = (void *)(ads + 1);
>    237		ads->nodes = (void *)(ads->ports + ports_count);
>    238		ads->nodeptrs = (void *)(ads->nodes +
>    239					 ports_count * 2 + 1);
>    240		end = ads->nodeptrs + ports_count * 2 + 2;
>    241		if (!swnodes || !ads || WARN_ON((void *)ads + alloc_size != end)) {
>    242			kfree(swnodes);
>    243			kfree(ads);
>    244			acpi_handle_debug(handle,
>    245					  "cannot allocate for %zu software nodes\n",
>    246					  ports_count);
>    247			return;
>    248		}
>    249	
>    250		ads->num_ports = ports_count;
>    251		for (i = 0; i < ports_count * 2 + 1; i++)
>    252			ads->nodeptrs[i] = &ads->nodes[i];
>    253		ads->nodeptrs[i] = NULL;
>    254		for (i = 0; i < ports_count; i++)
>    255			ads->ports[i].port_nr = NO_CSI2_PORT;
>    256		swnodes->handle = handle;
>    257		swnodes->ads = ads;
>    258		list_add(&swnodes->list, &crs_csi2_swnodes);
>    259	}
>    260	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests
> 
