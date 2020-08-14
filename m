Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF29244C04
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Aug 2020 17:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgHNPYs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 Aug 2020 11:24:48 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45723 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbgHNPYr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Aug 2020 11:24:47 -0400
Received: by mail-ot1-f67.google.com with SMTP id c4so7795832otf.12
        for <linux-acpi@vger.kernel.org>; Fri, 14 Aug 2020 08:24:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I1ZKv0oidpUYZtYugea70w1dcACEX1P6O8vbpS0AYGg=;
        b=YE3QFQOj0ZiyF/STlndFYgUGJZy2itHEaBRGb9UL+KXuRwjLOqLvxcTz42o77pPjAb
         dEIFY9mr3T1wGlU7xgQuHjIgjuU+QCvF+eAsWFbTHUNpnguWqMCmIHRYoUeAfdO+nFU6
         +gqptblUESwIO1lwEn0VV2vcMbmoZt8e3wBz3lTjPZ/PKvOAx470zgnHzdKztxYMWJto
         +2pa44sA4ns/eMmjnIoJy0RmlRaZGa9MmwFDRYF14F9HSgTdmI5V5X/w6R8N2HCVqUfy
         SFuc9sBjzhVmIgFNrp5EhiST3SdEGfqShcwiRT/8QPu96PHAJKSGks6aOmI0ekPMK9FI
         XSbQ==
X-Gm-Message-State: AOAM533qzo8SYmZBQpTpamcwsWJCYSNWKRYLZc1FVRfrHtuNoFMXImmo
        v7+pj3sR8/h3LKDVT1xAwK0JW7hnEycYvUuKkYc=
X-Google-Smtp-Source: ABdhPJwdNUGy5D3i+uGR7giHOpBxJrls+pyGg5p75RW8IC1fpbQLu/6kjJ0Yu99vzoJ0RWO2jaVbEIsymLC5hkBNsaU=
X-Received: by 2002:a9d:5c06:: with SMTP id o6mr1163233otk.262.1597418687084;
 Fri, 14 Aug 2020 08:24:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200813175729.15088-1-andriy.shevchenko@linux.intel.com> <20200813175729.15088-4-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20200813175729.15088-4-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 14 Aug 2020 17:24:36 +0200
Message-ID: <CAJZ5v0iw7_APT0LmcBpGj_Yz9g1hCOw9yeaMtvOffE_n2-ApaA@mail.gmail.com>
Subject: Re: [PATCH v1 4/7] resource: Introduce resource_intersection() for
 overlapping resources
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Aug 13, 2020 at 7:57 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> There will be at least one user that can utilize new helper.
> Provide the helper for future user and for wider use.
>
> Deliberately avoid min()/max() macro as they are still parts of
> kernel.h which is quite a burden to be included here in order
> to avoid circular dependencies.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/ioport.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index c98df0ec7422..1d5ab2e7f9eb 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -232,6 +232,16 @@ static inline bool resource_overlaps(struct resource *r1, struct resource *r2)
>         return (r1->start <= r2->end && r1->end >= r2->start);
>  }
>
> +static inline bool
> +resource_intersection(struct resource *r1, struct resource *r2, struct resource *r)
> +{
> +       if (!resource_overlaps(r1, r2))
> +               return false;
> +       r->start = r1->start > r2->start ? r1->start : r2->start;
> +       r->end = r1->end < r2->end ? r1->end : r2->end;
> +       return true;
> +}

I have the same comments as for patch [3/7].

> +
>  static inline bool
>  resource_union(struct resource *r1, struct resource *r2, struct resource *r)
>  {
> --
> 2.28.0
>
