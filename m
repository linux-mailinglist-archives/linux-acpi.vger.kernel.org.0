Return-Path: <linux-acpi+bounces-14189-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 485C8AD00C8
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Jun 2025 12:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF281189CB07
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Jun 2025 10:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E22286D4B;
	Fri,  6 Jun 2025 10:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fovZhgN+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA08C2853E5;
	Fri,  6 Jun 2025 10:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749207073; cv=none; b=B6sSJgi3tMDO8TT13xVHjyJPNIqzNGcyjC7epVRX32R2PYTNPIPBOsbfzDGD43k5p//B4+4CI4tEontthkkLAqy5YuKyGd9rmx++LvTDh1rLYJ/bSkLNjel3VCLBEoJs3mqAphikO+7X1RpNSYlr0Q8yYu8ssSevHgYSZQVA3dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749207073; c=relaxed/simple;
	bh=CNPz/yyP5cutCEBAybS+Lck8HSInfMDQx2oYa9/K/kQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CqXF6QKFS7GTIyOE3eAAKWLzkJ+KuLvZomcYQVbxzxQOv1yzsYbRtyYQ93qljSpt77IFit5uiy6TETwXQk2K87EKrOviq1YgL/oh4a0iUWyyuKi9d4HuM0YG2JnKXFZ1GZEHmo2hjVFJ5UlFm3ZI62Jtl13rleM/r9u5hQTF2dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fovZhgN+; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749207072; x=1780743072;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=CNPz/yyP5cutCEBAybS+Lck8HSInfMDQx2oYa9/K/kQ=;
  b=fovZhgN+SYdxPpiNelxNhvuvZRVlQR2CAENUtQOPcNwScxcoIPShdt0D
   QWnqxoJIC1lrZQAgIxAgz3FA2tAESRiE2Spghg3Rz/vyJ8uzzcUNr/74I
   VzKu0kPZ5KaB0vwoiTiIGsxY1n6TJbbDEUnJboO7piJ46HW2Z1YfpcsZ5
   Qq+a+BsN5NPLDpNBrhDVBE2neFXDoqq92PcAPL0MI0hWViQWhGTABqQeQ
   jtn0M4c54GZAkSvtMpJwCYhHozRi2HPoYFCdM0aP6NmLc3Z+Q84ynipI+
   pgTAHyRKm2c4bd+hs/+21FAZAwDcDidumKq1ro1QkwCUy0rxOZ412LiSb
   w==;
X-CSE-ConnectionGUID: X5ZtwcWSTe+9kXUx3Tfk5Q==
X-CSE-MsgGUID: GrRRXGuPR0ONh6W2OW3ArA==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="55161791"
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; 
   d="scan'208";a="55161791"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 03:51:11 -0700
X-CSE-ConnectionGUID: s0+9KUBOScK0UWBrMAYDuw==
X-CSE-MsgGUID: rk/F+LbGRu+OjUNpF+gkaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; 
   d="scan'208";a="146768243"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 03:51:11 -0700
Received: from [10.245.245.46] (abityuts-desk.ger.corp.intel.com [10.245.245.46])
	by linux.intel.com (Postfix) with ESMTP id DBA2220B5736;
	Fri,  6 Jun 2025 03:51:06 -0700 (PDT)
Message-ID: <96158539a213de089c792ff8f88ed5abb71a60e0.camel@linux.intel.com>
Subject: Re: [PATCH v1 0/5] x86/smp: Restore the elimination of
 mwait_play_dead_cpuid_hint()
From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86 Maintainers
 <x86@kernel.org>,  Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Dave
 Hansen	 <dave.hansen@linux.intel.com>, "Gautham R. Shenoy"
 <gautham.shenoy@amd.com>,  Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Linux ACPI <linux-acpi@vger.kernel.org>
Date: Fri, 06 Jun 2025 13:51:05 +0300
In-Reply-To: <2226957.irdbgypaU6@rjwysocki.net>
References: <2226957.irdbgypaU6@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-06-05 at 17:03 +0200, Rafael J. Wysocki wrote:
> Hi Everyone,
>=20
> The purpose of this series is to reapply the code changes from commit
> 96040f7273e2 ("x86/smp: Eliminate mwait_play_dead_cpuid_hint()") that
> has been reverted because of an issue introduced by it.  This takes
> place in the last patch ([5/5]) and the previous patches make
> preparatory changes needed to avoid breaking systems in the field
> once again.

Hello,

thanks Rafael for the patches, and Peter/Dave for helping handling the
issue.

Tested-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

I measured a Granite Rapids Xeon with v6.15 vanilla [setup 1], then
with v6.15 + revert of 96040f7273e2 + these 5 patches [setup 2].

I can see that in setup 2 the average idle package power is 54% lower
than in setup 1. This is simply because in setup 1 there is no CC6 /
PC6. And this is because every core's sibling is in CC1, which blocks
CC6 on every core.

=3D=3D Reference =3D=3D

1. Small article explaining then naming I use (CC1, CC6, PC6):
https://github.com/intel/pepc/blob/main/docs/misc-cstate-namespaces.md

=3D=3D Non-essential details, just for reference =3D=3D

The measurement could have been done in a simpler way, but since I have
developed tools and have a good setup to measure workloads with my open
source tools, I did the following.

Used stats-collect: https://github.com/intel/stats-collect/

# Boot the vanilla kernel on system under test (SUT) named 'gnr2' (this
# is the host name). Then run the following command on my system, that
# has root SSH access to 'gnr2' configured.

stats-collect start --stats all -H gnr2 --reportid gnr2-idle-nosmt-
v6.15-vanilla -o raw/gnr2-idle-nosmt-v6.15-vanilla -- sleep 600

# The above SSHed to gnr2, ran workload "sleep 600", and collected a
# bunch of statistics, which were saved to
# raw/gnr2-idle-nosmt-v6.15-vanilla on my host.

# Boot the "setup 2" kernel, which I referred to as "6.15-fixed". Run
# the following command.

stats-collect start --stats all -H gnr2 --reportid gnr2-idle-nosmt-
v6.15-fixed -o raw/gnr2-idle-nosmt-v6.15-fixed -- sleep 600

# Then generate an HTML diff between those.
stats-collect report raw/gnr2-idle-nosmt-v6.15-vanilla/ raw/gnr2-idle-
nosmt-v6.15-fixed/ -o diff

# Open "diff" with a browser (I have my HTTP server, so just copied it
# to ~/public_html). Find lots of stats, in my case
# turbostat,=C2=A0interrupts, IPMI.

In the diff, I checked turbostat's PkgPwr (CPU chip power in Watts) and
turbostat's CPU%c6 (CC6 residency, %).

HTH,
Artem.

