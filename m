Return-Path: <linux-acpi+bounces-11183-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C229A353F0
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Feb 2025 02:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 916B91890846
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Feb 2025 01:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B5D86324;
	Fri, 14 Feb 2025 01:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hyQzOKky"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C69D347CC;
	Fri, 14 Feb 2025 01:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739498285; cv=none; b=kLC93qzUsS2InbrY/pAiSt9XS02x5tqsvKFFE91RdEog66TgJiD8F7JZLCAqLigyTmQayDj+lICa2tYYaPOJogZfXlwXxewDiV4LrPNwwwFRfvJTG5Qq9cbpNRK6Ih+nKqOomCLb45obbOiAp5nUKlj2Dy42RuWRBNZKUzGWmZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739498285; c=relaxed/simple;
	bh=xqQr2Py0Wo1dWSI6BF6vAyEUGFaoFkBBl6dgrTsRVoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwQYICOc5vQZJC9YbyCtJeJG3AQL90+LxEqYxzpKbM3puzE6pjHHRGg2iwYRPh8PwjbXsPNB7W7/J/M/gr6AslQ75JelU4ILaAHJ18VMz27H9OlH08G+I06SSu6UULoERCVZxph6md5GkVqIwJFdHVzONHyUwEcVpQtHTHULFTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hyQzOKky; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739498284; x=1771034284;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xqQr2Py0Wo1dWSI6BF6vAyEUGFaoFkBBl6dgrTsRVoQ=;
  b=hyQzOKkykIxMYco/pWXGTK6Hn7urrUEQwW8mHnY0TGy8+RnmsWt9Paol
   Yo/JZAjCMMnFKdoC2ZEMFHhc1+i5PD7BzHd7xjplFHQ9F6bLvoSM0ITKI
   rJxVjjzGdoIreEZpiAcZEZ+3II+rlPUmNqEZANTTc1OILue85gAT9DicD
   ZYDovb/2LhYGFfFln/DDlXZt3HtSua7VmfXrFsIVMif8mBiK04EHg4Yo3
   Rx3WLl/QIww/TuWx8I3a2cUUaWvGjo/iBCyeWSV2a9ht3r8FN3LCfpNwX
   cYHVEAvQ0SgeUf9xpCqKreRMzqangOGKwubsOyHPXWgN8+tPyh6R3yTOZ
   Q==;
X-CSE-ConnectionGUID: Ct09tW+RQkqSmzTzEGeYLA==
X-CSE-MsgGUID: AtGUpl7KQMOdV0R+0kLxzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="50878312"
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="50878312"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 17:58:03 -0800
X-CSE-ConnectionGUID: pWp7sM5+TUm0Wd6kPwb4xQ==
X-CSE-MsgGUID: yTNWeSQwQhimGDFDFr6f9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="113842073"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.108.202])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 17:58:03 -0800
Date: Thu, 13 Feb 2025 17:58:00 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, nvdimm@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	SupportedACPI status: linux-hardening@vger.kernel.org;
Subject: Re: [PATCH v2][next] UAPI: ndctl / acpi: intel: Avoid multiple
 -Wflex-array-member-not-at-end warnings
Message-ID: <Z66jKIvuTXmNC3Q7@aschofie-mobl2.lan>
References: <Z66T8tSKjVutr6of@kspp>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z66T8tSKjVutr6of@kspp>

