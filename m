Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF1C2B4EFA
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Nov 2020 19:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbgKPSQZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Nov 2020 13:16:25 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41331 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730096AbgKPSQY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Nov 2020 13:16:24 -0500
Received: by mail-ot1-f68.google.com with SMTP id o3so6382632ota.8
        for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2020 10:16:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=legnyHyNkddsSoEooIyRtm4FtPu0MkiFReJC8nOTp4Y=;
        b=jUe6ZeztRc2NusPuN/udtYAdkY/7LImJCsmPooqRhGSKicSv90hslaaLzyGkusNZ/q
         tkOnC6ODfBML2gWK7RKX74faDilo2fO+UoZlw2801tLbTE4AAJqevgHQFmdqitpjgt/e
         lXwBZfhMXcz/PKx6xznkXn7wmRIyXIsfbpyvOmbUcYcBP17+vPdT899tbJV7SiWzGXUb
         O4tIP26XCR0L5IQrYA6o47qs4yFdgTvKDi5Qe5qMVEmVThvmKiy7z/RJcrsrydKIKj/J
         mfKFthA5YCg4XVYRBROIGrFjlq4fdBjMcpciEKmbJ0Dfj8fnYzXfFxkPkwsNUBDpWPjX
         Qgpw==
X-Gm-Message-State: AOAM531icEmSKhlmQnazP0AT+RG6CMkyZGovizAVPT0UrZ+BdYS3POdG
        uFMENcWA2JmuTv0OXS82k6Y37j643aVdKeq7UFc=
X-Google-Smtp-Source: ABdhPJxnaJBVAiAB9wIaYAuxC3ySzvJThspKg+Nv+UeqzxPpTthnyt0szr1EFL43AzjXNIAVJ+/INmw5txhSBYg9XNU=
X-Received: by 2002:a9d:171a:: with SMTP id i26mr421154ota.260.1605550582053;
 Mon, 16 Nov 2020 10:16:22 -0800 (PST)
MIME-Version: 1.0
References: <20201023080315.458570-1-Shyam-sundar.S-k@amd.com>
In-Reply-To: <20201023080315.458570-1-Shyam-sundar.S-k@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 16 Nov 2020 19:16:10 +0100
Message-ID: <CAJZ5v0jKaKSHZdM_Bz9Y9EFg9yfhRJLbktsCbpxhW+rS90mg3Q@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PM: s2idle: Add AMD support to handle _DSM during S2Idle
To:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 23, 2020 at 10:04 AM Shyam Sundar S K
<Shyam-sundar.S-k@amd.com> wrote:
>
> Initial support for S2Idle based on the Intel implementation[1] does not
> work for AMD as the BIOS implementation for ACPI methods like the _DSM
> are not standardized.
>
> So, the way in which the UUID's were parsed and the ACPI packages were
> retrieved out of the ACPI objects are not the same between Intel and AMD.
>
> This patch adds AMD support for S2Idle to parse the UUID, evaluate the
> _DSM methods, preparing the Idle constaint list etc.

constraint

> Link: https://uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S0_Idle.pdf # [1]
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> ---
>  drivers/acpi/sleep.c | 166 ++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 158 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index aff13bf4d947..a36b4ddcd1e9 100644
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
> @@ -733,8 +738,128 @@ struct lpi_constraints {
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
> +       acpi_handle_info(lps0_device_handle, "_DSM function 1 eval %s\n",
> +                        out_obj ? "successful" : "failed");

The existing lpi_device_get_constraints() uses acpi_handle_debug().

Why is it necessary to use acpi_handle_info() here?

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
> +                       default:
> +                               break;

Not needed AFAICS.

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
> +                                       default:
> +                                               break;

Likewise.

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
> +                                                        "index:%d Name:%s\n", k, dev_info.name);
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
> @@ -883,7 +1008,7 @@ static void acpi_sleep_run_lps0_dsm(unsigned int func)
>         if (!(lps0_dsm_func_mask & (1 << func)))
>                 return;
>
> -       out_obj = acpi_evaluate_dsm(lps0_device_handle, &lps0_dsm_guid, 1, func, NULL);
> +       out_obj = acpi_evaluate_dsm(lps0_device_handle, &lps0_dsm_guid, rev_id, func, NULL);
>         ACPI_FREE(out_obj);
>
>         acpi_handle_debug(lps0_device_handle, "_DSM function %u evaluation %s\n",
> @@ -894,6 +1019,7 @@ static int lps0_device_attach(struct acpi_device *adev,
>                               const struct acpi_device_id *not_used)
>  {
>         union acpi_object *out_obj;
> +       struct cpuinfo_x86 *c = &boot_cpu_data;

Why do you need this pointer on the stack?

What would be wrong with accessing boot_cpu_data directly below?

Besides, this file doesn't depend on X86 and it may not build on the
other architectures after your changes.
