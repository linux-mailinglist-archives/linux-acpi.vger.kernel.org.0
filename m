Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F6B6928F7
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Feb 2023 22:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbjBJVOK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Feb 2023 16:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbjBJVOJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Feb 2023 16:14:09 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C692D635B2;
        Fri, 10 Feb 2023 13:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676063648; x=1707599648;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BO34XjZLWGxBhKfn8yhJ9VDuVnjKXllAiqYv46Kdgc8=;
  b=dFzr3J6gUqOVhO7UzwK2G8k2cGN1t2jUmHmEhChVwSZIFr6DnQdaMRkV
   I+X3/JfKU7jn119wkN8UDyLyPrWmkvfAVLvhKevcV6EeNsDv/0VyTGorI
   PZqZrSETNt4qi4hgyZstG44pU/gAw9pMznq0JBHip4WOS/siwqSkctylw
   s0VPsVbKMFAzsjPL9Jrw4ziZQ6on5ID+dHItxzsPcnvKO+RYqBkviXQyN
   2LDlKYe2T4wy3QWn3diLyP6vFLmQXSnYkakWRi8Ms50EsByiFeWoVQ/SV
   2Pata/pJ5OsBx8V7i63SygDHHrrYL2Q/7+KP36dV1vui8au8OiwEeO26V
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="357927631"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="357927631"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 13:14:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="756917700"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="756917700"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Feb 2023 13:14:08 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 13:14:07 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 10 Feb 2023 13:14:07 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 10 Feb 2023 13:14:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rsk1ufPbGmVpk+E0X0gTT1/8a9C/tz/6Qm2kZXJkpLfF8In9GkPHZBGXax8vkfUa0WgoVaJeQ2ADggi8wnHoROPFTaNzBE6dy8cM4sO0BL/k0cjk+3RleIXEGraciXTCsjAoN5pir0Vbv7rz9zbzw2r7Tj3NXB8W1dVd1YYjyZmvRDgtPqh8aziY9BMY8YUMnlIs3568qznSzH9Vxnmqh8G8xWxixoKD/T45ziV+p/IDd8jKl9VjxyBQN1EZs91+aCySYaiw799xQR2NIitNLxznU+OIKGBiaHHIGoNwhMf43/WsLQN+qz0RhAi2pOcyGtr4KVZWgeAebmHhCG8dLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFwxpGRszSuldtH2UxW4/JwCMP1MCiRsI7vh/KDBadA=;
 b=cRJvjL96eunugSnzuQ554ZKALWJ6nl1jGc+c/pDBIlt5YRvH+OhrbFdUFkZ8vGmfQS+jOntlc6w7OzosQCfvP1WCYMpwIu/QEi5uGx+ImM5S2RgNkB8T/kbjwKdZkJttPL/8CtYOGyUMyFmFHhMzQvoEuXkT/7BBZBmAwO7k9K5zhE4VkTVnDNo8RlA0B8MhaHGPN3rFbsSztGBoM8o1omZtvixddOeOF1nOPMfuhtP/vjZN8z3MwcgX+s9TAGYIRHYYHTKlvci8d1HdRJKvqEij/bhUbDOxwXGakOuHwtrT4AszKvxE/egeXi9K5Mhwi6BfXgYHSTusJLMXng6WYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN2PR11MB4696.namprd11.prod.outlook.com (2603:10b6:208:26d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.21; Fri, 10 Feb
 2023 21:14:05 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6086.020; Fri, 10 Feb 2023
 21:14:05 +0000
Date:   Fri, 10 Feb 2023 13:14:03 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>,
        <dave.hansen@linux.intel.com>, <linux-mm@kvack.org>,
        <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2 01/20] cxl/memdev: Fix endpoint port removal
Message-ID: <63e6b39b46bee_1db5d029497@dwillia2-xfh.jf.intel.com.notmuch>
References: <167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com>
 <167601992789.1924368.8083994227892600608.stgit@dwillia2-xfh.jf.intel.com>
 <20230210172850.00001d5b@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230210172850.00001d5b@Huawei.com>
