Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6842241ABA
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Aug 2020 14:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgHKMAr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 Aug 2020 08:00:47 -0400
Received: from mout.gmx.net ([212.227.15.18]:59749 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728469AbgHKMAr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 11 Aug 2020 08:00:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597147125;
        bh=PiXz7T5Qow1zNWYr28KRUPG3sTkPX/Vka2nmt1UMH8E=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:References:Date:In-Reply-To;
        b=KeP3iUwmr12O3R3rgxFQMEFGvBCAs8/h0qlVEfZ0yOtaViP391cACdcr3zHtXC+HK
         Lt91Q7cE2AtDF+hhVqbdYNVsgAxlIbwR2AHiHXXUuYAECBvnFyLEyK1h98jzxMwHc0
         zaW8AhllshMk9odyQDurGXnk8zOcxujb8EsQrwjk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from strobe-jhalfs ([94.220.127.176]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MwQT9-1kxYun3QA9-00sN3z; Tue, 11
 Aug 2020 13:58:45 +0200
From:   Stephen Berman <stephen.berman@gmx.net>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>
Subject: Re: power-off delay/hang due to commit 6d25be57 (mainline)
References: <20200616073827.vysntufld3ves666@linutronix.de>
        <87o8pjh1i0.fsf@gmx.net>
        <20200616155501.psduxnisltitodme@linutronix.de>
        <871rmesqkk.fsf@gmx.net>
        <20200617142734.mxwfoblufmo6li5e@linutronix.de>
        <87ftatqu07.fsf@gmx.net>
        <20200624201156.xu6hel3drnhno6c3@linutronix.de>
        <87ftak2kxr.fsf@rub.de>
        <20200714134410.3odqfvjq6rndjjf6@linutronix.de>
        <CAJZ5v0hZSUkEMCszDADGWk-v0xNEiDE45B3CHLi05BX6rPfm6g@mail.gmail.com>
        <20200714141135.47adndrsdgpiqfy4@linutronix.de>
        <87blkbx1gt.fsf@gmx.net>
Date:   Tue, 11 Aug 2020 13:58:39 +0200
In-Reply-To: <87blkbx1gt.fsf@gmx.net> (Stephen Berman's message of "Sun, 19
        Jul 2020 12:07:14 +0200")
Message-ID: <87imdp5r80.fsf@rub.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Provags-ID: V03:K1:toB/Zjg2aFqGbWRcB8OrQogjKaiHFaN3+Ki9OvgitLebGHcz/aK
 FDu4bAoS6ozbFuCbOIV/zaXuccj7wgsgP6jj85U+TydkVpcLUddr1qZwpXxB725BFdoZJvS
 OYxVUWFhYxhT20yCRR7jqp+98hixUL7qttfOL7ldrRk8Fk6yC+GGYB140qQi773W+T+hFB7
 yrs/uxiVFcZD2tq+t1F2g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:A+4W+E43X58=:DFKlBz5nwMtEWUzTpifZ0y
 A347YaDxV9tnvPr46HyVuXUeuaXgKRculbJ/5bSeCG8b9em84IUFTuPMlutvQ+Pb3UdDYJiI2
 2TTr+Tc2F2Z8A4l22pMET58cxknjhvNLRN8PcLop1EIHc19YHhljLuf+EnvA5QXD+lldt5r9U
 GhkeAyWrGsUSRVbRRBvc8IRJUqcgerlrZ5JydnmqFEFrmONe9AosOsoww4O+upG1t7nC16bTx
 3inXl3nNWOyDNtv/uX+e9fJhVPnT9AhDBpfEqvINJ/2zG3aDovbsF4vscj/onnW7ObP+slhE2
 9XcUTH9JFo4B+yaTgkLfSjS+zLTGz5wHaSd0ZNy7AOfzRJzfKnZ8HVVNGoIBsuM6mgflXNsz7
 yu26dahE0I6fW/blqe0w1tXg1TnviiE7Uhm8q6P8PT774cM1SlM0Jb5sgoX+SeDUpWQPPFEpn
 ZRqrlebo4koJA1yz8IyaLDS+pHkficAQAGbw9UNkJTnvOuyzBbgf9VZrEcIjNHnhKbw9XVpl+
 ypXkM81JBhg500mIhaMFp/LfpY2CIs/qksuOdMxzUwKdYR725uUZ7mOzp+76T6IUw3gK0oA8e
 F1DLE/1uQui3lpEFu1pmbmDI1Vp/j+14UZqLWenj0OWw4/QsqSA1Ru9gc6gaBcgX1ydOgO46/
 Mfk3ueS81JPLN4NO66Gr5/g8xC+QgDJV/CanIRohyTj67FQ3DVKUqi75GGHY+iakQZqPvQnfD
 6qlWLHYyIbs8KVtPkGrO8x6wkwTwKpxJk1VZU1izwWaOel0GKkteV0auRx9BIRCDsafPnvb7r
 eFoMkzyxH7h5VvsKaOYDH97L5gII7NZf2YrFyhFVsCr+rjuIJefe9RKhahlx5RP2xgRtex+cG
 iNCbKkwkWQldCgspTGOSBIaToTnNeCEppN3YGWuYRUJ2Shg8oCYGefyEqydynBSP5x//wgh3Y
 x5Ohm0yWX4kHXWoJotdALoIaXUTa8V5Yi8UKHVXUpfA0i4uaCHLHEtyX1gvRcm4SsZ30HU1th
 ro3dpHU4czNzVCQvZqkmicdulPj31FqpG9C2iIlw3lmpFBe+/byfcoPyj/zh9fILRe7T8s+8n
 JESrIfcls6qbRG2I5obMjfQndhK5yhrE5B+VwMWI6qBmVacD9yIHAuY8l7+xDkE+FDNLL5/Z1
 j4PRQFX4w9v899WK16aYe2EZoVDn8kpcoAAP1xs1zQEwo4fRYSUujPPgW1vEXJjyYjbMH/SSh
 R8wW4p8W0kWrxuhtkhq/w9XHBoXiciGUb7Jl93g==
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, 19 Jul 2020 12:07:14 +0200 Stephen Berman <stephen.berman@gmx.net>=
 wrote:

> On Tue, 14 Jul 2020 16:11:35 +0200 Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
>
[...]
>> Stephen, the patch attached adds a WARN_ON() statement which will
>> produce a stack trace (4 or so). Could please run 'dmesg' after a while
>> and send it back. There should be a
>>     "WARNING in drivers/acpi/acpica/evmisc.c"
>>
>> statement or something along the lines.
>
> I've now rebuilt 5.6.4 with the new patch; sorry for the delay.  Output
> of dmesg attached.

FWIW, while you were away I got an additional datapoint: someone who saw
my original post about this problem to one of the Linux From Scratch
mailing lists wrote me that he had the same problem, also getting
messages about the cdrom timing out ("sr 3:0:0:0" in his case); I told
him about your workaround of adding 'thermal.tzp=3D300' to the kernel
commandline, and he replied that this works for him too.  And it turns
out we have similar motherboards: I have a Gigabyte Z390 M Gaming
Rev. 1001 board and he has Gigabyte Z390 Designare rev 1.0.

Steve Berman
