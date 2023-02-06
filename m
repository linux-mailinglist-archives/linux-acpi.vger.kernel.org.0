Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBD468C7C2
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Feb 2023 21:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjBFUjG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Feb 2023 15:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjBFUjF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2023 15:39:05 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297BA72AD;
        Mon,  6 Feb 2023 12:39:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZK/jJBDFa61KuQbs8ZB3LcoMIeK4XhhV+qFHgC0OVDaDYo9S5IZrMK8fY1oK8cTsyWKsUbA2xU6gPF1mMxT4NOUhsp2EJ6WO1/iURfOUG2SRN4UcgM0gZ73yfrUeP8dwmRPcARp63EHDttzdxnjHzZSHgxq8l6aOF6nSHLsvK8VAgg9+mArkH3hMaTSuymMzQXOLCHFn4ur24BE7gKawC+sL0NmZgOxaz9xzq6exS2A3xdsrvCBQvF+PT3qwYskZGBf90Ga73e577hQAgdJD6FzMfZ55Kt22cF3VzkrI9NdyMCGV1W/Y4M2bzsQv7FO3eQN/aCkaZ4/F+/qwCDVZ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XCn3xhTCGwZ5uaIAxGohr3E8SbapZXRd/tEegcw4KSo=;
 b=QNdYyZiwx7Nf04ewX0le5GbvaCjeeTqmN6fiyjVzSb4ySWqZz63vhN26kMia5goFDMEQPbujwasw8yEJ7vxlWlBfhi9QQ/iFslbOZDdAeAnnA5qYHdiQBkjs3umxLrtoW1nSXvT1f5xFrNTIZTa4YTAhs1awCgVz8sk/FLR+sM5chI4HP6a+/+ZG4pME/oRFeA6vidlAJYWIHlaavbpS6mb7fefK4Z6IK3+0/sCDLFtcKbfBmRnEztEH2YQMmdTEJl+zTY2cy3TChMlpDV4gdRTVgZoaYJGUlGAEQ9hynQ1zlzXpR8CYvdPjAnz4tZzMnwbNFKzXj9iu7znJKwqcAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCn3xhTCGwZ5uaIAxGohr3E8SbapZXRd/tEegcw4KSo=;
 b=Qa+voehm/OhDk0hH9Bv2nuRX5S3vhHduaUUNwnzyV5fNNssl3fsM+IIEwAhTiC9SB3NrgFdCAmnfCYTtzidmhGvlpf1NtZjHupyjmGEOHISpeeELQvRZvok+Dv91ChVypCAphg7fNxMTD5V+hdMCR40v32Bg6XZKb0BhjGbdcPU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by PH0PR17MB4923.namprd17.prod.outlook.com (2603:10b6:510:ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 20:39:02 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 20:39:02 +0000
Date:   Mon, 6 Feb 2023 11:39:20 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, dave.hansen@linux.intel.com,
        linux-mm@kvack.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 02/18] cxl/region: Add a mode attribute for regions
