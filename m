Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABC7630427
	for <lists+linux-acpi@lfdr.de>; Thu, 30 May 2019 23:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbfE3VxJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Thu, 30 May 2019 17:53:09 -0400
Received: from mga18.intel.com ([134.134.136.126]:1199 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbfE3VxJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 30 May 2019 17:53:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 May 2019 14:44:00 -0700
X-ExtLoop1: 1
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by fmsmga007.fm.intel.com with ESMTP; 30 May 2019 14:43:57 -0700
Received: from orsmsx124.amr.corp.intel.com (10.22.240.120) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 30 May 2019 14:43:57 -0700
Received: from orsmsx121.amr.corp.intel.com ([169.254.10.47]) by
 ORSMSX124.amr.corp.intel.com ([169.254.2.120]) with mapi id 14.03.0415.000;
 Thu, 30 May 2019 14:43:57 -0700
From:   "Schmauss, Erik" <erik.schmauss@intel.com>
To:     Hedi Berriche <hedi.berriche@hpe.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Russ Anderson <rja@hpe.com>, Mike Travis <mike.travis@hpe.com>,
        "Frank Ramsay" <frank.ramsay@hpe.com>,
        "Moore, Robert" <robert.moore@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Subject: RE: [Patch] ACPICA: Increase AE_OWNER_ID_LIMIT to 2047
Thread-Topic: [Patch] ACPICA: Increase AE_OWNER_ID_LIMIT to 2047
Thread-Index: AQHVFw9415tu17mJcEeDzTkGohyRuKaELwvg
Date:   Thu, 30 May 2019 21:43:56 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED53C5D61F7@ORSMSX121.amr.corp.intel.com>
References: <20190530174504.17172-1-hedi.berriche@hpe.com>
In-Reply-To: <20190530174504.17172-1-hedi.berriche@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOWViZjg2NDctM2U2MC00ZTM3LWJiZmYtMDlhNTZjYTljYzUwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiMVd1XC9XNldvdGVENXNnUGtvZ0VUd2NjdFNOaTQrTnAzb1FRN0JrWFBBUTJGRnAyZjU1dWZMeDBvS1NsUnVhRncifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Hedi Berriche [mailto:hedi.berriche@hpe.com]
> Sent: Thursday, May 30, 2019 10:45 AM
> To: linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Hedi Berriche <hedi.berriche@hpe.com>; Russ Anderson
> <rja@hpe.com>; Mike Travis <mike.travis@hpe.com>; Frank Ramsay
> <frank.ramsay@hpe.com>; Moore, Robert <robert.moore@intel.com>;
> Schmauss, Erik <erik.schmauss@intel.com>; Wysocki, Rafael J
> <rafael.j.wysocki@intel.com>
> Subject: [Patch] ACPICA: Increase AE_OWNER_ID_LIMIT to 2047
> 
> 32 sockets systems with 192 NVDIMMs run into the ACPI_OWNER_ID_MAX
> limit which is currently set to 255, and nfit kernel module initialisation fails
> with the following representative error messages:
> 
> ACPI Error: Could not allocate new OwnerId (255 max), AE_OWNER_ID_LIMIT
> (20170303/utownerid-149 ACPI Error: Method parse/execution failed
> [\_SB.NVDR.N031.PCDR] (Node ffff9e2fffd8e280), AE_OWNER_ID_LIMIT
> (20170303/psparse-543) ACPI Error: Method parse/execution failed
> [\_SB.NVDR.N031.CR05] (Node ffff9547ffd91bb8), AE_OWNER_ID_LIMIT
> (20170303/psparse-543) ACPI Error: Method parse/execution failed
> [\_SB.NVDR.N031.CRLD] (Node ffff8e99ffd92550), AE_OWNER_ID_LIMIT
> (20170303/psparse-543) ACPI Error: Method parse/execution failed
> [\_SB.NVDR.N031._DSM] (Node ffffadc5ffd90e88), AE_OWNER_ID_LIMIT
> (20170303/psparse-543)
> ACPI: \_SB_.NVDR.N031: failed to evaluate _DSM (0x1b)
> 
Hi,

> Further debugging shows that, on such a system, we end up using 1020
> owner IDs, hence I'm suggesting that we bump ACPI_OWNER_ID_MAX up to
> 2047.

Owner ID's increment for each ACPI table and for each control method invocation (and decreases after the method exits).
How are you using 1020 owner ID's? 

How many nested control methods does \_SB_.NVDR.N031._DSM invoke?
How many SSDT's does this machine have?

More comments below.

> 
> Signed-off-by: Hedi Berriche <hedi.berriche@hpe.com>
> Cc: Russ Anderson <rja@hpe.com>
> Cc: Mike Travis <mike.travis@hpe.com>
> Cc: Frank Ramsay <frank.ramsay@hpe.com>
> Cc: Robert Moore <robert.moore@intel.com>
> Cc: Erik Schmauss <erik.schmauss@intel.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/acpica/utownerid.c | 6 +++---
>  include/acpi/acconfig.h         | 4 ++--
>  include/acpi/actypes.h          | 4 ++--
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/acpi/acpica/utownerid.c
> b/drivers/acpi/acpica/utownerid.c index 5eb8b76ce9d8..c015a2c147d9
> 100644
> --- a/drivers/acpi/acpica/utownerid.c
> +++ b/drivers/acpi/acpica/utownerid.c
> @@ -88,7 +88,7 @@ acpi_status acpi_ut_allocate_owner_id(acpi_owner_id
> *owner_id)
>  				/*
>  				 * Construct encoded ID from the index and
> bit position
>  				 *
> -				 * Note: Last [j].k (bit 255) is never used and
> is marked
> +				 * Note: Last [j].k (bit 2047) is never used and
> is marked
>  				 * permanently allocated (prevents +1
> overflow)
>  				 */
>  				*owner_id =
> @@ -116,7 +116,7 @@ acpi_status
> acpi_ut_allocate_owner_id(acpi_owner_id *owner_id)
>  	 */
>  	status = AE_OWNER_ID_LIMIT;
>  	ACPI_ERROR((AE_INFO,
> -		    "Could not allocate new OwnerId (255 max),
> AE_OWNER_ID_LIMIT"));
> +		    "Could not allocate new OwnerId (2047 max),
> AE_OWNER_ID_LIMIT"));
> 
>  exit:
>  	(void)acpi_ut_release_mutex(ACPI_MTX_CACHES);
> @@ -133,7 +133,7 @@ acpi_status
> acpi_ut_allocate_owner_id(acpi_owner_id *owner_id)
>   *              control method or unloading a table. Either way, we would
>   *              ignore any error anyway.
>   *
> - * DESCRIPTION: Release a table or method owner ID. Valid IDs are 1 - 255
> + * DESCRIPTION: Release a table or method owner ID. Valid IDs are 1 -
> + 2047
>   *
> 
> **********************************************************
> ********************/
> 
> diff --git a/include/acpi/acconfig.h b/include/acpi/acconfig.h index
> 16a83959e616..536fe9a81cb7 100644
> --- a/include/acpi/acconfig.h
> +++ b/include/acpi/acconfig.h
> @@ -95,9 +95,9 @@
> 
>  #define ACPI_DEFAULT_PAGE_SIZE          4096	/* Must be power of 2 */
> 
> -/* owner_id tracking. 8 entries allows for 255 owner_ids */
> +/* owner_id tracking. 64 entries allow for 2047 owner_ids */
> 
> -#define ACPI_NUM_OWNERID_MASKS          8
> +#define ACPI_NUM_OWNERID_MASKS          64
> 
>  /* Size of the root table array is increased by this increment */
> 
> diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h index
> ad6892a24015..f32a4d49ea13 100644
> --- a/include/acpi/actypes.h
> +++ b/include/acpi/actypes.h
> @@ -442,8 +442,8 @@ typedef void *acpi_handle;	/* Actually a ptr to a
> NS Node */
> 
>  /* Owner IDs are used to track namespace nodes for selective deletion */
> 
> -typedef u8 acpi_owner_id;
> -#define ACPI_OWNER_ID_MAX               0xFF
> +typedef u16 acpi_owner_id;
> +#define ACPI_OWNER_ID_MAX               0x7FF

Why 0x7ff?
Why not just go to 0xFFFF?

Thanks,
Erik
> 
>  #define ACPI_INTEGER_BIT_SIZE           64
>  #define ACPI_MAX_DECIMAL_DIGITS         20	/* 2^64 =
> 18,446,744,073,709,551,616 */
> --
> 2.20.1

