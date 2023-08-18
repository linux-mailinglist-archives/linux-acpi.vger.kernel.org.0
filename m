Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8DA6781354
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Aug 2023 21:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244225AbjHRTUI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Aug 2023 15:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379603AbjHRTTm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Aug 2023 15:19:42 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B3F3C31
        for <linux-acpi@vger.kernel.org>; Fri, 18 Aug 2023 12:19:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0uNgOPO47jiH1YvL5wIKoCOsqeYwekVtETi/5H6x8WDH1b9npxKKWL+OBChvQ3F2VrLD0oguZvdVzDQkNooyv8ozKj+HTDm8z/Xc2w40Dkd3RcUZ6kInWywV2bTXtUD2EPuHZbBsBEglH76E2nxEPcrKfGwIeT80S93eYV6/0MJUVywzXfANrys86z2zmXZbne0/fH8LLyZVaDzoTWcE4JPqayAz1qiY95zWymtQsu4jPNOqIWdlNnwZF7a1s4r/ihXZKic6lyBIP7WLJuQTOoOgp4xIj8D+7h0cynYxUWDf28iYMwnHrfcsEolrla9QdD1E5qcN4NJhc/zCCl8cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7VpMNWYKVigqRASAifxiwBWGsIsc61vpTs2ZPl44uY=;
 b=VYPI7zR6vzKEOaTyOSNPXlm7BnkRHYx3CDM/qp4s1nKFqFcMSMdbYVEGv9eD/oCeuFP9Tr58LKhI33NDZBo/I6E0h9BQTj/MbA6wGRcjVRGm2ApmkXyGXIgqlzZ+jSau9eg+1ficc6zeSAFA2JDFzXP1WiW2yYGmethiPDvdbFN2ynvHRjWhqxLJKdsVJefOTBn0MdTZtArihszx8efmaV83smywCoqKCSWOHG4dQOQC9PkXUyX/D/t+WbnNGTyrOMD+j8qN29Y/xk4RUQei5mjtSOgN9bvl7/wXPPb0a59c4cwuI/K8HnENGKfNtzmiW5XX8ndLoObA4n+sXQZobg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7VpMNWYKVigqRASAifxiwBWGsIsc61vpTs2ZPl44uY=;
 b=d1YX8owZB5sUEuYxEXgzb4Zt9E1boNaToy5aO5y9O/Jvy1Ow5wo8KcS660KrWrFj7Y4uqrfoS5aHkOp58m3iHoRjt427LfVc987VgWgCVQ+1hMijnQ4oG3oiST/hPgANrOkhOKL177wQ/8+gZezTO0OwtqI3ri5rlGxKT5idkZ3ebZSXZ+hDxRdZx/IWH8NoAw65FLqdGe+rDVpGkXPB4+w6JxNr7Ll+gZWRkwVRYLb/7kpVG3n+GriK2CoHiTfodYJCwF33Roqc8uho3eki1UrJmtS/42xjJbQ2mEpBqbxiGGi/lJRzQn/evPaPlh25guUJDz/Blq2cg76SuPjUBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB8177.namprd12.prod.outlook.com (2603:10b6:510:2b4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Fri, 18 Aug
 2023 19:19:38 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 19:19:38 +0000
Date:   Fri, 18 Aug 2023 16:19:37 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <jroedel@suse.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v2 0/4] Fix device_lock deadlock on two probe() paths
Message-ID: <ZN/ESR+3pchFRB9g@nvidia.com>
References: <CGME20230809144403eucas1p1345aec6ec34440f1794594426e0402ab@eucas1p1.samsung.com>
 <0-v2-d2762acaf50a+16d-iommu_group_locking2_jgg@nvidia.com>
 <d090f196-a5c2-b188-31bf-e42553d8d251@samsung.com>
 <ZN5n7GnlrTS6s5Yg@nvidia.com>
 <ZN-UpDFHab0vGuXp@suse.de>
 <ZN+XE7dk04f2C3D7@nvidia.com>
 <ZN-3Qfp3CyNiwJBK@suse.de>
 <b31c4b66-9543-a827-9404-227d3fafe22f@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b31c4b66-9543-a827-9404-227d3fafe22f@arm.com>
