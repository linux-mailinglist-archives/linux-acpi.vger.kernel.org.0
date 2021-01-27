Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5A8305C30
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Jan 2021 13:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237943AbhA0Mzb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Jan 2021 07:55:31 -0500
Received: from mga11.intel.com ([192.55.52.93]:48650 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238066AbhA0Mwi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 27 Jan 2021 07:52:38 -0500
IronPort-SDR: CZB6JRl299cKdDBLVezpuoH95l8KaZPXMy87ZusmDfMXf820Ge0MaFAB1rT8XSbayo3MVNU7Oq
 /HEOEehY/jnQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="176551754"
X-IronPort-AV: E=Sophos;i="5.79,379,1602572400"; 
   d="scan'208";a="176551754"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 04:49:44 -0800
IronPort-SDR: NJDK9KRqBG61tdPn3HyFnSon9wtk2ujx9vVoCAGI5VRYIYZ7c7AZDO6Raw4eqkCxGCsEMa8N96
 97IuSuPBu5Tg==
X-IronPort-AV: E=Sophos;i="5.79,379,1602572400"; 
   d="scan'208";a="362420090"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 04:49:38 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 27 Jan 2021 14:49:35 +0200
Date:   Wed, 27 Jan 2021 14:49:35 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Limonciello, Mario" <Mario.Limonciello@dell.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Christian Kellner <christian@kellner.me>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 4/6] ACPI: Execute platform _OSC also with query bit clear
Message-ID: <20210127124935.GC2542@lahna.fi.intel.com>
References: <20210126155723.9388-1-mika.westerberg@linux.intel.com>
 <20210126155723.9388-5-mika.westerberg@linux.intel.com>
 <CAJZ5v0i+wCOFZOhyx6i=TUGMeWyQR4vXzDN06G6xheFwC66Tuw@mail.gmail.com>
 <SA1PR19MB4926907D028D3F924FF42A36FABC9@SA1PR19MB4926.namprd19.prod.outlook.com>
 <CAJZ5v0hQ_JZVfOpSZY0hxc01He9x7uzgU2rsKffmQubaeKy=EA@mail.gmail.com>
 <SA1PR19MB4926A9A1E4D0AD96FAE236B3FABC9@SA1PR19MB4926.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR19MB4926A9A1E4D0AD96FAE236B3FABC9@SA1PR19MB4926.namprd19.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 26, 2021 at 10:43:32PM +0000, Limonciello, Mario wrote:
> > I would put that information into the changelog.
> 
> Thanks, @Mika Westerberg can you collapse that in when you re-spin the
> series?

Sure.

> > 
> > Moreover, have you looked at acpi_pci_osc_control_set()?
> > 
> > What it does is analogous to what you are proposing, but a bit
> > different, and I would like to preserve consistency between _OSC use
> > cases.
> > 
> > So would it be possible to adjust the _SB _OSC evaluation flow to
> > follow the PCI _OSC one?  That is, if any control bits are there, pass
> > them along with the last evaluation of _OSC with the query flag clear.
> > Or is the latter defective and if so then why?
> 
> Basically the only difference is another line cloning OSC_CONTROL_DWORD from
> capbuf_ret to capbuf?
> 
> Yes, this actually sounds like it better adheres to the spec to me.
> 
> Quoting spec:
> " If the OS is granted control of a feature in the Control Field in one call to
> _OSC, then it must preserve the set state of that bit (requesting that feature)
> in all subsequent calls."

However, the platform wide _OSC does not actually have this
OSC_CONTROL_DWORD at all ;-)

I think what we do in this patch is already equivalent to what the PCI
_OSC is doing:

  1. Query bit set _OSC
  2. Take the returned OSC_SUPPORT_DWORD buffer and
  3. Pass it to the _OSC with query bit clear.

I may be missing something, though.
