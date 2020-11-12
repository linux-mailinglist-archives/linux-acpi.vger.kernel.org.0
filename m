Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5B22B0DBF
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Nov 2020 20:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgKLTTY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Nov 2020 14:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgKLTTY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Nov 2020 14:19:24 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D30C0613D4
        for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2020 11:19:23 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id 79so6678949otc.7
        for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2020 11:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=N4Vjw5NC4RmM34mGJCQoJR5jl336pYDBdqYQzcnhD2k=;
        b=wQOtted5TwmSA/6KMVqdJrUMJkbajCVoJS/vff6xlEPpCBVenuIVSZv/eoR4aECruU
         d5V9anMmoMNkvoDTQjf2tyPVhJwR5WfpE83cfSXMn/A5pY0N4oU5OTzSC0vHY00g5YJc
         pLnDh+fitBnXEt3yN+fMJnDuO7xmfhbut9HECklTkhLonxKgK2jHxzATPK4bn0PACmPH
         ZEBl+d3dQm87CJzxWNyhyxFbZGCVaj9TKBlibYQ3klCUZBJYrVuqonsahLcyLbtVdVmy
         GPWcxnJ14W+fN58LZPwVNZyKR0KONiUMoGkVeROW2GdpLWW6Zt+/DWbAbch4RQdWczFy
         j15Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=N4Vjw5NC4RmM34mGJCQoJR5jl336pYDBdqYQzcnhD2k=;
        b=Taa5cUM9TAjRxjdGAxeinGXlBDv6MoZZ6kuf6j7lJ12m1cY7hECggOyHiYk0DXzz1A
         lzPW1QLXGZ3uLBcCNlj4xiiyDKpCPytuVkxak+gB0xTucPI4zDdiYo2GZxXMUH9q5ahQ
         SiRN7wIqhUr4GR7DVSjSu5aw/RqTD+DkGP43FVQ3IGgFm1ubm0YRzV6racwLNhB4tTZr
         6ngelh7B0YBdDxjPDuLNWe7PPy5Q7OrhlZ3Wmfk7Gid/29lZTH6RBDhBB5nNUXqVl4C+
         aUUnjSdUYZ1gUdhGAUGpdHAIae4PTk8o8O2v2d4xRzAf3QSRyQrB4z/Kw4WY4ESM6EDx
         m3ow==
X-Gm-Message-State: AOAM530XmhV9TfOXNA+7LpB0WhGeeygPsyrKmnIjH5HZLmOU2mE/gyMf
        K08muyh9jIK7SeSVte+Qo8ehe2fisji9y16ITsGR8KWbo65GnA==
X-Google-Smtp-Source: ABdhPJyAEghN6fo6Q0Pe+SPB/ZtVBBbw1BJCqlh/0z2EN0fhMSMVGGj6BZ/khYfF/MMmZSRuCZyyuC13lZFgW9t800s=
X-Received: by 2002:a05:6830:1e7a:: with SMTP id m26mr576926otr.104.1605208762515;
 Thu, 12 Nov 2020 11:19:22 -0800 (PST)
MIME-Version: 1.0
From:   Furquan Shaikh <furquan@google.com>
Date:   Thu, 12 Nov 2020 11:19:06 -0800
Message-ID: <CAEGmHFFjV2UKm3L1G5JF6Ve47L1-aKBAGrCxN3pPX1HO9R-aUg@mail.gmail.com>
Subject: [RFC] ACPI PM during kernel poweroff/reboot
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, Aaron Durbin <adurbin@google.com>,
        Duncan Laurie <dlaurie@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On x86 Chromebooks, we have observed this issue for a long time now -
when the system is powered off or rebooted, ACPI PM is not invoked and
this results in PowerResource _OFF methods not being invoked for any
of the devices. The _OFF methods are invoked correctly in case of
suspend-to-idle (S0ix) and suspend-to-memory(S3). However, they do not
get invoked when `poweroff` or `reboot` are triggered.

One of the differences between suspend, hibernate and shutdown paths
in Linux kernel is that the shutdown path does not use the typical
device PM phases (prepare, freeze/suspend, poweroff) as used by
suspend/hibernate. Instead the shutdown path makes use of
.shutdown_pre() and .shutdown() callbacks.

