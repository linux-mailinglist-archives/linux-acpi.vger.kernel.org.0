Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F6166E0EE
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Jan 2023 15:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbjAQOhw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 Jan 2023 09:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjAQOhu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jan 2023 09:37:50 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CA41A49C;
        Tue, 17 Jan 2023 06:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673966269; x=1705502269;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Hg/QWPUugWGBv9GHT7GTGvSrGTrbRskqFX2cpRg87gk=;
  b=fQ7gu5u5mQVXVY4rsxy51vKpW92rvGw6A0wd9V00r4GA3drSn8BmdgwV
   TfsgdX3EW2MSLcEoG5v7Lnx+2UCEeWcbX5f4odB+P1Z73GiGpfTYqLzDU
   BN3H7+w1nyiosSCQDxp3JAsWldZwijx63PtohsR13MG+NVEf0pih5WPPv
   Zi0mgDwqVwnJ7cw5YRJsK67ysW3udH8oK9NKyZH310/mLLFGTsnwcVpaU
   qyLxzAjyk5aijkppS0P3h0BShb2p1xFVoG8SG9mYbPsXInKKF7NNF9uB2
   rbT+2MJsrKD0jh8fHL4i6W+KVb9SNehq4eJWvQDWy4TQqkeo3s4MWNPbv
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="326777335"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="326777335"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 06:37:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="904672146"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="904672146"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 17 Jan 2023 06:37:47 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pHn5u-00AcHf-07;
        Tue, 17 Jan 2023 16:37:46 +0200
Date:   Tue, 17 Jan 2023 16:37:45 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org,
        linux-media@vger.kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH 3/8] device property: Add SOFTWARE_NODE() macro for
 defining software nodes
Message-ID: <Y8ayuc2/XRu3qDWl@smile.fi.intel.com>
References: <20230117122244.2546597-1-sakari.ailus@linux.intel.com>
 <20230117122244.2546597-4-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117122244.2546597-4-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 17, 2023 at 02:22:39PM +0200, Sakari Ailus wrote:
> Add SOFTWARE_NODE() macro in order to make defining software nodes look
> nicer. This is analogous to different PROPERTY_ENTRY_*() macros for
> defining properties.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  include/linux/property.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 37179e3abad5c..6745a86bc9b97 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -477,6 +477,13 @@ struct software_node {
>  	const struct property_entry *properties;
>  };
>  
> +#define SOFTWARE_NODE(_name_, _properties_, _parent_)	\
> +	(struct software_node) {			\
> +		.name = _name_,				\
> +		.properties = _properties_,		\
> +		.parent = _parent_,			\
> +	}
> +
>  bool is_software_node(const struct fwnode_handle *fwnode);
>  const struct software_node *
>  to_software_node(const struct fwnode_handle *fwnode);
> -- 
> 2.30.2
> 

-- 
With Best Regards,
Andy Shevchenko


