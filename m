Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9494568C7DF
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Feb 2023 21:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjBFUnm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Feb 2023 15:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjBFUnl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2023 15:43:41 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA08F26A5;
        Mon,  6 Feb 2023 12:43:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kXZrMaPNZYmF2+m2IIrZfw7I9xeupHzxCU6ofmlG3JVIvintbDStQ1P/RJ1HuHGZwkUu8ogAaK/qA/cVTXsEo9c2GB8o4jKonqHkCt82MePTc+pxS9WKMRBOpiBERSnMgQCUvHFhDR8vMk3AOasav3ZbpGmUMUlVUwf80Dj+BDh7pmLhaYZdl0X3JpE7NzZL1UBnKNDWkidtAX9AY6zNmdwEXKINA9siZ6seQqsNc9A/taeH4QuwCbbd+1FOqjkegmqkepbUPQ6JerZGDKI5rMHj13k3Crl3AcJpnvM/6Um1i949kzv6IY/fNCOULiWKnW5+yb8YrtHvvgUgdmzuUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hzkFb+1irEs1KS3b/XNT0eYnZbihTa+cv5xM02BQ7k=;
 b=aSZqaoIzFO5gyoJnP4bAHjqXqsUVlPZ4TsX0lgMCl9DzVfGO7c6dzaDFzgtYascUhjyDYkPj/MI8ctJ/6Ul5jotrtkZhzM98fUHmTFO9CxE6bIgpoHO6HzVuHNbltzWhwfVOlCwPlKWLngoCofFe25DgleMuBAWfhAh/9UIvxZpzW9vvl2kRwWW5Gvr6JmdPH8GYX+Any9fViiv0eDcLPNr5jmJvKbgvM7ZH1bOebyaG11V0qzTQNw3lN263SQddAY/K+iFlNilmtQz0dHHbLKcS67d+I0ZpwBiU9bpYCJpZUa017zqZkJwE2meWlZNwoJdpkLnd06RG9RaxO0fTrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hzkFb+1irEs1KS3b/XNT0eYnZbihTa+cv5xM02BQ7k=;
 b=JtMNOu6CmJYwrW74vBBTYJlu0aPFH+4B2X9+D03G2OwR6TPpVHvQISM4N1hBI54yCpmu1+fYB8Uq21m06xOgfmBPrEc1bc4zYtfVPdTsDTAKO+LG1TDhh+kw+jyzS8pxwqX7pN3UbgaHnGY4u+OPmUKjPH9TmqIn5/HGV+X7nWA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by PH0PR17MB5937.namprd17.prod.outlook.com (2603:10b6:510:164::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 20:43:38 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 20:43:38 +0000
Date:   Mon, 6 Feb 2023 11:44:19 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, dave.hansen@linux.intel.com,
        linux-mm@kvack.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 04/18] cxl/region: Validate region mode vs decoder mode
