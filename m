Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E8868C6B4
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Feb 2023 20:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjBFTYA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Feb 2023 14:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjBFTX7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2023 14:23:59 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB9E1B304;
        Mon,  6 Feb 2023 11:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675711438; x=1707247438;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=yOOHT6L8SPPRSBX/JDgT+BMwBqlJIjnyQXxGJWdK+L0=;
  b=TgEOXHeSkiVIPnAEAs93wPmj/rF1ItkHxq6822IBafI1kipyuyy/sitz
   0jYID2Z8fuJY15hZO7yH72CgZSv4VMAH7Mvd329K2p6PQSA1o3j4ZPi6B
   5ttYFoT4zQILam3JuWtxrNWgSFzfOmgBBP0cKj3UYaS8ShGQ+tgcbNfCG
   flrgtmo/GNVhGHmSFIEcoP3V+Htlq9Bdug1k/xLSMeXXp7fOKDJXVn/uO
   VFqizPUmU+jehOJbRr/nBXgQx2sGQZ2p3yvCEHGsYJ5+dfMTglPkpORfy
   SKaMaFTxWbVkKtghN5QOcuxbbhGvGnM08Gvbv+RXA8VrcnjTvXhGuYWki
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="309627815"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="309627815"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 11:23:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="696969923"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="696969923"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 06 Feb 2023 11:23:56 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 11:23:55 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 11:23:55 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 6 Feb 2023 11:23:55 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 6 Feb 2023 11:23:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZIwmO+S3R9zGGqYwqu2KFAIe8ZxttFcCitCQbzBGF3HDzsYUeimn2ZstCmS8xkjdbTcQhZldZNRmntD/Xdn4ExLNb9vHMmNc4ge00myJSFIih/P4nqPVwKHdDAMMoRu56LQgdkoWtLZ+/7pVZBeUAtO4QhSaFgeSqWcCicV5hwLOyxff8TFY0o7AIZLX2uAkVTyZcfCzslIf5lv7bxNdv98coNjAjN18+miAoPpIVjJ3Pa7iSeh7jD3Pfu0DezZY/3a1pGXKrSzq6jwUakhbaujcA1ynqxAyaPrMCsr9zsRL3/r6n3cimhvqReLrzqjp/tTiVgdoTDCLW+gwE2OiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8KY1+LQS5NYHE/6MFdkCzFxBBsltOHe/tvO422/h20=;
 b=d9q0OZGMPNQxPk8CkP5L3l+UNoWj5PB27NFYY4LCZaU1YvGqyngb/ki2zCghhAcoEQs7CenJrimcnkX5zCQlDN7ZalBYx/b0HSZIFyHu56CYv2aAECxRuWnReP9zhTK3+zkBzcDQkZE6ztxvGqS2Po5hqxGzeiubAWrjB2WDvejLhk0VFnnoqrHREnAACqV6ZM2dFV9K1+YOTtODuLtKhNeui8DT9cMeHnfGKtY/aB2UtwK18XHv8QirdO/cCGszSwN/iG2+GJkr9V9YLH/erOR3qStAJuIUZFmtKYO29akwPZmZVEqK0TEATQZ/+ov0AY3Ncvd0smzU3kdmw+JxOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ1PR11MB6178.namprd11.prod.outlook.com (2603:10b6:a03:45b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Mon, 6 Feb
 2023 19:23:53 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6%9]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 19:23:53 +0000
Date:   Mon, 6 Feb 2023 11:23:50 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
CC:     <dave.hansen@linux.intel.com>, <linux-mm@kvack.org>,
        <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 04/18] cxl/region: Validate region mode vs decoder mode
Message-ID: <63e153c69c57d_fd49e294f3@iweiny-mobl.notmuch>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
 <167564537131.847146.9020072654741860107.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <167564537131.847146.9020072654741860107.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: SJ0PR13CA0004.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::9) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ1PR11MB6178:EE_
