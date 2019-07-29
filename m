Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD30778993
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Jul 2019 12:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbfG2KYc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 29 Jul 2019 06:24:32 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:40965 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728030AbfG2KYb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 29 Jul 2019 06:24:31 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-234-VJwiHrKHPaOBTCMo7rm5ew-1; Mon, 29 Jul 2019 11:24:28 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon,
 29 Jul 2019 11:24:27 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 29 Jul 2019 11:24:27 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Moore, Robert'" <robert.moore@intel.com>, Qian Cai <cai@lca.pw>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
CC:     "Schmauss, Erik" <erik.schmauss@intel.com>,
        "jkim@FreeBSD.org" <jkim@FreeBSD.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] acpica: fix -Wnull-pointer-arithmetic warnings
Thread-Topic: [PATCH v2] acpica: fix -Wnull-pointer-arithmetic warnings
Thread-Index: AQHVPaHylXmfzBauvEybJLDaugeeCqbdV0WAgAQb46A=
Date:   Mon, 29 Jul 2019 10:24:27 +0000
Message-ID: <c98fa373a004472b979255a93b414fe1@AcuMS.aculab.com>
References: <20190718194846.1880-1-cai@lca.pw>
 <94F2FBAB4432B54E8AACC7DFDE6C92E3B9661CBD@ORSMSX110.amr.corp.intel.com>
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E3B9661CBD@ORSMSX110.amr.corp.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: VJwiHrKHPaOBTCMo7rm5ew-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Moore, Robert
> Sent: 26 July 2019 20:36
...
> This is because pointer arithmetic
> on a pointer not pointing to an array is an undefined behavior (C11 6.5.6, constraint 8).
...

The standards committee as smoking dope again :-)
If that is enforced as a compiler warning/error a lot of code 'breaks'.
Anything that does:
	struct foo *foo = ...;
      struct bar *bar = (void *)(foo + 1);
suddenly becomes 'invalid'.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

