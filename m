Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B59F3D9FD8
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jul 2021 10:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234995AbhG2IvS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Jul 2021 04:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234972AbhG2IvR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Jul 2021 04:51:17 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB5DC061757;
        Thu, 29 Jul 2021 01:51:14 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id a20so6228091plm.0;
        Thu, 29 Jul 2021 01:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dUj1P0AzqgAchl6jA4S00J/qZkPPxZhkbN+Xiq2WGLg=;
        b=KE/xuk+tQes5WMjruTwfyOGEf/oypE+UxtXolXbVeER79Jx0e0A6DzTemjPsErkjl4
         aToUKo1z40Rizuuc+jAY1VMpMphzGOjMzcfhkcrnPybXx5GVZuNhUpt7J0eLIy44YSfM
         sHfdKj+giWFH1ArUTporkXUkNu1b2/V6OUIjbGzV1Ard4qGfyyFh7hJSdiUso0ZGtYgg
         MRYgDWy08RaLZt1ZuNs5FOKaEycDzUac+jHIPWN/11YySfe+1+y0Nkk4rq+ul1oI/ZG5
         0UJbCKAdcJmv8pqjZ2Rat1tZyiuI/4vag/yqqDSYl4DAyxBO1T0HGG6bZS/AxYAEnl9J
         FbFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dUj1P0AzqgAchl6jA4S00J/qZkPPxZhkbN+Xiq2WGLg=;
        b=ECWtgcgWZALf+mRDmSqguecqu0NZBV5PBkpEgu5BJwaoOBgtjS6fc6sX8qj415CtiT
         kIt9xhBggzQq7uQh97074otI+LkRZUakY5stwHwp8d9IdPXD24ar63RLtnzgI7UHg5uc
         /YpDrENoeTomFMSQlrJ9TalSKyUtF1SgWa/TAKxsZTPEtoF0GxTJk21SNyXLAYIfEIQM
         mF1dRtOLNsHb5QQijz0HUPiSNA/t2Ke0I1CaeHDsZM4QpFX36VNLx+8fwzAORN7w430h
         dXXZuehqfeeLqBMr0nOmAAf8/FLoK1ZnGrGfPiYz/lXjCiMFlcAod1kSydzDVzlphyBv
         bv4w==
X-Gm-Message-State: AOAM530yr4Pi0Lnzmw4PhGPvQ9dgwRyQ59vOPaoyW4vKGXMxnYqvt/4b
        KHSYe/qHSD1G1ww9gc2M/GeGNwMd3MOhy5vGF4Y=
X-Google-Smtp-Source: ABdhPJxGvvBYQQfLVOUEU+msxBkX/nG2hHGPlAr9mzt1LgWZM8NbXWxR0DObemlrxKoczMEPnACKb4uFOb/MPU4UYw4=
X-Received: by 2002:a63:d014:: with SMTP id z20mr2853429pgf.203.1627548673835;
 Thu, 29 Jul 2021 01:51:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210729082134.6683-1-hdegoede@redhat.com> <CAHp75VepyNqwLSDaDmc+XCk+_gC5+zGUQ51DOo7KUt2-Gaty-Q@mail.gmail.com>
 <7e6402dd-ec83-5014-8165-95e45cd3169f@redhat.com>
In-Reply-To: <7e6402dd-ec83-5014-8165-95e45cd3169f@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 29 Jul 2021 11:50:34 +0300
Message-ID: <CAHp75VeeN7KYifZ7K82CKmj4QKexAu2cK1pqXaj_coMPO4Q8ZQ@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: Add and use a dual_accel_detect() helper
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <mgross@linux.intel.com>,
        Andy Shevchenko <andy@infradead.org>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Mark Pearson <markpearson@lenovo.com>,
        Thinkpad-acpi devel ML <ibm-acpi-devel@lists.sourceforge.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Julius Lehmann <julius@devpi.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jul 29, 2021 at 11:45 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 7/29/21 10:37 AM, Andy Shevchenko wrote:
