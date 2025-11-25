Return-Path: <linux-acpi+bounces-19253-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E30C84CBE
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Nov 2025 12:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CDB384E4964
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Nov 2025 11:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69864314B9D;
	Tue, 25 Nov 2025 11:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uPGiKTaV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC94265CBE;
	Tue, 25 Nov 2025 11:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764071270; cv=none; b=HuKRX4TBzGRb15QWcj2m5Hvx1/+oyzmL3+MdOQSLX7cDVOtBO3b/EMnnuw3fLgN8h4ClUN9p1igt6VdzcB7HC1MFBppf+Q8oEY15/WqaAP1a3vBQJYMdFjOnP/tVX/RzsfFLmPzqWVVeWAMjJU10rsMkFCWa+o6H+c3T/rL/NVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764071270; c=relaxed/simple;
	bh=TCGi/wFKjRkB6ogJsQ61H3l+btD8ChQHohKRD/wI5Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4vUuCuXROuabjwkTSR9HTgwYKqFSjOvJ8yTDYTPKXO5hFMV4+A8VjJkUQH09qL+GURH1DJkB9XN3FRggKiW2dRCfTFwkGwHBABrLxUHAl8JdHDDgMbJoNDzQ9p5uaRcEpunGt7h85rGTOPfOYhNozID3Y1XUp29F9b1d6LUmtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uPGiKTaV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ADABC4CEF1;
	Tue, 25 Nov 2025 11:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764071269;
	bh=TCGi/wFKjRkB6ogJsQ61H3l+btD8ChQHohKRD/wI5Ak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uPGiKTaVfptw0bx+qJPdtmE54OMCklcBAbdgMQDbPUdCwiKVTxkeIFFemClQH7fmc
	 dAmQoW5ae4ovfqYaIzPMprpYjCQnsOv5moq48IKVrLQbd6kIOKfQABxzC397EKKR/X
	 MuOULLIcihUv9JBj0x69zLjmklf0mrT+PAtNU2qc=
Date: Tue, 25 Nov 2025 12:47:46 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-input@vger.kernel.org, kernel@collabora.com,
	superm1@kernel.org
Subject: Re: [PATCH 2/4] ACPI: button: Cancel hibernation if button is
 pressed during hibernation
Message-ID: <2025112506-acting-tipoff-3a49@gregkh>
References: <20251107184438.1328717-1-usama.anjum@collabora.com>
 <20251107184438.1328717-3-usama.anjum@collabora.com>
 <2025112433-emphasize-helpful-b748@gregkh>
 <e1e97842-0ad3-4270-b0d1-3cc7150988cd@collabora.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1e97842-0ad3-4270-b0d1-3cc7150988cd@collabora.com>

On Tue, Nov 25, 2025 at 04:12:54PM +0500, Muhammad Usama Anjum wrote:
> Hi Greg,
> 
> Thank you for the review.
> 
> On 11/24/25 10:03 PM, Greg Kroah-Hartman wrote:
> > On Fri, Nov 07, 2025 at 11:44:29PM +0500, Muhammad Usama Anjum wrote:
> >> acpi_pm_wakeup_event() is called from acpi_button_notify() which is
> >> called when power button is pressed. The system is worken up from s2idle
> >> in this case by setting hard parameter to pm_wakeup_dev_event().
> >>
> >> Call acpi_pm_wakeup_event() if power button is pressed and hibernation
> >> is in progress. Set the hard parameter such that pm_system_wakeup()
> >> gets called which increments pm_abort_suspend counter. The explicit call
> >> to acpi_pm_wakeup_event() is necessary as ACPI button device has the
> >> wakeup source. Hence call to input_report_key() with input device
> >> doesn't call pm_system_wakeup() as it doesn't have wakeup source
> >> registered.
> >>
> >> Hence hibernation would be cancelled as in hibernation path, this counter
> >> is checked if it should be aborted.
> >>
> >> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> >
> My thinking is that people don't press power button after triggering
> hibernation. They will only press power button if they want to cancel the
> hibernation or resume from hibernation a bit later when hibernation completes. 
> > This could be dangerous, as this is not what happens today, are you sure
> > that people aren't just used to pressing the button multiple times until
> > the system is hibernated? If so, that would now break with this change
> > as it's hard to determine what is going on.
> Yes, its possible. Previously the device wouldn't cancel hibernation on power
> button press; while now it'll cancel.
> 
> So should we put this cancellation under some config option to avoid breaking
> the default behavior?

Do not add another config option, that way lies madness.  As proof, what
would your distro select for this, in order to preserve old behavior?  :)

> > And why does hibernate take so long?  Why not fix that up instead?
> Hibernation is inherently slow: it must freeze devices, copy and
> compress/encrypt memory, then resume storage devices to write the image to
> disk.
> 
> While I've thought about increasing the speed, I've no concrete ideas yet.
> The main problem is that its sequential in nature.

Then fix that?

thanks,

greg k-h

