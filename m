Return-Path: <linux-acpi+bounces-15285-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 091E8B0E28C
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Jul 2025 19:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31D163B72BE
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Jul 2025 17:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A7927F749;
	Tue, 22 Jul 2025 17:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ceFrNi1k"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC9D27EC78;
	Tue, 22 Jul 2025 17:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753205103; cv=none; b=kNvJKsjbUwsWZ945chHu6WrWh7N6lDdJDzpYVqG4HueeTGnfi0xLc98PmUNuER0QTzGtPyyTUECkGcklhQh+Q0JEulWzlHJkA4Ljv+0k3475KIA8chXW3twb/0FoZPoF52O41r8ehjKvBFUctPtB2+9OMJVuBmNp2T6PA2Ft3/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753205103; c=relaxed/simple;
	bh=Pz10GjGrwbBssSWDb1PxSY6xRzltyNWVn72u1fnSTtU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hGiJpmLBlU3ysgrQITpWYWrIAy85J+08eMfgKwmr9f5oiqepvvgmVvGc/V3KjVsrClvw9MX8SxlpEnzQm57h68QTiCV6wh63qUGxj+sOpaQ0oeHHQ71lMaXkWwDuoLgTUHydbFfva7ml2CGRdqP9Pj++R2sI5hA0I4fFdufRV98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ceFrNi1k; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753205101; x=1784741101;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Pz10GjGrwbBssSWDb1PxSY6xRzltyNWVn72u1fnSTtU=;
  b=ceFrNi1kQz1IU4aRPgFA4/4k7xUek7GyDlBOG1h6Pqh0gTgIvvdQ2kVy
   B2ixlmGifAHDxUzkr5yb63ZF6B4zmoyKx465+BkQenuimwEcGyCQ0LmfK
   uGzjpLvZGabSqQNcMEi4uJK/tmsONi4MtSSYWiA82GOiM0EY0/76/TOxe
   U6rOVHkrtzDkXZsiDcqHh98kkW9801NZ0prJ2WMP3oGE19bAbpOp6aN2I
   gsNGWOtbeIksh/z039hnkEHlsznu5Uwb8RylClzehHQKatMOGh+Yje7oR
   otrZHxuZsxWHJEy1GV3A0MFPddv/9yMG3/DsinNxZFN9AzcTRlgr9AKJ6
   g==;
X-CSE-ConnectionGUID: wyGCjv23SU6TxrOX7qxFiQ==
X-CSE-MsgGUID: uelW5UUvSmun65GghSm3Ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="58084680"
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="58084680"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 10:25:00 -0700
X-CSE-ConnectionGUID: zIHaSsJmToq4YiGQYZ8xzQ==
X-CSE-MsgGUID: iy/iskv2RwSC9oTvTTPiYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="196291876"
Received: from dwesterg-mobl1.amr.corp.intel.com ([10.125.108.137])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 10:25:00 -0700
Message-ID: <4f534cc70650111e420d5ac9040df4e546eed336.camel@linux.intel.com>
Subject: Re: [BUG] intel_pstate: CPU frequencies miscalculated/incorrectly
 detected on Arrow Lake hardware
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Aaron Rainbolt <arainbolt@kfocus.org>, lenb@kernel.org, rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, 
	kernel-team@lists.ubuntu.com
Date: Tue, 22 Jul 2025 10:24:42 -0700
In-Reply-To: <20250722113133.3a048c7a@kf-m2g5>
References: <20250517223323.6e13bf58@kf-m2g5>
	 <20250722113133.3a048c7a@kf-m2g5>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-07-22 at 11:31 -0500, Aaron Rainbolt wrote:
