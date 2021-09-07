Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18ABB402C0F
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Sep 2021 17:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345333AbhIGPnn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 Sep 2021 11:43:43 -0400
Received: from mga02.intel.com ([134.134.136.20]:21515 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235162AbhIGPnm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 7 Sep 2021 11:43:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10099"; a="207458040"
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="207458040"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2021 08:42:36 -0700
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="538028650"
Received: from chenyu-desktop.sh.intel.com (HELO chenyu-desktop) ([10.239.158.176])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2021 08:42:32 -0700
Date:   Tue, 7 Sep 2021 23:48:30 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-doc@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH 1/5][RFC] Documentation: Introduce Platform Firmware
 Runtime Update documentation
Message-ID: <20210907154830.GA44825@chenyu-desktop>
References: <cover.1631025237.git.yu.c.chen@intel.com>
 <c135a9bf742f3c2181650914f40ce563d7a3dc48.1631025237.git.yu.c.chen@intel.com>
 <87sfygtnna.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sfygtnna.fsf@meer.lwn.net>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Jon,
On Tue, Sep 07, 2021 at 09:23:53AM -0600, Jonathan Corbet wrote:
> Thanks for adding to the documentation.  I have a few nits for you...
> 
Thank you very much for your comments.
> Chen Yu <yu.c.chen@intel.com> writes:
> 
> > Add the Platform Firmware Runtime Update/Telemetry documentation.
> >
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> >  Documentation/x86/pfru.rst | 98 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 98 insertions(+)
> >  create mode 100644 Documentation/x86/pfru.rst
> 
> When you add a new RST file, you also need to find a spot for it in
> index.rst so it becomes part of the docs build.
> 
I see. Will do in next version.
> > diff --git a/Documentation/x86/pfru.rst b/Documentation/x86/pfru.rst
> > new file mode 100644
> > index 000000000000..321729f46737
> > --- /dev/null
> > +++ b/Documentation/x86/pfru.rst
> > @@ -0,0 +1,98 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +========================================================
> > +The Linux Platform Firmware Runtime Update and Telemetry
> > +========================================================
> > +
> > +According to the specification of <Management Mode Firmware Runtime Update>[1],
> > +certain computing systems require high Service Level Agreements (SLAs) where
> > +system reboot fewer firmware updates are required to deploy firmware changes
> > +to address bug fixes, security updates and to debug and root cause issues. This
> > +technology is called Intel Seamless Update. The management mode (MM),
> > +UEFI runtime services and ACPI services handle most of the system runtime
> > +functions. Changing the MM code execution during runtime is called MM Runtime
> > +Update. Since the "MM" acronyms might be misunderstood as "Memory Management",
> > +this driver uses "Platform Firmware Runtime Update"(PFRU)
> > +
> > +PFRU provides the following facilities: Performs a runtime firmware driver update
> > +and activate. Ability to inject firmware code at runtime, for dynamic instrumentation.
> > +PFRU Telemetry is a service which allows Runtime Update handler to produce telemetry
> > +data to upper layer OS consumer at runtime. The OS provides interfaces to let the
> > +users query the telemetry data via read operations. The specification specifies the
> > +interface and recommended policy to extract the data, the format and use are left to
> > +individual OEM's and BIOS implementations on what that data represents.
> 
> Sticking to the 80-column limit is preferable; it keeps the text
> readable. 
> 
Okay, will do.
> > +PFRU interfaces
> > +=====================
> 
> Underline lengths should match the title text, or Sphinx will get grumpy
> with you.
> 
Got it, will fix it.
> > +The user space tool manipulates on /dev/pfru/update for code injection and
> > +driver update. PFRU stands for Platform Firmware Runtime Update, and the /dev/pfru
> > +directory might be reserved for future usage.
> > +
> > + 1. mmap the capsule file
> > +    fd_capsule = open("capsule.cap", O_RDONLY);
> > +    fstat(fd_capsule, &stat);
> > +    addr = mmap(0, stat.st_size, PROT_READ, fd_capsule);
> 
> These will not render the way you would like; you'll want to use literal
> blocks for the code samples.
> 
Okay, I'll fix it.

thanks,
Chenyu
