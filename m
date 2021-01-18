Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C50412FA4AC
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Jan 2021 16:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405865AbhARP2k (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Jan 2021 10:28:40 -0500
Received: from mga12.intel.com ([192.55.52.136]:35352 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405840AbhARP2b (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 18 Jan 2021 10:28:31 -0500
IronPort-SDR: 5ND2IDaC5cUpdcV04pMctxwHgx9mMBZ2eVREj0NQJdx+IfHzsq3verUr8ofxFXO2yAs9aWaRMW
 f7W37PFKSgKg==
X-IronPort-AV: E=McAfee;i="6000,8403,9867"; a="157995682"
X-IronPort-AV: E=Sophos;i="5.79,356,1602572400"; 
   d="scan'208";a="157995682"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 07:26:43 -0800
IronPort-SDR: iiMNZY9nl6O/3/N+sb0ba/p89E2Dh2yQDGedJpwTKSnkKSsnaH72c/PDrkb/0FYyPmw/cyRttR
 ryygXDL+gtLg==
X-IronPort-AV: E=Sophos;i="5.79,356,1602572400"; 
   d="scan'208";a="466395269"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 07:26:41 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l1WRU-002Hre-3f; Mon, 18 Jan 2021 17:27:44 +0200
Date:   Mon, 18 Jan 2021 17:27:44 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        lennart@poettering.net,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Multiple MODALIAS= in uevent file confuses userspace
Message-ID: <20210118152744.GW4077@smile.fi.intel.com>
References: <CAAd53p6aURhfFp1RFQxEPtGfzSdUfe4=N=P2rP27ULxp-D4GCg@mail.gmail.com>
 <CAAd53p45q+Jigje0FcWAERiBUGfJhR8nTYNh7SFxBpajAe4=oA@mail.gmail.com>
 <CAJZ5v0iyEq6+OemJNXQv46h0pW=LHxiR2HeFe4+us59_x6Nymg@mail.gmail.com>
 <20210118141238.GQ968855@lahna.fi.intel.com>
 <YAWalPeMPt44lBgI@kroah.com>
 <20210118144853.GP4077@smile.fi.intel.com>
 <YAWiCkJwiOS8i50c@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YAWiCkJwiOS8i50c@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jan 18, 2021 at 03:58:18PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Jan 18, 2021 at 04:48:53PM +0200, Andy Shevchenko wrote:
> > On Mon, Jan 18, 2021 at 03:26:28PM +0100, Greg Kroah-Hartman wrote:
> > > On Mon, Jan 18, 2021 at 04:12:38PM +0200, Mika Westerberg wrote:
> > > > On Mon, Jan 18, 2021 at 02:50:33PM +0100, Rafael J. Wysocki wrote:
> > > > > On Mon, Jan 18, 2021 at 8:27 AM Kai-Heng Feng
> > > > > <kai.heng.feng@canonical.com> wrote:
> > > > > > On Sat, Jan 9, 2021 at 12:25 AM Kai-Heng Feng
> > > > > > <kai.heng.feng@canonical.com> wrote:
> > > > > > >
> > > > > > > Commit 8765c5ba19490 ("ACPI / scan: Rework modalias creation when
> > > > > > > "compatible" is present") creates two modaliases for certain ACPI
> > > > > > > devices. However userspace (systemd-udevd in this case) assumes uevent
> > > > > > > file doesn't have duplicated keys, so two "MODALIAS=" breaks the
> > > > > > > assumption.
> > > > > > >
> > > > > > > Based on the assumption, systemd-udevd internally uses hashmap to
> > > > > > > store each line of uevent file, so the second modalias always replaces
> > > > > > > the first modalias.
> > > > > > >
> > > > > > > My attempt [1] is to add a new key, "MODALIAS1" for the second
> > > > > > > modalias. This brings up the question of whether each key in uevent
> > > > > > > file is unique. If it's no unique, this may break may userspace.
> > > > > >
> > > > > > Does anyone know if there's any user of the second modalias?
> > > > > > If there's no user of the second one, can we change it to OF_MODALIAS
> > > > > > or COMPAT_MODALIAS?
> > > > 
> > > > The only users I'm aware are udev and the busybox equivalent (udev,
> > > > mdev) but I'm not sure if they use the second second modalias at all so
> > > > OF_MODALIAS for the DT compatible string sounds like a good way to solve
> > > > this.
> > > 
> > > As udev seems to "break" with this (which is where we got the original
> > > report from), I don't think you need to worry about that user :)
> > 
> > > Does anyone use mdev anymore, and in any ACPI-supported systems?
> > 
> > Yes, regularly.
> 
> Ok, and how badly does it break when MODALIAS is multiple lines like
> this?  Or can it handle it?

Since the mentioned change landed into v4.1 I never had a problem with my
setup. From my point of view it doesn't affect anyhow mdev setup.

-- 
With Best Regards,
Andy Shevchenko


