Return-Path: <linux-acpi+bounces-20090-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F534D080D3
	for <lists+linux-acpi@lfdr.de>; Fri, 09 Jan 2026 10:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9408B3022F3C
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Jan 2026 09:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AA632F762;
	Fri,  9 Jan 2026 09:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lUvItflC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IWhPKwQY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C2230BB91
	for <linux-acpi@vger.kernel.org>; Fri,  9 Jan 2026 09:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767949359; cv=none; b=BR/yhNgjP1DcFy8Gy+o1hfy8pjhKn1GcoovCqfiNi9PEIfRgb7HNk+Kz/NMxR1iZkHY7MnRNuWnEa/nRUOwjKbKg+2MECYjbSpvco2HvyUN4PayM9kHnqMlVyKmHv8qWm5X9vuUXwe2B2QH0/cxQLv/5489HoqI9FTJtUAmbwV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767949359; c=relaxed/simple;
	bh=43UXhApAkBbdyL5srItP+jv6EOFCQfwD3JkEtU+Yv8c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QTVCMG6zsgwSbVy4bFHx9r8UINZq4css5d9wjT4BhN7S/D0qk4+6EDQ5XZ+T96Y57DeG+2INiY7eeD0qujeXyGKNenrH76o7CwAS9ySD0UeZynjD62Jbj1wxSZhjIbaxSTYp/MxLva4K1NdCtq7j5VIyHNWPIqlLsILbcW/4FmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lUvItflC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IWhPKwQY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6095SWhp2706841
	for <linux-acpi@vger.kernel.org>; Fri, 9 Jan 2026 09:02:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=jaPeZjaEm2rmsGcviI7wax
	bXzFXJxMs5/kStWwjIs8k=; b=lUvItflCX5293Zm0gWhsCNMlaC3RNDoOoumpL+
	Sf6LfIxKeTAFIjC/PVZAxejpqqzyr0gb6W1Nw/aLtw+C6zuZrbt+DmcG+39DIlfq
	NRNkrd76Y/wc5u1WWex3F3tiaqUzc9Hp2ddwa8c9/j4Cij+hGDBlnh4eraXVXKui
	W1wFmowcuoZaSXqZ4J9wD6BI8tTPt676/kCum5PJmh/PIyTMAv19IMb+FjU8ZsR1
	d6jI42x6ywBrQy0F4H4Hmjhe68CX4bE8KUV0CLJ7A2vyuvHSbJPd6JYn5Gm9opef
	gz9W9AjpxYScfyGWqKGjKNJgWXH55jmTJ3JS1fGeybWNQjdg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bj9hquy20-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 09 Jan 2026 09:02:34 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7b952a966d7so7574501b3a.3
        for <linux-acpi@vger.kernel.org>; Fri, 09 Jan 2026 01:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767949353; x=1768554153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jaPeZjaEm2rmsGcviI7waxbXzFXJxMs5/kStWwjIs8k=;
        b=IWhPKwQYUuVauOSJTMaF/8cfx4YO9jSs6Yqo6ydil76rsMzyG3UxhygHwGaOOblo0/
         iNhDC7dPxjX3zlOnukAwNTOf9LM+Vunj47M/F4xnrGcz2ZYq7ufea0KfPd2avZBhL+7d
         GyrDWd+FjZM0wRq9q2f2vHg+cpqwyF2CDdMpH8rqXq4X3ZC68nCYCJcLt7lAkzQZ+vR+
         4h9xmKs4HjHkwxZ7IrwvY/kadq6X8bIIn4GYy5TtRecjzWuCefgWJFR+fmb2EazeGqmR
         26VkUZuvSRgqJvIgT/mPz+K+yob1yb78jOrdaxeqh+C4eN6p1ginVo5WHOYlqKUWwAoq
         Kodw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767949353; x=1768554153;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jaPeZjaEm2rmsGcviI7waxbXzFXJxMs5/kStWwjIs8k=;
        b=b+rJheitpKAOBJuudR3Cdj7lnL0UdxMPY3GG+CzY7pDO+1qlbAg1/ZZWH2IzBYnrBy
         ULWbM0Ytr3ZZqH/fpyEBrbz2cnp/+/cFg8B6cJpM51uQporrUWaEyKUeP5Y1HhqFOlRV
         ZuvpzuodpaWR+l9o2qwERB6riZQM9yQfRFASfAcY5xClXd6kaf3LZW5iFdKBzzDSORjY
         B2XpxQPx6AoY+FjR6DBghbOA0uplsOR7LpotcMz6z/QCpVPIQe7uDaDJBebnbgXKxw0R
         YzYVfdaqnUhvPC/3gCI2Wn9fPmtMosvR4znC4YwvGUe+LDRPKIwh2RqofOGRcCNG96ZN
         INiw==
