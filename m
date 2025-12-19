Return-Path: <linux-acpi+bounces-19713-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D852CD049E
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Dec 2025 15:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40B003015114
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Dec 2025 14:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A207531ED71;
	Fri, 19 Dec 2025 14:35:57 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAC9339701;
	Fri, 19 Dec 2025 14:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766154957; cv=none; b=O1ZqR3YDV/ia6KaqkBHdD8AgwhQppH9lDgYzWbcJ7Y3gYUewRw4Q4X/rLayiV7j+pSqJ9W9y/+qkH7qMhn3VicNEcjrAXBW79zcGytL3g05G7P+Bwm0dmcVozmOZEGWiLZhDmFR77UrCAmWFsTo87jxXPYMliK1cTvXaKdUnMmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766154957; c=relaxed/simple;
	bh=Ai8buLZOjsV1/1tNsDKHrdoCKC5Y2zXnMkOcugx9j1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qi5NaDlxaCO23RuuoxhFqgY075a4/fO4SpeyLTH/fMOOduo2mHqXXXDDpFErh58EBEjT4HTM3UUMRxx7Wjtpc68MENID+/VnDY9v2619o832iucj09niY1dm9lyIquEhVzS5fTgih2BufjrpKVtnWJF4GtvNek+IhZL2eoSwFDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06F3EFEC;
	Fri, 19 Dec 2025 06:35:46 -0800 (PST)