Message-ID: <Y+EtOLiNRLEEeJuu@memverge.com>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
 <167564536041.847146.11330354943211409793.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167564536041.847146.11330354943211409793.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: BYAPR07CA0053.namprd07.prod.outlook.com
 (2603:10b6:a03:60::30) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|PH0PR17MB4923:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ba52c71-6b86-4378-b9e6-08db08822eb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PHgfVOUJk1jaTHnquy2sstE7kfmLOksJOhi0I0ThbXaAHFBM9mRpVzflQ1Z8GV1ZoWUhXiDS2ojcQrhOtbzWvmO36lHreNQn68L/kZ5OMu/4uEAfSJf1/nzvssFTX7sYKkjzxUhfQvmRIK1oS8wW4Rq8QDjU+2nwUuJ6Xeg37hOgVSBhFbZGI2c4pzwLEwogs57hm4MXTE2NCxLhuFNylU3+P+wbNDhn5EZMQXEP7tYY8chkUtPxg3SFLnCqVR9ibP6aYTCQB8aenls7Q3OzE+iyX8bA1rc4AY7BeWCUOf4V15nEkhX1HT5sQ4CHV8u9hj4KRcwZlpkgkad24182v8j8p1VJ9pRO+lDjXlAqVNbqT0NGghfCyz7eVDK2noa3THXVSEgwptL76KwobzbF4oOHdPwqZxuLP/Q+KB0RGwvDWWaWP/6dPUui/b1shVLpfOhFn/7tAO3DQzF6A9KZY/9ihUX0podcgty7YTUBkn/n+OiOs7vRRpYe/KgASsx4pj9lamTLWCMui4O60tIP88d7eInk9Smbw8GCunb4Tbryk3b1zNoST0MDkW3L8YMFekmQY7X5Uid5QKuptdbo5ucwIMe49pPYWhsBSp62q2uI1TCgpHnKPQzZrhF6yNTDimTuQk1xNtRSD8p0jkQujrSX6UdCTeKkLmSwAqHIsa9O1sGwF5lvy8X9bGaaZaCn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39840400004)(396003)(376002)(366004)(136003)(346002)(451199018)(86362001)(36756003)(38100700002)(2906002)(478600001)(6486002)(41300700001)(4744005)(44832011)(66476007)(6506007)(316002)(8936002)(66946007)(5660300002)(4326008)(6666004)(6916009)(8676002)(6512007)(66556008)(186003)(26005)(2616005)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wakugvR9gA94L8zYWN7srtI7J+XvIsFCN3O+iNno3umzwW5ybhH0o0RfJkHB?=
 =?us-ascii?Q?INiz/IVaB3hgRJJ1mrtu8m4KmU28wfxPsV+eF0QDAzFZMEc6rphm75YIW4Zq?=
 =?us-ascii?Q?/aei3VIY1dBeVHJRWzCE+RkAYETvtGTEadepZ3g83KZHuYlUHa7T4ilhBIZg?=
 =?us-ascii?Q?rtoCYyKfq5z+IhQKF9zjnK9uMc7k6GcFzePHXK04pc1p7PGFTHL0X8Y7/ZU6?=
 =?us-ascii?Q?T564CQ328eutOanfiTuZ/KjQCLBoPGqk9ER7/lplsb0sMb153hk5xAPaMMtg?=
 =?us-ascii?Q?mJIVKIuXhyzZPxPmLWHW+IxSKn54BHAlQcmoDN59xkeHfOTUFBgZljDiJN4U?=
 =?us-ascii?Q?6K0IwDT3y9E1Y00INfhwF7ynaVqe/QzECDdotYZq5sD8oGEoBQvptMtzt8M0?=
 =?us-ascii?Q?broUm/a7ghyEW+fADGwPhCd+24jB6qtbeRsEzF/ERM8zsedrS2yTGKJXnA2J?=
 =?us-ascii?Q?DR7nOTzK+H87raYW2Z4fKj1JxwziZkbPRcG2QOplBNNXqvfUTJ/ZaG656RJZ?=
 =?us-ascii?Q?UbxPnmr+NWRVya1BU7ImZ4w0DEWt/nUf3Gv+/pHTyNAfDT+YyqjDgb460n9L?=
 =?us-ascii?Q?5EHBMf0PBfAde5zTibb/yhT6AkCqONzTyLBE4dNlgkQTWJV4q/VI8CgsBCPp?=
 =?us-ascii?Q?JtcvD0MYy/qJ9xKFtVvLbfONe5w2a58UcEsxoVii3awPksgN0DgEuYTTTttv?=
 =?us-ascii?Q?zHQg5wW4eCbrqnPp1Cu51xa+rE7LU6yHP61DYsSlpgMPHntq5ukkAZgVGzk3?=
 =?us-ascii?Q?tOkoMf/AicCpncD/U/fBjcmXDf4eKr8KJvu6s9uRQo9iH1TxICJnw9LfMZ0G?=
 =?us-ascii?Q?R3X9PtqoZBuubTHuGcJLMb6VwKeVL6wOfBlpvlHBrrqaeH6FUDceNc5UChvT?=
 =?us-ascii?Q?lv/OAKKoR4nhqStlYAZPaOl+a0ZWUOKpO6H8O7XZcEqR0UhYClPiKNgNLQgP?=
 =?us-ascii?Q?c+dVddJP/mlm0fEnyBOy1i9Rr90bNxQz3IEwxPKcVcmVHgNVAY2FxV9eekQS?=
 =?us-ascii?Q?ABohlpQ4U+4lObHgUoAOaiHjBhT9xnYr1JbCDm5PW/+5/bthQFJINAUEts8y?=
 =?us-ascii?Q?r0JJJJcmkalxAD2J4Sws8YP26Dr7OGCPUrhDccwyCDmbZphCXRshWlBm9riU?=
 =?us-ascii?Q?kxdQxLBSU8wMmQJBWvtJ48kVJmxElWidnm2LH9Ay4naF0iWV94Or69MiA1a+?=
 =?us-ascii?Q?F5eYWV/tmifMaKHqFhdXT486dbEI1w8109UgooGHdBSZrTC91H1jpehPfZ6x?=
 =?us-ascii?Q?uRB7zIbzdmIaFRUH0PSHmZhCF7yNKBaBpudpZB+Y3ivEr0vkUP8N+jbbGBRh?=
 =?us-ascii?Q?Ffnd6WKyo2KYP7IQL62kofIAptiSxapmLQF3pJvzDY8N6bZGUo8ssT8vksTf?=
 =?us-ascii?Q?JgqCDqIHOigZ5YO+rlToiwvuuIs6e7ENHbJ0qal2sgQeLyfmF8O+FkxiU765?=
 =?us-ascii?Q?yQ8f1y94STXlGq7iv2UtIVqhM681YD6md9a6uE3Y0NLDtC/bKD+LeiVaK2Dj?=
 =?us-ascii?Q?KhgaCg0DYXjkVkJcYrncDIQ3kaUjZe5ljxWoBlYMn0nq/2r6AJMFOcmSBtz8?=
 =?us-ascii?Q?NTba+dykklPJSC53KksidH+uCaT//Y7TG4ArTNZ1RXZ9tE2GhHIjVYHTVU81?=
 =?us-ascii?Q?pg=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ba52c71-6b86-4378-b9e6-08db08822eb0
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 20:39:02.6411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rLhlP0vBF1jhXFUvXDecmNKQMfX6gWGR0fO4Bf5b7BhtbMjIsoxBwemsHIyr/0YohogDyxIwi+MXN/OhCqpYiwsRM9srdqkC1yZ3hJaua5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR17MB4923
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Feb 05, 2023 at 05:02:40PM -0800, Dan Williams wrote:
> In preparation for a new region type, "ram" regions, add a mode
> attribute to clarify the mode of the decoders that can be added to a
> region. Share the internals of mode_show() (for decoders) with the
> region case.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---

Reviewed-by: Gregory Price <gregory.price@memverge.com>
