Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471ED68CAAC
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Feb 2023 00:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjBFXlI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Feb 2023 18:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjBFXlH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2023 18:41:07 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586B92448F;
        Mon,  6 Feb 2023 15:41:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvNs8K+tTQ8FRSuPbAQHV7bxBQ74CEcc78zpBzxB6LhdteOYx4w6SLWA0Z+s4PsguZsY5T1ZXA74t7rfSDAqO6uOSzucZfR/JZH/XoM/xy6uwH0ajf6byUFr3RD0RRFKYUDXju+lSdFWNt6JYWu/pW8HblBec3RyW0giuebx3T3Su6/PsLwuhFIKfSJNtnZAUDrb6+Kv3p2UdpmQIqBcYwu3tteQXcGtr+nggOGyEvPWDh3i50Tc1EKdp9w0S0E7gHVpew0MEHVswuFvcfROkzBlrxWK1JsmhP4GukbEAH+RrGNMhVuLGcSUquGMJrcRl9v6hG4qqs+Qav7fm4jLig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmWiseBYaLPdVUy77wiOH/G8W9Rg/qsaGM01R3F1xDQ=;
 b=VnQRY/nGRAIE0DVBTzNAJdyyLc3IDba0RHotuqRZRt3OONn/cYF2jY5h415aX2l5Zt5xEM3qp+pSpSLJFtErExtUXlaj/Guqwq8GBhPfpNvjZXjvYQWLYZjFbIhnnfWGe0YrbY6FjQ/1QkcazC4g021mkcKqRkNYp4SR01efDvG96/XU/m6k0pJ3rv888C5yT4Dp/Wi3/cttyqCM2bdJwLEHTPLZrybj47nHvz+GW/NDXZpLfj7ThN5wobG+rnk8S14kA3ydrXXA3fVP+6FjACqohhNz9UdSakA+T7ByJUjIHNJ+6Fh8aJMKh/RbSu2YGfYCS/GJqkHangmckYAtmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmWiseBYaLPdVUy77wiOH/G8W9Rg/qsaGM01R3F1xDQ=;
 b=huyXSjtlkLw4f1993Z64p8xXLP5s+u0dACnBHUjoI6sRQ+bC1aMZ7B3c0+/AJugonGXwFuMWAVa0BYBlXFT/gXzJW0own6bR0FhlPZEFZjR8sxcsCAfCwTTbLkdqXXs1YXoypKlo+9WQ1ZbX4jwAcXECxLI5Wq5prjzmvmrSA1M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BY5PR17MB3128.namprd17.prod.outlook.com (2603:10b6:a03:185::10)
 by PH0PR17MB5486.namprd17.prod.outlook.com (2603:10b6:510:b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.28; Mon, 6 Feb
 2023 23:41:04 +0000
Received: from BY5PR17MB3128.namprd17.prod.outlook.com
 ([fe80::461:c456:bcb:c59]) by BY5PR17MB3128.namprd17.prod.outlook.com
 ([fe80::461:c456:bcb:c59%7]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 23:41:04 +0000
Date:   Mon, 6 Feb 2023 14:56:34 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, dave.hansen@linux.intel.com,
        linux-mm@kvack.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 05/18] cxl/region: Add volatile region creation support
Message-ID: <Y+FbchorYja5tRWG@memverge.com>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
 <167564537678.847146.4066579806086171091.stgit@dwillia2-xfh.jf.intel.com>
 <Y+ExAllpl9OIyvl7@memverge.com>
 <63e177b14a0ed_e3dae294da@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63e177b14a0ed_e3dae294da@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BYAPR21CA0025.namprd21.prod.outlook.com
 (2603:10b6:a03:114::35) To BY5PR17MB3128.namprd17.prod.outlook.com
 (2603:10b6:a03:185::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR17MB3128:EE_|PH0PR17MB5486:EE_
X-MS-Office365-Filtering-Correlation-Id: 4df6705d-e5dc-4833-5921-08db089b9c8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YcYYeksyd5PQQparhsp0NRzdroQ9mVLT2CE0uCPGnEtnGgqOVGwt0Vr66vGWSGvi4vSWP3nngPKGbEavJ+/Q6hrjrD1gAJlaUdx+yN7PDth8wN3/jKK91c/CR6w4EEU1Ph8AHGm4FLKsmfve5KV1dYWSzJTTZ2CjyDt2G+h0Nr4f0bjKDaPiUowagDXyMqt0avm31l+k4UHtaTXLznuYZ5J2k4FrtngTTPNuGqq1ZFINhdBXHKy1SPF0r5w8fuXRVzzKHte2F0zTgViZr2EO5DxsjNJIpMYyjnTOsmvwOVJsHH9spsVTpxz8TcBsCOhZo8Xq8Y57ZxDVHwKyfP45ogTSoqnimTnZpaPjekspVZ1hZ3b/7yLDOaCcrS8sirLEtkvrFEzd/TNlOK7caAmYgiSriEMGZ0RKuRIyMNXhDceuyolsZQNL+yu4xDZF6I6Ax2whYpXKat5A2jKOvZIap5hIa355mukNpuK4O02VRo404NP7hvbaZ/YlZKHOIEhMd2H/ezth5vw9hkpLNA7zsHgtnCdDpsrGQmL0kfJ+sdAepTs3IqeaPSsmyiNi1oyGfT83G41z6r6e9azxtTKZjwk+6LLEDMGxPOYFNZ7vi+n858wbBv4wf/GzgsiTSHn19dMNChxPGJEVIIeTgJcQgVCJSpmxsp8KlHBRPJPASL1wE5L36Zwcc077aWFma/oi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR17MB3128.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(396003)(346002)(366004)(39840400004)(376002)(451199018)(26005)(66946007)(36756003)(86362001)(6506007)(38100700002)(186003)(66476007)(8936002)(41300700001)(6916009)(6666004)(66556008)(4326008)(44832011)(8676002)(6512007)(316002)(2616005)(2906002)(6486002)(478600001)(5660300002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xYGmjAOIN6Whvdg4N6Zvp5F29goPkGcKGFoHTlUx1FSaqpY2jwofGUSiHqcN?=
 =?us-ascii?Q?posaKl/yPvZeA8uhFtafTH2nodjmUkAPxXiBOAK9KSxCKywxaZ0NhexjMSef?=
 =?us-ascii?Q?YgBNEOJ7XiZl5l+7w26xf0UFCFKmgo6rKqIJ3Tm2CjtK43S8BmBu2kB3yY+U?=
 =?us-ascii?Q?086O9QuKmtZC4oxtUv6uRLAyhKmf0doKFGLkTqtTxykFTdzTppUfT5fFDf3+?=
 =?us-ascii?Q?6Z5CA4uZE6g3+8Aha1nZP6jlhT0A95p/fX7sP6rE7vW2OMJ3M/Y1yIjGxnL+?=
 =?us-ascii?Q?0uX17DJo7onw6RhKux94hD06vttTwShQAA8XxiWK9inTjap3JgM3hzq57nDC?=
 =?us-ascii?Q?oHq8HUWxJluFDv2lzWKWl/3oceDJ1h/PQx7Cf5T6/d/nuwjTjQfB8luVRGkv?=
 =?us-ascii?Q?PsaP6dsPJHFILBp9JuzmxhqymdAHmelEVx0wtq9ue/JQNHwUlBOUYCv7RKyZ?=
 =?us-ascii?Q?C3d39KaKR4bXgUNMZWrsv2rqZfnqN4UJG9EH+zxjMO6jvnGIyrxgpUQ1IMIx?=
 =?us-ascii?Q?3d2GrREC239MKMk5JsgVQIJvnz0b/0JaMiCPLygD85D9MgZXsT6LDFUtLfFZ?=
 =?us-ascii?Q?tdkHr747UVl8O79JFOvup/u0The0b3tNoyAk0wC76yCrNu7WhZyIcU302NwY?=
 =?us-ascii?Q?w3+r0OZ02AkvXE3hYFD4bJ/wg/alO8M0aUCnwBORfjDILsyebCfBkFgDOAB5?=
 =?us-ascii?Q?ci+I+6+4MTx8gWmfdLJg6NgQHOKOKYI04FF3iAVdM5Ho7NVARbc75XJdd2d+?=
 =?us-ascii?Q?6BWvYHWzmBuWlDbXBlWfnbgPy607mz78mSisqcazOh9tp1/Ezt8YTlyaHai/?=
 =?us-ascii?Q?HNyWVlPXOqhoWRKq5PSY08lmILBbwHIcC0QWDZ4D/23VnGhMbGriKd8KK4dW?=
 =?us-ascii?Q?zr7U8pb+R2Xwuy/J+v66JrvtvMU4+Vm0/bqojD6aJ2+1VUCtI+LnSuWcptjH?=
 =?us-ascii?Q?h17uUOzn4popXzY0ZhQTwyxSqnByrTBh1+7awwJp8Bj9EsUC/DIi2sX8tgN0?=
 =?us-ascii?Q?myymxKMc5NqBEurDi0FzHnEK7Tyw62hNyYPzS8b8rm7y6BS6vzFcXHOMilLG?=
 =?us-ascii?Q?HByeZCyPNuUjCERMpu1zhVSA7diVy57xV0Z1TTF2ET1wqcogPkY4ynTQLWE3?=
 =?us-ascii?Q?zqQwtsG8Oah6irwKLm+BwInijNxewl+MlZaMVMLnjI/oji2TWZmMxE4VV5bW?=
 =?us-ascii?Q?ZzbLbLSfuK/nhv4wk1aqgP1i+pvMMf/9l51hwXguysV9f8PPwwZWIfXwpRfh?=
 =?us-ascii?Q?X/+Vzw8eOkERpnLqxd9CXhVMn0dzRxHbNbaIHh+6OgiVFR1vuuJnD4ku/YSS?=
 =?us-ascii?Q?Qyk9HDERS0/TzCmv3M3LovhDVIrxfHsx58B2qRtf7QIUuw04Ba1vQbqdGjf9?=
 =?us-ascii?Q?gJmKW6n04cTo75rVCdhXxpLJKf/9ij3fUgEt2QprSGEdN+78cZCWzjoFdDHc?=
 =?us-ascii?Q?pD5/tMRx4So8uj3iDUiySaD76sYIkq8diQ06lFJnINM9gpPHYoDGzScI8Zhn?=
 =?us-ascii?Q?oVSs5s/ISQJaYguEheA9M++dB6znHXNiCxUP4sGmVgT95bA8uUhBMDzY8E1w?=
 =?us-ascii?Q?DAq8ISHp+69yL7/EJGKxE3W67Vz1ugJsqY8XUC5vGbFEZunIEZZwPsgQGXHe?=
 =?us-ascii?Q?dZ8okZbcI/IjLuQEQ/A3F5Q=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df6705d-e5dc-4833-5921-08db089b9c8a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR17MB3128.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 23:41:04.4822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cwJpy+BrYPSDd7N45PDtMoD9+sC5Momfe1xF8/Bb1UIYV3ULg4kiDFvKjysttwTwiT8CFfbKzMk8X64aO2Dyk/RwDlC+f4l606fppC4kyyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR17MB5486
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Feb 06, 2023 at 01:57:05PM -0800, Dan Williams wrote:
> Gregory Price wrote:
> > On Sun, Feb 05, 2023 at 05:02:56PM -0800, Dan Williams wrote:
> > > Expand the region creation infrastructure to enable 'ram'
> > > (volatile-memory) regions. The internals of create_pmem_region_store()
> > > and create_pmem_region_show() are factored out into helpers
> > > __create_region() and __create_region_show() for the 'ram' case to
> > > reuse.
> > > 
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > ---
> > >  
> [..]
> > > @@ -305,6 +306,13 @@ static bool can_create_pmem(struct cxl_root_decoder *cxlrd)
> > >  	return (cxlrd->cxlsd.cxld.flags & flags) == flags;
> > >  }
> > >  
> > > +static bool can_create_ram(struct cxl_root_decoder *cxlrd)
> > > +{
> > > +	unsigned long flags = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_RAM;
> > > +
> > > +	return (cxlrd->cxlsd.cxld.flags & flags) == flags;
> > > +}
> > > +
> > 
> > does this collide with either CXL_DECODE_F_ENABLE or CXL_DECODER_F_AUTO?
> > 
> > I think obviously if it's already enabled creating new regions in a
> > decoder doesn't make sense, but if F_AUTO is set, does that imply
> > the region settings cannot be changed?
> 
> That just cares if the root decoder supports TYPE3 and RAM independent
> of ENABLE or AUTO. Root decoders are always enabled. The AUTO flag,
> which is not applicable to root decoders, is just there to hold off
> userspace racing the attachment of endpoint decoders to a region until
> the autodiscovery process has completed. Once that completes and the
> region has been enabled then it can be destroyed to clear AUTO.

Reviewed-by: Gregory Price <gregory.price@memverge.com>
