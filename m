Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4B42B06FB
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Nov 2020 14:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgKLNuK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Thu, 12 Nov 2020 08:50:10 -0500
Received: from smtp.asem.it ([151.1.184.197]:52541 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728398AbgKLNuK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 12 Nov 2020 08:50:10 -0500
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 6.5.2)
        with ESMTP id SG000603503.MSG 
        for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2020 14:50:07 +0100S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 12
 Nov 2020 14:50:05 +0100
Received: from ASAS044.asem.intra ([::1]) by ASAS044.asem.intra ([::1]) with
 mapi id 15.01.1979.003; Thu, 12 Nov 2020 14:50:05 +0100
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4] Documentation: ACPI: explain how to use
 gpio-line-names
Thread-Topic: [PATCH v4] Documentation: ACPI: explain how to use
 gpio-line-names
Thread-Index: AQHWuPXuI/5ytptgx0ikZ9J5iah8/qnEcCQAgAATJfA=
Date:   Thu, 12 Nov 2020 13:50:05 +0000
Message-ID: <0ffeff9c510c40198ea0384a6d34323b@asem.it>
References: <20201112131545.62628-1-f.suligoi@asem.it>
 <20201112134042.GB4077@smile.fi.intel.com>
In-Reply-To: <20201112134042.GB4077@smile.fi.intel.com>
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
X-SGOP-RefID: str=0001.0A09020F.5FAD3D8E.00F9,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

HI Andy,

> On Thu, Nov 12, 2020 at 02:15:45PM +0100, Flavio Suligoi wrote:
> > The "gpio-line-names" declaration is not fully
> > documented, so can be useful to add some important
> > information and one more example.
> >
> > This commit also fixes a trivial spelling mistake.
> 
> For the future contributions:
> 
> No need to resend each time you got a tag. Maintainers usually take them
> all at
> once when applying (esp. taking into account plenty of scripts which help
> to do
> this automatically).

ok

> 
> Also, no need to resend so often. Give a chance to others to review
> (minimum
> resend time is 24h)

ok, right!

> 
> --
> With Best Regards,
> Andy Shevchenko
> 

Regards,
Flavio
