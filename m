Return-Path: <linux-acpi+bounces-21419-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGmHO2GaqWm7AgEAu9opvQ
	(envelope-from <linux-acpi+bounces-21419-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 15:59:45 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3F32140B3
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 15:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3DA29300A336
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 14:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51DD3AE718;
	Thu,  5 Mar 2026 14:54:11 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498B1394786;
	Thu,  5 Mar 2026 14:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772722451; cv=none; b=I13hV5xF2bvPGZ4V5OqbHKIfjIQYlEhix0U4P9pE2rl5CJ6gV88y4YqI9HuJ0PLjSRC6StGASO0ktjFqNZjVvN2rB7MOUUWSPzqbfKVBZpmxF6Dwb0AJJomz3M/y3rtw0Z2UeV6R0K8oygN4Abpk4H/4byL5IgSKExDEd12YMVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772722451; c=relaxed/simple;
	bh=e9jryshronyw/hf+XUuhNDCAysBrxR3TuZBcZe/Tgdc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yt+0cO9A0zsOl6GkOTDcmthYizhX/imDz2pjvaXVw21CPvvWv6m+XsELC0CkLLcdGnMPnq56PPkiLQ1jjnnJZPNml+Jf0A+DMqwEkBwUuh3/6ziEBvrTd0lsQ4ViFkKqhPQQM8TEwxo+liLOd95TmLv+54BBiCwtx0zqM78NAno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fRXb85pd4zHnGkd;
	Thu,  5 Mar 2026 22:53:08 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id A5CEC4056B;
	Thu,  5 Mar 2026 22:54:06 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 5 Mar
 2026 14:54:04 +0000
Date: Thu, 5 Mar 2026 14:54:03 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: fengchengwen <fengchengwen@huawei.com>
CC: Huacai Chen <chenhuacai@kernel.org>, <linux-pci@vger.kernel.org>,
	<bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, WANG Xuerui <kernel@xen0n.name>, "Paul Walmsley"
	<pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Andy Gospodarek
	<andrew.gospodarek@broadcom.com>, Eric Van Tassell <Eric.VanTassell@amd.com>,
	Ajit Khaparde <ajit.khaparde@broadcom.com>, Somnath Kotur
	<somnath.kotur@broadcom.com>, <linux-acpi@vger.kernel.org>,
	<wei.huang2@amd.com>, <wangzhou1@hisilicon.com>, <wanghuiqiang@huawei.com>,
	<liuyonglong@huawei.com>, <stable@vger.kernel.org>, <jeremy.linton@arm.com>,
	<sunilvl@ventanamicro.com>, <sunilvl@oss.qualcomm.com>,
	<chenhuacai@loongson.cn>, <wangliupu@loongson.cn>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <loongarch@lists.linux.dev>,
	<linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v2] PCI/TPH: Fix get cpu steer-tag fail on ARM64
 platform
Message-ID: <20260305145403.0000394e@huawei.com>
In-Reply-To: <795a9167-6c49-4c7c-9a36-385bf543cacf@huawei.com>
References: <20260303003625.39035-1-fengchengwen@huawei.com>
	<20260305083650.54611-1-fengchengwen@huawei.com>
	<CAAhV-H4xZsyLdzswPxPGHoQNd4LKXrTOL-oPGZHyVt8dj0xu6A@mail.gmail.com>
	<795a9167-6c49-4c7c-9a36-385bf543cacf@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml500005.china.huawei.com (7.214.145.207)
X-Rspamd-Queue-Id: DA3F32140B3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[41];
	TAGGED_FROM(0.00)[bounces-21419-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathan.cameron@huawei.com,linux-acpi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action


> >> +       ret = acpi_get_cpu_acpi_id(cpu);  
> > Can we use get_acpi_id_for_cpu() directly? Then just x86 needs a wrapper.  
> 
> Yes, it indeed simple.
> 
> But I prefer to have the acpi_ prefix for such API names because it's a cross-subsystem API reference.

Can we just do a global rename of get_acpi_id_for_cpu() as a precursor
patch?  Then this just becomes adding x86 implementation and using
it on all architectures.

J



