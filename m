Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7294568C886
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Feb 2023 22:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjBFVW4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Feb 2023 16:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjBFVWz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2023 16:22:55 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2546E82;
        Mon,  6 Feb 2023 13:22:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePc0ZzEvA+2Eyv1XG4bACkajA84GgOQ3c196ZL2b18l5cL0Mn6O+XWkKLn7MN/FG6s+uckWZG7wJ3BKBY1To27HF5dZZbV5JoYiOMKPv24W2TFKPRMghsjlfNA3RUer185Fl/78OEZ7s190m4wR6JNhGYjX7kiFxGaPSC/9ck/yhrLRd0db1fGfoi4h39OWBnshBMUD9xJVW7J7VJPyL1ndQ1N1Xvoa1C22mDEzNPuhlvqHyFsd7REWYVs1vQfHZdoDxg1kue84ZSE9uUNrke3Z/IVVR+9WgBMhBkA6+svBggs88vnjnH7fF8qJTFehczT9FxFAxQl2aSL/Y8s/rOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2X8l/tfwjMIQl5HeiHBK//JRPM407RZZzN4mG8YHi8=;
 b=U22IxtKlUFMs8lxWJ/uTOgnwckBJmIzcxAXLUbXHpBQIktIZ+ddPluTkIHr7Rbuk2ssj+ZeRN2Mbx5LXmuvFYBzOqXGK2V1/5Fn9VktTG6Ndr2l9X+AV4Wkv+odLeUAZs/z/M5EsB5ddj6oujCBlN0baLLPzzMl2hAVg8gaBvNg2N1t/Hu9nLzNqaT8jTxiwCU6z1YLTBP2SKudfjQzWJIVBg7vIgQ9wdTPu8kHZG4yZUXcE8kDn+KYhMEcchIEgS/glkdZKeSWkYZx0Qa9YAeM9eJknLjTv5PZwiRbf0mcRKsQJsV+A09+NNr7QfYZwZabaiBAn/d423gNSaOGipg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2X8l/tfwjMIQl5HeiHBK//JRPM407RZZzN4mG8YHi8=;
 b=KuesZe4vYkcR3qqs6+rtz+6N/+jKERRfnV40G2d1M3+/48aRI81xpTDnS2/BtTqKqwAX0xADqU+pk3pqgC60yOd2xHAE1wdRlFLXnoQ/CAhDpyPgzbKjG9y3zLAv+0qNLcGOBPzFkGfTLzhYvOr4my8GapqSIwB1u25p6mpuBn4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by DS0PR17MB6863.namprd17.prod.outlook.com (2603:10b6:8:12d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 21:22:48 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 21:22:48 +0000
Date:   Mon, 6 Feb 2023 12:26:40 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH 17/18] dax: Assign RAM regions to memory-hotplug by
 default
