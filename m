Return-Path: <linux-acpi+bounces-11025-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C478A31226
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 17:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58AA0188202F
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 16:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E8E260A21;
	Tue, 11 Feb 2025 16:56:01 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87D325291B;
	Tue, 11 Feb 2025 16:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739292961; cv=none; b=OmA9L7b6gaWNrjm3XZFw/32vGSfEXqEg+mKkKGSNmoWh0j+2GM3xtXIjIL2qj8y8BDCX1sNkYURTDOP3kPQhAp5BOTKIhztScDZzBd85o/YU/iMkMXQdk2m2sPjscDJxcBMRrD5F0+Rc7v1vnEuoUGlJux1U/HUyzyA/cs5MpGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739292961; c=relaxed/simple;
	bh=yyn719VaAyIMcUMTWTNmPXbCFPVkN+95ZQVcRv+ZUfM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j1CWIq4qXKtn1ymwPwlteaP7qWgoPfAIo88iDn/16ZP8Qzi1fJx5AULQ+athkONRBtJgEnZpeGZU1SNoBPxJbuUiYxNeMakieXo7ZzDecd9T1NmZ5krhuRlwAScMyZ6L+yvc0vK/9F7K72nY2/rqUO5JWfB0cd1+RMYSkcdaK74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YsnYw2HZNz6L54D;
	Wed, 12 Feb 2025 00:52:52 +0800 (CST)
