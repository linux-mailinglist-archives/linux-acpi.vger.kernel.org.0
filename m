Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0222268CAA9
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Feb 2023 00:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjBFXkY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Feb 2023 18:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjBFXkV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2023 18:40:21 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2061.outbound.protection.outlook.com [40.107.101.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D603346E;
        Mon,  6 Feb 2023 15:39:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XFafr0KPvgGqvw9E+8ycywPFkqKX/UGHp2cg7RZAdfUMbSNZUgIUw0qf0ugfvGb2cmSrcvv2eoQDMABn3cxiMlyUnVBXoLAPOOqf5hdXrKqpumkHL47Ai00lV/Lvz9l1yMCKxBQVhjNzm7tRHhDmXdqLrTdST6QKwhxVAzIyRmpvQeF6dY1PdjPbZsXDlXrON/MrWRvL8d8C2t35tV0MBbZRV0X8dzQDTVg0ER5mlgXkB56W1ayTYp/TiQVekI03je2AL0/nfA1MwlEU1NN6TAYUKei3wGeE+mTWJ30jBvnjmcWueYlNoZk3k2ZKvI+wDLSngUCqV3apXcSrQcZmQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/eLZJR5DIq9K2sriPFsrg/Nwdcg+zOQ+IkUlD0JMFk=;
 b=aVKSDXMA7Bipt+6CBxHFqvXnv2BaCFTutOmpR+APN5muS4KHWIHLshPyrvW5usWnzCHEfnnxKNFH3ZrL3OhP1kdPuhWBUJIbIp5uwcqPteZWBcOznDAlhHJ4SpQ5WaTPYDj539UC9M0Bngbj88lMxZtaV6PeQkoXetodkRtWMpbI7q/0Sg1P9HJk9fQcdxLgDb71jqLRw+gQgqez/iTbW1xHzziMpT556RhY1kryFuRvCQIC3Z6kGTQ/dFLn+GE2xl4S+gobM0YlXvaKRbkF7VhKgTlyfQP/uGvgBUJB7E9xp0TqXUkVCO5e/HXTIvYRRMzxxaUxWA3i4JA1GaMXsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/eLZJR5DIq9K2sriPFsrg/Nwdcg+zOQ+IkUlD0JMFk=;
 b=WPm3NxhyXDyG+lY+G/xv8a6ln1qtzBEMjsEMcLY4vget+fo8uhrxmAmldEPCVAv0tdC0znqFNkVbQRxMH4iS2dw1oCu9DoanOLQyWDswZJM4bl30JPDO/MjwwtzwHgLNTTVv58KWPljkUrkpG/o8WzeWVf5aoRbzohixrrV36bI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BY5PR17MB3128.namprd17.prod.outlook.com (2603:10b6:a03:185::10)
 by PH0PR17MB5486.namprd17.prod.outlook.com (2603:10b6:510:b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.28; Mon, 6 Feb
 2023 23:39:55 +0000
Received: from BY5PR17MB3128.namprd17.prod.outlook.com
 ([fe80::461:c456:bcb:c59]) by BY5PR17MB3128.namprd17.prod.outlook.com
 ([fe80::461:c456:bcb:c59%7]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 23:39:54 +0000
Date:   Mon, 6 Feb 2023 14:55:18 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, dave.hansen@linux.intel.com,
        linux-mm@kvack.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 04/18] cxl/region: Validate region mode vs decoder mode
Message-ID: <Y+FbJob2+3J0HM4P@memverge.com>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
 <167564537131.847146.9020072654741860107.stgit@dwillia2-xfh.jf.intel.com>
 <Y+EuYzk2Ro7WBEhz@memverge.com>
 <63e1765622185_e3dae2941f@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63e1765622185_e3dae2941f@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BY3PR10CA0010.namprd10.prod.outlook.com
 (2603:10b6:a03:255::15) To BY5PR17MB3128.namprd17.prod.outlook.com
 (2603:10b6:a03:185::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR17MB3128:EE_|PH0PR17MB5486:EE_
X-MS-Office365-Filtering-Correlation-Id: e0df3a76-0f5a-4cb8-58a7-08db089b72d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0X71R++5UDCE4je50mH1UVT9hI03SAq87WiSM5rr564vGELp3wpTz+qzfzmnhHEMAeKY9Xps8wvKlb08JgeOmrAfzHh307eYzfXoK8Fl+4YW0mtfW+CtmmJetOu8UzG0200W+2Z5Gh1QdPoNr8EcD89GvZAr2vFbNVpU4HqHzzd9fD5m6qQVRVYHZ5+GKX9G3uG9iILjP0u/KS4vrbMaFRqjOAapfN6rOi3z7+XupeZH1KjmTVDwp+NZ3/u9rCnLvXbv9spq609AlJaXvLzRNTZ2q7q0DN6Zno7US0X0IF2fBBWdC77iDwokpn1PNKbWN9RuKXKdC14wN+RErmyWQHUovMBccrPAqkkDYG9MPLMLt+8Bk6gThL9Fq2ttryMMh4c6UZyaJtsspSB6MnoODBz28URurqgWLIvL7AO2zd+ImlkBUfR7vtBOkPeLYvV9kFQE4VYpOVtVFcd8UsbVEyOzZCApAC4Z1styhP4Ona6VtRullAeoJuy0/48VPMGd3d0SNsGzK19KQf2uOMQOfZXGpKVxBj2X4ZubyyiRqh5lsJnMUhy0CmDX/xrb82M64YHMtjA5+ROvr0wgCtA4tqqgcDzqKmGYNlgnKvOeD9JfiZkZ7kiF2FXX3k1U86UHIG+lyjvr9q4p4WJ4RNxDKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR17MB3128.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(396003)(346002)(366004)(39840400004)(376002)(451199018)(26005)(66946007)(36756003)(86362001)(6506007)(38100700002)(186003)(66476007)(8936002)(41300700001)(6916009)(6666004)(66556008)(4744005)(4326008)(44832011)(8676002)(6512007)(316002)(2616005)(2906002)(6486002)(478600001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qqKaP6jBNeDXbOU+IfXKY4CoWmEGprhZNLB9l+OrLRqJDDPfvt8YmM0HIVLE?=
 =?us-ascii?Q?vCHdJdP0eDM66BeOo082uO4kvM/PGXBqsEIKU4ODZxVM8P97/yoR7S3uxT2e?=
 =?us-ascii?Q?8Iw3SAwFoy5XKSBH9qRKDBqv0ThXTZ1UGgFCvAb1F9wbhgtiFzVK/zU3V0hb?=
 =?us-ascii?Q?rsxg/pV27b49JQcGXSD9WnCvmF6cSM4DAq0pNVoeB90ajvXzkImnQAJJEoHP?=
 =?us-ascii?Q?3QHC5YMRW3uWqDJ2ACjp3KoeiUWe1R9dEYp9V+njy66WhpavNx6BMWW2vWzU?=
 =?us-ascii?Q?WRq9K3047dOQG0MpKMfpD/Nbk38xx+V64q4rQNH2Xiz2E+tX6rLPSLyEjivW?=
 =?us-ascii?Q?8KVzhCvsOIJVs/IMoCZw6Ec2CVPgnbkOZk/YIzwv6KNy+/Wm6npBqAAAwwVo?=
 =?us-ascii?Q?QBUywOQA7Dj/VMELvReHjFLu3YxqjzyPe/UQm/sczE5Rd9R5Tk55YiRQmbt0?=
 =?us-ascii?Q?AdFutOvAPoX1ttv3pFRTXM8nr4DFfygLNS3Z40zDbWvtZwvmDE3beh37y4o9?=
 =?us-ascii?Q?0JWt18D3dPvQdaB6ftUfQ2uROxN8BVp4VndybxqdDBRq1wj2ZUsHwzSbJkC+?=
 =?us-ascii?Q?cVC7OoQgUkPkxJy1Z4m8Vwy8vcHeSBJLsiIGhVYm3bEvxXrJWu1iRAvjUXV7?=
 =?us-ascii?Q?N2lf409F52eO4t+Yk/SP0uB2qPhtLa2uN4z2AbSIyLnAvYdaa9dH5YiTnT1s?=
 =?us-ascii?Q?kKre6N8YhUAYFojlXmp2sl2sWz9ZVBO0TBs2rHIRS6bjH1FV4v49dG8jN94X?=
 =?us-ascii?Q?/DDYlBq0MOqmuk/KYuhMCYQVyivb+JcP763iq3fm6291ohaEXKv3Q3TNEMr3?=
 =?us-ascii?Q?JHGTwY1HL2r0/zCGHe9X3v7kn63y813BDAqzxC6KFnf9ZHFVLWHVd8DQNk7F?=
 =?us-ascii?Q?/Qv9L8iUE9cbdkPV4VVDc2DkX1/82D3p5Sx1P0zbosfqFkheEe427C4TmYjD?=
 =?us-ascii?Q?W21KXz4OCpeOmK5NTg1qfGpR5Jpu8IzlGqg89XaTDsB+1nf0seXq56hXZK9J?=
 =?us-ascii?Q?roAlcdhpqZvCwZE0NtkzK8xRA659PvjLLd9t9TWTrD4WaSOsHoS2nK07J5No?=
 =?us-ascii?Q?K6I9s6FUGttx8nVmWCElqLLxEybREsSUSlvuLCjkfiacMqAt87mXGxRAbhi1?=
 =?us-ascii?Q?A8UMGPJMnFW7N8+uLfIFUL+w9aHg7e3112nBl+ShBWvyFFJba+34WWWL/GXI?=
 =?us-ascii?Q?EsJ98Ds9VnxTpQKJrGk0ZktAu0BRJsgMwXc0WuQOOyS2+BcG6xJbh5rlZc0F?=
 =?us-ascii?Q?fEWfShXx/w8TssOtMG/bIZt1ICDOIvv1i4CFmUSHR3bPk9VA1UiQd8u4C0BZ?=
 =?us-ascii?Q?WJu2mbDav8f+XkFrYbDz/r79epMcKKjDVzGvc35bPwr8cZVRdAmSgyZCxY9s?=
 =?us-ascii?Q?qAmqG9tKqCnitEjyofDGyRRL6OK1U/65jnCmy657yz+TUBpFkUm9D1w+O5mj?=
 =?us-ascii?Q?fOnK37LIWmU1xuMjyJQOuM9IFZHa9yyuQYR+VL5MGi13WnAt2H2OqwUuUXdd?=
 =?us-ascii?Q?DAwR/WDq8NyNfwug+pzuSTGlK94b+84miW8pzEucpOnt1SXNDYVxmoVJc21h?=
 =?us-ascii?Q?1hPonitj0dV15XGuEJxq5USXUiaraafHh5NV0DEgDrThYdi5tBLG9mtMfIKB?=
 =?us-ascii?Q?+bzRo8GeFG3X13A210gW6Sk=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0df3a76-0f5a-4cb8-58a7-08db089b72d4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR17MB3128.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 23:39:54.5029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yjKzLcEz826jQD5XPkmxE77+GU5JyRcz6xXZ2la4UFum1yA8xdJi3dNyCi8ARQCUT9vgHztQZxhicXRCtZi0WmOHOcXMsrdqgPSOdfPeFDY=
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

On Mon, Feb 06, 2023 at 01:51:18PM -0800, Dan Williams wrote:
> Gregory Price wrote:
> > On Sun, Feb 05, 2023 at 05:02:51PM -0800, Dan Williams wrote:
> > > In preparation for a new region mode, do not, for example, allow
> > > 'ram' decoders to be assigned to 'pmem' regions and vice versa.
> > > 
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > ---
> > >  drivers/cxl/core/region.c |    6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
[...]

sounds good, thanks for the explanation

Reviewed-by: Gregory Price <gregory.price@memverge.com>
