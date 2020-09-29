Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D5827D2F7
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Sep 2020 17:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbgI2Pmz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Tue, 29 Sep 2020 11:42:55 -0400
Received: from smtp.asem.it ([151.1.184.197]:53979 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728241AbgI2Pmz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 29 Sep 2020 11:42:55 -0400
X-Greylist: delayed 305 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Sep 2020 11:42:54 EDT
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 6.5.2)
        with ESMTP id SG000512543.MSG 
        for <linux-acpi@vger.kernel.org>; Tue, 29 Sep 2020 17:37:47 +0200S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 29
 Sep 2020 17:37:46 +0200
Received: from ASAS044.asem.intra ([::1]) by ASAS044.asem.intra ([::1]) with
 mapi id 15.01.1979.003; Tue, 29 Sep 2020 17:37:46 +0200
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: How to use an ACPI declared GPIO in a userspace ...
Thread-Topic: How to use an ACPI declared GPIO in a userspace ...
Thread-Index: AdaWdniTedAZ6+9wQdyYYgE5sQ27yA==
Date:   Tue, 29 Sep 2020 15:37:46 +0000
Message-ID: <9152bb8be33e4192a7766eb53c6ca9af@asem.it>
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
X-SGOP-RefID: str=0001.0A09020D.5F7354CB.0052,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi all,

I need to expose to the userspace a GPIO, physically connected to a board
push-button. This GPIO must expose a pre-defined name, such as
"user-push-button", so that the userspace applications can use it without
know any physical GPIO details.

I can customize the board BIOS and so my goal is to add an ACPI table with
a content like this:

...
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
					25,              // GPIO number
				}
...

I know that this GPIO can be used from other drivers.
For example I successfully tested it using the "gpio-keys" device driver,
giving to my GPIO a key-code and emulating in this way a keyboard key.
This could be a possible solution.

But I prefer to expose my GPIO as a classic GPIO, not as a keyboard key.

I was wondering if there is a generic GPIO driver that I can use to expose
this GPIO with its pre-defined name (caming from the ACPI table declaration),
to the userspace...

Best regards,

Flavio
