Return-Path: <linux-acpi+bounces-13624-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED286AAF0BA
	for <lists+linux-acpi@lfdr.de>; Thu,  8 May 2025 03:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C42E1C00567
	for <lists+linux-acpi@lfdr.de>; Thu,  8 May 2025 01:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282EE13B5B3;
	Thu,  8 May 2025 01:47:38 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA13286340;
	Thu,  8 May 2025 01:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746668858; cv=none; b=rdqkZw0XonW+9NinFRVT+hsaqFcjRvEU5Gv2E8uI4G+KxWeS9wciSZ6BQO4UIkFIDLqAMBMjURZCOOhx8GQjHuosZ0JPSA9/DJZAWdNoojjZEbxzvq1Pj/aKSMVnkGWN/aljtKkFHGPJLjkxU1V/cGltKHQaC2EI5LZzdpY499k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746668858; c=relaxed/simple;
	bh=nASkXVfIwNhSjLLO4YJTAS9qEBKUYYXbewIKMYH9UfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XIEPxppyyn+sCP7JYXQNHpFiR4TUZsgh+FeLDIrC/56XteXMOfLw1awmIMpSzL+VPi2NL3lNcnKkOfBdMfn3aEbN2BR3jdZvcA5xKqvsTjcqQZqbKC3zpetWRNrzST7OFNOxSeGTj10jANVubz5eAJv2XKX0fBv4zyyY409Hi0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwCXnXkkDRxod8cqAw--.21321S2;
	Thu, 08 May 2025 09:47:16 +0800 (CST)
Received: from localhost (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwAXqyQZDRxoozsZAA--.3231S2;
	Thu, 08 May 2025 09:47:06 +0800 (CST)
Date: Thu, 8 May 2025 09:47:04 +0800
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: dan.j.williams@intel.com, rppt@kernel.org, rafael@kernel.org,
	lenb@kernel.org, akpm@linux-foundation.org,
	alison.schofield@intel.com, rrichter@amd.com, bfaccini@nvidia.com,
	haibo1.xu@intel.com, david@redhat.com, chenhuacai@kernel.org,
	linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	loongarch@lists.linux.dev
Subject: Re: [PATCH v2] mm: numa_memblks: introduce numa_add_reserved_memblk
Message-ID: <aBwNGG2hLMZBO0mh@phytium.com.cn>
References: <20250506062245.3816791-1-wangyuquan1236@phytium.com.cn>
 <20250507172436.00003888@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507172436.00003888@huawei.com>
X-CM-TRANSID:AQAAfwAXqyQZDRxoozsZAA--.3231S2
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQADAWgaZs4InAAhss
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxGF1kXr15Wr17ur4DCr15Arb_yoWrAFWDpa
	y8G3Z8WF4xGr1xGw1I9r1jy3WS93WrKr1DJF9Fgr13ZF1rWry2qr48tFsxZF1DArW7ur1F
	gr4vyw15uw1rZFJanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

On Wed, May 07, 2025 at 05:24:36PM +0100, Jonathan Cameron wrote:
> On Tue, 6 May 2025 14:22:45 +0800
> Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:
> 
> > acpi_parse_cfmws() currently adds empty CFMWS ranges to numa_meminfo
> > with the expectation that numa_cleanup_meminfo moves them to
> > numa_reserved_meminfo. There is no need for that indirection when it is
> > known in advance that these unpopulated ranges are meant for
> > numa_reserved_meminfo in support of future hotplug / CXL provisioning.
> > 
> > Introduce and use numa_add_reserved_memblk() to add the empty CFMWS
> > ranges directly.
> > 
> > Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> This is v2 take 2.  There were tags on the previous version (pre longarch
> change).
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> (Also Dan Williams).
> 
> Easiest option when this happens is spin a v3 with a change log to
> say the loongarch issue is resolved and you picked up tags.
>
Hi Jonathan,

Thanks for your tips. Would this v2 version trigger the kernel test
robot? It seems like only a new version of patch would trigger that.
I would publish v3 of this patch as soon as possible. 

Yuquan
> 
> > ---
> > 
> > Changes in v2 (Thanks to Dan & Alison):
> > - Use numa_add_reserved_memblk() to replace numa_add_memblk() in acpi_parse_cfmws()
> > - Add comments to describe the usage of numa_add_reserved_memblk()
> > - Updating the commit message to clarify the purpose of the patch
> > 
> > By the way, "LoongArch: Introduce the numa_memblks conversion" is in linux-next.
> > 
> >  drivers/acpi/numa/srat.c     |  2 +-
> >  include/linux/numa_memblks.h |  1 +
> >  mm/numa_memblks.c            | 22 ++++++++++++++++++++++
> >  3 files changed, 24 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> > index 0a725e46d017..751774f0b4e5 100644
> > --- a/drivers/acpi/numa/srat.c
> > +++ b/drivers/acpi/numa/srat.c
> > @@ -453,7 +453,7 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
> >  		return -EINVAL;
> >  	}
> >  
> > -	if (numa_add_memblk(node, start, end) < 0) {
> > +	if (numa_add_reserved_memblk(node, start, end) < 0) {
> >  		/* CXL driver must handle the NUMA_NO_NODE case */
> >  		pr_warn("ACPI NUMA: Failed to add memblk for CFMWS node %d [mem %#llx-%#llx]\n",
> >  			node, start, end);
> > diff --git a/include/linux/numa_memblks.h b/include/linux/numa_memblks.h
> > index dd85613cdd86..991076cba7c5 100644
> > --- a/include/linux/numa_memblks.h
> > +++ b/include/linux/numa_memblks.h
> > @@ -22,6 +22,7 @@ struct numa_meminfo {
> >  };
> >  
> >  int __init numa_add_memblk(int nodeid, u64 start, u64 end);
> > +int __init numa_add_reserved_memblk(int nid, u64 start, u64 end);
> >  void __init numa_remove_memblk_from(int idx, struct numa_meminfo *mi);
> >  
> >  int __init numa_cleanup_meminfo(struct numa_meminfo *mi);
> > diff --git a/mm/numa_memblks.c b/mm/numa_memblks.c
> > index ff4054f4334d..541a99c4071a 100644
> > --- a/mm/numa_memblks.c
> > +++ b/mm/numa_memblks.c
> > @@ -200,6 +200,28 @@ int __init numa_add_memblk(int nid, u64 start, u64 end)
> >  	return numa_add_memblk_to(nid, start, end, &numa_meminfo);
> >  }
> >  
> > +/**
> > + * numa_add_reserved_memblk - Add one numa_memblk to numa_reserved_meminfo
> > + * @nid: NUMA node ID of the new memblk
> > + * @start: Start address of the new memblk
> > + * @end: End address of the new memblk
> > + *
> > + * Add a new memblk to the numa_reserved_meminfo.
> > + *
> > + * Usage Case: numa_cleanup_meminfo() reconciles all numa_memblk instances
> > + * against memblock_type information and moves any that intersect reserved
> > + * ranges to numa_reserved_meminfo. However, when that information is known
> > + * ahead of time, we use numa_add_reserved_memblk() to add the numa_memblk
> > + * to numa_reserved_meminfo directly.
> > + *
> > + * RETURNS:
> > + * 0 on success, -errno on failure.
> > + */
> > +int __init numa_add_reserved_memblk(int nid, u64 start, u64 end)
> > +{
> > +	return numa_add_memblk_to(nid, start, end, &numa_reserved_meminfo);
> > +}
> > +
> >  /**
> >   * numa_cleanup_meminfo - Cleanup a numa_meminfo
> >   * @mi: numa_meminfo to clean up
> 


