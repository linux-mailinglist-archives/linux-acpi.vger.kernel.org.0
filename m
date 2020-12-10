Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E722D65C9
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Dec 2020 20:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393237AbgLJS5u convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Thu, 10 Dec 2020 13:57:50 -0500
Received: from mail-oo1-f67.google.com ([209.85.161.67]:37613 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393188AbgLJS5n (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Dec 2020 13:57:43 -0500
Received: by mail-oo1-f67.google.com with SMTP id t23so1517880oov.4
        for <linux-acpi@vger.kernel.org>; Thu, 10 Dec 2020 10:57:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iWDqmnrOy6XAoiY09dM3x1lIqPzKRE8zOY9EpMW2dmU=;
        b=J1lkmrI0eZqeUMY/z1pH7oh/XS78fvOf552+1dia1QbLeYfrlFie9VVCbvDV4Ziwus
         rBvSoS2PBnKfA4KRL0xJLoGd2tuJHPi1ucnCmLkYtptLI2fa1DGN3XvJKn+Y2wtJZRnv
         CEI/BMUVbj3u70hoguo/KdPfy/AX+4JdyA7DJl2UBrBENgvybtEwvA8NE2kLjF9ZOcte
         6D+F6wZr52WqifjKgvPwWi8r+j986rjiq/KZvRHhDKBw7PCCXyBsTv2GSIDi1TThQlT5
         JUZY1ec5Tl84F0+DqEhJ3uXyMUS90CbnJuy9b6p7gFw9BRe2fz+4pI2MqGZo9qGGx2CA
         koIg==
X-Gm-Message-State: AOAM533FhRDoOuW6ZjlO7ghG2p4jqCIOm+emziFFetbA3WdVnRx/cnvJ
        sR2iYIog2Sp7wDMuIFLMF5TNYxC6nsVQNIKayic=
X-Google-Smtp-Source: ABdhPJyuD4n0yKZ2AE3WBjYVdqekGOGkrZpEHQnt7MH4zpmXYeny0jb7gtNDj2Yqxpg1ekygBQGPOjw8H8jEKd/IfMc=
X-Received: by 2002:a4a:9873:: with SMTP id z48mr7020471ooi.44.1607626621507;
 Thu, 10 Dec 2020 10:57:01 -0800 (PST)
MIME-Version: 1.0
References: <20201120060752.3146704-1-Shyam-sundar.S-k@amd.com>
 <CAJZ5v0jeoiZdgzKupakPn+82iur-nMLH3wEC07cHO1qyvoysug@mail.gmail.com> <e0cd4950-e19d-a158-c9c9-b6436854e663@amd.com>
In-Reply-To: <e0cd4950-e19d-a158-c9c9-b6436854e663@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 10 Dec 2020 19:56:50 +0100
Message-ID: <CAJZ5v0jkcFjHzaJXmm9Z-VjxEO373k=g_iwt+8gOs2FcjEABEg@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: PM: s2idle: Add AMD support to handle _DSM
 during S2Idle
To:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 25, 2020 at 7:45 AM Shyam Sundar S K
<Shyam-sundar.S-k@amd.com> wrote:
>
>
>
> On 11/23/2020 10:15 PM, Rafael J. Wysocki wrote:
> > [CAUTION: External Email]
> >
> > On Fri, Nov 20, 2020 at 7:10 AM Shyam Sundar S K
> > <Shyam-sundar.S-k@amd.com> wrote:
> >>
> >> Initial support for S2Idle based on the Intel implementation [1] does not
> >> work for AMD as the BIOS implementation for ACPI methods like the _DSM
> >> are not standardized.
> >>
> >> So, the way in which the UUID's were parsed and the ACPI packages were
> >> retrieved out of the ACPI objects are not the same between Intel and AMD.
> >>
> >> This patch adds AMD support for S2Idle to parse the UUID, evaluate the
> >> _DSM methods, preparing the Idle constraint list etc.
> >>
> >> Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fuefi.org%2Fsites%2Fdefault%2Ffiles%2Fresources%2FIntel_ACPI_Low_Power_S0_Idle.pdf&amp;data=04%7C01%7CShyam-sundar.S-k%40amd.com%7C640970e0f42a4fd53a1408d88fcf25d8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C1%7C637417467581911776%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&amp;sdata=xPFj5OymQkr3xEaU8qQD1y8O95XCszUblRRuknNvD7I%3D&amp;reserved=0 # [1]
> >> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> >> ---
> >> v2:(https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.spinics.net%2Flists%2Flinux-acpi%2Fmsg97104.html&amp;data=04%7C01%7CShyam-sundar.S-k%40amd.com%7C640970e0f42a4fd53a1408d88fcf25d8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C1%7C637417467581911776%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&amp;sdata=r5whv52ruKVbFgsV1qEuWKeePaUQhjXnxQwF7izFRf4%3D&amp;reserved=0)
> >> - Remove default case in switch.
> >> - Add a routine acpi_match_vendor_name() required when building on a
> >>   non-x86 based environment.
> >> - Fixed spelling mistakes.
> >> ---
> >>  drivers/acpi/sleep.c | 166 ++++++++++++++++++++++++++++++++++++++++---
> >>  1 file changed, 157 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> >> index aff13bf4d947..b929fd0d2e04 100644
> >> --- a/drivers/acpi/sleep.c
> >> +++ b/drivers/acpi/sleep.c
> >> @@ -710,6 +710,11 @@ static const struct acpi_device_id lps0_device_ids[] = {
> >>  #define ACPI_LPS0_ENTRY                5
> >>  #define ACPI_LPS0_EXIT         6
> >>
> >> +/* AMD */
> >> +#define ACPI_LPS0_DSM_UUID_AMD      "e3f32452-febc-43ce-9039-932122d37721"
> >> +#define ACPI_LPS0_SCREEN_OFF_AMD    4
> >> +#define ACPI_LPS0_SCREEN_ON_AMD     5
> >> +
> >>  static acpi_handle lps0_device_handle;
> >>  static guid_t lps0_dsm_guid;
> >>  static char lps0_dsm_func_mask;
> >> @@ -733,8 +738,124 @@ struct lpi_constraints {
> >>         int min_dstate;
> >>  };
> >>
> >> +/* AMD */
> >> +/* Device constraint entry structure */
> >> +struct lpi_device_info_amd {
> >> +       int revision;
> >> +       int count;
> >> +       union acpi_object *package;
> >> +};
> >> +
> >> +/* Constraint package structure */
> >> +struct lpi_device_constraint_amd {
> >> +       char *name;
> >> +       int enabled;
> >> +       int function_states;
> >> +       int min_dstate;
> >> +};
> >> +
> >>  static struct lpi_constraints *lpi_constraints_table;
> >>  static int lpi_constraints_table_size;
> >> +static int rev_id;
> >> +
> >> +static void lpi_device_get_constraints_amd(void)
> >> +{
> >> +       union acpi_object *out_obj;
> >> +       int i, j, k;
> >> +
> >> +       out_obj = acpi_evaluate_dsm_typed(lps0_device_handle, &lps0_dsm_guid,
> >> +                                         1, ACPI_LPS0_GET_DEVICE_CONSTRAINTS,
> >> +                                         NULL, ACPI_TYPE_PACKAGE);
> >> +
> >> +       if (!out_obj)
> >> +               return;
> >> +
> >> +       acpi_handle_debug(lps0_device_handle, "_DSM function 1 eval %s\n",
> >> +                         out_obj ? "successful" : "failed");
> >> +
> >> +       for (i = 0; i < out_obj->package.count; i++) {
> >> +               union acpi_object *package = &out_obj->package.elements[i];
> >> +               struct lpi_device_info_amd info = { };
> >> +
> >> +               if (package->type == ACPI_TYPE_INTEGER) {
> >> +                       switch (i) {
> >> +                       case 0:
> >> +                               info.revision = package->integer.value;
> >> +                               break;
> >> +                       case 1:
> >> +                               info.count = package->integer.value;
> >> +                               break;
> >> +                       }
> >> +               } else if (package->type == ACPI_TYPE_PACKAGE) {
> >> +                       lpi_constraints_table = kcalloc(package->package.count,
> >> +                                                       sizeof(*lpi_constraints_table),
> >> +                                                       GFP_KERNEL);
> >> +
> >> +                       if (!lpi_constraints_table)
> >> +                               goto free_acpi_buffer;
> >> +
> >> +                       acpi_handle_info(lps0_device_handle,
> >> +                                        "LPI: constraints list begin:\n");
> >> +
> >> +                       for (j = 0; j < package->package.count; ++j) {
> >> +                               union acpi_object *info_obj = &package->package.elements[j];
> >> +                               struct lpi_device_constraint_amd dev_info = {};
> >> +                               struct lpi_constraints *list;
> >> +                               acpi_status status;
> >> +
> >> +                               for (k = 0; k < info_obj->package.count; ++k) {
> >> +                                       union acpi_object *obj = &info_obj->package.elements[k];
> >> +                                       union acpi_object *obj_new;
> >> +
> >> +                                       list = &lpi_constraints_table[lpi_constraints_table_size];
> >> +                                       list->min_dstate = -1;
> >> +
> >> +                                       obj_new = &obj[k];
> >> +                                       switch (k) {
> >> +                                       case 0:
> >> +                                               dev_info.enabled = obj->integer.value;
> >> +                                               break;
> >> +                                       case 1:
> >> +                                               dev_info.name = obj->string.pointer;
> >> +                                               break;
> >> +                                       case 2:
> >> +                                               dev_info.function_states = obj->integer.value;
> >> +                                               break;
> >> +                                       case 3:
> >> +                                               dev_info.min_dstate = obj->integer.value;
> >> +                                               break;
> >> +                                       }
> >> +
> >> +                                       if (!dev_info.enabled || !dev_info.name ||
> >> +                                           !dev_info.min_dstate)
> >> +                                               continue;
> >> +
> >> +                                       status = acpi_get_handle(NULL, dev_info.name,
> >> +                                                                &list->handle);
> >> +                                       if (ACPI_FAILURE(status))
> >> +                                               continue;
> >> +
> >> +                                       acpi_handle_info(lps0_device_handle,
> >> +                                                        "Name:%s\n", dev_info.name);
> >> +
> >> +                                       list->min_dstate = dev_info.min_dstate;
> >> +
> >> +                                       if (list->min_dstate < 0) {
> >> +                                               acpi_handle_info(lps0_device_handle,
> >> +                                                                "Incomplete constraint defined\n");
> >> +                                               continue;
> >> +                                       }
> >> +                               }
> >> +                               lpi_constraints_table_size++;
> >> +                       }
> >> +               }
> >> +       }
> >> +
> >> +       acpi_handle_info(lps0_device_handle, "LPI: constraints list end\n");
> >> +
> >> +free_acpi_buffer:
> >> +       ACPI_FREE(out_obj);
> >> +}
> >>
> >>  static void lpi_device_get_constraints(void)
> >>  {
> >> @@ -883,13 +1004,22 @@ static void acpi_sleep_run_lps0_dsm(unsigned int func)
> >>         if (!(lps0_dsm_func_mask & (1 << func)))
> >>                 return;
> >>
> >> -       out_obj = acpi_evaluate_dsm(lps0_device_handle, &lps0_dsm_guid, 1, func, NULL);
> >> +       out_obj = acpi_evaluate_dsm(lps0_device_handle, &lps0_dsm_guid, rev_id, func, NULL);
> >>         ACPI_FREE(out_obj);
> >>
> >>         acpi_handle_debug(lps0_device_handle, "_DSM function %u evaluation %s\n",
> >>                           func, out_obj ? "successful" : "failed");
> >>  }
> >>
> >> +static bool acpi_match_vendor_name(void)
> >> +{
> >> +#ifdef CONFIG_X86
> >> +       if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
> >> +               return true;
> >> +#endif
> >> +       return false;
> >> +}
> >
> > Well, I still don't like this (explicit CONFIG_X86 dependencies are
> > not welcome in this file), but arguably the damage was done before
> > already and there is a bunch of X86-specific code in here anyway, so
> > I'm going to take your patch provisionally and rearrange the code on
> > top of it so as to relocate the x86-specific part of it into
> > acpi/x86/.
> >
> > Thanks!
>
> Thank you Rafael!

I won't be able to take care of this before the start of the 5.11
merge window, so I'll do my best to get to it during the merge window
so as to be able to still get it into 5.11-rc1.

Thanks!
