Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1AE22F9555
	for <lists+linux-acpi@lfdr.de>; Sun, 17 Jan 2021 22:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730066AbhAQVGi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 17 Jan 2021 16:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729755AbhAQVGg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 17 Jan 2021 16:06:36 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328E8C061573;
        Sun, 17 Jan 2021 13:05:56 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id n10so9664899pgl.10;
        Sun, 17 Jan 2021 13:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xiGgpCOMLVvvF9WOTNFX2PUnJFl3Im7GCb/838FY8K0=;
        b=h5MpDdNNlaywbMeHtLCOkKGg0rqIU+7qo0RnhFCcKeYI6cfK0L1XFUpchPVK7dzlL3
         ptCthdEin3/btB83rIq849MmVd6Etci0R0/Et02MUr+0DWHM2dcT0JnpCow1ux0zXPcB
         N2QdzP8QSJKeD6ZTwldL61676CYcmiD08jAAKMzC1SSoK7P5V/oLp5lh0YLKaJ0TBPXj
         nQ7e+4J5zNonniPcdWOd9oZ4pPA8PIrnmnk53A3afiGX79cSsOkuTwxStiDZC0udgg+o
         Th5HUZnuZ2CD/jjgXLAFcxc14BfN/BlEV+6N4EOLVx2eqj3ZkzEeOTZsXKN8yEMYywjI
         62/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xiGgpCOMLVvvF9WOTNFX2PUnJFl3Im7GCb/838FY8K0=;
        b=ufgAkclTrJQCijzSJrDzl6yfOMfT0vn63YkONtCBrnOXosIu1ZHm5eQllo5v5hipCx
         +6ibGXSQPdScgarHQ57sYkIWAdusOrcWDWyjHH+MEaFDW3z2Mtsh+uzY5xoBLJ0F8Sxz
         O3UjolqL27U04MGUdsLL39ADSvgbzQAH0ra7pK9Qry3fvb9Hud/0v7g3IwzmuNrwv8Rl
         zEix49Q/v0Vnp0PIihepGdk7WSz5V3j0fdBSBY1pQ4KkaxhFZrB97FZRrRN/oaB1eXY+
         lNzpdhAtsk/VUfXPjGUO7Iyd6WsYZa3TRdHUcD2VDuv+ejoSU+NJKO4zNkYOSyMaeprx
         H2dQ==
X-Gm-Message-State: AOAM532PQ2zjLNMU5iwSrSPDDDNFyDbWaMOUGWYYXkL6zKA2OBRFBU5j
        dmchCuDttWGALUNBLPDw++j7eE1xDwjv1dAbkEk=
X-Google-Smtp-Source: ABdhPJwjg5Yk5pppvzZNoyX+G14S7BE0gcMIIaGeDa21EYhslEqdMfrwUvtYV854GA05PDl4Fau5aZtrx0r53yTkgP8=
X-Received: by 2002:a05:6a00:854:b029:1b7:6233:c5f with SMTP id
 q20-20020a056a000854b02901b762330c5fmr2467555pfk.73.1610917555805; Sun, 17
 Jan 2021 13:05:55 -0800 (PST)
MIME-Version: 1.0
References: <20210115094914.88401-1-heikki.krogerus@linux.intel.com>
 <CAHp75Vc3xjaOugX3d8bohz12OEP=n4BAonNyQJQ=UgBfVZorOg@mail.gmail.com> <c644e72c-bb46-56c2-931e-7cb98b024cc3@gmail.com>
In-Reply-To: <c644e72c-bb46-56c2-931e-7cb98b024cc3@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 17 Jan 2021 23:05:39 +0200
Message-ID: <CAHp75VfMOcPyXELoD4S+oQjAaVg6H0Hn2hs2UAbYEKhnFZp36A@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Remove one more platform_device_add_properties() call
To:     Daniel Scally <djrscally@gmail.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg KH <greg@kroah.com>, Felipe Balbi <balbi@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Jan 16, 2021 at 11:29 PM Daniel Scally <djrscally@gmail.com> wrote:
> On 16/01/2021 20:23, Andy Shevchenko wrote:
> > On Fri, Jan 15, 2021 at 11:52 AM Heikki Krogerus
> > <heikki.krogerus@linux.intel.com> wrote:
> >> Hi,
> >>
> >> I'm now clearing the dev_fwnode(dev)->secondary pointer in
> >> device_remove_software_node() as requested by Daniel and Andy. Thanks
> >> guys, it's much better now. I also took the liberty of including one
> >> more PCI ID patch where I add PCI ID for the Alder Lake-P variant. I
> >> hope that is OK.
> >>
> >> Andy, I dropped your Tested-by tag because of the change I made to the
> >> first patch. If you have time to retest these, I would much appreciate.
> > Since Greg already grabbed a v3 I will test it when it appears in linux-next.
> >
> It seems the grabbed one is the v2 one though actually

In his last message he wrote that he noticed the v3 *as I understand that*.
Greg, is it right? I mean you took v3 eventually?

-- 
With Best Regards,
Andy Shevchenko
