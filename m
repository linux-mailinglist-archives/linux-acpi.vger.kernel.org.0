Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C97F534253
	for <lists+linux-acpi@lfdr.de>; Wed, 25 May 2022 19:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235887AbiEYRlz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 May 2022 13:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbiEYRly (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 May 2022 13:41:54 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77A19D06A
        for <linux-acpi@vger.kernel.org>; Wed, 25 May 2022 10:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653500512; x=1685036512;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6TOfJ58QJJLCmpfLrtKbLatQeiHt9F5xhdnegN3wHqY=;
  b=KB4h+G05exHJQ/0uklARdQZ98Ys4qUqMujWbQQwygtbBd4GDvMDIchQ1
   rLTsDiE0J+sQmefOn6C0w7OoCO0b8NiDPxjhz+3gsNBcQ5bUDHjAox7yg
   sF2nO3s3Q7J7WwD3VqYOcpj3FbvYlvu1Cs7XJhWppwC0grEkgJmV0NJRE
   MR2vYKYshZkyz6VkcknuReg3oq18Q8OKoUhj6ldgvw428WqzAcXwm2Dsg
   IZuW0liEKT72miTcxp+E65F2kQGHtS3fh4j2LR4kqbSevPlsksazsHtTC
   Zo3ajPI7KTJp5ArnicCUrQbbYjfZB+cflkayE3Z1YOP3FyL97I0RJ3qm/
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="334529260"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="334529260"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 10:15:39 -0700
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="704086742"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 10:15:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ntubg-000L4o-0p;
        Wed, 25 May 2022 20:15:36 +0300
Date:   Wed, 25 May 2022 20:15:35 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org
Subject: Re: [PATCH v3 1/8] ACPI: property: Return type of
 acpi_add_nondev_subnodes() should be bool
Message-ID: <Yo5kN5maLroJWnlT@smile.fi.intel.com>
References: <20220525130123.767410-1-sakari.ailus@linux.intel.com>
 <20220525130123.767410-2-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525130123.767410-2-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, May 25, 2022 at 04:01:16PM +0300, Sakari Ailus wrote:
> The value acpi_add_nondev_subnodes() returns is bool so change the return
> type of the function to match that.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: 445b0eb058f5 ("ACPI / property: Add support for data-only subnodes")
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/acpi/property.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index d3173811614ec..bc9a645f8bb77 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -155,10 +155,10 @@ static bool acpi_nondev_subnode_ok(acpi_handle scope,
>  	return acpi_nondev_subnode_data_ok(handle, link, list, parent);
>  }
>  
> -static int acpi_add_nondev_subnodes(acpi_handle scope,
> -				    const union acpi_object *links,
> -				    struct list_head *list,
> -				    struct fwnode_handle *parent)
> +static bool acpi_add_nondev_subnodes(acpi_handle scope,
> +				     const union acpi_object *links,
> +				     struct list_head *list,
> +				     struct fwnode_handle *parent)
>  {
>  	bool ret = false;
>  	int i;
> -- 
> 2.30.2
> 

-- 
With Best Regards,
Andy Shevchenko


