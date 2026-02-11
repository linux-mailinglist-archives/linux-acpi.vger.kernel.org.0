Return-Path: <linux-acpi+bounces-20926-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QND7L/bii2kVcgAAu9opvQ
	(envelope-from <linux-acpi+bounces-20926-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Feb 2026 03:01:26 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2655A1209CB
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Feb 2026 03:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABA843005D34
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Feb 2026 02:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0F12E62DC;
	Wed, 11 Feb 2026 02:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gfNlU6Ab"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A8E2D6407
	for <linux-acpi@vger.kernel.org>; Wed, 11 Feb 2026 02:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770775281; cv=none; b=tFimvib1fcFbh+wDg58gDm+SgeOTsPFs9NFbilb55GAe4nP6ceBaTjq6uoHyLR6cYPa/zPm0DCGBLfwqSA/DrzH5Ej554JdIY7f3O8zaU4aEHjBE9fZK6wnJmMufGG4p8MJg0AfDDlCddyzPBGG/OM0VSA/CD0IWmcqcc6TAAJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770775281; c=relaxed/simple;
	bh=ypyZ9xtcmysuknopsxCZTenqJlx1ip0djWxaYL+IebA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KfYvXb4qofn/PFAerK/1AaZvNWSbpxJCqYP8WEhUvU2w+CntHy2QiwmDsaSNXYin+t/pxiJZ9J2wZjTtSYx1yY8a2c/UFQLkwMn37UoHy0mVtGreL9PaCXSMttyExkn27WGCVyFKP4GTYuhmnDf5eNp/6Ar1wLwsLqqRXUkwuaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gfNlU6Ab; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770775279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l0WoVHm/wpm3VeRQ1Osn5LCFxSpKgojYv3/htjRdiuo=;
	b=gfNlU6AbMyjnzqSkO3J3wL7VwH5K4XeoaxGUoKuC8Yc4RfCeIlZqPupMd65+NxEHH1xRMN
	F33VA9Y6n3uA+FOeOgeeDUCAKF3ostGqwki+CcrVBoG0RZJwlbd1wjtnyjOjUK8fHCxvPC
	S04mjqv0UtVwTppsJvLn5higbNFcIqg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-YPSwdpkMMt-d41HpU6MD2g-1; Tue,
 10 Feb 2026 21:01:15 -0500
X-MC-Unique: YPSwdpkMMt-d41HpU6MD2g-1
X-Mimecast-MFC-AGG-ID: YPSwdpkMMt-d41HpU6MD2g_1770775274
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 455D418003F5;
	Wed, 11 Feb 2026 02:01:13 +0000 (UTC)
Received: from localhost (unknown [10.72.112.131])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 18F421800464;
	Wed, 11 Feb 2026 02:01:09 +0000 (UTC)
Date: Wed, 11 Feb 2026 10:01:05 +0800
From: Baoquan He <bhe@redhat.com>
To: Breno Leitao <leitao@debian.org>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, dyoung@redhat.com, tony.luck@intel.com,
	xueshuai@linux.alibaba.com, vgoyal@redhat.com,
	zhiquan1.li@intel.com, olja@meta.com, kernel-team@meta.com
Subject: Re: [PATCH v2 1/2] vmcoreinfo: expose hardware error recovery
 statistics via sysfs
Message-ID: <aYvi4Y_HNqk_u1-v@fedora>
References: <20260202-vmcoreinfo_sysfs-v2-0-8f3b5308b894@debian.org>
 <20260202-vmcoreinfo_sysfs-v2-1-8f3b5308b894@debian.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202-vmcoreinfo_sysfs-v2-1-8f3b5308b894@debian.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20926-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhe@redhat.com,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-acpi];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2655A1209CB
X-Rspamd-Action: no action

Hi Breno,

