Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA2E1179AB
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Dec 2019 23:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfLIWtU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 9 Dec 2019 17:49:20 -0500
Received: from mga17.intel.com ([192.55.52.151]:20294 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbfLIWtU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 9 Dec 2019 17:49:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Dec 2019 14:34:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,296,1571727600"; 
   d="scan'208";a="363078147"
Received: from laumelis-mobl1.amr.corp.intel.com ([10.251.26.176])
  by orsmga004.jf.intel.com with ESMTP; 09 Dec 2019 14:34:55 -0800
Message-ID: <7cc9a74a0e16b8e3583401f6be43820377a8f875.camel@linux.intel.com>
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
Date:   Mon, 09 Dec 2019 14:34:54 -0800
In-Reply-To: <56a33219fc336c26b8ef9d8de1a3d50893a7b7d1.camel@linux.intel.com>
References: <1773028.iBGNyVBcMc@kreacher>
         <2991d01601fdbcf25d745a387eda74926f1192b2.camel@intel.com>
         <56a33219fc336c26b8ef9d8de1a3d50893a7b7d1.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, 2019-12-05 at 09:32 -0800, Todd Brandt wrote:
> On Wed, 2019-12-04 at 22:04 +0800, Zhang Rui wrote:
> > On Wed, 2019-12-04 at 02:54 +0100, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > 
> > > Certain ACPI-enumerated devices represented as platform devices
> > > in
> > > Linux, like fans, require special low-level power management
> > > handling
> > > implemented by their drivers that is not in agreement with the
> > > ACPI
> > > PM domain behavior.  That leads to problems with managing ACPI
> > > fans
> > > during system-wide suspend and resume.
> > > 
> > > For this reason, make acpi_dev_pm_attach() skip the affected
> > > devices
> > > by adding a list of device IDs to avoid to it and putting the IDs
> > > of
> > > the affected devices into that list.
> > > 
> > > Fixes: e5cc8ef31267 (ACPI / PM: Provide ACPI PM callback routines
> > > for
> > > subsystems)
> > > Reported-by: Zhang Rui <rui.zhang@intel.com>
> > > Cc: 3.10+ <stable@vger.kernel.org> # 3.10+
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > > 
> > > Rui,
> > > 
> > > Please test this on the machine(s) affected by the fan
> > > suspend/resume
> > > issues.
> > 
> > Sure, Todd and I will re-run stress test with this patch applied
> > when
> > 5.5-rc1 released.
> 
> I've applied it 5.4.0 and will do a full stress test run this weekend
> in the lab (where 7 out of 20 machines have this issue). The kernel
> will be called "5.4.0-acpifanfix", and the data should be ready
> Sunday
> Dec 8.
> 
> This is the issue I'll test for:
> https://bugzilla.kernel.org/show_bug.cgi?id=204321
> 

The test data is in and I'm very happy to report that the patch works
extremely well. Here's the data gathered on the bugzilla issue 204321:
ACPI fan resume is too long.

[With the patch]

Kernel              Host                      Test Run    Count Rate
5.4.0-acpifanfix    otcpl-whl-u-clear         mem-x2351    1    0.04%
5.4.0-acpifanfix    otcpl-z170x-ud5           mem-x2369    0    0%
5.4.0-acpifanfix    otcpl-z170x-ud5           freeze-x2492 0    0%
5.4.0-acpifanfix    otcpl-whl-u-clear         freeze-x2411 0    0%
5.4.0-acpifanfix    otcpl-whl-u               mem-x2289    0    0%
5.4.0-acpifanfix    otcpl-whl-u               freeze-x2389 0    0%
5.4.0-acpifanfix    otcpl-icl-u-2             mem-x2273    0    0%
5.4.0-acpifanfix    otcpl-icl-u-2             freeze-x817  0    0%
5.4.0-acpifanfix    otcpl-glk-rvp-1           freeze-x122  0    0%
5.4.0-acpifanfix    otcpl-dell-p5510-xeon-1   mem-x1851    0    0%
5.4.0-acpifanfix    otcpl-dell-p5510-xeon-1   freeze-x1994 0    0%
5.4.0-acpifanfix    otcpl-dell-inspiron-3493  mem-x1722    0    0%
5.4.0-acpifanfix    otcpl-dell-inspiron-3493  freeze-x2102 0    0%
5.4.0-acpifanfix    otcpl-cfl-u-01            mem-x39      0    0%
5.4.0-acpifanfix    otcpl-cfl-u-01            freeze-x2091 0    0%
5.4.0-acpifanfix    otcpl-cfl-h               mem-x415     0    0%
5.4.0-acpifanfix    otcpl-cfl-h               freeze-x2265 0    0%
5.4.0-acpifanfix    otcpl-aml-y               mem-x3126    0    0%
5.4.0-acpifanfix    otcpl-aml-y               freeze-x2288 0    0%

[Without the patch]

Kernel    Host                      Test Run    Count Rate
5.3.0+    otcpl-icl-u-2             mem-x2571    2571 100.00%
5.3.0+    otcpl-whl-u               mem-x2497    2497 100.00%
5.3.0+    otcpl-cfl-h               mem-x2068    2068 100.00%
5.3.0+    otcpl-glk-rvp-1           mem-x75      74   98.67%
5.3.0+    otcpl-cfl-u-01            mem-x1074    1050 97.77%
5.3.0+    otcpl-glk-rvp-1           freeze-x45   12   26.67%
5.3.0+    otcpl-whl-u               freeze-x2649 428  16.16%
5.3.0+    otcpl-aml-y               freeze-x2434 373  15.32%
5.3.0+    otcpl-cfl-u-01            freeze-x2419 123  5.08%
5.3.0+    otcpl-latexo-ivb-cpt      freeze-x1914 97   5.07%
5.3.0+    otcpl-whl-u-clear         mem-x2640    69   2.61%
5.3.0+    otcpl-icl-u-2             freeze-x2757 59   2.14%
5.3.0+    otcpl-whl-u-clear         freeze-x2830 53   1.87%
5.3.0+    otcpl-tgl-rvp             freeze-x2086 20   0.96%
5.3.0+    otcpl-cfl-h               freeze-x2457 8    0.33%
5.3.0+    otcpl-latexo-ivb-cpt      mem-x2000    4    0.20%
5.3.0+    otcpl-aml-y               mem-x2727    2    0.07%
5.3.0+    otcpl-z170x-ud5           mem-x2669    0    0%    
5.3.0+    otcpl-z170x-ud5           freeze-x2881 0    0%    
5.3.0+    otcpl-lenovo-ideapad-130  mem-x2000    0    0%    
5.3.0+    otcpl-lenovo-ideapad-130  freeze-x2000 0    0%    
5.3.0+    otcpl-dell-p5510-xeon-2   mem-x570     0    0%    
5.3.0+    otcpl-dell-p5510-xeon-2   freeze-x1093 0    0%    
5.3.0+    otcpl-dell-p5510-xeon-1   mem-x2209    0    0%    
5.3.0+    otcpl-dell-p5510-xeon-1   freeze-x2431 0    0%    
5.3.0+    otcpl-dell-inspiron-3493  freeze-x1170 0    0%    
5.3.0+    otcpl-chromebook-hsw      freeze-x1305 0    0%    
5.3.0+    otcpl-chromebook-hsw      freeze-x368  0    0%    

> > 
> > thanks,
> > rui
> > 
> > > 
> > > I don't really see any cleaner way to address this problem,
> > > because
> > > the
> > > ACPI PM domain should not be used with the devices in question
> > > even
> > > if
> > > the driver that binds to them is not loaded.
> > > 
> > > Cheers,
> > > Rafael
> > > 
> > > ---
> > >  drivers/acpi/device_pm.c |   12 +++++++++++-
> > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > > 
> > > Index: linux-pm/drivers/acpi/device_pm.c
> > > =================================================================
> > > ==
> > > --- linux-pm.orig/drivers/acpi/device_pm.c
> > > +++ linux-pm/drivers/acpi/device_pm.c
> > > @@ -1314,9 +1314,19 @@ static void acpi_dev_pm_detach(struct de
> > >   */
> > >  int acpi_dev_pm_attach(struct device *dev, bool power_on)
> > >  {
> > > +	/*
> > > +	 * Skip devices whose ACPI companions match the device IDs
> > > below,
> > > +	 * because they require special power management handling
> > > incompatible
> > > +	 * with the generic ACPI PM domain.
> > > +	 */
> > > +	static const struct acpi_device_id special_pm_ids[] = {
> > > +		{"PNP0C0B", }, /* Generic ACPI fan */
> > > +		{"INT3404", }, /* Fan */
> > > +		{}
> > > +	};
> > >  	struct acpi_device *adev = ACPI_COMPANION(dev);
> > >  
> > > -	if (!adev)
> > > +	if (!adev || !acpi_match_device_ids(adev, special_pm_ids))
> > >  		return 0;
> > >  
> > >  	/*
> > > 
> > > 
> > > 
> > 
> > 

