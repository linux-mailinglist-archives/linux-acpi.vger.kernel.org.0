Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54266924DE
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Feb 2023 18:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbjBJRyB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Feb 2023 12:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbjBJRxx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Feb 2023 12:53:53 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4343F7BFE0;
        Fri, 10 Feb 2023 09:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676051629; x=1707587629;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oFl0+QGvRhLKYpr89Y6LGwAnRPGFf/nBPmxg2YZhifg=;
  b=DIhROjDbmTkViVyP3+XgDqIB442Qro5yU+kITonl81AolwqtnHJVKxbu
   zcFiC9rqGLUOuiWZ+NpTVRrV6AH5h9APSc7fkj2541PghqjLvmNi5SVee
   NdIbFD8RoaYoUYCzffiZ4CtyXzYNaUspZ53jqshlq0eUUApKaymMWJTp2
   BNamvktWABUrkkSlnSjcjhGjIJDScPdce8FVvxLqyrwqjqDstX4F26/jH
   aVV8T2rTpVg+d0p6VdAmUxymbtm3+rRx6N5BalgGwBQItEmgMmWyNZRhb
   y6hsVMcTckeWHBllLzpjnhj72i2p7aXDB8VZhoqQU176CZTwAUTlFkLX9
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="332622318"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="332622318"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 09:53:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="668121817"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="668121817"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 10 Feb 2023 09:53:48 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 09:53:47 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 09:53:47 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 10 Feb 2023 09:53:47 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 10 Feb 2023 09:53:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sk+g35UL3zgBiT1YBwXqX5/QFx+/EfLluZO+KwFe26xa4BJlehJZhJX98ohFeWdCLvTafZtOgJX1QNkkg2OXQsBOeuPodqc/+vOPU0uHne5RwbMASjnWwUvmuHaDok6yBAqIM9ftSSqVfSKJNoqTwu1U3tJi0mZR5/3FR7pwXn7xnx+m3Fwz2NLi8KkjMbed1OQuYogcm38C4pdRZmB30MhiG1Nuq2hG0nsVSrSyBY3nOPEDpxbPpJzGkjWRlIgfnEsPtVuPigNAW8NvX9u+FVUrEivo9SS1VCZLwMzXe8/lJ5dqLN7TNZceisnGxMGEq6ZR0zDguzUBLXw+epXQJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/7XIJZwso05h2YP82Wv6bkHoRHvK8xt2yj3VV8M+lk=;
 b=PvGlimYpUfM/qSvmfN6FkNvXcXkg7+YI8oNKSm0FmFOHgJw3y7jmOTWePuU4VPLKVlc8xxouav1We3pblxwIFPjbqUGpgAwr5erL96smoGufwU2XhkQOUBBFyx3LlEs07ybcS3F6qkihcIAwUhoeURb223SHjPa1AQMRusnLp/DB9jNNJbTN41mX1cUbw0fJsBiiGxEJ9ykGSyo9zUL8aYA41pICI6fpVFQjBSeMLLyq9WD+xAcsJHUI8sbz1Fi+uzYpghYC2jZiO09g57lUvQ71IBthsvll0ahWGKylVlhfJQaJcGeUwrjizKlOknckEp37NiVNfMWRvqFJNhpQEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB7347.namprd11.prod.outlook.com (2603:10b6:610:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.21; Fri, 10 Feb
 2023 17:53:38 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6086.020; Fri, 10 Feb 2023
 17:53:38 +0000
Date:   Fri, 10 Feb 2023 09:53:35 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
CC:     Ira Weiny <ira.weiny@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Kees Cook" <keescook@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        "Gregory Price" <gregory.price@memverge.com>,
        Fan Ni <fan.ni@samsung.com>, <linux-mm@kvack.org>,
        <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v2 00/20] CXL RAM and the 'Soft Reserved' => 'System RAM'
 default
Message-ID: <63e6849f4c1a5_36c729462@dwillia2-xfh.jf.intel.com.notmuch>
References: <167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: BYAPR01CA0060.prod.exchangelabs.com (2603:10b6:a03:94::37)
 To PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB7347:EE_
