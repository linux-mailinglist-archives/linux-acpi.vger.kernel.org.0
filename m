Return-Path: <linux-acpi+bounces-20723-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHWUKLxxemlI6QEAu9opvQ
	(envelope-from <linux-acpi+bounces-20723-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 21:29:48 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB63A887B
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 21:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8D4B3071041
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 20:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA40336ECA;
	Wed, 28 Jan 2026 20:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XG34yeAF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476953321A3;
	Wed, 28 Jan 2026 20:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769632083; cv=none; b=Bfumkdu0Sqor1DxZKwHn4Gu+7CgxkmM0FVUoGEfsAm5/vs0rTxsS3+V8/RdjoZtglYcOMq48zvnyHKRbApvEOrqPK6vgmCLfcnbUHR3tGQKDhuNmgnMAZZYHQS0yD5HWmxkTPgK93x0/boB3m7QJ3ghcuAONqBG4ZsxR/gZQ6+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769632083; c=relaxed/simple;
	bh=wQj2q6wuJjpPm7rr1TKf5AbpKETgZxroRvnXhQ5JpLg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LKW2ZhGqa7rtyamkh+i0f5hJ1czzXpJUklWtSiPMz4Oht7gucefVrhsQCotjzi7V6AVuoo62qk3M06HXN5xatOqkrKfCPmXD7/XvzVKVN8sdfNQt0vZVxU4VZh/9S74c2ZftXanl3UhE0Q9GEmeAppztQsUaccw9py17Vy/iKyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XG34yeAF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF96C4CEF1;
	Wed, 28 Jan 2026 20:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769632082;
	bh=wQj2q6wuJjpPm7rr1TKf5AbpKETgZxroRvnXhQ5JpLg=;
	h=From:Subject:Date:To:Cc:From;
	b=XG34yeAFBYrJsx6Yfiu5cq8wYlowegpK+/GusIA/DwUhKdYp4XxhTs+ZESSh2AIvn
	 NljDx6v4xZ0eBlJ7ueEDPEHhMk3+Gr8EG+cjNEjYb8PSUzffwcSRssTUP+N5cXj/ST
	 cz5E9R4idtbe0D0NKKhtBUfz6I7x15FjMgTpruKYKRUU7XJeUObey60h3DU0Jv3EXb
	 NICm4V01+tSyEiZRN+Geov7S4CrpNtuOwci2DktUNh/SIiSiTZjrQAMYt1lv3ZP7+z
	 c013WXkG4pm02IxDNqF8d/KoGUlL6F/THfORAHtlMzvk2nuY4velLcWnoBsAXzhLo1
	 uIjuCLgFe5BRA==
From: Drew Fustini <fustini@kernel.org>
Subject: [PATCH RFC v2 00/17] RISC-V: QoS: add CBQRI resctrl interface
Date: Wed, 28 Jan 2026 12:27:21 -0800
Message-Id: <20260128-ssqosid-cbqri-v2-0-dca586b091b9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAClxemkC/12NwQrCMBBEf6Xs2UiSttZ6EgQ/wKv0ENNNuyiN3
 ZWilP67oXjy+GaYNzMIMqHAIZuBcSKhOCSwmwx874YOFbWJwWq708ZYJTJGoVb528ikCl354Ft
 Xh1BA2jwZA71X3xUu5xM0KexJXpE/68dk1uqnq/90k1FaOWddVZoy3+f2eEce8LGN3EGzLMsX5
 hpSlrAAAAA=
X-Change-ID: 20260112-ssqosid-cbqri-407cfcda9ff4
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Adrien Ricciardi <aricciardi@baylibre.com>, 
 Nicolas Pitre <npitre@baylibre.com>, 
 =?utf-8?q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
 Atish Patra <atish.patra@linux.dev>, 
 Atish Kumar Patra <atishp@rivosinc.com>, 
 Vasudevan Srinivasan <vasu@rivosinc.com>, Ved Shanbhogue <ved@rivosinc.com>, 
 yunhui cui <cuiyunhui@bytedance.com>, Chen Pei <cp0613@linux.alibaba.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>, 
 guo.wenjia23@zte.com.cn, liu.qingtao2@zte.com.cn, 
 Reinette Chatre <reinette.chatre@intel.com>, 
 Tony Luck <tony.luck@intel.com>, Babu Moger <babu.moger@amd.com>, 
 Peter Newman <peternewman@google.com>, Fenghua Yu <fenghua.yu@intel.com>, 
 James Morse <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>, 
 Dave Martin <Dave.Martin@arm.com>, Drew Fustini <fustini@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 x86@kernel.org, Rob Herring <robh@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, Sunil V L <sunilvl@ventanamicro.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, linux-acpi@vger.kernel.org, 
 acpica-devel@lists.linux.dev, devicetree@vger.kernel.org, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=13056; i=fustini@kernel.org;
 h=from:subject:message-id; bh=wQj2q6wuJjpPm7rr1TKf5AbpKETgZxroRvnXhQ5JpLg=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWRWFXoW/nr5RnPej/s/XOtXf1L5e2aKa8aM7IzZBekeF
 4/emPBHrqOUhUGMi0FWTJFl04e8C0u8Qr8umP9iG8wcViaQIQxcnAIwkasljAyvvJKr1m4N/J5g
 +iAtYmqXxPvdDNdmzF6aeCRnfvPXgzcPMfyV/WEpP/eLckGn3W+x346KKw+kO17Lupx/SGn3tpt
 LDZdzAwA=
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20723-lists,linux-acpi=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,ventanamicro.com,sifive.com,baylibre.com,semihalf.com,linux.dev,rivosinc.com,bytedance.com,linux.alibaba.com,gmail.com,zte.com.cn,intel.com,amd.com,google.com,arm.com,vger.kernel.org,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[43];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fustini@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4CB63A887B
X-Rspamd-Action: no action

This RFC series implements the RISC-V Quality-of-Service Identifiers
(Ssqosid) extension [1] which adds the srmcfg register. It also
implements the RISC-V Capacity and Bandwidth Controller QoS Register
Interface (CBQRI) specification [2] and integrates resctrl [3] support.
The patches are also available as a branch [4].

There is a Qemu patch series [5] that implements Ssqosid and CBQRI, and
a corresponding Qemu branch with those patches too [6]. ACPI RQSC
support [7] is imeplemented as a set of additional patches [8].

[1] https://github.com/riscv/riscv-ssqosid/releases/tag/v1.0
[2] https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
[3] https://docs.kernel.org/filesystems/resctrl.html
[4] https://git.kernel.org/pub/scm/linux/kernel/git/fustini/linux.git/log/?h=b4/ssqosid-cbqri
[5] https://lore.kernel.org/qemu-devel/20260105-riscv-ssqosid-cbqri-v4-0-9ad7671dde78@kernel.org/
[6] https://github.com/tt-fustini/qemu/tree/b4/riscv-ssqosid-cbqri
[7] https://github.com/riscv-non-isa/riscv-rqsc/blob/main/src/
[8] https://github.com/tt-fustini/qemu/tree/b4/riscv-rqsc

RISC-V QoS
----------
QoS (Quality of Service) in this context is concerned with shared
resources on an SoC such as cache capacity and memory bandwidth.

The Sssqosid extension defines the srmcfg CSR which configures a hart
with two identifiers:

 - Resource Control ID (RCID)
 - Monitoring Counter ID (MCID)

These identifiers accompany each request issued by the hart to shared
resource controllers. This allows the capacity and bandwidth resources
used by a software workload (e.g. a process or a set of processes) to be
controlled and monitored.

CBQRI defines operations to configure resource usage limits, in the form
of capacity or bandwidth, for an RCID. CBQRI also defines operations to
configure counters to track resource utilization per MCID. Furthermore,
the Access Type (AT) field allows resource usage to be differentiated
between data and code.

x86 comparison
--------------
The existing QoS identifiers on x86 map well:

  CLOSID (Class of Service ID) on x86 is RCID on RISC-V
    RMID (Resource Monitoring ID) on x86 is MCID on RISC-V

In addition, CDP (code data prioritization) on x86 is similar to the
AT (access type) field in CBQRI which defines code and data types.

One aspect of CBQRI that simplifies the RISC-V resctrl interface is that
any cpu (technically a hart, or hardware thread, in RISC-V terminology)
can access the memory-mapped registers of any CBQRI controller in the
system. This means it does not matter which cpu runs the resctrl code.

Example SoC
-----------
This series was developed and tested using the Qemu virt platform [8]
configured as a hypothetical SoC with a cache controller that implements
CBQRI capacity operations and a memory controller that implements CBQRI
bandwidth operations.

  - L2 cache controllers
    - Resource type: Capacity
    - Number of capacity blocks (NCBLKS): 12
    	- In the context of a set-associative cache, the number of
	  capacity blocks can be thought of as the number of ways
    - Number of access types: 2 (code and data)
    - Usage monitoring not supported
    - Capacity allocation operations: CONFIG_LIMIT, READ_LIMIT

  - Last-level cache (LLC) controller
    - Resource type: Capacity
    - Number of capacity blocks (NCBLKS): 16
    - Number of access types: 2 (code and data)
    - Usage monitoring operations: CONFIG_EVENT, READ_COUNTER
    - Event IDs supported: None, Occupancy
    - Capacity allocation ops: CONFIG_LIMIT, READ_LIMIT, FLUSH_RCID

  - Memory controllers
    - Resource type: Bandwidth
    - Number of bandwidth blocks (NBWBLKS): 1024
       - Bandwidth blocks do not have a unit but instead represent a
         portion of the total bandwidth resource. For NWBLKS of 1024,
	 each block represents about 0.1% of the bandwidth resource.
    - Maximum reserved bandwidth blocks (MRBWB): 819 (80% of NBWBLKS)
    - Number of access types: 1 (no code/data differentiation)
    - Usage monitoring operations: CONFIG_EVENT, READ_COUNTER
    - Event IDs supported: None, Total read/write byte count, Total
                           read byte count, Total write byte count
    - Bandwidth allocation operations: CONFIG_LIMIT, READ_LIMIT

The memory map for this example SoC:

  Base addr  Size
  0x4820000  4KB  Cluster 0 L2 cache controller
  0x4821000  4KB  Cluster 1 L2 cache controller
  0x4828000  4KB  Memory controller 0
  0x4829000  4KB  Memory controller 1
  0X482a000  4KB  Memory controller 2
  0X482b000  4KB  Shared LLC cache controller

This configuration is only meant to provide a "concrete" example, and it
represents just one of many possible ways that hardware can implement
the CBQRI spec.

The example SoC configuration is created with the following:

  qemu-system-riscv64 \
	-M virt,pflash0=pflash0,pflash1=pflash1,aia=aplic-imsic  \
	-smp cpus=8,sockets=1,clusters=2,cores=4,threads=1 \
	-m 1G \
	-nographic \
	-kernel ${LINUX}/arch/riscv/boot/Image \
	-append "root=/dev/vda rootwait" \
	-blockdev node-name=pflash0,driver=file,read-only=on,filename=${EDK}/RISCV_VIRT_CODE.fd \
	-blockdev node-name=pflash1,driver=file,filename=${EDK}/RISCV_VIRT_VARS.fd \
	-drive if=none,file=${ROOTFS}/rootfs.ext2,format=raw,id=hd0 \
	-device virtio-blk-device,drive=hd0 \
	-device qemu-xhci \
	-device usb-kbd \
	-device virtio-net-pci,netdev=net0 \
	-netdev user,id=net0 \
	-device riscv.cbqri.capacity,max_mcids=256,max_rcids=64,ncblks=12,alloc_op_flush_rcid=false,mon_op_config_event=false,mon_op_read_counter=false,mon_evt_id_none=false,mon_evt_id_occupancy=false,mmio_base=0x04820000 \
	-device riscv.cbqri.capacity,max_mcids=256,max_rcids=64,ncblks=12,alloc_op_flush_rcid=false,mon_op_config_event=false,mon_op_read_counter=false,mon_evt_id_none=false,mon_evt_id_occupancy=false,mmio_base=0x04821000 \
	-device riscv.cbqri.capacity,max_mcids=256,max_rcids=64,ncblks=16,mmio_base=0x0482B000 \
	-device riscv.cbqri.bandwidth,max_mcids=256,max_rcids=64,nbwblks=1024,mrbwb=819,mmio_base=0x04828000 \
	-device riscv.cbqri.bandwidth,max_mcids=256,max_rcids=64,nbwblks=1024,mrbwb=819,mmio_base=0x04829000 \
	-device riscv.cbqri.bandwidth,max_mcids=256,max_rcids=64,nbwblks=1024,mrbwb=819,mmio_base=0x0482a000

Versions
--------
Changes in v2:
 - Add support for ACPI RQSC table which provides the details needed to
   discover the CBQRI controllers and support resctrl
 - Drop the "not for upstream" platform drivers and qemu dts patches.
   Those can be found in v1 and were only for the RFC series. The 
   branch for the v1 series is preserved as ssqosid-cbqri-rfc-v1
 - Change cbqri_wait_busy_flag() from 100 ms to 1 ms to avoid
   unnecessary latency.
 - Change resctrl_arch_get_config() to return resctrl_get_default_ctrl()
   instead of a negative errno value which is not valid for u32.
 - Change cbqri_probe_controller() to return -EBUSY when
   request_mem_region() fails
 - Change resctrl_arch_get_config() to now longer increment when rbwb
   modulo ctrl->bc.nbwblks is true
 - Fix indentation in cbqri_set_cbm(), cbqri_set_rbwb() and
   cbqri_get_rbwb().
 - Link to v1: https://lore.kernel.org/r/20260119-ssqosid-cbqri-v1-0-aa2a75153832@kernel.org

Older related series for reference:

 [RFC PATCH 00/21] RISC-V: QoS: add CBQRI resctrl interface
 https://lore.kernel.org/all/20230419111111.477118-1-dfustini@baylibre.com/
 The original RFC from the CBQRI proof-of-concept in 2023 that worked
 in conjunction with the Qemu patch series for the proof-of-concept.

 [PATCH v4 0/3] RISC-V: Detect Ssqosid extension and handle srmcfg CSR
 https://lore.kernel.org/all/20251007-ssqosid-v4-0-e8b57e59d812@kernel.org/
 More recently I thought it would be simpler to upstream just the
 Ssqosid patches first. However, I got feedback that it was hard to
 review without the CBQRI patches in the same series.

Open issues:
------------
 - Checkpatch false positive: there is a checkpatch warning about
   "Argument '__next' is not used in function-like macro"
   - __switch_to_srmcfg(__next) is needed to avoid the error reported
     by LKP for riscv-allnoconfig:
     https://lore.kernel.org/oe-kbuild-all/202509162355.wByessnb-lkp@intel.com/
   - __switch_to_srmcfg() will trigger a build error in clang when
     CONFIG_RISCV_ISA_SSQOSID is turned off.

 - The number of CBQRI controllers is hard coded
   - This was done as a simple approach in the proof-of-concept as there
     were 6 controllers
   - I need to refactor this so that it is dynamically allocated based
     on the number of controllers present in the system

 - Refactor or eliminate find_acpi_cache_from_id()
   - find_acpi_cache_from_id is based on find_acpi_cache_level_from_id
     in commit c4170570cc7f ("ACPI / PPTT: Find PPTT cache level by ID")
     from the morse/mpam/snapshot/v6.14-rc1 branch.
   - The version that of find_acpi_cache_level_from_id() that landed
     upstream has changed so find_acpi_cache_from_id() needs to be
     updated if it is going to remain in this patch series.
   - However, there may be a simpler way for acpi_parse_rqsc() to get a
     pointer to acpi_pptt_cache.

 - No L2 and L3 cache occupancy monitoring
   - This is not currently implemented and I have to decided to leave
     it as an enhancement for a future series after the Ssqosid and
     CBQRI core are merged.

 - No MBM (bandwidth monitoring)
   - MBA schema works ok for the CBQRI-enabled memory controllers, but
     resctrl does not currently have solution for representing MBM for
     bandwidth resources that are not associated with a L3 cache.
   - For the old CBQRI proof-of-concept RFC, two separate domains were
     created for each memory controller: one for MB (allocation) and one
     for MBM (monitoring).
   - The monitoring domains had to pretend that these memory controllers
     were L3 caches which is not the case. I have removed this as it was
     too complicated and not the right solution.
   - There is active discussion about allowing different scopes for
     resources which I think would solve this problem:
     https://lore.kernel.org/all/aXUK7XFsHl+gnwA%2F@x1/

---
Drew Fustini (17):
      dt-bindings: riscv: Add Ssqosid extension description
      RISC-V: Detect the Ssqosid extension
      RISC-V: Add support for srmcfg CSR from Ssqosid ext
      RISC-V: QoS: define properties of CBQRI controllers
      RISC-V: QoS: define CBQRI capacity and bandwidth capabilities
      RISC-V: QoS: define CBQRI resctrl resources and domains
      RISC-V: QoS: define prototypes for resctrl interface
      RISC-V: QoS: add resctrl interface for CBQRI controllers
      RISC-V: QoS: expose implementation to resctrl
      RISC-V: QoS: add late_initcall to setup resctrl interface
      RISC-V: QoS: add to build when CONFIG_RISCV_ISA_SSQOSID set
      RISC-V: QoS: make CONFIG_RISCV_ISA_SSQOSID select resctrl
      acpi: pptt: Add helper to find a cache from id
      include: acpi: actbl2: Add structs for RQSC table
      RISC-V: QoS: add Cache ID and Prox Dom to CBQRI controllers
      acpi: riscv: Parse RISC-V Quality of Service Controller (RQSC) table
      acpi: riscv: Add support for RISC-V Quality of Service Controller (RQSC)

 .../devicetree/bindings/riscv/extensions.yaml      |    6 +
 MAINTAINERS                                        |   10 +
 arch/riscv/Kconfig                                 |   20 +
 arch/riscv/include/asm/acpi.h                      |   10 +
 arch/riscv/include/asm/csr.h                       |    8 +
 arch/riscv/include/asm/hwcap.h                     |    1 +
 arch/riscv/include/asm/processor.h                 |    3 +
 arch/riscv/include/asm/qos.h                       |   41 +
 arch/riscv/include/asm/resctrl.h                   |    2 +
 arch/riscv/include/asm/switch_to.h                 |    3 +
 arch/riscv/kernel/Makefile                         |    2 +
 arch/riscv/kernel/cpufeature.c                     |    1 +
 arch/riscv/kernel/qos/Makefile                     |    2 +
 arch/riscv/kernel/qos/internal.h                   |  155 +++
 arch/riscv/kernel/qos/qos.c                        |   32 +
 arch/riscv/kernel/qos/qos_resctrl.c                | 1192 ++++++++++++++++++++
 drivers/acpi/pptt.c                                |   63 ++
 drivers/acpi/riscv/Makefile                        |    2 +-
 drivers/acpi/riscv/init.c                          |   19 +
 drivers/acpi/riscv/rqsc.c                          |  112 ++
 include/acpi/actbl2.h                              |   92 ++
 include/linux/acpi.h                               |    8 +
 include/linux/riscv_qos.h                          |   85 ++
 23 files changed, 1868 insertions(+), 1 deletion(-)
---
base-commit: 9ace4753a5202b02191d54e9fdf7f9e3d02b85eb
change-id: 20260112-ssqosid-cbqri-407cfcda9ff4

Best regards,
-- 
Drew Fustini <fustini@kernel.org>


