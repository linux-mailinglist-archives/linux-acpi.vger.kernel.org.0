Return-Path: <linux-acpi+bounces-19110-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 602BCC6F91E
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 16:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B14E33A8536
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 15:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53132BF013;
	Wed, 19 Nov 2025 15:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="N5VzLaVO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDD22BE7AB;
	Wed, 19 Nov 2025 15:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763564529; cv=none; b=ijzkJlcKaEbs7KvTb2sUCRKGqKjw+CMNnI9qkLwU/A3YRCudG/WF5kR5EIaC6fhL/10J0aHxtIIkbw7Nuctyus1atCmhgDrYLfdmcL9iAOCein/7D3TCiSglX36U7txJqZGfEqRrk60BgYUjv43n8by1B8LUNKMgymA8/mXpp8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763564529; c=relaxed/simple;
	bh=gRp5/3d9NvnCg2hGlZcBbdcLFO2/q/rhW13mW8QrF60=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WtwfNiULcMSXZP/ouLGa1QBc5pH0brcCYYe8O2Kaladc8PjLf8N4zR9JwOM0vhzcsL5LNa7rThQlXinienbCGJAbxNdgcAPQxpqa7q92K9SNI3VcJI+CbUP6TvNHH8oupTKrbJzlvbT+6hUX40qM41UEH5LvUwEQz5Ng1Bblu4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=N5VzLaVO; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AJ5MSqZ943860;
	Wed, 19 Nov 2025 07:00:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=VhdIfvEDesky1RmUVf6fLwf
	tIfEDMfwtUnUeNnQL1Kg=; b=N5VzLaVOndpfLDLpc1EZ+FQCb6kUqayt1Qw/62j
	fwEgI9j8dztiqkulmwlOl2wpYZZiNGKfPQu9fSp+aBxv9lZAquNLD+ksCWVXJtGi
	x3blFQWwd+CHTYwbCGTl9BRWz+9KoF52H5Aixkbokb/hf6UQI0WapVSEmlzFPO+B
	Jt1+4GI4kF943qEqdIXMHcAxBH8+Eby4PFEY5HiGCsivKGOaD2h2goRmIeusMof0
	6mSXGvq5qTn/vcQBRUhGrftnpuZqs0fU3lfdqHJGgkjRCd5dqN2yXrt3bw+G/wTE
	b6zMMeQ2SOwc3fKRSIPwQQDUXlJpE1pRfpLQxn25FEDbtPg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ag8fs58dk-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 07:00:29 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 19 Nov 2025 07:00:38 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 19 Nov 2025 07:00:38 -0800
Received: from marvell-OptiPlex-7090 (unknown [10.28.36.167])
	by maili.marvell.com (Postfix) with ESMTP id 74A015B6956;
	Wed, 19 Nov 2025 07:00:18 -0800 (PST)
Date: Wed, 19 Nov 2025 20:30:17 +0530
From: Amit Singh Tomar <amitsinght@marvell.com>
To: Ben Horgan <ben.horgan@arm.com>
CC: <james.morse@arm.com>, <baisheng.gao@unisoc.com>,
        <baolin.wang@linux.alibaba.com>, <bobo.shaobowang@huawei.com>,
        <carl@os.amperecomputing.com>, <catalin.marinas@arm.com>,
        <dakr@kernel.org>, <dave.martin@arm.com>, <david@redhat.com>,
        <dfustini@baylibre.com>, <fenghuay@nvidia.com>,
        <gregkh@linuxfoundation.org>, <gshan@redhat.com>,
        <guohanjun@huawei.com>, <jeremy.linton@arm.com>,
        <jonathan.cameron@huawei.com>, <kobak@nvidia.com>,
        <lcherian@marvell.com>, <lenb@kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <lpieralisi@kernel.org>,
        <peternewman@google.com>, <quic_jiles@quicinc.com>,
        <rafael@kernel.org>, <robh@kernel.org>, <rohit.mathew@arm.com>,
        <scott@os.amperecomputing.com>, <sdonthineni@nvidia.com>,
        <sudeep.holla@arm.com>, <tan.shaopeng@fujitsu.com>, <will@kernel.org>,
        <xhao@linux.alibaba.com>, <reinette.chatre@intel.com>
