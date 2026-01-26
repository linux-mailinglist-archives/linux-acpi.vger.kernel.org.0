Return-Path: <linux-acpi+bounces-20634-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHlYEbvLd2lylAEAu9opvQ
	(envelope-from <linux-acpi+bounces-20634-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 21:16:59 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C0C8CF43
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 21:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F9543017529
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 20:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300E62D3A75;
	Mon, 26 Jan 2026 20:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgDV8Qd6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1C91DE8AE;
	Mon, 26 Jan 2026 20:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769458615; cv=none; b=cvxv9M+cZ+fQ91HALdDo4sVhkm9FeY1TJrcjnUWUSTyKUbtLLqQCPd8W0Wgov4g6RVgOdYiNMLxcsIvJKzBDqk28i2PaLKeHXT2l4VkOxmUhddqHZgp8T9aOmjIutK4SpSLXBj4zfbKU9plTRtw+HZrXvG5opg+1h9OcyHlQIMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769458615; c=relaxed/simple;
	bh=jDTJt28eS0OoJ53PsZXeEECWkT1UGi1eT3ZMSzGB25M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tefQNQaf5/kdwUCTs64fO3Y7srpBxaJR24EuSkjlytnCTgCA3q5U/jW1o3VJKRa5IMoDahkAgzHZ128KpIr1jFwLjau1qIKeiUGXZTVeB7y2qoyBcuYnXr07fqV7Ojdu9kKCikwrYWlB/xEZRckrlnWNPBKeVBmoVLQKtA5ergA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgDV8Qd6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01506C116C6;
	Mon, 26 Jan 2026 20:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769458614;
	bh=jDTJt28eS0OoJ53PsZXeEECWkT1UGi1eT3ZMSzGB25M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kgDV8Qd6nYF8zBFQPhFHXo8DLxGwM1sFByWRSjdf2B4nK8GHyILToDsGWcS2sbgSJ
	 WypEHy8Ic5kMPpX/hS437eVpNKOx7tSI8mEE11fm8cRkvCcrTgFWCkGz+6Rsbj4TrB
	 xTHCWj7tg9tXwPu4WZHGeKSlHDr7CT6TCJucpPXy1kyydP+wocvh7J8zz2i4VUGgOK
	 gKZ00hQchg9jSWBqNAWSusenBje3lcIVDUAsoTB2Y5FQ1VqLlsd5fUYfMS4VXPwNMR
	 IvFVt1LZO7vLmcxVqYof+g4OR/d1c+Mil2tJNpxcy8CehyGidmRZSzW1waoRzY7axf
	 SLrz9kJMPA0Nw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: kernel test robot <lkp@intel.com>,
 Frederic Weisbecker <frederic@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject:
 Re: [rafael-pm:bleeding-edge 175/176] ERROR: modpost: "tick_nohz_enabled"
 [drivers/cpufreq/cpufreq_ondemand.ko] undefined!
Date: Mon, 26 Jan 2026 21:16:49 +0100
Message-ID: <4709230.LvFx2qVVIh@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <aXN9-KrR0YyC7YDV@localhost.localdomain>
References:
 <202601231505.4Q8tb33s-lkp@intel.com>
 <aXN9-KrR0YyC7YDV@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20634-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	SUBJECT_ENDS_EXCLAIM(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rafael.j.wysocki:mid,01.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linaro.org:email,intel.com:email]
X-Rspamd-Queue-Id: A9C0C8CF43
X-Rspamd-Action: no action

On Friday, January 23, 2026 2:56:08 PM CET Frederic Weisbecker wrote:
> Le Fri, Jan 23, 2026 at 03:37:07PM +0800, kernel test robot a =C3=A9crit :
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
=2Egit bleeding-edge
> > head:   8a22b02a1427ff0eab01a1b7cd62355238ba3d5b
> > commit: cc85c350babcb86c65da5393532f1cb255c750bc [175/176] cpufreq: ond=
emand: Simplify idle cputime granularity test
> > config: i386-buildonly-randconfig-002-20260123 (https://download.01.org=
/0day-ci/archive/20260123/202601231505.4Q8tb33s-lkp@intel.com/config)
> > compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/arc=
hive/20260123/202601231505.4Q8tb33s-lkp@intel.com/reproduce)
> >=20
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202601231505.4Q8tb33s-l=
kp@intel.com/
> >=20
> > All errors (new ones prefixed by >>, old ones prefixed by <<):
> >=20
> > >> ERROR: modpost: "tick_nohz_enabled" [drivers/cpufreq/cpufreq_ondeman=
d.ko] undefined!
> >=20
>=20
> Right...
>=20
> Is it better with this replacement?

It is still failing the build.

I'll fix it up tomorrow.