> > On Thu, Jul 29, 2021 at 11:21 AM Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> Various 360 degree hinges (yoga) style 2-in-1 devices use 2 accelerometers
> >> to allow the OS to determine the angle between the display and the base of
> >> the device.
> >>
> >> On Windows these are read by a special HingeAngleService process which
> >> calls undocumented ACPI methods, to let the firmware know if the 2-in-1 is
> >> in tablet- or laptop-mode. The firmware may use this to disable the kbd and
> >> touchpad to avoid spurious input in tablet-mode as well as to report
> >> SW_TABLET_MODE info to the OS.
> >>
> >> Since Linux does not call these undocumented methods, the SW_TABLET_MODE
> >> info reported by various pdx86 drivers is incorrect on these devices.
> >>
> >> Before this commit the intel-hid and thinkpad_acpi code already had 2
> >> hardcoded checks for ACPI hardware-ids of dual-accel sensors to avoid
> >> reporting broken info.
> >>
> >> And now we also have a bug-report about the same problem in the intel-vbtn
> >> code. Since there are at least 3 different ACPI hardware-ids in play, add
> >> a new dual_accel_detect() helper which checks for all 3, rather then
> >> adding different hardware-ids to the drivers as bug-reports trickle in.
> >> Having shared code which checks all known hardware-ids is esp. important
> >> for the intel-hid and intel-vbtn drivers as these are generic drivers
> >> which are used on a lot of devices.
> >>
> >> The BOSC0200 hardware-id requires special handling, because often it is
> >> used for a single-accelerometer setup. Only in a few cases it refers to
> >> a dual-accel setup, in which case there will be 2 I2cSerialBus resources
> >> in the device's resource-list, so the helper checks for this.
> >
> > ...
> >
> >> +static int dual_accel_i2c_resource_count(struct acpi_resource *ares, void *data)
> >> +{
> >> +       struct acpi_resource_i2c_serialbus *sb;
> >> +       int *count = data;
> >> +
> >> +       if (i2c_acpi_get_i2c_resource(ares, &sb))
> >> +               *count = *count + 1;
> >> +
> >> +       return 1;
> >> +}
> >
> > It will be a third copy of this in the kernel.
> > Let's put it to i2c.h or somewhere available for all these users.
> >
> >> +
> >> +static int dual_accel_i2c_client_count(struct acpi_device *adev)
> >> +{
> >> +       int ret, count = 0;
> >> +       LIST_HEAD(r);
> >> +
> >> +       ret = acpi_dev_get_resources(adev, &r, dual_accel_i2c_resource_count, &count);
> >> +       if (ret < 0)
> >> +               return ret;
> >> +
> >> +       acpi_dev_free_resource_list(&r);
> >> +       return count;
> >> +}
> >
> > So does this.
> >
> > Taking into account that this is a bug fix, I'm okay if you do above
> > as an additional patch (or patches) on top of this.
>
> Right, I had a note about this behind the cut (---) line, but I dropped
> the patch and git-am-ed it while reworking my tree for some other issue
> dropping the note (sorry), the note was:
>
> """
> ---
> Note the counting of the number of I2cSerialBus resources in an
> ACPI-device's resource-list is becoming a common pattern. I plan
> to add a new shared helper for this in a follow-up patch-set.
> I've deliberately not made use of such a new helper in this patch
> for easier backporting to the stable series.
> """
>
> In other words, I fully agree. I've already added an item to my
> TODO list about doing a followup series to replace the 3 copies in:

With this promise taken
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

>  drivers/platform/x86/dual_accel_detect.h
>  drivers/platform/x86/i2c-multi-instantiate.c
>  drivers/platform/x86/intel/int33fe/intel_cht_int33fe_common.c
>
> With a new helper in drivers/i2c/i2c-core-acpi.c, like the
> i2c_acpi_get_i2c_resource() helper which was recently added.


-- 
With Best Regards,
Andy Shevchenko
