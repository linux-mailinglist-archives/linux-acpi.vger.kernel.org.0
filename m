Return-Path: <linux-acpi+bounces-14568-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8920AE701C
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Jun 2025 21:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F03318994EC
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Jun 2025 19:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CBF2ECEA3;
	Tue, 24 Jun 2025 19:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="VZON7Y3w"
X-Original-To: linux-acpi@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2E92E88AE
	for <linux-acpi@vger.kernel.org>; Tue, 24 Jun 2025 19:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750794409; cv=none; b=mj0RQtwVc3VZqctbaF5YN8TEDZKtzY6QZnowUij8qcADN02gpavEV5qwqfzoq39pKrFXeWbWCKScF+tgBfIrHoujpcvWwy/b6jiAYc9VUmxn/q+SicTqRKVFpx75UzA5c66QD0kw7Yv9lF7g8liRYK6lNQu5Z6WaTiYBkeV48AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750794409; c=relaxed/simple;
	bh=/VKNEP0ltWiKSzMv/NxgrMfcRJpj1AtOgeiziegS+qQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YsYah8Xgg+qh2QWPp3H1YPGfImRt839kiYOSTpb8jiEZGntKYukf4ZObRT5prODQLCMf4rYeqX4r2gRgSBwXZBYEW7JvjdfdEDpHb4lWjSLr2HdeD/0CoEgZzz08XjHt4/pGzvxTOY11QZhV8SZIpG3xmtBiA5Fo6m/VABA8nXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=VZON7Y3w; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6001a.ext.cloudfilter.net ([10.0.30.140])
	by cmsmtp with ESMTPS
	id U20ru0yOubmnlU9bRu1AXp; Tue, 24 Jun 2025 19:46:45 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id U9bPujFVNgFaXU9bQucud1; Tue, 24 Jun 2025 19:46:44 +0000
X-Authority-Analysis: v=2.4 cv=DbzcqetW c=1 sm=1 tr=0 ts=685b00a4
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=y7jUFFJD1EYPe7d4fIfORw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=rxE1pZJS_adTsW7E6NAA:9 a=QEXdDO2ut3YA:10 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UrkOMRXh4VU9szWbhUzcUYJTMJCwbEOG1xhSxMr5j/s=; b=VZON7Y3wKm+1ZIJLeb9xH61f7I
	x938k9LP1QGcL52x2rmYSeSzzv4KES1aUKkox26nbZFXBY9dSnaYpLwQe79DygG6EudIhvBUQqtax
	OQ2D2UC4UchUOmmjxl5i+8brKQOBp2FllQUHxAALjGbAkjN8G4h8nHkLKVHSpeMFM82jTwBvY+IYi
	FMjZEskzilCrgW6jOYSVx46EtrC3JvKb5QCWxR2hu7/wShFB9QQr0xHTW0nINlmMVHq0mY2Nza1dS
	2+CyeU9MZ4lo5STprt7Fy0zd3WB550f3rfOd473ukD3YzgxjRBlrZfxbzoqMJaOzwgNT3ypQ5vEev
	x8WFnWyg==;
Received: from [177.238.16.137] (port=33172 helo=[192.168.0.21])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1uU9bP-00000004Led-076f;
	Tue, 24 Jun 2025 14:46:43 -0500
Message-ID: <9782fd09-c6c6-4cac-bcfa-404733ae827a@embeddedor.com>
Date: Tue, 24 Jun 2025 13:46:32 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3][next] acpi: nfit: intel: avoid multiple
 -Wflex-array-member-not-at-end warnings
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>
Cc: nvdimm@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 Kees Cook <kees@kernel.org>
References: <aEneid7gdAZr1_kR@kspp>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <aEneid7gdAZr1_kR@kspp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.16.137
X-Source-L: No
X-Exim-ID: 1uU9bP-00000004Led-076f
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.21]) [177.238.16.137]:33172
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfModvxFFXLyQOLs2ynbGm2bOxJLRUb8m/+/S2oz6nQwOVOVPuqBwV42YimCpQ5KIqN9gU/ddxMht6NIOjvRw7KY4CW8AZF8jGB7fy/zOWiSxQ/zmXa9y
 sAIiltkz+bhLzVAnId7EmkZ1euZzNuU2pX+MQ4IabsIvdUN1zvcwxbhBRXwUEYWyN3AGk2f3AN6FK8FY81v8eV38V5L9lUO0+OY1BvupBMSWGt3G3Gpj8ZHU