> ---
> From: Frederic Weisbecker <frederic@kernel.org>
> Date: Wed, 7 Jan 2026 17:25:09 +0100
> Subject: [PATCH] cpufreq: ondemand: Simplify idle cputime granularity test
>=20
> cpufreq calls get_cpu_idle_time_us() just to know if idle cputime
> accounting has a nanoseconds granularity.
>=20
> Use the appropriate indicator instead to make that deduction.
>=20
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm@vger.kernel.org
> ---
>  drivers/cpufreq/cpufreq_ondemand.c | 7 +------
>  include/linux/tick.h               | 1 +
>  kernel/time/hrtimer.c              | 2 +-
>  kernel/time/tick-internal.h        | 2 --
>  kernel/time/tick-sched.c           | 8 +++++++-
>  kernel/time/timer.c                | 2 +-
>  6 files changed, 11 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq=
_ondemand.c
> index a6ecc203f7b7..bb7db82930e4 100644
> --- a/drivers/cpufreq/cpufreq_ondemand.c
> +++ b/drivers/cpufreq/cpufreq_ondemand.c
> @@ -334,17 +334,12 @@ static void od_free(struct policy_dbs_info *policy_=
dbs)
>  static int od_init(struct dbs_data *dbs_data)
>  {
>  	struct od_dbs_tuners *tuners;
> -	u64 idle_time;
> -	int cpu;
> =20
>  	tuners =3D kzalloc(sizeof(*tuners), GFP_KERNEL);
>  	if (!tuners)
>  		return -ENOMEM;
> =20
> -	cpu =3D get_cpu();
> -	idle_time =3D get_cpu_idle_time_us(cpu, NULL);
> -	put_cpu();
> -	if (idle_time !=3D -1ULL) {
> +	if (tick_nohz_is_active()) {
>  		/* Idle micro accounting is supported. Use finer thresholds */
>  		dbs_data->up_threshold =3D MICRO_FREQUENCY_UP_THRESHOLD;
>  	} else {
> diff --git a/include/linux/tick.h b/include/linux/tick.h
> index ac76ae9fa36d..fe7f51451ba1 100644
> --- a/include/linux/tick.h
> +++ b/include/linux/tick.h
> @@ -126,6 +126,7 @@ enum tick_dep_bits {
> =20
>  #ifdef CONFIG_NO_HZ_COMMON
>  extern bool tick_nohz_enabled;
> +extern bool tick_nohz_is_active(void);
>  extern bool tick_nohz_tick_stopped(void);
>  extern bool tick_nohz_tick_stopped_cpu(int cpu);
>  extern void tick_nohz_idle_stop_tick(void);
> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> index f8ea8c8fc895..e1bbf883dfa8 100644
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -943,7 +943,7 @@ void clock_was_set(unsigned int bases)
>  	cpumask_var_t mask;
>  	int cpu;
> =20
> -	if (!hrtimer_hres_active(cpu_base) && !tick_nohz_active)
> +	if (!hrtimer_hres_active(cpu_base) && !tick_nohz_is_active())
>  		goto out_timerfd;
> =20
>  	if (!zalloc_cpumask_var(&mask, GFP_KERNEL)) {
> diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
> index 4e4f7bbe2a64..597d816d22e8 100644
> --- a/kernel/time/tick-internal.h
> +++ b/kernel/time/tick-internal.h
> @@ -156,7 +156,6 @@ static inline void tick_nohz_init(void) { }
>  #endif
> =20
>  #ifdef CONFIG_NO_HZ_COMMON
> -extern unsigned long tick_nohz_active;
>  extern void timers_update_nohz(void);
>  extern u64 get_jiffies_update(unsigned long *basej);
>  # ifdef CONFIG_SMP
> @@ -171,7 +170,6 @@ extern void timer_expire_remote(unsigned int cpu);
>  # endif
>  #else /* CONFIG_NO_HZ_COMMON */
>  static inline void timers_update_nohz(void) { }
> -#define tick_nohz_active (0)
>  #endif
> =20
>  DECLARE_PER_CPU(struct hrtimer_cpu_base, hrtimer_bases);
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index 21ac561a8545..81c619bf662c 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -691,7 +691,7 @@ void __init tick_nohz_init(void)
>   * NO HZ enabled ?
>   */
>  bool tick_nohz_enabled __read_mostly  =3D true;
> -unsigned long tick_nohz_active  __read_mostly;
> +static unsigned long tick_nohz_active  __read_mostly;
>  /*
>   * Enable / Disable tickless mode
>   */
> @@ -702,6 +702,12 @@ static int __init setup_tick_nohz(char *str)
> =20
>  __setup("nohz=3D", setup_tick_nohz);
> =20
> +bool tick_nohz_is_active(void)
> +{
> +	return tick_nohz_active;
> +}
> +EXPORT_SYMBOL_GPL(tick_nohz_is_active);
> +
>  bool tick_nohz_tick_stopped(void)
>  {
>  	struct tick_sched *ts =3D this_cpu_ptr(&tick_cpu_sched);
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index 1f2364126894..7e1e3bde6b8b 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -281,7 +281,7 @@ DEFINE_STATIC_KEY_FALSE(timers_migration_enabled);
> =20
>  static void timers_update_migration(void)
>  {
> -	if (sysctl_timer_migration && tick_nohz_active)
> +	if (sysctl_timer_migration && tick_nohz_is_active())
>  		static_branch_enable(&timers_migration_enabled);
>  	else
>  		static_branch_disable(&timers_migration_enabled);
>=20





