Return-Path: <linux-acpi+bounces-16184-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4596B3BD30
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Aug 2025 16:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FF1DA2525B
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Aug 2025 14:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D8C31E0E2;
	Fri, 29 Aug 2025 14:11:29 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9868D313529;
	Fri, 29 Aug 2025 14:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756476689; cv=none; b=THXekhpDm0GB6j0qmyEjjI8RjK92dj84C3QLk3alLVpKmyD/n/qDeFHIOZWrMGRx9rhboYXCLaQ5gpE4fj1NizNSpN2bVZ8Tr39MNv7gplUDYjcQUNJG4rPfsBKSQBU49IrIETTcpDvZ4t42MuXdi+ZeGUs/Y/P3peLdwYOIKHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756476689; c=relaxed/simple;
	bh=7OmDSWROZvN+5Tqqwo3pnakSpsUVMb+bERZomoO6OjM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=de00FObtyYKCML7h/rqE8Kq8kx1wLCGdWZywHhiueVbMSTA7ipOzq69UuVkBjER6onEyUqOLTYeJ01NjHxFnBn/3Vq+n2845+yH2iYV70GdqRQlUPXQ5Ml0hIiVhE/sinyIps6aD7Hreaz+dJyso0brYSDejnAQd0ePj8kFFihI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cD0Xv56JJz6HJvn;
	Fri, 29 Aug 2025 22:10:39 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 5C0E814033F;
	Fri, 29 Aug 2025 22:11:18 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 29 Aug
 2025 16:11:17 +0200
Date: Fri, 29 Aug 2025 15:11:16 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: David Hildenbrand <david@redhat.com>
CC: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <rafael@kernel.org>, <dakr@kernel.org>,
	<dave@stgolabs.net>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <marc.herbert@linux.intel.com>,
	<akpm@linux-foundation.org>
Subject: Re: [PATCH v2 1/4] mm/memory_hotplug: Update comment for hotplug
 memory callback priorities
Message-ID: <20250829151116.00001144@huawei.com>
In-Reply-To: <14a0e842-8616-4bd3-8e11-7d8521c81cb0@redhat.com>
References: <20250820194704.4130565-1-dave.jiang@intel.com>
	<20250820194704.4130565-2-dave.jiang@intel.com>
	<14a0e842-8616-4bd3-8e11-7d8521c81cb0@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 21 Aug 2025 23:17:38 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 20.08.25 21:47, Dave Jiang wrote:
> > Add clarification to comment for memory hotplug callback ordering as the
> > current comment does not provide clear language on which callback happens
> > first.
> > 
> > Acked-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > ---
> > v2:
> > - Clearer comment suggestion from DavidH.
> > ---
> >   include/linux/memory.h | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/memory.h b/include/linux/memory.h
> > index 40eb70ccb09d..de5c0d8e8925 100644
> > --- a/include/linux/memory.h
> > +++ b/include/linux/memory.h
> > @@ -115,8 +115,8 @@ struct notifier_block;
> >   struct mem_section;
> >   
> >   /*
> > - * Priorities for the hotplug memory callback routines (stored in decreasing
> > - * order in the callback chain)
> > + * Priorities for the hotplug memory callback routines. Invoked from
> > + * high to low. Higher priorities corresponds to higher numbers.  
> 
> Minor nit: s/corresponds/correspond/

With that tidied up
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> 


