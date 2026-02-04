Return-Path: <linux-acpi+bounces-20846-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Mf9Jj+pgmk2XgMAu9opvQ
	(envelope-from <linux-acpi+bounces-20846-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Feb 2026 03:04:47 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3CBE0AB4
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Feb 2026 03:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3A78C30093B8
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Feb 2026 02:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB9A23D290;
	Wed,  4 Feb 2026 02:04:43 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF60B1C860A;
	Wed,  4 Feb 2026 02:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770170682; cv=none; b=euAwucCz3vZR/qextix0BJq1kN508zGnkIqbmODCKZfKTgl1CER99HsDyhox61Y+yothUU9KJwNmumG9NNiMn3mrtlIhg1QfOIVuBb1+DMY/+meaq3Kay++U1GUAnLM2mpKdrezlH8oyM3phWqfYRrnKCxBVF18OUytPOiUC/fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770170682; c=relaxed/simple;
	bh=XY9cc/cOTWwR0ib1CbJ9KA/iVeU+PThpH9/G+HUfZL4=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xla52aJfjWlqgbPTr6eH/fF8lzUzBcT985QOoFLwWRQGBpIBB0UqyQKIPvKV0KXiLx78uRFx9WDHNlnoxFercjFs8BiXiVH5RqqvH/Q1EU1C7vgo93qHPIzK/JoXUZRODRKkVXu4jAEmOfHEylaJbYczBjEOKEuketcer0hGVbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas3t1770170615t766t05890
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [36.20.47.234])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 17962103746675529112
To: "'Bjorn Helgaas'" <helgaas@kernel.org>
Cc: "'Rafael J. Wysocki'" <rafael@kernel.org>,
	"'Tony Luck'" <tony.luck@intel.com>,
	"'Borislav Petkov'" <bp@alien8.de>,
	"'Hanjun Guo'" <guohanjun@huawei.com>,
	"'Mauro Carvalho Chehab'" <mchehab@kernel.org>,
	"'Shuai Xue'" <xueshuai@linux.alibaba.com>,
	"'Len Brown'" <lenb@kernel.org>,
	"'Shiju Jose'" <shiju.jose@huawei.com>,
	"'Bjorn Helgaas'" <bhelgaas@google.com>,
	<linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <23A877C77DF26B7C+20260203021233.8178-1-jiawenwu@trustnetic.com> <20260203225509.GA195397@bhelgaas>
In-Reply-To: <20260203225509.GA195397@bhelgaas>
Subject: RE: [PATCH] ACPI: APEI: Avoid NULL pointer dereference in ghes_estatus_pool_region_free
Date: Wed, 4 Feb 2026 10:03:34 +0800
Message-ID: <06ed01dc957a$7823c0b0$686b4210$@trustnetic.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQKfcgIpykHaIb3qnAJzzZnnq5yTUbPsDkJA
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OSV8m3GRFcPJHurJsLpRnhLxodfwP70Szngrm+V4Sf99uD1Z3NL3tf72
	GQ3+vc+hTDFg1EslvnlGeC1cQ8i/KsaV/GUqDYIj3EuNfLXivXcsCIru/DC6iY0k9N3TZmY
	9joDLL04PNguZq5BBLYcvLdSFR6J1kjXKN0W4jVqct4wRqnX6VLirMHlb8NAf9d7uOw0P+N
	Xn31i8b0YNx0aTO5bge4xaoS5wctz75faxJIgRSvQ52liBZFrKHIVQZaAxcPEnSGwGeVXti
	hyT1r97gfYbhTiriuAB4Ado9aWJI77vyaHK84esdJl9irefdyKHOSgE39s3TgPz6VKlQLEH
	ue8s9ckD5xIm54n1N5By1ThJtsk72FyeD96GbxuGqIhuSLZgCMUhbHJpGsJcSvaZFTC2rG2
	8mo7gnbgcXKBtB5L04sAfC5sFtdqxMyEccwuCmhFN1oE6CxIAjZDN1ZuARNEXwWLLBcb+4p
	IOew5UcptUyqRpwFiB2IuOhlchAHSN1f5ExhSaBO/xDrrX6OzZeWAgKjm6UN6lz2YXdzpFV
	tP2LrL+tzCCubJiqrAdoGhuA1HKMLdxcUVfWZujDfTBgvYJExzVji7N5yFh3L1Yaxk1gUyZ
	8VS9HS5QJnLJHOXIdVgosUe2HzycwxJNAjWmB+0gO9vUokJjLxxLcgIrVydZgFT/E8m5Y6M
	FoBQZKHMYpgnGdgykbotvUkTUexDL13PuipZdZJaa1elunGU64kuOaogthEdawpvQSPGN8E
	BA2LGmKW2o1dv76cAHG7/lgyd8yqc7iAvB6iofu1kgkEhVp1/mXNM/MowhaMUU1SrSUgfzU
	3brPQOBnr2D+dqPxoEMWzydpHwjr4yOX25DW8OXHQ1SUKyyd4+/KA/HHngv7x1vwrmJ+EEV
	ECONPs5em+tO9oACjNJY7ZHTIcs7edw9ywE3ASjhKPAd5Q/Z7r4KyK6pNXqleHamQ0csm8m
	r398Y7vgbEMxvWtXyPg23CXx42xgz4Ye+8yrM7Uyp6jJlEviBysOd4CxW8GmTRJHAcp4HvU
	b6fjdVGZs8TwWk04A70JGD46dOmHOpXPspkzbpZA==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	FROM_EXCESS_BASE64(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20846-lists,linux-acpi=lfdr.de];
	DMARC_NA(0.00)[trustnetic.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.984];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BA3CBE0AB4
X-Rspamd-Action: no action

On Wed, Feb 4, 2026 6:55 AM, Bjorn Helgaas wrote:
> On Tue, Feb 03, 2026 at 10:12:32AM +0800, Jiawen Wu wrote:
> > The function ghes_estatus_pool_region_free() is exported and be called
> > by the PCIe AER recovery path, which unconditionally invokes it to free
> > aer_capability_regs memory.
> >
> > Although current AER usage assumes memory comes from the GHES pool,
> > robustness requires guarding against pool unavailability. Add a NULL check
> > before calling gen_pool_free() to prevent crashes when the pool is not
> > initialized. This also makes the API safer for potential future use by
> > non-GHES callers.
> 
> I'm not sure what you mean by "pool unavailability."  I think getting
> here with ghes_estatus_pool==NULL means we have a logic error
> somewhere, and I don't think we should silently hide that error.
> 
> I'm generally in favor of *not* checking so we find out if the caller
> forgot to keep track of the pointer correctly.

"pool unavailability" means that when I attempt to call
aer_recover_queue() in a ethernet driver, which does not create
ghes_estatus_pool, it leads to a NULL pointer dereference. 



