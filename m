Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E17E1D509C
	for <lists+linux-acpi@lfdr.de>; Fri, 15 May 2020 16:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgEOOgZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 May 2020 10:36:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:49012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbgEOOgZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 May 2020 10:36:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF58D20671;
        Fri, 15 May 2020 14:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589553384;
        bh=Veoljy1+igqZX3k6pjqIjP7pIUUoD466ftNFEhbs7K4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i4M5dSEzsRnlnNkWak0gZ0CjGJmT1XV9eYjJ+dACkmPvRcFdJczuYVCaYanqpnp0N
         jHXXUESuWdIn7Jv8PEPRazFU/TnOSGbelYlJ9ZQlFYcagPR8ukPn7eiYF9p2dESAd2
         W3gU7NVIXTkWv96+3dpFG1h0o0TtYN8Aj7/1I/eo=
Date:   Fri, 15 May 2020 16:36:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Ji Luo <ji.luo@nxp.com>
Subject: Re: [PATCH v1 0/4] Optimize fw_devlink parsing
Message-ID: <20200515143622.GA2526356@kroah.com>
References: <20200515053500.215929-1-saravanak@google.com>
 <CAGETcx-7qnNXug4PGssdXciy0BZrspXP0njJG+GFGFgie_Dwnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx-7qnNXug4PGssdXciy0BZrspXP0njJG+GFGFgie_Dwnw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, May 15, 2020 at 01:52:37AM -0700, Saravana Kannan wrote:
> On Thu, May 14, 2020 at 10:35 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > When fw_devlink is enabled on hardware with a large number of device
> > tree nodes, the initial device addition done in
> > of_platform_default_populate_init() can be very inefficient. This is
> > because most devices will fail to find all their suppliers when they are
> > added and will keep trying to parse their device tree nodes and link to
> > any newly added devices
> >
> > This was an item on my TODO list that I'm finally getting around to. On
> > hardware I'm testing on, this saved 1.216 _seconds_!
> 
> Correction. It went from 1.216 _seconds_ to 61 _milliseconds_! So
> about 95% reduction in time.

Nice speedups!  All now queued up, thanks.

greg k-h
