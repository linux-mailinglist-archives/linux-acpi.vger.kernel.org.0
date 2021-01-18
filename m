Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B622F2FA3A1
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Jan 2021 15:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393079AbhAROwW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Jan 2021 09:52:22 -0500
Received: from mga02.intel.com ([134.134.136.20]:61377 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393064AbhAROwT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 18 Jan 2021 09:52:19 -0500
IronPort-SDR: h5MREQX7vZaYptgdPPByUOZPdqvHf06Gv1C8DuicNIzHDVwfZRi5DIxeeQS4E4v/zs+Tsjc0JC
 HSwuq+HX+Jww==
X-IronPort-AV: E=McAfee;i="6000,8403,9867"; a="165901499"
X-IronPort-AV: E=Sophos;i="5.79,356,1602572400"; 
   d="scan'208";a="165901499"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 06:50:52 -0800
IronPort-SDR: Kw5Sc83iCcakof2p6K/nG5eyFb5fn6v2EipZhINNgdaOkvAziVnfR60BlKwXxZ72BBYnVivej9
 A3ZxMs/x+RPA==
X-IronPort-AV: E=Sophos;i="5.79,356,1602572400"; 
   d="scan'208";a="365359456"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 06:50:50 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l1Vsm-002Fl5-C1; Mon, 18 Jan 2021 16:51:52 +0200
Date:   Mon, 18 Jan 2021 16:51:52 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        lennart@poettering.net,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Multiple MODALIAS= in uevent file confuses userspace
Message-ID: <20210118145152.GQ4077@smile.fi.intel.com>
References: <CAAd53p6aURhfFp1RFQxEPtGfzSdUfe4=N=P2rP27ULxp-D4GCg@mail.gmail.com>
 <CAAd53p45q+Jigje0FcWAERiBUGfJhR8nTYNh7SFxBpajAe4=oA@mail.gmail.com>
 <CAJZ5v0iyEq6+OemJNXQv46h0pW=LHxiR2HeFe4+us59_x6Nymg@mail.gmail.com>
 <20210118141238.GQ968855@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118141238.GQ968855@lahna.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jan 18, 2021 at 04:12:38PM +0200, Mika Westerberg wrote:
> On Mon, Jan 18, 2021 at 02:50:33PM +0100, Rafael J. Wysocki wrote:
> > On Mon, Jan 18, 2021 at 8:27 AM Kai-Heng Feng
> > <kai.heng.feng@canonical.com> wrote:
> > > On Sat, Jan 9, 2021 at 12:25 AM Kai-Heng Feng
> > > <kai.heng.feng@canonical.com> wrote:
> > > >
> > > > Commit 8765c5ba19490 ("ACPI / scan: Rework modalias creation when
> > > > "compatible" is present") creates two modaliases for certain ACPI
> > > > devices. However userspace (systemd-udevd in this case) assumes uevent
> > > > file doesn't have duplicated keys, so two "MODALIAS=" breaks the
> > > > assumption.
> > > >
> > > > Based on the assumption, systemd-udevd internally uses hashmap to
> > > > store each line of uevent file, so the second modalias always replaces
> > > > the first modalias.
> > > >
> > > > My attempt [1] is to add a new key, "MODALIAS1" for the second
> > > > modalias. This brings up the question of whether each key in uevent
> > > > file is unique. If it's no unique, this may break may userspace.
> > >
> > > Does anyone know if there's any user of the second modalias?
> > > If there's no user of the second one, can we change it to OF_MODALIAS
> > > or COMPAT_MODALIAS?
> 
> The only users I'm aware are udev and the busybox equivalent (udev,
> mdev) but I'm not sure if they use the second second modalias at all so
> OF_MODALIAS for the DT compatible string sounds like a good way to solve
> this.

I agree with Mika here.

-- 
With Best Regards,
Andy Shevchenko


