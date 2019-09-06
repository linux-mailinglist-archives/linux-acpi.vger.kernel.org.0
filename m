Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB57AC0FC
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Sep 2019 21:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393611AbfIFTxv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 Sep 2019 15:53:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39280 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfIFTxv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Sep 2019 15:53:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ew6/0qVAdmZqdoKuB0ftq6YKxojcd2lW86roVTM6SN0=; b=HaDIZREUU4sYgn/JzFNf6E0OZ
        wUV/Zha1HrvFqpRxD1keIy+llfbiYbyO54VUM5f14UIi3JBAs86JzzzA99a3oqAbsCfWCa3j9D5Il
        Ul9csN2rC3lOfxHUkE3Nur3f17cxxoyo+NJZbmQO4IV/gC95JSVPhjhYrajx+qvRluFGsRuG3eKC+
        pMchkuAKJ3LpEIkBkmTDw/+ai08Rk50M18mwfnNfCYsLlXEEJ2sGNmfiC8w2cnmml6WGjhnENKE2b
        9y1CdcuQbB8qsi9RgytnVvp8W/fRwJ7e+YwUOwQi5K+8dKgAeN99bYl3lucqlkPTQ/g1iRzoJLnGQ
        MBaqbwQkA==;
Received: from [177.159.253.249] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i6KIn-0006S3-1u; Fri, 06 Sep 2019 19:53:49 +0000
Date:   Fri, 6 Sep 2019 16:53:41 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jessica Yu <jeyu@kernel.org>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-doc@vger.kernel.org, Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, Thomas Renninger <trenn@suse.com>,
        Shuah Khan <shuah@kernel.org>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org, linux-usb <linux-usb@vger.kernel.org>
Subject: Re: [RFC PATCH] tools: Add SPDX license to man pages
Message-ID: <20190906164959.288ab3d5@coco.lan>
In-Reply-To: <1b1cfc9c8c13b58c47d1d123763c8bc412abf9d4.camel@perches.com>
References: <20190905055614.7958918b@coco.lan>
        <88e638eb959095ab6657d295f9f8c27169569bf2.1567675272.git.mchehab+samsung@kernel.org>
        <20190905092703.GA30899@kroah.com>
        <20190905090701.37dcf75e@coco.lan>
        <b32c2e46b91e7bcda2a9bd140673f06d71b2487a.camel@perches.com>
        <20190906083457.7e7934ec@coco.lan>
        <1b1cfc9c8c13b58c47d1d123763c8bc412abf9d4.camel@perches.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Em Fri, 06 Sep 2019 11:12:58 -0700
Joe Perches <joe@perches.com> escreveu:

> On Fri, 2019-09-06 at 08:34 -0300, Mauro Carvalho Chehab wrote:
> > Warning: SPDX header for file tools/thermal/tmon/tmon.8 is at line 2  
> []
> > The last one is interesting... what's the "very first line" where a
> > SPDX header tag should be on a man page?  
> 
> just fyi:
> 
> It looks like .man pages could use a comment form
> using '.\"' like this example on the first line:
> 
> $ head -5 tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.8
> .\"  This page Copyright (C) 2010 - 2015 Len Brown <len.brown@intel.com>
> .\"  Distributed under the GPL, Copyleft 1994.
> .TH X86_ENERGY_PERF_POLICY 8
> .SH NAME
> x86_energy_perf_policy \- Manage Energy vs. Performance Policy via x86 Model Specific Registers
> 
> So maybe:
> ---
>  tools/power/acpi/man/acpidump.8                                 | 1 +
>  tools/power/cpupower/man/cpupower-frequency-info.1              | 1 +
>  tools/power/cpupower/man/cpupower-frequency-set.1               | 1 +
>  tools/power/cpupower/man/cpupower-idle-info.1                   | 1 +
>  tools/power/cpupower/man/cpupower-idle-set.1                    | 1 +
>  tools/power/cpupower/man/cpupower-info.1                        | 1 +
>  tools/power/cpupower/man/cpupower-monitor.1                     | 1 +
>  tools/power/cpupower/man/cpupower-set.1                         | 1 +
>  tools/power/cpupower/man/cpupower.1                             | 1 +
>  tools/power/pm-graph/bootgraph.8                                | 1 +
>  tools/power/pm-graph/sleepgraph.8                               | 1 +
>  tools/power/x86/turbostat/turbostat.8                           | 1 +
>  tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.8 | 1 +
>  tools/thermal/tmon/tmon.8                                       | 1 +
>  tools/usb/usbip/doc/usbip.8                                     | 1 +
>  tools/usb/usbip/doc/usbipd.8                                    | 1 +
>  16 files changed, 16 insertions(+)

Makes sense. I would also patch license-rules.txt with something like:

diff --git a/Documentation/process/license-rules.rst b/Documentation/process/license-rules.rst
index 5d23e3498b1c..6224421ee120 100644
--- a/Documentation/process/license-rules.rst
+++ b/Documentation/process/license-rules.rst
@@ -76,12 +76,13 @@ License identifier syntax
    The SPDX license identifier is added in form of a comment.  The comment
    style depends on the file type::
 
-      C source:	// SPDX-License-Identifier: <SPDX License Expression>
-      C header:	/* SPDX-License-Identifier: <SPDX License Expression> */
-      ASM:	/* SPDX-License-Identifier: <SPDX License Expression> */
-      scripts:	# SPDX-License-Identifier: <SPDX License Expression>
-      .rst:	.. SPDX-License-Identifier: <SPDX License Expression>
-      .dts{i}:	// SPDX-License-Identifier: <SPDX License Expression>
+      C source:  // SPDX-License-Identifier: <SPDX License Expression>
+      C header:  /* SPDX-License-Identifier: <SPDX License Expression> */
+      ASM:       /* SPDX-License-Identifier: <SPDX License Expression> */
+      scripts:   # SPDX-License-Identifier: <SPDX License Expression>
+      .rst:      .. SPDX-License-Identifier: <SPDX License Expression>
+      .dts{i}:	  // SPDX-License-Identifier: <SPDX License Expression>
+      man pages: .\" SPDX-License-Identifier: <SPDX License Expression>
 
    If a specific tool cannot handle the standard comment style, then the
    appropriate comment mechanism which the tool accepts shall be used. This

> diff --git a/tools/thermal/tmon/tmon.8 b/tools/thermal/tmon/tmon.8
> index 2f122de5841b..cffaa0d65478 100644
> --- a/tools/thermal/tmon/tmon.8
> +++ b/tools/thermal/tmon/tmon.8
> @@ -1,3 +1,4 @@
> +.\" SPDX-License-Identifier: GPL-2.0-only
>  .TH TMON 8
>  # SPDX-License-Identifier: GPL-2.0
>  .SH NAME

Hmm... here, you should probably keep the same license as defined at
the existing tag (GPL-2.0) and remove the comment one.


Thanks,
Mauro
