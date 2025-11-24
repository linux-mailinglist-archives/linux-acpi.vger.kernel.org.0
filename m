Return-Path: <linux-acpi+bounces-19219-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CA467C81CB2
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Nov 2025 18:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 343BF4E5E29
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Nov 2025 17:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F592C11C2;
	Mon, 24 Nov 2025 17:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KY46qDxs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0966821CC60;
	Mon, 24 Nov 2025 17:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764003807; cv=none; b=mCaCInsTYlJIY+2kiVNihwvSZpMmyNtvmpct2Tt56KOUXrygOnKW9pOampGQdwBkcLa8Gpu/6EvLrcuokQAV+4k5hgHCnz4EeeJHoXYzIuRm1PPnm1MkRqOM9uCnDn+fbRVjMtt8FgV/e3D+lIae/kqSjPdj44/rPGt0Drhi5m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764003807; c=relaxed/simple;
	bh=XxxmkS+0psK2Efzy4eRoZ9aPH6XqSpviIZ4MrWxBXRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKjtC0AjLB4jcOaXEYzAYvfF4TRsrFVmIXUWwWlPu10W9ea5PCytCBTXcqLGi9Tjo+ibFWa17aSlHX+UojHJ4zqMUVNVrL+K7W03keosWD1w5BHa52PI/3FhhxnBg8dNQlWoXWAEkrMrcHF3WFahue3SYjn46Ee/PVd4ig41nSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KY46qDxs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3639AC4CEF1;
	Mon, 24 Nov 2025 17:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764003806;
	bh=XxxmkS+0psK2Efzy4eRoZ9aPH6XqSpviIZ4MrWxBXRY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KY46qDxsQMwBwr3kh2pe9tKN7G0RE73/bZLC6vNsGKGUjyzWDxT/VlUnr3H9LojvY
	 u8qn7DM/B0upwMBoXP4JsIaeDPnSMl9XAHaXeH4NGmTO14Nw+UEm1rOPcnMcsfq/LA
	 0EpFgf8tVwRtj9H01VmQpxM8Kmkmyh2UOAHVTTDI=
Date: Mon, 24 Nov 2025 18:03:24 +0100
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
Message-ID: <2025112433-emphasize-helpful-b748@gregkh>
References: <20251107184438.1328717-1-usama.anjum@collabora.com>
 <20251107184438.1328717-3-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107184438.1328717-3-usama.anjum@collabora.com>

On Fri, Nov 07, 2025 at 11:44:29PM +0500, Muhammad Usama Anjum wrote:
> acpi_pm_wakeup_event() is called from acpi_button_notify() which is
> called when power button is pressed. The system is worken up from s2idle
> in this case by setting hard parameter to pm_wakeup_dev_event().
> 
> Call acpi_pm_wakeup_event() if power button is pressed and hibernation
> is in progress. Set the hard parameter such that pm_system_wakeup()
> gets called which increments pm_abort_suspend counter. The explicit call
> to acpi_pm_wakeup_event() is necessary as ACPI button device has the
> wakeup source. Hence call to input_report_key() with input device
> doesn't call pm_system_wakeup() as it doesn't have wakeup source
> registered.
> 
> Hence hibernation would be cancelled as in hibernation path, this counter
> is checked if it should be aborted.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

This could be dangerous, as this is not what happens today, are you sure
that people aren't just used to pressing the button multiple times until
the system is hibernated?  If so, that would now break with this change
as it's hard to determine what is going on.

And why does hibernate take so long?  Why not fix that up instead?

thanks,

greg k-h

