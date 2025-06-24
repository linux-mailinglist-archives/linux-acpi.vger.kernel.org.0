Return-Path: <linux-acpi+bounces-14528-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E213AAE66EF
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Jun 2025 15:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 153911668AA
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Jun 2025 13:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34922C325A;
	Tue, 24 Jun 2025 13:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PfTQEwUu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E2B2C324F;
	Tue, 24 Jun 2025 13:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750772833; cv=none; b=Sa1S8L5BlHBTEoAsHxcsidv1xrnkJcwlSNOjl6fivSu6R5dD34RzdN6tOjc+msiNw6Et7jGVzWTF0dpots+6TP5bDBaSRRreqssj8NuLDhtGXZ243War0Weh5ZhH3le8LeGTvylBSXYqAU6BovfyzwC9eNpoFziaXTjZxK5TeO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750772833; c=relaxed/simple;
	bh=jr6TVyH5tYJl1OotHhDU7NHVSPLSs5hnVmnDmy0upMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GsX/HRyxXxFESbM/uK7Seaa4H8rkCG2LPS4eRcENAoFWpUABlRG4CG5gsRRT6Z/bkvEziTEwO1/YfQvKUfRY20p6fEuIbMHt6732fhO/s484gjgl5N2vBcehUP44X5I5sBjMlIfTerS0IoIFt9R9eXu3267G0pTJL4CtAcF+3XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PfTQEwUu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D4A4C4CEF5;
	Tue, 24 Jun 2025 13:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750772833;
	bh=jr6TVyH5tYJl1OotHhDU7NHVSPLSs5hnVmnDmy0upMQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PfTQEwUuA60kTOOWci6wmFUpT7K8CxP/lf2877Mbo9/xxhqkbGj33/bFRwbSfhszd
	 +zYjcKl8RSp2foJf2CQ9ZCcRSSD+AZx4bQNR4H1FZJps1n1z9d1fxVMWuX3AAjdFD0
	 JQ8ByBL7nvD3RpwvTwrMgxD2fbR2UG6ahUXc1nxUeFwDZ0TlNJuIFrO1agGxEBAzLo
	 cLS1DgcwSw350cL4PxXpd+Dt1EAx1wHDQ3AH3NqyBOdiirMEcYD8UEFi/C6Qk2B0fG
	 C0wZLbIrLchfrJUPoyZ3jzFXwN0pyyQLmi17xruKCGDHpyA4aLllybXDGoaRztDQe+
	 PBkK8+EmR5MaA==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6060a70ba80so2820345eaf.2;
        Tue, 24 Jun 2025 06:47:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU7+RzumE5p3Ga5OMe9YXH+CvjiRgaC5aqJ+TKizoZeLTSmkOT9IIkl8SaO9+sv7wHNrQojqqQKeTqE@vger.kernel.org, AJvYcCXNhahqwcc3vMGPgWnCMzMVme4O5LEr2gPFgYiDkTgjacHSkUlHO6gCpSqmoxFlXKSpNFLwXDXe2MVsqem0@vger.kernel.org
X-Gm-Message-State: AOJu0YzPJGk14g+jQXPfEYDe3u7ccliOhr+XJsdaFZ+dtJutZBQBpdN9
	z435ESlQk+zq+lU1ZuXzmtA8WiG+Atkid5Gb0QSWB5KOPrv+jwBTGaWOvJvMokL363OSzCLW+gx
	u0/RN2EysjIgtCLUrEaMMXgI0C1bIhXc=
X-Google-Smtp-Source: AGHT+IHWNLr3rdFDrzU9E0f2akoWvlQqd3I3juKx1o457TNbG3wq4LQW6nQ1ipgBYVPRbgrAyF6iniET71uJ1FTULEU=
X-Received: by 2002:a4a:ee08:0:b0:611:96c0:535f with SMTP id
 006d021491bc7-61196c05588mr912296eaf.8.1750772832142; Tue, 24 Jun 2025
 06:47:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624133739.25215-1-listout@listout.xyz>
In-Reply-To: <20250624133739.25215-1-listout@listout.xyz>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 24 Jun 2025 15:46:58 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jSk-NrovSq5En6qOureQXFbCsJLChorbgYXQdYfa0m3w@mail.gmail.com>
X-Gm-Features: AX0GCFuloK1-5LEjv3L3bpF5HjxsvvcaFAjbJ6DsLustfZbwQ_ulkgg_e7G-kDM
Message-ID: <CAJZ5v0jSk-NrovSq5En6qOureQXFbCsJLChorbgYXQdYfa0m3w@mail.gmail.com>
Subject: Re: [PATCH] ACPI / sysfs: Replace deprecated and unsafe functions
 with sysfs_emit
