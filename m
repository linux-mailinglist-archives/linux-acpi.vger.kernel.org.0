Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9226568C936
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Feb 2023 23:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjBFWQN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Feb 2023 17:16:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjBFWQM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2023 17:16:12 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A882126DD;
        Mon,  6 Feb 2023 14:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675721771; x=1707257771;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0RRzC/wdLeCuBxhyimDYOxDAhhSUJ8kbDilMnjk3dv8=;
  b=Fi4vY3oWIWH4aRyUCloOvi1oZSvmBETepO183ffm78AezGtQ1NSEQaoV
   Fdw0Ad27kuaqrADNgz9rJqi6fOWe3DurrSJR7IEIexP8FgAhY1K6To6KG
   jfg/43QMvAzkGcDi4CP6Bc6CrOh85RCrajwMy+L0H/iI/zKMELJzPRX/F
   trcyRTRyTU560TE26AqWh/pfcc5rsVZ5AuILjVzeCH9QDyNUWsMb/oi3x
   GOiUbSPmvyx42QpP2LZohe21rys6WA1b1xMrfWLcHFfP0uMBWE214tci9
   9cnNbUus4IVQVYbhUGVOTsjVZNKNCskqEJyUW6bxxKJfT1mbQPT2BWhzc
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="312983035"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="312983035"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 14:16:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="697022905"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="697022905"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 06 Feb 2023 14:16:02 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 14:16:02 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 6 Feb 2023 14:16:02 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 6 Feb 2023 14:16:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AfkcM8P7MFEAYMrNUnVNt2vHq3Sg4QvmDs64BoH9xfnr9PcJUmLxu0CmYHny/l6SF7gnqydHYOWnXWSP1ezqaSmxVLaTxqjjL9XHYnRL8ggB4sK+q8BiNIwT5RvDh6oE5Cj20RqwaVkDyTAz98m9DkkUsOsXyE0uUv0d7F4o75uAyoOWXYfZ7dRr4kAXra/Skz+RchO0rZC9hy591IBkxBntdeslgEIZBh8SgbHcL+ZxH0Xs4SRPv34jMZ0zUVyCmJfds5ZKIEJeOYJMo/eP1ogy7j8El/4iWQVd/kF8SKICx28gW3bxRQYIuJAgSjdPts1fsm++l7M0CKddSvubHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ohBOVOvl0M/MaTbzj0k9OAhjTzzhteLr92S8jnxPA0=;
 b=c3YvY58T9E/mZIUK9sWPlC7FW934eskvp6T2GHDWJ6ji2XqbS4pyxF4QhuxsNRbsRtPyWP16D17yPEWPrjvAoMC6wYDN1ML4hHcjXpiwrnIkLs8kMptUUNhT5p8ys3yLYMfovnebSu8l/lzmXRZZ6pUmE7SipY3bHZbf5AUAapGBhLC0Q2TG99nC40qOh5ngbrx8uX30x1V1igMhK/k93zwlFTbgrI8FMryl2MujjOQxXHCXH+YwRVLN/EoXri7+GE8B3ownzJV4isB/MWDOXnZkxKg98ksW9HLlq4APVyc3heQORC0StvqfaVqjTxNzl+VlZeIIYCjIbWEie7an/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL3PR11MB6531.namprd11.prod.outlook.com (2603:10b6:208:38e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Mon, 6 Feb
 2023 22:15:59 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%6]) with mapi id 15.20.6064.031; Mon, 6 Feb 2023
 22:15:59 +0000
Date:   Mon, 6 Feb 2023 14:15:56 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Gregory Price <gregory.price@memverge.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Michal Hocko <mhocko@suse.com>,
        "David Hildenbrand" <david@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 17/18] dax: Assign RAM regions to memory-hotplug by
 default
Message-ID: <63e17c1c4f8a3_e3dae29457@dwillia2-xfh.jf.intel.com.notmuch>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
 <167564544513.847146.4645646177864365755.stgit@dwillia2-xfh.jf.intel.com>
 <Y+E4UGJhKXIj7ssm@memverge.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y+E4UGJhKXIj7ssm@memverge.com>
