Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1024953425C
	for <lists+linux-acpi@lfdr.de>; Wed, 25 May 2022 19:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241648AbiEYRpI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 May 2022 13:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343499AbiEYRpE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 May 2022 13:45:04 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3369D06A
        for <linux-acpi@vger.kernel.org>; Wed, 25 May 2022 10:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653500704; x=1685036704;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qB0pni2y01usyYectD6a+dAVh/b2QXO38Uzo+TH3CEI=;
  b=ZsTtdvIoX06r0LhEOV59d8CKQ2OvBB1uvFR/01NBSAkzcr7S/qsyfY9f
   8BplXBsLmyUN8YMsy26iAMODKLZ5roexX+4Mjhgtxzo93ej44HHhcFPJN
   L7OloK9m/Ko1ubc404EEDKBLjQT6ye2/K7oX1gjORXfrfu0NMBAXnNBZY
   ZImZ6ItXuwaSxfKaJPYJ+IbLwdLk+Sgg5QOV0DJ0912org2JGBkQZIxVQ
   o+huCzW7qQdd3kvvYXOCi/AyUi0dmDVCh1f+bi268ZlU/NZca2jM1kftZ
   2C1v3KBkbeAZXi5uND0vv95dHT+ekCZjIrnXAJBkyvZREJSFw6ruU/ldF
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="261498082"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="261498082"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 10:29:01 -0700
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="573436362"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 10:29:00 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1ntuob-000L5J-Rh;
        Wed, 25 May 2022 20:28:57 +0300
Date:   Wed, 25 May 2022 20:28:57 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org
Subject: Re: [PATCH v3 4/8] ACPI: property: Move property ref argument
 parsing into a new function
Message-ID: <Yo5nWSQFqPxnIfqh@smile.fi.intel.com>
References: <20220525130123.767410-1-sakari.ailus@linux.intel.com>
 <20220525130123.767410-5-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525130123.767410-5-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, May 25, 2022 at 04:01:19PM +0300, Sakari Ailus wrote:
> Split out property reference argument parsing out of the
> __acpi_node_get_property_reference() function into a new one,
> acpi_get_ref_args(). The new function will be needed also for parsing
> string references soon.

...

> +static int
> +acpi_get_ref_args(struct fwnode_reference_args *args,

You can at least make these two on one line.

> +		  struct fwnode_handle *ref_fwnode,

Calling it fwnode would save a few lines of code even with your strictness
of 80.

> +		  const union acpi_object **element,
> +		  const union acpi_object *end, size_t num_args)
> +{
> +	u32 nargs = 0, i;
> +
> +	/*
> +	 * Find the referred data extension node under the
> +	 * referred device node.
> +	 */
> +	for (; *element < end && (*element)->type == ACPI_TYPE_STRING;
> +	     (*element)++) {
> +		const char *child_name = (*element)->string.pointer;

I believe this on one line is better to read.

> +		ref_fwnode = acpi_fwnode_get_named_child_node(ref_fwnode,
> +							      child_name);

This too.

> +		if (!ref_fwnode)
> +			return -EINVAL;
> +	}
> +
> +	/*
> +	 * Assume the following integer elements are all args. Stop counting on
> +	 * the first reference or end of the package arguments. In case of
> +	 * neither reference, nor integer, return an error, we can't parse it.
> +	 */
> +	for (i = 0; (*element) + i < end && i < num_args; i++) {
> +		acpi_object_type type = (*element)[i].type;
> +
> +		if (type == ACPI_TYPE_LOCAL_REFERENCE)
> +			break;
> +
> +		if (type == ACPI_TYPE_INTEGER)
> +			nargs++;
> +		else
> +			return -EINVAL;
> +	}
> +
> +	if (nargs > NR_FWNODE_REFERENCE_ARGS)
> +		return -EINVAL;
> +
> +	if (args) {
> +		args->fwnode = ref_fwnode;
> +		args->nargs = nargs;
> +		for (i = 0; i < nargs; i++)
> +			args->args[i] = (*element)[i].integer.value;
> +	}
> +
> +	(*element) += nargs;
> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko


