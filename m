Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7777841E7F
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2019 10:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfFLIBY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 Jun 2019 04:01:24 -0400
Received: from mga09.intel.com ([134.134.136.24]:29902 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbfFLIBY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 12 Jun 2019 04:01:24 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2019 01:01:22 -0700
X-ExtLoop1: 1
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 12 Jun 2019 01:01:19 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 12 Jun 2019 11:01:18 +0300
Date:   Wed, 12 Jun 2019 11:01:18 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Subject: Re: How to inject fwnode/oftree/acpi data by platform driver ?
Message-ID: <20190612080118.GA18301@kuha.fi.intel.com>
References: <c15a9872-4ad4-1b7e-e34f-14549b5b55eb@metux.net>
 <CAHp75Vc_FnSaqq_Xu_Y3uXBYY=HbGsthVOAqyt4c-dH7sRGVVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vc_FnSaqq_Xu_Y3uXBYY=HbGsthVOAqyt4c-dH7sRGVVw@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On Tue, Jun 11, 2019 at 09:44:23PM +0300, Andy Shevchenko wrote:
> +Cc: Heikki.
> Heikki, can you help here with swnodes?
> 
> On Sat, Jun 1, 2019 at 5:17 PM Enrico Weigelt, metux IT consult
> <lkml@metux.net> wrote:
> >
> > Hi folks,
> >
> >
> > I'm looking for a way to inject fwnode data from a platform driver,
> > in order to initialize generic drivers w/ board specific configuration.
> > The idea is getting rid of passing driver specific pdata structs
> > (which, IIRC, seem to be deprecated).
> >
> > An example usecase is the APUv2/3 board, which have things like gpios
> > wired to buttons and LEDs. The board can only be detected via DMI
> > string, no way to probe the platform devices - have to be initialized
> > explicitly (that's how I'm already doing it now).
> >
> > The nicest way, IMHO, would be if I could just write some piece of DTS
> > and some fancy magic all the rest under the hood. Such thing doesn't
> > seem to exist yet. Does it make sense to implement that ? How could
> > we do it ?
> >
> > Which other options do we have ?
> >
> > Or should we just leave everything as it is and stick w/ pdata structs ?

The software nodes (drivers/base/swnode.c) were designed to supply
fwnodes that describe devices in the same way DT does. The goal I had
with the software nodes was exaclty to get rid of pdata, so they do
sound like the thing you are looking for. If you check Rafael's latest
linux-next branch [1], drivers/platform/x86/intel_cht_int33fe.c can be
used as an example how to use the software nodes.

I think it's time to add documentation for the software nodes to the
kernel, but I'll list here the features the software nodes have:

- The software nodes are created independently from device entries.
- Software nodes support hierarchy. Every software node has a pointer
  to a parent software node.
- Software nodes can have device properties.
- Software nodes can have reference pointers to other software nodes
  (outside of the hierarchy).

Creating the software nodes from static description (struct
software_node - available from Linux kernel v5.3 onwards) is
straightforward. Once you have them, when you create your device
entries (struct device), you can associate a software node with a
device just like like any other fwnode:

        device_initialize(&my_dev);
        my_dev.parent = parent;
        my_dev.fwnode = software_node_fwnode(&my_node);
        ...
        device_add(&my_device);

After that, you can access all the information the software nodes
supply to the device by using fwnode_* APIs from your driver, just
like with ACPI or DT. Basically the entire fwnode_* API is now
supported with softwarw nodes, except the device graph (fwnode_graph*)
API.

One final note. The hardware description must always primarily come
from the system firmware. You only use software nodes if it's too
late to influence what goes to the ACPI tables, or if using DTS is not
an option.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?h=linux-next

thanks,

-- 
heikki
