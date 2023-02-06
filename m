Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACA468C510
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Feb 2023 18:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjBFRrb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Feb 2023 12:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjBFRra (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2023 12:47:30 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B09234EB;
        Mon,  6 Feb 2023 09:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675705649; x=1707241649;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=J2nmXwUMAKGIXtS8KIOqImXJdNY7eiOLMgbehE26+EI=;
  b=W8pZG6k7vlzD+mBhboMFUaai/jz/ljJEbc2tbDNyhVNSpE0Jdfj/CGL6
   PTEhKxDRmi08uaTb+1FlBYj8pXscnkNYGOMtx+nBBatVN5hdcYZX+oN/r
   GqT1ngL/H7bfbmu8aN7VtCjAn2nVCVzh4baML0LhAC8vtwAnE5JnZURs7
   IpyJThDH17kwUbyxMpRdYFjOEexF7Xl9VJ7v5d413goFmgGRZTwBxySHz
   O0BP8jf2TYJ6n3qJg3OvI47pkLo3jxu8BTv9SpIi7ZLUQCn9DsfP1VgIe
   8qP6r/fIUcukSoLxlKPuk4zepEXHadByqGnZCBkI55S11lQ5EpT0L0HXI
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="317278173"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="317278173"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 09:47:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="790507147"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="790507147"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 06 Feb 2023 09:47:27 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 09:47:26 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 09:47:26 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 6 Feb 2023 09:47:26 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 6 Feb 2023 09:47:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kC55oX4ka3cJ8KqChkyEaExUZF7YqboHmKI4XIeFXWt9c6/Kug/JJeKv2AdD/mpKauBYPWTa+XhMmrN2zstutt0PLvc7AfFrtdo+DIqd3BbrutSTsrsA+XcIEXYDq705kTGndZ5t/nwIFERvK4pgaOFdu5+jCwBJvB347TwE4t74FnFnlpWgOSr9ayNPlBAPD6i6HbUO/HL5qBk7HQ0TrnsBmJKnxHQzmi4Yv2f8/8W4BViDmkhdxffWiIPpHiXsdjMWUdxo5Yth85R+meqGG1A3w2Ie4CYvkFteGXayC7qHCEQHYmXbRjAK9yCPDjP5mX6BfTLRVa+1XbNVUpUmVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5zhioCjF9fgHE/wF9A42nfSwHOayXy3q0tqBD3zLVY=;
 b=Y7gp4aIwEcoceO2dfjItzfr679eCKCl+1FLdV4l2viPeJbwO7h7zV5PC10Er/HcG35Rb0nqzY2k3VlFu4AR5RbTYytsyi02azOHEaBUHE18ENSTUIlJWQwFnjInY79kP9SnJu1FEcF7qheqUgV6985vJVdV/NfgFg9bKs0DeqmFHumRg10tCzOut/AmpJZZjgneyQPJsv74eNCeGRubryC6vrNbR/iPxFlnVQa3UoemHhGcPYh7DUddEfHf6X01WSO+n+f0BYwH4IwDpZTFRZ7ekw5gL8FqqCva1/FYWkTo9xul1hyW/3iAbOgvO2dr9H4MSrRSai4Oi/9eOBURETA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB6998.namprd11.prod.outlook.com (2603:10b6:510:222::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 17:47:23 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%6]) with mapi id 15.20.6064.031; Mon, 6 Feb 2023
 17:47:23 +0000
Date:   Mon, 6 Feb 2023 09:47:21 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dave.hansen@linux.intel.com>,
        <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 02/18] cxl/region: Add a mode attribute for regions
Message-ID: <63e13d291aed8_ea22229456@dwillia2-xfh.jf.intel.com.notmuch>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
 <167564536041.847146.11330354943211409793.stgit@dwillia2-xfh.jf.intel.com>
 <20230206154627.00000a1b@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230206154627.00000a1b@Huawei.com>
