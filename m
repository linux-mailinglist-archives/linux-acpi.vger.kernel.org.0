Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9789727393C
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Sep 2020 05:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbgIVD0x (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 21 Sep 2020 23:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728546AbgIVD0x (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Sep 2020 23:26:53 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6C0C061755;
        Mon, 21 Sep 2020 20:26:53 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id r10so3807497oor.5;
        Mon, 21 Sep 2020 20:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tLAbhc9hG8hMeoi+bM5VQG65H4Ga6azIRDdsWGwXFug=;
        b=WIqaR4beJQ0GUBFjk06VaesFsJlavd8siwqFJBLFhBfh5cc6h6TSQ3/ksivWC2dU9j
         lhs3j1yS8hjMl52eWMrPhwZ2lwvQA+yMMqXIeHpaOvmr/GiVYEssNYOHry8RK12htNLe
         v/N0Acz1RkNNxmG/w56Z/jxYIlXPcyGhZHB5uJY9YtJrnKUvpbbtuEmUKZNJhMVD7ERP
         K9V8MT+Yc4Lq/3nag2yM/JeWTsho+9g4FrTOGbRky9Q9RqdU1xwnsppHmrsun09mOerS
         kMowLrHCAmgD+XkVAbkztaPj5IcQduwXLzhAMJpWRIFxnJbkLmqjma5JpLwl5pA+91rU
         IJZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=tLAbhc9hG8hMeoi+bM5VQG65H4Ga6azIRDdsWGwXFug=;
        b=hV7RAW1RitBEw+gPSBh2K3zi5igtCgqkeYFS864Ozm25ZTCD7UIDw/g8ms9m5oKuCp
         894+8XiPzAL+FwMBV8nki86Fer0tuPbfBgpy5Tjgg+yKpTLZ6kcm9s9Ch9Lk+PDt4q/H
         NE75XL9DUHhVMxmBvAslUv5PbYLIfy9TiyZCjHGUh2tAOgpHQSZpIjQrc2OAqPJEFDg4
         15w8V6iCZm0ee+JoisPm6au5pYBfj72b8UMx5jO3j6AiDrdT1jBs1j2DX2Z4+JoZQ3lS
         cY+C+WBkfovWSNho7zFSaxMbF+t3jhaA0KwNtt3VRQepGHGaPdSKNOu2re4spORhfTQq
         FIXg==
X-Gm-Message-State: AOAM53346ip7Bvul8zARpeJaHdyFAKlABV19it2iRNaZ0EVnnMspRpwF
        4sQZuhXwduxsRLtKWBcnx9I=
X-Google-Smtp-Source: ABdhPJxNsFEUb5hcLJGgCHMImrPXc+7mZILZP92Ju/tLjaTX5HlhjFwnIXS/u7MCi6LlfNGJVKJXHg==
X-Received: by 2002:a4a:9bde:: with SMTP id b30mr1685783ook.82.1600745212535;
        Mon, 21 Sep 2020 20:26:52 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w20sm6467851otk.24.2020.09.21.20.26.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Sep 2020 20:26:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 21 Sep 2020 20:26:51 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, bp@alien8.de, x86@kernel.org,
        tony.luck@intel.com, lenb@kernel.org, daniel.lezcano@linaro.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, ulf.hansson@linaro.org,
        paulmck@kernel.org, tglx@linutronix.de, naresh.kamboju@linaro.org
Subject: Re: [RFC][PATCH 1/4] acpi: Use CPUIDLE_FLAG_TIMER_STOP
Message-ID: <20200922032651.GA222679@roeck-us.net>
References: <20200915103157.345404192@infradead.org>
 <20200915103806.280265587@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915103806.280265587@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Sep 15, 2020 at 12:31:58PM +0200, Peter Zijlstra wrote:
> Make acpi_processor_idle use the common broadcast code, there's no
> reason not to. This also removes some RCU usage after
> rcu_idle_enter().
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reported-by: Borislav Petkov <bp@suse.de>
> Tested-by: Borislav Petkov <bp@suse.de>
> ---
>  drivers/acpi/processor_idle.c |   49 +++++++++++++-----------------------------
>  1 file changed, 16 insertions(+), 33 deletions(-)
> 
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -161,18 +161,10 @@ static void lapic_timer_propagate_broadc
>  }
>  
>  /* Power(C) State timer broadcast control */
> -static void lapic_timer_state_broadcast(struct acpi_processor *pr,
> -				       struct acpi_processor_cx *cx,
> -				       int broadcast)
> -{
> -	int state = cx - pr->power.states;
> -
> -	if (state >= pr->power.timer_broadcast_on_state) {
> -		if (broadcast)
> -			tick_broadcast_enter();
> -		else
> -			tick_broadcast_exit();
> -	}
> +static bool lapic_timer_needs_broadcast(struct acpi_processor *pr,
> +					struct acpi_processor_cx *cx)
> +{
> +	return cx - pr->power.states >= pr->power.timer_broadcast_on_state;
>  }
>  
>  #else
> @@ -180,9 +172,9 @@ static void lapic_timer_state_broadcast(
>  static void lapic_timer_check_state(int state, struct acpi_processor *pr,
>  				   struct acpi_processor_cx *cstate) { }
>  static void lapic_timer_propagate_broadcast(struct acpi_processor *pr) { }
> -static void lapic_timer_state_broadcast(struct acpi_processor *pr,
> -				       struct acpi_processor_cx *cx,
> -				       int broadcast)
> +
> +static bool lapic_timer_needs_broadcast(struct acpi_processor *pr,
> +					struct acpi_processor_cx *cx)
>  {
>  }

drivers/acpi/processor_idle.c: In function 'lapic_timer_needs_broadcast':
drivers/acpi/processor_idle.c:179:1: warning: no return statement in function returning non-void [-Wreturn-type]

Should this return true or false ?

Guenter

>  
> @@ -568,21 +560,13 @@ static DEFINE_RAW_SPINLOCK(c3_lock);
>   * acpi_idle_enter_bm - enters C3 with proper BM handling
>   * @pr: Target processor
>   * @cx: Target state context
> - * @timer_bc: Whether or not to change timer mode to broadcast
>   */
>  static void acpi_idle_enter_bm(struct acpi_processor *pr,
> -			       struct acpi_processor_cx *cx, bool timer_bc)
> +			       struct acpi_processor_cx *cx)
>  {
>  	acpi_unlazy_tlb(smp_processor_id());
>  
>  	/*
> -	 * Must be done before busmaster disable as we might need to
> -	 * access HPET !
> -	 */
> -	if (timer_bc)
> -		lapic_timer_state_broadcast(pr, cx, 1);
> -
> -	/*
>  	 * disable bus master
>  	 * bm_check implies we need ARB_DIS
>  	 * bm_control implies whether we can do ARB_DIS
> @@ -609,9 +593,6 @@ static void acpi_idle_enter_bm(struct ac
>  		c3_cpu_count--;
>  		raw_spin_unlock(&c3_lock);
>  	}
> -
> -	if (timer_bc)
> -		lapic_timer_state_broadcast(pr, cx, 0);
>  }
>  
>  static int acpi_idle_enter(struct cpuidle_device *dev,
> @@ -630,7 +611,7 @@ static int acpi_idle_enter(struct cpuidl
>  			cx = per_cpu(acpi_cstate[index], dev->cpu);
>  		} else if (cx->type == ACPI_STATE_C3 && pr->flags.bm_check) {
>  			if (cx->bm_sts_skip || !acpi_idle_bm_check()) {
> -				acpi_idle_enter_bm(pr, cx, true);
> +				acpi_idle_enter_bm(pr, cx);
>  				return index;
>  			} else if (drv->safe_state_index >= 0) {
>  				index = drv->safe_state_index;
> @@ -642,15 +623,11 @@ static int acpi_idle_enter(struct cpuidl
>  		}
>  	}
>  
> -	lapic_timer_state_broadcast(pr, cx, 1);
> -
>  	if (cx->type == ACPI_STATE_C3)
>  		ACPI_FLUSH_CPU_CACHE();
>  
>  	acpi_idle_do_entry(cx);
>  
> -	lapic_timer_state_broadcast(pr, cx, 0);
> -
>  	return index;
>  }
>  
> @@ -666,7 +643,7 @@ static int acpi_idle_enter_s2idle(struct
>  			return 0;
>  
>  		if (pr->flags.bm_check) {
> -			acpi_idle_enter_bm(pr, cx, false);
> +			acpi_idle_enter_bm(pr, cx);
>  			return 0;
>  		} else {
>  			ACPI_FLUSH_CPU_CACHE();
> @@ -682,6 +659,7 @@ static int acpi_processor_setup_cpuidle_
>  {
>  	int i, count = ACPI_IDLE_STATE_START;
>  	struct acpi_processor_cx *cx;
> +	struct cpuidle_state *state;
>  
>  	if (max_cstate == 0)
>  		max_cstate = 1;
> @@ -694,6 +672,11 @@ static int acpi_processor_setup_cpuidle_
>  
>  		per_cpu(acpi_cstate[count], dev->cpu) = cx;
>  
> +		if (lapic_timer_needs_broadcast(pr, cx)) {
> +			state = &acpi_idle_driver.states[count];
> +			state->flags |= CPUIDLE_FLAG_TIMER_STOP;
> +		}
> +
>  		count++;
>  		if (count == CPUIDLE_STATE_MAX)
>  			break;
