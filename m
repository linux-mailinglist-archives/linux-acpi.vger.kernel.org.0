Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED2896A626
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Jul 2019 12:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732782AbfGPKGV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 Jul 2019 06:06:21 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46597 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728090AbfGPKGU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Jul 2019 06:06:20 -0400
Received: by mail-oi1-f196.google.com with SMTP id 65so15080731oid.13;
        Tue, 16 Jul 2019 03:06:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SKSKLDsZNWfrDqHnwOUMB50WqSsunNsqcQ+sfiyuXlw=;
        b=LUQz9z9NzUKwz3VZG8WkSVYX5bP8/PJ5nc6S7ITKpSFD7TLJqaRt4L9ZpExnFGmheG
         onOmU+vc4/x85JYoHNUHIFTiHATnjUENWu8AxRqbOdCg8c6iv5eHhJ2vnzlkEt4O0TQ5
         zPmxO7DwYktMZPNQoUzDFf3s8B+IKrjrgwTCfqW/j5azw4orRtNr5xHFexoXF+DZ23xi
         mhx79UUxv5bRo4dSOn2FMc0K3A7JoJqwq+5/bq5EY/FVl8tjH4FAmynG9rC34Yqk9oXj
         MG+OUniVFc7k6kMnQ2kJ8wtzYGegKMHC+Eg7hYAKhmVNN4AyOveGYWyLl4np4654BBKO
         iIZA==
X-Gm-Message-State: APjAAAV6P6w5dRn664PINiularmyow8blJWkM0IVEr+G1fL/ty4E4TTn
        GyblPqRgWgM5wDmD2ydzqi0p0NsA0kxJsXIAjpI=
X-Google-Smtp-Source: APXvYqz+9SLeYZezhd1CiiqSz9N5lOWLlOsr+u93YAb04Q18lnnuxQ5teq8PO6tM0DnrmvA9w9XvcWX+j6bgyJjGrm4=
X-Received: by 2002:aca:edc8:: with SMTP id l191mr15705198oih.103.1563271579314;
 Tue, 16 Jul 2019 03:06:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1563269894.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1563269894.git.viresh.kumar@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 16 Jul 2019 12:06:08 +0200
Message-ID: <CAJZ5v0iqYHNt6NQy3Fi1B=XtjNOm2x0mX3+7eWBREgFZRpUS+w@mail.gmail.com>
Subject: Re: [PATCH 00/10] cpufreq: Migrate users of policy notifiers to QoS requests
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Javi Merino <javi.merino@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jul 16, 2019 at 11:49 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hello,
>
> Now that cpufreq core supports taking QoS requests for min/max cpu
> frequencies, lets migrate rest of the users to using them instead of the
> policy notifiers.

Technically, this still is linux-next only. :-)

> The CPUFREQ_NOTIFY and CPUFREQ_ADJUST events of the policy notifiers are
> removed as a result, but we have to add CPUFREQ_CREATE_POLICY and
> CPUFREQ_REMOVE_POLICY events to it for the acpi stuff specifically. So
> the policy notifiers aren't completely removed.

That's not entirely accurate, because arch_topology is going to use
CPUFREQ_CREATE_POLICY now too.

> Boot tested on my x86 PC and ARM hikey board. Nothing looked broken :)
>
> This has already gone through build bot for a few days now.

So I'd prefer patches [5-8] to go right after the first one and then
do the cleanups on top of that, as somebody may want to backport the
essential changes without the cleanups.
