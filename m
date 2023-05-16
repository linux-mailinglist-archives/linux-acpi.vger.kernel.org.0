Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D80070484F
	for <lists+linux-acpi@lfdr.de>; Tue, 16 May 2023 10:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbjEPI5q (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 May 2023 04:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbjEPI5o (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 May 2023 04:57:44 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630A649DA;
        Tue, 16 May 2023 01:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684227462; x=1715763462;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9ieOiHdR2XFodCWGlERuengFjj9o9lpxO2QT8t8Ovg0=;
  b=E6y5vnoEZd+Ks3nlp/Y7Xr4arM0J2Zr00AYoROT1AKFS1ZJt17Nh9yjm
   AuJpDTlttrklBeP/0VPkrLIwlfUHdIhCKfVTDdHJXc3oHnPMPK3Ksu1Dx
   gKbMv/xSegIBdEROlcEHz8rm9EbmTXtWxpLp2w5gwLIwBAAIkLcv3WmIw
   xFBrvEb50HIP66CgXzd5jI+ES/kr+Wyx0ca5ACesGdZ46ylBK7wvf2Cd3
   RcrlaF/erg8trm1Lfp7I7ZnQlYxGGD5TxmAmO9F3plM+s1OiEeew2QXd0
   k/XN0jWOdnwoNUiai2zMEGx6/i5eEh8c+XIILllCFKGyKDV89wXcf6WNF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="354588392"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="354588392"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 01:57:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="678768726"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="678768726"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 01:57:39 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 429A0120279;
        Tue, 16 May 2023 11:57:37 +0300 (EEST)
Date:   Tue, 16 May 2023 08:57:37 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, andriy.shevchenko@linux.intel.com,
        heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v8 03/10] ACPI: property: Parse _CRS CSI-2 descriptor
Message-ID: <ZGNFgXM/463ycI6R@kekkonen.localdomain>
References: <20230329100951.1522322-1-sakari.ailus@linux.intel.com>
 <20230329100951.1522322-4-sakari.ailus@linux.intel.com>
 <1865464.tdWV9SEqCh@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1865464.tdWV9SEqCh@kreacher>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

On Mon, May 15, 2023 at 06:45:10PM +0200, Rafael J. Wysocki wrote:
> On Wednesday, March 29, 2023 12:09:44 PM CEST Sakari Ailus wrote:
> > Parse newly added ACPI _CRS CSI-2 descriptor for CSI-2 and camera
> > configuration, associate it with appropriate devices and allocate memory for
> > software nodes needed to create a DT-like data structure for drivers.
> 
> It occurred to me, that there would be so many things I would like to change
> in this patch, so it would be better to create my own version of it, which
> is appended.
> 
> It is based on
> 
> https://patchwork.kernel.org/project/linux-acpi/patch/2694293.mvXUDI8C0e@kreacher/
> 
> that has just been posted.
> 
> IIUC, the idea is to extract the ACPI handle for each resource source in every
> _CRS CSI-2 resource descriptor and count how many times each handle appears in
> a CSI-2 context, either because it is referenced from a _CRS CSI-2 resource
> descriptor (as a "resource source"), or because its device object has CSI-2
> resource descriptors in _CRS.

Correct.

> 
> This allows a set of software nodes to be allocated for each of these handles.
> 
> If I got that totally wrong, please let me know.  Otherwise, I will rework the
> remaining patches in the series to match this one.

It seems about right. I mostly see renames, moving the code around,
using the existing dependency list and then parsing sub-tree for _CRS CSI-2
objects right from the bus scan callback. 

It seems you've also moved the structs from internal.h to what is now
called mipi-disco-imaging.c. They'll be later needed in e.g. scan.c. At
least I'd use names that indicate they're related to scanning the bus:
they're not needed after this is done.

I don't have objections to you reworking the rest, but given the number of
non-trivial changes, will it work after this? :-) I can also do this,
although I would un-do some of the changes in this patch in order to
prepare for the rest (such as moving the structs from internal.h).

See e.g. "ACPI: scan: Generate software nodes based on MIPI DisCo for
Imaging", I think it's the 6th patch.

...

> +/**
> + * acpi_mipi_scan_crs_csi2 - Allocate ACPI _CRS CSI-2 software nodes
> + *
> + * Note that this function must be called before any struct acpi_device objects
> + * are bound to any ACPI drivers or scan handlers, so it cannot assume the
> + * existence of struct acpi_device objects for every device present in the ACPI
> + * namespace.
> + *
> + * acpi_scan_lock in scan.c must be held when calling this function.
> + */
> +void acpi_mipi_scan_crs_csi2(void)
> +{
> +	struct crs_csi2 *csi2;
> +	LIST_HEAD(aux_list);
> +
> +	/* Count references to each ACPI handle in the CSI-2 connection graph. */
> +	list_for_each_entry(csi2, &acpi_mipi_crs_csi2_list, entry) {
> +		struct crs_csi2_connection *conn;
> +
> +		list_for_each_entry(conn, &csi2->connections, entry) {
> +			struct crs_csi2 *remote_csi2;
> +			acpi_status status;
> +
> +			status = acpi_get_data_full(conn->remote_handle,
> +						    acpi_mipi_data_tag,
> +						    (void **)&remote_csi2,
> +						    NULL);
> +			if (ACPI_SUCCESS(status) && remote_csi2) {
> +				remote_csi2->port_count++;
> +				continue;
> +			}
> +
> +			/*
> +			 * The "remote" device has no _CRS CSI-2 list entry yet,
> +			 * so create one for it and add it to the list.
> +			 */
> +			remote_csi2 = create_crs_csi2_entry(conn->remote_handle);
> +			if (!remote_csi2)
> +				continue;
> +
> +			list_add(&remote_csi2->entry, &aux_list);
> +		}
> +	}
> +	list_splice(&aux_list, &acpi_mipi_crs_csi2_list);
> +
> +	/* Allocate softwware nodes for representing the CSI-2 information. */

"software"

> +	list_for_each_entry(csi2, &acpi_mipi_crs_csi2_list, entry)
> +		alloc_fill_crs_csi2_swnodes(csi2->handle, csi2->port_count);
> +
> +	acpi_mipi_crs_csi2_release();
> +}

-- 
Kind regards,

Sakari Ailus