Hi all,

Friendly ping: who can review or take this, please? :)

Thanks!
-Gustavo

On 11/06/25 13:52, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Refactor multiple structs that contain flexible-array members in the
> middle by replacing them with unions.
> 
> These changes preserve the memory layout while effectively adjusting
> it so that the flexible-array member is always treated as the last
> member.
> 
> With these changes, fix a dozen instances of the following type of
> warning:
> 
> drivers/acpi/nfit/intel.c:692:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> Changes in v3:
>   - Use union instead of DEFINE_RAW_FLEX().
> 
> Changes in v2:
>   - Use DEFINE_RAW_FLEX() instead of __struct_group().
>   - Link: https://lore.kernel.org/linux-hardening/Z-QpUcxFCRByYcTA@kspp/
> 
> v1:
>   - Link: https://lore.kernel.org/linux-hardening/Z618ILbAR8YAvTkd@kspp/
> 
>   drivers/acpi/nfit/intel.c | 132 +++++++++++++++++++++++++++++++-------
>   1 file changed, 108 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/acpi/nfit/intel.c b/drivers/acpi/nfit/intel.c
> index 3902759abcba..987d427ec2b6 100644
> --- a/drivers/acpi/nfit/intel.c
> +++ b/drivers/acpi/nfit/intel.c
> @@ -55,9 +55,16 @@ static unsigned long intel_security_flags(struct nvdimm *nvdimm,
>   {
>   	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
>   	unsigned long security_flags = 0;
> -	struct {
> +	/*
> +	 * This effectively creates a union between the flexible-array member
> +	 * and any members after _offset_to_fam.
> +	 */
> +	union {
>   		struct nd_cmd_pkg pkg;
> -		struct nd_intel_get_security_state cmd;
> +		struct {
> +			u8 _offset_to_fam[offsetof(struct nd_cmd_pkg, nd_payload)];
> +			struct nd_intel_get_security_state cmd;
> +		};
>   	} nd_cmd = {
>   		.pkg = {
>   			.nd_command = NVDIMM_INTEL_GET_SECURITY_STATE,
> @@ -120,9 +127,16 @@ static unsigned long intel_security_flags(struct nvdimm *nvdimm,
>   static int intel_security_freeze(struct nvdimm *nvdimm)
>   {
>   	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
> -	struct {
> +	/*
> +	 * This effectively creates a union between the flexible-array member
> +	 * and any members after _offset_to_fam.
> +	 */
> +	union {
>   		struct nd_cmd_pkg pkg;
> -		struct nd_intel_freeze_lock cmd;
> +		struct {
> +			u8 _offset_to_fam[offsetof(struct nd_cmd_pkg, nd_payload)];
> +			struct nd_intel_freeze_lock cmd;
> +		};
>   	} nd_cmd = {
>   		.pkg = {
>   			.nd_command = NVDIMM_INTEL_FREEZE_LOCK,
> @@ -153,9 +167,16 @@ static int intel_security_change_key(struct nvdimm *nvdimm,
>   	unsigned int cmd = ptype == NVDIMM_MASTER ?
>   		NVDIMM_INTEL_SET_MASTER_PASSPHRASE :
>   		NVDIMM_INTEL_SET_PASSPHRASE;
> -	struct {
> +	/*
> +	 * This effectively creates a union between the flexible-array member
> +	 * and any members after _offset_to_fam.
> +	 */
> +	union {
>   		struct nd_cmd_pkg pkg;
> -		struct nd_intel_set_passphrase cmd;
> +		struct {
> +			u8 _offset_to_fam[offsetof(struct nd_cmd_pkg, nd_payload)];
> +			struct nd_intel_set_passphrase cmd;
> +		};
>   	} nd_cmd = {
>   		.pkg = {
>   			.nd_family = NVDIMM_FAMILY_INTEL,
> @@ -195,9 +216,16 @@ static int __maybe_unused intel_security_unlock(struct nvdimm *nvdimm,
>   		const struct nvdimm_key_data *key_data)
>   {
>   	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
> -	struct {
> +	/*
> +	 * This effectively creates a union between the flexible-array member
> +	 * and any members after _offset_to_fam.
> +	 */
> +	union {
>   		struct nd_cmd_pkg pkg;
> -		struct nd_intel_unlock_unit cmd;
> +		struct {
> +			u8 _offset_to_fam[offsetof(struct nd_cmd_pkg, nd_payload)];
> +			struct nd_intel_unlock_unit cmd;
> +		};
>   	} nd_cmd = {
>   		.pkg = {
>   			.nd_command = NVDIMM_INTEL_UNLOCK_UNIT,
> @@ -234,9 +262,16 @@ static int intel_security_disable(struct nvdimm *nvdimm,
>   {
>   	int rc;
>   	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
> -	struct {
> +	/*
> +	 * This effectively creates a union between the flexible-array member
> +	 * and any members after _offset_to_fam.
> +	 */
> +	union {
>   		struct nd_cmd_pkg pkg;
> -		struct nd_intel_disable_passphrase cmd;
> +		struct {
> +			u8 _offset_to_fam[offsetof(struct nd_cmd_pkg, nd_payload)];
> +			struct nd_intel_disable_passphrase cmd;
> +		};
>   	} nd_cmd = {
>   		.pkg = {
>   			.nd_command = NVDIMM_INTEL_DISABLE_PASSPHRASE,
> @@ -277,9 +312,16 @@ static int __maybe_unused intel_security_erase(struct nvdimm *nvdimm,
>   	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
>   	unsigned int cmd = ptype == NVDIMM_MASTER ?
>   		NVDIMM_INTEL_MASTER_SECURE_ERASE : NVDIMM_INTEL_SECURE_ERASE;
> -	struct {
> +	/*
> +	 * This effectively creates a union between the flexible-array member
> +	 * and any members after _offset_to_fam.
> +	 */
> +	union {
>   		struct nd_cmd_pkg pkg;
> -		struct nd_intel_secure_erase cmd;
> +		struct {
> +			u8 _offset_to_fam[offsetof(struct nd_cmd_pkg, nd_payload)];
> +			struct nd_intel_secure_erase cmd;
> +		};
>   	} nd_cmd = {
>   		.pkg = {
>   			.nd_family = NVDIMM_FAMILY_INTEL,
> @@ -318,9 +360,16 @@ static int __maybe_unused intel_security_query_overwrite(struct nvdimm *nvdimm)
>   {
>   	int rc;
>   	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
> -	struct {
> +	/*
> +	 * This effectively creates a union between the flexible-array member
> +	 * and any members after _offset_to_fam.
> +	 */
> +	union {
>   		struct nd_cmd_pkg pkg;
> -		struct nd_intel_query_overwrite cmd;
> +		struct {
> +			u8 _offset_to_fam[offsetof(struct nd_cmd_pkg, nd_payload)];
> +			struct nd_intel_query_overwrite cmd;
> +		};
>   	} nd_cmd = {
>   		.pkg = {
>   			.nd_command = NVDIMM_INTEL_QUERY_OVERWRITE,
> @@ -354,9 +403,16 @@ static int __maybe_unused intel_security_overwrite(struct nvdimm *nvdimm,
>   {
>   	int rc;
>   	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
> -	struct {
> +	/*
> +	 * This effectively creates a union between the flexible-array member
> +	 * and any members after _offset_to_fam.
> +	 */
> +	union {
>   		struct nd_cmd_pkg pkg;
> -		struct nd_intel_overwrite cmd;
> +		struct {
> +			u8 _offset_to_fam[offsetof(struct nd_cmd_pkg, nd_payload)];
> +			struct nd_intel_overwrite cmd;
> +		};
>   	} nd_cmd = {
>   		.pkg = {
>   			.nd_command = NVDIMM_INTEL_OVERWRITE,
> @@ -407,9 +463,16 @@ const struct nvdimm_security_ops *intel_security_ops = &__intel_security_ops;
>   static int intel_bus_fwa_businfo(struct nvdimm_bus_descriptor *nd_desc,
>   		struct nd_intel_bus_fw_activate_businfo *info)
>   {
> -	struct {
> +	/*
> +	 * This effectively creates a union between the flexible-array member
> +	 * and any members after _offset_to_fam.
> +	 */
> +	union {
>   		struct nd_cmd_pkg pkg;
> -		struct nd_intel_bus_fw_activate_businfo cmd;
> +		struct {
> +			u8 _offset_to_fam[offsetof(struct nd_cmd_pkg, nd_payload)];
> +			struct nd_intel_bus_fw_activate_businfo cmd;
> +		};
>   	} nd_cmd = {
>   		.pkg = {
>   			.nd_command = NVDIMM_BUS_INTEL_FW_ACTIVATE_BUSINFO,
> @@ -518,9 +581,16 @@ static enum nvdimm_fwa_capability intel_bus_fwa_capability(
>   static int intel_bus_fwa_activate(struct nvdimm_bus_descriptor *nd_desc)
>   {
>   	struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
> -	struct {
> +	/*
> +	 * This effectively creates a union between the flexible-array member
> +	 * and any members after _offset_to_fam.
> +	 */
> +	union {
>   		struct nd_cmd_pkg pkg;
> -		struct nd_intel_bus_fw_activate cmd;
> +		struct {
> +			u8 _offset_to_fam[offsetof(struct nd_cmd_pkg, nd_payload)];
> +			struct nd_intel_bus_fw_activate cmd;
> +		};
>   	} nd_cmd = {
>   		.pkg = {
>   			.nd_command = NVDIMM_BUS_INTEL_FW_ACTIVATE,
> @@ -582,9 +652,16 @@ const struct nvdimm_bus_fw_ops *intel_bus_fw_ops = &__intel_bus_fw_ops;
>   static int intel_fwa_dimminfo(struct nvdimm *nvdimm,
>   		struct nd_intel_fw_activate_dimminfo *info)
>   {
> -	struct {
> +	/*
> +	 * This effectively creates a union between the flexible-array member
> +	 * and any members after _offset_to_fam.
> +	 */
> +	union {
>   		struct nd_cmd_pkg pkg;
> -		struct nd_intel_fw_activate_dimminfo cmd;
> +		struct {
> +			u8 _offset_to_fam[offsetof(struct nd_cmd_pkg, nd_payload)];
> +			struct nd_intel_fw_activate_dimminfo cmd;
> +		};
>   	} nd_cmd = {
>   		.pkg = {
>   			.nd_command = NVDIMM_INTEL_FW_ACTIVATE_DIMMINFO,
> @@ -688,9 +765,16 @@ static int intel_fwa_arm(struct nvdimm *nvdimm, enum nvdimm_fwa_trigger arm)
>   {
>   	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
>   	struct acpi_nfit_desc *acpi_desc = nfit_mem->acpi_desc;
> -	struct {
> +	/*
> +	 * This effectively creates a union between the flexible-array member
> +	 * and any members after _offset_to_fam.
> +	 */
> +	union {
>   		struct nd_cmd_pkg pkg;
> -		struct nd_intel_fw_activate_arm cmd;
> +		struct {
> +			u8 _offset_to_fam[offsetof(struct nd_cmd_pkg, nd_payload)];
> +			struct nd_intel_fw_activate_arm cmd;
> +		};
>   	} nd_cmd = {
>   		.pkg = {
>   			.nd_command = NVDIMM_INTEL_FW_ACTIVATE_ARM,


