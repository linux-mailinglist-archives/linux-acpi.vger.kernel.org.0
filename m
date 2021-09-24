Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F23C241788B
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Sep 2021 18:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbhIXQd3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 Sep 2021 12:33:29 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:40480 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233640AbhIXQd3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Sep 2021 12:33:29 -0400
Received: by mail-oi1-f182.google.com with SMTP id t189so15189926oie.7;
        Fri, 24 Sep 2021 09:31:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YbjRBqRzb8KYpNgRLaEYJ6jgr0RlWe+czyRscPGcjD0=;
        b=vQ8fNfvhglnjgzhvbOGPxDRQ4pYLPj8ikgo+0d0NY4TN4SIt1eX8BadPXrd1Q9ScAS
         M12UULALO0gi+rp/zpoPhavPPcRkY3bfe8YwRTr6B+/SrJJZf90AW5ZEzD8jPUW245Qz
         +KwNkb6N5qBoTJp1cEBCL/ncHCq13/zQxo05g+WGIw1zXvrLl5u2sYblzv+12aTKT4Qg
         sYv0kxeeplOkdPbbYf22fLaduPyall9SYIelvE9NYYVL9bM3NTdA71KhS7t1ijccvOmS
         Xg3XxeNbeGDzgB7ZkdNWg2dO/cHmrwL986ROB280Jt/Ypm1jOTPx/EFra8/Mq6vjqqsl
         YZrg==
X-Gm-Message-State: AOAM531w71GdH9hFcJqYRCsScMnRsFb5EOAxWs6aSQ63SkDn3alBWSPP
        C1SwxrEP/EiwvFmffEUMc1Sl4BCXCtYu0Xkq0MD9EmqF
X-Google-Smtp-Source: ABdhPJzb32RBBISpIOFuSg5Fy97JJQ3/0Sf57fxliPmdq5zXsL/R1LO+oIeHtCS6qF58K2GkM5o+xcoC7218A2BmOEY=
X-Received: by 2002:a05:6808:10ce:: with SMTP id s14mr2287514ois.157.1632501115801;
 Fri, 24 Sep 2021 09:31:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210922133116.102-1-richard.gong@amd.com>
In-Reply-To: <20210922133116.102-1-richard.gong@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 24 Sep 2021 18:31:44 +0200
Message-ID: <CAJZ5v0jpOzNS5TFdJNXdxa_p2D_5QQMwwRcSMe8JmjOaTjR8gg@mail.gmail.com>
Subject: Re: [PATCHv1] ACPI: processor idle: Allow playing dead in C3 state
To:     Richard Gong <richard.gong@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lijo.lazar@amd.com, Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Sep 22, 2021 at 3:31 PM Richard Gong <richard.gong@amd.com> wrote:
>
> When some cores are disabled on AMD platforms, the system will no longer
> be able to enter suspend-to-idle s0ix.
>
> Update to allow playing dead in C3 state so that the CPUs can enter the
> deepest state on AMD platforms.
>
> BugLink: https://gitlab.freedesktop.org/drm/amd/-/issues/1708
> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Richard Gong <richard.gong@amd.com>
> ---
>  drivers/acpi/processor_idle.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index f37fba9e5ba0..61d5a72d218e 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -789,7 +789,8 @@ static int acpi_processor_setup_cstates(struct acpi_processor *pr)
>                 state->enter = acpi_idle_enter;
>
>                 state->flags = 0;
> -               if (cx->type == ACPI_STATE_C1 || cx->type == ACPI_STATE_C2) {
> +               if (cx->type == ACPI_STATE_C1 || cx->type == ACPI_STATE_C2
> +                       || cx->type == ACPI_STATE_C3) {
>                         state->enter_dead = acpi_idle_play_dead;
>                         drv->safe_state_index = count;
>                 }
> --

Tentatively applied as 5.16 material, but have you done any research
on why this restriction has been there in the first place?
