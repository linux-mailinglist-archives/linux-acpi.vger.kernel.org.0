Return-Path: <linux-acpi+bounces-18531-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BA6C351BA
	for <lists+linux-acpi@lfdr.de>; Wed, 05 Nov 2025 11:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEB9F189BE40
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Nov 2025 10:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A8130103C;
	Wed,  5 Nov 2025 10:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="P06Viwhx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600C421CC58
	for <linux-acpi@vger.kernel.org>; Wed,  5 Nov 2025 10:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762338799; cv=none; b=S7PmXFj2LF/nkXzU0sD1Mt0awnBkCuUh+P4z5ryP7tT5W5YnQtqlbm6J+kz4QZk0P6ua+0Fl23DOQoIqjdf4iFLXl4Wf9k8mHsdR3oTzwod0+5+GdOuSHeBKQ/9Xi+PDkgMjkFD0qhF3DEvi+c70p+NGCes/N11NC0lbFwnga6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762338799; c=relaxed/simple;
	bh=c9wuqi0SxrCAjffdVwW0x2qZQdlD0QG6wYx0WrPTSoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DVLS7ZvN+Vh4CiCDrCfZaMYJW+h4ONSxdCqas0dqbO6dpEcvqSBXxJWEv5wCvgSIVFl+EKEL0O+bSI1pg14/uuj8oUi2iUU6GMFDJT0FM12nAOlseYUAHF1rxjguFOl/FbhcYWh70CNZvurphBY/fmiphddXg+uOputi2oHOXoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=P06Viwhx; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2952048eb88so71681025ad.0
        for <linux-acpi@vger.kernel.org>; Wed, 05 Nov 2025 02:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1762338797; x=1762943597; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=39uIckh4SoWr03ZIJh4ib+/wvpmKdVIU8qgMasnqseQ=;
        b=P06ViwhxEkb+P8pd2RycSh64aYTigXKRQTHOjrDc4aEeQqL+Tm/hC+ycmX/FzdOFNl
         kWoaMeClgm02WuehoZFRUA4+E35gFU+EvYX0r6n0HoqecjNaxwg4PC50THW8++3exss7
         xr1N5iOFrAsipDK+IiQbII0VARIQd2PTHo0h7SwIPi7cDWKE9IdUaNIsQKlTvGP1IxqW
         MpT2pltPwP4bgqjPu2fyf4M8XouKLIgrpXU2JRbgmvs/jwyAcV/u2gg3/lepOHpJ/lKO
         rg8eBGg9I3ey5BkZoVl3i4yaB20B8TWPIS6of8KZ9crn859WqyVTceOoXxgnshsOyKjD
         YBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762338797; x=1762943597;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=39uIckh4SoWr03ZIJh4ib+/wvpmKdVIU8qgMasnqseQ=;
        b=Hy42yoncZ2mjK5a8S4TLJyxFsjTb5ImcZCSC4uUv7lpZRSk0k1oTdsxvu0NtgEgfx4
         ixAYCTH4H+obJ4lqnPnO1PJfjSbI3cWDzYaTWAy5KGPGHojNmiP+6Sx7d/M/ppsl39/5
         9UTYZ3NVWFEWVlQv0fQ7w0Bx0r/wW+pCO/ggqWPG1gZw+1gb0rH2pcEB72/fVTGSbjaI
         fjtAGnxJTV0JD2K6X2VlgYoPymH3lnfQRBmBB2CEBsYJdqkMVC3fROyJZ7WMDHVutyfu
         TORThYL51NCc3EwuBC2Nd2zN4uK6RKkJ7oyYKYu6pGv5ri3uBHpaM+DSbrcVVUSjy07Y
         DJrw==
X-Forwarded-Encrypted: i=1; AJvYcCUg34RIIMBAltjNrGLJ3NBkaTN4aGfBRcRM4Mqd+H1pvB4WCkAT4zHGf/c81M69xo6TTlDXEG2A/7TT@vger.kernel.org
X-Gm-Message-State: AOJu0YwQZFMsP9kFBuGSPCaVpwLUfGl+J3u4gAnbZ9mAaySYFRYTd5HU
	9j/IWIirCHo8md+0lyebCO0y6DN8Bm+wgdsAA6oofMeSsrJTh7dH2lpsjlSiaRc5mvI=