X-ClientProxiedBy: SJ0PR05CA0060.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB6998:EE_
X-MS-Office365-Filtering-Correlation-Id: 64981756-1c16-49d1-6750-08db086a33de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AbP+XwJGh7U/RBh0A+pS5YvLvoqqhQa4Ym4S/2RSmI7gZ8p5DwcZ75mfMTqTmhTZrRMA8myTx8iMSeXV981E9s036BvHTdhLSrOyWzycmYVnR1UDdNXLomDGLDE5K2tcYELiYbdakb/u+v6PRnKr8MXgDikohuEpD2TpmB1e452f8yoCXv6w9aELuX+TBUJXCt/L7Hluyb3QdPJLiSnMY3gMsSdCYDDL8Perm1MX2R5Y8r4p5sLgQ+qxm6NbEkFjEEsoVm1hYFhAairmumxiDdHLaxWrE9GEq+YqNXAbiyb3duoJdErNW/AWi8pGtyyTrwLbvKFT1e4ZQziPkFBPfqFNdW3GTLJXRVumTb+eUCGuCKGoLn6d6t/70ejWKaNCfIJwJQ5BTEtOguhNjLrTb3qZxpjILylLax6zXjjT8LIpyfzgL0L5YOygkNVP4Ajq5/K+eC1SiLw4p5HEfBLPuu19qLfMC3e6bZt9U3fHIoanu4n7x0301rnvrF/1lR7YcTb45Gma/COIib7Lu/JXeZ/jISGKdi3A9do8Y+9Nkj0HgUcHqfyZek7qiGYlBTb+RuTnwNDTZ6cd36sWjhUSAemqw/ZoU+8etckukrMcx1YycEvBrLQMImddlp5OGyf5QWu4s8LBOPtAYBP+g0EfMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199018)(66476007)(316002)(83380400001)(8936002)(5660300002)(478600001)(4326008)(41300700001)(8676002)(66556008)(9686003)(6512007)(186003)(110136005)(6506007)(26005)(66946007)(6486002)(86362001)(2906002)(38100700002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ak8CnJB30iv5A6aCXZ9BG3lJ7J0/R7MYvOv+wfZgRN7wqjVzktigl8sxf7JI?=
 =?us-ascii?Q?K2MO0ye41Ww0aMxnma95uTfxeyiGDZnRNjMZIrUoO5rNf8/ly59AZNEJm6a/?=
 =?us-ascii?Q?pLieHlVUCi5nqSV/XEXCwhIn2ovbY5JLlFxJljKgle5qjlWvLi9cUg3Nkd1h?=
 =?us-ascii?Q?oCTbZOx3mtwrhtBSiDqE9zaltRBOKcecHpXLk3xA8JqLXP/cc0ilXzY+Tm/+?=
 =?us-ascii?Q?PABgc1Tlle/AP7XbYTi6VuQ9bqxHl2MzHYCbSgABZs89zamToq1vemHhzqe0?=
 =?us-ascii?Q?T8z3gl0yZrQ0mnRUi2fDmrh74TBmwohSaDtL7q2LWbwzOFvGNpxBGmrls6v8?=
 =?us-ascii?Q?feVEr+lbACOFmvWm5Gcp5SDoJ6zyb+U+yEB80/X9PF1GNmxJVmYokwT5GU3o?=
 =?us-ascii?Q?ZTtSFY/3FMm6BJmprgY80ijAmPqvEqin5cQtVIJ5RNGj8ABjYIvmXY5exD4d?=
 =?us-ascii?Q?5Wkdu4kBF+NQzou36+w0Zsyv2qMl6NG9Domeq4mpbMGZXrtwHpBuCDCJM7z0?=
 =?us-ascii?Q?AiEwRtKsFQ2aYcSWO66wpqJufh/eC4ijr3idWEQcjFGZ6v6oLCXW2wsmdQjV?=
 =?us-ascii?Q?Y9wZ9fXqgqAA6vD1+IKpGS3D5kYHwJwc2c6tX0qqii89hhdSrTCryld1/UCJ?=
 =?us-ascii?Q?O/9zU7Co0nam+oCdRW4WMXiY9+F4TeZgjXNW4GZMaQU224Y29/y1BTmyM2za?=
 =?us-ascii?Q?LuqEUwanHZL3ea/sns56g6OJrgHVULxEX32o7mjh3XoHkxhyIPx3AET1tAds?=
 =?us-ascii?Q?KpZ/Tje1bF4FRnBX07rUzXD+24tzqHQiwPOttp8mGp+bARukCMNN8zsXsVmU?=
 =?us-ascii?Q?re1aTcm9QtB2vlltxscry60L3mFRrFMa9oJPX/lFK2inXIsqb+HAcjA6f49R?=
 =?us-ascii?Q?julMLdET1MtcxzFBItHNlt/8Hp5r2BjnUCtfcTXl1/re6k2LeFnRgCxbfl08?=
 =?us-ascii?Q?4cuR2lgUidEd5XBtNHTsGPgG8BAiBtadlx/4m3YAtloo76ZBAINJE7SV8+v5?=
 =?us-ascii?Q?vWIxp7ROJhD16vAMmrLdCdK5lTfk6zWD1m8t6E0gu9LSKdVDaDRBT4br9VAF?=
 =?us-ascii?Q?4SuxSd2YJ8L5tgMyw6siznWdmSkbBnmbWh/ZApeUkfotVfQGohqxyvhcuodo?=
 =?us-ascii?Q?wNO68ucIMpERBTAw2cbgAkN9ifl/xG0dd09p7xWvhV1s9k3VucE/qZci5F6N?=
 =?us-ascii?Q?HRFsROn29bDYo0qrKPXPw8Yh4Bw22ffJhuAa3ytFxAkn5MH1MotZFEukYAX4?=
 =?us-ascii?Q?hDxP4I2Qmahma7N9KWrQjauHklPvP+LVSG11BAuFXEKrEFlDnIPMpuqIgNEJ?=
 =?us-ascii?Q?W4+TrGHmwchr9VpxQ8PXncUZ8D4DXdbxZN3EQn3Dn2PYe1ZQk72gNag74dEE?=
 =?us-ascii?Q?4aTPZCbrQ8L9cN8U8J5kCe28RQK0ABQ8xJrecbI592icu9ZtxRXpqqk8qnDV?=
 =?us-ascii?Q?3BHNjFb0DcfGPtvRWUD2c1qvkDfwJrohvup1iJDFye5uPx61qXv2hf4j4fwj?=
 =?us-ascii?Q?UlnJrbkbxc0iNNPNwBh/+aJPPZ7ObEccaJREbeeDPvTuuU0ieWCpZMw/1nLS?=
 =?us-ascii?Q?jJ0+DlIl/WlBlOYjv1XgB3CuX+c6mDgQyveoJXYGNS3IkTcfApg0QRqYj9EV?=
 =?us-ascii?Q?8w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 64981756-1c16-49d1-6750-08db086a33de
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 17:47:23.4388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X4pxPGdg2squYi5eYMWYOOPqxK+RX6s/aQD9qja8rjGmx6bOy/2Y/KmWPWyYHLR1TYSyaZRRt2dcYiKkXoM7JRmfMEZan3G4IH9aWfJOXpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6998
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
> On Sun, 05 Feb 2023 17:02:40 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > In preparation for a new region type, "ram" regions, add a mode
> > attribute to clarify the mode of the decoders that can be added to a
> > region. Share the internals of mode_show() (for decoders) with the
> > region case.
> > 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> I guess the DEAD decoder cases is an odd enough path that it is
> fine to not worry that it is presented as mixed (none might be
> more appropriate as you can't put any memory behind it).

Yeah, I went back and forth on what's the best state to expose in the
small window between the transition to DEAD and the removal of the
attribute from sysfs. Settled on "mixed" as the best indicator of
"ambiguous". From an administrator point of the view the decoder is
still very much alive in hardware, but the kernel has lost track of its
setting.

> 
> Other than that this is straight forwards exposure of internal data
> that already existed...
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
