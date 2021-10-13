Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6F9642C886
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Oct 2021 20:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238658AbhJMSU5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 13 Oct 2021 14:20:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:52104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238387AbhJMSU4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 13 Oct 2021 14:20:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 04AF161165;
        Wed, 13 Oct 2021 18:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634149133;
        bh=h43zpChNzyMQTIytYSLNOFwek9CqlNQr5TsiPcTFR6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=evt+nFVPa6UAau0wcLmzcJcAovJsoFMrrD+QlA50TSj3Ru8/Pz7p0oZoACJX18G+5
         Gb+V2/yh+yjOBZ2zeX53OZMQn5wDpjMhlSzWMz6n2WKvhIgQcXLRsFgo3PCWkk0Lms
         e810yLZrGIFpZhSvFnDBvoKUQkrvXne141Nz4rf8=
Date:   Wed, 13 Oct 2021 20:18:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v1 1/1] device property: Add missed header in fwnode.h
Message-ID: <YWcjCmYnULuf1CsL@kroah.com>
References: <20211013143707.80222-1-andriy.shevchenko@linux.intel.com>
 <CAGETcx_mNWumqmYzytvKG+FvPLA=DWokbbtFv=EGet41G6cQeQ@mail.gmail.com>
 <CAJZ5v0jJyjYAreubd6ySrt-61Ca4PJUOu6D8VXC1k1GTyVyDZA@mail.gmail.com>
 <CAGETcx-Yaof2EFzY6C9JHjqi48UBg-nR7aACJ5nJa1T-rbv3Uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx-Yaof2EFzY6C9JHjqi48UBg-nR7aACJ5nJa1T-rbv3Uw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 13, 2021 at 10:34:54AM -0700, Saravana Kannan wrote:
> On Wed, Oct 13, 2021 at 10:31 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Wed, Oct 13, 2021 at 7:21 PM Saravana Kannan <saravanak@google.com> wrote:
> > >
> > > On Wed, Oct 13, 2021 at 7:37 AM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > When adding some stuff to the header file we must not rely on
> > > > implicit dependencies that are happen by luck or bugs in other
> > > > headers. Hence fwnode.h needs to use bits.h directly.
> > > >
> > > > Fixes: c2c724c868c4 ("driver core: Add fw_devlink_parse_fwtree()")
> > > > Cc: Saravana Kannan <saravanak@google.com>
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > >
> > > Acked-by: Saravana Kannan <saravanak@google.com>
> >
> > I'm going to pick this up, thanks!
> >
> 
> I think Greg already picked it up.

I did, but multiple people can :)

thanks,

greg k-h
