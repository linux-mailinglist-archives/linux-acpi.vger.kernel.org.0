Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BB74DCBA8
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Mar 2022 17:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236636AbiCQQrP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Mar 2022 12:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236631AbiCQQrO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Mar 2022 12:47:14 -0400
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB99193225;
        Thu, 17 Mar 2022 09:45:57 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id j2so11397371ybu.0;
        Thu, 17 Mar 2022 09:45:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s5jFdMvgfNxeKGN+U4Na8gA95VLXfz1VhA8KORiGYEY=;
        b=Ru1l8B+Gf4ww0JEzQRNeoHhiVeJDSkIpdq4NuK/RVyBs++XLbXSFE9VrmiyC/Fhnwi
         ve2Ka45+UeTiFj34mjd3+Nva3z1kZ5p4OGunJi8LAWxOFh40mFza88azgzst2sVf5m2g
         SuH/KVAwiBWX+f+o9Aj2IHZvzC3MOy1fPOWYCApMDCZJ2MNGPP+wP7y8DTpqGAL4CclQ
         PRRxBbKWXfO/a9lJI9YTSYy6G5QyjkLnMOwu6n7sbFkUYPVa777kEoEWu9UzQ2xdtW58
         K5sAkxX7RlQiVNj8JduUmZcQWKJfjrd+E/ZigwsBg0uCEgZw1lpN5JxWc8vEBfYkADMW
         ViLw==
X-Gm-Message-State: AOAM533wnUjFFQuStvsSucORc3oI3+OWUuysEiKNEjh0c0pzx5EDrSKX
        wi/RqqmcQ9+2d0IyuxWlL8G3zxFk1OhbmGz1W3MAmBSP
X-Google-Smtp-Source: ABdhPJzmSFaKCkBq/4JR8cm9NzRlCmeMXxRalgGPfzsLh+nQjnSyEh/Clv6LsJuDTrjQkxKA9AoNCNBmx+y5dOKc+aA=
X-Received: by 2002:a25:bbc1:0:b0:610:b4ce:31db with SMTP id
 c1-20020a25bbc1000000b00610b4ce31dbmr5986647ybk.482.1647535557162; Thu, 17
 Mar 2022 09:45:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220317141445.6498-1-mario.limonciello@amd.com>
In-Reply-To: <20220317141445.6498-1-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Mar 2022 17:45:46 +0100
Message-ID: <CAJZ5v0hNKmXWJ5uNaAFWsDkBm7FpKexkx5sCFHvx=OBJdVt+aA@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] ACPI / x86: Add support for LPS0 callback handler
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Goswami Sanket <Sanket.Goswami@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Mar 17, 2022 at 3:15 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Currenty the latest thing run during a suspend to idle attempt is
> the LPS0 `prepare_late` callback and the earliest thing is the
> `resume_early` callback.
>
> There is a desire for the `amd-pmc` driver to suspend later in the
> suspend process (ideally the very last thing), so create a callback
> that it or any other driver can hook into to do this.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

This looks good to me, so:

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

and I don't have any conflicting changes queued up for 5.17, so from
my POV it can go in via the x86 platform drivers tree along with the
other patches in the series.

> ---
> changes from v4->v5:
> * fix a check for handler->prepare
>   Reported by Dan Carpenter <dan.carpenter@oracle.com>
> changes from v3->v4:
> * drop use of mutex, use lock_system_sleep instead
> * don't pass argument of context, driver will maintain this internally
> * don't allow failing prepare stage
> * don't allow unregistering if sleep_no_lps0 is set
> changes from v2->v3:
> * Check that callbacks exist before calling
> changes from v1->v2:
> * Change register/unregister arguments to be struct
>
>  drivers/acpi/x86/s2idle.c | 40 +++++++++++++++++++++++++++++++++++++++
>  include/linux/acpi.h      | 10 +++++++++-
>  2 files changed, 49 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index abc06e7f89d8..031b20a547f9 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -86,6 +86,8 @@ struct lpi_device_constraint_amd {
>         int min_dstate;
>  };
>
> +static LIST_HEAD(lps0_s2idle_devops_head);
> +
>  static struct lpi_constraints *lpi_constraints_table;
>  static int lpi_constraints_table_size;
>  static int rev_id;
> @@ -444,6 +446,8 @@ static struct acpi_scan_handler lps0_handler = {
>
>  int acpi_s2idle_prepare_late(void)
>  {
> +       struct acpi_s2idle_dev_ops *handler;
> +
>         if (!lps0_device_handle || sleep_no_lps0)
>                 return 0;
>
> @@ -474,14 +478,26 @@ int acpi_s2idle_prepare_late(void)
>                 acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_ENTRY,
>                                 lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
>         }
> +
> +       list_for_each_entry(handler, &lps0_s2idle_devops_head, list_node) {
> +               if (handler->prepare)
> +                       handler->prepare();
> +       }
> +
>         return 0;
>  }
>
>  void acpi_s2idle_restore_early(void)
>  {
> +       struct acpi_s2idle_dev_ops *handler;
> +
>         if (!lps0_device_handle || sleep_no_lps0)
>                 return;
>
> +       list_for_each_entry(handler, &lps0_s2idle_devops_head, list_node)
> +               if (handler->restore)
> +                       handler->restore();
> +
>         /* Modern standby exit */
>         if (lps0_dsm_func_mask_microsoft > 0)
>                 acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_EXIT,
> @@ -524,4 +540,28 @@ void acpi_s2idle_setup(void)
>         s2idle_set_ops(&acpi_s2idle_ops_lps0);
>  }
>
> +int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *arg)
> +{
> +       if (!lps0_device_handle || sleep_no_lps0)
> +               return -ENODEV;
> +
> +       lock_system_sleep();
> +       list_add(&arg->list_node, &lps0_s2idle_devops_head);
> +       unlock_system_sleep();
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(acpi_register_lps0_dev);
> +
> +void acpi_unregister_lps0_dev(struct acpi_s2idle_dev_ops *arg)
> +{
> +       if (!lps0_device_handle || sleep_no_lps0)
> +               return;
> +
> +       lock_system_sleep();
> +       list_del(&arg->list_node);
> +       unlock_system_sleep();
> +}
> +EXPORT_SYMBOL_GPL(acpi_unregister_lps0_dev);
> +
>  #endif /* CONFIG_SUSPEND */
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 6274758648e3..47c16cdc8e0e 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1023,7 +1023,15 @@ void acpi_os_set_prepare_extended_sleep(int (*func)(u8 sleep_state,
>
>  acpi_status acpi_os_prepare_extended_sleep(u8 sleep_state,
>                                            u32 val_a, u32 val_b);
> -
> +#ifdef CONFIG_X86
> +struct acpi_s2idle_dev_ops {
> +       struct list_head list_node;
> +       void (*prepare)(void);
> +       void (*restore)(void);
> +};
> +int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *arg);
> +void acpi_unregister_lps0_dev(struct acpi_s2idle_dev_ops *arg);
> +#endif /* CONFIG_X86 */
>  #ifndef CONFIG_IA64
>  void arch_reserve_mem_area(acpi_physical_address addr, size_t size);
>  #else
> --
> 2.34.1
>
