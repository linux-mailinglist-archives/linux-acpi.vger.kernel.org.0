Return-Path: <linux-acpi+bounces-21319-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKGCFylRp2nKggAAu9opvQ
	(envelope-from <linux-acpi+bounces-21319-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Mar 2026 22:22:49 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 830381F7738
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Mar 2026 22:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 833EE311EB5C
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Mar 2026 21:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8723BED7A;
	Tue,  3 Mar 2026 21:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AON6Iodm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4344D32AAD1;
	Tue,  3 Mar 2026 21:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772572650; cv=none; b=Hq9hj+nX30bGaf4IX/QK+jWvwWkYjKgzyiBO3kwlTUCQ8UY12dPJIu2DdwxU9cXRpslJ9x1IwOzSbscqj3HR6pqhfdo3kR1jU8dafcR7M03qAqrn1gB5Yo0odG8qVkkLfMyuyZbwkETMeDx3cDHys2c7vpDIrptKmjcCKuLOe8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772572650; c=relaxed/simple;
	bh=Z1W2Bl8N0pZkt7in1QIybNpK9RnKaw7nYugMjZyDq0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lt7DAxLmXMOf4ptlsxCPjTwj33Tp3/1PEvPY/5AoAXQgqwpFSyNq6jjZEYyeglXzPTHUthv2DDFQIbyB/XIDuB6nddSzHZx4jO+lONLI5QsUDbQwWHmjcSuy0aCdTtEFTRRYQMLpP2BnkkI4BIpYxm++ByJYLzY0M3DtOMroiKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AON6Iodm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2EF4C116C6;
	Tue,  3 Mar 2026 21:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772572649;
	bh=Z1W2Bl8N0pZkt7in1QIybNpK9RnKaw7nYugMjZyDq0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AON6IodmdREAm440kXFHIxj9b0EiTtX+66loUFrMK+L4FxBwVF9P9etO7pFP8mlvx
	 zGnNASTOZY8FZ+NQVPdP0VRtaqbQAAWYs6OOtKtgY7wb3382XFSo800z8ML19whzFG
	 rYYh8jLCx9VspUHj3IDuBffi/yiIwVbKPE95If+DAZ2nXrn24DGONCcetZoWudjQ4z
	 NdiF2IG6fdYbnrAcesv0XodLDHCi67aofwm5QChZAUZ5mrppzAUHhx89IjPA0XSPDx
	 jjWPYKSKUodXn6hiBw5ZHlYtQvnkB8iaOecv7pMUtvDTCeOfDZ6KrAHo/lzit2svm2
	 S+oWcqtNlN/4Q==
Date: Tue, 3 Mar 2026 14:17:25 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	x86 Maintainers <x86@kernel.org>, linux-rtc@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v1 4/8] ACPI: x86/rtc-cmos: Use platform device for
 driver binding
Message-ID: <20260303211725.GA2374171@ax162>
References: <5983325.DvuYhMxLoT@rafael.j.wysocki>
 <13969123.uLZWGnKmhe@rafael.j.wysocki>
 <20260303060752.GA2749263@ax162>
 <5087839.31r3eYUQgx@rafael.j.wysocki>
 <20260303175237.GB1114907@ax162>
 <CAJZ5v0jgLU_87cESzySAQhP31L83u-sd2xAHFiJmeqrw0NdOhg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="tFp+GUeSvr1YnwcN"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jgLU_87cESzySAQhP31L83u-sd2xAHFiJmeqrw0NdOhg@mail.gmail.com>
X-Rspamd-Queue-Id: 830381F7738
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21319-lists,linux-acpi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Action: no action


