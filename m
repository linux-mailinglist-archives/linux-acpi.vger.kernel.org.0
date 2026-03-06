Return-Path: <linux-acpi+bounces-21471-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHN5GgQ6qmmPNgEAu9opvQ
	(envelope-from <linux-acpi+bounces-21471-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 03:20:52 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 703DC21A8F6
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 03:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8EA36300C572
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Mar 2026 02:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2F933B6C2;
	Fri,  6 Mar 2026 02:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="mwQ0hEls"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BD32DEA9B;
	Fri,  6 Mar 2026 02:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772763646; cv=none; b=A0CsfrjMSMlo5rNXsm4eoNKr9cQYTJTrVFymHfvhFzQJUO6hF8SLBHH6KlRD2KtUy0+zfLP30wCsiJFHlf/s/Dyem4GBAgDnB1JwiGfFSqXfyfffok0YqMQAbL4i+caLS7+gZfc4ehiHtonESOx/tcmHYf/5iOwHVot+QzwF1YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772763646; c=relaxed/simple;
	bh=/6LmCpQyifPooxJtvigqmg0itVhBM9bRxZUXzpxx/jg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=B3Mmsiq1GIB87KbdkcMCcWX3EjvYjARn9b/9jAvbK/Cdfmt9OGn8ijz1ZhJNrNYyTT0VyBO/a93nsRQXRJQOhmjGwh2hvMtIz/Lc8EAi6SoeQ5+0J5EaLwci1+RMo5oCKq7cbH9fNQ60GmyBRUsndsO91C75T20vt/aP9sjUt74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=mwQ0hEls; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=63G8v1SmaEgTYdfJTyL6ai9ialxWPrLA+2LQvndcIO8=;
	b=mwQ0hElsHFrGBY+A3e2KK7IjK1rv0TAkhpGRCNBsH64nmtcpuKi+oWynKmiaLosb7CItekbvd
	7Ur566TDm1xinylYA/X8Q+XD14TchvZjfjiy4Cw81UnxzrRRUjK7AmWvdX6Y/jbCiVwouEIKPd8
	GTSznfAxZkaV5F0QVZ6bA9E=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4fRqkq3J7bz1prLV;
	Fri,  6 Mar 2026 10:15:47 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id DF7C52022B;
	Fri,  6 Mar 2026 10:20:41 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 6 Mar 2026 10:20:40 +0800
Message-ID: <e33affb0-e8f8-48fc-b344-90fea722d30b@huawei.com>
Date: Fri, 6 Mar 2026 10:20:40 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI/TPH: Fix get cpu steer-tag fail on ARM64 platform
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: Huacai Chen <chenhuacai@kernel.org>, <linux-pci@vger.kernel.org>,
	<bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Paul Walmsley
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
References: <20260303003625.39035-1-fengchengwen@huawei.com>
 <20260305083650.54611-1-fengchengwen@huawei.com>
 <CAAhV-H4xZsyLdzswPxPGHoQNd4LKXrTOL-oPGZHyVt8dj0xu6A@mail.gmail.com>
 <795a9167-6c49-4c7c-9a36-385bf543cacf@huawei.com>
 <20260305145403.0000394e@huawei.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260305145403.0000394e@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk500009.china.huawei.com (7.202.194.94)
X-Rspamd-Queue-Id: 703DC21A8F6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[41];
	TAGGED_FROM(0.00)[bounces-21471-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fengchengwen@huawei.com,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,huawei.com:dkim,huawei.com:mid]
X-Rspamd-Action: no action

On 3/5/2026 10:54 PM, Jonathan Cameron wrote:
> 
>>>> +       ret = acpi_get_cpu_acpi_id(cpu);  
>>> Can we use get_acpi_id_for_cpu() directly? Then just x86 needs a wrapper.  
>>
>> Yes, it indeed simple.
>>
>> But I prefer to have the acpi_ prefix for such API names because it's a cross-subsystem API reference.
> 
> Can we just do a global rename of get_acpi_id_for_cpu() as a precursor
> patch?  Then this just becomes adding x86 implementation and using
> it on all architectures.

Sounds good, done in v3

Thanks

> 
> J
> 
> 


