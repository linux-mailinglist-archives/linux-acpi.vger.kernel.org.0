Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6576ED81E
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Apr 2023 00:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbjDXWqi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 Apr 2023 18:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjDXWqh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Apr 2023 18:46:37 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0C561A5;
        Mon, 24 Apr 2023 15:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682376395; x=1713912395;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2tpba3SwPpciHvIoFAleRKbkvtCfOpSOMs3O+WJ+uf4=;
  b=jT4o0lhEQLG+f4dy1IT00jj18fp+J2J4WW43O766aH28TY3C/Fios3NF
   dnE4aZy4V3iBiKo+sCcNy/Mq3tvFlGFWObq0kLeMRBYFTBZrRu1Ff6njq
   6jl2R6y2yDvFm/hku7l6Vm/E8mPmKfppqMiPXn9xGDDjMOyDk7r0+N22o
   PFGrSNwroNLoM5rLNL/KfHxHDKGDa9xr0cS/i+YLEzzOUdeZTxVbuFlpJ
   wThiSc70PSyPjabBh1vEWqb2WaoPxDEFhknNoQTM9XplV5p8EwWu29hLY
   b+kw7DqeRlYgIKEiD7RB95QFDY7fJQVB/SyYnCboCekRg2yJzQjfkOw0W
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="335483718"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="335483718"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 15:46:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="725874843"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="725874843"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 24 Apr 2023 15:46:35 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 24 Apr 2023 15:46:34 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 24 Apr 2023 15:46:34 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 24 Apr 2023 15:46:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vsr5wixSjBaagIQEiOCTJWB6JHS9h2yaLboPaeMRa5JAZDDDwqxruZwEimmDgjAKSfju54rmbnhzS+cHEL11qQlrT/aUtGpA2SE1vD67I8Rgnet64dA7YWVAlft0xCSrNYSon66qI6sjwTQfehOEakYqMUcxDSkd0J2E53GKy2K8LyC690Xx6NoaGncwVdrbUbJyvRd4mH5BCIV0+qGVk6pZVpAP5DKv2JgmCzL4BExCDjA7tiwM20w7kydBiF+DbB93hCk4OHTMTsh94xnUsGh7ddX2VbFdw59Ph2paTRJVn7AXLnKRXQ9dkFMm19no13+tQ09qBIPkZQLYJH8eqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UEyTCU0RYt3IE+qjazF2XQ3V6Q0dLm/gJrFsVqxekB8=;
 b=gqxKIwZDNbIsu5uxtEWymX703VXyqRrJj/ovftfVIUrJHuCTrkeQthrYDIWMRmK+F23QClXFLbZancw1m8DVBG1ztggAIKo4gBdgcXCQi9vaF0MhZhRBgyMuBYlIpjnM1S+uihBpQ6wu2J2ueQLbMX90HQdUq/hR8ZKsC0gXDrOXzZR4oZOV+pFZ2eXnTTIWB3O86uQkrtbeI/L/I+abTz7dLhPY49KmEx2/e1Hn4k1qQxbt79gN3j748EwL9yK80X3lAOueUYycmcLqsIlmkjuJ99J4alzwehPPA6OB1Xi5f3jImSABLUjQXUv+cT54p0LjoDtuDlKVR3JDedZFwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB4926.namprd11.prod.outlook.com (2603:10b6:a03:2d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.32; Mon, 24 Apr
 2023 22:46:33 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%3]) with mapi id 15.20.6319.032; Mon, 24 Apr 2023
 22:46:33 +0000
Date:   Mon, 24 Apr 2023 15:46:30 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>
CC:     <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <rafael@kernel.org>, <lukas@wunner.de>,
        <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH v4 06/23] cxl: Add callback to parse the DSLBIS subtable
 from CDAT
