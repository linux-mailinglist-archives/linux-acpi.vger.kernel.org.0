Return-Path: <linux-acpi+bounces-20585-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDiaOBN+c2mQwwAAu9opvQ
	(envelope-from <linux-acpi+bounces-20585-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Jan 2026 14:56:35 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B8D76863
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Jan 2026 14:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 003A7303A866
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Jan 2026 13:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30732DECB2;
	Fri, 23 Jan 2026 13:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="heSDTkc5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E39A1CAA68;
	Fri, 23 Jan 2026 13:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769176571; cv=none; b=gxSakSY74LI3UCMp9IaUb+VLw51RlPXJVPYVaLyEe+UGvKSIjzBS1TrUCi2TjAEQasV3+vAaWsLoZ2yHwPoE5nTDpD9Ot+h4f+FU/S/UaWmUIS+ZlRoHPAnqL89y2EGmHR2odeXgGy97IUIPZkV0swUdCKTinK87ZJrGOn1Wong=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769176571; c=relaxed/simple;
	bh=QSOx2eE67HzDrrswbsxCRfzJN1fJujSWWNEDMVmEFjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ON5iWbUjeYz9q+39+R9Y67uPK2rNN9zwiwzfTeD5ySOFMlerO6QjB61a93P+BXEaBg9bQyIboivV/IYOGe+4KWt5HLBvjMZCqwamPUBMoLcf1BVUEFIJFHnzT9I5vu39nJsnn8LNS4TlGEYnJcCCcSV1NzLItHPcbME7+AevPKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=heSDTkc5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7AA1C4CEF1;
	Fri, 23 Jan 2026 13:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769176571;
	bh=QSOx2eE67HzDrrswbsxCRfzJN1fJujSWWNEDMVmEFjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=heSDTkc5XrJ7Na+T8tlMn5nwZKCULjgQ645sRwxTS1pd6Q3cakd6pU1aUFZndI6/V
	 Umdg53G84uMgHYOkOVEmgl/qESMYRxOn0g3VtxBdW1amQWxYC/TAPwXb/QNzYu8Jn2
	 kf7kb/rK8R0yzkc30d+XkNgkki9UVx4iycoNHDRlHXbdrgauT0N0JYIfBm6515znwC
	 qpVkQDhT+PsVkzPXmB54HdmQX2gd4l06HC2VnqOPA7ze6sHECqVcZPWJxFOErq+Wga
	 /rdjfQBKTMPQZfCdlgKYK5gXHVGHUsbaZXT43C3EUki5WTqiGxImhXtLAqBCqEViTa
	 DJoqEKhoZNZfA==
Date: Fri, 23 Jan 2026 14:56:08 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [rafael-pm:bleeding-edge 175/176] ERROR: modpost:
 "tick_nohz_enabled" [drivers/cpufreq/cpufreq_ondemand.ko] undefined!
Message-ID: <aXN9-KrR0YyC7YDV@localhost.localdomain>
References: <202601231505.4Q8tb33s-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202601231505.4Q8tb33s-lkp@intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20585-lists,linux-acpi=lfdr.de];
	SUBJECT_ENDS_EXCLAIM(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[frederic@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linaro.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,localhost.localdomain:mid,01.org:url]
X-Rspamd-Queue-Id: 69B8D76863
X-Rspamd-Action: no action

Le Fri, Jan 23, 2026 at 03:37:07PM +0800, kernel test robot a écrit :
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
> head:   8a22b02a1427ff0eab01a1b7cd62355238ba3d5b
> commit: cc85c350babcb86c65da5393532f1cb255c750bc [175/176] cpufreq: ondemand: Simplify idle cputime granularity test
> config: i386-buildonly-randconfig-002-20260123 (https://download.01.org/0day-ci/archive/20260123/202601231505.4Q8tb33s-lkp@intel.com/config)
> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260123/202601231505.4Q8tb33s-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202601231505.4Q8tb33s-lkp@intel.com/
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
> >> ERROR: modpost: "tick_nohz_enabled" [drivers/cpufreq/cpufreq_ondemand.ko] undefined!
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

Right...

Is it better with this replacement?

---
From: Frederic Weisbecker <frederic@kernel.org>
Date: Wed, 7 Jan 2026 17:25:09 +0100
Subject: [PATCH] cpufreq: ondemand: Simplify idle cputime granularity test

cpufreq calls get_cpu_idle_time_us() just to know if idle cputime
accounting has a nanoseconds granularity.

Use the appropriate indicator instead to make that deduction.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
---
 drivers/cpufreq/cpufreq_ondemand.c | 7 +------
 include/linux/tick.h               | 1 +
 kernel/time/hrtimer.c              | 2 +-
 kernel/time/tick-internal.h        | 2 --
 kernel/time/tick-sched.c           | 8 +++++++-
 kernel/time/timer.c                | 2 +-
 6 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index a6ecc203f7b7..bb7db82930e4 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -334,17 +334,12 @@ static void od_free(struct policy_dbs_info *policy_dbs)
 static int od_init(struct dbs_data *dbs_data)
 {
 	struct od_dbs_tuners *tuners;
-	u64 idle_time;
-	int cpu;
 
 	tuners = kzalloc(sizeof(*tuners), GFP_KERNEL);
 	if (!tuners)
 		return -ENOMEM;
 
-	cpu = get_cpu();
-	idle_time = get_cpu_idle_time_us(cpu, NULL);
-	put_cpu();
-	if (idle_time != -1ULL) {
+	if (tick_nohz_is_active()) {
 		/* Idle micro accounting is supported. Use finer thresholds */
 		dbs_data->up_threshold = MICRO_FREQUENCY_UP_THRESHOLD;
 	} else {
diff --git a/include/linux/tick.h b/include/linux/tick.h
index ac76ae9fa36d..fe7f51451ba1 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -126,6 +126,7 @@ enum tick_dep_bits {
 
 #ifdef CONFIG_NO_HZ_COMMON
 extern bool tick_nohz_enabled;
+extern bool tick_nohz_is_active(void);
 extern bool tick_nohz_tick_stopped(void);
 extern bool tick_nohz_tick_stopped_cpu(int cpu);
 extern void tick_nohz_idle_stop_tick(void);
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index f8ea8c8fc895..e1bbf883dfa8 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -943,7 +943,7 @@ void clock_was_set(unsigned int bases)
 	cpumask_var_t mask;
 	int cpu;
 
-	if (!hrtimer_hres_active(cpu_base) && !tick_nohz_active)
+	if (!hrtimer_hres_active(cpu_base) && !tick_nohz_is_active())
 		goto out_timerfd;
 
 	if (!zalloc_cpumask_var(&mask, GFP_KERNEL)) {
diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index 4e4f7bbe2a64..597d816d22e8 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -156,7 +156,6 @@ static inline void tick_nohz_init(void) { }
 #endif
 
 #ifdef CONFIG_NO_HZ_COMMON
-extern unsigned long tick_nohz_active;
 extern void timers_update_nohz(void);
 extern u64 get_jiffies_update(unsigned long *basej);
 # ifdef CONFIG_SMP
@@ -171,7 +170,6 @@ extern void timer_expire_remote(unsigned int cpu);
 # endif
 #else /* CONFIG_NO_HZ_COMMON */
 static inline void timers_update_nohz(void) { }
-#define tick_nohz_active (0)
 #endif
 
 DECLARE_PER_CPU(struct hrtimer_cpu_base, hrtimer_bases);
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 21ac561a8545..81c619bf662c 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -691,7 +691,7 @@ void __init tick_nohz_init(void)
  * NO HZ enabled ?
  */
 bool tick_nohz_enabled __read_mostly  = true;
-unsigned long tick_nohz_active  __read_mostly;
+static unsigned long tick_nohz_active  __read_mostly;
 /*
  * Enable / Disable tickless mode
  */
@@ -702,6 +702,12 @@ static int __init setup_tick_nohz(char *str)
 
 __setup("nohz=", setup_tick_nohz);
 
+bool tick_nohz_is_active(void)
+{
+	return tick_nohz_active;
+}
+EXPORT_SYMBOL_GPL(tick_nohz_is_active);
+
 bool tick_nohz_tick_stopped(void)
 {
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 1f2364126894..7e1e3bde6b8b 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -281,7 +281,7 @@ DEFINE_STATIC_KEY_FALSE(timers_migration_enabled);
 
 static void timers_update_migration(void)
 {
-	if (sysctl_timer_migration && tick_nohz_active)
+	if (sysctl_timer_migration && tick_nohz_is_active())
 		static_branch_enable(&timers_migration_enabled);
 	else
 		static_branch_disable(&timers_migration_enabled);
-- 
2.51.1



