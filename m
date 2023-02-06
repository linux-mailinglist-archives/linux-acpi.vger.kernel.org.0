Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B278568C7B9
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Feb 2023 21:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjBFUhN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Feb 2023 15:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjBFUhL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2023 15:37:11 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC4612076;
        Mon,  6 Feb 2023 12:37:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBMHHKrn59bV/h4WJjMzw+KBOzs4+bn/fondY0P2LCj/KxYLhz/Bm6ZO6JUuzjiDBvNOfvzsGPaopfx5RzKkv47lOYJoKyZSGh3KifhvaPYU3GnWz4roOXuyoYa0J8zPAYXnxgLnxqbwZ+QVGct5WDYKGK1Vw+8tdOJRvmsYaRAmZspcx/sS2IEjyUj8pRLr2Y4P6pQRCyUSgetLdZdW4vQfbWJ715gSToMcWtM6AM1LZP5mNlfJuJKDhVKii21/f8VZwJDBUjvr5R7Yl/YdpDngZmsCU0YsADYA521/XoBBRr9V0UdnReOG4ATi8Q5Ap9I9jtPxB+yfeVcBvtwE2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kfQ+NLdRQAoXNwYYLTj2uTr0j0JJiCzxq06PApB8jhI=;
 b=m7hcnGtunoBQUihMg76nWAjnNBNNBkMvpiqmDsBaqSGQzW5Xm3+y676k1Q8DwDNPduSYUaypLWO663FQleg/cq3iSXNSDu4zAu3hBYu0jfakZno1Kbreh7m7gU+5iYbjHlaw0A8cgTCNLFBtmuGbWHVaiP5QNeQybaDDGzcKXm5VB51z6QT2LkwfzLzGHnoSLZ40FzxbOjtsUen8argsLoCqK/pOjkOLEo3jpWls9Xt+aks0NXKMP+d/4IdePOA0jFiiXcZZJNDcFr5eXtnH0+cy3+XckrqjCeUi/70/VrKN5jPmnKstSsKMhneRX+4GiXvTTNxxBmjDnelVdKDGTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfQ+NLdRQAoXNwYYLTj2uTr0j0JJiCzxq06PApB8jhI=;
 b=U9iKm5eANlLrNBwy+3jDChirQC80pvs7sJ2v1z5aN8oRr4FIaDV8supzRyIFtbtGNGDtUETREH0pX3huBRpYWbuLU93xODmSdrGgPdIUBbt6tUfFegFXqS7C1XOJiSLHGm0jf7eeLs1cZzpKb1EmVvnCecZEQAGbgY/zuxemB10=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by PH0PR17MB5937.namprd17.prod.outlook.com (2603:10b6:510:164::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 20:37:06 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 20:37:06 +0000
Date:   Mon, 6 Feb 2023 11:37:13 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, dave.hansen@linux.intel.com,
        linux-mm@kvack.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 01/18] cxl/Documentation: Update references to attributes
 added in v6.0
Message-ID: <Y+EsuWzTvNQvYyQ8@memverge.com>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
 <167564535494.847146.12120939572640882946.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167564535494.847146.12120939572640882946.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: SJ0PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::29) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|PH0PR17MB5937:EE_
