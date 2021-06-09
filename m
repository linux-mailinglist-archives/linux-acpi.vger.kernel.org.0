Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2125A3A0F94
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Jun 2021 11:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237949AbhFIJ03 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Jun 2021 05:26:29 -0400
Received: from mga04.intel.com ([192.55.52.120]:11756 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233972AbhFIJ03 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 9 Jun 2021 05:26:29 -0400
IronPort-SDR: Rt1Bq+uLzVByaVhiyJd+02/IQv6fidlvPxpv1WmrY9CeEXDwn+9KlXBqNe001FxqWSGNK0D8Mj
 CC0dcaE8Qb9Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="203183918"
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; 
   d="scan'208";a="203183918"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 02:24:34 -0700
IronPort-SDR: N7YechYws/gdpL3BpFCk/UyUb/uO1sL3uD/PgSbgUbq8Mf7LjTVDfNhJHfpWbJ+aVh+XTH7Ejz
 PdOlsvyfL+4w==
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; 
   d="scan'208";a="552617607"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 02:24:31 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 09 Jun 2021 12:24:29 +0300
Date:   Wed, 9 Jun 2021 12:24:29 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mario Limonciello <mario.limonciello@outlook.com>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH] ACPI: Pass the same capabilities to the _OSC regardless
 of the query flag
Message-ID: <YMCIzfV7QJq+Kksu@lahna.fi.intel.com>
References: <YL+Gqh9dT06SBLCx@lahna.fi.intel.com>
 <20210608163810.18071-1-mika.westerberg@linux.intel.com>
 <d0bdb868-95c9-8908-06e1-01f1364f12a0@redhat.com>
 <3b58902f-fda3-d957-2e9c-204e82b2f570@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b58902f-fda3-d957-2e9c-204e82b2f570@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jun 09, 2021 at 09:58:31AM +0200, Hans de Goede wrote:
> Hi,
> 
> On 6/8/21 7:10 PM, Hans de Goede wrote:
> > Hi,
> > 
> > On 6/8/21 6:38 PM, Mika Westerberg wrote:
> >> Commit 719e1f561afb ("ACPI: Execute platform _OSC also with query bit
> >> clear") makes acpi_bus_osc_negotiate_platform_control() not only query
> >> the platforms capabilities but it also commits the result back to the
> >> firmware to report which capabilities are supported by the OS back to
> >> the firmware
> >>
> >> On certain systems the BIOS loads SSDT tables dynamically based on the
> >> capabilities the OS claims to support. However, on these systems the
> >> _OSC actually clears some of the bits (under certain conditions) so what
> >> happens is that now when we call the _OSC twice the second time we pass
> >> the cleared values and that results errors like below to appear on the
> >> system log:
> >>
> >>   ACPI BIOS Error (bug): Could not resolve symbol [\_PR.PR00._CPC], AE_NOT_FOUND (20210105/psargs-330)
> >>   ACPI Error: Aborting method \_PR.PR01._CPC due to previous error (AE_NOT_FOUND) (20210105/psparse-529)
> >>
> >> In addition the ACPI 6.4 spec says following [1]:
> >>
> >>   If the OS declares support of a feature in the Support Field in one
> >>   call to _OSC, then it must preserve the set state of that bit
> >>   (declaring support for that feature) in all subsequent calls.
> >>
> >> Based on the above we can fix the issue by passing the same set of
> >> capabilities to the platform wide _OSC in both calls regardless of the
> >> query flag.
> >>
> >> While there drop the context.ret.length check which was wrong to begin
> >> with (as the length is number of bytes not elements). This is already
> >> checked in acpi_run_osc() that also returns an error in that case.
> >>
> >> [1] https://uefi.org/specs/ACPI/6.4/06_Device_Configuration/Device_Configuration.html#sequence-of-osc-calls
> >>
> >> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=213023
> >> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1963717
> >> Fixes: 719e1f561afb ("ACPI: Execute platform _OSC also with query bit clear")
> >> Cc: Mario Limonciello <mario.limonciello@outlook.com>
> >> cc: Hans de Goede <hdegoede@redhat.com>
> >> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> >> ---
> >>  drivers/acpi/bus.c | 21 +++++++--------------
> >>  1 file changed, 7 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> >> index be7da23fad76..61e8c02595ac 100644
> >> --- a/drivers/acpi/bus.c
> >> +++ b/drivers/acpi/bus.c
> >> @@ -336,26 +336,19 @@ static void acpi_bus_osc_negotiate_platform_control(void)
> >>  		return;
> >>  	}
> >>  
> >> -	/*
> >> -	 * Now run _OSC again with query flag clear and with the caps
> >> -	 * supported by both the OS and the platform.
> >> -	 */
> >> +	/* Now run _OSC again with query flag clear */
> >>  	capbuf[OSC_QUERY_DWORD] = 0;
> >> -	capbuf[OSC_SUPPORT_DWORD] = capbuf_ret[OSC_SUPPORT_DWORD];
> >> -	kfree(context.ret.pointer);
> > 
> > This kfree needs to be moved up, rather then be completely removed
> > and you are still leaving 1 of the unnecessary length checks in place.
> > 
> > I've added this fixup on top, to fix both these issues:
> > 
> > --- a/drivers/acpi/bus.c
> > +++ b/drivers/acpi/bus.c
> > @@ -330,11 +330,7 @@ static void acpi_bus_osc_negotiate_platform_control(void)
> >  	if (ACPI_FAILURE(acpi_run_osc(handle, &context)))
> >  		return;
> >  
> > -	capbuf_ret = context.ret.pointer;
> > -	if (context.ret.length <= OSC_SUPPORT_DWORD) {
> > -		kfree(context.ret.pointer);
> > -		return;
> > -	}
> > +	kfree(context.ret.pointer);
> >  
> >  	/* Now run _OSC again with query flag clear */
> >  	capbuf[OSC_QUERY_DWORD] = 0;
> > 
> > I'll ask the reporters of:
> > https://bugzilla.kernel.org/show_bug.cgi?id=213023
> > https://bugzilla.redhat.com/show_bug.cgi?id=1963717
> > 
> > To test the (fixed-up) patch, so that they can confirm if this indeed
> > fixes things.
> 
> I've received confirmation from 2 users that this patch (with the fixup)
> fixes this. Can send a v2 with the fixup squashed in for Rafael to pick up?

Thanks Hans for the fixup and checking with the users! I will send the
v2 with your fixup soon.
