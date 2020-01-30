Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABD5D14E468
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Jan 2020 22:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgA3VHV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 30 Jan 2020 16:07:21 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33306 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgA3VHV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Jan 2020 16:07:21 -0500
Received: by mail-oi1-f193.google.com with SMTP id q81so5135034oig.0;
        Thu, 30 Jan 2020 13:07:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+KhBsaQhYAtg/9op0ggWgTDIHD8rbgQILFtHm4y6ZFo=;
        b=Hg92ugbkSXmLWCBJuOJK+7+OY/1o6//yBw15l6cqYBJXEexpN6B620zzvVqZDHrHe4
         4cAo40MtEgPbkePpidXVDf2hyydSUT6q6SEjazmuJoRZGXy30agu0ADmo5A2Pih567bw
         0WcoL8N24yE7JHAmtnzV7WuK9keTurqVGBogNj2FybFNVtqWOFM/gO4+SYscYlldYC2k
         +5CC/GAPUoqVPfJYYtONxNXQPJp7I7+vlw8MIymy0YrNX/RF9afre8W0759NoNKaQkj4
         jv8UvHibgAPuFy3Ei9cj1TlQQNuFKTR6zIt7gAww5p10E6FQuC1K9S3DFn2eISS0G4WP
         s+9Q==
X-Gm-Message-State: APjAAAVWpNLwewGboBwN4Hd2NZJycnNXhBgA8LzE/EK2ajDQPZ/3d3WG
        6cLYO2dQMjiDSR24WPq4tCs7PtBXLwiBFWK0zgE=
X-Google-Smtp-Source: APXvYqyl510fC9XqZsVw4DYiTbSHXnTxOvhV5KaMTO1VWv/L/jyTAjwQPata1SThgOjatlzBGwd4Q2asPWdLs4/wV/o=
X-Received: by 2002:aca:d6c8:: with SMTP id n191mr4359734oig.103.1580418440279;
 Thu, 30 Jan 2020 13:07:20 -0800 (PST)
MIME-Version: 1.0
References: <20200111022145.GA166025@localhost>
In-Reply-To: <20200111022145.GA166025@localhost>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 30 Jan 2020 22:07:09 +0100
Message-ID: <CAJZ5v0hF2YDVHcvqx_4TaEzuqBKppVG7gZ4nXm_peF75Cfbzmg@mail.gmail.com>
Subject: Re: [PATCH] acpi: button: Provide option for power button to directly
 signal init
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Jan 11, 2020 at 3:21 AM Josh Triplett <josh@joshtriplett.org> wrote:
>
> Virtual machines and containers often use an ACPI power button event to
> tell the machine to shut down gracefully.
>
> Provide an optional, extremely lightweight way to handle this event by
> signaling init directly, rather than running a separate daemon (such as
> acpid or systemd-logind) that adds to startup time and VM image
> complexity.

Well, I'm not convinced.

Even though the patch looks straightforward, the approach really is
quite not so conceptually and honestly it looks like a band-aid.

Also I'm not quite sure why the ACPI button driver is the target of
this and not the input layer, for instance.

> By default, the power button will continue to notify userspace through
> the input layer. With the button.power_signal parameter set, the
> power button will instead send the configured signal to init. (For
> instance, sending SIGINT will make the power button simulate
> ctrl-alt-del.)
>
> Signed-off-by: Josh Triplett <josh@joshtriplett.org>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  6 ++++++
>  drivers/acpi/button.c                           | 11 +++++++++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index ade4e6ec23e0..bbb598e148f4 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -450,6 +450,12 @@
>                         firmware feature for flushing multiple hpte entries
>                         at a time.
>
> +       button.power_signal=
> +                       [ACPI] When the power button is pressed, send this
> +                       signal number to the init process. If set to 0
> +                       (default), do not send a signal.
> +                       Format: integer
> +
>         c101=           [NET] Moxa C101 synchronous serial card
>
>         cachesize=      [BUGS=X86-32] Override level 2 CPU cache size detection.
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index b758b45737f5..923259f132d6 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -14,6 +14,7 @@
>  #include <linux/init.h>
>  #include <linux/types.h>
>  #include <linux/proc_fs.h>
> +#include <linux/sched/signal.h>
>  #include <linux/seq_file.h>
>  #include <linux/input.h>
>  #include <linux/slab.h>
> @@ -167,6 +168,10 @@ static unsigned long lid_report_interval __read_mostly = 500;
>  module_param(lid_report_interval, ulong, 0644);
>  MODULE_PARM_DESC(lid_report_interval, "Interval (ms) between lid key events");
>
> +static int power_signal __read_mostly = 0;
> +module_param(power_signal, int, 0644);
> +MODULE_PARM_DESC(power_signal, "Power button sends this signal to init");
> +
>  /* --------------------------------------------------------------------------
>                                FS Interface (/proc)
>     -------------------------------------------------------------------------- */
> @@ -426,6 +431,12 @@ static void acpi_button_notify(struct acpi_device *device, u32 event)
>                         if (button->suspended)
>                                 break;
>
> +                       if (power_signal
> +                           && button->type == ACPI_BUTTON_TYPE_POWER) {
> +                               kill_cad_pid(power_signal, 1);
> +                               break;
> +                       }
> +
>                         keycode = test_bit(KEY_SLEEP, input->keybit) ?
>                                                 KEY_SLEEP : KEY_POWER;
>                         input_report_key(input, keycode, 1);
> --
> 2.25.0.rc2
>
