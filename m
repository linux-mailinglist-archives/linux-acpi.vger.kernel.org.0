Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF0428FFE7
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Oct 2020 10:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389928AbgJPIXa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Oct 2020 04:23:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:58376 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389817AbgJPIXa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 16 Oct 2020 04:23:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 78898B1FF;
        Fri, 16 Oct 2020 08:23:28 +0000 (UTC)
Date:   Fri, 16 Oct 2020 10:23:23 +0200
From:   Borislav Petkov <bp@suse.de>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 1/2] ACPI: DPTF: Fix participant driver names
Message-ID: <20201016082323.GA8588@zn.tnic>
References: <2206290.MayQypTng0@kreacher>
 <2071902.YaQf1D0BmN@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2071902.YaQf1D0BmN@kreacher>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Oct 15, 2020 at 06:58:43PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Change the names of DPTF participant drivers to adhere to the
> sysfs file naming conventions (no spaces present in the name in
> particular).
> 
> Fixes: 2ce6324eadb0 ("ACPI: DPTF: Add PCH FIVR participant driver")
> Fixes: 6256ebd5daf9 ("ACPI / DPTF: Add DPTF power participant driver")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
