Return-Path: <linux-acpi+bounces-21314-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILRTGe4fp2mYeQAAu9opvQ
	(envelope-from <linux-acpi+bounces-21314-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Mar 2026 18:52:46 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD14C1F4CF8
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Mar 2026 18:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A44DC3050EE2
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Mar 2026 17:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999844DA55D;
	Tue,  3 Mar 2026 17:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aa0b6ie6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1993636C0CD;
	Tue,  3 Mar 2026 17:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772560362; cv=none; b=hD2kUbLU2fLAZLlsj9BQz+PDt0ZAlUNKKG+hgz1hhoLlt18GY4bn1/Sx9mzs0ByN8yJbyuwvzL49yAoEQrgWJlTCEFFydznQ0QC6aFPS8UEuchrb0/WkagIEeAKmCPpmkBtGImERGCKEtwEygnIGsSNKpzBSazWDv99spO11LwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772560362; c=relaxed/simple;
	bh=hRNNeYqGgi+ChI17GEwK814RfnQ1Qg48XJKOzHnjSRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHKp8tIQlgzU+m1VZRA6kBcpE8ArdUYoBzdIp6St3lmervPUb19uvMgD3SY84td9jwY5P3EwjldO+VOOth7V0luLFmvUksWa6jGIJxvEMFxgvlZKtLbMafSiP7yW0jUfp/vtHTZaPneu/aJsnnHQp3BgTU8PwiNBOVlZmrfSddY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aa0b6ie6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1644C116C6;
	Tue,  3 Mar 2026 17:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772560361;
	bh=hRNNeYqGgi+ChI17GEwK814RfnQ1Qg48XJKOzHnjSRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aa0b6ie6KMiThDTxt+Sk8+Pd4PC61JQzButMjZezkwdAcFVbfjZUdVjwuuGbYoEGH
	 0xHKkowkhR8Y54QzOd8OXQ9lKhsWIfIdnZoJv/n7HeKEOjMATCsb7qHXVUNCYgDVuE
	 wza8qg4dmNg/EJhuOzNmpdV9kROxKOha8EqkfCKrIHhHzLXrUK17DbJb2Znahq8esL
	 gSOVXmCDJ5TRlyDyCGPK5rX6W9C2a9p8P4zlIDfIxIys3aknxM07Kq15peqOGiDoA6
	 5o37xAh3VSbeE4PX4MX2+5DRK4JNnMF+Pq91UxDNMy4QY6WZ+tbO6uRLEO7fkkcQbV
	 AGLoroTvwLLTA==
Date: Tue, 3 Mar 2026 10:52:37 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	x86 Maintainers <x86@kernel.org>, linux-rtc@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v1 4/8] ACPI: x86/rtc-cmos: Use platform device for
 driver binding
Message-ID: <20260303175237.GB1114907@ax162>
References: <5983325.DvuYhMxLoT@rafael.j.wysocki>
 <13969123.uLZWGnKmhe@rafael.j.wysocki>
 <20260303060752.GA2749263@ax162>
 <5087839.31r3eYUQgx@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="TrKuMI+BaD7XwHS9"
Content-Disposition: inline
In-Reply-To: <5087839.31r3eYUQgx@rafael.j.wysocki>
X-Rspamd-Queue-Id: AD14C1F4CF8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21314-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan@kernel.org,linux-acpi@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email,linux.dev:email]
X-Rspamd-Action: no action


--TrKuMI+BaD7XwHS9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 03, 2026 at 01:51:37PM +0100, Rafael J. Wysocki wrote:
> On Tuesday, March 3, 2026 7:07:52 AM CET Nathan Chancellor wrote:
> > After this change in -next as commit 2a78e4210444 ("ACPI: x86/rtc-cmos:
> > Use platform device for driver binding"), I am seeing
> > 
> >   rtc_cmos PNP0B00:00: error -ENXIO: IRQ index 0 not found
> > 
> > on a few of my test machines. Is this expected?
> 
> Not really, thanks for reporting!
> 
> Please send me a dmesg boot log from one of the affected systems.

Attached.

> The patch below should make the message go away.

Can confirm, thanks! If it is helpful:

Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH v1] rtc: cmos: Use platform_get_irq_optional() in cmos_platform_probe()
> 
> The rtc-cmos driver can live without an IRQ and returning an error
> code from platform_get_irq() is not a problem for it in general, so
> make it call platform_get_irq_optional() in cmos_platform_probe()
> instead of platform_get_irq() to avoid a confusing error message
> printed by the latter if an IRQ cannot be found for IRQ index 0,
> which is possible on x86 platforms.
> 
> Additionally, on x86, if the IRQ is not defined and the system has
> a legacy PIC, hardcode it to RTC_IRQ, which should be safe then.
> 
> Fixes: 2a78e4210444 ("ACPI: x86/rtc-cmos: Use platform device for driver binding")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/rtc/rtc-cmos.c |   13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> --- a/drivers/rtc/rtc-cmos.c
> +++ b/drivers/rtc/rtc-cmos.c
> @@ -1423,9 +1423,18 @@ static int __init cmos_platform_probe(st
>  		resource = platform_get_resource(pdev, IORESOURCE_IO, 0);
>  	else
>  		resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0)
> +	irq = platform_get_irq_optional(pdev, 0);
> +	if (irq < 0) {
>  		irq = -1;
> +#ifdef CONFIG_X86
> +		/*
> +		 * On some x86 systems, the IRQ is not defined, but it should
> +		 * always be safe to hardcode it on systems with a legacy PIC.
> +		 */
> +		if (nr_legacy_irqs())
> +			irq = RTC_IRQ;
> +#endif
> +	}
>  
>  	return cmos_do_probe(&pdev->dev, resource, irq);
>  }
> 
> 
> 

--TrKuMI+BaD7XwHS9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg

[    0.000000] Linux version 7.0.0-rc2-debug-next-20260303-03431-gc025f6cf4209 (nathan@framework-amd-ryzen-maxplus-395) (x86_64-linux-gcc (GCC) 15.2.0, GNU ld (GNU Binutils) 2.45) #1 SMP PREEMPT_DYNAMIC Tue Mar  3 10:43:00 MST 2026
[    0.000000] Command line: initrd=\initramfs-linux-debug.img amd_pstate=active kvm.mitigate_smt_rsb=1 root=PARTUUID=e57babd5-4363-4337-8f75-0abf8481c852 rootflags=subvol=@ rootfstype=btrfs rw zswap.enabled=0
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff]  System RAM
[    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff]  device reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000009a7efff]  System RAM
[    0.000000] BIOS-e820: [mem 0x0000000009a7f000-0x0000000009ffffff]  device reserved
[    0.000000] BIOS-e820: [mem 0x000000000a000000-0x000000000a1fffff]  System RAM
[    0.000000] BIOS-e820: [mem 0x000000000a200000-0x000000000a23bfff]  ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000000a23c000-0x0000000093f06fff]  System RAM
[    0.000000] BIOS-e820: [mem 0x0000000093f07000-0x000000009690efff]  device reserved
[    0.000000] BIOS-e820: [mem 0x000000009690f000-0x0000000096989fff]  ACPI data
[    0.000000] BIOS-e820: [mem 0x000000009698a000-0x0000000097404fff]  ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000097405000-0x000000009affefff]  device reserved
[    0.000000] BIOS-e820: [mem 0x000000009afff000-0x000000009bff8fff]  System RAM
[    0.000000] BIOS-e820: [mem 0x000000009bff9000-0x000000009bffcfff]  device reserved
[    0.000000] BIOS-e820: [mem 0x000000009bffd000-0x000000009bffefff]  System RAM
[    0.000000] BIOS-e820: [mem 0x000000009bfff000-0x000000009cffffff]  device reserved
[    0.000000] BIOS-e820: [gap 0x000000009d000000-0x000000009d78ffff]
[    0.000000] BIOS-e820: [mem 0x000000009d790000-0x000000009d7effff]  device reserved
[    0.000000] BIOS-e820: [gap 0x000000009d7f0000-0x000000009d7f4fff]
[    0.000000] BIOS-e820: [mem 0x000000009d7f5000-0x000000009fffffff]  device reserved
[    0.000000] BIOS-e820: [gap 0x00000000a0000000-0x00000000dfffffff]
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff]  device reserved
[    0.000000] BIOS-e820: [gap 0x00000000f0000000-0x00000000fcffffff]
[    0.000000] BIOS-e820: [mem 0x00000000fd000000-0x00000000ffffffff]  device reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000055e2fffff]  System RAM
[    0.000000] BIOS-e820: [gap 0x000000055e300000-0x000000055f33ffff]
[    0.000000] BIOS-e820: [mem 0x000000055f340000-0x00000006801fffff]  device reserved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] efi: EFI v2.8 by American Megatrends Inc.
[    0.000000] efi: ACPI=0x973eb000 ACPI 2.0=0x973eb014 TPMFinalLog=0x973b7000 SMBIOS=0x9ad71000 SMBIOS 3.0=0x9ad70000 MEMATTR=0x90e9e298 ESRT=0x90802e98 RNG=0x96926f18 INITRD=0x8879c818 TPMEventLog=0x9691d018 
[    0.000000] random: crng init done
[    0.000000] efi: Remove mem55: MMIO range=[0xe0000000-0xefffffff] (256MB) from e820 map
[    0.000000] e820: remove [mem 0xe0000000-0xefffffff] device reserved
[    0.000000] efi: Remove mem56: MMIO range=[0xfd000000-0xfedfffff] (30MB) from e820 map
[    0.000000] e820: remove [mem 0xfd000000-0xfedfffff] device reserved
[    0.000000] efi: Not removing mem57: MMIO range=[0xfee00000-0xfee00fff] (4KB) from e820 map
[    0.000000] efi: Remove mem58: MMIO range=[0xfee01000-0xffffffff] (17MB) from e820 map
[    0.000000] e820: remove [mem 0xfee01000-0xffffffff] device reserved
[    0.000000] efi: Remove mem60: MMIO range=[0x660000000-0x6801fffff] (514MB) from e820 map
[    0.000000] e820: remove [mem 0x660000000-0x6801fffff] device reserved
[    0.000000] SMBIOS 3.5.0 present.
[    0.000000] DMI: AZW SER8/SER8, BIOS HPT.8xxx.SER8.V029.P8C0M0C15.13.Link 02/21/2025
[    0.000000] DMI: Memory slots populated: 2/2
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 3792.747 MHz processor
[    0.000070] e820: update [mem 0x00000000-0x00000fff] System RAM ==> device reserved
[    0.000072] e820: remove [mem 0x000a0000-0x000fffff] System RAM
[    0.000076] last_pfn = 0x55e300 max_arch_pfn = 0x400000000
[    0.000081] MTRR map: 5 entries (3 fixed + 2 variable; max 20), built from 9 variable MTRRs
[    0.000082] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000220] e820: update [mem 0xa0000000-0xffffffff] System RAM ==> device reserved
[    0.000225] last_pfn = 0x9bfff max_arch_pfn = 0x400000000
[    0.002721] esrt: Reserving ESRT space from 0x0000000090802e98 to 0x0000000090802ed0.
[    0.002725] e820: update [mem 0x90802000-0x90802fff] System RAM ==> device reserved
[    0.002735] Using GB pages for direct mapping
[    0.002987] Secure boot disabled
[    0.002987] RAMDISK: [mem 0x8228e000-0x84d64fff]
[    0.003115] ACPI: Early table checksum verification disabled
[    0.003118] ACPI: RSDP 0x00000000973EB014 000024 (v02 ALASKA)
[    0.003120] ACPI: XSDT 0x00000000973EA728 00017C (v01 ALASKA A M I    01072009 AMI  01000013)
[    0.003124] ACPI: FACP 0x000000009697F000 000114 (v06 ALASKA A M I    01072009 AMI  00010013)
[    0.003127] ACPI: DSDT 0x0000000096974000 00ABAC (v02 ALASKA A M I    01072009 INTL 20220331)
[    0.003129] ACPI: FACS 0x0000000096BA4000 000040
[    0.003130] ACPI: SSDT 0x0000000096981000 008416 (v02 AMD    AmdTable 00000002 MSFT 02000002)
[    0.003131] ACPI: SSDT 0x0000000096980000 000221 (v02 ALASKA CPUSSDT  01072009 AMI  01072009)
[    0.003132] ACPI: FIDT 0x0000000096973000 00009C (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.003133] ACPI: MCFG 0x0000000096972000 00003C (v01 ALASKA A M I    01072009 MSFT 00010013)
[    0.003134] ACPI: HPET 0x0000000096971000 000038 (v01 ALASKA A M I    01072009 AMI  00000005)
[    0.003135] ACPI: UEFI 0x0000000096BA3000 000048 (v01 ALASKA A M I    01072009 AMI  01000013)
[    0.003136] ACPI: FPDT 0x0000000096970000 000044 (v01 ALASKA A M I    01072009 AMI  01000013)
[    0.003137] ACPI: VFCT 0x000000009696B000 004284 (v01 ALASKA A M I    00000001 AMD  33504F47)
[    0.003138] ACPI: BGRT 0x000000009696A000 000038 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.003139] ACPI: TPM2 0x0000000096969000 000044 (v05 ALASKA A M I    00000001 AMI  00000000)
[    0.003140] ACPI: SSDT 0x0000000096963000 00547E (v02 AMD    AmdTable 00000001 AMD  00000001)
[    0.003141] ACPI: CRAT 0x0000000096962000 000EE8 (v01 AMD    AmdTable 00000001 AMD  00000001)
[    0.003142] ACPI: CDIT 0x0000000096961000 000029 (v01 AMD    AmdTable 00000001 AMD  00000001)
[    0.003143] ACPI: SSDT 0x000000009695F000 0015C8 (v02 AMD    CPMDFIG2 00000001 INTL 20220331)
[    0.003144] ACPI: SSDT 0x000000009695C000 002A9E (v02 AMD    CDFAAIG2 00000001 INTL 20220331)
[    0.003146] ACPI: SSDT 0x000000009695A000 0012AE (v02 AMD    OEMACP   00000001 INTL 20220331)
[    0.003147] ACPI: SSDT 0x0000000096959000 0008BA (v02 AMD    OEMPMF   00000001 INTL 20220331)
[    0.003148] ACPI: SSDT 0x000000009694F000 009902 (v02 AMD    CPMCMN   00000001 INTL 20220331)
[    0.003149] ACPI: WSMT 0x000000009694E000 000028 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.003150] ACPI: APIC 0x000000009694D000 0000E8 (v05 ALASKA A M I    01072009 AMI  00010013)
[    0.003151] ACPI: MHSP 0x000000009694C000 0000C8 (v04 AMD    AGESA    20505348 ?    00000001)
[    0.003152] ACPI: SSDT 0x000000009694B000 0000E5 (v02 MSFT   MHSP     00000004 INTL 20220331)
[    0.003153] ACPI: SSDT 0x0000000096948000 002370 (v02 AMD    AOD      00000001 INTL 20220331)
[    0.003154] ACPI: SSDT 0x0000000096947000 000051 (v02 AMD    DRTM     00000001 INTL 20220331)
[    0.003155] ACPI: IVRS 0x0000000096946000 0001F8 (v02 AMD    AmdTable 00000001 AMD  00000001)
[    0.003156] ACPI: SSDT 0x0000000096945000 000968 (v02 AMD    CPMMSOSC 00000001 INTL 20220331)
[    0.003157] ACPI: SSDT 0x0000000096944000 000FF5 (v02 AMD    CPMACPV5 00000001 INTL 20220331)
[    0.003158] ACPI: SSDT 0x0000000096943000 000608 (v02 AMD    TOUCHPNL 00000001 INTL 20220331)
[    0.003159] ACPI: SSDT 0x0000000096942000 000609 (v02 AMD    TOUCHPAD 00000001 INTL 20220331)
[    0.003160] ACPI: SSDT 0x0000000096941000 0007DD (v02 AMD    THERMAL0 00000001 INTL 20220331)
[    0.003161] ACPI: SSDT 0x0000000096940000 000FF7 (v02 AMD    GPP_PME_ 00000001 INTL 20220331)
[    0.003162] ACPI: SSDT 0x0000000096936000 0098BD (v02 AMD    INTGPP03 00000001 INTL 20220331)
[    0.003163] ACPI: SSDT 0x0000000096931000 004FEB (v02 AMD    INTGPP01 00000001 INTL 20220331)
[    0.003164] ACPI: SSDT 0x0000000096930000 000D89 (v02 AMD    CPMGPIO0 00000001 INTL 20220331)
[    0.003165] ACPI: SSDT 0x000000009692F000 00008D (v02 AMD    CPMMSLPI 00000001 INTL 20220331)
[    0.003166] ACPI: SSDT 0x000000009692E000 000501 (v02 AMD    CPMSFAML 00000001 INTL 20220331)
[    0.003167] ACPI: SSDT 0x000000009692D000 000CE0 (v02 AMD    WwanSsdt 00000001 INTL 20220331)
[    0.003168] ACPI: SSDT 0x000000009692C000 000BE8 (v01 AMD    WLAN     00000001 INTL 20220331)
[    0.003169] ACPI: SSDT 0x000000009692B000 00074A (v02 AMD    NVME     00000001 INTL 20220331)
[    0.003170] ACPI: SSDT 0x000000009692A000 000A51 (v02 AMD    GpMsSsdt 00000001 INTL 20220331)
[    0.003171] ACPI: SSDT 0x0000000096929000 000057 (v02 AMD    GPP0     00000001 INTL 20220331)
[    0.003172] ACPI: SSDT 0x0000000096927000 0017B8 (v02 AMD    UPEP     00000001 INTL 20220331)
[    0.003173] ACPI: Reserving FACP table memory at [mem 0x9697f000-0x9697f113]
[    0.003174] ACPI: Reserving DSDT table memory at [mem 0x96974000-0x9697ebab]
[    0.003174] ACPI: Reserving FACS table memory at [mem 0x96ba4000-0x96ba403f]
[    0.003175] ACPI: Reserving SSDT table memory at [mem 0x96981000-0x96989415]
[    0.003175] ACPI: Reserving SSDT table memory at [mem 0x96980000-0x96980220]
[    0.003175] ACPI: Reserving FIDT table memory at [mem 0x96973000-0x9697309b]
[    0.003175] ACPI: Reserving MCFG table memory at [mem 0x96972000-0x9697203b]
[    0.003176] ACPI: Reserving HPET table memory at [mem 0x96971000-0x96971037]
[    0.003176] ACPI: Reserving UEFI table memory at [mem 0x96ba3000-0x96ba3047]
[    0.003176] ACPI: Reserving FPDT table memory at [mem 0x96970000-0x96970043]
[    0.003176] ACPI: Reserving VFCT table memory at [mem 0x9696b000-0x9696f283]
[    0.003177] ACPI: Reserving BGRT table memory at [mem 0x9696a000-0x9696a037]
[    0.003177] ACPI: Reserving TPM2 table memory at [mem 0x96969000-0x96969043]
[    0.003177] ACPI: Reserving SSDT table memory at [mem 0x96963000-0x9696847d]
[    0.003178] ACPI: Reserving CRAT table memory at [mem 0x96962000-0x96962ee7]
[    0.003178] ACPI: Reserving CDIT table memory at [mem 0x96961000-0x96961028]
[    0.003178] ACPI: Reserving SSDT table memory at [mem 0x9695f000-0x969605c7]
[    0.003178] ACPI: Reserving SSDT table memory at [mem 0x9695c000-0x9695ea9d]
[    0.003179] ACPI: Reserving SSDT table memory at [mem 0x9695a000-0x9695b2ad]
[    0.003179] ACPI: Reserving SSDT table memory at [mem 0x96959000-0x969598b9]
[    0.003179] ACPI: Reserving SSDT table memory at [mem 0x9694f000-0x96958901]
[    0.003179] ACPI: Reserving WSMT table memory at [mem 0x9694e000-0x9694e027]
[    0.003180] ACPI: Reserving APIC table memory at [mem 0x9694d000-0x9694d0e7]
[    0.003180] ACPI: Reserving MHSP table memory at [mem 0x9694c000-0x9694c0c7]
[    0.003180] ACPI: Reserving SSDT table memory at [mem 0x9694b000-0x9694b0e4]
[    0.003181] ACPI: Reserving SSDT table memory at [mem 0x96948000-0x9694a36f]
[    0.003181] ACPI: Reserving SSDT table memory at [mem 0x96947000-0x96947050]
[    0.003181] ACPI: Reserving IVRS table memory at [mem 0x96946000-0x969461f7]
[    0.003181] ACPI: Reserving SSDT table memory at [mem 0x96945000-0x96945967]
[    0.003182] ACPI: Reserving SSDT table memory at [mem 0x96944000-0x96944ff4]
[    0.003182] ACPI: Reserving SSDT table memory at [mem 0x96943000-0x96943607]
[    0.003182] ACPI: Reserving SSDT table memory at [mem 0x96942000-0x96942608]
[    0.003183] ACPI: Reserving SSDT table memory at [mem 0x96941000-0x969417dc]
[    0.003183] ACPI: Reserving SSDT table memory at [mem 0x96940000-0x96940ff6]
[    0.003183] ACPI: Reserving SSDT table memory at [mem 0x96936000-0x9693f8bc]
[    0.003183] ACPI: Reserving SSDT table memory at [mem 0x96931000-0x96935fea]
[    0.003184] ACPI: Reserving SSDT table memory at [mem 0x96930000-0x96930d88]
[    0.003184] ACPI: Reserving SSDT table memory at [mem 0x9692f000-0x9692f08c]
[    0.003184] ACPI: Reserving SSDT table memory at [mem 0x9692e000-0x9692e500]
[    0.003185] ACPI: Reserving SSDT table memory at [mem 0x9692d000-0x9692dcdf]
[    0.003185] ACPI: Reserving SSDT table memory at [mem 0x9692c000-0x9692cbe7]
[    0.003185] ACPI: Reserving SSDT table memory at [mem 0x9692b000-0x9692b749]
[    0.003185] ACPI: Reserving SSDT table memory at [mem 0x9692a000-0x9692aa50]
[    0.003186] ACPI: Reserving SSDT table memory at [mem 0x96929000-0x96929056]
[    0.003186] ACPI: Reserving SSDT table memory at [mem 0x96927000-0x969287b7]
[    0.003235] No NUMA configuration found
[    0.003236] Faking a node at [mem 0x0000000000000000-0x000000055e2fffff]
[    0.003239] NODE_DATA(0) allocated [mem 0x55e2d5240-0x55e2fffff]
[    0.003964] ACPI: PM-Timer IO Port: 0x808
[    0.003968] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.003981] IOAPIC[0]: apic_id 33, version 33, address 0xfec00000, GSI 0-23
[    0.003985] IOAPIC[1]: apic_id 34, version 33, address 0xfec01000, GSI 24-55
[    0.003986] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.003988] ACPI: INT_SRC_OVR (bus 0 bus_irq 1 global_irq 1 low edge)
[    0.003988] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.003990] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.003991] ACPI: HPET id: 0x10228201 base: 0xfed00000
[    0.003994] e820: update [mem 0x8ffe2000-0x905d0fff] System RAM ==> device reserved
[    0.004002] CPU topo: Max. logical packages:   1
[    0.004002] CPU topo: Max. logical dies:       1
[    0.004002] CPU topo: Max. dies per package:   1
[    0.004005] CPU topo: Max. threads per core:   2
[    0.004005] CPU topo: Num. cores per package:     8
[    0.004005] CPU topo: Num. threads per package:  16
[    0.004005] CPU topo: Allowing 16 present CPUs plus 0 hotplug CPUs
[    0.004016] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.004017] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000fffff]
[    0.004017] PM: hibernation: Registered nosave memory: [mem 0x09a7f000-0x09ffffff]
[    0.004018] PM: hibernation: Registered nosave memory: [mem 0x0a200000-0x0a23bfff]
[    0.004019] PM: hibernation: Registered nosave memory: [mem 0x8ffe2000-0x905d0fff]
[    0.004019] PM: hibernation: Registered nosave memory: [mem 0x90802000-0x90802fff]
[    0.004020] PM: hibernation: Registered nosave memory: [mem 0x93f07000-0x9affefff]
[    0.004021] PM: hibernation: Registered nosave memory: [mem 0x9bff9000-0x9bffcfff]
[    0.004021] PM: hibernation: Registered nosave memory: [mem 0x9bfff000-0xffffffff]
[    0.004022] [gap 0xa0000000-0xfedfffff] available for PCI devices
[    0.004023] Booting paravirtualized kernel on bare hardware
[    0.004025] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.007267] Zone ranges:
[    0.007267]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.007268]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.007269]   Normal   [mem 0x0000000100000000-0x000000055e2fffff]
[    0.007269]   Device   empty
[    0.007270] Movable zone start for each node
[    0.007270] Early memory node ranges
[    0.007271]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
[    0.007271]   node   0: [mem 0x0000000000100000-0x0000000009a7efff]
[    0.007272]   node   0: [mem 0x000000000a000000-0x000000000a1fffff]
[    0.007272]   node   0: [mem 0x000000000a23c000-0x0000000093f06fff]
[    0.007272]   node   0: [mem 0x000000009afff000-0x000000009bff8fff]
[    0.007273]   node   0: [mem 0x000000009bffd000-0x000000009bffefff]
[    0.007273]   node   0: [mem 0x0000000100000000-0x000000055e2fffff]
[    0.007274] Initmem setup node 0 [mem 0x0000000000001000-0x000000055e2fffff]
[    0.007278] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.007286] On node 0, zone DMA: 96 pages in unavailable ranges
[    0.007349] On node 0, zone DMA32: 1409 pages in unavailable ranges
[    0.008653] On node 0, zone DMA32: 60 pages in unavailable ranges
[    0.008739] On node 0, zone DMA32: 28920 pages in unavailable ranges
[    0.008740] On node 0, zone DMA32: 4 pages in unavailable ranges
[    0.020490] On node 0, zone Normal: 16385 pages in unavailable ranges
[    0.020512] On node 0, zone Normal: 7424 pages in unavailable ranges
[    0.020520] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:16 nr_cpu_ids:16 nr_node_ids:1
[    0.020758] percpu: Embedded 63 pages/cpu s221184 r8192 d28672 u262144
[    0.020762] pcpu-alloc: s221184 r8192 d28672 u262144 alloc=1*2097152
[    0.020764] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 12 13 14 15 
[    0.020777] Kernel command line: initrd=\initramfs-linux-debug.img amd_pstate=active kvm.mitigate_smt_rsb=1 root=PARTUUID=e57babd5-4363-4337-8f75-0abf8481c852 rootflags=subvol=@ rootfstype=btrfs rw zswap.enabled=0
[    0.021012] printk: log buffer data + meta data: 131072 + 458752 = 589824 bytes
[    0.022271] Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes, linear)
[    0.022937] Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
[    0.023037] software IO TLB: area num 16.
[    0.027899] Fallback order for Node 0: 0 
[    0.027906] Built 1 zonelists, mobility grouping on.  Total pages: 5188581
[    0.027907] Policy zone: Normal
[    0.028006] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    0.044534] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=16, Nodes=1
[    0.052325] ftrace: allocating 54818 entries in 216 pages
[    0.052326] ftrace: allocated 216 pages with 4 groups
[    0.052384] Dynamic Preempt: full
[    0.052430] rcu: Preemptible hierarchical RCU implementation.
[    0.052430] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=16.
[    0.052431] rcu: 	RCU priority boosting: priority 1 delay 500 ms.
[    0.052432] 	Trampoline variant of Tasks RCU enabled.
[    0.052432] 	Rude variant of Tasks RCU enabled.
[    0.052432] 	Tracing variant of Tasks RCU enabled.
[    0.052433] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.052433] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=16
[    0.052440] RCU Tasks: Setting shift to 4 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=16.
[    0.052442] RCU Tasks Rude: Setting shift to 4 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=16.
[    0.055149] NR_IRQS: 524544, nr_irqs: 1096, preallocated irqs: 16
[    0.055327] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.055486] kfence: initialized - using 2097152 bytes for 255 objects at 0x(____ptrval____)-0x(____ptrval____)
[    0.055518] Console: colour dummy device 80x25
[    0.055520] printk: legacy console [tty0] enabled
[    0.055551] ACPI: Core revision 20251212
[    0.055712] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
[    0.055731] APIC: Switch to symmetric I/O mode setup
[    0.055992] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR0, rdevid:0xa0
[    0.055994] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR1, rdevid:0xa0
[    0.055994] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR2, rdevid:0xa0
[    0.055995] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR3, rdevid:0xa0
[    0.055995] AMD-Vi: Using global IVHD EFR:0x246577efa2054ada, EFR2:0x0
[    0.056333] x2apic: IRQ remapping doesn't support X2APIC mode
[    0.057080] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.061734] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x6d57294e0bc, max_idle_ns: 881590807728 ns
[    0.061736] Calibrating delay loop (skipped), value calculated using timer frequency.. 7585.49 BogoMIPS (lpj=3792747)
[    0.061751] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.061981] LVT offset 1 assigned for vector 0xf9
[    0.061982] LVT offset 2 assigned for vector 0xf4
[    0.062139] Last level iTLB entries: 4KB 512, 2MB 512, 4MB 256
[    0.062140] Last level dTLB entries: 4KB 3072, 2MB 3072, 4MB 1536, 1GB 0
[    0.062144] process: using mwait in idle threads
[    0.062145] mitigations: Enabled attack vectors: user_kernel, user_user, guest_host, guest_guest, SMT mitigations: auto
[    0.062147] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    0.062148] Transient Scheduler Attacks: Mitigation: Clear CPU buffers
[    0.062149] Spectre V2 : Mitigation: Enhanced / Automatic IBRS
[    0.062150] Spectre V2 : User space: Mitigation: STIBP always-on protection
[    0.062150] Speculative Return Stack Overflow: Mitigation: Safe RET
[    0.062151] VMSCAPE: Mitigation: IBPB before exit to userspace
[    0.062152] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.062153] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.062155] active return thunk: srso_alias_return_thunk
[    0.062162] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.062163] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.062164] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.062164] x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
[    0.062165] x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
[    0.062165] x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'
[    0.062166] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
[    0.062167] x86/fpu: Supporting XSAVE feature 0x800: 'Control-flow User registers'
[    0.062167] x86/fpu: Supporting XSAVE feature 0x1000: 'Control-flow Kernel registers (KVM only)'
[    0.062168] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.062169] x86/fpu: xstate_offset[5]:  832, xstate_sizes[5]:   64
[    0.062170] x86/fpu: xstate_offset[6]:  896, xstate_sizes[6]:  512
[    0.062171] x86/fpu: xstate_offset[7]: 1408, xstate_sizes[7]: 1024
[    0.062171] x86/fpu: xstate_offset[9]: 2432, xstate_sizes[9]:    8
[    0.062172] x86/fpu: xstate_offset[11]: 2440, xstate_sizes[11]:   16
[    0.062173] x86/fpu: xstate_offset[12]: 2456, xstate_sizes[12]:   24
[    0.062173] x86/fpu: Enabled xstate features 0x1ae7, context size is 2480 bytes, using 'compacted' format.
[    0.085743] Freeing SMP alternatives memory: 56K
[    0.085746] pid_max: default: 32768 minimum: 301
[    0.085864] landlock: Up and running.
[    0.085866] Yama: becoming mindful.
[    0.086032] LSM support for eBPF active
[    0.086078] Mount-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.086100] Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.086164] VFS: Finished mounting rootfs on nullfs
[    0.188537] smpboot: CPU0: AMD Ryzen 7 8745HS w/ Radeon 780M Graphics (family: 0x19, model: 0x75, stepping: 0x2)
[    0.188727] Performance Events: Fam17h+ 16-deep LBR, core perfctr, AMD PMU driver.
[    0.188735] ... version:                   2
[    0.188735] ... bit width:                 48
[    0.188735] ... generic counters:          6
[    0.188735] ... generic bitmap:            000000000000003f
[    0.188735] ... fixed-purpose counters:    0
[    0.188735] ... fixed-purpose bitmap:      0000000000000000
[    0.188735] ... value mask:                0000ffffffffffff
[    0.188735] ... max period:                00007fffffffffff
[    0.188735] ... global_ctrl mask:          000000000000003f
[    0.188735] signal: max sigframe size: 3376
[    0.188735] rcu: Hierarchical SRCU implementation.
[    0.188735] rcu: 	Max phase no-delay instances is 400.
[    0.188735] Timer migration: 2 hierarchy levels; 8 children per group; 2 crossnode level
[    0.192495] MCE: In-kernel MCE decoding enabled.
[    0.192538] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.192668] smp: Bringing up secondary CPUs ...
[    0.192751] smpboot: x86: Booting SMP configuration:
[    0.192752] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8  #9 #10 #11 #12 #13 #14 #15
[    0.203855] Spectre V2 : Update user space SMT mitigation: STIBP always-on
[    0.211774] smp: Brought up 1 node, 16 CPUs
[    0.211774] smpboot: Total of 16 processors activated (121367.90 BogoMIPS)
[    0.212928] Memory: 20174756K/20754324K available (19661K kernel code, 3530K rwdata, 15400K rodata, 4664K init, 4456K bss, 555796K reserved, 0K cma-reserved)
[    0.213130] devtmpfs: initialized
[    0.213130] x86/mm: Memory block size: 128MB
[    0.215280] ACPI: PM: Registering ACPI NVS region [mem 0x0a200000-0x0a23bfff] (245760 bytes)
[    0.215280] ACPI: PM: Registering ACPI NVS region [mem 0x9698a000-0x97404fff] (10989568 bytes)
[    0.215280] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.215280] posixtimers hash table entries: 8192 (order: 5, 131072 bytes, linear)
[    0.215280] futex hash table entries: 4096 (262144 bytes on 1 NUMA nodes, total 256 KiB, linear).
[    0.215280] xor: automatically using best checksumming function   avx       
[    0.215280] PM: RTC time: 17:44:56, date: 2026-03-03
[    0.215977] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.216227] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic allocations
[    0.216341] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.216476] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.216482] audit: initializing netlink subsys (disabled)
[    0.216488] audit: type=2000 audit(1772559896.159:1): state=initialized audit_enabled=0 res=1
[    0.216488] thermal_sys: Registered thermal governor 'fair_share'
[    0.216488] thermal_sys: Registered thermal governor 'bang_bang'
[    0.216488] thermal_sys: Registered thermal governor 'step_wise'
[    0.216488] thermal_sys: Registered thermal governor 'user_space'
[    0.216488] thermal_sys: Registered thermal governor 'power_allocator'
[    0.216488] cpuidle: using governor ladder
[    0.216488] cpuidle: using governor menu
[    0.216805] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.216867] PCI: ECAM [mem 0xe0000000-0xefffffff] (base 0xe0000000) for domain 0000 [bus 00-ff]
[    0.216880] PCI: Using configuration type 1 for base access
[    0.217006] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    0.221914] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.221916] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.221917] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.221918] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.226171] raid6: skipped pq benchmark and selected avx512x4
[    0.226173] raid6: using avx512x2 recovery algorithm
[    0.226257] ACPI: Added _OSI(Module Device)
[    0.226258] ACPI: Added _OSI(Processor Device)
[    0.226260] ACPI: Added _OSI(Processor Aggregator Device)
[    0.248426] ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.GPP5.RTL8._S0W], AE_ALREADY_EXISTS (20251212/dswload2-326)
[    0.248434] fbcon: Taking over console
[    0.248735] ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20251212/psobject-220)
[    0.249074] ACPI: 29 ACPI AML tables successfully acquired and loaded
[    0.262744] ACPI: \_SB_: platform _OSC: OS support mask [006e7efe]
[    0.263032] ACPI: \_SB_: platform _OSC: OS control mask [006e7e7e]
[    0.263086] ACPI: USB4 _OSC: OS supports USB3+ DisplayPort+ PCIe+ XDomain+
[    0.263087] ACPI: USB4 _OSC: OS controls USB3+ DisplayPort+ PCIe+ XDomain+
[    0.264526] ACPI: Interpreter enabled
[    0.264538] ACPI: PM: (supports S0 S4 S5)
[    0.264539] ACPI: Using IOAPIC for interrupt routing
[    0.265945] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.265946] PCI: Ignoring E820 reservations for host bridge windows
[    0.266452] ACPI: Enabled 3 GPEs in block 00 to 1F
[    0.267753] ACPI: \_SB_.PCI0.GPP2.P0WW: New power resource
[    0.268832] ACPI: \_SB_.PCI0.GPP6.PWSR: New power resource
[    0.270270] ACPI: \_SB_.PCI0.GPP8.P0NV: New power resource
[    0.272225] ACPI: \_SB_.PCI0.GP11.PWRS: New power resource
[    0.273591] ACPI: \_SB_.PCI0.GP11.SWUS.PWRS: New power resource
[    0.274193] ACPI: \_SB_.PCI0.GP12.PWRS: New power resource
[    0.274837] ACPI: \_SB_.PCI0.GP12.SWUS.PWRS: New power resource
[    0.275084] ACPI: \_SB_.PCI0.GP17.PWRS: New power resource
[    0.275344] ACPI: \_SB_.PCI0.GP17.VGA_.PWRS: New power resource
[    0.275664] ACPI: \_SB_.PCI0.GP17.HDAU.PWRS: New power resource
[    0.275931] ACPI: \_SB_.PCI0.GP17.ACP_.PWRS: New power resource
[    0.276578] ACPI: \_SB_.PCI0.GP17.AZAL.PWRS: New power resource
[    0.277204] ACPI: \_SB_.PCI0.GP17.XHC0.PWRS: New power resource
[    0.279986] ACPI: \_SB_.PCI0.GP17.XHC1.PWRS: New power resource
[    0.282097] ACPI: \_SB_.PCI0.GP19.XHC2.PWRS: New power resource
[    0.283527] ACPI: \_SB_.PCI0.GP19.XHC3.PWRS: New power resource
[    0.285004] ACPI: \_SB_.PCI0.GP19.XHC4.PWRS: New power resource
[    0.286472] ACPI: \_SB_.PCI0.GP19.NHI0.PWRS: New power resource
[    0.287295] ACPI: \_SB_.PCI0.GP19.NHI1.PWRS: New power resource
[    0.298581] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.298586] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
[    0.298751] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME AER PCIeCapability LTR DPC]
[    0.299340] PCI host bridge to bus 0000:00
[    0.299343] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    0.299345] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    0.299347] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
[    0.299348] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.299349] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000dffff window]
[    0.299351] pci_bus 0000:00: root bus resource [mem 0xfa000000-0xfcffffff window]
[    0.299352] pci_bus 0000:00: root bus resource [mem 0xf0000000-0xf9ffffff window]
[    0.299353] pci_bus 0000:00: root bus resource [mem 0xa0000000-0xdfffffff window]
[    0.299354] pci_bus 0000:00: root bus resource [mem 0x660000000-0x7fffffffff window]
[    0.299356] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.299369] pci 0000:00:00.0: [1022:14e8] type 00 class 0x060000 conventional PCI endpoint
[    0.299478] pci 0000:00:00.2: [1022:14e9] type 00 class 0x080600 conventional PCI endpoint
[    0.299580] pci 0000:00:01.0: [1022:14ea] type 00 class 0x060000 conventional PCI endpoint
[    0.299649] pci 0000:00:02.0: [1022:14ea] type 00 class 0x060000 conventional PCI endpoint
[    0.299717] pci 0000:00:02.1: [1022:14ee] type 01 class 0x060400 PCIe Root Port
[    0.299733] pci 0000:00:02.1: PCI bridge to [bus 01]
[    0.299740] pci 0000:00:02.1:   bridge window [io  0xf000-0xffff]
[    0.299743] pci 0000:00:02.1:   bridge window [mem 0xdcb00000-0xdcbfffff]
[    0.299756] pci 0000:00:02.1: enabling Extended Tags
[    0.299829] pci 0000:00:02.1: PME# supported from D0 D3hot D3cold
[    0.299971] pci 0000:00:02.2: [1022:14ee] type 01 class 0x060400 PCIe Root Port
[    0.299988] pci 0000:00:02.2: PCI bridge to [bus 02]
[    0.299993] pci 0000:00:02.2:   bridge window [mem 0xdca00000-0xdcafffff]
[    0.300007] pci 0000:00:02.2: enabling Extended Tags
[    0.300078] pci 0000:00:02.2: PME# supported from D0 D3hot D3cold
[    0.300217] pci 0000:00:02.3: [1022:14ee] type 01 class 0x060400 PCIe Root Port
[    0.300233] pci 0000:00:02.3: PCI bridge to [bus 03]
[    0.300251] pci 0000:00:02.3: enabling Extended Tags
[    0.300322] pci 0000:00:02.3: PME# supported from D0 D3hot D3cold
[    0.300459] pci 0000:00:02.4: [1022:14ee] type 01 class 0x060400 PCIe Root Port
[    0.300475] pci 0000:00:02.4: PCI bridge to [bus 04]
[    0.300481] pci 0000:00:02.4:   bridge window [mem 0xdc900000-0xdc9fffff]
[    0.300563] pci 0000:00:02.4: PME# supported from D0 D3hot D3cold
[    0.300690] pci 0000:00:03.0: [1022:14ea] type 00 class 0x060000 conventional PCI endpoint
[    0.300769] pci 0000:00:03.1: [1022:14ef] type 01 class 0x060400 PCIe Root Port
[    0.300878] pci 0000:00:03.1: PCI bridge to [bus 05-64]
[    0.300883] pci 0000:00:03.1:   bridge window [io  0xa000-0xdfff]
[    0.300886] pci 0000:00:03.1:   bridge window [mem 0xc4000000-0xdbffffff]
[    0.300911] pci 0000:00:03.1:   bridge window [mem 0x6c00000000-0x7bffffffff 64bit pref]
[    0.300922] pci 0000:00:03.1: enabling Extended Tags
[    0.301207] pci 0000:00:03.1: PME# supported from D0 D3hot D3cold
[    0.302627] pci 0000:00:04.0: [1022:14ea] type 00 class 0x060000 conventional PCI endpoint
[    0.302701] pci 0000:00:08.0: [1022:14ea] type 00 class 0x060000 conventional PCI endpoint
[    0.302767] pci 0000:00:08.1: [1022:14eb] type 01 class 0x060400 PCIe Root Port
[    0.302781] pci 0000:00:08.1: PCI bridge to [bus 65]
[    0.302785] pci 0000:00:08.1:   bridge window [io  0xe000-0xefff]
[    0.302787] pci 0000:00:08.1:   bridge window [mem 0xdc000000-0xdc5fffff]
[    0.302793] pci 0000:00:08.1:   bridge window [mem 0x7c00000000-0x7c107fffff 64bit pref]
[    0.302799] pci 0000:00:08.1: enabling Extended Tags
[    0.302838] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
[    0.303103] pci 0000:00:08.2: [1022:14eb] type 01 class 0x060400 PCIe Root Port
[    0.303117] pci 0000:00:08.2: PCI bridge to [bus 66]
[    0.303132] pci 0000:00:08.2: enabling Extended Tags
[    0.303170] pci 0000:00:08.2: PME# supported from D0 D3hot D3cold
[    0.303273] pci 0000:00:08.3: [1022:14eb] type 01 class 0x060400 PCIe Root Port
[    0.303287] pci 0000:00:08.3: PCI bridge to [bus 67]
[    0.303292] pci 0000:00:08.3:   bridge window [mem 0xdc600000-0xdc8fffff]
[    0.303302] pci 0000:00:08.3: enabling Extended Tags
[    0.303341] pci 0000:00:08.3: PME# supported from D0 D3hot D3cold
[    0.303629] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500 conventional PCI endpoint
[    0.303747] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100 conventional PCI endpoint
[    0.303876] pci 0000:00:18.0: [1022:14f0] type 00 class 0x060000 conventional PCI endpoint
[    0.303910] pci 0000:00:18.1: [1022:14f1] type 00 class 0x060000 conventional PCI endpoint
[    0.303945] pci 0000:00:18.2: [1022:14f2] type 00 class 0x060000 conventional PCI endpoint
[    0.303978] pci 0000:00:18.3: [1022:14f3] type 00 class 0x060000 conventional PCI endpoint
[    0.304014] pci 0000:00:18.4: [1022:14f4] type 00 class 0x060000 conventional PCI endpoint
[    0.304048] pci 0000:00:18.5: [1022:14f5] type 00 class 0x060000 conventional PCI endpoint
[    0.304082] pci 0000:00:18.6: [1022:14f6] type 00 class 0x060000 conventional PCI endpoint
[    0.304117] pci 0000:00:18.7: [1022:14f7] type 00 class 0x060000 conventional PCI endpoint
[    0.304261] pci 0000:01:00.0: [10ec:8125] type 00 class 0x020000 PCIe Endpoint
[    0.304309] pci 0000:01:00.0: BAR 0 [io  0xf000-0xf0ff]
[    0.304314] pci 0000:01:00.0: BAR 2 [mem 0xdcb00000-0xdcb0ffff 64bit]
[    0.304318] pci 0000:01:00.0: BAR 4 [mem 0xdcb10000-0xdcb13fff 64bit]
[    0.304421] pci 0000:01:00.0: supports D1 D2
[    0.304423] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.304678] pci 0000:00:02.1: PCI bridge to [bus 01]
[    0.305096] pci 0000:02:00.0: [8086:2723] type 00 class 0x028000 PCIe Endpoint
[    0.305177] pci 0000:02:00.0: BAR 0 [mem 0xdca00000-0xdca03fff 64bit]
[    0.305330] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.306311] pci 0000:00:02.2: PCI bridge to [bus 02]
[    0.306432] pci 0000:00:02.3: PCI bridge to [bus 03]
[    0.306543] pci 0000:04:00.0: [1344:5416] type 00 class 0x010802 PCIe Endpoint
[    0.306579] pci 0000:04:00.0: BAR 0 [mem 0xdc900000-0xdc903fff 64bit]
[    0.306986] pci 0000:00:02.4: PCI bridge to [bus 04]
[    0.307081] pci 0000:00:03.1: PCI bridge to [bus 05-64]
[    0.307200] pci 0000:65:00.0: [1002:1900] type 00 class 0x030000 PCIe Legacy Endpoint
[    0.307228] pci 0000:65:00.0: BAR 0 [mem 0x7c00000000-0x7c0fffffff 64bit pref]
[    0.307230] pci 0000:65:00.0: BAR 2 [mem 0xdc000000-0xdc1fffff 64bit pref]
[    0.307232] pci 0000:65:00.0: BAR 4 [io  0xe000-0xe0ff]
[    0.307234] pci 0000:65:00.0: BAR 5 [mem 0xdc500000-0xdc57ffff]
[    0.307240] pci 0000:65:00.0: enabling Extended Tags
[    0.307304] pci 0000:65:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.307622] pci 0000:65:00.1: [1002:1640] type 00 class 0x040300 PCIe Legacy Endpoint
[    0.307647] pci 0000:65:00.1: BAR 0 [mem 0xdc5c8000-0xdc5cbfff]
[    0.307656] pci 0000:65:00.1: enabling Extended Tags
[    0.307696] pci 0000:65:00.1: PME# supported from D1 D2 D3hot D3cold
[    0.307934] pci 0000:65:00.2: [1022:15c7] type 00 class 0x108000 PCIe Endpoint
[    0.307961] pci 0000:65:00.2: BAR 2 [mem 0xdc400000-0xdc4fffff]
[    0.307965] pci 0000:65:00.2: BAR 5 [mem 0xdc5cc000-0xdc5cdfff]
[    0.307970] pci 0000:65:00.2: enabling Extended Tags
[    0.308099] pci 0000:65:00.3: [1022:15b9] type 00 class 0x0c0330 PCIe Endpoint
[    0.308126] pci 0000:65:00.3: BAR 0 [mem 0xdc300000-0xdc3fffff 64bit]
[    0.308135] pci 0000:65:00.3: enabling Extended Tags
[    0.308176] pci 0000:65:00.3: PME# supported from D0 D3hot D3cold
[    0.308420] pci 0000:65:00.4: [1022:15ba] type 00 class 0x0c0330 PCIe Endpoint
[    0.308447] pci 0000:65:00.4: BAR 0 [mem 0xdc200000-0xdc2fffff 64bit]
[    0.308455] pci 0000:65:00.4: enabling Extended Tags
[    0.308497] pci 0000:65:00.4: PME# supported from D0 D3hot D3cold
[    0.308747] pci 0000:65:00.5: [1022:15e2] type 00 class 0x048000 PCIe Endpoint
[    0.308772] pci 0000:65:00.5: BAR 0 [mem 0xdc580000-0xdc5bffff]
[    0.308775] pci 0000:65:00.5: BAR 2 [mem 0x7c10000000-0x7c107fffff 64bit pref]
[    0.308782] pci 0000:65:00.5: enabling Extended Tags
[    0.308822] pci 0000:65:00.5: PME# supported from D0 D3hot D3cold
[    0.309065] pci 0000:65:00.6: [1022:15e3] type 00 class 0x040300 PCIe Endpoint
[    0.309090] pci 0000:65:00.6: BAR 0 [mem 0xdc5c0000-0xdc5c7fff]
[    0.309099] pci 0000:65:00.6: enabling Extended Tags
[    0.309138] pci 0000:65:00.6: PME# supported from D0 D3hot D3cold
[    0.309390] pci 0000:00:08.1: PCI bridge to [bus 65]
[    0.309447] pci 0000:66:00.0: [1022:14ec] type 00 class 0x130000 PCIe Endpoint
[    0.309479] pci 0000:66:00.0: enabling Extended Tags
[    0.309531] pci 0000:66:00.0: PME# supported from D3hot D3cold
[    0.309626] pci 0000:00:08.2: PCI bridge to [bus 66]
[    0.309707] pci 0000:67:00.0: [1022:14ec] type 00 class 0x130000 PCIe Endpoint
[    0.309741] pci 0000:67:00.0: enabling Extended Tags
[    0.310223] pci 0000:67:00.3: [1022:15c0] type 00 class 0x0c0330 PCIe Endpoint
[    0.310250] pci 0000:67:00.3: BAR 0 [mem 0xdc700000-0xdc7fffff 64bit]
[    0.310259] pci 0000:67:00.3: enabling Extended Tags
[    0.310301] pci 0000:67:00.3: PME# supported from D0 D3hot D3cold
[    0.310708] pci 0000:67:00.4: [1022:15c1] type 00 class 0x0c0330 PCIe Endpoint
[    0.310736] pci 0000:67:00.4: BAR 0 [mem 0xdc600000-0xdc6fffff 64bit]
[    0.310745] pci 0000:67:00.4: enabling Extended Tags
[    0.310787] pci 0000:67:00.4: PME# supported from D0 D3hot D3cold
[    0.311186] pci 0000:67:00.5: [1022:1668] type 00 class 0x0c0340 PCIe Endpoint
[    0.311217] pci 0000:67:00.5: BAR 0 [mem 0xdc800000-0xdc87ffff 64bit]
[    0.311226] pci 0000:67:00.5: enabling Extended Tags
[    0.311268] pci 0000:67:00.5: PME# supported from D0 D3hot D3cold
[    0.311679] pci 0000:00:08.3: PCI bridge to [bus 67]
[    0.319043] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.319097] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
[    0.319143] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.319200] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.319252] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.319295] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.319338] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.319381] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    0.320842] Low-power S0 idle used by default for system suspend
[    0.321135] iommu: Default domain type: Translated
[    0.321135] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.321852] SCSI subsystem initialized
[    0.321857] libata version 3.00 loaded.
[    0.321857] ACPI: bus type USB registered
[    0.321857] usbcore: registered new interface driver usbfs
[    0.321857] usbcore: registered new interface driver hub
[    0.321857] usbcore: registered new device driver usb
[    0.321857] EDAC MC: Ver: 3.0.0
[    0.322089] efivars: Registered efivars operations
[    0.322089] NetLabel: Initializing
[    0.322089] NetLabel:  domain hash size = 128
[    0.322089] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.322089] NetLabel:  unlabeled traffic allowed by default
[    0.322089] mctp: management component transport protocol core
[    0.322089] NET: Registered PF_MCTP protocol family
[    0.322089] PCI: Using ACPI for IRQ routing
[    0.331303] PCI: pci_cache_line_size set to 64 bytes
[    0.331760] e820: register RAM buffer resource [mem 0x09a7f000-0x0bffffff]
[    0.331761] e820: register RAM buffer resource [mem 0x0a200000-0x0bffffff]
[    0.331762] e820: register RAM buffer resource [mem 0x8ffe2000-0x8fffffff]
[    0.331763] e820: register RAM buffer resource [mem 0x90802000-0x93ffffff]
[    0.331764] e820: register RAM buffer resource [mem 0x93f07000-0x93ffffff]
[    0.331765] e820: register RAM buffer resource [mem 0x9bff9000-0x9bffffff]
[    0.331766] e820: register RAM buffer resource [mem 0x9bfff000-0x9bffffff]
[    0.331767] e820: register RAM buffer resource [mem 0x55e300000-0x55fffffff]
[    0.331814] pci 0000:65:00.0: vgaarb: setting as boot VGA device
[    0.331814] pci 0000:65:00.0: vgaarb: bridge control possible
[    0.331814] pci 0000:65:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
[    0.331814] vgaarb: loaded
[    0.331814] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.331814] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.333794] clocksource: Switched to clocksource tsc-early
[    0.333909] VFS: Disk quotas dquot_6.6.0
[    0.333917] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.333975] acpi PNP0C01:00: Reserved [mem 0xe0000000-0xefffffff]
[    0.333999] acpi PNP0C02:00: Reserved [mem 0xfd300000-0xfd3fffff]
[    0.334128] acpi PNP0C02:01: Reserved [io  0x0a00-0x0a0f]
[    0.334130] acpi PNP0C02:01: Reserved [io  0x0a10-0x0a1f]
[    0.334131] acpi PNP0C02:01: Reserved [io  0x0a20-0x0a2f]
[    0.334298] acpi PNP0C02:02: Skipped [io  0x0010-0x001f]
[    0.334300] acpi PNP0C02:02: Skipped [io  0x0022-0x003f]
[    0.334301] acpi PNP0C02:02: Skipped [io  0x0063]
[    0.334302] acpi PNP0C02:02: Skipped [io  0x0065]
[    0.334303] acpi PNP0C02:02: Skipped [io  0x0067-0x006f]
[    0.334304] acpi PNP0C02:02: Skipped [io  0x0072-0x007f]
[    0.334305] acpi PNP0C02:02: Skipped [io  0x0080]
[    0.334306] acpi PNP0C02:02: Skipped [io  0x0084-0x0086]
[    0.334307] acpi PNP0C02:02: Skipped [io  0x0088]
[    0.334308] acpi PNP0C02:02: Skipped [io  0x008c-0x008e]
[    0.334309] acpi PNP0C02:02: Skipped [io  0x0090-0x009f]
[    0.334310] acpi PNP0C02:02: Skipped [io  0x00a2-0x00bf]
[    0.334312] acpi PNP0C02:02: Skipped [io  0x00b1]
[    0.334313] acpi PNP0C02:02: Skipped [io  0x00e0-0x00ef]
[    0.334314] acpi PNP0C02:02: Reserved [io  0x04d0-0x04d1]
[    0.334315] acpi PNP0C02:02: Reserved [io  0x040b]
[    0.334316] acpi PNP0C02:02: Reserved [io  0x04d6]
[    0.334317] acpi PNP0C02:02: Reserved [io  0x0c00-0x0c01]
[    0.334318] acpi PNP0C02:02: Reserved [io  0x0c14]
[    0.334320] acpi PNP0C02:02: Reserved [io  0x0c50-0x0c51]
[    0.334321] acpi PNP0C02:02: Reserved [io  0x0c52]
[    0.334322] acpi PNP0C02:02: Reserved [io  0x0c6c]
[    0.334323] acpi PNP0C02:02: Reserved [io  0x0c6f]
[    0.334324] acpi PNP0C02:02: Reserved [io  0x0cd0-0x0cd1]
[    0.334325] acpi PNP0C02:02: Reserved [io  0x0cd2-0x0cd3]
[    0.334327] acpi PNP0C02:02: Reserved [io  0x0cd4-0x0cd5]
[    0.334328] acpi PNP0C02:02: Reserved [io  0x0cd6-0x0cd7]
[    0.334329] acpi PNP0C02:02: Reserved [io  0x0cd8-0x0cdf]
[    0.334330] acpi PNP0C02:02: Reserved [io  0x0800-0x089f]
[    0.334331] acpi PNP0C02:02: Reserved [io  0x0b00-0x0b0f]
[    0.334332] acpi PNP0C02:02: Reserved [io  0x0b20-0x0b3f]
[    0.334334] acpi PNP0C02:02: Reserved [io  0x0900-0x090f]
[    0.334335] acpi PNP0C02:02: Reserved [io  0x0910-0x091f]
[    0.334336] acpi PNP0C02:02: Could not reserve [mem 0xfec00000-0xfec00fff]
[    0.334337] acpi PNP0C02:02: Could not reserve [mem 0xfec01000-0xfec01fff]
[    0.334339] acpi PNP0C02:02: Reserved [mem 0xfedc0000-0xfedc0fff]
[    0.334340] acpi PNP0C02:02: Reserved [mem 0xfee00000-0xfee00fff]
[    0.334342] acpi PNP0C02:02: Could not reserve [mem 0xfed80000-0xfed8ffff]
[    0.334343] acpi PNP0C02:02: Reserved [mem 0xfec10000-0xfec10fff]
[    0.334345] acpi PNP0C02:02: Reserved [mem 0xff000000-0xffffffff]
[    0.334376] pnp: PnP ACPI init
[    0.337301] pnp 00:00: [dma 0 disabled]
[    0.338516] pnp: PnP ACPI: found 1 devices
[    0.344454] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.344545] NET: Registered PF_INET protocol family
[    0.344660] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.347286] tcp_listen_portaddr_hash hash table entries: 16384 (order: 6, 262144 bytes, linear)
[    0.347307] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.347391] TCP established hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.347574] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes, linear)
[    0.347629] TCP: Hash tables configured (established 262144 bind 65536)
[    0.347710] MPTCP token hash table entries: 32768 (order: 8, 786432 bytes, linear)
[    0.347776] UDP hash table entries: 16384 (order: 8, 1048576 bytes, linear)
[    0.347852] UDP-Lite hash table entries: 16384 (order: 8, 1048576 bytes, linear)
[    0.347929] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.347936] NET: Registered PF_XDP protocol family
[    0.347941] pci 0000:00:02.3: bridge window [io  0x1000-0x0fff] to [bus 03] add_size 1000
[    0.347944] pci 0000:00:02.3: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 03] add_size 200000 add_align 100000
[    0.347946] pci 0000:00:02.3: bridge window [mem 0x00100000-0x000fffff] to [bus 03] add_size 200000 add_align 100000
[    0.347953] pci 0000:00:02.3: bridge window [mem 0xfa000000-0xfa1fffff]: assigned
[    0.347955] pci 0000:00:02.3: bridge window [mem 0x660000000-0x6601fffff 64bit pref]: assigned
[    0.347957] pci 0000:00:02.3: bridge window [io  0x1000-0x1fff]: assigned
[    0.347960] pci 0000:00:02.1: PCI bridge to [bus 01]
[    0.347967] pci 0000:00:02.1:   bridge window [io  0xf000-0xffff]
[    0.347970] pci 0000:00:02.1:   bridge window [mem 0xdcb00000-0xdcbfffff]
[    0.347994] pci 0000:00:02.2: PCI bridge to [bus 02]
[    0.347997] pci 0000:00:02.2:   bridge window [mem 0xdca00000-0xdcafffff]
[    0.348023] pci 0000:00:02.3: PCI bridge to [bus 03]
[    0.348024] pci 0000:00:02.3:   bridge window [io  0x1000-0x1fff]
[    0.348027] pci 0000:00:02.3:   bridge window [mem 0xfa000000-0xfa1fffff]
[    0.348030] pci 0000:00:02.3:   bridge window [mem 0x660000000-0x6601fffff 64bit pref]
[    0.348054] pci 0000:00:02.4: PCI bridge to [bus 04]
[    0.348057] pci 0000:00:02.4:   bridge window [mem 0xdc900000-0xdc9fffff]
[    0.348082] pci 0000:00:03.1: PCI bridge to [bus 05-64]
[    0.348084] pci 0000:00:03.1:   bridge window [io  0xa000-0xdfff]
[    0.348093] pci 0000:00:03.1:   bridge window [mem 0xc4000000-0xdbffffff]
[    0.348106] pci 0000:00:03.1:   bridge window [mem 0x6c00000000-0x7bffffffff 64bit pref]
[    0.348134] pci 0000:00:08.1: PCI bridge to [bus 65]
[    0.348135] pci 0000:00:08.1:   bridge window [io  0xe000-0xefff]
[    0.348141] pci 0000:00:08.1:   bridge window [mem 0xdc000000-0xdc5fffff]
[    0.348143] pci 0000:00:08.1:   bridge window [mem 0x7c00000000-0x7c107fffff 64bit pref]
[    0.348146] pci 0000:00:08.2: PCI bridge to [bus 66]
[    0.348153] pci 0000:00:08.3: PCI bridge to [bus 67]
[    0.348155] pci 0000:00:08.3:   bridge window [mem 0xdc600000-0xdc8fffff]
[    0.348160] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    0.348161] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
[    0.348162] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
[    0.348164] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    0.348165] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000dffff window]
[    0.348166] pci_bus 0000:00: resource 9 [mem 0xfa000000-0xfcffffff window]
[    0.348167] pci_bus 0000:00: resource 10 [mem 0xf0000000-0xf9ffffff window]
[    0.348168] pci_bus 0000:00: resource 11 [mem 0xa0000000-0xdfffffff window]
[    0.348170] pci_bus 0000:00: resource 12 [mem 0x660000000-0x7fffffffff window]
[    0.348171] pci_bus 0000:01: resource 0 [io  0xf000-0xffff]
[    0.348172] pci_bus 0000:01: resource 1 [mem 0xdcb00000-0xdcbfffff]
[    0.348174] pci_bus 0000:02: resource 1 [mem 0xdca00000-0xdcafffff]
[    0.348175] pci_bus 0000:03: resource 0 [io  0x1000-0x1fff]
[    0.348176] pci_bus 0000:03: resource 1 [mem 0xfa000000-0xfa1fffff]
[    0.348177] pci_bus 0000:03: resource 2 [mem 0x660000000-0x6601fffff 64bit pref]
[    0.348179] pci_bus 0000:04: resource 1 [mem 0xdc900000-0xdc9fffff]
[    0.348180] pci_bus 0000:05: resource 0 [io  0xa000-0xdfff]
[    0.348181] pci_bus 0000:05: resource 1 [mem 0xc4000000-0xdbffffff]
[    0.348182] pci_bus 0000:05: resource 2 [mem 0x6c00000000-0x7bffffffff 64bit pref]
[    0.348184] pci_bus 0000:65: resource 0 [io  0xe000-0xefff]
[    0.348185] pci_bus 0000:65: resource 1 [mem 0xdc000000-0xdc5fffff]
[    0.348186] pci_bus 0000:65: resource 2 [mem 0x7c00000000-0x7c107fffff 64bit pref]
[    0.348187] pci_bus 0000:67: resource 1 [mem 0xdc600000-0xdc8fffff]
[    0.348550] pci 0000:65:00.1: D0 power state depends on 0000:65:00.0
[    0.348903] PCI: CLS 64 bytes, default 64
[    0.348920] pci 0000:00:00.2: AMD-Vi: IOMMU performance counters supported
[    0.348960] Unpacking initramfs...
[    0.348967] pci 0000:00:01.0: Adding to iommu group 0
[    0.349010] pci 0000:00:02.0: Adding to iommu group 1
[    0.349023] pci 0000:00:02.1: Adding to iommu group 2
[    0.349039] pci 0000:00:02.2: Adding to iommu group 3
[    0.349052] pci 0000:00:02.3: Adding to iommu group 4
[    0.349065] pci 0000:00:02.4: Adding to iommu group 5
[    0.349086] pci 0000:00:03.0: Adding to iommu group 6
[    0.349096] pci 0000:00:03.1: Adding to iommu group 6
[    0.349112] pci 0000:00:04.0: Adding to iommu group 7
[    0.349151] pci 0000:00:08.0: Adding to iommu group 8
[    0.349163] pci 0000:00:08.1: Adding to iommu group 9
[    0.349179] pci 0000:00:08.2: Adding to iommu group 10
[    0.349191] pci 0000:00:08.3: Adding to iommu group 11
[    0.349212] pci 0000:00:14.0: Adding to iommu group 12
[    0.349223] pci 0000:00:14.3: Adding to iommu group 12
[    0.349275] pci 0000:00:18.0: Adding to iommu group 13
[    0.349287] pci 0000:00:18.1: Adding to iommu group 13
[    0.349298] pci 0000:00:18.2: Adding to iommu group 13
[    0.349310] pci 0000:00:18.3: Adding to iommu group 13
[    0.349322] pci 0000:00:18.4: Adding to iommu group 13
[    0.349333] pci 0000:00:18.5: Adding to iommu group 13
[    0.349345] pci 0000:00:18.6: Adding to iommu group 13
[    0.349358] pci 0000:00:18.7: Adding to iommu group 13
[    0.349377] pci 0000:01:00.0: Adding to iommu group 14
[    0.349389] pci 0000:02:00.0: Adding to iommu group 15
[    0.349400] pci 0000:04:00.0: Adding to iommu group 16
[    0.349433] pci 0000:65:00.0: Adding to iommu group 17
[    0.349446] pci 0000:65:00.1: Adding to iommu group 18
[    0.349459] pci 0000:65:00.2: Adding to iommu group 19
[    0.349475] pci 0000:65:00.3: Adding to iommu group 20
[    0.349490] pci 0000:65:00.4: Adding to iommu group 21
[    0.349504] pci 0000:65:00.5: Adding to iommu group 22
[    0.349517] pci 0000:65:00.6: Adding to iommu group 23
[    0.349531] pci 0000:66:00.0: Adding to iommu group 24
[    0.349544] pci 0000:67:00.0: Adding to iommu group 25
[    0.349558] pci 0000:67:00.3: Adding to iommu group 26
[    0.349571] pci 0000:67:00.4: Adding to iommu group 27
[    0.349584] pci 0000:67:00.5: Adding to iommu group 28
[    0.351553] AMD-Vi: Extended features (0x246577efa2054ada, 0x0): PPR NX GT IA GA PC
[    0.351561] AMD-Vi: Interrupt remapping enabled
[    0.351665] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.351667] software IO TLB: mapped [mem 0x000000007e289000-0x0000000082289000] (64MB)
[    0.351722] LVT offset 0 assigned for vector 0x400
[    0.352443] perf: AMD IBS detected (0x00000bff)
[    0.352448] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 counters/bank).
[    0.365848] Initialise system trusted keyrings
[    0.365858] Key type blacklist registered
[    0.365943] workingset: timestamp_bits=36 (anon: 32) max_order=23 bucket_order=0 (anon: 0)
[    0.366191] fuse: init (API version 7.45)
[    0.366256] integrity: Platform Keyring initialized
[    0.366258] integrity: Machine keyring initialized
[    0.372870] Key type asymmetric registered
[    0.372871] Asymmetric key parser 'x509' registered
[    0.372890] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 245)
[    0.372943] io scheduler mq-deadline registered
[    0.372944] io scheduler kyber registered
[    0.372955] io scheduler bfq registered
[    0.374498] ledtrig-cpu: registered to indicate activity on CPUs
[    0.374608] pcieport 0000:00:02.1: PME: Signaling with IRQ 42
[    0.374734] pcieport 0000:00:02.2: PME: Signaling with IRQ 43
[    0.374858] pcieport 0000:00:02.3: PME: Signaling with IRQ 44
[    0.374876] pcieport 0000:00:02.3: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.375039] pcieport 0000:00:02.4: PME: Signaling with IRQ 45
[    0.375223] pcieport 0000:00:03.1: PME: Signaling with IRQ 46
[    0.375340] pcieport 0000:00:03.1: AER: enabled with IRQ 46
[    0.375365] pcieport 0000:00:03.1: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.375750] pcieport 0000:00:08.1: PME: Signaling with IRQ 47
[    0.375916] pcieport 0000:00:08.2: PME: Signaling with IRQ 48
[    0.376019] pcieport 0000:00:08.3: PME: Signaling with IRQ 49
[    0.376236] input: Power Button as /devices/platform/PNP0C0C:00/input/input0
[    0.376259] ACPI: button: Power Button [PWRB]
[    0.376287] Monitor-Mwait will be used to enter C-1 state
[    0.378816] Estimated ratio of average max frequency by base frequency (times 1024): 1181
[    0.379143] acpi LNXTHERM:00: registered as thermal_zone0
[    0.379147] ACPI: thermal: Thermal Zone [TZ01] (20 C)
[    0.379448] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.379734] 00:00: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    0.383449] Non-volatile memory driver v1.3
[    0.383451] Linux agpgart interface v0.103
[    0.385173] Freeing initrd memory: 43868K
[    0.416394] xhci_hcd 0000:65:00.3: xHCI Host Controller
[    0.416399] xhci_hcd 0000:65:00.3: new USB bus registered, assigned bus number 1
[    0.416847] xhci_hcd 0000:65:00.3: hcc params 0x0128ffc5 hci version 0x120 quirks 0x0000000200000010
[    0.417219] xhci_hcd 0000:65:00.3: xHCI Host Controller
[    0.417222] xhci_hcd 0000:65:00.3: new USB bus registered, assigned bus number 2
[    0.417224] xhci_hcd 0000:65:00.3: Host supports USB 3.1 Enhanced SuperSpeed
[    0.417256] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 7.00
[    0.417258] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.417260] usb usb1: Product: xHCI Host Controller
[    0.417261] usb usb1: Manufacturer: Linux 7.0.0-rc2-debug-next-20260303-03431-gc025f6cf4209 xhci-hcd
[    0.417262] usb usb1: SerialNumber: 0000:65:00.3
[    0.417358] hub 1-0:1.0: USB hub found
[    0.417370] hub 1-0:1.0: 5 ports detected
[    0.420863] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[    0.420879] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 7.00
[    0.420881] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.420882] usb usb2: Product: xHCI Host Controller
[    0.420883] usb usb2: Manufacturer: Linux 7.0.0-rc2-debug-next-20260303-03431-gc025f6cf4209 xhci-hcd
[    0.420884] usb usb2: SerialNumber: 0000:65:00.3
[    0.420955] hub 2-0:1.0: USB hub found
[    0.420964] hub 2-0:1.0: 2 ports detected
[    0.422517] xhci_hcd 0000:65:00.4: xHCI Host Controller
[    0.422521] xhci_hcd 0000:65:00.4: new USB bus registered, assigned bus number 3
[    0.422953] xhci_hcd 0000:65:00.4: hcc params 0x0110ffc5 hci version 0x120 quirks 0x0000000200000010
[    0.423130] xhci_hcd 0000:65:00.4: xHCI Host Controller
[    0.423132] xhci_hcd 0000:65:00.4: new USB bus registered, assigned bus number 4
[    0.423134] xhci_hcd 0000:65:00.4: Host supports USB 3.1 Enhanced SuperSpeed
[    0.423160] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 7.00
[    0.423162] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.423163] usb usb3: Product: xHCI Host Controller
[    0.423164] usb usb3: Manufacturer: Linux 7.0.0-rc2-debug-next-20260303-03431-gc025f6cf4209 xhci-hcd
[    0.423165] usb usb3: SerialNumber: 0000:65:00.4
[    0.423239] hub 3-0:1.0: USB hub found
[    0.423249] hub 3-0:1.0: 1 port detected
[    0.423992] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
[    0.424008] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 7.00
[    0.424010] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.424011] usb usb4: Product: xHCI Host Controller
[    0.424012] usb usb4: Manufacturer: Linux 7.0.0-rc2-debug-next-20260303-03431-gc025f6cf4209 xhci-hcd
[    0.424013] usb usb4: SerialNumber: 0000:65:00.4
[    0.424082] hub 4-0:1.0: USB hub found
[    0.424094] hub 4-0:1.0: 1 port detected
[    0.424926] xhci_hcd 0000:67:00.3: xHCI Host Controller
[    0.424929] xhci_hcd 0000:67:00.3: new USB bus registered, assigned bus number 5
[    0.425289] xhci_hcd 0000:67:00.3: hcc params 0x0110ffc5 hci version 0x120 quirks 0x0000000200000010
[    0.425622] xhci_hcd 0000:67:00.3: xHCI Host Controller
[    0.425624] xhci_hcd 0000:67:00.3: new USB bus registered, assigned bus number 6
[    0.425626] xhci_hcd 0000:67:00.3: Host supports USB 3.1 Enhanced SuperSpeed
[    0.425652] usb usb5: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 7.00
[    0.425654] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.425655] usb usb5: Product: xHCI Host Controller
[    0.425656] usb usb5: Manufacturer: Linux 7.0.0-rc2-debug-next-20260303-03431-gc025f6cf4209 xhci-hcd
[    0.425657] usb usb5: SerialNumber: 0000:67:00.3
[    0.425726] hub 5-0:1.0: USB hub found
[    0.425745] hub 5-0:1.0: 1 port detected
[    0.426491] usb usb6: We don't know the algorithms for LPM for this host, disabling LPM.
[    0.426507] usb usb6: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 7.00
[    0.426508] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.426509] usb usb6: Product: xHCI Host Controller
[    0.426510] usb usb6: Manufacturer: Linux 7.0.0-rc2-debug-next-20260303-03431-gc025f6cf4209 xhci-hcd
[    0.426511] usb usb6: SerialNumber: 0000:67:00.3
[    0.426577] hub 6-0:1.0: USB hub found
[    0.426586] hub 6-0:1.0: 1 port detected
[    0.427655] xhci_hcd 0000:67:00.4: xHCI Host Controller
[    0.427659] xhci_hcd 0000:67:00.4: new USB bus registered, assigned bus number 7
[    0.427994] xhci_hcd 0000:67:00.4: hcc params 0x0110ffc5 hci version 0x120 quirks 0x0000000200000010
[    0.428319] xhci_hcd 0000:67:00.4: xHCI Host Controller
[    0.428321] xhci_hcd 0000:67:00.4: new USB bus registered, assigned bus number 8
[    0.428323] xhci_hcd 0000:67:00.4: Host supports USB 3.1 Enhanced SuperSpeed
[    0.428349] usb usb7: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 7.00
[    0.428350] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.428352] usb usb7: Product: xHCI Host Controller
[    0.428353] usb usb7: Manufacturer: Linux 7.0.0-rc2-debug-next-20260303-03431-gc025f6cf4209 xhci-hcd
[    0.428356] usb usb7: SerialNumber: 0000:67:00.4
[    0.428425] hub 7-0:1.0: USB hub found
[    0.428434] hub 7-0:1.0: 1 port detected
[    0.429190] usb usb8: We don't know the algorithms for LPM for this host, disabling LPM.
[    0.429207] usb usb8: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 7.00
[    0.429208] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.429209] usb usb8: Product: xHCI Host Controller
[    0.429211] usb usb8: Manufacturer: Linux 7.0.0-rc2-debug-next-20260303-03431-gc025f6cf4209 xhci-hcd
[    0.429212] usb usb8: SerialNumber: 0000:67:00.4
[    0.429278] hub 8-0:1.0: USB hub found
[    0.429287] hub 8-0:1.0: 1 port detected
[    0.430319] usbcore: registered new interface driver usbserial_generic
[    0.430324] usbserial: USB Serial support registered for generic
[    0.430341] i8042: PNP: No PS/2 controller found.
[    0.430342] i8042: Probing ports directly.
[    0.431314] i8042: No controller found
[    0.431384] rtc_cmos PNP0B00:00: error -ENXIO: IRQ index 0 not found
[    0.431391] rtc_cmos PNP0B00:00: RTC can wake from S4
[    0.431480] rtc_cmos PNP0B00:00: registered as rtc0
[    0.431509] rtc_cmos PNP0B00:00: setting system clock to 2026-03-03T17:44:56 UTC (1772559896)
[    0.431534] rtc_cmos PNP0B00:00: no alarms, y3k, 114 bytes nvram
[    0.432508] hid: raw HID events driver (C) Jiri Kosina
[    0.432525] usbcore: registered new interface driver usbhid
[    0.432526] usbhid: USB HID core driver
[    0.432568] drop_monitor: Initializing network drop monitor service
[    0.432663] NET: Registered PF_INET6 protocol family
[    0.432875] Segment Routing with IPv6
[    0.432876] RPL Segment Routing with IPv6
[    0.432883] In-situ OAM (IOAM) with IPv6
[    0.432902] NET: Registered PF_PACKET protocol family
[    0.434535] x86/amd: Previous system reset reason [0x00080800]: software wrote 0x6 to reset control register 0xCF9
[    0.434542] microcode: Current revision: 0x0a705208
[    0.434543] microcode: Updated early from: 0x0a705206
[    0.434867] resctrl: L3 allocation detected
[    0.434869] resctrl: MB allocation detected
[    0.434869] resctrl: SMBA allocation detected
[    0.434871] resctrl: L3 monitoring detected
[    0.434889] IPI shorthand broadcast: enabled
[    0.437560] sched_clock: Marking stable (435976386, 1378695)->(454863641, -17508560)
[    0.437809] registered taskstats version 1
[    0.438481] Loading compiled-in X.509 certificates
[    0.443651] Loaded X.509 cert 'Build time autogenerated kernel key: 7754750550326b503c61d5d55789cb6dd59bfeb6'
[    0.445968] Demotion targets for Node 0: null
[    0.446072] Key type .fscrypt registered
[    0.446073] Key type fscrypt-provisioning registered
[    0.446305] Btrfs loaded, zoned=yes, fsverity=yes
[    0.446331] Key type big_key registered
[    0.446407] integrity: Loading X.509 certificate: UEFI:db
[    0.446419] integrity: Loaded X.509 cert 'Microsoft Corporation: Windows UEFI CA 2023: aefc5fbbbe055d8f8daa585473499417ab5a5272'
[    0.446420] integrity: Loading X.509 certificate: UEFI:db
[    0.446429] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    0.446430] integrity: Loading X.509 certificate: UEFI:db
[    0.446438] integrity: Loaded X.509 cert 'Microsoft Windows Production PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    0.447327] PM:   Magic number: 2:693:743
[    0.447494] RAS: Correctable Errors collector initialized.
[    0.448567] clk: Disabling unused clocks
[    0.448569] PM: genpd: Disabling unused power domains
[    0.449598] Freeing unused decrypted memory: 2028K
[    0.450047] Freeing unused kernel image (initmem) memory: 4664K
[    0.450057] Write protecting the kernel read-only data: 36864k
[    0.450306] Freeing unused kernel image (text/rodata gap) memory: 816K
[    0.450420] Freeing unused kernel image (rodata/data gap) memory: 984K
[    0.482056] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    0.482060] rodata_test: all tests were successful
[    0.482063] Run /init as init process
[    0.482064]   with arguments:
[    0.482065]     /init
[    0.482066]   with environment:
[    0.482067]     HOME=/
[    0.482068]     TERM=linux
[    0.656834] usb 1-3: new high-speed USB device number 2 using xhci_hcd
[    0.681349] ACPI: video: Video Device [VGA] (multi-head: yes  rom: no  post: no)
[    0.681764] input: Video Bus as /devices/pci0000:00/0000:00:08.1/LNXVIDEO:00/input/input1
[    0.683272] Key type psk registered
[    0.699200] nvme 0000:04:00.0: platform quirk: setting simple suspend
[    0.699283] nvme nvme0: pci function 0000:04:00.0
[    0.699433] ACPI: bus type drm_connector registered
[    0.699442] Unsupported value for CONFIG_DRM_PANIC_SCREEN ('qr_code'), falling back to 'user'...
[    0.722495] nvme nvme0: allocated 64 MiB host memory buffer (1 segment).
[    0.756666] nvme nvme0: 16/0/0 default/read/poll queues
[    0.760301]  nvme0n1: p1 p2
[    0.786322] usb 1-3: New USB device found, idVendor=38eb, idProduct=0002, bcdDevice= 1.00
[    0.786328] usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    0.786331] usb 1-3: Product: Glinet Composite Device
[    0.786334] usb 1-3: Manufacturer: Glinet
[    0.786337] usb 1-3: SerialNumber: CAFEBABE
[    0.796245] input: Glinet Glinet Composite Device as /devices/pci0000:00/0000:00:08.1/0000:65:00.3/usb1/1-3/1-3:1.0/0003:38EB:0002.0001/input/input2
[    0.868153] hid-generic 0003:38EB:0002.0001: input,hidraw0: USB HID v1.01 Keyboard [Glinet Glinet Composite Device] on usb-0000:65:00.3-3/input0
[    0.872277] input: Glinet Glinet Composite Device as /devices/pci0000:00/0000:00:08.1/0000:65:00.3/usb1/1-3/1-3:1.1/0003:38EB:0002.0002/input/input3
[    0.872370] hid-generic 0003:38EB:0002.0002: input,hidraw1: USB HID v1.01 Mouse [Glinet Glinet Composite Device] on usb-0000:65:00.3-3/input1
[    0.875647] input: Glinet Glinet Composite Device as /devices/pci0000:00/0000:00:08.1/0000:65:00.3/usb1/1-3/1-3:1.2/0003:38EB:0002.0003/input/input4
[    0.875722] hid-generic 0003:38EB:0002.0003: input,hidraw2: USB HID v1.01 Mouse [Glinet Glinet Composite Device] on usb-0000:65:00.3-3/input2
[    0.989830] usb 1-5: new full-speed USB device number 3 using xhci_hcd
[    1.143260] usb 1-5: New USB device found, idVendor=8087, idProduct=0029, bcdDevice= 0.01
[    1.143268] usb 1-5: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    1.368427] tsc: Refined TSC clocksource calibration: 3792.909 MHz
[    1.368440] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x6d585bca50c, max_idle_ns: 881590444602 ns
[    1.368606] clocksource: Switched to clocksource tsc
[    2.479816] usb-storage 1-3:1.3: USB Mass Storage device detected
[    2.479942] scsi host0: usb-storage 1-3:1.3
[    2.480050] usb-storage 1-3:1.4: USB Mass Storage device detected
[    2.480128] scsi host1: usb-storage 1-3:1.4
[    2.480191] usbcore: registered new interface driver usb-storage
[    2.482628] usbcore: registered new interface driver uas
[    2.494922] amdgpu: Virtual CRAT table created for CPU
[    2.494937] amdgpu: Topology: Add CPU node
[    2.495065] amdgpu 0000:65:00.0: enabling device (0006 -> 0007)
[    2.495108] amdgpu 0000:65:00.0: initializing kernel modesetting (IP DISCOVERY 0x1002:0x1900 0x1F66:0x0031 0xB3).
[    2.495116] amdgpu 0000:65:00.0: register mmio base: 0xDC500000
[    2.495118] amdgpu 0000:65:00.0: register mmio size: 524288
[    2.498577] amdgpu 0000:65:00.0: detected ip block number 0 <common_v1_0_0> (soc21_common)
[    2.498580] amdgpu 0000:65:00.0: detected ip block number 1 <gmc_v11_0_0> (gmc_v11_0)
[    2.498582] amdgpu 0000:65:00.0: detected ip block number 2 <ih_v6_0_0> (ih_v6_0)
[    2.498584] amdgpu 0000:65:00.0: detected ip block number 3 <psp_v13_0_4> (psp)
[    2.498586] amdgpu 0000:65:00.0: detected ip block number 4 <smu_v13_0_0> (smu)
[    2.498588] amdgpu 0000:65:00.0: detected ip block number 5 <dce_v1_0_0> (dm)
[    2.498589] amdgpu 0000:65:00.0: detected ip block number 6 <gfx_v11_0_0> (gfx_v11_0)
[    2.498591] amdgpu 0000:65:00.0: detected ip block number 7 <sdma_v6_0_0> (sdma_v6_0)
[    2.498593] amdgpu 0000:65:00.0: detected ip block number 8 <vcn_v4_0_0> (vcn_v4_0)
[    2.498595] amdgpu 0000:65:00.0: detected ip block number 9 <jpeg_v4_0_0> (jpeg_v4_0)
[    2.498596] amdgpu 0000:65:00.0: detected ip block number 10 <mes_v11_0_0> (mes_v11_0)
[    2.498612] amdgpu 0000:65:00.0: Fetched VBIOS from VFCT
[    2.498615] amdgpu 0000:65:00.0: [drm] ATOM BIOS: 113-PHXGENERIC-001, build: 00077464, ver: 022.012.000.027.000001, 2023/09/15
[    2.501995] amdgpu 0000:65:00.0: vgaarb: deactivate vga console
[    2.502000] amdgpu 0000:65:00.0: Trusted Memory Zone (TMZ) feature enabled
[    2.502124] amdgpu 0000:65:00.0: vm size is 262144 GB, 4 levels, block size is 9-bit, fragment size is 9-bit
[    2.502164] amdgpu 0000:65:00.0: VRAM: 4096M 0x0000008000000000 - 0x00000080FFFFFFFF (4096M used)
[    2.502166] amdgpu 0000:65:00.0: GART: 512M 0x00007FFF00000000 - 0x00007FFF1FFFFFFF
[    2.502194] amdgpu 0000:65:00.0: [drm] Detected VRAM RAM=4096M, BAR=4096M
[    2.502196] amdgpu 0000:65:00.0: [drm] RAM width 128bits DDR5
[    2.502403] amdgpu 0000:65:00.0:  4096M of VRAM memory ready
[    2.502405] amdgpu 0000:65:00.0:  9888M of GTT memory ready.
[    2.502432] amdgpu 0000:65:00.0: [drm] GART: num cpu pages 131072, num gpu pages 131072
[    2.502880] amdgpu 0000:65:00.0: [drm] PCIE GART of 512M enabled (table at 0x0000008000F00000).
[    2.503248] amdgpu 0000:65:00.0: [drm] Loading DMUB firmware via PSP: version=0x08005700
[    2.503579] amdgpu 0000:65:00.0: [VCN instance 0] Found VCN firmware Version ENC: 1.24 DEC: 9 VEP: 0 Revision: 27
[    2.503660] amdgpu 0000:65:00.0: MES: vmid_mask_mmhub 0x0000ff00, vmid_mask_gfxhub 0x0000ff00
[    2.503662] amdgpu 0000:65:00.0: MES: gfx_hqd_mask 0x00000002, compute_hqd_mask 0x0000000c, sdma_hqd_mask 0x000000fc
[    2.528093] amdgpu 0000:65:00.0: reserve 0x4000000 from 0x80f8000000 for PSP TMR
[    3.088700] amdgpu 0000:65:00.0: RAS: optional ras ta ucode is not available
[    3.097053] amdgpu 0000:65:00.0: RAP: optional rap ta ucode is not available
[    3.097056] amdgpu 0000:65:00.0: SECUREDISPLAY: optional securedisplay ta ucode is not available
[    3.126882] amdgpu 0000:65:00.0: SMU is initialized successfully!
[    3.128404] amdgpu 0000:65:00.0: [drm] Display Core v3.2.372 initialized on DCN 3.1.4
[    3.128408] amdgpu 0000:65:00.0: [drm] DP-HDMI FRL PCON supported
[    3.130904] amdgpu 0000:65:00.0: [drm] DMUB hardware initialized: version=0x08005700
[    3.134243] amdgpu 0000:65:00.0: [drm] DP-1: PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[    3.161787] amdgpu 0000:65:00.0: [drm] HDMI-A-1: PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[    3.161861] amdgpu 0000:65:00.0: [drm] DP-2: PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[    3.161909] amdgpu 0000:65:00.0: [drm] DP-3: PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[    3.161956] amdgpu 0000:65:00.0: [drm] DP-4: PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[    3.162002] amdgpu 0000:65:00.0: [drm] DP-5: PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[    3.162048] amdgpu 0000:65:00.0: [drm] DP-6: PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[    3.170215] kfd kfd: Allocated 3969056 bytes on gart
[    3.170235] kfd kfd: Total number of KFD nodes to be created: 1
[    3.170402] amdgpu: Virtual CRAT table created for GPU
[    3.170564] amdgpu: Topology: Add GPU node [0x1002:0x1900]
[    3.170567] kfd kfd: added device 1002:1900
[    3.170578] amdgpu 0000:65:00.0: SE 1, SH per SE 2, CU per SH 6, active_cu_number 12
[    3.170583] amdgpu 0000:65:00.0: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
[    3.170586] amdgpu 0000:65:00.0: ring comp_1.0.0 uses VM inv eng 1 on hub 0
[    3.170587] amdgpu 0000:65:00.0: ring comp_1.1.0 uses VM inv eng 4 on hub 0
[    3.170589] amdgpu 0000:65:00.0: ring comp_1.2.0 uses VM inv eng 6 on hub 0
[    3.170591] amdgpu 0000:65:00.0: ring comp_1.3.0 uses VM inv eng 7 on hub 0
[    3.170592] amdgpu 0000:65:00.0: ring comp_1.0.1 uses VM inv eng 8 on hub 0
[    3.170593] amdgpu 0000:65:00.0: ring comp_1.1.1 uses VM inv eng 9 on hub 0
[    3.170594] amdgpu 0000:65:00.0: ring comp_1.2.1 uses VM inv eng 10 on hub 0
[    3.170596] amdgpu 0000:65:00.0: ring comp_1.3.1 uses VM inv eng 11 on hub 0
[    3.170597] amdgpu 0000:65:00.0: ring sdma0 uses VM inv eng 12 on hub 0
[    3.170598] amdgpu 0000:65:00.0: ring vcn_unified_0 uses VM inv eng 0 on hub 8
[    3.170600] amdgpu 0000:65:00.0: ring jpeg_dec uses VM inv eng 1 on hub 8
[    3.170601] amdgpu 0000:65:00.0: ring mes_kiq_3.1.0 uses VM inv eng 13 on hub 0
[    3.171632] amdgpu 0000:65:00.0: Runtime PM not available
[    3.172725] amdgpu 0000:65:00.0: [drm] Registered 4 planes with drm panic
[    3.179434] [drm] Initialized amdgpu 3.64.0 for 0000:65:00.0 on minor 0
[    3.181995] amdgpu 0000:65:00.0: [drm] Failed to setup vendor infoframe on connector HDMI-A-1: -22
[    3.186694] fbcon: amdgpudrmfb (fb0) is primary device
[    3.187051] [drm] pre_validate_dsc:1667 MST_DSC dsc precompute is not needed
[    3.455651] amdgpu 0000:65:00.0: [drm] REG_WAIT timeout 1us * 100000 tries - optc314_disable_crtc line:145
[    3.481826] scsi 1:0:0:0: Direct-Access     Glinet   Flash Drive      1.00 PQ: 0 ANSI: 2
[    3.482311] scsi 0:0:0:0: CD-ROM            Glinet   Flash Drive      1.00 PQ: 0 ANSI: 2
[    3.483918] sd 1:0:0:0: Power-on or device reset occurred
[    3.484284] sd 1:0:0:0: [sda] Media removed, stopped polling
[    3.492523] sd 1:0:0:0: [sda] Attached SCSI removable disk
[    3.496421] sr 0:0:0:0: Power-on or device reset occurred
[    3.497937] sr 0:0:0:0: [sr0] scsi-1 drive
[    3.497940] cdrom: Uniform CD-ROM driver Revision: 3.20
[    3.507459] sr 0:0:0:0: Attached scsi CD-ROM sr0
[    3.533217] Console: switching to colour frame buffer device 160x45
[    3.569762] amdgpu 0000:65:00.0: [drm] fb0: amdgpudrmfb frame buffer device
[    3.660298] BTRFS: device fsid 204f00b6-441d-4dc1-8bf1-c27bbfe077b2 devid 1 transid 582430 /dev/nvme0n1p2 (259:2) scanned by mount (359)
[    3.660669] BTRFS info (device nvme0n1p2): first mount of filesystem 204f00b6-441d-4dc1-8bf1-c27bbfe077b2
[    3.660673] BTRFS info (device nvme0n1p2): using crc32c checksum algorithm
[    3.704898] BTRFS info (device nvme0n1p2): enabling ssd optimizations
[    3.704905] BTRFS info (device nvme0n1p2): turning on async discard
[    3.704909] BTRFS info (device nvme0n1p2): enabling free space tree
[    3.791905] systemd[1]: systemd 259.2-1-arch running in system mode (+PAM +AUDIT -SELINUX +APPARMOR -IMA +IPE +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +KMOD +LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +BTF +XKBCOMMON +UTMP -SYSVINIT +LIBARCHIVE)
[    3.791912] systemd[1]: Detected architecture x86-64.
[    3.793135] systemd[1]: Hostname set to <beelink-amd-ryzen-8745HS>.
[    3.862310] systemd[1]: bpf-restrict-fs: LSM BPF program attached
[    4.037627] zram: Added device: zram0
[    4.095816] systemd[1]: Queued start job for default target Graphical Interface.
[    4.111707] systemd[1]: Created slice Virtual Machine and Container Slice.
[    4.112450] systemd[1]: Created slice Slice /system/dirmngr.
[    4.112729] systemd[1]: Created slice Slice /system/getty.
[    4.113000] systemd[1]: Created slice Slice /system/gpg-agent.
[    4.113271] systemd[1]: Created slice Slice /system/gpg-agent-browser.
[    4.113551] systemd[1]: Created slice Slice /system/gpg-agent-extra.
[    4.113809] systemd[1]: Created slice Slice /system/gpg-agent-ssh.
[    4.114063] systemd[1]: Created slice Slice /system/keyboxd.
[    4.114318] systemd[1]: Created slice Slice /system/modprobe.
[    4.114638] systemd[1]: Created slice Slice /system/systemd-zram-setup.
[    4.114934] systemd[1]: Created slice User and Session Slice.
[    4.115009] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[    4.115071] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[    4.115222] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[    4.115276] systemd[1]: Expecting device /dev/disk/by-uuid/1AD9-58CA...
[    4.115308] systemd[1]: Expecting device /dev/disk/by-uuid/204f00b6-441d-4dc1-8bf1-c27bbfe077b2...
[    4.115348] systemd[1]: Expecting device /dev/zram0...
[    4.115382] systemd[1]: Reached target Local Encrypted Volumes.
[    4.115422] systemd[1]: Reached target Login Prompts.
[    4.115452] systemd[1]: Reached target Image Downloads.
[    4.115484] systemd[1]: Reached target Local Integrity Protected Volumes.
[    4.115522] systemd[1]: Reached target Preparation for Network.
[    4.115556] systemd[1]: Reached target Path Units.
[    4.115587] systemd[1]: Reached target Remote File Systems.
[    4.115621] systemd[1]: Reached target Slice Units.
[    4.115658] systemd[1]: Reached target Local Verity Protected Volumes.
[    4.115744] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    4.116211] systemd[1]: Listening on Query the User Interactively for a Password.
[    4.117238] systemd[1]: Listening on Process Core Dump Socket.
[    4.118511] systemd[1]: Listening on Credential Encryption/Decryption.
[    4.119225] systemd[1]: Listening on Factory Reset Management.
[    4.119549] systemd[1]: Listening on Journal Socket (/dev/log).
[    4.119845] systemd[1]: Listening on Journal Sockets.
[    4.120499] systemd[1]: Listening on Console Output Muting Service Socket.
[    4.120888] systemd[1]: TPM PCR Measurements skipped, unmet condition check ConditionSecurity=measured-uki
[    4.120896] systemd[1]: Make TPM PCR Policy skipped, unmet condition check ConditionSecurity=measured-uki
[    4.121193] systemd[1]: Listening on Disk Repartitioning Service Socket.
[    4.121490] systemd[1]: Listening on udev Control Socket.
[    4.121755] systemd[1]: Listening on udev Kernel Socket.
[    4.122019] systemd[1]: Listening on udev Varlink Socket.
[    4.122287] systemd[1]: Listening on User Database Manager Socket.
[    4.123797] systemd[1]: Mounting Huge Pages File System...
[    4.124592] systemd[1]: Mounting POSIX Message Queue File System...
[    4.125976] systemd[1]: Mounting Kernel Debug File System...
[    4.143762] systemd[1]: Mounting Kernel Trace File System...
[    4.145582] systemd[1]: Starting Create List of Static Device Nodes...
[    4.146042] systemd[1]: Load Kernel Module configfs skipped, unmet condition check ConditionKernelModuleLoaded=!configfs
[    4.146884] systemd[1]: Mounting Kernel Configuration File System...
[    4.148150] systemd[1]: Starting Load Kernel Module dm_mod...
[    4.148646] systemd[1]: Load Kernel Module drm skipped, unmet condition check ConditionKernelModuleLoaded=!drm
[    4.148674] systemd[1]: Load Kernel Module fuse skipped, unmet condition check ConditionKernelModuleLoaded=!fuse
[    4.149523] systemd[1]: Mounting FUSE Control File System...
[    4.151065] systemd[1]: Starting Load Kernel Module loop...
[    4.152531] systemd[1]: Starting Load Kernel Module tun...
[    4.153259] systemd[1]: Clear Stale Hibernate Storage Info skipped, unmet condition check ConditionPathExists=/sys/firmware/efi/efivars/HibernateLocation-8cf2644b-4b0b-428f-9387-6d876050dc67
[    4.154860] systemd[1]: Starting Journal Service...
[    4.156188] systemd[1]: Starting Load Kernel Modules...
[    4.156617] systemd[1]: TPM PCR Machine ID Measurement skipped, unmet condition check ConditionSecurity=measured-uki
[    4.156641] systemd[1]: TPM NvPCR Product ID Measurement skipped, unmet condition check ConditionSecurity=measured-uki
[    4.157156] systemd[1]: Starting Remount Root and Kernel File Systems...
[    4.157582] systemd[1]: Early TPM SRK Setup skipped, unmet condition check ConditionSecurity=measured-uki
[    4.158110] systemd[1]: Starting Load udev Rules from Credentials...
[    4.159036] systemd[1]: Starting Coldplug All udev Devices...
[    4.160876] tun: Universal TUN/TAP device driver, 1.6
[    4.160972] device-mapper: uevent: version 1.0.3
[    4.160974] loop: module loaded
[    4.161047] device-mapper: ioctl: 4.50.0-ioctl (2025-04-28) initialised: dm-devel@lists.linux.dev
[    4.161531] systemd[1]: Mounted Huge Pages File System.
[    4.162093] systemd[1]: Mounted POSIX Message Queue File System.
[    4.162570] systemd[1]: Mounted Kernel Debug File System.
[    4.162943] systemd[1]: Mounted Kernel Trace File System.
[    4.163424] systemd[1]: Finished Create List of Static Device Nodes.
[    4.164743] Asymmetric key parser 'pkcs8' registered
[    4.177842] systemd[1]: Mounted Kernel Configuration File System.
[    4.178324] systemd[1]: modprobe@dm_mod.service: Deactivated successfully.
[    4.178460] systemd[1]: Finished Load Kernel Module dm_mod.
[    4.178823] systemd[1]: Mounted FUSE Control File System.
[    4.179177] systemd[1]: modprobe@loop.service: Deactivated successfully.
[    4.179290] systemd[1]: Finished Load Kernel Module loop.
[    4.179293] systemd-journald[446]: Collecting audit messages is disabled.
[    4.179695] systemd[1]: modprobe@tun.service: Deactivated successfully.
[    4.179813] systemd[1]: Finished Load Kernel Module tun.
[    4.180232] systemd[1]: Finished Load Kernel Modules.
[    4.180873] systemd[1]: Finished Load udev Rules from Credentials.
[    4.182812] systemd[1]: Starting Apply Kernel Variables...
[    4.183534] systemd[1]: Starting Create Static Device Nodes in /dev gracefully...
[    4.203155] systemd[1]: Finished Apply Kernel Variables.
[    4.239260] systemd[1]: Started Journal Service.
[    4.250245] BTRFS info (device nvme0n1p2 state M): use zstd compression, level 3
[    4.485919] zram0: detected capacity change from 0 to 8388608
[    4.522833] ccp 0000:65:00.2: enabling device (0000 -> 0002)
[    4.525599] mousedev: PS/2 mouse device common for all mice
[    4.527635] ccp 0000:65:00.2: tee enabled
[    4.529157] ccp 0000:65:00.2: psp enabled
[    4.529375] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, revision 0
[    4.529386] piix4_smbus 0000:00:14.0: Using register 0x02 for SMBus port selection
[    4.531602] i2c i2c-13: Successfully instantiated SPD at 0x50
[    4.535961] Adding 4194300k swap on /dev/zram0.  Priority:100 extents:1 across:4194300k SSDsc
[    4.536371] i2c i2c-13: Successfully instantiated SPD at 0x51
[    4.540580] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Controller at 0xb20
[    4.572388] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver
[    4.572514] RAPL PMU: API unit is 2^-32 Joules, 2 fixed counters, 163840 ms ovfl timer
[    4.572518] RAPL PMU: hw unit of domain package 2^-16 Joules
[    4.572520] RAPL PMU: hw unit of domain core 2^-16 Joules
[    4.572556] sp5100-tco sp5100-tco: Using 0xfeb00000 for watchdog MMIO address
[    4.572668] sp5100-tco sp5100-tco: initialized. heartbeat=60 sec (nowayout=0)
[    4.572931] Bluetooth: Core ver 2.22
[    4.572958] NET: Registered PF_BLUETOOTH protocol family
[    4.572960] Bluetooth: HCI device and connection manager initialized
[    4.572967] Bluetooth: HCI socket layer initialized
[    4.572970] Bluetooth: L2CAP socket layer initialized
[    4.572973] Bluetooth: SCO socket layer initialized
[    4.573112] ACPI: bus type thunderbolt registered
[    4.573143] input: PC Speaker as /devices/platform/pcspkr/input/input5
[    4.573559] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    4.576202] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    4.576304] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
[    4.577057] faux_driver regulatory: Direct firmware load for regulatory.db failed with error -2
[    4.577061] cfg80211: failed to load regulatory.db
[    4.585470] spd5118 13-0050: DDR5 temperature sensor: vendor 0x06:0x32 revision 1.6
[    4.588441] r8169 0000:01:00.0 eth0: RTL8125B, 70:70:fc:07:68:03, XID 641, IRQ 97
[    4.588447] r8169 0000:01:00.0 eth0: jumbo features [frames: 16362 bytes, tx checksumming: ko]
[    4.590075] spd5118 13-0051: DDR5 temperature sensor: vendor 0x06:0x32 revision 1.6
[    4.592809] iwlwifi 0000:02:00.0: enabling device (0000 -> 0002)
[    4.604286] iwlwifi 0000:02:00.0: Detected crf-id 0x3617, cnv-id 0x100530 wfpm id 0x80000000
[    4.604319] iwlwifi 0000:02:00.0: PCI dev 2723/0084, rev=0x340, rfid=0x10a100
[    4.604322] iwlwifi 0000:02:00.0: Detected Intel(R) Wi-Fi 6 AX200 160MHz
[    4.608111] iwlwifi 0000:02:00.0: loaded firmware version 77.f39cc7f9.0 cc-a0-77.ucode op_mode iwlmvm
[    4.629852] usbcore: registered new interface driver btusb
[    4.632715] r8169 0000:01:00.0 enp1s0: renamed from eth0
[    4.635497] snd_hda_intel 0000:65:00.1: enabling device (0000 -> 0002)
[    4.635569] snd_hda_intel 0000:65:00.1: Handle vga_switcheroo audio client
[    4.635662] snd_hda_intel 0000:65:00.6: enabling device (0000 -> 0002)
[    4.640415] kvm_amd: TSC scaling supported
[    4.640419] kvm_amd: Nested Virtualization enabled
[    4.640422] kvm_amd: Nested Paging enabled
[    4.640423] kvm_amd: LBR virtualization supported
[    4.640429] kvm_amd: [Firmware Bug]: Cannot enable x2AVIC, AVIC is unsupported
[    4.640430] kvm_amd: Virtual GIF supported
[    4.640431] kvm_amd: Virtual NMI enabled
[    4.647843] Bluetooth: hci0: Found device firmware: intel/ibt-20-1-3.sfi
[    4.647858] Bluetooth: hci0: Boot Address: 0x24800
[    4.647860] Bluetooth: hci0: Firmware Version: 193-33.24
[    4.647862] Bluetooth: hci0: Firmware already loaded
[    4.653648] snd_hda_intel 0000:65:00.1: bound 0000:65:00.0 (ops amdgpu_dm_audio_component_bind_ops [amdgpu])
[    4.655794] input: HD-Audio Generic HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:08.1/0000:65:00.1/sound/card0/input6
[    4.655848] input: HD-Audio Generic HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:08.1/0000:65:00.1/sound/card0/input7
[    4.655888] input: HD-Audio Generic HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:08.1/0000:65:00.1/sound/card0/input8
[    4.655924] input: HD-Audio Generic HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:08.1/0000:65:00.1/sound/card0/input9
[    4.657229] Bluetooth: hci0: HCI LE Coded PHY feature bit is set, but its usage is not supported.
[    4.683134] pps_core: LinuxPPS API ver. 1 registered
[    4.683137] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    4.683210] intel_rapl_common: Found RAPL domain package
[    4.683214] intel_rapl_common: Found RAPL domain core
[    4.683357] amd_atl: AMD Address Translation Library initialized
[    4.686396] PTP clock support registered
[    4.687037] snd_hda_codec_alc662 hdaudioC1D0: autoconfig for ALC897: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:line
[    4.687045] snd_hda_codec_alc662 hdaudioC1D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    4.687049] snd_hda_codec_alc662 hdaudioC1D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
[    4.687052] snd_hda_codec_alc662 hdaudioC1D0:    mono: mono_out=0x0
[    4.687055] snd_hda_codec_alc662 hdaudioC1D0:    inputs:
[    4.687058] snd_hda_codec_alc662 hdaudioC1D0:      Rear Mic=0x18
[    4.687061] snd_hda_codec_alc662 hdaudioC1D0:      Front Mic=0x19
[    4.694607] snd_pci_ps 0000:65:00.5: enabling device (0000 -> 0002)
[    4.701157] input: HD-Audio Generic Rear Mic as /devices/pci0000:00/0000:00:08.1/0000:65:00.6/sound/card1/input10
[    4.701213] input: HD-Audio Generic Front Mic as /devices/pci0000:00/0000:00:08.1/0000:65:00.6/sound/card1/input11
[    4.701260] input: HD-Audio Generic Line Out as /devices/pci0000:00/0000:00:08.1/0000:65:00.6/sound/card1/input12
[    4.701317] input: HD-Audio Generic Front Headphone as /devices/pci0000:00/0000:00:08.1/0000:65:00.6/sound/card1/input13
[    4.870810] iwlwifi 0000:02:00.0: Detected RF HR B3, rfid=0x10a100
[    4.949374] iwlwifi 0000:02:00.0: base HW address: dc:45:46:f2:f1:0c
[    5.193469] FAT-fs (nvme0n1p1): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
[    5.200148] systemd-journald[446]: Received client request to flush runtime journal.
[    5.693402] Realtek Internal NBASE-T PHY r8169-0-100:00: attached PHY driver (mii_bus:phy_addr=r8169-0-100:00, irq=MAC)
[    5.846981] r8169 0000:01:00.0 enp1s0: Link is Down
[    8.971015] r8169 0000:01:00.0 enp1s0: Link is Up - 2.5Gbps/Full - flow control off
[    9.588643] netfs: FS-Cache loaded
[    9.628301] RPC: Registered named UNIX socket transport module.
[    9.628303] RPC: Registered udp transport module.
[    9.628304] RPC: Registered tcp transport module.
[    9.628305] RPC: Registered tcp-with-tls transport module.
[    9.628306] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    9.679035] Key type dns_resolver registered
[    9.756939] NFS: Registering the id_resolver key type
[    9.756946] Key type id_resolver registered
[    9.756947] Key type id_legacy registered
[   13.268348] rfkill: input handler disabled

--TrKuMI+BaD7XwHS9--

