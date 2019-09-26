Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A54BBF720
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2019 18:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfIZQvD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Thu, 26 Sep 2019 12:51:03 -0400
Received: from mga09.intel.com ([134.134.136.24]:46443 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfIZQvD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 26 Sep 2019 12:51:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2019 09:51:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,552,1559545200"; 
   d="scan'208";a="219466843"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by fmsmga002.fm.intel.com with ESMTP; 26 Sep 2019 09:51:01 -0700
Received: from orsmsx154.amr.corp.intel.com (10.22.226.12) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 26 Sep 2019 09:51:00 -0700
Received: from orsmsx122.amr.corp.intel.com ([169.254.11.236]) by
 ORSMSX154.amr.corp.intel.com ([169.254.11.180]) with mapi id 14.03.0439.000;
 Thu, 26 Sep 2019 09:51:00 -0700
From:   "Schmauss, Erik" <erik.schmauss@intel.com>
To:     "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
CC:     Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Moore, Robert" <robert.moore@intel.com>,
        Len Brown <lenb@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        "Pavel Machek" <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nv@vosn.de" <nv@vosn.de>
Subject: RE: [PATCH] ACPICA: make acpi_load_table() return table index
Thread-Topic: [PATCH] ACPICA: make acpi_load_table() return table index
Thread-Index: AQHVaUE6PwWyj3qAlUyiJ16YhgOwE6c+NeMQgAB9wgD//42XEA==
Date:   Thu, 26 Sep 2019 16:51:00 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED53C6481F2@ORSMSX122.amr.corp.intel.com>
References: <20190906174605.GY2680@smile.fi.intel.com>
 <20190912080742.24642-1-nikolaus.voss@loewensteinmedical.de>
 <CF6A88132359CE47947DB4C6E1709ED53C6481B1@ORSMSX122.amr.corp.intel.com>
 <20190926163528.GH32742@smile.fi.intel.com>
In-Reply-To: <20190926163528.GH32742@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYTczMTQ5Y2QtNTJkOC00MjdkLTg3OWYtOWRmZjQzNDlmN2M1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVzNISmZaM3VHTmFkQ1l0b01LMzNHQVhkNVVXZFJYN3hTcFN2OE1lNnRtTXZCOFwvQWlITXhGOVhuREJyZ0g0WlYifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org <linux-acpi-owner@vger.kernel.org>
> On Behalf Of Shevchenko, Andriy
> Sent: Thursday, September 26, 2019 9:35 AM
> To: Schmauss, Erik <erik.schmauss@intel.com>
> Cc: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>; Rafael J. Wysocki
> <rjw@rjwysocki.net>; Moore, Robert <robert.moore@intel.com>; Len Brown
> <lenb@kernel.org>; Jacek Anaszewski <jacek.anaszewski@gmail.com>; Pavel
> Machek <pavel@ucw.cz>; Dan Murphy <dmurphy@ti.com>; linux-
> acpi@vger.kernel.org; devel@acpica.org; linux-kernel@vger.kernel.org;
> nv@vosn.de
> Subject: Re: [PATCH] ACPICA: make acpi_load_table() return table index
> 
> On Thu, Sep 26, 2019 at 07:09:05PM +0300, Schmauss, Erik wrote:
> > > -----Original Message-----
> > > From: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
> > > Sent: Thursday, September 12, 2019 1:08 AM
> > > To: Shevchenko, Andriy <andriy.shevchenko@intel.com>; Schmauss, Erik
> > > <erik.schmauss@intel.com>; Rafael J. Wysocki <rjw@rjwysocki.net>;
> > > Moore, Robert <robert.moore@intel.com>
> > > Cc: Len Brown <lenb@kernel.org>; Jacek Anaszewski
> > > <jacek.anaszewski@gmail.com>; Pavel Machek <pavel@ucw.cz>; Dan
> > > Murphy <dmurphy@ti.com>; linux-acpi@vger.kernel.org;
> > > devel@acpica.org; linux- kernel@vger.kernel.org; nv@vosn.de;
> > > Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
> > > Subject: [PATCH] ACPICA: make acpi_load_table() return table index
> > >
> > Hi Nikolaus,
> >
> > > For unloading an ACPI table, it is necessary to provide the index of the table.
> > > The method intended for dynamically loading or hotplug addition of
> > > tables, acpi_load_table(), should provide this information via an
> > > optional pointer to the loaded table index.
> >
> > We'll take this patch for ACPICA upstream
> 
> Erik,
> 
Hi Andy,

> how about to have also counterpart to acpi_load_table() which will do what it's
> done now in acpi_configfs.c via acpi_tb_*() API?

I should have given more details. We decided to add this extra parameter in AcpiLoadTable and
we're going to create an AcpiUnloadTable function that will take table index to unload the table (basically the acpi_tb_unload..).
Once we do this, you can use table indices with AcpiUnloadTable and AcpiLoadTable.

Erik
> 
> Because it's kinda strange to call acpi_load_table*() and acpi_tb_*() in the
> same module.
> 
> --
> With Best Regards,
> Andy Shevchenko
> 