Received: from frapeml100006.china.huawei.com (unknown [7.182.85.201])
	by mail.maildlp.com (Postfix) with ESMTPS id BB3081400DD;
	Wed, 12 Feb 2025 00:55:49 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100006.china.huawei.com (7.182.85.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Feb 2025 17:55:49 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Tue, 11 Feb 2025 17:55:49 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Fan Ni <nifan.cxl@gmail.com>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"tony.luck@intel.com" <tony.luck@intel.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"Jonathan Cameron" <jonathan.cameron@huawei.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"david@redhat.com" <david@redhat.com>, "Vilas.Sridharan@amd.com"
	<Vilas.Sridharan@amd.com>, "leo.duran@amd.com" <leo.duran@amd.com>,
	"Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>, "rientjes@google.com"
	<rientjes@google.com>, "jiaqiyan@google.com" <jiaqiyan@google.com>,
	"Jon.Grimm@amd.com" <Jon.Grimm@amd.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "naoya.horiguchi@nec.com"
	<naoya.horiguchi@nec.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"jthoughton@google.com" <jthoughton@google.com>, "somasundaram.a@hpe.com"
	<somasundaram.a@hpe.com>, "erdemaktas@google.com" <erdemaktas@google.com>,
	"pgonda@google.com" <pgonda@google.com>, "duenwen@google.com"
	<duenwen@google.com>, "gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>, "Roberto
 Sassu" <roberto.sassu@huawei.com>, "kangkang.shen@futurewei.com"
	<kangkang.shen@futurewei.com>, wanghuiqiang <wanghuiqiang@huawei.com>,
	Linuxarm <linuxarm@huawei.com>, "a.manzanares@samsung.com"
	<a.manzanares@samsung.com>, "nmtadam.samsung@gmail.com"
	<nmtadam.samsung@gmail.com>, "anisa.su887@gmail.com" <anisa.su887@gmail.com>
Subject: RE: [PATCH v19 00/15] EDAC: Scrub: introduce generic EDAC RAS control
 feature driver + CXL/ACPI-RAS2 drivers
Thread-Topic: [PATCH v19 00/15] EDAC: Scrub: introduce generic EDAC RAS
 control feature driver + CXL/ACPI-RAS2 drivers
Thread-Index: AQHbeW7q+yAlb0l8b0m3xpFA4TlX9rNAxY6AgAF8IfA=
Date: Tue, 11 Feb 2025 16:55:49 +0000
Message-ID: <c2fe65c81ab4484f977f5938a3278036@huawei.com>
References: <20250207144445.1879-1-shiju.jose@huawei.com>
 <Z6o87wa-tabDy34V@fan>
In-Reply-To: <Z6o87wa-tabDy34V@fan>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

>-----Original Message-----
>From: Fan Ni <nifan.cxl@gmail.com>
>Sent: 10 February 2025 17:53
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: linux-edac@vger.kernel.org; linux-cxl@vger.kernel.org; linux-
>acpi@vger.kernel.org; linux-mm@kvack.org; linux-kernel@vger.kernel.org;
>linux-doc@vger.kernel.org; bp@alien8.de; tony.luck@intel.com;
>rafael@kernel.org; lenb@kernel.org; mchehab@kernel.org;
>dan.j.williams@intel.com; dave@stgolabs.net; Jonathan Cameron
><jonathan.cameron@huawei.com>; dave.jiang@intel.com;
>alison.schofield@intel.com; vishal.l.verma@intel.com; ira.weiny@intel.com;
>david@redhat.com; Vilas.Sridharan@amd.com; leo.duran@amd.com;
>Yazen.Ghannam@amd.com; rientjes@google.com; jiaqiyan@google.com;
>Jon.Grimm@amd.com; dave.hansen@linux.intel.com;
>naoya.horiguchi@nec.com; james.morse@arm.com; jthoughton@google.com;
>somasundaram.a@hpe.com; erdemaktas@google.com; pgonda@google.com;
>duenwen@google.com; gthelen@google.com;
>wschwartz@amperecomputing.com; dferguson@amperecomputing.com;
>wbs@os.amperecomputing.com; nifan.cxl@gmail.com; tanxiaofei
><tanxiaofei@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>; Roberto
>Sassu <roberto.sassu@huawei.com>; kangkang.shen@futurewei.com;
>wanghuiqiang <wanghuiqiang@huawei.com>; Linuxarm
><linuxarm@huawei.com>; a.manzanares@samsung.com;
>nmtadam.samsung@gmail.com; anisa.su887@gmail.com
>Subject: Re: [PATCH v19 00/15] EDAC: Scrub: introduce generic EDAC RAS
>control feature driver + CXL/ACPI-RAS2 drivers
>
>On Fri, Feb 07, 2025 at 02:44:29PM +0000, shiju.jose@huawei.com wrote:
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> The CXL patches of this series has dependency on Dave's CXL fwctl
>> series [1].
>>
>> The code is based on v3 of CXL fwctl series [1] posted by Dave and
>> v3 of FWCTL series [2] posted by Jason and rebased on top of
>> v6.14-rc1.
>>
>> [1]:
>> https://lore.kernel.org/linux-cxl/20250204220430.4146187-1-dave.jiang@
>> intel.com/
>> [2]:
>> https://lore.kernel.org/linux-cxl/0-v3-960f17f90f17+516-fwctl_jgg@nvid
>> ia.com/#r
>>
>>
>> Userspace code for CXL memory repair features [3] and sample
>> boot-script for CXL memory repair [4].
>>
>> [3]:
>> https://lore.kernel.org/lkml/20250207143028.1865-1-shiju.jose@huawei.c
>> om/
>> [4]:
>> https://lore.kernel.org/lkml/20250207143028.1865-5-shiju.jose@huawei.c
>> om/
>>
>
>Hi Shiju,
>Is this series the same as in branch
>https://github.com/shijujose4/linux/tree/edac-enhancement-ras-features_v19=
?
>
>I hit some compile errors wen trying to test with the above branch directl=
y.
>
>Here are two cases where I found the code cannot compile. Please check if =
it is a
>false alarm.
>
>Case 1: CONFIG_CXL_RAS_FEATURES=3Dm
>
>fan:~/cxl/linux-edac$ cat .config | egrep -i "edac|cxl|ras" | grep -v "^#"
>CONFIG_ACPI_RAS2=3Dy
>CONFIG_ACPI_APEI_EINJ_CXL=3Dy
>CONFIG_PCIEAER_CXL=3Dy
>CONFIG_CXL_BUS=3Dy
>CONFIG_CXL_PCI=3Dy
>CONFIG_CXL_MEM_RAW_COMMANDS=3Dy
>CONFIG_CXL_ACPI=3Dy
>CONFIG_CXL_PMEM=3Dy
>CONFIG_CXL_MEM=3Dy
>CONFIG_CXL_FWCTL=3Dy
>CONFIG_CXL_PORT=3Dy
>CONFIG_CXL_SUSPEND=3Dy
>CONFIG_CXL_REGION=3Dy
>CONFIG_CXL_REGION_INVALIDATION_TEST=3Dy
>CONFIG_CXL_RAS_FEATURES=3Dm
>CONFIG_MMC_SDHCI_OF_ARASAN=3Dy
>CONFIG_EDAC_ATOMIC_SCRUB=3Dy
>CONFIG_EDAC_SUPPORT=3Dy
>CONFIG_EDAC=3Dy
>CONFIG_EDAC_LEGACY_SYSFS=3Dy
>CONFIG_EDAC_DEBUG=3Dy
>CONFIG_EDAC_DECODE_MCE=3Dm
>CONFIG_EDAC_GHES=3Dm
>CONFIG_EDAC_SCRUB=3Dy
>CONFIG_EDAC_ECS=3Dy
>CONFIG_EDAC_MEM_REPAIR=3Dy
>CONFIG_EDAC_IGEN6=3Dm
>CONFIG_RAS=3Dy
>CONFIG_MEM_ACPI_RAS2=3Dy
>CONFIG_DEV_DAX_CXL=3Dm
>fan:~/cxl/linux-edac$
>
>
>fan:~/cxl/linux-edac$ make -j16
>mkdir -p /home/fan/cxl/linux-edac/tools/objtool && make
>O=3D/home/fan/cxl/linux-edac subdir=3Dtools/objtool --no-print-directory -=
C objtool
>  CALL    scripts/checksyscalls.sh
>  INSTALL libsubcmd_headers
>  UPD     include/generated/utsversion.h
>  CC      init/version-timestamp.o
>  KSYMS   .tmp_vmlinux0.kallsyms.S
>  AS      .tmp_vmlinux0.kallsyms.o
>  LD      .tmp_vmlinux1
>ld: vmlinux.o: in function `cxl_region_probe':
>/home/fan/cxl/linux-edac/drivers/cxl/core/region.c:3456:(.text+0x7b296f):
>undefined reference to `devm_cxl_region_edac_register'
>ld: vmlinux.o: in function `cxl_mem_probe':
>/home/fan/cxl/linux-edac/drivers/cxl/mem.c:188:(.text+0x7b8ad1): undefined
>reference to `devm_cxl_memdev_edac_register'
>make[2]: *** [scripts/Makefile.vmlinux:77: vmlinux] Error 1
>make[1]: *** [/home/fan/cxl/linux-edac/Makefile:1226: vmlinux] Error 2
>make: *** [Makefile:251: __sub-make] Error 2
>
>When compile with CONFIG_CXL_RAS_FEATURES=3Dy,  it can compile.
>
Hi Fan,

Thanks for checking this and reporting.

This error is with CONFIG_CXL_RAS_FEATURES=3Dm and CONFIG_CXL_BUS=3Dy and C=
ONFIG_CXL_MEM=3Dy.
Now changed  CONFIG_CXL_RAS_FEATURES  for tristate -> boolean as this imple=
mented only interface functions
for the CXL RAS features.
>
>CASE 2: CONFIG_EDAC=3Dm
>
>fan:~/cxl/linux-edac$ cat .config | egrep -i "edac|cxl|ras" | grep -v "^#"
>CONFIG_CRASH_RESERVE=3Dy
>CONFIG_CRASH_DUMP=3Dy
>CONFIG_CRASH_HOTPLUG=3Dy
>CONFIG_CRASH_MAX_MEMORY_RANGES=3D8192
>CONFIG_ARCH_SUPPORTS_CRASH_DUMP=3Dy
>CONFIG_ARCH_DEFAULT_CRASH_DUMP=3Dy
>CONFIG_ARCH_SUPPORTS_CRASH_HOTPLUG=3Dy
>CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION=3Dy
>CONFIG_ACPI_RAS2=3Dy
>CONFIG_ACPI_APEI_EINJ_CXL=3Dy
>CONFIG_PCIEAER_CXL=3Dy
>CONFIG_CXL_BUS=3Dy
>CONFIG_CXL_PCI=3Dy
>CONFIG_CXL_MEM_RAW_COMMANDS=3Dy
>CONFIG_CXL_ACPI=3Dy
>CONFIG_CXL_PMEM=3Dy
>CONFIG_CXL_MEM=3Dy
>CONFIG_CXL_FWCTL=3Dy
>CONFIG_CXL_PORT=3Dy
>CONFIG_CXL_SUSPEND=3Dy
>CONFIG_CXL_REGION=3Dy
>CONFIG_CXL_REGION_INVALIDATION_TEST=3Dy
>CONFIG_CXL_RAS_FEATURES=3Dy
>CONFIG_MMC_SDHCI_OF_ARASAN=3Dy
>CONFIG_EDAC_ATOMIC_SCRUB=3Dy
>CONFIG_EDAC_SUPPORT=3Dy
>CONFIG_EDAC=3Dm
>CONFIG_EDAC_LEGACY_SYSFS=3Dy
>CONFIG_EDAC_DEBUG=3Dy
>CONFIG_EDAC_DECODE_MCE=3Dm
>CONFIG_EDAC_GHES=3Dm
>CONFIG_EDAC_SCRUB=3Dy
>CONFIG_EDAC_ECS=3Dy
>CONFIG_EDAC_MEM_REPAIR=3Dy
>CONFIG_EDAC_IGEN6=3Dm
>CONFIG_RAS=3Dy
>CONFIG_MEM_ACPI_RAS2=3Dy
>CONFIG_DEV_DAX_CXL=3Dm
>fan:~/cxl/linux-edac$
>
>fan:~/cxl/linux-edac$ make -j16
>mkdir -p /home/fan/cxl/linux-edac/tools/objtool && make
>O=3D/home/fan/cxl/linux-edac subdir=3Dtools/objtool --no-print-directory -=
C objtool
>  CALL    scripts/checksyscalls.sh
>  INSTALL libsubcmd_headers
>  UPD     include/generated/utsversion.h
>  CC      init/version-timestamp.o
>  KSYMS   .tmp_vmlinux0.kallsyms.S
>  AS      .tmp_vmlinux0.kallsyms.o
>  LD      .tmp_vmlinux1
>ld: vmlinux.o: in function `devm_cxl_region_edac_register':
>/home/fan/cxl/linux-
>edac/drivers/cxl/core/memfeature.c:1720:(.text+0x7b665d): undefined
>reference to `edac_dev_register'
>ld: vmlinux.o: in function `devm_cxl_memdev_edac_register':
>/home/fan/cxl/linux-
>edac/drivers/cxl/core/memfeature.c:1697:(.text+0x7b7241): undefined
>reference to `edac_dev_register'
>ld: vmlinux.o: in function `ras2_probe':
>/home/fan/cxl/linux-edac/drivers/ras/acpi_ras2.c:363:(.text+0xb0ecc8):
>undefined reference to `edac_dev_register'
>make[2]: *** [scripts/Makefile.vmlinux:77: vmlinux] Error 1
>make[1]: *** [/home/fan/cxl/linux-edac/Makefile:1226: vmlinux] Error 2
>make: *** [Makefile:251: __sub-make] Error 2
>

Here the symbol 'edac_dev_register' can't find with CONFIG_CXL_BUS=3Dy  CON=
FIG_CXL_RAS_FEATURES=3Dy and=20
CONFIG_EDAC=3Dm.
Modified CXL_RAS_FEATURES depends on EDAC=3Dy || (CXL_BUS=3Dm && EDAC=3Dm)
to fix this.
>
>
>Fan
>
>
Thanks,
Shiju

