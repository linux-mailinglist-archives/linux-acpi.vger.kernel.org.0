Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACBD5342216
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Mar 2021 17:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhCSQjh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 19 Mar 2021 12:39:37 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:40674 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbhCSQje (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Mar 2021 12:39:34 -0400
Received: by mail-ot1-f47.google.com with SMTP id w31-20020a9d36220000b02901f2cbfc9743so8821237otb.7;
        Fri, 19 Mar 2021 09:39:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KY/8YcMn0hOGRkMzxByx0ORtpT71fbTQVq2Wtk/ZVsE=;
        b=HT86J+WXJWlvym3Hk9iIGFujvq9aslXuiEEWeLOd/koYzKfuKkrUYj392Mel0FIpFt
         qHvYcHv6AHN1FKGb3dCZJ1OVy+3t9ygzYobdDDIHr8jJIUqai6/BOfWN3kNnjnR6xRN3
         nd5fnVslJeMeQcUuJdFhQabH70yG8I3q3evczJ1hny5LsvTXhvR5GfFjVBIeRWRZap/s
         bhnCF3N1sB0IRxhb7aWXy9PZ2n73+XcFQefWzQMjKINSohCkc46T3gUw6Oq+iihGY/8v
         Mo1Nv8qQ8iABvF5yiD9XOChWtsRa1NHZrx/3881CTKCaUWLMvqv5v8S8GvZoNDBI65+u
         m5Fg==
X-Gm-Message-State: AOAM533npjWWP1IgjTEeDpAPA5vrWTR19G24Aja5bgRH1QENPbh+XV1x
        Vdbr0Cx1KSLMUUMDt0FmcbbQ/ogjtH6fZtQsWMZyRDqz
X-Google-Smtp-Source: ABdhPJw3TI3INPMDNiDG5a01h30sKFYpNJ4Hl5itOGkSOU/6PX7OE1jLN4lIVzLPx4Vg++oqm3LTQ4ZaMXh1XhEKVxk=
X-Received: by 2002:a9d:4811:: with SMTP id c17mr1845743otf.206.1616171974396;
 Fri, 19 Mar 2021 09:39:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210311082521.39342-1-heikki.krogerus@linux.intel.com> <YEoEGRZIJ81NzOgQ@smile.fi.intel.com>
In-Reply-To: <YEoEGRZIJ81NzOgQ@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 19 Mar 2021 17:39:21 +0100
Message-ID: <CAJZ5v0jg2PGjpjLkXwSJKo5YMS+tdqmtmzD3nC7GHches06tzg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add entry for the software nodes
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Mar 11, 2021 at 12:50 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Mar 11, 2021 at 11:25:21AM +0300, Heikki Krogerus wrote:
> > Making Andy and myself (Heikki) the designated reviewers of
> > the thing. The software node mailing list shall be
> > linux-acpi@vger.kernel.org for now.
>
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > ---
> >  MAINTAINERS | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index f032f45bc9512..a76b6c926004e 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -16616,6 +16616,13 @@ F:   drivers/firmware/arm_sdei.c
> >  F:   include/linux/arm_sdei.h
> >  F:   include/uapi/linux/arm_sdei.h
> >
> > +SOFTWARE NODES
> > +R:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > +R:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > +L:   linux-acpi@vger.kernel.org
> > +S:   Maintained
> > +F:   drivers/base/swnode.c
> > +
> >  SOFTWARE RAID (Multiple Disks) SUPPORT
> >  M:   Song Liu <song@kernel.org>
> >  L:   linux-raid@vger.kernel.org
> > --

Applied as 5.13 material, thanks!