Message-ID: <Y+E4UGJhKXIj7ssm@memverge.com>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
 <167564544513.847146.4645646177864365755.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167564544513.847146.4645646177864365755.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: BY5PR17CA0043.namprd17.prod.outlook.com
 (2603:10b6:a03:167::20) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|DS0PR17MB6863:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aeb0a52-72e8-4af4-5623-08db08884b81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RZu8jmuBNI/HnT23JY77w8giZ6i2ehB/aSi5Ss28gCNRBnlyK81HapifaNK1XyBF+Lde2CRlP/GwUEL3v1KmKN8pATbTSbnOZVHkAfD3s5wRsQjmQcEwDZhFXgUZ4hWwinv6DefjooJ3CWy+xGpt2v+Fgc5Tnee1G+fGUduTUf+oh8Ite5Yirsug00dDdsa21grlESEM+0D+zDEhaOt+osMQlCFUGMSxPH5Qaqi2cullH8mZk0nrHMJJ3z6cpc9Qy9Y+xugneiOrg4JZMn/2oM6MHE1YKo9d0HxN2UW9V4M7p0qnLC2cub3SaZ0UqUZDweHv964CPOEJw4vn9VRagsAvsSPUpYc/VEfRn9lrux9GmWNyYgifSvLgQQoCsfBARVonuGRUFEigYS0aNvNEziDt625lQ+H3GYWYgCaa0hmBlI3sLd81lStC3SO3RTjl+Lnd3UibKbSYHA+MpwK588bvKUNka7uk6fXUOgWpykX/LNDsGZIhOtZx7tQhpRNeUEmdeDX0dcQaN7cTG+nkPY4SttSCe5EiKvxzX3RI+ZV4gMeJGhvIzwBv+4SVn7LiMEsPJHE/bgAvf94Wis1TaZi49SNZpnlqn0Lky635krIk2JgIOWACCX8VTJ0qibS+7JzU5k5azyjQ8kWkGJaDqn+B8qdfOrvh4jzBCeZsklE4RjQaWGP0L3sXzay9i8QB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(346002)(376002)(136003)(39850400004)(451199018)(36756003)(86362001)(38100700002)(316002)(44832011)(2906002)(54906003)(478600001)(6486002)(8936002)(5660300002)(66946007)(4326008)(6666004)(66556008)(83380400001)(8676002)(6916009)(41300700001)(66476007)(6512007)(186003)(26005)(6506007)(2616005)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kRXyeKIVM1efu9/Ep4/izNGKOBV/XfHxX+jFuTHtPL+YdtV22OyTlQHqnC1R?=
 =?us-ascii?Q?XfAHkMbm4dcMf8eQSYj430wy5KpydQd57FFR3ElaR+WZPbFgWUIhjF3v7tit?=
 =?us-ascii?Q?wwNLADaC8eJ9RkQJtwKYL51v2aHRmNb3u3oaCMaW8FZSaYm9OWyHX0k+eDML?=
 =?us-ascii?Q?vSq+NckxOC34ffkQYD228RYdUAhLmNPlHszRmeMs7OLOWwH5xhuk09TSefDV?=
 =?us-ascii?Q?BJdFXPVt3aDiFih4sP6fXtevDMmvxu8XdHoozL2eOQbSdyNGrUQ98onXoETp?=
 =?us-ascii?Q?yecFCc+3fDJcsBlyghK1CrwnWriCGxsGEyayMcSxSwkjEpOJhB7OYaSHHZxJ?=
 =?us-ascii?Q?P6F29nSJgyOo6z4OQy1wEzrFuPzay+zmQeo+zV3F5Evu1WBotKeyxSrkrN+Y?=
 =?us-ascii?Q?7rbgN0mZL4+dA8KL8pRiH8NVJL3V29kw5sC46cXztd9Df/70RBapMDhYgC5h?=
 =?us-ascii?Q?w6EpxkjX/S/qR8QN0SM370bMCLv+NfN32XcECXpyKYzFNXjV0cmRcD28U9Fo?=
 =?us-ascii?Q?HZ/7EhglHCnqsD7LMRaXhD3q3XK/si8Qz9Focmwe7QfdedUbT0LDKqm51M/I?=
 =?us-ascii?Q?FcK2f0LxBZ7LxyPVoBmqSdzbRMkvwIZ4W8KYqOIpfrRQTGBPf1DXWSF3psoG?=
 =?us-ascii?Q?Zk18W1tKOn8HvY8hP7SHgQ2kcULAxNEj4mwaNeaXzcG+OKB0XiPPCnuaiNWU?=
 =?us-ascii?Q?g1NcMX8V1oB61+DPBCKXHKGYY0DZv4/U5PXUScGzrTN/FCA9FJBqeUtNe2Dq?=
 =?us-ascii?Q?Le+8KHpLAT9zHzP5u/rwg3AVoFJSRtAAeUbBUCo2GmmrqS14I3C3T56unBVC?=
 =?us-ascii?Q?Z+2JQt77PPPFZ66aSDePF0xbPYnbbOFbf8aGXVUn5JPXwlhDcIQ8zq3rVy+Z?=
 =?us-ascii?Q?h5DhMCH1vrR0QeOUb50iCig3IpfcKftfzYB8DsCwFbfceQ3ddVybFaWgGLmN?=
 =?us-ascii?Q?Z09GUrT+9n/OGLlk89ssyQys3uzA3yZrQ4npAhxzpull8BOscqwv8/L3XTJ9?=
 =?us-ascii?Q?f7SlRtDyQMOJPw0A4wqHHTiipxAcMHQQJjzDuozZ+Tjtyb+KD+OG/1Jm85/B?=
 =?us-ascii?Q?t2xqfrqNLhEXn7GEv5DpgQq6CXvK+dPmjLPSI+f4y+3qZOdlUQE/qfsSl1/s?=
 =?us-ascii?Q?6S9O0kJ4HSNVfsqGDy0PoABrug1iRKSOwrr3gjcPJUeBKmuNYF77lsqHUDlY?=
 =?us-ascii?Q?ygij2PMsLDB1DMI2oJHPUAJGlOO83Nn85T8vBCvZILyOGvA5aQ8tTKy4tj1h?=
 =?us-ascii?Q?/lh+UuYykliYVuPk563hhBjP1pMfsgcUjYjfmWp9Ov9mt8bXi16h3FxPENsb?=
 =?us-ascii?Q?2jH/mfxd1HCtNBqZ9n6jTLpyq0B8PqYfUbVs4KQykdqsPS9J9g1fkaH+6XHd?=
 =?us-ascii?Q?ZXFy4DxeoQG2mj7Gxunlb23dcZeMsjgNY8HyBRMQLMcMofDT/Uv/SJwTjC7D?=
 =?us-ascii?Q?Nb5wgk8NG5cGoB8StH5dMgC6bkpJ3JQuDJ9SdUN6idgXt/QwIgI5LJgc7pd+?=
 =?us-ascii?Q?bpMmeHLjePaFoEYPhnk4YTmm9ue3U3bTU98MOKC1e+CqnXXgAut6Y8cCa6qa?=
 =?us-ascii?Q?khjbxivm54zUZOBgr2JCUDcZ0scOJixsmOVOS6rfoC/7a0o8bOrV33auLB9A?=
 =?us-ascii?Q?Tg=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aeb0a52-72e8-4af4-5623-08db08884b81
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 21:22:48.0273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8t7Oen41H/vj/NtbUnxxBLa4l4HSj9V530Cu6ASzFPKneEFwZO0NsGxWxEWV13h3yadOJEsRVEX89ainrUmOh5DOwptsowkJhQ5u7MnXEPw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR17MB6863
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Feb 05, 2023 at 05:04:05PM -0800, Dan Williams wrote:
> The default mode for device-dax instances is backwards for RAM-regions
> as evidenced by the fact that it tends to catch end users by surprise.
> "Where is my memory?". Recall that platforms are increasingly shipping
> with performance-differentiated memory pools beyond typical DRAM and
> NUMA effects. This includes HBM (high-bandwidth-memory) and CXL (dynamic
> interleave, varied media types, and future fabric attached
> possibilities).
> 
> For this reason the EFI_MEMORY_SP (EFI Special Purpose Memory => Linux
> 'Soft Reserved') attribute is expected to be applied to all memory-pools
> that are not the general purpose pool. This designation gives an
> Operating System a chance to defer usage of a memory pool until later in
> the boot process where its performance properties can be interrogated
> and administrator policy can be applied.
> 
> 'Soft Reserved' memory can be anything from too limited and precious to
> be part of the general purpose pool (HBM), too slow to host hot kernel
> data structures (some PMEM media), or anything in between. However, in
> the absence of an explicit policy, the memory should at least be made
> usable by default. The current device-dax default hides all
> non-general-purpose memory behind a device interface.
> 
> The expectation is that the distribution of users that want the memory
> online by default vs device-dedicated-access by default follows the
> Pareto principle. A small number of enlightened users may want to do
> userspace memory management through a device, but general users just
> want the kernel to make the memory available with an option to get more
> advanced later.
> 
> Arrange for all device-dax instances not backed by PMEM to default to
> attaching to the dax_kmem driver. From there the baseline memory hotplug
> policy (CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE / memhp_default_state=)
> gates whether the memory comes online or stays offline. Where, if it
> stays offline, it can be reliably converted back to device-mode where it
> can be partitioned, or fronted by a userspace allocator.
> 
> So, if someone wants device-dax instances for their 'Soft Reserved'
> memory:
> 
> 1/ Build a kernel with CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=n or boot
>    with memhp_default_state=offline, or roll the dice and hope that the
>    kernel has not pinned a page in that memory before step 2.
> 
> 2/ Write a udev rule to convert the target dax device(s) from
>    'system-ram' mode to 'devdax' mode:
> 
>    daxctl reconfigure-device $dax -m devdax -f
> 
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Stupid question: when defaulting to online, do these devices get placed
into Zone Normal?  Is there a way for us, at a minimum, to online this
as Zone Moveable in an effort to assist the "hope the kernel has not
pinned a page" problem (and to try to keep kernel resources out of this
zone in general).

If this is covered by a different patch or already set up this way,
ignore me :]

~Gregory
