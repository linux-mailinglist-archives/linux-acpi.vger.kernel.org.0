Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6843A8FC6
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jun 2021 05:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhFPDyv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Jun 2021 23:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbhFPDyv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Jun 2021 23:54:51 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D9FC061574
        for <linux-acpi@vger.kernel.org>; Tue, 15 Jun 2021 20:52:44 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id p5-20020a9d45450000b029043ee61dce6bso1148803oti.8
        for <linux-acpi@vger.kernel.org>; Tue, 15 Jun 2021 20:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/U40ejpOstL7ovbpi33uWFDwH+uhmNbcBXnXyzzqdTY=;
        b=nqeyHG3g3m6yzYWVXcJm3sINtErYOpJZM0QSQU3gl4J6k+t16muMx4fLMELQmFFz/H
         wlpuwDAqeNVKBiW9ETrtyrKcQNmHtaK1guqWjzcf8pUh7Y6f0B7Mjo4FzANtbPZeWMhQ
         m9VNGvqSKjR59l1b7tvoAWbEqetHvg1ro7QxWO+TaYPgy7mfz942xNM+yrd2e8RLbLXj
         0Ufvr6OBFtnWD0W35LSu45IZB9euUU0cGK70HjIdgrottFime7KiJdfHNELn3G7HdlkM
         eDxuuJIIsPS4OKkZVuh0Uq25LoehDeAEzmd1nrUV5BdM9/H5J9V0X0weMRJl1KZblE5N
         /YCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/U40ejpOstL7ovbpi33uWFDwH+uhmNbcBXnXyzzqdTY=;
        b=qYCrt0pM/1wByD2s8PlWHMHSWV6jcG59LIqWacaKJVeIC+uoWPEFiKxjRf325RfgKH
         ZUZ+UaK1WerSJUSiDteZ0B1nUlWWE9Bwm/wtAwAbBwAicJaguZTSHyIeop3UPhR1gSPC
         fXtelT2ysA/r0simnrQFXSTNY5p3B1dwBX5QDS9Jyi1QgTzIiKiM3ZhaL4fPH6anSTAU
         kGvcQMpls8ds9wWgcyWGH3i0HwnJryMQwejtISAde9bR56+HumfOgXqw9IIlIqb7BzfM
         JHxuk/EtC52zRKwiOXv3h2WdTr0bG2kYsj+csPIwwk0tOtNHNWpH4LgVkEAEWZR2W0Z2
         xWqw==
X-Gm-Message-State: AOAM531KWJhFzuSTQWUxh8MtA16fAnT+iFgsLgTvLglCfchOXURYE80t
        R3xjcXPOdM3vWZpVPcitkUGKPeIYMQg=
X-Google-Smtp-Source: ABdhPJwfMls7pZd06H9tY6rR8fUA26tmd0N0Uxb7gULvNNaBV/Tw791O0awm8fpvJvH3qoXgOEAbUQ==
X-Received: by 2002:a9d:c04:: with SMTP id 4mr2054947otr.245.1623815564208;
        Tue, 15 Jun 2021 20:52:44 -0700 (PDT)
Received: from fedora ([2601:283:4400:c0:96c1:9c48:12a7:2c7c])
        by smtp.gmail.com with ESMTPSA id l25sm204118oie.57.2021.06.15.20.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 20:52:43 -0700 (PDT)
Date:   Tue, 15 Jun 2021 21:52:34 -0600
From:   Clayton Casciato <majortomtosourcecontrol@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] acpi: sysfs: Fixed a control flow style issue
Message-ID: <YMl1ghOY2SwPPxun@fedora>
References: <20210612223401.9273-1-majortomtosourcecontrol@gmail.com>
 <CAJZ5v0idK5cneSF8+A1SrHcs-WHQLmTeAJdB72yNNfH5QygWoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0idK5cneSF8+A1SrHcs-WHQLmTeAJdB72yNNfH5QygWoQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jun 14, 2021 at 05:36:19PM +0200, Rafael J. Wysocki wrote:
> On Sun, Jun 13, 2021 at 12:37 AM Clayton Casciato
> <majortomtosourcecontrol@gmail.com> wrote:
> >
> > Fixed coding style issue.
> 
> I'm not really sure what issue you are fixing here.
> 

Checkpatch warns that "else is not generally useful after a break or
return".

> Is it the redundant braces around the nested if () statement?
> 

The patch only removes the else clause.

> If so, the flow before and after the patch is different.  Is this intentional?
> 

Yes. The patch improves readability by removing the outermost context, reducing
the nested conditional complexity.

Thank you for your consideration!

> > Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
> > ---
> >  drivers/acpi/sysfs.c | 18 +++++++++---------
> >  1 file changed, 9 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
> > index d6626aba4a6a..0e685ca8f78f 100644
> > --- a/drivers/acpi/sysfs.c
> > +++ b/drivers/acpi/sysfs.c
> > @@ -254,15 +254,15 @@ static int param_get_trace_state(char *buffer, const struct kernel_param *kp)
> >  {
> >         if (!(acpi_gbl_trace_flags & ACPI_TRACE_ENABLED))
> >                 return sprintf(buffer, "disable\n");
> > -       else {
> > -               if (acpi_gbl_trace_method_name) {
> > -                       if (acpi_gbl_trace_flags & ACPI_TRACE_ONESHOT)
> > -                               return sprintf(buffer, "method-once\n");
> > -                       else
> > -                               return sprintf(buffer, "method\n");
> > -               } else
> > -                       return sprintf(buffer, "enable\n");
> > -       }
> > +
> > +       if (acpi_gbl_trace_method_name) {
> > +               if (acpi_gbl_trace_flags & ACPI_TRACE_ONESHOT)
> > +                       return sprintf(buffer, "method-once\n");
> > +               else
> > +                       return sprintf(buffer, "method\n");
> > +       } else
> > +               return sprintf(buffer, "enable\n");
> > +
> >         return 0;
> >  }
> >
> > --
> > 2.31.1
> >