X-MS-Office365-Filtering-Correlation-Id: 75c28e9b-266b-44e8-0247-08db0877aee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k8NwN6TGmWrn0cdmF6ajY2s3qTyeOCzIKS68pcy8MvcSCQMJBU3DnvVZdjONZVsSEPtnE3ShyECbRx1JcpD8wDxs60xbz0RhBDzjubpoMU6wjYNGMIWvDmm5NhY417f9Z8mg2vKa5LPrZ2c7XZ2OloGzK7yGEzQDAfNZ14Zh8d7N9/XReBoOGIK8o5e/sNOQ4XGptyNnUu2+b7AfdjLOEwpyD4G5QdS73Zb+XALOhCNiCEZoSgnE2UfEFMSlSR4NUTcgqspI+4dWHiNx25q583gAufmREypyrKzQYYS2pgtECLfVbfYicHHcg5v7dG5lMODuhRMpaoNBGJ3uanMtlr42fzcRBDVpKqIYhX7nPDje0m8/m+/5EfLF0NVl16GPpoUeCsU9JCVEiRuvGhNlf01hfL1IWOIPFLTJzT6du/v/BAnaVgn0tvlDTo8XeANGr2eHupx3Cnp7zbpLXhTjevLcD5xhOUxgYdrSfvQwDetZm+NkipYawPgQfgOrAq9Pe/LIHG9I+7T/FNsRt6wCbAWVKpYgIHH0GDDtCoS67rvRzBtuhjw1rFRox96Jz/+F0z4/Z5vTBWQxblKmsqOw+VXpBTaNaQfxteXP2LpDoWKh079YronFG+3hCT0TcaqjH2TouOzdcO3JlrsfrQqFHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(136003)(376002)(39860400002)(366004)(451199018)(6486002)(41300700001)(9686003)(2906002)(478600001)(26005)(186003)(6512007)(66556008)(6506007)(66946007)(8936002)(66476007)(8676002)(4326008)(44832011)(316002)(5660300002)(38100700002)(86362001)(558084003)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B4I0ZxpNunGgCE+8Vv6rcZIk7y/wkchL5xmk43X2PujgPJAOtRiDL87rwIJo?=
 =?us-ascii?Q?BS7/GtfeBDKTNnywx/GhzmB6TP2nORRTapekxcbY/LSfKVHYux9IFCH6inhm?=
 =?us-ascii?Q?NLS/XJci0QlUxyaMHU6E5cJWoFdEUky2LrI4bXHOb8wsURvc0ZkK5tHMF40Y?=
 =?us-ascii?Q?yEoyRuNZP9dGxo47C5dNE9m/BNqBOzIUMi5Ojq8jLcyJjY9qqFnDwTEpxOd7?=
 =?us-ascii?Q?4ghXnDmEBSxgVyoANmQh9sZVGzMih4cj2E5r8J9ZzlRM9a9m7UsYlwBX58Ag?=
 =?us-ascii?Q?dpUQaes0cYv0Kek9NMMS+wSdFsxSwXAWm2ngGu8klylkQvF3P410WFlJavlE?=
 =?us-ascii?Q?Sn3vqyr4+QN64ISTWIyKcolJaGUw4WIrmG7qOKBd5U/Q2nHVo60+YaAZ2iDi?=
 =?us-ascii?Q?HMTePT7vhM3R7UJMH1N0KFjgGqVJuzoj+3GvJQIW80/VG3eWM3fDdjEICC6q?=
 =?us-ascii?Q?g65fUp0UWcKlKmSILlo8jph5YZnlsL3IfFDh6u5MZqQPjalf4L5zgSFXh44T?=
 =?us-ascii?Q?KY6Uhcc6+Jyuv4zkt8vDpWSmgwIJPnF4YsmXEVLbIlPQZJAUWY8768xSUCU2?=
 =?us-ascii?Q?OM2NIIA/fAsfpGhY4rgF4lOT9YTAWV9S4broe+Ptj8T+Q4gnjnxwinZIJEFB?=
 =?us-ascii?Q?A7CEKiWKEba28o40QtJRpQRCqeXXEL7Nph4sDJ4gR74LHd+x7DJ+CyFiSxCW?=
 =?us-ascii?Q?DmVb/GeQQKZ2HXOzIahAUtH3zWkYQc4sCja2CwmRs9MgKN08g4wNfMTCDR4h?=
 =?us-ascii?Q?mVy9CarT4cI9/Qy718557H0rYfmjnzb7+CLz2OizJF88dLuY/EX8bn9lNVpE?=
 =?us-ascii?Q?gEb+NSIlOVSWG/OLIsR0jrnxu9FTL/sgMRRTDa71zMzaldJDfb7tzucBWTnO?=
 =?us-ascii?Q?jlaVxAw/cikRj4y1hVngAJj6XtvtIYgqLOhASgqfOjwSk61q3aWOIhVm2O1Q?=
 =?us-ascii?Q?wyhBlYzcfmQbg6XYVv3b10jHWJ0U0q1DxEt2NdZK4mClYxCS8f65vy2qLdWQ?=
 =?us-ascii?Q?Qx6CP6ZCsMm4BJH+PhuERydp7kIJsXwVXONB9loP0bflAXiLyrHV2bdRFHmz?=
 =?us-ascii?Q?rPc/mjGli3bNke8NxC6mP06gWNZh6aprwYeOUQD9JXQUwwGmSKuWZjx5/V56?=
 =?us-ascii?Q?6czN0evo2K3BgVMv6A6V3dL8ZnXnH7fqYLgyjvbWpnmX3i2zntTHUshwDxlG?=
 =?us-ascii?Q?q6zBIaFLe+L1tPhZoXEVas0dT74zI92sW0rV1ziFeSFIciY1fx9Mler9s9wi?=
 =?us-ascii?Q?/3itLCw1m4u15i13lRR6oBoXSaWGL32rslWYukM2msif1qWBQbB57Onuiemi?=
 =?us-ascii?Q?e7ym49fw13JxnIsEYSq/NG+8l1feDS58f9ctORQmOFA94FQPBZ2tgbdgi3Oj?=
 =?us-ascii?Q?hcitY8eJV4FVUmUo3+0SLQBle/Wa6f4wXWnLme6HKEBJ+NOQqDF0iCT6UBnA?=
 =?us-ascii?Q?6mHQL1gVaA0z+ygMaSf/obENz1BDVxhV3FyciTijhHEKprO9+ugTXrPB9KUZ?=
 =?us-ascii?Q?A66ASJTZ9qXZTKFmExv6oeG76lkaTJTdCw6gHL2QIjmOgsuVRoxMWA6jTGyz?=
 =?us-ascii?Q?4/KBbUyGYK+MQP9gdFR4D6BdK/hhZmK9HtoyVBOx?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 75c28e9b-266b-44e8-0247-08db0877aee8
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 19:23:53.3190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /gPVKd1Kzt49veW+xhPs2t4aKEwPInr6Z0enPP9+VSMGc5igMifnADOqRwt+2HENMWGyTJlBjiTAAr2sO9heZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6178
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
> In preparation for a new region mode, do not, for example, allow
> 'ram' decoders to be assigned to 'pmem' regions and vice versa.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
