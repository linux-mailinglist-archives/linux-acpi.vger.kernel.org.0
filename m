Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5433D93B9
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jul 2021 18:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbhG1Q53 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 28 Jul 2021 12:57:29 -0400
Received: from mga12.intel.com ([192.55.52.136]:51739 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230101AbhG1Q5Q (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 28 Jul 2021 12:57:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10059"; a="192300304"
X-IronPort-AV: E=Sophos;i="5.84,276,1620716400"; 
   d="scan'208";a="192300304"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2021 09:57:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,276,1620716400"; 
   d="scan'208";a="417827554"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 28 Jul 2021 09:57:13 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.54.75.160])
        by linux.intel.com (Postfix) with ESMTP id 79C2158086A;
        Wed, 28 Jul 2021 09:57:13 -0700 (PDT)
Message-ID: <d5972bd061a00c2b8e9e7953a4472a853336f359.camel@linux.intel.com>
Subject: Re: [PATCH 1/2] acpi: Add acpi_init_properties to ACPI driver code
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Hans de Goede <hdegoede@redhat.com>,
        Michael Bottini <michael.a.bottini@linux.intel.com>,
        rjw@rjwysocki.net, lenb@kernel.org, irenic.rajneesh@gmail.com,
        mgross@linux.intel.com
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Date:   Wed, 28 Jul 2021 09:57:13 -0700
In-Reply-To: <1fd1a48e-3756-e933-9038-cb3f3e247144@redhat.com>
References: <20210723202157.2425-1-michael.a.bottini@linux.intel.com>
         <d8e4f0f3-7282-50d4-16ac-2f67b210373c@redhat.com>
         <1fd1a48e-3756-e933-9038-cb3f3e247144@redhat.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 2021-07-28 at 11:10 +0200, Hans de Goede wrote:
> Hi,
> 
> On 7/28/21 11:08 AM, Hans de Goede wrote:
> > Hi,
> > 
> > On 7/23/21 10:21 PM, Michael Bottini wrote:
> > > Some products in the field, like Intel Rocket Lake systems,
> > > contain
> > > AML code that can modify _DSD properties after they have been
> > > evaluated by ACPI init code. Therefore, there is a need for
> > > drivers
> > > to be able to reevaluate _DSDs so that the updated property
> > > values can
> > > be read. Export acpi_init_properties() for this purpose.
> > > 
> > > Signed-off-by: Michael Bottini
> > > <michael.a.bottini@linux.intel.com>
> > 
> > My first instinct here is this is a firmware bug and we should
> > go out of our way here to not support this and to instead apply
> > pressure on the vendor to get the firmware fixed.
> > 
> > Let me explain, the standard use of _DSD is to allow embedding
> > open-firmware/devicetree style properties inside ACPI nodes.
> > 
> > devicetree files, unlike AML contain static information, which
> > is parsed once and only once.
> > 
> > Allowing AML code to dynamically change _DSD results pretty
> > much breaks this entire model.
> > 
> > So I might be shooting from the hip a bit here:
> > "no, just no". IOW nack.
> 
> I should have read the rest of the thread first I guess.
> 
> I see that Andy and Rafael are saying the same thing.
> 
> So here we have 3 people who all 3 are somewhat experts in ACPI
> saying no to this. So yes please talk to the BIOS team as you
> indicated elsewhere in the thread.
> 
> Regards,
> 
> Hans

We get that reevaluating the _DSD would be against spec. We have taken
this back to the firmware team as a bug and asked for a fix or
different solution. Thanks.

> 
> 
> 
> 
> > > ---
> > >  drivers/acpi/property.c | 1 +
> > >  include/linux/acpi.h    | 6 ++++++
> > >  2 files changed, 7 insertions(+)
> > > 
> > > diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> > > index e312ebaed8db..2c1f8cf1a8f0 100644
> > > --- a/drivers/acpi/property.c
> > > +++ b/drivers/acpi/property.c
> > > @@ -432,6 +432,7 @@ void acpi_init_properties(struct acpi_device
> > > *adev)
> > >         if (!adev->data.pointer)
> > >                 acpi_extract_apple_properties(adev);
> > >  }
> > > +EXPORT_SYMBOL(acpi_init_properties);
> > >  
> > >  static void acpi_destroy_nondev_subnodes(struct list_head *list)
> > >  {
> > > diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> > > index 72e4f7fd268c..57defc3bc9b9 100644
> > > --- a/include/linux/acpi.h
> > > +++ b/include/linux/acpi.h
> > > @@ -716,6 +716,8 @@ static inline u64
> > > acpi_arch_get_root_pointer(void)
> > >  
> > >  int acpi_get_local_address(acpi_handle handle, u32 *addr);
> > >  
> > > +void acpi_init_properties(struct acpi_device *adev);
> > > +
> > >  #else  /* !CONFIG_ACPI */
> > >  
> > >  #define acpi_disabled 1
> > > @@ -976,6 +978,10 @@ static inline int
> > > acpi_get_local_address(acpi_handle handle, u32 *addr)
> > >         return -ENODEV;
> > >  }
> > >  
> > > +static inline void acpi_init_properties(struct acpi_device
> > > *adev)
> > > +{
> > > +}
> > > +
> > >  #endif /* !CONFIG_ACPI */
> > >  
> > >  #ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
> > > 
> 


