Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2846B2FB912
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Jan 2021 15:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395416AbhASOSk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 Jan 2021 09:18:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:43826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404389AbhASKfe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 19 Jan 2021 05:35:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B0CE120867;
        Tue, 19 Jan 2021 10:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611052493;
        bh=Ai9OtUYE17P/PsNgazL93C2QuNBAGpf3R4vtI8UU7tU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qFRNSgW3Phy8vew+1a95X5kmhqMA1QVSxeV/v+QNU2W1CjRdJbVoEEFxU+MWUM02h
         2DbPo1jagUWGtrttWrzJaB8//4Nk1CztWgxvQLBQLDFvD1qhKaf0zFyLJu66ud/02r
         FYwE1BBXlCiLLU1DbVyIFNnZE0An7DU/psfcJBtw=
Date:   Tue, 19 Jan 2021 11:34:50 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        AceLan Kao <acelan.kao@canonical.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI / device_sysfs: Use OF_MODALIAS for "compatible"
 modalias
Message-ID: <YAa1ygjr2L3VxBKF@kroah.com>
References: <20210119081513.300938-1-kai.heng.feng@canonical.com>
 <YAaXz9Pg5x3DsCs3@kroah.com>
 <CAAd53p7tdFiARtW1RXsjN8+OwRXWzMnok_rfKHDHCh-JSam3cQ@mail.gmail.com>
 <20210119094159.GQ4077@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119094159.GQ4077@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 19, 2021 at 11:41:59AM +0200, Andy Shevchenko wrote:
> On Tue, Jan 19, 2021 at 04:41:48PM +0800, Kai-Heng Feng wrote:
> > On Tue, Jan 19, 2021 at 4:27 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > On Tue, Jan 19, 2021 at 04:15:13PM +0800, Kai-Heng Feng wrote:
> 
> ...
> 
> > > Who will use OF_MODALIAS and where have you documented it?
> > 
> > After this lands in mainline, I'll modify the pull request for systemd
> > to add a new rule for OF_MODALIAS.
> > I'll modify the comment on the function to document the change.
> 
> I'm wondering why to have two fixes in two places instead of fixing udev to
> understand multiple MODALIAS= events?

It's not a matter of multiple events, it's a single event with a
key/value pair with duplicate keys and different values.

What is this event with different values supposed to be doing in
userspace?  Do you want multiple invocations of `modprobe` or something
else?

Usually a "device" only has a single "signature" that modprobe uses to
look up the correct module for.  Modules can support any number of
device signatures, but traditionally it is odd to think that a device
itself can be supported by multiple modules, which is what you are
saying is happening here.

So what should userspace do with this, and why does a device need to
have multiple module alias signatures?

thanks,

greg k-h
