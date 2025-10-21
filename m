Return-Path: <linux-acpi+bounces-18063-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BF4BF8EAE
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Oct 2025 23:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 558114F966C
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Oct 2025 21:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBBA2877F1;
	Tue, 21 Oct 2025 21:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/xw7MzL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5DE28726E;
	Tue, 21 Oct 2025 21:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761081285; cv=none; b=G5AtNEmf4W593f0a05PeGXpsijb3MHUp4XGzGAaXVupkiZ2uzVh5p65eFgVFX9q5K97FPrWpPetYAdq+ubGp8WQpasxbUTMy7qTBC+OOt+la++OZnVvuCjI/qD1QFcqBrRbYTioo/7RnQtaCYBgfROjPbLtAGX3i8L3tNqOmO4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761081285; c=relaxed/simple;
	bh=E6SQg1oIwh1ZxyuFxSkOYv3t4N6XzLLqb/wv80kcBgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nnyB5hKqY3Rh1sQMXVVacClOhrN/6xATa0DuB7g0T0VSUz7P6L9JB24vMWdXwTpBMAtN4X7lZE5tOBfu8ZzLyi5FJ6cv/64swYAd59bwx7w8ZsLbuUocezxelnnlfni+P3kBfaejJ07gO1oWOszK+5I/vlTdMxZPibG5Udzvrlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/xw7MzL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E62FFC4CEF7;
	Tue, 21 Oct 2025 21:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761081284;
	bh=E6SQg1oIwh1ZxyuFxSkOYv3t4N6XzLLqb/wv80kcBgc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o/xw7MzLpkmBy+24pCcbCbsXu8o2GjJ9mpBYXzLNpf2jSylhB1MNiW+6KEETSvTho
	 ythFck343+ReraNZlpvyy1HbJ18vf7X//8sHT8YySHHF+HUuTcMuh7XQx+NLcCvA+8
	 pOCgTw3FjIjSSzBVzUaar9/Hz05Xiz890S575uLc4UpIB46O2leQlyg8AGeLHHYKhv
	 TjPMgznJQVK2LUyNvDASkwlVt9bFcm0jnfUkCAF8+fj8tOIWnycdcJe/6Tbe4GkMOd
	 DNncjK14JTrUW+QUsro8DErZXxws2+kWDZqFUrjSEYiF4cHbtqaO2R6Zovb2gy0UR5
	 6j4iwjXKPrdlg==
Message-ID: <7308c2c0-3881-445d-9771-fad5c3259518@kernel.org>
Date: Tue, 21 Oct 2025 16:14:42 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 3/4] Input: Ignore the KEY_POWER events if hibernation is in
 progress
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Pavel Machek <pavel@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-input@vger.kernel.org
Cc: kernel@collabora.com
References: <20251018142114.897445-1-usama.anjum@collabora.com>
 <20251018142114.897445-4-usama.anjum@collabora.com>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <20251018142114.897445-4-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/18/2025 9:21 AM, Muhammad Usama Anjum wrote:
> Serio drivers call input_handle_event(). Although the serio drivers have
> duplicate events, they have separate code path and call
> input_handle_event(). Ignore the KEY_POWER such that this event isn't
> sent to the userspace if hibernation is in progress.
> 
> Abort the hibernation by calling pm awake API as well.

So do you observe events both from ACPI and from input?  Or was this 
patch based upon an earlier version of the ACPI patch?

Because it feels like to me perhaps another way to solve this would be 
for patch 2 to to send the input event and just keep 
pm_wakeup_dev_event() here instead of both places.

> 
> Without this, the event is sent to the userspace and it suspends the
> device after hibernation cancellation.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>   drivers/input/input.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/input/input.c b/drivers/input/input.c
> index a500e1e276c21..0979f18aae6a2 100644
> --- a/drivers/input/input.c
> +++ b/drivers/input/input.c
> @@ -26,6 +26,7 @@
>   #include <linux/kstrtox.h>
>   #include <linux/mutex.h>
>   #include <linux/rcupdate.h>
> +#include <linux/suspend.h>
>   #include "input-compat.h"
>   #include "input-core-private.h"
>   #include "input-poller.h"
> @@ -362,6 +363,11 @@ void input_handle_event(struct input_dev *dev,
>   
>   	lockdep_assert_held(&dev->event_lock);
>   
> +	if (code == KEY_POWER && hibernation_in_progress()) {
> +		pm_wakeup_dev_event(&dev->dev, 0, true);
> +		return;
> +	}
> +
>   	disposition = input_get_disposition(dev, type, code, &value);
>   	if (disposition != INPUT_IGNORE_EVENT) {
>   		if (type != EV_SYN)


