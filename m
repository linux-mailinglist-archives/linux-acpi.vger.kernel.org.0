Return-Path: <linux-acpi+bounces-12061-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6BDA5B779
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 04:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 063F816EC3F
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 03:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD7D1DFE22;
	Tue, 11 Mar 2025 03:48:57 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997AA259C;
	Tue, 11 Mar 2025 03:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741664937; cv=none; b=jy/jxsRHdsQD5QzkMnyvGZxuMC/O28D3A654JniVQ1TnaoZF2airB3HDRQT3X3bATa9kjTxFP/Xufq4c81j8YuSqHY644b7wmI65YrFoeYeYxufDDVoYiNjRNxZbIAVyPDHsTxHSapGa9lB1Rr1sv+WLsiGeBVIt93goREbBkis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741664937; c=relaxed/simple;
	bh=5vukZrG8OAo4CAMfv6ndpFPJrij07acQ5HVzF3j8ASo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TdtgUnP0A+RKx9bCm6zTiRxGZcQghQ0BM26wxVYbELl82kCfHV7+ZxII93O5ryyu5AXiYr0x1ckl7bkyfxkKZ5d+Mqk2NfzDSwtx6uNYFOdfBfsxzogezlYjxcOBtUGmoka8SDv+Xig84vOEd8hhnEb8i0afdIKP4aj/BtfBA60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwC3PC2Wss9n7JOOCA--.1414S2;
	Tue, 11 Mar 2025 11:48:38 +0800 (CST)
Received: from localhost (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwBnaoaSss9nXsdCAA--.19578S2;
	Tue, 11 Mar 2025 11:48:35 +0800 (CST)
Date: Tue, 11 Mar 2025 11:48:18 +0800
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: Alison Schofield <alison.schofield@intel.com>
Cc: rafael@kernel.org, lenb@kernel.org, Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com, rrichter@amd.com, bfaccini@nvidia.com,
	haibo1.xu@intel.com, dave.jiang@intel.com, rppt@kernel.org,
	gourry@gourry.net, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	chenbaozi@phytium.com.cn
Subject: Re: [PATCH] ACPI: NUMA: debug invalid unused PXM value for CFMWs
Message-ID: <Z8+yggwrcYZXmnd0@phytium.com.cn>
References: <20250310093910.1752126-1-wangyuquan1236@phytium.com.cn>
 <Z88rzKHrqlCXQOTb@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z88rzKHrqlCXQOTb@aschofie-mobl2.lan>
X-CM-TRANSID:AQAAfwBnaoaSss9nXsdCAA--.19578S2
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAFAWfN84QGSAAjs1
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7Kry7GryrJF47Jw4kXrWUurg_yoW8XFWrpF
	W8Ka4Ykrs2y3yxC3Wvvw17XFyrKw10kFW5KasrWr9xWanI9rn7ZFZ7KayY9FyDXw4UCr1I
	yanYqF15WF18ZFDanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

On Mon, Mar 10, 2025 at 11:13:32AM -0700, Alison Schofield wrote:
> On Mon, Mar 10, 2025 at 05:39:10PM +0800, Yuquan Wang wrote:
> > The absence of SRAT would cause the fake_pxm to be -1 and increment
> > to 0, then send to acpi_parse_cfmws(). If there exists CXL memory
> > ranges that are defined in the CFMWS and not already defined in the
> > SRAT, the new node (node0) for the CXL memory would be invalid, as
> > node0 is already in "used".
> 
> 
> If no SRAT or bad SRAT, then all memory is at node:0, and first fake
> node for CFMWs should start at 1. Right?
Yes.
> 
> If so, might it be safest to always start the the CFMWS fake nodes at
> at a minimum of node[1]. Maybe srat_disabled() can be used to decide.
> 
> > 
> > Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> > ---
> >  drivers/acpi/numa/srat.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> > index 00ac0d7bb8c9..eb8628e217fa 100644
> > --- a/drivers/acpi/numa/srat.c
> > +++ b/drivers/acpi/numa/srat.c
> > @@ -646,6 +646,9 @@ int __init acpi_numa_init(void)
> >  		if (node_to_pxm_map[i] > fake_pxm)
> >  			fake_pxm = node_to_pxm_map[i];
> >  	}
> > +	if (fake_pxm == PXM_INVAL)
> > +		pr_warn("Failed to find the next unused PXM value for CFMWs\n");
> > +
> 
> How come it is sufficient to just warn?
> As per my comment above, can we adjust?
>
Sure. Thanks for your suggestion.
> 
> 
> >  	last_real_pxm = fake_pxm;
> >  	fake_pxm++;
> >  	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, acpi_parse_cfmws,
> > -- 
> > 2.34.1
> > 


