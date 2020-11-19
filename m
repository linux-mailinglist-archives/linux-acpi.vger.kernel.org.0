Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 416672B9797
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Nov 2020 17:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgKSQRY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Thu, 19 Nov 2020 11:17:24 -0500
Received: from smtp.asem.it ([151.1.184.197]:50036 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbgKSQRX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 19 Nov 2020 11:17:23 -0500
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 6.5.2)
        with ESMTP id SG000619548.MSG 
        for <linux-acpi@vger.kernel.org>; Thu, 19 Nov 2020 17:17:21 +0100
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 19
 Nov 2020 17:17:20 +0100
Received: from ASAS044.asem.intra ([::1]) by ASAS044.asem.intra ([::1]) with
 mapi id 15.01.1979.003; Thu, 19 Nov 2020 17:17:20 +0100
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] docs: ACPI: enumeration: add PCI hierarchy
 representation
Thread-Topic: [PATCH v1] docs: ACPI: enumeration: add PCI hierarchy
 representation
Thread-Index: AQHWvlyAjXLlwduncU2KU0iBvT+xrKnPO2CAgABk9nA=
Date:   Thu, 19 Nov 2020 16:17:19 +0000
Message-ID: <9b5ab860bb77427892edbe443889a006@asem.it>
References: <20201119101233.701918-1-f.suligoi@asem.it>
 <20201119110921.GB4077@smile.fi.intel.com>
In-Reply-To: <20201119110921.GB4077@smile.fi.intel.com>
Accept-Language: it-IT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.17.208]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-SGHeloLookup-Result: pass smtp.helo=webmail.asem.it (ip=172.16.16.44)
X-SGSPF-Result: none (smtp.asem.it)
X-SGOP-RefID: str=0001.0A090214.5FB69A90.0068,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy!


> On Thu, Nov 19, 2020 at 11:12:33AM +0100, Flavio Suligoi wrote:
> 
> Thank you very much for nice piece of documentation!
> My comments below.

Thanks for your suggestions! I'll use them in the next version
of the patch!

> > +particular the DSDT (see also [2])::
> 
> > +	cd /sys/firmware/acpi
> > +	cp -a tables/ ~
> > +	cd ~/tables/
> 
> acpidump followed by acpixtract from ACPI tools is better to advertise.

Ok, I'll use acpixtract

> 
> > +	find . -type f -exec mv {} {}.aml \;
> 
> Unnecessary step. But I think you wanted to have it to distinguish sources
> and
> binaries in the text below.

Right, I think that is important include the SSDT tables for external
symbol resolution. For this reason I renamed the binary tables, to
use the following command:

> > +	iasl -e SSDT?.* -d DSDT.aml

> --
> With Best Regards,
> Andy Shevchenko
> 

Best regards,
Flavio
