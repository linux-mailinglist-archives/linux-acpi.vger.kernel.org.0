Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52272AB519
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Nov 2020 11:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgKIKfr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 9 Nov 2020 05:35:47 -0500
Received: from smtp.asem.it ([151.1.184.197]:57914 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbgKIKfr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 9 Nov 2020 05:35:47 -0500
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 6.5.2)
        with ESMTP id SG000594087.MSG 
        for <linux-acpi@vger.kernel.org>; Mon, 09 Nov 2020 11:35:45 +0100S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 9 Nov
 2020 11:35:44 +0100
Received: from ASAS044.asem.intra ([::1]) by ASAS044.asem.intra ([::1]) with
 mapi id 15.01.1979.003; Mon, 9 Nov 2020 11:35:44 +0100
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: RE: How to add the "gpio-line-names" property in a PCI gpio expander
Thread-Topic: How to add the "gpio-line-names" property in a PCI gpio expander
Thread-Index: AdazWEAUpTjocun1TNeP3lXLN/Ph2wACVbgAAABK9IAABkeZAAAAulsAAALtYfAAHgxtAAAWS8WA///44YD/+8QuMIAIgj0A///vI2A=
Date:   Mon, 9 Nov 2020 10:35:43 +0000
Message-ID: <20306488dbf545d4bec94f52d1c5e332@asem.it>
References: <98acf6339a1b43d6a38f867069088530@asem.it>
 <CAJZ5v0g7POp1Lp05RcJJ8ZD1ZiaetN0_SfbAjnQg0kCw4aQukQ@mail.gmail.com>
 <20201105115941.GK2495@lahna.fi.intel.com>
 <574b86929d1247caae717ab1a2f31194@asem.it>
 <20201105152020.GO2495@lahna.fi.intel.com>
 <5fb64f9c8af64235943c29c9ba50a2df@asem.it>
 <20201106070432.GQ2495@lahna.fi.intel.com>
 <c20e82318bbf426c9d9000cac7e7734b@asem.it>
 <20201106171727.GK4077@smile.fi.intel.com>
 <dfeb12b6c53a49a2afc8cf381b066999@asem.it>
 <20201109103432.GU4077@smile.fi.intel.com>
In-Reply-To: <20201109103432.GU4077@smile.fi.intel.com>
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
X-SGOP-RefID: str=0001.0A09020C.5FA91B80.0067,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

> > Ok, I'll see how to integrate my PCI "investigation" about the
> > identification of the correct path from the CPU to the final PCI
> > device, through the various bridges of the board.
> > I think that a general discourse about it can be useful to
> > other people, too.
> 
> I realized that here we have two items to document:
> 1) the gpio-line-names property in [1];
> 2) PCI hierarchy in ACPI tables, which can be added into [3] under
>    the "PCI hierarchy representation" title or so.
> 
> [3]: Documentation/firmware-guide/acpi/enumeration.rst

OK, thanks for your guidelines!

> 
> --
> With Best Regards,
> Andy Shevchenko
> 

Regards,

Flavio
