Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA8C37A48D
	for <lists+linux-acpi@lfdr.de>; Tue, 11 May 2021 12:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbhEKK1e convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Tue, 11 May 2021 06:27:34 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:35820 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbhEKK11 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 11 May 2021 06:27:27 -0400
Received: by mail-oi1-f175.google.com with SMTP id v22so13699036oic.2;
        Tue, 11 May 2021 03:26:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Y/kVtDHIZKmMSzJqt2osYUZoKGVA0ReHyak/rU5cC5c=;
        b=l+eBKx4VeyxVFcH6iRvG5yk3jceUS7TdXOOG88xabbPjT2uEKUzbmmJiYTBvM6Ly2B
         /J/qnW38qtl/HbnAQzBJsu6asXITnJpPohtoOreZvtLLQO7QQk/WpeLhJLGjsfq5bqhj
         XJ6sygWbTBBKlK3v0tyPZIPjqaQ6OkSCdPpTuFMpqZDgpeGr7RlGmFzk3Q4fd+LhvozO
         g26bDbDXE6i1VWv5AxOnqS0J1KoE81DQMLHj+0vqI4ZjcmialHespJNIcdzu7m0c1HuX
         QzeVR3xRrnGJGr8Mg0dqTpQUct0t/sZY+p3pksk1m/BUq/T05TrrQWq0dGA1FOKEp9oa
         SSqg==
X-Gm-Message-State: AOAM532eO28pqsMIQBF0nRXTn/Eoyg8ZmJRk7WVGCKoGHMCCAQFnY834
        V+HAZiVknMrUIZkS/kkkwrFC4psmFldTblXL6zM=
X-Google-Smtp-Source: ABdhPJyVc1Adj8xVyObdprPl2+PqCJObB0MAM6XfJz4JAIipmyLDXri3ba7YmDZvSK16PM6BYf++7Uytfb6IowgGI1w=
X-Received: by 2002:a05:6808:90d:: with SMTP id w13mr6920337oih.71.1620728781037;
 Tue, 11 May 2021 03:26:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210422192937.707500-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAJZ5v0hbAaFtRxuyR2B6YBUfV6eGWmDrZnTisd9j5H0UNurqrg@mail.gmail.com> <MWHPR11MB1599AD69C50EE40EF625C837F0539@MWHPR11MB1599.namprd11.prod.outlook.com>
In-Reply-To: <MWHPR11MB1599AD69C50EE40EF625C837F0539@MWHPR11MB1599.namprd11.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 11 May 2021 12:26:10 +0200
Message-ID: <CAJZ5v0jFhX6Jy_Ws14BO3g35yCKnKncp5gBWCADTCdppbHQ55A@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPICA: Add SVKL table headers
To:     "Kaneda, Erik" <erik.kaneda@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Rafael J Wysocki <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "Moore, Robert" <robert.moore@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, May 11, 2021 at 2:17 AM Kaneda, Erik <erik.kaneda@intel.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Rafael J. Wysocki <rafael@kernel.org>
> > Sent: Monday, May 10, 2021 9:58 AM
> > To: Kuppuswamy Sathyanarayanan
> > <sathyanarayanan.kuppuswamy@linux.intel.com>; Kaneda, Erik
> > <erik.kaneda@intel.com>
> > Cc: Rafael J Wysocki <rjw@rjwysocki.net>; Len Brown <lenb@kernel.org>;
> > Moore, Robert <robert.moore@intel.com>; ACPI Devel Maling List <linux-
> > acpi@vger.kernel.org>; open list:ACPI COMPONENT ARCHITECTURE
> > (ACPICA) <devel@acpica.org>; Linux Kernel Mailing List <linux-
> > kernel@vger.kernel.org>; Wysocki, Rafael J <rafael.j.wysocki@intel.com>
> > Subject: Re: [PATCH 1/1] ACPICA: Add SVKL table headers
> >
> > On Thu, Apr 22, 2021 at 9:29 PM Kuppuswamy Sathyanarayanan
> > <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> > >
> > > ACPICA commit b5e6bcf69dbb9877481992d5ce86008cfb94f5b8
> > >
> > > SVKL (Storage Volume Key Location Table) is used by BIOS/Firmware
> > > to share storage volume encryption key's with OS. It will be used
> > > by userspace to decrypt and mount encrypted drives.
> > >
> > > So add SVKL table signature and add it to known signatures array
> > > support SVKL.
> > >
> > > You can find details about the SVKL table in TDX specfication
> > > titled "Guest-Host-Communication Interface (GHCI) for Intel
> > > Trust Domain Extensions (Intel® TDX)", sec 4.4 and in ACPI
> > > specification r6.4, sec 5.2.6.
> > >
> > >
> > https://software.intel.com/content/dam/develop/external/us/en/documen
> > ts/intel-tdx-guest-hypervisor-communication-interface.pdf
> > >
> > > Cc: Robert Moore <robert.moore@intel.com>
> > > Cc: Erik Kaneda <erik.kaneda@intel.com>
> > > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > Link: https://github.com/acpica/acpica/commit/b5e6bcf6
> > > Signed-off-by: Kuppuswamy Sathyanarayanan
> > <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > Signed-off-by: Bob Moore <robert.moore@intel.com>
> > > Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
> >
> > Erik, what's the plan regarding this patch and the other ACPICA change
> > requisite for this series?
> >
> > Are they going to be part of the next ACPICA release and am I going to
> > receive them the usual way?
>
> Yes, we'll do this the usual way

OK, thanks!
