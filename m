Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 876BD89928
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2019 11:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfHLJBc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 12 Aug 2019 05:01:32 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:27820 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727261AbfHLJBc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 12 Aug 2019 05:01:32 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-167-o1ho9AClPlujEPqzHyiv3g-1; Mon, 12 Aug 2019 10:01:29 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon,
 12 Aug 2019 10:01:28 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 12 Aug 2019 10:01:28 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Mika Westerberg' <mika.westerberg@linux.intel.com>
CC:     'Yehezkel Bernat' <yehezkelshb@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        "Anthony Wong" <anthony.wong@canonical.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH 3/8] thunderbolt: Use 32-bit writes when writing ring
 producer/consumer
Thread-Topic: [PATCH 3/8] thunderbolt: Use 32-bit writes when writing ring
 producer/consumer
Thread-Index: AQHVMyIznn3HI+p3CEuvWWeqi0Ulhqa8L0swgDPP6oCAABFywP//9NeAgAAR0ICAARElgIAGSXbA
Date:   Mon, 12 Aug 2019 09:01:28 +0000
Message-ID: <60b8b8d8ff14405bb86b9bd30addb94f@AcuMS.aculab.com>
References: <20190705095800.43534-1-mika.westerberg@linux.intel.com>
 <20190705095800.43534-4-mika.westerberg@linux.intel.com>
 <CA+CmpXtMBEtyh77fcrhX2BU8esiit56CWfZmey6LYEHZVUxf8A@mail.gmail.com>
 <0f3a47d8133945b181d623ea6e0d53f2@AcuMS.aculab.com>
 <20190807161359.GT2716@lahna.fi.intel.com>
 <79616dd147864771b0b74901e77f2607@AcuMS.aculab.com>
 <20190807163629.GV2716@lahna.fi.intel.com>
 <91a579eb2f614739a9a1177bdde5513e@AcuMS.aculab.com>
 <20190808095751.GA2716@lahna.fi.intel.com>
In-Reply-To: <20190808095751.GA2716@lahna.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: o1ho9AClPlujEPqzHyiv3g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: 'Mika Westerberg'
> Sent: 08 August 2019 10:58
> On Wed, Aug 07, 2019 at 04:41:30PM +0000, David Laight wrote:
> > From: 'Mika Westerberg' [mailto:mika.westerberg@linux.intel.com]
> > > Sent: 07 August 2019 17:36
> > >
> > > On Wed, Aug 07, 2019 at 04:22:26PM +0000, David Laight wrote:
> > > > From: Mika Westerberg
> > > > > Sent: 07 August 2019 17:14
> > > > > To: David Laight
> > > > >
> > > > > On Fri, Jul 05, 2019 at 04:04:19PM +0000, David Laight wrote:
> > > > > > > Really a matter of taste, but maybe you want to consider having a single
> > > > > > > function, with a 3rd parameter, bool is_tx.
> > > > > > > The calls here will be unified to:
> > > > > > >         ring_iowrite(ring, ring->head, ring->is_tx);
> > > > > > > (No condition is needed here).
> > > > > > >
> > > > > > > The implementation uses the new parameter to decide which part of the register
> > > > > > > to mask, reducing the code duplication (in my eyes):
> > > > > > >
> > > > > > >         val = ioread32(ring_desc_base(ring) + 8);
> > > > > > >         if (is_tx) {
> > > > > > >                 val &= 0x0000ffff;
> > > > > > >                 val |= value << 16;
> > > > > > >         } else {
> > > > > > >                 val &= 0xffff0000;
> > > > > > >                 val |= value;
> > > > > > >         }
> > > > > > >         iowrite32(val, ring_desc_base(ring) + 8);
> > > > > > >
> > > > > > > I'm not sure if it improves the readability or makes it worse. Your call.
> > > > > >
> > > > > > Gah, that is all horrid beyond belief.
> > > > > > If a 32bit write is valid then the hardware must not be updating
> > > > > > the other 16 bits.
> > > > > > In which case the driver knows what they should be.
> > > > > > So it can do a single 32bit write of the required value.
> > > > >
> > > > > I'm not entirely sure I understand what you say above. Can you shed some
> > > > > light on this by a concrete example how it should look like? :-)
> > > >
> > > > The driver must know both the tx and rx ring values, so:
> > > > 	iowrite32(tx_val << 16 | rx_val, ring_desc_base(ring) + 8);
> > > >
> > >
> > > I see. However, prod or cons side gets updated by the hardware as it
> > > processes buffers and other side is only updated by the driver. I'm not
> > > sure the above works here.
> >
> > If the hardware updates the other half of the 32bit word it doesn't ever work.
> >
> > In that case you must do 16bit writes.
> > If the hardware is ignoring the byte-enables it is broken and unusable.
> 
> It is quite usable as I'm running this code on real hardware ;-) but
> 32-bit access is needed.
> 
> The low or high 16-bits are read-only depending on the ring (Tx or Rx)
> and updated by the hardware. It ignores writes to that part so we could
> do this for Tx ring:
> 
> 	iowrite32(prod << 16, ring_desc_base(ring) + 8);
> 
> and this for Rx ring:
> 
> 	iowrite32(cons, ring_desc_base(ring) + 8);
> 
> Do you see any issues with this?

No, just comment that the hardware ignores the write to the other bytes.

You probably want separate functions - to remove the mispredicted branch.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

