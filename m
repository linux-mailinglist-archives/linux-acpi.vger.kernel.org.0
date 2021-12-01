Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6972C465646
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Dec 2021 20:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245106AbhLATYi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 1 Dec 2021 14:24:38 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]:44774 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240750AbhLATYd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Dec 2021 14:24:33 -0500
Received: by mail-ot1-f49.google.com with SMTP id u18-20020a9d7212000000b00560cb1dc10bso36649614otj.11
        for <linux-acpi@vger.kernel.org>; Wed, 01 Dec 2021 11:21:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mA1S+Gr5WL+7eBSXmqPLpGfI63I4GFoVjttcF9lrnuY=;
        b=2kP+C2vm3uBLgzjX5C0R1pkrLxH4kNx4et2q5msgSMPBBls0mcOi4XR3GIV+Z74g+w
         YOS9Nrdjksauyfunox7PEE12qCy8j4ihLjFA0ELF5UPHpUHig+tsYcxYbXc1wAxfRfM7
         R1yge+WrMT4mz1BBjRs1upLwMdzEcJnDbOltND0zrg7cCzJQAA56J77d181wwjL6GOVF
         v9o0c0+QmxotIB70w059Y4DmT5srINO6hd4IZEimZodyp9jRX4nT50uDRQ3uigTMzdvE
         mWBJkHTAW40I/rrqzqSeekIBGfiZlnp74bX2cdFzooxx5IpD/flO/IQShu/jbO9jeb5O
         AEbQ==
X-Gm-Message-State: AOAM5338XnjO+1I4Jy957m8E36Zy0rYF7HkkYzHv6k54WFjh1wsHVwNh
        Z5JoBfYYwhilfDeqIl6Onem4nenu1/eedrGZjr0=
X-Google-Smtp-Source: ABdhPJyqufxX7XZTIZ8DMr0IE23EXdn9msjg00ulW/7MqGzVdiqstdExzNZHvuH7rH/LArql33hbHE+5RqYPn0fFzNc=
X-Received: by 2002:a9d:4c10:: with SMTP id l16mr7456569otf.198.1638386472021;
 Wed, 01 Dec 2021 11:21:12 -0800 (PST)
MIME-Version: 1.0
References: <20211125103616.47742-1-hdegoede@redhat.com> <6990b275-9a09-a135-8e9b-d5c963040770@lenovo.com>
In-Reply-To: <6990b275-9a09-a135-8e9b-d5c963040770@lenovo.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 1 Dec 2021 20:21:01 +0100
Message-ID: <CAJZ5v0itADsfGFjtRtbBXNEfpxTYBsGgrqHW5tghKcBwcwpCyg@mail.gmail.com>
Subject: Re: [External] [PATCH] ACPI / EC: Mark the ec_sys write_support param
 as module_param_hw()
To:     Mark Pearson <markpearson@lenovo.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Dec 1, 2021 at 3:06 PM Mark Pearson <markpearson@lenovo.com> wrote:
>
>
> On 2021-11-25 05:36, Hans de Goede wrote:
> > Using write_support=1 with the ec_sys module changes the mode of the
> > "io" debugfs file to 0600. This will cause any attempts to access it under
> > a kernel in lockdown mode to return -EPERM, which makes the entire ec_sys
> > module unusable.
> >
> > Use the special module_param_hw() macro for module parameters which
> > may not be used while in lockdown mode, to avoid this.
> >
> > Cc: Mark Pearson <markpearson@lenovo.com>
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > ---
> >  drivers/acpi/ec_sys.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/ec_sys.c b/drivers/acpi/ec_sys.c
> > index fd39c14493ab..c074a0fae059 100644
> > --- a/drivers/acpi/ec_sys.c
> > +++ b/drivers/acpi/ec_sys.c
> > @@ -19,7 +19,7 @@ MODULE_DESCRIPTION("ACPI EC sysfs access driver");
> >  MODULE_LICENSE("GPL");
> >
> >  static bool write_support;
> > -module_param(write_support, bool, 0644);
> > +module_param_hw(write_support, bool, other, 0644);
> >  MODULE_PARM_DESC(write_support, "Dangerous, reboot and removal of battery may "
> >                "be needed.");
> >
> >
> Looks good to me. Thanks Hans
> Mark

Patch applied as 5.17 material, thanks!