On Fri, Feb 14, 2025 at 11:23:06AM +1030, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> So, in order to avoid ending up with flexible-array members in the
> middle of other structs, we use the `__struct_group()` helper to
> separate the flexible array from the rest of the members in the
> flexible structure. We then use the newly created tagged `struct
> nd_cmd_pkg_hdr` to replace the type of the objects causing trouble:
> `pkg` in multiple structs.
> 
> Below is the before-and-after changes of the memory layout in `struct
> nd_cmd_pkg`. This to illustrate that the use of `__struct_group()`
> doesn't alter the layout, ensuring that user space remains unaffected.
> 
> Before changes:
> struct nd_cmd_pkg {
> 	__u64                      nd_family;            /*     0     8 */
> 	__u64                      nd_command;           /*     8     8 */
> 	__u32                      nd_size_in;           /*    16     4 */
> 	__u32                      nd_size_out;          /*    20     4 */
> 	__u32                      nd_reserved2[9];      /*    24    36 */
> 	__u32                      nd_fw_size;           /*    60     4 */
> 	/* --- cacheline 1 boundary (64 bytes) --- */
> 	unsigned char              nd_payload[];         /*    64     0 */
> 
> 	/* size: 64, cachelines: 1, members: 7 */
> };
> 
> After changes:
> struct nd_cmd_pkg {
> 	union {
> 		struct {
> 			__u64      nd_family;            /*     0     8 */
> 			__u64      nd_command;           /*     8     8 */
> 			__u32      nd_size_in;           /*    16     4 */
> 			__u32      nd_size_out;          /*    20     4 */
> 			__u32      nd_reserved2[9];      /*    24    36 */
> 			__u32      nd_fw_size;           /*    60     4 */
> 		};                                       /*     0    64 */
> 		struct nd_cmd_pkg_hdr __hdr;             /*     0    64 */
> 	};                                               /*     0    64 */
> 	/* --- cacheline 1 boundary (64 bytes) --- */
> 	unsigned char              nd_payload[];         /*    64     0 */
> 
> 	/* size: 64, cachelines: 1, members: 2 */
> };
> 
> It's also worth mentioning that all members of the struct can still be
> accessed directly, for example instance->nd_family, instance->nd_command,
> and so on.
> 
> So, with these changes, fix 12 of the following warnings:
> 
> drivers/acpi/nfit/intel.c:692:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>


