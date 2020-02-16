Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A045616044C
	for <lists+linux-acpi@lfdr.de>; Sun, 16 Feb 2020 15:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbgBPOQD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 16 Feb 2020 09:16:03 -0500
Received: from a3.inai.de ([88.198.85.195]:36340 "EHLO a3.inai.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728128AbgBPOQD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 16 Feb 2020 09:16:03 -0500
Received: by a3.inai.de (Postfix, from userid 25121)
        id B3F99589BF92D; Sun, 16 Feb 2020 15:15:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id B2C1961BE7EBD;
        Sun, 16 Feb 2020 15:15:58 +0100 (CET)
Date:   Sun, 16 Feb 2020 15:15:58 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: Linux hangs at ACPI init on Medion P15648 MD63490
In-Reply-To: <CAJZ5v0jesX_fz6-1wnNqYqtVE1qtjZhMsq2OW2L6EGvcpLPtsg@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.2002161038370.4312@n3.vanv.qr>
References: <nycvar.YFH.7.76.2002141734590.24119@n3.vanv.qr> <CAJZ5v0jesX_fz6-1wnNqYqtVE1qtjZhMsq2OW2L6EGvcpLPtsg@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On Sunday 2020-02-16 01:32, Rafael J. Wysocki wrote:
>On Fri, Feb 14, 2020 at 8:28 PM Jan Engelhardt <jengelh@inai.de> wrote:
>>
>> I have a problem with a certain x86 laptop, and judging from the
>> kernel's output, this looks very much like a broken ACPI table.
>> Versions tried are 5.3.8 (Fedora31 liveimage), 5.5.2 (openSUSE
>> Tumbleweed installer) and 5.6.0-rc1+
>> (b19e8c68470385dd2c5440876591fddb02c8c402; self compile), all
>> exhibiting the same hang.
>>         ACPI: \: Used as first EC
>>         ACPI: \: GPE=0x10, IRQ=-1, EC_CMD/EC_SC=0x66, EC_DATA=0x62
>
>Would it be possible to try 5.0 or earlier on the problematic machine?
>You may be hitting a regression here.

Seems not to be the case. The same hang shows, with slightly different messages.

	5.0
	unable to progress to the problem point...
	the NMI watchdog causes a panic due to the slow scrolling of
	earlyprintk=efi

	4.12.14 (openSUSE)
	ACPI: : EC: EC started
	ACPI: : EC: interrupt blocked
	ACPI: \: Used as first EC
	ACPI: \: GPE=0x10, EC_CMD/EC_SC=0x66, EC_DATA=0x62
		(no mention of IRQ=-1)
	ACPI: \: Used as boot ECDT EC to handle transactions
	<hang>

	4.4.76 (openSUSE)
	ACPI : EC: EC description table is found, configuring boot EC
	ACPI : EC: EC started
	<hang>

I thus went back to 5.6-rc and enabled full ACPI tracing
(layer=0xffffffff/level=0xffffffff) starting from

nsinit.c:213	/* Walk namespace to execute all _INIs on present devices */

onwards. That log output is at http://inai.de/files/m923.mp4 [53MB].
