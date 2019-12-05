Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 440DD1145F4
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2019 18:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbfLERbv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 5 Dec 2019 12:31:51 -0500
Received: from mga09.intel.com ([134.134.136.24]:50971 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729396AbfLERbv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 5 Dec 2019 12:31:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2019 09:31:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,282,1571727600"; 
   d="scan'208";a="209217337"
Received: from pdemke-mobl.amr.corp.intel.com ([10.251.20.175])
  by fmsmga007.fm.intel.com with ESMTP; 05 Dec 2019 09:31:49 -0800
Message-ID: <56a33219fc336c26b8ef9d8de1a3d50893a7b7d1.camel@linux.intel.com>
Subject: Re: [PATCH] ACPI: PM: Avoid attaching ACPI PM domain to certain
 devices
From:   Todd Brandt <todd.e.brandt@linux.intel.com>
Reply-To: todd.e.brandt@linux.intel.com
To:     Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Brandt, Todd E" <todd.e.brandt@intel.com>
Date:   Thu, 05 Dec 2019 09:32:09 -0800
In-Reply-To: <2991d01601fdbcf25d745a387eda74926f1192b2.camel@intel.com>
References: <1773028.iBGNyVBcMc@kreacher>
         <2991d01601fdbcf25d745a387eda74926f1192b2.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 2019-12-04 at 22:04 +0800, Zhang Rui wrote:
> On Wed, 2019-12-04 at 02:54 +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Certain ACPI-enumerated devices represented as platform devices in
> > Linux, like fans, require special low-level power management
> > handling
> > implemented by their drivers that is not in agreement with the ACPI
> > PM domain behavior.  That leads to problems with managing ACPI fans
> > during system-wide suspend and resume.
> > 
> > For this reason, make acpi_dev_pm_attach() skip the affected
> > devices
> > by adding a list of device IDs to avoid to it and putting the IDs
> > of
> > the affected devices into that list.
> > 
> > Fixes: e5cc8ef31267 (ACPI / PM: Provide ACPI PM callback routines
> > for
> > subsystems)
> > Reported-by: Zhang Rui <rui.zhang@intel.com>
> > Cc: 3.10+ <stable@vger.kernel.org> # 3.10+
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> > 
> > Rui,
> > 
> > Please test this on the machine(s) affected by the fan
> > suspend/resume
> > issues.
> 
> Sure, Todd and I will re-run stress test with this patch applied when
> 5.5-rc1 released.

I've applied it 5.4.0 and will do a full stress test run this weekend
in the lab (where 7 out of 20 machines have this issue). The kernel
will be called "5.4.0-acpifanfix", and the data should be ready Sunday
Dec 8.

This is the issue I'll test for:
https://bugzilla.kernel.org/show_bug.cgi?id=204321

> 
> thanks,
> rui
> 
> > 
> > I don't really see any cleaner way to address this problem, because
> > the
> > ACPI PM domain should not be used with the devices in question even
> > if
> > the driver that binds to them is not loaded.
> > 
> > Cheers,
> > Rafael
> > 
> > ---
> >  drivers/acpi/device_pm.c |   12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> > 
> > Index: linux-pm/drivers/acpi/device_pm.c
> > ===================================================================
> > --- linux-pm.orig/drivers/acpi/device_pm.c
> > +++ linux-pm/drivers/acpi/device_pm.c
> > @@ -1314,9 +1314,19 @@ static void acpi_dev_pm_detach(struct de
> >   */
> >  int acpi_dev_pm_attach(struct device *dev, bool power_on)
> >  {
> > +	/*
> > +	 * Skip devices whose ACPI companions match the device IDs
> > below,
> > +	 * because they require special power management handling
> > incompatible
> > +	 * with the generic ACPI PM domain.
> > +	 */
> > +	static const struct acpi_device_id special_pm_ids[] = {
> > +		{"PNP0C0B", }, /* Generic ACPI fan */
> > +		{"INT3404", }, /* Fan */
> > +		{}
> > +	};
> >  	struct acpi_device *adev = ACPI_COMPANION(dev);
> >  
> > -	if (!adev)
> > +	if (!adev || !acpi_match_device_ids(adev, special_pm_ids))
> >  		return 0;
> >  
> >  	/*
> > 
> > 
> > 
> 
> 

