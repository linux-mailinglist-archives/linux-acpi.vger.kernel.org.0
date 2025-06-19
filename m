Return-Path: <linux-acpi+bounces-14465-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1715AE044F
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Jun 2025 13:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74BEB16502C
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Jun 2025 11:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FAF22D7A3;
	Thu, 19 Jun 2025 11:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="aTb7GInj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38F8221704;
	Thu, 19 Jun 2025 11:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750333802; cv=pass; b=a+fPRWRV9XbwOWl9edQGYj+y0cwA5DMEqd5TsAJo/IKgY0uxMwzn+Gt9AAOQgB7jUyGBVI3Ue3L1ELtKABKbFtVQ0WZIMNbnCp9P1yY4m/uQlqVCbqoflw7AM0VJQm4Ox+SuMapx2UfPluaNkBfzXMoJoKb9tDCH+JI0FuJYoPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750333802; c=relaxed/simple;
	bh=x9mmf/4+sS8EjTOOF+TIHjEh6qmrc/lZ1PIXobh6WK4=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=eJZoszy7rR6k0MZZUI9suJv1wORAdTYy9VB2mbwBBL3gu4d5EP89N5OnQAKL4geTMvuQ6VpPN5e8wjKuRJSeklN2xzBwu8IGd49DeI8Rcu2+sRbf+JAcQOtMowPIilC4eM/WQ6n4wd1OqyhTp+W/mwUv6pCc8lbBjFV2LL0lBsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=aTb7GInj; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1750333773; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=k2ECfxzVPE3LQGdP+afxdo2PgIFbQNaYLKpjrIynKpY3yybZYHJLxFiB/dmI8efnc8rUsIKNoNwmqPz2EPQsVULAfgO091mxnTABvvvCrSKmqben6qk4NSJSs+sScEpScGuZ6eLpwubPC3oaOrZbonPHtnN6Jh9cEJNxrk88RxU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750333773; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=MFwa0VaeKDYvJD+4TaNeC8PvG0ohNrCLdil12mUnuYE=; 
	b=iEW5xAAgezzbdxSNsZDDk3VsivFivtHmB6Po0joThn2weblF6yQzIy1L5IIU/InlzMjKoERnoZysKA3nOopWpeP9uCrELVxC2mLS9mr5QiqoSlnlQKehI25R/SUBNYmc1a5tAhM+UCR2sybwqLItzf5Qbu6stjltqs8Rfd2lbLw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750333773;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=Date:Date:From:From:To:To:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=MFwa0VaeKDYvJD+4TaNeC8PvG0ohNrCLdil12mUnuYE=;
	b=aTb7GInjoKUCOXMf7yztMIKG511RPdIWJjMtGuN08TR/Y1jgM1569zm5xdN3g09d
	zLZW5wOVfmSUv/fb9z0GjJg9C2ymeJy2HAqhBfCrCGJzn66/7wD5IyxD+rzdnMIpqTH
	wXQjkb/XSpDfK3ExgNAft8FJbMrF8CO1G5ovTuOY=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1750333771123763.0534931058979; Thu, 19 Jun 2025 04:49:31 -0700 (PDT)
Date: Thu, 19 Jun 2025 19:49:31 +0800
From: Li Chen <me@linux.beauty>
To: "Catalin Marinas" <catalin.marinas@arm.com>,
	"Will Deacon" <will@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	"Len Brown" <lenb@kernel.org>, "Hanjun Guo" <guohanjun@huawei.com>,
	"Liu Wei" <liuwei09@cestc.cn>, "Ryan Roberts" <ryan.roberts@arm.com>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	"Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
	"Sudeep Holla" <sudeep.holla@arm.com>,
	"linux-arm-kernel" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"linux-acpi" <linux-acpi@vger.kernel.org>
Message-ID: <1978805cd53.d7656d5d435218.1873813773955537604@linux.beauty>
In-Reply-To: <20250606072802.191580-1-me@linux.beauty>
References: <20250606072802.191580-1-me@linux.beauty>
Subject: Re: [PATCH 0/2] ACPI: Improve SPCR handling and messaging on
 SPCR-less systems
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Gentle ping incase of forgotten.

 ---- On Fri, 06 Jun 2025 15:27:43 +0800  Li Chen <me@linux.beauty> wrote --- 
 > From: Li Chen <chenl311@chinatelecom.cn>
 > 
 > This small series improves the kernel behavior and output when the ACPI SPCR
 > table is not present or not supported.
 > 
 > Currently, even on systems that completely lack an SPCR table, the kernel prints:
 > "Use ACPI SPCR as default console: Yes"
 > 
 > Or if with acpi=nospcr:
 > "Use ACPI SPCR as default console: No"
 > 
 > This may mislead users into thinking an SPCR table exists
 > when in fact there is no such table at all. This series addresses this in two steps:
 > 
 > Patch 1 ensures that acpi_parse_spcr() returns -ENODEV if CONFIG_ACPI_SPCR_TABLE is disabled.
 > 
 > Patch 2 updates arm64 acpi_boot_table_init() to only print the SPCR console message
 > if acpi_parse_spcr() succeeds.
 > 
 > This results in cleaner and more accurate boot logs on ARM64.
 > 
 > Tested on both SPCR-enabled and SPCR-less qemu-system arm64 virt platform. [1]
 > 
 > [1]: https://patchew.org/QEMU/20250528105404.457729-1-me@linux.beauty/
 > 
 > Li Chen (2):
 >   ACPI: Return -ENODEV from acpi_parse_spcr() when SPCR support is
 >     disabled
 >   ACPI: Suppress misleading SPCR console message when SPCR table is
 >     absent
 > 
 >  arch/arm64/kernel/acpi.c | 9 ++++++---
 >  include/linux/acpi.h     | 2 +-
 >  2 files changed, 7 insertions(+), 4 deletions(-)
 > 
 > -- 
 > 2.49.0
 > 
 > 

Regards,
Li

