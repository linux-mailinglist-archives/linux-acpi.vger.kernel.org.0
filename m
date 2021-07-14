Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA9053C8465
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jul 2021 14:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbhGNMXJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Jul 2021 08:23:09 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:42587 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239299AbhGNMXJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Jul 2021 08:23:09 -0400
Received: by mail-oi1-f178.google.com with SMTP id m18so2004581oie.9;
        Wed, 14 Jul 2021 05:20:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wj2YIDnuSkMORrnDduw22NHIm+du4AAqDR9YDqPpvIo=;
        b=QZgPSF5p33vMO9wUt/ZRHfKMlguHSVt+89zoGtQ7oXmtuhx8gYCUezwWIfTQvRfYcM
         NrFReBZ/Y/adO6Hh3nmF+mrI6mmEHnm27Ye20cH6NTB61CDo/Qdz6VjkDTETkPBmTWR+
         LzJjzPHsJpQVDEHksMB/GNa14q9pYajgL2lIRbqElXln7MPwvT3dPPq5vaQzy+3wT1OP
         zSjurypMnnXKY6ciN8Gc8M1V5gk2g9YgQzwj1ydvCp/A/VymXByYGFQEnLYq/kzDOFpw
         7m2/goqG+NdeG8KtypfRzOX1Nborp2ZlKcZjuz38Yl1nacYnbxvfWQ5RkzOuouD9yPqn
         6Stw==
X-Gm-Message-State: AOAM533Uy8RWezwmbsMGTFXq5AabhLUbhPzHUG0V0roDR80iD6LxNPQx
        vF0+h93uPggX0N4F0bmBx6JCWihOQ6QpsuSy0H4=
X-Google-Smtp-Source: ABdhPJx3hBx3XNvS6sx0m6VpifKSXeEkpj553UCUJ/z+9JGUL2e6pdiOKBdNX8/eMukU5V+ADUmGWDuBgZm+mSqM6BQ=
X-Received: by 2002:a05:6808:10d0:: with SMTP id s16mr6768030ois.69.1626265216250;
 Wed, 14 Jul 2021 05:20:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210708180851.2311192-1-sudeep.holla@arm.com> <20210708180851.2311192-3-sudeep.holla@arm.com>
In-Reply-To: <20210708180851.2311192-3-sudeep.holla@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 14 Jul 2021 14:20:05 +0200
Message-ID: <CAJZ5v0ibgrdceoTqnbgbqHhCTZR74RuzKTDxVOzU2UR4VWJkGg@mail.gmail.com>
Subject: Re: [PATCH 02/13] ACPI: CPPC: Fix doxygen comments
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jassi Brar <jassisinghbrar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jul 8, 2021 at 8:09 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> Clang complains about doxygen comments too with W=1 in the build.
>
>   | drivers/acpi/cppc_acpi.c:560: warning: Function parameter or member
>   |     'pcc_ss_id' not described in 'pcc_data_alloc'
>   | drivers/acpi/cppc_acpi.c:1343: warning: Function parameter or member
>   |     'cpu_num' not described in 'cppc_get_transition_latency'
>
> Fix it.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/acpi/cppc_acpi.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index a4d4eebba1da..eb5685167d19 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -562,6 +562,8 @@ bool __weak cpc_ffh_supported(void)
>  /**
>   * pcc_data_alloc() - Allocate the pcc_data memory for pcc subspace
>   *

I would drop this empty line (and analogously below).

> + * @pcc_ss_id: PCC Subspace channel identifier
> + *
>   * Check and allocate the cppc_pcc_data memory.
>   * In some processor configurations it is possible that same subspace
>   * is shared between multiple CPUs. This is seen especially in CPUs
> @@ -1347,10 +1349,15 @@ EXPORT_SYMBOL_GPL(cppc_set_perf);
>  /**
>   * cppc_get_transition_latency - returns frequency transition latency in ns
>   *
> + * @cpu_num: Logical index of the CPU for which latencty is requested
> + *
>   * ACPI CPPC does not explicitly specify how a platform can specify the
>   * transition latency for performance change requests. The closest we have
>   * is the timing information from the PCCT tables which provides the info
>   * on the number and frequency of PCC commands the platform can handle.
> + *
> + * Returns: frequency transition latency on success or CPUFREQ_ETERNAL on
> + * failure

Is this change needed?  The one-line summary already says this.

>   */
>  unsigned int cppc_get_transition_latency(int cpu_num)
>  {
> --
