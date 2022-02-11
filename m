Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5904B2984
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Feb 2022 16:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349607AbiBKP7s (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 11 Feb 2022 10:59:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239711AbiBKP7r (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Feb 2022 10:59:47 -0500
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE231A8;
        Fri, 11 Feb 2022 07:59:46 -0800 (PST)
Received: by mail-qk1-f182.google.com with SMTP id o12so8625596qke.5;
        Fri, 11 Feb 2022 07:59:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f+ifvKEkXr9ARNhzR8qgdvE+2k8WYo63Fid0lRtptzU=;
        b=L7FtoxWuHExJun1XA2e4vsLMoSck8pbzScjW4tAQlFmWmnwARVFaTdm0tpOsNwRWiF
         78nxYgXAMAHLvYJf2IREu9w+YBQAv1CCEqwwBd/SsF9AoS4f/R+7gt0l8qct47KDHI2e
         7J3x2H6gtRJw/LI8beMwPvPkK/e1SbpfAlBtEFeRj1kxD87fofNiNJfgUC/MA5f2Ybg6
         q7UMvQcPHgXZMQZb5B/fd15AKiD1rWd/N1rCDKUFASFaErN3XEfwxrp9Mne+qvQAcZN3
         +a0lh9GjK3naihbX0trOsH5I2nd+z/Tk7QcCl42ewGYi2fOQcdwBvIjP37nj3BYSEww6
         jCmg==
X-Gm-Message-State: AOAM530QBA4HfZoPPdpn9Z7vC9NlvRfi4iuCWdASWCAiCuD7c4ty8Snf
        9C+KS7PSWhF75tfJ1csIpMb8UMd+GA==
X-Google-Smtp-Source: ABdhPJz+98ogOo5DBeX77ym1aHks5D4Wcj9cTI1Mn6+ybCLJyig3Mg7VvHb7zL0Wup2+xb8DdbEORg==
X-Received: by 2002:a05:620a:29ce:: with SMTP id s14mr1090724qkp.355.1644595185656;
        Fri, 11 Feb 2022 07:59:45 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:5fee:dfce:b6df:c3e1:b1e5:d6d8])
        by smtp.gmail.com with ESMTPSA id y5sm11277476qkj.28.2022.02.11.07.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 07:59:44 -0800 (PST)
Received: (nullmailer pid 429224 invoked by uid 1000);
        Fri, 11 Feb 2022 15:59:42 -0000
Date:   Fri, 11 Feb 2022 09:59:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        devicetree@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH 3/4] device property: Add iomap to fwnode operations
Message-ID: <YgaH7iJ5CWSJp1PY@robh.at.kernel.org>
References: <20220206091643.276833-1-sakari.ailus@linux.intel.com>
 <20220206091643.276833-4-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220206091643.276833-4-sakari.ailus@linux.intel.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Feb 06, 2022 at 11:16:42AM +0200, Sakari Ailus wrote:
> Add iomap() fwnode operation to implement fwnode_iomap() through fwnode
> operations, moving the code in fwnode_iomap() to OF framework.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/base/property.c | 5 +----
>  drivers/of/property.c   | 7 +++++++
>  include/linux/fwnode.h  | 1 +
>  3 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 09686e2e903e..83dd22e7cb81 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -887,10 +887,7 @@ EXPORT_SYMBOL_GPL(device_get_phy_mode);
>   */
>  void __iomem *fwnode_iomap(struct fwnode_handle *fwnode, int index)
>  {
> -	if (IS_ENABLED(CONFIG_OF_ADDRESS) && is_of_node(fwnode))
> -		return of_iomap(to_of_node(fwnode), index);
> -
> -	return NULL;
> +	return fwnode_call_ptr_op(fwnode, iomap, index);
>  }
>  EXPORT_SYMBOL(fwnode_iomap);
>  
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 676899566f7c..8beb89709740 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1465,6 +1465,12 @@ static int of_link_property(struct device_node *con_np, const char *prop_name)
>  	return 0;
>  }
>  
> +static void __iomem *of_fwnode_iomap(struct fwnode_handle *fwnode, int index)
> +{
> +	return IS_ENABLED(CONFIG_OF_ADDRESS) ?

I think this shouldn't be needed. !OF_ADDRESS is Sparc which just has 
its own implementation of of_iomap().

> +		of_iomap(to_of_node(fwnode), index) : NULL;
> +}
> +
>  static int of_fwnode_add_links(struct fwnode_handle *fwnode)
>  {
>  	struct property *p;
> @@ -1502,6 +1508,7 @@ const struct fwnode_operations of_fwnode_ops = {
>  	.graph_get_remote_endpoint = of_fwnode_graph_get_remote_endpoint,
>  	.graph_get_port_parent = of_fwnode_graph_get_port_parent,
>  	.graph_parse_endpoint = of_fwnode_graph_parse_endpoint,
> +	.iomap = of_fwnode_iomap,
>  	.add_links = of_fwnode_add_links,
>  };
>  EXPORT_SYMBOL_GPL(of_fwnode_ops);
> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index 6f307f21fc65..ebbc3bf03f95 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -148,6 +148,7 @@ struct fwnode_operations {
>  	(*graph_get_port_parent)(struct fwnode_handle *fwnode);
>  	int (*graph_parse_endpoint)(const struct fwnode_handle *fwnode,
>  				    struct fwnode_endpoint *endpoint);
> +	void __iomem *(*iomap)(struct fwnode_handle *fwnode, int index);
>  	int (*add_links)(struct fwnode_handle *fwnode);
>  };
>  
> -- 
> 2.30.2
> 
> 
