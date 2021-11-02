Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3155D44298F
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Nov 2021 09:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhKBIe6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Nov 2021 04:34:58 -0400
Received: from mga06.intel.com ([134.134.136.31]:65314 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231356AbhKBIez (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 2 Nov 2021 04:34:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10155"; a="292048517"
X-IronPort-AV: E=Sophos;i="5.87,202,1631602800"; 
   d="scan'208";a="292048517"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2021 01:32:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,202,1631602800"; 
   d="scan'208";a="638114603"
Received: from kuha.fi.intel.com ([10.237.72.166])
  by fmsmga001.fm.intel.com with SMTP; 02 Nov 2021 01:32:11 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 02 Nov 2021 10:32:10 +0200
Date:   Tue, 2 Nov 2021 10:32:10 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Qian Cai <quic_qiancai@quicinc.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] software node: Skip duplicated software_node sysfs
Message-ID: <YYD3iqLEoaalO79M@kuha.fi.intel.com>
References: <20211101200346.16466-1-quic_qiancai@quicinc.com>
 <CAHp75VcrWPdR8EVGpcsniQedT0J4X700N7thFs6+srTP1MTgwQ@mail.gmail.com>
 <YYD2uXPcnFmiy54c@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YYD2uXPcnFmiy54c@kuha.fi.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 02, 2021 at 10:28:45AM +0200, Heikki Krogerus wrote:
> On Tue, Nov 02, 2021 at 01:51:34AM +0200, Andy Shevchenko wrote:
> > On Monday, November 1, 2021, Qian Cai <quic_qiancai@quicinc.com> wrote:
> > 
> > > A recent commit allowed device_create_managed_software_node() to call
> > > software_node_notify() which could generate duplicated "software_node"
> > > sysfs files. For example,
> > >
> > > "/devices/platform/808622B7:01/xhci-hcd.3.auto/software_node"
> > >
> > > Since it was created earlier from another path,
> > >
> > >   sysfs_create_link
> > >   software_node_notify
> > >   device_add
> > >   platform_device_add
> > >   dwc3_host_init
> > >   dwc3_probe
> > >   platform_probe
> > >   really_probe.part.0
> > >   really_probe
> > >   __driver_probe_device
> > >   driver_probe_device
> > >   __driver_attach
> > >   bus_for_each_dev
> > >   driver_attach
> > >   bus_add_driver
> > >   driver_register
> > >   __platform_driver_register
> > >   dwc3_driver_init at drivers/usb/dwc3/core.c:2072
> > >   do_one_initcall
> > >
> > > Fixed it by using sysfs_create_link_nowarn() in software_node_notify() to
> > > avoid those bad messages during booting,
> > 
> > 
> > No, it’s not so easy. What you are doing is a papering over the real issue
> > which is the limitation of the firmware nodes to two. What we need is to
> > drop the link from struct fwnode_handle, move it to upper layer and modify
> > all fwnode ops to be used over the list of fwnode:s.
> > 
> > XHCI driver and DWC3 are sharing the primary fwnode, but at the same time
> > they wanted to have _different_ secondary ones when role is switched. This
> > can’t be done in the current design. And here is the symptom what you got.
> 
> I'm actually not sure what is going on in this case, because this is
> the ACPI enumerated BSW board, at least based on the ACPI ID?
> 
> That board should not have the initial secondary fwnode assigned by
> the time the dwc3 host driver is called.

But what Andy said is still true. You are only hiding the core problem
with this. So this patch is not the way to go.


thanks,

-- 
heikki