If I understand correctly, .shutdown() has been around for a long time
and existed even before the PM callbacks were added. Thus,
pm->poweroff() and .shutdown() are supposed to be analogous and
consistent in the behavior. This is why runtime PM is disallowed by
device_shutdown() before it calls .shutdown() (i.e. to keep behavior
consistent for both paths). However, in practice, there are
differences in behavior for the pm->poweroff() and .shutdown() paths
since the shutdown path does not execute any PM domain operations.

Because of this difference in behavior, shutdown path never invokes
ACPI PM and thus the ACPI PowerResources are not turned off when the
system is rebooted or powered off (sleep S5). On Chromebooks, it is
critical to run the _OFF methods for poweroff/reboot in order to
ensure that the device power off sequencing requirements are met.
Currently, these requirements are violated which impact the
reliability of devices over the lifetime of the platform.

There are a few ways in which this can be addressed:

1. Similar to the case of hibernation, a new
PMSG_POWEROFF/PM_EVENT_POWEROFF can be introduced to invoke device
power management phases using `dpm_suspend_start(PMSG_POWEROFF)` and
`dpm_suspend_end(PMSG_POWEROFF)`. However, as the shutdown path uses
the class/bus/driver .shutdown() callbacks, adding dpm phases for
poweroff complicates the order of operations. If the dpm phases are
run before .shutdown() callbacks, then it will result in the callbacks
accessing devices after they are powered off. If the .shutdown()
callbacks are run before dpm phases, then the pm->poweroff() calls are
made after the device shutdown is done. Since .shutdown() and
pm->poweroff() are supposed to be analogous, having both calls in the
shutdown path is not only redundant but also results in incorrect
behavior.

2. Another option is to update device_shutdown() to make
pm_domain.poweroff calls after the class/bus/driver .shutdown() is
done. However, this suffers from the same problem as #1 above i.e. it
is redundant and creates conflicting order of operations.

3. Third possible solution is to detach the device from the PM domain
after it is shutdown. Currently, device drivers perform a detach
operation only when the device is removed. However, in case of
poweroff/reboot as the device is already shutdown, detaching PM domain
will give it the opportunity to ensure that any power resources are
correctly turned off before the system shuts down.

Out of these, I think #3 makes the most sense as it does not introduce
any conflicting operations. I verified that the following diff results
in _OFF methods getting invoked in both poweroff and reboot cases:

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 94df2ba1bbed..e55d65fbb4a9 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -23,6 +23,7 @@
 #include <linux/of_device.h>
 #include <linux/genhd.h>
 #include <linux/mutex.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <linux/netdevice.h>
 #include <linux/sched/signal.h>
@@ -3230,6 +3231,8 @@ void device_shutdown(void)
                        dev->driver->shutdown(dev);
                }

+               dev_pm_domain_detach(dev, true);
+
                device_unlock(dev);
                if (parent)
                        device_unlock(parent);

This was discussed on the mailing list some time back[1] in the
context of a different use case. However, the idea of detaching
devices (on any bus) from the PM domain during shutdown is important
to ensure correct power sequencing for the devices.

One of the concerns that was raised on the above thread was slowing
down the shutdown process when not needed. I think this can be handled
by adding a sysfs attribute to allow platforms to decide if they need
the ability to power off PM domains on shutdown/reboot path.

Questions that I am looking to get feedback/comments are:

1. Is my assessment of the problem and understanding of the
.shutdown() and pm.poweroff() correct?
2. Does the solution #3 i.e. detaching PM domain after shutting down
device on shutdown path makes sense?
3. Are there other possible approaches to solve this problem that can
be explored?
4. Do we still have the performance concern about the shutdown path? I
don=E2=80=99t think anything has changed since that thread, so this is
probably still true.
5. Does the use of sysfs attribute make sense to let platform control
if it wants to detach PM domains on shutdown path?

Sorry about the long thread and thank you so much for your time!

Thanks,
Furquan

[1] https://lore.kernel.org/linux-pm/HE1PR04MB30046668C9F4FFAB5C07E693886D0=
@HE1PR04MB3004.eurprd04.prod.outlook.com/T/#mbd80804857f38c66aa5e825cdd4b61=
ba6b12317d
