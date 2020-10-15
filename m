Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 476B228F9B0
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Oct 2020 21:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391881AbgJOTrL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Oct 2020 15:47:11 -0400
Received: from mga03.intel.com ([134.134.136.65]:43987 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391865AbgJOTrK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 15 Oct 2020 15:47:10 -0400
IronPort-SDR: 0o3A548iK5eeqvOPUoBVxDb203bb/UnxMbqbHlAohWYOoMkRDBfKzDLL9hHHjfEb097DEi6zP+
 k9+xHiqpGhIw==
X-IronPort-AV: E=McAfee;i="6000,8403,9775"; a="166500299"
X-IronPort-AV: E=Sophos;i="5.77,380,1596524400"; 
   d="scan'208";a="166500299"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2020 12:47:09 -0700
IronPort-SDR: I95RksRwuPmnhmsPzdmHnGLymyKbVO6Jdiz9Y6Sl2vVBPJXKbV8pbeXH8kIlp3BsUvZnRL3DhW
 Va137lp51opw==
X-IronPort-AV: E=Sophos;i="5.77,380,1596524400"; 
   d="scan'208";a="464417523"
Received: from spandruv-mobl.amr.corp.intel.com ([10.212.199.190])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2020 12:47:08 -0700
Message-ID: <1e820f96242cc847b8465751f074155f8e7b5819.camel@linux.intel.com>
Subject: Re: [PATCH 1/2] ACPI: DPTF: Fix participant driver names
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@suse.de>
Date:   Thu, 15 Oct 2020 12:47:07 -0700
In-Reply-To: <2071902.YaQf1D0BmN@kreacher>
References: <2206290.MayQypTng0@kreacher> <2071902.YaQf1D0BmN@kreacher>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, 2020-10-15 at 18:58 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Change the names of DPTF participant drivers to adhere to the
> sysfs file naming conventions (no spaces present in the name in
> particular).
> 
> Fixes: 2ce6324eadb0 ("ACPI: DPTF: Add PCH FIVR participant driver")
> Fixes: 6256ebd5daf9 ("ACPI / DPTF: Add DPTF power participant
> driver")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
>  drivers/acpi/dptf/dptf_pch_fivr.c |    2 +-
>  drivers/acpi/dptf/dptf_power.c    |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> Index: linux-pm/drivers/acpi/dptf/dptf_pch_fivr.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/dptf/dptf_pch_fivr.c
> +++ linux-pm/drivers/acpi/dptf/dptf_pch_fivr.c
> @@ -114,7 +114,7 @@ static struct platform_driver pch_fivr_d
>  	.probe = pch_fivr_add,
>  	.remove = pch_fivr_remove,
>  	.driver = {
> -		.name = "DPTF PCH FIVR",
> +		.name = "dptf_pch_fivr",
>  		.acpi_match_table = pch_fivr_device_ids,
>  	},
>  };
> Index: linux-pm/drivers/acpi/dptf/dptf_power.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/dptf/dptf_power.c
> +++ linux-pm/drivers/acpi/dptf/dptf_power.c
> @@ -237,7 +237,7 @@ static struct platform_driver dptf_power
>  	.probe = dptf_power_add,
>  	.remove = dptf_power_remove,
>  	.driver = {
> -		.name = "DPTF Platform Power",
> +		.name = "dptf_power",
>  		.acpi_match_table = int3407_device_ids,
>  	},
>  };
> 
> 
> 

