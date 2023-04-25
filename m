Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35136ED961
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Apr 2023 02:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjDYAp7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 Apr 2023 20:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjDYAp6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Apr 2023 20:45:58 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E338493E6;
        Mon, 24 Apr 2023 17:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682383556; x=1713919556;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5IWkHAWKHdVwK4hf1Eta/MKesa8EIhPooaKEYBsjxEU=;
  b=meTeFFAZjovCruPfeDLcOGq0/pw8AxljZ0u/29x0XBtHPSSUqIwV4fxV
   VXlESAGgu5plg+hrHWapIScRMN5CNAFgb+HdwdgOH4+uvcMIvhNZkYrNB
   au5Qv84ha38QnWa+dtBCK87u2tM1ABPJvbv4zbALC0ObXGFrSsXV6x4Dm
   gC7xgVjNxpcla8REVz2vwxtbdci77+M4sMvu/5uTNgPHjPfRy679vvm+B
   RVfyJsF3cupZvUCLdFbTNtJp7QBd9qhlnUCczghSphaPF7d/Q3G3otl2/
   Xp3QUGZMD5k6xqjsZ5Xjy4bA/57utcFnazTeFWNvHSuXvxR74pPSLfDk1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="345361510"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="345361510"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 17:45:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="782625368"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="782625368"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Apr 2023 17:45:56 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 24 Apr 2023 17:45:56 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 24 Apr 2023 17:45:56 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 24 Apr 2023 17:45:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/UW1WMZNnb1l/2CSwWY/za2aWNugK/GaQnrD4Sh80+aUHezQnm1rTdC7H7qohKckv2tmsj0WWgqXEd4zvd+VhfqWTIF9kAJRxw1OZyFz+QLMBmdknH5q2BffOOcLY97xzVz6G6SFeFM9qegKMlWNb1B2zQZPwRoTpSCVRkmbvdjO4eUmValuwwEy4fd6o4TIyaZPG8KIzn1tt0uvbyIsSGnvi0a9nIJoSlrOcBoxS51ej50GMUNspdRkhMJvJ8RIOhzZMg+ILy8yxy9/F9aAPENVRC9PDUEpNiJO/GQC7vs3RtWjNmxlWTTI4xRZqdzpimGBo11DR6TXltCUZ4rtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jG03gMDK4sNMgkuTgJVndKCL3j20SNATN6mQ0Y97JxE=;
 b=epKQqSZQSClhDoikt7fctlDd67fNvGF1ABXFO0aztDpa0wIDnWSL8eQKkCAXBE4iwnKMeB9ENMnTjeNbUo+26AZrqWRxSMXnZwqupE84mzPxQ+TwdYZO3JRrdR83QmV7DMCYEkTkrCx+CBKVKPHr17/qY1MSwnBlgO69Wv5wyYdD1y4XzX62xJUoPM+fhXsuSUX3JW7yJG4506KAPkRLnn7TgdPdLS27DBbzhmbAo7Sa4iz5FcqL8iiNBEd9IuvJtJgDIa3ezbewEtT/gwAhHaGYHKeAEz1PhOi5OWVPeVLW4LNTXyYCGitiWo/I5AgelibSMsB3WMvWukuuTEfMjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5168.namprd11.prod.outlook.com (2603:10b6:a03:2dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.32; Tue, 25 Apr
 2023 00:45:54 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%3]) with mapi id 15.20.6319.032; Tue, 25 Apr 2023
 00:45:53 +0000
Date:   Mon, 24 Apr 2023 17:45:50 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>
CC:     <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <rafael@kernel.org>, <lukas@wunner.de>,
        <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH v4 12/23] cxl: Add helper function that calculate QoS
 values for PCI path
Message-ID: <644722be7fce3_1b662947d@dwillia2-xfh.jf.intel.com.notmuch>
References: <168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3>
 <168193573330.1178687.2727689734216767954.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <168193573330.1178687.2727689734216767954.stgit@djiang5-mobl3>