> ---
> Changes in v2:
>  - Show changes in UAPI first. (Alison)
>  - Update changelog text --add more information about _struct_group()
>    changes. (Alison)
> 
> v1:
>  - Link: https://lore.kernel.org/linux-hardening/Z618ILbAR8YAvTkd@kspp/
> 
>  include/uapi/linux/ndctl.h | 15 +++++++++------
>  drivers/acpi/nfit/intel.c  | 24 ++++++++++++------------
>  2 files changed, 21 insertions(+), 18 deletions(-)
> 
> diff --git a/include/uapi/linux/ndctl.h b/include/uapi/linux/ndctl.h
> index 73516e263627..34c11644d5d7 100644
> --- a/include/uapi/linux/ndctl.h
> +++ b/include/uapi/linux/ndctl.h
> @@ -227,12 +227,15 @@ enum ars_masks {
>   */
>  
>  struct nd_cmd_pkg {
> -	__u64   nd_family;		/* family of commands */
> -	__u64   nd_command;
> -	__u32   nd_size_in;		/* INPUT: size of input args */
> -	__u32   nd_size_out;		/* INPUT: size of payload */
> -	__u32   nd_reserved2[9];	/* reserved must be zero */
> -	__u32   nd_fw_size;		/* OUTPUT: size fw wants to return */
> +	/* New members MUST be added within the __struct_group() macro below. */
> +	__struct_group(nd_cmd_pkg_hdr, __hdr, /* no attrs */,
> +		__u64   nd_family;		/* family of commands */
> +		__u64   nd_command;
> +		__u32   nd_size_in;		/* INPUT: size of input args */
> +		__u32   nd_size_out;		/* INPUT: size of payload */
> +		__u32   nd_reserved2[9];	/* reserved must be zero */
> +		__u32   nd_fw_size;		/* OUTPUT: size fw wants to return */
> +	);
>  	unsigned char nd_payload[];	/* Contents of call      */
>  };
>  
> diff --git a/drivers/acpi/nfit/intel.c b/drivers/acpi/nfit/intel.c
> index 3902759abcba..fe561ce0ddec 100644
> --- a/drivers/acpi/nfit/intel.c
> +++ b/drivers/acpi/nfit/intel.c
> @@ -56,7 +56,7 @@ static unsigned long intel_security_flags(struct nvdimm *nvdimm,
>  	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
>  	unsigned long security_flags = 0;
>  	struct {
> -		struct nd_cmd_pkg pkg;
> +		struct nd_cmd_pkg_hdr pkg;
>  		struct nd_intel_get_security_state cmd;
>  	} nd_cmd = {
>  		.pkg = {
> @@ -121,7 +121,7 @@ static int intel_security_freeze(struct nvdimm *nvdimm)
>  {
>  	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
>  	struct {
> -		struct nd_cmd_pkg pkg;
> +		struct nd_cmd_pkg_hdr pkg;
>  		struct nd_intel_freeze_lock cmd;
>  	} nd_cmd = {
>  		.pkg = {
> @@ -154,7 +154,7 @@ static int intel_security_change_key(struct nvdimm *nvdimm,
>  		NVDIMM_INTEL_SET_MASTER_PASSPHRASE :
>  		NVDIMM_INTEL_SET_PASSPHRASE;
>  	struct {
> -		struct nd_cmd_pkg pkg;
> +		struct nd_cmd_pkg_hdr pkg;
>  		struct nd_intel_set_passphrase cmd;
>  	} nd_cmd = {
>  		.pkg = {
> @@ -196,7 +196,7 @@ static int __maybe_unused intel_security_unlock(struct nvdimm *nvdimm,
>  {
>  	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
>  	struct {
> -		struct nd_cmd_pkg pkg;
> +		struct nd_cmd_pkg_hdr pkg;
>  		struct nd_intel_unlock_unit cmd;
>  	} nd_cmd = {
>  		.pkg = {
> @@ -235,7 +235,7 @@ static int intel_security_disable(struct nvdimm *nvdimm,
>  	int rc;
>  	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
>  	struct {
> -		struct nd_cmd_pkg pkg;
> +		struct nd_cmd_pkg_hdr pkg;
>  		struct nd_intel_disable_passphrase cmd;
>  	} nd_cmd = {
>  		.pkg = {
> @@ -278,7 +278,7 @@ static int __maybe_unused intel_security_erase(struct nvdimm *nvdimm,
>  	unsigned int cmd = ptype == NVDIMM_MASTER ?
>  		NVDIMM_INTEL_MASTER_SECURE_ERASE : NVDIMM_INTEL_SECURE_ERASE;
>  	struct {
> -		struct nd_cmd_pkg pkg;
> +		struct nd_cmd_pkg_hdr pkg;
>  		struct nd_intel_secure_erase cmd;
>  	} nd_cmd = {
>  		.pkg = {
> @@ -319,7 +319,7 @@ static int __maybe_unused intel_security_query_overwrite(struct nvdimm *nvdimm)
>  	int rc;
>  	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
>  	struct {
> -		struct nd_cmd_pkg pkg;
> +		struct nd_cmd_pkg_hdr pkg;
>  		struct nd_intel_query_overwrite cmd;
>  	} nd_cmd = {
>  		.pkg = {
> @@ -355,7 +355,7 @@ static int __maybe_unused intel_security_overwrite(struct nvdimm *nvdimm,
>  	int rc;
>  	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
>  	struct {
> -		struct nd_cmd_pkg pkg;
> +		struct nd_cmd_pkg_hdr pkg;
>  		struct nd_intel_overwrite cmd;
>  	} nd_cmd = {
>  		.pkg = {
> @@ -408,7 +408,7 @@ static int intel_bus_fwa_businfo(struct nvdimm_bus_descriptor *nd_desc,
>  		struct nd_intel_bus_fw_activate_businfo *info)
>  {
>  	struct {
> -		struct nd_cmd_pkg pkg;
> +		struct nd_cmd_pkg_hdr pkg;
>  		struct nd_intel_bus_fw_activate_businfo cmd;
>  	} nd_cmd = {
>  		.pkg = {
> @@ -519,7 +519,7 @@ static int intel_bus_fwa_activate(struct nvdimm_bus_descriptor *nd_desc)
>  {
>  	struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
>  	struct {
> -		struct nd_cmd_pkg pkg;
> +		struct nd_cmd_pkg_hdr pkg;
>  		struct nd_intel_bus_fw_activate cmd;
>  	} nd_cmd = {
>  		.pkg = {
> @@ -583,7 +583,7 @@ static int intel_fwa_dimminfo(struct nvdimm *nvdimm,
>  		struct nd_intel_fw_activate_dimminfo *info)
>  {
>  	struct {
> -		struct nd_cmd_pkg pkg;
> +		struct nd_cmd_pkg_hdr pkg;
>  		struct nd_intel_fw_activate_dimminfo cmd;
>  	} nd_cmd = {
>  		.pkg = {
> @@ -689,7 +689,7 @@ static int intel_fwa_arm(struct nvdimm *nvdimm, enum nvdimm_fwa_trigger arm)
>  	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
>  	struct acpi_nfit_desc *acpi_desc = nfit_mem->acpi_desc;
>  	struct {
> -		struct nd_cmd_pkg pkg;
> +		struct nd_cmd_pkg_hdr pkg;
>  		struct nd_intel_fw_activate_arm cmd;
>  	} nd_cmd = {
>  		.pkg = {
> -- 
> 2.43.0
> 