Message-ID: <Y+EuYzk2Ro7WBEhz@memverge.com>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
 <167564537131.847146.9020072654741860107.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167564537131.847146.9020072654741860107.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: BY5PR17CA0027.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::40) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|PH0PR17MB5937:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f1ccaa8-324a-42cb-5e8a-08db0882d326
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6iwYD/mGcFQEU8aq+2cv+xQRcHEfl3Oeu/is0F6If1DH8BC4RWSdjDCHA3fbnjjlFf/shLUKOHJgS1qojNaGfw/iQk3qfjasGOqFo9VB/1ZsBX9S4zAnw4x2sb6Zmgbdy3wuhkZN17P1YsUciPI/Hx5JM+Q9ItSDQttQ4WIlNz0HvKOexWOpxiPTIueX/tZbGxcNhkwkzbTat5V4ho7yKGzay92Bbf7tlpYzaI0ZC9SJE6k5ss6D9miK/sAiG12JKhn1OV+0WvQqT3uwxuikw1i1lDaTbMHrqXJfC+bs+Cj+0lzyARt8Yjc5wyUnjNUvJlzoskIenMDS54RQ1SHz1y7bXj7BMQwX83J+wWJSZAf2tsFd/eYOTYbw2eqq3lTnwomVQoL4qQVu0JvbXPfjSF83yRMkWpy1xQwRlJphr9gbm0XTK0oShcpRe8u2fS8jjMVRTwfDbkG1J2YyILAl696oBuCBqknuFlrwgDjf2hB8aBlK34wDEeaCAWv0wxjTKf4ZHXIcDmKuN/XJHnOCydn2zsjGZEj9MaASuN+6Qfpw2aykFJtg4JgONuDtZO4WRFdkSDHTvENC9K1/nntI8A7bU2MwRHWhqnJq23HvHAPZHpvereh6jnEuySRnvnQl95Yp5s8ssahYzapg0KmmcX5LKINHSbJyymRQgNvDVIpupPA31W9FvfSCv6nvjpu2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(396003)(346002)(136003)(39840400004)(451199018)(6916009)(4326008)(66556008)(8676002)(66946007)(66476007)(2616005)(6666004)(6512007)(26005)(186003)(83380400001)(6506007)(86362001)(316002)(36756003)(478600001)(6486002)(38100700002)(2906002)(44832011)(8936002)(5660300002)(41300700001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JMKxMIoX/9Oc9ACban2EpIuMaYwjwHP+4ioNGCZewiCL0TLeZEXWOzQntupV?=
 =?us-ascii?Q?oSG8Mm8rC4DWC4HAnoG0NF1vefNYiKZvTJkPh8okluljaBPyld9icN4mQaGW?=
 =?us-ascii?Q?BBPn4WStpo/bYMqyYBAqERKmvlWySdOmw0g7+coqSb+TnIojusSfvrINqKdh?=
 =?us-ascii?Q?Or0Oe7GK/10YCnJYE/CYGkn9U+I7x4wmwCFRZz0uHANqWF9W5UVILgRimc9r?=
 =?us-ascii?Q?IdOwnHZIYxCsQj7/JeMPgxez17YMlNv0VRV+j+EENlza2QtkpmsJmwiAJoSp?=
 =?us-ascii?Q?yC5ejGxs2Fz7DUBFEbNinrzAvu+xtXKVjkm0bfJUmPMPGMaRTUYxohC81zvL?=
 =?us-ascii?Q?N12L1c2uoP7siXx7HgYIBgCzo8Zvat/lXUS+bBd8QjqHvjuaSFegvoLdAKFX?=
 =?us-ascii?Q?mOGfHGfwUAJZzER8vVA5QLBkznNtg2VV1sU+uH/iFysfcZ82C5wIqWEdL42S?=
 =?us-ascii?Q?JxfLPv77vMPS4FEkhibiLEIycV4FFbtyeJlViplup53nXPYhSyYz7wbyPVdW?=
 =?us-ascii?Q?MtazdxsBwI2dKoY5Lxs6Y9F5dlCLHfGoCGvmDwZYgD99RbzggZ9QtQDGjOpk?=
 =?us-ascii?Q?WezM8ovHUJrdUSxt1loJ02A72UZAEtqEPtT6Z3AosZhCqOU/MDjjQIS/9LGM?=
 =?us-ascii?Q?8X6KjMy2SOZjmcd7j73fvtap8IZcHBHaQgMwsLxdtKQopTPi7dUrQD6qNTOz?=
 =?us-ascii?Q?Bzb153k63PK7i5rD9WmYsV+JMXEru8E6zAnY0ZND1j5XJAlpUO/9gzKqzmBU?=
 =?us-ascii?Q?bFmXnFaLzYVP/ntr4Kr9jB7oLv/Q2yW4wWIcNnV7FBIewaXbw5JQzTMa2Dgj?=
 =?us-ascii?Q?MZVxNByPt5LAeeM+bC3U2lUoaqfNoxdhD+/xHXmGRpffhbSCZzyMYq6fzNVe?=
 =?us-ascii?Q?rZliqdCCyKlmZQ0i8onsbi9Wm9vs30fzkfmXKekFXTa5mW3OLAegYckty52N?=
 =?us-ascii?Q?nXvjhIQU+GpPsFXGMFM/2/I+u0ZyqcpXCN+sirfPVILX1U7yBXfSc2UbQxxC?=
 =?us-ascii?Q?UAEPepbGiH89lblclIY8yQpGBvEX9Wi6LC+ymWJ5XDu6yvoS+PMRF0KpzZp5?=
 =?us-ascii?Q?O3ZLZefmpYIJP579rCtV6NZo9Eiw5j1NtQohQnPNHw+ML0sA55yh3Kww9FOr?=
 =?us-ascii?Q?yJuHVxTuXyb9f3RJVuna/guA4HazYTjC+6QPdJ5tqUn6a9NI6bumu1QDwc1r?=
 =?us-ascii?Q?x5PzgqffMKyOuXhBfEXUGWMezw6/Rgb2P7r0NGgaIG56HvpFZN5Yz+ECuK4C?=
 =?us-ascii?Q?GUkLfddFuQRpknloxW/addRSyJzUNEvzvbaCOMQ5PePP1tjBxwa8lfnUrqpM?=
 =?us-ascii?Q?TT6lo+n92vTlzIfPFKTUX5zo+dxuGU2hk9P0DYcgUSZA3oDgMM9y3UVlSsRN?=
 =?us-ascii?Q?TuEcxQSQEaiHklTcmLzmOx+umh/YFY1ARJsotrw8CmeTM6nLyAJtybwRCvJC?=
 =?us-ascii?Q?a5+X28tiKQYxJBUGE4tMrG3FpyoVTLO0lrFi2dXmDtdZJZqzPOJ1aCfCWcJv?=
 =?us-ascii?Q?o+VNgTK2xAKdqI7sMdOgeCy2OGoxLHtK7fvPAwUv8xP85KNBtE4tN69uBLrW?=
 =?us-ascii?Q?KOi+UWz/nJrYFB7H0wOZxWN3M6L5lgQndjhTPqc5gagffRg//63dhPaZKioh?=
 =?us-ascii?Q?dw=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f1ccaa8-324a-42cb-5e8a-08db0882d326
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 20:43:38.6366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w1AUNgCi7+zWiGjt63G3YuuNAHh0XNEQBiym1Gh7yfaBUzoCu2B0KOx6B1yXaSaaNJ89I/yCsCsbokp8wSzuMuEvgmxfya97GJcJg5HOUz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR17MB5937
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Feb 05, 2023 at 05:02:51PM -0800, Dan Williams wrote:
> In preparation for a new region mode, do not, for example, allow
> 'ram' decoders to be assigned to 'pmem' regions and vice versa.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/region.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index c9e7f05caa0f..53d6dbe4de6d 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1217,6 +1217,12 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  	struct cxl_dport *dport;
>  	int i, rc = -ENXIO;
>  
> +	if (cxled->mode != cxlr->mode) {
> +		dev_dbg(&cxlr->dev, "%s region mode: %d mismatch: %d\n",
> +			dev_name(&cxled->cxld.dev), cxlr->mode, cxled->mode);
> +		return -EINVAL;
> +	}
> +
>  	if (cxled->mode == CXL_DECODER_DEAD) {
>  		dev_dbg(&cxlr->dev, "%s dead\n", dev_name(&cxled->cxld.dev));
>  		return -ENODEV;
> 


Maybe a stupid question.  It will be entirely possible to "convert" pmem
to "ram" (i.e. just online it as system memory).

Are type-3 devices with pmem expected to carry 2 decoders (one ram, 1
pmem), such that you can create a ram region from pmem, or is it expected
that the pmem decoder will be used for pmem, even if it gets onlined
as volatile?

Just asking because depending on how that flushes out, you might
expected a "ram region" to get assigned to a "pmem decoder", unless
you're expecting all pmem-carrying-devices to create 2 decoders per pmem
region depending on how the end user intends to use it.

~Gregory