On 02/02/26 at 06:27am, Breno Leitao wrote:
> Add a sysfs directory at /sys/kernel/hwerr_recovery_stats/ to expose
> hardware error recovery statistics that are already tracked by the
> kernel. This allows userspace monitoring tools to track recovered
> hardware errors without requiring kernel crashes.
> 
> This is useful to track recoverable hardware errors in a time series,
> even if the host doesn't crash.
> 
> The sysfs directory contains one file per error subsystem:
> 
>   /sys/kernel/hwerr_recovery_stats/cpu     - CPU-related errors (MCE, ARM errors)
>   /sys/kernel/hwerr_recovery_stats/memory  - Memory-related errors
>   /sys/kernel/hwerr_recovery_stats/pci     - PCI/PCIe AER non-fatal errors
>   /sys/kernel/hwerr_recovery_stats/cxl     - CXL errors
>   /sys/kernel/hwerr_recovery_stats/others  - Other hardware errors
> 
> Each file contains a single integer representing the count of recovered
> errors for that subsystem.
> 
> These statistics provide visibility into the health of the system's
> hardware and can be used by system administrators to proactively detect
> failing components before they cause system crashes.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  kernel/vmcore_info.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/kernel/vmcore_info.c b/kernel/vmcore_info.c
> index e2784038bbed7..b7fcd21be7c59 100644
> --- a/kernel/vmcore_info.c
> +++ b/kernel/vmcore_info.c

Since we agreed hwerr_recovery_stats has nothing to do with vmcore, it
seems inappropriate to put its sysfs handling code in
kernel/vmcore_info.c. File kernel/vmcore_info.c is only used to build
vmcore info for later vmcore dumping. And hwerr_log_error_type() should
not be put in kernel/vmcore_info.c. either. I didn't check this
carefully before, sorry. Please reconsider if these can be handled better.

Thanks
Baoquan

> @@ -6,6 +6,8 @@
>  
>  #include <linux/buildid.h>
>  #include <linux/init.h>
> +#include <linux/kobject.h>
> +#include <linux/sysfs.h>
>  #include <linux/utsname.h>
>  #include <linux/vmalloc.h>
>  #include <linux/sizes.h>
> @@ -139,6 +141,56 @@ void hwerr_log_error_type(enum hwerr_error_type src)
>  }
>  EXPORT_SYMBOL_GPL(hwerr_log_error_type);
>  
> +/* sysfs interface for hardware error recovery statistics */
> +#define HWERR_ATTR_RO(_name, _type)					\
> +static ssize_t _name##_show(struct kobject *kobj,			\
> +			    struct kobj_attribute *attr, char *buf)	\
> +{									\
> +	return sysfs_emit(buf, "%d\n",					\
> +			  atomic_read(&hwerr_data[_type].count));	\
> +}									\
> +static struct kobj_attribute hwerr_##_name##_attr = __ATTR_RO(_name)
> +
> +HWERR_ATTR_RO(cpu, HWERR_RECOV_CPU);
> +HWERR_ATTR_RO(memory, HWERR_RECOV_MEMORY);
> +HWERR_ATTR_RO(pci, HWERR_RECOV_PCI);
> +HWERR_ATTR_RO(cxl, HWERR_RECOV_CXL);
> +HWERR_ATTR_RO(others, HWERR_RECOV_OTHERS);
> +
> +static struct attribute *hwerr_recovery_stats_attrs[] = {
> +	&hwerr_cpu_attr.attr,
> +	&hwerr_memory_attr.attr,
> +	&hwerr_pci_attr.attr,
> +	&hwerr_cxl_attr.attr,
> +	&hwerr_others_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group hwerr_recovery_stats_group = {
> +	.attrs = hwerr_recovery_stats_attrs,
> +};
> +
> +static struct kobject *hwerr_recovery_stats_kobj;
> +
> +static int __init hwerr_recovery_stats_init(void)
> +{
> +	hwerr_recovery_stats_kobj = kobject_create_and_add("hwerr_recovery_stats",
> +							   kernel_kobj);
> +	if (!hwerr_recovery_stats_kobj) {
> +		pr_warn("Failed to create hwerr_recovery_stats kobject\n");
> +		return -ENOMEM;
> +	}
> +
> +	if (sysfs_create_group(hwerr_recovery_stats_kobj,
> +			       &hwerr_recovery_stats_group)) {
> +		kobject_put(hwerr_recovery_stats_kobj);
> +		pr_warn("Failed to create hwerr_recovery_stats sysfs group\n");
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
>  static int __init crash_save_vmcoreinfo_init(void)
>  {
>  	vmcoreinfo_data = (unsigned char *)get_zeroed_page(GFP_KERNEL);
> @@ -248,6 +300,9 @@ static int __init crash_save_vmcoreinfo_init(void)
>  	arch_crash_save_vmcoreinfo();
>  	update_vmcoreinfo_note();
>  
> +	/* Create /sys/kernel/hwerr_recovery_stats/ directory */
> +	hwerr_recovery_stats_init();
> +
>  	return 0;
>  }
>  
> 
> -- 
> 2.47.3
> 


