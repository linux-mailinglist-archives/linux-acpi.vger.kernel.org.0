Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064006ABE7F
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Mar 2023 12:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjCFLoF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Mar 2023 06:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjCFLoA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Mar 2023 06:44:00 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B4A23D93;
        Mon,  6 Mar 2023 03:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678103039; x=1709639039;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rmMYzCNrCuAGX+FVKa0uzWAwWT9fcvok0xc1fHs/3wk=;
  b=ikiLQXvksxr0TsCKP+nbzyUE8oxHuRpfmAVbv0UkBU/l9hnO4Qwcdbk6
   EPhdhMSLHNw+awy/LoakYbZub6yZHOsSqVzjuCdoa7auInEIMSDtagRcN
   7PyuGNs6VmUd07fVZ3uJMGwhWT+31N1fA+HOc6yAjwAkDKsONkE51H0Sn
   qoZxFuiI7e5fG3EPJdycjxw+3J7ETo3N279EY4L/j0lNVAt4+sdirwgTP
   T4JjXqQwoQTumtORw9bEMUm/EUoC/6auEeiYzeHCaG9A880hbwVWxKIN+
   a7bMt4ZnKK9/7Hi+Bs5JGn3CWNUO2n3amAC7ewm0Zb0hWztGQeo6pzUSl
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="337050644"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="337050644"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 03:43:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="740297142"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="740297142"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 06 Mar 2023 03:43:49 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pZ9Fq-00GKVl-0P;
        Mon, 06 Mar 2023 13:43:46 +0200
Date:   Mon, 6 Mar 2023 13:43:45 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Pin-yen Lin <treapking@chromium.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Xin Ji <xji@analogixsemi.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Lyude Paul <lyude@redhat.com>, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        chrome-platform@lists.linux.dev,
        =?iso-8859-1?Q?N=EDcolas_F_=2E_R_=2E_A_=2E?= Prado 
        <nfraprado@collabora.com>, Marek Vasut <marex@denx.de>,
        Hsin-Yi Wang <hsinyi@chromium.org>, devicetree@vger.kernel.org,
        Allen Chen <allen.chen@ite.com.tw>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Stephen Boyd <swboyd@chromium.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v13 01/10] device property: Add remote endpoint to devcon
 matcher
Message-ID: <ZAXR8emmwuVChL4i@smile.fi.intel.com>
References: <20230303143350.815623-1-treapking@chromium.org>
 <20230303143350.815623-2-treapking@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303143350.815623-2-treapking@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Mar 03, 2023 at 10:33:41PM +0800, Pin-yen Lin wrote:
> From: Prashant Malani <pmalani@chromium.org>
> 
> When searching the device graph for device matches, check the
> remote-endpoint itself for a match.
> 
> Some drivers register devices for individual endpoints. This allows
> the matcher code to evaluate those for a match too, instead
> of only looking at the remote parent devices. This is required when a
> device supports two mode switches in its endpoints, so we can't simply
> register the mode switch with the parent node.

OK!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> 
> ---
> 
> Changes in v13:
> - Update the kernel doc of fwnode_connection_find_match
> 
> Changes in v12:
> - Check the availability of the device node in fwnode_graph_devcon_matches
> - Ensured valid access to "matches" in fwnode_graph_devcon_matches
> - Updated the documentation in fwnode_connection_find_match(es)
> - Dropped collected tags due to the new changes
> 
> Changes in v11:
> - Added missing fwnode_handle_put in drivers/base/property.c
> 
> Changes in v10:
> - Collected Reviewed-by and Tested-by tags
> 
> Changes in v6:
> - New in v6
> 
>  drivers/base/property.c | 31 ++++++++++++++++++++++++++-----
>  1 file changed, 26 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 083a95791d3b..4426ac2b16ca 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -1243,6 +1243,23 @@ static unsigned int fwnode_graph_devcon_matches(const struct fwnode_handle *fwno
>  			continue;
>  		}
>  
> +		ret = match(node, con_id, data);
> +		fwnode_handle_put(node);
> +		if (ret) {
> +			if (matches)
> +				matches[count] = ret;
> +			count++;
> +
> +			if (matches && count >= matches_len)
> +				break;
> +		}
> +
> +		/*
> +		 * Some drivers may register devices for endpoints. Check
> +		 * the remote-endpoints for matches in addition to the remote
> +		 * port parent.
> +		 */
> +		node = fwnode_graph_get_remote_endpoint(ep);
>  		ret = match(node, con_id, data);
>  		fwnode_handle_put(node);
>  		if (ret) {
> @@ -1293,8 +1310,11 @@ static unsigned int fwnode_devcon_matches(const struct fwnode_handle *fwnode,
>   * @match: Function to check and convert the connection description
>   *
>   * Find a connection with unique identifier @con_id between @fwnode and another
> - * device node. @match will be used to convert the connection description to
> - * data the caller is expecting to be returned.
> + * device node. For fwnode graph connections, the graph endpoints are also
> + * checked. @match will be used to convert the connection description to data
> + * the caller is expecting to be returned.
> + *
> + * Return: The pointer to the matched node, or NULL on error.
>   */
>  void *fwnode_connection_find_match(const struct fwnode_handle *fwnode,
>  				   const char *con_id, void *data,
> @@ -1325,9 +1345,10 @@ EXPORT_SYMBOL_GPL(fwnode_connection_find_match);
>   * @matches_len: Length of @matches
>   *
>   * Find up to @matches_len connections with unique identifier @con_id between
> - * @fwnode and other device nodes. @match will be used to convert the
> - * connection description to data the caller is expecting to be returned
> - * through the @matches array.
> + * @fwnode and other device nodes. For fwnode graph connections, the graph
> + * endpoints are also checked. @match will be used to convert the connection
> + * description to data the caller is expecting to be returned through the
> + * @matches array.
>   * If @matches is NULL @matches_len is ignored and the total number of resolved
>   * matches is returned.
>   *
> -- 
> 2.40.0.rc0.216.gc4246ad0f0-goog
> 

-- 
With Best Regards,
Andy Shevchenko


