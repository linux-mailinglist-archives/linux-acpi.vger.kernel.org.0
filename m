Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F42032FA3B7
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Jan 2021 15:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405310AbhAROy1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Jan 2021 09:54:27 -0500
Received: from mga05.intel.com ([192.55.52.43]:63035 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405329AbhAROyV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 18 Jan 2021 09:54:21 -0500
IronPort-SDR: VwLhlAf/wDXYBwMnD0joSGwxZfI6ilp/O9m15u1yvaNZ/Pcz3LrfQQOyZr2vVDjfJbklixtt1g
 jVbLzqesiCFw==
X-IronPort-AV: E=McAfee;i="6000,8403,9867"; a="263618343"
X-IronPort-AV: E=Sophos;i="5.79,356,1602572400"; 
   d="scan'208";a="263618343"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 06:52:31 -0800
IronPort-SDR: tQpW+ICRhUjvTwac5yfP/dlT/LDaIQFD1xCbR+J8p4bfn25VwRYObz5l73ohlmss30r3kqql3v
 cgHlXzKQV5nw==
X-IronPort-AV: E=Sophos;i="5.79,356,1602572400"; 
   d="scan'208";a="402069336"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 06:52:28 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 18 Jan 2021 16:52:26 +0200
Date:   Mon, 18 Jan 2021 16:52:26 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        lennart@poettering.net,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: Multiple MODALIAS= in uevent file confuses userspace
Message-ID: <20210118145226.GR968855@lahna.fi.intel.com>
References: <CAAd53p6aURhfFp1RFQxEPtGfzSdUfe4=N=P2rP27ULxp-D4GCg@mail.gmail.com>
 <CAAd53p45q+Jigje0FcWAERiBUGfJhR8nTYNh7SFxBpajAe4=oA@mail.gmail.com>
 <CAJZ5v0iyEq6+OemJNXQv46h0pW=LHxiR2HeFe4+us59_x6Nymg@mail.gmail.com>
 <20210118141238.GQ968855@lahna.fi.intel.com>
 <YAWalPeMPt44lBgI@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YAWalPeMPt44lBgI@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jan 18, 2021 at 03:26:28PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Jan 18, 2021 at 04:12:38PM +0200, Mika Westerberg wrote:
> > Hi,
> > 
> > On Mon, Jan 18, 2021 at 02:50:33PM +0100, Rafael J. Wysocki wrote:
> > > CC Mika and Andy.
> > > 
> > > On Mon, Jan 18, 2021 at 8:27 AM Kai-Heng Feng
> > > <kai.heng.feng@canonical.com> wrote:
> > > >
> > > > On Sat, Jan 9, 2021 at 12:25 AM Kai-Heng Feng
> > > > <kai.heng.feng@canonical.com> wrote:
> > > > >
> > > > > Commit 8765c5ba19490 ("ACPI / scan: Rework modalias creation when
> > > > > "compatible" is present") creates two modaliases for certain ACPI
> > > > > devices. However userspace (systemd-udevd in this case) assumes uevent
> > > > > file doesn't have duplicated keys, so two "MODALIAS=" breaks the
> > > > > assumption.
> > > > >
> > > > > Based on the assumption, systemd-udevd internally uses hashmap to
> > > > > store each line of uevent file, so the second modalias always replaces
> > > > > the first modalias.
> > > > >
> > > > > My attempt [1] is to add a new key, "MODALIAS1" for the second
> > > > > modalias. This brings up the question of whether each key in uevent
> > > > > file is unique. If it's no unique, this may break may userspace.
> > > >
> > > > Does anyone know if there's any user of the second modalias?
> > > > If there's no user of the second one, can we change it to OF_MODALIAS
> > > > or COMPAT_MODALIAS?
> > 
> > The only users I'm aware are udev and the busybox equivalent (udev,
> > mdev) but I'm not sure if they use the second second modalias at all so
> > OF_MODALIAS for the DT compatible string sounds like a good way to solve
> > this.
> 
> As udev seems to "break" with this (which is where we got the original
> report from), I don't think you need to worry about that user :)

Ah right - it is the same udev used in busybox too :)

> Does anyone use mdev anymore, and in any ACPI-supported systems?

My guess is that some "embedded" distros such as Yocto and Buildroot
(Gentoo perhaps) may still use it, and at least Yocto is being used in
ACPI enabled systems.
