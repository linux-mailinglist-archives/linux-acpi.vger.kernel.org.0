Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79CFE3F10D4
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Aug 2021 04:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235700AbhHSC5g (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 18 Aug 2021 22:57:36 -0400
Received: from mga11.intel.com ([192.55.52.93]:62083 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235670AbhHSC5e (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 18 Aug 2021 22:57:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10080"; a="213351918"
X-IronPort-AV: E=Sophos;i="5.84,333,1620716400"; 
   d="scan'208";a="213351918"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2021 19:56:57 -0700
X-IronPort-AV: E=Sophos;i="5.84,333,1620716400"; 
   d="scan'208";a="521403027"
Received: from dhuo1-mobl.ccr.corp.intel.com ([10.249.169.197])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2021 19:56:55 -0700
Message-ID: <08895a6117ee6155f15764ad3fafae35b98b7ece.camel@intel.com>
Subject: Re: [PATCH 1/1] ACPI: tables: FPDT: Do not print FW_BUG message if
 subtable types are reserved
From:   Zhang Rui <rui.zhang@intel.com>
To:     Adrian Huang <adrianhuang0701@gmail.com>,
        linux-acpi@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Adrian Huang <ahuang12@lenovo.com>
Date:   Thu, 19 Aug 2021 10:56:53 +0800
In-Reply-To: <20210818063831.1349-1-adrianhuang0701@gmail.com>
References: <20210818063831.1349-1-adrianhuang0701@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 2021-08-18 at 14:38 +0800, Adrian Huang wrote:
> From: Adrian Huang <ahuang12@lenovo.com>
> 
> Table 5.90 "Runtime Performance Record Types" in ACPI 6.4 spec [1]
> says:
> 
>   These type values "0x0003-0xFFFF" of Runtime Performance Record
> Types
>   are reserved for ACPI spec usage, platform vendor usage, hardware
>   vendor usage, platform firmware vendor usage and future use.
> 
> Users might be confused with the FW_BUG message, and they think this
> is the FW issue. Here is the example in a Lenovo box:
> 
>   ACPI: FPDT 0x00000000A820A000 000044 (v01 LENOVO THINKSYS 00000100
> 01000013)
>   ACPI: Reserving FPDT table memory at [mem 0xa820a000-0xa820a043]
>   ACPI FPDT: [Firmware Bug]: Invalid record 4113 found
> 
> So, remove the FW_BUG message to avoid confusion since those subtable
> types are reserved in ACPI 6.4 spec.
> 
> [1] 
> https://uefi.org/specs/ACPI/6.4/05_ACPI_Software_Programming_Model/ACPI_Software_Programming_Model.html#firmware-performance-data-table-fpdt
> 

In 
https://uefi.org/specs/ACPI/6.4/05_ACPI_Software_Programming_Model/ACPI_Software_Programming_Model.html#fpdt-performance-record-types
it also mentions that "0x0002-0xFFFF" of FPDT Performance Record Types
are reserved, so it's better to fix them all in one patch?

thanks,
rui
> Cc: Zhang Rui <rui.zhang@intel.com>
> Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
> ---
>  drivers/acpi/acpi_fpdt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_fpdt.c b/drivers/acpi/acpi_fpdt.c
> index 4ee2ad234e3d..568f26a7490a 100644
> --- a/drivers/acpi/acpi_fpdt.c
> +++ b/drivers/acpi/acpi_fpdt.c
> @@ -220,8 +220,8 @@ static int fpdt_process_subtable(u64 address, u32
> subtable_type)
>  			break;
>  
>  		default:
> -			pr_err(FW_BUG "Invalid record %d found.\n",
> record_header->type);
> -			return -EINVAL;
> +			/* Other types are reserved in ACPI 6.4 spec.
> */
> +			break;
>  		}
>  	}
>  	return 0;

