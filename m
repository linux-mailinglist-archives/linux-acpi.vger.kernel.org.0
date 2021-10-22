Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 735504380C4
	for <lists+linux-acpi@lfdr.de>; Sat, 23 Oct 2021 01:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbhJVX5K (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Oct 2021 19:57:10 -0400
Received: from mga09.intel.com ([134.134.136.24]:12632 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231820AbhJVX5J (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 22 Oct 2021 19:57:09 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10145"; a="229276938"
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="229276938"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 16:54:51 -0700
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="576908780"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 16:54:50 -0700
Date:   Fri, 22 Oct 2021 16:54:49 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        bp@alien8.de, james.morse@arm.com, lenb@kernel.org,
        rjw@rjwysocki.net, zhangliguang@linux.alibaba.com,
        zhuo.song@linux.alibaba.com
Subject: Re: [PATCH v2] ACPI, APEI, EINJ: Relax platform response timeout to
 1 second.
Message-ID: <YXNPSQT9LnxiyVFC@agluck-desk2.amr.corp.intel.com>
References: <20211015033817.16719-1-xueshuai@linux.alibaba.com>
 <20211022134424.67279-1-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022134424.67279-1-xueshuai@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 22, 2021 at 09:44:24PM +0800, Shuai Xue wrote:
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
> We observe that the waiting time for DDR error injection is about 10 ms
> and that for PCIe error injection is about 500 ms in Arm platform.
> 
> In this patch, we relax the response timeout to 1 second and allow user to
> pass the time out value as a argument.
> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> ---
> Changelog v1 -> v2:
> - Implemented the timeout in msleep instead of udelay.
> - Link to the v1 patch: https://lkml.org/lkml/2021/10/14/1402
> ---
>  drivers/acpi/apei/einj.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
> index 133156759551..e411eb30e0ee 100644
> --- a/drivers/acpi/apei/einj.c
> +++ b/drivers/acpi/apei/einj.c
> @@ -28,9 +28,9 @@
>  #undef pr_fmt
>  #define pr_fmt(fmt) "EINJ: " fmt
>  
> -#define SPIN_UNIT		100			/* 100ns */
> -/* Firmware should respond within 1 milliseconds */
> -#define FIRMWARE_TIMEOUT	(1 * NSEC_PER_MSEC)
> +#define SLEEP_UNIT		1			/* 1ms */

I know I pointed you to msleep() ... sorry, I was wrong. For a
1 ms sleep the recommendation is to use usleep_range()

See this write-up in Documentation/timers/timers-howto.rst:

                - Why not msleep for (1ms - 20ms)?
                        Explained originally here:
                                https://lore.kernel.org/r/15327.1186166232@lwn.net

                        msleep(1~20) may not do what the caller intends, and
                        will often sleep longer (~20 ms actual sleep for any
                        value given in the 1~20ms range). In many cases this
                        is not the desired behavior.

To answer the question posed in that document on "What is a good range?"

I don't think injection cares too much about precision here. Maybe go
with

	usleep_range(1000, 5000);
[with #defines for SLEEP_UNIT_MIN, SLEEP_UNIT_MAX instead of those
numbers]

> +/* Firmware should respond within 1 seconds */
> +#define FIRMWARE_TIMEOUT	(1 * MSEC_PER_SEC)
>  #define ACPI5_VENDOR_BIT	BIT(31)
>  #define MEM_ERROR_MASK		(ACPI_EINJ_MEMORY_CORRECTABLE | \
>  				ACPI_EINJ_MEMORY_UNCORRECTABLE | \
> @@ -40,6 +40,8 @@
>   * ACPI version 5 provides a SET_ERROR_TYPE_WITH_ADDRESS action.
>   */
>  static int acpi5;
> +static int timeout_default = FIRMWARE_TIMEOUT;
> +module_param(timeout_default, int, 0644);

You've set the default to 1 second. Who would use this parameter?
Do you anticipate systems that take even longer to inject?
A user might set a shorter limit ... but I don't see why they
would want to.

>  
>  struct set_error_type_with_address {
>  	u32	type;
> @@ -171,12 +173,12 @@ static int einj_get_available_error_type(u32 *type)
>  
>  static int einj_timedout(u64 *t)
>  {
> -	if ((s64)*t < SPIN_UNIT) {
> +	if ((s64)*t < SLEEP_UNIT) {
>  		pr_warn(FW_WARN "Firmware does not respond in time\n");
>  		return 1;
>  	}
> -	*t -= SPIN_UNIT;
> -	ndelay(SPIN_UNIT);
> +	*t -= SLEEP_UNIT;
> +	msleep(SLEEP_UNIT);
>  	touch_nmi_watchdog();

Since we are sleeping instead of spinning, maybe we don't need to
touch the nmi watchdog?

>  	return 0;
>  }
> @@ -403,7 +405,7 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>  			       u64 param3, u64 param4)
>  {
>  	struct apei_exec_context ctx;
> -	u64 val, trigger_paddr, timeout = FIRMWARE_TIMEOUT;
> +	u64 val, trigger_paddr, timeout = timeout_default;
>  	int rc;
>  
>  	einj_exec_ctx_init(&ctx);
> -- 
> 2.20.1.12.g72788fdb
> 

-Tony
