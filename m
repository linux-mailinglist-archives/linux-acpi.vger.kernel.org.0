Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9032D7580
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Oct 2019 13:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729532AbfJOLsU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Tue, 15 Oct 2019 07:48:20 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:29691 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729531AbfJOLsT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 15 Oct 2019 07:48:19 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-235-E9r2Iy20MAWay1Auj4hFhA-1; Tue, 15 Oct 2019 12:48:16 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 15 Oct 2019 12:48:16 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 15 Oct 2019 12:48:16 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Yin Fengwei' <fengwei.yin@intel.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] ACPI / processor_idle: use ndelay instead of io port
 access for wait
Thread-Topic: [PATCH v2] ACPI / processor_idle: use ndelay instead of io port
 access for wait
Thread-Index: AQHVgy8hI4gW7D6kAEmU4JIecWCIJ6dblHkg
Date:   Tue, 15 Oct 2019 11:48:15 +0000
Message-ID: <c9f3f4f93bb946f790fce4709253b359@AcuMS.aculab.com>
References: <20191015080404.6013-1-fengwei.yin@intel.com>
In-Reply-To: <20191015080404.6013-1-fengwei.yin@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: E9r2Iy20MAWay1Auj4hFhA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Yin Fengwei
> Sent: 15 October 2019 09:04
> In function acpi_idle_do_entry(), an ioport access is used for dummy
> wait to guarantee hardware behavior. But it could trigger unnecessary
> vmexit in virtualization environment.
> 
> If we run linux as guest and export all available native C state to
> guest, we did see many PM timer access triggered VMexit when guest
> enter deeper C state in our environment (We used ACRN hypervisor
> instead of kvm or xen which has PM timer emulated and exports all
> native C state to guest).
> 
> According to the original comments of this part of code, io port
> access is only for dummy wait. We could use busy wait instead of io
> port access to guarantee hardware behavior and avoid unnecessary
> VMexit.

You need some hard synchronisation instruction(s) after the inb()
and before any kind of delay to ensure your delay code is executed
after the inb() completes.

I'm pretty sure that inb() is only synchronised with memory reads.

...
> +	/* profiling the time used for dummy wait op */
> +	ktime_get_real_ts64(&ts0);
> +	inl(acpi_gbl_FADT.xpm_timer_block.address);
> +	ktime_get_real_ts64(&ts1);

That could be dominated by the cost of ktime_get_real_ts64().
It also need synchronising instructions.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

