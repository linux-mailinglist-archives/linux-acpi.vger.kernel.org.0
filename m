Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696F868C69A
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Feb 2023 20:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjBFTRL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Feb 2023 14:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjBFTRI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2023 14:17:08 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568D12BF03;
        Mon,  6 Feb 2023 11:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675711011; x=1707247011;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HvNNLgrkTu5en9vc+m+aZbyE4s0FNlJiQ8eeyDfXiFk=;
  b=BuTq1eg3eGy0vBIyugn4gM3tUNl4Av+W64nLazUMnQWynWqh9GJ26elA
   UYhlFHLekwPEKLVd0r8fILD+CNIfMPgHI/D6RL6yBJVS5aVWGzmMvVkbr
   1bUbpz8AMG5oz1LhKyEo8KfhaikH7KtwhFNzIt2HhHm8MGATn3vwnUt6W
   YcYjd902tvu8hJbtI3Jg6hMoYVucyIs8cLLDNXwQFXmbjz26Nf5oQIVdn
   /VD0SoeSb7m4NRIsOgnUGXOdw73k4grMFXrVSeIw1H1mTiA7jP11w3z+F
   uax1PfCnQ3AQZqD1Pq2G+t9xZd/ekb1fM1cgq+noSv/mP+jzNaFcA5D7/
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="309625692"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="309625692"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 11:16:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="775254203"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="775254203"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 06 Feb 2023 11:16:37 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 11:16:37 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 6 Feb 2023 11:16:37 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 6 Feb 2023 11:16:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IUYiyUJE1jkm5Fyu+yL0k8gDv/Iw/HOu1NU0sIUSfV5HSQFAitf/rqyS7ThThHKjRI0YKBklpDB4yHzohXutiaLgvCCi+lvuUKj+WXNkuJIP0REw8GDikJAUgEOEEPdWxueJewTvpIuqAKQkdveH8MG4xujhCyp0ytyUwwas3cVEjOY9p7bdTbOR62pBETV65z41TOdqBjaFfQJVNnRUb6Zak2oDCSzbE5gwZW3x/nHJEhnKo0EppDh5rxzm/E1vN89tpPx/QUrBZKrykeoHAxr210LFURuv69xdxr7lGKXSdrg2tNS/6GGcu1YqfnY18V94XVb0lNAPfbqEHVAsxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDQU9xly/6QLEahVLqXuCkdMPB62i75w+sx3JccrJb4=;
 b=d4zJgL5GcWs7ucTgjqumhzCTfpMcRs2pf2hyNcc0tfnjV0W+YveC7QAye2OoRBBArP/Ze5K/2eMYcI5hSwn8hOzH1lDvmUfR0UsPr1jyXTTDWw2svBKJwFeGY8ESyLrlDuZZiSL2sisb69Xejm9oF+3sr4qxdx9hBOe+wsVp1duR5Azg7PSGYn9d8HTOPHOqHbgD+N6LkzZne5fOmRcqX8zL8u1RPwsgakll5wjsp6ZqXPt3AfqUwThxcElKolhwLWJ2ef7mjxtElBMWBqf4bRjmerspODGOIXVgd2VTtPl7aYgGMzcULtHjiiB1pzLJ4URRHdXfv1PJsDbXOQyOhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA1PR11MB7776.namprd11.prod.outlook.com (2603:10b6:208:3f9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Mon, 6 Feb
 2023 19:16:35 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6%9]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 19:16:35 +0000
Date:   Mon, 6 Feb 2023 11:16:31 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
CC:     <dave.hansen@linux.intel.com>, <linux-mm@kvack.org>,
        <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 02/18] cxl/region: Add a mode attribute for regions
Message-ID: <63e1520f73f22_fa329294cb@iweiny-mobl.notmuch>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
 <167564536041.847146.11330354943211409793.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <167564536041.847146.11330354943211409793.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: SJ0PR13CA0178.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::33) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA1PR11MB7776:EE_
