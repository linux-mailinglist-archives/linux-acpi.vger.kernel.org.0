Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4495121FC0
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Dec 2019 01:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbfLQAbF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 16 Dec 2019 19:31:05 -0500
Received: from mga12.intel.com ([192.55.52.136]:39964 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726556AbfLQAbF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 16 Dec 2019 19:31:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Dec 2019 16:31:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,323,1571727600"; 
   d="scan'208";a="240223776"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga004.fm.intel.com with ESMTP; 16 Dec 2019 16:31:04 -0800
Received: from fmsmsx119.amr.corp.intel.com (10.18.124.207) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 16 Dec 2019 16:31:04 -0800
Received: from shsmsx154.ccr.corp.intel.com (10.239.6.54) by
 FMSMSX119.amr.corp.intel.com (10.18.124.207) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 16 Dec 2019 16:31:03 -0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.109]) by
 SHSMSX154.ccr.corp.intel.com ([169.254.7.71]) with mapi id 14.03.0439.000;
 Tue, 17 Dec 2019 08:31:02 +0800
From:   "Li, Philip" <philip.li@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>, lkp <lkp@intel.com>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: RE: [kbuild-all] Re: [pm:intel_idle+acpi 4/10]
 acpi_processor.c:undefined reference to `acpi_processor_ffh_cstate_probe'
Thread-Topic: [kbuild-all] Re: [pm:intel_idle+acpi 4/10]
 acpi_processor.c:undefined reference to `acpi_processor_ffh_cstate_probe'
Thread-Index: AQHVtBw7KA1SHmK+706KMnA2SFRqtKe9ehag
Date:   Tue, 17 Dec 2019 00:31:01 +0000
Message-ID: <831EE4E5E37DCC428EB295A351E66249522A215D@shsmsx102.ccr.corp.intel.com>
References: <201912162148.hTRbNfPp%lkp@intel.com>
 <CAJZ5v0iTOSnvZqKuL7gy7QBtdHxcM7wPS8qdgbvs6+sQxZX5yg@mail.gmail.com>
In-Reply-To: <CAJZ5v0iTOSnvZqKuL7gy7QBtdHxcM7wPS8qdgbvs6+sQxZX5yg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNzQzNjFiZmUtZGNiNy00N2IyLWFkMWItZTU3NzFlMTI4NGI0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoicXFkaHZwVmM3NUlTcnFnQmd1ekN1OG54YUEzcnlXQlZzRGt1MklzUHowVEdBN3h3SWFzdEJFQVNzcjhmVmRyVyJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

> Subject: [kbuild-all] Re: [pm:intel_idle+acpi 4/10] acpi_processor.c:undefined
> reference to `acpi_processor_ffh_cstate_probe'
> 
> On Mon, Dec 16, 2019 at 2:26 PM kbuild test robot <lkp@intel.com> wrote:
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
> intel_idle+acpi
> > head:   dcedc03145600b929a32acb85b212131b079bc46
> > commit: 0300cf31f061e6287810c894337f29df2e200e2d [4/10] ACPI: processor:
> Export acpi_processor_evaluate_cst()
> 
> Outdated.  Please stop sending these.
thanks for the input Rafael, we will ignore the following tests on it.

> 
> > config: x86_64-randconfig-b002-20191216 (attached as .config)
> > compiler: gcc-7 (Debian 7.5.0-1) 7.5.0
> > reproduce:
> >         git checkout 0300cf31f061e6287810c894337f29df2e200e2d
> >         # save the attached .config to linux build tree
> >         make ARCH=x86_64
> >
> > If you fix the issue, kindly add following tag
> > Reported-by: kbuild test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> >    ld: drivers/acpi/acpi_processor.o: in function `acpi_processor_evaluate_cst':
> > >> acpi_processor.c:(.text+0x542): undefined reference to
> `acpi_processor_ffh_cstate_probe'
> >
> > ---
> > 0-DAY kernel test infrastructure                 Open Source Technology Center
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
