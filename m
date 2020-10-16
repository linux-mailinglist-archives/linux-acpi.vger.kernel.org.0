Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3385290907
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Oct 2020 18:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409076AbgJPQAh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Oct 2020 12:00:37 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46847 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408468AbgJPQAh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Oct 2020 12:00:37 -0400
Received: by mail-ot1-f67.google.com with SMTP id m11so2803738otk.13
        for <linux-acpi@vger.kernel.org>; Fri, 16 Oct 2020 09:00:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nFCzqKn5rqHfe/qUj17znJrSjRNjpAWf9smqu4k77K8=;
        b=dMiDKf5W8/F59MVlV1amY2O+pjH+k/jc+Hdy1CxE4vRg076rMhp3z65KPYYIMeHRzM
         hgm/zS7MNxvf6HfVU7HiXtOyyToQPLN4RXZ0HCUcvZ2ENFKaFPtybdXKIjbLPl5ix5WG
         06WUTj2HbbIfn1CG01s6jfveTKNsOic5iFxrqrsbXwKsKUpoIDzEVzV8ruMiIgAL4XkW
         udFceW85LLVKGk+rIfzCR527mvcZo26YgjNy6p0tMNL9h6Yu9lak/uUaB6gpRO0fbvMr
         CFL3D7wmPJse+qwFGdm0xaj7XB/1Hhpl5UJXKt1GUqgh+qqeuLEAr45D4FdKMfGpagmr
         dqzg==
X-Gm-Message-State: AOAM530ODb7s2JIHVGlqJjPSIz3uZfj1qHc1zMnAAizVNMkshNTsaTCE
        VgXmBXv2wNBslycGTO/bOBHCRAiyftHcQLpEGgo=
X-Google-Smtp-Source: ABdhPJxDx62rm+kEKb0QD0zknN91GJcA+3+zlhflhqt3uzamBbjVTII099mytz16moH7/K1dQA3cn6Oa9IH6fMCwRPc=
X-Received: by 2002:a9d:734f:: with SMTP id l15mr3288124otk.260.1602864036288;
 Fri, 16 Oct 2020 09:00:36 -0700 (PDT)
MIME-Version: 1.0
References: <20201009152116.35184-1-jamie@nuviainc.com> <20201012130446.57325-1-jamie@nuviainc.com>
In-Reply-To: <20201012130446.57325-1-jamie@nuviainc.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 16 Oct 2020 18:00:25 +0200
Message-ID: <CAJZ5v0gs3uM58H4A4nYL0kY1r8LaW3gV60-nkvROQ1Lfy-p9OQ@mail.gmail.com>
Subject: Re: [PATCHv2] ACPI: debug: don't allow debugging when ACPI is disabled
To:     Jamie Iles <jamie@nuviainc.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Oct 12, 2020 at 3:05 PM Jamie Iles <jamie@nuviainc.com> wrote:
>
> If ACPI is disabled then loading the acpi_dbg module will result in the
> following splat when lock debugging is enabled.
>
>   DEBUG_LOCKS_WARN_ON(lock->magic != lock)
>   WARNING: CPU: 0 PID: 1 at kernel/locking/mutex.c:938 __mutex_lock+0xa10/0x1290
>   Kernel panic - not syncing: panic_on_warn set ...
>   CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.9.0-rc8+ #103
>   Hardware name: linux,dummy-virt (DT)
>   Call trace:
>    dump_backtrace+0x0/0x4d8
>    show_stack+0x34/0x48
>    dump_stack+0x174/0x1f8
>    panic+0x360/0x7a0
>    __warn+0x244/0x2ec
>    report_bug+0x240/0x398
>    bug_handler+0x50/0xc0
>    call_break_hook+0x160/0x1d8
>    brk_handler+0x30/0xc0
>    do_debug_exception+0x184/0x340
>    el1_dbg+0x48/0xb0
>    el1_sync_handler+0x170/0x1c8
>    el1_sync+0x80/0x100
>    __mutex_lock+0xa10/0x1290
>    mutex_lock_nested+0x6c/0xc0
>    acpi_register_debugger+0x40/0x88
>    acpi_aml_init+0xc4/0x114
>    do_one_initcall+0x24c/0xb10
>    kernel_init_freeable+0x690/0x728
>    kernel_init+0x20/0x1e8
>    ret_from_fork+0x10/0x18
>
> This is because acpi_debugger.lock has not been initialized as
> acpi_debugger_init() is not called when ACPI is disabled.  Fail module
> loading to avoid this and any subsequent problems that might arise by
> trying to debug AML when ACPI is disabled.
>
> Fixes: 8cfb0cdf07e2 ("ACPI / debugger: Add IO interface to access debugger functionalities")
> Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Jamie Iles <jamie@nuviainc.com>
> ---
>  drivers/acpi/acpi_dbg.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/acpi/acpi_dbg.c b/drivers/acpi/acpi_dbg.c
> index 6041974c7627..fb7290338593 100644
> --- a/drivers/acpi/acpi_dbg.c
> +++ b/drivers/acpi/acpi_dbg.c
> @@ -749,6 +749,9 @@ static int __init acpi_aml_init(void)
>  {
>         int ret;
>
> +       if (acpi_disabled)
> +               return -ENODEV;
> +
>         /* Initialize AML IO interface */
>         mutex_init(&acpi_aml_io.lock);
>         init_waitqueue_head(&acpi_aml_io.wait);
> --

Applied as 5.10-rc material, thanks!
