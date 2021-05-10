Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69D963794F1
	for <lists+linux-acpi@lfdr.de>; Mon, 10 May 2021 19:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbhEJRFz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 10 May 2021 13:05:55 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:39767 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbhEJRFc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 10 May 2021 13:05:32 -0400
Received: by mail-ot1-f41.google.com with SMTP id d25-20020a0568300459b02902f886f7dd43so1626762otc.6;
        Mon, 10 May 2021 10:04:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xl40YY+UwmSdCEgMPbdm3QhhBzG29tkagPo5lF6lVJo=;
        b=Y+fT1O5nbFKwneruCBEYTmli7uj1O7O0yfWxq9uQjw9I1WxTtLj/YLMcg2e3z3tbaQ
         kfrFN+h/WOkYSLOOzZHO2mL9exWCrNo2KFi4KXUQSt6wfnUncSGzfihlslmgx8Mkiy6a
         i4t6JRkMSTcJ5w7baw0PgmCoyul/zBxXpqlElHS9b/m4SZA/QlTGD0VLfgQUoALoTmzs
         R6HpnmjvRcUJq0/BIFsFxulBkYj/us02hoxJsWs8OMR5jMR2dd19YDRkfYDOcgyqdMDc
         HTnBaT1NtUsMFuPNwtaZsqFA4B2uA1+JboRkWS5A0lEE4yRm/MPLVjbPzlF0L4QSACrW
         Q3EQ==
X-Gm-Message-State: AOAM5332qe37xkUWBUBbj6QPLM9dmAiP2rymUS/d74wdVsRn50MVlcbC
        fZQ+ItYTUGE0LkBj/3XLcJHYIAxOF/Rq1nPGH7Y6A39P
X-Google-Smtp-Source: ABdhPJxzgKL8nTsWIc40ErSnfp5DyWliOhM0nTQ1BzEHKT4msTNjiCn2yiQ2dwjPpUTGyhyDC/TVBPvXdsy+/1VNcX4=
X-Received: by 2002:a05:6830:55b:: with SMTP id l27mr21934250otb.260.1620666267231;
 Mon, 10 May 2021 10:04:27 -0700 (PDT)
MIME-Version: 1.0
References: <63bf4e87eb42fa3fff2cd87eb605ebcc01f4b2f7.1620458525.git.christophe.jaillet@wanadoo.fr>
 <YJkkjI6+k34ZoQ69@smile.fi.intel.com>
In-Reply-To: <YJkkjI6+k34ZoQ69@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 10 May 2021 19:04:16 +0200
Message-ID: <CAJZ5v0jNG54Y4LYCFjqh2UKWXLswJFfKMxjrpPpGoSjNnEPibg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: scan: Fix a memory leak in an error handling path
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, May 10, 2021 at 3:17 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Sat, May 08, 2021 at 09:23:09AM +0200, Christophe JAILLET wrote:
> > If 'acpi_device_set_name()' fails, we must free
> > 'acpi_device_bus_id->bus_id' or there is a (potential) memory leak.
>
> Good catch!
> I guess I have lost it somewhere in the middle of developing the mentioned fix.
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Thanks!
>
> > Fixes: eb50aaf960e3 ("ACPI: scan: Use unique number for instance_no")
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> >  drivers/acpi/scan.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> > index a22778e880c2..651a431e2bbf 100644
> > --- a/drivers/acpi/scan.c
> > +++ b/drivers/acpi/scan.c
> > @@ -700,6 +700,7 @@ int acpi_device_add(struct acpi_device *device,
> >
> >               result = acpi_device_set_name(device, acpi_device_bus_id);
> >               if (result) {
> > +                     kfree_const(acpi_device_bus_id->bus_id);
> >                       kfree(acpi_device_bus_id);
> >                       goto err_unlock;
> >               }
> > --

Applied as 5.13-rc material, thanks!
