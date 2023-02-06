Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662CB68C853
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Feb 2023 22:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjBFVMW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Feb 2023 16:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBFVMV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2023 16:12:21 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880DB22781;
        Mon,  6 Feb 2023 13:12:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gylbMCErtoACZ8HJMQ9ntNy2bwCmDZg7C/Qfq5rEU/22dRfNSOEnhbo/yrCVjR8cjiF1Z1f5dhTPnvgdvXoEeQ+MQzgRDxUdRdZW1qZW7iPKiABcBGvSlwnCg/cPct1nhWa+mM6/L4wjIslA7uAiye1+0aUyQG6AYHKtsEwcSDnlCL19L82Y1O0J159AhfnKrOuyNHMYPY8mq2xmftyBxc3cDKm5Wqk91Y7QVH2RLEPAEhbT8SbaiEf3t+lw8Qrjmso3vydTmZ3ZDvB5QqDTEKM7ghDIm3Hh7Qt7sy76vND6thkpbsbQKwUPalJkTrkqRZ3PCYTgrOMrPvxrmMnJyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+2I19F2lz2rFraRJJsKr9+hzQfFhxh/Rof/Lxy9ino=;
 b=KgOYrqXxQ0bnOehbGdhfDmdEUUt0Ahhh5zL7G7y8SSGSVa1M5JVgImv82oY3XJUKiC5bOs3H9ZP7eAdwzXV3w5r3iWQYb/h7lXdXb/jjlpg7GqkyUIVXy48T3q3uAOpA6WdhaogvqRsEu5DYenz+TH0dZpnVCyu+jrNcA5Cp2ViF+HewCLKaaPojj2Ak2n5m6LYTMflTQHFDW09aw5/O+3lhLTzZqsMZ+NABiMhByYZoay/qBYw4lX76lD7kM/PgUmZYLelJa0tMFsdrHowdKBlgzcieeVNg9kVaSFXAwrY7QAyO+fKRH9sRbpaRnhlOBeLq6UImZP5I6DCkcPj2/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+2I19F2lz2rFraRJJsKr9+hzQfFhxh/Rof/Lxy9ino=;
 b=PDHGglD199ykg53TymPhsb1lBNF/P02AAUSsHwYDO1a1ezQA38Mm332GPqDX+bJN0vWOLNSN+f2ie7hyRAu7BFg+RKLIMllZdpjnCm7f1jKSPUWdHluJgAannXhlZ3mr3KuR2gV/wsPKKRCUNpjA/Z2QYLwPtCd/ZpuFifdqCCc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by MW4PR17MB4618.namprd17.prod.outlook.com (2603:10b6:303:103::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 21:12:16 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 21:12:16 +0000
Date:   Mon, 6 Feb 2023 12:15:16 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, dave.hansen@linux.intel.com,
        linux-mm@kvack.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 14/18] dax/hmem: Drop unnecessary dax_hmem_remove()
Message-ID: <Y+E1pODoTD23vj+B@memverge.com>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
 <167564542679.847146.17174404738816053065.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167564542679.847146.17174404738816053065.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: SJ0PR05CA0071.namprd05.prod.outlook.com
 (2603:10b6:a03:332::16) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|MW4PR17MB4618:EE_
