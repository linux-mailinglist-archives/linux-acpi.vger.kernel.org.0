Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2FD76ED7FC
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Apr 2023 00:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjDXWdM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 Apr 2023 18:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbjDXWdL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Apr 2023 18:33:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19E76198;
        Mon, 24 Apr 2023 15:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682375590; x=1713911590;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3sUlmYTzpAsqVT9YNyz7mniXU+WBzqi8G0Zn395d9zU=;
  b=e373cDPvV0te1fiLRMRwnaioHdra8bkYB5Iyb8JkbFcVR8v2/SENVKDy
   9nSMOuG20JLXIhX8wBrML2ImUSz3zEzoQgBY1sVDNZfdC9bMPstGMTxrk
   7BWm6OJoGG49WusA4JsY9XJj1iH+codbfbmqcHR2rD3k6217fGXktdjHR
   gGNAPrFprdDwwWFCHc2DllN2thNr6IPM8n7dLd39PgHfpUgio/JgCZd1F
   0WOmNpYlm8hCDUldqmkfR5Q8Mgcl7VZ9xUvmy27H4hNZOcdMchw82W4w2
   JYucCra8ikWicVB0XU6TmoVTh6ricPU1nBVpxOHUrCnkozHWIyWjsdEg9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="346597592"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="346597592"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 15:33:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="817425818"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="817425818"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 24 Apr 2023 15:33:10 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 24 Apr 2023 15:33:10 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 24 Apr 2023 15:33:09 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 24 Apr 2023 15:33:09 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 24 Apr 2023 15:33:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjDne3Z8i2qr3ykU7g5W/GuUSUqKdmxdiA0qSleISFRLdsXTPY7Fjv5ROm3TaJcF18keYjbkZzThoUhAICCxtDWGDd0s9nu30wQKuuSy8a0RZuHyYtMY5x9oKaInAR8Cd0dblCbTc4JkGoWVun4mjdoTI41wt6ab8qlPnWod5ZXg2chq9d2YcGyL8SYdG4WQesU7D2D1P+B78f2xbO4zcuO1YLSGIMHWqXyVBKLilAFXVzQ4tXFq2koi8vy6657A8el5PnHTxBAPLZUW5+gkDzp7wT4iAkAMl1cK0xnxaKoy5wu89ThyrheOkxpLzVPRdr+gmV9+eHYNy3DfgC9ZKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3sUlmYTzpAsqVT9YNyz7mniXU+WBzqi8G0Zn395d9zU=;
 b=VMOu+AxNisSB8JAjABZ8TkGeeAiQXoh9pAKfheFAf+buy6lqoVr3TdmiRJWQuXbir7b2a1rQAHSW4E8q7DBXZIA55pQYq4QaBeY+nh5nz6Bw02EBahaiX6fiFHRVlnrMXkT7s3HtEWZOh3QcZ/i5DlkN6RrJOTrISXkkzxJ/a521BuHGPB4ZK6j4nO7SIXVa0vPi6hY5aAiGo06qyvnP7R/ROki6Ny6hgfzBoeWOWxmQVJN+MuGIb1zr+hHM1qbVgnbso8C+8CFWA2Sib9vxPEcIWBLCRilsPTscuYgsZg95Sx7MUhoPMStSJDfHcSmwkjTXs22d4pEUZ5pYIyp6Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB7032.namprd11.prod.outlook.com (2603:10b6:303:227::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 22:33:08 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%3]) with mapi id 15.20.6319.032; Mon, 24 Apr 2023
 22:33:08 +0000
Date:   Mon, 24 Apr 2023 15:33:05 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>
CC:     <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <rafael@kernel.org>, <lukas@wunner.de>,
        <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH v4 04/23] cxl: Add common helpers for cdat parsing
Message-ID: <644703a1d25c2_1b66294d9@dwillia2-xfh.jf.intel.com.notmuch>
References: <168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3>
 <168193568543.1178687.3067575213689202382.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <168193568543.1178687.3067575213689202382.stgit@djiang5-mobl3>