X-MS-Office365-Filtering-Correlation-Id: 80ae3f04-d931-4562-3d8b-08db0b8fbd02
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bzYHLjEPzeSBNoObRoK27DMmepPAemujIugd2MUu9RyV/fVn0sRyMxTnH54QVKEx+eHzsQlU8K6TmLnqmGbhcrKfRn6przU4bsirhL6scADObpwTR3EbI4oH60jwcqpY3JPQiQQl2CYFswVe4BKAZsTdlW9UCyj6xgj/YbpD8aXhQe3v+zsvP9gYcXBU9YTUXBRFtw5lJf6I03muDCuOJG3z/F12yiDNZi5HwGtLNPW9TDf3mCyroZ9zkFTv2jvOAUaoCFfEfHMH/uGGWPXkukL9DGqPJGFnGgtb72LphsPRIPF0Uy9fQwDmLVAqVEGdyUOHdEG19AU55ho80Z8TV5e2YXlnl+5AWSfnyw4Zu92sYuo/ROJPXfaU+55acvkg+cFuQRQY3GBlnzIatvz31jfCfUudd9Mxlps5LTMdYzGMbyVvnhcl7SEbIL5RoEsrMCG5O1YfxT3Ko1VUla/yVp//7efpHGHIZtjmHw4UEwzxcbkhT7aibWix6hbOwji5N8I7YrWRD7MJvzC8WWfo032yc9ZGAIbKNSpCADmwIF9eBnvjWxkBDucajBk/yrpUHGmOO5Mw4l7C9M5R4xNcHFAMGaySwehxzawLYOxnUOsyF1tkiig5AXBrBLE81ZDt8am/r8/TtnOjgSUckMMY1FRroRwbsnVzVjt9XFKevuwNWcykkthy0y6nPRnc+JaJWS52x4nZVrLQPiGQGJTnKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(376002)(346002)(136003)(396003)(451199018)(38100700002)(82960400001)(86362001)(7416002)(2906002)(8936002)(66556008)(66946007)(66476007)(4326008)(5660300002)(8676002)(41300700001)(83380400001)(316002)(54906003)(966005)(26005)(186003)(9686003)(6666004)(6506007)(6512007)(6486002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e8/5vLSeJhFAuIcD305yH8UT3M7a/q3hRjHAt1QPYCNAQpEWlJAyplG8Kd03?=
 =?us-ascii?Q?Fm/COfImraJ0x2elT/ZCjDbBpM9I/LUAONrGg+zmtqk19L6Q9bHiiNX0i6fO?=
 =?us-ascii?Q?nE4PDoZ/P0chnLrz4TN46T0Io+MjTwUiNFva2YJptMrEDnMQwUPs8DRPLjYy?=
 =?us-ascii?Q?WHNWRk/WhcDyuajIC4o3Ujajhk850N1ML2e+5YQgCrzl7QljiGXmFEsM2PQZ?=
 =?us-ascii?Q?qrl/XezAsrxxqtam7M+MSi6AK+t6X7JDcP0I2N1nYJvITojK5S7PbTlx0SZG?=
 =?us-ascii?Q?BMqTS6qvAxfSWjDaniuaoHjLwEq9KYSQotkYpTnBP148hKUuMh9Jy7jyekQW?=
 =?us-ascii?Q?OWONvYGtkJPQ8oEFyvbjhWelr1nUILY+xNqeP0R4pF9FySb0Rvwx/Xx9BXdQ?=
 =?us-ascii?Q?X+K6L2UBMpkD1MSpS1jyGzA9KalooAcKKo9+lFALNs2wCT6vAWYKw7Tr15TW?=
 =?us-ascii?Q?ql16u++WPquNp5EhBItj3lTJf/LyyBcX/ry/ELez5HLcs3mjPg2wk6CvBPOV?=
 =?us-ascii?Q?4VRKuB08eEA6ibgxVwJ3j114Zieu7skzwRaq4jpyi5r7RjkHT8NtNg5aihD+?=
 =?us-ascii?Q?FSPG6PoBFCXeC2wXc8ZdHK70pRc5olm0c6acFfemtYupSZQ+QEjmbjUgbCQd?=
 =?us-ascii?Q?VYLx4AxHg7wSAG/n4BpmfDC1ofM4arHGXEmSs4hNpn4JFJQGYBNgu/JOr+Kn?=
 =?us-ascii?Q?i+hVqlMoP+Hj43Doz1m96WD3hawRyxBjFWOVCsI/T98dCGvci6NXI8qXfSrI?=
 =?us-ascii?Q?9ISM8wmV74ZtEGn6tcyCffB62vnmvdAiyTAPj0nvqTT8LOer4U0A8C0H5apF?=
 =?us-ascii?Q?6s7s7LYA8vu+eAOAxKCf12DRyVWBFO9NFZ32hPqdGD/uSaZjx7PvJg53v959?=
 =?us-ascii?Q?k4uKapJNYfIZKmOOhMjG2J4/3adca+515wXnmtLXytHtWcflFmpnBAoIcvCt?=
 =?us-ascii?Q?pU7ZAE4f60FLPPeuGK+bgTza34vOmp4w4Ze3C1oY5koZ54iC9ngx7ARu6txZ?=
 =?us-ascii?Q?U+XxBPEeNhZc7zK9nG0fhi1Cali5uaPLrCGopU9crxczvW0BwfjAP11d8PDQ?=
 =?us-ascii?Q?ZCurEDBxDShagJ/hoSmbkgrNqqhk+7WEajFigLtTc/JLxpOstcB74IcOzjvV?=
 =?us-ascii?Q?9EuaqezBIRSYEH6MOD/Mb4DBG2HkDqbXYd+J3aYHTw1vVyp6MmDRdsmLwHCi?=
 =?us-ascii?Q?Bg1+wql/EyNbGIgZ/VxrM/z1iaLhyiO0JMbZXN58YE+kPG1nysdfVMlsl2m+?=
 =?us-ascii?Q?k9nwzRdVd9sgPSQCYEonAIUw4sUtZ9WWfwSBgozGW/I0ZJtle5/fUuWUeOJr?=
 =?us-ascii?Q?jFKODgnbWSSH+GIusyENqhovBLCZvscQ3Aaqf0E7Go+zQSsBSFMsU59Z3eMy?=
 =?us-ascii?Q?w/MJVDtZbxIEi8FgN5Rb5bDQgqHgfzHaPCldcVAUlQ3izMB+gnBCbPDzcZRO?=
 =?us-ascii?Q?PK6s1hN8XhUi7d8sdzSPzB6nCLHaCJ5X7zudkuguP4M7ctGUGFhM7qcp85iT?=
 =?us-ascii?Q?XCuuhqAxDrZjZhHgC68LW7e+U786AIFPPR0LtUfUmfYwA1IwplNCRcia0azv?=
 =?us-ascii?Q?FruwbVZKBSgpbqk4sYIGqjUeZhbEVujvUJcWPvodXwnYTuFCTmnwr0HuxD6v?=
 =?us-ascii?Q?Ug=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ae3f04-d931-4562-3d8b-08db0b8fbd02
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 17:53:38.4526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SjGmSra6LVpzaLVsc4LThimjHWptbiXAjniJQryXl40Kg1OQZC1yoc/ZMZEKUEyjXz+1sOM5Wn1MVHXS4XCjw7IfjvPvVTqJrIZYYzvTpG8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7347
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dan Williams wrote:
> Changes since v1: [1]
> - Add a fix for memdev removal racing port removal (found by unit tests)
> - Add a fix to unwind region target list updates on error in
>   cxl_region_attach() (Jonathan)
> - Move the passthrough decoder fix for submission for v6.2-final (Greg)
> - Fix wrong initcall for cxl_core (Gregory and Davidlohr)
> - Add an endpoint decoder state (CXL_DECODER_STATE_AUTO) to replace
>   the flag CXL_DECODER_F_AUTO (Jonathan)
> - Reflow cmp_decode_pos() to reduce levels of indentation (Jonathan)
> - Fix a leaked reference count in cxl_add_to_region() (Jonathan)
> - Make cxl_add_to_region() return an error (Jonathan)
> - Fix several spurious whitespace changes (Jonathan)
> - Cleanup some spurious changes from the tools/testing/cxl update
>   (Jonathan)
> - Test for == CXL_CONFIG_COMMIT rather than >= CXL_CONFIG_COMMIT
>   (Jonathan)
> - Add comment to clarify device_attach() return code expectation in
>   cxl_add_to_region() (Jonathan)
> - Add a patch to split cxl_port_probe() into switch and endpoint port
>   probe calls (Jonathan)
> - Collect reviewed-by and tested-by tags
> 
> [1]: http://lore.kernel.org/r/167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com
> 
> ---
> Cover letter same as v1

