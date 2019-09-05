Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1C7EAAE20
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Sep 2019 23:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731771AbfIEVzG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 5 Sep 2019 17:55:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:44130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731215AbfIEVzF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 5 Sep 2019 17:55:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35812206DE;
        Thu,  5 Sep 2019 21:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567720504;
        bh=sxN+Qr/3fwNO0OFeIiUozIkTmD7RRmTjiEqGCmmePa4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TEZPMFUPMovUgr4tDaFH5yw3qPfuqa19akfrr16lxcsDdFmv5p4F7qmOA9yJasp8t
         dO8oZVYMqZf5KEJz8EWtdSNXtWLgLXzWUWInZuiZ8YUcZ6YhoNQ52NM4o9gWNQ2FZ1
         zlXMdPA8vTu3pg5wfc71Id4M3rJHUmi8RZPnztFs=
Date:   Thu, 5 Sep 2019 23:55:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Charles.Hyde@dellteam.com
Cc:     Mario.Limonciello@dell.com, oliver@neukum.org, rjw@rjwysocki.net,
        lenb@kernel.org, chip.programmer@gmail.com, nic_swsd@realtek.com,
        linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 0/3] Add get/set ethernet address functions and ACPI MAC
 address pass through functionality to cdc_ncm driver
Message-ID: <20190905215501.GA1219@kroah.com>
References: <1567717313153.65736@Dellteam.com>
 <e41270463c46445d82415d86bebc9566@AUSX13MPC101.AMER.DELL.COM>
 <67e340c684a64e528b04276f715567cc@AUSX13MPS307.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67e340c684a64e528b04276f715567cc@AUSX13MPS307.AMER.DELL.COM>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Sep 05, 2019 at 09:14:05PM +0000, Charles.Hyde@dellteam.com wrote:
> > > -----Original Message-----
> > > From: Hyde, Charles - Dell Team
> > > Sent: Thursday, September 5, 2019 4:02 PM
> > > To: Oliver Neukum; "Rafael J. Wysocki"; Len Brown
> > > Cc: Limonciello, Mario; chip.programmer@gmail.com; Realtek linux nic
> > > maintainers; linux-usb@vger.kernel.org; linux-acpi@vger.kernel.org
> > > Subject: [PATCH 0/3] Add get/set ethernet address functions and ACPI
> > > MAC address pass through functionality to cdc_ncm driver
> > >
> > > In recent testing of a Dell Universal Dock D6000, I found that MAC
> > > address pass through is not supported in the Linux drivers.  However,
> > > this same device is supported in Windows 10 (Pro) on my personal
> > > computer, in as much as I was able to tell Windows to assign a new MAC
> > > address of my choosing, and I saw through wireshark the new MAC
> > > address was pushed out to the device.  Afterward, Windows reported a
> > > new IP address and I was able to view web pages.
> > >
> > > This series of patches give support to cdc_ncm USB based Ethernet
> > > controllers for programming a MAC address to the device, and also to
> > > retrieve the device's MAC address.  This patch series further adds
> > > ACPI MAC address pass through support specifically for the cdc_ncm
> > > driver, and generally for any other driver that may need or want it,
> > > in furtherance of Dell's enterprise IT policy efforts.  It was this
> > > latter that I initially found lacking when testing a D6000 with a Dell
> > > laptop, and then I found ifconfig was unable to set a MAC address into
> > > the device.  These patches bring a similar level of functionality to
> > > cdc_ncm driver as is available with the Realtek r8152 driver, and is available
> > with Windows.
> > >
> > > The cdc_ncm driver limits the ACPI MAC address pass through support to
> > > only the Dell Universal Dock D6000, so no other cdc_ncm device will be
> > > impacted.
> > >
> > > Charles Hyde (3):
> > >   net: cdc_ncm: add get/set ethernet address functions
> > >   ACPI: move ACPI functionality out of r8152 driver
> > >   net: cdc_ncm: Add ACPI MAC address pass through functionality
> > >
> > >  drivers/acpi/Makefile            |   1 +
> > >  drivers/acpi/acpi_mac_passthru.c |  63 +++++++++++++
> > >  drivers/net/usb/cdc_ncm.c        | 148 ++++++++++++++++++++++++++++---
> > >  drivers/net/usb/r8152.c          |  44 +--------
> > >  include/acpi/acpi_mac_passthru.h |  29 ++++++
> > >  5 files changed, 234 insertions(+), 51 deletions(-)  create mode
> > > 100644 drivers/acpi/acpi_mac_passthru.c  create mode 100644
> > > include/acpi/acpi_mac_passthru.h
> > >
> > > --
> > > 2.20.1
> > 
> > Typical practice is to make this new patch series prefixed with a v2. And to
> > describe what has changed From v1 either in individual patches below the '--'
> > or in the cover letter.
> > 
> > So can you please describe what changed from previous submission in case it's
> > not obvious to reviewers?
> > 
> > For example:
> > 
> > [PATCH v2 0/3] Add get/set ethernet address functions and ACPI MAC address
> > pass through functionality to cdc_ncm driver
> > 
> > Changes from v1 to v 2:
> > * Changed foo to bar
> 
> 
> Ah, my apologies.
> 
> What changed with today's patch series from what I proposed on Friday, August 30, is that I created a function named get_ethernet_addr() which replaces two instances where the same code snippet was located in the previous patch series.  I also created a post reset function to set the MAC address, if there exists an ACPI MAC address pass through (MAPT).  Oliver Neukum had requested a post reset function for this purpose.

Please resend the series with that information in it, and also properly
thread the emails so they are at least clustered together.

thanks,

greg k-h
