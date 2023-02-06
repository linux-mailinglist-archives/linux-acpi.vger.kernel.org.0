Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0831268C81F
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Feb 2023 22:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjBFVAV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Feb 2023 16:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjBFVAV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2023 16:00:21 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2049.outbound.protection.outlook.com [40.107.212.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669E523C4A;
        Mon,  6 Feb 2023 13:00:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hcA9wdigWBRkpGX6oJnO7mRIVwrdqIws6Rb+Z1mnyKG7tOWqciw7Jrqow6k0T621ICj1yn55KL59iSK+GE+x0UUblbJnPHkaUC9nC6sopF/PU4CN1MOz1/xpMMo58X+1KUFYdc6dxm3bTCD4MEXWesDsGoy5LdTo1+kHZ5f2l5Sx8h5Ki9IS+Jwi3rV6im/Wotxbe5oweNH+Hc8T0mygr7BcAzY8kcqx0CjLQHU6drJEdpR/Z1Wr73C1Agm9OkKVcShRqZSVIw5WR3maSoIBrWHpNePOiYjJyhTkuJZGySG13qogl2ZtTXzjxfGhr7r75Q0eimlZ1Gh/duZNYIVrHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MrTFqNpxDduKD4MMjGthRfRgAEDQiEEIQdRkYu12aZw=;
 b=j9nnyLRfy5eC4AFd6Hm9huNTwhqjEl4/sswIvRu+JPp0YMoNX2DP6KgYgUq/U5LmWQyHi0rEIgs3OqoX7JRo7kAH8Alt9Bw5408kOoHGlFbaFkezincZ+lvdXrZTZyaHayy4aQ0rcQHGvilVc4yUCEJm1wiZQCUMLNzBFa78B9TCt8pQvy8uZenpSPp67qCO8JqnGsgif/P4HVt6Bj3uuauIpjdv/5wQi8gmzb1FjkqzZipvhndZrbN+NuB2IDbX3v6jeUUBGGsbQkqQfI7Hoin9qjkzp0bNYfi6axAmoDc0jyWL4caoKqLUY9n5Yoeghy8VHUn8Z/z3SROPDWLyPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MrTFqNpxDduKD4MMjGthRfRgAEDQiEEIQdRkYu12aZw=;
 b=nXuV50Zyo2PYW5zanAMLxciryWUUtc9wCKxmYkPGU+LY/J5B9J6wtXqUHhlbTxNfpb4QS6ReLVkEcPiHjj/cf2KvssOwKqxbbWmmtoCHPMaB/4Y72D2fQniSCgQiE7YDc1AQuUTISNX0HmuA8qAKEprNz6UpsCoZEgoWbMu0++I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by IA1PR17MB6239.namprd17.prod.outlook.com (2603:10b6:208:418::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31; Mon, 6 Feb
 2023 21:00:18 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 21:00:18 +0000
Date:   Mon, 6 Feb 2023 12:02:22 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        dave.hansen@linux.intel.com, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH 08/18] kernel/range: Uplevel the cxl subsystem's
 range_contains() helper
Message-ID: <Y+EynoTcMzofUbi1@memverge.com>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
 <167564539327.847146.788601375229324484.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167564539327.847146.788601375229324484.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: BYAPR07CA0019.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::32) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|IA1PR17MB6239:EE_