Subject: Re: [PATCH v6 00/34] arm_mpam: Add basic mpam driver
Message-ID: <20251119150017.GA3900937@marvell-OptiPlex-7090>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=D7ZK6/Rj c=1 sm=1 tr=0 ts=691ddb8d cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=JwYGXQUTteuCLpoJtHYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: xeEAGrLd4oRR7gL-heMeUoQXSQKwl0Zi
X-Proofpoint-GUID: xeEAGrLd4oRR7gL-heMeUoQXSQKwl0Zi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDEyMCBTYWx0ZWRfX2bKDNW7p/yTK
 MHh4AGF394Sz/QHQvDPPEpjUbeJj8m8Cwlu4FD8wUIWllrczZUtLgUqA3HO3laRAib9DZXuN+Hw
 udSSweIXWnHzrH52JCsvhoEKDJccFmAhKEj7RyDX0VI6mv9QTOmgv5OyV/GS1bppTR7YGfTFxdD
 0qdz4Foob7fdAAmaZOs79GF1FUUR/Z2n8QnsKx8kViJykhHA9tVibShRyZSWT/BkhBdO+CU2Im4
 pTFqfpXHvALbif0JV857Ha+duI0HYIwavtDxzjmDJpuwb0/ZVT5vkljQsJxS4nT9mZ8vHu1s5tC
 y6vJDd4KZF2JdYIwB+kGuMRjhSqkpKsO6uMAUGwXLMI42tBRDUf79+YaJazz61pnh+vCFm0znHq
 QZoc1t86z+0/XP8WOvMMDBCdCpCnqA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_04,2025-11-18_02,2025-10-01_01

Hi Ben,

On 2025-11-19 at 17:52:30, Ben Horgan (ben.horgan@arm.com) wrote:
> Hi all,
> 
> Just a handful of minor changes based on v5 review comments. See individual
> patches for change lgos. I haven't asked James to host any branches for this
> revision but please let me know if this would be helpful to anyone. Thanks for
> all the help with reviews and testing.
> 
> Previous cover letter from James:
> 
> This is just enough MPAM driver for ACPI. DT got ripped out. If you need DT
> support - please share your DTS so the DT folk know the binding is what is
> needed.
> This doesn't contain any of the resctrl code, meaning you can't actually drive it
> from user-space yet. Because of that, its hidden behind CONFIG_EXPERT.
> This will change once the user interface is connected up.
> 
> This is the initial group of patches that allows the resctrl code to be built
> on top. Including that will increase the number of trees that may need to
> coordinate, so breaking it up make sense.
> 
> The locking got simplified, but is still strange - this is because of the 'mpam-fb'
> firmware interface specification that is still alpha. That thing needs to wait for
> an interrupt after every system register write, which significantly impacts the
> driver. Some features just won't work, e.g. reading the monitor registers via
> perf.
> 
> I've not found a platform that can test all the behaviours around the monitors,
> so this is where I'd expect the most bugs.
> 
> The MPAM spec that describes all the system and MMIO registers can be found here:
> https://developer.arm.com/documentation/ddi0598/db/?lang=en
> (Ignored the 'RETIRED' warning - that is just arm moving the documentation around.
>  This document has the best overview)
> 
> The expectation is this will go via the arm64 tree.
> 
> This series is based on v6.18-rc4, and can be retrieved from: (no v6 version)
> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/driver/v5
> 
> The rest of the driver can be found here: (no v6 version)
> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/snapshot/v6.18-rc4-v5

Booted it on the MARVELL OCTEON 10 platform, and confirmed that MPAM is enabled properly with:

~ # dmesg | grep -i mpam
[    0.000000] ACPI: MPAM 0x0000000BF826FA98 0002C4 (v01 MRVL   CN106    00000001 MRVL 00000001)
[    8.868206] MPAM enabled with 64 PARTIDs and 1 PMGs

Tested-by: Amit Singh Tomar <amitsinght@marvell.com>

However, while testing DDR bandwidth partitioning (based on mpam/snapshot/v6.18-rc4-v5),
seeing behaviour that doesn’t look consistent with how MPAMCFG_MBW_MIN and
MPAMCFG_MBW_MAX should relate.

For instance, when assigning 10% BW to a partition, the value programmed into
MPAMCFG_MBW_MIN ends up higher than the value in MPAMCFG_MBW_MAX. But MBW_MIN
should always be lower than MBW_MAX, correct? If not, the MPAM resctrl side
likely needs a fix?

~ # cat > bw.sh
mount -t resctrl resctrl /sys/fs/resctrl
cd /sys/fs/resctrl
mkdir p1
cd p1
echo fff > cpus
echo "MB:1=10" > schemata

