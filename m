Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB2578DCC3
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Aug 2023 20:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240752AbjH3Sqk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 30 Aug 2023 14:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244361AbjH3ND5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Aug 2023 09:03:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0B3185
        for <linux-acpi@vger.kernel.org>; Wed, 30 Aug 2023 06:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693400634; x=1724936634;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YMXi/ukgCCQZTnupVD0xMm/Pdsbza/vB0WhPl2UXnVk=;
  b=EkXwdcjoeGJ+d7S0oi+eBDHGiwo/yUcc5+xYx+SFdpXbjxsGvz7Omlj0
   V1+cPwgkTfeNZBhQirC4UezjJaY5xWEOZKCxar7anV7cXjLJjqAO09zeo
   0hlqencKu+X7SKPv9C42M7S8QLWmpeaBqJUSB5rx3X5gVl9qV6Ua/7FJc
   vUpld7f1kksilmaDQycmEFMWI4o0lZfVJLFOT33plQUEh1a3gYagyGzrZ
   4mKTZTkR/yVkj2ykHYoHsG/Wc/lkx71BJuAKoRXuU28X/PO0BBFWh9mO4
   Z/L2XgPMdQIkKARHO9W74pDoJ7AvWYUHiAMSuwWAxuDfFAoltuhvvGDzr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="355141205"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="355141205"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 06:03:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="742238895"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="742238895"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP; 30 Aug 2023 06:03:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 06:03:53 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 30 Aug 2023 06:03:53 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 30 Aug 2023 06:03:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ilh+mTsGOJGxpkMlB/4ejIx4CVwO1OdghjPPGbZxOqXN4ts3JMvPgIOCPMcu+U4OtAcU+xYHLkDNDbHprylfqgvSsmHAvleMgMttrPLyg7PYQM4bIaVihTHRI1LpXE7sDz5OQhB6Uz4EbLN7Jo1UWgNDBZGYvHThfF9r+HU41CZ5C/dWP9m7MCyjDmdgnvF++mUY+axjO8F5nZrXVcFaQROSOd9yW3elBJRqAzi6LK8+CSNC2THvGeMGaURdWNGdv8qrUceYVcpd0HUbChcpzablJs/dnzqFyU2SiIhbGn8EAJ9UZIfE+yOmdNGzwKPU03fhnkIhANCkUKJZFwk5jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lZnYGRvAyDq5idGlP46zU28DoMhw1qv2JBCoUVheJU=;
 b=hnSmCK+4dHUCuzuYPe6IbGUPFkSOmD6eURhPm1c1RvUaY4AuOgvc5ACecBq+BlhOTvhOxbi9CMejS/1BmLcQIiwfChI36zqGQ2aoxQRq33L5O9BQhK8gUvSu+FIeLABt/jV7Kgzx7beaNfVjgQ4l2DyEgzxPIL2nFltYTRZj98BY+bv2lQituLS3E6BeOLw1J5yg9WJugdqEo94VdTELEIU7WP6Msdhp+1f43Zno0hSIboCzYE+yneWHUr9FDDMpfxqPU0tH/0cGelDJJADBZScTWRorlulfAyxQzv2yVsF7AnWgr1zOeBAet9jocP4c9N7gVp00FRt4w9L7d7n5pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by PH0PR11MB5080.namprd11.prod.outlook.com (2603:10b6:510:3f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Wed, 30 Aug
 2023 13:03:51 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6699.034; Wed, 30 Aug 2023
 13:03:51 +0000
Date:   Wed, 30 Aug 2023 21:03:41 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Anup Patel <apatel@ventanamicro.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Anup Patel <anup@brainfault.org>,
        Sunil V L <sunilvl@ventanamicro.com>,
        <linux-acpi@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [avpatel:riscv_acpi_b2_v1] [swnode]  f6c8bb7f93:
 BUG:KASAN:global-out-of-bounds_in_is_software_node
Message-ID: <202308301642.aac23f05-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:3:17::27) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|PH0PR11MB5080:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c5cb9f4-a8ce-4056-89a8-08dba9598e61
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wnh3OKXMfPzL9M/FseKcPLcsUUQwUH0KOM5OWfLf8BSTz3UB5jhICtsLQoLVwZl118ieuc9yfP2K0V58EQXibZLJJlk5DFPh22mABKLUjGjFL922UjcVxSxASPEe8uaTL+pDQ0Rs4N38RpLcBBGr3ar13Uu222db31dRoBgX48RF35qgvDjzAu8gcL0QJrfZfll3IOVg15aeNbXcUsSJuV3tdwlafOZy1D+x5q0hvUgZye6nYvtMJ4FU3cVNAdymVjeOl49smxR8QyOwJgnjRfByBfupBytoBJRqeCC6Ca3ySwqgv16P9C57sCRGiQurE7nYQoGmE4usg9b12+EW/0pevEGLYPsKKUOQ3Up+lzw+JBX8p0Ovv5vYeSIlu356z9cfC/XxKVcgtWx1sl43cSU/oP5kcb1Yz7/PdjbP0wdXr+2RxW3gtyyERkV/xRdrWm1SZFjJF4VMhzuYpKsrqDm+ktNoLPwBAnvFtCAPVKR0BWNKrVaPPxPYk50PPc4jxznapeGitMgXAB2kQjkUyPG6NzMSdC8A++pzTWJ2Iw2T34pc75AdVn46TFYzzVcvnzst3/aVehmtKnbChzWNu7A2D0JEKmzEeKiOxREVMe/grtUXdY8pXIc4s3SFfX7fitiNV0c1hmBitr6lBqYK8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(136003)(39860400002)(366004)(1800799009)(186009)(451199024)(8936002)(6666004)(66946007)(478600001)(6506007)(66556008)(66476007)(54906003)(6486002)(966005)(316002)(38100700002)(41300700001)(82960400001)(6512007)(5660300002)(8676002)(26005)(36756003)(1076003)(2906002)(83380400001)(2616005)(6916009)(107886003)(86362001)(4326008)(505234007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hW3KxH0zY6hn7bfqInq3sb8/LFprtUbcueV2edhN6w/+x1hCb2tN0uArWu3J?=
 =?us-ascii?Q?mTKDc6Pjfu78i7TdLL0toSyfWXTvhi5TULTgszsrOPZlmHmj2tilBEOOYZQa?=
 =?us-ascii?Q?io9c+mZMQQCINJrdmJyFAIRdb7qbUNizh9+jvhI3fGAcEy1M9ge37bQ4D/O2?=
 =?us-ascii?Q?fWJcuaV8pLU1gnvRrfMS9aN+2YyGKAN3bD5oGeCau19THP1BUmHGUMHbun3o?=
 =?us-ascii?Q?nk8h9wYspidbawVdCf68d152tn05lKdKHp3kvCqZGLy5NnfC97NLoXiOVLdC?=
 =?us-ascii?Q?mZ4dODXK6j+1LOgopHNd8mzTM1pKKputK86M4cSuRjkVqYDi9aAClkeQYt6T?=
 =?us-ascii?Q?g7ayjgMpPxIcDogBXOV00Q/7lcKwkFvnV6vEu2ZMGcqKxHZBsAXFSoa62kqb?=
 =?us-ascii?Q?PqfZmRlT7ME80VytyuOQM2U7gmDbgkBdbcvcr7HYdXFagwcGllro42djJGTw?=
 =?us-ascii?Q?8+ryHcOx7D+BiP71DPBsqc+MZS9HKMrWE33E3gxvCvNWDchy9oYFhyvsZhV9?=
 =?us-ascii?Q?yNR3cbmO+J/8gc70pVlvVCk/rmobS/EfN9MN9xqPDHxceYrbJxKttoipTKIQ?=
 =?us-ascii?Q?cBz1eEvxiXPZl+PIf6ZW1P3zVuZykSOcNznv4eSz/YHQzGRXCA8DpBKVWWk2?=
 =?us-ascii?Q?DoaprFOzO7J+NlHZ23cN1o7/RWmdauMqbwfaLxL5oK/2Ie9JU3rEb1U2kEFT?=
 =?us-ascii?Q?39vZkB6rehbGHE2yl1qjvaJN+8PzM5x3corNiLvVjS4pOcJjyekPf0iLzeI6?=
 =?us-ascii?Q?+X8z8gABXHCOTqWM7dSk6q5cNhXHHU2J/uc4IXGVCu5xuF+/fFGQL8h004bt?=
 =?us-ascii?Q?Br2riMw4eZGI7AlJA9ojRun7WE1XMUHeGO92SS6hfG+28NLV4Cklx3UD3oAU?=
 =?us-ascii?Q?mZ7e8gAfvuvrqFwZdWMCYp6rkmq2XX1Wbqlerf0GldB3/xnDSRwLQYokp2rn?=
 =?us-ascii?Q?rllsQItOAWGmq5qp7nx4re/LP/OTr2QO30TFk1tFFh9KzpQhp/ninn0LVkQd?=
 =?us-ascii?Q?U7Aj2G6PEz2MV6L7PL713nRu7S0pSRk8i3mdXRIlZTGmx/uCSkJwsGOm8eC0?=
 =?us-ascii?Q?9t3kKVpwEktuOf9wkdmyJEpCh27t4z0UgQYIUocbA04nuTMR98WgciwJmbTz?=
 =?us-ascii?Q?nrUmWRIq7loByBWg8bJc4TtoO1wK++1ddR8kaWWrZMZxLv6ZS5D41CvPCcvO?=
 =?us-ascii?Q?oG5t7mCblhXmHLIT111WBuo/EaiezScqw6oq9+KX+NfbnKxBeCYi9N+MYywK?=
 =?us-ascii?Q?hGZdHWHf9WXSL0pu2OM4i7Nb+R2FdUFvd/1VrodD/wpOuf+5VsSurH0q9ril?=
 =?us-ascii?Q?VvRX8M6E2zLgouk5Ec/C16wr6SFxUsz1viWz10Xnvc28NGyBZSSeleEH+4yd?=
 =?us-ascii?Q?hKmNlDE9mHEubmOS9WrmH++UHUhX3xNPMR37hD/51Q3mQBllyWlrbjkQ3wv4?=
 =?us-ascii?Q?pz5gdCYIfxh54oIReDhPWAO0UKsg22aYFY7HYK7k6wb19RIolC7b23whfQNp?=
 =?us-ascii?Q?81x7SDO08fuLmoP/wUER+hUWZR+z8KDPd5cID86wkMsb/YYqE0wFaphNoLJz?=
 =?us-ascii?Q?E+NdMmVf9ojYYium0atpTk1Q0nMXBiabYwxsDfidgr27VnLFE4534sXoLzjr?=
 =?us-ascii?Q?nQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c5cb9f4-a8ce-4056-89a8-08dba9598e61
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 13:03:51.1998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zLvi7eIWqTsCDn1kig7IpC79HcSRjxjhAEsQy+f9O7Rek7PsSMfQJm4AKdnTMHhLRwoNaxyUMTO5H8s7IZnbWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5080
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



Hello,

kernel test robot noticed "BUG:KASAN:global-out-of-bounds_in_is_software_node" on:

commit: f6c8bb7f93ce0e2d0640e0ea73b33145d849f0d8 ("swnode: Add support to create early during boot")
https://github.com/avpatel/linux.git riscv_acpi_b2_v1

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202308301642.aac23f05-oliver.sang@intel.com



[   43.426753][    T1] ==================================================================
[   43.428570][    T1] BUG: KASAN: global-out-of-bounds in is_software_node+0x9a/0xc0
[   43.429100][    T1] Read of size 8 at addr ffffffff8628d220 by task swapper/0/1
[   43.429100][    T1] 
[   43.429100][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G                 N 6.5.0-00106-gf6c8bb7f93ce #1
[   43.429100][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   43.429100][    T1] Call Trace:
[   43.429100][    T1]  <TASK>
[   43.429100][    T1]  dump_stack_lvl+0x86/0x100
[   43.429100][    T1]  print_address_description+0x57/0x3c0
[   43.429100][    T1]  print_report+0xcc/0x2c0
[   43.429100][    T1]  ? kasan_complete_mode_report_info+0x93/0xc0
[   43.429100][    T1]  ? is_software_node+0x9a/0xc0
[   43.429100][    T1]  kasan_report+0xf8/0x140
[   43.429100][    T1]  ? is_software_node+0x9a/0xc0
[   43.429100][    T1]  __asan_report_load8_noabort+0x14/0x40
[   43.429100][    T1]  is_software_node+0x9a/0xc0
[   43.429100][    T1]  software_node_unregister_node_group+0xb2/0x100
[   43.441192][    T1]  software_node_register_node_group+0x87/0x100
[   43.441192][    T1]  fwnode_pointer+0x110/0x240
[   43.441192][    T1]  ? flags+0x380/0x380
[   43.441192][    T1]  ? test_hashed+0x104/0x1c0
[   43.441192][    T1]  ? fwnode_pointer+0x240/0x240
[   43.441192][    T1]  test_pointer+0x70b/0x980
[   43.441192][    T1]  ? test_hashed+0x1c0/0x1c0
[   43.441192][    T1]  ? __kmem_cache_free+0x172/0x2c0
[   43.441192][    T1]  ? kfree+0x11d/0x280
[   43.441192][    T1]  ? __test+0x150/0x1c0
[   43.441192][    T1]  ? do_test+0x340/0x340
[   43.441192][    T1]  ? kasan_set_track+0x25/0x40
[   43.441192][    T1]  ? test_pointer+0x980/0x980
[   43.441192][    T1]  test_printf_init+0x3c2/0x480
[   43.441192][    T1]  ? test_printf_init+0x3c2/0x480
[   43.441192][    T1]  ? test_pointer+0x980/0x980
[   43.441192][    T1]  ? ida_checks+0x18e/0x200
[   43.441192][    T1]  do_one_initcall+0x1be/0x7c0
[   43.441192][    T1]  ? trace_initcall_level+0x280/0x280
[   43.441192][    T1]  ? do_initcalls+0x30/0x540
[   43.441192][    T1]  do_initcalls+0x230/0x540
[   43.441192][    T1]  kernel_init_freeable+0x2e6/0x400
[   43.441192][    T1]  ? rest_init+0x240/0x240
[   43.441192][    T1]  kernel_init+0x1f/0x200
[   43.441192][    T1]  ? rest_init+0x240/0x240
[   43.441192][    T1]  ret_from_fork+0x58/0xc0
[   43.441192][    T1]  ? rest_init+0x240/0x240
[   43.441192][    T1]  ret_from_fork_asm+0x11/0x40
[   43.441192][    T1]  </TASK>
[   43.441192][    T1] 
[   43.441192][    T1] The buggy address belongs to the variable:
[   43.441192][    T1]  dev_attr_id+0x2200/0x22a0
[   43.441192][    T1] 
[   43.441192][    T1] The buggy address belongs to the physical page:
[   43.441192][    T1] page:ffffea000018a340 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x628d
[   43.441192][    T1] flags: 0xfffffc0001000(reserved|node=0|zone=1|lastcpupid=0x1fffff)
[   43.441192][    T1] page_type: 0xffffffff()
[   43.441192][    T1] raw: 000fffffc0001000 ffffea000018a348 ffffea000018a348 0000000000000000
[   43.441192][    T1] raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
[   43.441192][    T1] page dumped because: kasan: bad access detected
[   43.441192][    T1] page_owner info is not present (never set?)
[   43.441192][    T1] 
[   43.441192][    T1] Memory state around the buggy address:
[   43.441192][    T1]  ffffffff8628d100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   43.441192][    T1]  ffffffff8628d180: 00 00 00 00 00 00 00 00 00 00 00 00 f9 f9 f9 f9
[   43.441192][    T1] >ffffffff8628d200: 00 00 00 00 f9 f9 f9 f9 00 06 f9 f9 f9 f9 f9 f9
[   43.441192][    T1]                                ^
[   43.441192][    T1]  ffffffff8628d280: 00 02 f9 f9 f9 f9 f9 f9 00 00 f9 f9 f9 f9 f9 f9
[   43.441192][    T1]  ffffffff8628d300: 00 00 00 00 00 00 00 00 00 f9 f9 f9 f9 f9 f9 f9
[   43.441192][    T1] ==================================================================
[   43.478039][    T1] Disabling lock debugging due to kernel taint
[   43.478860][    T1] test_printf: cannot register softnodes; rval -17



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230830/202308301642.aac23f05-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

