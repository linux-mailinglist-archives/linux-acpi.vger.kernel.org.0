Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 679EF3D49AD
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Jul 2021 21:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbhGXTIb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 24 Jul 2021 15:08:31 -0400
Received: from mga02.intel.com ([134.134.136.20]:1833 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229481AbhGXTIb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 24 Jul 2021 15:08:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10055"; a="199243023"
X-IronPort-AV: E=Sophos;i="5.84,266,1620716400"; 
   d="scan'208";a="199243023"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2021 12:49:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,266,1620716400"; 
   d="scan'208";a="578703268"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 24 Jul 2021 12:49:01 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.54.75.160])
        by linux.intel.com (Postfix) with ESMTP id 9299F5805CB;
        Sat, 24 Jul 2021 12:49:01 -0700 (PDT)
Message-ID: <27751c8ff02d98cabd512472b29078b11f4bdf0e.camel@linux.intel.com>
Subject: Re: [PATCH 2/2] platform/x86/intel/pmc: Add PSON residency counter
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Michael Bottini <michael.a.bottini@linux.intel.com>
Cc:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "irenic.rajneesh@gmail.com" <irenic.rajneesh@gmail.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Date:   Sat, 24 Jul 2021 12:49:01 -0700
In-Reply-To: <CAHp75Ve2Ls9KVM0KZ2GMgbrQvc6wXvAXP1CqSLzQ4JWMTAcZ0A@mail.gmail.com>
References: <20210723202157.2425-1-michael.a.bottini@linux.intel.com>
         <20210723202157.2425-2-michael.a.bottini@linux.intel.com>
         <CAHp75Ve2Ls9KVM0KZ2GMgbrQvc6wXvAXP1CqSLzQ4JWMTAcZ0A@mail.gmail.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, 2021-07-24 at 11:29 +0300, Andy Shevchenko wrote:
> 
> 
> On Friday, July 23, 2021, Michael Bottini
> <michael.a.bottini@linux.intel.com> wrote:
> > Tiger Lake devices have the capability to track the duration
> > of time that their Power Supply Units (PSUs) are turned off during
> > S0ix.
> > This patch adds a debugfs file `pson_residency_usec` to provide
> > access to this counter.
> > 
> > In order to determine whether the device is capable of PSON,
> > use acpi_init_properties() to reevaluate _DSD.
> > 
> > 
> 
> It’s direct abuse of ACPI specification as I read it:
> 
> “_DSD must return the same data each time it is evaluated. Firmware
> should not expect it to be evaluated every time (in case it is
> implemented as a method).”
> 
> 
> NAK to the series.

Okay, we'll check with the BIOS folks. They are setting this property
from _STA. They may not expect OSPM to reevaluate _DSD. But they may
have expected that OSPM doesn't attempt to read _DSD until after _STA
is executed.

David

