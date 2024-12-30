Return-Path: <linux-acpi+bounces-10322-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 280929FE2B1
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Dec 2024 06:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15EB01881E54
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Dec 2024 05:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E5715FD01;
	Mon, 30 Dec 2024 05:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ifopUeQ6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC399D530;
	Mon, 30 Dec 2024 05:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735538096; cv=none; b=kkIgLPiCmkk7LEjBdYARmRqrxWvQ5QKInvYQG9yvS4DazrTJgLTO1fyrE03qn9ZzUkAjBYNRBhWKE4alfcl9iQtAsvYayvVeOEJllUWsvOHpumpcKlB6seDZWUf3JCif/XmMQj7aOUyFC8jZ8k0+nktsuJ7luetkRqUmPsm9FM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735538096; c=relaxed/simple;
	bh=TfUa5Uzza4nQwN32obVAylOoo5oLMRgsE+SyZoOJSWQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NQ8OPCRn3B3H54vuNBdZqDr2xZkios+Rx/1jisH4JCIQarXoK5XTd+76rYi5Ikjb9CM5vs3dJmnb2BNTfU7POP14uzS/cErjTAE4Jbs1wRpN3wToNlA1466dihoQvbsa3s1HC4C0D4NPcAM0g0bMFsIhCfkzkm0vu0kX1E+m5Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ifopUeQ6; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1735538090; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=dpC9yzgaxD+PWbYZLBhzYExpItW6diCLdDdM3iPkj3k=;
	b=ifopUeQ6yQMSwGEzAXNMZWjSeCrznOU0MzXbO0/PnL4LL75vxvEmJCj8oHGCoLdMRLd4iS6/By5q+v56JVVnl4UK5BcDmOInDONzpQHfL5xaH85JHj07eZOisROgiQN4BMlmGh7Kg2ZEkksNtNKsxspAYIUonCibBeZFex88VmI=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WMSNgBk_1735538077 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 30 Dec 2024 13:54:49 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Feng Tang <feng.tang@linux.alibaba.com>,  rafael@kernel.org,  Len Brown
 <lenb@kernel.org>,  James Morse <james.morse@arm.com>,  Tony Luck
 <tony.luck@intel.com>,  linux-acpi@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Ira Weiny <ira.weiny@intel.com>,  Dave
 Jiang <dave.jiang@intel.com>,  Dan Williams <dan.j.williams@intel.com>,
  Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] acpi/ghes: Make ghes_panic_timeout adjustable as a
 parameter
In-Reply-To: <1EA3C309-6508-489B-9F13-7659E8388A17@alien8.de> (Borislav
	Petkov's message of "Fri, 27 Dec 2024 11:09:40 +0100")
References: <20241227095422.44147-1-feng.tang@linux.alibaba.com>
	<1EA3C309-6508-489B-9F13-7659E8388A17@alien8.de>
Date: Mon, 30 Dec 2024 13:54:36 +0800
Message-ID: <87bjwtlnqb.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Boris,

Borislav Petkov <bp@alien8.de> writes:

> On December 27, 2024 10:54:22 AM GMT+01:00, Feng Tang <feng.tang@linux.alibaba.com> wrote:
>>There is a problem report that when debugging a hard-to-reproduce panic
>>issue, user wanted the kernel to not reboot by adding "panic=0" in
>>kernel cmdline, so that the panic context could be kept, say the panic
>>was caught randomly in the mid-night, and user hoped to check it in
>>the morning. GHES panic handler may overwrite that user setting and
>>force to reboot after 'ghes_panic_timeout'(30) seconds.
>
> Why doesn't the ghes panic handler honor a panic=0 setting?

It appears that I introduced the ghes_panic_timeout originally.

panic() is used for software errors, while ghes is used for hardware
errors.  They may have different requirements.  For example, it may be
OK to wait forever for a software error, but it may be better to reboot
the system to contain the influence of the hardware error for some
hardware errors.  So, we introduced another knob for that.

---
Best Regards,
Huang, Ying

