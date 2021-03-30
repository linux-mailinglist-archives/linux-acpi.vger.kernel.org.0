Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8E7C34F1CF
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Mar 2021 21:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbhC3Tua (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 30 Mar 2021 15:50:30 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:37886 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbhC3TuJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Mar 2021 15:50:09 -0400
Received: by mail-oi1-f176.google.com with SMTP id k25so17663266oic.4
        for <linux-acpi@vger.kernel.org>; Tue, 30 Mar 2021 12:50:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uyi8sqIWurInIw+1QesUwI7szlN53A/dIS2t4a6NLjY=;
        b=OGKZ1H8D8EV333EMPoDEpfH/Zb2Q3wdPTcalD0tCp6LS7AhGec5My9qUV6yiJTiQuC
         lm4Y4TDqUrWaUMqZ74w4nfrKkQh2xh3hxWAReYmaufLyOIxqPAlAFV86mu3flIdHRSpL
         0CE5uMCHZGBudHETDmRISc4x5NLcn0zR9Ku9Mi69Y5c0+KfWyqOjtKQ8tWL2bkFAZ4Q9
         +SX+nlt1BWtRqICd6h+7di4w+SJO6GXNJNFUDWGWKksDlLWfzXwqdIupPRwVULzrLmTb
         aWQHNSWcOKB7OLWQjKZ6Gv10BlR9XKkqPdyUL9pn6STPTtQ3M3lxNr3O1OUFlGAdbUZp
         +UEg==
X-Gm-Message-State: AOAM531WKaxPrSY1o6iz8fgwruAtHotTVTd3wrVDT1n39tKOiIV7KX5F
        rdQh1H/Kri0QCXGwULeSP1b/+W2fZebM6ZRMqus=
X-Google-Smtp-Source: ABdhPJziL4CK5EYOObx5V0qrQ0X8emgGwvasCliq3KgrUpaQCJEBpBjvWdZRUlxiQzIKNyl1CZf/v6p5tOGTzghMhDQ=
X-Received: by 2002:a05:6808:24b:: with SMTP id m11mr4512007oie.157.1617133808514;
 Tue, 30 Mar 2021 12:50:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210330184932.16027-1-hdegoede@redhat.com>
In-Reply-To: <20210330184932.16027-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 30 Mar 2021 21:49:57 +0200
Message-ID: <CAJZ5v0iaCojpt3SVBnO7Ok55FzcnGFJ-eGG4Py8o6geaLcGUbQ@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: scan: Fix _STA getting called on devices with
 unmet dependencies
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 30, 2021 at 8:50 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Commit 71da201f38df ("ACPI: scan: Defer enumeration of devices with
> _DEP lists") dropped the following 2 lines from acpi_init_device_object():
>
>         /* Assume there are unmet deps until acpi_device_dep_initialize() runs */
>         device->dep_unmet = 1;
>
> Leaving the initial value of dep_unmet at the 0 from the kzalloc(). This
> causes the acpi_bus_get_status() call in acpi_add_single_object() to
> actually call _STA, even though there maybe unmet deps, leading to errors
> like these:
>
> [    0.123579] ACPI Error: No handler for Region [ECRM] (00000000ba9edc4c)
>                [GenericSerialBus] (20170831/evregion-166)
> [    0.123601] ACPI Error: Region GenericSerialBus (ID=9) has no handler
>                (20170831/exfldio-299)
> [    0.123618] ACPI Error: Method parse/execution failed
>                \_SB.I2C1.BAT1._STA, AE_NOT_EXIST (20170831/psparse-550)
>
> Fix this by re-adding the dep_unmet = 1 initialization to
> acpi_init_device_object() and modifying acpi_bus_check_add() to make sure
> that dep_unmet always gets setup there, overriding the initial 1 value.
>
> This re-fixes the issue initially fixed by
> commit 63347db0affa ("ACPI / scan: Use acpi_bus_get_status() to initialize
> ACPI_TYPE_DEVICE devs"), which introduced the removed
> "device->dep_unmet = 1;" statement.
>
> This issue was noticed; and the fix tested on a Dell Venue 10 Pro 5055.
>
> Fixes: 71da201f38df ("ACPI: scan: Defer enumeration of devices with _DEP lists")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> - Simplify, making it more like the original 63347db0affa commit
>
> Changes in v3:
> - Fix brown paper-bag bug where dep_unmet was not reset to 0 at the start of
>   acpi_scan_dep_init()

I've replaced the previous version of the patch with this one, thanks!

> ---
>  drivers/acpi/scan.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 1584c9e463bd..24490db82531 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1647,6 +1647,8 @@ void acpi_init_device_object(struct acpi_device *device, acpi_handle handle,
>         device_initialize(&device->dev);
>         dev_set_uevent_suppress(&device->dev, true);
>         acpi_init_coherency(device);
> +       /* Assume there are unmet deps to start with. */
> +       device->dep_unmet = 1;
>  }
>
>  void acpi_device_add_finalize(struct acpi_device *device)
> @@ -1910,6 +1912,8 @@ static void acpi_scan_dep_init(struct acpi_device *adev)
>  {
>         struct acpi_dep_data *dep;
>
> +       adev->dep_unmet = 0;
> +
>         mutex_lock(&acpi_dep_list_lock);
>
>         list_for_each_entry(dep, &acpi_dep_list, node) {
> @@ -1957,7 +1961,13 @@ static acpi_status acpi_bus_check_add(acpi_handle handle, bool check_dep,
>                 return AE_CTRL_DEPTH;
>
>         acpi_scan_init_hotplug(device);
> -       if (!check_dep)
> +       /*
> +        * If check_dep is true at this point, the device has no dependencies,
> +        * or the creation of the device object would have been postponed above.
> +        */
> +       if (check_dep)
> +               device->dep_unmet = 0;
> +       else
>                 acpi_scan_dep_init(device);
>
>  out:
> --
> 2.30.2
>
