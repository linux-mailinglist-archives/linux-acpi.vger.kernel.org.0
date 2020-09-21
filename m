Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D77271EC5
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Sep 2020 11:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgIUJSc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 21 Sep 2020 05:18:32 -0400
Received: from mout.gmx.net ([212.227.17.20]:54301 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbgIUJSc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 21 Sep 2020 05:18:32 -0400
X-Greylist: delayed 319 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Sep 2020 05:18:30 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600679910;
        bh=THBAV1c5TBsj3wC0AH3Sfvy3cUJwveAFoGq0ZItq2qE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:References:Date:In-Reply-To;
        b=JCvTIKcyjNl8GTOyiWeKJQ3kQ8B75bFe9TMtLZxnvUaUHhtnbplH99orqvtdiAqMG
         6pRuQicMF/NKBco7ft4rSZeEq4KCI0bXAyFBMvW9L55bLRC93O0/WpLO2KiFtnn9uE
         NVIsT0iw951hoIXHyJxtGKCrxA7n7eBhL+o8pfX4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.223.47.29]) by mail.gmx.com
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MO9z7-1k56Xl185B-00OVoF; Mon, 21 Sep 2020 11:12:36 +0200
Received: by localhost.localdomain (Postfix, from userid 1000)
        id 4A385800D6; Mon, 21 Sep 2020 11:12:33 +0200 (CEST)
From:   Sven Joachim <svenjoac@gmx.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, bp@alien8.de, x86@kernel.org,
        tony.luck@intel.com, lenb@kernel.org, daniel.lezcano@linaro.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, ulf.hansson@linaro.org,
        paulmck@kernel.org, tglx@linutronix.de, naresh.kamboju@linaro.org
Subject: Re: [RFC][PATCH 4/4] acpi: Take over RCU-idle for C3-BM idle
References: <20200915103157.345404192@infradead.org>
        <20200915103806.479637218@infradead.org>
Date:   Mon, 21 Sep 2020 11:12:33 +0200
In-Reply-To: <20200915103806.479637218@infradead.org> (Peter Zijlstra's
        message of "Tue, 15 Sep 2020 12:32:01 +0200")
Message-ID: <87wo0npk72.fsf@turtle.gmx.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Provags-ID: V03:K1:LU+6Naa2RzvxoQM+fppTiSPWilBwOe+Amx4l9CtgODZ8kFQhAQC
 RuTwDg2hz43cWNG4BL235PNVfLnBNRrmkBVLwL6vueULxrj1L05LZ7Y3bnnI5C6eX4pI8bm
 uw2MCH2RifQNTjYiHBscDiVY+k5vqPr7y1dle7ivjjQn3Cri30DRF0ZjBB20UMH02JaKAut
 /gJ3ntQ5xb67GO/v0Qb/A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:KGXbZlySef0=:jL0sHATM2RcmZJEZ+Rvyas
 cg/SyE4EqynHhscpoYmD76dcUn8BfLz/8oJMNV4w/wriqZvlcTzxm6sWTuoTE0/fa92zkyxDY
 /mBs6ojff3CcnXe8yfILabAay1vcsilPfuSNRC9xCcUHD3Sn3XXsKtRWPB/xiKh6Ze2BubXQF
 N/c0G89dIBFS/FEXpoV/ysLweSK7Cp/juXnVRgbgk1mDViW81GJjXoK+bt/oPDvc5StLNAKXM
 2yZhCuFPuwM9y2ZpekM9HqwjO3xwJLJZOh7dlQh6D1eZQEms7Lyu2YNAggObAiwSHPv5KlUOe
 WfZQSwKrK/ekNP1VK2mla751nhx1n8p7esYegzml7dekF5wOc3hIeDuEO1DWcQlSgmHojm80+
 R8JXmqCMKlG0nXg6TAqpKzY4+Ezg+88gh3dzeY3NNeKRI8i03TKWIvLCI6tsjAllDU77CYdGX
 JxtLWmHmQZ+cfhe1hAyojru9G/Fnwr8wmzHvJjIJywGAFmiGHiiV7fFy2/124MMzKuRoWLK+a
 57UOjw7tlAWmIhGsULZgYxY2o8Ya6X40KuPbrqa2z2QhKzS/owv+nu0u8uDnMUiGsAMZZR2gk
 Ztq3O5mmmqS055AE5QjHepAy8KwwttVeKZQPEYpVIP6whE83rqCXqvw5wrpd+OfPoZkIrwQom
 swVlmss2MvIj1/UN6qO/mBUkOMdpMffSTBa8jWI+K/36Vi1FLc2poIOHuZh0agN7S0iCLWTqL
 bgqdaN4FUJTpJ4IbVI+EdAx+o8FEigw/pLKp4Xp+E/FiN7nE/uf7kZEMLN5TQ/qVxF7jMYfhm
 hLM3OI5Qruf3cpGim0uE5gA7qxUELCcXLFusYFA2pmty1zmPoCRMT1HWEuymjQvkcKzzTsuGR
 YGzjW1Iic64u5hHpsuYLN6+C4YoBuQ+PQEShHmjqfwiKXVXn0kvBEi4fDzXfyKAYj8mYkzpr1
 tKPUie/vBGx4919SIj2IUrcJUUiY9f1oaqwjG3w3FbTSzPKOM0A46b51TlkFVa3roSdg1QBXn
 BVMSwgASLmIp8R/TV5doMwuqa1enCZ2lSlJKBMvXNHrl/Lrha6LGew7QzguP6Dxdx5GindYQR
 0UVIocRYrn1LOmriVe96WmUoysLyaJ9FdUlOigfIj57ZZOJr/S9VHczJK3lTimewZnhon2pec
 wHrRx+4Ihvf1oP7xkxaqPk4QbWFVRuxAeopV3F3YbApL+mIDiSBe/jyl84/U1GD9rqWmAHELf
 TCNCHCbdkJ/qTk6hh
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020-09-15 12:32 +0200, Peter Zijlstra wrote:

