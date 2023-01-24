Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A1F6796CB
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Jan 2023 12:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbjAXLkW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 24 Jan 2023 06:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234194AbjAXLkU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Jan 2023 06:40:20 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E39F2CC49;
        Tue, 24 Jan 2023 03:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674560417; x=1706096417;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NIYk1uI41v3OvDRzECTRb8uxkg78dVlwCPE4WWsO46w=;
  b=lNqZ8SvbDBfDkgavloGqHHXFyOszeCedx6svXxBP8TOR1RWpI4cIfBjN
   jaRTX48tcb3/7gfcdQ330MN6vT0ObRJ17tdm6voPrGnKo35eIQlrX1nAz
   jk7i0sb4aPhTFExModbHxNxeocoBPkcUTZxvcSRV4klULKTxv+FL9aRKC
   f3Y0YCzNy/mKUuUtozrjghEDXfIYcChgIKZD2QxF84aJU1cmZX9un3avT
   N9eQifwGXede8x/7FZfKHT8WKOU8Lbbs8OykL2utCnemqRBf8wr0B/Xpr
   2oW8A4dePqXhIR3HFZo4I5Z7ZhOesV/CLo2UZy/zFgnkgURjnIoL59+du
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="314175682"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="314175682"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 03:40:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="804565001"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="804565001"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 24 Jan 2023 03:40:13 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 24 Jan 2023 13:40:13 +0200
Date:   Tue, 24 Jan 2023 13:40:13 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, andriy.shevchenko@linux.intel.com
Subject: Re: [PATCH v2 3/8] device property: Add SOFTWARE_NODE() macro for
 defining software nodes
Message-ID: <Y8/DnebjvGFsBgjk@kuha.fi.intel.com>
References: <20230123134617.265382-1-sakari.ailus@linux.intel.com>
 <20230123134617.265382-4-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123134617.265382-4-sakari.ailus@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jan 23, 2023 at 03:46:12PM +0200, Sakari Ailus wrote:
> Add SOFTWARE_NODE() macro in order to make defining software nodes look
> nicer. This is analogous to different PROPERTY_ENTRY_*() macros for
> defining properties.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

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

-- 
heikki
