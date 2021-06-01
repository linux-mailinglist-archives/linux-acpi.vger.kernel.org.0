Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAA11396E64
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Jun 2021 09:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbhFAIAJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Jun 2021 04:00:09 -0400
Received: from mga04.intel.com ([192.55.52.120]:11244 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232963AbhFAIAI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 1 Jun 2021 04:00:08 -0400
IronPort-SDR: Z+fpa4qBCtMZR5/FxgpQZBG/N6y0Qc64q9jRPOCsUYmtMe5Rs+L+Tp3LCkCAcmKo1WL39qKrNb
 eBhcUIvWFp/g==
X-IronPort-AV: E=McAfee;i="6200,9189,10001"; a="201629379"
X-IronPort-AV: E=Sophos;i="5.83,239,1616482800"; 
   d="scan'208";a="201629379"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2021 00:58:28 -0700
IronPort-SDR: ULSEG9kC9dGUEoiQ+Vvz42bjmWXY2AyZxHL2C4kDFOmxwlIi1ZfrX4qfInX+Hug3qpvl+3IwtF
 vH1P6hQUdaYQ==
X-IronPort-AV: E=Sophos;i="5.83,239,1616482800"; 
   d="scan'208";a="632785120"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2021 00:58:24 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 01 Jun 2021 10:56:11 +0300
Date:   Tue, 1 Jun 2021 10:56:11 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, Yehezkel Bernat <YehezkelShB@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org,
        Casey G Bowman <casey.g.bowman@intel.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Christian Kellner <ckellner@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 0/9] thunderbolt: Offline on-board retimer NVM upgrade
 support
Message-ID: <YLXoG2luz3ywKDZw@lahna.fi.intel.com>
References: <20210519141259.84839-1-mika.westerberg@linux.intel.com>
 <YKYk4LqriOskFCP4@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKYk4LqriOskFCP4@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, May 20, 2021 at 10:59:12AM +0200, Greg Kroah-Hartman wrote:
> On Wed, May 19, 2021 at 05:12:50PM +0300, Mika Westerberg wrote:
> > Hi all,
> > 
> > USB4 retimers are only accessible when the USB4 is up. However, sometimes
> > it may be useful to be able to upgrade on-board retimers even if the link
> > is not up. For instance if the user simply does not have any USB4 devices.
> > 
> > Making retimers accessible in "offline" mode requires some help from the
> > platform firmware (ACPI in our case) to turn on power to the retimers and
> > cycle them through different modes to get the sideband link up. This may
> > also involve other firmwares such as Embedded Controller (as it is the case
> > with recent Chromebooks).
> > 
> > This series adds support for "offline" retimer NVM upgrade so that it first
> > exposes each USB4 port to the userspace. If the platform firmware provides
> > a special _DSM-method (Device Specific Method) under the USB4 port ACPI
> > description, we expose two attributes under the port that the userspace can
> > use to put the port to offline mode and rescan for the retimers. Otherwise
> > the NVM upgrade works the same way than with the online mode. We also add
> > documentation to the admin-guide how this can be done.
> > 
> > In addition to this, at least Intel USB4 devices (and retimers) allow
> > running NVM authenticate (upgrade) separately from write so we make it
> > possible for the userspace to run the write and authenticate in two steps.
> > This allows userspace to trigger the authentication at later time, like
> > when the user logs out.
> > 
> > Mika Westerberg (4):
> >   thunderbolt: Log the link as TBT instead of TBT3
> >   thunderbolt: Add USB4 port devices
> >   thunderbolt: Allow router NVM authenticate separately
> >   thunderbolt: Check for NVM authentication status after the operation started
> > 
> > Rajmohan Mani (5):
> >   thunderbolt: Add support for ACPI _DSM to power on/off retimers
> >   thunderbolt: Add additional USB4 port operations for retimer access
> >   thunderbolt: Add support for retimer NVM upgrade when there is no link
> >   thunderbolt: Move nvm_write_ops to tb.h
> >   thunderbolt: Add WRITE_ONLY and AUTHENTICATE_ONLY NVM operations for retimers
> 
> Looks good:
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks!

All applied to thunderbolt.git/next.
