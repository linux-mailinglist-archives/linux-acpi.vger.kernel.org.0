Return-Path: <linux-acpi+bounces-13799-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF6BABBE41
	for <lists+linux-acpi@lfdr.de>; Mon, 19 May 2025 14:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F39518912F0
	for <lists+linux-acpi@lfdr.de>; Mon, 19 May 2025 12:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D9C275877;
	Mon, 19 May 2025 12:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CDhe0Tti"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CEB1E1A3B;
	Mon, 19 May 2025 12:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747658906; cv=none; b=tmku2Birvf+ooBwqdHN5zUvFm0XPzBGwOxPr/ZAvkpmhpRAYqwWS4ifjmZ1sjEYNNmcEkyKBWUR2rLiPq2acWxsdqYkxnUV5DJqzffXSnqBar8SzvGRYFl0r578sw4jNmtCiCHRVWRhOksHe0Ma99ycn5YSg8hxxxHEVWXnm3Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747658906; c=relaxed/simple;
	bh=PxWZ4QhyrKgsbEoFl1OvatHk5GZQi4G9/S059phuHsA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fysn9ANChgAscGHab5UetBMnfiqz9pTFhNl5qLN5ceNMCeJvboo9bYesbLtnuz1cnub1KVRakz27qW0vD1ktFrymcrWYtXnFwZ6LfGSS83Z7zf2Q/RHQtHX/mYTy1+0qf8oDS0HMrTcMIx2Tf41+r4bL9la+FVkAFBKtagRC27s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CDhe0Tti; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747658905; x=1779194905;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=PxWZ4QhyrKgsbEoFl1OvatHk5GZQi4G9/S059phuHsA=;
  b=CDhe0TtimELFX5YlocXsiWx5ZLHjNSMkL0+YtiP8kcXcEeQFd9LNRsLq
   m0+j9Q6OHFJOB53IMeLn41XeWE0JwNU74Q8TTNRS8+TcyS7I5y06Bpjy6
   3m3IeIHX1RbvaT1Ddw+pXeLDiobUx68QVHxiEKlzBDtTW6sjLh6lcs/Tx
   tIcdPQIrM0V9nOeTzkbhIMOFGS3hDCYAEOrq/V+zfKgXzUSP0FT9WbKFu
   VFFD0f3z5YBn3X9pX0Fk6emu+juCN9DvzpAot03HN2+dg/xhzkJxNqCEi
   KTGbTSaCuXS3RbujwywvBHhavfEquNHhIfGVrNqCL9Lb/iSoG74/BNkfw
   g==;
X-CSE-ConnectionGUID: 61MSSVM3Sx+hw3Pfw7QmgQ==
X-CSE-MsgGUID: QaJDti0XRsy5sKChgyxc/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49459056"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="49459056"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 05:48:24 -0700
X-CSE-ConnectionGUID: g4RwBotARTqTTe9bxR7gWg==
X-CSE-MsgGUID: pO+I31GrQc+wiRo+lK7uRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="170392245"
Received: from spandruv-desk.jf.intel.com ([10.54.75.16])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 05:48:24 -0700
Message-ID: <3761c1edef2c431a65f5fba2c5c64a2a882060cb.camel@linux.intel.com>
Subject: Re: [BUG] intel_pstate: CPU frequencies miscalculated/incorrectly
 detected on Arrow Lake hardware
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Aaron Rainbolt <arainbolt@kfocus.org>, lenb@kernel.org, rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, 
	kernel-team@lists.ubuntu.com
Date: Mon, 19 May 2025 05:48:12 -0700
In-Reply-To: <20250517223323.6e13bf58@kf-m2g5>
References: <20250517223323.6e13bf58@kf-m2g5>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


