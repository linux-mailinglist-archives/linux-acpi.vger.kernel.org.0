Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BE168C9D3
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Feb 2023 23:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjBFWyZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Feb 2023 17:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjBFWyW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2023 17:54:22 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F246A30B19;
        Mon,  6 Feb 2023 14:54:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DvPNaZaybCICAO7WyI2yzSegZMbRTk6OPpv/6+MWGHRQGff+lEag6BgCWXZvLoUpVXzdMyw20gnHWTwucgs9q1wKtlIjJc8AhupGcvOWlOjbFiV31pkvgGrvhRHUmMnrmttLO97t22lOma94xEIzXhYZUKV3B6VMvkvFML1ZcVaSmOuXbhQZ5UjPCSi3AeXToSGP2iZaU7vCrbA9Ka1Z0Sw4akJN61GeDdkekFd3VElu0JmC8aoZYkANrNjp9RKxgnh9z/MaQVQueG9JKebUdM0edFmVRN6jr4bjTR+Qa8h4l0SPjCYNlCxDhCQxPlZw9TrXWUnrcQ16hHq2nIWszw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4bb8jCOTM2gb8DMT6ila7Mgf5ik9dm/bOrt1zl8RwRQ=;
 b=TAFoMdBY00nbUSMX6gx+T76Ie2OtLxjojPbbH8kIJZd5GJu8ra9Anm415GzhJKmdCmgZ37RhI42dGcPzibAibaFPRcXdv00NyZC6cVO6wDpQcY6O4iOw8hw81zAOWdGM7G5oRsRE6BnCpQBxN1R7qc1g+tZx0QZtuqKPLCQKIZz3XxC8veKigDV6enjGM70MQ/kC1FdDR5RDaYtQ0wowHqxsAWKrXtrwTkSrHeuyAlphGQq1m0IxO6FXlozXmyLavuN2DzpdqPXnjalDNFo38Umno2+HC9edS1hTLSwY5ym28LpL3DlyJawi9j7GzWQamWOaGmNCK8vaBvyOAthD4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4bb8jCOTM2gb8DMT6ila7Mgf5ik9dm/bOrt1zl8RwRQ=;
 b=LsbsolV1F0h68sZw5QCHlNDJSXvDBB+SMJFzd5x/q12alMNLQqCVHf6X9JkkHp9N2hXBxxxtt0LO9XaOfdA3lobumtzzRQLoZa+ts7oKooGHq9RIas4cJlnXUUbdKXjXFzE29zsd5kN10+QiIR0vcXFdt+Y5ysB3nAxfhoBWfW0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by MN2PR17MB3999.namprd17.prod.outlook.com (2603:10b6:208:202::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 22:54:17 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 22:54:17 +0000
Date:   Mon, 6 Feb 2023 14:05:45 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH 17/18] dax: Assign RAM regions to memory-hotplug by
 default
Message-ID: <Y+FPiePV0Pn561yw@memverge.com>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
 <167564544513.847146.4645646177864365755.stgit@dwillia2-xfh.jf.intel.com>
 <Y+E4UGJhKXIj7ssm@memverge.com>
 <63e17c1c4f8a3_e3dae29457@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63e17c1c4f8a3_e3dae29457@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: SJ0PR03CA0115.namprd03.prod.outlook.com
 (2603:10b6:a03:333::30) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|MN2PR17MB3999:EE_
