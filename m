Return-Path: <linux-acpi+bounces-7305-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4916C947E7E
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Aug 2024 17:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 792111C21D19
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Aug 2024 15:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E80215C130;
	Mon,  5 Aug 2024 15:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NNIERRSJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104C241746;
	Mon,  5 Aug 2024 15:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722872794; cv=none; b=IMgpomVPSToXaFvQeZ5RkGoQvnDDF7C3pltwKN/QHpvzaion/9npMiDthRK+jwP0Jk+ebpponURLdmt7LuILmWgGhIG1mvHl3G8MIh/4/kAE6VQcROdzr02hEqMZDt8lBXBvhclmfyV60yvbxOfvmiLk98F19Em0DS0OoSDQHjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722872794; c=relaxed/simple;
	bh=ozdopBfX+Pa7sQb7DkWYYSg0hnj6wOB8jcvpKirKoFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/qfTmktStnVQLePn5U1Jrk3cXPWNupPjFSRMYfCbgZTehYGNzME6GsrCwS6JD9bc8sDCOWCJd3yA87+ucmw/1+/Uhv0WjQA9xzCHd8k9sqp9tQKKjc1/xyMAbGmwAsHbMUTjtAgCfwrDTW5vCw98x/IDcgHrLRBneRSJh3k5ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=NNIERRSJ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id A4FE220B7165; Mon,  5 Aug 2024 08:46:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A4FE220B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1722872792;
	bh=wDw7UOdH0U0NkiUKjQ+qGsEmMYcAqgKZ0jJT6sguB2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NNIERRSJDzkDFPnjzmfpEw2Huumf0O/DOCfAUIW5/RkbyVLCePPdcl7F9FjyPaQtt
	 ieYBpCk6osXBkEYMj97/VTOuCiwRtp8noVUjXCUwZ8XM0FhT3uBfgT88v0EGPmg2lA
	 qWuL02JWexb1OT09t3H5SBOWRy3bSzCArYLaz9yM=
Date: Mon, 5 Aug 2024 08:46:32 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: arnd@arndb.de, bhelgaas@google.com, bp@alien8.de,
	catalin.marinas@arm.com, dave.hansen@linux.intel.com,
	decui@microsoft.com, haiyangz@microsoft.com, hpa@zytor.com,
	kw@linux.com, kys@microsoft.com, lenb@kernel.org,
	lpieralisi@kernel.org, mingo@redhat.com, rafael@kernel.org,
	robh@kernel.org, tglx@linutronix.de, wei.liu@kernel.org,
	will@kernel.org, linux-acpi@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, x86@kernel.org, apais@microsoft.com,
	benhill@microsoft.com, ssengar@microsoft.com,
	sunilmut@microsoft.com, vdso@hexbites.dev
Subject: Re: [PATCH v3 1/7] arm64: hyperv: Use SMC to detect hypervisor
 presence
Message-ID: <20240805154632.GA11961@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240726225910.1912537-1-romank@linux.microsoft.com>
 <20240726225910.1912537-2-romank@linux.microsoft.com>
 <20240805035340.GA13276@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <ce9104e7-9b48-496e-a0af-3d8035b05047@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce9104e7-9b48-496e-a0af-3d8035b05047@linux.microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Aug 05, 2024 at 08:17:05AM -0700, Roman Kisel wrote:
> 
> 
> On 8/4/2024 8:53 PM, Saurabh Singh Sengar wrote:
> >On Fri, Jul 26, 2024 at 03:59:04PM -0700, Roman Kisel wrote:
> >>The arm64 Hyper-V startup path relies on ACPI to detect
> >>running under a Hyper-V compatible hypervisor. That
> >>doesn't work on non-ACPI systems.
> >>
> >>Hoist the ACPI detection logic into a separate function,
> >>use the new SMC added recently to Hyper-V to use in the
> >>non-ACPI case.
> >>
> >>Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> >>---
> >>  arch/arm64/hyperv/mshyperv.c      | 36 ++++++++++++++++++++++++++-----
> >>  arch/arm64/include/asm/mshyperv.h |  5 +++++
> >>  2 files changed, 36 insertions(+), 5 deletions(-)
> >>
> >>diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
> >>index b1a4de4eee29..341f98312667 100644
> >>--- a/arch/arm64/hyperv/mshyperv.c
> >>+++ b/arch/arm64/hyperv/mshyperv.c
> >>@@ -27,6 +27,34 @@ int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
> >>  	return 0;
> >>  }
> >>+static bool hyperv_detect_via_acpi(void)
> >>+{
> >>+	if (acpi_disabled)
> >>+		return false;
> >>+#if IS_ENABLED(CONFIG_ACPI)
> >>+	/* Hypervisor ID is only available in ACPI v6+. */
> >>+	if (acpi_gbl_FADT.header.revision < 6)
> >>+		return false;
> >>+	return strncmp((char *)&acpi_gbl_FADT.hypervisor_id, "MsHyperV", 8) == 0;
> >>+#else
> >>+	return false;
> >>+#endif
> >>+}
> >>+
> >>+static bool hyperv_detect_via_smc(void)
> >>+{
> >>+	struct arm_smccc_res res = {};
> >>+
> >>+	if (arm_smccc_1_1_get_conduit() != SMCCC_CONDUIT_HVC)
> >>+		return false;
> >>+	arm_smccc_1_1_hvc(ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID, &res);
> >>+
> >>+	return res.a0 == ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_0 &&
> >>+		res.a1 == ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_1 &&
> >>+		res.a2 == ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_2 &&
> >>+		res.a3 == ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_3;
> >>+}
> >
> >As you mentioned in the cover letter this is supported in latest Hyper-V hypervisor,
> >can we add a comment about it, specifying the exact version in it would be great.
> >
> I can add a comment about that, thought that would look as too much
> detail to refer to a version of the Windows insiders build in the
> comments in this code. Another option would be to entrench the logic
> in if statements which felt gross as there is a fallback.

I'll leave the decision to your judgment.

> 
> >If someone attempts to build non-ACPI kernel on older Hyper-V what is the
> >behaviour of this function, do we need to safeguard or handle that case ?
> The function won't panic if that's what you're asking about, i.e.
> safe for runtime. That won't break the build either as it relies on
> the SMCCC spec, and that uses the smc or hvc instructions (the code
> does expect hvc to be the conduit and checks for that being the
> case). The hypervisor doesn't inject the exception in the guest for
> the unknown call, just returns SMCCC_RET_NOT_SUPPORTED in the first
> output register (the hypervisor got a unit-test for that, too).

Looks good, have you considered checking for SMCCC_RET_NOT_SUPPORTED ?

- Saurabh

