Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37EA74D53C1
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Mar 2022 22:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239939AbiCJVor (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Mar 2022 16:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbiCJVoq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Mar 2022 16:44:46 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35772114FFF;
        Thu, 10 Mar 2022 13:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646948625; x=1678484625;
  h=message-id:subject:from:reply-to:to:cc:in-reply-to:
   references:mime-version:date:content-transfer-encoding;
  bh=XUapZ7Q6wJqYykO/dgmAlR+1FZT3PPjUZrZiDoyk/OQ=;
  b=WsPbEd8fF0eHIG+fVYwym7gvSA4T5sEd1jLNhBoDx1bR1G4xWPVRwY05
   V1PRtIAdc1RDdLGL1cZT99xH1OCBGN+7gaf71WggvCy2Ld25BcGNlhF9B
   ahbBbdBWG4/bPwk5hZbRvCwx8VkOokIiB6kTLN72Q4HDW87x7gc8WaE57
   virDdwBsMN7B7jLBdT2F5u1nc7IQ2LbXKGmHzK7N/A74xb0WvNJqMBdF6
   hyUehLsCfyiXzQ7c2WgF4591zLFeAmGOSxi83Cua+Lqr4qbCM8pFP71x9
   OJlYdOw19ph4tJmfA8oor8b9SKTbFxS8/WgqhZMLngsqqszvlc4KpAkHO
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="242835293"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="242835293"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 13:43:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="496425844"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 10 Mar 2022 13:43:44 -0800
Received: from smirmobi-mobl.amr.corp.intel.com (smirmobi-mobl.amr.corp.intel.com [10.212.177.154])
        by linux.intel.com (Postfix) with ESMTP id 98B0F580BF8;
        Thu, 10 Mar 2022 13:43:44 -0800 (PST)
Message-ID: <ece072c74b107d2327a12ca3d328b0e6e8d7d4e0.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/5] ACPI / x86: Add support for LPS0 callback
 handler
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>, linux-acpi@vger.kernel.org,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Goswami Sanket <Sanket.Goswami@amd.com>
In-Reply-To: <20220310191724.1440-1-mario.limonciello@amd.com>
References: <20220310191724.1440-1-mario.limonciello@amd.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Thu, 10 Mar 2022 13:43:25 -0800
User-Agent: Evolution 3.36.5-0ubuntu1 
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, 2022-03-10 at 13:17 -0600, Mario Limonciello wrote:
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
> changes from v1->v2:
>  * Change register/unregister arguments to be struct
> 
>  drivers/acpi/x86/s2idle.c | 65 ++++++++++++++++++++++++++++++++++++++-
>  include/linux/acpi.h      | 11 ++++++-
>  2 files changed, 74 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index abc06e7f89d8..7418443580d4 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -86,6 +86,9 @@ struct lpi_device_constraint_amd {
>  	int min_dstate;
>  };
>  
> +static LIST_HEAD(lps0_callback_handler_head);
> +static DEFINE_MUTEX(lps0_callback_handler_mutex);
> +
>  static struct lpi_constraints *lpi_constraints_table;
>  static int lpi_constraints_table_size;
>  static int rev_id;
> @@ -444,6 +447,9 @@ static struct acpi_scan_handler lps0_handler = {
>  
>  int acpi_s2idle_prepare_late(void)
>  {
> +	struct lps0_callback_handler *handler;
> +	int rc = 0;
> +
>  	if (!lps0_device_handle || sleep_no_lps0)
>  		return 0;
>  
> @@ -474,14 +480,31 @@ int acpi_s2idle_prepare_late(void)
>  		acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_ENTRY,
>  				lps0_dsm_func_mask_microsoft,
> lps0_dsm_guid_microsoft);
>  	}
> -	return 0;
> +
> +	mutex_lock(&lps0_callback_handler_mutex);
> +	list_for_each_entry(handler, &lps0_callback_handler_head, list_node) {
> +		rc = handler->prepare_late_callback(handler->context);

Check callback exists first. Sorry I missed earlier.

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

Here too.

David

> +	mutex_unlock(&lps0_callback_handler_mutex);
> +
>  	/* Modern standby exit */
>  	if (lps0_dsm_func_mask_microsoft > 0)
>  		acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_EXIT,
> @@ -524,4 +547,44 @@ void acpi_s2idle_setup(void)
>  	s2idle_set_ops(&acpi_s2idle_ops_lps0);
>  }
>  
> +int acpi_register_lps0_callbacks(struct lps0_callback_handler *arg)
> +{
> +	struct lps0_callback_handler *handler;
> +
> +	if (!lps0_device_handle || sleep_no_lps0)
> +		return -ENODEV;
> +
> +	handler = kmalloc(sizeof(*handler), GFP_KERNEL);
> +	if (!handler)
> +		return -ENOMEM;
> +	handler->prepare_late_callback = arg->prepare_late_callback;
> +	handler->restore_early_callback = arg->restore_early_callback;
> +	handler->context = arg->context;
> +
> +	mutex_lock(&lps0_callback_handler_mutex);
> +	list_add(&handler->list_node, &lps0_callback_handler_head);
> +	mutex_unlock(&lps0_callback_handler_mutex);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(acpi_register_lps0_callbacks);
> +
> +void acpi_unregister_lps0_callbacks(struct lps0_callback_handler *arg)
> +{
> +	struct lps0_callback_handler *handler;
> +
> +	mutex_lock(&lps0_callback_handler_mutex);
> +	list_for_each_entry(handler, &lps0_callback_handler_head, list_node) {
> +		if (handler->prepare_late_callback == arg->prepare_late_callback 
> &&
> +		    handler->restore_early_callback == arg-
> >restore_early_callback &&
> +		    handler->context == arg->context) {
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
> index 6274758648e3..df105f5e03e5 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1023,7 +1023,16 @@ void acpi_os_set_prepare_extended_sleep(int (*func)(u8
> sleep_state,
>  
>  acpi_status acpi_os_prepare_extended_sleep(u8 sleep_state,
>  					   u32 val_a, u32 val_b);
> -
> +#ifdef CONFIG_X86
> +struct lps0_callback_handler {
> +	struct list_head list_node;
> +	int (*prepare_late_callback)(void *context);
> +	void (*restore_early_callback)(void *context);
> +	void *context;
> +};
> +int acpi_register_lps0_callbacks(struct lps0_callback_handler *arg);
> +void acpi_unregister_lps0_callbacks(struct lps0_callback_handler *arg);
> +#endif /* CONFIG_X86 */
>  #ifndef CONFIG_IA64
>  void arch_reserve_mem_area(acpi_physical_address addr, size_t size);
>  #else

