Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2A43F14D4
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Aug 2021 10:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236988AbhHSIIj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 Aug 2021 04:08:39 -0400
Received: from mga18.intel.com ([134.134.136.126]:61940 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236766AbhHSIIi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 19 Aug 2021 04:08:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10080"; a="203655708"
X-IronPort-AV: E=Sophos;i="5.84,334,1620716400"; 
   d="scan'208";a="203655708"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 01:08:01 -0700
X-IronPort-AV: E=Sophos;i="5.84,334,1620716400"; 
   d="scan'208";a="522340689"
Received: from dhuo1-mobl.ccr.corp.intel.com ([10.249.169.197])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 01:08:00 -0700
Message-ID: <43a0b67b4412c617778a6a30ededd5c042b9a554.camel@intel.com>
Subject: Re: [PATCH v2 1/1] ACPI: tables: FPDT: Do not print FW_BUG message
 if record types are reserved
From:   Zhang Rui <rui.zhang@intel.com>
To:     Adrian Huang <adrianhuang0701@gmail.com>,
        linux-acpi@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Adrian Huang <ahuang12@lenovo.com>
Date:   Thu, 19 Aug 2021 16:07:57 +0800
In-Reply-To: <20210819071416.14975-1-adrianhuang0701@gmail.com>
References: <20210819071416.14975-1-adrianhuang0701@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, 2021-08-19 at 15:14 +0800, Adrian Huang wrote:
> From: Adrian Huang <ahuang12@lenovo.com>
> 
> In ACPI 6.4 spec, record types "0x0002-0xffff" of FPDT Performance
> Record
> Types [1] and record types "0x0003-0xffff" of Runtime Performance
> Record
> Types [2] are reserved.
> 
> Users might be confused with the FW_BUG message, and they think this
> is the FW issue. Here is the example in a Lenovo box:
> 
>   ACPI: FPDT 0x00000000A820A000 000044 (v01 LENOVO THINKSYS 00000100
> 01000013)
>   ACPI: Reserving FPDT table memory at [mem 0xa820a000-0xa820a043]
>   ACPI FPDT: [Firmware Bug]: Invalid record 4113 found
> 
> So, remove the FW_BUG message to avoid confusion since those types
> are
> reserved in ACPI 6.4 spec.
> 
> [1] 
> https://uefi.org/specs/ACPI/6.4/05_ACPI_Software_Programming_Model/ACPI_Software_Programming_Model.html#fpdt-performance-record-types-table
> [2] 
> https://uefi.org/specs/ACPI/6.4/05_ACPI_Software_Programming_Model/ACPI_Software_Programming_Model.html#runtime-performance-record-types-table
> 
> Cc: Zhang Rui <rui.zhang@intel.com>
> Signed-off-by: Adrian Huang <ahuang12@lenovo.com>

Acked-by: Zhang Rui <rui.zhang@intel.com>

thanks,
rui
> ---
> 
> Changes since v2:
>  * Fix "0x0002-0xFFFF" of FPDT Performance Record Types, per Rui
> 
>  drivers/acpi/acpi_fpdt.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_fpdt.c b/drivers/acpi/acpi_fpdt.c
> index 4ee2ad234e3d..6922a44b3ce7 100644
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
> @@ -254,8 +254,7 @@ static int __init acpi_init_fpdt(void)
>  					      subtable->type);
>  			break;
>  		default:
> -			pr_info(FW_BUG "Invalid subtable type %d
> found.\n",
> -			       subtable->type);
> +			/* Other types are reserved in ACPI 6.4 spec.
> */
>  			break;
>  		}
>  		offset += sizeof(*subtable);

