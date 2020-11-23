Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AADA92C114C
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Nov 2020 18:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390205AbgKWRCf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Nov 2020 12:02:35 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34383 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387757AbgKWRCf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Nov 2020 12:02:35 -0500
Received: by mail-ot1-f65.google.com with SMTP id h19so3930240otr.1;
        Mon, 23 Nov 2020 09:02:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0lGM4pOPvAmkdRh3kP6eJPs9iYpu5tJR7XH1PIxCUmM=;
        b=Pv7plHtcmS+Ov8zY1kf7+xi2lBlKtOaqVNPwKaazM7X4mA9/UKSMU+A7P7PQYenz3k
         n5F+7QpOS6pYGCqIlM35Z7aAevusrh8Sn4y/T57rGey+wX3hD3TtV/R3kwykG6ZNrm4j
         bGwNfiMIR6CELoMpFqy9mxVFF6wCDDL6xEywvwEKWSOlqj6BzJ68D7KQHwVkNxxfGRXN
         gUFZlx+TvVN5czDDuIHM+qtQy3TQuZQovP1rSq1iL2jndIpq0WerJgqxWrzs+KeiXJ5f
         3WQAv6BxXW1RMN3B84x/TytK9a+Z/AylP1AZfT8X0jP1ckN2I/zPL44cSK8dCIbPQZJv
         WZ+g==
X-Gm-Message-State: AOAM530K3yv4/FlImwQmk9qVIxqi05/oZXvE1MXdxBFfZTakLkDam5Z2
        AM1kj1xPHFPL5yX2m8sn9byezjwot6WN2rnrXvQs7H/+l74=
X-Google-Smtp-Source: ABdhPJwyCdVjVibPqKrQy4Lj7nZfu82474LEJlTPdJCRpsaDGQ6SLPYaUcR9e9CSN9uaQ+ctlMQPylBDJuBQMtMH0ho=
X-Received: by 2002:a9d:16f:: with SMTP id 102mr207668otu.206.1606150954566;
 Mon, 23 Nov 2020 09:02:34 -0800 (PST)
MIME-Version: 1.0
References: <20201120111125.78296-1-f.suligoi@asem.it>
In-Reply-To: <20201120111125.78296-1-f.suligoi@asem.it>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 23 Nov 2020 18:02:23 +0100
Message-ID: <CAJZ5v0jTLcvcyzKRvM6N_2xJq94PseUNtd5xCPpS59Nz4VvWnQ@mail.gmail.com>
Subject: Re: [PATCH v2] docs: ACPI: enumeration: add PCI hierarchy representation
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-gpio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Nov 20, 2020 at 12:12 PM Flavio Suligoi <f.suligoi@asem.it> wrote:
>
> For "fixed" PCI devices, such as chips directly soldered
> on the main board (ethernet, Wi-Fi, serial ports, etc.),
> it is possible to find an ACPI enumeration.
>
> This allows to add useful properties to these devices.
> Just for an example: the property "gpio-line-names" can be
> added to the pins of a GPIO expander on the PCI bus.
>
> In order to find the ACPI name of a PCI device, it's necessary
> to disassemble the BIOS ACPI tables (in particular the DSDT)
> and also to analyze the PCI bus topology of the board.
>
> This patch, with a practical example, show how to do this.
>
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> ---

Applied as 5.11 material with the R-by tags from Mika and Andy, thanks!
