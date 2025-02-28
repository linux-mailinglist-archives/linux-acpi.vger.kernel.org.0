Return-Path: <linux-acpi+bounces-11612-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C74A48DEC
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Feb 2025 02:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1DBD1890E7A
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Feb 2025 01:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D49225D7;
	Fri, 28 Feb 2025 01:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BIgrT5+S"
X-Original-To: linux-acpi@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E602DF42;
	Fri, 28 Feb 2025 01:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740706036; cv=none; b=ToNsOz6x6xdpzhhHVCDuu9nirksavkGPAzQgGmYozMYW2Q1iGZGEN7quFn8eNbFPyuHZke1F14hbmnA43zEfxP89zl27tOA3AfLrmK3iX6AvGytn+Ug4gtnNpHgsK0cYorNcEK5gB5Zf+JBg+etlpSQoAZcQtSH5ku4kskIy0RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740706036; c=relaxed/simple;
	bh=DRIZE59qfbLrhjyDe2fdcZWo/OrPyOhFIGVU0MOKC60=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EaNW2M9YfQQ7NnzsQtLxcMACXvxhUxu5Zmr1Tp95P2YhbkZbAb2iM9dyxxSnEz0mv5wFjC3b0jge/cVIRv7Yy/6EkOFRkqFUx1jdCMsq1KLp8jOyHaF+m74Y5oiv+XfaNHFLBoQ6GDR5HWdfMrafS53KvT/1ECb6DpUfwZOjR8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=BIgrT5+S; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.35.166] (c-24-22-154-137.hsd1.wa.comcast.net [24.22.154.137])
	by linux.microsoft.com (Postfix) with ESMTPSA id F02D4210EAC3;
	Thu, 27 Feb 2025 17:27:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F02D4210EAC3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740706033;
	bh=lr/v4YSSk6nndg6C8G4rlBUxgxXkwSzTgFFFPuEsycA=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=BIgrT5+SvSDsUhI4dSQuzSDtsU2JxYoa+o7oeZyCtJeApFB2GkyENAyE0j90AMgZg
	 g9PwNRy7A8e7K2aBhaoZ1ULd6xdyB9Zqe6CTlTXCjFQG6lEKHN1TngAlTGuaJ88l5i
	 UXhIXfRMrROnFNFKl8a91qazyZ/STWGm0DOwxt1Y=
Message-ID: <4fc076cd-7ac0-4569-909c-9c1abc3ae80c@linux.microsoft.com>
Date: Thu, 27 Feb 2025 17:27:11 -0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: linux-hyperv@vger.kernel.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org,
 eahariha@linux.microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, mhklinux@outlook.com, decui@microsoft.com,
 catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 daniel.lezcano@linaro.org, joro@8bytes.org, robin.murphy@arm.com,
 arnd@arndb.de, jinankjain@linux.microsoft.com, muminulrussell@gmail.com,
 skinsburskii@linux.microsoft.com, mrathor@linux.microsoft.com,
 ssengar@linux.microsoft.com, apais@linux.microsoft.com,
 Tianyu.Lan@microsoft.com, stanislav.kinsburskiy@gmail.com,
 gregkh@linuxfoundation.org, vkuznets@redhat.com, prapal@linux.microsoft.com,
 muislam@microsoft.com, anrayabh@linux.microsoft.com, rafael@kernel.org,
 lenb@kernel.org, corbet@lwn.net
Subject: Re: [PATCH v5 09/10] hyperv: Add definitions for root partition
 driver to hv headers
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
References: <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-10-git-send-email-nunodasneves@linux.microsoft.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <1740611284-27506-10-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/26/2025 3:08 PM, Nuno Das Neves wrote:
> A few additional definitions are required for the mshv driver code
> (to follow). Introduce those here and clean up a little bit while
> at it.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  include/hyperv/hvgdk_mini.h |  64 ++++++++++++++++-
>  include/hyperv/hvhdk.h      | 132 ++++++++++++++++++++++++++++++++++--
>  include/hyperv/hvhdk_mini.h |  91 +++++++++++++++++++++++++
>  3 files changed, 280 insertions(+), 7 deletions(-)
> 
> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> index 58895883f636..e4a3cca0cbce 100644
> --- a/include/hyperv/hvgdk_mini.h
> +++ b/include/hyperv/hvgdk_mini.h
> @@ -13,7 +13,7 @@ struct hv_u128 {
>  	u64 high_part;
>  } __packed;
>  

<snip>

