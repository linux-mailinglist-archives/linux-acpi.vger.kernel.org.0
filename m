Return-Path: <linux-acpi+bounces-16591-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BB8B51EC3
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 19:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0702E1C86DFD
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 17:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F246328506B;
	Wed, 10 Sep 2025 17:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="EUHijJpT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D73426D4F9
	for <linux-acpi@vger.kernel.org>; Wed, 10 Sep 2025 17:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757524863; cv=none; b=s5ZjQRCsn4VR+QQxs74Ne3kdiIXzKr8QJV6dlndfqr1zWS5atXuwjBrI4Spqp7cGy8m7gsppGtN3LH7grEdBr+IWLIKDdHSdlugQu/1mACughqgREAi5rCIH4cZT/QDR5rpXmuceYnG/TUB7hM+4kNaUV5nnDqJAbHenAaxxBvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757524863; c=relaxed/simple;
	bh=kCEO0YTt6Ohy/VkqnyZfNYD2LFwpNyBrnjm/fgenpuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q8jwIkJAq/Ck8M/EbNNUwHtgpT27ONUnEBdHFkPB6uYfviFwJFCBwX605JFpGll4fyP7SiYaMoes79Zsx6HpUGbW4ppKOLdoDedUJos+e/00B8KyZD4TD9KohUnWPFtTVOcIdDVm6lQ/L/1Ip0RNc9+RF264wEEycLSKflHR+l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=EUHijJpT; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55f6b0049fbso7962373e87.0
        for <linux-acpi@vger.kernel.org>; Wed, 10 Sep 2025 10:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1757524859; x=1758129659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4y7C8S2xJQZYsJ9c9ADBNgi86RVk7zzkb8x6ic0x2s=;
        b=EUHijJpTq43g5hvq97u8EwhMATDVfLOt84qJGU9gO1B4furajZcfjDDfFPygIYZqgD
         d2whZGR+HnFEaXByX0bPQrU1zcTegv7s7HsHCpxW5JTgf7ElAikHJP3M5DCjoAXgM7iY
         VokNSg7dGuBkAFVtpTsQEF1iTHFNZXNbm5V0q6E+E6plHWXdRb/Y05MUyN8+LNyGJJ//
         kfm9V/jxmBJcW6UIPQBFHrL+8LBKMp8ub856t+4CtRg0QMSylW6NTNzOuPef04C4UK0D
         bN8AqxmBz7RindiWh6bMc+vNFUinlPnCXpr8Djl19B0c+GDx48vJYF3/OJA4tgB/nJFH
         p1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757524859; x=1758129659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D4y7C8S2xJQZYsJ9c9ADBNgi86RVk7zzkb8x6ic0x2s=;
        b=RU1lP1o9rLJvt9DWCOQcflUmChENt95sPsjMNkVeZb/QZYF46IYa7llnDniVoNdg1t
         laca5jIPX2g2wM1BcX7fCqErMb55AdE4WNmMc/NsR8/wM/KhIJc7hTkPadLlOVoJFnWx
         AyDpB5sn26KSsc11oXEaXJIXQPvKnd2HgciySiJk2arYDAHdZTegkEMLFocW8artCnjJ
         7fSz5iJ02Ath1sPHo51r3dW6vpdTCJgaqpR/4h8+ogK2/EeKg44W25WtW0ndHNYbYmmk
         Rv03fqEXFxMTjDTRDyWxJOUxtDqab9YIXL9rtxub92zJQvCLqCGmAJiqwcTyuLUuJf+J
         rwpg==
X-Forwarded-Encrypted: i=1; AJvYcCWN6cQ191KTydKLm6Z4J5KFAsPcpMOT/cp4RT9iJ82WiHgt5fSjHX5v7XsfgwcnhquATISPdmE1q/tw@vger.kernel.org
X-Gm-Message-State: AOJu0YzbImGhTkKlAH7ncD5M8A8hcz9m1IG8GiDCSvagbyxEBKR+InwX
	QYOWvG5vpZdySKIbS3BYrxK2aytcxZ9MigCT0o4KvWAOgcxyvgHH5I23eIurCYONwK7x1iakx36
	6ltmTUi8pcu8fsNWhX0I2b4CwNGIYZ1/q0nQy7hR+sA==
