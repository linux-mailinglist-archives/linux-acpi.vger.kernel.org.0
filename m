Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEFC62DF11D
	for <lists+linux-acpi@lfdr.de>; Sat, 19 Dec 2020 19:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbgLSSxi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 19 Dec 2020 13:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbgLSSxi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 19 Dec 2020 13:53:38 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73063C0613CF;
        Sat, 19 Dec 2020 10:52:46 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id x126so3598354pfc.7;
        Sat, 19 Dec 2020 10:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k1zIYWtnLeqCpR6G01qfhl0qjWfgWBYC7/jVFwx9GwE=;
        b=ONF3H9nm1kc9HSePnhuciU8TbKdOmZD9ddxKmAb5SUSVv9uMe3tYyR8iX1lwdwIIRl
         EXOuxEbPndf6H89QQVgBxcajC8YwT8Y0jkJrcJgmnseRkvjkvc+tf4FOM/pwhqN2EDJb
         oKVgNtAKOwZJC1slAJ3jXbOHdnKzv7ZI2SughrBRPE4FUZtH2CnVzViCIXfHUgG84zbJ
         o87MOV6eOZLA/KOkZ09cz5LDTghW8Kd3ieazDMFHNO9dx47xZMVvfwPM3Kpt+WETnaep
         oTji+jqIrKwjB1FnSpnGFVeVEHRuCiDyLAN9gyNKLH/JdupQHE5KPSRGpfETteuaydC5
         AGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k1zIYWtnLeqCpR6G01qfhl0qjWfgWBYC7/jVFwx9GwE=;
        b=SJ9Uw6tfEI4wztO3sGdd3hi3f2KqgSlev0Ws+IQPsvsxT24qT9TmAfpDjJ4aoRvuqH
         bCc0nTElTcF+C+4QQ9UcTl+Jzo9IF+57Vn4GGX1yacPV+dVb82kjmJ4KGlZ8mmxPwz5r
         KQ6TxehrzEkR+eLPEwUvxHxFJQbIiAnccXRhy5n2Rr8PHhochqLT1yg4D1SSmQaeRCZZ
         KcTk3aAx1ZC0QYodMQJ7+8+PDATqbgguuzrhbaL3I7UHGIILZobqkagy8iZGR2bASx3w
         2IjQ0JISOy7Hoq8YAfRocigX+oC6kGuP3wzSAxNZMIie26lhz0c6kJwqlcq+wxSc+PSg
         eLSQ==
X-Gm-Message-State: AOAM533KdT7LltXokuO/emyzMYt0Et9o81HV0sNAt/b3nCXoA4neZbXl
        a1/NfXatlBK2+D0fAgb25MYfzvVf3VcsWiTkWGQ=
X-Google-Smtp-Source: ABdhPJz5HGuII/pHqYaHr7+ZtbOwTFu7GODBV+U/h1vrgnQazOUcB6ZL7+pPs4yxjBZUWSRc7v3wXh44kRIaKPNeVt0=
X-Received: by 2002:a05:6a00:170a:b029:19d:afca:4704 with SMTP id
 h10-20020a056a00170ab029019dafca4704mr8805453pfc.7.1608403965858; Sat, 19 Dec
 2020 10:52:45 -0800 (PST)
MIME-Version: 1.0
References: <20201217234337.1983732-1-djrscally@gmail.com> <20201217234337.1983732-13-djrscally@gmail.com>
 <20201218211732.GE4077@smile.fi.intel.com> <e2b4c35f-5020-c332-d97a-8ba25be0e55e@gmail.com>
In-Reply-To: <e2b4c35f-5020-c332-d97a-8ba25be0e55e@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 19 Dec 2020 20:52:29 +0200
Message-ID: <CAHp75VcebKas4j-vByodicHxRMrO4jkaJToSUW3iLJC2+vY_iA@mail.gmail.com>
Subject: Re: [PATCH v2 12/12] ipu3-cio2: Add cio2-bridge to ipu3-cio2 driver
To:     Daniel Scally <djrscally@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        devel@acpica.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tian Shu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        kieran.bingham+renesas@ideasonboard.com,
        Linus Walleij <linus.walleij@linaro.org>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Tsuchiya Yuto <kitakar@gmail.com>, jorhand@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Dec 19, 2020 at 2:25 AM Daniel Scally <djrscally@gmail.com> wrote:
> On 18/12/2020 21:17, Andy Shevchenko wrote:
> > On Thu, Dec 17, 2020 at 11:43:37PM +0000, Daniel Scally wrote:

...

> >> +    sensor->ep_properties[0] = PROPERTY_ENTRY_U32(sensor->prop_names.bus_type, 4);
> >
> > Does 4 has any meaning that can be described by #define ?
>
> It's V4L2_FWNODE_BUS_TYPE_CSI2_DPHY:
>
> https://elixir.bootlin.com/linux/latest/source/drivers/media/v4l2-core/v4l2-fwnode.c#L36
>
> That enum's not in an accessible header, but I can define it in this
> module's header

Maybe you can do a preparatory patch to make it visible to v4l2
drivers? (Like moving to one of v4l2 headers)

...

> >> +                    if (bridge->n_sensors >= CIO2_NUM_PORTS) {
> >> +                            dev_warn(&cio2->dev, "Exceeded available CIO2 ports\n");
> >
> >> +                            /* overflow i so outer loop ceases */
> >> +                            i = ARRAY_SIZE(cio2_supported_sensors);
> >> +                            break;
> >
> > Why not to create a new label below and assign ret here with probably comment
> > why it's not an error?
>
> Sure, I can do that, but since it wouldn't need any cleanup I could also
> just return 0 here as Laurent suggest (but with a comment explaining why
> that's ok as you say) - do you have a preference?

While it's a good suggestion it will bring a bit of inconsistency into
approach. Everywhere else in the function you are using the goto
approach.
So yes, I have a preference.

> >> +                    }

...

> >> +                    ret = cio2_bridge_read_acpi_buffer(adev, "SSDB",
> >> +                                                       &sensor->ssdb,
> >> +                                                       sizeof(sensor->ssdb));
> >> +                    if (ret < 0)
> >
> > if (ret) (because positive case can be returned just by next conditional).
>
> cio2_bridge_read_acpi_buffer() returns the buffer length on success at
> the moment, but I can change it to return 0 and have this be if (ret)

Please correct this somehow, because the next failure returns it
instead of error...

> >> +                            goto err_put_adev;
> >> +
> >> +                    if (sensor->ssdb.lanes > 4) {
> >> +                            dev_err(&adev->dev,
> >> +                                    "Number of lanes in SSDB is invalid\n");

...I'm even thinking that you have to assign ret here to something meaningful.

> >> +                            goto err_put_adev;
> >> +                    }

-- 
With Best Regards,
Andy Shevchenko