>  union hv_input_vtl {
>  	u8 as_uint8;
>  	struct {
> @@ -1325,6 +1344,49 @@ struct hv_retarget_device_interrupt {	 /* HV_INPUT_RETARGET_DEVICE_INTERRUPT */
>  	struct hv_device_interrupt_target int_target;
>  } __packed __aligned(8);
>  
> +enum hv_intercept_type {
> +#if defined(CONFIG_X86_64)

These chosen ifdef's come across kinda arbitrary. The hypervisor code has
this enabled for both 32-bit and 64-bit x86, but you've chosen x86_64 only.
I thought that may be because we only intend to support root partition for 64-bit
platforms, but then, below...

> +	HV_INTERCEPT_TYPE_X64_IO_PORT			= 0x00000000,
> +	HV_INTERCEPT_TYPE_X64_MSR			= 0x00000001,
> +	HV_INTERCEPT_TYPE_X64_CPUID			= 0x00000002,
> +#endif
> +	HV_INTERCEPT_TYPE_EXCEPTION			= 0x00000003,
> +	/* Used to be HV_INTERCEPT_TYPE_REGISTER */
> +	HV_INTERCEPT_TYPE_RESERVED0			= 0x00000004,
> +	HV_INTERCEPT_TYPE_MMIO				= 0x00000005,
> +#if defined(CONFIG_X86_64)
> +	HV_INTERCEPT_TYPE_X64_GLOBAL_CPUID		= 0x00000006,
> +	HV_INTERCEPT_TYPE_X64_APIC_SMI			= 0x00000007,
> +#endif
> +	HV_INTERCEPT_TYPE_HYPERCALL			= 0x00000008,
> +#if defined(CONFIG_X86_64)
> +	HV_INTERCEPT_TYPE_X64_APIC_INIT_SIPI		= 0x00000009,
> +	HV_INTERCEPT_MC_UPDATE_PATCH_LEVEL_MSR_READ	= 0x0000000A,
> +	HV_INTERCEPT_TYPE_X64_APIC_WRITE		= 0x0000000B,
> +	HV_INTERCEPT_TYPE_X64_MSR_INDEX			= 0x0000000C,
> +#endif
> +	HV_INTERCEPT_TYPE_MAX,
> +	HV_INTERCEPT_TYPE_INVALID			= 0xFFFFFFFF,
> +};
> +
> +union hv_intercept_parameters {
> +	/*  HV_INTERCEPT_PARAMETERS is defined to be an 8-byte field. */
> +	__u64 as_uint64;
> +#if defined(CONFIG_X86_64)
> +	/* HV_INTERCEPT_TYPE_X64_IO_PORT */
> +	__u16 io_port;
> +	/* HV_INTERCEPT_TYPE_X64_CPUID */
> +	__u32 cpuid_index;
> +	/* HV_INTERCEPT_TYPE_X64_APIC_WRITE */
> +	__u32 apic_write_mask;
> +	/* HV_INTERCEPT_TYPE_EXCEPTION */
> +	__u16 exception_vector;
> +	/* HV_INTERCEPT_TYPE_X64_MSR_INDEX */
> +	__u32 msr_index;
> +#endif
> +	/* N.B. Other intercept types do not have any parameters. */
> +};
> +
>  /* Data structures for HVCALL_MMIO_READ and HVCALL_MMIO_WRITE */
>  #define HV_HYPERCALL_MMIO_MAX_DATA_LENGTH 64
>  
> diff --git a/include/hyperv/hvhdk.h b/include/hyperv/hvhdk.h
> index 64407c2a3809..1b447155c338 100644
> --- a/include/hyperv/hvhdk.h
> +++ b/include/hyperv/hvhdk.h
> @@ -19,11 +19,24 @@
>  
>  #define HV_VP_REGISTER_PAGE_VERSION_1	1u
>  
> +#define HV_VP_REGISTER_PAGE_MAX_VECTOR_COUNT		7
> +
> +union hv_vp_register_page_interrupt_vectors {
> +	u64 as_uint64;
> +	struct {
> +		u8 vector_count;
> +		u8 vector[HV_VP_REGISTER_PAGE_MAX_VECTOR_COUNT];
> +	} __packed;
> +} __packed;
> +
>  struct hv_vp_register_page {
>  	u16 version;
>  	u8 isvalid;
>  	u8 rsvdz;
>  	u32 dirty;
> +
> +#if IS_ENABLED(CONFIG_X86)
> +

...you've chosen to include 32bit here, where the hypervisor code supports both.

Confused

>  	union {
>  		struct {
>  			/* General purpose registers
> @@ -95,6 +108,22 @@ struct hv_vp_register_page {
>  	union hv_x64_pending_interruption_register pending_interruption;
>  	union hv_x64_interrupt_state_register interrupt_state;
>  	u64 instruction_emulation_hints;
> +	u64 xfem;
> +
> +	/*
> +	 * Fields from this point are not included in the register page save chunk.
> +	 * The reserved field is intended to maintain alignment for unsaved fields.
> +	 */
> +	u8 reserved1[0x100];
> +
> +	/*
> +	 * Interrupts injected as part of HvCallDispatchVp.
> +	 */
> +	union hv_vp_register_page_interrupt_vectors interrupt_vectors;
> +
> +#elif IS_ENABLED(CONFIG_ARM64)
> +	/* Not yet supported in ARM */
> +#endif
>  } __packed;
>  
>  #define HV_PARTITION_PROCESSOR_FEATURES_BANKS 2
> @@ -299,10 +328,11 @@ union hv_partition_isolation_properties {
>  #define HV_PARTITION_ISOLATION_HOST_TYPE_RESERVED   0x2
>  
>  /* Note: Exo partition is enabled by default */
> -#define HV_PARTITION_CREATION_FLAG_EXO_PARTITION                    BIT(8)
> -#define HV_PARTITION_CREATION_FLAG_LAPIC_ENABLED                    BIT(13)
> -#define HV_PARTITION_CREATION_FLAG_INTERCEPT_MESSAGE_PAGE_ENABLED   BIT(19)
> -#define HV_PARTITION_CREATION_FLAG_X2APIC_CAPABLE                   BIT(22)
> +#define HV_PARTITION_CREATION_FLAG_GPA_SUPER_PAGES_ENABLED		BIT(4)
> +#define HV_PARTITION_CREATION_FLAG_EXO_PARTITION			BIT(8)
> +#define HV_PARTITION_CREATION_FLAG_LAPIC_ENABLED			BIT(13)
> +#define HV_PARTITION_CREATION_FLAG_INTERCEPT_MESSAGE_PAGE_ENABLED	BIT(19)
> +#define HV_PARTITION_CREATION_FLAG_X2APIC_CAPABLE			BIT(22)
>  
>  struct hv_input_create_partition {
>  	u64 flags;
> @@ -349,13 +379,23 @@ struct hv_input_set_partition_property {
>  enum hv_vp_state_page_type {
>  	HV_VP_STATE_PAGE_REGISTERS = 0,
>  	HV_VP_STATE_PAGE_INTERCEPT_MESSAGE = 1,
> +	HV_VP_STATE_PAGE_GHCB,
>  	HV_VP_STATE_PAGE_COUNT
>  };
>  
>  struct hv_input_map_vp_state_page {
>  	u64 partition_id;
>  	u32 vp_index;
> -	u32 type; /* enum hv_vp_state_page_type */
> +	u16 type; /* enum hv_vp_state_page_type */
> +	union hv_input_vtl input_vtl;
> +	union {
> +		u8 as_uint8;
> +		struct {
> +			u8 map_location_provided : 1;
> +			u8 reserved : 7;
> +		};
> +	} flags;
> +	u64 requested_map_location;
>  } __packed;
>  
>  struct hv_output_map_vp_state_page {
> @@ -365,7 +405,14 @@ struct hv_output_map_vp_state_page {
>  struct hv_input_unmap_vp_state_page {
>  	u64 partition_id;
>  	u32 vp_index;
> -	u32 type; /* enum hv_vp_state_page_type */
> +	u16 type; /* enum hv_vp_state_page_type */
> +	union hv_input_vtl input_vtl;
> +	u8 reserved0;
> +} __packed;
> +
> +struct hv_x64_apic_eoi_message {
> +	__u32 vp_index;
> +	__u32 interrupt_vector;

Can these be plain u32? Similar below...

>  } __packed;
>  
>  struct hv_opaque_intercept_message {
> @@ -515,6 +562,13 @@ struct hv_synthetic_timers_state {
>  	u64 reserved[5];
>  } __packed;
>  
> +struct hv_async_completion_message_payload {
> +	__u64 partition_id;
> +	__u32 status;
> +	__u32 completion_count;
> +	__u64 sub_status;
> +} __packed;
> +
>  union hv_input_delete_vp {
>  	u64 as_uint64[2];
>  	struct {
> @@ -649,6 +703,57 @@ struct hv_input_set_vp_state {
>  	union hv_input_set_vp_state_data data[];
>  } __packed;
>  
> +union hv_x64_vp_execution_state {
> +	__u16 as_uint16;
> +	struct {
> +		__u16 cpl:2;
> +		__u16 cr0_pe:1;
> +		__u16 cr0_am:1;
> +		__u16 efer_lma:1;
> +		__u16 debug_active:1;
> +		__u16 interruption_pending:1;
> +		__u16 vtl:4;
> +		__u16 enclave_mode:1;
> +		__u16 interrupt_shadow:1;
> +		__u16 virtualization_fault_active:1;
> +		__u16 reserved:2;
> +	} __packed;
> +};
> +
> +struct hv_x64_intercept_message_header {
> +	__u32 vp_index;
> +	__u8 instruction_length:4;
> +	__u8 cr8:4; /* Only set for exo partitions */
> +	__u8 intercept_access_type;
> +	union hv_x64_vp_execution_state execution_state;
> +	struct hv_x64_segment_register cs_segment;
> +	__u64 rip;
> +	__u64 rflags;
> +} __packed;
> +
> +union hv_x64_memory_access_info {
> +	__u8 as_uint8;
> +	struct {
> +		__u8 gva_valid:1;
> +		__u8 gva_gpa_valid:1;
> +		__u8 hypercall_output_pending:1;
> +		__u8 tlb_locked_no_overlay:1;
> +		__u8 reserved:4;
> +	} __packed;
> +};
> +
> +struct hv_x64_memory_intercept_message {
> +	struct hv_x64_intercept_message_header header;
> +	__u32 cache_type; /* enum hv_cache_type */
> +	__u8 instruction_byte_count;
> +	union hv_x64_memory_access_info memory_access_info;
> +	__u8 tpr_priority;
> +	__u8 reserved1;
> +	__u64 guest_virtual_address;
> +	__u64 guest_physical_address;
> +	__u8 instruction_bytes[16];
> +} __packed;
> +
>  /*
>   * Dispatch state for the VP communicated by the hypervisor to the
>   * VP-dispatching thread in the root on return from HVCALL_DISPATCH_VP.
> @@ -716,6 +821,7 @@ static_assert(sizeof(struct hv_vp_signal_pair_scheduler_message) ==
>  #define HV_DISPATCH_VP_FLAG_SKIP_VP_SPEC_FLUSH		0x8
>  #define HV_DISPATCH_VP_FLAG_SKIP_CALLER_SPEC_FLUSH	0x10
>  #define HV_DISPATCH_VP_FLAG_SKIP_CALLER_USER_SPEC_FLUSH	0x20
> +#define HV_DISPATCH_VP_FLAG_SCAN_INTERRUPT_INJECTION	0x40
>  
>  struct hv_input_dispatch_vp {
>  	u64 partition_id;
> @@ -730,4 +836,18 @@ struct hv_output_dispatch_vp {
>  	u32 dispatch_event; /* enum hv_vp_dispatch_event */
>  } __packed;
>  
> +struct hv_input_modify_sparse_spa_page_host_access {
> +	u32 host_access : 2;
> +	u32 reserved : 30;
> +	u32 flags;
> +	u64 partition_id;
> +	u64 spa_page_list[];
> +} __packed;
> +
> +/* hv_input_modify_sparse_spa_page_host_access flags */
> +#define HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_EXCLUSIVE  0x1
> +#define HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_SHARED     0x2
> +#define HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE      0x4
> +#define HV_MODIFY_SPA_PAGE_HOST_ACCESS_HUGE_PAGE       0x8
> +
>  #endif /* _HV_HVHDK_H */
> diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
> index f8a39d3e9ce6..42e7876455b5 100644
> --- a/include/hyperv/hvhdk_mini.h
> +++ b/include/hyperv/hvhdk_mini.h
> @@ -36,6 +36,52 @@ enum hv_scheduler_type {
>  	HV_SCHEDULER_TYPE_MAX
>  };
>  
> +/* HV_STATS_AREA_TYPE */
> +enum hv_stats_area_type {
> +	HV_STATS_AREA_SELF = 0,
> +	HV_STATS_AREA_PARENT = 1,
> +	HV_STATS_AREA_INTERNAL = 2,
> +	HV_STATS_AREA_COUNT
> +};
> +
> +enum hv_stats_object_type {
> +	HV_STATS_OBJECT_HYPERVISOR		= 0x00000001,
> +	HV_STATS_OBJECT_LOGICAL_PROCESSOR	= 0x00000002,
> +	HV_STATS_OBJECT_PARTITION		= 0x00010001,
> +	HV_STATS_OBJECT_VP			= 0x00010002
> +};
> +
> +union hv_stats_object_identity {
> +	/* hv_stats_hypervisor */
> +	struct {
> +		u8 reserved[15];
> +		u8 stats_area_type;
> +	} __packed hv;
> +
> +	/* hv_stats_logical_processor */
> +	struct {
> +		u32 lp_index;
> +		u8 reserved[11];
> +		u8 stats_area_type;
> +	} __packed lp;
> +
> +	/* hv_stats_partition */
> +	struct {
> +		u64 partition_id;
> +		u8  reserved[7];
> +		u8  stats_area_type;
> +	} __packed partition;
> +
> +	/* hv_stats_vp */
> +	struct {
> +		u64 partition_id;
> +		u32 vp_index;
> +		u16 flags;
> +		u8  reserved;
> +		u8  stats_area_type;
> +	} __packed vp;
> +};
> +
>  enum hv_partition_property_code {
>  	/* Privilege properties */
>  	HV_PARTITION_PROPERTY_PRIVILEGE_FLAGS			= 0x00010000,
> @@ -47,19 +93,45 @@ enum hv_partition_property_code {
>  
>  	/* Compatibility properties */
>  	HV_PARTITION_PROPERTY_PROCESSOR_XSAVE_FEATURES		= 0x00060002,
> +	HV_PARTITION_PROPERTY_XSAVE_STATES                      = 0x00060007,
>  	HV_PARTITION_PROPERTY_MAX_XSAVE_DATA_SIZE		= 0x00060008,
>  	HV_PARTITION_PROPERTY_PROCESSOR_CLOCK_FREQUENCY		= 0x00060009,
>  };
>  
> +enum hv_snp_status {
> +	HV_SNP_STATUS_NONE = 0,
> +	HV_SNP_STATUS_AVAILABLE = 1,
> +	HV_SNP_STATUS_INCOMPATIBLE = 2,
> +	HV_SNP_STATUS_PSP_UNAVAILABLE = 3,
> +	HV_SNP_STATUS_PSP_INIT_FAILED = 4,
> +	HV_SNP_STATUS_PSP_BAD_FW_VERSION = 5,
> +	HV_SNP_STATUS_BAD_CONFIGURATION = 6,
> +	HV_SNP_STATUS_PSP_FW_UPDATE_IN_PROGRESS = 7,
> +	HV_SNP_STATUS_PSP_RB_INIT_FAILED = 8,
> +	HV_SNP_STATUS_PSP_PLATFORM_STATUS_FAILED = 9,
> +	HV_SNP_STATUS_PSP_INIT_LATE_FAILED = 10,
> +};
> +
>  enum hv_system_property {
>  	/* Add more values when needed */
>  	HV_SYSTEM_PROPERTY_SCHEDULER_TYPE = 15,
> +	HV_DYNAMIC_PROCESSOR_FEATURE_PROPERTY = 21,
> +};
> +
> +enum hv_dynamic_processor_feature_property {
> +	/* Add more values when needed */
> +	HV_X64_DYNAMIC_PROCESSOR_FEATURE_MAX_ENCRYPTED_PARTITIONS = 13,
> +	HV_X64_DYNAMIC_PROCESSOR_FEATURE_SNP_STATUS = 16,
>  };
>  
>  struct hv_input_get_system_property {
>  	u32 property_id; /* enum hv_system_property */
>  	union {
>  		u32 as_uint32;
> +#if IS_ENABLED(CONFIG_X86)
> +		/* enum hv_dynamic_processor_feature_property */
> +		u32 hv_processor_feature;
> +#endif
>  		/* More fields to be filled in when needed */
>  	};
>  } __packed;
> @@ -67,9 +139,28 @@ struct hv_input_get_system_property {
>  struct hv_output_get_system_property {
>  	union {
>  		u32 scheduler_type; /* enum hv_scheduler_type */
> +#if IS_ENABLED(CONFIG_X86)
> +		u64 hv_processor_feature_value;
> +#endif
>  	};
>  } __packed;
>  
> +struct hv_input_map_stats_page {
> +	u32 type; /* enum hv_stats_object_type */
> +	u32 padding;
> +	union hv_stats_object_identity identity;
> +} __packed;
> +
> +struct hv_output_map_stats_page {
> +	u64 map_location;
> +} __packed;
> +
> +struct hv_input_unmap_stats_page {
> +	u32 type; /* enum hv_stats_object_type */
> +	u32 padding;
> +	union hv_stats_object_identity identity;
> +} __packed;
> +
>  struct hv_proximity_domain_flags {
>  	u32 proximity_preferred : 1;
>  	u32 reserved : 30;


