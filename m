Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374D043B7E3
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Oct 2021 19:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235415AbhJZRIV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Oct 2021 13:08:21 -0400
Received: from mga02.intel.com ([134.134.136.20]:36431 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234147AbhJZRIV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 26 Oct 2021 13:08:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="217135873"
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="217135873"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 10:05:50 -0700
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="465385992"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 10:05:50 -0700
Date:   Tue, 26 Oct 2021 10:05:49 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        bp@alien8.de, james.morse@arm.com, lenb@kernel.org,
        rjw@rjwysocki.net, zhangliguang@linux.alibaba.com,
        zhuo.song@linux.alibaba.com
Subject: Re: [PATCH v3] ACPI, APEI, EINJ: Relax platform response timeout to
 1 second.
Message-ID: <YXg1bWBKja/tqScg@agluck-desk2.amr.corp.intel.com>
References: <20211015033817.16719-1-xueshuai@linux.alibaba.com>
 <20211026072829.94262-1-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026072829.94262-1-xueshuai@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Oct 26, 2021 at 03:28:29PM +0800, Shuai Xue wrote:
> When injecting an error into the platform, the OSPM executes an
> EXECUTE_OPERATION action to instruct the platform to begin the injection
> operation. And then, the OSPM busy waits for a while by continually
> executing CHECK_BUSY_STATUS action until the platform indicates that the
> operation is complete. More specifically, the platform is limited to
> respond within 1 millisecond right now. This is too strict for some
> platforms.
> 
> For example, in Arm platform, when injecting a Processor Correctable error,
> the OSPM will warn:
>     Firmware does not respond in time.
> 
> And a message is printed on the console:
>     echo: write error: Input/output error
> 
> We observe that the waiting time for DDR error injection is about 10 ms and
> that for PCIe error injection is about 500 ms in Arm platform.
> 
> In this patch, we relax the response timeout to 1 second.
> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>

Reviewed-by: Tony Luck <tony.luck@intel.com>

Rafael: Do you want to take this in the acpi tree? If not, I can
apply it to the RAS tree (already at -rc7, so in next merge cycle
after 5.16-rc1 comes out).

> ---
> Changelog v2 -> v3:
> - Implemented the timeout in usleep_range instead of msleep.
> - Dropped command line interface of timeout.
> - Link to the v1 patch: https://lkml.org/lkml/2021/10/14/1402
> ---
>  drivers/acpi/apei/einj.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
> index 133156759551..6e1ff4b62a8f 100644
> --- a/drivers/acpi/apei/einj.c
> +++ b/drivers/acpi/apei/einj.c
> @@ -28,9 +28,10 @@
>  #undef pr_fmt
>  #define pr_fmt(fmt) "EINJ: " fmt
>  
> -#define SPIN_UNIT		100			/* 100ns */
> -/* Firmware should respond within 1 milliseconds */
> -#define FIRMWARE_TIMEOUT	(1 * NSEC_PER_MSEC)
> +#define SLEEP_UNIT_MIN		1000			/* 1ms */
> +#define SLEEP_UNIT_MAX		5000			/* 5ms */
> +/* Firmware should respond within 1 seconds */
> +#define FIRMWARE_TIMEOUT	(1 * USEC_PER_SEC)
>  #define ACPI5_VENDOR_BIT	BIT(31)
>  #define MEM_ERROR_MASK		(ACPI_EINJ_MEMORY_CORRECTABLE | \
>  				ACPI_EINJ_MEMORY_UNCORRECTABLE | \
> @@ -171,13 +172,13 @@ static int einj_get_available_error_type(u32 *type)
>  
>  static int einj_timedout(u64 *t)
>  {
> -	if ((s64)*t < SPIN_UNIT) {
> +	if ((s64)*t < SLEEP_UNIT_MIN) {
>  		pr_warn(FW_WARN "Firmware does not respond in time\n");
>  		return 1;
>  	}
> -	*t -= SPIN_UNIT;
> -	ndelay(SPIN_UNIT);
> -	touch_nmi_watchdog();
> +	*t -= SLEEP_UNIT_MIN;
> +	usleep_range(SLEEP_UNIT_MIN, SLEEP_UNIT_MAX);
> +
>  	return 0;
>  }
>  
> -- 
> 2.20.1.12.g72788fdb
> 