X-Forwarded-Encrypted: i=1; AJvYcCWypDs8B0JSb+QDgZrKyPDi7jtjqVDXKPFjDNO2vlp/B2Pkd5a1jTO35YqQbqcRbj21dOq3//BTDeHR@vger.kernel.org
X-Gm-Message-State: AOJu0YzKO2PbTj10rpddhEL9/bZ327HxGP88Fs0Ssk+deynPPRceu3yD
	npqK/vTLlZndq+sDjOg9NLSGvND+9RoOEcfDTGV2NaODvX310q/5cfU6LGayLy0YblYitEdEvyW
	iJiUt1H2AUVh2p1erSTLHsxSRMdke1/Sp3QSBFb50tlhIDiK8xVHL6bjfo/aKg9LB
X-Gm-Gg: AY/fxX433FY1FZjEOCITc6cvV/9ZuAjP1GpfKR/nLn4bxzdnYSYF0rKQSui0a9sR3BB
	SO1DS8GtXcGINXKtUzzI7AxYGgU8WLBR/l6fk3LNQwSLfc47SFCG2TjSo0lPI3sSL7BErORF6L2
	mYkrrhsNGbf5TDeP6YSyOE84gKRRzM7aXhapxpRifqht3MhQ4UzyyAYO+qHVdeiHnPUQwHjCQa9
	Pjygq9be5+P71TSfGAlunK5rGefuzyrEwcy3ikYTI5dFdMF8ORgGmIC3rXkQr3aqXTY4pJgSOMC
	m562ES+e94BBqSRlgQDGMStSpaIrFXWJdXPOq00UX88Xoy58oAxlpIFqopfB6azSRVW/VmruBhV
	VV6qaOip25HDoP3Jgm2LSLHzTOg/GO14vE1kHM2crqge8NjJbSiCozDef2hiGFYa1/39Cwi+cmf
	AjOjdLDN34rOBusU2FkdimZG/qwUR8WMU/Pw==
X-Received: by 2002:a05:6a00:909b:b0:7ff:ce33:e6b0 with SMTP id d2e1a72fcca58-81b7d3584dcmr8600307b3a.10.1767949353038;
        Fri, 09 Jan 2026 01:02:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKauFosRUhftJAAnZIqR7HI0iWGjeOb7mTBwr//VM09K21Q9R/ybDsy4S6rU/Qg0jctDgUNQ==
X-Received: by 2002:a05:6a00:909b:b0:7ff:ce33:e6b0 with SMTP id d2e1a72fcca58-81b7d3584dcmr8600210b3a.10.1767949352262;
        Fri, 09 Jan 2026 01:02:32 -0800 (PST)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c59e826asm9831562b3a.54.2026.01.09.01.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 01:02:31 -0800 (PST)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
        acpica-devel@lists.linux.dev, paul.walmsley@sifive.com,
        palmer@dabbelt.com, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
        cleger@rivosinc.com, robert.moore@intel.com, sunilvl@oss.qualcomm.com,
        anup.patel@oss.qualcomm.com
Cc: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v3 00/10] Add RAS support for RISC-V architecture
Date: Fri,  9 Jan 2026 14:32:14 +0530
Message-ID: <20260109090224.3105465-1-himanshu.chauhan@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GN8F0+NK c=1 sm=1 tr=0 ts=6960c42a cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=h0uksLzaAAAA:8
 a=dw0t6H4-AAAA:8 a=j7arexpxAAAA:20 a=WC7QRpXXAAAA:20 a=F-tpdftpAAAA:20
 a=NM_uERPgrM2pg5U9BGAA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=MSi_79tMYmZZG2gvAgS0:22 a=wVJa4CU9-Z26yuRAZDil:22
