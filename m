Return-Path: <linux-acpi+bounces-20596-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOsYDboZdGnS2AAAu9opvQ
	(envelope-from <linux-acpi+bounces-20596-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Jan 2026 02:00:42 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E2F7BD74
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Jan 2026 02:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB20B3019B90
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Jan 2026 01:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C4F2AE8D;
	Sat, 24 Jan 2026 01:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jORReJF3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A7F1FC8;
	Sat, 24 Jan 2026 01:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769216439; cv=none; b=PvL9Y/C/QdW5uMqqXjUtXqQnuuMs9oefsY0XWOMIoRyn7QAMq88UWOa3tsZJG2gmEo2nJMPpDkbncGMXnYvhKcqXwHQzKoyJndxZNvBXqKY9IhWlt9QvNX+FwuBADoDNaTpcEHW/8tXlIFKV+TLT3vIZTVT61YBtBQbKJ71JzdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769216439; c=relaxed/simple;
	bh=ePfizrVQ213T5iJJd+JPuQ1ZTHCYKYVtrij+7knwsro=;
	h=Date:From:To:Cc:Subject:Message-ID; b=hSzN3fCFMJJyQvMqPXGgY1VVKYVhVUmJrbrW8NBWD4cwI3xqOcXDlXW+V3Vb+H6LmaHk/mrL/LAI4ww9qxN4hgC0hDAKhsRxfDIkMCanP6BhsqmbFZf5rX2V0KUUswuy2GeAWNzY1LxmWPr/S2iqiA1isvRlo2/KmECWxzovfJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jORReJF3; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769216437; x=1800752437;
  h=date:from:to:cc:subject:message-id;
  bh=ePfizrVQ213T5iJJd+JPuQ1ZTHCYKYVtrij+7knwsro=;
  b=jORReJF3vU9GwJH7midGTNCZeTDS8TgkUktHC/5n0v+RJGsb7/UwSFo5
   pSEtRdRPKWJE8is6Kd75x51/U4+s93uRDoyiUMd1wV5iw4lNdK0ACTisQ
   ML8MSNkxR60Vrpp4vgKvmUmxe+VSZiNe3FqlLSWw1Q9kUt7Fz30SiFJJt
   MMMSMND7qyKkEQpDGa9D38iCidjXQnEeQbMQJPjvIVYZ7/k5qd6JZGagi
   9HKana7TjCA7rST+dIoWk0KujdIF/Xs58YPoF/WSAlwyMNcnqPJ08WlFS
   pCnh1f9OAuJ21YCs5zSDgSqtcxTUA1KcyJxCAbE8+r5Z2pWW2t6xcBe2s
   Q==;
X-CSE-ConnectionGUID: XTga3E1xQzemY6yE+1xILg==
X-CSE-MsgGUID: Q3ugYCzkQJutGAxejTJ74g==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="70369227"
X-IronPort-AV: E=Sophos;i="6.21,249,1763452800"; 
   d="scan'208";a="70369227"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 17:00:37 -0800
X-CSE-ConnectionGUID: 7Xc8IZZzQgqeL/IuBl3nFQ==
X-CSE-MsgGUID: PY4yoz7cSmyjY6rMxT4jEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,249,1763452800"; 
   d="scan'208";a="206277537"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 23 Jan 2026 17:00:33 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vjS0t-00000000UdU-1cl5;
	Sat, 24 Jan 2026 01:00:31 +0000
Date: Sat, 24 Jan 2026 08:59:57 +0800
From: kernel test robot <lkp@intel.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [rafael-pm:bleeding-edge 172/186]
 kernel/time/hrtimer.c:946:48: error: implicit declaration of function
 'tick_nohz_is_active'; did you mean 'tick_nohz_init'?
Message-ID: <202601240853.XfwHlHep-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	SUBJECT_ENDS_QUESTION(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20596-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid,01.org:url]
X-Rspamd-Queue-Id: 43E2F7BD74
X-Rspamd-Action: no action

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   7e9b0371ed5b9bf9a80c59487f47fca0ba638f61
commit: b0d640cf14148cbce9f1651fe6028c7586291cf5 [172/186] cpufreq: ondemand: Simplify idle cputime granularity test
config: nios2-allnoconfig (https://download.01.org/0day-ci/archive/20260124/202601240853.XfwHlHep-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260124/202601240853.XfwHlHep-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601240853.XfwHlHep-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/time/hrtimer.c: In function 'clock_was_set':
>> kernel/time/hrtimer.c:946:48: error: implicit declaration of function 'tick_nohz_is_active'; did you mean 'tick_nohz_init'? [-Werror=implicit-function-declaration]
     946 |         if (!hrtimer_hres_active(cpu_base) && !tick_nohz_is_active())
         |                                                ^~~~~~~~~~~~~~~~~~~
         |                                                tick_nohz_init
   cc1: some warnings being treated as errors


vim +946 kernel/time/hrtimer.c

   925	
   926	/*
   927	 * Clock was set. This might affect CLOCK_REALTIME, CLOCK_TAI and
   928	 * CLOCK_BOOTTIME (for late sleep time injection).
   929	 *
   930	 * This requires to update the offsets for these clocks
   931	 * vs. CLOCK_MONOTONIC. When high resolution timers are enabled, then this
   932	 * also requires to eventually reprogram the per CPU clock event devices
   933	 * when the change moves an affected timer ahead of the first expiring
   934	 * timer on that CPU. Obviously remote per CPU clock event devices cannot
   935	 * be reprogrammed. The other reason why an IPI has to be sent is when the
   936	 * system is in !HIGH_RES and NOHZ mode. The NOHZ mode updates the offsets
   937	 * in the tick, which obviously might be stopped, so this has to bring out
   938	 * the remote CPU which might sleep in idle to get this sorted.
   939	 */
   940	void clock_was_set(unsigned int bases)
   941	{
   942		struct hrtimer_cpu_base *cpu_base = raw_cpu_ptr(&hrtimer_bases);
   943		cpumask_var_t mask;
   944		int cpu;
   945	
 > 946		if (!hrtimer_hres_active(cpu_base) && !tick_nohz_is_active())
   947			goto out_timerfd;
   948	
   949		if (!zalloc_cpumask_var(&mask, GFP_KERNEL)) {
   950			on_each_cpu(retrigger_next_event, NULL, 1);
   951			goto out_timerfd;
   952		}
   953	
   954		/* Avoid interrupting CPUs if possible */
   955		cpus_read_lock();
   956		for_each_online_cpu(cpu) {
   957			unsigned long flags;
   958	
   959			cpu_base = &per_cpu(hrtimer_bases, cpu);
   960			raw_spin_lock_irqsave(&cpu_base->lock, flags);
   961	
   962			if (update_needs_ipi(cpu_base, bases))
   963				cpumask_set_cpu(cpu, mask);
   964	
   965			raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
   966		}
   967	
   968		preempt_disable();
   969		smp_call_function_many(mask, retrigger_next_event, NULL, 1);
   970		preempt_enable();
   971		cpus_read_unlock();
   972		free_cpumask_var(mask);
   973	
   974	out_timerfd:
   975		timerfd_clock_was_set();
   976	}
   977	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

