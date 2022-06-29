Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F7055FB00
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Jun 2022 10:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbiF2ItB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 29 Jun 2022 04:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232922AbiF2Is7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Jun 2022 04:48:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 556083CFEE
        for <linux-acpi@vger.kernel.org>; Wed, 29 Jun 2022 01:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656492537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q3uU9jTQ5T8SRwl+i9Uf1d958xlez+RICHhYAfnUYeg=;
        b=LETpgwLYrUGFCv3A4FORU9gPHhI5mi1arny7mV30voUPZ6ZJjcvcW0HSma6kRsIztl76dZ
        kin+T+yAn+YSU2hmMbILW3bCmHCO2edrEhTOfhKeosL99VaBk1uVBXcU2t6xlhang3PcIF
        9YmKapl1sacCxOJvgwLTjY7UCxFx+dM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-164-tfBXhf4LOJWQ97y6OWehdA-1; Wed, 29 Jun 2022 04:48:56 -0400
X-MC-Unique: tfBXhf4LOJWQ97y6OWehdA-1
Received: by mail-wm1-f70.google.com with SMTP id 6-20020a1c0206000000b003a02cd754d1so6305139wmc.9
        for <linux-acpi@vger.kernel.org>; Wed, 29 Jun 2022 01:48:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q3uU9jTQ5T8SRwl+i9Uf1d958xlez+RICHhYAfnUYeg=;
        b=qiGiQutz92XJZy763KicU1bdNdStQoMZ/YOMteSC6BJ6sIZdCAsMiYTUwLz5XXuVnu
         Yidv9HHtBmlq6nBcQt3kWOib+wY/PQwmXRiHOBKOxVplc/QyOcAXz/WpXBxtiXx81F0b
         x17al+4xMyiFoI9mOlJRONQp2OQJAwWaw+6JLs4gfjvvhei5SVxX4olmamPujJ/m0TmT
         vWBlXBtoUQEsKHyD4FUi/qKMIdIARPriqk7s8Q3cFyi6z7fpvYezpDJydDat3UTS+0sH
         bwv1k4FRFc+tzb+/go5g3VBWdkJxAq1jJ/fv4qjyvJH6DLK13fDP2gMh1qsoC8wcNzKp
         jPow==
X-Gm-Message-State: AJIora8h98TaQHA1ENyV4qi0Qd4wqjKQFwOUZyYrgu0d45OAqPHAwFYQ
        w/f4sViskhHn6Sp5/bKcVNhgll2Gjd62yX4YieY2vOEuWgeM442OLGO+6A9mTFEU4M37Aqf0OgK
        B7zLvwVrrbrto2fzPqzbamA==
X-Received: by 2002:a05:6000:15ca:b0:21b:baca:5902 with SMTP id y10-20020a05600015ca00b0021bbaca5902mr1980536wry.294.1656492534915;
        Wed, 29 Jun 2022 01:48:54 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sDScQ4cboO+70tDhLIpi7F39rbsDBsKr0xZWm7bwfHxKR2sNpG1kJOy2Gl8MEgXQMIl4Yrcw==
X-Received: by 2002:a05:6000:15ca:b0:21b:baca:5902 with SMTP id y10-20020a05600015ca00b0021bbaca5902mr1980515wry.294.1656492534684;
        Wed, 29 Jun 2022 01:48:54 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id c8-20020a7bc848000000b0039c457cea21sm2342924wml.34.2022.06.29.01.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 01:48:53 -0700 (PDT)
Date:   Wed, 29 Jun 2022 10:48:50 +0200
From:   Igor Mammedov <imammedo@redhat.com>
To:     Kai Huang <kai.huang@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kvm-devel <kvm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Len Brown <len.brown@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        isaku.yamahata@intel.com, Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v5 03/22] cc_platform: Add new attribute to prevent ACPI
 memory hotplug
Message-ID: <20220629104850.07559fee@redhat.com>
In-Reply-To: <ceb320a00eebd29d2031b94b6123ff31ba74c313.camel@intel.com>
References: <cover.1655894131.git.kai.huang@intel.com>
        <87dc19c47bad73509359c8e1e3a81d51d1681e4c.1655894131.git.kai.huang@intel.com>
        <CAJZ5v0jEJNdmkidvcOiRn+OVt01D5095t+nyXaJHKsqEAOvcBQ@mail.gmail.com>
        <20220628140112.661154cf@redhat.com>
        <ceb320a00eebd29d2031b94b6123ff31ba74c313.camel@intel.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 29 Jun 2022 11:49:14 +1200