Received: from e134710.manchester.arm.com (e134710.arm.com [10.33.10.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C3733F5CA;
	Fri, 19 Dec 2025 06:35:50 -0800 (PST)
From: Ahmed Tiba <ahmed.tiba@arm.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	devicetree@vger.kernel.org,
	tony.luck@intel.com,
	bp@alien8.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	rafael@kernel.org,
	linux-doc@vger.kernel.org,
	Dmitry.Lamerov@arm.com,
	Michael.Zhao2@arm.com,
	Ahmed.Tiba@arm.com
Subject: Re: [PATCH 02/12] ras: add estatus core implementation
Date: Fri, 19 Dec 2025 14:35:42 +0000
Message-ID: <20251219143545.2792858-1-ahmed.tiba@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6vlj35rmfm7dzjdngxibaygcgmcj3h2ibhuqnoeqqrsrxmsqbt@qpqnm5xndok6>
References: 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, Dec 18, 2025 at 04:42:42PM +0100, Mauro Carvalho Chehab wrote:
>> Add estatus.c, hook it into the EFI Makefile, and register
>> the MAINTAINERS entry for the new code. The implementation provides the
>> memory-pool helpers, notifier plumbing, and utility functions that the
>> GHES and DeviceTree providers will reuse in later commits.
>>
>> Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
>> ---
>>  MAINTAINERS                    |   1 +
>>  drivers/firmware/efi/Makefile  |   1 +
>>  drivers/firmware/efi/estatus.c | 560 +++++++++++++++++++++++++++++++++

> If I'm understanding this patch series, you will be basically moving more than
> half of the code from drivers/acpi/apei/ghes.c to drivers/firmware/efi/estatus.c:
> 
>  drivers/acpi/apei/ghes.c                   | 1292 ++-------------
>  drivers/firmware/efi/estatus.c             | 1056 ++++++++++++
> 
>  $ wc drivers/acpi/apei/ghes.c drivers/firmware/efi/estatus.c -l
>   894 drivers/acpi/apei/ghes.c
>  1056 drivers/firmware/efi/estatus.c
>  1950 total
> 
> The way you're doing of adding things first, and then removing on
> separate patches is error prone, makes it hard to review and
> it becomes a lot harder to identify whose are the original authors
> of the code.

I see your point. I tried staging the additions ahead of the removals so the new helpers
were readable, but I can see that makes review and authorship tracking painful.

> This will cause undetected conflicts with already-submitted patches
> that are under review.
> 
> You should instead be moving function per function as-is. Then,
> adjust the code to make it more generic.

I did try moving each helper first and doing the cleanup afterwards,
but the series quickly ballooned and the ordering became confusing
once later patches started depending on code that was still in transit.

I’m happy to try again, though I expect to run into the same issue
unless there’s a known pattern to follow. If you have a reference series or a preferred ordering
that you’d recommend, please point me to it so I can align with that approach.


>>  3 files changed, 562 insertions(+)
>>  create mode 100644 drivers/firmware/efi/estatus.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 501b6d300aa5..67d79d4e612d 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -21760,6 +21760,7 @@ F:    drivers/rapidio/
>>  RAS ERROR STATUS
>>  M:   Ahmed Tiba <ahmed.tiba@arm.com>
>>  S:   Maintained
>> +F:   drivers/firmware/efi/estatus.c
>>  F:   include/linux/estatus.h
>> 
>>  RAS INFRASTRUCTURE
>> diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
>> index 8efbcf699e4f..03708d915bcf 100644
>> --- a/drivers/firmware/efi/Makefile
>> +++ b/drivers/firmware/efi/Makefile
>> @@ -20,6 +20,7 @@ obj-$(CONFIG_EFI_PARAMS_FROM_FDT)   += fdtparams.o
>>  obj-$(CONFIG_EFI_ESRT)                       += esrt.o
>>  obj-$(CONFIG_EFI_VARS_PSTORE)                += efi-pstore.o
>>  obj-$(CONFIG_UEFI_CPER)                      += cper.o cper_cxl.o
>> +obj-$(CONFIG_RAS_ESTATUS_CORE)               += estatus.o
>>  obj-$(CONFIG_EFI_RUNTIME_WRAPPERS)   += runtime-wrappers.o
>>  subdir-$(CONFIG_EFI_STUB)            += libstub
>>  obj-$(CONFIG_EFI_BOOTLOADER_CONTROL) += efibc.o
>> diff --git a/drivers/firmware/efi/estatus.c b/drivers/firmware/efi/estatus.c
>> new file mode 100644
>> index 000000000000..8dae5c73ce27
>> --- /dev/null
>> +++ b/drivers/firmware/efi/estatus.c
>> @@ -0,0 +1,560 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Firmware-first RAS: Generic Error Status Core
>> + *
>> + * Copyright (C) 2025 ARM Ltd.
>> + * Author: Ahmed Tiba <ahmed.tiba@arm.com>
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/cper.h>
>> +#include <linux/ratelimit.h>
>> +#include <linux/vmalloc.h>
>> +#include <linux/llist.h>
>> +#include <linux/genalloc.h>
>> +#include <linux/pci.h>
>> +#include <linux/pfn.h>
>> +#include <linux/aer.h>
>> +#include <linux/nmi.h>
>> +#include <linux/sched/clock.h>
>> +#include <linux/uuid.h>
>> +#include <linux/kconfig.h>
>> +#include <linux/ras.h>
>> +#include <linux/mutex.h>
>> +#include <linux/notifier.h>
>> +#include <linux/workqueue.h>
>> +#include <linux/task_work.h>
>> +#include <ras/ras_event.h>
>> +
>> +#include <linux/estatus.h>
>> +#include <asm/fixmap.h>
>> +
>> +void estatus_pool_region_free(unsigned long addr, u32 size);
>> +
>> +static void estatus_log_hw_error(char level, const char *seq_tag,
>> +                              const char *name)
>> +{
>> +     switch (level) {
>> +     case '0':
>> +             pr_emerg("%sHardware error from %s\n", seq_tag, name);
>> +             break;
>> +     case '1':
>> +             pr_alert("%sHardware error from %s\n", seq_tag, name);
>> +             break;
>> +     case '2':
>> +             pr_crit("%sHardware error from %s\n", seq_tag, name);
>> +             break;
>> +     case '3':
>> +             pr_err("%sHardware error from %s\n", seq_tag, name);
>> +             break;
>> +     case '4':
>> +             pr_warn("%sHardware error from %s\n", seq_tag, name);
>> +             break;
>> +     case '5':
>> +             pr_notice("%sHardware error from %s\n", seq_tag, name);
>> +             break;
>> +     case '6':
>> +             pr_info("%sHardware error from %s\n", seq_tag, name);
>> +             break;
>> +     default:
>> +             pr_debug("%sHardware error from %s\n", seq_tag, name);
>> +             break;
>> +     }
>> +}
>> +
>> +static inline u32 estatus_len(struct acpi_hest_generic_status *estatus)
>> +{
>> +     if (estatus->raw_data_length)
>> +             return estatus->raw_data_offset + estatus->raw_data_length;
>> +
>> +     return sizeof(*estatus) + estatus->data_length;
>> +}
>> +
>> +#define ESTATUS_PFX  "ESTATUS: "
>> +
>> +#define ESTATUS_ESOURCE_PREALLOC_MAX_SIZE_SIZE       65536
>> +
>> +#define ESTATUS_POOL_MIN_ALLOC_ORDER 3
>> +
>> +/* This is just an estimation for memory pool allocation */
>> +#define ESTATUS_CACHE_AVG_SIZE       512
>> +
>> +#define ESTATUS_CACHES_SIZE  4
>> +
>> +#define ESTATUS_IN_CACHE_MAX_NSEC    10000000000ULL
>> +/* Prevent too many caches are allocated because of RCU */
>> +#define ESTATUS_CACHE_ALLOCED_MAX    (ESTATUS_CACHES_SIZE * 3 / 2)
>> +
>> +#define ESTATUS_CACHE_LEN(estatus_len)                       \
>> +     (sizeof(struct estatus_cache) + (estatus_len))
>> +#define ESTATUS_FROM_CACHE(cache)                    \
>> +     ((struct acpi_hest_generic_status *)            \
>> +      ((struct estatus_cache *)(cache) + 1))
>> +
>> +#define ESTATUS_NODE_LEN(estatus_len)                        \
>> +     (sizeof(struct estatus_node) + (estatus_len))
>> +#define ESTATUS_FROM_NODE(node)                              \
>> +     ((struct acpi_hest_generic_status *)            \
>> +      ((struct estatus_node *)(node) + 1))
>> +
>> +#define ESTATUS_VENDOR_ENTRY_LEN(gdata_len)          \
>> +     (sizeof(struct estatus_vendor_record_entry) + (gdata_len))
>> +#define ESTATUS_GDATA_FROM_VENDOR_ENTRY(vendor_entry)        \
>> +     ((struct acpi_hest_generic_data *)              \
>> +     ((struct estatus_vendor_record_entry *)(vendor_entry) + 1))
>> +
>> +static ATOMIC_NOTIFIER_HEAD(estatus_report_chain);
>> +
>> +struct estatus_vendor_record_entry {
>> +     struct work_struct work;
>> +     int error_severity;
>> +     char vendor_record[];
>> +};
>> +
>> +static struct estatus_cache __rcu *estatus_caches[ESTATUS_CACHES_SIZE];
>> +static atomic_t estatus_cache_alloced;
>> +
>> +static int estatus_panic_timeout __read_mostly = 30;
>> +
>> +static struct gen_pool *estatus_pool;
>> +static DEFINE_MUTEX(estatus_pool_mutex);
>> +
>> +static inline const char *estatus_source_name(struct estatus_source *source)
>> +{
>> +     if (source->ops && source->ops->get_name)
>> +             return source->ops->get_name(source);
>> +
>> +     return "unknown";
>> +}
>> +
>> +static inline size_t estatus_source_max_len(struct estatus_source *source)
>> +{
>> +     if (source->ops && source->ops->get_max_len)
>> +             return source->ops->get_max_len(source);
>> +
>> +     return 0;
>> +}
>> +
>> +static inline enum estatus_notify_mode
>> +estatus_source_notify_mode(struct estatus_source *source)
>> +{
>> +     if (source->ops && source->ops->get_notify_mode)
>> +             return source->ops->get_notify_mode(source);
>> +
>> +     return ESTATUS_NOTIFY_ASYNC;
>> +}
>> +
>> +static inline int estatus_source_get_phys(struct estatus_source *source,
>> +                                       phys_addr_t *addr)
>> +{
>> +     if (!source->ops || !source->ops->get_phys)
>> +             return -EOPNOTSUPP;
>> +
>> +     return source->ops->get_phys(source, addr);
>> +}
>> +
>> +static inline int estatus_source_read(struct estatus_source *source,
>> +                                   phys_addr_t addr, void *buf, size_t len,
>> +                                   enum fixed_addresses fixmap_idx)
>> +{
>> +     if (!source->ops || !source->ops->read)
>> +             return -EOPNOTSUPP;
>> +
>> +     return source->ops->read(source, addr, buf, len, fixmap_idx);
>> +}
>> +
>> +static inline int estatus_source_write(struct estatus_source *source,
>> +                                    phys_addr_t addr, const void *buf,
>> +                                    size_t len,
>> +                                    enum fixed_addresses fixmap_idx)
>> +{
>> +     if (!source->ops || !source->ops->write)
>> +             return -EOPNOTSUPP;
>> +
>> +     return source->ops->write(source, addr, buf, len, fixmap_idx);
>> +}
>> +
>> +static inline void estatus_source_ack(struct estatus_source *source)
>> +{
>> +     if (source->ops && source->ops->ack)
>> +             source->ops->ack(source);
>> +}
>> +
>> +int estatus_pool_init(unsigned int num_ghes)
>> +{
>> +     unsigned long addr, len;
>> +     int rc = 0;
>> +
>> +     mutex_lock(&estatus_pool_mutex);
>> +     if (estatus_pool)
>> +             goto out_unlock;
>> +
>> +     estatus_pool = gen_pool_create(ESTATUS_POOL_MIN_ALLOC_ORDER, -1);
>> +     if (!estatus_pool) {
>> +             rc = -ENOMEM;
>> +             goto out_unlock;
>> +     }
>> +
>> +     if (!num_ghes)
>> +             num_ghes = 1;
>> +
>> +     len = ESTATUS_CACHE_AVG_SIZE * ESTATUS_CACHE_ALLOCED_MAX;
>> +     len += (num_ghes * ESTATUS_ESOURCE_PREALLOC_MAX_SIZE_SIZE);
>> +
>> +     addr = (unsigned long)vmalloc(PAGE_ALIGN(len));
>> +     if (!addr) {
>> +             rc = -ENOMEM;
>> +             goto err_pool_alloc;
>> +     }
>> +
>> +     rc = gen_pool_add(estatus_pool, addr, PAGE_ALIGN(len), -1);
>> +     if (rc)
>> +             goto err_pool_add;
>> +
>> +out_unlock:
>> +     mutex_unlock(&estatus_pool_mutex);
>> +     return rc;
>> +
>> +err_pool_add:
>> +     vfree((void *)addr);
>> +err_pool_alloc:
>> +     gen_pool_destroy(estatus_pool);
>> +     estatus_pool = NULL;
>> +     goto out_unlock;
>> +}
>> +
>> +/**
>> + * estatus_pool_region_free - free previously allocated memory
>> + *                              from the estatus_pool.
>> + * @addr: address of memory to free.
>> + * @size: size of memory to free.
>> + *
>> + * Returns none.
>> + */
>> +void estatus_pool_region_free(unsigned long addr, u32 size)
>> +{
>> +     gen_pool_free(estatus_pool, addr, size);
>> +}
>> +EXPORT_SYMBOL_GPL(estatus_pool_region_free);
>> +
>> +/* Check the top-level record header has an appropriate size. */
>> +static int __estatus_check_estatus(struct estatus_source *source,
>> +                                struct acpi_hest_generic_status *estatus)
>> +{
>> +     u32 len = estatus_len(estatus);
>> +     size_t max_len = estatus_source_max_len(source);
>> +
>> +     if (len < sizeof(*estatus)) {
>> +             pr_warn_ratelimited(FW_WARN ESTATUS_PFX "Truncated error status block!\n");
>> +             return -EIO;
>> +     }
>> +
>> +     if (max_len && len > max_len) {
>> +             pr_warn_ratelimited(FW_WARN ESTATUS_PFX "Invalid error status block length!\n");
>> +             return -EIO;
>> +     }
>> +
>> +     if (cper_estatus_check_header(estatus)) {
>> +             pr_warn_ratelimited(FW_WARN ESTATUS_PFX "Invalid CPER header!\n");
>> +             return -EIO;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +/* Read the CPER block, returning its address, and header in estatus. */
>> +static int __estatus_peek_estatus(struct estatus_source *source,
>> +                               struct acpi_hest_generic_status *estatus,
>> +                               phys_addr_t *buf_paddr,
>> +                               enum fixed_addresses fixmap_idx)
>> +{
>> +     int rc;
>> +
>> +     rc = estatus_source_get_phys(source, buf_paddr);
>> +     if (rc) {
>> +             *buf_paddr = 0;
>> +             pr_warn_ratelimited(FW_WARN ESTATUS_PFX
>> +                                 "Failed to get error status block address for provider %s: %d\n",
>> +                                 estatus_source_name(source), rc);
>> +             return rc;
>> +     }
>> +
>> +     if (!*buf_paddr)
>> +             return -ENOENT;
>> +
>> +     rc = estatus_source_read(source, *buf_paddr, estatus,
>> +                              sizeof(*estatus), fixmap_idx);
>> +     if (rc)
>> +             return rc;
>> +
>> +     if (!estatus->block_status) {
>> +             *buf_paddr = 0;
>> +             return -ENOENT;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static int __estatus_read_estatus(struct estatus_source *source,
>> +                               struct acpi_hest_generic_status *estatus,
>> +                               phys_addr_t buf_paddr,
>> +                               enum fixed_addresses fixmap_idx,
>> +                               size_t buf_len)
>> +{
>> +     int rc;
>> +
>> +     rc = estatus_source_read(source, buf_paddr, estatus, buf_len,
>> +                              fixmap_idx);
>> +     if (rc)
>> +             return rc;
>> +
>> +     if (cper_estatus_check(estatus)) {
>> +             pr_warn_ratelimited(FW_WARN ESTATUS_PFX
>> +                                 "Failed to read error status block for provider %s!\n",
>> +                                 estatus_source_name(source));
>> +             return -EIO;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static int estatus_read_estatus(struct estatus_source *source,
>> +                             struct acpi_hest_generic_status *estatus,
>> +                             phys_addr_t *buf_paddr,
>> +                             enum fixed_addresses fixmap_idx)
>> +{
>> +     int rc;
>> +
>> +     rc = __estatus_peek_estatus(source, estatus, buf_paddr, fixmap_idx);
>> +     if (rc)
>> +             return rc;
>> +
>> +     rc = __estatus_check_estatus(source, estatus);
>> +     if (rc)
>> +             return rc;
>> +
>> +     return __estatus_read_estatus(source, estatus, *buf_paddr,
>> +                                   fixmap_idx, estatus_len(estatus));
>> +}
>> +
>> +static void estatus_clear_estatus(struct estatus_source *source,
>> +                               struct acpi_hest_generic_status *estatus,
>> +                               phys_addr_t buf_paddr,
>> +                               enum fixed_addresses fixmap_idx)
>> +{
>> +     int rc;
>> +
>> +     estatus->block_status = 0;
>> +
>> +     if (!buf_paddr)
>> +             return;
>> +
>> +     rc = estatus_source_write(source, buf_paddr, estatus,
>> +                               sizeof(estatus->block_status), fixmap_idx);
>> +     if (rc)
>> +             pr_warn_ratelimited(FW_WARN ESTATUS_PFX
>> +                                 "Failed to clear error status block for provider %s: %d\n",
>> +                                 estatus_source_name(source), rc);
>> +
>> +     estatus_source_ack(source);
>> +}
>> +
>> +static inline int estatus_severity(int severity)
>> +{
>> +     switch (severity) {
>> +     case CPER_SEV_INFORMATIONAL:
>> +             return ESTATUS_SEV_NO;
>> +     case CPER_SEV_CORRECTED:
>> +             return ESTATUS_SEV_CORRECTED;
>> +     case CPER_SEV_RECOVERABLE:
>> +             return ESTATUS_SEV_RECOVERABLE;
>> +     case CPER_SEV_FATAL:
>> +             return ESTATUS_SEV_PANIC;
>> +     default:
>> +             /* Unknown, go panic */
>> +             return ESTATUS_SEV_PANIC;
>> +     }
>> +}
>> +
>> +static void __estatus_print_estatus(const char *pfx,
>> +                                 struct estatus_source *source,
>> +                                 const struct acpi_hest_generic_status *estatus)
>> +{
>> +     static atomic_t seqno;
>> +     unsigned int curr_seqno;
>> +     char pfx_seq[64];
>> +     char seq_tag[64];
>> +     const char *name = estatus_source_name(source);
>> +     const char *level = pfx;
>> +     char level_char = '4';
>> +
>> +     if (!level) {
>> +             if (estatus_severity(estatus->error_severity) <=
>> +                 ESTATUS_SEV_CORRECTED)
>> +                     level = KERN_WARNING;
>> +             else
>> +                     level = KERN_ERR;
>> +     }
>> +
>> +     if (level[0] == KERN_SOH_ASCII && level[1])
>> +             level_char = level[1];
>> +     else if (estatus_severity(estatus->error_severity) > ESTATUS_SEV_CORRECTED)
>> +             level_char = '3';
>> +
>> +     curr_seqno = atomic_inc_return(&seqno);
>> +     snprintf(seq_tag, sizeof(seq_tag), "{%u}" HW_ERR, curr_seqno);
>> +     snprintf(pfx_seq, sizeof(pfx_seq), "%s%s", level, seq_tag);
>> +     estatus_log_hw_error(level_char, seq_tag, name);
>> +     cper_estatus_print(pfx_seq, estatus);
>> +}
>> +
>> +static int estatus_print_estatus(const char *pfx,
>> +                              struct estatus_source *source,
>> +                              const struct acpi_hest_generic_status *estatus)
>> +{
>> +     /* Not more than 2 messages every 5 seconds */
>> +     static DEFINE_RATELIMIT_STATE(ratelimit_corrected, 5 * HZ, 2);
>> +     static DEFINE_RATELIMIT_STATE(ratelimit_uncorrected, 5 * HZ, 2);
>> +     struct ratelimit_state *ratelimit;
>> +
>> +     if (estatus_severity(estatus->error_severity) <= ESTATUS_SEV_CORRECTED)
>> +             ratelimit = &ratelimit_corrected;
>> +     else
>> +             ratelimit = &ratelimit_uncorrected;
>> +     if (__ratelimit(ratelimit)) {
>> +             __estatus_print_estatus(pfx, source, estatus);
>> +             return 1;
>> +     }
>> +     return 0;
>> +}
>> +
>> +/*
>> + * GHES error status reporting throttle, to report more kinds of
>> + * errors, instead of just most frequently occurred errors.
>> + */
>> +static int estatus_cached(struct acpi_hest_generic_status *estatus)
>> +{
>> +     u32 len;
>> +     int i, cached = 0;
>> +     unsigned long long now;
>> +     struct estatus_cache *cache;
>> +     struct acpi_hest_generic_status *cache_estatus;
>> +
>> +     len = estatus_len(estatus);
>> +     rcu_read_lock();
>> +     for (i = 0; i < ESTATUS_CACHES_SIZE; i++) {
>> +             cache = rcu_dereference(estatus_caches[i]);
>> +             if (!cache)
>> +                     continue;
>> +             if (len != cache->estatus_len)
>> +                     continue;
>> +             cache_estatus = ESTATUS_FROM_CACHE(cache);
>> +             if (memcmp(estatus, cache_estatus, len))
>> +                     continue;
>> +             atomic_inc(&cache->count);
>> +             now = sched_clock();
>> +             if (now - cache->time_in < ESTATUS_IN_CACHE_MAX_NSEC)
>> +                     cached = 1;
>> +             break;
>> +     }
>> +     rcu_read_unlock();
>> +     return cached;
>> +}
>> +
>> +static struct estatus_cache *estatus_cache_alloc(struct estatus_source *source,
>> +                                              struct acpi_hest_generic_status *estatus)
>> +{
>> +     int alloced;
>> +     u32 len, cache_len;
>> +     struct estatus_cache *cache;
>> +     struct acpi_hest_generic_status *cache_estatus;
>> +
>> +     alloced = atomic_add_return(1, &estatus_cache_alloced);
>> +     if (alloced > ESTATUS_CACHE_ALLOCED_MAX) {
>> +             atomic_dec(&estatus_cache_alloced);
>> +             return NULL;
>> +     }
>> +     len = estatus_len(estatus);
>> +     cache_len = ESTATUS_CACHE_LEN(len);
>> +     cache = (void *)gen_pool_alloc(estatus_pool, cache_len);
>> +     if (!cache) {
>> +             atomic_dec(&estatus_cache_alloced);
>> +             return NULL;
>> +     }
>> +     cache_estatus = ESTATUS_FROM_CACHE(cache);
>> +     memcpy(cache_estatus, estatus, len);
>> +     cache->estatus_len = len;
>> +     atomic_set(&cache->count, 0);
>> +     cache->source = source;
>> +     cache->time_in = sched_clock();
>> +     return cache;
>> +}
>> +
>> +static void estatus_cache_rcu_free(struct rcu_head *head)
>> +{
>> +     struct estatus_cache *cache;
>> +     u32 len;
>> +
>> +     cache = container_of(head, struct estatus_cache, rcu);
>> +     len = estatus_len(ESTATUS_FROM_CACHE(cache));
>> +     len = ESTATUS_CACHE_LEN(len);
>> +     gen_pool_free(estatus_pool, (unsigned long)cache, len);
>> +     atomic_dec(&estatus_cache_alloced);
>> +}
>> +
>> +static void estatus_cache_add(struct estatus_source *source,
>> +                           struct acpi_hest_generic_status *estatus)
>> +{
>> +     unsigned long long now, duration, period, max_period = 0;
>> +     struct estatus_cache *cache, *new_cache;
>> +     struct estatus_cache __rcu *victim;
>> +     int i, slot = -1, count;
>> +
>> +     new_cache = estatus_cache_alloc(source, estatus);
>> +     if (!new_cache)
>> +             return;
>> +
>> +     rcu_read_lock();
>> +     now = sched_clock();
>> +     for (i = 0; i < ESTATUS_CACHES_SIZE; i++) {
>> +             cache = rcu_dereference(estatus_caches[i]);
>> +             if (!cache) {
>> +                     slot = i;
>> +                     break;
>> +             }
>> +             duration = now - cache->time_in;
>> +             if (duration >= ESTATUS_IN_CACHE_MAX_NSEC) {
>> +                     slot = i;
>> +                     break;
>> +             }
>> +             count = atomic_read(&cache->count);
>> +             period = duration;
>> +             do_div(period, (count + 1));
>> +             if (period > max_period) {
>> +                     max_period = period;
>> +                     slot = i;
>> +             }
>> +     }
>> +     rcu_read_unlock();
>> +
>> +     if (slot != -1) {
>> +             /*
>> +              * Use release semantics to ensure that estatus_cached()
>> +              * running on another CPU will see the updated cache fields if
>> +              * it can see the new value of the pointer.
>> +              */
>> +             victim = xchg_release(&estatus_caches[slot],
>> +                                   RCU_INITIALIZER(new_cache));
>> +
>> +             /*
>> +              * At this point, victim may point to a cached item different
>> +              * from the one based on which we selected the slot. Instead of
>> +              * going to the loop again to pick another slot, let's just
>> +              * drop the other item anyway: this may cause a false cache
>> +              * miss later on, but that won't cause any problems.
>> +              */
>> +             if (victim)
>> +                     call_rcu(&unrcu_pointer(victim)->rcu,
>> +                              estatus_cache_rcu_free);
>> +     }
>> +}
>> --
>> 2.43.0
>>

Thanks,
Ahmed

