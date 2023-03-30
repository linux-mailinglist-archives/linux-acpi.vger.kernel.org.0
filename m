Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A74C6D0A44
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Mar 2023 17:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbjC3PqA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 30 Mar 2023 11:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbjC3Pp7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Mar 2023 11:45:59 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E67E07C;
        Thu, 30 Mar 2023 08:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680191126; x=1711727126;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=RN1Cm2GCZcQoGRox1xfibo73ByCq1sHqhaRH51BCVwY=;
  b=gC1H+X9Q14u2d0b5psMgLKoMAkYsgD5qRJ3sLeexdqtYgSccbWVKF964
   RlJnP6LYmHTxgACHpEhUMbU11Yoga90PlTOYdia18K2Nb+EAdcRofytn2
   1WCW5CtPUIp0QsFnPDBB1YV53mpHUVqEFtjY+QxvkOcQfNaC1XdGlBUZA
   oJIU+VmtiabNHF8tB4+IkpRm6rpJ/AkTlXrSjthXEbkKsWg8INJeVjfxK
   GOz8k/j6Dxax1ToGiG1+l4OSz6gEV/hMaAqKNbmP88hT6jTu2Xs+kf/3Q
   imRUuoebJCnKnBTkdKtKUYo8TmrC5mYoZwIN+h7rjx9HHLnykB1wGnLow
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="427481263"
X-IronPort-AV: E=Sophos;i="5.98,305,1673942400"; 
   d="scan'208";a="427481263"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 08:43:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="795702613"
X-IronPort-AV: E=Sophos;i="5.98,305,1673942400"; 
   d="scan'208";a="795702613"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.117.86]) ([10.212.117.86])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 08:43:06 -0700
Message-ID: <ae2e391e-996b-a6c1-1a2b-1210cc7d1b14@intel.com>
Date:   Thu, 30 Mar 2023 08:43:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v2 05/21] cxl: Add callback to parse the DSMAS subtables
 from CDAT
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, lukas@wunner.de
References: <167995336797.2857312.539473939839316778.stgit@djiang5-mobl3>
 <167995347254.2857312.246180486952683569.stgit@djiang5-mobl3>
