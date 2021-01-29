Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1373B3085B8
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Jan 2021 07:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbhA2GY6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 29 Jan 2021 01:24:58 -0500
Received: from mga14.intel.com ([192.55.52.115]:28815 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229459AbhA2GY6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 29 Jan 2021 01:24:58 -0500
IronPort-SDR: dm5xGpU9x8P2adH7WYf0PueRibpYkQxtDBzbHLFVlgn5+haoB+FbnuE4z6zFUKth+rAZBJrZgo
 jXKLo9NTc57A==
X-IronPort-AV: E=McAfee;i="6000,8403,9878"; a="179592621"
X-IronPort-AV: E=Sophos;i="5.79,384,1602572400"; 
   d="scan'208";a="179592621"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 22:24:16 -0800
IronPort-SDR: EK93pEI217TQHa8q2fHpFwHLFvEwlrOHY9lSiGKvzsdIcsMAHTfNKCGN8Eiv036RmP8M8ib6Q/
 5/HpzIK70ZqQ==
X-IronPort-AV: E=Sophos;i="5.79,384,1602572400"; 
   d="scan'208";a="578942440"
Received: from chengpol-mobl1.ccr.corp.intel.com ([10.249.170.29])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 22:24:14 -0800
Message-ID: <3ccebb5f3b7ae48166abf000b286589bd80a2ada.camel@intel.com>
Subject: Re: [PATCH -next] acpi: fpdt: drop errant comma in pr_info()
From:   Zhang Rui <rui.zhang@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Date:   Fri, 29 Jan 2021 14:24:12 +0800
In-Reply-To: <20210128232528.21117-1-rdunlap@infradead.org>
References: <20210128232528.21117-1-rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi, Randy,

Thanks for the patch, a similar patch has been posted earlier, but I
forgot to cc linux-acpi mailing list.
https://marc.info/?l=linux-next&m=161172750710666&w=2

Now given that there are a couple of fixes needed for the original
patch, I just refreshed the original patch to include all the fixes.

https://patchwork.kernel.org/project/linux-acpi/patch/20210129061548.13448-1-rui.zhang@intel.com/

thanks,
rui

On Thu, 2021-01-28 at 15:25 -0800, Randy Dunlap wrote:
> Drop a mistaken comma in the pr_info() args to prevent the
> build warning.
> 
> ../drivers/acpi/acpi_fpdt.c: In function 'acpi_init_fpdt':
> ../include/linux/kern_levels.h:5:18: warning: too many arguments for
> format [-Wformat-extra-args]
> ../drivers/acpi/acpi_fpdt.c:255:4: note: in expansion of macro
> 'pr_info'
>     pr_info(FW_BUG, "Invalid subtable type %d found.\n",
> 
> Fixes: 208757d71098 ("ACPI: tables: introduce support for FPDT
> table")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> Cc: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/acpi_fpdt.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20210128.orig/drivers/acpi/acpi_fpdt.c
> +++ linux-next-20210128/drivers/acpi/acpi_fpdt.c
> @@ -252,7 +252,7 @@ void acpi_init_fpdt(void)
>  					      subtable->type);
>  			break;
>  		default:
> -			pr_info(FW_BUG, "Invalid subtable type %d
> found.\n",
> +			pr_info(FW_BUG "Invalid subtable type %d
> found.\n",
>  			       subtable->type);
>  			return;
>  		}

