Return-Path: <linux-acpi+bounces-13766-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 499BAABA8DC
	for <lists+linux-acpi@lfdr.de>; Sat, 17 May 2025 10:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A3C41BA272C
	for <lists+linux-acpi@lfdr.de>; Sat, 17 May 2025 08:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B25B1C84A1;
	Sat, 17 May 2025 08:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hm1Zle8y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382DB4B1E5E;
	Sat, 17 May 2025 08:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747470391; cv=none; b=LOGf5uapQlrHnhtz0kzNHfbGsCcgfHlvfVuepudxCmDPD/7wt4ColH/AQe51eUu/vdNdY2no9aJxA4o7gvDP2Jxijr++KaNfp7hENwDS3Wt5nmhZDIxCmj4yHQVCaCllUg94yvhPdKNpwod/Oa7xX/Ujn1mSB7/yBAoAbsn3AkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747470391; c=relaxed/simple;
	bh=PQOLWqrKSyrqpWmnE9BonZOml3AtvPoByeRJERePNws=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jhvNywdBzh2qnK5AQG24Q9myztzRZe5AEX7Vyo4NOnFi9uYuUUgcy121bGQduJIbWdQ6LIgx+bvhPyQLO1/3Wm4v7X5othsaYhjmjOtAFQ5YRWeT9U3vGeCH+X0Br/QMe0O8HkhfwZclezRytoi6dTOWH5Z9MQDXSZVnP5kT/N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hm1Zle8y; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1747470383; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=l+Er2Ula6bNRtJ61wL0riauQQAVXrck13+EaUfPTQ1I=;
	b=hm1Zle8yyUEULoniyEkVsWT9wIEjXtRJnmjqqt5z0Qk1K4eyNLT8AgNo+N+OiHWz7aSm2RMuoEdMr68Qr4uwPiVly3sXERS0SOS8Nly1rQMwAOL++6wBtR2U7qtknPP+VJGXtgMnsaCtMgGmqxPjoBKml2cWgsd6B9qs6T8oWNg=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WazQ0TG_1747470380 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 17 May 2025 16:26:21 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Honggyu Kim <honggyu.kim@sk.com>,  kernel_team@skhynix.com,  Andrew
 Morton <akpm@linux-foundation.org>,  gourry@gourry.net,
  yunjeong.mun@sk.com,  gregkh@linuxfoundation.org,  rafael@kernel.org,
  lenb@kernel.org,  dan.j.williams@intel.com,  Jonathan.Cameron@huawei.com,
  dave.jiang@intel.com,  horen.chuang@linux.dev,  hannes@cmpxchg.org,
  osalvador@suse.de,  linux-kernel@vger.kernel.org,
  linux-acpi@vger.kernel.org,  linux-mm@kvack.org,  kernel-team@meta.com
Subject: Re: [PATCH v8] mm/mempolicy: Weighted Interleave Auto-tuning
In-Reply-To: <20250516144346.8545-1-joshua.hahnjy@gmail.com> (Joshua Hahn's
	message of "Fri, 16 May 2025 07:43:45 -0700")
References: <20250516144346.8545-1-joshua.hahnjy@gmail.com>
Date: Sat, 17 May 2025 16:26:09 +0800
Message-ID: <874ixjod7i.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Joshua Hahn <joshua.hahnjy@gmail.com> writes:

> On Fri, 16 May 2025 13:37:39 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
>
> Hi Andrew,
>
> Would it be too late at this point to add Honggyu's Reviewed-by and
> Tested-by tags? He has helped test and review this series from the start,
> but I must have missed adding his tags after rebasing from v7.
>
> Sorry again for the noise, and thank you for your understanding! I'm not
> sure what the procedure looks like for commit messages... but here is
> a fixlet if that makes sense with you:
>
>  Suggested-by: Yunjeong Mun <yunjeong.mun@sk.com>
>  Suggested-by: Oscar Salvador <osalvador@suse.de>
>  Suggested-by: Ying Huang <ying.huang@linux.alibaba.com>
>  Suggested-by: Harry Yoo <harry.yoo@oracle.com>
> +Tested-by: Honggyu Kim <honggyu.kim@sk.com>
> +Reviewed-by: Honggyu Kim <honggyu.kim@sk.com>
>  Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
>  Co-developed-by: Gregory Price <gourry@gourry.net>
>  Signed-off-by: Gregory Price <gourry@gourry.net>
>  Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
>
> And I will sign this off so that you do not have to forge my signature : -)
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
>
> Thank you again for your help, I hope you have a great day!

Feel free to add my

Reviewed-by: Huang Ying <ying.huang@linux.alibaba.com>

too :-)

[snip]

---
Best Regards,
Huang, Ying

