Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D486E25F612
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Sep 2020 11:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgIGJNM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Sep 2020 05:13:12 -0400
Received: from mga14.intel.com ([192.55.52.115]:40067 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727953AbgIGJNL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 7 Sep 2020 05:13:11 -0400
IronPort-SDR: VWpXt9nXXaR3NWac2WCA3HFMB9X99PxSN+K9Br223HBz6lmf4U/i4ldK9Vowa5wbod0mlAVBBV
 6chxCEyXwAaA==
X-IronPort-AV: E=McAfee;i="6000,8403,9736"; a="157239934"
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; 
   d="scan'208";a="157239934"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2020 02:13:10 -0700
IronPort-SDR: /eFKzWvQQ1MC7nTjKRmxR7AVgtHmA2+47L/kVt40vQWLOIC66fd2mu/ulOkEPgesu/YEf7AobO
 aCTXYAiB712Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; 
   d="scan'208";a="406780353"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 07 Sep 2020 02:13:08 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 07 Sep 2020 12:13:07 +0300
Date:   Mon, 7 Sep 2020 12:13:07 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 4/4] device property: Move fwnode_connection_find_match()
 under drivers/base/property.c
Message-ID: <20200907091307.GA3042948@kuha.fi.intel.com>
References: <20200904125123.83725-1-heikki.krogerus@linux.intel.com>
 <20200904125123.83725-5-heikki.krogerus@linux.intel.com>
 <20200907090414.GE1101646@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907090414.GE1101646@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 07, 2020 at 11:04:14AM +0200, Greg Kroah-Hartman wrote:
> On Fri, Sep 04, 2020 at 03:51:23PM +0300, Heikki Krogerus wrote:
> > The function is now only a helper that searches the
> > connection from device graph and then by checking if the
> > supplied connection identifier matches a property that
> > contains reference.
> > 
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > ---
> >  .../driver-api/device_connection.rst          |  43 --------
> >  drivers/base/Makefile                         |   2 +-
> >  drivers/base/devcon.c                         | 101 ------------------
> >  drivers/base/property.c                       |  73 +++++++++++++
> >  include/linux/device.h                        |   9 --
> >  include/linux/property.h                      |  14 +++
> >  6 files changed, 88 insertions(+), 154 deletions(-)
> >  delete mode 100644 Documentation/driver-api/device_connection.rst
> 
> You also removed the documentation in this patch, which would have been
> fine if you had mentioned it in the changelog text :(
> 
> I'll go queue up the first 3 patches of this series, can you split this
> up into two?

Sure. I'll do that.

thanks,

-- 
heikki