Thanks for all the review so far! The outstanding backlog is still too
high to definitively say this will make v6.3:

http://lore.kernel.org/r/167601992789.1924368.8083994227892600608.stgit@dwillia2-xfh.jf.intel.com
http://lore.kernel.org/r/167601996980.1924368.390423634911157277.stgit@dwillia2-xfh.jf.intel.com
http://lore.kernel.org/r/167601999378.1924368.15071142145866277623.stgit@dwillia2-xfh.jf.intel.com
http://lore.kernel.org/r/167601999958.1924368.9366954455835735048.stgit@dwillia2-xfh.jf.intel.com
http://lore.kernel.org/r/167602000547.1924368.11613151863880268868.stgit@dwillia2-xfh.jf.intel.com
http://lore.kernel.org/r/167602001107.1924368.11562316181038595611.stgit@dwillia2-xfh.jf.intel.com
http://lore.kernel.org/r/167602002771.1924368.5653558226424530127.stgit@dwillia2-xfh.jf.intel.com
http://lore.kernel.org/r/167602003896.1924368.10335442077318970468.stgit@dwillia2-xfh.jf.intel.com

...what I plan to do is provisionally include it in -next and then make
a judgement call next Friday.

I am encouraged by Fan's test results:

http://lore.kernel.org/r/20230208173720.GA709329@bgt-140510-bm03

...and am reminded that there are some non-trivial TODOs pent up behind
region enumeration:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9ea4dcf49878