On Sat, 2025-05-17 at 22:33 -0500, Aaron Rainbolt wrote:
> We have tested three systems with Arrow Lake CPUs, and all of them
> report incorrect max and base frequencies. Two systems have Ultra 9
> 275
> HX CPUs, and one has an Ultra 5 225 H. The problem occurs with both
> the
> Ubuntu 6.11 kernel and the 6.14.6 mainline kernel.
>=20
> How these values are misreported appears to depend on the CPU. On the
> Ultra 9 275HX systems when running Ubuntu=E2=80=99s 6.11.0-1015-oem kerne=
l,
> the
> max reported frequency on a golden core is 5000000; however, the CPU
> spec says it should be 5400000. In contrast, on an Ultra 5 225H
> system,
> the max reported frequency on a golden core is 6200000;=C2=A0 however, th=
e
> spec says it should be 4900000.=20
>=20

I think this is similar to
https://lkml.indiana.edu/2504.3/04971.html

The issue is the BIOS didn't program frequencies correctly in ACPI
CPPC. So frequency limits will be wrong.

You can dump the following values and also the details about the system
under test (OEM, model etc).

grep -r . /sys/devices/system/cpu/cpu*/acpi_cppc/*


Thanks,
Srinivas

> This bug is troublesome to end users because many CPU monitoring apps
> will report the CPU is running quite a bit slower or faster than the
> spec. Tools such as cpupower-gui, cpufreq-info, and cpufreq-set all
> show incorrect values because they read cpuinfo_max_freq and
> base_frequency, and write scaling_max_freq values in
> /sys/devices/system/cpu/cpufreq/policy* directories.=20
>=20
> The following bash script shows the incorrect values read from the
> cpuinfo_max_freq and base_frequency files. It also shows how the
> actual
> max frequencies attained are as expected. The example values shown
> come
> from an Ultra 9 275 HX CPU.
>=20
> =C2=A0=C2=A0=C2=A0 echo; echo '=3D=3D BEGIN =3D=3D';
> =C2=A0=C2=A0=C2=A0 echo 'Ensure turbo is on';
> =C2=A0=C2=A0=C2=A0 cd /sys/devices/system/cpu;
> =C2=A0=C2=A0=C2=A0 echo '0' |sudo tee intel_pstate/no_turbo > /dev/null;
> =C2=A0=C2=A0=C2=A0 if grep -q '0' intel_pstate/no_turbo; then echo 'Turbo=
 is on'; fi
>=20
> =C2=A0=C2=A0=C2=A0 echo; echo 'Find top 2 golden cores';
> =C2=A0=C2=A0=C2=A0 cd /sys/devices/system/cpu/cpufreq/;
> =C2=A0=C2=A0=C2=A0 grep . policy*/cpuinfo_max_freq \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | awk -F: '{print $2" "$1}' |sort -rn | he=
ad -n2;
> =C2=A0=C2=A0=C2=A0 #> 5000000 policy2/cpuinfo_max_freq
> =C2=A0=C2=A0=C2=A0 #> 5000000 policy3/cpuinfo_max_freq
>=20
> =C2=A0=C2=A0=C2=A0 echo; echo 'Confirm misreporting: per spec, this shoul=
d be
> 5400000!';
> =C2=A0=C2=A0=C2=A0 grep . policy2/cpuinfo_max_freq; # 500000
>=20
> =C2=A0=C2=A0=C2=A0 echo; echo 'Confirm misreporting: per spec, this shoul=
d be
> 2700000!'
> =C2=A0=C2=A0=C2=A0 grep . policy2/base_frequency; # 2500000
>=20
> =C2=A0=C2=A0=C2=A0 echo; echo '# Run a CPU benchmark now, then press [ En=
ter ] to
> see top 3 freqs.';
> =C2=A0=C2=A0=C2=A0 echo 'This will take 6 seconds to complete.';
> =C2=A0=C2=A0=C2=A0 read -r -p '# You should see that the freqs match the =
CPU specs.
> ';\=20
> =C2=A0=C2=A0=C2=A0 for i in {0..5}; do
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 grep . policy*/scaling_cur_freq | awk -F: =
'{print $2" "$1}';
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sleep 1;
> =C2=A0=C2=A0=C2=A0 done |sort -rn |head -n3=20
> =C2=A0=C2=A0=C2=A0 #> 5400000 policy2/scaling_cur_freq
> =C2=A0=C2=A0=C2=A0 #> 5320159 policy2/scaling_cur_freq
> =C2=A0=C2=A0=C2=A0 #> 5241886 policy3/scaling_cur_freq
>=20
> =C2=A0=C2=A0=C2=A0 echo; echo '=3D=3D END=C2=A0=C2=A0 =3D=3D'; echo;
>=20
> The actual results, when running the above script, shows the
> cpuinfo_max_freq and base_frequencies values do not match those
> specified by Intel. With the 6.11.0-1021-oem Ubuntu Kernel, we see
> the
> following:
>=20
> > Turbo? | Core | Freq (spec) | Freq (report) | Freq (actual) |
> > Yes=C2=A0=C2=A0=C2=A0 | P=C2=A0=C2=A0=C2=A0 | 5.4 GHz=C2=A0=C2=A0=C2=A0=
=C2=A0 | 5.0 GHz=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 5.4 GHz=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |
> > No=C2=A0=C2=A0=C2=A0=C2=A0 | P=C2=A0=C2=A0=C2=A0 | 2.7 GHz=C2=A0=C2=A0=
=C2=A0=C2=A0 | 2.5 GHz=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2.7 GHz=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > Yes=C2=A0=C2=A0=C2=A0 | E=C2=A0=C2=A0=C2=A0 | 4.6 GHz=C2=A0=C2=A0=C2=A0=
=C2=A0 | 4.6 GHz=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4.6 GHz=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |
> > No=C2=A0=C2=A0=C2=A0=C2=A0 | E=C2=A0=C2=A0=C2=A0 | 2.1 GHz=C2=A0=C2=A0=
=C2=A0=C2=A0 | 2.1 GHz=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2.1 GHz=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
>=20
> We have verified the cores are operating at their specified
> frequencies
> by running a demanding CPU benchmark while graphing frequencies with
> KDE System Monitor, on all 3 systems. This tool appeared to graph
> scaling_cur_freq values. Notice E-cores appear to be correctly
> reported. Also, all systems misinterpret values written to
> scaling_max_req with the apparent same error deltas: on the Ultra 9
> 275
> HX, setting this value to 5000000 results in actual max frequencies
> of
> 5400000. Setting it to 2500000 results in max 2700000. Setting it to
> 1650000 results in max 2100000.
>=20
> The behavior with the 6.14.6 kernel is worse than with 6.11, with all
> values under-reported. Actual frequencies were not tested on 6.14.6:
>=20
> > Turbo? | Core | Freq (spec) | Freq (report) |
> > Yes=C2=A0=C2=A0=C2=A0 | P=C2=A0=C2=A0=C2=A0 | 5.4 GHz=C2=A0=C2=A0=C2=A0=
=C2=A0 | 3.9 GHz=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > No=C2=A0=C2=A0=C2=A0=C2=A0 | P=C2=A0=C2=A0=C2=A0 | 2.7 GHz=C2=A0=C2=A0=
=C2=A0=C2=A0 | 2.0 GHz=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > Yes=C2=A0=C2=A0=C2=A0 | E=C2=A0=C2=A0=C2=A0 | 4.6 GHz=C2=A0=C2=A0=C2=A0=
=C2=A0 | 3.3 GHz=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > No=C2=A0=C2=A0=C2=A0=C2=A0 | E=C2=A0=C2=A0=C2=A0 | 2.1 GHz=C2=A0=C2=A0=
=C2=A0=C2=A0 | 1.5 GHz=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
>=20
> Is it possible the math currently used for calculating CPU
> frequencies
> is no longer correct for Arrow Lake CPUs? This seems similar to the
> issue that was fixed by commit f5c8cf2 (cpufreq: intel_pstate:
> hybrid:
> Use known scaling factor for P-cores).


