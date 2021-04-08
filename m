Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4446B358BCE
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Apr 2021 19:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbhDHR7u (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 8 Apr 2021 13:59:50 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:37567 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbhDHR7t (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Apr 2021 13:59:49 -0400
Received: by mail-oi1-f180.google.com with SMTP id k25so3086249oic.4;
        Thu, 08 Apr 2021 10:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ax3ABmQpuWlTEUM4I+bnWh/ue2r9VyNMX16GZ55B25k=;
        b=opAZ6TLrYpnSvSawO7UNq0D0i6tGu9WTxQJ0CZ6u89/FnUmfRgiEAXYoGkA5yubn4s
         yXH4BNH2Jj5YBZ6gTHmVWGyfngBHbvb0nunb1ikIq7imMQicyL1Xkgm4ymf5VygwyRSm
         +zur+LH7jAdOxBQ6tA8QTUfQhjjY8mM7UIRAwglEaRhND4TYOE/eJdATKvFe5mRFN4zn
         8/CyaubdfRqYRgW+5fxfVOwHVhKgwMilF8VVI1k5VivLrYqVnlJJEwA9lMVYW1umyM8w
         aDwKoC7B48iEs0JuafplxSxF1UoCQ1mg/W5Sar9bBBlZEiCz1fPMjiJJ5jB40OL7HVBE
         muXw==
X-Gm-Message-State: AOAM5301mJKmDPjARF00deVw+viS1Kumh5WUEGX2MA88LHiURydmZnD/
        OrNAb78wtR9yHzVwx6KeE7OsSRCrzIZcvLB8pX8=
X-Google-Smtp-Source: ABdhPJwUtkkrpSPv+VoY0saC9mw4IuWibMv4PWM7IxUrA5g3CzTGF3ir/gABhN80eWU6JzFakFJnNLNDUf/+cZPpohk=
X-Received: by 2002:aca:5fc3:: with SMTP id t186mr6880729oib.69.1617904778140;
 Thu, 08 Apr 2021 10:59:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210407213048.940498-1-nathan@kernel.org>
In-Reply-To: <20210407213048.940498-1-nathan@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 8 Apr 2021 19:59:27 +0200
Message-ID: <CAJZ5v0iKYN-tM=3JXTPxXFMsyK8X1_yEHSwmtK+xsAmZ-8D=Pg@mail.gmail.com>
Subject: Re: [PATCH] ACPI / CPPC: Replace cppc_attr with kobj_attribute
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Apr 7, 2021 at 11:32 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> All of the CPPC sysfs show functions are called via indirect call in
> kobj_attr_show(), where they should be of type
>
> ssize_t (*show)(struct kobject *kobj, struct kobj_attribute *attr, char *buf);
>
> because that is the type of the ->show() member in
> 'struct kobj_attribute' but they are actually of type
>
> ssize_t (*show)(struct kobject *kobj, struct attribute *attr, char *buf);
>
> because of the ->show() member in 'struct cppc_attr', resulting in a
> Control Flow Integrity violation [1].
>
> $ cat /sys/devices/system/cpu/cpu0/acpi_cppc/highest_perf
> 3400
>
> $ dmesg | grep "CFI failure"
> [  175.970559] CFI failure (target: show_highest_perf+0x0/0x8):
>
> As far as I can tell, the only different between 'struct cppc_attr' and
> 'struct kobj_attribute' aside from the type of the attr parameter is the
> type of the count parameter in the ->store() member (ssize_t vs.
> size_t), which does not actually matter because all of these nodes are
> read-only.
>
> Eliminate 'struct cppc_attr' in favor of 'struct kobj_attribute' to fix
> the violation.
>
> [1]: https://lore.kernel.org/r/20210401233216.2540591-1-samitolvanen@google.com/
>
> Fixes: 158c998ea44b ("ACPI / CPPC: add sysfs support to compute delivered performance")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1343
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  drivers/acpi/cppc_acpi.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 69057fcd2c04..a5e6fd0bafa1 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -119,23 +119,15 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
>   */
>  #define NUM_RETRIES 500ULL
>
> -struct cppc_attr {
> -       struct attribute attr;
> -       ssize_t (*show)(struct kobject *kobj,
> -                       struct attribute *attr, char *buf);
> -       ssize_t (*store)(struct kobject *kobj,
> -                       struct attribute *attr, const char *c, ssize_t count);
> -};
> -
>  #define define_one_cppc_ro(_name)              \
> -static struct cppc_attr _name =                        \
> +static struct kobj_attribute _name =           \
>  __ATTR(_name, 0444, show_##_name, NULL)
>
>  #define to_cpc_desc(a) container_of(a, struct cpc_desc, kobj)
>
>  #define show_cppc_data(access_fn, struct_name, member_name)            \
>         static ssize_t show_##member_name(struct kobject *kobj,         \
> -                                       struct attribute *attr, char *buf) \
> +                               struct kobj_attribute *attr, char *buf) \
>         {                                                               \
>                 struct cpc_desc *cpc_ptr = to_cpc_desc(kobj);           \
>                 struct struct_name st_name = {0};                       \
> @@ -161,7 +153,7 @@ show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, reference_perf);
>  show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, wraparound_time);
>
>  static ssize_t show_feedback_ctrs(struct kobject *kobj,
> -               struct attribute *attr, char *buf)
> +               struct kobj_attribute *attr, char *buf)
>  {
>         struct cpc_desc *cpc_ptr = to_cpc_desc(kobj);
>         struct cppc_perf_fb_ctrs fb_ctrs = {0};
>
> base-commit: 454859c552da78b0f587205d308401922b56863e
> --

Applied as 5.13 material, thanks!
