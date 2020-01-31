Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 374D614EB75
	for <lists+linux-acpi@lfdr.de>; Fri, 31 Jan 2020 12:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbgAaLHo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Fri, 31 Jan 2020 06:07:44 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:39615 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728353AbgAaLHo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 31 Jan 2020 06:07:44 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-73-VjcVhdg1N8ihqIuBpg4wFw-1; Fri, 31 Jan 2020 11:07:40 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 31 Jan 2020 11:07:40 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 31 Jan 2020 11:07:40 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
CC:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        David Box <david.e.box@linux.intel.com>,
        "Artem Bityutskiy" <artem.bityutskiy@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: RE: [PATCH 2/2] intel_idle: Introduce 'states_off' module parameter
Thread-Topic: [PATCH 2/2] intel_idle: Introduce 'states_off' module parameter
Thread-Index: AQHV13w6Eg2UWHP5m0aqtl9kDKUdz6gEmmHQ
Date:   Fri, 31 Jan 2020 11:07:39 +0000
Message-ID: <86fb1cd10e344f76a3e96c4b6c722680@AcuMS.aculab.com>
References: <1720216.0Jr2BLnqKp@kreacher> <16995896.bQtfYxEEOs@kreacher>
In-Reply-To: <16995896.bQtfYxEEOs@kreacher>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: VjcVhdg1N8ihqIuBpg4wFw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki
> Sent: 30 January 2020 14:47
> 
> In certain system configurations it may not be desirable to use some
> C-states assumed to be available by intel_idle and the driver needs
> to be prevented from using them even before the cpuidle sysfs
> interface becomes accessible to user space.  Currently, the only way
> to achieve that is by setting the 'max_cstate' module parameter to a
> value lower than the index of the shallowest of the C-states in
> question, but that may be overly intrusive, because it effectively
> makes all of the idle states deeper than the 'max_cstate' one go
> away (and the C-state to avoid may be in the middle of the range
> normally regarded as available).
> 
> To allow that limitation to be overcome, introduce a new module
> parameter called 'states_off' to represent a list of idle states to
> be disabled by default in the form of a bitmask and update the
> documentation to cover it.

The problem I see is that there are (at least) 3 different ways of
referring to the C-States:

1) The state names, C1, C1E, C3, C7 etc.
   I'm not sure these are visible outside intel_idle.c.
2) The maximum allowed latency in us.
3) The index into the cpu-dependant tables in intel_idle.c.

Boot parameters that set 3 are completely hopeless for normal
users. The C-state names might be - but they aren't documented.

Unless you know exactly which cpu table is being used the
only constraint a user can request is the latency.

(I've had the misfortune to read intel_idle.c in the last week.
Almost impenetrable TLA ridden uncommented code.)

...
> + * The positions of the bits that are set in the two's complement representation
> + * of this value are the indices of the idle states to be disabled by default
> + * (as reflected by the names of the corresponding idle state directories in
> + * sysfs, "state0", "state1" ... "state<i>" ..., where <i> is the index of the
> + * given state).

What has 'two's complement' got to do with anything?

...
> +The value of the ``states_off`` module parameter (0 by default) represents a
> +list of idle states to be disabled by default in the form of a bitmask.  Namely,
> +the positions of the bits that are set in the two's complement representation of
> +that value are the indices of idle states to be disabled by default (as
> +reflected by the names of the corresponding idle state directories in ``sysfs``,
> +:file:`state0`, :file:`state1` ... :file:`state<i>` ..., where ``<i>`` is the
> +index of the given idle state; see :ref:`idle-states-representation` in
> +:doc:`cpuidle`).  For example, if ``states_off`` is equal to 3, the driver will
> +disable idle states 0 and 1 by default, and if it is equal to 8, idle state 3
> +will be disabled by default and so on (bit positions beyond the maximum idle
> +state index are ignored).  The idle states disabled this way can be enabled (on
> +a per-CPU basis) from user space via ``sysfs``.

A few line breaks would make that easier to read.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