X-ClientProxiedBy: MW4PR03CA0114.namprd03.prod.outlook.com
 (2603:10b6:303:b7::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5168:EE_
X-MS-Office365-Filtering-Correlation-Id: 56c26b08-3cb5-4780-22e8-08db45266c63
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AbDoIcutXhor+8OQEtX7N9nj+xrHqvDLQhgSNRfXWIMBJ0BFgR5cpGFfjuq/j38VfgE4R1qd6XsexK91d/WtF8fasDnplnxQBH7XujAqHhOsjsVFefHHIRpdR91gMMc6R+gdLnWeKebSfG2o8Xj8tCR2HuW1Uvmafu+IrX38Vd319R5zxz0QIDGz05XtzUXrTtI4CoANYcWhV1mgPDIU9LZnNK105XiIubI2OYUBWqOf2jaHE0IOVU3ZG2meRKra3B+Ieo9DeSltjULjpMnQqqJ7Hx8jB/04l0sX0sVXmPZP6+3/5XlqjZg81Scg1PEy6r6D1p5+oUem0LxPiIklKUoX5TYOG4W8PirkWL05aKQfeeE0OM+cfOKf9XYeXJmAA4axlUOKZRhvHOXOlx4xsJ0kD+pUiDjaH6SBDbIEoCgwSQ9J09qg+wzNNTbr8zmz1rD9E50eQnFnB51VsyM2BX6eVlQi5acTvrrvYrm7LaaRlTFAHj3FZJbhhacYXKISXOYOOHcplt38pvuTQ+O8p3VcpFGLsAnXbprCRQF8Q1SiTkwJCkDySshLHWoRU1tc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199021)(9686003)(6506007)(26005)(6512007)(83380400001)(186003)(82960400001)(38100700002)(66946007)(478600001)(86362001)(66556008)(66476007)(8676002)(8936002)(5660300002)(6486002)(41300700001)(2906002)(4326008)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2ILmLXC5S6tPMIWAMYc+fHONdrXN80dMlATfgHbFkNZ30YfUUMQsmjPX0k3w?=
 =?us-ascii?Q?0bto1+unehNhxbB69bb598dI0SouRvybqTbwJwy8RA2eektrXxZbX3NvGhJB?=
 =?us-ascii?Q?qBGG0ZaVPYNg+JsIbURht7v2Ke7XAFisnULjpaOnshBfwpb6T6xjtq7d7GbD?=
 =?us-ascii?Q?rtp/xw9QZC96iDwodI0DuCM+9/DQsL77PoUo4HjJrGhAP421efUHyY9xVWQb?=
 =?us-ascii?Q?iapr/VeQ+sIvXWw6ImCc+iGI55QVLDsb8OmFLnx59H2IXo9djWG0DuR01G/3?=
 =?us-ascii?Q?CObmzLMm0+oLVKWDRYqugCTIRRmfh7569j8gE2htG/cd/9FuntDFan1ZXBmk?=
 =?us-ascii?Q?1kQnq8dU3Djl2eFpPvHiE7K1wj3GrSfhU9M3bStqLErmLjTS5/+hsScUqEMv?=
 =?us-ascii?Q?PZIixFSLqZUvU2M6TyJqKZatYiLTLQzszEZxu++wZkERXWgaTO4DsNITehDI?=
 =?us-ascii?Q?6Ac5HMgs42gF5jP5fT8wgrYC8riZdq4EoiU0TIW0l1J/+0UVgyGYF67TPs9z?=
 =?us-ascii?Q?lim9KSnfYORcctme6yLSshWAwwkQwI1lLMPKqF+vwO6WWuH2MmLtmqOCoTCg?=
 =?us-ascii?Q?g167J5sbsQRqiG1EhX+LInrNUN1g2KFMRzIFnDa8A4Awdh9uIpHOtaK94FjH?=
 =?us-ascii?Q?9xM7fZZoXx5Y0l2mxNm4O6g+DQUtxzPxiAblBRBFQS7kAFsltC72KwHU7Kak?=
 =?us-ascii?Q?KHmdxQY1OfEb43IqANuOv52fHjYB585CmROpuwlvdY3oRYOQbK44yn7n7fyP?=
 =?us-ascii?Q?0B3MIFziHyQvT1kmnqn1BImwFuhJNF9tNLlMamG9sqTBkL2lKuzvMleTmH+A?=
 =?us-ascii?Q?KRUVneMtvpF/ixOTn1gG+PYWXXbqn4ckVfdiLcuoISyOsmqpfALR0QE1Gy12?=
 =?us-ascii?Q?U8d/UzD+FMDOKO1AcVJeknCx3KlRGYRpf0v6piEpMkUGC3gupIXjYm1VAlc/?=
 =?us-ascii?Q?Bq0SmpA0lQkcIFWgMgwV0WrWB+sRU4EjP7ug4pvBG9ZF2eeT+qJ5sYHEiGro?=
 =?us-ascii?Q?Minx5jp6KRw5iMk6jp65AV0qZYac6dfBbTY6nGGhs6lonWqqyMc5jOsugLEj?=
 =?us-ascii?Q?Stj2wa/k4CI/AcGz4acC8rGqzA5XhTtKQeZRoVxxuj+llmpbt1ri6XUbWeDH?=
 =?us-ascii?Q?L5I/oxiaX35/Hqg27H+JXXRFaRIU+DGq31YpGLz9NGFKYT/gTc389+82VvFy?=
 =?us-ascii?Q?O505IgQ8vMZIl/MMDZVAnvDqSPA+mWthCploqJ/dT838bVcEUnFYJUE9zadR?=
 =?us-ascii?Q?l2JxX38RJC/RE2wC4eescGAWo9DwzNFrAp7QDIAfb1ceGEbeQiqQ7+f/xZHl?=
 =?us-ascii?Q?tRpLyfHu+jxHTFO4L/bgKanxRf5I4XfUj77h4agPyh9LiCKBUYXpP3dI78Gq?=
 =?us-ascii?Q?YuVMVhHz6ElGMVf6slwNlUuxe+MAUmfVcR+We7m+cFAnvJaeLdZzBGBo8R+q?=
 =?us-ascii?Q?rK8mOaa09/9pYKs/suKbaDo1rGdk+Mmb047pF70e8KKnSSer8JuKM3CTfZHZ?=
 =?us-ascii?Q?c6X+gyCy+SNq27BdPDVaDN2d210hP68YxSDcX8cS4T+bcs0ZjsrKhkvXIQDY?=
 =?us-ascii?Q?cn4ATPotlR+/JHYswSy+QqP65rbjAMzkgwG2BOaqMwgnsJkvHAJTRV9pteDD?=
 =?us-ascii?Q?XA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c26b08-3cb5-4780-22e8-08db45266c63
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 00:45:53.5888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qXDmirLrd5F4yNOaKFYQu5sNNCEQosWCEhQGWxXvshoiC14rbhyMQ12TCEzas/lFDS7c+MKJZ/WZt48CUaCG0CSMDO62r9nYQuoKKBLiPdQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5168
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
> Calculate the link bandwidth and latency for the PCIe path from the device
> to the CXL Host Bridge. This does not include the CDAT data from the device
> or the switch(es) in the path.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v4:
> - 0-day fix, remove unused var. Fix checking < 0 for unsigned var.
> - Rework port hierachy walk to calculate the latencies correctly
> ---
>  drivers/cxl/core/port.c |   83 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h       |    2 +
>  2 files changed, 85 insertions(+)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 770b540d5325..8da437e038b9 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -2002,6 +2002,89 @@ int cxl_port_get_switch_qos(struct cxl_port *port, u64 *rd_bw, u64 *rd_lat,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_port_get_switch_qos, CXL);
>  
> +/**
> + * cxl_port_get_downstream_qos - retrieve QoS data for PCIE downstream path
> + * @port: endpoint cxl_port
> + * @bandwidth: writeback value for min bandwidth
> + * @latency: writeback value for total latency
> + *
> + * Return: Errno on failure, 0 on success.
> + */
> +int cxl_port_get_downstream_qos(struct cxl_port *port, u64 *bandwidth,
> +				u64 *latency)
> +{
> +	u64 min_bw = ULONG_MAX;
> +	struct pci_dev *pdev;
> +	struct cxl_port *p;
> +	struct device *dev;
> +	u64 total_lat = 0;
> +	long lat;
> +
> +	*bandwidth = 0;
> +	*latency = 0;
> +
> +	/* Grab the device that is the PCI device for CXL memdev */
> +	dev = port->uport->parent;

The prototype for this function makes it seem like it can apply to
either switch downstream ports or endpoint ports. Given that this is
retrieving link speed can it not just retrieve the speed from the switch
downstream port status rather than the endpoint status?

> +	/* Skip if it's not PCI, most likely a cxl_test device */
> +	if (!dev_is_pci(dev))
> +		return 0;
> +
> +	pdev = to_pci_dev(dev);
> +	min_bw = pcie_bandwidth_available(pdev, NULL, NULL, NULL);
> +	if (min_bw == 0)
> +		return -ENXIO;
> +
> +	/* convert to MB/s from Mb/s */
> +	min_bw >>= 3;
> +
> +	/*
> +	 * Walk the cxl_port hierachy to retrieve the link latencies for
> +	 * each of the PCIe segments. The loop will obtain the link latency
> +	 * via each of the switch downstream port.
> +	 */

If performance data is cached in 'struct cxl_dport' at init then the PCI
device topology need not be walked later. All of the dev_is_pci() calls
can be removed from cxl_port_get_downstream_qos().

> +	p = port;
> +	do {
> +		struct cxl_dport *dport = p->parent_dport;
> +		struct device *dport_dev, *uport_dev;
> +		struct pci_dev *dport_pdev;
> +
> +		if (!dport)
> +			break;
> +
> +		dport_dev = dport->dport;
> +		if (!dev_is_pci(dport_dev))
> +			break;
> +
> +		p = dport->port;
> +		uport_dev = p->uport;
> +		if (!dev_is_pci(uport_dev))
> +			break;
> +
> +		dport_pdev = to_pci_dev(dport_dev);
> +		pdev = to_pci_dev(uport_dev);
> +		lat = cxl_pci_get_latency(dport_pdev);
> +		if (lat < 0)
> +			return lat;
> +
> +		total_lat += lat;
> +	} while (1);
> +
> +	/*
> +	 * pdev would be either the cxl device if there are no switches, or the
> +	 * upstream port of the last switch.
> +	 */
> +	lat = cxl_pci_get_latency(pdev);
> +	if (lat < 0)
> +		return lat;
> +
> +	total_lat += lat;
> +	*bandwidth = min_bw;
> +	*latency = total_lat;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_port_get_downstream_qos, CXL);
> +
>  /* for user tooling to ensure port disable work has completed */
>  static ssize_t flush_store(struct bus_type *bus, const char *buf, size_t count)
>  {
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 76ccc815134f..6a6387a545db 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -811,6 +811,8 @@ struct qtg_dsm_output *cxl_acpi_evaluate_qtg_dsm(acpi_handle handle,
>  acpi_handle cxl_acpi_get_rootdev_handle(struct device *dev);
>  int cxl_port_get_switch_qos(struct cxl_port *port, u64 *rd_bw, u64 *rd_lat,
>  			    u64 *wr_bw, u64 *wr_lat);
> +int cxl_port_get_downstream_qos(struct cxl_port *port, u64 *bandwidth,
> +				u64 *latency);
>  
>  /*
>   * Unit test builds overrides this to __weak, find the 'strong' version
> 
> 


