Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8F8160770
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Feb 2020 01:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgBQAKr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 16 Feb 2020 19:10:47 -0500
Received: from a3.inai.de ([88.198.85.195]:52738 "EHLO a3.inai.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbgBQAKr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 16 Feb 2020 19:10:47 -0500
Received: by a3.inai.de (Postfix, from userid 25121)
        id 4F8EE5874A7A5; Mon, 17 Feb 2020 01:10:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 4B92C60C26E25;
        Mon, 17 Feb 2020 01:10:45 +0100 (CET)
Date:   Mon, 17 Feb 2020 01:10:45 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: Linux hangs at ACPI init on Medion P15648 MD63490
In-Reply-To: <CAJZ5v0jOOi0SjZ+SUv8L8f6z2uxu40Q7AP_q9XKVEOePxwBHfg@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.2002170109040.8537@n3.vanv.qr>
References: <nycvar.YFH.7.76.2002141734590.24119@n3.vanv.qr> <CAJZ5v0jesX_fz6-1wnNqYqtVE1qtjZhMsq2OW2L6EGvcpLPtsg@mail.gmail.com> <nycvar.YFH.7.76.2002161038370.4312@n3.vanv.qr> <CAJZ5v0jOOi0SjZ+SUv8L8f6z2uxu40Q7AP_q9XKVEOePxwBHfg@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On Sunday 2020-02-16 21:49, Rafael J. Wysocki wrote:

>> I thus went back to 5.6-rc and enabled full ACPI tracing
>> (layer=0xffffffff/level=0xffffffff) starting from
>>
>> nsinit.c:213    /* Walk namespace to execute all _INIs on present devices */
>>
>> onwards. That log output is at http://inai.de/files/m923.mp4 [53MB].
>
>If that is the case, then AFAICS the issue may not be directly related
>to the EC at all.  This output only means that the system has an ECDT,
>but that should not be a problem by itself.
>
>The system appears to hang somewhere in acpi_ns_initialize_devices()
>and it is hard to say where exactly.

I had an exact stack trace. (Stashed in all those videos - now extracted and
posted to the bug)

>I would suggest creating a BZ entry at bugzilla.kernel.org for this
>issue and attaching the output of acpidump from the affected system in
>there.

https://bugzilla.kernel.org/show_bug.cgi?id=206553
