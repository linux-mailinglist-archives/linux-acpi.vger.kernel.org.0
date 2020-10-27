Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE04529C760
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Oct 2020 19:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1828384AbgJ0Sbp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 27 Oct 2020 14:31:45 -0400
Received: from mail-oo1-f67.google.com ([209.85.161.67]:38937 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1828382AbgJ0Sbo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Oct 2020 14:31:44 -0400
Received: by mail-oo1-f67.google.com with SMTP id c10so572184oon.6;
        Tue, 27 Oct 2020 11:31:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cgfDxBRqZFn1I8+lrk1v2IOdukgMx9CwviEf/qzFVes=;
        b=HixRlBPYT6Yur4+e1IC1zJojA0mc+iq5kufayHW9il9vtqAY/tgd0sO1LCOAbJJFyI
         5YvxRuOA1dmOIUHc4WR78ofkJeqZQnIVnwuGPeNdczDgAa3fNwCtDYhYLsoYJAGv8dWd
         DrAM+Kpxw2wXslcH/JslbgSuZZ4RomGhWuoGa8SWp3KvqmeJar+ezsO6uxaOgRc5R4O5
         xXehRB0IvyRjH3otB7EFSBXT9vWF+bVmDLygds5aZOfnDRP/Q+4c6chUxa/hqjy0pEMW
         ZqYrc383AWoq9neHhWcDcxjlSFEGZlMsVLuVQvVRSn+WOgyoghLpxTFhRfdfOf+MVpyK
         JJtQ==
X-Gm-Message-State: AOAM5320VIareMwk+xMjrqi5IIJCb0VI3euxgNxJ2gAr7jR1LFcaYIDQ
        r29Yct6oSADJ/8XwCd/TgTI+RSZbnYiJhSSbatxfqZ7q
X-Google-Smtp-Source: ABdhPJyCa2qbxR/oafdrncJLycfUCK4Q7+vHYbFgYsqizy2HNjDYmUdGrVixy4cGNeMUEMmr+6A2VSP4c6r4U/QkJBQ=
X-Received: by 2002:a4a:dc0d:: with SMTP id p13mr2770015oov.2.1603823503770;
 Tue, 27 Oct 2020 11:31:43 -0700 (PDT)
MIME-Version: 1.0
References: <20201026214838.3892471-1-arnd@kernel.org>
In-Reply-To: <20201026214838.3892471-1-arnd@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 27 Oct 2020 19:31:32 +0100
Message-ID: <CAJZ5v0hh2XSco-TdUS83piwpTyQk==VUo7nGi9+rKsK2P6u33g@mail.gmail.com>
Subject: Re: [PATCH] ACPI: dock: fix enum-conversion warning
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Yinghai Lu <yinghai@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Oct 26, 2020 at 10:48 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> gcc points out a type mismatch:
>
> drivers/acpi/dock.c: In function 'hot_remove_dock_devices':
> drivers/acpi/dock.c:234:53: warning: implicit conversion from 'enum <anonymous>' to 'enum dock_callback_type' [-Wenum-conversion]
>   234 |   dock_hotplug_event(dd, ACPI_NOTIFY_EJECT_REQUEST, false);
>
> This is harmless because 'false' still has the correct numeric value,
> but passing DOCK_CALL_HANDLER documents better what is going on
> and avoids the warning.
>
> Fixes: 37f908778f20 ("ACPI / dock: Walk list in reverse order during removal of devices")
> Fixes: f09ce741a03a ("ACPI / dock / PCI: Drop ACPI dock notifier chain")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/acpi/dock.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
> index 45d4b7b69de8..24e076f44d23 100644
> --- a/drivers/acpi/dock.c
> +++ b/drivers/acpi/dock.c
> @@ -231,7 +231,8 @@ static void hot_remove_dock_devices(struct dock_station *ds)
>          * between them).
>          */
>         list_for_each_entry_reverse(dd, &ds->dependent_devices, list)
> -               dock_hotplug_event(dd, ACPI_NOTIFY_EJECT_REQUEST, false);
> +               dock_hotplug_event(dd, ACPI_NOTIFY_EJECT_REQUEST,
> +                                  DOCK_CALL_HANDLER);
>
>         list_for_each_entry_reverse(dd, &ds->dependent_devices, list)
>                 acpi_bus_trim(dd->adev);
> --

Applied as 5.10-rc material, thanks!