X-Gm-Gg: ASbGncs7D0ZZ5ECLj9LOQe9Oxu/k9mJSDc/lHoCVyUk4mP+v8mr45hVhQ2zK1OzIhLS
	EDl5fhpvbCklUgesISCb1pEHBoGlsQQYSAzauTaGTs/vx3/e0pB4HIz1qDLWpi79wvG7SKZKNPf
	yAXxr5sHN6NxsTyCYXM4hJkJa0B7kyILeZhpbwt4EM2kUpCTxLtL6Oh7hDjYh1JwJUVQUK358CI
	Mxaq1ro/ubjmQCEGJ8=
X-Google-Smtp-Source: AGHT+IEMC5CgIT7ZKhbb9e4OnXDYYVwccWgf2cqpuCV1m2eXMNd148ZBrJvXPaZEKu+blEhZhrwZCup0EV+3UQHRlvM=
X-Received: by 2002:a05:6512:33d2:b0:560:95c0:a523 with SMTP id
 2adb3069b0e04-56262667e77mr5945448e87.35.1757524859373; Wed, 10 Sep 2025
 10:20:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910093347.75822-1-tianruidong@linux.alibaba.com>
In-Reply-To: <20250910093347.75822-1-tianruidong@linux.alibaba.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Wed, 10 Sep 2025 22:50:47 +0530
X-Gm-Features: Ac12FXyVWt78cRqW1T3y7uW90ELz685Wecbof4GuJH9AJDtvZCte0fSBKlzx1OU
Message-ID: <CAK9=C2UnN0VFnGCRSHaYrwzjHFu-PfWpWkBzNfJNW9wwM8UOvw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] riscv: Handle synchronous hardware error exception
To: Ruidong Tian <tianruidong@linux.alibaba.com>
Cc: xueshuai@linux.alibaba.com, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, james.morse@arm.com, tony.luck@intel.com, 
	cleger@rivosinc.com, hchauhan@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 3:04=E2=80=AFPM Ruidong Tian
<tianruidong@linux.alibaba.com> wrote:
>
> Hi all,
> This patch series introduces support for handling synchronous hardware er=
rors
> on RISC-V, laying the groundwork for more robust kernel-mode error recove=
ry.
>
> 1. Background
> Hardware error reporting mechanisms typically fall into two categories:
> asynchronous and synchronous.
>
> - Asynchronous errors (e.g., memory scrubbing errors) repoted by a asynch=
ronous
> exceptions or a interrupt, are usually handled by GHES subsystems. For in=
stance,
> ARM uses SDEI, and a similar SSE specification is being proposed for RISC=
-V.
> - Synchronous errors (e.g., reading poisoned data) cause the processor co=
re to
> take a precise exception. This is known as a Synchronous External Abort (=
SEA)
> on ARM, a Machine Check Exception (MCE) on x86, and is designated as trap=
 with
> mcause 19 on RISC-V.
>
> Discussions within the RVI PRS TG have already led to proposals[0] to UEF=
I for
> standardizing two notification methods, SSE and Hardware Error Exception,
> on RISC-V.
> This series focuses on implementing Hardware Error Exception notification=
 to
> handle synchronous errors. Himanshu Chauhan has already started working o=
n SSE[1].
>
> 2. Motivation
> While a synchronous hardware errors occurring in kernel context (e.g., du=
ring
> get_user, put_user, CoW, etc.). The kernel requires a fixup mechanism (vi=
a
> extable) to recover from such errors and prevent a system panic. However,=
 the
> APEI/GHES subsystem, being asynchronous, cannot directly leverage the syn=
chronous
> extable fixup path.
>
> By handling the synchronous exception directly, we enable the use of this=
 fixup