X-Gm-Gg: ASbGncvpXYcfBL2KKcoueb42ftzEYmWHrkIyEQiT+Y4fPzdQKYqkJyjjTAbLUoAcQd/
	f2SVpliLJpzAJj6IUS6j9Ztm0nfvTXfOjnXN69UCxP7S5GPVCYzcR/aCGYpirFpNTQ00t233eRL
	Xlyka9B+7unRnL5yerKVIbnmlr17RSTKHFmsS5uPF00rQgU8fNfP4UrRWLBYgf1SWZIPOiieexf
	BHMLgPTqCCDWZ3S7m5tk8fvPLfHLzK7CSb6PvvA8cRDNW5z8U0Oq8fkn0dh8Wv9rfW4smDSvak9
	AHlp2/Hn0izhqhwdl5VfQ7OPUZicIOaphClk1NxDiQi6TvEQ1oytdpnTZFyaoTn41i8Hd89zkAe
	1IO57MQrXIkhp88EhdS8HpKNhiuraWIgdA+o3zNtfEabfnoLidRK76tf5BUIlcv7DBFG6RtuuWO
	25SFxzobSjgthBvQDFTJqY+O9NA0k18ZeVRs9tLD/kTkSctQ==
X-Google-Smtp-Source: AGHT+IHdw/96/OCAC1Nx+H3pSqIGsf399zmz5OwGHSCzXvqg9BWyA4UoKggLFqHvpU21yZ0+LgXqjw==
X-Received: by 2002:a17:902:e54e:b0:295:8db9:3059 with SMTP id d9443c01a7336-2962ada1d5fmr42185075ad.38.1762338796647;
        Wed, 05 Nov 2025 02:33:16 -0800 (PST)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a60761sm55885165ad.90.2025.11.05.02.33.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 02:33:15 -0800 (PST)
Message-ID: <7b267b11-a204-447e-afc6-86722518cf58@rivosinc.com>
Date: Wed, 5 Nov 2025 11:33:04 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 06/10] riscv: Add functions to register ghes having
 SSE notification
To: Himanshu Chauhan <hchauhan@ventanamicro.com>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
 acpica-devel@lists.linux.dev
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, lenb@kernel.org,
 james.morse@arm.com, tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
 robert.moore@intel.com, sunilvl@ventanamicro.com, apatel@ventanamicro.com
References: <20251029112649.3811657-1-hchauhan@ventanamicro.com>
 <20251029112649.3811657-7-hchauhan@ventanamicro.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20251029112649.3811657-7-hchauhan@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/29/25 12:26, Himanshu Chauhan wrote:
> Add functions to register the ghes entries which have SSE as
> notification type. The vector inside the ghes is the SSE event
> ID that should be registered.
> 
> Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
> ---
>  drivers/firmware/riscv/riscv_sbi_sse.c | 147 +++++++++++++++++++++++++
>  include/linux/riscv_sbi_sse.h          |  16 +++
>  2 files changed, 163 insertions(+)
> 
> diff --git a/drivers/firmware/riscv/riscv_sbi_sse.c b/drivers/firmware/riscv/riscv_sbi_sse.c
> index 6561c7acdaaa..46ebc9e9651c 100644
> --- a/drivers/firmware/riscv/riscv_sbi_sse.c
> +++ b/drivers/firmware/riscv/riscv_sbi_sse.c
> @@ -5,6 +5,8 @@
>  
>  #define pr_fmt(fmt) "sse: " fmt
>  
> +#include <acpi/ghes.h>
> +#include <linux/acpi.h>
>  #include <linux/cpu.h>
>  #include <linux/cpuhotplug.h>
>  #include <linux/cpu_pm.h>
> @@ -700,3 +702,148 @@ static int __init sse_init(void)
>  	return ret;
>  }
>  arch_initcall(sse_init);
> +
> +struct sse_ghes_callback {
> +	struct list_head head;
> +	struct ghes *ghes;
> +	sse_event_handler_fn *callback;
> +};
> +
> +struct sse_ghes_event_data {
> +	struct list_head head;
> +	u32 event_num;
> +	struct list_head callback_list;
> +	struct sse_event *event;
> +};
> +
> +static DEFINE_SPINLOCK(sse_ghes_event_list_lock);
> +static LIST_HEAD(sse_ghes_event_list);

