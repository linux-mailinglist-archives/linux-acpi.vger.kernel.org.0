Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA18D31D115
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Feb 2021 20:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhBPTmd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 Feb 2021 14:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhBPTmc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Feb 2021 14:42:32 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA4AC061756
        for <linux-acpi@vger.kernel.org>; Tue, 16 Feb 2021 11:41:51 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id b14so12501700eju.7
        for <linux-acpi@vger.kernel.org>; Tue, 16 Feb 2021 11:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NyiOPfisDOEgXA9NixaWG6upt5A1aLawMEAay6tzWsE=;
        b=dVxhzj59BDbm1z0hgAwGmOAwyi2rqAbmQ5SJ4CTtlh9tfFNfWd2VkPP7x6RsJpQ227
         0V8LZWi5dRhSj6v0WGM5KHqSjjr0iS6myvB4YfjSnlpgabkj3DQ//6VFrX//siKTXBHi
         JGP+1MOFcmQ1e9Ggq0XtKqdkNe9UTHANcaYawAOhKAms4bzvUH8KSTJ7WReUOVdCRS96
         CkmvC5d9D0228JALYKgiJEDIuw3+a96tuwP9h5OvrFXhwRRyP32fDxr9cXct+BuwHoVr
         mvx+SBuWmgUpWkPDGll9wzgnH7w8fmD7Qs3h1X63NE/Z/nGon3T9k6ZEiT1evTJZ+R+J
         lANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NyiOPfisDOEgXA9NixaWG6upt5A1aLawMEAay6tzWsE=;
        b=fpVHm9bv93MQNMzS27Y1JnpfVNxIHg6ZKhFiwB/0YhSeIrt4RYh0Kzws5f4ZxVQcr2
         F0HmM4a4WpKPzC505UzXSJkwNSMlAABgfMwWZ+MKgYPpAy+spknAgaCiM8Grk3IPdjRO
         2+P9aWi8CeXbhfkWCqh6wj5bGpQeUSGWk5A8s/9sTDIZvitnOUIVR/Mk3E5JZ3ZaK98q
         jNbL+2I7b2aDLz2sUlDQYFFSVpz9ic5wg3tFHvekdVzKOlm5s183zoLtqn1AUMrulqpR
         cFVN1y2eHX4OurgxV/uJ5e9fvhnnkaionXON5/bSDMTiX5a6gGCYkkLsTwP0MRLaudS+
         447g==
X-Gm-Message-State: AOAM531mGHfi+ujxEo2MpWOPFUmrqJeu6IAJykdkEFe8sAoNlWnr4oUt
        cN/d+UmGVXce9w5VWe9b4LZBuWbdENpMplgsAim/dw==
X-Google-Smtp-Source: ABdhPJwZItL/UAnHFKTHN9vHOAMi30O4+bBRNaC9oSi+WofOph+0pnw9YW7xzKZNEMcmTZblXj+XBQ5eLcSZ0ptNoBA=
X-Received: by 2002:a17:906:36cc:: with SMTP id b12mr22571682ejc.323.1613504510152;
 Tue, 16 Feb 2021 11:41:50 -0800 (PST)
MIME-Version: 1.0
References: <CAPcyv4gmd_cygXK0PpGkXmJLC3_ctEpRvpi5P-QcuXusFX5oNQ@mail.gmail.com>
 <20210210112330.00003e74@Huawei.com> <CAPcyv4gOyPjVcBa_m6pvpVP+vamJ38G7ePos-2LP273y3ivJqg@mail.gmail.com>
 <20210211094222.000048ae@Huawei.com> <CAPcyv4j0Wce-76OfgqTSkveukgDXB_p2VZZpgM8XjDFd+Q-0Ww@mail.gmail.com>
 <20210212122438.00003621@Huawei.com> <CAPcyv4j1axBsy4GdRxj4JhxRXtrK-U+ikxQ3xYKCa-z-a84XPQ@mail.gmail.com>
 <20210216110643.000071f0@Huawei.com> <CAPcyv4iv9kFLU7U9=VpYJZOiahUWJAZ_J_ZWCrGy1Lgqq+07kg@mail.gmail.com>
 <20210216180634.00007178@Huawei.com> <CAPcyv4h=e_a-YD2pAzY5k8Qc-+EMeBNyfzLfpuC01Jey6_sQ5g@mail.gmail.com>
 <20210216185837.000030c7@Huawei.com>
In-Reply-To: <20210216185837.000030c7@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 16 Feb 2021 11:41:40 -0800
Message-ID: <CAPcyv4j962+sS1ovhTiat0SyjqjDOZyQ83k=t7f_XTAW_87PTg@mail.gmail.com>
Subject: Re: [RFC] ACPI Code First ECR: Generic Target
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>,
        "Natu, Mahesh" <mahesh.natu@intel.com>,
        Chet R Douglas <chet.r.douglas@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Feb 16, 2021 at 11:00 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
[..]
> > For
> > example, the persistent memory enabling assigns the closest online
> > memory node for the pmem device. That achieves the traditional
> > behavior of the device-driver allocating from "local" memory by
> > default. However the HMAT-sysfs representation indicates the numa node
> > that pmem represents itself were it to be online. So the question is
> > why does GI need more than that? To me a GI is "offline" in terms
> > Linux node representations because numactl can't target it,
>
> That's fair. It does exist in an intermediate world. Whether the
> internal representation of online vs offline should have anything much
> to do with numactl rather than whether than numactl being based on
> whether a node has online memory or CPUs isn't clear to me.
> It already has to distinguish whether a node has CPUs and / or memory
> so this isn't a huge conceptual extension.
>
> > "closest
> > online" is good enough for a GI device driver,
>
> So that's the point. Is it 'good enough'?  Maybe - in some cases.
>
> > but if userspace needs
> > the next level of detail of the performance properties that's what
> > HMEM sysfs is providing.
>
> sysfs is fine if you are doing userspace allocations or placement
> decisions. For GIs it can be relevant if you are using userspace drivers
> (or partially userspace drivers).

That's unfortunate, please tell me there's another use for this
infrastructure than userspace drivers? The kernel should not be
carrying core-mm debt purely on behalf of userspace drivers.

> In the GI case, from my point of view the sysfs stuff was a nice addition
> but not actually that useful.  The info in HMAT is useful, but too little
> of it was exposed.  What I don't yet have (due to lack of time), is a good
> set of examples that show more info is needed.  Maybe I'll get to that
> one day!

See the "migration in lieu of discard" [1] series as an attempt to
make HMAT-like info more useful. The node-demotion infrastructure puts
HMAT data to more use in the sense that the next phase of memory
tiering enabling is to have the kernel automatically manage it rather
than have a few enlightened apps consume the HMEM sysfs directly.

[1]: http://lore.kernel.org/r/20210126003411.2AC51464@viggo.jf.intel.com