X-ClientProxiedBy: SJ0PR13CA0099.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL3PR11MB6531:EE_
X-MS-Office365-Filtering-Correlation-Id: b0dde053-743c-446c-4dea-08db088fb941
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mSqr0FOPiitiKiGB6OCKIvWRmzsPzmmmwz7yqJ3tjTO+41xkfe1BHhRMwe7VGo+11z9I3eINIWlVY8OW24gNHfpLSAMJUutPt6SCpfkTGwyQM0wV7Q1v0IRB6w8RMunXtx1ZpnA+62WeUjUxa/ta/Z7MUbrReiMUKiTlXwSoc4mw4d6iWYrNPHB+lcJ7pTb0EqR3cX9bJcxiZ1BYbjZ65Zbs2LQKvz356bvpFnZXW2qJYwaM60KdjkP8dl95rOE7oZd5J/TAoYIpZZo8WF/mQI9zIOdsESG22zM7GYC4P3gVS2oHertWqb94UMnnBghcfLskQCGT/hc1N5oaBDic6dykCd0ufg8hBxEMHlOtCPlqmzJHcK408DkFcQipp6nHtXn4oEDAj+QFQH5/JTqP+0NRIt+rM5Htv1P8XUM+H6Tnkwj1aXea1LyNxDTP1HNDjo3KIsvFeGQj1UhDLfzQ5QxUA92O824sSYd4hMv2VeknIAwQZfJ3v6dWhe4hrEuGAodrYvHKouO2QfZPQ7I0TE0wKyIoM6B4vv0IBQQG0CPK4pp0izLTbfUT9UpCDO0Vv4W/QbxvWG8i1E0BrMp2OFbZxAiZ+BsGV3nbmx2SpkD5KpbJ+UErWgDQeit38CxqYExYtUVc/w2ckuE7Q6h4Vhk6Snbvj54K1OpmhYzlaBRgANGz8MOw1DszMCyXIWzQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199018)(8936002)(5660300002)(83380400001)(82960400001)(54906003)(38100700002)(110136005)(4326008)(316002)(41300700001)(9686003)(66476007)(66556008)(186003)(6512007)(478600001)(26005)(66946007)(6486002)(6506007)(86362001)(6666004)(8676002)(4744005)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qgiQawXbQ8pQLB282N3di8yga66LIB7kWM8bJdx1+BjcmTdco3fzPMM1T7wT?=
 =?us-ascii?Q?ukoskQCJZEa6h3KjhkyMc/DUh74x07XWHPKWFFx1L6u9H5is9A9IsBxywbet?=
 =?us-ascii?Q?5FDXTe8jGCJyED7+P/WUSLIrNbQwaBXuD+qrDR+UDAKkarPVwpUwZ1G8mIyG?=
 =?us-ascii?Q?7L4nFBgHrSMCQOwlByEW2hOmj4s7FdGazwx3ALCvWPPW6Ks0a11KwzKaon0K?=
 =?us-ascii?Q?iLP++of6Delr83vZgMVneKIuWzetCpIfC2Z9dqpsh+hlZjcyfytBbJbEFZpq?=
 =?us-ascii?Q?N8ImYVOEftQenLMazZ4KeUflM/KSl9Vjg4snzNhDVMdL4o7dKSARw4tjIQGY?=
 =?us-ascii?Q?7zGdxBnp9Eh7hLzYGABkwOuNGW5+iB99wbly7VT2jRfY3qXIGXtLiawe0zcO?=
 =?us-ascii?Q?cS8xOUZt9TmzhfBvw7ybM2sZpIKxRZ+SzjGcDrJYInfkE7d6Pff5sC7jQlxH?=
 =?us-ascii?Q?/1g/+RafEMZoSs/WxYru+prxyZTa3r0VTf3Z/5kRKmH2yXVVtJFlL19ZdX/0?=
 =?us-ascii?Q?5L0iA+2p76/1/5pcGFNXwcqkFOwISd2RtEruc113BRjncZHdPphYU1fHGiHX?=
 =?us-ascii?Q?uwewe6ggwKfIdBIUxB4dYFQQXLOaWQ3MSiKjKvI+ZGUw8FjRJVI3RNWya5Vd?=
 =?us-ascii?Q?ahFV6I+/e9+XTP3rxa45EQkabu8wBOIQqMk+Xqkq7j4FTaC1nfzKZQZl2v0u?=
 =?us-ascii?Q?WPyOMFP9sh7vBIzIhVZjleWaNtl6tgTpLhO5tjsOpFHEATCMt7aikjdXY6GH?=
 =?us-ascii?Q?yxbznD5E20Kv06iEThL2M76JGmGmRrC/Hvt3A7Wj2QwSQnp55TJptCjAh6zg?=
 =?us-ascii?Q?yZ/KHhcIR4IXLQtWq43OAVw/j9RorcYVqeEpQwFuQUeT/LzvR2OmUkLCOYEw?=
 =?us-ascii?Q?Uw2BaBxBDGzd2u/x5ijmSkub+L858uQOQxTpSKWz+DBDMpS81wkeSYoJZ34o?=
 =?us-ascii?Q?PNxK8MSxH8x1n70M6PdZxxVmkCbVc0il6byOLrDyVwn8KhJp9b7ZlB2EuXv3?=
 =?us-ascii?Q?wxVdQLt5yFNLW5XxP86w+mBOUx6E9LzdrXbdP6t2veKyY+iNmBp6omJzrSim?=
 =?us-ascii?Q?oZAHAcLftuttRbbmiYiHjeRrQlLbut4+MNfp4IKlzc0sl2IHb0y+eA6FCaV7?=
 =?us-ascii?Q?3eFODf9xuOgqvAl7wMel6pY8qshfkPNjtTTPa+05dD31kSjJPP+cAwCk6X1m?=
 =?us-ascii?Q?NK46NLBZNKaAqkUoKwunLmbqiMlce1gvLLiIYFYFT2ngGsgLU0pj8iQbn2yS?=
 =?us-ascii?Q?wRcmzk4q3AM/JR8znSaogGYiFQdhyhhGl415zOXGq+YOuAavwrFYBu7OYrW3?=
 =?us-ascii?Q?fAQQKXcl+ZOiGmuO+T34rb9IjdLLLuumCIz1vUitpxxcA3pf9ho3VKayW2fI?=
 =?us-ascii?Q?EfcyqBAqOuiCvNstQVQdM4OoGOwsADFueqPVeOnbCTXA3baN9DSVy1YvJHRD?=
 =?us-ascii?Q?+cqchy4lnOkU93HDJuXKV+N6rSmarp3fQqr3uC7czCiTnRseQ60vW7jnPo14?=
 =?us-ascii?Q?YyC6rZGYZLlgckON66oPjk6mTdRFLt3X7zd13Nm3bCPIgOtg8w0QxmNb7U4y?=
 =?us-ascii?Q?ckiMUmK2icQ5N8GW5pU8kzc483xGFnhDjxSwJCoovdEEAaZJ5JZ5T4e+wf6l?=
 =?us-ascii?Q?Uw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b0dde053-743c-446c-4dea-08db088fb941
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 22:15:58.6715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HUK/p7lyXuCykwa2m2CFQAoAXMdGmk+uPNSENqH6o43wYJMkZN/d38aSQQCifk17aW4OwvEOMU5JqJIde3aCM7HvGw5X0kdNSmDXaGOQ+q0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6531
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Gregory Price wrote:
> On Sun, Feb 05, 2023 at 05:04:05PM -0800, Dan Williams wrote:
[..]
> 
> Stupid question: when defaulting to online, do these devices get placed
> into Zone Normal?  Is there a way for us, at a minimum, to online this
> as Zone Moveable in an effort to assist the "hope the kernel has not
> pinned a page" problem (and to try to keep kernel resources out of this
> zone in general).
> 
> If this is covered by a different patch or already set up this way,
> ignore me :]

Have a look in Documentation/admin-guide/mm/memory-hotplug.rst, the
'daxctl recconfigure-device' man page and the the policy options of how
hot-added memory is brought online.

The routing can be anything from fully offline device-dax, to fully
online ZONE_NORMAL, or even a mix of device-dax subdivision,
ZONE_NORMAL, and ZONE_MOVABLE memblocks all within one CXL ram region.
