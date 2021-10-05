Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E00034222EB
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Oct 2021 11:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbhJEJ7c (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Oct 2021 05:59:32 -0400
Received: from mga11.intel.com ([192.55.52.93]:54448 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233855AbhJEJ7a (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 5 Oct 2021 05:59:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10127"; a="223115527"
X-IronPort-AV: E=Sophos;i="5.85,348,1624345200"; 
   d="scan'208";a="223115527"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 02:57:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,348,1624345200"; 
   d="scan'208";a="623339867"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 05 Oct 2021 02:57:32 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 05 Oct 2021 12:57:32 +0300
Date:   Tue, 5 Oct 2021 12:57:32 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: linux 5.15-rc4: refcount underflow when unloading gpio-mockup
Message-ID: <YVwhjItspc+cNBvN@kuha.fi.intel.com>
References: <YVrz86m3+7wDSYlh@kuha.fi.intel.com>
 <20211004124701.GA3418302@sol>
 <YVr/t7AbmP/h08GX@kuha.fi.intel.com>
 <20211004141754.GA3510607@sol>
 <20211004152844.GA3825382@sol>
 <CAHp75VeBc3AN+5f680LeK8V6NpiiaPUTgE14FFonUM1W-xrjNA@mail.gmail.com>
 <20211005004035.GA29779@sol>
 <YVwLIWrqY9TRLjwG@smile.fi.intel.com>
 <YVwf7uzL1aydysVl@kuha.fi.intel.com>
 <CAHp75VfZPDwwvB1sqobSVmqjSePMBPw1igrYwaTkUkxC84cOqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VfZPDwwvB1sqobSVmqjSePMBPw1igrYwaTkUkxC84cOqQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Oct 05, 2021 at 12:53:04PM +0300, Andy Shevchenko wrote:
> On Tue, Oct 5, 2021 at 12:50 PM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > On Tue, Oct 05, 2021 at 11:21:53AM +0300, Andy Shevchenko wrote:
> > > On Tue, Oct 05, 2021 at 08:40:35AM +0800, Kent Gibson wrote:
> 
> ...
> 
> > > I'll see what I can do about.
> >
> > So, something like this (attached)?
> 
> Actually I have sent another solution:
> https://lore.kernel.org/linux-gpio/20211005093731.62743-1-andriy.shevchenko@linux.intel.com/T/#u

Ah, OK. Thanks Andy.

-- 
heikki
