Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8D66ED957
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Apr 2023 02:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjDYAae (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 Apr 2023 20:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjDYAab (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Apr 2023 20:30:31 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61015585;
        Mon, 24 Apr 2023 17:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682382630; x=1713918630;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jz4V53Z+YzrHqSMt5mgbVp55qDFXmvcykZ59CB3KQ3Q=;
  b=TByzuwETfI64ULTppltpH73wB7011Qas1Q/2C0T5CCFKAMpt/6lQSUnz
   ureivM8Td/X5g/pXf4y/RnZ9rqc7AGQ9qNJPhr5oGTYPaqGpJr/b5lfjb
   d+/pAlJ2GGt3Bv8jgNED8LuciW1Xf1ExCLNOTfRb8vZ9/oTkGFmUvjV96
   AeDMCJHiPzrRhxDgYDDkQByjN8h6s/z/18j7LTzr8qrd4V9zP5nAoUUAs
   h4cNStA/1MaRtw9oKVjnCik8XzsKEodreDdKzRTV/zl6LOcQ/WgKRH9H7
   rHdUrP/4NwsbZWpBD9sMxIfQLNn83DOtU8Mra45UBROR2LdLDvRgEGQyw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="326913957"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="326913957"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 17:30:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="723807102"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="723807102"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 24 Apr 2023 17:30:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 24 Apr 2023 17:30:29 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 24 Apr 2023 17:30:29 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 24 Apr 2023 17:30:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bEBBar10K+zmvuMNo3sb+nrNuaB51B/O13f+aC/9tosqF5MNhnEA/GozUYVESX6Fv3MUnIhavonnhXOa9ss7gADT+GpcIStIN+sqIX/kAmuSzScVBDWBK0SA5Sfc6ZgdMk/vPiDJwei7P+9FvIAxt9ITRQq+grYzV8Ekf7mWEjHIpwZfOQ4+2vwLMqoHlTQK5O3BniGWbAPq8kFf77mHCkd/ZPqUmo4gkadi2Qu0XZbq71Jnc1rETzFuzanvidqJvq/eCyx5tKul8jWzwI9ee3KbrAcMA8P5bpFL2DS8juqOGOe24tRm0jlVJj19ZVAMsVnITZ3jQo2xXPr6mcVU+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UprNzMX2l2zyXjijTGio9P/ThfBmAekE3Q0EGqnNRRg=;
 b=WHAi4Kk5m8DzHKlG5OAWDjlNgwwNwnpYrqG68N37huZJUObfg7erF3OHg2prrDKSgE/kRAZUhDnjMc9DjwvEGo7GYc25ctCMPhXkkG/8pFzEkF4PA3YnPhN8ZLQRC/D/L/kLhzM11H01SvZr11AnWZD3pG+TU6sc4cf4NdtFWcFKbzeVFUJVzXE9/RunIxo3imW42JrviM3pcH0G1cdMm4oXJBckCl/4aVuoiCxr6XwphrG14hPKGiHGx8ds5IaBK2JMeorLFVuAKUp/PGQgt/RhzJBR1hafTbH8xahFncuTjUiwJIKy5n8Wi27sf6KHEXLVIbFrdqUOcKucIN0eOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 00:30:26 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%3]) with mapi id 15.20.6319.032; Tue, 25 Apr 2023
 00:30:26 +0000
Date:   Mon, 24 Apr 2023 17:30:24 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>
CC:     <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <rafael@kernel.org>, <lukas@wunner.de>,
        <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH v4 10/23] cxl: Add helpers to calculate pci latency for
 the CXL device
Message-ID: <64471f202f6dd_1b6629492@dwillia2-xfh.jf.intel.com.notmuch>
References: <168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3>
 <168193572162.1178687.9726045601551945413.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <168193572162.1178687.9726045601551945413.stgit@djiang5-mobl3>
