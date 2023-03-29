Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513006CCE75
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Mar 2023 02:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjC2ADJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Mar 2023 20:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjC2ADI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Mar 2023 20:03:08 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAA41B5;
        Tue, 28 Mar 2023 17:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680048187; x=1711584187;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u9tjAHk2BuHxmeOup3K9tkBHA+3dtAQ/YC0iJe8ULYQ=;
  b=jXum6ue3kSzct2La5Jt2lgzkcE8ZDktHkNTR8qNB3dcWKIffAm5duBuE
   POZUQ9+v0p1s9AllEuIPIXzs8PMzvLW/m5AR7sTSY7PtAvslnAc4KQLkv
   qHJirUVcK49ebohiCKeLshebOrPrr/IN39ddXhMBzCT6KEiR7Yp8W14rO
   HkluFpCScnSBlGg0cbgwA+8SB//XOGeIHazigSk7Wn7Zu6SvJZ4YZt2VZ
   J88duqScXqT9YOSEMhhmBxHlQ/CMfQ8+SrtlGtIqz5mHLvjrIwEXQauFD
   BcLszDKM6p8UYx5u0PAw5KD+HxbbWY8A+6vULf/+4dso/1BWflAfaMwbU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="427005291"
X-IronPort-AV: E=Sophos;i="5.98,299,1673942400"; 
   d="scan'208";a="427005291"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 17:03:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="753364452"
X-IronPort-AV: E=Sophos;i="5.98,299,1673942400"; 
   d="scan'208";a="753364452"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.62.61])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 17:03:04 -0700
Date:   Tue, 28 Mar 2023 17:03:02 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, rafael@kernel.org, lukas@wunner.de
Subject: Re: [PATCH v2 02/21] cxl: Add checksum verification to CDAT from CXL
Message-ID: <ZCOANlmHyhJ0hDGn@aschofie-mobl2>
References: <167995336797.2857312.539473939839316778.stgit@djiang5-mobl3>
 <167995345388.2857312.2421270054519644444.stgit@djiang5-mobl3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167995345388.2857312.2421270054519644444.stgit@djiang5-mobl3>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Mar 27, 2023 at 02:44:13PM -0700, Dave Jiang wrote:
> A CDAT table is available from a CXL device. The table is read by the
> driver and cached in software. With the CXL subsystem needing to parse the
> CDAT table, the checksum should be verified. Add checksum verification
> after the CDAT table is read from device.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> v2:
> - Drop ACPI checksum export and just use local verification. (Dan)
> ---
>  drivers/cxl/core/pci.c |   16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 25b7e8125d5d..e0d5e6525c0d 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -528,6 +528,16 @@ static int cxl_cdat_read_table(struct device *dev,
>  	return 0;
>  }
>  
> +static unsigned char cdat_checksum(void *buf, size_t size)
> +{
> +	unsigned char sum, *data = buf;
> +	size_t i;
> +
> +	for (sum = 0, i = 0; i < size; i++)
> +		sum += data[i];
> +	return 0 - sum;

This return value isn't obvious to me. What's happening here?
Thanks for explaining,

Alison

> +}
> +
>  /**
>   * read_cdat_data - Read the CDAT data on this port
>   * @port: Port to read data from
> @@ -573,6 +583,12 @@ void read_cdat_data(struct cxl_port *port)
>  	}
>  
>  	port->cdat.table = cdat_table + sizeof(__le32);
> +	if (cdat_checksum(port->cdat.table, cdat_length)) {
> +		/* Don't leave table data allocated on error */
> +		devm_kfree(dev, cdat_table);
> +		dev_err(dev, "CDAT data checksum error\n");
> +	}
> +
>  	port->cdat.length = cdat_length;
>  }
>  EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
> 
> 