X-MS-Office365-Filtering-Correlation-Id: 8283c954-c32f-47ba-74c6-08db0876a9b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +rGXFYfh5AoUlUJnJNTjG9R2riS6++FVBAqYGono4TRa8oyj4yIp7qQiMPWj4AhHM74qfkwezvVWAsbzuSIBlgIjvnq67ojzyE3Pz12OsILAQhldGiAYoei7MP1Lke+R3/f918GZyEpXuElJoajkK76WDD+BpmQbnwUgyEdciYiQ6T0z0uqyYaHDlf2nSNLkGqVbffmw+6knVf+jrto7E067AtrNAI8SlIkY9eCjy2R4VKYbqXQD3x/gmG9dHGbEgYpnaeKlSdiQ2pBpmhBzBdPE9YC/CDBx+ybFfwNVOtMyX6oGx2njmxIiUL0o/ru0pSgNajr28C9Z8OJdUDDgeHr3Ay9d/BTnE52z79nXXbojApftzmX/fbK2FP9Mk8YOxvyX58JjTZeK3aGvyspg4ICarhjuj6LNmrJu6uMvqUbFSC0t2HpFMHlLjvvXRXsEOV21yukdUj6HKGLEd6sbEX6s0dTwEManABFvesBxIF4R96pW0sIaU5m2EfaO+7e0CMOD3SyblBKYZgZfBIZdugznGt5ulqjev5oKcq7RYQmDJ4pw2gFFeta/n+uIiUh2OeE8mgmxw2+ylA6h8N4TS3U7UDkmQyM6eKVFJ/0PrLusQwIrls2qfWT+gQWVSWHDk5Aq9wMdJd4xaEF6ri1IRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(396003)(39860400002)(376002)(346002)(366004)(451199018)(186003)(4326008)(6512007)(26005)(9686003)(4744005)(82960400001)(8676002)(5660300002)(6486002)(478600001)(41300700001)(6506007)(2906002)(8936002)(44832011)(86362001)(66556008)(66476007)(66946007)(6666004)(316002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xy7uuNGURBZaI15oiBm9qp/8hDoE0QC6IEO/jqYt4Mbp9mZ4z7AGCKS5JeSi?=
 =?us-ascii?Q?SJA+Sgrq8WjyZiNGbCzJnXHH34GJ5uON1C4dvhuIQjgTEXibNb+yMtEJPRsB?=
 =?us-ascii?Q?1R4D5TrwPgP/FZ0Et6Ynvz1h6TLFDO03p/iECC1BbfbOPm1TPrhuoDMV7a5O?=
 =?us-ascii?Q?HIK5oFDsyfGFL1Ib5ET3W4lXw5UK6KqLRgVJRIwKZLqpsjHPeBDsf+Fx6sQN?=
 =?us-ascii?Q?Bdbx32kgptSUv6dXpjPlp2lBCGskMVfh0eicydUsmu0S55/G5VX/W3Hz/GHb?=
 =?us-ascii?Q?eDJIozDRifcFbZCLKiAJ5Vis5n1xyDbkCG0JE8AKUU3zypR7oblEtz4ADwjU?=
 =?us-ascii?Q?M1KKL0YeXwxHCJHJ5s5Pjh18PmojHQ7AgmVsDLf4RHP4GHn1FQeioPflfkQr?=
 =?us-ascii?Q?hK9pSqn44fXOwMPcH6WmFUHnFYN3fAkN7EKvcme1MQ0ToarTLyDZr8g+RCn+?=
 =?us-ascii?Q?sk/GJdoaVMhcoenLQAwASLdtHWhKDRHOpFyhIE6N8+1efvFe4YK+g1aR68Ec?=
 =?us-ascii?Q?mM1U5hwtxLqOk1EaKNhCe4wm1/sCyNUjLfmRktoS+8/6t4uiNfeOB3rM52WL?=
 =?us-ascii?Q?Z8TZrd/S7w2yh/OTcfB1rehqO5zKyxIiPnv03up/HTdsUKhbd3rA6adWC2Ot?=
 =?us-ascii?Q?2rb5i8F2IuTkPBhQz7bkg2bALqmAAgVCtFq+1e6LH7qO34QVhJ8SpKA2Oi+R?=
 =?us-ascii?Q?HsrfQtVWnYt/Rp3nVzWabFVOjijaqbHBYvVpGtVVg5fuT0qCKZXbv6JvZzAj?=
 =?us-ascii?Q?y83tS0ffr3dwuQ6lDLWeDgcjubF2mLqlERvOlzvGUypxfKtzDNpdPCYampD3?=
 =?us-ascii?Q?k57zAfgcPdCclmG6R6h+sQa1BnF8w6qudInUEy86R3yGojIiEYBZkyFjfJ9Z?=
 =?us-ascii?Q?EYtq89MuwF5ahhUfjidXExmxnSQq1vI2OSVWz4eJAC7p8yIDlgg4NwW5sJ8f?=
 =?us-ascii?Q?obVBX5ss7GhHaCjK+7OdbIAzHYu4aNfco3U94gEqRMMFLqhYdjnoo35d2AQO?=
 =?us-ascii?Q?qI3KSPP3icvdwUE43NekSmNR8BXwhrVTV2jO5cWSTDUPP+iJpjBEtFFsMQPN?=
 =?us-ascii?Q?GaxCDmaWysOvBMftIbUzmM/4oVNtRzijRXgyr3BEObAmoy6feanWiwIPZMu7?=
 =?us-ascii?Q?w8WN+2aHrEyfkAAfjSjyNpJTaK0pjNWbRqE3sOnkxcUlmhGaWP4ahi7L1+VQ?=
 =?us-ascii?Q?W0ZP/r+h2b0dk0D8Gql8iFfJm8OhO11MhIyCzfDht81v074FtbXL4hbGle3f?=
 =?us-ascii?Q?syK/9Gz+rk0FyD6B8ekmzO5CqHw7Oq3RZ4CL/WwzH2MdDMcpG0hzazt/4Nou?=
 =?us-ascii?Q?EtFdcCuQgYD0rXgH8sD1j0m3aThHg+rWiRJz5CVGfiL25SKTPGp8xLPXcHzx?=
 =?us-ascii?Q?DF29onezH5WMrDim8poXqZs7LV5Gg8/2qd58OJ6CPX7dKWceS7fueuxQD6wP?=
 =?us-ascii?Q?6NgGE78uhA+uOH+g4I1koHz2lr5qx6b9plflW9jpvRG4y/zyuBAFMBmxT++p?=
 =?us-ascii?Q?C1pWI2MmqXVjvyU7caqIy+n2MniUs7a2FdpZse9ZtdS+ppP4WJ358DsWwI1Q?=
 =?us-ascii?Q?daetUQhALgbJ4wy8SQeXRFL2X8ZFDdldvVFoHuBy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8283c954-c32f-47ba-74c6-08db0876a9b9
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 19:16:35.2067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0iNI3C2E01gzq3Egppg342Ppqy4qsbBP+t+1B0DUr0KpJkaSuzmWFxMpSk4ieuNQBzNHYumHUsV2dD3g/ce8tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7776
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dan Williams wrote:
> In preparation for a new region type, "ram" regions, add a mode
> attribute to clarify the mode of the decoders that can be added to a
> region. Share the internals of mode_show() (for decoders) with the
> region case.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