> The C3 BusMaster idle code takes lock in a number of places, some deep
> inside the ACPI code. Instead of wrapping it all in RCU_NONIDLE, have
> the driver take over RCU-idle duty and avoid flipping RCU state back
> and forth a lot.
>
> ( by marking 'C3 && bm_check' as RCU_IDLE, we _must_ call enter_bm() for
>   that combination, otherwise we'll loose RCU-idle, this requires
>   shuffling some code around )
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

I got modpost errors in 5.9-rc6 after this patch:

ERROR: modpost: "rcu_idle_enter" [drivers/acpi/processor.ko] undefined!
ERROR: modpost: "rcu_idle_exit" [drivers/acpi/processor.ko] undefined!

Reverting commit 1fecfdbb7acc made them go away.  Notably my
configuration had CONFIG_ACPI_PROCESSOR=3Dm,  changing that
to CONFIG_ACPI_PROCESSOR=3Dy let the build succeed as well.

Cheers,
       Sven

> ---
>  drivers/acpi/processor_idle.c |   69 +++++++++++++++++++++++++++++-----=
--------
>  1 file changed, 49 insertions(+), 20 deletions(-)
>
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -558,22 +558,43 @@ static DEFINE_RAW_SPINLOCK(c3_lock);
>
>  /**
>   * acpi_idle_enter_bm - enters C3 with proper BM handling
> + * @drv: cpuidle driver
>   * @pr: Target processor
>   * @cx: Target state context
> + * @index: index of target state
>   */
> -static void acpi_idle_enter_bm(struct acpi_processor *pr,
> -			       struct acpi_processor_cx *cx)
> +static int acpi_idle_enter_bm(struct cpuidle_driver *drv,
> +			       struct acpi_processor *pr,
> +			       struct acpi_processor_cx *cx,
> +			       int index)
>  {
> +	static struct acpi_processor_cx safe_cx =3D {
> +		.entry_method =3D ACPI_CSTATE_HALT,
> +	};
> +
>  	/*
>  	 * disable bus master
>  	 * bm_check implies we need ARB_DIS
>  	 * bm_control implies whether we can do ARB_DIS
>  	 *
> -	 * That leaves a case where bm_check is set and bm_control is
> -	 * not set. In that case we cannot do much, we enter C3
> -	 * without doing anything.
> +	 * That leaves a case where bm_check is set and bm_control is not set.
> +	 * In that case we cannot do much, we enter C3 without doing anything.
>  	 */
> -	if (pr->flags.bm_control) {
> +	bool dis_bm =3D pr->flags.bm_control;
> +
> +	/* If we can skip BM, demote to a safe state. */
> +	if (!cx->bm_sts_skip && acpi_idle_bm_check()) {
> +		dis_bm =3D false;
> +		index =3D drv->safe_state_index;
> +		if (index >=3D 0) {
> +			cx =3D this_cpu_read(acpi_cstate[index]);
> +		} else {
> +			cx =3D &safe_cx;
> +			index =3D -EBUSY;
> +		}
> +	}
> +
> +	if (dis_bm) {
>  		raw_spin_lock(&c3_lock);
>  		c3_cpu_count++;
>  		/* Disable bus master arbitration when all CPUs are in C3 */
> @@ -582,15 +603,21 @@ static void acpi_idle_enter_bm(struct ac
>  		raw_spin_unlock(&c3_lock);
>  	}
>
> +	rcu_idle_enter();
> +
>  	acpi_idle_do_entry(cx);
>
> +	rcu_idle_exit();
> +
>  	/* Re-enable bus master arbitration */
> -	if (pr->flags.bm_control) {
> +	if (dis_bm) {
>  		raw_spin_lock(&c3_lock);
>  		acpi_write_bit_register(ACPI_BITREG_ARB_DISABLE, 0);
>  		c3_cpu_count--;
>  		raw_spin_unlock(&c3_lock);
>  	}
> +
> +	return index;
>  }
>
>  static int acpi_idle_enter(struct cpuidle_device *dev,
> @@ -604,20 +631,13 @@ static int acpi_idle_enter(struct cpuidl
>  		return -EINVAL;
>
>  	if (cx->type !=3D ACPI_STATE_C1) {
> +		if (cx->type =3D=3D ACPI_STATE_C3 && pr->flags.bm_check)
> +			return acpi_idle_enter_bm(drv, pr, cx, index);
> +
> +		/* C2 to C1 demotion. */
>  		if (acpi_idle_fallback_to_c1(pr) && num_online_cpus() > 1) {
>  			index =3D ACPI_IDLE_STATE_START;
>  			cx =3D per_cpu(acpi_cstate[index], dev->cpu);
> -		} else if (cx->type =3D=3D ACPI_STATE_C3 && pr->flags.bm_check) {
> -			if (cx->bm_sts_skip || !acpi_idle_bm_check()) {
> -				acpi_idle_enter_bm(pr, cx);
> -				return index;
> -			} else if (drv->safe_state_index >=3D 0) {
> -				index =3D drv->safe_state_index;
> -				cx =3D per_cpu(acpi_cstate[index], dev->cpu);
> -			} else {
> -				acpi_safe_halt();
> -				return -EBUSY;
> -			}
>  		}
>  	}
>
> @@ -641,7 +661,13 @@ static int acpi_idle_enter_s2idle(struct
>  			return 0;
>
>  		if (pr->flags.bm_check) {
> -			acpi_idle_enter_bm(pr, cx);
> +			u8 bm_sts_skip =3D cx->bm_sts_skip;
> +
> +			/* Don't check BM_STS, do an unconditional ARB_DIS for S2IDLE */
> +			cx->bm_sts_skip =3D 1;
> +			acpi_idle_enter_bm(drv, pr, cx, index);
> +			cx->bm_sts_skip =3D bm_sts_skip;
> +
>  			return 0;
>  		} else {
>  			ACPI_FLUSH_CPU_CACHE();
> @@ -674,8 +700,11 @@ static int acpi_processor_setup_cpuidle_
>  		if (lapic_timer_needs_broadcast(pr, cx))
>  			state->flags |=3D CPUIDLE_FLAG_TIMER_STOP;
>
> -		if (cx->type =3D=3D ACPI_STATE_C3)
> +		if (cx->type =3D=3D ACPI_STATE_C3) {
>  			state->flags |=3D CPUIDLE_FLAG_TLB_FLUSHED;
> +			if (pr->flags.bm_check)
> +				state->flags |=3D CPUIDLE_FLAG_RCU_IDLE;
> +		}
>
>  		count++;
>  		if (count =3D=3D CPUIDLE_STATE_MAX)
