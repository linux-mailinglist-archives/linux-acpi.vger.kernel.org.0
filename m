Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4612A7AEF
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Nov 2020 10:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgKEJqH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Thu, 5 Nov 2020 04:46:07 -0500
Received: from smtp.asem.it ([151.1.184.197]:55014 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbgKEJqG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 5 Nov 2020 04:46:06 -0500
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 6.5.2)
        with ESMTP id SG000587625.MSG 
        for <linux-acpi@vger.kernel.org>; Thu, 05 Nov 2020 10:46:03 +0100S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 5 Nov
 2020 10:46:02 +0100
Received: from ASAS044.asem.intra ([::1]) by ASAS044.asem.intra ([::1]) with
 mapi id 15.01.1979.003; Thu, 5 Nov 2020 10:46:02 +0100
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: How to add the "gpio-line-names" property in a PCI gpio expander
Thread-Topic: How to add the "gpio-line-names" property in a PCI gpio expander
Thread-Index: AdazWEAUpTjocun1TNeP3lXLN/Ph2w==
Date:   Thu, 5 Nov 2020 09:46:02 +0000
Message-ID: <98acf6339a1b43d6a38f867069088530@asem.it>
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
X-SGOP-RefID: str=0001.0A090212.5FA3C9DA.007A,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi all,

I'm working to introduce the "gpio-line-names" property in the ACPI
configuration of the BIOS of our x86 boards (we can customize the BIOS of our
boards).

All is ok for the gpiochips related to the Intel chipset and some I2C gpio
expanders. I have inserted the _DSD as described in the Linux documentation.

In one of our boards we have an add-on PCI board, with a PCI serial device
Exar XR17V352. This device also contains 16 gpios.
The exar device drivers work good, both the "8250_exar" and the "gpio_exar", and
I can manage the exar's gpios correctly.
The problem is how to assign the gpio-line-names property to a PCI gpio
expanders like this.

I tried adding a new device in my ACPI configuration, as:

Device (EXAR)
{
    Name (_HID, "13A80352")
    Name (_STR, Unicode ("STR - Exar GPIOs"))  // _STR: Description String

    Name (_DSD, Package () {
	ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
	Package () {
	    Package () {
		"gpio-line-names",
		    Package () {
			"exar_0",
			"exar_1",
			"exar_2",
			"exar_3",
			...
		    }
		}
	    }
    })
}

but I have no result.
Does anyone have a suggestion?

Thanks,

Flavio
