Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C18D6CCEA7
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Mar 2023 02:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjC2AVE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Mar 2023 20:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjC2AVD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Mar 2023 20:21:03 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC7219A4;
        Tue, 28 Mar 2023 17:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680049262; x=1711585262;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NBYUE4CZmdFva2SO9TXKIepYL41Hbi9OVqE1wFD9pAk=;
  b=gOzsbOeyNipHTZSkLUQbhBpbVshwyaq4jShvSXNJm9WykZcdAEHR6Q74
   lD+jtJz20O6JTdc1MDEQidnfwfAo1ys0WnnioKncAobicPG/Qhph3EBz6
   f5RyxWnd4swGyY03ab3SZmxFTIXVnA0JiRXqHqYcaKfv9gJrqPAo36zd+
   npXYKWYRVvBE0zIHiZVnnyo36HweOK/CQRJPGDWVYdqdNWnald/1beWpM
   36tOV/tv0QHC714p/YlTrjMNb9vrLXQITmHyKj0m4MBR/Fg9gNgYpMLqX
   bSuq8gFRRNfC/6aPCzCCIGXA7xdm+vFzqMJRV+beM2zQCUsO36MxslKIK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="368500996"
X-IronPort-AV: E=Sophos;i="5.98,299,1673942400"; 
   d="scan'208";a="368500996"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 17:21:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="807999772"
X-IronPort-AV: E=Sophos;i="5.98,299,1673942400"; 
   d="scan'208";a="807999772"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.62.61])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 17:21:01 -0700
Date:   Tue, 28 Mar 2023 17:20:59 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, rafael@kernel.org, lukas@wunner.de
Subject: Re: [PATCH v2 05/21] cxl: Add callback to parse the DSMAS subtables
 from CDAT
Message-ID: <ZCOEa0Y7OFU4afxK@aschofie-mobl2>
References: <167995336797.2857312.539473939839316778.stgit@djiang5-mobl3>
 <167995347254.2857312.246180486952683569.stgit@djiang5-mobl3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167995347254.2857312.246180486952683569.stgit@djiang5-mobl3>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Mar 27, 2023 at 02:44:32PM -0700, Dave Jiang wrote:
> Provide a callback function to the CDAT parser in order to parse the Device
> Scoped Memory Affinity Structure (DSMAS). Each DSMAS structure contains the
> DPA range and its associated attributes in each entry. See the CDAT
> specification for details.

Are we going away from offering spec section numbers or links?

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
>  drivers/cxl/core/cdat.c |   26 ++++++++++++++++++++++++++
>  drivers/cxl/cxl.h       |    1 +
>  drivers/cxl/cxlpci.h    |   18 ++++++++++++++++++
>  drivers/cxl/port.c      |   24 ++++++++++++++++++++++++
>  4 files changed, 69 insertions(+)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 210f4499bddb..d068609fb6f9 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -98,3 +98,29 @@ int cdat_table_parse_sslbis(struct cdat_header *table,
>  	return cdat_table_parse_entries(CDAT_TYPE_SSLBIS, table, &proc);
>  }
>  EXPORT_SYMBOL_NS_GPL(cdat_table_parse_sslbis, CXL);
> +
> +int cxl_dsmas_parse_entry(struct cdat_entry_header *header, void *arg)
> +{
> +	struct cdat_dsmas *dsmas = (struct cdat_dsmas *)(header);
> +	struct list_head *dsmas_list = (struct list_head *)arg;

cast from void unnecessary ?

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
>  #include <linux/bitfield.h>
>  #include <linux/bitops.h>
>  #include <linux/log2.h>
> +#include <linux/list.h>
>  #include <linux/io.h>
>  
>  /**
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 45e2f2bf5ef8..9a2468a93d83 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -104,6 +104,22 @@ struct cdat_subtable_entry {
>  	enum cdat_type type;
>  };
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
>  int devm_cxl_port_enumerate_dports(struct cxl_port *port);
>  struct cxl_dev_state;
>  int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
> @@ -119,4 +135,6 @@ int cdat_table_parse_##x(struct cdat_header *table, \
>  cdat_table_parse(dsmas);
>  cdat_table_parse(dslbis);
>  cdat_table_parse(sslbis);
> +
> +int cxl_dsmas_parse_entry(struct cdat_entry_header *header, void *arg);
>  #endif /* __CXL_PCI_H__ */
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 60a865680e22..c8136797d528 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -57,6 +57,16 @@ static int discover_region(struct device *dev, void *root)
>  	return 0;
>  }
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
>  static int cxl_switch_port_probe(struct cxl_port *port)
>  {
>  	struct cxl_hdm *cxlhdm;
> @@ -131,9 +141,23 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  static int cxl_port_probe(struct device *dev)
>  {
>  	struct cxl_port *port = to_cxl_port(dev);
> +	int rc;
>  
>  	/* Cache the data early to ensure is_visible() works */
>  	read_cdat_data(port);
> +	if (port->cdat.table) {
> +		if (is_cxl_endpoint(port)) {

How about reducing indentation w:
	if ((port->cdat.table) && (is_cxl_endpoint(port))

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
>  
>  	if (is_cxl_endpoint(port))
>  		return cxl_endpoint_port_probe(port);
> 
> 