> On Sat, 17 May 2025 22:33:23 -0500
> Aaron Rainbolt <arainbolt@kfocus.org> wrote:
>=20
> > We have tested three systems with Arrow Lake CPUs, and all of them
> > report incorrect max and base frequencies. Two systems have Ultra 9
> > 275 HX CPUs, and one has an Ultra 5 225 H. The problem occurs with
> > both the Ubuntu 6.11 kernel and the 6.14.6 mainline kernel.
> >=20
> > How these values are misreported appears to depend on the CPU. On
> > the
> > Ultra 9 275HX systems when running Ubuntu=E2=80=99s 6.11.0-1015-oem ker=
nel,
> > the max reported frequency on a golden core is 5000000; however,
> > the
> > CPU spec says it should be 5400000. In contrast, on an Ultra 5 225H
> > system, the max reported frequency on a golden core is 6200000;
> > however, the spec says it should be 4900000.=20
> >=20
> > This bug is troublesome to end users because many CPU monitoring
> > apps
> > will report the CPU is running quite a bit slower or faster than
> > the
> > spec. Tools such as cpupower-gui, cpufreq-info, and cpufreq-set all
> > show incorrect values because they read cpuinfo_max_freq and
> > base_frequency, and write scaling_max_freq values in
> > /sys/devices/system/cpu/cpufreq/policy* directories.=20
> >=20
> > The following bash script shows the incorrect values read from the
> > cpuinfo_max_freq and base_frequency files. It also shows how the
> > actual max frequencies attained are as expected. The example values
> > shown come from an Ultra 9 275 HX CPU.
> >=20
> > =C2=A0=C2=A0=C2=A0 echo; echo '=3D=3D BEGIN =3D=3D';
> > =C2=A0=C2=A0=C2=A0 echo 'Ensure turbo is on';
> > =C2=A0=C2=A0=C2=A0 cd /sys/devices/system/cpu;
> > =C2=A0=C2=A0=C2=A0 echo '0' |sudo tee intel_pstate/no_turbo > /dev/null=
;
> > =C2=A0=C2=A0=C2=A0 if grep -q '0' intel_pstate/no_turbo; then echo 'Tur=
bo is on';
> > fi
> >=20
> > =C2=A0=C2=A0=C2=A0 echo; echo 'Find top 2 golden cores';
> > =C2=A0=C2=A0=C2=A0 cd /sys/devices/system/cpu/cpufreq/;
> > =C2=A0=C2=A0=C2=A0 grep . policy*/cpuinfo_max_freq \
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | awk -F: '{print $2" "$1}' |sort -rn | =
head -n2;
> > =C2=A0=C2=A0=C2=A0 #> 5000000 policy2/cpuinfo_max_freq
> > =C2=A0=C2=A0=C2=A0 #> 5000000 policy3/cpuinfo_max_freq=C2=A0=20
> >=20
> > =C2=A0=C2=A0=C2=A0 echo; echo 'Confirm misreporting: per spec, this sho=
uld be
> > 5400000!'; grep . policy2/cpuinfo_max_freq; # 500000
> >=20
> > =C2=A0=C2=A0=C2=A0 echo; echo 'Confirm misreporting: per spec, this sho=
uld be
> > 2700000!' grep . policy2/base_frequency; # 2500000
> >=20
> > =C2=A0=C2=A0=C2=A0 echo; echo '# Run a CPU benchmark now, then press [ =
Enter ] to
> > see top 3 freqs.'; echo 'This will take 6 seconds to complete.';
> > =C2=A0=C2=A0=C2=A0 read -r -p '# You should see that the freqs match th=
e CPU
> > specs.
> > ';\ for i in {0..5}; do
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 grep . policy*/scaling_cur_freq | awk -F=
: '{print $2" "$1}';
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sleep 1;
> > =C2=A0=C2=A0=C2=A0 done |sort -rn |head -n3=20
> > =C2=A0=C2=A0=C2=A0 #> 5400000 policy2/scaling_cur_freq
> > =C2=A0=C2=A0=C2=A0 #> 5320159 policy2/scaling_cur_freq
> > =C2=A0=C2=A0=C2=A0 #> 5241886 policy3/scaling_cur_freq=C2=A0=20
> >=20
> > =C2=A0=C2=A0=C2=A0 echo; echo '=3D=3D END=C2=A0=C2=A0 =3D=3D'; echo;
> >=20
> > The actual results, when running the above script, shows the
> > cpuinfo_max_freq and base_frequencies values do not match those
> > specified by Intel. With the 6.11.0-1021-oem Ubuntu Kernel, we see
> > the
> > following:
> >=20
> > > Turbo? | Core | Freq (spec) | Freq (report) | Freq (actual) |
> > > Yes=C2=A0=C2=A0=C2=A0 | P=C2=A0=C2=A0=C2=A0 | 5.4 GHz=C2=A0=C2=A0=C2=
=A0=C2=A0 | 5.0 GHz=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 5.4 GHz=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > > No=C2=A0=C2=A0=C2=A0=C2=A0 | P=C2=A0=C2=A0=C2=A0 | 2.7 GHz=C2=A0=C2=
=A0=C2=A0=C2=A0 | 2.5 GHz=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2.7 GHz=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > > Yes=C2=A0=C2=A0=C2=A0 | E=C2=A0=C2=A0=C2=A0 | 4.6 GHz=C2=A0=C2=A0=C2=
=A0=C2=A0 | 4.6 GHz=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4.6 GHz=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > > No=C2=A0=C2=A0=C2=A0=C2=A0 | E=C2=A0=C2=A0=C2=A0 | 2.1 GHz=C2=A0=C2=
=A0=C2=A0=C2=A0 | 2.1 GHz=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2.1 GHz=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> >=20
> > We have verified the cores are operating at their specified
> > frequencies by running a demanding CPU benchmark while graphing
> > frequencies with KDE System Monitor, on all 3 systems. This tool
> > appeared to graph scaling_cur_freq values. Notice E-cores appear to
> > be correctly reported. Also, all systems misinterpret values
> > written
> > to scaling_max_req with the apparent same error deltas: on the
> > Ultra
> > 9 275 HX, setting this value to 5000000 results in actual max
> > frequencies of 5400000. Setting it to 2500000 results in max
> > 2700000.
> > Setting it to 1650000 results in max 2100000.
> >=20
> > The behavior with the 6.14.6 kernel is worse than with 6.11, with
> > all
> > values under-reported. Actual frequencies were not tested on
> > 6.14.6:
> >=20
> > > Turbo? | Core | Freq (spec) | Freq (report) |
> > > Yes=C2=A0=C2=A0=C2=A0 | P=C2=A0=C2=A0=C2=A0 | 5.4 GHz=C2=A0=C2=A0=C2=
=A0=C2=A0 | 3.9 GHz=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > > No=C2=A0=C2=A0=C2=A0=C2=A0 | P=C2=A0=C2=A0=C2=A0 | 2.7 GHz=C2=A0=C2=
=A0=C2=A0=C2=A0 | 2.0 GHz=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > > Yes=C2=A0=C2=A0=C2=A0 | E=C2=A0=C2=A0=C2=A0 | 4.6 GHz=C2=A0=C2=A0=C2=
=A0=C2=A0 | 3.3 GHz=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > > No=C2=A0=C2=A0=C2=A0=C2=A0 | E=C2=A0=C2=A0=C2=A0 | 2.1 GHz=C2=A0=C2=
=A0=C2=A0=C2=A0 | 1.5 GHz=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> >=20
> > Is it possible the math currently used for calculating CPU
> > frequencies
> > is no longer correct for Arrow Lake CPUs? This seems similar to the
> > issue that was fixed by commit f5c8cf2 (cpufreq: intel_pstate:
> > hybrid:
> > Use known scaling factor for P-cores).
>=20
> Following up on this, is there any update or possible fix we could
> test?
I asked for some dumps before. We can try to inform the OEM of the
system as this is a BIOS tables issue. What is the make and model of
your system?

Thanks,
Srinivas

