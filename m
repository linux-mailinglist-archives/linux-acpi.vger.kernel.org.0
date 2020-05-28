Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D5E1E5EB0
	for <lists+linux-acpi@lfdr.de>; Thu, 28 May 2020 13:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388491AbgE1Lu0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 28 May 2020 07:50:26 -0400
Received: from mail-oo1-f67.google.com ([209.85.161.67]:44936 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388480AbgE1LuZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 28 May 2020 07:50:25 -0400
Received: by mail-oo1-f67.google.com with SMTP id u40so2700353ooi.11;
        Thu, 28 May 2020 04:50:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XLJo2hS383AKVmW050P0lpuDCi+PHLJHoR9wahnQtWc=;
        b=dRdL4y045cp1ZR/cq/uemDDMCoGySk2ccmID2d/SmIiydSLjsl6Zm655+qdmxfYzjX
         8znY7/8Bml5+kd1xP+DSWnCxMZE0FmhgLIXZO+N7wqnm+Sl3b/4hOQ8DMxsA8hOxzJY9
         3hyVz2Ng+tA7hpIiKeh4D2YYWFNI244VgWR4OBsxFqihVrpl5fW6k00VjIwbAplxBi+L
         6RmAZbJ+RsDK6Q36RCS30MNEpXJ1nU+de1JO/8uMxAchDqfPAwkP5YjMjA/7ytELyHaj
         9hgGqu0LgIWtcFOzhbn3qGOqKE+hyuMUaS6sxV/W9FqiBd1w7tWLX70Dn1TY7fp1ASCu
         Y3ow==
X-Gm-Message-State: AOAM531DAugSCzKZpdMOO5WRjePbdacVcK4OBfuYGC1G2/pJNnPkWOg+
        Qwk8D5XUAHBwU0JSm62/cJMZG1/rpZFtfk5GX4w=
X-Google-Smtp-Source: ABdhPJyXSh7LDat7dDoI7pFL7G1eRu8tjzqfouImv88Dg/hXTeHDI7LOUBh4MsuEIm0PHOhyaTKRrDYxG5jGh0jqasc=
X-Received: by 2002:a4a:e0d1:: with SMTP id e17mr2146272oot.1.1590666623991;
 Thu, 28 May 2020 04:50:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200527211717.14956-1-wu000273@umn.edu>
In-Reply-To: <20200527211717.14956-1-wu000273@umn.edu>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 28 May 2020 13:50:12 +0200
Message-ID: <CAJZ5v0gTQVMYgfXNUs=3jDv0zzT3RVuwJ_OfzzOwTQkT-0W=ZQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: sysfs: Fix reference count leak in acpi_sysfs_add_hotplug_profile.
To:     wu000273@umn.edu
Cc:     Kangjie Lu <kjlu@umn.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Toshi Kani <toshi.kani@hp.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, May 27, 2020 at 11:17 PM <wu000273@umn.edu> wrote:
>
> From: Qiushi Wu <wu000273@umn.edu>
>
> kobject_init_and_add() takes reference even when it fails.
> Thus, when kobject_init_and_add() returns an error,
> kobject_put() must be called to properly clean up the kobject.
>
> Fixes: 3f8055c35836 ("ACPI / hotplug: Introduce user space interface for hotplug profiles")
> Signed-off-by: Qiushi Wu <wu000273@umn.edu>
> ---
>  drivers/acpi/sysfs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
> index c60d2c6d31d6..3a89909b50a6 100644
> --- a/drivers/acpi/sysfs.c
> +++ b/drivers/acpi/sysfs.c
> @@ -993,8 +993,10 @@ void acpi_sysfs_add_hotplug_profile(struct acpi_hotplug_profile *hotplug,
>
>         error = kobject_init_and_add(&hotplug->kobj,
>                 &acpi_hotplug_profile_ktype, hotplug_kobj, "%s", name);
> -       if (error)
> +       if (error) {
> +               kobject_put(&hotplug->kobj);
>                 goto err_out;
> +       }
>
>         kobject_uevent(&hotplug->kobj, KOBJ_ADD);
>         return;
> --

Applied as 5.8 material, thanks!