X-Proofpoint-GUID: 1nBQMQQI9vJkulx44CUfAJtskgQ5Dmfv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA2NCBTYWx0ZWRfXwOfb8zEi9LLv
 3O88x+bgq1dt4n+RhCyr3Z5J2VIdUCFF4OLjbeqRKkEQKWalMXRkcqnmWscw95F50CEC7htcc3d
 eIv3h9CRiYH2+TQhlJtjlDtM36fn3o/0h2tQrYJEKZh1NHFaDQqNJDyHQhK13PimSwsHDePeMUh
 Ug0jq5pWtx580l7cBZF99tOEdn/wMog8LoG4XP/2K/bGp18rBYMRXiJr+1Qk0d/SBibuhza8i2D
 RcAks2bHn0OB87bZ+mh9Dw6gKw9wo+qFLznNrnsckV9zljDj/9mgG4h9yeGsQ5nxwv8gCxv29sg
 YR6u1aBZGhBkDVIgs5vrfrufyK1FKke/i3t/9KklQURaHXYn89wV3KE5gziLsbq0+xC7dGxKZx/
 yV5+1cDteKIhph9rujATGnO3bI9tx6cUc297OF9RTa00h2OXvGpAljRYLig463RpF67Dig0SLP8
 YCHPgI+GwPNURIrZWEg==
X-Proofpoint-ORIG-GUID: 1nBQMQQI9vJkulx44CUfAJtskgQ5Dmfv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_02,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1011 phishscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601090064

RAS stands for Reliability, Availability and Serviceability.

This series implements the RAS support for RISC-V architecture using
RISC-V RERI specification. It is conformant to ACPI platform error
interfaces (APEI). It uses the highest priority Supervisor Software
Events (SSE)[2] to deliver the hardware error events to the kernel.
The SSE implementation has already been merged in OpenSBI. Clement
has sent a patch series for its implemenation in Linux kernel.[5]

The GHES driver framework is used as is with the following changes for RISC-V:
	1. Register each ghes entry with SSE layer. Ghes notification vector is SSE event.
	2. Add RISC-V specific entries for processor type and ISA string
	3. Add fixmap indices GHES SSE Low and High Priority to help map and read from
	   physical addresses present in GHES entry.
	4. Other changes to build/configure the RAS support

Changes in v3:
 - Dropped RFC tag because the related ECRs are now approved [6][7][8][9]
 - Changes to be conformant with SSE v8 patches

Changes in v2:
 - Made changes to be conformant with SSE v7 patches
 - Fixed some bot warnings

How to Use:
----------
This RAS stack consists of Qemu[3], OpenSBI, EDK2[4], Linux kernel and devmem utility to inject and trigger
errors. Qemu [Ref.] has support to emulate RISC-V RERI. The RAS agent is implemented in OpenSBI which
creates CPER records. EDK2 generates HEST table and populates it with GHES entries with the help of
OpenSBI.

Qemu Command:
------------
<qemu-dir>/build/qemu-system-riscv64 \
    -s -accel tcg -m 4096 -smp 2 \
    -cpu rv64,smepmp=false \
    -serial mon:stdio \
    -d guest_errors -D ./qemu.log \
    -bios <opensbi-dir>/build/platform/generic/firmware/fw_dynamic.bin \
    -monitor telnet:127.0.0.1:55555,server,nowait \
    -device virtio-gpu-pci -full-screen \ 
    -device qemu-xhci \
    -device usb-kbd \
    -blockdev node-name=pflash0,driver=file,read-only=on,filename=<edk2-build-dir>/RiscVVirtQemu/RELEASE_GCC5/FV/RISCV_VIRT_CODE.fd \
    -blockdev node-name=pflash1,driver=file,filename=<edk2-build-dir>/RiscVVirtQemu/RELEASE_GCC5/FV/RISCV_VIRT_VARS.fd \
    -M virt,pflash0=pflash0,pflash1=pflash1,rpmi=true,reri=true,aia=aplic-imsic \
    -kernel <kernel image> \
    -initrd <rootfs image> \
    -append "root=/dev/ram rw console=ttyS0 earlycon=uart8250,mmio,0x10000000"

