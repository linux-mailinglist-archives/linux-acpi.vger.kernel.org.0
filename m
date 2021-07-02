Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7499D3BA1DD
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Jul 2021 16:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbhGBOFG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Jul 2021 10:05:06 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:43550 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbhGBOFG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Jul 2021 10:05:06 -0400
Received: by mail-ot1-f53.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso10118234otu.10;
        Fri, 02 Jul 2021 07:02:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tp7kflwyuTLEinjM2vlPexiFxYfi5m3o28+q1GtVsGA=;
        b=e5YxjqyyjjE1hR90QlP04Lbnw4Yul8d6TX5JADLGqsY1557SXhEQax8H3izzOhOG0p
         IiDnd3h4cco1MLyxHYS6dpJxJSrWSFljehHQBst1weVkqAfpxaFFSc/XRIKAfGPXft60
         iNNKUkzkcBsWYA0CUTZBzO4ZRhwz4xvRMGpJuFiKHdWeXD6vU6bANeOQbKQQq+GrDCEj
         g0dKUewSrIpVKN2zZ8xKw5t38/W8zLu26/H1D3qFOKmiUEWIq/lsEoHef/jsxzZHtvD6
         TRoc7DsJyV0hY6wGKHUIEYK/LGbKT4bkaaGlCWKqv90sXpmf292aRxcUg8yignnjnXm0
         BWtA==
X-Gm-Message-State: AOAM53081YKO5EZ6LEoHugAGSfAdBMNfaQHkB3h59NmA1wAyoSse75VX
        idRpNUueS2Bu1yesMAtUwIlj6mkff0vt9Rnds9E=
X-Google-Smtp-Source: ABdhPJy6eZoAXQV1ZNVA1Xnp0PjSzl/2h6uQ8rD/0be947T6Ch2AzHZB+aypLF7pdjiTCWKDCTQn0QkoyIiTs0bLlN8=
X-Received: by 2002:a9d:604e:: with SMTP id v14mr1822850otj.260.1625234553676;
 Fri, 02 Jul 2021 07:02:33 -0700 (PDT)
MIME-Version: 1.0
References: <1625209430-19934-1-git-send-email-aubrey.li@intel.com>
 <1625209430-19934-2-git-send-email-aubrey.li@intel.com> <CAJZ5v0jq=-97bW_s7dx2U=y-3rZoJsLtFre2XXYAaQgAdbQdXA@mail.gmail.com>
In-Reply-To: <CAJZ5v0jq=-97bW_s7dx2U=y-3rZoJsLtFre2XXYAaQgAdbQdXA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 2 Jul 2021 16:02:22 +0200
Message-ID: <CAJZ5v0h=jA8awhGZDYXXX7ybcT-d8BpSoPDZfvJ3+_7tOoK=bw@mail.gmail.com>
Subject: Re: [PATCH 2/2] ACPI: let BIOS fall back to legacy handling if PRM disabled
To:     Aubrey Li <aubrey.li@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jul 2, 2021 at 1:37 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Jul 2, 2021 at 9:03 AM Aubrey Li <aubrey.li@intel.com> wrote:
> >
> > Based on _OSC PRM bit, BIOS can choose switch from legacy handling
> > to using PRM. So if CONFIG_ACPI_PRMT is disabled, this bit should
> > not be set to let BIOS fall back to the legacy handling (such as SMI).
> >
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> > ---
> >  drivers/acpi/bus.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> > index 60fb6a84..30a3d4a 100644
> > --- a/drivers/acpi/bus.c
> > +++ b/drivers/acpi/bus.c
> > @@ -303,7 +303,9 @@ static void acpi_bus_osc_negotiate_platform_control(void)
> >
> >         capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_HOTPLUG_OST_SUPPORT;
> >         capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_PCLPI_SUPPORT;
> > +#ifdef CONFIG_ACPI_PRMT
> >         capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_PRM_SUPPORT;
> > +#endif
>
> What about using if (IS_ENABLED()) instead of #ifdef?

I've made this change myself and applied the patch with a rewritten
changelog and under a different subject ("ACPI: Do not singal PRM
support if not enabled").

Thanks!
