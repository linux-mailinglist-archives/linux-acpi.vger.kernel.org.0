Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9521768CA72
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Feb 2023 00:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjBFXVL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Feb 2023 18:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBFXVK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2023 18:21:10 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6D82BF23;
        Mon,  6 Feb 2023 15:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675725664; x=1707261664;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5CkXuJDspncLdcCyB1tgCdsfguDeAROb4u8hnlOpuOs=;
  b=LkeVriW7aMN1iODErqJxm4diAs4ZbhZbGpjYbD2X+yyC8O8cH+tbj05h
   O85ETpTvLMePfA3/yMKtncZhtlO8UkPVa3xhhvfmMHkLVYrasWYBenrYN
   TD+CdlgJpH7MVRjuYPTCoO32KdFGOtloEYRFysUgO5XtaJLNbGOLLluTL
   QPAayuHDyraDbqosvTmCWt3ZEJ7ZkxXqr9q5neTWOGMLnUJp+h5sp0rcs
   C/sECXN0LGHmufPclZWzcruEPaMqAOAztx1EUXsHSJ3UDZjBGpqOoeCxM
   mHex8xwACMO8TSDjiiifKnrve+Q7LXy2CelwXixf8IW8ctCEuZOAijQRl
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="415555434"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="415555434"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 15:21:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="659997984"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="659997984"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 06 Feb 2023 15:21:02 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 15:21:02 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 15:21:01 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 6 Feb 2023 15:21:01 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 6 Feb 2023 15:21:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YemdzIqpSPiFE46MqXMlhyxDm5Z0hq+B7w3EWWhDezaOROjlVg5XzZb2w/kMIsb5jNkyiUD8FNLG/pte9BoS4Cbx2ynBhL25OWuciLgruMMWgv2mkTe3yIc5WpE1HbcLgqwoi+8DDB/9Yb3uQHC8GVLqDaYvblthm02fo5orArFzwK+an3YVPztyxaL+VHLCIqCf5gH9dxpTYzbEj4wO6KIb/P/MAjigYpWe615o9c1K7YQqccYzzufxeAPZcI+gIBLtPVnD/uCAEdDbfP954l0O+xv2rCX1UxSvsV8PHm0LYdwWwq6iD8ZOkiz3zbD38ksKJHKyUod/rZYLtLVjZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nO3qouUf+pn6sNwloDaeyMEM0c8o1iUeW5HwkHRFeds=;
 b=eKb7Vs4B17JTdNIxpibqIl0YMUDIyNNZEq30axcU0r/yu0fRnqzIyHgpVScd5Qyr+jT8OnV2YSamEXHIu48fianZtIIzWsMRs3nt4XYc7DmYN8CiUM1/nADKfchoS5g7HZ/zlMDI/aLQdMRZbYuDCA/SayCnhDYh6j2fD2jqhLQtatyNg40kpCdwL3ZPAi8nqK3EqPvCgPoFuISgknWPfj7B411k2DrsWWuEM0bb/gpIWBsdlPBg+a2BMWQwXGTX0sVAits2NDv1xaOxdPsBEsFEV4RmHes9JIPnrb9Vuu7X1xawh5CKU0ZosE3u1kPxE8KvnrnfmzW4VFA+CZuaug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB6671.namprd11.prod.outlook.com (2603:10b6:a03:44b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.35; Mon, 6 Feb
 2023 23:20:59 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%6]) with mapi id 15.20.6064.031; Mon, 6 Feb 2023
 23:20:58 +0000
Date:   Mon, 6 Feb 2023 15:20:51 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Gregory Price <gregory.price@memverge.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Michal Hocko <mhocko@suse.com>,
        "David Hildenbrand" <david@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 17/18] dax: Assign RAM regions to memory-hotplug by
 default
Message-ID: <63e18b5327eb4_1049ea294c2@dwillia2-xfh.jf.intel.com.notmuch>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
 <167564544513.847146.4645646177864365755.stgit@dwillia2-xfh.jf.intel.com>
 <Y+E4UGJhKXIj7ssm@memverge.com>
 <63e17c1c4f8a3_e3dae29457@dwillia2-xfh.jf.intel.com.notmuch>
 <Y+FPiePV0Pn561yw@memverge.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y+FPiePV0Pn561yw@memverge.com>
