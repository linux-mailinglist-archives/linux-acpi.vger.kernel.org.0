Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7037852EE29
	for <lists+linux-acpi@lfdr.de>; Fri, 20 May 2022 16:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbiETO26 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 20 May 2022 10:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiETO25 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 20 May 2022 10:28:57 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B1C9D070
        for <linux-acpi@vger.kernel.org>; Fri, 20 May 2022 07:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653056936; x=1684592936;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XXcy4/dg+oajCE4EV4nhyVm7P9LW0I2wdIkhh+1Fk7c=;
  b=C2x2INd6aofzjrV32hf7NNyhl4l86DdCQ91ZSgpCAtWgnzg0phcXH/Wu
   78ZXjnCpLuWYhGWY4/7iVHKDD+2139sI5KeJ1lQCrvfW5Bk9UKm7KbKHH
   rkanGavzFDgZckIS+k1flYibbybBZ7080gP30wDf45lfHgIcPVdw/SeT2
   uH88+VCVdH20p3GmUyzG7QYy2TLBbd3xFMjlywE3eGPr2ADqjMDOOHXHy
   L3nompyLe8Ttt5a5Iu9iVOibXhND6gpsFybr279fsGrq19WZUpnu+pYfs
   KJUBYFVemwRlfTJx81/M/g+2lTT7Wy/IEbKMeupaS6VDtAxptolMfLkv4
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="335677939"
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="335677939"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 07:28:56 -0700
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="640339604"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 07:28:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1ns3ca-000Gqn-MJ;
        Fri, 20 May 2022 17:28:52 +0300
Date:   Fri, 20 May 2022 17:28:52 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org
Subject: Re: [PATCH v2 7/8] ACPI: property: Add support for parsing buffer
 property UUID
Message-ID: <YoelpPVmLoKL295p@smile.fi.intel.com>
References: <20220520061148.21366-1-sakari.ailus@linux.intel.com>
 <20220520061148.21366-8-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520061148.21366-8-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, May 20, 2022 at 09:11:47AM +0300, Sakari Ailus wrote:
> Add support for newly added buffer property UUID, as defined in the DSD
> guide.

...

>  static bool acpi_enumerate_nondev_subnodes(acpi_handle scope,
> -					   const union acpi_object *desc,
> +					   union acpi_object *desc,
>  					   struct acpi_device_data *data,
>  					   struct fwnode_handle *parent);
> -static bool acpi_extract_properties(const union acpi_object *desc,
> +static bool acpi_extract_properties(acpi_handle handle,
> +				    union acpi_object *desc,
>  				    struct acpi_device_data *data);

Looking at the first one, can union member be const in the last one?

...

>  struct acpi_device_properties {
>  	const guid_t *guid;
> -	const union acpi_object *properties;
> +	union acpi_object *properties;

Probably this change explains on the above question...

>  	struct list_head list;
> +	void **bufs;
>  };

-- 
With Best Regards,
Andy Shevchenko


