Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3426CC279
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Mar 2023 16:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbjC1Opr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Mar 2023 10:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbjC1Opd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Mar 2023 10:45:33 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA55D52E;
        Tue, 28 Mar 2023 07:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680014718; x=1711550718;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vgWwPnAjZQYBYL4Bwwf4wc9rslKPq0416E/mW3l6AG0=;
  b=NfDWb2/B+0WGy4yfs4are1sscEMLKdUB/SC73nXqQ7Ibx7fkZKHJZxBe
   yP4uBiHOwoNabPLwBKZ2950fV9BM4alCUh5MK3hMtvmMlOc/B7N9FA3+g
   /HMqnzafCb8F9DstruotEdjuYLC2Z+w/bVbNcTRpSTfmcSXs6J2C1c0KO
   9L8MWJ97fJw/MBaV8hkxlDx+HJXt1lkas6/8wfDI9M4qMBr/DnX7QZW/+
   A/KXgcwc1VRngWuWMJ+FQygy9/GiMTlWy+wbB4zgt2RiYZL72T8z67EXB
   /opzLVoXcjNs50fEArKkeIdZvHj/yFTOLCQSmRvDmTO/Rsp4svEg6DzKK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="339305535"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="339305535"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 07:45:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="686453207"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="686453207"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 28 Mar 2023 07:45:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1phAZV-009fEo-1c;
        Tue, 28 Mar 2023 17:45:13 +0300
Date:   Tue, 28 Mar 2023 17:45:13 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v7 01/10] ACPI: scan: Remove the second DSDT traversal
Message-ID: <ZCL9eWARHqzYuQyV@smile.fi.intel.com>
References: <20230328101303.1458570-1-sakari.ailus@linux.intel.com>
 <20230328101303.1458570-2-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328101303.1458570-2-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 28, 2023 at 01:12:54PM +0300, Sakari Ailus wrote:
> Collect the devices with _DEP into a list and continue processing them
> after a full traversal, instead of doing a full second traversal of the
> tree.
> 
> This makes the second DSDT traversal pass unnecessary as we already have
> the nodes we're interested in in a linked list.

...

> +/**
> + * struct acpi_postponed_handle - A postponed ACPI handle
> + * @handle: The postponed handle
> + * @list: Entry in a postponed list
> + *
> + * One such entry represents an ACPI handle the scanning of which has been
> + * postponed.
> + */
> +struct acpi_postponed_handle {
> +	acpi_handle handle;
> +	struct list_head list;
> +};

If you put the list to be the first member, container_of() against it becomes a
no-op at compile time. Have you checked the code generation if you swap these
members?

> +/**
> + * struct acpi_scan_context - Context for scanning ACPI devices
> + * @device: The first encountered device, typically the root of the scanned tree
> + * @postponed_head: The list head of the postponed ACPI handles
> + */
> +struct acpi_scan_context {
> +	struct acpi_device *device;
> +	struct list_head postponed_head;
> +};

Ditto.

...

> +/**
> + * acpi_bus_handle_postpone - Add an ACPI handle to a given postponed list
> + * @handle: The ACPI handle
> + * @head: Postponed list head
> + *
> + * Add a given ACPI handle to a list of ACPI objects for which the creation
> + * of the device objects is to be postponed.

`kernel-doc -v ...` complains on the absence of Return section. Is it the same
for you?

> + */


-- 
With Best Regards,
Andy Shevchenko