X-MS-Office365-Filtering-Correlation-Id: a6bc5e56-bca3-4c53-d6b6-08db0886d344
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OqGvmOwbDADXQehFTHgu4CWEa8NFcO57QTmtJ1AUD8i7NpDNGf0h7Uwl+AwZPvUmqHLczuJL2enDzAYNpPyMjq1a902xunXWw7tG0WpviXY97UXbmtMZdxrX1oRqcUfjYX9laIWBO+Xyr8kfHebpr+DJVVXwidG4HbFX6BZp4+hVjdDCVuAS3oL94GWkd0rkXJF78/S95LiGjygGS8Lp6Du/+oFY8BuYnu0IMD+3NK6p0HhfnxJ6icStYKldtNZui+r/4UDda4VDQPnPIIHtMz1w+CmeP1p42u9VqEkEpqlfheTUOyYOJ1EgASS71O5s6Kl4+fZv8XYChR4xPAXRAHmfYpP6Rh8fzcK5QvnlTv29OKF2n4l4aGrBd+GmCxAoZaYQEKg983Loa5hflZPeJ3xTkPLeuzvydaCMT5A388YUH7wk0Rp8SotdMeelVkMHdjgINg6dQnfnBhYRwS7+Vf+ZjnjPp/7FzC5lzhtmFYStH7w1TYcXU4AQCRtQ3tKxhc7FU05p/2/MySUsxSiis5t2GdemXbAK995PM9FOh6BczqQUmlgxYHwlmGZuWmAy2sRpfE3NwoMv6tKsVgyNGuniBirdQsMzeLp1ja1HKhT6S7N3tbUfOxwbL/8eiDNyLo+gOV2S8A53sZk8ydUJBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39840400004)(346002)(136003)(396003)(376002)(366004)(451199018)(38100700002)(86362001)(36756003)(41300700001)(316002)(6486002)(478600001)(66476007)(6506007)(44832011)(2906002)(66556008)(6916009)(83380400001)(5660300002)(4326008)(66946007)(8676002)(8936002)(4744005)(6512007)(26005)(186003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vkdsP3rFv2JzpnIOy2/ScUokCd8LML+jlvQ+DkAL+SKEHnixJUEY+LySWlKv?=
 =?us-ascii?Q?TH3/wx3y7WxRf7onIUh9JdFcLflJaOYpDhsp9Rgky2nG0iTxEX41Wt3K+/wS?=
 =?us-ascii?Q?oXORF0gPMyPN/t6skT6FqbKJ8yTy8vxmKjYMW9Kg1HtbdzXZ3wA/CAfes0nf?=
 =?us-ascii?Q?bHiL8GT+ggZ/s7WKG9tPEIQ7eqAnjdM99kquVCTh/azTlHJYfgTk5TpOj0jM?=
 =?us-ascii?Q?7sAKXpRzXUUGzyueHcPu9/+OmygPyLRcSFg0S1mLi6jrOGVYOFl8oHii1nu6?=
 =?us-ascii?Q?yQJ0ajcJ204QUH2SbRRoi8EG/G4oNJ5b8TAq1yRLwmQH5z3HmxfBSpKoB36s?=
 =?us-ascii?Q?mplFRCD4+M+ZoDFcFj7HqE10k1JG6+VEY+vtmpdIzob0qmra9UFDfVL2FYnc?=
 =?us-ascii?Q?djataDyMCbYj2EuanhyaKeU7Oe5tjZc8xPxdYbIV+Ysue+lMh7ZE1UED0iAo?=
 =?us-ascii?Q?DvSVwe38LX0yrV9UmOI5mVU6VY+x8SNEHSQHW+pdWOZL9vdDfQiaMBLgXkaU?=
 =?us-ascii?Q?AwSM8JsOTQ2sBBx8CVwpSVlPOw/bSsVN5ahZa/4OOMPYV8jeHVKMo/z72e2s?=
 =?us-ascii?Q?gL0IGtvtl5OfkpLC0b2mCV78Hdl0Dlo8V9ZJTfdCMZfSqlMxjdd5yUTBo63a?=
 =?us-ascii?Q?gyywc8IK8W+v7q5IA7eTpviH0Aj+QOkty0M8UKA43R0N7jSLsz5iUnX8i0Eu?=
 =?us-ascii?Q?W0nzGlH5tgGvKyqtSOH/bexhCItL5RN1hwULipCB6PpkArf6Y4P0AQzSSJE5?=
 =?us-ascii?Q?lC5vo0d9+MluUunKv9gRzD+25b+9lo0ccczxxEoHljko/XsiYPchBZl0lV9O?=
 =?us-ascii?Q?25pjSZYLXzSxzCU3989xDB/RpKxkA3GxhTI0lmCTkCenkTonAlGuUWA3CVdR?=
 =?us-ascii?Q?+Sm9kx9vuImXhi6YYaMo5f1JEMsK6/Z24RM36tGGjIjNe2ccVJpmfbRp35Ok?=
 =?us-ascii?Q?NiTpeES8yoPprdwaRa53hQGC/EFpEfFashfSIxbjY3MH/kCHJp1gW2zYFQSN?=
 =?us-ascii?Q?8xhc0GhLmS+QJc6eAGJo3ox6i7ZHLogVtTsz1LRW0J6/35hoLMmbGoecQqln?=
 =?us-ascii?Q?o1b7bi/XuBxMVFVSsNDO25SZLUHHiBenJZ5hLzmfC4rWuDMabn9+vQ2kQxND?=
 =?us-ascii?Q?h3G/meX6m0FbEKmDC8wBGECpT8s6rSqEWqXa3gWiGLjTEzdGcqHu9ihrSvAI?=
 =?us-ascii?Q?2NiFW18xwTG0WuCbJigg+g+ky92C4N4iFPz4NsQE/RC0SpFolwc+aB9CQxaX?=
 =?us-ascii?Q?/8XwVhig4dgcWPzOBBg9QOrqmuRbAwPgpv7ISVtJ88I37PAPBaPBT+g1QxW9?=
 =?us-ascii?Q?kDgtiY/Tp8R8j5ShH8Rm1a+Hvzzu/qST5CLsUPumqUR0/qGOKfGAGZbNd0YJ?=
 =?us-ascii?Q?KnxVLd9gR1YL+u0MPQ6HnPrj4d7eVeqYn/RwZGvQ7cQV/VmGaMjPrKzvHpuE?=
 =?us-ascii?Q?8hoTg13cgTuDvARLE+cy4k4QYcYiQZhK3IPD+Fn03i/aCoiLu3TPeFfCRGO4?=
 =?us-ascii?Q?NIgw85T4kY+bWhMPxjhuLpqTwS+xfgLY0o5ro2xbQyTBsOioCCe6TCjbDE3m?=
 =?us-ascii?Q?xgbu3d+aG7smKyW241zEr0gxD992apGyZHMaH5UzD3X8EOw2jAWR3X3F6XK+?=
 =?us-ascii?Q?9g=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6bc5e56-bca3-4c53-d6b6-08db0886d344
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 21:12:16.7138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3SOXN4CzP9mvbkqXyiUVA3x25xcFzmZGoQxYEcLw7bcGKK1kYcvnkhHrbJ4pLYeDr+nn9BNnok+oy3OzGMbk2PPih5UzMj8TkM1m/2DOR/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR17MB4618
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Feb 05, 2023 at 05:03:46PM -0800, Dan Williams wrote:
> Empty driver remove callbacks can just be elided.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/dax/hmem/hmem.c |    7 -------
>  1 file changed, 7 deletions(-)
> 

Reviewed-by: Gregory Price <gregory.price@memverge.com>