Message-ID: <644706c631bb8_1b66294eb@dwillia2-xfh.jf.intel.com.notmuch>
References: <168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3>
 <168193569717.1178687.294428469465996536.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <168193569717.1178687.294428469465996536.stgit@djiang5-mobl3>
X-ClientProxiedBy: SJ0PR13CA0048.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB4926:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f2b842a-2ff8-457d-3472-08db4515c04b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UlN7aqybm1NFv7Shq+eW2clJodz4HhF4ImupWDdVA6zPfqxZaksDee3GPnkexk+Lpc7RaVELyrWEzXwuJsqbn/IofNTgb/dquJU+svsYxBgXJu6C3v15ddAnbWHPqDfF8M/4I/v1hYzNGG7XbIqE0gup5FkY1nSfMYEVfg3c5vFdPogSQ9WX17II+BgZTHy+UV3d4lM9M4ja9GKjX9kJ1Bms3Kt3M5pB+tlELk3UWoVKiWem6Iv/rGQZZMrZWivdlCTBCAbsENp2fiT9daS2L6t6hXNolugf1ZYC7jDcHZFLNY4d5fjriFMS07ubpzjSixdGJhq5VOCAGGvibaukoOnpKMEyNFDMtH1ZcBr2e/7Dz+59dc3At7pMTqBSDEJciZcvaafrM8u4vFiQTCrJGgCcGQZlNZdMOv0N7mYnvdhkIXhOnp2I0tqihuvzTEGd+8a4eXooUORbreq6b1aCWK7cYQW654LWiqz36EotRZ5Fxcf1zXqHk3rlonj4QTy/TbqZ/j96atyVv81pH0TUc1g6RLq8PqX1hbKctH+GSRvsB68kheCV4bjPRz3dTQSz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(396003)(136003)(39860400002)(346002)(451199021)(186003)(86362001)(6512007)(6506007)(26005)(9686003)(5660300002)(38100700002)(6486002)(83380400001)(478600001)(41300700001)(2906002)(8936002)(8676002)(82960400001)(66556008)(66946007)(66476007)(316002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DNdu24eXkXAl2f7++z1NpwsYymGmcItXftQrdUvn8sZCJeg93n7RwvszzrJp?=
 =?us-ascii?Q?Wmqto0IZzJ8wuVFE+Y3Rm2HOxtIC+ImjGcgH7cmzIRKe9ELuFyZ3fqEiT/H9?=
 =?us-ascii?Q?qBCt0lLJs4EykSwp1WG+5bkZZ0NGNjwWCw2oQjDZijHUbgPfV5fKD6ABUAdf?=
 =?us-ascii?Q?mysz3BtpcffkVQX/CYUzZYxeQZ+waohiERdsWNANMfish4ldIA08hJHUAQ52?=
 =?us-ascii?Q?PCtv0bmA/429Ga5kg2mHwNSVj0rKpeIURjA860ifbuqcI+xoWTK0+BEkWi/0?=
 =?us-ascii?Q?+6FctM9mI45mhVhtFvdtKz00DShNXJYHyVua0ngSBWkzQuUbRbvJ1sGqNDa7?=
 =?us-ascii?Q?uMfRbhg9njW9KK5ketBef3CNzxMdXbd7kUYVp2wmRnnN6LrfPUbUQDtGz5NA?=
 =?us-ascii?Q?MzsXkZDTxS0+UHSePpDduVXLyb+fFiFgWhph2VkuV4U+bELaAYe3qGyATsZI?=
 =?us-ascii?Q?AgQIII3mJGMzghm5lRfI9q4IB+ZCApLZs02/sRALrvqRJug78Ttqyu4c1/M7?=
 =?us-ascii?Q?Z0gwFOsgGcCvg0x+1Z8dmHHn+h15gYGzRCZbl9vuI5e0aSEvokOWdEmKEk2c?=
 =?us-ascii?Q?sFp00Lev3yM5KDp3jFmgXsbw/pDNTONKcdId24hO4irIV4FvEL+PvSMDvWCO?=
 =?us-ascii?Q?FB+0K1LcrgcOLjF/XQ9zxitbGWSBKqJc4IUNfR4usA84vnKZeY4o75tGQ+k1?=
 =?us-ascii?Q?pHWZba0wjdyI3gxzwJ3KyLxitH31RQvr+k77/T7Ct5dLUpvYe1uHA6p3hGU2?=
 =?us-ascii?Q?EW97Vnz+mhPXIAifmOS7YvUrWinR+/FPgnwFOc+hxCL1swalwDZe/MWl+uhI?=
 =?us-ascii?Q?LSBRfShB6kUUuOYMohStPxNz4dzEgL8WzjfVILAK8GYsaA2qi7ZZZhzzAYc2?=
 =?us-ascii?Q?fjL4kkqpKYGZ2iNDGz1rMol43BJ4RP+6QJsz65vZr1MlS+MGc+q0ImrHTLjq?=
 =?us-ascii?Q?PFxpQId1hacbXJRzES5KAIr2HfskpZ7/sASugUJISnxkym6ifTVvcBcQDAZx?=
 =?us-ascii?Q?FEofLhgPi1GR1kpF/Cv8feLlkJOj+bCbUevrymEW58+QCc8jLjtvgSmc/2S3?=
 =?us-ascii?Q?2jpkp223BdCvsV0uOpJN9atk5cRKuM/LJMudEqkfYM0altWHhlBY7y3hmvJ8?=
 =?us-ascii?Q?9aa4m6YTbbv1YFn8qtzoIIqQGayPnriEsoBUVMK0CrmMDj1dbIaWehyLWmeO?=
 =?us-ascii?Q?oSRmHllJpKQDYFLUt1AUgcK3gTT7ERQKGyuQKcPBASNYNLzsaOhSWsHYn1x5?=
 =?us-ascii?Q?liTWlodAbW52TUC4cEJjbKXFD/pWgqA2AT6OGrIoOZmFeJrnfIJgWv09k00X?=
 =?us-ascii?Q?WZiKmJizZJDIrN5ILT2E9BDtWWXXyUHLPq7GsD8fwufPng9ZktiaxT9LwcPO?=
 =?us-ascii?Q?auNDqu4m5ZckrvxdVD0zTmC/lDmxoTZV3SwYFRdo1P+7mz5yfrFgkOkS4OWp?=
 =?us-ascii?Q?W2JV/DWewgCfF4kPESKEEIDs99HTFFOEVVExJGJbwjkiCo22WAKxxVb8O8K2?=
 =?us-ascii?Q?GjGoHDswiLYSob0rEciHlT+n3Km3FEKaSx+b4khXCm/seEka3AMFkjxyuaKH?=
 =?us-ascii?Q?SHMg+4DB2aVHhwGw6mYyf9+TOSabH6DX0fMsxcJKQCg8kCu2CDJdFYfmtsV8?=
 =?us-ascii?Q?/w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f2b842a-2ff8-457d-3472-08db4515c04b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 22:46:32.8931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rr7Z4yCjg+kqJSMVa6NcQnp0yEVdr1vGbKxtRs6dx0lMfKzyKjzUgNezdMrsyh2qil7+if3SZjlkmesNaZZeSZdmMOhJ/JKbRdg79Z6jzls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4926
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dave Jiang wrote:
> Provide a callback to parse the Device Scoped Latency and Bandwidth
> Information Structure (DSLBIS) in the CDAT structures. The DSLBIS
> contains the bandwidth and latency information that's tied to a DSMAS
> handle. The driver will retrieve the read and write latency and
> bandwidth associated with the DSMAS which is tied to a DPA range.
> 
> Coherent Device Attribute Table 1.03 2.1 Device Scoped Latency and
> Bandwidth Information Structure (DSLBIS)
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> v3:
> - Added spec section in commit header. (Alison)
> - Remove void * recast. (Alison)
> - Rework comment. (Alison)
> - Move CDAT parse to cxl_endpoint_port_probe()
> - Convert to use 'struct node_hmem_attrs'
> 
> v2:
> - Add size check to DSLIBIS table. (Lukas)
> - Remove unnecessary entry type check. (Jonathan)
> - Move data_type check to after match. (Jonathan)
> - Skip unknown data type. (Jonathan)
> - Add overflow check for unit multiply. (Jonathan)
> - Use dev_warn() when entries parsing fail. (Jonathan)
> ---
>  drivers/cxl/core/cdat.c |   68 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlpci.h    |   34 +++++++++++++++++++++++-
>  drivers/cxl/port.c      |   11 +++++++-
>  3 files changed, 111 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 6f20af83a3ed..e8b9bb99dfdf 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright(c) 2023 Intel Corporation. All rights reserved. */
> +#include <linux/overflow.h>
>  #include "cxlpci.h"
>  #include "cxl.h"
>  
> @@ -124,3 +125,70 @@ int cxl_dsmas_parse_entry(struct cdat_entry_header *header, void *arg)
>  	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_dsmas_parse_entry, CXL);
> +
> +static void cxl_hmem_attrs_set(struct node_hmem_attrs *attrs,
> +			       int access, unsigned int val)
> +{
> +	switch (access) {
> +	case HMAT_SLLBIS_ACCESS_LATENCY:
> +		attrs->read_latency = val;
> +		attrs->write_latency = val;
> +		break;
> +	case HMAT_SLLBIS_READ_LATENCY:
> +		attrs->read_latency = val;
> +		break;
> +	case HMAT_SLLBIS_WRITE_LATENCY:
> +		attrs->write_latency = val;
> +		break;
> +	case HMAT_SLLBIS_ACCESS_BANDWIDTH:
> +		attrs->read_bandwidth = val;
> +		attrs->write_bandwidth = val;
> +		break;
> +	case HMAT_SLLBIS_READ_BANDWIDTH:
> +		attrs->read_bandwidth = val;
> +		break;
> +	case HMAT_SLLBIS_WRITE_BANDWIDTH:
> +		attrs->write_bandwidth = val;
> +		break;
> +	}
> +}
> +
> +int cxl_dslbis_parse_entry(struct cdat_entry_header *header, void *arg)
> +{
> +	struct cdat_dslbis *dslbis = (struct cdat_dslbis *)header;
> +	struct list_head *dsmas_list = arg;
> +	struct dsmas_entry *dent;
> +
> +	if (dslbis->hdr.length != sizeof(*dslbis)) {
> +		pr_warn("Malformed DSLBIS table length: (%lu:%u)\n",
> +			(unsigned long)sizeof(*dslbis), dslbis->hdr.length);
> +		return -EINVAL;
> +	}
> +
> +	/* Skip unrecognized data type */
> +	if (dslbis->data_type >= HMAT_SLLBIS_DATA_TYPE_MAX)
> +		return 0;
> +
> +	list_for_each_entry(dent, dsmas_list, list) {
> +		u64 val;
> +		int rc;
> +
> +		if (dslbis->handle != dent->handle)
> +			continue;

Oh, now I see why the list is needed. Update the changelog of the
previous patch to indicate that the entries are cached to a list so they
can be cross referenced during dslbis parsing. At least that would have
saved me from picking on it.


> +
> +		/* Not a memory type, skip */
> +		if ((dslbis->flags & DSLBIS_MEM_MASK) != DSLBIS_MEM_MEMORY)
> +			return 0;
> +
> +		rc = check_mul_overflow(le64_to_cpu(dslbis->entry_base_unit),
> +					le16_to_cpu(dslbis->entry[0]), &val);
> +		if (unlikely(rc))

Don't use likely() / unlikely() without performance numbers. The
compiler generally does a better job and this is not a hot path.