X-ClientProxiedBy: BL1PR13CA0308.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB8177:EE_
X-MS-Office365-Filtering-Correlation-Id: 40c450cf-80f2-48d1-adda-08dba02010c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jxB6qddihjJg2naex3x45EuTa4cdtnI/cqGU/eFzlZOtfeS/hVV13oqLGwTxFOtACVp/wgzuU1fAT0SHOiHVFEBvDMaA6Wy2YVIRfMihawrGe3qs+eqpttQdEHe/42mJ/jfGA/Rk81HGHdZsviE2c+EiV9iPpMSfmzowj8IBm/PSZjlKoxSdpDAtZgko3kRoXtbDs/SEo5IDlfzmC49AplotBlvxBcRJJwCGPOzk4+beGysog5tDIMCu+WOTXLfTax3WYVL0BRR/aR2CTEoqtNXFH4sVbBoOzr1n2RqF/xcRbyN4lVsMv1ACUfBMl1rEqbLyQMJndJuoL43YArlsWh2zhgYTCd0f6KzniNsI77V/RcbDW8bp7vEVP7864835pejQzsYt3f7tN/U8qdLKC/NlXXbdQIfmQW6loGQ4CJxQgMdbVeGFXC5WZCXZwCPmThln3XR35CpuCJaQT2TOx/eytKPBWydoU5OOk5NYUF4RRQaFrynR0y1BfYsGIhjkd8YFe98801BIn/q3jE44ygN0/Qs5MlEdE3TkU43xU7J8AwTw5/7qL1klYkvjMLi+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(366004)(136003)(396003)(451199024)(186009)(1800799009)(54906003)(66946007)(316002)(66556008)(66476007)(6916009)(41300700001)(5660300002)(38100700002)(4326008)(8676002)(8936002)(26005)(2906002)(4744005)(83380400001)(478600001)(86362001)(7416002)(6506007)(6512007)(36756003)(2616005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dwXQQNnZjIspXigISDiwrMeq/VPPKVsSxLo0mQZHerP8Fx2hlAyWjfiQPjyj?=
 =?us-ascii?Q?u2OvDV51XKFqARFZMODWc4R+ffn4rcIcjCT2Thg44YSIgOeMuZsgRYPWrSDo?=
 =?us-ascii?Q?LvXWwgivzcwPLJ2ehmums6FNTOG2gWmC4mwbLYCyz5Re07zhNyUM1cgK3C7b?=
 =?us-ascii?Q?WO3vjrN5pyTC0elU/5zRNFsNpb7fCqFeZXY5f7EB+YZWQ7F86vznlB+gzYhM?=
 =?us-ascii?Q?oBJ40RuLgi2JYS721HGqeafgommF2GEVz0+9vj682P6OmM5l9ME+G1QESL0g?=
 =?us-ascii?Q?QMZv5QIB/ucwnkYgVInLkTLn1iQjoqQEcm1NimGE3l9CJDPxPvRX/o7048DK?=
 =?us-ascii?Q?no8nNP5kkb9Q5LlU0ckBV5KkRfQSqIykO0NJ0zHgkg9VDDk+Kuf8llYIHA9E?=
 =?us-ascii?Q?QgVMF4sS5egryMtUJeuwhi+e7LyxGXBpTc4Cznp7s523AmpFAWN0XSJS5WXP?=
 =?us-ascii?Q?3hHt2eHHvmem7D/V5WlJKR+Ip66w9cuhv2IewwNDg4BHWthTMjWOT7WNw78R?=
 =?us-ascii?Q?tY7XzeufgIyW/Ari2nH2SjMXGvpobaoX+S2uAlpl7jMieM0hBZlqDJmwhG8R?=
 =?us-ascii?Q?INKWzkWzBVAha5dqXXwd6YfWYbOLCwPJmjVmFqJt4uDmPIEN3RNADH9Fa5QQ?=
 =?us-ascii?Q?6tu3LHupHcjxiUCXIKtTJCuXi9MG4KjQ9bm//pEWh7qzNtuF8SJD2O0OUs2c?=
 =?us-ascii?Q?5UrqdkAkH4VwmAT7HQnd7XLRrgo7PFLoVaxU93mbUHM0uhQKHZvbrL4Svxv6?=
 =?us-ascii?Q?up2plx8O5V7vQqd0wtU4HIvX1EaypEeQJ/gLryfqtq2kQiRjwEdIaIG+6t2S?=
 =?us-ascii?Q?iM4EppJgBF4wtjjiMsG8zEnKC2o82ARBmc7n6vHoGulcS6vEfdo5VNw/ICgs?=
 =?us-ascii?Q?yIenIyW3Fi/D9FFwVEljKRYJP5pjaldgt56tG2WTXEsdvXEk4toCGkhbjkzN?=
 =?us-ascii?Q?GuGTNdQeCAbdieDpdo9AujJregB/M4UYFopSvEjblvqKcOB8KcHti37H6MQk?=
 =?us-ascii?Q?NJn5VYrTQE7I2iymIik0BKOhYfjlMPAb5pdAxlkjXfmI+2WHnlfm/HEnKVPB?=
 =?us-ascii?Q?uMUDNDLOsakYNRVoyoW+A/cPbTsyYaxeB0qEXJgIdxqH0VcWvupLSYxW+GRA?=
 =?us-ascii?Q?Zib8rNb6o9p2b+EiIi2Qq/3Yt7b/UrEXA/7GAsafycooCH49dWecUymi92zs?=
 =?us-ascii?Q?aa9lfBuNKnsEufmY5ZXkzXxTcPEZgYP0gbOIX8STpdWFY4McpyFiVb1L5DRn?=
 =?us-ascii?Q?qxoBwTXDkHm1+exOCqJ9ce64DoJC1kpgbeCgiJ80xDBFZWxBx67ouftGWX/x?=
 =?us-ascii?Q?fzMDGNNbUIN/hTfSlA8c/yP4ku9r/kjtgk3LmljNm6L1MVq9r7RA1grtgAW3?=
 =?us-ascii?Q?c2SP+BEcVqHE4XwknglN+nLxM45kUoFu5JlqxhJKl5CkZRAE9RQptFvVh9NO?=
 =?us-ascii?Q?Bgqkkc8yHTCZ7CEGzT2/jHjDOMhBJL9+iRha7xOHlZofpUT07glUv2R9hSa9?=
 =?us-ascii?Q?DMDblldmRB7hJT4KoHw3aSYtFzrYvxrHEAsGSb8ceUxcEvYG4mswjyRxDhZN?=
 =?us-ascii?Q?oxb1+JwBqOh3YjvjrK4fKbcqj8dJ10Cs2DnuDPLg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c450cf-80f2-48d1-adda-08dba02010c9
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 19:19:38.5303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: feWVmiJH76AaXzGbu/t7A9EkUQ0rdYPzQ9loDval4ij7oAIDwPqepmdDVwbzZj+j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8177
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Aug 18, 2023 at 07:50:18PM +0100, Robin Murphy wrote:

> > There is a difference between knowingly introducing new lockdep warnings
> > into upstream and letting warnings discovered upstream rot for a while.
> 
> Furthermore I'd say it's one thing to have deadlocks or warnings slip in as
> part of some functional change, but quite another when the change is solely
> reworking the locking in an attempt to make it better. This is clearly not
> better.

Exactly what isn't better? We now print a warning when pre-existing
locking rules are violated. That is the only issue here.

Jason
