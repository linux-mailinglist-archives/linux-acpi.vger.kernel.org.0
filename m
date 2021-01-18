Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6BBE2FA2A6
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Jan 2021 15:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391271AbhAROO1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Jan 2021 09:14:27 -0500
Received: from mga18.intel.com ([134.134.136.126]:2724 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392750AbhAROOT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 18 Jan 2021 09:14:19 -0500
IronPort-SDR: 36mpAlXeGO3Xuc2CxbPu/GbLS3CXZNno1k6xoiFxP/8ZrIzHDr3g13xub94ZAcKuT1BjHwk6Fr
 ydH4lxkuS1UQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9867"; a="166475055"
X-IronPort-AV: E=Sophos;i="5.79,356,1602572400"; 
   d="scan'208";a="166475055"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 06:12:44 -0800
IronPort-SDR: VHm/iNpL5VYsm8XzZTzbO+7KI7fSipwwMwQD4L0xyNGgVuHl4bhrhj5Hb7Y6hiKqVO68nNF2gV
 vFodIZqKRmkw==
X-IronPort-AV: E=Sophos;i="5.79,356,1602572400"; 
   d="scan'208";a="355207686"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 06:12:41 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 18 Jan 2021 16:12:38 +0200
Date:   Mon, 18 Jan 2021 16:12:38 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        lennart@poettering.net,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: Multiple MODALIAS= in uevent file confuses userspace
Message-ID: <20210118141238.GQ968855@lahna.fi.intel.com>
References: <CAAd53p6aURhfFp1RFQxEPtGfzSdUfe4=N=P2rP27ULxp-D4GCg@mail.gmail.com>
 <CAAd53p45q+Jigje0FcWAERiBUGfJhR8nTYNh7SFxBpajAe4=oA@mail.gmail.com>
 <CAJZ5v0iyEq6+OemJNXQv46h0pW=LHxiR2HeFe4+us59_x6Nymg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iyEq6+OemJNXQv46h0pW=LHxiR2HeFe4+us59_x6Nymg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On Mon, Jan 18, 2021 at 02:50:33PM +0100, Rafael J. Wysocki wrote:
> CC Mika and Andy.
> 
> On Mon, Jan 18, 2021 at 8:27 AM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
> >
> > On Sat, Jan 9, 2021 at 12:25 AM Kai-Heng Feng
> > <kai.heng.feng@canonical.com> wrote:
> > >
> > > Commit 8765c5ba19490 ("ACPI / scan: Rework modalias creation when
> > > "compatible" is present") creates two modaliases for certain ACPI
> > > devices. However userspace (systemd-udevd in this case) assumes uevent
> > > file doesn't have duplicated keys, so two "MODALIAS=" breaks the
> > > assumption.
> > >
> > > Based on the assumption, systemd-udevd internally uses hashmap to
> > > store each line of uevent file, so the second modalias always replaces
> > > the first modalias.
> > >
> > > My attempt [1] is to add a new key, "MODALIAS1" for the second
> > > modalias. This brings up the question of whether each key in uevent
> > > file is unique. If it's no unique, this may break may userspace.
> >
> > Does anyone know if there's any user of the second modalias?
> > If there's no user of the second one, can we change it to OF_MODALIAS
> > or COMPAT_MODALIAS?

The only users I'm aware are udev and the busybox equivalent (udev,
mdev) but I'm not sure if they use the second second modalias at all so
OF_MODALIAS for the DT compatible string sounds like a good way to solve
this.
