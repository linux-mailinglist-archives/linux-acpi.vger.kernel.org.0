Return-Path: <linux-acpi+bounces-13678-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FBCAB2D3E
	for <lists+linux-acpi@lfdr.de>; Mon, 12 May 2025 03:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C41F6165DE2
	for <lists+linux-acpi@lfdr.de>; Mon, 12 May 2025 01:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB991E51F5;
	Mon, 12 May 2025 01:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="X1DY0pIf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149611AA791;
	Mon, 12 May 2025 01:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747013728; cv=none; b=LvrXsPbyI75u6+Hwa954I5Ql/uL1mhL8t/KpNePb0J9n36snpsPrUNRi9V0EOyza2LkVKOy9/Vj14M2/3dyevYcCkAAk1TnjlcWwlssXCSfmEvPX5mnFSbwOZ6yrZKNPnASGlBRob4I2PA3lg2ysYGIzAkjFveGMLbEx7jwcyE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747013728; c=relaxed/simple;
	bh=G+J25bml5bYBByqxL+nrYMLzk29yS76vcQmZP3bJzsU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YzSKNT85TeEtESkSwb211C+unB0QKw1OIrSinSoeituJ/X2dDSOd51d+Eqnz8EgzHxzyEiSrUDsJfj5WGITbCyi/2ki7NBQIi+JcaVCIwyK1ahXAVKGVUiekNKR7QjBn6tchGnRzT8yO3PjjKWbNzwD/dXMgUoKnoyJVMoGNTt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=X1DY0pIf; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1747013718; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=EuVnERNVneAr3tpEi62beA//L5n3y/h3iWpY0SrJdDg=;
	b=X1DY0pIf9mhd3fM5mSZIO5rvrzZcMvQJMrBFqUQ/kK2/xbAVj/cOZaQ5Z6YYTYFUuRRDglnV5ihGqCEEblSmgWsLa09FNiiJNht3FfWDUPcmjSvy3ReL0B46yBWXI+EA9XodOFq2yxzsGobmvNZaT+XaTkWU/tRKRDYs6O5Qs5I=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WaCLFf4_1747013715 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 12 May 2025 09:35:16 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  gourry@gourry.net,
  honggyu.kim@sk.com,  yunjeong.mun@sk.com,  gregkh@linuxfoundation.org,
  rafael@kernel.org,  lenb@kernel.org,  dan.j.williams@intel.com,
  Jonathan.Cameron@huawei.com,  dave.jiang@intel.com,
  horen.chuang@linux.dev,  hannes@cmpxchg.org,  osalvador@suse.de,
  linux-kernel@vger.kernel.org,  linux-acpi@vger.kernel.org,
  linux-mm@kvack.org,  kernel-team@meta.com
Subject: Re: [PATCH v8] mm/mempolicy: Weighted Interleave Auto-tuning
In-Reply-To: <20250511025840.2410154-1-joshua.hahnjy@gmail.com> (Joshua Hahn's
	message of "Sat, 10 May 2025 19:58:39 -0700")
References: <20250511025840.2410154-1-joshua.hahnjy@gmail.com>
Date: Mon, 12 May 2025 09:35:16 +0800
Message-ID: <87zffizk4r.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Joshua,

Joshua Hahn <joshua.hahnjy@gmail.com> writes:

[snip]

> @@ -3707,8 +3720,12 @@ static void wi_state_free(void)
>  	kfree(&wi_group->wi_kobj);
>  }
>
> +static struct kobj_attribute wi_auto_attr =
> +	__ATTR(auto, 0664, weighted_interleave_auto_show,
> +			   weighted_interleave_auto_store);
> +
>  static void wi_cleanup(void) {
> -	sysfs_remove_file(&wi_group->wi_kobj, &wi_group->auto_kobj_attr.attr);
> +	sysfs_remove_file(&wi_group->wi_kobj, &wi_auto_attr.attr);

If we use wi_auto_attr directly here, we can remove auto_kobj_attr field
from struct sysfs_wi_group?

>  	sysfs_wi_node_delete_all();
>  	wi_state_free();
>  }

[snip]

---
Best Regards,
Huang, Ying