X-MS-Office365-Filtering-Correlation-Id: 77a61cac-1911-4969-660f-08db0881e93a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IKYlSUeUZAttIn/ao3SmrWCkuvWkhmcqwp4uEOApt7vjxC9rJNtydyiCiGU0xgh2HgbOrhXO8TtB+Qv2HdF8sMlJPcukJAKi78oY0+Qwl5K7DiRZuX8iMOGP6ne/CgrRYRL/qWlidPXGtfRjxbEyE7y/tCk3CaBSZiQitio20M+yUJi2a5enY0DRrkTsUxvVaexjTu5WkGZzyhOs2Q6QTXy09nL+Thu3/pOvUxJZlBHfvm3FQQKdB1paFaenxstAIrKkm+oXfeNUnDbPpgl0Bd7nsoJ08hUj7QRqeFPjXRFwwDWp+du8UoTdJSgfydWI+c9MGYK6S10mYgdXQ76tec8pvg+le4kOSvPCHERu1bQ/W8jiIhsGElAMbbrSCQgV7k5Qtckkq+8egX4bsT4iRhPWdp9wU+cciRbDGXtCOT8BquIarNmBR4T6dNNDjfiNCXzDAGOr/jB9PlTik7XcjT+g0EUre2PS2JJVCJ9HyIpda2PWWywgb8Wh/tgDAC6GYORiVXL3r18EvmPSpPjVooE/EM8f6mTjMhXooI5mQnp9On3Gc4latq62yZIW48naZNeGi9WM+pBvw9RCjvnLst2cwgO5vpDiBtQ6naZU2HO0AXlQVIQ13UeO2yiBxGzInPQbC5bujEaSUtITxQR6yBUwDELiuGBs4IvfX864ecLvGkdk+srMAt3MWa5yX5Xx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(396003)(346002)(136003)(39840400004)(451199018)(6916009)(4326008)(66556008)(8676002)(66946007)(66476007)(2616005)(6666004)(6512007)(26005)(186003)(83380400001)(6506007)(86362001)(316002)(36756003)(478600001)(6486002)(38100700002)(15650500001)(4744005)(2906002)(44832011)(8936002)(5660300002)(41300700001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KoPi2aDWd24Kz06GxFqOfJFdqUboWeJQyV9dYqa0kD0Rb3EO+KxcdFXzY9b9?=
 =?us-ascii?Q?ISpx3su/EDGIeHJZ/PzMPXFSbl26zlb3Rdk2Sx3khm38HdJK+dzjnLPsAR/s?=
 =?us-ascii?Q?mzDRFEqb1f8randwvScXuDeZsgP1aKsbZs7Sz75c5Nlk9wb2iKMeYKLTfYqA?=
 =?us-ascii?Q?wMcpICX+NL7hWXWZ3EPAJCdMjxGzavMbnQxj3xUkxurODjvpV9tZhCWDVGea?=
 =?us-ascii?Q?u4EUrCb6flsqS287yv6H+NCvbgE7w54yR0BgMH64lraYVTKJ33cRxNrXXYk8?=
 =?us-ascii?Q?9JYMpo4I2xGyXQ0I7Ss/AWZYzghfGr7Ns7O5knkJo9Q+DSM8p22ft0+cuQuK?=
 =?us-ascii?Q?oGA7TzQYdwltpql75Q96mxU4iHWW5vY43DT0fr4coSk7qTa2gUFhHc3XY1Jb?=
 =?us-ascii?Q?TQft6/yKCu2Cz6n7cW1cdGJP4MRYAYSfzfWxK5a15/jvdg5o9OQ0LmQktbLj?=
 =?us-ascii?Q?dHJMkPykELetavyy9swYppjuXjVgToEo4UY3i3loy4lKkQMVaJBNoMCDI3QS?=
 =?us-ascii?Q?/8jzThAOgHFCHNQM7hogSFCRB9pmvCitMp/vKtiMcwwerKobwfwP32/doU1C?=
 =?us-ascii?Q?huVzI7673TOZt3kisPsobOZM06YRToRsjIjIVjSdHd2NQbM5/vAtaRV0I3Et?=
 =?us-ascii?Q?fora6DIgGTfzOVKZpzenWI6OtKN9lKhlZsHza67so19jKldxO2eS1Z0Sf3Pu?=
 =?us-ascii?Q?RaQqMOELiMaKj8GEeVbuFWcjPWa1xto4Ysq2T65fW/xc4LGFvJgCfF17PTJc?=
 =?us-ascii?Q?alOH4CkccEf5P4U08EcusqSVE1rBP9DqVodlRgaF4VrCezDXSyJj5uX4Pkh3?=
 =?us-ascii?Q?qrLlL6r10/PvrXpTklWQKSRx6RThuzczOinZvaBV0fwJJyWPunWwZSJc1K2A?=
 =?us-ascii?Q?ahvUg16KQXyQdxxhCRtPANKMsxyavbwwz3gHUGmUfUZjbGERndJ1B1pWG//+?=
 =?us-ascii?Q?W/uQ2zRKPmiEb2tN0DBDdhwlRaTHMBc18hG7LewKV8dv+p3j7GpvUxvh/0R9?=
 =?us-ascii?Q?cRGXAwVpWUsZFog7jz7PuSX+Sq+1sIdAV1AblVdw82fUzAqcDrAbl1KWoP6c?=
 =?us-ascii?Q?yUKzIPOwS/yBz6wecrZO7OkUj/JC2ibUA5GlLpGf5hCJSzaHbATZq9D/oyAW?=
 =?us-ascii?Q?n+BjfovdWFbVg9kfLtlav/LsGAO80QGLxNJssNnQIOou/n7mJQdEq+3huwOS?=
 =?us-ascii?Q?SHUafseH76GcXvJ2Gv33tV67AwcKd8Vcot+ruDQu+7flr7dP+AfQAvv4Wj5M?=
 =?us-ascii?Q?jDubu//nbZSLygaTH+XrUgAmSKi2X9BubsCvGYEzhgs3yE4w5AtvuZhX+9CS?=
 =?us-ascii?Q?zedmkiGHbvuLg/iT7vAw5pQICAOddWhOmkCumaHE3c1EBMuYCiS1/hHVTk8K?=
 =?us-ascii?Q?p8KvJmlnnNS3TDKI4QpOC5Xh9Yh1TX2FmqVdKU/okJvA8u7VPKsHWEQo/dXL?=
 =?us-ascii?Q?nkFRw0853y48g9AaFfXxGTU8qPlaXSRtsDP8m+sV1nLhcanpraZJSXXxVDRJ?=
 =?us-ascii?Q?1Nv6KrbJEqU3JQxDXY8PabrzBncOsOjy8X+KDqixbNIPfBz7rjYb00iEyLM2?=
 =?us-ascii?Q?OBVJ3tX2m/O1wtIU8UfxCQdxCJ6X8XLPJP8YJkOoId009CG8L73ogbzAlrkI?=
 =?us-ascii?Q?Zw=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77a61cac-1911-4969-660f-08db0881e93a
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 20:37:06.1029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LA1v1MFb34glIQt3ZOj2RV3bOPGLfJpirag2kXUEmKM6zwTgCfEiVAeZSUL5uE+I6I/roQAddF3OdK1xr22m+Rz13eAVnNk9vRAZ+W7MesI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR17MB5937
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Feb 05, 2023 at 05:02:35PM -0800, Dan Williams wrote:
> Prior to Linus deciding that the kernel that following v5.19 would be
> v6.0, the CXL ABI documentation already referenced v5.20. In preparation
> for updating these entries update the kernel version to v6.0.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl |   30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 

Reviewed-by: Gregory Price <gregory.price@memverge.com>
