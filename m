Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B87EA2E98FC
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Jan 2021 16:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbhADPko (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 Jan 2021 10:40:44 -0500
Received: from mout.gmx.net ([212.227.15.18]:48041 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727373AbhADPko (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 4 Jan 2021 10:40:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1609774730;
        bh=IPu/zgiNgNmz3x4T6k4qp/trrTx8/3vL3KZym3IUYgM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:References:Date:In-Reply-To;
        b=bjmwzx3x2+5Hbpu0hAS/j0nZ8jcsvPA6YBueWr6W6GcWhVd/GwmToYx+1J+ZdiZrL
         2li0nnMry+twwADjFaltiZ6I8Em33C86GFRWqgFIcEHFEKFiVKfEYKymVNDkLApsCG
         aHaLsO9metJYvnxPIbx5AH8xtGPVMJCH6jKQZPhg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from strobe-jhalfs ([188.109.198.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MrhUE-1kBEZa1qGC-00nf5J; Mon, 04
 Jan 2021 16:38:50 +0100
From:   Stephen Berman <stephen.berman@gmx.net>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: power-off delay/hang due to commit 6d25be57 (mainline)
References: <87blkbx1gt.fsf@gmx.net>
        <CAJZ5v0j86pX_a4bSLP=sobLoYhfQYV9dWL8HHf2941kXgND79g@mail.gmail.com>
        <CAJZ5v0j7i86twMS+csYMaetUkvqjof4FD2GRNoZ_AN=SBF7F1w@mail.gmail.com>
        <9709109.MH8tSaV5v9@kreacher>
Date:   Mon, 04 Jan 2021 16:38:43 +0100
In-Reply-To: <9709109.MH8tSaV5v9@kreacher> (Rafael J. Wysocki's message of
        "Thu, 31 Dec 2020 21:46:11 +0100")
Message-ID: <87eej0iuf0.fsf@gmx.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Provags-ID: V03:K1:4zd9Fn9oxJThrxYFz8JbUXu+EVRcv/zeUM5ArdhvzN5kc2MnNti
 EHIMMLRAVKsMTIyCftrJtWahKRhYdYbP4vsY2j4RPA/HcOcK5Xjd0zkRQOrouc9u8G89bxD
 Iod/Rq5YRw732M3UVyHs8IWeHvR58ZbYscdFLwTQCA1Z4m0pIjPLASfsZS6LV5kMRaCWTLh
 fHQLLJudLP2ZbsrwdQgWw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9/YFwp5L8E8=:Go3TnzrpE6IOCBiaoZ8oIs
 5egBHQyTJ3uMrDFWSVuOi+IZtzLBy1XDI2L1ve5ADViMLdWCmF1mwwT73rPGnw/YqS1JhMM28
 tVbyoTEBRpy5NkrUxILKHRWA66w+sRIWyLOGyDGA924hcM3o3rxTapXNDRCP6lq3X9o3cyQUx
 72OQ+7lKMPa/AtL8xRYotIfI0xP+dakuBYY6aM5rh4lM/WSnTzYVTBAL/QrUVfS0gIAjW8ziY
 d5IgISTDxEqPAM7v34YQnvTBJHlPnd7/TVmIu+V/5hBKUKj0Sif2Zca3l1qo0nBLaadIBph5s
 ZPulj2PYlwfYIXcCnitAPFjD0SwpPBC/BjX3gh+WidxItLgkAQvZe81zuUlQSUExSwzN0F7D6
 w4c5KrzYjpePnRzG6YmA2zcwfejjst18RW7jj//IK1BbtFHsLSX9b4vJqwIUYmCrrlDkoGC4K
 6MuB9v1mcS2buGnwnIFehhIAUAIWgbCt02a+dw3YDTFYRdnOeY98oGZ3K9nlXbebC7clTY4SX
 9rnYIrTxp8a1zppoBxA+06KVzqXMLIaTRZN8iKoCCG7beonzRjUoBAdTh4e2hMD+2Z4mT/d9S
 dQ5oYfuK5aldGdsehe/+15S1plJDPDhHVwLMvQ/BlPOBB7nxgFRrROBwN1Koo7H3R8VNMfcc1
 8UoXM2kDKQNXy2mwh3c3yB5565cRT5NRrEFW29MYJl7NvkN2FKtT10qLMbU3QBEB+Xlg1UBNW
 VfHYeJ6KpM5FfaaBRAx2tgtuPa4jO7ghmo+Nq/30+NGHJag/EVFrf5CDYBtaqzmKlWVhk5Evz
 EMDoh2WjTy4+s/8YxLdvW2U6bw8OImu1J18IY7Qu9aX0UPidmAtt9qCitaceo5C5t42B2PdOZ
 r0OUIvTIzgoyT+2K5SSw==
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, 31 Dec 2020 21:46:11 +0100 "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:

> ATM, I'm tempted to do something like the patch below (with the rationale
> that it shouldn't be necessary to read the temperature right after updating
> the trip points if polling is in use, because the next update through polling
> will cause it to be read anyway and it will trigger trip point actions as
> needed).
>
> Stephen, can you give it a go, please?

On Sat, 02 Jan 2021 12:03:17 +0100 "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:

> There is one more way to address this, probably better: instead of checking the
> temperature right away in acpi_thermal_notify(), queue that on acpi_thermal_pm_queue
> and so only if another thermal check is not pending.
>
> This way there will be at most one temperature check coming from
> acpi_thermal_notify() queued up at any time which should prevent the
> build-up of work items from taking place.
>
> So something like this:

Thanks for the patches.  I'll try them as soon as I can.

Steve Berman
