Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 476352FA681
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Jan 2021 17:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393321AbhARQlo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Jan 2021 11:41:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:52038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390380AbhARQlU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 18 Jan 2021 11:41:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B0DE22BF3;
        Mon, 18 Jan 2021 16:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610988038;
        bh=vwCki1f6YIWIWNcCAyhuitSK8rQJU8G6+bsi8qQ/MdU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pEWe309kIfgkz1Eu1f+wPHYVHxOtbzsVNujPC1GJa6MsOa/BJy2t4/qijjlzLxdCo
         bfK8l/+BBd/F1Uk/pCenFp9kyjj1M5B/b/q7LTiehNbyvsZdvDd3iqUAW4GgmXwf3Q
         N9HEwIHKuAZLd3BmTeP/ZdUIbALOSIWhBNTdFrPo=
Date:   Mon, 18 Jan 2021 17:40:36 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        lennart@poettering.net,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Multiple MODALIAS= in uevent file confuses userspace
Message-ID: <YAW6BI00Kr615kFk@kroah.com>
References: <CAAd53p6aURhfFp1RFQxEPtGfzSdUfe4=N=P2rP27ULxp-D4GCg@mail.gmail.com>
 <CAAd53p45q+Jigje0FcWAERiBUGfJhR8nTYNh7SFxBpajAe4=oA@mail.gmail.com>
 <CAJZ5v0iyEq6+OemJNXQv46h0pW=LHxiR2HeFe4+us59_x6Nymg@mail.gmail.com>
 <20210118141238.GQ968855@lahna.fi.intel.com>
 <YAWalPeMPt44lBgI@kroah.com>
 <20210118144853.GP4077@smile.fi.intel.com>
 <YAWiCkJwiOS8i50c@kroah.com>
 <20210118152744.GW4077@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118152744.GW4077@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jan 18, 2021 at 05:27:44PM +0200, Andy Shevchenko wrote:
> On Mon, Jan 18, 2021 at 03:58:18PM +0100, Greg Kroah-Hartman wrote:
> > On Mon, Jan 18, 2021 at 04:48:53PM +0200, Andy Shevchenko wrote:
> > > On Mon, Jan 18, 2021 at 03:26:28PM +0100, Greg Kroah-Hartman wrote:
> > > > On Mon, Jan 18, 2021 at 04:12:38PM +0200, Mika Westerberg wrote:
> > > > > On Mon, Jan 18, 2021 at 02:50:33PM +0100, Rafael J. Wysocki wrote:
> > > > > > On Mon, Jan 18, 2021 at 8:27 AM Kai-Heng Feng
> > > > > > <kai.heng.feng@canonical.com> wrote:
> > > > > > > On Sat, Jan 9, 2021 at 12:25 AM Kai-Heng Feng
> > > > > > > <kai.heng.feng@canonical.com> wrote:
> > > > > > > >
> > > > > > > > Commit 8765c5ba19490 ("ACPI / scan: Rework modalias creation when
> > > > > > > > "compatible" is present") creates two modaliases for certain ACPI
> > > > > > > > devices. However userspace (systemd-udevd in this case) assumes uevent
> > > > > > > > file doesn't have duplicated keys, so two "MODALIAS=" breaks the
> > > > > > > > assumption.
> > > > > > > >
> > > > > > > > Based on the assumption, systemd-udevd internally uses hashmap to
> > > > > > > > store each line of uevent file, so the second modalias always replaces
> > > > > > > > the first modalias.
> > > > > > > >
> > > > > > > > My attempt [1] is to add a new key, "MODALIAS1" for the second
> > > > > > > > modalias. This brings up the question of whether each key in uevent
> > > > > > > > file is unique. If it's no unique, this may break may userspace.
> > > > > > >
> > > > > > > Does anyone know if there's any user of the second modalias?
> > > > > > > If there's no user of the second one, can we change it to OF_MODALIAS
> > > > > > > or COMPAT_MODALIAS?
> > > > > 
> > > > > The only users I'm aware are udev and the busybox equivalent (udev,
> > > > > mdev) but I'm not sure if they use the second second modalias at all so
> > > > > OF_MODALIAS for the DT compatible string sounds like a good way to solve
> > > > > this.
> > > > 
> > > > As udev seems to "break" with this (which is where we got the original
> > > > report from), I don't think you need to worry about that user :)
> > > 
> > > > Does anyone use mdev anymore, and in any ACPI-supported systems?
> > > 
> > > Yes, regularly.
> > 
> > Ok, and how badly does it break when MODALIAS is multiple lines like
> > this?  Or can it handle it?
> 
> Since the mentioned change landed into v4.1 I never had a problem with my
> setup. From my point of view it doesn't affect anyhow mdev setup.

Do you actually have a device with multiple entries and try to do a rule
based on it?  That's how this was triggered in udev, "normal" operations
work just fine.

thanks,

greg k-h