In-Reply-To: <167995347254.2857312.246180486952683569.stgit@djiang5-mobl3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 3/27/23 2:44 PM, Dave Jiang wrote:
> Provide a callback function to the CDAT parser in order to parse the Device
> Scoped Memory Affinity Structure (DSMAS). Each DSMAS structure contains the
> DPA range and its associated attributes in each entry. See the CDAT
> specification for details.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> v2:
> - Add DSMAS table size check. (Lukas)
> - Use local DSMAS header for LE handling.
> - Remove dsmas lock. (Jonathan)
> - Fix handle size (Jonathan)
> - Add LE to host conversion for DSMAS address and length.
> - Make dsmas_list local
> ---
>   drivers/cxl/core/cdat.c |   26 ++++++++++++++++++++++++++
>   drivers/cxl/cxl.h       |    1 +
>   drivers/cxl/cxlpci.h    |   18 ++++++++++++++++++
>   drivers/cxl/port.c      |   24 ++++++++++++++++++++++++
>   4 files changed, 69 insertions(+)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 210f4499bddb..d068609fb6f9 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -98,3 +98,29 @@ int cdat_table_parse_sslbis(struct cdat_header *table,
>   	return cdat_table_parse_entries(CDAT_TYPE_SSLBIS, table, &proc);
>   }
>   EXPORT_SYMBOL_NS_GPL(cdat_table_parse_sslbis, CXL);
> +
> +int cxl_dsmas_parse_entry(struct cdat_entry_header *header, void *arg)
> +{
> +	struct cdat_dsmas *dsmas = (struct cdat_dsmas *)(header);
> +	struct list_head *dsmas_list = (struct list_head *)arg;
> +	struct dsmas_entry *dent;
> +
> +	if (dsmas->hdr.length != sizeof(*dsmas)) {
> +		pr_warn("Malformed DSMAS table length: (%lu:%u)\n",
> +			 (unsigned long)sizeof(*dsmas), dsmas->hdr.length);
> +		return -EINVAL;
> +	}
> +
> +	dent = kzalloc(sizeof(*dent), GFP_KERNEL);
> +	if (!dent)
> +		return -ENOMEM;
> +
> +	dent->handle = dsmas->dsmad_handle;
> +	dent->dpa_range.start = le64_to_cpu(dsmas->dpa_base_address);
> +	dent->dpa_range.end = le64_to_cpu(dsmas->dpa_base_address) +
> +			      le64_to_cpu(dsmas->dpa_length) - 1;
> +	list_add_tail(&dent->list, dsmas_list);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_dsmas_parse_entry, CXL);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index cc3309794b45..9d0e22fe72c0 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -8,6 +8,7 @@
>   #include <linux/bitfield.h>
>   #include <linux/bitops.h>
>   #include <linux/log2.h>
> +#include <linux/list.h>
>   #include <linux/io.h>
>   
>   /**
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 45e2f2bf5ef8..9a2468a93d83 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -104,6 +104,22 @@ struct cdat_subtable_entry {
>   	enum cdat_type type;
>   };
>   
> +struct dsmas_entry {
> +	struct list_head list;
> +	struct range dpa_range;
> +	u8 handle;
> +};
> +
> +/* Sub-table 0: Device Scoped Memory Affinity Structure (DSMAS) */
> +struct cdat_dsmas {
> +	struct cdat_entry_header hdr;
> +	u8 dsmad_handle;
> +	u8 flags;
> +	__u16 reserved;
> +	__le64 dpa_base_address;
> +	__le64 dpa_length;
> +} __packed;
> +
>   int devm_cxl_port_enumerate_dports(struct cxl_port *port);
>   struct cxl_dev_state;
>   int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
> @@ -119,4 +135,6 @@ int cdat_table_parse_##x(struct cdat_header *table, \
>   cdat_table_parse(dsmas);
>   cdat_table_parse(dslbis);
>   cdat_table_parse(sslbis);
> +
> +int cxl_dsmas_parse_entry(struct cdat_entry_header *header, void *arg);
>   #endif /* __CXL_PCI_H__ */
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 60a865680e22..c8136797d528 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -57,6 +57,16 @@ static int discover_region(struct device *dev, void *root)
>   	return 0;
>   }
>   
> +static void dsmas_list_destroy(struct list_head *dsmas_list)
> +{
> +	struct dsmas_entry *dentry, *n;
> +
> +	list_for_each_entry_safe(dentry, n, dsmas_list, list) {
> +		list_del(&dentry->list);
> +		kfree(dentry);
> +	}
> +}
> +
>   static int cxl_switch_port_probe(struct cxl_port *port)
>   {
>   	struct cxl_hdm *cxlhdm;
> @@ -131,9 +141,23 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>   static int cxl_port_probe(struct device *dev)
>   {
>   	struct cxl_port *port = to_cxl_port(dev);
> +	int rc;
>   
>   	/* Cache the data early to ensure is_visible() works */
>   	read_cdat_data(port);
> +	if (port->cdat.table) {
> +		if (is_cxl_endpoint(port)) {
> +			LIST_HEAD(dsmas_list);
> +
> +			rc = cdat_table_parse_dsmas(port->cdat.table,
> +						    cxl_dsmas_parse_entry,
> +						    (void *)&dsmas_list);
> +			if (rc < 0)
> +				dev_warn(dev, "Failed to parse DSMAS: %d\n", rc);
> +
> +			dsmas_list_destroy(&dsmas_list);
> +		}
> +	}

This block needs to be moved to cxl_endpoint_port_probe() after media is 
ready.

>   
>   	if (is_cxl_endpoint(port))
>   		return cxl_endpoint_port_probe(port);
> 
> 
