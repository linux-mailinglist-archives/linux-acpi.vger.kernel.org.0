Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0421E2BAEE9
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Nov 2020 16:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbgKTP0R convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Fri, 20 Nov 2020 10:26:17 -0500
Received: from smtp.asem.it ([151.1.184.197]:55711 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728608AbgKTP0Q (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 20 Nov 2020 10:26:16 -0500
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 6.5.2)
        with ESMTP id SG000621942.MSG 
        for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2020 16:26:14 +0100
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 20
 Nov 2020 16:26:13 +0100
Received: from ASAS044.asem.intra ([::1]) by ASAS044.asem.intra ([::1]) with
 mapi id 15.01.1979.003; Fri, 20 Nov 2020 16:26:13 +0100
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] docs: ACPI: enumeration: add PCI hierarchy
 representation
Thread-Topic: [PATCH v2] docs: ACPI: enumeration: add PCI hierarchy
 representation
Thread-Index: AQHWvy3o1QjrgEUP4UmaOryOTfF696nRDJQAgAAXbqA=
Date:   Fri, 20 Nov 2020 15:26:13 +0000
Message-ID: <d51ce85e8c474242a939e13f81c1a5a1@asem.it>
References: <20201120111125.78296-1-f.suligoi@asem.it>
 <20201120150014.GS4077@smile.fi.intel.com>
In-Reply-To: <20201120150014.GS4077@smile.fi.intel.com>
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
X-SGOP-RefID: str=0001.0A090201.5FB7E016.001F,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

> > This patch, with a practical example, show how to do this.
> 
> Good enough, we can amend style and formatting later on.
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 

Thanks!

> > Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> > ---
> 
> (Here you usually put a changelog what has been done in v2 vs. v1))

Yes, you are right! I forgot it!

> 
> --
> With Best Regards,
> Andy Shevchenko
> 

Regards,
Flavio