^C
~ # chmod +x bw.sh
~ # ./bw.sh
~ #  devmem MPAMCFG_MBW_MAX 32
0x00001900
~ # devmem MPAMCFG_MBW_MIN 32
0x0000F200

> 
> What is MPAM? Set your time-machine to 2020:
> https://lore.kernel.org/lkml/20201030161120.227225-1-james.morse@arm.com/
> 
> Ben Horgan (5):
>   ACPI / PPTT: Add acpi_pptt_cache_v1_full to use pptt cache as one
>     structure
>   platform: Define platform_device_put cleanup handler
>   ACPI: Define acpi_put_table cleanup handler and
>     acpi_get_table_pointer() helper
>   arm_mpam: Consider overflow in bandwidth counter state
>   MAINTAINERS: new entry for MPAM Driver
> 
> James Morse (27):
>   ACPI / PPTT: Add a helper to fill a cpumask from a processor container
>   ACPI / PPTT: Stop acpi_count_levels() expecting callers to clear
>     levels
>   ACPI / PPTT: Find cache level by cache-id
>   ACPI / PPTT: Add a helper to fill a cpumask from a cache_id
>   arm64: kconfig: Add Kconfig entry for MPAM
>   ACPI / MPAM: Parse the MPAM table
>   arm_mpam: Add probe/remove for mpam msc driver and kbuild boiler plate
>   arm_mpam: Add the class and component structures for firmware
>     described ris
>   arm_mpam: Add MPAM MSC register layout definitions
>   arm_mpam: Add cpuhp callbacks to probe MSC hardware
>   arm_mpam: Probe hardware to find the supported partid/pmg values
>   arm_mpam: Add helpers for managing the locking around the mon_sel
>     registers
>   arm_mpam: Probe the hardware features resctrl supports
>   arm_mpam: Merge supported features during mpam_enable() into
>     mpam_class
>   arm_mpam: Reset MSC controls from cpuhp callbacks
>   arm_mpam: Add a helper to touch an MSC from any CPU
>   arm_mpam: Extend reset logic to allow devices to be reset any time
>   arm_mpam: Register and enable IRQs
>   arm_mpam: Use a static key to indicate when mpam is enabled
>   arm_mpam: Allow configuration to be applied and restored during cpu
>     online
>   arm_mpam: Probe and reset the rest of the features
>   arm_mpam: Add helpers to allocate monitors
>   arm_mpam: Add mpam_msmon_read() to read monitor value
>   arm_mpam: Track bandwidth counter state for power management
>   arm_mpam: Add helper to reset saved mbwu state
>   arm_mpam: Add kunit test for bitmap reset
>   arm_mpam: Add kunit tests for props_mismatch()
> 
> Rohit Mathew (2):
>   arm_mpam: Probe for long/lwd mbwu counters
>   arm_mpam: Use long MBWU counters if supported
> 
>  MAINTAINERS                         |   10 +
>  arch/arm64/Kconfig                  |   25 +
>  drivers/Kconfig                     |    2 +
>  drivers/Makefile                    |    1 +
>  drivers/acpi/arm64/Kconfig          |    3 +
>  drivers/acpi/arm64/Makefile         |    1 +
>  drivers/acpi/arm64/mpam.c           |  411 ++++
>  drivers/acpi/pptt.c                 |  280 ++-
>  drivers/acpi/tables.c               |    2 +-
>  drivers/resctrl/Kconfig             |   24 +
>  drivers/resctrl/Makefile            |    4 +
>  drivers/resctrl/mpam_devices.c      | 2723 +++++++++++++++++++++++++++
>  drivers/resctrl/mpam_internal.h     |  658 +++++++
>  drivers/resctrl/test_mpam_devices.c |  389 ++++
>  include/linux/acpi.h                |   26 +
>  include/linux/arm_mpam.h            |   66 +
>  include/linux/platform_device.h     |    1 +
>  17 files changed, 4608 insertions(+), 18 deletions(-)
>  create mode 100644 drivers/acpi/arm64/mpam.c
>  create mode 100644 drivers/resctrl/Kconfig
>  create mode 100644 drivers/resctrl/Makefile
>  create mode 100644 drivers/resctrl/mpam_devices.c
>  create mode 100644 drivers/resctrl/mpam_internal.h
>  create mode 100644 drivers/resctrl/test_mpam_devices.c
>  create mode 100644 include/linux/arm_mpam.h
> 
> -- 
> 2.43.0
> 