> 
> 
> 
> 
>  
> > Signed-off-by: Michael Bottini <michael.a.bottini@linux.intel.com>
> > ---
> >  drivers/platform/x86/intel/pmc/core.c | 46
> > +++++++++++++++++++++++++++
> >  drivers/platform/x86/intel/pmc/core.h |  7 ++++
> >  2 files changed, 53 insertions(+)
> > 
> > diff --git a/drivers/platform/x86/intel/pmc/core.c
> > b/drivers/platform/x86/intel/pmc/core.c
> > index 7c4bf7d22fd5..6cf06aecf368 100644
> > --- a/drivers/platform/x86/intel/pmc/core.c
> > +++ b/drivers/platform/x86/intel/pmc/core.c
> > @@ -595,6 +595,8 @@ static const struct pmc_reg_map tgl_reg_map = {
> >         .lpm_sts = tgl_lpm_maps,
> >         .lpm_status_offset = TGL_LPM_STATUS_OFFSET,
> >         .lpm_live_status_offset = TGL_LPM_LIVE_STATUS_OFFSET,
> > +       .pson_residency_offset = TGL_PSON_RESIDENCY_OFFSET,
> > +       .pson_residency_counter_step = TGL_PSON_RES_COUNTER_STEP,
> >         .etr3_offset = ETR3_OFFSET,
> >  };
> > 
> > @@ -1084,6 +1086,20 @@ static int pmc_core_dev_state_get(void
> > *data,
> > u64 *val)
> > 
> >  DEFINE_DEBUGFS_ATTRIBUTE(pmc_core_dev_state,
> > pmc_core_dev_state_get,
> > NULL, "%llu\n");
> > 
> > +static int pmc_core_pson_residency_get(void *data, u64 *val)
> > +{
> > +       struct pmc_dev *pmcdev = data;
> > +       const struct pmc_reg_map *map = pmcdev->map;
> > +       u32 value;
> > +
> > +       value = pmc_core_reg_read(pmcdev, map-
> > > pson_residency_offset);
> > +       *val = (u64)value * pmcdev->map-
> > >pson_residency_counter_step;
> > +
> > +       return 0;
> > +}
> > +
> > +DEFINE_DEBUGFS_ATTRIBUTE(pmc_core_pson_residency,
> > pmc_core_pson_residency_get, NULL, "%llu\n");
> > +
> >  static int pmc_core_check_read_lock_bit(struct pmc_dev *pmcdev)
> >  {
> >         u32 value;
> > @@ -1788,6 +1804,30 @@ static void
> > pmc_core_get_low_power_modes(struct pmc_dev *pmcdev)
> >         }
> >  }
> > 
> > +static bool pmc_core_is_pson_residency_enabled(struct pmc_dev
> > *pmcdev)
> > +{
> > +       struct platform_device *pdev = pmcdev->pdev;
> > +       struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
> > +       acpi_status status;
> > +       u8 val;
> > +
> > +       if (!adev)
> > +               return false;
> > +
> > +       acpi_init_properties(adev);
> > +       status = acpi_evaluate_object(adev->handle, "PSOP", NULL,
> > NULL);
> > +
> > +       if (ACPI_FAILURE(status))
> > +               return false;
> > +
> > +       if (fwnode_property_read_u8(acpi_fwnode_handle(adev),
> > +                                   "intel-cec-pson-switching-
> > enabled-in-s0",
> > +                                   &val))
> > +               return false;
> > +
> > +       return val == 1;
> > +}
> > +
> >  static void pmc_core_dbgfs_unregister(struct pmc_dev *pmcdev)
> >  {
> >         debugfs_remove_recursive(pmcdev->dbgfs_dir);
> > @@ -1856,6 +1896,11 @@ static void pmc_core_dbgfs_register(struct
> > pmc_dev *pmcdev)
> >                                     pmcdev->dbgfs_dir, pmcdev,
> >                                    
> > &pmc_core_substate_req_regs_fops);
> >         }
> > +
> > +       if (pmcdev->map->pson_residency_offset &&
> > pmc_core_is_pson_residency_enabled(pmcdev)) {
> > +               debugfs_create_file("pson_residency_usec", 0444,
> > +                                   pmcdev->dbgfs_dir, pmcdev,
> > &pmc_core_pson_residency);
> > +       }
> >  }
> > 
> >  static const struct x86_cpu_id intel_pmc_core_ids[] = {
> > @@ -1944,6 +1989,7 @@ static int pmc_core_probe(struct
> > platform_device *pdev)
> >                 return -ENOMEM;
> > 
> >         platform_set_drvdata(pdev, pmcdev);
> > +       pmcdev->pdev = pdev;
> > 
> >         cpu_id = x86_match_cpu(intel_pmc_core_ids);
> >         if (!cpu_id)
> > diff --git a/drivers/platform/x86/intel/pmc/core.h
> > b/drivers/platform/x86/intel/pmc/core.h
> > index 333e25981e8e..822d77f49861 100644
> > --- a/drivers/platform/x86/intel/pmc/core.h
> > +++ b/drivers/platform/x86/intel/pmc/core.h
> > @@ -214,6 +214,10 @@ enum ppfear_regs {
> >  #define TGL_LPM_PRI_OFFSET                     0x1C7C
> >  #define TGL_LPM_NUM_MAPS                       6
> > 
> > +/* Tigerlake PSON residency register */
> > +#define TGL_PSON_RESIDENCY_OFFSET              0x18f8
> > +#define TGL_PSON_RES_COUNTER_STEP              0x7A
> > +
> >  /* Extended Test Mode Register 3 (CNL and later) */
> >  #define ETR3_OFFSET                            0x1048
> >  #define ETR3_CF9GR                             BIT(20)
> > @@ -301,6 +305,8 @@ struct pmc_reg_map {
> >         const u32 lpm_residency_offset;
> >         const u32 lpm_status_offset;
> >         const u32 lpm_live_status_offset;
> > +       const u32 pson_residency_offset;
> > +       const u32 pson_residency_counter_step;
> >         const u32 etr3_offset;
> >  };
> > 
> > @@ -337,6 +343,7 @@ struct pmc_dev {
> >         int num_lpm_modes;
> >         int lpm_en_modes[LPM_MAX_NUM_MODES];
> >         u32 *lpm_req_regs;
> > +       struct platform_device *pdev;
> >  };
> > 
> >  #define pmc_for_each_mode(i, mode, pmcdev)             \
> > -- 
> > 2.25.1
> > 
> > 
> 
> 


