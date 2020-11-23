Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294192C1100
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Nov 2020 17:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387879AbgKWQpN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Nov 2020 11:45:13 -0500
Received: from mail-oo1-f65.google.com ([209.85.161.65]:47014 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732979AbgKWQpN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Nov 2020 11:45:13 -0500
Received: by mail-oo1-f65.google.com with SMTP id s11so3253742oov.13
        for <linux-acpi@vger.kernel.org>; Mon, 23 Nov 2020 08:45:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GkRNs8iuxJWIpoSGWBylXKcII9rd9UiaJ7g5QuMVLpk=;
        b=uNP7MigCwP/biQLwy0nJHXJ7rW97pwDLJQOgxPZZpuxyWEh5BdBWrWpG6bWbSWqCdI
         JA9J9X9jFPPcCvOmrxQsf1DmCq1wW9cwXafy1XB9tZshME3xVH0mprJbMukWL0gUBRRZ
         WWvJbD2hp3z//AC6XJtYgh5ZzPW/FFLFKJDFb933L+0Xk33Vu0dCmMyreApNGtFXRasz
         cGAPyMkSLuLPnuOWTZdE0XCX73F44WwrLIGjXCmmP73B4mOgyi1AquyPNF3SJ8D5tbpP
         o2hMnfPlNIAhEbmGjuWO6vn4tGRHbWt5N+IebYXT1uAVYSOoj7gXPD9NwytXQxX27G+q
         bM7Q==
X-Gm-Message-State: AOAM533pkYg55Bl+y32h+OT2mcC+xmvdG2P7YDPZtKR8rG0topTpJfig
        tuqdvB7ChKkz7KjZUW7cd4WbrxyHLH98pdjLat5tMGrmKxfGcA==
X-Google-Smtp-Source: ABdhPJxBSsEb2fqDNeD2NopCluvwwx2vzpwYMSPjLn3N1Ruy1isNWtm0/Imzc+/a39xY+r/rIy7S6EPFMuXMGoegzeM=
X-Received: by 2002:a4a:bb07:: with SMTP id f7mr157370oop.44.1606149912103;
 Mon, 23 Nov 2020 08:45:12 -0800 (PST)
MIME-Version: 1.0
References: <20201120060752.3146704-1-Shyam-sundar.S-k@amd.com>
In-Reply-To: <20201120060752.3146704-1-Shyam-sundar.S-k@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 23 Nov 2020 17:45:01 +0100
Message-ID: <CAJZ5v0jeoiZdgzKupakPn+82iur-nMLH3wEC07cHO1qyvoysug@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: PM: s2idle: Add AMD support to handle _DSM
 during S2Idle
To:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Nov 20, 2020 at 7:10 AM Shyam Sundar S K
<Shyam-sundar.S-k@amd.com> wrote:
>
> Initial support for S2Idle based on the Intel implementation [1] does not
> work for AMD as the BIOS implementation for ACPI methods like the _DSM
> are not standardized.
>
> So, the way in which the UUID's were parsed and the ACPI packages were
> retrieved out of the ACPI objects are not the same between Intel and AMD.
>
> This patch adds AMD support for S2Idle to parse the UUID, evaluate the
> _DSM methods, preparing the Idle constraint list etc.
>
> Link: https://uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S0_Idle.pdf # [1]
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> ---
> v2:(https://www.spinics.net/lists/linux-acpi/msg97104.html)
> - Remove default case in switch.
> - Add a routine acpi_match_vendor_name() required when building on a
>   non-x86 based environment.
> - Fixed spelling mistakes.
> ---
>  drivers/acpi/sleep.c | 166 ++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 157 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index aff13bf4d947..b929fd0d2e04 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -710,6 +710,11 @@ static const struct acpi_device_id lps0_device_ids[] = {
>  #define ACPI_LPS0_ENTRY                5
>  #define ACPI_LPS0_EXIT         6
>
> +/* AMD */
> +#define ACPI_LPS0_DSM_UUID_AMD      "e3f32452-febc-43ce-9039-932122d37721"
> +#define ACPI_LPS0_SCREEN_OFF_AMD    4
> +#define ACPI_LPS0_SCREEN_ON_AMD     5
> +
>  static acpi_handle lps0_device_handle;
>  static guid_t lps0_dsm_guid;
>  static char lps0_dsm_func_mask;
> @@ -733,8 +738,124 @@ struct lpi_constraints {
>         int min_dstate;
>  };
>
> +/* AMD */
> +/* Device constraint entry structure */
> +struct lpi_device_info_amd {
> +       int revision;
> +       int count;
> +       union acpi_object *package;
> +};
> +
> +/* Constraint package structure */
> +struct lpi_device_constraint_amd {
> +       char *name;
> +       int enabled;
> +       int function_states;
> +       int min_dstate;
> +};
> +
>  static struct lpi_constraints *lpi_constraints_table;
>  static int lpi_constraints_table_size;
> +static int rev_id;
> +
> +static void lpi_device_get_constraints_amd(void)
> +{
> +       union acpi_object *out_obj;
> +       int i, j, k;
> +
> +       out_obj = acpi_evaluate_dsm_typed(lps0_device_handle, &lps0_dsm_guid,
> +                                         1, ACPI_LPS0_GET_DEVICE_CONSTRAINTS,
> +                                         NULL, ACPI_TYPE_PACKAGE);
> +
> +       if (!out_obj)
> +               return;
> +
> +       acpi_handle_debug(lps0_device_handle, "_DSM function 1 eval %s\n",
> +                         out_obj ? "successful" : "failed");
> +
> +       for (i = 0; i < out_obj->package.count; i++) {
> +               union acpi_object *package = &out_obj->package.elements[i];
> +               struct lpi_device_info_amd info = { };
> +
> +               if (package->type == ACPI_TYPE_INTEGER) {
> +                       switch (i) {
> +                       case 0:
> +                               info.revision = package->integer.value;
> +                               break;
> +                       case 1:
> +                               info.count = package->integer.value;
> +                               break;
> +                       }
> +               } else if (package->type == ACPI_TYPE_PACKAGE) {
> +                       lpi_constraints_table = kcalloc(package->package.count,
> +                                                       sizeof(*lpi_constraints_table),
> +                                                       GFP_KERNEL);
> +
> +                       if (!lpi_constraints_table)
> +                               goto free_acpi_buffer;
> +
> +                       acpi_handle_info(lps0_device_handle,
> +                                        "LPI: constraints list begin:\n");
> +
> +                       for (j = 0; j < package->package.count; ++j) {
> +                               union acpi_object *info_obj = &package->package.elements[j];
> +                               struct lpi_device_constraint_amd dev_info = {};
> +                               struct lpi_constraints *list;
> +                               acpi_status status;
> +
> +                               for (k = 0; k < info_obj->package.count; ++k) {
> +                                       union acpi_object *obj = &info_obj->package.elements[k];
> +                                       union acpi_object *obj_new;
> +
> +                                       list = &lpi_constraints_table[lpi_constraints_table_size];
> +                                       list->min_dstate = -1;
> +
> +                                       obj_new = &obj[k];
> +                                       switch (k) {
> +                                       case 0:
> +                                               dev_info.enabled = obj->integer.value;
> +                                               break;
> +                                       case 1:
> +                                               dev_info.name = obj->string.pointer;
> +                                               break;
> +                                       case 2:
> +                                               dev_info.function_states = obj->integer.value;
> +                                               break;
> +                                       case 3:
> +                                               dev_info.min_dstate = obj->integer.value;
> +                                               break;
> +                                       }
> +
> +                                       if (!dev_info.enabled || !dev_info.name ||
> +                                           !dev_info.min_dstate)
> +                                               continue;
> +
> +                                       status = acpi_get_handle(NULL, dev_info.name,
> +                                                                &list->handle);
> +                                       if (ACPI_FAILURE(status))
> +                                               continue;
> +
> +                                       acpi_handle_info(lps0_device_handle,
> +                                                        "Name:%s\n", dev_info.name);
> +
> +                                       list->min_dstate = dev_info.min_dstate;
> +
> +                                       if (list->min_dstate < 0) {
> +                                               acpi_handle_info(lps0_device_handle,
> +                                                                "Incomplete constraint defined\n");
> +                                               continue;
> +                                       }
> +                               }
> +                               lpi_constraints_table_size++;
> +                       }
> +               }
> +       }
> +
> +       acpi_handle_info(lps0_device_handle, "LPI: constraints list end\n");
> +
> +free_acpi_buffer:
> +       ACPI_FREE(out_obj);
> +}
>
>  static void lpi_device_get_constraints(void)
>  {
> @@ -883,13 +1004,22 @@ static void acpi_sleep_run_lps0_dsm(unsigned int func)
>         if (!(lps0_dsm_func_mask & (1 << func)))
>                 return;
>
> -       out_obj = acpi_evaluate_dsm(lps0_device_handle, &lps0_dsm_guid, 1, func, NULL);
> +       out_obj = acpi_evaluate_dsm(lps0_device_handle, &lps0_dsm_guid, rev_id, func, NULL);
>         ACPI_FREE(out_obj);
>
>         acpi_handle_debug(lps0_device_handle, "_DSM function %u evaluation %s\n",
>                           func, out_obj ? "successful" : "failed");
>  }
>
> +static bool acpi_match_vendor_name(void)
> +{
> +#ifdef CONFIG_X86
> +       if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
> +               return true;
> +#endif
> +       return false;
> +}

Well, I still don't like this (explicit CONFIG_X86 dependencies are
not welcome in this file), but arguably the damage was done before
already and there is a bunch of X86-specific code in here anyway, so
I'm going to take your patch provisionally and rearrange the code on
top of it so as to relocate the x86-specific part of it into
acpi/x86/.

Thanks!