Kai Huang <kai.huang@intel.com> wrote:

> On Tue, 2022-06-28 at 14:01 +0200, Igor Mammedov wrote:
> > On Wed, 22 Jun 2022 13:45:01 +0200
> > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> >   
> > > On Wed, Jun 22, 2022 at 1:16 PM Kai Huang <kai.huang@intel.com> wrote:  
> > > > 
> > > > Platforms with confidential computing technology may not support ACPI
> > > > memory hotplug when such technology is enabled by the BIOS.  Examples
> > > > include Intel platforms which support Intel Trust Domain Extensions
> > > > (TDX).
> > > > 
> > > > If the kernel ever receives ACPI memory hotplug event, it is likely a
> > > > BIOS bug.  For ACPI memory hot-add, the kernel should speak out this is
> > > > a BIOS bug and reject the new memory.  For hot-removal, for simplicity
> > > > just assume the kernel cannot continue to work normally, and just BUG().
> > > > 
> > > > Add a new attribute CC_ATTR_ACPI_MEMORY_HOTPLUG_DISABLED to indicate the
> > > > platform doesn't support ACPI memory hotplug, so that kernel can handle
> > > > ACPI memory hotplug events for such platform.
> > > > 
> > > > In acpi_memory_device_{add|remove}(), add early check against this
> > > > attribute and handle accordingly if it is set.
> > > > 
> > > > Signed-off-by: Kai Huang <kai.huang@intel.com>
> > > > ---
> > > >  drivers/acpi/acpi_memhotplug.c | 23 +++++++++++++++++++++++
> > > >  include/linux/cc_platform.h    | 10 ++++++++++
> > > >  2 files changed, 33 insertions(+)
> > > > 
> > > > diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
> > > > index 24f662d8bd39..94d6354ea453 100644
> > > > --- a/drivers/acpi/acpi_memhotplug.c
> > > > +++ b/drivers/acpi/acpi_memhotplug.c
> > > > @@ -15,6 +15,7 @@
> > > >  #include <linux/acpi.h>
> > > >  #include <linux/memory.h>
> > > >  #include <linux/memory_hotplug.h>
> > > > +#include <linux/cc_platform.h>
> > > > 
> > > >  #include "internal.h"
> > > > 
> > > > @@ -291,6 +292,17 @@ static int acpi_memory_device_add(struct acpi_device *device,
> > > >         if (!device)
> > > >                 return -EINVAL;
> > > > 
> > > > +       /*
> > > > +        * If the confidential computing platform doesn't support ACPI
> > > > +        * memory hotplug, the BIOS should never deliver such event to
> > > > +        * the kernel.  Report ACPI CPU hot-add as a BIOS bug and ignore
> > > > +        * the memory device.
> > > > +        */
> > > > +       if (cc_platform_has(c)) {    
> > > 
> > > Same comment as for the acpi_processor driver: this will affect the
> > > initialization too and it would be cleaner to reset the
> > > .hotplug.enabled flag of the scan handler.  
> > 
> > with QEMU, it is likely broken when memory is added as
> >   '-device pc-dimm'
> > on CLI since it's advertised only as device node in DSDT.
> > 
> >   
> 
> Hi Rafael,  Igor,
> 
> On my test machine, the acpi_memory_device_add() is not called for system
> memory.  It probably because my machine doesn't have memory device in ACPI.
> 
> I don't know whether we can have any memory device in ACPI if such memory is
> present during boot?  Any comments here?

I don't see anything in ACPI spec that forbids memory device being present at boot.
Such memory may also be present in E820, but in QEMU is not done as linux used to
online all E820 memory as normal which breaks hotplug. And I don't know if it
still true.

Also NVDIMMs also use memory device, so they may be affected by this patch as well.

> 
> And CC_ATTR_ACPI_MEMORY_HOTPLUG_DISABLED is only true on TDX bare-metal system,
> but cannot be true in Qemu guest.  But yes if this flag ever becomes true in

that's temporary, once TDX support lands in KVM/QEMU, this patch will silently
break usecase.

> guest, then I think we may have problem here.  I will do more study around ACPI.
> Thanks for comments!
> 

