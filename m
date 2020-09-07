Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDE2425F9D7
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Sep 2020 13:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbgIGLtC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Sep 2020 07:49:02 -0400
Received: from mga17.intel.com ([192.55.52.151]:7590 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729149AbgIGLs1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 7 Sep 2020 07:48:27 -0400
IronPort-SDR: C/Vtw7APVNgUqUMsk6UPaFFnPDJRKmZaFAz6gil/2LdtAZlz4tPASQIFWkJVPp+Va3MB9WJxe5
 EO6hd/7Uvefg==
X-IronPort-AV: E=McAfee;i="6000,8403,9736"; a="138041466"
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; 
   d="scan'208";a="138041466"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2020 04:48:27 -0700
IronPort-SDR: T4HI9PyGhK7P9pE2TkBU7ruqJLVreQXOnGHdopLXmcDo32cQ8doYIkyJKA3P9AwQdTlgZ7lcRz
 qeHBct+6mwtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; 
   d="scan'208";a="406814486"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 07 Sep 2020 04:48:25 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 07 Sep 2020 14:48:24 +0300
Date:   Mon, 7 Sep 2020 14:48:24 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 2/2] Documentation: Remove device connection documentation
Message-ID: <20200907114824.GA3101050@kuha.fi.intel.com>
References: <20200907103750.9093-1-heikki.krogerus@linux.intel.com>
 <20200907103750.9093-3-heikki.krogerus@linux.intel.com>
 <20200907111740.GB299300@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907111740.GB299300@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 07, 2020 at 01:17:40PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Sep 07, 2020 at 01:37:50PM +0300, Heikki Krogerus wrote:
> > The API that allowed device connection descriptions to
> > be added is now removed, so removing also the documentation
> > for it.
> > 
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > ---
> >  .../driver-api/device_connection.rst          | 43 -------------------
> >  1 file changed, 43 deletions(-)
> >  delete mode 100644 Documentation/driver-api/device_connection.rst
> 
> Oops, you forgot to remove this file from the list in
> Documentation/driver-api/index.rst, which I think will now break the
> documentation build, right?
> 
> Can you redo this one with that fix?

Argh! It does not actually break the documentation build. It did
generate a warning though, and that I missed. Apologies.

I'll fix this.

thanks,

-- 
heikki
