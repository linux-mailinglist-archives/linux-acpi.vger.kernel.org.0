Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A493043DB
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Jan 2021 17:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390975AbhAZQ2i (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Jan 2021 11:28:38 -0500
Received: from mga02.intel.com ([134.134.136.20]:22254 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392722AbhAZQ22 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 26 Jan 2021 11:28:28 -0500
IronPort-SDR: yR7xAnJxcESn5oZPalV0TMocXFIDQhERIWKSx+kvFqtuNzarbigAIAtdNBcYI3oFk/sxXqrMQi
 h04QodAl7nYA==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="167028845"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="167028845"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 08:26:36 -0800
IronPort-SDR: 2L8j2f9TFsRPZxtVzcEO45/L+uJEcceaGqUAlVY5H1DSO2oEyjPXUhUuefwCJiBDQacfzcAQpU
 DaFiTASvDqHQ==
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="472802064"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 08:26:32 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 26 Jan 2021 18:26:30 +0200
Date:   Tue, 26 Jan 2021 18:26:30 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Yehezkel Bernat <yehezkelshb@gmail.com>
Cc:     linux-usb@vger.kernel.org, Michael Jamet <michael.jamet@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mario Limonciello <mario.limonciello@dell.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Christian Kellner <christian@kellner.me>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH 2/6] thunderbolt: Add support for PCIe tunneling disabled
 (SL5)
Message-ID: <20210126162630.GA1988617@lahna.fi.intel.com>
References: <20210126155723.9388-1-mika.westerberg@linux.intel.com>
 <20210126155723.9388-3-mika.westerberg@linux.intel.com>
 <CA+CmpXscOVjn20ffw37GRLBWhQDRJ9J8svYvU1-VWg5eA-Bm4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CmpXscOVjn20ffw37GRLBWhQDRJ9J8svYvU1-VWg5eA-Bm4A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 26, 2021 at 06:18:47PM +0200, Yehezkel Bernat wrote:
> On Tue, Jan 26, 2021 at 5:57 PM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > Recent Intel Thunderbolt firmware connection manager has support for
> > another security level, SL5, that disables PCIe tunneling. This option
> > can be turned on from the BIOS.
> >
> > When this is set the driver exposes a new security level "nopcie" to the
> > userspace and hides the authorized attribute under connected devices.
> >
> > While there we also hide it when "dponly" security level is enabled
> > since it is not really usable in that case anyway.
> >
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> 
> Looks good to me, I'm just not sure I understand how this is different from
> dponly mode. Is this just because it comes from the new _OSC?

The firmware connection manager reports this new security level instead
of dponly so we reflect that to the userspace, and while at it take
advantage of the nopcie when USB4 _OSC disables PCIe tunneling so they
both look the same from userspace perspective.