Hi Himanshu,

Please declare these structs/functions at the beggining of the file.

> +
> +static int sse_ghes_handler(u32 event_num, void *arg, struct pt_regs *regs)
> +{
> +	struct sse_ghes_event_data *ev_data = arg;
> +	struct sse_ghes_callback *cb = NULL;
> +
> +	list_for_each_entry(cb, &ev_data->callback_list, head) {
> +		if (cb && cb->ghes && cb->callback) {
> +			cb->callback(ev_data->event_num, cb->ghes, regs);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +int sse_register_ghes(struct ghes *ghes, sse_event_handler_fn *lo_cb,
> +		      sse_event_handler_fn *hi_cb)
> +{
> +	struct sse_ghes_event_data *ev_data, *evd;
> +	struct sse_ghes_callback *cb;
> +	u32 ev_num;
> +	int err;
> +
> +	if (!sse_available)
> +		return -EOPNOTSUPP;
> +	if (!ghes || !lo_cb || !hi_cb)
> +		return -EINVAL;
> +
> +	ev_num = ghes->generic->notify.vector;
> +
> +	ev_data = NULL;
> +	spin_lock(&sse_ghes_event_list_lock);
> +	list_for_each_entry(evd, &sse_ghes_event_list, head) {
> +		if (evd->event_num == ev_num) {
> +			ev_data = evd;
> +			break;
> +		}
> +	}
> +	spin_unlock(&sse_ghes_event_list_lock);

That lock should cover the whole ev_data creation. Because if two CPUs
enters this function at the same time, the following scneario can occur:

   CPU0               CPU1
   lock
   ev_data = NULL
   unlock
                      lock
		      ev_data = NULL
                      unlock
	
   create ev_data     create ev_data

 -> Both will have read a ev_data = NULL and create an ev_data.

The lock should be kept and unlocked at the end of the function, you can
use a guard() for that.

> +
> +	if (!ev_data) {
> +		ev_data = kzalloc(sizeof(*ev_data), GFP_KERNEL);
> +		if (!ev_data)
> +			return -ENOMEM;
> +
> +		INIT_LIST_HEAD(&ev_data->head);

I think this isn't necessary since list_add_tail() will anyway overwrite
the head->next/prev field. BTW it's confusing to call this member head
since it will be used as a node in the list. It could probably be
renamed node/list.

> +		ev_data->event_num = ev_num;
> +
> +		INIT_LIST_HEAD(&ev_data->callback_list);
> +
> +		ev_data->event = sse_event_register(ev_num, ev_num,
> +						    sse_ghes_handler, ev_data);
> +		if (IS_ERR(ev_data->event)) {
> +			pr_err("%s: Couldn't register event 0x%x\n", __func__, ev_num);
> +			kfree(ev_data);
> +			return -ENOMEM;
> +		}
> +
> +		err = sse_event_enable(ev_data->event);
> +		if (err) {
> +			pr_err("%s: Couldn't enable event 0x%x\n", __func__, ev_num);
> +			sse_event_unregister(ev_data->event);
> +			kfree(ev_data);
> +			return err;
> +		}
> +
> +		spin_lock(&sse_ghes_event_list_lock);
> +		list_add_tail(&ev_data->head, &sse_ghes_event_list);
> +		spin_unlock(&sse_ghes_event_list_lock);
> +	}
> +
> +	list_for_each_entry(cb, &ev_data->callback_list, head) {
> +		if (cb->ghes == ghes)
> +			return -EALREADY;
> +	}
> +
> +	cb = kzalloc(sizeof(*cb), GFP_KERNEL);
> +	if (!cb)
> +		return -ENOMEM;
> +	INIT_LIST_HEAD(&cb->head);
> +	cb->ghes = ghes;
> +	cb->callback = lo_cb;
> +	list_add_tail(&cb->head, &ev_data->callback_list);

AFAIU, at this point, the SSE event is already enabled, it means the
sse_ghes_handler() can be called. This one can potentially access
&ev_data->callback_list concurrently which would result in a corrupted
list. You should mask/disable the SSE event while adding the callback to
this list.

BTW, accessing the ev_data->callback here means that if multiple CPUs
access this function at the same time, it could result in a corrupted
ev_data list. Not sure if it can happen but better be safe than sorry.

> +
> +	return 0;
> +}
> +
> +int sse_unregister_ghes(struct ghes *ghes)
> +{
> +	struct sse_ghes_event_data *ev_data, *tmp;
> +	struct sse_ghes_callback *cb;
> +	int free_ev_data = 0;
> +
> +	if (!ghes)
> +		return -EINVAL;
> +
> +	spin_lock(&sse_ghes_event_list_lock);
> +
> +	list_for_each_entry_safe(ev_data, tmp, &sse_ghes_event_list, head) {
> +		list_for_each_entry(cb, &ev_data->callback_list, head) {
> +			if (cb->ghes != ghes)
> +				continue;
> +
> +			list_del(&cb->head);
> +			kfree(cb);
> +			break;
> +		}
> +
> +		if (list_empty(&ev_data->callback_list))
> +			free_ev_data = 1;
> +
> +		if (free_ev_data) {

Remove free_ev_data and use the following:

		if (list_empty(&ev_data->callback_list)) {> +		
spin_unlock(&sse_ghes_event_list_lock);
> +
> +			sse_event_disable(ev_data->event);
> +			sse_event_unregister(ev_data->event);
> +			ev_data->event = NULL;
> +
> +			spin_lock(&sse_ghes_event_list_lock);
> +
> +			list_del(&ev_data->head);
> +			kfree(ev_data);
> +		}
> +	}
> +
> +	spin_unlock(&sse_ghes_event_list_lock);
> +
> +	return 0;
> +}

Please declare this above the arch_initcall() function

> diff --git a/include/linux/riscv_sbi_sse.h b/include/linux/riscv_sbi_sse.h
> index a1b58e89dd19..cd615b479f82 100644
> --- a/include/linux/riscv_sbi_sse.h
> +++ b/include/linux/riscv_sbi_sse.h
> @@ -11,6 +11,7 @@
>  
>  struct sse_event;
>  struct pt_regs;
> +struct ghes;
>  
>  typedef int (sse_event_handler_fn)(u32 event_num, void *arg,
>  				   struct pt_regs *regs);
> @@ -24,6 +25,10 @@ void sse_event_unregister(struct sse_event *evt);
>  
>  int sse_event_set_target_cpu(struct sse_event *sse_evt, unsigned int cpu);
>  
> +int sse_register_ghes(struct ghes *ghes, sse_event_handler_fn *lo_cb,
> +		      sse_event_handler_fn *hi_cb);
> +int sse_unregister_ghes(struct ghes *ghes);
> +
>  int sse_event_enable(struct sse_event *sse_evt);
>  
>  void sse_event_disable(struct sse_event *sse_evt);
> @@ -47,6 +52,17 @@ static inline int sse_event_set_target_cpu(struct sse_event *sse_evt,
>  	return -EOPNOTSUPP;
>  }
>  
> +static inline int sse_register_ghes(struct ghes *ghes, sse_event_handler_fn *lo_cb,
> +				    sse_event_handler_fn *hi_cb)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int sse_unregister_ghes(struct ghes *ghes)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  static inline int sse_event_enable(struct sse_event *sse_evt)
>  {
>  	return -EOPNOTSUPP;