X-ClientProxiedBy: SJ0PR13CA0188.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB5776:EE_
X-MS-Office365-Filtering-Correlation-Id: 7821e66c-3546-4b6e-a9e2-08db452443ef
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E7i3fdsDpG/DI+aBfusOzLafPXBlebFSwdwdAvBJaqyRj0IFWJmvCzVufG0ailzV5yIlUDDLPJx3TL1BYAfNJ2NlDMIp1iciRsCzGhPuIGrSKbEqzWwYY4GfRo1wpPQzCIIrlVDQs4dFvIQq18b7Nw1z6Ix9aImf4040lkkYWySoeZoE/i7SMGXJmvI2q0qdEAu9hbwfnYkjIf8ePrCG4/v6nNmuROAstYHx5N1RbQMYbOUhQ43bmXpsvxyfVagSZIwGCoNHdoyAQIKpC9l+TCvAeiMkXNMUGfTUXaTB17FxFTsMOA/lTKKKTkYFLXokr50EZXGFhnrYrhHSdlB/m8XRAlc6qRBLoI+0CoeLRXdgIDKF9O7ejXEKzGfriCGs6Sq4X7/AIhtmjUAUF5MD7AMhDJAVfBMPc1jhoL22tvRfaxcLytYoc2abkDoU7DjB9/Oi58fPBtmiZKxv95VveBzK42V6VCJ0B/8UKq1XfM88YOSQjEKpov3Eyc1ju/ynaaT339OrzwylA29Qu6UJF3sheqclht3AHqbmegd/wKJROqQk3eN8BNisw0xV3Pge
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199021)(478600001)(82960400001)(316002)(66946007)(66476007)(66556008)(4326008)(41300700001)(2906002)(8936002)(8676002)(5660300002)(38100700002)(186003)(86362001)(26005)(6512007)(9686003)(6506007)(6486002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?71NQYfuSd2UuTXys0x0vNoGrfc4XseKoYElC4py+86GLVLJBzXiXbOXfFITz?=
 =?us-ascii?Q?6rETL5uMprT7WuOZ//BkC3TOB8FxdtsEkJoSoJs5FNQW+Cyir3bA0TE8E8Ac?=
 =?us-ascii?Q?BkvwhtB5FgHOr1r3f6xbRRwbNBMJz5m7KttZx/dkFS15AkUC0PAGV/C4Fq+D?=
 =?us-ascii?Q?Gh84d42tH5G7+PBaLwvuKMgFIEklapNS7OBU2QyAP9ijwQqCv5iB1le41PIG?=
 =?us-ascii?Q?HrpnkJtZPY6IPKrd+jfq+8EyigXwqiunBgDGhcTfziP0hWTH1vZ6a1sYvaHc?=
 =?us-ascii?Q?rLAYO//3sPSFK0NdTloWIGTpFzcr6LmJKsRq13KsYPWiwHUV3Va6lJBvjL+B?=
 =?us-ascii?Q?VUY9vJaS3G3smRyy/UXJX+5Q7W8bWIgxM84ryyXH8FffpmorXaqZzqYvZq8S?=
 =?us-ascii?Q?VL+teQ6gcpzgchOWyjWv1WPbuWVl3u6SnnDvyk3Y4BNw67JPiTitp9MUSYDO?=
 =?us-ascii?Q?jRPPGKs+wMc2umh6qy/aEVhlPSVIfxaJifHWLvRC7vSQTBaA/KK6PMbnbyiy?=
 =?us-ascii?Q?buANVrJn0xb81p8moy4MyL/HiuLQiRrfdVxoNfLt2Lrt8nUnoI82wbMOyHH/?=
 =?us-ascii?Q?H1j9SC7MvDYVbwDHzZcocDm9GElho+4i6aEnjIUzBTY74yuh849BMJaAAZH5?=
 =?us-ascii?Q?VhgectgpS/aNzdRD4daZGSHKW2BVvV0d1UM0DeUq0TyM5y5qnbtav0/cE7Se?=
 =?us-ascii?Q?Tqtmmb2kyx9fmyYpCWgCQDKLUYhqhR8H3+o9r0mwYegwhWHb+QFRDi6hXOdV?=
 =?us-ascii?Q?eYXNMEf7VJj5MApmT/zu4bCtyzvHabRsD0tu/4gsjDxIXJ0FPTtRgSrLilx1?=
 =?us-ascii?Q?Tr36HgfitxyowT/d8Vl1zlsBUOt59CDnmFFzhs4JfbQiAfMc7cJSavLC+QYg?=
 =?us-ascii?Q?v+5+UZANSldsp5ZfCsmRllWUYir+dbsPTgr+E/FcDkpBATuKrByb+fGnfkth?=
 =?us-ascii?Q?sZfi3kqY0kDDypEmmzmNyc0yOHbSyN2jl02uID6A07lAXAyF1XGWYcYro9ji?=
 =?us-ascii?Q?oZG1gSbHHTqTrist4PcEfqZbQC3j+3Ewh9StSb+Z7x/JKRry2WQAhLNaVqwo?=
 =?us-ascii?Q?fLVoJ2QR7TMB9O9pImS/L2jlM6rS7NUh5X0oaI6gb0HHc1uDbjEi2OMZzdH7?=
 =?us-ascii?Q?xAL3BrEcPyD+fQ/3bmh9JCQxYZI7KJb4AJ/xe7stad8D69FasTtuaAn/4ptO?=
 =?us-ascii?Q?573XBFnuPab4C6bXsB0Et+NZOfDOYSY0XYESL7JB+2EvcI2TELbFAoGDmM0L?=
 =?us-ascii?Q?jaSMvzXJ/NOQyeegqgcUnY0yBt+2KoNK8tkCY2daa4B+kLw/okmq6KN6EQpd?=
 =?us-ascii?Q?1vYUvKhHZEy/ttkTxeTmPHHXTDQ8Ql/BrZY9HwyjidRVWhKjYwDxTFEYQPyJ?=
 =?us-ascii?Q?B7l+SdEMiL8tMyMynjnZlpttx1lncT6pOfj62TcN9l0E8uGCTgTEsUJULNCY?=
 =?us-ascii?Q?dbisB9DEhFq4Q3/a+7EZRhcGFKUBbzEZo1zVvwGIvI5hFvMRbZSNQxI95/wP?=
 =?us-ascii?Q?qAYODHYZD2lVdkaz0vehzqeDyj65tsjgcE3/bHbH3xARtvuaZ3lVumv0Yq4J?=
 =?us-ascii?Q?JUBrldM0szEt3u0anZmTwIU2DBpG8VCOthLZGJbpPLboU3ZBc5wAWAv88uPs?=
 =?us-ascii?Q?1g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7821e66c-3546-4b6e-a9e2-08db452443ef
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 00:30:26.6477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0jwYOX1ZUOMTlP3EIO34OqSnKaF1lPJwWLvR9Cs4be/NUN7cxVzbEEGZrfsQ3opEGZHiBXq+QcMVul9FPzIBaPtfdvxxZ3NOx4ZeeI/c1Xc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5776
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dave Jiang wrote:
> The latency is calculated by dividing the flit size over the bandwidth. Add
> support to retrieve the flit size for the CXL device and calculate the
> latency of the downstream link.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> v2:
> - Fix commit log issues. (Jonathan)
> - Fix var declaration issues. (Jonathan)
> ---
>  drivers/cxl/core/pci.c |   68 ++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlpci.h   |   15 +++++++++++
>  drivers/cxl/pci.c      |   13 ---------
>  3 files changed, 83 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 1c415b26e866..bb58296b3e56 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -712,3 +712,71 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  	return PCI_ERS_RESULT_NEED_RESET;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_error_detected, CXL);
> +
> +static int pci_bus_speed_to_mbps(enum pci_bus_speed speed)
> +{
> +	switch (speed) {
> +	case PCIE_SPEED_2_5GT:
> +		return 2500;
> +	case PCIE_SPEED_5_0GT:
> +		return 5000;
> +	case PCIE_SPEED_8_0GT:
> +		return 8000;
> +	case PCIE_SPEED_16_0GT:
> +		return 16000;
> +	case PCIE_SPEED_32_0GT:
> +		return 32000;
> +	case PCIE_SPEED_64_0GT:
> +		return 64000;
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int cxl_pci_mbits_to_mbytes(struct pci_dev *pdev)
> +{
> +	int mbits;
> +
> +	mbits = pci_bus_speed_to_mbps(pdev->bus->cur_bus_speed);
> +	if (mbits < 0)
> +		return mbits;
> +
> +	return mbits >> 3;

Why not just return mbits directly and skip the conversion? Otherwise a
"/ 8" requires bit less cleverness to read than ">> 3".

> +}
> +
> +static int cxl_flit_size(struct pci_dev *pdev)

This like something that might be worth caching in 'struct cxl_port'
rather than re-reading the configuration register each call. Depends on
how often it is used.

> +{
> +	if (cxl_pci_flit_256(pdev))
> +		return 256;
> +
> +	return 68;
> +}
> +
> +/**
> + * cxl_pci_get_latency - calculate the link latency for the PCIe link
> + * @pdev - PCI device
> + *
> + * return: calculated latency or -errno
> + *
> + * CXL Memory Device SW Guide v1.0 2.11.4 Link latency calculation
> + * Link latency = LinkPropagationLatency + FlitLatency + RetimerLatency
> + * LinkProgationLatency is negligible, so 0 will be used
> + * RetimerLatency is assumed to be negligible and 0 will be used
> + * FlitLatency = FlitSize / LinkBandwidth
> + * FlitSize is defined by spec. CXL rev3.0 4.2.1.
> + * 68B flit is used up to 32GT/s. >32GT/s, 256B flit size is used.
> + * The FlitLatency is converted to picoseconds.
> + */
> +long cxl_pci_get_latency(struct pci_dev *pdev)
> +{
> +	long bw;
> +
> +	bw = cxl_pci_mbits_to_mbytes(pdev);

This function looks misnamed when I read it here, it's retrieving the
bus speed in MiBs not doing a conversion.

> +	if (bw < 0)
> +		return bw;
> +
> +	return cxl_flit_size(pdev) * 1000000L / bw;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_pci_get_latency, CXL);
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 1bca1c0e4b40..795eba31fe29 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -167,6 +167,19 @@ struct cdat_sslbis {
>  #define SSLBIS_US_PORT		0x0100
>  #define SSLBIS_ANY_PORT		0xffff
>  
> +/*
> + * CXL v3.0 6.2.3 Table 6-4
> + * The table indicates that if PCIe Flit Mode is set, then CXL is in 256B flits
> + * mode, otherwise it's 68B flits mode.
> + */
> +static inline bool cxl_pci_flit_256(struct pci_dev *pdev)
> +{
> +	u16 lnksta2;
> +
> +	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA2, &lnksta2);
> +	return lnksta2 & PCI_EXP_LNKSTA2_FLIT;
> +}
> +
>  int devm_cxl_port_enumerate_dports(struct cxl_port *port);
>  struct cxl_dev_state;
>  int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
> @@ -189,4 +202,6 @@ int cxl_##x##_parse_entry(struct cdat_entry_header *header, void *arg)
>  cxl_parse_entry(dsmas);
>  cxl_parse_entry(dslbis);
>  cxl_parse_entry(sslbis);
> +
> +long cxl_pci_get_latency(struct pci_dev *pdev);
>  #endif /* __CXL_PCI_H__ */
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index ea38bd49b0cf..ed39d133b70d 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -365,19 +365,6 @@ static bool is_cxl_restricted(struct pci_dev *pdev)
>  	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
>  }
>  
> -/*
> - * CXL v3.0 6.2.3 Table 6-4
> - * The table indicates that if PCIe Flit Mode is set, then CXL is in 256B flits
> - * mode, otherwise it's 68B flits mode.
> - */
> -static bool cxl_pci_flit_256(struct pci_dev *pdev)
> -{
> -	u16 lnksta2;
> -
> -	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA2, &lnksta2);
> -	return lnksta2 & PCI_EXP_LNKSTA2_FLIT;
> -}
> -
>  static int cxl_pci_ras_unmask(struct pci_dev *pdev)
>  {
>  	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
> 
> 


