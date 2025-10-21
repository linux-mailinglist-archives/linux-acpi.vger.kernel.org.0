Return-Path: <linux-acpi+bounces-18061-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E8718BF8E42
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Oct 2025 23:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DBC684E9D58
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Oct 2025 21:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B686F284690;
	Tue, 21 Oct 2025 21:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zz5lIda6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743CE283151;
	Tue, 21 Oct 2025 21:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761080860; cv=none; b=UzHDd/nxZ2lPfRFTUEsSR0R4e7cO8qJGskl4eoocIwWIx74O/eK6RfVLH+azPqFbe9PwEu9VSlqVXMw1o0d1RIDIwm04AT0L7JLDRvMp/QcMKiI2FXQARWT3KaVZ4nr3P+w9B9JgifHWahEl+/XjQMaCjO4SzX1rxMi55jXwKFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761080860; c=relaxed/simple;
	bh=6rVJs5rEus5FZiX6tLPh68lB2YG/8X+bTkHWX4sobcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jdCoVcAYCdYh9kAJKQhDBb9SRHBhbjl4NBN6FNzDTCUjBMts1fqPLm4uVYyUPNq5kiQUcgrzFTXOb2v3K6+eBZt6IDl+lvpzn8IzqqNbh3SkocAoLvuVvBOfwjNQdlbeaiZtUjdUSb8F+2yNNHhoIRWPebyVnpadfBoN7wGnB+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zz5lIda6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79900C4CEF1;
	Tue, 21 Oct 2025 21:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761080859;
	bh=6rVJs5rEus5FZiX6tLPh68lB2YG/8X+bTkHWX4sobcw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Zz5lIda6FiJqRCcOuvAe6jpfmgvIRlDcUJPg6A7KLUB/usFIoOYlKO3p39IS8cH4J
	 WHSWsEBok/a4/UOcncVeWqc5gUAckLw+K2skYwHRlX+SNQMQ/lf22ghbWvyG/GPN6P
	 Ipaw60tbWs2gVFGAbEGJNV09hWyn2S+u/apyJYDPFoIq8ulYNUgLUEJdQKnYuMa7MA
	 du+bJ/n9VukM8CfdOBBdZ2Dcz9Vvn3HivweFDqPGtCIGIeel71CLfQjOA1BV8oxrx3
	 oIrREX7eZmVsh7vc2Pljbq16I0vH+4lUQ7gcn/Cg0JpaMTHw2HQmM8jwUNj3YL5sKy
	 ohjd2L/d+GtdA==
Message-ID: <68a8c1ba-275c-4908-a4c8-2e8b83367703@kernel.org>
Date: Tue, 21 Oct 2025 16:07:36 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/4] PM: hibernate: export hibernation_in_progress()
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
 <20251018142114.897445-2-usama.anjum@collabora.com>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <20251018142114.897445-2-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/18/2025 9:21 AM, Muhammad Usama Anjum wrote:
> Export hibernation_in_progress() to be used by other modules. Add its
> signature when hibernation config isn't enabled as well.

I wonder if you actually want to have pm_sleep_transition_in_progress() 
exported instead.  "Logically" I would expect cancelling a hibernate and 
cancelling a suspend should work similarly.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>   include/linux/suspend.h  | 2 ++
>   kernel/power/hibernate.c | 1 +
>   2 files changed, 3 insertions(+)
> 
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index b02876f1ae38a..348831cdb60e4 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -393,6 +393,7 @@ extern void hibernation_set_ops(const struct platform_hibernation_ops *ops);
>   extern int hibernate(void);
>   extern bool system_entering_hibernation(void);
>   extern bool hibernation_available(void);
> +extern bool hibernation_in_progress(void);
>   asmlinkage int swsusp_save(void);
>   extern struct pbe *restore_pblist;
>   int pfn_is_nosave(unsigned long pfn);
> @@ -412,6 +413,7 @@ static inline void hibernation_set_ops(const struct platform_hibernation_ops *op
>   static inline int hibernate(void) { return -ENOSYS; }
>   static inline bool system_entering_hibernation(void) { return false; }
>   static inline bool hibernation_available(void) { return false; }
> +static inline bool hibernation_in_progress(void) { return false; }
>   
>   static inline int hibernate_quiet_exec(int (*func)(void *data), void *data) {
>   	return -ENOTSUPP;
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 14e85ff235512..aadf82f57e868 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -105,6 +105,7 @@ bool hibernation_in_progress(void)
>   {
>   	return !atomic_read(&hibernate_atomic);
>   }
> +EXPORT_SYMBOL_GPL(hibernation_in_progress);
>   
>   bool hibernation_available(void)
>   {


