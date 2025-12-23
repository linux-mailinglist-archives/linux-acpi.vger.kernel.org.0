Return-Path: <linux-acpi+bounces-19834-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0A9CDA566
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 20:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D9423027CF6
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 19:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48923431E6;
	Tue, 23 Dec 2025 19:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SCoP7vjZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B5E2D3231;
	Tue, 23 Dec 2025 19:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766517729; cv=none; b=igOCQO1/hTACA8+gN1tMLF+0ETZBLD7JCH6ipD1PtAeo8SShyR8AElGiRIDNP4qr6vGffYg/2NVvqHGONkw5nBrHx6dxacwWOcSp+pK2pOAODJvmVY+obgylM4EDX+/5CyMgPdYjJO//4hJXAM5dDnjHlWIcOE9IgDxI/0iGBSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766517729; c=relaxed/simple;
	bh=pliM/YfSrbKWPt0QBAhdRpwIux5X0ur1FKG+K5KviLc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U69yGiyqdzggcHjfd9yPgJPhihOrB2Mq3gX2A3H9f3+RKa8cLV/jpOUpUR+VncHWFNoeGEPUhQ54Kj8rtYR3eYL9aP2f4Ir6kzna4he2keUG9GVUqVk+9qMvPoBbwHMAhIwMlx6oLELtxc/H3til5PntRxz9Phv5IUBLods8If0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SCoP7vjZ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766517727; x=1798053727;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=pliM/YfSrbKWPt0QBAhdRpwIux5X0ur1FKG+K5KviLc=;
  b=SCoP7vjZoini8Mffqni/pfuUFS4ucKXqKNqBTUmLLDSs/aB20sH6hAVf
   75n1JWzGVZgAfPc+XkDBknfdAdmB1uNGdyJmrvys2Bsw26rCHI106i24P
   Buc0jjJV8W9TlYTNqR5ZBDrNBiX3pRdDIS8UvnMdGKN1jvbPsFWlF0BKa
   IM1kYZRHBSyWPmbNNSou27IXED8vzEwFdKQnz3qVItUTYMtKsZOA23e3i
   Byu6fke57KBr9H5jJ1LY8/xMrahA06GYaGQ/p2CHMber5zZ9mO545lZhQ
   ubin5N96axQtlgnJ/0Lsm6Unzo34zxDes2OxPqT2mJWbxQ7Evm2OsyoOO
   w==;
X-CSE-ConnectionGUID: XV9LNSUmQuCOwdDOkklAkA==
X-CSE-MsgGUID: 4LaJgH0GTvipINOyDzQYbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11651"; a="72232196"
X-IronPort-AV: E=Sophos;i="6.21,171,1763452800"; 
   d="scan'208";a="72232196"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2025 11:21:56 -0800
X-CSE-ConnectionGUID: Yvjtap7MS9eGRblpWvRoeA==
X-CSE-MsgGUID: IqGaRZkxSPSx5Y6/LXnAwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,171,1763452800"; 
   d="scan'208";a="230514214"
Received: from spandruv-mobl5.amr.corp.intel.com (HELO [10.124.220.160]) ([10.124.220.160])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2025 11:21:53 -0800
Message-ID: <08052bbd0a6fa2ca2d0c349936086cd31be87b37.camel@linux.intel.com>
Subject: Re: [BUG] intel_pstate: CPU frequencies miscalculated/incorrectly
 detected on Arrow Lake hardware
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Aaron Rainbolt <arainbolt@kfocus.org>
Cc: kernel-team@lists.ubuntu.com, lenb@kernel.org,
 linux-acpi@vger.kernel.org, 	linux-pm@vger.kernel.org,
 mmikowski@kfocus.org, rjw@rjwysocki.net
Date: Tue, 23 Dec 2025 11:21:51 -0800
In-Reply-To: <20251223114122.0227dab8@kf-m2g5>
References: <20251214184507.21f95134@kf-m2g5>
		<33fc5ba96b80f1eeb69777822cfddefe64100540.camel@linux.intel.com>
		<20251215092525.6ea95739@kf-m2g5>
		<250bec4336d5e7adbc841e4945e50e589b10c375.camel@linux.intel.com>
	 <20251223114122.0227dab8@kf-m2g5>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Aaron,

On Tue, 2025-12-23 at 11:41 -0600, Aaron Rainbolt wrote:
> On Wed, 17 Dec 2025 05:33:08 -0800
> srinivas pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
>=20
> > Hi Aaron,
> >=20
> > Tested on a platform with the similar CPU (100 MHz more max). There
> > is
> > no issue in max frequency or base frequency display.
>=20
> Hi Srinivas,
>=20
> Thanks for taking the time to look into this. For reference, the
> X560WNR-G that we last reported has the INSYDE BIOS version
> 1.07.07S3min29. That might be useful when reaching out to Clevo.
>=20
> Since we=E2=80=99ve seen this on hardware from Clevo, TongFang, and ASUS,
> we=E2=80=99ll
> want to report to all of them. Can you tell us what tool you are
> using
> to measure the max and base frequency displays?

I checked the sysfs display of base and scalig_max freq from cpufreq.
For current frequencies used turbotstat  with stress 1 CPU busy.

>  Are both P and E cores
> displaying the proper frequencies on your end?
Yes.

>  We can then share that
> with the ODMs.
>=20

Sure.

Thanks,
Srinivas

> Thanks again,
>=20
> --
> Aaron