To: Brahmajit Das <listout@listout.xyz>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, rafael@kernel.org, lenb@kernel.org, 
	lv.zheng@intel.com, kees@kernel.org, rui.zhang@intel.com, len.brown@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 3:38=E2=80=AFPM Brahmajit Das <listout@listout.xyz>=
 wrote:
>
> acpi/sysfs.c has many instances of unsafe or deprecated functions such
> as sprintf, strcpy. This patch relaces them with sysfs_emit to safer

"replaces"

> alternavtive and better following of kernel API.

"alternative"

1. Have you tested all of the affected interfaces and verified that
they still work as expected after the changes?
2. While the replaced functions are unsafe in principle, is the usage
of them in any places affected by this patch actually unsafe?

> Signed-off-by: Brahmajit Das <listout@listout.xyz>
> ---
>  drivers/acpi/sysfs.c | 87 ++++++++++++++++++++++----------------------
>  1 file changed, 43 insertions(+), 44 deletions(-)
>
> diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
> index a48ebbf768f9..c3bb7af79fcb 100644
> --- a/drivers/acpi/sysfs.c
> +++ b/drivers/acpi/sysfs.c
> @@ -94,23 +94,23 @@ static int param_get_debug_layer(char *buffer, const =
struct kernel_param *kp)
>         int result =3D 0;
>         int i;
>
> -       result =3D sprintf(buffer, "%-25s\tHex        SET\n", "Descriptio=
n");
> +       result =3D sysfs_emit(buffer, "%-25s\tHex        SET\n", "Descrip=
tion");
>
>         for (i =3D 0; i < ARRAY_SIZE(acpi_debug_layers); i++) {
> -               result +=3D sprintf(buffer + result, "%-25s\t0x%08lX [%c]=
\n",
> +               result +=3D sysfs_emit(buffer + result, "%-25s\t0x%08lX [=
%c]\n",
>                                   acpi_debug_layers[i].name,
>                                   acpi_debug_layers[i].value,
>                                   (acpi_dbg_layer & acpi_debug_layers[i].=
value)
>                                   ? '*' : ' ');
>         }
>         result +=3D
> -           sprintf(buffer + result, "%-25s\t0x%08X [%c]\n", "ACPI_ALL_DR=
IVERS",
> +           sysfs_emit(buffer + result, "%-25s\t0x%08X [%c]\n", "ACPI_ALL=
_DRIVERS",
>                     ACPI_ALL_DRIVERS,
>                     (acpi_dbg_layer & ACPI_ALL_DRIVERS) =3D=3D
>                     ACPI_ALL_DRIVERS ? '*' : (acpi_dbg_layer & ACPI_ALL_D=
RIVERS)
>                     =3D=3D 0 ? ' ' : '-');
>         result +=3D
> -           sprintf(buffer + result,
> +           sysfs_emit(buffer + result,
>                     "--\ndebug_layer =3D 0x%08X ( * =3D enabled)\n",
>                     acpi_dbg_layer);
>
> @@ -122,17 +122,17 @@ static int param_get_debug_level(char *buffer, cons=
t struct kernel_param *kp)
>         int result =3D 0;
>         int i;
>
> -       result =3D sprintf(buffer, "%-25s\tHex        SET\n", "Descriptio=
n");
> +       result =3D sysfs_emit(buffer, "%-25s\tHex        SET\n", "Descrip=
tion");
>
>         for (i =3D 0; i < ARRAY_SIZE(acpi_debug_levels); i++) {
> -               result +=3D sprintf(buffer + result, "%-25s\t0x%08lX [%c]=
\n",
> +               result +=3D sysfs_emit(buffer + result, "%-25s\t0x%08lX [=
%c]\n",
>                                   acpi_debug_levels[i].name,
>                                   acpi_debug_levels[i].value,
>                                   (acpi_dbg_level & acpi_debug_levels[i].=
value)
>                                   ? '*' : ' ');
>         }
>         result +=3D
> -           sprintf(buffer + result, "--\ndebug_level =3D 0x%08X (* =3D e=
nabled)\n",
> +           sysfs_emit(buffer + result, "--\ndebug_level =3D 0x%08X (* =
=3D enabled)\n",
>                     acpi_dbg_level);
>
>         return result;
> @@ -181,11 +181,11 @@ static int param_set_trace_method_name(const char *=
val,
>
>         /* This is a hack.  We can't kmalloc in early boot. */
>         if (is_abs_path)
> -               strcpy(trace_method_name, val);
> +               sysfs_emit(trace_method_name, "%s", val);
>         else {
> -               trace_method_name[0] =3D '\\';
> -               strcpy(trace_method_name+1, val);
> +               sysfs_emit(trace_method_name, "\%s", val);
>         }
> +       pr_info("tracepoint: %s", trace_method_name);
>
>         /* Restore the original tracer state */
>         (void)acpi_debug_trace(trace_method_name,
> @@ -255,13 +255,13 @@ static int param_set_trace_state(const char *val,
>  static int param_get_trace_state(char *buffer, const struct kernel_param=
 *kp)
>  {
>         if (!(acpi_gbl_trace_flags & ACPI_TRACE_ENABLED))
> -               return sprintf(buffer, "disable\n");
> +               return sysfs_emit(buffer, "disable\n");
>         if (!acpi_gbl_trace_method_name)
> -               return sprintf(buffer, "enable\n");
> +               return sysfs_emit(buffer, "enable\n");
>         if (acpi_gbl_trace_flags & ACPI_TRACE_ONESHOT)
> -               return sprintf(buffer, "method-once\n");
> +               return sysfs_emit(buffer, "method-once\n");
>         else
> -               return sprintf(buffer, "method\n");
> +               return sysfs_emit(buffer, "method\n");
>  }
>
>  module_param_call(trace_state, param_set_trace_state, param_get_trace_st=
ate,
> @@ -282,7 +282,7 @@ static int param_get_acpica_version(char *buffer,
>  {
>         int result;
>
> -       result =3D sprintf(buffer, "%x\n", ACPI_CA_VERSION);
> +       result =3D sysfs_emit(buffer, "%x\n", ACPI_CA_VERSION);
>
>         return result;
>  }
> @@ -366,9 +366,8 @@ static int acpi_table_attr_init(struct kobject *table=
s_obj,
>         if (table_attr->instance > 1 || (table_attr->instance =3D=3D 1 &&
>                                          !acpi_get_table
>                                          (table_header->signature, 2, &he=
ader))) {
> -               snprintf(instance_str, sizeof(instance_str), "%u",
> -                        table_attr->instance);
> -               strcat(table_attr->filename, instance_str);
> +               sysfs_emit(instance_str, "%u%s", table_attr->instance,
> +                          table_attr->filename);
>         }
>
>         table_attr->attr.size =3D table_header->length;
> @@ -687,7 +686,7 @@ static ssize_t counter_show(struct kobject *kobj,
>             acpi_irq_not_handled;
>         all_counters[num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_GPE].count =
=3D
>             acpi_gpe_count;
> -       size =3D sprintf(buf, "%8u", all_counters[index].count);
> +       size =3D sysfs_emit(buf, "%8u", all_counters[index].count);
>
>         /* "gpe_all" or "sci" */
>         if (index >=3D num_gpes + ACPI_NUM_FIXED_EVENTS)
> @@ -698,29 +697,29 @@ static ssize_t counter_show(struct kobject *kobj,
>                 goto end;
>
>         if (status & ACPI_EVENT_FLAG_ENABLE_SET)
> -               size +=3D sprintf(buf + size, "  EN");
> +               size +=3D sysfs_emit(buf + size, "  EN");
>         else
> -               size +=3D sprintf(buf + size, "    ");
> +               size +=3D sysfs_emit(buf + size, "    ");
>         if (status & ACPI_EVENT_FLAG_STATUS_SET)
> -               size +=3D sprintf(buf + size, " STS");
> +               size +=3D sysfs_emit(buf + size, " STS");
>         else
> -               size +=3D sprintf(buf + size, "    ");
> +               size +=3D sysfs_emit(buf + size, "    ");
>
>         if (!(status & ACPI_EVENT_FLAG_HAS_HANDLER))
> -               size +=3D sprintf(buf + size, " invalid     ");
> +               size +=3D sysfs_emit(buf + size, " invalid     ");
>         else if (status & ACPI_EVENT_FLAG_ENABLED)
> -               size +=3D sprintf(buf + size, " enabled     ");
> +               size +=3D sysfs_emit(buf + size, " enabled     ");
>         else if (status & ACPI_EVENT_FLAG_WAKE_ENABLED)
> -               size +=3D sprintf(buf + size, " wake_enabled");
> +               size +=3D sysfs_emit(buf + size, " wake_enabled");
>         else
> -               size +=3D sprintf(buf + size, " disabled    ");
> +               size +=3D sysfs_emit(buf + size, " disabled    ");
>         if (status & ACPI_EVENT_FLAG_MASKED)
> -               size +=3D sprintf(buf + size, " masked  ");
> +               size +=3D sysfs_emit(buf + size, " masked  ");
>         else
> -               size +=3D sprintf(buf + size, " unmasked");
> +               size +=3D sysfs_emit(buf + size, " unmasked");
>
>  end:
> -       size +=3D sprintf(buf + size, "\n");
> +       size +=3D sysfs_emit(buf + size, "\n");
>         return result ? result : size;
>  }
>
> @@ -885,27 +884,27 @@ void acpi_irq_stats_init(void)
>                 char *name;
>
>                 if (i < num_gpes)
> -                       sprintf(buffer, "gpe%02X", i);
> +                       sysfs_emit(buffer, "gpe%02X", i);
>                 else if (i =3D=3D num_gpes + ACPI_EVENT_PMTIMER)
> -                       sprintf(buffer, "ff_pmtimer");
> +                       sysfs_emit(buffer, "ff_pmtimer");
>                 else if (i =3D=3D num_gpes + ACPI_EVENT_GLOBAL)
> -                       sprintf(buffer, "ff_gbl_lock");
> +                       sysfs_emit(buffer, "ff_gbl_lock");
>                 else if (i =3D=3D num_gpes + ACPI_EVENT_POWER_BUTTON)
> -                       sprintf(buffer, "ff_pwr_btn");
> +                       sysfs_emit(buffer, "ff_pwr_btn");
>                 else if (i =3D=3D num_gpes + ACPI_EVENT_SLEEP_BUTTON)
> -                       sprintf(buffer, "ff_slp_btn");
> +                       sysfs_emit(buffer, "ff_slp_btn");
>                 else if (i =3D=3D num_gpes + ACPI_EVENT_RTC)
> -                       sprintf(buffer, "ff_rt_clk");
> +                       sysfs_emit(buffer, "ff_rt_clk");
>                 else if (i =3D=3D num_gpes + ACPI_NUM_FIXED_EVENTS + COUN=
T_GPE)
> -                       sprintf(buffer, "gpe_all");
> +                       sysfs_emit(buffer, "gpe_all");
>                 else if (i =3D=3D num_gpes + ACPI_NUM_FIXED_EVENTS + COUN=
T_SCI)
> -                       sprintf(buffer, "sci");
> +                       sysfs_emit(buffer, "sci");
>                 else if (i =3D=3D num_gpes + ACPI_NUM_FIXED_EVENTS + COUN=
T_SCI_NOT)
> -                       sprintf(buffer, "sci_not");
> +                       sysfs_emit(buffer, "sci_not");
>                 else if (i =3D=3D num_gpes + ACPI_NUM_FIXED_EVENTS + COUN=
T_ERROR)
> -                       sprintf(buffer, "error");
> +                       sysfs_emit(buffer, "error");
>                 else
> -                       sprintf(buffer, "bug%02X", i);
> +                       sysfs_emit(buffer, "bug%02X", i);
>
>                 name =3D kstrdup(buffer, GFP_KERNEL);
>                 if (name =3D=3D NULL)
> @@ -937,7 +936,7 @@ static void __exit interrupt_stats_exit(void)
>
>  static ssize_t pm_profile_show(struct kobject *kobj, struct kobj_attribu=
te *attr, char *buf)
>  {
> -       return sprintf(buf, "%d\n", acpi_gbl_FADT.preferred_profile);
> +       return sysfs_emit(buf, "%d\n", acpi_gbl_FADT.preferred_profile);
>  }
>
>  static const struct kobj_attribute pm_profile_attr =3D __ATTR_RO(pm_prof=
ile);
> @@ -946,7 +945,7 @@ static ssize_t enabled_show(struct kobject *kobj, str=
uct kobj_attribute *attr, c
>  {
>         struct acpi_hotplug_profile *hotplug =3D to_acpi_hotplug_profile(=
kobj);
>
> -       return sprintf(buf, "%d\n", hotplug->enabled);
> +       return sysfs_emit(buf, "%d\n", hotplug->enabled);
>  }
>
>  static ssize_t enabled_store(struct kobject *kobj, struct kobj_attribute=
 *attr,
> @@ -1000,7 +999,7 @@ void acpi_sysfs_add_hotplug_profile(struct acpi_hotp=
lug_profile *hotplug,
>  static ssize_t force_remove_show(struct kobject *kobj,
>                                  struct kobj_attribute *attr, char *buf)
>  {
> -       return sprintf(buf, "%d\n", 0);
> +       return sysfs_emit(buf, "%d\n", 0);
>  }
>
>  static ssize_t force_remove_store(struct kobject *kobj,
> --
> 2.50.0
>
>

