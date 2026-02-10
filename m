Return-Path: <linux-acpi+bounces-20918-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFOiJGH2imn2OwAAu9opvQ
	(envelope-from <linux-acpi+bounces-20918-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Feb 2026 10:12:01 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C66D118A2F
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Feb 2026 10:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 324803017F94
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Feb 2026 09:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E209533F381;
	Tue, 10 Feb 2026 09:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="n05Y8xfY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E90333D6D4;
	Tue, 10 Feb 2026 09:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770714717; cv=none; b=u/9wi0QQ1uKtkEoxO0jd6mtX+SrV/s/SpL6A5No4I07zJFErWAHSfjoaVPKFnkF2JzK2VJdhBcBA8NhejriLxGunc2zjrkP3VnnH7XMlxZQ/rVFUdYV3Th1eTDb+NZnjKlT90nml3uskXljwRbLqpeIsnnL9iVasKNYfLVeQxPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770714717; c=relaxed/simple;
	bh=XyqsN6UDvQ6iELowQWWIS8hFABzA5KYXEYfbcIeqyd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CoMG06EV879NTcMn6QS/vWqcEw+dzpOX2UT6YE34+tEmc1AfxEOel2Wrk78SwP2li/AE28fX34idIDz76POBywj8/z2vTEhpwPfErohUQQ0/jtJTO7JRWznLd+yhcVJ+Zt+O7AeJJ17zv+MgN9Ia7oKvPDlk8u35eXVdawo9lRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=n05Y8xfY; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=szkXnntPPaw/iZii5G+5XATrzVuI/KG7DFWma9HeAR8=; b=n05Y8xfYet9S8xJDuQsHgj4piC
	ee31Csk//iNiTDywJaIpqYXUvQ1SJRh38fr4nArhiXJmu2Bxg+ZrTfhmm4+hm6vRg1pLoQ5T9zFT3
	Bag9chsy4wtvp96lUZJByvC/yHFR0FIaqc4sk1OMqvWUTAEN7ABPrHqByNSGHlei6sPV7cuCO/A+t
	4g/camxqrL4zVki8U7vMgru7o76RUR0ArIzD9aKRvYFEETI7bNFC242KXZltxjwYsrV+sQdJHtUlg
	FbVIrjbUEvl8UxF+4RNRk812Tl7QORBWBT+tbUPMOVnn9DC/Gnvl6Um683Cpq/9zguhmxY3m0e9yt
	Cb4BAFFg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vpjmc-00A9cQ-D8; Tue, 10 Feb 2026 09:11:46 +0000
Date: Tue, 10 Feb 2026 01:11:41 -0800
From: Breno Leitao <leitao@debian.org>
To: akpm@linux-foundation.org, bhe@redhat.com
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, dyoung@redhat.com, 
	tony.luck@intel.com, xueshuai@linux.alibaba.com, vgoyal@redhat.com, 
	zhiquan1.li@intel.com, olja@meta.com, kernel-team@meta.com
Subject: Re: [PATCH v2 0/2] vmcoreinfo: Expose hardware error recovery
 statistics via sysfs
Message-ID: <aYr154HW4IiIw3PH@gmail.com>
References: <20260202-vmcoreinfo_sysfs-v2-0-8f3b5308b894@debian.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202-vmcoreinfo_sysfs-v2-0-8f3b5308b894@debian.org>
X-Debian-User: leitao
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[debian.org];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-20918-lists,linux-acpi=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+]
X-Rspamd-Queue-Id: 3C66D118A2F
X-Rspamd-Action: no action

Hello Andrew,

On Mon, Feb 02, 2026 at 06:27:38AM -0800, Breno Leitao wrote:
> The kernel already tracks recoverable hardware errors (CPU, memory, PCI,
> CXL, etc.) in the hwerr_data array for vmcoreinfo crash dump analysis.
> However, this data is only accessible after a crash.
>
> This series adds a sysfs directory at /sys/kernel/hwerr_recovery_stats/ to
> expose these statistics at runtime, allowing monitoring tools to track
> hardware health without requiring a kernel crash.
>
> The directory contains one file per error subsystem:
>   /sys/kernel/hwerr_recovery_stats/{cpu, memory, pci, cxl, others}
>
> Each file contains a single integer representing the error count.
>
> This is useful for:
> - Proactive detection of failing hardware components
> - Time-series tracking of recoverable errors
> - System health monitoring in cloud environments

Is there a chance this could be included in the 6.20 merge window?

Thanks,
--breno

