Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB0625FBEF
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Sep 2020 16:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbgIGORZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Sep 2020 10:17:25 -0400
Received: from mga11.intel.com ([192.55.52.93]:21425 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729766AbgIGOPX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 7 Sep 2020 10:15:23 -0400
IronPort-SDR: 80OO6qyAYlM07BBN9nVww29WgTZLQgaS5/U26qdFzZhOQQH+FHUddWIPOUjV+iViNqcFQ6w/Dx
 1DW8FUNTSOAw==
X-IronPort-AV: E=McAfee;i="6000,8403,9736"; a="155503772"
X-IronPort-AV: E=Sophos;i="5.76,402,1592895600"; 
   d="scan'208";a="155503772"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2020 07:15:22 -0700
IronPort-SDR: 8fCr++0gNuXQBoqnbD7voikm+NUSjzSAx6hZgsxSHFKfQwiMaUNzp82a8X1/7DitaunNYteeQX
 vBGJ9T0HRo7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,402,1592895600"; 
   d="scan'208";a="406849470"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 07 Sep 2020 07:15:20 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 07 Sep 2020 17:15:19 +0300
Date:   Mon, 7 Sep 2020 17:15:19 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Mani, Rajmohan" <rajmohan.mani@intel.com>,
        linux-acpi@vger.kernel.org,
        Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: Re: [PATCH 2/2] usb: typec: intel_pmc_mux: Do not configure SBU and
 HSL Orientation in Alternate modes
Message-ID: <20200907141519.GC3101050@kuha.fi.intel.com>
References: <20200907135740.19941-1-heikki.krogerus@linux.intel.com>
 <20200907135740.19941-3-heikki.krogerus@linux.intel.com>
 <20200907141058.GA3720524@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907141058.GA3720524@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 07, 2020 at 04:10:58PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Sep 07, 2020 at 04:57:40PM +0300, Heikki Krogerus wrote:
> > From: Utkarsh Patel <utkarsh.h.patel@intel.com>
> > 
> > According to the PMC Type C Subsystem (TCSS) Mux programming guide rev
> > 0.7, bits 4 and 5 are reserved in Alternate modes.
> > SBU Orientation and HSL Orientation needs to be configured only during
> > initial cable detection in USB connect flow based on device property of
> > "sbu-orientation" and "hsl-orientation".
> > Configuring these reserved bits in the Alternate modes may result in delay
> > in display link training or some unexpected behaviour.
> > So do not configure them while issuing Alternate Mode requests.
> > 
> > Fixes: ff4a30d5e243 ("usb: typec: mux: intel_pmc_mux: Support for static SBU/HSL orientation")
> > Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 
> Shouldn't this also need a cc:stable?

This one fixes something in 5.8-rcx.

> And why not cc: the linux-usb list on these patches?

I guess "acpi" and "usb" are very similar strings to my brain... I'm
sorry about the wrong list. I'll resend.

thanks,

-- 
heikki