X-ClientProxiedBy: SJ0PR13CA0179.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB6671:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bcddb2d-3b3c-4c7f-e0d8-08db0898cdf2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1e52Dq3+K0huqwp/ll4xVLJ2NeovrS3hAwj7yMi0+npUaUNW8YKneReshcR3nahiGgI3njtTGpiotMen3sw96cAeYdYuN8OEOEwMRlhUtpGBjTxUVttyN8mXG5OrSB0NAxfe3gc1baMmK2mcOpvumCcyitCToPO14jLi4zpNW98jx/nv3YBAd77ybfTs/+WBSv4gsuL/v/kwMmyADlrW1T5iB1sceBbsq3LpOiZzo3a714mkIYYmTX4fXp+oSKDXK7t6sMSroK4z9KMR9moZ9npDy3NyXDNU6vs+G8VOHv1P3ZDh7F9eljuXl4Go8vwz1VmRpEGACiV3Xa5evfqJnFQe4/dyQivQgVNMNc08B/JAgBVumZxUgXEXLRXWfqBSamy8CgdS+1DFY881a3dLVr61KkMMbjjgSVgCu6i3xSNaKjgJjdD9CJ9W+nbaR2ye6kS11HniG2+RZxErxw6rpJUzL3OpihMA8ooRyCHfFkdjCnBuJkxw9gR4AvsA4N/KJmZb7d7ukayWUPr0l2RFpec8YGvaKEcUNlLmvFV60cYoMhBkWEhmTk8BHCZX26j0RTDGpGp4y9JYzFlg2JLwh3CAyipoXt5odFpEI1HJhK+Hep8t2iSrWpdJMUfk6NBO1AKofmTifwxvXV/YsxvYMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199018)(6512007)(86362001)(9686003)(66556008)(66946007)(26005)(8676002)(186003)(66476007)(4326008)(110136005)(6486002)(316002)(54906003)(478600001)(6666004)(6506007)(82960400001)(38100700002)(41300700001)(8936002)(5660300002)(2906002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CV8okdIyNzyCvSn791m/v8vx7/gUfCLBgdlevKCiT7ypSuUY4D6kuz6hleOG?=
 =?us-ascii?Q?CPTCS43u2TmLJppkk6ZZ8zAlwv1+WtgCtnHdyXzn4AP8SMdr0I6DLGD51Nwe?=
 =?us-ascii?Q?kiLQMb/itv4Cth528jo6V0W0f4ubG1xni+EYKpRV6shxu2FTgBmctCH3C34D?=
 =?us-ascii?Q?rNMLCuTHeS2iSDNzeqFTOmQOWz6jlbrYBjmbAW/fLveh6+IsH8Lzmo9zreqv?=
 =?us-ascii?Q?KLchahqBAr5iTTmXqTUiUFRFfK5L8eH2sU6oIyNjbR/n+OVw0NmfGoe5dD9i?=
 =?us-ascii?Q?Y6IykG+QmCTWkEDj1WamD3ZnDw1LZALLet8WtC6BdaA/O2djVrsmxAaiABnI?=
 =?us-ascii?Q?588CGk7ho0eMjKHGSte+H3ExZi+k1SMCazWbroE3yeOkbenfxdQC8xinsNVk?=
 =?us-ascii?Q?jAmY/dLwLv1qGDIXQVN788As3SD4jQZgGfj7eZ48SY+u/btc39DBc0AuI2wo?=
 =?us-ascii?Q?FZlH84qMfSTZb2z3lJe5wMaHEJrsXlQ6auSAQPUAqMy+MzXLUJs1LQP+x4vt?=
 =?us-ascii?Q?dHIJMzdC5JKB8HUbnIhE533HNUJs3cAqPztY+de3bFtMrzLjpXQ7N33os5uW?=
 =?us-ascii?Q?ArRDIyo9/LAxaUMh31NfpNQqIfh7flMG2CzLlu73ztd4cagEHTOapb00q+J/?=
 =?us-ascii?Q?7YCq5han8rqRqLwTDBq1Mvao3AK7Dq26RIb9IZo49BVbmobMJ2s/kM7+KD/v?=
 =?us-ascii?Q?/S46EoOBhUTTLMHS9WXpjW5KUkpCm13TvDJ9gcVaErTavs/v0NuNNEi7afYC?=
 =?us-ascii?Q?0ykgQ7t6frq4pwwrJtJcO1d31vygpQG4JrZ0n9nwHE0Syny+cMqCcGkkT7Ke?=
 =?us-ascii?Q?3dLYrHK+zRkEJFAgnmjGwm1PtiyNlDCmu8oeFsfDAHNdrVXNeIOvC4KcWidi?=
 =?us-ascii?Q?UINV/2sjNPZqUj5pzJL2X32ZAm9rgGqDsTPihxi/hrP4OaQLjX43BE4QKKQ5?=
 =?us-ascii?Q?BgDieEXpC5s3xba3EoqcSUQT9z0TeMxGiiMIiwMtY9dXJzaZlDf4glsK/C+9?=
 =?us-ascii?Q?06u1Twv0WxiLXVvVstq0NsY9wyyuLEwG+exrGOguWpAeymBDDkQbJCdPQmd7?=
 =?us-ascii?Q?1OZPQvnoQkbCQi7MoNP0lcyUF2DnNW2zEfQhyKsEBe9r7AgIBIAZu4FeOLFL?=
 =?us-ascii?Q?XVvuZ6825VggR67C1e6EYeIMRqZNqW2y6+m39482d6syCIzFt46BGxB/cyE4?=
 =?us-ascii?Q?OawJhWRKrtGUyYaOkpy/2vT5WQ0XKc8tUfI/srj4Jv22PmxIHugLci5805/n?=
 =?us-ascii?Q?E2w6zCsHRlxeHHdKFa0Dyg6ryO7P+KCIbP8ltKvDlqxzVg2+5QH2W4jeMDW5?=
 =?us-ascii?Q?slz59CSkQAYYuubrDlPH5E4JAL5t7DY0cATDT2ro8rB73A13TTfAJsMMNzYc?=
 =?us-ascii?Q?/4SLJV28d8iPP+C69y2AhvDiYJn4+Tz2DM6PA1Kgsz6d/gcgv3WXBCj1zLNc?=
 =?us-ascii?Q?vqd0WPI4RVtlmA/SaKkXUVwr8d2ZCVNTPxCZJBGYKt4vEx/Wcbaa7coE6CKc?=
 =?us-ascii?Q?tGfks4Uiz6q4MnqQ5poKXEjT0AZ80ObNbmevWKRLciN1B9t1tYA8dXB+3bez?=
 =?us-ascii?Q?FWc8sr5dN4PWhW9oJzhExMZCBfMer3nDsjWND4nIwFhSHbO1pob1il/t6KOF?=
 =?us-ascii?Q?gA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bcddb2d-3b3c-4c7f-e0d8-08db0898cdf2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 23:20:58.8355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pTnAJYi4uWoTNEBuVpUyqEF23c9lvsr8PzSlbtPnlleED3GYB6gULryWhmyW6QWsm9t2rxi5GZ3XpKQVuJ75p8RayOx6+SS8BzUY254Ek54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6671
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Gregory Price wrote:
> On Mon, Feb 06, 2023 at 02:15:56PM -0800, Dan Williams wrote:
> > Gregory Price wrote:
> > > On Sun, Feb 05, 2023 at 05:04:05PM -0800, Dan Williams wrote:
> > [..]
> > > 
> > > Stupid question: when defaulting to online, do these devices get placed
> > > into Zone Normal?  Is there a way for us, at a minimum, to online this
> > > as Zone Moveable in an effort to assist the "hope the kernel has not
> > > pinned a page" problem (and to try to keep kernel resources out of this
> > > zone in general).
> > > 
> > > If this is covered by a different patch or already set up this way,
> > > ignore me :]
> > 
> > Have a look in Documentation/admin-guide/mm/memory-hotplug.rst, the
> > 'daxctl recconfigure-device' man page and the the policy options of how
> > hot-added memory is brought online.
> > 
> > The routing can be anything from fully offline device-dax, to fully
> > online ZONE_NORMAL, or even a mix of device-dax subdivision,
> > ZONE_NORMAL, and ZONE_MOVABLE memblocks all within one CXL ram region.
> 
> Hm.
> 
> I'm just thinking, for early expander devices the assumption that the
> default behavior should be auto-online is good.  Just kinda working
> through this in my head for multi-headed devices and early pools, and I
> suppose the kernel paremeter covers that. Most of those will be used in
> specialty, vertically integrated systems, so we're good to go.
> 
> In the future when we get fully featured DCD's, I imagine we will have a
> memory region of size X, with N memory blocks, but only some of those
> blocks are online.  I suppose it could also be done such that DCD capacity
> add events drive the creation of new blocks under the region, as opposed
> to having the region pre-create the blocks.

In the case of DCD the proposal is "sparse" dax regions. So there will
be nothing to online by default until extents start arriving. I do
expect DCD systems will opt for memhp_default_state=offline so that
userspace policy can be applied.

> Either way I think the kernel parameter probably covers this case as
> well, I'm just wondering if at some point the default will yet again
> wish to be false, but i think that's a "CXL has become so successful all
> memory is now CXL DCDs and computers look radically different" scenario.

It's a distro policy. Fedora and RHEL, for example, pick different
defaults.