X-MS-Office365-Filtering-Correlation-Id: fb850aa3-ce16-4d12-120a-08db08951362
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2V6GaeMloasgGh/J2OMfjDOSwHvTyi9ppmoRe0+4/vnCiy+PdxU/j95zJzEM0Fu6BB8v7AOuueyMs1p3Co5fULUb1kvOH5fMIzXPIdhunP8ox67TCzRmUuVESt0k1bSnPIWKp1qkdWKa56dHb4BuI3dXOfa8cE8YH44gBZIzUK7rqk20/ajks5/oyodTp5NAYoO5mCaFwUXKHr4fb/OpdnpNbLnoxZWSC0MEI/KGus9IVoJFmaM71MdjylUy0OgAqQjBp9lEtSTqGTIDlFhN10+3FguJijgJ08rGAv6SEWcW2nXqPYjntklm3tiTeco3AOnjvdKLYQ5pz9rXmwbPQxg1mm9r0gqCxAHFapXFJg18hW4I7qBrMfdJ/L7hl0N/uF6nRn89cc1dJa7xcZyeSiyNpvqmEd0SLP3OCko8xGP/yAF8txpYeh5IE5qwtbx6DXu1U0Ovjaq8KpIl0CwMLuI+27MStQKphavbIfMna6GzRyggNI5CsUb4+CNrYONJqRLXewsiRiJ+EFW4gkbLlKNcru3mRdlDZVRgg69TQKMTuOX0my5D+r8wzddZNZdav2Q7s2Z1UhWshr5YA6pye1nPHWWiepNwCUTTBizfc0po2K7Lfie/Rk855K5w0uVf9FppkiM2pE6/pOHih3jmD9oNeL7TGUBDps5c4KUZLfxS5s18t9XgZ7nJs+TaM60P
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(136003)(39850400004)(366004)(376002)(451199018)(6486002)(54906003)(316002)(478600001)(36756003)(2906002)(38100700002)(86362001)(2616005)(83380400001)(6916009)(66946007)(66476007)(4326008)(5660300002)(8676002)(6666004)(8936002)(41300700001)(44832011)(66556008)(6506007)(6512007)(186003)(26005)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?20mqZJirYXDuevE6RTd8e634mkp5DvdyPMC+Y4Xehlf69ONhrt38AuFYYCid?=
 =?us-ascii?Q?iaJVKXEhQ3nWTKMwDlX7Y+jRAXQ2DTF4dqBcozNyVCsDCkKIzj/UwuTk0HYj?=
 =?us-ascii?Q?KEXMCYyfPuVjsuxN1CN3h2Zen8StHnwBZtxdze/7qtCBD1eNQDkr3Fzy4QNr?=
 =?us-ascii?Q?NsZncIloX5qYZgsLGPkcplh15cPYOEkl/AL11Vy+qVuoISI6JWIoKbukCtiP?=
 =?us-ascii?Q?O4DdNNLjIA0xU7/V+9YPnxVEH7qumItvHVekBn9hChUOL0tfMd2oYp9FswWt?=
 =?us-ascii?Q?e0PpOAwyTfrPKil0NpbZo5caJHi8AkvkiIC9Wp+D517swxEWKoVw2vSspAJe?=
 =?us-ascii?Q?HU7rqsZ/lilrboxFOYhToC2fCcMkH/lRq4LBM+BIMXJF2TP65LpEE7UZ2MMY?=
 =?us-ascii?Q?DAxpYCwVB/dymkkP8df4p8RF9yjgVCl2aGBfgwETsXiampacXk9ot2zGI3Ip?=
 =?us-ascii?Q?mgzxsbBQZevJOnvQTsfaU5qZP3BP8NlBV4emuwAuOsfOc/C8LOeEvQNA4Kpi?=
 =?us-ascii?Q?nH1TqfidLpI9Czqa77PM6O+Qec8UTELAsoB/OmE5k0ASc+2xy5gNd1OXb1lq?=
 =?us-ascii?Q?PyiroRzx1+9bPcBpKPu1gIB4O8Aw6+c05kgQ+VdDNAnTJ0fI7tP8hUzda3h7?=
 =?us-ascii?Q?wIHiVUGg2jWLvnKm9hmkyxxfoOZLez4vdvZFO9+JbjpBUDu/vJnR2zpnv3sO?=
 =?us-ascii?Q?rT3canFRLVdgnLqWSvpAoN/k9ghm99ryHJSf18+OxINoO/VPsMmJ2cl0ff0J?=
 =?us-ascii?Q?UKyc/zwY9+OfbR1cKUazFGy7IRnk1v5D7QOOBJodzvpn/RX4a6D6/icr5cjl?=
 =?us-ascii?Q?u2JN/iSebvYkpuEpw4y/isjsmP7ZXqI7YJieKUMC+mHi51j4NCTTIqHJKsGm?=
 =?us-ascii?Q?FUhd6M5m8hum4ko2pnb38dvZ0KeYVvF9fRQD9l0CnYHHtoio1IsIV01NK+1k?=
 =?us-ascii?Q?3y3ok8CjGJzFSTtvISJkPU0UXT3YlZIPio//OwwDiSPhwvKiXOAYefm1U/+o?=
 =?us-ascii?Q?13MAVsXSlFyJy5k1rBc+sshHfJer58/UbT2AR77hr86Ydgcjb+9KSxOGF6Su?=
 =?us-ascii?Q?z6vSfaSN3KoJHBlesac1u5oC2n+n1AJnRuw60/Lu3adNj47vDdYA/FfmzMKp?=
 =?us-ascii?Q?jx/v/Pk4ya0a2No9iktRZB9tlUBHppTzFcgYYrU4pM6lL80HfV9VP/o4VrR0?=
 =?us-ascii?Q?XhrarpvDoNDcYp2YU4aSzmdWClhvK8vMALaFSBPRur/JYxKD+k1gBP7LKEBj?=
 =?us-ascii?Q?oVkJeds1NPtk70CoIrLiwT0hkVvG/QAGh66YJ/Hz83kbPt8vGtZZDDvR5606?=
 =?us-ascii?Q?GsXzvjnyWGm5xo8lJC7c0zXvzNonDq7oq75o+P+KbY+Fo8g/Ifee1ouKUR23?=
 =?us-ascii?Q?2VqGIm4KJEjYoraEFGMZmUieLgsJW/v2PALMVqAkSvmUxA8GJiQ1azkkHOTx?=
 =?us-ascii?Q?ovp3nXc4LfPt2FgOn5DJpsISFJdPvzd0tCCMmoMhAo4OgZnoMR2jbr6u6wDe?=
 =?us-ascii?Q?d2ocfZ6QVkUmcV0PYEaIRJQ23Owh1Fd7Ku7DZcjH+6DLY+dSBCk+KjJvAI+V?=
 =?us-ascii?Q?ykn7uINXnytojYHzJ2gDXXKvGibvfTTUQN2IsIXgEMl9VZY8yPG7ZJMmL4LV?=
 =?us-ascii?Q?Bo4qXAzrrOlrZbULMaY6134=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb850aa3-ce16-4d12-120a-08db08951362
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 22:54:17.3744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nAZ0iEipxYMVPBnYcT1gPfUc35FPl801ZkNglyyHRBy1KE7co8zT84Bn/Sc0K8TqluJCNVuNLs018CJMB/sLYIyCjdDVCtTUWSZ0WeLeF0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR17MB3999
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Feb 06, 2023 at 02:15:56PM -0800, Dan Williams wrote:
> Gregory Price wrote:
> > On Sun, Feb 05, 2023 at 05:04:05PM -0800, Dan Williams wrote:
> [..]
> > 
> > Stupid question: when defaulting to online, do these devices get placed
> > into Zone Normal?  Is there a way for us, at a minimum, to online this
> > as Zone Moveable in an effort to assist the "hope the kernel has not
> > pinned a page" problem (and to try to keep kernel resources out of this
> > zone in general).
> > 
> > If this is covered by a different patch or already set up this way,
> > ignore me :]
> 
> Have a look in Documentation/admin-guide/mm/memory-hotplug.rst, the
> 'daxctl recconfigure-device' man page and the the policy options of how
> hot-added memory is brought online.
> 
> The routing can be anything from fully offline device-dax, to fully
> online ZONE_NORMAL, or even a mix of device-dax subdivision,
> ZONE_NORMAL, and ZONE_MOVABLE memblocks all within one CXL ram region.

Hm.

I'm just thinking, for early expander devices the assumption that the
default behavior should be auto-online is good.  Just kinda working
through this in my head for multi-headed devices and early pools, and I
suppose the kernel paremeter covers that. Most of those will be used in
specialty, vertically integrated systems, so we're good to go.

In the future when we get fully featured DCD's, I imagine we will have a
memory region of size X, with N memory blocks, but only some of those
blocks are online.  I suppose it could also be done such that DCD capacity
add events drive the creation of new blocks under the region, as opposed
to having the region pre-create the blocks.

Either way I think the kernel parameter probably covers this case as
well, I'm just wondering if at some point the default will yet again
wish to be false, but i think that's a "CXL has become so successful all
memory is now CXL DCDs and computers look radically different" scenario.

Anyway, this seems good.

Reviewed-by: Gregory Price <gregory.price@memverge.com>
