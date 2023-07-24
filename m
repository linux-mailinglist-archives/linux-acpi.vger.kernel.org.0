Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76ABA7602A5
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Jul 2023 00:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjGXWr5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 Jul 2023 18:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGXWr4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Jul 2023 18:47:56 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C820DF
        for <linux-acpi@vger.kernel.org>; Mon, 24 Jul 2023 15:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690238876; x=1721774876;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/cei8Q8sF5wV/K0QAz96EaF7vEr04Wejo5x1v49LbNg=;
  b=brrFPppycutY2vGvBBCUTiuSa0L8ezy8Z/bWIGElGz+FmKjwKAu6B1PL
   YPpUn6f14CWHTzXV4l302IJXe6UJPivhH4nfkXz95nqXNZQT1BUV9w0Ty
   ag2i70Fz3nKgEErJA3/XJIaGUjStNqolaHoqX33ennBCG6WxulsgFTKe4
   1VxjY7ZvEnd6j17baT9VinyJicRW6uAy0utriF/eg7nfwO1pzHwlGZ1ux
   OugTJm4VAhCCe7D/3YkkpdAiN89te7VJKKBM1N6mJaFXICng4T06pvnTV
   9Tcc1wshUpZPPZ1EZvdXFD8tzT5m3JY3AfbJdzqyIMS3J8ANPfbZnTcWu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="357568967"
X-IronPort-AV: E=Sophos;i="6.01,229,1684825200"; 
   d="scan'208";a="357568967"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 15:47:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="1056593797"
X-IronPort-AV: E=Sophos;i="6.01,229,1684825200"; 
   d="scan'208";a="1056593797"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.251.18.188])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 15:47:55 -0700
Date:   Mon, 24 Jul 2023 15:47:53 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        nvdimm@lists.linux.dev, linux-acpi@vger.kernel.org, lenb@kernel.org
Subject: Re: [PATCH] nfit: remove redundant list_for_each_entry
Message-ID: <ZL7/mctQSQ7rtK3X@aschofie-mobl2>
References: <20230719080526.2436951-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719080526.2436951-1-ruansy.fnst@fujitsu.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jul 19, 2023 at 04:05:26PM +0800, Shiyang Ruan wrote:
> The first for_each only do acpi_nfit_init_ars() for NFIT_SPA_VOLATILE
> and NFIT_SPA_PM, which can be moved to next one.

Can the result of nfit_spa_type(nfit_spa->spa) change as a result of
the first switch statement? That would be a reason why they are separate.

Alison

> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  drivers/acpi/nfit/core.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 07204d482968..4090a0a0505c 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -2971,14 +2971,6 @@ static int acpi_nfit_register_regions(struct acpi_nfit_desc *acpi_desc)
>  		case NFIT_SPA_VOLATILE:
>  		case NFIT_SPA_PM:
>  			acpi_nfit_init_ars(acpi_desc, nfit_spa);
> -			break;
> -		}
> -	}
> -
> -	list_for_each_entry(nfit_spa, &acpi_desc->spas, list) {
> -		switch (nfit_spa_type(nfit_spa->spa)) {
> -		case NFIT_SPA_VOLATILE:
> -		case NFIT_SPA_PM:
>  			/* register regions and kick off initial ARS run */
>  			rc = ars_register(acpi_desc, nfit_spa);
>  			if (rc)
> -- 
> 2.41.0
> 
