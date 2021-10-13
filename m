Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A66B42C7B6
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Oct 2021 19:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238020AbhJMRhf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 13 Oct 2021 13:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhJMRhf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Oct 2021 13:37:35 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90212C061570
        for <linux-acpi@vger.kernel.org>; Wed, 13 Oct 2021 10:35:31 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id w10so8301644ybt.4
        for <linux-acpi@vger.kernel.org>; Wed, 13 Oct 2021 10:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o/eWH+rcImV7Ew+lIRkmNjdLHTKTp1JnO4ZUaQDu6AY=;
        b=YFLHN4hG+2vrl6XOcOIWyNWSZ3t3RnNlIzTBZDFZhSJyptmoyXujRfURu7otFuyt76
         mMJMiM57FjZmUCHx8ZVD3b1sRSYYruKCSIvEzUfAuqKZTzWUYj4h+4zO8z/4RLJcpn9o
         S2qLf21MTpYdY2118pR7ZZ8+n53JYFcu/SyN+0nvyrwfy9714xPaeF2qQnhQXrvqpMj+
         HekqlOXCxE7iGXGgIbhZSY9iVHmgeDT8IJAR8fQZCOOMtsmbRZ+4j4QRaau5bbqL3AaW
         sb24iltNpikpBCDCMblhis3OeRe9Ldye1jICA5CqA17J0IuT4Ma89ABPRwxQmVNmwMJU
         1FrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o/eWH+rcImV7Ew+lIRkmNjdLHTKTp1JnO4ZUaQDu6AY=;
        b=t88TkMCK2wtFBw6dSvtLeiT4KccphfjbhGjM/O630HG1tnxX1Fu5BNTJtYdRG0fjXh
         AQfJOK6YB0KDfjtOHCVFt+8FxzNIJ6sPWT7n+ce7Cifmx+Lnbg40mjmHCearEdY7IchC
         aPf4sTnheGPRa83412OqLuUMnWycIdNDPWjlk9O2PrDcXg37v83LDqfJT3jn2oVsBcWZ
         /h7g+79v6tsovwvbxT2MN7AD+kZwtLp4CHX5d/rZ8mzoEFMrXmg5miri13dn4BXaiY2/
         f33ZcIn+4dk+CnPs7+1gyekKOpBYanInckdbJnyW4cl7Ijs53JX+tWxiqtS3bJhqC+a8
         9ROg==
X-Gm-Message-State: AOAM530LF0VPB8fm3qTSWqVCrST8HW5JEsCLYWuHdKodHtEMYi6iUpkh
        Sgsbhr/BPOvyfhSX7kT9mcbloYENADVbT/6Cch6Y+g==
X-Google-Smtp-Source: ABdhPJzRfNJkR2JEl7k2XrB1vmtrZH6Z/PsQrzE70dNCEMtRUhmrZDuaiDzjV6MZ4zp0+To4/C5R6rMHxvREF4NlyVo=
X-Received: by 2002:a05:6902:154c:: with SMTP id r12mr867525ybu.432.1634146530729;
 Wed, 13 Oct 2021 10:35:30 -0700 (PDT)
MIME-Version: 1.0
References: <20211013143707.80222-1-andriy.shevchenko@linux.intel.com>
 <CAGETcx_mNWumqmYzytvKG+FvPLA=DWokbbtFv=EGet41G6cQeQ@mail.gmail.com> <CAJZ5v0jJyjYAreubd6ySrt-61Ca4PJUOu6D8VXC1k1GTyVyDZA@mail.gmail.com>
In-Reply-To: <CAJZ5v0jJyjYAreubd6ySrt-61Ca4PJUOu6D8VXC1k1GTyVyDZA@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 13 Oct 2021 10:34:54 -0700
Message-ID: <CAGETcx-Yaof2EFzY6C9JHjqi48UBg-nR7aACJ5nJa1T-rbv3Uw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] device property: Add missed header in fwnode.h
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 13, 2021 at 10:31 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Oct 13, 2021 at 7:21 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Wed, Oct 13, 2021 at 7:37 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > When adding some stuff to the header file we must not rely on
> > > implicit dependencies that are happen by luck or bugs in other
> > > headers. Hence fwnode.h needs to use bits.h directly.
> > >
> > > Fixes: c2c724c868c4 ("driver core: Add fw_devlink_parse_fwtree()")
> > > Cc: Saravana Kannan <saravanak@google.com>
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > Acked-by: Saravana Kannan <saravanak@google.com>
>
> I'm going to pick this up, thanks!
>

I think Greg already picked it up.

-Saravana
