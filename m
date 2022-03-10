Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF844D4DB6
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Mar 2022 16:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbiCJP5f (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Mar 2022 10:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233562AbiCJP52 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Mar 2022 10:57:28 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB8515678B;
        Thu, 10 Mar 2022 07:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646927785; x=1678463785;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oGRk01Mtwpm/6J+nUOKWUFOoAtau2R/fmxlSMKuMYX8=;
  b=hou+ChIRnH6303niYy8IKBk0cdPWJoW3tU+Q/OTAvvxmStGBccwH86Xn
   uQXYNb1nxTNITvARGokKmDr0KuujTtQPqx8IDfAxsvtEYK80dTi3IbzP7
   zKkBLx/aWhi4gXDQR9bwJsGvR7IkVYHm96N1El8ln9qrchzjHU4lQe/Zl
   A/TzpQ+An+ODLJsKX9RqUo9e8DqVE5ZV+bp2zdpDvl7CbkrnCQWknxPAG
   IftDIyoTOTPxkd9AZNavejCcwVWtFmNFcPXa1W+nd6hq5rBDB3lm4OqSL
   cWvOT+Sux+k23zvrIhCNptxqXJiJpE9ZCJ/l2QPMacwNTdHLvgK0qMD7g
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="341712093"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="341712093"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 07:56:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="815872050"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 10 Mar 2022 07:56:10 -0800
Received: from ngpereir-MOBL.amr.corp.intel.com (unknown [10.212.217.28])
        by linux.intel.com (Postfix) with ESMTP id 8005758090C;
        Thu, 10 Mar 2022 07:56:10 -0800 (PST)
Message-ID: <c7f595c16e0d15aea53eb1562c8a2f17705f4e09.camel@linux.intel.com>
Subject: Re: [PATCH 1/4] ACPI / x86: Add support for LPS0 callback handler
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>, linux-acpi@vger.kernel.org
Date:   Thu, 10 Mar 2022 07:56:10 -0800
In-Reply-To: <20220310151705.577442-1-mario.limonciello@amd.com>
References: <20220310151705.577442-1-mario.limonciello@amd.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Mario,

On Thu, 2022-03-10 at 09:17 -0600, Mario Limonciello wrote:
> Currenty the latest thing run during a suspend to idle attempt is
> the LPS0 `prepare_late` callback and the earliest thing is the
> `resume_early` callback.
> 
> There is a desire for the `amd-pmc` driver to suspend later in the
> suspend process (ideally the very last thing), so create a callback
> that it or any other driver can hook into to do this.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/x86/s2idle.c | 76 ++++++++++++++++++++++++++++++++++++++-
>  include/linux/acpi.h      |  9 ++++-
>  2 files changed, 83 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index abc06e7f89d8..652dc2d75458 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -86,6 +86,16 @@ struct lpi_device_constraint_amd {
>  	int min_dstate;
>  };
>  
> +struct lps0_callback_handler {
> +	struct list_head list_node;
> +	int (*prepare_late_callback)(void *context);
> +	void (*restore_early_callback)(void *context);
> +	void *context;
> +};

Maybe put this in acpi.h

...


> +
> +static LIST_HEAD(lps0_callback_handler_head);
> +static DEFINE_MUTEX(lps0_callback_handler_mutex);
> +
>  static struct lpi_constraints *lpi_constraints_table;
>  static int lpi_constraints_table_size;
>  static int rev_id;
> @@ -444,6 +454,9 @@ static struct acpi_scan_handler lps0_handler = {
>  
>  int acpi_s2idle_prepare_late(void)
>  {
> +	struct lps0_callback_handler *handler;
> +	int rc = 0;
> +
>  	if (!lps0_device_handle || sleep_no_lps0)
>  		return 0;
>  
> @@ -474,14 +487,31 @@ int acpi_s2idle_prepare_late(void)
>  		acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_ENTRY,
>  				lps0_dsm_func_mask_microsoft,
> lps0_dsm_guid_microsoft);
>  	}
> -	return 0;
> +
> +	mutex_lock(&lps0_callback_handler_mutex);
> +	list_for_each_entry(handler, &lps0_callback_handler_head, list_node) {
> +		rc = handler->prepare_late_callback(handler->context);
> +		if (rc)
> +			goto out;
> +	}
> +out:
> +	mutex_unlock(&lps0_callback_handler_mutex);
> +
> +	return rc;
>  }
>  
>  void acpi_s2idle_restore_early(void)
>  {
> +	struct lps0_callback_handler *handler;
> +
>  	if (!lps0_device_handle || sleep_no_lps0)
>  		return;
>  
> +	mutex_lock(&lps0_callback_handler_mutex);
> +	list_for_each_entry(handler, &lps0_callback_handler_head, list_node)
> +		handler->restore_early_callback(handler->context);
> +	mutex_unlock(&lps0_callback_handler_mutex);
> +
>  	/* Modern standby exit */
>  	if (lps0_dsm_func_mask_microsoft > 0)
>  		acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_EXIT,
> @@ -524,4 +554,48 @@ void acpi_s2idle_setup(void)
>  	s2idle_set_ops(&acpi_s2idle_ops_lps0);
>  }
>  
> +int acpi_register_lps0_callbacks(int (*prepare_late)(void *context),
> +				 void (*restore_early)(void *context),
> +				 void *context)

