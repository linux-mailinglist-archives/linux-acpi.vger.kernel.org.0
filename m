Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34E2515F79C
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Feb 2020 21:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbgBNUVt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Fri, 14 Feb 2020 15:21:49 -0500
Received: from mga02.intel.com ([134.134.136.20]:31163 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728529AbgBNUVt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 Feb 2020 15:21:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 12:21:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,441,1574150400"; 
   d="scan'208";a="223127865"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by orsmga007.jf.intel.com with ESMTP; 14 Feb 2020 12:21:48 -0800
Received: from orsmsx110.amr.corp.intel.com ([169.254.10.107]) by
 ORSMSX107.amr.corp.intel.com ([169.254.1.106]) with mapi id 14.03.0439.000;
 Fri, 14 Feb 2020 12:21:48 -0800
From:   "Moore, Robert" <robert.moore@intel.com>
To:     "Kaneda, Erik" <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] ACPICA: Fix a typo in acuuid.h
Thread-Topic: [PATCH] ACPICA: Fix a typo in acuuid.h
Thread-Index: AQHV4wBMHiM0+joAK0665+NbOcZNwKga+7yAgAB29oD//6/2AA==
Date:   Fri, 14 Feb 2020 20:21:48 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B96EA166@ORSMSX110.amr.corp.intel.com>
References: <20200214063003.29741-1-christophe.jaillet@wanadoo.fr>
 <2712088.SaWAGPlJqS@kreacher>
 <BL0PR11MB29466C25466F5A88B4D4F5B9F0150@BL0PR11MB2946.namprd11.prod.outlook.com>
In-Reply-To: <BL0PR11MB29466C25466F5A88B4D4F5B9F0150@BL0PR11MB2946.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiM2ZkMjYzOTktMmRlOS00ZGYyLWFkMTEtNTlmMzc4ZTBhYjVlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiOCsxbldrMEtsbkZCS2N6c2o4dXpvQ2ZWYXBERkdvb3hzTFRjeFwvdERKK1lnZjNESmZcLzNoZ29ObUt4emhYK0hQIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Ok, got it.
Thanks,
Bob
-

-----Original Message-----
From: Kaneda, Erik <erik.kaneda@intel.com> 
Sent: Friday, February 14, 2020 9:08 AM
To: Rafael J. Wysocki <rjw@rjwysocki.net>; Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: lenb@kernel.org; Moore, Robert <robert.moore@intel.com>; linux-acpi@vger.kernel.org; devel@acpica.org; linux-kernel@vger.kernel.org; kernel-janitors@vger.kernel.org
Subject: RE: [PATCH] ACPICA: Fix a typo in acuuid.h



> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org <linux-acpi- 
> owner@vger.kernel.org> On Behalf Of Rafael J. Wysocki
> Sent: Friday, February 14, 2020 2:02 AM
> To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>; Kaneda, Erik 
> <erik.kaneda@intel.com>
> Cc: lenb@kernel.org; Moore, Robert <robert.moore@intel.com>; linux- 
> acpi@vger.kernel.org; devel@acpica.org; linux-kernel@vger.kernel.org; 
> kernel-janitors@vger.kernel.org
> Subject: Re: [PATCH] ACPICA: Fix a typo in acuuid.h
> 
> On Friday, February 14, 2020 7:30:03 AM CET Christophe JAILLET wrote:
> > The comment related to the ending of the include guard should be 
> > related to __ACUUID_H__, not __AUUID_H__ (i.e. 'C' is missing).
> >
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> Erik, please route this through the upstream.

Thanks for your patch!

I'll add it to our next release (in March)

Erik
> 
> Thanks!
> 
> > ---
> >  include/acpi/acuuid.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/acpi/acuuid.h b/include/acpi/acuuid.h index
> > 9dd4689a39cf..9e1367b19069 100644
> > --- a/include/acpi/acuuid.h
> > +++ b/include/acpi/acuuid.h
> > @@ -57,4 +57,4 @@
> >  #define UUID_THERMAL_EXTENSIONS         "14d399cd-7a27-4b18-8fb4-
> 7cb7b9f4e500"
> >  #define UUID_DEVICE_PROPERTIES          "daffd814-6eba-4d8c-8a91-
> bc9bbf4aa301"
> >
> > -#endif/* __AUUID_H__ */
> > +#endif/* __ACUUID_H__ */
> >
> 
> 
> 


