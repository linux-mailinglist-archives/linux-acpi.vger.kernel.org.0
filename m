Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E5968C827
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Feb 2023 22:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjBFVBt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Feb 2023 16:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjBFVBq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2023 16:01:46 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703712BEE6;
        Mon,  6 Feb 2023 13:01:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2nChtRF6Km46s2//KL41NARPzbmLRqgpHC2NGvL/QsccX+3SSTJ7HX1CRQttX/krQD4LP9yv8hh8NNf2Exm5geg2HjX1rpS0tHKuPdSFQH8SkkV+nteLN/VnQLq3j254LUjtysjcrfTWTjCtUEZLoh+3DEpwP3zL+JHmTgPsq7hl4giuAW9G/62d73m1kngj9TZARfa7GEykN4MKgLITnLP0CDwaNdr9HgEbhLMHt1g6pSWYfNw/Z0PQxMpFa3c+9GwCzkmKO4Jr4NCBFzW5btQSJoGsT61o2+7IMPzs7KBj16oT7IeCdeHnXdrZJcfb5zwf+BvTULyWwDr9WOrAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PkHF2L51QUeyLs7RI9dgGJ/SH+ZDZNSa4uObmEr3bGs=;
 b=RbwCbRW+AQqpLvMU7AKQAwJ6f4bLWyMaIDSp59y5+vYxxux5tlfwGnKzr1OUGKZFYkdVLRTRaemU577ys2nPsdRv6yAjJ3yLa/BxbEzVcqfVEJU7tcDrroRPk+LADxOyLRr7x72l4UISlunjd7/AF72xiTCaj0zvKdWBCBJzl9cwhRQqX/ZyufzidQNQrz2fB2XkPLfhX4AV5NE6PqrnGtWTb/0ssMC1AXUOCrR0xRF/N/SoFej4OLeohlUdjd9FU6syLbhhxuZYBH5M510WA+RXpI7AhkI07aRCAe8gzgGFlGEXVUhzFK0JBZRAvDSBL2MjJegmVgkUQOFTanVE6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkHF2L51QUeyLs7RI9dgGJ/SH+ZDZNSa4uObmEr3bGs=;
 b=FesPhJC6s5NoKWs7EAMdpiuK3iTBBsAmQmSTCqQocBa/P2WqIpzwC0J/VhAsQo2on51kpaIINr+FfoUZMOQnuBF25RZnbErxrnVG0P8QjyNktzOJ5nulS5UqVmXBGLztqTkK/SgAxiUDXI8Ldtw81GBFNzkW0CFM+Wwv275kZU0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by BY5PR17MB3764.namprd17.prod.outlook.com (2603:10b6:a03:232::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 21:01:41 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 21:01:41 +0000
Date:   Mon, 6 Feb 2023 12:03:52 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, dave.hansen@linux.intel.com,
        linux-mm@kvack.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 09/18] cxl/region: Enable CONFIG_CXL_REGION to be toggled
Message-ID: <Y+Ey+N2fSOEd8CG5@memverge.com>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
 <167564539875.847146.16213498614174558767.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167564539875.847146.16213498614174558767.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: BYAPR07CA0081.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::22) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|BY5PR17MB3764:EE_