... and just have "struct lps0_callback_handler *handler" be the argument here.

David

> +{
> +	struct lps0_callback_handler *handler;
> +
> +	if (!lps0_device_handle || sleep_no_lps0)
> +		return -ENODEV;
> +
> +	handler = kmalloc(sizeof(*handler), GFP_KERNEL);
> +	if (!handler)
> +		return -ENOMEM;
> +	handler->prepare_late_callback = prepare_late;
> +	handler->restore_early_callback = restore_early;
> +	handler->context = context;
> +
> +	mutex_lock(&lps0_callback_handler_mutex);
> +	list_add(&handler->list_node, &lps0_callback_handler_head);
> +	mutex_unlock(&lps0_callback_handler_mutex);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(acpi_register_lps0_callbacks);
> +
> +void acpi_unregister_lps0_callbacks(int (*prepare_late)(void *context),
> +				    void (*restore_early)(void *context),
> +				    void *context)
> +{
> +	struct lps0_callback_handler *handler;
> +
> +	mutex_lock(&lps0_callback_handler_mutex);
> +	list_for_each_entry(handler, &lps0_callback_handler_head, list_node) {
> +		if (handler->prepare_late_callback == prepare_late &&
> +		    handler->restore_early_callback == restore_early &&
> +		    handler->context == context) {
> +			list_del(&handler->list_node);
> +			kfree(handler);
> +			break;
> +		}
> +	}
> +	mutex_unlock(&lps0_callback_handler_mutex);
> +}
> +EXPORT_SYMBOL_GPL(acpi_unregister_lps0_callbacks);
> +
>  #endif /* CONFIG_SUSPEND */
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 6274758648e3..cae0fde309f2 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1023,7 +1023,14 @@ void acpi_os_set_prepare_extended_sleep(int (*func)(u8
> sleep_state,
>  
>  acpi_status acpi_os_prepare_extended_sleep(u8 sleep_state,
>  					   u32 val_a, u32 val_b);
> -
> +#ifdef CONFIG_X86
> +int acpi_register_lps0_callbacks(int (*prepare_late)(void *context),
> +				 void (*restore_early)(void *context),
> +				 void *context);
> +void acpi_unregister_lps0_callbacks(int (*prepare_late)(void *context),
> +				    void (*restore_early)(void *context),
> +				    void *context);
> +#endif /* CONFIG_X86 */
>  #ifndef CONFIG_IA64
>  void arch_reserve_mem_area(acpi_physical_address addr, size_t size);
>  #else