X-ClientProxiedBy: BYAPR07CA0067.namprd07.prod.outlook.com
 (2603:10b6:a03:60::44) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB7032:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a08ddf1-bdb2-4bc1-f048-08db4513e0ab
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: avjx3mcmWlonwEib74H3Gepa7T0I4S2HE3i8BO3O9LeSU+5aiHZdddcYqHLav55D+MUWiwmH2zEAOmFHSOHawLPUVChl9W+gnOSWkvm9Lg8la7AZD6r2KL3/KosjdQtCG0ehHrUqkn8lzNokOHgGvHQW6ObxaBFYfJiwWCqL+i4KA6G04yOIj429OGZt0L9lC1uhFAYiOVCjdILpEZGxgL1fvtwQlZHUXKiLdW9kg/ifkpJBrK9MvbCEvvSFRJEdqEJXmVZblPESUh9resU2vOXyBh3SEsg/mdxlVPKYWVvMjHsgh0kwGoPUGk1e9p4LRQr2r6NZ81a51VOQiKC7vWSLPAkaU1GFDQB5EWsUCqwJST/1296/VQ2F4q1559URKCmjdbpg1/sIV3T/sYwu0cDUl/qvBvWIOginixZbP46tehtQ5ncSYRpvS0wy2y83XtzoglE/6Z5YuIo2zxckhfBtgQIThGMGe+FpVfQppHt6f2ZhaziBni+iISapuUzy1m9zOMhnhXzBTdvEc19oysBoBhskZpG/g9vILOCR9XPx/weMWg/8pAVqppB8DH/9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199021)(478600001)(82960400001)(316002)(4326008)(66476007)(66556008)(66946007)(41300700001)(2906002)(4744005)(8936002)(8676002)(5660300002)(38100700002)(86362001)(186003)(6506007)(6512007)(26005)(9686003)(6486002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m4ap0PmzdW/OZkl6FXsPxT3yVcZBJVFuR94Xfau6H8dicQN4ZpTXpqJywBlx?=
 =?us-ascii?Q?AsvpF1H6WyunTIkY//+9wijqxs2UUQzCgMyT2GfYNjTllmZr2bun7tFEhXCT?=
 =?us-ascii?Q?255pOWAqVL/+RcY9UKuyzwYgX+B9U/eU3SuQjTc/dR6wGCfdN9374KSqchKZ?=
 =?us-ascii?Q?DmgDekXrkA80MiC7kR37qpWVAft69jAFp2hOdZYL8v+N8dCh4LUKEwdwHP3o?=
 =?us-ascii?Q?DVweS9S6e2nvM3u9RSH4LiKnvHZGzPkU/+sSGVndvbdUnXA5saJUqI7H91an?=
 =?us-ascii?Q?u5kArMxgsGaUAyMQVf/n7wBnnv8d6gW4q+Qwpk8zF58ODoVYs2iGp2hK8O5S?=
 =?us-ascii?Q?9TjhWI9zHGi43XYbI+kAcIH9EImKMLS5jCLfgZ3GAdDcumSMI6kXzGUIPMqc?=
 =?us-ascii?Q?biZ5nCYxbl2U5z0JxNY3R9FTajh5yCpDmlyikhGIbTF3EjG8ofzgXAFN9hJA?=
 =?us-ascii?Q?8xrKlPaYqJuqEV+DhniZE9pczu4VM3A0EIejQiTpniOcBAfbq32DzsNPZIW1?=
 =?us-ascii?Q?Nk5PCcVOqOGlg0tF8btSTqwjIQ4krUt5EAzDwBqzEFEAiGW4ipZQSas1A5AS?=
 =?us-ascii?Q?BXKN0eVdZXBlQ2n7XwlUaYUfatZBTCsppP3P7sZme5SHvZ6kZKiRvFHYPQo0?=
 =?us-ascii?Q?Ki4V1KSM04qw/pdVCvroB0z6XKKGTPMKuCmfX29uZjQ5FRjX6oBj0AdUHCO7?=
 =?us-ascii?Q?8e7KXJWdFDnqfKI9Hm8EU+J2weGb46S3E7ZzWH38jUBzf21n1PxkZw9A+iEQ?=
 =?us-ascii?Q?jsqkB2gURHPtvhrqB8TlnrpjC1OLekGCfZdFGGTwM7ikUEQQIpTTcTWZdIWk?=
 =?us-ascii?Q?fMNO0uATk/Zbt4lgo6eZxngfoDxTtxTAURliSVy7yUDvybveT50sRhoruG2W?=
 =?us-ascii?Q?KSz8UgmvC4QQQEvfnfgOM+tfqYxZF0xq5ev6YLsQVHMor4gtUSJnhzx1AQZz?=
 =?us-ascii?Q?bnAI2b2PVclNlN8rFtc8F5J6HuVw++6UmdCOg/HTSoMaBbSVW3MMHd7UbAqD?=
 =?us-ascii?Q?QUGb730herTsdj/WjsTHA5+vDPfNkBTSwqDzCk4qH58uTuegGVfWbZ8Qh+3W?=
 =?us-ascii?Q?Ohbp1MbjRXvElAsBHcihtn7VtcqpSrg7R0G4foPpQdiJSTQZf36Q2YnaXYoY?=
 =?us-ascii?Q?CdihDp0wG8T2OTdmFMm0HHVC5e2shLMWDgkSFoMSoxlgioQDot0+Xfp1my4l?=
 =?us-ascii?Q?oCUjRuahi6SRvvZB81xr2k4r+YXOmmcoNQt8zlbBnpumEI/an/s0VytbDVnx?=
 =?us-ascii?Q?/Yijc/WvneayQJDGtVKfV3xotmuZqxCao1+GoEb5cJrvPbUDD9OaWhFChNYD?=
 =?us-ascii?Q?DRB6qW89g6UITofKSAms419ZD5guYVM+NG+vjSk6S8eaC3IdnffjKTrs0VLQ?=
 =?us-ascii?Q?B3F2FJHx3aLfyNQGMbl7PoU1LU7jYmI0WmBBWjBSRINLPOG/SBe09Ig+++yg?=
 =?us-ascii?Q?UaYZF0ojkG1CIuQ47Y1reCJnKr1rtzxeORNgwLTRJrfEc5NVHPenhuBKN55l?=
 =?us-ascii?Q?pME38Tcnr6UfMZA0LtNPoE7rmR+ijY5Cvb+8+T8byrLzQeUJQLYembw+lU1i?=
 =?us-ascii?Q?smmi3S/MBv1YMpxzyfqFX9RhqlCGaBBlY4jZSjdytRKqEHQJ5MtNtBzL9wRh?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a08ddf1-bdb2-4bc1-f048-08db4513e0ab
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 22:33:08.0935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lxa2baz93DzFjSUhM8yRayRofCO5qx+qVDYIY9HNVxUaDyTz5IKcvpW/NwQHZ555EovjAy5OBVwaTs8vJdUO1TidvE2SGNnHsaYxOHLULa0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7032
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dave Jiang wrote:
> Add helper functions to parse the CDAT table and provide a callback to
> parse the sub-table. Helpers are provided for DSMAS and DSLBIS sub-table
> parsing. The code is patterned after the ACPI table parsing helpers.

It seems a shame that CDAT is so ACPI-like, but can't reuse the ACPI
table parsing infrastructure. Can this not be achieved by modifying some
of the helpers helpers in drivers/acpi/tables.c to take a passed in
@table_header?
