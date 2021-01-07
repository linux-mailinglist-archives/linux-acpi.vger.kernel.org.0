Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89ABA2ED4E3
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Jan 2021 18:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbhAGQ7c (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Jan 2021 11:59:32 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:34748 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbhAGQ7b (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Jan 2021 11:59:31 -0500
Received: by mail-oi1-f179.google.com with SMTP id s75so8103732oih.1;
        Thu, 07 Jan 2021 08:59:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TIUCk98ZrOIpG1GmXrTUqVGJnHOd4caRGIWW5TIJbS8=;
        b=V9wmrk0UF4HA5UOscb5LbilpDS7fBHbHS8dra03Sf+rWktkY691IelWFUBCBwJgZqE
         SePmY35BDEtnHNgLsIIdq0HYoIGkb1FKkh+BOJPiOOcIIQJle/mxY3xaSR6tXC9gL5QB
         PIzutpQc5NzAtgQ0adidcW4vZeJBpiYSHaNYkxFUZdcPS5AeAU2HyURZTRVt8oLLy7Mn
         ZFlNc5VKDNIeF1iGDiO836FISAUhiQVhdT+aH0cPPE4fhjDMJRBv6cAvkOHIf3zYBDDw
         bqLKYZgnyc1VCboaA6bUY0V7VMbW1V1R4laLms/yo1fwhL5WK/KMke6fPh2+eTlYVbY4
         FAaQ==
X-Gm-Message-State: AOAM532pgwAO4DHV8BvMqzguHl2N+bMeIWPFY56IuiJY7U31CjG8Kdao
        FJPT7Q806EiFxAl+28Stc8iDJaD1RxBRDJ+hqi8vDgIW
X-Google-Smtp-Source: ABdhPJyukCZVV38p/zQ6tWkukqy7Ouk8hw/xptUTZs702eMWVli+xcwlX7CjqRphxq0FnBzRuew4EmXAlYy3f3RzpsQ=
X-Received: by 2002:aca:d6c8:: with SMTP id n191mr1825561oig.69.1610038730626;
 Thu, 07 Jan 2021 08:58:50 -0800 (PST)
MIME-Version: 1.0
References: <20210105091146.25422-1-yung-chuan.liao@linux.intel.com>
 <20210105091146.25422-3-yung-chuan.liao@linux.intel.com> <20210107141123.GI940479@kuha.fi.intel.com>
In-Reply-To: <20210107141123.GI940479@kuha.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 7 Jan 2021 17:58:39 +0100
Message-ID: <CAJZ5v0go48B+3QV5zreg1yxy2KnvLdp5p=n2Rb+D8XyBtb=Rbg@mail.gmail.com>
Subject: Re: [PATCH 2/2] device property: add description of fwnode cases
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, bard.liao@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jan 7, 2021 at 3:11 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Tue, Jan 05, 2021 at 05:11:46PM +0800, Bard Liao wrote:
> > There are only four valid fwnode cases which are
> > - primary --> secondary --> -ENODEV
> > - primary --> NULL
> > - secondary --> -ENODEV
> > - NULL
> >
> > dev->fwnode should be converted between the 4 cases above no matter
> > how/when set_primary_fwnode() and set_secondary_fwnode() are called.
> > Describe it in the code so people will keep it in mind.
> >
> > Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>
> > ---
> >  drivers/base/core.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 51b9545a050b..17eb14607074 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -4414,6 +4414,12 @@ static inline bool fwnode_is_primary(struct fwnode_handle *fwnode)
> >   *
> >   * Set the device's firmware node pointer to @fwnode, but if a secondary
> >   * firmware node of the device is present, preserve it.
> > + *
> > + * Valid fwnode cases are:
> > + *  - primary --> secondary --> -ENODEV
> > + *  - primary --> NULL
> > + *  - secondary --> -ENODEV
> > + *  - NULL
> >   */
> >  void set_primary_fwnode(struct device *dev, struct fwnode_handle *fwnode)
> >  {
> > @@ -4432,6 +4438,7 @@ void set_primary_fwnode(struct device *dev, struct fwnode_handle *fwnode)
> >       } else {
> >               if (fwnode_is_primary(fn)) {
> >                       dev->fwnode = fn->secondary;
> > +                     /* Set fn->secondary = NULL to keep fn as a primary fwnode */
> >                       if (!(parent && fn == parent->fwnode))
> >                               fn->secondary = NULL;
> >               } else {
> > --

Applied (with a minor edit in the new comment) along with the [1/2] as
5.11-rc material, thanks!