> mechanism, allowing the kernel to gracefully recover from hardware errors
> encountered during kernel execution. This brings RISC-V's error handling
> capabilities closer to the robustness found on ARM[2] and x86[3].
>
> 3. What This Patch Series Does
> This initial series lays the foundational infrastructure. It primarily:
> - Introduces a new exception handler for synchronous hardware errors (mca=
use=3D19).
> - Establishes the core exception path, which is a prerequisite for kernel
>   context error recovery.
>
> Please note that this version does not yet implement the full kernel fixu=
p logic
> for recovery. That functionality is planned for the next formal version.
>
> Some adaptations for GHES are included, based on the work from Himanshu C=
hauhan[1]
>
> 4. Future Plans
> - Implement full kernel fixup support to handle and recover from errors i=
n
>   some kernel context[2].
> - Add support for handling "double trap" scenarios.
>
> 5. Testing Methodology
>
> test program: ras-tools: https://kernel.googlesource.com/pub/scm/linux/ke=
rnel/git/aegl/ras-tools/
> qemu: https://github.com/winterddd/qemu
> offcial opensbi and edk2:
>
> - Run qemu:
> qemu-system-riscv64 -M virt,pflash0=3Dpflash0,pflash1=3Dpflash1,acpi=3Don=
,aia=3Daplic-imsic
>  -cpu max -m 64G -smp 64 -device virtio-gpu-pci -full-screen -device qemu=
-xhci
>  -device usb-kbd -device virtio-rng-pci
>  -blockdev node-name=3Dpflash0,driver=3Dfile,read-only=3Don,filename=3DRI=
SCV_VIRT_CODE.fd
>  -blockdev node-name=3Dpflash1,driver=3Dfile,filename=3DRISCV_VIRT_VARS.f=
d
>  -bios fw_dynamic.bin -device virtio-net-device,netdev=3Dnet0
>  -netdev user,id=3Dnet0,hostfwd=3Dtcp::2223-:22
>  -kernel Image -initrd rootfs
>  -append "rdinit=3D/sbin/init earlycon verbose debug strict_devmem=3D0 no=
kaslr"
>  -monitor telnet:127.0.0.1:5557,server,nowait -nographic
>
> - Run ras-tools:
> ./einj_mem_uc -j -k single &
> $ 0: single   vaddr =3D 0x7fff86ff4400 paddr =3D 107d11b400
>
> - Inject poison
> telnet localhost 5557
> poison_enable on
> poison_add 0x107d11b400
>
> - Read poison
> echo trigger > ./trigger_start
> $ triggering ...
> $ signal 7 code 3 addr 0x7fff86ff4400
>
> [0]: https://lists.riscv.org/g/tech-prs/topic/risc_v_ras_related_ecrs/113=
685653
> [1]: https://patchew.org/linux/20250227123628.2931490-1-hchauhan@ventanam=
icro.com/
> [2]: https://lore.kernel.org/lkml/20241209024257.3618492-1-tongtiangen@hu=
awei.com/
> [3]: https://github.com/torvalds/linux/blob/9dd1835ecda5b96ac88c166f4a873=
86f3e727bd9/arch/x86/kernel/cpu/mce/core.c#L1514
>
> Himanshu Chauhan (2):
>   riscv: Define ioremap_cache for RISC-V
>   riscv: Define arch_apei_get_mem_attribute for RISC-V
>
> Ruidong Tian (3):
>   acpi: Introduce SSE and HEE in HEST notification types
>   riscv: Introduce HEST HEE notification handlers for APEI
>   riscv: Add Hardware Error Exception trap handler
>

Himanshu had already sent-out RFC v1 way back in Feb 2025 [1] which
did not receive any comments or feedback.

Instead of sending out a half-baked series, it will be helpful if you
can review Himanshu's series.

Regards,
Anup

[1] https://patchew.org/linux/20250227123628.2931490-1-hchauhan@ventanamicr=
o.com/

