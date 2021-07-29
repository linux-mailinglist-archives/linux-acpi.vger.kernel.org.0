Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 315AF3D9FAE
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jul 2021 10:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235206AbhG2Ihr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Jul 2021 04:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235035AbhG2Ihr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Jul 2021 04:37:47 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4FEC061757;
        Thu, 29 Jul 2021 01:37:44 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id e2-20020a17090a4a02b029016f3020d867so8194457pjh.3;
        Thu, 29 Jul 2021 01:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EsrfTvny/SpzJRbB7yoAhloVOqEJbXPedO1ke9Lw82Y=;
        b=M76cyDQcjfsuDEkSnUD2bWiws7Vcq5lLpCBBh4QGVSzp78nf6GBA+bpWD1vvOIkQdc
         jcYXl1LmJSDRA1wTnm/OGTtZq/WspSqSTOwNkeTIAk42PtKxPkZ58I1h03F0Cd1xYY31
         SCgPQUSP2/VlTEVXaiN6tf5yv5SHHUqukZ8D/tQ30RTv6OO9l+L+PqTDXiYGYx1nMirv
         uPFBcAn8gaQaCNdNfgqHSjx0FAAisg9GnaV6qTH9DNME/r/xv/NL/DuhhfIs5R//F8cv
         /eD9LQi4mGEV+DGg2a7ycskyG3gfZ5YMXHk+xlhTzAtVWbdM5zyG0YM8oMFPhHN/NTUp
         i+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EsrfTvny/SpzJRbB7yoAhloVOqEJbXPedO1ke9Lw82Y=;
        b=SKMHpAbgbnoPwd2U7cWo2IsqBdJNwn33LA+Ep/CEcdwWYb9h9JpUD+KKmO+GYti3GC
         6ae3KxHVSkneG6bjhOl5quLzZF+V5tEFrUwMn430dFoK8rKULzc0JtC67nVsCqzEmgQa
         4n4FKFH7LYJz3mTivUmd0h7yG/TY1BNEl3cIAn5cNCI2lCicPm5FkR5trg3GEqHaLBSZ
         NJSx72fEaJN71xQxVb3jxlldAk82TMb+14r3J9ejlbC62tSju4tuTmpoEMnlKqjsrgoA
         rxUCoke1Ao+etasv0psaS3w6WBEybZVl2I7uqE7wcE0BR6kFUG0n2lzokFdi4YO+QH4j
         4pWA==
X-Gm-Message-State: AOAM530lwWO38XSmFnQdrqqfL3TT0UMJGE0KtD1/R5nLPc0ySuwf9U/6
        61llZZEqdDE6g9Elr5v0gHP20oyjsQTX4W5J6KI=
X-Google-Smtp-Source: ABdhPJzwrcm4RQAm4C1p1Rn8af5HkQIAJqwrrsYynFizjWfO6+au8SYAk+BLwfxghFP9rTUHccYIOIsuBe40dFx8tw8=
X-Received: by 2002:a63:5a5b:: with SMTP id k27mr2916152pgm.74.1627547863853;
 Thu, 29 Jul 2021 01:37:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210729082134.6683-1-hdegoede@redhat.com>
In-Reply-To: <20210729082134.6683-1-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 29 Jul 2021 11:37:04 +0300
Message-ID: <CAHp75VepyNqwLSDaDmc+XCk+_gC5+zGUQ51DOo7KUt2-Gaty-Q@mail.gmail.com>
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

On Thu, Jul 29, 2021 at 11:21 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Various 360 degree hinges (yoga) style 2-in-1 devices use 2 accelerometers
> to allow the OS to determine the angle between the display and the base of
> the device.
>
> On Windows these are read by a special HingeAngleService process which
> calls undocumented ACPI methods, to let the firmware know if the 2-in-1 is
> in tablet- or laptop-mode. The firmware may use this to disable the kbd and
> touchpad to avoid spurious input in tablet-mode as well as to report
> SW_TABLET_MODE info to the OS.
>
> Since Linux does not call these undocumented methods, the SW_TABLET_MODE
> info reported by various pdx86 drivers is incorrect on these devices.
>
> Before this commit the intel-hid and thinkpad_acpi code already had 2
> hardcoded checks for ACPI hardware-ids of dual-accel sensors to avoid
> reporting broken info.
>
> And now we also have a bug-report about the same problem in the intel-vbtn
> code. Since there are at least 3 different ACPI hardware-ids in play, add
> a new dual_accel_detect() helper which checks for all 3, rather then
> adding different hardware-ids to the drivers as bug-reports trickle in.
> Having shared code which checks all known hardware-ids is esp. important
> for the intel-hid and intel-vbtn drivers as these are generic drivers
> which are used on a lot of devices.
>
> The BOSC0200 hardware-id requires special handling, because often it is
> used for a single-accelerometer setup. Only in a few cases it refers to
> a dual-accel setup, in which case there will be 2 I2cSerialBus resources
> in the device's resource-list, so the helper checks for this.

...

> +static int dual_accel_i2c_resource_count(struct acpi_resource *ares, void *data)
> +{
> +       struct acpi_resource_i2c_serialbus *sb;
> +       int *count = data;
> +
> +       if (i2c_acpi_get_i2c_resource(ares, &sb))
> +               *count = *count + 1;
> +
> +       return 1;
> +}

It will be a third copy of this in the kernel.
Let's put it to i2c.h or somewhere available for all these users.

> +
> +static int dual_accel_i2c_client_count(struct acpi_device *adev)
> +{
> +       int ret, count = 0;
> +       LIST_HEAD(r);
> +
> +       ret = acpi_dev_get_resources(adev, &r, dual_accel_i2c_resource_count, &count);
> +       if (ret < 0)
> +               return ret;
> +
> +       acpi_dev_free_resource_list(&r);
> +       return count;
> +}

So does this.

Taking into account that this is a bug fix, I'm okay if you do above
as an additional patch (or patches) on top of this.

-- 
With Best Regards,
Andy Shevchenko
