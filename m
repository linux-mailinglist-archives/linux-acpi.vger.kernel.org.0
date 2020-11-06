Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF0F2A9199
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Nov 2020 09:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgKFIgq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 Nov 2020 03:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbgKFIgp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Nov 2020 03:36:45 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86732C0613D3
        for <linux-acpi@vger.kernel.org>; Fri,  6 Nov 2020 00:36:45 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id i193so468094yba.1
        for <linux-acpi@vger.kernel.org>; Fri, 06 Nov 2020 00:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qEZLCwayVmjTSz55WLFDrASQyKwm9AzKbv8zrefCiDk=;
        b=Ji/jXL4wApkUI69Y5av8UFEa6ZvMG8Mm7sMdeBuZf7EoU4V1ZJLIvyslti7xbYYgOo
         7sI5169sAiOnVjscRjwLSG5mTCDgJbsvvoyW7NaM+rXP+TANNYM9GzJTJeHzh5IJBSn6
         jCu4ranqabbyvqfRRUp8VUmP12hOGnUWANJ2MHUcQuqSD+QuRogFeUpnHgYeTln5Ymb2
         IxW851j1Otp0qXE2KbajHox2eLThi38VBbZU7+cZkmlqcN1NRpsNCkHTGxZofwDuILfd
         YJVqD/sCpYRPLK+Qa+6GsSNblgKHxW6x/FkEn9nScueY9kHi8mFdGrFX2iHrBlCcY0aX
         0Zzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qEZLCwayVmjTSz55WLFDrASQyKwm9AzKbv8zrefCiDk=;
        b=ocr/bi0FSTspjjBWEhPV02rG4BMxT5VgRfx+5V30b/K+3FipGDFY63JY4jwaxH6t3A
         3+w6/nrXCHaG8mWd+4Ff2tPRJM8JlFM5vQePKGX05fRKhWTKq0b2OodOghpKJN7yCgAS
         Re3nyU7aWz/311MYpYNnZjiz6RD5QzxKELv9qQphVYj8MV6KEA3/h3ZY/+9Vq1YK+feu
         pQuXGiT4DWuEeG5/DFLAlbFjz4eBmeAk42duhioO0/oAh6EYsTtT24dOa+kNBa/AaKpe
         7B3jbzNUtcomhiqaaDkcIG1kiK7Cmv5HYVArYAPOZ7yCaKp3EKixT8yq6p2nQlZvXDTQ
         tJaQ==
X-Gm-Message-State: AOAM53194XISEed1Qf8a3YlAd1gZaJS5aHqQ8hxY0XSt9fY+XY3l2eei
        8Q0cayKjJ1CV8iUOwkM/2dGTIPAyG20nrFut/9eV3g==
X-Google-Smtp-Source: ABdhPJzvDcNdXHjO7nYfSMx7aYo6WWdRNoKpDm3K2m0Ae6MfNyULyjym/ptGih8ndA11+PnN2rHt+iT8lQNTMQ3Kip0=
X-Received: by 2002:a25:d2c5:: with SMTP id j188mr1358442ybg.32.1604651804489;
 Fri, 06 Nov 2020 00:36:44 -0800 (PST)
MIME-Version: 1.0
References: <20201104232356.4038506-1-saravanak@google.com> <20201106050940.GG16469@pendragon.ideasonboard.com>
In-Reply-To: <20201106050940.GG16469@pendragon.ideasonboard.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 6 Nov 2020 00:36:08 -0800
Message-ID: <CAGETcx-rvTuEmJUsf6qP3WkPLOh6m6cy8E_LsJPoGejNOXrdcw@mail.gmail.com>
Subject: Re: [PATCH v1 00/18] Refactor fw_devlink to significantly improve
 boot time
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Android Kernel Team <kernel-team@android.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 5, 2020 at 9:09 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Saravana,
>
> Thank you for working on this !
>
> On Wed, Nov 04, 2020 at 03:23:37PM -0800, Saravana Kannan wrote:
> > The current implementation of fw_devlink is very inefficient because it
> > tries to get away without creating fwnode links in the name of saving
> > memory usage. Past attempts to optimize runtime at the cost of memory
> > usage were blocked with request for data showing that the optimization
> > made significant improvement for real world scenarios.
> >
> > We have those scenarios now. There have been several reports of boot
> > time increase in the order of seconds in this thread [1]. Several OEMs
> > and SoC manufacturers have also privately reported significant
> > (350-400ms) increase in boot time due to all the parsing done by
> > fw_devlink.
> >
> > So this patch series refactors fw_devlink to be more efficient. The key
> > difference now is the addition of support for fwnode links -- just a few
> > simple APIs. This also allows most of the code to be moved out of
> > firmware specific (DT mostly) code into driver core.
> >
> > This brings the following benefits:
> > - Instead of parsing the device tree multiple times (complexity was
> >   close to O(N^3) where N in the number of properties) during bootup,
> >   fw_devlink parses each fwnode node/property only once and creates
> >   fwnode links. The rest of the fw_devlink code then just looks at these
> >   fwnode links to do rest of the work.
> >
> > - Makes it much easier to debug probe issue due to fw_devlink in the
> >   future. fw_devlink=on blocks the probing of devices if they depend on
> >   a device that hasn't been added yet. With this refactor, it'll be very
> >   easy to tell what that device is because we now have a reference to
> >   the fwnode of the device.
> >
> > - Much easier to add fw_devlink support to ACPI and other firmware
> >   types. A refactor to move the common bits from DT specific code to
> >   driver core was in my TODO list as a prerequisite to adding ACPI
> >   support to fw_devlink. This series gets that done.
> >
> > Tomi/Laurent/Grygorii,
> >
> > If you can test this series, that'd be great!
>
> I gave it a try, rebasing my branch from v5.9 to v5.10-rc2 first. On
> v5.10-rc2 the kernel dies when booting due to a deadlock (reported by
> lockdep, so hopefully not too hard to debug). *sigh*. Fortunately, it
> dies after the fw_devlink initialization, so I can still report results.

Phew! For a sec I thought you said fw_devlink was causing a deadlock.

>
> Before your series:
>
> [    0.743065] cpuidle: using governor menu
> [   13.350259] No ATAGs?
>
> With your series applied:
>
> [    0.722670] cpuidle: using governor menu
> [    1.135859] No ATAGs?
>
> That's a very clear improvement :-)

Thanks for testing. Great to hear it's helping!

> Tested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

I'll add it to my v2 series.

-Saravana