Error Injection & Triggering:
----------------------------
devmem 0x4010040 32 0x2a1
devmem 0x4010048 32 0x9001404
devmem 0x4010044 8 1

The above commands injects a TLB error on CPU 0.

Sample Output (CPU 0):
---------------------
[   34.370282] {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 1
[   34.371375] {1}[Hardware Error]: event severity: recoverable
[   34.372149] {1}[Hardware Error]:  Error 0, type: recoverable
[   34.372756] {1}[Hardware Error]:   section_type: general processor error
[   34.373357] {1}[Hardware Error]:   processor_type: 3, RISCV
[   34.373806] {1}[Hardware Error]:   processor_isa: 6, RISCV64
[   34.374294] {1}[Hardware Error]:   error_type: 0x02
[   34.374845] {1}[Hardware Error]:   TLB error
[   34.375448] {1}[Hardware Error]:   operation: 1, data read
[   34.376100] {1}[Hardware Error]:   target_address: 0x0000000000000000

References:
----------
[1] [RERI Specification          ]: https://github.com/riscv-non-isa/riscv-ras-eri/releases/download/v1.0/riscv-reri.pdf
[2] [Chap-19 SSE RISC-V SBI v3.0 ]: https://github.com/riscv-non-isa/riscv-sbi-doc/releases/download/v3.0/riscv-sbi.pdf
[3] [Qemu source (RERI Support)  ]: https://github.com/ventanamicro/qemu.git (branch: dev-upstream)
[4] [EDK2                        ]: https://github.com/ventanamicro/edk2.git (branch: dev-upstream)
[5] [SSE Kernel Patches (v8)     ]: https://lore.kernel.org/all/20251105082639.342973-1-cleger@rivosinc.com/
[6] [ACPI ECR for HEST changes   ]: https://mantis.uefi.org/mantis/view.php?id=2522
[7] [RISC-V CPER Table ECR       ]: https://mantis.uefi.org/mantis/view.php?id=2551
[8] [RISC-V CPER Proposed Changes]:
	[PART 1] https://docs.google.com/document/d/1-Dd-T_QIUqjq3muyjfK8IUeXWr9QWkFAkFyzweXQL30/edit?tab=t.0
	[PART 2] https://docs.google.com/document/d/13y8kQqbVtCAPCMI4oJ80MtcUS5FL4xuO914NmfCi5vI/edit?tab=t.0
[9] [RISC-V APEI Proposed Changes]: https://docs.google.com/document/d/18rxA6JTyFTelEj0aiKdSFzxPgwyHyThj8EP8lXqWZdY/edit?tab=t.0

Himanshu Chauhan (10):
  riscv: Define ioremap_cache for RISC-V
  riscv: Define arch_apei_get_mem_attribute for RISC-V
  acpi: Introduce SSE in HEST notification types
  riscv: Add fixmap indices for GHES IRQ and SSE contexts
  riscv: conditionally compile GHES NMI spool function
  riscv: Add functions to register ghes having SSE notification
  riscv: Add RISC-V entries in processor type and ISA strings
  riscv: Introduce HEST SSE notification handlers
  riscv: Select HAVE_ACPI_APEI required for RAS
  riscv: Enable APEI GHES driver in defconfig

 arch/riscv/Kconfig                     |   1 +
 arch/riscv/configs/defconfig           |   3 +
 arch/riscv/include/asm/acpi.h          |  20 ++++
 arch/riscv/include/asm/fixmap.h        |   8 ++
 arch/riscv/include/asm/io.h            |   3 +
 drivers/acpi/apei/Kconfig              |   5 +
 drivers/acpi/apei/ghes.c               | 102 +++++++++++++++--
 drivers/firmware/efi/cper.c            |   3 +
 drivers/firmware/riscv/riscv_sbi_sse.c | 146 +++++++++++++++++++++++++
 include/acpi/actbl1.h                  |   3 +-
 include/linux/riscv_sbi_sse.h          |  16 +++
 11 files changed, 298 insertions(+), 12 deletions(-)

-- 
2.43.0


