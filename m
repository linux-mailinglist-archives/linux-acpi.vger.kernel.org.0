Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E37DA3085BC
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Jan 2021 07:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbhA2G0U (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 29 Jan 2021 01:26:20 -0500
Received: from mga14.intel.com ([192.55.52.115]:28869 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232029AbhA2G0M (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 29 Jan 2021 01:26:12 -0500
IronPort-SDR: PuQqDKsxs8Ewsv6+4ZAbokdax2st/X50Sb8lUKzUtlEPQUm1xIv6B00oTwwcBB1DeF593PTW7Q
 eJ4FM38NVgcw==
X-IronPort-AV: E=McAfee;i="6000,8403,9878"; a="179592728"
X-IronPort-AV: E=Sophos;i="5.79,384,1602572400"; 
   d="scan'208";a="179592728"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 22:25:32 -0800
IronPort-SDR: oX2YZrpx3tu7S/vNustT46zdvOeFhXKTRQeKDUMK0toKKPhTL5+OzUdO0FSbFNS2vm5PeJoPsn
 4+z4WxcpWcWQ==
X-IronPort-AV: E=Sophos;i="5.79,384,1602572400"; 
   d="scan'208";a="578942725"
Received: from chengpol-mobl1.ccr.corp.intel.com ([10.249.170.29])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 22:25:30 -0800
Message-ID: <0940484c3c64c3a6ba1e05f19f2d5137bc4fdcdf.camel@intel.com>
Subject: Re: [PATCH -next] ACPI: tables: Mark acpi_init_fpdt with static
 keyword
From:   Zhang Rui <rui.zhang@intel.com>
To:     Zou Wei <zou_wei@huawei.com>, rjw@rjwysocki.net, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 29 Jan 2021 14:25:28 +0800
In-Reply-To: <1611833479-87653-1-git-send-email-zou_wei@huawei.com>
References: <1611833479-87653-1-git-send-email-zou_wei@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi, Wei,

Thanks for the patch.

Given that there are a couple of things need to be fixed in the orignal
patch, I'd prefer to refresh the patch with all the fixes included

https://patchwork.kernel.org/project/linux-acpi/patch/20210129061548.13448-1-rui.zhang@intel.com/

what do you think?

thanks,
rui

On Thu, 2021-01-28 at 19:31 +0800, Zou Wei wrote:
> Fix the following sparse warning:
> 
> drivers/acpi/acpi_fpdt.c:230:6: warning: symbol 'acpi_init_fpdt' was
> not declared. Should it be static?
> 
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>  drivers/acpi/acpi_fpdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/acpi_fpdt.c b/drivers/acpi/acpi_fpdt.c
> index b810811..968f9cc 100644
> --- a/drivers/acpi/acpi_fpdt.c
> +++ b/drivers/acpi/acpi_fpdt.c
> @@ -227,7 +227,7 @@ static int fpdt_process_subtable(u64 address, u32
> subtable_type)
>  	return 0;
>  }
>  
> -void acpi_init_fpdt(void)
> +static void acpi_init_fpdt(void)
>  {
>  	acpi_status status;
>  	struct acpi_table_header *header;

