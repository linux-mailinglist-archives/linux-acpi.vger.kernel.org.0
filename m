Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFA3E199C95
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Mar 2020 19:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgCaRKz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 31 Mar 2020 13:10:55 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33326 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731236AbgCaRKy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 31 Mar 2020 13:10:54 -0400
Received: by mail-ot1-f67.google.com with SMTP id 22so22830227otf.0
        for <linux-acpi@vger.kernel.org>; Tue, 31 Mar 2020 10:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qHYDmZrgq5jmEkRfovldh3Vm9VQlL40sufsyBZ8bEao=;
        b=ejCKGv9ewqzPDwu36dgEf76BAdc6P8/FNIHvqlRJ2NbFTsqobiYJueIPM1QZi0OCCQ
         mbU1B6WSb811ZFiG9JOqTsYC1SHqnNkP67uF97SvOhv96tkShJMN5PdECEv/UVHWpBbe
         dmopibqZGT8YOlWB1Mxjj8B8vSeGI+adpgikk5ZFFX19jP5gQEyzgvSeCkR+ruYYKmOR
         1nHq5goBe3vvatRr2t6ArsKapoHRzQb/Dp8xUl9h++ZuJuyY81r7fl+m1ecyqBeAUMb9
         U7tiQZCEeGGDdpZ4SYSLIDyZTmrECoB9X/A+YpKZrNIyVhGzFEbffqrR2St0hFC6aHil
         3G0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qHYDmZrgq5jmEkRfovldh3Vm9VQlL40sufsyBZ8bEao=;
        b=XPjaq5PUF/iKsafcmAU72G5JZERW7Egy3RPWxuYgpSGu/CfXS+EH0DNO19e2zpNqtz
         JwuUAOuXlDGuSIEohdcjmYtIgFFl0gppvEUyvXClZTYCr9sGllcHiDWqNpfw+E1MziPc
         4+kjapAsuv5biHyU/efkXOgebq0FfA+payc6frD9d4Dgh1OJsqM6hBFxXSd67hFT5Kd0
         r9+kDW5PTM5YJ/sl1YZmlDyz+NSZolZP/FeGohnXtKAgYFAjygfgajr+gU+ecFer16c3
         /6GcqlanAbK46rRzRHg4MY2Sqlc5rGdnqtgOMLY8lNzuMoW4l9bwcU8EWF9upBoQd9gD
         Tqlw==
X-Gm-Message-State: ANhLgQ2xHWhTIWmLrSMU17yh5U6BmKXhJmdXCw/Zc50pJhkNGVsqu/Z/
        Yu0DeFa60GuKKbUihQFaOCpBImzCxjClY2FtlRl9Aw==
X-Google-Smtp-Source: ADFU+vvG/KSouwa/5JXn2S/dDVOQi5q+3SzbGyUUkrqFLoZCxv6KzvHR1l+yj5t93H1llPNa0r7/9yF4i0utZTLMJIE=
X-Received: by 2002:a05:6830:1ac1:: with SMTP id r1mr9669891otc.139.1585674651276;
 Tue, 31 Mar 2020 10:10:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200222014038.180923-1-saravanak@google.com> <20200222014038.180923-6-saravanak@google.com>
 <CAMuHMdW_pvt1b6Y8e5j0Q5yDFMsg5z61upOo+gFaq7zf1F0V6w@mail.gmail.com>
In-Reply-To: <CAMuHMdW_pvt1b6Y8e5j0Q5yDFMsg5z61upOo+gFaq7zf1F0V6w@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 31 Mar 2020 10:10:15 -0700
Message-ID: <CAGETcx_pg_wFLP9zdhxzKUnVp3Hx_t3xz88bas4UJavgehupBw@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] of: property: Delete of_devlink kernel commandline option
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 31, 2020 at 5:20 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Saravana,
>
> On Sat, Feb 22, 2020 at 2:41 AM Saravana Kannan <saravanak@google.com> wrote:
> > With the addition of fw_devlink kernel commandline option, of_devlink is
> > redundant and not useful anymore. So, delete it.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
>
> Thanks for your patch!
>
> This is now commit e94f62b7140fa3da ("of: property: Delete of_devlink
> kernel commandline option") upstream.
>
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -3299,12 +3299,6 @@
> >                         This can be set from sysctl after boot.
> >                         See Documentation/admin-guide/sysctl/vm.rst for details.
> >
> > -       of_devlink      [OF, KNL] Create device links between consumer and
> > -                       supplier devices by scanning the devictree to infer the
> > -                       consumer/supplier relationships.  A consumer device
> > -                       will not be probed until all the supplier devices have
> > -                       probed successfully.
> > -
> >         ohci1394_dma=early      [HW] enable debugging via the ohci1394 driver.
> >                         See Documentation/debugging-via-ohci1394.txt for more
> >                         info.
>
> While I agree with the thunk above...
>
> > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > index 15fc9315f1a7..f104f15b57fb 100644
> > --- a/drivers/of/property.c
> > +++ b/drivers/of/property.c
> > @@ -1299,15 +1299,9 @@ static int of_link_to_suppliers(struct device *dev,
> >         return ret;
> >  }
> >
> > -static bool of_devlink;
> > -core_param(of_devlink, of_devlink, bool, 0);
> > -
> >  static int of_fwnode_add_links(const struct fwnode_handle *fwnode,
> >                                struct device *dev)
> >  {
> > -       if (!of_devlink)
> > -               return 0;
> > -
> >         if (unlikely(!is_of_node(fwnode)))
> >                 return 0;

Hi Geert,

> ... I have some reservations about removing the actual code.
> The "of_devlink" kernel parameter was supported in v5.5 and v5.6, so
> removing its support may silently break some setups.
>
> Is this likely to happen?

As much as I'd love to see people start using this, I doubt of_devlink
has been significantly adopted outside of Android yet (I'm working on
making that easier :)). I'd be happy to be proven wrong though :)

of_devlink/fw_devlink is mainly useful when module loading is causing
ordering and clean up issues. So if deletion of of_devlink breaks
anything, I'd expect it to break in obvious ways and not silently.

> Do we need a compatibility fallback that warns to user to update his kernel
> command line?

I don't think we need to, but I'm not strongly against your suggestion
either. Let us know what you think.

-Saravana
