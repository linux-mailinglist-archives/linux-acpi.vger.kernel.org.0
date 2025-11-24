Return-Path: <linux-acpi+bounces-19217-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE9AC81C55
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Nov 2025 18:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CDEDE4E66B0
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Nov 2025 17:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5517E313E27;
	Mon, 24 Nov 2025 17:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XfXgaRpA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A3C2C21C4;
	Mon, 24 Nov 2025 17:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764003716; cv=none; b=g/aupWWlR2+ym1Cewb4+mUpwkWkRorYRpHmxq5tduo7CmbbCx10lizIJ8c5OaGYhxpyCw2vQ335itFcdNI64WaQEZ3gDpuwSFUiqqPKoTkIdQtYI+EquEE+6iLvxV8lFm+rHbekmzl+jmYB0n4XlAxI9/sOnyB33Re/DUtfnK6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764003716; c=relaxed/simple;
	bh=0rs6/wHIvwu17tltFEE9Lln46ntnETEqPJFF3W3lSaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxvalqyTOoO0sbeejnYF+9Rj6MtbaCwqUA77NdGjVe+azHlKoDeWJ6gBcWgaaw1+JruladyPPZkFcj6yWncYXi5ZLiKga9Iqr0KFhOmLtvApZTupkRzBX+tVwflJgsCYoWtTrek58guc23fztrq1z1+WWpyuCpUHMbFU8bAkjsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XfXgaRpA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06568C4CEF1;
	Mon, 24 Nov 2025 17:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764003715;
	bh=0rs6/wHIvwu17tltFEE9Lln46ntnETEqPJFF3W3lSaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XfXgaRpA2CCH77H/w4evexNhq6cSxnP+EeX2641WjzYJudn09qSa5RSRDvDz3e+BC
	 ij0WqIHaRgKTbCwDAojy80N4H1ETuRMdsdWkhnQCz8UO0M3vUO93qvjQELZFMUBXGA
	 2QngPctZ7H7iYl6Hp0w3rrEzamrbBjURJJE+jHXk=
Date: Mon, 24 Nov 2025 18:01:52 +0100
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
Subject: Re: [PATCH 1/4] PM: hibernate: export
 pm_sleep_transition_in_progress()
Message-ID: <2025112423-rocking-deafness-88c0@gregkh>
References: <20251107184438.1328717-1-usama.anjum@collabora.com>
 <20251107184438.1328717-2-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107184438.1328717-2-usama.anjum@collabora.com>

On Fri, Nov 07, 2025 at 11:44:28PM +0500, Muhammad Usama Anjum wrote:
> Export pm_sleep_transition_in_progress() to be used by other
> modules.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  kernel/power/main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index 33a47ed15994f..ff3354b5be150 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -570,6 +570,7 @@ bool pm_sleep_transition_in_progress(void)
>  {
>  	return pm_suspend_in_progress() || hibernation_in_progress();
>  }
> +EXPORT_SYMBOL_GPL(pm_sleep_transition_in_progress);

The problem is, you can not rely on the result of this call as it could
change right after you call it, right?

So who needs to call this and why?  What new workflow requires this?

thanks,

greg k-h