X-MS-Office365-Filtering-Correlation-Id: 0732475f-d174-4a86-d8b2-08db088558aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lo1tmfPdvTMTbxzmLl4OiH0udJynmTL91PzNHGTTU9cpHD5GRsNA004A9R6xiZSIHQagYUUut19Gg/MSEGS3Ntvyco77TPCXL5Y6SAxlkpnY70/QX8cmzdofY85e/poryJQT8Smwy535Uz68EJhKJZ00vIRq6Uj9F0BzfwSrM9Zvr9+jvdOReOZsi7cSVpl851C2uyKvyQtpczcnH/qC/S1k7kqyeJzXmNxS/BcFeFBOc3oPGeVheUa0rs8XFqDGUPXqNed43eMkjzn9teXbD87wkvC8lnOm94pX9LeUXwlNdiy3Ge1/s8X9YfUNwygzVZNThD3GFbEvrOD2+F60czUjhZmWwVx6X3nZjDv69ZUCwL0EmxjztMqj95912sFHq3kqzAGrOG/p1E57kAg2il5An89EsYRRl/RPSD89jBLAxgxwklH59uZxvFM5flYP82wlvmqJ1sHgBVFR77d2EXs13sFR2p12pFavsgERc0dB4zxWSht2tyPg2wrlOO/085Tm2SAYi82kKtUtA9llJG1kKdqWJwZqgl1NH3uuLZ7iZIlnySqOuiTZ/CjcPOhJQsCWR240T/zWY0ncGGrKJ8HVB31Q176oQ22PmWYxiypWkX5mToHbHSMTkk0Fc/5kKkExWnU2wpeQqdvkwf7LXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(39830400003)(376002)(366004)(396003)(451199018)(2906002)(4744005)(44832011)(5660300002)(41300700001)(8936002)(6486002)(66476007)(8676002)(66946007)(2616005)(4326008)(6916009)(66556008)(478600001)(316002)(38100700002)(36756003)(26005)(6512007)(83380400001)(186003)(6666004)(86362001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BBfJsNyFkDUhduGK4fqxMmujlFU7eEp3tXvjNjl83J/+wk9W8/DhmWq3PCFU?=
 =?us-ascii?Q?Sh71DTq/Y3TkpDrft8vu7Vvy+zULvpgD5vXQJsyadMW3HsUI4SKp4aOduEC8?=
 =?us-ascii?Q?3pia07iWjJJZbyRA79XfQvDF+c3kFEpwgd5WFjo7P2HVNMKrHBHmi4viVZ4K?=
 =?us-ascii?Q?8C0Wy3FLYItMaRwLvhM1CvRK8dA6+tbIroLQoBZ9j5mBJdqTjSG/MqsMG0gL?=
 =?us-ascii?Q?fcTcEU5gkfRn1yiuhLBUYM1B1LfyffSzUnEYmxXrgsSPSYxUk/gFjRLyWk0C?=
 =?us-ascii?Q?RFXOp09eb3x7haJbP6NWIZPOkkxr/YgoE3vdDa3HR8k+8TB+jRo0c6zvQUTj?=
 =?us-ascii?Q?UHM+EaA/aF4Gk34aVf//qJMNTt4qrb/rHIFBXPWdBbm9JFjjgI0ewm16fp87?=
 =?us-ascii?Q?0kLp9uucL/6BLp71FQlHJgD7oNOu6gYa1K7Cbfggu4iIwZBu1UqtKFoMi8nl?=
 =?us-ascii?Q?CRzARLH5Cjq6vPQfJaYi11VP91fGvK0WiNsI5iaT2jlXpK8LCGyPFBUbzBlX?=
 =?us-ascii?Q?03521+LXb2vUA6GgYhd563lgRv8tEebs8TUqPp43E8FOh9uyC3GkWI8GL1NA?=
 =?us-ascii?Q?J+W+ou8DZS26ieI2Vyj4Mk6GrZ4EIfCEX1WRrmy57YKaeabl+efmXCFrq0e9?=
 =?us-ascii?Q?vyMZHIup580T8O5Y6uZwE0BAIbkItOzDz6Etiw7+ZgXuufQ8sPyduEyKZd63?=
 =?us-ascii?Q?Adv3WjvgmQfqMsYFYP3VBNqd3an+hHaeD3seSRzTfc4KAYVUs2twE5asu43/?=
 =?us-ascii?Q?uJFu2JG1+PjIxFJInUGC1QslB6vBDhmnp2FoUnph3rLFWFNGlTIt+EhWpPNV?=
 =?us-ascii?Q?Y17qdwxiDFluAR44b2Xm09ekJfECuU7BScul9UE2bsp+cIG5XnAURkuVwbry?=
 =?us-ascii?Q?mxLHOaunn7yvmke4WdysfMnAgtNn//cjnhpfIK88SFnn85E6BjqMOZWR/F5C?=
 =?us-ascii?Q?YuelCzj00973fbb5GbzgI3j85in4pP2qPdJFhDf01qMn/kXkBROINIVryotR?=
 =?us-ascii?Q?FZepi/YibUTJnLJDCTtb1JnW5dOn8zB7M9m4xqFoTsnKS2ox4IaMGy4UVWJQ?=
 =?us-ascii?Q?7b2DRTavygSuf6Uj1CN15LXkjXVUJiyHdzsii0dt5xU5reiIQt2fd+9VJtS5?=
 =?us-ascii?Q?sp/L7WG3HVy5NU3LRJSHA/SSoXPJQ7ixJumcnWnFL8ofpFoiONTFWgNZcLjB?=
 =?us-ascii?Q?53vgvLd/5yObeFEfNh/jrb9RZhq+o7NG6hqr5iNGhq+njRhMG9a5NWEf9mIg?=
 =?us-ascii?Q?wzvUfLkJm1qgXOI7ahOQnd9mJrehJEB/6okCTg+qmlbtN/FNTUw2vJLkl8g7?=
 =?us-ascii?Q?Gg+6uVahb8cD6HrK/styCBrjxK64/3UVCTXnLFc8vxOdb/WCNdTYEFo3ur7k?=
 =?us-ascii?Q?MIXy0oI5nW6kWsgEUWPbp1DokqorjNIhFUrgosuFhpbBywV7UIHPar3UEoWE?=
 =?us-ascii?Q?s+sV3yEOJbGzMd6fZAVXWbgLvWFict0Zbi740sqSAMKKvuSMzw9Yr9amT2Dd?=
 =?us-ascii?Q?tXyqeI7VjcYYwP7JGcF7GDPcDOWQNwD6W/wazXR2gCvU59sRgmMCvlwAm9Fa?=
 =?us-ascii?Q?9BZgoFYx/376BikLZOwpnxHKM0yVpoTLsL4qECBFHZ+9fb8+fgm3RA5+gNSg?=
 =?us-ascii?Q?Ow=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0732475f-d174-4a86-d8b2-08db088558aa
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 21:01:41.4946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DWfjKfYGD3tmJFRAKJaUlv/4ioD9Drbpgy4V80dZC96jcTiL64ibGkuj2RjKbxhxDmSlFteFHy5OmECuQh8BxkmaWHmEnskPjqWU0tGtx8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR17MB3764
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Feb 05, 2023 at 05:03:18PM -0800, Dan Williams wrote:
> Add help text and a label so the CXL_REGION config option can be
> toggled. This is mainly to enable compile testing without region
> support.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/Kconfig |   12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 

Reviewed-by: Gregory Price <gregory.price@memverge.com