--tFp+GUeSvr1YnwcN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Mar 03, 2026 at 07:47:54PM +0100, Rafael J. Wysocki wrote:
> On Tue, Mar 3, 2026 at 6:52 PM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > On Tue, Mar 03, 2026 at 01:51:37PM +0100, Rafael J. Wysocki wrote:
> > > On Tuesday, March 3, 2026 7:07:52 AM CET Nathan Chancellor wrote:
> > > > After this change in -next as commit 2a78e4210444 ("ACPI: x86/rtc-cmos:
> > > > Use platform device for driver binding"), I am seeing
> > > >
> > > >   rtc_cmos PNP0B00:00: error -ENXIO: IRQ index 0 not found
> > > >
> > > > on a few of my test machines. Is this expected?
> > >
> > > Not really, thanks for reporting!
> > >
> > > Please send me a dmesg boot log from one of the affected systems.
> >
> > Attached.
> >
> > > The patch below should make the message go away.
> >
> > Can confirm, thanks! If it is helpful:
> >
> > Tested-by: Nathan Chancellor <nathan@kernel.org>
> 
> Thank you!
> 
> Can you please also send me a dmesg boot log from the same system with
> this patch applied?

Attached. Let me know if you need anything else.

Cheers,
Nathan

--tFp+GUeSvr1YnwcN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg

[    0.000000] Linux version 7.0.0-rc2-debug-next-20260303-03431-gc025f6cf4209-dirty (nathan@framework-amd-ryzen-maxplus-395) (x86_64-linux-gcc (GCC) 15.2.0, GNU ld (GNU Binutils) 2.45) #1 SMP PREEMPT_DYNAMIC Tue Mar  3 14:12:42 MST 2026
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
[    0.000000] tsc: Detected 3793.174 MHz processor
[    0.000070] e820: update [mem 0x00000000-0x00000fff] System RAM ==> device reserved
[    0.000071] e820: remove [mem 0x000a0000-0x000fffff] System RAM
[    0.000075] last_pfn = 0x55e300 max_arch_pfn = 0x400000000
[    0.000080] MTRR map: 5 entries (3 fixed + 2 variable; max 20), built from 9 variable MTRRs
[    0.000082] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000221] e820: update [mem 0xa0000000-0xffffffff] System RAM ==> device reserved
[    0.000227] last_pfn = 0x9bfff max_arch_pfn = 0x400000000
[    0.002723] esrt: Reserving ESRT space from 0x0000000090802e98 to 0x0000000090802ed0.
[    0.002728] e820: update [mem 0x90802000-0x90802fff] System RAM ==> device reserved
[    0.002738] Using GB pages for direct mapping
[    0.002996] Secure boot disabled
[    0.002996] RAMDISK: [mem 0x8228e000-0x84d64fff]
[    0.003121] ACPI: Early table checksum verification disabled
[    0.003124] ACPI: RSDP 0x00000000973EB014 000024 (v02 ALASKA)
[    0.003127] ACPI: XSDT 0x00000000973EA728 00017C (v01 ALASKA A M I    01072009 AMI  01000013)
[    0.003130] ACPI: FACP 0x000000009697F000 000114 (v06 ALASKA A M I    01072009 AMI  00010013)
[    0.003133] ACPI: DSDT 0x0000000096974000 00ABAC (v02 ALASKA A M I    01072009 INTL 20220331)
[    0.003135] ACPI: FACS 0x0000000096BA4000 000040
[    0.003136] ACPI: SSDT 0x0000000096981000 008416 (v02 AMD    AmdTable 00000002 MSFT 02000002)
[    0.003137] ACPI: SSDT 0x0000000096980000 000221 (v02 ALASKA CPUSSDT  01072009 AMI  01072009)
[    0.003138] ACPI: FIDT 0x0000000096973000 00009C (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.003139] ACPI: MCFG 0x0000000096972000 00003C (v01 ALASKA A M I    01072009 MSFT 00010013)
[    0.003140] ACPI: HPET 0x0000000096971000 000038 (v01 ALASKA A M I    01072009 AMI  00000005)
[    0.003141] ACPI: UEFI 0x0000000096BA3000 000048 (v01 ALASKA A M I    01072009 AMI  01000013)
[    0.003142] ACPI: FPDT 0x0000000096970000 000044 (v01 ALASKA A M I    01072009 AMI  01000013)
[    0.003144] ACPI: VFCT 0x000000009696B000 004284 (v01 ALASKA A M I    00000001 AMD  33504F47)
[    0.003145] ACPI: BGRT 0x000000009696A000 000038 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.003146] ACPI: TPM2 0x0000000096969000 000044 (v05 ALASKA A M I    00000001 AMI  00000000)
[    0.003147] ACPI: SSDT 0x0000000096963000 00547E (v02 AMD    AmdTable 00000001 AMD  00000001)
[    0.003148] ACPI: CRAT 0x0000000096962000 000EE8 (v01 AMD    AmdTable 00000001 AMD  00000001)
[    0.003149] ACPI: CDIT 0x0000000096961000 000029 (v01 AMD    AmdTable 00000001 AMD  00000001)
[    0.003150] ACPI: SSDT 0x000000009695F000 0015C8 (v02 AMD    CPMDFIG2 00000001 INTL 20220331)
[    0.003151] ACPI: SSDT 0x000000009695C000 002A9E (v02 AMD    CDFAAIG2 00000001 INTL 20220331)
[    0.003152] ACPI: SSDT 0x000000009695A000 0012AE (v02 AMD    OEMACP   00000001 INTL 20220331)
[    0.003153] ACPI: SSDT 0x0000000096959000 0008BA (v02 AMD    OEMPMF   00000001 INTL 20220331)
[    0.003154] ACPI: SSDT 0x000000009694F000 009902 (v02 AMD    CPMCMN   00000001 INTL 20220331)
[    0.003155] ACPI: WSMT 0x000000009694E000 000028 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.003156] ACPI: APIC 0x000000009694D000 0000E8 (v05 ALASKA A M I    01072009 AMI  00010013)
[    0.003157] ACPI: MHSP 0x000000009694C000 0000C8 (v04 AMD    AGESA    20505348 ?    00000001)
[    0.003158] ACPI: SSDT 0x000000009694B000 0000E5 (v02 MSFT   MHSP     00000004 INTL 20220331)
[    0.003159] ACPI: SSDT 0x0000000096948000 002370 (v02 AMD    AOD      00000001 INTL 20220331)
[    0.003160] ACPI: SSDT 0x0000000096947000 000051 (v02 AMD    DRTM     00000001 INTL 20220331)
[    0.003161] ACPI: IVRS 0x0000000096946000 0001F8 (v02 AMD    AmdTable 00000001 AMD  00000001)
[    0.003162] ACPI: SSDT 0x0000000096945000 000968 (v02 AMD    CPMMSOSC 00000001 INTL 20220331)
[    0.003163] ACPI: SSDT 0x0000000096944000 000FF5 (v02 AMD    CPMACPV5 00000001 INTL 20220331)
[    0.003164] ACPI: SSDT 0x0000000096943000 000608 (v02 AMD    TOUCHPNL 00000001 INTL 20220331)
[    0.003165] ACPI: SSDT 0x0000000096942000 000609 (v02 AMD    TOUCHPAD 00000001 INTL 20220331)
[    0.003166] ACPI: SSDT 0x0000000096941000 0007DD (v02 AMD    THERMAL0 00000001 INTL 20220331)
[    0.003167] ACPI: SSDT 0x0000000096940000 000FF7 (v02 AMD    GPP_PME_ 00000001 INTL 20220331)
[    0.003168] ACPI: SSDT 0x0000000096936000 0098BD (v02 AMD    INTGPP03 00000001 INTL 20220331)
[    0.003169] ACPI: SSDT 0x0000000096931000 004FEB (v02 AMD    INTGPP01 00000001 INTL 20220331)
[    0.003170] ACPI: SSDT 0x0000000096930000 000D89 (v02 AMD    CPMGPIO0 00000001 INTL 20220331)
[    0.003171] ACPI: SSDT 0x000000009692F000 00008D (v02 AMD    CPMMSLPI 00000001 INTL 20220331)
[    0.003172] ACPI: SSDT 0x000000009692E000 000501 (v02 AMD    CPMSFAML 00000001 INTL 20220331)
[    0.003173] ACPI: SSDT 0x000000009692D000 000CE0 (v02 AMD    WwanSsdt 00000001 INTL 20220331)
[    0.003174] ACPI: SSDT 0x000000009692C000 000BE8 (v01 AMD    WLAN     00000001 INTL 20220331)
[    0.003175] ACPI: SSDT 0x000000009692B000 00074A (v02 AMD    NVME     00000001 INTL 20220331)
[    0.003176] ACPI: SSDT 0x000000009692A000 000A51 (v02 AMD    GpMsSsdt 00000001 INTL 20220331)
[    0.003177] ACPI: SSDT 0x0000000096929000 000057 (v02 AMD    GPP0     00000001 INTL 20220331)
[    0.003178] ACPI: SSDT 0x0000000096927000 0017B8 (v02 AMD    UPEP     00000001 INTL 20220331)
[    0.003179] ACPI: Reserving FACP table memory at [mem 0x9697f000-0x9697f113]
[    0.003180] ACPI: Reserving DSDT table memory at [mem 0x96974000-0x9697ebab]
[    0.003180] ACPI: Reserving FACS table memory at [mem 0x96ba4000-0x96ba403f]
[    0.003180] ACPI: Reserving SSDT table memory at [mem 0x96981000-0x96989415]
[    0.003181] ACPI: Reserving SSDT table memory at [mem 0x96980000-0x96980220]
[    0.003181] ACPI: Reserving FIDT table memory at [mem 0x96973000-0x9697309b]
[    0.003181] ACPI: Reserving MCFG table memory at [mem 0x96972000-0x9697203b]
[    0.003181] ACPI: Reserving HPET table memory at [mem 0x96971000-0x96971037]
[    0.003182] ACPI: Reserving UEFI table memory at [mem 0x96ba3000-0x96ba3047]
[    0.003182] ACPI: Reserving FPDT table memory at [mem 0x96970000-0x96970043]
[    0.003182] ACPI: Reserving VFCT table memory at [mem 0x9696b000-0x9696f283]
[    0.003183] ACPI: Reserving BGRT table memory at [mem 0x9696a000-0x9696a037]
[    0.003183] ACPI: Reserving TPM2 table memory at [mem 0x96969000-0x96969043]
[    0.003183] ACPI: Reserving SSDT table memory at [mem 0x96963000-0x9696847d]
[    0.003183] ACPI: Reserving CRAT table memory at [mem 0x96962000-0x96962ee7]
[    0.003184] ACPI: Reserving CDIT table memory at [mem 0x96961000-0x96961028]
[    0.003184] ACPI: Reserving SSDT table memory at [mem 0x9695f000-0x969605c7]
[    0.003184] ACPI: Reserving SSDT table memory at [mem 0x9695c000-0x9695ea9d]
[    0.003185] ACPI: Reserving SSDT table memory at [mem 0x9695a000-0x9695b2ad]
[    0.003185] ACPI: Reserving SSDT table memory at [mem 0x96959000-0x969598b9]
[    0.003185] ACPI: Reserving SSDT table memory at [mem 0x9694f000-0x96958901]
[    0.003185] ACPI: Reserving WSMT table memory at [mem 0x9694e000-0x9694e027]
[    0.003186] ACPI: Reserving APIC table memory at [mem 0x9694d000-0x9694d0e7]
[    0.003186] ACPI: Reserving MHSP table memory at [mem 0x9694c000-0x9694c0c7]
[    0.003186] ACPI: Reserving SSDT table memory at [mem 0x9694b000-0x9694b0e4]
[    0.003186] ACPI: Reserving SSDT table memory at [mem 0x96948000-0x9694a36f]
[    0.003187] ACPI: Reserving SSDT table memory at [mem 0x96947000-0x96947050]
[    0.003187] ACPI: Reserving IVRS table memory at [mem 0x96946000-0x969461f7]
[    0.003187] ACPI: Reserving SSDT table memory at [mem 0x96945000-0x96945967]
[    0.003188] ACPI: Reserving SSDT table memory at [mem 0x96944000-0x96944ff4]
[    0.003188] ACPI: Reserving SSDT table memory at [mem 0x96943000-0x96943607]
[    0.003188] ACPI: Reserving SSDT table memory at [mem 0x96942000-0x96942608]
[    0.003188] ACPI: Reserving SSDT table memory at [mem 0x96941000-0x969417dc]
[    0.003189] ACPI: Reserving SSDT table memory at [mem 0x96940000-0x96940ff6]
[    0.003189] ACPI: Reserving SSDT table memory at [mem 0x96936000-0x9693f8bc]
[    0.003189] ACPI: Reserving SSDT table memory at [mem 0x96931000-0x96935fea]
[    0.003190] ACPI: Reserving SSDT table memory at [mem 0x96930000-0x96930d88]
[    0.003190] ACPI: Reserving SSDT table memory at [mem 0x9692f000-0x9692f08c]
[    0.003190] ACPI: Reserving SSDT table memory at [mem 0x9692e000-0x9692e500]
[    0.003190] ACPI: Reserving SSDT table memory at [mem 0x9692d000-0x9692dcdf]
[    0.003191] ACPI: Reserving SSDT table memory at [mem 0x9692c000-0x9692cbe7]
[    0.003191] ACPI: Reserving SSDT table memory at [mem 0x9692b000-0x9692b749]
[    0.003191] ACPI: Reserving SSDT table memory at [mem 0x9692a000-0x9692aa50]
[    0.003192] ACPI: Reserving SSDT table memory at [mem 0x96929000-0x96929056]
[    0.003192] ACPI: Reserving SSDT table memory at [mem 0x96927000-0x969287b7]
[    0.003240] No NUMA configuration found
[    0.003241] Faking a node at [mem 0x0000000000000000-0x000000055e2fffff]
[    0.003245] NODE_DATA(0) allocated [mem 0x55e2d5240-0x55e2fffff]
[    0.003969] ACPI: PM-Timer IO Port: 0x808
[    0.003973] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.003986] IOAPIC[0]: apic_id 33, version 33, address 0xfec00000, GSI 0-23
[    0.003990] IOAPIC[1]: apic_id 34, version 33, address 0xfec01000, GSI 24-55
[    0.003991] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.003992] ACPI: INT_SRC_OVR (bus 0 bus_irq 1 global_irq 1 low edge)
[    0.003993] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.003995] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.003995] ACPI: HPET id: 0x10228201 base: 0xfed00000
[    0.003999] e820: update [mem 0x8ffe2000-0x905d0fff] System RAM ==> device reserved
[    0.004007] CPU topo: Max. logical packages:   1
[    0.004007] CPU topo: Max. logical dies:       1
[    0.004007] CPU topo: Max. dies per package:   1
[    0.004010] CPU topo: Max. threads per core:   2
[    0.004010] CPU topo: Num. cores per package:     8
[    0.004010] CPU topo: Num. threads per package:  16
[    0.004011] CPU topo: Allowing 16 present CPUs plus 0 hotplug CPUs
[    0.004021] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.004022] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000fffff]
[    0.004022] PM: hibernation: Registered nosave memory: [mem 0x09a7f000-0x09ffffff]
[    0.004023] PM: hibernation: Registered nosave memory: [mem 0x0a200000-0x0a23bfff]
[    0.004024] PM: hibernation: Registered nosave memory: [mem 0x8ffe2000-0x905d0fff]
[    0.004024] PM: hibernation: Registered nosave memory: [mem 0x90802000-0x90802fff]
[    0.004025] PM: hibernation: Registered nosave memory: [mem 0x93f07000-0x9affefff]
[    0.004026] PM: hibernation: Registered nosave memory: [mem 0x9bff9000-0x9bffcfff]
[    0.004026] PM: hibernation: Registered nosave memory: [mem 0x9bfff000-0xffffffff]
[    0.004028] [gap 0xa0000000-0xfedfffff] available for PCI devices
[    0.004028] Booting paravirtualized kernel on bare hardware
[    0.004030] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.007259] Zone ranges:
[    0.007260]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.007261]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.007262]   Normal   [mem 0x0000000100000000-0x000000055e2fffff]
[    0.007262]   Device   empty
[    0.007263] Movable zone start for each node
[    0.007263] Early memory node ranges
[    0.007264]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
[    0.007264]   node   0: [mem 0x0000000000100000-0x0000000009a7efff]
[    0.007265]   node   0: [mem 0x000000000a000000-0x000000000a1fffff]
[    0.007265]   node   0: [mem 0x000000000a23c000-0x0000000093f06fff]
[    0.007265]   node   0: [mem 0x000000009afff000-0x000000009bff8fff]
[    0.007266]   node   0: [mem 0x000000009bffd000-0x000000009bffefff]
[    0.007266]   node   0: [mem 0x0000000100000000-0x000000055e2fffff]
[    0.007268] Initmem setup node 0 [mem 0x0000000000001000-0x000000055e2fffff]
[    0.007272] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.007280] On node 0, zone DMA: 96 pages in unavailable ranges
[    0.007343] On node 0, zone DMA32: 1409 pages in unavailable ranges
[    0.008636] On node 0, zone DMA32: 60 pages in unavailable ranges
[    0.008722] On node 0, zone DMA32: 28920 pages in unavailable ranges
[    0.008723] On node 0, zone DMA32: 4 pages in unavailable ranges
[    0.020289] On node 0, zone Normal: 16385 pages in unavailable ranges
[    0.020310] On node 0, zone Normal: 7424 pages in unavailable ranges
[    0.020318] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:16 nr_cpu_ids:16 nr_node_ids:1
[    0.020555] percpu: Embedded 63 pages/cpu s221184 r8192 d28672 u262144
[    0.020559] pcpu-alloc: s221184 r8192 d28672 u262144 alloc=1*2097152
[    0.020561] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 12 13 14 15 
[    0.020575] Kernel command line: initrd=\initramfs-linux-debug.img amd_pstate=active kvm.mitigate_smt_rsb=1 root=PARTUUID=e57babd5-4363-4337-8f75-0abf8481c852 rootflags=subvol=@ rootfstype=btrfs rw zswap.enabled=0
[    0.020810] printk: log buffer data + meta data: 131072 + 458752 = 589824 bytes
[    0.022064] Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes, linear)
[    0.022730] Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
[    0.022827] software IO TLB: area num 16.
[    0.027702] Fallback order for Node 0: 0 
[    0.027709] Built 1 zonelists, mobility grouping on.  Total pages: 5188581
[    0.027710] Policy zone: Normal
[    0.027807] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    0.044341] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=16, Nodes=1
[    0.052136] ftrace: allocating 54818 entries in 216 pages
[    0.052137] ftrace: allocated 216 pages with 4 groups
[    0.052196] Dynamic Preempt: full
[    0.052242] rcu: Preemptible hierarchical RCU implementation.
[    0.052243] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=16.
[    0.052244] rcu: 	RCU priority boosting: priority 1 delay 500 ms.
[    0.052245] 	Trampoline variant of Tasks RCU enabled.
[    0.052245] 	Rude variant of Tasks RCU enabled.
[    0.052245] 	Tracing variant of Tasks RCU enabled.
[    0.052246] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.052246] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=16
[    0.052253] RCU Tasks: Setting shift to 4 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=16.
[    0.052255] RCU Tasks Rude: Setting shift to 4 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=16.
[    0.054872] NR_IRQS: 524544, nr_irqs: 1096, preallocated irqs: 16
[    0.055051] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.055207] kfence: initialized - using 2097152 bytes for 255 objects at 0x(____ptrval____)-0x(____ptrval____)
[    0.055238] Console: colour dummy device 80x25
[    0.055240] printk: legacy console [tty0] enabled
[    0.055270] ACPI: Core revision 20251212
[    0.055431] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
[    0.055450] APIC: Switch to symmetric I/O mode setup
[    0.055713] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR0, rdevid:0xa0
[    0.055714] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR1, rdevid:0xa0
[    0.055715] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR2, rdevid:0xa0
[    0.055715] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR3, rdevid:0xa0
[    0.055716] AMD-Vi: Using global IVHD EFR:0x246577efa2054ada, EFR2:0x0
[    0.056053] x2apic: IRQ remapping doesn't support X2APIC mode
[    0.056800] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.061451] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x6d5a4efad5e, max_idle_ns: 881590493027 ns
[    0.061454] Calibrating delay loop (skipped), value calculated using timer frequency.. 7586.34 BogoMIPS (lpj=3793174)
[    0.061469] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.061686] LVT offset 1 assigned for vector 0xf9
[    0.061687] LVT offset 2 assigned for vector 0xf4
[    0.062096] Last level iTLB entries: 4KB 512, 2MB 512, 4MB 256
[    0.062097] Last level dTLB entries: 4KB 3072, 2MB 3072, 4MB 1536, 1GB 0
[    0.062100] process: using mwait in idle threads
[    0.062101] mitigations: Enabled attack vectors: user_kernel, user_user, guest_host, guest_guest, SMT mitigations: auto
[    0.062104] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    0.062105] Transient Scheduler Attacks: Mitigation: Clear CPU buffers
[    0.062106] Spectre V2 : Mitigation: Enhanced / Automatic IBRS
[    0.062106] Spectre V2 : User space: Mitigation: STIBP always-on protection
[    0.062107] Speculative Return Stack Overflow: Mitigation: Safe RET
[    0.062107] VMSCAPE: Mitigation: IBPB before exit to userspace
[    0.062108] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.062109] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.062110] active return thunk: srso_alias_return_thunk
[    0.062118] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.062119] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.062120] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.062120] x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
[    0.062121] x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
[    0.062122] x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'
[    0.062122] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
[    0.062123] x86/fpu: Supporting XSAVE feature 0x800: 'Control-flow User registers'
[    0.062124] x86/fpu: Supporting XSAVE feature 0x1000: 'Control-flow Kernel registers (KVM only)'
[    0.062125] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.062126] x86/fpu: xstate_offset[5]:  832, xstate_sizes[5]:   64
[    0.062126] x86/fpu: xstate_offset[6]:  896, xstate_sizes[6]:  512
[    0.062127] x86/fpu: xstate_offset[7]: 1408, xstate_sizes[7]: 1024
[    0.062128] x86/fpu: xstate_offset[9]: 2432, xstate_sizes[9]:    8
[    0.062128] x86/fpu: xstate_offset[11]: 2440, xstate_sizes[11]:   16
[    0.062129] x86/fpu: xstate_offset[12]: 2456, xstate_sizes[12]:   24
[    0.062130] x86/fpu: Enabled xstate features 0x1ae7, context size is 2480 bytes, using 'compacted' format.
[    0.085276] Freeing SMP alternatives memory: 56K
[    0.085279] pid_max: default: 32768 minimum: 301
[    0.085398] landlock: Up and running.
[    0.085400] Yama: becoming mindful.
[    0.085570] LSM support for eBPF active
[    0.085616] Mount-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.085636] Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.085700] VFS: Finished mounting rootfs on nullfs
[    0.188082] smpboot: CPU0: AMD Ryzen 7 8745HS w/ Radeon 780M Graphics (family: 0x19, model: 0x75, stepping: 0x2)
[    0.188272] Performance Events: Fam17h+ 16-deep LBR, core perfctr, AMD PMU driver.
[    0.188301] ... version:                   2
[    0.188302] ... bit width:                 48
[    0.188303] ... generic counters:          6
[    0.188304] ... generic bitmap:            000000000000003f
[    0.188305] ... fixed-purpose counters:    0
[    0.188305] ... fixed-purpose bitmap:      0000000000000000
[    0.188306] ... value mask:                0000ffffffffffff
[    0.188307] ... max period:                00007fffffffffff
[    0.188308] ... global_ctrl mask:          000000000000003f
[    0.188408] signal: max sigframe size: 3376
[    0.188453] rcu: Hierarchical SRCU implementation.
[    0.188453] rcu: 	Max phase no-delay instances is 400.
[    0.188453] Timer migration: 2 hierarchy levels; 8 children per group; 2 crossnode level
[    0.192196] MCE: In-kernel MCE decoding enabled.
[    0.192238] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.192368] smp: Bringing up secondary CPUs ...
[    0.192447] smpboot: x86: Booting SMP configuration:
[    0.192449] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8  #9 #10 #11 #12 #13 #14 #15
[    0.203573] Spectre V2 : Update user space SMT mitigation: STIBP always-on
[    0.211494] smp: Brought up 1 node, 16 CPUs
[    0.211494] smpboot: Total of 16 processors activated (121381.56 BogoMIPS)
[    0.212643] Memory: 20174760K/20754324K available (19661K kernel code, 3530K rwdata, 15400K rodata, 4664K init, 4456K bss, 555792K reserved, 0K cma-reserved)
[    0.212937] devtmpfs: initialized
[    0.212937] x86/mm: Memory block size: 128MB
[    0.215099] ACPI: PM: Registering ACPI NVS region [mem 0x0a200000-0x0a23bfff] (245760 bytes)
[    0.215099] ACPI: PM: Registering ACPI NVS region [mem 0x9698a000-0x97404fff] (10989568 bytes)
[    0.215099] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.215099] posixtimers hash table entries: 8192 (order: 5, 131072 bytes, linear)
[    0.215099] futex hash table entries: 4096 (262144 bytes on 1 NUMA nodes, total 256 KiB, linear).
[    0.215099] xor: automatically using best checksumming function   avx       
[    0.215551] PM: RTC time: 21:14:38, date: 2026-03-03
[    0.215797] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.216045] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic allocations
[    0.216156] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.216293] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.216299] audit: initializing netlink subsys (disabled)
[    0.216305] audit: type=2000 audit(1772572478.159:1): state=initialized audit_enabled=0 res=1
[    0.216305] thermal_sys: Registered thermal governor 'fair_share'
[    0.216305] thermal_sys: Registered thermal governor 'bang_bang'
[    0.216305] thermal_sys: Registered thermal governor 'step_wise'
[    0.216305] thermal_sys: Registered thermal governor 'user_space'
[    0.216305] thermal_sys: Registered thermal governor 'power_allocator'
[    0.216305] cpuidle: using governor ladder
[    0.216305] cpuidle: using governor menu
[    0.216537] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.216586] PCI: ECAM [mem 0xe0000000-0xefffffff] (base 0xe0000000) for domain 0000 [bus 00-ff]
[    0.216599] PCI: Using configuration type 1 for base access
[    0.216731] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    0.221639] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.221641] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.221643] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.221644] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.222773] raid6: skipped pq benchmark and selected avx512x4
[    0.222775] raid6: using avx512x2 recovery algorithm
[    0.222860] ACPI: Added _OSI(Module Device)
[    0.222862] ACPI: Added _OSI(Processor Device)
[    0.222864] ACPI: Added _OSI(Processor Aggregator Device)
[    0.246852] ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.GPP5.RTL8._S0W], AE_ALREADY_EXISTS (20251212/dswload2-326)
[    0.246860] fbcon: Taking over console
[    0.246871] ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20251212/psobject-220)
[    0.247494] ACPI: 29 ACPI AML tables successfully acquired and loaded
[    0.260694] ACPI: \_SB_: platform _OSC: OS support mask [006e7efe]
[    0.260810] ACPI: \_SB_: platform _OSC: OS control mask [006e7e7e]
[    0.261089] ACPI: USB4 _OSC: OS supports USB3+ DisplayPort+ PCIe+ XDomain+
[    0.261091] ACPI: USB4 _OSC: OS controls USB3+ DisplayPort+ PCIe+ XDomain+
[    0.262824] ACPI: Interpreter enabled
[    0.262836] ACPI: PM: (supports S0 S4 S5)
[    0.262837] ACPI: Using IOAPIC for interrupt routing
[    0.264218] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.264220] PCI: Ignoring E820 reservations for host bridge windows
[    0.264726] ACPI: Enabled 3 GPEs in block 00 to 1F
[    0.266015] ACPI: \_SB_.PCI0.GPP2.P0WW: New power resource
[    0.267084] ACPI: \_SB_.PCI0.GPP6.PWSR: New power resource
[    0.268509] ACPI: \_SB_.PCI0.GPP8.P0NV: New power resource
[    0.270448] ACPI: \_SB_.PCI0.GP11.PWRS: New power resource
[    0.271807] ACPI: \_SB_.PCI0.GP11.SWUS.PWRS: New power resource
[    0.272403] ACPI: \_SB_.PCI0.GP12.PWRS: New power resource
[    0.273042] ACPI: \_SB_.PCI0.GP12.SWUS.PWRS: New power resource
[    0.273287] ACPI: \_SB_.PCI0.GP17.PWRS: New power resource
[    0.273546] ACPI: \_SB_.PCI0.GP17.VGA_.PWRS: New power resource
[    0.273864] ACPI: \_SB_.PCI0.GP17.HDAU.PWRS: New power resource
[    0.274128] ACPI: \_SB_.PCI0.GP17.ACP_.PWRS: New power resource
[    0.274770] ACPI: \_SB_.PCI0.GP17.AZAL.PWRS: New power resource
[    0.275384] ACPI: \_SB_.PCI0.GP17.XHC0.PWRS: New power resource
[    0.278151] ACPI: \_SB_.PCI0.GP17.XHC1.PWRS: New power resource
[    0.280244] ACPI: \_SB_.PCI0.GP19.XHC2.PWRS: New power resource
[    0.281670] ACPI: \_SB_.PCI0.GP19.XHC3.PWRS: New power resource
[    0.283139] ACPI: \_SB_.PCI0.GP19.XHC4.PWRS: New power resource
[    0.284602] ACPI: \_SB_.PCI0.GP19.NHI0.PWRS: New power resource
[    0.285419] ACPI: \_SB_.PCI0.GP19.NHI1.PWRS: New power resource
[    0.296643] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.296647] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
[    0.296808] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME AER PCIeCapability LTR DPC]
[    0.297396] PCI host bridge to bus 0000:00
[    0.297399] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    0.297401] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    0.297402] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
[    0.297403] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.297405] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000dffff window]
[    0.297406] pci_bus 0000:00: root bus resource [mem 0xfa000000-0xfcffffff window]
[    0.297407] pci_bus 0000:00: root bus resource [mem 0xf0000000-0xf9ffffff window]
[    0.297408] pci_bus 0000:00: root bus resource [mem 0xa0000000-0xdfffffff window]
[    0.297410] pci_bus 0000:00: root bus resource [mem 0x660000000-0x7fffffffff window]
[    0.297411] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.297424] pci 0000:00:00.0: [1022:14e8] type 00 class 0x060000 conventional PCI endpoint
[    0.297537] pci 0000:00:00.2: [1022:14e9] type 00 class 0x080600 conventional PCI endpoint
[    0.297640] pci 0000:00:01.0: [1022:14ea] type 00 class 0x060000 conventional PCI endpoint
[    0.297711] pci 0000:00:02.0: [1022:14ea] type 00 class 0x060000 conventional PCI endpoint
[    0.297780] pci 0000:00:02.1: [1022:14ee] type 01 class 0x060400 PCIe Root Port
[    0.297797] pci 0000:00:02.1: PCI bridge to [bus 01]
[    0.297802] pci 0000:00:02.1:   bridge window [io  0xf000-0xffff]
[    0.297805] pci 0000:00:02.1:   bridge window [mem 0xdcb00000-0xdcbfffff]
[    0.297818] pci 0000:00:02.1: enabling Extended Tags
[    0.297892] pci 0000:00:02.1: PME# supported from D0 D3hot D3cold
[    0.298034] pci 0000:00:02.2: [1022:14ee] type 01 class 0x060400 PCIe Root Port
[    0.298051] pci 0000:00:02.2: PCI bridge to [bus 02]
[    0.298056] pci 0000:00:02.2:   bridge window [mem 0xdca00000-0xdcafffff]
[    0.298070] pci 0000:00:02.2: enabling Extended Tags
[    0.298142] pci 0000:00:02.2: PME# supported from D0 D3hot D3cold
[    0.298281] pci 0000:00:02.3: [1022:14ee] type 01 class 0x060400 PCIe Root Port
[    0.298297] pci 0000:00:02.3: PCI bridge to [bus 03]
[    0.298315] pci 0000:00:02.3: enabling Extended Tags
[    0.298387] pci 0000:00:02.3: PME# supported from D0 D3hot D3cold
[    0.298525] pci 0000:00:02.4: [1022:14ee] type 01 class 0x060400 PCIe Root Port
[    0.298542] pci 0000:00:02.4: PCI bridge to [bus 04]
[    0.298547] pci 0000:00:02.4:   bridge window [mem 0xdc900000-0xdc9fffff]
[    0.298631] pci 0000:00:02.4: PME# supported from D0 D3hot D3cold
[    0.298757] pci 0000:00:03.0: [1022:14ea] type 00 class 0x060000 conventional PCI endpoint
[    0.298835] pci 0000:00:03.1: [1022:14ef] type 01 class 0x060400 PCIe Root Port
[    0.298944] pci 0000:00:03.1: PCI bridge to [bus 05-64]
[    0.298950] pci 0000:00:03.1:   bridge window [io  0xa000-0xdfff]
[    0.298953] pci 0000:00:03.1:   bridge window [mem 0xc4000000-0xdbffffff]
[    0.298977] pci 0000:00:03.1:   bridge window [mem 0x6c00000000-0x7bffffffff 64bit pref]
[    0.298989] pci 0000:00:03.1: enabling Extended Tags
[    0.299271] pci 0000:00:03.1: PME# supported from D0 D3hot D3cold
[    0.300677] pci 0000:00:04.0: [1022:14ea] type 00 class 0x060000 conventional PCI endpoint
[    0.300753] pci 0000:00:08.0: [1022:14ea] type 00 class 0x060000 conventional PCI endpoint
[    0.300818] pci 0000:00:08.1: [1022:14eb] type 01 class 0x060400 PCIe Root Port
[    0.300832] pci 0000:00:08.1: PCI bridge to [bus 65]
[    0.300836] pci 0000:00:08.1:   bridge window [io  0xe000-0xefff]
[    0.300838] pci 0000:00:08.1:   bridge window [mem 0xdc000000-0xdc5fffff]
[    0.300844] pci 0000:00:08.1:   bridge window [mem 0x7c00000000-0x7c107fffff 64bit pref]
[    0.300850] pci 0000:00:08.1: enabling Extended Tags
[    0.300889] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
[    0.301150] pci 0000:00:08.2: [1022:14eb] type 01 class 0x060400 PCIe Root Port
[    0.301165] pci 0000:00:08.2: PCI bridge to [bus 66]
[    0.301179] pci 0000:00:08.2: enabling Extended Tags
[    0.301218] pci 0000:00:08.2: PME# supported from D0 D3hot D3cold
[    0.301322] pci 0000:00:08.3: [1022:14eb] type 01 class 0x060400 PCIe Root Port
[    0.301336] pci 0000:00:08.3: PCI bridge to [bus 67]
[    0.301340] pci 0000:00:08.3:   bridge window [mem 0xdc600000-0xdc8fffff]
[    0.301351] pci 0000:00:08.3: enabling Extended Tags
[    0.301391] pci 0000:00:08.3: PME# supported from D0 D3hot D3cold
[    0.301680] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500 conventional PCI endpoint
[    0.301801] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100 conventional PCI endpoint
[    0.301928] pci 0000:00:18.0: [1022:14f0] type 00 class 0x060000 conventional PCI endpoint
[    0.301965] pci 0000:00:18.1: [1022:14f1] type 00 class 0x060000 conventional PCI endpoint
[    0.302002] pci 0000:00:18.2: [1022:14f2] type 00 class 0x060000 conventional PCI endpoint
[    0.302037] pci 0000:00:18.3: [1022:14f3] type 00 class 0x060000 conventional PCI endpoint
[    0.302072] pci 0000:00:18.4: [1022:14f4] type 00 class 0x060000 conventional PCI endpoint
[    0.302106] pci 0000:00:18.5: [1022:14f5] type 00 class 0x060000 conventional PCI endpoint
[    0.302141] pci 0000:00:18.6: [1022:14f6] type 00 class 0x060000 conventional PCI endpoint
[    0.302175] pci 0000:00:18.7: [1022:14f7] type 00 class 0x060000 conventional PCI endpoint
[    0.302321] pci 0000:01:00.0: [10ec:8125] type 00 class 0x020000 PCIe Endpoint
[    0.302368] pci 0000:01:00.0: BAR 0 [io  0xf000-0xf0ff]
[    0.302374] pci 0000:01:00.0: BAR 2 [mem 0xdcb00000-0xdcb0ffff 64bit]
[    0.302378] pci 0000:01:00.0: BAR 4 [mem 0xdcb10000-0xdcb13fff 64bit]
[    0.302481] pci 0000:01:00.0: supports D1 D2
[    0.302483] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.302738] pci 0000:00:02.1: PCI bridge to [bus 01]
[    0.303156] pci 0000:02:00.0: [8086:2723] type 00 class 0x028000 PCIe Endpoint
[    0.303237] pci 0000:02:00.0: BAR 0 [mem 0xdca00000-0xdca03fff 64bit]
[    0.303389] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.304479] pci 0000:00:02.2: PCI bridge to [bus 02]
[    0.304601] pci 0000:00:02.3: PCI bridge to [bus 03]
[    0.304715] pci 0000:04:00.0: [1344:5416] type 00 class 0x010802 PCIe Endpoint
[    0.304751] pci 0000:04:00.0: BAR 0 [mem 0xdc900000-0xdc903fff 64bit]
[    0.305037] pci 0000:00:02.4: PCI bridge to [bus 04]
[    0.305134] pci 0000:00:03.1: PCI bridge to [bus 05-64]
[    0.305252] pci 0000:65:00.0: [1002:1900] type 00 class 0x030000 PCIe Legacy Endpoint
[    0.305280] pci 0000:65:00.0: BAR 0 [mem 0x7c00000000-0x7c0fffffff 64bit pref]
[    0.305283] pci 0000:65:00.0: BAR 2 [mem 0xdc000000-0xdc1fffff 64bit pref]
[    0.305285] pci 0000:65:00.0: BAR 4 [io  0xe000-0xe0ff]
[    0.305287] pci 0000:65:00.0: BAR 5 [mem 0xdc500000-0xdc57ffff]
[    0.305293] pci 0000:65:00.0: enabling Extended Tags
[    0.305357] pci 0000:65:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.305662] pci 0000:65:00.1: [1002:1640] type 00 class 0x040300 PCIe Legacy Endpoint
[    0.305688] pci 0000:65:00.1: BAR 0 [mem 0xdc5c8000-0xdc5cbfff]
[    0.305697] pci 0000:65:00.1: enabling Extended Tags
[    0.305737] pci 0000:65:00.1: PME# supported from D1 D2 D3hot D3cold
[    0.305968] pci 0000:65:00.2: [1022:15c7] type 00 class 0x108000 PCIe Endpoint
[    0.305995] pci 0000:65:00.2: BAR 2 [mem 0xdc400000-0xdc4fffff]
[    0.305999] pci 0000:65:00.2: BAR 5 [mem 0xdc5cc000-0xdc5cdfff]
[    0.306004] pci 0000:65:00.2: enabling Extended Tags
[    0.306134] pci 0000:65:00.3: [1022:15b9] type 00 class 0x0c0330 PCIe Endpoint
[    0.306161] pci 0000:65:00.3: BAR 0 [mem 0xdc300000-0xdc3fffff 64bit]
[    0.306170] pci 0000:65:00.3: enabling Extended Tags
[    0.306212] pci 0000:65:00.3: PME# supported from D0 D3hot D3cold
[    0.306476] pci 0000:65:00.4: [1022:15ba] type 00 class 0x0c0330 PCIe Endpoint
[    0.306504] pci 0000:65:00.4: BAR 0 [mem 0xdc200000-0xdc2fffff 64bit]
[    0.306512] pci 0000:65:00.4: enabling Extended Tags
[    0.306555] pci 0000:65:00.4: PME# supported from D0 D3hot D3cold
[    0.306801] pci 0000:65:00.5: [1022:15e2] type 00 class 0x048000 PCIe Endpoint
[    0.306826] pci 0000:65:00.5: BAR 0 [mem 0xdc580000-0xdc5bffff]
[    0.306830] pci 0000:65:00.5: BAR 2 [mem 0x7c10000000-0x7c107fffff 64bit pref]
[    0.306837] pci 0000:65:00.5: enabling Extended Tags
[    0.306876] pci 0000:65:00.5: PME# supported from D0 D3hot D3cold
[    0.307114] pci 0000:65:00.6: [1022:15e3] type 00 class 0x040300 PCIe Endpoint
[    0.307140] pci 0000:65:00.6: BAR 0 [mem 0xdc5c0000-0xdc5c7fff]
[    0.307149] pci 0000:65:00.6: enabling Extended Tags
[    0.307189] pci 0000:65:00.6: PME# supported from D0 D3hot D3cold
[    0.307438] pci 0000:00:08.1: PCI bridge to [bus 65]
[    0.307497] pci 0000:66:00.0: [1022:14ec] type 00 class 0x130000 PCIe Endpoint
[    0.307530] pci 0000:66:00.0: enabling Extended Tags
[    0.307583] pci 0000:66:00.0: PME# supported from D3hot D3cold
[    0.307679] pci 0000:00:08.2: PCI bridge to [bus 66]
[    0.307761] pci 0000:67:00.0: [1022:14ec] type 00 class 0x130000 PCIe Endpoint
[    0.307794] pci 0000:67:00.0: enabling Extended Tags
[    0.308272] pci 0000:67:00.3: [1022:15c0] type 00 class 0x0c0330 PCIe Endpoint
[    0.308299] pci 0000:67:00.3: BAR 0 [mem 0xdc700000-0xdc7fffff 64bit]
[    0.308308] pci 0000:67:00.3: enabling Extended Tags
[    0.308350] pci 0000:67:00.3: PME# supported from D0 D3hot D3cold
[    0.308758] pci 0000:67:00.4: [1022:15c1] type 00 class 0x0c0330 PCIe Endpoint
[    0.308785] pci 0000:67:00.4: BAR 0 [mem 0xdc600000-0xdc6fffff 64bit]
[    0.308794] pci 0000:67:00.4: enabling Extended Tags
[    0.308836] pci 0000:67:00.4: PME# supported from D0 D3hot D3cold
[    0.309237] pci 0000:67:00.5: [1022:1668] type 00 class 0x0c0340 PCIe Endpoint
[    0.309268] pci 0000:67:00.5: BAR 0 [mem 0xdc800000-0xdc87ffff 64bit]
[    0.309277] pci 0000:67:00.5: enabling Extended Tags
[    0.309319] pci 0000:67:00.5: PME# supported from D0 D3hot D3cold
[    0.309734] pci 0000:00:08.3: PCI bridge to [bus 67]
[    0.317065] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.317118] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
[    0.317164] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.317221] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.317273] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.317316] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.317359] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.317405] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    0.318854] Low-power S0 idle used by default for system suspend
[    0.319156] iommu: Default domain type: Translated
[    0.319156] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.319577] SCSI subsystem initialized
[    0.319581] libata version 3.00 loaded.
[    0.319581] ACPI: bus type USB registered
[    0.319581] usbcore: registered new interface driver usbfs
[    0.319581] usbcore: registered new interface driver hub
[    0.319581] usbcore: registered new device driver usb
[    0.319581] EDAC MC: Ver: 3.0.0
[    0.319844] efivars: Registered efivars operations
[    0.319844] NetLabel: Initializing
[    0.319844] NetLabel:  domain hash size = 128
[    0.319844] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.319844] NetLabel:  unlabeled traffic allowed by default
[    0.319844] mctp: management component transport protocol core
[    0.319844] NET: Registered PF_MCTP protocol family
[    0.319844] PCI: Using ACPI for IRQ routing
[    0.329832] PCI: pci_cache_line_size set to 64 bytes
[    0.330369] e820: register RAM buffer resource [mem 0x09a7f000-0x0bffffff]
[    0.330371] e820: register RAM buffer resource [mem 0x0a200000-0x0bffffff]
[    0.330372] e820: register RAM buffer resource [mem 0x8ffe2000-0x8fffffff]
[    0.330373] e820: register RAM buffer resource [mem 0x90802000-0x93ffffff]
[    0.330374] e820: register RAM buffer resource [mem 0x93f07000-0x93ffffff]
[    0.330375] e820: register RAM buffer resource [mem 0x9bff9000-0x9bffffff]
[    0.330376] e820: register RAM buffer resource [mem 0x9bfff000-0x9bffffff]
[    0.330377] e820: register RAM buffer resource [mem 0x55e300000-0x55fffffff]
[    0.330475] pci 0000:65:00.0: vgaarb: setting as boot VGA device
[    0.330477] pci 0000:65:00.0: vgaarb: bridge control possible
[    0.330478] pci 0000:65:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
[    0.330481] vgaarb: loaded
[    0.330511] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.330515] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.332509] clocksource: Switched to clocksource tsc-early
[    0.332631] VFS: Disk quotas dquot_6.6.0
[    0.332638] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.332726] acpi PNP0C01:00: Reserved [mem 0xe0000000-0xefffffff]
[    0.332750] acpi PNP0C02:00: Reserved [mem 0xfd300000-0xfd3fffff]
[    0.332877] acpi PNP0C02:01: Reserved [io  0x0a00-0x0a0f]
[    0.332879] acpi PNP0C02:01: Reserved [io  0x0a10-0x0a1f]
[    0.332880] acpi PNP0C02:01: Reserved [io  0x0a20-0x0a2f]
[    0.333045] acpi PNP0C02:02: Skipped [io  0x0010-0x001f]
[    0.333047] acpi PNP0C02:02: Skipped [io  0x0022-0x003f]
[    0.333048] acpi PNP0C02:02: Skipped [io  0x0063]
[    0.333049] acpi PNP0C02:02: Skipped [io  0x0065]
[    0.333050] acpi PNP0C02:02: Skipped [io  0x0067-0x006f]
[    0.333051] acpi PNP0C02:02: Skipped [io  0x0072-0x007f]
[    0.333052] acpi PNP0C02:02: Skipped [io  0x0080]
[    0.333053] acpi PNP0C02:02: Skipped [io  0x0084-0x0086]
[    0.333054] acpi PNP0C02:02: Skipped [io  0x0088]
[    0.333055] acpi PNP0C02:02: Skipped [io  0x008c-0x008e]
[    0.333056] acpi PNP0C02:02: Skipped [io  0x0090-0x009f]
[    0.333057] acpi PNP0C02:02: Skipped [io  0x00a2-0x00bf]
[    0.333059] acpi PNP0C02:02: Skipped [io  0x00b1]
[    0.333060] acpi PNP0C02:02: Skipped [io  0x00e0-0x00ef]
[    0.333061] acpi PNP0C02:02: Reserved [io  0x04d0-0x04d1]
[    0.333062] acpi PNP0C02:02: Reserved [io  0x040b]
[    0.333063] acpi PNP0C02:02: Reserved [io  0x04d6]
[    0.333064] acpi PNP0C02:02: Reserved [io  0x0c00-0x0c01]
[    0.333066] acpi PNP0C02:02: Reserved [io  0x0c14]
[    0.333067] acpi PNP0C02:02: Reserved [io  0x0c50-0x0c51]
[    0.333068] acpi PNP0C02:02: Reserved [io  0x0c52]
[    0.333069] acpi PNP0C02:02: Reserved [io  0x0c6c]
[    0.333070] acpi PNP0C02:02: Reserved [io  0x0c6f]
[    0.333071] acpi PNP0C02:02: Reserved [io  0x0cd0-0x0cd1]
[    0.333072] acpi PNP0C02:02: Reserved [io  0x0cd2-0x0cd3]
[    0.333074] acpi PNP0C02:02: Reserved [io  0x0cd4-0x0cd5]
[    0.333075] acpi PNP0C02:02: Reserved [io  0x0cd6-0x0cd7]
[    0.333076] acpi PNP0C02:02: Reserved [io  0x0cd8-0x0cdf]
[    0.333077] acpi PNP0C02:02: Reserved [io  0x0800-0x089f]
[    0.333078] acpi PNP0C02:02: Reserved [io  0x0b00-0x0b0f]
[    0.333079] acpi PNP0C02:02: Reserved [io  0x0b20-0x0b3f]
[    0.333081] acpi PNP0C02:02: Reserved [io  0x0900-0x090f]
[    0.333082] acpi PNP0C02:02: Reserved [io  0x0910-0x091f]
[    0.333083] acpi PNP0C02:02: Could not reserve [mem 0xfec00000-0xfec00fff]
[    0.333084] acpi PNP0C02:02: Could not reserve [mem 0xfec01000-0xfec01fff]
[    0.333086] acpi PNP0C02:02: Reserved [mem 0xfedc0000-0xfedc0fff]
[    0.333087] acpi PNP0C02:02: Reserved [mem 0xfee00000-0xfee00fff]
[    0.333089] acpi PNP0C02:02: Could not reserve [mem 0xfed80000-0xfed8ffff]
[    0.333090] acpi PNP0C02:02: Reserved [mem 0xfec10000-0xfec10fff]
[    0.333091] acpi PNP0C02:02: Reserved [mem 0xff000000-0xffffffff]
[    0.333121] pnp: PnP ACPI init
[    0.336037] pnp 00:00: [dma 0 disabled]
[    0.337258] pnp: PnP ACPI: found 1 devices
[    0.343170] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.343262] NET: Registered PF_INET protocol family
[    0.343379] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.345712] tcp_listen_portaddr_hash hash table entries: 16384 (order: 6, 262144 bytes, linear)
[    0.345732] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.345813] TCP established hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.345998] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes, linear)
[    0.346053] TCP: Hash tables configured (established 262144 bind 65536)
[    0.346136] MPTCP token hash table entries: 32768 (order: 8, 786432 bytes, linear)
[    0.346202] UDP hash table entries: 16384 (order: 8, 1048576 bytes, linear)
[    0.346277] UDP-Lite hash table entries: 16384 (order: 8, 1048576 bytes, linear)
[    0.346351] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.346356] NET: Registered PF_XDP protocol family
[    0.346361] pci 0000:00:02.3: bridge window [io  0x1000-0x0fff] to [bus 03] add_size 1000
[    0.346364] pci 0000:00:02.3: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 03] add_size 200000 add_align 100000
[    0.346366] pci 0000:00:02.3: bridge window [mem 0x00100000-0x000fffff] to [bus 03] add_size 200000 add_align 100000
[    0.346373] pci 0000:00:02.3: bridge window [mem 0xfa000000-0xfa1fffff]: assigned
[    0.346376] pci 0000:00:02.3: bridge window [mem 0x660000000-0x6601fffff 64bit pref]: assigned
[    0.346378] pci 0000:00:02.3: bridge window [io  0x1000-0x1fff]: assigned
[    0.346380] pci 0000:00:02.1: PCI bridge to [bus 01]
[    0.346387] pci 0000:00:02.1:   bridge window [io  0xf000-0xffff]
[    0.346391] pci 0000:00:02.1:   bridge window [mem 0xdcb00000-0xdcbfffff]
[    0.346416] pci 0000:00:02.2: PCI bridge to [bus 02]
[    0.346420] pci 0000:00:02.2:   bridge window [mem 0xdca00000-0xdcafffff]
[    0.346444] pci 0000:00:02.3: PCI bridge to [bus 03]
[    0.346446] pci 0000:00:02.3:   bridge window [io  0x1000-0x1fff]
[    0.346449] pci 0000:00:02.3:   bridge window [mem 0xfa000000-0xfa1fffff]
[    0.346452] pci 0000:00:02.3:   bridge window [mem 0x660000000-0x6601fffff 64bit pref]
[    0.346476] pci 0000:00:02.4: PCI bridge to [bus 04]
[    0.346479] pci 0000:00:02.4:   bridge window [mem 0xdc900000-0xdc9fffff]
[    0.346503] pci 0000:00:03.1: PCI bridge to [bus 05-64]
[    0.346505] pci 0000:00:03.1:   bridge window [io  0xa000-0xdfff]
[    0.346514] pci 0000:00:03.1:   bridge window [mem 0xc4000000-0xdbffffff]
[    0.346527] pci 0000:00:03.1:   bridge window [mem 0x6c00000000-0x7bffffffff 64bit pref]
[    0.346555] pci 0000:00:08.1: PCI bridge to [bus 65]
[    0.346557] pci 0000:00:08.1:   bridge window [io  0xe000-0xefff]
[    0.346563] pci 0000:00:08.1:   bridge window [mem 0xdc000000-0xdc5fffff]
[    0.346565] pci 0000:00:08.1:   bridge window [mem 0x7c00000000-0x7c107fffff 64bit pref]
[    0.346568] pci 0000:00:08.2: PCI bridge to [bus 66]
[    0.346575] pci 0000:00:08.3: PCI bridge to [bus 67]
[    0.346577] pci 0000:00:08.3:   bridge window [mem 0xdc600000-0xdc8fffff]
[    0.346582] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    0.346583] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
[    0.346585] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
[    0.346586] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    0.346587] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000dffff window]
[    0.346588] pci_bus 0000:00: resource 9 [mem 0xfa000000-0xfcffffff window]
[    0.346589] pci_bus 0000:00: resource 10 [mem 0xf0000000-0xf9ffffff window]
[    0.346591] pci_bus 0000:00: resource 11 [mem 0xa0000000-0xdfffffff window]
[    0.346592] pci_bus 0000:00: resource 12 [mem 0x660000000-0x7fffffffff window]
[    0.346593] pci_bus 0000:01: resource 0 [io  0xf000-0xffff]
[    0.346595] pci_bus 0000:01: resource 1 [mem 0xdcb00000-0xdcbfffff]
[    0.346596] pci_bus 0000:02: resource 1 [mem 0xdca00000-0xdcafffff]
[    0.346597] pci_bus 0000:03: resource 0 [io  0x1000-0x1fff]
[    0.346598] pci_bus 0000:03: resource 1 [mem 0xfa000000-0xfa1fffff]
[    0.346599] pci_bus 0000:03: resource 2 [mem 0x660000000-0x6601fffff 64bit pref]
[    0.346601] pci_bus 0000:04: resource 1 [mem 0xdc900000-0xdc9fffff]
[    0.346602] pci_bus 0000:05: resource 0 [io  0xa000-0xdfff]
[    0.346603] pci_bus 0000:05: resource 1 [mem 0xc4000000-0xdbffffff]
[    0.346604] pci_bus 0000:05: resource 2 [mem 0x6c00000000-0x7bffffffff 64bit pref]
[    0.346606] pci_bus 0000:65: resource 0 [io  0xe000-0xefff]
[    0.346607] pci_bus 0000:65: resource 1 [mem 0xdc000000-0xdc5fffff]
[    0.346608] pci_bus 0000:65: resource 2 [mem 0x7c00000000-0x7c107fffff 64bit pref]
[    0.346609] pci_bus 0000:67: resource 1 [mem 0xdc600000-0xdc8fffff]
[    0.346972] pci 0000:65:00.1: D0 power state depends on 0000:65:00.0
[    0.347316] PCI: CLS 64 bytes, default 64
[    0.347334] pci 0000:00:00.2: AMD-Vi: IOMMU performance counters supported
[    0.347376] Unpacking initramfs...
[    0.347379] pci 0000:00:01.0: Adding to iommu group 0
[    0.347427] pci 0000:00:02.0: Adding to iommu group 1
[    0.347444] pci 0000:00:02.1: Adding to iommu group 2
[    0.347458] pci 0000:00:02.2: Adding to iommu group 3
[    0.347471] pci 0000:00:02.3: Adding to iommu group 4
[    0.347484] pci 0000:00:02.4: Adding to iommu group 5
[    0.347506] pci 0000:00:03.0: Adding to iommu group 6
[    0.347516] pci 0000:00:03.1: Adding to iommu group 6
[    0.347533] pci 0000:00:04.0: Adding to iommu group 7
[    0.347569] pci 0000:00:08.0: Adding to iommu group 8
[    0.347581] pci 0000:00:08.1: Adding to iommu group 9
[    0.347596] pci 0000:00:08.2: Adding to iommu group 10
[    0.347608] pci 0000:00:08.3: Adding to iommu group 11
[    0.347629] pci 0000:00:14.0: Adding to iommu group 12
[    0.347640] pci 0000:00:14.3: Adding to iommu group 12
[    0.347691] pci 0000:00:18.0: Adding to iommu group 13
[    0.347703] pci 0000:00:18.1: Adding to iommu group 13
[    0.347715] pci 0000:00:18.2: Adding to iommu group 13
[    0.347727] pci 0000:00:18.3: Adding to iommu group 13
[    0.347738] pci 0000:00:18.4: Adding to iommu group 13
[    0.347750] pci 0000:00:18.5: Adding to iommu group 13
[    0.347762] pci 0000:00:18.6: Adding to iommu group 13
[    0.347775] pci 0000:00:18.7: Adding to iommu group 13
[    0.347791] pci 0000:01:00.0: Adding to iommu group 14
[    0.347803] pci 0000:02:00.0: Adding to iommu group 15
[    0.347815] pci 0000:04:00.0: Adding to iommu group 16
[    0.347847] pci 0000:65:00.0: Adding to iommu group 17
[    0.347859] pci 0000:65:00.1: Adding to iommu group 18
[    0.347872] pci 0000:65:00.2: Adding to iommu group 19
[    0.347886] pci 0000:65:00.3: Adding to iommu group 20
[    0.347900] pci 0000:65:00.4: Adding to iommu group 21
[    0.347915] pci 0000:65:00.5: Adding to iommu group 22
[    0.347929] pci 0000:65:00.6: Adding to iommu group 23
[    0.347942] pci 0000:66:00.0: Adding to iommu group 24
[    0.347955] pci 0000:67:00.0: Adding to iommu group 25
[    0.347968] pci 0000:67:00.3: Adding to iommu group 26
[    0.347981] pci 0000:67:00.4: Adding to iommu group 27
[    0.347995] pci 0000:67:00.5: Adding to iommu group 28
[    0.349927] AMD-Vi: Extended features (0x246577efa2054ada, 0x0): PPR NX GT IA GA PC
[    0.349936] AMD-Vi: Interrupt remapping enabled
[    0.350059] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.350061] software IO TLB: mapped [mem 0x000000007e289000-0x0000000082289000] (64MB)
[    0.350115] LVT offset 0 assigned for vector 0x400
[    0.350231] perf: AMD IBS detected (0x00000bff)
[    0.350235] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 counters/bank).
[    0.360983] Initialise system trusted keyrings
[    0.360995] Key type blacklist registered
[    0.361046] workingset: timestamp_bits=36 (anon: 32) max_order=23 bucket_order=0 (anon: 0)
[    0.361299] fuse: init (API version 7.45)
[    0.361364] integrity: Platform Keyring initialized
[    0.361366] integrity: Machine keyring initialized
[    0.368039] Key type asymmetric registered
[    0.368040] Asymmetric key parser 'x509' registered
[    0.368058] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 245)
[    0.368103] io scheduler mq-deadline registered
[    0.368105] io scheduler kyber registered
[    0.368115] io scheduler bfq registered
[    0.369696] ledtrig-cpu: registered to indicate activity on CPUs
[    0.369803] pcieport 0000:00:02.1: PME: Signaling with IRQ 42
[    0.369931] pcieport 0000:00:02.2: PME: Signaling with IRQ 43
[    0.370053] pcieport 0000:00:02.3: PME: Signaling with IRQ 44
[    0.370071] pcieport 0000:00:02.3: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.370235] pcieport 0000:00:02.4: PME: Signaling with IRQ 45
[    0.370420] pcieport 0000:00:03.1: PME: Signaling with IRQ 46
[    0.370535] pcieport 0000:00:03.1: AER: enabled with IRQ 46
[    0.370557] pcieport 0000:00:03.1: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.370937] pcieport 0000:00:08.1: PME: Signaling with IRQ 47
[    0.371105] pcieport 0000:00:08.2: PME: Signaling with IRQ 48
[    0.371211] pcieport 0000:00:08.3: PME: Signaling with IRQ 49
[    0.371434] input: Power Button as /devices/platform/PNP0C0C:00/input/input0
[    0.371456] ACPI: button: Power Button [PWRB]
[    0.371484] Monitor-Mwait will be used to enter C-1 state
[    0.374005] Estimated ratio of average max frequency by base frequency (times 1024): 1181
[    0.374173] acpi LNXTHERM:00: registered as thermal_zone0
[    0.374175] ACPI: thermal: Thermal Zone [TZ01] (20 C)
[    0.374329] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.374566] 00:00: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    0.378742] Non-volatile memory driver v1.3
[    0.378744] Linux agpgart interface v0.103
[    0.383685] Freeing initrd memory: 43868K
[    0.410500] xhci_hcd 0000:65:00.3: xHCI Host Controller
[    0.410506] xhci_hcd 0000:65:00.3: new USB bus registered, assigned bus number 1
[    0.410953] xhci_hcd 0000:65:00.3: hcc params 0x0128ffc5 hci version 0x120 quirks 0x0000000200000010
[    0.411190] xhci_hcd 0000:65:00.3: xHCI Host Controller
[    0.411192] xhci_hcd 0000:65:00.3: new USB bus registered, assigned bus number 2
[    0.411194] xhci_hcd 0000:65:00.3: Host supports USB 3.1 Enhanced SuperSpeed
[    0.411227] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 7.00
[    0.411229] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.411231] usb usb1: Product: xHCI Host Controller
[    0.411232] usb usb1: Manufacturer: Linux 7.0.0-rc2-debug-next-20260303-03431-gc025f6cf4209-dirty xhci-hcd
[    0.411233] usb usb1: SerialNumber: 0000:65:00.3
[    0.411331] hub 1-0:1.0: USB hub found
[    0.411343] hub 1-0:1.0: 5 ports detected
[    0.414847] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[    0.414863] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 7.00
[    0.414864] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.414865] usb usb2: Product: xHCI Host Controller
[    0.414867] usb usb2: Manufacturer: Linux 7.0.0-rc2-debug-next-20260303-03431-gc025f6cf4209-dirty xhci-hcd
[    0.414868] usb usb2: SerialNumber: 0000:65:00.3
[    0.414939] hub 2-0:1.0: USB hub found
[    0.414948] hub 2-0:1.0: 2 ports detected
[    0.416490] xhci_hcd 0000:65:00.4: xHCI Host Controller
[    0.416494] xhci_hcd 0000:65:00.4: new USB bus registered, assigned bus number 3
[    0.416928] xhci_hcd 0000:65:00.4: hcc params 0x0110ffc5 hci version 0x120 quirks 0x0000000200000010
[    0.417118] xhci_hcd 0000:65:00.4: xHCI Host Controller
[    0.417120] xhci_hcd 0000:65:00.4: new USB bus registered, assigned bus number 4
[    0.417122] xhci_hcd 0000:65:00.4: Host supports USB 3.1 Enhanced SuperSpeed
[    0.417147] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 7.00
[    0.417149] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.417150] usb usb3: Product: xHCI Host Controller
[    0.417151] usb usb3: Manufacturer: Linux 7.0.0-rc2-debug-next-20260303-03431-gc025f6cf4209-dirty xhci-hcd
[    0.417152] usb usb3: SerialNumber: 0000:65:00.4
[    0.417224] hub 3-0:1.0: USB hub found
[    0.417233] hub 3-0:1.0: 1 port detected
[    0.417982] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
[    0.417998] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 7.00
[    0.418000] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.418001] usb usb4: Product: xHCI Host Controller
[    0.418002] usb usb4: Manufacturer: Linux 7.0.0-rc2-debug-next-20260303-03431-gc025f6cf4209-dirty xhci-hcd
[    0.418003] usb usb4: SerialNumber: 0000:65:00.4
[    0.418069] hub 4-0:1.0: USB hub found
[    0.418078] hub 4-0:1.0: 1 port detected
[    0.418918] xhci_hcd 0000:67:00.3: xHCI Host Controller
[    0.418921] xhci_hcd 0000:67:00.3: new USB bus registered, assigned bus number 5
[    0.419285] xhci_hcd 0000:67:00.3: hcc params 0x0110ffc5 hci version 0x120 quirks 0x0000000200000010
[    0.419623] xhci_hcd 0000:67:00.3: xHCI Host Controller
[    0.419625] xhci_hcd 0000:67:00.3: new USB bus registered, assigned bus number 6
[    0.419627] xhci_hcd 0000:67:00.3: Host supports USB 3.1 Enhanced SuperSpeed
[    0.419655] usb usb5: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 7.00
[    0.419656] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.419657] usb usb5: Product: xHCI Host Controller
[    0.419659] usb usb5: Manufacturer: Linux 7.0.0-rc2-debug-next-20260303-03431-gc025f6cf4209-dirty xhci-hcd
[    0.419660] usb usb5: SerialNumber: 0000:67:00.3
[    0.419728] hub 5-0:1.0: USB hub found
[    0.419737] hub 5-0:1.0: 1 port detected
[    0.420470] usb usb6: We don't know the algorithms for LPM for this host, disabling LPM.
[    0.420486] usb usb6: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 7.00
[    0.420487] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.420488] usb usb6: Product: xHCI Host Controller
[    0.420489] usb usb6: Manufacturer: Linux 7.0.0-rc2-debug-next-20260303-03431-gc025f6cf4209-dirty xhci-hcd
[    0.420490] usb usb6: SerialNumber: 0000:67:00.3
[    0.420556] hub 6-0:1.0: USB hub found
[    0.420561] hub 6-0:1.0: 1 port detected
[    0.421600] xhci_hcd 0000:67:00.4: xHCI Host Controller
[    0.421603] xhci_hcd 0000:67:00.4: new USB bus registered, assigned bus number 7
[    0.421940] xhci_hcd 0000:67:00.4: hcc params 0x0110ffc5 hci version 0x120 quirks 0x0000000200000010
[    0.422248] xhci_hcd 0000:67:00.4: xHCI Host Controller
[    0.422250] xhci_hcd 0000:67:00.4: new USB bus registered, assigned bus number 8
[    0.422252] xhci_hcd 0000:67:00.4: Host supports USB 3.1 Enhanced SuperSpeed
[    0.422278] usb usb7: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 7.00
[    0.422279] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.422281] usb usb7: Product: xHCI Host Controller
[    0.422282] usb usb7: Manufacturer: Linux 7.0.0-rc2-debug-next-20260303-03431-gc025f6cf4209-dirty xhci-hcd
[    0.422283] usb usb7: SerialNumber: 0000:67:00.4
[    0.422355] hub 7-0:1.0: USB hub found
[    0.422365] hub 7-0:1.0: 1 port detected
[    0.423111] usb usb8: We don't know the algorithms for LPM for this host, disabling LPM.
[    0.423127] usb usb8: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 7.00
[    0.423128] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.423129] usb usb8: Product: xHCI Host Controller
[    0.423130] usb usb8: Manufacturer: Linux 7.0.0-rc2-debug-next-20260303-03431-gc025f6cf4209-dirty xhci-hcd
[    0.423131] usb usb8: SerialNumber: 0000:67:00.4
[    0.423196] hub 8-0:1.0: USB hub found
[    0.423205] hub 8-0:1.0: 1 port detected
[    0.424229] usbcore: registered new interface driver usbserial_generic
[    0.424234] usbserial: USB Serial support registered for generic
[    0.424250] i8042: PNP: No PS/2 controller found.
[    0.424251] i8042: Probing ports directly.
[    0.425203] i8042: No controller found
[    0.425273] rtc_cmos PNP0B00:00: RTC can wake from S4
[    0.425497] rtc_cmos PNP0B00:00: registered as rtc0
[    0.425533] rtc_cmos PNP0B00:00: setting system clock to 2026-03-03T21:14:38 UTC (1772572478)
[    0.425557] rtc_cmos PNP0B00:00: alarms up to one month, y3k, 114 bytes nvram
[    0.426543] hid: raw HID events driver (C) Jiri Kosina
[    0.426560] usbcore: registered new interface driver usbhid
[    0.426561] usbhid: USB HID core driver
[    0.426604] drop_monitor: Initializing network drop monitor service
[    0.426693] NET: Registered PF_INET6 protocol family
[    0.426865] Segment Routing with IPv6
[    0.426866] RPL Segment Routing with IPv6
[    0.426873] In-situ OAM (IOAM) with IPv6
[    0.426887] NET: Registered PF_PACKET protocol family
[    0.428290] x86/amd: Previous system reset reason [0x00080800]: software wrote 0x6 to reset control register 0xCF9
[    0.428298] microcode: Current revision: 0x0a705208
[    0.428299] microcode: Updated early from: 0x0a705206
[    0.428639] resctrl: L3 allocation detected
[    0.428641] resctrl: MB allocation detected
[    0.428642] resctrl: SMBA allocation detected
[    0.428643] resctrl: L3 monitoring detected
[    0.428666] IPI shorthand broadcast: enabled
[    0.431959] sched_clock: Marking stable (430446574, 1373028)->(448713901, -16894299)
[    0.432276] registered taskstats version 1
[    0.433012] Loading compiled-in X.509 certificates
[    0.439524] Loaded X.509 cert 'Build time autogenerated kernel key: 2b5620a8e19e596f5e8187c1c6f93ddd959d4ef7'
[    0.442861] Demotion targets for Node 0: null
[    0.442987] Key type .fscrypt registered
[    0.442988] Key type fscrypt-provisioning registered
[    0.443240] Btrfs loaded, zoned=yes, fsverity=yes
[    0.443265] Key type big_key registered
[    0.443339] integrity: Loading X.509 certificate: UEFI:db
[    0.443354] integrity: Loaded X.509 cert 'Microsoft Corporation: Windows UEFI CA 2023: aefc5fbbbe055d8f8daa585473499417ab5a5272'
[    0.443355] integrity: Loading X.509 certificate: UEFI:db
[    0.443365] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    0.443366] integrity: Loading X.509 certificate: UEFI:db
[    0.443374] integrity: Loaded X.509 cert 'Microsoft Windows Production PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    0.444298] PM:   Magic number: 2:602:246
[    0.444373] memory memory120: hash matches
[    0.444474] RAS: Correctable Errors collector initialized.
[    0.445523] clk: Disabling unused clocks
[    0.445525] PM: genpd: Disabling unused power domains
[    0.446188] Freeing unused decrypted memory: 2028K
[    0.446651] Freeing unused kernel image (initmem) memory: 4664K
[    0.446661] Write protecting the kernel read-only data: 36864k
[    0.446908] Freeing unused kernel image (text/rodata gap) memory: 816K
[    0.447014] Freeing unused kernel image (rodata/data gap) memory: 984K
[    0.478238] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    0.478242] rodata_test: all tests were successful
[    0.478246] Run /init as init process
[    0.478247]   with arguments:
[    0.478248]     /init
[    0.478248]   with environment:
[    0.478249]     HOME=/
[    0.478250]     TERM=linux
[    0.649949] usb 1-3: new high-speed USB device number 2 using xhci_hcd
[    0.677747] ACPI: video: Video Device [VGA] (multi-head: yes  rom: no  post: no)
[    0.678152] input: Video Bus as /devices/pci0000:00/0000:00:08.1/LNXVIDEO:00/input/input1
[    0.682764] Key type psk registered
[    0.700103] nvme 0000:04:00.0: platform quirk: setting simple suspend
[    0.700168] nvme nvme0: pci function 0000:04:00.0
[    0.700388] ACPI: bus type drm_connector registered
[    0.700399] Unsupported value for CONFIG_DRM_PANIC_SCREEN ('qr_code'), falling back to 'user'...
[    0.723917] nvme nvme0: allocated 64 MiB host memory buffer (1 segment).
[    0.757699] nvme nvme0: 16/0/0 default/read/poll queues
[    0.760275]  nvme0n1: p1 p2
[    0.778267] usb 1-3: New USB device found, idVendor=38eb, idProduct=0002, bcdDevice= 1.00
[    0.778273] usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    0.778276] usb 1-3: Product: Glinet Composite Device
[    0.778280] usb 1-3: Manufacturer: Glinet
[    0.778282] usb 1-3: SerialNumber: CAFEBABE
[    0.788161] input: Glinet Glinet Composite Device as /devices/pci0000:00/0000:00:08.1/0000:65:00.3/usb1/1-3/1-3:1.0/0003:38EB:0002.0001/input/input2
[    0.869673] hid-generic 0003:38EB:0002.0001: input,hidraw0: USB HID v1.01 Keyboard [Glinet Glinet Composite Device] on usb-0000:65:00.3-3/input0
[    0.873451] input: Glinet Glinet Composite Device as /devices/pci0000:00/0000:00:08.1/0000:65:00.3/usb1/1-3/1-3:1.1/0003:38EB:0002.0002/input/input3
[    0.873542] hid-generic 0003:38EB:0002.0002: input,hidraw1: USB HID v1.01 Mouse [Glinet Glinet Composite Device] on usb-0000:65:00.3-3/input1
[    0.876918] input: Glinet Glinet Composite Device as /devices/pci0000:00/0000:00:08.1/0000:65:00.3/usb1/1-3/1-3:1.2/0003:38EB:0002.0003/input/input4
[    0.877004] hid-generic 0003:38EB:0002.0003: input,hidraw2: USB HID v1.01 Mouse [Glinet Glinet Composite Device] on usb-0000:65:00.3-3/input2
[    0.991133] usb 1-5: new full-speed USB device number 3 using xhci_hcd
[    1.144181] usb 1-5: New USB device found, idVendor=8087, idProduct=0029, bcdDevice= 0.01
[    1.144189] usb 1-5: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    1.368423] tsc: Refined TSC clocksource calibration: 3792.901 MHz
[    1.368437] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x6d584d31f5c, max_idle_ns: 881590888443 ns
[    1.368618] clocksource: Switched to clocksource tsc
[    2.306382] usb-storage 1-3:1.3: USB Mass Storage device detected
[    2.306512] scsi host0: usb-storage 1-3:1.3
[    2.306599] usb-storage 1-3:1.4: USB Mass Storage device detected
[    2.306679] scsi host1: usb-storage 1-3:1.4
[    2.306736] usbcore: registered new interface driver usb-storage
[    2.309157] usbcore: registered new interface driver uas
[    2.321408] amdgpu: Virtual CRAT table created for CPU
[    2.321423] amdgpu: Topology: Add CPU node
[    2.321555] amdgpu 0000:65:00.0: enabling device (0006 -> 0007)
[    2.321601] amdgpu 0000:65:00.0: initializing kernel modesetting (IP DISCOVERY 0x1002:0x1900 0x1F66:0x0031 0xB3).
[    2.321611] amdgpu 0000:65:00.0: register mmio base: 0xDC500000
[    2.321612] amdgpu 0000:65:00.0: register mmio size: 524288
[    2.325084] amdgpu 0000:65:00.0: detected ip block number 0 <common_v1_0_0> (soc21_common)
[    2.325087] amdgpu 0000:65:00.0: detected ip block number 1 <gmc_v11_0_0> (gmc_v11_0)
[    2.325089] amdgpu 0000:65:00.0: detected ip block number 2 <ih_v6_0_0> (ih_v6_0)
[    2.325091] amdgpu 0000:65:00.0: detected ip block number 3 <psp_v13_0_4> (psp)
[    2.325093] amdgpu 0000:65:00.0: detected ip block number 4 <smu_v13_0_0> (smu)
[    2.325095] amdgpu 0000:65:00.0: detected ip block number 5 <dce_v1_0_0> (dm)
[    2.325096] amdgpu 0000:65:00.0: detected ip block number 6 <gfx_v11_0_0> (gfx_v11_0)
[    2.325098] amdgpu 0000:65:00.0: detected ip block number 7 <sdma_v6_0_0> (sdma_v6_0)
[    2.325100] amdgpu 0000:65:00.0: detected ip block number 8 <vcn_v4_0_0> (vcn_v4_0)
[    2.325102] amdgpu 0000:65:00.0: detected ip block number 9 <jpeg_v4_0_0> (jpeg_v4_0)
[    2.325103] amdgpu 0000:65:00.0: detected ip block number 10 <mes_v11_0_0> (mes_v11_0)
[    2.325123] amdgpu 0000:65:00.0: Fetched VBIOS from VFCT
[    2.325127] amdgpu 0000:65:00.0: [drm] ATOM BIOS: 113-PHXGENERIC-001, build: 00077464, ver: 022.012.000.027.000001, 2023/09/15
[    2.328542] amdgpu 0000:65:00.0: vgaarb: deactivate vga console
[    2.328547] amdgpu 0000:65:00.0: Trusted Memory Zone (TMZ) feature enabled
[    2.328605] amdgpu 0000:65:00.0: vm size is 262144 GB, 4 levels, block size is 9-bit, fragment size is 9-bit
[    2.328627] amdgpu 0000:65:00.0: VRAM: 4096M 0x0000008000000000 - 0x00000080FFFFFFFF (4096M used)
[    2.328630] amdgpu 0000:65:00.0: GART: 512M 0x00007FFF00000000 - 0x00007FFF1FFFFFFF
[    2.328644] amdgpu 0000:65:00.0: [drm] Detected VRAM RAM=4096M, BAR=4096M
[    2.328645] amdgpu 0000:65:00.0: [drm] RAM width 128bits DDR5
[    2.328814] amdgpu 0000:65:00.0:  4096M of VRAM memory ready
[    2.328816] amdgpu 0000:65:00.0:  9888M of GTT memory ready.
[    2.328837] amdgpu 0000:65:00.0: [drm] GART: num cpu pages 131072, num gpu pages 131072
[    2.329249] amdgpu 0000:65:00.0: [drm] PCIE GART of 512M enabled (table at 0x0000008000F00000).
[    2.329688] amdgpu 0000:65:00.0: [drm] Loading DMUB firmware via PSP: version=0x08005700
[    2.330013] amdgpu 0000:65:00.0: [VCN instance 0] Found VCN firmware Version ENC: 1.24 DEC: 9 VEP: 0 Revision: 27
[    2.330094] amdgpu 0000:65:00.0: MES: vmid_mask_mmhub 0x0000ff00, vmid_mask_gfxhub 0x0000ff00
[    2.330096] amdgpu 0000:65:00.0: MES: gfx_hqd_mask 0x00000002, compute_hqd_mask 0x0000000c, sdma_hqd_mask 0x000000fc
[    2.355362] amdgpu 0000:65:00.0: reserve 0x4000000 from 0x80f8000000 for PSP TMR
[    2.914423] amdgpu 0000:65:00.0: RAS: optional ras ta ucode is not available
[    2.922569] amdgpu 0000:65:00.0: RAP: optional rap ta ucode is not available
[    2.922573] amdgpu 0000:65:00.0: SECUREDISPLAY: optional securedisplay ta ucode is not available
[    2.952995] amdgpu 0000:65:00.0: SMU is initialized successfully!
[    2.953887] amdgpu 0000:65:00.0: [drm] Display Core v3.2.372 initialized on DCN 3.1.4
[    2.953891] amdgpu 0000:65:00.0: [drm] DP-HDMI FRL PCON supported
[    2.956177] amdgpu 0000:65:00.0: [drm] DMUB hardware initialized: version=0x08005700
[    2.959611] amdgpu 0000:65:00.0: [drm] DP-1: PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[    2.987038] amdgpu 0000:65:00.0: [drm] HDMI-A-1: PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[    2.987091] amdgpu 0000:65:00.0: [drm] DP-2: PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[    2.987137] amdgpu 0000:65:00.0: [drm] DP-3: PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[    2.987183] amdgpu 0000:65:00.0: [drm] DP-4: PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[    2.987216] amdgpu 0000:65:00.0: [drm] DP-5: PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[    2.987251] amdgpu 0000:65:00.0: [drm] DP-6: PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[    2.995326] kfd kfd: Allocated 3969056 bytes on gart
[    2.995342] kfd kfd: Total number of KFD nodes to be created: 1
[    2.995531] amdgpu: Virtual CRAT table created for GPU
[    2.995679] amdgpu: Topology: Add GPU node [0x1002:0x1900]
[    2.995681] kfd kfd: added device 1002:1900
[    2.995692] amdgpu 0000:65:00.0: SE 1, SH per SE 2, CU per SH 6, active_cu_number 12
[    2.995698] amdgpu 0000:65:00.0: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
[    2.995700] amdgpu 0000:65:00.0: ring comp_1.0.0 uses VM inv eng 1 on hub 0
[    2.995701] amdgpu 0000:65:00.0: ring comp_1.1.0 uses VM inv eng 4 on hub 0
[    2.995703] amdgpu 0000:65:00.0: ring comp_1.2.0 uses VM inv eng 6 on hub 0
[    2.995704] amdgpu 0000:65:00.0: ring comp_1.3.0 uses VM inv eng 7 on hub 0
[    2.995705] amdgpu 0000:65:00.0: ring comp_1.0.1 uses VM inv eng 8 on hub 0
[    2.995707] amdgpu 0000:65:00.0: ring comp_1.1.1 uses VM inv eng 9 on hub 0
[    2.995708] amdgpu 0000:65:00.0: ring comp_1.2.1 uses VM inv eng 10 on hub 0
[    2.995709] amdgpu 0000:65:00.0: ring comp_1.3.1 uses VM inv eng 11 on hub 0
[    2.995710] amdgpu 0000:65:00.0: ring sdma0 uses VM inv eng 12 on hub 0
[    2.995712] amdgpu 0000:65:00.0: ring vcn_unified_0 uses VM inv eng 0 on hub 8
[    2.995713] amdgpu 0000:65:00.0: ring jpeg_dec uses VM inv eng 1 on hub 8
[    2.995714] amdgpu 0000:65:00.0: ring mes_kiq_3.1.0 uses VM inv eng 13 on hub 0
[    2.996874] amdgpu 0000:65:00.0: Runtime PM not available
[    2.997815] amdgpu 0000:65:00.0: [drm] Registered 4 planes with drm panic
[    3.004461] [drm] Initialized amdgpu 3.64.0 for 0000:65:00.0 on minor 0
[    3.007198] amdgpu 0000:65:00.0: [drm] Failed to setup vendor infoframe on connector HDMI-A-1: -22
[    3.011429] fbcon: amdgpudrmfb (fb0) is primary device
[    3.011756] [drm] pre_validate_dsc:1667 MST_DSC dsc precompute is not needed
[    3.273964] amdgpu 0000:65:00.0: [drm] REG_WAIT timeout 1us * 100000 tries - optc314_disable_crtc line:145
[    3.351081] Console: switching to colour frame buffer device 160x45
[    3.353950] scsi 1:0:0:0: Direct-Access     Glinet   Flash Drive      1.00 PQ: 0 ANSI: 2
[    3.354586] scsi 0:0:0:0: CD-ROM            Glinet   Flash Drive      1.00 PQ: 0 ANSI: 2
[    3.354853] sd 1:0:0:0: Power-on or device reset occurred
[    3.355187] sd 1:0:0:0: [sda] Media removed, stopped polling
[    3.362552] sd 1:0:0:0: [sda] Attached SCSI removable disk
[    3.366359] sr 0:0:0:0: Power-on or device reset occurred
[    3.367281] sr 0:0:0:0: [sr0] scsi-1 drive
[    3.367282] cdrom: Uniform CD-ROM driver Revision: 3.20
[    3.369398] amdgpu 0000:65:00.0: [drm] fb0: amdgpudrmfb frame buffer device
[    3.385498] sr 0:0:0:0: Attached scsi CD-ROM sr0
[    3.480762] BTRFS: device fsid 204f00b6-441d-4dc1-8bf1-c27bbfe077b2 devid 1 transid 582524 /dev/nvme0n1p2 (259:2) scanned by mount (362)
[    3.481134] BTRFS info (device nvme0n1p2): first mount of filesystem 204f00b6-441d-4dc1-8bf1-c27bbfe077b2
[    3.481138] BTRFS info (device nvme0n1p2): using crc32c checksum algorithm
[    3.525112] BTRFS info (device nvme0n1p2): enabling ssd optimizations
[    3.525117] BTRFS info (device nvme0n1p2): turning on async discard
[    3.525120] BTRFS info (device nvme0n1p2): enabling free space tree
[    3.619386] systemd[1]: systemd 259.2-1-arch running in system mode (+PAM +AUDIT -SELINUX +APPARMOR -IMA +IPE +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +KMOD +LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +BTF +XKBCOMMON +UTMP -SYSVINIT +LIBARCHIVE)
[    3.619394] systemd[1]: Detected architecture x86-64.
[    3.620550] systemd[1]: Hostname set to <beelink-amd-ryzen-8745HS>.
[    3.690769] systemd[1]: bpf-restrict-fs: LSM BPF program attached
[    3.854615] zram: Added device: zram0
[    3.909139] systemd[1]: Queued start job for default target Graphical Interface.
[    3.922242] systemd[1]: Created slice Virtual Machine and Container Slice.
[    3.922948] systemd[1]: Created slice Slice /system/dirmngr.
[    3.923202] systemd[1]: Created slice Slice /system/getty.
[    3.923462] systemd[1]: Created slice Slice /system/gpg-agent.
[    3.923713] systemd[1]: Created slice Slice /system/gpg-agent-browser.
[    3.923972] systemd[1]: Created slice Slice /system/gpg-agent-extra.
[    3.924222] systemd[1]: Created slice Slice /system/gpg-agent-ssh.
[    3.924487] systemd[1]: Created slice Slice /system/keyboxd.
[    3.924745] systemd[1]: Created slice Slice /system/modprobe.
[    3.924991] systemd[1]: Created slice Slice /system/systemd-zram-setup.
[    3.925302] systemd[1]: Created slice User and Session Slice.
[    3.925384] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[    3.925450] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[    3.925617] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[    3.925675] systemd[1]: Expecting device /dev/disk/by-uuid/1AD9-58CA...
[    3.925715] systemd[1]: Expecting device /dev/disk/by-uuid/204f00b6-441d-4dc1-8bf1-c27bbfe077b2...
[    3.925758] systemd[1]: Expecting device /dev/zram0...
[    3.925792] systemd[1]: Reached target Local Encrypted Volumes.
[    3.925829] systemd[1]: Reached target Login Prompts.
[    3.925860] systemd[1]: Reached target Image Downloads.
[    3.925893] systemd[1]: Reached target Local Integrity Protected Volumes.
[    3.925938] systemd[1]: Reached target Preparation for Network.
[    3.925975] systemd[1]: Reached target Path Units.
[    3.926009] systemd[1]: Reached target Remote File Systems.
[    3.926044] systemd[1]: Reached target Slice Units.
[    3.926085] systemd[1]: Reached target Local Verity Protected Volumes.
[    3.926167] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    3.926606] systemd[1]: Listening on Query the User Interactively for a Password.
[    3.927156] systemd[1]: Listening on Process Core Dump Socket.
[    3.927881] systemd[1]: Listening on Credential Encryption/Decryption.
[    3.928572] systemd[1]: Listening on Factory Reset Management.
[    3.928884] systemd[1]: Listening on Journal Socket (/dev/log).
[    3.929180] systemd[1]: Listening on Journal Sockets.
[    3.929829] systemd[1]: Listening on Console Output Muting Service Socket.
[    3.930216] systemd[1]: TPM PCR Measurements skipped, unmet condition check ConditionSecurity=measured-uki
[    3.930225] systemd[1]: Make TPM PCR Policy skipped, unmet condition check ConditionSecurity=measured-uki
[    3.930531] systemd[1]: Listening on Disk Repartitioning Service Socket.
[    3.930814] systemd[1]: Listening on udev Control Socket.
[    3.931076] systemd[1]: Listening on udev Kernel Socket.
[    3.931346] systemd[1]: Listening on udev Varlink Socket.
[    3.931615] systemd[1]: Listening on User Database Manager Socket.
[    3.933027] systemd[1]: Mounting Huge Pages File System...
[    3.934246] systemd[1]: Mounting POSIX Message Queue File System...
[    3.935134] systemd[1]: Mounting Kernel Debug File System...
[    3.936480] systemd[1]: Mounting Kernel Trace File System...
[    3.943934] systemd[1]: Starting Create List of Static Device Nodes...
[    3.944665] systemd[1]: Load Kernel Module configfs skipped, unmet condition check ConditionKernelModuleLoaded=!configfs
[    3.945296] systemd[1]: Mounting Kernel Configuration File System...
[    3.946278] systemd[1]: Starting Load Kernel Module dm_mod...
[    3.946638] systemd[1]: Load Kernel Module drm skipped, unmet condition check ConditionKernelModuleLoaded=!drm
[    3.946658] systemd[1]: Load Kernel Module fuse skipped, unmet condition check ConditionKernelModuleLoaded=!fuse
[    3.947232] systemd[1]: Mounting FUSE Control File System...
[    3.948129] systemd[1]: Starting Load Kernel Module loop...
[    3.949083] systemd[1]: Starting Load Kernel Module tun...
[    3.949556] systemd[1]: Clear Stale Hibernate Storage Info skipped, unmet condition check ConditionPathExists=/sys/firmware/efi/efivars/HibernateLocation-8cf2644b-4b0b-428f-9387-6d876050dc67
[    3.950788] systemd[1]: Starting Journal Service...
[    3.952103] systemd[1]: Starting Load Kernel Modules...
[    3.952613] systemd[1]: TPM PCR Machine ID Measurement skipped, unmet condition check ConditionSecurity=measured-uki
[    3.952638] systemd[1]: TPM NvPCR Product ID Measurement skipped, unmet condition check ConditionSecurity=measured-uki
[    3.953193] systemd[1]: Starting Remount Root and Kernel File Systems...
[    3.953604] systemd[1]: Early TPM SRK Setup skipped, unmet condition check ConditionSecurity=measured-uki
[    3.954133] systemd[1]: Starting Load udev Rules from Credentials...
[    3.954657] loop: module loaded
[    3.955071] systemd[1]: Starting Coldplug All udev Devices...
[    3.956555] tun: Universal TUN/TAP device driver, 1.6
[    3.956593] device-mapper: uevent: version 1.0.3
[    3.956656] device-mapper: ioctl: 4.50.0-ioctl (2025-04-28) initialised: dm-devel@lists.linux.dev
[    3.957339] systemd[1]: Mounted Huge Pages File System.
[    3.957905] systemd[1]: Mounted POSIX Message Queue File System.
[    3.958388] systemd[1]: Mounted Kernel Debug File System.
[    3.958770] systemd[1]: Mounted Kernel Trace File System.
[    3.959243] systemd[1]: Finished Create List of Static Device Nodes.
[    3.960407] Asymmetric key parser 'pkcs8' registered
[    3.973956] systemd[1]: Mounted Kernel Configuration File System.
[    3.974739] systemd[1]: modprobe@dm_mod.service: Deactivated successfully.
[    3.974898] systemd[1]: Finished Load Kernel Module dm_mod.
[    3.975245] systemd-journald[450]: Collecting audit messages is disabled.
[    3.975315] systemd[1]: Mounted FUSE Control File System.
[    3.975696] systemd[1]: modprobe@loop.service: Deactivated successfully.
[    3.975825] systemd[1]: Finished Load Kernel Module loop.
[    3.976349] systemd[1]: modprobe@tun.service: Deactivated successfully.
[    3.976470] systemd[1]: Finished Load Kernel Module tun.
[    3.976910] systemd[1]: Finished Load Kernel Modules.
[    3.977484] systemd[1]: Finished Load udev Rules from Credentials.
[    3.979061] systemd[1]: Starting Apply Kernel Variables...
[    3.979818] systemd[1]: Starting Create Static Device Nodes in /dev gracefully...
[    4.020183] BTRFS info (device nvme0n1p2 state M): use zstd compression, level 3
[    4.020946] systemd[1]: Finished Remount Root and Kernel File Systems.
[    4.022180] systemd[1]: Rebuild Hardware Database skipped, no trigger condition checks were met.
[    4.023061] systemd[1]: Starting Load/Save OS Random Seed...
[    4.023640] systemd[1]: TPM SRK Setup skipped, unmet condition check ConditionSecurity=measured-uki
[    4.023654] systemd[1]: TPM PCR NvPCR Initialization Separator skipped, unmet condition check ConditionSecurity=measured-uki
[    4.024002] systemd[1]: Finished Apply Kernel Variables.
[    4.041982] systemd[1]: Starting User Database Manager...
[    4.042810] systemd[1]: Started Journal Service.
[    4.243032] zram0: detected capacity change from 0 to 8388608
[    4.263927] ccp 0000:65:00.2: enabling device (0000 -> 0002)
[    4.265440] ccp 0000:65:00.2: tee enabled
[    4.268496] ccp 0000:65:00.2: psp enabled
[    4.276099] mousedev: PS/2 mouse device common for all mice
[    4.288554] Adding 4194300k swap on /dev/zram0.  Priority:100 extents:1 across:4194300k SSDsc
[    4.303153] Bluetooth: Core ver 2.22
[    4.303173] NET: Registered PF_BLUETOOTH protocol family
[    4.303175] Bluetooth: HCI device and connection manager initialized
[    4.303179] Bluetooth: HCI socket layer initialized
[    4.303181] Bluetooth: L2CAP socket layer initialized
[    4.303185] Bluetooth: SCO socket layer initialized
[    4.322900] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, revision 0
[    4.322904] piix4_smbus 0000:00:14.0: Using register 0x02 for SMBus port selection
[    4.322982] input: PC Speaker as /devices/platform/pcspkr/input/input5
[    4.322989] RAPL PMU: API unit is 2^-32 Joules, 2 fixed counters, 163840 ms ovfl timer
[    4.322992] RAPL PMU: hw unit of domain package 2^-16 Joules
[    4.322993] RAPL PMU: hw unit of domain core 2^-16 Joules
[    4.323206] ACPI: bus type thunderbolt registered
[    4.323443] i2c i2c-13: Successfully instantiated SPD at 0x50
[    4.323564] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    4.324055] i2c i2c-13: Successfully instantiated SPD at 0x51
[    4.324120] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Controller at 0xb20
[    4.326542] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    4.326658] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
[    4.327801] faux_driver regulatory: Direct firmware load for regulatory.db failed with error -2
[    4.327805] cfg80211: failed to load regulatory.db
[    4.328657] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver
[    4.329363] sp5100-tco sp5100-tco: Using 0xfeb00000 for watchdog MMIO address
[    4.329558] sp5100-tco sp5100-tco: initialized. heartbeat=60 sec (nowayout=0)
[    4.336350] r8169 0000:01:00.0 eth0: RTL8125B, 70:70:fc:07:68:03, XID 641, IRQ 97
[    4.336355] r8169 0000:01:00.0 eth0: jumbo features [frames: 16362 bytes, tx checksumming: ko]
[    4.338450] spd5118 13-0050: DDR5 temperature sensor: vendor 0x06:0x32 revision 1.6
[    4.342115] usbcore: registered new interface driver btusb
[    4.342816] spd5118 13-0051: DDR5 temperature sensor: vendor 0x06:0x32 revision 1.6
[    4.342838] iwlwifi 0000:02:00.0: enabling device (0000 -> 0002)
[    4.358771] iwlwifi 0000:02:00.0: Detected crf-id 0x3617, cnv-id 0x100530 wfpm id 0x80000000
[    4.358804] iwlwifi 0000:02:00.0: PCI dev 2723/0084, rev=0x340, rfid=0x10a100
[    4.358807] iwlwifi 0000:02:00.0: Detected Intel(R) Wi-Fi 6 AX200 160MHz
[    4.361066] Bluetooth: hci0: Found device firmware: intel/ibt-20-1-3.sfi
[    4.361080] Bluetooth: hci0: Boot Address: 0x24800
[    4.361081] Bluetooth: hci0: Firmware Version: 193-33.24
[    4.361083] Bluetooth: hci0: Firmware already loaded
[    4.362233] iwlwifi 0000:02:00.0: loaded firmware version 77.f39cc7f9.0 cc-a0-77.ucode op_mode iwlmvm
[    4.371109] Bluetooth: hci0: HCI LE Coded PHY feature bit is set, but its usage is not supported.
[    4.382927] snd_hda_intel 0000:65:00.1: enabling device (0000 -> 0002)
[    4.382991] snd_hda_intel 0000:65:00.1: Handle vga_switcheroo audio client
[    4.383068] snd_hda_intel 0000:65:00.6: enabling device (0000 -> 0002)
[    4.387645] kvm_amd: TSC scaling supported
[    4.387649] kvm_amd: Nested Virtualization enabled
[    4.387651] kvm_amd: Nested Paging enabled
[    4.387653] kvm_amd: LBR virtualization supported
[    4.387659] kvm_amd: [Firmware Bug]: Cannot enable x2AVIC, AVIC is unsupported
[    4.387661] kvm_amd: Virtual GIF supported
[    4.387662] kvm_amd: Virtual NMI enabled
[    4.389505] r8169 0000:01:00.0 enp1s0: renamed from eth0
[    4.400958] snd_hda_intel 0000:65:00.1: bound 0000:65:00.0 (ops amdgpu_dm_audio_component_bind_ops [amdgpu])
[    4.417083] input: HD-Audio Generic HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:08.1/0000:65:00.1/sound/card0/input6
[    4.417139] input: HD-Audio Generic HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:08.1/0000:65:00.1/sound/card0/input7
[    4.417194] input: HD-Audio Generic HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:08.1/0000:65:00.1/sound/card0/input8
[    4.417253] input: HD-Audio Generic HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:08.1/0000:65:00.1/sound/card0/input9
[    4.422750] amd_atl: AMD Address Translation Library initialized
[    4.422909] intel_rapl_common: Found RAPL domain package
[    4.422911] intel_rapl_common: Found RAPL domain core
[    4.426608] pps_core: LinuxPPS API ver. 1 registered
[    4.426611] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    4.434377] PTP clock support registered
[    4.435431] snd_hda_codec_alc662 hdaudioC1D0: autoconfig for ALC897: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:line
[    4.435436] snd_hda_codec_alc662 hdaudioC1D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    4.435438] snd_hda_codec_alc662 hdaudioC1D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
[    4.435440] snd_hda_codec_alc662 hdaudioC1D0:    mono: mono_out=0x0
[    4.435441] snd_hda_codec_alc662 hdaudioC1D0:    inputs:
[    4.435442] snd_hda_codec_alc662 hdaudioC1D0:      Rear Mic=0x18
[    4.435444] snd_hda_codec_alc662 hdaudioC1D0:      Front Mic=0x19
[    4.452260] snd_pci_ps 0000:65:00.5: enabling device (0000 -> 0002)
[    4.452556] input: HD-Audio Generic Rear Mic as /devices/pci0000:00/0000:00:08.1/0000:65:00.6/sound/card1/input10
[    4.452611] input: HD-Audio Generic Front Mic as /devices/pci0000:00/0000:00:08.1/0000:65:00.6/sound/card1/input11
[    4.452652] input: HD-Audio Generic Line Out as /devices/pci0000:00/0000:00:08.1/0000:65:00.6/sound/card1/input12
[    4.452695] input: HD-Audio Generic Front Headphone as /devices/pci0000:00/0000:00:08.1/0000:65:00.6/sound/card1/input13
[    4.619124] iwlwifi 0000:02:00.0: Detected RF HR B3, rfid=0x10a100
[    4.698680] iwlwifi 0000:02:00.0: base HW address: dc:45:46:f2:f1:0c
[    4.983515] FAT-fs (nvme0n1p1): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
[    4.988599] systemd-journald[450]: Received client request to flush runtime journal.
[    5.509390] Realtek Internal NBASE-T PHY r8169-0-100:00: attached PHY driver (mii_bus:phy_addr=r8169-0-100:00, irq=MAC)
[    5.618319] r8169 0000:01:00.0 enp1s0: Link is Down
[    8.825436] r8169 0000:01:00.0 enp1s0: Link is Up - 2.5Gbps/Full - flow control off
[    9.287796] netfs: FS-Cache loaded
[    9.325924] RPC: Registered named UNIX socket transport module.
[    9.325926] RPC: Registered udp transport module.
[    9.325927] RPC: Registered tcp transport module.
[    9.325928] RPC: Registered tcp-with-tls transport module.
[    9.325928] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    9.376752] Key type dns_resolver registered
[    9.453395] NFS: Registering the id_resolver key type
[    9.453402] Key type id_resolver registered
[    9.453403] Key type id_legacy registered
[   15.065606] rfkill: input handler disabled

--tFp+GUeSvr1YnwcN--

