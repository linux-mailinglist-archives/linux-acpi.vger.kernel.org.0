Return-Path: <linux-acpi+bounces-12178-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AFFA5F01B
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 10:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8206169DFE
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 09:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7504B265607;
	Thu, 13 Mar 2025 09:59:21 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64234264F9A;
	Thu, 13 Mar 2025 09:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741859961; cv=none; b=hTnw6YiGocEYotwVc41fE5rUwOJ5zfhybFoBOxZmmMtCioc6fmPtvYUl8A72Jmb7Eh6yts/2iHraa0ngtJaXBDgOP6SiFADve7RSeekSjad6omIcBTprjmIqH1XA9/3W0Igi05i9Q0bpZkRtZ7kQ+FoIXSkU6cSM/8TIaqaQVa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741859961; c=relaxed/simple;
	bh=pyKfBjqDAN4P+9rSQW/SVJRyKIFw6ExLmm2iZO2gyuA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PpF4TQRg5Y1+aNdsRzX9sFWic6lS1MGqv4vOuaRJAA4TXLaK8ophALDPngDaapcDrcuwkaGEMA6tNjd6+2CoY0qMZgAVi+EqtpnzFZu5Ff7LKMfPHUtsRdnZixyw1AaZJlp3GGO9noAfRoYLrDD6I9c8Va6sZhGU8TZP54qfzgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZD2vC6gdJz6H8fC;
	Thu, 13 Mar 2025 17:56:07 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7BF471403A2;
	Thu, 13 Mar 2025 17:59:17 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 13 Mar
 2025 10:59:16 +0100
Date: Thu, 13 Mar 2025 09:59:15 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <robert.moore@intel.com>,
	<dan.j.williams@intel.com>, <Benjamin.Cheatham@amd.com>,
	<Avadhut.Naik@amd.com>, <viro@zeniv.linux.org.uk>, <arnd@arndb.de>,
	<ira.weiny@intel.com>, <dave.jiang@intel.com>,
	<sthanneeru.opensrc@micron.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <acpica-devel@lists.linux.dev>
Subject: Re: [PATCH v4 9/9] ACPI: APEI: EINJ: Update the documentation for
 EINJv2 support
Message-ID: <20250313095915.00000847@huawei.com>
In-Reply-To: <20250306234810.75511-10-zaidal@os.amperecomputing.com>
References: <20250306234810.75511-1-zaidal@os.amperecomputing.com>
	<20250306234810.75511-10-zaidal@os.amperecomputing.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu,  6 Mar 2025 15:48:10 -0800
Zaid Alali <zaidal@os.amperecomputing.com> wrote:

> Add documentation for the updated ACPI specs for EINJv2(1)(2)
> 
> (1)https://bugzilla.tianocore.org/show_bug.cgi?id=4615
> (2)https://bugzilla.tianocore.org/attachment.cgi?id=1446
> 
> Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
> ---
>  .../firmware-guide/acpi/apei/einj.rst         | 41 ++++++++++++++++++-
>  1 file changed, 39 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/firmware-guide/acpi/apei/einj.rst b/Documentation/firmware-guide/acpi/apei/einj.rst
> index c52b9da08fa9..31c848183af0 100644
> --- a/Documentation/firmware-guide/acpi/apei/einj.rst
> +++ b/Documentation/firmware-guide/acpi/apei/einj.rst
> @@ -59,6 +59,9 @@ The following files belong to it:
>    0x00000200        Platform Correctable
>    0x00000400        Platform Uncorrectable non-fatal
>    0x00000800        Platform Uncorrectable fatal
> +  V2_0x00000001     EINJV2 Processor Error
> +  V2_0x00000002     EINJV2 Memory Error
> +  V2_0x00000004     EINJV2 PCI Express Error
>    ================  ===================================
>  
>    The format of the file contents are as above, except present are only
> @@ -85,9 +88,11 @@ The following files belong to it:
>      Bit 0
>        Processor APIC field valid (see param3 below).
>      Bit 1
> -      Memory address and mask valid (param1 and param2).
> +      Memory address and range valid (param1 and param2).

So was this a bug technically before?  If it was maybe separate
patch.


>      Bit 2
>        PCIe (seg,bus,dev,fn) valid (see param4 below).
> +    Bit 3
> +      EINJv2 extension structure is valid
>  
>    If set to zero, legacy behavior is mimicked where the type of
>    injection specifies just one bit set, and param1 is multiplexed.
> @@ -110,6 +115,7 @@ The following files belong to it:
>    Used when the 0x1 bit is set in "flags" to specify the APIC id
>  
>  - param4
> +
This also shouldn't really be in a patch adding new stuff.
We should treat docs in similar fashion to code - if it is just whitespace
separate patch.

>    Used when the 0x4 bit is set in "flags" to specify target PCIe device
>  
>  - notrigger
> @@ -122,6 +128,18 @@ The following files belong to it:
>    this actually works depends on what operations the BIOS actually
>    includes in the trigger phase.
>  
> +- einjv2_component_count
> +
> +  The value from this file is used to set the "Component Array Count"
> +  field of EINJv2 Extension Structure.

Can we not parse this from the provided component array?  Why is separate
parameter useful?  You don't seem to write it below in the example.


> +
> +- einjv2_component_array
> +
> +  The contents of this file are used to set the "Component Array" field
> +  of the EINJv2 Extension Structure. The expected format is hex values
> +  for component id and syndrome separated by space, and multiple
> +  components are separated by new line.
> +
>  CXL error types are supported from ACPI 6.5 onwards (given a CXL port
>  is present). The EINJ user interface for CXL error types is at
>  <debugfs mount point>/cxl. The following files belong to it:
> @@ -139,7 +157,6 @@ is present). The EINJ user interface for CXL error types is at
>    under <debugfs mount point>/apei/einj, while CXL 1.1/1.0 port injections
>    must use this file.
>  
> -

Another white space change that shouldn't be in this patch in my view.

>  BIOS versions based on the ACPI 4.0 specification have limited options
>  in controlling where the errors are injected. Your BIOS may support an
>  extension (enabled with the param_extension=1 module parameter, or boot
> @@ -194,6 +211,26 @@ An error injection example::
>    # echo 0x8 > error_type			# Choose correctable memory error
>    # echo 1 > error_inject			# Inject now
>  
> +An EINJv2 error injection example::
> +
> +  # cd /sys/kernel/debug/apei/einj
> +  # cat available_error_type			# See which errors can be injected
> +  0x00000002	Processor Uncorrectable non-fatal
> +  0x00000008	Memory Correctable
> +  0x00000010	Memory Uncorrectable non-fatal
> +  0x00000001	EINJV2 Processor Error
> +  0x00000002	EINJV2 Memory Error
> +
> +  # echo 0x12345000 > param1			# Set memory address for injection
> +  # echo 0xfffffffffffff000 > param2		# Range - anywhere in this page
> +  # comp_arr="0x1 0x2				# Fill in the component array
> +    >0x1 0x4
> +    >0x2 0x4"
> +  # echo "$comp_arr" > einjv2_component_array
> +  # echo V2_0x2 > error_type			# Choose EINJv2 memory error
> +  # echo 0xa > flags				# set flags to indicate EINJv2
> +  # echo 1 > error_inject			# Inject now
> +
>  You should see something like this in dmesg::
>  
>    [22715.830801] EDAC sbridge MC3: HANDLING MCE MEMORY ERROR


