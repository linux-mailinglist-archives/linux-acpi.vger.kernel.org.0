Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC853453A41
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Nov 2021 20:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240056AbhKPTg5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 Nov 2021 14:36:57 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:42670 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240077AbhKPTgy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Nov 2021 14:36:54 -0500
Received: by mail-ot1-f44.google.com with SMTP id g91-20020a9d12e4000000b0055ae68cfc3dso213523otg.9
        for <linux-acpi@vger.kernel.org>; Tue, 16 Nov 2021 11:33:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XV2cfrRiIH54sE6hZUZkwabS6s3AchKxeGs+feIz16w=;
        b=0bmUXYCKQ2MCGlrVLS8AsfnWmfms9VjfRREmBRrTNvhMNf9qnnbeUxc18Qgt38EXe0
         2ZAW9U2O/l8o0yv/RQd8ISlwXQcOeCvTHZ9erFOxpMePCCmL89YO/2yd8J1VOhamCpzG
         PnESs4ULHRQQvxdwWCBOO00RLtFiKXYzY/TPoE8wOOaxRrRJL4gofit2NnPnkrHs/93t
         q7WaATUqmADk58XkRCqF4KcgTVs9uTbet3d3XvPYxLec5JUWo0Lr6MPIooHB3UtJly+z
         pKIAfBiO+ZpzerkMncZ+O0H6frCUXnLTbR31U/mYpXcj9zosMMffUIKIHyYATSaLaEOF
         6cMA==
X-Gm-Message-State: AOAM5316GUaH4hKaHdFlH1+gvKPC8n9zLfVpH+CkrRW0+K/xAHbgcx1F
        +nLjzJE8hJyOHSzSZBbdb9qcvzKV7BlqwgzAu49q4s6s
X-Google-Smtp-Source: ABdhPJx7j/gSvd/aB9yM9f4KDk46eXYlyX+tp/1A9pyTtigB3WpAu1dGnCEeSU6y7DpGbMlXprVw2UyAKopYxtJ04w0=
X-Received: by 2002:a05:6830:348f:: with SMTP id c15mr8379540otu.254.1637091236894;
 Tue, 16 Nov 2021 11:33:56 -0800 (PST)
MIME-Version: 1.0
References: <20211115173208.57911-1-kilobyte@angband.pl>
In-Reply-To: <20211115173208.57911-1-kilobyte@angband.pl>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 16 Nov 2021 20:33:46 +0100
Message-ID: <CAJZ5v0iFmE1x-N=vQjVweqSWvBD8Q-q6wkE2yair-3DKU2R3vg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: thermal: drop an always true check
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Nov 15, 2021 at 6:55 PM Adam Borowski <kilobyte@angband.pl> wrote:
>
> Address of a field inside a struct can't possibly be null; gcc-12 warns
> about this.
>
> Signed-off-by: Adam Borowski <kilobyte@angband.pl>
> ---
>  drivers/acpi/thermal.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index 95105db642b9..155bbabcc6f5 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -1098,8 +1098,6 @@ static int acpi_thermal_resume(struct device *dev)
>                 return -EINVAL;
>
>         for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
> -               if (!(&tz->trips.active[i]))
> -                       break;
>                 if (!tz->trips.active[i].flags.valid)
>                         break;
>                 tz->trips.active[i].flags.enabled = 1;
> --

Applied as 5.16-rc material, thanks!