X-MS-Office365-Filtering-Correlation-Id: f81430f9-3d8b-4c53-8605-08db088526fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 090mMUB5rxnU+ZXS/sM0hEpMCKGbiCN8zaad9zBsG2Gu74DHLTI9xt6BlZtyXnkDmnaGS6PlMQBCk2NpfxyJ9X2O1VcHjTBWSFBO5+8QiSmPqOkjt3nj0f4vm9YXFBkcFA4vjNwckP3PduRFe0Mkin11os2UVCKWZIs9sUUMViKLwdcN+UgNnKdfJ87MH/exXZHaTk4RLxPRpALqHqU2FX6DMliWYpnLE50qrbGGAB4ojyjjMyTNg3uE4sHxX6ECf1igCPcPJfQ6vxi8x/r0xW11O5GZrKhYwupInVCmjzlMGXEmBccfVm5O93CrlyxjArNoQjrwMtHjttx9CYyamFZ2j7EcmmTMxFXv89XkJ6eNabjLAQ9sAa9QkkykoxURefwTDvqkmdVsk+8ah5kGnt78B475GSn4B1VsUFa13EckxPoz58jauJh6lh4jwqdPRCtqhxkNxTf8lSBaCZZeSrT0pGu9w6x4qeo6rSbxiZBT4SXYXdZRDuZfSGotvjgqLEvYfqPUnVVPRDzhM3zLGfVf+VrGnQj76YF4+EdEBUzuhj3VCcH9BMaRPk2p93DW6cSLRC+Cy8tA7alDlII0+fHoULE9UK0xRHHxy/9aCZQzrPSngwhuQ8etrltnV6VJVYc02X/K6XEyH4osLHJ7ezfJCfOhdJgcpqI4fIr04iy/tWRdqU/lElzBaQ8Ayc/v
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(39840400004)(366004)(346002)(136003)(451199018)(6506007)(44832011)(4744005)(26005)(6512007)(66476007)(6666004)(186003)(83380400001)(2616005)(38100700002)(66946007)(4326008)(6916009)(86362001)(8936002)(36756003)(66556008)(41300700001)(478600001)(8676002)(6486002)(316002)(2906002)(5660300002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ARxsV7n9ks0vVTW2o25gzxuAsr/Lvk/suSj3YWMS4CsXzSxx8vBdKxBFtiG1?=
 =?us-ascii?Q?8BpEg5EfJ570O9Jklc7uKbtKfNjRZkX4LnR/xw3c6GENkBBIORtvltPFaYTS?=
 =?us-ascii?Q?DHjYVh1rPS7QH+8LRRIxXU+c8KsxjpsWcuEVq7L1xMP0uqG6fyySaw257xwM?=
 =?us-ascii?Q?9jvXByr5tBfmvhxb4BzaBXELcH5iynNRSC3zw24q8Z3l250bil7ynPnyy4zm?=
 =?us-ascii?Q?0V84XInRWDwrm2fCwbFQb4k5D9IHOvs/tGv1JryUJtMQBJybpe1kU5qxbiQN?=
 =?us-ascii?Q?91zd+4L9wT24c5dtGILr2Yu6pXuYrTaakCbDDPBZpKUQyAvEvf4DKNTgO7v8?=
 =?us-ascii?Q?JUhRXNRoYaCzHyhqvysJflspRtUTPXJ1hW1t6wPrfl4kD+kUVGW55v4HRDH0?=
 =?us-ascii?Q?2gU8jr/tHEhQb52/xL0+2zBkSYWoCg5M0mREkhZNi6KmjPdzgzMbA/p9QrJA?=
 =?us-ascii?Q?g6ov0GjLJU8YoX8Sxl0XjtdPTZmSBSVTjIvR3sFU14vb50HPwwQIR6KJEf5l?=
 =?us-ascii?Q?NoZp0dOzQQLWvFm5LaWbYsb3ZrZJccHt2kr9RIKBbOaabjA29udcB8jEtxD3?=
 =?us-ascii?Q?hP1LpNOLxg3zTfAaVpDNts1Fwuzo04Ug7pKIyLfST2kSENV1PiBsYlDjCI/U?=
 =?us-ascii?Q?+2KYEFnIji9KHtHe/f7YkeULJlUbPzOJlQWOGiPaV/o8S/vlH4IEoNVV5hLc?=
 =?us-ascii?Q?BnK3LLiXmx1PgtUPYnCtew8qS5x3iWc6/DwnQCsJXM5ulta4Ld+91uoBOaR4?=
 =?us-ascii?Q?7D7IvOlViZYIOC4mSMFZqE6dtbnrabrD3WLxOCimWBrHpGHdNfABJVpyyyQA?=
 =?us-ascii?Q?vMq3VjHUvsRslaBljhPpQL2+AkD9w59j2S7+3IVEYAHGHnVwy7w4BUtoj3YB?=
 =?us-ascii?Q?Dyzdnak97iVgT9kynZeoCAEY5TsQFpOCedq+qQKEpfnB0HgYXh27PSZCWRB5?=
 =?us-ascii?Q?t+Iykhlbq6Q8D3Ytb8AKF5yYYivF8CX/mHa7X9gGl75ZDbHq2/aUK0V9kZBa?=
 =?us-ascii?Q?lHT4GdPvw7PKCf+yoUCfcr7KcLILN8ajQNtT4t1eKIxfPBZtFSnNhVwKH0fG?=
 =?us-ascii?Q?STPTuBHvGdbKHArIkU+bk1kVtYYuXgp59ThuYrjtM/zvvykKDPsKK775Y3bh?=
 =?us-ascii?Q?pnUyPBLvuS2JjFU5gME8p2XRfy/wWibpjMVW7cPKyIYw+SN4m256xjJDbSpU?=
 =?us-ascii?Q?yZtEv2cOacbv9L3U9RGc4Q0k2aezC0gyC+jkDSR9tM3azHOEgt2okHqS59cD?=
 =?us-ascii?Q?9xZZMpfahizCL+Wn5KVhnAWBmcP3LvbBgGENR7ZpwFhEkiIF8aTdVTAnqF0a?=
 =?us-ascii?Q?0RDWTH/n9f8rS/MwOmFWho3XFmEwx/eyrBtzxI5bihgC5f0QQQqnEdL+SrJP?=
 =?us-ascii?Q?mQTHaU++Jhx145lACP0qWRX8e7JTYj3qWGRpghoSgZWZeSqsNl0pcN2XZKTt?=
 =?us-ascii?Q?BaTKMUwuw+kEoHt9kBNxLpI4Yv9Dbmzjoq/c1evqdR5UDsJi3zG13m7tivzJ?=
 =?us-ascii?Q?D/MOlvzZCq4uAVmz15hVObdyppeOc1GE9eVmL9udcVSnRInC0mco79+OdhAU?=
 =?us-ascii?Q?pIZd0zWFytgZ0oZCsOtyzau0Cqhzky9wd6YXDVyDQ/qruhOAFpjDZtJViMmA?=
 =?us-ascii?Q?1A=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f81430f9-3d8b-4c53-8605-08db088526fe
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 21:00:18.2975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dwUn6wsLWuS2/BPAzvBLRgaA74TmXBSWwVr7JprLIKm1ODSHIEoJliuog1Np/XA4ZJDQJLjja1ff8sr3w1Q2WZ1MCS9ARfrgtj1+ZjpGICg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR17MB6239
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Feb 05, 2023 at 05:03:13PM -0800, Dan Williams wrote:
> In support of the CXL subsystem's use of 'struct range' to track decode
> address ranges, add a common range_contains() implementation with
> identical semantics as resource_contains();
> 
> The existing 'range_contains()' in lib/stackinit_kunit.c is namespaced
> with a 'stackinit_' prefix.
> 
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/pci.c |    5 -----
>  include/linux/range.h  |    5 +++++
>  lib/stackinit_kunit.c  |    6 +++---
>  3 files changed, 8 insertions(+), 8 deletions(-)
> 

Only question is whether this should be upstreamed separate/ahead since
it's only tacitly related to the commit line, and the stackinit naming
seems overly-broad enough to cause issues.

Either way:


Reviewed-by: Gregory Price <gregory.price@memverge.com>