X-ClientProxiedBy: SJ0PR03CA0216.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN2PR11MB4696:EE_
X-MS-Office365-Filtering-Correlation-Id: 5458929a-53b8-4a0e-447b-08db0babbdc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: saOvIsvbO1DTv9E9n7P75ST7AJOF2nlbRfxqJZf7592iG0VrtSSSmxTQx5Gs+pYA/8HHYmBiLF8ewL8t3/RAo4rbQ2BtT33+0xr3xTMG1jaVXJlmMkK8dY3cjUD2/aQwxJwJZTyasfIYlOXQfZTv1kMiLW+zQsvs/ufJjKNTxgtce6lEjShcsmbxHq8V8oG+fvFzAoEomnyUQ9Hwa35W/jmEKKqErmODRONPGgycdrpXOxLGvmATGFz9jdUPBLbt6N6ipAvhDqc8ywv6lD1PlBhBDpwzMwwK9N2fwNjDCforxeEhFKv+H+hk5YG7lqDfgUkotn6YBCeCMYh7AKgElIjYEKmJCHuzV1z4nt2y+FuOCHMsPoaNkgkFcGzUq2exiii8xrdvq/cG/3DqqeFYgY+tbf+hpPDjnHvCh0axf/DnKNP2d1FYtyJkflMttnyjPKHHZOlfeicezG5Ucncy40y5z9IxICVFejfQD2idt5pND2QRxpDwn4fzyHj9VI7Sf4kIbv55zYQBWRRiwlnkwUFarQsn4fwelogi1lNVPJRsnM2df4EHGKQo9Gvc6gIHdLwW2IbDpTwBPP+EM2ZR6dRA5mhKRruc2TbHGb7K7WHwX2KoEWPanwRPi0sGGX225ixb6HGKpIq375sYz+Owaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199018)(86362001)(82960400001)(38100700002)(8936002)(66556008)(66476007)(41300700001)(66946007)(316002)(110136005)(8676002)(4326008)(5660300002)(2906002)(83380400001)(478600001)(186003)(6486002)(6512007)(9686003)(6506007)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RkoixTQ9YdbquiyF07SWckLyjKi0Im2ta33rinwekP4Y9goZIryuDvkr32ku?=
 =?us-ascii?Q?BMXqrdNaWCLLWCr4Q2dU/6nJtnF1rR0hvSUrSuAvGThVEwTOXVRIF+TPDnIl?=
 =?us-ascii?Q?obXG/FL+xALmoBbjVixiL+28KG4rO4Qga96g4+TfmIv/RYsfHd4NsG3De5bR?=
 =?us-ascii?Q?SngexyTbDXRcUJ8E14e5g8BNIqjUQ6fW9lfwqS9FlWd/a103U5yv6tfsKYbG?=
 =?us-ascii?Q?rzN2nQbE4FNgfRqbyt/w2pMlvat2QDUBzFDSmM+kiaqnH3lAS1beSj+xlG8q?=
 =?us-ascii?Q?PNg26FDkDhhMHTOk8YYH7/xBKu+JNZNvzH4Mc5rB/GSPj4+BVqadNJ6dhxGk?=
 =?us-ascii?Q?H2A0w0fo8pPO0dGpqz2ea/5HJnG5o+dc5sEh/ms4KYjudcBJDxqxeyFUBabW?=
 =?us-ascii?Q?mijQxCziw134IDvkzA8mbj7n1q1UPPPxol+dT8n3lHgLd4bvvINUKNze0kj9?=
 =?us-ascii?Q?pj4bxsSMVPqvRITFglYpltBnXvVT4HJqPRSs9skWK1ihilcHjd0JKSoh/oWC?=
 =?us-ascii?Q?z4juYYdEmS4Vcr+iczmCOhO3JlAlinNFfq8IZSFuoMfgBQl6dU08LAGwJ4w/?=
 =?us-ascii?Q?DjSk8XihLoz3r8gk+ZWf17lgpJInZWcsn8Ez+RXqQU1MeOEnYexgry+pl2NL?=
 =?us-ascii?Q?QDLObezvQJO24enTqs2C2aQtr2DuiqBw02Y4AiGXqWrbvnK+U5XCs5dZlRja?=
 =?us-ascii?Q?XX93V9dF6jD8Rwn3dtG0j3N4BN74VtjvjbNLIoNTpw0SYe1IqzogGVAb5ldu?=
 =?us-ascii?Q?b2EleFzhIEjcUw9WoLqeZ0torEMbVCyzdGOF3XyTnwczk2t5f0cWpow0jdAu?=
 =?us-ascii?Q?s2R9STDd4tvSxEkBMfVjCN6SdOyLwRnMja/n5UnKEh3y9lr2Bzr06ubSWFwq?=
 =?us-ascii?Q?yX/PInznkp6XnscqFMVrqvY8/SXNSauIoVgS70VfwwL8dJwH8Cxw+t6selo7?=
 =?us-ascii?Q?QzDkghDXEHrb/yyA4bRxBpNjGsvhoJwM+qv5UX8pWvSyGo2hrl3RPvZLrRDD?=
 =?us-ascii?Q?eRs0izLfS2BtQA1XpJCHH6XcDNUUOn+G8Kh6K9b33aA0qsf8C+PbfvJWJxsB?=
 =?us-ascii?Q?06G+GahTZzYn+6BZ+H4n2HO52X7FJTp8To6hWcd8ZtO79hJnkdoLQWeBk4AO?=
 =?us-ascii?Q?U4kXBtCeni6AaV/G3rby4NEhg6MfMZeq8QEjaEUrd0oPxAnTE1VzMl7RWU1c?=
 =?us-ascii?Q?I9z7Vurq8763XWxCbtoORAo1ZuGeL51mY6OzpYySzAB/2qN1nYoYGka3kQ4u?=
 =?us-ascii?Q?m+Vp/DZCfbkzEIVx5WlqgsaeebkozXkjbnGh26t7CSHwPRYDGJxT3j1cIh6x?=
 =?us-ascii?Q?v8N/qpYb3YaMOEozE4i25PgCXvRXgA9GrWJqTPrH/heh6gB4LSJqwjIpb9HH?=
 =?us-ascii?Q?fbdDlZWl0Y8JtNR231UCdEioXvLYM4xCzURGWcU+XfBLFYY4VIXXRpewuTJi?=
 =?us-ascii?Q?BxuJRbjldwgMGHmjm0m7sIJ0UTbILe6A449Q/VWUIxKKYsDUsUdlJ0e+BLgB?=
 =?us-ascii?Q?/eSa2Ba8DLLROnOh5ftYuRCPyZrS4ScoNSym5AX38+WcxmY6Yg2vjQ3b3d5i?=
 =?us-ascii?Q?GsNQcPl2z7FI6ylM0UTdr8jw7vG1S392s+e3xxtkXX19oKWX9UQKqulgFzUL?=
 =?us-ascii?Q?Aw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5458929a-53b8-4a0e-447b-08db0babbdc8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 21:14:05.5951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lyYwN0swIe2Pz9jSybfbw/eTtM+jJR3XGhou7VS5sh6+W3hoEVJajk5BG22QW+06fdjSOPjHfa8yT6BWLWHaqb22BjijYPuQcLFL7RI1XXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4696
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Jonathan Cameron wrote:
> On Fri, 10 Feb 2023 01:05:27 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Testing of ram region support [1], stimulates a long standing bug in
> > cxl_detach_ep() where some cxl_ep_remove() cleanup is skipped due to
> > inability to walk ports after dports have been unregistered. That
> > results in a failure to re-register a memdev after the port is
> > re-enabled leading to a crash like the following:
> > 
> >     cxl_port_setup_targets: cxl region4: cxl_host_bridge.0:port4 iw: 1 ig: 256
> >     general protection fault, ...
> >     [..]
> >     RIP: 0010:cxl_region_setup_targets+0x897/0x9e0 [cxl_core]
> >     dev_name at include/linux/device.h:700
> >     (inlined by) cxl_port_setup_targets at drivers/cxl/core/region.c:1155
> >     (inlined by) cxl_region_setup_targets at drivers/cxl/core/region.c:1249
> >     [..]
> >     Call Trace:
> >      <TASK>
> >      attach_target+0x39a/0x760 [cxl_core]
> >      ? __mutex_unlock_slowpath+0x3a/0x290
> >      cxl_add_to_region+0xb8/0x340 [cxl_core]
> >      ? lockdep_hardirqs_on+0x7d/0x100
> >      discover_region+0x4b/0x80 [cxl_port]
> >      ? __pfx_discover_region+0x10/0x10 [cxl_port]
> >      device_for_each_child+0x58/0x90
> >      cxl_port_probe+0x10e/0x130 [cxl_port]
> >      cxl_bus_probe+0x17/0x50 [cxl_core]
> > 
> > Change the port ancestry walk to be by depth rather than by dport. This
> > ensures that even if a port has unregistered its dports a deferred
> > memdev cleanup will still be able to cleanup the memdev's interest in
> > that port.
> > 
> > The parent_port->dev.driver check is only needed for determining if the
> > bottom up removal beat the top-down removal, but cxl_ep_remove() can
> > always proceed.
> 
> Why can cxl_ep_remove() always proceed?  What stops it racing?
> Is it that we are holding a reference to the port at the time of the
> call so the release callback can't be called until we drop that?

Right, as long as a port reference is held then the cxl_ep_remove() at
cxl_port_release() can not race this one from memdev removal.
The result of cxl_ep_load() is guaranteed to stay stable until
the subsequent put_device().

> Anyhow, good to have a little more detail on the 'why' in the patch
> description (particularly for those reading this when half asleep like me ;)

Long day for you, I appreciate it!
