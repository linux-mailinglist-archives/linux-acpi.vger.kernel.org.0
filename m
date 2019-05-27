Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6EF2B175
	for <lists+linux-acpi@lfdr.de>; Mon, 27 May 2019 11:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfE0JkD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 27 May 2019 05:40:03 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:49227 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfE0JkD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 27 May 2019 05:40:03 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 368A8804CB; Mon, 27 May 2019 11:39:51 +0200 (CEST)
Date:   Mon, 27 May 2019 11:39:38 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
        bp@suse.de, hpa@zytor.com, mingo@redhat.com, x86@kernel.org,
        rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org
Subject: Re: Thinkpad X60 fails to boot while "hot"
Message-ID: <20190527093938.GA12391@xo-6d-61-c0.localdomain>
References: <20190527085155.GA11421@xo-6d-61-c0.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527085155.GA11421@xo-6d-61-c0.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon 2019-05-27 10:51:55, Pavel Machek wrote:
> Hi!
> 
> So if you compile a kernel, then reboot, boot will hang after "Freeing SMP
> alternatives memory" (and then wastes power, making thermal situation even worse).

Normally, next message is "smpboot: CPU0: Genuine Intel...".

I added some printks, and check_bugs() returns. Then it goes to ACPI and never
comes back...

kernel-parameters.txt points to Documentation/acpi/debug.txt, but that one does not exist.

Any ideas what debugging parameters to use for ACPI? I either get nothing or
so much that machine does not boot...

> Unfortunately, threshold for non-booting system is quite low, fan does _not_
> go full speed after reboot. Annoying for kernel development :-(. Force power off,
> wait for a while, power on, and it works again.
> 
> The bug is there for a long long time... probably 4.0 is affected, probably even
> older.

Quick test, and 4.6.0 seems to be affected.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
