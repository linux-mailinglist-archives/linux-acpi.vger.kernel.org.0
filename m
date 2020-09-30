Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 653CD27ED77
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Sep 2020 17:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725372AbgI3PjS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Wed, 30 Sep 2020 11:39:18 -0400
Received: from smtp.asem.it ([151.1.184.197]:50479 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbgI3PjS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 30 Sep 2020 11:39:18 -0400
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 6.5.2)
        with ESMTP id SG000515311.MSG 
        for <linux-acpi@vger.kernel.org>; Wed, 30 Sep 2020 17:39:15 +0200S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 30
 Sep 2020 17:39:13 +0200
Received: from ASAS044.asem.intra ([::1]) by ASAS044.asem.intra ([::1]) with
 mapi id 15.01.1979.003; Wed, 30 Sep 2020 17:39:13 +0200
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Bartosz Golaszewski <brgl@bgdev.pl>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: How to use an ACPI declared GPIO in a userspace ...
Thread-Topic: How to use an ACPI declared GPIO in a userspace ...
Thread-Index: AdaWdniTedAZ6+9wQdyYYgE5sQ27yP//4UoAgAAGTYD//91o0IAAJ14A//6Yg1CAAsA0gP//s0vA
Date:   Wed, 30 Sep 2020 15:39:13 +0000
Message-ID: <2c26adae711145639d0b982a354aff3c@asem.it>
References: <9152bb8be33e4192a7766eb53c6ca9af@asem.it>
 <CAMRc=McnsSkg-7UMp7pKaGX2wSqsZC2jQZV2zRepxm9UxGg=YA@mail.gmail.com>
 <CAHp75VfgEGydXN1A+Y=wn3iX1MbLhN8F9kYyfQwTZBJydr+0+Q@mail.gmail.com>
 <feb8567c830748c483c8c66dd4717003@asem.it>
 <CAHp75Vdd2QjvJvLGHa1x=RaSknEG+O+YB4eJA6+2htnZ=Gf52g@mail.gmail.com>
 <22753b53cd7d4dfba4ef3610f71cc462@asem.it>
 <20200930130113.GQ3956970@smile.fi.intel.com>
In-Reply-To: <20200930130113.GQ3956970@smile.fi.intel.com>
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
X-SGOP-RefID: str=0001.0A090210.5F74A6A2.001C,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

> I guess you simply didn't get. The "gpio-line-names" property of GPIO
> *controller* (provider!) and you are trying to do something with the
> *consumer*
> if I got it right.
> 
> And of course GPIO line, which has name, has no difference in use from
> another
> w/o name assigned. You will need to request it by *consumer* either in
> kernel
> or in user space.
> 
> To be more precise we have to look at your DSDT.
> 
> --
> With Best Regards,
> Andy Shevchenko
> 

My SSDT table is:

DefinitionBlock ("gpio_button.aml", "SSDT", 5, "ASEMsp", "GPIO_BTN", 1)
{
	External (_SB_.GPO1, DeviceObj)

	Scope (\_SB.GPO1)
	{
		Device (BTNS)
		{
			Name (_HID, "PRP0001")
			Name (_DDN, "GPIO buttons device")

			Name (_CRS, ResourceTemplate ()
			{
				GpioIo (
				Exclusive,               // Not shared
				PullNone,                // No need for pulls
				0,                       // Debounce timeout
				0,                       // Drive strength
				IoRestrictionInputOnly,  // Only used as input
				"\\_SB.GPO1",            // GPIO controller
				0, ResourceConsumer, , ) // Must be 0
				{
					1,              // GPIO number
				}
			})
	
			Name (_DSD, Package () {
				ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
				Package () {
					Package () {
						"gpio-line-names",
						Package () {
							"USER_PUSH_BUTTON",
						}
					},
				}
			})
		}
	}
}

And the kernel messages, after loading the table, are:

ACPI: Host-directed Dynamic ACPI Table Load:
ACPI: SSDT 0xFFFF908274285200 0000E8 (v05 ASEMsp GPIO_BTN 00000001 INTL 20200717)
ACPI: \_SB_.GPO1.BTNS: PRP0001 requires 'compatible' property

So I need a "consumer", but I don't want to export the GPIO using its number...
If you have any suggestion ...

Thanks!

Flavi

