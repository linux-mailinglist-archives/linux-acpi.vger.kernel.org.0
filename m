Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89028DF028
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Oct 2019 16:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfJUOnV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 21 Oct 2019 10:43:21 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40938 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbfJUOnU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Oct 2019 10:43:20 -0400
Received: by mail-ot1-f67.google.com with SMTP id y39so11191934ota.7
        for <linux-acpi@vger.kernel.org>; Mon, 21 Oct 2019 07:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FxMjjLmCV5wu1SmNNdDes4wpF04tbh7UfnzG8agpR2I=;
        b=SMM8mEPV5eIu4/MGnm96tEXoZP/uFIWNabBj+JlhE1PpBLziaE6xkdwXDD3R7SFApE
         b7CBRP/aIKTqteGouH/nWWkMGLuNkDsJ+38UcnHH9GKzx8ufmkHQ9ndW3044/R5QIWm+
         b3oXY6yHKbCMLYaxpGMu50UbVsFyaYeOSPMu6TKt+7IZ9AW907IT8hQhpmtibI7k7IgL
         hJb/YKf5bOtScYctW3xRu7BheXgJQL90Nl4L8SP5hSkBj6Pw1eFda14kOt4G2Yyk2azO
         EaNGeuETqvNrnBF6glEtn2nBIA3ykxMyD0bp7KHDqiI83KemtUQhIxRwtFAQcsB5WHXz
         4k4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FxMjjLmCV5wu1SmNNdDes4wpF04tbh7UfnzG8agpR2I=;
        b=KZeU5Jeym9CGr4wVlSbiKM5Y6cMeykXqIyQ66MWga1KdSLjoEdRVsAhJR+md6eWCzw
         8vwwKNKE222tKaqVednLlYV/koAgfsq4fgNlwP5E6azPfsljXpri0Mjn+Nlp6enQ1olO
         PJ0TpKA/NvqEgjYjn478PDMGcfO8TIFxO0Xd23v7BQiDPayFoA/Sje862vpnagBC9JoD
         Hu2iq8xaV8Fz2w1GPnaw4fbiRHab1W6cATZwftEn370f6Mc5QCjHr1IcqZIjHczRotbP
         B68fVtemSt/pP7/N1R4gR00/BrCZtDHzfAdT8DDlZh8vnyFbU7R1Q5zozbOVFm8Yv27y
         2Qhw==
X-Gm-Message-State: APjAAAUyf6DRNN5gAFrKXJFkLlWRWrCLTXQI7wwD58IclgzzBBpd3bSe
        AmYxXVH/5LzKPCuhjzipu7IXS6kJFZh49vsdLWc4Iw==
X-Google-Smtp-Source: APXvYqwnfS9nd3wLOGs0D0OfKHD+SBxl97XKF9D56iGQIcLGlwPyed8/yOfLu8En+dOBF5iJpDt1gOXwywtP/o3xkzA=
X-Received: by 2002:a9d:7c92:: with SMTP id q18mr19200169otn.363.1571668999984;
 Mon, 21 Oct 2019 07:43:19 -0700 (PDT)
MIME-Version: 1.0
References: <20191018123534.GA6549@mwanda> <CAJZ5v0jeoJrrn56VqRSoY-Mc9rp04tWYbTCsQugZV=vXQk0nNg@mail.gmail.com>
In-Reply-To: <CAJZ5v0jeoJrrn56VqRSoY-Mc9rp04tWYbTCsQugZV=vXQk0nNg@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 21 Oct 2019 07:43:10 -0700
Message-ID: <CAPcyv4jL=7WFjxK1UmWRoxup0gDzjapLdt7GxwOsg1xYEPr4ew@mail.gmail.com>
Subject: Re: [PATCH] acpi/nfit: unlock on error in scrub_show()
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Oct 20, 2019 at 4:35 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Oct 18, 2019 at 2:38 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > We change the locking in this function and forgot to update this error
> > path so we are accidentally still holding the "dev->lockdep_mutex".
> >
> > Fixes: 87a30e1f05d7 ("driver-core, libnvdimm: Let device subsystems add local lockdep coverage")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  drivers/acpi/nfit/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> > index 1413324982f0..14e68f202f81 100644
> > --- a/drivers/acpi/nfit/core.c
> > +++ b/drivers/acpi/nfit/core.c
> > @@ -1322,7 +1322,7 @@ static ssize_t scrub_show(struct device *dev,
> >         nfit_device_lock(dev);
> >         nd_desc = dev_get_drvdata(dev);
> >         if (!nd_desc) {
> > -               device_unlock(dev);
> > +               nfit_device_unlock(dev);
> >                 return rc;
> >         }
> >         acpi_desc = to_acpi_desc(nd_desc);
> > --
>
> Applying as a fix for 5.4, thanks!
>
> @Dan W: Please let me know if you'd rather take it yourself.

If you already have it applied, I have no concerns.

Acked-by: Dan Williams <dan.j.williams@intel.com>
