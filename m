Return-Path: <linux-acpi+bounces-10326-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 140589FE586
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Dec 2024 12:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F9C03A2249
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Dec 2024 11:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8B81A0739;
	Mon, 30 Dec 2024 11:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iysF8UJT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E8D16DC3C;
	Mon, 30 Dec 2024 11:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735556715; cv=none; b=g9f43PqgaRAay9sZFX5CkG91t+MXHiKiJeAhdUwv9qwurRhG9Gcp23h75ORp/yqwfcmOiLXwhaMA4DaDbf8udiKAeRwKfRy45L7v/uZgswV3AEW2V2TfAWWWu3gha8AJF6EAc3xrxKgDGs6EhwGA7LP5rlAIOk6011GcvZAcFyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735556715; c=relaxed/simple;
	bh=4xd58yTCpQIf47blFqE57IVz0+bBOZWNPI6OBlamdug=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WWXEh0612/MtRja31HRWY4OeONv4MZ5WC2I7ULe+3rRvnzjL9OEw+Aj0WFRl4Wk7x/tN7/0aOhVy3lIBBkkAYUjOLDZo4dxTYpBFr3w9rDeK6sJfTHTKsiCun7n8Jz7D1M75pyebw+0MCU/c0FOdTow3wRNaowBhGLTbUz8QUNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iysF8UJT; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1735556702; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=wuuHYz1Kl0fklpdkVnLE7r+3e0NQZ3botUrMiUaWhR4=;
	b=iysF8UJTPyvoEYYX52xRzGX+zRsmmgWE8+12C/VpdkSnGEUY8zKmiMzFejGk3ClGp+z66qbVNzvuTrXcVlFJTDklDbi6HiXYaVQWEjZxjFl5G3jQn5vfoLFoH6mD4NgDAlb/07Tzs2KrJAVuGzKmztTgfHBT4+2I2bQW+GFdCWE=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WMX1Nq0_1735556701 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 30 Dec 2024 19:05:02 +0800
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
In-Reply-To: <20241230101658.GAZ3JzGhRjn7UtoJPt@fat_crate.local> (Borislav
	Petkov's message of "Mon, 30 Dec 2024 11:16:58 +0100")
References: <20241227095422.44147-1-feng.tang@linux.alibaba.com>
	<1EA3C309-6508-489B-9F13-7659E8388A17@alien8.de>
	<87bjwtlnqb.fsf@DESKTOP-5N7EMDA>
	<20241230101658.GAZ3JzGhRjn7UtoJPt@fat_crate.local>
Date: Mon, 30 Dec 2024 19:04:59 +0800
Message-ID: <87wmfhjusk.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Borislav Petkov <bp@alien8.de> writes:

> On Mon, Dec 30, 2024 at 01:54:36PM +0800, Huang, Ying wrote:
>> For example, it may be OK to wait forever for a software error, but it may
>> be better to reboot the system to contain the influence of the hardware
>> error for some hardware errors.
>
> A default panic timeout of 30 seconds for hw errors?! You do realize that 30
> seconds for a machine is an eternity and by that time your hardware error has
> long propagated and corrupted results, right?
>
> So your timeout is not even trying to do what you want.
>
> So unless I'm missing something, this ghes timeout needs to go - if you want
> to "contain the influence" you need to panic *immediately*! And not even that
> would help in some cases - hw has its own protections there so the OS
> panicking is meh. At least on x86, that is.

OK.  30 seconds isn't good enough for hw errors.

Another possible benefit of ghes_panic_timeout is,

rebooting instead of waiting forever can help us to log/report the
hardware errors earlier.

For example, the hardware errors could be logged in some simple
non-volatile storage (such as EFI variables) during panic or kdump, etc.
Then, after reboot, the new kernel could report the hardware errors in
some way.

>> So, we introduced another knob for that.
>
> No, that another knob is piling more of the silly ontop.

---
Best Regards,
Huang, Ying

